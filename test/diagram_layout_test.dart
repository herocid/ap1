import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/diagram.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_description.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_style.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'diagram_samples.dart';

/// Rendert jede Zeichnungsart (Beispiele aus `diagram_samples.dart`) und
/// alle echten Zeichnungen aus Lernschritten und Aufgaben in schmalen und
/// breiten Layouts, mit normaler und vergrößerter Schrift, hell und
/// dunkel. Es darf keine Exception und keinen Überlauf geben.
void main() {
  final real = <String, Diagram>{
    for (final n in kSeedNuggets)
      if (n.diagram != null) n.id: n.diagram!,
    for (final q in kSeedQuestions)
      if (q.diagram != null) q.id: q.diagram!,
  };

  test('jede Zeichnungsart hat ein Beispiel', () {
    final types = kDiagramSamples.values.map((d) => d.type).toSet();
    expect(
      types,
      containsAll(<String>[
        'stapel',
        'fluss',
        'baum',
        'sequenz',
        'quadranten',
        'balken',
        'gantt',
        'geraden',
        'klassen',
        'erm',
        'usecase',
        'netz',
        'bits',
        'netzplan',
        'netzplan_legende',
      ]),
    );
  });

  test('jede Zeichnung hat eine Textfassung für Screenreader', () {
    for (final e in {...kDiagramSamples, ...real}.entries) {
      expect(describeDiagram(e.value).length, greaterThan(20), reason: e.key);
    }
  });

  test('Zahlen in deutscher Schreibweise', () {
    expect(formatZahl(0), '0');
    expect(formatZahl(1500), '1.500');
    expect(formatZahl(40000), '40.000');
    expect(formatZahl(8.15), '8,15');
    expect(formatZahl(62.5), '62,5');
    expect(formatZahl(1234567.5), '1.234.567,5');
    expect(mitEinheit(7.4, 'Punkte'), '7,4 Punkte');
    expect(niceStep(60000, 6), 10000);
    expect(niceStep(1500, 4), 500);
  });

  for (final dark in [false, true]) {
    for (final scale in [1.0, 1.3]) {
      for (final width in [240.0, 280.0, 320.0, 412.0]) {
        final name =
            '${width.round()} px, Schrift ${(scale * 100).round()} %, '
            '${dark ? 'dunkel' : 'hell'}';

        testWidgets('Beispielzeichnungen: $name', (tester) async {
          final broken = await _renderAll(
            tester,
            kDiagramSamples,
            width,
            scale,
            dark,
          );
          expect(broken, isEmpty, reason: broken.join('\n'));
        });

        testWidgets('Zeichnungen aus den Inhalten: $name', (tester) async {
          final broken = await _renderAll(tester, real, width, scale, dark);
          expect(broken, isEmpty, reason: broken.join('\n'));
        });
      }
    }
  }

  testWidgets('Layout wird bei unverändertem Neuaufbau nicht neu berechnet', (
    tester,
  ) async {
    final d = kDiagramSamples['netzplan_projekt']!;
    Widget app(Key k) => MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(key: k, width: 320, child: DiagramView(d)),
        ),
      ),
    );
    await tester.pumpWidget(app(const ValueKey(1)));
    final before = tester.renderObject<RenderCustomPaint>(
      find
          .descendant(
            of: find.byType(DiagramView),
            matching: find.byType(CustomPaint),
          )
          .last,
    );
    final painter = before.painter;
    await tester.pumpWidget(app(const ValueKey(1)));
    final after = tester.renderObject<RenderCustomPaint>(
      find
          .descendant(
            of: find.byType(DiagramView),
            matching: find.byType(CustomPaint),
          )
          .last,
    );
    expect(after.painter!.shouldRepaint(painter!), isFalse);
  });
}

Future<List<String>> _renderAll(
  WidgetTester tester,
  Map<String, Diagram> diagrams,
  double width,
  double scale,
  bool dark,
) async {
  tester.view.physicalSize = Size(width + 32, 1600) * 2;
  tester.view.devicePixelRatio = 2;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

  final broken = <String>[];
  for (final MapEntry(key: id, value: d) in diagrams.entries) {
    // Eigener Key je Zeichnung, damit Überläufe jedes Mal gemeldet werden.
    await tester.pumpWidget(
      MaterialApp(
        key: ValueKey('$id-$width-$scale-$dark'),
        theme: dark ? AppTheme.dark() : AppTheme.light(),
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SizedBox(width: width, child: DiagramView(d)),
          ),
        ),
      ),
    );
    final error = tester.takeException();
    if (error != null) broken.add('$id: $error');
  }
  return broken;
}
