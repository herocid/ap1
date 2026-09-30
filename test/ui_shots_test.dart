// Screenshot-Generator für die visuelle Prüfung, kein normaler Test.
//
// Rendert die Screens mit den echten gebündelten Schriften (Inter,
// Material Icons) als PNG nach build/ui_shots/<tag>/. Im normalen
// `flutter test`-Lauf wird er übersprungen.
//
// Ausführen:
//   flutter test test/ui_shots_test.dart --dart-define=UI_SHOTS=true \
//     --dart-define=UI_SHOTS_TAG=nachher

import 'dart:io';
import 'dart:ui' as ui;

import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/data/seed/cards/cards_data.dart';
import 'package:ap1_trainer/features/shell/app_shell.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

const _enabled = bool.fromEnvironment('UI_SHOTS');
const _tag = String.fromEnvironment('UI_SHOTS_TAG', defaultValue: 'aktuell');

/// Eine Karte mit sehr langer Rückseite - so lang, wie die neuen Inhalte
/// werden können.
const longCard = Flashcard(
  id: 'k-shot-1',
  topicId: 'netzplan',
  front: 'Was unterscheidet Gesamtpuffer und freien Puffer im Netzplan?',
  back:
      'Der Gesamtpuffer (GP = SAZ - FAZ) gibt an, um wie viel sich ein Vorgang '
      'verschieben darf, ohne das Projektende zu gefährden. Der freie Puffer '
      '(FP = FAZ des Nachfolgers - FEZ) gibt an, um wie viel sich ein Vorgang '
      'verschieben darf, ohne den frühesten Anfang eines Nachfolgers zu '
      'verzögern. Beispiel: FAZ 4, FEZ 9, SAZ 6 ergibt GP = 2; beginnt der '
      'Nachfolger frühestens bei 10, ist FP = 1. Vorgänge auf dem kritischen '
      'Pfad haben GP = 0 und FP = 0. Der freie Puffer ist nie größer als der '
      'Gesamtpuffer. In der Prüfung wird oft beides gefragt - immer mit '
      'Rechenweg angeben, sonst gibt es Punktabzug. Merke: Erst vorwärts '
      '(FAZ/FEZ), dann rückwärts (SAZ/SEZ) rechnen, danach die Puffer.',
  hint:
      'Eselsbrücke: Gesamt = gegen das Ende, frei = gegen den Nachfolger. '
      'Wer den Puffer eines Vorgangs aufbraucht, nimmt ihn den Nachfolgern.',
);

Future<void> _loadFonts() async {
  Future<ByteData> file(String path) async =>
      ByteData.sublistView(await File(path).readAsBytes());

  final inter = FontLoader('Inter');
  for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    inter.addFont(file('assets/fonts/Inter-$w.ttf'));
  }
  await inter.load();

  final mono = FontLoader('JetBrainsMono')
    ..addFont(file('assets/fonts/JetBrainsMono-Regular.ttf'))
    ..addFont(file('assets/fonts/JetBrainsMono-Bold.ttf'));
  await mono.load();

  final flutterRoot =
      Platform.environment['FLUTTER_ROOT'] ??
      r'C:\Users\Student\develop\flutter';
  final icons = FontLoader('MaterialIcons')
    ..addFont(
      file(
        '$flutterRoot/bin/cache/artifacts/material_fonts/'
        'materialicons-regular.otf',
      ),
    );
  await icons.load();
}

