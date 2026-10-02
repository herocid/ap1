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

  /// Stolz - Hände in die Hüften, zufriedenes Lächeln.
  proud,

  /// Müde - halb geschlossene Augen, kleine „z“. Für Pausen und spät abends.
  sleepy,
}

/// Bit, der AP1 Coach: ein kleiner Roboter mit Bildschirmgesicht.
///
/// Gezeichnet statt als Grafik, damit er sich Hell- und Dunkelmodus
/// anpasst. Beim Erscheinen hüpft er kurz ins Bild. Antippen lässt ihn
/// hüpfen und kurz jubeln.
///
/// Leerlauf (seltenes Blinzeln, leichtes Schweben) läuft nur, wenn
/// [idleAnimations] gesetzt ist (in `main.dart`), das Widget sichtbar ist
/// (`TickerMode`) und „Animationen reduzieren“ aus ist. In Tests bleibt es
/// aus, sonst käme `pumpAndSettle` nie zur Ruhe.
class Mascot extends StatefulWidget {
  const Mascot({super.key, this.mood = MascotMood.happy, this.size = 64});

  final MascotMood mood;
  final double size;

  /// Schaltet Blinzeln und Schweben ein. Standard aus (Tests).
  static bool idleAnimations = false;

  @override
  State<Mascot> createState() => _MascotState();
}

class _MascotState extends State<Mascot> with TickerProviderStateMixin {
  late final AnimationController _hop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  /// Reaktion aufs Antippen: so lange gilt die Tipp-Stimmung.
  late final AnimationController _tap = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  /// Leerlauf: ein Zyklus = einmal blinzeln, zweimal atmen.
  AnimationController? _idle;
  final _rnd = math.Random();
  double _blinkAt = 0.8;

