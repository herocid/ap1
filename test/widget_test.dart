import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  late HiveLocalStore store;

  setUpAll(() async {
    await initializeDateFormatting('de_DE');
  });

  // Außerhalb von testWidgets öffnen: dort läuft eine simulierte Uhr, in der
  // die asynchrone Box-Initialisierung nicht fertig würde.
  setUp(() async => store = await HiveLocalStore.open(inMemory: true));
  tearDown(() => store.close());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [localStoreProvider.overrideWithValue(store)],
        child: const Ap1TrainerApp(),
      ),
    );
    await tester.pump();
  }

  testWidgets('startet im Onboarding, wenn kein Profil vorliegt', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('AP1 Coach'), findsOneWidget);
    expect(find.text('Weiter'), findsOneWidget);
  });

  testWidgets('führt durch Onboarding und Einführung zum Dashboard', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.enterText(find.byType(TextField).first, 'Testuser');
    await tester.pump();

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Weiter'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Lernplan erstellen'));
    await tester.pumpAndSettle();

    // Direkt danach erklärt Bit die Tabs - einmal durchklicken.
    expect(find.text('Hallo! Ich bin Bit.'), findsOneWidget);
    while (find.text('Weiter').evaluate().isNotEmpty) {
      await tester.tap(find.text('Weiter'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Los geht’s'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Moin'), findsOneWidget);
    expect(find.text('Heutiges Ziel'), findsOneWidget);
    expect(find.text('Tagesrunde starten'), findsOneWidget);
    expect(find.text('Kurztest'), findsOneWidget);
  });
}
