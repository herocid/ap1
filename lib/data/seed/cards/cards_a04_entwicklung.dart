import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 04, Teil 1: Anforderungen, UML, Programmierlogik
/// und Objektorientierung.
final List<Flashcard> cardsA04Entwicklung = [
  // Lastenheft und Pflichtenheft
  karte(
    'k-ld-1',
    'af-dokumente',
    'Lastenheft',
    'Vom Auftraggeber erstellt: beschreibt lösungsneutral, was und wofür gebraucht wird.',
  ),
  karte(
    'k-ld-2',
    'af-dokumente',
    'Pflichtenheft',
    'Vom Auftragnehmer erstellt: beschreibt, wie und womit die Anforderungen umgesetzt werden.',
  ),
  karte(
    'k-ld-3',
    'af-dokumente',
    'Wogegen wird abgenommen?',
    'Gegen das vom Auftraggeber genehmigte Pflichtenheft.',
  ),
  karte(
    'k-ld-4',
    'af-dokumente',
    'Wann entsteht das Pflichtenheft?',
    'Nach der Vergabe - erst dann steht fest, welcher Auftragnehmer es schreibt.',
  ),
  karte(
    'k-ld-5',
    'af-dokumente',
    'Inhalt Lastenheft',
    'Ist-Zustand, Ziele, funktionale und nicht-funktionale Anforderungen, Rahmenbedingungen, Lieferumfang.',
  ),
  karte(
    'k-ld-6',
    'af-dokumente',
    'Inhalt Pflichtenheft',
    'Konkretisierte Anforderungen plus Lösungskonzept, Architektur, Technologien, Schnittstellen, Testfälle, Zeitplan.',
  ),
  karte(
    'k-ld-7',
    'af-dokumente',
    'Ist-Analyse vs. Soll-Konzept',
    'Ist: Wie läuft es heute, wo sind Schwachstellen? Soll: Wie soll es künftig laufen?',
  ),
  karte(
    'k-ld-8',
    'af-dokumente',
    'Änderung nach Genehmigung des Pflichtenhefts',
    'Über einen Änderungsantrag (Change Request) mit Folgen für Kosten und Termine.',
  ),

  // Arten von Anforderungen
  karte(
    'k-fa-1',
    'af-arten',
    'Funktionale Anforderung',
    'Beschreibt, was das System tut, z. B. „Rechnung als PDF erzeugen“.',
  ),
  karte(
    'k-fa-2',
    'af-arten',
    'Nicht-funktionale Anforderung',
    'Beschreibt, wie gut oder unter welchen Bedingungen das System arbeitet, z. B. Antwortzeit, Verfügbarkeit.',
  ),
  karte(
    'k-fa-3',
    'af-arten',
    'Beispiele nicht-funktional',
    'Leistung, Zuverlässigkeit, Benutzbarkeit, Sicherheit, Wartbarkeit, Übertragbarkeit, Randbedingungen.',
  ),
  karte(
    'k-fa-4',
    'af-arten',
    '„Das System soll schnell sein.“',
    'Nicht prüfbar. Besser: „95 % der Anfragen in höchstens 2 Sekunden.“',
  ),
  karte(
    'k-fa-5',
    'af-arten',
    'Randbedingung',
    'Vorgabe von außen, die den Lösungsraum einschränkt: Gesetze, vorhandene Technik, Budget, Termine.',
  ),
  karte(
    'k-fa-6',
    'af-arten',
    'Ausfallzeit bei 99,5 % Verfügbarkeit',
    '8.760 h × 0,005 = 43,8 Stunden pro Jahr.',
  ),
  karte(
    'k-fa-7',
    'af-arten',
    'Funktional oder nicht? „Anmelden mit zweitem Faktor“',
    'Funktional - es beschreibt eine Tätigkeit des Systems, auch wenn es um Sicherheit geht.',
  ),

  // Anforderungen erheben
  karte(
    'k-fe-1',
    'af-erhebung',
    'Interview',
    'Einzelgespräch mit Rückfragen - viel Tiefe, aber zeitaufwendig und nur für wenige Personen.',
  ),
  karte(
    'k-fe-2',
    'af-erhebung',
    'Fragebogen',
    'Erreicht viele Personen und ist gut auswertbar, erlaubt aber keine Rückfragen.',
  ),
  karte(
    'k-fe-3',
    'af-erhebung',
    'Beobachtung',
    'Zeigt echte Arbeitsabläufe und unbewusste Handgriffe, die im Gespräch nicht genannt werden.',
  ),
  karte(
    'k-fe-4',
    'af-erhebung',
    'MoSCoW',
    'Must have, Should have, Could have, Won’t have (this time) - Priorisierung von Anforderungen.',
  ),
  karte(
    'k-fe-5',
    'af-erhebung',
    'Merkmale guter Anforderungen',
    'Eindeutig, vollständig, widerspruchsfrei, prüfbar, notwendig, realisierbar.',
  ),
  karte(
    'k-fe-6',
    'af-erhebung',
    'Aufbau einer User Story',
    'Als <Rolle> möchte ich <Funktion>, damit <Nutzen>. Dazu Akzeptanzkriterien.',
  ),
  karte(
    'k-fe-7',
    'af-erhebung',
    'Workshop',
    'Mehrere Stakeholder erarbeiten gemeinsam Anforderungen und klären Konflikte - braucht Moderation.',
  ),
  karte(
    'k-fe-8',
    'af-erhebung',
    'Stakeholder',
    'Alle, die vom System betroffen sind oder es beeinflussen: Anwender, Auftraggeber, IT-Betrieb, Datenschutz, Betriebsrat.',
  ),

  // Anwendungsfalldiagramm
  karte(
    'k-uu-1',
    'u-usecase',
    'Akteur',
    'Rolle oder externes System außerhalb der Systemgrenze, das mit dem System interagiert.',
  ),
  karte(
    'k-uu-2',
    'u-usecase',
    'Systemgrenze',
    'Rechteck mit Systemnamen, das alle Anwendungsfälle umschließt. Akteure stehen außerhalb.',
  ),
  karte(
    'k-uu-3',
    'u-usecase',
    '«include»',
    'Der eingebundene Fall wird immer ausgeführt. Pfeil vom Basisfall zum inkludierten Fall.',
  ),
  karte(
    'k-uu-4',
    'u-usecase',
    '«extend»',
    'Erweitert den Basisfall nur unter einer Bedingung. Pfeil vom erweiternden Fall zum Basisfall.',
  ),
  karte(
    'k-uu-5',
    'u-usecase',
    'Anwendungsfall benennen',
    'Verb + Objekt aus Sicht des Akteurs, z. B. „Termin buchen“. Symbol: Ellipse.',
  ),
  karte(
    'k-uu-6',
    'u-usecase',
    'Zeigt das Use-Case-Diagramm eine Reihenfolge?',
    'Nein. Es zeigt nur, wer welche Leistung nutzt. Abläufe zeigt das Aktivitätsdiagramm.',
  ),
  karte(
    'k-uu-7',
    'u-usecase',
    'Ist die eigene Datenbank ein Akteur?',
    'Nein - sie ist Teil des Systems. Akteure sind nur Rollen und externe Systeme.',
  ),

  // Klassendiagramm
  karte(
    'k-uk-1',
    'u-klassen',
    'Sichtbarkeiten in UML',
    '+ public, - private, # protected, ~ package.',
  ),
  karte(
    'k-uk-2',
    'u-klassen',
    'Multiplizität 1..*',
    'Mindestens ein Objekt, nach oben offen.',
  ),
  karte(
    'k-uk-3',
    'u-klassen',
    'Aggregation',
    'Leere Raute am Ganzen - das Teil kann ohne das Ganze existieren (Abteilung - Mitarbeiter).',
  ),
  karte(
    'k-uk-4',
    'u-klassen',
    'Komposition',
    'Gefüllte Raute am Ganzen - das Teil existiert nur mit dem Ganzen (Rechnung - Position).',
  ),
  karte(
    'k-uk-5',
    'u-klassen',
    'Aufbau einer Klasse',
    'Drei Abschnitte: Klassenname, Attribute, Methoden.',
  ),
  karte(
    'k-uk-6',
    'u-klassen',
    'Methode in UML-Schreibweise',
    'Sichtbarkeit Name(parameter: Typ): Rückgabetyp, z. B. + setMenge(m: int): void.',
  ),
  karte(
    'k-uk-7',
    'u-klassen',
    'Wo steht die Multiplizität?',
    'Am anderen Ende der Linie: Kunde 1 --- 0..* Bestellung heißt „ein Kunde hat 0..* Bestellungen“.',
  ),
  karte(
    'k-uk-8',
    'u-klassen',
    'Gerichtete Assoziation',
    'Linie mit offener Pfeilspitze: Nur die Klasse am Linienanfang kennt die Klasse, auf die der Pfeil zeigt.',
  ),

  // Aktivitätsdiagramm
  karte(
    'k-ua-1',
    'u-aktivitaet',
    'Start- und Endknoten',
    'Start: gefüllter Kreis. Ende: gefüllter Kreis mit Ring.',
  ),
  karte(
    'k-ua-2',
    'u-aktivitaet',
    'Entscheidung',
    'Raute mit einem Eingang und mehreren Ausgängen - genau ein Weg, gesteuert über Guards [ ].',
  ),
  karte(
    'k-ua-3',
    'u-aktivitaet',
    'Gabelung und Vereinigung',
    'Balken: Fork startet parallele Wege, Join wartet, bis alle angekommen sind.',
  ),
  karte(
    'k-ua-4',
    'u-aktivitaet',
    'Swimlane',
    'Aktivitätsbereich je Rolle oder Abteilung - zeigt, wer eine Aktion ausführt.',
  ),
  karte(
    'k-ua-5',
    'u-aktivitaet',
    'Guard',
    'Bedingung in eckigen Klammern an einer Kante, z. B. [Betrag > 500]. Guards schließen sich aus und decken alle Fälle ab.',
  ),
  karte(
    'k-ua-6',
    'u-aktivitaet',
    'Ablaufende',
    'Kreis mit X: beendet nur diesen einen Weg, nicht die ganze Aktivität.',
  ),
  karte(
    'k-ua-7',
    'u-aktivitaet',
    'Schleife im Aktivitätsdiagramm',
    'Entscheidung mit einer Kante zurück vor eine frühere Aktion.',
  ),

  // Variablen und Datentypen
  karte(
    'k-pd-1',
    'pl-datentypen',
    'Wertebereich 8 Bit mit Vorzeichen',
    '-128 bis 127, insgesamt 2^8 = 256 Werte.',
  ),
  karte(
    'k-pd-2',
    'pl-datentypen',
    'Datentyp für eine PLZ',
    'String - keine Rechnung, und die führende Null bleibt erhalten.',
  ),
  karte(
    'k-pd-3',
    'pl-datentypen',
    'Cast',
    'Ausdrückliche Typumwandlung, z. B. (int) 9.99 ergibt 9 - abgeschnitten, nicht gerundet.',
  ),
  karte(
    'k-pd-4',
    'pl-datentypen',
    'Geldbeträge speichern',
    'Nicht als float/double. Besser Dezimaltyp (BigDecimal) oder ganze Cent als Ganzzahl.',
  ),
  karte(
    'k-pd-5',
    'pl-datentypen',
    'char vs. String',
    'char: genau ein Zeichen wie \'A\'. String: Zeichenkette beliebiger Länge.',
  ),
  karte(
    'k-pd-6',
    'pl-datentypen',
    '17 / 5 und 17 % 5 (int)',
    '17 / 5 = 3 (Ganzzahldivision), 17 % 5 = 2 (Rest).',
  ),
  karte(
    'k-pd-7',
    'pl-datentypen',
    'Größen in Java',
    'byte 8, short 16, int 32, long 64, float 32, double 64, char 16 Bit.',
  ),
  karte(
    'k-pd-8',
    'pl-datentypen',
    'Überlauf',
    'Der Wertebereich wird überschritten, die Zahl springt ans andere Ende: byte 127 + 1 = -128.',
  ),

  // Kontrollstrukturen
  karte(
    'k-pk-1',
    'pl-kontrollstrukturen',
    'Kopfgesteuerte Schleife',
    'Prüft vor jedem Durchlauf (while) - läuft eventuell gar nicht.',
  ),
  karte(
    'k-pk-2',
    'pl-kontrollstrukturen',
    'Fußgesteuerte Schleife',
    'Prüft nach jedem Durchlauf (do-while) - läuft mindestens einmal.',
  ),
  karte(
    'k-pk-3',
    'pl-kontrollstrukturen',
    'switch / case',
    'Mehrfachauswahl anhand eines Wertes. In Java beendet break den jeweiligen Fall.',
  ),
  karte(
    'k-pk-4',
    'pl-kontrollstrukturen',
    'Endlosschleife',
    'Die Bedingung wird nie falsch, z. B. weil der Zähler im Rumpf nicht verändert wird.',
  ),
  karte(
    'k-pk-5',
    'pl-kontrollstrukturen',
    'Rangfolge logischer Operatoren',
    'NICHT vor UND vor ODER - im Zweifel Klammern setzen.',
  ),
  karte(
    'k-pk-6',
    'pl-kontrollstrukturen',
    'a ODER b',
    'Wahr, wenn mindestens eine Seite wahr ist - also auch, wenn beide wahr sind.',
  ),
  karte(
    'k-pk-7',
    'pl-kontrollstrukturen',
    'WIEDERHOLE … BIS vs. do-while',
    'BIS nennt die Abbruchbedingung, while die Laufbedingung - beim Übersetzen umkehren.',
  ),
  karte(
    'k-pk-8',
    'pl-kontrollstrukturen',
    '= und ==',
    '= weist einen Wert zu, == vergleicht zwei Werte.',
  ),

  // Pseudocode
  karte(
    'k-pc-1',
    'pl-pseudocode',
    'x ← 5',
    'Zuweisung: Die Variable x erhält den Wert 5.',
  ),
  karte(
    'k-pc-2',
    'pl-pseudocode',
    'Indizes bei n Elementen',
    'Beginnt der Index bei 0, laufen die Indizes von 0 bis n - 1.',
  ),
  karte(
    'k-pc-3',
    'pl-pseudocode',
    'Startwert beim Maximum',
    'Das erste Element des Arrays - nicht 0, sonst scheitert es an negativen Werten.',
  ),
  karte(
    'k-pc-4',
    'pl-pseudocode',
    'Lineare Suche',
    'Durchläuft die Liste von vorn, bis der Wert gefunden ist. Nicht gefunden: -1.',
  ),
  karte(
    'k-pc-5',
    'pl-pseudocode',
    'Parameter vs. Argument',
    'Parameter: Platzhalter in der Funktionsdefinition. Argument: konkreter Wert beim Aufruf.',
  ),
  karte(
    'k-pc-6',
    'pl-pseudocode',
    'Zählen mit Bedingung',
    'Zähler mit 0 starten und nur im Dann-Zweig um 1 erhöhen.',
  ),
  karte(
    'k-pc-7',
    'pl-pseudocode',
    'Bubblesort',
    'Vergleicht benachbarte Elemente und tauscht sie bei falscher Reihenfolge - je Durchlauf wandert das größte nach hinten.',
  ),

  // Schreibtischtest
  karte(
    'k-pt-1',
    'pl-schreibtischtest',
    'Schreibtischtest',
    'Algorithmus gedanklich ausführen und alle Variablenwerte Schritt für Schritt notieren.',
  ),
  karte(
    'k-pt-2',
    'pl-schreibtischtest',
    'Trace-Tabelle',
    'Tabelle mit einer Spalte je Variable und einer Zeile je Änderung.',
  ),
  karte(
    'k-pt-3',
    'pl-schreibtischtest',
    'Werte tauschen',
    'Nur mit Hilfsvariable: hilf ← a, a ← b, b ← hilf.',
  ),
  karte(
    'k-pt-4',
    'pl-schreibtischtest',
    'Wann ist eine SOLANGE-Schleife zu Ende?',
    'Sobald die Bedingung vor einem Durchlauf mit den aktuellen Werten falsch ist.',
  ),
  karte(
    'k-pt-5',
    'pl-schreibtischtest',
    'Startwert für ein Produkt',
    '1 - mit 0 bliebe jedes Produkt 0 (z. B. bei der Fakultät).',
  ),
  karte(
    'k-pt-6',
    'pl-schreibtischtest',
    'zahl MOD 10 und zahl DIV 10',
    'MOD 10 liefert die letzte Ziffer, DIV 10 schneidet sie ab - Grundlage der Quersumme.',
  ),
  karte(
    'k-pt-7',
    'pl-schreibtischtest',
    'Durchläufe verschachtelter Zählschleifen',
    'Bei festen Grenzen: äußere mal innere Anzahl, z. B. 3 × 4 = 12.',
  ),

  // Grundbegriffe OOP
  karte(
    'k-og-1',
    'oo-grundbegriffe',
    'Klasse',
    'Bauplan, der Attribute und Methoden für alle Objekte dieser Art festlegt.',
  ),
  karte(
    'k-og-2',
    'oo-grundbegriffe',
    'Objekt',
    'Konkretes Exemplar (Instanz) einer Klasse mit eigenen Attributwerten.',
  ),
  karte(
    'k-og-3',
    'oo-grundbegriffe',
    'Zustand eines Objekts',
    'Die aktuellen Werte seiner Attribute.',
  ),
  karte(
    'k-og-4',
    'oo-grundbegriffe',
    'Identität eines Objekts',
    'Jedes Objekt ist eigenständig - auch bei gleichen Attributwerten.',
  ),
  karte(
    'k-og-5',
    'oo-grundbegriffe',
    'Signatur einer Methode',
    'Methodenname plus Parameterliste (Anzahl, Typen, Reihenfolge).',
  ),
  karte(
    'k-og-6',
    'oo-grundbegriffe',
    'Abstraktion',
    'Die Klasse bildet nur die Eigenschaften ab, die die Anwendung wirklich braucht.',
  ),
  karte(
    'k-og-7',
    'oo-grundbegriffe',
    'Alter speichern?',
    'Nein - Geburtsdatum speichern, Alter per Methode getAlter() berechnen.',
  ),

  // Kapselung
  karte(
    'k-ok-1',
    'oo-kapselung',
    'Kapselung',
    'Daten sind private und nur über öffentliche Methoden erreichbar (Geheimnisprinzip).',
  ),
  karte(
    'k-ok-2',
    'oo-kapselung',
    'Getter',
    'Öffentliche Methode, die den Wert eines privaten Attributs zurückgibt.',
  ),
  karte(
    'k-ok-3',
    'oo-kapselung',
    'Setter',
    'Öffentliche Methode, die ein privates Attribut ändert - idealerweise nach einer Prüfung.',
  ),
  karte(
    'k-ok-4',
    'oo-kapselung',
    'Warum Attribute private?',
    'Damit niemand ungültige Werte setzt und das Innenleben änderbar bleibt.',
  ),
  karte(
    'k-ok-5',
    'oo-kapselung',
    'Getter für boolean',
    'Üblich mit is: isAktiv(): boolean.',
  ),
  karte(
    'k-ok-6',
    'oo-kapselung',
    'Nur-lesbares Attribut',
    'Wird im Konstruktor gesetzt und hat nur einen Getter, keinen Setter - z. B. kontoNr.',
  ),
  karte(
    'k-ok-7',
    'oo-kapselung',
    'Fachliche Methode statt Setter',
    'z. B. einzahlen()/abheben() statt setKontostand() - mit Prüfung der Werte.',
  ),

  // Konstruktor
  karte(
    'k-oc-1',
    'oo-konstruktor',
    'Konstruktor',
    'Wird bei new aufgerufen, initialisiert die Attribute. Name wie die Klasse, kein Rückgabetyp.',
  ),
  karte(
    'k-oc-2',
    'oo-konstruktor',
    'Überladen',
    'Mehrere Konstruktoren mit gleichem Namen, aber unterschiedlicher Parameterliste.',
  ),
  karte(
    'k-oc-3',
    'oo-konstruktor',
    'Referenz',
    'Verweis auf ein Objekt. b = a kopiert nur den Verweis, nicht das Objekt.',
  ),
  karte(
    'k-oc-4',
    'oo-konstruktor',
    'Nachricht',
    'Aufruf einer Methode eines anderen Objekts, z. B. lager.reservieren(artikel, 2).',
  ),
  karte(
    'k-oc-5',
    'oo-konstruktor',
    'Standardkonstruktor',
    'Parameterloser Konstruktor, den Java nur anlegt, wenn die Klasse keinen eigenen hat.',
  ),
  karte(
    'k-oc-6',
    'oo-konstruktor',
    'this',
    'Verweis auf das aktuelle Objekt: this.name = name; unterscheidet Attribut und Parameter.',
  ),
  karte(
    'k-oc-7',
    'oo-konstruktor',
    'static (Klassenattribut)',
    'Existiert nur einmal für alle Objekte der Klasse, in UML unterstrichen.',
  ),
  karte(
    'k-oc-8',
    'oo-konstruktor',
    'Multiplizität * im Code',
    'Wird zu einem Array oder einer Liste, z. B. ArrayList<Position>.',
  ),
];
