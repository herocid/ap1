import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/util/haptics.dart';

/// Grafisches Feedback: Puls bei richtig, Wackeln bei falsch, Konfetti für
/// Meilensteine, mitlaufende Zahlen. Alles respektiert „Animationen
/// reduzieren“ - dann erscheint sofort der Endzustand.
bool _reduced(BuildContext context) =>
    MediaQuery.maybeDisableAnimationsOf(context) ?? false;

/// Art der Rückmeldung für [AnswerFx].
enum AnswerFxKind { none, correct, wrong }

/// Spielt einmal einen kurzen Puls (richtig) oder ein leichtes Wackeln
/// (falsch), sobald [kind] von `none` auf einen Wert wechselt oder sich
/// [trigger] ändert.
class AnswerFx extends StatefulWidget {
  const AnswerFx({
    super.key,
    required this.kind,
    required this.child,
    this.trigger,
  });

  final AnswerFxKind kind;
  final Widget child;

  /// Ändert sich der Wert, spielt die Animation erneut (z. B. neue Aufgabe).
  final Object? trigger;

  @override
  State<AnswerFx> createState() => _AnswerFxState();
}

class _AnswerFxState extends State<AnswerFx>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  @override
  void initState() {
    super.initState();
    if (widget.kind != AnswerFxKind.none) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _play());
    }
  }

  @override
  void didUpdateWidget(AnswerFx old) {
    super.didUpdateWidget(old);
    if (widget.kind != AnswerFxKind.none &&
        (old.kind != widget.kind || old.trigger != widget.trigger)) {
      _play();
    }
  }

  void _play() {
    if (!mounted || _reduced(context)) return;
    _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      child: widget.child,
      builder: (context, child) {
        final t = _c.value;
        if (t == 0 || t == 1) return child!;
        switch (widget.kind) {
          case AnswerFxKind.correct:
            // Kurz auf 104 % und zurück.
            final s = 1 + 0.04 * math.sin(t * math.pi);
            return Transform.scale(scale: s, child: child);
          case AnswerFxKind.wrong:
            // Drei abklingende Ausschläge, höchstens 8 px.
            final dx = math.sin(t * math.pi * 6) * 8 * (1 - t);
            return Transform.translate(offset: Offset(dx, 0), child: child);
          case AnswerFxKind.none:
            return child!;
        }
      },
    );
  }
}

/// Zahl, die vom alten zum neuen Wert hochzählt.
class AnimatedCount extends StatelessWidget {
  const AnimatedCount(
    this.value, {
    super.key,
    this.style,
    this.suffix = '',
    this.duration = const Duration(milliseconds: 700),
  });

  final num value;
  final TextStyle? style;
  final String suffix;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    if (_reduced(context)) return Text('${value.round()}$suffix', style: style);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Text('${v.round()}$suffix', style: style),
    );
  }
}

/// Fortschrittsbalken, der sich animiert füllt.
class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.value,
    this.minHeight = 6,
    this.color,
    this.backgroundColor,
  });

  final double value;
  final double minHeight;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    Widget bar(double x) => ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: LinearProgressIndicator(
        value: x,
        minHeight: minHeight,
        color: color,
        backgroundColor: backgroundColor,
      ),
    );
    if (_reduced(context)) return bar(v);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: v),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, x, _) => bar(x),
    );
  }
}

/// Konfetti über dem ganzen Bildschirm - einmal, ca. 1,8 Sekunden, ohne
/// Bedienung zu blockieren. Für Meilensteine, nicht für jede Antwort.
class Celebration {
  const Celebration._();

  static void show(BuildContext context) {
    AppHaptics.milestone();
    if (_reduced(context)) return;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) =>
          IgnorePointer(child: _Confetti(onDone: () => entry.remove())),
    );
    overlay.insert(entry);
  }
}

class _Confetti extends StatefulWidget {
  const _Confetti({required this.onDone});
  final VoidCallback onDone;

  @override
  State<_Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<_Confetti>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..forward().whenComplete(widget.onDone);

  final _rnd = math.Random();
  late final List<_Piece> _pieces = List.generate(70, (_) {
    const colors = [
      AppColors.brand,
      AppColors.flameDark,
      AppColors.successDark,
      AppColors.brandDark,
      AppColors.flame,
    ];
    return _Piece(
      x: _rnd.nextDouble(),
      drift: (_rnd.nextDouble() - 0.5) * 0.3,
      speed: 0.7 + _rnd.nextDouble() * 0.6,
      size: 6 + _rnd.nextDouble() * 6,
      spin: (_rnd.nextDouble() - 0.5) * 12,
      delay: _rnd.nextDouble() * 0.25,
      color: colors[_rnd.nextInt(colors.length)],
    );
  });

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _c,
    builder: (_, _) => CustomPaint(
      size: Size.infinite,
      painter: _ConfettiPainter(_pieces, _c.value),
    ),
  );
}

class _Piece {
  const _Piece({
    required this.x,
    required this.drift,
    required this.speed,
    required this.size,
    required this.spin,
    required this.delay,
    required this.color,
  });
  final double x, drift, speed, size, spin, delay;
  final Color color;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.pieces, this.t);
  final List<_Piece> pieces;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final p in pieces) {
      final local = ((t - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      if (local == 0) continue;
      final y = -20 + local * p.speed * (size.height + 40);
      final x = (p.x + p.drift * local) * size.width;
      paint.color = p.color.withValues(
        alpha: 1 - math.max(0, local - 0.75) * 4,
      );
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin * local);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.size,
          height: p.size * 0.5,
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.t != t;
}
