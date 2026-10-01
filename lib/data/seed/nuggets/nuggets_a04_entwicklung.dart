import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 04, Teil 1: Anforderungen, UML, Programmierlogik
/// und Objektorientierung.
final List<Nugget> nuggetsA04Entwicklung = [
  // ================================================ Lastenheft und Pflichtenheft
  konzept(
    'n-ld-1',
    'af-dokumente',
    'Zwei Dokumente, zwei Rollen',
    'Bevor ein Dienstleister Software baut, muss klar sein, was gebraucht wird und wie es umgesetzt wird. Dafür gibt es zwei Dokumente: Das Lastenheft schreibt der Auftraggeber, das Pflichtenheft der Auftragnehmer.',
    points: [
      'Auftraggeber (AG): der Kunde, der etwas braucht und bezahlt',
      'Auftragnehmer (AN): der Dienstleister, der die Lösung liefert',
      'Lastenheft und Pflichtenheft sind in der DIN 69901-5 definiert',
    ],
    merksatz: 'Lastenheft: Was und wofür? Pflichtenheft: Wie und womit?',
  ),
  vergleich(
    'n-ld-2',
    'af-dokumente',
    'Lastenheft oder Pflichtenheft?',
    'Die beiden Dokumente unterscheiden sich in Verfasser, Inhalt und Zeitpunkt. Diese Tabelle ist die häufigste Prüfungsfrage zum Thema.',
    [
      ['', 'Lastenheft', 'Pflichtenheft'],
      ['Verfasser', 'Auftraggeber', 'Auftragnehmer'],
      ['Frage', 'Was und wofür?', 'Wie und womit?'],
      ['Sicht', 'fachlich, lösungsneutral', 'technisch, konkret'],
      ['Zeitpunkt', 'vor der Ausschreibung', 'nach der Vergabe'],
      ['Dient als', 'Basis für Angebote', 'Basis für die Abnahme'],
    ],
  ),
  vergleich(
    'n-ld-3',
    'af-dokumente',
    'Ist-Analyse und Soll-Konzept',
    'Ein Lastenheft beginnt meist mit einer Bestandsaufnahme. Aus den Schwachstellen des Ist-Zustands ergeben sich die Ziele des Soll-Zustands.',
    [
      ['', 'Ist-Analyse', 'Soll-Konzept'],
      ['Frage', 'Wie läuft es heute?', 'Wie soll es laufen?'],
      ['Inhalt', 'Abläufe, Systeme, Schwachstellen', 'Ziele, Anforderungen'],
      ['Beispiel', 'Termine nur per Telefon', 'Online-Buchung rund um die Uhr'],
    ],
  ),
  konzept(
    'n-ld-4',
    'af-dokumente',
    'Was im Lastenheft steht',
    'Das Lastenheft beschreibt das Problem und die Anforderungen aus Sicht des Kunden, ohne technische Lösung. So können mehrere Anbieter vergleichbare Angebote abgeben.',
    points: [
      'Ausgangssituation (Ist-Zustand) und Zielsetzung (Soll-Zustand)',
      'Produkteinsatz: Wer nutzt das System wofür?',
      'funktionale Anforderungen',
      'nicht-funktionale Anforderungen wie Antwortzeit oder Verfügbarkeit',
      'Rahmenbedingungen: Budget, Termine, Gesetze wie die DSGVO',
      'Lieferumfang und Abnahmekriterien aus Kundensicht',
    ],
  ),
  konzept(
    'n-ld-5',
    'af-dokumente',
    'Was im Pflichtenheft steht',
    'Das Pflichtenheft übernimmt die Anforderungen aus dem Lastenheft, präzisiert sie und ergänzt, wie sie technisch erfüllt werden. Nach der Genehmigung durch den Auftraggeber wird es Teil des Vertrags.',
    points: [
      'übernommene und konkretisierte Anforderungen',
      'Lösungskonzept und Systemarchitektur',
      'eingesetzte Technologien, Plattformen, Programmiersprachen',
      'Schnittstellen zu anderen Systemen',
      'Test- und Abnahmekriterien, Testfälle',
      'Zeit- und Ressourcenplan',
    ],
  ),
  vergleich(
    'n-ld-6',
    'af-dokumente',
    'Eine Anforderung, zwei Sichten',
    'Beispiel: Eine Arztpraxis möchte eine Online-Terminbuchung. So klingt dieselbe Anforderung in beiden Dokumenten.',
    [
      ['Thema', 'Lastenheft', 'Pflichtenheft'],
      [
        'Buchung',
        'Termine rund um die Uhr online buchen',
        'Web-App mit REST-Anbindung an die Praxissoftware',
      ],
      [
        'Verfügbarkeit',
        'Buchung fast immer erreichbar',
        '99,5 % im Jahr, Hosting in zwei Rechenzentren',
      ],
      [
        'Datenschutz',
        'Patientendaten DSGVO-konform',
        'TLS-Verschlüsselung, Server in Deutschland',
      ],
    ],
  ),
  skizze(
    'n-ld-7',
    'af-dokumente',
    'Vom Lastenheft zur Abnahme',
    'So fügen sich beide Dokumente in den Projektablauf ein. Das genehmigte Pflichtenheft ist der Maßstab für alles, was danach kommt.',
    const FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Lastenheft (Auftraggeber)', form: FlussForm.dokument),
      FlussKnoten('Anfrage an Anbieter'),
      FlussKnoten('Angebote vergleichen'),
      FlussKnoten('Auftrag vergeben'),
      FlussKnoten('Pflichtenheft (Auftragnehmer)', form: FlussForm.dokument),
      FlussKnoten('Genehmigung durch AG'),
      FlussKnoten('Umsetzung und Test'),
      FlussKnoten('Abnahme gegen Pflichtenheft'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
  ),
  konzept(
    'n-ld-8',
    'af-dokumente',
    'Warum das so wichtig ist',
    'Beide Dokumente schützen beide Seiten. Was nicht drinsteht, muss nicht geliefert werden, und was drinsteht, muss funktionieren.',
    points: [
      'Lastenheft: vergleichbare Angebote, klare Erwartung des Kunden',
      'Pflichtenheft: Vertragsgrundlage, Maßstab für die Abnahme',
      'Streitfall: Man prüft, ob das Pflichtenheft erfüllt ist',
      'Änderungen nach der Genehmigung laufen über einen Änderungsantrag (Change Request), mit Folgen für Kosten und Termine',
    ],
  ),
  beispiel(
    'n-ld-9',
    'af-dokumente',
    'Aussagen einordnen',
    'Du arbeitest bei einem IT-Dienstleister. Ein Autohaus möchte eine App für Werkstatttermine. Ordne die Aussagen dem richtigen Dokument zu.',
    table: [
      ['Nr', 'Aussage'],
      ['1', 'Kunden sollen Werkstatttermine per App buchen.'],
      ['2', 'Die App wird mit Flutter für Android und iOS entwickelt.'],
      ['3', 'Heute werden Termine nur telefonisch vergeben.'],
      [
        '4',
        'Die Termine werden per REST-API aus dem Dealer-Management-System gelesen.',
      ],
      ['5', 'Das Budget beträgt 40.000 €.'],
    ],
    schritte: [
      '1: Was soll die App können? Fachliche Anforderung -> Lastenheft',
      '2: Womit wird entwickelt? Technologieentscheidung -> Pflichtenheft',
      '3: Ist-Zustand des Kunden -> Lastenheft',
      '4: Wie wird angebunden? Schnittstelle -> Pflichtenheft',
      '5: Rahmenbedingung des Auftraggebers -> Lastenheft',
    ],
    ergebnis: 'Lastenheft: 1, 3, 5. Pflichtenheft: 2, 4',
  ),
  konzept(
    'n-ld-10',
    'af-dokumente',
    'Und in agilen Projekten?',
    'In Scrum-Projekten wird selten vorab ein vollständiges Pflichtenheft geschrieben. Die Anforderungen stehen als User Stories im Product Backlog und werden Sprint für Sprint verfeinert.',
    points: [
      'Vorteil: Änderungen sind jederzeit eingeplant',
      'Nachteil: Umfang und Preis stehen am Anfang nicht fest',
      'Häufig: ein Rahmenvertrag, abgerechnet nach Aufwand',
    ],
  ),
  falle(
    'n-ld-11',
    'af-dokumente',
    'Genehmigung und Abnahme',
    'Das Pflichtenheft schreibt zwar der Auftragnehmer, verbindlich wird es aber erst durch die Genehmigung des Auftraggebers. Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft, denn nur das Pflichtenheft enthält die prüfbare, konkrete Lösung.',
    points: [
      'falsch: „Der Kunde schreibt das Pflichtenheft.“',
      'falsch: „Im Lastenheft steht die Programmiersprache.“',
      'richtig: Das Pflichtenheft enthält das Lastenheft in präzisierter Form',
    ],
  ),
  merke(
    'n-ld-12',
    'af-dokumente',
    'Auf einen Blick',
    'Zwei Dokumente mit zwei Verfassern und zwei Leitfragen, dazu ein klarer Maßstab für die Abnahme.',
    satz:
        'LAstenheft = Auftraggeber: Was und wofür? PFlichtenheft = Auftragnehmer: Wie und womit? Abgenommen wird gegen das genehmigte Pflichtenheft.',
  ),

  // ===================================================== Arten von Anforderungen
  konzept(
    'n-fa-1',
    'af-arten',
    'Was und wie gut',
    'Funktionale Anforderungen beschreiben, was ein System tut: welche Funktionen, Daten und Reaktionen es bietet. Nicht-funktionale Anforderungen beschreiben, wie gut und unter welchen Bedingungen es das tut.',
  ),
  vergleich(
    'n-fa-2',
    'af-arten',
    'Die Arten im Vergleich',
    'Beispiele aus einem Webshop zeigen den Unterschied. Randbedingungen werden meist zu den nicht-funktionalen Anforderungen gezählt.',
    [
      ['Art', 'Leitfrage', 'Beispiel'],
      ['funktional', 'Was soll das System tun?', 'Rechnung als PDF erzeugen'],
      [
        'nicht-funktional',
        'Wie gut soll es das tun?',
        'Suche antwortet in unter 2 s',
      ],
      ['Randbedingung', 'Welche Vorgaben gelten?', 'Betrieb auf Linux-Servern'],
    ],
  ),
  konzept(
    'n-fa-3',
    'af-arten',
    'Funktionale Anforderungen genauer',
    'Funktionale Anforderungen lassen sich gut nach dem EVA-Prinzip finden: Was wird eingegeben, was verarbeitet, was ausgegeben?',
    points: [
      'Eingabe: Kunden erfassen eine Lieferadresse',
      'Verarbeitung: Das System berechnet die Versandkosten',
      'Ausgabe: Das System erzeugt eine Auftragsbestätigung',
      'Reaktion auf Fehler: Bei ungültiger PLZ erscheint ein Hinweis',
      'Rechte: Nur die Buchhaltung darf Rechnungen stornieren',
    ],
  ),
  vergleich(
    'n-fa-4',
    'af-arten',
    'Typische Qualitätsmerkmale',
    'Nicht-funktionale Anforderungen betreffen die Qualität des ganzen Systems. Diese Merkmale werden in Prüfungen immer wieder abgefragt.',
    [
      ['Merkmal', 'Frage', 'Beispiel'],
      ['Leistung', 'Wie schnell?', 'Antwort in max. 2 s'],
      ['Zuverlässigkeit', 'Wie ausfallsicher?', '99,5 % Verfügbarkeit'],
      ['Benutzbarkeit', 'Wie leicht bedienbar?', 'barrierefrei, ohne Schulung'],
      ['Sicherheit', 'Wie geschützt?', 'Passwörter nur als Hash'],
      ['Wartbarkeit', 'Wie leicht änderbar?', 'Module einzeln austauschbar'],
      ['Übertragbarkeit', 'Wo lauffähig?', 'Android und iOS'],
    ],
  ),
  konzept(
    'n-fa-5',
    'af-arten',
    'Randbedingungen',
    'Randbedingungen schränken den Lösungsraum ein. Sie sind nicht verhandelbar und kommen von außen: vom Gesetzgeber, vom Unternehmen oder von der vorhandenen Technik.',
    points: [
      'rechtlich: DSGVO, Barrierefreiheitsstärkungsgesetz, Aufbewahrungsfristen',
      'technisch: vorhandene Server, vorgegebene Datenbank, Schnittstellen zum Altsystem',
      'organisatorisch: Budget, Fertigstellungstermin, verfügbares Personal',
    ],
  ),
  ablauf(
    'n-fa-6',
    'af-arten',
    'Eine Anforderung einordnen',
    'Beispiel: „Der Webshop berechnet die Versandkosten innerhalb von einer Sekunde.“',
    [
      'Tätigkeit suchen: „berechnet die Versandkosten“, das System tut etwas -> funktional',
      'Eigenschaft suchen: „innerhalb von einer Sekunde“, wie schnell -> nicht-funktional',
      'Ergebnis: Der Satz enthält zwei Anforderungen und sollte aufgeteilt werden',
    ],
    merksatz:
        'Tätigkeit des Systems = funktional. Eigenschaft oder Bedingung = nicht-funktional.',
  ),
  beispiel(
    'n-fa-7',
    'af-arten',
    'Einen Lastenheft-Auszug sortieren',
    'Ein Fitnessstudio lässt eine Kurs-App entwickeln. Ordne jede Anforderung ein.',
    table: [
      ['Nr', 'Anforderung'],
      ['1', 'Mitglieder buchen einen Kursplatz.'],
      ['2', 'Die App startet in unter 3 Sekunden.'],
      ['3', 'Trainer sehen die Teilnehmerliste.'],
      ['4', 'Die App läuft ab Android 12 und iOS 16.'],
      ['5', 'Bei vollem Kurs gibt es eine Warteliste.'],
      ['6', 'Daten werden nur in der EU gespeichert.'],
    ],
    schritte: [
      '1, 3, 5 beschreiben Tätigkeiten des Systems: buchen, anzeigen, Warteliste führen',
      '2 beschreibt eine Eigenschaft: Leistung (Startzeit)',
      '4 legt die Plattform fest: Übertragbarkeit bzw. Randbedingung',
      '6 ist eine rechtliche Randbedingung (Datenschutz)',
    ],
    ergebnis: 'funktional: 1, 3, 5. Nicht-funktional: 2, 4, 6',
  ),
  vergleich(
    'n-fa-8',
    'af-arten',
    'Messbar formulieren',
    'Auch nicht-funktionale Anforderungen müssen prüfbar sein, sonst kann man bei der Abnahme nicht entscheiden, ob sie erfüllt sind.',
    [
      ['vage', 'messbar'],
      ['Die Suche ist schnell.', '95 % der Suchen dauern max. 2 s.'],
      [
        'Die App ist leicht bedienbar.',
        'Neue Nutzer buchen ohne Hilfe in unter 3 min.',
      ],
      ['Das System ist immer verfügbar.', 'Verfügbarkeit 99,5 % pro Jahr.'],
      [
        'Das System verkraftet viele Nutzer.',
        '500 gleichzeitige Nutzer ohne Einbruch.',
      ],
    ],
  ),
  beispiel(
    'n-fa-9',
    'af-arten',
    'Was heißt 99,5 % Verfügbarkeit?',
    'Im Pflichtenheft steht: „Verfügbarkeit 99,5 % pro Jahr.“ Wie viele Stunden darf das System im Jahr höchstens ausfallen?',
    schritte: [
      'Stunden pro Jahr: 365 × 24 h = 8.760 h',
      'Erlaubter Ausfall: 100 % - 99,5 % = 0,5 %',
      '0,5 % von 8.760 h = 8.760 h × 0,005 = 43,8 h',
      'Zum Vergleich: 99,9 % erlauben nur 8,76 h pro Jahr',
    ],
    ergebnis: 'höchstens 43,8 Stunden Ausfall pro Jahr',
  ),
  falle(
    'n-fa-10',
    'af-arten',
    'Anmelden ist funktional',
    '„Benutzer können sich mit Passwort und zweitem Faktor anmelden“ ist funktional, denn es beschreibt eine Funktion. Nicht-funktional wäre „Passwörter werden nur als Hash gespeichert“. Das Wort „Sicherheit“ allein entscheidet also nicht über die Art.',
    points: [
      'Kann man die Anforderung als Tätigkeit des Systems ausdrücken? -> funktional',
      '„Das System soll schnell sein“ ist nicht falsch eingeordnet, sondern nicht prüfbar',
    ],
  ),
  merke(
    'n-fa-11',
    'af-arten',
    'Auf einen Blick',
    'Jede Anforderung gehört in genau eine Schublade und muss prüfbar sein.',
    satz:
        'Funktional: Was tut das System? Nicht-funktional: Wie gut und unter welchen Bedingungen? Beides messbar formulieren.',
  ),

  // ====================================================== Anforderungen erheben
  konzept(
    'n-fe-1',
    'af-erhebung',
    'Erst die Stakeholder',
    'Anforderungen kommen von Menschen. Wer eine Gruppe vergisst, vergisst ihre Anforderungen. Deshalb klärt man zuerst, wer vom System betroffen ist oder es beeinflusst: die Stakeholder.',
    points: [
      'Anwenderinnen und Anwender, z. B. Sachbearbeitung, Lager',
      'Auftraggeber und Geschäftsleitung',
      'IT-Betrieb und Support',
      'Datenschutzbeauftragte, Betriebsrat',
      'externe: Kunden, Lieferanten, Behörden',
    ],
  ),
  ablauf(
    'n-fe-2',
    'af-erhebung',
    'Vom Ist zum Soll',
    'Anforderungen zu ermitteln ist ein eigener Arbeitsschritt mit fester Reihenfolge.',
    [
      'Stakeholder ermitteln',
      'Ist-Zustand analysieren und Schwachstellen sammeln',
      'Anforderungen mit passenden Techniken erheben',
      'Anforderungen eindeutig dokumentieren',
      'Mit den Stakeholdern prüfen und abstimmen (validieren)',
      'Priorisieren, z. B. mit MoSCoW',
      'Änderungen während des Projekts verwalten',
    ],
  ),
  vergleich(
    'n-fe-3',
    'af-erhebung',
    'Erhebungstechniken',
    'Jede Technik hat Stärken und Schwächen. Oft kombiniert man mehrere.',
    [
      ['Technik', 'Stärke', 'Schwäche'],
      [
        'Interview',
        'Tiefe, Rückfragen möglich',
        'zeitaufwendig, wenige Personen',
      ],
      [
        'Fragebogen',
        'viele Personen, gut auswertbar',
        'keine Rückfragen, wenig Tiefe',
      ],
      [
        'Beobachtung',
        'zeigt echte, unbewusste Abläufe',
        'aufwendig, Verhalten ändert sich',
      ],
      [
        'Workshop',
        'gemeinsame Sicht, Konflikte klären',
        'Moderation und Termine nötig',
      ],
      [
        'Dokumentenanalyse',
        'nutzt Formulare, Handbücher, Altsystem',
        'Unterlagen oft veraltet',
      ],
      [
        'Prototyp',
        'Nutzer sehen früh etwas Greifbares',
        'weckt Erwartung „fast fertig“',
      ],
    ],
  ),
  vergleich(
    'n-fe-4',
    'af-erhebung',
    'Offene und geschlossene Fragen',
    'Die Frageform bestimmt, was man erfährt. Im Interview helfen offene Fragen, im Fragebogen geschlossene, weil sie sich zählen lassen.',
    [
      ['Frageart', 'Beispiel', 'Einsatz'],
      ['offen', 'Wie planen Sie heute Ihre Touren?', 'Interview, Workshop'],
      ['geschlossen', 'Nutzen Sie ein Tablet? (ja/nein)', 'Fragebogen'],
      ['Skala', 'Zufriedenheit von 1 bis 5?', 'Fragebogen'],
    ],
  ),
  beispiel(
    'n-fe-5',
    'af-erhebung',
    'Die richtige Technik wählen',
    'Eine Werkstattkette mit 12 Filialen und 150 Beschäftigten will eine neue Auftragssoftware. Welche Techniken setzt du wofür ein?',
    schritte: [
      'Ziele der Geschäftsführung: Interview (wenige Personen, viel Tiefe)',
      'Wünsche aller 150 Beschäftigten: Fragebogen (viele Personen, auswertbar)',
      'Tatsächliche Handgriffe in der Werkstatt: Beobachtung (zeigt Unbewusstes)',
      'Streit zwischen Werkstatt und Buchhaltung: Workshop (gemeinsame Einigung)',
      'Formulare und Altsoftware: Dokumentenanalyse',
    ],
    ergebnis:
        'Kombination aus Interview, Fragebogen, Beobachtung, Workshop und Dokumentenanalyse',
  ),
  konzept(
    'n-fe-6',
    'af-erhebung',
    'Gute Anforderungen',
    'Eine erhobene Anforderung taugt nur dann etwas, wenn sich später eindeutig prüfen lässt, ob sie erfüllt ist.',
    points: [
      'eindeutig: nur eine Interpretation',
      'vollständig: keine fehlenden Angaben',
      'widerspruchsfrei zu anderen Anforderungen',
      'prüfbar: messbares Kriterium',
      'notwendig und realisierbar',
      'verfolgbar: mit eindeutiger Nummer und Quelle',
    ],
  ),
  formel(
    'n-fe-7',
    'af-erhebung',
    'Aus vage wird prüfbar',
    'Eine Satzschablone mit festen Verben zwingt zu klaren Formulierungen. „Muss“ ist verbindlich, „soll“ wünschenswert, „kann“ optional.',
    '''Schablone:
Das System muss/soll/kann
<wem?> die Möglichkeit bieten,
<Objekt> <Tätigkeit>.

Vage:
„Die Suche soll schnell sein.“

Prüfbar:
„Das System muss 95 % aller
Suchanfragen in höchstens
2 Sekunden beantworten.“''',
  ),
  formel(
    'n-fe-8',
    'af-erhebung',
    'User Stories',
    'In agilen Projekten werden Anforderungen als User Stories aus Sicht der Nutzenden geschrieben. Akzeptanzkriterien machen sie prüfbar.',
    '''Als <Rolle>
möchte ich <Funktion>,
damit <Nutzen>.

Als Mitglied
möchte ich einen Kurs buchen,
damit mir ein Platz sicher ist.''',
    points: [
      'Akzeptanzkriterium: Die Buchung ist nur bei freiem Platz möglich',
      'Akzeptanzkriterium: Nach der Buchung kommt eine Bestätigung per Mail',
    ],
  ),
  vergleich(
    'n-fe-9',
    'af-erhebung',
    'Priorisieren mit MoSCoW',
    'Nicht alles lässt sich sofort umsetzen. MoSCoW sortiert Anforderungen in vier Klassen, hier am Beispiel eines Webshops.',
    [
      ['Klasse', 'Bedeutung', 'Beispiel'],
      ['Must have', 'unverzichtbar', 'Bezahlung'],
      ['Should have', 'wichtig, nicht kritisch', 'Wunschliste'],
      ['Could have', 'schön, wenn Zeit bleibt', 'dunkles Design'],
      ['Won’t have', 'diesmal bewusst nicht', 'Sprachsteuerung'],
    ],
  ),
  falle(
    'n-fe-10',
    'af-erhebung',
    '„Won’t“ heißt nicht „nie“',
    'Won’t have bedeutet „in diesem Release nicht“. Die Anforderung wird dokumentiert und kann später wieder aufgenommen werden. Denk außerdem daran: Wer nur befragt, erfährt nur, was den Menschen bewusst ist. Eingeübte Handgriffe deckt erst die Beobachtung auf.',
  ),
  merke(
    'n-fe-11',
    'af-erhebung',
    'Auf einen Blick',
    'Erst die Menschen, dann die Technik, dann die saubere Formulierung.',
    satz:
        'Stakeholder finden, passende Technik wählen, Anforderungen prüfbar formulieren, mit MoSCoW priorisieren.',
  ),

  // ===================================================== Anwendungsfalldiagramm
  konzept(
    'n-uu-1',
    'u-usecase',
    'Wer macht was mit dem System?',
    'Das Anwendungsfalldiagramm (Use-Case-Diagramm) zeigt aus Sicht der Nutzer, welche Leistungen ein System bietet und wer sie nutzt. Es zeigt nicht, wie oder in welcher Reihenfolge etwas abläuft.',
    points: [
      'eignet sich für die Anforderungsanalyse und das Gespräch mit dem Kunden',
      'ein Bild für den Überblick, Details stehen in Textbeschreibungen',
    ],
  ),
  vergleich(
    'n-uu-2',
    'u-usecase',
    'Die Notationselemente',
    'Mit diesen sechs Elementen lässt sich jedes Anwendungsfalldiagramm der Prüfung zeichnen.',
    [
      ['Element', 'Symbol', 'Bedeutung'],
      ['Akteur', 'Strichmännchen', 'Rolle oder externes System'],
      ['Anwendungsfall', 'Ellipse', 'Leistung des Systems'],
      ['Systemgrenze', 'Rechteck mit Name', 'was zum System gehört'],
      ['Assoziation', 'durchgezogene Linie', 'Akteur nutzt Fall'],
      ['«include»', 'gestrichelter Pfeil', 'wird immer mit ausgeführt'],
      ['«extend»', 'gestrichelter Pfeil', 'erweitert unter Bedingung'],
    ],
  ),
  skizze(
    'n-uu-3',
    'u-usecase',
    'Ein einfaches Diagramm',
    'Das Bibliothekssystem bietet vier Anwendungsfälle. Mitglieder suchen und reservieren Medien, das Personal verleiht sie und nimmt sie zurück. Beide Akteure stehen außerhalb der Systemgrenze.',
    const UseCaseDiagramm(
      system: 'Bibliothekssystem',
      faelle: [
        'Medium suchen',
        'Medium reservieren',
        'Medium ausleihen',
        'Rückgabe buchen',
      ],
      akteure: [
        UcAkteur('Mitglied', [0, 1]),
        UcAkteur('Bibliothekspersonal', [2, 3]),
      ],
    ),
  ),
  konzept(
    'n-uu-4',
    'u-usecase',
    'Akteure richtig finden',
    'Ein Akteur ist alles außerhalb des Systems, das mit ihm interagiert. Er beschreibt eine Rolle, keine bestimmte Person, denn eine Person kann mehrere Rollen haben.',
    points: [
      'Rollen: „Kundin“, „Sachbearbeitung“, nicht „Frau Meier“',
      'externe Systeme: Zahlungsdienst, Mailserver, Behörden-Schnittstelle',
      'primärer Akteur: löst den Anwendungsfall aus',
      'sekundärer Akteur: wird vom System dabei in Anspruch genommen',
      'die eigene Datenbank ist Teil des Systems, kein Akteur',
    ],
  ),
  konzept(
    'n-uu-5',
    'u-usecase',
    'Anwendungsfälle benennen',
    'Ein Anwendungsfall ist ein Ziel, das ein Akteur mit dem System erreicht. Man benennt ihn mit Objekt und Verb aus Sicht des Akteurs.',
    points: [
      'gut: „Termin buchen“, „Rechnung drucken“',
      'zu fein: „Button OK klicken“, das ist nur ein Bedienschritt',
      'zu grob: „Webshop“, das ist das ganze System',
      'technisch: „In Datenbank speichern“, kein Ziel eines Akteurs',
    ],
  ),
  vergleich(
    'n-uu-6',
    'u-usecase',
    'include und extend',
    'Neben der Assoziation gibt es zwei gestrichelte Pfeile mit Stereotyp. Sie verbinden nur Anwendungsfälle untereinander.',
    [
      ['Beziehung', 'Bedeutung', 'Pfeilrichtung'],
      [
        '«include»',
        'wird immer mit ausgeführt',
        'vom Basisfall zum inkludierten Fall',
      ],
      [
        '«extend»',
        'erweitert nur unter Bedingung',
        'vom erweiternden Fall zum Basisfall',
      ],
    ],
  ),
  skizze(
    'n-uu-7',
    'u-usecase',
    'include und extend im Diagramm',
    'Jede Bestellung setzt eine Anmeldung voraus, also «include» von „Bestellung aufgeben“ zu „Anmelden“. Einen Gutschein lösen nur manche ein, also «extend», und der Pfeil zeigt auf „Bestellung aufgeben“. Der Zahlungsdienst ist ein externes System und damit ein Akteur.',
    const UseCaseDiagramm(
      system: 'Webshop',
      faelle: [
        'Bestellung aufgeben',
        'Anmelden',
        'Gutschein einlösen',
        'Artikel suchen',
      ],
      akteure: [
        UcAkteur('Kunde', [0, 3]),
        UcAkteur('Zahlungsdienst', [0]),
      ],
      beziehungen: [
        UcBeziehung(0, 1, UcArt.include),
        UcBeziehung(2, 0, UcArt.extend),
      ],
    ),
  ),
  ablauf(
    'n-uu-8',
    'u-usecase',
    'So entsteht das Diagramm',
    'Mit dieser Reihenfolge lässt sich jede Prüfungsaufgabe zum Anwendungsfalldiagramm angehen.',
    [
      'Systemgrenze zeichnen und benennen',
      'Akteure als Rollen finden, „Kundin“, nicht „Frau Meier“',
      'Anwendungsfälle je Akteur sammeln: Verb + Objekt',
      'Akteure und Anwendungsfälle mit Linien verbinden',
      'Immer gemeinsam genutzte Teile als «include», optionale als «extend» modellieren',
      'Prüfen: Steht jeder Satz der Aufgabe im Diagramm?',
    ],
  ),
  beispiel(
    'n-uu-9',
    'u-usecase',
    'Aus einem Text ein Diagramm',
    'Aufgabe: „Mitglieder eines Fitnessstudios buchen und stornieren Kurse über die App. Beides setzt eine Anmeldung voraus. Ist ein Kurs voll, kann sich das Mitglied auf die Warteliste setzen. Trainer pflegen den Kursplan.“',
    schritte: [
      'System: Kurs-App. Akteure: Mitglied, Trainer',
      'Fälle des Mitglieds: Kurs buchen, Kurs stornieren',
      'Fall des Trainers: Kursplan pflegen',
      '„setzt eine Anmeldung voraus“ -> «include» von Buchen und von Stornieren zu „Anmelden“',
      '„ist ein Kurs voll, kann …“ -> Bedingung -> «extend» von „Auf Warteliste setzen“ zu „Kurs buchen“',
    ],
    ergebnis: '5 Anwendungsfälle, 2 Akteure, 2 × «include», 1 × «extend»',
    skizze: const UseCaseDiagramm(
      system: 'Kurs-App',
      faelle: [
        'Kurs buchen',
        'Kurs stornieren',
        'Anmelden',
        'Auf Warteliste setzen',
        'Kursplan pflegen',
      ],
      akteure: [
        UcAkteur('Mitglied', [0, 1]),
        UcAkteur('Trainer', [4]),
      ],
      beziehungen: [
        UcBeziehung(0, 2, UcArt.include),
        UcBeziehung(1, 2, UcArt.include),
        UcBeziehung(3, 0, UcArt.extend),
      ],
    ),
  ),
  falle(
    'n-uu-10',
    'u-usecase',
    'Die Pfeilrichtung',
    'Bei «include» zeigt der Pfeil vom Basisfall weg zum eingebundenen Fall. Bei «extend» ist es umgekehrt: Der Pfeil zeigt vom erweiternden Fall hin zum Basisfall, denn der Basisfall funktioniert auch ohne die Erweiterung.',
    merksatz:
        'include = immer, Pfeil weg vom Basisfall. extend = manchmal, Pfeil hin zum Basisfall.',
  ),
  falle(
    'n-uu-11',
    'u-usecase',
    'Kein Ablaufdiagramm',
    'Das Anwendungsfalldiagramm kennt keine Reihenfolge. Wer „erst anmelden, dann suchen, dann bestellen“ mit Pfeilen darstellen will, braucht ein Aktivitätsdiagramm.',
    points: [
      'keine Pfeile zwischen Akteur und Anwendungsfall, nur Linien',
      'Anwendungsfälle nicht mit einfachen Linien verbinden, nur «include»/«extend»',
      'Akteure nie innerhalb der Systemgrenze zeichnen',
    ],
  ),
  merke(
    'n-uu-12',
    'u-usecase',
    'Auf einen Blick',
    'Das Diagramm beantwortet die Frage: Wer nutzt welche Leistung des Systems?',
    satz:
        'Akteure außen, Anwendungsfälle als Ellipsen innen, Linien für die Nutzung. include = immer, extend = manchmal.',
  ),

  // =============================================================== Klassendiagramm
  konzept(
    'n-uk-1',
    'u-klassen',
    'Aufbau einer Klasse',
    'Eine Klasse ist im Klassendiagramm ein Rechteck mit drei Abschnitten: oben der Name, in der Mitte die Attribute, unten die Methoden. Vor jedem Eintrag steht die Sichtbarkeit, hinter dem Doppelpunkt der Datentyp.',
    points: [
      'Klassenname: Substantiv im Singular, großgeschrieben (Kunde, nicht Kunden)',
      'Attribut: - name: String',
      'Methode: + getName(): String',
    ],
  ),
  skizze(
    'n-uk-2',
    'u-klassen',
    'Eine Klasse lesen',
    'Die Klasse Kunde hat drei private Attribute. Der Konstruktor und zwei Methoden sind öffentlich. bestellen erwartet einen Artikel und liefert einen Wahrheitswert zurück.',
    const KlassenDiagramm([
      UmlKlasse(
        'Kunde',
        attribute: ['- kundenNr: int', '- name: String', '- email: String'],
        methoden: [
          '+ Kunde(name: String)',
          '+ getName(): String',
          '+ bestellen(a: Artikel): boolean',
        ],
      ),
    ]),
  ),
  vergleich(
    'n-uk-3',
    'u-klassen',
    'Die Schreibweise im Detail',
    'Die UML-Schreibweise folgt immer demselben Muster: Sichtbarkeit, Name, Doppelpunkt, Typ.',
    [
      ['Element', 'UML-Schreibweise'],
      ['Attribut', '- name: String'],
      ['mit Startwert', '- status: String = "offen"'],
      ['Methode', '+ getName(): String'],
      ['mit Parametern', '+ setMenge(m: int): void'],
      ['Konstruktor', '+ Kunde(name: String)'],
      ['Klassenattribut', 'unterstrichen dargestellt'],
    ],
  ),
  vergleich(
    'n-uk-4',
    'u-klassen',
    'Sichtbarkeiten',
    'Das Zeichen vor Attribut oder Methode legt fest, wer darauf zugreifen darf. Attribute sind in der Regel private, Methoden der Schnittstelle public.',
    [
      ['Zeichen', 'Name', 'Zugriff'],
      ['+', 'public', 'von überall'],
      ['-', 'private', 'nur die Klasse selbst'],
      ['#', 'protected', 'Klasse und Unterklassen'],
      ['~', 'package', 'Klassen im selben Paket'],
    ],
  ),
  vergleich(
    'n-uk-5',
    'u-klassen',
    'Multiplizitäten',
    'An den Enden einer Beziehung steht, wie viele Objekte beteiligt sind.',
    [
      ['Angabe', 'Bedeutung'],
      ['1', 'genau eins'],
      ['0..1', 'keins oder eins'],
      ['* oder 0..*', 'beliebig viele, auch keins'],
      ['1..*', 'mindestens eins'],
      ['2..5', 'zwei bis fünf'],
    ],
  ),
  skizze(
    'n-uk-6',
    'u-klassen',
    'Multiplizitäten richtig lesen',
    'Man liest von einem einzelnen Objekt aus über die Linie hinweg: Ein Kunde gibt 0..* Bestellungen auf. Eine Bestellung gehört zu genau 1 Kunden. Die Zahl steht also am anderen Ende.',
    const KlassenDiagramm(
      [
        UmlKlasse('Kunde', attribute: ['- name: String']),
        UmlKlasse('Bestellung', attribute: ['- datum: Date']),
      ],
      beziehungen: [
        UmlBeziehung(0, 1, multVon: '1', multZu: '0..*', label: 'gibt auf'),
      ],
    ),
  ),
  vergleich(
    'n-uk-7',
    'u-klassen',
    'Arten von Beziehungen',
    'Die Raute sitzt immer am Ganzen. Entscheidend ist, ob das Teil ohne das Ganze weiterlebt.',
    [
      ['Beziehung', 'Symbol', 'Beispiel'],
      ['Assoziation', 'einfache Linie', 'Kunde - Bestellung'],
      [
        'gerichtete Assoziation',
        'Linie mit offenem Pfeil',
        'Position kennt Artikel',
      ],
      ['Aggregation', 'leere Raute am Ganzen', 'Abteilung ◇ Mitarbeiter'],
      ['Komposition', 'gefüllte Raute am Ganzen', 'Rechnung ◆ Position'],
    ],
    merksatz:
        'Komposition: Wird die Rechnung gelöscht, verschwinden ihre Positionen mit. Aggregation: Mitarbeitende gibt es auch ohne Abteilung.',
  ),
  skizze(
    'n-uk-8',
    'u-klassen',
    'Beziehungen im Diagramm',
    'Ein Kunde erhält beliebig viele Rechnungen. Jede Rechnung besteht aus mindestens einer Position, eine Komposition, denn Positionen gibt es nicht ohne Rechnung. Jede Position verweist auf genau einen Artikel; der Pfeil zeigt: Die Position kennt den Artikel, nicht umgekehrt.',
    const KlassenDiagramm(
      [
        UmlKlasse('Kunde', attribute: ['- name: String']),
        UmlKlasse('Rechnung', attribute: ['- nummer: int', '- datum: Date']),
        UmlKlasse('Position', attribute: ['- menge: int']),
        UmlKlasse('Artikel', attribute: ['- bezeichnung: String']),
      ],
      beziehungen: [
        UmlBeziehung(0, 1, multVon: '1', multZu: '0..*', label: 'erhält'),
        UmlBeziehung(
          1,
          2,
          art: UmlArt.komposition,
          multVon: '1',
          multZu: '1..*',
        ),
        UmlBeziehung(2, 3, art: UmlArt.gerichtet, multVon: '0..*', multZu: '1'),
      ],
    ),
  ),
  beispiel(
    'n-uk-9',
    'u-klassen',
    'Aus einem Text ein Klassendiagramm',
    'Aufgabe: „Eine Fahrschule verwaltet Fahrschüler mit Name und Geburtsdatum. Jeder Fahrschüler hat beliebig viele Fahrstunden, jede Fahrstunde gehört zu genau einem Fahrschüler. Eine Fahrstunde hat Datum und Dauer in Minuten und wird von genau einem Fahrlehrer gegeben.“',
    schritte: [
      'Substantive mit eigenen Eigenschaften werden Klassen: Fahrschueler, Fahrstunde, Fahrlehrer',
      'Eigenschaften werden Attribute mit Datentyp, private: - dauerMin: int',
      'Verben zwischen Klassen werden Beziehungen: „hat“, „gibt“',
      '„beliebig viele“ -> 0..*, „genau einem“ -> 1',
      'Multiplizität ans richtige Ende: 0..* neben Fahrstunde',
    ],
    ergebnis: '3 Klassen, 2 Assoziationen mit 1 zu 0..*',
    skizze: const KlassenDiagramm(
      [
        UmlKlasse(
          'Fahrschueler',
          attribute: ['- name: String', '- geburtsdatum: Date'],
        ),
        UmlKlasse(
          'Fahrstunde',
          attribute: ['- datum: Date', '- dauerMin: int'],
        ),
        UmlKlasse('Fahrlehrer', attribute: ['- name: String']),
      ],
      beziehungen: [
        UmlBeziehung(0, 1, multVon: '1', multZu: '0..*', label: 'hat'),
        UmlBeziehung(2, 1, multVon: '1', multZu: '0..*', label: 'gibt'),
      ],
    ),
  ),
  falle(
    'n-uk-10',
    'u-klassen',
    'Auf der richtigen Seite lesen',
    'Die Multiplizität steht an dem Ende, über das sie eine Aussage macht: Die 0..* neben Bestellung sagt, wie viele Bestellungen ein Kunde hat. Und die Raute gehört ans Ganze, nicht ans Teil. Wer beides vertauscht, liest das Diagramm genau falsch herum.',
  ),
  falle(
    'n-uk-11',
    'u-klassen',
    'Was nicht ins Klassendiagramm gehört',
    'Das Klassendiagramm zeigt die Struktur, nicht den Ablauf und keine konkreten Daten.',
    points: [
      'keine konkreten Werte wie „Meier“. Die gehören zu Objekten',
      'keine Reihenfolge von Methodenaufrufen',
      'Ist eine Beziehung gezeichnet, braucht Bestellung kein zusätzliches Attribut kundenNr',
      'Methoden immer mit Klammern, auch ohne Parameter: getName()',
    ],
  ),
  merke(
    'n-uk-12',
    'u-klassen',
    'Auf einen Blick',
    'Das Klassendiagramm ist der Bauplan des Programms.',
    satz:
        'Name, Attribute, Methoden. Sichtbarkeit + - # ~, Typ nach dem Doppelpunkt. Multiplizität am anderen Ende, Raute am Ganzen.',
  ),

  // ========================================================== Aktivitätsdiagramm
  konzept(
    'n-ua-1',
    'u-aktivitaet',
    'Abläufe zeigen',
    'Das Aktivitätsdiagramm zeigt einen Ablauf Schritt für Schritt: einen Geschäftsprozess oder einen Algorithmus. Pfeile (Kontrollfluss) verbinden die Elemente. Seit Struktogramm und Programmablaufplan nicht mehr geprüft werden, ist es die grafische Darstellung für Algorithmen.',
  ),
  vergleich(
    'n-ua-2',
    'u-aktivitaet',
    'Die Notationselemente',
    'Diese Symbole musst du lesen und zeichnen können.',
    [
      ['Element', 'Symbol', 'Bedeutung'],
      ['Startknoten', 'gefüllter Kreis', 'Beginn des Ablaufs'],
      ['Aktion', 'Rechteck, runde Ecken', 'ein Schritt, z. B. „Ware prüfen“'],
      ['Kontrollfluss', 'Pfeil', 'Reihenfolge'],
      ['Entscheidung', 'Raute', 'genau ein Weg nach Bedingung'],
      ['Gabelung/Vereinigung', 'dicker Balken', 'parallele Wege'],
      ['Endknoten', 'Kreis mit Ring', 'beendet die ganze Aktivität'],
      ['Ablaufende', 'Kreis mit X', 'beendet nur diesen Weg'],
    ],
  ),
  skizze(
    'n-ua-3',
    'u-aktivitaet',
    'Ein einfacher Ablauf',
    'Eine Anmeldung: Nach der Eingabe prüft das System die Daten. An den Kanten der Raute stehen die Bedingungen in eckigen Klammern. Im vollständigen Diagramm führt der [nein]-Zweig nach der Fehlermeldung zurück zur Eingabe.',
    const FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Anmeldedaten eingeben'),
      FlussKnoten(
        'Daten korrekt?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] Fehlermeldung zeigen',
      ),
      FlussKnoten('Startseite anzeigen'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
  ),
  konzept(
    'n-ua-4',
    'u-aktivitaet',
    'Bedingungen an den Kanten',
    'An den ausgehenden Kanten einer Entscheidung stehen Bedingungen in eckigen Klammern, sogenannte Guards. Sie müssen sich gegenseitig ausschließen und zusammen alle Fälle abdecken.',
    points: [
      'richtig: [Betrag > 500] und [Betrag <= 500]',
      'falsch: [Betrag > 500] und [Betrag < 500], bei genau 500 geht es nicht weiter',
      '[else] fängt alle übrigen Fälle ab',
    ],
  ),
  vergleich(
    'n-ua-5',
    'u-aktivitaet',
    'Raute oder Balken?',
    'Verzweigungen und parallele Abläufe haben unterschiedliche Symbole.',
    [
      ['Element', 'Symbol', 'Wirkung'],
      [
        'Entscheidung',
        'Raute, 1 rein, n raus',
        'genau ein Weg je nach Bedingung',
      ],
      [
        'Zusammenführung',
        'Raute, n rein, 1 raus',
        'alternative Wege treffen sich',
      ],
      ['Gabelung (Fork)', 'Balken, 1 rein, n raus', 'startet parallele Wege'],
      [
        'Vereinigung (Join)',
        'Balken, n rein, 1 raus',
        'wartet, bis alle Wege fertig sind',
      ],
    ],
  ),
  formel(
    'n-ua-6',
    'u-aktivitaet',
    'Beispiel mit parallelen Wegen',
    'Ist die Ware lieferbar, laufen Verpacken und Rechnungserstellung parallel. Versendet wird erst, wenn beides erledigt ist. Dafür sorgt der Vereinigungsbalken.',
    '''(Start)
 -> Bestellung prüfen
 -> <> Entscheidung
  [nicht lieferbar]
   -> Kunde informieren -> (Ende)
  [lieferbar]
   -> === Gabelung
      | Ware verpacken
      | Rechnung erstellen
   -> === Vereinigung
   -> Paket versenden -> (Ende)''',
  ),
  skizze(
    'n-ua-7',
    'u-aktivitaet',
    'Schleifen darstellen',
    'Eine eigene Schleifenform gibt es nicht. Man baut sie aus einer Entscheidung und einer Kante, die zurück vor eine frühere Aktion führt. An der Kasse wird gescannt, solange noch Artikel da sind.',
    const FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Artikel scannen'),
      FlussKnoten(
        'Weitere Artikel?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] zurück zum Scannen',
      ),
      FlussKnoten('Summe anzeigen'),
      FlussKnoten('Bezahlung abwickeln'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
  ),
  konzept(
    'n-ua-8',
    'u-aktivitaet',
    'Swimlanes: Wer ist zuständig?',
    'Aktivitätsbereiche, auch Swimlanes oder Partitionen genannt, teilen das Diagramm in Bahnen, je Rolle oder Abteilung eine. Jede Aktion steht in der Bahn dessen, der sie ausführt.',
    points: [
      'Bahn Vertrieb: Bestellung prüfen',
      'Bahn Lager: Ware verpacken',
      'Bahn Buchhaltung: Rechnung erstellen',
      'Pfeile dürfen die Bahnen überqueren, so sieht man Übergaben',
    ],
  ),
  beispiel(
    'n-ua-9',
    'u-aktivitaet',
    'Aus einem Text ein Aktivitätsdiagramm',
    'Aufgabe: „Der Support erfasst ein Ticket. Hat es hohe Priorität, wird es sofort an den 2nd-Level übergeben. Sonst kommt es in die Warteschlange. Danach wird das Ticket bearbeitet und geschlossen.“',
    schritte: [
      'Startknoten setzen, erste Aktion: „Ticket erfassen“',
      '„Hat es hohe Priorität?“ -> Entscheidung mit [ja] und [nein]',
      '[ja]: „An 2nd-Level übergeben“, [nein]: „In Warteschlange stellen“',
      'Beide Wege mit einer Zusammenführung (Raute) vereinen',
      '„Ticket bearbeiten“, „Ticket schließen“, Endknoten',
    ],
    ergebnis: 'Eine Entscheidung, zwei alternative Wege, eine Zusammenführung',
    skizze: const FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Ticket erfassen'),
      FlussKnoten(
        'Priorität hoch?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] an 2nd-Level übergeben',
      ),
      FlussKnoten('In Warteschlange stellen'),
      FlussKnoten('Ticket bearbeiten'),
      FlussKnoten('Ticket schließen'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
  ),
  vergleich(
    'n-ua-10',
    'u-aktivitaet',
    'Aktivitätsdiagramm und Pseudocode',
    'Ein Algorithmus lässt sich in beide Formen übersetzen. So erkennst du, welches Element welcher Anweisung entspricht.',
    [
      ['Aktivitätsdiagramm', 'Pseudocode'],
      ['Aktion', 'Anweisung, z. B. x ← x + 1'],
      ['Entscheidung + Zusammenführung', 'WENN … SONST … ENDE WENN'],
      ['Entscheidung + Rückkante', 'SOLANGE … ENDE SOLANGE'],
      ['Start- und Endknoten', 'Anfang und Ende des Algorithmus'],
    ],
  ),
  falle(
    'n-ua-11',
    'u-aktivitaet',
    'Entweder-oder ist nicht sowohl-als-auch',
    'Nach einer Raute läuft genau ein Weg weiter. Nach einem Gabelungsbalken laufen alle Wege gleichzeitig. Wer parallele Arbeiten mit einer Raute zusammenführt, lässt den Ablauf schon nach dem ersten fertigen Weg weiterlaufen. Dafür braucht es den Vereinigungsbalken.',
  ),
  falle(
    'n-ua-12',
    'u-aktivitaet',
    'Kleine Fehler, volle Punktabzüge',
    'Diese Fehler sieht man in Prüfungslösungen besonders oft.',
    points: [
      'Guards fehlen oder überschneiden sich',
      'eine Kante endet im Nichts. Jeder Weg braucht ein Ende',
      'Aktionen ohne Verb: „Rechnung“ statt „Rechnung erstellen“',
      'Endknoten statt Ablaufende: Der Endknoten stoppt auch alle parallelen Wege',
    ],
  ),
  merke(
    'n-ua-13',
    'u-aktivitaet',
    'Auf einen Blick',
    'Das Aktivitätsdiagramm zeigt, was in welcher Reihenfolge passiert.',
    satz:
        'Raute = entweder-oder mit Guards in [ ]. Balken = alle gleichzeitig, Join wartet auf alle. Schleife = Entscheidung mit Rückkante.',
  ),

  // ===================================================== Variablen und Datentypen
  konzept(
    'n-pd-1',
    'pl-datentypen',
    'Variable und Datentyp',
    'Eine Variable ist ein benannter Speicherplatz für einen Wert. Ihr Datentyp legt fest, welche Werte sie aufnehmen kann, wie viel Speicher sie braucht und welche Operationen erlaubt sind: mit Zahlen kann man rechnen, mit Text nicht.',
    points: [
      'Deklaration: int anzahl;',
      'Initialisierung: int anzahl = 5;',
      'Zuweisung: anzahl = anzahl + 1;',
    ],
  ),
  vergleich(
    'n-pd-2',
    'pl-datentypen',
    'Die wichtigsten Datentypen',
    'Diese einfachen Typen und der String kommen in jeder Prüfung vor.',
    [
      ['Typ', 'Inhalt', 'Beispiel'],
      ['int', 'ganze Zahl', '42'],
      ['float / double', 'Gleitkommazahl', '2.75'],
      ['boolean', 'wahr oder falsch', 'true'],
      ['char', 'ein einzelnes Zeichen', '\'A\''],
      ['String', 'Zeichenkette', '"Hallo"'],
    ],
  ),
  vergleich(
    'n-pd-3',
    'pl-datentypen',
    'Speicherbedarf und Wertebereich',
    'Die Größen gelten für Java. In C ist ein char nur 8 Bit groß, und die Größe von int hängt vom System ab.',
    [
      ['Typ', 'Bit', 'Wertebereich'],
      ['byte', '8', '-128 bis 127'],
      ['short', '16', '-32.768 bis 32.767'],
      ['int', '32', 'ca. ±2,1 Milliarden'],
      ['long', '64', 'ca. ±9,2 Trillionen'],
      ['float', '32', 'ca. 7 Stellen genau'],
      ['double', '64', 'ca. 15 Stellen genau'],
      ['char', '16', 'ein Unicode-Zeichen'],
      ['boolean', '-', 'true oder false'],
    ],
  ),
  formel(
    'n-pd-4',
    'pl-datentypen',
    'Wertebereiche berechnen',
    'Mit n Bit lassen sich 2ⁿ verschiedene Werte darstellen. Bei Zahlen mit Vorzeichen geht die Hälfte in den negativen Bereich, und die Null zählt zur positiven Hälfte.',
    '''n Bit -> 2^n Werte
ohne Vorzeichen: 0 bis 2^n - 1
mit Vorzeichen:
  -2^(n-1) bis 2^(n-1) - 1

8 Bit (byte): 2^8 = 256 Werte
  -128 bis 127
32 Bit (int): 2^32 Werte
  -2.147.483.648 bis
   2.147.483.647''',
    merksatz:
        'Größter Wert mit Vorzeichen: 2^(n-1) - 1, bei 16 Bit also 32.767.',
  ),
  beispiel(
    'n-pd-5',
    'pl-datentypen',
    'Wie viele Bit braucht man?',
    'Ein Sensor liefert ganze Messwerte von 0 bis 1000. Wie viele Bit braucht man mindestens, um jeden Wert ohne Vorzeichen zu speichern?',
    schritte: [
      'Anzahl der Werte: 0 bis 1000 sind 1001 Werte',
      '2^9 = 512, reicht nicht, 512 < 1001',
      '2^10 = 1024, reicht, 1024 ≥ 1001',
      'Probe: Mit 10 Bit ohne Vorzeichen geht es von 0 bis 1023',
    ],
    ergebnis: 'mindestens 10 Bit',
  ),
  konzept(
    'n-pd-6',
    'pl-datentypen',
    'Konstanten und gute Namen',
    'Werte, die sich nie ändern, speichert man als Konstante. Sie hat einen sprechenden Namen und kann nach der Initialisierung nicht mehr verändert werden.',
    points: [
      'Konstante in Java: final double MWST_SATZ = 0.19;',
      'Konstanten in GROSSBUCHSTABEN, Variablen in camelCase: anzahlArtikel',
      'sprechende Namen: bruttoPreis statt bp oder x',
      'keine Umlaute, Leerzeichen oder Sonderzeichen in Namen',
    ],
  ),
  vergleich(
    'n-pd-7',
    'pl-datentypen',
    'Rechenoperatoren',
    'Punktrechnung geht vor Strichrechnung, Klammern zuerst, sonst wird von links nach rechts gerechnet. Bei zwei ganzen Zahlen ist / eine Ganzzahldivision.',
    [
      ['Operator', 'Bedeutung', 'Beispiel'],
      ['+ - *', 'Grundrechenarten', '2 + 3 * 4 ergibt 14'],
      ['/ (int)', 'Ganzzahldivision (DIV)', '17 / 5 ergibt 3'],
      ['/ (double)', 'normale Division', '17.0 / 5 ergibt 3.4'],
      ['% (MOD)', 'Rest der Division', '17 % 5 ergibt 2'],
    ],
  ),
  beispiel(
    'n-pd-8',
    'pl-datentypen',
    'Ganzzahldivision und Modulo nutzen',
    'Eine Stoppuhr liefert 7384 Sekunden. Gib die Zeit als Stunden, Minuten und Sekunden aus, nur mit DIV (Ganzzahldivision) und MOD (Rest).',
    code: '''s ← 7384
h ← s DIV 3600
rest ← s MOD 3600
m ← rest DIV 60
sek ← rest MOD 60''',
    schritte: [
      'h = 7384 DIV 3600 = 2, denn 2 × 3600 = 7200',
      'rest = 7384 MOD 3600 = 7384 - 7200 = 184',
      'm = 184 DIV 60 = 3, denn 3 × 60 = 180',
      'sek = 184 MOD 60 = 4',
      'Probe: 2 × 3600 + 3 × 60 + 4 = 7384',
    ],
    ergebnis: '2 h 3 min 4 s (2:03:04)',
    merksatz:
        'x MOD 2 = 0 heißt: x ist gerade. Das ist der häufigste Einsatz von Modulo.',
  ),
  konzept(
    'n-pd-9',
    'pl-datentypen',
    'Typumwandlung',
    'Beim Wechsel des Datentyps kann Information verloren gehen. Eine erweiternde Umwandlung passiert automatisch, eine einschränkende muss man ausdrücklich anfordern (Cast).',
    points: [
      'implizit, verlustfrei: int -> double, aus 7 wird 7.0',
      'explizit per Cast: (int) 9.99 ergibt 9 (abgeschnitten, nicht gerundet)',
      'Text in Zahl: Integer.parseInt("42") ergibt 42',
      'Zahl in Text: String.valueOf(42) ergibt "42"',
      'Text plus Zahl verkettet: "5" + 3 ergibt "53"',
    ],
  ),
  beispiel(
    'n-pd-10',
    'pl-datentypen',
    'Wo die Nachkommastellen bleiben',
    'Welche Werte haben d, e und f nach diesem Java-Code?',
    code: '''int a = 7;
int b = 2;
double d = a / b;
double e = (double) a / b;
int f = (int) 3.99;''',
    schritte: [
      'd: a / b sind zwei int -> Ganzzahldivision 7 / 2 = 3, erst dann wird 3 zu 3.0',
      'e: a wird vorher in double umgewandelt -> 7.0 / 2 = 3.5',
      'f: Der Cast schneidet die Nachkommastellen ab -> 3',
    ],
    ergebnis: 'd = 3.0, e = 3.5, f = 3',
  ),
  falle(
    'n-pd-11',
    'pl-datentypen',
    'PLZ, Telefonnummer und Geld',
    'Postleitzahlen und Telefonnummern gehören in einen String: Mit ihnen wird nicht gerechnet, die führende Null (01067 Dresden) ginge als Zahl verloren, und Zeichen wie + oder Leerzeichen passen in keinen Zahlentyp. Geldbeträge nicht als float oder double speichern, denn 0.1 + 0.2 ergibt dort nicht exakt 0.3. Besser: ein Dezimaltyp wie BigDecimal oder ganze Cent als Ganzzahl.',
  ),
  falle(
    'n-pd-12',
    'pl-datentypen',
    'Überlauf',
    'Wird der Wertebereich überschritten, gibt es in Java keinen Fehler: Die Zahl springt ans andere Ende des Bereichs. Aus einem byte mit 127 wird nach + 1 der Wert -128.',
    points: [
      'byte: 127 + 1 ergibt -128',
      'int: 2.147.483.647 + 1 ergibt -2.147.483.648',
      'Abhilfe: einen größeren Typ wählen, z. B. long statt int',
    ],
  ),
  merke(
    'n-pd-13',
    'pl-datentypen',
    'Auf einen Blick',
    'Der passende Datentyp spart Speicher und verhindert Fehler.',
    satz:
        'Rechnest du nicht damit, ist es ein String. Geld nie als Gleitkommazahl. int / int ergibt int, MOD liefert den Rest.',
  ),

  // ========================================================= Kontrollstrukturen
  konzept(
    'n-pk-1',
    'pl-kontrollstrukturen',
    'Drei Bausteine',
    'Jeder Algorithmus lässt sich aus drei Grundstrukturen zusammensetzen. Sie können beliebig ineinander verschachtelt werden.',
    points: [
      'Sequenz: Anweisungen nacheinander',
      'Verzweigung (Selektion): Anweisungen nur unter einer Bedingung',
      'Schleife (Iteration): Anweisungen wiederholen',
    ],
  ),
  vergleich(
    'n-pk-2',
    'pl-kontrollstrukturen',
    'Vergleichsoperatoren',
    'Bedingungen entstehen aus Vergleichen. Das Ergebnis ist immer wahr oder falsch. Beispiel mit x = 5:',
    [
      ['Operator', 'Bedeutung', 'Beispiel'],
      ['==', 'gleich', 'x == 5 ist wahr'],
      ['!=', 'ungleich', 'x != 5 ist falsch'],
      ['<  >', 'kleiner, größer', 'x < 5 ist falsch'],
      ['<=  >=', 'kleiner/größer gleich', 'x <= 5 ist wahr'],
    ],
    merksatz:
        'Ein = weist zu, == vergleicht. Im Pseudocode steht für die Zuweisung meist ←.',
  ),
  vergleich(
    'n-pk-3',
    'pl-kontrollstrukturen',
    'Logische Operatoren',
    'Mehrere Bedingungen verknüpft man mit UND, ODER und NICHT. Ohne Klammern gilt: NICHT vor UND vor ODER.',
    [
      ['Pseudocode', 'Java', 'wahr, wenn …'],
      ['UND', '&&', 'beide Seiten wahr sind'],
      ['ODER', '||', 'mindestens eine Seite wahr ist'],
      ['NICHT', '!', 'der Ausdruck falsch ist'],
    ],
  ),
  vergleich(
    'n-pk-4',
    'pl-kontrollstrukturen',
    'Die Wahrheitstabelle',
    'Die Tabelle zeigt alle Kombinationen von zwei Bedingungen a und b. ODER ist hier das einschließende Oder: Es ist auch wahr, wenn beide wahr sind.',
    [
      ['a', 'b', 'a UND b', 'a ODER b'],
      ['falsch', 'falsch', 'falsch', 'falsch'],
      ['falsch', 'wahr', 'falsch', 'wahr'],
      ['wahr', 'falsch', 'falsch', 'wahr'],
      ['wahr', 'wahr', 'wahr', 'wahr'],
    ],
    points: [
      'NICHT wahr = falsch, NICHT falsch = wahr',
      'NICHT (a UND b) ist dasselbe wie NICHT a ODER NICHT b',
    ],
  ),
  beispiel(
    'n-pk-5',
    'pl-kontrollstrukturen',
    'Bedingungen auswerten',
    'Gegeben: alter = 17, mitglied = wahr. Welchen Wert haben die vier Bedingungen?',
    schritte: [
      'alter >= 18 UND mitglied: falsch UND wahr -> falsch',
      'alter >= 18 ODER mitglied: falsch ODER wahr -> wahr',
      'NICHT mitglied: NICHT wahr -> falsch',
      'alter < 18 UND mitglied ODER alter > 65: UND zuerst -> (wahr UND wahr) ODER falsch -> wahr',
    ],
    ergebnis: 'falsch, wahr, falsch, wahr',
  ),
  vergleich(
    'n-pk-6',
    'pl-kontrollstrukturen',
    'Verzweigungen',
    'Je nach Anzahl der Fälle gibt es unterschiedliche Formen.',
    [
      ['Form', 'Einsatz', 'Beispiel'],
      ['if', 'nur ein Dann-Zweig', 'ab 50 € versandfrei'],
      ['if / else', 'zwei Fälle', 'volljährig oder nicht'],
      ['else if', 'mehrere Bereiche', 'Notenstufen nach Punkten'],
      ['switch / case', 'ein Wert, viele Fälle', 'Menüauswahl 1, 2, 3'],
    ],
  ),
  formel(
    'n-pk-7',
    'pl-kontrollstrukturen',
    'Mehrstufige Verzweigung',
    'Bei Bereichen prüft man von oben nach unten. Sobald eine Bedingung zutrifft, wird nur dieser Zweig ausgeführt. Mit 85 Punkten ist die erste Bedingung falsch, die zweite wahr: Ausgabe „gut“. Mit 72 Punkten wäre erst die dritte Bedingung wahr: „befriedigend“.',
    '''WENN punkte >= 92 DANN
  note ← "sehr gut"
SONST WENN punkte >= 81 DANN
  note ← "gut"
SONST WENN punkte >= 67 DANN
  note ← "befriedigend"
SONST
  note ← "nicht befriedigend"
ENDE WENN''',
    merksatz:
        'Die Reihenfolge der Bedingungen zählt: bei >= von der höchsten Grenze abwärts.',
  ),
  formel(
    'n-pk-8',
    'pl-kontrollstrukturen',
    'Mehrfachauswahl',
    'switch vergleicht einen Wert mit festen Fällen. In Java beendet break den Fall, default fängt alle übrigen Werte ab. Im Pseudocode heißt das FALLS … SONST.',
    '''switch (auswahl) {
  case 1:
    anlegen();
    break;
  case 2:
    loeschen();
    break;
  default:
    fehler();
}''',
  ),
  vergleich(
    'n-pk-9',
    'pl-kontrollstrukturen',
    'Schleifen',
    'Entscheidend ist, wann die Bedingung geprüft wird.',
    [
      ['Schleife', 'Prüfung', 'min. Durchläufe'],
      ['while (kopfgesteuert)', 'vor jedem Durchlauf', '0'],
      ['do-while (fußgesteuert)', 'nach jedem Durchlauf', '1'],
      ['for (Zählschleife)', 'vor jedem Durchlauf, mit Zähler', '0'],
    ],
  ),
  formel(
    'n-pk-10',
    'pl-kontrollstrukturen',
    'Drei Schleifen, ein Ergebnis',
    'Alle drei Varianten addieren die Zahlen 1 bis 5 und liefern summe = 15. Die Zählschleife ist hier am kürzesten, weil die Anzahl der Durchläufe feststeht.',
    '''// kopfgesteuert
int i = 1, summe = 0;
while (i <= 5) {
  summe += i;
  i++;
}
// fußgesteuert
int i = 1, summe = 0;
do {
  summe += i;
  i++;
} while (i <= 5);
// Zählschleife
int summe = 0;
for (int i = 1; i <= 5; i++) {
  summe += i;
}''',
  ),
  formel(
    'n-pk-11',
    'pl-kontrollstrukturen',
    'Durchläufe zählen',
    'Die Prüfung fragt gern nach der Anzahl der Durchläufe. Am sichersten: die Werte des Zählers aufschreiben. Bei verschachtelten Schleifen multipliziert man.',
    '''for (int i = 3; i <= 10; i++)
i = 3, 4, ..., 10
-> 10 - 3 + 1 = 8 Durchläufe

for (int i = 0; i < 10; i += 2)
i = 0, 2, 4, 6, 8 -> 5 Durchläufe

for (int i = 10; i > 0; i -= 3)
i = 10, 7, 4, 1 -> 4 Durchläufe

FÜR i VON 1 BIS 3
  FÜR j VON 1 BIS 4
-> 3 × 4 = 12 innere Durchläufe''',
  ),
  falle(
    'n-pk-12',
    'pl-kontrollstrukturen',
    'WIEDERHOLE … BIS ist nicht do-while',
    'Beide Schleifen sind fußgesteuert, aber ihre Bedingungen sind gegensätzlich. WIEDERHOLE … BIS läuft, bis die Bedingung wahr wird (Abbruchbedingung). do-while läuft, solange die Bedingung wahr ist (Laufbedingung).',
    code: '''WIEDERHOLE
  pin ← eingabe()
BIS pin = korrekt

do {
  pin = eingabe();
} while (pin != korrekt);''',
    merksatz:
        'Beim Übersetzen die Bedingung umkehren: BIS x wird zu while (NICHT x).',
  ),
  falle(
    'n-pk-13',
    'pl-kontrollstrukturen',
    'Endlosschleifen und fehlendes break',
    'Wird die Bedingung einer Schleife nie falsch, läuft sie endlos. Typisch, wenn der Zähler im Rumpf nicht verändert wird. Bei switch/case in Java und C fehlt oft das break: Dann laufen auch die folgenden Fälle mit ab.',
    points: [
      'while (i < 10) { summe += i; } - i ändert sich nie',
      'Grenzen prüfen: < und <= unterscheiden sich um genau einen Durchlauf',
    ],
  ),
  merke(
    'n-pk-14',
    'pl-kontrollstrukturen',
    'Auf einen Blick',
    'Welche Struktur passt, verrät meist schon die Aufgabenstellung.',
    points: [
      '„falls“, „wenn“ -> Verzweigung',
      '„für jeden“, „genau n-mal“ -> Zählschleife',
      '„solange“, Anzahl unbekannt -> kopfgesteuert',
      '„mindestens einmal“ -> fußgesteuert',
    ],
    satz:
        'Kopfgesteuert: erst prüfen, dann laufen, vielleicht nie. Fußgesteuert: erst laufen, dann prüfen, mindestens einmal.',
  ),

  // ======================================================= Pseudocode
  konzept(
    'n-pc-1',
    'pl-pseudocode',
    'Wozu Pseudocode?',
    'Pseudocode beschreibt einen Algorithmus unabhängig von einer Programmiersprache. Eine verbindliche Norm gibt es nicht. In der Prüfung zählt, dass die Logik stimmt und die Schreibweise eindeutig und durchgehend gleich ist.',
    points: [
      'eine Anweisung pro Zeile',
      'Einrückung zeigt, was zu einem Block gehört',
      'jeder Block wird geschlossen: ENDE WENN, ENDE FÜR',
      'sprechende Variablennamen',
      'Ist eine Schreibweise in der Aufgabe vorgegeben, übernimm sie',
    ],
  ),
  vergleich(
    'n-pc-2',
    'pl-pseudocode',
    'Die Schlüsselwörter',
    'Diese Schreibweisen sind in Prüfungen üblich. Englische Varianten wie IF, WHILE und FOR sind ebenso verständlich.',
    [
      ['Element', 'Pseudocode'],
      ['Zuweisung', 'x ← 5'],
      ['Verzweigung', 'WENN … DANN … SONST … ENDE WENN'],
      ['kopfgesteuert', 'SOLANGE … ENDE SOLANGE'],
      ['fußgesteuert', 'WIEDERHOLE … BIS …'],
      ['Zählschleife', 'FÜR i VON 1 BIS n … ENDE FÜR'],
      ['Ein-/Ausgabe', 'EINGABE x, AUSGABE x'],
      ['Rückgabe', 'RÜCKGABE x'],
    ],
  ),
  konzept(
    'n-pc-3',
    'pl-pseudocode',
    'Arrays und Index',
    'Ein Array speichert mehrere gleichartige Werte unter einem Namen. Auf ein Element greift man über seinen Index zu, der meist bei 0 beginnt. Ein Array mit n Elementen hat also die Indizes 0 bis n - 1.',
    table: [
      ['Index', '0', '1', '2'],
      ['Wert', '4', '9', '2'],
    ],
    points: [
      'zahlen ← [4, 9, 2]',
      'zahlen[1] ist 9, zahlen[2] ist 2',
      'Länge n = 3, letzter Index = 2',
      'Beginnt der Index laut Aufgabe bei 1, läuft er von 1 bis n',
    ],
  ),
  formel(
    'n-pc-4',
    'pl-pseudocode',
    'Zweidimensionale Arrays',
    'Eine Tabelle speichert man als zweidimensionales Array: erster Index Zeile, zweiter Index Spalte. Durchlaufen wird mit zwei verschachtelten Schleifen.',
    '''// 3 Zeilen, 4 Spalten
summe ← 0
FÜR z VON 0 BIS 2
  FÜR s VON 0 BIS 3
    summe ← summe + m[z][s]
  ENDE FÜR
ENDE FÜR
AUSGABE summe''',
    points: [
      'm[1][2] = Zeile 1, Spalte 2 (bei Index ab 0: zweite Zeile, dritte Spalte)',
      'Die innere Schleife läuft je Zeile komplett durch: 3 × 4 = 12 Zugriffe',
    ],
  ),
  formel(
    'n-pc-5',
    'pl-pseudocode',
    'Funktionen, Parameter, Rückgabewert',
    'Eine Funktion fasst Anweisungen unter einem Namen zusammen. Sie erhält Werte über Parameter und liefert mit RÜCKGABE ein Ergebnis. Eine Funktion ohne Rückgabewert heißt auch Prozedur, in Java void.',
    '''FUNKTION brutto(netto, satz)
  RÜCKGABE netto * (1 + satz)
ENDE FUNKTION

preis ← brutto(100, 0.19)
AUSGABE preis   // 119''',
    points: [
      'Parameter: Platzhalter in der Definition (netto, satz)',
      'Argumente: konkrete Werte beim Aufruf (100, 0.19)',
      'Variablen in der Funktion sind lokal und außerhalb unbekannt',
    ],
  ),
  formel(
    'n-pc-6',
    'pl-pseudocode',
    'Summe und Durchschnitt',
    'Die Summe startet bei 0, jedes Element wird addiert, am Ende wird durch die Anzahl geteilt. Mit [3, 5, 10]: summe = 18, schnitt = 18 / 3 = 6.',
    '''summe ← 0
FÜR i VON 0 BIS n - 1
  summe ← summe + werte[i]
ENDE FÜR
schnitt ← summe / n
AUSGABE schnitt''',
  ),
  formel(
    'n-pc-7',
    'pl-pseudocode',
    'Das Maximum finden',
    'Man nimmt das erste Element als vorläufiges Maximum und vergleicht jedes weitere damit. Mit [4, 9, 2]: max = 4, dann 9 > 4 -> max = 9, dann 2 > 9 ist falsch -> Ausgabe 9. Für das Minimum dreht man nur den Vergleich um.',
    '''max ← zahlen[0]
FÜR i VON 1 BIS n - 1
  WENN zahlen[i] > max DANN
    max ← zahlen[i]
  ENDE WENN
ENDE FÜR
AUSGABE max''',
  ),
  formel(
    'n-pc-8',
    'pl-pseudocode',
    'Zählen mit Bedingung',
    'Oft soll gezählt werden, wie viele Elemente eine Bedingung erfüllen. Der Zähler startet bei 0 und wächst nur im Dann-Zweig. Mit [28, 31, 33, 25] und grenze = 30 ist das Ergebnis 2.',
    '''anzahl ← 0
FÜR i VON 0 BIS n - 1
  WENN temp[i] > grenze DANN
    anzahl ← anzahl + 1
  ENDE WENN
ENDE FÜR
AUSGABE anzahl''',
  ),
  formel(
    'n-pc-9',
    'pl-pseudocode',
    'Lineare Suche',
    'Die Liste wird von vorn nach hinten durchlaufen, bis der gesuchte Wert gefunden ist. Ausgegeben wird seine Position oder -1, wenn er fehlt. Suche nach 7 in [5, 7, 3]: gefunden bei Index 1.',
    '''pos ← -1
i ← 0
SOLANGE i < n UND pos = -1
  WENN liste[i] = gesucht DANN
    pos ← i
  ENDE WENN
  i ← i + 1
ENDE SOLANGE
AUSGABE pos''',
  ),
  beispiel(
    'n-pc-10',
    'pl-pseudocode',
    'IHK-Aufgabe: Lagerbestand prüfen',
    'Das Array bestand enthält den Lagerbestand von n Artikeln. Gib für jeden Artikel unter dem Mindestbestand den Index aus und am Ende, wie viele Artikel nachbestellt werden müssen. Testdaten: bestand = [12, 3, 8, 0], mindest = 5.',
    code: '''anzahl ← 0
FÜR i VON 0 BIS n - 1
  WENN bestand[i] < mindest DANN
    AUSGABE i
    anzahl ← anzahl + 1
  ENDE WENN
ENDE FÜR
AUSGABE anzahl''',
    schritte: [
      'i = 0: 12 < 5 falsch',
      'i = 1: 3 < 5 wahr -> Ausgabe 1, anzahl = 1',
      'i = 2: 8 < 5 falsch',
      'i = 3: 0 < 5 wahr -> Ausgabe 3, anzahl = 2',
    ],
    ergebnis: 'Ausgabe 1, 3 und danach 2',
  ),
  beispiel(
    'n-pc-11',
    'pl-pseudocode',
    'Sortieren mit Bubblesort',
    'Bubblesort vergleicht immer zwei Nachbarn und tauscht sie, wenn sie falsch herum stehen. Nach jedem Durchlauf steht das größte übrige Element am Ende. Sortiere [5, 1, 4, 2].',
    code: '''FÜR i VON 0 BIS n - 2
  FÜR j VON 0 BIS n - 2 - i
    WENN a[j] > a[j + 1] DANN
      hilf ← a[j]
      a[j] ← a[j + 1]
      a[j + 1] ← hilf
    ENDE WENN
  ENDE FÜR
ENDE FÜR''',
    table: [
      ['Durchlauf', 'Array danach'],
      ['Start', '[5, 1, 4, 2]'],
      ['i = 0', '[1, 4, 2, 5]'],
      ['i = 1', '[1, 2, 4, 5]'],
      ['i = 2', '[1, 2, 4, 5]'],
    ],
    schritte: [
      'i = 0: 5/1 tauschen, 5/4 tauschen, 5/2 tauschen, die 5 ist hinten',
      'i = 1: 1/4 bleibt, 4/2 tauschen, die 4 steht richtig',
      'i = 2: 1/2 bleibt, keine Vertauschung mehr',
    ],
    ergebnis: '[1, 2, 4, 5] nach 3 Durchläufen',
  ),
  falle(
    'n-pc-12',
    'pl-pseudocode',
    'Grenzen und Startwerte',
    'Zwei Fehler kosten in der Prüfung regelmäßig Punkte. Erstens: FÜR i VON 0 BIS n greift auf liste[n] zu. Das Element gibt es nicht. Zweitens: Wird das Maximum mit 0 statt mit dem ersten Element begonnen, liefert es bei lauter negativen Werten wie [-5, -2, -8] fälschlich 0.',
  ),
  falle(
    'n-pc-13',
    'pl-pseudocode',
    'Weitere typische Fehler',
    'Diese Fehler fallen erst beim Durchspielen auf. Deshalb jeden eigenen Pseudocode mit kleinen Testdaten prüfen.',
    points: [
      'summe nicht mit 0 initialisiert',
      'Durchschnitt innerhalb statt nach der Schleife berechnet',
      'leeres Array: summe / n teilt durch 0. Vorher n > 0 prüfen',
      'Tausch ohne Hilfsvariable: ein Wert geht verloren',
      'Block nicht geschlossen: fehlendes ENDE WENN',
    ],
  ),
  merke(
    'n-pc-14',
    'pl-pseudocode',
    'Auf einen Blick',
    'Fast jede Pseudocode-Aufgabe ist eine Variante von Summe, Zählen, Maximum oder Suche.',
    satz:
        'Index von 0 bis n - 1. Summe und Zähler mit 0, Maximum und Minimum mit dem ersten Element starten. Jeden Block schließen.',
  ),

  // ============================================================ Schreibtischtest
  konzept(
    'n-pt-1',
    'pl-schreibtischtest',
    'Programm ohne Computer ausführen',
    'Beim Schreibtischtest führt man einen Algorithmus gedanklich aus und notiert nach jeder Änderung die Werte aller Variablen in einer Tabelle, der Trace-Tabelle. So findet man Logikfehler und erkennt, was ein Programm tatsächlich berechnet.',
    points: [
      'Prüfungsfrage 1: Welcher Wert wird ausgegeben?',
      'Prüfungsfrage 2: Was berechnet der Algorithmus?',
      'Prüfungsfrage 3: Wo steckt der Fehler?',
    ],
  ),
  ablauf(
    'n-pt-2',
    'pl-schreibtischtest',
    'Vorgehen',
    'Wer sauber Buch führt, verrechnet sich nicht.',
    [
      'Für jede Variable eine Spalte anlegen, dazu eine für die Bedingung',
      'Startwerte in die erste Zeile eintragen',
      'Anweisung für Anweisung ausführen, jede Änderung in einer neuen Zeile notieren',
      'Bedingungen jedes Mal mit den aktuellen Werten neu prüfen',
      'Bei falscher Schleifenbedingung weiter hinter der Schleife, Ausgabe notieren',
    ],
  ),
  beispiel(
    'n-pt-3',
    'pl-schreibtischtest',
    'Eine SOLANGE-Schleife',
    'Welchen Wert gibt dieses Programm aus? Die Bedingung x < 5 wird vor jedem Durchlauf mit den aktuellen Werten geprüft.',
    code: '''x ← 1
y ← 0
SOLANGE x < 5
  y ← y + x
  x ← x + 2
ENDE SOLANGE
AUSGABE y''',
    table: [
      ['Zeitpunkt', 'x', 'y', 'x < 5?'],
      ['Start', '1', '0', 'wahr'],
      ['nach Durchlauf 1', '3', '1', 'wahr'],
      ['nach Durchlauf 2', '5', '4', 'falsch'],
    ],
    schritte: [
      'Durchlauf 1: y = 0 + 1 = 1, x = 1 + 2 = 3',
      'Durchlauf 2: y = 1 + 3 = 4, x = 3 + 2 = 5',
      '5 < 5 ist falsch -> Schleife endet, Ausgabe y',
    ],
    ergebnis: 'Ausgabe 4',
  ),
  beispiel(
    'n-pt-4',
    'pl-schreibtischtest',
    'Zählschleife mit Verzweigung',
    'Welchen Wert gibt das Programm aus? MOD liefert den Rest der Division, i MOD 2 = 1 heißt also: i ist ungerade.',
    code: '''summe ← 0
FÜR i VON 1 BIS 5
  WENN i MOD 2 = 1 DANN
    summe ← summe + i * i
  ENDE WENN
ENDE FÜR
AUSGABE summe''',
    table: [
      ['i', 'ungerade?', 'summe'],
      ['1', 'wahr', '0 + 1 = 1'],
      ['2', 'falsch', '1'],
      ['3', 'wahr', '1 + 9 = 10'],
      ['4', 'falsch', '10'],
      ['5', 'wahr', '10 + 25 = 35'],
    ],
    schritte: [
      'Nur bei ungeradem i wird das Quadrat addiert: 1, 9, 25',
      'Probe: 1 + 9 + 25 = 35',
    ],
    ergebnis: 'Ausgabe 35',
  ),
  beispiel(
    'n-pt-5',
    'pl-schreibtischtest',
    'Ein Array durchlaufen',
    'Der Algorithmus sucht in werte = [3, 8, 2, 9, 4] das Maximum und seine Position. Was wird ausgegeben?',
    code: '''max ← werte[0]
pos ← 0
FÜR i VON 1 BIS 4
  WENN werte[i] > max DANN
    max ← werte[i]
    pos ← i
  ENDE WENN
ENDE FÜR
AUSGABE pos, max''',
    table: [
      ['i', 'werte[i]', 'max', 'pos'],
      ['Start', '-', '3', '0'],
      ['1', '8', '8', '1'],
      ['2', '2', '8', '1'],
      ['3', '9', '9', '3'],
      ['4', '4', '9', '3'],
    ],
    schritte: [
      'i = 1: 8 > 3 -> max = 8, pos = 1',
      'i = 2: 2 > 8 falsch, nichts ändert sich',
      'i = 3: 9 > 8 -> max = 9, pos = 3',
      'i = 4: 4 > 9 falsch',
    ],
    ergebnis: 'Ausgabe 3, 9',
  ),
  beispiel(
    'n-pt-6',
    'pl-schreibtischtest',
    'Verschachtelte Schleifen',
    'Welchen Wert hat z am Ende? Achtung: Die innere Schleife läuft nur bis zum aktuellen Wert von i.',
    code: '''z ← 0
FÜR i VON 1 BIS 3
  FÜR j VON 1 BIS i
    z ← z + j
  ENDE FÜR
ENDE FÜR
AUSGABE z''',
    table: [
      ['i', 'j', 'z'],
      ['1', '1', '1'],
      ['2', '1', '2'],
      ['2', '2', '4'],
      ['3', '1', '5'],
      ['3', '2', '7'],
      ['3', '3', '10'],
    ],
    schritte: [
      'i = 1: j läuft von 1 bis 1 -> z = 1',
      'i = 2: j läuft von 1 bis 2 -> z = 1 + 1 + 2 = 4',
      'i = 3: j läuft von 1 bis 3 -> z = 4 + 1 + 2 + 3 = 10',
      'Die innere Schleife läuft insgesamt 1 + 2 + 3 = 6-mal',
    ],
    ergebnis: 'z = 10',
  ),
  beispiel(
    'n-pt-7',
    'pl-schreibtischtest',
    'Was berechnet der Algorithmus?',
    'Führe den Algorithmus für n = 4 aus und beschreibe, was er berechnet.',
    code: '''ergebnis ← 1
FÜR i VON 1 BIS n
  ergebnis ← ergebnis * i
ENDE FÜR
AUSGABE ergebnis''',
    table: [
      ['i', 'ergebnis'],
      ['Start', '1'],
      ['1', '1 × 1 = 1'],
      ['2', '1 × 2 = 2'],
      ['3', '2 × 3 = 6'],
      ['4', '6 × 4 = 24'],
    ],
    schritte: [
      'Es werden alle Zahlen von 1 bis n multipliziert',
      '1 × 2 × 3 × 4 = 24, das ist die Fakultät 4!',
      'Startwert 1 statt 0, sonst bliebe das Produkt immer 0',
    ],
    ergebnis: '24: der Algorithmus berechnet n! (Fakultät)',
  ),
  beispiel(
    'n-pt-8',
    'pl-schreibtischtest',
    'Einen Fehler finden',
    'Der Algorithmus soll die Summe von werte = [4, 6, 8] berechnen, also 18. Finde mit einem Schreibtischtest den Fehler.',
    code: '''summe ← 0
i ← 0
SOLANGE i < 3
  i ← i + 1
  summe ← summe + werte[i]
ENDE SOLANGE''',
    schritte: [
      '0 < 3: i = 1, summe = 0 + werte[1] = 6. Die 4 bei Index 0 wird übersprungen',
      '1 < 3: i = 2, summe = 6 + 8 = 14',
      '2 < 3: i = 3, werte[3] gibt es nicht -> Laufzeitfehler',
      'Korrektur: Erst addieren, dann i erhöhen. Die beiden Zeilen tauschen',
    ],
    ergebnis: 'Fehler: i wird zu früh erhöht. Korrigiert: summe = 18',
  ),
  falle(
    'n-pt-9',
    'pl-schreibtischtest',
    'Reihenfolge der Zuweisungen',
    'Jede Zuweisung arbeitet mit dem Wert, den die Variable in diesem Moment hat. Der klassische Fehler ist der Tausch ohne Hilfsvariable: Bei a = 3 und b = 7 macht a ← b aus a eine 7, danach macht b ← a aus b ebenfalls eine 7. Die 3 ist verloren.',
    points: ['richtig: hilf ← a, a ← b, b ← hilf'],
  ),
  falle(
    'n-pt-10',
    'pl-schreibtischtest',
    'Die Bedingung prüft nur am Anfang',
    'Eine SOLANGE-Schleife prüft ihre Bedingung nur vor jedem Durchlauf, nicht mitten im Rumpf. Der Rumpf läuft immer bis zum Ende, auch wenn die Bedingung zwischendurch schon falsch ist.',
    code: '''x ← 8
SOLANGE x < 10
  x ← x + 5
ENDE SOLANGE
AUSGABE x   // 13, nicht 10''',
    points: [
      'Deshalb: erst den ganzen Rumpf ausführen, dann die Bedingung neu prüfen',
    ],
  ),
  merke(
    'n-pt-11',
    'pl-schreibtischtest',
    'Auf einen Blick',
    'Mit einer sauberen Tabelle ist jeder Schreibtischtest reine Fleißarbeit.',
    satz:
        'Eine Zeile, eine Änderung, eine neue Tabellenzeile. Bedingungen immer mit den aktuellen Werten prüfen.',
  ),

  // ================================================== Klasse, Objekt, Attribut, Methode
  konzept(
    'n-og-1',
    'oo-grundbegriffe',
    'Bauplan und Exemplar',
    'Eine Klasse ist der Bauplan: Sie legt fest, welche Eigenschaften und Fähigkeiten alle Objekte dieser Art haben. Ein Objekt ist ein konkretes Exemplar, das nach diesem Bauplan erzeugt wurde, auch Instanz genannt. Aus einer Klasse Ticket entstehen beliebig viele Ticket-Objekte.',
  ),
  vergleich(
    'n-og-2',
    'oo-grundbegriffe',
    'Die vier Grundbegriffe',
    'Am Beispiel eines Ticketsystems im IT-Support.',
    [
      ['Begriff', 'Bedeutung', 'Beispiel'],
      ['Klasse', 'Bauplan', 'Ticket'],
      ['Objekt', 'konkretes Exemplar', 'Ticket Nr. 4711'],
      ['Attribut', 'Eigenschaft', 'status, prioritaet'],
      ['Methode', 'Fähigkeit, Verhalten', 'schliessen()'],
    ],
  ),
  skizze(
    'n-og-3',
    'oo-grundbegriffe',
    'Die Klasse im Diagramm',
    'So sieht die Klasse Ticket im UML-Klassendiagramm aus. Die Attribute beschreiben, was jedes Ticket hat, die Methoden, was jedes Ticket kann.',
    const KlassenDiagramm([
      UmlKlasse(
        'Ticket',
        attribute: ['- nummer: int', '- status: String', '- prioritaet: int'],
        methoden: [
          '+ schliessen(): void',
          '+ eskalieren(): void',
          '+ getStatus(): String',
        ],
      ),
    ]),
  ),
  konzept(
    'n-og-4',
    'oo-grundbegriffe',
    'Zustand, Verhalten, Identität',
    'Jedes Objekt wird durch drei Merkmale beschrieben.',
    points: [
      'Zustand: die aktuellen Werte seiner Attribute, z. B. status = „offen“',
      'Verhalten: seine Methoden, z. B. schliessen() ändert den Status',
      'Identität: Jedes Objekt ist eigenständig, auch zwei Objekte mit gleichen Werten sind zwei verschiedene Objekte',
    ],
  ),
  vergleich(
    'n-og-5',
    'oo-grundbegriffe',
    'Zwei Objekte einer Klasse',
    't1 und t2 sind aus derselben Klasse Ticket erzeugt. Sie haben dieselben Attribute, aber eigene Werte. Wird t1 geschlossen, bleibt t2 unverändert.',
    [
      ['Attribut', 'Objekt t1', 'Objekt t2'],
      ['nummer', '4711', '4712'],
      ['status', '„offen“', '„geschlossen“'],
      ['prioritaet', '2', '1'],
    ],
  ),
  konzept(
    'n-og-6',
    'oo-grundbegriffe',
    'Methoden genauer',
    'Eine Methode hat einen Namen, eine Parameterliste und einen Rückgabetyp. Name und Parameterliste zusammen heißen Signatur.',
    points: [
      'UML: + berechneBrutto(netto: double): double',
      'Parameter: Werte, die die Methode zum Arbeiten braucht',
      'Rückgabetyp: Typ des Ergebnisses, void = kein Ergebnis',
      'Aufruf mit Punktnotation: t1.schliessen()',
    ],
  ),
  formel(
    'n-og-7',
    'oo-grundbegriffe',
    'Im Code',
    'Die Klasse beschreibt Attribute und Methoden. Mit new entsteht ein Objekt, dessen Methode dann seinen eigenen Zustand ändert.',
    '''class Ticket {
  int nummer;
  String status;

  void schliessen() {
    status = "geschlossen";
  }
}

Ticket t1 = new Ticket();
t1.nummer = 4711;
t1.status = "offen";
t1.schliessen();
// t1.status: "geschlossen"''',
  ),
  konzept(
    'n-og-8',
    'oo-grundbegriffe',
    'Abstraktion',
    'Eine Klasse bildet nicht alles aus der Wirklichkeit ab, sondern nur das, was das Programm braucht. Diese Vereinfachung heißt Abstraktion.',
    points: [
      'Kunde im Webshop: name, lieferadresse, email',
      'Kunde in der Arztpraxis: name, geburtsdatum, versicherung',
      'Die Augenfarbe braucht keine der beiden Anwendungen',
    ],
  ),
  beispiel(
    'n-og-9',
    'oo-grundbegriffe',
    'Eine Klasse aus einer Beschreibung',
    'Aufgabe: „Ein Carsharing-Anbieter verwaltet Fahrzeuge. Jedes Fahrzeug hat ein Kennzeichen, einen Kilometerstand und ist entweder frei oder gebucht. Ein Fahrzeug kann gebucht werden. Bei der Rückgabe werden die gefahrenen Kilometer addiert.“ Modelliere die Klasse.',
    schritte: [
      'Klasse: Fahrzeug (Substantiv, Singular)',
      'Attribute: kennzeichen: String, kmStand: int, gebucht: boolean',
      'Methoden aus den Verben: buchen(), zurueckgeben(km: int)',
      'buchen() liefert boolean und klappt nur, wenn das Fahrzeug frei ist',
      'Attribute private, Methoden public',
    ],
    ergebnis: 'Klasse Fahrzeug mit 3 Attributen und 2 Methoden',
    skizze: const KlassenDiagramm([
      UmlKlasse(
        'Fahrzeug',
        attribute: [
          '- kennzeichen: String',
          '- kmStand: int',
          '- gebucht: boolean',
        ],
        methoden: ['+ buchen(): boolean', '+ zurueckgeben(km: int): void'],
      ),
    ]),
  ),
  falle(
    'n-og-10',
    'oo-grundbegriffe',
    'Klasse ist nicht Objekt',
    'Die Klasse Ticket ist kein Ticket, sondern die Beschreibung aller Tickets. Werte wie „offen“ oder 4711 gehören zu einem Objekt, nicht zur Klasse. Wird t1 geschlossen, bleibt jedes andere Ticket-Objekt unverändert. Jedes hat seinen eigenen Zustand.',
  ),
  falle(
    'n-og-11',
    'oo-grundbegriffe',
    'Attribut oder Methode?',
    'Was sich aus anderen Werten berechnen lässt, speichert man nicht als Attribut. Das Alter ändert sich jedes Jahr. Gespeichert wird das Geburtsdatum, das Alter liefert eine Methode getAlter().',
    points: [
      'Substantive, Eigenschaften -> Attribute',
      'Verben, Tätigkeiten -> Methoden',
      'berechnete Werte (Alter, Summe, Bruttopreis) -> Methode statt Attribut',
    ],
  ),
  merke(
    'n-og-12',
    'oo-grundbegriffe',
    'Auf einen Blick',
    'Vier Begriffe tragen die gesamte Objektorientierung.',
    satz:
        'Klasse = Bauplan, Objekt = Exemplar. Attribute: was es hat. Methoden: was es kann.',
  ),

  // ==================================================== Kapselung und Sichtbarkeit
  konzept(
    'n-ok-1',
    'oo-kapselung',
    'Das Geheimnisprinzip',
    'Kapselung heißt: Die Daten eines Objekts sind von außen nicht direkt erreichbar. Andere Objekte dürfen nur über öffentliche Methoden zugreifen (die Schnittstelle der Klasse).',
    points: [
      'ungültige Werte werden abgefangen, z. B. ein negativer Lagerbestand',
      'das Innenleben lässt sich ändern, ohne aufrufenden Code anzupassen',
      'Fehler bleiben auf eine Klasse begrenzt',
    ],
  ),
  vergleich(
    'n-ok-2',
    'oo-kapselung',
    'Sichtbarkeit in UML und Java',
    'Die Zeichen aus dem Klassendiagramm entsprechen Schlüsselwörtern im Code.',
    [
      ['UML', 'Java', 'Zugriff'],
      ['+', 'public', 'von überall'],
      ['-', 'private', 'nur in der eigenen Klasse'],
      ['#', 'protected', 'Paket und Unterklassen'],
      ['~', 'ohne Angabe', 'nur im selben Paket'],
    ],
  ),
  skizze(
    'n-ok-3',
    'oo-kapselung',
    'Eine gekapselte Klasse',
    'Alle Attribute sind private (-), die Methoden public (+). Von außen lässt sich der Bestand nur über einlagern und auslagern ändern, und diese Methoden prüfen die Werte.',
    const KlassenDiagramm([
      UmlKlasse(
        'Artikel',
        attribute: ['- artikelNr: String', '- bestand: int'],
        methoden: [
          '+ getArtikelNr(): String',
          '+ getBestand(): int',
          '+ einlagern(menge: int): void',
          '+ auslagern(menge: int): boolean',
        ],
      ),
    ]),
  ),
  vergleich(
    'n-ok-4',
    'oo-kapselung',
    'Getter und Setter',
    'Für den Zugriff auf private Attribute gibt es feste Namenskonventionen.',
    [
      ['Art', 'Aufgabe', 'Beispiel'],
      ['Getter', 'liest den Wert', '+ getBestand(): int'],
      ['Getter für boolean', 'liest Ja/Nein', '+ isGebucht(): boolean'],
      ['Setter', 'ändert den Wert', '+ setBestand(b: int): void'],
    ],
  ),
  formel(
    'n-ok-5',
    'oo-kapselung',
    'Setter mit Prüfung',
    'Das Attribut ist private. Der Getter liest es, der Setter ändert es nur, wenn der neue Wert gültig ist.',
    '''class Artikel {
  private int bestand;

  public int getBestand() {
    return bestand;
  }

  public void setBestand(int b) {
    if (b >= 0) {
      bestand = b;
    }
  }
}''',
  ),
  ablauf(
    'n-ok-6',
    'oo-kapselung',
    'Durchgespielt',
    'Eine andere Klasse arbeitet mit einem Artikel-Objekt a.',
    [
      'a.setBestand(20) -> gültig, bestand ist 20',
      'a.setBestand(-5) -> abgelehnt, bestand bleibt 20',
      'a.bestand = -5 -> Compilerfehler, das Attribut ist private',
      'a.getBestand() -> liefert 20',
    ],
  ),
  beispiel(
    'n-ok-7',
    'oo-kapselung',
    'Fachliche Methoden statt Setter',
    'Statt setBestand bietet der Artikel einlagern und auslagern an. Welchen Bestand hat der Artikel nach diesen Aufrufen, wenn er mit 0 startet?',
    code: '''public void einlagern(int m) {
  if (m > 0) {
    bestand += m;
  }
}
public boolean auslagern(int m) {
  if (m > 0 && m <= bestand) {
    bestand -= m;
    return true;
  }
  return false;
}''',
    table: [
      ['Aufruf', 'Rückgabe', 'bestand'],
      ['einlagern(100)', '-', '100'],
      ['auslagern(30)', 'true', '70'],
      ['auslagern(200)', 'false', '70'],
      ['einlagern(-50)', '-', '70'],
    ],
    schritte: [
      'auslagern(30): 30 <= 100 -> Bestand 70, Rückgabe true',
      'auslagern(200): mehr als vorhanden -> abgelehnt, false',
      'einlagern(-50): negative Menge -> ignoriert',
    ],
    ergebnis: 'bestand = 70',
  ),
  konzept(
    'n-ok-8',
    'oo-kapselung',
    'Nur lesen erlaubt',
    'Nicht jedes Attribut braucht einen Setter. Werte, die sich nach dem Anlegen nicht mehr ändern dürfen, setzt der Konstruktor. Danach gibt es nur noch einen Getter.',
    points: [
      'artikelNr, kontoNr, geburtsdatum: nur Getter',
      'bestand: Änderung nur über fachliche Methoden',
      'passwortHash: Getter wäre ein Risiko, daher nur eine Methode pruefePasswort()',
    ],
  ),
  vergleich(
    'n-ok-9',
    'oo-kapselung',
    'Welche Sichtbarkeit wofür?',
    'Als Faustregel gilt: Mach so wenig sichtbar wie möglich und so viel wie nötig.',
    [
      ['Element', 'Sichtbarkeit', 'Grund'],
      ['Attribute', 'private', 'Daten schützen'],
      ['Methoden der Schnittstelle', 'public', 'Nutzung von außen'],
      ['Hilfsmethoden', 'private', 'internes Detail'],
      ['Konstruktor', 'meist public', 'Objekte erzeugen'],
    ],
  ),
  falle(
    'n-ok-10',
    'oo-kapselung',
    'Kapselung nur zum Schein',
    'Wer für jedes Attribut blind Getter und Setter ohne Prüfung anlegt, hat die Kapselung nur zum Schein. Jeder kann weiterhin jeden Wert setzen. Übrigens schützt private vor falscher Verwendung im Code, es verschlüsselt keine Daten.',
  ),
  merke(
    'n-ok-11',
    'oo-kapselung',
    'Auf einen Blick',
    'Kapselung macht eine Klasse zur Blackbox mit klarer Schnittstelle.',
    satz:
        'Attribute private, Zugriff nur über öffentliche Methoden, die prüfen.',
  ),

  // ======================================================== Objekte erzeugen und nutzen
  konzept(
    'n-oc-1',
    'oo-konstruktor',
    'Der Konstruktor',
    'Ein Konstruktor wird beim Erzeugen eines Objekts mit new automatisch aufgerufen und setzt die Startwerte der Attribute. So entsteht nie ein halb fertiges Objekt.',
    points: [
      'heißt genau wie die Klasse',
      'hat keinen Rückgabetyp, auch nicht void',
      'kann Parameter haben',
    ],
  ),
  formel(
    'n-oc-2',
    'oo-konstruktor',
    'Ein Objekt erzeugen',
    'Der Konstruktor übernimmt die Werte aus dem Aufruf. this bezeichnet das Objekt selbst: this.name ist das Attribut, name der Parameter. Nach der letzten Zeile existiert ein Kunde mit dem Namen „Yilmaz“ und der Nummer 1001.',
    '''class Kunde {
  private String name;
  private int kundenNr;

  public Kunde(String name, int nr) {
    this.name = name;
    this.kundenNr = nr;
  }
}

Kunde k = new Kunde("Yilmaz", 1001);''',
  ),
  ablauf(
    'n-oc-3',
    'oo-konstruktor',
    'Was bei new passiert',
    'Die Anweisung Kunde k = new Kunde("Yilmaz", 1001); löst mehrere Schritte aus.',
    [
      'Speicher für ein neues Objekt reservieren',
      'Attribute mit Standardwerten belegen: 0, false oder null',
      'Konstruktor ausführen: name = „Yilmaz“, kundenNr = 1001',
      'Referenz auf das Objekt in der Variable k speichern',
    ],
  ),
  vergleich(
    'n-oc-4',
    'oo-konstruktor',
    'Konstruktoren überladen',
    'Eine Klasse kann mehrere Konstruktoren haben, wenn sich ihre Parameterlisten in Anzahl, Typ oder Reihenfolge der Typen unterscheiden. Welcher aufgerufen wird, entscheiden die Argumente.',
    [
      ['Konstruktor', 'passender Aufruf'],
      ['Kunde()', 'new Kunde()'],
      ['Kunde(String n)', 'new Kunde("Meier")'],
      ['Kunde(String n, int nr)', 'new Kunde("Meier", 1002)'],
    ],
    merksatz:
        'Schreibt man keinen Konstruktor, legt Java automatisch einen parameterlosen Standardkonstruktor an, aber nur dann.',
  ),
  skizze(
    'n-oc-5',
    'oo-konstruktor',
    'Konstruktoren im Klassendiagramm',
    'Konstruktoren stehen im Methodenteil, tragen den Klassennamen und haben keinen Rückgabetyp. Hier ist der Konstruktor überladen: einmal nur mit Namen, einmal mit Namen und Nummer.',
    const KlassenDiagramm([
      UmlKlasse(
        'Kunde',
        attribute: ['- name: String', '- kundenNr: int'],
        methoden: [
          '+ Kunde(name: String)',
          '+ Kunde(name: String, nr: int)',
          '+ getName(): String',
        ],
      ),
    ]),
  ),
  konzept(
    'n-oc-6',
    'oo-konstruktor',
    'Variablen speichern Referenzen',
    'Eine Objektvariable enthält nicht das Objekt selbst, sondern einen Verweis darauf. Nach Kunde b = k; zeigen b und k auf dasselbe Objekt. Eine Änderung über b ist auch über k sichtbar. Ein neues Objekt entsteht nur mit new.',
    points: [
      'null: Die Variable zeigt auf kein Objekt',
      'Methodenaufruf auf null führt zu einem Laufzeitfehler (NullPointerException)',
    ],
  ),
  vergleich(
    'n-oc-7',
    'oo-konstruktor',
    'Objekt- und Klassenattribute',
    'Ein normales Attribut hat jedes Objekt für sich. Ein Klassenattribut (static) gibt es nur einmal, alle Objekte teilen es.',
    [
      ['', 'Objektattribut', 'Klassenattribut'],
      ['gehört zu', 'jedem Objekt', 'der Klasse'],
      ['Anzahl', 'eins je Objekt', 'genau eins'],
      ['UML', 'normal', 'unterstrichen'],
      ['Java', 'ohne static', 'static'],
      ['Beispiel', 'name', 'anzahlKunden'],
    ],
  ),
  beispiel(
    'n-oc-8',
    'oo-konstruktor',
    'Objekte zählen mit static',
    'Jedes neue Ticket soll automatisch eine fortlaufende Nummer bekommen. Welche Nummern haben drei nacheinander erzeugte Tickets, und welchen Wert hat zaehler danach?',
    code: '''class Ticket {
  private static int zaehler = 0;
  private int nummer;

  public Ticket() {
    zaehler++;
    nummer = zaehler;
  }
}''',
    table: [
      ['Aufruf', 'zaehler', 'nummer'],
      ['t1 = new Ticket()', '1', '1'],
      ['t2 = new Ticket()', '2', '2'],
      ['t3 = new Ticket()', '3', '3'],
    ],
    schritte: [
      'zaehler gibt es nur einmal für alle Tickets',
      'Jeder Konstruktoraufruf erhöht zaehler um 1',
      'nummer ist ein Objektattribut: Jedes Ticket behält seinen Wert',
    ],
    ergebnis: 'Nummern 1, 2, 3; zaehler = 3',
  ),
  formel(
    'n-oc-9',
    'oo-konstruktor',
    'Beziehungen im Code',
    'Beziehungen aus dem Klassendiagramm werden zu Attributen. Die Multiplizität bestimmt den Typ: bei 1 ein einzelnes Objekt, bei * ein Array oder eine Liste. Bei einer Komposition erzeugt das Ganze seine Teile selbst.',
    '''class Bestellung {
  // Assoziation, Multiplizität 1
  private Kunde kunde;
  // Komposition, Multiplizität *
  private ArrayList<Position> pos;

  public Bestellung(Kunde k) {
    kunde = k;
    pos = new ArrayList<>();
  }
}''',
  ),
  ablauf(
    'n-oc-10',
    'oo-konstruktor',
    'Objekte schicken sich Nachrichten',
    'Objekte arbeiten zusammen, indem sie Methoden anderer Objekte aufrufen. Dafür brauchen sie eine Referenz auf das andere Objekt. Beispiel Webshop:',
    [
      'Der Kunde löst warenkorb.bestellen() aus',
      'Der Warenkorb ruft lager.reservieren(artikel, 2) auf',
      'Das Lager prüft den Bestand und antwortet mit true',
      'Der Warenkorb erzeugt new Rechnung(kunde, summe)',
    ],
  ),
  falle(
    'n-oc-11',
    'oo-konstruktor',
    'Typische Konstruktor-Fehler',
    'Steht void vor dem Namen, ist es kein Konstruktor mehr, sondern eine gewöhnliche Methode. Sie läuft bei new nicht mit. Überladen geht nur über die Parameterliste: Kunde(String name) und Kunde(String vorname) haben dieselbe Signatur und sind nicht erlaubt.',
    points: [
      'name = name; ohne this weist den Parameter sich selbst zu, das Attribut bleibt leer',
      'Gibt es einen Konstruktor mit Parametern, fehlt der Standardkonstruktor: new Kunde() scheitert',
    ],
  ),
  merke(
    'n-oc-12',
    'oo-konstruktor',
    'Auf einen Blick',
    'Objekte entstehen mit new und werden über Referenzen genutzt.',
    satz:
        'Konstruktor: Name wie die Klasse, kein Rückgabetyp, Aufruf über new. static = einmal für alle Objekte.',
  ),
];
