import 'package:ap1_trainer/data/models/diagram.dart';
import 'package:ap1_trainer/data/models/nugget.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/models/subtopic.dart';

/// Absichtlich lange, unhandliche Inhalte - so lang, wie die Inhalts-Agenten
/// sie künftig schreiben (und etwas länger). Wer das Layout ändert, sieht
/// an ihnen, ob noch alles vollständig sichtbar bleibt.
const kFixtureLesson = 'n-vorwaerts';

String get _topic => Subtopics.byId(kFixtureLesson)!.topicId;

Nugget _n(
  String id,
  NuggetKind kind,
  String title,
  String body, {
  List<String> points = const [],
  List<List<String>>? table,
  String? code,
  String? merksatz,
  Diagram? diagram,
  String? ergebnis,
}) => Nugget(
  id: id,
  topicId: _topic,
  subtopicId: kFixtureLesson,
  kind: kind,
  title: title,
  body: body,
  points: points,
  table: table,
  code: code,
  merksatz: merksatz,
  diagram: diagram,
  ergebnis: ergebnis,
);

final kLongNuggets = <Nugget>[
  _n(
    'fx-1',
    NuggetKind.vergleich,
    'Risikobewertung: Eintrittswahrscheinlichkeit und Schadenshöhe',
    'Die Risikomatrix ordnet jedes Risiko nach zwei Größen ein. Erst die '
        'Kombination zeigt, welche Maßnahme angemessen ist - ein seltenes, '
        'aber existenzbedrohendes Risiko wiegt schwerer als ein häufiges '
        'Ärgernis.',
    table: [
      ['Strategie', 'Idee', 'Beispiel aus dem IT-Projekt', 'Restrisiko'],
      [
        'Vermeiden',
        'Ursache beseitigen, Vorhaben ändern',
        'Auf die unerprobte Datenbankversion verzichten',
        'keines',
      ],
      [
        'Vermindern',
        'Eintrittswahrscheinlichkeit oder Schadenshöhe senken',
        'Zusätzliche Tests, Schulung der Anwenderinnen und Anwender',
        'verringert',
      ],
      [
        'Übertragen',
        'Risiko vertraglich auf Dritte verlagern',
        'Versicherung, Festpreisvertrag mit Konventionalstrafe',
        'beim Dritten',
      ],
      [
        'Akzeptieren',
        'Bewusst tragen, Rückstellung bilden',
        'Kleine Terminverschiebung wird hingenommen',
        'vollständig',
      ],
    ],
    merksatz:
        'Vermeiden, vermindern, übertragen, akzeptieren - in der Prüfung '
        'immer mit konkretem Beispiel begründen.',
  ),
  _n(
    'fx-2',
    NuggetKind.beispiel,
    'Kapitalwert einer Serverinvestition berechnen',
    'Ein Unternehmen investiert 12.000 € in einen Server. Er spart drei '
        'Jahre lang je 5.000 € Betriebskosten. Der Kalkulationszinssatz '
        'beträgt 5 %. Lohnt sich die Investition?',
    table: [
      ['Jahr', 'Einsparung', 'Abzinsungsfaktor', 'Barwert'],
      ['1', '5.000 €', '0,9524', '4.761,90 €'],
      ['2', '5.000 €', '0,9070', '4.535,15 €'],
      ['3', '5.000 €', '0,8638', '4.319,19 €'],
    ],
    points: [
      'Abzinsungsfaktor je Jahr bestimmen: 1 / 1,05^n, also 0,9524, 0,9070 '
          'und 0,8638.',
      'Barwerte berechnen: Einsparung × Abzinsungsfaktor - zusammen '
          '13.616,24 €.',
      'Kapitalwert = Summe der Barwerte - Anschaffungsauszahlung = '
          '13.616,24 € - 12.000 € = 1.616,24 €.',
    ],
    code:
        'Kapitalwert = Σ Einsparung / (1 + i)^n - I₀\n'
        '            = 13.616,24 € - 12.000,00 €',
    ergebnis: 'Kapitalwert 1.616,24 € > 0 - die Investition lohnt sich.',
  ),
  _n(
    'fx-3',
    NuggetKind.formel,
    'Pseudocode mit tiefer Einrückung',
    'Der Algorithmus prüft jede Bestellung und berechnet den Rabatt. Lange '
        'Zeilen dürfen nicht hinter dem Rand verschwinden.',
    code:
        'FÜR JEDE bestellung IN bestellungen\n'
        '    WENN bestellung.summe > 1000 UND kunde.istStammkunde() DANN\n'
        '        rabatt = bestellung.summe * 0,05\n'
        '        protokolliere("Rabatt gewährt für Kundennummer " + kunde.nr)\n'
        '    SONST\n'
        '        rabatt = 0\n'
        '    ENDE WENN\n'
        'ENDE FÜR',
  ),
  _n(
    'fx-4',
    NuggetKind.skizze,
    'Schichten des OSI-Modells',
    'Die Zeichnung zeigt die sieben Schichten von oben nach unten. Jede '
        'Schicht nutzt die Dienste der darunterliegenden.',
    diagram: const StapelDiagramm([
      StapelEbene('7 Anwendungsschicht', 'HTTP, SMTP, DNS'),
      StapelEbene('4 Transportschicht', 'TCP, UDP'),
      StapelEbene('3 Vermittlungsschicht', 'IP, ICMP'),
      StapelEbene('1 Bitübertragungsschicht', 'Kabel, Funk'),
    ]),
    points: [
      'Adressierung über Schichtgrenzen: Portnummer (Schicht 4), '
          'IP-Adresse (Schicht 3), MAC-Adresse (Schicht 2).',
      'Beispieladresse: 2001:0db8:0000:0000:0000:ff00:0042:8329, gekürzt '
          'https://shop.example.com:8443/warenkorb/bestellung',
    ],
  ),
  _n(
    'fx-5',
    NuggetKind.ablauf,
    'Anforderungsermittlung Schritt für Schritt',
    'Die Anforderungsermittlung folgt einem festen Ablauf. Jede Stufe hat ein '
        'eigenes Ergebnis.',
    points: [
      'Stakeholderanalyse: Wer ist betroffen, wer entscheidet, wer nutzt '
          'das System täglich?',
      'Erhebungstechniken auswählen: Interview, Fragebogen, Beobachtung, '
          'Dokumentenanalyse oder Workshop.',
      'Anforderungen dokumentieren und priorisieren (MoSCoW), dann mit dem '
          'Auftraggeber abstimmen.',
      'Qualitätssicherung der Anforderungen: vollständig, eindeutig, '
          'prüfbar, widerspruchsfrei.',
    ],
    merksatz: 'Erst verstehen, dann dokumentieren, dann abstimmen.',
  ),
  _n(
    'fx-6',
    NuggetKind.vergleich,
    'Zwei Spalten',
    'Kurze Tabelle mit zwei Spalten muss ganz normal als Tabelle bleiben.',
    table: [
      ['Begriff', 'Bedeutung'],
      ['FAZ', 'frühester Anfangszeitpunkt'],
      ['SEZ', 'spätester Endzeitpunkt'],
    ],
  ),
];

