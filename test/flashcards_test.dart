import 'dart:math' as math;

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
        expect(
          Leitner.intervalFor(box + 1),
          greaterThan(Leitner.intervalFor(box)),
        );
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
      expect(
        due.first.id,
        isNot('a'),
        reason: 'Was schon sitzt, darf nicht vor dem Neuen kommen',
      );
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
        expect(
          Topics.map.containsKey(c.topicId),
          isTrue,
          reason: '${c.id} nutzt unbekanntes Thema ${c.topicId}',
        );
      }
    });

    test('Vorder- und Rückseite sind gefüllt', () {
      for (final c in kSeedFlashcards) {
        expect(c.front.trim(), isNotEmpty, reason: c.id);
        expect(
          c.back.trim().length,
          greaterThan(15),
          reason: '${c.id}: Rückseite zu dünn',
        );
      }
    });

    test('die Vorderseite bleibt kurz', () {
      // Eine Vorderseite, die länger ist als ein Satz, ist keine Karteikarte
      // mehr, sondern eine Aufgabe.
      for (final c in kSeedFlashcards) {
        expect(
          c.front.length,
          lessThanOrEqualTo(120),
          reason: '${c.id}: Vorderseite zu lang (${c.front.length} Zeichen)',
        );
      }
    });

    test('ein Thema hat entweder keine oder mindestens acht Karten', () {
      final counts = kCardCountByTopic();
      for (final t in Topics.all) {
        final n = counts[t.id] ?? 0;
        if (n == 0) continue;
        expect(
          n,
          greaterThanOrEqualTo(8),
          reason:
              'Thema ${t.id} hat nur $n Karten - zu wenig für einen '
              'sinnvollen Kasten',
        );
      }
    });

    test('keine doppelten Vorderseiten innerhalb eines Themas', () {
      final byTopic = <String, List<String>>{};
      for (final c in kSeedFlashcards) {
        byTopic.putIfAbsent(c.topicId, () => []).add(c.front.toLowerCase());
      }
      for (final e in byTopic.entries) {
        expect(
          e.value.toSet().length,
          e.value.length,
          reason: 'Thema ${e.key} hat doppelte Kartenvorderseiten',
        );
      }
    });
  });

  group('Durchlauf', () {
    final pool = [
      for (final id in ['a', 'b', 'c', 'd'])
        Flashcard(id: id, topicId: 'netzplan', front: id, back: id),
    ];

    test('startet mit allen Karten offen, gemischt und vollständig', () {
      final run = CardRun.start(
        title: 'Alle',
        pool: pool,
        random: math.Random(1),
        now: heute,
      );
      expect(run.total, 4);
      expect(run.remainingCount, 4);
      expect(run.cardIds.toSet(), {'a', 'b', 'c', 'd'});
      expect(run.isDone, isFalse);
    });

    test('nicht gewusst bleibt im Pool und kommt beim Fortsetzen zuerst', () {
      var run = CardRun(
        title: 'Alle',
        cardIds: const ['a', 'b', 'c', 'd'],
        startedAt: heute,
      );
      run = run.withAnswer('a', knewIt: true);
      run = run.withAnswer('c', knewIt: false);
      expect(run.knownCount, 1);
      expect(run.remainingIds(), ['c', 'b', 'd']);
      expect(run.missCount, 1);
    });

    test('ist fertig, wenn jede Karte einmal gewusst wurde', () {
      var run = CardRun(
        title: 'Alle',
        cardIds: const ['a', 'b'],
        startedAt: heute,
      );
      run = run.withAnswer('a', knewIt: false, now: heute);
      run = run.withAnswer('a', knewIt: true, now: heute);
      expect(run.isDone, isFalse);
      run = run.withAnswer('b', knewIt: true, now: heute);
      expect(run.isDone, isTrue);
      expect(run.finishedAt, heute);
      expect(run.misses['a'], 1);
    });

    test('eine gewusste Karte zählt kein zweites Mal', () {
      var run = CardRun(
        title: 'Alle',
        cardIds: const ['a', 'b'],
        startedAt: heute,
      );
      run = run.withAnswer('a', knewIt: true);
      final again = run.withAnswer('a', knewIt: false);
      expect(again.misses, isEmpty);
      expect(again.knownCount, 1);
    });

    test('Karten, die es nicht mehr gibt, fallen heraus', () {
      final run = CardRun(
        title: 'Alle',
        cardIds: const ['a', 'b', 'x'],
        known: const {'x'},
        startedAt: heute,
      ).restrictedTo({'a', 'b'});
      expect(run.cardIds, ['a', 'b']);
      expect(run.known, isEmpty);
    });

    test('JSON-Roundtrip erhält den Stand', () {
      final run = CardRun(
        title: 'Bereich 03',
        cardIds: const ['a', 'b'],
        topicIds: const {'netzwerke'},
        startedAt: heute,
      ).withAnswer('a', knewIt: false).withAnswer('b', knewIt: true);
      final back = CardRun.decode(run.encode());
      expect(back.title, 'Bereich 03');
      expect(back.cardIds, ['a', 'b']);
      expect(back.topicIds, {'netzwerke'});
      expect(back.known, {'b'});
      expect(back.misses, {'a': 1});
      expect(back.startedAt, heute);
    });
  });

  group('Schwächen und Aktivität', () {
    final cards = [
      for (final id in ['a', 'b', 'c'])
        Flashcard(id: id, topicId: 'netzplan', front: id, back: id),
    ];

    test('Schwächen: nur gesehene Karten, die danebengingen', () {
      var deck = const DeckState();
      deck = deck.withAnswer('a', false, now: heute);
      deck = deck.withAnswer('b', true, now: heute);
      deck = deck.withAnswer('b', true, now: heute);
      deck = deck.withAnswer('b', true, now: heute);
      expect(deck.weakCards(cards).map((c) => c.id), ['a']);
      expect(deck.weakness('c'), isNull);
      expect(deck.weakness('a')!, greaterThan(deck.weakness('b')!));
    });

    test('Trefferquote über alle Antworten', () {
      var deck = const DeckState();
      expect(deck.accuracy(cards), isNull);
      deck = deck.withAnswer('a', false, now: heute);
      deck = deck.withAnswer('b', true, now: heute);
      expect(deck.accuracy(cards), 0.5);
    });

    test('fällige Wiederholungen kommen vor neuen Karten desselben Fachs', () {
      var deck = const DeckState();
      deck = deck.withAnswer('c', false, now: DateTime(2026, 9, 18));
      final due = deck.due(cards, now: heute);
      expect(due.first.id, 'c');
    });

    test('Aktivität zählt je Tag und Tage in Folge', () {
      var a = const CardActivity();
      a = a.withAnswer(knewIt: true, now: DateTime(2026, 9, 18, 10));
      a = a.withAnswer(knewIt: false, now: DateTime(2026, 9, 19, 10));
      a = a.withAnswer(knewIt: true, now: DateTime(2026, 9, 20, 8));
      a = a.withAnswer(knewIt: true, now: DateTime(2026, 9, 20, 9));
      expect(a.reviewsOn(heute), 2);
      expect(a.streak(now: heute), 3);
      expect(a.lastDays(3, now: heute), [1, 1, 2]);
      expect(a.totalReviews, 4);
      final back = CardActivity.decode(a.encode());
      expect(back.days, a.days);
    });

    test('Streak zählt ab gestern, wenn heute noch nichts geübt wurde', () {
      final a = const CardActivity().withAnswer(
        knewIt: true,
        now: DateTime(2026, 9, 19),
      );
      expect(a.streak(now: heute), 1);
      expect(a.streak(now: DateTime(2026, 9, 22)), 0);
    });
  });

  group('Tageslimit für neue Karten', () {
    final many = [
      for (var i = 0; i < 50; i++)
        Flashcard(id: 'n$i', topicId: 'netzplan', front: 'F$i', back: 'B$i'),
    ];

    test('heute höchstens ${Leitner.newPerDay} neue Karten fällig', () {
      const deck = DeckState();
      expect(deck.dueCount(many, now: heute), Leitner.newPerDay);
      expect(deck.due(many, now: heute, limit: 99).length, Leitner.newPerDay);
    });

    test('heute eingeführte Karten verbrauchen das Limit', () {
      var deck = const DeckState();
      for (var i = 0; i < 5; i++) {
        deck = deck.withAnswer('n$i', true, now: heute);
      }
      expect(deck.newIntroducedOn(heute), 5);
      expect(deck.dueNewCount(many, now: heute), Leitner.newPerDay - 5);
    });

    test('neue Karten kommen in Lernreihenfolge', () {
      const deck = DeckState();
      final due = deck.due(many, now: heute, limit: 3);
      expect(due.map((c) => c.id), ['n0', 'n1', 'n2']);
    });

    test('erste Abfrage bleibt gespeichert', () {
      var deck = const DeckState().withAnswer('n1', false, now: heute);
      deck = deck.withAnswer('n1', true, now: DateTime(2026, 9, 25));
      final back = DeckState.decode(deck.encode());
      expect(back.stateOf('n1').firstSeen, heute);
    });
  });
}
