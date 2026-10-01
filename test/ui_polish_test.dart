import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/features/shell/app_shell.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:ap1_trainer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Pixelgenaue Prüfungen für Reiterleiste, Kacheln und Karteikarten - das,
/// was ein reiner Überlauf-Test nicht sieht: umbrochene oder gestauchte
/// Labels, versetzte Symbole, ungleich hohe Kacheln.
void main() {
  late HiveLocalStore store;

  setUpAll(() async => initializeDateFormatting('de_DE'));

  setUp(() async {
    store = await HiveLocalStore.open(inMemory: true);
    await store.writeProfile(
      UserProfile.initial().copyWith(
        displayName: 'Marcel',
        onboarded: true,
        tutorialSeen: true,
      ),
    );
  });
  tearDown(() => store.close());

  Future<ProviderContainer> pumpApp(
    WidgetTester tester, {
    required Size size,
    required double scale,
    List<Override> overrides = const [],
  }) async {
    tester.view.physicalSize = size * 3;
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = scale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final container = ProviderContainer(
      overrides: [localStoreProvider.overrideWithValue(store), ...overrides],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const Ap1TrainerApp(),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  group('Reiterleiste', () {
    const labels = ['Start', 'Journey', 'Quiz', 'Karten', 'Statistik'];

    for (final width in [320.0, 375.0, 412.0]) {
      for (final scale in [1.0, 1.3, 2.0]) {
        testWidgets('Labels einzeilig, vollständig und mittig unter dem Symbol '
            '(${width.toInt()} px, Schrift ${(scale * 100).round()} %)', (
          tester,
        ) async {
          final c = await pumpApp(tester, size: Size(width, 800), scale: scale);
          // Jeder Reiter einmal aktiv - der fette Stil ist der breiteste.
          for (var active = 0; active < labels.length; active++) {
            c
                .read(routerProvider)
                .go(
                  const [
                    '/',
                    '/journey',
                    '/quiz',
                    '/karten',
                    '/statistik',
                  ][active],
                );
            await tester.pumpAndSettle();
            // Seiteninhalte sind bis 130 % Schrift vertraglich überlauffrei
            // (screens_layout_test). Bei 200 % wird hier nur die Leiste
            // geprüft - die dafür aber pixelgenau.
            final err = tester.takeException();
            if (scale <= 1.3) expect(err, isNull);

            final bar = find.byType(AppNavigationBar);
            expect(bar, findsOneWidget);
            final barRect = tester.getRect(bar);
            final itemWidth = barRect.width / labels.length;
            expect(
              barRect.height,
              greaterThanOrEqualTo(64),
              reason: 'Touch-Ziel und Luft um Symbol und Label',
            );

            final fontSizes = <double>{};
            final labelTops = <double>{};
            final labelHeights = <double>{};
            for (var i = 0; i < labels.length; i++) {
              final text = find.descendant(
                of: bar,
                matching: find.text(labels[i]),
              );
              expect(text, findsOneWidget);
              final para = tester.renderObject<RenderParagraph>(text);

              // Einzeilig und nicht abgeschnitten.
              expect(para.didExceedMaxLines, isFalse, reason: labels[i]);
              final full = para.getMaxIntrinsicWidth(double.infinity);
              expect(
                full,
                lessThanOrEqualTo(para.size.width + 0.5),
                reason: '${labels[i]} passt nicht in seine Zeile',
              );
              final labelRect = tester.getRect(text);
              final slotLeft = barRect.left + i * itemWidth;
              expect(
                labelRect.left,
                greaterThanOrEqualTo(slotLeft - 0.5),
                reason: '${labels[i]} ragt links aus dem Reiter',
              );
              expect(
                labelRect.right,
                lessThanOrEqualTo(slotLeft + itemWidth + 0.5),
                reason: '${labels[i]} ragt rechts aus dem Reiter',
              );

              // Symbol und Label horizontal zentriert übereinander.
              final icon = find.descendant(
                of: bar,
                matching: find.byWidgetPredicate(
                  (w) =>
                      w is Icon &&
                      (w.icon == AppShell.destinations[i].icon ||
                          w.icon == AppShell.destinations[i].active),
                ),
              );
              final iconRect = tester.getRect(icon.first);
              final slotCenter = slotLeft + itemWidth / 2;
              expect(iconRect.center.dx, closeTo(slotCenter, 0.5));
              expect(labelRect.center.dx, closeTo(slotCenter, 0.5));
              expect(iconRect.bottom, lessThanOrEqualTo(labelRect.top));

              fontSizes.add(para.textScaler.scale(12));
              labelTops.add(labelRect.top);
              labelHeights.add(labelRect.height);
            }
            expect(fontSizes, hasLength(1), reason: 'gleiche Schriftgröße');
            expect(labelTops, hasLength(1), reason: 'gleiche Grundlinie');
            expect(labelHeights, hasLength(1), reason: 'gleiche Höhe');
          }
        });
      }
    }

    testWidgets('aktiver Reiter behält sein Symbol in Markenfarbe', (
      tester,
    ) async {
      final c = await pumpApp(tester, size: const Size(375, 800), scale: 1);
      c.read(routerProvider).go('/quiz');
      await tester.pumpAndSettle();
      final bar = find.byType(AppNavigationBar);
      final active = tester.widget<Icon>(
        find.descendant(of: bar, matching: find.byIcon(Icons.quiz_outlined)),
      );
      final ctx = tester.element(bar);
      expect(active.color, Theme.of(ctx).colorScheme.primary);
      expect(
        find.descendant(of: bar, matching: find.byIcon(Icons.quiz_outlined)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: bar, matching: find.byIcon(Icons.home_outlined)),
        findsOneWidget,
      );
    });

    testWidgets('breite Fenster bekommen eine NavigationRail', (tester) async {
      await pumpApp(tester, size: const Size(1200, 800), scale: 1);
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(AppNavigationBar), findsNothing);
    });
  });

  group('Karteikarten', () {
    final longBack = List.filled(
      12,
      'Der Gesamtpuffer gibt an, um wie viel sich ein Vorgang verschieben '
      'darf, ohne das Projektende zu gefährden.',
    ).join(' ');
    final card = Flashcard(
      id: 'k-test-lang',
      topicId: 'netzplan',
      front: 'Gesamtpuffer und freier Puffer im Netzplan unterscheiden',
      back: longBack,
      hint: 'Gesamt = gegen das Ende, frei = gegen den Nachfolger.',
    );

    for (final scale in [1.0, 1.3]) {
      testWidgets('lange Rückseite wird vollständig gezeigt (320 px, '
          '${(scale * 100).round()} %)', (tester) async {
        final c = await pumpApp(
          tester,
          size: const Size(320, 568),
          scale: scale,
          overrides: [
            flashcardsProvider.overrideWithValue([card]),
          ],
        );
        c.read(routerProvider).go('/karten-lernen');
        await tester.pumpAndSettle();
        await tester.tap(find.text('Umdrehen'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Der ganze Text steht in einem Absatz ohne Zeilenlimit.
        final back = tester.renderObject<RenderParagraph>(find.text(longBack));
        expect(back.didExceedMaxLines, isFalse);
        expect(back.maxLines, isNull);

        // Bis ans Ende scrollbar, der Hinweis darunter erreichbar.
        await tester.scrollUntilVisible(
          find.textContaining('Gesamt = gegen das Ende'),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        expect(tester.takeException(), isNull);

        // Die Bewertungsknöpfe brechen ihre Beschriftung nie um.
        for (final l in ['Nochmal', 'Wusste ich']) {
          final p = tester.renderObject<RenderParagraph>(find.text(l));
          expect(p.didExceedMaxLines, isFalse, reason: l);
        }
      });
    }
  });

  group('Kacheln', () {
    Widget host(Widget child, {double width = 320, double scale = 1.3}) =>
        MaterialApp(
          theme: AppTheme.light(),
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(width, 800),
              textScaler: TextScaler.linear(scale),
            ),
            child: Scaffold(
              body: Center(
                child: SizedBox(width: width - 32, child: child),
              ),
            ),
          ),
        );

    testWidgets('Kennzahl-Kacheln einer Reihe sind gleich hoch', (
      tester,
    ) async {
      await tester.pumpWidget(
        host(
          const StatTileRow(
            children: [
              StatTile(icon: Icons.star, value: '1', label: 'Tage Streak'),
              StatTile(icon: Icons.star, value: 'Lv. 12', label: '440 XP'),
              StatTile(icon: Icons.star, value: '600', label: 'Aufgaben'),
            ],
          ),
        ),
      );
      expect(tester.takeException(), isNull);
      final heights = tester
          .widgetList<StatTile>(find.byType(StatTile))
          .map((w) => tester.getSize(find.byWidget(w)).height)
          .toSet();
      expect(heights, hasLength(1));
    });

    testWidgets('Titel brechen nie mitten im Wort um', (tester) async {
      const title = 'Kundenbeziehungen & Kommunikation';
      await tester.pumpWidget(
        host(
          ProgressTile(
            icon: Icons.forum_outlined,
            overline: 'BEREICH 02',
            title: title,
            progress: 0.4,
            badge: '67 fällig',
            onTap: () {},
          ),
          width: 300,
        ),
      );
      expect(tester.takeException(), isNull);
      final para = tester.renderObject<RenderParagraph>(find.text(title));
      final style = para.text.style!;
      // Das längste Wort muss mit der tatsächlich verwendeten Skalierung
      // in die Zeile passen.
      final widest = WordSafeText.words(title)
          .map((w) => measureTextWidth(w, style, para.textScaler))
          .reduce((a, b) => a > b ? a : b);
      expect(widest, lessThanOrEqualTo(para.size.width + 0.5));
    });

    testWidgets('Symbole in Kacheln sind einheitlich groß', (tester) async {
      await tester.pumpWidget(
        host(
          Column(
            children: [
              ActionTile(
                icon: Icons.timer,
                title: 'Prüfungssimulation',
                subtitle: 'Zeitlimit wie in der AP1',
                onTap: () {},
              ),
              const ProgressTile(
                icon: Icons.forum_outlined,
                title: 'Kommunikation',
                progress: 0.2,
              ),
            ],
          ),
        ),
      );
      final sizes = tester
          .widgetList(find.byType(TileIcon))
          .map((w) => tester.getSize(find.byWidget(w)))
          .toSet();
      expect(sizes, {const Size.square(TileIcon.kTileIconSize)});
    });
  });
}
