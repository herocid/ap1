import 'package:ap1_trainer/core/theme/app_theme.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/seed/builders.dart';
import 'package:ap1_trainer/widgets/hyphenation.dart';
import 'package:ap1_trainer/widgets/question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Beispielaufgaben und Testrahmen für die Ansichten der Aufgabenarten.
/// Absichtlich mit langen Wörtern, Einheiten und Code - an ihnen zeigt sich,
/// ob auf 320 px mit 130 % Schrift noch alles lesbar ist.
const kSub = 'n-vorwaerts';

final clozeSelect = lueckentext(
  'ts-cloze-select',
  kSub,
  prompt: 'Ergänze die Aussagen zu den Transportprotokollen.',
  text:
      '{0} arbeitet verbindungsorientiert und bestätigt jedes Segment. '
      'Für Videotelefonie eignet sich {1}, weil verlorene Pakete nicht neu '
      'gesendet werden. Beide Protokolle gehören zur {2} des OSI-Modells.',
  luecken: [
    wahl('TCP', ['UDP', 'ICMP'], 'TCP baut per Drei-Wege-Handshake auf.'),
    wahl('UDP', ['TCP', 'ARP'], 'UDP verzichtet auf Bestätigungen.'),
    wahl('Transportschicht', [
      'Vermittlungsschicht',
      'Sicherungsschicht',
      'Anwendungsschicht',
    ], 'Schicht 4 adressiert über Ports.'),
  ],
  explanation:
      'TCP ist zuverlässig und verbindungsorientiert, UDP schnell und '
      'verbindungslos. Beide liegen auf Schicht 4 (Transport).',
  punkte: 3,
);

final clozeBank = lueckentext(
  'ts-cloze-bank',
  kSub,
  prompt: 'Setze die Vertragsarten ein.',
  text:
      'Beim {0} wird ein Erfolg geschuldet, beim {1} nur die Tätigkeit. '
      'Standardsoftware von der Stange erwirbt man per {2}.',
  luecken: [
    wort(['Werkvertrag'], 'Geschuldet ist das fertige Werk (§ 631 BGB).'),
    wort(['Dienstvertrag'], 'Geschuldet ist das Bemühen, kein Erfolg.'),
    wort(['Kaufvertrag'], 'Sache gegen Geld.'),
  ],
  wortbank: ['Mietvertrag', 'Leasingvertrag'],
  explanation:
      'Werkvertrag = Erfolg, Dienstvertrag = Tätigkeit, Kaufvertrag = '
      'Übereignung einer Sache gegen Zahlung des Kaufpreises.',
);

final clozeInput = lueckentext(
  'ts-cloze-input',
  kSub,
  prompt: 'Berechne die fehlenden Werte des Netzes 192.168.10.64/26.',
  text:
      'Das Netz hat {0} nutzbare Hostadressen. Die Subnetzmaske lautet '
      '{1}. Ein Server mit 350 W im Dauerbetrieb verbraucht pro Tag {2}.',
  luecken: [
    zahl(62, einheit: 'Hosts', rationale: '2^6 - 2 = 62.'),
    wort(['255.255.255.192'], '26 Bit Netzanteil: letztes Oktett 192.'),
    zahl(8.4, toleranz: 0.05, einheit: 'kWh', rationale: '0,35 kW x 24 h.'),
  ],
  explanation:
      '/26 lässt 6 Hostbits: 2^6 - 2 = 62 Hosts, Maske 255.255.255.192. '
      '0,35 kW x 24 h = 8,4 kWh.',
);

final clozeCode = lueckentext(
  'ts-cloze-code',
  kSub,
  prompt: 'Ergänze den Pseudocode, der die Summe aller Bestellwerte bildet.',
  mono: true,
  text:
      'summe = {0}\n'
      'FÜR i = 0 BIS laenge(bestellungen) - {1}\n'
      '    WENN bestellungen[i].status == "offen" DANN\n'
      '        summe = summe {2} bestellungen[i].wert\n'
      '    ENDE WENN\n'
      'ENDE FÜR\n'
      'AUSGABE summe',
  luecken: [
    zahl(0, rationale: 'Eine Summe startet bei 0.'),
    zahl(1, rationale: 'Der letzte Index ist laenge - 1.'),
    wahl('+', ['-', '*', '='], 'Aufsummieren heißt addieren.'),
  ],
  explanation:
      'Die Summe wird mit 0 initialisiert, die Schleife läuft bis '
      'laenge - 1, und jeder offene Wert wird addiert.',
  punkte: 3,
);

