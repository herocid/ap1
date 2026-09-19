import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

/// Diese Tests halten den Aufgabenpool sauber. Eine fachlich falsche Aufgabe
/// faellt in einer Lern-App niemandem auf - eine strukturell kaputte schon,
/// und zwar dem Nutzer mitten in der Session. Das faengt der Test hier ab.
void main() {
  group('Aufgabenpool', () {
    test('enthaelt Aufgaben', () {
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

    test('jedes Thema hat mindestens drei Aufgaben', () {
      final pool = kPoolSizeByTopic();
      for (final t in Topics.all) {
        expect(pool[t.id] ?? 0, greaterThanOrEqualTo(3),
            reason: 'Thema ${t.id} hat zu wenige Aufgaben');
      }
    });

    test('jede Aufgabe hat Fragestellung und Erklaerung', () {
      for (final q in kSeedQuestions) {
        expect(q.prompt.trim(), isNotEmpty, reason: q.id);
        expect(q.explanation.trim().length, greaterThan(40),
            reason: '${q.id}: Erklaerung zu duenn');
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
              reason: '${q.id}: Mehrfachauswahl mit nur einer Loesung');
        }
      }
    });

    test('jede Antwortoption hat eine Begruendung', () {
      for (final q in kSeedQuestions) {
        for (final c in q.choices) {
          expect(c.rationale.trim(), isNotEmpty,
              reason: '${q.id}: Option "${c.text}" ohne Begruendung');
        }
      }
    });

    test('Rechenaufgaben haben ein Ergebnis', () {
      for (final q
          in kSeedQuestions.where((q) => q.kind == QuestionKind.numeric)) {
        expect(q.numericAnswer, isNotNull, reason: q.id);
      }
    });

    test('Zuordnungsaufgaben verweisen auf gueltige Kategorien', () {
      for (final q
          in kSeedQuestions.where((q) => q.kind == QuestionKind.matching)) {
        expect(q.buckets.length, greaterThanOrEqualTo(2), reason: q.id);
        expect(q.matchItems.length, greaterThanOrEqualTo(3), reason: q.id);
        for (final m in q.matchItems) {
          expect(m.bucket, inInclusiveRange(0, q.buckets.length - 1),
              reason: '${q.id}: Item "${m.text}" zeigt ins Leere');
        }
        // Jede Kategorie sollte mindestens einmal die Loesung sein, sonst ist
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
            reason: '${q.id}: doppelte Eintraege');
      }
    });

    test('Netzplan-Aufgaben sind loesbar und verweisen auf echte Vorgaenger',
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

    test('JSON-Roundtrip erhaelt die Aufgabe', () {
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

    test('zu jedem Thema gibt es mindestens einen Theorie-Snack', () {
      for (final t in Topics.all) {
        expect(kSeedTheory.any((s) => s.topicId == t.id), isTrue,
            reason: 'Thema ${t.id} ohne Theorie-Snack');
      }
    });
  });
}
