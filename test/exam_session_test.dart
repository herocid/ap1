import 'package:ap1_trainer/core/util/exam_composer.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:ap1_trainer/state/session_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/exam_fixtures.dart';

/// Ablauf eines Prüfungsbogens im Controller: Deckblatt, Abgabe,
/// Selbstbewertung der Freitext-Antworten, Buchung in die Statistik.
void main() {
  late HiveLocalStore store;
  late ProviderContainer container;

  setUp(() async {
    store = await HiveLocalStore.open(inMemory: true);
    container = ProviderContainer(
      overrides: [localStoreProvider.overrideWithValue(store)],
    );
  });
  tearDown(() async {
    container.dispose();
    await store.close();
  });

  final cases = fullCaseSet();
  ExamPaper paper(int tasks) =>
      ExamComposer.fromCases(cases: cases, tasks: tasks, seed: 4)!;

  SessionController c() => container.read(sessionProvider.notifier);
  SessionState s() => container.read(sessionProvider)!;

  void startExam({int tasks = 1, Duration? limit, bool cover = true}) =>
      c().startPaper(
        paper: paper(tasks),
        mode: SessionMode.pruefung,
        title: 'Volle Prüfung',
        limit: limit ?? const Duration(minutes: 90),
        cover: cover,
      );

  group('Prüfungsbogen', () {
    testWidgets('die Zeit läuft erst nach dem Deckblatt', (tester) async {
      startExam();
      expect(s().begun, isFalse);
      await tester.pump(const Duration(seconds: 5));
      expect(s().elapsed, Duration.zero);

      c().begin();
      await tester.pump(const Duration(seconds: 5));
      expect(s().elapsed, const Duration(seconds: 5));
      expect(s().current.seconds, 5, reason: 'Zeit je Teilaufgabe');
      c().clear();
      await tester.pump(const Duration(milliseconds: 10));
    });

    test('Teilaufgaben stehen in Bogenreihenfolge, 100 Punkte', () {
      startExam(tasks: 4, cover: false);
      expect(s().items, hasLength(24));
      expect(s().possiblePoints, 100);
      expect(s().paper!.tasks, hasLength(4));
      expect(s().deferredFeedback, isTrue);
      c().clear();
    });

    test('kein Feedback während der Prüfung', () {
      startExam(cover: false);
      c().jumpTo(3);
      c().setAnswer(<int>{0});
      c().check();
      expect(s().current.checked, isFalse);
      expect(s().current.grade, isNull);
      expect(container.read(progressProvider).history, isEmpty);
      // Die Antwort lässt sich bis zur Abgabe ändern.
      c().setAnswer(<int>{1});
      expect(s().current.answer, <int>{1});
      c().clear();
    });

    test('Abgabe öffnet zuerst die Selbstbewertung der Freitexte', () {
      startExam(cover: false);
      // a) Freitext: zwei der Kriterien erkennt die Stichwortsuche.
      c().setAnswer(const OpenAnswer(text: 'Der Preis und die Garantie'));
      c().jumpTo(1);
      c().setAnswer(30.0);
      c().jumpTo(3);
      c().setAnswer(<int>{0});
      c().finish();

      expect(s().reviewing, isTrue);
      expect(s().finished, isFalse);
      expect(s().openIndices, [0, 5]);
      expect(s().index, 0, reason: 'erste Freitext-Aufgabe');
      expect(
        container.read(progressProvider).history,
        isEmpty,
        reason: 'gebucht wird erst nach der Selbstbewertung',
      );

      // Vorschlag der Stichworterkennung: Kosten + Garantie = 4 von 6 P.
      expect(s().items[0].grade!.parts, {
        '0': true,
        '1': false,
        '2': true,
        '3': false,
      });
      expect(s().items[0].earned, 4);
      // Automatisch bewertete Teilaufgaben stehen schon fest.
      expect(s().items[1].earned, 4);
      expect(s().items[3].earned, 2);
      expect(s().items[2].earned, 0, reason: 'unbeantwortet');
    });

    test('Selbstbewertung ändert die Punkte, danach wird gebucht', () {
      startExam(cover: false);
      c().setAnswer(const OpenAnswer(text: 'Der Preis und die Garantie'));
      c().jumpTo(1);
      c().setAnswer(30.0);
      c().finish();

      // Der Prüfling hakt drei Kriterien ab: gedeckelt auf 6 Punkte.
      c().setAnswer(
        const OpenAnswer(
          text: 'Der Preis und die Garantie',
          checked: {0, 1, 2},
        ),
      );
      expect(s().items[0].earned, 6);
      // ... und nimmt einen Haken zurück.
      c().regradeAt(
        0,
        const OpenAnswer(text: 'Der Preis und die Garantie', checked: {0}),
      );
      expect(s().items[0].earned, 2);

      c().next();
      expect(s().index, 5, reason: 'nächste Freitext-Aufgabe');
      c().setAnswer(const OpenAnswer(checked: {0, 1}));
      expect(s().items[5].earned, 2);
      c().previous();
      expect(s().index, 0);
      c().next();
      c().next();
      expect(s().index, 5, reason: 'keine weitere Freitext-Aufgabe');

      c().completeReview();
      expect(s().finished, isTrue);
      expect(s().reviewing, isFalse);
      expect(s().earnedPoints, 2 + 4 + 2);
      expect(s().possiblePoints, 25);

      final history = container.read(progressProvider).history;
      expect(history, hasLength(6));
      expect(history.every((r) => r.mode == SessionMode.pruefung), isTrue);
      expect(
        history.map((r) => r.at).toSet(),
        hasLength(1),
        reason: 'ein Lauf, ein Zeitstempel',
      );
      expect(history[0].score, closeTo(2 / 6, 1e-9));
      expect(history[1].score, 1);
      expect(history[5].score, 0.5);
      // Streak und Abzeichen laufen weiter.
      expect(container.read(progressProvider).streak, 1);
    });

    test('Teilpunkte werden auf halbe Punkte gerundet', () {
      final table = cases.first.parts[2]; // 6 Punkte, zwei Zellen
      final item = SessionItem(
        question: table,
        grade: table.grade({'1.1': '62'}),
        checked: true,
      );
      expect(item.earned, 3);
      const third = SessionItem(
        question: Question(
          id: 'x',
          topicId: 'netzplan',
          kind: QuestionKind.matching,
          prompt: '',
          explanation: '',
          pointsOverride: 4,
        ),
        grade: GradeResult(score: 1 / 3, parts: {}),
      );
      expect(third.earned, 1.5, reason: '1,33 -> 1,5');
    });

    testWidgets('bei Zeitablauf wird automatisch abgegeben', (tester) async {
      startExam(limit: const Duration(seconds: 3), cover: false);
      c().jumpTo(1);
      c().setAnswer(30.0);
      await tester.pump(const Duration(seconds: 4));

      expect(s().timedOut, isTrue);
      expect(s().reviewing, isTrue);
      final elapsed = s().elapsed;
      // Während der Selbstbewertung steht die Uhr.
      await tester.pump(const Duration(seconds: 10));
      expect(s().elapsed, elapsed);

      c().completeReview();
      expect(s().finished, isTrue);
      expect(s().timedOut, isTrue);
      expect(s().earnedPoints, 4);
      // Riverpod plant seine Aktualisierung über einen Timer - ablaufen
      // lassen, bevor der Test endet.
      await tester.pump(const Duration(milliseconds: 10));
    });

    test('ohne Freitext-Aufgaben geht es direkt zur Auswertung', () {
      final closed = [
        for (final q in cases.first.parts)
          if (q.kind != QuestionKind.open) q,
      ];
      c().startPaper(
        paper: ExamPaper(
          tasks: [ExamTask(title: 'Test', situation: '', parts: closed)],
        ),
        mode: SessionMode.pruefung,
        title: 'Eine Aufgabe',
        cover: false,
      );
      c().finish();
      expect(s().finished, isTrue);
      expect(container.read(progressProvider).history, hasLength(4));
    });

    test('ein abgebrochener Bogen wird nicht gewertet', () {
      startExam(cover: false);
      c().setAnswer(const OpenAnswer(text: 'Preis'));
      c().finish();
      c().clear();
      expect(container.read(sessionProvider), isNull);
      expect(container.read(progressProvider).history, isEmpty);
    });

    test('Markieren zum späteren Nachsehen', () {
      startExam(cover: false);
      c().jumpTo(2);
      c().toggleFlag();
      expect(s().items[2].flagged, isTrue);
      c().toggleFlag();
      expect(s().items[2].flagged, isFalse);
      c().clear();
    });

    test('Aufgabe des Tages: gleicher Ablauf, zählt aber als Übung', () {
      final daily = ExamComposer.daily(
        cases: cases,
        day: DateTime(2026, 10, 1),
      )!;
      c().startPaper(
        paper: daily,
        mode: SessionMode.uebung,
        title: 'Prüfungsaufgabe des Tages',
        cover: false,
      );
      expect(s().isExam, isFalse);
      expect(s().deferredFeedback, isTrue);
      expect(s().begun, isTrue);
      expect(s().limit, isNull);
      c().check();
      expect(s().current.checked, isFalse);
      c().finish();
      expect(s().reviewing, isTrue);
      c().completeReview();
      final history = container.read(progressProvider).history;
      expect(history, hasLength(6));
      expect(history.every((r) => r.mode == SessionMode.uebung), isTrue);
    });
  });

  group('Freitext in der Übung', () {
    final open = cases.first.parts[0]; // 6 Punkte, Kriterien je 2 P.
    final single = kExamRelevantQuestions.firstWhere(
      (q) => q.kind == QuestionKind.single,
    );

    void start() => c().start(
      questions: [open, single],
      mode: SessionMode.uebung,
      title: 'Test',
    );

    test('Musterlösung lässt sich ohne getippte Antwort aufdecken', () {
      start();
      expect(s().current.hasAnswer, isFalse);
      c().check();
      expect(s().current.checked, isTrue);
      expect(s().current.earned, 0);
    });

    test('nach dem Prüfen wird mit jedem Haken neu bewertet', () {
      start();
      c().setAnswer(const OpenAnswer(text: 'Strom sparen'));
      c().check();
      expect(s().current.earned, 2, reason: 'Vorschlag: Energie erkannt');

      c().setAnswer(const OpenAnswer(text: 'Strom sparen', checked: {0, 3}));
      expect(s().current.earned, 4);
      expect(
        container.read(progressProvider).history,
        isEmpty,
        reason: 'gebucht wird erst beim Weitergehen',
      );

      c().next();
      final history = container.read(progressProvider).history;
      expect(history, hasLength(1));
      expect(history.single.score, closeTo(4 / 6, 1e-9));
      expect(s().index, 1);
    });

    test('andere Aufgaben bleiben nach dem Prüfen eingefroren', () {
      start();
      c().check();
      c().next();
      c().setAnswer(<int>{0});
      c().check();
      final before = s().current.answer;
      c().setAnswer(<int>{1});
      expect(s().current.answer, before);
      expect(container.read(progressProvider).history, hasLength(2));
    });

    test('auch beim Abbrechen geht die Freitext-Antwort nicht verloren', () {
      start();
      c().setAnswer(const OpenAnswer(text: 'Kosten', checked: {0}));
      c().check();
      c().clear();
      final history = container.read(progressProvider).history;
      expect(history, hasLength(1));
      expect(history.single.score, closeTo(2 / 6, 1e-9));
    });

    test('in der Auswertung ändert die Selbstbewertung nur die Anzeige', () {
      c().start(questions: [open], mode: SessionMode.uebung);
      c().check();
      c().finish();
      expect(s().finished, isTrue);
      c().regradeAt(0, const OpenAnswer(checked: {0, 1, 2}));
      expect(s().items[0].earned, 6);
      expect(container.read(progressProvider).history, hasLength(1));
      expect(container.read(progressProvider).history.single.score, 0);
    });
  });

  group('Fehler wiederholen in der Runde', () {
    final singles = kExamRelevantQuestions
        .where((q) => q.kind == QuestionKind.single)
        .take(6)
        .toList();
    Set<int> wrong(Question q) => {q.choices.indexWhere((c) => !c.isCorrect)};
    Set<int> right(Question q) => {q.choices.indexWhere((c) => c.isCorrect)};

    test('ein Fehler kommt nach drei anderen Aufgaben noch einmal', () {
      c().start(
        questions: singles,
        mode: SessionMode.fokus,
        title: 'Fehler wiederholen',
        requeueWrong: true,
      );
      c().setAnswer(wrong(singles[0]));
      c().check();
      expect(s().items, hasLength(7));
      expect(s().items[4].question.id, singles[0].id);
      expect(s().items[4].retry, isTrue);
      expect(
        s().items.sublist(1, 4).map((i) => i.question.id),
        singles.sublist(1, 4).map((q) => q.id),
      );
    });

    test('der zweite Anlauf wird nicht noch einmal angehängt', () {
      c().start(
        questions: singles,
        mode: SessionMode.fokus,
        requeueWrong: true,
      );
      c().setAnswer(wrong(singles[0]));
      c().check();
      for (var i = 0; i < 3; i++) {
        c().next();
        c().setAnswer(right(s().current.question));
        c().check();
      }
      c().next();
      expect(s().current.retry, isTrue);
      c().setAnswer(wrong(singles[0]));
      c().check();
      expect(s().items, hasLength(7));
    });

    test('richtige Antworten und Runden ohne Wiederholung bleiben', () {
      c().start(
        questions: singles,
        mode: SessionMode.fokus,
        requeueWrong: true,
      );
      c().setAnswer(right(singles[0]));
      c().check();
      expect(s().items, hasLength(6));

      c().start(questions: singles, mode: SessionMode.uebung);
      c().setAnswer(wrong(singles[0]));
      c().check();
      expect(s().items, hasLength(6));
    });

    test('am Ende der Runde gibt es kein sofortiges Wiederholen', () {
      c().start(
        questions: singles.take(2).toList(),
        mode: SessionMode.fokus,
        requeueWrong: true,
      );
      c().next();
      c().setAnswer(wrong(singles[1]));
      c().check();
      expect(s().items, hasLength(2));
    });
  });
}
