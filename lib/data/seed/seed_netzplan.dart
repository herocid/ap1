import '../models/netzplan.dart';
import '../models/question.dart';

Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Netzplantechnik und Terminplanung.
///
/// Bei den Aufgaben vom Typ [QuestionKind.netzplan] werden nur die Vorgänge
/// hinterlegt - FAZ/FEZ/SAZ/SEZ/GP/FP und der kritische Pfad rechnet der
/// [NetzplanSolver] selbst aus. Dadurch kann eine Musterlösung gar nicht
/// von der Aufgabe abweichen.
final List<Question> seedNetzplan = [
  Question(
    id: 'np-001',
    topicId: 'netzplan',
    kind: QuestionKind.netzplan,
    difficulty: 1,
    tags: ['vorwärtsrechnung'],
    scenario:
        'Für die Einführung eines Ticketsystems wurden folgende Vorgänge '
        'geplant. Alle Zeiten in Arbeitstagen.',
    prompt:
        'Führe die Vorwärtsrechnung durch: trage FAZ und FEZ für jeden '
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
        'Vorwärtsrechnung, Regel: FAZ = größter FEZ aller Vorgänger '
        '(Startvorgang: 0), FEZ = FAZ + Dauer.\n\n'
        'A: FAZ 0, FEZ 0+4 = 4\n'
        'B: FAZ 4 (nach A), FEZ 4+3 = 7\n'
        'C: FAZ 4 (nach A), FEZ 4+6 = 10\n'
        'D: FAZ 7 (nach B), FEZ 7+5 = 12\n'
        'E: FAZ = max(FEZ C = 10, FEZ D = 12) = 12, FEZ 12+2 = 14\n\n'
        'Der häufigste Fehler: bei E den kleineren Wert nehmen. Bei mehreren '
        'Vorgängern gilt immer das MAXIMUM - der Vorgang kann erst starten, '
        'wenn der letzte Vorgänger fertig ist. Projektdauer: 14 Arbeitstage.',
  ),

  Question(
    id: 'np-002',
    topicId: 'netzplan',
    kind: QuestionKind.netzplan,
    difficulty: 2,
    tags: ['vollständig', 'puffer'],
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
        'Vorwärts (FAZ = max FEZ der Vorgänger, FEZ = FAZ + D):\n'
        'A 0/3, B 3/8, C 3/5, D 8/12, E 5/11, F max(12,11)=12/15\n'
        'Projektdauer = 15 Arbeitstage.\n\n'
        'Rückwärts (SEZ = min SAZ der Nachfolger, Endvorgang: SEZ = Projektdauer, '
        'SAZ = SEZ - D):\n'
        'F 12/15, D 8/12, E 6/12, B 3/8, C 4/6, A 0/3\n\n'
        'Puffer:\n'
        'GP = SAZ - FAZ  ->  A 0, B 0, C 1, D 0, E 1, F 0\n'
        'FP = min(FAZ der Nachfolger) - FEZ  ->  A 0, B 0, C 0, D 0, E 1, F 0\n\n'
        'Der Lerneffekt steckt in Vorgang C: GP = 1, aber FP = 0. Man kann C '
        'zwar um einen Tag verschieben, ohne das Projektende zu gefährden - '
        'aber der Nachfolger E startet dann später. Freier Puffer heißt: '
        'verschiebbar OHNE den frühesten Start des Nachfolgers anzutasten. '
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
        'A: 2 Tage, kein Vorgänger\n'
        'B: 4 Tage, Vorgänger A\n'
        'C: 3 Tage, Vorgänger A\n'
        'D: 5 Tage, Vorgänger B\n'
        'E: 2 Tage, Vorgänger C\n'
        'F: 1 Tag, Vorgänger D und E',
    prompt: 'Wie groß ist der Gesamtpuffer (GP) von Vorgang C?',
    numericAnswer: 4,
    numericTolerance: 0,
    unit: 'Tage',
    explanation:
        'Vorwärtsrechnung:\n'
        'A 0/2, B 2/6, C 2/5, D 6/11, E 5/7, F max(11,7)=11/12 -> Projektdauer 12\n\n'
        'Rückwärtsrechnung:\n'
        'F 11/12, D 6/11, E 9/11, B 2/6, C 6/9, A 0/2\n\n'
        'GP(C) = SAZ(C) - FAZ(C) = 6 - 2 = 4 Tage.\n'
        'Gegenprobe über die andere Formel: GP = SEZ - FEZ = 9 - 5 = 4. '
        'Stimmen beide Werte nicht überein, steckt ein Rechenfehler in der '
        'Rückwärtsrechnung.',
  ),

  Question(
    id: 'np-004',
    topicId: 'netzplan',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['puffer', 'definition'],
    prompt: 'Was sagt der freie Puffer (FP) eines Vorgangs aus?',
    choices: [
      _c('Die Zeit, um die der Vorgang verschoben werden kann, ohne den frühesten Anfang seiner Nachfolger zu verändern.', true,
          'Richtig. FP = kleinster FAZ der Nachfolger minus eigener FEZ. Diesen Puffer darf man aufbrauchen, ohne dass es irgendjemand anders merkt.'),
      _c('Die Zeit, um die der Vorgang verschoben werden kann, ohne das Projektende zu gefährden.', false,
          'Das ist die Definition des GESAMTpuffers (GP = SAZ - FAZ). Der GP ist immer größer oder gleich dem FP.'),
      _c('Die Differenz zwischen geplanter und tatsächlicher Dauer.', false,
          'Das wäre eine Abweichung im Projektcontrolling, kein Puffer aus der Netzplantechnik.'),
      _c('Die Reservezeit, die das Projektteam zusätzlich einplant.', false,
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
    prompt: 'Welche Aussagen über den kritischen Pfad sind richtig?',
    choices: [
      _c('Alle Vorgänge auf ihm haben einen Gesamtpuffer von 0.', true,
          'Das ist die Definition. Genau daran erkennt man ihn in der Rechnung.'),
      _c('Er ist der längste Weg durch den Netzplan.', true,
          'Der längste Weg bestimmt die Projektdauer - deshalb hat er keinen Puffer.'),
      _c('Verzögert sich ein Vorgang auf ihm um 2 Tage, verzögert sich das Projektende um 2 Tage.', true,
          'Ohne Puffer schlägt jede Verzögerung eins zu eins aufs Projektende durch.'),
      _c('Ein Netzplan hat immer genau einen kritischen Pfad.', false,
          'Falsch. Es kann mehrere gleich lange kritische Pfade geben - dann ist das Projekt besonders anfällig, weil es mehrere pufferlose Ketten gibt.'),
      _c('Er enthält immer die Vorgänge mit der längsten Einzeldauer.', false,
          'Falsch. Ein einzelner langer Vorgang kann parallel liegen und viel Puffer haben. Entscheidend ist die Kette, nicht die Einzeldauer.'),
      _c('Eine Verkürzung eines Vorgangs auf dem kritischen Pfad verkürzt immer das Projekt um denselben Betrag.', false,
          'Falsch, und das ist der beliebteste Stolperstein: verkürzt man genug, wird ein anderer Weg zum kritischen Pfad und die Verkürzung verpufft ab diesem Punkt.'),
    ],
    explanation:
        'Der kritische Pfad ist der längste Weg vom Start- zum Endvorgang und '
        'damit die Kette ohne Puffer. Praktische Konsequenz fürs Projekt: '
        'Ressourcen und Aufmerksamkeit gehören zuerst dorthin. Bei '
        'Verkürzungsaufgaben immer nach jedem Schritt neu rechnen - der '
        'kritische Pfad kann wandern.',
  ),

  Question(
    id: 'np-006',
    topicId: 'netzplan',
    kind: QuestionKind.netzplan,
    difficulty: 3,
    tags: ['puffer', 'kritischer_pfad'],
    scenario:
        'Aufbau eines neuen Serverraums, sieben Vorgänge, Dauer in Arbeitstagen.',
    prompt:
        'Ermittle für jeden Vorgang den Gesamtpuffer und den freien Puffer.',
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
        'Vorwärts: A 0/2, B 2/6, C 2/8, D 6/9, E 6/8, F max(9,8)=9/13, '
        'G max(8,13)=13/16. Projektdauer 16 Tage.\n\n'
        'Rückwärts: G 13/16, F 9/13, E 11/13, D 6/9, C 3/9, B 2/6, A 0/2.\n\n'
        'GP = SAZ - FAZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0\n'
        'FP = min(FAZ Nachfolger) - FEZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0\n\n'
        'Kritischer Pfad: A - B - D - F - G (16 Tage).\n'
        'Vorgang E hat mit 5 Tagen den größten Spielraum - hier kann man ohne '
        'Risiko Personal abziehen, wenn es auf dem kritischen Pfad brennt. '
        'Achtung bei C: die Lieferung dauert zwar am längsten (6 Tage), liegt '
        'aber trotzdem nicht auf dem kritischen Pfad.',
  ),

  Question(
    id: 'np-007',
    topicId: 'netzplan',
    kind: QuestionKind.numeric,
    difficulty: 1,
    tags: ['projektdauer'],
    scenario:
        'A: 5 Tage, kein Vorgänger\n'
        'B: 3 Tage, kein Vorgänger\n'
        'C: 4 Tage, Vorgänger A und B\n'
        'D: 6 Tage, Vorgänger A\n'
        'E: 2 Tage, Vorgänger C und D',
    prompt: 'Wie lang dauert das Gesamtprojekt?',
    numericAnswer: 13,
    numericTolerance: 0,
    unit: 'Tage',
    explanation:
        'Alle Wege durchrechnen und den längsten nehmen:\n'
        'A - C - E = 5 + 4 + 2 = 11\n'
        'B - C - E = 3 + 4 + 2 = 9\n'
        'A - D - E = 5 + 6 + 2 = 13  <- längster Weg\n'
        'Projektdauer = 13 Tage, kritischer Pfad A - D - E.\n'
        'Kontrolle über die Vorwärtsrechnung: C startet bei max(5, 3) = 5, '
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
        'Welchen Vorteil hat ein Netzplan gegenüber einem einfachen Balkenplan '
        '(Gantt-Diagramm)?',
    choices: [
      _c('Er zeigt Abhängigkeiten und Puffer explizit und macht den kritischen Pfad berechenbar.', true,
          'Richtig. Der Netzplan ist ein Rechenmodell: Puffer und kritischer Pfad ergeben sich rechnerisch, nicht durch Hinsehen.'),
      _c('Er stellt den Zeitverlauf anschaulicher dar.', false,
          'Das ist gerade die Stärke des Balkenplans: Die Zeitachse ist maßstabsgetreu und auf einen Blick lesbar.'),
      _c('Er benötigt keine Angabe von Vorgangsdauern.', false,
          'Ohne Dauern gibt es keine Vorwärts- und Rückwärtsrechnung. Der Netzplan braucht sie zwingend.'),
      _c('Er eignet sich besser für die Präsentation vor der Geschäftsführung.', false,
          'Umgekehrt. Für Präsentationen nimmt man den Balkenplan, weil er ohne Erklärung verständlich ist.'),
    ],
    explanation:
        'Arbeitsteilung in der Praxis: mit dem Netzplan rechnen, mit dem '
        'Balkenplan kommunizieren. Moderne Tools erzeugen den Gantt direkt aus '
        'den Netzplandaten und zeichnen den kritischen Pfad rot ein - '
        'in der Prüfung muss man beides aber getrennt beherrschen.',
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
      _c('Der längste Vorgang im Projekt.', false,
          'Das hat mit Meilensteinen nichts zu tun; lange Vorgänge sind einfach Vorgänge.'),
      _c('Ein Vorgang, der besonders viel Budget bindet.', false,
          'Budget ist kein Kriterium. Ein Meilenstein kostet definitionsgemäß nichts.'),
      _c('Der Abschluss des gesamten Projekts.', false,
          'Der Projektabschluss IST ein Meilenstein, aber Meilensteine gibt es während des gesamten Projekts.'),
    ],
    explanation:
        'Meilensteine sind Entscheidungspunkte: Ergebnis da oder nicht, weiter '
        'oder nicht. Gute Meilensteine sind binär prüfbar formuliert '
        '("Pflichtenheft vom Kunden unterzeichnet"), nicht schwammig '
        '("Konzept weitgehend fertig"). In der Meilensteintrendanalyse (MTA) '
        'trägt man über die Zeit auf, wie sich die geplanten '
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
        'Ein Meilensteintrendanalyse-Diagramm zeigt für einen Meilenstein eine '
        'nach oben steigende Linie. Welche Schlüsse sind zulässig?',
    choices: [
      _c('Der Meilenstein verschiebt sich immer weiter nach hinten.', true,
          'Richtig. Steigende Linie = der prognostizierte Termin wird bei jedem Berichtszeitpunkt später.'),
      _c('Es besteht Handlungsbedarf, z. B. Ressourcen umsteuern oder Umfang kürzen.', true,
          'Die MTA ist ein Frühwarninstrument - der Zweck ist genau dieses Gegensteuern.'),
      _c('Der Meilenstein wird früher als geplant erreicht.', false,
          'Falsch, das wäre eine FALLENDE Linie. Steigend = später.'),
      _c('Das Projekt liegt im Plan.', false,
          'Falsch. Im Plan bedeutet eine waagerechte Linie.'),
      _c('Die Ursache der Verzögerung lässt sich direkt aus dem Diagramm ablesen.', false,
          'Falsch. Die MTA zeigt, DASS sich etwas verschiebt, nicht WARUM. Die Ursachenanalyse ist eine separate Aufgabe.'),
    ],
    explanation:
        'MTA-Lesehilfe: waagerecht = im Plan, steigend = Verzug, fallend = '
        'früher fertig, Zickzack = unsichere Schätzung bzw. instabile '
        'Planung. Ein Zickzack ist ein Warnsignal für die Planungsqualität, '
        'auch wenn der Endtermin am Ende stimmt.',
  ),

  Question(
    id: 'tp-004',
    topicId: 'terminplanung',
    kind: QuestionKind.numeric,
    difficulty: 3,
    tags: ['ressourcenplanung'],
    scenario:
        'Für ein Arbeitspaket sind 120 Personentage veranschlagt. Es stehen '
        '4 Entwickler zur Verfügung, die jedoch nur zu 75 % für das Projekt '
        'verfügbar sind (der Rest geht in Support und Linientätigkeit).',
    prompt:
        'Wie viele Arbeitstage dauert das Arbeitspaket? Runde auf volle Tage auf.',
    numericAnswer: 40,
    numericTolerance: 0,
    unit: 'Arbeitstage',
    explanation:
        'Rechenweg:\n'
        '1. Tatsächliche Kapazität pro Tag = 4 Entwickler x 0,75 = 3 Personentage/Tag\n'
        '2. Dauer = 120 Personentage / 3 Personentage pro Tag = 40 Arbeitstage\n\n'
        'Typischer Fehler: 120 / 4 = 30 Tage - die Verfügbarkeit wird '
        'vergessen. In Prüfungsaufgaben ist der Verfügbarkeitsgrad fast '
        'immer der eigentliche Prüfpunkt. Merke außerdem: Personentage sind '
        'Aufwand, Arbeitstage sind Dauer. Die beiden Einheiten zu verwechseln '
        'kostet in der Klausur sofort Punkte.',
  ),
];
