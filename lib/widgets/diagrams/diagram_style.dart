import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Farben, Schriften und Textskalierung einer Zeichnung.
///
/// Wird einmal pro Build aus dem Theme gelesen und an Layout und Painter
/// weitergereicht. Gleichheit über die Werte, damit zwischengespeicherte
/// Layouts und `shouldRepaint` nur bei echten Änderungen neu rechnen.
@immutable
class DiagramStyle {
  const DiagramStyle({
    required this.ink,
    required this.muted,
    required this.line,
    required this.grid,
    required this.surface,
    required this.surfaceAlt,
    required this.accent,
    required this.accentBg,
    required this.onAccent,
    required this.hot,
    required this.hotBg,
    required this.info,
    required this.infoBg,
    required this.success,
    required this.danger,
    required this.textScaler,
  });

  factory DiagramStyle.of(BuildContext context) => DiagramStyle.fromTheme(
    Theme.of(context),
    MediaQuery.textScalerOf(context),
  );

  factory DiagramStyle.fromTheme(ThemeData theme, TextScaler textScaler) {
    final s = theme.colorScheme;
    final c = theme.extension<AppSemanticColors>()!;
    return DiagramStyle(
      ink: s.onSurface,
      muted: c.textMuted,
      line: Color.lerp(c.textMuted, s.onSurface, 0.25)!,
      grid: c.border,
      surface: s.surface,
      surfaceAlt: c.surfaceAlt,
      accent: s.primary,
      accentBg: s.primaryContainer,
      onAccent: s.onPrimary,
      hot: c.flame,
      hotBg: c.flameBg,
      info: c.info,
      infoBg: c.infoBg,
      success: c.success,
      danger: c.danger,
      textScaler: textScaler,
    );
  }

  /// Text, Umrisse.
  final Color ink;

  /// Nebentext, Achsenbeschriftung.
  final Color muted;

  /// Verbindungslinien und Pfeile.
  final Color line;

  /// Raster, Trennlinien, Hilfslinien.
  final Color grid;
  final Color surface;
  final Color surfaceAlt;

  /// Markenblau: Hervorhebung, Netzanteil, Balken.
  final Color accent;
  final Color accentBg;
  final Color onAccent;

  /// Orange: kritischer Pfad, hervorgehobene Werte.
  final Color hot;
  final Color hotBg;
  final Color info;
  final Color infoBg;
  final Color success;
  final Color danger;
  final TextScaler textScaler;

  /// Reihenfolge für mehrere Datenreihen (Geraden).
  List<Color> get series => [accent, hot, info, success, danger, muted];

  /// Skaliert eine Länge, die an Textgröße gebunden ist.
  double sc(double v) => textScaler.scale(v);

  // ------------------------------------------------------------ Schriften

  TextStyle label({
    double size = 12.5,
    FontWeight weight = FontWeight.w500,
    Color? color,
  }) => TextStyle(
    fontFamily: kFontSans,
    fontSize: size,
    height: 1.3,
    fontWeight: weight,
    color: color ?? ink,
  );

  TextStyle title({double size = 13, Color? color}) =>
      label(size: size, weight: FontWeight.w700, color: color);

  TextStyle small({Color? color, FontWeight weight = FontWeight.w500}) =>
      label(size: 11, weight: weight, color: color ?? muted);

