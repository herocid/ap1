import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/seed/builders_ihk.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/widgets/hyphenation.dart';
import 'package:ap1_trainer/widgets/question_types/question_material.dart';
import 'package:ap1_trainer/widgets/question_types/shuffle.dart';
import 'package:ap1_trainer/widgets/question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'question_types_samples.dart';

/// Keine erkennbaren Muster: Die Anzeige wird gemischt, die Bewertung
/// bleibt gleich.
void main() {
  /// Original-Indizes in der Reihenfolge, in der sie auf dem Bildschirm
  /// stehen (von oben nach unten).
  List<int> shown(WidgetTester tester, String prefix, int n) {
    final ys = {
      for (var i = 0; i < n; i++)
        i: tester.getTopLeft(find.byKey(ValueKey('$prefix-$i'))).dy,
    };
    return ys.keys.toList()..sort((a, b) => ys[a]!.compareTo(ys[b]!));
  }

  Future<List<int>> orderWith(
    WidgetTester tester,
    Question q,
    int seed,
    String prefix,
    int n,
  ) async {
    final host = QuestionHost(q, seed: seed);
    await tester.pumpWidget(
      KeyedSubtree(key: UniqueKey(), child: host.build()),
    );
    await tester.pumpAndSettle();
    return shown(tester, prefix, n);
  }

  test(
    'displayOrder: gleicher Seed gleich, verschiedene Seeds verschieden',
    () {
      expect(displayOrder(6, 42, salt: 'a'), displayOrder(6, 42, salt: 'a'));
      final orders = {
        for (var s = 0; s < 40; s++) displayOrder(6, s, salt: 'a').join(),
      };
      expect(orders.length, greaterThan(20));
      for (var s = 0; s < 40; s++) {
        final o = displayOrder(6, s);
        expect([...o]..sort(), [0, 1, 2, 3, 4, 5]);
        final avoid = displayOrder(5, s, avoidIdentity: true);
        expect(avoid, isNot([0, 1, 2, 3, 4]));
        final pinned = displayOrder(5, s, pinLast: (i) => i == 1);
        expect(pinned.last, 1);
      }
    },
  );

  test('Sammeloptionen werden erkannt', () {
    for (final t in [
      'Alle genannten',
      'Keine der genannten Antworten',
      'Keine der Aussagen trifft zu',
      'Beides',
      'Keine',
      'Alle drei',
      'Weder noch',
      'Nichts davon',
    ]) {
      expect(isCatchAllOption(t), isTrue, reason: t);
    }
    for (final t in [
      'Keine Normalform',
      'Alle Mitarbeitenden werden geschult',
      'Beide Server laufen im selben Rack und teilen sich die USV',
      'Verfügbarkeit',
    ]) {
      expect(isCatchAllOption(t), isFalse, reason: t);
    }
    expect(refersToPosition(['Antwort A und C', 'TCP']), isTrue);
    expect(refersToPosition(['Option 1', 'Option 2']), isTrue);
    expect(refersToPosition(['TCP', 'UDP']), isFalse);
  });

  testWidgets('Auswahl: gemischt, stabil, Sammeloption am Ende, Bewertung '
      'unverändert', (tester) async {
    final n = singleQuestion.choices.length;
    final a = await orderWith(tester, singleQuestion, 1, 'choice', n);
    final again = await orderWith(tester, singleQuestion, 1, 'choice', n);
    expect(again, a, reason: 'gleicher Seed, gleiche Reihenfolge');

    final orders = <String>{};
    final firsts = <int>{};
    for (var seed = 0; seed < 24; seed++) {
      final o = await orderWith(tester, singleQuestion, seed, 'choice', n);
      orders.add(o.join());
      firsts.add(o.first);
      expect(o.last, n - 1, reason: '„Keine der genannten“ bleibt am Ende');
    }
    expect(orders.length, greaterThan(6));
    expect(
      firsts.length,
      greaterThan(2),
      reason:
          'die richtige steht nicht '
          'immer oben',
    );

    // Egal wo die richtige Option steht: Antippen liefert ihren
    // Original-Index.
    for (final seed in [3, 4, 5]) {
      final host = QuestionHost(singleQuestion, seed: seed);
      await tester.pumpWidget(
        KeyedSubtree(key: UniqueKey(), child: host.build()),
      );
      await tester.tap(textOf('Verfügbarkeit'));
      await tester.pumpAndSettle();
      expect(host.answer, {0});
      expect(host.grade.isCorrect, isTrue);
    }
  });

  testWidgets('Mehrfachauswahl: Original-Indizes trotz Mischung', (
    tester,
  ) async {
    for (final seed in [1, 2, 3, 4]) {
      final host = QuestionHost(multiQuestion, seed: seed);
      await tester.pumpWidget(
        KeyedSubtree(key: UniqueKey(), child: host.build()),
      );
      await tester.tap(textOf('USV'));
      await tester.pumpAndSettle();
      await tester.tap(textOf('Redundantes Netzteil'));
      await tester.pumpAndSettle();
      expect(host.answer, {0, 1});
      expect(host.grade.isCorrect, isTrue);
    }
  });

  testWidgets('Zuordnung: Aussagen gemischt, Kategorien verraten nichts', (
    tester,
  ) async {
    final n = matchingQuestion.matchItems.length;
    final orders = <String>{};
    for (var seed = 0; seed < 12; seed++) {
      orders.add(
        (await orderWith(tester, matchingQuestion, seed, 'match', n)).join(),
      );
    }
    expect(orders.length, greaterThan(6));
    expect(
      await orderWith(tester, matchingQuestion, 5, 'match', n),
      await orderWith(tester, matchingQuestion, 5, 'match', n),
    );

    // Vor dem Prüfen sehen alle Kategorien gleich aus und stehen unter
    // jeder Aussage in derselben Reihenfolge.
    final host = QuestionHost(matchingQuestion, seed: 5);
    await tester.pumpWidget(
      KeyedSubtree(key: UniqueKey(), child: host.build()),
    );
    for (var i = 0; i < n; i++) {
      final row = find.byKey(ValueKey('match-$i'));
      final xs = [
        for (final b in matchingQuestion.buckets)
          tester.getTopLeft(find.descendant(of: row, matching: textOf(b))).dx,
      ];
      expect(xs, [...xs]..sort(), reason: 'Aussage $i');
      final colors = tester
          .widgetList<Material>(
            find.descendant(of: row, matching: find.byType(Material)),
          )
          .map((m) => m.color)
          .toSet();
      expect(colors.length, 1, reason: 'kein Chip hervorgehoben');
      expect(
        find.descendant(of: row, matching: find.byIcon(Icons.check)),
        findsNothing,
      );
    }

    // Zuordnen über den Text liefert den Original-Index.
    final row = find.byKey(const ValueKey('match-4'));
    await tester.ensureVisible(row);
    await tester.tap(
      find.descendant(of: row, matching: textOf('Verfügbarkeit')),
    );
    await tester.pumpAndSettle();
    expect(host.answer, {4: 2});
    expect(host.grade.parts['4'], isTrue);
  });

  testWidgets('Paare: rechte Seite gemischt und nie in Lösungsreihenfolge', (
    tester,
  ) async {
    final n = pairsQuestion.pairs.length;
    final identity = List<int>.generate(n, (i) => i);
    final orders = <String>{};
    for (var seed = 0; seed < 16; seed++) {
      final o = await orderWith(tester, pairsQuestion, seed, 'right', n);
      expect(o, isNot(identity), reason: 'Seed $seed');
      orders.add(o.join());
      // Die linke Seite bleibt in der Reihenfolge der Aufgabe.
      expect(shown(tester, 'left', n), identity);
    }
    expect(orders.length, greaterThan(8));
    expect(
      await orderWith(tester, pairsQuestion, 9, 'right', n),
      await orderWith(tester, pairsQuestion, 9, 'right', n),
    );
  });

  testWidgets('Markieren: Liste gemischt, Code nicht', (tester) async {
    final n = markingList.choices.length;
    final orders = <String>{};
    for (var seed = 0; seed < 12; seed++) {
      orders.add(
        (await orderWith(tester, markingList, seed, 'mark', n)).join(),
      );
    }
    expect(orders.length, greaterThan(5));
    for (var seed = 0; seed < 6; seed++) {
      expect(await orderWith(tester, markingCode, seed, 'mark', 6), [
        0,
        1,
        2,
        3,
        4,
        5,
      ]);
    }
  });

  testWidgets('Reihenfolge: Start hängt am Seed und ist nie die Lösung', (
    tester,
  ) async {
    final starts = <String>{};
    for (var seed = 0; seed < 12; seed++) {
      final host = QuestionHost(orderingQuestion, seed: seed);
      await tester.pumpWidget(
        KeyedSubtree(key: UniqueKey(), child: host.build()),
      );
      await tester.pumpAndSettle();
      final order = host.answer! as List<int>;
      expect(order, isNot([0, 1, 2, 3]));
      starts.add(order.join());
    }
    expect(starts.length, greaterThan(3));
  });

  testWidgets('Lückentext: Auswahloptionen und Wortbank gemischt', (
    tester,
  ) async {
    final orders = <String>{};
    for (var seed = 0; seed < 12; seed++) {
      final host = QuestionHost(clozeSelect, seed: seed);
      await tester.pumpWidget(
        KeyedSubtree(key: UniqueKey(), child: host.build()),
      );
      await tester.tap(find.byKey(const ValueKey('gap-2')));
      await tester.pumpAndSettle();
      final opts = clozeSelect.gaps[2].options;
      final ys = {for (final o in opts) o: tester.getTopLeft(textOf(o)).dy};
      orders.add(
        (opts.toList()..sort((a, b) => ys[a]!.compareTo(ys[b]!))).join(),
      );
      await tester.tap(textOf('Transportschicht'));
      await tester.pumpAndSettle();
      expect(host.answer, {2: 'Transportschicht'});
    }
    expect(orders.length, greaterThan(4));

    final bank = <String>{};
    for (var seed = 0; seed < 12; seed++) {
      final host = QuestionHost(clozeBank, seed: seed);
      await tester.pumpWidget(
        KeyedSubtree(key: UniqueKey(), child: host.build()),
      );
      bank.add(
        [
          for (var j = 0; j < 5; j++)
            tester
                .widget<HyphenText>(
                  find.descendant(
                    of: find.byKey(ValueKey('bank-$j')),
                    matching: find.byType(HyphenText),
                  ),
                )
                .text,
        ].join('|'),
      );
    }
    expect(bank.length, greaterThan(6));
  });

  testWidgets(
    'ohne shuffleSeed: neu je Durchgang, stabil beim Zurückblättern',
    (tester) async {
      final n = singleQuestion.choices.length;
      Future<List<int>> pump({Object? answer, bool revealed = false}) async {
        await tester.pumpWidget(
          MaterialApp(
            key: UniqueKey(),
            theme: AppTheme.light(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: QuestionView(
                  question: singleQuestion,
                  answer: answer,
                  onChanged: (_) {},
                  revealed: revealed,
                ),
              ),
            ),
          ),
        );
        return shown(tester, 'choice', n);
      }

      // Frisch begonnen: jedes Mal neu gewürfelt.
      final fresh = <String>{};
      late List<int> last;
      for (var i = 0; i < 12; i++) {
        last = await pump();
        fresh.add(last.join());
      }
      expect(fresh.length, greaterThan(3));

      // Beantwortet zurückgeblättert bzw. in der Auswertung: wie zuletzt.
      expect(await pump(answer: <int>{2}), last);
      expect(await pump(answer: <int>{2}, revealed: true), last);
      expect(await pump(revealed: true), last);
    },
  );

  testWidgets('Fallaufgabe: Ausgangssituation einklappbar und abschaltbar', (
    tester,
  ) async {
    final c = fall(
      'ts-fall',
      firma: 'handel',
      bereich: 'a03',
      titel: 'Netzwerk der neuen Filiale planen',
      situation: 'Die Filiale Göttingen bekommt ein eigenes Subnetz.',
      teile: [singleQuestion, openQuestion],
    );
    kSeedCases.add(c);
    kCaseById[c.id] = c;
    addTearDown(() {
      kSeedCases.remove(c);
      kCaseById.remove(c.id);
    });

    Future<void> pump({bool show = true}) => tester.pumpWidget(
      MaterialApp(
        key: UniqueKey(),
        theme: AppTheme.light(),
        home: Scaffold(
          body: SingleChildScrollView(
            child: QuestionView(
              question: c.parts.first,
              answer: null,
              onChanged: (_) {},
              revealed: false,
              showCaseContext: show,
            ),
          ),
        ),
      ),
    );

    await pump();
    expect(textOf('AUSGANGSSITUATION'), findsOneWidget);
    expect(textOf('Grünwerk Gartenbedarf GmbH'), findsOneWidget);
    expect(textHas('eigenes Subnetz'), findsOneWidget);

    await tester.tap(textOf('AUSGANGSSITUATION'));
    await tester.pumpAndSettle();
    expect(textHas('eigenes Subnetz'), findsNothing);
    expect(textOf('Netzwerk der neuen Filiale planen'), findsOneWidget);

    // Bleibt für die nächste Teilaufgabe desselben Falls eingeklappt.
    await pump();
    expect(textHas('eigenes Subnetz'), findsNothing);
    await tester.tap(find.byType(CaseContextBox));
    await tester.pumpAndSettle();
    expect(textHas('eigenes Subnetz'), findsOneWidget);

    await pump(show: false);
    expect(find.byType(CaseContextBox), findsNothing);
  });
}
