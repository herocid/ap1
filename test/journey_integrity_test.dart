import 'package:ap1_trainer/data/models/nugget.dart';
import 'package:ap1_trainer/data/models/subtopic.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final nuggets = kSeedNuggets;

  test('IDs sind eindeutig', () {
    final ids = nuggets.map((n) => n.id).toList();
    expect(ids.toSet().length, ids.length);
  });

  test('jedes Nugget gehört zu einem existierenden Thema', () {
    for (final n in nuggets) {
      expect(Topics.map.containsKey(n.topicId), isTrue,
          reason: '${n.id}: unbekanntes Thema ${n.topicId}');
    }
  });

  test('jedes Nugget gehört zu einer Lektion desselben Themas', () {
    for (final n in nuggets) {
      final s = Subtopics.byId(n.subtopicId);
      expect(s, isNotNull, reason: '${n.id}: unbekannte Lektion ${n.subtopicId}');
      expect(s!.topicId, n.topicId,
          reason: '${n.id}: Lektion ${s.id} gehört zu ${s.topicId}');
    }
  });

  test('die Lernschritte einer Lektion stehen am Stück', () {
    // Sonst wäre die Reihenfolge innerhalb einer Lektion davon abhängig,
    // in welcher Datei ein Schritt zufällig steht.
    final seen = <String>{};
    String? current;
    for (final n in nuggets) {
      if (n.subtopicId != current) {
        expect(seen.add(n.subtopicId), isTrue,
            reason: 'Lektion ${n.subtopicId} ist über die Liste verstreut');
        current = n.subtopicId;
      }
    }
  });

  test('Lektions-IDs und -Titel sind eindeutig, Lernziele formuliert', () {
    final ids = Subtopics.all.map((s) => s.id).toList();
    expect(ids.toSet().length, ids.length);
    for (final s in Subtopics.all) {
      expect(Topics.map.containsKey(s.topicId), isTrue, reason: s.id);
      expect(s.goal.startsWith('Du '), isTrue, reason: '${s.id}: Lernziel');
    }
  });

  test('Aufgaben und Karten mit Lektion passen zu ihrem Thema', () {
    for (final q in kSeedQuestions.where((q) => q.subtopicId != null)) {
      final s = Subtopics.byId(q.subtopicId);
      expect(s, isNotNull, reason: '${q.id}: unbekannte Lektion');
      expect(s!.topicId, q.topicId, reason: '${q.id}: Lektion aus anderem Thema');
    }
    for (final c in kSeedFlashcards.where((c) => c.subtopicId != null)) {
      final s = Subtopics.byId(c.subtopicId);
      expect(s, isNotNull, reason: '${c.id}: unbekannte Lektion');
      expect(s!.topicId, c.topicId, reason: '${c.id}: Lektion aus anderem Thema');
    }
  });

  test('gestrichene Aufgaben gehören zu keiner Lektion', () {
    for (final q in kSeedQuestions.where((q) => !q.isExamRelevant)) {
      expect(q.subtopicId, isNull,
          reason: '${q.id} ist ab 2025 gestrichen und darf nicht im Wissenscheck landen');
    }
  });

  // Die Vollständigkeitsregel: Jede Lektion, die in der Journey erscheint,
  // hat genug Lernschritte, Aufgaben für den Wissenscheck und Karteikarten.
  final lessons = nuggets.map((n) => n.subtopicId).toSet();

  test('jede Lektion hat mindestens vier Lernschritte', () {
    for (final id in lessons) {
      final n = nuggets.where((x) => x.subtopicId == id).length;
      expect(n, greaterThanOrEqualTo(4), reason: 'Lektion $id: $n Lernschritte');
    }
  });

  test('jede Lektion hat mindestens drei Aufgaben', () {
    for (final id in lessons) {
      final n = kExamRelevantQuestions.where((q) => q.subtopicId == id).length;
      expect(n, greaterThanOrEqualTo(3), reason: 'Lektion $id: $n Aufgaben');
    }
  });

  test('jede Lektion hat mindestens vier Karteikarten', () {
    for (final id in lessons) {
      final n = kSeedFlashcards.where((c) => c.subtopicId == id).length;
      expect(n, greaterThanOrEqualTo(4), reason: 'Lektion $id: $n Karten');
    }
  });

  test('jedes Thema hat mindestens zwei Lektionen', () {
    for (final t in Topics.all) {
      expect(Subtopics.ofTopic(t.id).length, greaterThanOrEqualTo(2),
          reason: t.id);
    }
  });

  test('Titel und Text sind nicht leer', () {
    for (final n in nuggets) {
      expect(n.title.trim(), isNotEmpty, reason: n.id);
      expect(n.body.trim().length, greaterThanOrEqualTo(30), reason: n.id);
    }
  });

  test('jede Art hat die Felder, die ihre Karte braucht', () {
    for (final n in nuggets) {
      switch (n.kind) {
        case NuggetKind.vergleich:
          expect(n.table, isNotNull, reason: '${n.id}: Vergleich ohne Tabelle');
        case NuggetKind.ablauf:
          expect(n.points.length, greaterThanOrEqualTo(2),
              reason: '${n.id}: Ablauf mit weniger als zwei Schritten');
        case NuggetKind.formel:
          expect(n.code, isNotNull, reason: '${n.id}: Formel ohne Formel');
        case NuggetKind.merksatz:
          expect(n.merksatz != null || n.points.isNotEmpty, isTrue,
              reason: '${n.id}: Merksatz ohne Merksatz oder Punkte');
        case NuggetKind.konzept:
        case NuggetKind.fehlerfalle:
          break;
      }
    }
  });

  test('Tabellen sind rechteckig und haben Kopf plus Inhalt', () {
    for (final n in nuggets.where((n) => n.table != null)) {
      final t = n.table!;
      expect(t.length, greaterThanOrEqualTo(2), reason: n.id);
      for (final row in t) {
        expect(row.length, t.first.length,
            reason: '${n.id}: Zeile "${row.first}" hat falsche Spaltenzahl');
      }
    }
  });

  test('JSON-Roundtrip verliert nichts', () {
    for (final n in nuggets) {
      final back = Nugget.fromJson(n.toJson());
      expect(back.toJson(), n.toJson(), reason: n.id);
    }
  });
}
