import 'package:ap1_trainer/core/router.dart';
import 'package:ap1_trainer/data/models/profile.dart';
import 'package:ap1_trainer/data/repositories/local_store.dart';
import 'package:ap1_trainer/main.dart';
import 'package:ap1_trainer/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Eine angefangene Lektion öffnet beim nächsten Mal am letzten Schritt,
/// und die Startseite bietet sie unter „Weitermachen“ an.
void main() {
  late HiveLocalStore store;

  setUpAll(() async => initializeDateFormatting('de_DE'));
  setUp(() async {
    store = await HiveLocalStore.open(inMemory: true);
    await store.writeProfile(
      UserProfile.initial().copyWith(
        displayName: 'Test',
        onboarded: true,
        tutorialSeen: true,
      ),
    );
  });
  tearDown(() => store.close());

  testWidgets('Lektion merkt sich den Schritt', (tester) async {
    tester.view.physicalSize = const Size(412, 915) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final c = ProviderContainer(
      overrides: [localStoreProvider.overrideWithValue(store)],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(container: c, child: const Ap1TrainerApp()),
    );
    await tester.pumpAndSettle();

    final lesson = c.read(lessonsProvider).first;
    c.read(routerProvider).push('/lektion/${lesson.id}');
    await tester.pumpAndSettle();
    // Einstieg -> Schritt 1 -> Schritt 2.
    for (var i = 0; i < 2; i++) {
      await tester.tap(find.byType(FilledButton).last);
      await tester.pumpAndSettle();
    }
    expect(c.read(resumeProvider).lesson?.page, 2);
    expect(c.read(lessonInProgressProvider)?.lessonId, lesson.id);

    // Verlassen und neu öffnen: es geht bei Schritt 2 weiter.
    c.read(routerProvider).pop();
    await tester.pumpAndSettle();
    expect(find.textContaining('Schritt 2 von'), findsWidgets);
    c.read(routerProvider).push('/lektion/${lesson.id}');
    await tester.pumpAndSettle();
    expect(find.textContaining('Weiter bei Schritt 2'), findsOneWidget);
  });
}
