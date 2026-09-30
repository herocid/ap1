import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Rendert jeden Hauptscreen auf typischen Handygrößen. Flutter lässt den
/// Test bei jedem Layout-Überlauf fehlschlagen - abgeschnittene oder
/// überlaufende Inhalte fallen so vor dem Store-Release auf, nicht danach.
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

  const routes = [
    '/',
    '/themen',
    '/journey',
    '/quiz',
    '/einfuehrung',
    '/lektion/n-vorwaerts',
    '/karten',
    '/statistik',
    '/einstellungen',
    '/pruefung',
    '/karten-lernen',
    '/bereich/a01',
    '/katalog-aenderungen',
  ];

  // Kleinstes verbreitetes Handy (iPhone SE) und ein typisches Android -
  // jeweils mit normaler und mit vergrößerter Systemschrift (Barrierefreiheit).
  const sizes = [Size(320, 568), Size(375, 812), Size(412, 915)];
  const textScales = [1.0, 1.3];

  for (final scale in textScales) {
    for (final size in sizes) {
      for (final route in routes) {
        testWidgets('$route bei ${size.width.toInt()}×${size.height.toInt()}, '
            'Schrift ${(scale * 100).round()} %', (tester) async {
          tester.view.physicalSize = size * 3;
          tester.view.devicePixelRatio = 3;
          tester.platformDispatcher.textScaleFactorTestValue = scale;
          addTearDown(tester.view.reset);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

          final container = ProviderContainer(
            overrides: [localStoreProvider.overrideWithValue(store)],
          );
          addTearDown(container.dispose);

          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: const Ap1TrainerApp(),
            ),
          );
          await tester.pumpAndSettle();
          // Die App startet immer auf "/". Deren Fehler prüft der Fall "/"
          // selbst - hier sollen sie den Befund für andere Screens nicht
          // überdecken.
          if (route != '/') tester.takeException();

          container.read(routerProvider).go(route);
          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
        });
      }
    }
  }
}