  @override
  void initState() {
    super.initState();
    _hop.forward();
    _tap.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final want =
        Mascot.idleAnimations &&
        !reduce &&
        TickerMode.valuesOf(context).enabled;
    if (want && _idle == null) {
      _idle =
          AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 4200 + _rnd.nextInt(1800)),
            )
            ..addStatusListener((s) {
              if (s == AnimationStatus.completed) {
                _blinkAt = 0.55 + _rnd.nextDouble() * 0.35;
                _idle?.forward(from: 0);
              }
            })
            ..forward();
    } else if (!want && _idle != null) {
      _idle!.dispose();
      _idle = null;
    }
  }

  @override
  void didUpdateWidget(Mascot old) {
    super.didUpdateWidget(old);
    if (old.mood != widget.mood) _hop.forward(from: 0);
  }

  @override
  void dispose() {
    _hop.dispose();
    _tap.dispose();
    _idle?.dispose();
    super.dispose();
  }

  void _onTap() {
    _hop.forward(from: 0);
    _tap.forward(from: 0);
    setState(() {});
  }

  MascotMood get _mood {
    if (_tap.isAnimating) {
      return widget.mood == MascotMood.cheer
          ? MascotMood.proud
          : MascotMood.cheer;
    }
    return widget.mood;
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final idle = _idle;

    return Semantics(
      label: 'Bit, dein AP1 Coach',
      // Listener statt GestureDetector: nimmt einem umgebenden ListTile
      // oder Button den Tipp nicht weg.
      child: Listener(
        onPointerDown: (_) => _onTap(),
        child: SizedBox.square(
          dimension: widget.size,
          child: AnimatedBuilder(
            animation: Listenable.merge([_hop, ?idle]),
            builder: (context, _) {
              final t = reduce ? 1.0 : _hop.value;
              // Kurzer Hüpfer: hoch und mit leichtem Nachfedern zurück.
              final hop = t < 1 ? math.sin(t * math.pi) * (1 - t) : 0.0;
              var float = 0.0;
              var blink = 0.0;
              if (idle != null) {
                final v = idle.value;
                float = math.sin(v * math.pi * 4);
                final d = (v - _blinkAt).abs();
                if (d < 0.025) blink = 1 - d / 0.025;
              }
              final mood = _mood;
              return Transform.translate(
                offset: Offset(
                  0,
                  -hop * widget.size * 0.18 - float * widget.size * 0.015,
                ),
                child: CustomPaint(
                  painter: MascotPainter(
                    mood: mood,
                    dark: dark,
                    blink: blink,
                    lift: hop + float * 0.08,
                    armSwing: mood == MascotMood.wave
                        ? math.sin(t * math.pi * 3) * (1 - t * 0.6)
                        : 0,
                  ),
                ),
              );
            },
          ),
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
    this.blink = 0,
    this.lift = 0,
  });

  final MascotMood mood;
  final bool dark;

  /// -1..1, nur beim Winken.
  final double armSwing;

  /// 0 = Augen offen, 1 = geschlossen.
  final double blink;

  /// Wie weit Bit gerade über dem Boden ist (0..1) - der Bodenschatten
  /// wird dann kleiner und blasser.
  final double lift;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide / 100;
    canvas.save();
    canvas.scale(s);

    final body = dark ? const Color(0xFF3B86EA) : AppColors.brand;
    // Eine Spur dunkler für Arme, Ohren und Hals - gibt Tiefe ohne Verlauf.
    final bodyDeep = Color.lerp(body, const Color(0xFF06264F), 0.28)!;
    // Glanzkante oben am Kopf.
    final sheen = Colors.white.withValues(alpha: dark ? 0.16 : 0.2);
    final accent = dark ? AppColors.flameDark : AppColors.flameFill;
    const screen = Color(0xFF0D2140);
    const glow = Color(0xFFEAF4FF);
    final cheekC = accent.withValues(alpha: 0.75);

    final fill = Paint()..isAntiAlias = true;
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Bodenschatten.
    final l = lift.clamp(0.0, 1.0);
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(50, 97),
        width: 40 * (1 - l * 0.35),
        height: 5 * (1 - l * 0.3),
      ),
      fill
        ..color = Colors.black.withValues(
          alpha: (dark ? 0.35 : 0.12) * (1 - l * 0.5),
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    fill.maskFilter = null;

    // Arme hinter dem Körper.
    line
      ..color = bodyDeep
      ..strokeWidth = 6.5;
    final hand = Paint()..color = body;
    void arm(Offset from, Offset to, {Offset? via}) {
      final p = Path()..moveTo(from.dx, from.dy);
      if (via != null) {
        p.quadraticBezierTo(via.dx, via.dy, to.dx, to.dy);
      } else {
        p.lineTo(to.dx, to.dy);
      }
      canvas.drawPath(p, line);
      canvas.drawCircle(to, 4.6, hand);
    }

    const lShoulder = Offset(38, 80);
    const rShoulder = Offset(62, 80);
    switch (mood) {
      case MascotMood.cheer:
        break; // Erhobene Arme folgen nach dem Kopf.
      case MascotMood.wave:
        arm(lShoulder, const Offset(28, 93));
      case MascotMood.think:
        arm(lShoulder, const Offset(28, 93));
      case MascotMood.oops:
        // Rechte Hand kratzt sich am Kopf.
        arm(lShoulder, const Offset(28, 93));
        arm(rShoulder, const Offset(90, 40), via: const Offset(94, 72));
      case MascotMood.proud:
        // Hände in die Hüften.
        arm(lShoulder, const Offset(36, 90), via: const Offset(24, 82));
        arm(rShoulder, const Offset(64, 90), via: const Offset(76, 82));
      case MascotMood.happy:
      case MascotMood.sleepy:
        arm(lShoulder, const Offset(28, 93));
        arm(rShoulder, const Offset(72, 93));
    }

    // Körper: klein und rund, mit orangem Knopf.
    final bodyR = RRect.fromLTRBR(36, 72, 64, 95, const Radius.circular(11));
    canvas.drawRRect(bodyR, fill..color = body);
    canvas.drawCircle(const Offset(50, 84), 3.8, fill..color = accent);
    canvas.drawCircle(
      const Offset(48.8, 82.8),
      1.1,
      fill..color = Colors.white.withValues(alpha: 0.6),
    );

    // Antenne mit oranger Kugel.
    canvas.drawLine(
      const Offset(50, 19),
      const Offset(50, 10),
      line
        ..color = bodyDeep
        ..strokeWidth = 3,
    );
    final ballA = mood == MascotMood.sleepy ? 0.7 : 1.0;
    canvas.drawCircle(
      const Offset(50, 7.5),
      5.2,
      fill..color = accent.withValues(alpha: ballA),
    );
    canvas.drawCircle(
      const Offset(48.3, 5.8),
      1.6,
      fill..color = Colors.white.withValues(alpha: 0.65 * ballA),
    );

    // Ohren.
    for (final x in [7.0, 87.0]) {
      canvas.drawRRect(
        RRect.fromLTRBR(x, 38, x + 6, 54, const Radius.circular(3)),
        fill..color = bodyDeep,
      );
    }

    // Kopf mit weichem Schatten statt Rahmen.
    final head = RRect.fromLTRBR(11, 17, 89, 74, const Radius.circular(24));
    canvas.drawShadow(
      Path()..addRRect(head.shift(const Offset(0, 1))),
      Colors.black.withValues(alpha: dark ? 0.6 : 0.35),
      2.5,
      false,
    );
    canvas.drawRRect(head, fill..color = body);
    // Glanzkante oben (flache Form, kein Verlauf).
    canvas.save();
    canvas.clipRRect(head);
    canvas.drawRRect(
      RRect.fromLTRBR(20, 19.5, 80, 25, const Radius.circular(3)),
      fill..color = sheen,
    );
    canvas.restore();

    // Bildschirm.
    final scr = RRect.fromLTRBR(19, 27, 81, 66, const Radius.circular(15));
    canvas.drawRRect(scr, fill..color = screen);

    // Erhobene Arme seitlich am Kopf vorbei, vor ihm gezeichnet, damit er
    // sie nicht verdeckt.
    line
      ..color = bodyDeep
      ..strokeWidth = 6.5;
    if (mood == MascotMood.cheer) {
      arm(lShoulder, const Offset(4, 44), via: const Offset(2, 82));
      arm(rShoulder, const Offset(96, 44), via: const Offset(98, 82));
    } else if (mood == MascotMood.wave) {
      final to = Offset(95 + armSwing * 2, 50 - armSwing * 4);
      arm(rShoulder, to, via: const Offset(97, 82));
    }

    // Nachdenken: die Hand liegt vor dem Kopf am Kinn.
    if (mood == MascotMood.think) {
      line
        ..color = bodyDeep
        ..strokeWidth = 6.5;
      canvas.drawPath(
        Path()
          ..moveTo(rShoulder.dx, rShoulder.dy)
          ..quadraticBezierTo(74, 80, 68, 71),
        line,
      );
      canvas.drawCircle(const Offset(67, 70), 5, Paint()..color = body);
      // Gedankenpunkte.
      final dot = Paint()..color = accent;
      canvas.drawCircle(const Offset(84, 14), 2, dot);
      canvas.drawCircle(const Offset(90, 8), 2.8, dot);
    }

    // Wangen.
    if (mood == MascotMood.happy ||
        mood == MascotMood.cheer ||
        mood == MascotMood.wave ||
        mood == MascotMood.proud) {
      final cheek = Paint()..color = cheekC;
      for (final x in [29.0, 71.0]) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(x, 55), width: 7, height: 3.6),
            const Radius.circular(2),
          ),
          cheek,
        );
      }
    }

    // Augen.
    final eye = Paint()..color = glow;
    line
      ..color = glow
      ..strokeWidth = 3.6;
    void openEyes(double y, double w, double h, {double dx = 0}) {
      final hh = math.max(h * (1 - blink), 2.4);
      for (final x in [37.0, 63.0]) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(x + dx, y), width: w, height: hh),
            Radius.circular(w / 2),
          ),
          eye,
        );
      }
    }

    switch (mood) {
      case MascotMood.cheer:
        // Lachende Augen ^ ^.
        for (final x in [37.0, 63.0]) {
          canvas.drawPath(
            Path()
              ..moveTo(x - 5.5, 46)
              ..quadraticBezierTo(x, 36, x + 5.5, 46),
            line,
          );
        }
      case MascotMood.proud:
        // Zufrieden geschlossen (Bogen nach unten).
        for (final x in [37.0, 63.0]) {
          canvas.drawPath(
            Path()
              ..moveTo(x - 5, 42)
              ..quadraticBezierTo(x, 49, x + 5, 42),
            line,
          );
        }
      case MascotMood.sleepy:
        // Halb geschlossen: Lid als gerade Kante.
        for (final x in [37.0, 63.0]) {
          canvas.drawPath(
            Path()
              ..moveTo(x - 5.5, 44)
              ..lineTo(x + 5.5, 44)
              ..quadraticBezierTo(x, 50, x - 5.5, 44)
              ..close(),
            eye,
          );
        }
      case MascotMood.think:
        // Blick nach oben rechts, eine Braue hoch.
        openEyes(42, 6.5, 8, dx: 3);
        line.strokeWidth = 2.6;
        canvas.drawLine(const Offset(60, 34), const Offset(70, 32), line);
      case MascotMood.oops:
        openEyes(45, 8, 11);
        line.strokeWidth = 2.6;
        canvas.drawLine(const Offset(32, 36), const Offset(41, 33.5), line);
        canvas.drawLine(const Offset(59, 33.5), const Offset(68, 36), line);
      case MascotMood.happy:
      case MascotMood.wave:
        openEyes(44, 8, 12);
        if (blink < 0.5) {
          final glint = Paint()..color = screen;
          canvas.drawCircle(const Offset(39, 41), 1.5, glint);
          canvas.drawCircle(const Offset(65, 41), 1.5, glint);
        }
    }

    // Mund.
    line
      ..color = glow
      ..strokeWidth = 3.2;
    switch (mood) {
      case MascotMood.cheer:
        final m = Path()
          ..moveTo(40, 53)
          ..lineTo(60, 53)
          ..quadraticBezierTo(60, 63, 50, 63)
          ..quadraticBezierTo(40, 63, 40, 53)
          ..close();
        canvas.drawPath(m, eye);
        canvas.save();
        canvas.clipPath(m);
        canvas.drawCircle(const Offset(50, 64), 5, Paint()..color = accent);
        canvas.restore();
      case MascotMood.wave:
        canvas.drawPath(
          Path()
            ..moveTo(42, 54)
            ..quadraticBezierTo(50, 62, 58, 54)
            ..close(),
          eye,
        );
      case MascotMood.think:
        canvas.drawLine(const Offset(45, 57), const Offset(55, 55), line);
      case MascotMood.oops:
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(50, 57), width: 6, height: 7),
          line,
        );
      case MascotMood.proud:
        canvas.drawPath(
          Path()
            ..moveTo(42, 54)
            ..quadraticBezierTo(51, 60, 59, 52),
          line,
        );
      case MascotMood.sleepy:
        canvas.drawLine(const Offset(47, 57), const Offset(53, 57), line);
      case MascotMood.happy:
        canvas.drawPath(
          Path()
            ..moveTo(43, 54)
            ..quadraticBezierTo(50, 61, 57, 54),
          line,
        );
    }

    // Kleine Extras außerhalb des Kopfes.
    switch (mood) {
      case MascotMood.cheer:
        _sparkle(canvas, const Offset(18, 12), 4, accent);
        _sparkle(canvas, const Offset(84, 14), 3, accent);
      case MascotMood.proud:
        _sparkle(canvas, const Offset(83, 12), 4.5, accent);
      case MascotMood.oops:
        // Schweißtropfen.
        canvas.drawPath(
          Path()
            ..moveTo(16, 24)
            ..quadraticBezierTo(12, 31, 16, 33)
            ..quadraticBezierTo(20, 31, 16, 24)
            ..close(),
          Paint()..color = const Color(0xFF7FC4F5),
        );
      case MascotMood.sleepy:
        final z = Paint()
          ..color = accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
        void zz(double x, double y, double w) => canvas.drawPath(
          Path()
            ..moveTo(x, y)
            ..lineTo(x + w, y)
            ..lineTo(x, y + w)
            ..lineTo(x + w, y + w),
          z,
        );
        zz(76, 9, 5);
        zz(86, 2, 6.5);
      case MascotMood.happy:
      case MascotMood.wave:
      case MascotMood.think:
        break;
    }

    canvas.restore();
  }

  void _sparkle(Canvas canvas, Offset c, double r, Color color) {
    final p = Path()
      ..moveTo(c.dx, c.dy - r)
      ..quadraticBezierTo(c.dx, c.dy, c.dx + r, c.dy)
      ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy + r)
      ..quadraticBezierTo(c.dx, c.dy, c.dx - r, c.dy)
      ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy - r)
      ..close();
    canvas.drawPath(p, Paint()..color = color);
  }

  @override
  bool shouldRepaint(MascotPainter old) =>
      old.mood != mood ||
      old.dark != dark ||
      old.armSwing != armSwing ||
      old.blink != blink ||
      old.lift != lift;
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
        const SizedBox(width: Gap.xs),
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
    return CustomPaint(
      painter: _BubblePainter.of(context, tail: false),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Gap.m),
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
                        child: Text(title!, style: _titleStyle(context)),
                      ),
                    ],
                  ),
                  const SizedBox(height: Gap.xs),
                  body,
                ],
              ),
      ),
    );
  }
}

