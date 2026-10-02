import 'dart:io';
import 'dart:ui' as ui;

import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/features/cards/card_back_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mit --dart-define=CARD_BACK_SHOT=true entsteht zusätzlich je Variante ein
/// Bild in build/ui_shots/karten/ (echte Schriften) zur Sichtprüfung.
const _shot = bool.fromEnvironment('CARD_BACK_SHOT');

Future<void> _loadFonts() async {
  Future<ByteData> file(String path) async =>
      ByteData.sublistView(await File(path).readAsBytes());
  final inter = FontLoader('Inter');
  for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    inter.addFont(file('assets/fonts/Inter-$w.ttf'));
  }
  await inter.load();
  final mono = FontLoader('JetBrainsMono')
    ..addFont(file('assets/fonts/JetBrainsMono-Regular.ttf'));
  await mono.load();
}

/// Die gegliederte Rückseite darf auf schmalen Handys mit großer Schrift
/// nirgends überlaufen - auch nicht mit langen Rechenwegen in Zahlenschrift.
void main() {
  const backs = [
    'Er verliert seinen Inhalt ohne Strom.',
    'Textform (§ 126b BGB): lesbare Erklärung mit Namen, z. B. E-Mail. '
        'Schriftform (§ 126): eigenhändige Unterschrift.',
    '4 × 12 V × 9 Ah = 432 Wh; × 0,9 = 388,8 Wh; / 650 W ≈ 0,6 h ≈ 36 min.',
    'Eigen: 6.000 € + 3 × 1.800 € = 11.400 €. Cloud: 290 € × 36 = 10.440 €. '
        'Die Cloud ist 960 € günstiger.',
    '1.073.741.824 × 8 = 8.589.934.592 Bit; / 100.000.000 ≈ 85,9 s. '
        'Merke: Erst in Bit umrechnen, dann teilen.',
    '2³ = 2 × 2 × 2 = 8 Pfade.',
  ];

  for (final dark in [false, true]) {
    for (final scale in [1.0, 1.3]) {
      final variant = '${dark ? 'dunkel' : 'hell'}_${(scale * 100).round()}';
      testWidgets('ohne Überlauf bei 320 px, $variant', (tester) async {
        if (_shot) await tester.runAsync(_loadFonts);
        final key = GlobalKey();
        tester.view.physicalSize = const Size(320, 1500);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: MaterialApp(
              theme: dark ? AppTheme.dark() : AppTheme.light(),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(scale)),
                child: child!,
              ),
              home: Scaffold(
                body: SingleChildScrollView(
                  // Wie in der Karte: 16 px Seitenrand plus 16 px Kartenrand.
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final b in backs) ...[
                        CardBackText(b),
                        const Divider(height: 32),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        // Kurze Antwort: unverändert ein einziger Text.
        expect(find.text(backs.first), findsOneWidget);

        if (_shot) {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          await tester.runAsync(() async {
            final image = await boundary.toImage(pixelRatio: 2);
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            File('build/ui_shots/karten/rueckseite_muster_320_$variant.png')
              ..createSync(recursive: true)
              ..writeAsBytesSync(bytes!.buffer.asUint8List());
          });
        }
      });
    }
  }
}
