import '../../models/nugget.dart';

/// Feed-Beiträge zu Bereich 01 - Projekte & Projektmanagement.
const List<Nugget> nuggetsA01 = [
  // ---------------------------------------------------------------- Netzplan
  Nugget(
    id: 'n-netzplan-formeln',
    topicId: 'netzplan',
    subtopicId: 'n-vorwaerts',
    kind: NuggetKind.formel,
    title: 'Netzplan: die sechs Formeln',
    body:
        'Mehr braucht es nicht. Vorwärts rechnest du die frühesten, rückwärts die spätesten Zeiten - danach ergeben sich die Puffer von selbst.',
    code: 'FAZ = max(FEZ aller Vorgänger)   Start: 0\n'
        'FEZ = FAZ + Dauer\n'
        'SEZ = min(SAZ aller Nachfolger)  Ende: Projektdauer\n'
        'SAZ = SEZ - Dauer\n'
        'GP  = SAZ - FAZ\n'
        'FP  = min(FAZ aller Nachfolger) - FEZ',
    merksatz: 'Vorwärts das Maximum, rückwärts das Minimum.',
  ),
  Nugget(
    id: 'n-netzplan-puffer-falle',
    topicId: 'netzplan',
    subtopicId: 'n-puffer',
    kind: NuggetKind.fehlerfalle,
    title: 'Gesamtpuffer ist nicht freier Puffer',
    body:
        'Der Gesamtpuffer sagt, wie lange sich ein Vorgang verspäten darf, ohne das Projektende zu verschieben. Der freie Puffer sagt, wie lange er sich verspäten darf, ohne den frühesten Start eines Nachfolgers zu verschieben.',
    points: [
      'Häufigster Fehler: den freien Puffer mit dem SAZ statt dem FAZ des Nachfolgers rechnen.',
      'Der freie Puffer ist nie größer als der Gesamtpuffer.',
      'GP = 2 und FP = 0 ist möglich: Der Vorgang hat Luft, nimmt sie aber seinem Nachfolger weg.',
    ],
  ),
  Nugget(
    id: 'n-netzplan-kritischer-pfad',
    topicId: 'netzplan',
    subtopicId: 'n-kritisch',
    kind: NuggetKind.konzept,
    title: 'Der kritische Pfad',
    body:
        'Die Kette aller Vorgänge mit Gesamtpuffer 0, vom Start bis zum Ende. Sie ist der längste Weg durch den Netzplan und bestimmt die Projektdauer.',
    points: [
      'Jede Verzögerung auf dem kritischen Pfad verschiebt das Projektende.',
      'Es kann mehrere kritische Pfade geben, wenn Wege gleich lang sind.',
      'Wird ein kritischer Vorgang verkürzt, kann ein anderer Weg kritisch werden.',
    ],
    merksatz: 'Kritisch heißt: kein Puffer, nicht: lange Dauer.',
  ),

  // ------------------------------------------------- Projektorganisation
  Nugget(
    id: 'n-org-formen',
    topicId: 'projektorganisation',
    subtopicId: 'p-organisation',
    kind: NuggetKind.vergleich,
    title: 'Drei Formen der Projektorganisation',
    body:
        'Die Formen unterscheiden sich darin, wie viel die Projektleitung zu sagen hat - und wie stark das Team aus der Linie herausgelöst wird.',
    table: [
      ['Form', 'Weisungsbefugnis der PL', 'Passt zu'],
      ['Reine Projektorganisation', 'fachlich und disziplinarisch', 'großen, langen, kritischen Projekten'],
      ['Matrix-Organisation', 'fachlich (disziplinarisch bleibt in der Linie)', 'dem Normalfall mittlerer Projekte'],
      ['Stabs-/Einflussorganisation', 'keine, nur koordinierend', 'kleinen Projekten mit wenig Konfliktpotenzial'],
    ],
  ),
  Nugget(
    id: 'n-org-magisches-dreieck',
    topicId: 'projektorganisation',
    subtopicId: 'p-ziele',
    kind: NuggetKind.konzept,
    title: 'Das magische Dreieck',
    body:
        'Zeit, Kosten und Leistung bzw. Qualität hängen voneinander ab. Ändert sich eine Ecke, muss mindestens eine andere nachgeben.',
    points: [
      'Mehr Leistung bei gleicher Zeit kostet mehr Geld.',
      'Weniger Budget bei gleicher Leistung braucht mehr Zeit.',
      'In Prüfungsaufgaben steht meist, welche zwei Ecken fest sind - die dritte ist die Antwort.',
    ],
  ),
  Nugget(
    id: 'n-org-smart',
    topicId: 'projektorganisation',
    subtopicId: 'p-ziele',
    kind: NuggetKind.merksatz,
    title: 'SMART formulierte Ziele',
    body: 'Ein Projektziel ist erst prüfbar, wenn alle fünf Kriterien erfüllt sind.',
    points: [
      'Spezifisch - eindeutig beschrieben',
      'Messbar - mit einer Kennzahl überprüfbar',
      'Attraktiv bzw. akzeptiert - von den Beteiligten getragen',
      'Realistisch - mit den Mitteln erreichbar',
      'Terminiert - mit festem Datum',
    ],
    merksatz:
        '"Die Software soll schneller werden" ist nicht SMART. "Die Suche liefert bis 30.06. Ergebnisse in unter 2 Sekunden" schon.',
  ),

  // ------------------------------------------------------ Vorgehensmodelle
  Nugget(
    id: 'n-vorgehen-wasserfall-scrum',
    topicId: 'vorgehensmodelle',
    subtopicId: 'v-auswahl',
    kind: NuggetKind.vergleich,
    title: 'Wasserfall oder Scrum?',
    body:
        'Seit dem Katalog 2025 sind das die beiden Vorgehensmodelle der AP1. Gefragt wird meist, welches zu einer beschriebenen Situation passt.',
    table: [
      ['', 'Wasserfall', 'Scrum'],
      ['Planung', 'vollständig vorab', 'je Sprint neu'],
      ['Anforderungen', 'fest im Lastenheft', 'veränderlich im Product Backlog'],
      ['Ergebnis', 'am Projektende', 'nach jedem Sprint ein nutzbares Increment'],
      ['Passt bei', 'klaren, stabilen Anforderungen', 'unklaren, sich ändernden Anforderungen'],
    ],
  ),

  // ------------------------------------------------------------------ Scrum
  Nugget(
    id: 'n-scrum-rollen',
    topicId: 'agil_scrum',
    subtopicId: 's-rollen',
    kind: NuggetKind.vergleich,
    title: 'Die drei Verantwortlichkeiten in Scrum',
    body:
        'Ein Scrum Team hat keine Hierarchie, aber drei klar getrennte Verantwortlichkeiten.',
    table: [
      ['Rolle', 'Verantwortlich für'],
      ['Product Owner', 'den Wert des Produkts; pflegt und priorisiert das Product Backlog'],
      ['Scrum Master', 'die Wirksamkeit des Teams; beseitigt Hindernisse, coacht'],
      ['Developers', 'in jedem Sprint ein nutzbares Increment'],
    ],
    merksatz: 'Wer priorisiert? Immer der Product Owner - nie der Scrum Master.',
  ),
  Nugget(
    id: 'n-scrum-events',
    topicId: 'agil_scrum',
    subtopicId: 's-events',
    kind: NuggetKind.ablauf,
    title: 'Ein Sprint von innen',
    body:
        'Der Sprint ist der Rahmen für alle anderen Events und dauert höchstens einen Monat.',
    points: [
      'Sprint Planning - was wird in diesem Sprint geschafft und wie?',
      'Daily Scrum - täglich 15 Minuten, Blick auf das Sprint-Ziel',
      'Sprint Review - das Increment wird den Stakeholdern gezeigt',
      'Sprint Retrospective - das Team verbessert seine Zusammenarbeit',
    ],
    merksatz: 'Die Review schaut aufs Produkt, die Retro aufs Team.',
  ),

  // --------------------------------------------------- Wirtschaftlichkeit
  Nugget(
    id: 'n-wirtschaft-break-even',
    topicId: 'pm_wirtschaftlichkeit',
    subtopicId: 'w-breakeven',
    kind: NuggetKind.formel,
    title: 'Break-even-Menge berechnen',
    body:
        'Ab dieser Stückzahl deckt der Erlös alle Kosten. Jedes weitere Stück bringt Gewinn in Höhe seines Deckungsbeitrags.',
    code: 'Deckungsbeitrag je Stück = Preis - variable Stückkosten\n'
        'Break-even-Menge = Fixkosten / Deckungsbeitrag je Stück',
    merksatz: 'Fixkosten geteilt durch das, was jedes Stück zu ihnen beiträgt.',
  ),

  // ------------------------------------------------------ Risikomanagement
  Nugget(
    id: 'n-risiko-bewertung',
    topicId: 'risikomanagement',
    subtopicId: 'r-bewertung',
    kind: NuggetKind.formel,
    title: 'Risiken bewerten und behandeln',
    body:
        'Risiken werden vergleichbar, wenn man Wahrscheinlichkeit und Schaden zusammen betrachtet. Danach wird für jedes Risiko eine Strategie gewählt.',
    code: 'Risikowert = Eintrittswahrscheinlichkeit × Schadenshöhe',
    points: [
      'Vermeiden - die Ursache beseitigen',
      'Vermindern - Wahrscheinlichkeit oder Schaden senken',
      'Übertragen - z. B. auf eine Versicherung oder einen Dienstleister',
      'Akzeptieren - bewusst tragen, wenn der Aufwand größer wäre als der Schaden',
    ],
  ),
];
