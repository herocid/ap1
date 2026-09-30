import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// Waagerechte Balken mit Wert und Einheit. Breit: Bezeichnung links,
/// Balken, Wert rechts. Schmal: Bezeichnung und Wert über dem Balken.
DiagramLayout layoutBalken(BalkenDiagramm d, DiagramStyle s, double w) =>
    _BalkenLayout(d, s, w);

class _Row {
  _Row(this.b, this.label, this.value);
  final Balken b;
  final TextPainter label;
  final TextPainter value;
  late final Offset labelPos;
  late final Offset valuePos;
  late final Rect track;
}

class _BalkenLayout extends DiagramLayout {
  _BalkenLayout(this.d, this.s, double maxW) {
    final maxWert = d.balken.fold<double>(0, (m, b) => math.max(m, b.wert));
    scaleMax = (d.max ?? 0) > 0 ? d.max! : (maxWert > 0 ? maxWert : 1);
    barH = s.sc(12);

    TextStyle labelStyle(Balken b) => s.label(
      size: 12.5,
      weight: b.hervorheben ? FontWeight.w700 : FontWeight.w500,
    );
    TextStyle valueStyle(Balken b) => s.numeric(
      size: 12.5,
      weight: FontWeight.w700,
      color: b.hervorheben ? s.hot : s.ink,
    );

    var valueW = 0.0;
    var labelNatural = 0.0;
    for (final b in d.balken) {
      valueW = math.max(
        valueW,
        s.text(mitEinheit(b.wert, d.einheit), valueStyle(b)).width,
      );
      labelNatural = math.max(
        labelNatural,
        s.text(b.label, labelStyle(b)).width,
      );
    }
    valueW = valueW.ceilToDouble() + 2;
    inline = maxW >= 400 && labelNatural <= maxW * 0.34;

    // Achsenschritte unter den Balken.
    final tickStyle = s.numeric(
      size: 10.5,
      weight: FontWeight.w500,
      color: s.muted,
    );
    final trackX0 = inline ? labelNatural + 12 : 0.0;
    final trackX1 = inline ? maxW - valueW - 10 : maxW;
    final trackW = trackX1 - trackX0;
    // Großzügiger Abstand: Die äußeren Zahlen werden an den Rand geschoben
    // und dürfen dabei nicht in ihre Nachbarn rutschen.
    final tickLabelW = s.text(formatZahl(scaleMax), tickStyle).width * 1.5 + 16;
    final step = niceStep(
      scaleMax,
      math.max(1, (trackW / tickLabelW).floor().clamp(1, 5)),
    );

    var y = 0.0;
    for (final b in d.balken) {
      final valueTp = s.text(mitEinheit(b.wert, d.einheit), valueStyle(b));
      if (inline) {
        final lbl = s.text(b.label, labelStyle(b), maxWidth: labelNatural);
        final rowH = math.max(lbl.height, math.max(barH, valueTp.height));
        final row = _Row(b, lbl, valueTp)
          ..labelPos = Offset(0, y + (rowH - lbl.height) / 2)
          ..valuePos = Offset(
            maxW - valueTp.width,
            y + (rowH - valueTp.height) / 2,
          )
          ..track = Rect.fromLTWH(trackX0, y + (rowH - barH) / 2, trackW, barH);
        rows.add(row);
        y += rowH + s.sc(12);
      } else {
        // Passt die Bezeichnung nicht neben den Wert, steht der Wert in
        // einer eigenen Zeile darunter - sonst würde die Bezeichnung in eine
        // zu schmale Spalte gequetscht und überlappt den Wert.
        final natural = s.text(b.label, labelStyle(b)).width;
        final stacked = natural + valueTp.width + 10 > maxW;
        final lbl = s.text(
          b.label,
          labelStyle(b),
          maxWidth: stacked ? maxW : maxW - valueTp.width - 10,
        );
        final double head;
        final row = _Row(b, lbl, valueTp);
        if (stacked) {
          head = lbl.height + 2 + valueTp.height;
          row
            ..labelPos = Offset(0, y)
            ..valuePos = Offset(0, y + lbl.height + 2);
        } else {
          head = math.max(lbl.height, valueTp.height);
          row
            ..labelPos = Offset(0, y + head - lbl.height)
            ..valuePos =
                Offset(maxW - valueTp.width, y + head - valueTp.height);
        }
        row.track = Rect.fromLTWH(0, y + head + 5, maxW, barH);
        rows.add(row);
        y += head + 5 + barH + s.sc(14);
      }
    }
    // Skala.
    final top = rows.isEmpty ? 0.0 : rows.first.track.top;
    axisY = y - s.sc(6);
    gridTop = top;
    for (var v = 0.0; v <= scaleMax + 1e-9; v += step) {
      final x = trackX0 + trackW * (v / scaleMax);
      ticks.add((x, s.text(formatZahl(v), tickStyle)));
    }
    this.trackX0 = trackX0;
    this.trackW = trackW;
    final tickH = ticks.isEmpty ? 0.0 : ticks.first.$2.height;
    size = Size(maxW, axisY + 4 + tickH);
  }

  final BalkenDiagramm d;
  final DiagramStyle s;
  late final double scaleMax;
  late final double barH;
  late final bool inline;
  late final double axisY;
  late final double gridTop;
  late final double trackX0;
  late final double trackW;
  final rows = <_Row>[];
  final ticks = <(double, TextPainter)>[];

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    // Hilfslinien der Skala.
    final gp = strokePaint(s.grid, 1);
    for (final (x, tp) in ticks) {
      if (inline) {
        drawDashedLine(
          c,
          Offset(x, gridTop - 4),
          Offset(x, axisY),
          gp,
          dash: 3,
          gap: 3,
        );
      } else {
        // Schmal stehen die Beschriftungen zwischen den Balken - die
        // Hilfslinien laufen nur durch die Balken.
        for (final r in rows) {
          c.drawLine(
            Offset(x, r.track.top - 3),
            Offset(x, r.track.bottom + 3),
            gp,
          );
        }
        c.drawLine(Offset(x, axisY - 3), Offset(x, axisY), gp);
      }
      var tx = x - tp.width / 2;
      tx = tx.clamp(0.0, size.width - tp.width);
      tp.paint(c, Offset(tx, axisY + 3));
    }
    for (final r in rows) {
      final radius = Radius.circular(barH / 2);
      c.drawRRect(
        RRect.fromRectAndRadius(r.track, radius),
        fillPaint(s.surfaceAlt),
      );
      final frac = (r.b.wert / scaleMax).clamp(0.0, 1.0);
      if (frac > 0) {
        final fill = Rect.fromLTWH(
          r.track.left,
          r.track.top,
          math.max(barH, r.track.width * frac),
          r.track.height,
        );
        c.drawRRect(
          RRect.fromRectAndRadius(fill, radius),
          fillPaint(r.b.hervorheben ? s.hot : s.accent),
        );
      }
      r.label.paint(c, r.labelPos);
      r.value.paint(c, r.valuePos);
    }
  }
}
