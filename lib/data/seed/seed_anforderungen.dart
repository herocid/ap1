import '../models/question.dart';

Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Lasten-/Pflichtenheft, Wirtschaftlichkeit, Qualitaet und Risiko,
/// Projektabschluss.
final List<Question> seedAnforderungen = [
  // ---------------------------------------------------------- Lastenheft
  Question(
    id: 'lh-001',
    topicId: 'lastenheft',
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
        rationale: 'Merksatz: Der Auftraggeber laedt dem Auftragnehmer die Last auf.',
      ),
      MatchItem(
        text: 'Wird vom Auftragnehmer erstellt.',
        bucket: 1,
        rationale: 'Der Auftragnehmer beschreibt, wie er die Pflicht erfuellt.',
      ),
      MatchItem(
        text: 'Beschreibt das WAS und WOFUER - die Gesamtheit der Anforderungen.',
        bucket: 0,
        rationale: 'Das Lastenheft ist bewusst loesungsneutral formuliert.',
      ),
      MatchItem(
        text: 'Beschreibt das WIE und WOMIT - die konkrete technische Umsetzung.',
        bucket: 1,
        rationale: 'Erst im Pflichtenheft werden Technologien, Schnittstellen und Architektur festgelegt.',
      ),
      MatchItem(
        text: 'Ist Grundlage fuer die Ausschreibung und den Angebotsvergleich.',
        bucket: 0,
        rationale: 'Alle Anbieter bekommen dasselbe Lastenheft - nur so sind Angebote vergleichbar.',
      ),
      MatchItem(
        text: 'Wird vom Auftraggeber genehmigt und ist Grundlage der Abnahme.',
        bucket: 1,
        rationale: 'Das genehmigte Pflichtenheft ist der vertragliche Massstab, gegen den abgenommen wird.',
      ),
    ],
    explanation:
        'Eselsbruecke: LAstenheft = Auftraggeber (der die Last verteilt), '
        'PFlichtenheft = Auftragnehmer (der die Pflicht uebernimmt). '
        'Reihenfolge: Lastenheft -> Ausschreibung -> Angebote -> Zuschlag -> '
        'Pflichtenheft -> Genehmigung -> Umsetzung -> Abnahme gegen das '
        'Pflichtenheft.',
  ),

  Question(
    id: 'lh-002',
    topicId: 'lastenheft',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['anforderungsarten'],
    prompt:
        'Handelt es sich um eine funktionale oder eine nicht-funktionale '
        'Anforderung?',
    buckets: ['Funktional', 'Nicht-funktional'],
    matchItems: const [
      MatchItem(
        text: 'Das System muss Rechnungen als PDF exportieren koennen.',
        bucket: 0,
        rationale: 'Eine konkrete Faehigkeit des Systems - also funktional.',
      ),
      MatchItem(
        text: 'Die Suchanfrage muss in unter 2 Sekunden beantwortet werden.',
        bucket: 1,
        rationale: 'Performance ist eine Qualitaetseigenschaft, kein Funktionsumfang.',
      ),
      MatchItem(
        text: 'Benutzer muessen sich mit Zwei-Faktor-Authentifizierung anmelden koennen.',
        bucket: 0,
        rationale: 'Die Anmeldung mit 2FA ist eine Funktion, die das System bereitstellen muss.',
      ),
      MatchItem(
        text: 'Die Anwendung muss zu 99,5 % im Jahr verfuegbar sein.',
        bucket: 1,
        rationale: 'Verfuegbarkeit ist eine klassische nicht-funktionale Anforderung.',
      ),
      MatchItem(
        text: 'Die Oberflaeche muss der BITV 2.0 fuer Barrierefreiheit entsprechen.',
        bucket: 1,
        rationale: 'Eine Randbedingung bzw. Qualitaetsanforderung - sie beschreibt keine einzelne Funktion.',
      ),
      MatchItem(
        text: 'Administratoren koennen Benutzerkonten sperren und entsperren.',
        bucket: 0,
        rationale: 'Wieder eine konkrete Faehigkeit - funktional.',
      ),
    ],
    explanation:
        'Testfrage zur Abgrenzung: Kann man die Anforderung als "Das System '
        'TUT etwas" formulieren? Dann funktional. Beschreibt sie eher, WIE GUT '
        'das System etwas tut (schnell, sicher, verfuegbar, bedienbar, '
        'wartbar, portabel), dann nicht-funktional. '
        'Die sechs Qualitaetsmerkmale nach ISO 25010 sind eine gute '
        'Checkliste fuer nicht-funktionale Anforderungen.',
  ),

  Question(
    id: 'lh-003',
    topicId: 'lastenheft',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['anforderungsqualitaet'],
    prompt: 'Was zeichnet eine gut formulierte Anforderung aus?',
    choices: [
      _c('Sie ist eindeutig und laesst nur eine Interpretation zu.', true,
          'Mehrdeutigkeit ist die Hauptursache fuer Streit bei der Abnahme.'),
      _c('Sie ist ueberpruefbar bzw. testbar.', true,
          'Wenn niemand entscheiden kann, ob sie erfuellt ist, ist sie wertlos.'),
      _c('Sie ist vollstaendig - es fehlen keine notwendigen Angaben.', true,
          'Klassisches Kriterium aus der Anforderungsanalyse.'),
      _c('Sie enthaelt bereits die technische Loesung.', false,
          'Falsch, zumindest im Lastenheft. Eine vorweggenommene Loesung schliesst bessere Alternativen aus. Das WIE gehoert ins Pflichtenheft.'),
      _c('Sie ist mit anderen Anforderungen widerspruchsfrei.', true,
          'Widersprueche fallen sonst erst in der Umsetzung auf - dann ist die Korrektur teuer.'),
      _c('Sie ist moeglichst allgemein gehalten, um flexibel zu bleiben.', false,
          'Falsch. "Das System soll benutzerfreundlich sein" ist nicht flexibel, sondern unpruefbar. Flexibilitaet erreicht man ueber Prioritaeten, nicht ueber Vagheit.'),
    ],
    explanation:
        'Merkhilfe fuer Anforderungsqualitaet: eindeutig, vollstaendig, '
        'widerspruchsfrei, pruefbar, notwendig, verstaendlich, priorisiert. '
        'Priorisierung erfolgt oft nach MuSCoW: Must have, Should have, '
        'Could have, Won t have.',
  ),

  Question(
    id: 'lh-004',
    topicId: 'lastenheft',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['abnahme'],
    scenario:
        'Ein Dienstleister liefert eine Software aus. Bei der Abnahme stellt der '
        'Kunde zwei kleinere Maengel fest, die den Betrieb nicht verhindern.',
    prompt: 'Was ist die uebliche und rechtlich sinnvolle Vorgehensweise?',
    choices: [
      _c('Abnahme unter Vorbehalt: Maengel werden protokolliert und mit Frist zur Beseitigung vereinbart.', true,
          'Richtig. Die Abnahme unter Vorbehalt haelt die Maengelrechte aufrecht und blockiert trotzdem nicht den Produktivstart.'),
      _c('Vollstaendige Verweigerung der Abnahme bis alle Maengel beseitigt sind.', false,
          'Bei unwesentlichen Maengeln ist die Verweigerung in der Regel unzulaessig (vgl. Werkvertragsrecht) und schadet dem Kunden selbst, weil der Nutzen ausbleibt.'),
      _c('Vorbehaltlose Abnahme, die Maengel werden formlos per E-Mail gemeldet.', false,
          'Gefaehrlich: Mit der vorbehaltlosen Abnahme verliert der Kunde bei bekannten Maengeln seine Rechte darauf.'),
      _c('Die Abnahme entfaellt, weil die Software bereits laeuft.', false,
          'Die Abnahme ist ein formaler Rechtsakt mit erheblichen Folgen (Gefahruebergang, Faelligkeit der Verguetung, Beginn der Gewaehrleistung). Sie entfaellt nicht durch Nutzung - im Gegenteil kann Nutzung als konkludente Abnahme gelten.'),
    ],
    explanation:
        'Was an der Abnahme haengt: Faelligkeit der Verguetung, Gefahruebergang, '
        'Beginn der Verjaehrungsfrist fuer Gewaehrleistung und die Umkehr der '
        'Beweislast (danach muss der Kunde den Mangel beweisen). '
        'Deshalb ist das Abnahmeprotokoll mit Maengelliste kein Formalkram, '
        'sondern der wichtigste Zettel im Projekt.',
  ),

  Question(
    id: 'lh-005',
    topicId: 'lastenheft',
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
        'Die zwei Stellen, an denen in der Pruefung gern getauscht wird: '
        '(1) Das Pflichtenheft kommt NACH der Vergabe - vorher weiss man ja '
        'gar nicht, wer es schreibt. (2) Abgenommen wird gegen das '
        'Pflichtenheft, nicht gegen das Lastenheft, weil nur das '
        'Pflichtenheft die pruefbare Konkretisierung enthaelt.',
  ),

  Question(
    id: 'lh-006',
    topicId: 'lastenheft',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['scope_creep'],
    scenario:
        'Waehrend der Realisierung bittet die Fachabteilung den Entwickler '
        'mehrfach direkt um "kleine Zusatzfunktionen". Der Termin ist unveraendert.',
    prompt: 'Wie sollte die Projektleitung darauf reagieren?',
    choices: [
      _c('Jede Aenderung ueber einen definierten Change-Request-Prozess mit Aufwands- und Terminbewertung fuehren.', true,
          'Richtig. Aenderungen sind nicht verboten - sie muessen nur bewertet und entschieden werden, statt still im Hintergrund zu passieren.'),
      _c('Die Zusatzwuensche ablehnen, weil das Pflichtenheft unterschrieben ist.', false,
          'Pauschale Ablehnung ist praxisfern und beschaedigt die Zusammenarbeit. Anforderungen aendern sich - das Problem ist der unkontrollierte Weg, nicht die Aenderung selbst.'),
      _c('Die Wuensche kurzfristig mit umsetzen, solange sie klein sind.', false,
          'Genau so entsteht Scope Creep: viele kleine, nie bewertete Erweiterungen sprengen am Ende Termin und Budget, und niemand kann hinterher sagen, warum.'),
      _c('Die Entscheidung dem Entwickler ueberlassen, der den Aufwand am besten einschaetzen kann.', false,
          'Der Entwickler kann den Aufwand schaetzen, aber nicht ueber Umfang, Budget und Termin entscheiden. Das ist eine Projektleitungs- bzw. Auftraggeberentscheidung.'),
    ],
    explanation:
        'Change-Request-Prozess: Antrag erfassen -> Auswirkung auf Zeit, '
        'Kosten und Qualitaet bewerten -> Entscheidung durch den befugten '
        'Gremium bzw. Auftraggeber -> bei Annahme Planung und Pflichtenheft '
        'fortschreiben. Der Kern ist Transparenz: Jeder soll sehen, was eine '
        'Aenderung kostet.',
  ),

  // ------------------------------------------------------ Wirtschaftlichkeit
  Question(
    id: 'wi-001',
    topicId: 'wirtschaftlichkeit',
    kind: QuestionKind.numeric,
    difficulty: 2,
    tags: ['nutzwertanalyse'],
    scenario:
        'Nutzwertanalyse fuer ein Ticketsystem. Bewertungsskala 1 (schlecht) bis '
        '5 (sehr gut).\n\n'
        'Kriterium (Gewichtung) - Bewertung Anbieter B:\n'
        'Funktionsumfang (40 %) - 4\n'
        'Bedienbarkeit (25 %) - 3\n'
        'Support (20 %) - 5\n'
        'Preis (15 %) - 2',
    prompt:
        'Wie hoch ist der Gesamtnutzwert von Anbieter B? '
        '(Zwei Nachkommastellen)',
    numericAnswer: 3.65,
    numericTolerance: 0.01,
    explanation:
        'Rechenweg - jedes Kriterium: Gewichtung x Bewertung, dann summieren:\n'
        'Funktionsumfang: 0,40 x 4 = 1,60\n'
        'Bedienbarkeit:   0,25 x 3 = 0,75\n'
        'Support:         0,20 x 5 = 1,00\n'
        'Preis:           0,15 x 2 = 0,30\n'
        'Gesamtnutzwert = 1,60 + 0,75 + 1,00 + 0,30 = 3,65\n\n'
        'Kontrolle: Die Gewichtungen muessen in Summe 100 % ergeben, sonst ist '
        'das Ergebnis nicht vergleichbar. Und der Nutzwert kann nie ueber dem '
        'Maximum der Skala (hier 5) liegen.',
  ),

  Question(
    id: 'wi-002',
    topicId: 'wirtschaftlichkeit',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['nutzwertanalyse'],
    prompt: 'Wozu dient die Nutzwertanalyse?',
    choices: [
      _c('Zum Vergleich von Alternativen anhand mehrerer, unterschiedlich gewichteter und teils nicht monetaerer Kriterien.', true,
          'Richtig. Ihre Staerke ist, dass sie weiche Faktoren wie Bedienbarkeit oder Zukunftssicherheit vergleichbar macht.'),
      _c('Zur Berechnung des exakten Return on Investment.', false,
          'Der ROI ist eine rein monetaere Kennzahl. Die Nutzwertanalyse liefert dimensionslose Punkte, keine Euro.'),
      _c('Zur Ermittlung der Projektdauer.', false,
          'Das leistet die Netzplantechnik.'),
      _c('Zur rechtssicheren Dokumentation gegenueber dem Auftraggeber.', false,
          'Sie kann eine Entscheidung nachvollziehbar machen, ist aber kein Rechtsdokument.'),
    ],
    explanation:
        'Ablauf der Nutzwertanalyse: 1. Kriterien festlegen, 2. gewichten '
        '(Summe 100 %), 3. Alternativen je Kriterium bewerten, '
        '4. Teilnutzwerte = Gewicht x Bewertung, 5. aufsummieren, '
        '6. hoechster Nutzwert gewinnt.\n'
        'Schwaeche, nach der gern gefragt wird: Gewichtung und Bewertung sind '
        'subjektiv. Wer das Ergebnis vorher kennt, kann es ueber die '
        'Gewichtung herbeifuehren - deshalb Kriterien VOR dem Blick auf die '
        'Angebote festlegen.',
  ),

  Question(
    id: 'wi-003',
    topicId: 'wirtschaftlichkeit',
    kind: QuestionKind.numeric,
    difficulty: 2,
    tags: ['amortisation'],
    scenario:
        'Eine Virtualisierungsloesung kostet einmalig 48.000 Euro. Dadurch '
        'sinken die laufenden Kosten um 15.000 Euro pro Jahr.',
    prompt:
        'Nach wie vielen Jahren ist die Investition amortisiert? '
        '(Eine Nachkommastelle)',
    numericAnswer: 3.2,
    numericTolerance: 0.05,
    unit: 'Jahre',
    explanation:
        'Amortisationsdauer = Investitionssumme / jaehrlicher Rueckfluss\n'
        '= 48.000 Euro / 15.000 Euro pro Jahr = 3,2 Jahre\n\n'
        'In Worten: nach rund 3 Jahren und 2-3 Monaten hat sich die Anschaffung '
        'bezahlt gemacht. Achtung bei Aufgaben, in denen zusaetzlich laufende '
        'Kosten der neuen Loesung genannt werden - dann muss man erst den '
        'NETTO-Rueckfluss bilden (Einsparung minus neue laufende Kosten) und '
        'erst damit rechnen.',
  ),

  Question(
    id: 'wi-004',
    topicId: 'wirtschaftlichkeit',
    kind: QuestionKind.numeric,
    difficulty: 3,
    tags: ['angebotsvergleich', 'bezugskalkulation'],
    scenario:
        'Ein Angebot fuer Netzwerk-Hardware:\n'
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
        'Bezugskalkulation - immer in dieser Reihenfolge:\n'
        'Listeneinkaufspreis            12.000,00\n'
        '- Rabatt 15 %                 - 1.800,00\n'
        '= Zieleinkaufspreis            10.200,00\n'
        '- Skonto 2 % (von 10.200)     -   204,00\n'
        '= Bareinkaufspreis              9.996,00\n'
        '+ Bezugskosten                +   250,00\n'
        '= Bezugspreis/Einstandspreis   10.246,00 Euro\n\n'
        'Zwei klassische Fehler: (1) Skonto vom Listenpreis statt vom '
        'Zieleinkaufspreis rechnen, (2) die Bezugskosten vor dem Skontoabzug '
        'addieren - auf Fracht gibt es kein Skonto.',
  ),

  Question(
    id: 'wi-005',
    topicId: 'wirtschaftlichkeit',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['tco'],
    prompt:
        'Welche Positionen gehoeren in eine TCO-Betrachtung (Total Cost of '
        'Ownership) fuer eine Serverbeschaffung?',
    choices: [
      _c('Anschaffungskosten der Hardware', true,
          'Die direkten Anschaffungskosten sind der offensichtliche Teil - meist der kleinere.'),
      _c('Strom- und Klimatisierungskosten ueber die Nutzungsdauer', true,
          'Laufende Betriebskosten sind bei Servern oft hoeher als der Kaufpreis.'),
      _c('Lizenz- und Wartungsvertraege', true,
          'Wiederkehrende Kosten, die sich ueber 5 Jahre erheblich summieren.'),
      _c('Schulungsaufwand fuer die Administratoren', true,
          'Auch indirekte Personalkosten gehoeren dazu - das unterscheidet TCO vom reinen Anschaffungspreis.'),
      _c('Der Umsatz, der mit dem neuen System erzielt wird', false,
          'Falsch. TCO betrachtet ausschliesslich die KOSTEN. Ertraege gehoeren in eine Wirtschaftlichkeits- oder ROI-Rechnung.'),
      _c('Entsorgungs- und Migrationskosten am Ende der Nutzungsdauer', true,
          'Der oft vergessene letzte Lebenszyklusabschnitt gehoert ausdruecklich dazu.'),
    ],
    explanation:
        'TCO betrachtet den gesamten Lebenszyklus: Beschaffung, Betrieb, '
        'Wartung, Schulung, Ausfallkosten, Ausserbetriebnahme. Der Sinn ist, '
        'das billigste Angebot vom guenstigsten zu unterscheiden. '
        'Wichtig zur Abgrenzung: TCO = nur Kosten. ROI und '
        'Wirtschaftlichkeitsrechnung = Kosten UND Nutzen.',
  ),

  // --------------------------------------------------------- Qualitaet/Risiko
  Question(
    id: 'qr-001',
    topicId: 'qualitaet_risiko',
    kind: QuestionKind.numeric,
    difficulty: 1,
    tags: ['risikobewertung'],
    scenario:
        'Fuer das Risiko "Ausfall des Hauptlieferanten" wurde eine '
        'Eintrittswahrscheinlichkeit von 20 % und eine Schadenshoehe von '
        '80.000 Euro geschaetzt.',
    prompt: 'Wie hoch ist der Risikowert (Erwartungswert) in Euro?',
    numericAnswer: 16000,
    numericTolerance: 0,
    unit: 'Euro',
    explanation:
        'Risikowert = Eintrittswahrscheinlichkeit x Schadenshoehe\n'
        '= 0,20 x 80.000 Euro = 16.000 Euro\n\n'
        'Der Risikowert ist die Obergrenze fuer sinnvolle Gegenmassnahmen: '
        'Eine Massnahme, die 25.000 Euro kostet, lohnt sich hier nicht. '
        'Deshalb werden Risiken nach dem Risikowert priorisiert und nicht '
        'nach der Schadenshoehe allein.',
  ),

  Question(
    id: 'qr-002',
    topicId: 'qualitaet_risiko',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['risikostrategien'],
    prompt: 'Ordne jede Massnahme der passenden Risikostrategie zu.',
    buckets: ['Vermeiden', 'Vermindern', 'Ueberwaelzen', 'Akzeptieren'],
    matchItems: const [
      MatchItem(
        text: 'Auf den Einsatz einer unausgereiften Technologie wird verzichtet.',
        bucket: 0,
        rationale: 'Die Ursache wird komplett beseitigt - die Eintrittswahrscheinlichkeit sinkt auf null.',
      ),
      MatchItem(
        text: 'Zusaetzliche Code-Reviews und automatisierte Tests werden eingefuehrt.',
        bucket: 1,
        rationale: 'Die Eintrittswahrscheinlichkeit sinkt, das Risiko bleibt aber grundsaetzlich bestehen.',
      ),
      MatchItem(
        text: 'Eine Betriebshaftpflichtversicherung wird abgeschlossen.',
        bucket: 2,
        rationale: 'Der finanzielle Schaden geht auf einen Dritten ueber - klassisches Ueberwaelzen.',
      ),
      MatchItem(
        text: 'Die Entwicklung wird an einen Dienstleister mit Festpreis vergeben.',
        bucket: 2,
        rationale: 'Das Kostenrisiko traegt beim Festpreis der Auftragnehmer.',
      ),
      MatchItem(
        text: 'Ein Restrisiko mit sehr geringem Schadenswert wird bewusst in Kauf genommen und dokumentiert.',
        bucket: 3,
        rationale: 'Akzeptieren ist eine legitime Strategie - entscheidend ist, dass es bewusst und dokumentiert geschieht.',
      ),
      MatchItem(
        text: 'Ein Backup-Rechenzentrum wird bereitgehalten, um die Ausfalldauer zu begrenzen.',
        bucket: 1,
        rationale: 'Die Auswirkung wird reduziert. Das Risiko selbst bleibt bestehen - also Vermindern, nicht Vermeiden.',
      ),
    ],
    explanation:
        'Vier Strategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit '
        'oder Auswirkung runter), Ueberwaelzen (Dritter traegt das Risiko), '
        'Akzeptieren (bewusst tragen).\n'
        'Der haeufigste Fehler ist die Verwechslung von Vermeiden und '
        'Vermindern. Testfrage: Kann das Risiko danach ueberhaupt noch '
        'eintreten? Ja -> Vermindern. Nein -> Vermeiden.',
  ),

  Question(
    id: 'qr-003',
    topicId: 'qualitaet_risiko',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['qualitaetssicherung'],
    prompt:
        'Welche der folgenden Massnahmen sind KONSTRUKTIVE '
        'Qualitaetssicherungsmassnahmen?',
    choices: [
      _c('Verbindliche Coding-Standards und Styleguides', true,
          'Konstruktiv: Sie verhindern Fehler von vornherein, statt sie hinterher zu finden.'),
      _c('Einsatz erprobter Frameworks und Entwurfsmuster', true,
          'Ebenfalls vorbeugend - das Rad nicht neu erfinden heisst, dessen Fehler nicht neu zu machen.'),
      _c('Schulung der Entwickler vor Projektbeginn', true,
          'Qualifikation ist eine klassische konstruktive Massnahme.'),
      _c('Durchfuehrung von Modul- und Integrationstests', false,
          'Das ist ANALYTISCHE QS: Tests finden vorhandene Fehler, sie verhindern sie nicht.'),
      _c('Code-Review nach Fertigstellung eines Moduls', false,
          'Ebenfalls analytisch - es wird ein bereits erstelltes Artefakt geprueft.'),
      _c('Einsatz einer einheitlichen Entwicklungsumgebung mit Linter-Konfiguration', true,
          'Vorbeugend: Der Linter verhindert bestimmte Fehlerklassen schon beim Tippen.'),
    ],
    explanation:
        'Einfache Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler '
        '(Standards, Methoden, Werkzeuge, Schulung, Templates). '
        'ANALYTISCH = nachher, findet Fehler (Test, Review, Inspektion, '
        'statische Analyse, Audit).\n'
        'Grenzfall, der gern gefragt wird: Ein Linter ist konstruktiv, wenn er '
        'beim Schreiben eingreift, und analytisch, wenn er im Nachhinein ueber '
        'fertigen Code laeuft. In der Pruefung zaehlt die Einordnung als '
        'Werkzeugvorgabe - also konstruktiv.',
  ),

  Question(
    id: 'qr-004',
    topicId: 'qualitaet_risiko',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['risikomatrix'],
    scenario:
        'In der Risikomatrix liegt Risiko X bei geringer '
        'Eintrittswahrscheinlichkeit, aber existenzbedrohender Schadenshoehe '
        '(z. B. vollstaendiger Datenverlust ohne Backup).',
    prompt: 'Wie ist mit einem solchen Risiko umzugehen?',
    choices: [
      _c('Es muss trotz geringer Wahrscheinlichkeit behandelt werden, weil der Schaden untragbar waere.', true,
          'Richtig. Bei existenzbedrohenden Schaeden greift die reine Erwartungswertlogik nicht mehr - ein Schaden, den man nicht ueberlebt, darf nicht eintreten.'),
      _c('Es kann akzeptiert werden, weil der Risikowert rechnerisch niedrig ist.', false,
          'Genau der Denkfehler. Ein rechnerisch kleiner Erwartungswert hilft nicht, wenn der Einzelfall das Unternehmen beendet.'),
      _c('Es ist nachrangig gegenueber Risiken mit mittlerer Wahrscheinlichkeit und mittlerem Schaden.', false,
          'Falsch. Bei gleicher Rechengroesse hat das Risiko mit dem katastrophalen Schadenspotenzial Vorrang.'),
      _c('Es gehoert nicht in das Risikoregister, weil es unwahrscheinlich ist.', false,
          'Ins Register gehoeren alle identifizierten Risiken. Erst die Bewertung entscheidet ueber Massnahmen.'),
    ],
    explanation:
        'Die Risikomatrix (Wahrscheinlichkeit x Auswirkung) hat eine '
        'eingebaute Schwaeche: Sie behandelt "oft, aber harmlos" und '
        '"selten, aber katastrophal" gleich, wenn das Produkt gleich ist. '
        'In der Praxis zieht man deshalb eine Toleranzgrenze: Schaeden '
        'oberhalb einer bestimmten Hoehe werden unabhaengig von der '
        'Wahrscheinlichkeit behandelt. Genau deshalb gibt es Backups, obwohl '
        'Totalausfaelle selten sind.',
  ),

  // --------------------------------------------------------------- Abschluss
  Question(
    id: 'ab-001',
    topicId: 'abschluss',
    kind: QuestionKind.single,
    difficulty: 1,
    tags: ['lessons_learned'],
    prompt: 'Was ist das Ziel einer Lessons-Learned-Sitzung?',
    choices: [
      _c('Erfahrungen systematisch sichern, damit kuenftige Projekte davon profitieren.', true,
          'Richtig. Der Wert entsteht erst dadurch, dass die Erkenntnisse dokumentiert und in der Organisation verfuegbar gemacht werden.'),
      _c('Die Verantwortlichen fuer Fehler im Projekt benennen.', false,
          'Genau das Gegenteil. Sobald Schuldzuweisungen drohen, sagt niemand mehr, was wirklich schieflief - und die Sitzung ist wertlos.'),
      _c('Die Abnahme des Projektergebnisses durch den Kunden.', false,
          'Die Abnahme ist ein eigener, vorgelagerter Schritt.'),
      _c('Die Schlussrechnung fuer den Kunden erstellen.', false,
          'Das ist kaufmaennischer Projektabschluss, nicht Erfahrungssicherung.'),
    ],
    explanation:
        'Lessons Learned funktionieren nur unter drei Bedingungen: zeitnah '
        '(nicht Monate spaeter), ohne Schuldzuweisung und mit dokumentiertem '
        'Ergebnis an einem Ort, an dem das naechste Projekt es auch findet. '
        'Eine Sitzung, deren Protokoll in einem Ordner verschwindet, ist '
        'verlorene Zeit.',
  ),

  Question(
    id: 'ab-002',
    topicId: 'abschluss',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['abschlussbericht'],
    prompt: 'Was gehoert in einen Projektabschlussbericht?',
    choices: [
      _c('Soll-Ist-Vergleich von Terminen, Kosten und Leistungsumfang', true,
          'Der Kern des Berichts: Was war geplant, was ist herausgekommen, warum die Abweichung?'),
      _c('Zielerreichungsgrad bezogen auf den Projektauftrag', true,
          'Gemessen wird gegen das, was im Auftrag stand - nicht gegen das, was unterwegs daraus wurde.'),
      _c('Lessons Learned und Verbesserungsvorschlaege', true,
          'Die Erfahrungssicherung gehoert in den Bericht, nicht nur ins Sitzungsprotokoll.'),
      _c('Uebergabe an Betrieb bzw. Linie mit benannten Verantwortlichen', true,
          'Ohne klare Uebergabe bleibt das Projektteam ewig zustaendig - ein haeufiger Praxisfehler.'),
      _c('Der vollstaendige Quellcode der Anwendung', false,
          'Falsch. Der Code gehoert ins Versionsverwaltungssystem, nicht in den Bericht. Der Bericht verweist darauf.'),
      _c('Offene Punkte und Restrisiken', true,
          'Was nicht erledigt wurde, muss benannt und an jemanden uebergeben werden.'),
    ],
    explanation:
        'Der Projektabschluss hat drei Ebenen: sachlich-technisch (Abnahme, '
        'Uebergabe an den Betrieb, Restarbeiten), kaufmaennisch '
        '(Schlussrechnung, Nachkalkulation, Projekt schliessen) und personell '
        '(Teamaufloesung, Rueckfuehrung in die Linie, Wuerdigung). '
        'Die personelle Ebene wird am haeufigsten vergessen - und ist die, an '
        'die sich das Team am laengsten erinnert.',
  ),

  Question(
    id: 'ab-003',
    topicId: 'abschluss',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['projektabschluss'],
    prompt: 'Bringe die Schritte des Projektabschlusses in eine sinnvolle Reihenfolge.',
    orderingHint: 'Vom ersten bis zum letzten Schritt',
    orderedItems: const [
      'Restarbeiten abschliessen und Projektergebnis fertigstellen',
      'Abnahme durch den Auftraggeber mit Abnahmeprotokoll',
      'Uebergabe an den Betrieb bzw. die Linienorganisation',
      'Projektabschlussbericht mit Soll-Ist-Vergleich erstellen',
      'Lessons Learned durchfuehren und dokumentieren',
      'Projektteam formal aufloesen und Ressourcen freigeben',
    ],
    explanation:
        'Zwei Stellen, an denen gern getauscht wird: Die Abnahme kommt VOR der '
        'Uebergabe an den Betrieb - man uebergibt nichts, was der Kunde nicht '
        'angenommen hat. Und die Teamaufloesung kommt ZULETZT, weil man fuer '
        'Bericht und Lessons Learned die Leute noch braucht. Wer das Team '
        'vorher aufloest, bekommt weder das eine noch das andere in '
        'brauchbarer Qualitaet.',
  ),
];
