import 'package:ap1_trainer/core/util/feed_order.dart';
import 'package:ap1_trainer/core/util/question_selector.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Querbeet', () {
    final mix = QuestionSelector.forMix(pool: kSeedQuestions, count: 15, seed: 7);

    test('liefert die gewünschte Anzahl ohne Doppelte', () {
      expect(mix, hasLength(15));
      expect(mix.map((q) => q.id).toSet(), hasLength(15));
    });

    test('nimmt nur prüfungsrelevante Aufgaben', () {
      expect(mix.every((q) => q.isExamRelevant), isTrue);
    });

    test('streut über viele Themen statt eines zu wiederholen', () {
      final topics = kExamRelevantQuestions.map((q) => q.topicId).toSet();
      // Reihum gezogen: jedes Thema kommt einmal dran, bevor sich eins
      // wiederholt.
      final expected = topics.length < 15 ? topics.length : 15;
      expect(mix.map((q) => q.topicId).toSet().length, expected);
    });
  });

  group('Feed-Reihenfolge', () {
    test('enthält jeden Beitrag genau einmal', () {
      final round = FeedOrder.round(kSeedNuggets, seed: 20260930);
      expect(round.map((n) => n.id).toSet(),
          kSeedNuggets.map((n) => n.id).toSet());
      expect(round, hasLength(kSeedNuggets.length));
    });

    test('zwei Beiträge desselben Themas stehen nicht nebeneinander, '
        'solange genug andere da sind', () {
      final round = FeedOrder.round(kSeedNuggets, seed: 20260930);
      var clashes = 0;
      for (var i = 1; i < round.length; i++) {
        if (round[i].topicId == round[i - 1].topicId) clashes++;
      }
      expect(clashes, lessThanOrEqualTo(1));
    });

    test('ist über den Tag stabil und am nächsten Tag anders', () {
      final a = FeedOrder.round(kSeedNuggets, seed: FeedOrder.daySeed(DateTime(2026, 9, 30, 8)));
      final b = FeedOrder.round(kSeedNuggets, seed: FeedOrder.daySeed(DateTime(2026, 9, 30, 22)));
      final c = FeedOrder.round(kSeedNuggets, seed: FeedOrder.daySeed(DateTime(2026, 10, 1)));
      expect(a.map((n) => n.id), b.map((n) => n.id));
      expect(a.map((n) => n.id), isNot(c.map((n) => n.id)));
    });
  });
}
