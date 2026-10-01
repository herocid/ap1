import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 04, Teil 1: Anforderungen, UML, Programmierlogik und
/// Objektorientierung. Zu af-dokumente, af-arten und af-erhebung gibt es
/// bereits Aufgaben in seed_anforderungen.dart (lh-001 bis lh-005).
final List<Question> questionsA04Entwicklung = [
  // ================================================ Lastenheft und Pflichtenheft
  einfach(
    'a4-ld-1',
    'af-dokumente',
    scenario:
        'Eine Arztpraxis beschreibt schriftlich: „Patientinnen und Patienten sollen Termine online buchen können.“ Ein Dienstleister antwortet mit einem Dokument, das eine Webanwendung mit REST-Anbindung an die Praxissoftware und einen Testplan beschreibt.',
    prompt:
        'Um welches Dokument handelt es sich bei der Antwort des Dienstleisters?',
    choices: [
      ja(
        'Pflichtenheft',
        'Der Auftragnehmer beschreibt, wie und womit er die Anforderungen umsetzt.',
      ),
      nein(
        'Lastenheft',
        'Das Lastenheft schreibt der Auftraggeber, hier die Praxis mit ihrer Beschreibung.',
      ),
      nein(
        'Abnahmeprotokoll',
        'Das entsteht erst am Ende, wenn das fertige Ergebnis geprüft wird.',
      ),
      nein(
        'Projektauftrag',
        'Er gibt ein Projekt intern frei und beschreibt keine technische Lösung.',
      ),
    ],
    explanation:
        'Die Praxis hat als Auftraggeber das Lastenheft (Was?) geliefert. Die technische Lösung mit Architektur, Schnittstelle und Testplan (Wie?) ist das Pflichtenheft des Auftragnehmers.',
    difficulty: 1,
  ),
  lueckentext(
    'a4-ld-2',
    'af-dokumente',
    scenario:
        'Ein Softwarehaus hat den Auftrag für ein Kundenportal erhalten und schreibt nun das Pflichtenheft.',
    prompt:
        'Ergänze, was im Pflichtenheft gegenüber dem Lastenheft hinzukommt.',
    text:
        'Das Pflichtenheft übernimmt die Anforderungen aus dem {0}. Es ergänzt, womit umgesetzt wird (eingesetzte {1}), wie die Teile zusammenspielen (Systemarchitektur und {2}) und woran die Abnahme gemessen wird (konkrete {3}).',
    luecken: [
      wort(['Lastenheft'], 'Dort beginnt alles: mit den Anforderungen.'),
      wort([
        'Technologien',
      ], 'Womit umgesetzt wird, entscheidet der Auftragnehmer.'),
      wort(['Schnittstellen'], 'Sie gehören zum technischen Wie der Lösung.'),
      wort(['Testfälle'], 'Sie machen die Anforderungen prüfbar.'),
    ],
    wortbank: ['Angebote', 'Budgetvorgaben'],
    explanation:
        'Das Lastenheft enthält Ausgangslage, Ziele und Anforderungen. Das Pflichtenheft übernimmt sie und ergänzt das Lösungskonzept: Technologien, Architektur, Schnittstellen und Abnahmekriterien.',
  ),
  zuordnen(
    'a4-ld-3',
    'af-dokumente',
    scenario: 'Ein Autohaus lässt eine App für Werkstatttermine entwickeln.',
    prompt: 'In welches Dokument gehört die Angabe?',
    buckets: ['Lastenheft', 'Pflichtenheft'],
    items: [
      zu(
        'Heute werden Termine nur telefonisch vergeben.',
        0,
        'Ist-Zustand aus Sicht des Auftraggebers.',
      ),
      zu(
        'Kunden sollen Termine rund um die Uhr buchen können.',
        0,
        'Fachliche Anforderung ohne technische Lösung.',
      ),
      zu(
        'Das Budget beträgt höchstens 40.000 €.',
        0,
        'Rahmenbedingung des Auftraggebers.',
      ),
      zu(
        'Die App wird mit Flutter für Android und iOS entwickelt.',
        1,
        'Technologieentscheidung des Auftragnehmers.',
      ),
      zu(
        'Die Termine werden per REST-API aus dem Werkstattsystem gelesen.',
        1,
        'Schnittstelle: das technische Wie.',
      ),
      zu(
        'Testfall 12: Buchung ohne freien Termin wird abgelehnt.',
        1,
        'Konkrete Testfälle für die Abnahme stehen im Pflichtenheft.',
      ),
    ],
    explanation:
        'Das Lastenheft beschreibt lösungsneutral Ist-Zustand, Ziele, Anforderungen und Rahmenbedingungen des Auftraggebers. Das Pflichtenheft ergänzt Technologien, Schnittstellen und prüfbare Testfälle.',
  ),
  einfach(
    'a4-ld-4',
    'af-dokumente',
    scenario:
        'Bei der Abnahme bemängelt der Kunde, dass ein Excel-Export fehlt. Er stand im Lastenheft, wurde aber nicht ins Pflichtenheft übernommen. Der Kunde hat das Pflichtenheft vor Projektbeginn genehmigt.',
    prompt: 'Welche Aussage entspricht der üblichen Projektpraxis?',
    choices: [
      ja(
        'Maßstab ist das genehmigte Pflichtenheft. Der Export muss über einen Änderungsantrag nachbeauftragt werden.',
        'Mit der Genehmigung hat der Kunde den Leistungsumfang bestätigt.',
      ),
      nein(
        'Der Auftragnehmer muss den Export kostenlos liefern, weil er im Lastenheft steht.',
        'Abgenommen wird gegen das genehmigte Pflichtenheft, nicht gegen das Lastenheft.',
      ),
      nein(
        'Die Abnahme ist unmöglich, bis ein neues Lastenheft geschrieben wurde.',
        'Ein neues Lastenheft ist nicht nötig, denn die Änderung läuft über einen Änderungsantrag.',
      ),
      nein(
        'Der Kunde hätte das Pflichtenheft selbst schreiben müssen.',
        'Das Pflichtenheft schreibt immer der Auftragnehmer.',
      ),
    ],
    explanation:
        'Das Pflichtenheft wird mit der Genehmigung durch den Auftraggeber verbindlich und ist Grundlage der Abnahme. Was dort fehlt, ist nicht vereinbart. Zusätzliche Leistungen werden per Änderungsantrag (Change Request) mit Kosten und Termin nachbeauftragt.',
    difficulty: 3,
  ),
  reihenfolge(
    'a4-ld-5',
    'af-dokumente',
    prompt:
        'Bringe die Schritte vom Kundenwunsch bis zur Abnahme in die richtige Reihenfolge.',
    items: [
      'Auftraggeber erstellt das Lastenheft',
      'Anbieter geben Angebote ab',
      'Auftrag wird vergeben',
      'Auftragnehmer erstellt das Pflichtenheft',
      'Auftraggeber genehmigt das Pflichtenheft',
      'Umsetzung und Test',
      'Abnahme gegen das Pflichtenheft',
    ],
    explanation:
        'Das Lastenheft ist Grundlage für die Angebote. Nach der Vergabe schreibt der Auftragnehmer das Pflichtenheft, das der Auftraggeber genehmigt. Erst dann wird umgesetzt und am Ende gegen das Pflichtenheft abgenommen.',
  ),
  lueckentext(
    'a4-ld-6',
    'af-dokumente',
    scenario:
        'Eine Schreinerei will eine Auftragsverwaltung einführen. Die Inhaberin fragt, was ein Lastenheft ausmacht.',
    prompt: 'Vervollständige die Aussagen zum Lastenheft.',
    text:
        'Das Lastenheft erstellt der {0}.\nEs ist {1} formuliert.\nEs dient als Grundlage für die {2}.\nAbgenommen wird am Ende gegen das genehmigte {3}.',
    luecken: [
      wahl('Auftraggeber', [
        'Auftragnehmer',
        'Projektleiter des Anbieters',
      ], 'Der Kunde beschreibt, was er braucht.'),
      wahl(
        'lösungsneutral',
        ['technisch detailliert', 'als Testplan'],
        'Es beschreibt das Was, nicht das Wie. So bleiben Angebote vergleichbar.',
      ),
      wahl(
        'Angebote',
        ['Abnahme', 'Schlussrechnung'],
        'Anbieter kalkulieren auf Basis der beschriebenen Anforderungen.',
      ),
      wahl('Pflichtenheft', [
        'Lastenheft',
        'Angebot',
      ], 'Technik und Abnahmegrundlage stehen im Pflichtenheft.'),
    ],
    explanation:
        'Das Lastenheft schreibt der Auftraggeber lösungsneutral: Ist-Zustand, Ziele, Anforderungen, Rahmenbedingungen. Es dient als Basis für Angebote. Technik und Abnahmegrundlage stehen im Pflichtenheft.',
  ),
  einfach(
    'a4-ld-7',
    'af-dokumente',
    scenario:
        'In einem Dokument steht: „Urlaubsanträge werden derzeit auf Papier gestellt und per Hauspost verteilt. Die Bearbeitung dauert bis zu zehn Tage, Anträge gehen regelmäßig verloren.“',
    prompt: 'Zu welchem Teil gehört dieser Abschnitt?',
    choices: [
      ja(
        'Ist-Analyse im Lastenheft',
        'Er beschreibt den heutigen Zustand mit seinen Schwachstellen.',
      ),
      nein('Soll-Konzept', 'Das Soll beschreibt, wie es künftig laufen soll.'),
      nein(
        'Lösungskonzept im Pflichtenheft',
        'Es wird keine technische Lösung beschrieben.',
      ),
      nein(
        'Abnahmeprotokoll',
        'Das hält das Ergebnis der Prüfung am Projektende fest.',
      ),
    ],
    explanation:
        'Die Ist-Analyse beschreibt, wie es heute läuft, und sammelt Schwachstellen (Papier, Dauer, Verluste). Daraus leitet das Soll-Konzept die Ziele ab, etwa einen digitalen Antrag mit Freigabe per Mausklick.',
    difficulty: 1,
  ),

  // ===================================================== Arten von Anforderungen
  einfach(
    'a4-fa-1',
    'af-arten',
    scenario:
        'Für die neue Ticket-App des IT-Supports liegen vier Anforderungen vor.',
    prompt: 'Welche Anforderung ist funktional?',
    choices: [
      ja(
        'Mitarbeitende können einem Ticket einen Screenshot anhängen.',
        'Das beschreibt eine Tätigkeit des Systems.',
      ),
      nein(
        'Die App ist zu 99,5 % im Jahr verfügbar.',
        'Verfügbarkeit ist eine Qualitätseigenschaft.',
      ),
      nein(
        'Die App läuft auf Android ab Version 12.',
        'Das ist eine Randbedingung zur Plattform.',
      ),
      nein(
        'Die Ticketliste lädt in höchstens 2 Sekunden.',
        'Das beschreibt, wie schnell, also nicht-funktional.',
      ),
    ],
    explanation:
        'Funktional ist, was das System tut (Screenshot anhängen). Verfügbarkeit, Plattform und Antwortzeit beschreiben, wie gut oder unter welchen Bedingungen es arbeitet.',
    difficulty: 1,
  ),
  tabelle(
    'a4-fa-2',
    'af-arten',
    scenario: 'Auszug aus dem Lastenheft eines Webshops.',
    prompt: 'Ordne jede Anforderung ihrer Art zu.',
    zeilen: [
      ['Anforderung', 'Art'],
      [
        'Die Seiten erfüllen die Vorgaben zur Barrierefreiheit.',
        wahl('nicht-funktional', ['funktional', 'keine Anforderung']),
      ],
      [
        'Kunden können eine Bestellung innerhalb von 14 Tagen stornieren.',
        wahl('funktional', ['nicht-funktional', 'keine Anforderung']),
      ],
      [
        'Der Shop verkraftet 500 gleichzeitige Nutzer ohne Leistungseinbruch.',
        wahl('nicht-funktional', ['funktional', 'keine Anforderung']),
      ],
      [
        'Nach der Bestellung wird eine Bestätigungsmail versendet.',
        wahl('funktional', ['nicht-funktional', 'keine Anforderung']),
      ],
      [
        'Personenbezogene Daten liegen nur auf Servern in der EU.',
        wahl('nicht-funktional', ['funktional', 'keine Anforderung']),
      ],
    ],
    explanation:
        'Nicht-funktional sind Qualitätsmerkmale und Randbedingungen wie Barrierefreiheit, Leistung und Speicherort. Stornieren und Mails versenden sind Funktionen.',
  ),
  zuordnen(
    'a4-fa-3',
    'af-arten',
    scenario: 'Auszug aus dem Lastenheft für ein Urlaubsportal.',
    prompt: 'Ist die Anforderung funktional oder nicht-funktional?',
    buckets: ['funktional', 'nicht-funktional'],
    items: [
      zu('Mitarbeitende können Urlaub beantragen.', 0),
      zu('Vorgesetzte erhalten bei einem neuen Antrag eine E-Mail.', 0),
      zu('Das System berechnet den Resturlaub.', 0),
      zu(
        'Das Portal ist werktags von 7 bis 19 Uhr zu 99 % verfügbar.',
        1,
        'Zuverlässigkeit.',
      ),
      zu('Jede Seite lädt in höchstens 2 Sekunden.', 1, 'Leistung.'),
      zu(
        'Die Daten werden ausschließlich in der EU gespeichert.',
        1,
        'Rechtliche Randbedingung.',
      ),
    ],
    explanation:
        'Beantragen, benachrichtigen und berechnen sind Tätigkeiten des Systems, also funktional. Verfügbarkeit, Ladezeit und Speicherort beschreiben Qualität oder Rahmenbedingungen, also nicht-funktional.',
    difficulty: 1,
  ),
  rechnen(
    'a4-fa-4',
    'af-arten',
    scenario:
        'Im Pflichtenheft ist für den Onlineshop eine Verfügbarkeit von 99,9 % pro Jahr (365 Tage, rund um die Uhr) vereinbart.',
    prompt: 'Wie viele Stunden darf der Shop pro Jahr höchstens ausfallen?',
    answer: 8.76,
    unit: 'h',
    tolerance: 0.01,
    explanation:
        'Stunden pro Jahr: 365 × 24 h = 8.760 h. Erlaubter Ausfall: 100 % - 99,9 % = 0,1 %. 8.760 h × 0,001 = 8,76 h.',
  ),
  einfach(
    'a4-fa-5',
    'af-arten',
    prompt: 'Welche nicht-funktionale Anforderung ist prüfbar formuliert?',
    choices: [
      ja(
        'Bei 1.000 gleichzeitigen Nutzern liefert die Suche in 95 % der Fälle nach höchstens 2 Sekunden ein Ergebnis.',
        'Last, Anteil und Zeit sind messbar und bei der Abnahme eindeutig prüfbar.',
      ),
      nein(
        'Die Suche ist sehr schnell.',
        '„Sehr schnell“ hat keinen Messwert.',
      ),
      nein(
        'Die App ist intuitiv bedienbar.',
        '„Intuitiv“ ist subjektiv und ohne Kriterium nicht prüfbar.',
      ),
      nein(
        'Das System ist möglichst sicher.',
        '„Möglichst“ legt keinen Maßstab fest.',
      ),
    ],
    explanation:
        'Eine prüfbare Anforderung nennt eine messbare Größe mit Grenzwert und Bedingungen. Nur dann lässt sich bei der Abnahme eindeutig entscheiden, ob sie erfüllt ist.',
  ),
  zuordnen(
    'a4-fa-6',
    'af-arten',
    prompt: 'Welches Qualitätsmerkmal beschreibt die Anforderung?',
    buckets: [
      'Leistung',
      'Zuverlässigkeit',
      'Benutzbarkeit',
      'Sicherheit',
      'Übertragbarkeit',
    ],
    items: [
      zu('Die Antwortzeit beträgt höchstens 1 Sekunde.', 0),
      zu('Das System fällt höchstens 4 Stunden im Monat aus.', 1),
      zu('Alle Seiten sind mit einem Screenreader bedienbar.', 2),
      zu('Passwörter werden nur als Hashwert gespeichert.', 3),
      zu('Die Software läuft unter Windows und Linux.', 4),
    ],
    explanation:
        'Leistung: Zeit und Durchsatz. Zuverlässigkeit: Verfügbarkeit und Ausfälle. Benutzbarkeit: Bedienbarkeit und Barrierefreiheit. Sicherheit: Schutz der Daten. Übertragbarkeit: Lauffähigkeit auf verschiedenen Plattformen.',
  ),
  mehrfach(
    'a4-fa-7',
    'af-arten',
    scenario: 'Für ein Kundenportal liegen mehrere Vorgaben vor.',
    prompt: 'Welche davon sind Randbedingungen?',
    choices: [
      ja(
        'Das Budget beträgt höchstens 50.000 €.',
        'Organisatorische Vorgabe, die die Lösung begrenzt.',
      ),
      ja(
        'Das Portal muss auf den vorhandenen Linux-Servern laufen.',
        'Technische Vorgabe durch die bestehende Infrastruktur.',
      ),
      ja(
        'Das Portal geht spätestens am 1. März live.',
        'Termin als organisatorische Randbedingung.',
      ),
      nein(
        'Kunden können ihre Rechnungen als PDF herunterladen.',
        'Das ist eine Funktion des Systems.',
      ),
      nein(
        'Der Warenkorb bleibt nach dem Abmelden gespeichert.',
        'Auch das beschreibt, was das System tut, also funktional.',
      ),
    ],
    explanation:
        'Randbedingungen kommen von außen und schränken den Lösungsraum ein: Budget, Termine, vorhandene Technik, Gesetze. Sie werden meist zu den nicht-funktionalen Anforderungen gezählt. PDF-Download und gespeicherter Warenkorb sind Funktionen.',
  ),

  // ====================================================== Anforderungen erheben
  zuordnen(
    'a4-fe-1',
    'af-erhebung',
    prompt: 'Welche Erhebungstechnik passt jeweils am besten?',
    buckets: [
      'Interview',
      'Fragebogen',
      'Beobachtung',
      'Workshop',
      'Dokumentenanalyse',
    ],
    items: [
      zu(
        'Die Praxisleitung soll ausführlich zu ihren Zielen befragt werden, mit Rückfragen.',
        0,
      ),
      zu(
        '300 Mitarbeitende in allen Filialen sollen ihre Wünsche an die Kassensoftware angeben.',
        1,
      ),
      zu(
        'Es soll sichtbar werden, welche Handgriffe das Lager mit dem Handscanner unbewusst ausführt.',
        2,
      ),
      zu(
        'Vertrieb, Lager und Buchhaltung haben widersprüchliche Wünsche, die gemeinsam geklärt werden sollen.',
        3,
      ),
      zu(
        'Die Papierformulare und das Handbuch der Altsoftware werden systematisch ausgewertet.',
        4,
      ),
    ],
    explanation:
        'Interview: Tiefe mit Rückfragen. Fragebogen: viele Personen. Beobachtung: unbewusste Abläufe. Workshop: mehrere Gruppen einigen sich. Dokumentenanalyse: vorhandene Unterlagen auswerten.',
  ),
  einfach(
    'a4-fe-2',
    'af-erhebung',
    scenario:
        'Im Projekt „Kundenportal“ wird die Anforderung „Anmeldung per Fingerabdruck“ nach MoSCoW als „Won’t have“ eingestuft.',
    prompt: 'Was bedeutet das?',
    choices: [
      ja(
        'Sie wird in diesem Release bewusst nicht umgesetzt, bleibt aber dokumentiert.',
        'Won’t have heißt „this time“: später ist sie wieder möglich.',
      ),
      nein(
        'Sie wird endgültig gestrichen und aus der Dokumentation entfernt.',
        'Sie bleibt ausdrücklich erfasst, nur nicht für diesen Stand.',
      ),
      nein(
        'Sie wird umgesetzt, falls am Ende noch Zeit bleibt.',
        'Das beschreibt „Could have“.',
      ),
      nein(
        'Sie ist wichtig, aber nicht kritisch für den Start.',
        'Das beschreibt „Should have“.',
      ),
    ],
    explanation:
        'MoSCoW: Must have (unverzichtbar), Should have (wichtig), Could have (wenn Zeit bleibt), Won’t have this time (diesmal bewusst nicht, aber vorgemerkt).',
  ),
  einfach(
    'a4-fe-3',
    'af-erhebung',
    scenario:
        'Im Interview beschreiben die Lagerbeschäftigten ihre Arbeit lückenhaft: viele Handgriffe sind Routine und fallen ihnen gar nicht mehr auf.',
    prompt: 'Welche Erhebungstechnik ergänzt das Interview hier am besten?',
    choices: [
      ja(
        'Beobachtung am Arbeitsplatz',
        'Sie macht unbewusste, eingeübte Abläufe sichtbar.',
      ),
      nein(
        'Fragebogen',
        'Auch hier nennen die Befragten nur, was ihnen bewusst ist.',
      ),
      nein(
        'Dokumentenanalyse',
        'Unterlagen zeigen den Soll-Ablauf, nicht die tatsächlichen Handgriffe.',
      ),
      nein(
        'Brainstorming',
        'Es sammelt Ideen, erfasst aber keine tatsächlichen Abläufe.',
      ),
    ],
    explanation:
        'Befragungen liefern nur bewusstes Wissen. Routinen, Umwege und Workarounds zeigt erst die Beobachtung. Deshalb kombiniert man Interview und Beobachtung.',
  ),
  paare(
    'a4-fe-4',
    'af-erhebung',
    scenario:
        'Vor der Abstimmung mit dem Kunden prüfst du die gesammelten Anforderungen auf ihre Qualität.',
    prompt:
        'Ordne jeder Eigenschaft einer guten Anforderung ihre Bedeutung zu.',
    paare: [
      paar('eindeutig', 'lässt nur eine Deutung zu'),
      paar('prüfbar', 'hat ein messbares Kriterium'),
      paar('widerspruchsfrei', 'kollidiert mit keiner anderen'),
      paar('notwendig', 'erfüllt einen echten Bedarf'),
      paar('realisierbar', 'ist technisch und finanziell machbar'),
    ],
    explanation:
        'Gute Anforderungen sind eindeutig, vollständig, widerspruchsfrei, prüfbar, notwendig, realisierbar und verfolgbar. Allgemeine oder zusammengefasste Formulierungen verhindern eine klare Abnahme.',
  ),
  einfach(
    'a4-fe-5',
    'af-erhebung',
    prompt: 'Welche User Story ist korrekt aufgebaut?',
    choices: [
      ja(
        'Als Lagerist möchte ich Wareneingänge per Scanner buchen, damit ich keine Listen abtippen muss.',
        'Rolle, Funktion und Nutzen sind vollständig genannt.',
      ),
      nein(
        'Das System muss eine relationale Datenbank nutzen.',
        'Eine technische Vorgabe ohne Rolle und Nutzen, also keine User Story.',
      ),
      nein(
        'Als Entwickler baue ich eine REST-API.',
        'Beschreibt eine Aufgabe des Teams, keinen Nutzen für Anwender.',
      ),
      nein(
        'Scanner-Funktion einbauen, möglichst schnell.',
        'Weder Rolle noch Nutzen, dazu unklar formuliert.',
      ),
    ],
    explanation:
        'Eine User Story folgt dem Muster „Als <Rolle> möchte ich <Funktion>, damit <Nutzen>.“ Akzeptanzkriterien ergänzen, wann sie erfüllt ist.',
    difficulty: 1,
  ),
  zuordnen(
    'a4-fe-6',
    'af-erhebung',
    scenario:
        'Für den Start einer Kurs-App am 1. Juni wurden die Anforderungen mit MoSCoW priorisiert.',
    prompt: 'Ordne jede Aussage der passenden Klasse zu.',
    buckets: ['Must have', 'Should have', 'Could have', 'Won’t have'],
    items: [
      zu('Ohne Kursbuchung ist die App nutzlos.', 0),
      zu(
        'Eine Erinnerung vor Kursbeginn ist wichtig, der Start klappt aber auch ohne.',
        1,
      ),
      zu('Ein Profilbild wäre nett, falls Zeit bleibt.', 2),
      zu('Eine Smartwatch-App kommt frühestens in einer späteren Version.', 3),
    ],
    explanation:
        'Must: ohne geht es nicht. Should: wichtig, aber nicht startkritisch. Could: optional, wenn Zeit bleibt. Won’t: in diesem Release bewusst nicht, aber vorgemerkt.',
  ),
  einfach(
    'a4-fe-7',
    'af-erhebung',
    scenario: 'Du bereitest ein Interview mit der Werkstattleitung vor.',
    prompt: 'Welche Frage ist eine offene Frage?',
    choices: [
      ja(
        'Wie läuft bei Ihnen die Annahme eines Reparaturauftrags ab?',
        'Eine W-Frage, die zum ausführlichen Erzählen einlädt.',
      ),
      nein(
        'Nutzen Sie derzeit Excel?',
        'Mit Ja oder Nein beantwortbar, also geschlossen.',
      ),
      nein(
        'Sind Sie mit dem jetzigen System zufrieden?',
        'Ebenfalls mit Ja oder Nein beantwortbar.',
      ),
      nein(
        'Wie zufrieden sind Sie auf einer Skala von 1 bis 5?',
        'Eine Skalenfrage mit festen Antworten, also geschlossen.',
      ),
    ],
    explanation:
        'Offene Fragen beginnen meist mit einem W-Wort und lassen die Antwort frei. Sie liefern im Interview Tiefe. Geschlossene und Skalenfragen eignen sich für Fragebögen, weil man sie zählen kann.',
    difficulty: 1,
  ),

  // ===================================================== Anwendungsfalldiagramm
  einfach(
    'a4-uu-1',
    'u-usecase',
    scenario:
        'Im Webshop kann ein Kunde beim Anwendungsfall „Bestellung aufgeben“ optional einen Gutschein einlösen.',
    prompt: 'Wie wird „Gutschein einlösen“ korrekt modelliert?',
    choices: [
      ja(
        '«extend»-Pfeil von „Gutschein einlösen“ zu „Bestellung aufgeben“',
        'Optionale Erweiterung, der Pfeil zeigt auf den Basisfall.',
      ),
      nein(
        '«extend»-Pfeil von „Bestellung aufgeben“ zu „Gutschein einlösen“',
        'Die Richtung ist vertauscht: bei extend zeigt der Pfeil zum Basisfall.',
      ),
      nein(
        '«include»-Pfeil von „Bestellung aufgeben“ zu „Gutschein einlösen“',
        'include hieße, dass bei jeder Bestellung ein Gutschein eingelöst wird.',
      ),
      nein(
        'Assoziation zwischen dem Akteur Gutschein und der Bestellung',
        'Ein Gutschein ist kein Akteur, sondern ein Objekt im Ablauf.',
      ),
    ],
    explanation:
        '«extend» steht für eine Erweiterung, die nur unter einer Bedingung stattfindet. Der gestrichelte Pfeil geht vom erweiternden Fall zum Basisfall, der auch ohne ihn vollständig ist.',
  ),
  zuordnen(
    'a4-uu-2',
    'u-usecase',
    scenario: 'Modelliert wird die Online-Terminbuchung einer Arztpraxis.',
    prompt: 'Ist das Element ein Akteur oder ein Anwendungsfall?',
    buckets: ['Akteur', 'Anwendungsfall'],
    items: [
      zu('Patientin oder Patient', 0),
      zu('Termin buchen', 1),
      zu('Medizinische Fachangestellte', 0),
      zu(
        'Externer SMS-Dienst für Terminerinnerungen',
        0,
        'Auch ein externes System kann Akteur sein.',
      ),
      zu('Termin absagen', 1),
      zu('Freie Termine anzeigen', 1),
    ],
    explanation:
        'Akteure sind Rollen oder externe Systeme außerhalb der Systemgrenze. Anwendungsfälle sind Leistungen des Systems, benannt mit Objekt und Verb.',
  ),
  lueckentext(
    'a4-uu-3',
    'u-usecase',
    scenario:
        'Du erklärst einem neuen Teammitglied das Anwendungsfalldiagramm eines Webshops.',
    prompt: 'Vervollständige die Aussagen zum Anwendungsfalldiagramm.',
    text:
        'Akteure stehen {0} der Systemgrenze.\nEin mit «include» eingebundener Anwendungsfall läuft {1} mit ab.\nDer «extend»-Pfeil zeigt {2}.\nDie Reihenfolge der Abläufe zeigt erst das {3}.',
    luecken: [
      wahl('außerhalb', [
        'innerhalb',
        'auf',
      ], 'Sie nutzen das System, gehören aber nicht dazu.'),
      wahl('bei jeder Ausführung des Basisfalls', [
        'nur unter einer Bedingung',
        'nie automatisch',
      ], 'Genau das bedeutet «include».'),
      wahl(
        'von der Erweiterung zum Basisfall',
        ['vom Basisfall zur Erweiterung', 'vom Akteur zum Anwendungsfall'],
        'Der Basisfall ist auch ohne die Erweiterung vollständig.',
      ),
      wahl(
        'Aktivitätsdiagramm',
        ['Klassendiagramm', 'Anwendungsfalldiagramm'],
        'Das Anwendungsfalldiagramm zeigt keine Reihenfolge.',
      ),
    ],
    explanation:
        'Das Anwendungsfalldiagramm zeigt, wer welche Leistung des Systems nutzt, keine Reihenfolge. include ist Pflichtbestandteil, extend eine bedingte Erweiterung mit Pfeil zum Basisfall.',
  ),
  einfach(
    'a4-uu-4',
    'u-usecase',
    scenario:
        'Das Diagramm zeigt einen Ausschnitt aus einem Online-Banking-System.',
    skizze: const UseCaseDiagramm(
      system: 'Online-Banking',
      faelle: [
        'Überweisung ausführen',
        'TAN bestätigen',
        'Als Vorlage speichern',
        'Kontostand abrufen',
      ],
      akteure: [
        UcAkteur('Kunde', [0, 3]),
      ],
      beziehungen: [
        UcBeziehung(0, 1, UcArt.include),
        UcBeziehung(2, 0, UcArt.extend),
      ],
    ),
    prompt: 'Welche Aussage lässt sich aus dem Diagramm ablesen?',
    choices: [
      ja(
        'Bei jeder Überweisung muss eine TAN bestätigt werden.',
        '«include» bedeutet: Der eingebundene Fall läuft immer mit.',
      ),
      nein(
        'Bei jeder Überweisung wird eine Vorlage gespeichert.',
        '«extend» ist eine Erweiterung, die nur unter einer Bedingung stattfindet.',
      ),
      nein(
        'Bei jeder Überweisung wird zuerst der Kontostand abgerufen.',
        'Zwischen den beiden Fällen gibt es keine Beziehung, und das Diagramm zeigt keine Reihenfolge.',
      ),
      nein(
        '„TAN bestätigen“ ist ein Akteur.',
        'Es ist eine Ellipse innerhalb der Systemgrenze, also ein Anwendungsfall.',
      ),
    ],
    explanation:
        'Der «include»-Pfeil geht von „Überweisung ausführen“ zu „TAN bestätigen“: Die TAN ist Pflicht. „Als Vorlage speichern“ erweitert die Überweisung mit «extend» nur bei Bedarf, der Pfeil zeigt deshalb zum Basisfall.',
  ),
  mehrfach(
    'a4-uu-5',
    'u-usecase',
    scenario:
        'Für ein Hotelbuchungssystem soll ein Anwendungsfalldiagramm entstehen.',
    prompt: 'Welche Elemente sind als Akteure geeignet?',
    choices: [
      ja('Gast', 'Eine Rolle außerhalb des Systems, die Zimmer bucht.'),
      ja('Rezeption', 'Eine Rolle, die Check-in und Check-out durchführt.'),
      ja(
        'Externer Zahlungsdienstleister',
        'Ein externes System, das mit dem Buchungssystem interagiert.',
      ),
      nein(
        'Zimmer buchen',
        'Das ist eine Leistung des Systems, also ein Anwendungsfall.',
      ),
      nein(
        'Hoteldatenbank',
        'Die eigene Datenbank ist Teil des Systems, kein Akteur.',
      ),
    ],
    explanation:
        'Akteure sind Rollen oder externe Systeme außerhalb der Systemgrenze. Anwendungsfälle sind Leistungen des Systems, die eigene Datenbank gehört zum System selbst.',
  ),
  einfach(
    'a4-uu-6',
    'u-usecase',
    prompt:
        'Welche Bezeichnung eignet sich am besten für einen Anwendungsfall?',
    choices: [
      ja(
        'Zimmer reservieren',
        'Verb und Objekt, ein fachliches Ziel des Akteurs.',
      ),
      nein(
        'Reservierungsdatenbank',
        'Ein technischer Bestandteil, kein Ziel eines Akteurs.',
      ),
      nein(
        'Button „Weiter“ klicken',
        'Ein einzelner Bedienschritt, zu fein für einen Anwendungsfall.',
      ),
      nein(
        'Hotel',
        'Ein Substantiv ohne Tätigkeit. Das beschreibt eher das ganze System.',
      ),
    ],
    explanation:
        'Anwendungsfälle werden mit Objekt und Verb aus Sicht des Akteurs benannt und beschreiben ein Ziel, das er mit dem System erreicht.',
    difficulty: 1,
  ),
  zuordnen(
    'a4-uu-7',
    'u-usecase',
    prompt: 'Welche Beziehung modelliert den Sachverhalt?',
    buckets: ['«include»', '«extend»', 'Assoziation'],
    items: [
      zu(
        'Jede Auszahlung am Geldautomaten erfordert eine PIN-Prüfung.',
        0,
        'Immer, also include.',
      ),
      zu(
        'Auf Wunsch wird nach der Auszahlung ein Beleg gedruckt.',
        1,
        'Nur bei Bedarf, also extend.',
      ),
      zu(
        'Die Kundin nutzt den Anwendungsfall „Geld abheben“.',
        2,
        'Akteur und Anwendungsfall verbindet eine Linie.',
      ),
      zu('Jede Bestellung schließt die Prüfung der Lieferadresse ein.', 0),
      zu('Nur Neukunden legen zusätzlich ein Kundenkonto an.', 1),
    ],
    explanation:
        '«include»: Der Teil läuft bei jeder Ausführung mit. «extend»: Der Teil kommt nur unter einer Bedingung hinzu. Die Assoziation verbindet einen Akteur mit dem Anwendungsfall, den er nutzt.',
  ),

  // =============================================================== Klassendiagramm
  einfach(
    'a4-uk-1',
    'u-klassen',
    scenario: 'Im Klassendiagramm steht: Kunde 1 --- 0..* Bestellung',
    prompt: 'Welche Aussage ist richtig?',
    choices: [
      ja(
        'Ein Kunde hat beliebig viele Bestellungen, jede Bestellung gehört zu genau einem Kunden.',
        'Die Multiplizität steht am Ende, über das sie etwas aussagt.',
      ),
      nein(
        'Ein Kunde hat genau eine Bestellung.',
        'Die 1 steht beim Kunden und sagt, zu wie vielen Kunden eine Bestellung gehört.',
      ),
      nein(
        'Eine Bestellung kann zu mehreren Kunden gehören.',
        'Beim Kunden steht 1, also genau ein Kunde je Bestellung.',
      ),
      nein(
        'Ein Kunde muss mindestens eine Bestellung haben.',
        'Das wäre 1..*. Bei 0..* sind auch null Bestellungen erlaubt.',
      ),
    ],
    explanation:
        'Gelesen wird über die Linie hinweg: Von einem Kunden aus sieht man 0..* Bestellungen, von einer Bestellung aus genau 1 Kunden.',
  ),
  zuordnen(
    'a4-uk-2',
    'u-klassen',
    prompt: 'Aggregation oder Komposition?',
    buckets: ['Aggregation', 'Komposition'],
    items: [
      zu(
        'Rechnung - Rechnungsposition',
        1,
        'Positionen gibt es nicht ohne ihre Rechnung.',
      ),
      zu(
        'Abteilung - Mitarbeiter',
        0,
        'Mitarbeitende bleiben, wenn die Abteilung aufgelöst wird.',
      ),
      zu(
        'Bestellung - Bestellposition',
        1,
        'Eine Bestellposition existiert nur als Teil ihrer Bestellung.',
      ),
      zu(
        'Playlist - Song',
        0,
        'Der Song existiert weiter, wenn die Playlist gelöscht wird.',
      ),
    ],
    explanation:
        'Komposition (gefüllte Raute): Das Teil lebt und stirbt mit dem Ganzen. Aggregation (leere Raute): Das Teil kann auch ohne das Ganze existieren.',
  ),
  lueckentext(
    'a4-uk-3',
    'u-klassen',
    scenario: 'In der Klasse Konto steht der Eintrag: - kontoNr: String',
    prompt: 'Vervollständige die Aussagen zu diesem Eintrag.',
    text:
        'Der Eintrag ist {0}.\nDas Zeichen „-“ bedeutet {1}.\nDer Datentyp ist {2}.\nEine Methode erkennt man an {3}.',
    luecken: [
      wahl(
        'ein Attribut',
        ['eine Methode', 'eine Beziehung'],
        'Ohne Klammern und im mittleren Abschnitt, also ein Attribut.',
      ),
      wahl('private', [
        'public',
        'protected',
      ], 'Das Minuszeichen steht für private.'),
      wahl('String', [
        'kontoNr',
        'Konto',
      ], 'Der Typ steht hinter dem Doppelpunkt.'),
      wahl('den Klammern', [
        'dem Doppelpunkt',
        'dem Minuszeichen',
      ], 'Methoden haben Klammern, z. B. getKontoNr(): String.'),
    ],
    explanation:
        'Schreibweise im Klassendiagramm: Sichtbarkeit, Name, Doppelpunkt, Datentyp. „-“ bedeutet private, also nur innerhalb der Klasse Konto zugreifbar.',
  ),
  mehrfach(
    'a4-uk-4',
    'u-klassen',
    scenario: 'Ausschnitt aus dem Klassendiagramm einer Stadtbibliothek.',
    skizze: const KlassenDiagramm(
      [
        UmlKlasse('Leser', attribute: ['- leserNr: int']),
        UmlKlasse('Ausleihe', attribute: ['- rueckgabeAm: Date']),
        UmlKlasse('Medium', attribute: ['- titel: String']),
      ],
      beziehungen: [
        UmlBeziehung(0, 1, multVon: '1', multZu: '0..5', label: 'hat'),
        UmlBeziehung(
          1,
          2,
          art: UmlArt.gerichtet,
          multVon: '0..*',
          multZu: '1',
          label: 'betrifft',
        ),
      ],
    ),
    prompt: 'Welche Aussagen lassen sich aus dem Diagramm ablesen?',
    choices: [
      ja(
        'Ein Leser hat höchstens 5 Ausleihen gleichzeitig.',
        'Neben Ausleihe steht 0..5.',
      ),
      ja('Jede Ausleihe betrifft genau ein Medium.', 'Neben Medium steht 1.'),
      ja(
        'Ein Medium kann in beliebig vielen Ausleihen vorkommen.',
        'Neben Ausleihe steht auf dieser Seite 0..*.',
      ),
      nein(
        'Jeder Leser muss mindestens eine Ausleihe haben.',
        '0..5 erlaubt auch keine Ausleihe.',
      ),
      nein(
        'Eine Ausleihe kann zu mehreren Lesern gehören.',
        'Neben Leser steht 1: genau ein Leser je Ausleihe.',
      ),
    ],
    explanation:
        'Multiplizitäten liest man von einem Objekt aus über die Linie hinweg: Ein Leser hat 0..5 Ausleihen, eine Ausleihe gehört zu genau 1 Leser und betrifft genau 1 Medium, ein Medium steckt in 0..* Ausleihen.',
    difficulty: 3,
  ),
  tabelle(
    'a4-uk-5',
    'u-klassen',
    scenario:
        'In einer Klasse steht die Methode:\n+ berechneRabatt(betrag: double, stammkunde: boolean): double',
    prompt: 'Lies die Signatur und fülle die Tabelle aus.',
    zeilen: [
      ['Bestandteil', 'Angabe'],
      [
        'Sichtbarkeit',
        wahl('public', ['private', 'protected']),
      ],
      ['Anzahl der Parameter', zahl(2)],
      [
        'Typ von stammkunde',
        wahl('boolean', ['double', 'void']),
      ],
      [
        'Rückgabetyp',
        wahl('double', ['boolean', 'void']),
      ],
    ],
    explanation:
        'Methodenschreibweise in UML: Sichtbarkeit, Name, Parameterliste mit „name: Typ“, dann Doppelpunkt und Rückgabetyp. + steht für public, in der Klammer stehen zwei Parameter, zurückgegeben wird double.',
    difficulty: 1,
  ),
  einfach(
    'a4-uk-6',
    'u-klassen',
    scenario:
        'Ein Gebäude besteht aus Räumen. Wird ein Gebäude aus dem System gelöscht, werden auch seine Räume gelöscht. Ein Raum gehört immer zu genau einem Gebäude.',
    prompt: 'Wie wird die Beziehung korrekt modelliert?',
    choices: [
      ja(
        'Komposition mit gefüllter Raute an Gebäude',
        'Die Teile existieren nur mit dem Ganzen, die Raute sitzt am Ganzen.',
      ),
      nein(
        'Aggregation mit leerer Raute an Gebäude',
        'Bei einer Aggregation könnten die Räume ohne Gebäude weiterbestehen.',
      ),
      nein(
        'Komposition mit gefüllter Raute an Raum',
        'Die Raute gehört ans Ganze, nicht ans Teil.',
      ),
      nein(
        'Einfache Assoziation ohne Raute',
        'Sie drückt die Existenzabhängigkeit nicht aus.',
      ),
    ],
    explanation:
        'Wenn das Teil mit dem Ganzen entsteht und vergeht, ist es eine Komposition. Die gefüllte Raute steht immer am Ganzen, hier also an Gebäude.',
  ),
  zuordnen(
    'a4-uk-7',
    'u-klassen',
    prompt: 'Welche Multiplizität passt zur Aussage?',
    buckets: ['1', '0..1', '0..*', '1..*'],
    items: [
      zu('Jedes Auto hat genau einen Fahrzeughalter.', 0),
      zu(
        'Ein Mitarbeiter hat höchstens einen Dienstwagen, vielleicht keinen.',
        1,
      ),
      zu('Ein Kunde kann beliebig viele Bewertungen schreiben, auch keine.', 2),
      zu('Jede Bestellung hat mindestens eine Position.', 3),
    ],
    explanation:
        '1 = genau eins, 0..1 = keins oder eins, 0..* = beliebig viele einschließlich keins, 1..* = mindestens eins.',
    difficulty: 1,
  ),

  // ========================================================== Aktivitätsdiagramm
  zuordnen(
    'a4-ua-1',
    'u-aktivitaet',
    prompt: 'Welches Element ist gemeint?',
    buckets: [
      'Startknoten',
      'Entscheidung',
      'Gabelung (Fork)',
      'Vereinigung (Join)',
    ],
    items: [
      zu('Gefüllter schwarzer Kreis, an dem der Ablauf beginnt', 0),
      zu(
        'Raute mit Bedingungen in eckigen Klammern an den ausgehenden Kanten',
        1,
      ),
      zu('Balken, der einen Fluss in mehrere parallele Flüsse aufteilt', 2),
      zu('Balken, der wartet, bis alle eingehenden Flüsse angekommen sind', 3),
    ],
    explanation:
        'Start: gefüllter Kreis. Entscheidung: Raute mit Guards, genau ein Weg. Gabelung: Balken, alle Wege parallel. Vereinigung: Balken, wartet auf alle eingehenden Wege.',
  ),
  einfach(
    'a4-ua-2',
    'u-aktivitaet',
    scenario:
        'Nach der Entscheidung „Bestellwert prüfen“ stehen an den Kanten die Guards [Betrag > 500] und [Betrag < 500].',
    prompt: 'Was ist an dieser Modellierung falsch?',
    choices: [
      ja(
        'Ein Betrag von genau 500 wird von keinem Guard abgedeckt.',
        'Die Guards müssen zusammen alle Fälle abdecken.',
      ),
      nein(
        'Guards dürfen keine Vergleichsoperatoren enthalten.',
        'Vergleiche sind in Guards üblich.',
      ),
      nein(
        'Die Guards schließen sich nicht gegenseitig aus.',
        'Doch: kein Betrag ist zugleich größer und kleiner als 500.',
      ),
      nein(
        'Guards gehören in die Raute, nicht an die Kanten.',
        'Guards stehen an den ausgehenden Kanten.',
      ),
    ],
    explanation:
        'Guards müssen sich gegenseitig ausschließen und vollständig sein. Richtig wäre z. B. [Betrag > 500] und [Betrag <= 500] oder ein [else]-Zweig.',
  ),
  einfach(
    'a4-ua-3',
    'u-aktivitaet',
    scenario:
        'Nach dem Zahlungseingang verpackt das Lager die Ware, gleichzeitig bucht die Buchhaltung die Zahlung. Versendet werden darf erst, wenn beides erledigt ist.',
    prompt: 'Welches Element steht direkt vor der Aktion „Paket versenden“?',
    choices: [
      ja(
        'Vereinigung (Join-Balken)',
        'Sie wartet, bis beide parallelen Wege abgeschlossen sind.',
      ),
      nein(
        'Zusammenführung (Raute)',
        'Sie lässt den Ablauf schon beim ersten ankommenden Weg weiterlaufen.',
      ),
      nein(
        'Gabelung (Fork-Balken)',
        'Die Gabelung startet parallele Wege, sie führt sie nicht zusammen.',
      ),
      nein('Endknoten', 'Nach dem Endknoten gibt es keine weiteren Aktionen.'),
    ],
    explanation:
        'Parallele Wege werden mit einer Gabelung gestartet und mit einer Vereinigung zusammengeführt. Erst wenn alle eingehenden Flüsse angekommen sind, geht es weiter.',
  ),
  einfach(
    'a4-ua-4',
    'u-aktivitaet',
    scenario: 'Aktivitätsdiagramm eines Onlineshops.',
    skizze: const FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Bestellwert ermitteln'),
      FlussKnoten(
        'Wert >= 50 €?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] Versand gratis setzen',
      ),
      FlussKnoten('Versandkosten addieren'),
      FlussKnoten('Rechnung erstellen'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
    prompt: 'Welcher Weg wird bei einem Bestellwert von genau 50 € genommen?',
    choices: [
      ja('Der [ja]-Zweig: Versand gratis setzen', '50 >= 50 ist wahr.'),
      nein(
        'Der [nein]-Zweig: Versandkosten addieren',
        'Das gälte nur, wenn die Bedingung falsch wäre. Bei >= ist 50 eingeschlossen.',
      ),
      nein(
        'Beide Zweige nacheinander',
        'Nach einer Entscheidung läuft genau ein Weg weiter.',
      ),
      nein(
        'Keiner: der Ablauf bleibt stehen',
        'Die Guards [ja] und [nein] decken alle Fälle ab.',
      ),
    ],
    explanation:
        'Der Guard >= schließt die Grenze ein: 50 >= 50 ist wahr, also gilt der [ja]-Zweig. Bei einer Entscheidung wird immer genau ein ausgehender Weg genommen.',
    difficulty: 1,
  ),
  reihenfolge(
    'a4-ua-5',
    'u-aktivitaet',
    scenario:
        'Am Geldautomaten steckt die Kundin ihre Karte ein und gibt die PIN ein. Das System prüft die PIN. Ist sie korrekt, wählt die Kundin den Betrag. Danach gibt der Automat zuerst die Karte und dann das Geld aus.',
    prompt:
        'Bringe die Elemente des Aktivitätsdiagramms für den Erfolgsfall in die richtige Reihenfolge.',
    items: [
      'Startknoten',
      'Karte einstecken',
      'PIN eingeben',
      'Entscheidung „PIN korrekt?“',
      'Betrag wählen',
      'Karte ausgeben',
      'Geld ausgeben',
      'Endknoten',
    ],
    explanation:
        'Das Diagramm beginnt mit dem Startknoten. Die Aktionen folgen der Beschreibung, die PIN-Prüfung ist eine Entscheidung mit Guards. Im Erfolgsfall folgen Betrag wählen, Karte ausgeben und Geld ausgeben, am Ende steht der Endknoten.',
  ),
  lueckentext(
    'a4-ua-6',
    'u-aktivitaet',
    scenario:
        'Für die Dokumentation eines Bestellprozesses fasst du die Regeln des Aktivitätsdiagramms zusammen.',
    prompt: 'Ergänze den Text mit den passenden Begriffen.',
    text:
        'Bedingungen an den Kanten stehen in eckigen Klammern und heißen {0}. Nach einer {1} läuft genau ein Weg weiter, nach einer {2} laufen alle Wege parallel. Wer eine Aktion ausführt, zeigen {3}. Eine Schleife entsteht aus einer Entscheidung und einer {4}.',
    luecken: [
      wort(['Guards'], 'Sie steuern, welcher Weg genommen wird.'),
      wort(['Entscheidung'], 'Die Raute: genau ein Weg.'),
      wort(['Gabelung'], 'Der Balken: alle Wege gleichzeitig.'),
      wort(['Swimlanes'], 'Jede Bahn steht für eine Rolle oder Abteilung.'),
      wort(['Rückkante'], 'Eine eigene Schleifenform gibt es nicht.'),
    ],
    wortbank: ['Vereinigung', 'Endknoten', 'Akteure'],
    explanation:
        'Guards in [ ] steuern Entscheidungen, Schleifen entstehen aus Entscheidung und Rückkante, Swimlanes ordnen Aktionen Rollen zu. Parallelität braucht Balken, und ein Diagramm darf mehrere Endknoten haben.',
  ),
  einfach(
    'a4-ua-7',
    'u-aktivitaet',
    scenario: 'Aktivitätsdiagramm an einer Supermarktkasse.',
    skizze: const FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Artikel scannen'),
      FlussKnoten(
        'Weitere Artikel?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] zurück zum Scannen',
      ),
      FlussKnoten('Summe anzeigen'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
    prompt:
        'Welcher Kontrollstruktur entspricht der Teil mit „Artikel scannen“?',
    choices: [
      ja(
        'Fußgesteuerte Schleife',
        'Es wird mindestens einmal gescannt, erst danach wird geprüft.',
      ),
      nein(
        'Kopfgesteuerte Schleife',
        'Dann stünde die Prüfung vor dem ersten Scannen.',
      ),
      nein('Zählschleife', 'Die Anzahl der Artikel steht vorher nicht fest.'),
      nein(
        'Einfache Verzweigung',
        'Die Rückkante wiederholt die Aktion. Das ist eine Schleife.',
      ),
    ],
    explanation:
        'Die Aktion steht vor der Entscheidung, die über die Rückkante zurückführt. Also läuft der Rumpf mindestens einmal: das Muster einer fußgesteuerten Schleife (WIEDERHOLE … BIS keine Artikel mehr).',
    difficulty: 3,
  ),

  // ===================================================== Variablen und Datentypen
  zuordnen(
    'a4-pd-1',
    'pl-datentypen',
    prompt: 'Welcher Datentyp passt am besten?',
    buckets: ['int', 'double', 'boolean', 'char', 'String'],
    items: [
      zu('Anzahl der Artikel im Warenkorb', 0),
      zu('Durchschnittliche Bearbeitungszeit in Stunden, z. B. 2,75', 1),
      zu('Newsletter abonniert: ja oder nein', 2),
      zu('Trennzeichen einer CSV-Datei, z. B. ;', 3),
      zu('Postleitzahl 01067', 4, 'Führende Null, keine Rechnung, also Text.'),
      zu('Telefonnummer +49 351 123456', 4, 'Enthält + und Leerzeichen.'),
    ],
    explanation:
        'Ganze Stückzahlen: int. Kommazahlen: double. Ja/Nein: boolean. Ein einzelnes Zeichen: char. PLZ und Telefonnummer: String, weil nicht gerechnet wird und führende Nullen und Sonderzeichen erhalten bleiben müssen.',
  ),
  rechnen(
    'a4-pd-2',
    'pl-datentypen',
    prompt:
        'Welches ist der größte Wert, den eine vorzeichenbehaftete Ganzzahl mit 16 Bit speichern kann?',
    answer: 32767,
    explanation:
        'Mit Vorzeichen reicht der Bereich von -2^(n-1) bis 2^(n-1) - 1. Bei n = 16: 2^15 = 32.768, also größter Wert 32.768 - 1 = 32.767. Der Bereich ist -32.768 bis 32.767, zusammen 2^16 = 65.536 Werte.',
  ),
  rechnen(
    'a4-pd-3',
    'pl-datentypen',
    scenario: 'int a = 17;\nint b = 5;\ndouble c = a / b;',
    prompt: 'Welchen Wert hat c nach Ausführung dieses Java-Codes?',
    answer: 3,
    explanation:
        'a und b sind beide int, deshalb rechnet Java eine Ganzzahldivision: 17 / 5 = 3 Rest 2, der Rest fällt weg. Erst danach wird 3 in double umgewandelt: c = 3.0. Für 3.4 müsste man vorher casten, z. B. (double) a / b.',
    difficulty: 3,
  ),
  einfach(
    'a4-pd-4',
    'pl-datentypen',
    scenario:
        'In einer Buchhaltungssoftware sollen Rechnungsbeträge exakt auf den Cent gespeichert und summiert werden.',
    prompt: 'Welche Lösung ist am besten geeignet?',
    choices: [
      ja(
        'Ein Dezimaltyp wie BigDecimal oder ganze Cent als Ganzzahl',
        'Beides rechnet exakt ohne Rundungsfehler.',
      ),
      nein(
        'double',
        'Gleitkommazahlen stellen viele Dezimalbrüche nur näherungsweise dar: 0.1 + 0.2 ist nicht exakt 0.3.',
      ),
      nein('String', 'Mit Text kann man nicht direkt rechnen.'),
      nein('float', 'Noch ungenauer als double, gleiches Problem.'),
    ],
    explanation:
        'float und double speichern Zahlen binär, viele Centbeträge sind dort nur Näherungen. Bei Summen über viele Buchungen entstehen so Rundungsfehler. Dezimaltypen oder Cent-Ganzzahlen rechnen exakt.',
  ),
  rechnen(
    'a4-pd-5',
    'pl-datentypen',
    scenario: 'int x = 47 % 6 + 47 / 6;',
    prompt:
        'Welchen Wert hat x? (% liefert den Rest, / ist bei zwei int-Werten eine Ganzzahldivision.)',
    answer: 12,
    explanation:
        '47 / 6 = 7, denn 7 × 6 = 42. Der Rest ist 47 - 42 = 5, also 47 % 6 = 5. % und / werden vor + ausgewertet: x = 5 + 7 = 12.',
  ),
  rechnen(
    'a4-pd-6',
    'pl-datentypen',
    scenario:
        'Ein Zähler soll ganze Werte von 0 bis 5000 speichern, ohne Vorzeichen.',
    prompt: 'Wie viele Bit sind mindestens nötig?',
    answer: 13,
    unit: 'Bit',
    explanation:
        'Von 0 bis 5000 sind es 5001 Werte. 2^12 = 4096 reicht nicht (4096 < 5001). 2^13 = 8192 reicht. Mit 13 Bit ohne Vorzeichen lassen sich 0 bis 8191 speichern.',
  ),
  lueckentext(
    'a4-pd-7',
    'pl-datentypen',
    scenario:
        'In Java verkettet + Text, sobald ein Operand ein String ist. Ausgewertet wird von links nach rechts, Klammern zuerst.',
    prompt: 'Gib an, welche Werte die Variablen erhalten.',
    mono: true,
    text:
        'String s = "5" + 3 + 4;     // s = "{0}"\nString t = "5" + (3 + 4);   // t = "{1}"\nint u = 5 + 3 + 4;          // u = {2}',
    luecken: [
      zahl(
        534,
        rationale:
            'Von links nach rechts: "5" + 3 ergibt "53", dann "53" + 4 ergibt "534".',
      ),
      zahl(57, rationale: 'Die Klammer zuerst: 3 + 4 = 7, dann "5" + 7.'),
      zahl(12, rationale: 'Nur Zahlen: hier wird addiert.'),
    ],
    explanation:
        'Der Operator + wird von links nach rechts ausgewertet. Ist ein Operand ein String, wird verkettet: "5" + 3 = "53", "53" + 4 = "534". Mit "5" + (3 + 4) entstünde "57". Ohne String wird gerechnet: 12.',
    difficulty: 3,
  ),
  mehrfach(
    'a4-pd-8',
    'pl-datentypen',
    scenario: 'double d = 9.7;\nint i = 3;',
    prompt: 'Bei welchen Java-Anweisungen gehen Informationen verloren?',
    choices: [
      ja(
        'int x = (int) d;',
        'Der Cast schneidet die Nachkommastellen ab: x = 9.',
      ),
      ja(
        'byte b = (byte) 200;',
        'byte reicht nur bis 127: der Wert läuft über und wird -56.',
      ),
      nein(
        'double y = i;',
        'Erweiternde Umwandlung: aus 3 wird 3.0, nichts geht verloren.',
      ),
      nein(
        'long l = i;',
        'long ist größer als int, die Zahl passt vollständig hinein.',
      ),
    ],
    explanation:
        'Einschränkende Umwandlungen (double -> int, int -> byte) brauchen einen Cast und können Information verlieren: Nachkommastellen werden abgeschnitten, zu große Werte laufen über (200 - 256 = -56). Erweiternde Umwandlungen sind verlustfrei.',
  ),

  // ========================================================= Kontrollstrukturen
  rechnen(
    'a4-pk-1',
    'pl-kontrollstrukturen',
    scenario: 'for (int i = 2; i <= 20; i += 3) {\n  ausgabe(i);\n}',
    prompt: 'Wie oft wird der Schleifenrumpf ausgeführt?',
    answer: 7,
    unit: 'Durchläufe',
    explanation:
        'i nimmt die Werte 2, 5, 8, 11, 14, 17, 20 an, das sind 7 Werte. Danach wäre i = 23, und 23 <= 20 ist falsch. Kontrolle: (20 - 2) / 3 + 1 = 6 + 1 = 7.',
  ),
  lueckentext(
    'a4-pk-2',
    'pl-kontrollstrukturen',
    scenario:
        'Eine Kasse soll die PIN abfragen und die Abfrage so lange wiederholen, bis die PIN korrekt ist. Die erste Abfrage erfolgt in jedem Fall.',
    prompt: 'Ergänze die Schleife mit den passenden Schlüsselwörtern.',
    mono: true,
    text: '{0}\n  pin ← eingabe()\n{1} pin = korrekt',
    luecken: [
      wort(['WIEDERHOLE'], 'Fußgesteuert: Der Rumpf läuft mindestens einmal.'),
      wort(['BIS'], 'Die Abbruchbedingung steht am Ende.'),
    ],
    wortbank: ['SOLANGE', 'FÜR', 'WENN'],
    explanation:
        'Wenn der Rumpf mindestens einmal laufen muss und erst danach über die Wiederholung entschieden wird, ist die fußgesteuerte Schleife die passende Wahl: WIEDERHOLE … BIS mit der Abbruchbedingung am Ende.',
  ),
  zuordnen(
    'a4-pk-3',
    'pl-kontrollstrukturen',
    prompt: 'Welche Kontrollstruktur passt?',
    buckets: [
      'Verzweigung',
      'Kopfgesteuerte Schleife',
      'Fußgesteuerte Schleife',
      'Zählschleife',
    ],
    items: [
      zu('Ab 50 € Bestellwert entfallen die Versandkosten.', 0),
      zu(
        'Eine Datei zeilenweise lesen, solange noch Zeilen da sind. Sie kann auch leer sein.',
        1,
      ),
      zu(
        'Ein Menü anzeigen und die Auswahl lesen, bis „Beenden“ gewählt wird.',
        2,
      ),
      zu('Die 12 Monatsumsätze eines Jahres addieren.', 3),
    ],
    explanation:
        'Eine einmalige Bedingung ist eine Verzweigung. Kann der Rumpf null Mal laufen: kopfgesteuert. Muss er mindestens einmal laufen: fußgesteuert. Steht die Anzahl fest: Zählschleife.',
  ),
  rechnen(
    'a4-pk-4',
    'pl-kontrollstrukturen',
    scenario: 'int x = 10;\ndo {\n  x = x + 5;\n} while (x < 10);',
    prompt: 'Wie oft wird der Schleifenrumpf ausgeführt?',
    answer: 1,
    unit: 'Durchlauf',
    explanation:
        'Fußgesteuert heißt: erst ausführen, dann prüfen. Der Rumpf läuft einmal (x = 15), danach ist 15 < 10 falsch und die Schleife endet. Eine while-Schleife liefe hier gar nicht, weil 10 < 10 schon zu Beginn falsch ist.',
  ),
  einfach(
    'a4-pk-5',
    'pl-kontrollstrukturen',
    scenario: 'a = wahr, b = wahr, c = wahr\n\na ODER b UND NICHT c',
    prompt: 'Welchen Wert hat der Ausdruck? Es gilt: NICHT vor UND vor ODER.',
    choices: [
      ja(
        'wahr',
        'NICHT c = falsch, b UND falsch = falsch, a ODER falsch = wahr.',
      ),
      nein(
        'falsch',
        'Das ergibt sich nur, wenn man von links nach rechts rechnet: (a ODER b) UND NICHT c.',
      ),
      nein(
        'Der Ausdruck ist ohne Klammern nicht auswertbar.',
        'Die Rangfolge legt die Auswertung eindeutig fest.',
      ),
      nein(
        'Das hängt vom Wert von b ab.',
        'Da a wahr ist und ODER zuletzt ausgewertet wird, ist das Ergebnis immer wahr.',
      ),
    ],
    explanation:
        'Zuerst NICHT: NICHT c = falsch. Dann UND: b UND falsch = falsch. Zuletzt ODER: a ODER falsch = wahr ODER falsch = wahr. Klammern machen solche Ausdrücke eindeutiger lesbar.',
    difficulty: 3,
  ),
  rechnen(
    'a4-pk-6',
    'pl-kontrollstrukturen',
    scenario: 'for (int i = 50; i > 5; i = i / 2) {\n  ausgabe(i);\n}',
    prompt: 'Wie oft wird der Schleifenrumpf ausgeführt?',
    answer: 4,
    unit: 'Durchläufe',
    explanation:
        'i nimmt die Werte 50, 25, 12 und 6 an (25 / 2 = 12 bei int). Danach wird i = 6 / 2 = 3, und 3 > 5 ist falsch. Also 4 Durchläufe.',
  ),
  rechnen(
    'a4-pk-7',
    'pl-kontrollstrukturen',
    scenario:
        'zaehler ← 0\nFÜR i VON 1 BIS 4\n  FÜR j VON i BIS 4\n    zaehler ← zaehler + 1\n  ENDE FÜR\nENDE FÜR',
    prompt: 'Welchen Wert hat zaehler am Ende?',
    answer: 10,
    explanation:
        'Die innere Schleife beginnt bei i: i = 1 -> j = 1..4 (4 Durchläufe), i = 2 -> 3, i = 3 -> 2, i = 4 -> 1. Zusammen 4 + 3 + 2 + 1 = 10.',
    difficulty: 3,
  ),
  einfach(
    'a4-pk-8',
    'pl-kontrollstrukturen',
    scenario: 'WIEDERHOLE\n  x ← x * 2\nBIS x > 100',
    prompt: 'Welcher Java-Code verhält sich für jeden Startwert von x genauso?',
    choices: [
      ja(
        'do { x = x * 2; } while (x <= 100);',
        'Fußgesteuert, und die Abbruchbedingung x > 100 wird zur Laufbedingung x <= 100.',
      ),
      nein(
        'do { x = x * 2; } while (x > 100);',
        'Die Bedingung wurde nicht umgekehrt: die Schleife liefe genau im falschen Fall weiter.',
      ),
      nein(
        'do { x = x * 2; } while (x < 100);',
        'Bei x = 100 würde diese Schleife enden, WIEDERHOLE … BIS aber weiterlaufen, weil 100 > 100 falsch ist.',
      ),
      nein(
        'while (x <= 100) { x = x * 2; }',
        'Kopfgesteuert: Bei einem Startwert über 100 liefe der Rumpf gar nicht, beim Original einmal.',
      ),
    ],
    explanation:
        'WIEDERHOLE … BIS prüft eine Abbruchbedingung, do-while eine Laufbedingung. Beim Übersetzen wird die Bedingung genau umgekehrt: NICHT (x > 100) ist x <= 100. Beide sind fußgesteuert und laufen mindestens einmal.',
    difficulty: 3,
  ),

  // ============================================================== Pseudocode
  rechnen(
    'a4-pc-1',
    'pl-pseudocode',
    scenario:
        'werte ← [7, 3, 8, 2]\nsumme ← 0\nFÜR i VON 0 BIS 3\n  WENN werte[i] > 4 DANN\n    summe ← summe + werte[i]\n  ENDE WENN\nENDE FÜR\nAUSGABE summe',
    prompt: 'Welchen Wert gibt der Algorithmus aus?',
    answer: 15,
    explanation:
        'i = 0: 7 > 4, summe = 7. i = 1: 3 > 4 falsch, summe bleibt 7. i = 2: 8 > 4, summe = 15. i = 3: 2 > 4 falsch, summe bleibt 15. Ausgabe: 15.',
  ),
  reihenfolge(
    'a4-pc-2',
    'pl-pseudocode',
    prompt:
        'Bringe die Zeilen des Algorithmus zur Bestimmung des Maximums in die richtige Reihenfolge.',
    items: [
      'max ← zahlen[0]',
      'FÜR i VON 1 BIS n - 1',
      'WENN zahlen[i] > max DANN',
      'max ← zahlen[i]',
      'ENDE WENN',
      'ENDE FÜR',
      'AUSGABE max',
    ],
    hint: 'Von der ersten bis zur letzten Zeile',
    explanation:
        'Zuerst wird max mit dem ersten Element belegt. Die Schleife vergleicht jedes weitere Element und übernimmt größere Werte. Die Verzweigung wird vor der Schleife geschlossen, ausgegeben wird nach der Schleife.',
  ),
  einfach(
    'a4-pc-3',
    'pl-pseudocode',
    scenario:
        'Ein Algorithmus soll die höchste Temperatur einer Winterwoche finden: [-5, -2, -8, -4, -6, -3, -7]. Er beginnt mit max ← 0 und gibt 0 aus.',
    prompt: 'Wie lässt sich der Fehler beheben?',
    choices: [
      ja(
        'max mit dem ersten Element der Liste initialisieren',
        'Dann ist max von Anfang an ein echter Wert der Liste, hier -5, und am Ende -2.',
      ),
      nein(
        'Den Vergleich > durch < ersetzen',
        'Dann würde das Minimum gesucht.',
      ),
      nein(
        'Die Schleife bei Index 1 statt 0 beginnen',
        'Solange max mit 0 startet, bleibt das Ergebnis 0.',
      ),
      nein(
        'max mit 100 initialisieren',
        'Dann wäre das Ergebnis 100 und noch weiter daneben.',
      ),
    ],
    explanation:
        'Kein Wert der Liste ist größer als 0, also wird max nie überschrieben. Startet max mit dem ersten Element, liefert der Algorithmus für jede Liste das richtige Maximum, hier -2.',
  ),
  rechnen(
    'a4-pc-4',
    'pl-pseudocode',
    scenario:
        'FUNKTION abstand(a, b)\n  WENN a > b DANN\n    RÜCKGABE a - b\n  SONST\n    RÜCKGABE b - a\n  ENDE WENN\nENDE FUNKTION\n\nAUSGABE abstand(3, 10) + abstand(8, 2)',
    prompt: 'Welcher Wert wird ausgegeben?',
    answer: 13,
    explanation:
        'abstand(3, 10): 3 > 10 ist falsch, Rückgabe 10 - 3 = 7. abstand(8, 2): 8 > 2 ist wahr, Rückgabe 8 - 2 = 6. Ausgabe: 7 + 6 = 13.',
  ),
  lueckentext(
    'a4-pc-5',
    'pl-pseudocode',
    scenario:
        'Der Algorithmus soll zählen, wie viele Schüler die Note 1 haben.',
    prompt: 'Wähle die fehlende Anweisung.',
    mono: true,
    text:
        'anzahl ← 0\nFÜR i VON 0 BIS n - 1\n  WENN noten[i] = 1 DANN\n    {0}\n  ENDE WENN\nENDE FÜR\nAUSGABE anzahl',
    luecken: [
      wahl('anzahl ← anzahl + 1', [
        'anzahl ← 1',
        'i ← i + 1',
        'anzahl ← noten[i]',
      ], 'Der Zähler wächst bei jedem Treffer um eins.'),
    ],
    explanation:
        'Beim Zählen mit Bedingung startet der Zähler bei 0 und wird nur im Dann-Zweig um 1 erhöht. „anzahl ← 1“ ergäbe höchstens 1, „i ← i + 1“ würde ein Element überspringen, „anzahl ← noten[i]“ speichert eine Note, zählt aber nicht.',
    difficulty: 1,
  ),
  rechnen(
    'a4-pc-6',
    'pl-pseudocode',
    scenario:
        'liste ← [4, 7, 1, 7, 9]\npos ← -1\nFÜR i VON 0 BIS 4\n  WENN liste[i] = 7 DANN\n    pos ← i\n  ENDE WENN\nENDE FÜR\nAUSGABE pos',
    prompt: 'Welcher Wert wird ausgegeben?',
    answer: 3,
    explanation:
        'Die Schleife bricht beim ersten Treffer nicht ab. Bei i = 1 wird pos = 1, bei i = 3 wird pos mit 3 überschrieben. Ausgegeben wird also der Index des letzten Vorkommens: 3.',
    difficulty: 3,
  ),
  reihenfolge(
    'a4-pc-7',
    'pl-pseudocode',
    prompt:
        'Bringe die Zeilen des Algorithmus zur Berechnung des Durchschnitts in die richtige Reihenfolge.',
    items: [
      'summe ← 0',
      'FÜR i VON 0 BIS n - 1',
      'summe ← summe + werte[i]',
      'ENDE FÜR',
      'schnitt ← summe / n',
      'AUSGABE schnitt',
    ],
    hint: 'Von der ersten bis zur letzten Zeile',
    explanation:
        'Die Summe wird vor der Schleife mit 0 initialisiert, in der Schleife wird jedes Element addiert. Erst nach der Schleife wird durch n geteilt und das Ergebnis ausgegeben.',
  ),
  rechnen(
    'a4-pc-8',
    'pl-pseudocode',
    scenario:
        'm ← [[3, 8, 1],\n     [6, 2, 9]]\nErster Index = Zeile, zweiter Index = Spalte, beide beginnen bei 0.',
    prompt: 'Welchen Wert hat m[1][0] + m[0][2]?',
    answer: 7,
    explanation:
        'm[1][0] ist Zeile 1 (die zweite Zeile), Spalte 0: 6. m[0][2] ist Zeile 0, Spalte 2: 1. Summe: 6 + 1 = 7.',
    difficulty: 1,
  ),

  // ============================================================ Schreibtischtest
  rechnen(
    'a4-pt-1',
    'pl-schreibtischtest',
    scenario:
        'a ← 2\nb ← 20\nSOLANGE b > a\n  a ← a + 3\n  b ← b - 1\nENDE SOLANGE',
    prompt: 'Welchen Wert hat a nach Ablauf des Algorithmus?',
    answer: 17,
    explanation:
        'Trace (a, b): Start (2, 20). 20 > 2: (5, 19). 19 > 5: (8, 18). 18 > 8: (11, 17). 17 > 11: (14, 16). 16 > 14: (17, 15). Jetzt ist 15 > 17 falsch, also Ende nach 5 Durchläufen. a = 17.',
  ),
  rechnen(
    'a4-pt-2',
    'pl-schreibtischtest',
    scenario:
        'x ← 0\nFÜR i VON 1 BIS 6\n  WENN i MOD 2 = 0 DANN\n    x ← x + i\n  SONST\n    x ← x - 1\n  ENDE WENN\nENDE FÜR',
    prompt:
        'Welchen Wert hat x nach Ablauf? (MOD liefert den Rest der ganzzahligen Division.)',
    answer: 9,
    explanation:
        'i = 1 (ungerade): x = -1. i = 2 (gerade): x = -1 + 2 = 1. i = 3: x = 0. i = 4: x = 4. i = 5: x = 3. i = 6: x = 9. Kontrolle: gerade Zahlen 2 + 4 + 6 = 12, drei ungerade je -1 = -3, 12 - 3 = 9.',
    difficulty: 3,
  ),
  tabelle(
    'a4-pt-3',
    'pl-schreibtischtest',
    scenario:
        'Zwei Variablen sollen ihre Werte tauschen. Die Hilfsvariable wurde vergessen.',
    code: 'a ← 4\nb ← 9\na ← b\nb ← a',
    prompt: 'Trage die Werte von a und b nach den letzten beiden Zeilen ein.',
    zeilen: [
      ['nach Zeile', 'a', 'b'],
      ['b ← 9', '4', '9'],
      ['a ← b', zahl(9), zahl(9)],
      ['b ← a', zahl(9), zahl(9)],
    ],
    explanation:
        'Jede Zuweisung nutzt den aktuellen Wert. Nach a ← b ist die 4 verloren, danach übernimmt b den neuen Wert von a: beide sind 9. Ein echter Tausch braucht eine Hilfsvariable: hilf ← a, a ← b, b ← hilf.',
  ),
  rechnen(
    'a4-pt-4',
    'pl-schreibtischtest',
    scenario:
        'zahl ← 4725\nq ← 0\nSOLANGE zahl > 0\n  q ← q + (zahl MOD 10)\n  zahl ← zahl DIV 10\nENDE SOLANGE\nAUSGABE q',
    prompt:
        'Welcher Wert wird ausgegeben? (MOD: Rest, DIV: ganzzahlige Division)',
    answer: 18,
    explanation:
        'Trace (zahl, q): Start (4725, 0). Durchlauf 1: q = 0 + 5 = 5, zahl = 472. Durchlauf 2: q = 5 + 2 = 7, zahl = 47. Durchlauf 3: q = 7 + 7 = 14, zahl = 4. Durchlauf 4: q = 14 + 4 = 18, zahl = 0. 0 > 0 ist falsch. Der Algorithmus berechnet die Quersumme: 4 + 7 + 2 + 5 = 18.',
    difficulty: 3,
  ),
  rechnen(
    'a4-pt-5',
    'pl-schreibtischtest',
    scenario:
        'n ← 100\nk ← 0\nSOLANGE n > 1\n  n ← n DIV 3\n  k ← k + 1\nENDE SOLANGE\nAUSGABE k',
    prompt: 'Welcher Wert wird ausgegeben?',
    answer: 4,
    explanation:
        'Trace (n, k): Start (100, 0). 100 > 1: (33, 1). 33 > 1: (11, 2). 11 > 1: (3, 3). 3 > 1: (1, 4). 1 > 1 ist falsch, also Ende. Ausgabe k = 4.',
  ),
  einfach(
    'a4-pt-6',
    'pl-schreibtischtest',
    scenario: 'e ← 1\nFÜR i VON 1 BIS n\n  e ← e * b\nENDE FÜR\nAUSGABE e',
    prompt: 'Was berechnet der Algorithmus für ganze Zahlen b und n ≥ 1?',
    choices: [
      ja(
        'b hoch n',
        'b wird n-mal mit sich selbst multipliziert, z. B. b = 2, n = 3: 1 · 2 · 2 · 2 = 8.',
      ),
      nein(
        'n! (Fakultät)',
        'Dafür müsste mit i multipliziert werden, nicht mit b.',
      ),
      nein(
        'b · n',
        'Dafür müsste n-mal b addiert werden, nicht multipliziert.',
      ),
      nein('Die Summe von 1 bis n', 'Dafür müsste i addiert werden.'),
    ],
    explanation:
        'Ein Schreibtischtest mit Beispielwerten verrät die Funktion: b = 2, n = 3 ergibt e = 1 → 2 → 4 → 8 = 2³. Der Algorithmus berechnet die Potenz bⁿ.',
  ),
  rechnen(
    'a4-pt-7',
    'pl-schreibtischtest',
    scenario: 'x ← 1\nWIEDERHOLE\n  x ← x * 3\nBIS x > 50\nAUSGABE x',
    prompt: 'Welcher Wert wird ausgegeben?',
    answer: 81,
    explanation:
        'x = 3 (3 > 50 falsch), x = 9 (falsch), x = 27 (falsch), x = 81 (81 > 50 wahr), also Ende. Ausgabe 81. Die Bedingung wird erst nach jedem Durchlauf geprüft.',
    difficulty: 1,
  ),

  // ================================================== Klasse, Objekt, Attribut, Methode
  zuordnen(
    'a4-og-1',
    'oo-grundbegriffe',
    scenario:
        'Ein Ticketsystem für den IT-Support wird objektorientiert entwickelt.',
    prompt: 'Ordne jeden Begriff zu.',
    buckets: ['Klasse', 'Objekt', 'Attribut', 'Methode'],
    items: [
      zu('Ticket', 0, 'Der Bauplan für alle Tickets.'),
      zu('Das Ticket Nr. 4711 von Frau Kaya', 1, 'Ein konkretes Exemplar.'),
      zu('prioritaet', 2),
      zu('eskalieren()', 3),
      zu('erstelltAm', 2),
    ],
    explanation:
        'Die Klasse beschreibt alle Tickets, ein Objekt ist ein bestimmtes Ticket. Attribute sind Eigenschaften wie prioritaet und erstelltAm, Methoden Fähigkeiten wie eskalieren().',
    difficulty: 1,
  ),
  lueckentext(
    'a4-og-2',
    'oo-grundbegriffe',
    scenario:
        'Im Lager gibt es zwei Paletten-Objekte mit demselben Gewicht und demselben Lagerplatz-Typ.',
    prompt: 'Ergänze den Text mit den passenden Begriffen.',
    text:
        'Der Zustand eines Objekts sind die aktuellen Werte seiner {0}. Sein Verhalten bestimmen die {1} der Klasse. Zwei Objekte mit gleichen Werten bleiben verschieden. Jedes hat seine eigene {2}.',
    luecken: [
      wort([
        'Attribute',
      ], 'Ändert sich ein Attributwert, ändert sich der Zustand.'),
      wort(['Methoden'], 'Methoden beschreiben das Verhalten.'),
      wort([
        'Identität',
      ], 'Sie bleibt gleich, auch wenn sich der Zustand ändert.'),
    ],
    wortbank: ['Klassen', 'Parameter'],
    explanation:
        'Ein Objekt hat Zustand (Attributwerte), Verhalten (Methoden) und Identität (es ist eigenständig, auch bei gleichen Werten).',
  ),
  lueckentext(
    'a4-og-3',
    'oo-grundbegriffe',
    scenario:
        'Im Ticketsystem werden zwei Tickets angelegt, danach wird eines geschlossen. Neue Tickets sind offen.',
    code:
        'Ticket t1 = new Ticket();\nTicket t2 = new Ticket();\nt1.schliessen();',
    prompt: 'Vervollständige die Aussagen zum Code.',
    text:
        'Es wurden {0} Objekte der Klasse Ticket erzeugt.\nNach der letzten Zeile ist t2 {1}.\nTicket ist {2}, t1 ist {3}.',
    luecken: [
      zahl(2, rationale: 'Jedes new erzeugt ein Objekt.'),
      wahl('weiterhin offen', [
        'ebenfalls geschlossen',
        'gelöscht',
      ], 'Jedes Objekt hat seinen eigenen Zustand.'),
      wahl('die Klasse', [
        'ein Objekt',
        'ein Attribut',
      ], 'Der Bauplan für alle Tickets.'),
      wahl('ein Objekt', [
        'die Klasse',
        'eine Methode',
      ], 'Ein Exemplar, erzeugt mit new.'),
    ],
    explanation:
        'Klasse = Bauplan, Objekt = Exemplar mit eigenem Zustand und eigener Identität. Methoden beschreiben das Verhalten und ändern den Zustand genau des Objekts, auf dem sie aufgerufen werden: t2 bleibt offen.',
  ),
  tabelle(
    'a4-og-4',
    'oo-grundbegriffe',
    scenario: 'Aus einem Personalverwaltungssystem:',
    skizze: const KlassenDiagramm([
      UmlKlasse(
        'Mitarbeiter',
        attribute: [
          '- personalNr: int',
          '- name: String',
          '- wochenstunden: int',
        ],
        methoden: ['+ getName(): String', '+ setStunden(h: int): void'],
      ),
    ]),
    prompt: 'Lies das Klassendiagramm und fülle die Tabelle aus.',
    zeilen: [
      ['Frage', 'Antwort'],
      ['Anzahl der Attribute', zahl(3)],
      [
        'Sichtbarkeit von name',
        wahl('private', ['public', 'protected']),
      ],
      [
        'Parametertyp von setStunden',
        wahl('int', ['String', 'void']),
      ],
      [
        'Rückgabetyp von getName',
        wahl('String', ['int', 'void']),
      ],
    ],
    explanation:
        'Das Klassendiagramm zeigt den Bauplan: Attribute im mittleren, Methoden im unteren Abschnitt. Die Klasse hat drei Attribute, alle private (-). setStunden erwartet h: int, getName liefert einen String.',
    difficulty: 1,
  ),
  einfach(
    'a4-og-5',
    'oo-grundbegriffe',
    scenario:
        'Für die App einer Stadtbibliothek wird die Klasse Leser modelliert.',
    prompt: 'Welches Attribut ist für diese Anwendung überflüssig?',
    choices: [
      ja(
        'schuhgroesse',
        'Für das Ausleihen von Medien spielt sie keine Rolle: Abstraktion lässt sie weg.',
      ),
      nein('leserNr', 'Sie identifiziert den Leser bei jeder Ausleihe.'),
      nein('name', 'Wird für Mahnungen und den Ausweis gebraucht.'),
      nein('email', 'Wird für Erinnerungen an die Rückgabe gebraucht.'),
    ],
    explanation:
        'Abstraktion heißt: Eine Klasse bildet nur die Eigenschaften ab, die die Anwendung braucht. Leser-Nummer, Name und E-Mail sind für die Bibliothek wichtig, die Schuhgröße nicht.',
    difficulty: 1,
  ),
  einfach(
    'a4-og-6',
    'oo-grundbegriffe',
    scenario: 'In der Klasse Kunde soll das Alter der Kundin abrufbar sein.',
    prompt: 'Welche Modellierung ist am sinnvollsten?',
    choices: [
      ja(
        '- geburtsdatum: Date und + getAlter(): int',
        'Das Geburtsdatum ändert sich nie, das Alter wird bei Bedarf berechnet.',
      ),
      nein(
        '- alter: int',
        'Das gespeicherte Alter ist nach dem nächsten Geburtstag falsch.',
      ),
      nein(
        '- alter: int und - geburtsdatum: Date',
        'Doppelte Daten können sich widersprechen.',
      ),
      nein(
        '+ getGeburtsdatum(): int',
        'Ein Datum ist kein int, und das Alter wäre weiterhin nicht verfügbar.',
      ),
    ],
    explanation:
        'Werte, die sich aus anderen berechnen lassen, speichert man nicht als Attribut. Gespeichert wird das unveränderliche Geburtsdatum, das Alter liefert eine Methode.',
  ),
  zuordnen(
    'a4-og-7',
    'oo-grundbegriffe',
    scenario: 'Ein Ticket-Objekt im IT-Support wird betrachtet.',
    prompt:
        'Gehört die Angabe zu Zustand, Verhalten oder Identität des Objekts?',
    buckets: ['Zustand', 'Verhalten', 'Identität'],
    items: [
      zu('status = „offen“', 0),
      zu('prioritaet = 3', 0),
      zu('schliessen()', 1),
      zu('eskalieren()', 1),
      zu(
        'Zwei Tickets mit gleichen Werten sind trotzdem zwei verschiedene Tickets.',
        2,
      ),
    ],
    explanation:
        'Zustand: aktuelle Attributwerte. Verhalten: die Methoden des Objekts. Identität: Jedes Objekt ist eigenständig, auch bei gleichen Werten.',
    difficulty: 1,
  ),

  // ==================================================== Kapselung und Sichtbarkeit
  einfach(
    'a4-ok-1',
    'oo-kapselung',
    scenario:
        'Die Klasse Artikel hat das Attribut private int bestand sowie public getBestand() und setBestand(int b). In der Klasse Lager steht: Artikel a = new Artikel();',
    prompt:
        'Welche Anweisung in der Klasse Lager führt zu einem Compilerfehler?',
    choices: [
      ja(
        'a.bestand = 50;',
        'bestand ist private und nur innerhalb von Artikel zugreifbar.',
      ),
      nein(
        'a.setBestand(50);',
        'Der Setter ist public und darf aufgerufen werden.',
      ),
      nein('int x = a.getBestand();', 'Der Getter ist public.'),
      nein('a.setBestand(a.getBestand() + 1);', 'Beide Methoden sind public.'),
    ],
    explanation:
        'Private Attribute sind nur in der eigenen Klasse sichtbar. Von außen läuft der Zugriff über die öffentlichen Getter und Setter.',
  ),
  rechnen(
    'a4-ok-2',
    'oo-kapselung',
    scenario:
        'Der Setter setBestand(int b) übernimmt den Wert nur, wenn b >= 0 ist.\n\nArtikel a = new Artikel();\na.setBestand(30);\na.setBestand(-10);\na.setBestand(a.getBestand() + 5);',
    prompt: 'Welchen Wert hat bestand am Ende?',
    answer: 35,
    unit: 'Stück',
    explanation:
        'setBestand(30): gültig, bestand = 30. setBestand(-10): -10 >= 0 ist falsch, bestand bleibt 30. setBestand(30 + 5): gültig, bestand = 35.',
  ),
  freitext(
    'a4-ok-3',
    'oo-kapselung',
    scenario:
        'Im Code-Review wird vorgeschlagen, alle Attribute der Klasse Artikel public zu machen, „weil das kürzer ist“. Du bist für Kapselung.',
    prompt: 'Nenne zwei Vorteile der Kapselung. (2 P.)',
    punkte: 2,
    kriterien: [
      krit(
        'Ungültige Werte lassen sich im Setter abfangen',
        stichwoerter: [
          'ungültige',
          'prüfen',
          'prüfung',
          'validierung',
          'abfangen',
        ],
      ),
      krit(
        'Die interne Darstellung kann sich ändern, ohne dass aufrufender Code angepasst werden muss',
        stichwoerter: [
          'intern',
          'änderbar',
          'unabhängig',
          'austauschbar',
          'ohne anpassung',
        ],
      ),
      krit(
        'Die Klasse hat eine klar definierte Schnittstelle',
        stichwoerter: [
          'schnittstelle',
          'öffentliche methoden',
          'kontrollierter zugriff',
        ],
      ),
      krit(
        'Daten sind vor unkontrolliertem Zugriff geschützt',
        stichwoerter: [
          'geschützt',
          'schutz',
          'unkontrolliert',
          'kein direkter zugriff',
        ],
      ),
    ],
    loesung:
        'Zum Beispiel: Ungültige Werte lassen sich im Setter abfangen, und die interne Darstellung kann geändert werden, ohne dass andere Klassen angepasst werden müssen. Ebenfalls richtig: klare Schnittstelle, Schutz vor unkontrolliertem Zugriff.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 2. Kapselung schützt Daten vor falscher Verwendung, macht Klassen unabhängig voneinander änderbar und legt eine klare Schnittstelle fest. Schneller wird das Programm dadurch nicht.',
  ),
  zuordnen(
    'a4-ok-4',
    'oo-kapselung',
    prompt: 'Ordne das UML-Zeichen der Sichtbarkeit zu.',
    buckets: ['public', 'private', 'protected', 'package'],
    items: [zu('+', 0), zu('-', 1), zu('#', 2), zu('~', 3)],
    explanation:
        'Im Klassendiagramm: + public (von überall), - private (nur die Klasse), # protected (Klasse und Unterklassen), ~ package (selbes Paket).',
    difficulty: 1,
  ),
  einfach(
    'a4-ok-5',
    'oo-kapselung',
    scenario:
        'In der Klasse Lager wurde ein Objekt a der Klasse Artikel erzeugt.',
    skizze: const KlassenDiagramm([
      UmlKlasse(
        'Artikel',
        attribute: ['- artikelNr: String', '- bestand: int'],
        methoden: [
          '+ getBestand(): int',
          '+ einlagern(menge: int): void',
          '+ auslagern(menge: int): boolean',
        ],
      ),
    ]),
    prompt: 'Welche Anweisung in der Klasse Lager ist erlaubt?',
    choices: [
      ja(
        'a.einlagern(10);',
        'einlagern ist public und darf von außen aufgerufen werden.',
      ),
      nein(
        'a.bestand = 10;',
        'bestand ist private: Zugriff nur innerhalb von Artikel.',
      ),
      nein(
        'a.bestand++;',
        'Auch das Erhöhen ist ein direkter Zugriff auf das private Attribut.',
      ),
      nein(
        'String nr = a.artikelNr;',
        'artikelNr ist private, und einen Getter dafür gibt es nicht.',
      ),
    ],
    explanation:
        'Von außen sind nur die öffentlichen Methoden erreichbar. Alle Änderungen am Bestand laufen über einlagern und auslagern, die die Werte prüfen.',
  ),
  rechnen(
    'a4-ok-6',
    'oo-kapselung',
    scenario:
        'Der Bestand eines neuen Artikels ist 0. einlagern(m) addiert m nur, wenn m > 0 ist. auslagern(m) zieht m nur ab, wenn m > 0 und m <= bestand ist.\n\na.einlagern(40);\na.auslagern(15);\na.auslagern(30);\na.einlagern(0);\na.auslagern(20);',
    prompt: 'Welchen Wert hat bestand am Ende?',
    answer: 5,
    unit: 'Stück',
    explanation:
        'einlagern(40): 0 + 40 = 40. auslagern(15): 15 <= 40, Bestand 25. auslagern(30): 30 > 25, abgelehnt, bleibt 25. einlagern(0): 0 > 0 ist falsch, bleibt 25. auslagern(20): 20 <= 25, Bestand 5.',
  ),
  lueckentext(
    'a4-ok-7',
    'oo-kapselung',
    scenario: 'Die Klasse Kunde hat das private Attribut - aktiv: boolean.',
    prompt:
        'Ergänze die Signatur eines üblichen Getters für dieses Attribut in UML-Schreibweise.',
    mono: true,
    text: '{0} {1}(): {2}',
    luecken: [
      wahl('+', [
        '-',
        '#',
      ], 'Ein privater Getter wäre von außen nicht nutzbar.'),
      wahl('isAktiv', [
        'setAktiv',
        'aktiv',
      ], 'Getter für boolean beginnen üblicherweise mit is.'),
      wahl('boolean', [
        'void',
        'String',
      ], 'Ein Getter liefert den Attributwert zurück.'),
    ],
    explanation:
        'Getter sind öffentlich, parameterlos und liefern den Attributwert: getName() oder bei boolean isAktiv(). Setter heißen setName(wert) und haben meist den Rückgabetyp void.',
  ),
  zuordnen(
    'a4-ok-8',
    'oo-kapselung',
    scenario: 'Für die Klasse Konto wird die Sichtbarkeit festgelegt.',
    prompt: 'Welche Sichtbarkeit ist für das Element üblich?',
    buckets: ['private', 'public'],
    items: [
      zu('Attribut kontostand', 0),
      zu('Attribut pin', 0),
      zu('Hilfsmethode pruefeIban()', 0, 'Internes Detail der Klasse.'),
      zu('Methode einzahlen(betrag)', 1),
      zu('Getter getKontoNr()', 1),
    ],
    explanation:
        'Attribute und interne Hilfsmethoden sind private. Die Methoden, die andere Klassen nutzen sollen (fachliche Methoden und Getter), bilden die öffentliche Schnittstelle.',
    difficulty: 1,
  ),

  // ======================================================== Objekte erzeugen und nutzen
  lueckentext(
    'a4-oc-1',
    'oo-konstruktor',
    scenario:
        'Für eine Schulung fasst du die Merkmale eines Konstruktors zusammen.',
    prompt: 'Ergänze den Text mit den passenden Begriffen.',
    text:
        'Der Konstruktor heißt genau wie die {0} und hat keinen {1}. Er wird beim Erzeugen eines Objekts mit {2} aufgerufen. Hat eine Klasse mehrere Konstruktoren mit unterschiedlichen Parameterlisten, spricht man von {3}.',
    luecken: [
      wort(['Klasse'], 'Daran erkennt der Compiler den Konstruktor.'),
      wort(['Rückgabetyp'], 'Nicht einmal void.'),
      wort(['new'], 'Er setzt dabei die Startwerte.'),
      wort(['Überladen'], 'Konstruktoren lassen sich überladen.'),
    ],
    wortbank: ['void', 'Methode', 'Kapselung'],
    explanation:
        'Der Konstruktor trägt den Klassennamen, hat keinen Rückgabetyp, wird bei new aufgerufen und kann überladen werden.',
  ),
  einfach(
    'a4-oc-2',
    'oo-konstruktor',
    scenario:
        'Die Klasse Kunde hat bereits die Konstruktoren Kunde(String name) und Kunde(String name, int nr).',
    prompt: 'Welcher weitere Konstruktor kann NICHT ergänzt werden?',
    choices: [
      ja(
        'Kunde(String vorname)',
        'Gleiche Parameterliste wie Kunde(String name). Nur der Parametername unterscheidet sich.',
      ),
      nein('Kunde()', 'Keine Parameter: diese Liste gibt es noch nicht.'),
      nein('Kunde(int nr)', 'Ein int-Parameter ist eine neue Parameterliste.'),
      nein(
        'Kunde(int nr, String name)',
        'Andere Reihenfolge der Typen: erlaubt.',
      ),
    ],
    explanation:
        'Beim Überladen müssen sich die Parameterlisten in Anzahl, Typen oder Reihenfolge der Typen unterscheiden. Parameternamen zählen nicht.',
    difficulty: 3,
  ),
  rechnen(
    'a4-oc-3',
    'oo-konstruktor',
    scenario:
        'Punktekonto a = new Punktekonto(100);\nPunktekonto b = a;\nb.gutschreiben(50);\nPunktekonto c = new Punktekonto(100);\nc.gutschreiben(20);',
    prompt:
        'Welchen Wert liefert danach a.getPunkte()? Der Konstruktor setzt den Startwert, gutschreiben addiert.',
    answer: 150,
    unit: 'Punkte',
    explanation:
        'b = a kopiert nur die Referenz: a und b zeigen auf dasselbe Objekt. 100 + 50 = 150. c ist ein eigenes Objekt mit new, seine 120 Punkte berühren a nicht. a.getPunkte() liefert 150.',
  ),
  rechnen(
    'a4-oc-4',
    'oo-konstruktor',
    scenario:
        'class Kunde {\n  static int anzahl = 0;\n  Kunde() {\n    anzahl++;\n  }\n}\n\nKunde k1 = new Kunde();\nKunde k2 = new Kunde();\nKunde k3 = k1;\nKunde k4 = new Kunde();\nKunde k5 = new Kunde();',
    prompt: 'Welchen Wert hat Kunde.anzahl am Ende?',
    answer: 4,
    explanation:
        'Der Konstruktor läuft nur bei new: k1, k2, k4 und k5, also viermal. k3 = k1 kopiert nur die Referenz und erzeugt kein Objekt. Da anzahl static ist, gibt es den Zähler nur einmal: 4.',
  ),
  einfach(
    'a4-oc-5',
    'oo-konstruktor',
    scenario:
        'Die Klasse Artikel hat genau zwei Konstruktoren: Artikel(String bez) und Artikel(String bez, int bestand).',
    prompt: 'Welcher Aufruf führt zu einem Compilerfehler?',
    choices: [
      ja(
        'new Artikel()',
        'Weil eigene Konstruktoren existieren, legt Java keinen Standardkonstruktor an.',
      ),
      nein('new Artikel("Maus")', 'Passt zu Artikel(String bez).'),
      nein(
        'new Artikel("Maus", 15)',
        'Passt zu Artikel(String bez, int bestand).',
      ),
      nein('new Artikel("Tastatur", 0)', 'Auch 0 ist ein gültiger int-Wert.'),
    ],
    explanation:
        'Den parameterlosen Standardkonstruktor erzeugt Java nur, wenn die Klasse keinen eigenen Konstruktor hat. Hier gibt es zwei, also scheitert new Artikel().',
    difficulty: 3,
  ),
  mehrfach(
    'a4-oc-6',
    'oo-konstruktor',
    prompt: 'Welche Aussagen zu Klassenattributen (static) sind richtig?',
    choices: [
      ja(
        'Ein Klassenattribut gibt es nur einmal, alle Objekte teilen es.',
        'Es gehört zur Klasse, nicht zu einem Objekt.',
      ),
      ja(
        'Im Klassendiagramm wird es unterstrichen.',
        'So unterscheidet UML es von Objektattributen.',
      ),
      ja(
        'Man kann damit z. B. zählen, wie viele Objekte erzeugt wurden.',
        'Der Konstruktor erhöht den gemeinsamen Zähler.',
      ),
      nein(
        'Jedes Objekt hat eine eigene Kopie.',
        'Das gilt für normale Objektattribute.',
      ),
      nein(
        'Ein static-Attribut kann nie geändert werden.',
        'Unveränderlich macht erst final, static heißt nur „gehört zur Klasse“.',
      ),
    ],
    explanation:
        'static bedeutet: Das Attribut gehört zur Klasse und existiert genau einmal. In UML wird es unterstrichen. Konstant ist es nur, wenn es zusätzlich final ist.',
  ),
  einfach(
    'a4-oc-7',
    'oo-konstruktor',
    scenario:
        'class Kunde {\n  private String name;\n  public Kunde(String name) {\n    name = name;\n  }\n}\n\nKunde k = new Kunde("Meier");',
    prompt: 'Welchen Wert hat das Attribut name von k danach?',
    choices: [
      ja(
        'null',
        'name = name weist den Parameter sich selbst zu. Das Attribut bleibt beim Standardwert null.',
      ),
      nein('„Meier“', 'Dafür müsste this.name = name; dort stehen.'),
      nein(
        'Ein leerer String ""',
        'Der Standardwert für Objekttypen wie String ist null, nicht "".',
      ),
      nein(
        'Der Code lässt sich nicht übersetzen.',
        'Die Zuweisung ist erlaubt, sie ist nur wirkungslos.',
      ),
    ],
    explanation:
        'Heißen Parameter und Attribut gleich, verdeckt der Parameter das Attribut. Mit this.name = name; wird das Attribut des Objekts angesprochen. Ohne this bleibt es beim Standardwert null.',
    difficulty: 3,
  ),
  reihenfolge(
    'a4-oc-8',
    'oo-konstruktor',
    scenario: 'Kunde k = new Kunde("Yilmaz", 1001);',
    prompt: 'In welcher Reihenfolge läuft diese Anweisung ab?',
    items: [
      'Speicher für das neue Objekt reservieren',
      'Attribute mit Standardwerten belegen',
      'Konstruktor mit den Argumenten ausführen',
      'Referenz auf das Objekt in k speichern',
    ],
    explanation:
        'new reserviert Speicher, belegt die Attribute mit Standardwerten (0, false, null), führt dann den Konstruktor aus und liefert die Referenz, die in k gespeichert wird.',
    difficulty: 3,
  ),
];
