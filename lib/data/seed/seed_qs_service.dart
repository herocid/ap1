import '../models/question.dart';
import 'builders.dart';

Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Bereich 05 (Qualitätssicherung) und Bereich 07 (Vertragsmanagement &
/// Service).
final List<Question> seedQsService = [
  // ============================================== 05.01 Qualitätsmanagement
  Question(
    id: 'qm-001',
    topicId: 'qualitaetsmanagement',
    subtopicId: 'qm-pdca',
    kind: QuestionKind.ordering,
    difficulty: 1,
    tags: ['pdca'],
    prompt: 'Bringe die Phasen des PDCA-Zyklus in die richtige Reihenfolge.',
    orderingHint: 'Beginne mit der Planung',
    orderedItems: const [
      'Plan: Ziel festlegen und Maßnahme planen',
      'Do: Maßnahme im Kleinen ausprobieren',
      'Check: Ergebnis mit dem Ziel vergleichen',
      'Act: bei Erfolg zum Standard machen, sonst nachbessern',
    ],
    explanation:
        'Der PDCA-Zyklus (auch Deming-Kreis) ist das Grundmuster jeder '
        'kontinuierlichen Verbesserung. Zwei Punkte werden gern falsch '
        'verstanden:\n'
        '- "Do" heißt ausprobieren im kleinen Rahmen, nicht flächendeckend '
        'ausrollen. Das Ausrollen passiert erst in "Act".\n'
        '- Der Zyklus endet nicht, sondern beginnt von vorn, deshalb Kreis '
        'und nicht Liste.',
  ),

  lueckentext(
    'qm-002',
    'qm-grundlagen',
    difficulty: 2,
    tags: ['qualitätsbegriff'],
    prompt: 'Ergänze die Aussagen zum Qualitätsbegriff.',
    text:
        'Qualität ist der {0}, in dem ein Produkt die festgelegten {1} '
        'erfüllt. Maßstab ist der {2}, nicht das Empfinden des '
        'Entwicklerteams. Feststellen lässt sich Qualität deshalb nur, wenn '
        'die Anforderungen {3} formuliert sind.',
    luecken: [
      wort(['Grad'], 'Qualität ist relativ, nicht absolut.'),
      wort(['Anforderungen'], 'Nicht die technisch bestmögliche Ausführung zählt.'),
      wort(['Kunde'], 'Seine Anforderungen sind der Maßstab.'),
      wort(['prüfbar'], '"Benutzerfreundlich" allein lässt sich nicht prüfen.'),
    ],
    wortbank: ['Preis', 'Fehler', 'Hersteller', 'allgemein'],
    explanation:
        'Qualität = Erfüllungsgrad der Anforderungen. Daraus folgt eine '
        'praktische Konsequenz: Ohne prüfbar formulierte Anforderungen kann '
        'man Qualität gar nicht feststellen. Deshalb hängen '
        'Anforderungsanalyse und Qualitätssicherung unmittelbar zusammen, '
        'und deshalb ist eine unprüfbare Anforderung wie "benutzerfreundlich" '
        'ein Qualitätsproblem, bevor die erste Zeile Code geschrieben ist. '
        'Ein Produkt, das mehr kann als gefordert, hat nicht mehr Qualität, '
        'sondern verschwendet Budget.',
  ),

  Question(
    id: 'qm-003',
    topicId: 'qualitaetsmanagement',
    subtopicId: 'qm-grundlagen',
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
        rationale: 'Ein bereits erstelltes Artefakt wird geprüft, also analytisch.',
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
        rationale: 'Prüfung des fertigen Produkts, also analytisch.',
      ),
    ],
    explanation:
        'Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler (Standards, '
        'Methoden, Werkzeuge, Schulung, Templates). ANALYTISCH = nachher, '
        'findet Fehler (Test, Review, Inspektion, Audit).\n'
        'Merksatz: Der Test findet den Fehler, der Standard verhindert ihn. '
        'Wirtschaftlich ist konstruktive QS fast immer überlegen (siehe '
        'Rule of Ten).',
  ),

  freitext(
    'qm-004',
    'qm-grundlagen',
    difficulty: 2,
    tags: ['qualitätsplanung'],
    scenario:
        'Ein Team startet ein Projekt und legt seine Qualitätsziele fest.',
    prompt: 'Nenne vier Festlegungen, die in die Qualitätsplanung gehören.',
    kriterien: [
      krit('Qualitätsmerkmale, die gemessen werden, mit ihren Zielwerten',
          stichwoerter: ['Qualitätsmerkmale', 'Zielwert', 'Kennzahl', 'Messgröße']),
      krit('Prüfmaßnahmen und ihre Zeitpunkte (Prüfplan)',
          stichwoerter: ['Prüfmaßnahmen', 'Prüfplan', 'Tests', 'Reviews', 'wann geprüft']),
      krit('Verantwortliche für die Qualitätssicherung',
          stichwoerter: ['Verantwortliche', 'Verantwortung', 'zuständig', 'wer']),
      krit('Abnahmekriterien bzw. Definition of Done',
          stichwoerter: ['Abnahmekriterien', 'Definition of Done', 'fertig']),
      krit('Standards, Methoden und Werkzeuge',
          stichwoerter: ['Standards', 'Methoden', 'Werkzeuge', 'Richtlinien']),
      krit('Dokumentation der Prüfergebnisse',
          stichwoerter: ['Dokumentation', 'Protokoll', 'Nachweis']),
    ],
    loesung:
        'Welche Qualitätsmerkmale mit welchem Zielwert gemessen werden, '
        'welche Prüfmaßnahmen wann stattfinden (Prüfplan), wer für die '
        'Qualitätssicherung verantwortlich ist und wann etwas als fertig gilt '
        '(Abnahmekriterien bzw. Definition of Done). Dazu: Standards und '
        'Werkzeuge, Dokumentation der Prüfergebnisse.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Qualitätsplanung '
        'beantwortet vier Fragen: Was wird gemessen? Welcher Zielwert gilt? '
        'Wann und wie wird geprüft? Wer ist verantwortlich?\n'
        'Nicht geplant werden eine Anzahl erwarteter Fehler oder der Code '
        'der Testfälle. Der häufigste Fehler in der Praxis ist, '
        'Qualitätsziele nur qualitativ zu formulieren ("hohe Performance"). '
        'Ohne Zahl ist das keine Planung, sondern ein Wunsch.',
    punkte: 4,
  ),

  // =========================================================== 05.02 Testen
  Question(
    id: 'te-001',
    topicId: 'testen',
    subtopicId: 'ts-stufen',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['teststufen'],
    prompt:
        'Bringe die Teststufen in die Reihenfolge, in der sie üblicherweise '
        'durchlaufen werden.',
    orderingHint: 'Vom kleinsten Prüfgegenstand zum größten',
    orderedItems: const [
      'Modultest (Unittest): einzelne Funktion oder Klasse',
      'Integrationstest: Zusammenspiel mehrerer Komponenten',
      'Systemtest: das komplette System in der Testumgebung',
      'Abnahmetest: das System beim Auftraggeber',
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
    subtopicId: 'ts-verfahren',
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
        rationale: 'Zweigabdeckung setzt Kenntnis des Codes voraus, also White-Box.',
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

  lueckentext(
    'te-003',
    'ts-protokoll',
    difficulty: 2,
    tags: ['testfall', 'testprotokoll'],
    prompt: 'Ergänze die Bestandteile eines vollständigen Testfalls.',
    text:
        'Ein Testfall braucht eine eindeutige {0}, damit sich ein Fehler '
        'später zuordnen lässt. Die {1} beschreibt den Ausgangszustand. '
        'Dazu kommen konkrete {2} und das {3}, an dem der Test gemessen '
        'wird. Nach der Durchführung wird das {4} eingetragen, zusammen '
        'mit dem Urteil bestanden oder nicht bestanden.',
    luecken: [
      wort(['Kennung'], 'Testfall-Nummer oder -Bezeichnung.'),
      wort(['Vorbedingung'], 'Ohne definierten Startzustand ist der Test nicht reproduzierbar.'),
      wort(['Eingabedaten'], '"Irgendeine gültige Eingabe" ist kein Testfall.'),
      wort(['Soll-Ergebnis'], 'Ohne erwartetes Ergebnis kann ein Test nicht fehlschlagen.'),
      wort(['Ist-Ergebnis'], 'Das tatsächliche Ergebnis der Durchführung.'),
    ],
    wortbank: ['Fehlerursache', 'Entwicklername', 'Behebungsdauer'],
    explanation:
        'Ein Testfall besteht aus: Kennung, Vorbedingung, Eingabe, erwartetes '
        'Ergebnis und nach der Durchführung zusätzlich dem tatsächlichen '
        'Ergebnis sowie dem Urteil bestanden/nicht bestanden. Erst das '
        'zusammen ergibt das Testprotokoll.\n'
        'Nicht hinein gehören der Name eines "Schuldigen" oder die Dauer der '
        'Fehlerbehebung. Der häufigste Fehler in Prüfungsaufgaben: das '
        'Soll-Ergebnis vergessen. Ein Test ohne Soll-Ergebnis kann nicht '
        'fehlschlagen und ist damit wertlos.',
  ),

  Question(
    id: 'te-004',
    topicId: 'testen',
    subtopicId: 'ts-verfahren',
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
          'Richtig. Der Code wird ohne Ausführung manuell nachvollzogen, ein klassisches Prüfungsthema.'),
      _c('Regressionstest', false,
          'Falsch. Ein Regressionstest prüft nach einer Änderung, ob bisher funktionierende Teile noch laufen.'),
      _c('Integrationstest', false,
          'Falsch. Der Integrationstest prüft das Zusammenspiel mehrerer Komponenten, nicht eine einzelne Anweisungsfolge.'),
      _c('Lasttest', false,
          'Falsch. Ein Lasttest prüft das Verhalten unter hoher Beanspruchung.'),
    ],
    explanation:
        'Der Schreibtischtest (auch Trockentest) ist '
        'ein statisches Verfahren: Der Code wird gelesen und nachvollzogen, '
        'nicht ausgeführt.\n'
        'Praktisch geht man mit einer Wertetabelle vor: eine Spalte je '
        'Variable, eine Zeile je Durchlauf. Genau diese Tabelle verlangt die '
        'AP1 häufig als Lösung. Wer sie sauber führt, findet den Fehler '
        'fast von selbst; wer im Kopf rechnet, verrechnet sich.',
  ),

  Question(
    id: 'te-005',
    topicId: 'testen',
    subtopicId: 'ts-stufen',
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
          'Der Abnahmetest findet am Ende beim Kunden statt. Dann ist der Schaden schon da.'),
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
    subtopicId: 'vt-arten',
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
        rationale: 'Typisch für den Werkvertrag: ohne Abnahme keine Fälligkeit.',
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
        'nicht. Maßgeblich ist, was tatsächlich geschuldet wird.',
  ),

  paare(
    've-002',
    'vt-urheber',
    difficulty: 2,
    tags: ['lizenzen'],
    prompt: 'Verbinde jedes Lizenzmodell mit seinem Kennzeichen.',
    paare: [
      paar('Einzelplatzlizenz', 'an ein Gerät oder einen Nutzer gebunden'),
      paar('Concurrent-User-Lizenz', 'begrenzt die gleichzeitigen Nutzer'),
      paar('Volumenlizenz', 'viele Lizenzen in einem Vertrag'),
      paar('Software-Abonnement (SaaS)', 'Nutzungsrecht nur für die Laufzeit'),
      paar('Freeware', 'kostenlos, Quellcode meist geschlossen'),
      paar('Copyleft-Lizenz (z. B. GPL)', 'Änderungen unter gleicher Lizenz weitergeben'),
    ],
    explanation:
        'Vier Begriffe sauber trennen:\n'
        '- Freeware: kostenlos, Quellcode geschlossen.\n'
        '- Open Source: Quellcode offen, oft mit Pflichten (Copyleft).\n'
        '- Proprietär: kostenpflichtig, Quellcode geschlossen.\n'
        '- SaaS/Abo: Nutzungsrecht auf Zeit, Betrieb beim Anbieter.\n'
        'Lizenzmodelle nach Zählweise: pro Gerät, pro benanntem Nutzer, '
        'pro gleichzeitigem Nutzer (concurrent), pro CPU/Core, '
        'nutzungsabhängig. Volumenlizenzen sind meist, aber nicht immer '
        'günstiger als der Einzelkauf.',
  ),

  Question(
    id: 've-003',
    topicId: 'vertraege',
    subtopicId: 'vt-urheber',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['urheberrecht'],
    scenario:
        'Eine Auszubildende entwickelt im Rahmen ihrer Aufgaben im Betrieb ein '
        'Skript, das dort produktiv eingesetzt wird.',
    prompt: 'Wie ist die urheberrechtliche Lage in Deutschland?',
    choices: [
      _c('Die Urheberin bleibt sie selbst, die Nutzungsrechte liegen aber beim Arbeitgeber.',
          true,
          'Richtig. Das Urheberrecht ist in Deutschland nicht übertragbar; übertragen werden nur Nutzungsrechte, bei Arbeitnehmern regelmäßig automatisch an den Arbeitgeber.'),
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
        'verkaufen noch verschenken, nur vererben.\n'
        'Was übertragen wird, sind NUTZUNGSRECHTE: einfach (mehrere dürfen '
        'nutzen) oder ausschließlich (nur einer). Bei Software, die in '
        'Erfüllung des Arbeitsvertrags entsteht, erhält der Arbeitgeber '
        'die ausschließlichen Nutzungsrechte.',
  ),

  freitext(
    've-004',
    'vt-arten',
    difficulty: 1,
    tags: ['vertragsbestandteile'],
    scenario:
        'Ein Unternehmen beauftragt ein Systemhaus mit der Betreuung seiner '
        'IT. Der Vertrag soll spätere Streitigkeiten vermeiden.',
    prompt:
        'Nenne fünf Punkte, die ein IT-Dienstleistungsvertrag mindestens '
        'regeln sollte.',
    kriterien: [
      krit('Leistungsbeschreibung bzw. Verweis auf das Pflichtenheft',
          stichwoerter: ['Leistungsbeschreibung', 'Leistung', 'Pflichtenheft', 'Umfang']),
      krit('Vergütung und Zahlungsbedingungen',
          stichwoerter: ['Vergütung', 'Preis', 'Zahlungsbedingungen', 'Zahlungsziel']),
      krit('Termine und Fristen',
          stichwoerter: ['Termine', 'Fristen', 'Liefertermin', 'Zeitplan']),
      krit('Gewährleistung und Haftung',
          stichwoerter: ['Gewährleistung', 'Haftung', 'Mängel']),
      krit('Datenschutz und Vertraulichkeit',
          stichwoerter: ['Datenschutz', 'Vertraulichkeit', 'Geheimhaltung', 'Auftragsverarbeitung']),
      krit('Mitwirkungspflichten des Auftraggebers',
          stichwoerter: ['Mitwirkung', 'Mitwirkungspflichten', 'Ansprechpartner']),
      krit('Abnahme der Leistung',
          stichwoerter: ['Abnahme', 'Abnahmekriterien', 'Abnahmetest']),
      krit('Laufzeit und Kündigung',
          stichwoerter: ['Laufzeit', 'Kündigung', 'Vertragsdauer']),
    ],
    loesung:
        'Vertragsparteien, Leistungsbeschreibung, Vergütung und '
        'Zahlungsbedingungen, Termine und Fristen, Mitwirkungspflichten des '
        'Auftraggebers, Abnahme, Gewährleistung und Haftung, Datenschutz und '
        'Vertraulichkeit, Laufzeit und Kündigung.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 5 Punkte. Nicht geregelt werden die '
        'Namen einzelner Entwickler, denn Personal wechselt.\n'
        'Die Mitwirkungspflichten werden am häufigsten vergessen und führen '
        'am häufigsten zu Streit: Wenn der Auftraggeber Testdaten oder '
        'Ansprechpartner nicht liefert, kann der Auftragnehmer den Termin '
        'nicht halten. Ohne Regelung steht dann Aussage gegen Aussage. '
        'Verarbeitet der Dienstleister personenbezogene Daten im Auftrag, '
        'ist ein Auftragsverarbeitungsvertrag Pflicht (Art. 28 DSGVO).',
    punkte: 5,
  ),

  // ======================================================= 07.02 Service/SLA
  paare(
    'sl-001',
    'sla-inhalte',
    difficulty: 2,
    tags: ['sla'],
    prompt: 'Verbinde jede Größe eines SLA mit ihrer Bedeutung.',
    paare: [
      paar('Servicezeit', 'wann der Service erbracht wird'),
      paar('Verfügbarkeit', 'Anteil der Servicezeit ohne Störung'),
      paar('Reaktionszeit', 'Zeit bis zur ersten Rückmeldung'),
      paar('Wiederherstellungszeit', 'Zeit bis die Störung behoben ist'),
      paar('Vertragsstrafe', 'Folge, wenn Werte verfehlt werden'),
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
        'dass das Problem nach einer Stunde gelöst ist. Ohne Folgen bei '
        'Nichteinhaltung bleibt ein SLA eine Absichtserklärung.',
  ),

  Question(
    id: 'sl-002',
    topicId: 'sla_service',
    subtopicId: 'sla-inhalte',
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
        'Merke die Größenordnungen, denn danach wird gern gefragt:\n'
        '99 % = rund 7,2 Stunden Ausfall im Monat\n'
        '99,5 % = rund 3,6 Stunden\n'
        '99,9 % = rund 43 Minuten\n'
        'Jede zusätzliche Neun teilt den erlaubten Ausfall durch zehn.',
  ),

  Question(
    id: 'sl-003',
    topicId: 'sla_service',
    subtopicId: 'sla-support',
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
          'Falsch. Ein ungelöstes Ticket wird nie geschlossen. Der Vorgang und seine Historie müssen erhalten bleiben.'),
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
        'behält einen Ansprechpartner. Das nennt sich '
        'Ownership-Prinzip.',
  ),

  // ============================================= 07.03 Leistungsstörungen
  freitext(
    'ls-001',
    'ls-verzug',
    difficulty: 2,
    tags: ['verzug'],
    scenario:
        'Ein Lieferant hat eine Serverlieferung für den 1. Oktober fest '
        'zugesagt. Am 10. Oktober ist nichts geliefert. Der Kunde hat bisher '
        'nicht gemahnt.',
    prompt:
        'Erläutere, ob sich der Lieferant im Lieferungsverzug befindet.',
    kriterien: [
      krit('Die Lieferung ist seit dem 1. Oktober fällig und nicht erfolgt',
          stichwoerter: ['fällig', 'Fälligkeit', 'nicht geliefert']),
      krit('Eine Mahnung ist nicht nötig, weil der Termin nach dem Kalender bestimmt ist',
          stichwoerter: ['Kalender', 'keine Mahnung', 'ohne Mahnung', 'fester Termin', 'entbehrlich']),
      krit('Der Lieferant hat die Verspätung zu vertreten - er ist also in Verzug',
          stichwoerter: ['vertreten', 'Verschulden', 'in Verzug']),
    ],
    loesung:
        'Ja. Die Lieferung war am 1. Oktober fällig und ist ausgeblieben. '
        'Weil der Termin nach dem Kalender bestimmt ist, tritt der Verzug '
        'ohne Mahnung ein. Das Verschulden des Lieferanten wird vermutet. Er '
        'ist seit dem 2. Oktober in Verzug.',
    explanation:
        'Je Aussage 1 Punkt. Verzug setzt voraus: fällige Leistung, '
        'Nichtleistung, Verschulden des Schuldners und grundsätzlich eine '
        'Mahnung.\n'
        'Die Mahnung entfällt unter anderem, wenn ein Termin nach dem '
        'Kalender bestimmt ist ("Lieferung am 1. Oktober") oder wenn der '
        'Schuldner die Leistung ernsthaft und endgültig verweigert. Drei '
        'Mahnungen sind ein Mythos aus der Praxis.\n'
        'Beim ZAHLUNGSverzug gilt zusätzlich: Spätestens 30 Tage nach '
        'Zugang einer Rechnung tritt Verzug auch ohne Mahnung ein, bei '
        'Verbrauchern nur, wenn darauf hingewiesen wurde.',
    punkte: 3,
  ),

  Question(
    id: 'ls-002',
    topicId: 'leistungsstoerungen',
    subtopicId: 'ls-maengel',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['mängelrechte'],
    scenario:
        'Eine Agentur hat für einen Kunden ein Buchungsmodul programmiert '
        '(Werkvertrag). Nach der Abnahme zeigt sich ein Fehler: Stornierungen '
        'werden nicht gespeichert.',
    prompt:
        'Was muss der Kunde grundsätzlich tun, bevor er den Fehler von einer '
        'anderen Firma beheben lässt, die Vergütung mindert oder zurücktritt?',
    choices: [
      _c('Der Agentur eine angemessene Frist zur Nacherfüllung setzen', true,
          'Die Nacherfüllung hat Vorrang. Erst wenn die Frist erfolglos '
          'verstreicht, stehen Selbstvornahme, Minderung, Rücktritt und '
          'Schadensersatz offen.'),
      _c('Nichts. Er kann sofort eine andere Firma beauftragen und der '
          'Agentur die Kosten in Rechnung stellen', false,
          'Ohne erfolglose Frist zur Nacherfüllung riskiert er, auf den '
          'Kosten der Selbstvornahme sitzen zu bleiben.'),
      _c('Erst Selbstvornahme versuchen, danach mindern, zuletzt '
          'Schadensersatz verlangen', false,
          'Nach gescheiterter Nacherfüllung gibt es keine feste Reihenfolge: '
          'Selbstvornahme, Minderung oder Rücktritt und Schadensersatz stehen '
          'nebeneinander, Schadensersatz lässt sich auch mit dem Rücktritt '
          'verbinden.'),
      _c('Die Agentur dreimal schriftlich mahnen', false,
          'Drei Mahnungen verlangt das Gesetz nicht. Entscheidend ist eine '
          'Frist zur Nacherfüllung.'),
    ],
    explanation:
        'Beim Werkvertrag hat die Nacherfüllung Vorrang (§ 634 BGB): Der '
        'Unternehmer darf den Mangel zuerst selbst beseitigen und wählt dabei '
        'zwischen Nachbesserung und Neuherstellung. Erst nach erfolglosem '
        'Fristablauf kann der Besteller den Mangel selbst beseitigen lassen '
        'und Kostenersatz verlangen, die Vergütung mindern oder zurücktreten '
        '- und zusätzlich Schadensersatz fordern, wenn der Unternehmer den '
        'Mangel zu vertreten hat. Deshalb gehört in jede Mangelanzeige eine '
        'konkrete Frist.',
  ),

  markieren(
    'ls-003',
    'ls-abnahme',
    difficulty: 2,
    tags: ['abnahmeprotokoll'],
    scenario:
        'Bei der Abnahme einer Lagerverwaltungssoftware zeigt sich, dass der '
        'Etikettendruck fehlerhaft ist. Ein Auszubildender hat das '
        'Abnahmeprotokoll entworfen.',
    prompt:
        'Markiere alle Einträge, die so nicht in das Protokoll gehören oder '
        'unvollständig sind.',
    zeilen: [
      nein('Abnahme am 14. Juni im Lager des Auftraggebers; anwesend: die Projektleiter beider Seiten',
          'Datum, Ort und Beteiligte gehören hinein.'),
      nein('Gegenstand: Lagerverwaltungssoftware gemäß Pflichtenheft Version 2.1',
          'Abgenommen wird gegen ein definiertes Soll, und der Verweis stellt das her.'),
      ja('Mangel: Etikettendruck fehlerhaft. Wird bei Gelegenheit behoben.',
          'Es fehlt eine Frist zur Beseitigung.'),
      ja('Erklärung: Die Abnahme erfolgt ohne Vorbehalt.',
          'Bei einem bekannten Mangel muss der Vorbehalt erklärt werden, sonst gehen Nacherfüllung, Selbstvornahme, Rücktritt und Minderung dafür verloren (§ 640 Abs. 3 BGB).'),
      ja('Interne Kalkulation des Auftragnehmers: 310 Stunden zu 62 €',
          'Die Kalkulation ist ein Geschäftsgeheimnis und hat im Protokoll nichts zu suchen.'),
      nein('Geprüft wurden die 24 Testfälle des Abnahmetestplans, 23 davon bestanden.',
          'Das Ergebnis des Abnahmetests gehört ins Protokoll.'),
      ja('Unterschrift: nur Auftragnehmer',
          'Erst die Unterschriften beider Vertragsparteien machen das Protokoll zum Nachweis.'),
    ],
    explanation:
        'In das Protokoll gehören: Datum, Ort, Beteiligte, Gegenstand mit '
        'Verweis auf das Pflichtenheft, Mängel mit Fristen, die Erklärung '
        '(abgenommen, unter Vorbehalt, verweigert) und die Unterschriften '
        'beider Seiten.\n'
        'An der Abnahme hängen vier Rechtsfolgen: Fälligkeit der '
        'Vergütung, Gefahrübergang, Beginn der Verjährungsfrist für '
        'Mängelansprüche und die Umkehr der Beweislast. Wer bekannte Mängel '
        'nicht vorbehält, verliert die meisten Rechte darauf. Nur ein '
        'Anspruch auf Schadensersatz bleibt bestehen (§ 640 Abs. 3 BGB).',
  ),

  // ============================================== 07.04 Change Management
  Question(
    id: 'cm-001',
    topicId: 'change_management',
    subtopicId: 'cm-lewin',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['lewin'],
    prompt: 'Bringe die drei Phasen des Lewin-Modells in die richtige Reihenfolge.',
    orderingHint: 'Von der Vorbereitung zur Verankerung',
    orderedItems: const [
      'Unfreeze (Auftauen): Veränderungsbedarf verdeutlichen, Widerstände ansprechen',
      'Change (Verändern): neue Abläufe einführen und begleiten',
      'Refreeze (Einfrieren): den neuen Zustand stabilisieren und zum Standard machen',
    ],
    explanation:
        'Lewins Modell erklärt, warum Veränderungen scheitern: Meist wird '
        'die erste oder die letzte Phase übersprungen.\n'
        '- Ohne "Unfreeze" fehlt die Einsicht, dass sich etwas ändern muss; '
        'die Betroffenen halten am Alten fest.\n'
        '- Ohne "Refreeze" fällt die Organisation nach einigen Wochen in '
        'alte Gewohnheiten zurück, weil der neue Zustand nie verankert '
        'wurde.\n'
        'In der Change-Phase sinkt die Leistung typischerweise vorübergehend '
        'ab. Das ist normal und kein Zeichen des Scheiterns.',
  ),

  freitext(
    'cm-002',
    'cm-widerstand',
    difficulty: 2,
    tags: ['widerstand'],
    scenario:
        'Bei der Einführung eines neuen Ticketsystems weigern sich mehrere '
        'erfahrene Mitarbeitende, das System zu nutzen.',
    prompt: 'Nenne vier Maßnahmen, die geeignet sind, den Widerstand abzubauen.',
    kriterien: [
      krit('Betroffene frühzeitig einbeziehen und ihre Erfahrung in die Gestaltung einfließen lassen',
          stichwoerter: ['einbeziehen', 'beteiligen', 'mitgestalten', 'Erfahrung nutzen']),
      krit('Den Nutzen für die tägliche Arbeit konkret erklären',
          stichwoerter: ['Nutzen', 'erklären', 'informieren', 'Vorteile']),
      krit('Schulungen anbieten',
          stichwoerter: ['Schulung', 'schulen', 'Training']),
      krit('In der Umstellungsphase begleiten und Ansprechpartner benennen',
          stichwoerter: ['begleiten', 'Ansprechpartner', 'Unterstützung', 'Support']),
      krit('Erfahrene Mitarbeitende als Multiplikatoren bzw. Key-User gewinnen',
          stichwoerter: ['Multiplikator', 'Key-User', 'Vorbild']),
      krit('Erste Erfolge sichtbar machen',
          stichwoerter: ['Erfolge', 'sichtbar', 'Kennzahlen']),
    ],
    loesung:
        'Die Betroffenen früh einbeziehen, den Nutzen für die tägliche '
        'Arbeit erklären, schulen, in der Umstellungsphase begleiten und '
        'erfahrene Mitarbeitende als Multiplikatoren gewinnen. Später: '
        'Erfolge sichtbar machen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Widerstand ist kein Defekt '
        'der Mitarbeitenden, sondern eine Information: Er zeigt, dass Sinn, '
        'Können oder Beteiligung fehlen.\n'
        'Die drei typischen Ursachen und ihre Gegenmittel:\n'
        '- "Ich verstehe es nicht" -> informieren, Nutzen erklären.\n'
        '- "Ich kann es nicht" -> schulen, begleiten.\n'
        '- "Ich will es nicht" -> beteiligen, Bedenken ernst nehmen.\n'
        'Anordnung und Sanktion sind das letzte Mittel, nicht das erste, denn '
        'Druck erzeugt Scheinanpassung. Auch das alte System ohne '
        'Vorbereitung abzuschalten verfestigt die Ablehnung.',
    punkte: 4,
  ),

  lueckentext(
    'cm-003',
    'cm-kaizen',
    difficulty: 2,
    tags: ['kaizen'],
    prompt: 'Ergänze die Aussagen zu Kaizen und KVP.',
    text:
        'Kaizen bedeutet „Veränderung zum {0}“. Verbessert wird in vielen '
        '{1} Schritten, getragen von {2} Mitarbeitenden. Jeder einzelne '
        'Schritt durchläuft den {3}. Das Gegenstück, die einmalige radikale '
        'Neugestaltung eines Prozesses, heißt {4}.',
    luecken: [
      wort(['Besseren']),
      wort(['kleinen'], 'Die Summe vieler kleiner Schritte, nicht der eine große Wurf.'),
      wort(['allen'], 'Vorschläge kommen von denen, die die Arbeit täglich machen.'),
      wort(['PDCA-Zyklus'], 'Plan, Do, Check, Act.'),
      wort(['Reengineering'], 'Business Process Reengineering: revolutionär statt evolutionär.'),
    ],
    wortbank: ['großen', 'Führungskräften', 'Netzplan', 'Schlechteren'],
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
