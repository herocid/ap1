import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 01, Teil 2: Struktur und Termine, Risiken,
/// Wirtschaftlichkeit, Abschluss.
final List<Nugget> nuggetsA01Planung = [
  // ========================================================= Projektstrukturplan
  konzept(
    'n-tp-1',
    't-psp',
    'Der Projektstrukturplan',
    'Der Projektstrukturplan (PSP, englisch Work Breakdown Structure) zerlegt das gesamte Projekt hierarchisch in Teilaufgaben und Arbeitspakete. Er ist die Grundlage aller weiteren Pläne: Ohne vollständige Aufgabenliste lassen sich weder Termine noch Kosten planen.',
    points: [
      'Überblick über den gesamten Projektumfang',
      'Grundlage für Aufwandsschätzung, Kosten- und Terminplanung',
      'klare Verantwortung: jedes Arbeitspaket hat eine zuständige Person',
      'Kontrolle: Nichts wird vergessen, nichts doppelt gemacht',
    ],
  ),
  konzept(
    'n-tp-2',
    't-psp',
    'Die Ebenen des PSP',
    'Ein PSP ist ein Baum: oben das Projekt, darunter Teilaufgaben, ganz unten die Arbeitspakete. Jede Ebene verfeinert die darüberliegende.',
    table: [
      ['Ebene', 'Element', 'Weiter zerlegt?'],
      ['0', 'Projekt (Wurzel)', 'ja'],
      ['1 bis vorletzte', 'Teilprojekt, Teilaufgabe', 'ja'],
      ['unterste', 'Arbeitspaket', 'nein'],
    ],
    points: [
      '100-%-Regel: Die Elemente einer Ebene decken zusammen den vollen Umfang des übergeordneten Elements ab - nicht mehr und nicht weniger.',
    ],
  ),
  vergleich(
    'n-tp-3',
    't-psp',
    'Drei Arten zu gliedern',
    'Auf jeder Ebene wird nach einem Prinzip gegliedert. Welches man wählt, hängt davon ab, was im Projekt am besten trennt.',
    [
      ['Gliederung', 'Leitfrage', 'Beispiel'],
      [
        'objektorientiert',
        'Woraus besteht das Ergebnis?',
        'Server, Clients, Netzwerk',
      ],
      [
        'funktionsorientiert',
        'Welche Tätigkeiten fallen an?',
        'Beschaffen, Installieren, Testen',
      ],
      [
        'phasenorientiert',
        'In welcher Phase passiert es?',
        'Analyse, Entwurf, Umsetzung',
      ],
    ],
    points: [
      'Mischformen sind üblich: etwa Ebene 1 nach Phasen, Ebene 2 nach Objekten.',
      'Innerhalb einer Ebene bleibt man bei einem Prinzip.',
    ],
  ),
  skizze(
    'n-tp-4',
    't-psp',
    'Ein PSP, objektorientiert',
    'Eine neue Filiale bekommt ihre IT-Ausstattung. Gegliedert wird nach den Bestandteilen des Ergebnisses. Die Zahlen unter den Namen sind die PSP-Codes.',
    const BaumDiagramm(
      BaumKnoten('IT-Ausstattung Filiale', [
        BaumKnoten('Hardware', [
          BaumKnoten('Server', [], '1.1'),
          BaumKnoten('Clients', [], '1.2'),
        ], '1'),
        BaumKnoten('Software', [
          BaumKnoten('Betriebssysteme', [], '2.1'),
          BaumKnoten('Office-Paket', [], '2.2'),
        ], '2'),
        BaumKnoten('Netzwerk', [
          BaumKnoten('Verkabelung', [], '3.1'),
          BaumKnoten('WLAN', [], '3.2'),
        ], '3'),
      ], 'Projekt'),
    ),
    points: [
      'Ebene 1: die Teilaufgaben 1 bis 3',
      'Ebene 2: Arbeitspakete wie 1.1 „Server“ - sie werden nicht weiter zerlegt',
    ],
  ),
  skizze(
    'n-tp-5',
    't-psp',
    'Ein PSP, phasenorientiert',
    'Ein Webshop wird entwickelt. Hier bilden die Projektphasen die erste Ebene, darunter stehen die Arbeitspakete jeder Phase.',
    const BaumDiagramm(
      BaumKnoten('Webshop', [
        BaumKnoten('Analyse', [
          BaumKnoten('Ist-Analyse', [], '1.1'),
          BaumKnoten('Pflichtenheft', [], '1.2'),
        ], '1'),
        BaumKnoten('Entwurf', [
          BaumKnoten('Datenmodell', [], '2.1'),
          BaumKnoten('Oberfläche', [], '2.2'),
        ], '2'),
        BaumKnoten('Umsetzung', [
          BaumKnoten('Programmierung', [], '3.1'),
          BaumKnoten('Test', [], '3.2'),
        ], '3'),
        BaumKnoten('Einführung', [
          BaumKnoten('Schulung', [], '4.1'),
          BaumKnoten('Go-live', [], '4.2'),
        ], '4'),
      ], 'Projekt'),
    ),
    points: [
      'Funktionsorientiert sähe Ebene 1 zum Beispiel so aus: Planen, Programmieren, Testen, Schulen.',
    ],
  ),
  konzept(
    'n-tp-6',
    't-psp',
    'PSP-Codes',
    'Jedes Element bekommt einen eindeutigen Code, der seine Position im Baum verrät. Über diesen Code werden Aufwände, Kosten und Termine später dem richtigen Arbeitspaket zugeordnet.',
    table: [
      ['Codierung', 'Beispiel', 'Merkmal'],
      ['numerisch', '2.1.3', 'Ziffern je Ebene, mit Punkt getrennt'],
      ['alphanumerisch', 'B.1.3', 'Buchstaben und Ziffern gemischt'],
    ],
    points: [
      '2.1.3 heißt: Teilaufgabe 2, darin Teilaufgabe 1, darin Arbeitspaket 3.',
      'Die Anzahl der Stellen zeigt die Ebene: 2 liegt auf Ebene 1, 2.1.3 auf Ebene 3.',
    ],
  ),
  konzept(
    'n-tp-7',
    't-psp',
    'Das Arbeitspaket beschreiben',
    'Das Arbeitspaket ist die kleinste Einheit im PSP. Damit es geplant und vergeben werden kann, hält man es in einer Arbeitspaketbeschreibung fest.',
    table: [
      ['Feld', 'Beispiel'],
      ['PSP-Code, Name', '3.2 Test Webshop'],
      ['Verantwortlich', 'L. Braun'],
      ['Ergebnis', 'Testprotokoll, alle Tests bestanden'],
      ['Voraussetzung', '3.1 abgeschlossen'],
      ['Aufwand', '6 Personentage'],
      ['Termin', 'KW 18 bis KW 19'],
    ],
    points: [
      'Ein gutes Arbeitspaket hat ein prüfbares Ergebnis, genau eine verantwortliche Person, einen schätzbaren Aufwand und zuordenbare Kosten.',
    ],
  ),
  vergleich(
    'n-tp-8',
    't-psp',
    'Top-down oder Bottom-up?',
    'Ein PSP kann von oben zerlegt oder von unten zusammengesetzt werden.',
    [
      ['Vorgehen', 'So geht es', 'Geeignet, wenn'],
      [
        'Top-down',
        'Projekt schrittweise zerlegen',
        'das Projekt gut bekannt ist',
      ],
      [
        'Bottom-up',
        'Tätigkeiten sammeln, dann gruppieren',
        'das Projekt neuartig ist',
      ],
    ],
    points: [
      'In der Praxis kombiniert: grob top-down gliedern, dann im Team Tätigkeiten sammeln und einsortieren.',
    ],
  ),
  ablauf(
    'n-tp-9',
    't-psp',
    'Einen PSP erstellen',
    'So gehst du vor - auch in einer Prüfungsaufgabe, in der ein PSP zu zeichnen ist.',
    [
      'Projektgegenstand und Ziel aus dem Projektauftrag klären',
      'Gliederungsprinzip für die erste Ebene wählen',
      'Teilaufgaben so weit zerlegen, bis Arbeitspakete verantwortbar und schätzbar sind',
      'Vollständigkeit mit der 100-%-Regel prüfen',
      'PSP-Codes vergeben',
      'Arbeitspakete beschreiben: Ergebnis, Verantwortung, Aufwand',
    ],
  ),
  ablauf(
    'n-tp-10',
    't-psp',
    'Vom PSP zum Terminplan',
    'Der PSP steht am Anfang einer Planungskette.',
    [
      'Projektstrukturplan mit allen Arbeitspaketen',
      'Aufwand und Dauer je Arbeitspaket schätzen',
      'Abhängigkeiten zwischen den Paketen festlegen',
      'Netzplan rechnen: Dauer, Puffer, kritischer Pfad',
      'Gantt-Diagramm für die Kommunikation erstellen',
    ],
  ),
  falle(
    'n-tp-11',
    't-psp',
    'Der PSP kennt keine Reihenfolge',
    'Ein Projektstrukturplan zeigt, WAS zu tun ist - nicht wann und in welcher Reihenfolge. Termine und Abhängigkeiten kommen erst im Netzplan oder Gantt-Diagramm dazu.',
    points: [
      'keine Pfeile und keine Datumsangaben im PSP',
      'Arbeitspakete sind Arbeit mit Aufwand - keine Meilensteine mit Dauer 0',
      'nicht zwei Gliederungsprinzipien auf derselben Ebene mischen',
    ],
  ),
  merke(
    'n-tp-12',
    't-psp',
    'Merksatz',
    'Der PSP ist das Fundament der Projektplanung: Was hier fehlt, fehlt später in jedem Plan.',
    satz:
        'Der PSP beantwortet WAS, der Netzplan WANN, die Ressourcenplanung WER.',
  ),

  // ================================================ Gantt-Diagramm und Meilensteine
  konzept(
    'n-tg-1',
    't-gantt',
    'Das Gantt-Diagramm',
    'Im Gantt-Diagramm (Balkenplan) ist jeder Vorgang ein Balken auf einer Zeitachse. Lage und Länge des Balkens zeigen Start, Ende und Dauer. Es ist leicht verständlich und deshalb das Standardwerkzeug, um Terminpläne mit Stakeholdern zu besprechen.',
    points: [
      'waagerecht: die Zeitachse in Tagen, Wochen oder Kalenderwochen',
      'senkrecht: die Vorgänge bzw. Arbeitspakete',
      'Balken: Lage = Start und Ende, Länge = Dauer',
      'Raute: Meilenstein mit Dauer 0',
    ],
  ),
  beispiel(
    'n-tg-2',
    't-gantt',
    'Ein Gantt-Diagramm aus der Vorgangsliste',
    'Ein Schulungsraum wird eingerichtet. Zeichne den Balkenplan. Jeder Vorgang beginnt, sobald alle seine Vorgänger fertig sind.',
    table: [
      ['Vorgang', 'Dauer', 'Vorgänger'],
      ['A Anforderungen', '3 Tage', '-'],
      ['B Hardware beschaffen', '5 Tage', 'A'],
      ['C Software vorbereiten', '4 Tage', 'A'],
      ['D Installation', '3 Tage', 'B, C'],
      ['E Test', '2 Tage', 'D'],
    ],
    schritte: [
      'A hat keinen Vorgänger: Start bei 0, Ende bei 0 + 3 = 3.',
      'B und C folgen auf A, starten also bei 3. B endet bei 3 + 5 = 8, C bei 3 + 4 = 7.',
      'D braucht B und C: Start beim späteren Ende, also bei 8. Ende 8 + 3 = 11.',
      'E folgt auf D: Start 11, Ende 11 + 2 = 13. Dort liegt der Meilenstein „Raum abgenommen“.',
      'C könnte 8 - 7 = 1 Tag später enden, ohne D zu verzögern - C hat 1 Tag Puffer, alle anderen keinen.',
    ],
    ergebnis:
        'Projektdauer 13 Tage; kritisch sind A, B, D und E, C hat 1 Tag Puffer.',
    skizze: const GanttDiagramm([
      GanttVorgang('A Anforderungen', 0, 3, kritisch: true),
      GanttVorgang('B Hardware', 3, 5, kritisch: true),
      GanttVorgang('C Software', 3, 4),
      GanttVorgang('D Installation', 8, 3, kritisch: true),
      GanttVorgang('E Test', 11, 2, kritisch: true),
      GanttVorgang('Raum abgenommen', 13, 0, kritisch: true),
    ], einheit: 'Tag'),
  ),
  konzept(
    'n-tg-3',
    't-gantt',
    'Was du ablesen kannst - und was nicht',
    'Im Balkenplan siehst du sofort, was wann läuft und was parallel passiert. Viele Werkzeuge färben kritische Vorgänge ein und zeigen den Fortschritt als gefüllten Balkenanteil.',
    points: [
      'Parallelität: B und C laufen gleichzeitig',
      'Fortschritt: Ist-Balken oder Heute-Linie zeigen einen Verzug',
      'Abhängigkeiten nur, wenn Pfeile eingezeichnet sind',
      'Puffer nur, wenn er eigens dargestellt wird - berechnet wird er im Netzplan',
    ],
  ),
  vergleich(
    'n-tg-4',
    't-gantt',
    'Anordnungsbeziehungen',
    'Wie zwei Vorgänge voneinander abhängen, beschreibt die Anordnungsbeziehung. Der Normalfall ist die Normalfolge: B beginnt, wenn A endet.',
    [
      ['Beziehung', 'Bedeutung', 'Beispiel'],
      [
        'Normalfolge (EA)',
        'Ende A -> Anfang B',
        'erst installieren, dann testen',
      ],
      [
        'Anfangsfolge (AA)',
        'Anfang A -> Anfang B',
        'Verkabelung und Doku beginnen gemeinsam',
      ],
      [
        'Endfolge (EE)',
        'Ende A -> Ende B',
        'Test und Testbericht enden zusammen',
      ],
      [
        'Sprungfolge (AE)',
        'Anfang A -> Ende B',
        'Altsystem (B) läuft, bis das neue System (A) startet',
      ],
    ],
    points: [
      'Ein Zeitabstand ist möglich, zum Beispiel Normalfolge plus 2 Tage Lieferzeit.',
    ],
  ),
  vergleich(
    'n-tg-5',
    't-gantt',
    'Gantt oder Netzplan?',
    'Beide Darstellungen ergänzen sich: Mit dem Netzplan wird gerechnet, mit dem Gantt-Diagramm kommuniziert.',
    [
      ['', 'Gantt-Diagramm', 'Netzplan'],
      [
        'Stärke',
        'anschaulich, Zeitbezug auf einen Blick',
        'Abhängigkeiten, Puffer, kritischer Pfad',
      ],
      [
        'Schwäche',
        'Puffer kaum erkennbar',
        'ohne Zeitachse weniger anschaulich',
      ],
      ['Einsatz', 'Statusbericht, Abstimmung', 'Berechnung und Planung'],
    ],
  ),
  konzept(
    'n-tg-6',
    't-gantt',
    'Meilensteine',
    'Ein Meilenstein ist ein Ereignis mit der Dauer 0, das ein wichtiges Zwischenergebnis markiert - oft das Ende einer Phase. An Meilensteinen wird entschieden, ob das Projekt wie geplant weiterläuft.',
    points: [
      'im Gantt-Diagramm als Raute auf der Zeitachse',
      'verbraucht weder Zeit noch Ressourcen',
      'typisch: Projektauftrag unterschrieben, Pflichtenheft freigegeben, Abnahme erteilt',
    ],
  ),
  vergleich(
    'n-tg-7',
    't-gantt',
    'Meilensteine richtig formulieren',
    'Ein Meilenstein ist erreicht oder nicht - dazwischen gibt es nichts. Formuliere ihn deshalb als prüfbares Ergebnis, nicht als Tätigkeit.',
    [
      ['Schlecht (Tätigkeit)', 'Gut (prüfbares Ereignis)'],
      ['Pflichtenheft schreiben', 'Pflichtenheft vom Kunden freigegeben'],
      ['Testphase', 'Systemtest bestanden, Protokoll liegt vor'],
      ['Server fast fertig', 'Server betriebsbereit übergeben'],
    ],
  ),
  skizze(
    'n-tg-8',
    't-gantt',
    'Die Meilensteintrendanalyse',
    'Die Meilensteintrendanalyse (MTA) trägt bei jedem Berichtstermin (waagerecht) ein, wann ein Meilenstein voraussichtlich erreicht wird (senkrecht). Erreicht ist er, wenn seine Linie die Diagonale trifft.',
    const GeradenDiagramm(
      xAchse: 'Berichtswoche',
      yAchse: 'Prognose (Woche)',
      xMax: 8,
      yMax: 16,
      geraden: [
        Gerade('Diagonale', 0, 1),
        Gerade('M1 hält', 8, 0),
        Gerade('M2 verschiebt sich', 10, 0.5),
      ],
      punkte: [DiagrammPunkt(8, 8, 'M1 erreicht')],
    ),
    points: [
      'M1 verläuft waagerecht: Der Termin Woche 8 hält, in Woche 8 trifft die Linie die Diagonale.',
      'M2 steigt je Berichtswoche um eine halbe Woche: Verzug - geplant war Woche 10, in Berichtswoche 8 lautet die Prognose Woche 14.',
    ],
  ),
  vergleich(
    'n-tg-9',
    't-gantt',
    'Verläufe in der MTA lesen',
    'Die MTA ist ein Frühwarnsystem: Sie zeigt einen Trend, bevor der Termin tatsächlich platzt. Warum sich etwas verschiebt, zeigt sie nicht.',
    [
      ['Verlauf', 'Bedeutung'],
      ['waagerecht', 'Termin hält'],
      ['steigend', 'Termin rutscht nach hinten (Verzug)'],
      ['fallend', 'Meilenstein wird früher erreicht'],
      ['Zickzack', 'unsichere, schwankende Planung'],
    ],
  ),
  falle(
    'n-tg-10',
    't-gantt',
    'Ein Meilenstein ist keine Aufgabe',
    'Meilensteine haben keine Dauer und verbrauchen keine Ressourcen. Wer „Test durchführen“ als Meilenstein einträgt, verwechselt ihn mit einem Vorgang. Richtig wäre „Test abgeschlossen, Protokoll liegt vor“.',
  ),
  falle(
    'n-tg-11',
    't-gantt',
    'Zeitpunkt oder Tag?',
    'In Balkenplänen und Netzplänen ist der Start ein Zeitpunkt: Start 3 heißt „nach dem Ende von Tag 3“. Ein Vorgang ab Zeitpunkt 3 mit 5 Tagen Dauer endet deshalb bei 8, nicht bei 7. Wer Kästchen abzählt statt zu rechnen, verschiebt jeden Balken um einen Tag.',
    merksatz:
        'Ende = Start + Dauer. Der Nachfolger startet beim spätesten Ende seiner Vorgänger.',
  ),
  merke(
    'n-tg-12',
    't-gantt',
    'Merksatz',
    'Balkenplan, Netzplan und Meilensteine haben jeweils ihre eigene Aufgabe in der Terminplanung.',
    satz:
        'Mit dem Netzplan rechnen, mit dem Gantt-Diagramm kommunizieren, mit Meilensteinen steuern.',
  ),

  // ================================================== Ressourcen und Aufwand
  konzept(
    'n-tr-1',
    't-ressourcen',
    'Ressourcen planen',
    'Ressourcen sind alles, was ein Arbeitspaket zum Erledigen braucht. Die Ressourcenplanung prüft, ob sie zur richtigen Zeit in ausreichender Menge verfügbar sind: Bedarf ermitteln, Verfügbarkeit ermitteln, beides abgleichen.',
    points: [
      'Personal: Entwicklerinnen, Admins, Fachbereich',
      'Sachmittel: Hardware, Testumgebung, Räume, Lizenzen',
      'Finanzmittel: Budget für Einkauf und externe Leistungen',
    ],
  ),
  vergleich(
    'n-tr-2',
    't-ressourcen',
    'Aufwand, Dauer, Kapazität',
    'Die Begriffe werden im Alltag vermischt, in der Prüfung aber streng getrennt.',
    [
      ['Begriff', 'Bedeutung', 'Einheit'],
      ['Aufwand', 'Menge an Arbeit', 'Personentage (PT)'],
      ['Dauer', 'Zeitspanne im Kalender', 'Arbeitstage (AT)'],
      ['Kapazität', 'verfügbare Arbeit je Zeitraum', 'PT pro Tag oder Monat'],
    ],
    points: [
      '1 PT ist die Arbeit einer Person an einem vollen Arbeitstag, meist 8 Stunden.',
      '10 PT können 10 Tage für eine Person oder 5 Tage für zwei Personen sein.',
    ],
  ),
  konzept(
    'n-tr-3',
    't-ressourcen',
    'Brutto- und Nettokapazität',
    'Niemand arbeitet an allen Arbeitstagen voll im Projekt. Von der Bruttokapazität gehen Urlaub, Krankheit, Schulungen und Linienaufgaben ab - übrig bleibt die Nettokapazität.',
    points: [
      'Verfügbarkeitsgrad: Anteil der Arbeitszeit, der dem Projekt gehört, zum Beispiel 60 %',
      'erst abwesende Tage abziehen, dann mit dem Verfügbarkeitsgrad multiplizieren',
    ],
  ),
  beispiel(
    'n-tr-4',
    't-ressourcen',
    'Teamkapazität für einen Monat',
    'Der Mai hat 20 Arbeitstage. Wie viele Personentage kann das Team in diesem Monat ins Projekt einbringen?',
    table: [
      ['Person', 'Arbeitstage', 'Verfügbarkeit'],
      ['Ahmet', '20', '100 %'],
      ['Birte', '20', '50 %'],
      ['Chris', '20 - 5 Urlaub = 15', '80 %'],
    ],
    schritte: [
      'Ahmet: 20 AT × 1,0 = 20 PT',
      'Birte: 20 AT × 0,5 = 10 PT',
      'Chris: erst den Urlaub abziehen, dann 15 AT × 0,8 = 12 PT',
      'Summe: 20 PT + 10 PT + 12 PT = 42 PT',
    ],
    ergebnis: 'Nettokapazität im Mai: 42 Personentage',
  ),
  formel(
    'n-tr-5',
    't-ressourcen',
    'Dauer, Aufwand und Personen',
    'Aus einer Grundformel lässt sich jede der drei Größen berechnen - je nachdem, was in der Aufgabe gesucht ist.',
    'Dauer    = Aufwand / (Personen × Verfügbarkeit)\n'
        'Aufwand  = Dauer × Personen × Verfügbarkeit\n'
        'Personen = Aufwand / (Dauer × Verfügbarkeit)',
    points: [
      'Aufwand in PT, Dauer in AT, Verfügbarkeit als Dezimalzahl (60 % = 0,6)',
      'Stunden in PT umrechnen: Stunden / 8',
    ],
  ),
  beispiel(
    'n-tr-6',
    't-ressourcen',
    'Wie lange dauert das Arbeitspaket?',
    'Das Arbeitspaket „Datenmigration“ ist mit 360 Stunden Aufwand geschätzt. Zwei Entwickler arbeiten voll daran, eine Auszubildende zu 50 %. Ein Arbeitstag hat 8 Stunden.',
    schritte: [
      'Aufwand in PT: 360 h / 8 h = 45 PT',
      'Kapazität je Arbeitstag: 2 × 1,0 + 1 × 0,5 = 2,5 PT',
      'Dauer: 45 PT / 2,5 PT pro AT = 18 AT',
      'In Wochen: 18 AT / 5 AT pro Woche = 3,6 Wochen',
    ],
    ergebnis: 'Dauer 18 Arbeitstage, also knapp 4 Wochen',
  ),
  beispiel(
    'n-tr-7',
    't-ressourcen',
    'Wie viele Personen werden gebraucht?',
    'Ein Rollout mit 60 PT Aufwand muss in 15 Arbeitstagen fertig sein. Die Techniker sind zu 80 % für das Projekt verfügbar.',
    schritte: [
      'Formel umstellen: Personen = Aufwand / (Dauer × Verfügbarkeit)',
      'Einsetzen: 60 / (15 × 0,8) = 60 / 12',
      'Ergebnis: 5 Personen',
      'Bei krummen Ergebnissen immer aufrunden: 4,2 Personen heißt 5 Personen, sonst wird der Termin nicht gehalten.',
    ],
    ergebnis: '5 Techniker',
  ),
  formel(
    'n-tr-8',
    't-ressourcen',
    'Aufwand schätzen: Drei-Punkt-Schätzung',
    'Bevor gerechnet wird, muss der Aufwand geschätzt werden: durch Fachleute (Expertenschätzung), im Vergleich mit früheren Projekten (Analogieverfahren) oder mit drei Werten. Die Drei-Punkt-Schätzung gewichtet den wahrscheinlichsten Wert vierfach.',
    'Erwartungswert = (O + 4 × M + P) / 6\n'
        'O = optimistisch, M = wahrscheinlich, P = pessimistisch',
    points: [
      'Beispiel: O = 6 PT, M = 9 PT, P = 18 PT',
      '(6 + 4 × 9 + 18) / 6 = (6 + 36 + 18) / 6 = 60 / 6 = 10 PT',
      'Der Erwartungswert liegt über M, weil der pessimistische Wert weit entfernt ist.',
    ],
  ),
  skizze(
    'n-tr-9',
    't-ressourcen',
    'Das Ressourcenhistogramm',
    'Das Histogramm zeigt, wie viele Stunden eine Person je Woche verplant ist. Ihre Kapazität liegt bei 40 Stunden pro Woche - in KW 2 ist sie überschritten.',
    const BalkenDiagramm(
      [
        Balken('KW 1', 32),
        Balken('KW 2', 56, hervorheben: true),
        Balken('KW 3', 40),
        Balken('KW 4', 16),
      ],
      einheit: 'h',
      max: 60,
    ),
    points: [
      'KW 2: 56 h - 40 h = 16 Stunden Überlast, so nicht umsetzbar',
      'KW 4: 40 h - 16 h = 24 Stunden frei - hierhin lässt sich Arbeit verschieben, wenn der Puffer es erlaubt',
    ],
  ),
  konzept(
    'n-tr-10',
    't-ressourcen',
    'Überlastung ausgleichen',
    'Liegt der Bedarf über der Kapazität, muss die Planung angepasst werden. Zuerst prüft man Lösungen, die weder Geld noch Termin kosten.',
    points: [
      'Vorgänge innerhalb ihres Puffers verschieben (Kapazitätsausgleich)',
      'Arbeit auf weniger ausgelastete Personen umverteilen',
      'kurzfristig Überstunden',
      'zusätzliche interne oder externe Kapazität beschaffen',
      'Termin verschieben oder Umfang kürzen - nur in Absprache mit dem Auftraggeber',
    ],
  ),
  falle(
    'n-tr-11',
    't-ressourcen',
    'Mehr Leute, schneller fertig?',
    'Nicht unbedingt. Neue Teammitglieder müssen eingearbeitet werden, und mit jeder Person wächst der Abstimmungsaufwand. Das Brookssche Gesetz besagt sogar: Zusätzliches Personal macht ein verspätetes Softwareprojekt zunächst noch später.',
  ),
  falle(
    'n-tr-12',
    't-ressourcen',
    'Die Verfügbarkeit vergessen',
    '120 PT mit 4 Personen sind nicht automatisch 30 Tage. Sind alle nur zu 75 % im Projekt, ergibt sich 120 / (4 × 0,75) = 120 / 3 = 40 Arbeitstage. Die Verfügbarkeit zu übersehen ist der häufigste Fehler in diesen Aufgaben.',
    points: [
      'Personenzahlen immer aufrunden',
      'bei Tagen die Rundungsvorgabe der Aufgabe beachten',
    ],
  ),
  merke(
    'n-tr-13',
    't-ressourcen',
    'Merksatz',
    'Die Einheiten verraten die Bedeutung.',
    satz:
        'Personentage beschreiben Arbeit, Arbeitstage beschreiben Zeit - dazwischen steht die Verfügbarkeit.',
  ),

  // ======================================= Der Risikomanagement-Prozess
  konzept(
    'n-rp-1',
    'r-prozess',
    'Was ist ein Risiko?',
    'Ein Risiko ist ein mögliches künftiges Ereignis, das die Projektziele Leistung, Zeit oder Kosten gefährdet. Es hat zwei Größen: die Eintrittswahrscheinlichkeit und die Auswirkung, falls es eintritt.',
    points: [
      'Chance: das positive Gegenstück, etwa ein früher lieferbares Bauteil',
      'Risikomanagement: Risiken systematisch erkennen, bewerten, behandeln und überwachen',
    ],
  ),
  vergleich(
    'n-rp-2',
    'r-prozess',
    'Risiko oder Problem?',
    'Risikomanagement beschäftigt sich mit dem, was noch nicht passiert ist.',
    [
      ['Begriff', 'Zeitbezug', 'Beispiel'],
      ['Risiko', 'kann eintreten', 'Der Lieferant könnte zu spät liefern.'],
      ['Problem', 'ist eingetreten', 'Der Lieferant hat zu spät geliefert.'],
    ],
    points: [
      'Tritt ein Risiko ein, wird es zum Problem - dann greift die vorbereitete Notfallmaßnahme.',
    ],
  ),
  vergleich(
    'n-rp-3',
    'r-prozess',
    'Risikoarten',
    'Wer Risiken nach Arten ordnet, übersieht weniger. Diese Gruppen sind in IT-Projekten üblich.',
    [
      ['Art', 'Beispiel'],
      ['technisch', 'neue Schnittstelle funktioniert nicht'],
      ['personell', 'Schlüsselperson fällt aus'],
      ['wirtschaftlich', 'Hardwarepreise steigen'],
      ['organisatorisch', 'Fachbereich hat keine Zeit für Tests'],
      ['terminlich', 'Lieferant liefert zu spät'],
      ['rechtlich', 'Verstoß gegen Datenschutz oder Lizenzen'],
    ],
  ),
  skizze(
    'n-rp-4',
    'r-prozess',
    'Der Risikomanagement-Kreislauf',
    'Risikomanagement ist ein Kreislauf, der das ganze Projekt begleitet - vom Start bis zum Abschluss.',
    const FlussDiagramm(
      [
        FlussKnoten('Risiken identifizieren'),
        FlussKnoten('Risiken bewerten'),
        FlussKnoten('Maßnahmen planen'),
        FlussKnoten('Risiken überwachen'),
      ],
      zyklus: true,
      zyklusLabel: 'laufend wiederholen',
    ),
    points: [
      'Identifizieren: Welche Risiken gibt es?',
      'Bewerten: Wie wahrscheinlich, wie schwer?',
      'Maßnahmen planen: Welche Strategie, wer ist verantwortlich?',
      'Überwachen: Hat sich etwas verändert? Sind neue Risiken dazugekommen?',
    ],
  ),
  konzept(
    'n-rp-5',
    'r-prozess',
    'Risiken finden',
    'Kein Verfahren findet alle Risiken - deshalb kombiniert man mehrere.',
    points: [
      'Brainstorming im Team',
      'Checklisten aus früheren Projekten',
      'Lessons Learned vergangener Projekte',
      'Befragung von Fachleuten und Stakeholdern',
      'Durchsicht von Lastenheft, Verträgen und Plänen',
    ],
  ),
  konzept(
    'n-rp-6',
    'r-prozess',
    'Risiken richtig beschreiben',
    'Ein gut beschriebenes Risiko nennt Ursache, Ereignis und Auswirkung. Erst dann lässt es sich bewerten und gezielt behandeln.',
    table: [
      ['Teil', 'Beispiel'],
      ['Ursache', 'Weil nur ein Admin die Firewall kennt,'],
      ['Ereignis', 'könnte bei seinem Ausfall die Umstellung stocken,'],
      ['Auswirkung', 'sodass sich der Go-live um 2 Wochen verschiebt.'],
    ],
    points: [
      'Zu ungenau: „Das Projekt könnte scheitern.“ - daraus folgt keine Maßnahme.',
    ],
  ),
  konzept(
    'n-rp-7',
    'r-prozess',
    'Das Risikoregister',
    'Alle erkannten Risiken werden in einer Liste gesammelt und laufend gepflegt. Auch unwahrscheinliche Risiken gehören hinein - erst die Bewertung entscheidet über Maßnahmen.',
    table: [
      ['Feld', 'Beispiel'],
      ['ID, Beschreibung', 'R3: Admin fällt während der Umstellung aus'],
      ['Wahrscheinlichkeit', '20 %'],
      ['Schadenshöhe', '30.000 €'],
      ['Risikowert', '0,2 × 30.000 € = 6.000 €'],
      ['Maßnahme', 'zweiten Admin einarbeiten'],
      ['Verantwortlich', 'Projektleitung'],
      ['Status', 'in Bearbeitung'],
    ],
  ),
  konzept(
    'n-rp-8',
    'r-prozess',
    'Risiken überwachen',
    'Jedes Risiko bekommt eine verantwortliche Person (Risikoeigner), die es im Blick behält. Frühwarnindikatoren zeigen an, dass ein Risiko näher rückt.',
    points: [
      'Frühwarnindikator, zum Beispiel: Der Lieferant bestätigt den Liefertermin nicht.',
      'Risikostatus in jeder Projektbesprechung prüfen',
      'stark gestiegene Risiken an den Lenkungsausschuss eskalieren',
      'erledigte Risiken schließen, neue aufnehmen',
    ],
  ),
  falle(
    'n-rp-9',
    'r-prozess',
    'Einmal ist nicht genug',
    'Risikomanagement ist kein Pflichtpunkt beim Projektstart. Risiken ändern sich, neue kommen hinzu, alte entfallen. Ohne regelmäßige Überprüfung ist das Register nach wenigen Wochen veraltet.',
  ),
  falle(
    'n-rp-10',
    'r-prozess',
    'Problem statt Risiko',
    'In Prüfungsaufgaben werden gern eingetretene Ereignisse als Risiko angeboten. „Der Server ist ausgefallen“ ist ein Problem, kein Risiko - es wird sofort gelöst, nicht bewertet. Achte auf die Formulierung: Ein Risiko steht in der Möglichkeitsform (könnte, falls).',
  ),
  merke(
    'n-rp-11',
    'r-prozess',
    'Merksatz',
    'Der Prozess endet nie mit dem ersten Durchlauf.',
    satz:
        'Erkennen, bewerten, behandeln, überwachen - und dann wieder von vorn.',
  ),

  // =========================================================== Risiken bewerten
  vergleich(
    'n-rb-1',
    'r-bewertung',
    'Qualitativ oder quantitativ?',
    'Risiken lassen sich in Stufen oder in Zahlen bewerten. Beide Wege führen zu einer Rangfolge.',
    [
      ['', 'qualitativ', 'quantitativ'],
      [
        'Wahrscheinlichkeit',
        'Stufe gering/mittel/hoch (1-3)',
        'Prozent, z. B. 20 %',
      ],
      ['Auswirkung', 'Stufe gering/mittel/hoch (1-3)', 'Euro, z. B. 50.000 €'],
      ['Ergebnis', 'Risikokennzahl, z. B. 6', 'Risikowert in Euro'],
      ['Einsatz', 'früh, wenig Daten', 'wenn Zahlen schätzbar sind'],
    ],
  ),
  formel(
    'n-rb-2',
    'r-bewertung',
    'Der Risikowert',
    'Um Risiken vergleichbar zu machen, multipliziert man Wahrscheinlichkeit und Auswirkung. Der Risikowert heißt auch Erwartungswert des Schadens.',
    'Risikowert      = Eintrittswahrscheinlichkeit × Schadenshöhe\n'
        'Risikokennzahl  = Wahrscheinlichkeitsstufe × Auswirkungsstufe',
    points: ['Prozent als Dezimalzahl einsetzen: 20 % = 0,2'],
  ),
  beispiel(
    'n-rb-3',
    'r-bewertung',
    'Den Risikowert berechnen',
    'Bei einer Serverumstellung scheitert die Datenmigration mit einer Wahrscheinlichkeit von 20 %. Der Schaden läge dann bei 50.000 €.',
    schritte: [
      'Wahrscheinlichkeit umrechnen: 20 % = 0,2',
      'Risikowert = 0,2 × 50.000 € = 10.000 €',
      'Deutung: Über viele gleichartige Projekte gerechnet kostet dieses Risiko im Schnitt 10.000 €.',
    ],
    ergebnis: 'Risikowert 10.000 €',
  ),
  beispiel(
    'n-rb-4',
    'r-bewertung',
    'Risiken priorisieren',
    'Drei Risiken aus einem Rollout-Projekt sollen in eine Rangfolge gebracht werden.',
    table: [
      ['Risiko', 'Wahrscheinlichkeit', 'Schaden'],
      ['R1 Serverausfall', '10 %', '80.000 €'],
      ['R2 Lieferverzug', '40 %', '15.000 €'],
      ['R3 Ausfall Admin', '5 %', '40.000 €'],
    ],
    schritte: [
      'R1: 0,10 × 80.000 € = 8.000 €',
      'R2: 0,40 × 15.000 € = 6.000 €',
      'R3: 0,05 × 40.000 € = 2.000 €',
      'Nach Risikowert absteigend sortieren',
    ],
    ergebnis: 'Rangfolge: R1 (8.000 €), R2 (6.000 €), R3 (2.000 €)',
    merksatz:
        'Das wahrscheinlichste Risiko R2 steht nicht vorn - es zählt das Produkt.',
  ),
  skizze(
    'n-rb-5',
    'r-bewertung',
    'Die Risikomatrix',
    'Die Matrix ordnet Risiken nach Eintrittswahrscheinlichkeit (waagerecht) und Auswirkung (senkrecht) ein. Je weiter rechts oben ein Risiko liegt, desto dringender ist es.',
    const QuadrantenDiagramm(
      xAchse: 'Eintrittswahrscheinlichkeit',
      yAchse: 'Auswirkung',
      obenLinks: Quadrant('selten, schwer', 'gelb: absichern'),
      obenRechts: Quadrant('häufig, schwer', 'rot: sofort handeln'),
      untenLinks: Quadrant('selten, leicht', 'grün: beobachten'),
      untenRechts: Quadrant('häufig, leicht', 'gelb: vermindern'),
    ),
  ),
  vergleich(
    'n-rb-6',
    'r-bewertung',
    'Die 3×3-Matrix mit Punkten',
    'Oft werden beide Achsen in drei Stufen geteilt: 1 = gering, 2 = mittel, 3 = hoch. Das Produkt der Stufen ergibt die Risikokennzahl.',
    [
      ['Auswirkung', 'W. gering (1)', 'W. mittel (2)', 'W. hoch (3)'],
      ['hoch (3)', '3', '6', '9'],
      ['mittel (2)', '2', '4', '6'],
      ['gering (1)', '1', '2', '3'],
    ],
    points: [
      '1 bis 2: grün - akzeptieren und beobachten',
      '3 bis 4: gelb - Maßnahmen planen',
      '6 bis 9: rot - sofort handeln',
    ],
  ),
  beispiel(
    'n-rb-7',
    'r-bewertung',
    'Ein Risiko einstufen',
    'Die Wahrscheinlichkeit, dass der Fachbereich keine Zeit für den Abnahmetest hat, wird als mittel eingeschätzt, die Auswirkung auf den Termin als hoch.',
    schritte: [
      'Wahrscheinlichkeit mittel = Stufe 2',
      'Auswirkung hoch = Stufe 3',
      'Risikokennzahl = 2 × 3 = 6',
      'Einordnen: 6 liegt im roten Bereich',
    ],
    ergebnis: 'Kennzahl 6 - rot, es muss sofort eine Maßnahme geplant werden',
  ),
  formel(
    'n-rb-8',
    'r-bewertung',
    'Lohnt sich die Maßnahme?',
    'Der Risikowert ist auch ein Maßstab für Gegenmaßnahmen: Eine Maßnahme lohnt sich wirtschaftlich, wenn sie den Risikowert stärker senkt, als sie kostet.',
    'Nutzen = Risikowert vorher - Risikowert nachher\n'
        'lohnt sich, wenn Nutzen > Kosten der Maßnahme',
  ),
  beispiel(
    'n-rb-9',
    'r-bewertung',
    'Eine Maßnahme bewerten',
    'Ein Datenverlust tritt mit 30 % Wahrscheinlichkeit ein und kostet dann 40.000 €. Ein zusätzliches Backup-System kostet 5.000 € und senkt die Wahrscheinlichkeit auf 10 %.',
    schritte: [
      'Vorher: 0,30 × 40.000 € = 12.000 €',
      'Nachher: 0,10 × 40.000 € = 4.000 €',
      'Nutzen: 12.000 € - 4.000 € = 8.000 €',
      'Vergleich: 8.000 € Nutzen > 5.000 € Kosten',
    ],
    ergebnis:
        'Die Maßnahme lohnt sich - sie bringt 3.000 € mehr, als sie kostet.',
  ),
  falle(
    'n-rb-10',
    'r-bewertung',
    'Die Schwäche der Rechnung',
    'Ein sehr seltenes, aber existenzbedrohendes Risiko bekommt rechnerisch einen kleinen Wert: 1 % × 5 Mio. € ergibt 50.000 €. Trotzdem darf es nicht einfach hingenommen werden - Risiken, die das Unternehmen gefährden, brauchen immer eine Maßnahme.',
  ),
  falle(
    'n-rb-11',
    'r-bewertung',
    'Prozente und Achsen',
    'Zwei Fehler kosten regelmäßig Punkte: 25 % × 36.000 € sind 0,25 × 36.000 € = 9.000 € - Prozent immer als Dezimalzahl einsetzen. Und bei einer vorgegebenen Matrix zuerst prüfen, welche Achse was zeigt: Nicht jede Vorlage hat die Wahrscheinlichkeit waagerecht.',
  ),
  merke(
    'n-rb-12',
    'r-bewertung',
    'Merksatz',
    'Zahlen helfen beim Sortieren, nicht beim Wegsehen.',
    satz:
        'Erst nach Risikowert priorisieren, dann existenzbedrohende Risiken gesondert prüfen.',
  ),

  // =========================================================== Risikostrategien
  konzept(
    'n-rs-1',
    'r-strategien',
    'Vom Risiko zur Maßnahme',
    'Für jedes relevante Risiko wird eine Strategie gewählt und in konkrete Maßnahmen übersetzt - mit Verantwortlichem, Termin und Kosten. Die vier klassischen Strategien unterscheiden sich darin, wo sie ansetzen.',
    points: [
      'an der Ursache: vermeiden',
      'an Wahrscheinlichkeit oder Auswirkung: vermindern',
      'an den finanziellen Folgen: übertragen',
      'gar nicht, bewusst: akzeptieren',
    ],
  ),
  vergleich(
    'n-rs-2',
    'r-strategien',
    'Die vier Strategien',
    'Übertragen heißt in manchen Büchern auch überwälzen - gemeint ist dasselbe.',
    [
      ['Strategie', 'Idee', 'Beispiel'],
      [
        'Vermeiden',
        'Ursache beseitigen, auf riskante Tätigkeit verzichten',
        'bewährte statt unerprobter Technik',
      ],
      [
        'Vermindern',
        'Wahrscheinlichkeit oder Schaden senken',
        'Backup, Schulung, Prototyp',
      ],
      [
        'Übertragen',
        'finanzielle Folgen auf Dritte verlagern',
        'Versicherung, Festpreisvertrag',
      ],
      [
        'Akzeptieren',
        'bewusst tragen, ggf. mit Rücklage',
        'kleines Risiko, geringer Schaden',
      ],
    ],
  ),
  skizze(
    'n-rs-3',
    'r-strategien',
    'Strategien in der Risikomatrix',
    'Wo ein Risiko in der Matrix liegt, legt eine Strategie nahe. Das ist eine Faustregel, keine Pflicht.',
    const QuadrantenDiagramm(
      xAchse: 'Eintrittswahrscheinlichkeit',
      yAchse: 'Auswirkung',
      obenLinks: Quadrant('Übertragen', 'selten, aber teuer'),
      obenRechts: Quadrant('Vermeiden', 'häufig und teuer'),
      untenLinks: Quadrant('Akzeptieren', 'selten und billig'),
      untenRechts: Quadrant('Vermindern', 'häufig, aber billig'),
    ),
    points: [
      'selten, aber teuer: typisch für eine Versicherung',
      'häufig und teuer: so nicht eingehen - Ursache beseitigen',
    ],
  ),
  konzept(
    'n-rs-4',
    'r-strategien',
    'Vermeiden oder vermindern?',
    'Das ist die häufigste Verwechslung. Stell dir die Testfrage: Kann das Risiko nach der Maßnahme noch eintreten?',
    points: [
      'Nein, die Ursache ist weg: vermeiden',
      'Ja, aber seltener oder weniger schlimm: vermindern',
      'Beispiel: Ein Backup verhindert keinen Plattendefekt, begrenzt aber den Schaden - also vermindern.',
    ],
  ),
  vergleich(
    'n-rs-5',
    'r-strategien',
    'Vorbeugen oder vorbereiten?',
    'Maßnahmen wirken entweder vor dem Eintritt oder erst danach. Für wichtige Risiken plant man beides.',
    [
      ['Art', 'Wirkung', 'Beispiel'],
      [
        'präventiv',
        'vor dem Eintritt, senkt die Wahrscheinlichkeit',
        'zweiten Admin einarbeiten',
      ],
      [
        'korrektiv (Notfallplan)',
        'nach dem Eintritt, begrenzt den Schaden',
        'Wiederanlaufplan, Ersatzlieferant',
      ],
    ],
  ),
  vergleich(
    'n-rs-6',
    'r-strategien',
    'Strategien im IT-Projekt',
    'So sehen die vier Strategien in einem typischen Projekt aus.',
    [
      ['Risiko', 'Strategie', 'Maßnahme'],
      ['neues Framework unerprobt', 'vermeiden', 'bewährtes Framework nutzen'],
      [
        'Datenverlust bei Migration',
        'vermindern',
        'Vollbackup und Testmigration',
      ],
      ['Transportschaden an Servern', 'übertragen', 'Transportversicherung'],
      ['Beamer fällt aus', 'akzeptieren', 'bei Bedarf Ersatz kaufen'],
    ],
  ),
  konzept(
    'n-rs-7',
    'r-strategien',
    'Das Restrisiko',
    'Kaum eine Maßnahme beseitigt ein Risiko vollständig. Was danach übrig bleibt, ist das Restrisiko. Es wird erneut bewertet und entweder akzeptiert oder mit einer weiteren Maßnahme behandelt.',
  ),
  beispiel(
    'n-rs-8',
    'r-strategien',
    'Das Restrisiko berechnen',
    'Ein Lieferverzug tritt mit 40 % Wahrscheinlichkeit ein und kostet 20.000 €. Ein Rahmenvertrag mit einem Ersatzlieferanten senkt die Wahrscheinlichkeit auf 10 %, am Schaden ändert er nichts.',
    schritte: [
      'Risikowert vorher: 0,40 × 20.000 € = 8.000 €',
      'Restrisiko: 0,10 × 20.000 € = 2.000 €',
      'Senkung: 8.000 € - 2.000 € = 6.000 €',
      'Das Restrisiko wird neu eingestuft: 2.000 € sind vertretbar - akzeptieren und beobachten.',
    ],
    ergebnis: 'Restrisiko 2.000 €',
  ),
  falle(
    'n-rs-9',
    'r-strategien',
    'Übertragen heißt nicht beseitigen',
    'Eine Versicherung verhindert keinen Serverausfall - sie bezahlt nur den Schaden. Das Ereignis kann trotzdem eintreten, mit allen Folgen für den Zeitplan.',
  ),
  falle(
    'n-rs-10',
    'r-strategien',
    'Akzeptieren ist nicht ignorieren',
    'Akzeptieren ist eine bewusste Entscheidung: Das Risiko steht im Register, ist bewertet, und jemand hat entschieden, es zu tragen - oft mit einer finanziellen Rücklage. Ein Risiko, das niemand erfasst hat, ist nicht akzeptiert, sondern übersehen.',
  ),
  merke(
    'n-rs-11',
    'r-strategien',
    'Merksatz',
    'Geprüft wird von der wirksamsten zur schwächsten Strategie.',
    satz:
        'Vermeiden, vermindern, übertragen, akzeptieren - in dieser Reihenfolge prüfen.',
  ),

  // ============================================== Projektkosten kalkulieren
  konzept(
    'n-wk-1',
    'w-kalkulation',
    'Woraus Projektkosten bestehen',
    'In IT-Projekten sind die Personalkosten meist der größte Posten.',
    points: [
      'Personalkosten - interne Arbeitszeit',
      'Sachkosten - Hardware, Lizenzen, Material',
      'Fremdleistungen - externe Dienstleister',
      'Gemeinkosten - anteilige Kosten für Räume, Verwaltung, Infrastruktur',
    ],
  ),
  vergleich(
    'n-wk-2',
    'w-kalkulation',
    'Kostenbegriffe',
    'Für jede Kalkulation brauchst du zwei Unterscheidungen: Lässt sich die Kostenart dem Projekt direkt zurechnen? Und ändert sie sich mit der Menge?',
    [
      ['Begriff', 'Bedeutung', 'Beispiel'],
      [
        'Einzelkosten',
        'direkt dem Projekt zurechenbar',
        'Projektstunden, gekaufte Server',
      ],
      [
        'Gemeinkosten',
        'nur anteilig über einen Zuschlag',
        'Miete, Verwaltung, IT-Betrieb',
      ],
      ['fixe Kosten', 'unabhängig von der Menge', 'Miete, Lizenzpauschale'],
      [
        'variable Kosten',
        'steigen mit der Menge',
        'Material je Gerät, Versand',
      ],
    ],
  ),
  formel(
    'n-wk-3',
    'w-kalkulation',
    'Der Stundensatz',
    'Ein Stundensatz verteilt die Jahreskosten einer Person auf die Stunden, in denen sie tatsächlich produktiv arbeitet.',
    'Stundensatz = Personalkosten pro Jahr / produktive Stunden pro Jahr\n'
        'Tagessatz   = Stundensatz × 8\n'
        'Personalkosten im Projekt = Stunden × Stundensatz',
    points: [
      'Personalkosten = Bruttogehalt + Arbeitgeberanteil (Lohnnebenkosten)',
      'produktive Stunden = (Arbeitstage - Urlaub - Krankheit - Weiterbildung) × Stunden pro Tag',
    ],
  ),
  beispiel(
    'n-wk-4',
    'w-kalkulation',
    'Einen Stundensatz berechnen',
    'Eine Fachinformatikerin verdient 48.000 € brutto im Jahr, der Arbeitgeber trägt zusätzlich 20 % Lohnnebenkosten. Von 250 Arbeitstagen fallen 30 Tage Urlaub, 10 Tage Krankheit und 10 Tage Weiterbildung weg. Ein Arbeitstag hat 8 Stunden.',
    schritte: [
      'Personalkosten: 48.000 € × 1,2 = 57.600 €',
      'Produktive Tage: 250 - 30 - 10 - 10 = 200 Tage',
      'Produktive Stunden: 200 × 8 h = 1.600 h',
      'Stundensatz: 57.600 € / 1.600 h = 36 €/h',
      'Tagessatz: 36 €/h × 8 h = 288 €',
    ],
    ergebnis: 'Stundensatz 36 €/h, Tagessatz 288 €',
  ),
  formel(
    'n-wk-5',
    'w-kalkulation',
    'Vom Selbstkostenpreis zum Angebot',
    'Für ein Angebot kommen zu den Einzelkosten die Gemeinkosten als prozentualer Zuschlag. Auf die Selbstkosten folgt der Gewinnzuschlag, auf den Nettopreis die Umsatzsteuer.',
    '  Personaleinzelkosten (Stunden × Stundensatz)\n'
        '+ Gemeinkostenzuschlag (% der Personalkosten)\n'
        '+ Sachkosten (Hardware, Lizenzen)\n'
        '= Selbstkosten\n'
        '+ Gewinnzuschlag (% der Selbstkosten)\n'
        '= Nettoangebotspreis\n'
        '+ Umsatzsteuer 19 %\n'
        '= Bruttoangebotspreis',
    points: [
      'Worauf sich der Gemeinkostenzuschlag bezieht, steht in der Aufgabe - hier auf die Personalkosten.',
    ],
  ),
  beispiel(
    'n-wk-6',
    'w-kalkulation',
    'Ein Angebot kalkulieren',
    'Ein Systemhaus plant für die Einrichtung eines Netzwerks 120 Stunden zu je 36 €. Der Gemeinkostenzuschlag beträgt 50 % auf die Personalkosten, die Hardware kostet 1.520 €. Kalkuliert wird mit 10 % Gewinn und 19 % Umsatzsteuer.',
    table: [
      ['Position', 'Rechnung', 'Betrag'],
      ['Personalkosten', '120 h × 36 €', '4.320 €'],
      ['+ Gemeinkosten', '50 % von 4.320 €', '2.160 €'],
      ['+ Sachkosten', 'Hardware', '1.520 €'],
      ['= Selbstkosten', 'Summe', '8.000 €'],
      ['+ Gewinn', '10 % von 8.000 €', '800 €'],
      ['= netto', 'Summe', '8.800 €'],
      ['+ Umsatzsteuer', '19 % von 8.800 €', '1.672 €'],
      ['= brutto', 'Summe', '10.472 €'],
    ],
    schritte: [
      'Personalkosten: 120 h × 36 €/h = 4.320 €',
      'Gemeinkosten: 4.320 € × 0,5 = 2.160 €',
      'Selbstkosten: 4.320 € + 2.160 € + 1.520 € = 8.000 €',
      'Gewinn: 8.000 € × 0,1 = 800 €, netto 8.800 €',
      'Umsatzsteuer: 8.800 € × 0,19 = 1.672 €, brutto 10.472 €',
    ],
    ergebnis: 'Angebotspreis 8.800 € netto, 10.472 € brutto',
  ),
  formel(
    'n-wk-7',
    'w-kalkulation',
    'Die Bezugskalkulation',
    'Beim Vergleich von Lieferantenangeboten zählt nicht der Listenpreis, sondern der Bezugspreis (Einstandspreis): was die Ware wirklich kostet, bis sie im Haus ist.',
    '  Listenpreis\n'
        '- Rabatt (% vom Listenpreis)\n'
        '= Zieleinkaufspreis\n'
        '- Skonto (% vom Zieleinkaufspreis)\n'
        '= Bareinkaufspreis\n'
        '+ Bezugskosten (Fracht, Verpackung)\n'
        '= Bezugspreis',
    points: [
      'Rabatt: Preisnachlass, etwa für Menge oder Stammkunden',
      'Skonto: Nachlass für Zahlung innerhalb einer kurzen Frist',
    ],
  ),
  beispiel(
    'n-wk-8',
    'w-kalkulation',
    'Den Bezugspreis berechnen',
    'Ein Händler bietet 10 Monitore zu je 250 € an. Er gewährt 10 % Rabatt und 2 % Skonto bei Zahlung innerhalb von 10 Tagen. Für die Lieferung berechnet er 35 €.',
    schritte: [
      'Listenpreis: 10 × 250 € = 2.500 €',
      'Rabatt: 2.500 € × 0,10 = 250 €, Zieleinkaufspreis 2.250 €',
      'Skonto vom Zieleinkaufspreis: 2.250 € × 0,02 = 45 €, Bareinkaufspreis 2.205 €',
      'Bezugskosten: 2.205 € + 35 € = 2.240 €',
      'Je Monitor: 2.240 € / 10 = 224 €',
    ],
    ergebnis: 'Bezugspreis 2.240 €, also 224 € je Monitor',
  ),
  konzept(
    'n-wk-9',
    'w-kalkulation',
    'Der Angebotsvergleich',
    'Liegen mehrere Angebote vor, vergleicht man zuerst quantitativ: Für jedes Angebot wird der Bezugspreis berechnet, denn Rabatte, Skonto und Versandkosten verschieben die Rangfolge. Danach folgen qualitative Kriterien wie Lieferzeit, Service oder Garantie.',
    points: [
      'Angebot A: 2.400 € mit 5 % Rabatt, frei Haus -> 2.400 € × 0,95 = 2.280 €',
      'Angebot B: 2.300 € ohne Rabatt, 60 € Versand -> 2.300 € + 60 € = 2.360 €',
      'Trotz höheren Listenpreises ist A um 80 € günstiger.',
    ],
  ),
  konzept(
    'n-wk-14',
    'w-kalkulation',
    'Entgangener Umsatz gehört zu den Kosten',
    'Wer geschult wird oder auf ein neues System umstellt, kann in dieser Zeit keine Kundenstunden abrechnen. Der Umsatz, der dadurch fehlt, heißt entgangener Umsatz. Er steht auf keiner Rechnung, gehört aber in jeden Kostenvergleich - sonst wirkt die Lösung mit der längeren Schulung zu günstig.',
    points: [
      'Entgangener Umsatz = Personen × ausgefallene Stunden × Stundensatz',
      'typische Anlässe: Schulung, Umstellung, Systemausfall',
      'Kosten im ersten Jahr = Lizenzen + Schulung + entgangener Umsatz',
    ],
  ),
  beispiel(
    'n-wk-15',
    'w-kalkulation',
    'Jahreskosten mit entgangenem Umsatz',
    'Ein Planungsbüro führt für 4 Ingenieure eine neue Software ein. Die Lizenz kostet 60 € je Nutzer und Monat. Die Pflichtschulung dauert 6 Stunden und kostet pauschal 1.200 €. Ein Ingenieur rechnet 90 € je Stunde beim Kunden ab.',
    schritte: [
      'Lizenzen: 4 Nutzer × 60 € × 12 Monate = 2.880 €',
      'Schulung: 1.200 € pauschal',
      'Entgangener Umsatz: 4 Personen × 6 h × 90 € = 2.160 €',
      'Summe: 2.880 € + 1.200 € + 2.160 € = 6.240 €',
    ],
    ergebnis:
        'Kosten im ersten Jahr: 6.240 €, davon 2.160 € entgangener Umsatz',
  ),
  konzept(
    'n-wk-10',
    'w-kalkulation',
    'Vor-, Mit- und Nachkalkulation',
    'Kalkuliert wird nicht nur einmal, sondern in drei Stufen.',
    points: [
      'Vorkalkulation: vor dem Projekt, Grundlage für Angebot und Budget',
      'Mitkalkulation: während des Projekts, laufender Soll-Ist-Vergleich',
      'Nachkalkulation: nach dem Projekt, Abgleich mit den echten Kosten - verbessert die nächste Schätzung',
    ],
  ),
  falle(
    'n-wk-11',
    'w-kalkulation',
    'Jeder Prozentsatz hat seine Basis',
    'Skonto wird vom Zieleinkaufspreis abgezogen, also nach dem Rabatt - nicht vom Listenpreis. Auf Bezugskosten gibt es kein Skonto. Der Gewinnzuschlag bezieht sich auf die Selbstkosten, die Umsatzsteuer auf den Nettopreis.',
    points: [
      'Falsch: 2.500 € - 10 % - 2 % jeweils vom Listenpreis = 2.200 €',
      'Richtig: 2.500 € -> 2.250 € -> 2.205 €',
    ],
  ),
  falle(
    'n-wk-12',
    'w-kalkulation',
    'Produktive Stunden, nicht Anwesenheit',
    'Wer die Jahreskosten auf alle theoretisch möglichen Stunden verteilt (250 Tage × 8 h = 2.000 h), erhält 57.600 € / 2.000 h = 28,80 €/h - zu wenig. Urlaub, Krankheit und Weiterbildung werden bezahlt, bringen aber keine Projektstunden. Richtig sind 36 €/h.',
  ),
  merke(
    'n-wk-13',
    'w-kalkulation',
    'Merksatz',
    'Die Angebotskalkulation baut Stufe für Stufe aufeinander auf.',
    satz:
        'Einzelkosten plus Gemeinkosten ergeben die Selbstkosten, plus Gewinn den Nettopreis, plus Umsatzsteuer den Bruttopreis.',
  ),

  // ============================================================ Nutzwertanalyse
  konzept(
    'n-wn-1',
    'w-nutzwert',
    'Wozu eine Nutzwertanalyse?',
    'Nicht alles lässt sich in Euro ausdrücken: Bedienbarkeit, Support oder Zukunftssicherheit zum Beispiel. Die Nutzwertanalyse macht solche qualitativen Kriterien mit Punkten und Gewichten vergleichbar - etwa bei der Auswahl von Software, Hardware oder Dienstleistern.',
  ),
  vergleich(
    'n-wn-2',
    'w-nutzwert',
    'Quantitativ oder qualitativ?',
    'Ein vollständiger Angebotsvergleich betrachtet beides. Der Preis kann dabei auch selbst ein Kriterium der Nutzwertanalyse sein.',
    [
      ['', 'quantitativ', 'qualitativ'],
      ['Grundlage', 'Preise und Kosten in Euro', 'Kriterien mit Punkten'],
      ['Werkzeug', 'Bezugskalkulation, Kostenvergleich', 'Nutzwertanalyse'],
      ['Beispiel', 'Bezugspreis 2.240 €', 'Support: 8 von 10 Punkten'],
    ],
  ),
  vergleich(
    'n-wn-3',
    'w-nutzwert',
    'Muss- und Kann-Kriterien',
    'Nicht jedes Kriterium wird gewichtet. Mussanforderungen prüft man vorab als K.-o.-Kriterien: Wer sie nicht erfüllt, scheidet aus.',
    [
      ['Art', 'Behandlung', 'Beispiel'],
      ['Muss (K.-o.)', 'erfüllt oder ausgeschieden', 'Hosting in der EU'],
      ['Kann (Wunsch)', 'gewichtet und bepunktet', 'Bedienbarkeit, Support'],
    ],
  ),
  ablauf(
    'n-wn-4',
    'w-nutzwert',
    'Die Schritte',
    'Das Verfahren ist immer gleich.',
    [
      'Kriterien festlegen - bevor man die Angebote kennt',
      'K.-o.-Kriterien prüfen, ungeeignete Alternativen streichen',
      'Kriterien gewichten - die Gewichte ergeben zusammen 100 %',
      'Jede Alternative je Kriterium mit Punkten bewerten',
      'Teilnutzwert = Gewicht × Punkte',
      'Teilnutzwerte je Alternative zum Nutzwert addieren',
      'Die Alternative mit dem höchsten Nutzwert wählen',
    ],
  ),
  konzept(
    'n-wn-5',
    'w-nutzwert',
    'Gewichte und Punkte festlegen',
    'Die Gewichte drücken aus, wie wichtig ein Kriterium ist, die Punkte, wie gut eine Alternative es erfüllt. Beides wird vor der Bewertung festgelegt.',
    points: [
      'Gewichte in Prozent (Summe 100 %) oder als Anteile (Summe 1)',
      'eine einheitliche Punkteskala, z. B. 0 bis 10 - höher ist immer besser',
      'auch beim Preis: günstig bekommt viele Punkte',
      'Hilfe beim Gewichten: paarweiser Vergleich, jedes Kriterium gegen jedes andere',
    ],
  ),
  formel(
    'n-wn-6',
    'w-nutzwert',
    'Die Rechnung',
    'Jedes Kriterium liefert einen Teilnutzwert, ihre Summe ist der Nutzwert der Alternative.',
    'Teilnutzwert = Gewicht × Punkte\n'
        'Nutzwert     = Summe aller Teilnutzwerte',
    points: [
      'Der Nutzwert kann nie über dem Maximum der Punkteskala liegen - gute Kontrolle.',
    ],
  ),
  beispiel(
    'n-wn-7',
    'w-nutzwert',
    'Drei Ticketsysteme im Vergleich',
    'Drei Ticketsysteme werden auf einer Skala von 0 bis 10 bewertet. Gewichte: Preis 40 %, Support 35 %, Bedienung 25 %.',
    table: [
      ['Kriterium', 'A', 'B', 'C'],
      ['Preis (40 %)', '8', '6', '9'],
      ['Support (35 %)', '6', '9', '5'],
      ['Bedienung (25 %)', '9', '7', '6'],
    ],
    schritte: [
      'Kontrolle der Gewichte: 40 % + 35 % + 25 % = 100 %',
      'A: 0,40 × 8 + 0,35 × 6 + 0,25 × 9 = 3,20 + 2,10 + 2,25 = 7,55',
      'B: 0,40 × 6 + 0,35 × 9 + 0,25 × 7 = 2,40 + 3,15 + 1,75 = 7,30',
      'C: 0,40 × 9 + 0,35 × 5 + 0,25 × 6 = 3,60 + 1,75 + 1,50 = 6,85',
    ],
    ergebnis: 'A gewinnt mit 7,55 Punkten vor B (7,30) und C (6,85).',
  ),
  skizze(
    'n-wn-8',
    'w-nutzwert',
    'Das Ergebnis als Balkendiagramm',
    'Ein Balkendiagramm macht das Ergebnis für Entscheider auf einen Blick lesbar. Der Abstand zwischen A und B ist klein - hier lohnt ein zweiter Blick.',
    const BalkenDiagramm(
      [
        Balken('A', 7.55, hervorheben: true),
        Balken('B', 7.30),
        Balken('C', 6.85),
      ],
      einheit: 'Punkte',
      max: 10,
    ),
    points: [
      'Die Skala endet bei 10 möglichen Punkten.',
      'Bei knappen Abständen prüfen: Kippt das Ergebnis, wenn man ein Gewicht leicht ändert?',
    ],
  ),
  beispiel(
    'n-wn-9',
    'w-nutzwert',
    'Das K.-o.-Kriterium schlägt den Nutzwert',
    'Muss-Kriterium ist „Daten werden in der EU gespeichert“. Ticketsystem A aus dem Beispiel speichert die Daten in den USA, B und C in Deutschland.',
    schritte: [
      'K.-o.-Prüfung vor der Rechnung: A erfüllt das Muss-Kriterium nicht.',
      'A scheidet aus - sein Nutzwert von 7,55 spielt keine Rolle.',
      'Unter den verbleibenden Alternativen hat B den höchsten Nutzwert: 7,30 > 6,85.',
    ],
    ergebnis: 'Gewählt wird B.',
  ),
  konzept(
    'n-wn-12',
    'w-nutzwert',
    'Entscheidungsmatrix mit Rangplätzen',
    'Die einfachste Form des Vergleichs kommt ohne Gewichtung aus: Je Kriterium werden die Alternativen in eine Rangfolge gebracht, die Ränge werden addiert. Welche Zahl für den besten Wert steht, legt die Aufgabe fest - deshalb immer zuerst die Vorgabe lesen.',
    points: [
      'Vorgabe „Rang 1 für den besten Wert“: Die kleinste Rangsumme gewinnt.',
      'Vorgabe „höchste Punktzahl für den besten Wert“ (bei drei Alternativen 3 Punkte): Die größte Summe gewinnt.',
      'Jeder Rang wird je Kriterium nur einmal vergeben.',
      'Bewertet werden nur die genannten Kriterien, auch wenn die Datentabelle mehr Merkmale enthält.',
    ],
  ),
  beispiel(
    'n-wn-13',
    'w-nutzwert',
    'Drei Drucker nach Rangplätzen vergleichen',
    'Drei Drucker werden ohne Gewichtung verglichen. Vorgabe: Rang 1 für den besten, Rang 3 für den schlechtesten Wert je Kriterium.',
    table: [
      ['Kriterium', 'Gerät A', 'Gerät B', 'Gerät C'],
      ['Preis', '480 €', '390 €', '560 €'],
      ['Drucktempo (Seiten/min)', '30', '22', '38'],
      ['Wartung je Monat', '14 €', '9 €', '11 €'],
    ],
    schritte: [
      'Preis (klein ist gut): B Rang 1, A Rang 2, C Rang 3',
      'Drucktempo (groß ist gut): C Rang 1, A Rang 2, B Rang 3',
      'Wartung (klein ist gut): B Rang 1, C Rang 2, A Rang 3',
      'Rangsummen: A 2 + 2 + 3 = 7, B 1 + 3 + 1 = 5, C 3 + 1 + 2 = 6',
    ],
    ergebnis: 'Gerät B gewinnt mit der kleinsten Rangsumme 5.',
  ),
  falle(
    'n-wn-14',
    'w-nutzwert',
    'Bei Kosten ist klein gut',
    'Der häufigste Fehler in der Entscheidungsmatrix: Beim Preis oder bei den Wartungskosten bekommt der größte Wert den besten Rang. Bei Kosten, Lieferzeit oder Stromverbrauch ist aber der kleinste Wert der beste. Der zweite Fehler: die Vorgabe überlesen und die falsche Summe gewinnen lassen.',
    points: [
      'Vorgabe „3 Punkte für den besten Wert“: Das günstigste Gerät erhält 3 Punkte, die größte Summe gewinnt.',
      'Vorgabe „Rang 1 für den besten Wert“: Das günstigste Gerät erhält Rang 1, die kleinste Summe gewinnt.',
    ],
  ),
  falle(
    'n-wn-10',
    'w-nutzwert',
    'Typische Fehler',
    'Hier gehen in der Prüfung die meisten Punkte verloren.',
    points: [
      'Gewichte ergeben nicht 100 %',
      'Punkte ohne Gewichtung addiert',
      'Prozent als ganze Zahl gerechnet: 40 × 8 = 320 statt 0,40 × 8 = 3,20',
      'K.-o.-Kriterien übersehen: Wer eine Mussanforderung verfehlt, fällt vorher heraus - egal wie hoch sein Nutzwert wäre',
    ],
  ),
  merke(
    'n-wn-11',
    'w-nutzwert',
    'Die Grenze des Verfahrens',
    'Gewichte und Punkte sind subjektiv - wer sie festlegt, beeinflusst das Ergebnis. Deshalb legt man Kriterien und Gewichte fest, bevor man die Angebote kennt.',
    satz:
        'Die Nutzwertanalyse macht eine Entscheidung nachvollziehbar, nicht objektiv.',
  ),

  // ================================================================== Make or Buy
  konzept(
    'n-wm-1',
    'w-makeorbuy',
    'Die Frage',
    'Soll eine Lösung selbst entwickelt oder betrieben werden (make) oder am Markt eingekauft (buy)? Die Entscheidung hängt nicht nur am Preis.',
    points: [
      'Make: Eigenentwicklung, Eigenfertigung, eigener Betrieb',
      'Buy: Standardsoftware, Fremdentwicklung, Outsourcing, Cloud-Dienst (SaaS)',
    ],
  ),
  vergleich(
    'n-wm-2',
    'w-makeorbuy',
    'Make oder Buy im Vergleich',
    'Beide Wege haben typische Vor- und Nachteile.',
    [
      ['', 'Make', 'Buy'],
      [
        'Passgenauigkeit',
        'exakt auf den Bedarf zugeschnitten',
        'Standard, ggf. Anpassung nötig',
      ],
      ['Zeit bis zum Einsatz', 'lang', 'kurz'],
      ['Know-how', 'bleibt im Unternehmen', 'Abhängigkeit vom Anbieter'],
      ['Kosten', 'hohe Entwicklungskosten', 'Lizenz- und Wartungskosten'],
    ],
  ),
  konzept(
    'n-wm-3',
    'w-makeorbuy',
    'Qualitative Kriterien',
    'Neben den Kosten entscheiden strategische Fragen. Sie werden oft mit einer Nutzwertanalyse bewertet.',
    points: [
      'Kernkompetenz: Ist die Lösung ein Wettbewerbsvorteil? Dann eher make.',
      'Know-how und Kapazität: Haben wir die Leute dafür?',
      'Zeit: Wie schnell wird die Lösung gebraucht?',
      'Abhängigkeit: Was passiert, wenn der Anbieter Preise erhöht oder aufgibt?',
      'Datenschutz und Sicherheit: Wo liegen die Daten?',
    ],
  ),
  formel(
    'n-wm-4',
    'w-makeorbuy',
    'Der Kostenvergleich',
    'Beim Kostenvergleich stellt man die Gesamtkosten beider Wege in Abhängigkeit von der Menge x auf. Wo sie gleich sind, liegt die kritische Menge.',
    'K(make) = Fixkosten(make) + Stückkosten(make) × x\n'
        'K(buy)  = Fixkosten(buy)  + Stückpreis(buy) × x\n'
        'kritische Menge = (Fix(make) - Fix(buy))\n'
        '                / (Stück(buy) - Stück(make))',
    points: [
      'Unterhalb der kritischen Menge gewinnt der Weg mit den niedrigeren Fixkosten, meist buy.',
      'Oberhalb gewinnt der Weg mit den niedrigeren Stückkosten, meist make.',
    ],
  ),
  beispiel(
    'n-wm-5',
    'w-makeorbuy',
    'Die kritische Menge berechnen',
    'Ein Systemhaus richtet Notebooks für Kunden ein. Selbst machen: Imaging-Server und Einrichtung kosten 6.000 € fix, danach 20 € je Gerät. Einkaufen: Der Lieferant konfiguriert für 50 € je Gerät vor.',
    schritte: [
      'K(make) = 6.000 € + 20 € × x',
      'K(buy) = 50 € × x',
      'Gleichsetzen: 6.000 + 20x = 50x, also 6.000 = 30x',
      'x = 6.000 / 30 = 200 Geräte',
      'Probe bei 200: make 6.000 € + 4.000 € = 10.000 €, buy 200 × 50 € = 10.000 €',
    ],
    ergebnis:
        'Kritische Menge 200 Geräte: darunter ist buy günstiger, darüber make',
  ),
  skizze(
    'n-wm-6',
    'w-makeorbuy',
    'Make or Buy im Diagramm',
    'Die Buy-Gerade beginnt bei 0, steigt aber steiler. Die Make-Gerade beginnt bei den Fixkosten und steigt flacher. Im Schnittpunkt kosten beide Wege gleich viel.',
    const GeradenDiagramm(
      xAchse: 'Geräte',
      yAchse: 'Kosten in €',
      xMax: 400,
      yMax: 20000,
      geraden: [Gerade('Make', 6000, 20), Gerade('Buy', 0, 50)],
      punkte: [DiagrammPunkt(200, 10000, 'kritische Menge')],
    ),
    points: [
      '150 Geräte: make 6.000 € + 3.000 € = 9.000 €, buy 7.500 € - buy ist günstiger',
      '300 Geräte: make 6.000 € + 6.000 € = 12.000 €, buy 15.000 € - make ist günstiger',
    ],
  ),
  konzept(
    'n-wm-7',
    'w-makeorbuy',
    'Total Cost of Ownership',
    'Die TCO betrachtet alle Kosten über die gesamte Nutzungsdauer - nicht nur den Kaufpreis. Erträge gehören nicht dazu, sie kommen erst in einer Wirtschaftlichkeitsrechnung ins Spiel.',
    points: [
      'Anschaffung und Einrichtung',
      'Betrieb: Strom, Wartung, Lizenzen',
      'Support und Personal',
      'Schulung',
      'Entsorgung bzw. Ablösung',
    ],
  ),
  beispiel(
    'n-wm-8',
    'w-makeorbuy',
    'TCO über vier Jahre',
    'Eine Zeiterfassung wird für 4 Jahre gebraucht. Buy: Lizenz 12.000 €, Anpassung 3.000 €, Wartung 2.400 € pro Jahr. Make: Entwicklung 20.000 €, Pflege 1.000 € pro Jahr.',
    table: [
      ['Kosten', 'Buy', 'Make'],
      ['einmalig', '15.000 €', '20.000 €'],
      ['laufend (4 Jahre)', '9.600 €', '4.000 €'],
      ['TCO', '24.600 €', '24.000 €'],
    ],
    schritte: [
      'Buy einmalig: 12.000 € + 3.000 € = 15.000 €',
      'Buy laufend: 4 × 2.400 € = 9.600 €, TCO 24.600 €',
      'Make: 20.000 € + 4 × 1.000 € = 24.000 €',
      'Differenz: 24.600 € - 24.000 € = 600 € zugunsten von Make',
    ],
    ergebnis:
        'Make ist über 4 Jahre 600 € günstiger - bei so knappem Abstand entscheiden die qualitativen Kriterien.',
  ),
  konzept(
    'n-wm-9',
    'w-makeorbuy',
    'Die Machbarkeitsanalyse',
    'Bevor ein Weg gewählt wird, prüft man, ob er überhaupt gangbar ist.',
    points: [
      'technisch - lässt es sich umsetzen?',
      'wirtschaftlich - lohnt es sich?',
      'rechtlich - ist es erlaubt, etwa beim Datenschutz und bei Lizenzen?',
      'organisatorisch - passt es zu Abläufen und Personal?',
      'zeitlich - ist es rechtzeitig fertig?',
    ],
  ),
  falle(
    'n-wm-10',
    'w-makeorbuy',
    'Kein Weg ist automatisch billiger',
    'Ein niedriger Kaufpreis täuscht, wenn hohe jährliche Lizenzgebühren, teure Anpassungen oder Schulungen folgen. Umgekehrt unterschätzen Eigenentwicklungen oft Wartung, Tests und die Abhängigkeit von einzelnen Entwicklern. Erst die Betrachtung über die ganze Nutzungsdauer zeigt, welcher Weg günstiger ist.',
  ),
  merke(
    'n-wm-11',
    'w-makeorbuy',
    'Merksatz',
    'Make or Buy ist Rechnung und Strategie zugleich.',
    satz:
        'Erst über die ganze Nutzungsdauer rechnen, dann strategisch abwägen.',
  ),

  // ===================================================== Break-even und Amortisation
  konzept(
    'n-wb-1',
    'w-breakeven',
    'Die Gewinnschwelle',
    'Der Break-even-Point ist die Menge, ab der die Erlöse alle Kosten decken. Darunter macht man Verlust, darüber Gewinn. Genau an diesem Punkt ist der Gewinn null.',
  ),
  vergleich(
    'n-wb-2',
    'w-breakeven',
    'Die Begriffe',
    'Für die Break-even-Rechnung brauchst du vier Größen.',
    [
      ['Begriff', 'Formel'],
      ['Erlös (Umsatz)', 'Preis × Menge'],
      ['Gesamtkosten', 'Fixkosten + variable Stückkosten × Menge'],
      ['Deckungsbeitrag je Stück', 'Preis - variable Stückkosten'],
      ['Gewinn', 'Erlös - Gesamtkosten'],
    ],
  ),
  formel(
    'n-wb-3',
    'w-breakeven',
    'Die Break-even-Menge',
    'Jedes verkaufte Stück trägt seinen Deckungsbeitrag zu den Fixkosten bei. Sind die Fixkosten gedeckt, ist die Gewinnschwelle erreicht.',
    'Deckungsbeitrag je Stück = Preis - variable Stückkosten\n'
        'Break-even-Menge = Fixkosten / Deckungsbeitrag je Stück',
  ),
  beispiel(
    'n-wb-4',
    'w-breakeven',
    'Die Break-even-Menge berechnen',
    'Ein Systemhaus verkauft ein Wartungspaket für 50 €. Je Paket fallen 30 € variable Kosten an, die Fixkosten betragen 10.000 €.',
    schritte: [
      'Deckungsbeitrag: 50 € - 30 € = 20 € je Paket',
      'Break-even-Menge: 10.000 € / 20 € = 500 Pakete',
      'Probe Erlös: 500 × 50 € = 25.000 €',
      'Probe Kosten: 10.000 € + 500 × 30 € = 25.000 €',
    ],
    ergebnis: 'Ab 500 Paketen ist die Gewinnschwelle erreicht.',
  ),
  skizze(
    'n-wb-5',
    'w-breakeven',
    'Das Break-even-Diagramm',
    'Die Erlösgerade beginnt bei 0, die Gesamtkostengerade bei den Fixkosten. Links vom Schnittpunkt liegt die Verlustzone, rechts die Gewinnzone.',
    const GeradenDiagramm(
      xAchse: 'Menge',
      yAchse: 'Euro',
      xMax: 1000,
      yMax: 50000,
      geraden: [
        Gerade('Erlös', 0, 50),
        Gerade('Gesamtkosten', 10000, 30),
        Gerade('Fixkosten', 10000, 0),
      ],
      punkte: [DiagrammPunkt(500, 25000, 'Break-even')],
    ),
    points: [
      'Der senkrechte Abstand zwischen Erlös und Gesamtkosten ist Gewinn oder Verlust.',
      'Die Fixkosten bleiben waagerecht, egal wie viel verkauft wird.',
    ],
  ),
  beispiel(
    'n-wb-6',
    'w-breakeven',
    'Gewinn bei gegebener Menge',
    'Wie hoch ist der Gewinn, wenn das Systemhaus 800 Wartungspakete verkauft?',
    schritte: [
      'Gesamtdeckungsbeitrag: 800 × 20 € = 16.000 €',
      'Gewinn: 16.000 € - 10.000 € Fixkosten = 6.000 €',
      'Probe: Erlös 800 × 50 € = 40.000 €, Kosten 10.000 € + 800 × 30 € = 34.000 €, Differenz 6.000 €',
    ],
    ergebnis: 'Gewinn 6.000 €',
  ),
  beispiel(
    'n-wb-7',
    'w-breakeven',
    'Break-even bei einem Abo-Dienst',
    'Ein Start-up bietet Cloud-Backup für 25 € pro Kunde und Monat an. Je Kunde entstehen 5 € variable Kosten im Monat, die Fixkosten liegen bei 36.000 € im Jahr.',
    schritte: [
      'Alle Größen auf dasselbe Zeitmaß bringen - hier ein Jahr',
      'Deckungsbeitrag je Kunde und Monat: 25 € - 5 € = 20 €',
      'Deckungsbeitrag je Kunde und Jahr: 20 € × 12 = 240 €',
      'Break-even: 36.000 € / 240 € = 150 Kunden',
    ],
    ergebnis: 'Ab 150 zahlenden Kunden trägt sich der Dienst.',
  ),
  formel(
    'n-wb-8',
    'w-breakeven',
    'Die Amortisationsdauer',
    'Die Amortisationsdauer gibt an, nach wie vielen Jahren eine Investition durch Einsparungen oder Mehrerlöse wieder hereingeholt ist. Je kürzer, desto geringer das Risiko der Investition.',
    'Amortisationsdauer = Investition / jährlicher Rückfluss\n'
        'jährlicher Rückfluss = Einsparung - laufende Kosten',
    points: ['Nachkommateil in Monate umrechnen: Nachkommateil × 12'],
  ),
  beispiel(
    'n-wb-9',
    'w-breakeven',
    'Amortisation in Jahren und Monaten',
    'Eine neue Virtualisierungsumgebung kostet 30.000 €. Sie spart 10.000 € Strom- und Wartungskosten pro Jahr, verursacht aber 2.000 € Lizenzkosten pro Jahr.',
    schritte: [
      'Rückfluss pro Jahr: 10.000 € - 2.000 € = 8.000 €',
      'Amortisationsdauer: 30.000 € / 8.000 € = 3,75 Jahre',
      'Nachkommateil in Monate: 0,75 × 12 = 9 Monate',
    ],
    ergebnis: 'Amortisiert nach 3,75 Jahren, also nach 3 Jahren und 9 Monaten',
  ),
  skizze(
    'n-wb-10',
    'w-breakeven',
    'Amortisation im Diagramm',
    'Trägt man die Rückflüsse Jahr für Jahr auf, erreicht die Linie irgendwann die Investitionssumme. Dort ist die Investition amortisiert.',
    const GeradenDiagramm(
      xAchse: 'Jahre',
      yAchse: 'Euro',
      xMax: 5,
      yMax: 40000,
      geraden: [
        Gerade('Investition', 30000, 0),
        Gerade('kumulierter Rückfluss', 0, 8000),
      ],
      punkte: [DiagrammPunkt(3.75, 30000, 'amortisiert')],
    ),
    points: [
      'Die Rückflusslinie steigt um 8.000 € pro Jahr.',
      'Nach 3,75 Jahren erreicht sie 30.000 €, danach erwirtschaftet die Investition Überschuss.',
    ],
  ),
  formel(
    'n-wb-11',
    'w-breakeven',
    'Return on Investment',
    'Der ROI setzt den Gewinn einer Investition ins Verhältnis zum eingesetzten Kapital. Je höher, desto besser rentiert sich die Investition.',
    'ROI = Gewinn / eingesetztes Kapital × 100 %\n'
        'Gewinn = Rückflüsse über die Nutzungsdauer - Investition',
    points: [
      'Beispiel: 20.000 € Investition bringt über die Nutzungsdauer 27.000 € Einsparung.',
      'Gewinn: 27.000 € - 20.000 € = 7.000 €',
      'ROI = 7.000 € / 20.000 € × 100 % = 35 %',
    ],
  ),
  falle(
    'n-wb-12',
    'w-breakeven',
    'Laufende Kosten vergessen, falsch runden',
    'Die Einsparung allein ist nicht der Rückfluss - laufende Kosten der neuen Lösung werden abgezogen, sonst wird die Amortisationsdauer zu kurz. Und eine Break-even-Menge von 333,3 Stück heißt 334 Stück: Mit 333 wäre die Schwelle noch nicht erreicht.',
  ),
  merke(
    'n-wb-13',
    'w-breakeven',
    'Merksatz',
    'Break-even und Amortisation folgen demselben Muster.',
    satz: 'Was einmal anfällt, geteilt durch das, was regelmäßig zurückfließt.',
  ),

  // ============================================================ Abnahme und Übergabe
  konzept(
    'n-aa-1',
    'a-abnahme',
    'Drei Ebenen des Abschlusses',
    'Ein Projekt ist erst abgeschlossen, wenn alle drei Ebenen erledigt sind.',
    points: [
      'Sachlich: Ergebnis abnehmen und an den Betrieb übergeben',
      'Wirtschaftlich: Nachkalkulation, Rechnungen, Budget schließen',
      'Personell: Team auflösen, Leistungen würdigen, Rückkehr in die Linie',
    ],
  ),
  ablauf(
    'n-aa-2',
    'a-abnahme',
    'Der Ablauf des Abschlusses',
    'Eine sinnvolle Reihenfolge - das Team wird zuletzt aufgelöst, weil es für Bericht und Lessons Learned noch gebraucht wird.',
    [
      'Restarbeiten erledigen, Ergebnis fertigstellen',
      'Abnahme des Ergebnisses durch den Auftraggeber',
      'Übergabe an den Betrieb mit Dokumentation und Schulung',
      'Nachkalkulation und Abschlussbericht',
      'Lessons-Learned-Workshop',
      'Auflösung des Projektteams',
    ],
  ),
  konzept(
    'n-aa-3',
    'a-abnahme',
    'Die Abnahme',
    'Bei der Abnahme prüft der Auftraggeber das Ergebnis gegen die vereinbarten Abnahmekriterien, meist aus dem Pflichtenheft, und erklärt, dass er es als im Wesentlichen vertragsgemäß annimmt.',
    points: [
      'Maßstab ist nur, was vereinbart war - nicht spätere Wünsche',
      'Abnahmekriterien werden deshalb schon bei der Planung prüfbar festgelegt',
      'das Ergebnis hält ein Abnahmeprotokoll fest',
    ],
  ),
  vergleich(
    'n-aa-4',
    'a-abnahme',
    'Was die Abnahme rechtlich bewirkt',
    'Bei Werkverträgen, etwa über eine Individualsoftware, ist die Abnahme ein rechtlicher Wendepunkt (§ 640 BGB).',
    [
      ['Folge', 'Bedeutung'],
      [
        'Vergütung fällig',
        'der Auftragnehmer darf die Schlussrechnung stellen',
      ],
      [
        'Gefahrübergang',
        'das Risiko des zufälligen Untergangs trägt nun der Auftraggeber',
      ],
      [
        'Beweislast kehrt sich um',
        'ab jetzt muss der Auftraggeber Mängel beweisen',
      ],
      ['Verjährung beginnt', 'die Frist für Mängelansprüche läuft'],
    ],
  ),
  vergleich(
    'n-aa-5',
    'a-abnahme',
    'Drei mögliche Ergebnisse',
    'Das Ergebnis der Abnahme hängt davon ab, ob und welche Mängel gefunden werden.',
    [
      ['Ergebnis', 'Wann', 'Folge'],
      ['abgenommen', 'keine Mängel festgestellt', 'Rechnung, Übergabe'],
      ['unter Vorbehalt', 'unwesentliche Mängel', 'Mängelliste mit Fristen'],
      ['verweigert', 'wesentliche Mängel', 'Nachbesserung, neuer Termin'],
    ],
    points: [
      'Wegen unwesentlicher Mängel darf die Abnahme nicht verweigert werden.',
      'Bekannte Mängel gehören ins Protokoll - wer ohne Vorbehalt abnimmt, verliert wichtige Mängelrechte.',
    ],
  ),
  ablauf(
    'n-aa-6',
    'a-abnahme',
    'So läuft eine Abnahme',
    'Eine Abnahme wird vorbereitet wie ein Test - nur dass am Ende der Auftraggeber entscheidet.',
    [
      'Abnahmekriterien vorab festlegen, zum Beispiel aus dem Pflichtenheft',
      'Termin, Teilnehmer und Testdaten abstimmen',
      'Abnahmetest gemeinsam durchführen',
      'Mängel dokumentieren und nach Schwere einstufen',
      'Entscheiden: abgenommen, unter Vorbehalt oder verweigert',
      'Abnahmeprotokoll von beiden Seiten unterschreiben',
    ],
  ),
  konzept(
    'n-aa-7',
    'a-abnahme',
    'Das Abnahmeprotokoll',
    'Das Abnahmeprotokoll belegt, was geprüft wurde, welche Mängel bestehen und wie entschieden wurde. Ohne Protokoll steht im Streitfall Aussage gegen Aussage.',
    table: [
      ['Inhalt', 'Beispiel'],
      ['Projekt, Datum, Teilnehmer', 'Ticketsystem, 14.05., Kunde und PL'],
      ['Prüfgegenstand', 'Version 1.0 laut Pflichtenheft'],
      ['Geprüfte Kriterien', '24 Abnahmetestfälle'],
      ['Mängel mit Frist', 'CSV-Export fehlerhaft, bis 28.05.'],
      ['Entscheidung', 'abgenommen unter Vorbehalt'],
      ['Unterschriften', 'Auftraggeber und Auftragnehmer'],
    ],
  ),
  vergleich(
    'n-aa-8',
    'a-abnahme',
    'Wie abgenommen werden kann',
    'Eine Abnahme muss nicht immer ein förmlicher Termin sein.',
    [
      ['Art', 'So geschieht sie'],
      ['förmlich', 'gemeinsamer Termin mit Protokoll'],
      [
        'stillschweigend (konkludent)',
        'Auftraggeber nutzt das Ergebnis vorbehaltlos',
      ],
      [
        'fiktiv',
        'Frist zur Abnahme läuft ab, ohne dass ein Mangel genannt wird',
      ],
    ],
    points: [
      'In IT-Projekten ist die förmliche Abnahme mit Protokoll der Normalfall.',
    ],
  ),
  konzept(
    'n-aa-9',
    'a-abnahme',
    'Übergabe an den Betrieb',
    'Nach dem Projekt muss jemand die Lösung betreiben. Damit das funktioniert, bekommt der Betrieb alles, was er braucht - und bestätigt die Übernahme.',
    points: [
      'Betriebs- und Benutzerdokumentation',
      'Schulung von Anwendern und Administratoren',
      'Zugangsdaten, Lizenzen und Verträge',
      'geregelter Support: Ansprechpartner und Service-Level',
      'Übergabeprotokoll',
    ],
  ),
  vergleich(
    'n-aa-10',
    'a-abnahme',
    'Einführungsstrategien',
    'Wie ein neues System in Betrieb geht, wird vorher festgelegt.',
    [
      ['Strategie', 'Vorteil', 'Nachteil'],
      ['Stichtag (Big Bang)', 'schnell, keine Doppelarbeit', 'hohes Risiko'],
      ['Parallelbetrieb', 'Rückfall jederzeit möglich', 'doppelter Aufwand'],
      ['stufenweise', 'Erfahrungen je Stufe nutzen', 'lange Übergangszeit'],
      ['Pilotbetrieb', 'Test unter Echtbedingungen', 'andere Bereiche warten'],
    ],
    points: [
      'stufenweise: Modul für Modul, etwa erst Lohnbuchhaltung, dann Finanzbuchhaltung',
      'Pilot: ein Bereich startet komplett, die anderen folgen nach der Auswertung',
    ],
  ),
  falle(
    'n-aa-11',
    'a-abnahme',
    'Mängel nicht festhalten',
    'Kleine Mängel, die bei der Abnahme bekannt sind, gehören ins Protokoll - sonst lässt sich später nicht mehr belegen, dass sie schon bei Übergabe bestanden, und wichtige Mängelrechte gehen verloren.',
  ),
  falle(
    'n-aa-12',
    'a-abnahme',
    'Erst abnehmen, dann übergeben',
    'Übergeben wird nur, was der Auftraggeber abgenommen hat. Und Vorsicht: Wer ein Ergebnis ohne Vorbehalt produktiv nutzt, kann es damit stillschweigend abgenommen haben.',
  ),
  merke(
    'n-aa-13',
    'a-abnahme',
    'Merksatz',
    'Die Abnahme ist der wichtigste Termin am Projektende.',
    satz: 'Keine Übergabe ohne Abnahme, keine Abnahme ohne Protokoll.',
  ),

  // ====================================================== Abschlussbericht und Soll-Ist
  konzept(
    'n-ab-1',
    'a-bericht',
    'Der Abschlussbericht',
    'Der Abschlussbericht fasst das Projekt für Auftraggeber und Lenkungsausschuss zusammen. Er beantwortet: Was sollte erreicht werden, was wurde erreicht, und warum weicht beides voneinander ab?',
  ),
  vergleich(
    'n-ab-2',
    'a-bericht',
    'Aufbau eines Abschlussberichts',
    'Diese Abschnitte gehören in jeden Abschlussbericht.',
    [
      ['Abschnitt', 'Inhalt'],
      ['Überblick', 'Auftrag, Ziele, Beteiligte'],
      ['Ergebnis', 'erreichte und verfehlte Ziele'],
      ['Soll-Ist-Vergleich', 'Leistung, Termine, Kosten'],
      ['Abweichungen', 'Ursachen und Folgen'],
      ['Offene Punkte', 'Restarbeiten, Restrisiken, Übergabe'],
      ['Erfahrungen', 'Lessons Learned, Empfehlungen'],
    ],
  ),
  konzept(
    'n-ab-3',
    'a-bericht',
    'Gemessen am magischen Dreieck',
    'Der Soll-Ist-Vergleich prüft alle drei Projektziele: Leistung, Zeit und Kosten. Maßstab ist der Projektauftrag einschließlich genehmigter Änderungen.',
    points: [
      'Leistung: Wurden alle Anforderungen in der vereinbarten Qualität umgesetzt?',
      'Zeit: Wurden Meilensteine und Endtermin gehalten?',
      'Kosten: Wurde das Budget eingehalten?',
    ],
  ),
  formel(
    'n-ab-4',
    'a-bericht',
    'Abweichungen berechnen',
    'Abweichungen werden absolut und relativ angegeben. Basis der relativen Abweichung ist immer das Soll.',
    'absolute Abweichung = Ist - Soll\n'
        'relative Abweichung = (Ist - Soll) / Soll × 100 %',
    points: [
      'positiv: mehr als geplant - bei Kosten und Dauer eine Überschreitung',
      'negativ: weniger als geplant - bei Kosten eine Unterschreitung',
    ],
  ),
  beispiel(
    'n-ab-5',
    'a-bericht',
    'Soll-Ist-Vergleich Ticketsystem',
    'Für die Einführung eines Ticketsystems waren 40.000 € und 12 Wochen geplant. Tatsächlich kostete es 46.000 € und dauerte 14 Wochen. Alle 8 Module wurden geliefert.',
    table: [
      ['Größe', 'Soll', 'Ist', 'Abweichung'],
      ['Kosten', '40.000 €', '46.000 €', '+6.000 € (+15 %)'],
      ['Dauer', '12 Wochen', '14 Wochen', '+2 Wochen (+16,7 %)'],
      ['Umfang', '8 Module', '8 Module', 'keine'],
    ],
    schritte: [
      'Kosten absolut: 46.000 € - 40.000 € = 6.000 €',
      'Kosten relativ: 6.000 € / 40.000 € × 100 % = 15 %',
      'Dauer: 14 - 12 = 2 Wochen; 2 / 12 × 100 % ≈ 16,7 %',
      'Umfang: vollständig geliefert, keine Abweichung',
    ],
    ergebnis:
        'Leistung erreicht, aber 15 % teurer und 2 Wochen später als geplant',
  ),
  skizze(
    'n-ab-6',
    'a-bericht',
    'Soll und Ist im Balkendiagramm',
    'Nach Kostenarten aufgeteilt zeigt sich, woher die Überschreitung kommt: absolut vor allem aus den Personalkosten, relativ sind die Sachkosten stärker gestiegen.',
    const BalkenDiagramm(
      [
        Balken('Personal Soll', 30000),
        Balken('Personal Ist', 34000, hervorheben: true),
        Balken('Sachkosten Soll', 10000),
        Balken('Sachkosten Ist', 12000, hervorheben: true),
      ],
      einheit: '€',
      max: 40000,
    ),
    points: [
      'Personal: +4.000 €, also 4.000 / 30.000 × 100 % ≈ +13,3 %',
      'Sachkosten: +2.000 €, also 2.000 / 10.000 × 100 % = +20 %',
      'Zusammen: +6.000 € auf 46.000 €',
    ],
  ),
  beispiel(
    'n-ab-7',
    'a-bericht',
    'Personalkosten nachkalkulieren',
    'Geplant waren 300 Stunden zu 50 €/h. Tatsächlich wurden 345 Stunden gebucht.',
    schritte: [
      'Soll: 300 h × 50 €/h = 15.000 €',
      'Ist: 345 h × 50 €/h = 17.250 €',
      'Abweichung absolut: 17.250 € - 15.000 € = 2.250 €',
      'Abweichung relativ: 2.250 € / 15.000 € × 100 % = 15 %',
    ],
    ergebnis: 'Personalkosten 2.250 € (15 %) über Plan',
  ),
  formel(
    'n-ab-8',
    'a-bericht',
    'Der Zielerreichungsgrad',
    'Wie viel vom Auftrag erfüllt ist, drückt der Zielerreichungsgrad aus.',
    'Zielerreichungsgrad = erreichte Ziele / geplante Ziele × 100 %',
    points: [
      'Beispiel: 7 von 8 Muss-Anforderungen umgesetzt',
      '7 / 8 × 100 % = 87,5 %',
      'Gezählt wird gegen den Projektauftrag mit genehmigten Änderungen, nicht gegen spätere Wünsche.',
    ],
  ),
  konzept(
    'n-ab-9',
    'a-bericht',
    'Abweichungen begründen',
    'Zu jeder deutlichen Abweichung gehören eine Ursache und eine Empfehlung. Typische Ursachen in IT-Projekten:',
    points: [
      'Aufwand zu niedrig geschätzt',
      'Änderungswünsche (Change Requests) ohne Anpassung von Budget und Termin',
      'Ausfall von Personal oder Lieferverzug',
      'technische Probleme, etwa mit Schnittstellen',
    ],
  ),
  falle(
    'n-ab-10',
    'a-bericht',
    'Nur Zahlen, keine Gründe',
    'Eine Abweichung ohne Begründung hilft niemandem. Wertvoll wird der Bericht erst, wenn er erklärt, warum die Kosten gestiegen sind - etwa durch eine nachträglich beauftragte Schnittstelle.',
  ),
  falle(
    'n-ab-11',
    'a-bericht',
    'Die falsche Bezugsgröße',
    'Die relative Abweichung bezieht sich immer auf das Soll. Wer (46.000 - 40.000) / 46.000 rechnet, erhält rund 13 % statt 15 % - und unterschätzt die Überschreitung.',
  ),
  merke(
    'n-ab-12',
    'a-bericht',
    'Merksatz',
    'Der Soll-Ist-Vergleich ist das Herzstück des Abschlussberichts.',
    satz:
        'Abweichung = Ist minus Soll, bezogen auf das Soll - und immer mit Begründung.',
  ),

  // ============================================================== Lessons Learned
  konzept(
    'n-al-1',
    'a-lessons',
    'Wozu Lessons Learned?',
    'Aus Erfahrungen soll Wissen für künftige Projekte werden. Ohne diesen Schritt wiederholt die nächste Projektgruppe dieselben Fehler - und muss erfolgreiche Lösungen neu erfinden.',
  ),
  konzept(
    'n-al-2',
    'a-lessons',
    'Wann Erfahrungen gesichert werden',
    'Der klassische Zeitpunkt ist das Projektende, solange die Erinnerungen frisch sind. Besser ist es, auch nach Phasen oder Meilensteinen innezuhalten - dann profitiert schon das laufende Projekt.',
    points: [
      'am Projektende: Lessons-Learned-Workshop',
      'projektbegleitend: nach Phasen und Meilensteinen',
      'in Scrum: Sprint-Retrospektive nach jedem Sprint',
    ],
  ),
  vergleich(
    'n-al-3',
    'a-lessons',
    'Lessons Learned oder Abschlussbericht?',
    'Beide entstehen am Projektende, haben aber verschiedene Aufgaben.',
    [
      ['', 'Lessons Learned', 'Abschlussbericht'],
      ['Frage', 'Was lernen wir daraus?', 'Was ist herausgekommen?'],
      [
        'Blick',
        'nach vorn, auf künftige Projekte',
        'zurück, auf Ziele und Zahlen',
      ],
      ['Zielgruppe', 'andere Projektteams', 'Auftraggeber, Lenkungsausschuss'],
    ],
  ),
  ablauf(
    'n-al-4',
    'a-lessons',
    'Ein Lessons-Learned-Workshop',
    'So läuft der Workshop üblicherweise ab.',
    [
      'Vorbereiten - Beteiligte einladen, Projektdaten bereitlegen',
      'Sammeln - was lief gut, was lief schlecht?',
      'Ursachen analysieren',
      'Empfehlungen für künftige Projekte ableiten',
      'Dokumentieren und für andere zugänglich ablegen',
    ],
  ),
  konzept(
    'n-al-5',
    'a-lessons',
    'Die Leitfragen',
    'Im Workshop führen wenige offene Fragen durch die Sammlung. Wichtig: Auch Erfolge werden gesammelt, nicht nur Fehler.',
    points: [
      'Was lief gut und sollte beibehalten werden?',
      'Was lief schlecht, und warum?',
      'Was würden wir beim nächsten Mal anders machen?',
      'Was hat uns überrascht?',
    ],
  ),
  vergleich(
    'n-al-6',
    'a-lessons',
    'Methode: Start - Stop - Continue',
    'Eine einfache Methode, die Erfahrungen direkt in Handlungen übersetzt.',
    [
      ['Frage', 'Beispiel'],
      ['Start: Was neu anfangen?', 'Fachbereich früher in Tests einbinden'],
      ['Stop: Was lassen?', 'Anforderungen nur mündlich abstimmen'],
      ['Continue: Was beibehalten?', 'tägliche Kurzabstimmung im Team'],
    ],
  ),
  vergleich(
    'n-al-7',
    'a-lessons',
    'Eine Lesson richtig formulieren',
    'Eine brauchbare Lesson beschreibt Situation, Ursache und Empfehlung so, dass ein fremdes Team sie versteht.',
    [
      ['Teil', 'Beispiel'],
      ['Situation', 'Der Go-live verschob sich um 2 Wochen.'],
      ['Ursache', 'Die Firewall-Freigabe dauerte 10 Tage.'],
      ['Empfehlung', 'Freigaben schon beim Projektstart beantragen.'],
    ],
    points: [
      'Zu allgemein: „Die Kommunikation verbessern.“ - daraus folgt keine Handlung.',
    ],
  ),
  konzept(
    'n-al-8',
    'a-lessons',
    'Wissen verfügbar machen',
    'Lessons Learned wirken nur, wenn das nächste Team sie findet und nutzt.',
    points: [
      'zentral ablegen, zum Beispiel im Wiki oder Projektportal',
      'verschlagworten: Projektart, Technik, Phase',
      'Checklisten und Vorlagen anpassen',
      'beim Start neuer Projekte gezielt durchsehen',
    ],
  ),
  falle(
    'n-al-9',
    'a-lessons',
    'Keine Schuldfrage',
    'Geht es um Schuld, schweigen die Beteiligten - und die wichtigsten Erkenntnisse gehen verloren. Lessons Learned fragen nach Ursachen und Verbesserungen, nicht nach Verantwortlichen.',
  ),
  konzept(
    'n-al-10',
    'a-lessons',
    'Auch bei Abbruch',
    'Gerade abgebrochene Projekte liefern die wertvollsten Erkenntnisse. Auch sie brauchen einen geordneten Abschluss mit Bericht und Lessons Learned.',
  ),
  falle(
    'n-al-11',
    'a-lessons',
    'Zu spät, zu einseitig, zu vage',
    'Drei Fehler machen Lessons Learned wertlos: Der Workshop findet Monate nach Projektende statt, wenn sich niemand mehr erinnert. Es wird nur gesammelt, was schieflief, obwohl auch Erfolge übertragbar sind. Und die Ergebnisse bleiben so vage, dass niemand weiß, was er anders machen soll.',
  ),
  merke(
    'n-al-12',
    'a-lessons',
    'Merksatz',
    'Der Aufwand lohnt sich nur, wenn die Erkenntnisse beim nächsten Projekt ankommen.',
    satz:
        'Lessons Learned machen aus Erfahrung Wissen - für das nächste Projekt, nicht für das Protokoll.',
  ),
];
