import '../models/question.dart';
import 'builders.dart';

Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Lasten-/Pflichtenheft, Wirtschaftlichkeit, Qualität und Risiko,
/// Projektabschluss.
final List<Question> seedAnforderungen = [
  // ---------------------------------------------------------- Lastenheft
  Question(
    id: 'lh-001',
    topicId: 'anforderungen',
    subtopicId: 'af-dokumente',
    kind: QuestionKind.matching,
    difficulty: 1,
    tags: ['lastenheft', 'pflichtenheft'],
    prompt:
        'Ordne jede Aussage dem richtigen Dokument zu. (Nach DIN 69901-5)',
    buckets: ['Lastenheft', 'Pflichtenheft'],
    matchItems: const [
      MatchItem(
        text: 'Wird vom Auftraggeber erstellt.',
        bucket: 0,
        rationale: 'Merksatz: Der Auftraggeber lädt dem Auftragnehmer die Last auf.',
      ),
      MatchItem(
        text: 'Wird vom Auftragnehmer erstellt.',
        bucket: 1,
        rationale: 'Der Auftragnehmer beschreibt, wie er die Pflicht erfüllt.',
      ),
      MatchItem(
        text: 'Beschreibt das WAS und WOFÜR, also die Gesamtheit der Anforderungen.',
        bucket: 0,
        rationale: 'Das Lastenheft ist bewusst lösungsneutral formuliert.',
      ),
      MatchItem(
        text: 'Beschreibt das WIE und WOMIT, also die konkrete technische Umsetzung.',
        bucket: 1,
        rationale: 'Erst im Pflichtenheft werden Technologien, Schnittstellen und Architektur festgelegt.',
      ),
      MatchItem(
        text: 'Ist Grundlage für die Ausschreibung und den Angebotsvergleich.',
        bucket: 0,
        rationale: 'Alle Anbieter bekommen dasselbe Lastenheft, denn nur so sind Angebote vergleichbar.',
      ),
      MatchItem(
        text: 'Wird vom Auftraggeber genehmigt und ist Grundlage der Abnahme.',
        bucket: 1,
        rationale: 'Das genehmigte Pflichtenheft ist der vertragliche Maßstab, gegen den abgenommen wird.',
      ),
    ],
    explanation:
        'Eselsbrücke: LAstenheft = Auftraggeber (der die Last verteilt), '
        'PFlichtenheft = Auftragnehmer (der die Pflicht übernimmt). '
        'Reihenfolge: Lastenheft -> Ausschreibung -> Angebote -> Zuschlag -> '
        'Pflichtenheft -> Genehmigung -> Umsetzung -> Abnahme gegen das '
        'Pflichtenheft.',
  ),

  Question(
    id: 'lh-002',
    topicId: 'anforderungen',
    subtopicId: 'af-arten',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['anforderungsarten'],
    prompt:
        'Handelt es sich um eine funktionale oder eine nicht-funktionale '
        'Anforderung?',
    buckets: ['Funktional', 'Nicht-funktional'],
    matchItems: const [
      MatchItem(
        text: 'Das System muss Rechnungen als PDF exportieren können.',
        bucket: 0,
        rationale: 'Eine konkrete Fähigkeit des Systems, also funktional.',
      ),
      MatchItem(
        text: 'Die Suchanfrage muss in unter 2 Sekunden beantwortet werden.',
        bucket: 1,
        rationale: 'Performance ist eine Qualitätseigenschaft, kein Funktionsumfang.',
      ),
      MatchItem(
        text: 'Benutzer müssen sich mit Zwei-Faktor-Authentifizierung anmelden können.',
        bucket: 0,
        rationale: 'Die Anmeldung mit 2FA ist eine Funktion, die das System bereitstellen muss.',
      ),
      MatchItem(
        text: 'Die Anwendung muss zu 99,5 % im Jahr verfügbar sein.',
        bucket: 1,
        rationale: 'Verfügbarkeit ist eine klassische nicht-funktionale Anforderung.',
      ),
      MatchItem(
        text: 'Die Oberfläche muss der BITV 2.0 für Barrierefreiheit entsprechen.',
        bucket: 1,
        rationale: 'Eine Randbedingung bzw. Qualitätsanforderung, denn sie beschreibt keine einzelne Funktion.',
      ),
      MatchItem(
        text: 'Administratoren können Benutzerkonten sperren und entsperren.',
        bucket: 0,
        rationale: 'Wieder eine konkrete Fähigkeit, also funktional.',
      ),
    ],
    explanation:
        'Testfrage zur Abgrenzung: Kann man die Anforderung als "Das System '
        'TUT etwas" formulieren? Dann funktional. Beschreibt sie eher, WIE GUT '
        'das System etwas tut (schnell, sicher, verfügbar, bedienbar, '
        'wartbar, portabel), dann nicht-funktional. '
        'Die Qualitätsmerkmale von Software (etwa Zuverlässigkeit, '
        'Benutzbarkeit, Effizienz und Sicherheit) sind eine gute Checkliste '
        'für nicht-funktionale Anforderungen.',
  ),

  markieren(
    'lh-003',
    'af-erhebung',
    difficulty: 2,
    tags: ['anforderungsqualität'],
    scenario:
        'Der Entwurf eines Lastenhefts für ein Ticketsystem enthält die '
        'folgenden Anforderungen.',
    prompt:
        'Markiere alle Anforderungen, die NICHT gut formuliert sind.',
    zeilen: [
      ja('Das System soll benutzerfreundlich sein.',
          'Nicht prüfbar: Niemand kann entscheiden, ob das erfüllt ist.'),
      nein('Die Suche liefert bei 10.000 Tickets ein Ergebnis in höchstens 2 Sekunden.',
          'Eindeutig und messbar.'),
      ja('Das System muss schnell reagieren.',
          'Ohne Messwert mehrdeutig, denn "schnell" versteht jeder anders.'),
      nein('Tickets können als PDF exportiert werden.',
          'Eine klare, prüfbare Fähigkeit des Systems.'),
      ja('Das System wird mit MySQL 8 und PHP umgesetzt.',
          'Nimmt die technische Lösung vorweg. Das WIE gehört ins Pflichtenheft.'),
      ja('Jeder Nutzer sieht alle Tickets. Kundentickets sieht nur das zuständige Team.',
          'Die beiden Sätze widersprechen sich.'),
      nein('Nach fünf Fehlversuchen wird das Benutzerkonto für 15 Minuten gesperrt.',
          'Vollständig, eindeutig und testbar.'),
    ],
    explanation:
        'Merkhilfe für Anforderungsqualität: eindeutig, vollständig, '
        'widerspruchsfrei, prüfbar, notwendig, verständlich, priorisiert. '
        'Eine vorweggenommene Lösung schließt bessere Alternativen aus, und '
        'Vagheit ist keine Flexibilität; die erreicht man über Prioritäten. '
        'Priorisierung erfolgt oft nach MoSCoW: Must have, Should have, '
        'Could have, Won’t have (this time).',
  ),

  Question(
    id: 'lh-004',
    topicId: 'leistungsstoerungen',
    subtopicId: 'ls-abnahme',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['abnahme'],
    scenario:
        'Ein Dienstleister liefert eine Software aus. Bei der Abnahme stellt der '
        'Kunde zwei kleinere Mängel fest, die den Betrieb nicht verhindern.',
    prompt: 'Was ist die übliche und rechtlich sinnvolle Vorgehensweise?',
    choices: [
      _c('Abnahme unter Vorbehalt: Mängel werden protokolliert und mit Frist zur Beseitigung vereinbart.', true,
          'Richtig. Die Abnahme unter Vorbehalt hält die Mängelrechte aufrecht und blockiert trotzdem nicht den Produktivstart.'),
      _c('Vollständige Verweigerung der Abnahme bis alle Mängel beseitigt sind.', false,
          'Bei unwesentlichen Mängeln ist die Verweigerung in der Regel unzulässig (vgl. Werkvertragsrecht) und schadet dem Kunden selbst, weil der Nutzen ausbleibt.'),
      _c('Vorbehaltlose Abnahme, die Mängel werden formlos per E-Mail gemeldet.', false,
          'Gefährlich: Mit der vorbehaltlosen Abnahme verliert der Kunde bei bekannten Mängeln Nacherfüllung, Minderung und Rücktritt. Nur Schadensersatz bleibt.'),
      _c('Die Abnahme entfällt, weil die Software bereits läuft.', false,
          'Die Abnahme ist ein formaler Rechtsakt mit erheblichen Folgen (Gefahrübergang, Fälligkeit der Vergütung, Beginn der Gewährleistung). Sie entfällt nicht durch Nutzung. Im Gegenteil kann Nutzung als konkludente Abnahme gelten.'),
    ],
    explanation:
        'Was an der Abnahme hängt: Fälligkeit der Vergütung, Gefahrübergang, '
        'Beginn der Verjährungsfrist für Gewährleistung und die Umkehr der '
        'Beweislast (danach muss der Kunde den Mangel beweisen). '
        'Deshalb ist das Abnahmeprotokoll mit Mängelliste kein Formalkram, '
        'sondern der wichtigste Zettel im Projekt.',
  ),

  Question(
    id: 'lh-005',
    topicId: 'anforderungen',
    subtopicId: 'af-dokumente',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['ablauf'],
    prompt:
        'Bringe die Schritte einer klassischen Fremdvergabe in die richtige '
        'Reihenfolge.',
    orderingHint: 'Vom ersten bis zum letzten Schritt',
    orderedItems: const [
      'Lastenheft durch den Auftraggeber erstellen',
      'Ausschreibung und Einholung von Angeboten',
      'Angebotsvergleich und Vergabeentscheidung',
      'Pflichtenheft durch den Auftragnehmer erstellen',
      'Genehmigung des Pflichtenhefts durch den Auftraggeber',
      'Realisierung',
      'Abnahme gegen das Pflichtenheft',
    ],
    explanation:
        'Die zwei Stellen, an denen in der Prüfung gern getauscht wird: '
        '(1) Das Pflichtenheft kommt NACH der Vergabe, denn vorher weiß man ja '
        'gar nicht, wer es schreibt. (2) Abgenommen wird gegen das '
        'Pflichtenheft, nicht gegen das Lastenheft, weil nur das '
        'Pflichtenheft die prüfbare Konkretisierung enthält.',
  ),

  Question(
    id: 'lh-006',
    topicId: 'change_management',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['scope_creep'],
    scenario:
        'Während der Realisierung bittet die Fachabteilung den Entwickler '
        'mehrfach direkt um "kleine Zusatzfunktionen". Der Termin ist unverändert.',
    prompt: 'Wie sollte die Projektleitung darauf reagieren?',
    choices: [
      _c('Jede Änderung über einen definierten Change-Request-Prozess mit Aufwands- und Terminbewertung führen.', true,
          'Richtig. Änderungen sind nicht verboten. Sie müssen nur bewertet und entschieden werden, statt still im Hintergrund zu passieren.'),
      _c('Die Zusatzwünsche ablehnen, weil das Pflichtenheft unterschrieben ist.', false,
          'Pauschale Ablehnung ist praxisfern und beschädigt die Zusammenarbeit. Anforderungen ändern sich. Das Problem ist der unkontrollierte Weg, nicht die Änderung selbst.'),
      _c('Die Wünsche kurzfristig mit umsetzen, solange sie klein sind.', false,
          'Genau so entsteht Scope Creep: viele kleine, nie bewertete Erweiterungen sprengen am Ende Termin und Budget, und niemand kann hinterher sagen, warum.'),
      _c('Die Entscheidung dem Entwickler überlassen, der den Aufwand am besten einschätzen kann.', false,
          'Der Entwickler kann den Aufwand schätzen, aber nicht über Umfang, Budget und Termin entscheiden. Das ist eine Projektleitungs- bzw. Auftraggeberentscheidung.'),
    ],
    explanation:
        'Change-Request-Prozess: Antrag erfassen -> Auswirkung auf Zeit, '
        'Kosten und Qualität bewerten -> Entscheidung durch das befugte '
        'Gremium bzw. den Auftraggeber -> bei Annahme Planung und Pflichtenheft '
        'fortschreiben. Der Kern ist Transparenz: Jeder soll sehen, was eine '
        'Änderung kostet.',
  ),

  // ------------------------------------------------------ Wirtschaftlichkeit
  Question(
    id: 'wi-001',
    topicId: 'pm_wirtschaftlichkeit',
    subtopicId: 'w-nutzwert',
    kind: QuestionKind.numeric,
    difficulty: 2,
    tags: ['nutzwertanalyse'],
    scenario:
        'Nutzwertanalyse für ein Ticketsystem. Bewertungsskala 1 (schlecht) bis '
        '5 (sehr gut).\n\n'
        'Kriterium (Gewichtung): Bewertung Anbieter B\n'
        'Funktionsumfang (40 %): 4\n'
        'Bedienbarkeit (25 %): 3\n'
        'Support (20 %): 5\n'
        'Preis (15 %): 2',
    prompt:
        'Wie hoch ist der Gesamtnutzwert von Anbieter B? '
        '(Zwei Nachkommastellen)',
    numericAnswer: 3.65,
    numericTolerance: 0.01,
    explanation:
        'Rechenweg für jedes Kriterium: Gewichtung x Bewertung, dann summieren:\n'
        'Funktionsumfang: 0,40 x 4 = 1,60\n'
        'Bedienbarkeit:   0,25 x 3 = 0,75\n'
        'Support:         0,20 x 5 = 1,00\n'
        'Preis:           0,15 x 2 = 0,30\n'
        'Gesamtnutzwert = 1,60 + 0,75 + 1,00 + 0,30 = 3,65\n\n'
        'Kontrolle: Die Gewichtungen müssen in Summe 100 % ergeben, sonst ist '
        'das Ergebnis nicht vergleichbar. Und der Nutzwert kann nie über dem '
        'Maximum der Skala (hier 5) liegen.',
  ),

  reihenfolge(
    'wi-002',
    'w-nutzwert',
    difficulty: 2,
    tags: ['nutzwertanalyse'],
    scenario:
        'Für ein neues Ticketsystem liegen drei Angebote vor. Neben dem Preis '
        'sollen Bedienbarkeit, Support und Zukunftssicherheit in die '
        'Entscheidung einfließen.',
    prompt: 'Bringe die Schritte der Nutzwertanalyse in die richtige Reihenfolge.',
    hint: 'Vom Kriterium zur Entscheidung',
    items: [
      'Bewertungskriterien festlegen',
      'Kriterien gewichten (Summe 100 %)',
      'Alternativen je Kriterium mit Punkten bewerten',
      'Teilnutzwerte berechnen: Gewicht x Bewertung',
      'Teilnutzwerte je Alternative aufsummieren',
      'Alternative mit dem höchsten Nutzwert wählen',
    ],
    explanation:
        'Die Nutzwertanalyse vergleicht Alternativen anhand mehrerer, '
        'unterschiedlich gewichteter und teils nicht monetärer Kriterien. '
        'Ablauf: 1. Kriterien festlegen, 2. gewichten '
        '(Summe 100 %), 3. Alternativen je Kriterium bewerten, '
        '4. Teilnutzwerte = Gewicht x Bewertung, 5. aufsummieren, '
        '6. höchster Nutzwert gewinnt.\n'
        'Schwäche, nach der gern gefragt wird: Gewichtung und Bewertung sind '
        'subjektiv. Wer das Ergebnis vorher kennt, kann es über die '
        'Gewichtung herbeiführen. Deshalb Kriterien VOR dem Blick auf die '
        'Angebote festlegen.',
  ),

  Question(
    id: 'wi-003',
    topicId: 'pm_wirtschaftlichkeit',
    subtopicId: 'w-breakeven',
    kind: QuestionKind.numeric,
    difficulty: 2,
    tags: ['amortisation'],
    scenario:
        'Eine Virtualisierungslösung kostet einmalig 48.000 Euro. Dadurch '
        'sinken die laufenden Kosten um 15.000 Euro pro Jahr.',
    prompt:
        'Nach wie vielen Jahren ist die Investition amortisiert? '
        '(Eine Nachkommastelle)',
    numericAnswer: 3.2,
    numericTolerance: 0.05,
    unit: 'Jahre',
    explanation:
        'Amortisationsdauer = Investitionssumme / jährlicher Rückfluss\n'
        '= 48.000 Euro / 15.000 Euro pro Jahr = 3,2 Jahre\n\n'
        'In Worten: nach rund 3 Jahren und 2-3 Monaten hat sich die Anschaffung '
        'bezahlt gemacht. Achtung bei Aufgaben, in denen zusätzlich laufende '
        'Kosten der neuen Lösung genannt werden. Dann muss man erst den '
        'NETTO-Rückfluss bilden (Einsparung minus neue laufende Kosten) und '
        'erst damit rechnen.',
  ),

  Question(
    id: 'wi-004',
    topicId: 'pm_wirtschaftlichkeit',
    subtopicId: 'w-kalkulation',
    kind: QuestionKind.numeric,
    difficulty: 3,
    tags: ['angebotsvergleich', 'bezugskalkulation'],
    scenario:
        'Ein Angebot für Netzwerk-Hardware:\n'
        'Listeneinkaufspreis: 12.000,00 Euro\n'
        'Rabatt: 15 %\n'
        'Skonto: 2 % bei Zahlung innerhalb von 10 Tagen\n'
        'Bezugskosten (Fracht, Versicherung): 250,00 Euro',
    prompt:
        'Wie hoch ist der Bezugspreis (Einstandspreis) bei Skontoausnutzung? '
        '(in Euro, zwei Nachkommastellen)',
    numericAnswer: 10246,
    numericTolerance: 0.5,
    unit: 'Euro',
    explanation:
        'Bezugskalkulation, immer in dieser Reihenfolge:\n'
        'Listeneinkaufspreis            12.000,00\n'
        '- Rabatt 15 %                 - 1.800,00\n'
        '= Zieleinkaufspreis            10.200,00\n'
        '- Skonto 2 % (von 10.200)     -   204,00\n'
        '= Bareinkaufspreis              9.996,00\n'
        '+ Bezugskosten                +   250,00\n'
        '= Bezugspreis/Einstandspreis   10.246,00 Euro\n\n'
        'Zwei klassische Fehler: (1) Skonto vom Listenpreis statt vom '
        'Zieleinkaufspreis rechnen, (2) die Bezugskosten vor dem Skontoabzug '
        'addieren, denn auf Fracht gibt es kein Skonto.',
  ),

  zuordnen(
    'wi-005',
    'w-makeorbuy',
    difficulty: 2,
    tags: ['tco'],
    scenario:
        'Für eine Serverbeschaffung wird eine TCO-Betrachtung (Total Cost of '
        'Ownership) aufgestellt.',
    prompt: 'Ordne jede Position dem Abschnitt der TCO-Betrachtung zu.',
    buckets: ['Anschaffung', 'Laufender Betrieb', 'Außerbetriebnahme', 'Kein Teil der TCO'],
    items: [
      zu('Strom- und Klimatisierungskosten', 1,
          'Laufende Betriebskosten sind bei Servern oft höher als der Kaufpreis.'),
      zu('Kaufpreis der Hardware', 0,
          'Der offensichtliche Teil, meist der kleinere.'),
      zu('Umsatz, der mit dem neuen System erzielt wird', 3,
          'TCO betrachtet ausschließlich Kosten. Erträge gehören in eine ROI-Rechnung.'),
      zu('Jährliche Lizenz- und Wartungsverträge', 1,
          'Wiederkehrende Kosten, die sich über fünf Jahre erheblich summieren.'),
      zu('Datenmigration auf das Nachfolgesystem und Entsorgung', 2,
          'Der oft vergessene letzte Lebenszyklusabschnitt.'),
      zu('Installation und Einrichtung im Serverraum', 0,
          'Einmalige Kosten bei der Beschaffung.'),
    ],
    explanation:
        'TCO betrachtet den gesamten Lebenszyklus: Beschaffung, Betrieb, '
        'Wartung, Schulung, Ausfallkosten, Außerbetriebnahme. Der Sinn ist, '
        'das billigste Angebot vom günstigsten zu unterscheiden. '
        'Wichtig zur Abgrenzung: TCO = nur Kosten. ROI und '
        'Wirtschaftlichkeitsrechnung = Kosten UND Nutzen.',
  ),

  // --------------------------------------------------------- Qualität/Risiko
  Question(
    id: 'qr-001',
    topicId: 'risikomanagement',
    subtopicId: 'r-bewertung',
    kind: QuestionKind.numeric,
    difficulty: 1,
    tags: ['risikobewertung'],
    scenario:
        'Für das Risiko "Ausfall des Hauptlieferanten" wurde eine '
        'Eintrittswahrscheinlichkeit von 20 % und eine Schadenshöhe von '
        '80.000 Euro geschätzt.',
    prompt: 'Wie hoch ist der Risikowert (Erwartungswert) in Euro?',
    numericAnswer: 16000,
    numericTolerance: 0,
    unit: 'Euro',
    explanation:
        'Risikowert = Eintrittswahrscheinlichkeit x Schadenshöhe\n'
        '= 0,20 x 80.000 Euro = 16.000 Euro\n\n'
        'Der Risikowert ist die Obergrenze für sinnvolle Gegenmaßnahmen: '
        'Eine Maßnahme, die 25.000 Euro kostet, lohnt sich hier nicht. '
        'Deshalb werden Risiken nach dem Risikowert priorisiert und nicht '
        'nach der Schadenshöhe allein.',
  ),

  Question(
    id: 'qr-002',
    topicId: 'risikomanagement',
    subtopicId: 'r-strategien',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['risikostrategien'],
    prompt: 'Ordne jede Maßnahme der passenden Risikostrategie zu.',
    buckets: ['Vermeiden', 'Vermindern', 'Überwälzen', 'Akzeptieren'],
    matchItems: const [
      MatchItem(
        text: 'Auf den Einsatz einer unausgereiften Technologie wird verzichtet.',
        bucket: 0,
        rationale: 'Die Ursache wird komplett beseitigt; die Eintrittswahrscheinlichkeit sinkt auf null.',
      ),
      MatchItem(
        text: 'Zusätzliche Code-Reviews und automatisierte Tests werden eingeführt.',
        bucket: 1,
        rationale: 'Die Eintrittswahrscheinlichkeit sinkt, das Risiko bleibt aber grundsätzlich bestehen.',
      ),
      MatchItem(
        text: 'Eine Betriebshaftpflichtversicherung wird abgeschlossen.',
        bucket: 2,
        rationale: 'Der finanzielle Schaden geht auf einen Dritten über, also klassisches Überwälzen.',
      ),
      MatchItem(
        text: 'Die Entwicklung wird an einen Dienstleister mit Festpreis vergeben.',
        bucket: 2,
        rationale: 'Das Kostenrisiko trägt beim Festpreis der Auftragnehmer.',
      ),
      MatchItem(
        text: 'Ein Restrisiko mit sehr geringem Schadenswert wird bewusst in Kauf genommen und dokumentiert.',
        bucket: 3,
        rationale: 'Akzeptieren ist eine legitime Strategie. Entscheidend ist, dass es bewusst und dokumentiert geschieht.',
      ),
      MatchItem(
        text: 'Ein Backup-Rechenzentrum wird bereitgehalten, um die Ausfalldauer zu begrenzen.',
        bucket: 1,
        rationale: 'Die Auswirkung wird reduziert. Das Risiko selbst bleibt bestehen, also Vermindern, nicht Vermeiden.',
      ),
    ],
    explanation:
        'Vier Strategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit '
        'oder Auswirkung runter), Überwälzen (Dritter trägt das Risiko), '
        'Akzeptieren (bewusst tragen).\n'
        'Der häufigste Fehler ist die Verwechslung von Vermeiden und '
        'Vermindern. Testfrage: Kann das Risiko danach überhaupt noch '
        'eintreten? Ja -> Vermindern. Nein -> Vermeiden.',
  ),

  tabelle(
    'qr-003',
    'qm-grundlagen',
    difficulty: 2,
    tags: ['qualitätssicherung'],
    scenario:
        'Ein Softwareteam listet auf, was es für die Qualität seiner '
        'Anwendung tut.',
    prompt: 'Ordne jede Maßnahme ein.',
    zeilen: [
      ['Maßnahme', 'Einordnung'],
      [
        'Verbindliche Coding-Standards und Styleguides',
        wahl('konstruktiv', ['analytisch', 'keine QS-Maßnahme'],
            'Verhindert Fehler von vornherein.'),
      ],
      [
        'Modul- und Integrationstests',
        wahl('analytisch', ['konstruktiv', 'keine QS-Maßnahme'],
            'Tests finden vorhandene Fehler, sie verhindern sie nicht.'),
      ],
      [
        'Schulung der Entwickler vor Projektbeginn',
        wahl('konstruktiv', ['analytisch', 'keine QS-Maßnahme'],
            'Qualifikation ist eine klassische vorbeugende Maßnahme.'),
      ],
      [
        'Code-Review nach Fertigstellung eines Moduls',
        wahl('analytisch', ['konstruktiv', 'keine QS-Maßnahme'],
            'Ein bereits erstelltes Artefakt wird geprüft.'),
      ],
      [
        'Einsatz erprobter Frameworks und Entwurfsmuster',
        wahl('konstruktiv', ['analytisch', 'keine QS-Maßnahme'],
            'Das Rad nicht neu erfinden heißt, dessen Fehler nicht neu zu machen.'),
      ],
      [
        'Überstunden in der Woche vor dem Release anordnen',
        wahl('keine QS-Maßnahme', ['konstruktiv', 'analytisch'],
            'Mehr Arbeitszeit verhindert und findet keine Fehler. Unter Zeitdruck entstehen eher neue.'),
      ],
    ],
    explanation:
        'Einfache Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler '
        '(Standards, Methoden, Werkzeuge, Schulung, Templates). '
        'ANALYTISCH = nachher, findet Fehler (Test, Review, Inspektion, '
        'statische Analyse, Audit).\n'
        'Grenzfall, der gern gefragt wird: Ein Linter ist konstruktiv, wenn er '
        'beim Schreiben eingreift, und analytisch, wenn er im Nachhinein über '
        'fertigen Code läuft. In der Prüfung zählt die Einordnung als '
        'Werkzeugvorgabe, also konstruktiv.',
    punkte: 3,
  ),

  Question(
    id: 'qr-004',
    topicId: 'risikomanagement',
    subtopicId: 'r-strategien',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['risikomatrix'],
    scenario:
        'In der Risikomatrix liegt Risiko X bei geringer '
        'Eintrittswahrscheinlichkeit, aber existenzbedrohender Schadenshöhe '
        '(z. B. vollständiger Datenverlust ohne Backup).',
    prompt: 'Wie ist mit einem solchen Risiko umzugehen?',
    choices: [
      _c('Es muss trotz geringer Wahrscheinlichkeit behandelt werden, weil der Schaden untragbar wäre.', true,
          'Richtig. Bei existenzbedrohenden Schäden greift die reine Erwartungswertlogik nicht mehr. Ein Schaden, den man nicht überlebt, darf nicht eintreten.'),
      _c('Es kann akzeptiert werden, weil der Risikowert rechnerisch niedrig ist.', false,
          'Genau der Denkfehler. Ein rechnerisch kleiner Erwartungswert hilft nicht, wenn der Einzelfall das Unternehmen beendet.'),
      _c('Es ist nachrangig gegenüber Risiken mit mittlerer Wahrscheinlichkeit und mittlerem Schaden.', false,
          'Falsch. Bei gleicher Rechengröße hat das Risiko mit dem katastrophalen Schadenspotenzial Vorrang.'),
      _c('Es gehört nicht in das Risikoregister, weil es unwahrscheinlich ist.', false,
          'Ins Register gehören alle identifizierten Risiken. Erst die Bewertung entscheidet über Maßnahmen.'),
    ],
    explanation:
        'Die Risikomatrix (Wahrscheinlichkeit x Auswirkung) hat eine '
        'eingebaute Schwäche: Sie behandelt "oft, aber harmlos" und '
        '"selten, aber katastrophal" gleich, wenn das Produkt gleich ist. '
        'In der Praxis zieht man deshalb eine Toleranzgrenze: Schäden '
        'oberhalb einer bestimmten Höhe werden unabhängig von der '
        'Wahrscheinlichkeit behandelt. Genau deshalb gibt es Backups, obwohl '
        'Totalausfälle selten sind.',
  ),

  // --------------------------------------------------------------- Abschluss
  Question(
    id: 'ab-001',
    topicId: 'projektabschluss',
    subtopicId: 'a-lessons',
    kind: QuestionKind.single,
    difficulty: 1,
    tags: ['lessons_learned'],
    prompt: 'Was ist das Ziel einer Lessons-Learned-Sitzung?',
    choices: [
      _c('Erfahrungen systematisch sichern, damit künftige Projekte davon profitieren.', true,
          'Richtig. Der Wert entsteht erst dadurch, dass die Erkenntnisse dokumentiert und in der Organisation verfügbar gemacht werden.'),
      _c('Die Verantwortlichen für Fehler im Projekt benennen.', false,
          'Genau das Gegenteil. Sobald Schuldzuweisungen drohen, sagt niemand mehr, was wirklich schieflief, und die Sitzung ist wertlos.'),
      _c('Die Abnahme des Projektergebnisses durch den Kunden.', false,
          'Die Abnahme ist ein eigener, vorgelagerter Schritt.'),
      _c('Die Schlussrechnung für den Kunden erstellen.', false,
          'Das ist kaufmännischer Projektabschluss, nicht Erfahrungssicherung.'),
    ],
    explanation:
        'Lessons Learned funktionieren nur unter drei Bedingungen: zeitnah '
        '(nicht Monate später), ohne Schuldzuweisung und mit dokumentiertem '
        'Ergebnis an einem Ort, an dem das nächste Projekt es auch findet. '
        'Eine Sitzung, deren Protokoll in einem Ordner verschwindet, ist '
        'verlorene Zeit.',
  ),

  freitext(
    'ab-002',
    'a-bericht',
    difficulty: 2,
    tags: ['abschlussbericht'],
    scenario:
        'Ein Projekt zur Einführung eines Ticketsystems ist abgenommen. Die '
        'Projektleitung schreibt den Projektabschlussbericht.',
    prompt: 'Nenne vier Inhalte eines Projektabschlussberichts.',
    kriterien: [
      krit('Soll-Ist-Vergleich von Terminen, Kosten und Leistungsumfang',
          stichwoerter: ['Soll-Ist', 'Vergleich', 'Abweichungen', 'Kosten', 'Termine']),
      krit('Zielerreichungsgrad bezogen auf den Projektauftrag',
          stichwoerter: ['Zielerreichung', 'Ziele erreicht', 'Projektauftrag']),
      krit('Lessons Learned und Verbesserungsvorschläge',
          stichwoerter: ['Lessons Learned', 'Erfahrungen', 'Verbesserungsvorschläge']),
      krit('Übergabe an Betrieb bzw. Linie mit benannten Verantwortlichen',
          stichwoerter: ['Übergabe', 'Betrieb', 'Linie', 'Verantwortliche']),
      krit('Offene Punkte und Restrisiken',
          stichwoerter: ['offene Punkte', 'Restarbeiten', 'Restrisiken']),
      krit('Kurzbeschreibung von Projektverlauf und Ergebnis',
          stichwoerter: ['Projektverlauf', 'Ergebnis', 'Zusammenfassung']),
    ],
    loesung:
        'Soll-Ist-Vergleich von Terminen, Kosten und Leistungsumfang, '
        'Zielerreichungsgrad bezogen auf den Projektauftrag, Lessons Learned '
        'und Verbesserungsvorschläge, Übergabe an den Betrieb mit benannten '
        'Verantwortlichen, offene Punkte und Restrisiken.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Der Quellcode gehört nicht '
        'in den Bericht, sondern ins Versionsverwaltungssystem.\n'
        'Der Projektabschluss hat drei Ebenen: sachlich-technisch (Abnahme, '
        'Übergabe an den Betrieb, Restarbeiten), kaufmännisch '
        '(Schlussrechnung, Nachkalkulation, Projekt schließen) und personell '
        '(Teamauflösung, Rückführung in die Linie, Würdigung). '
        'Die personelle Ebene wird am häufigsten vergessen und ist die, an '
        'die sich das Team am längsten erinnert.',
    punkte: 4,
  ),

  Question(
    id: 'ab-003',
    topicId: 'projektabschluss',
    subtopicId: 'a-abnahme',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['projektabschluss'],
    prompt: 'Bringe die Schritte des Projektabschlusses in eine sinnvolle Reihenfolge.',
    orderingHint: 'Vom ersten bis zum letzten Schritt',
    orderedItems: const [
      'Restarbeiten abschließen und Projektergebnis fertigstellen',
      'Abnahme durch den Auftraggeber mit Abnahmeprotokoll',
      'Übergabe an den Betrieb bzw. die Linienorganisation',
      'Projektabschlussbericht mit Soll-Ist-Vergleich erstellen',
      'Lessons Learned durchführen und dokumentieren',
      'Projektteam formal auflösen und Ressourcen freigeben',
    ],
    explanation:
        'Zwei Stellen, an denen gern getauscht wird: Die Abnahme kommt VOR der '
        'Übergabe an den Betrieb, denn man übergibt nichts, was der Kunde nicht '
        'angenommen hat. Und die Teamauflösung kommt ZULETZT, weil man für '
        'Bericht und Lessons Learned die Leute noch braucht. Wer das Team '
        'vorher auflöst, bekommt weder das eine noch das andere in '
        'brauchbarer Qualität.',
  ),
];
