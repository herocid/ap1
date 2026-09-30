import 'package:ap1_trainer/core/util/question_selector.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}
