import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben im IHK-Stil zu Bereich 01, Teil 2: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA01Planung = [
  // ========================================================= Projektstrukturplan
  freitext(
    'i1-tp-1',
    't-psp',
    scenario:
        'Die Nordlicht IT GmbH richtet für eine Grundschule ein WLAN in 14 Klassenräumen ein. Bevor Termine festgelegt werden, erstellt die Projektleiterin einen Projektstrukturplan (PSP).',
    prompt:
        'Erläutere zwei Gründe, warum vor der Terminplanung ein Projektstrukturplan erstellt wird. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Vollständigkeit: Alle Aufgaben des Projekts werden erfasst, nichts wird vergessen.',
        punkte: 2,
        stichwoerter: [
          'vollständig',
          'vergessen',
          'alle Aufgaben',
          'Überblick',
          'gesamten Umfang',
        ],
      ),
      krit(
        'Grundlage der Planung: Aufwand, Kosten und Termine werden je Arbeitspaket geschätzt.',
        punkte: 2,
        stichwoerter: [
          'schätzen',
          'Aufwand',
          'Kosten',
          'Grundlage',
          'Terminplanung',
        ],
      ),
      krit(
        'Verantwortung: Jedes Arbeitspaket lässt sich genau einer Person zuweisen.',
        punkte: 2,
        stichwoerter: ['verantwortlich', 'zuständig', 'zuweisen', 'Zuordnung'],
      ),
      krit(
        'Überschaubarkeit: Das Projekt wird in kleine, plan- und kontrollierbare Einheiten zerlegt.',
        punkte: 2,
        stichwoerter: [
          'überschaubar',
          'zerlegen',
          'gliedern',
          'Teilaufgaben',
          'kontrollierbar',
        ],
      ),
    ],
    loesung:
        'Der PSP zerlegt das Projekt vollständig in Teilaufgaben und Arbeitspakete, sodass keine Aufgabe vergessen wird. Außerdem ist er die Grundlage für alles Weitere: Aufwand, Kosten und Termine lassen sich erst je Arbeitspaket verlässlich schätzen.',
    explanation:
        'Je Grund 2 Punkte (Aussage plus kurze Ausführung), höchstens 4 Punkte. Der PSP beantwortet die Frage, WAS zu tun ist. Erst danach folgen Dauer, Reihenfolge und Termine.',
  ),
  tabelle(
    'i1-tp-2',
    't-psp',
    scenario:
        'Für den Umzug eines Serverraums wurde ein Projektstrukturplan mit numerischem Code angelegt. Die Elemente stehen in der Reihenfolge, in der sie im PSP unter ihrer Teilaufgabe hängen.',
    prompt:
        'Ergänze die fehlenden PSP-Codes und gib an, ob es sich um eine Teilaufgabe oder ein Arbeitspaket handelt. (6 P.)',
    punkte: 6,
    zeilen: [
      ['PSP-Code', 'Element', 'Art'],
      [
        '1',
        'Planung',
        wahl('Teilaufgabe', ['Arbeitspaket', 'Meilenstein']),
      ],
      ['1.1', 'Ist-Aufnahme durchführen', 'Arbeitspaket'],
      [
        wort(['1.2', '1,2']),
        'Umzugskonzept erstellen',
        'Arbeitspaket',
      ],
      ['2', 'Hardware', 'Teilaufgabe'],
      [
        wort(['2.1', '2,1']),
        'Rack aufbauen',
        wahl('Arbeitspaket', ['Teilaufgabe', 'Meilenstein']),
      ],
      [
        wort(['2.2', '2,2']),
        'Server einbauen',
        'Arbeitspaket',
      ],
      ['3', 'Inbetriebnahme', 'Teilaufgabe'],
      [
        wort(['3.1', '3,1']),
        'Funktionstest durchführen',
        'Arbeitspaket',
      ],
    ],
    explanation:
        'Beim numerischen Code steht je Ebene eine Zahl: Das zweite Element unter Teilaufgabe 1 heißt 1.2, die Elemente unter 2 heißen 2.1 und 2.2, das erste unter 3 heißt 3.1. Elemente, die weiter zerlegt werden, sind Teilaufgaben; die unterste Ebene bilden die Arbeitspakete.',
  ),
  markieren(
    'i1-tp-3',
    't-psp',
    scenario:
        'Ein Auszubildender hat für den Rollout von 40 Notebooks einen Projektstrukturplan entworfen.',
    prompt:
        'Markiere alle Einträge, die nicht in einen Projektstrukturplan gehören. (3 P.)',
    punkte: 3,
    zeilen: [
      nein('1 Beschaffung', 'Eine Teilaufgabe, sie gehört also in den PSP.'),
      nein(
        '1.1 Angebote einholen',
        'Ein Arbeitspaket unter der Teilaufgabe Beschaffung.',
      ),
      ja(
        '1.2 Liefertermin: 14. März',
        'Ein Termin gehört in den Terminplan, nicht in den PSP.',
      ),
      nein('2 Installation', 'Eine Teilaufgabe, sie gehört also in den PSP.'),
      nein('2.1 Image erstellen', 'Ein Arbeitspaket mit prüfbarem Ergebnis.'),
      ja(
        '2.2 Image erst nach Abschluss von 1.1 verteilen',
        'Eine Abhängigkeit zwischen Vorgängen zeigt erst der Netzplan.',
      ),
      nein('3.1 Anwender einweisen', 'Ein Arbeitspaket der Übergabe.'),
      ja(
        '3.2 Meilenstein „Rollout abgeschlossen“',
        'Meilensteine sind Ereignisse des Terminplans, keine Arbeitspakete.',
      ),
    ],
    explanation:
        'Der PSP gliedert, WAS zu tun ist: Teilaufgaben und Arbeitspakete. Termine, Reihenfolgen und Meilensteine kommen erst im Netzplan oder Gantt-Diagramm dazu.',
  ),

  // ================================================ Gantt-Diagramm und Meilensteine
  tabelle(
    'i1-tg-1',
    't-gantt',
    scenario:
        'Die Stadtwerke Ahrensfeld stellen ihre Telefonanlage um. Das Gantt-Diagramm zeigt die Planung in Arbeitstagen. Vorgang D kann erst beginnen, wenn B und C abgeschlossen sind.',
    skizze: const GanttDiagramm([
      GanttVorgang('A Planung', 0, 3, kritisch: true),
      GanttVorgang('B Lieferung', 3, 5, kritisch: true),
      GanttVorgang('C Kabel prüfen', 3, 2),
      GanttVorgang('D Installation', 8, 3, kritisch: true),
      GanttVorgang('E Schulung', 11, 1, kritisch: true),
      GanttVorgang('Anlage live', 12, 0, kritisch: true),
    ], einheit: 'Tag'),
    prompt: 'Lies die gesuchten Werte aus dem Diagramm ab. (5 P.)',
    punkte: 5,
    zeilen: [
      ['Gesucht', 'Wert'],
      ['Gesamtdauer des Projekts in Tagen', zahl(12)],
      ['Zeitpunkt, an dem Vorgang B endet', zahl(8)],
      ['Puffer von Vorgang C in Tagen', zahl(3)],
      ['Anzahl der Vorgänge zwischen Zeitpunkt 3 und 5', zahl(2)],
      [
        'Vorgang, der sich um 1 Tag verspäten darf',
        wahl('C', ['A', 'B', 'D']),
      ],
    ],
    explanation:
        'Der Meilenstein „Anlage live“ liegt bei 12, also dauert das Projekt 12 Tage. B läuft von 3 bis 8. C endet bei 3 + 2 = 5, sein Nachfolger D beginnt erst bei 8. Das ergibt 8 - 5 = 3 Tage Puffer. Zwischen 3 und 5 laufen B und C parallel. Nur C liegt nicht auf dem kritischen Pfad und darf sich verspäten.',
  ),
  lueckentext(
    'i1-tg-2',
    't-gantt',
    scenario:
        'Für die Einrichtung eines Schulungsraums liegt eine Vorgangsliste vor. Daraus soll ein Gantt-Diagramm entstehen. Alle Vorgänge beginnen so früh wie möglich, das Projekt startet bei Zeitpunkt 0.',
    table: [
      ['Vorgang', 'Dauer', 'Vorgänger'],
      ['A Möbel aufbauen', '3 Tage', '-'],
      ['B Netzwerk verlegen', '4 Tage', 'A'],
      ['C Beamer montieren', '2 Tage', 'A'],
      ['D PCs einrichten', '5 Tage', 'B, C'],
      ['E Abnahme', '2 Tage', 'D'],
    ],
    prompt:
        'Ermittle die Werte, die du für das Zeichnen der Balken brauchst. (6 P.)',
    punkte: 6,
    text:
        'B endet zum Zeitpunkt {0}, C endet zum Zeitpunkt {1}.\n'
        'D beginnt frühestens zum Zeitpunkt {2} und endet bei {3}.\n'
        'Das Projekt dauert insgesamt {4} Tage.\n'
        'Vorgang C hat {5} Tage Puffer.',
    luecken: [
      zahl(7, rationale: 'B startet nach A bei 3: 3 + 4 = 7.'),
      zahl(5, rationale: 'C startet nach A bei 3: 3 + 2 = 5.'),
      zahl(7, rationale: 'D wartet auf das spätere Ende von B und C.'),
      zahl(12, rationale: '7 + 5 = 12.'),
      zahl(14, rationale: 'E läuft von 12 bis 14.'),
      zahl(2, rationale: 'D beginnt bei 7, C endet bei 5: 7 - 5 = 2.'),
    ],
    explanation:
        'A läuft von 0 bis 3, B von 3 bis 7 und C von 3 bis 5. D braucht B und C, startet also beim späteren Ende bei 7 und endet bei 12. E läuft von 12 bis 14, das Projekt dauert also 14 Tage. C ist schon bei 5 fertig, D beginnt erst bei 7. Das sind 2 Tage Puffer.',
  ),
  freitext(
    'i1-tg-3',
    't-gantt',
    scenario:
        'Im Statusmeeting eines Migrationsprojekts wird der Terminplan als Gantt-Diagramm gezeigt.',
    prompt:
        'Nenne drei Informationen, die sich aus einem Gantt-Diagramm ablesen lassen. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Beginn, Ende und Dauer jedes Vorgangs',
        stichwoerter: [
          'Beginn',
          'Anfang',
          'Start und Ende',
          'Balkenlänge',
          'Vorgangsdauer',
        ],
      ),
      krit(
        'Welche Vorgänge gleichzeitig (parallel) laufen',
        stichwoerter: ['parallel', 'gleichzeitig', 'überschneiden'],
      ),
      krit(
        'Meilensteine des Projekts',
        stichwoerter: ['Meilenstein', 'Meilensteine', 'Raute'],
      ),
      krit(
        'Gesamtdauer bzw. Endtermin des Projekts',
        stichwoerter: [
          'Gesamtdauer',
          'Projektdauer',
          'Endtermin',
          'Projektende',
        ],
      ),
      krit(
        'Fortschritt und Verzug, etwa über eine Heute-Linie',
        stichwoerter: ['Fortschritt', 'Verzug', 'Heute-Linie', 'Stand'],
      ),
      krit(
        'Kritische Vorgänge, wenn sie hervorgehoben sind',
        stichwoerter: ['kritisch', 'kritischer Pfad', 'kritische Vorgänge'],
      ),
    ],
    loesung:
        'Aus dem Gantt-Diagramm lassen sich Beginn, Ende und Dauer der Vorgänge, parallel laufende Vorgänge und die Meilensteine ablesen. Auch die Gesamtdauer und (mit Heute-Linie) der Fortschritt sind erkennbar.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Puffer und kritischer Pfad werden dagegen im Netzplan berechnet. Das Gantt-Diagramm zeigt sie nur, wenn sie eingezeichnet sind.',
  ),

  // ================================================== Ressourcen und Aufwand
  tabelle(
    'i1-tr-1',
    't-ressourcen',
    scenario:
        'Für ein Projekt im März (22 Arbeitstage) stehen drei Personen zur Verfügung. Abwesenheiten werden vor der Verfügbarkeit abgezogen.',
    prompt:
        'Berechne die Kapazität jeder Person und die Kapazität des Teams in Personentagen (PT). (4 P.)',
    punkte: 4,
    zeilen: [
      ['Person', 'Verfügbarkeit', 'Abwesend', 'Kapazität (PT)'],
      ['Dana', '100 %', '2 Tage', zahl(20)],
      ['Emre', '50 %', '0 Tage', zahl(11)],
      ['Finn', '75 %', '2 Tage', zahl(15)],
      ['Team', '', '', zahl(46)],
    ],
    explanation:
        'Kapazität = (Arbeitstage - Abwesenheit) × Verfügbarkeit.\n'
        'Dana: (22 - 2) × 1,0 = 20 PT\n'
        'Emre: 22 × 0,5 = 11 PT\n'
        'Finn: (22 - 2) × 0,75 = 15 PT\n'
        'Team: 20 + 11 + 15 = 46 PT',
  ),
  lueckentext(
    'i1-tr-2',
    't-ressourcen',
    scenario:
        'Eine Auszubildende soll im Projekthandbuch festhalten, wie aus dem Aufwand eines Arbeitspakets seine Dauer wird.',
    prompt: 'Vervollständige den Text mit den passenden Begriffen. (4 P.)',
    punkte: 4,
    text:
        'Dauer = {0} / (Anzahl der Personen × {1}).\n'
        'Der Aufwand wird in {2} gemessen, die Dauer in {3}.',
    luecken: [
      wort(['Aufwand'], 'Die Arbeitsmenge steht im Zähler.'),
      wort([
        'Verfügbarkeit',
      ], 'Wer nur zu 50 % mitarbeitet, schafft halb so viel.'),
      wort(['Personentagen'], 'Aufwand ist eine Arbeitsmenge.'),
      wort(['Arbeitstagen'], 'Dauer ist eine Zeitspanne im Kalender.'),
    ],
    wortbank: ['Kosten', 'Stundensatz', 'Meilensteinen', 'Puffer'],
    explanation:
        'Dauer = Aufwand / (Personen × Verfügbarkeit). Beispiel: 24 PT / (2 × 0,6) = 20 Arbeitstage. Aufwand (Personentage) ist Arbeitsmenge, Dauer (Arbeitstage) ist Kalenderzeit.',
  ),
  freitext(
    'i1-tr-3',
    't-ressourcen',
    scenario:
        'Das Ressourcenhistogramm zeigt für den einzigen Netzwerkadministrator in KW 20 eine Auslastung von 140 %. In KW 22 ist er nur zu 50 % ausgelastet.',
    prompt:
        'Beschreibe zwei Maßnahmen, mit denen die Überlast ausgeglichen werden kann. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Einen Vorgang mit Puffer in eine schwächer ausgelastete Woche (KW 22) verschieben',
        punkte: 2,
        stichwoerter: ['verschieben', 'Puffer', 'KW 22', 'später', 'verlagern'],
      ),
      krit(
        'Arbeit auf Kolleginnen oder Kollegen mit freier Kapazität umverteilen',
        punkte: 2,
        stichwoerter: [
          'umverteilen',
          'Kollegen',
          'Kollegin',
          'abgeben',
          'delegieren',
        ],
      ),
      krit(
        'Zusätzliche Kapazität beschaffen, etwa externe Unterstützung',
        punkte: 2,
        stichwoerter: ['extern', 'Dienstleister', 'zusätzlich', 'Aushilfe'],
      ),
      krit(
        'Mit dem Auftraggeber Termin oder Umfang anpassen',
        punkte: 2,
        stichwoerter: ['Auftraggeber', 'Endtermin', 'Umfang', 'strecken'],
      ),
    ],
    loesung:
        'Ein Vorgang mit Puffer wird aus KW 20 in die schwach ausgelastete KW 22 verschoben; das kostet weder Geld noch Termin. Zusätzlich kann ein Teil der Arbeit an eine Kollegin mit freier Kapazität abgegeben werden.',
    explanation:
        'Je Maßnahme 2 Punkte, höchstens 4. Zuerst nutzt man Lösungen ohne Mehrkosten (Verschieben im Puffer, Umverteilen), erst danach externe Hilfe oder Änderungen an Termin und Umfang.',
  ),
  lueckentext(
    'i1-tr-4',
    't-ressourcen',
    scenario:
        'Für die Umstellung eines Mailservers sind 36 Personentage (PT) Aufwand geschätzt. Drei Administratoren arbeiten zu je 80 % im Projekt. Ein Personentag hat 8 Stunden, der interne Stundensatz beträgt 45 €.',
    prompt: 'Berechne Dauer und Personalkosten des Arbeitspakets. (4 P.)',
    punkte: 4,
    text:
        'Kapazität des Teams je Arbeitstag: {0} PT\n'
        'Dauer: {1} Arbeitstage\n'
        'Aufwand in Stunden: {2} h\n'
        'Personalkosten: {3} €',
    luecken: [
      zahl(2.4, toleranz: 0.01, rationale: '3 × 0,8 = 2,4 PT je Tag.'),
      zahl(15, rationale: '36 / 2,4 = 15.'),
      zahl(288, rationale: '36 × 8 = 288.'),
      zahl(12960, rationale: '288 × 45 = 12.960.'),
    ],
    explanation:
        'Kapazität je Tag: 3 × 0,8 = 2,4 PT\n'
        'Dauer: 36 PT / 2,4 PT je Tag = 15 Arbeitstage\n'
        'Stunden: 36 PT × 8 h = 288 h\n'
        'Personalkosten: 288 h × 45 €/h = 12.960 €\n'
        'Die Kosten hängen am Aufwand, nicht an der Dauer.',
  ),

  // ======================================= Der Risikomanagement-Prozess
  tabelle(
    'i1-rp-1',
    'r-prozess',
    scenario:
        'Die Brenner Maschinenbau GmbH zieht ihre Postfächer auf einen neuen Mailserver um. Im Risikoregister stehen drei Einträge.',
    prompt:
        'Ordne jedem Risiko die Risikoart und einen passenden Frühwarnindikator zu. (6 P.)',
    punkte: 6,
    zeilen: [
      ['Risiko', 'Art', 'Frühwarnindikator'],
      [
        'Der Lieferant liefert die Server verspätet.',
        wahl('terminlich', ['technisch', 'personell', 'rechtlich']),
        wahl('Termin unbestätigt', [
          'viele Krankmeldungen',
          'Testlauf mit Fehlern',
        ]),
      ],
      [
        'Der einzige Mail-Administrator fällt aus.',
        wahl('personell', ['technisch', 'terminlich', 'rechtlich']),
        wahl('viele Krankmeldungen', [
          'Termin unbestätigt',
          'Testlauf mit Fehlern',
        ]),
      ],
      [
        'Alte Postfächer lassen sich nicht fehlerfrei übernehmen.',
        wahl('technisch', ['personell', 'terminlich', 'rechtlich']),
        wahl('Testlauf mit Fehlern', [
          'Termin unbestätigt',
          'viele Krankmeldungen',
        ]),
      ],
    ],
    explanation:
        'Eingeordnet wird nach der Ursache: Lieferverzug gefährdet den Zeitplan (terminlich), der Ausfall einer Schlüsselperson ist personell, die Datenübernahme technisch. Ein Frühwarnindikator ist ein beobachtbares Anzeichen dafür, dass das Risiko wahrscheinlicher wird.',
  ),
  freitext(
    'i1-rp-2',
    'r-prozess',
    scenario:
        'Eine Bäckereikette mit 12 Filialen führt eine digitale Zeiterfassung mit Terminals in jeder Filiale ein. Im Kick-off sollen Risiken gesammelt werden.',
    prompt:
        'Nenne vier Risiken unterschiedlicher Art, die in diesem Projekt auftreten können. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Technisch: Terminals sind mit der Lohnsoftware oder dem Filialnetz nicht kompatibel',
        stichwoerter: [
          'kompatibel',
          'Schnittstelle',
          'WLAN',
          'Netzwerk',
          'technisch',
        ],
      ),
      krit(
        'Personell: Mitarbeitende lehnen die Zeiterfassung ab oder eine Schlüsselperson fällt aus',
        stichwoerter: [
          'Akzeptanz',
          'Widerstand',
          'ablehnen',
          'krank',
          'personell',
        ],
      ),
      krit(
        'Terminlich: Die Terminals werden verspätet geliefert',
        stichwoerter: ['Lieferung', 'Lieferverzug', 'verspätet', 'terminlich'],
      ),
      krit(
        'Rechtlich: Verstoß gegen Datenschutz oder fehlende Zustimmung des Betriebsrats',
        stichwoerter: [
          'Datenschutz',
          'DSGVO',
          'Betriebsrat',
          'Mitbestimmung',
          'rechtlich',
        ],
      ),
      krit(
        'Wirtschaftlich: Das Budget wird überschritten',
        stichwoerter: ['Budget', 'Kosten', 'teurer', 'wirtschaftlich'],
      ),
    ],
    loesung:
        'Technisch: Die Terminals arbeiten nicht mit der Lohnsoftware zusammen. Personell: Die Belegschaft lehnt die Zeiterfassung ab. Terminlich: Die Terminals kommen verspätet. Rechtlich: Der Betriebsrat wurde nicht beteiligt oder der Datenschutz wird verletzt.',
    explanation:
        'Je Risiko 1 Punkt, höchstens 4. Wer systematisch nach Risikoarten sucht (technisch, personell, terminlich, rechtlich, wirtschaftlich), übersieht weniger.',
  ),
  lueckentext(
    'i1-rp-3',
    'r-prozess',
    scenario:
        'Im Risikoregister soll ein Risiko nach dem Muster „Ursache, Ereignis, Auswirkung“ beschrieben werden.',
    prompt: 'Setze die drei Bausteine an die richtige Stelle. (3 P.)',
    punkte: 3,
    text: 'Weil {0}, könnte {1}, sodass {2}.',
    luecken: [
      wahl('nur ein Admin die Firewall kennt', [
        'die Umstellung bei seinem Ausfall stocken',
        'sich der Go-live verschiebt',
      ], 'Die Ursache steht am Anfang.'),
      wahl('die Umstellung bei seinem Ausfall stocken', [
        'nur ein Admin die Firewall kennt',
        'sich der Go-live verschiebt',
      ], 'Das mögliche Ereignis.'),
      wahl('sich der Go-live verschiebt', [
        'nur ein Admin die Firewall kennt',
        'die Umstellung bei seinem Ausfall stocken',
      ], 'Die Auswirkung auf das Projekt.'),
    ],
    explanation:
        'Ein gut beschriebenes Risiko nennt Ursache, Ereignis und Auswirkung: „Weil nur ein Admin die Firewall kennt, könnte die Umstellung bei seinem Ausfall stocken, sodass sich der Go-live verschiebt.“ Erst so lassen sich Wahrscheinlichkeit und Schaden schätzen.',
  ),
  paare(
    'i1-rp-4',
    'r-prozess',
    scenario:
        'Das Risikomanagement eines Projekts läuft in vier Schritten ab, die sich als Kreislauf wiederholen.',
    prompt: 'Ordne jedem Schritt die passende Tätigkeit zu. (4 P.)',
    punkte: 4,
    paare: [
      paar('Identifizieren', 'Brainstorming und Checklisten nutzen'),
      paar('Bewerten', 'Wahrscheinlichkeit und Schaden schätzen'),
      paar('Maßnahmen planen', 'Strategie und Verantwortliche festlegen'),
      paar('Überwachen', 'Frühwarnindikatoren beobachten'),
    ],
    explanation:
        'Identifizieren (Risiken finden), bewerten (Wahrscheinlichkeit × Schaden), Maßnahmen planen (Strategie, Verantwortliche), überwachen (Indikatoren, Status). Danach beginnt der Kreislauf von vorn.',
  ),

  // =========================================================== Risiken bewerten
  tabelle(
    'i1-rb-1',
    'r-bewertung',
    scenario:
        'Für die Einführung eines Warenwirtschaftssystems wurden drei Risiken geschätzt. Priorisiert wird nach dem Risikowert.',
    prompt:
        'Berechne die Risikowerte und vergib die Rangplätze (1 = zuerst behandeln). (6 P.)',
    punkte: 6,
    zeilen: [
      ['Risiko', 'Wahrsch.', 'Schaden', 'Risikowert (€)', 'Rang'],
      [
        'R1 Datenverlust bei Migration',
        '20 %',
        '30.000 €',
        zahl(6000),
        zahl(2),
      ],
      ['R2 Ausfall des Lieferanten', '5 %', '200.000 €', zahl(10000), zahl(1)],
      ['R3 Schulung fällt aus', '60 %', '4.000 €', zahl(2400), zahl(3)],
    ],
    explanation:
        'Risikowert = Wahrscheinlichkeit × Schaden.\n'
        'R1: 0,20 × 30.000 € = 6.000 €\n'
        'R2: 0,05 × 200.000 € = 10.000 €\n'
        'R3: 0,60 × 4.000 € = 2.400 €\n'
        'Rangfolge: R2, R1, R3. Das unwahrscheinlichste Risiko steht also vorn, das wahrscheinlichste hinten.',
  ),
  markieren(
    'i1-rb-2',
    'r-bewertung',
    scenario:
        'In einer 3×3-Risikomatrix werden Wahrscheinlichkeit (W) und Auswirkung (A) mit 1 bis 3 bewertet. Kennzahl = W × A. Kennzahl 1 bis 2: grün, 3 bis 4: gelb, 6 bis 9: rot.',
    prompt: 'Markiere alle Risiken, die falsch eingeordnet wurden. (3 P.)',
    punkte: 3,
    zeilen: [
      nein('R1: W 3, A 3: rot', '3 × 3 = 9, also rot. Richtig eingeordnet.'),
      ja('R2: W 1, A 2: gelb', '1 × 2 = 2, das ist grün.'),
      nein('R3: W 2, A 2: gelb', '2 × 2 = 4, also gelb. Richtig.'),
      ja('R4: W 3, A 2: gelb', '3 × 2 = 6, das ist bereits rot.'),
      nein('R5: W 1, A 1: grün', '1 × 1 = 1, also grün. Richtig.'),
      ja('R6: W 1, A 3: grün', '1 × 3 = 3, das ist gelb.'),
    ],
    explanation:
        'Kennzahl = Wahrscheinlichkeit × Auswirkung. Falsch eingeordnet sind R2 (Kennzahl 2, grün), R4 (6, rot) und R6 (3, gelb). Die Kennzahl 5 kann in einer 3×3-Matrix nicht vorkommen, deshalb beginnt Rot bei 6.',
  ),
  lueckentext(
    'i1-rb-3',
    'r-bewertung',
    scenario:
        'Die Klimaanlage im Serverraum fällt mit einer Wahrscheinlichkeit von 15 % aus. Der Schaden läge bei 80.000 €. Ein zweites Klimagerät für 5.000 € würde die Wahrscheinlichkeit auf 5 % senken.',
    prompt: 'Prüfe rechnerisch, ob sich das zweite Klimagerät lohnt. (5 P.)',
    punkte: 5,
    text:
        'Risikowert ohne Maßnahme: {0} €\n'
        'Risikowert mit Maßnahme: {1} €\n'
        'Senkung des Risikowerts: {2} €\n'
        'Senkung abzüglich Kosten der Maßnahme: {3} €\n'
        'Das zweite Klimagerät {4}.',
    luecken: [
      zahl(12000, rationale: '0,15 × 80.000 €.'),
      zahl(4000, rationale: '0,05 × 80.000 €.'),
      zahl(8000, rationale: '12.000 € - 4.000 €.'),
      zahl(3000, rationale: '8.000 € - 5.000 €.'),
      wahl('lohnt sich', ['lohnt sich nicht', 'ändert nichts am Risiko']),
    ],
    explanation:
        'Vorher: 0,15 × 80.000 € = 12.000 €. Nachher: 0,05 × 80.000 € = 4.000 €. Die Maßnahme senkt den Risikowert um 8.000 € und kostet 5.000 €. Es bleibt ein Vorteil von 3.000 €, sie lohnt sich also.',
  ),
  freitext(
    'i1-rb-4',
    'r-bewertung',
    scenario:
        'Ein Brand im Rechenzentrum eines Onlinehändlers ist sehr unwahrscheinlich (0,5 %), würde aber einen Schaden von 2 Mio. € verursachen. Der Risikowert beträgt nur 10.000 €.',
    prompt:
        'Erläutere, warum dieses Risiko trotz des kleinen Risikowerts behandelt werden muss, und nenne eine geeignete Maßnahme. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Der Risikowert ist nur ein rechnerischer Durchschnitt: Tritt das Risiko ein, fällt der volle Schaden an.',
        punkte: 2,
        stichwoerter: [
          'Durchschnitt',
          'Erwartungswert',
          'voller Schaden',
          'gesamte Schaden',
          '2 Mio',
        ],
      ),
      krit(
        'Ein Schaden dieser Höhe kann die Existenz des Unternehmens gefährden.',
        punkte: 2,
        stichwoerter: [
          'Existenz',
          'existenzbedrohend',
          'Insolvenz',
          'verkraften',
          'gefährdet',
        ],
      ),
      krit(
        'Maßnahme: Versicherung, ausgelagerte Backups oder ein Notfallplan',
        stichwoerter: [
          'Versicherung',
          'Backup',
          'Datensicherung',
          'Notfallplan',
          'Ausweichrechenzentrum',
        ],
      ),
    ],
    loesung:
        'Der Risikowert von 10.000 € ist nur ein Durchschnitt. Tritt der Brand ein, fallen die vollen 2 Mio. € an. Das könnte das Unternehmen in die Insolvenz treiben. Deshalb wird das Risiko übertragen (Versicherung) und der Schaden durch ausgelagerte Backups begrenzt.',
    explanation:
        'Begründung 2 Punkte, Maßnahme 1 Punkt. Seltene, aber existenzbedrohende Risiken brauchen immer eine Maßnahme, denn der Risikowert allein unterschätzt sie.',
  ),

  // =========================================================== Risikostrategien
  paare(
    'i1-rs-1',
    'r-strategien',
    scenario:
        'Für den Umzug eines Rechenzentrums wurden zu vier Risiken Maßnahmen beschlossen.',
    prompt: 'Ordne jeder Maßnahme die Risikostrategie zu. (4 P.)',
    punkte: 4,
    paare: [
      paar('Auf die unerprobte Technik verzichten', 'Vermeiden'),
      paar('Zweiten Administrator einarbeiten', 'Vermindern'),
      paar('Transportversicherung abschließen', 'Übertragen'),
      paar('Kratzer am Gehäuse bewusst hinnehmen', 'Akzeptieren'),
    ],
    explanation:
        'Vermeiden: Die Ursache entfällt. Vermindern: Wahrscheinlichkeit oder Schaden sinken. Übertragen: Ein Dritter trägt die finanziellen Folgen. Akzeptieren: Das Risiko wird bewusst getragen.',
  ),
  tabelle(
    'i1-rs-2',
    'r-strategien',
    scenario:
        'Ein Systemhaus stellt bei einem Kunden die Warenwirtschaft um. Für vier Risiken wurden Maßnahmen geplant.',
    prompt:
        'Gib zu jeder Maßnahme die Strategie an und, wo gefragt, worauf sie wirkt. (7 P.)',
    punkte: 7,
    zeilen: [
      ['Maßnahme', 'Strategie', 'wirkt auf'],
      [
        'Datenübernahme vorab an einer Kopie proben',
        wahl('Vermindern', ['Vermeiden', 'Übertragen', 'Akzeptieren']),
        wahl('Wahrscheinlichkeit', ['Schadenshöhe', 'Kostenträger']),
      ],
      [
        'Ersatzserver für den Notfall bereithalten',
        wahl('Vermindern', ['Vermeiden', 'Übertragen', 'Akzeptieren']),
        wahl('Schadenshöhe', ['Wahrscheinlichkeit', 'Kostenträger']),
      ],
      [
        'Cyberversicherung abschließen',
        wahl('Übertragen', ['Vermeiden', 'Vermindern', 'Akzeptieren']),
        wahl('Kostenträger', ['Wahrscheinlichkeit', 'Schadenshöhe']),
      ],
      [
        'Auf die Beta-Version des Moduls verzichten',
        wahl('Vermeiden', ['Vermindern', 'Übertragen', 'Akzeptieren']),
        'Risiko entfällt',
      ],
    ],
    explanation:
        'Die Probe senkt die Wahrscheinlichkeit eines Fehlschlags, der Ersatzserver begrenzt den Schaden. Beides ist Vermindern. Die Versicherung ändert nur, wer zahlt (Übertragen). Wer auf die Beta-Version verzichtet, beseitigt die Ursache (Vermeiden).',
  ),
  freitext(
    'i1-rs-3',
    'r-strategien',
    scenario:
        'Die Projektleitung eines Büroumzugs erhält vom englischsprachigen IT-Dienstleister eine Risikonotiz zum Transport des Dateiservers.',
    code:
        'RISK MEMO - Office relocation\n'
        'The file server will be moved by an external\n'
        'carrier. If it is damaged, the staff cannot\n'
        'work for up to two days.\n'
        'We recommend:\n'
        '1. Take out transport insurance for the server.\n'
        '2. Run a full backup and a restore test before\n'
        '   the move.\n'
        '3. Rent a standby server in the data centre so\n'
        '   that work can continue during the move.',
    prompt:
        'Nenne die drei empfohlenen Maßnahmen auf Deutsch und gib jeweils die Risikostrategie an. (6 P.)',
    punkte: 6,
    kriterien: [
      krit(
        'Transportversicherung für den Server abschließen, Strategie: Übertragen',
        punkte: 2,
        stichwoerter: [
          'Versicherung',
          'Transportversicherung',
          'übertragen',
          'überwälzen',
        ],
      ),
      krit(
        'Vollsicherung und Wiederherstellungstest vor dem Umzug, Strategie: Vermindern',
        punkte: 2,
        stichwoerter: [
          'Backup',
          'Vollsicherung',
          'Datensicherung',
          'Wiederherstellung',
          'Rücksicherung',
        ],
      ),
      krit(
        'Ersatzserver im Rechenzentrum mieten, damit weitergearbeitet werden kann, Strategie: Vermindern',
        punkte: 2,
        stichwoerter: [
          'Ersatzserver',
          'Standby',
          'mieten',
          'Ausweichserver',
          'Rechenzentrum',
        ],
      ),
    ],
    loesung:
        '1. Transportversicherung abschließen: Übertragen (die Versicherung trägt den finanziellen Schaden). 2. Vollsicherung mit Wiederherstellungstest vor dem Umzug: Vermindern (der Schaden wird begrenzt). 3. Ersatzserver im Rechenzentrum mieten: Vermindern (der Arbeitsausfall wird kleiner).',
    explanation:
        'Je Maßnahme 1 Punkt für die Übersetzung und 1 Punkt für die Strategie. Keine der Maßnahmen verhindert den Transportschaden. Sie verlagern oder begrenzen nur seine Folgen.',
  ),

  // ============================================== Projektkosten kalkulieren
  tabelle(
    'i1-wk-1',
    'w-kalkulation',
    scenario:
        'Ein Systemhaus kalkuliert die Einrichtung eines Besprechungsraums: 60 Stunden zu je 50 €, 40 % Gemeinkostenzuschlag auf die Personalkosten, 800 € Sachkosten, 10 % Gewinnzuschlag auf die Selbstkosten, 19 % Umsatzsteuer.',
    prompt: 'Vervollständige das Kalkulationsschema. (7 P.)',
    punkte: 7,
    zeilen: [
      ['Position', 'Betrag (€)'],
      ['Personalkosten', zahl(3000)],
      ['+ Gemeinkosten 40 %', zahl(1200)],
      ['+ Sachkosten', '800'],
      ['= Selbstkosten', zahl(5000)],
      ['+ Gewinn 10 %', zahl(500)],
      ['= Nettoangebotspreis', zahl(5500)],
      ['+ Umsatzsteuer 19 %', zahl(1045)],
      ['= Bruttoangebotspreis', zahl(6545)],
    ],
    explanation:
        'Personalkosten: 60 h × 50 € = 3.000 €\n'
        'Gemeinkosten: 3.000 € × 0,4 = 1.200 €\n'
        'Selbstkosten: 3.000 € + 1.200 € + 800 € = 5.000 €\n'
        'Gewinn: 5.000 € × 0,1 = 500 €, netto 5.500 €\n'
        'Umsatzsteuer: 5.500 € × 0,19 = 1.045 €, brutto 6.545 €',
  ),
  lueckentext(
    'i1-wk-2',
    'w-kalkulation',
    scenario:
        'Eine Arztpraxis kauft einen Laserdrucker für 2.880 € und nutzt ihn 4 Jahre. Sie druckt 2.500 Seiten im Monat, eine Seite kostet 0,018 € an Toner und Papier. Der Wartungsvertrag kostet 15 € im Monat.',
    prompt:
        'Berechne die monatlichen Kosten des Druckers und die Kosten je Seite. (5 P.)',
    punkte: 5,
    text:
        'Nutzungsdauer: {0} Monate\n'
        'Anschaffung je Monat: {1} €\n'
        'Verbrauch je Monat: {2} €\n'
        'Gesamtkosten je Monat: {3} €\n'
        'Kosten je Seite: {4} Cent (eine Nachkommastelle)',
    luecken: [
      zahl(48, rationale: '4 Jahre × 12 Monate.'),
      zahl(60, rationale: '2.880 € / 48.'),
      zahl(45, rationale: '2.500 × 0,018 €.'),
      zahl(120, rationale: '60 € + 45 € + 15 € Wartung.'),
      zahl(4.8, toleranz: 0.01, rationale: '120 € / 2.500 = 0,048 €.'),
    ],
    explanation:
        'Anschaffung: 2.880 € / 48 Monate = 60 €\n'
        'Verbrauch: 2.500 Seiten × 0,018 € = 45 €\n'
        'Wartung: 15 €\n'
        'Monatskosten: 60 € + 45 € + 15 € = 120 €\n'
        'Je Seite: 120 € / 2.500 = 0,048 € = 4,8 Cent',
  ),
  tabelle(
    'i1-wk-3',
    'w-kalkulation',
    scenario:
        'Ein Ingenieurbüro mit 6 Beschäftigten vergleicht zwei Planungsprogramme für das erste Jahr. Während der Schulung können die Beschäftigten keine Kundenstunden abrechnen (75 € je Stunde, 8 Stunden je Tag).',
    table: [
      ['', 'Software A', 'Software B'],
      ['Lizenz je Nutzer und Monat', '40 €', '55 €'],
      ['Schulung für alle', '2 Tage', '1 Tag'],
      ['Trainer je Schulungstag', '800 €', '800 €'],
    ],
    prompt:
        'Berechne die Kosten im ersten Jahr einschließlich des entgangenen Umsatzes. (6 P.)',
    punkte: 6,
    zeilen: [
      ['Kostenart', 'A (€)', 'B (€)'],
      ['Lizenzen', zahl(2880), zahl(3960)],
      ['Trainer', '1.600', '800'],
      ['Entgangener Umsatz', zahl(7200), zahl(3600)],
      ['Summe', zahl(11680), zahl(8360)],
    ],
    explanation:
        'Lizenzen: A 6 × 40 € × 12 = 2.880 €, B 6 × 55 € × 12 = 3.960 €\n'
        'Entgangener Umsatz: A 6 × 2 Tage × 8 h × 75 € = 7.200 €, B 6 × 1 Tag × 8 h × 75 € = 3.600 €\n'
        'Summe: A 2.880 + 1.600 + 7.200 = 11.680 €, B 3.960 + 800 + 3.600 = 8.360 €\n'
        'Trotz teurerer Lizenz ist B um 3.320 € günstiger, weil der entgangene Umsatz den Ausschlag gibt.',
  ),
  markieren(
    'i1-wk-4',
    'w-kalkulation',
    scenario:
        'Ein Auszubildender hat den Bezugspreis für ein Angebot berechnet: Listenpreis 4.000 €, 10 % Rabatt, 2 % Skonto, 60 € Fracht.',
    prompt:
        'Markiere die Zeilen, in denen ein Fehler entsteht. Folgefehler in späteren Zeilen werden nicht markiert. (4 P.)',
    punkte: 4,
    zeilen: [
      nein('Rabatt: 10 % von 4.000 € = 400 €', 'Richtig gerechnet.'),
      nein(
        'Zieleinkaufspreis: 4.000 € - 400 € = 3.600 €',
        'Richtig: Listenpreis minus Rabatt.',
      ),
      ja(
        'Skonto: 2 % von 4.000 € = 80 €',
        'Skonto wird vom Zieleinkaufspreis gerechnet: 2 % von 3.600 € = 72 €.',
      ),
      nein(
        'Bareinkaufspreis: 3.600 € - 80 € = 3.520 €',
        'Nur ein Folgefehler: Richtig wären 3.600 € - 72 € = 3.528 €.',
      ),
      ja(
        'Fracht: 60 € abzüglich 2 % Skonto = 58,80 €',
        'Auf Bezugskosten gibt es kein Skonto, es bleibt also bei 60 €.',
      ),
      nein(
        'Bezugspreis: 3.520 € + 58,80 € = 3.578,80 €',
        'Nur ein Folgefehler: Richtig wären 3.528 € + 60 € = 3.588 €.',
      ),
    ],
    explanation:
        'Richtig: 4.000 € - 400 € = 3.600 €; Skonto 2 % von 3.600 € = 72 €; Bareinkaufspreis 3.528 €; + 60 € Fracht = 3.588 €. Je Fehler 2 Punkte: Skonto bezieht sich auf den Zieleinkaufspreis, und Bezugskosten werden nicht skontiert.',
  ),
  lueckentext(
    'i1-wk-5',
    'w-kalkulation',
    scenario:
        'Eine Eingangsrechnung über Netzwerkkomponenten weist 2.400,00 € netto aus, dazu 19 % Umsatzsteuer. Zahlungsbedingung: „Zahlbar innerhalb von 10 Tagen mit 2 % Skonto, 30 Tage netto.“ Die Rechnung wird am 6. Tag bezahlt.',
    prompt:
        'Berechne den Überweisungsbetrag (Beträge kaufmännisch auf zwei Nachkommastellen). (4 P.)',
    punkte: 4,
    text:
        'Umsatzsteuer: {0} €\n'
        'Rechnungsbetrag brutto: {1} €\n'
        'Skontobetrag: {2} €\n'
        'Überweisungsbetrag: {3} €',
    luecken: [
      zahl(456, toleranz: 0.01, rationale: '2.400 € × 0,19.'),
      zahl(2856, toleranz: 0.01, rationale: '2.400 € + 456 €.'),
      zahl(57.12, toleranz: 0.01, rationale: '2 % vom Bruttobetrag.'),
      zahl(2798.88, toleranz: 0.01, rationale: '2.856 € - 57,12 €.'),
    ],
    explanation:
        'Umsatzsteuer: 2.400 € × 0,19 = 456 €\n'
        'Brutto: 2.400 € + 456 € = 2.856 €\n'
        'Skonto: 2.856 € × 0,02 = 57,12 €. Beim Bezahlen einer Rechnung ist der Bruttobetrag die Basis.\n'
        'Überweisung: 2.856 € - 57,12 € = 2.798,88 €',
  ),
  lueckentext(
    'i1-wk-6',
    'w-kalkulation',
    scenario:
        'Die Hansa Druck KG erneuert ihre Etagenverteiler und erhält ein englischsprachiges Angebot. Skonto wird genutzt.',
    code:
        'QUOTATION No. 2291 - NetSupply Ltd.\n'
        'Item:        24-port managed switch\n'
        'Quantity:    8 units\n'
        'Unit price:  EUR 310.00 (net)\n'
        'Discount:    5 % for 5 units or more\n'
        'Shipping:    EUR 45.00 flat rate\n'
        'Payment:     2 % cash discount within\n'
        '             10 days, 30 days net\n'
        'Delivery:    3 weeks after order',
    prompt: 'Ermittle den Bezugspreis der Lieferung (netto). (6 P.)',
    punkte: 6,
    text:
        'Listenpreis gesamt: {0} €\n'
        'Rabatt: {1} €\n'
        'Zieleinkaufspreis: {2} €\n'
        'Skonto: {3} €\n'
        'Bezugspreis: {4} €\n'
        'Lieferzeit: {5} Wochen nach Bestellung',
    luecken: [
      zahl(2480, toleranz: 0.01, rationale: '8 × 310 €.'),
      zahl(124, toleranz: 0.01, rationale: '5 % von 2.480 €.'),
      zahl(2356, toleranz: 0.01, rationale: '2.480 € - 124 €.'),
      zahl(47.12, toleranz: 0.01, rationale: '2 % von 2.356 €.'),
      zahl(
        2353.88,
        toleranz: 0.01,
        rationale: '2.356 € - 47,12 € + 45 € Versand.',
      ),
      zahl(3, rationale: '„3 weeks after order“.'),
    ],
    explanation:
        'Listenpreis: 8 × 310 € = 2.480 €\n'
        'Rabatt (discount) 5 %: 124 €, Zieleinkaufspreis 2.356 €\n'
        'Skonto (cash discount) 2 % von 2.356 €: 47,12 €, Bareinkaufspreis 2.308,88 €\n'
        'Versand (shipping): + 45 € = 2.353,88 €\n'
        'Der Mengenrabatt gilt, weil mindestens 5 Stück bestellt werden.',
  ),
  freitext(
    'i1-wk-7',
    'w-kalkulation',
    scenario:
        'Eine Unternehmensberatung führt eine neue Projektsoftware ein. Die Geschäftsführung fragt, warum im Kostenvergleich neben den Lizenzgebühren ein „entgangener Umsatz“ steht.',
    prompt:
        'Erläutere, warum der entgangene Umsatz ein Kostenbestandteil ist, und nenne zwei weitere Kosten der Einführung außer den Lizenzgebühren. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Während Schulung und Umstellung leisten die Beschäftigten keine abrechenbaren Stunden. Dieser Umsatz fehlt dem Unternehmen.',
        punkte: 2,
        stichwoerter: [
          'abrechenbar',
          'Umsatz fehlt',
          'keine Kundenstunden',
          'nicht produktiv',
          'Arbeitszeit',
          'Ausfallzeit',
        ],
      ),
      krit(
        'Schulungskosten (Trainer, Unterlagen)',
        stichwoerter: ['Schulung', 'Trainer', 'Seminar'],
      ),
      krit(
        'Installation, Einrichtung oder Datenübernahme',
        stichwoerter: [
          'Installation',
          'Einrichtung',
          'Datenübernahme',
          'Migration',
          'Anpassung',
        ],
      ),
      krit(
        'Zusätzliche Hardware oder Wartung und Support',
        stichwoerter: ['Hardware', 'Wartung', 'Support', 'Server'],
      ),
    ],
    loesung:
        'Solange die Beraterinnen und Berater geschult werden, können sie keine Stunden an Kunden abrechnen. Der Umsatz, der in dieser Zeit erzielt worden wäre, fehlt. Er gehört deshalb zu den Kosten der Einführung. Weitere Kosten: Trainerhonorar für die Schulung und die Datenübernahme aus dem Altsystem.',
    explanation:
        'Erläuterung 2 Punkte, je weitere Kostenart 1 Punkt. Entgangener Umsatz = ausgefallene Stunden × Stundensatz × Personen. Es fließt kein Geld ab, aber es kommt weniger herein.',
  ),

  // ============================================================ Nutzwertanalyse
  tabelle(
    'i1-wn-1',
    'w-nutzwert',
    scenario:
        'Ein Handwerksbetrieb wählt eine Zeiterfassungs-App aus. Bewertet wird auf einer Skala von 0 bis 10 Punkten. Gewichte: Funktionsumfang 50 %, Preis 30 %, Support 20 %.',
    prompt:
        'Berechne die gewichteten Punkte und die Nutzwerte beider Anbieter. (8 P.)',
    punkte: 8,
    zeilen: [
      ['Kriterium', 'A Punkte', 'A gewichtet', 'B Punkte', 'B gewichtet'],
      [
        'Funktion (50 %)',
        '8',
        zahl(4, toleranz: 0.01),
        '6',
        zahl(3, toleranz: 0.01),
      ],
      [
        'Preis (30 %)',
        '5',
        zahl(1.5, toleranz: 0.01),
        '9',
        zahl(2.7, toleranz: 0.01),
      ],
      [
        'Support (20 %)',
        '7',
        zahl(1.4, toleranz: 0.01),
        '8',
        zahl(1.6, toleranz: 0.01),
      ],
      [
        'Nutzwert',
        '',
        zahl(6.9, toleranz: 0.01),
        '',
        zahl(7.3, toleranz: 0.01),
      ],
    ],
    explanation:
        'A: 0,5 × 8 = 4,0; 0,3 × 5 = 1,5; 0,2 × 7 = 1,4; Nutzwert 6,9\n'
        'B: 0,5 × 6 = 3,0; 0,3 × 9 = 2,7; 0,2 × 8 = 1,6; Nutzwert 7,3\n'
        'B gewinnt, obwohl A beim wichtigsten Kriterium vorn liegt. Am Ende zählt die Summe.',
  ),
  tabelle(
    'i1-wn-2',
    'w-nutzwert',
    scenario:
        'Eine Kanzlei vergleicht drei Multifunktionsdrucker mit einer Entscheidungsmatrix ohne Gewichtung. Je Kriterium werden Rangplätze vergeben: Rang 1 für den besten, Rang 3 für den schlechtesten Wert. Es gewinnt das Gerät mit der kleinsten Rangsumme.',
    table: [
      ['Kriterium', 'Gerät X', 'Gerät Y', 'Gerät Z'],
      ['Anschaffung', '1.200 €', '950 €', '1.400 €'],
      ['Kosten je Seite', '1,8 Cent', '2,5 Cent', '1,2 Cent'],
      ['Druckgeschwindigkeit', '40 S./min', '30 S./min', '35 S./min'],
      ['Garantie', '24 Monate', '36 Monate', '12 Monate'],
    ],
    prompt:
        'Vervollständige die Entscheidungsmatrix und bilde die Rangsummen. (7 P.)',
    punkte: 7,
    zeilen: [
      ['Kriterium', 'X', 'Y', 'Z'],
      ['Anschaffung', '2', '1', '3'],
      ['Kosten je Seite', zahl(2), zahl(3), zahl(1)],
      ['Druckgeschwindigkeit', zahl(1), zahl(3), zahl(2)],
      ['Garantie', zahl(2), zahl(1), zahl(3)],
      ['Rangsumme', zahl(7), zahl(8), zahl(9)],
    ],
    explanation:
        'Bei Kosten ist der kleinste Wert der beste. Bei den Kosten je Seite hat also Z (1,2 Cent) Rang 1, X Rang 2 und Y Rang 3. Bei Geschwindigkeit und Garantie ist der größte Wert der beste.\n'
        'Rangsummen: X 2 + 2 + 1 + 2 = 7, Y 1 + 3 + 3 + 1 = 8, Z 3 + 1 + 2 + 3 = 9.\n'
        'Gewählt wird Gerät X mit der kleinsten Rangsumme.',
  ),
  freitext(
    'i1-wn-3',
    'w-nutzwert',
    scenario:
        'Die Geschäftsführung eines Autohauses zweifelt am Ergebnis einer Nutzwertanalyse: Der Sieger liegt nur 0,2 Punkte vor dem Zweiten.',
    prompt:
        'Beschreibe zwei Schwächen der Nutzwertanalyse, die bei der Entscheidung zu beachten sind. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Die Gewichtung ist subjektiv: Wer die Gewichte festlegt, beeinflusst das Ergebnis.',
        punkte: 2,
        stichwoerter: ['Gewichtung', 'Gewichte', 'subjektiv', 'gewichtet'],
      ),
      krit(
        'Die Punktevergabe beruht auf persönlicher Einschätzung, nicht auf Messung.',
        punkte: 2,
        stichwoerter: [
          'Punktevergabe',
          'Punkte',
          'Einschätzung',
          'Schätzung',
          'Bewertung',
        ],
      ),
      krit(
        'Bei knappen Abständen kann eine kleine Änderung das Ergebnis kippen: Die Zahl täuscht Genauigkeit vor.',
        punkte: 2,
        stichwoerter: [
          'knapp',
          'kippen',
          'Scheingenauigkeit',
          'kleine Änderung',
          'Abstand',
        ],
      ),
      krit(
        'Werden Kriterien oder Gewichte nachträglich angepasst, lässt sich das Ergebnis steuern.',
        punkte: 2,
        stichwoerter: ['nachträglich', 'manipulieren', 'steuern', 'anpassen'],
      ),
    ],
    loesung:
        'Gewichte und Punkte beruhen auf persönlichen Einschätzungen: Wer sie festlegt, beeinflusst das Ergebnis. Bei einem Abstand von nur 0,2 Punkten kann schon ein leicht anderes Gewicht die Reihenfolge umdrehen. Das Ergebnis wirkt also genauer, als es ist.',
    explanation:
        'Je Schwäche 2 Punkte, höchstens 4. Die Nutzwertanalyse macht eine Entscheidung nachvollziehbar, nicht objektiv. Deshalb werden Kriterien und Gewichte festgelegt, bevor die Angebote bekannt sind.',
  ),
  lueckentext(
    'i1-wn-4',
    'w-nutzwert',
    scenario:
        'Für die Auswahl eines Beamers soll eine Entscheidungsmatrix mit Rangplätzen und ohne Gewichtung erstellt werden. Vorgabe: Rang 1 ist der beste Wert.',
    prompt: 'Vervollständige die Regeln für dieses Verfahren. (4 P.)',
    punkte: 4,
    text:
        'Je Kriterium erhält die beste Alternative den Rang {0}.\n'
        'Beim Kriterium Preis ist der {1} Wert der beste.\n'
        'Die Rangplätze jeder Alternative werden {2}.\n'
        'Es gewinnt die Alternative mit der {3} Rangsumme.',
    luecken: [
      wahl('1', ['3', '10'], 'So lautet die Vorgabe der Aufgabe.'),
      wahl('niedrigste', ['höchste', 'mittlere'], 'Bei Kosten ist klein gut.'),
      wahl('addiert', [
        'multipliziert',
        'gewichtet',
      ], 'Ohne Gewichtung wird nur addiert.'),
      wahl('kleinsten', [
        'größten',
        'mittleren',
      ], 'Rang 1 ist am besten, also gewinnt die kleinste Summe.'),
    ],
    explanation:
        'Ohne Gewichtung zählen alle Kriterien gleich: Du vergibst Ränge und addierst sie, die kleinste Rangsumme gewinnt. Lautet die Vorgabe umgekehrt (höchste Punktzahl für den besten Wert), gewinnt die größte Summe. Lies deshalb immer zuerst die Vorgabe.',
  ),

  // ================================================================== Make or Buy
  tabelle(
    'i1-wm-1',
    'w-makeorbuy',
    scenario:
        'Ein Autohaus braucht ein neues Dokumentenarchiv und vergleicht den Kauf eines eigenen Servers mit einem Cloud-Dienst über eine Nutzungsdauer von 3 Jahren.',
    table: [
      ['', 'Kauf', 'Cloud'],
      ['einmalig', 'Server 9.000 €, Lizenzen 2.400 €', 'Einrichtung 1.200 €'],
      ['laufend', 'Wartung 1.500 €/Jahr, Strom 600 €/Jahr', '520 €/Monat'],
    ],
    prompt: 'Berechne die Gesamtkosten beider Varianten über 3 Jahre. (6 P.)',
    punkte: 6,
    zeilen: [
      ['Position', 'Kauf (€)', 'Cloud (€)'],
      ['Einmalige Kosten', zahl(11400), '1.200'],
      ['Laufende Kosten je Jahr', zahl(2100), zahl(6240)],
      ['Laufende Kosten in 3 Jahren', zahl(6300), zahl(18720)],
      ['Gesamtkosten', zahl(17700), zahl(19920)],
    ],
    explanation:
        'Kauf: einmalig 9.000 + 2.400 = 11.400 €; laufend 1.500 + 600 = 2.100 € je Jahr, in 3 Jahren 6.300 €; gesamt 17.700 €\n'
        'Cloud: laufend 520 € × 12 = 6.240 € je Jahr, in 3 Jahren 18.720 €; gesamt 1.200 + 18.720 = 19.920 €\n'
        'Der Kauf ist über 3 Jahre um 2.220 € günstiger.',
  ),
  lueckentext(
    'i1-wm-2',
    'w-makeorbuy',
    scenario:
        'Eine Versicherungsagentur lässt Schadensmeldungen digital erfassen. Eigenentwicklung (Make): 6.000 € einmalig, danach 5 € je Vorgang. Dienstleister (Buy): 20 € je Vorgang, keine Fixkosten. Erwartet werden 250 Vorgänge.',
    prompt: 'Ermittle die kritische Menge und die günstigere Variante. (5 P.)',
    punkte: 5,
    text:
        'Ersparnis je Vorgang bei Make: {0} €\n'
        'Kritische Menge: {1} Vorgänge\n'
        'Kosten Make bei 250 Vorgängen: {2} €\n'
        'Kosten Buy bei 250 Vorgängen: {3} €\n'
        'Günstiger ist {4}.',
    luecken: [
      zahl(15, rationale: '20 € - 5 €.'),
      zahl(400, rationale: '6.000 € / 15 €.'),
      zahl(7250, rationale: '6.000 € + 250 × 5 €.'),
      zahl(5000, rationale: '250 × 20 €.'),
      wahl('Buy', ['Make', 'keine von beiden']),
    ],
    explanation:
        'Gleichsetzen: 6.000 + 5x = 20x, also x = 6.000 / 15 = 400 Vorgänge.\n'
        'Bei 250 Vorgängen: Make 6.000 € + 1.250 € = 7.250 €, Buy 250 × 20 € = 5.000 €.\n'
        '250 liegt unter der kritischen Menge, also ist Buy um 2.250 € günstiger.',
  ),
  markieren(
    'i1-wm-3',
    'w-makeorbuy',
    scenario:
        'Statt ein Helpdesk-System selbst zu entwickeln, prüft ein Maschinenbauer das Angebot eines Cloud-Anbieters.',
    code:
        'CloudDesk Helpdesk - Offer\n'
        'Price: EUR 29 per agent per month,\n'
        '       billed annually\n'
        'Minimum contract term: 12 months\n'
        'Setup fee: EUR 400 (one-time)\n'
        'Included: updates, daily backups,\n'
        '          e-mail support\n'
        'Not included: data migration,\n'
        '              on-site training\n'
        'Hosting: data centre in Frankfurt (EU)',
    prompt: 'Markiere alle Aussagen, die laut Angebot zutreffen. (3 P.)',
    punkte: 3,
    zeilen: [
      ja(
        'Die Einrichtung kostet einmalig 400 €.',
        '„Setup fee: EUR 400 (one-time)“.',
      ),
      nein(
        'Die Datenübernahme ist im Preis enthalten.',
        '„Not included: data migration“.',
      ),
      ja(
        'Der Vertrag läuft mindestens 12 Monate.',
        '„Minimum contract term: 12 months“.',
      ),
      nein(
        'Die Rechnung kommt jeden Monat.',
        '„billed annually“ heißt, dass jährlich abgerechnet wird.',
      ),
      ja(
        'Tägliche Datensicherungen sind enthalten.',
        '„Included: ... daily backups“.',
      ),
      nein(
        'Schulungen vor Ort sind enthalten.',
        '„Not included: ... on-site training“.',
      ),
    ],
    explanation:
        'Enthalten sind Updates, tägliche Backups und E-Mail-Support. Nicht enthalten sind Datenmigration und Schulung vor Ort. Diese Kosten gehören deshalb in den Make-or-Buy-Vergleich. Abgerechnet wird jährlich, die Mindestlaufzeit beträgt 12 Monate.',
  ),
  rechnen(
    'i1-wm-4',
    'w-makeorbuy',
    scenario:
        'Der Maschinenbauer will das Helpdesk-System für 8 Agenten buchen. Für die Datenübernahme aus dem Altsystem berechnet ein Dienstleister zusätzlich 900 €.',
    code:
        'CloudDesk Helpdesk - Offer\n'
        'Price: EUR 29 per agent per month,\n'
        '       billed annually\n'
        'Minimum contract term: 12 months\n'
        'Setup fee: EUR 400 (one-time)\n'
        'Not included: data migration,\n'
        '              on-site training',
    prompt: 'Berechne die Gesamtkosten der Buy-Variante im ersten Jahr.',
    punkte: 3,
    answer: 4084,
    unit: '€',
    explanation:
        'Lizenzen: 8 Agenten × 29 € × 12 Monate = 2.784 €\n'
        '+ Einrichtung (setup fee): 400 €\n'
        '+ Datenübernahme (nicht enthalten): 900 €\n'
        '= 4.084 € im ersten Jahr',
  ),

  // ===================================================== Break-even und Amortisation
  lueckentext(
    'i1-wb-1',
    'w-breakeven',
    scenario:
        'Ein Systemhaus bietet eine Tagesschulung zur IT-Sicherheit an. Jeder Teilnehmer zahlt 450 €. Je Teilnehmer fallen 150 € für Unterlagen und Verpflegung an. Raum und Trainer kosten 4.800 €.',
    prompt:
        'Berechne die Gewinnschwelle und den Gewinn bei 22 Teilnehmern. (4 P.)',
    punkte: 4,
    text:
        'Deckungsbeitrag je Teilnehmer: {0} €\n'
        'Break-even-Menge: {1} Teilnehmer\n'
        'Erlös im Break-even-Point: {2} €\n'
        'Gewinn bei 22 Teilnehmern: {3} €',
    luecken: [
      zahl(300, rationale: '450 € - 150 €.'),
      zahl(16, rationale: '4.800 € / 300 €.'),
      zahl(7200, rationale: '16 × 450 €.'),
      zahl(1800, rationale: '22 × 300 € - 4.800 €.'),
    ],
    explanation:
        'Deckungsbeitrag: 450 € - 150 € = 300 €\n'
        'Break-even-Menge: 4.800 € / 300 € = 16 Teilnehmer\n'
        'Erlös dort: 16 × 450 € = 7.200 € (= Kosten 4.800 € + 16 × 150 €)\n'
        'Gewinn bei 22: 22 × 300 € - 4.800 € = 1.800 €',
  ),
  tabelle(
    'i1-wb-2',
    'w-breakeven',
    scenario:
        'Eine Spedition investiert 24.000 € in ein digitales Dokumentenarchiv. Die jährlichen Rückflüsse (Einsparung abzüglich laufender Kosten) steigen nach dem ersten Jahr.',
    table: [
      ['Jahr', 'Rückfluss'],
      ['1', '6.000 €'],
      ['2', '9.000 €'],
      ['3', '9.000 €'],
    ],
    prompt:
        'Ermittle die kumulierten Rückflüsse und das Jahr, an dessen Ende die Investition amortisiert ist. (5 P.)',
    punkte: 5,
    zeilen: [
      ['Ende von Jahr', 'kumulierter Rückfluss (€)', 'noch offen (€)'],
      ['1', zahl(6000), zahl(18000)],
      ['2', zahl(15000), zahl(9000)],
      ['3', zahl(24000), '0'],
      ['Amortisiert am Ende von Jahr', zahl(3), ''],
    ],
    explanation:
        'Jahr 1: 6.000 €, offen 24.000 - 6.000 = 18.000 €\n'
        'Jahr 2: 6.000 + 9.000 = 15.000 €, offen 9.000 €\n'
        'Jahr 3: 15.000 + 9.000 = 24.000 €, offen 0 €\n'
        'Am Ende des 3. Jahres ist die Investition zurückgeflossen. Bei ungleichen Rückflüssen wird kumuliert statt geteilt.',
  ),
  freitext(
    'i1-wb-3',
    'w-breakeven',
    scenario:
        'Ein Softwarehaus stellt der Geschäftsführung die Kalkulation eines neuen Wartungspakets mit einem Break-even-Diagramm vor.',
    skizze: const GeradenDiagramm(
      xAchse: 'Menge',
      yAchse: 'Euro',
      xMax: 800,
      yMax: 48000,
      geraden: [Gerade('Erlös', 0, 60), Gerade('Gesamtkosten', 12000, 30)],
      punkte: [DiagrammPunkt(400, 24000, 'Break-even')],
    ),
    prompt:
        'Erläutere den Begriff Break-even-Point und beschreibe, was links und rechts davon gilt. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Menge, bei der der Erlös genau die Gesamtkosten deckt, also weder Gewinn noch Verlust',
        punkte: 2,
        stichwoerter: [
          'Gewinnschwelle',
          'deckt',
          'Kosten gedeckt',
          'Erlös gleich Kosten',
          'weder Gewinn noch Verlust',
          'Schnittpunkt',
        ],
      ),
      krit(
        'Links davon (kleinere Menge) entsteht Verlust.',
        stichwoerter: ['Verlust', 'Verluste', 'Verlustzone'],
      ),
      krit(
        'Rechts davon (größere Menge) entsteht Gewinn.',
        stichwoerter: [
          'Gewinnzone',
          'größeren Mengen',
          'rechts Gewinn',
          'darüber Gewinn',
        ],
      ),
    ],
    loesung:
        'Der Break-even-Point ist die Menge, bei der der Erlös genau die fixen und variablen Kosten deckt: hier 12.000 € / (60 € - 30 €) = 400 Stück. Bei kleineren Mengen liegt die Kostengerade über der Erlösgeraden (Verlust), bei größeren Mengen darunter (Gewinn).',
    explanation:
        'Erklärung 2 Punkte, je Seite 1 Punkt. Der senkrechte Abstand zwischen Erlös- und Kostengerade zeigt den Gewinn bzw. Verlust; im Schnittpunkt ist er null.',
  ),
  tabelle(
    'i1-wb-4',
    'w-breakeven',
    scenario:
        'Ein Logistiker vergleicht zwei Investitionen mit einer Nutzungsdauer von jeweils 6 Jahren. A kostet 20.000 € und bringt 5.000 € Rückfluss je Jahr. B kostet 12.000 € und bringt 4.000 € Rückfluss je Jahr.',
    prompt: 'Berechne die Kennzahlen beider Investitionen. (6 P.)',
    punkte: 6,
    zeilen: [
      ['Kennzahl', 'A', 'B'],
      ['Amortisationsdauer (Jahre)', zahl(4), zahl(3)],
      ['Gewinn über 6 Jahre (€)', zahl(10000), zahl(12000)],
      ['ROI über 6 Jahre (%)', zahl(50), zahl(100)],
    ],
    explanation:
        'Amortisation: A 20.000 / 5.000 = 4 Jahre, B 12.000 / 4.000 = 3 Jahre\n'
        'Gewinn: A 6 × 5.000 - 20.000 = 10.000 €, B 6 × 4.000 - 12.000 = 12.000 €\n'
        'ROI = Gewinn / Kapitaleinsatz: A 10.000 / 20.000 = 50 %, B 12.000 / 12.000 = 100 %\n'
        'B ist in allen drei Kennzahlen besser.',
  ),

  // ============================================================ Abnahme und Übergabe
  tabelle(
    'i1-aa-1',
    'a-abnahme',
    scenario:
        'Ein Möbelhändler nimmt seinen neuen Webshop ab. Der Auftragnehmer hat nach Pflichtenheft geliefert, bei der Prüfung fallen fünf Punkte auf.',
    prompt:
        'Stufe jede Feststellung ein und gib die Folge für die Abnahme an. (5 P.)',
    punkte: 5,
    zeilen: [
      ['Feststellung', 'Einstufung', 'Folge'],
      [
        'Tippfehler auf einer Hilfeseite',
        wahl('unwesentlicher Mangel', ['wesentlicher Mangel', 'kein Mangel']),
        wahl('Abnahme mit Vorbehalt', [
          'Abnahme verweigern',
          'Änderungsantrag',
        ]),
      ],
      [
        'Bestellungen werden nicht gespeichert',
        wahl('wesentlicher Mangel', ['unwesentlicher Mangel', 'kein Mangel']),
        wahl('Abnahme verweigern', [
          'Abnahme mit Vorbehalt',
          'Änderungsantrag',
        ]),
      ],
      [
        'Der Kunde wünscht nachträglich einen Dunkelmodus',
        wahl('kein Mangel', ['wesentlicher Mangel', 'unwesentlicher Mangel']),
        wahl('Änderungsantrag', [
          'Abnahme verweigern',
          'Abnahme mit Vorbehalt',
        ]),
      ],
      [
        'Der Rechnungsbetrag wird falsch berechnet',
        wahl('wesentlicher Mangel', ['unwesentlicher Mangel', 'kein Mangel']),
        'Abnahme verweigern',
      ],
      [
        'Logo im Ausdruck leicht unscharf',
        wahl('unwesentlicher Mangel', ['wesentlicher Mangel', 'kein Mangel']),
        'Abnahme mit Vorbehalt',
      ],
    ],
    explanation:
        'Wesentliche Mängel (Kernfunktion gestört) berechtigen zur Verweigerung der Abnahme. Unwesentliche Mängel tun das nicht. Sie werden mit einer Frist im Protokoll vorbehalten. Ein nicht vereinbarter Wunsch ist kein Mangel, sondern ein Änderungsantrag.',
  ),
  freitext(
    'i1-aa-2',
    'a-abnahme',
    scenario:
        'Ein Softwarehaus hat für einen Großhändler eine Lagerverwaltung als Werkvertrag entwickelt. Der Kunde unterschreibt das Abnahmeprotokoll.',
    prompt:
        'Nenne drei rechtliche Folgen, die mit der Abnahme eintreten. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Die Vergütung wird fällig.',
        stichwoerter: ['Vergütung', 'fällig', 'Zahlung', 'Schlussrechnung'],
      ),
      krit(
        'Die Verjährungsfrist für Mängelansprüche (Gewährleistung) beginnt.',
        stichwoerter: [
          'Verjährung',
          'Gewährleistung',
          'Mängelansprüche',
          'Frist beginnt',
        ],
      ),
      krit(
        'Die Beweislast für Mängel geht auf den Auftraggeber über.',
        stichwoerter: ['Beweislast', 'beweisen', 'Beweislastumkehr'],
      ),
      krit(
        'Die Gefahr geht auf den Auftraggeber über.',
        stichwoerter: ['Gefahrübergang', 'Gefahr', 'Risikoübergang'],
      ),
    ],
    loesung:
        'Mit der Abnahme wird die Vergütung fällig, die Verjährungsfrist für Mängelansprüche beginnt, und die Beweislast für Mängel geht auf den Auftraggeber über. Außerdem geht die Gefahr auf ihn über.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Weil die Abnahme so weitreichende Folgen hat, wird sie sorgfältig mit einem Protokoll dokumentiert.',
  ),
  lueckentext(
    'i1-aa-3',
    'a-abnahme',
    scenario:
        'Ein Krankenhaus plant die Einführung eines neuen Dienstplansystems und vergleicht vier Einführungsstrategien.',
    prompt: 'Setze die passenden Begriffe ein. (4 P.)',
    punkte: 4,
    text:
        'Bei der {0} wird das Altsystem zu einem festen Termin abgeschaltet: schnell, aber riskant.\n'
        'Beim {1} laufen altes und neues System eine Zeit lang gleichzeitig: sicher, aber doppelter Aufwand.\n'
        'Beim {2} arbeitet zunächst nur eine Station mit dem neuen System.\n'
        'Bei der {3} Einführung wird Modul für Modul umgestellt.',
    luecken: [
      wort(['Stichtagsumstellung'], 'Auch Big Bang genannt.'),
      wort(['Parallelbetrieb'], 'Rückfall auf das Altsystem bleibt möglich.'),
      wort(['Pilotbetrieb'], 'Ein Bereich erprobt unter Echtbedingungen.'),
      wort(['stufenweisen'], 'Schritt für Schritt, Modul für Modul.'),
    ],
    wortbank: ['Probeabnahme', 'Testbetrieb'],
    explanation:
        'Bei der Stichtagsumstellung (Big Bang) wechselt alles auf einmal. Im Parallelbetrieb laufen beide Systeme gleichzeitig. Im Pilotbetrieb startet ein Bereich komplett, die anderen folgen nach der Auswertung. Stufenweise heißt: Modul für Modul.',
  ),
  reihenfolge(
    'i1-aa-4',
    'a-abnahme',
    scenario:
        'Ein IT-Dienstleister hat bei einem Steuerbüro ein neues Dokumentenmanagementsystem eingerichtet und will das Projekt abschließen.',
    prompt: 'Bringe die Schritte der Abnahme in die richtige Reihenfolge.',
    punkte: 3,
    items: [
      'Fertigstellung melden und Abnahmetermin vereinbaren',
      'Ergebnis anhand der Abnahmekriterien prüfen',
      'Festgestellte Mängel im Abnahmeprotokoll festhalten',
      'Abnahme erklären und Protokoll unterschreiben',
      'Schlussrechnung stellen',
    ],
    explanation:
        'Erst wird die Fertigstellung gemeldet, dann gegen die vereinbarten Kriterien geprüft. Mängel kommen ins Protokoll, danach erklärt der Auftraggeber die Abnahme. Erst mit der Abnahme wird die Vergütung fällig. Deshalb steht die Schlussrechnung am Ende.',
  ),

  // ====================================================== Abschlussbericht und Soll-Ist
  tabelle(
    'i1-ab-1',
    'a-bericht',
    scenario:
        'Für den Abschlussbericht eines Migrationsprojekts liegen die Plan- und Ist-Werte vor. Unterschreitungen werden mit Minuszeichen angegeben.',
    prompt: 'Berechne die absolute und die relative Abweichung. (6 P.)',
    punkte: 6,
    zeilen: [
      ['Größe', 'Soll', 'Ist', 'Abw. absolut', 'Abw. in %'],
      ['Kosten (€)', '40.000', '46.000', zahl(6000), zahl(15)],
      ['Dauer (Wochen)', '16', '20', zahl(4), zahl(25)],
      ['Aufwand (PT)', '250', '240', zahl(-10), zahl(-4)],
    ],
    explanation:
        'Abweichung absolut = Ist - Soll, relativ = Abweichung / Soll × 100 %.\n'
        'Kosten: 46.000 - 40.000 = 6.000 €; 6.000 / 40.000 = 15 %\n'
        'Dauer: 20 - 16 = 4 Wochen; 4 / 16 = 25 %\n'
        'Aufwand: 240 - 250 = -10 PT; -10 / 250 = -4 %\n'
        'Bezugsgröße ist immer das Soll.',
  ),
  freitext(
    'i1-ab-2',
    'a-bericht',
    scenario:
        'Nach der Einführung eines Ticketsystems soll die Projektleiterin den Abschlussbericht für den Lenkungsausschuss schreiben.',
    prompt: 'Nenne vier Inhalte eines Projektabschlussberichts. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Überblick: Auftrag, Ziele und Beteiligte',
        stichwoerter: ['Auftrag', 'Ziele', 'Beteiligte', 'Ausgangslage'],
      ),
      krit(
        'Ergebnis: erreichte und verfehlte Ziele',
        stichwoerter: ['Ergebnis', 'Zielerreichung', 'erreicht'],
      ),
      krit(
        'Soll-Ist-Vergleich von Leistung, Terminen und Kosten',
        stichwoerter: ['Soll-Ist', 'Vergleich', 'Termine', 'Kosten'],
      ),
      krit(
        'Abweichungen mit Ursachen und Folgen',
        stichwoerter: ['Abweichung', 'Ursache', 'Begründung'],
      ),
      krit(
        'Offene Punkte: Restarbeiten, Restrisiken, Übergabe',
        stichwoerter: ['offene Punkte', 'Restarbeiten', 'Übergabe'],
      ),
      krit(
        'Erfahrungen: Lessons Learned und Empfehlungen',
        stichwoerter: ['Lessons Learned', 'Erfahrungen', 'Empfehlung'],
      ),
    ],
    loesung:
        'Der Abschlussbericht enthält einen Überblick (Auftrag, Ziele, Beteiligte), das Ergebnis, den Soll-Ist-Vergleich von Leistung, Terminen und Kosten mit begründeten Abweichungen, die offenen Punkte sowie die Erfahrungen und Empfehlungen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Der Bericht beantwortet für den Auftraggeber die Frage „Was ist herausgekommen?“. Kern ist der begründete Soll-Ist-Vergleich.',
  ),
  markieren(
    'i1-ab-3',
    'a-bericht',
    scenario:
        'Im Entwurf eines Abschlussberichts stehen sechs Abweichungen. Die relative Abweichung soll auf das Soll bezogen sein, Unterschreitungen tragen ein Minuszeichen.',
    prompt: 'Markiere alle Zeilen mit falscher Prozentangabe. (3 P.)',
    punkte: 3,
    zeilen: [
      nein(
        'Kosten: Soll 50.000 €, Ist 55.000 €, Abweichung +10 %',
        '5.000 / 50.000 = 10 %. Richtig.',
      ),
      ja(
        'Aufwand: Soll 200 PT, Ist 180 PT, Abweichung -11,1 %',
        'Falsch auf das Ist bezogen. Richtig: -20 / 200 = -10 %.',
      ),
      nein(
        'Dauer: Soll 10 Wochen, Ist 12 Wochen, Abweichung +20 %',
        '2 / 10 = 20 %. Richtig.',
      ),
      ja(
        'Lizenzen: Soll 8.000 €, Ist 6.000 €, Abweichung +25 %',
        'Das Ist liegt unter dem Soll: -2.000 / 8.000 = -25 %.',
      ),
      ja(
        'Schulung: Soll 4.000 €, Ist 5.000 €, Abweichung +20 %',
        'Falsch auf das Ist bezogen. Richtig: 1.000 / 4.000 = +25 %.',
      ),
      nein(
        'Hardware: Soll 12.000 €, Ist 12.600 €, Abweichung +5 %',
        '600 / 12.000 = 5 %. Richtig.',
      ),
    ],
    explanation:
        'Relative Abweichung = (Ist - Soll) / Soll × 100 %. Typische Fehler: durch das Ist statt durch das Soll teilen (Aufwand, Schulung) und das Vorzeichen verdrehen (Lizenzen).',
  ),
  lueckentext(
    'i1-ab-4',
    'a-bericht',
    scenario:
        'Ein Systemhaus hat ein Projekt zum Festpreis von 22.000 € angeboten. Kalkuliert waren 300 Stunden zu je 60 € Selbstkosten. Tatsächlich wurden 345 Stunden gebucht.',
    prompt: 'Erstelle die Nachkalkulation. (5 P.)',
    punkte: 5,
    text:
        'Geplante Kosten: {0} €\n'
        'Tatsächliche Kosten: {1} €\n'
        'Abweichung: {2} €, das sind {3} %\n'
        'Tatsächlicher Gewinn: {4} €',
    luecken: [
      zahl(18000, rationale: '300 h × 60 €.'),
      zahl(20700, rationale: '345 h × 60 €.'),
      zahl(2700, rationale: '20.700 € - 18.000 €.'),
      zahl(15, rationale: '2.700 / 18.000 × 100 %.'),
      zahl(1300, rationale: '22.000 € - 20.700 €.'),
    ],
    explanation:
        'Soll: 300 h × 60 € = 18.000 €\n'
        'Ist: 345 h × 60 € = 20.700 €\n'
        'Abweichung: 2.700 €, das sind 2.700 / 18.000 = 15 %\n'
        'Gewinn: geplant 22.000 - 18.000 = 4.000 €, tatsächlich 22.000 - 20.700 = 1.300 €\n'
        'Beim Festpreis trägt der Auftragnehmer den Mehraufwand.',
  ),

  // ============================================================== Lessons Learned
  freitext(
    'i1-al-1',
    'a-lessons',
    scenario:
        'Nach einem verspäteten Rollout lädt die Projektleiterin das Team zu einem Lessons-Learned-Workshop ein.',
    prompt:
        'Beschreibe zwei Regeln, die den Workshop erfolgreich machen. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Keine Schuldzuweisungen: Es geht um Ursachen und Verbesserungen.',
        punkte: 2,
        stichwoerter: ['Schuld', 'Schuldzuweisung', 'Vorwürfe', 'sachlich'],
      ),
      krit(
        'Auch Erfolge sammeln: Was gut lief, soll beibehalten werden.',
        punkte: 2,
        stichwoerter: ['Erfolge', 'positiv', 'gut lief', 'beibehalten'],
      ),
      krit(
        'Aus jeder Erfahrung eine konkrete Empfehlung ableiten.',
        punkte: 2,
        stichwoerter: ['Empfehlung', 'konkret', 'Maßnahme ableiten'],
      ),
      krit(
        'Zeitnah durchführen, solange die Erinnerung frisch ist.',
        punkte: 2,
        stichwoerter: ['zeitnah', 'frisch', 'direkt nach', 'früh'],
      ),
      krit(
        'Ergebnisse dokumentieren und zentral auffindbar ablegen.',
        punkte: 2,
        stichwoerter: [
          'dokumentieren',
          'Wiki',
          'ablegen',
          'auffindbar',
          'zugänglich',
        ],
      ),
    ],
    loesung:
        'Es werden keine Schuldigen gesucht, sondern Ursachen und Verbesserungen, sonst schweigt das Team. Außerdem wird aus jeder Erfahrung eine konkrete Empfehlung abgeleitet und so abgelegt, dass künftige Projektteams sie finden.',
    explanation:
        'Je Regel 2 Punkte, höchstens 4. Lessons Learned blicken nach vorn: Sie fragen „Was lernen wir daraus?“ und nicht „Wer war schuld?“.',
  ),
  paare(
    'i1-al-2',
    'a-lessons',
    scenario:
        'Ein Entwicklungsteam wertet sein Projekt aus und nutzt dabei gängige Begriffe der Erfahrungssicherung.',
    prompt: 'Ordne jedem Begriff seine Bedeutung zu. (5 P.)',
    punkte: 5,
    paare: [
      paar('Start', 'Künftig neu einführen'),
      paar('Stop', 'Künftig weglassen'),
      paar('Continue', 'Bewährtes beibehalten'),
      paar('Retrospektive', 'Rückblick nach jedem Sprint'),
      paar('Wissensdatenbank', 'Erfahrungen zentral ablegen'),
    ],
    explanation:
        '„Start, Stop, Continue“ übersetzt Erfahrungen direkt in Handlungen. Die Retrospektive ist die projektbegleitende Form in Scrum. Wirksam werden Lessons Learned erst, wenn sie zentral und auffindbar abgelegt sind.',
  ),
  lueckentext(
    'i1-al-3',
    'a-lessons',
    scenario:
        'Im Workshop soll eine Erfahrung so festgehalten werden, dass ein fremdes Projektteam danach handeln kann.',
    prompt:
        'Baue die Lesson aus Situation, Ursache und Empfehlung zusammen. (3 P.)',
    punkte: 3,
    text: 'Situation: {0}\nUrsache: {1}\nEmpfehlung: {2}',
    luecken: [
      wahl('Der Go-live verschob sich um zwei Wochen.', [
        'Die Firewall-Freigabe wurde zu spät beantragt.',
        'Freigaben schon beim Projektstart beantragen.',
      ], 'Was ist passiert?'),
      wahl(
        'Die Firewall-Freigabe wurde zu spät beantragt.',
        [
          'Der Go-live verschob sich um zwei Wochen.',
          'Freigaben schon beim Projektstart beantragen.',
        ],
        'Warum ist es passiert?',
      ),
      wahl(
        'Freigaben schon beim Projektstart beantragen.',
        [
          'Der Go-live verschob sich um zwei Wochen.',
          'Die Firewall-Freigabe wurde zu spät beantragt.',
        ],
        'Was tun wir künftig anders?',
      ),
    ],
    explanation:
        'Eine brauchbare Lesson nennt Situation, Ursache und Empfehlung. Sie ist konkret, kommt ohne Schuldzuweisung aus und ist für andere Projekte verständlich. „Die Kommunikation muss besser werden“ wäre zu vage.',
  ),
];
