import '../builders.dart';

/// Kanzlei Albers & Partner: Dauer 17, kritisch A - B - E - F - G,
/// C hat GP 4 / FP 3, D hat GP 1 / FP 1.
const _kanzlei = [
  Activity(id: 'A', name: 'Bestandsaufnahme', duration: 2),
  Activity(
    id: 'B',
    name: 'Hardware liefern lassen',
    duration: 6,
    predecessors: ['A'],
  ),
  Activity(
    id: 'C',
    name: 'Verkabelung prüfen',
    duration: 3,
    predecessors: ['A'],
  ),
  Activity(
    id: 'D',
    name: 'Netz einrichten',
    duration: 4,
    predecessors: ['B', 'C'],
  ),
  Activity(id: 'E', name: 'PCs aufbauen', duration: 5, predecessors: ['B']),
  Activity(
    id: 'F',
    name: 'Daten übertragen',
    duration: 3,
    predecessors: ['D', 'E'],
  ),
  Activity(id: 'G', name: 'Abnahme', duration: 1, predecessors: ['F']),
];

/// Lagerhalle der Elbtal Logistik: Dauer 16, kritisch A - B - D - F - G,
/// C hat GP 2 / FP 0, E hat GP 2 / FP 2.
const _halle = [
  Activity(id: 'A', name: 'Funkausleuchtung', duration: 2),
  Activity(
    id: 'B',
    name: 'Glasfaser verlegen',
    duration: 8,
    predecessors: ['A'],
  ),
  Activity(
    id: 'C',
    name: 'Access Points liefern',
    duration: 5,
    predecessors: ['A'],
  ),
  Activity(
    id: 'D',
    name: 'Netzschrank aufbauen',
    duration: 3,
    predecessors: ['B'],
  ),
  Activity(
    id: 'E',
    name: 'Access Points montieren',
    duration: 4,
    predecessors: ['C'],
  ),
  Activity(
    id: 'F',
    name: 'Anschließen, einrichten',
    duration: 2,
    predecessors: ['D', 'E'],
  ),
  Activity(id: 'G', name: 'Scanner testen', duration: 1, predecessors: ['F']),
];

const _filialeListe = [
  ['Nr.', 'Vorgang', 'Dauer', 'Vorgänger'],
  ['A', 'Filialplanung abschließen', '3', '-'],
  ['B', 'Internetanschluss bereitstellen', '10', 'A'],
  ['C', 'Ladenmöbel liefern und aufbauen', '6', 'A'],
  ['D', 'Netzwerk verkabeln', '4', 'A'],
  ['E', 'Kassen und PCs installieren', '3', 'C, D'],
  ['F', 'Anbindung an die Zentrale einrichten', '2', 'B, D'],
  ['G', 'Gesamttest und Schulung', '2', 'E, F'],
];

const _filialePlan =
    'Netzplan des Kollegen (Tage, Start bei 0)\n'
    'GP = SAZ - FAZ\n'
    '\n'
    'Vg  D  Vorg.  FAZ FEZ  SAZ SEZ  GP\n'
    'A   3  -        0   3    0   3   0\n'
    'B  10  A        3  13    3  13   0\n'
    'C   6  A        3   9    5  12   3\n'
    'D   4  A        3   7    8  12   4\n'
    'E   3  C, D     7  10   12  15   3\n'
    'F   2  B, D    13  15   13  15   0\n'
    'G   2  E, F    15  17   15  17   0';

