import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('de_DE');
  });

  Future<void> pumpApp(WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [localStoreProvider.overrideWithValue(LocalStore(prefs))],
        child: const Ap1TrainerApp(),
      ),
    );
    await tester.pump();
  }

  testWidgets('startet im Onboarding, wenn kein Profil vorliegt',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('AP1 Trainer'), findsOneWidget);
    expect(find.text('Weiter'), findsOneWidget);
  });

  testWidgets('fuehrt durch das Onboarding bis zum Dashboard', (tester) async {
    await pumpApp(tester);

    await tester.enterText(find.byType(TextField).first, 'Testuser');
    await tester.pump();

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Weiter'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Lernplan erstellen'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Moin'), findsOneWidget);
    expect(find.text('Pruefungsreife'), findsOneWidget);
  });
}
