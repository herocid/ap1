import 'dart:math' as math;

import 'package:ap1_trainer/core/util/answer_format.dart';
import 'package:ap1_trainer/core/util/mistake_tracker.dart';
import 'package:ap1_trainer/core/util/question_selector.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

Question q(String id, QuestionKind kind, {String topic = 'netzplan'}) =>
    Question(
      id: id,
      topicId: topic,
      kind: kind,
      prompt: 'Aufgabe $id',
      explanation: 'Erklärung',
    );

/// Ein Pool wie nach dem Ausbau: viele Auswahlaufgaben, dazu alle anderen
/// Formate.
List<Question> mixedPool() => [
  for (var i = 0; i < 60; i++) q('s$i', QuestionKind.single),
  for (var i = 0; i < 20; i++) q('m$i', QuestionKind.multiple),
  for (var i = 0; i < 8; i++) q('n$i', QuestionKind.numeric),
  for (var i = 0; i < 8; i++) q('t$i', QuestionKind.table),
  for (var i = 0; i < 8; i++) q('o$i', QuestionKind.open),
  for (var i = 0; i < 8; i++) q('c$i', QuestionKind.cloze),
  for (var i = 0; i < 8; i++) q('z$i', QuestionKind.matching),
  for (var i = 0; i < 8; i++) q('p$i', QuestionKind.pairs),
];

int longestRun(List<Question> qs) {
  var best = 0;
  var run = 0;
  String? last;
  for (final x in qs) {
    final f = FormatMix.family(x);
    run = f == last ? run + 1 : 1;
    last = f;
    best = math.max(best, run);
  }
  return best;
}

