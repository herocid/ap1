import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'diagram_style.dart';

enum LegendSwatch { box, line, diamond, dot }

class LegendItem {
  const LegendItem._(this.swatch, this.color, this.label);
  const LegendItem.box(Color color, String label)
    : this._(LegendSwatch.box, color, label);
  const LegendItem.line(Color color, String label)
    : this._(LegendSwatch.line, color, label);
  const LegendItem.diamond(Color color, String label)
    : this._(LegendSwatch.diamond, color, label);
  const LegendItem.dot(Color color, String label)
    : this._(LegendSwatch.dot, color, label);

  final LegendSwatch swatch;
  final Color color;
  final String label;
}

/// Legende unter einer Zeichnung, bricht wie ein Fließtext um.
class Legend {
  Legend(this.s, double maxW, this.items) {
    final style = s.label(size: 11.5, weight: FontWeight.w500, color: s.muted);
    sw = s.sc(18);
    var x = 0.0;
    var y = 0.0;
    var lineH = 0.0;
    for (final it in items) {
      final tp = s.text(it.label, style, maxWidth: math.max(40, maxW - sw - 6));
      final w = sw + 6 + tp.width;
      if (x > 0 && x + w > maxW) {
        x = 0;
        y += lineH + 4;
        lineH = 0;
      }
      _placed.add((it, tp, Offset(x, y)));
      x += w + s.sc(14);
      lineH = math.max(lineH, tp.height);
    }
    height = items.isEmpty ? 0 : y + lineH;
  }

  final DiagramStyle s;
  final List<LegendItem> items;
  late final double sw;
  late final double height;
  final _placed = <(LegendItem, TextPainter, Offset)>[];

  bool get isEmpty => items.isEmpty;

  void paint(Canvas c, Offset origin) {
    for (final (it, tp, off) in _placed) {
      final o = origin + off;
      // Symbol auf Höhe der ersten Textzeile.
      final cy = o.dy + math.min(tp.height, s.sc(15)) / 2;
      switch (it.swatch) {
        case LegendSwatch.box:
          c.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(o.dx, cy - s.sc(5), sw, s.sc(10)),
              const Radius.circular(3),
            ),
            fillPaint(it.color),
          );
        case LegendSwatch.line:
          c.drawLine(
            Offset(o.dx, cy),
            Offset(o.dx + sw, cy),
            strokePaint(it.color, 2.6),
          );
        case LegendSwatch.diamond:
          final m = s.sc(6);
          c.drawPath(
            diamondPath(
              Rect.fromCenter(
                center: Offset(o.dx + sw / 2, cy),
                width: 2 * m,
                height: 2 * m,
              ),
            ),
            fillPaint(it.color),
          );
        case LegendSwatch.dot:
          c.drawCircle(Offset(o.dx + sw / 2, cy), s.sc(5), fillPaint(it.color));
      }
      tp.paint(c, Offset(o.dx + sw + 6, o.dy));
    }
  }
}
