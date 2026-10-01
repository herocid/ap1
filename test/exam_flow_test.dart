import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/data/models/exam_case.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:ap1_trainer/state/session_controller.dart';
import 'package:ap1_trainer/widgets/hyphenation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'support/exam_fixtures.dart';

/// Spielt die Prüfungssimulation einmal komplett durch: Startbildschirm,
/// Deckblatt, Bearbeitung, Übersicht, Abgabe, Selbstbewertung, Auswertung.
/// (Die Simulation war im Web einmal nicht erreichbar - Umlaut in der Route.)
void main() {
  late HiveLocalStore store;
  setUpAll(() async => initializeDateFormatting('de_DE'));
  setUp(() async {
    store = await HiveLocalStore.open(inMemory: true);
    await store.writeProfile(
      UserProfile.initial().copyWith(onboarded: true, tutorialSeen: true),
    );
  });
  tearDown(() => store.close());

  Future<void> frames(WidgetTester tester, [int n = 12]) async {
    for (var i = 0; i < n; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<ProviderContainer> boot(
    WidgetTester tester, {
    required List<ExamCase> cases,
  }) async {
    tester.view.physicalSize = const Size(375, 812) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final container = ProviderContainer(
      overrides: [
        localStoreProvider.overrideWithValue(store),
        examCasesProvider.overrideWithValue(cases),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const Ap1TrainerApp(),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  // Getrennter Text hat einen eigenen Renderer - `find.text` sieht ihn nicht.
  Finder hyphenText(String text) =>
      find.byWidgetPredicate((w) => w is HyphenText && w.text == text);

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text).first);
    await frames(tester, 4);
    await tester.tap(find.text(text).first);
    await frames(tester);
  }

  testWidgets('Volle Prüfung: Deckblatt, Abgabe, Selbstbewertung, Ergebnis', (
    tester,
  ) async {
    final container = await boot(tester, cases: fullCaseSet());
    container.read(routerProvider).go('/pruefung');
    await tester.pumpAndSettle();
    expect(find.text('Prüfungssimulation'), findsOneWidget);
    expect(find.text('Volle Prüfung'), findsOneWidget);
    expect(find.text('Halbe Prüfung'), findsOneWidget);
    expect(find.text('Eine Aufgabe'), findsOneWidget);

    await tapText(tester, 'Volle Prüfung starten');

    // Deckblatt: Ausgangssituation des Unternehmens, die Zeit steht noch.
    var s = container.read(sessionProvider)!;
    expect(s.isExam, isTrue);
    expect(s.begun, isFalse);
    expect(s.items.length, 24);
    expect(s.possiblePoints, 100);
    expect(s.limit, const Duration(minutes: 90));
    expect(find.text('AUSGANGSSITUATION'), findsOneWidget);
    expect(hyphenText(s.paper!.company!.name), findsOneWidget);
    await frames(tester, 15);
    expect(container.read(sessionProvider)!.elapsed, Duration.zero);

    await tapText(tester, 'Beginnen (die Zeit läuft)');
    await frames(tester, 15);
    s = container.read(sessionProvider)!;
    expect(s.begun, isTrue);
    expect(s.elapsed, greaterThan(Duration.zero), reason: 'Countdown läuft');
    expect(find.text('Aufgabe 1 · a)'), findsOneWidget);
    expect(find.text('AUFGABE 1  ·  25 PUNKTE'), findsOneWidget);

    // Weiterblättern und markieren.
    await tapText(tester, 'Weiter');
    expect(find.text('Aufgabe 1 · b)'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.bookmark_outline));
    await frames(tester, 3);
    expect(container.read(sessionProvider)!.items[1].flagged, isTrue);

    // Übersicht: direkt zu Aufgabe 3 springen.
    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await frames(tester);
    expect(find.text('Übersicht'), findsOneWidget);
    expect(find.text('AUFGABE 4  ·  25 PUNKTE'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('teil-14')));
    await frames(tester, 4);
    await tester.tap(find.byKey(const ValueKey('teil-14')));
    await frames(tester);
    expect(container.read(sessionProvider)!.index, 14);
    expect(find.text('Aufgabe 3 · c)'), findsOneWidget);

    // Abgabe mit Bestätigung.
    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await frames(tester);
    await tapText(tester, 'Prüfung abgeben');
    expect(find.text('Prüfung abgeben?'), findsOneWidget);
    await tapText(tester, 'Abgeben');

    // Selbstbewertung der acht Freitext-Antworten.
    s = container.read(sessionProvider)!;
    expect(s.reviewing, isTrue);
    expect(find.text('Freitext bewerten'), findsOneWidget);
    expect(find.text('Antwort 1 von 8'), findsOneWidget);
    for (var i = 0; i < 7; i++) {
      await tapText(tester, 'Nächste Antwort');
    }
    expect(find.text('Antwort 8 von 8'), findsOneWidget);
    await tapText(tester, 'Zur Auswertung');
    await frames(tester, 20);

    // Auswertung mit Note und Aufschlüsselung.
    s = container.read(sessionProvider)!;
    expect(s.finished, isTrue);
    expect(find.text('VOLLE PRÜFUNG'), findsOneWidget);
    expect(find.text('0 von 100 Punkten'), findsOneWidget);
    expect(hyphenText('Noch nicht bestanden'), findsOneWidget);
    final history = container.read(progressProvider).history;
    expect(history, hasLength(24));
    expect(history.every((r) => r.mode == SessionMode.pruefung), isTrue);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Abbrechen: Deckblatt ohne Rückfrage, im Lauf mit Rückfrage', (
    tester,
  ) async {
    final container = await boot(tester, cases: fullCaseSet());
    container.read(routerProvider).go('/pruefung');
    await tester.pumpAndSettle();

    await tapText(tester, 'Eine Aufgabe starten');
    expect(container.read(sessionProvider)!.items.length, 6);
    await tester.tap(find.byIcon(Icons.close));
    await frames(tester);
    expect(container.read(sessionProvider), isNull);
    expect(find.text('Prüfungssimulation'), findsOneWidget);

    await tapText(tester, 'Halbe Prüfung starten');
    expect(container.read(sessionProvider)!.possiblePoints, 50);
    expect(container.read(sessionProvider)!.limit, const Duration(minutes: 45));
    await tapText(tester, 'Beginnen (die Zeit läuft)');
    await tester.tap(find.byIcon(Icons.close));
    await frames(tester);
    expect(find.text('Prüfung abbrechen?'), findsOneWidget);
    await tapText(tester, 'Beenden');
    expect(container.read(sessionProvider), isNull);
    expect(container.read(progressProvider).history, isEmpty);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('ohne Fallaufgaben: gemischte Einzelaufgaben als Ersatz', (
    tester,
  ) async {
    final container = await boot(tester, cases: const []);
    container.read(routerProvider).go('/pruefung');
    await tester.pumpAndSettle();

    await tapText(tester, 'Volle Prüfung starten');
    final s = container.read(sessionProvider)!;
    expect(s.isExam, isTrue);
    expect(s.paper!.company, isNull);
    expect(s.paper!.tasks, hasLength(4));
    expect(s.items.length, 32);
    expect(hyphenText('Gemischte Prüfungsaufgaben'), findsOneWidget);
    await tapText(tester, 'Beginnen (die Zeit läuft)');
    expect(find.text('Aufgabe 1 · a)'), findsOneWidget);

    container.read(sessionProvider.notifier).clear();
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Prüfungsaufgabe des Tages: eine Fallaufgabe ohne Zeitlimit', (
    tester,
  ) async {
    final container = await boot(tester, cases: fullCaseSet());
    container.read(routerProvider).go('/quiz');
    await tester.pumpAndSettle();
    expect(hyphenText('Prüfungsaufgabe des Tages'), findsOneWidget);

    await tapText(tester, 'Aufgabe starten');
    var s = container.read(sessionProvider)!;
    expect(s.paper!.tasks, hasLength(1));
    expect(s.possiblePoints, 25);
    expect(s.limit, isNull);
    expect(s.isExam, isFalse);
    expect(s.begun, isTrue, reason: 'kein Deckblatt');
    expect(find.text('Teilaufgabe a)'), findsOneWidget);

    container.read(sessionProvider.notifier).finish();
    await frames(tester);
    expect(find.text('Freitext bewerten'), findsOneWidget);
    await tapText(tester, 'Nächste Antwort');
    await tapText(tester, 'Zur Auswertung');
    await frames(tester, 20);
    s = container.read(sessionProvider)!;
    expect(s.finished, isTrue);
    expect(find.text('0 von 25 Punkten'), findsOneWidget);
    expect(find.text('PRÜFUNGSAUFGABE DES TAGES'), findsOneWidget);

    // Zurück im Quiz steht die Aufgabe als erledigt da.
    await tapText(tester, 'Fertig');
    await frames(tester, 10);
    expect(find.text('Noch einmal lösen'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('ohne Fallaufgaben gibt es keine Aufgabe des Tages', (
    tester,
  ) async {
    final container = await boot(tester, cases: const []);
    container.read(routerProvider).go('/quiz');
    await tester.pumpAndSettle();
    expect(hyphenText('Prüfungsaufgabe des Tages'), findsOneWidget);
    expect(find.text('Aufgabe starten'), findsNothing);
    expect(find.text('Schwächen-Training'), findsOneWidget);
    expect(find.text('Fehler wiederholen'), findsOneWidget);
    expect(find.text('Kurztest'), findsOneWidget);
    expect(find.text('Prüfung simulieren'), findsOneWidget);
  });
}
