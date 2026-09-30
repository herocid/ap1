import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// 2x2-Matrix mit L-förmigen Achsen: senkrecht nach oben steigend,
/// waagerecht nach rechts steigend.
DiagramLayout layoutQuadranten(
  QuadrantenDiagramm d,
  DiagramStyle s,
  double w,
) => _QuadrantenLayout(d, s, w);

class _Cell {
  _Cell(this.title, this.text);
  final TextPainter title;
  final TextPainter? text;
  Rect rect = Rect.zero;
}

class _QuadrantenLayout extends DiagramLayout {
  _QuadrantenLayout(this.d, this.s, double maxW) {
    final axisStyle = s.label(
      size: 11.5,
      weight: FontWeight.w600,
      color: s.muted,
    );
    axisW = s.sc(11);
    const gap = 3.0;
    final pad = s.sc(8);
    final qs = [d.obenLinks, d.obenRechts, d.untenLinks, d.untenRechts];

    // Lange Wörter („Zufriedenstellen“) notfalls etwas kleiner setzen;
    // erst wenn auch das nicht reicht, wird die Matrix breiter.
    var cellW = (maxW - axisW - gap) / 2;
    final nominal = cellW - 2 * pad;
    // Eine Größe für alle vier Felder, damit die Matrix ruhig wirkt.
    TextStyle smallest(List<TextStyle> l) =>
        l.reduce((a, b) => (a.fontSize ?? 0) <= (b.fontSize ?? 0) ? a : b);
    final titleStyle = smallest([
      for (final q in qs)
        s.fit(q.titel, s.title(size: 12, color: s.accent), nominal),
    ]);
    final textStyle = smallest([
      for (final q in qs)
        s.fit(
          q.text ?? '',
          s.label(size: 11.5, weight: FontWeight.w400, color: s.muted),
          nominal,
        ),
    ]);
    final titleStyles = List.filled(4, titleStyle);
    final textStyles = List.filled(4, textStyle);
    for (var i = 0; i < 4; i++) {
      cellW = math.max(
        cellW,
        s.longestWord(qs[i].titel, titleStyles[i]) + 2 * pad,
      );
      if (qs[i].text != null) {
        cellW = math.max(
          cellW,
          s.longestWord(qs[i].text!, textStyles[i]) + 2 * pad,
        );
      }
    }
    width = axisW + 2 * cellW + gap;

    yLabel = s.text(d.yAchse, axisStyle, maxWidth: width - axisW);
    xLabel = s.text(
      d.xAchse,
      axisStyle,
      maxWidth: width - axisW,
      align: TextAlign.right,
    );

    for (var i = 0; i < 4; i++) {
      final q = qs[i];
      final inner = cellW - 2 * pad;
      cells.add(
        _Cell(
          s.text(q.titel, titleStyles[i], maxWidth: inner),
          q.text == null
              ? null
              : s.text(q.text!, textStyles[i], maxWidth: inner),
        ),
      );
    }
    double h(_Cell c) =>
        c.title.height + (c.text == null ? 0 : c.text!.height + 3) + 2 * pad;
    final minH = s.sc(64);
    final row0 = math.max(minH, math.max(h(cells[0]), h(cells[1])));
    final row1 = math.max(minH, math.max(h(cells[2]), h(cells[3])));

    gridTop = yLabel.height + 8;
    final x0 = axisW;
    cells[0].rect = Rect.fromLTWH(x0, gridTop, cellW, row0);
    cells[1].rect = Rect.fromLTWH(x0 + cellW + gap, gridTop, cellW, row0);
    cells[2].rect = Rect.fromLTWH(x0, gridTop + row0 + gap, cellW, row1);
    cells[3].rect = Rect.fromLTWH(
      x0 + cellW + gap,
      gridTop + row0 + gap,
      cellW,
      row1,
    );
    gridBottom = gridTop + row0 + gap + row1;
    this.pad = pad;
    size = Size(width, gridBottom + 10 + xLabel.height + 2);
  }

  final QuadrantenDiagramm d;
  final DiagramStyle s;
  late final double axisW;
  late final double width;
  late final double gridTop;
  late final double gridBottom;
  late final double pad;
  late final TextPainter yLabel;
  late final TextPainter xLabel;
  final cells = <_Cell>[];

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    for (final cell in cells) {
      final rr = RRect.fromRectAndRadius(cell.rect, const Radius.circular(8));
      c.drawRRect(rr, fillPaint(s.surfaceAlt));
      var y = cell.rect.top + pad;
      cell.title.paint(c, Offset(cell.rect.left + pad, y));
      y += cell.title.height + 3;
      cell.text?.paint(c, Offset(cell.rect.left + pad, y));
    }
    // Achsen als L mit Pfeilspitzen.
    final ax = axisW / 2;
    final origin = Offset(ax, gridBottom + 4);
    final yTip = Offset(ax, gridTop - 4);
    final xTip = Offset(width - 1, gridBottom + 4);
    final p = strokePaint(s.ink, 1.5);
    c.drawLine(origin, yTip, p);
    c.drawLine(origin, xTip, p);
    drawHead(c, origin, yTip, ArrowHead.filled, s.ink, size: 8);
    drawHead(c, origin, xTip, ArrowHead.filled, s.ink, size: 8);
    yLabel.paint(c, Offset(axisW, 0));
    xLabel.paint(c, Offset(width - xLabel.width, gridBottom + 10));
  }
}
