import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';
import 'legend.dart';

/// Koordinatensystem mit Geraden (Break-even, Make-or-Buy): Achsen mit
/// Pfeil, Skala, Raster, farbige Geraden mit Legende und markierte Punkte
/// mit gestrichelten Hilfslinien zu beiden Achsen.
DiagramLayout layoutGeraden(GeradenDiagramm d, DiagramStyle s, double w) =>
    _GeradenLayout(d, s, w);

class _GeradenLayout extends DiagramLayout {
  _GeradenLayout(this.d, this.s, double maxW) {
    final tickStyle = s.numeric(
      size: 10.5,
      weight: FontWeight.w500,
      color: s.muted,
    );
    final axisStyle = s.label(
      size: 11.5,
      weight: FontWeight.w600,
      color: s.muted,
    );
    xMax = d.xMax > 0 ? d.xMax : 1;
    yMax = d.yMax > 0 ? d.yMax : 1;

    yAxisLabel = s.text(d.yAchse, axisStyle, maxWidth: maxW - 8);
    xAxisLabel = s.text(
      d.xAchse,
      axisStyle,
      maxWidth: maxW * 0.9,
      align: TextAlign.right,
    );

    // Linker Rand = breiteste y-Beschriftung.
    final roughH = maxW * 0.62;
    yStep = niceStep(yMax, math.max(2, (roughH / s.sc(34)).floor()));
    for (var v = 0.0; v <= yMax + 1e-9; v += yStep) {
      yTicks.add((v, s.text(formatZahl(v), tickStyle)));
    }
    final leftM = yTicks.fold<double>(0, (m, t) => math.max(m, t.$2.width)) + 8;
    plotLeft = leftM;
    plotTop = yAxisLabel.height + 10;
    final plotW = maxW - leftM - 12;
    plotH = math.min(math.max(plotW * 0.66, s.sc(150)), s.sc(300));
    plotRight = plotLeft + plotW;
    plotBottom = plotTop + plotH;

    final xLabelW = s.text(formatZahl(xMax), tickStyle).width + s.sc(12);
    xStep = niceStep(xMax, math.max(1, math.min(6, (plotW / xLabelW).floor())));
    for (var v = 0.0; v <= xMax + 1e-9; v += xStep) {
      xTicks.add((v, s.text(formatZahl(v), tickStyle)));
    }
    final tickH = xTicks.first.$2.height;

    final colors = s.series;
    legend = Legend(s, maxW, [
      for (var i = 0; i < d.geraden.length; i++)
        LegendItem.line(colors[i % colors.length], d.geraden[i].label),
      for (final p in d.punkte) LegendItem.dot(s.ink, p.label),
    ]);

    xAxisLabelPos = Offset(
      plotRight + 8 - xAxisLabel.width,
      plotBottom + 4 + tickH + 4,
    );
    final chartBottom = xAxisLabelPos.dy + xAxisLabel.height;
    legendTop = chartBottom + 12;
    size = Size(maxW, legendTop + legend.height);

    // Punktbeschriftungen: erste Lage, die ins Diagramm passt.
    final pointStyle = s.label(size: 11, weight: FontWeight.w700, color: s.ink);
    for (final p in d.punkte) {
      final tp = s.text(p.label, pointStyle, maxWidth: plotW * 0.55);
      final c = _pt(p.x, p.y);
      final candidates = [
        for (final g in [8.0, 22.0, 40.0]) ...[
          Offset(c.dx + g, c.dy + g), // rechts unten
          Offset(c.dx - g - tp.width, c.dy - g - tp.height), // links oben
          Offset(c.dx + g, c.dy - g - tp.height), // rechts oben
          Offset(c.dx - g - tp.width, c.dy + g), // links unten
        ],
      ];
      bool inside(Rect r) =>
          r.left >= plotLeft + 2 &&
          r.right <= plotRight &&
          r.top >= plotTop &&
          r.bottom <= plotBottom - 2;
      // Schneidet eine Gerade das Rechteck?
      bool hitsLine(Rect r) {
        for (final g in d.geraden) {
          final yl = _pt(0, g.start + g.steigung * _xOf(r.left - 3)).dy;
          final yr = _pt(0, g.start + g.steigung * _xOf(r.right + 3)).dy;
          if (math.min(yl, yr) <= r.bottom + 3 &&
              math.max(yl, yr) >= r.top - 3) {
            return true;
          }
        }
        return false;
      }

      Offset? pos;
      for (final o in candidates) {
        final r = Rect.fromLTWH(o.dx, o.dy, tp.width, tp.height);
        if (inside(r) && !hitsLine(r)) {
          pos = o;
          break;
        }
      }
      pos ??= candidates.firstWhere(
        (o) => inside(Rect.fromLTWH(o.dx, o.dy, tp.width, tp.height)),
        orElse: () => candidates.first,
      );
      pos = Offset(
        pos.dx.clamp(
          plotLeft + 2,
          math.max(plotLeft + 2, plotRight - tp.width),
        ),
        pos.dy.clamp(plotTop, math.max(plotTop, plotBottom - tp.height - 2)),
      );
      pointLabels.add((tp, pos));
    }
  }

