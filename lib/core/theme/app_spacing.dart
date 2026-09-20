/// 4pt-Raster. Alle Abstände im Projekt kommen aus dieser Skala - das ist der
/// billigste Weg zu einem ruhigen Layout, ohne dass irgendwo "mal eben 13px"
/// landen.
class Gap {
  const Gap._();
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

class Radii {
  const Radii._();
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double pill = 999;
}

/// Breakpoints. Die App ist eine Codebase für Touch *und* Desktop/Web;
/// ab [medium] wechseln Listen auf zweispaltige Layouts und die Navigation
/// wandert von der BottomBar in eine NavigationRail.
class Breakpoints {
  const Breakpoints._();
  static const double compact = 600;
  static const double medium = 900;
  static const double wide = 1200;
}
