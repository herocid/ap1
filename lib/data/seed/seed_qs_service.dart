import '../models/question.dart';

Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Bereich 05 (Qualitätssicherung) und Bereich 07 (Vertragsmanagement &
/// Service).
final List<Question> seedQsService = [
  // ============================================== 05.01 Qualitätsmanagement
  Question(
    id: 'qm-001',
    topicId: 'qualitaetsmanagement',
    kind: QuestionKind.ordering,
    difficulty: 1,
    tags: ['pdca'],
    prompt: 'Bringe die Phasen des PDCA-Zyklus in die richtige Reihenfolge.',
    orderingHint: 'Beginne mit der Planung',
    orderedItems: const [
      'Plan - Ziel festlegen und Maßnahme planen',
      'Do - Maßnahme im Kleinen ausprobieren',
      'Check - Ergebnis mit dem Ziel vergleichen',
      'Act - bei Erfolg zum Standard machen, sonst nachbessern',
    ],
    explanation:
        'Der PDCA-Zyklus (auch Deming-Kreis) ist das Grundmuster jeder '
        'kontinuierlichen Verbesserung. Zwei Punkte werden gern falsch '
        'verstanden:\n'
        '- "Do" heißt ausprobieren im kleinen Rahmen, nicht flächendeckend '
        'ausrollen. Das Ausrollen passiert erst in "Act".\n'
        '- Der Zyklus endet nicht, sondern beginnt von vorn - deshalb Kreis '
        'und nicht Liste.',
  ),

  Question(
    id: 'qm-002',
    topicId: 'qualitaetsmanagement',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['qualitätsbegriff'],
    prompt: 'Was bedeutet Qualität im Sinne des Qualitätsmanagements?',
    choices: [
      _c('Der Grad, in dem ein Produkt die festgelegten Anforderungen erfüllt.',
          true,
          'Richtig. Qualität ist relativ zu den vereinbarten Anforderungen - nicht absolut.'),
      _c('Die technisch bestmögliche Ausführung eines Produkts.', false,
          'Falsch. Das wäre Perfektion. Ein Produkt, das teurer ist als gefordert, hat nicht mehr Qualität, sondern verschwendet Budget.'),
      _c('Die Abwesenheit jeglicher Fehler.', false,
          'Falsch. Nullfehler ist ein Ziel, keine Definition. Auch ein Produkt mit bekannten, akzeptierten Restmängeln kann die Anforderungen erfüllen.'),
      _c('Die Zufriedenheit der Entwickler mit dem Ergebnis.', false,
          'Falsch. Maßstab ist die Anforderung des Kunden, nicht das Empfinden des Teams.'),
    ],
    explanation:
        'Qualität = Erfüllungsgrad der Anforderungen. Daraus folgt eine '
        'praktische Konsequenz: Ohne prüfbar formulierte Anforderungen kann '
        'man Qualität gar nicht feststellen. Deshalb hängen '
        'Anforderungsanalyse und Qualitätssicherung unmittelbar zusammen - '
        'und deshalb ist eine unprüfbare Anforderung wie "benutzerfreundlich" '
        'ein Qualitätsproblem, bevor die erste Zeile Code geschrieben ist.',
  ),

  Question(
    id: 'qm-003',
    topicId: 'qualitaetsmanagement',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['qs_maßnahmen'],
    prompt:
        'Ordne die Maßnahmen der konstruktiven oder analytischen '
        'Qualitätssicherung zu.',
    buckets: ['Konstruktiv (verhindert Fehler)', 'Analytisch (findet Fehler)'],
    matchItems: const [
      MatchItem(
        text: 'Verbindlicher Styleguide für die Programmierung',
        bucket: 0,
        rationale: 'Eine Vorgabe, die bestimmte Fehler gar nicht erst entstehen lässt.',
      ),
      MatchItem(
        text: 'Code-Review eines fertigen Moduls',
        bucket: 1,
        rationale: 'Ein bereits erstelltes Artefakt wird geprüft - also analytisch.',
      ),
      MatchItem(
        text: 'Schulung der Entwickler vor Projektbeginn',
        bucket: 0,
        rationale: 'Qualifikation ist eine klassische vorbeugende Maßnahme.',
      ),
      MatchItem(
        text: 'Automatisierter Unit-Test in der Build-Pipeline',
        bucket: 1,
        rationale: 'Tests finden vorhandene Fehler, sie verhindern sie nicht.',
      ),
      MatchItem(
        text: 'Einsatz eines erprobten Frameworks statt Eigenentwicklung',
        bucket: 0,
        rationale: 'Das Rad nicht neu erfinden heißt, dessen Fehler nicht neu zu machen.',
      ),
      MatchItem(
        text: 'Abnahmetest durch den Auftraggeber',
        bucket: 1,
        rationale: 'Prüfung des fertigen Produkts - analytisch.',
      ),
    ],
    explanation:
        'Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler (Standards, '
        'Methoden, Werkzeuge, Schulung, Templates). ANALYTISCH = nachher, '
        'findet Fehler (Test, Review, Inspektion, Audit).\n'
        'Merksatz: Der Test findet den Fehler, der Standard verhindert ihn. '
        'Wirtschaftlich ist konstruktive QS fast immer überlegen - siehe '
        'Rule of Ten.',
  ),

  Question(
    id: 'qm-004',
    topicId: 'qualitaetsmanagement',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['qualitätsplanung'],
    scenario:
        'Ein Team startet ein Projekt und legt seine Qualitätsziele fest.',
    prompt: 'Welche Festlegungen gehören in die Qualitätsplanung?',
    choices: [
      _c('Welche Qualitätsmerkmale gemessen werden und mit welchem Zielwert',
          true,
          'Ohne Zielwert ist später nicht entscheidbar, ob die Qualität erreicht wurde.'),
      _c('Welche Prüfmaßnahmen wann durchgeführt werden', true,
          'Der Prüfplan legt fest, an welchen Punkten geprüft wird - sonst prüft am Ende niemand.'),
      _c('Wer für die Qualitätssicherung verantwortlich ist', true,
          'Ohne benannte Verantwortung wird QS die Aufgabe, die jeder für die anderen für zuständig hält.'),
      _c('Die konkrete Anzahl der zu erwartenden Fehler', false,
          'Falsch. Eine Fehlerzahl lässt sich nicht sinnvoll im Voraus festlegen. Man plant Maßnahmen und Schwellwerte, keine Fehlerquoten als Ziel.'),
      _c('Die Definition of Done bzw. die Abnahmekriterien', true,
          'Die Festlegung, wann etwas fertig ist, ist der Kern der Qualitätsplanung.'),
      _c('Der vollständige Quellcode der Testfälle', false,
          'Falsch. Testfälle entstehen später in der Umsetzung. Geplant wird, DASS und WIE getestet wird.'),
    ],
    explanation:
        'Qualitätsplanung beantwortet vier Fragen: Was wird gemessen? Welcher '
        'Zielwert gilt? Wann und wie wird geprüft? Wer ist verantwortlich?\n'
        'Der häufigste Fehler in der Praxis ist, Qualitätsziele nur '
        'qualitativ zu formulieren ("hohe Performance"). Ohne Zahl ist das '
        'keine Planung, sondern ein Wunsch.',
  ),

  // =========================================================== 05.02 Testen
  Question(
    id: 'te-001',
    topicId: 'testen',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['teststufen'],
    prompt:
        'Bringe die Teststufen in die Reihenfolge, in der sie üblicherweise '
        'durchlaufen werden.',
    orderingHint: 'Vom kleinsten Prüfgegenstand zum größten',
    orderedItems: const [
      'Modultest (Unittest) - einzelne Funktion oder Klasse',
      'Integrationstest - Zusammenspiel mehrerer Komponenten',
      'Systemtest - das komplette System in der Testumgebung',
      'Abnahmetest - das System beim Auftraggeber',
    ],
    explanation:
        'Die vier Teststufen bauen aufeinander auf: Je höher die Stufe, '
        'desto größer der Prüfgegenstand und desto näher am Kunden.\n'
        '- Modultest: entwickelt meist der Programmierer selbst.\n'
        '- Integrationstest: prüft Schnittstellen zwischen Komponenten.\n'
        '- Systemtest: prüft das Gesamtsystem gegen die Spezifikation, in '
        'einer möglichst produktionsähnlichen Testumgebung.\n'
        '- Abnahmetest: prüft gegen die Anforderungen des Auftraggebers, '
        'in dessen Verantwortung.\n'
        'Systemtest und Abnahmetest werden gern verwechselt: der Systemtest '
        'ist Sache des Auftragnehmers, der Abnahmetest die des Auftraggebers.',
  ),

  Question(
    id: 'te-002',
    topicId: 'testen',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['blackbox', 'whitebox'],
    prompt: 'Black-Box- oder White-Box-Test?',
    buckets: ['Black-Box', 'White-Box'],
    matchItems: const [
      MatchItem(
        text: 'Der Tester kennt den Quellcode nicht und prüft nur Eingabe und Ausgabe.',
        bucket: 0,
        rationale: 'Genau die Definition: die innere Struktur bleibt eine schwarze Kiste.',
      ),
      MatchItem(
        text: 'Die Testfälle werden so gewählt, dass jeder Programmzweig einmal durchlaufen wird.',
        bucket: 1,
        rationale: 'Zweigabdeckung setzt Kenntnis des Codes voraus - also White-Box.',
      ),
      MatchItem(
        text: 'Grundlage sind ausschließlich die Anforderungen aus dem Pflichtenheft.',
        bucket: 0,
        rationale: 'Anforderungsbasiertes Testen ohne Blick in den Code.',
      ),
      MatchItem(
        text: 'Der Entwickler prüft seine eigene Schleifenlogik mit Grenzwerten für den Zähler.',
        bucket: 1,
        rationale: 'Die Logik im Inneren wird gezielt adressiert.',
      ),
      MatchItem(
        text: 'Der Abnahmetest durch den Fachbereich.',
        bucket: 0,
        rationale: 'Der Fachbereich testet fachlich gegen die Anforderungen, nicht gegen den Code.',
      ),
      MatchItem(
        text: 'Code-Coverage wird als Kennzahl erhoben.',
        bucket: 1,
        rationale: 'Überdeckungsmaße beziehen sich zwangsläufig auf den Quellcode.',
      ),
    ],
    explanation:
        'Black-Box: Testfälle aus den Anforderungen, ohne Kenntnis des Codes. '
        'Typische Verfahren sind Äquivalenzklassenbildung und '
        'Grenzwertanalyse.\n'
        'White-Box: Testfälle aus der Struktur des Codes, mit Überdeckungs'
        'kriterien wie Anweisungs- oder Zweigabdeckung.\n'
        'Faustregel für die Prüfung: Steht "kennt den Code nicht" oder '
        '"gegen die Anforderungen", ist es Black-Box. Steht "Zweig", '
        '"Pfad", "Coverage" oder "Schleifenlogik", ist es White-Box.',
  ),

  Question(
    id: 'te-003',
    topicId: 'testen',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['testfall', 'testprotokoll'],
    prompt: 'Was gehört in einen vollständigen Testfall?',
    choices: [
      _c('Eindeutige Testfall-Nummer oder -Bezeichnung', true,
          'Ohne Kennung lässt sich ein Fehler später nicht dem Testfall zuordnen.'),
      _c('Vorbedingung bzw. Ausgangszustand', true,
          'Ein Testfall ist nur reproduzierbar, wenn der Startzustand definiert ist.'),
      _c('Konkrete Eingabedaten', true,
          '"Irgendeine gültige Eingabe" ist kein Testfall, sondern eine Absichtserklärung.'),
      _c('Das erwartete Ergebnis (Soll-Ergebnis)', true,
          'Der wichtigste Teil. Ohne Soll-Ergebnis kann niemand entscheiden, ob der Test bestanden ist.'),
      _c('Der Name des Entwicklers, der den Fehler verursacht hat', false,
          'Falsch - und schädlich. Testfälle dienen der Fehlersuche, nicht der Schuldzuweisung.'),
      _c('Die geschätzte Dauer der Fehlerbehebung', false,
          'Falsch. Das ist eine Planungsgröße für die Korrektur, kein Bestandteil des Testfalls.'),
    ],
    explanation:
        'Ein Testfall besteht aus: Kennung, Vorbedingung, Eingabe, erwartetes '
        'Ergebnis - und nach der Durchführung zusätzlich dem tatsächlichen '
        'Ergebnis sowie dem Urteil bestanden/nicht bestanden. Erst das '
        'zusammen ergibt das Testprotokoll.\n'
        'Der häufigste Fehler in Prüfungsaufgaben: das Soll-Ergebnis '
        'vergessen. Ein Test ohne Soll-Ergebnis kann nicht fehlschlagen und '
        'ist damit wertlos.',
  ),

  Question(
    id: 'te-004',
    topicId: 'testen',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['schreibtischtest'],
    scenario:
        'Eine Entwicklerin geht einen fremden Algorithmus Zeile für Zeile '
        'auf Papier durch und notiert nach jeder Anweisung die aktuellen '
        'Variablenwerte.',
    prompt: 'Wie heißt dieses Verfahren?',
    choices: [
      _c('Schreibtischtest', true,
          'Richtig. Der Code wird ohne Ausführung manuell nachvollzogen - im Katalog 2025 ausdrücklich genannt.'),
      _c('Regressionstest', false,
          'Falsch. Ein Regressionstest prüft nach einer Änderung, ob bisher funktionierende Teile noch laufen.'),
      _c('Integrationstest', false,
          'Falsch. Der Integrationstest prüft das Zusammenspiel mehrerer Komponenten, nicht eine einzelne Anweisungsfolge.'),
      _c('Lasttest', false,
          'Falsch. Ein Lasttest prüft das Verhalten unter hoher Beanspruchung.'),
    ],
    explanation:
        'Der Schreibtischtest (auch Trockentest oder Code-Walkthrough) ist '
        'ein statisches Verfahren: Der Code wird gelesen und nachvollzogen, '
        'nicht ausgeführt.\n'
        'Praktisch geht man mit einer Wertetabelle vor - eine Spalte je '
        'Variable, eine Zeile je Durchlauf. Genau diese Tabelle verlangt die '
        'AP1 häufig als Lösung. Wer sie sauber führt, findet den Fehler '
        'fast von selbst; wer im Kopf rechnet, verrechnet sich.',
  ),

  Question(
    id: 'te-005',
    topicId: 'testen',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['regressionstest'],
    scenario:
        'Nach der Korrektur eines Fehlers im Rechnungsmodul funktioniert '
        'plötzlich der Export nicht mehr, der vorher lief.',
    prompt: 'Welche Testart hätte das verhindern können?',
    choices: [
      _c('Regressionstest', true,
          'Richtig. Der Regressionstest wiederholt bereits bestandene Tests, um genau solche Nebenwirkungen zu entdecken.'),
      _c('Abnahmetest', false,
          'Der Abnahmetest findet am Ende beim Kunden statt - dann ist der Schaden schon da.'),
      _c('Lasttest', false,
          'Ein Lasttest prüft Verhalten unter Last, nicht die fachliche Korrektheit nach Änderungen.'),
      _c('Usability-Test', false,
          'Der prüft die Bedienbarkeit, nicht die Funktion.'),
    ],
    explanation:
        'Regression heißt Rückschritt: Eine Änderung macht etwas kaputt, '
        'das vorher funktionierte. Der Regressionstest läuft deshalb nach '
        'JEDER Änderung und wiederholt die bisherigen Tests.\n'
        'Genau deshalb lohnt sich Testautomatisierung: Manuell wiederholt '
        'niemand hundert Tests nach jedem Bugfix. Automatisiert kostet es '
        'Minuten.',
  ),

  // ========================================================= 07.01 Verträge
  Question(
    id: 've-001',
    topicId: 'vertraege',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['vertragsarten'],
    prompt: 'Ordne die Beschreibung der passenden Vertragsart zu.',
    buckets: ['Kaufvertrag', 'Werkvertrag', 'Dienstvertrag'],
    matchItems: const [
      MatchItem(
        text: 'Geschuldet wird ein konkreter Erfolg, zum Beispiel eine fertige, abnahmefähige Software.',
        bucket: 1,
        rationale: 'Erfolg geschuldet = Werkvertrag. Deshalb gibt es hier eine Abnahme.',
      ),
      MatchItem(
        text: 'Geschuldet wird die Tätigkeit als solche, nicht ein bestimmtes Ergebnis.',
        bucket: 2,
        rationale: 'Dienstvertrag: bezahlt wird die geleistete Arbeit, etwa bei Beratung oder Personalgestellung.',
      ),
      MatchItem(
        text: 'Übereignung einer Sache gegen Zahlung des Kaufpreises.',
        bucket: 0,
        rationale: 'Der klassische Kaufvertrag, zum Beispiel beim Hardwareeinkauf.',
      ),
      MatchItem(
        text: 'Die Vergütung wird mit der Abnahme fällig.',
        bucket: 1,
        rationale: 'Typisch für den Werkvertrag - ohne Abnahme keine Fälligkeit.',
      ),
      MatchItem(
        text: 'Ein externer Administrator wird stundenweise für Support bereitgestellt.',
        bucket: 2,
        rationale: 'Bereitgestellt wird Arbeitszeit, kein definiertes Werk.',
      ),
      MatchItem(
        text: 'Gewährleistung richtet sich nach dem Zustand der gelieferten Sache bei Gefahrübergang.',
        bucket: 0,
        rationale: 'Sachmangelhaftung des Kaufrechts.',
      ),
    ],
    explanation:
        'Die Abgrenzung entscheidet sich an einer Frage: Wird ein ERFOLG '
        'geschuldet oder eine TÄTIGKEIT?\n'
        '- Werkvertrag: Erfolg. Es gibt eine Abnahme, und erst danach wird '
        'gezahlt. Typisch für Individualsoftware und Projekte mit Festpreis.\n'
        '- Dienstvertrag: Tätigkeit. Bezahlt wird nach Aufwand, es gibt '
        'keine Abnahme. Typisch für Beratung, Support und Zeitverträge.\n'
        '- Kaufvertrag: Übereignung einer Sache, etwa Standardsoftware auf '
        'Datenträger oder Hardware.\n'
        'Für die Prüfung wichtig: Die Bezeichnung im Vertrag entscheidet '
        'nicht - maßgeblich ist, was tatsächlich geschuldet wird.',
  ),

  Question(
    id: 've-002',
    topicId: 'vertraege',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['lizenzen'],
    prompt: 'Welche Aussagen zu Softwarelizenzen sind richtig?',
    choices: [
      _c('Eine Einzelplatzlizenz berechtigt zur Installation auf einem bestimmten Arbeitsplatz.',
          true,
          'Die klassische Form - gebunden an ein Gerät oder einen benannten Nutzer.'),
      _c('Bei einer Concurrent-User-Lizenz zählt die Zahl der gleichzeitigen Nutzer.',
          true,
          'Nicht die Zahl der installierten Kopien, sondern die gleichzeitige Nutzung ist begrenzt.'),
      _c('Open-Source-Software darf immer kostenlos und uneingeschränkt kommerziell genutzt werden.',
          false,
          'Falsch. Open Source heißt offener Quellcode, nicht bedingungslos frei. Copyleft-Lizenzen wie die GPL verpflichten dazu, Änderungen unter derselben Lizenz weiterzugeben.'),
      _c('Bei einem Software-Abonnement (SaaS) erwirbt man Nutzungsrechte auf Zeit, kein Eigentum.',
          true,
          'Läuft das Abo aus, endet das Nutzungsrecht - ein wesentlicher Unterschied zum Kauf.'),
      _c('Eine Volumenlizenz ist immer günstiger als der Einzelkauf derselben Stückzahl.',
          false,
          'In der Regel ja, aber "immer" ist falsch. Volumenlizenzen haben Mindestabnahmen und Laufzeiten, die sich bei kleinen Stückzahlen nicht rechnen.'),
      _c('Freeware ist kostenlos, der Quellcode ist aber nicht zwingend offen.',
          true,
          'Genau der Unterschied zu Open Source: kostenlos sagt nichts über den Quellcode.'),
    ],
    explanation:
        'Vier Begriffe sauber trennen:\n'
        '- Freeware: kostenlos, Quellcode geschlossen.\n'
        '- Open Source: Quellcode offen, oft mit Pflichten (Copyleft).\n'
        '- Proprietär: kostenpflichtig, Quellcode geschlossen.\n'
        '- SaaS/Abo: Nutzungsrecht auf Zeit, Betrieb beim Anbieter.\n'
        'Lizenzmodelle nach Zählweise: pro Gerät, pro benanntem Nutzer, '
        'pro gleichzeitigem Nutzer (concurrent), pro CPU/Core, '
        'nutzungsabhängig.',
  ),

  Question(
    id: 've-003',
    topicId: 'vertraege',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['urheberrecht'],
    scenario:
        'Eine Auszubildende entwickelt während ihrer Arbeitszeit ein '
        'Skript, das im Betrieb produktiv eingesetzt wird.',
    prompt: 'Wie ist die urheberrechtliche Lage in Deutschland?',
    choices: [
      _c('Die Urheberin bleibt sie selbst, die Nutzungsrechte liegen aber beim Arbeitgeber.',
          true,
          'Richtig. Das Urheberrecht ist in Deutschland nicht übertragbar; übertragen werden nur Nutzungsrechte - bei Arbeitnehmern regelmäßig automatisch an den Arbeitgeber.'),
      _c('Der Arbeitgeber wird automatisch Urheber der Software.', false,
          'Falsch. Urheber kann nur eine natürliche Person sein, und das Urheberrecht selbst ist nicht übertragbar.'),
      _c('Die Auszubildende kann die Nutzung jederzeit untersagen.', false,
          'Falsch. Für im Arbeitsverhältnis geschaffene Software erwirbt der Arbeitgeber die Nutzungsrechte.'),
      _c('Software ist urheberrechtlich nicht geschützt, nur patentierbar.', false,
          'Falsch. Computerprogramme sind ausdrücklich urheberrechtlich geschützt. Reine Software ist in Europa umgekehrt kaum patentierbar.'),
    ],
    explanation:
        'Kern des deutschen Urheberrechts: Urheber ist immer die natürliche '
        'Person, die das Werk geschaffen hat. Dieses Recht kann man weder '
        'verkaufen noch verschenken - nur vererben.\n'
        'Was übertragen wird, sind NUTZUNGSRECHTE: einfach (mehrere dürfen '
        'nutzen) oder ausschließlich (nur einer). Bei Software, die in '
        'Erfüllung des Arbeitsvertrags entsteht, erhält der Arbeitgeber '
        'die ausschließlichen Nutzungsrechte.',
  ),

  Question(
    id: 've-004',
    topicId: 'vertraege',
    kind: QuestionKind.multiple,
    difficulty: 1,
    tags: ['vertragsbestandteile'],
    prompt: 'Was sollte ein IT-Dienstleistungsvertrag mindestens regeln?',
    choices: [
      _c('Leistungsbeschreibung bzw. Verweis auf das Pflichtenheft', true,
          'Ohne beschriebene Leistung lässt sich später nicht feststellen, ob erfüllt wurde.'),
      _c('Vergütung und Zahlungsbedingungen', true,
          'Höhe, Fälligkeit und Zahlungsziel gehören zwingend hinein.'),
      _c('Termine und Fristen', true,
          'Ohne Termin gibt es keinen Verzug - und damit keine Handhabe bei Verspätung.'),
      _c('Regelungen zu Gewährleistung und Haftung', true,
          'Legt fest, wer bei Mängeln und Schäden in welchem Umfang einsteht.'),
      _c('Die Namen aller eingesetzten Entwickler', false,
          'Falsch. Das wäre unpraktikabel - Personal wechselt. Geregelt werden höchstens Qualifikationsanforderungen.'),
      _c('Vereinbarungen zu Datenschutz und Vertraulichkeit', true,
          'Bei Zugriff auf personenbezogene Daten ist ein Auftragsverarbeitungsvertrag sogar Pflicht.'),
    ],
    explanation:
        'Mindestinhalte: Vertragsparteien, Leistungsbeschreibung, Vergütung, '
        'Termine, Mitwirkungspflichten des Auftraggebers, Abnahme, '
        'Gewährleistung, Haftung, Datenschutz/Geheimhaltung, Laufzeit und '
        'Kündigung.\n'
        'Die Mitwirkungspflichten werden am häufigsten vergessen und führen '
        'am häufigsten zu Streit: Wenn der Auftraggeber Testdaten oder '
        'Ansprechpartner nicht liefert, kann der Auftragnehmer den Termin '
        'nicht halten - ohne Regelung steht dann Aussage gegen Aussage.',
  ),

  // ======================================================= 07.02 Service/SLA
  Question(
    id: 'sl-001',
    topicId: 'sla_service',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['sla'],
    prompt: 'Was regelt ein Service Level Agreement (SLA)?',
    choices: [
      _c('Verfügbarkeit des Dienstes, meist als Prozentwert pro Zeitraum',
          true,
          'Die zentrale Kennzahl, zum Beispiel 99,5 % im Monat.'),
      _c('Reaktionszeit - wie schnell auf eine Störung reagiert wird', true,
          'Reaktionszeit ist die Zeit bis zur ersten Rückmeldung, nicht bis zur Lösung.'),
      _c('Wiederherstellungszeit - wie schnell die Störung behoben sein muss',
          true,
          'Die zweite Zeitgröße. Reaktions- und Wiederherstellungszeit werden ständig verwechselt.'),
      _c('Servicezeiten, in denen die vereinbarten Werte gelten', true,
          'Ein SLA mit 15 Minuten Reaktionszeit ist wertlos, wenn unklar bleibt, ob das auch sonntags um 3 Uhr gilt.'),
      _c('Den Quellcode der betriebenen Anwendung', false,
          'Falsch. Quellcode-Fragen regelt gegebenenfalls ein Hinterlegungsvertrag (Escrow), nicht das SLA.'),
      _c('Folgen bei Nichteinhaltung, etwa Vergütungsminderung', true,
          'Ohne Konsequenz ist ein SLA eine Absichtserklärung.'),
    ],
    explanation:
        'Ein SLA macht Servicequalität messbar und einklagbar. Die vier '
        'Größen, die man auseinanderhalten muss:\n'
        '- Servicezeit: wann der Service überhaupt erbracht wird (z. B. '
        'Mo-Fr 8-18 Uhr).\n'
        '- Verfügbarkeit: Anteil der Servicezeit ohne Störung.\n'
        '- Reaktionszeit: bis zur ersten qualifizierten Rückmeldung.\n'
        '- Wiederherstellungszeit: bis die Störung behoben ist.\n'
        'Typische Prüfungsfalle: "Reaktionszeit 1 Stunde" bedeutet NICHT, '
        'dass das Problem nach einer Stunde gelöst ist.',
  ),

  Question(
    id: 'sl-002',
    topicId: 'sla_service',
    kind: QuestionKind.numeric,
    difficulty: 3,
    tags: ['verfügbarkeit'],
    scenario:
        'Ein SLA sichert eine Verfügbarkeit von 99,5 % zu. Die vereinbarte '
        'Servicezeit beträgt 24 Stunden an 30 Tagen im Monat.',
    prompt:
        'Wie viele Minuten Ausfall sind in diesem Monat höchstens zulässig?',
    numericAnswer: 216,
    numericTolerance: 1,
    unit: 'Minuten',
    explanation:
        'Rechenweg:\n'
        '1. Servicezeit im Monat = 30 Tage x 24 h x 60 min = 43.200 Minuten\n'
        '2. Zulässige Ausfallquote = 100 % - 99,5 % = 0,5 % = 0,005\n'
        '3. Erlaubter Ausfall = 43.200 x 0,005 = 216 Minuten (3,6 Stunden)\n\n'
        'Merke die Größenordnungen - danach wird gern gefragt:\n'
        '99 % = rund 7,2 Stunden Ausfall im Monat\n'
        '99,5 % = rund 3,6 Stunden\n'
        '99,9 % = rund 43 Minuten\n'
        'Jede Neun kostet ungefähr den Faktor 10 an Aufwand.',
  ),

  Question(
    id: 'sl-003',
    topicId: 'sla_service',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['support_level'],
    scenario:
        'Ein Anwender meldet, dass sein Drucker nicht mehr reagiert. Der '
        'Mitarbeiter am Telefon nimmt die Störung auf, prüft die '
        'Standardlösungen und kann sie nicht beheben.',
    prompt: 'Was passiert als Nächstes im mehrstufigen Support?',
    choices: [
      _c('Eskalation an den 2nd-Level-Support mit dokumentiertem Ticket', true,
          'Richtig. Der 1st Level nimmt auf, klassifiziert und löst Standardfälle; alles andere geht dokumentiert weiter nach oben.'),
      _c('Das Ticket wird geschlossen, der Anwender meldet sich neu.', false,
          'Falsch. Ein ungelöstes Ticket wird nie geschlossen - der Vorgang und seine Historie müssen erhalten bleiben.'),
      _c('Direkte Weitergabe an den Hersteller (3rd Level).', false,
          'Falsch. Die Stufen werden der Reihe nach durchlaufen. Der 3rd Level ist der Hersteller bzw. die Entwicklung und wird erst eingeschaltet, wenn der 2nd Level nicht weiterkommt.'),
      _c('Der Anwender erhält Administratorrechte, um es selbst zu lösen.', false,
          'Falsch und sicherheitstechnisch fatal. Rechteausweitung ist keine Supportmaßnahme.'),
    ],
    explanation:
        'Die Supportstufen:\n'
        '- 1st Level: Annahme, Klassifizierung, Lösung bekannter '
        'Standardfälle. Ziel ist eine hohe Erstlösungsquote.\n'
        '- 2nd Level: Fachspezialisten mit tieferem Systemwissen.\n'
        '- 3rd Level: Hersteller oder Entwicklung, bei Fehlern im Produkt '
        'selbst.\n'
        'Wichtig für die Prüfung: Das Ticket bleibt beim Eskalieren '
        'bestehen und wandert mit seiner kompletten Historie. Der Anwender '
        'behält einen Ansprechpartner - das nennt sich '
        'Ownership-Prinzip.',
  ),

  // ============================================= 07.03 Leistungsstörungen
  Question(
    id: 'ls-001',
    topicId: 'leistungsstoerungen',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['verzug'],
    scenario:
        'Ein Lieferant hat eine Serverlieferung für den 1. Oktober fest '
        'zugesagt. Am 10. Oktober ist nichts geliefert.',
    prompt: 'Welche Voraussetzung für Lieferverzug ist hier erfüllt?',
    choices: [
      _c('Die Leistung ist fällig und der Termin kalendermäßig bestimmt - es braucht keine Mahnung.',
          true,
          'Richtig. Bei einem kalendermäßig festgelegten Termin tritt Verzug automatisch mit Fristablauf ein.'),
      _c('Verzug tritt erst ein, wenn der Kunde dreimal gemahnt hat.', false,
          'Falsch. Drei Mahnungen sind ein Mythos aus der Praxis, keine Rechtsvoraussetzung.'),
      _c('Verzug setzt immer eine schriftliche Mahnung voraus.', false,
          'Falsch. Eine Mahnung ist nur nötig, wenn kein kalendermäßig bestimmter Termin vereinbart wurde.'),
      _c('Verzug tritt automatisch 30 Tage nach Vertragsschluss ein.', false,
          'Die 30-Tage-Regel gilt für den Zahlungsverzug nach Rechnungszugang, nicht für Lieferverzug.'),
    ],
    explanation:
        'Verzug setzt voraus: fällige Leistung, Nichtleistung, Verschulden '
        'des Schuldners und grundsätzlich eine Mahnung.\n'
        'Die Mahnung entfällt unter anderem, wenn ein Termin nach dem '
        'Kalender bestimmt ist ("Lieferung am 1. Oktober") oder wenn der '
        'Schuldner die Leistung ernsthaft und endgültig verweigert.\n'
        'Beim ZAHLUNGSverzug gilt zusätzlich: Spätestens 30 Tage nach '
        'Zugang einer Rechnung tritt Verzug auch ohne Mahnung ein - bei '
        'Verbrauchern nur, wenn darauf hingewiesen wurde.',
  ),

  Question(
    id: 'ls-002',
    topicId: 'leistungsstoerungen',
    kind: QuestionKind.ordering,
    difficulty: 3,
    tags: ['mängelrechte'],
    prompt:
        'In welcher Reihenfolge stehen dem Kunden die Mängelrechte beim '
        'Werkvertrag üblicherweise zu?',
    orderingHint: 'Vom vorrangigen zum nachrangigen Recht',
    orderedItems: const [
      'Nacherfüllung verlangen (Mangelbeseitigung oder Neuherstellung)',
      'Nach erfolgloser Fristsetzung: Selbstvornahme und Ersatz der Kosten',
      'Minderung der Vergütung oder Rücktritt vom Vertrag',
      'Schadensersatz bzw. Ersatz vergeblicher Aufwendungen',
    ],
    explanation:
        'Der Vorrang der Nacherfüllung ist das Grundprinzip: Der '
        'Auftragnehmer bekommt zuerst die Gelegenheit, selbst nachzubessern. '
        'Erst wenn das scheitert oder eine gesetzte Frist fruchtlos '
        'verstreicht, stehen die weiteren Rechte offen.\n'
        'Praktische Konsequenz: Wer sofort mindert oder einen anderen '
        'Dienstleister beauftragt, ohne eine Frist zur Nacherfüllung zu '
        'setzen, verliert seine Ansprüche. Deshalb gehört in jede '
        'Mangelanzeige eine konkrete Frist.',
  ),

  Question(
    id: 'ls-003',
    topicId: 'leistungsstoerungen',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['abnahmeprotokoll'],
    prompt: 'Was gehört in ein Abnahmeprotokoll?',
    choices: [
      _c('Datum, Ort und die anwesenden Personen beider Seiten', true,
          'Ohne Beteiligte und Datum ist das Protokoll als Nachweis wertlos.'),
      _c('Gegenstand der Abnahme mit Verweis auf das Pflichtenheft', true,
          'Abgenommen wird gegen ein definiertes Soll - der Verweis stellt das her.'),
      _c('Liste der festgestellten Mängel mit Fristen zur Beseitigung', true,
          'Der wichtigste Teil. Nicht protokollierte Mängel gelten bei vorbehaltloser Abnahme als akzeptiert.'),
      _c('Erklärung, ob die Abnahme erfolgt, unter Vorbehalt erfolgt oder verweigert wird',
          true,
          'Diese Erklärung ist der eigentliche Rechtsakt.'),
      _c('Unterschriften beider Vertragsparteien', true,
          'Erst die Unterschriften machen das Protokoll zum Nachweis.'),
      _c('Die interne Kalkulation des Auftragnehmers', false,
          'Falsch. Die Kalkulation ist ein Geschäftsgeheimnis des Auftragnehmers und hat im Protokoll nichts zu suchen.'),
    ],
    explanation:
        'An der Abnahme hängen vier Rechtsfolgen: Fälligkeit der '
        'Vergütung, Gefahrübergang, Beginn der Verjährungsfrist für '
        'Mängelansprüche und die Umkehr der Beweislast - danach muss der '
        'Kunde beweisen, dass ein Mangel schon bei Abnahme vorlag.\n'
        'Deshalb ist das Abnahmeprotokoll kein Formalkram, sondern der '
        'wichtigste Zettel im Projekt. Wer bekannte Mängel nicht '
        'protokolliert, verliert die Rechte darauf.',
  ),

  // ============================================== 07.04 Change Management
  Question(
    id: 'cm-001',
    topicId: 'change_management',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['lewin'],
    prompt: 'Bringe die drei Phasen des Lewin-Modells in die richtige Reihenfolge.',
    orderingHint: 'Von der Vorbereitung zur Verankerung',
    orderedItems: const [
      'Unfreeze - Auftauen: Veränderungsbedarf verdeutlichen, Widerstände ansprechen',
      'Change - Verändern: neue Abläufe einführen und begleiten',
      'Refreeze - Einfrieren: den neuen Zustand stabilisieren und zum Standard machen',
    ],
    explanation:
        'Lewins Modell erklärt, warum Veränderungen scheitern: Meist wird '
        'die erste oder die letzte Phase übersprungen.\n'
        '- Ohne "Unfreeze" fehlt die Einsicht, dass sich etwas ändern muss - '
        'die Betroffenen halten am Alten fest.\n'
        '- Ohne "Refreeze" fällt die Organisation nach einigen Wochen in '
        'alte Gewohnheiten zurück, weil der neue Zustand nie verankert '
        'wurde.\n'
        'In der Change-Phase sinkt die Leistung typischerweise vorübergehend '
        'ab - das ist normal und kein Zeichen des Scheiterns.',
  ),

  Question(
    id: 'cm-002',
    topicId: 'change_management',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['widerstand'],
    scenario:
        'Bei der Einführung eines neuen Ticketsystems weigern sich mehrere '
        'erfahrene Mitarbeitende, das System zu nutzen.',
    prompt: 'Welche Maßnahmen sind geeignet, den Widerstand abzubauen?',
    choices: [
      _c('Die Betroffenen frühzeitig einbeziehen und ihre Erfahrung in die Gestaltung einfließen lassen',
          true,
          'Beteiligung ist die wirksamste Maßnahme - wer mitgestaltet hat, blockiert selten.'),
      _c('Den Nutzen für die tägliche Arbeit konkret und nachvollziehbar erklären',
          true,
          'Widerstand entsteht oft aus fehlendem Sinn, nicht aus Bequemlichkeit.'),
      _c('Schulungen und eine Begleitung in der Umstellungsphase anbieten', true,
          'Ein Teil des Widerstands ist schlicht Unsicherheit im Umgang mit dem Neuen.'),
      _c('Die Nutzung per Anweisung durchsetzen und Verstöße sanktionieren',
          false,
          'Falsch als erste Maßnahme. Druck erzeugt Scheinanpassung: Das System wird formal benutzt und die eigentliche Arbeit läuft weiter daneben.'),
      _c('Erfahrene Mitarbeitende als Multiplikatoren gewinnen', true,
          'Wer die Skeptiker zu Vorbildern macht, dreht den Widerstand in Unterstützung.'),
      _c('Das alte System sofort abschalten, um Ausweichen zu verhindern', false,
          'Falsch als alleinige Maßnahme. Ein harter Schnitt ohne Vorbereitung erzeugt Chaos und verfestigt die Ablehnung.'),
    ],
    explanation:
        'Widerstand ist kein Defekt der Mitarbeitenden, sondern eine '
        'Information: Er zeigt, dass Sinn, Können oder Beteiligung fehlen.\n'
        'Die drei typischen Ursachen und ihre Gegenmittel:\n'
        '- "Ich verstehe es nicht" -> informieren, Nutzen erklären.\n'
        '- "Ich kann es nicht" -> schulen, begleiten.\n'
        '- "Ich will es nicht" -> beteiligen, Bedenken ernst nehmen.\n'
        'Anordnung und Sanktion sind das letzte Mittel, nicht das erste.',
  ),

  Question(
    id: 'cm-003',
    topicId: 'change_management',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['kaizen'],
    prompt: 'Was kennzeichnet Kaizen bzw. den kontinuierlichen Verbesserungsprozess?',
    choices: [
      _c('Laufende Verbesserung in vielen kleinen Schritten, getragen von allen Mitarbeitenden',
          true,
          'Richtig. Die Summe vieler kleiner Schritte, nicht der eine große Wurf.'),
      _c('Einmalige, grundlegende Neugestaltung der Geschäftsprozesse', false,
          'Das ist Business Process Reengineering - der radikale Gegenentwurf zu Kaizen.'),
      _c('Verbesserung ausschließlich durch die Führungsebene', false,
          'Falsch. Kaizen lebt davon, dass Verbesserungsvorschläge von denen kommen, die die Arbeit täglich machen.'),
      _c('Ein Verfahren zur Fehlersuche im Quellcode', false,
          'Falsch. Kaizen ist eine Haltung zur Prozessverbesserung, kein Testverfahren.'),
    ],
    explanation:
        'Kaizen (japanisch: Veränderung zum Besseren) steht für den '
        'kontinuierlichen Verbesserungsprozess (KVP). Kernideen: kleine '
        'Schritte statt großer Sprünge, Beteiligung aller Mitarbeitenden, '
        'Standardisierung des Erreichten und Wiederholung.\n'
        'Der Zusammenhang zum PDCA-Zyklus ist direkt: PDCA ist das Werkzeug, '
        'mit dem jeder einzelne Kaizen-Schritt durchlaufen wird.\n'
        'Abgrenzung für die Prüfung: Kaizen = viele kleine Schritte, '
        'evolutionär. Reengineering = ein großer Schnitt, revolutionär.',
  ),
];