TextStyle? _titleStyle(BuildContext context) => context.text.titleMedium
    ?.copyWith(fontSize: 15, fontWeight: FontWeight.w700);

/// Sprechblase mit kleiner Spitze nach links unten (zu Bit).
class SpeechBubble extends StatelessWidget {
  const SpeechBubble({super.key, required this.text, this.title});

  final String text;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter.of(context, tail: true),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          _BubblePainter.tailW + Gap.l,
          Gap.m,
          Gap.l,
          Gap.m,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Text(title!, style: _titleStyle(context)),
              const SizedBox(height: 2),
            ],
            Text(text, style: context.text.bodyMedium),
          ],
        ),
      ),
    );
  }
}

/// Zeichnet Blase und Spitze als eine Form: hell mit weichem Schatten wie
/// die AppCard, dunkel als etwas hellere Fläche mit feiner Kante.
class _BubblePainter extends CustomPainter {
  const _BubblePainter({
    required this.color,
    required this.dark,
    required this.tail,
  });

  factory _BubblePainter.of(BuildContext context, {required bool tail}) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final surface = context.scheme.surface;
    return _BubblePainter(
      color: dark ? Color.lerp(surface, Colors.white, 0.06)! : surface,
      dark: dark,
      tail: tail,
    );
  }

  static const tailW = 8.0;

  final Color color;
  final bool dark;
  final bool tail;

  Path _shape(Size size) {
    final left = tail ? tailW : 0.0;
    final rect = RRect.fromLTRBR(
      left,
      0,
      size.width,
      size.height,
      const Radius.circular(Radii.l),
    );
    final path = Path()..addRRect(rect);
    if (!tail) return path;
    // Spitze unten links, Richtung Bit, mit weich gerundetem Ende.
    final y = size.height - 14;
    final t = Path()
      ..moveTo(left + 1, y - 10)
      ..quadraticBezierTo(left - 2, y + 2, 1, y + 7)
      ..quadraticBezierTo(0, y + 9, 3, y + 8.5)
      ..quadraticBezierTo(left + 2, y + 6, left + 10, y + 4)
      ..close();
    return Path.combine(PathOperation.union, path, t);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final shape = _shape(size);
    if (!dark) {
      for (final (c, blur, dy) in const [
        (Color(0x0A0B1E3A), 2.0, 1.0),
        (Color(0x120B1E3A), 12.0, 4.0),
      ]) {
        canvas.drawPath(
          shape.shift(Offset(0, dy)),
          Paint()
            ..color = c
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur / 2),
        );
      }
    }
    canvas.drawPath(shape, Paint()..color = color);
    if (dark) {
      canvas.drawPath(
        shape,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.06)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(_BubblePainter old) =>
      old.color != color || old.dark != dark || old.tail != tail;
}