void main() {
  final poolSize = kPoolSizeByTopic();

  group('Formatmix einer Runde', () {
    test('höchstens rund 30 % Auswahlaufgaben', () {
      for (var seed = 0; seed < 25; seed++) {
        final qs = QuestionSelector.forPractice(
          pool: mixedPool(),
          progress: const ProgressState(),
          poolSize: poolSize,
          count: 10,
          seed: seed,
        );
        expect(qs, hasLength(10));
        expect(qs.where(FormatMix.isChoice).length, lessThanOrEqualTo(3));
      }
    });

    test('keine drei Aufgaben derselben Art hintereinander', () {
      for (var seed = 0; seed < 25; seed++) {
        final qs = QuestionSelector.forPractice(
          pool: mixedPool(),
          progress: const ProgressState(),
          poolSize: poolSize,
          count: 10,
          seed: seed,
        );
        expect(longestRun(qs), lessThanOrEqualTo(2));
      }
    });

    test('mindestens eine Rechen-/Tabellen- und eine Freitext-Aufgabe', () {
      // Wenige davon im Pool und viel anderes: Die Garantie muss sie
      // trotzdem in die Runde holen.
      final pool = [
        for (var i = 0; i < 40; i++) q('s$i', QuestionKind.single),
        for (var i = 0; i < 40; i++) q('c$i', QuestionKind.cloze),
        for (var i = 0; i < 40; i++) q('z$i', QuestionKind.matching),
        q('n0', QuestionKind.numeric),
        q('o0', QuestionKind.open),
      ];
      for (var seed = 0; seed < 25; seed++) {
        final qs = QuestionSelector.forPractice(
          pool: pool,
          progress: const ProgressState(),
          poolSize: poolSize,
          count: 10,
          seed: seed,
        );
        expect(qs.where(FormatMix.isCalc), isNotEmpty);
        expect(qs.where(FormatMix.isOpen), isNotEmpty);
        expect(qs.map((x) => x.id).toSet(), hasLength(10));
      }
    });

    test('mit dem echten Pool: Mix, keine Dubletten, nur Prüfungsstoff', () {
      for (var seed = 0; seed < 10; seed++) {
        final qs = QuestionSelector.forPractice(
          pool: kSeedQuestions,
          progress: const ProgressState(),
          poolSize: poolSize,
          count: 10,
          seed: seed,
        );
        expect(qs, hasLength(10));
        expect(qs.map((x) => x.id).toSet(), hasLength(10));
        expect(qs.every((x) => x.isExamRelevant), isTrue);
        expect(qs.where(FormatMix.isChoice).length, lessThanOrEqualTo(3));
        expect(qs.where(FormatMix.isCalc), isNotEmpty);
        expect(longestRun(qs), lessThanOrEqualTo(2));
      }
    });

    test('gibt es fast nur Auswahlaufgaben, wird die Runde trotzdem voll', () {
      final pool = [
        for (var i = 0; i < 30; i++) q('s$i', QuestionKind.single),
        q('n0', QuestionKind.numeric),
        q('o0', QuestionKind.open),
      ];
      final qs = QuestionSelector.mixFormats(pool, count: 10);
      expect(qs, hasLength(10));
      expect(qs.where(FormatMix.isChoice).length, 8);
    });

    test('offene Fehler kommen immer, auch wenn es Auswahlaufgaben sind', () {
      final ranked = [
        for (var i = 0; i < 6; i++) q('s$i', QuestionKind.single),
        for (var i = 0; i < 10; i++) q('c$i', QuestionKind.cloze),
      ];
      final qs = QuestionSelector.mixFormats(
        ranked,
        count: 8,
        pinned: {'s0', 's1', 's2', 's3', 's4'},
      );
      expect(qs.map((x) => x.id), containsAll(['s0', 's1', 's2', 's3', 's4']));
      expect(qs, hasLength(8));
    });

    test('die Rangfolge bleibt innerhalb eines Formats erhalten', () {
      final ranked = [
        q('s0', QuestionKind.single),
        q('s1', QuestionKind.single),
        q('c0', QuestionKind.cloze),
        q('s2', QuestionKind.single),
        q('s3', QuestionKind.single),
        q('c1', QuestionKind.cloze),
        q('c2', QuestionKind.cloze),
        q('c3', QuestionKind.cloze),
      ];
      final ids = QuestionSelector.mixFormats(
        ranked,
        count: 4,
      ).map((x) => x.id).toList();
      // Deckel bei vier Aufgaben: eine Auswahlaufgabe - die ranghöchste.
      expect(ids, ['s0', 'c0', 'c1', 'c2']);
    });

    test('Reihenfolge: eine überwiegende Art wird verteilt', () {
      final items = [
        for (var i = 0; i < 7; i++) q('c$i', QuestionKind.cloze),
        for (var i = 0; i < 3; i++) q('n$i', QuestionKind.numeric),
      ];
      final out = QuestionSelector.arrange(items);
      expect(out, hasLength(10));
      expect(out.map((x) => x.id).toSet(), hasLength(10));
      expect(longestRun(out), lessThanOrEqualTo(2));
    });

    test('Einfach- und Mehrfachauswahl gelten als dieselbe Art', () {
      final out = QuestionSelector.arrange([
        q('s0', QuestionKind.single),
        q('m0', QuestionKind.multiple),
        q('s1', QuestionKind.single),
        q('n0', QuestionKind.numeric),
        q('n1', QuestionKind.numeric),
      ]);
      expect(longestRun(out), lessThanOrEqualTo(2));
    });

    test('Teilaufgaben von Fallaufgaben dürfen einzeln vorkommen', () {
      final part = q('fall-1-a', QuestionKind.table).inCase('fall-1');
      final qs = QuestionSelector.forPractice(
        pool: [part, q('s0', QuestionKind.single)],
        progress: const ProgressState(),
        poolSize: poolSize,
        count: 10,
        seed: 1,
      );
      expect(qs.map((x) => x.id), contains('fall-1-a'));
    });
  });

  group('Kurztest (endlos)', () {
    test('hält den Formatmix über viele Aufgaben', () {
      final pool = mixedPool();
      for (var seed = 0; seed < 10; seed++) {
        final rnd = math.Random(seed);
        final asked = <Question>[];
        for (var i = 0; i < 40; i++) {
          asked.add(QuestionSelector.nextEndless(pool, asked, rnd)!);
        }
        expect(asked.map((x) => x.id).toSet(), hasLength(40));
        expect(
          asked.where(FormatMix.isChoice).length,
          lessThanOrEqualTo(12),
          reason: 'höchstens 30 % Auswahl',
        );
        expect(longestRun(asked), lessThanOrEqualTo(2));
        for (var from = 0; from + 10 <= asked.length; from += 10) {
          final block = asked.sublist(from, from + 10);
          expect(block.where(FormatMix.isCalc), isNotEmpty);
          expect(block.where(FormatMix.isOpen), isNotEmpty);
        }
      }
    });

    test('nur Auswahlaufgaben im Pool: es geht trotzdem weiter', () {
      final pool = [for (var i = 0; i < 5; i++) q('s$i', QuestionKind.single)];
      final rnd = math.Random(1);
      final asked = <Question>[];
      for (var i = 0; i < 12; i++) {
        asked.add(QuestionSelector.nextEndless(pool, asked, rnd)!);
      }
      expect(asked, hasLength(12));
      expect(asked.take(5).map((x) => x.id).toSet(), hasLength(5));
    });
  });

  group('Fehler wiederholen mit Abstand', () {
    final today = DateTime(2026, 10, 1, 18);
    AnswerRecord rec(String id, double score, DateTime at) => AnswerRecord(
      questionId: id,
      topicId: 'netzplan',
      score: score,
      seconds: 20,
      at: at,
      mode: SessionMode.uebung,
    );
    DateTime day(int daysAgo, [int hour = 10]) =>
        DateTime(2026, 10, 1, hour).subtract(Duration(days: daysAgo));

    test('ein Fehler ist offen und heute fällig', () {
      final s = MistakeStatus.of([rec('a', 0, day(1))], now: today);
      expect(s.open, {'a'});
      expect(s.due, {'a'});
    });

    test('Teilpunkte gelten als Fehler', () {
      final s = MistakeStatus.of([rec('a', 0.5, day(0))], now: today);
      expect(s.due, {'a'});
    });

    test('heute richtig: bleibt offen, ist aber erst morgen wieder dran', () {
      final s = MistakeStatus.of([
        rec('a', 0, day(0, 9)),
        rec('a', 1, day(0, 10)),
        rec('a', 1, day(0, 11)),
      ], now: today);
      expect(s.open, {'a'});
      expect(s.due, isEmpty);
      expect(s.waiting, {'a'});
    });

    test('an einem früheren Tag richtig: heute der zweite Anlauf', () {
      final s = MistakeStatus.of([
        rec('a', 0, day(3)),
        rec('a', 1, day(2)),
      ], now: today);
      expect(s.open, {'a'});
      expect(s.due, {'a'});
    });

    test('an zwei verschiedenen Tagen richtig: erledigt', () {
      final s = MistakeStatus.of([
        rec('a', 0, day(3)),
        rec('a', 1, day(2)),
        rec('a', 1, day(0)),
      ], now: today);
      expect(s.open, isEmpty);
    });

    test('ein neuer Fehler setzt die Zählung zurück', () {
      final s = MistakeStatus.of([
        rec('a', 0, day(5)),
        rec('a', 1, day(4)),
        rec('a', 0, day(2)),
        rec('a', 1, day(1)),
      ], now: today);
      expect(s.open, {'a'});
      expect(s.due, {'a'});
    });

    test('nie falsch beantwortet: kein Fehler', () {
      final s = MistakeStatus.of([rec('a', 1, day(1))], now: today);
      expect(s.open, isEmpty);
    });

    test('die Runde enthält nur die fälligen Fehler', () {
      final ids = kExamRelevantQuestions.take(6).map((x) => x.id).toList();
      final qs = QuestionSelector.forPractice(
        pool: kSeedQuestions,
        progress: const ProgressState(),
        poolSize: poolSize,
        mistakesOnly: true,
        mistakeIds: ids.take(4).toSet(),
        seed: 1,
      );
      expect(qs.map((x) => x.id).toSet(), ids.take(4).toSet());
    });
  });

  group('Antwortformate der Auswertung', () {
    test('Zuordnung der Aufgabenarten', () {
      expect(
        AnswerFormat.of(q('a', QuestionKind.open)),
        AnswerFormat.formulieren,
      );
      expect(
        AnswerFormat.of(q('a', QuestionKind.numeric)),
        AnswerFormat.rechnen,
      );
      expect(AnswerFormat.of(q('a', QuestionKind.table)), AnswerFormat.tabelle);
      expect(AnswerFormat.of(q('a', QuestionKind.cloze)), AnswerFormat.tabelle);
      expect(
        AnswerFormat.of(q('a', QuestionKind.netzplan)),
        AnswerFormat.diagramm,
      );
      expect(
        AnswerFormat.of(q('a', QuestionKind.matching)),
        AnswerFormat.zuordnen,
      );
      expect(
        AnswerFormat.of(q('a', QuestionKind.single)),
        AnswerFormat.auswahl,
      );
      expect(
        AnswerFormat.of(
          const Question(
            id: 'x',
            topicId: 'programmierlogik',
            kind: QuestionKind.cloze,
            prompt: 'Pseudocode ergänzen',
            explanation: '',
            mono: true,
          ),
        ),
        AnswerFormat.code,
      );
    });
  });
}
