import 'package:flutter/material.dart';

/// Farb-Token des Design-Systems.
///
/// Zwei Paletten (hell/dunkel) mit identischen Rollen. Semantische Farben
/// (richtig/falsch/Streak) sind bewusst *nicht* Rot/Grün allein – jede
/// Rückmeldung bekommt zusätzlich ein Icon, damit sie auch bei Rot-Grün-Schwäche
/// lesbar bleibt.
class AppColors {
  const AppColors._();

  // Farbwelt "Tinte und Messing": Tintenblau für Aktionen, warmes Papier als
  // Fläche, Messing als einziger warmer Akzent. Bewusst kein Violett/Indigo -
  // das ist der Standard-Look generischer KI- und EdTech-Apps.

  // Marke: Tintenblau. Im Dunkelmodus ein gedecktes Stahlblau, weil Tinte
  // auf dunklem Grund verschwindet.
  static const brand = Color(0xFF1F2A44);
  static const brandDark = Color(0xFFA9B9D6);

  // Fortschritt / "geschafft".
  static const success = Color(0xFF2F6B4F);
  static const successDark = Color(0xFF6FBF93);

  // Messing: Streak, Tagesziel, kritischer Pfad, Zeitwarnung.
  static const flame = Color(0xFFA8792A);
  static const flameDark = Color(0xFFD4A95A);

  // Ziegelrot für falsche Antworten - deutlich, aber nicht grell.
  static const danger = Color(0xFFA63D32);
  static const dangerDark = Color(0xFFE58A7F);

  // Schieferblau für Erklärungen und Merksätze.
  static const info = Color(0xFF2F5D7C);
  static const infoDark = Color(0xFF8DB3D1);

  // Flächen hell: warmes Papier statt kaltem Grauweiß.
  static const lightBg = Color(0xFFF6F4EF);
  static const lightSurface = Color(0xFFFFFDF8);
  static const lightSurfaceAlt = Color(0xFFEEEAE1);
  static const lightBorder = Color(0xFFE4E0D6);
  static const lightText = Color(0xFF15181F);
  static const lightTextMuted = Color(0xFF6B6A63);

  // Flächen dunkel: warmes Anthrazit, nicht reines Schwarz - sonst
  // "schwimmt" Text auf OLED-Displays.
  static const darkBg = Color(0xFF121211);
  static const darkSurface = Color(0xFF1A1A19);
  static const darkSurfaceAlt = Color(0xFF232321);
  static const darkBorder = Color(0xFF2F2E2B);
  static const darkText = Color(0xFFF2EFE8);
  static const darkTextMuted = Color(0xFFA3A097);
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
    successBg: Color(0xFFE6EFE9),
    danger: AppColors.danger,
    dangerBg: Color(0xFFF6E5E2),
    flame: AppColors.flame,
    flameBg: Color(0xFFF3EAD7),
    info: AppColors.info,
    infoBg: Color(0xFFE4ECF2),
    surfaceAlt: AppColors.lightSurfaceAlt,
    border: AppColors.lightBorder,
    textMuted: AppColors.lightTextMuted,
  );

  static const dark = AppSemanticColors(
    success: AppColors.successDark,
    successBg: Color(0xFF16281F),
    danger: AppColors.dangerDark,
    dangerBg: Color(0xFF34191A),
    flame: AppColors.flameDark,
    flameBg: Color(0xFF2E2616),
    info: AppColors.infoDark,
    infoBg: Color(0xFF172430),
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
