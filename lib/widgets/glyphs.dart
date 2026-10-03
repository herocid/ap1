import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Eigene, gezeichnete Symbole im Stil von Bit: runde Striche in einer
/// Hauptfarbe, ein kleiner Akzent in Orange. Bewusst keine Standard-Icons.
enum GlyphKind { journey, cards, flame }

class AppGlyph extends StatelessWidget {
  const AppGlyph(
    this.kind, {
    super.key,
    this.size = 24,
    required this.color,
    required this.accent,
  });

  final GlyphKind kind;
  final double size;
  final Color color;
  final Color accent;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: CustomPaint(painter: _GlyphPainter(kind, color, accent)),
  );
}

class _GlyphPainter extends CustomPainter {
  _GlyphPainter(this.kind, this.color, this.accent);

  final GlyphKind kind;
  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final u = size.width / 24;
    canvas.scale(u);
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fill = Paint()..color = accent;

    switch (kind) {
      case GlyphKind.journey:
        // Geschwungener Pfad von unten links zur Fahne oben rechts.
        final path = Path()
          ..moveTo(4, 20)
          ..cubicTo(4, 13, 12, 17, 12, 11)
          ..cubicTo(12, 7, 16, 7, 17, 7);
        canvas.drawPath(path, stroke);
        canvas.drawCircle(const Offset(4, 20), 2, fill);
        canvas.drawLine(const Offset(17, 12), const Offset(17, 3), stroke);
        final flag = Path()
          ..moveTo(17.6, 3)
          ..lineTo(22, 4.8)
          ..lineTo(17.6, 6.6)
          ..close();
        canvas.drawPath(flag, fill);
      case GlyphKind.cards:
        // Zwei Karten, die hintere leicht gedreht, vorne ein Haken-Akzent.
        canvas.save();
        canvas.translate(10, 12.5);
        canvas.rotate(-0.28);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(-6, -8, 12, 16),
            const Radius.circular(2.5),
          ),
          stroke..color = color.withValues(alpha: 0.45),
        );
        canvas.restore();
        stroke.color = color;
        final front = RRect.fromRectAndRadius(
          const Rect.fromLTWH(9, 4, 12, 16),
          const Radius.circular(2.5),
        );
        canvas.drawRRect(front, stroke);
        canvas.drawCircle(const Offset(15, 12), 2.4, fill);
      case GlyphKind.flame:
        // Flamme mit Innenzunge: außen Strich, innen Akzentfläche.
        final outer = Path()
          ..moveTo(12, 2.5)
          ..cubicTo(13, 6.5, 19, 9, 19, 14.5)
          ..cubicTo(19, 18.6, 15.9, 21.5, 12, 21.5)
          ..cubicTo(8.1, 21.5, 5, 18.6, 5, 14.5)
          ..cubicTo(5, 11.5, 7, 9.8, 8.4, 8.2)
          ..cubicTo(8.6, 10.4, 9.6, 11.6, 10.6, 11.8)
          ..cubicTo(10.2, 8.4, 10.8, 5, 12, 2.5)
          ..close();
        canvas.drawPath(outer, stroke);
        final inner = Path()
          ..moveTo(12, 12)
          ..cubicTo(13.2, 14, 15, 15, 15, 17.2)
          ..arcTo(
            Rect.fromCircle(center: const Offset(12, 17.2), radius: 3),
            0,
            math.pi,
            false,
          )
          ..cubicTo(9, 15.2, 11, 14, 12, 12)
          ..close();
        canvas.drawPath(inner, fill);
    }
  }

  @override
  bool shouldRepaint(_GlyphPainter old) =>
      old.kind != kind || old.color != color || old.accent != accent;
}