  final GeradenDiagramm d;
  final DiagramStyle s;
  late final double xMax;
  late final double yMax;
  late final double xStep;
  late final double yStep;
  late final double plotLeft;
  late final double plotTop;
  late final double plotRight;
  late final double plotBottom;
  late final double plotH;
  late final double legendTop;
  late final TextPainter yAxisLabel;
  late final TextPainter xAxisLabel;
  late final Offset xAxisLabelPos;
  late final Legend legend;
  final xTicks = <(double, TextPainter)>[];
  final yTicks = <(double, TextPainter)>[];
  final pointLabels = <(TextPainter, Offset)>[];

  @override
  late final Size size;

  double _xOf(double px) => (px - plotLeft) / (plotRight - plotLeft) * xMax;

  Offset _pt(double x, double y) => Offset(
    plotLeft + (plotRight - plotLeft) * (x / xMax),
    plotBottom - plotH * (y / yMax),
  );

  @override
  void paint(Canvas c) {
    final gp = strokePaint(s.grid, 1);
    // Raster und Skala.
    for (final (v, tp) in yTicks) {
      final y = _pt(0, v).dy;
      if (v > 0) c.drawLine(Offset(plotLeft, y), Offset(plotRight, y), gp);
      tp.paint(c, Offset(plotLeft - 6 - tp.width, y - tp.height / 2));
    }
    for (final (v, tp) in xTicks) {
      final x = _pt(v, 0).dx;
      if (v > 0) c.drawLine(Offset(x, plotTop), Offset(x, plotBottom), gp);
      c.drawLine(
        Offset(x, plotBottom),
        Offset(x, plotBottom + 3),
        strokePaint(s.ink, 1),
      );
      var tx = x - tp.width / 2;
      if (v == 0) tx = math.max(tx, plotLeft - tp.width / 2);
      tx = math.min(tx, size.width - tp.width);
      tp.paint(c, Offset(tx, plotBottom + 4));
    }

    // Geraden, auf die Zeichenfläche beschnitten.
    final plot = Rect.fromLTRB(
      plotLeft,
      plotTop - 1,
      plotRight,
      plotBottom + 1,
    );
    c.save();
    c.clipRect(plot);
    final colors = s.series;
    for (var i = 0; i < d.geraden.length; i++) {
      final g = d.geraden[i];
      final a = _pt(0, g.start);
      final b = _pt(xMax, g.start + g.steigung * xMax);
      c.drawLine(a, b, strokePaint(colors[i % colors.length], 2.4));
    }
    c.restore();

    // Achsen mit Pfeil.
    final axis = strokePaint(s.ink, 1.5);
    final o = Offset(plotLeft, plotBottom);
    final yTip = Offset(plotLeft, plotTop - 8);
    final xTip = Offset(plotRight + 10, plotBottom);
    c.drawLine(o, yTip, axis);
    c.drawLine(o, xTip, axis);
    drawHead(c, o, yTip, ArrowHead.filled, s.ink, size: 8);
    drawHead(c, o, xTip, ArrowHead.filled, s.ink, size: 8);
    yAxisLabel.paint(c, Offset(math.max(0, plotLeft - 6), 0));
    xAxisLabel.paint(c, xAxisLabelPos);

    // Markierte Punkte mit Hilfslinien.
    final help = strokePaint(s.muted, 1.2);
    for (var i = 0; i < d.punkte.length; i++) {
      final p = d.punkte[i];
      final pt = _pt(p.x, p.y);
      drawDashedLine(c, pt, Offset(pt.dx, plotBottom), help, dash: 4, gap: 3);
      drawDashedLine(c, pt, Offset(plotLeft, pt.dy), help, dash: 4, gap: 3);
      c.drawCircle(pt, s.sc(5.5), fillPaint(s.surface));
      c.drawCircle(pt, s.sc(4.5), fillPaint(s.ink));
      final (tp, pos) = pointLabels[i];
      paintLabel(
        c,
        tp,
        pos,
        s.surface.withValues(alpha: 0.9),
        padX: 3,
        padY: 1,
      );
    }

    legend.paint(c, Offset(0, legendTop));
  }
}
