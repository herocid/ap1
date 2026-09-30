import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';
import 'legend.dart';

/// Gantt-Diagramm: Vorgänge links, Zeitachse oben mit durchnummerierten
/// Zeitabschnitten, kritische Vorgänge orange, Meilensteine als Raute.
DiagramLayout layoutGantt(GanttDiagramm d, DiagramStyle s, double w) =>
    _GanttLayout(d, s, w);

class _GanttLayout extends DiagramLayout {
  _GanttLayout(this.d, this.s, double maxW) {
    final labelStyle = s.label(size: 12, weight: FontWeight.w500);
    final headStyle = s.numeric(
      size: 10.5,
      weight: FontWeight.w600,
      color: s.muted,
    );
    units = math.max(
      1,
      d.vorgaenge.fold<int>(0, (m, v) => math.max(m, v.start + v.dauer)),
    );

    // Spalte der Vorgangsnamen.
    var natural = 0.0;
    var longest = 0.0;
    for (final v in d.vorgaenge) {
      natural = math.max(natural, s.text(v.label, labelStyle).width);
      longest = math.max(longest, s.longestWord(v.label, labelStyle));
    }
    einheit = s.text(
      d.einheit,
      headStyle.copyWith(fontWeight: FontWeight.w700),
    );
    // Rechts Platz für eine Meilenstein-Raute am Ende.
    final rightPad = s.sc(9);
    final sideLabelW = math
        .max(
          longest,
          math.max(einheit.width, math.min(natural + 2, maxW * 0.38)),
        )
        .ceilToDouble();
    // Schmal: Namen über den Balken statt daneben.
    stacked =
        sideLabelW > maxW * 0.42 ||
        (maxW - sideLabelW - 10 - rightPad) / units < s.sc(12);
    labelW = stacked ? maxW : sideLabelW;
    timeX = stacked ? einheit.width + 8 : labelW + 10;
    var unitW = (maxW - timeX - rightPad) / units;
    unitW = math.max(unitW, s.sc(8));
    this.unitW = unitW;
    width = math.max(maxW, timeX + unitW * units + rightPad);

    // Jede k-te Zahl, damit nichts überlappt.
    final numW = s.text('${units}0', headStyle).width;
    step = math.max(1, (numW / unitW).ceil());
    for (var i = 1; i <= units; i++) {
      nums.add(s.text('$i', headStyle));
    }
    headH = math.max(einheit.height, nums.first.height) + 8;

    barH = s.sc(13);
    var y = headH;
    for (final v in d.vorgaenge) {
      final tp = s.text(v.label, labelStyle, maxWidth: labelW);
      final rowH = stacked
          ? s.sc(6) + tp.height + 4 + barH + s.sc(8)
          : math.max(tp.height, s.sc(16)) + s.sc(12);
      labels.add(tp);
      rowTops.add(y);
      rowHs.add(rowH);
      y += rowH;
      durs.add(
        s.text(
          '${v.dauer}',
          s.numeric(
            size: 10,
            weight: FontWeight.w700,
            color: v.kritisch ? s.surface : s.onAccent,
          ),
        ),
      );
    }
    chartBottom = y;

    final hasCrit = d.vorgaenge.any((v) => v.kritisch && v.dauer > 0);
    final hasNormal = d.vorgaenge.any((v) => !v.kritisch && v.dauer > 0);
    final hasMile = d.vorgaenge.any((v) => v.dauer == 0);
    legend = Legend(s, width, [
      if (hasNormal) LegendItem.box(s.accent, 'Vorgang'),
      if (hasCrit) LegendItem.box(s.hot, 'kritischer Vorgang'),
      if (hasMile)
        LegendItem.diamond(
          d.vorgaenge.any((v) => v.dauer == 0 && !v.kritisch) ? s.ink : s.hot,
          'Meilenstein',
        ),
    ]);
    size = Size(width, chartBottom + (legend.isEmpty ? 0 : 12 + legend.height));
  }

