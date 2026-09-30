import 'dart:io';

import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/diagram.dart';
import 'package:ap1_trainer/data/models/netzplan.dart';
import 'package:flutter/services.dart';

/// Lädt die echten App-Schriften (Inter, JetBrains Mono) in die
/// Testumgebung - sonst misst flutter_test mit einer Ersatzschrift, deren
/// Zeichen alle quadratisch sind.
Future<void> loadDiagramFonts() async {
  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      final bytes = File('assets/fonts/$f').readAsBytesSync();
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    }
    await loader.load();
  }

  await load(kFontSans, [
    'Inter-Regular.ttf',
    'Inter-Medium.ttf',
    'Inter-SemiBold.ttf',
    'Inter-Bold.ttf',
  ]);
  await load(kFontMono, [
    'JetBrainsMono-Regular.ttf',
    'JetBrainsMono-Bold.ttf',
  ]);
}

/// Beispielzeichnungen mit typischen AP1-Inhalten - je Art mindestens
/// eine. Genutzt von `diagram_layout_test.dart` und dem Vorschau-Generator
/// `tool/render_diagrams_test.dart`.
final Map<String, Diagram> kDiagramSamples = {
  'stapel_osi': const StapelDiagramm([
    StapelEbene('Anwendung', 'HTTP, FTP, SMTP, DNS'),
    StapelEbene('Darstellung', 'TLS, JPEG, ASCII'),
    StapelEbene('Sitzung', 'RPC, NetBIOS'),
    StapelEbene('Transport', 'TCP, UDP – Ports'),
    StapelEbene('Vermittlung', 'IP, ICMP – Router'),
    StapelEbene('Sicherung', 'Ethernet, MAC – Switch'),
    StapelEbene('Bitübertragung', 'Kabel, Funk – Hub, Repeater'),
  ]),
  'stapel_schichten': const StapelDiagramm(
    [
      StapelEbene('Präsentationsschicht'),
      StapelEbene('Logikschicht'),
      StapelEbene('Datenhaltungsschicht'),
    ],
    oben: 'nah am Benutzer',
    unten: 'nah an den Daten',
  ),
  'stapel_speicher': const StapelDiagramm(
    [
      StapelEbene('Register', '< 1 ns'),
      StapelEbene('Cache', '1–10 ns'),
      StapelEbene('Arbeitsspeicher', 'ca. 100 ns'),
      StapelEbene('SSD', 'ca. 0,1 ms'),
      StapelEbene('Festplatte (HDD)', 'ca. 10 ms'),
    ],
    pyramide: true,
    oben: 'schnell, teuer, klein',
    unten: 'langsam, günstig, groß',
  ),
  'fluss_pdca': const FlussDiagramm(
    [
      FlussKnoten('Plan – Ziele und Maßnahmen planen'),
      FlussKnoten('Do – Maßnahmen im Kleinen umsetzen'),
      FlussKnoten('Check – Ergebnisse prüfen'),
      FlussKnoten('Act – bewährte Lösung einführen'),
    ],
    zyklus: true,
    zyklusLabel: 'kontinuierliche Verbesserung',
  ),
  'fluss_aktivitaet': const FlussDiagramm([
    FlussKnoten('', form: FlussForm.start),
    FlussKnoten('Bestellung prüfen'),
    FlussKnoten(
      'Artikel lieferbar?',
      form: FlussForm.entscheidung,
      pfeil: '[ja]',
      seitlich: '[nein] Kunden informieren',
    ),
    FlussKnoten('Rechnung', form: FlussForm.dokument),
    FlussKnoten('Ware versenden'),
    FlussKnoten('', form: FlussForm.ende),
  ]),
  'fluss_eva': const FlussDiagramm([
    FlussKnoten('Eingabe (Tastatur, Scanner)'),
    FlussKnoten('Verarbeitung (CPU, Arbeitsspeicher)'),
    FlussKnoten('Ausgabe (Monitor, Drucker)'),
  ]),
  'baum_psp': const BaumDiagramm(
    BaumKnoten('Einführung Ticketsystem', [
      BaumKnoten('Analyse', [
        BaumKnoten('Ist-Analyse', [], '1.1.1'),
        BaumKnoten('Soll-Konzept', [], '1.1.2'),
      ], '1.1'),
      BaumKnoten('Umsetzung', [
        BaumKnoten('Installation', [], '1.2.1'),
        BaumKnoten('Konfiguration', [], '1.2.2'),
        BaumKnoten('Datenübernahme', [], '1.2.3'),
      ], '1.2'),
      BaumKnoten('Test', [
        BaumKnoten('Funktionstest', [], '1.3.1'),
        BaumKnoten('Abnahme', [], '1.3.2'),
      ], '1.3'),
      BaumKnoten('Einführung', [
        BaumKnoten('Schulung', [], '1.4.1'),
        BaumKnoten('Go-live', [], '1.4.2'),
      ], '1.4'),
    ], '1'),
  ),
  'baum_organigramm': const BaumDiagramm(
    BaumKnoten('Geschäftsführung', [
      BaumKnoten('Vertrieb'),
      BaumKnoten('IT', [BaumKnoten('Support'), BaumKnoten('Entwicklung')]),
      BaumKnoten('Verwaltung'),
    ]),
  ),
  'sequenz_dora': const SequenzDiagramm(
    ['Client', 'DHCP-Server'],
    [
      Nachricht(0, 1, 'DHCPDISCOVER (Broadcast)'),
      Nachricht(1, 0, 'DHCPOFFER (IP-Angebot)', antwort: true),
      Nachricht(0, 1, 'DHCPREQUEST'),
      Nachricht(1, 0, 'DHCPACK (Bestätigung)', antwort: true),
    ],
  ),
  'sequenz_dns': const SequenzDiagramm(
    ['Browser', 'DNS-Resolver', 'Webserver'],
    [
      Nachricht(0, 1, 'Anfrage: IP von www.example.de?'),
      Nachricht(1, 0, '93.184.216.34', antwort: true),
      Nachricht(0, 2, 'HTTP GET /index.html'),
      Nachricht(2, 0, '200 OK + HTML', antwort: true),
    ],
  ),
  'quadranten_stakeholder': const QuadrantenDiagramm(
    xAchse: 'Interesse am Projekt',
    yAchse: 'Einfluss',
    obenLinks: Quadrant('Zufriedenstellen', 'z. B. Geschäftsführung'),
    obenRechts: Quadrant(
      'Eng einbinden',
      'Schlüsselpersonen, z. B. Auftraggeber',
    ),
    untenLinks: Quadrant('Beobachten', 'geringer Aufwand'),
    untenRechts: Quadrant('Informieren', 'z. B. Anwender, Betriebsrat'),
  ),
  'balken_nutzwert': const BalkenDiagramm(
    [
      Balken('Angebot A (Systemhaus Nord)', 7.4),
      Balken('Angebot B (IT-Partner GmbH)', 8.15, hervorheben: true),
      Balken('Angebot C', 6.35),
    ],
    einheit: 'Punkte',
    max: 10,
  ),
  'gantt_projekt': const GanttDiagramm([
    GanttVorgang('Anforderungen aufnehmen', 0, 3, kritisch: true),
    GanttVorgang('Hardware beschaffen', 3, 4),
    GanttVorgang('Software einrichten', 3, 5, kritisch: true),
    GanttVorgang('Test', 8, 2, kritisch: true),
    GanttVorgang('Schulung', 8, 1),
    GanttVorgang('Abnahme', 10, 0, kritisch: true),
  ]),
  'geraden_breakeven': const GeradenDiagramm(
    xAchse: 'Menge in Stück',
    yAchse: 'Euro',
    xMax: 1500,
    yMax: 60000,
    geraden: [
      Gerade('Gesamtkosten K = 20.000 + 20 · x', 20000, 20),
      Gerade('Erlös E = 40 · x', 0, 40),
    ],
    punkte: [DiagrammPunkt(1000, 40000, 'Break-even (1.000 Stück)')],
  ),
  'geraden_makebuy': const GeradenDiagramm(
    xAchse: 'Stunden pro Monat',
    yAchse: 'Kosten in €',
    xMax: 100,
    yMax: 8000,
    geraden: [
      Gerade('Eigenleistung', 2500, 35),
      Gerade('Fremdbezug', 0, 75),
      Gerade('Pauschale', 5000, 0),
    ],
    punkte: [DiagrammPunkt(62.5, 4687.5, 'Grenzmenge 62,5 h')],
  ),
  'klassen_konto': const KlassenDiagramm(
    [
      UmlKlasse(
        'Kunde',
        attribute: ['- kundenNr: int', '- name: String'],
        methoden: ['+ getName(): String'],
      ),
      UmlKlasse(
        'Konto',
        attribute: ['- iban: String', '- kontostand: double'],
        methoden: [
          '+ einzahlen(betrag: double): void',
          '+ auszahlen(betrag: double): boolean',
        ],
      ),
      UmlKlasse('Buchung', attribute: ['- datum: Date', '- betrag: double']),
    ],
    beziehungen: [
      UmlBeziehung(0, 1, multVon: '1', multZu: '0..*', label: 'besitzt'),
      UmlBeziehung(1, 2, art: UmlArt.komposition, multVon: '1', multZu: '0..*'),
    ],
  ),
  'klassen_bestellung': const KlassenDiagramm(
    [
      UmlKlasse('Kunde', attribute: ['- name: String']),
      UmlKlasse(
        'Bestellung',
        attribute: ['- datum: Date'],
        methoden: ['+ summe(): double'],
      ),
      UmlKlasse('Position', attribute: ['- menge: int']),
      UmlKlasse('Artikel', attribute: ['- preis: double']),
      UmlKlasse(
        'Bezahlbar',
        stereotyp: 'interface',
        methoden: ['+ bezahlen(): boolean'],
      ),
    ],
    beziehungen: [
      UmlBeziehung(0, 1, multVon: '1', multZu: '0..*', label: 'gibt auf'),
      UmlBeziehung(1, 2, art: UmlArt.komposition, multVon: '1', multZu: '1..*'),
      UmlBeziehung(2, 3, art: UmlArt.gerichtet, multVon: '0..*', multZu: '1'),
      UmlBeziehung(
        0,
        3,
        art: UmlArt.aggregation,
        multVon: '0..1',
        multZu: '*',
        label: 'merkt',
      ),
      UmlBeziehung(1, 4, art: UmlArt.abhaengigkeit),
    ],
  ),
  'erm_shop': const ErmDiagramm(
    [
      ErmEntitaet(
        'Kunde',
        attribute: ['KundenNr', 'Name', 'Anschrift'],
        schluessel: ['KundenNr'],
      ),
      ErmEntitaet(
        'Bestellung',
        attribute: ['BestellNr', 'Datum'],
        schluessel: ['BestellNr'],
      ),
      ErmEntitaet(
        'Artikel',
        attribute: ['ArtikelNr', 'Bezeichnung', 'Preis'],
        schluessel: ['ArtikelNr'],
      ),
    ],
    beziehungen: [
      ErmBeziehung('Kunde', 'gibt auf', 'Bestellung', '1', 'n'),
      ErmBeziehung('Bestellung', 'enthält', 'Artikel', 'm', 'n'),
    ],
  ),
  'erm_schule': const ErmDiagramm(
    [
      ErmEntitaet(
        'Lehrer',
        attribute: ['PersNr', 'Name'],
        schluessel: ['PersNr'],
      ),
      ErmEntitaet(
        'Klasse',
        attribute: ['Bezeichnung'],
        schluessel: ['Bezeichnung'],
      ),
      ErmEntitaet('Raum', attribute: ['RaumNr'], schluessel: ['RaumNr']),
    ],
    beziehungen: [
      ErmBeziehung('Lehrer', 'leitet', 'Klasse', '1', '1'),
      ErmBeziehung('Klasse', 'hat', 'Raum', 'n', '1'),
      ErmBeziehung('Lehrer', 'betreut', 'Raum', '1', 'n'),
    ],
  ),
  'usecase_shop': const UseCaseDiagramm(
    system: 'Onlineshop',
    faelle: [
      'Artikel suchen',
      'Bestellung aufgeben',
      'Kundenkonto anlegen',
      'Bestellung versenden',
      'Anmelden',
      'Gutschein einlösen',
    ],
    akteure: [
      UcAkteur('Kunde', [0, 1, 2]),
      UcAkteur('Lagermitarbeiter', [3]),
    ],
    beziehungen: [
      UcBeziehung(1, 4, UcArt.include),
      UcBeziehung(5, 1, UcArt.extend),
      UcBeziehung(3, 4, UcArt.include),
    ],
  ),
  'netz_dmz': const NetzSkizze(
    [
      NetzKnoten('inet', 'Internet', NetzTyp.internet, 2, 0),
      NetzKnoten('fw1', 'Firewall 1', NetzTyp.firewall, 2, 1),
      NetzKnoten('web', 'Webserver', NetzTyp.server, 1, 2),
      NetzKnoten('sw1', 'Switch', NetzTyp.switch_, 2, 2),
      NetzKnoten('mail', 'Mailserver', NetzTyp.server, 3, 2),
      NetzKnoten('fw2', 'Firewall 2', NetzTyp.firewall, 2, 3),
      NetzKnoten('sw2', 'Switch', NetzTyp.switch_, 2, 4),
      NetzKnoten('ap', 'Access Point', NetzTyp.accessPoint, 3, 4),
      NetzKnoten('pc', 'PC', NetzTyp.pc, 1, 5),
      NetzKnoten('nas', 'NAS', NetzTyp.nas, 2, 5),
      NetzKnoten('phone', 'Smartphone', NetzTyp.smartphone, 3, 5),
    ],
    verbindungen: [
      NetzVerbindung('inet', 'fw1'),
      NetzVerbindung('fw1', 'sw1'),
      NetzVerbindung('sw1', 'web'),
      NetzVerbindung('sw1', 'mail'),
      NetzVerbindung('sw1', 'fw2'),
      NetzVerbindung('fw2', 'sw2'),
      NetzVerbindung('sw2', 'pc'),
      NetzVerbindung('sw2', 'nas'),
      NetzVerbindung('sw2', 'ap'),
      NetzVerbindung('ap', 'phone', funk: true, label: 'WLAN'),
    ],
    zonen: [NetzZone('DMZ', 1, 2, 3, 2), NetzZone('LAN', 1, 4, 3, 5)],
  ),
  'netz_heim': const NetzSkizze(
    [
      NetzKnoten('cloud', 'Cloud-Speicher', NetzTyp.cloud, 0, 0),
      NetzKnoten('inet', 'Internet', NetzTyp.internet, 1, 0),
      NetzKnoten('r', 'DSL-Router', NetzTyp.router, 1, 1),
      NetzKnoten('lap', 'Laptop', NetzTyp.laptop, 0, 2),
      NetzKnoten('drucker', 'Drucker', NetzTyp.drucker, 2, 2),
    ],
    verbindungen: [
      NetzVerbindung('cloud', 'inet'),
      NetzVerbindung('inet', 'r', label: 'DSL'),
      NetzVerbindung('r', 'lap', funk: true),
      NetzVerbindung('r', 'drucker', label: 'LAN'),
    ],
  ),
  'bits_subnetz': const BitDiagramm([
    BitZeile(
      'IP-Adresse 192.168.10.77',
      '11000000.10101000.00001010.01001101',
      netz: 26,
    ),
    BitZeile(
      'Subnetzmaske /26',
      '11111111.11111111.11111111.11000000',
      netz: 26,
    ),
    BitZeile(
      'Netzadresse 192.168.10.64',
      '11000000.10101000.00001010.01000000',
      netz: 26,
    ),
  ]),
  'bits_ascii': const BitDiagramm([
    BitZeile('A = 65', '0100 0001'),
    BitZeile('a = 97', '0110 0001'),
  ], legende: 'Groß- und Kleinbuchstabe unterscheiden sich nur in Bit 5.'),
  'netzplan_projekt': const NetzplanDiagramm([
    Activity(id: 'A', name: 'Anforderungen', duration: 3),
    Activity(
      id: 'B',
      name: 'Hardware beschaffen',
      duration: 5,
      predecessors: ['A'],
    ),
    Activity(
      id: 'C',
      name: 'Software entwickeln',
      duration: 8,
      predecessors: ['A'],
    ),
    Activity(id: 'D', name: 'Installation', duration: 2, predecessors: ['B']),
    Activity(id: 'E', name: 'Test', duration: 4, predecessors: ['C', 'D']),
    Activity(id: 'F', name: 'Abnahme', duration: 1, predecessors: ['E']),
  ]),
  'netzplan_leer': const NetzplanDiagramm([
    Activity(id: '1', name: 'Planung', duration: 2),
    Activity(id: '2', name: 'Einkauf', duration: 4, predecessors: ['1']),
    Activity(
      id: '3',
      name: 'Schulung vorbereiten',
      duration: 3,
      predecessors: ['1'],
    ),
    Activity(id: '4', name: 'Rollout', duration: 2, predecessors: ['2', '3']),
  ], mitWerten: false),
  'netzplan_legende': const NetzplanLegende(),
};