/// Fallaufgaben (je 25 Punkte) zu Bereich 01, Teil 1 für die Prüfungssimulation.
final List<ExamCase> casesA01Projekte = [
  // ================================================================ Systemhaus
  fall(
    'f-a01p-systemhaus',
    firma: 'systemhaus',
    bereich: 'a01',
    titel: 'Umzug der Kanzlei planen',
    situation:
        'Die Steuerkanzlei Albers & Partner bezieht zum Monatsende ihre neuen Büroräume. Kessler & Brandt erneuert dabei Netzwerk und Arbeitsplätze der 18 Beschäftigten und überträgt Daten und Programme. Die Kanzlei darf höchstens zwei Arbeitstage nicht arbeitsfähig sein; das Budget beträgt 46.000 €. Du unterstützt die Projektleiterin bei der Planung.',
    teile: [
      freitext(
        'f-a01p-systemhaus-a',
        'p-begriff',
        prompt:
            'Die Erneuerung der Kanzlei-IT wird als Projekt geführt. Nenne vier Merkmale, die ein Projekt kennzeichnen.',
        kriterien: [
          krit(
            'Einmaligkeit bzw. Neuartigkeit',
            stichwoerter: ['einmalig', 'neuartig', 'erstmalig', 'einzigartig'],
          ),
          krit(
            'Konkretes Ziel',
            stichwoerter: ['Ziel', 'Zielvorgabe', 'zielgerichtet'],
          ),
          krit(
            'Zeitliche Begrenzung (Anfang und Ende)',
            stichwoerter: [
              'zeitlich begrenzt',
              'zeitliche Begrenzung',
              'befristet',
              'Endtermin',
              'Termin',
            ],
          ),
          krit(
            'Begrenzte Ressourcen (Budget, Personal)',
            stichwoerter: [
              'Budget',
              'Ressourcen',
              'Kosten',
              'finanziell',
              'personell',
            ],
          ),
          krit(
            'Eigene Projektorganisation',
            stichwoerter: [
              'Organisation',
              'Projektteam',
              'Projektleitung',
              'eigenes Team',
            ],
          ),
          krit(
            'Komplexität, Umfang und Risiko',
            stichwoerter: ['komplex', 'Umfang', 'Risiko', 'Unsicherheit'],
          ),
        ],
        loesung:
            'Einmaligkeit bzw. Neuartigkeit, ein konkretes Ziel, zeitliche Begrenzung mit festem Endtermin, begrenzte Ressourcen (Budget, Personal), eine eigene Projektorganisation sowie Komplexität und Risiko.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 4 Punkte. Stichworte genügen; überzählige Nennungen werden nicht gewertet.',
        punkte: 4,
        difficulty: 1,
      ),
      lueckentext(
        'f-a01p-systemhaus-b',
        'p-ziele',
        scenario:
            'Das Projektziel soll SMART formuliert werden: „Bis 30.06. arbeiten alle 18 Beschäftigten an den neuen Arbeitsplätzen; die Kanzlei ist dabei höchstens zwei Arbeitstage nicht arbeitsfähig.“',
        prompt:
            'Ergänze die Bedeutung der vier Buchstaben (deutsche oder englische Begriffe).',
        text:
            'S = spezifisch\n'
            'M = {0}\n'
            'A = {1}\n'
            'R = {2}\n'
            'T = {3}',
        luecken: [
          wort([
            'messbar',
            'measurable',
          ], 'Kennzahlen wie „18 Beschäftigte“ und „zwei Arbeitstage“.'),
          wort([
            'attraktiv',
            'akzeptiert',
            'akzeptabel',
            'aktiv beeinflussbar',
            'anspruchsvoll',
            'ausführbar',
            'erreichbar',
            'achievable',
            'attainable',
            'accepted',
            'attractive',
          ], 'Das Ziel wird von den Beteiligten mitgetragen.'),
          wort([
            'realistisch',
            'realistic',
            'relevant',
            'realisierbar',
            'reasonable',
          ], 'Mit den vorhandenen Mitteln erreichbar.'),
          wort([
            'terminiert',
            'terminierbar',
            'termingebunden',
            'terminlich festgelegt',
            'time-bound',
            'timely',
            'timed',
          ], 'Ein Datum wie „bis 30.06.“.'),
        ],
        explanation:
            'SMART: spezifisch, messbar, attraktiv bzw. akzeptiert, realistisch, terminiert. Auch die englischen Begriffe (measurable, achievable, realistic bzw. relevant, time-bound) werden gewertet, 1 Punkt je Begriff.',
        punkte: 4,
        difficulty: 1,
      ),
      netzplanAufgabe(
        'f-a01p-systemhaus-c',
        'n-puffer',
        scenario:
            'Die Projektleiterin hat die Vorgänge mit Dauer (in Arbeitstagen) und Vorgängern festgelegt. Der Start liegt bei 0. Es gilt: GP = SAZ - FAZ, FP = kleinster FAZ der Nachfolger - FEZ.',
        prompt:
            'Vervollständige den Netzplan: Trage für jeden Vorgang FAZ, FEZ, SAZ, SEZ, Gesamtpuffer und freien Puffer ein.',
        vorgaenge: _kanzlei,
        gefragt: const [
          NodeField.faz,
          NodeField.fez,
          NodeField.saz,
          NodeField.sez,
          NodeField.gp,
          NodeField.fp,
        ],
        explanation:
            'Vorwärts (FAZ/FEZ): A 0/2, B 2/8, C 2/5, D max(8; 5) = 8/12, E 8/13, F max(12; 13) = 13/16, G 16/17.\n'
            'Rückwärts (SAZ/SEZ): G 16/17, F 13/16, D 9/13, E 8/13, B min(9; 8) = 8 → 2/8, C 6/9, A min(2; 6) = 2 → 0/2.\n'
            'GP: C 6 - 2 = 4, D 9 - 8 = 1, alle anderen 0.\n'
            'FP: C: FAZ D 8 - FEZ C 5 = 3, D: FAZ F 13 - FEZ D 12 = 1, alle anderen 0.\n'
            'Projektdauer: 17 Arbeitstage.',
        punkte: 12,
      ),
      lueckentext(
        'f-a01p-systemhaus-d',
        'n-kritisch',
        prompt: 'Gib den kritischen Pfad deines Netzplans an.',
        text: 'Der kritische Pfad lautet {0}.',
        luecken: [
          wahl('A - B - E - F - G', [
            'A - B - D - F - G',
            'A - C - D - F - G',
            'A - B - E - G',
          ]),
        ],
        explanation:
            'Kritisch sind alle Vorgänge mit Gesamtpuffer 0: A, B, E, F und G. Der Weg A - B - E - F - G dauert 2 + 6 + 5 + 3 + 1 = 17 Arbeitstage und ist damit der längste.',
        punkte: 1,
      ),
      freitext(
        'f-a01p-systemhaus-e',
        'n-puffer',
        scenario:
            'Der Elektriker meldet: Die Prüfung der Verkabelung (Vorgang C) dauert 3 Arbeitstage länger als geplant.',
        prompt:
            'Beschreibe die Auswirkung dieser Verzögerung auf das Projektende.',
        kriterien: [
          krit(
            'Das Projektende verschiebt sich nicht (es bleibt bei 17 Arbeitstagen).',
            stichwoerter: [
              'kein Einfluss',
              'keine Auswirkung',
              'keinen Einfluss',
              'verschiebt sich nicht',
              'nicht',
              'unverändert',
            ],
          ),
          krit(
            'Begründung: C hat einen Gesamtpuffer von 4 Tagen (und einen freien Puffer von 3 Tagen); die Verzögerung von 3 Tagen liegt darunter.',
            stichwoerter: ['Puffer', 'Gesamtpuffer', 'GP', '4 Tage'],
          ),
        ],
        loesung:
            'Die Verzögerung hat keinen Einfluss auf das Projektende: Vorgang C hat einen Gesamtpuffer von 4 Tagen, die Verzögerung von 3 Tagen liegt darunter. Weil auch der freie Puffer 3 Tage beträgt, kann sogar der Nachfolger D wie geplant beginnen.',
        explanation:
            '1 Punkt für die Aussage, 1 Punkt für die Begründung über den Puffer. Erst wenn die Verzögerung den Gesamtpuffer übersteigt, verschiebt sich das Projektende.',
        punkte: 2,
      ),
      rechnen(
        'f-a01p-systemhaus-f',
        'n-puffer',
        scenario:
            'Bei der Prüfung fallen defekte Leitungen auf. Vorgang C dauert deshalb nicht 3, sondern 6 Arbeitstage länger als geplant.',
        prompt:
            'Berechne, um wie viele Arbeitstage sich das Projektende jetzt verschiebt.',
        answer: 2,
        unit: 'Tage',
        explanation:
            'Der Gesamtpuffer von C fängt 4 Tage auf.\n'
            'Verschiebung = Verzögerung - GP = 6 - 4 = 2 Arbeitstage.\n'
            'Probe: C endet bei 5 + 6 = 11, D läuft 11 bis 15, F 15 bis 18, G endet bei 19 statt 17.',
        punkte: 2,
      ),
    ],
  ),

  // ==================================================================== Handel
  fall(
    'f-a01p-handel',
    firma: 'handel',
    bereich: 'a01',
    titel: 'Eröffnung der Filiale Göttingen',
    situation:
        'Die Grünwerk Gartenbedarf GmbH eröffnet ihre vierte Filiale in Göttingen. Die IT-Abteilung richtet Internetanschluss, Netzwerk, Kassen und die Anbindung an die Zentrale in Kassel ein. Drei der acht IT-Mitarbeitenden arbeiten dafür drei Monate lang mit etwa der Hälfte ihrer Arbeitszeit im Projekt, dazu je eine Person aus Einkauf und Ladenbau. Ein Kollege hat den Netzplan bereits berechnet; du sollst ihn prüfen.',
    teile: [
      freitext(
        'f-a01p-handel-a',
        'p-organisation',
        scenario:
            'Der Projektleiter aus der IT soll Aufgaben und Termine im Projekt verbindlich vorgeben können. Urlaub und Beurteilung bleiben bei den Abteilungsleitungen.',
        prompt:
            'Entscheide, welche Form der Projektorganisation hier vorliegt, und begründe deine Antwort mit zwei Merkmalen aus der Situation.',
        kriterien: [
          krit('Matrix-Projektorganisation', stichwoerter: ['Matrix']),
          krit(
            'Die Teammitglieder arbeiten nur anteilig (etwa zur Hälfte) im Projekt und bleiben in ihren Abteilungen.',
            punkte: 2,
            stichwoerter: [
              'anteilig',
              'Hälfte',
              '50 %',
              'bleiben in der Abteilung',
              'bleiben in der Linie',
              'Teilzeit',
            ],
          ),
          krit(
            'Die Weisungsbefugnis ist geteilt: fachlich beim Projektleiter, disziplinarisch (Urlaub, Beurteilung) bei den Abteilungsleitungen.',
            punkte: 2,
            stichwoerter: [
              'fachlich',
              'disziplinarisch',
              'Weisungsbefugnis',
              'zwei Vorgesetzte',
              'geteilt',
            ],
          ),
        ],
        loesung:
            'Es liegt eine Matrix-Projektorganisation vor. Die Teammitglieder arbeiten nur etwa zur Hälfte im Projekt und bleiben in ihren Abteilungen. Die Weisungsbefugnis ist geteilt: Der Projektleiter gibt fachlich Aufgaben und Termine vor, Urlaub und Beurteilung (disziplinarisch) bleiben bei den Abteilungsleitungen.',
        explanation:
            '1 Punkt für die Organisationsform, je Merkmal 2 Punkte. In der reinen Projektorganisation wäre das Team ganz herausgelöst, in der Stabs-/Einflussorganisation hätte der Projektleiter keine Weisungsbefugnis.',
        punkte: 5,
      ),
      freitext(
        'f-a01p-handel-b',
        'p-stakeholder',
        prompt:
            'Nenne drei Stakeholder der Filialeröffnung und beschreibe jeweils kurz ihren Einfluss auf das Projekt.',
        kriterien: [
          krit(
            'Geschäftsführung: gibt Budget und Eröffnungstermin vor und entscheidet über Änderungen.',
            stichwoerter: [
              'Geschäftsführung',
              'Geschäftsleitung',
              'Auftraggeber',
            ],
          ),
          krit(
            'Filialleitung und Beschäftigte der Filiale: müssen mit Kassen und Systemen arbeiten. Ihre Akzeptanz und Schulung entscheiden über den Start.',
            stichwoerter: [
              'Filialleitung',
              'Mitarbeiter',
              'Mitarbeitende',
              'Beschäftigte',
              'Verkäufer',
              'Anwender',
            ],
          ),
          krit(
            'Internetanbieter und Lieferanten (Möbel, Kassen): Ihre Liefertermine bestimmen den Zeitplan.',
            stichwoerter: [
              'Provider',
              'Internetanbieter',
              'Lieferant',
              'Ladenbauer',
              'Dienstleister',
            ],
          ),
          krit(
            'Vermieter des Ladenlokals: muss baulichen Änderungen wie der Verkabelung zustimmen.',
            stichwoerter: ['Vermieter', 'Eigentümer', 'Hausverwaltung'],
          ),
          krit(
            'Fachabteilungen der Zentrale (Einkauf, Ladenbau, Buchhaltung): stellen Personal und Anforderungen.',
            stichwoerter: [
              'Einkauf',
              'Ladenbau',
              'Buchhaltung',
              'Fachabteilung',
              'Zentrale',
            ],
          ),
          krit(
            'Kundinnen und Kunden: erwarten eine pünktliche Eröffnung und funktionierende Kassen.',
            stichwoerter: ['Kunden', 'Kundinnen', 'Käufer'],
          ),
        ],
        loesung:
            'Geschäftsführung: gibt Budget und Eröffnungstermin vor. Filialleitung und Beschäftigte: müssen mit den Kassen arbeiten, ihre Akzeptanz und Schulung entscheiden über einen reibungslosen Start. Internetanbieter und Lieferanten: Ihre Liefertermine bestimmen den Zeitplan.',
        explanation:
            'Je Stakeholder mit Einfluss 1 Punkt, höchstens 3 Punkte. Andere sinnvolle Gruppen (Vermieter, Fachabteilungen, Kunden) zählen ebenso.',
        punkte: 3,
      ),
      markieren(
        'f-a01p-handel-c',
        'n-rueckwaerts',
        scenario:
            'Vorgangsliste der Filialeröffnung (Dauer in Arbeitstagen) und der Netzplan des Kollegen. In drei Vorgängen stehen falsche Werte.',
        table: _filialeListe,
        code: _filialePlan,
        prompt:
            'Rechne den Netzplan nach und markiere die drei Vorgänge mit fehlerhaften Werten.',
        zeilen: [
          nein(
            'Vorgang A',
            'Startvorgang: 0/3, rückwärts 0/3, GP 0, also richtig.',
          ),
          nein('Vorgang B', '3/13, rückwärts 3/13, GP 0, also richtig.'),
          ja(
            'Vorgang C',
            'SEZ = SAZ von E = 12 stimmt, aber SAZ = 12 - 6 = 6, nicht 5.',
          ),
          ja('Vorgang D', 'GP = SAZ - FAZ = 8 - 3 = 5, nicht 4.'),
          ja(
            'Vorgang E',
            'FAZ = max(FEZ C 9; FEZ D 7) = 9, nicht 7; FEZ = 9 + 3 = 12.',
          ),
          nein(
            'Vorgang F',
            'FAZ = max(FEZ B 13; FEZ D 7) = 13, FEZ 15, GP 0, also richtig.',
          ),
          nein(
            'Vorgang G',
            'FAZ = max(FEZ E 12; FEZ F 15) = 15, FEZ 17, also richtig.',
          ),
        ],
        explanation:
            'Fehlerhaft sind C (SAZ), D (GP) und E (FAZ und FEZ). Bei E wurde der kleinere statt des größeren FEZ der Vorgänger übernommen. Je gefundenem Vorgang 1 Punkt.',
        punkte: 3,
        difficulty: 3,
      ),
      lueckentext(
        'f-a01p-handel-d',
        'n-rueckwaerts',
        table: _filialeListe,
        code: _filialePlan,
        prompt: 'Trage die Werte ein, die sich bei richtiger Rechnung ergeben.',
        text:
            'Vorgang C: SAZ = {0}\n'
            'Vorgang D: GP = {1}\n'
            'Vorgang E: FAZ = {2}, FEZ = {3}\n'
            'Vorgang F: SAZ = {4}',
        luecken: [
          zahl(6, rationale: 'SEZ 12 - Dauer 6 = 6'),
          zahl(5, rationale: 'SAZ 8 - FAZ 3 = 5'),
          zahl(9, rationale: 'max(FEZ C 9; FEZ D 7) = 9'),
          zahl(12, rationale: '9 + 3 = 12'),
          zahl(
            13,
            rationale: 'SEZ 15 - Dauer 2 = 13: Der Wert des Kollegen stimmt.',
          ),
        ],
        explanation:
            'Vorwärts: A 0/3, B 3/13, C 3/9, D 3/7, E max(9; 7) = 9/12, F max(13; 7) = 13/15, G max(12; 15) = 15/17.\n'
            'Rückwärts: G 15/17, E 12/15, F 13/15, B 3/13, C 6/12, D: SEZ = min(SAZ E 12; SAZ F 13) = 12, SAZ 8.\n'
            'GP: C 3, D 5, E 3, alle anderen 0.',
        punkte: 4,
        difficulty: 3,
      ),
      lueckentext(
        'f-a01p-handel-e',
        'n-kritisch',
        table: _filialeListe,
        prompt: 'Werte den berichtigten Netzplan aus.',
        text:
            'Die Projektdauer beträgt {0} Arbeitstage. Der kritische Pfad lautet {1}. Den größten Gesamtpuffer hat Vorgang {2}.',
        luecken: [
          zahl(17),
          wahl('A - B - F - G', [
            'A - C - E - G',
            'A - D - E - G',
            'A - D - F - G',
          ], '3 + 10 + 2 + 2 = 17'),
          wahl('D', [
            'B',
            'C',
            'E',
          ], 'D hat 5 Tage Gesamtpuffer, C und E je 3.'),
        ],
        explanation:
            'Der längste Weg ist A - B - F - G mit 3 + 10 + 2 + 2 = 17 Arbeitstagen; seine Vorgänge haben den Gesamtpuffer 0. A - C - E - G dauert 14, A - D - E - G 12 und A - D - F - G 11 Tage. D hat mit 5 Tagen den größten Gesamtpuffer.',
        punkte: 3,
      ),
      freitext(
        'f-a01p-handel-f',
        'n-puffer',
        scenario:
            'Der Ladenbauer teilt mit, dass die Ladenmöbel (Vorgang C) 4 Arbeitstage später fertig aufgebaut sind als geplant.',
        prompt:
            'Beschreibe die Auswirkung auf das Projektende und begründe sie.',
        kriterien: [
          krit(
            'Das Projektende verschiebt sich um 1 Arbeitstag (von 17 auf 18).',
            stichwoerter: [
              '1 Tag',
              'einen Tag',
              'ein Tag',
              '1 Arbeitstag',
              'einen Arbeitstag',
              '18',
            ],
          ),
          krit(
            'Begründung: C hat einen Gesamtpuffer von 3 Tagen; die Verzögerung von 4 Tagen übersteigt ihn um 1 Tag (4 - 3 = 1).',
            punkte: 2,
            stichwoerter: ['Gesamtpuffer', 'Puffer', 'GP', '3 Tage'],
          ),
        ],
        loesung:
            'Das Projektende verschiebt sich um einen Arbeitstag auf 18. Vorgang C hat einen Gesamtpuffer von 3 Tagen; die Verzögerung von 4 Tagen übersteigt ihn um 4 - 3 = 1 Tag. Der Weg A - C - E - G wird damit zum kritischen Pfad.',
        explanation:
            '1 Punkt für die Verschiebung um 1 Tag, 2 Punkte für die Begründung über den Gesamtpuffer. Probe: C endet bei 13, E läuft 13 bis 16, G endet bei 18.',
        punkte: 3,
      ),
      rechnen(
        'f-a01p-handel-g',
        'n-kritisch',
        scenario:
            'Jeder Arbeitstag, den die Filiale später eröffnet, kostet Grünwerk 2.400 € Deckungsbeitrag. Der Ladenbauer bietet an, den um 4 Tage verspäteten Möbelaufbau (Vorgang C, Gesamtpuffer 3 Tage) mit einem zweiten Montageteam um 2 Tage zu verkürzen. Der Aufpreis beträgt 1.900 €.',
        prompt:
            'Berechne den finanziellen Vorteil für Grünwerk, wenn das Angebot angenommen wird.',
        answer: 500,
        unit: '€',
        explanation:
            'Ohne Angebot: Verschiebung = 4 - 3 = 1 Tag → 1 × 2.400 € = 2.400 € entgangener Deckungsbeitrag.\n'
            'Mit Angebot: Verzögerung nur noch 4 - 2 = 2 Tage ≤ Gesamtpuffer 3 → keine Verschiebung, Kosten 1.900 €.\n'
            'Vorteil: 2.400 € - 1.900 € = 500 €.',
        punkte: 4,
        difficulty: 3,
      ),
    ],
  ),

  // =================================================================== Agentur
  fall(
    'f-a01p-agentur',
    firma: 'agentur',
    bereich: 'a01',
    titel: 'Kundenportal zum Ticketsystem entwickeln',
    situation:
        'Zum neuen Ticketsystem entwickelt die Pixelhafen Medien GmbH selbst ein Kundenportal, in dem Kunden Anfragen stellen und verfolgen. Welche Funktionen die Kunden wirklich brauchen, ist erst grob bekannt. Drei Pilotkunden haben zugesagt, alle zwei Wochen Rückmeldung zu geben; erste Funktionen sollen möglichst früh nutzbar sein. Das Team besteht aus vier Entwicklerinnen und Entwicklern, das Monatsbudget steht fest.',
    teile: [
      freitext(
        'f-a01p-agentur-a',
        'v-auswahl',
        prompt:
            'Entscheide dich für das Wasserfallmodell oder für Scrum und begründe deine Entscheidung mit zwei Argumenten aus der Situation.',
        kriterien: [
          krit('Vorgehensmodell: Scrum', stichwoerter: ['Scrum', 'agil']),
          krit(
            'Die Anforderungen sind erst grob bekannt und werden sich ändern; ein vollständiges Pflichtenheft ist vorab nicht möglich.',
            punkte: 2,
            stichwoerter: [
              'unklar',
              'grob',
              'ändern',
              'Anforderungen',
              'nicht fest',
            ],
          ),
          krit(
            'Die Pilotkunden geben alle zwei Wochen Rückmeldung. Das passt zu Sprints mit Sprint Review.',
            punkte: 2,
            stichwoerter: [
              'Rückmeldung',
              'Feedback',
              'Pilotkunden',
              'Sprint Review',
              'alle zwei Wochen',
            ],
          ),
          krit(
            'Erste Funktionen sollen früh nutzbar sein: Jeder Sprint liefert ein nutzbares Increment.',
            punkte: 2,
            stichwoerter: [
              'früh',
              'Increment',
              'Inkrement',
              'Teilergebnis',
              'nutzbar',
            ],
          ),
          krit(
            'Festes Monatsbudget bei offenem Umfang: In Scrum stehen Zeit und Kosten fest, der Umfang ergibt sich.',
            punkte: 2,
            stichwoerter: [
              'Budget',
              'Umfang offen',
              'Umfang variabel',
              'Kosten fest',
            ],
          ),
        ],
        loesung:
            'Scrum. Die Anforderungen sind erst grob bekannt und werden sich mit den Rückmeldungen ändern. Ein vollständiges Pflichtenheft ließe sich nicht schreiben. Die Pilotkunden können alle zwei Wochen Rückmeldung geben, was zu zweiwöchigen Sprints mit Sprint Review passt. Zudem entsteht nach jedem Sprint ein nutzbares Increment.',
        explanation:
            '1 Punkt für das Modell, je Argument 2 Punkte, höchstens 5 Punkte. Gewertet werden nur Argumente aus der Situation.',
        punkte: 5,
      ),
      tabelle(
        'f-a01p-agentur-b',
        's-events',
        scenario:
            'Das Team arbeitet mit einem Freelancer aus Dublin zusammen und hält seine Regeln deshalb auf Englisch fest:',
        code:
            'Working agreement - portal team\n'
            '\n'
            '1 Every morning at 9:15 the developers meet\n'
            '  for 15 minutes and plan the next 24 hours.\n'
            '2 On the last Friday we show the increment to\n'
            '  the pilot customers and collect feedback.\n'
            '3 After that, the team alone discusses how to\n'
            '  improve its collaboration.\n'
            '4 On the first Monday we agree on the sprint\n'
            '  goal and select the backlog items.',
        prompt: 'Ordne jedem Absatz das beschriebene Scrum-Event zu.',
        zeilen: [
          ['Absatz', 'Scrum-Event'],
          [
            '1',
            wahl('Daily Scrum', [
              'Sprint Planning',
              'Sprint Review',
              'Sprint Retrospective',
            ]),
          ],
          [
            '2',
            wahl('Sprint Review', [
              'Sprint Planning',
              'Daily Scrum',
              'Sprint Retrospective',
            ]),
          ],
          [
            '3',
            wahl('Sprint Retrospective', [
              'Sprint Planning',
              'Daily Scrum',
              'Sprint Review',
            ]),
          ],
          [
            '4',
            wahl('Sprint Planning', [
              'Daily Scrum',
              'Sprint Review',
              'Sprint Retrospective',
            ]),
          ],
        ],
        explanation:
            'Absatz 1: tägliche Abstimmung der Developers über die nächsten 24 Stunden: Daily Scrum. Absatz 2: Increment zeigen, Feedback der Kunden: Sprint Review. Absatz 3: Zusammenarbeit verbessern, nur das Team: Retrospektive. Absatz 4: Sprintziel (sprint goal) und Auswahl der Einträge: Sprint Planning.',
        punkte: 4,
      ),
      tabelle(
        'f-a01p-agentur-c',
        's-rollen',
        prompt:
            'Wer ist im Scrum Team des Kundenportals jeweils verantwortlich?',
        zeilen: [
          ['Aufgabe', 'Verantwortlich'],
          [
            'Wünsche der Pilotkunden nach ihrem Wert ordnen',
            wahl('Product Owner', ['Scrum Master', 'Developers']),
          ],
          [
            'Den Plan für den Sprint erstellen und die Einträge schätzen',
            wahl('Developers', ['Product Owner', 'Scrum Master']),
          ],
          [
            'Dafür sorgen, dass das Hindernis „fehlender Testserver“ beseitigt wird',
            wahl('Scrum Master', ['Product Owner', 'Developers']),
          ],
          [
            'Den Sprint abbrechen, wenn das Sprintziel hinfällig ist',
            wahl('Product Owner', ['Scrum Master', 'Developers']),
          ],
        ],
        explanation:
            'Der Product Owner ordnet das Product Backlog nach Wert und darf als Einziger einen Sprint abbrechen. Die Developers planen und schätzen ihre Arbeit selbst. Der Scrum Master sorgt dafür, dass Hindernisse beseitigt werden.',
        punkte: 4,
      ),
      rechnen(
        'f-a01p-agentur-d',
        's-stories',
        scenario:
            'In den ersten drei Sprints hat das Team 18, 22 und 20 Story Points fertiggestellt. Im Product Backlog stehen für die erste Version noch 96 Story Points.',
        prompt:
            'Berechne, wie viele Sprints das Team voraussichtlich noch braucht. Runde auf ganze Sprints auf.',
        answer: 5,
        unit: 'Sprints',
        explanation:
            'Velocity = (18 + 22 + 20) / 3 = 60 / 3 = 20 Story Points je Sprint.\n'
            'Restliche Sprints = 96 / 20 = 4,8.\n'
            'Aufgerundet: 5 Sprints, denn auch der letzte, nicht ganz gefüllte Sprint wird gebraucht.',
        punkte: 3,
      ),
      markieren(
        'f-a01p-agentur-e',
        's-artefakte',
        scenario:
            'Die Definition of Done des Teams verlangt: Code-Review erfolgt, automatische Tests grün, Hilfetext im Portal ergänzt. Stand am letzten Tag des Sprints:',
        table: [
          ['Story', 'Review', 'Tests', 'Hilfetext'],
          ['Anfrage stellen', 'ja', 'grün', 'ja'],
          ['Status ansehen', 'ja', 'grün', 'nein'],
          ['Datei anhängen', 'ja', '1 rot', 'ja'],
          ['Passwort ändern', 'ja', 'grün', 'ja'],
          ['Anfrage bewerten', 'nein', 'grün', 'ja'],
        ],
        prompt:
            'Markiere alle Stories, die zum Increment gehören und den Pilotkunden als fertig gezeigt werden.',
        zeilen: [
          ja('Anfrage stellen', 'Review, Tests und Hilfetext sind erfüllt.'),
          nein('Status ansehen', 'Der Hilfetext fehlt, also nicht „done“.'),
          nein('Datei anhängen', 'Ein Test schlägt fehl.'),
          ja('Passwort ändern', 'Alle drei Punkte sind erfüllt.'),
          nein('Anfrage bewerten', 'Das Code-Review fehlt.'),
        ],
        explanation:
            'Zum Increment gehört nur, was die Definition of Done vollständig erfüllt. Die übrigen Stories gehen zurück ins Product Backlog und zählen nicht zur Velocity.',
        punkte: 3,
      ),
      freitext(
        'f-a01p-agentur-f',
        's-stories',
        scenario:
            'Ein Pilotkunde sagt im Sprint Review: „Unsere Sachbearbeiter wollen im Portal sehen, wie weit ihre Anfrage ist. Dann müssen sie nicht mehr bei euch anrufen.“',
        prompt: 'Formuliere daraus eine User Story nach dem üblichen Muster.',
        kriterien: [
          krit(
            'Rolle: „Als Sachbearbeiter (Kunde) ...“',
            stichwoerter: [
              'als Sachbearbeiter',
              'als Kunde',
              'als Sachbearbeiterin',
              'als Nutzer',
            ],
          ),
          krit(
            'Ziel: „... möchte ich den Bearbeitungsstand meiner Anfrage im Portal sehen ...“',
            stichwoerter: [
              'möchte ich',
              'will ich',
              'Status',
              'Bearbeitungsstand',
            ],
          ),
          krit(
            'Nutzen: „... damit ich nicht mehr anrufen muss.“',
            stichwoerter: ['damit', 'um zu', 'nicht anrufen', 'anrufen'],
          ),
        ],
        loesung:
            'Als Sachbearbeiter eines Kunden möchte ich im Portal den Bearbeitungsstand meiner Anfrage sehen, damit ich nicht mehr bei der Agentur anrufen muss.',
        explanation:
            'Je Bestandteil 1 Punkt: Rolle, Ziel, Nutzen. Muster: „Als <Rolle> möchte ich <Ziel>, damit <Nutzen>“.',
        punkte: 3,
      ),
      freitext(
        'f-a01p-agentur-g',
        's-events',
        prompt:
            'Nenne drei Vorteile, die kurze Sprints mit einem Sprint Review für die Agentur und ihre Pilotkunden haben.',
        kriterien: [
          krit(
            'Frühe Rückmeldung: Fehlentwicklungen werden nach spätestens einem Sprint erkannt.',
            stichwoerter: [
              'Rückmeldung',
              'Feedback',
              'Fehlentwicklung',
              'früh erkannt',
            ],
          ),
          krit(
            'Früh nutzbare Teilergebnisse: Nach jedem Sprint liegt ein Increment vor.',
            stichwoerter: [
              'Increment',
              'Inkrement',
              'Teilergebnis',
              'früh nutzbar',
              'nutzbar',
            ],
          ),
          krit(
            'Änderungswünsche lassen sich im nächsten Sprint berücksichtigen.',
            stichwoerter: [
              'Änderungen',
              'Änderungswünsche',
              'flexibel',
              'anpassen',
              'neu priorisieren',
            ],
          ),
          krit(
            'Der Fortschritt ist für alle sichtbar (Transparenz).',
            stichwoerter: [
              'Transparenz',
              'transparent',
              'Fortschritt',
              'sichtbar',
            ],
          ),
          krit(
            'Geringeres Risiko, am Bedarf vorbeizuentwickeln; höhere Zufriedenheit der Kunden.',
            stichwoerter: ['Risiko', 'Zufriedenheit', 'Akzeptanz', 'Bedarf'],
          ),
        ],
        loesung:
            'Die Pilotkunden geben früh Rückmeldung, sodass Fehlentwicklungen nach spätestens einem Sprint auffallen. Nach jedem Sprint liegt ein nutzbares Teilergebnis vor. Änderungswünsche können schon im nächsten Sprint berücksichtigt werden; außerdem ist der Fortschritt für alle sichtbar.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. „Scrum ist schneller“ ist kein gültiger Vorteil. Scrum ist flexibler, nicht automatisch schneller.',
        punkte: 3,
      ),
    ],
  ),

  // ================================================================== Logistik
  fall(
    'f-a01p-logistik',
    firma: 'logistik',
    bereich: 'a01',
    titel: 'Neue Lagerhalle ans Netz anbinden',
    situation:
        'Die Elbtal Logistik AG nimmt eine neue Lagerhalle in Betrieb. Die IT-Abteilung bindet die Halle per Glasfaser an und stattet sie mit WLAN für die mobilen Handscanner aus. Der Vorstand hat das Budget freigegeben und verlangt jede Woche einen Statusbericht. Weil die Scanner die Zahl der Buchungen je Person aufzeichnen, ist auch der Betriebsrat zu beteiligen. Du arbeitest im Projektteam mit.',
    teile: [
      freitext(
        'f-a01p-logistik-a',
        'p-ziele',
        scenario:
            'Im Entwurf des Projektauftrags steht als Ziel: „Die neue Halle soll möglichst schnell ein gutes WLAN für die Scanner bekommen.“',
        prompt:
            'Erläutere zwei Mängel dieser Zielformulierung anhand der SMART-Kriterien.',
        kriterien: [
          krit(
            'Nicht messbar: „gutes WLAN“ ist keine Kennzahl; es fehlt ein prüfbarer Wert, z. B. Signalstärke von mindestens -67 dBm an allen Regalplätzen.',
            punkte: 2,
            stichwoerter: [
              'messbar',
              'Kennzahl',
              'Messgröße',
              'messen',
              'nicht prüfbar',
            ],
          ),
          krit(
            'Nicht terminiert: „möglichst schnell“ ist kein Datum; es fehlt ein Endtermin.',
            punkte: 2,
            stichwoerter: [
              'terminiert',
              'Termin',
              'Datum',
              'Zeitpunkt',
              'Frist',
              'möglichst schnell',
            ],
          ),
          krit(
            'Nicht spezifisch: Es bleibt offen, was genau geliefert wird (Glasfaseranbindung, Zahl der Access Points, Zahl der Scanner).',
            punkte: 2,
            stichwoerter: [
              'spezifisch',
              'ungenau',
              'unklar',
              'konkret',
              'eindeutig',
            ],
          ),
        ],
        loesung:
            'Das Ziel ist nicht messbar: „Gutes WLAN“ lässt sich nicht prüfen, es fehlt eine Kennzahl wie eine Mindest-Signalstärke an allen Regalplätzen. Es ist nicht terminiert: „Möglichst schnell“ nennt kein Datum. SMART wäre etwa: „Bis 30.09. ist die Halle per Glasfaser angebunden; alle 40 Handscanner buchen an jedem Regalplatz ohne Verbindungsabbruch.“',
        explanation:
            'Je Mangel 2 Punkte (Kriterium nennen und am Beispiel begründen), höchstens 4 Punkte.',
        punkte: 4,
      ),
      netzplanAufgabe(
        'f-a01p-logistik-b',
        'n-puffer',
        scenario:
            'Für die Anbindung der Halle liegt die Vorgangsliste mit Dauer (in Arbeitstagen) und Vorgängern vor. Der Start liegt bei 0. Es gilt: GP = SAZ - FAZ, FP = kleinster FAZ der Nachfolger - FEZ.',
        prompt:
            'Vervollständige den Netzplan: Trage für jeden Vorgang FAZ, FEZ, SAZ, SEZ, Gesamtpuffer und freien Puffer ein.',
        vorgaenge: _halle,
        gefragt: const [
          NodeField.faz,
          NodeField.fez,
          NodeField.saz,
          NodeField.sez,
          NodeField.gp,
          NodeField.fp,
        ],
        explanation:
            'Vorwärts (FAZ/FEZ): A 0/2, B 2/10, C 2/7, D 10/13, E 7/11, F max(13; 11) = 13/15, G 15/16.\n'
            'Rückwärts (SAZ/SEZ): G 15/16, F 13/15, D 10/13, E 9/13, B 2/10, C 4/9, A min(2; 4) = 2 → 0/2.\n'
            'GP: C 4 - 2 = 2, E 9 - 7 = 2, alle anderen 0.\n'
            'FP: C: FAZ E 7 - FEZ C 7 = 0, E: FAZ F 13 - FEZ E 11 = 2, alle anderen 0.\n'
            'Projektdauer: 16 Arbeitstage.',
        punkte: 9,
      ),
      lueckentext(
        'f-a01p-logistik-c',
        'n-kritisch',
        prompt: 'Werte deinen Netzplan aus.',
        text:
            'Die Halle ist frühestens nach {0} Arbeitstagen angebunden. Der kritische Pfad lautet {1}.',
        luecken: [
          zahl(16),
          wahl('A - B - D - F - G', [
            'A - C - E - F - G',
            'A - B - D - G',
            'A - C - D - F - G',
          ], '2 + 8 + 3 + 2 + 1 = 16'),
        ],
        explanation:
            'Kritisch sind die Vorgänge mit Gesamtpuffer 0: A, B, D, F und G. Der Weg A - B - D - F - G dauert 2 + 8 + 3 + 2 + 1 = 16 Arbeitstage; A - C - E - F - G nur 14.',
        punkte: 2,
      ),
      freitext(
        'f-a01p-logistik-d',
        'n-puffer',
        scenario:
            'Der Lieferant teilt mit, dass die Access Points (Vorgang C) 5 Arbeitstage später eintreffen.',
        prompt:
            'Beschreibe die Auswirkung auf das Projektende und begründe sie.',
        kriterien: [
          krit(
            'Das Projektende verschiebt sich um 3 Arbeitstage (von 16 auf 19).',
            stichwoerter: ['3 Tage', 'drei Tage', '3 Arbeitstage', '19'],
          ),
          krit(
            'Begründung: C hat nur 2 Tage Gesamtpuffer; die Verzögerung von 5 Tagen übersteigt ihn um 5 - 2 = 3 Tage.',
            stichwoerter: ['Gesamtpuffer', 'Puffer', 'GP', '2 Tage'],
          ),
        ],
        loesung:
            'Das Projektende verschiebt sich um 3 Arbeitstage auf 19. Vorgang C hat einen Gesamtpuffer von 2 Tagen; die Verzögerung von 5 Tagen übersteigt ihn um 5 - 2 = 3 Tage. Weil C keinen freien Puffer hat, beginnt auch die Montage (E) entsprechend später.',
        explanation:
            '1 Punkt für die Verschiebung um 3 Tage, 1 Punkt für die Begründung über den Gesamtpuffer. Probe: C endet bei 12, E läuft 12 bis 16, F 16 bis 18, G endet bei 19.',
        punkte: 2,
      ),
      tabelle(
        'f-a01p-logistik-e',
        'p-stakeholder',
        scenario:
            'Für die Stakeholderanalyse beschreibt die Projektleitung vier Gruppen:\n'
            '- Vorstand: hat das Budget freigegeben und verlangt jede Woche einen Statusbericht\n'
            '- Betriebsrat: muss zustimmen, hat sich bisher aber nicht mit dem Projekt befasst\n'
            '- Lagerpersonal der drei Schichten: arbeitet täglich mit den Scannern, entscheidet aber nichts\n'
            '- Pächter der Kantine: von der neuen Halle nicht betroffen',
        prompt: 'Wähle für jede Gruppe die passende Strategie.',
        zeilen: [
          ['Stakeholder', 'Strategie'],
          [
            'Vorstand',
            wahl('eng einbinden', [
              'zufriedenstellen',
              'informieren',
              'beobachten',
            ], 'Hoher Einfluss, hohes Interesse.'),
          ],
          [
            'Betriebsrat',
            wahl('zufriedenstellen', [
              'eng einbinden',
              'informieren',
              'beobachten',
            ], 'Hoher Einfluss, bisher geringes Interesse.'),
          ],
          [
            'Lagerpersonal',
            wahl('informieren', [
              'eng einbinden',
              'zufriedenstellen',
              'beobachten',
            ], 'Geringer Einfluss, hohes Interesse.'),
          ],
          [
            'Pächter der Kantine',
            wahl('beobachten', [
              'eng einbinden',
              'zufriedenstellen',
              'informieren',
            ], 'Geringer Einfluss, geringes Interesse.'),
          ],
        ],
        explanation:
            'Stakeholder-Matrix: hoher Einfluss und hohes Interesse → eng einbinden; hoher Einfluss, geringes Interesse → zufriedenstellen; geringer Einfluss, hohes Interesse → informieren; beides gering → beobachten.',
        punkte: 4,
      ),
      tabelle(
        'f-a01p-logistik-f',
        'v-phasen',
        prompt:
            'Ordne jede Tätigkeit des Projekts der Projektphase nach DIN 69901 zu.',
        zeilen: [
          ['Tätigkeit', 'Phase'],
          [
            'Der Vorstand unterschreibt den Projektauftrag',
            wahl('Initialisierung', ['Definition', 'Planung', 'Steuerung']),
          ],
          [
            'Vorgangsliste und Netzplan erstellen',
            wahl('Planung', ['Definition', 'Steuerung', 'Abschluss']),
          ],
          [
            'Wöchentlicher Soll-Ist-Vergleich im Statusbericht',
            wahl('Steuerung', ['Planung', 'Definition', 'Abschluss']),
          ],
          [
            'Abnahme der Halle und Lessons Learned',
            wahl('Abschluss', ['Steuerung', 'Planung', 'Initialisierung']),
          ],
        ],
        explanation:
            'Initialisierung: Projektauftrag. Definition: Ziele und Anforderungen. Planung: Struktur-, Ablauf- und Terminplan, hier der Netzplan. Steuerung: Soll-Ist-Vergleich und Statusberichte. Abschluss: Abnahme, Abschlussbericht, Lessons Learned.',
        punkte: 4,
        difficulty: 1,
      ),
    ],
  ),
];
