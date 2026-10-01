import '../builders.dart';

/// Fallaufgaben (je 25 Punkte) zu Bereich 04, Teil 1 für die Prüfungssimulation.
///
/// Aufbau wie die Aufgabe „Entwicklung“ der echten AP1: Schreibtischtest,
/// UML-Diagramm, Code erklären oder korrigieren und OOP-/Anforderungsbegriffe
/// als Freitext. Keine Auswahlaufgaben.
final List<ExamCase> casesA04Entwicklung = [
  // ------------------------------------------------------------- Systemhaus
  fall(
    'f-a04e-systemhaus',
    firma: 'systemhaus',
    bereich: 'a04',
    titel: 'Supporteinsätze für die Kanzlei abrechnen',
    situation:
        'Die Kessler & Brandt IT-Systemhaus GmbH rechnet ihre Supporteinsätze bei der Steuerkanzlei Albers & Partner bisher von Hand in einer Tabellenkalkulation ab. Künftig soll ein kleines, objektorientiert entwickeltes Programm die Einsätze erfassen und die Monatsrechnung vorbereiten. Du arbeitest im Entwicklungsteam mit und prüfst Entwürfe und Quelltext.',
    teile: [
      freitext(
        'f-a04e-systemhaus-a',
        'af-arten',
        scenario:
            'Notiz aus dem Gespräch mit der Abrechnung: „Die Techniker erfassen jeden Einsatz mit Datum, Dauer und Ort. Das Programm erstellt am Monatsende je Kunde eine Rechnung als PDF. Die Monatsrechnung muss in höchstens 10 Sekunden erzeugt sein. Die Daten dürfen nur auf unseren eigenen Servern liegen.“',
        prompt:
            'Nenne aus der Notiz zwei funktionale und zwei nicht-funktionale Anforderungen. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Funktional: Einsätze mit Datum, Dauer und Ort erfassen',
            stichwoerter: [
              'erfassen',
              'einsatz erfassen',
              'einsätze erfassen',
              'eingeben',
            ],
          ),
          krit(
            'Funktional: Monatsrechnung je Kunde als PDF erstellen',
            stichwoerter: [
              'rechnung erstellen',
              'pdf',
              'monatsrechnung',
              'rechnung erzeugen',
            ],
          ),
          krit(
            'Nicht-funktional: Rechnung in höchstens 10 Sekunden erzeugt (Leistung)',
            stichwoerter: [
              '10 sekunden',
              'leistung',
              'performance',
              'antwortzeit',
              'höchstens 10',
            ],
          ),
          krit(
            'Nicht-funktional: Daten nur auf eigenen Servern (Randbedingung)',
            stichwoerter: [
              'eigenen servern',
              'eigene server',
              'speicherort',
              'randbedingung',
              'datenschutz',
            ],
          ),
        ],
        loesung:
            'Funktional: Einsätze mit Datum, Dauer und Ort erfassen; Monatsrechnung je Kunde als PDF erstellen. Nicht-funktional: Rechnung in höchstens 10 Sekunden erzeugen; Daten nur auf eigenen Servern speichern.',
        explanation:
            'Je Nennung 1 Punkt. Funktional ist, was das Programm tut (erfassen, Rechnung erstellen). Nicht-funktional ist, wie gut oder unter welchen Bedingungen es arbeitet (Zeit, Speicherort).',
      ),
      lueckentext(
        'f-a04e-systemhaus-b',
        'u-klassen',
        scenario:
            'Ein Einsatz hat ein Datum (als Text), eine Dauer in ganzen Minuten, die Angabe, ob er vor Ort stattfand, und einen Stundensatz mit Nachkommastellen. Die Attribute sind von außen nicht direkt zugreifbar. Die Methode berechneKosten ist bereits eingetragen.',
        prompt: 'Ergänze das UML-Klassendiagramm. (5 P.)',
        mono: true,
        text:
            '{0}\n----------------------------\n- datum: String\n{1} minuten: {2}\n- vorOrt: {3}\n- stundensatz: {4}\n----------------------------\n+ berechneKosten(): double',
        luecken: [
          wort(['Einsatz'], 'Klassenname im Singular.'),
          wahl('-', ['+', '#'], 'Nicht direkt zugreifbar: private.'),
          wahl('int', ['double', 'String', 'boolean'], 'Ganze Minuten.'),
          wahl('boolean', ['int', 'String', 'char'], 'Ja oder nein.'),
          wahl('double', ['int', 'String', 'boolean'], 'Kommazahl.'),
        ],
        explanation:
            'Der Klassenname Einsatz steht oben. Attribute haben die Form „Sichtbarkeit Name: Typ“. Nicht zugreifbar von außen heißt private (-). Ganze Minuten: int, vor Ort ja/nein: boolean, Stundensatz mit Komma: double.',
        punkte: 5,
      ),
      tabelle(
        'f-a04e-systemhaus-c',
        'pl-schreibtischtest',
        scenario:
            'Die Monatsabrechnung wird mit drei Einsätzen getestet. Der Stundensatz beträgt 90 €, für Einsätze vor Ort kommt eine Anfahrtspauschale von 40 € hinzu. Liegt die Summe über 500 €, gibt es 10 % Rabatt.',
        code: '''minuten ← [120, 60, 100]
vorOrt ← [wahr, falsch, wahr]
satz ← 90
anfahrt ← 40
summe ← 0
FÜR i VON 0 BIS 2
  kosten ← minuten[i] / 60 * satz
  WENN vorOrt[i] DANN
    kosten ← kosten + anfahrt
  ENDE WENN
  summe ← summe + kosten
ENDE FÜR
WENN summe > 500 DANN
  summe ← summe * 0.9
ENDE WENN
AUSGABE summe''',
        prompt:
            'Führe einen Schreibtischtest durch: Berechne die Kosten je Einsatz, die Summe nach der Schleife und die Ausgabe (in €). (9 P.)',
        zeilen: [
          ['Schritt', 'Wert'],
          ['kosten für i = 0', zahl(220, toleranz: 0.005)],
          ['kosten für i = 1', zahl(90, toleranz: 0.005)],
          ['kosten für i = 2', zahl(190, toleranz: 0.005)],
          ['summe nach der Schleife', zahl(500, toleranz: 0.005)],
          ['Ausgabe', zahl(500, toleranz: 0.005)],
        ],
        explanation:
            'i = 0: 120 / 60 × 90 = 180, plus 40 Anfahrt = 220. i = 1: 60 / 60 × 90 = 90, nicht vor Ort. i = 2: 100 / 60 × 90 = 150, plus 40 = 190. Summe: 220 + 90 + 190 = 500. 500 > 500 ist falsch, also kein Rabatt, Ausgabe 500.',
        punkte: 9,
        difficulty: 3,
      ),
      markieren(
        'f-a04e-systemhaus-d',
        'pl-pseudocode',
        scenario:
            'Eine weitere Routine soll die durchschnittliche Dauer aller n Einsätze berechnen. Für die Dauern [120, 60, 100] gibt sie 33,33 statt 93,33 aus.',
        prompt: 'Markiere die fehlerhafte Zeile. (2 P.)',
        mono: true,
        zeilen: [
          nein('summe ← 0', 'Der Startwert einer Summe ist richtig 0.'),
          nein('FÜR i VON 0 BIS n - 1', 'Alle n Einsätze werden durchlaufen.'),
          ja(
            '  summe ← minuten[i]',
            'Die Summe wird überschrieben statt erhöht. Am Ende steht nur der letzte Wert darin.',
          ),
          nein('ENDE FÜR', 'Schließt die Schleife.'),
          nein(
            'schnitt ← summe / n',
            'Geteilt wird richtig nach der Schleife.',
          ),
          nein('AUSGABE schnitt', 'Die Ausgabe ist in Ordnung.'),
        ],
        explanation:
            'In der Schleife wird summe jedes Mal mit minuten[i] überschrieben. Nach dem letzten Durchlauf steht dort nur 100, also 100 / 3 = 33,33. Die Dauer muss zur bisherigen Summe addiert werden.',
        punkte: 2,
      ),
      lueckentext(
        'f-a04e-systemhaus-e',
        'pl-pseudocode',
        scenario:
            'Die fehlerhafte Zeile „summe ← minuten[i]“ der Durchschnittsberechnung soll korrigiert werden. Testdaten: [120, 60, 100].',
        prompt:
            'Korrigiere die Zeile und gib die Ausgabe des korrigierten Programms an, gerundet auf zwei Nachkommastellen. (2 P.)',
        mono: true,
        text: 'summe ← {0}\n\nAusgabe nach der Korrektur: {1}',
        luecken: [
          wahl(
            'summe + minuten[i]',
            ['summe * minuten[i]', 'minuten[i] + 1', 'summe + i'],
            'Der neue Wert wird zur bisherigen Summe addiert.',
          ),
          zahl(
            93.33,
            toleranz: 0.01,
            rationale: '(120 + 60 + 100) / 3 = 280 / 3 = 93,33.',
          ),
        ],
        explanation:
            'Korrekt ist summe ← summe + minuten[i]. Dann ergibt sich 120 + 60 + 100 = 280 und der Durchschnitt 280 / 3 = 93,33 Minuten.',
        punkte: 2,
      ),
      freitext(
        'f-a04e-systemhaus-f',
        'oo-kapselung',
        scenario:
            'Im Entwurf sind alle Attribute der Klasse Einsatz private. Ein Kollege möchte sie public machen, „damit man nicht für alles eine Methode schreiben muss“.',
        prompt:
            'Erläutere, warum die Attribute private bleiben sollten und wie andere Klassen trotzdem an die Werte kommen. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Schutz: Die Werte können von außen nicht unkontrolliert oder ungültig verändert werden',
            punkte: 2,
            stichwoerter: [
              'schutz',
              'geschützt',
              'ungültige werte',
              'unkontrolliert',
              'kapselung',
            ],
          ),
          krit(
            'Zugriff über öffentliche Methoden (Getter und Setter)',
            stichwoerter: [
              'getter',
              'setter',
              'öffentliche methoden',
              'public methoden',
            ],
          ),
          krit(
            'Der Setter kann Werte prüfen, z. B. keine negativen Minuten',
            stichwoerter: [
              'prüfen',
              'prüfung',
              'negative',
              'validieren',
              'plausibilität',
            ],
          ),
        ],
        loesung:
            'Private Attribute lassen sich von anderen Klassen nicht direkt ändern. So kann niemand ungültige Werte wie negative Minuten eintragen (Kapselung). Andere Klassen lesen und ändern die Werte über öffentliche Methoden (Getter und Setter), wobei der Setter den neuen Wert prüfen kann.',
        explanation:
            '2 Punkte für den Schutz vor unkontrollierten Änderungen, 1 Punkt für den Zugriff über Getter/Setter oder die Prüfung im Setter, höchstens 3.',
      ),
    ],
  ),

  // ------------------------------------------------------------------ Handel
  fall(
    'f-a04e-handel',
    firma: 'handel',
    bereich: 'a04',
    titel: 'Filialauswertung für die neue Filiale vorbereiten',
    situation:
        'Zur Eröffnung der Filiale in Göttingen erweitert die IT-Abteilung der Grünwerk Gartenbedarf GmbH ihr Auswertungsprogramm für Filialumsätze und Lagerbestände. Ein Teil der Dokumentation stammt von einem englischsprachigen Dienstleister. Du sollst Abläufe modellieren sowie Pseudocode prüfen und korrigieren.',
    teile: [
      freitext(
        'f-a04e-handel-a',
        'af-arten',
        scenario: 'Auszug aus der Dokumentation des Dienstleisters.',
        code: '''The reporting tool must show the daily
revenue of each branch. Branch managers
can export the report as a spreadsheet.
Every report has to be available within
five seconds. The tool must run in all
common web browsers.''',
        prompt:
            'Nenne auf Deutsch drei Anforderungen aus dem Text und gib jeweils an, ob sie funktional oder nicht-funktional ist. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Funktional: Tagesumsatz jeder Filiale anzeigen',
            stichwoerter: [
              'tagesumsatz',
              'umsatz anzeigen',
              'täglichen umsatz',
              'umsatz jeder filiale',
            ],
          ),
          krit(
            'Funktional: Bericht als Tabellenkalkulation exportieren',
            stichwoerter: [
              'exportieren',
              'export',
              'tabellenkalkulation',
              'tabelle exportieren',
            ],
          ),
          krit(
            'Nicht-funktional: Bericht innerhalb von fünf Sekunden verfügbar',
            stichwoerter: [
              'fünf sekunden',
              '5 sekunden',
              'antwortzeit',
              'leistung',
            ],
          ),
          krit(
            'Nicht-funktional: läuft in allen gängigen Webbrowsern',
            stichwoerter: [
              'browser',
              'webbrowser',
              'browsern',
              'übertragbarkeit',
            ],
          ),
        ],
        loesung:
            'Funktional: Das Tool zeigt den Tagesumsatz jeder Filiale; Filialleitungen können den Bericht als Tabellenkalkulation exportieren. Nicht-funktional: Jeder Bericht steht innerhalb von fünf Sekunden bereit; das Tool läuft in allen gängigen Webbrowsern.',
        explanation:
            'Je Anforderung mit richtiger Einordnung 1 Punkt, höchstens 3. „Show“ und „export“ sind Funktionen, „within five seconds“ und „all common web browsers“ beschreiben Qualität und Randbedingungen.',
      ),
      reihenfolge(
        'f-a04e-handel-b',
        'u-aktivitaet',
        scenario:
            'Ablauf einer Nachbestellung: Das System ermittelt den Lagerbestand eines Artikels. Liegt er unter dem Mindestbestand, wird eine Bestellung erzeugt und an den Lieferanten gesendet. In jedem Fall wird der Vorgang anschließend protokolliert.',
        prompt:
            'Erstelle das Aktivitätsdiagramm für den Fall, dass nachbestellt wird: Bringe die Elemente in die richtige Reihenfolge. (3 P.)',
        items: [
          'Startknoten',
          'Lagerbestand ermitteln',
          'Entscheidung, Kante [unter Mindestbestand]',
          'Bestellung erzeugen',
          'Bestellung senden',
          'Zusammenführung',
          'Vorgang protokollieren',
          'Endknoten',
        ],
        hint: 'Vom Startknoten bis zum Endknoten',
        explanation:
            'Nach dem Start wird der Bestand ermittelt. Die Entscheidung führt über die Kante [unter Mindestbestand] zu „Bestellung erzeugen“ und „Bestellung senden“. Die Zusammenführung vereint beide alternativen Wege vor „Vorgang protokollieren“, danach folgt der Endknoten.',
        punkte: 3,
      ),
      lueckentext(
        'f-a04e-handel-c',
        'u-aktivitaet',
        scenario:
            'Der Ablauf wird erweitert: Nachbestellt wird, wenn der Bestand kleiner als 20 Stück ist. Nach „Bestellung senden“ sollen „Einkauf informieren“ und „Liefertermin vormerken“ gleichzeitig ablaufen.',
        prompt:
            'Ergänze die Beschreibung des Aktivitätsdiagramms mit den passenden Begriffen. (4 P.)',
        text:
            'An der Kante zu „Bestellung erzeugen“ steht die Bedingung {0}, an der anderen Kante {1}. Die beiden gleichzeitigen Aktionen beginnen an einer {2} und enden an einer {3}.',
        luecken: [
          wort(['[Bestand < 20]'], '„Kleiner als 20“ schließt 20 nicht ein.'),
          wort(['[Bestand >= 20]'], 'Das lückenlose Gegenstück.'),
          wort(['Gabelung'], 'Balken, der parallele Wege startet (Teilung).'),
          wort([
            'Vereinigung',
          ], 'Balken, der auf beide Wege wartet (Synchronisation).'),
        ],
        wortbank: ['[Bestand <= 20]', '[Bestand > 20]', 'Zusammenführung'],
        explanation:
            '„Kleiner als 20“ ist [Bestand < 20], das Gegenstück [Bestand >= 20]. So ist auch der Wert 20 abgedeckt. Gleichzeitige Aktionen starten an einer Gabelung und enden an einer Vereinigung. Eine Zusammenführung (Raute) vereint dagegen alternative Wege.',
        punkte: 4,
      ),
      freitext(
        'f-a04e-handel-d',
        'pl-pseudocode',
        scenario:
            'Der Dienstleister liefert diesen Pseudocode zur Auswertung der Filialumsätze.',
        code: '''target ← 20000
count ← 0
gap ← 0
for each b in branches
  if b.revenue < target then
    print b.name
    count ← count + 1
    gap ← gap + (target - b.revenue)
  end if
end for
print count, gap''',
        prompt:
            'Erläutere auf Deutsch, was die Zeilen „for each b in branches“, „if b.revenue < target then“ und „print b.name“ bewirken. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'for each: Schleife über alle Filialen der Liste',
            stichwoerter: [
              'schleife',
              'alle filialen',
              'jede filiale',
              'durchläuft',
              'nacheinander',
            ],
          ),
          krit(
            'if: prüft, ob der Umsatz der Filiale unter dem Zielwert liegt',
            stichwoerter: [
              'kleiner als',
              'unter dem ziel',
              'vergleich',
              'prüft',
              'weniger als',
            ],
          ),
          krit(
            'print: gibt den Namen der Filiale aus',
            stichwoerter: [
              'gibt aus',
              'ausgabe',
              'ausgegeben',
              'name der filiale',
              'anzeigen',
            ],
          ),
        ],
        loesung:
            'Die Schleife durchläuft alle Filialen der Liste. Die Verzweigung prüft, ob der Umsatz der Filiale kleiner als der Zielwert ist. Nur dann wird der Name der Filiale ausgegeben.',
        explanation:
            'Je Zeile 1 Punkt. Der Code gibt alle Filialen aus, die ihr Umsatzziel verfehlt haben, zählt sie und summiert die fehlenden Beträge.',
      ),
      tabelle(
        'f-a04e-handel-e',
        'pl-schreibtischtest',
        scenario:
            'Der Pseudocode zur Filialauswertung wird mit den Umsätzen aus der Tabelle getestet.',
        code: '''target ← 20000
count ← 0
gap ← 0
for each b in branches
  if b.revenue < target then
    print b.name
    count ← count + 1
    gap ← gap + (target - b.revenue)
  end if
end for
print count, gap''',
        prompt:
            'Führe einen Schreibtischtest durch: Trage die Werte von count und gap nach jeder Filiale ein. (6 P.)',
        zeilen: [
          ['Filiale', 'revenue', 'count', 'gap'],
          ['Kassel', '24500', '0', '0'],
          ['Fulda', '20000', zahl(0), zahl(0)],
          ['Marburg', '18200', zahl(1), zahl(1800)],
          ['Göttingen', '16500', zahl(2), zahl(5300)],
        ],
        explanation:
            'Kassel: 24500 < 20000 ist falsch. Fulda: 20000 < 20000 ist falsch. Der Grenzwert zählt bei < nicht. Marburg: wahr, count = 1, gap = 20000 - 18200 = 1800. Göttingen: wahr, count = 2, gap = 1800 + 3500 = 5300. Ausgegeben werden Marburg und Göttingen, dann 2 und 5300.',
        punkte: 6,
      ),
      freitext(
        'f-a04e-handel-f',
        'pl-pseudocode',
        scenario:
            'Ein zweiter Algorithmus soll zählen, wie viele Artikel unter dem Mindestbestand liegen. Für bestand = [3, 9, 2, 1] und mindest = 5 gibt er 1 statt 3 aus.',
        code: '''anzahl ← 0
FÜR i VON 0 BIS n - 1
  WENN bestand[i] < mindest DANN
    anzahl ← 1
  ENDE WENN
ENDE FÜR
AUSGABE anzahl''',
        prompt: 'Erläutere den Fehler im Pseudocode. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Fundstelle: Die Zeile „anzahl ← 1“ im Dann-Zweig ist falsch',
            stichwoerter: [
              'anzahl ← 1',
              'anzahl = 1',
              'zuweisung',
              'dann zweig',
              'zeile 4',
            ],
          ),
          krit(
            'Fehler: Der Zähler wird auf 1 gesetzt statt um 1 erhöht',
            stichwoerter: [
              'gesetzt',
              'überschrieben',
              'nicht erhöht',
              'statt erhöht',
              'hochgezählt',
            ],
          ),
          krit(
            'Folge: Das Ergebnis ist höchstens 1, egal wie viele Artikel betroffen sind',
            stichwoerter: [
              'höchstens 1',
              'immer 1',
              'maximal 1',
              'nie mehr als 1',
            ],
          ),
        ],
        loesung:
            'Im Dann-Zweig wird anzahl bei jedem Treffer auf 1 gesetzt, statt um 1 erhöht zu werden. Dadurch ist das Ergebnis höchstens 1, auch wenn wie hier drei Artikel unter dem Mindestbestand liegen.',
        explanation:
            'Je 1 Punkt für die Fundstelle, die Beschreibung des Fehlers (setzen statt erhöhen) und die Auswirkung (Ergebnis höchstens 1).',
      ),
      lueckentext(
        'f-a04e-handel-g',
        'pl-pseudocode',
        scenario:
            'Die fehlerhafte Zeile „anzahl ← 1“ soll korrigiert werden. Testdaten: bestand = [3, 9, 2, 1], mindest = 5.',
        prompt:
            'Korrigiere die Zeile und gib die Ausgaben vor und nach der Korrektur an. (3 P.)',
        mono: true,
        text: 'anzahl ← {0}\n\nAusgabe vorher: {1}\nAusgabe nachher: {2}',
        luecken: [
          wahl('anzahl + 1', [
            'anzahl * 1',
            'bestand[i] + 1',
            'i + 1',
          ], 'Der Zähler wächst bei jedem Treffer um 1.'),
          zahl(1, rationale: 'Der Zähler wird nur auf 1 gesetzt.'),
          zahl(3, rationale: '3, 2 und 1 liegen unter 5.'),
        ],
        explanation:
            'Korrekt ist anzahl ← anzahl + 1. Unter dem Mindestbestand 5 liegen die Bestände 3, 2 und 1, aber die 9 nicht. Der fehlerhafte Code gibt 1 aus, der korrigierte 3.',
        punkte: 3,
      ),
    ],
  ),

  // ----------------------------------------------------------------- Agentur
  fall(
    'f-a04e-agentur',
    firma: 'agentur',
    bereich: 'a04',
    titel: 'Ticketsystem: Kennzahlen und Einstufung prüfen',
    situation:
        'Die Pixelhafen Medien GmbH führt ein neues Ticketsystem für Kundenanfragen ein. Zwei Funktionen hat das Entwicklungsteam selbst geschrieben: eine Monatsauswertung und die Einstufung eingehender Tickets. Vor der Freigabe sollst du beide mit einem Schreibtischtest prüfen und den Klassenentwurf vervollständigen.',
    teile: [
      tabelle(
        'f-a04e-agentur-a',
        'pl-schreibtischtest',
        scenario:
            'Die Python-Funktion berechnet drei Kennzahlen aus der Zahl aller Tickets (ges), der gelösten Tickets (ok), den Bearbeitungsstunden (std) und den eskalierten Tickets (esk). Aufruf: kpi(240, 198, 544.5, 21)',
        code: '''def kpi(ges, ok, std, esk):
    quote = ok / ges * 100
    zeit = std / ok
    anteil = esk / ges * 100
    return quote, zeit, anteil''',
        prompt:
            'Berechne die drei Rückgabewerte auf zwei Nachkommastellen. (6 P.)',
        zeilen: [
          ['Rückgabewert', 'Wert'],
          ['quote', zahl(82.5, toleranz: 0.005)],
          ['zeit', zahl(2.75, toleranz: 0.005)],
          ['anteil', zahl(8.75, toleranz: 0.005)],
        ],
        explanation:
            'quote = 198 / 240 × 100 = 82,50 (Lösungsquote in Prozent). zeit = 544,5 / 198 = 2,75 (Stunden je gelöstem Ticket). anteil = 21 / 240 × 100 = 8,75 (Anteil eskalierter Tickets in Prozent). Je Wert 2 Punkte.',
        punkte: 6,
      ),
      tabelle(
        'f-a04e-agentur-b',
        'pl-schreibtischtest',
        scenario:
            'Die Funktion stuft ein Ticket nach seinem Alter in Stunden (std), dem Kundentyp (premium) und der Zahl offener Tickets im Team (offen) ein.',
        code: '''FUNKTION bewerte(std, premium, offen)
  WENN std > 48 DANN
    RÜCKGABE "eskalieren"
  SONST
    WENN premium DANN
      WENN std > 24 DANN
        RÜCKGABE "heute lösen"
      SONST
        RÜCKGABE "bevorzugt"
      ENDE WENN
    SONST
      WENN offen >= 10 DANN
        RÜCKGABE "später"
      SONST
        RÜCKGABE "normal"
      ENDE WENN
    ENDE WENN
  ENDE WENN
ENDE FUNKTION''',
        prompt: 'Gib für jeden Aufruf den Rückgabewert an. (6 P.)',
        zeilen: [
          ['Aufruf', 'Rückgabe'],
          [
            'bewerte(48, wahr, 3)',
            wahl('heute lösen', [
              'eskalieren',
              'bevorzugt',
              'später',
              'normal',
            ]),
          ],
          [
            'bewerte(24, falsch, 10)',
            wahl('später', [
              'eskalieren',
              'heute lösen',
              'bevorzugt',
              'normal',
            ]),
          ],
          [
            'bewerte(24, wahr, 12)',
            wahl('bevorzugt', [
              'eskalieren',
              'heute lösen',
              'später',
              'normal',
            ]),
          ],
        ],
        explanation:
            'bewerte(48, wahr, 3): 48 > 48 ist falsch, premium wahr, 48 > 24 wahr: „heute lösen“. bewerte(24, falsch, 10): nicht premium, 10 >= 10 wahr: „später“. bewerte(24, wahr, 12): premium, 24 > 24 ist falsch: „bevorzugt“. Offen wird hier nicht geprüft.',
        punkte: 6,
        difficulty: 3,
      ),
      lueckentext(
        'f-a04e-agentur-c',
        'u-klassen',
        scenario:
            'Ein Ticket hat eine ganzzahlige Nummer, einen Betreff als Text, die Angabe, ob es von einem Premiumkunden stammt, und sein Alter in Stunden mit Nachkommastellen. Alle Attribute sind nur innerhalb der Klasse sichtbar. Die Methode schliessen ist bereits eingetragen.',
        prompt: 'Ergänze das UML-Klassendiagramm. (5 P.)',
        mono: true,
        text:
            '{0}\n----------------------------\n- nr: {1}\n- betreff: {2}\n{3} premium: boolean\n- alterStd: {4}\n----------------------------\n+ schliessen(): void',
        luecken: [
          wort(['Ticket'], 'Klassenname im Singular.'),
          wahl('int', ['double', 'String', 'boolean'], 'Ganze Zahl.'),
          wahl('String', ['int', 'char', 'boolean'], 'Text.'),
          wahl('-', ['+', '#'], 'Nur innerhalb der Klasse: private.'),
          wahl('double', ['int', 'String', 'boolean'], 'Kommazahl.'),
        ],
        explanation:
            'Oben steht der Klassenname Ticket. Die Nummer ist int, der Betreff String, das Alter mit Nachkommastellen double. „Nur innerhalb der Klasse sichtbar“ ist private und wird mit - notiert.',
        punkte: 5,
      ),
      freitext(
        'f-a04e-agentur-d',
        'pl-pseudocode',
        scenario:
            'Ein weiterer Algorithmus soll zählen, wie viele Tickets älter als 48 Stunden sind. Für alter = [30, 50, 48, 72] gibt er 1 statt 2 aus.',
        code: '''anz ← 0
FÜR i VON 0 BIS n - 1
  WENN alter[i] < 48 DANN
    anz ← anz + 1
  ENDE WENN
ENDE FÜR
AUSGABE anz''',
        prompt:
            'Erläutere den Fehler im Pseudocode und gib die korrigierte Zeile an. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Fehler: Der Vergleich ist vertauscht. Geprüft wird „kleiner als 48“',
            stichwoerter: [
              'vergleich',
              'vertauscht',
              'kleiner statt größer',
              'falscher operator',
              'vergleichsoperator',
            ],
          ),
          krit(
            'Folge: Gezählt werden die Tickets unter 48 Stunden (hier nur das mit 30)',
            stichwoerter: [
              'jüngere',
              'jünger',
              'unter 48',
              'falschen tickets',
              'nur 30',
            ],
          ),
          krit(
            'Korrektur: WENN alter[i] > 48 DANN',
            stichwoerter: [
              'alter[i] > 48',
              '> 48',
              'größer als 48',
              'größer 48',
            ],
          ),
        ],
        loesung:
            'Der Vergleichsoperator ist vertauscht: Die Bedingung alter[i] < 48 zählt die Tickets, die jünger als 48 Stunden sind, hier nur das mit 30 Stunden. Korrekt ist: WENN alter[i] > 48 DANN. Dann werden 50 und 72 gezählt, Ausgabe 2.',
        explanation:
            'Je 1 Punkt für die Fundstelle (Vergleich), die Auswirkung (falsche Tickets werden gezählt) und die korrigierte Zeile. Das Ticket mit genau 48 Stunden zählt bei > 48 nicht mit.',
      ),
      freitext(
        'f-a04e-agentur-e',
        'oo-grundbegriffe',
        scenario:
            'Das Ticketsystem wird objektorientiert entwickelt. Ein Kunde der Agentur fragt, was das bringt.',
        prompt:
            'Nenne zwei Vorteile der objektorientierten gegenüber der prozeduralen Programmierung. (2 P.)',
        punkte: 2,
        kriterien: [
          krit(
            'Wiederverwendbarkeit von Klassen',
            stichwoerter: [
              'wiederverwendbarkeit',
              'wiederverwendung',
              'wiederverwendbar',
              'mehrfach nutzen',
            ],
          ),
          krit(
            'Bessere Wartbarkeit',
            stichwoerter: ['wartbarkeit', 'wartbar', 'übersichtlich', 'pflege'],
          ),
          krit(
            'Leichtere Erweiterbarkeit',
            stichwoerter: [
              'erweiterbarkeit',
              'erweiterbar',
              'erweitern',
              'ergänzen',
            ],
          ),
          krit(
            'Kapselung der Daten',
            stichwoerter: [
              'kapselung',
              'datenkapselung',
              'geschützt',
              'zugriffsschutz',
            ],
          ),
        ],
        loesung:
            'Zum Beispiel Wiederverwendbarkeit und Wartbarkeit. Ebenfalls richtig: Erweiterbarkeit, Kapselung der Daten.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2. Stichworte genügen; andere fachlich richtige Vorteile werden ebenfalls gewertet.',
      ),
      freitext(
        'f-a04e-agentur-f',
        'af-dokumente',
        scenario:
            'Für einen Kunden soll die Agentur ein ähnliches Ticketsystem entwickeln. Der Kunde hat ein Lastenheft geschickt und erwartet von Pixelhafen ein Pflichtenheft.',
        prompt:
            'Beschreibe, worin sich das Pflichtenheft vom Lastenheft unterscheidet. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Lastenheft: vom Auftraggeber, beschreibt was gefordert ist',
            stichwoerter: ['auftraggeber', 'kunde', 'was', 'anforderungen'],
          ),
          krit(
            'Pflichtenheft: vom Auftragnehmer erstellt',
            stichwoerter: [
              'auftragnehmer',
              'agentur',
              'pixelhafen',
              'dienstleister',
            ],
          ),
          krit(
            'Pflichtenheft: beschreibt, wie und womit die Anforderungen umgesetzt werden',
            stichwoerter: [
              'wie',
              'womit',
              'umsetzung',
              'lösungskonzept',
              'technisch',
            ],
          ),
          krit(
            'Das genehmigte Pflichtenheft ist Grundlage der Abnahme',
            stichwoerter: [
              'abnahme',
              'genehmigt',
              'verbindlich',
              'verpflichtet',
            ],
          ),
        ],
        loesung:
            'Das Lastenheft stammt vom Auftraggeber und beschreibt, was das System leisten soll. Das Pflichtenheft schreibt der Auftragnehmer, hier die Agentur. Es beschreibt, wie und womit die Anforderungen umgesetzt werden, und ist nach der Genehmigung die Grundlage der Abnahme.',
        explanation:
            'Je Aspekt 1 Punkt, höchstens 3: Verfasser und Inhalt des Lastenhefts, Verfasser des Pflichtenhefts, Inhalt des Pflichtenhefts, Bedeutung für die Abnahme.',
      ),
    ],
  ),

  // ---------------------------------------------------------------- Logistik
  fall(
    'f-a04e-logistik',
    firma: 'logistik',
    bereich: 'a04',
    titel: 'Lagergebühren für die neue Halle berechnen',
    situation:
        'Für die neue Lagerhalle der Elbtal Logistik AG entwickelt die IT-Abteilung ein Programm, das Paletten verwaltet und die monatlichen Lagergebühren berechnet. Es wird objektorientiert entwickelt, die Gebührenberechnung liegt als Pseudocode mit englischen Schlüsselwörtern vor. Du prüfst den Entwurf vor der Programmierung.',
    teile: [
      freitext(
        'f-a04e-logistik-a',
        'oo-grundbegriffe',
        scenario:
            'Die bisherige Lagersoftware ist prozedural geschrieben. Das neue Programm soll objektorientiert entwickelt werden.',
        prompt:
            'Nenne zwei Vorteile der objektorientierten gegenüber der prozeduralen Programmierung. (2 P.)',
        punkte: 2,
        kriterien: [
          krit(
            'Wiederverwendbarkeit von Klassen',
            stichwoerter: [
              'wiederverwendbarkeit',
              'wiederverwendung',
              'wiederverwendbar',
              'mehrfach nutzen',
            ],
          ),
          krit(
            'Bessere Wartbarkeit',
            stichwoerter: ['wartbarkeit', 'wartbar', 'übersichtlich', 'pflege'],
          ),
          krit(
            'Leichtere Erweiterbarkeit',
            stichwoerter: [
              'erweiterbarkeit',
              'erweiterbar',
              'erweitern',
              'ergänzen',
            ],
          ),
          krit(
            'Kapselung der Daten',
            stichwoerter: [
              'kapselung',
              'datenkapselung',
              'geschützt',
              'zugriffsschutz',
            ],
          ),
        ],
        loesung:
            'Zum Beispiel Wiederverwendbarkeit und Erweiterbarkeit. Ebenfalls richtig: Wartbarkeit, Kapselung der Daten.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2. Stichworte genügen; andere fachlich richtige Vorteile werden ebenfalls gewertet.',
      ),
      lueckentext(
        'f-a04e-logistik-b',
        'u-klassen',
        scenario:
            'Eine Palette hat eine Kennung als Text, ein Gewicht in Kilogramm mit Nachkommastellen, die Angabe, ob sie gekühlt gelagert wird, und die Zahl der bisherigen Lagertage. Alle Attribute sind von außen nicht direkt zugreifbar. Die Methode berechneGebuehr ist bereits eingetragen.',
        prompt: 'Ergänze das UML-Klassendiagramm. (5 P.)',
        mono: true,
        text:
            '{0}\n----------------------------\n- kennung: {1}\n- gewicht: {2}\n{3} gekuehlt: boolean\n- lagertage: {4}\n----------------------------\n+ berechneGebuehr(): double',
        luecken: [
          wort(['Palette'], 'Klassenname im Singular.'),
          wahl('String', ['int', 'double', 'boolean'], 'Text.'),
          wahl('double', ['int', 'String', 'boolean'], 'Kommazahl.'),
          wahl('-', ['+', '#'], 'Nicht direkt zugreifbar: private.'),
          wahl('int', ['double', 'String', 'boolean'], 'Ganze Tage.'),
        ],
        explanation:
            'Der Klassenname Palette steht oben. Kennung als Text: String. Gewicht mit Nachkommastellen: double. Anzahl der Lagertage: int. Nicht von außen zugreifbar heißt private, notiert mit -.',
        punkte: 5,
      ),
      tabelle(
        'f-a04e-logistik-c',
        'pl-schreibtischtest',
        scenario:
            'Die Gebührenberechnung wird mit drei Paletten getestet: P1 mit 620 kg, gekühlt; P2 mit 500 kg, ungekühlt; P3 mit 480 kg, gekühlt.',
        code: '''base ← 6.00     // fee per pallet
heavy ← 2.50    // above 500 kg
cooling ← 4.50  // cooled storage
total ← 0
for each p in pallets
  fee ← base
  if p.weight > 500 then
    fee ← fee + heavy
  end if
  if p.cooled then
    fee ← fee + cooling
  end if
  total ← total + fee
end for
// 10 % discount from 25 upwards
if total >= 25 then
  total ← total * 0.9
end if
print total''',
        prompt:
            'Führe einen Schreibtischtest durch: Berechne die Gebühr je Palette und die Ausgabe (in €). (10 P.)',
        zeilen: [
          ['Schritt', 'Wert'],
          ['fee für P1', zahl(13, toleranz: 0.005)],
          ['fee für P2', zahl(6, toleranz: 0.005)],
          ['fee für P3', zahl(10.5, toleranz: 0.005)],
          ['Ausgabe', zahl(26.55, toleranz: 0.005)],
        ],
        explanation:
            'P1: 6,00 + 2,50 (620 > 500) + 4,50 (gekühlt) = 13,00. P2: 500 > 500 ist falsch, ungekühlt: 6,00. P3: 480 > 500 falsch, gekühlt: 6,00 + 4,50 = 10,50. Summe 29,50 >= 25, also 29,50 × 0,9 = 26,55. Je Palette 2 Punkte, 4 Punkte für die Ausgabe.',
        punkte: 10,
        difficulty: 3,
      ),
      reihenfolge(
        'f-a04e-logistik-d',
        'u-aktivitaet',
        scenario:
            'Wareneingang in der neuen Halle: Der Lieferschein wird gescannt, danach werden die Paletten gezählt. Stimmt die Menge mit dem Lieferschein überein, wird die Ware eingelagert, sonst wird eine Abweichung gemeldet. In beiden Fällen wird anschließend der Wareneingang gebucht.',
        prompt:
            'Erstelle das Aktivitätsdiagramm für den Fall, dass die Menge stimmt: Bringe die Elemente in die richtige Reihenfolge. (3 P.)',
        items: [
          'Startknoten',
          'Lieferschein scannen',
          'Paletten zählen',
          'Entscheidung, Kante [Menge stimmt]',
          'Ware einlagern',
          'Zusammenführung',
          'Wareneingang buchen',
          'Endknoten',
        ],
        hint: 'Vom Startknoten bis zum Endknoten',
        explanation:
            'Auf den Startknoten folgen „Lieferschein scannen“ und „Paletten zählen“. Die Entscheidung führt mit [Menge stimmt] zu „Ware einlagern“. Die Zusammenführung vereint beide alternativen Wege vor „Wareneingang buchen“, zuletzt kommt der Endknoten.',
        punkte: 3,
      ),
      lueckentext(
        'f-a04e-logistik-e',
        'u-aktivitaet',
        scenario:
            'Der Ablauf des Wareneingangs wird ergänzt: Nach „Wareneingang buchen“ sollen „Etikett drucken“ und „Lagerplatz zuweisen“ gleichzeitig ablaufen.',
        prompt:
            'Ergänze die Beschreibung des Aktivitätsdiagramms mit den passenden Begriffen. (3 P.)',
        text:
            'An der zweiten Kante der Entscheidung steht die Bedingung {0}. Die beiden gleichzeitigen Aktionen beginnen an einer {1} und enden an einer {2}.',
        luecken: [
          wort(['[Menge weicht ab]'], 'Das Gegenstück zu [Menge stimmt].'),
          wort(['Gabelung'], 'Balken, der parallele Wege startet (Teilung).'),
          wort([
            'Vereinigung',
          ], 'Balken, der auf beide Wege wartet (Synchronisation).'),
        ],
        wortbank: ['[Menge > 0]', 'Zusammenführung', 'Entscheidung'],
        explanation:
            'Die Bedingungen einer Entscheidung müssen alle Fälle abdecken: [Menge stimmt] und [Menge weicht ab]. Gleichzeitige Aktionen liegen zwischen zwei Balken: Gabelung am Anfang, Vereinigung am Ende.',
        punkte: 3,
      ),
      freitext(
        'f-a04e-logistik-f',
        'pl-datentypen',
        scenario:
            'Jede Palette trägt einen 18-stelligen Barcode, der mit Nullen beginnen kann, zum Beispiel 003401234500000017. Ein Kollege schlägt vor, ihn als Ganzzahl (int) zu speichern.',
        prompt:
            'Begründe, warum der Datentyp String für den Barcode besser geeignet ist. (2 P.)',
        punkte: 2,
        kriterien: [
          krit(
            'Eine Ganzzahl speichert keine führenden Nullen',
            punkte: 2,
            stichwoerter: [
              'führende null',
              'führenden nullen',
              'nullen am anfang',
              'nullen vorne',
            ],
          ),
          krit(
            '18 Stellen überschreiten den Wertebereich von int',
            stichwoerter: ['wertebereich', 'zu groß', 'überlauf', '18 stellen'],
          ),
          krit(
            'Mit dem Barcode wird nicht gerechnet, denn er ist ein Kennzeichen',
            stichwoerter: [
              'nicht gerechnet',
              'kein rechnen',
              'kennzeichen',
              'keine rechnung',
            ],
          ),
        ],
        loesung:
            'Als Ganzzahl gingen die führenden Nullen verloren, außerdem passen 18 Stellen nicht in den Wertebereich von int. Mit dem Barcode wird nicht gerechnet, denn er ist ein Kennzeichen und wird als Zeichenfolge (String) unverändert gespeichert.',
        explanation:
            '2 Punkte für die führenden Nullen, alternativ je 1 Punkt für den Wertebereich und für „es wird nicht gerechnet“, höchstens 2.',
      ),
    ],
  ),

  // --------------------------------------------------------------- Agentur 2
  fall(
    'f-a04e-agentur2',
    firma: 'agentur',
    bereich: 'a04',
    titel: 'Zeiterfassung für Kundenprojekte entwickeln',
    situation:
        'Die Pixelhafen Medien GmbH rechnet ihre Webprojekte nach Stunden ab. Eine kleine Webanwendung soll die Arbeitszeiten je Projekt erfassen, Überstunden ermitteln und vor einer Überschreitung des Stundenbudgets warnen. Du unterstützt das Team beim Klassenentwurf und beim Testen des Pseudocodes.',
    teile: [
      freitext(
        'f-a04e-agentur2-a',
        'oo-grundbegriffe',
        scenario:
            'Im Entwurf gibt es die Klasse Projekt mit den Attributen titel und budgetStunden. Aktuell betreut die Agentur 14 Kundenprojekte.',
        prompt:
            'Erläutere den Unterschied zwischen einer Klasse und einem Objekt anhand dieses Beispiels. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Klasse: Bauplan/Vorlage, legt Attribute und Methoden fest',
            punkte: 2,
            stichwoerter: [
              'bauplan',
              'vorlage',
              'schablone',
              'legt fest',
              'beschreibt',
            ],
          ),
          krit(
            'Objekt: konkretes Exemplar (Instanz) mit eigenen Attributwerten',
            punkte: 2,
            stichwoerter: [
              'exemplar',
              'instanz',
              'konkret',
              'eigene werte',
              'attributwerte',
            ],
          ),
        ],
        loesung:
            'Die Klasse Projekt ist der Bauplan: Sie legt fest, dass jedes Projekt einen Titel und ein Stundenbudget hat. Ein Objekt ist ein konkretes Projekt mit eigenen Werten, zum Beispiel titel = „Relaunch Stadtwerke“ und budgetStunden = 120. Aus der einen Klasse entstehen hier 14 Objekte.',
        explanation:
            'Je Begriff 2 Punkte: 1 für die Erklärung, 1 für den Bezug zum Beispiel. Kurz: Klasse = Bauplan, Objekt = Exemplar mit eigenem Zustand.',
      ),
      tabelle(
        'f-a04e-agentur2-b',
        'u-klassen',
        scenario:
            'Die Klasse Projekt erhält einen Titel als Text und ein Stundenbudget als ganze Zahl. Beide Attribute sind gekapselt. Die Methode bucheStunden erhält eine Stundenzahl mit Nachkommastellen, soll von anderen Klassen aufgerufen werden können und liefert nichts zurück.',
        prompt:
            'Trage Sichtbarkeit und Typ für das UML-Klassendiagramm ein. (6 P.)',
        zeilen: [
          ['Element', 'Sichtbarkeit', 'Typ / Rückgabetyp'],
          [
            'titel',
            wahl('-', ['+', '#']),
            wahl('String', ['int', 'double', 'void']),
          ],
          [
            'budgetStunden',
            wahl('-', ['+', '#']),
            wahl('int', ['String', 'double', 'void']),
          ],
          [
            'bucheStunden(h: double)',
            wahl('+', ['-', '#']),
            wahl('void', ['int', 'double', 'String']),
          ],
        ],
        explanation:
            'Gekapselte Attribute sind private (-): titel als String, budgetStunden als int. Die Methode ist von außen aufrufbar, also public (+), und liefert nichts zurück: void.',
        punkte: 6,
      ),
      tabelle(
        'f-a04e-agentur2-c',
        'pl-schreibtischtest',
        scenario:
            'Das Programm ermittelt die Überstunden einer Woche. Die erste Zeile der Tabelle ist bereits ausgefüllt.',
        code: '''ist ← [9, 8, 6, 10, 11]
soll ← 8
ueber ← 0
FÜR i VON 0 BIS 4
  diff ← ist[i] - soll
  WENN diff > 0 DANN
    ueber ← ueber + diff
  ENDE WENN
ENDE FÜR
AUSGABE ueber''',
        prompt:
            'Führe einen Schreibtischtest durch: Trage für jeden Durchlauf diff und den Wert von ueber am Ende des Durchlaufs ein. (8 P.)',
        zeilen: [
          ['i', 'ist[i]', 'diff', 'ueber'],
          ['0', '9', '1', '1'],
          ['1', '8', zahl(0), zahl(1)],
          ['2', '6', zahl(-2), zahl(1)],
          ['3', '10', zahl(2), zahl(3)],
          ['4', '11', zahl(3), zahl(6)],
        ],
        explanation:
            'i = 1: diff = 0, 0 > 0 ist falsch, ueber bleibt 1. i = 2: diff = -2, Minusstunden werden nicht verrechnet, ueber bleibt 1. i = 3: diff = 2, ueber = 3. i = 4: diff = 3, ueber = 6. Ausgabe: 6.',
        punkte: 8,
      ),
      markieren(
        'f-a04e-agentur2-d',
        'pl-pseudocode',
        scenario:
            'Der Algorithmus soll warnen, wenn die gebuchten Stunden das Budget überschreiten. Bei stunden = [12, 9, 14] und budget = 30 erscheint keine Warnung.',
        prompt: 'Markiere die fehlerhafte Zeile. (2 P.)',
        mono: true,
        zeilen: [
          nein('summe ← 0', 'Die Summe startet richtig bei 0.'),
          nein('FÜR i VON 0 BIS n - 1', 'Alle Buchungen werden durchlaufen.'),
          nein('  summe ← summe + stunden[i]', 'So wird richtig aufsummiert.'),
          nein('ENDE FÜR', 'Schließt die Schleife.'),
          ja(
            'WENN summe < budget DANN',
            'Der Vergleich ist vertauscht: gewarnt wird, wenn die Summe unter dem Budget liegt.',
          ),
          nein(
            '  AUSGABE "Budget überschritten"',
            'Der Text passt zur Aufgabe.',
          ),
          nein('ENDE WENN', 'Schließt die Verzweigung.'),
        ],
        explanation:
            'Die Summe ist 12 + 9 + 14 = 35. Die Bedingung 35 < 30 ist falsch, deshalb bleibt die Warnung aus. Überschritten ist das Budget, wenn die Summe größer ist: summe > budget.',
        punkte: 2,
      ),
      freitext(
        'f-a04e-agentur2-e',
        'pl-pseudocode',
        scenario:
            'In der Budgetprüfung steht die Zeile „WENN summe < budget DANN“. Bei stunden = [12, 9, 14] und budget = 30 erscheint keine Warnung „Budget überschritten“.',
        prompt: 'Erläutere den Fehler und gib die korrigierte Zeile an. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Fehler: Der Vergleichsoperator ist vertauscht (< statt >)',
            stichwoerter: [
              'vertauscht',
              'vergleichsoperator',
              'falscher vergleich',
              'kleiner statt größer',
              'falsches zeichen',
            ],
          ),
          krit(
            'Folge: Die Summe 35 ist nicht kleiner als 30, deshalb erscheint keine Warnung (bzw. es würde bei unterschrittenem Budget gewarnt)',
            stichwoerter: [
              'keine warnung',
              '35',
              'unter dem budget',
              'nicht kleiner',
              'bedingung falsch',
            ],
          ),
          krit(
            'Korrektur: WENN summe > budget DANN',
            stichwoerter: [
              'summe > budget',
              '> budget',
              'größer als budget',
              'größer als das budget',
            ],
          ),
        ],
        loesung:
            'Der Vergleichsoperator ist vertauscht: summe < budget ist nur wahr, wenn das Budget noch nicht erreicht ist. Hier ist die Summe 35, und 35 < 30 ist falsch. Es erscheint keine Warnung. Korrekt ist: WENN summe > budget DANN.',
        explanation:
            'Je 1 Punkt für die Fundstelle (Vergleichsoperator), die Auswirkung (Warnung bleibt aus) und die korrigierte Zeile.',
      ),
      rechnen(
        'f-a04e-agentur2-f',
        'pl-schreibtischtest',
        scenario:
            'Für ein Projekt wurden an drei Tagen Stunden gebucht. Abgerechnet wird mit 80 € je Stunde.',
        code: '''stunden ← [3.5, 4, 2.5]
betrag ← 0
FÜR i VON 0 BIS 2
  betrag ← betrag + stunden[i] * 80
ENDE FÜR
AUSGABE betrag''',
        prompt: 'Ermittle die Ausgabe des Programms. (2 P.)',
        answer: 800,
        unit: '€',
        explanation:
            'i = 0: 3,5 × 80 = 280. i = 1: 280 + 4 × 80 = 600. i = 2: 600 + 2,5 × 80 = 800. Kontrolle: 10 Stunden × 80 € = 800 €.',
        punkte: 2,
      ),
    ],
  ),

  // ---------------------------------------------------------------- Handel 2
  fall(
    'f-a04e-handel2',
    firma: 'handel',
    bereich: 'a04',
    titel: 'Bonusprogramm für den Webshop entwickeln',
    situation:
        'Die Grünwerk Gartenbedarf GmbH führt ein Bonusprogramm ein: Kundinnen und Kunden sammeln bei jedem Einkauf im Webshop und in den Filialen Punkte und lösen sie später ein. Die IT-Abteilung entwickelt dafür die Klasse Bonuskonto und die Punkteberechnung. Du testest den Entwurf, bevor er in den Webshop eingebaut wird.',
    teile: [
      tabelle(
        'f-a04e-handel2-a',
        'pl-schreibtischtest',
        scenario:
            'Ein neues Bonuskonto startet mit 0 Punkten. gutschreiben(p) addiert p nur, wenn p > 0 ist. einloesen(p) zieht p nur ab, wenn p <= punkte ist. Die Aufrufe erfolgen nacheinander auf demselben Objekt k.',
        prompt:
            'Trage nach jedem Aufruf den Wert des Attributs punkte ein. (4 P.)',
        zeilen: [
          ['Aufruf', 'punkte danach'],
          ['k.gutschreiben(120)', zahl(120)],
          ['k.einloesen(150)', zahl(120)],
          ['k.gutschreiben(-20)', zahl(120)],
          ['k.einloesen(120)', zahl(0)],
        ],
        explanation:
            'gutschreiben(120): 0 + 120 = 120. einloesen(150): 150 <= 120 ist falsch, abgelehnt, bleibt 120. gutschreiben(-20): -20 > 0 ist falsch, bleibt 120. einloesen(120): 120 <= 120 ist wahr, 120 - 120 = 0.',
        punkte: 4,
      ),
      tabelle(
        'f-a04e-handel2-b',
        'pl-schreibtischtest',
        scenario:
            'Je volle 10 € Umsatz gibt es einen Punkt, ab 100 € Umsatz je Einkauf die doppelte Punktzahl. DIV liefert das ganzzahlige Ergebnis einer Division.',
        code: '''umsatz ← [45, 100, 99, 250]
punkte ← 0
FÜR i VON 0 BIS 3
  p ← umsatz[i] DIV 10
  WENN umsatz[i] >= 100 DANN
    p ← p * 2
  ENDE WENN
  punkte ← punkte + p
ENDE FÜR
AUSGABE punkte''',
        prompt:
            'Führe einen Schreibtischtest durch: Trage für jeden Durchlauf p und punkte am Ende des Durchlaufs ein. (6 P.)',
        zeilen: [
          ['i', 'umsatz[i]', 'p', 'punkte'],
          ['0', '45', zahl(4), zahl(4)],
          ['1', '100', zahl(20), zahl(24)],
          ['2', '99', zahl(9), zahl(33)],
          ['3', '250', zahl(50), zahl(83)],
        ],
        explanation:
            'i = 0: 45 DIV 10 = 4, punkte = 4. i = 1: 100 DIV 10 = 10, 100 >= 100 ist wahr, p = 20, punkte = 24. i = 2: 99 DIV 10 = 9, 99 >= 100 falsch, punkte = 33. i = 3: 250 DIV 10 = 25, verdoppelt 50, punkte = 83. Ausgabe: 83.',
        punkte: 6,
      ),
      lueckentext(
        'f-a04e-handel2-c',
        'u-klassen',
        scenario:
            'Aus dem Fachkonzept: Jeder Kunde besitzt genau ein Bonuskonto, jedes Bonuskonto gehört zu genau einem Kunden. Zu einem Bonuskonto gehören beliebig viele Buchungen, auch keine. Eine Buchung gehört zu genau einem Bonuskonto und wird mit ihm gelöscht.',
        prompt:
            'Wähle die Multiplizitäten und die Beziehungsart für das UML-Klassendiagramm. (5 P.)',
        mono: true,
        text:
            'Kunde {0} ------ {1} Bonuskonto\nBonuskonto {2} ◆----- {3} Buchung\n\nGefüllte Raute = {4}',
        luecken: [
          wahl('1', ['0..1', '0..*', '1..*'], 'Genau ein Kunde je Bonuskonto.'),
          wahl('1', ['0..1', '0..*', '1..*'], 'Genau ein Bonuskonto je Kunde.'),
          wahl('1', [
            '0..1',
            '0..*',
            '1..*',
          ], 'Genau ein Bonuskonto je Buchung.'),
          wahl('0..*', ['1', '0..1', '1..*'], 'Beliebig viele, auch keine.'),
          wahl('Komposition', [
            'Aggregation',
            'Assoziation',
          ], 'Die Buchung existiert nicht ohne ihr Bonuskonto.'),
        ],
        explanation:
            'Kunde und Bonuskonto stehen 1 zu 1. Ein Bonuskonto hat 0..* Buchungen, jede Buchung gehört zu genau 1 Bonuskonto. Weil die Buchungen mit dem Konto gelöscht werden, ist es eine Komposition, also gefüllte Raute am Ganzen.',
        punkte: 5,
      ),
      freitext(
        'f-a04e-handel2-d',
        'oo-konstruktor',
        scenario: 'Im Webshop wird das Bonuskonto so verwendet.',
        code: '''Bonuskonto k = new Bonuskonto();
k.gutschreiben(50);
int p = k.getPunkte();''',
        prompt: 'Erläutere, was jede der drei Zeilen bewirkt. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Zeile 1: erzeugt ein neues Objekt der Klasse Bonuskonto (Konstruktor wird aufgerufen)',
            stichwoerter: [
              'objekt erzeugt',
              'neues objekt',
              'erzeugt',
              'konstruktor',
              'instanz',
            ],
          ),
          krit(
            'Zeile 2: ruft die Methode gutschreiben des Objekts mit dem Wert 50 auf',
            stichwoerter: [
              'methode',
              'aufruf',
              'ruft',
              'gutgeschrieben',
              '50 punkte',
            ],
          ),
          krit(
            'Zeile 3: liest den Punktestand über den Getter und speichert ihn in p',
            stichwoerter: [
              'getter',
              'liest',
              'punktestand',
              'speichert',
              'variable p',
            ],
          ),
        ],
        loesung:
            'Zeile 1 erzeugt mit new ein neues Objekt der Klasse Bonuskonto und speichert die Referenz in k. Zeile 2 ruft auf diesem Objekt die Methode gutschreiben mit dem Wert 50 auf. Zeile 3 liest den Punktestand über den Getter getPunkte und speichert ihn in der Variablen p.',
        explanation:
            'Je Zeile 1 Punkt. Stichworte genügen: Objekt erzeugen, Methode aufrufen, Wert über Getter lesen.',
      ),
      freitext(
        'f-a04e-handel2-e',
        'oo-kapselung',
        scenario:
            'Im ersten Entwurf war das Attribut punkte der Klasse Bonuskonto public. Im Test hat ein anderes Modul den Punktestand versehentlich auf -300 gesetzt.',
        prompt:
            'Beschreibe, wie sich dieser Fehler durch Kapselung verhindern lässt. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Das Attribut punkte wird private: kein direkter Zugriff von außen',
            punkte: 2,
            stichwoerter: [
              'private',
              'privat',
              'kein direkter zugriff',
              'nur innerhalb',
            ],
          ),
          krit(
            'Änderungen laufen nur über öffentliche Methoden wie gutschreiben und einloesen',
            punkte: 2,
            stichwoerter: [
              'öffentliche methoden',
              'public methoden',
              'gutschreiben',
              'einloesen',
              'setter',
            ],
          ),
          krit(
            'Die Methoden prüfen die Werte und lehnen ungültige ab',
            punkte: 2,
            stichwoerter: [
              'prüfen',
              'prüfung',
              'ungültige',
              'negative',
              'validierung',
            ],
          ),
        ],
        loesung:
            'Das Attribut punkte wird private, sodass andere Module nicht mehr direkt darauf zugreifen können. Geändert wird der Punktestand nur über die öffentlichen Methoden gutschreiben und einloesen. Diese prüfen die übergebenen Werte und lehnen ungültige ab. Ein negativer Punktestand kann nicht mehr entstehen.',
        explanation:
            'Je Aspekt 2 Punkte, höchstens 4: private Attribute, Zugriff nur über öffentliche Methoden, Prüfung der Werte in den Methoden.',
      ),
      freitext(
        'f-a04e-handel2-f',
        'af-erhebung',
        scenario:
            'Vor der Entwicklung sollen die Wünsche von rund 60 Verkäuferinnen und Verkäufern in den Filialen und der drei Verantwortlichen im Kundenservice an das Bonusprogramm ermittelt werden.',
        prompt:
            'Nenne drei Techniken, mit denen sich die Anforderungen erheben lassen. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Interview',
            stichwoerter: [
              'interview',
              'befragung',
              'gespräch',
              'einzelgespräch',
            ],
          ),
          krit(
            'Fragebogen',
            stichwoerter: [
              'fragebogen',
              'umfrage',
              'onlinebefragung',
              'onlineumfrage',
            ],
          ),
          krit(
            'Beobachtung',
            stichwoerter: [
              'beobachtung',
              'beobachten',
              'hospitation',
              'feldbeobachtung',
            ],
          ),
          krit(
            'Workshop',
            stichwoerter: [
              'workshop',
              'brainstorming',
              'gruppendiskussion',
              'kreativtechnik',
            ],
          ),
          krit(
            'Dokumentenanalyse',
            stichwoerter: [
              'dokumentenanalyse',
              'unterlagen auswerten',
              'dokumente',
              'altsystem',
            ],
          ),
        ],
        loesung:
            'Zum Beispiel: Interview (mit den drei Verantwortlichen im Kundenservice), Fragebogen (für die rund 60 Verkäuferinnen und Verkäufer), Beobachtung an der Kasse. Ebenfalls richtig: Workshop, Dokumentenanalyse.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3. Stichworte genügen. Wenige Schlüsselpersonen befragt man im Interview, viele Personen erreicht man mit einem Fragebogen.',
      ),
    ],
  ),
];
