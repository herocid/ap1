import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/seed/cards/cards_data.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Rendert jeden Hauptscreen auf typischen Handygrößen. Flutter lässt den
/// Test bei jedem Layout-Überlauf fehlschlagen - abgeschnittene oder
/// überlaufende Inhalte fallen so vor dem Store-Release auf, nicht danach.
void main() {
  late HiveLocalStore store;

  setUpAll(() async => initializeDateFormatting('de_DE'));

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

  const routes = [
    '/',
    '/themen',
    '/journey',
    '/quiz',
    '/einfuehrung',
    '/lektion/n-vorwaerts',
    '/karten',
    '/statistik',
    '/einstellungen',
    '/pruefung',
    // Ohne laufende Prüfung der Leerzustand - Deckblatt, Lauf, Bewertung und
    // Auswertung prüft `exam_layout_test.dart` mit Test-Fallaufgaben.
    '/pruefung-lauf',
    '/karten-lernen',
    '/karten-auswahl',
    '/bereich/a01',
    '/katalog-aenderungen',
  ];

  // Kleinstes verbreitetes Handy (iPhone SE) und ein typisches Android -
  // jeweils mit normaler und mit vergrößerter Systemschrift (Barrierefreiheit).
  const sizes = [Size(320, 568), Size(375, 812), Size(412, 915)];
  const textScales = [1.0, 1.3];

  for (final scale in textScales) {
    for (final size in sizes) {
      for (final route in routes) {
        testWidgets('$route bei ${size.width.toInt()}×${size.height.toInt()}, '
            'Schrift ${(scale * 100).round()} %', (tester) async {
          tester.view.physicalSize = size * 3;
          tester.view.devicePixelRatio = 3;
          tester.platformDispatcher.textScaleFactorTestValue = scale;
          addTearDown(tester.view.reset);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

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
          // Die App startet immer auf "/". Deren Fehler prüft der Fall "/"
          // selbst - hier sollen sie den Befund für andere Screens nicht
          // überdecken.
          if (route != '/') tester.takeException();

          container.read(routerProvider).go(route);
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
        });
      }
    }
  }

  // Karteikasten und Statistik mit Lernstand: Durchlauf, Schwächen,
  // Aktivität - die Leerzustände oben zeigen diese Teile gar nicht.
  group('mit Kartenfortschritt', () {
    setUp(() async {
      final now = DateTime.now();
      await store.appendAnswers([
        AnswerRecord(
          questionId: 'q1',
          topicId: 'netzplan',
          score: 1,
          seconds: 30,
          at: now,
          mode: SessionMode.uebung,
        ),
      ]);
      var deck = const DeckState();
      var activity = const CardActivity();
      for (final (i, c) in kSeedFlashcards.take(60).indexed) {
        deck = deck.withAnswer(c.id, i % 3 != 0, now: now);
        activity = activity.withAnswer(knewIt: i % 3 != 0, now: now);
      }
      for (final s in deck.cards.values) {
        await store.writeCardState(s);
      }
      await store.writeCardActivity(activity);
      var run = CardRun(
        title: 'Informations- und Softwaresysteme mit langem Namen',
        cardIds: [for (final c in kSeedFlashcards.take(80)) c.id],
        startedAt: now,
      );
      for (final (i, c) in kSeedFlashcards.take(30).indexed) {
        run = run.withAnswer(c.id, knewIt: i.isEven);
      }
      await store.writeCardRun(run);
    });

    for (final scale in textScales) {
      for (final route in ['/karten', '/statistik', '/karten-auswahl']) {
        testWidgets('$route bei 320 px, Schrift ${(scale * 100).round()} %', (
          tester,
        ) async {
          tester.view.physicalSize = sizes.first * 3;
          tester.view.devicePixelRatio = 3;
          tester.platformDispatcher.textScaleFactorTestValue = scale;
          addTearDown(tester.view.reset);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

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
          tester.takeException();
          container.read(routerProvider).go(route);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);

          // Themenauswahl: einen Bereich aufklappen und ankreuzen.
          if (route == '/karten-auswahl') {
            await tester.tap(find.byType(ExpansionTile).first);
            await tester.pumpAndSettle();
            await tester.tap(find.byType(Checkbox).first);
            await tester.pumpAndSettle();
            expect(tester.takeException(), isNull);
          }
        });
      }
    }
  });

  // Einführung: jede Seite einmal, auf dem kleinsten Handy mit großer Schrift.
  testWidgets('Einführung: alle Seiten bei 320 px, Schrift 130 %', (
    tester,
  ) async {
    tester.view.physicalSize = sizes.first * 3;
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
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
    tester.takeException();
    container.read(routerProvider).go('/einfuehrung');
    await tester.pumpAndSettle();
    var pages = 1;
    while (find.text('Weiter').evaluate().isNotEmpty) {
      await tester.tap(find.text('Weiter'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'Seite ${pages + 1}');
      pages++;
    }
    expect(find.text('Los geht’s'), findsOneWidget);
    expect(pages, greaterThanOrEqualTo(8));
  });
}
