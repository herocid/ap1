// Generator, kein Test.
//
// Rendert die Beispielzeichnungen aus `test/diagram_samples.dart` mit den
// echten Schriften als PNG nach build/diagram_previews/ - zum Anschauen,
// ob jede Zeichnungsart sauber aussieht.
//
// Ausführen:
//   flutter test tool/render_diagrams_test.dart
//   flutter test tool/render_diagrams_test.dart --dart-define=only=klassen

import 'dart:io';
import 'dart:ui' as ui;

import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test/diagram_samples.dart';

const _only = String.fromEnvironment('only');

void main() {
  testWidgets('rendert Diagramm-Vorschauen', (tester) async {
    await tester.runAsync(loadDiagramFonts);
    final out = Directory('build/diagram_previews')
      ..createSync(recursive: true);

    const variants = [
      (320.0, false, 1.0),
      (412.0, true, 1.3),
      (240.0, false, 1.0),
      (260.0, false, 1.3),
      (640.0, false, 1.0),
    ];

    for (final MapEntry(key: name, value: diagram) in kDiagramSamples.entries) {
      if (_only.isNotEmpty && !name.contains(_only)) continue;
      for (final (w, dark, scale) in variants) {
        tester.view.physicalSize = Size(w + 16, 2400) * 2;
        tester.view.devicePixelRatio = 2;
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        final key = GlobalKey();
        final theme = dark ? AppTheme.dark() : AppTheme.light();
        await tester.pumpWidget(
          MaterialApp(
            key: ValueKey('$name$w$dark$scale'),
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: Scaffold(
              body: SingleChildScrollView(
                child: RepaintBoundary(
                  key: key,
                  child: Container(
                    color: theme.colorScheme.surface,
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(width: w, child: DiagramView(diagram)),
                  ),
                ),
              ),
            ),
          ),
        );
        final err = tester.takeException();
        if (err != null) {
          // ignore: avoid_print
          print('FEHLER $name @$w: $err');
        }
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 2);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final file = File(
            '${out.path}/${name}_${w.round()}_${dark ? 'dunkel' : 'hell'}_${(scale * 100).round()}.png',
          );
          file.writeAsBytesSync(bytes!.buffer.asUint8List());
        });
      }
    }
    tester.view.reset();
    tester.platformDispatcher.clearTextScaleFactorTestValue();
  });
}
