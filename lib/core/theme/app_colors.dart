import 'package:flutter/material.dart';

/// Farb-Token des Design-Systems.
///
/// Zwei Paletten (hell/dunkel) mit identischen Rollen. Semantische Farben
/// (richtig/falsch/Streak) sind bewusst *nicht* Rot/Grün allein – jede
/// Rückmeldung bekommt zusätzlich ein Icon, damit sie auch bei Rot-Grün-Schwäche
/// lesbar bleibt.
class AppColors {
  const AppColors._();

  // Marke: ruhiges Indigo-Violett. Nicht das übliche Neon-Blau, aber auch
  // nicht so gesättigt, dass es bei 40 Minuten Lernsession ermüdet.
  static const brand = Color(0xFF5A4FCF);
  static const brandDark = Color(0xFF8B83F0);

  // Akzent für Fortschritt / "geschafft".
  static const success = Color(0xFF15803D);
  static const successDark = Color(0xFF4ADE80);

  // Streak / Tagesziel.
  static const flame = Color(0xFFEA580C);
  static const flameDark = Color(0xFFFB923C);

  // Fehler / falsche Antwort.
  static const danger = Color(0xFFBE123C);
  static const dangerDark = Color(0xFFFB7185);

  // Hinweis, Erklärboxen.
  static const info = Color(0xFF0E7490);
  static const infoDark = Color(0xFF22D3EE);

  // Flächen hell
  static const lightBg = Color(0xFFF7F7FB);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceAlt = Color(0xFFEFEEF6);
  static const lightBorder = Color(0xFFDDDCE8);
  static const lightText = Color(0xFF14131C);
  static const lightTextMuted = Color(0xFF5E5C70);

  // Flächen dunkel – nicht reines Schwarz, sonst „schwimmt" Text bei OLED.
  static const darkBg = Color(0xFF0E0E13);
  static const darkSurface = Color(0xFF17171F);
  static const darkSurfaceAlt = Color(0xFF20202B);
  static const darkBorder = Color(0xFF2E2E3C);
  static const darkText = Color(0xFFF2F1F7);
  static const darkTextMuted = Color(0xFF9F9DB2);
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
    successBg: Color(0xFFE7F6EC),
    danger: AppColors.danger,
    dangerBg: Color(0xFFFDE8EE),
    flame: AppColors.flame,
    flameBg: Color(0xFFFDEDE1),
    info: AppColors.info,
    infoBg: Color(0xFFE2F4F8),
    surfaceAlt: AppColors.lightSurfaceAlt,
    border: AppColors.lightBorder,
    textMuted: AppColors.lightTextMuted,
  );

  static const dark = AppSemanticColors(
    success: AppColors.successDark,
    successBg: Color(0xFF14301F),
    danger: AppColors.dangerDark,
    dangerBg: Color(0xFF3A1522),
    flame: AppColors.flameDark,
    flameBg: Color(0xFF3A2113),
    info: AppColors.infoDark,
    infoBg: Color(0xFF0F2C33),
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