void main() {
  if (!_enabled) {
    test(
      'UI-Screenshots (nur mit --dart-define=UI_SHOTS=true)',
      () {},
      skip: true,
    );
    return;
  }

  final boundaryKey = GlobalKey();

  setUpAll(() async {
    await initializeDateFormatting('de_DE');
  });

  Future<void> save(WidgetTester tester, String name, {Rect? crop}) async {
    final boundary =
        boundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    await tester.runAsync(() async {
      final ratio = crop == null ? 2.0 : 3.0;
      var image = await boundary.toImage(pixelRatio: ratio);
      if (crop != null) {
        final src = Rect.fromLTRB(
          crop.left * ratio,
          crop.top * ratio,
          crop.right * ratio,
          crop.bottom * ratio,
        );
        final recorder = ui.PictureRecorder();
        Canvas(
          recorder,
        ).drawImageRect(image, src, Offset.zero & src.size, Paint());
        image = await recorder.endRecording().toImage(
          src.width.round(),
          src.height.round(),
        );
      }
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      File('build/ui_shots/$_tag/$name.png')
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  Future<ProviderContainer> boot(
    WidgetTester tester, {
    required Size size,
    required double scale,
    required bool dark,
    bool withData = false,
    List<Flashcard>? cards,
  }) async {
    await tester.runAsync(_loadFonts);
    final store = await HiveLocalStore.open(inMemory: true);
    await store.writeProfile(
      UserProfile.initial().copyWith(
        displayName: 'Marcel',
        onboarded: true,
        tutorialSeen: true,
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      ),
    );
    if (withData) {
      final now = DateTime.now();
      await store.appendAnswers([
        for (var i = 0; i < 60; i++)
          AnswerRecord(
            questionId: 'q$i',
            topicId: i.isEven ? 'netzplan' : 'agil_scrum',
            score: i % 3 == 0 ? 0 : 1,
            seconds: 30,
            at: now.subtract(Duration(days: i % 9, minutes: i)),
            mode: SessionMode.uebung,
          ),
      ]);
    }
    tester.view.physicalSize = size * 3;
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = scale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final container = ProviderContainer(
      overrides: [
        localStoreProvider.overrideWithValue(store),
        if (cards != null) flashcardsProvider.overrideWithValue(cards),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(store.close);

    await tester.pumpWidget(
      RepaintBoundary(
        key: boundaryKey,
        child: UncontrolledProviderScope(
          container: container,
          child: const Ap1TrainerApp(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  const sizes = {'320': Size(320, 568), '412': Size(412, 915)};
  const tabs = {
    'start': '/',
    'quiz': '/quiz',
    'karten': '/karten',
    'statistik': '/statistik',
  };

  for (final dark in [false, true]) {
    for (final scale in [1.0, 1.3]) {
      for (final s in sizes.entries) {
        final variant =
            '${s.key}_${dark ? 'dunkel' : 'hell'}_${(scale * 100).round()}';

        testWidgets('Tabs $variant', (tester) async {
          final c = await boot(
            tester,
            size: s.value,
            scale: scale,
            dark: dark,
            withData: true,
          );
          for (final t in tabs.entries) {
            c.read(routerProvider).go(t.value);
            await tester.pumpAndSettle();
            await save(tester, '${t.key}_$variant');
          }
          final bar = tester.getRect(find.byType(AppNavigationBar));
          await save(tester, 'leiste_$variant', crop: bar);
          expect(tester.takeException(), isNull);
        });

        testWidgets('Karteikarte $variant', (tester) async {
          final c = await boot(
            tester,
            size: s.value,
            scale: scale,
            dark: dark,
            cards: [longCard, ...kSeedFlashcards.take(3)],
          );
          c.read(routerProvider).go('/karten-lernen');
          await tester.pumpAndSettle();
          await save(tester, 'karte_vorne_$variant');
          await tester.tap(find.text('Umdrehen'));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 200));
          await save(tester, 'karte_dreht_$variant');
          await tester.pumpAndSettle();
          await save(tester, 'karte_hinten_$variant');
          expect(tester.takeException(), isNull);
        });
      }
    }
  }

  // Ganze Seiten ohne Scrollen: sehr hohes Fenster.
  for (final dark in [false, true]) {
    final variant = dark ? 'dunkel' : 'hell';
    testWidgets('Lange Seiten $variant', (tester) async {
      final c = await boot(
        tester,
        size: const Size(320, 2600),
        scale: 1.3,
        dark: dark,
        withData: true,
      );
      for (final r in {
        ...tabs,
        'einstellungen': '/einstellungen',
        'pruefung': '/pruefung',
        'katalog': '/katalog-aenderungen',
      }.entries) {
        c.read(routerProvider).go(r.value);
        await tester.pumpAndSettle();
        // In Abschnitten speichern, damit man die Details lesen kann.
        for (var y = 0.0; y < 2600; y += 700) {
          await save(
            tester,
            'lang_${r.key}_${variant}_${(y / 700).round()}',
            crop: Rect.fromLTWH(0, y, 320, y + 700 > 2600 ? 2600 - y : 700),
          );
        }
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Einführung 320 hell', (tester) async {
    final c = await boot(
      tester,
      size: const Size(320, 568),
      scale: 1.3,
      dark: false,
    );
    c.read(routerProvider).go('/einfuehrung');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Weiter'));
    await tester.pumpAndSettle();
    await save(tester, 'einfuehrung_320_hell_130');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Rail 1200 hell', (tester) async {
    final c = await boot(
      tester,
      size: const Size(1200, 800),
      scale: 1,
      dark: false,
      withData: true,
    );
    c.read(routerProvider).go('/quiz');
    await tester.pumpAndSettle();
    await save(tester, 'rail_quiz_1200_hell');
    expect(tester.takeException(), isNull);
  });
}
