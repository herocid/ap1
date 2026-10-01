import 'dart:math' as math;

import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/core/util/question_selector.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:ap1_trainer/state/session_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HiveLocalStore store;
  late ProviderContainer container;

  setUp(() async {
    store = await HiveLocalStore.open(inMemory: true);
    container = ProviderContainer(
      overrides: [localStoreProvider.overrideWithValue(store)],
    );
  });
  tearDown(() async {
    container.dispose();
    await store.close();
  });

  final pool = kExamRelevantQuestions;
  final single = pool.firstWhere((q) => q.kind == QuestionKind.single);

  void startKurztest() {
    final rnd = math.Random(1);
    container
        .read(sessionProvider.notifier)
        .start(
          questions: [single],
          mode: SessionMode.uebung,
          title: 'Kurztest',
          supply: (asked) => QuestionSelector.nextEndless(pool, asked, rnd),
        );
  }

  test('nach jeder Aufgabe kommt eine neue - ohne Ende', () {
    startKurztest();
    final c = container.read(sessionProvider.notifier);
    for (var i = 0; i < 25; i++) {
      c.next();
    }
    final s = container.read(sessionProvider)!;
    expect(s.endless, isTrue);
    expect(s.items.length, 26);
    expect(s.index, 25);
    expect(
      s.items.map((i) => i.question.id).toSet().length,
      26,
      reason: 'Solange der Pool reicht, wiederholt sich nichts',
    );
  });

  test('beim Beenden zählt nur, was beantwortet wurde', () {
    startKurztest();
    final c = container.read(sessionProvider.notifier);
    c.setAnswer(<int>{0});
    c.check();
    // Weiter zur nächsten Aufgabe und mittendrin aufhören.
    c.next();
    c.finish();

    final s = container.read(sessionProvider)!;
    expect(s.finished, isTrue);
    expect(s.items.length, 1, reason: 'die offene Aufgabe fällt weg');
    expect(container.read(progressProvider).history.length, 1);
  });

  test('ohne beantwortete Aufgabe gibt es keine Auswertung', () {
    startKurztest();
    container.read(sessionProvider.notifier).finish();
    expect(container.read(sessionProvider), isNull);
  });

  test('die Zufallsauswahl erreicht alle Themen', () {
    final rnd = math.Random(7);
    final topics = <String>{};
    for (var i = 0; i < 2000; i++) {
      topics.add(QuestionSelector.nextEndless(pool, const [], rnd)!.topicId);
    }
    expect(topics, pool.map((q) => q.topicId).toSet());
  });

  test('eine normale Übung wächst nicht über ihr Ende hinaus', () {
    container
        .read(sessionProvider.notifier)
        .start(questions: [single], mode: SessionMode.uebung);
    container.read(sessionProvider.notifier).next();
    expect(container.read(sessionProvider)!.items.length, 1);
  });
}