  final GanttDiagramm d;
  final DiagramStyle s;
  late final int units;
  late final bool stacked;
  final durs = <TextPainter>[];
  late final TextPainter einheit;
  late final double labelW;
  late final double timeX;
  late final double unitW;
  late final double width;
  late final int step;
  late final double headH;
  late final double chartBottom;
  late final double barH;
  late final Legend legend;
  final nums = <TextPainter>[];
  final labels = <TextPainter>[];
  final rowTops = <double>[];
  final rowHs = <double>[];

  @override
  late final Size size;

  double _x(num t) => timeX + unitW * t;

  /// Mitte des Balkens in Zeile [i].
  double _barY(int i) => stacked
      ? rowTops[i] + s.sc(6) + labels[i].height + 4 + barH / 2
      : rowTops[i] + rowHs[i] / 2;

  @override
  void paint(Canvas c) {
    // Zeilenstreifen.
    for (var i = 0; i < rowTops.length; i++) {
      if (i.isOdd) {
        c.drawRect(
          Rect.fromLTWH(0, rowTops[i], width, rowHs[i]),
          fillPaint(s.surfaceAlt.withValues(alpha: 0.55)),
        );
      }
    }
    // Raster (gestapelt nur im Balkenbereich jeder Zeile, damit die
    // Namen darüber frei stehen).
    final gp = strokePaint(s.grid, 1);
    for (var i = 0; i <= units; i++) {
      final x = _x(i);
      if (!stacked) {
        c.drawLine(Offset(x, headH - 2), Offset(x, chartBottom), gp);
        continue;
      }
      c.drawLine(Offset(x, headH - 2), Offset(x, headH), gp);
      for (var r = 0; r < rowTops.length; r++) {
        final cy = _barY(r);
        c.drawLine(
          Offset(x, cy - barH / 2 - 3),
          Offset(x, cy + barH / 2 + 3),
          gp,
        );
      }
    }
    c.drawLine(
      Offset(0, headH),
      Offset(_x(units), headH),
      strokePaint(s.line, 1),
    );
    c.drawLine(Offset(0, chartBottom), Offset(_x(units), chartBottom), gp);
    // Kopf.
    final ex = stacked ? 0.0 : labelW - einheit.width;
    einheit.paint(c, Offset(ex, (headH - einheit.height) / 2 - 2));
    for (var i = 1; i <= units; i++) {
      if ((i - 1) % step != 0 && i != units) continue;
      if (i == units && (i - 1) % step != 0 && step > 1) {
        // Letzte Zahl nur, wenn sie nicht mit der vorigen kollidiert.
        final prev = ((i - 1) ~/ step) * step + 1;
        if ((i - prev) * unitW < nums[i - 1].width + 4) continue;
      }
      final tp = nums[i - 1];
      final cx = _x(i - 0.5);
      tp.paint(c, Offset(cx - tp.width / 2, (headH - tp.height) / 2 - 2));
    }
    // Vorgänge.
    for (var i = 0; i < d.vorgaenge.length; i++) {
      final v = d.vorgaenge[i];
      final top = rowTops[i];
      final h = rowHs[i];
      final tp = labels[i];
      tp.paint(
        c,
        Offset(0, stacked ? top + s.sc(6) : top + (h - tp.height) / 2),
      );
      final cy = _barY(i);
      final color = v.kritisch ? s.hot : s.accent;
      if (v.dauer == 0) {
        final m = s.sc(7);
        final r = Rect.fromCenter(
          center: Offset(_x(v.start), cy),
          width: 2 * m,
          height: 2 * m,
        );
        c.drawPath(diamondPath(r), fillPaint(v.kritisch ? s.hot : s.ink));
        continue;
      }
      final bar = Rect.fromLTRB(
        _x(v.start) + 1.5,
        cy - barH / 2,
        _x(v.start + v.dauer) - 1.5,
        cy + barH / 2,
      );
      c.drawRRect(
        RRect.fromRectAndRadius(bar, const Radius.circular(4)),
        fillPaint(color),
      );
      final dur = durs[i];
      if (dur.width + 6 <= bar.width && dur.height <= bar.height + 3) {
        dur.paint(c, bar.center - Offset(dur.width / 2, dur.height / 2));
      }
    }
    legend.paint(c, Offset(0, chartBottom + 12));
  }
}