/// Eine Aufgabe mit langer Situation, langen Optionen und Begründungen.
final kLongQuestion = Question(
  id: 'fx-q1',
  topicId: _topic,
  subtopicId: kFixtureLesson,
  kind: QuestionKind.single,
  difficulty: 2,
  scenario:
      'Die Fahrradmanufaktur Kettenblatt GmbH plant die Einführung eines '
      'Warenwirtschaftssystems. Die Geschäftsführung möchte vorab wissen, '
      'ob sich die Investition lohnt, und bittet dich um eine '
      'Wirtschaftlichkeitsbetrachtung mit Kapitalwertmethode.',
  prompt:
      'Welche Aussage zur Kapitalwertmethode ist richtig, wenn der '
      'Kalkulationszinssatz steigt?',
  choices: const [
    Choice(
      text:
          'Der Kapitalwert sinkt, weil künftige Einzahlungen stärker '
          'abgezinst werden und dadurch weniger wert sind.',
      isCorrect: true,
      rationale:
          'Richtig: Ein höherer Zinssatz verkleinert jeden Abzinsungsfaktor '
          '1 / (1 + i)^n - die Barwerte der Einsparungen sinken.',
    ),
    Choice(
      text: 'Der Kapitalwert steigt, weil Zinsen zusätzliche Erträge bringen.',
      isCorrect: false,
      rationale:
          'Falsch: Der Zinssatz ist hier die geforderte Mindestverzinsung, '
          'kein Ertrag. Er senkt die Barwerte.',
    ),
    Choice(
      text:
          'Die Eintrittswahrscheinlichkeitsberechnung ändert sich, der '
          'Kapitalwert bleibt gleich.',
      isCorrect: false,
      rationale:
          'Falsch: Das ist ein Begriff aus dem Risikomanagement und hat mit '
          'der Kapitalwertmethode nichts zu tun.',
    ),
  ],
  explanation:
      'Kapitalwert = Summe der abgezinsten Rückflüsse minus Anschaffungs'
      'auszahlung. Steigt i, wird 1 / (1 + i)^n kleiner - also sinkt der '
      'Kapitalwert. Beispiel: 5.000 € in drei Jahren sind bei 5 % noch '
      '4.319 € wert, bei 10 % nur noch 3.757 €.',
  tags: const ['Wirtschaftlichkeitsbetrachtung', 'Kapitalwert'],
);
