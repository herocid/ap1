import '../models/question.dart';
import 'builders.dart';

/// Kurzform für eine Antwortoption.
Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Projektorganisation, Vorgehensmodelle, agiles Arbeiten.
///
/// Alle Aufgaben sind eigene Formulierungen im Stil der AP1 - keine
/// Originalaufgaben der IHK (die sind urheberrechtlich geschützt).
final List<Question> seedGrundlagen = [
  // ---------------------------------------------------------------- Organisation
  markieren(
    'org-001',
    'p-begriff',
    difficulty: 1,
    tags: ['din69901', 'projektbegriff'],
    scenario:
        'In der IT-Abteilung eines Unternehmens stehen sechs Vorhaben an.',
    prompt: 'Markiere alle Vorhaben, die nach DIN 69901 ein Projekt sind.',
    zeilen: [
      ja(
        'Einführung eines neuen ERP-Systems bis Jahresende, mit eigenem Team und Budget',
        'Einmalig, mit Ziel, begrenzt und mit eigener Organisation.',
      ),
      nein(
        'Tägliche Datensicherung der Server',
        'Wiederkehrende Routine, also Tagesgeschäft.',
      ),
      ja(
        'Umzug des Rechenzentrums in ein neues Gebäude',
        'Einmaliges Vorhaben mit klarem Anfang und Ende.',
      ),
      nein('Monatliche Lohnabrechnung', 'Läuft jeden Monat identisch ab.'),
      ja(
        'Entwicklung einer Kunden-App für einen Auftraggeber zum Festpreis',
        'Zielvorgabe, Begrenzung von Zeit und Kosten, Abgrenzung von anderen Vorhaben.',
      ),
      nein(
        'Laufender Betrieb des Service Desks',
        'Daueraufgabe der Linie ohne definiertes Ende.',
      ),
    ],
    explanation:
        'Ein Projekt erkennst du an der Einmaligkeit der Bedingungen: '
        'Zielvorgabe, Begrenzung (zeitlich, finanziell, personell), '
        'Abgrenzung gegenüber anderen Vorhaben und eigene Organisation. '
        'Größe und Budget gehören nicht zur Definition, auch ein '
        'Zwei-Personen-Vorhaben kann ein Projekt sein.',
  ),

  Question(
    id: 'org-002',
    topicId: 'projektorganisation',
    subtopicId: 'p-organisation',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['aufbauorganisation'],
    prompt: 'Ordne die Aussagen der passenden Form der Projektorganisation zu.',
    buckets: [
      'Reine Projektorganisation',
      'Matrix-Organisation',
      'Stabs-/Einflussorganisation',
    ],
    matchItems: const [
      MatchItem(
        text: 'Mitarbeitende werden vollständig aus der Linie herausgelöst.',
        bucket: 0,
        rationale:
            'Genau das ist das Kennzeichen der reinen (autonomen) Projektorganisation.',
      ),
      MatchItem(
        text:
            'Die Projektleitung hat volle fachliche und disziplinarische Weisungsbefugnis.',
        bucket: 0,
        rationale: 'Nur hier ist die Weisungsbefugnis ungeteilt.',
      ),
      MatchItem(
        text:
            'Die Weisungsbefugnis ist zwischen Linien- und Projektleitung geteilt.',
        bucket: 1,
        rationale:
            'Der typische Kompromiss und die typische Konfliktquelle der Matrix.',
      ),
      MatchItem(
        text: 'Hohes Konfliktpotenzial durch zwei Vorgesetzte pro Person.',
        bucket: 1,
        rationale:
            'Das klassische Matrix-Problem: zwei Chefs, widersprüchliche Prioritäten.',
      ),
      MatchItem(
        text:
            'Die Projektleitung koordiniert nur und kann keine Anweisungen geben.',
        bucket: 2,
        rationale:
            'Die Stabsstelle berichtet und koordiniert, entscheidet aber nicht.',
      ),
      MatchItem(
        text:
            'Geringster organisatorischer Aufwand, dafür schwache Durchsetzungskraft.',
        bucket: 2,
        rationale:
            'Vorteil und Nachteil der Einflussorganisation in einem Satz.',
      ),
    ],
    explanation:
        'Faustregel für die Prüfung: Je mehr Macht die Projektleitung hat, '
        'desto teurer und störender ist die Organisationsform für die Linie. '
        'Rein = viel Macht, hoher Aufwand. Stab = wenig Macht, wenig Aufwand. '
        'Matrix liegt dazwischen und wird am häufigsten gewählt.',
  ),

  Question(
    id: 'org-003',
    topicId: 'projektorganisation',
    subtopicId: 'p-stakeholder',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['stakeholder'],
    scenario:
        'Bei der Einführung eines neuen Ticketsystems hat der Betriebsrat hohen '
        'Einfluss auf die Entscheidung, zeigt bislang aber wenig Interesse am '
        'Projekt.',
    prompt:
        'Welche Strategie sieht die Stakeholder-Matrix (Einfluss/Interesse) für '
        'diese Gruppe vor?',
    choices: [
      _c(
        'Zufriedenstellen: regelmäßig informieren, aber nicht überfrachten',
        true,
        'Richtig. Hoher Einfluss + geringes Interesse = "keep satisfied". Die Gruppe kann das Projekt kippen, will aber keine Detailflut.',
      ),
      _c(
        'Eng einbinden: in alle Entscheidungen einbeziehen',
        false,
        'Das gilt für hohen Einfluss UND hohes Interesse. Hier würde es den Betriebsrat mit Details überfordern und Widerstand erzeugen.',
      ),
      _c(
        'Beobachten: minimaler Aufwand',
        false,
        'Das gilt nur bei geringem Einfluss UND geringem Interesse. Wer den Betriebsrat so behandelt, erlebt spätestens bei der Mitbestimmung eine Vollbremsung.',
      ),
      _c(
        'Informieren: ausführlich über Fortschritte berichten',
        false,
        'Das ist die Strategie für geringen Einfluss und hohes Interesse, z. B. interessierte Fachanwender.',
      ),
    ],
    explanation:
        'Die vier Felder der Stakeholder-Matrix:\n'
        '- Einfluss hoch / Interesse hoch -> eng einbinden (manage closely)\n'
        '- Einfluss hoch / Interesse niedrig -> zufriedenstellen (keep satisfied)\n'
        '- Einfluss niedrig / Interesse hoch -> informieren (keep informed)\n'
        '- Einfluss niedrig / Interesse niedrig -> beobachten (monitor)\n'
        'In der Prüfung wird fast immer nach dem Feld "hoher Einfluss, geringes '
        'Interesse" gefragt, weil es das unintuitivste ist.',
  ),

  freitext(
    'org-004',
    'p-ziele',
    difficulty: 2,
    tags: ['projektauftrag'],
    scenario:
        'Die Geschäftsführung beauftragt die IT-Abteilung, ein neues '
        'Ticketsystem einzuführen. Dafür wird ein Projektauftrag geschrieben.',
    prompt: 'Nenne vier Angaben, die in einen Projektauftrag gehören.',
    kriterien: [
      krit(
        'Projektziel mit messbaren Abnahmekriterien',
        stichwoerter: ['Projektziel', 'Ziel', 'Abnahmekriterien'],
      ),
      krit(
        'Benannte Projektleitung mit ihren Befugnissen',
        stichwoerter: ['Projektleitung', 'Projektleiter', 'Befugnisse'],
      ),
      krit('Budgetrahmen', stichwoerter: ['Budget', 'Kostenrahmen', 'Kosten']),
      krit(
        'Terminrahmen',
        stichwoerter: ['Termin', 'Zeitrahmen', 'Endtermin', 'Meilensteine'],
      ),
      krit(
        'Nicht-Ziele bzw. Abgrenzung des Projektumfangs',
        stichwoerter: ['Nicht-Ziele', 'Abgrenzung', 'Umfang'],
      ),
      krit(
        'Auftraggeber und Beteiligte',
        stichwoerter: ['Auftraggeber', 'Beteiligte', 'Team'],
      ),
    ],
    loesung:
        'Projektziel mit messbaren Abnahmekriterien, benannte Projektleitung '
        'mit Befugnissen, Budgetrahmen, Terminrahmen, Nicht-Ziele bzw. '
        'Abgrenzung des Umfangs, Auftraggeber.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Der Projektauftrag ist die '
        'Geburtsurkunde des Projekts: Ziel, Nicht-Ziel, '
        'Rahmen (Zeit/Budget), Verantwortliche. Alles, was Detailplanung ist '
        '(Netzplan, Architektur, Arbeitspakete), kommt danach und gehört '
        'nicht in den Auftrag.',
    punkte: 4,
  ),

  Question(
    id: 'org-005',
    topicId: 'projektorganisation',
    subtopicId: 'p-ziele',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['magisches_dreieck'],
    scenario:
        'Zwei Wochen vor dem Releasetermin fällt auf, dass ein Modul mehr Aufwand '
        'braucht als geplant. Der Termin ist vertraglich fixiert, zusätzliches '
        'Budget gibt es nicht.',
    prompt:
        'Welche Konsequenz ergibt sich zwangsläufig aus dem magischen Dreieck?',
    choices: [
      _c(
        'Der Leistungsumfang muss reduziert werden.',
        true,
        'Richtig. Zeit und Kosten sind fixiert. Im Dreieck bleibt nur die dritte Größe, der Umfang (Qualität/Leistung), als Stellhebel.',
      ),
      _c(
        'Die Qualitätssicherung kann entfallen, ohne den Umfang zu ändern.',
        false,
        'Das ist keine neutrale Option: QS zu streichen ist selbst eine Reduzierung der Qualität, also ebenfalls eine Änderung der dritten Größe, nur eine besonders teure.',
      ),
      _c(
        'Mehr Personal löst das Problem ohne Nebenwirkung.',
        false,
        'Erstens kostet mehr Personal Budget (das es nicht gibt), zweitens gilt das Brookssche Gesetz: Zusätzliche Leute in einem späten Projekt verzögern es zunächst weiter.',
      ),
      _c(
        'Das Projekt muss abgebrochen werden.',
        false,
        'Ein Abbruch ist eine mögliche Managemententscheidung, aber nicht die zwangsläufige Folge des Dreiecks. Gefragt war die logische Konsequenz.',
      ),
    ],
    explanation:
        'Magisches Dreieck: Zeit, Kosten, Leistung/Qualität. Sind zwei Größen '
        'fixiert, ist die dritte die abhängige Variable. In Prüfungsaufgaben '
        'steht die Lösung immer in der Aufgabenstellung: Schau, welche zwei '
        'Ecken als "fest" beschrieben sind.',
  ),

  // ------------------------------------------------------------ Vorgehensmodelle
  Question(
    id: 'vor-001',
    topicId: 'vorgehensmodelle',
    subtopicId: 'v-wasserfall',
    kind: QuestionKind.ordering,
    difficulty: 1,
    tags: ['wasserfall'],
    prompt:
        'Bringe die Phasen des Wasserfallmodells in die richtige Reihenfolge.',
    orderingHint: 'Von der ersten zur letzten Phase',
    orderedItems: const [
      'Analyse / Anforderungsdefinition',
      'Entwurf (Design)',
      'Implementierung',
      'Test / Verifikation',
      'Einführung und Wartung',
    ],
    explanation:
        'Das Wasserfallmodell läuft streng sequenziell: Jede Phase endet mit '
        'einem freigegebenen Dokument, erst dann startet die nächste. Das ist '
        'zugleich sein größter Nachteil: Fehler aus der Analyse fallen erst '
        'im Test auf, und dann ist die Korrektur am teuersten.',
  ),

  Question(
    id: 'vor-002',
    topicId: 'vorgehensmodelle',
    // V-Modell ist ab 2025 nicht mehr Teil des AP1-Katalogs. Die Teststufen
    // selbst bleiben relevant - dafür gibt es eigene Aufgaben im Thema Testen.
    catalogStatus: CatalogStatus.removed2025,
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['v-modell'],
    prompt:
        'Welcher Testart steht im V-Modell die Phase "Anforderungsdefinition" '
        'gegenüber?',
    choices: [
      _c(
        'Abnahmetest',
        true,
        'Richtig. Die oberste linke Ebene (Anforderungen des Auftraggebers) wird gegen die oberste rechte Ebene (Abnahmetest durch den Auftraggeber) geprüft.',
      ),
      _c(
        'Modultest',
        false,
        'Der Modul-/Unittest liegt auf der untersten Ebene und prüft gegen die Modulspezifikation bzw. den Feinentwurf.',
      ),
      _c(
        'Integrationstest',
        false,
        'Der Integrationstest gehört zum Grobentwurf/Architektur. Er prüft das Zusammenspiel der Komponenten.',
      ),
      _c(
        'Systemtest',
        false,
        'Der Systemtest gehört zur Systemspezifikation, also eine Ebene unterhalb der Anforderungsdefinition. Er prüft in der Testumgebung, der Abnahmetest beim Kunden.',
      ),
    ],
    explanation:
        'Die Ebenen des V-Modells von oben nach unten:\n'
        'Anforderungsdefinition <-> Abnahmetest\n'
        'Systemspezifikation <-> Systemtest\n'
        'Architektur/Grobentwurf <-> Integrationstest\n'
        'Feinentwurf/Modulspez. <-> Modultest (Unittest)\n'
        'Merkhilfe: gleiche Höhe im V = zusammengehöriges Paar. Je höher, '
        'desto näher am Kunden.',
  ),

  Question(
    id: 'vor-003',
    topicId: 'vorgehensmodelle',
    // Vergleicht Spiralmodell und V-Modell mit - beide ab 2025 gestrichen.
    catalogStatus: CatalogStatus.removed2025,
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['modellvergleich'],
    prompt:
        'Ordne jede Aussage dem Vorgehensmodell zu, das sie am besten beschreibt.',
    buckets: ['Wasserfall', 'V-Modell', 'Spiralmodell', 'Scrum'],
    matchItems: const [
      MatchItem(
        text: 'Streng sequenziell, jede Phase endet mit einem Dokument.',
        bucket: 0,
        rationale: 'Das Grundprinzip des Wasserfalls.',
      ),
      MatchItem(
        text: 'Jeder Entwicklungsstufe ist eine passende Teststufe zugeordnet.',
        bucket: 1,
        rationale:
            'Das ist genau die Erweiterung, die das V-Modell gegenüber dem Wasserfall bringt.',
      ),
      MatchItem(
        text:
            'Wiederholte Zyklen mit expliziter Risikoanalyse zu Beginn jedes Zyklus.',
        bucket: 2,
        rationale:
            'Die Risikoanalyse pro Zyklus ist das Markenzeichen des Spiralmodells nach Boehm.',
      ),
      MatchItem(
        text: 'Lieferung eines nutzbaren Inkrements am Ende jedes Sprints.',
        bucket: 3,
        rationale:
            'Das Increment ist ein Scrum-Artefakt; es muss die Definition of Done erfüllen.',
      ),
      MatchItem(
        text: 'Anforderungen müssen zu Projektbeginn vollständig bekannt sein.',
        bucket: 0,
        rationale: 'Die zentrale Voraussetzung (und Schwäche) des Wasserfalls.',
      ),
      MatchItem(
        text:
            'Priorisierung der Arbeit erfolgt fortlaufend durch eine Rolle mit Produktverantwortung.',
        bucket: 3,
        rationale:
            'Der Product Owner verantwortet die Reihenfolge im Product Backlog.',
      ),
    ],
    explanation:
        'Für die Prüfung reicht je ein Erkennungsmerkmal pro Modell: '
        'Wasserfall = sequenziell, V-Modell = Teststufen-Paare, Spiralmodell = '
        'Risikoanalyse pro Zyklus, Scrum = Inkremente in festen Sprints.',
  ),

  Question(
    id: 'vor-004',
    topicId: 'vorgehensmodelle',
    subtopicId: 'v-auswahl',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['agil_vs_klassisch'],
    scenario:
        'Ein Kunde möchte eine Web-Anwendung, hat aber nur eine grobe Vorstellung '
        'vom Funktionsumfang und erwartet, dass sich die Anforderungen während '
        'der Entwicklung noch ändern.',
    prompt: 'Welche Argumente sprechen hier für ein agiles Vorgehen?',
    choices: [
      _c(
        'Anforderungen können zwischen den Iterationen angepasst werden.',
        true,
        'Genau der Fall aus dem Szenario: Unklare, veränderliche Anforderungen sind das Kernargument für agil.',
      ),
      _c(
        'Der Kunde sieht nach jeder Iteration lauffähige Software.',
        true,
        'Frühes Feedback: Fehlannahmen fallen nach Wochen auf, nicht erst nach Monaten.',
      ),
      _c(
        'Der Preis für den gesamten Funktionsumfang lässt sich von Anfang an exakt festschreiben.',
        false,
        'Falsch. Ein Festpreis für einen festen Umfang ist eine Stärke des klassischen Vorgehens. Agil arbeitet eher mit festem Budget und variablem Umfang.',
      ),
      _c(
        'Der Dokumentationsaufwand entfällt vollständig.',
        false,
        'Falsch. Das agile Manifest sagt "funktionierende Software MEHR ALS umfassende Dokumentation", nicht "statt". Dokumentation wird reduziert, nicht abgeschafft.',
      ),
      _c(
        'Das Risiko einer kompletten Fehlentwicklung sinkt.',
        true,
        'Durch kurze Zyklen und regelmäßige Abnahme kann man maximal eine Iteration in die falsche Richtung laufen.',
      ),
      _c(
        'Ein vollständiges Pflichtenheft ist zu Projektbeginn erforderlich.',
        false,
        'Falsch, das ist klassisches Vorgehen. Agil startet mit einem priorisierten Backlog, das sich weiterentwickelt.',
      ),
    ],
    explanation:
        'Entscheidungsregel: Sind die Anforderungen stabil und der Umfang '
        'vertraglich fix (z. B. Ausschreibung der öffentlichen Hand), ist '
        'klassisch richtig. Sind sie unklar oder veränderlich, ist agil '
        'richtig. Der häufigste Fehler in der Prüfung ist die Behauptung, '
        'agil brauche keine Dokumentation.',
  ),

  Question(
    id: 'vor-005',
    topicId: 'vorgehensmodelle',
    subtopicId: 'v-wasserfall',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['wasserfall', 'fehlerkosten'],
    prompt:
        'Warum sind Fehler aus der Analysephase im Wasserfallmodell besonders teuer?',
    choices: [
      _c(
        'Weil sie erst in der Testphase auffallen und dann alle darauf aufbauenden Phasen korrigiert werden müssen.',
        true,
        'Richtig. Der Aufwand zur Fehlerbehebung steigt mit jeder Phase etwa um den Faktor 10 (Rule of Ten).',
      ),
      _c(
        'Weil die Analysephase das teuerste Personal bindet.',
        false,
        'Die Personalkosten der Analyse sind nicht der Punkt. Entscheidend ist die Fortpflanzung des Fehlers durch alle Folgephasen.',
      ),
      _c(
        'Weil das Wasserfallmodell keine Testphase vorsieht.',
        false,
        'Sachlich falsch: Test ist eine eigene Phase im Wasserfall. Nur liegt sie eben am Ende.',
      ),
      _c(
        'Weil Analysefehler die Hardwarebeschaffung betreffen.',
        false,
        'Das ist ein Spezialfall, keine allgemeine Begründung.',
      ),
    ],
    explanation:
        'Rule of Ten: Ein Fehler, der in der Analyse 1 Euro kostet, kostet im '
        'Entwurf 10, in der Implementierung 100, im Test 1.000 und beim Kunden '
        '10.000 Euro. '
        'Genau dagegen arbeiten früh geplante Tests (z. B. Testfälle schon '
        'aus dem Pflichtenheft) und agile '
        'Modelle (kurze Feedback-Schleifen).',
  ),

  // ------------------------------------------------------------------ Scrum
  paare(
    'scr-001',
    's-rollen',
    difficulty: 1,
    tags: ['scrum', 'rollen'],
    prompt: 'Verbinde jede Scrum-Rolle mit ihrer Verantwortung.',
    paare: [
      paar('Product Owner', 'ordnet das Product Backlog nach Wert'),
      paar('Scrum Master', 'sorgt dafür, dass Scrum funktioniert'),
      paar('Developers', 'entscheiden, wie und wie viel umgesetzt wird'),
    ],
    explanation:
        'Kurzformel: Product Owner = WAS und in welcher Reihenfolge. '
        'Developers = WIE und wie viel. Scrum Master = DASS es funktioniert. '
        'Der Product Owner darf sich beraten lassen, entscheidet über die '
        'Reihenfolge im Product Backlog aber allein. Ein Lenkungsausschuss '
        'ist in Scrum nicht vorgesehen.',
  ),

  Question(
    id: 'scr-002',
    topicId: 'agil_scrum',
    subtopicId: 's-events',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['scrum', 'events'],
    prompt:
        'Bringe die Scrum-Events in die Reihenfolge, in der sie innerhalb eines '
        'Sprints stattfinden.',
    orderingHint: 'Vom Sprintbeginn bis zum Sprintende',
    orderedItems: const [
      'Sprint Planning',
      'Daily Scrum (täglich)',
      'Sprint Review',
      'Sprint Retrospective',
    ],
    explanation:
        'Der Sprint selbst ist der Container für alle anderen Events. '
        'Wichtig für die Prüfung: Das Review kommt VOR der Retrospektive. '
        'Im Review geht es um das Produkt (mit Stakeholdern), in der '
        'Retrospektive um die Zusammenarbeit (nur das Scrum Team). '
        'Das Refinement ist kein eigenes Event, sondern eine laufende Tätigkeit.',
  ),

  tabelle(
    'scr-003',
    's-events',
    difficulty: 1,
    tags: ['scrum', 'timebox'],
    scenario: 'Ein Scrum-Team arbeitet in vierwöchigen Sprints.',
    prompt: 'Gib für jedes Event die Timebox an.',
    zeilen: [
      ['Event', 'Timebox'],
      [
        'Sprint Planning',
        wahl('höchstens 8 Stunden', [
          '15 Minuten',
          'höchstens 3 Stunden',
          'höchstens 4 Stunden',
        ]),
      ],
      [
        'Daily Scrum',
        wahl(
          '15 Minuten',
          ['30 Minuten', '1 Stunde', 'höchstens 4 Stunden'],
          'Die einzige Timebox, die nicht mit der Sprintlänge wächst.',
        ),
      ],
      [
        'Sprint Review',
        wahl('höchstens 4 Stunden', [
          '15 Minuten',
          'höchstens 3 Stunden',
          'höchstens 8 Stunden',
        ]),
      ],
      [
        'Sprint Retrospective',
        wahl('höchstens 3 Stunden', [
          '15 Minuten',
          'höchstens 4 Stunden',
          'höchstens 8 Stunden',
        ]),
      ],
    ],
    explanation:
        'Timeboxen bei einem Monatssprint (bei kürzeren Sprints meist kürzer):\n'
        '- Sprint Planning: max. 8 Stunden\n'
        '- Daily Scrum: 15 Minuten (immer)\n'
        '- Sprint Review: max. 4 Stunden\n'
        '- Sprint Retrospective: max. 3 Stunden\n'
        'Merkhilfe 8-4-3 und das Daily als Konstante.',
    punkte: 2,
  ),

  Question(
    id: 'scr-004',
    topicId: 'agil_scrum',
    subtopicId: 's-artefakte',
    kind: QuestionKind.matching,
    difficulty: 3,
    tags: ['scrum', 'artefakte'],
    prompt:
        'Jedes Scrum-Artefakt hat ein "Commitment", das ihm Transparenz gibt. '
        'Ordne richtig zu.',
    buckets: ['Product Backlog', 'Sprint Backlog', 'Increment'],
    matchItems: const [
      MatchItem(
        text: 'Product Goal',
        bucket: 0,
        rationale:
            'Das Product Goal ist das langfristige Ziel, auf das das Product Backlog einzahlt.',
      ),
      MatchItem(
        text: 'Sprint Goal',
        bucket: 1,
        rationale:
            'Das Sprint Goal ist das eine Ziel des Sprints und gehört zum Sprint Backlog.',
      ),
      MatchItem(
        text: 'Definition of Done',
        bucket: 2,
        rationale:
            'Die DoD beschreibt, wann ein Increment wirklich fertig (also nutzbar) ist.',
      ),
      MatchItem(
        text: 'Geordnete Liste aller bekannten Anforderungen an das Produkt',
        bucket: 0,
        rationale: 'Das ist die Definition des Product Backlogs.',
      ),
      MatchItem(
        text:
            'Auswahl der Items plus Plan zur Umsetzung für die kommenden Wochen',
        bucket: 1,
        rationale:
            'Sprint Backlog = Sprint Goal + ausgewählte Items + Umsetzungsplan.',
      ),
      MatchItem(
        text: 'Das konkrete, nutzbare Ergebnis am Ende des Sprints',
        bucket: 2,
        rationale:
            'Das Increment ist das Arbeitsergebnis, das die DoD erfüllt.',
      ),
    ],
    explanation:
        'Drei Artefakte, drei Commitments: Product Backlog -> Product Goal, '
        'Sprint Backlog -> Sprint Goal, Increment -> Definition of Done. '
        'Diese Zuordnung wird gern gefragt, weil viele die DoD fälschlich dem '
        'Sprint Backlog zuordnen.',
  ),

  Question(
    id: 'scr-005',
    topicId: 'agil_scrum',
    subtopicId: 's-stories',
    kind: QuestionKind.numeric,
    difficulty: 2,
    tags: ['scrum', 'velocity'],
    scenario:
        'Ein Scrum-Team hat in den letzten drei Sprints 28, 32 und 30 Story Points '
        'abgeschlossen. Im Product Backlog liegen noch 270 Story Points.',
    prompt:
        'Wie viele weitere Sprints braucht das Team voraussichtlich? '
        'Runde auf volle Sprints auf.',
    numericAnswer: 9,
    numericTolerance: 0,
    unit: 'Sprints',
    explanation:
        'Rechenweg:\n'
        '1. Durchschnittliche Velocity = (28 + 32 + 30) / 3 = 30 Story Points/Sprint\n'
        '2. 270 SP / 30 SP je Sprint = 9 Sprints\n'
        'Wäre das Ergebnis krumm (z. B. 9,3), wird aufgerundet, denn einen '
        'halben Sprint gibt es in der Planung nicht. Die Velocity wird immer '
        'aus abgeschlossenen Items gebildet (Definition of Done erfüllt), '
        'nicht aus angefangenen.',
  ),

  Question(
    id: 'scr-006',
    topicId: 'agil_scrum',
    // Kanban zählt ab 2025 zu den gestrichenen Methoden.
    catalogStatus: CatalogStatus.removed2025,
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['kanban', 'wip'],
    prompt: 'Wozu dient ein WIP-Limit in Kanban?',
    choices: [
      _c(
        'Es begrenzt die Anzahl gleichzeitig bearbeiteter Aufgaben und macht Engpässe sichtbar.',
        true,
        'Richtig. Work in Progress zu begrenzen verkürzt die Durchlaufzeit und zwingt das Team, Aufgaben fertigzustellen, statt neue anzufangen.',
      ),
      _c(
        'Es legt fest, wie viele Story Points pro Sprint eingeplant werden.',
        false,
        'Das ist die Velocity in Scrum. Kanban kennt keine Sprints und keine feste Einplanung.',
      ),
      _c(
        'Es begrenzt die maximale Teamgröße.',
        false,
        'WIP bezieht sich auf Arbeit, nicht auf Personen.',
      ),
      _c(
        'Es definiert, wie lange eine Aufgabe maximal dauern darf.',
        false,
        'Das wäre eine Timebox bzw. ein Service Level Expectation, nicht das WIP-Limit.',
      ),
    ],
    explanation:
        'Kanban-Kernpraktiken: Workflow visualisieren, WIP limitieren, Fluss '
        'steuern, Regeln explizit machen, Feedback etablieren, verbessern. '
        'Hintergrund ist das Littlesche Gesetz: Durchlaufzeit = WIP / Durchsatz. '
        'Weniger parallele Arbeit bedeutet direkt kürzere Durchlaufzeiten.',
  ),

  Question(
    id: 'scr-007',
    topicId: 'agil_scrum',
    subtopicId: 's-stories',
    kind: QuestionKind.multiple,
    difficulty: 3,
    tags: ['scrum', 'user_story'],
    prompt:
        'Welche Aussagen über User Stories und deren Akzeptanzkriterien sind korrekt?',
    choices: [
      _c(
        'Das Format lautet: Als <Rolle> möchte ich <Ziel>, um <Nutzen>.',
        true,
        'Das ist das Standardformat. Der "um ... zu"-Teil ist der wichtigste und wird am häufigsten weggelassen.',
      ),
      _c(
        'Akzeptanzkriterien legen fest, wann die Story als erfüllt gilt.',
        true,
        'Sie sind storyspezifisch und prüfbar, im Gegensatz zur Definition of Done, die für alle Stories gilt.',
      ),
      _c(
        'Die Definition of Done ersetzt die Akzeptanzkriterien.',
        false,
        'Falsch. Die DoD gilt teamweit für JEDES Increment (z. B. Code-Review erfolgt, Tests grün). Akzeptanzkriterien sind fachlich und gelten nur für diese eine Story. Beides muss erfüllt sein.',
      ),
      _c(
        'Story Points schätzen den Aufwand relativ, nicht in Stunden.',
        true,
        'Relative Schätzung ist stabiler als absolute: Menschen vergleichen zuverlässiger, als sie Stunden schätzen.',
      ),
      _c(
        'Eine User Story muss immer in einen Sprint passen.',
        true,
        'Passt sie nicht, wird sie im Refinement geteilt. Eine zu große Story heißt Epic.',
      ),
      _c(
        'Der Scrum Master schreibt die User Stories.',
        false,
        'Falsch. Verantwortlich für das Product Backlog ist der Product Owner; formulieren kann sie jeder im Team.',
      ),
    ],
    explanation:
        'INVEST als Qualitätscheck für Stories: Independent, Negotiable, '
        'Valuable, Estimable, Small, Testable. Der klassische Prüfungsfallstrick '
        'ist die Abgrenzung Akzeptanzkriterien (pro Story, fachlich) gegen '
        'Definition of Done (teamweit, handwerklich).',
  ),
];
