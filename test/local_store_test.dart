import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/models/resume.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

AnswerRecord _answer(String id, {double score = 1, int day = 1}) =>
    AnswerRecord(
      questionId: id,
      topicId: 'netzplan',
      score: score,
      seconds: 30,
      at: DateTime(2026, 9, day, 10),
      mode: SessionMode.uebung,
    );

void main() {
  late HiveLocalStore store;

  setUp(() async => store = await HiveLocalStore.open(inMemory: true));
  tearDown(() => store.close());

  group('Fortschritt', () {
    test('angehängte Antworten bleiben in Reihenfolge erhalten', () async {
      await store.appendAnswers([_answer('q1'), _answer('q2', score: 0)]);
      await store.appendAnswers([_answer('q3')]);

      final ids = store.readProgress().history.map((r) => r.questionId);
      expect(ids, ['q1', 'q2', 'q3']);
    });

    test('Kennzahlen überschreiben, ohne die Historie anzufassen', () async {
      await store.appendAnswers([_answer('q1')]);
      await store.writeProgressMeta(
        ProgressState(
          streak: 4,
          longestStreak: 9,
          lastActiveDay: DateTime(2026, 9, 1),
          badges: const {Achievement.ersterTag},
        ),
      );

      final p = store.readProgress();
      expect(p.history, hasLength(1));
      expect(p.streak, 4);
      expect(p.longestStreak, 9);
      expect(p.badges, {Achievement.ersterTag});
    });

    test('clearProgress leert Historie und Kennzahlen', () async {
      await store.appendAnswers([_answer('q1')]);
      await store.writeProgressMeta(const ProgressState(streak: 3));
      await store.clearProgress();

      final p = store.readProgress();
      expect(p.history, isEmpty);
      expect(p.streak, 0);
    });
  });

  group('Learning Journey', () {
    test('merkt sich abgeschlossene Lektionen', () async {
      expect(store.readJourney(), isEmpty);
      await store.writeJourney({'n-grundlagen', 'n-vorwaerts'});
      expect(store.readJourney(), {'n-grundlagen', 'n-vorwaerts'});
    });
  });

  group('Karteikasten', () {
    test('speichert jede Karte einzeln', () async {
      final a = const CardState(cardId: 'c1').answer(knewIt: true);
      final b = const CardState(cardId: 'c2').answer(knewIt: false);
      await store.writeCardState(a);
      await store.writeCardState(b);
      await store.writeCardState(a.answer(knewIt: true));

      final deck = store.readDeck();
      expect(deck.cards.keys, unorderedEquals(['c1', 'c2']));
      expect(deck.stateOf('c1').box, 3);
      expect(deck.stateOf('c2').box, 1);
    });
  });

  group('Übernahme aus der Vorgängerversion', () {
    Future<SharedPreferences> legacyPrefs() async {
      final progress = ProgressState(
        history: [_answer('alt1'), _answer('alt2', score: 0, day: 2)],
        streak: 2,
        longestStreak: 5,
        lastActiveDay: DateTime(2026, 9, 2),
      );
      final deck = const DeckState().withAnswer('c-org-01', true);
      SharedPreferences.setMockInitialValues({
        'ap1.profile': UserProfile.initial()
            .copyWith(displayName: 'Marcel', onboarded: true)
            .encode(),
        'ap1.progress': progress.encode(),
        'ap1.seen_theory': ['t-netzplan'],
        'ap1.deck': deck.encode(),
      });
      return SharedPreferences.getInstance();
    }

    test('übernimmt Profil, Historie, Theorie und Karteikasten', () async {
      await store.migrateFrom(await legacyPrefs());

      expect(store.readProfile()?.displayName, 'Marcel');
      expect(store.readProfile()?.onboarded, isTrue);

      final p = store.readProgress();
      expect(p.history.map((r) => r.questionId), ['alt1', 'alt2']);
      expect(p.streak, 2);
      expect(p.longestStreak, 5);

      expect(store.readSeenTheory(), {'t-netzplan'});
      expect(store.readDeck().stateOf('c-org-01').box, 2);
    });

    test('löscht die alten Einträge danach', () async {
      final prefs = await legacyPrefs();
      await store.migrateFrom(prefs);

      expect(prefs.getKeys(), isEmpty);
    });

    test('ein zweiter Lauf erzeugt keine doppelten Antworten', () async {
      await store.migrateFrom(await legacyPrefs());
      // Simuliert einen Abbruch, bevor die alten Einträge gelöscht wurden.
      await store.migrateFrom(await legacyPrefs());

      expect(store.readProgress().history, hasLength(2));
    });

    test('ohne Altdaten passiert nichts', () async {
      SharedPreferences.setMockInitialValues({});
      await store.migrateFrom(await SharedPreferences.getInstance());

      expect(store.readProfile(), isNull);
      expect(store.readProgress().history, isEmpty);
    });
  });

  group('Durchlauf und Kartenaktivität', () {
    test('werden gespeichert und mit dem Kasten gelöscht', () async {
      final run = CardRun(
        title: 'Alle',
        cardIds: const ['a', 'b'],
        startedAt: DateTime(2026, 9, 20),
      ).withAnswer('a', knewIt: true);
      await store.writeCardRun(run);
      await store.writeCardActivity(
        const CardActivity().withAnswer(knewIt: true),
      );
      await store.writeCardState(const CardState(cardId: 'a', box: 2));

      expect(store.readCardRun()?.known, {'a'});
      expect(store.readCardActivity().totalReviews, 1);

      await store.clearDeck();
      expect(store.readCardRun(), isNull);
      expect(store.readCardActivity().totalReviews, 0);
      expect(store.readDeck().cards, isEmpty);
    });

    test('null löscht den Durchlauf', () async {
      await store.writeCardRun(
        CardRun(title: 'x', cardIds: const ['a'], startedAt: DateTime(2026)),
      );
      await store.writeCardRun(null);
      expect(store.readCardRun(), isNull);
    });
  });

  group('Lesezeichen', () {
    test('Lektion und Kartenrunde werden gespeichert', () async {
      await store.writeResume(
        ResumeState(
          lesson: LessonBookmark(
            lessonId: 'p-ziele',
            page: 4,
            at: DateTime(2026, 9, 20),
          ),
          cards: CardBookmark(
            mode: 'practice',
            title: 'Netzwerke',
            topicIds: const {'netzwerke'},
            at: DateTime(2026, 9, 20),
          ),
        ),
      );
      final r = store.readResume();
      expect(r.lesson?.lessonId, 'p-ziele');
      expect(r.lesson?.page, 4);
      expect(r.cards?.topicIds, {'netzwerke'});
    });

    test('ohne Eintrag leer', () {
      expect(store.readResume().lesson, isNull);
      expect(store.readResume().cards, isNull);
    });
  });
}