  TextStyle numeric({
    double size = 12,
    FontWeight weight = FontWeight.w600,
    Color? color,
  }) => TextStyle(
    fontFamily: kFontSans,
    fontSize: size,
    height: 1.25,
    fontWeight: weight,
    color: color ?? ink,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  TextStyle mono({double size = 11.5, Color? color, FontWeight? weight}) =>
      TextStyle(
        fontFamily: kFontMono,
        fontSize: size,
        height: 1.35,
        fontWeight: weight,
        color: color ?? ink,
      );

  // ---------------------------------------------------------------- Text

  /// Legt [text] mit der Textskalierung des Geräts aus. Ohne [maxWidth]
  /// einzeilig; mit [maxWidth] umbrechend, aber nie schmaler als das
  /// längste Wort - Wörter werden nicht mitten im Wort getrennt.
  TextPainter text(
    String text,
    TextStyle style, {
    double? maxWidth,
    TextAlign align = TextAlign.left,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: align,
      textScaler: textScaler,
    );
    if (maxWidth == null) {
      tp.layout();
      return tp;
    }
    final w = math.max(maxWidth, longestWord(text, style));
    tp.layout(maxWidth: w);
    // Auf die tatsächlich benutzte Breite verkleinern, damit zentrierter
    // Text wirklich mittig sitzt.
    final used = tp.width;
    if (align != TextAlign.left && used < w) tp.layout(maxWidth: used);
    return tp;
  }

  /// Verkleinert [style] (höchstens auf [min]), bis das längste Wort von
  /// [text] in [maxWidth] passt. Lange Komposita wie
  /// „Datenhaltungsschicht“ sollen nicht über den Kasten hinausragen.
  TextStyle fit(
    String text,
    TextStyle style,
    double maxWidth, {
    double min = 0.8,
  }) {
    final need = longestWord(text, style);
    if (need <= maxWidth || maxWidth <= 0) return style;
    final f = math.max(min, maxWidth / need);
    return style.copyWith(fontSize: (style.fontSize ?? 14) * f);
  }

  /// Breite des längsten Wortes (Zeilenumbruch nur an Leerzeichen).
  double longestWord(String text, TextStyle style) {
    var best = 0.0;
    // Umbruch ist an Leerzeichen und nach Bindestrichen möglich.
    for (final w in text.split(RegExp(r'\s+|(?<=-)'))) {
      if (w.isEmpty) continue;
      final tp = TextPainter(
        text: TextSpan(text: w, style: style),
        textDirection: TextDirection.ltr,
        textScaler: textScaler,
      )..layout();
      best = math.max(best, tp.width);
    }
    return best.ceilToDouble() + 1;
  }

  @override
  bool operator ==(Object other) =>
      other is DiagramStyle &&
      other.ink == ink &&
      other.muted == muted &&
      other.line == line &&
      other.grid == grid &&
      other.surface == surface &&
      other.surfaceAlt == surfaceAlt &&
      other.accent == accent &&
      other.accentBg == accentBg &&
      other.onAccent == onAccent &&
      other.hot == hot &&
      other.hotBg == hotBg &&
      other.info == info &&
      other.infoBg == infoBg &&
      other.success == success &&
      other.danger == danger &&
      other.textScaler == textScaler;

  @override
  int get hashCode => Object.hash(
    ink,
    muted,
    line,
    grid,
    surface,
    surfaceAlt,
    accent,
    accentBg,
    hot,
    hotBg,
    info,
    success,
    danger,
    textScaler,
  );
}

// ------------------------------------------------------------------ Zahlen

/// Zahl in deutscher Schreibweise: Tausenderpunkt, Dezimalkomma, höchstens
/// zwei Nachkommastellen, keine überflüssigen Nullen.
String formatZahl(double v) {
  final neg = v < 0;
  var s = v.abs().toStringAsFixed(2);
  if (s.contains('.')) {
    s = s.replaceFirst(RegExp(r'0+$'), '');
    if (s.endsWith('.')) s = s.substring(0, s.length - 1);
  }
  final parts = s.split('.');
  final ganz = parts[0];
  final buf = StringBuffer();
  for (var i = 0; i < ganz.length; i++) {
    if (i > 0 && (ganz.length - i) % 3 == 0) buf.write('.');
    buf.write(ganz[i]);
  }
  if (parts.length > 1) buf.write(',${parts[1]}');
  return '${neg ? '−' : ''}$buf';
}

/// Zahl mit Einheit; „%“ und Einheiten mit Leerzeichen, wie im Duden.
String mitEinheit(double v, String? einheit) {
  if (einheit == null || einheit.isEmpty) return formatZahl(v);
  return '${formatZahl(v)} $einheit';
}

/// „Schöne“ Schrittweite für eine Achse (1, 2, 2,5, 5 mal 10^n), sodass
/// etwa [ziel] Abschnitte entstehen.
double niceStep(double range, int ziel) {
  if (range <= 0) return 1;
  final roh = range / math.max(1, ziel);
  final exp = math.pow(10, (math.log(roh) / math.ln10).floor()).toDouble();
  final f = roh / exp;
  final nice = f <= 1
      ? 1.0
      : f <= 2
      ? 2.0
      : f <= 2.5
      ? 2.5
      : f <= 5
      ? 5.0
      : 10.0;
  return nice * exp;
}

// ---------------------------------------------------------- Zeichenhilfen

Paint strokePaint(Color c, [double w = 1.4]) => Paint()
  ..color = c
  ..style = PaintingStyle.stroke
  ..strokeWidth = w
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..isAntiAlias = true;

Paint fillPaint(Color c) => Paint()
  ..color = c
  ..style = PaintingStyle.fill
  ..isAntiAlias = true;

/// Zerlegt [source] in Striche der Länge [dash] mit Lücken [gap].
Path dashPath(Path source, {double dash = 5, double gap = 4}) {
  final out = Path();
  for (final m in source.computeMetrics()) {
    var d = 0.0;
    while (d < m.length) {
      final len = math.min(dash, m.length - d);
      out.addPath(m.extractPath(d, d + len), Offset.zero);
      d += dash + gap;
    }
  }
  return out;
}

void drawDashedLine(
  Canvas canvas,
  Offset a,
  Offset b,
  Paint paint, {
  double dash = 5,
  double gap = 4,
}) {
  canvas.drawPath(
    dashPath(
      Path()
        ..moveTo(a.dx, a.dy)
        ..lineTo(b.dx, b.dy),
      dash: dash,
      gap: gap,
    ),
    paint,
  );
}

enum ArrowHead {
  none,
  open,
  filled,
  hollowTriangle,
  hollowDiamond,
  filledDiamond,
}

/// Zeichnet eine Spitze an [tip]; [from] gibt die Richtung der Linie an
/// (die Spitze zeigt von [from] nach [tip]). Liefert den Punkt, an dem die
/// Linie enden soll (bei Rauten und gefüllten Spitzen deren Rückseite).
Offset drawHead(
  Canvas canvas,
  Offset from,
  Offset tip,
  ArrowHead head,
  Color color, {
  double size = 9,
  double strokeWidth = 1.4,
  Color? fill,
}) {
  if (head == ArrowHead.none) return tip;
  final dir = tip - from;
  final len = dir.distance;
  if (len == 0) return tip;
  final u = dir / len;
  final n = Offset(-u.dy, u.dx);
  switch (head) {
    case ArrowHead.none:
      return tip;
    case ArrowHead.open:
      final a = tip - u * size + n * (size * 0.55);
      final b = tip - u * size - n * (size * 0.55);
      canvas.drawPath(
        Path()
          ..moveTo(a.dx, a.dy)
          ..lineTo(tip.dx, tip.dy)
          ..lineTo(b.dx, b.dy),
        strokePaint(color, strokeWidth),
      );
      return tip;
    case ArrowHead.filled:
    case ArrowHead.hollowTriangle:
      final a = tip - u * size + n * (size * 0.5);
      final b = tip - u * size - n * (size * 0.5);
      final p = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(a.dx, a.dy)
        ..lineTo(b.dx, b.dy)
        ..close();
      if (head == ArrowHead.filled) {
        canvas.drawPath(p, fillPaint(color));
      } else {
        canvas.drawPath(p, fillPaint(fill ?? Colors.transparent));
        canvas.drawPath(p, strokePaint(color, strokeWidth));
      }
      return tip - u * size;
    case ArrowHead.hollowDiamond:
    case ArrowHead.filledDiamond:
      final l = size * 1.5;
      final w = size * 0.5;
      final mid = tip - u * (l / 2);
      final back = tip - u * l;
      final p = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(mid.dx + n.dx * w, mid.dy + n.dy * w)
        ..lineTo(back.dx, back.dy)
        ..lineTo(mid.dx - n.dx * w, mid.dy - n.dy * w)
        ..close();
      if (head == ArrowHead.filledDiamond) {
        canvas.drawPath(p, fillPaint(color));
      } else {
        canvas.drawPath(p, fillPaint(fill ?? Colors.transparent));
      }
      canvas.drawPath(p, strokePaint(color, strokeWidth));
      return back;
  }
}

/// Text mit hinterlegter Fläche in [bg], damit Linien darunter nicht
/// durch die Schrift laufen.
void paintLabel(
  Canvas canvas,
  TextPainter tp,
  Offset topLeft,
  Color bg, {
  double padX = 3,
  double padY = 1,
  double radius = 4,
}) {
  final r = Rect.fromLTWH(
    topLeft.dx - padX,
    topLeft.dy - padY,
    tp.width + 2 * padX,
    tp.height + 2 * padY,
  );
  canvas.drawRRect(
    RRect.fromRectAndRadius(r, Radius.circular(radius)),
    fillPaint(bg),
  );
  tp.paint(canvas, topLeft);
}

/// Schnittpunkt der Strecke vom Mittelpunkt eines Rechtecks in Richtung
/// [toward] mit dessen Rand.
Offset rectEdgePoint(Rect r, Offset toward) {
  final c = r.center;
  final d = toward - c;
  if (d.dx == 0 && d.dy == 0) return c;
  final sx = d.dx == 0 ? double.infinity : (r.width / 2) / d.dx.abs();
  final sy = d.dy == 0 ? double.infinity : (r.height / 2) / d.dy.abs();
  final s = math.min(sx, sy);
  return c + d * s;
}

/// Schnittpunkt vom Mittelpunkt einer Ellipse in Richtung [toward] mit
/// ihrem Rand.
Offset ellipseEdgePoint(Rect r, Offset toward) {
  final c = r.center;
  final d = toward - c;
  if (d.dx == 0 && d.dy == 0) return c;
  final a = r.width / 2;
  final b = r.height / 2;
  final t = 1 / math.sqrt((d.dx * d.dx) / (a * a) + (d.dy * d.dy) / (b * b));
  return c + d * t;
}

/// Schnittpunkt einer Raute (Mittelpunkt, halbe Diagonalen) in Richtung
/// [toward].
Offset diamondEdgePoint(Rect r, Offset toward) {
  final c = r.center;
  final d = toward - c;
  if (d.dx == 0 && d.dy == 0) return c;
  final a = r.width / 2;
  final b = r.height / 2;
  final t = 1 / (d.dx.abs() / a + d.dy.abs() / b);
  return c + d * t;
}

Path diamondPath(Rect r) => Path()
  ..moveTo(r.center.dx, r.top)
  ..lineTo(r.right, r.center.dy)
  ..lineTo(r.center.dx, r.bottom)
  ..lineTo(r.left, r.center.dy)
  ..close();
