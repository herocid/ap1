import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:ap1_trainer/state/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Die Prüfungssimulation war im Web nicht erreichbar (Umlaut in der
/// Route). Dieser Test spielt den Weg einmal komplett durch.
void main() {
  late HiveLocalStore store;
  setUpAll(() async => initializeDateFormatting('de_DE'));
  setUp(() async {
    store = await HiveLocalStore.open(inMemory: true);
    await store.writeProfile(
      UserProfile.initial().copyWith(onboarded: true, tutorialSeen: true),
    );
  });
  tearDown(() => store.close());

  Future<void> frames(WidgetTester tester, int n) async {
    for (var i = 0; i < n; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  testWidgets('Prüfung starten, Countdown läuft, Abbrechen fragt nach', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(375, 812) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
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

    container.read(routerProvider).go('/pruefung');
    await tester.pumpAndSettle();
    expect(find.text('Prüfungssimulation'), findsOneWidget);

    await tester.ensureVisible(find.text('Simulation starten').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simulation starten').first);
    await frames(tester, 25);

    final s = container.read(sessionProvider)!;
    expect(s.isExam, isTrue);
    expect(s.items.length, 10);
    expect(s.elapsed, greaterThan(Duration.zero), reason: 'Countdown läuft');
    expect(find.text('Aufgabe 1 von 10'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await frames(tester, 10);
    expect(find.text('Simulation abbrechen?'), findsOneWidget);

    await tester.tap(find.text('Beenden'));
    await frames(tester, 10);
    expect(container.read(sessionProvider), isNull);
    await tester.pumpWidget(const SizedBox());
  });
}
