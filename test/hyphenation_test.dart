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
        'An-ord-nungs-be-zie-hun-gen',
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

    test('„st“ wird getrennt, wenn kein Wortteil damit beginnt', () {
      // Früher „Mu-sterlösung“ - „st“ galt als untrennbar.
      expect(show(hyphenate('Musterlösung')), 'Mus-ter-lö-sung');
      expect(show(hyphenate('Karteikasten')), 'Kar-tei-kas-ten');
      expect(show(hyphenate('Fensterplatz')), 'Fens-ter-platz');
      expect(show(hyphenate('Lastenheftes')), 'Las-ten-hef-tes');
      expect(show(hyphenate('Betriebssystem')), 'Be-triebs-sys-tem');
      expect(show(hyphenate('Dienstleistung')), 'Dienst-leis-tung');
      expect(show(hyphenate('Administrator')), 'Ad-mi-nis-tra-tor');
      expect(show(hyphenate('Industriebetrieb')), 'In-dus-trie-be-trieb');
    });

    test('„st“ bleibt zusammen, wo ein Wortteil damit beginnt', () {
      expect(show(hyphenate('Kostenstelle')), 'Kos-ten-stelle');
      expect(show(hyphenate('Bestandteilen')), 'Be-stand-tei-len');
      expect(show(hyphenate('Verständlichkeit')), 'Ver-ständ-lich-keit');
      expect(show(hyphenate('Wiederherstellung')), 'Wie-der-her-stel-lung');
      expect(show(hyphenate('Selbstständigkeit')), 'Selbst-stän-dig-keit');
      expect(show(hyphenate('Infrastruktur')), 'In-fra-struk-tur');
      expect(show(hyphenate('Bestätigungsmail')), 'Be-stä-ti-gungs-mail');
      // Kein „Stab“ in der Tabelle, kein „Start“ in den Testarten.
      expect(show(hyphenate('Ausgangstabelle')), 'Aus-gangs-ta-belle');
      expect(show(hyphenate('Testartenübersicht')), 'Test-ar-ten-über-sicht');
      expect(show(hyphenate('Mindestabstand')), 'Min-dest-ab-stand');
    });

    test('„ck“, „ch“ und „sch“ werden nie geteilt', () {
      expect(show(hyphenate('Zuckerfabriken')), 'Zu-cker-fa-bri-ken');
      expect(show(hyphenate('Testabdeckung')), 'Test-ab-de-ckung');
      // Früher „Entwic-klung“ und „Stüc-kliste“.
      expect(
        show(hyphenate('Entwicklungsumgebung')),
        'Ent-wick-lungs-um-ge-bung',
      );
      expect(
        show(hyphenate('Stücklistenauflösung')),
        'Stück-lis-ten-auf-lö-sung',
      );
      expect(show(hyphenate('Wirtschaftlichkeit')), 'Wirt-schaft-lich-keit');
      expect(show(hyphenate('Verschlüsselung')), 'Ver-schlüs-se-lung');
      expect(show(hyphenate('Netzplantechnik')), 'Netz-plan-tech-nik');
      expect(show(hyphenate('Menschlichkeit')), 'Mensch-lich-keit');
    });

    test('Zusammensetzungen werden an der Wortfuge getrennt', () {
      expect(show(hyphenate('Datenübertragung')), 'Da-ten-über-tra-gung');
      expect(
        show(hyphenate('Auftragsverarbeitung')),
        'Auf-trags-ver-ar-bei-tung',
      );
      expect(
        show(hyphenate('Datenschutzbeauftragter')),
        'Da-ten-schutz-be-auf-trag-ter',
      );
      expect(show(hyphenate('Abschlussprüfung')), 'Ab-schluss-prü-fung');
      expect(show(hyphenate('Integritätsprüfung')), 'In-te-gri-täts-prü-fung');
      expect(show(hyphenate('Gesprächspartner')), 'Ge-sprächs-part-ner');
      expect(
        show(hyphenate('Netzwerkkomponenten')),
        'Netz-werk-kom-po-nen-ten',
      );
      expect(show(hyphenate('Nutzwertanalyse')), 'Nutz-wert-ana-lyse');
      expect(show(hyphenate('Voraussetzungen')), 'Vor-aus-set-zun-gen');
      expect(show(hyphenate('Verpflichtungen')), 'Ver-pflich-tun-gen');
      expect(show(hyphenate('Transportschicht')), 'Trans-port-schicht');
      expect(show(hyphenate('Echtzeitsystem')), 'Echt-zeit-sys-tem');
      expect(show(hyphenate('Guthabenkonto')), 'Gut-ha-ben-konto');
      expect(show(hyphenate('Projektrahmen')), 'Pro-jekt-rah-men');
      expect(show(hyphenate('Namensauflösung')), 'Na-mens-auf-lö-sung');
      // Wörter, die nur zufällig einen Stamm enthalten.
      expect(show(hyphenate('Prüfverfahren')), 'Prüf-ver-fah-ren');
      expect(show(hyphenate('Kleinbetrieb')), 'Klein-be-trieb');
      expect(show(hyphenate('Allgemeinheit')), 'All-ge-mein-heit');
      expect(show(hyphenate('ausgeglichen')), 'aus-ge-gli-chen');
      expect(show(hyphenate('Subtraktionen')), 'Sub-trak-tio-nen');
    });

    test('kein einzelner Buchstabe wird abgetrennt', () {
      const words = [
        'Anordnungsbeziehungen',
        'Echtzeitsystem',
        'Anforderungsanalyse',
        'Identitätsprüfung',
        'Energieeffizienz',
        'Übertragungsgeschwindigkeit',
        'Organisationsprojekt',
        'Urheberrechtsgesetz',
      ];
      for (final word in words) {
        final parts = show(hyphenate(word)).split('-');
        expect(parts.join(), word);
        expect(
          parts.every((p) => p.length >= 2),
          isTrue,
          reason: parts.join('-'),
        );
      }
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

  testWidgets('kein Umbruch mitten im Wort ohne Trennstrich', (tester) async {
    // Früher ließ ein Sicherheitsnetz alle Striche weg, wenn das Setzen
    // nicht zur Ruhe kam - dann stand "unterbre|chungsfreien" ohne Strich.
    const texts = [
      'Nenne zwei Vorteile einer unterbrechungsfreien Stromversorgung (USV) '
          'für einen Serverraum.',
      'Vervollständige die Nutzwertanalyse für die Wirtschaftlichkeits'
          'betrachtung der Netzwerkinfrastruktur.',
      'Erläutere die Eintrittswahrscheinlichkeit und die Schadenshöhe bei der '
          'Risikobewertung des Datensicherungskonzepts.',
      // Mehrere Absätze: Früher endete die Zeilensuche am ersten Umbruch.
      'Für die Geräteverwaltung gelten diese Regeln:\n'
          '- Manche Geräte (z. B. der Besprechungslaptop) werden von mehreren '
          'Mitarbeitern genutzt.\n'
          '- Zu jeder Nutzung werden Ausgabe- und Rückgabedatum festgehalten.',
    ];
    for (final text in texts) {
      for (final size in [14.0, 18.85, 22.0, 28.6]) {
        for (var width = 150.0; width <= 360; width += 7) {
          await tester.pumpWidget(
            MaterialApp(
              home: Material(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: width,
                    child: HyphenText(
                      text,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: size,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
          final ro = tester.renderObject<RenderHyphenText>(
            find.byType(HyphenText),
          );
          final where = '$width px, $size pt: ${show(ro.debugPainted)}';
          expect(
            ro.debugDashesAtLineEnds,
            isTrue,
            reason: 'Strich in Zeile $where',
          );
          expect(ro.debugUndashedBreaks, 0, reason: 'ohne Strich $where');
        }
      }
    }
  });
}