final tableQuestion = tabelle(
  'ts-table',
  kSub,
  prompt: 'Vervollständige die Nutzwertanalyse für die beiden Anbieter.',
  scenario:
      'Gewichtung: Preis 40 %, Leistung 60 %. Punkte von 1 (schlecht) bis '
      '10 (sehr gut).',
  zeilen: [
    ['Anbieter', 'Preis', 'Leistung', 'Nutzwert'],
    ['Alphanet', '8', '5', zahl(6.2, rationale: '8 x 0,4 + 5 x 0,6 = 6,2')],
    ['Betacom', '6', '7', zahl(6.6, rationale: '6 x 0,4 + 7 x 0,6 = 6,6')],
    [
      'Entscheidung',
      '',
      '',
      wahl('Betacom', ['Alphanet'], 'Der höhere Nutzwert gewinnt.'),
    ],
  ],
  explanation:
      'Nutzwert = Summe aus Punkten mal Gewicht. Alphanet 6,2, Betacom 6,6 - '
      'Betacom gewinnt.',
);

final tableWide = tabelle(
  'ts-table-wide',
  kSub,
  prompt: 'Trage die Netzdaten der drei Subnetze ein.',
  zeilen: [
    ['Subnetz', 'Netzadresse', 'Erster Host', 'Broadcast', 'Hosts'],
    [
      'Verwaltung',
      '192.168.10.0',
      wort(['192.168.10.1']),
      wort(['192.168.10.63'], 'Letzte Adresse des /26-Blocks.'),
      zahl(62),
    ],
    [
      'Lager',
      wort(['192.168.10.64']),
      '192.168.10.65',
      wort(['192.168.10.127']),
      zahl(62),
    ],
    [
      'Gäste',
      '192.168.10.128',
      '192.168.10.129',
      wahl('192.168.10.191', ['192.168.10.255', '192.168.10.192']),
      zahl(62, einheit: 'Hosts'),
    ],
  ],
  explanation:
      'Ein /26-Netz umfasst 64 Adressen: Netzadresse, 62 Hosts, Broadcast. '
      'Die Blöcke beginnen bei 0, 64, 128 und 192.',
);

final openQuestion = freitext(
  'ts-open',
  kSub,
  prompt:
      'Nennen Sie zwei Vorteile einer unterbrechungsfreien Stromversorgung '
      '(USV) für einen Serverraum.',
  kriterien: [
    krit(
      'Überbrückung bei Stromausfall',
      stichwoerter: ['Stromausfall', 'überbrücken', 'Ausfall'],
    ),
    krit(
      'Geordnetes Herunterfahren der Server',
      stichwoerter: ['herunterfahren', 'Shutdown'],
    ),
    krit(
      'Schutz vor Spannungsschwankungen und Überspannung',
      stichwoerter: ['Spannungsschwankung', 'Überspannung', 'Spannung'],
    ),
    krit(
      'Schutz vor Datenverlust',
      stichwoerter: ['Datenverlust', 'Daten verloren'],
    ),
  ],
  loesung:
      'Eine USV überbrückt kurze Stromausfälle mit ihren Akkus und gibt '
      'den Servern Zeit, geordnet herunterzufahren. Außerdem glättet sie '
      'Spannungsschwankungen und schützt so Hardware und Daten.',
  explanation:
      'Je Nennung 1 Punkt, höchstens 2 Punkte. Andere sinnvolle Vorteile '
      'sind ebenfalls richtig.',
  punkte: 2,
);

