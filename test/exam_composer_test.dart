import 'package:ap1_trainer/core/util/answer_format.dart';
import 'package:ap1_trainer/core/util/exam_composer.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/exam_fixtures.dart';

void main() {
  final all = fullCaseSet();

  group('Volle Prüfung aus Fallaufgaben', () {
    test('ein Unternehmen, vier Aufgaben, 100 Punkte', () {
      for (var seed = 0; seed < 40; seed++) {
        final paper = ExamComposer.fromCases(cases: all, tasks: 4, seed: seed)!;
        expect(paper.tasks, hasLength(4));
        expect(paper.points, 100);
        expect(paper.company, isNotNull);
        expect(
          paper.tasks.map((t) => t.examCase!.companyId).toSet(),
          {paper.company!.id},
          reason: 'alle Aufgaben hängen an einem Unternehmen',
        );
        expect(paper.tasks.every((t) => t.otherCompany == null), isTrue);
      }
    });

    test('Bereiche wie in der echten Prüfung: 03, 04, 06 und ein weiterer', () {
      for (var seed = 0; seed < 40; seed++) {
        final paper = ExamComposer.fromCases(cases: all, tasks: 4, seed: seed)!;
        final areas = paper.tasks.map((t) => t.areaId!).toList();
        expect(areas.toSet(), hasLength(4), reason: 'verschiedene Bereiche');
        expect(areas, containsAll(['a03', 'a04', 'a06']));
        expect(['a01', 'a02', 'a05', 'a07'], contains(areas.first));
        // Reihenfolge wie auf dem Bogen: Rest, Systeme, Sicherheit,
        // Entwicklung.
        expect(areas.sublist(1), ['a03', 'a06', 'a04']);
      }
    });

    test('das Unternehmen wechselt von Lauf zu Lauf', () {
      final companies = {
        for (var seed = 0; seed < 60; seed++)
          ExamComposer.fromCases(cases: all, tasks: 4, seed: seed)!.company!.id,
      };
      expect(companies.length, greaterThan(1));
    });

    test('zuletzt gesehene Fälle werden gemieden', () {
      final handel = all.where((c) => c.companyId == 'handel').toList();
      final a03 = handel.where((c) => c.areaId == 'a03').toList();
      final a04 = handel.where((c) => c.areaId == 'a04').toList();
      expect(a03, hasLength(2));
      final seen = {
        a03.first.id: DateTime(2026, 9, 30),
        a04.last.id: DateTime(2026, 9, 30),
      };
      for (var seed = 0; seed < 30; seed++) {
        final paper = ExamComposer.fromCases(
          cases: handel,
          tasks: 4,
          lastSeen: seen,
          seed: seed,
        )!;
        final ids = paper.tasks.map((t) => t.examCase!.id).toSet();
        expect(ids, contains(a03.last.id));
        expect(ids, contains(a04.first.id));
      }
    });

    test('sind alle gesehen, kommt der am längsten zurückliegende', () {
      final handel = all.where((c) => c.companyId == 'handel').toList();
      final a03 = handel.where((c) => c.areaId == 'a03').toList();
      final seen = {
        for (final c in handel) c.id: DateTime(2026, 9, 20),
        a03.first.id: DateTime(2026, 8, 1),
      };
      final paper = ExamComposer.fromCases(
        cases: handel,
        tasks: 4,
        lastSeen: seen,
        seed: 1,
      )!;
      expect(paper.tasks[1].examCase!.id, a03.first.id);
    });

    test('bevorzugt das Unternehmen mit noch nicht gesehenen Fällen', () {
      final seen = {
        for (final c in all)
          if (c.companyId != 'agentur') c.id: DateTime(2026, 9, 1),
      };
      for (var seed = 0; seed < 20; seed++) {
        final paper = ExamComposer.fromCases(
          cases: all,
          tasks: 4,
          lastSeen: seen,
          seed: seed,
        )!;
        expect(paper.company!.id, 'agentur');
      }
    });
  });

  group('Auffüllen und Rückfall', () {
    test('fehlt dem Unternehmen ein Bereich, füllt ein anderes auf', () {
      final cases = [
        testCase('h1', 'handel', 'a01'),
        testCase('h3', 'handel', 'a03'),
        testCase('h4', 'handel', 'a04'),
        testCase('g6', 'agentur', 'a06'),
      ];
      final paper = ExamComposer.fromCases(cases: cases, tasks: 4, seed: 5)!;
      expect(paper.company!.id, 'handel');
      expect(paper.tasks.map((t) => t.areaId), ['a01', 'a03', 'a06', 'a04']);
      final foreign = paper.tasks.where((t) => t.otherCompany != null);
      expect(foreign.single.examCase!.id, 'g6');
      expect(foreign.single.otherCompany!.id, 'agentur');
    });

    test('fehlt ein Bereich ganz, kommt ein anderer freier Fall', () {
      final cases = [
        testCase('h3a', 'handel', 'a03'),
        testCase('h3b', 'handel', 'a03'),
        testCase('h4', 'handel', 'a04'),
        testCase('h7', 'handel', 'a07'),
      ];
      final paper = ExamComposer.fromCases(cases: cases, tasks: 4, seed: 2)!;
      expect(paper.tasks, hasLength(4));
      expect(paper.tasks.map((t) => t.examCase!.id).toSet(), {
        'h3a',
        'h3b',
        'h4',
        'h7',
      });
    });

    test('weniger als vier Fälle: Rückfall auf gemischte Aufgaben', () {
      final few = all.take(3).toList();
      expect(ExamComposer.fromCases(cases: few, tasks: 4, seed: 1), isNull);
      expect(ExamComposer.fromCases(cases: few, tasks: 1, seed: 1), isNull);
      expect(ExamComposer.fromCases(cases: const [], tasks: 4), isNull);

      final paper = ExamComposer.compose(
        cases: few,
        pool: kSeedQuestions,
        tasks: 4,
        seed: 3,
      );
      expect(paper.company, isNull);
      expect(paper.fromCases, isFalse);
      expect(paper.tasks, hasLength(4));
      final qs = paper.questions;
      expect(qs, hasLength(32));
      expect(qs.map((q) => q.id).toSet(), hasLength(32));
      expect(qs.every((q) => q.isExamRelevant), isTrue);
      // Auch der Ersatzbogen hält den Formatmix ein.
      final choices = qs.where(FormatMix.isChoice).length;
      expect(choices, lessThanOrEqualTo((32 * 0.3).round()));
    });

    test('ab vier Fällen kommen ausschließlich Fallaufgaben', () {
      final paper = ExamComposer.compose(
        cases: all,
        pool: kSeedQuestions,
        tasks: 4,
        seed: 3,
      );
      expect(paper.fromCases, isTrue);
      expect(paper.questions.every((q) => q.caseId != null), isTrue);
    });
  });

  group('Halbe Prüfung und eine Aufgabe', () {
    test('halbe Prüfung: zwei Aufgaben aus verschiedenen Bereichen, 50 P.', () {
      for (var seed = 0; seed < 40; seed++) {
        final paper = ExamComposer.fromCases(cases: all, tasks: 2, seed: seed)!;
        expect(paper.tasks, hasLength(2));
        expect(paper.points, 50);
        expect(paper.tasks.map((t) => t.areaId).toSet(), hasLength(2));
        expect(paper.tasks.every((t) => t.otherCompany == null), isTrue);
      }
    });

    test('eine Aufgabe: 25 Punkte, Bereich 04 am häufigsten', () {
      final count = <String, int>{};
      for (var seed = 0; seed < 300; seed++) {
        final paper = ExamComposer.fromCases(cases: all, tasks: 1, seed: seed)!;
        expect(paper.tasks, hasLength(1));
        expect(paper.points, 25);
        final a = paper.tasks.single.areaId!;
        count[a] = (count[a] ?? 0) + 1;
      }
      expect(count['a04']!, greaterThan(count['a06']!));
      expect(count['a03']!, greaterThan(count['a06']!));
    });

    test('Varianten: Punkte und Zeit im Verhältnis der echten Prüfung', () {
      expect(kExamVariants.map((v) => v.tasks), [4, 2, 1]);
      expect(kExamVariants.map((v) => v.points), [100, 50, 25]);
      expect(kExamVariants.map((v) => v.minutes), [90, 45, 22]);
      expect(ExamComposer.guideTime(100), const Duration(minutes: 90));
    });
  });

  group('Prüfungsaufgabe des Tages', () {
    test('am selben Tag dieselbe, an anderen Tagen eine andere', () {
      final a = ExamComposer.daily(cases: all, day: DateTime(2026, 10, 1, 7));
      final b = ExamComposer.daily(cases: all, day: DateTime(2026, 10, 1, 23));
      final c = ExamComposer.daily(cases: all, day: DateTime(2026, 10, 2, 9));
      expect(a!.tasks.single.examCase!.id, b!.tasks.single.examCase!.id);
      expect(a.tasks.single.examCase!.id, isNot(c!.tasks.single.examCase!.id));
      expect(a.points, 25);
      expect(a.company, isNotNull);
    });

    test('unabhängig von der Reihenfolge der Fälle', () {
      final day = DateTime(2026, 11, 5);
      final a = ExamComposer.daily(cases: all, day: day)!;
      final b = ExamComposer.daily(cases: all.reversed.toList(), day: day)!;
      expect(a.tasks.single.examCase!.id, b.tasks.single.examCase!.id);
    });

    test('jeder Fall kommt dran, bevor sich einer wiederholt', () {
      final ids = {
        for (var d = 0; d < all.length; d++)
          ExamComposer.daily(
            cases: all,
            day: DateTime(2026, 10, 1).add(Duration(days: d, hours: 3)),
          )!.tasks.single.examCase!.id,
      };
      expect(ids, hasLength(all.length));
    });

    test('ohne Fälle gibt es keine - immer eine Fallaufgabe', () {
      expect(
        ExamComposer.daily(cases: const [], day: DateTime(2026, 10, 1)),
        isNull,
      );
    });
  });

  group('Bogen', () {
    final paper = ExamComposer.fromCases(cases: all, tasks: 4, seed: 1)!;

    test('Teilaufgaben heißen a), b), c) … je Aufgabe', () {
      expect(paper.partCount, 24);
      expect(paper.startOf(0), 0);
      expect(paper.startOf(2), 12);
      expect(paper.taskAt(0), 0);
      expect(paper.taskAt(5), 0);
      expect(paper.taskAt(6), 1);
      expect(paper.taskAt(23), 3);
      expect(paper.partLabel(0), 'a)');
      expect(paper.partLabel(5), 'f)');
      expect(paper.partLabel(6), 'a)');
      expect(paper.questions[6].id, paper.tasks[1].parts.first.id);
    });

    test('zuletzt gesehen ergibt sich aus der Historie', () {
      final c = all.first;
      final seen = ExamComposer.lastSeenByCase(all, [
        AnswerRecord(
          questionId: c.parts[0].id,
          topicId: c.parts[0].topicId,
          score: 1,
          seconds: 10,
          at: DateTime(2026, 9, 1),
          mode: SessionMode.pruefung,
        ),
        AnswerRecord(
          questionId: c.parts[1].id,
          topicId: c.parts[1].topicId,
          score: 0,
          seconds: 10,
          at: DateTime(2026, 9, 12),
          mode: SessionMode.uebung,
        ),
        AnswerRecord(
          questionId: 'andere-aufgabe',
          topicId: 'netzplan',
          score: 0,
          seconds: 10,
          at: DateTime(2026, 9, 20),
          mode: SessionMode.uebung,
        ),
      ]);
      expect(seen, {c.id: DateTime(2026, 9, 12)});
    });
  });

  test('Notenschlüssel der IHK', () {
    expect(ihkNote(1.0).note, '1');
    expect(ihkNote(0.92).note, '1');
    expect(ihkNote(0.91).note, '2');
    expect(ihkNote(0.81).note, '2');
    expect(ihkNote(0.80).note, '3');
    expect(ihkNote(0.67).note, '3');
    expect(ihkNote(0.66).note, '4');
    expect(ihkNote(0.50).note, '4');
    expect(ihkNote(0.49).note, '5');
    expect(ihkNote(0.30).note, '5');
    expect(ihkNote(0.29).note, '6');
    expect(formatPoints(2.5), '2,5');
    expect(formatPoints(3), '3');
    expect(halfPoints(2.74), 2.5);
    expect(halfPoints(2.75), 3);
  });
}
