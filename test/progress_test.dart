import 'package:ap1_trainer/core/util/question_selector.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

AnswerRecord rec(
  String qid,
  String topic,
  double score, {
  int daysAgo = 0,
  SessionMode mode = SessionMode.uebung,
}) =>
    AnswerRecord(
      questionId: qid,
      topicId: topic,
      score: score,
      seconds: 30,
      at: DateTime.now().subtract(Duration(days: daysAgo)),
      mode: mode,
    );

void main() {
  final pool = kPoolSizeByTopic();

  group('Pruefungsreife', () {
    test('ist ohne Historie null', () {
      expect(const ProgressState().readiness(pool), 0);
    });

    test('bleibt niedrig, wenn nur ein Thema geuebt wurde', () {
      final p = ProgressState(
        history: [
          for (var i = 0; i < 7; i++) rec('np-00$i', 'netzplan', 1.0),
        ],
      );
      final r = p.readiness(pool);
      expect(r, greaterThan(0));
      // Netzplan ist mit 18 % gewichtet - mehr kann ein einzelnes Thema nicht
      // beitragen.
      expect(r, lessThanOrEqualTo(18));
    });

    test('liegt immer zwischen 0 und 100', () {
      final p = ProgressState(
        history: [
          for (final q in kExamRelevantQuestions) rec(q.id, q.topicId, 1.0),
        ],
      );
      expect(p.readiness(pool), inInclusiveRange(0, 100));
    });

    test('deckelt sich beim Gewicht der Themen, die Aufgaben haben', () {
      // Themen ohne Aufgaben zaehlen als 0 - der Wert soll ehrlich zeigen,
      // dass ein Teil des Katalogs noch nicht geuebt werden kann. Wer alle
      // vorhandenen Aufgaben fehlerfrei loest, erreicht deshalb genau den
      // Gewichtsanteil der befuellten Themen, nicht 100 %.
      final p = ProgressState(
        history: [
          for (final q in kExamRelevantQuestions) rec(q.id, q.topicId, 1.0),
        ],
      );
      final covered = pool.keys.where((id) => (pool[id] ?? 0) > 0);
      final expectedShare = covered.fold<double>(
          0, (s, id) => s + (Topics.map[id]?.weight ?? 0));

      expect(p.readiness(pool), closeTo(expectedShare * 100, 1.5));
    });

    test('erreicht 100, wenn jedes Thema vollstaendig sitzt', () {
      // Synthetischer Vollausbau: jedes Thema hat Aufgaben und alle sind
      // richtig. Erst dann darf der Indikator 100 zeigen.
      final fullPool = {for (final t in Topics.all) t.id: 2};
      final p = ProgressState(
        history: [
          for (final t in Topics.all) ...[
            rec('${t.id}-a', t.id, 1.0),
            rec('${t.id}-b', t.id, 1.0),
          ],
        ],
      );
      expect(p.readiness(fullPool), 100);
    });
  });

  group('Themenstatistik', () {
    test('gewichtet juengere Antworten staerker', () {
      final verbessert = ProgressState(history: [
        rec('a', 'netzplan', 0, daysAgo: 9),
        rec('b', 'netzplan', 0, daysAgo: 8),
        rec('c', 'netzplan', 1, daysAgo: 1),
        rec('d', 'netzplan', 1, daysAgo: 0),
      ]);
      final verschlechtert = ProgressState(history: [
        rec('a', 'netzplan', 1, daysAgo: 9),
        rec('b', 'netzplan', 1, daysAgo: 8),
        rec('c', 'netzplan', 0, daysAgo: 1),
        rec('d', 'netzplan', 0, daysAgo: 0),
      ]);

      final mBesser = verbessert.topicStats(pool)['netzplan']!.mastery;
      final mSchlechter = verschlechtert.topicStats(pool)['netzplan']!.mastery;
      expect(mBesser, greaterThan(0.5));
      expect(mSchlechter, lessThan(0.5));
    });

    test('Coverage zaehlt nur unterschiedliche Aufgaben', () {
      final p = ProgressState(history: [
        rec('np-001', 'netzplan', 1),
        rec('np-001', 'netzplan', 1),
        rec('np-001', 'netzplan', 1),
      ]);
      final st = p.topicStats(pool)['netzplan']!;
      expect(st.answered, 3);
      expect(st.distinctQuestions, 1);
      expect(st.coverage, lessThan(0.5));
    });
  });

  group('Fehlerspeicher', () {
    test('enthaelt nur Aufgaben, deren letzter Versuch falsch war', () {
      final p = ProgressState(history: [
        rec('a', 'netzplan', 0, daysAgo: 3),
        rec('a', 'netzplan', 1, daysAgo: 1), // korrigiert
        rec('b', 'agil_scrum', 1, daysAgo: 3),
        rec('b', 'agil_scrum', 0, daysAgo: 1), // wieder falsch
        rec('c', 'lastenheft', 0.5, daysAgo: 1), // Teilpunkte zaehlen als offen
      ]);
      expect(p.openMistakes, {'b', 'c'});
    });
  });

  group('Level und XP', () {
    test('starten bei Level 1', () {
      expect(const ProgressState().level, 1);
      expect(const ProgressState().xp, 0);
    });

    test('steigen monoton mit der Anzahl richtiger Antworten', () {
      var last = 0;
      for (final n in [1, 10, 30, 80]) {
        final p = ProgressState(
          history: [for (var i = 0; i < n; i++) rec('q$i', 'netzplan', 1.0)],
        );
        expect(p.xp, greaterThan(last));
        last = p.xp;
      }
    });

    test('auch eine falsche Antwort gibt einen Trostpunkt', () {
      final p = ProgressState(history: [rec('a', 'netzplan', 0)]);
      expect(p.xp, 2);
    });
  });

  group('QuestionSelector', () {
    test('liefert die gewuenschte Anzahl', () {
      final qs = QuestionSelector.forPractice(
        pool: kSeedQuestions,
        progress: const ProgressState(),
        poolSize: pool,
        count: 10,
        seed: 42,
      );
      expect(qs.length, 10);
      expect(qs.map((q) => q.id).toSet().length, 10, reason: 'keine Dubletten');
    });

    test('bevorzugt Aufgaben aus dem Fehlerspeicher', () {
      final wrongIds =
          kSeedQuestions.take(5).map((q) => q.id).toList(growable: false);
      final progress = ProgressState(
        history: [
          for (final q in kSeedQuestions.take(5))
            rec(q.id, q.topicId, 0, daysAgo: 1),
        ],
      );

      final qs = QuestionSelector.forPractice(
        pool: kSeedQuestions,
        progress: progress,
        poolSize: pool,
        count: 8,
        seed: 7,
      );
      final picked = qs.map((q) => q.id).toSet();
      expect(picked.intersection(wrongIds.toSet()).length, wrongIds.length,
          reason: 'alle offenen Fehler muessen in den naechsten 8 auftauchen');
    });

    test('Themenfilter wird eingehalten', () {
      final qs = QuestionSelector.forPractice(
        pool: kSeedQuestions,
        progress: const ProgressState(),
        poolSize: pool,
        count: 5,
        topicFilter: 'netzplan',
        seed: 1,
      );
      expect(qs.every((q) => q.topicId == 'netzplan'), isTrue);
    });

    test('Pruefungsmix streut ueber mehrere Themen', () {
      final qs = QuestionSelector.forExam(
        pool: kSeedQuestions,
        count: 30,
        seed: 3,
      );
      expect(qs.length, 30);
      expect(qs.map((q) => q.id).toSet().length, 30);
      expect(qs.map((q) => q.topicId).toSet().length, greaterThanOrEqualTo(6));
    });
  });
}
