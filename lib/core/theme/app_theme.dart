import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Familiennamen aus pubspec.yaml. Die Dateien liegen in assets/fonts.
const String kFontSans = 'Inter';
const String kFontMono = 'JetBrainsMono';

/// Das Theme ist bewusst leise: wenig Schatten, keine Verläufe in der Fläche,
/// hoher Textkontrast. Die einzigen kräftigen Farbflächen sind Fortschritt,
/// Streak und Feedback - also genau dort, wo die Aufmerksamkeit hin soll.
class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.brand,
          brightness: brightness,
        ).copyWith(
          primary: isDark ? AppColors.brandDark : AppColors.brand,
          onPrimary: isDark ? const Color(0xFF0A1830) : Colors.white,
          // fromSeed leitet Neben- und Containertöne selbst ab - die können
          // stichig ausfallen (z. B. ausgewählte Chips). Deshalb alles,
          // was Material-Widgets von selbst benutzen, explizit aus der Palette.
          primaryContainer: isDark
              ? const Color(0xFF1B3A66)
              : const Color(0xFFE1ECFB),
          onPrimaryContainer: isDark ? AppColors.darkText : AppColors.brand,
          secondary: isDark ? AppColors.brandDark : AppColors.brand,
          onSecondary: isDark ? const Color(0xFF0A1830) : Colors.white,
          secondaryContainer: isDark
              ? const Color(0xFF1B3A66)
              : const Color(0xFFE1ECFB),
          onSecondaryContainer: isDark ? AppColors.darkText : AppColors.brand,
          tertiary: isDark ? AppColors.flameDark : AppColors.flame,
          onTertiary: isDark ? const Color(0xFF2A1500) : Colors.white,
          surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          onSurface: isDark ? AppColors.darkText : AppColors.lightText,
          onSurfaceVariant: isDark
              ? AppColors.darkTextMuted
              : AppColors.lightTextMuted,
          surfaceContainerHighest: isDark
              ? AppColors.darkSurfaceAlt
              : AppColors.lightSurfaceAlt,
          error: isDark ? AppColors.dangerDark : AppColors.danger,
          outline: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          outlineVariant: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        );

    final baseText = isDark
        ? Typography.whiteMountainView
        : Typography.blackMountainView;

    // Inter für die gesamte UI. Zahlenlastige Stellen (Timer, Netzplan)
    // benutzen zusätzlich AppType.numeric mit Tabellenziffern, damit beim
    // Hochzählen nichts springt.
    final textTheme = baseText
        .apply(
          fontFamily: kFontSans,
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        )
        .copyWith(
          displaySmall: TextStyle(
            fontFamily: kFontSans,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
            color: scheme.onSurface,
          ),
          headlineSmall: TextStyle(
            fontFamily: kFontSans,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
            color: scheme.onSurface,
          ),
          titleLarge: TextStyle(
            fontFamily: kFontSans,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
            color: scheme.onSurface,
          ),
          titleMedium: TextStyle(
            fontFamily: kFontSans,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
          bodyLarge: TextStyle(
            fontFamily: kFontSans,
            fontSize: 16,
            height: 1.55,
            color: scheme.onSurface,
          ),
          bodyMedium: TextStyle(
            fontFamily: kFontSans,
            fontSize: 14.5,
            height: 1.55,
            color: scheme.onSurface,
          ),
          labelLarge: const TextStyle(
            fontFamily: kFontSans,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          labelSmall: const TextStyle(
            fontFamily: kFontSans,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        );

    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return ThemeData(
      useMaterial3: true,
      fontFamily: kFontSans,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      textTheme: textTheme,
      extensions: [isDark ? AppSemanticColors.dark : AppSemanticColors.light],
      // Ein ruhiger Überblendeffekt auf allen Plattformen statt des
      // harten Einschiebens von unten (Android) bzw. rechts (Web).
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          for (final p in TargetPlatform.values)
            p: const FadeForwardsPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.l),
          side: BorderSide(color: border),
        ),
      ),
      dividerTheme: DividerThemeData(color: border, space: 1, thickness: 1),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: Gap.xl),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.m),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: Gap.xl),
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.m),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(0, 44),
          textStyle: textTheme.labelLarge,
        ),
      ),
      chipTheme: ChipThemeData(
        side: BorderSide(color: border),
        backgroundColor: isDark
            ? AppColors.darkSurfaceAlt
            : AppColors.lightSurfaceAlt,
        labelStyle: textTheme.labelSmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Gap.l,
          vertical: Gap.l,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.m),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.m),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.m),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
        height: 68,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelSmall!.copyWith(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        indicatorColor: scheme.primaryContainer,
        selectedLabelTextStyle: textTheme.labelSmall!.copyWith(
          color: scheme.primary,
        ),
        unselectedLabelTextStyle: textTheme.labelSmall!.copyWith(
          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.xl)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        // Etwas breiter und mit knapperem Rand für die Knöpfe: Sonst
        // rutschen „Weitermachen“ und „Beenden“ auf schmalen Handys
        // versetzt untereinander.
        insetPadding: const EdgeInsets.symmetric(
          horizontal: Gap.l,
          vertical: Gap.xl,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.l),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.m),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        linearTrackColor: isDark
            ? AppColors.darkSurfaceAlt
            : AppColors.lightSurfaceAlt,
        linearMinHeight: 8,
      ),
    );
  }
}

/// Textstile, die das Material-TextTheme nicht abdeckt.
class AppType {
  const AppType._();

  /// Tabellenziffern: gleiche Breite pro Ziffer. Pflicht für Timer,
  /// Netzplan-Zellen und Prozentanzeigen.
  static TextStyle numeric({
    double size = 16,
    FontWeight weight = FontWeight.w600,
    Color? color,
  }) => TextStyle(
    fontFamily: kFontSans,
    fontSize: size,
    fontWeight: weight,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  /// Monospace für Code-nahe Inhalte (z.B. Pseudocode in Aufgaben).
  static TextStyle mono({double size = 14, Color? color}) => TextStyle(
    fontFamily: kFontMono,
    fontSize: size,
    height: 1.5,
    color: color,
  );
}
