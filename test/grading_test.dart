import 'package:ap1_trainer/data/models/netzplan.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:flutter_test/flutter_test.dart';

Choice c(String t, bool ok) => Choice(text: t, isCorrect: ok, rationale: '');

void main() {
  group('Einfachauswahl', () {
    final q = Question(
      id: 'q1',
      topicId: 'agil_scrum',
      kind: QuestionKind.single,
      prompt: '?',
      explanation: '',
      choices: [c('a', true), c('b', false), c('c', false)],
    );

    test('richtige Option gibt volle Punktzahl', () {
      expect(q.grade({0}).score, 1.0);
      expect(q.grade({0}).isCorrect, isTrue);
    });

    test('falsche Option gibt null', () {
      expect(q.grade({1}).score, 0.0);
    });

    test('keine Antwort gibt null', () {
      expect(q.grade(null).score, 0.0);
    });
  });

  group('Mehrfachauswahl', () {
    final q = Question(
      id: 'q2',
      topicId: 'agil_scrum',
      kind: QuestionKind.multiple,
      prompt: '?',
      explanation: '',
      choices: [c('a', true), c('b', true), c('c', false), c('d', false)],
    );

    test('alle richtigen angekreuzt gibt volle Punktzahl', () {
      expect(q.grade({0, 1}).score, 1.0);
    });

    test('eine von zwei richtigen gibt Teilpunkte', () {
      expect(q.grade({0}).score, closeTo(0.5, 1e-9));
    });

    test('falsch angekreuzte Optionen ziehen ab', () {
      // eine richtige, eine falsche -> (1 - 1) / 2 = 0
      expect(q.grade({0, 2}).score, 0.0);
    });

    test('alles ankreuzen ist keine Gewinnstrategie', () {
      expect(q.grade({0, 1, 2, 3}).score, 0.0);
    });
  });

  group('Rechenaufgabe', () {
    final q = Question(
      id: 'q3',
      topicId: 'wirtschaftlichkeit',
      kind: QuestionKind.numeric,
      prompt: '?',
      explanation: '',
      numericAnswer: 3.65,
      numericTolerance: 0.01,
    );

    test('Wert innerhalb der Toleranz zählt als richtig', () {
      expect(q.grade(3.65).score, 1.0);
      expect(q.grade(3.66).score, 1.0);
    });

    test('Wert außerhalb der Toleranz zählt als falsch', () {
      expect(q.grade(3.7).score, 0.0);
    });
  });

  group('Reihenfolge', () {
    final q = Question(
      id: 'q4',
      topicId: 'vorgehensmodelle',
      kind: QuestionKind.ordering,
      prompt: '?',
      explanation: '',
      orderedItems: const ['eins', 'zwei', 'drei', 'vier'],
    );

    test('korrekte Reihenfolge gibt volle Punktzahl', () {
      expect(q.grade([0, 1, 2, 3]).score, 1.0);
    });

    test('ein Tausch verliert nicht alles', () {
      final s = q.grade([1, 0, 2, 3]).score;
      expect(s, greaterThan(0.6));
      expect(s, lessThan(1.0));
    });

    test('komplett umgedreht gibt null', () {
      expect(q.grade([3, 2, 1, 0]).score, 0.0);
    });

    test('unvollständige Antwort gibt null', () {
      expect(q.grade([0, 1]).score, 0.0);
    });
  });

  group('Zuordnung', () {
    final q = Question(
      id: 'q5',
      topicId: 'lastenheft',
      kind: QuestionKind.matching,
      prompt: '?',
      explanation: '',
      buckets: const ['Lastenheft', 'Pflichtenheft'],
      matchItems: const [
        MatchItem(text: 'a', bucket: 0),
        MatchItem(text: 'b', bucket: 1),
        MatchItem(text: 'c', bucket: 0),
        MatchItem(text: 'd', bucket: 1),
      ],
    );

    test('alles richtig gibt volle Punktzahl', () {
      expect(q.grade({0: 0, 1: 1, 2: 0, 3: 1}).score, 1.0);
    });

    test('Teilpunkte pro richtiger Zuordnung', () {
      expect(q.grade({0: 0, 1: 1, 2: 1, 3: 0}).score, closeTo(0.5, 1e-9));
    });
  });

  group('Netzplan', () {
    final q = Question(
      id: 'q6',
      topicId: 'netzplan',
      kind: QuestionKind.netzplan,
      prompt: '?',
      explanation: '',
      activities: const [
        Activity(id: 'A', name: 'A', duration: 4),
        Activity(id: 'B', name: 'B', duration: 3, predecessors: ['A']),
      ],
      askedFields: const [NodeField.faz, NodeField.fez],
    );

    test('alle Zellen richtig', () {
      final g = q.grade({'A.faz': 0, 'A.fez': 4, 'B.faz': 4, 'B.fez': 7});
      expect(g.score, 1.0);
    });

    test('Teilpunkte pro richtiger Zelle', () {
      final g = q.grade({'A.faz': 0, 'A.fez': 4, 'B.faz': 3, 'B.fez': 6});
      expect(g.score, closeTo(0.5, 1e-9));
      expect(g.parts['B.faz'], isFalse);
      expect(g.parts['A.fez'], isTrue);
    });

    test('leere Antwort gibt null', () {
      expect(q.grade(<String, int>{}).score, 0.0);
    });
  });
}
