// Screenshot-Generator für die Sichtprüfung der Aufgabenarten, kein
// normaler Test. Rendert jede Art mit den echten Schriften vor und nach dem
// Prüfen als PNG nach build/question_shots/.
//
// Ausführen:
//   flutter test test/question_types_shots_test.dart --dart-define=QT_SHOTS=true

import 'dart:io';
import 'dart:ui' as ui;

import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/widgets/question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'question_types_samples.dart';
import 'support/fonts.dart';

const _enabled = bool.fromEnvironment('QT_SHOTS');

/// Halb ausgefüllte Antworten - so sieht man gefüllte, leere, richtige und
/// falsche Felder zugleich.
final _answers = <String, Object?>{
  clozeSelect.id: <int, String>{0: 'TCP', 1: 'TCP'},
  clozeBank.id: <int, String>{0: 'Werkvertrag', 1: 'Mietvertrag'},
  clozeInput.id: <int, String>{0: '62', 1: '255.255.255.0'},
  clozeCode.id: <int, String>{0: '0', 2: '+'},
  tableQuestion.id: <String, String>{
    '1.3': '6,2',
    '2.3': '6,4',
    '3.3': 'Betacom',
  },
  tableWide.id: <String, String>{
    '1.2': '192.168.10.1',
    '1.4': '62',
    '2.1': '192.168.10.60',
    '3.3': '192.168.10.255',
  },
  openQuestion.id: const OpenAnswer(
    text: 'Überbrückt einen Stromausfall, Server können sauber herunterfahren',
  ),
  markingCode.id: <int>{1, 3},
  markingList.id: <int>{0, 1},
  pairsQuestion.id: <int, int>{0: 0, 1: 2, 2: 1},
  singleQuestion.id: <int>{1},
  multiQuestion.id: <int>{0, 2},
  matchingQuestion.id: <int, int>{0: 0, 2: 2, 4: 2},
  materialQuestion.id: <int>{0},
};

void main() {
  if (!_enabled) {
    test(
      'Screenshots der Aufgabenarten (nur mit --dart-define=QT_SHOTS=true)',
      () {},
      skip: true,
    );
    return;
  }

  final boundaryKey = GlobalKey();

  setUpAll(loadAppFonts);

  Future<void> save(WidgetTester tester, String name) async {
    final boundary =
        boundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    final content = tester.getRect(find.byType(QuestionView));
    await tester.runAsync(() async {
      const ratio = 2.0;
      final image = await boundary.toImage(pixelRatio: ratio);
      final height = ((content.bottom + 16) * ratio).clamp(
        1.0,
        image.height.toDouble(),
      );
      final src = Rect.fromLTWH(0, 0, image.width.toDouble(), height);
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawImageRect(image, src, src, Paint());
      final cropped = await recorder.endRecording().toImage(
        src.width.round(),
        src.height.round(),
      );
      final bytes = await cropped.toByteData(format: ui.ImageByteFormat.png);
      File('build/question_shots/$name.png')
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  const variants = [
    (name: '320_hell_130', width: 320.0, scale: 1.3, dark: false),
    (name: '320_dunkel_100', width: 320.0, scale: 1.0, dark: true),
    (name: '412_hell_100', width: 412.0, scale: 1.0, dark: false),
  ];

  for (final v in variants) {
    for (final q in kAllSamples) {
      testWidgets('${q.id} ${v.name}', (tester) async {
        setView(tester, Size(v.width, 2400), v.scale);
        final host = QuestionHost(q, answer: _answers[q.id]);
        await tester.pumpWidget(
          RepaintBoundary(
            key: boundaryKey,
            child: host.build(dark: v.dark),
          ),
        );
        await tester.pumpAndSettle();
        await save(tester, '${q.id}_${v.name}_a');
        await host.check(tester);
        await save(tester, '${q.id}_${v.name}_b');
        expect(tester.takeException(), isNull);
      });
    }
  }

  // Echte Aufgaben aus dem Pool, an denen sich die schwierigen Fälle
  // zeigen: gemischte Lücken, lange Auswahloptionen in Tabellen, englisches
  // Material, ER-Diagramm zum Ergänzen.
  const realIds = [
    'i4-de-2',
    'i4-mu-6',
    'a6-yb-8',
    'f-a06-handel-b',
    'f-a06-handel-g',
    'i4-ua-7',
    'a4-fa-2',
    'f-a04d-systemhaus-b',
  ];
  final real = [
    for (final id in realIds)
      ...kSeedQuestions.where((q) => q.id == id).take(1),
    ...kSeedQuestions
        .where((q) => q.code != null && q.kind == QuestionKind.open)
        .take(4),
  ];
  for (final q in real) {
    testWidgets('Pool ${q.id}', (tester) async {
      setView(tester, const Size(320, 4000), 1.3);
      final host = QuestionHost(q);
      await tester.pumpWidget(
        RepaintBoundary(key: boundaryKey, child: host.build()),
      );
      await tester.pumpAndSettle();
      await save(tester, 'pool_${q.id}_a');
      await host.check(tester);
      await save(tester, 'pool_${q.id}_b');
      expect(tester.takeException(), isNull);
    });
  }
}
