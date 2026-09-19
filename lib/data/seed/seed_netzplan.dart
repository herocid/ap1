import '../models/netzplan.dart';
import '../models/question.dart';

Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Netzplantechnik und Terminplanung.
///
/// Bei den Aufgaben vom Typ [QuestionKind.netzplan] werden nur die Vorgaenge
/// hinterlegt - FAZ/FEZ/SAZ/SEZ/GP/FP und der kritische Pfad rechnet der
/// [NetzplanSolver] selbst aus. Dadurch kann eine Musterloesung gar nicht
/// von der Aufgabe abweichen.
final List<Question> seedNetzplan = [
  Question(
    id: 'np-001',
    topicId: 'netzplan',
    kind: QuestionKind.netzplan,
    difficulty: 1,
    tags: ['vorwaertsrechnung'],
    scenario:
        'Fuer die Einfuehrung eines Ticketsystems wurden folgende Vorgaenge '
        'geplant. Alle Zeiten in Arbeitstagen.',
    prompt:
        'Fuehre die Vorwaertsrechnung durch: trage FAZ und FEZ fuer jeden '
        'Vorgang ein.',
    activities: const [
      Activity(id: 'A', name: 'Anforderungsanalyse', duration: 4),
      Activity(id: 'B', name: 'Grobkonzept', duration: 3, predecessors: ['A']),
      Activity(id: 'C', name: 'Hardwarebeschaffung', duration: 6, predecessors: ['A']),
      Activity(id: 'D', name: 'Implementierung', duration: 5, predecessors: ['B']),
      Activity(id: 'E', name: 'Integrationstest', duration: 2, predecessors: ['C', 'D']),
    ],
    askedFields: const [NodeField.faz, NodeField.fez],
    explanation:
        'Vorwaertsrechnung, Regel: FAZ = groesster FEZ aller Vorgaenger '
        '(Startvorgang: 0), FEZ = FAZ + Dauer.\n\n'
        'A: FAZ 0, FEZ 0+4 = 4\n'
        'B: FAZ 4 (nach A), FEZ 4+3 = 7\n'
        'C: FAZ 4 (nach A), FEZ 4+6 = 10\n'
        'D: FAZ 7 (nach B), FEZ 7+5 = 12\n'
        'E: FAZ = max(FEZ C = 10, FEZ D = 12) = 12, FEZ 12+2 = 14\n\n'
        'Der haeufigste Fehler: bei E den kleineren Wert nehmen. Bei mehreren '
        'Vorgaengern gilt immer das MAXIMUM - der Vorgang kann erst starten, '
        'wenn der letzte Vorgaenger fertig ist. Projektdauer: 14 Arbeitstage.',
  ),

  Question(
    id: 'np-002',
    topicId: 'netzplan',
    kind: QuestionKind.netzplan,
    difficulty: 2,
    tags: ['vollstaendig', 'puffer'],
    scenario:
        'Migration eines Warenwirtschaftssystems. Dauer in Arbeitstagen.',
    prompt:
        'Berechne den kompletten Netzplan: FAZ, FEZ, SAZ, SEZ sowie Gesamt- und '
        'freien Puffer.',
    activities: const [
      Activity(id: 'A', name: 'Ist-Analyse', duration: 3),
      Activity(id: 'B', name: 'Datenmodell', duration: 5, predecessors: ['A']),
      Activity(id: 'C', name: 'Schulungskonzept', duration: 2, predecessors: ['A']),
      Activity(id: 'D', name: 'Migrationsskripte', duration: 4, predecessors: ['B']),
      Activity(id: 'E', name: 'Schulung', duration: 6, predecessors: ['C']),
      Activity(id: 'F', name: 'Go-Live', duration: 3, predecessors: ['D', 'E']),
    ],
    askedFields: const [
      NodeField.faz,
      NodeField.fez,
      NodeField.saz,
      NodeField.sez,
      NodeField.gp,
      NodeField.fp,
    ],
    explanation:
        'Vorwaerts (FAZ = max FEZ der Vorgaenger, FEZ = FAZ + D):\n'
        'A 0/3, B 3/8, C 3/5, D 8/12, E 5/11, F max(12,11)=12/15\n'
        'Projektdauer = 15 Arbeitstage.\n\n'
        'Rueckwaerts (SEZ = min SAZ der Nachfolger, Endvorgang: SEZ = Projektdauer, '
        'SAZ = SEZ - D):\n'
        'F 12/15, D 8/12, E 6/12, B 3/8, C 4/6, A 0/3\n\n'
        'Puffer:\n'
        'GP = SAZ - FAZ  ->  A 0, B 0, C 1, D 0, E 1, F 0\n'
        'FP = min(FAZ der Nachfolger) - FEZ  ->  A 0, B 0, C 0, D 0, E 1, F 0\n\n'
        'Der Lerneffekt steckt in Vorgang C: GP = 1, aber FP = 0. Man kann C '
        'zwar um einen Tag verschieben, ohne das Projektende zu gefaehrden - '
        'aber der Nachfolger E startet dann spaeter. Freier Puffer heisst: '
        'verschiebbar OHNE den fruehesten Start des Nachfolgers anzutasten. '
        'Kritischer Pfad: A - B - D - F.',
  ),

  Question(
    id: 'np-003',
    topicId: 'netzplan',
    kind: QuestionKind.numeric,
    difficulty: 2,
    tags: ['gesamtpuffer'],
    scenario:
        'Gegeben ist folgender Netzplan (Dauer in Tagen):\n'
        'A: 2 Tage, kein Vorgaenger\n'
        'B: 4 Tage, Vorgaenger A\n'
        'C: 3 Tage, Vorgaenger A\n'
        'D: 5 Tage, Vorgaenger B\n'
        'E: 2 Tage, Vorgaenger C\n'
        'F: 1 Tag, Vorgaenger D und E',
    prompt: 'Wie gross ist der Gesamtpuffer (GP) von Vorgang C?',
    numericAnswer: 4,
    numericTolerance: 0,
    unit: 'Tage',
    explanation:
        'Vorwaertsrechnung:\n'
        'A 0/2, B 2/6, C 2/5, D 6/11, E 5/7, F max(11,7)=11/12 -> Projektdauer 12\n\n'
        'Rueckwaertsrechnung:\n'
        'F 11/12, D 6/11, E 9/11, B 2/6, C 6/9, A 0/2\n\n'
        'GP(C) = SAZ(C) - FAZ(C) = 6 - 2 = 4 Tage.\n'
        'Gegenprobe ueber die andere Formel: GP = SEZ - FEZ = 9 - 5 = 4. '
        'Stimmen beide Werte nicht ueberein, steckt ein Rechenfehler in der '
        'Rueckwaertsrechnung.',
  ),

  Question(
    id: 'np-004',
    topicId: 'netzplan',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['puffer', 'definition'],
    prompt: 'Was sagt der freie Puffer (FP) eines Vorgangs aus?',
    choices: [
      _c('Die Zeit, um die der Vorgang verschoben werden kann, ohne den fruehesten Anfang seiner Nachfolger zu veraendern.', true,
          'Richtig. FP = kleinster FAZ der Nachfolger minus eigener FEZ. Diesen Puffer darf man aufbrauchen, ohne dass es irgendjemand anders merkt.'),
      _c('Die Zeit, um die der Vorgang verschoben werden kann, ohne das Projektende zu gefaehrden.', false,
          'Das ist die Definition des GESAMTpuffers (GP = SAZ - FAZ). Der GP ist immer groesser oder gleich dem FP.'),
      _c('Die Differenz zwischen geplanter und tatsaechlicher Dauer.', false,
          'Das waere eine Abweichung im Projektcontrolling, kein Puffer aus der Netzplantechnik.'),
      _c('Die Reservezeit, die das Projektteam zusaetzlich einplant.', false,
          'Das ist eine Sicherheitsreserve. Puffer im Netzplan werden berechnet, nicht eingeplant.'),
    ],
    explanation:
        'GP = SAZ - FAZ = SEZ - FEZ: Spielraum bis das PROJEKTENDE kippt.\n'
        'FP = min(FAZ der Nachfolger) - FEZ: Spielraum bis der NACHFOLGER '
        'betroffen ist.\n'
        'Es gilt immer FP <= GP. Auf dem kritischen Pfad sind beide 0. '
        'Ein Vorgang mit GP > 0 und FP = 0 hat zwar Luft bis zum Projektende, '
        'nimmt sie aber direkt dem Nachfolger weg.',
  ),

  Question(
    id: 'np-005',
    topicId: 'netzplan',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['kritischer_pfad'],
    prompt: 'Welche Aussagen ueber den kritischen Pfad sind richtig?',
    choices: [
      _c('Alle Vorgaenge auf ihm haben einen Gesamtpuffer von 0.', true,
          'Das ist die Definition. Genau daran erkennt man ihn in der Rechnung.'),
      _c('Er ist der laengste Weg durch den Netzplan.', true,
          'Der laengste Weg bestimmt die Projektdauer - deshalb hat er keinen Puffer.'),
      _c('Verzoegert sich ein Vorgang auf ihm um 2 Tage, verzoegert sich das Projektende um 2 Tage.', true,
          'Ohne Puffer schlaegt jede Verzoegerung eins zu eins aufs Projektende durch.'),
      _c('Ein Netzplan hat immer genau einen kritischen Pfad.', false,
          'Falsch. Es kann mehrere gleich lange kritische Pfade geben - dann ist das Projekt besonders anfaellig, weil es mehrere pufferlose Ketten gibt.'),
      _c('Er enthaelt immer die Vorgaenge mit der laengsten Einzeldauer.', false,
          'Falsch. Ein einzelner langer Vorgang kann parallel liegen und viel Puffer haben. Entscheidend ist die Kette, nicht die Einzeldauer.'),
      _c('Eine Verkuerzung eines Vorgangs auf dem kritischen Pfad verkuerzt immer das Projekt um denselben Betrag.', false,
          'Falsch, und das ist der beliebteste Stolperstein: verkuerzt man genug, wird ein anderer Weg zum kritischen Pfad und die Verkuerzung verpufft ab diesem Punkt.'),
    ],
    explanation:
        'Der kritische Pfad ist der laengste Weg vom Start- zum Endvorgang und '
        'damit die Kette ohne Puffer. Praktische Konsequenz fuers Projekt: '
        'Ressourcen und Aufmerksamkeit gehoeren zuerst dorthin. Bei '
        'Verkuerzungsaufgaben immer nach jedem Schritt neu rechnen - der '
        'kritische Pfad kann wandern.',
  ),

  Question(
    id: 'np-006',
    topicId: 'netzplan',
    kind: QuestionKind.netzplan,
    difficulty: 3,
    tags: ['puffer', 'kritischer_pfad'],
    scenario:
        'Aufbau eines neuen Serverraums, sieben Vorgaenge, Dauer in Arbeitstagen.',
    prompt:
        'Ermittle fuer jeden Vorgang den Gesamtpuffer und den freien Puffer.',
    activities: const [
      Activity(id: 'A', name: 'Planung', duration: 2),
      Activity(id: 'B', name: 'Elektro-Vorbereitung', duration: 4, predecessors: ['A']),
      Activity(id: 'C', name: 'Lieferung Racks', duration: 6, predecessors: ['A']),
      Activity(id: 'D', name: 'Klimatechnik', duration: 3, predecessors: ['B']),
      Activity(id: 'E', name: 'Netzwerkverkabelung', duration: 2, predecessors: ['B']),
      Activity(id: 'F', name: 'Hardware-Montage', duration: 4, predecessors: ['D', 'C']),
      Activity(id: 'G', name: 'Inbetriebnahme', duration: 3, predecessors: ['E', 'F']),
    ],
    askedFields: const [NodeField.gp, NodeField.fp],
    explanation:
        'Vorwaerts: A 0/2, B 2/6, C 2/8, D 6/9, E 6/8, F max(9,8)=9/13, '
        'G max(8,13)=13/16. Projektdauer 16 Tage.\n\n'
        'Rueckwaerts: G 13/16, F 9/13, E 11/13, D 6/9, C 3/9, B 2/6, A 0/2.\n\n'
        'GP = SAZ - FAZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0\n'
        'FP = min(FAZ Nachfolger) - FEZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0\n\n'
        'Kritischer Pfad: A - B - D - F - G (16 Tage).\n'
        'Vorgang E hat mit 5 Tagen den groessten Spielraum - hier kann man ohne '
        'Risiko Personal abziehen, wenn es auf dem kritischen Pfad brennt. '
        'Achtung bei C: die Lieferung dauert zwar am laengsten (6 Tage), liegt '
        'aber trotzdem nicht auf dem kritischen Pfad.',
  ),

  Question(
    id: 'np-007',
    topicId: 'netzplan',
    kind: QuestionKind.numeric,
    difficulty: 1,
    tags: ['projektdauer'],
    scenario:
        'A: 5 Tage, kein Vorgaenger\n'
        'B: 3 Tage, kein Vorgaenger\n'
        'C: 4 Tage, Vorgaenger A und B\n'
        'D: 6 Tage, Vorgaenger A\n'
        'E: 2 Tage, Vorgaenger C und D',
    prompt: 'Wie lang dauert das Gesamtprojekt?',
    numericAnswer: 13,
    numericTolerance: 0,
    unit: 'Tage',
    explanation:
        'Alle Wege durchrechnen und den laengsten nehmen:\n'
        'A - C - E = 5 + 4 + 2 = 11\n'
        'B - C - E = 3 + 4 + 2 = 9\n'
        'A - D - E = 5 + 6 + 2 = 13  <- laengster Weg\n'
        'Projektdauer = 13 Tage, kritischer Pfad A - D - E.\n'
        'Kontrolle ueber die Vorwaertsrechnung: C startet bei max(5, 3) = 5, '
        'endet bei 9. D endet bei 11. E startet bei max(9, 11) = 11 und endet '
        'bei 13.',
  ),

  // ----------------------------------------------------------- Terminplanung
  Question(
    id: 'tp-001',
    topicId: 'terminplanung',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['gantt'],
    prompt:
        'Welchen Vorteil hat ein Netzplan gegenueber einem einfachen Balkenplan '
        '(Gantt-Diagramm)?',
    choices: [
      _c('Er zeigt Abhaengigkeiten und Puffer explizit und macht den kritischen Pfad berechenbar.', true,
          'Richtig. Der Netzplan ist ein Rechenmodell: Puffer und kritischer Pfad ergeben sich rechnerisch, nicht durch Hinsehen.'),
      _c('Er stellt den Zeitverlauf anschaulicher dar.', false,
          'Das ist gerade die Staerke des Balkenplans: Die Zeitachse ist massstabsgetreu und auf einen Blick lesbar.'),
      _c('Er benoetigt keine Angabe von Vorgangsdauern.', false,
          'Ohne Dauern gibt es keine Vorwaerts- und Rueckwaertsrechnung. Der Netzplan braucht sie zwingend.'),
      _c('Er eignet sich besser fuer die Praesentation vor der Geschaeftsfuehrung.', false,
          'Umgekehrt. Fuer Praesentationen nimmt man den Balkenplan, weil er ohne Erklaerung verstaendlich ist.'),
    ],
    explanation:
        'Arbeitsteilung in der Praxis: mit dem Netzplan rechnen, mit dem '
        'Balkenplan kommunizieren. Moderne Tools erzeugen den Gantt direkt aus '
        'den Netzplandaten und zeichnen den kritischen Pfad rot ein - '
        'in der Pruefung muss man beides aber getrennt beherrschen.',
  ),

  Question(
    id: 'tp-002',
    topicId: 'terminplanung',
    kind: QuestionKind.single,
    difficulty: 1,
    tags: ['meilenstein'],
    prompt: 'Was kennzeichnet einen Meilenstein in der Projektplanung?',
    choices: [
      _c('Ein Ereignis mit der Dauer null, an dem ein definiertes Zwischenergebnis vorliegt.', true,
          'Richtig. Ein Meilenstein verbraucht keine Zeit und keine Ressourcen - er stellt nur fest, ob ein Ergebnis erreicht ist.'),
      _c('Der laengste Vorgang im Projekt.', false,
          'Das hat mit Meilensteinen nichts zu tun; lange Vorgaenge sind einfach Vorgaenge.'),
      _c('Ein Vorgang, der besonders viel Budget bindet.', false,
          'Budget ist kein Kriterium. Ein Meilenstein kostet definitionsgemaess nichts.'),
      _c('Der Abschluss des gesamten Projekts.', false,
          'Der Projektabschluss IST ein Meilenstein, aber Meilensteine gibt es waehrend des gesamten Projekts.'),
    ],
    explanation:
        'Meilensteine sind Entscheidungspunkte: Ergebnis da oder nicht, weiter '
        'oder nicht. Gute Meilensteine sind binaer pruefbar formuliert '
        '("Pflichtenheft vom Kunden unterzeichnet"), nicht schwammig '
        '("Konzept weitgehend fertig"). In der Meilensteintrendanalyse (MTA) '
        'traegt man ueber die Zeit auf, wie sich die geplanten '
        'Meilensteintermine verschieben - eine steigende Linie bedeutet '
        'Verzug.',
  ),

  Question(
    id: 'tp-003',
    topicId: 'terminplanung',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['mta'],
    prompt:
        'Ein Meilensteintrendanalyse-Diagramm zeigt fuer einen Meilenstein eine '
        'nach oben steigende Linie. Welche Schluesse sind zulaessig?',
    choices: [
      _c('Der Meilenstein verschiebt sich immer weiter nach hinten.', true,
          'Richtig. Steigende Linie = der prognostizierte Termin wird bei jedem Berichtszeitpunkt spaeter.'),
      _c('Es besteht Handlungsbedarf, z. B. Ressourcen umsteuern oder Umfang kuerzen.', true,
          'Die MTA ist ein Fruehwarninstrument - der Zweck ist genau dieses Gegensteuern.'),
      _c('Der Meilenstein wird frueher als geplant erreicht.', false,
          'Falsch, das waere eine FALLENDE Linie. Steigend = spaeter.'),
      _c('Das Projekt liegt im Plan.', false,
          'Falsch. Im Plan bedeutet eine waagerechte Linie.'),
      _c('Die Ursache der Verzoegerung laesst sich direkt aus dem Diagramm ablesen.', false,
          'Falsch. Die MTA zeigt, DASS sich etwas verschiebt, nicht WARUM. Die Ursachenanalyse ist eine separate Aufgabe.'),
    ],
    explanation:
        'MTA-Lesehilfe: waagerecht = im Plan, steigend = Verzug, fallend = '
        'frueher fertig, Zickzack = unsichere Schaetzung bzw. instabile '
        'Planung. Ein Zickzack ist ein Warnsignal fuer die Planungsqualitaet, '
        'auch wenn der Endtermin am Ende stimmt.',
  ),

  Question(
    id: 'tp-004',
    topicId: 'terminplanung',
    kind: QuestionKind.numeric,
    difficulty: 3,
    tags: ['ressourcenplanung'],
    scenario:
        'Fuer ein Arbeitspaket sind 120 Personentage veranschlagt. Es stehen '
        '4 Entwickler zur Verfuegung, die jedoch nur zu 75 % fuer das Projekt '
        'verfuegbar sind (der Rest geht in Support und Linientaetigkeit).',
    prompt:
        'Wie viele Arbeitstage dauert das Arbeitspaket? Runde auf volle Tage auf.',
    numericAnswer: 40,
    numericTolerance: 0,
    unit: 'Arbeitstage',
    explanation:
        'Rechenweg:\n'
        '1. Tatsaechliche Kapazitaet pro Tag = 4 Entwickler x 0,75 = 3 Personentage/Tag\n'
        '2. Dauer = 120 Personentage / 3 Personentage pro Tag = 40 Arbeitstage\n\n'
        'Typischer Fehler: 120 / 4 = 30 Tage - die Verfuegbarkeit wird '
        'vergessen. In Pruefungsaufgaben ist der Verfuegbarkeitsgrad fast '
        'immer der eigentliche Pruefpunkt. Merke ausserdem: Personentage sind '
        'Aufwand, Arbeitstage sind Dauer. Die beiden Einheiten zu verwechseln '
        'kostet in der Klausur sofort Punkte.',
  ),
];
