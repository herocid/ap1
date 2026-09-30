import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Der App-Name an einer Stelle - er taucht in Titelzeile, Onboarding,
/// Einstellungen und Tutorial auf.
const kAppName = 'AP1 Coach';

/// Das Logo: ein „A“ als Gipfel mit Fahne - das Ziel AP1 ist erreicht.
///
/// Gezeichnet statt als Bild eingebunden, damit es in jeder Größe scharf
/// bleibt. Dieselbe Zeichnung erzeugt auch die App-Icons
/// (`tool/generate_icons_test.dart`).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: const CustomPaint(painter: LogoPainter()),
    );
  }
}

class LogoPainter extends CustomPainter {
  const LogoPainter({this.rounded = true, this.inset = 0});

  /// Ohne Rundung für maskierbare Icons - das System schneidet selbst zu.
  final bool rounded;

  /// Anteil Rand um das Zeichen (0..0.3), für die Sicherheitszone
  /// maskierbarer Icons.
  final double inset;

  static const ink = AppColors.brand;
  static const paper = AppColors.lightSurface;
  static const brass = AppColors.flameDark;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final bg = Paint()..color = ink;
    final rect = Offset.zero & size;
    if (rounded) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(s * 0.24)),
        bg,
      );
    } else {
      canvas.drawRect(rect, bg);
    }

    // Zeichenfläche 100 × 100, bei Bedarf eingerückt.
    final scale = s * (1 - 2 * inset) / 100;
    canvas.save();
    canvas.translate(s * inset, s * inset);
    canvas.scale(scale);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Die beiden Schenkel des A - zugleich der Berg.
    canvas.drawPath(
      Path()
        ..moveTo(25, 78)
        ..lineTo(50, 33)
        ..lineTo(75, 78),
      stroke
        ..color = paper
        ..strokeWidth = 11,
    );
    // Querstrich in Orange.
    canvas.drawLine(
      const Offset(39, 62),
      const Offset(61, 62),
      stroke
        ..color = brass
        ..strokeWidth = 8,
    );
    // Fahnenstange und Fahne auf dem Gipfel.
    canvas.drawLine(
      const Offset(50, 31),
      const Offset(50, 13),
      stroke
        ..color = paper
        ..strokeWidth = 4,
    );
    canvas.drawPath(
      Path()
        ..moveTo(51, 12)
        ..lineTo(67, 17.5)
        ..lineTo(51, 23)
        ..close(),
      Paint()..color = brass,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(LogoPainter old) =>
      old.rounded != rounded || old.inset != inset;
}

/// Logo plus Schriftzug.
class AppWordmark extends StatelessWidget {
  const AppWordmark({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLogo(size: size),
        SizedBox(width: size * 0.3),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'AP1 '),
                TextSpan(
                  text: 'Coach',
                  style: TextStyle(color: context.c.flame),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.text.headlineSmall?.copyWith(
              fontSize: size * 0.62,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ],
    );
  }
}
