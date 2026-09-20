import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final heute = DateTime(2026, 9, 20);

  group('Leitner-Boxen', () {
    test('eine neue Karte ist sofort fällig', () {
      const s = CardState(cardId: 'x');
      expect(s.isNew, isTrue);
      expect(s.isDue(heute), isTrue);
      expect(s.box, 1);
    });

    test('gewusst schiebt die Karte ein Fach weiter', () {
      const s = CardState(cardId: 'x', box: 2);
      final next = s.answer(knewIt: true, now: heute);
      expect(next.box, 3);
      expect(next.timesCorrect, 1);
    });

    test('nicht gewusst wirft die Karte zurück in Fach 1', () {
      const s = CardState(cardId: 'x', box: 5);
      final next = s.answer(knewIt: false, now: heute);
      expect(next.box, 1);
      expect(next.timesWrong, 1);
    });

    test('Fach 5 ist die Obergrenze', () {
      const s = CardState(cardId: 'x', box: 5);
      expect(s.answer(knewIt: true, now: heute).box, 5);
    });

    test('die Wiedervorlage folgt dem Intervall des neuen Fachs', () {
      const s = CardState(cardId: 'x', box: 1);
      final next = s.answer(knewIt: true, now: heute);
      // Fach 2 -> 2 Tage
      expect(next.due, DateTime(2026, 9, 22));
    });

    test('eine beantwortete Karte ist heute nicht mehr fällig', () {
      const s = CardState(cardId: 'x');
      final next = s.answer(knewIt: true, now: heute);
      expect(next.isDue(heute), isFalse);
    });

    test('nach Ablauf des Intervalls ist sie wieder fällig', () {
      const s = CardState(cardId: 'x');
      final next = s.answer(knewIt: true, now: heute);
      // Fach 1 -> 2 bedeutet zwei Tage Wiedervorlage.
      expect(next.isDue(DateTime(2026, 9, 21)), isFalse);
      expect(next.isDue(DateTime(2026, 9, 22)), isTrue);
    });

    test('die Intervalle wachsen streng monoton', () {
      for (var box = 1; box < Leitner.boxCount; box++) {
        expect(Leitner.intervalFor(box + 1),
            greaterThan(Leitner.intervalFor(box)));
      }
    });
  });

  group('Karteikasten', () {
    final cards = [
      const Flashcard(id: 'a', topicId: 'netzplan', front: 'A', back: 'a'),
      const Flashcard(id: 'b', topicId: 'netzplan', front: 'B', back: 'b'),
      const Flashcard(id: 'c', topicId: 'agil_scrum', front: 'C', back: 'c'),
    ];

    test('alle Karten sind anfangs fällig', () {
      const deck = DeckState();
      expect(deck.dueCount(cards, now: heute), 3);
    });

    test('der Themenfilter greift', () {
      const deck = DeckState();
      final due = deck.due(cards, topicIds: {'agil_scrum'}, now: heute);
      expect(due.map((c) => c.id), ['c']);
    });

    test('niedrige Fächer kommen zuerst', () {
      var deck = const DeckState();
      // "a" auf Fach 3 heben, "b" bleibt neu.
      deck = deck.withAnswer('a', true, now: DateTime(2026, 9, 1));
      deck = deck.withAnswer('a', true, now: DateTime(2026, 9, 5));
      final due = deck.due(cards, now: heute);
      expect(due.first.id, isNot('a'),
          reason: 'Was schon sitzt, darf nicht vor dem Neuen kommen');
    });

    test('eine falsch beantwortete Karte ist morgen wieder dran', () {
      var deck = const DeckState();
      deck = deck.withAnswer('a', false, now: heute);
      expect(deck.stateOf('a').isDue(heute), isFalse);
      expect(deck.stateOf('a').isDue(DateTime(2026, 9, 21)), isTrue);
    });

    test('mastery wächst mit dem Fach', () {
      var deck = const DeckState();
      expect(deck.mastery(cards), 0);
      for (var i = 0; i < 4; i++) {
        for (final c in cards) {
          deck = deck.withAnswer(c.id, true, now: heute);
        }
      }
      expect(deck.mastery(cards), 1.0);
    });

    test('JSON-Roundtrip erhält den Lernstand', () {
      var deck = const DeckState();
      deck = deck.withAnswer('a', true, now: heute);
      deck = deck.withAnswer('b', false, now: heute);
      final back = DeckState.decode(deck.encode());
      expect(back.stateOf('a').box, deck.stateOf('a').box);
      expect(back.stateOf('a').due, deck.stateOf('a').due);
      expect(back.stateOf('b').timesWrong, 1);
    });
  });

  group('Kartensammlung', () {
    test('enthält Karten', () {
      expect(kSeedFlashcards.length, greaterThanOrEqualTo(100));
    });

    test('alle IDs sind eindeutig', () {
      final ids = kSeedFlashcards.map((c) => c.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('jede Karte verweist auf ein existierendes Thema', () {
      for (final c in kSeedFlashcards) {
        expect(Topics.map.containsKey(c.topicId), isTrue,
            reason: '${c.id} nutzt unbekanntes Thema ${c.topicId}');
      }
    });

    test('Vorder- und Rückseite sind gefüllt', () {
      for (final c in kSeedFlashcards) {
        expect(c.front.trim(), isNotEmpty, reason: c.id);
        expect(c.back.trim().length, greaterThan(15),
            reason: '${c.id}: Rückseite zu dünn');
      }
    });

    test('die Vorderseite bleibt kurz', () {
      // Eine Vorderseite, die länger ist als ein Satz, ist keine Karteikarte
      // mehr, sondern eine Aufgabe.
      for (final c in kSeedFlashcards) {
        expect(c.front.length, lessThanOrEqualTo(120),
            reason: '${c.id}: Vorderseite zu lang (${c.front.length} Zeichen)');
      }
    });

    test('ein Thema hat entweder keine oder mindestens acht Karten', () {
      final counts = kCardCountByTopic();
      for (final t in Topics.all) {
        final n = counts[t.id] ?? 0;
        if (n == 0) continue;
        expect(n, greaterThanOrEqualTo(8),
            reason: 'Thema ${t.id} hat nur $n Karten - zu wenig für einen '
                'sinnvollen Kasten');
      }
    });

    test('keine doppelten Vorderseiten innerhalb eines Themas', () {
      final byTopic = <String, List<String>>{};
      for (final c in kSeedFlashcards) {
        byTopic.putIfAbsent(c.topicId, () => []).add(c.front.toLowerCase());
      }
      for (final e in byTopic.entries) {
        expect(e.value.toSet().length, e.value.length,
            reason: 'Thema ${e.key} hat doppelte Kartenvorderseiten');
      }
    });
  });
}
