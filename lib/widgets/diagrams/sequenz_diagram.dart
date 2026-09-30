import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// UML-Sequenzdiagramm: Köpfe oben, gestrichelte Lebenslinien, Nachrichten
/// als Pfeile von oben nach unten; Antworten gestrichelt mit offener Spitze.
DiagramLayout layoutSequenz(SequenzDiagramm d, DiagramStyle s, double w) =>
    _SequenzLayout(d, s, w);

class _Msg {
  _Msg(this.n, this.text);
  final Nachricht n;
  final TextPainter text;
  late final Offset textPos;
  late final double y;
}

class _SequenzLayout extends DiagramLayout {
  _SequenzLayout(this.d, this.s, double maxW) {
    final n = math.max(1, d.teilnehmer.length);
    final headPad = s.sc(5);
    // Spaltenbreite: gleichmäßig, aber jedes Wort der Köpfe muss passen.
    var colW = maxW / n;
    // Alle Köpfe in derselben (notfalls leicht verkleinerten) Größe.
    final fitted = [
      for (final t in d.teilnehmer)
        s.fit(t, s.title(size: 12.5), colW - 4 - 2 * headPad),
    ];
    final head = fitted.isEmpty
        ? s.title(size: 12.5)
        : fitted.reduce(
            (a, b) => (a.fontSize ?? 0) <= (b.fontSize ?? 0) ? a : b,
          );
    final styles = List.filled(d.teilnehmer.length, head);
    for (var i = 0; i < n; i++) {
      colW = math.max(
        colW,
        s.longestWord(d.teilnehmer[i], styles[i]) + 2 * headPad + 4,
      );
    }
    width = colW * n;
    for (var i = 0; i < n; i++) {
      xs.add(colW * (i + 0.5));
    }
    var headH = 0.0;
    for (var i = 0; i < n; i++) {
      final tp = s.text(
        d.teilnehmer[i],
        styles[i],
        maxWidth: colW - 4 - 2 * headPad,
        align: TextAlign.center,
      );
      heads.add(tp);
      headH = math.max(headH, tp.height + 2 * s.sc(8));
    }
    this.headH = headH;

    final msgStyle = s.label(size: 12, weight: FontWeight.w500);
    var y = headH + s.sc(16);
    for (final m in d.nachrichten) {
      if (m.von < 0 || m.von >= n || m.an < 0 || m.an >= n) continue;
      final x0 = xs[m.von];
      final x1 = xs[m.an];
      final span = (x1 - x0).abs();
      final wrap = math.max(span - 14, math.min(width - 8, s.sc(130)));
      final tp = s.text(
        m.text,
        msgStyle,
        maxWidth: wrap,
        align: TextAlign.center,
      );
      final msg = _Msg(m, tp);
      var tx = (x0 + x1) / 2 - tp.width / 2;
      tx = tx.clamp(3.0, math.max(3.0, width - tp.width - 3));
      msg.textPos = Offset(tx, y);
      msg.y = y + tp.height + 5;
      msgs.add(msg);
      y = msg.y + s.sc(16);
    }
    lifeEnd = y;
    size = Size(width, y + 2);
  }

  final SequenzDiagramm d;
  final DiagramStyle s;
  late final double width;
  late final double headH;
  late final double lifeEnd;
  final xs = <double>[];
  final heads = <TextPainter>[];
  final msgs = <_Msg>[];

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    // Lebenslinien.
    for (final x in xs) {
      drawDashedLine(
        c,
        Offset(x, headH),
        Offset(x, lifeEnd),
        strokePaint(s.grid, 1.4),
        dash: 5,
        gap: 4,
      );
    }
    // Köpfe.
    for (var i = 0; i < heads.length; i++) {
      final tp = heads[i];
      final w = math.max(tp.width + 2 * s.sc(10), s.sc(56));
      final r = Rect.fromCenter(
        center: Offset(xs[i], headH / 2),
        width: math.max(
          tp.width + s.sc(10),
          math.min(w, size.width / heads.length - 4),
        ),
        height: headH,
      );
      final rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
      c.drawRRect(rr, fillPaint(s.accentBg));
      c.drawRRect(rr, strokePaint(s.accent, 1.3));
      tp.paint(c, r.center - Offset(tp.width / 2, tp.height / 2));
    }
    // Nachrichten.
    for (final m in msgs) {
      final x0 = xs[m.n.von];
      final x1 = xs[m.n.an];
      final a = Offset(x0, m.y);
      final b = Offset(x1, m.y);
      final color = m.n.antwort ? s.muted : s.ink;
      final p = strokePaint(color, 1.4);
      if (m.n.antwort) {
        drawDashedLine(c, a, b, p, dash: 6, gap: 4);
        drawHead(c, a, b, ArrowHead.open, color, size: 9);
      } else {
        c.drawLine(a, b, p);
        drawHead(c, a, b, ArrowHead.filled, color, size: 9);
      }
      paintLabel(c, m.text, m.textPos, s.surface, padX: 2, padY: 0);
    }
  }
}
