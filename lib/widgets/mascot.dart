import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';

/// Stimmungen des Maskottchens.
enum MascotMood {
  /// Freundlich, Standard.
  happy,

  /// Winkt - Begrüßung.
  wave,

  /// Jubelt - Ziel erreicht, gutes Ergebnis.
  cheer,

  /// Denkt nach - Tipps, Erklärungen.
  think,

  /// „Hoppla“ - nach einem schwachen Ergebnis. Aufmunternd, nicht traurig.
  oops,
}

/// Bit, der AP1 Coach: ein kleiner Roboter mit Bildschirmgesicht.
///
/// Gezeichnet statt als Grafik, damit er sich Hell- und Dunkelmodus
/// anpasst. Beim Erscheinen hüpft er einmal kurz ins Bild; eine Dauer-
/// animation gibt es bewusst nicht - sie lenkt beim Lernen ab und kostet
/// Akku.
class Mascot extends StatefulWidget {
  const Mascot({super.key, this.mood = MascotMood.happy, this.size = 64});

  final MascotMood mood;
  final double size;

  @override
  State<Mascot> createState() => _MascotState();
}

class _MascotState extends State<Mascot> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    _c.forward();
  }

  @override
  void didUpdateWidget(Mascot old) {
    super.didUpdateWidget(old);
    if (old.mood != widget.mood) _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    return Semantics(
      label: 'Bit, dein AP1 Coach',
      child: SizedBox.square(
        dimension: widget.size,
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            final t = reduce ? 1.0 : _c.value;
            // Kurzer Hüpfer: hoch und mit leichtem Nachfedern zurück.
            final hop = t < 1 ? math.sin(t * math.pi) * (1 - t) : 0.0;
            return Transform.translate(
              offset: Offset(0, -hop * widget.size * 0.18),
              child: CustomPaint(
                painter: MascotPainter(
                  mood: widget.mood,
                  dark: dark,
                  armSwing: widget.mood == MascotMood.wave
                      ? math.sin(t * math.pi * 3) * (1 - t * 0.6)
                      : 0,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MascotPainter extends CustomPainter {
  const MascotPainter({
    required this.mood,
    this.dark = false,
    this.armSwing = 0,
  });

  final MascotMood mood;
  final bool dark;

  /// -1..1, nur beim Winken.
  final double armSwing;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide / 100;
    canvas.save();
    canvas.scale(s);

    final body = dark ? const Color(0xFF2F7BE0) : AppColors.brand;
    const face = Color(0xFFF5F9FF);
    const ink = Color(0xFF0F172A);
    const brass = AppColors.flameDark;

    final fill = Paint();
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Arme hinter dem Körper.
    line
      ..color = body
      ..strokeWidth = 6;
    final hand = Paint()..color = body;
    void arm(Offset from, Offset to) {
      canvas.drawLine(from, to, line);
      canvas.drawCircle(to, 4.2, hand);
    }

    // Erhobene Arme müssen seitlich am Kopf vorbei, sonst verdeckt er sie.
    switch (mood) {
      case MascotMood.cheer:
        arm(const Offset(34, 82), const Offset(6, 58));
        arm(const Offset(66, 82), const Offset(94, 58));
      case MascotMood.wave:
        arm(const Offset(33, 84), const Offset(25, 93));
        final angle = -0.72 + armSwing * 0.3;
        final to =
            const Offset(66, 84) +
            Offset(math.cos(angle), math.sin(angle)) * 36;
        arm(const Offset(66, 84), to);
      case MascotMood.think:
        arm(const Offset(33, 84), const Offset(25, 93));
      case MascotMood.happy:
      case MascotMood.oops:
        arm(const Offset(33, 84), const Offset(25, 93));
        arm(const Offset(67, 84), const Offset(75, 93));
    }

    // Körper mit orangem Knopf.
    canvas.drawRRect(
      RRect.fromLTRBR(33, 74, 67, 96, const Radius.circular(10)),
      fill..color = body,
    );
    canvas.drawCircle(const Offset(50, 86), 3.6, fill..color = brass);

    // Antenne.
    canvas.drawLine(
      const Offset(50, 19),
      const Offset(50, 9),
      line
        ..color = body
        ..strokeWidth = 3,
    );
    canvas.drawCircle(const Offset(50, 7.5), 5, fill..color = brass);

    // Kopf und Bildschirm.
    canvas.drawRRect(
      RRect.fromLTRBR(13, 18, 87, 78, const Radius.circular(22)),
      fill..color = body,
    );
    canvas.drawRRect(
      RRect.fromLTRBR(21, 27, 79, 69, const Radius.circular(15)),
      fill..color = face,
    );

    // Nachdenken: die Hand liegt vor dem Kopf am Kinn.
    if (mood == MascotMood.think) {
      line
        ..color = body
        ..strokeWidth = 6;
      canvas.drawLine(const Offset(66, 86), const Offset(62, 75), line);
      canvas.drawCircle(const Offset(62, 73), 5, Paint()..color = body);
    }

    // Wangen.
    if (mood == MascotMood.happy ||
        mood == MascotMood.cheer ||
        mood == MascotMood.wave) {
      final cheek = Paint()..color = brass.withValues(alpha: 0.45);
      canvas.drawCircle(const Offset(30, 56), 4.2, cheek);
      canvas.drawCircle(const Offset(70, 56), 4.2, cheek);
    }

    // Augen.
    final eye = Paint()..color = ink;
    line
      ..color = ink
      ..strokeWidth = 3.6;
    switch (mood) {
      case MascotMood.cheer:
        for (final x in [38.0, 62.0]) {
          canvas.drawPath(
            Path()
              ..moveTo(x - 5, 47)
              ..quadraticBezierTo(x, 38, x + 5, 47),
            line,
          );
        }
      case MascotMood.think:
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(41, 43), width: 6.5, height: 9),
          eye,
        );
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(65, 43), width: 6.5, height: 9),
          eye,
        );
      case MascotMood.oops:
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(38, 46), width: 6.5, height: 8),
          eye,
        );
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(62, 46), width: 6.5, height: 8),
          eye,
        );
        // Hochgezogene Brauen.
        line.strokeWidth = 2.6;
        canvas.drawLine(const Offset(33, 37), const Offset(42, 35), line);
        canvas.drawLine(const Offset(58, 35), const Offset(67, 37), line);
      case MascotMood.happy:
      case MascotMood.wave:
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(38, 45), width: 7, height: 10),
          eye,
        );
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(62, 45), width: 7, height: 10),
          eye,
        );
        // Lichtpunkte lassen die Augen lebendig wirken.
        final glint = Paint()..color = face;
        canvas.drawCircle(const Offset(39.5, 42.5), 1.5, glint);
        canvas.drawCircle(const Offset(63.5, 42.5), 1.5, glint);
    }

    // Mund.
    line
      ..color = ink
      ..strokeWidth = 3.4;
    switch (mood) {
      case MascotMood.cheer:
        canvas.drawPath(
          Path()
            ..moveTo(40, 54)
            ..lineTo(60, 54)
            ..quadraticBezierTo(50, 68, 40, 54)
            ..close(),
          Paint()..color = ink,
        );
      case MascotMood.think:
        canvas.drawLine(const Offset(46, 59), const Offset(56, 57), line);
      case MascotMood.oops:
        canvas.drawCircle(const Offset(50, 58.5), 3.4, line);
      case MascotMood.happy:
      case MascotMood.wave:
        canvas.drawPath(
          Path()
            ..moveTo(42, 55)
            ..quadraticBezierTo(50, 63, 58, 55),
          line,
        );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(MascotPainter old) =>
      old.mood != mood || old.dark != dark || old.armSwing != armSwing;
}