final markingCode = markieren(
  'ts-mark-code',
  kSub,
  prompt:
      'Der Pseudocode soll den Durchschnitt der Messwerte ausgeben. '
      'Markiere die beiden fehlerhaften Zeilen.',
  mono: true,
  zeilen: [
    nein('summe = 0', 'Die Initialisierung mit 0 ist richtig.'),
    ja(
      'FÜR i = 0 BIS laenge(werte)',
      'Der letzte Index ist laenge - 1; so wird über das Array hinaus '
          'gelesen.',
    ),
    nein('    summe = summe + werte[i]', 'Aufsummieren ist korrekt.'),
    nein('ENDE FÜR', ''),
    ja(
      'durchschnitt = summe * laenge(werte)',
      'Für den Durchschnitt muss geteilt werden, nicht multipliziert.',
    ),
    nein('AUSGABE durchschnitt', ''),
  ],
  explanation:
      'Fehler 1: Schleifenobergrenze (Off-by-one). Fehler 2: Division statt '
      'Multiplikation für den Durchschnitt.',
);

final markingList = markieren(
  'ts-mark-list',
  kSub,
  prompt: 'Welche Angaben sind personenbezogene Daten im Sinne der DSGVO?',
  zeilen: [
    ja('E-Mail-Adresse max.mustermann@firma.de', 'Identifiziert eine Person.'),
    nein('Umsatz der Filiale Kassel im März', 'Kein Bezug zu einer Person.'),
    ja('IP-Adresse eines Kundenanschlusses', 'Gilt als personenbeziehbar.'),
    nein('Seriennummer eines Lagerregals', 'Sachdatum ohne Personenbezug.'),
    ja('Personalnummer', 'Eindeutig einer Person zugeordnet.'),
  ],
  explanation:
      'Personenbezogen ist alles, was sich auf eine identifizierte oder '
      'identifizierbare natürliche Person bezieht (Art. 4 DSGVO).',
);

final pairsQuestion = paare(
  'ts-pairs',
  kSub,
  prompt: 'Ordne jedem Protokoll seine Aufgabe zu.',
  paare: [
    paar('DNS', 'Namensauflösung'),
    paar('DHCP', 'Adressvergabe'),
    paar('SMTP', 'E-Mail-Versand'),
    paar('HTTPS', 'Verschlüsselte Webseiten'),
    paar('SSH', 'Sichere Fernwartung'),
  ],
  explanation:
      'DNS löst Namen auf, DHCP verteilt Adressen, SMTP versendet E-Mails, '
      'HTTPS überträgt Webseiten verschlüsselt, SSH dient der Fernwartung.',
);

final singleQuestion = einfach(
  'ts-single',
  kSub,
  prompt: 'Welches Schutzziel verletzt ein Ausfall des Webshops?',
  choices: [
    ja('Verfügbarkeit', 'Das System ist nicht erreichbar.'),
    nein('Vertraulichkeit', 'Es wurden keine Daten offengelegt.'),
    nein('Integrität', 'Es wurden keine Daten verändert.'),
    nein('Authentizität', 'Die Echtheit ist nicht betroffen.'),
    nein('Keine der genannten', 'Die Verfügbarkeit ist betroffen.'),
  ],
  explanation:
      'Verfügbarkeit heißt: Systeme und Daten sind nutzbar, wenn sie '
      'gebraucht werden. Ein Ausfall verletzt genau dieses Ziel.',
);

final multiQuestion = mehrfach(
  'ts-multi',
  kSub,
  prompt: 'Welche Maßnahmen erhöhen die Verfügbarkeit?',
  choices: [
    ja('Redundantes Netzteil', 'Fällt eines aus, übernimmt das andere.'),
    ja('USV', 'Überbrückt Stromausfälle.'),
    nein('Verschlüsselung', 'Dient der Vertraulichkeit.'),
    nein('Hashwert', 'Dient der Integrität.'),
  ],
  explanation:
      'Verfügbarkeit erhöht alles, was Ausfälle verhindert oder überbrückt: '
      'Redundanz und USV.',
);

final matchingQuestion = zuordnen(
  'ts-match',
  kSub,
  prompt: 'Ordne die Maßnahmen den Schutzzielen zu.',
  buckets: ['Vertraulichkeit', 'Integrität', 'Verfügbarkeit'],
  items: [
    zu('Festplattenverschlüsselung', 0, 'Nur Berechtigte lesen die Daten.'),
    zu('Zugriffsrechte nach Need-to-know', 0),
    zu('Hashwert einer Datei prüfen', 1, 'Veränderungen fallen auf.'),
    zu('Digitale Signatur', 1),
    zu('Redundantes Netzteil', 2, 'Ausfall wird abgefangen.'),
    zu('Tägliche Datensicherung', 2),
  ],
  explanation:
      'Vertraulichkeit: nur Befugte lesen. Integrität: unverändert und '
      'vollständig. Verfügbarkeit: nutzbar, wenn benötigt.',
);

