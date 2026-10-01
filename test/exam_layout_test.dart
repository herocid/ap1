import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:ap1_trainer/state/session_controller.dart';
import 'package:ap1_trainer/widgets/diagrams/diagram_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'support/exam_fixtures.dart';
import 'support/fonts.dart';
import 'support/screenshot.dart';
import 'support/text_visibility.dart';

/// Prüfungssimulation, Quiz-Reiter und Rundenauswertung mit den echten
/// Schriften auf 320-640 px und mit 100 % und 130 % Schrift: kein Überlauf,
/// kein abgeschnittener Text. Mit `AP1_SHOTS=<Ordner>` entstehen dabei
/// Bildschirmfotos für die Sichtprüfung (hell und dunkel).
void main() {
  late HiveLocalStore store;

  setUpAll(() async {
    await initializeDateFormatting('de_DE');
    await loadAppFonts();
  });

  tearDown(() => store.close());

  Future<ProviderContainer> boot(
    WidgetTester tester, {
    required Size size,
    required double scale,
    bool dark = false,
    bool withCases = true,
    List<AnswerRecord> history = const [],
  }) async {
    store = await HiveLocalStore.open(inMemory: true);
    await store.writeProfile(
      UserProfile.initial().copyWith(
        displayName: 'Marcel',
        onboarded: true,
        tutorialSeen: true,
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      ),
    );
    if (history.isNotEmpty) await store.appendAnswers(history);
    // Der Theorie-Snack soll sich nicht vor die Übungsrunde schieben.
    await store.writeSeenTheory({for (final t in kSeedTheory) t.id});

    tester.view.physicalSize = size * 2;
    tester.view.devicePixelRatio = 2;
    tester.platformDispatcher.textScaleFactorTestValue = scale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final container = ProviderContainer(
      overrides: [
        localStoreProvider.overrideWithValue(store),
        examCasesProvider.overrideWithValue(
          withCases ? fullCaseSet() : const [],
        ),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      RepaintBoundary(
        child: UncontrolledProviderScope(
          container: container,
          child: const Ap1TrainerApp(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    tester.takeException();
    return container;
  }

  Future<void> frames(WidgetTester tester, [int n = 12]) async {
    for (var i = 0; i < n; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  /// Kein Überlauf, kein abgeschnittener Text - und ein Foto fürs Auge.
  Future<void> check(WidgetTester tester, String name) async {
    expect(tester.takeException(), isNull, reason: name);
    expect(
      findCutTexts(tester, skipInside: (w) => w is DiagramView),
      isEmpty,
      reason: name,
    );
    await saveScreenshot(tester, name);
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text).first);
    await frames(tester, 4);
    await tester.tap(find.text(text).first);
    await frames(tester);
  }

  const sizes = [
    Size(320, 568),
    Size(375, 812),
    Size(412, 915),
    Size(640, 900),
  ];
  const scales = [1.0, 1.3];

  for (final size in sizes) {
    for (final scale in scales) {
      for (final dark in [false, true]) {
        // Dunkel nur an den beiden Enden - das Layout ist dasselbe.
        if (dark && !(size.width == 320 && scale == 1.3) && size.width != 412) {
          continue;
        }
        final tag =
            '${size.width.toInt()}_${dark ? 'dunkel' : 'hell'}_'
            '${(scale * 100).round()}';

        testWidgets('Prüfungssimulation $tag', (tester) async {
          final c = await boot(tester, size: size, scale: scale, dark: dark);
          final router = c.read(routerProvider);
          final controller = c.read(sessionProvider.notifier);

          router.go('/pruefung');
          await tester.pumpAndSettle();
          await check(tester, 'pruefung_start_$tag');

          await tapText(tester, 'Volle Prüfung starten');
          await check(tester, 'pruefung_deckblatt_$tag');

          await tapText(tester, 'Beginnen (die Zeit läuft)');
          await check(tester, 'pruefung_aufgabe_a_$tag');

          // Antworten geben, markieren, weiterblättern.
          controller.setAnswer(
            const OpenAnswer(text: 'Preis, Leistung und die Garantie'),
          );
          controller.next();
          controller.setAnswer(30.0);
          controller.toggleFlag();
          await frames(tester, 4);
          await check(tester, 'pruefung_aufgabe_b_$tag');
          controller.jumpTo(3);
          controller.setAnswer(<int>{0});
          await frames(tester, 4);
          await check(tester, 'pruefung_aufgabe_d_$tag');

          await tester.tap(find.byIcon(Icons.grid_view_outlined));
          await frames(tester);
          await check(tester, 'pruefung_uebersicht_$tag');
          await tapText(tester, 'Prüfung abgeben');
          await check(tester, 'pruefung_abgabe_$tag');
          await tapText(tester, 'Abgeben');

          await check(tester, 'pruefung_bewertung_1_$tag');
          controller.setAnswer(
            const OpenAnswer(
              text: 'Preis, Leistung und die Garantie',
              checked: {0, 1},
            ),
          );
          controller.next();
          await frames(tester, 4);
          await check(tester, 'pruefung_bewertung_2_$tag');
          controller.completeReview();
          await frames(tester, 20);

          expect(find.text('VOLLE PRÜFUNG'), findsOneWidget);
          await check(tester, 'pruefung_ergebnis_$tag');
          // Durchsicht aufklappen.
          await tester.ensureVisible(find.byType(ExpansionTile).first);
          await frames(tester, 4);
          await tester.tap(find.byType(ExpansionTile).first);
          await frames(tester);
          await check(tester, 'pruefung_durchsicht_$tag');
          await tester.pumpWidget(const SizedBox());
        });
      }

      final tag = '${size.width.toInt()}_hell_${(scale * 100).round()}';

      testWidgets('Quiz-Reiter und Aufgabe des Tages $tag', (tester) async {
        final wrong = kExamRelevantQuestions.take(4).toList();
        final c = await boot(
          tester,
          size: size,
          scale: scale,
          history: [
            for (final q in wrong)
              AnswerRecord(
                questionId: q.id,
                topicId: q.topicId,
                score: 0,
                seconds: 30,
                at: DateTime.now().subtract(const Duration(days: 1)),
                mode: SessionMode.uebung,
              ),
          ],
        );
        c.read(routerProvider).go('/quiz');
        await tester.pumpAndSettle();
        await check(tester, 'quiz_$tag');

        await tapText(tester, 'Aufgabe starten');
        await check(tester, 'tagesaufgabe_$tag');
        c.read(sessionProvider.notifier).clear();
        await tester.pumpWidget(const SizedBox());
      });

      testWidgets('Quiz-Reiter ohne Fallaufgaben $tag', (tester) async {
        final c = await boot(
          tester,
          size: size,
          scale: scale,
          withCases: false,
        );
        c.read(routerProvider).go('/quiz');
        await tester.pumpAndSettle();
        await check(tester, 'quiz_leer_$tag');
        c.read(routerProvider).go('/pruefung');
        await tester.pumpAndSettle();
        await check(tester, 'pruefung_start_leer_$tag');
      });

      testWidgets('Übungsrunde mit Rückmeldung und Auswertung $tag', (
        tester,
      ) async {
        final c = await boot(tester, size: size, scale: scale);
        final controller = c.read(sessionProvider.notifier);
        final parts = fullCaseSet().first.parts;
        // Freitext, Rechnung, Auswahl - mit voller, halber und ohne Punkte.
        controller.start(
          questions: [parts[0], parts[1], parts[3]],
          mode: SessionMode.fokus,
          title: 'Schwächen-Training',
        );
        c.read(routerProvider).push('/session');
        await frames(tester, 20);
        // Der Theorie-Snack darf sich hier nicht davorschieben.
        expect(find.text('Musterlösung zeigen'), findsOneWidget);

        controller.setAnswer(const OpenAnswer(text: 'Preis und Garantie'));
        controller.check();
        await frames(tester, 6);
        expect(find.text('4 von 6 P.'), findsOneWidget);
        await check(tester, 'uebung_freitext_$tag');

        controller.next();
        controller.setAnswer(12.0);
        controller.check();
        await frames(tester, 6);
        expect(find.text('0 von 4 P.'), findsOneWidget);
        await check(tester, 'uebung_falsch_$tag');

        controller.next();
        controller.setAnswer(<int>{0});
        controller.check();
        await frames(tester, 6);
        expect(find.text('2 von 2 P.'), findsOneWidget);
        await check(tester, 'uebung_richtig_$tag');

        controller.finish();
        await frames(tester, 20);
        expect(find.text('6 von 12 Punkten'), findsOneWidget);
        await check(tester, 'uebung_ergebnis_$tag');
        await tester.pumpWidget(const SizedBox());
      });
    }
  }
}
