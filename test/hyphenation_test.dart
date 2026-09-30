import 'package:ap1_trainer/widgets/hyphenation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fonts.dart';

/// Weiche Trennstellen als „-“ sichtbar machen, damit die Erwartungen
/// lesbar bleiben.
String show(String s) => s
    .replaceAll(String.fromCharCode(0xAD), '-')
    .replaceAll(kZeroWidthSpace, '|');

void main() {
  setUpAll(loadAppFonts);

  group('hyphenate', () {
    test('trennt lange Komposita an Silbengrenzen', () {
      expect(
        show(hyphenate('Eintrittswahrscheinlichkeit')),
        'Ein-tritts-wahr-schein-lich-keit',
      );
      expect(
        show(hyphenate('Anordnungsbeziehungen')),
        'Anord-nungs-be-zie-hun-gen',
      );
      expect(
        show(hyphenate('Kapitalgesellschaften')),
        'Ka-pi-tal-ge-sell-schaf-ten',
      );
    });

    test('Fugen-s vor Vokal bleibt beim ersten Wort', () {
      expect(
        show(hyphenate('Anschaffungsauszahlung')),
        'An-schaf-fungs-aus-zah-lung',
      );
    });

    test('kurze Wörter und normale Sätze bleiben unverändert', () {
      expect(hyphenate('Projekt'), 'Projekt');
      expect(hyphenate('Das ist ein Test.'), 'Das ist ein Test.');
    });

    test('lange Ausdrücke ohne Leerzeichen bekommen Umbruchstellen', () {
      expect(
        show(hyphenate('https://shop.example.com:8443')),
        'https://|shop.|example.|com:|8443',
      );
      expect(
        show(hyphenate('Lessons-Learned-Workshop')),
        'Lessons-|Learned-|Workshop',
      );
    });
  });

  testWidgets('HyphenText setzt den Strich genau an das Zeilenende', (
    tester,
  ) async {
    const text =
        'Kapitalwert = Summe der Barwerte - Anschaffungsauszahlung = '
        '13.616,24 € - 12.000 € = 1.616,24 €. Die Eintrittswahrscheinlichkeit '
        'mal Schadenshöhe ergibt den Risikowert.';
    for (final width in [120.0, 160.0, 213.75, 240.0, 300.0]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: width,
                child: const HyphenText(
                  text,
                  style: TextStyle(fontFamily: 'Inter', fontSize: 18.85),
                ),
              ),
            ),
          ),
        ),
      );
      final ro = tester.renderObject<RenderHyphenText>(find.byType(HyphenText));
      final painted = ro.debugPainted;
      // Jeder sichtbare Trennstrich muss am Ende einer Zeile stehen.
      expect(
        ro.debugDashesAtLineEnds,
        isTrue,
        reason: 'Strich mitten in der Zeile bei $width px: ${show(painted)}',
      );
      // Bei schmaler Breite wird tatsächlich getrennt.
      if (width <= 160) expect(painted, contains('-$kZeroWidthSpace'));
      expect(ro.plainText, text);
    }
  });
}