final orderingQuestion = reihenfolge(
  'ts-order',
  kSub,
  prompt: 'Bringe die Phasen der Teamentwicklung nach Tuckman in Reihenfolge.',
  items: [
    'Forming – Orientierung, das Team lernt sich kennen',
    'Storming – Konflikte um Rollen und Vorgehen',
    'Norming – Regeln und Zusammenarbeit festigen sich',
    'Performing – das Team arbeitet eigenständig und produktiv',
  ],
  explanation:
      'Forming, Storming, Norming, Performing - erst nach dem Aushandeln der '
      'Regeln erreicht ein Team seine volle Leistung.',
);

final materialQuestion = einfach(
  'ts-material',
  kSub,
  prompt:
      'Welche Schnittstelle empfiehlt das Handbuch für den zweiten Monitor?',
  scenario: 'Du richtest einen Arbeitsplatz mit zwei Monitoren ein.',
  table: [
    ['Anschluss', 'Max. Auflösung', 'Daisy Chain'],
    ['HDMI 2.0', '3840 x 2160 bei 60 Hz', 'nein'],
    ['DisplayPort 1.4', '7680 x 4320 bei 60 Hz', 'ja (MST)'],
  ],
  code:
      'To connect a second display, use the DisplayPort output of the first '
      'monitor. Multi-Stream Transport (MST) must be enabled in the on-screen '
      'menu. HDMI does not support daisy chaining.',
  choices: [
    ja('DisplayPort', 'MST erlaubt das Durchschleifen.'),
    nein('HDMI', 'Laut Text kein Daisy Chaining.'),
    nein('VGA', 'Wird nicht erwähnt.'),
  ],
  explanation:
      'Der englische Text nennt DisplayPort mit Multi-Stream Transport als '
      'Weg, einen zweiten Monitor in Reihe anzuschließen.',
);

final kNewKindSamples = <Question>[
  clozeSelect,
  clozeBank,
  clozeInput,
  clozeCode,
  tableQuestion,
  tableWide,
  openQuestion,
  markingCode,
  markingList,
  pairsQuestion,
];

final kAllSamples = <Question>[
  ...kNewKindSamples,
  singleQuestion,
  multiQuestion,
  matchingQuestion,
  orderingQuestion,
  materialQuestion,
];

/// Hält Antwort und Prüfzustand wie der echte Host (Session).
class QuestionHost {
  QuestionHost(this.question, {this.seed = 7, this.answer});

  final Question question;
  int seed;
  Object? answer;
  bool revealed = false;
  final changes = <Object?>[];
  StateSetter? _setState;

  GradeResult get grade => question.grade(answer);

  Widget build({bool dark = false, bool showExplanation = true}) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: dark ? AppTheme.dark() : AppTheme.light(),
    home: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: StatefulBuilder(
          builder: (context, setState) {
            _setState = setState;
            return QuestionView(
              question: question,
              answer: answer,
              onChanged: (a) => setState(() {
                answer = a;
                changes.add(a);
              }),
              revealed: revealed,
              grade: revealed ? grade : null,
              showExplanation: showExplanation,
              shuffleSeed: seed,
            );
          },
        ),
      ),
    ),
  );

  Future<void> check(WidgetTester tester) async {
    _setState!(() => revealed = true);
    await tester.pumpAndSettle();
  }
}

void setView(WidgetTester tester, Size size, double scale) {
  tester.view.physicalSize = size * 3;
  tester.view.devicePixelRatio = 3;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

String? _shownText(Widget w) => switch (w) {
  Text t => t.data,
  HyphenText h => '${h.prefix ?? ''}${h.text}',
  _ => null,
};

/// Wie `find.text`, findet aber auch getrennten Text ([HyphenText]).
Finder textOf(String s) =>
    find.byWidgetPredicate((w) => _shownText(w) == s, description: 'Text "$s"');

Finder textHas(String s) => find.byWidgetPredicate(
  (w) => _shownText(w)?.contains(s) ?? false,
  description: 'Text mit "$s"',
);
