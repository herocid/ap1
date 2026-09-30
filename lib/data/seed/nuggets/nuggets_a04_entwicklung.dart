import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 04, Teil 1: Anforderungen, UML, Programmierlogik
/// und Objektorientierung.
final List<Nugget> nuggetsA04Entwicklung = [
  // ================================================ Lastenheft und Pflichtenheft
  konzept('n-ld-1', 'af-dokumente', 'Zwei Dokumente, zwei Rollen',
      'Bevor ein Dienstleister Software baut, muss klar sein, was gebraucht wird und wie es umgesetzt wird. Dafür gibt es zwei Dokumente: Das Lastenheft schreibt der Auftraggeber, das Pflichtenheft der Auftragnehmer.',
      merksatz: 'Lastenheft: Was und wofür? Pflichtenheft: Wie und womit?'),
  vergleich('n-ld-2', 'af-dokumente', 'Lastenheft oder Pflichtenheft?',
      'Die beiden Dokumente unterscheiden sich in Verfasser, Inhalt und Zeitpunkt.',
      [
        ['', 'Lastenheft', 'Pflichtenheft'],
        ['Verfasser', 'Auftraggeber', 'Auftragnehmer'],
        ['Frage', 'Was und wofür?', 'Wie und womit?'],
        ['Zeitpunkt', 'vor der Ausschreibung', 'nach der Vergabe'],
        ['Dient als', 'Basis für Angebote', 'Basis für die Abnahme'],
      ]),
  konzept('n-ld-3', 'af-dokumente', 'Was drinsteht',
      'Das Lastenheft bleibt lösungsneutral. Das Pflichtenheft übernimmt die Anforderungen und ergänzt, wie sie technisch erfüllt werden.',
      points: [
        'Lastenheft: Ausgangssituation, Ziele, funktionale und nicht-funktionale Anforderungen, Rahmenbedingungen',
        'Pflichtenheft: Lösungskonzept, Systemarchitektur, eingesetzte Technologien, Schnittstellen',
        'Pflichtenheft: Abnahmekriterien und Testfälle, Zeitplan',
      ]),
  vergleich('n-ld-4', 'af-dokumente', 'Eine Anforderung, zwei Sichten',
      'Beispiel: Eine Arztpraxis möchte eine Online-Terminbuchung. So sieht dieselbe Anforderung in beiden Dokumenten aus.',
      [
        ['Dokument', 'Formulierung'],
        ['Lastenheft', 'Patientinnen und Patienten können rund um die Uhr Termine online buchen.'],
        ['Pflichtenheft', 'Buchung über eine Webanwendung, die per REST-Schnittstelle an die Praxissoftware angebunden ist.'],
      ]),
  falle('n-ld-5', 'af-dokumente', 'Genehmigung und Abnahme',
      'Das Pflichtenheft schreibt zwar der Auftragnehmer, verbindlich wird es aber erst durch die Genehmigung des Auftraggebers. Abgenommen wird gegen das Pflichtenheft - nicht gegen das Lastenheft, denn nur das Pflichtenheft enthält die prüfbare, konkrete Lösung.',
      merksatz: 'LAstenheft = Auftraggeber, PFlichtenheft = Auftragnehmer, Abnahme gegen das Pflichtenheft.'),

  // ===================================================== Arten von Anforderungen
  konzept('n-fa-1', 'af-arten', 'Was und wie gut',
      'Funktionale Anforderungen beschreiben, was ein System tut: welche Funktionen, Daten und Reaktionen es bietet. Nicht-funktionale Anforderungen beschreiben, wie gut und unter welchen Bedingungen es das tut.'),
  vergleich('n-fa-2', 'af-arten', 'Zwei Arten im Vergleich',
      'Beispiele aus einem Webshop zeigen den Unterschied.',
      [
        ['Art', 'Leitfrage', 'Beispiel'],
        ['funktional', 'Was soll das System tun?', 'Rechnung als PDF erzeugen'],
        ['nicht-funktional', 'Wie gut, unter welchen Bedingungen?', 'Suche antwortet in unter 2 Sekunden'],
      ]),
  konzept('n-fa-3', 'af-arten', 'Typische nicht-funktionale Anforderungen',
      'Nicht-funktionale Anforderungen betreffen Qualität und Rahmenbedingungen des ganzen Systems.',
      points: [
        'Leistung: Antwortzeit, Durchsatz, Anzahl gleichzeitiger Nutzer',
        'Zuverlässigkeit: Verfügbarkeit, z. B. 99,5 % im Jahr',
        'Benutzbarkeit: Bedienbarkeit, Barrierefreiheit',
        'Sicherheit: Schutz vor unbefugtem Zugriff',
        'Wartbarkeit und Übertragbarkeit: Änderbarkeit, lauffähig auf bestimmten Plattformen',
        'Randbedingungen: gesetzliche Vorgaben wie die DSGVO, vorgegebene Technik, Budget',
      ]),
  ablauf('n-fa-4', 'af-arten', 'Eine Anforderung einordnen',
      'Beispiel: „Der Webshop berechnet die Versandkosten innerhalb von einer Sekunde.“',
      [
        'Tätigkeit suchen: „berechnet die Versandkosten“ - das System tut etwas -> funktional',
        'Eigenschaft suchen: „innerhalb von einer Sekunde“ - wie schnell -> nicht-funktional',
        'Ergebnis: Der Satz enthält zwei Anforderungen und sollte in zwei Anforderungen aufgeteilt werden',
      ],
      merksatz: 'Tätigkeit des Systems = funktional. Eigenschaft oder Bedingung = nicht-funktional.'),
  falle('n-fa-5', 'af-arten', 'Anmelden ist funktional',
      '„Benutzer können sich mit Passwort und zweitem Faktor anmelden“ ist funktional - es beschreibt eine Funktion. Nicht-funktional wäre „Passwörter werden nur als Hash gespeichert“. Außerdem gilt: Auch nicht-funktionale Anforderungen müssen messbar sein. „Das System soll schnell sein“ ist nicht prüfbar.'),

  // ====================================================== Anforderungen erheben
  konzept('n-fe-1', 'af-erhebung', 'Erst die Stakeholder',
      'Anforderungen kommen von Menschen. Wer eine Gruppe vergisst, vergisst ihre Anforderungen. Deshalb klärt man zuerst, wer vom System betroffen ist oder es beeinflusst.',
      points: [
        'Anwenderinnen und Anwender, z. B. Sachbearbeitung, Lager',
        'Auftraggeber und Geschäftsleitung',
        'IT-Betrieb und Support',
        'Datenschutzbeauftragte, Betriebsrat',
      ]),
  vergleich('n-fe-2', 'af-erhebung', 'Erhebungstechniken',
      'Jede Technik hat Stärken und Schwächen - oft kombiniert man mehrere.',
      [
        ['Technik', 'Stärke', 'Schwäche'],
        ['Interview', 'Tiefe, Rückfragen möglich', 'zeitaufwendig, wenige Personen'],
        ['Fragebogen', 'viele Personen, gut auswertbar', 'keine Rückfragen, wenig Tiefe'],
        ['Beobachtung', 'zeigt echte, unbewusste Abläufe', 'aufwendig, Verhalten ändert sich'],
        ['Workshop', 'gemeinsame Sicht, Konflikte klären', 'Moderation und Termine nötig'],
        ['Dokumentenanalyse', 'nutzt Formulare, Handbücher, Altsystem', 'Unterlagen oft veraltet'],
      ]),
  konzept('n-fe-3', 'af-erhebung', 'Gute Anforderungen',
      'Eine erhobene Anforderung taugt nur dann etwas, wenn sich später eindeutig prüfen lässt, ob sie erfüllt ist.',
      points: [
        'eindeutig - nur eine Interpretation',
        'vollständig - keine fehlenden Angaben',
        'widerspruchsfrei zu anderen Anforderungen',
        'prüfbar - messbares Kriterium',
        'notwendig und realisierbar',
      ]),
  formel('n-fe-4', 'af-erhebung', 'Aus vage wird prüfbar',
      'Eine Satzschablone mit festen Verben (muss, soll, kann) zwingt zu klaren Formulierungen. „Muss“ ist verbindlich, „soll“ wünschenswert, „kann“ optional.',
      'Vage:\n'
          '„Die Suche soll schnell sein.“\n'
          '\n'
          'Prüfbar:\n'
          '„Das System muss 95 % aller\n'
          'Suchanfragen in höchstens\n'
          '2 Sekunden beantworten.“'),
  vergleich('n-fe-5', 'af-erhebung', 'Priorisieren mit MoSCoW',
      'Nicht alles lässt sich sofort umsetzen. MoSCoW sortiert Anforderungen in vier Klassen - hier am Beispiel eines Webshops.',
      [
        ['Klasse', 'Bedeutung', 'Beispiel'],
        ['Must have', 'unverzichtbar', 'Bezahlung'],
        ['Should have', 'wichtig, nicht kritisch', 'Wunschliste'],
        ['Could have', 'schön, wenn Zeit bleibt', 'dunkles Design'],
        ['Won’t have', 'diesmal bewusst nicht', 'Sprachsteuerung'],
      ]),
  falle('n-fe-6', 'af-erhebung', '„Won’t“ heißt nicht „nie“',
      'Won’t have bedeutet „in diesem Release nicht“ - die Anforderung wird dokumentiert und kann später wieder aufgenommen werden. Und: Wer nur befragt, erfährt nur, was den Menschen bewusst ist. Eingeübte Handgriffe deckt erst die Beobachtung auf.',
      merksatz: 'Must, Should, Could, Won’t (this time) - und messbar formulieren.'),

  // ===================================================== Anwendungsfalldiagramm
  konzept('n-uu-1', 'u-usecase', 'Wer macht was mit dem System?',
      'Das Anwendungsfalldiagramm (Use-Case-Diagramm) zeigt aus Sicht der Nutzer, welche Leistungen ein System bietet und wer sie nutzt. Es zeigt nicht, wie oder in welcher Reihenfolge etwas abläuft.',
      points: [
        'Akteur: Strichmännchen außerhalb des Systems - eine Rolle oder ein externes System',
        'Anwendungsfall: Ellipse mit Verb und Objekt, z. B. „Termin buchen“',
        'Systemgrenze: Rechteck mit dem Systemnamen um alle Anwendungsfälle',
        'Assoziation: durchgezogene Linie zwischen Akteur und Anwendungsfall',
      ]),
  vergleich('n-uu-2', 'u-usecase', 'Beziehungen zwischen Anwendungsfällen',
      'Neben der Assoziation gibt es zwei gestrichelte Pfeile mit Stereotyp.',
      [
        ['Beziehung', 'Bedeutung', 'Pfeilrichtung'],
        ['«include»', 'wird immer mit ausgeführt', 'vom Basisfall zum inkludierten Fall'],
        ['«extend»', 'erweitert nur unter Bedingung', 'vom erweiternden Fall zum Basisfall'],
      ]),
  formel('n-uu-3', 'u-usecase', 'Beispiel Webshop',
      'Jede Bestellung setzt eine Anmeldung voraus - also «include». Einen Gutschein lösen nur manche ein - also «extend», und der Pfeil zeigt auf „Bestellung aufgeben“.',
      '[ System: Webshop ]\n'
          '\n'
          'Kunde --- (Bestellung aufgeben)\n'
          '\n'
          '(Bestellung aufgeben)\n'
          '  - - «include» - -> (Anmelden)\n'
          '\n'
          '(Gutschein einlösen)\n'
          '  - - «extend» - ->\n'
          '         (Bestellung aufgeben)'),
  ablauf('n-uu-4', 'u-usecase', 'So entsteht das Diagramm',
      'Mit dieser Reihenfolge lässt sich jede Prüfungsaufgabe zum Anwendungsfalldiagramm angehen.',
      [
        'Systemgrenze festlegen und benennen',
        'Akteure als Rollen finden - „Kundin“, nicht „Frau Meier“',
        'Anwendungsfälle je Akteur sammeln',
        'Akteure und Anwendungsfälle mit Assoziationen verbinden',
        'Immer gemeinsam genutzte Teile als «include», optionale als «extend» modellieren',
      ]),
  falle('n-uu-5', 'u-usecase', 'Die Pfeilrichtung',
      'Bei «include» zeigt der Pfeil vom Basisfall weg zum eingebundenen Fall. Bei «extend» ist es umgekehrt: Der Pfeil zeigt vom erweiternden Fall hin zum Basisfall, denn der Basisfall funktioniert auch ohne die Erweiterung.',
      merksatz: 'include = immer, Pfeil weg vom Basisfall. extend = manchmal, Pfeil hin zum Basisfall.'),

  // =============================================================== Klassendiagramm
  konzept('n-uk-1', 'u-klassen', 'Aufbau einer Klasse',
      'Eine Klasse ist im Klassendiagramm ein Rechteck mit drei Abschnitten: oben der Name, in der Mitte die Attribute, unten die Methoden. Vor jedem Eintrag steht die Sichtbarkeit, hinter dem Doppelpunkt der Datentyp.',
      points: [
        'Attribut: - name: String',
        'Methode: + getName(): String',
        'Methode mit Parameter: + einzahlen(betrag: int): void',
      ]),
  formel('n-uk-2', 'u-klassen', 'Eine Klasse lesen',
      'Die Klasse Kunde hat zwei private Attribute, ein geschütztes Attribut und zwei öffentliche Methoden.',
      '+---------------------------+\n'
          '| Kunde                     |\n'
          '+---------------------------+\n'
          '| - kundenNr: int           |\n'
          '| - name: String            |\n'
          '| # rabatt: int             |\n'
          '+---------------------------+\n'
          '| + getName(): String       |\n'
          '| + bestellen(): boolean    |\n'
          '+---------------------------+'),
  vergleich('n-uk-3', 'u-klassen', 'Sichtbarkeiten',
      'Das Zeichen vor Attribut oder Methode legt fest, wer darauf zugreifen darf.',
      [
        ['Zeichen', 'Name', 'Zugriff'],
        ['+', 'public', 'von überall'],
        ['-', 'private', 'nur die Klasse selbst'],
        ['#', 'protected', 'Klasse und Unterklassen'],
        ['~', 'package', 'Klassen im selben Paket'],
      ]),
  vergleich('n-uk-4', 'u-klassen', 'Multiplizitäten',
      'An den Enden einer Assoziation steht, wie viele Objekte beteiligt sind. Beispiel: Kunde 1 --- 0..* Bestellung heißt: Ein Kunde hat beliebig viele Bestellungen, jede Bestellung gehört zu genau einem Kunden.',
      [
        ['Angabe', 'Bedeutung'],
        ['1', 'genau eins'],
        ['0..1', 'keins oder eins'],
        ['* oder 0..*', 'beliebig viele, auch keins'],
        ['1..*', 'mindestens eins'],
        ['2..5', 'zwei bis fünf'],
      ]),
  vergleich('n-uk-5', 'u-klassen', 'Assoziation, Aggregation, Komposition',
      'Die Raute sitzt immer am Ganzen. Entscheidend ist, ob das Teil ohne das Ganze weiterlebt.',
      [
        ['Beziehung', 'Symbol', 'Beispiel'],
        ['Assoziation', 'einfache Linie', 'Kunde - Bestellung'],
        ['Aggregation', 'leere Raute am Ganzen', 'Abteilung ◇ Mitarbeiter'],
        ['Komposition', 'gefüllte Raute am Ganzen', 'Rechnung ◆ Position'],
      ],
      merksatz: 'Komposition: Wird die Rechnung gelöscht, verschwinden ihre Positionen mit. Aggregation: Mitarbeitende gibt es auch ohne Abteilung.'),
  falle('n-uk-6', 'u-klassen', 'Auf der richtigen Seite lesen',
      'Die Multiplizität steht an dem Ende, über das sie eine Aussage macht: Die 0..* neben Bestellung sagt, wie viele Bestellungen ein Kunde hat. Und die Raute gehört ans Ganze - nicht ans Teil. Wer beides vertauscht, liest das Diagramm genau falsch herum.'),

  // ========================================================== Aktivitätsdiagramm
  konzept('n-ua-1', 'u-aktivitaet', 'Abläufe zeigen',
      'Das Aktivitätsdiagramm zeigt einen Ablauf Schritt für Schritt - einen Geschäftsprozess oder einen Algorithmus. Pfeile (Kontrollfluss) verbinden die Elemente.',
      points: [
        'Startknoten: gefüllter schwarzer Kreis',
        'Aktion: Rechteck mit abgerundeten Ecken, z. B. „Bestellung prüfen“',
        'Endknoten: gefüllter Kreis mit Ring - beendet die gesamte Aktivität',
        'Ablaufende: Kreis mit X - beendet nur diesen einen Fluss',
      ]),
  vergleich('n-ua-2', 'u-aktivitaet', 'Raute oder Balken?',
      'Verzweigungen und parallele Abläufe haben unterschiedliche Symbole.',
      [
        ['Element', 'Symbol', 'Wirkung'],
        ['Entscheidung', 'Raute, 1 rein, n raus', 'genau ein Weg je nach Bedingung'],
        ['Zusammenführung', 'Raute, n rein, 1 raus', 'alternative Wege treffen sich'],
        ['Gabelung (Fork)', 'Balken, 1 rein, n raus', 'startet parallele Wege'],
        ['Vereinigung (Join)', 'Balken, n rein, 1 raus', 'wartet, bis alle Wege fertig sind'],
      ]),
  konzept('n-ua-3', 'u-aktivitaet', 'Bedingungen an den Kanten',
      'An den ausgehenden Kanten einer Entscheidung stehen Bedingungen in eckigen Klammern, sogenannte Guards. Sie müssen sich gegenseitig ausschließen und zusammen alle Fälle abdecken.',
      points: [
        'richtig: [Betrag > 500] und [Betrag <= 500]',
        'falsch: [Betrag > 500] und [Betrag < 500] - bei genau 500 geht es nicht weiter',
        '[else] fängt alle übrigen Fälle ab',
      ]),
  formel('n-ua-4', 'u-aktivitaet', 'Beispiel Bestellabwicklung',
      'Ist die Ware lieferbar, laufen Verpacken und Rechnungserstellung parallel. Versendet wird erst, wenn beides erledigt ist.',
      '(Start)\n'
          ' -> Bestellung prüfen\n'
          ' -> <> Entscheidung\n'
          '  [nicht lieferbar]\n'
          '   -> Kunde informieren -> (Ende)\n'
          '  [lieferbar]\n'
          '   -> === Gabelung\n'
          '      | Ware verpacken\n'
          '      | Rechnung erstellen\n'
          '   -> === Vereinigung\n'
          '   -> Paket versenden -> (Ende)'),
  konzept('n-ua-5', 'u-aktivitaet', 'Swimlanes: Wer ist zuständig?',
      'Aktivitätsbereiche, auch Swimlanes oder Partitionen genannt, teilen das Diagramm in Bahnen - je Rolle oder Abteilung eine. Jede Aktion steht in der Bahn dessen, der sie ausführt, z. B. „Bestellung prüfen“ beim Vertrieb, „Ware verpacken“ im Lager.'),
  falle('n-ua-6', 'u-aktivitaet', 'Entweder-oder ist nicht sowohl-als-auch',
      'Nach einer Raute läuft genau ein Weg weiter. Nach einem Gabelungsbalken laufen alle Wege gleichzeitig. Wer parallele Arbeiten mit einer Raute zusammenführt, lässt den Ablauf schon nach dem ersten fertigen Weg weiterlaufen - dafür braucht es den Vereinigungsbalken.',
      merksatz: 'Raute = entweder-oder. Balken = alle gleichzeitig. Join wartet auf alle.'),

  // ===================================================== Variablen und Datentypen
  konzept('n-pd-1', 'pl-datentypen', 'Variable und Datentyp',
      'Eine Variable ist ein benannter Speicherplatz für einen Wert. Ihr Datentyp legt fest, welche Werte sie aufnehmen kann, wie viel Speicher sie braucht und welche Operationen erlaubt sind - mit Zahlen kann man rechnen, mit Text nicht.',
      points: [
        'Deklaration: int anzahl;',
        'Initialisierung: int anzahl = 5;',
      ]),
  vergleich('n-pd-2', 'pl-datentypen', 'Die wichtigsten Datentypen',
      'Diese einfachen Typen und der String kommen in jeder Prüfung vor.',
      [
        ['Typ', 'Inhalt', 'Beispiel'],
        ['int', 'ganze Zahl', '42'],
        ['float / double', 'Gleitkommazahl', '2.75'],
        ['boolean', 'wahr oder falsch', 'true'],
        ['char', 'ein einzelnes Zeichen', '\'A\''],
        ['String', 'Zeichenkette', '"Hallo"'],
      ]),
  formel('n-pd-3', 'pl-datentypen', 'Wertebereiche berechnen',
      'Mit n Bit lassen sich 2ⁿ verschiedene Werte darstellen. Bei Zahlen mit Vorzeichen geht die Hälfte in den negativen Bereich, und die Null zählt zur positiven Hälfte.',
      'n Bit -> 2^n Werte\n'
          'ohne Vorzeichen: 0 bis 2^n - 1\n'
          'mit Vorzeichen:\n'
          '  -2^(n-1) bis 2^(n-1) - 1\n'
          '\n'
          '8 Bit (byte): 2^8 = 256 Werte\n'
          '  -128 bis 127\n'
          '32 Bit (int): 2^32 Werte\n'
          '  -2.147.483.648 bis\n'
          '   2.147.483.647',
      merksatz: 'Größter Wert mit Vorzeichen: 2^(n-1) - 1, bei 16 Bit also 32.767.'),
  konzept('n-pd-4', 'pl-datentypen', 'Typumwandlung',
      'Beim Wechsel des Datentyps kann Information verloren gehen. Eine erweiternde Umwandlung passiert automatisch, eine einschränkende muss man ausdrücklich anfordern (Cast).',
      points: [
        'implizit, verlustfrei: int -> double, aus 7 wird 7.0',
        'explizit per Cast: (int) 9.99 ergibt 9 - Nachkommastellen werden abgeschnitten, nicht gerundet',
        'Text in Zahl: Integer.parseInt("42") ergibt 42',
        'Ganzzahldivision: 7 / 2 ergibt bei zwei int-Werten 3',
      ]),
  falle('n-pd-5', 'pl-datentypen', 'PLZ, Telefonnummer und Geld',
      'Postleitzahlen und Telefonnummern gehören in einen String: Mit ihnen wird nicht gerechnet, die führende Null (01067 Dresden) ginge als Zahl verloren, und Zeichen wie + oder Leerzeichen passen in keinen Zahlentyp. Geldbeträge nicht als float oder double speichern - 0.1 + 0.2 ergibt dort nicht exakt 0.3. Besser: ein Dezimaltyp wie BigDecimal oder ganze Cent als Ganzzahl.',
      merksatz: 'Rechnest du nicht damit, ist es ein String. Geld nie als Gleitkommazahl.'),

  // ========================================================= Kontrollstrukturen
  konzept('n-pk-1', 'pl-kontrollstrukturen', 'Drei Bausteine',
      'Jeder Algorithmus lässt sich aus drei Grundstrukturen zusammensetzen.',
      points: [
        'Sequenz: Anweisungen nacheinander',
        'Verzweigung (Selektion): Anweisungen nur unter einer Bedingung',
        'Schleife (Iteration): Anweisungen wiederholen',
      ]),
  vergleich('n-pk-2', 'pl-kontrollstrukturen', 'Verzweigungen',
      'Je nach Anzahl der Fälle gibt es unterschiedliche Formen.',
      [
        ['Form', 'Einsatz', 'Beispiel'],
        ['if', 'nur ein Dann-Zweig', 'ab 50 € versandfrei'],
        ['if / else', 'zwei Fälle', 'volljährig oder nicht'],
        ['else if', 'mehrere Bereiche', 'Notenstufen nach Punkten'],
        ['switch / case', 'ein Wert, viele Fälle', 'Menüauswahl 1, 2, 3'],
      ]),
  vergleich('n-pk-3', 'pl-kontrollstrukturen', 'Schleifen',
      'Entscheidend ist, wann die Bedingung geprüft wird.',
      [
        ['Schleife', 'Prüfung', 'min. Durchläufe'],
        ['while (kopfgesteuert)', 'vor jedem Durchlauf', '0'],
        ['do-while (fußgesteuert)', 'nach jedem Durchlauf', '1'],
        ['for (Zählschleife)', 'vor jedem Durchlauf, mit Zähler', '0'],
      ]),
  formel('n-pk-4', 'pl-kontrollstrukturen', 'Durchläufe zählen',
      'Bei Zählschleifen fragt die Prüfung gern nach der Anzahl der Durchläufe. Am sichersten: die Werte des Zählers aufschreiben.',
      'for (int i = 3; i <= 10; i++)\n'
          'i = 3, 4, ..., 10\n'
          '-> 10 - 3 + 1 = 8 Durchläufe\n'
          '\n'
          'for (int i = 0; i < 10; i += 2)\n'
          'i = 0, 2, 4, 6, 8\n'
          '-> 5 Durchläufe (10 < 10 ist falsch)'),
  falle('n-pk-5', 'pl-kontrollstrukturen', 'Endlosschleifen und fehlendes break',
      'Wird die Bedingung einer Schleife nie falsch, läuft sie endlos - typisch, wenn der Zähler im Rumpf nicht verändert wird. Bei switch/case in Java und C fehlt oft das break: Dann laufen auch die folgenden Fälle mit ab.',
      points: [
        'while (i < 10) { summe += i; } - i ändert sich nie',
        'Grenzen prüfen: < und <= unterscheiden sich um genau einen Durchlauf',
      ],
      merksatz: 'Kopfgesteuert: erst prüfen, dann laufen - vielleicht nie. Fußgesteuert: erst laufen, dann prüfen - mindestens einmal.'),

  // ======================================================= Pseudocode
  vergleich('n-pc-1', 'pl-pseudocode', 'Die Schlüsselwörter',
      'Pseudocode beschreibt einen Algorithmus unabhängig von einer Programmiersprache. Eine Norm gibt es nicht, in Prüfungen sind diese Schreibweisen üblich. Die Einrückung zeigt, was zu einem Block gehört.',
      [
        ['Element', 'Pseudocode'],
        ['Zuweisung', 'x ← 5'],
        ['Verzweigung', 'WENN … DANN … SONST … ENDE WENN'],
        ['kopfgesteuert', 'SOLANGE … ENDE SOLANGE'],
        ['fußgesteuert', 'WIEDERHOLE … BIS …'],
        ['Zählschleife', 'FÜR i VON 1 BIS n … ENDE FÜR'],
        ['Ausgabe', 'AUSGABE x'],
      ]),
  konzept('n-pc-2', 'pl-pseudocode', 'Arrays und Index',
      'Ein Array speichert mehrere gleichartige Werte unter einem Namen. Auf ein Element greift man über seinen Index zu, der meist bei 0 beginnt. Ein Array mit n Elementen hat also die Indizes 0 bis n - 1.',
      points: [
        'zahlen ← [4, 9, 2]',
        'zahlen[0] ist 4, zahlen[1] ist 9, zahlen[2] ist 2',
        'n = 3, letzter Index = 2',
      ]),
  formel('n-pc-3', 'pl-pseudocode', 'Das Maximum finden',
      'Man nimmt das erste Element als vorläufiges Maximum und vergleicht jedes weitere damit. Mit [4, 9, 2]: max = 4, dann 9 > 4 -> max = 9, dann 2 > 9 ist falsch -> Ausgabe 9.',
      'max ← zahlen[0]\n'
          'FÜR i VON 1 BIS n - 1\n'
          '  WENN zahlen[i] > max DANN\n'
          '    max ← zahlen[i]\n'
          '  ENDE WENN\n'
          'ENDE FÜR\n'
          'AUSGABE max'),
  formel('n-pc-4', 'pl-pseudocode', 'Summe und Durchschnitt',
      'Die Summe startet bei 0, jedes Element wird addiert, am Ende wird durch die Anzahl geteilt. Mit [3, 5, 10]: summe = 18, schnitt = 18 / 3 = 6.',
      'summe ← 0\n'
          'FÜR i VON 0 BIS n - 1\n'
          '  summe ← summe + werte[i]\n'
          'ENDE FÜR\n'
          'schnitt ← summe / n\n'
          'AUSGABE schnitt'),
  formel('n-pc-5', 'pl-pseudocode', 'Lineare Suche',
      'Die Liste wird von vorn nach hinten durchlaufen, bis der gesuchte Wert gefunden ist. Ausgegeben wird seine Position oder -1, wenn er fehlt. Suche nach 7 in [5, 7, 3]: gefunden bei Index 1.',
      'pos ← -1\n'
          'i ← 0\n'
          'SOLANGE i < n UND pos = -1\n'
          '  WENN liste[i] = gesucht DANN\n'
          '    pos ← i\n'
          '  ENDE WENN\n'
          '  i ← i + 1\n'
          'ENDE SOLANGE\n'
          'AUSGABE pos'),
  falle('n-pc-6', 'pl-pseudocode', 'Grenzen und Startwerte',
      'Zwei Fehler kosten in der Prüfung regelmäßig Punkte. Erstens: FÜR i VON 0 BIS n greift auf liste[n] zu - das Element gibt es nicht. Zweitens: Wird das Maximum mit 0 statt mit dem ersten Element begonnen, liefert es bei lauter negativen Werten wie [-5, -2, -8] fälschlich 0.',
      merksatz: 'Index von 0 bis n - 1. Maximum und Minimum mit dem ersten Element starten.'),

  // ============================================================ Schreibtischtest
  konzept('n-pt-1', 'pl-schreibtischtest', 'Programm ohne Computer ausführen',
      'Beim Schreibtischtest führt man einen Algorithmus gedanklich aus und notiert nach jeder Änderung die Werte aller Variablen in einer Tabelle, der Trace-Tabelle. So findet man Logikfehler und erkennt, was ein Programm tatsächlich berechnet.'),
  ablauf('n-pt-2', 'pl-schreibtischtest', 'Vorgehen',
      'Wer sauber Buch führt, verrechnet sich nicht.',
      [
        'Für jede Variable eine Spalte anlegen, dazu eine für die Bedingung',
        'Startwerte in die erste Zeile eintragen',
        'Anweisung für Anweisung ausführen, jede Änderung in einer neuen Zeile notieren',
        'Bedingungen jedes Mal mit den aktuellen Werten neu prüfen',
        'Bei falscher Schleifenbedingung weiter hinter der Schleife, Ausgabe notieren',
      ]),
  formel('n-pt-3', 'pl-schreibtischtest', 'Das Beispielprogramm',
      'Welchen Wert gibt dieses Programm aus? Im nächsten Schritt steht die Trace-Tabelle.',
      'x ← 1\n'
          'y ← 0\n'
          'SOLANGE x < 5\n'
          '  y ← y + x\n'
          '  x ← x + 2\n'
          'ENDE SOLANGE\n'
          'AUSGABE y'),
  vergleich('n-pt-4', 'pl-schreibtischtest', 'Die Trace-Tabelle',
      'Vor jedem Durchlauf wird x < 5 geprüft. Nach dem zweiten Durchlauf ist x = 5, und 5 < 5 ist falsch. Ausgabe: 4.',
      [
        ['Zeitpunkt', 'y', 'x'],
        ['Start', '0', '1'],
        ['nach Durchlauf 1', '1', '3'],
        ['nach Durchlauf 2', '4', '5'],
        ['5 < 5 falsch -> Ende', '4', '5'],
      ]),
  falle('n-pt-5', 'pl-schreibtischtest', 'Reihenfolge der Zuweisungen',
      'Jede Zuweisung arbeitet mit dem Wert, den die Variable in diesem Moment hat. Der klassische Fehler ist der Tausch ohne Hilfsvariable: Bei a = 3 und b = 7 macht a ← b aus a eine 7, danach macht b ← a aus b ebenfalls eine 7. Die 3 ist verloren.',
      points: [
        'richtig: hilf ← a, a ← b, b ← hilf',
        'Bedingung immer mit den neuen Werten prüfen, nicht mit den Startwerten',
      ],
      merksatz: 'Eine Zeile, eine Änderung, eine neue Tabellenzeile.'),

  // ================================================== Klasse, Objekt, Attribut, Methode
  konzept('n-og-1', 'oo-grundbegriffe', 'Bauplan und Exemplar',
      'Eine Klasse ist der Bauplan: Sie legt fest, welche Eigenschaften und Fähigkeiten alle Objekte dieser Art haben. Ein Objekt ist ein konkretes Exemplar, das nach diesem Bauplan erzeugt wurde - auch Instanz genannt. Aus einer Klasse Ticket entstehen beliebig viele Ticket-Objekte.'),
  vergleich('n-og-2', 'oo-grundbegriffe', 'Die vier Grundbegriffe',
      'Am Beispiel eines Ticketsystems im IT-Support.',
      [
        ['Begriff', 'Bedeutung', 'Beispiel'],
        ['Klasse', 'Bauplan', 'Ticket'],
        ['Objekt', 'konkretes Exemplar', 'Ticket Nr. 4711'],
        ['Attribut', 'Eigenschaft', 'status, prioritaet'],
        ['Methode', 'Fähigkeit, Verhalten', 'schliessen()'],
      ]),
  konzept('n-og-3', 'oo-grundbegriffe', 'Zustand, Verhalten, Identität',
      'Jedes Objekt wird durch drei Merkmale beschrieben.',
      points: [
        'Zustand: die aktuellen Werte seiner Attribute, z. B. status = „offen“',
        'Verhalten: seine Methoden, z. B. schliessen() ändert den Status',
        'Identität: Jedes Objekt ist eigenständig - auch zwei Objekte mit gleichen Werten sind zwei verschiedene Objekte',
      ]),
  formel('n-og-4', 'oo-grundbegriffe', 'Im Code',
      'Die Klasse beschreibt Attribute und Methoden. Mit new entsteht ein Objekt, dessen Methode dann seinen eigenen Zustand ändert.',
      'class Ticket {\n'
          '  int nummer;\n'
          '  String status;\n'
          '\n'
          '  void schliessen() {\n'
          '    status = "geschlossen";\n'
          '  }\n'
          '}\n'
          '\n'
          'Ticket t1 = new Ticket();\n'
          't1.nummer = 4711;\n'
          't1.status = "offen";\n'
          't1.schliessen();\n'
          '// t1.status: "geschlossen"'),
  falle('n-og-5', 'oo-grundbegriffe', 'Klasse ist nicht Objekt',
      'Die Klasse Ticket ist kein Ticket, sondern die Beschreibung aller Tickets. Werte wie „offen“ oder 4711 gehören zu einem Objekt, nicht zur Klasse. Wird t1 geschlossen, bleibt jedes andere Ticket-Objekt unverändert - jedes hat seinen eigenen Zustand.',
      merksatz: 'Klasse = Bauplan, Objekt = Exemplar. Attribute: was es hat. Methoden: was es kann.'),

  // ==================================================== Kapselung und Sichtbarkeit
  konzept('n-ok-1', 'oo-kapselung', 'Das Geheimnisprinzip',
      'Kapselung heißt: Die Daten eines Objekts sind von außen nicht direkt erreichbar. Andere Objekte dürfen nur über öffentliche Methoden zugreifen - die Schnittstelle der Klasse.',
      points: [
        'ungültige Werte werden abgefangen, z. B. ein negativer Lagerbestand',
        'das Innenleben lässt sich ändern, ohne aufrufenden Code anzupassen',
        'Fehler bleiben auf eine Klasse begrenzt',
      ]),
  vergleich('n-ok-2', 'oo-kapselung', 'Sichtbarkeit in UML und Java',
      'Die Zeichen aus dem Klassendiagramm entsprechen Schlüsselwörtern im Code.',
      [
        ['UML', 'Java', 'Zugriff'],
        ['+', 'public', 'von überall'],
        ['-', 'private', 'nur in der eigenen Klasse'],
        ['#', 'protected', 'Paket und Unterklassen'],
        ['~', 'ohne Angabe', 'nur im selben Paket'],
      ]),
  formel('n-ok-3', 'oo-kapselung', 'Getter und Setter mit Prüfung',
      'Das Attribut ist private. Der Getter liest es, der Setter ändert es nur, wenn der neue Wert gültig ist.',
      'class Artikel {\n'
          '  private int bestand;\n'
          '\n'
          '  public int getBestand() {\n'
          '    return bestand;\n'
          '  }\n'
          '\n'
          '  public void setBestand(int b) {\n'
          '    if (b >= 0) {\n'
          '      bestand = b;\n'
          '    }\n'
          '  }\n'
          '}'),
  ablauf('n-ok-4', 'oo-kapselung', 'Durchgespielt',
      'Eine andere Klasse arbeitet mit einem Artikel-Objekt a.',
      [
        'a.setBestand(20) -> gültig, bestand ist 20',
        'a.setBestand(-5) -> abgelehnt, bestand bleibt 20',
        'a.bestand = -5 -> Compilerfehler, das Attribut ist private',
        'a.getBestand() -> liefert 20',
      ]),
  falle('n-ok-5', 'oo-kapselung', 'Setter ohne Prüfung',
      'Wer für jedes Attribut blind Getter und Setter ohne Prüfung anlegt, hat die Kapselung nur zum Schein. Besser sind fachliche Methoden: Ein Konto bietet einzahlen() und abheben() mit Prüfung an statt setKontostand(). Und: private schützt vor falscher Verwendung im Code, es verschlüsselt keine Daten.',
      merksatz: 'Attribute private, Zugriff nur über öffentliche Methoden, die prüfen.'),

  // ======================================================== Objekte erzeugen und nutzen
  konzept('n-oc-1', 'oo-konstruktor', 'Der Konstruktor',
      'Ein Konstruktor wird beim Erzeugen eines Objekts mit new automatisch aufgerufen und setzt die Startwerte der Attribute. So entsteht nie ein halb fertiges Objekt.',
      points: [
        'heißt genau wie die Klasse',
        'hat keinen Rückgabetyp, auch nicht void',
        'kann Parameter haben',
      ]),
  formel('n-oc-2', 'oo-konstruktor', 'Ein Objekt erzeugen',
      'Der Konstruktor übernimmt die Werte aus dem Aufruf. Nach der letzten Zeile existiert ein Kunde-Objekt mit dem Namen „Yilmaz“ und der Nummer 1001.',
      'class Kunde {\n'
          '  private String name;\n'
          '  private int kundenNr;\n'
          '\n'
          '  public Kunde(String n, int nr) {\n'
          '    name = n;\n'
          '    kundenNr = nr;\n'
          '  }\n'
          '}\n'
          '\n'
          'Kunde k = new Kunde("Yilmaz", 1001);'),
  vergleich('n-oc-3', 'oo-konstruktor', 'Konstruktoren überladen',
      'Eine Klasse kann mehrere Konstruktoren haben, wenn sich ihre Parameterlisten in Anzahl, Typ oder Reihenfolge der Typen unterscheiden. Welcher aufgerufen wird, entscheiden die Argumente.',
      [
        ['Konstruktor', 'passender Aufruf'],
        ['Kunde()', 'new Kunde()'],
        ['Kunde(String n)', 'new Kunde("Meier")'],
        ['Kunde(String n, int nr)', 'new Kunde("Meier", 1002)'],
      ],
      merksatz: 'Schreibt man keinen Konstruktor, legt Java automatisch einen parameterlosen Standardkonstruktor an - aber nur dann.'),
  konzept('n-oc-4', 'oo-konstruktor', 'Variablen speichern Referenzen',
      'Eine Objektvariable enthält nicht das Objekt selbst, sondern einen Verweis darauf. Nach Kunde b = k; zeigen b und k auf dasselbe Objekt - eine Änderung über b ist auch über k sichtbar. Ein neues Objekt entsteht nur mit new.'),
  ablauf('n-oc-5', 'oo-konstruktor', 'Objekte schicken sich Nachrichten',
      'Objekte arbeiten zusammen, indem sie Methoden anderer Objekte aufrufen. Dafür brauchen sie eine Referenz auf das andere Objekt. Beispiel Webshop:',
      [
        'Der Kunde löst warenkorb.bestellen() aus',
        'Der Warenkorb ruft lager.reservieren(artikel, 2) auf',
        'Das Lager prüft den Bestand und antwortet mit true',
        'Der Warenkorb erzeugt new Rechnung(kunde, summe)',
      ]),
  falle('n-oc-6', 'oo-konstruktor', 'Typische Konstruktor-Fehler',
      'Steht void vor dem Namen, ist es kein Konstruktor mehr, sondern eine gewöhnliche Methode - sie läuft bei new nicht mit. Überladen geht nur über die Parameterliste: Kunde(String name) und Kunde(String vorname) haben dieselbe Signatur und sind nicht erlaubt.',
      merksatz: 'Name wie die Klasse, kein Rückgabetyp, Aufruf über new.'),
];
