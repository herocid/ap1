import 'package:ap1_trainer/data/models/exam_area.dart';
import 'package:ap1_trainer/data/models/exam_case.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

/// Regeln für die Aufgabenarten im IHK-Stil und die Fallaufgaben der
/// Prüfungssimulation.
void main() {
  final all = kSeedQuestions;
  List<Question> of(QuestionKind k) => all.where((q) => q.kind == k).toList();

  final errors = <String>[];
  void check(bool ok, String id, String msg) {
    if (!ok) errors.add('$id: $msg');
  }

  setUp(errors.clear);
  void done() => expect(errors, isEmpty, reason: errors.join('\n'));

  /// Die fehlerfreie Antwort auf eine Aufgabe der neuen Arten.
  Object? perfect(Question q) => switch (q.kind) {
    QuestionKind.cloze => {
      for (var i = 0; i < q.gaps.length; i++) i: q.gaps[i].solution,
    },
    QuestionKind.table => {
      for (final e in q.gridGaps.entries) e.key: e.value.solution,
    },
    QuestionKind.open => OpenAnswer(
      checked: {for (var i = 0; i < q.criteria.length; i++) i},
    ),
    QuestionKind.marking => {
      for (var i = 0; i < q.choices.length; i++)
        if (q.choices[i].isCorrect) i,
    },
    QuestionKind.pairs => {for (var i = 0; i < q.pairs.length; i++) i: i},
    _ => null,
  };

  void checkGap(Blank g, String id, String where, {required bool hasBank}) {
    check(g.answers.isNotEmpty, id, '$where: keine Lösung');
    for (final a in g.answers) {
      check(a.trim().isNotEmpty, id, '$where: leere Lösung');
    }
    if (g.numeric) {
      check(parseNumber(g.solution) != null, id, '$where: keine Zahl');
    }
    if (g.options.isNotEmpty) {
      check(g.options.length >= 3, id, '$where: weniger als 3 Optionen');
      check(
        g.options.toSet().length == g.options.length,
        id,
        '$where: Optionen doppelt',
      );
      check(
        g.options.where(g.matches).length == 1,
        id,
        '$where: genau eine Option muss richtig sein',
      );
    } else if (!g.numeric && !hasBank) {
      // Getippte Antworten müssen kurz und eindeutig sein.
      check(
        g.solution.length <= 24,
        id,
        '$where: getippte Lösung "${g.solution}" ist zu lang - '
        'Auswahl (wahl) oder Wortbank nutzen',
      );
    }
    check(g.matches(g.solution), id, '$where: Lösung wird nicht akzeptiert');
  }

  test('Material-Tabellen sind rechteckig', () {
    for (final q in all.where((q) => q.table != null)) {
      final t = q.table!;
      check(t.length >= 2, q.id, 'Tabelle ohne Inhalt');
      for (final row in t) {
        check(row.length == t.first.length, q.id, 'Tabelle nicht rechteckig');
      }
    }
    done();
  });

  test('Lückentexte', () {
    for (final q in of(QuestionKind.cloze)) {
      final text = q.clozeText ?? '';
      check(q.gaps.isNotEmpty, q.id, 'keine Lücken');
      check(q.gaps.length <= 8, q.id, 'mehr als 8 Lücken');
      for (var i = 0; i < q.gaps.length; i++) {
        check(
          '{$i}'.allMatches(text).length == 1,
          q.id,
          'Platzhalter {$i} fehlt oder kommt mehrfach vor',
        );
        checkGap(q.gaps[i], q.id, 'Lücke $i', hasBank: q.wordBank.isNotEmpty);
      }
      check(
        !RegExp(r'\{\d+\}').allMatches(text).any((m) {
          final n = int.parse(m.group(0)!.replaceAll(RegExp(r'[{}]'), ''));
          return n >= q.gaps.length;
        }),
        q.id,
        'Platzhalter ohne Lücke',
      );
      for (final w in q.wordBank) {
        check(
          !q.gaps.any((g) => g.matches(w)),
          q.id,
          'Wortbank-Ablenker "$w" ist eine richtige Lösung',
        );
      }
    }
    done();
  });

  test('Tabellen zum Ausfüllen', () {
    for (final q in of(QuestionKind.table)) {
      check(q.grid.length >= 2, q.id, 'weniger als 2 Zeilen');
      if (q.grid.isEmpty) continue;
      final cols = q.grid.first.length;
      check(cols >= 2 && cols <= 5, q.id, '2-5 Spalten erlaubt, hat $cols');
      check(!q.grid.first.any((c) => c.isGap), q.id, 'Lücke in der Kopfzeile');
      for (final row in q.grid) {
        check(row.length == cols, q.id, 'Tabelle nicht rechteckig');
      }
      final gaps = q.gridGaps;
      check(gaps.isNotEmpty, q.id, 'keine Zelle auszufüllen');
      check(gaps.length <= 12, q.id, 'mehr als 12 Zellen auszufüllen');
      for (final e in gaps.entries) {
        checkGap(e.value, q.id, 'Zelle ${e.key}', hasBank: false);
      }
    }
    done();
  });

  test('Freitext-Aufgaben', () {
    for (final q in of(QuestionKind.open)) {
      check(q.criteria.isNotEmpty, q.id, 'keine Bewertungskriterien');
      check(
        (q.sampleSolution ?? '').trim().length >= 30,
        q.id,
        'Musterlösung fehlt oder ist zu kurz',
      );
      for (final c in q.criteria) {
        check(c.points >= 1, q.id, 'Kriterium ohne Punkte');
        check(c.text.trim().length >= 8, q.id, 'Kriterium zu kurz');
        check(
          c.keywords.isNotEmpty,
          q.id,
          'Kriterium "${c.text}" ohne Stichwörter',
        );
      }
      final sum = q.criteria.fold<int>(0, (s, c) => s + c.points);
      check(
        q.pointsOverride == null || q.pointsOverride! <= sum,
        q.id,
        'punkte (${q.pointsOverride}) größer als Summe der Kriterien ($sum)',
      );
    }
    done();
  });

  test('Markieren-Aufgaben', () {
    for (final q in of(QuestionKind.marking)) {
      check(q.choices.length >= 4, q.id, 'weniger als 4 Zeilen');
      check(q.choices.any((c) => c.isCorrect), q.id, 'nichts zu markieren');
      check(q.choices.any((c) => !c.isCorrect), q.id, 'alles zu markieren');
      for (final c in q.choices) {
        check(c.rationale.trim().isNotEmpty, q.id, 'Zeile ohne Begründung');
      }
    }
    done();
  });

  test('Paare finden', () {
    for (final q in of(QuestionKind.pairs)) {
      check(
        q.pairs.length >= 3 && q.pairs.length <= 6,
        q.id,
        '3-6 Paare erlaubt, hat ${q.pairs.length}',
      );
      check(
        q.pairs.map((p) => p.left).toSet().length == q.pairs.length,
        q.id,
        'linke Seite doppelt',
      );
      check(
        q.pairs.map((p) => p.right).toSet().length == q.pairs.length,
        q.id,
        'rechte Seite doppelt',
      );
    }
    done();
  });

  test(
    'neue Aufgabenarten: Musterantwort gibt volle, keine Antwort null Punkte',
    () {
      for (final q in all) {
        final p = perfect(q);
        if (p == null) continue;
        final Object typed = switch (q.kind) {
          QuestionKind.cloze => (p as Map).cast<int, String>(),
          QuestionKind.table => (p as Map).cast<String, String>(),
          QuestionKind.marking => (p as Set).cast<int>(),
          QuestionKind.pairs => (p as Map).cast<int, int>(),
          _ => p,
        };
        check(
          q.grade(typed).isCorrect,
          q.id,
          'Musterantwort nicht voll bewertet',
        );
        check(q.grade(null).score == 0, q.id, 'leere Antwort gibt Punkte');
      }
      done();
    },
  );

  test('JSON-Roundtrip aller Aufgaben', () {
    for (final q in all) {
      final back = Question.fromJson(q.toJson());
      expect(back.toJson(), q.toJson(), reason: q.id);
    }
  });

  group('Fallaufgaben', () {
    final cases = kSeedCases;

    test('IDs eindeutig, Unternehmen und Bereich bekannt', () {
      final ids = cases.map((c) => c.id).toList();
      expect(ids.toSet().length, ids.length);
      final companies = ExamCompanies.all.map((c) => c.id).toSet();
      final areas = ExamAreas.all.map((a) => a.id).toSet();
      for (final c in cases) {
        check(companies.contains(c.companyId), c.id, 'Unternehmen unbekannt');
        check(areas.contains(c.areaId), c.id, 'Bereich unbekannt');
        check(c.title.trim().length >= 8, c.id, 'Titel zu kurz');
        check(c.situation.trim().length >= 80, c.id, 'Situation zu kurz');
      }
      done();
    });

    test('jede Fallaufgabe: 4-8 Teilaufgaben, zusammen 25 Punkte', () {
      for (final c in cases) {
        check(
          c.parts.length >= 4 && c.parts.length <= 8,
          c.id,
          '${c.parts.length} Teilaufgaben',
        );
        check(c.points == 25, c.id, '${c.points} statt 25 Punkte');
        for (final q in c.parts) {
          check(q.caseId == c.id, q.id, 'caseId fehlt');
          check(q.pointsOverride != null, q.id, 'Teilaufgabe ohne punkte:');
          check(q.subtopicId != null, q.id, 'Teilaufgabe ohne Lektion');
        }
      }
      done();
    });

    test('jede Fallaufgabe mischt die Formate wie die IHK', () {
      for (final c in cases) {
        final kinds = c.parts.map((q) => q.kind).toList();
        check(kinds.toSet().length >= 3, c.id, 'weniger als 3 Aufgabenarten');
        final choice = kinds
            .where(
              (k) => k == QuestionKind.single || k == QuestionKind.multiple,
            )
            .length;
        check(choice <= 1, c.id, 'höchstens eine Auswahlaufgabe, hat $choice');
        check(
          kinds.contains(QuestionKind.open),
          c.id,
          'keine Freitext-Teilaufgabe',
        );
      }
      done();
    });

    test('Teilaufgaben-IDs kollidieren mit keiner anderen Aufgabe', () {
      final ids = all.map((q) => q.id).toList();
      final seen = <String>{};
      for (final id in ids) {
        check(seen.add(id), id, 'ID doppelt');
      }
      done();
    });
  });
}