/// Bit mit Sprechblase - für Tipps, Begrüßung und Rückmeldungen.
class MascotSays extends StatelessWidget {
  const MascotSays({
    super.key,
    required this.text,
    this.title,
    this.mood = MascotMood.happy,
    this.size = 56,
  });

  final String text;
  final String? title;
  final MascotMood mood;
  final double size;

  /// Wenig Platz: schmales Gerät oder große Schrift. Dann wäre die Blase
  /// neben Bit sehr schmal und hoch, links bliebe eine leere Fläche.
  static bool _isTight(BuildContext context) {
    final mq = MediaQuery.of(context);
    return mq.size.width < 360 || mq.textScaler.scale(100) > 115;
  }

  @override
  Widget build(BuildContext context) {
    if (_isTight(context)) return _compact(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Mascot(mood: mood, size: size),
        const SizedBox(width: Gap.s),
        Expanded(
          child: SpeechBubble(title: title, text: text),
        ),
      ],
    );
  }

  /// Kompakte Form: Blase über die volle Breite, Bit klein oben links neben
  /// dem Titel, der Text darunter in ganzer Breite. Ohne Titel steht Bit
  /// oben links neben dem Text.
  Widget _compact(BuildContext context) {
    final bit = Mascot(mood: mood, size: math.min(size, 40));
    final body = Text(text, style: context.text.bodyMedium);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.m),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.l),
        border: Border.all(color: context.c.border),
      ),
      child: title == null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bit,
                const SizedBox(width: Gap.s),
                Expanded(child: body),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    bit,
                    const SizedBox(width: Gap.s),
                    Expanded(
                      child: Text(
                        title!,
                        style: context.text.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.xs),
                body,
              ],
            ),
    );
  }
}

/// Sprechblase mit kleiner Spitze nach links unten.
class SpeechBubble extends StatelessWidget {
  const SpeechBubble({super.key, required this.text, this.title});

  final String text;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final bg = context.scheme.surface;
    final border = context.c.border;
    return CustomPaint(
      painter: _BubbleTail(color: bg, border: border),
      child: Container(
        margin: const EdgeInsets.only(left: 6),
        padding: const EdgeInsets.symmetric(horizontal: Gap.l, vertical: Gap.m),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(Radii.l),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: context.text.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
            ],
            Text(text, style: context.text.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _BubbleTail extends CustomPainter {
  const _BubbleTail({required this.color, required this.border});

  final Color color;
  final Color border;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height - 18;
    final tail = Path()
      ..moveTo(7, y)
      ..lineTo(0, y + 10)
      ..lineTo(7, y + 8)
      ..close();
    canvas.drawPath(tail, Paint()..color = color);
    canvas.drawPath(
      Path()
        ..moveTo(7, y)
        ..lineTo(0, y + 10)
        ..lineTo(7, y + 8),
      Paint()
        ..color = border
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_BubbleTail old) =>
      old.color != color || old.border != border;
}
