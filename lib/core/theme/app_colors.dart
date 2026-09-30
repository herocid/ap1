import 'package:flutter/material.dart';

/// Farb-Token des Design-Systems.
///
/// Zwei Paletten (hell/dunkel) mit identischen Rollen. Semantische Farben
/// (richtig/falsch/Streak) sind bewusst *nicht* Rot/Grün allein – jede
/// Rückmeldung bekommt zusätzlich ein Icon, damit sie auch bei Rot-Grün-Schwäche
/// lesbar bleibt.
class AppColors {
  const AppColors._();

  // Farbwelt "IT-Blau und Orange": ein kräftiges Blau wie bei SAP,
  // Salesforce oder Google als Markenfarbe, dazu Orange als Komplementär-
  // farbe für alles, was motivieren soll (Streak, Tagesziel, Akzente).
  // Klare, kühle Flächen - so sehen professionelle IT-Werkzeuge aus.

  // Marke: IT-Blau. Im Dunkelmodus heller, damit es auf Nachtblau leuchtet.
  static const brand = Color(0xFF0B63CE);
  static const brandDark = Color(0xFF6FA8FF);

  // Fortschritt / "geschafft".
  static const success = Color(0xFF1E8E3E);
  static const successDark = Color(0xFF5BD17A);

  // Orange (Komplementärfarbe): Streak, Tagesziel, kritischer Pfad,
  // Zeitwarnung. Der Name "flame" ist historisch.
  static const flame = Color(0xFFD25E0A);
  static const flameDark = Color(0xFFFFA24D);

  // Rot für falsche Antworten.
  static const danger = Color(0xFFD93025);
  static const dangerDark = Color(0xFFFF7B72);

  // Petrol für Erklärungen und Merksätze - abgesetzt vom Marken-Blau.
  static const info = Color(0xFF00897B);
  static const infoDark = Color(0xFF4DD0C4);

  // Flächen hell: klares, leicht kühles Weiß.
  static const lightBg = Color(0xFFF3F6FB);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceAlt = Color(0xFFE8EEF6);
  static const lightBorder = Color(0xFFDCE3ED);
  static const lightText = Color(0xFF0F172A);
  static const lightTextMuted = Color(0xFF5B6576);

  // Flächen dunkel: tiefes Nachtblau, nicht reines Schwarz - sonst
  // "schwimmt" Text auf OLED-Displays.
  static const darkBg = Color(0xFF0D1321);
  static const darkSurface = Color(0xFF151C2C);
  static const darkSurfaceAlt = Color(0xFF1E2738);
  static const darkBorder = Color(0xFF2A3447);
  static const darkText = Color(0xFFEEF2F8);
  static const darkTextMuted = Color(0xFF9AA6BA);
}

/// Rollen-basierter Zugriff auf semantische Farben, damit Widgets nicht
/// selbst `isDark` abfragen müssen.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.successBg,
    required this.danger,
    required this.dangerBg,
    required this.flame,
    required this.flameBg,
    required this.info,
    required this.infoBg,
    required this.surfaceAlt,
    required this.border,
    required this.textMuted,
  });

  final Color success;
  final Color successBg;
  final Color danger;
  final Color dangerBg;
  final Color flame;
  final Color flameBg;
  final Color info;
  final Color infoBg;
  final Color surfaceAlt;
  final Color border;
  final Color textMuted;

  static const light = AppSemanticColors(
    success: AppColors.success,
    successBg: Color(0xFFE6F4EA),
    danger: AppColors.danger,
    dangerBg: Color(0xFFFCE8E6),
    flame: AppColors.flame,
    flameBg: Color(0xFFFEEFE3),
    info: AppColors.info,
    infoBg: Color(0xFFE0F2F1),
    surfaceAlt: AppColors.lightSurfaceAlt,
    border: AppColors.lightBorder,
    textMuted: AppColors.lightTextMuted,
  );

  static const dark = AppSemanticColors(
    success: AppColors.successDark,
    successBg: Color(0xFF12291B),
    danger: AppColors.dangerDark,
    dangerBg: Color(0xFF3A1714),
    flame: AppColors.flameDark,
    flameBg: Color(0xFF36230F),
    info: AppColors.infoDark,
    infoBg: Color(0xFF0F2B2A),
    surfaceAlt: AppColors.darkSurfaceAlt,
    border: AppColors.darkBorder,
    textMuted: AppColors.darkTextMuted,
  );

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? successBg,
    Color? danger,
    Color? dangerBg,
    Color? flame,
    Color? flameBg,
    Color? info,
    Color? infoBg,
    Color? surfaceAlt,
    Color? border,
    Color? textMuted,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      successBg: successBg ?? this.successBg,
      danger: danger ?? this.danger,
      dangerBg: dangerBg ?? this.dangerBg,
      flame: flame ?? this.flame,
      flameBg: flameBg ?? this.flameBg,
      info: info ?? this.info,
      infoBg: infoBg ?? this.infoBg,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      border: border ?? this.border,
      textMuted: textMuted ?? this.textMuted,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      successBg: Color.lerp(successBg, other.successBg, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerBg: Color.lerp(dangerBg, other.dangerBg, t)!,
      flame: Color.lerp(flame, other.flame, t)!,
      flameBg: Color.lerp(flameBg, other.flameBg, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoBg: Color.lerp(infoBg, other.infoBg, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      border: Color.lerp(border, other.border, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppSemanticColors get c => Theme.of(this).extension<AppSemanticColors>()!;
  ColorScheme get scheme => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}
