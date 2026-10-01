import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/features/cards/card_session_screen.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Die Lernrunde: Nicht Gewusstes kommt in derselben Runde wieder, der
/// Kasten zählt nur die erste Antwort, der Durchlauf merkt sich alles.
void main() {
  late HiveLocalStore store;

  setUp(() async => store = await HiveLocalStore.open(inMemory: true));
  tearDown(() => store.close());

  const cards = [
    Flashcard(
      id: 'a',
      topicId: 'netzplan',
      front: 'Frage A',
      back: 'Antwort A lang genug',
    ),
    Flashcard(
      id: 'b',
      topicId: 'netzplan',
      front: 'Frage B',
      back: 'Antwort B lang genug',
    ),
  ];

  Future<ProviderContainer> pump(
    WidgetTester tester,
    CardSessionArgs args,
  ) async {
    final container = ProviderContainer(
      overrides: [
        localStoreProvider.overrideWithValue(store),
        flashcardsProvider.overrideWithValue(cards),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: CardSessionScreen(args: args),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> answer(WidgetTester tester, {required bool knewIt}) async {
    await tester.tap(find.text('Umdrehen'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(knewIt ? 'Wusste ich' : 'Nochmal'));
    await tester.pumpAndSettle();
  }

  testWidgets('nicht gewusste Karte kommt in derselben Runde wieder', (
    tester,
  ) async {
    final c = await pump(
      tester,
      const CardSessionArgs(mode: CardMode.practice, cardIds: ['a', 'b']),
    );

    expect(find.text('Frage A'), findsOneWidget);
    await answer(tester, knewIt: false);
    // B kommt dazwischen, danach A als Wiederholung.
    expect(find.text('Frage B'), findsOneWidget);
    await answer(tester, knewIt: true);
    expect(find.text('Frage A'), findsOneWidget);
    expect(find.text('Wiederholung'), findsOneWidget);
    await answer(tester, knewIt: true);

    expect(find.text('Runde beendet'), findsOneWidget);
    expect(find.text('nachgelernt'), findsOneWidget);
    // Für den Kasten zählt nur die erste Antwort: A bleibt in Fach 1.
    final deck = c.read(deckProvider);
    expect(deck.stateOf('a').box, 1);
    expect(deck.stateOf('a').timesWrong, 1);
    expect(deck.stateOf('a').timesCorrect, 0);
    expect(deck.stateOf('b').box, 2);
    expect(c.read(cardActivityProvider).totalReviews, 3);
  });

  testWidgets('Durchlauf endet erst, wenn alles gewusst wurde', (tester) async {
    await store.writeCardRun(
      CardRun(
        title: 'Alle',
        cardIds: const ['a', 'b'],
        startedAt: DateTime(2026),
      ),
    );
    final c = await pump(
      tester,
      const CardSessionArgs(mode: CardMode.run, title: 'Alle'),
    );

    await answer(tester, knewIt: true);
    await answer(tester, knewIt: false);
    expect(c.read(cardRunProvider)!.remainingCount, 1);
    await answer(tester, knewIt: true);

    expect(c.read(cardRunProvider)!.isDone, isTrue);
    expect(find.text('Durchlauf geschafft'), findsOneWidget);
  });
}
