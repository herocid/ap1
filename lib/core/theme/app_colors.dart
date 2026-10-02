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
  static const brandDark = Color(0xFF7DB2FF);

  // Fortschritt / "geschafft". Google-Grün 700 - die hellere 600er-Stufe
  // erreicht auf Weiß nur 4,2:1, zu wenig für Text (WCAG AA verlangt 4,5:1).
  static const success = Color(0xFF188038);
  static const successDark = Color(0xFF5FD982);

  // Orange (Komplementärfarbe): Streak, Tagesziel, kritischer Pfad,
  // Zeitwarnung. Der Name "flame" ist historisch. Eine Spur tiefer als ein
  // reines Signalorange, damit orange Schrift auch auf der hellen Orange-
  // Fläche (flameBg) 4,5:1 schafft (WCAG AA).
  static const flame = Color(0xFFAD4C08);
  static const flameDark = Color(0xFFFFA95C);

  // Frisches Orange für Flächen und Balken im Hellmodus (Tagesziel,
  // Fortschritt). Nicht für Text: auf Weiß 3,6:1, auf der Balkenspur
  // (lightSurfaceAlt) 3,1:1 - genug für Grafik (3:1), zu wenig für Schrift.
  // Im Dunkelmodus leuchtet flameDark schon, dort gibt es keinen Extraton.
  static const flameFill = Color(0xFFE8590C);

  // Rot für falsche Antworten.
  static const danger = Color(0xFFC5221F);
  static const dangerDark = Color(0xFFFF8A80);

  // Petrol für Erklärungen und Merksätze - abgesetzt vom Marken-Blau.
  // Teal 700: Hinweistext auf Weiß und auf dem Petrol-Hintergrund >= 4,5:1.
  static const info = Color(0xFF00796B);
  static const infoDark = Color(0xFF56DACC);

  // Flächen hell: klares, leicht kühles Weiß.
  static const lightBg = Color(0xFFF3F6FB);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceAlt = Color(0xFFE8EEF6);
  static const lightBorder = Color(0xFFDCE3ED);
  static const lightText = Color(0xFF0F172A);
  static const lightTextMuted = Color(0xFF5B6576);

  // Flächen dunkel: tiefes Blau-Schwarz, nicht reines Schwarz - sonst
  // "schwimmt" Text auf OLED-Displays. Drei Stufen (Grund, Karte, Spur),
  // jede eine Spur heller, damit Ebenen ohne Schatten lesbar bleiben.
  // Kontraste: darkText 17,0:1 auf darkBg, darkTextMuted 7,9:1 auf darkBg
  // und 6,4:1 auf darkSurfaceAlt.
  static const darkBg = Color(0xFF0A0F1C);
  static const darkSurface = Color(0xFF121A2B);
  static const darkSurfaceAlt = Color(0xFF1B2538);
  static const darkBorder = Color(0xFF263149);
  static const darkText = Color(0xFFEEF2F8);
  static const darkTextMuted = Color(0xFF9AA8BE);

  // Akzentfarbe je Prüfungsbereich (a01 bis a07), alle aus der Blau-Orange-
  // Familie und bewusst weit weg von Erfolg-Grün und Fehler-Rot. Je Bereich:
  // Vordergrund hell, Fläche hell, Vordergrund dunkel, Fläche dunkel.
  // Kontrast Vordergrund (WCAG, nachgerechnet): hell auf Weiß / auf eigener
  // Fläche, dunkel auf darkBg / darkSurface / eigener Fläche.
  //  a01 Blau     5,7 / 4,9   8,8 / 8,0 / 7,3
  //  a02 Orange   5,5 / 4,9  10,1 / 9,2 / 7,8
  //  a03 Cyan     5,6 / 4,8  10,6 / 9,6 / 8,2
  //  a04 Indigo   7,1 / 6,0   8,9 / 8,1 / 7,5
  //  a05 Bernstein 6,0 / 5,4 11,9 / 10,8 / 9,2
  //  a06 Violett  6,7 / 5,7   9,6 / 8,7 / 8,1
  //  a07 Stahlblau 7,1 / 6,0 10,0 / 9,1 / 8,0
  static const areaAccents = <String, AreaAccent>{
    'a01': AreaAccent(
      Color(0xFF0B63CE),
      Color(0xFFE3EEFC),
      Color(0xFF7DB2FF),
      Color(0xFF10233F),
    ),
    'a02': AreaAccent(
      Color(0xFFAD4C08),
      Color(0xFFFDEEE2),
      Color(0xFFFFA95C),
      Color(0xFF3A230F),
    ),
    'a03': AreaAccent(
      Color(0xFF00718F),
      Color(0xFFDEF2F7),
      Color(0xFF4FD0F0),
      Color(0xFF0C2B35),
    ),
    'a04': AreaAccent(
      Color(0xFF4B47C2),
      Color(0xFFECEBFB),
      Color(0xFFABA8FF),
      Color(0xFF1E1C46),
    ),
    'a05': AreaAccent(
      Color(0xFF875A00),
      Color(0xFFFBF1DA),
      Color(0xFFF7C552),
      Color(0xFF33260A),
    ),
    'a06': AreaAccent(
      Color(0xFF7C3AB8),
      Color(0xFFF2E9FB),
      Color(0xFFCFA6FF),
      Color(0xFF2A1842),
    ),
    'a07': AreaAccent(
      Color(0xFF3B5A82),
      Color(0xFFE6EDF5),
      Color(0xFFA3BEE2),
      Color(0xFF1A2638),
    ),
  };
}

/// Akzentfarbe eines Prüfungsbereichs, je hell und dunkel mit Flächenton.
@immutable
class AreaAccent {
  const AreaAccent(this.light, this.lightBg, this.dark, this.darkBg);

  final Color light;
  final Color lightBg;
  final Color dark;
  final Color darkBg;

  /// Vordergrund (Symbol, Balken, Schrift) passend zur Helligkeit.
  Color fg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;

  /// Flächenton (Symbolfeld, Kachel) passend zur Helligkeit.
  Color bg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBg : lightBg;

  /// Paar (Vordergrund, Fläche) für `TileIcon.accent`.
  (Color, Color) tile(BuildContext context) => (fg(context), bg(context));
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
    required this.flameFill,
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

  /// Orange für gefüllte Flächen und Balken. Text und Icons nehmen [flame].
  final Color flameFill;
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
    flameFill: AppColors.flameFill,
    info: AppColors.info,
    infoBg: Color(0xFFE0F2F1),
    surfaceAlt: AppColors.lightSurfaceAlt,
    border: AppColors.lightBorder,
    textMuted: AppColors.lightTextMuted,
  );

  static const dark = AppSemanticColors(
    success: AppColors.successDark,
    successBg: Color(0xFF0F2619),
    danger: AppColors.dangerDark,
    dangerBg: Color(0xFF361413),
    flame: AppColors.flameDark,
    flameBg: Color(0xFF33210E),
    flameFill: AppColors.flameDark,
    info: AppColors.infoDark,
    infoBg: Color(0xFF0C2827),
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
    Color? flameFill,
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
      flameFill: flameFill ?? this.flameFill,
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
      flameFill: Color.lerp(flameFill, other.flameFill, t)!,
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
