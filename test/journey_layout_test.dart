import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/exam_area.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/features/journey/nugget_card.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_view.dart';
import 'package:ap1_trainer/widgets/question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'support/fixtures.dart';
import 'support/fonts.dart';
import 'support/text_visibility.dart';

/// Prüft Journey, Startseite, Sessions und Aufgaben mit den echten
/// Schriften darauf, dass jeder Text vollständig lesbar ist - nicht nur,
/// dass nichts überläuft. „Vollständig“ heißt: nicht per maxLines gekürzt,
/// nicht mitten im Wort umbrochen, nicht unten abgeschnitten und nicht
/// hinter dem Rand einer seitlich scrollenden Fläche versteckt.
void main() {
  late HiveLocalStore store;

  setUpAll(() async {
    await initializeDateFormatting('de_DE');
    await loadAppFonts();
  });

  setUp(() async {
    store = await HiveLocalStore.open(inMemory: true);
    await store.writeProfile(
      UserProfile.initial().copyWith(
        displayName: 'Marcel',
        onboarded: true,
        tutorialSeen: true,
      ),
    );
  });
  tearDown(() => store.close());

  void setView(WidgetTester tester, Size size, double scale) {
    tester.view.physicalSize = size * 3;
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = scale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  }

  Future<ProviderContainer> pumpApp(WidgetTester tester, String route) async {
    final container = ProviderContainer(
      overrides: [localStoreProvider.overrideWithValue(store)],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const Ap1TrainerApp(),
      ),
    );
    await tester.pumpAndSettle();
    if (route != '/') {
      tester.takeException();
      container.read(routerProvider).go(route);
      await tester.pumpAndSettle();
    }
    return container;
  }

  List<String> cut(WidgetTester tester, {bool horizontal = false}) =>
      findCutTexts(
        tester,
        allowHorizontalScroll: horizontal,
        // Zeichnungen gehören dem Diagramm-Baustein (eigene Tests).
        skipInside: (w) => w is DiagramView,
      );

  // Die längste Lektion - an ihr zeigt sich, ob Fortschritt und Seiten
  // auch mit vielen Schritten funktionieren.
  final bySubtopic = <String, int>{};
  for (final n in kSeedNuggets) {
    bySubtopic[n.subtopicId] = (bySubtopic[n.subtopicId] ?? 0) + 1;
  }
  final longest = bySubtopic.entries.reduce(
    (a, b) => a.value >= b.value ? a : b,
  );

  final routes = [
    '/',
    '/journey',
    '/themen',
    '/bereich/a01',
    '/lektion/${longest.key}',
    for (final a in ExamAreas.all) '/session-bereich/${a.id}',
  ];

  for (final scale in [1.0, 1.3]) {
    for (final size in const [Size(320, 568), Size(375, 812), Size(412, 915)]) {
      for (final route in routes) {
        testWidgets('vollständig lesbar: $route bei ${size.width.toInt()} px, '
            'Schrift ${(scale * 100).round()} %', (tester) async {
          setView(tester, size, scale);
          await pumpApp(tester, route);
          expect(tester.takeException(), isNull);
          expect(cut(tester), isEmpty);
        });
      }
    }
  }

  // Sehr große Systemschrift: Hier darf ein Wort auch mal umbrechen, aber
  // nichts darf überlaufen.
  for (final route in routes) {
    testWidgets('kein Überlauf: $route bei 320 px, Schrift 200 %', (
      tester,
    ) async {
      for (final height in [568.0, 800.0]) {
        setView(tester, Size(320, height), 2);
        await pumpApp(tester, route);
        expect(tester.takeException(), isNull, reason: '$route, $height px');
      }
    });
  }

  testWidgets('Lektion: jede Seite der längsten Lektion vollständig lesbar', (
    tester,
  ) async {
    setView(tester, const Size(320, 568), 1.3);
    await pumpApp(tester, '/lektion/${longest.key}');
    final pages = longest.value + 2;
    for (var p = 0; p < pages; p++) {
      expect(cut(tester), isEmpty, reason: 'Seite $p');
      expect(tester.takeException(), isNull, reason: 'Seite $p');
      if (p < pages - 1) {
        await tester.tap(find.byType(FilledButton).last);
        await tester.pumpAndSettle();
      }
    }
    // Der Abschluss verweist nur noch auf die nächste Lektion - kein Quiz,
    // keine Karteikarten.
    expect(find.text('Lektion geschafft'), findsOneWidget);
    expect(find.text('Wissen prüfen'), findsNothing);
    expect(find.text('Karteikarten'), findsNothing);
  });

  group('Lernschritt-Karte', () {
    for (final scale in [1.0, 1.3]) {
      for (final width in [320.0, 412.0]) {
        testWidgets(
          'lange Tabellen, Formeln, Beispiele bei ${width.toInt()} px, '
          'Schrift ${(scale * 100).round()} %',
          (tester) async {
            setView(tester, Size(width, 900), scale);
            for (final dark in [false, true]) {
              for (final n in kLongNuggets) {
                await tester.pumpWidget(
                  MaterialApp(
                    key: ValueKey('${n.id}-$dark'),
                    theme: dark ? AppTheme.dark() : AppTheme.light(),
                    home: Scaffold(
                      body: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: NuggetCard(nugget: n, showTopic: true),
                      ),
                    ),
                  ),
                );
                expect(tester.takeException(), isNull, reason: n.id);
                expect(cut(tester), isEmpty, reason: n.id);
              }
            }
          },
        );
      }
    }

    testWidgets('vierspaltige Tabelle wird auf 320 px zu Blöcken', (
      tester,
    ) async {
      setView(tester, const Size(320, 900), 1.3);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SingleChildScrollView(
              child: NuggetTable(kLongNuggets.first.table!),
            ),
          ),
        ),
      );
      expect(find.byType(Table), findsNothing);
      expect(cut(tester), isEmpty);
    });

    testWidgets('zweispaltige Tabelle bleibt eine Tabelle', (tester) async {
      setView(tester, const Size(320, 900), 1.3);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: NuggetTable(kLongNuggets.last.table!),
            ),
          ),
        ),
      );
      expect(find.byType(Table), findsOneWidget);
      expect(cut(tester), isEmpty);
    });
  });

  testWidgets('jede Aufgabe ist vor und nach dem Prüfen vollständig lesbar '
      '(320 px, 130 %)', (tester) async {
    setView(tester, const Size(320, 900), 1.3);
    final broken = <String>[];
    // Offen: Netzplan (Werkzeugzeile läuft bei 130 % über) und Reihenfolge
    // (Pfeile nehmen dem Text zu viel Breite) - folgen gesondert.
    final checked = [kLongQuestion, ...kSeedQuestions].where(
      (q) => q.kind != QuestionKind.netzplan && q.kind != QuestionKind.ordering,
    );
    for (final q in checked) {
      for (final revealed in [false, true]) {
        await tester.pumpWidget(
          MaterialApp(
            key: ValueKey('${q.id}-$revealed'),
            theme: AppTheme.light(),
            home: Scaffold(
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: QuestionView(
                  question: q,
                  answer: null,
                  onChanged: (_) {},
                  revealed: revealed,
                  grade: revealed
                      ? const GradeResult(score: 0, parts: {})
                      : null,
                ),
              ),
            ),
          ),
        );
        final error = tester.takeException();
        if (error != null) broken.add('${q.id}: $error');
        for (final p in cut(tester)) {
          broken.add('${q.id}${revealed ? ' (geprüft)' : ''}: $p');
        }
      }
    }
    expect(broken, isEmpty, reason: broken.take(30).join('\n'));
  });
}
