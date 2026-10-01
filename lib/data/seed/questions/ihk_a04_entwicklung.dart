import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben im IHK-Stil zu Bereich 04, Teil 1: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA04Entwicklung = [
  // ================================================ Lastenheft und Pflichtenheft
  freitext(
    'i4-ld-1',
    'af-dokumente',
    scenario:
        'Ein Sanitätshaus möchte seine Lagerverwaltung ablösen und holt dafür Angebote ein. Die Geschäftsführerin fragt, wozu sie neben dem Lastenheft später noch ein Pflichtenheft braucht.',
    prompt:
        'Beschreibe den Unterschied zwischen Lastenheft und Pflichtenheft. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Lastenheft: vom Auftraggeber erstellt',
        stichwoerter: ['auftraggeber', 'kunde', 'kundin', 'besteller'],
      ),
      krit(
        'Lastenheft: beschreibt, was die Lösung leisten soll (Anforderungen, lösungsneutral)',
        stichwoerter: ['was', 'anforderungen', 'lösungsneutral', 'ziele'],
      ),
      krit(
        'Pflichtenheft: vom Auftragnehmer erstellt',
        stichwoerter: [
          'auftragnehmer',
          'dienstleister',
          'anbieter',
          'lieferant',
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
    ],
    loesung:
        'Das Lastenheft schreibt der Auftraggeber. Es beschreibt lösungsneutral, was das System leisten soll und wofür. Das Pflichtenheft schreibt der Auftragnehmer. Es beschreibt, wie und womit er die Anforderungen umsetzt, und wird nach der Genehmigung zur Grundlage der Abnahme.',
    explanation:
        'Je Dokument 1 Punkt für den Verfasser und 1 Punkt für den Inhalt. Merkhilfe: Lastenheft = Was und Wofür (Auftraggeber), Pflichtenheft = Wie und Womit (Auftragnehmer).',
  ),
  freitext(
    'i4-ld-2',
    'af-dokumente',
    scenario:
        'Ein Fitnessstudio will eine App für Kursbuchungen entwickeln lassen. Du hilfst der Inhaberin, das Lastenheft zu gliedern.',
    prompt: 'Nenne vier Inhalte, die in ein Lastenheft gehören. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Ausgangssituation / Ist-Zustand',
        stichwoerter: [
          'ist zustand',
          'ausgangssituation',
          'ausgangslage',
          'istanalyse',
        ],
      ),
      krit(
        'Ziele des Projekts / Soll-Zustand',
        stichwoerter: ['ziele', 'zielsetzung', 'soll zustand', 'projektziel'],
      ),
      krit(
        'Funktionale Anforderungen',
        stichwoerter: ['funktionale', 'funktionen', 'produktfunktionen'],
      ),
      krit(
        'Nicht-funktionale Anforderungen / Qualitätsanforderungen',
        stichwoerter: [
          'nicht funktionale',
          'nichtfunktionale',
          'qualität',
          'leistung',
        ],
      ),
      krit(
        'Rahmenbedingungen wie Budget, Termine, vorhandene Technik',
        stichwoerter: [
          'rahmenbedingungen',
          'randbedingungen',
          'budget',
          'termin',
          'zeitrahmen',
        ],
      ),
      krit(
        'Schnittstellen zu vorhandenen Systemen',
        stichwoerter: ['schnittstellen', 'anbindung', 'vorhandene systeme'],
      ),
      krit(
        'Abnahmekriterien / Lieferumfang',
        stichwoerter: ['abnahmekriterien', 'lieferumfang', 'abnahme'],
      ),
    ],
    loesung:
        'Zum Beispiel: Ausgangssituation (Ist-Zustand), Ziele (Soll-Zustand), funktionale Anforderungen, nicht-funktionale Anforderungen, Rahmenbedingungen (Budget, Termine), Schnittstellen, Abnahmekriterien.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Nicht ins Lastenheft gehören technische Entscheidungen wie Programmiersprache oder Architektur - die trifft der Auftragnehmer im Pflichtenheft.',
    difficulty: 1,
  ),
  tabelle(
    'i4-ld-3',
    'af-dokumente',
    scenario:
        'Für eine Projektmappe sollst du Lastenheft und Pflichtenheft gegenüberstellen.',
    prompt: 'Vervollständige die Tabelle. (4 P.)',
    zeilen: [
      ['Merkmal', 'Lastenheft', 'Pflichtenheft'],
      [
        'Verfasser',
        wahl('Auftraggeber', ['Auftragnehmer', 'externer Gutachter']),
        wahl('Auftragnehmer', ['Auftraggeber', 'externer Gutachter']),
      ],
      [
        'Kernfrage',
        wahl('Was und wofür?', ['Wie und womit?', 'Wer und wann?']),
        wahl('Wie und womit?', ['Was und wofür?', 'Wer und wann?']),
      ],
      [
        'Entsteht',
        wahl('vor den Angeboten', [
          'nach der Auftragsvergabe',
          'nach der Abnahme',
        ]),
        wahl('nach der Auftragsvergabe', [
          'vor den Angeboten',
          'nach der Abnahme',
        ]),
      ],
      [
        'Grundlage für',
        wahl('die Angebote', ['die Abnahme', 'die Schlussrechnung']),
        wahl('die Abnahme', ['die Angebote', 'die Schlussrechnung']),
      ],
    ],
    explanation:
        'Der Auftraggeber beschreibt im Lastenheft vor der Angebotsphase, was er braucht - darauf kalkulieren die Anbieter. Nach der Vergabe beschreibt der Auftragnehmer im Pflichtenheft, wie und womit er umsetzt. Das genehmigte Pflichtenheft ist Maßstab der Abnahme.',
    punkte: 4,
    difficulty: 1,
  ),

  // ===================================================== Arten von Anforderungen
  freitext(
    'i4-fa-1',
    'af-arten',
    scenario:
        'Gesprächsnotiz aus der Tierarztpraxis Lindner: „Das Team will Termine anlegen, verschieben und absagen. Tierhalter sollen am Vortag automatisch per SMS erinnert werden. Auch bei 20 gleichzeitig angemeldeten Nutzern darf eine Suche höchstens 2 Sekunden dauern. Die Daten dürfen nur in der EU gespeichert werden. Neue Mitarbeitende sollen nach einer Stunde Einweisung damit arbeiten können.“',
    prompt:
        'Nenne aus der Gesprächsnotiz zwei funktionale und zwei nicht-funktionale Anforderungen. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Funktional: Termine anlegen, verschieben und absagen',
        stichwoerter: ['anlegen', 'verschieben', 'absagen', 'terminverwaltung'],
      ),
      krit(
        'Funktional: automatische Erinnerung per SMS am Vortag',
        stichwoerter: ['sms', 'erinnerung', 'erinnert', 'erinnern'],
      ),
      krit(
        'Nicht-funktional: Suche höchstens 2 Sekunden bei 20 gleichzeitigen Nutzern (Leistung)',
        stichwoerter: [
          '2 sekunden',
          'gleichzeitig',
          'antwortzeit',
          'leistung',
          'performance',
        ],
      ),
      krit(
        'Nicht-funktional: Speicherung nur in der EU (Randbedingung)',
        stichwoerter: ['eu', 'speicherort', 'datenschutz', 'randbedingung'],
      ),
      krit(
        'Nicht-funktional: nach einer Stunde Einweisung bedienbar (Benutzbarkeit)',
        stichwoerter: [
          'einweisung',
          'benutzbarkeit',
          'bedienbar',
          'einarbeitung',
          'erlernbar',
        ],
      ),
    ],
    loesung:
        'Funktional: Termine anlegen, verschieben und absagen; automatische SMS-Erinnerung am Vortag. Nicht-funktional: Suche in höchstens 2 Sekunden bei 20 gleichzeitigen Nutzern; Speicherung nur in der EU; nach einer Stunde Einweisung bedienbar.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Funktional ist, was das System tut (Termine verwalten, erinnern). Nicht-funktional ist, wie gut oder unter welchen Bedingungen es arbeitet (Antwortzeit, Speicherort, Erlernbarkeit).',
  ),
  markieren(
    'i4-fa-2',
    'af-arten',
    scenario:
        'Ein englischsprachiger Kunde schickt per E-Mail seine Anforderungen an ein Buchungsportal für Besprechungsräume.',
    prompt: 'Markiere alle nicht-funktionalen Anforderungen. (3 P.)',
    zeilen: [
      nein(
        'Users can book a meeting room for a specific date.',
        'Buchen ist eine Tätigkeit des Systems - funktional.',
      ),
      ja(
        'The booking page must load within two seconds.',
        'Ladezeit ist eine Qualitätsanforderung (Leistung).',
      ),
      nein(
        'The system sends a confirmation e-mail after each booking.',
        'Eine Bestätigung zu versenden ist eine Funktion.',
      ),
      ja(
        'The portal must be available 99.5 % of the time.',
        'Verfügbarkeit beschreibt die Zuverlässigkeit, keine Funktion.',
      ),
      ja(
        'All personal data must be stored on servers in the EU.',
        'Der Speicherort ist eine rechtliche Randbedingung.',
      ),
      nein(
        'Administrators can cancel any booking.',
        'Stornieren ist eine Funktion für die Rolle Administrator.',
      ),
    ],
    explanation:
        'Nicht-funktional sind Ladezeit (within two seconds), Verfügbarkeit (available 99.5 %) und Speicherort (servers in the EU). Buchen, Bestätigungsmail und Stornieren beschreiben, was das System tut - funktional.',
    punkte: 3,
  ),
  lueckentext(
    'i4-fa-3',
    'af-arten',
    scenario:
        'Im Lastenheft eines Kundenportals steht: „Das Portal soll schnell und immer erreichbar sein.“ Der Auftragnehmer verlangt eine prüfbare Formulierung.',
    prompt: 'Ergänze die überarbeiteten Anforderungen. (3 P.)',
    text:
        'Bei 200 gleichzeitigen Nutzern wird jede Seite in höchstens {0} aufgebaut.\nDas Portal ist im Jahresmittel zu mindestens {1} verfügbar.\nBeide Anforderungen gehören zu den {2} Anforderungen.',
    luecken: [
      wahl('2 Sekunden', [
        'kurzer Zeit',
        'angemessener Zeit',
      ], 'Nur ein Messwert mit Einheit ist prüfbar.'),
      wahl('99,5 %', [
        'einem hohen Anteil',
        'fast 100 %',
      ], 'Ein Grenzwert in Prozent lässt sich messen.'),
      wahl(
        'nicht-funktionalen',
        ['funktionalen', 'organisatorischen'],
        'Antwortzeit und Verfügbarkeit sind Qualitätsmerkmale.',
      ),
    ],
    explanation:
        'Prüfbar ist eine Anforderung nur mit Messgröße, Grenzwert und Bedingungen: 2 Sekunden bei 200 Nutzern, 99,5 % im Jahresmittel. „Schnell“, „angemessen“ oder „fast“ lassen sich bei der Abnahme nicht entscheiden.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i4-fa-4',
    'af-arten',
    scenario:
        'In einem Lastenheft für eine Lager-App steht die Anforderung: „Die App soll benutzerfreundlich sein.“',
    prompt:
        'Erläutere, warum diese Anforderung so nicht geeignet ist, und formuliere ein Beispiel für eine geeignete Fassung. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Die Anforderung ist nicht messbar / nicht prüfbar, weil ein Kriterium fehlt',
        punkte: 2,
        stichwoerter: [
          'prüfbar',
          'messbar',
          'subjektiv',
          'kriterium',
          'abnahme',
        ],
      ),
      krit(
        'Beispiel mit Messgröße und Grenzwert, z. B. „Wareneingang in höchstens 3 Schritten buchen“',
        stichwoerter: [
          'höchstens',
          'maximal',
          'minuten',
          'schritte',
          'klicks',
          'einweisung',
        ],
      ),
      krit(
        'Folge: Bei der Abnahme lässt sich nicht entscheiden, ob sie erfüllt ist',
        stichwoerter: ['abnahme', 'streit', 'entscheiden', 'nachweisen'],
      ),
    ],
    loesung:
        '„Benutzerfreundlich“ ist subjektiv und nennt kein messbares Kriterium - bei der Abnahme kann niemand entscheiden, ob die Anforderung erfüllt ist. Geeignet wäre zum Beispiel: „Eine neue Lagerkraft bucht nach 30 Minuten Einweisung einen Wareneingang ohne Hilfe in höchstens 3 Bedienschritten.“',
    explanation:
        '2 Punkte für die Begründung (nicht messbar, nicht prüfbar), 1 Punkt für ein Beispiel mit Messgröße und Grenzwert. Andere sinnvolle Beispiele sind möglich.',
  ),

  // ====================================================== Anforderungen erheben
  tabelle(
    'i4-fe-1',
    'af-erhebung',
    scenario:
        'Für die Einführung einer neuen Kassensoftware in 40 Filialen sollst du Erhebungstechniken vergleichen.',
    prompt:
        'Ordne jeder Technik ihren typischen Vorteil und Nachteil zu. (6 P.)',
    zeilen: [
      ['Technik', 'Vorteil', 'Nachteil'],
      [
        'Interview',
        wahl('Rückfragen möglich', [
          'erreicht viele Personen',
          'zeigt unbewusste Abläufe',
        ]),
        wahl('hoher Zeitaufwand je Person', [
          'geringe Rücklaufquote',
          'Beobachtete verhalten sich anders',
        ]),
      ],
      [
        'Fragebogen',
        wahl('erreicht viele Personen', [
          'Rückfragen möglich',
          'zeigt unbewusste Abläufe',
        ]),
        wahl('geringe Rücklaufquote', [
          'hoher Zeitaufwand je Person',
          'Beobachtete verhalten sich anders',
        ]),
      ],
      [
        'Beobachtung',
        wahl('zeigt unbewusste Abläufe', [
          'Rückfragen möglich',
          'erreicht viele Personen',
        ]),
        wahl('Beobachtete verhalten sich anders', [
          'geringe Rücklaufquote',
          'hoher Zeitaufwand je Person',
        ]),
      ],
    ],
    explanation:
        'Das Interview liefert Tiefe durch Rückfragen, kostet aber viel Zeit je Person. Der Fragebogen erreicht viele, kommt aber oft nicht zurück. Die Beobachtung zeigt Routinen, die niemand erwähnt - allerdings arbeiten Beobachtete oft anders als sonst.',
    punkte: 6,
  ),
  freitext(
    'i4-fe-2',
    'af-erhebung',
    scenario:
        'Eine Spedition will ihre Tourenplanung digitalisieren. Betroffen sind 4 Disponenten in der Zentrale und rund 150 Fahrerinnen und Fahrer, die selten im Büro sind.',
    prompt:
        'Beschreibe zwei Erhebungstechniken, mit denen sich die Anforderungen in dieser Situation ermitteln lassen. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Interview mit den Disponenten: wenige Personen, ausführliche Antworten mit Rückfragen',
        punkte: 2,
        stichwoerter: ['interview', 'befragung', 'gespräch', 'rückfragen'],
      ),
      krit(
        'Fragebogen für die Fahrer: viele Personen mit wenig Aufwand erreichbar',
        punkte: 2,
        stichwoerter: [
          'fragebogen',
          'umfrage',
          'onlinebefragung',
          'viele personen',
        ],
      ),
      krit(
        'Beobachtung in der Disposition: zeigt tatsächliche Abläufe und Routinen',
        punkte: 2,
        stichwoerter: ['beobachtung', 'beobachten', 'mitfahren', 'hospitation'],
      ),
      krit(
        'Dokumentenanalyse: vorhandene Tourenlisten und Formulare auswerten',
        punkte: 2,
        stichwoerter: [
          'dokumentenanalyse',
          'unterlagen',
          'formulare',
          'tourenlisten',
        ],
      ),
      krit(
        'Workshop mit Vertretern beider Gruppen: widersprüchliche Wünsche gemeinsam klären',
        punkte: 2,
        stichwoerter: [
          'workshop',
          'gemeinsam',
          'brainstorming',
          'gruppendiskussion',
        ],
      ),
    ],
    loesung:
        'Interview: Die vier Disponenten werden einzeln ausführlich befragt, Rückfragen klären Details der Planung. Fragebogen: Die rund 150 Fahrerinnen und Fahrer erhalten einen kurzen (Online-)Fragebogen, weil sie zahlreich und selten im Büro sind. Ebenfalls möglich: Beobachtung, Dokumentenanalyse, Workshop.',
    explanation:
        'Je Technik 2 Punkte: 1 für die Nennung, 1 für die Ausführung mit Bezug zur Situation. Wenige Schlüsselpersonen befragt man im Interview, viele verstreute Personen per Fragebogen.',
  ),
  freitext(
    'i4-fe-3',
    'af-erhebung',
    scenario:
        'Im Interview sagt eine Lagermitarbeiterin: „Ich tippe jeden Wareneingang von der Liste ab. Das dauert ewig. Mit dem Scanner ginge das viel schneller.“',
    prompt:
        'Formuliere aus dieser Aussage eine User Story nach dem üblichen Muster. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Rolle genannt: „Als Lagermitarbeiterin …“',
        stichwoerter: [
          'als lagermitarbeiterin',
          'als lagerist',
          'als lagermitarbeiter',
          'als mitarbeiterin',
        ],
      ),
      krit(
        'Funktion genannt: „… möchte ich Wareneingänge mit dem Scanner buchen …“',
        stichwoerter: ['möchte ich', 'will ich', 'scanner', 'scannen'],
      ),
      krit(
        'Nutzen genannt: „… damit ich keine Listen abtippen muss / Zeit spare.“',
        stichwoerter: ['damit', 'um zu', 'zeit spare', 'abtippen'],
      ),
    ],
    loesung:
        'Als Lagermitarbeiterin möchte ich Wareneingänge mit dem Scanner buchen, damit ich keine Listen mehr abtippen muss und Zeit spare.',
    explanation:
        'Je Bestandteil 1 Punkt: Rolle (Als …), Funktion (möchte ich …), Nutzen (damit …). Akzeptanzkriterien ergänzen später, wann die Story erfüllt ist.',
    difficulty: 1,
  ),

  // ===================================================== Anwendungsfalldiagramm
  lueckentext(
    'i4-uu-1',
    'u-usecase',
    scenario:
        'Für die App eines Parkhausbetreibers liegt folgendes Anwendungsfalldiagramm vor.',
    skizze: const UseCaseDiagramm(
      system: 'Parkhaus-App',
      faelle: [
        'Parkplatz reservieren',
        'Zahlung durchführen',
        'Rechnung anfordern',
        'Belegung anzeigen',
      ],
      akteure: [
        UcAkteur('Kunde', [0, 3]),
      ],
      beziehungen: [
        UcBeziehung(0, 1, UcArt.include),
        UcBeziehung(2, 0, UcArt.extend),
      ],
    ),
    prompt: 'Ergänze die Aussagen zum Diagramm. (4 P.)',
    text:
        '„Zahlung durchführen“ läuft bei {0} Reservierung ab.\n„Rechnung anfordern“ läuft {1} ab.\nDer «extend»-Pfeil zeigt auf den Anwendungsfall {2}.\nDer Kunde ist direkt mit {3} Anwendungsfällen verbunden.',
    luecken: [
      wahl('jeder', [
        'keiner',
        'mancher',
      ], '«include» bedeutet: Der eingebundene Fall läuft immer mit.'),
      wahl('nur bei Bedarf', [
        'bei jeder Reservierung',
        'vor jeder Zahlung',
      ], '«extend» ist eine Erweiterung unter einer Bedingung.'),
      wahl(
        'Parkplatz reservieren',
        ['Rechnung anfordern', 'Zahlung durchführen'],
        'Bei «extend» zeigt der Pfeil von der Erweiterung zum Basisfall.',
      ),
      zahl(
        2,
        rationale:
            'Linien führen zu „Parkplatz reservieren“ und „Belegung anzeigen“.',
      ),
    ],
    explanation:
        '«include» von „Parkplatz reservieren“ zu „Zahlung durchführen“: Die Zahlung gehört zu jeder Reservierung. „Rechnung anfordern“ erweitert die Reservierung per «extend» nur bei Bedarf, der Pfeil zeigt zum Basisfall. Der Kunde ist mit zwei Fällen assoziiert.',
    punkte: 4,
  ),
  freitext(
    'i4-uu-2',
    'u-usecase',
    scenario:
        'Eine Stadtbibliothek plant einen Selbstverbuchungs-Terminal: Leserinnen und Leser leihen Medien aus und geben sie zurück. Bei jeder Ausleihe wird der Leserausweis geprüft. Das Bibliothekspersonal sperrt verlorene Ausweise. Gebühren werden über einen externen Zahlungsdienst beglichen.',
    prompt:
        'Nenne aus der Beschreibung zwei Akteure und drei Anwendungsfälle für ein Anwendungsfalldiagramm. (5 P.)',
    punkte: 5,
    kriterien: [
      krit(
        'Akteur: Leser/Leserin',
        stichwoerter: ['leser', 'leserin', 'kunde', 'nutzer'],
      ),
      krit(
        'Akteur: Bibliothekspersonal',
        stichwoerter: [
          'bibliothekspersonal',
          'personal',
          'bibliothekar',
          'mitarbeiter',
        ],
      ),
      krit(
        'Akteur: externer Zahlungsdienst',
        stichwoerter: [
          'zahlungsdienst',
          'zahlungsdienstleister',
          'externes system',
        ],
      ),
      krit(
        'Anwendungsfall: Medium ausleihen',
        stichwoerter: ['ausleihen', 'ausleihe', 'entleihen'],
      ),
      krit(
        'Anwendungsfall: Medium zurückgeben',
        stichwoerter: ['zurückgeben', 'rückgabe', 'zurück geben'],
      ),
      krit(
        'Anwendungsfall: Leserausweis prüfen',
        stichwoerter: [
          'ausweis prüfen',
          'leserausweis prüfen',
          'ausweisprüfung',
        ],
      ),
      krit(
        'Anwendungsfall: Ausweis sperren',
        stichwoerter: ['sperren', 'ausweis sperren', 'sperrung'],
      ),
      krit(
        'Anwendungsfall: Gebühren bezahlen',
        stichwoerter: ['gebühren', 'bezahlen', 'begleichen', 'zahlung'],
      ),
    ],
    loesung:
        'Akteure: Leser/Leserin, Bibliothekspersonal, externer Zahlungsdienst. Anwendungsfälle: Medium ausleihen, Medium zurückgeben, Leserausweis prüfen (per «include» Teil der Ausleihe), Ausweis sperren, Gebühren bezahlen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 2 für Akteure und 3 für Anwendungsfälle. Akteure sind Rollen oder externe Systeme außerhalb der Systemgrenze, Anwendungsfälle werden mit Objekt und Verb benannt.',
  ),
  freitext(
    'i4-uu-3',
    'u-usecase',
    scenario:
        'In einem Review fragt eine Kollegin, warum im Diagramm des Webshops „Adresse prüfen“ mit «include» und „Gutschein einlösen“ mit «extend» an „Bestellung aufgeben“ hängt.',
    prompt:
        'Erläutere den Unterschied zwischen «include» und «extend» anhand dieses Beispiels. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        '«include»: Der eingebundene Fall wird bei jeder Ausführung des Basisfalls mit ausgeführt',
        punkte: 2,
        stichwoerter: [
          'immer',
          'jeder bestellung',
          'jedes mal',
          'pflicht',
          'zwingend',
        ],
      ),
      krit(
        '«extend»: Die Erweiterung läuft nur unter einer Bedingung / bei Bedarf ab',
        punkte: 2,
        stichwoerter: [
          'optional',
          'bedingung',
          'bei bedarf',
          'nur wenn',
          'manchmal',
        ],
      ),
    ],
    loesung:
        '«include»: „Adresse prüfen“ ist fester Bestandteil - bei jeder Bestellung wird die Adresse geprüft. «extend»: „Gutschein einlösen“ erweitert die Bestellung nur unter einer Bedingung, nämlich wenn der Kunde einen Gutschein hat. Die Bestellung ist auch ohne die Erweiterung vollständig.',
    explanation:
        'Je Beziehung 2 Punkte: 1 für die Bedeutung, 1 für den Bezug zum Beispiel. Der «include»-Pfeil zeigt vom Basisfall zum eingebundenen Fall, der «extend»-Pfeil von der Erweiterung zum Basisfall.',
  ),
  paare(
    'i4-uu-4',
    'u-usecase',
    scenario:
        'Auf dem Prüfungsbogen ist die Notation des Anwendungsfalldiagramms abgedruckt.',
    prompt: 'Ordne jedem Symbol seine Bedeutung zu. (3 P.)',
    paare: [
      paar('Strichmännchen', 'Akteur (Rolle)'),
      paar('Ellipse', 'Anwendungsfall'),
      paar('Rechteck um die Ellipsen', 'Systemgrenze'),
      paar('durchgezogene Linie', 'Assoziation'),
      paar('gestrichelter Pfeil «include»', 'Pflichtbestandteil'),
      paar('gestrichelter Pfeil «extend»', 'optionale Erweiterung'),
    ],
    explanation:
        'Akteure stehen als Strichmännchen außerhalb der Systemgrenze, Anwendungsfälle als Ellipsen darin. Die Linie verbindet Akteur und Anwendungsfall, gestrichelte Pfeile verbinden Anwendungsfälle untereinander.',
    punkte: 3,
    difficulty: 1,
  ),

  // =============================================================== Klassendiagramm
  lueckentext(
    'i4-uk-1',
    'u-klassen',
    scenario:
        'Für eine Paketverwaltung wird eine Klasse modelliert: Ein Paket hat eine Paketnummer als Text, ein Gewicht in Kilogramm mit Nachkommastellen und die Angabe, ob es als Express verschickt wird. Die Attribute sind nur innerhalb der Klasse sichtbar. Die öffentliche Methode berechnePorto liefert einen Geldbetrag mit Nachkommastellen.',
    prompt: 'Ergänze das Klassendiagramm. (6 P.)',
    mono: true,
    text:
        '{0}\n----------------------------\n{1} paketNr: {2}\n- gewicht: {3}\n- express: {4}\n----------------------------\n+ berechnePorto(): {5}',
    luecken: [
      wort([
        'Paket',
      ], 'Der Klassenname steht im Singular im obersten Abschnitt.'),
      wahl('-', ['+', '#'], 'Nur innerhalb der Klasse sichtbar: private.'),
      wahl('String', ['int', 'boolean'], 'Text.'),
      wahl('double', ['int', 'String'], 'Kommazahl.'),
      wahl('boolean', ['String', 'char'], 'Ja oder nein.'),
      wahl('double', ['void', 'boolean'], 'Die Methode liefert einen Betrag.'),
    ],
    explanation:
        'Oben steht der Klassenname Paket, in der Mitte die Attribute in der Form „Sichtbarkeit Name: Typ“, unten die Methoden mit Rückgabetyp. „-“ ist private, „+“ public. Text ist String, Kommazahl double, Ja/Nein boolean.',
    punkte: 6,
  ),
  tabelle(
    'i4-uk-2',
    'u-klassen',
    scenario:
        'Für ein Personalsystem wird die Klasse Mitarbeiter beschrieben: Jede Person hat einen Namen und eine ganzzahlige Personalnummer. Das Monatsgehalt wird mit Nachkommastellen gespeichert. Alle Attribute sind gekapselt. Die Methode erhoeheGehalt erhält einen Prozentsatz und soll von anderen Klassen aufgerufen werden können, sie liefert nichts zurück.',
    prompt: 'Trage Sichtbarkeit und Typ für das Klassendiagramm ein. (8 P.)',
    zeilen: [
      ['Element', 'Sichtbarkeit', 'Typ / Rückgabetyp'],
      [
        'name',
        wahl('-', ['+', '#']),
        wahl('String', ['int', 'double', 'boolean']),
      ],
      [
        'personalNr',
        wahl('-', ['+', '#']),
        wahl('int', ['String', 'double', 'boolean']),
      ],
      [
        'gehalt',
        wahl('-', ['+', '#']),
        wahl('double', ['int', 'String', 'boolean']),
      ],
      [
        'erhoeheGehalt(prozent: double)',
        wahl('+', ['-', '#']),
        wahl('void', ['double', 'int', 'boolean']),
      ],
    ],
    explanation:
        'Gekapselte Attribute sind private (-). Name: String, Personalnummer: int, Gehalt: double. Die Methode soll von außen aufrufbar sein, also public (+), und liefert nichts zurück: void.',
    punkte: 8,
  ),
  lueckentext(
    'i4-uk-3',
    'u-klassen',
    scenario:
        'Aus dem Fachkonzept eines Webshops: Ein Kunde kann beliebig viele Bestellungen aufgeben, auch keine. Jede Bestellung gehört zu genau einem Kunden. Eine Bestellung besteht aus mindestens einer Position. Eine Position gehört zu genau einer Bestellung und wird mit ihr gelöscht.',
    prompt: 'Wähle die Multiplizitäten und die Beziehungsart. (5 P.)',
    mono: true,
    text:
        'Kunde {0} ------ {1} Bestellung\nBestellung {2} ◆----- {3} Position\n\nGefüllte Raute = {4}',
    luecken: [
      wahl('1', ['0..1', '0..*', '1..*'], 'Genau ein Kunde je Bestellung.'),
      wahl('0..*', ['1', '0..1', '1..*'], 'Beliebig viele, auch keine.'),
      wahl('1', ['0..1', '0..*', '1..*'], 'Genau eine Bestellung je Position.'),
      wahl('1..*', ['1', '0..1', '0..*'], 'Mindestens eine Position.'),
      wahl('Komposition', [
        'Aggregation',
        'Assoziation',
      ], 'Das Teil existiert nicht ohne das Ganze.'),
    ],
    explanation:
        'Die Multiplizität steht an dem Ende, über das sie etwas aussagt: bei Bestellung 0..* (so viele hat ein Kunde), bei Kunde 1. Positionen gibt es mindestens eine (1..*), sie leben und sterben mit der Bestellung - Komposition, gefüllte Raute am Ganzen.',
    punkte: 5,
    difficulty: 3,
  ),
  lueckentext(
    'i4-uk-4',
    'u-klassen',
    scenario:
        'In der Klasse Konto fehlen noch Methoden: einzahlen erhält einen Betrag mit Nachkommastellen und liefert nichts zurück. abheben erhält ebenfalls einen Betrag und meldet, ob die Abhebung geklappt hat. getKontostand hat keinen Parameter und liefert den Kontostand. Alle drei sind von außen aufrufbar.',
    prompt: 'Ergänze die Methodensignaturen in UML-Schreibweise. (5 P.)',
    mono: true,
    text:
        '{0} einzahlen(betrag: {1}): {2}\n+ abheben(betrag: double): {3}\n+ getKontostand(): {4}',
    luecken: [
      wahl('+', ['-', '#'], 'Von außen aufrufbar: public.'),
      wahl('double', ['int', 'boolean'], 'Betrag mit Nachkommastellen.'),
      wahl('void', ['double', 'boolean'], 'Kein Rückgabewert.'),
      wahl('boolean', ['void', 'double'], 'Geklappt: ja oder nein.'),
      wahl('double', ['void', 'boolean'], 'Der Kontostand ist eine Kommazahl.'),
    ],
    explanation:
        'Methoden schreibt man als „Sichtbarkeit Name(Parameter: Typ): Rückgabetyp“. einzahlen liefert nichts (void), abheben meldet Erfolg als boolean, getKontostand liefert den Kontostand als double.',
    punkte: 5,
  ),
  freitext(
    'i4-uk-5',
    'u-klassen',
    scenario: 'Ausschnitt aus dem Klassendiagramm einer Fakturierung.',
    skizze: const KlassenDiagramm(
      [
        UmlKlasse(
          'Rechnung',
          attribute: ['- rechnungsNr: int', '- datum: Date'],
          methoden: ['+ berechneSumme(): double'],
        ),
        UmlKlasse(
          'Position',
          attribute: ['- menge: int', '- einzelpreis: double'],
        ),
      ],
      beziehungen: [
        UmlBeziehung(
          0,
          1,
          art: UmlArt.komposition,
          multVon: '1',
          multZu: '1..*',
          label: 'enthält',
        ),
      ],
    ),
    prompt:
        'Beschreibe die Beziehung zwischen Rechnung und Position: Art der Beziehung und Bedeutung der Multiplizitäten. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Komposition: Eine Position existiert nur als Teil ihrer Rechnung',
        punkte: 2,
        stichwoerter: [
          'komposition',
          'existenzabhängig',
          'teil ganzes',
          'gefüllte raute',
        ],
      ),
      krit(
        'Eine Rechnung enthält mindestens eine Position (1..*)',
        stichwoerter: [
          'mindestens eine',
          '1..*',
          'eine oder mehrere',
          'beliebig viele',
        ],
      ),
      krit(
        'Jede Position gehört zu genau einer Rechnung (1)',
        stichwoerter: [
          'genau einer',
          'genau eine rechnung',
          'nur einer rechnung',
        ],
      ),
      krit(
        'Wird die Rechnung gelöscht, werden auch ihre Positionen gelöscht',
        stichwoerter: ['gelöscht', 'löschen', 'mitgelöscht', 'ohne rechnung'],
      ),
    ],
    loesung:
        'Es ist eine Komposition (gefüllte Raute an Rechnung): Positionen sind Teile der Rechnung und existieren nicht ohne sie. Eine Rechnung enthält mindestens eine Position (1..*), jede Position gehört zu genau einer Rechnung (1). Wird die Rechnung gelöscht, verschwinden ihre Positionen mit.',
    explanation:
        '2 Punkte für die Art (Komposition mit Existenzabhängigkeit), je 1 Punkt für jede richtig gelesene Multiplizität oder die Löschfolge, höchstens 4. Die Raute sitzt immer am Ganzen.',
    difficulty: 3,
  ),
  paare(
    'i4-uk-6',
    'u-klassen',
    scenario:
        'Du liest ein Klassendiagramm, das eine Kollegin für die Auftragsverwaltung gezeichnet hat.',
    prompt: 'Ordne jeder Notation ihre Bedeutung zu. (3 P.)',
    paare: [
      paar('+', 'public: von überall sichtbar'),
      paar('-', 'private: nur in der Klasse'),
      paar('0..*', 'beliebig viele, auch keins'),
      paar('1..*', 'mindestens eins'),
      paar('gefüllte Raute', 'Komposition'),
      paar('leere Raute', 'Aggregation'),
    ],
    explanation:
        'Sichtbarkeiten stehen vor dem Namen (+ public, - private). Multiplizitäten stehen an den Enden der Beziehung. Die Raute sitzt am Ganzen: gefüllt = Komposition, leer = Aggregation.',
    punkte: 3,
    difficulty: 1,
  ),
  markieren(
    'i4-uk-7',
    'u-klassen',
    scenario:
        'Ein Praktikant hat die Klasse Artikel notiert. Einige Zeilen entsprechen nicht der UML-Schreibweise „Sichtbarkeit Name: Typ“ bzw. „Sichtbarkeit Name(Parameter): Rückgabetyp“.',
    prompt: 'Markiere alle Zeilen mit einem Notationsfehler. (3 P.)',
    mono: true,
    zeilen: [
      nein(
        '- artikelNr: String',
        'Sichtbarkeit, Name, Doppelpunkt, Typ - korrekt.',
      ),
      ja(
        '- double preis',
        'Der Typ steht in UML hinter dem Namen: - preis: double.',
      ),
      nein('- bestand: int', 'Korrekt notiertes privates Attribut.'),
      ja(
        '+ getPreis: double',
        'Bei einer Methode fehlen die Klammern: + getPreis(): double.',
      ),
      nein(
        '+ einlagern(menge: int): void',
        'Methode mit Parameter und Rückgabetyp - korrekt.',
      ),
      ja(
        'istLieferbar(): boolean +',
        'Die Sichtbarkeit steht vorn: + istLieferbar(): boolean.',
      ),
    ],
    explanation:
        'In UML gilt: erst die Sichtbarkeit, dann der Name, nach dem Doppelpunkt der Typ. Methoden erkennt man an den Klammern. „- double preis“ ist Java-Reihenfolge, „getPreis: double“ sähe wie ein Attribut aus, und ein „+“ am Zeilenende ist keine gültige Sichtbarkeit.',
    punkte: 3,
  ),

  // ========================================================== Aktivitätsdiagramm
  reihenfolge(
    'i4-ua-1',
    'u-aktivitaet',
    scenario:
        'Ablauf im Support eines Elektronikhändlers: Der Support erfasst die Reklamation und prüft danach die Garantie. Besteht Garantie, wird ein Ersatzgerät verschickt, sonst wird ein Kostenvoranschlag erstellt. In beiden Fällen wird der Vorgang anschließend abgeschlossen.',
    prompt:
        'Erstelle das Aktivitätsdiagramm für den Garantiefall: Bringe die Elemente in die richtige Reihenfolge. (4 P.)',
    items: [
      'Startknoten',
      'Reklamation erfassen',
      'Garantie prüfen',
      'Entscheidung, Kante [Garantie besteht]',
      'Ersatzgerät verschicken',
      'Zusammenführung',
      'Vorgang abschließen',
      'Endknoten',
    ],
    hint: 'Vom Startknoten bis zum Endknoten',
    explanation:
        'Nach dem Startknoten folgen die Aktionen in der beschriebenen Reihenfolge. Die Entscheidung wählt mit dem Guard [Garantie besteht] den Weg zum Ersatzgerät. Die Zusammenführung vereint beide alternativen Wege wieder, danach folgen „Vorgang abschließen“ und der Endknoten.',
    punkte: 4,
  ),
  lueckentext(
    'i4-ua-2',
    'u-aktivitaet',
    scenario:
        'Bestellfreigabe in einem Industriebetrieb: Zuerst wird der Betrag ermittelt. Bestellungen ab 1.000 € brauchen eine Freigabe der Abteilungsleitung, kleinere nicht. Danach werden „Ware bestellen“ und „Budget buchen“ gleichzeitig erledigt. Erst wenn beides fertig ist, endet der Ablauf.',
    prompt:
        'Ergänze die Beschreibung des Aktivitätsdiagramms mit den passenden Begriffen. (7 P.)',
    text:
        'Der Ablauf beginnt am {0}. Nach der Aktion „Betrag ermitteln“ folgt eine {1}. An der Kante zu „Freigabe einholen“ steht die Bedingung {2}, an der anderen Kante {3}. „Ware bestellen“ und „Budget buchen“ starten gemeinsam an einer {4}. Erst hinter der {5} geht es weiter zum {6}.',
    luecken: [
      wort(['Startknoten'], 'Gefüllter Kreis.'),
      wort(['Entscheidung'], 'Raute mit Guards an den Ausgängen.'),
      wort(['[Betrag >= 1000]'], '„Ab 1.000 €“ schließt 1.000 ein.'),
      wort([
        '[Betrag < 1000]',
      ], 'Das Gegenstück, lückenlos und ohne Überschneidung.'),
      wort(['Gabelung'], 'Balken, der parallele Wege startet (Teilung).'),
      wort([
        'Vereinigung',
      ], 'Balken, der auf alle Wege wartet (Synchronisation).'),
      wort(['Endknoten'], 'Kreis mit Ring.'),
    ],
    wortbank: ['[Betrag > 1000]', 'Zusammenführung', 'Aktion'],
    explanation:
        'Entweder-oder ist eine Entscheidung (Raute) mit Guards in eckigen Klammern: „ab 1.000 €“ heißt [Betrag >= 1000], der Rest [Betrag < 1000]. Gleichzeitiges startet an der Gabelung (Balken) und endet an der Vereinigung, die auf beide Wege wartet.',
    punkte: 7,
  ),
  zuordnen(
    'i4-ua-3',
    'u-aktivitaet',
    scenario:
        'Retoure im Onlinehandel: Der Kunde meldet die Rücksendung an und verschickt das Paket. Das Lager nimmt das Paket an und prüft die Ware. Die Buchhaltung erstattet danach den Kaufpreis und verschickt die Gutschrift.',
    prompt:
        'Das Aktivitätsdiagramm erhält drei Swimlanes. Ordne jede Aktion der richtigen Bahn zu. (3 P.)',
    buckets: ['Kunde', 'Lager', 'Buchhaltung'],
    items: [
      zu('Ware prüfen', 1),
      zu('Rücksendung anmelden', 0),
      zu('Kaufpreis erstatten', 2),
      zu('Paket annehmen', 1),
      zu('Paket verschicken', 0),
      zu('Gutschrift verschicken', 2),
    ],
    explanation:
        'Swimlanes zeigen, wer eine Aktion ausführt. Der Kunde meldet an und verschickt, das Lager nimmt an und prüft, die Buchhaltung erstattet und verschickt die Gutschrift. Jede Aktion steht in genau einer Bahn.',
    punkte: 3,
    difficulty: 1,
  ),
  markieren(
    'i4-ua-4',
    'u-aktivitaet',
    scenario:
        'Im Review eines Aktivitätsdiagramms stehen an fünf Entscheidungen jeweils zwei Bedingungen. Bedingungen müssen sich gegenseitig ausschließen und zusammen alle Fälle abdecken.',
    prompt: 'Markiere alle fehlerhaften Bedingungspaare. (2 P.)',
    zeilen: [
      nein(
        '[Menge > 0] und [Menge <= 0]',
        'Lückenlos und ohne Überschneidung.',
      ),
      ja(
        '[Alter > 18] und [Alter < 18]',
        'Der Wert 18 wird von keiner Bedingung abgedeckt.',
      ),
      nein('[bezahlt] und [else]', '[else] fängt alle übrigen Fälle ab.'),
      ja(
        '[Note <= 4] und [Note >= 4]',
        'Bei Note 4 sind beide Bedingungen wahr - nicht eindeutig.',
      ),
      nein(
        '[lieferbar] und [nicht lieferbar]',
        'Genau eines von beiden trifft immer zu.',
      ),
    ],
    explanation:
        'Bei [Alter > 18] und [Alter < 18] fehlt der Grenzwert 18 - der Ablauf bliebe stehen. Bei [Note <= 4] und [Note >= 4] trifft für 4 beides zu - der Weg wäre nicht eindeutig. Richtig sind Paare wie > und <= oder eine Bedingung mit [else].',
    punkte: 2,
  ),
  freitext(
    'i4-ua-5',
    'u-aktivitaet',
    scenario:
        'Ein Auszubildender hat im Aktivitätsdiagramm „Ware verpacken“ und „Rechnung erstellen“ hinter eine Raute gezeichnet. Laut Beschreibung sollen beide Aktionen gleichzeitig ablaufen.',
    prompt:
        'Erläutere den Unterschied zwischen einer Entscheidung (Raute) und einer Gabelung (Balken) und nenne das hier richtige Element. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Entscheidung: Es wird genau einer der ausgehenden Wege genommen, abhängig von einer Bedingung',
        punkte: 2,
        stichwoerter: [
          'genau ein',
          'nur ein weg',
          'bedingung',
          'entweder oder',
          'alternativ',
        ],
      ),
      krit(
        'Gabelung: Alle ausgehenden Wege laufen gleichzeitig / parallel',
        punkte: 2,
        stichwoerter: ['parallel', 'gleichzeitig', 'alle wege', 'nebenläufig'],
      ),
      krit(
        'Hier richtig: Gabelung, weil beide Aktionen gleichzeitig ablaufen',
        stichwoerter: ['gabelung', 'balken', 'fork', 'teilung'],
      ),
      krit(
        'Parallele Wege werden mit einer Vereinigung (Balken) wieder zusammengeführt',
        stichwoerter: ['vereinigung', 'join', 'synchronisation', 'wartet'],
      ),
    ],
    loesung:
        'Nach einer Entscheidung (Raute) läuft genau ein Weg weiter - welcher, bestimmen die Bedingungen an den Kanten. Nach einer Gabelung (Balken) laufen alle Wege parallel. Hier sollen beide Aktionen gleichzeitig ablaufen, also gehört eine Gabelung hin, später eine Vereinigung.',
    explanation:
        'Je 2 Punkte für Entscheidung und Gabelung, weitere Punkte für das richtige Element oder die Vereinigung, höchstens 4. Merke: Raute = entweder-oder, Balken = gleichzeitig.',
  ),
  lueckentext(
    'i4-ua-6',
    'u-aktivitaet',
    scenario: 'Aktivitätsdiagramm für Urlaubsanträge in einem Personalportal.',
    skizze: const FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Antrag stellen'),
      FlussKnoten('Resturlaub prüfen'),
      FlussKnoten(
        'Resttage >= Antrag?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] Antrag ablehnen',
      ),
      FlussKnoten('Antrag genehmigen'),
      FlussKnoten('Kalender eintragen'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
    prompt: 'Ergänze die Aussagen zum Diagramm. (4 P.)',
    text:
        'Die Raute ist eine {0}.\n[ja] und [nein] nennt man {1}.\nBei 5 Resttagen und einem Antrag über 5 Tage wird der Antrag {2}.\nIm [ja]-Fall werden vom Start bis zum Ende insgesamt {3} Aktionen ausgeführt.',
    luecken: [
      wahl('Entscheidung', [
        'Gabelung',
        'Vereinigung',
      ], 'Raute mit einem Eingang und mehreren Ausgängen.'),
      wahl('Bedingungen (Guards)', [
        'Aktionen',
        'Swimlanes',
      ], 'Sie stehen in eckigen Klammern an den Kanten.'),
      wahl('genehmigt', ['abgelehnt', 'nicht bearbeitet'], '5 >= 5 ist wahr.'),
      zahl(
        4,
        rationale:
            'Antrag stellen, Resturlaub prüfen, Antrag genehmigen, Kalender eintragen.',
      ),
    ],
    explanation:
        'Die Raute ist eine Entscheidung, [ja] und [nein] sind ihre Bedingungen (Guards). 5 >= 5 ist wahr, also gilt der [ja]-Zweig: genehmigen. Aktionen sind nur die abgerundeten Rechtecke - Start, Raute und Ende zählen nicht mit: 4 Aktionen.',
    punkte: 4,
  ),
  tabelle(
    'i4-ua-7',
    'u-aktivitaet',
    scenario:
        'Ein Entwickler soll ein Aktivitätsdiagramm in Pseudocode umsetzen und sucht zu jedem Muster die passende Struktur.',
    prompt: 'Wähle zu jedem Muster die passende Struktur. (4 P.)',
    zeilen: [
      ['Muster im Aktivitätsdiagramm', 'Entspricht'],
      [
        'Entscheidung, zwei Wege, Zusammenführung',
        wahl('Verzweigung', [
          'kopfgesteuerte Schleife',
          'fußgesteuerte Schleife',
          'parallele Ausführung',
        ]),
      ],
      [
        'Entscheidung vor der Aktion, Rückkante zur Entscheidung',
        wahl('kopfgesteuerte Schleife', [
          'Verzweigung',
          'fußgesteuerte Schleife',
          'parallele Ausführung',
        ]),
      ],
      [
        'Aktion, danach Entscheidung mit Rückkante zur Aktion',
        wahl('fußgesteuerte Schleife', [
          'Verzweigung',
          'kopfgesteuerte Schleife',
          'parallele Ausführung',
        ]),
      ],
      [
        'Gabelung, zwei Wege, Vereinigung',
        wahl('parallele Ausführung', [
          'Verzweigung',
          'kopfgesteuerte Schleife',
          'fußgesteuerte Schleife',
        ]),
      ],
    ],
    explanation:
        'Eine Entscheidung mit Zusammenführung ist WENN … SONST. Steht die Entscheidung vor der Aktion, kann der Rumpf null Mal laufen (SOLANGE). Steht sie dahinter, läuft er mindestens einmal (WIEDERHOLE … BIS). Balken bedeuten parallele Wege.',
    punkte: 4,
    difficulty: 3,
  ),

  // ===================================================== Variablen und Datentypen
  tabelle(
    'i4-pd-1',
    'pl-datentypen',
    scenario:
        'Für die Artikelverwaltung eines Baumarkts werden Variablen angelegt. Du sollst jeweils den passenden Datentyp wählen.',
    prompt: 'Wähle für jede Variable den Datentyp. (5 P.)',
    zeilen: [
      ['Variable', 'Beispielwert', 'Datentyp'],
      [
        'lagerbestand',
        '250',
        wahl('int', ['double', 'boolean', 'String', 'char']),
      ],
      [
        'artikelNr',
        'K-20417',
        wahl('String', ['int', 'double', 'boolean', 'char']),
      ],
      [
        'gewichtKg',
        '3.75',
        wahl('double', ['int', 'boolean', 'String', 'char']),
      ],
      [
        'lieferbar',
        'wahr',
        wahl('boolean', ['int', 'double', 'String', 'char']),
      ],
      [
        'regalReihe',
        'C',
        wahl('char', ['int', 'double', 'boolean', 'String']),
      ],
    ],
    explanation:
        'Ganze Stückzahl: int. Artikelnummer mit Buchstaben und Bindestrich: String. Gewicht mit Nachkommastellen: double. Lieferbar ja/nein: boolean. Ein einzelner Buchstabe: char.',
    punkte: 5,
    difficulty: 1,
  ),
  freitext(
    'i4-pd-2',
    'pl-datentypen',
    scenario:
        'In einer Kundenverwaltung wurde die Postleitzahl als Ganzzahl (int) gespeichert. Kunden aus Dresden (01067) erhalten nun Post mit der Postleitzahl 1067.',
    prompt:
        'Begründe, warum für die Postleitzahl der Datentyp String besser geeignet ist. (2 P.)',
    punkte: 2,
    kriterien: [
      krit(
        'Eine Ganzzahl speichert keine führenden Nullen - aus 01067 wird 1067',
        punkte: 2,
        stichwoerter: [
          'führende null',
          'führenden nullen',
          'null vorne',
          'null am anfang',
        ],
      ),
      krit(
        'Mit Postleitzahlen wird nicht gerechnet - sie sind Kennzeichen, keine Zahlenwerte',
        stichwoerter: [
          'nicht gerechnet',
          'kein rechnen',
          'kennzeichen',
          'keine rechnung',
        ],
      ),
      krit(
        'Ein String speichert die Zeichenfolge genau so, wie sie eingegeben wurde',
        stichwoerter: ['zeichenfolge', 'zeichenkette', 'text', 'unverändert'],
      ),
    ],
    loesung:
        'Ein int speichert nur den Zahlenwert, führende Nullen gehen verloren: Aus 01067 wird 1067. Mit einer Postleitzahl wird außerdem nie gerechnet - sie ist ein Kennzeichen. Ein String speichert die Zeichenfolge unverändert.',
    explanation:
        '2 Punkte für die führende Null als Kernargument, alternativ je 1 Punkt für „es wird nicht gerechnet“ und „String speichert die Zeichen unverändert“, höchstens 2. Dasselbe gilt für Telefon- und Artikelnummern.',
    difficulty: 1,
  ),
  lueckentext(
    'i4-pd-3',
    'pl-datentypen',
    scenario:
        'Ein Java-Programm verteilt 17 Lizenzen auf Teams. Bei zwei int-Werten ist / eine Ganzzahldivision, % liefert den Rest.',
    prompt: 'Gib die Werte der Variablen an. (3 P.)',
    mono: true,
    text:
        'int a = 17;\nint b = 5;\nint q = a / b;        // q = {0}\nint r = a % b;        // r = {1}\ndouble d = a / 2.0;   // d = {2}',
    luecken: [
      zahl(3, rationale: '17 / 5 = 3 Rest 2 - der Rest fällt weg.'),
      zahl(2, rationale: '17 - 3 × 5 = 2.'),
      zahl(8.5, rationale: '2.0 ist double, also wird mit Komma gerechnet.'),
    ],
    explanation:
        'Zwei int-Werte: 17 / 5 = 3 (Ganzzahldivision), der Rest 17 % 5 ist 2. Sobald ein Operand double ist, rechnet Java mit Nachkommastellen: 17 / 2.0 = 8,5.',
    punkte: 3,
  ),
  markieren(
    'i4-pd-4',
    'pl-datentypen',
    scenario:
        'Der Compiler meldet in einem Java-Programm mehrere Typfehler. Die Meldungen sind verloren gegangen.',
    prompt:
        'Markiere alle Zeilen, in denen Wert und Datentyp nicht zusammenpassen. (3 P.)',
    mono: true,
    zeilen: [
      ja(
        'int menge = 3.5;',
        'Eine Kommazahl passt nicht in int - nötig wäre double.',
      ),
      nein('double preis = 19.99;', 'Kommazahl in double - passt.'),
      ja(
        'boolean aktiv = "ja";',
        'boolean kennt nur true und false, "ja" ist ein String.',
      ),
      nein('String plz = "01067";', 'Text in Anführungszeichen - passt.'),
      ja(
        'char klasse = "AB";',
        'char speichert genau ein Zeichen in einfachen Anführungszeichen.',
      ),
      nein('int stueck = 40;', 'Ganze Zahl in int - passt.'),
    ],
    explanation:
        'int nimmt nur ganze Zahlen, boolean nur true oder false, char genau ein Zeichen wie \'A\'. Die übrigen drei Zeilen sind korrekt: double für Kommazahlen, String für Text, int für ganze Zahlen.',
    punkte: 3,
  ),

  // ========================================================= Kontrollstrukturen
  tabelle(
    'i4-pk-1',
    'pl-kontrollstrukturen',
    scenario:
        'Eine Zählschleife läuft rückwärts mit der Schrittweite 3. Du sollst sie mit einem Schreibtischtest prüfen.',
    code: '''int summe = 0;
for (int i = 10; i > 0; i -= 3) {
  summe = summe + i;
}''',
    prompt:
        'Trage für jeden Durchlauf die Werte von i und summe am Ende des Durchlaufs ein. (4 P.)',
    zeilen: [
      ['Durchlauf', 'i', 'summe'],
      ['1', zahl(10), zahl(10)],
      ['2', zahl(7), zahl(17)],
      ['3', zahl(4), zahl(21)],
      ['4', zahl(1), zahl(22)],
    ],
    explanation:
        'i nimmt die Werte 10, 7, 4 und 1 an. summe: 0 + 10 = 10, 10 + 7 = 17, 17 + 4 = 21, 21 + 1 = 22. Danach wäre i = -2, und -2 > 0 ist falsch - die Schleife endet nach 4 Durchläufen.',
    punkte: 4,
  ),
  lueckentext(
    'i4-pk-2',
    'pl-kontrollstrukturen',
    scenario:
        'Vor dem Start eines Updates soll ein Countdown die Zahlen 5, 4, 3, 2, 1 ausgeben - die 0 nicht.',
    prompt: 'Ergänze die Schleife. (3 P.)',
    mono: true,
    text: 'i ← {0}\nSOLANGE i {1} 0\n  AUSGABE i\n  i ← i {2} 1\nENDE SOLANGE',
    luecken: [
      wahl('5', ['0', '1'], 'Die erste Ausgabe soll 5 sein.'),
      wahl('>', ['>=', '<'], 'Mit >= würde auch 0 ausgegeben.'),
      wahl('-', ['+', '*'], 'Der Zähler muss kleiner werden.'),
    ],
    explanation:
        'Der Zähler startet bei 5 und wird in jedem Durchlauf um 1 verringert. Die Bedingung i > 0 lässt 5, 4, 3, 2, 1 zu. Bei i = 0 ist 0 > 0 falsch - die 0 wird nicht mehr ausgegeben.',
    punkte: 3,
    difficulty: 1,
  ),
  tabelle(
    'i4-pk-3',
    'pl-kontrollstrukturen',
    scenario:
        'Ein Webshop berechnet die Versandkosten aus Bestellwert (in €) und Gewicht (in kg).',
    code: '''WENN wert >= 50 DANN
  versand ← 0
SONST
  WENN gewicht > 10 DANN
    versand ← 8.90
  SONST
    versand ← 4.90
  ENDE WENN
ENDE WENN''',
    prompt: 'Ermittle für jede Bestellung den Wert von versand. (4 P.)',
    zeilen: [
      ['wert', 'gewicht', 'versand'],
      [
        '50',
        '12',
        wahl('0', ['4.90', '8.90']),
      ],
      [
        '49.99',
        '10',
        wahl('4.90', ['0', '8.90']),
      ],
      [
        '20',
        '10.5',
        wahl('8.90', ['0', '4.90']),
      ],
      [
        '80',
        '3',
        wahl('0', ['4.90', '8.90']),
      ],
    ],
    explanation:
        '50 >= 50 ist wahr: versand = 0, das Gewicht wird nicht mehr geprüft. 49.99 >= 50 ist falsch, 10 > 10 ist falsch: 4.90. 20 >= 50 falsch, 10.5 > 10 wahr: 8.90. 80 >= 50 wahr: 0.',
    punkte: 4,
  ),
  markieren(
    'i4-pk-4',
    'pl-kontrollstrukturen',
    scenario:
        'Das Programm soll den Durchschnitt von vier Messwerten berechnen. Die Indizes des Arrays beginnen bei 0. Beim Test bricht es mit einem Zugriffsfehler ab.',
    prompt: 'Markiere die fehlerhafte Zeile. (1 P.)',
    mono: true,
    zeilen: [
      nein('werte ← [4, 8, 15, 16]', 'Vier Werte mit den Indizes 0 bis 3.'),
      nein('n ← 4', 'Die Anzahl der Werte stimmt.'),
      nein('summe ← 0', 'Die Summe startet richtig bei 0.'),
      ja(
        'FÜR i VON 0 BIS n',
        'Die Schleife läuft bis Index 4 - werte[4] gibt es nicht.',
      ),
      nein('  summe ← summe + werte[i]', 'So wird richtig aufsummiert.'),
      nein('ENDE FÜR', 'Schließt die Schleife.'),
      nein(
        'AUSGABE summe / n',
        'Der Durchschnitt wird nach der Schleife gebildet.',
      ),
    ],
    explanation:
        'Bei n = 4 Elementen sind die Indizes 0 bis 3. FÜR i VON 0 BIS n greift im letzten Durchlauf auf werte[4] zu - das Element existiert nicht. Richtig ist FÜR i VON 0 BIS n - 1.',
    punkte: 1,
  ),
  paare(
    'i4-pk-5',
    'pl-kontrollstrukturen',
    scenario:
        'In einem Java-Quelltext sollst du die Kontrollstrukturen benennen.',
    prompt: 'Ordne jeder Zeile die Kontrollstruktur zu. (3 P.)',
    paare: [
      paar('if (alter >= 18) { … }', 'einseitige Verzweigung'),
      paar('while (rest > 0) { … }', 'kopfgesteuerte Schleife'),
      paar('do { … } while (x < 5);', 'fußgesteuerte Schleife'),
      paar('for (int i = 0; i < 10; i++)', 'Zählschleife'),
      paar('switch (wahl) { case 1: … }', 'Mehrfachauswahl'),
    ],
    explanation:
        'if prüft einmal eine Bedingung. while prüft vor jedem Durchlauf (kopfgesteuert), do-while danach (fußgesteuert, mindestens ein Durchlauf). for zählt mit einer Laufvariablen. switch vergleicht einen Wert mit mehreren festen Fällen.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i4-pk-6',
    'pl-kontrollstrukturen',
    scenario:
        'Ein Programm soll eine Menüauswahl einlesen und so lange wiederholen, bis „Beenden“ gewählt wird. Im Team wird diskutiert, ob eine kopf- oder eine fußgesteuerte Schleife besser passt.',
    prompt:
        'Erläutere den Unterschied zwischen einer kopfgesteuerten und einer fußgesteuerten Schleife und begründe deine Wahl für das Menü. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Kopfgesteuert: Bedingung wird vor jedem Durchlauf geprüft, der Rumpf läuft eventuell gar nicht',
        punkte: 2,
        stichwoerter: [
          'vor dem durchlauf',
          'vorher',
          'gar nicht',
          'null mal',
          'zuerst geprüft',
        ],
      ),
      krit(
        'Fußgesteuert: Bedingung wird nach jedem Durchlauf geprüft, der Rumpf läuft mindestens einmal',
        punkte: 2,
        stichwoerter: [
          'mindestens einmal',
          'nach dem durchlauf',
          'nachher',
          'am ende geprüft',
        ],
      ),
      krit(
        'Für das Menü passt die fußgesteuerte Schleife, weil es mindestens einmal angezeigt werden muss',
        stichwoerter: [
          'fußgesteuert',
          'do while',
          'wiederhole',
          'menü mindestens',
        ],
      ),
    ],
    loesung:
        'Die kopfgesteuerte Schleife prüft die Bedingung vor jedem Durchlauf - ist sie von Anfang an falsch, läuft der Rumpf gar nicht. Die fußgesteuerte Schleife prüft erst nach dem Durchlauf, der Rumpf läuft also mindestens einmal. Das Menü muss mindestens einmal angezeigt werden, deshalb passt die fußgesteuerte Schleife.',
    explanation:
        'Je Schleifenart 2 Punkte (Zeitpunkt der Prüfung und Folge für die Anzahl der Durchläufe), 1 Punkt für die begründete Wahl, höchstens 4.',
  ),
  lueckentext(
    'i4-pk-7',
    'pl-kontrollstrukturen',
    scenario:
        'Ein Array werte hat n = 4 Elemente, die Indizes beginnen bei 0. Die Schleife „FÜR i VON 0 BIS n“ führt zu einem Zugriffsfehler und soll korrigiert werden.',
    prompt: 'Korrigiere den Schleifenkopf und ergänze die Begründung. (3 P.)',
    text:
        'Korrekter Schleifenkopf: FÜR i VON 0 BIS {0}\nDer letzte gültige Index ist {1}.\nDie fehlerhafte Schleife greift zusätzlich auf werte[{2}] zu.',
    luecken: [
      wahl('n - 1', ['n + 1', 'n', '1'], 'Indizes laufen von 0 bis n - 1.'),
      zahl(3, rationale: 'n - 1 = 4 - 1 = 3.'),
      zahl(4, rationale: 'BIS n schließt den Index 4 ein, den es nicht gibt.'),
    ],
    explanation:
        'Ein Array mit n Elementen hat die Indizes 0 bis n - 1, hier 0 bis 3. „BIS n“ läuft einen Durchlauf zu weit und greift auf werte[4] zu. Dieser Fehler um genau eins heißt auch Off-by-one-Fehler.',
    punkte: 3,
  ),

  // ============================================================== Pseudocode
  markieren(
    'i4-pc-1',
    'pl-pseudocode',
    scenario:
        'Der Algorithmus soll das Gesamtgewicht einer Lieferung aus n Paketen berechnen. Für die Gewichte [12, 7, 20] gibt er 0 statt 39 aus.',
    prompt: 'Markiere die fehlerhafte Zeile. (1 P.)',
    mono: true,
    zeilen: [
      nein('gesamt ← 0', 'Eine Summe startet richtig bei 0.'),
      nein(
        'FÜR i VON 0 BIS n - 1',
        'Die Schleife besucht jedes Paket genau einmal.',
      ),
      ja(
        '  gesamt ← gesamt * gewicht[i]',
        'Hier wird multipliziert statt addiert - 0 mal irgendetwas bleibt 0.',
      ),
      nein('ENDE FÜR', 'Schließt die Schleife.'),
      nein('AUSGABE gesamt', 'Die Ausgabe erfolgt richtig nach der Schleife.'),
    ],
    explanation:
        'Der Startwert 0 ist für eine Summe richtig. In der Schleife wird aber multipliziert: 0 × 12 = 0, 0 × 7 = 0, 0 × 20 = 0. Richtig ist gesamt ← gesamt + gewicht[i], dann ergibt sich 12 + 7 + 20 = 39.',
    punkte: 1,
  ),
  freitext(
    'i4-pc-2',
    'pl-pseudocode',
    scenario:
        'Der Algorithmus soll das Gesamtgewicht einer Lieferung berechnen. Für die Gewichte [12, 7, 20] gibt er 0 aus.',
    code: '''gesamt ← 0
FÜR i VON 0 BIS n - 1
  gesamt ← gesamt * gewicht[i]
ENDE FÜR
AUSGABE gesamt''',
    prompt:
        'Erläutere den Fehler im Pseudocode und gib die korrigierte Zeile an. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Fehler: In der Schleife wird multipliziert statt addiert',
        stichwoerter: [
          'multipliziert',
          'multiplikation',
          'mal statt plus',
          'statt addiert',
        ],
      ),
      krit(
        'Folge: Wegen des Startwerts 0 bleibt das Ergebnis immer 0',
        stichwoerter: [
          'immer 0',
          'bleibt 0',
          'bleibt null',
          'startwert 0',
          'null mal',
        ],
      ),
      krit(
        'Korrektur: gesamt ← gesamt + gewicht[i]',
        stichwoerter: ['gesamt + gewicht', 'addieren', 'plus', '+ gewicht[i]'],
      ),
    ],
    loesung:
        'In der Schleife wird gesamt mit dem Gewicht multipliziert statt es zu addieren. Da gesamt mit 0 startet, bleibt das Produkt immer 0. Korrekt ist: gesamt ← gesamt + gewicht[i].',
    explanation:
        'Je 1 Punkt für die Fundstelle (Multiplikation), die Auswirkung (Ergebnis bleibt 0) und die korrigierte Zeile. Mit + ergibt sich 12 + 7 + 20 = 39.',
  ),
  lueckentext(
    'i4-pc-3',
    'pl-pseudocode',
    scenario:
        'Eine Funktion soll aus einem Array mit n Preisen den niedrigsten Preis ermitteln und zurückgeben. Die Indizes beginnen bei 0.',
    prompt: 'Ergänze den Pseudocode mit den passenden Bausteinen. (5 P.)',
    mono: true,
    text:
        'FUNKTION kleinster(preise, n)\n  min ← {0}\n  FÜR i VON 1 BIS {1}\n    WENN preise[i] {2} min DANN\n      min ← {3}\n    ENDE WENN\n  ENDE FÜR\n  RÜCKGABE {4}\nENDE FUNKTION',
    luecken: [
      wort(['preise[0]'], 'Das erste Element ist das vorläufige Minimum.'),
      wort(['n - 1'], 'Der letzte Index eines Arrays mit n Elementen.'),
      wort(['<'], 'Gesucht ist ein kleinerer Preis.'),
      wort(['preise[i]'], 'Der kleinere Preis wird übernommen.'),
      wort(['min'], 'Zurückgegeben wird das gefundene Minimum.'),
    ],
    wortbank: ['0', 'n', '>', 'i'],
    explanation:
        'Das Minimum startet mit dem ersten Element, nicht mit 0. Die Schleife vergleicht die übrigen Elemente bis Index n - 1. Ist preise[i] kleiner als min, wird es übernommen. Am Ende liefert RÜCKGABE min das Ergebnis.',
    punkte: 5,
  ),
  paare(
    'i4-pc-4',
    'pl-pseudocode',
    scenario:
        'Die Dokumentation eines Ticketsystems enthält diesen Pseudocode mit englischen Schlüsselwörtern.',
    code: '''count ← 0
for each t in tickets
  if t.status = "open" then
    count ← count + 1
  end if
end for
print count''',
    prompt: 'Ordne jeder Zeile die passende Beschreibung zu. (5 P.)',
    paare: [
      paar('count ← 0', 'Zähler auf 0 setzen'),
      paar('for each t in tickets', 'alle Tickets durchlaufen'),
      paar('if t.status = "open" then', 'prüfen, ob das Ticket offen ist'),
      paar('count ← count + 1', 'Zähler um 1 erhöhen'),
      paar('print count', 'Anzahl offener Tickets ausgeben'),
    ],
    explanation:
        'Der Code zählt die offenen Tickets: Zähler mit 0 starten, jedes Ticket der Liste besuchen (for each), den Status vergleichen (if), bei einem Treffer hochzählen und nach der Schleife das Ergebnis ausgeben (print).',
    punkte: 5,
    difficulty: 1,
  ),
  reihenfolge(
    'i4-pc-5',
    'pl-pseudocode',
    scenario:
        'Eine Funktion soll prüfen, ob eine Artikelnummer x in einer Liste mit n Einträgen vorkommt, und wahr oder falsch zurückgeben.',
    prompt:
        'Bringe die Zeilen der Funktion in die richtige Reihenfolge. (4 P.)',
    items: [
      'FUNKTION enthaelt(liste, n, x)',
      'FÜR i VON 0 BIS n - 1',
      'WENN liste[i] = x DANN',
      'RÜCKGABE wahr',
      'ENDE WENN',
      'ENDE FÜR',
      'RÜCKGABE falsch',
      'ENDE FUNKTION',
    ],
    hint: 'Von der ersten bis zur letzten Zeile',
    explanation:
        'Die Schleife vergleicht jedes Element mit x. Beim ersten Treffer liefert die Funktion sofort wahr. Erst wenn die Schleife ohne Treffer durchgelaufen ist, folgt hinter ENDE FÜR die Rückgabe falsch.',
    punkte: 4,
  ),
  freitext(
    'i4-pc-6',
    'pl-pseudocode',
    scenario:
        'In der englischen Dokumentation eines Shop-Moduls steht folgende Funktion.',
    code: '''// returns the total after discount
function finalPrice(price, qty)
  if qty >= 10 then
    price ← price * 0.95
  end if
  return price * qty
end function''',
    prompt:
        'Erläutere auf Deutsch, was die drei Zeilen „if qty >= 10 then“, „price ← price * 0.95“ und „return price * qty“ bewirken. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'if: prüft, ob die Menge mindestens 10 beträgt',
        stichwoerter: [
          'mindestens 10',
          'ab 10',
          'größer gleich 10',
          'menge prüfen',
          '10 oder mehr',
        ],
      ),
      krit(
        'Zuweisung: senkt den Stückpreis um 5 % (auf 95 %)',
        stichwoerter: ['5 %', '5 prozent', '95 %', 'rabatt', 'reduziert'],
      ),
      krit(
        'return: gibt Stückpreis mal Menge als Gesamtpreis zurück',
        stichwoerter: [
          'gibt zurück',
          'rückgabe',
          'gesamtpreis',
          'preis mal menge',
          'liefert',
        ],
      ),
    ],
    loesung:
        'Die Verzweigung prüft, ob die Menge mindestens 10 Stück beträgt. Nur dann wird der Stückpreis um 5 % gesenkt (mit 0,95 multipliziert). Am Ende gibt die Funktion den Gesamtpreis zurück: Stückpreis mal Menge.',
    explanation:
        'Je Zeile 1 Punkt. Stichworte genügen: Bedingung „ab 10 Stück“, 5 % Mengenrabatt auf den Stückpreis, Rückgabe des Gesamtpreises.',
  ),
  tabelle(
    'i4-pc-7',
    'pl-pseudocode',
    scenario:
        'Die Funktion aus der englischen Dokumentation eines Shop-Moduls wird mit drei Aufrufen getestet.',
    code: '''// returns the total after discount
function finalPrice(price, qty)
  if qty >= 10 then
    price ← price * 0.95
  end if
  return price * qty
end function''',
    prompt:
        'Ermittle für jeden Aufruf den Wert von price vor der Rückgabe und den Rückgabewert. (6 P.)',
    zeilen: [
      ['Aufruf', 'price vor return', 'Rückgabe'],
      [
        'finalPrice(20, 10)',
        zahl(19, toleranz: 0.005),
        zahl(190, toleranz: 0.005),
      ],
      [
        'finalPrice(20, 9)',
        zahl(20, toleranz: 0.005),
        zahl(180, toleranz: 0.005),
      ],
      [
        'finalPrice(8, 25)',
        zahl(7.6, toleranz: 0.005),
        zahl(190, toleranz: 0.005),
      ],
    ],
    explanation:
        'Aufruf 1: 10 >= 10 ist wahr, price = 20 × 0,95 = 19, Rückgabe 19 × 10 = 190. Aufruf 2: 9 >= 10 ist falsch, price bleibt 20, Rückgabe 20 × 9 = 180. Aufruf 3: 25 >= 10 ist wahr, price = 8 × 0,95 = 7,60, Rückgabe 7,60 × 25 = 190.',
    punkte: 6,
  ),
  lueckentext(
    'i4-pc-8',
    'pl-pseudocode',
    scenario:
        'Eine Funktion soll das Porto für eine Sendung liefern: Bis einschließlich 1000 g kostet sie 1,80 €, darüber 2,90 €. Das Ergebnis geht an das aufrufende Programm zurück.',
    prompt: 'Ergänze Bedingung, Zuweisung und Rückgabe. (3 P.)',
    mono: true,
    text:
        'FUNKTION porto(gramm)\n  WENN gramm {0} 1000 DANN\n    preis ← 1.80\n  SONST\n    preis ← {1}\n  ENDE WENN\n  {2} preis\nENDE FUNKTION',
    luecken: [
      wahl('<=', ['<', '>=', '>'], '„Bis einschließlich“ schließt 1000 ein.'),
      wahl('2.90', ['1.80', 'gramm'], 'Der Preis für schwerere Sendungen.'),
      wahl('RÜCKGABE', [
        'AUSGABE',
        'EINGABE',
      ], 'Der Wert geht an den Aufrufer zurück.'),
    ],
    explanation:
        '„Bis einschließlich 1000 g“ heißt gramm <= 1000 - mit < würde eine Sendung mit genau 1000 g zu teuer. Im SONST-Zweig steht der höhere Preis. RÜCKGABE liefert den Wert an das aufrufende Programm, AUSGABE würde ihn nur anzeigen.',
    punkte: 3,
  ),

  // ============================================================ Schreibtischtest
  tabelle(
    'i4-pt-1',
    'pl-schreibtischtest',
    scenario:
        'Ein Lagerprogramm ermittelt, wie viele Stück insgesamt nachbestellt werden müssen, damit jeder Artikel wieder den Sollbestand erreicht.',
    code: '''lager ← [12, 5, 8, 3, 0]
soll ← 5
fehl ← 0
FÜR i VON 0 BIS 4
  WENN lager[i] < soll DANN
    fehl ← fehl + soll - lager[i]
  ENDE WENN
ENDE FÜR
AUSGABE fehl''',
    prompt:
        'Führe einen Schreibtischtest durch: Trage ein, ob die Bedingung zutrifft, und den Wert von fehl am Ende jedes Durchlaufs. (8 P.)',
    zeilen: [
      ['i', 'lager[i]', 'lager[i] < soll', 'fehl'],
      ['0', '12', 'falsch', zahl(0)],
      [
        '1',
        '5',
        wahl('falsch', ['wahr', 'wird nicht geprüft']),
        zahl(0),
      ],
      ['2', '8', 'falsch', zahl(0)],
      [
        '3',
        '3',
        wahl('wahr', ['falsch', 'wird nicht geprüft']),
        zahl(2),
      ],
      ['4', '0', 'wahr', zahl(7)],
      ['Ausgabe', '', '', zahl(7)],
    ],
    explanation:
        'i = 0: 12 < 5 falsch. i = 1: 5 < 5 ist falsch - der Grenzwert zählt bei < nicht mit. i = 2: 8 < 5 falsch. i = 3: 3 < 5 wahr, fehl = 0 + 5 - 3 = 2. i = 4: 0 < 5 wahr, fehl = 2 + 5 - 0 = 7. Ausgabe: 7.',
    punkte: 8,
  ),
  tabelle(
    'i4-pt-2',
    'pl-schreibtischtest',
    scenario:
        'Der IT-Support hat 40 offene Tickets. Pro Tag werden 12 gelöst, 4 neue kommen hinzu. Das Programm zählt die Tage, bis höchstens 8 Tickets offen sind.',
    code: '''offen ← 40
tag ← 0
SOLANGE offen > 8
  offen ← offen - 12 + 4
  tag ← tag + 1
ENDE SOLANGE
AUSGABE tag''',
    prompt: 'Führe einen Schreibtischtest durch und gib die Ausgabe an. (5 P.)',
    zeilen: [
      ['Zeitpunkt', 'offen', 'tag'],
      ['Start', '40', '0'],
      ['nach Durchlauf 1', zahl(32), zahl(1)],
      ['nach Durchlauf 2', zahl(24), zahl(2)],
      ['nach Durchlauf 3', zahl(16), zahl(3)],
      ['nach Durchlauf 4', zahl(8), zahl(4)],
      ['Ausgabe', '', zahl(4)],
    ],
    explanation:
        'Jeder Durchlauf verringert offen um 8: 40, 32, 24, 16, 8. Nach dem vierten Durchlauf ist offen = 8, und 8 > 8 ist falsch - die Schleife endet. Ausgabe: tag = 4.',
    punkte: 5,
  ),
  tabelle(
    'i4-pt-3',
    'pl-schreibtischtest',
    scenario:
        'Ein Händler stuft Kunden nach Jahresumsatz (in €) und Dauer der Kundenbeziehung (in Jahren) ein.',
    code: '''FUNKTION stufe(umsatz, jahre)
  WENN umsatz > 5000 DANN
    WENN jahre >= 3 DANN
      RÜCKGABE "Gold"
    SONST
      RÜCKGABE "Silber"
    ENDE WENN
  SONST
    WENN umsatz > 1000 DANN
      RÜCKGABE "Bronze"
    SONST
      RÜCKGABE "Basis"
    ENDE WENN
  ENDE WENN
ENDE FUNKTION''',
    prompt: 'Gib für jeden Aufruf den Rückgabewert an. (8 P.)',
    zeilen: [
      ['Aufruf', 'Rückgabe'],
      [
        'stufe(5000, 4)',
        wahl('Bronze', ['Gold', 'Silber', 'Basis']),
      ],
      [
        'stufe(5001, 3)',
        wahl('Gold', ['Silber', 'Bronze', 'Basis']),
      ],
      [
        'stufe(8000, 2)',
        wahl('Silber', ['Gold', 'Bronze', 'Basis']),
      ],
      [
        'stufe(1000, 10)',
        wahl('Basis', ['Gold', 'Silber', 'Bronze']),
      ],
    ],
    explanation:
        'stufe(5000, 4): 5000 > 5000 ist falsch, 5000 > 1000 wahr: „Bronze“ - die Jahre spielen hier keine Rolle. stufe(5001, 3): wahr, 3 >= 3 wahr: „Gold“. stufe(8000, 2): wahr, 2 >= 3 falsch: „Silber“. stufe(1000, 10): beide Umsatzbedingungen falsch: „Basis“.',
    punkte: 8,
    difficulty: 3,
  ),
  tabelle(
    'i4-pt-4',
    'pl-schreibtischtest',
    scenario:
        'Eine Druckerei berechnet Aufträge mit folgendem Programm. Getestet wird mit drei Aufträgen: J1 mit 100 Seiten in Farbe, J2 mit 200 Seiten schwarz-weiß, J3 mit 70 Seiten in Farbe.',
    code: '''perPage ← 0.05
color ← 0.15   // extra per color page
setup ← 2.00   // fee per job
total ← 0
for each j in jobs
  cost ← setup + j.pages * perPage
  if j.color then
    cost ← cost + j.pages * color
  end if
  total ← total + cost
end for
// 10 % discount above 50
if total > 50 then
  total ← total * 0.9
end if
print total''',
    prompt:
        'Führe einen Schreibtischtest durch: Berechne die Kosten je Auftrag, die Summe nach der Schleife und die Ausgabe (in €). (8 P.)',
    zeilen: [
      ['Schritt', 'Wert'],
      ['cost für J1', zahl(22, toleranz: 0.005)],
      ['cost für J2', zahl(12, toleranz: 0.005)],
      ['cost für J3', zahl(16, toleranz: 0.005)],
      ['total nach der Schleife', zahl(50, toleranz: 0.005)],
      ['Ausgabe', zahl(50, toleranz: 0.005)],
    ],
    explanation:
        'J1: 2,00 + 100 × 0,05 = 7,00, plus Farbe 100 × 0,15 = 15,00, zusammen 22,00. J2: 2,00 + 200 × 0,05 = 12,00. J3: 2,00 + 3,50 + 10,50 = 16,00. Summe: 50,00. 50 > 50 ist falsch - kein Rabatt, Ausgabe 50,00.',
    punkte: 8,
    difficulty: 3,
  ),
  rechnen(
    'i4-pt-5',
    'pl-schreibtischtest',
    scenario:
        'Ein Testprogramm verändert eine Zahl in vier Durchläufen. MOD liefert den Rest, DIV das ganzzahlige Ergebnis einer Division.',
    code: '''x ← 3
FÜR i VON 1 BIS 4
  WENN x MOD 2 = 0 DANN
    x ← x DIV 2
  SONST
    x ← 3 * x + 1
  ENDE WENN
ENDE FÜR''',
    prompt: 'Ermittle den Wert von x nach dem letzten Durchlauf. (3 P.)',
    answer: 8,
    explanation:
        'Start x = 3. i = 1: 3 ist ungerade, x = 3 × 3 + 1 = 10. i = 2: 10 ist gerade, x = 10 DIV 2 = 5. i = 3: 5 ist ungerade, x = 16. i = 4: 16 ist gerade, x = 8.',
    punkte: 3,
  ),
  markieren(
    'i4-pt-6',
    'pl-schreibtischtest',
    scenario:
        'Die Buchhaltung lässt eine Mahnliste erzeugen. Die Liste orders enthält fünf Bestellungen mit id, total (in €) und paid.',
    code: '''// print unpaid orders with a
// total of at least min
min ← 100
for each o in orders
  if o.total >= min and not o.paid then
    print o.id
  end if
end for''',
    prompt:
        'Führe einen Schreibtischtest durch und markiere alle Bestellungen, deren id ausgegeben wird. (2 P.)',
    mono: true,
    zeilen: [
      ja(
        '4711  total 250.00  paid false',
        '250 >= 100 und nicht bezahlt - wird ausgegeben.',
      ),
      ja(
        '4712  total 100.00  paid false',
        '100 >= 100 ist wahr - der Grenzwert zählt bei >= mit.',
      ),
      nein('4713  total  99.99  paid false', '99.99 >= 100 ist falsch.'),
      nein(
        '4714  total 180.00  paid true',
        'Schon bezahlt: not o.paid ist falsch.',
      ),
      nein(
        '4715  total 100.00  paid true',
        'Der Betrag reicht, aber die Bestellung ist bezahlt.',
      ),
    ],
    explanation:
        'Beide Teilbedingungen müssen wahr sein (and): Betrag mindestens 100 und nicht bezahlt. Das trifft nur auf 4711 und 4712 zu. Bei 4712 ist 100 >= 100 wahr, bei 4713 ist 99.99 >= 100 falsch.',
    punkte: 2,
  ),
  tabelle(
    'i4-pt-7',
    'pl-schreibtischtest',
    scenario:
        'Eine Bildbearbeitung kürzt Seitenverhältnisse mit dem größten gemeinsamen Teiler. Getestet wird mit einem Bild von 90 × 24 Pixeln. MOD liefert den Rest der ganzzahligen Division.',
    code: '''a ← 90
b ← 24
SOLANGE b > 0
  rest ← a MOD b
  a ← b
  b ← rest
ENDE SOLANGE
AUSGABE a''',
    prompt:
        'Führe einen Schreibtischtest durch: Trage die Werte am Ende jedes Durchlaufs und die Ausgabe ein. (10 P.)',
    zeilen: [
      ['Zeitpunkt', 'rest', 'a', 'b'],
      ['Start', '-', '90', '24'],
      ['nach Durchlauf 1', zahl(18), zahl(24), zahl(18)],
      ['nach Durchlauf 2', zahl(6), zahl(18), zahl(6)],
      ['nach Durchlauf 3', zahl(0), zahl(6), zahl(0)],
      ['Ausgabe', '', zahl(6), ''],
    ],
    explanation:
        'Durchlauf 1: 90 MOD 24 = 18 (3 × 24 = 72), a = 24, b = 18. Durchlauf 2: 24 MOD 18 = 6, a = 18, b = 6. Durchlauf 3: 18 MOD 6 = 0, a = 6, b = 0. 0 > 0 ist falsch - Ausgabe 6. Der größte gemeinsame Teiler von 90 und 24 ist 6.',
    punkte: 10,
    difficulty: 3,
  ),

  // ================================================== Klasse, Objekt, Attribut, Methode
  lueckentext(
    'i4-og-1',
    'oo-grundbegriffe',
    scenario:
        'Für das Ausbildungshandbuch sollst du die Grundbegriffe der Objektorientierung am Beispiel einer Fuhrparkverwaltung erklären.',
    prompt: 'Ergänze den Text mit den passenden Begriffen. (4 P.)',
    text:
        'Fahrzeug ist eine {0}: der Bauplan für alle Fahrzeuge. Der Transporter mit dem Kennzeichen HB-KB 204 ist ein {1} dieser Klasse. Sein Kilometerstand ist ein {2}, tanken() ist eine {3}.',
    luecken: [
      wort(['Klasse'], 'Der Bauplan.'),
      wort(['Objekt'], 'Ein konkretes Exemplar.'),
      wort(['Attribut'], 'Eine Eigenschaft mit einem Wert.'),
      wort(['Methode'], 'Eine Fähigkeit, erkennbar an den Klammern.'),
    ],
    wortbank: ['Konstruktor', 'Parameter'],
    explanation:
        'Die Klasse ist der Bauplan, das Objekt ein konkretes Exemplar. Attribute beschreiben die Eigenschaften (Zustand), Methoden das Verhalten. Ein Konstruktor erzeugt Objekte, ein Parameter übergibt Werte an eine Methode.',
    punkte: 4,
    difficulty: 1,
  ),
  freitext(
    'i4-og-2',
    'oo-grundbegriffe',
    scenario:
        'Ein Softwarehaus will eine alte, prozedural geschriebene Lagerverwaltung objektorientiert neu entwickeln. Die Geschäftsführung fragt nach dem Nutzen.',
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
        'Bessere Wartbarkeit durch klare Struktur',
        stichwoerter: [
          'wartbarkeit',
          'wartbar',
          'übersichtlich',
          'struktur',
          'pflege',
        ],
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
        'Kapselung: Daten sind vor unkontrolliertem Zugriff geschützt',
        stichwoerter: [
          'kapselung',
          'datenkapselung',
          'geschützt',
          'zugriffsschutz',
        ],
      ),
      krit(
        'Nähe zur Realität: Objekte bilden reale Dinge ab',
        stichwoerter: [
          'realität',
          'reale objekte',
          'realitätsnah',
          'abbildung',
          'modellierung',
        ],
      ),
    ],
    loesung:
        'Zum Beispiel: Wiederverwendbarkeit (Klassen lassen sich in anderen Programmen erneut nutzen) und bessere Wartbarkeit (Daten und Funktionen stehen zusammen in einer Klasse). Ebenfalls richtig: Erweiterbarkeit, Kapselung, Nähe zur Realität.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 2. Stichworte genügen. Die Lösungsliste ist länger als verlangt - gewertet werden die ersten beiden richtigen Nennungen.',
    difficulty: 1,
  ),
  tabelle(
    'i4-og-3',
    'oo-grundbegriffe',
    scenario:
        'Die Klasse Zaehler hat das Attribut stand (Startwert 0) sowie die Methoden erhoehen() - addiert 1 - und zuruecksetzen() - setzt stand auf 0. Es werden zwei Objekte erzeugt: z1 und z2.',
    prompt:
        'Trage nach jeder Anweisung den Wert von stand in beiden Objekten ein. (5 P.)',
    zeilen: [
      ['Anweisung', 'z1.stand', 'z2.stand'],
      ['z1.erhoehen()', zahl(1), zahl(0)],
      ['z1.erhoehen()', zahl(2), zahl(0)],
      ['z2.erhoehen()', zahl(2), zahl(1)],
      ['z1.zuruecksetzen()', zahl(0), zahl(1)],
      ['z2.erhoehen()', zahl(0), zahl(2)],
    ],
    explanation:
        'Jedes Objekt hat seinen eigenen Zustand. Aufrufe auf z1 ändern nur z1.stand, Aufrufe auf z2 nur z2.stand: (1, 0), (2, 0), (2, 1), nach dem Zurücksetzen von z1 (0, 1), am Ende (0, 2).',
    punkte: 5,
  ),
  freitext(
    'i4-og-4',
    'oo-grundbegriffe',
    scenario:
        'In einer Schulverwaltung gibt es die Klasse Schueler mit den Attributen name und klasse. Im System sind 480 Schülerinnen und Schüler erfasst.',
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
          'beschreibt',
          'legt fest',
        ],
      ),
      krit(
        'Objekt: konkretes Exemplar (Instanz) der Klasse mit eigenen Attributwerten',
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
        'Die Klasse Schueler ist der Bauplan: Sie legt fest, dass jeder Schüler einen Namen und eine Klasse hat. Ein Objekt ist ein konkretes Exemplar mit eigenen Werten, zum Beispiel der Schüler mit name = „Emre Aydin“ und klasse = „FI24a“. Aus der einen Klasse entstehen hier 480 Objekte.',
    explanation:
        'Je Begriff 2 Punkte: 1 für die Erklärung, 1 für den Bezug zum Beispiel. Kurz: Klasse = Bauplan, Objekt = Exemplar mit eigenem Zustand.',
    difficulty: 1,
  ),

  // ==================================================== Kapselung und Sichtbarkeit
  freitext(
    'i4-ok-1',
    'oo-kapselung',
    scenario:
        'In der Klasse Artikel ist das Attribut preis bisher public. Nach einem Fehler in einer anderen Klasse standen im Shop negative Preise. Die Klasse soll deshalb gekapselt werden.',
    prompt:
        'Beschreibe, wie die Kapselung des Attributs preis umgesetzt wird. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Das Attribut wird private - von außen ist kein direkter Zugriff mehr möglich',
        punkte: 2,
        stichwoerter: [
          'private',
          'privat',
          'kein direkter zugriff',
          'nur innerhalb',
        ],
      ),
      krit(
        'Der Zugriff läuft über öffentliche Methoden (Getter und Setter)',
        punkte: 2,
        stichwoerter: [
          'getter',
          'setter',
          'öffentliche methoden',
          'public methoden',
          'setpreis',
        ],
      ),
      krit(
        'Der Setter prüft den Wert und lehnt ungültige (negative) Preise ab',
        punkte: 2,
        stichwoerter: [
          'prüft',
          'prüfung',
          'ungültige',
          'negative',
          'validierung',
        ],
      ),
    ],
    loesung:
        'Das Attribut preis wird private, sodass andere Klassen nicht mehr direkt darauf zugreifen können. Gelesen wird über den öffentlichen Getter getPreis(), geändert über den öffentlichen Setter setPreis(). Der Setter prüft den neuen Wert und übernimmt ihn nur, wenn er nicht negativ ist.',
    explanation:
        'Je Aspekt 2 Punkte, höchstens 4: private Attribute, öffentliche Getter/Setter, Prüfung im Setter. So ändert nur die Klasse selbst ihre Daten - nach ihren eigenen Regeln.',
  ),
  lueckentext(
    'i4-ok-2',
    'oo-kapselung',
    scenario:
        'In der Klasse Artikel soll der Setter für das private Attribut rabatt nur Werte von 0 bis 30 Prozent übernehmen, jeweils einschließlich.',
    prompt: 'Ergänze den Setter. (3 P.)',
    mono: true,
    text:
        'public void setRabatt(int r) {\n  if (r {0} 0 && r <= {1}) {\n    {2}.rabatt = r;\n  }\n}',
    luecken: [
      wahl('>=', ['>', '<'], '0 Prozent sind erlaubt.'),
      wahl('30', ['29', '31'], 'Mit <= ist 30 eingeschlossen.'),
      wahl('this', [
        'r',
        'void',
      ], 'this spricht das Attribut des eigenen Objekts an.'),
    ],
    explanation:
        'Die Bedingung r >= 0 && r <= 30 lässt genau die Werte 0 bis 30 zu. Nur dann wird der Parameter r in das Attribut übernommen: this.rabatt = r. Ungültige Werte verändern das Objekt nicht.',
    punkte: 3,
  ),
  markieren(
    'i4-ok-3',
    'oo-kapselung',
    scenario:
        'Die Klasse Kasse arbeitet mit einem Objekt der Klasse Konto. Der Compiler meldet Fehler wegen unzulässiger Zugriffe.',
    skizze: const KlassenDiagramm([
      UmlKlasse(
        'Konto',
        attribute: ['- kontostand: double', '- pin: String'],
        methoden: [
          '+ einzahlen(b: double): void',
          '+ abheben(b: double): boolean',
          '+ getKontostand(): double',
        ],
      ),
    ]),
    prompt:
        'Markiere alle Zeilen der Klasse Kasse, die gegen die Kapselung verstoßen. (2 P.)',
    mono: true,
    zeilen: [
      nein('Konto k = new Konto();', 'Ein Objekt zu erzeugen ist erlaubt.'),
      nein('k.einzahlen(200);', 'einzahlen ist public.'),
      ja(
        'k.kontostand = 500;',
        'kontostand ist private - kein Zugriff von außen.',
      ),
      nein('double s = k.getKontostand();', 'Der Getter ist public.'),
      ja('k.pin = "0000";', 'pin ist private, einen Setter gibt es nicht.'),
      nein('k.abheben(50);', 'abheben ist public.'),
    ],
    explanation:
        'Mit „-“ gekennzeichnete Attribute sind private: Auf kontostand und pin darf die Klasse Kasse nicht direkt zugreifen. Erlaubt sind nur die öffentlichen Methoden einzahlen, abheben und getKontostand.',
    punkte: 2,
  ),
  tabelle(
    'i4-ok-4',
    'oo-kapselung',
    scenario:
        'Die Klasse Thermostat kapselt das Attribut temperatur (aktuell 20). Der Setter setTemperatur(t) übernimmt den Wert nur, wenn t zwischen 16 und 26 liegt, jeweils einschließlich. Die Aufrufe erfolgen nacheinander.',
    prompt:
        'Trage für jeden Aufruf ein, ob der Wert übernommen wird und welchen Wert temperatur danach hat. (5 P.)',
    zeilen: [
      ['Aufruf', 'übernommen?', 'temperatur danach'],
      [
        'setTemperatur(22)',
        wahl('ja', ['nein', 'Compilerfehler']),
        zahl(22),
      ],
      [
        'setTemperatur(27)',
        wahl('nein', ['ja', 'Compilerfehler']),
        zahl(22),
      ],
      [
        'setTemperatur(26)',
        wahl('ja', ['nein', 'Compilerfehler']),
        zahl(26),
      ],
      [
        'setTemperatur(15)',
        wahl('nein', ['ja', 'Compilerfehler']),
        zahl(26),
      ],
      [
        'setTemperatur(16)',
        wahl('ja', ['nein', 'Compilerfehler']),
        zahl(16),
      ],
    ],
    explanation:
        '22 liegt im Bereich: 22. 27 ist zu hoch: bleibt 22. 26 ist die obere Grenze und eingeschlossen: 26. 15 ist zu niedrig: bleibt 26. 16 ist die untere Grenze und eingeschlossen: 16. Abgelehnte Werte lösen keinen Compilerfehler aus - der Setter ignoriert sie nur.',
    punkte: 5,
  ),

  // ======================================================== Objekte erzeugen und nutzen
  lueckentext(
    'i4-oc-1',
    'oo-konstruktor',
    scenario:
        'Im Ticketsystem soll jedes neue Ticket beim Erzeugen seine Nummer erhalten und mit dem Status „offen“ starten.',
    prompt: 'Ergänze den Konstruktor und die Erzeugung des Objekts. (4 P.)',
    mono: true,
    text:
        'class Ticket {\n  private int nr;\n  private String status;\n\n  public {0}(int nr) {\n    {1}.nr = nr;\n    status = {2};\n  }\n}\n\nTicket t = {3} Ticket(4711);',
    luecken: [
      wahl(
        'Ticket',
        ['void Ticket', 'int Ticket', 'konstruktor'],
        'Der Konstruktor heißt wie die Klasse und hat keinen Rückgabetyp.',
      ),
      wahl('this', [
        'Ticket',
        'int',
      ], 'this.nr ist das Attribut, nr der Parameter.'),
      wahl('"offen"', ['nr', 'null'], 'Der vorgegebene Startwert.'),
      wahl('new', [
        'class',
        'this',
      ], 'new erzeugt das Objekt und ruft den Konstruktor auf.'),
    ],
    explanation:
        'Der Konstruktor trägt den Klassennamen und hat keinen Rückgabetyp - auch nicht void. this.nr = nr kopiert den Parameter in das Attribut. status erhält den Startwert "offen". Erzeugt wird das Objekt mit new Ticket(4711).',
    punkte: 4,
  ),
  tabelle(
    'i4-oc-2',
    'oo-konstruktor',
    scenario:
        'Der Konstruktor von Konto setzt den Startbetrag, einzahlen(b) addiert b. Zuerst werden zwei Objekte erzeugt: Konto a = new Konto(100); Konto b = new Konto(40); Danach folgen vier Anweisungen.',
    prompt:
        'Trage nach jeder Anweisung ein, welchen Wert a.getStand() und b.getStand() liefern. (8 P.)',
    zeilen: [
      ['Anweisung', 'a.getStand()', 'b.getStand()'],
      ['Konto c = a;', zahl(100), zahl(40)],
      ['c.einzahlen(50);', zahl(150), zahl(40)],
      ['b = c;', zahl(150), zahl(150)],
      ['b.einzahlen(10);', zahl(160), zahl(160)],
    ],
    explanation:
        'c = a kopiert nur die Referenz: a und c zeigen auf dasselbe Objekt, also wirkt c.einzahlen(50) auch auf a (150). Nach b = c zeigt auch b auf dieses Objekt (150). b.einzahlen(10) ändert es auf 160 - für a, b und c. Das Objekt mit 40 ist nicht mehr erreichbar.',
    punkte: 8,
    difficulty: 3,
  ),
  freitext(
    'i4-oc-3',
    'oo-konstruktor',
    scenario:
        'In einem Code-Review fällt auf, dass neue Objekte der Klasse Kunde ohne Namen und Kundennummer im System landen. Die Klasse hat keinen eigenen Konstruktor.',
    prompt:
        'Beschreibe die Aufgabe eines Konstruktors und nenne zwei Merkmale, an denen man ihn im Quelltext erkennt. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Aufgabe: versetzt ein neues Objekt in einen gültigen Anfangszustand (setzt Startwerte der Attribute)',
        punkte: 2,
        stichwoerter: [
          'initialisiert',
          'initialisieren',
          'startwerte',
          'anfangszustand',
          'anfangswerte',
        ],
      ),
      krit(
        'Merkmal: Er heißt genau wie die Klasse',
        stichwoerter: [
          'wie die klasse',
          'klassenname',
          'gleicher name',
          'name der klasse',
        ],
      ),
      krit(
        'Merkmal: Er hat keinen Rückgabetyp, auch nicht void',
        stichwoerter: [
          'kein rückgabetyp',
          'keinen rückgabetyp',
          'ohne rückgabetyp',
          'kein void',
        ],
      ),
      krit(
        'Merkmal: Er wird beim Erzeugen mit new automatisch aufgerufen',
        stichwoerter: [
          'new',
          'beim erzeugen',
          'automatisch aufgerufen',
          'erzeugung',
        ],
      ),
    ],
    loesung:
        'Der Konstruktor versetzt ein neues Objekt in einen gültigen Anfangszustand: Er setzt die Startwerte der Attribute, hier Name und Kundennummer. Man erkennt ihn daran, dass er genau wie die Klasse heißt und keinen Rückgabetyp hat. Aufgerufen wird er beim Erzeugen mit new.',
    explanation:
        '2 Punkte für die Aufgabe (Objekt initialisieren), je 1 Punkt pro Merkmal, höchstens 4. Mit einem Konstruktor Kunde(String name, int nr) kann kein Kunde mehr ohne diese Angaben entstehen.',
  ),
  paare(
    'i4-oc-4',
    'oo-konstruktor',
    scenario:
        'Ein Java-Programm arbeitet mit Objekten der Klasse Kunde. Du erklärst einer neuen Kollegin die Zeilen.',
    prompt: 'Ordne jeder Zeile die passende Beschreibung zu. (4 P.)',
    paare: [
      paar('Kunde k = new Kunde("Ay");', 'Objekt erzeugen'),
      paar('String n = k.getName();', 'Attributwert über Getter lesen'),
      paar('Kunde k2 = k;', 'Referenz kopieren, kein neues Objekt'),
      paar('this.name = name;', 'Parameter ins Attribut übernehmen'),
      paar('k.setName("Ayhan");', 'Attributwert über Setter ändern'),
    ],
    explanation:
        'new erzeugt ein Objekt und ruft den Konstruktor auf. Eine Zuweisung wie k2 = k kopiert nur die Referenz - beide Variablen zeigen auf dasselbe Objekt. this.name ist das Attribut, name der Parameter. Getter lesen, Setter ändern den Wert.',
    punkte: 4,
  ),
];
