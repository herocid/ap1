import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 04, Teil 1: Anforderungen, UML, Programmierlogik
/// und Objektorientierung.
final List<Flashcard> cardsA04Entwicklung = [
  // Lastenheft und Pflichtenheft
  karte('k-ld-1', 'af-dokumente', 'Lastenheft',
      'Vom Auftraggeber erstellt: beschreibt lösungsneutral, was und wofür gebraucht wird.'),
  karte('k-ld-2', 'af-dokumente', 'Pflichtenheft',
      'Vom Auftragnehmer erstellt: beschreibt, wie und womit die Anforderungen umgesetzt werden.'),
  karte('k-ld-3', 'af-dokumente', 'Wogegen wird abgenommen?',
      'Gegen das vom Auftraggeber genehmigte Pflichtenheft.'),
  karte('k-ld-4', 'af-dokumente', 'Wann entsteht das Pflichtenheft?',
      'Nach der Vergabe - erst dann steht fest, welcher Auftragnehmer es schreibt.'),

  // Arten von Anforderungen
  karte('k-fa-1', 'af-arten', 'Funktionale Anforderung',
      'Beschreibt, was das System tut, z. B. „Rechnung als PDF erzeugen“.'),
  karte('k-fa-2', 'af-arten', 'Nicht-funktionale Anforderung',
      'Beschreibt, wie gut oder unter welchen Bedingungen das System arbeitet, z. B. Antwortzeit, Verfügbarkeit.'),
  karte('k-fa-3', 'af-arten', 'Beispiele nicht-funktional',
      'Leistung, Zuverlässigkeit, Benutzbarkeit, Sicherheit, Wartbarkeit, Übertragbarkeit, Randbedingungen.'),
  karte('k-fa-4', 'af-arten', '„Das System soll schnell sein.“',
      'Nicht prüfbar. Besser: „95 % der Anfragen in höchstens 2 Sekunden.“'),

  // Anforderungen erheben
  karte('k-fe-1', 'af-erhebung', 'Interview',
      'Einzelgespräch mit Rückfragen - viel Tiefe, aber zeitaufwendig und nur für wenige Personen.'),
  karte('k-fe-2', 'af-erhebung', 'Fragebogen',
      'Erreicht viele Personen und ist gut auswertbar, erlaubt aber keine Rückfragen.'),
  karte('k-fe-3', 'af-erhebung', 'Beobachtung',
      'Zeigt echte Arbeitsabläufe und unbewusste Handgriffe, die im Gespräch nicht genannt werden.'),
  karte('k-fe-4', 'af-erhebung', 'MoSCoW',
      'Must have, Should have, Could have, Won’t have (this time) - Priorisierung von Anforderungen.'),
  karte('k-fe-5', 'af-erhebung', 'Merkmale guter Anforderungen',
      'Eindeutig, vollständig, widerspruchsfrei, prüfbar, notwendig, realisierbar.'),

  // Anwendungsfalldiagramm
  karte('k-uu-1', 'u-usecase', 'Akteur',
      'Rolle oder externes System außerhalb der Systemgrenze, das mit dem System interagiert.'),
  karte('k-uu-2', 'u-usecase', 'Systemgrenze',
      'Rechteck mit Systemnamen, das alle Anwendungsfälle umschließt. Akteure stehen außerhalb.'),
  karte('k-uu-3', 'u-usecase', '«include»',
      'Der eingebundene Fall wird immer ausgeführt. Pfeil vom Basisfall zum inkludierten Fall.'),
  karte('k-uu-4', 'u-usecase', '«extend»',
      'Erweitert den Basisfall nur unter einer Bedingung. Pfeil vom erweiternden Fall zum Basisfall.'),

  // Klassendiagramm
  karte('k-uk-1', 'u-klassen', 'Sichtbarkeiten in UML',
      '+ public, - private, # protected, ~ package.'),
  karte('k-uk-2', 'u-klassen', 'Multiplizität 1..*',
      'Mindestens ein Objekt, nach oben offen.'),
  karte('k-uk-3', 'u-klassen', 'Aggregation',
      'Leere Raute am Ganzen - das Teil kann ohne das Ganze existieren (Abteilung - Mitarbeiter).'),
  karte('k-uk-4', 'u-klassen', 'Komposition',
      'Gefüllte Raute am Ganzen - das Teil existiert nur mit dem Ganzen (Rechnung - Position).'),
  karte('k-uk-5', 'u-klassen', 'Aufbau einer Klasse',
      'Drei Abschnitte: Klassenname, Attribute, Methoden.'),

  // Aktivitätsdiagramm
  karte('k-ua-1', 'u-aktivitaet', 'Start- und Endknoten',
      'Start: gefüllter Kreis. Ende: gefüllter Kreis mit Ring.'),
  karte('k-ua-2', 'u-aktivitaet', 'Entscheidung',
      'Raute mit einem Eingang und mehreren Ausgängen - genau ein Weg, gesteuert über Guards [ ].'),
  karte('k-ua-3', 'u-aktivitaet', 'Gabelung und Vereinigung',
      'Balken: Fork startet parallele Wege, Join wartet, bis alle angekommen sind.'),
  karte('k-ua-4', 'u-aktivitaet', 'Swimlane',
      'Aktivitätsbereich je Rolle oder Abteilung - zeigt, wer eine Aktion ausführt.'),

  // Variablen und Datentypen
  karte('k-pd-1', 'pl-datentypen', 'Wertebereich 8 Bit mit Vorzeichen',
      '-128 bis 127, insgesamt 2^8 = 256 Werte.'),
  karte('k-pd-2', 'pl-datentypen', 'Datentyp für eine PLZ',
      'String - keine Rechnung, und die führende Null bleibt erhalten.'),
  karte('k-pd-3', 'pl-datentypen', 'Cast',
      'Ausdrückliche Typumwandlung, z. B. (int) 9.99 ergibt 9 - abgeschnitten, nicht gerundet.'),
  karte('k-pd-4', 'pl-datentypen', 'Geldbeträge speichern',
      'Nicht als float/double. Besser Dezimaltyp (BigDecimal) oder ganze Cent als Ganzzahl.'),
  karte('k-pd-5', 'pl-datentypen', 'char vs. String',
      'char: genau ein Zeichen wie \'A\'. String: Zeichenkette beliebiger Länge.'),

  // Kontrollstrukturen
  karte('k-pk-1', 'pl-kontrollstrukturen', 'Kopfgesteuerte Schleife',
      'Prüft vor jedem Durchlauf (while) - läuft eventuell gar nicht.'),
  karte('k-pk-2', 'pl-kontrollstrukturen', 'Fußgesteuerte Schleife',
      'Prüft nach jedem Durchlauf (do-while) - läuft mindestens einmal.'),
  karte('k-pk-3', 'pl-kontrollstrukturen', 'switch / case',
      'Mehrfachauswahl anhand eines Wertes. In Java beendet break den jeweiligen Fall.'),
  karte('k-pk-4', 'pl-kontrollstrukturen', 'Endlosschleife',
      'Die Bedingung wird nie falsch, z. B. weil der Zähler im Rumpf nicht verändert wird.'),

  // Pseudocode
  karte('k-pc-1', 'pl-pseudocode', 'x ← 5',
      'Zuweisung: Die Variable x erhält den Wert 5.'),
  karte('k-pc-2', 'pl-pseudocode', 'Indizes bei n Elementen',
      'Beginnt der Index bei 0, laufen die Indizes von 0 bis n - 1.'),
  karte('k-pc-3', 'pl-pseudocode', 'Startwert beim Maximum',
      'Das erste Element des Arrays - nicht 0, sonst scheitert es an negativen Werten.'),
  karte('k-pc-4', 'pl-pseudocode', 'Lineare Suche',
      'Durchläuft die Liste von vorn, bis der Wert gefunden ist. Nicht gefunden: -1.'),

  // Schreibtischtest
  karte('k-pt-1', 'pl-schreibtischtest', 'Schreibtischtest',
      'Algorithmus gedanklich ausführen und alle Variablenwerte Schritt für Schritt notieren.'),
  karte('k-pt-2', 'pl-schreibtischtest', 'Trace-Tabelle',
      'Tabelle mit einer Spalte je Variable und einer Zeile je Änderung.'),
  karte('k-pt-3', 'pl-schreibtischtest', 'Werte tauschen',
      'Nur mit Hilfsvariable: hilf ← a, a ← b, b ← hilf.'),
  karte('k-pt-4', 'pl-schreibtischtest', 'Wann ist eine SOLANGE-Schleife zu Ende?',
      'Sobald die Bedingung vor einem Durchlauf mit den aktuellen Werten falsch ist.'),

  // Grundbegriffe OOP
  karte('k-og-1', 'oo-grundbegriffe', 'Klasse',
      'Bauplan, der Attribute und Methoden für alle Objekte dieser Art festlegt.'),
  karte('k-og-2', 'oo-grundbegriffe', 'Objekt',
      'Konkretes Exemplar (Instanz) einer Klasse mit eigenen Attributwerten.'),
  karte('k-og-3', 'oo-grundbegriffe', 'Zustand eines Objekts',
      'Die aktuellen Werte seiner Attribute.'),
  karte('k-og-4', 'oo-grundbegriffe', 'Identität eines Objekts',
      'Jedes Objekt ist eigenständig - auch bei gleichen Attributwerten.'),

  // Kapselung
  karte('k-ok-1', 'oo-kapselung', 'Kapselung',
      'Daten sind private und nur über öffentliche Methoden erreichbar (Geheimnisprinzip).'),
  karte('k-ok-2', 'oo-kapselung', 'Getter',
      'Öffentliche Methode, die den Wert eines privaten Attributs zurückgibt.'),
  karte('k-ok-3', 'oo-kapselung', 'Setter',
      'Öffentliche Methode, die ein privates Attribut ändert - idealerweise nach einer Prüfung.'),
  karte('k-ok-4', 'oo-kapselung', 'Warum Attribute private?',
      'Damit niemand ungültige Werte setzt und das Innenleben änderbar bleibt.'),

  // Konstruktor
  karte('k-oc-1', 'oo-konstruktor', 'Konstruktor',
      'Wird bei new aufgerufen, initialisiert die Attribute. Name wie die Klasse, kein Rückgabetyp.'),
  karte('k-oc-2', 'oo-konstruktor', 'Überladen',
      'Mehrere Konstruktoren mit gleichem Namen, aber unterschiedlicher Parameterliste.'),
  karte('k-oc-3', 'oo-konstruktor', 'Referenz',
      'Verweis auf ein Objekt. b = a kopiert nur den Verweis, nicht das Objekt.'),
  karte('k-oc-4', 'oo-konstruktor', 'Nachricht',
      'Aufruf einer Methode eines anderen Objekts, z. B. lager.reservieren(artikel, 2).'),
  karte('k-oc-5', 'oo-konstruktor', 'Standardkonstruktor',
      'Parameterloser Konstruktor, den Java nur anlegt, wenn die Klasse keinen eigenen hat.'),
];
