import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_view.dart';
import 'package:ap1_trainer/widgets/question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'question_types_samples.dart';
import 'support/fonts.dart';
import 'support/text_visibility.dart';

/// Darstellung der Aufgabenarten mit den echten Schriften: kein Überlauf,
/// kein abgeschnittener Text - schmal und breit, 100 % und 130 % Schrift,
/// hell und dunkel, vor und nach dem Prüfen.
void main() {
  setUpAll(loadAppFonts);

  List<String> cut(WidgetTester tester) => findCutTexts(
    tester,
    // Der Netzplan scrollt bewusst seitlich; Zeichnungen haben eigene Tests.
    allowHorizontalScroll: true,
    skipInside: (w) => w is DiagramView,
  );

  /// Antworten, die möglichst viele Zustände zeigen (gefüllt, leer, falsch).
  final answers = <String, Object?>{
    clozeSelect.id: <int, String>{0: 'TCP', 1: 'TCP'},
    clozeBank.id: <int, String>{0: 'Werkvertrag', 1: 'Mietvertrag'},
    clozeInput.id: <int, String>{0: '62', 1: '255.255.255.0'},
    clozeCode.id: <int, String>{0: '0', 2: '+'},
    tableQuestion.id: <String, String>{'1.3': '6,2', '2.3': '6,4'},
    tableWide.id: <String, String>{
      '1.2': '192.168.10.1',
      '2.1': '192.168.10.60',
      '3.3': '192.168.10.255',
    },
    openQuestion.id: const OpenAnswer(
      text: 'Überbrückt einen Stromausfall, Server können herunterfahren',
    ),
    markingCode.id: <int>{1, 3},
    markingList.id: <int>{0, 1},
    pairsQuestion.id: <int, int>{0: 0, 1: 2, 2: 1},
    singleQuestion.id: <int>{1},
    multiQuestion.id: <int>{0, 2},
    matchingQuestion.id: <int, int>{0: 0, 2: 2, 4: 2},
    materialQuestion.id: <int>{0},
  };

  for (final width in [320.0, 412.0, 640.0]) {
    for (final scale in [1.0, 1.3]) {
      testWidgets('Beispielaufgaben bei ${width.toInt()} px, Schrift '
          '${(scale * 100).round()} %', (tester) async {
        setView(tester, Size(width, 900), scale);
        final broken = <String>[];
        for (final dark in [false, true]) {
          for (final q in kAllSamples) {
            for (final filled in [false, true]) {
              final host = QuestionHost(
                q,
                answer: filled ? answers[q.id] : null,
              );
              await tester.pumpWidget(
                KeyedSubtree(
                  key: UniqueKey(),
                  child: host.build(dark: dark),
                ),
              );
              await tester.pumpAndSettle();
              for (final revealed in [false, true]) {
                if (revealed) await host.check(tester);
                final where =
                    '${q.id}${filled ? ' gefüllt' : ''}'
                    '${revealed ? ' geprüft' : ''}${dark ? ' dunkel' : ''}';
                final error = tester.takeException();
                if (error != null) broken.add('$where: $error');
                for (final p in cut(tester)) {
                  broken.add('$where: $p');
                }
              }
            }
          }
        }
        expect(broken, isEmpty, reason: broken.take(30).join('\n'));
      });
    }
  }

  testWidgets('breite Tabelle wird auf 320 px zu Blöcken, schmale bleibt '
      'Tabelle', (tester) async {
    setView(tester, const Size(320, 900), 1.0);
    await tester.pumpWidget(QuestionHost(tableWide).build());
    expect(find.byType(Table), findsNothing);
    // Jede Lücke ist bedienbar und mindestens 48 px hoch.
    for (final key in tableWide.gridGaps.keys) {
      final size = tester.getSize(find.byKey(ValueKey('gap-$key')));
      expect(size.height, greaterThanOrEqualTo(48), reason: key);
      expect(size.width, greaterThan(150), reason: key);
    }

    setView(tester, const Size(412, 900), 1.0);
    await tester.pumpWidget(
      KeyedSubtree(
        key: UniqueKey(),
        child: QuestionHost(tableQuestion).build(),
      ),
    );
    expect(find.byType(Table), findsOneWidget);
  });

  testWidgets('Tippflächen sind mindestens 48 px hoch (320 px)', (
    tester,
  ) async {
    setView(tester, const Size(320, 900), 1.0);
    Future<void> expectTall(Question q, List<String> keys) async {
      await tester.pumpWidget(
        KeyedSubtree(key: UniqueKey(), child: QuestionHost(q).build()),
      );
      await tester.pumpAndSettle();
      for (final k in keys) {
        final size = tester.getSize(find.byKey(ValueKey(k)));
        expect(size.height, greaterThanOrEqualTo(48), reason: '${q.id} $k');
        expect(size.width, greaterThanOrEqualTo(48), reason: '${q.id} $k');
      }
    }

    await expectTall(clozeSelect, ['gap-0', 'gap-1', 'gap-2']);
    await expectTall(clozeBank, ['gap-0', 'bank-0', 'bank-4']);
    await expectTall(clozeInput, ['gap-0', 'gap-1']);
    await expectTall(clozeCode, ['gap-0', 'gap-2']);
    await expectTall(markingCode, ['mark-0', 'mark-3']);
    await expectTall(markingList, ['mark-0']);
    await expectTall(pairsQuestion, ['left-0', 'right-0']);
    await expectTall(singleQuestion, ['choice-0']);
  });

  // Die Autoren liefern laufend Inhalte - jede Aufgabe des Pools muss auf
  // dem kleinsten Display mit großer Schrift ohne Fehler erscheinen, vor und
  // nach dem Prüfen.
  testWidgets(
    'alle Aufgaben des Pools rendern bei 320 px fehlerfrei',
    (tester) async {
      setView(tester, const Size(320, 900), 1.3);
      final broken = <String>[];
      Question? current;
      var revealed = false;
      late StateSetter update;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: StatefulBuilder(
                builder: (context, setState) {
                  update = setState;
                  final q = current;
                  if (q == null) return const SizedBox.shrink();
                  return QuestionView(
                    key: ValueKey('${q.id}-$revealed'),
                    question: q,
                    answer: null,
                    onChanged: (_) {},
                    revealed: revealed,
                    grade: revealed ? q.grade(null) : null,
                    shuffleSeed: 1,
                  );
                },
              ),
            ),
          ),
        ),
      );

      final seen = <String>{};
      for (final q in kSeedQuestions) {
        if (!seen.add(q.id)) continue;
        for (final r in [false, true]) {
          update(() {
            current = q;
            revealed = r;
          });
          await tester.pump();
          // Reihenfolge-Aufgaben melden ihre Startreihenfolge nach dem Frame.
          await tester.pump();
          Object? error;
          while (true) {
            final e = tester.takeException();
            if (e == null) break;
            error ??= e;
          }
          if (error != null) {
            broken.add(
              '${q.id} (${q.kind.name}${r ? ', geprüft' : ''}): '
              '${error.toString().split('\n').first}',
            );
          }
        }
      }
      expect(seen.length, greaterThan(500));
      expect(
        broken,
        isEmpty,
        reason: '${broken.length} Aufgaben:\n${broken.take(40).join('\n')}',
      );
    },
    timeout: const Timeout(Duration(minutes: 20)),
  );
}
