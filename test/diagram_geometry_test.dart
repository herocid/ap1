import 'dart:ui' as ui;

import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/diagram.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_style.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'diagram_samples.dart';

/// Prüft die Geometrie jeder Zeichnung mit den echten Schriften: Kein Text
/// und keine Linie ragt aus der Zeichenfläche (sonst würde abgeschnitten),
/// und keine zwei Texte überlappen sich.
///
/// Dafür wird jedes Layout auf eine Leinwand gezeichnet, die nur die
/// Umrisse aller Zeichenbefehle mitschreibt.
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await loadDiagramFonts();
  });

  final real = <String, Diagram>{
    for (final n in kSeedNuggets)
      if (n.diagram != null) n.id: n.diagram!,
    for (final q in kSeedQuestions)
      if (q.diagram != null) q.id: q.diagram!,
  };
  final all = {...kDiagramSamples, ...real};

  for (final scale in [1.0, 1.3]) {
    for (final dark in [false, true]) {
      test('Geometrie bei Schrift ${(scale * 100).round()} %, '
          '${dark ? 'dunkel' : 'hell'}', () {
        final style = DiagramStyle.fromTheme(
          dark ? AppTheme.dark() : AppTheme.light(),
          TextScaler.linear(scale),
        );
        final errors = <String>[];
        for (final w in [216.0, 236.0, 256.0, 294.0, 386.0, 614.0]) {
          for (final MapEntry(key: id, value: d) in all.entries) {
            final layout = layoutDiagram(d, style, w);
            final canvas = _BoundsCanvas();
            layout.paint(canvas);
            final area = Offset.zero & layout.size;
            final where = '$id @${w.round()}';
            if (canvas.texts.isEmpty && d is! NetzplanDiagramm) {
              errors.add('$where: keine Texte gezeichnet');
            }
            for (final (i, r) in canvas.texts.indexed) {
              if (!area.inflate(1).contains(r.topLeft) ||
                  !area.inflate(1).contains(r.bottomRight)) {
                errors.add('$where: Text $i $r ragt aus ${layout.size}');
              }
            }
            for (final r in canvas.shapes) {
              if (!area.inflate(2.5).contains(r.topLeft) ||
                  !area.inflate(2.5).contains(r.bottomRight)) {
                errors.add('$where: Form $r ragt aus ${layout.size}');
                break;
              }
            }
            final t = canvas.texts;
            for (var i = 0; i < t.length; i++) {
              for (var j = i + 1; j < t.length; j++) {
                final o = t[i].deflate(1).intersect(t[j].deflate(1));
                if (o.width > 0.5 && o.height > 0.5) {
                  errors.add(
                    '$where: Texte $i und $j überlappen (${t[i]} / ${t[j]})',
                  );
                }
              }
            }
          }
        }
        expect(errors, isEmpty, reason: errors.take(40).join('\n'));
      });
    }
  }

  test('Zeichnungen passen ab 294 px ohne seitliches Scrollen', () {
    // 294 px = 320 px Anzeige abzüglich Rahmen der Zeichnung. Einzige
    // Ausnahme bleibt der Netzplan mit vielen parallelen Vorgängen.
    final style = DiagramStyle.fromTheme(
      AppTheme.light(),
      TextScaler.noScaling,
    );
    final wide = <String>[];
    for (final MapEntry(key: id, value: d) in all.entries) {
      final layout = layoutDiagram(d, style, 294);
      if (layout.size.width > 294.5) {
        wide.add('$id: ${layout.size.width.round()} px');
      }
    }
    expect(wide, isEmpty, reason: wide.join('\n'));
  });
}

/// Leinwand, die nur die Umrisse aller Zeichenbefehle sammelt.
class _BoundsCanvas implements Canvas {
  final _stack = <Matrix4>[Matrix4.identity()];
  final texts = <Rect>[];
  final shapes = <Rect>[];

  Matrix4 get _m => _stack.last;

  void _shape(Rect r, Paint p) {
    final half = p.style == PaintingStyle.stroke ? p.strokeWidth / 2 : 0.0;
    shapes.add(MatrixUtils.transformRect(_m, r.inflate(half)));
  }

  @override
  void save() => _stack.add(_m.clone());

  @override
  void restore() {
    if (_stack.length > 1) _stack.removeLast();
  }

  @override
  void translate(double dx, double dy) => _m.translateByDouble(dx, dy, 0, 1);

  @override
  void rotate(double radians) => _m.rotateZ(radians);

  @override
  void drawParagraph(ui.Paragraph paragraph, Offset offset) {
    // Zeilenmaße ohne Leerzeichen am Zeilenende.
    final lines = paragraph.computeLineMetrics();
    if (lines.isEmpty) return;
    Rect line(ui.LineMetrics l) => Rect.fromLTWH(
      l.left,
      l.baseline - l.ascent,
      l.width,
      l.ascent + l.descent,
    );
    var r = line(lines.first);
    for (final l in lines.skip(1)) {
      r = r.expandToInclude(line(l));
    }
    texts.add(MatrixUtils.transformRect(_m, r.shift(offset)));
  }

  @override
  void drawLine(Offset p1, Offset p2, Paint paint) =>
      _shape(Rect.fromPoints(p1, p2), paint);

  @override
  void drawRect(Rect rect, Paint paint) => _shape(rect, paint);

  @override
  void drawRRect(RRect rrect, Paint paint) => _shape(rrect.outerRect, paint);

  @override
  void drawCircle(Offset c, double radius, Paint paint) =>
      _shape(Rect.fromCircle(center: c, radius: radius), paint);

  @override
  void drawOval(Rect rect, Paint paint) => _shape(rect, paint);

  @override
  void drawPath(Path path, Paint paint) => _shape(path.getBounds(), paint);

  @override
  void drawArc(
    Rect rect,
    double s,
    double sweep,
    bool useCenter,
    Paint paint,
  ) => _shape(rect, paint);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
