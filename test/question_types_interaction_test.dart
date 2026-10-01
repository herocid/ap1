import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/seed/builders.dart';
import 'package:ap1_trainer/widgets/question_types/gap_field.dart';
import 'package:ap1_trainer/widgets/question_types/question_material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'question_types_samples.dart';

/// Bedienen -> `onChanged` liefert die erwartete Antwort -> `grade` stimmt.
void main() {
  Finder gap(String key) => find.byKey(ValueKey('gap-$key'));
  Finder field(String key) =>
      find.descendant(of: gap(key), matching: find.byType(TextField));

  Future<void> pick(WidgetTester tester, String key, String option) async {
    await tester.ensureVisible(gap(key));
    await tester.tap(gap(key));
    await tester.pumpAndSettle();
    await tester.tap(textOf(option).last);
    await tester.pumpAndSettle();
  }

  Future<void> tapKey(WidgetTester tester, String key) async {
    final f = find.byKey(ValueKey(key));
    await tester.ensureVisible(f);
    await tester.pumpAndSettle();
    await tester.tap(f);
    await tester.pumpAndSettle();
  }

  testWidgets('Lückentext mit Auswahl', (tester) async {
    final host = QuestionHost(clozeSelect);
    await tester.pumpWidget(host.build());
    expect(host.answer, isNull);

    await pick(tester, '0', 'TCP');
    await pick(tester, '1', 'UDP');
    await pick(tester, '2', 'Transportschicht');

    expect(host.answer, isA<Map<int, String>>());
    expect(host.answer, {0: 'TCP', 1: 'UDP', 2: 'Transportschicht'});
    expect(host.grade.isCorrect, isTrue);

    // Auswahl wieder entfernen.
    await tester.tap(gap('1'));
    await tester.pumpAndSettle();
    await tester.tap(textOf('Auswahl entfernen'));
    await tester.pumpAndSettle();
    expect(host.answer, {0: 'TCP', 2: 'Transportschicht'});
    expect(host.grade.score, closeTo(2 / 3, 1e-9));

    await host.check(tester);
    // Richtige Lösung und Begründung der offenen Lücke sind sichtbar.
    expect(textOf('UDP'), findsOneWidget);
    expect(textOf('UDP verzichtet auf Bestätigungen.'), findsOneWidget);
    expect(textOf('nicht ausgefüllt'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Lückentext mit Wortbank', (tester) async {
    final host = QuestionHost(clozeBank);
    await tester.pumpWidget(host.build());

    Finder chip(String word) =>
        find.ancestor(of: textOf(word), matching: find.byType(InkWell));

    // Alle Lösungen und beide Ablenker liegen in der Bank.
    for (final w in [
      'Werkvertrag',
      'Dienstvertrag',
      'Kaufvertrag',
      'Mietvertrag',
      'Leasingvertrag',
    ]) {
      expect(chip(w), findsOneWidget, reason: w);
    }

    // Antippen füllt die nächste freie Lücke.
    await tester.tap(chip('Werkvertrag'));
    await tester.pumpAndSettle();
    await tester.tap(chip('Mietvertrag'));
    await tester.pumpAndSettle();
    expect(host.answer, {0: 'Werkvertrag', 1: 'Mietvertrag'});

    // Tipp auf die gefüllte Lücke leert sie; der nächste Begriff landet dort.
    await tester.tap(gap('1'));
    await tester.pumpAndSettle();
    expect(host.answer, {0: 'Werkvertrag'});
    await tester.tap(chip('Dienstvertrag'));
    await tester.pumpAndSettle();
    await tester.tap(chip('Kaufvertrag'));
    await tester.pumpAndSettle();

    expect(host.answer, isA<Map<int, String>>());
    expect(host.answer, {
      0: 'Werkvertrag',
      1: 'Dienstvertrag',
      2: 'Kaufvertrag',
    });
    expect(host.grade.isCorrect, isTrue);

    // Alles leeren ergibt wieder „keine Antwort“.
    for (final i in ['0', '1', '2']) {
      await tester.tap(gap(i));
      await tester.pumpAndSettle();
    }
    expect(host.answer, isNull);
  });

  testWidgets('Lückentext mit Eingabe und Zahlen', (tester) async {
    final host = QuestionHost(clozeInput);
    await tester.pumpWidget(host.build());

    await tester.enterText(field('0'), '62');
    await tester.enterText(field('1'), '255.255.255.192');
    await tester.enterText(field('2'), '8,4');
    await tester.pumpAndSettle();

    expect(host.answer, {0: '62', 1: '255.255.255.192', 2: '8,4'});
    expect(host.grade.isCorrect, isTrue);

    // Zahlenlücken bekommen die Zahlentastatur, die Einheit steht dahinter.
    expect(
      tester.widget<TextField>(field('0')).keyboardType,
      const TextInputType.numberWithOptions(decimal: true, signed: true),
    );
    expect(
      tester.widget<TextField>(field('1')).keyboardType,
      TextInputType.text,
    );
    expect(textOf('Hosts'), findsOneWidget);
    expect(textOf('kWh'), findsOneWidget);

    await tester.enterText(field('0'), '');
    await tester.pumpAndSettle();
    expect((host.answer! as Map).containsKey(0), isFalse);
  });

  testWidgets('Lückentext: Modus je Lücke (Auswahl, Zahl, Wortbank)', (
    tester,
  ) async {
    final q = lueckentext(
      'ts-cloze-mixed',
      kSub,
      prompt: 'Ergänze.',
      text: 'Ein {0} hat {1} Bit und nutzt {2}.',
      luecken: [
        wort(['Byte']),
        zahl(8),
        wahl('Binärzahlen', ['Dezimalzahlen']),
      ],
      wortbank: ['Nibble'],
      explanation: 'Ein Byte besteht aus 8 Bit, gerechnet wird binär.',
    );
    expect(gapModeOf(q.gaps[0], hasWordBank: true), GapMode.bank);
    expect(gapModeOf(q.gaps[1], hasWordBank: true), GapMode.input);
    expect(gapModeOf(q.gaps[2], hasWordBank: true), GapMode.select);
    expect(gapModeOf(q.gaps[0]), GapMode.input);

    final host = QuestionHost(q);
    await tester.pumpWidget(host.build());
    // Die Zahl steht nicht in der Wortbank - sie wird getippt.
    expect(find.byKey(const ValueKey('bank-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('bank-2')), findsNothing);
    await tester.tap(
      find.ancestor(of: textOf('Byte'), matching: find.byType(InkWell)),
    );
    await tester.pumpAndSettle();
    await tester.enterText(field('1'), '8');
    await pick(tester, '2', 'Binärzahlen');
    expect(host.answer, {0: 'Byte', 1: '8', 2: 'Binärzahlen'});
    expect(host.grade.isCorrect, isTrue);
  });

  test('Material: hart umbrochener Fließtext wird wieder Fließtext', () {
    final text = prepareMaterial(
      'SECURING YOUR MAIL CLIENT\n\n'
      'To protect confidential messages, first install the\n'
      'latest security baseline provided by the vendor. Use a\n'
      'strong and unique password.\n\n'
      '- No default passwords: a password must be set\n'
      '  during first setup\n'
      '- Signed firmware',
    );
    expect(text.map((l) => l.text).toList(), [
      'SECURING YOUR MAIL CLIENT',
      '',
      'To protect confidential messages, first install the latest security '
          'baseline provided by the vendor. Use a strong and unique password.',
      '',
      'No default passwords: a password must be set during first setup',
      'Signed firmware',
    ]);
    expect(text[4].bullet, '-');
    expect(text.where((l) => !l.isBlank).every((l) => l.flow), isTrue);

    // Code, Pseudocode und Konfiguration behalten Zeilen und Einrückung.
    for (final code in [
      'summe = 0\nFÜR i = 0 BIS laenge(werte) - 1\n    summe = summe + werte[i]',
      'WENN alter GROESSER 18 DANN\nAUSGABE Hinweis anzeigen und weiter\nENDE WENN',
      'interface Gi0/1\n ip address 10.0.0.1 255.255.255.0\n no shutdown',
      'Power      65 W\nWeight     1.2 kg',
    ]) {
      final lines = prepareMaterial(code);
      expect(lines.length, code.split('\n').length, reason: code);
      expect(lines.any((l) => l.flow), isFalse, reason: code);
    }
    expect(prepareMaterial('a\n    b')[1].indent, 4);
  });

  testWidgets('Lückentext als Pseudocode', (tester) async {
    final host = QuestionHost(clozeCode);
    await tester.pumpWidget(host.build());

    await tester.enterText(field('0'), '0');
    await tester.enterText(field('1'), '1');
    await pick(tester, '2', '+');

    expect(host.answer, {0: '0', 1: '1', 2: '+'});
    expect(host.grade.isCorrect, isTrue);
    await host.check(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tabelle ausfüllen', (tester) async {
    final host = QuestionHost(tableQuestion);
    await tester.pumpWidget(host.build());

    await tester.enterText(field('1.3'), '6,2');
    await tester.enterText(field('2.3'), '6,4');
    await pick(tester, '3.3', 'Betacom');

    expect(host.answer, isA<Map<String, String>>());
    expect(host.answer, {'1.3': '6,2', '2.3': '6,4', '3.3': 'Betacom'});
    expect(host.grade.score, closeTo(2 / 3, 1e-9));
    expect(host.grade.parts, {'1.3': true, '2.3': false, '3.3': true});

    await tester.enterText(field('2.3'), '6,6');
    await tester.pumpAndSettle();
    expect(host.grade.isCorrect, isTrue);

    await host.check(tester);
    expect(textOf('Der höhere Nutzwert gewinnt.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tabelle: falsche Zelle zeigt die richtige Lösung', (
    tester,
  ) async {
    final host = QuestionHost(
      tableQuestion,
      answer: <String, String>{'2.3': '6,4'},
    );
    await tester.pumpWidget(host.build());
    await host.check(tester);
    expect(
      find.descendant(of: gap('2.3'), matching: textOf('richtig: 6,6')),
      findsOneWidget,
    );
  });

  testWidgets('Freitext mit Selbstbewertung', (tester) async {
    final host = QuestionHost(openQuestion);
    await tester.pumpWidget(host.build());
    expect(textOf('Stichworte genügen …'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Stromausfall überbrücken');
    await tester.pumpAndSettle();
    var a = host.answer! as OpenAnswer;
    expect(a.text, 'Stromausfall überbrücken');
    expect(a.checked, isNull, reason: 'vor dem Prüfen nicht selbst bewertet');

    // Leerer Text ohne Haken ist keine Antwort.
    await tester.enterText(find.byType(TextField), '  ');
    await tester.pumpAndSettle();
    expect(host.answer, isNull);
    await tester.enterText(find.byType(TextField), 'Stromausfall überbrücken');
    await tester.pumpAndSettle();

    await host.check(tester);
    expect(textOf('Vorschlag der App – bitte selbst prüfen'), findsOneWidget);
    expect(
      textOf('Die IHK wertet auch andere fachlich richtige Antworten.'),
      findsOneWidget,
    );
    expect(textHas('Eine USV überbrückt'), findsOneWidget);
    // Erkannt wurde nur das erste Kriterium: 1 von 2 Punkten.
    expect(textOf('1 / 2'), findsOneWidget);
    expect(host.grade.score, closeTo(0.5, 1e-9));

    // Abhaken ruft onChanged auch nach dem Prüfen.
    await tapKey(tester, 'krit-1');
    a = host.answer! as OpenAnswer;
    expect(a.checked, {0, 1});
    expect(a.text, 'Stromausfall überbrücken');
    expect(host.grade.isCorrect, isTrue);
    expect(textOf('2 / 2'), findsOneWidget);
    expect(textOf('Vorschlag der App – bitte selbst prüfen'), findsNothing);

    // Mehr Haken als verlangt: Punkte bleiben gedeckelt.
    await tapKey(tester, 'krit-2');
    expect((host.answer! as OpenAnswer).checked, {0, 1, 2});
    expect(textOf('2 / 2'), findsOneWidget);
    expect(host.grade.score, 1.0);

    await tapKey(tester, 'krit-0');
    await tapKey(tester, 'krit-1');
    await tapKey(tester, 'krit-2');
    expect((host.answer! as OpenAnswer).checked, isEmpty);
    expect(host.grade.score, 0);
    expect(textOf('0 / 2'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Markieren im Code', (tester) async {
    final host = QuestionHost(markingCode);
    await tester.pumpWidget(host.build());

    await tapKey(tester, 'mark-1');
    await tapKey(tester, 'mark-3');
    expect(host.answer, isA<Set<int>>());
    expect(host.answer, {1, 3});
    expect(host.grade.isCorrect, isFalse);

    await tapKey(tester, 'mark-3');
    await tapKey(tester, 'mark-4');
    expect(host.answer, {1, 4});
    expect(host.grade.isCorrect, isTrue);

    // Code behält seine Reihenfolge, egal mit welchem Seed.
    final ys = [
      for (var i = 0; i < 6; i++)
        tester.getTopLeft(find.byKey(ValueKey('mark-$i'))).dy,
    ];
    expect(ys, [...ys]..sort());

    await host.check(tester);
    expect(textOf('Richtig markiert'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Markieren in einer Liste', (tester) async {
    final host = QuestionHost(markingList);
    await tester.pumpWidget(host.build());
    await tapKey(tester, 'mark-0');
    await tapKey(tester, 'mark-1');
    expect(host.answer, {0, 1});
    await host.check(tester);
    expect(textOf('Falsch markiert'), findsOneWidget);
    expect(textOf('Übersehen – gehört markiert'), findsNWidgets(2));

    final empty = QuestionHost(markingList);
    await tester.pumpWidget(empty.build());
    await tapKey(tester, 'mark-2');
    await tapKey(tester, 'mark-2');
    expect(empty.answer, isNull);
  });

  testWidgets('Paare finden', (tester) async {
    final host = QuestionHost(pairsQuestion);
    await tester.pumpWidget(host.build());

    for (var i = 0; i < pairsQuestion.pairs.length; i++) {
      await tapKey(tester, 'left-$i');
      await tapKey(tester, 'right-$i');
    }
    expect(host.answer, isA<Map<int, int>>());
    expect(host.answer, {0: 0, 1: 1, 2: 2, 3: 3, 4: 4});
    expect(host.grade.isCorrect, isTrue);

    // Erneutes Antippen löst das Paar; neu verbinden nimmt dem alten
    // Partner das Gegenstück weg.
    await tapKey(tester, 'left-0');
    expect(host.answer, {1: 1, 2: 2, 3: 3, 4: 4});
    await tapKey(tester, 'right-1');
    expect(host.answer, {0: 1, 2: 2, 3: 3, 4: 4});
    expect(host.grade.score, closeTo(3 / 5, 1e-9));

    // Auch rechts zuerst funktioniert.
    await tapKey(tester, 'right-0');
    await tapKey(tester, 'left-1');
    expect(host.answer, {0: 1, 1: 0, 2: 2, 3: 3, 4: 4});

    await host.check(tester);
    expect(textOf('Deine Wahl: Adressvergabe'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Material, Punkte und Ausgangssituation im Kopf', (tester) async {
    final host = QuestionHost(materialQuestion);
    await tester.pumpWidget(host.build());
    expect(textOf('2 P.'), findsOneWidget);
    expect(textOf('SITUATION'), findsOneWidget);
    expect(textOf('DisplayPort 1.4'), findsOneWidget);
    expect(textHas('To connect a second display'), findsOneWidget);
    // Reihenfolge: Situation, Tabelle, Text, Frage.
    double y(Finder f) => tester.getTopLeft(f).dy;
    expect(y(textOf('SITUATION')), lessThan(y(textOf('DisplayPort 1.4'))));
    expect(
      y(textOf('DisplayPort 1.4')),
      lessThan(y(textHas('To connect a second display'))),
    );
    expect(
      y(textHas('To connect a second display')),
      lessThan(y(textHas('Welche Schnittstelle'))),
    );
  });
}
