import 'package:ap1_trainer/data/models/exam_area.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

/// Diese Tests halten den Aufgabenpool sauber. Eine fachlich falsche Aufgabe
/// fällt in einer Lern-App niemandem auf - eine strukturell kaputte schon,
/// und zwar dem Nutzer mitten in der Session. Das fängt der Test hier ab.
void main() {
  group('Aufgabenpool', () {
    test('enthält Aufgaben', () {
      expect(kSeedQuestions.length, greaterThanOrEqualTo(40));
    });

    test('alle IDs sind eindeutig', () {
      final ids = kSeedQuestions.map((q) => q.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('jede Aufgabe verweist auf ein existierendes Thema', () {
      for (final q in kSeedQuestions) {
        expect(Topics.map.containsKey(q.topicId), isTrue,
            reason: '${q.id} nutzt unbekanntes Thema ${q.topicId}');
      }
    });

    test('ein Thema hat entweder keine oder mindestens drei Aufgaben', () {
      // Themen ohne Inhalte sind während des Ausbaus erlaubt. Ein Thema mit
      // ein oder zwei Aufgaben wäre aber schlimmer als eines ohne: die
      // Auswahl würde dieselbe Aufgabe ständig wiederholen.
      final pool = kPoolSizeByTopic();
      for (final t in Topics.all) {
        final n = pool[t.id] ?? 0;
        if (n == 0) continue;
        expect(n, greaterThanOrEqualTo(3),
            reason: 'Thema ${t.id} hat nur $n Aufgaben');
      }
    });

    test('gestrichene Aufgaben zählen nicht in den Pool', () {
      final removed = kSeedQuestions
          .where((q) => q.catalogStatus == CatalogStatus.removed2025);
      expect(removed, isNotEmpty,
          reason: 'Der Katalog 2025 hat Themen gestrichen - das muss sich '
              'im Pool abbilden');
      final poolIds = kExamRelevantQuestions.map((q) => q.id).toSet();
      for (final q in removed) {
        expect(poolIds.contains(q.id), isFalse, reason: q.id);
      }
    });

    test('jede Aufgabe hat Fragestellung und Erklärung', () {
      for (final q in kSeedQuestions) {
        expect(q.prompt.trim(), isNotEmpty, reason: q.id);
        expect(q.explanation.trim().length, greaterThan(40),
            reason: '${q.id}: Erklärung zu dünn');
      }
    });

    test('Auswahlaufgaben haben mindestens eine richtige Option', () {
      for (final q in kSeedQuestions.where((q) =>
          q.kind == QuestionKind.single || q.kind == QuestionKind.multiple)) {
        final correct = q.choices.where((c) => c.isCorrect).length;
        expect(q.choices.length, greaterThanOrEqualTo(3), reason: q.id);
        expect(correct, greaterThanOrEqualTo(1), reason: q.id);
        if (q.kind == QuestionKind.single) {
          expect(correct, 1,
              reason: '${q.id}: Einfachauswahl mit $correct richtigen Optionen');
        } else {
          expect(correct, greaterThanOrEqualTo(2),
              reason: '${q.id}: Mehrfachauswahl mit nur einer Lösung');
        }
      }
    });

    test('jede Antwortoption hat eine Begründung', () {
      for (final q in kSeedQuestions) {
        for (final c in q.choices) {
          expect(c.rationale.trim(), isNotEmpty,
              reason: '${q.id}: Option "${c.text}" ohne Begründung');
        }
      }
    });

    test('Rechenaufgaben haben ein Ergebnis', () {
      for (final q
          in kSeedQuestions.where((q) => q.kind == QuestionKind.numeric)) {
        expect(q.numericAnswer, isNotNull, reason: q.id);
      }
    });

    test('Zuordnungsaufgaben verweisen auf gültige Kategorien', () {
      for (final q
          in kSeedQuestions.where((q) => q.kind == QuestionKind.matching)) {
        expect(q.buckets.length, greaterThanOrEqualTo(2), reason: q.id);
        expect(q.matchItems.length, greaterThanOrEqualTo(3), reason: q.id);
        for (final m in q.matchItems) {
          expect(m.bucket, inInclusiveRange(0, q.buckets.length - 1),
              reason: '${q.id}: Item "${m.text}" zeigt ins Leere');
        }
        // Jede Kategorie sollte mindestens einmal die Lösung sein, sonst ist
        // sie nur Dekoration.
        final used = q.matchItems.map((m) => m.bucket).toSet();
        expect(used.length, q.buckets.length,
            reason: '${q.id}: ungenutzte Kategorie');
      }
    });

    test('Reihenfolge-Aufgaben haben genug Elemente', () {
      for (final q
          in kSeedQuestions.where((q) => q.kind == QuestionKind.ordering)) {
        expect(q.orderedItems.length, greaterThanOrEqualTo(3), reason: q.id);
        expect(q.orderedItems.toSet().length, q.orderedItems.length,
            reason: '${q.id}: doppelte Einträge');
      }
    });

    test('Netzplan-Aufgaben sind lösbar und verweisen auf echte Vorgänger',
        () {
      for (final q
          in kSeedQuestions.where((q) => q.kind == QuestionKind.netzplan)) {
        expect(q.activities.length, greaterThanOrEqualTo(3), reason: q.id);
        expect(q.askedFields, isNotEmpty, reason: q.id);

        final ids = q.activities.map((a) => a.id).toSet();
        for (final a in q.activities) {
          expect(a.duration, greaterThan(0), reason: '${q.id}/${a.id}');
          for (final p in a.predecessors) {
            expect(ids.contains(p), isTrue,
                reason: '${q.id}: ${a.id} verweist auf unbekannten Vorgang $p');
          }
        }

        final sol = q.netzplanSolution!;
        expect(sol.projectDuration, greaterThan(0), reason: q.id);
        expect(sol.criticalPath, isNotEmpty, reason: q.id);
      }
    });

    test('JSON-Roundtrip erhält die Aufgabe', () {
      for (final q in kSeedQuestions) {
        final back = Question.fromJson(q.toJson());
        expect(back.id, q.id);
        expect(back.kind, q.kind);
        expect(back.choices.length, q.choices.length);
        expect(back.matchItems.length, q.matchItems.length);
        expect(back.activities.length, q.activities.length);
        expect(back.askedFields, q.askedFields);
        expect(back.numericAnswer, q.numericAnswer);
        expect(back.orderedItems, q.orderedItems);
      }
    });

    test('Themengewichte summieren sich zu 1', () {
      final sum = Topics.all.fold<double>(0, (s, t) => s + t.weight);
      expect(sum, closeTo(1.0, 1e-9));
    });

    test('jeder Theorie-Snack verweist auf ein existierendes Thema', () {
      for (final s in kSeedTheory) {
        expect(Topics.map.containsKey(s.topicId), isTrue,
            reason: '${s.id} nutzt unbekanntes Thema ${s.topicId}');
      }
    });

    test('jedes Thema mit Aufgaben gehört zu einem Bereich', () {
      for (final t in Topics.all) {
        expect(ExamAreas.map.containsKey(t.areaId), isTrue,
            reason: 'Thema ${t.id} zeigt auf unbekannten Bereich ${t.areaId}');
      }
    });

    test('Bereichsgewichte summieren sich zu 1', () {
      final sum = ExamAreas.all.fold<double>(0, (s, a) => s + a.weight);
      expect(sum, closeTo(1.0, 1e-9));
    });

    test('die Themen eines Bereichs ergeben dessen Bereichsgewicht', () {
      for (final area in ExamAreas.all) {
        final sum = Topics.ofArea(area.id).fold<double>(0, (s, t) => s + t.weight);
        expect(sum, closeTo(area.weight, 1e-9),
            reason: 'Bereich ${area.number}: Themen ergeben $sum statt '
                '${area.weight}');
      }
    });

    test('jeder Bereich hat mindestens ein Thema', () {
      for (final area in ExamAreas.all) {
        expect(Topics.ofArea(area.id), isNotEmpty, reason: area.id);
      }
    });
  });
}
