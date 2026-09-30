import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:ap1_trainer/features/journey/nugget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Rendert jeden Lernschritt auf dem kleinsten Handy mit normaler und
/// vergrößerter Schrift. `screens_layout_test.dart` zeigt nur die erste
/// Seite einer Lektion - Tabellen, Formeln und lange Titel der übrigen
/// Schritte fallen erst hier auf.
void main() {
  for (final scale in [1.0, 1.3]) {
    testWidgets(
      'alle Lernschritte bei 320 px, Schrift ${(scale * 100).round()} %',
      (tester) async {
        tester.view.physicalSize = const Size(320, 568) * 3;
        tester.view.devicePixelRatio = 3;
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        final broken = <String>[];
        for (final n in kSeedNuggets) {
          // Eigener Key je Schritt: Sonst verwendet Flutter die Render-Objekte
          // weiter und meldet einen Überlauf nur beim ersten Mal.
          await tester.pumpWidget(
            MaterialApp(
              key: ValueKey(n.id),
              theme: AppTheme.light(),
              home: Scaffold(
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: NuggetCard(nugget: n, showTopic: false),
                ),
              ),
            ),
          );
          final error = tester.takeException();
          if (error != null) broken.add('${n.id}: $error');
        }
        expect(broken, isEmpty, reason: broken.join('\n'));
      },
    );
  }
}
