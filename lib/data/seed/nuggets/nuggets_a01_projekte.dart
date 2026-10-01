import '../../models/nugget.dart';
import '../builders.dart';

// ------------------------------------------------ Wiederkehrende Netzpläne
//
// Die Netzplan-Lektionen rechnen dieselben Pläne Schritt für Schritt zu
// Ende. Die Werte in den Zeichnungen rechnet die App selbst aus.

/// Kleines Einstiegsbeispiel: Dauer 8, kritischer Pfad A - C - D.
const _npMini = [
  Activity(id: 'A', name: 'Analyse', duration: 3),
  Activity(id: 'B', name: 'Konzept', duration: 2, predecessors: ['A']),
  Activity(id: 'C', name: 'Hardware', duration: 4, predecessors: ['A']),
  Activity(id: 'D', name: 'Test', duration: 1, predecessors: ['B', 'C']),
];

/// Das Ticketsystem-Projekt: Dauer 15, kritischer Pfad A - B - D - F - G,
/// C hat 1 Tag, E 5 Tage Puffer.
const _npTicket = [
  Activity(id: 'A', name: 'Ist-Analyse', duration: 2),
  Activity(id: 'B', name: 'Konzept', duration: 4, predecessors: ['A']),
  Activity(id: 'C', name: 'Hardware', duration: 6, predecessors: ['A']),
  Activity(id: 'D', name: 'Installation', duration: 3, predecessors: ['B']),
  Activity(id: 'E', name: 'Schulung vorb.', duration: 2, predecessors: ['B']),
  Activity(id: 'F', name: 'Systemtest', duration: 4, predecessors: ['C', 'D']),
  Activity(id: 'G', name: 'Go-live', duration: 2, predecessors: ['E', 'F']),
];

/// Pufferbeispiel: B hat GP 3, aber FP 0; C hat GP 3 und FP 3.
const _npPuffer = [
  Activity(id: 'A', name: 'Planung', duration: 2),
  Activity(id: 'B', name: 'Kabel verlegen', duration: 1, predecessors: ['A']),
  Activity(id: 'C', name: 'Dosen setzen', duration: 1, predecessors: ['B']),
  Activity(id: 'D', name: 'Switch liefern', duration: 5, predecessors: ['A']),
  Activity(
    id: 'E',
    name: 'Inbetriebnahme',
    duration: 2,
    predecessors: ['C', 'D'],
  ),
];

/// Lernschritte Bereich 01, Teil 1: Projektgrundlagen, Vorgehensmodelle,
/// Scrum und Netzplantechnik. Reihenfolge je Lektion = Lernreihenfolge.
final List<Nugget> nuggetsA01 = [
  // ===================================================== Was ein Projekt ausmacht
  konzept(
    'n-pb-1',
    'p-begriff',
    'Projekt nach DIN 69901',
    'Die Norm DIN 69901 beschreibt ein Projekt als Vorhaben, das im Wesentlichen durch die Einmaligkeit seiner Bedingungen in ihrer Gesamtheit gekennzeichnet ist. Diese Einmaligkeit zeigt sich an typischen Merkmalen.',
    points: [
      'Zielvorgabe: es gibt ein klar definiertes Ergebnis',
      'Begrenzung: zeitlich (fester Start und fester Endtermin), finanziell (Budget) und personell',
      'Abgrenzung gegenüber anderen Vorhaben und dem Tagesgeschäft',
      'Projektspezifische Organisation: eigene Rollen wie Projektleitung und Projektteam',
    ],
  ),
  konzept(
    'n-pb-2',
    'p-begriff',
    'Weitere typische Kennzeichen',
    'Neben den Norm-Merkmalen nennen Lehrbücher und Musterlösungen weitere Kennzeichen. Sie treten bei Projekten fast immer auf, sind aber kein Pflichtkriterium.',
    points: [
      'Neuartigkeit: für die Beteiligten ist vieles Neuland',
      'Komplexität: viele Aufgaben, die voneinander abhängen',
      'Risiko und Unsicherheit: es fehlen Erfahrungswerte',
      'Interdisziplinäres Team: Fachleute aus mehreren Abteilungen',
      'Bedeutung für das Unternehmen: oft strategisch wichtig',
    ],
  ),
  vergleich(
    'n-pb-3',
    'p-begriff',
    'Projekt oder Linienaufgabe?',
    'Die meisten Tätigkeiten im Betrieb sind Linienaufgaben: wiederkehrend und eingespielt. Ein Projekt bricht aus dieser Routine aus.',
    [
      ['Merkmal', 'Projekt', 'Linienaufgabe'],
      ['Häufigkeit', 'einmalig', 'wiederkehrend'],
      ['Dauer', 'begrenzt, mit Start und Ende', 'dauerhaft'],
      ['Organisation', 'eigenes Projektteam', 'bestehende Abteilungen'],
      ['Ablauf', 'wird erst geplant', 'eingespielt, erprobt'],
      ['Risiko', 'höher, oft Neuland', 'gering'],
    ],
  ),
  konzept(
    'n-pb-4',
    'p-begriff',
    'Was ist Projektmanagement?',
    'Projektmanagement ist nach DIN 69901 die Gesamtheit von Führungsaufgaben, -organisation, -techniken und -mitteln für die Initiierung, Definition, Planung, Steuerung und den Abschluss von Projekten. Kurz: alles, was nötig ist, damit ein Projekt sein Ziel im vorgegebenen Rahmen erreicht.',
    points: [
      'Planen: Struktur, Termine, Ressourcen, Kosten, Risiken',
      'Organisieren: Rollen festlegen, Team zusammenstellen',
      'Steuern und kontrollieren: Soll-Ist-Vergleich, Gegenmaßnahmen',
      'Führen und kommunizieren: Team motivieren, Stakeholder informieren',
    ],
  ),
  vergleich(
    'n-pb-5',
    'p-begriff',
    'Projektarten',
    'Projekte lassen sich nach Inhalt und nach Auftraggeber einteilen. Die Einteilung hilft, typische Risiken und Beteiligte früh zu erkennen.',
    [
      ['Projektart', 'Kennzeichen', 'IT-Beispiel'],
      [
        'Investition',
        'Anschaffung von Sachmitteln',
        'neue Server für das Rechenzentrum',
      ],
      [
        'Organisation',
        'Abläufe und Strukturen ändern',
        'Einführung eines Ticketprozesses',
      ],
      ['Entwicklung', 'neues Produkt entsteht', 'Entwicklung einer Kunden-App'],
      ['intern', 'Auftraggeber im eigenen Haus', 'Umstellung auf Windows 11'],
      ['extern', 'Auftrag eines Kunden', 'Webshop für einen Händler'],
    ],
  ),
  beispiel(
    'n-pb-6',
    'p-begriff',
    'Merkmale am Fall prüfen',
    'Die Fahrschule Klein möchte bis 30.06. eine Online-Terminbuchung einführen. Budget: 12.000 €. Zwei Mitarbeitende und ein externer Entwickler arbeiten daran. Ist das ein Projekt?',
    schritte: [
      'Einmalig? Ja. Eine Online-Buchung gab es bisher nicht, Team, Budget und Termin sind so einzigartig.',
      'Zielvorgabe? Ja. Kundinnen und Kunden sollen Fahrstunden online buchen können.',
      'Begrenzung? Ja. Endtermin 30.06., 12.000 € Budget, drei Personen.',
      'Abgrenzung? Ja. Ein eigenes Vorhaben neben dem normalen Fahrschulbetrieb.',
      'Eigene Organisation? Ja. Ein kleines Team mit verteilten Rollen.',
    ],
    ergebnis: 'Alle Merkmale sind erfüllt: Es handelt sich um ein Projekt.',
  ),
  vergleich(
    'n-pb-7',
    'p-begriff',
    'Grenzfälle richtig einordnen',
    'In der Prüfung wird gern ein Vorhaben beschrieben, das auf den ersten Blick wie ein Projekt wirkt. Entscheidend ist immer, ob die Merkmale erfüllt sind.',
    [
      ['Vorhaben', 'Projekt?', 'Begründung'],
      [
        'Erstmalige Migration auf Windows 11',
        'ja',
        'einmalig, begrenzt, eigenes Team',
      ],
      ['Monatliches Einspielen von Updates', 'nein', 'wiederkehrende Routine'],
      [
        'Umzug der IT in ein neues Gebäude',
        'ja',
        'einmalig, mit festem Termin',
      ],
      ['Tägliche Benutzerbetreuung', 'nein', 'Daueraufgabe ohne Ende'],
      [
        'Jährlicher Tausch von 500 Geräten nach Checkliste',
        'nein',
        'eingespielter Ablauf',
      ],
    ],
  ),
  konzept(
    'n-pb-8',
    'p-begriff',
    'Warum Projekte scheitern',
    'Untersuchungen zu IT-Projekten nennen immer wieder dieselben Ursachen für Termin- und Kostenüberschreitungen. Gutes Projektmanagement setzt genau an diesen Stellen an.',
    points: [
      'Unklare oder sich ständig ändernde Ziele und Anforderungen',
      'Fehlende Unterstützung durch die Unternehmensleitung',
      'Schlechte Kommunikation zwischen Auftraggeber und Team',
      'Unrealistische Termin- und Kostenplanung',
      'Schleichende Ausweitung des Umfangs (Scope Creep)',
      'Risiken werden nicht erkannt oder nicht behandelt',
    ],
  ),
  falle(
    'n-pb-9',
    'p-begriff',
    'Groß heißt nicht Projekt',
    'Größe, Budget oder Teamstärke sind keine Merkmale eines Projekts. Ein zweiwöchiges, einmaliges Vorhaben mit klarem Ziel ist ein Projekt, aber der jährliche Hardware-Austausch mit 500 Geräten nach bewährtem Ablauf dagegen Routine.',
    merksatz: 'Entscheidend ist die Einmaligkeit, nicht die Größe.',
  ),
  falle(
    'n-pb-10',
    'p-begriff',
    'Einmalig heißt nicht weltneu',
    'Die Einmaligkeit bezieht sich auf die Bedingungen in ihrer Gesamtheit, nicht auf die Technik. Ein Webshop ist technisch nichts Neues: für diesen Kunden, mit diesem Team, Budget und Termin ist das Vorhaben trotzdem einmalig.',
  ),
  merke(
    'n-pb-11',
    'p-begriff',
    'Die Prüffrage',
    'Fehlt eines der Merkmale, handelt es sich um eine Linienaufgabe. Prüfe in einer Aufgabe deshalb jedes Merkmal einzeln am Text.',
    satz:
        'Einmalig, zielgerichtet, begrenzt, abgegrenzt, eigene Organisation: Erst alle zusammen machen ein Projekt.',
  ),

  // ====================================== Projektziele und magisches Dreieck
  konzept(
    'n-pz-1',
    'p-ziele',
    'Wozu Projektziele?',
    'Ziele sind der Maßstab, an dem am Ende gemessen wird, ob das Projekt erfolgreich war. Ohne messbares Ziel gibt es keine eindeutige Abnahme und keinen Streitschlichter, wenn Erwartungen auseinandergehen.',
    points: [
      'Sie geben dem Team eine gemeinsame Richtung.',
      'Sie sind Grundlage für Planung, Steuerung und Abnahme.',
      'Sie machen Erfolg und Misserfolg überprüfbar.',
    ],
  ),
  vergleich(
    'n-pz-2',
    'p-ziele',
    'Die drei Zielarten',
    'Jedes Projektziel lässt sich einer der drei Größen zuordnen. Zusammen bilden sie das magische Dreieck.',
    [
      ['Zielart', 'Frage', 'Beispiel'],
      [
        'Sachziel (Leistung)',
        'Was soll in welcher Qualität entstehen?',
        'Ticketsystem mit E-Mail-Anbindung',
      ],
      ['Terminziel', 'Bis wann?', 'Go-live am 31.03.'],
      ['Kostenziel', 'Was darf es kosten?', 'höchstens 25.000 €'],
    ],
  ),
  vergleich(
    'n-pz-3',
    'p-ziele',
    'SMART formulierte Ziele',
    'Ein Ziel ist erst prüfbar, wenn es alle fünf SMART-Kriterien erfüllt. Jeder Buchstabe steht für eine Prüffrage.',
    [
      ['Kriterium', 'Prüffrage'],
      ['Spezifisch', 'Ist eindeutig beschrieben, was erreicht werden soll?'],
      ['Messbar', 'Gibt es eine Kennzahl, an der man es erkennt?'],
      ['Attraktiv / akzeptiert', 'Tragen die Beteiligten das Ziel mit?'],
      ['Realistisch', 'Ist es mit den vorhandenen Mitteln erreichbar?'],
      ['Terminiert', 'Gibt es ein festes Datum?'],
    ],
  ),
  beispiel(
    'n-pz-4',
    'p-ziele',
    'Aus einem Wunsch wird ein SMART-Ziel',
    'Die Geschäftsführung sagt: „Unser Support soll schneller werden.“ Heute dauert es im Schnitt 8 Stunden bis zur ersten Antwort auf ein Ticket. Formuliere daraus ein SMART-Ziel.',
    schritte: [
      'Spezifisch: Was genau? Die Zeit bis zur ersten Antwort auf ein Ticket.',
      'Messbar: Kennzahl festlegen: Anteil der Tickets mit Erstantwort innerhalb von 2 Stunden.',
      'Attraktiv/akzeptiert: mit dem Support-Team abstimmen, damit es das Ziel mitträgt.',
      'Realistisch: Mit neuem Ticketsystem und Antwortvorlagen sind 2 Stunden erreichbar, aber nicht für jedes Ticket. Deshalb 90 %.',
      'Terminiert: Stichtag festlegen: ab 30.09.',
    ],
    ergebnis:
        '„Ab 30.09. erhalten 90 % aller Tickets innerhalb von 2 Stunden eine erste Antwort.“',
  ),
  konzept(
    'n-pz-5',
    'p-ziele',
    'Das magische Dreieck',
    'Leistung (Umfang und Qualität), Zeit und Kosten hängen voneinander ab. Ändert sich eine Ecke, muss mindestens eine andere nachgeben. Das Dreieck heißt „magisch“, weil sich nicht alle drei gleichzeitig optimieren lassen.',
    points: [
      'Mehr Leistung bei gleicher Zeit kostet mehr Geld.',
      'Weniger Budget bei gleicher Leistung braucht mehr Zeit.',
      'Ein früherer Termin bei gleichem Budget kostet Umfang oder Qualität.',
    ],
  ),
  vergleich(
    'n-pz-6',
    'p-ziele',
    'Zwei Ecken fest, die dritte gibt nach',
    'In Prüfungsaufgaben stehen meist zwei Größen fest. Die dritte ist dann der einzige Stellhebel.',
    [
      ['Fest vorgegeben', 'Stellhebel', 'Beispiel'],
      [
        'Termin und Budget',
        'Leistung',
        'Messe steht, kein Geld mehr: Funktionen streichen',
      ],
      [
        'Leistung und Budget',
        'Zeit',
        'alles muss rein, kein Extra-Geld: später fertig',
      ],
      [
        'Leistung und Termin',
        'Kosten',
        'Go-live fix, alles muss rein: mehr Personal',
      ],
    ],
    merksatz: 'Lies genau, welche zwei Größen die Aufgabe als fest beschreibt.',
  ),
  vergleich(
    'n-pz-7',
    'p-ziele',
    'Zielbeziehungen',
    'Ziele können sich gegenseitig unterstützen oder behindern. Konkurrierende Ziele müssen priorisiert werden, sonst ist ein Konflikt vorprogrammiert.',
    [
      ['Beziehung', 'Bedeutung', 'Beispiel'],
      [
        'komplementär',
        'fördern sich',
        'automatisierte Tests: bessere Qualität und weniger Nacharbeit',
      ],
      [
        'konkurrierend',
        'behindern sich',
        'früherer Termin und niedrigere Kosten',
      ],
      [
        'indifferent',
        'beeinflussen sich nicht',
        'Farbe der App und Standort des Servers',
      ],
    ],
  ),
  konzept(
    'n-pz-8',
    'p-ziele',
    'Der Projektauftrag',
    'Mit der Unterschrift des Auftraggebers unter den Projektauftrag beginnt das Projekt offiziell. Er hält fest, worauf sich alle geeinigt haben, und legitimiert die Projektleitung.',
    points: [
      'Ausgangslage und Anlass',
      'Ziele (SMART) und ausdrücklich auch Nicht-Ziele',
      'Endtermin und wichtige Meilensteine',
      'Budget und Ressourcen',
      'Auftraggeber, Projektleitung mit ihren Befugnissen, Team',
      'Rahmenbedingungen, bekannte Risiken, Abnahmekriterien',
    ],
  ),
  falle(
    'n-pz-9',
    'p-ziele',
    'Nicht-Ziele vergessen',
    'Was nicht ausdrücklich ausgeschlossen ist, wird später gern „noch schnell mitgemacht“. So wächst der Umfang schleichend, ohne dass Zeit oder Budget mitwachsen. Das nennt man Scope Creep.',
    points: [
      'Beispiel Nicht-Ziel: „Die Anbindung an das Buchhaltungssystem ist nicht Teil dieses Projekts.“',
    ],
    merksatz:
        'Nicht-Ziele schützen das Projekt vor Wünschen, die niemand bezahlt.',
  ),
  falle(
    'n-pz-10',
    'p-ziele',
    'Maßnahme ist kein Ziel',
    '„Wir führen ein Ticketsystem ein“ beschreibt eine Maßnahme, also den Weg. Ein Ziel beschreibt den Zustand danach, der sich prüfen lässt.',
    points: [
      'Maßnahme: „Wir führen ein Ticketsystem ein.“',
      'Ziel: „Ab 01.07. werden 100 % der Kundenanfragen im Ticketsystem erfasst.“',
    ],
  ),
  merke(
    'n-pz-11',
    'p-ziele',
    'Merksatz',
    'Gute Projektziele erfüllen drei Bedingungen zugleich.',
    satz:
        'Ziele beschreiben einen prüfbaren Zustand: SMART formuliert, durch Nicht-Ziele abgegrenzt und im Dreieck aus Leistung, Zeit und Kosten ausbalanciert.',
  ),

  // ====================================================== Organisationsformen
  konzept(
    'n-po-1',
    'p-organisation',
    'Worum es geht',
    'Ein Projektteam arbeitet nicht im luftleeren Raum, sondern innerhalb der bestehenden Linienorganisation. Die Projektorganisation regelt, wie viel die Projektleitung zu sagen hat und wie stark das Team aus der Linie herausgelöst wird.',
  ),
  skizze(
    'n-po-2',
    'p-organisation',
    'Ausgangspunkt: die Linienorganisation',
    'Die meisten Unternehmen sind als Linienorganisation aufgebaut: Jede Stelle hat genau einen Vorgesetzten. Ein Projekt, das quer durch mehrere Abteilungen läuft, passt in diese Struktur nicht hinein.',
    const BaumDiagramm(
      BaumKnoten('Geschäftsführung', [
        BaumKnoten('Vertrieb', [BaumKnoten('Mitarbeitende')]),
        BaumKnoten('IT', [BaumKnoten('Mitarbeitende')]),
        BaumKnoten('Buchhaltung', [BaumKnoten('Mitarbeitende')]),
      ]),
    ),
    points: [
      'Weisungen laufen nur von oben nach unten entlang der Linie.',
      'Ein Projekt braucht Leute aus Vertrieb, IT und Buchhaltung zugleich. Wer führt sie?',
    ],
  ),
  vergleich(
    'n-po-3',
    'p-organisation',
    'Drei Formen im Überblick',
    'Die Formen unterscheiden sich vor allem in der Weisungsbefugnis der Projektleitung (PL) und darin, ob das Team in der Linie bleibt.',
    [
      ['Form', 'Weisungsbefugnis der PL', 'Team'],
      [
        'Rein (autonom)',
        'fachlich und disziplinarisch',
        'ganz aus der Linie gelöst',
      ],
      [
        'Matrix',
        'fachlich; disziplinarisch bleibt die Linie',
        'bleibt in der Linie, arbeitet anteilig mit',
      ],
      [
        'Stab / Einfluss',
        'keine, nur beratend und koordinierend',
        'bleibt vollständig in der Linie',
      ],
    ],
  ),
  skizze(
    'n-po-4',
    'p-organisation',
    'Reine Projektorganisation im Organigramm',
    'Das Projekt steht als eigene Einheit neben den Abteilungen. Die Teammitglieder werden für die Projektdauer aus ihren Abteilungen herausgelöst und berichten nur an die Projektleitung.',
    const BaumDiagramm(
      BaumKnoten('Geschäftsführung', [
        BaumKnoten('Vertrieb'),
        BaumKnoten('IT-Betrieb'),
        BaumKnoten('Projekt ERP', [
          BaumKnoten('Entwickler 1'),
          BaumKnoten('Entwickler 2'),
          BaumKnoten('Key-User'),
        ], 'Projektleitung'),
      ]),
    ),
    points: [
      'Vorteil: klare Zuständigkeit, volle Konzentration aufs Projekt',
      'Nachteil: teuer, und nach Projektende müssen alle wieder zurück (Rückkehrproblem)',
    ],
  ),
  skizze(
    'n-po-5',
    'p-organisation',
    'Stabs-/Einflussorganisation im Organigramm',
    'Die Projektleitung sitzt als Stabsstelle neben der Geschäftsführung. Sie plant, koordiniert und berät, darf aber niemandem Anweisungen geben. Entscheidungen trifft die Linie.',
    const BaumDiagramm(
      BaumKnoten('Geschäftsführung', [
        BaumKnoten('Projektkoordination', [], 'Stabsstelle'),
        BaumKnoten('Vertrieb', [BaumKnoten('Mitarbeitende')]),
        BaumKnoten('IT', [BaumKnoten('Mitarbeitende')]),
      ]),
    ),
    points: [
      'Vorteil: kaum Aufwand, keine Umorganisation nötig',
      'Nachteil: Die Projektleitung kann nichts durchsetzen, Verantwortung ist unklar.',
    ],
  ),
  vergleich(
    'n-po-6',
    'p-organisation',
    'Die Matrix-Organisation',
    'In der Matrix kreuzen sich Linie und Projekt. Jede Person hat eine Linienvorgesetzte, die disziplinarisch führt, und für ihren Projektanteil eine Projektleitung, die fachlich führt.',
    [
      ['Abteilung', 'Projekt CRM', 'Projekt Web'],
      ['Entwicklung', 'Ali (50 %)', 'Ben (30 %)'],
      ['IT-Betrieb', 'Cem (20 %)', 'Cem (20 %)'],
      ['Vertrieb', 'Dana (30 %)', '-'],
    ],
    points: [
      'Zeilen: Linie: disziplinarische Führung (Urlaub, Beurteilung)',
      'Spalten: Projekte: fachliche Führung (Aufgaben, Termine)',
      'Cem arbeitet für zwei Projekte und hat damit drei Ansprechpersonen.',
    ],
  ),
  vergleich(
    'n-po-7',
    'p-organisation',
    'Stärken und Schwächen',
    'Jede Form hat einen typischen Preis. In Prüfungen werden Vor- und Nachteile häufig abgefragt.',
    [
      ['Form', 'Stärke', 'Schwäche'],
      [
        'Rein',
        'klare Zuständigkeit, schnelle Entscheidungen, hohe Identifikation',
        'teuer, Rückkehrproblem nach Projektende',
      ],
      [
        'Matrix',
        'Ressourcen flexibel nutzbar, Know-how bleibt in der Linie',
        'zwei Vorgesetzte, Prioritätenkonflikte',
      ],
      [
        'Einfluss',
        'wenig Aufwand, keine Umorganisation',
        'PL kann nichts durchsetzen, langsam',
      ],
    ],
  ),
  falle(
    'n-po-8',
    'p-organisation',
    'Fachlich oder disziplinarisch?',
    'Die Prüfung vertauscht die beiden Begriffe gern. Präge dir je ein typisches Beispiel ein.',
    points: [
      'Fachlich: WAS und WIE gearbeitet wird: Aufgaben, Termine, Qualität',
      'Disziplinarisch: Urlaub, Beurteilung, Gehalt, Abmahnung',
      'In der Matrix: fachlich die Projektleitung, disziplinarisch der Linienvorgesetzte',
    ],
  ),
  vergleich(
    'n-po-9',
    'p-organisation',
    'Die richtige Form wählen',
    'Die Wahl hängt vor allem von Größe, Dauer und Bedeutung des Projekts ab und davon, wie stark die Mitarbeitenden eingebunden sind.',
    [
      ['Kriterium', 'Rein', 'Matrix', 'Einfluss'],
      ['Größe', 'groß', 'mittel', 'klein'],
      ['Dauer', 'lang', 'mittel', 'kurz'],
      ['Bedeutung, Risiko', 'hoch', 'mittel', 'gering'],
      ['Mitarbeit', 'Vollzeit', 'anteilig', 'nebenbei'],
      ['Aufwand', 'hoch', 'mittel', 'gering'],
    ],
  ),
  beispiel(
    'n-po-10',
    'p-organisation',
    'Organisationsform begründen',
    'Ein Systemhaus mit 80 Mitarbeitenden führt eine neue Zeiterfassung ein. Das Projekt dauert 4 Monate. Beschäftigte aus IT, Personal und Buchhaltung arbeiten zu 20 bis 40 % mit, die Projektleitung soll ihnen Aufgaben zuweisen können. Welche Organisationsform passt?',
    schritte: [
      'Größe und Dauer: mittel: vier Monate, drei Abteilungen beteiligt.',
      'Mitarbeit: anteilig: alle bleiben in ihren Abteilungen.',
      'Befugnis: Die Projektleitung braucht fachliche Weisungsbefugnis.',
      'Reine Projektorganisation wäre für Teilzeit-Mitarbeit zu aufwendig, die Einflussorganisation gäbe keine Weisungsbefugnis.',
    ],
    ergebnis: 'Matrix-Projektorganisation',
  ),
  merke(
    'n-po-11',
    'p-organisation',
    'Faustregel',
    'Die Wahl richtet sich nach Bedeutung und Umfang des Projekts.',
    satz:
        'Je größer, länger und riskanter das Projekt, desto reiner die Projektorganisation. Matrix ist der Normalfall dazwischen.',
  ),

  // =========================================================== Rollen im Projekt
  konzept(
    'n-pr-1',
    'p-rollen',
    'Rollen statt Personen',
    'Eine Rolle bündelt Aufgaben, Kompetenzen (Befugnisse) und Verantwortung. Eine Person kann mehrere Rollen haben. In kleinen Projekten ist die Projektleitung oft zugleich Teammitglied.',
    points: [
      'Aufgabe: was zu tun ist',
      'Kompetenz: was entschieden werden darf',
      'Verantwortung: wofür man geradesteht',
      'Kongruenzprinzip: Alle drei müssen zusammenpassen: Wer Verantwortung trägt, braucht die passenden Befugnisse.',
    ],
  ),
  skizze(
    'n-pr-2',
    'p-rollen',
    'Die Projektorganisation im Überblick',
    'So sind die Rollen in einem größeren klassischen Projekt angeordnet. Der Auftraggeber sitzt meist selbst im Lenkungsausschuss.',
    const BaumDiagramm(
      BaumKnoten('Lenkungsausschuss', [
        BaumKnoten('Projektleitung', [
          BaumKnoten('Teilprojekt Technik', [
            BaumKnoten('Teammitglieder'),
          ], 'Teilprojektleitung'),
          BaumKnoten('Teilprojekt Schulung', [
            BaumKnoten('Teammitglieder'),
          ], 'Teilprojektleitung'),
          BaumKnoten('Key-User'),
        ]),
      ], 'mit Auftraggeber'),
    ),
  ),
  vergleich(
    'n-pr-3',
    'p-rollen',
    'Wer macht was?',
    'In klassischen Projekten sind die Rollen klar getrennt: Jede hat eigene Entscheidungsrechte.',
    [
      ['Rolle', 'Aufgabe'],
      [
        'Auftraggeber',
        'gibt das Projekt in Auftrag, stellt das Budget bereit, nimmt das Ergebnis ab',
      ],
      [
        'Lenkungsausschuss',
        'oberstes Entscheidungsgremium: Eskalationen, Budget- und Terminänderungen, Freigabe an Meilensteinen',
      ],
      [
        'Projektleitung',
        'plant, steuert und kontrolliert das Projekt, führt das Team, berichtet',
      ],
      [
        'Projektteam',
        'bearbeitet die Arbeitspakete und meldet Fortschritt und Probleme',
      ],
    ],
  ),
  ablauf(
    'n-pr-4',
    'p-rollen',
    'Die Aufgaben der Projektleitung',
    'Die Projektleitung arbeitet in einem wiederkehrenden Kreislauf. Selbst programmieren oder installieren gehört nicht zu ihren Kernaufgaben.',
    [
      'Planen: Termine, Ressourcen, Kosten, Risiken',
      'Organisieren: Team zusammenstellen, Aufgaben verteilen',
      'Führen: Team motivieren, Konflikte lösen',
      'Steuern und kontrollieren: Soll-Ist-Vergleich, Gegenmaßnahmen',
      'Berichten: Statusberichte an Auftraggeber und Lenkungsausschuss',
    ],
  ),
  konzept(
    'n-pr-5',
    'p-rollen',
    'Weitere Beteiligte',
    'Je nach Größe kommen weitere Rollen hinzu. Sie tauchen in Prüfungsaufgaben oft in der Situationsbeschreibung auf.',
    points: [
      'Teilprojektleitung: führt einen Teilbereich eines großen Projekts',
      'Key-User: erfahrene Anwender, bringen Fachwissen ein und schulen später Kolleginnen und Kollegen',
      'Fachexperten: werden für einzelne Fragen hinzugezogen',
      'Projektbüro (PMO): unterstützt bei Planung, Berichten und Dokumentation',
      'Betriebsrat, Datenschutzbeauftragte: wirken mit, wenn ihre Belange betroffen sind',
    ],
  ),
  vergleich(
    'n-pr-6',
    'p-rollen',
    'Die Verantwortungsmatrix (RACI)',
    'Eine RACI-Matrix zeigt für jede Aufgabe, wer sie durchführt, wer sie verantwortet, wer vorher gefragt und wer informiert wird. Je Aufgabe gibt es genau ein A.',
    [
      ['Aufgabe', 'PL', 'Team', 'AG'],
      ['Terminplan erstellen', 'R, A', 'C', 'I'],
      ['Modul entwickeln', 'A', 'R', '-'],
      ['Budget erhöhen', 'C', '-', 'R, A'],
      ['Ergebnis abnehmen', 'C', 'I', 'R, A'],
    ],
    points: [
      'R (Responsible): führt die Aufgabe durch',
      'A (Accountable): verantwortet das Ergebnis, entscheidet',
      'C (Consulted): wird vorher um Rat gefragt',
      'I (Informed): wird über das Ergebnis informiert',
      'PL = Projektleitung, AG = Auftraggeber',
    ],
  ),
  konzept(
    'n-pr-7',
    'p-rollen',
    'Das Kick-off-Meeting',
    'Der offizielle Startschuss mit allen Beteiligten. Ziel ist ein gemeinsames Verständnis, bevor die eigentliche Arbeit beginnt. Es ist keine Detailplanung.',
    points: [
      'Ziele und Nicht-Ziele vorstellen',
      'Rollen und Zuständigkeiten klären',
      'Vorgehen, Meilensteine und Termine vorstellen',
      'Kommunikationswege und Spielregeln vereinbaren',
      'Nächste Schritte festlegen',
    ],
  ),
  ablauf(
    'n-pr-8',
    'p-rollen',
    'Der Eskalationsweg',
    'Probleme werden zuerst dort gelöst, wo sie entstehen. Reicht die Befugnis nicht aus, geht die Entscheidung eine Stufe höher.',
    [
      'Teammitglied löst das Problem im eigenen Arbeitspaket',
      'Projektleitung entscheidet im Rahmen des Auftrags, z. B. Aufgaben umverteilen oder Puffer nutzen',
      'Lenkungsausschuss entscheidet über Änderungen an Budget, Termin oder Umfang',
      'Auftraggeber bzw. Geschäftsführung entscheidet im Extremfall über Fortsetzung oder Abbruch',
    ],
    skizze: const FlussDiagramm([
      FlussKnoten('Problem tritt auf', form: FlussForm.start),
      FlussKnoten(
        'Im Arbeitspaket lösbar?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] Team löst es',
      ),
      FlussKnoten(
        'Im Rahmen des Auftrags?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] PL entscheidet',
      ),
      FlussKnoten('Lenkungsausschuss entscheidet'),
      FlussKnoten('Entscheidung dokumentiert', form: FlussForm.ende),
    ]),
  ),
  vergleich(
    'n-pr-9',
    'p-rollen',
    'Der Statusbericht',
    'Die Projektleitung berichtet regelmäßig an Auftraggeber und Lenkungsausschuss. Üblich ist eine Ampel je Bereich: Termine, Kosten, Leistung.',
    [
      ['Ampel', 'Bedeutung'],
      ['Grün', 'im Plan'],
      ['Gelb', 'Abweichung: die Projektleitung steuert selbst gegen'],
      ['Rot', 'Rahmen gefährdet: Entscheidung des Lenkungsausschusses nötig'],
    ],
    points: [
      'Inhalt: Soll-Ist-Vergleich, erledigte und nächste Schritte, Risiken, Entscheidungsbedarf',
    ],
  ),
  falle(
    'n-pr-10',
    'p-rollen',
    'Wer entscheidet?',
    'Die Projektleitung entscheidet im Rahmen des Projektauftrags. Alles, was diesen Rahmen verändert (mehr Budget, späterer Termin, anderer Umfang) entscheidet der Auftraggeber bzw. der Lenkungsausschuss.',
    points: [
      'Droht der Rahmen zu platzen, eskaliert die Projektleitung früh, nicht erst im Abschlussbericht.',
    ],
    merksatz:
        'Die Projektleitung führt das Projekt, sie ändert nicht den Auftrag.',
  ),
  merke(
    'n-pr-11',
    'p-rollen',
    'Merksatz',
    'Jede Rolle hat ihre eigene Frage, auf die sie antwortet.',
    satz:
        'Auftraggeber beauftragt und nimmt ab, Lenkungsausschuss entscheidet über den Rahmen, Projektleitung steuert, Team setzt um.',
  ),

  // ===================================================== Stakeholder analysieren
  konzept(
    'n-ps-1',
    'p-stakeholder',
    'Wer sind Stakeholder?',
    'Stakeholder sind alle Personen und Gruppen, die vom Projekt betroffen sind, daran beteiligt sind oder es beeinflussen können, intern wie extern. Wer sie übersieht, erlebt späten Widerstand.',
    points: [
      'Intern: Geschäftsführung, Fachabteilungen, Anwender, Betriebsrat, IT-Betrieb',
      'Extern: Kunden, Lieferanten, Dienstleister, Behörden, Öffentlichkeit',
    ],
  ),
  vergleich(
    'n-ps-2',
    'p-stakeholder',
    'Beispiele aus einem IT-Projekt',
    'Jeder Stakeholder hat eigene Erwartungen. Sie zu kennen, ist die Grundlage für die richtige Ansprache.',
    [
      ['Stakeholder', 'Art', 'Typisches Anliegen'],
      ['Geschäftsführung', 'intern', 'Nutzen, Kosten, Termin'],
      ['Anwender', 'intern', 'einfache Bedienung, Schulung'],
      ['Betriebsrat', 'intern', 'Mitbestimmung, keine Leistungskontrolle'],
      ['IT-Betrieb', 'intern', 'sicher und wartbar'],
      ['Kunden', 'extern', 'Service bleibt erreichbar'],
      ['Dienstleister', 'extern', 'klarer Auftrag, pünktliche Zahlung'],
    ],
  ),
  ablauf(
    'n-ps-3',
    'p-stakeholder',
    'Die Stakeholderanalyse',
    'Die Analyse läuft in vier Schritten und wird im Projektverlauf regelmäßig aktualisiert.',
    [
      'Stakeholder identifizieren: Brainstorming, Organigramm, Projektauftrag',
      'Einfluss, Interesse und Einstellung zum Projekt einschätzen',
      'In das Stakeholder-Portfolio einordnen',
      'Passende Maßnahmen festlegen, umsetzen und überprüfen',
    ],
  ),
  konzept(
    'n-ps-4',
    'p-stakeholder',
    'Wonach bewertet wird',
    'Für jeden Stakeholder werden mehrere Merkmale eingeschätzt. Die beiden wichtigsten ergeben die Position im Portfolio.',
    points: [
      'Einfluss (Macht): Kann die Gruppe das Projekt fördern oder stoppen?',
      'Interesse (Betroffenheit): Wie stark ist sie vom Ergebnis betroffen?',
      'Einstellung: Befürworter (Promotor), neutral oder Gegner (Opponent)?',
      'Erwartungen und Befürchtungen: Was will die Gruppe erreichen oder verhindern?',
    ],
  ),
  skizze(
    'n-ps-5',
    'p-stakeholder',
    'Das Stakeholder-Portfolio',
    'Einfluss und Interesse spannen eine Matrix mit vier Feldern auf. Jedes Feld hat eine eigene Strategie.',
    const QuadrantenDiagramm(
      xAchse: 'Interesse',
      yAchse: 'Einfluss',
      obenLinks: Quadrant(
        'Zufriedenstellen',
        'hoher Einfluss, geringes Interesse',
      ),
      obenRechts: Quadrant('Eng einbinden', 'hoher Einfluss, hohes Interesse'),
      untenLinks: Quadrant(
        'Beobachten',
        'geringer Einfluss, geringes Interesse',
      ),
      untenRechts: Quadrant(
        'Informieren',
        'geringer Einfluss, hohes Interesse',
      ),
    ),
  ),
  vergleich(
    'n-ps-6',
    'p-stakeholder',
    'Strategien und konkrete Maßnahmen',
    'Aus der Position im Portfolio folgt, wie intensiv eine Gruppe eingebunden wird.',
    [
      ['Strategie', 'Maßnahmen'],
      [
        'Eng einbinden',
        'an Entscheidungen beteiligen, Lenkungsausschuss, Workshops',
      ],
      [
        'Zufriedenstellen',
        'kurze, regelmäßige Berichte, vor Entscheidungen abstimmen',
      ],
      ['Informieren', 'Newsletter, Demo-Termine, Schulungen, Intranet'],
      ['Beobachten', 'mit geringem Aufwand im Blick behalten'],
    ],
  ),
  beispiel(
    'n-ps-7',
    'p-stakeholder',
    'Stakeholder einordnen',
    'Ein Autohaus führt ein neues Werkstatt-Terminsystem ein. Einfluss und Interesse wurden von 1 (gering) bis 5 (hoch) bewertet; ab 3 gilt ein Wert als hoch. Ordne jede Gruppe ein.',
    table: [
      ['Stakeholder', 'Einfluss', 'Interesse'],
      ['Geschäftsführer', '5', '4'],
      ['Betriebsrat', '4', '2'],
      ['Serviceberater', '2', '5'],
      ['Reinigungsfirma', '1', '1'],
    ],
    schritte: [
      'Geschäftsführer: 5 und 4, beides hoch → eng einbinden',
      'Betriebsrat: Einfluss 4 hoch, Interesse 2 gering → zufriedenstellen',
      'Serviceberater: Einfluss 2 gering, Interesse 5 hoch → informieren',
      'Reinigungsfirma: 1 und 1, beides gering → beobachten',
    ],
    ergebnis:
        'Eng einbinden: Geschäftsführer · Zufriedenstellen: Betriebsrat · Informieren: Serviceberater · Beobachten: Reinigungsfirma',
  ),
  vergleich(
    'n-ps-8',
    'p-stakeholder',
    'Der Kommunikationsplan',
    'Aus der Analyse entsteht der Kommunikationsplan. Er legt fest, wer welche Information wann und auf welchem Weg bekommt.',
    [
      ['Wer', 'Was', 'Wie und wann'],
      [
        'Lenkungsausschuss',
        'Statusbericht, Entscheidungen',
        'Sitzung, monatlich',
      ],
      ['Projektteam', 'Aufgaben, Probleme', 'Teammeeting, wöchentlich'],
      [
        'Anwender',
        'Neuigkeiten, Schulungstermine',
        'Newsletter, alle zwei Wochen',
      ],
      [
        'Betriebsrat',
        'Konzept, verarbeitete Daten',
        'Termin vor der Einführung',
      ],
    ],
  ),
  falle(
    'n-ps-9',
    'p-stakeholder',
    'Das unterschätzte Feld',
    'Am häufigsten gefragt wird „hoher Einfluss, geringes Interesse“, weil es am wenigsten intuitiv ist. Eng einbinden wäre hier falsch: Diese Gruppe will nicht mit Details überhäuft werden, kann das Projekt aber jederzeit stoppen.',
    points: [
      'Typisch: Geschäftsführung anderer Bereiche, Betriebsrat',
      'Der Betriebsrat bestimmt bei IT-Systemen mit, mit denen sich Leistung oder Verhalten von Beschäftigten überwachen lassen (§ 87 Abs. 1 Nr. 6 BetrVG), also ihn frühzeitig einbeziehen.',
    ],
  ),
  falle(
    'n-ps-10',
    'p-stakeholder',
    'Einmal analysiert reicht nicht',
    'Stakeholder verändern sich: Ein Gegner wird durch gute Einbindung zum Befürworter, ein unbeteiligter Bereich ist plötzlich betroffen. Deshalb wird die Analyse im Projektverlauf regelmäßig überprüft.',
    points: [
      'Gegner nicht ignorieren: Einwände früh anhören und Betroffene beteiligen',
    ],
  ),
  merke(
    'n-ps-11',
    'p-stakeholder',
    'Merksatz',
    'Stakeholdermanagement ist gezielte Kommunikation.',
    satz:
        'Einfluss und Interesse bestimmen die Strategie: Nicht jeder Stakeholder braucht alles, aber jeder braucht das Passende.',
  ),

  // ================================================================ Projektphasen
  konzept(
    'n-vp-1',
    'v-phasen',
    'Warum Phasen?',
    'Phasen zerlegen ein Projekt in überschaubare Abschnitte. Jede Phase endet mit einem Ergebnis und einer Entscheidung, ob und wie es weitergeht. So bleibt das Projekt steuerbar und Fehlentwicklungen fallen früh auf.',
    points: [
      'Überschaubare Abschnitte statt eines riesigen Blocks',
      'Klare Zwischenergebnisse, die sich prüfen lassen',
      'Entscheidungspunkte: weitermachen, anpassen oder abbrechen',
    ],
  ),
  skizze(
    'n-vp-2',
    'v-phasen',
    'Die fünf Phasen nach DIN 69901',
    'Die Norm gliedert das Projektmanagement in fünf Phasen. Zwischen den Phasen liegen Meilensteine, an denen über das Weitermachen entschieden wird.',
    const FlussDiagramm([
      FlussKnoten('Initialisierung', pfeil: 'M1 Auftrag erteilt'),
      FlussKnoten('Definition', pfeil: 'M2 Anforderungen frei'),
      FlussKnoten('Planung', pfeil: 'M3 Plan freigegeben'),
      FlussKnoten('Steuerung', pfeil: 'M4 Ergebnis fertiggestellt'),
      FlussKnoten('Abschluss'),
    ]),
  ),
  ablauf(
    'n-vp-3',
    'v-phasen',
    'Was in jeder Phase passiert',
    'Jede Phase hat ihre eigene Leitfrage und ihre eigenen Tätigkeiten.',
    [
      'Initialisierung: Ist die Idee sinnvoll? Projektidee prüfen, Projektauftrag erstellen, Projektleitung benennen',
      'Definition: Was genau soll entstehen? Ziele, Anforderungen, Machbarkeit, Stakeholder klären',
      'Planung: Wie und wann? Projektstrukturplan, Termine, Ressourcen, Kosten, Risiken planen',
      'Steuerung: Läuft es nach Plan? Umsetzung überwachen, Soll-Ist-Vergleich, Änderungen steuern',
      'Abschluss: Ist alles erledigt? Abnahme, Abschlussbericht, Lessons Learned, Team auflösen',
    ],
  ),
  vergleich(
    'n-vp-4',
    'v-phasen',
    'Was am Ende jeder Phase vorliegt',
    'In der Prüfung wird gern nach dem Ergebnis einer Phase gefragt, oder umgekehrt nach der Phase zu einem Dokument.',
    [
      ['Phase', 'Typisches Ergebnis'],
      ['Initialisierung', 'unterschriebener Projektauftrag'],
      ['Definition', 'Lastenheft, Machbarkeitsbewertung, Stakeholderanalyse'],
      [
        'Planung',
        'Projektstrukturplan, Terminplan, Kosten- und Ressourcenplan',
      ],
      ['Steuerung', 'Statusberichte, umgesetzte Arbeitspakete'],
      ['Abschluss', 'Abnahmeprotokoll, Abschlussbericht'],
    ],
  ),
  konzept(
    'n-vp-5',
    'v-phasen',
    'Meilensteine',
    'Ein Meilenstein ist ein Ereignis ohne Dauer, an dem ein prüfbares Zwischenergebnis vorliegt. Meist schließt er eine Phase ab; dort wird entschieden, ob die nächste Phase beginnen darf (Phasenfreigabe).',
    points: [
      'Gut formuliert: „Pflichtenheft vom Kunden unterschrieben“: eindeutig erreicht oder nicht',
      'Schlecht formuliert: „Konzept weitgehend fertig“: nicht prüfbar',
      'Im Gantt-Diagramm als Raute mit Dauer 0 dargestellt',
    ],
  ),
  falle(
    'n-vp-6',
    'v-phasen',
    'Phase oder Meilenstein?',
    'Eine Phase ist ein Zeitraum, in dem gearbeitet wird. Ein Meilenstein ist ein Zeitpunkt ohne Dauer, der meist das Ende einer Phase markiert. Er verbraucht weder Zeit noch Ressourcen.',
    merksatz: 'Phasen dauern, Meilensteine passieren.',
  ),
  vergleich(
    'n-vp-7',
    'v-phasen',
    'Projektphasen und Entwicklungsphasen',
    'Die DIN-Phasen beschreiben das Management eines Projekts. Ein Vorgehensmodell wie der Wasserfall beschreibt dagegen, wie das Produkt entwickelt wird. Diese Arbeit läuft vor allem in der Steuerungsphase.',
    [
      ['', 'Projektphasen (DIN)', 'Wasserfallphasen'],
      ['Blick auf', 'Führung des Projekts', 'Entwicklung des Produkts'],
      ['Beispiele', 'Planung, Steuerung', 'Entwurf, Implementierung, Test'],
      ['Gilt für', 'jedes Projekt', 'klassische Softwareprojekte'],
    ],
  ),
  beispiel(
    'n-vp-8',
    'v-phasen',
    'Tätigkeiten den Phasen zuordnen',
    'Im Projekt „Neues WLAN für die Berufsschule“ fallen die folgenden Tätigkeiten an. Ordne jede einer Phase zu.',
    schritte: [
      'Die Schulleitung unterschreibt den Projektauftrag → Initialisierung',
      'Anforderungen sammeln: 40 Räume, 600 Geräte, eigenes Gastnetz → Definition',
      'Arbeitspakete, Terminplan und Kostenplan erstellen → Planung',
      'Access Points montieren und wöchentlich Soll und Ist vergleichen → Steuerung',
      'Abnahme mit der Schulleitung, Lessons-Learned-Runde → Abschluss',
    ],
    ergebnis: 'Initialisierung → Definition → Planung → Steuerung → Abschluss',
  ),
  konzept(
    'n-vp-9',
    'v-phasen',
    'Phasen auch in agilen Projekten',
    'Auch ein Scrum-Projekt wird beauftragt und am Ende abgeschlossen. Der Unterschied liegt in der Mitte: Planung und Umsetzung wechseln sich in jedem Sprint ab, statt einmal nacheinander zu laufen.',
  ),
  merke(
    'n-vp-10',
    'v-phasen',
    'Die Logik dahinter',
    'Die Reihenfolge der Phasen folgt einer einfachen Idee.',
    satz:
        'Erst klären, OB (Initialisierung) und WAS (Definition), dann WIE und WANN (Planung), dann TUN und STEUERN, zuletzt ABSCHLIESSEN.',
  ),

  // ============================================================ Wasserfallmodell
  konzept(
    'n-vw-1',
    'v-wasserfall',
    'Das Prinzip',
    'Im Wasserfallmodell laufen die Phasen der Softwareentwicklung streng nacheinander ab. Jede Phase wird vollständig abgeschlossen und dokumentiert, bevor die nächste beginnt, wie Wasser, das Stufe für Stufe nach unten fällt.',
    points: [
      'Geht auf eine Veröffentlichung von Winston W. Royce (1970) zurück',
      'Sequenziell: keine Überlappung der Phasen',
      'Dokumentgetrieben: Jede Phase liefert ein freigegebenes Dokument.',
    ],
  ),
  skizze(
    'n-vw-2',
    'v-wasserfall',
    'Die Phasen als Kaskade',
    'Die Ergebnisse einer Phase fließen als Vorgabe in die nächste. An den Pfeilen steht, was weitergegeben wird.',
    const FlussDiagramm([
      FlussKnoten('Anforderungsanalyse', pfeil: 'Lasten-/Pflichtenheft'),
      FlussKnoten('Entwurf', pfeil: 'Entwurfsdokument'),
      FlussKnoten('Implementierung', pfeil: 'Programmcode'),
      FlussKnoten('Test', pfeil: 'Testprotokoll, Abnahme'),
      FlussKnoten('Einführung und Betrieb'),
    ]),
  ),
  vergleich(
    'n-vw-3',
    'v-wasserfall',
    'Phasen, Tätigkeiten, Ergebnisse',
    'Für jede Phase solltest du wissen, was dort getan wird und welches Dokument am Ende steht.',
    [
      ['Phase', 'Tätigkeit', 'Ergebnis'],
      [
        'Analyse',
        'Anforderungen erheben und prüfen',
        'Lastenheft, Pflichtenheft',
      ],
      [
        'Entwurf',
        'Architektur, Datenmodell, Schnittstellen',
        'Entwurfsdokument',
      ],
      ['Implementierung', 'programmieren, Module testen', 'Programmcode'],
      ['Test', 'Integrations-, System-, Abnahmetest', 'Testprotokoll, Abnahme'],
      [
        'Einführung, Betrieb',
        'installieren, schulen, warten',
        'laufendes System',
      ],
    ],
  ),
  konzept(
    'n-vw-4',
    'v-wasserfall',
    'Lastenheft und Pflichtenheft',
    'Beide Dokumente entstehen in der Anforderungsanalyse und sind die Grundlage aller folgenden Phasen.',
    points: [
      'Lastenheft: vom Auftraggeber: WAS soll das System leisten und WOFÜR?',
      'Pflichtenheft: vom Auftragnehmer: WIE und WOMIT werden die Anforderungen umgesetzt?',
      'Das freigegebene Pflichtenheft ist die verbindliche Grundlage für Entwurf, Test und Abnahme.',
    ],
  ),
  konzept(
    'n-vw-5',
    'v-wasserfall',
    'Phasenabschluss mit Freigabe',
    'Am Ende jeder Phase wird das Ergebnisdokument geprüft und freigegeben. Erst dann startet die nächste Phase. Das Dokument ist ab jetzt die verbindliche Vorgabe.',
    points: [
      'Im strengen Modell gibt es keinen Weg zurück.',
      'Das erweiterte Wasserfallmodell erlaubt Rücksprünge in die direkt vorhergehende Phase, wenn dort Fehler entdeckt werden.',
      'Änderungen an freigegebenen Ergebnissen laufen über ein formales Änderungsverfahren (Change Request).',
    ],
  ),
  vergleich(
    'n-vw-6',
    'v-wasserfall',
    'Stärken und Schwächen',
    'Das Modell ist nicht veraltet. Es passt nur zu bestimmten Projekten.',
    [
      ['Stärke', 'Schwäche'],
      ['klare Struktur, gut planbar', 'Änderungen sind spät und teuer'],
      ['vollständige Dokumentation', 'Kunde sieht das Ergebnis erst am Ende'],
      [
        'Festpreis und Termin gut kalkulierbar',
        'Fehler aus der Analyse fallen erst im Test auf',
      ],
      [
        'einfache Fortschrittskontrolle',
        'setzt vollständige Anforderungen voraus',
      ],
    ],
  ),
  beispiel(
    'n-vw-7',
    'v-wasserfall',
    'Die Rule of Ten durchgerechnet',
    'Ein Fehler in der Anforderungsanalyse ließe sich dort für 100 € beheben. Nach der Faustregel „Rule of Ten“ verzehnfachen sich die Kosten mit jeder Phase, in der er unentdeckt bleibt. Was kostet er, wenn er erst im Test auffällt?',
    schritte: [
      'Anforderungsanalyse: 100 €, sofort entdeckt, nur das Dokument ändern',
      'Entwurf: 100 € × 10 = 1.000 €, Entwurf muss mit geändert werden',
      'Implementierung: 1.000 € × 10 = 10.000 €, Code muss umgeschrieben werden',
      'Test: 10.000 € × 10 = 100.000 €, Analyse, Entwurf, Code und Tests nachbessern',
    ],
    ergebnis: '100.000 €, also das Tausendfache (drei Phasen später: 10³)',
    skizze: const BalkenDiagramm([
      Balken('Analyse', 100),
      Balken('Entwurf', 1000),
      Balken('Implementierung', 10000),
      Balken('Test', 100000, hervorheben: true),
    ], einheit: '€'),
  ),
  falle(
    'n-vw-8',
    'v-wasserfall',
    'Späte Änderungswünsche',
    'Will der Kunde nach Freigabe des Pflichtenhefts etwas ändern, wird das nicht einfach „mitgemacht“. Es ist ein Change Request: Aufwand und Folgen für Termin und Kosten werden bewertet, dann wird neu entschieden und vereinbart.',
  ),
  falle(
    'n-vw-9',
    'v-wasserfall',
    'Testen erst am Ende?',
    'Auch im Wasserfall testen Entwickler ihre Module schon bei der Implementierung. Die eigene Testphase prüft das Zusammenspiel und das Gesamtsystem gegen die Anforderungen und genau dort fallen Analysefehler erst auf.',
  ),
  merke(
    'n-vw-10',
    'v-wasserfall',
    'Wann Wasserfall passt',
    'Das Modell spielt seine Stärken aus, wenn wenig Unsicherheit besteht.',
    points: [
      'Anforderungen sind vollständig bekannt und stabil',
      'Festpreis oder öffentliche Ausschreibung',
      'Nachweis- und Dokumentationspflichten, z. B. bei Behörden',
      'Bekannte Technik, erfahrenes Team',
    ],
    satz:
        'Wasserfall: erst vollständig planen, dann bauen. Das ist ideal bei klaren, stabilen Anforderungen.',
  ),

  // ======================================================== Klassisch oder agil?
  konzept(
    'n-va-1',
    'v-auswahl',
    'Die entscheidende Frage',
    'Seit dem Prüfungskatalog 2025 sind Wasserfall und Scrum die beiden Vorgehensmodelle der AP1. Die Wahl hängt vor allem davon ab, wie sicher die Anforderungen sind und wie früh der Kunde nutzbare Ergebnisse braucht.',
  ),
  vergleich(
    'n-va-2',
    'v-auswahl',
    'Wasserfall oder Scrum?',
    'Gefragt wird meist, welches Modell zu einer beschriebenen Situation passt, mit Begründung.',
    [
      ['', 'Wasserfall', 'Scrum'],
      ['Planung', 'vollständig vorab', 'grob vorab, im Detail je Sprint'],
      [
        'Anforderungen',
        'fest im Pflichtenheft',
        'veränderlich im Product Backlog',
      ],
      [
        'Ergebnis',
        'am Projektende',
        'nach jedem Sprint ein nutzbares Increment',
      ],
      [
        'Kundenkontakt',
        'vor allem am Anfang und Ende',
        'laufend, in jedem Sprint Review',
      ],
      [
        'Änderungen',
        'teuer, per Change Request',
        'willkommen, neu priorisiert',
      ],
      [
        'Passt bei',
        'klaren, stabilen Anforderungen',
        'unklaren, sich ändernden Anforderungen',
      ],
    ],
  ),
  vergleich(
    'n-va-3',
    'v-auswahl',
    'Das umgedrehte Dreieck',
    'Beide Modelle gehen verschieden mit dem magischen Dreieck um. Im Wasserfall ist der Umfang fest und Zeit und Kosten werden geschätzt. In Scrum ist es umgekehrt.',
    [
      ['', 'Wasserfall', 'Scrum'],
      ['fest', 'Umfang (Pflichtenheft)', 'Zeit (Sprints) und Kosten (Team)'],
      ['geschätzt', 'Zeit und Kosten', 'Umfang'],
      [
        'bei Engpass',
        'Termin oder Budget verschieben',
        'Unwichtiges später oder gar nicht',
      ],
    ],
  ),
  konzept(
    'n-va-4',
    'v-auswahl',
    'Iterativ und inkrementell',
    'Scrum arbeitet iterativ und inkrementell. Das sind zwei Begriffe, die oft verwechselt werden. Der Wasserfall ist dagegen sequenziell.',
    points: [
      'Iterativ: in Wiederholungen arbeiten und das Ergebnis dabei verbessern',
      'Inkrementell: das Produkt Stück für Stück erweitern',
      'Beispiel Webshop: Sprint 1 liefert die Produktliste, Sprint 2 den Warenkorb (inkrementell). Die Produktliste wird dabei nach Rückmeldungen verbessert (iterativ).',
    ],
  ),
  vergleich(
    'n-va-5',
    'v-auswahl',
    'Kriterien für die Auswahl',
    'Diese Kriterien helfen, eine Projektsituation einzuordnen. Selten sprechen alle für dasselbe Modell. Entscheidend ist die Gesamtschau.',
    [
      ['Kriterium', 'Wasserfall', 'Scrum'],
      ['Anforderungen', 'klar, stabil', 'unklar, ändern sich'],
      ['Kunde', 'wenig verfügbar', 'regelmäßig verfügbar'],
      ['Vertrag', 'Festpreis, fester Umfang', 'Aufwand, flexibler Umfang'],
      ['Nutzen', 'erst am Ende nötig', 'möglichst früh gewünscht'],
      ['Technik', 'bekannt', 'Neuland'],
      ['Dokumentation', 'Nachweispflicht', 'schlank genügt'],
    ],
  ),
  beispiel(
    'n-va-6',
    'v-auswahl',
    'Situation 1: die Patienten-App',
    'Eine Arztpraxis möchte eine Patienten-App. Die Praxisleitung hat nur grobe Ideen, will aber schnell erste Funktionen ausprobieren und kann alle zwei Wochen Rückmeldung geben. Das Budget pro Monat ist fest. Welches Modell passt?',
    schritte: [
      'Anforderungen: nur grob, werden sich durch Erfahrung ändern → spricht für Scrum',
      'Kunde: alle zwei Wochen verfügbar → passt zu zweiwöchigen Sprints mit Review',
      'Früher Nutzen gewünscht → nach jedem Sprint ein nutzbares Increment',
      'Budget fest, Umfang offen → entspricht dem umgedrehten Dreieck von Scrum',
    ],
    ergebnis: 'Scrum: Alle Kriterien sprechen dafür.',
  ),
  beispiel(
    'n-va-7',
    'v-auswahl',
    'Situation 2: die Telefonanlage',
    'Eine Stadtverwaltung schreibt die Erneuerung ihrer Telefonanlage öffentlich aus: 120 Anschlüsse, das Leistungsverzeichnis steht fest, Festpreis, Abnahme nach Pflichtenheft. Welches Modell passt?',
    schritte: [
      'Anforderungen: vollständig im Leistungsverzeichnis → spricht für Wasserfall',
      'Vertrag: Ausschreibung mit Festpreis und festem Umfang → Wasserfall',
      'Technik: bekannt, wenig Unsicherheit → Wasserfall',
      'Abnahme gegen ein Pflichtenheft, Dokumentationspflicht der Behörde → Wasserfall',
    ],
    ergebnis: 'Wasserfall: Stabile Anforderungen und fester Vertragsrahmen.',
  ),
  konzept(
    'n-va-8',
    'v-auswahl',
    'Mischformen in der Praxis',
    'Viele Unternehmen kombinieren beide Welten: Rahmen, Budget und Meilensteine werden klassisch geplant, die Softwareentwicklung darin läuft in Sprints. Man spricht von hybriden Vorgehensweisen. In der Prüfung geht es meist um eine begründete Wahl zwischen den beiden Modellen.',
  ),
  falle(
    'n-va-9',
    'v-auswahl',
    'Agil heißt nicht planlos',
    'Scrum plant ständig, nur kurzfristiger und in festen Zyklen: im Sprint Planning, täglich im Daily Scrum und laufend im Product Backlog. Auch Dokumentation gibt es, sie entsteht nur nicht vollständig im Voraus.',
  ),
  falle(
    'n-va-10',
    'v-auswahl',
    'Agil ist nicht automatisch schneller',
    'Scrum liefert früher nutzbare Teilergebnisse und senkt das Risiko, am Bedarf vorbeizuentwickeln. Das Gesamtprojekt wird dadurch aber nicht automatisch kürzer oder billiger. „Scrum, weil es schneller ist“ ist als Begründung falsch.',
  ),
  merke(
    'n-va-11',
    'v-auswahl',
    'Merksatz',
    'Die Anforderungen entscheiden.',
    satz:
        'Stabile Anforderungen und fester Vertrag: Wasserfall. Unklare oder sich ändernde Anforderungen und ein verfügbarer Kunde: Scrum.',
  ),

  // ============================================================ Agiles Manifest
  konzept(
    'n-sm-1',
    's-manifest',
    'Woher „agil“ kommt',
    '2001 formulierten 17 Softwareentwickler das Manifest für agile Softwareentwicklung, als Antwort auf schwerfällige, dokumentlastige Prozesse, in denen Kunden oft monatelang nichts Funktionierendes sahen. Es besteht aus vier Werten und zwölf Prinzipien.',
  ),
  vergleich(
    'n-sm-2',
    's-manifest',
    'Die vier Werte',
    'Jeder Wert stellt zwei Dinge gegenüber. Die linke Seite wird höher geschätzt als die rechte.',
    [
      ['Wichtiger ist ...', '... als'],
      ['Individuen und Interaktionen', 'Prozesse und Werkzeuge'],
      ['Funktionierende Software', 'umfassende Dokumentation'],
      ['Zusammenarbeit mit dem Kunden', 'Vertragsverhandlung'],
      ['Reagieren auf Veränderung', 'Befolgen eines Plans'],
    ],
  ),
  falle(
    'n-sm-3',
    's-manifest',
    'Rechts ist nicht wertlos',
    'Das Manifest sagt ausdrücklich: Die Werte rechts sind wichtig, die links aber wichtiger. Wer daraus ableitet, agile Teams bräuchten keine Dokumentation, keinen Vertrag oder keinen Plan, liegt falsch.',
  ),
  vergleich(
    'n-sm-4',
    's-manifest',
    'Was die Werte im Alltag bedeuten',
    'Die Werte werden erst greifbar, wenn man sie in konkretes Verhalten übersetzt.',
    [
      ['Wert', 'Im Projektalltag'],
      [
        'Individuen und Interaktionen',
        'kurz miteinander sprechen statt Tickets hin- und herschieben',
      ],
      [
        'Funktionierende Software',
        'Fortschritt am lauffähigen Ergebnis zeigen, nicht an Dokumenten',
      ],
      [
        'Zusammenarbeit mit dem Kunden',
        'Kunde gibt regelmäßig Rückmeldung zum Stand',
      ],
      [
        'Reagieren auf Veränderung',
        'neue Erkenntnisse aufnehmen und neu priorisieren',
      ],
    ],
  ),
  konzept(
    'n-sm-5',
    's-manifest',
    'Die zwölf Prinzipien (1 bis 6)',
    'Hinter den Werten stehen zwölf Prinzipien. Hier die ersten sechs, sinngemäß zusammengefasst.',
    points: [
      '1. Kunden durch frühe und kontinuierliche Auslieferung wertvoller Software zufriedenstellen',
      '2. Änderungen der Anforderungen sind willkommen, auch spät in der Entwicklung',
      '3. Funktionierende Software regelmäßig liefern, alle paar Wochen oder Monate, je kürzer, desto besser',
      '4. Fachleute und Entwickler arbeiten während des Projekts täglich zusammen',
      '5. Projekte um motivierte Menschen aufbauen und ihnen Umfeld, Unterstützung und Vertrauen geben',
      '6. Das Gespräch von Angesicht zu Angesicht ist die wirksamste Form der Kommunikation',
    ],
  ),
  konzept(
    'n-sm-6',
    's-manifest',
    'Die zwölf Prinzipien (7 bis 12)',
    'Die zweite Hälfte der Prinzipien betont Qualität, Einfachheit und ständige Verbesserung.',
    points: [
      '7. Funktionierende Software ist das wichtigste Fortschrittsmaß',
      '8. Nachhaltiges Tempo: Alle Beteiligten sollen ein gleichmäßiges Tempo dauerhaft halten können',
      '9. Ständiges Augenmerk auf technische Exzellenz und gutes Design',
      '10. Einfachheit: möglichst viel Arbeit vermeiden, die nicht nötig ist',
      '11. Die besten Architekturen, Anforderungen und Entwürfe entstehen in selbstorganisierten Teams',
      '12. Das Team reflektiert regelmäßig, wie es wirksamer werden kann, und passt sein Verhalten an',
    ],
  ),
  vergleich(
    'n-sm-7',
    's-manifest',
    'Prinzipien in Scrum wiederfinden',
    'Scrum setzt viele Prinzipien direkt in feste Bestandteile um. Diese Verbindung wird gern abgefragt.',
    [
      ['Prinzip', 'Umsetzung in Scrum'],
      ['häufig liefern', 'nutzbares Increment in jedem Sprint'],
      ['Änderungen willkommen', 'Product Backlog wird laufend neu geordnet'],
      ['täglich zusammenarbeiten', 'Daily Scrum, Product Owner eng am Team'],
      ['Software als Fortschrittsmaß', 'Sprint Review am Increment'],
      ['selbstorganisierte Teams', 'Developers planen den Sprint selbst'],
      ['reflektieren und anpassen', 'Sprint Retrospective'],
    ],
  ),
  beispiel(
    'n-sm-8',
    's-manifest',
    'Vorschläge am Manifest prüfen',
    'Ein Teamleiter schlägt vor: (1) Wir liefern erst nach einem Jahr, dann aber komplett. (2) Wir sprechen täglich 15 Minuten miteinander. (3) Wir schreiben keine Dokumentation mehr. (4) Nach jedem Sprint besprechen wir, was wir besser machen können. Welche Vorschläge sind im Sinne des Manifests?',
    schritte: [
      '(1) widerspricht den Prinzipien 1 und 3: früh und regelmäßig liefern',
      '(2) passt: direkte Zusammenarbeit und Gespräch (Prinzipien 4 und 6)',
      '(3) widerspricht dem Manifest: Dokumentation bleibt wertvoll, sie ist nur nachrangig',
      '(4) passt: regelmäßig reflektieren und anpassen (Prinzip 12)',
    ],
    ergebnis: 'Im Sinne des Manifests sind die Vorschläge 2 und 4.',
  ),
  falle(
    'n-sm-9',
    's-manifest',
    'Agil ist keine Methode',
    'Das Manifest beschreibt Werte und Prinzipien, aber kein konkretes Vorgehen. Scrum ist ein Rahmenwerk, das diese Werte umsetzt. „Agil“ und „Scrum“ sind also nicht dasselbe.',
  ),
  merke(
    'n-sm-10',
    's-manifest',
    'Merksatz',
    'Die kürzeste Form des Manifests.',
    satz:
        'Links vor rechts, nicht links statt rechts. Vier Werte, zwölf Prinzipien, im Zentrum: früh liefern, eng zusammenarbeiten, auf Veränderung reagieren.',
  ),

  // ============================================ Die drei Verantwortlichkeiten
  konzept(
    'n-sr-1',
    's-rollen',
    'Scrum auf einen Blick',
    'Scrum ist ein leichtgewichtiges Rahmenwerk, mit dem Teams komplexe Produkte in kurzen Zyklen entwickeln. Maßgeblich ist der Scrum Guide 2020 von Ken Schwaber und Jeff Sutherland.',
    points: [
      '3 Verantwortlichkeiten: Product Owner, Scrum Master, Developers',
      '5 Events: Sprint, Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective',
      '3 Artefakte mit je einem Commitment: Product Backlog, Sprint Backlog, Increment',
    ],
  ),
  vergleich(
    'n-sr-2',
    's-rollen',
    'Empirie: die drei Säulen',
    'Scrum beruht auf Empirie: Wissen entsteht aus Erfahrung, entschieden wird auf Grundlage dessen, was man beobachtet. Drei Säulen tragen dieses Vorgehen.',
    [
      ['Säule', 'Bedeutung', 'Beispiel'],
      [
        'Transparenz',
        'Arbeit und Fortschritt sind für alle sichtbar',
        'Backlogs, Definition of Done',
      ],
      [
        'Überprüfung',
        'Ergebnisse werden regelmäßig geprüft',
        'Daily Scrum, Sprint Review',
      ],
      [
        'Anpassung',
        'bei Abweichungen wird sofort nachgesteuert',
        'Retrospektive, neu geordnetes Backlog',
      ],
    ],
  ),
  vergleich(
    'n-sr-3',
    's-rollen',
    'Die fünf Scrum-Werte',
    'Damit die Säulen funktionieren, lebt das Scrum Team fünf Werte.',
    [
      ['Wert', 'Bedeutung'],
      ['Commitment', 'sich dem Ziel verpflichten und einander unterstützen'],
      ['Fokus', 'sich auf die Arbeit des Sprints konzentrieren'],
      ['Offenheit', 'Arbeit und Probleme offen ansprechen'],
      ['Respekt', 'einander als fähige, eigenständige Menschen achten'],
      ['Mut', 'das Richtige tun und schwierige Probleme angehen'],
    ],
  ),
  konzept(
    'n-sr-4',
    's-rollen',
    'Das Scrum Team',
    'Ein Scrum Team besteht aus genau einem Product Owner, einem Scrum Master und mehreren Developers. Der Scrum Guide spricht bewusst von Verantwortlichkeiten statt von Rollen.',
    points: [
      'Klein: in der Regel 10 Personen oder weniger',
      'Interdisziplinär: hat alle Fähigkeiten, um in jedem Sprint Wert zu schaffen',
      'Selbstmanagend: entscheidet selbst, wer was wann und wie tut',
      'Keine Unterteams und keine Hierarchien',
    ],
  ),
  vergleich(
    'n-sr-5',
    's-rollen',
    'Wer ist wofür verantwortlich?',
    'Jede Verantwortlichkeit hat einen klaren Schwerpunkt. Diese Tabelle ist die Grundlage aller Zuordnungsaufgaben.',
    [
      ['Verantwortlichkeit', 'Verantwortlich für'],
      [
        'Product Owner',
        'den Wert des Produkts; formuliert das Produktziel, pflegt und ordnet das Product Backlog',
      ],
      [
        'Scrum Master',
        'die Wirksamkeit des Scrum Teams; coacht, beseitigt Hindernisse, sorgt für gelebtes Scrum',
      ],
      [
        'Developers',
        'in jedem Sprint ein nutzbares Increment; erstellen den Plan für den Sprint (Sprint Backlog)',
      ],
    ],
  ),
  konzept(
    'n-sr-6',
    's-rollen',
    'Der Product Owner',
    'Der Product Owner ist eine einzelne Person, kein Gremium. Andere dürfen Wünsche äußern. Über die Reihenfolge im Product Backlog entscheidet aber allein er, und die Organisation muss diese Entscheidungen respektieren.',
    points: [
      'Entwickelt das Produktziel und kommuniziert es',
      'Erstellt Product Backlog Items und formuliert sie verständlich',
      'Ordnet das Product Backlog nach Wert',
      'Sorgt dafür, dass das Product Backlog transparent und verstanden ist',
      'Kann Arbeit delegieren, bleibt aber verantwortlich',
    ],
  ),
  konzept(
    'n-sr-7',
    's-rollen',
    'Der Scrum Master',
    'Der Scrum Master sorgt dafür, dass Scrum so gelebt wird, wie es im Scrum Guide steht. Er ist eine Führungskraft, die dient: er hilft anderen, statt Anweisungen zu geben.',
    points: [
      'Für das Team: coacht Selbstmanagement, beseitigt Hindernisse, sorgt für produktive Events innerhalb der Timebox',
      'Für den Product Owner: hilft mit Techniken für Produktziel und Backlog-Pflege',
      'Für die Organisation: führt Scrum ein, baut Hürden zwischen Stakeholdern und Team ab',
    ],
  ),
  konzept(
    'n-sr-8',
    's-rollen',
    'Die Developers',
    'Developers sind alle, die im Sprint am Increment arbeiten, nicht nur Programmierer, sondern zum Beispiel auch Tester, Designer oder Administratoren.',
    points: [
      'Erstellen den Plan für den Sprint, das Sprint Backlog',
      'Sichern die Qualität, indem sie die Definition of Done einhalten',
      'Passen ihren Plan täglich an das Sprintziel an',
      'Halten sich gegenseitig als Fachleute für ihre Arbeit verantwortlich',
    ],
  ),
  vergleich(
    'n-sr-9',
    's-rollen',
    'Klassische Rollen und Scrum',
    'Eine Projektleitung gibt es in Scrum nicht. Ihre Aufgaben verteilen sich auf das ganze Scrum Team.',
    [
      ['Aufgabe', 'klassisch', 'Scrum'],
      [
        'Anforderungen priorisieren',
        'Auftraggeber, Projektleitung',
        'Product Owner',
      ],
      ['Arbeit einteilen', 'Projektleitung', 'Developers selbst'],
      ['Hindernisse beseitigen', 'Projektleitung', 'Scrum Master'],
      ['Fortschritt zeigen', 'Statusbericht', 'Sprint Review am Increment'],
    ],
  ),
  beispiel(
    'n-sr-10',
    's-rollen',
    'Wer ist zuständig?',
    'Mitten im Sprint passiert Folgendes: (1) Der Vertrieb will eine neue Funktion sofort umgesetzt haben. (2) Der Testserver ist seit zwei Tagen gesperrt, das Team kommt nicht weiter. (3) Eine Aufgabe ist größer als gedacht, der Plan muss sich ändern.',
    schritte: [
      '(1) Product Owner: nimmt den Wunsch auf und ordnet ihn ins Product Backlog ein. Der laufende Sprint bleibt geschützt.',
      '(2) Scrum Master: kümmert sich um das Hindernis, weil das Team es nicht selbst lösen kann.',
      '(3) Developers: passen das Sprint Backlog selbst an; das Sprintziel bleibt bestehen.',
    ],
    ergebnis:
        'Product Owner: Inhalt und Reihenfolge · Scrum Master: Hindernisse · Developers: Umsetzung und Plan',
  ),
  falle(
    'n-sr-11',
    's-rollen',
    'Der Scrum Master ist kein Projektleiter',
    'Der Scrum Master verteilt keine Aufgaben, priorisiert nichts und entscheidet nicht über Inhalte. Er hilft dem Team, besser zu werden, und räumt Hindernisse aus dem Weg. Die Arbeit selbst organisieren die Developers.',
  ),
  merke(
    'n-sr-12',
    's-rollen',
    'Merksatz',
    'Drei Verantwortlichkeiten, drei Fragen.',
    satz:
        'Product Owner: WAS und WARUM. Developers: WIE und WIE VIEL. Scrum Master: DASS es funktioniert.',
  ),

  // ================================================ Artefakte und Commitments
  konzept(
    'n-sa-1',
    's-artefakte',
    'Drei Artefakte',
    'Artefakte machen Arbeit und Wert sichtbar, also sie sorgen für Transparenz. Zu jedem Artefakt gehört ein Commitment, an dem sich der Fortschritt messen lässt.',
  ),
  vergleich(
    'n-sa-2',
    's-artefakte',
    'Artefakt und Commitment',
    'Diese Zuordnung wird sehr häufig abgefragt.',
    [
      ['Artefakt', 'Inhalt', 'Commitment'],
      [
        'Product Backlog',
        'geordnete Liste von allem, was das Produkt braucht',
        'Produktziel',
      ],
      [
        'Sprint Backlog',
        'Sprintziel, ausgewählte Einträge und Plan für den Sprint',
        'Sprintziel',
      ],
      ['Increment', 'nutzbares, geprüftes Ergebnis', 'Definition of Done'],
    ],
  ),
  konzept(
    'n-sa-3',
    's-artefakte',
    'Das Product Backlog',
    'Das Product Backlog ist eine geordnete, sich ständig weiterentwickelnde Liste dessen, was für das Produkt gebraucht wird. Es ist die einzige Quelle für die Arbeit des Scrum Teams.',
    points: [
      'Einträge heißen Product Backlog Items, oft als User Stories formuliert',
      'Oben: kleine, detaillierte Einträge, bereit für den nächsten Sprint',
      'Unten: grobe, große Einträge wie Epics',
      'Verantwortlich: Product Owner',
      'Commitment: Produktziel: der langfristige Zielzustand des Produkts',
    ],
  ),
  konzept(
    'n-sa-4',
    's-artefakte',
    'Product Backlog Refinement',
    'Refinement heißt, Einträge zu zerlegen, zu präzisieren und zu schätzen, bis sie in einen Sprint passen. Es ist kein eigenes Event, sondern eine laufende Tätigkeit.',
    points: [
      'Der Product Owner erklärt die Einträge und ordnet sie.',
      'Die Developers, die die Arbeit erledigen, schätzen die Größe.',
      'Ziel: Oben im Backlog liegen genug Einträge, die für das nächste Sprint Planning bereit sind.',
    ],
  ),
  konzept(
    'n-sa-5',
    's-artefakte',
    'Das Sprint Backlog',
    'Das Sprint Backlog besteht aus drei Teilen: dem Sprintziel (warum), den ausgewählten Product Backlog Items (was) und dem Plan, wie sie umgesetzt werden (wie). Es gehört den Developers.',
    points: [
      'Es wird im Sprint laufend aktualisiert: Der Plan darf sich ändern.',
      'Das Sprintziel bleibt fest und gibt dem Sprint seine Richtung.',
      'Stellt sich Arbeit als anders heraus, klären die Developers den Umfang mit dem Product Owner, ohne das Sprintziel aufzugeben.',
    ],
  ),
  konzept(
    'n-sa-6',
    's-artefakte',
    'Das Increment',
    'Ein Increment ist ein konkreter Schritt zum Produktziel. Es baut auf allen vorherigen Increments auf, ist geprüft und nutzbar.',
    points: [
      'Sobald ein Eintrag die Definition of Done erfüllt, entsteht ein Increment.',
      'In einem Sprint können mehrere Increments entstehen.',
      'Ausgeliefert werden darf auch schon vor dem Sprint Review. Das Review ist kein Freigabetor.',
      'Commitment: Definition of Done',
    ],
  ),
  skizze(
    'n-sa-7',
    's-artefakte',
    'Vom Backlog zum Increment',
    'Die Artefakte bilden eine Kette, die sich in jedem Sprint wiederholt. Die Rückmeldungen aus dem Review fließen zurück ins Product Backlog.',
    const FlussDiagramm(
      [
        FlussKnoten(
          'Product Backlog',
          form: FlussForm.dokument,
          pfeil: 'Sprint Planning',
        ),
        FlussKnoten(
          'Sprint Backlog',
          form: FlussForm.dokument,
          pfeil: 'Sprint mit Daily Scrum',
        ),
        FlussKnoten(
          'Increment',
          form: FlussForm.dokument,
          pfeil: 'Sprint Review',
        ),
        FlussKnoten('Feedback der Stakeholder'),
      ],
      zyklus: true,
      zyklusLabel: 'ins Product Backlog',
    ),
  ),
  konzept(
    'n-sa-8',
    's-artefakte',
    'Die Definition of Done',
    'Die Definition of Done (DoD) beschreibt, welche Qualität ein Eintrag haben muss, damit er als fertig gilt. Sie gilt für alle Einträge gleichermaßen. Gibt die Organisation eine DoD vor, ist sie der Mindeststandard; sonst legt das Scrum Team eine eigene fest.',
    points: [
      'Beispiel: Code von einer zweiten Person geprüft',
      'Beispiel: automatische Tests geschrieben und bestanden',
      'Beispiel: Akzeptanzkriterien erfüllt',
      'Beispiel: Dokumentation aktualisiert, auf der Testumgebung installiert',
    ],
  ),
  vergleich(
    'n-sa-9',
    's-artefakte',
    'Definition of Done oder Akzeptanzkriterien?',
    'Die beiden Begriffe werden sehr oft verwechselt. Fertig ist ein Eintrag erst, wenn beides erfüllt ist.',
    [
      ['', 'Definition of Done', 'Akzeptanzkriterien'],
      ['gilt für', 'alle Einträge', 'eine einzelne User Story'],
      [
        'beschreibt',
        'handwerkliche Qualität',
        'fachlich gewünschtes Verhalten',
      ],
      ['legt fest', 'Scrum Team', 'Product Owner mit dem Team'],
      [
        'Beispiel',
        'Code-Review erfolgt, Tests grün',
        'Sendungsnummer wird angezeigt',
      ],
    ],
  ),
  falle(
    'n-sa-10',
    's-artefakte',
    'Fast fertig ist nicht fertig',
    'Erfüllt ein Eintrag am Sprintende die Definition of Done nicht, gehört er nicht zum Increment. Er wird im Review nicht als fertig vorgestellt, zählt nicht zur Velocity und geht zurück ins Product Backlog.',
  ),
  merke(
    'n-sa-11',
    's-artefakte',
    'Vom Wunsch zum Ergebnis',
    'Die Artefakte bilden eine Kette, und jedes hat sein Ziel.',
    satz:
        'Product Backlog → Produktziel, Sprint Backlog → Sprintziel, Increment → Definition of Done: vom Wunsch über den Plan zum nutzbaren Ergebnis.',
  ),

  // ============================================================= Scrum-Events
  konzept(
    'n-se-1',
    's-events',
    'Der Sprint',
    'Der Sprint ist der Rahmen für alle anderen Events. Er hat eine feste Länge von höchstens einem Monat; der nächste Sprint beginnt direkt nach dem Ende des vorherigen.',
    points: [
      'Keine Änderungen, die das Sprintziel gefährden',
      'Die Qualität wird nicht verringert.',
      'Das Product Backlog wird bei Bedarf verfeinert.',
      'Abbrechen darf nur der Product Owner, und zwar wenn das Sprintziel hinfällig geworden ist.',
    ],
  ),
  skizze(
    'n-se-2',
    's-events',
    'Der Scrum-Zyklus',
    'Ein Sprint läuft immer gleich ab. Nach der Retrospektive beginnt sofort der nächste Sprint mit dem nächsten Sprint Planning.',
    const FlussDiagramm(
      [
        FlussKnoten('Product Backlog', form: FlussForm.dokument),
        FlussKnoten('Sprint Planning', pfeil: 'Sprint Backlog'),
        FlussKnoten('Daily Scrum', seitlich: 'jeden Tag, 15 Minuten'),
        FlussKnoten('Sprint Review', pfeil: 'Increment geprüft'),
        FlussKnoten('Sprint Retrospective'),
      ],
      zyklus: true,
      zyklusLabel: 'nächster Sprint',
    ),
  ),
  vergleich(
    'n-se-3',
    's-events',
    'Die fünf Events im Überblick',
    'Jedes Event ist eine Gelegenheit, etwas zu überprüfen und anzupassen.',
    [
      ['Event', 'Zweck', 'Teilnehmende'],
      ['Sprint', 'Rahmen; erzeugt nutzbare Increments', 'Scrum Team'],
      [
        'Sprint Planning',
        'Warum, Was und Wie des Sprints festlegen',
        'Scrum Team, ggf. Gäste',
      ],
      [
        'Daily Scrum',
        'Fortschritt zum Sprintziel prüfen, Plan anpassen',
        'Developers',
      ],
      [
        'Sprint Review',
        'Ergebnis prüfen, nächste Schritte beraten',
        'Scrum Team und Stakeholder',
      ],
      [
        'Sprint Retrospective',
        'Zusammenarbeit und Qualität verbessern',
        'Scrum Team',
      ],
    ],
  ),
  ablauf(
    'n-se-4',
    's-events',
    'Sprint Planning: drei Themen',
    'Das Sprint Planning beantwortet drei Fragen. Das Ergebnis ist das Sprint Backlog.',
    [
      'Warum ist dieser Sprint wertvoll? Der Product Owner zeigt, wie das Produkt gewinnen kann; das Scrum Team formuliert das Sprintziel.',
      'Was kann erledigt werden? Die Developers wählen Einträge aus dem Product Backlog, anhand ihrer bisherigen Leistung, ihrer Kapazität und der Definition of Done.',
      'Wie wird die Arbeit erledigt? Die Developers zerlegen die Einträge in Aufgaben, oft von einem Tag oder weniger.',
    ],
  ),
  konzept(
    'n-se-5',
    's-events',
    'Das Daily Scrum',
    'Ein 15-minütiges Event für die Developers, jeden Arbeitstag zur gleichen Zeit am gleichen Ort. Sie prüfen den Fortschritt zum Sprintziel und passen den Plan für die nächsten 24 Stunden an.',
    points: [
      'Die Struktur wählen die Developers selbst. Die früher üblichen drei Fragen (gestern, heute, Hindernisse) sind nicht mehr vorgeschrieben.',
      'Product Owner und Scrum Master nehmen als Developers teil, wenn sie selbst an Einträgen arbeiten.',
      'Ausführliche Diskussionen finden im Anschluss statt.',
    ],
  ),
  konzept(
    'n-se-6',
    's-events',
    'Das Sprint Review',
    'Das Scrum Team zeigt den wichtigsten Stakeholdern das Ergebnis des Sprints und bespricht den Fortschritt zum Produktziel. Es ist eine Arbeitssitzung, keine reine Präsentation.',
    points: [
      'Stakeholder geben Rückmeldung zum Increment.',
      'Gemeinsam wird beraten, was als Nächstes sinnvoll ist.',
      'Ergebnis: ein angepasstes Product Backlog',
    ],
  ),
  konzept(
    'n-se-7',
    's-events',
    'Die Sprint Retrospective',
    'Das Scrum Team prüft, wie der letzte Sprint gelaufen ist (Personen, Zusammenarbeit, Prozesse, Werkzeuge und die Definition of Done) und legt Verbesserungen fest. Sie beendet den Sprint.',
    points: [
      'Was lief gut, welche Probleme gab es, wie wurden sie gelöst?',
      'Die wirksamsten Verbesserungen werden möglichst schnell umgesetzt, auch schon im nächsten Sprint.',
    ],
  ),
  vergleich(
    'n-se-8',
    's-events',
    'Die Timeboxen',
    'Jedes Event hat eine Höchstdauer (Timebox). Der Scrum Guide nennt Werte für einen Monatssprint; bei kürzeren Sprints sind die Events meist kürzer. Üblich ist, anteilig umzurechnen. Das Daily bleibt immer bei 15 Minuten.',
    [
      ['Event', 'Monatssprint (max.)', '2-Wochen-Sprint (üblich)'],
      ['Sprint', '1 Monat', '2 Wochen'],
      ['Sprint Planning', '8 Stunden', '4 Stunden'],
      ['Daily Scrum', '15 Minuten', '15 Minuten'],
      ['Sprint Review', '4 Stunden', '2 Stunden'],
      ['Sprint Retrospective', '3 Stunden', '1,5 Stunden'],
    ],
    merksatz:
        'Merkhilfe für den Monatssprint: 8 - 4 - 3, und das Daily bleibt 15.',
  ),
  beispiel(
    'n-se-9',
    's-events',
    'Timeboxen umrechnen',
    'Ein Team arbeitet in 3-Wochen-Sprints. Wie lange dürfen Planning, Review und Retrospektive bei anteiliger Umrechnung höchstens dauern? Rechne mit 1 Monat = 4 Wochen.',
    schritte: [
      'Anteil am Monatssprint: 3 Wochen / 4 Wochen = 0,75',
      'Sprint Planning: 8 h × 0,75 = 6 h',
      'Sprint Review: 4 h × 0,75 = 3 h',
      'Sprint Retrospective: 3 h × 0,75 = 2,25 h = 2 h 15 min',
      'Daily Scrum: bleibt 15 Minuten',
    ],
    ergebnis:
        'Planning 6 h, Review 3 h, Retrospektive 2 h 15 min, Daily 15 min',
  ),
  falle(
    'n-se-10',
    's-events',
    'Das Daily ist kein Statusbericht',
    'Im Daily Scrum berichten die Developers nicht an eine Führungskraft. Sie prüfen gemeinsam den Fortschritt zum Sprintziel und planen die nächsten 24 Stunden. Wer nur zuhört, hält sich zurück.',
  ),
  falle(
    'n-se-11',
    's-events',
    'Refinement ist kein Event',
    'Viele zählen das Product Backlog Refinement zu den Events. Es ist aber eine laufende Tätigkeit ohne feste Timebox. Die fünf Events sind: Sprint, Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective.',
  ),
  merke(
    'n-se-12',
    's-events',
    'Review oder Retro?',
    'Der häufigste Fehler bei den Events ist die Verwechslung der beiden letzten.',
    satz:
        'Die Review schaut aufs Produkt, mit Stakeholdern. Die Retro schaut aufs Team, nur das Scrum Team. Erst Review, dann Retro.',
  ),

  // ============================================= User Stories und Schätzung
  konzept(
    'n-st-1',
    's-stories',
    'Die User Story',
    'Eine User Story beschreibt eine Anforderung aus Sicht der Nutzer, kurz, verständlich und mit einem erkennbaren Nutzen. Sie ist die häufigste Form eines Product Backlog Items.',
    points: ['Als <Rolle> möchte ich <Ziel>, damit <Nutzen>.'],
    merksatz:
        'Als Kundin möchte ich meine Bestellung verfolgen, damit ich weiß, wann das Paket kommt.',
  ),
  vergleich(
    'n-st-2',
    's-stories',
    'Die drei Teile einer Story',
    'Jeder Teil beantwortet eine eigene Frage. Fehlt der Nutzen, weiß niemand, warum die Story wichtig ist.',
    [
      ['Teil', 'Frage', 'Beispiel'],
      ['Rolle', 'Wer?', 'Als Kundin'],
      ['Ziel', 'Was?', 'möchte ich meine Bestellung verfolgen,'],
      ['Nutzen', 'Warum?', 'damit ich weiß, wann das Paket kommt.'],
    ],
  ),
  konzept(
    'n-st-3',
    's-stories',
    'Card, Conversation, Confirmation',
    'Eine User Story ist kein vollständiges Pflichtenheft. Nach Ron Jeffries besteht sie aus drei Teilen, den „3 C“.',
    points: [
      'Card: kurze Beschreibung, die auf eine Karteikarte passt',
      'Conversation: Details entstehen im Gespräch zwischen Product Owner und Team',
      'Confirmation: Akzeptanzkriterien bestätigen, wann die Story erfüllt ist',
    ],
  ),
  konzept(
    'n-st-4',
    's-stories',
    'Akzeptanzkriterien',
    'Akzeptanzkriterien machen eine Story prüfbar. Sie beschreiben, unter welchen Bedingungen die Story als erfüllt gilt. Verbreitet ist die Form „Gegeben ... wenn ... dann ...“.',
    points: [
      'Die Sendungsnummer wird auf der Bestellseite angezeigt.',
      'Ein Klick darauf öffnet die Sendungsverfolgung.',
      'Gegeben eine noch nicht versendete Bestellung, wenn ich die Bestellseite öffne, dann sehe ich den Hinweis „Noch nicht versendet“.',
    ],
  ),
  vergleich(
    'n-st-5',
    's-stories',
    'INVEST: Merkmale guter Stories',
    'Gute User Stories erfüllen sechs Kriterien. Die Anfangsbuchstaben ergeben INVEST.',
    [
      ['Kriterium', 'Bedeutung'],
      ['Independent', 'unabhängig von anderen Stories umsetzbar'],
      ['Negotiable', 'verhandelbar, kein starrer Vertrag'],
      ['Valuable', 'bringt Nutzern oder Kunden einen Wert'],
      ['Estimable', 'lässt sich schätzen'],
      ['Small', 'klein genug für einen Sprint'],
      ['Testable', 'prüfbar über Akzeptanzkriterien'],
    ],
  ),
  skizze(
    'n-st-6',
    's-stories',
    'Epic, Story, Aufgabe',
    'Ist eine Story zu groß für einen Sprint, heißt sie Epic und wird im Refinement in kleinere Stories zerlegt. Im Sprint Planning zerlegen die Developers die Stories weiter in Aufgaben (Tasks).',
    const BaumDiagramm(
      BaumKnoten('Online-Bestellung', [
        BaumKnoten('Artikel suchen', [
          BaumKnoten('Suchfeld bauen', [], 'Task'),
          BaumKnoten('Suche testen', [], 'Task'),
        ], 'Story'),
        BaumKnoten('Warenkorb füllen', [], 'Story'),
        BaumKnoten('Bezahlen', [], 'Story'),
      ], 'Epic'),
    ),
  ),
  konzept(
    'n-st-7',
    's-stories',
    'Relativ schätzen mit Story Points',
    'Agile Teams schätzen meist nicht in Stunden, sondern relativ in Story Points: Wie groß ist diese Story im Vergleich zu einer bekannten Referenz-Story? Vergleichen gelingt Menschen zuverlässiger, als absolute Zeiten zu schätzen.',
    points: [
      'Story Points fassen Umfang, Komplexität und Unsicherheit zusammen.',
      'Übliche Werte: angepasste Fibonacci-Folge 1, 2, 3, 5, 8, 13, 20, 40, 100',
      'Die wachsenden Abstände zeigen: Große Stories sind unsicherer.',
      'Alternative: T-Shirt-Größen S, M, L, XL',
    ],
  ),
  ablauf(
    'n-st-8',
    's-stories',
    'Planning Poker',
    'Beim Planning Poker schätzt das ganze Team gemeinsam. Das gleichzeitige Aufdecken verhindert, dass sich alle am ersten genannten Wert orientieren (Ankereffekt).',
    [
      'Der Product Owner stellt eine Story vor, Fragen werden geklärt.',
      'Jede Person wählt verdeckt eine Karte mit ihrer Schätzung.',
      'Alle decken gleichzeitig auf.',
      'Wer am höchsten und wer am niedrigsten geschätzt hat, begründet seinen Wert.',
      'Erneut schätzen, bis sich das Team auf einen Wert einigt.',
    ],
  ),
  formel(
    'n-st-9',
    's-stories',
    'Prognose mit der Velocity',
    'Die Velocity ist die Menge an Story Points, die ein Team pro Sprint tatsächlich fertigstellt. Mit ihr lässt sich abschätzen, wie viele Sprints der Rest dauert.',
    'Velocity = Summe fertiger Story Points / Anzahl Sprints\n'
        'Restliche Sprints = offene Story Points / Velocity\n'
        '                    (immer aufrunden)',
    points: [
      'Nur Einträge, die die Definition of Done erfüllen, zählen.',
      'Aufgerundet wird, weil es keinen halben Sprint gibt.',
    ],
  ),
  beispiel(
    'n-st-10',
    's-stories',
    'Velocity und Restlaufzeit',
    'Ein Team hat in vier Sprints 21, 25, 18 und 24 Story Points fertiggestellt. Im Product Backlog liegen noch 150 Story Points. Ein Sprint dauert 2 Wochen. Wie lange dauert der Rest voraussichtlich?',
    schritte: [
      'Summe der fertigen Punkte: 21 + 25 + 18 + 24 = 88 SP',
      'Velocity: 88 SP / 4 Sprints = 22 SP je Sprint',
      'Restliche Sprints: 150 SP / 22 SP = 6,82 → aufrunden auf 7 Sprints',
      'Dauer: 7 Sprints × 2 Wochen = 14 Wochen',
    ],
    ergebnis: 'Voraussichtlich 7 Sprints, also 14 Wochen',
  ),
  skizze(
    'n-st-11',
    's-stories',
    'Das Burndown-Chart',
    'Ein Burndown-Chart zeigt, wie viel Arbeit im Sprint noch offen ist. Die Ideallinie fällt gleichmäßig von der geplanten Menge auf null. Liegen die Ist-Werte darüber, ist das Team hinter dem Plan.',
    const GeradenDiagramm(
      xAchse: 'Arbeitstag',
      yAchse: 'offene Story Points',
      xMax: 10,
      yMax: 40,
      geraden: [Gerade('Ideallinie', 40, -4)],
      punkte: [
        DiagrammPunkt(0, 40, 'Start'),
        DiagrammPunkt(5, 26, 'Ist Tag 5'),
        DiagrammPunkt(10, 4, 'Ist Tag 10'),
      ],
    ),
    points: [
      'Ideallinie: 40 SP in 10 Tagen → 4 SP pro Tag',
      'Tag 5: Soll 40 - 5 × 4 = 20 SP offen, Ist 26 SP → 6 SP Rückstand',
      'Tag 10: 4 SP sind nicht fertig. Sie gehen zurück ins Product Backlog.',
      'Das Burndown-Chart ist nicht im Scrum Guide vorgeschrieben, aber weit verbreitet.',
    ],
  ),
  falle(
    'n-st-12',
    's-stories',
    'Story Points sind keine Stunden',
    'Story Points drücken Umfang, Komplexität und Unsicherheit zusammen aus. Sie lassen sich nicht in Stunden umrechnen und sind nicht zwischen Teams vergleichbar. Die Velocity taugt deshalb auch nicht, um Teams zu bewerten.',
  ),
  merke(
    'n-st-13',
    's-stories',
    'Merksatz',
    'So hängen die Begriffe dieser Lektion zusammen.',
    satz:
        'Story = Rolle + Ziel + Nutzen, prüfbar durch Akzeptanzkriterien, relativ geschätzt in Story Points, geplant mit der Velocity (aufrunden!).',
  ),

  // ======================================================= Aufbau eines Netzplans
  konzept(
    'n-ng-1',
    'n-grundlagen',
    'Wozu ein Netzplan?',
    'Der Netzplan zeigt, welche Vorgänge voneinander abhängen. Aus ihm lassen sich die Projektdauer, die Pufferzeiten und der kritische Pfad berechnen. Das kann ein einfacher Balkenplan nicht.',
    points: [
      'Wie lange dauert das Projekt mindestens?',
      'Wann darf welcher Vorgang frühestens und spätestens beginnen?',
      'Welche Vorgänge dürfen sich auf keinen Fall verzögern?',
    ],
  ),
  vergleich(
    'n-ng-2',
    'n-grundlagen',
    'Die Vorgangsliste',
    'Grundlage jedes Netzplans ist eine Tabelle mit allen Vorgängen, ihrer Dauer und ihren direkten Vorgängern. Ein Vorgang ist eine Tätigkeit mit Anfang, Ende und Dauer.',
    [
      ['Nr.', 'Vorgang', 'Dauer', 'Vorgänger'],
      ['A', 'Analyse', '3 Tage', '-'],
      ['B', 'Konzept', '2 Tage', 'A'],
      ['C', 'Hardware', '4 Tage', 'A'],
      ['D', 'Test', '1 Tag', 'B, C'],
    ],
  ),
  skizze(
    'n-ng-3',
    'n-grundlagen',
    'Der Vorgangsknoten',
    'Im Vorgangsknotennetzplan ist jeder Vorgang ein Kasten mit festen Feldern. So ist er in dieser App aufgebaut:',
    const NetzplanLegende(),
    points: [
      'Oben: frühester Anfang (FAZ), Dauer (D), frühestes Ende (FEZ)',
      'Mitte: Nummer und Bezeichnung des Vorgangs',
      'Unten: spätester Anfang (SAZ), Gesamtpuffer (GP), spätestes Ende (SEZ)',
      'Den freien Puffer (FP) tragen viele Aufgaben in ein zusätzliches Feld ein.',
    ],
  ),
  vergleich(
    'n-ng-4',
    'n-grundlagen',
    'Die Werte im Knoten',
    'Jedes Feld hat eine feste Bedeutung. Die Berechnung lernst du in den folgenden Lektionen Schritt für Schritt.',
    [
      ['Kürzel', 'Bedeutung', 'Ermittlung'],
      ['D', 'Dauer', 'vorgegeben'],
      ['FAZ', 'frühester Anfangszeitpunkt', 'vorwärts'],
      ['FEZ', 'frühester Endzeitpunkt', 'FAZ + D'],
      ['SEZ', 'spätester Endzeitpunkt', 'rückwärts'],
      ['SAZ', 'spätester Anfangszeitpunkt', 'SEZ - D'],
      ['GP', 'Gesamtpuffer', 'SAZ - FAZ'],
      ['FP', 'freier Puffer', 'FAZ Nachfolger - FEZ'],
    ],
  ),
  skizze(
    'n-ng-5',
    'n-grundlagen',
    'Von der Liste zum Netzplan',
    'Aus der Vorgangsliste entsteht das Bild: Jeder Vorgang wird ein Knoten, jeder Eintrag in der Spalte „Vorgänger“ ein Pfeil vom Vorgänger zum Vorgang.',
    const NetzplanDiagramm(_npMini, mitWerten: false),
    points: [
      'A hat keinen Vorgänger → Startvorgang',
      'B und C folgen beide auf A → Verzweigung',
      'D wartet auf B und C → Zusammenführung',
      'D hat keinen Nachfolger → Endvorgang',
    ],
  ),
  konzept(
    'n-ng-6',
    'n-grundlagen',
    'Regeln für einen sauberen Netzplan',
    'Ein Netzplan lässt sich nur berechnen, wenn er ein paar Grundregeln einhält.',
    points: [
      'Pfeile laufen von links nach rechts und nie im Kreis, also keine Schleifen.',
      'Nur direkte Vorgänger eintragen: Folgt D auf B und B auf A, braucht D keinen Pfeil von A.',
      'Jeder Vorgang außer den Startvorgängen hat mindestens einen Vorgänger.',
      'Übersichtlich ist ein gemeinsamer Start- und ein gemeinsamer Endvorgang.',
    ],
  ),
  vergleich(
    'n-ng-7',
    'n-grundlagen',
    'Anordnungsbeziehungen',
    'Die Pfeile können unterschiedliche Abhängigkeiten bedeuten. In der AP1 ist fast immer die Normalfolge gemeint.',
    [
      ['Beziehung', 'Bedeutung'],
      [
        'Normalfolge (NF, Ende-Anfang)',
        'Nachfolger beginnt, wenn der Vorgänger beendet ist',
      ],
      [
        'Anfangsfolge (AF, Anfang-Anfang)',
        'Nachfolger beginnt frühestens mit dem Anfang des Vorgängers',
      ],
      [
        'Endfolge (EF, Ende-Ende)',
        'Nachfolger endet frühestens mit dem Ende des Vorgängers',
      ],
      [
        'Sprungfolge (SF, Anfang-Ende)',
        'Nachfolger endet frühestens mit dem Anfang des Vorgängers, selten',
      ],
    ],
  ),
  konzept(
    'n-ng-8',
    'n-grundlagen',
    'Zeitabstände',
    'Manchmal darf ein Nachfolger nicht sofort beginnen, etwa wegen einer Lieferzeit oder Wartezeit. Dann steht am Pfeil ein Zeitabstand, der zur Rechnung dazukommt.',
    points: [
      'Normalfolge mit Abstand: FAZ Nachfolger = FEZ Vorgänger + Abstand',
      'Beispiel: Bestellung endet an Tag 5, Lieferzeit 3 Tage → Einbau frühestens ab Tag 8',
    ],
  ),
  vergleich(
    'n-ng-9',
    'n-grundlagen',
    'Netzplan oder Gantt-Diagramm?',
    'Beide Techniken stellen Termine dar, haben aber unterschiedliche Stärken. In der Praxis wird mit dem Netzplan gerechnet und mit dem Gantt-Diagramm kommuniziert.',
    [
      ['', 'Netzplan', 'Gantt-Diagramm'],
      [
        'zeigt',
        'Abhängigkeiten, Puffer, kritischen Pfad',
        'Vorgänge als Balken auf der Zeitachse',
      ],
      ['Stärke', 'berechenbar', 'auf einen Blick lesbar'],
      [
        'Schwäche',
        'bei vielen Vorgängen unübersichtlich',
        'Abhängigkeiten schwer erkennbar',
      ],
    ],
  ),
  ablauf(
    'n-ng-10',
    'n-grundlagen',
    'So entsteht ein Netzplan',
    'Die Reihenfolge der Arbeitsschritte ist immer gleich.',
    [
      'Vorgänge mit ihrer Dauer auflisten',
      'Für jeden Vorgang die direkten Vorgänger festlegen',
      'Knoten anordnen und mit Pfeilen verbinden',
      'Vorwärtsrechnung: FAZ und FEZ',
      'Rückwärtsrechnung: SEZ und SAZ',
      'Puffer berechnen und kritischen Pfad markieren',
    ],
  ),
  falle(
    'n-ng-11',
    'n-grundlagen',
    'Vorgänger oder Nachfolger?',
    'Manche Aufgaben geben statt der Vorgänger die Nachfolger an. Dann zuerst umdrehen: Steht bei A „Nachfolger: B, C“, ist A der Vorgänger von B und von C.',
  ),
  falle(
    'n-ng-12',
    'n-grundlagen',
    'Erst die Legende lesen',
    'Wo im Kasten FAZ, SEZ oder GP stehen, ist nicht einheitlich geregelt. Jede Prüfungsaufgabe zeigt deshalb eine Legende. Wer aus Gewohnheit die Felder anders befüllt, verschenkt Punkte, auch wenn jede Zahl stimmt.',
  ),
  merke(
    'n-ng-13',
    'n-grundlagen',
    'Merksatz',
    'Jede Netzplanaufgabe folgt demselben Weg.',
    satz:
        'Vorgangsliste → Knoten und Pfeile → vorwärts (FAZ, FEZ) → rückwärts (SEZ, SAZ) → Puffer → kritischer Pfad.',
  ),

  // ============================================================ Vorwärtsrechnung
  konzept(
    'n-nv-1',
    'n-vorwaerts',
    'Was die Vorwärtsrechnung liefert',
    'Sie beantwortet die Frage: Wann kann jeder Vorgang frühestens beginnen und enden? Gerechnet wird vom Start- zum Endvorgang. Am Ende steht die kürzestmögliche Projektdauer.',
  ),
  formel(
    'n-nv-2',
    'n-vorwaerts',
    'Die Regeln',
    'Drei Regeln genügen. Gerechnet wird mit Zeitpunkten: FAZ 0 heißt „zu Beginn“, FEZ 3 heißt „nach dem 3. Tag“.',
    'FAZ = 0                         (Startvorgang)\n'
        'FAZ = max(FEZ aller Vorgänger)  (alle anderen)\n'
        'FEZ = FAZ + Dauer\n'
        'Projektdauer = größter FEZ',
  ),
  beispiel(
    'n-nv-3',
    'n-vorwaerts',
    'Ein kleines Beispiel Schritt für Schritt',
    'A (3 Tage) ist der Startvorgang. B (2 Tage) und C (4 Tage) folgen auf A. D (1 Tag) folgt auf B und C. Berechne FAZ und FEZ.',
    schritte: [
      'A: Startvorgang, FAZ = 0; FEZ = 0 + 3 = 3',
      'B: einziger Vorgänger A, FAZ = FEZ A = 3; FEZ = 3 + 2 = 5',
      'C: einziger Vorgänger A, FAZ = 3; FEZ = 3 + 4 = 7',
      'D: zwei Vorgänger, FAZ = max(FEZ B 5; FEZ C 7) = 7; FEZ = 7 + 1 = 8',
      'Größter FEZ = 8 → Projektdauer',
    ],
    ergebnis: 'Projektdauer 8 Tage',
    skizze: const NetzplanDiagramm(_npMini),
  ),
  falle(
    'n-nv-4',
    'n-vorwaerts',
    'Das Maximum am Zusammenfluss',
    'Hat ein Vorgang mehrere Vorgänger, kann er erst starten, wenn der LETZTE fertig ist. Wer bei D den kleineren Wert 5 nimmt, lässt D beginnen, obwohl C noch zwei Tage läuft.',
  ),
  beispiel(
    'n-nv-5',
    'n-vorwaerts',
    'Das Ticketsystem-Projekt vorwärts',
    'Für die Einführung eines Ticketsystems ist diese Vorgangsliste gegeben (Dauer in Arbeitstagen). Berechne FAZ, FEZ und die Projektdauer.',
    table: [
      ['Vorgang', 'Dauer', 'Vorgänger'],
      ['A Ist-Analyse', '2', '-'],
      ['B Konzept', '4', 'A'],
      ['C Hardware beschaffen', '6', 'A'],
      ['D Installation', '3', 'B'],
      ['E Schulung vorbereiten', '2', 'B'],
      ['F Systemtest', '4', 'C, D'],
      ['G Go-live mit Schulung', '2', 'E, F'],
    ],
    schritte: [
      'A: FAZ 0, FEZ 0 + 2 = 2',
      'B: FAZ = FEZ A = 2, FEZ 2 + 4 = 6',
      'C: FAZ = FEZ A = 2, FEZ 2 + 6 = 8',
      'D: FAZ = FEZ B = 6, FEZ 6 + 3 = 9',
      'E: FAZ = FEZ B = 6, FEZ 6 + 2 = 8',
      'F: FAZ = max(FEZ C 8; FEZ D 9) = 9, FEZ 9 + 4 = 13',
      'G: FAZ = max(FEZ E 8; FEZ F 13) = 13, FEZ 13 + 2 = 15',
    ],
    ergebnis: 'Projektdauer 15 Arbeitstage',
  ),
  skizze(
    'n-nv-6',
    'n-vorwaerts',
    'Der Ticketsystem-Netzplan',
    'So sieht der Plan mit allen Werten aus. Die oberen Felder stammen aus der Vorwärtsrechnung, die unteren füllt die Rückwärtsrechnung.',
    const NetzplanDiagramm(_npTicket),
    points: [
      'An den Zusammenführungen F und G entscheidet jeweils das Maximum.',
      'G endet bei 15: Das ist die Projektdauer.',
    ],
  ),
  konzept(
    'n-nv-7',
    'n-vorwaerts',
    'Mehrere Startvorgänge',
    'Haben mehrere Vorgänge keinen Vorgänger, dürfen alle sofort beginnen: Jeder bekommt FAZ 0. Entsprechend ist bei mehreren Endvorgängen der größte FEZ die Projektdauer.',
  ),
  vergleich(
    'n-nv-8',
    'n-vorwaerts',
    'Zählweise: ab 0 oder ab 1?',
    'Diese App und die meisten AP1-Aufgaben rechnen mit Zeitpunkten ab 0. Manche Aufgaben zählen Tage ab 1. Dann gelten angepasste Formeln. Die Projektdauer ist in beiden Fällen gleich.',
    [
      ['', 'ab 0 (Zeitpunkte)', 'ab 1 (Tagesnummern)'],
      ['FAZ Startvorgang', '0', '1'],
      ['FEZ', 'FAZ + D', 'FAZ + D - 1'],
      ['FAZ Nachfolger', 'FEZ Vorgänger', 'FEZ Vorgänger + 1'],
      ['A mit 3 Tagen', 'FAZ 0, FEZ 3', 'FAZ 1, FEZ 3'],
      ['D im Beispiel', 'FAZ 7, FEZ 8', 'FAZ 8, FEZ 8'],
    ],
    merksatz: 'Nie mischen: Die Aufgabe gibt die Zählweise vor.',
  ),
  beispiel(
    'n-nv-9',
    'n-vorwaerts',
    'Vom Zeitpunkt zum Kalenderdatum',
    'Das Ticketsystem-Projekt dauert 15 Arbeitstage und startet am Montag, 02.03.2026. Gearbeitet wird montags bis freitags. An welchem Tag ist es frühestens fertig?',
    schritte: [
      'Woche 1: Mo 02.03. bis Fr 06.03. = Arbeitstage 1 bis 5',
      'Woche 2: Mo 09.03. bis Fr 13.03. = Arbeitstage 6 bis 10',
      'Woche 3: Mo 16.03. bis Fr 20.03. = Arbeitstage 11 bis 15',
      'FEZ 15 heißt: am Ende des 15. Arbeitstags fertig',
    ],
    ergebnis: 'Frühestes Projektende: Freitag, 20.03.2026',
  ),
  falle(
    'n-nv-10',
    'n-vorwaerts',
    'Nicht einfach alle Dauern addieren',
    'Die Projektdauer ist nicht die Summe aller Dauern, denn parallele Vorgänge laufen gleichzeitig. Im Ticketsystem-Projekt ergäbe die Summe 2 + 4 + 6 + 3 + 2 + 4 + 2 = 23 Tage. Tatsächlich sind es 15.',
  ),
  merke(
    'n-nv-11',
    'n-vorwaerts',
    'Merksatz',
    'Wer sich nur eine Regel der Vorwärtsrechnung merkt, sollte diese nehmen.',
    satz:
        'Vorwärts: FEZ = FAZ + D, und am Zusammenfluss warten, bis der letzte Vorgänger fertig ist, also das Maximum.',
  ),

  // =========================================================== Rückwärtsrechnung
  konzept(
    'n-nr-1',
    'n-rueckwaerts',
    'Was die Rückwärtsrechnung liefert',
    'Sie beantwortet die Frage: Wann muss jeder Vorgang spätestens beginnen und enden, damit das Projektende nicht wackelt? Gerechnet wird vom End- zum Startvorgang, erst nach der kompletten Vorwärtsrechnung.',
  ),
  formel(
    'n-nr-2',
    'n-rueckwaerts',
    'Die Regeln',
    'Der Startwert kommt aus der Vorwärtsrechnung, oder aus einem vorgegebenen Endtermin.',
    'SEZ = FEZ des Endvorgangs        (Projektdauer)\n'
        'SEZ = min(SAZ aller Nachfolger)  (alle anderen)\n'
        'SAZ = SEZ - Dauer',
  ),
  beispiel(
    'n-nr-3',
    'n-rueckwaerts',
    'Das kleine Beispiel rückwärts',
    'Gleicher Netzplan wie bei der Vorwärtsrechnung: A (3), B (2) und C (4) nach A, D (1) nach B und C. Projektdauer 8. Berechne SEZ und SAZ.',
    schritte: [
      'D: Endvorgang, SEZ = Projektdauer = 8; SAZ = 8 - 1 = 7',
      'B: einziger Nachfolger D, SEZ = SAZ D = 7; SAZ = 7 - 2 = 5',
      'C: einziger Nachfolger D, SEZ = 7; SAZ = 7 - 4 = 3',
      'A: zwei Nachfolger, SEZ = min(SAZ B 5; SAZ C 3) = 3; SAZ = 3 - 3 = 0',
      'Kontrolle: SAZ des Startvorgangs = 0 ✓',
    ],
    ergebnis: 'SAZ/SEZ: A 0/3, B 5/7, C 3/7, D 7/8',
    skizze: const NetzplanDiagramm(_npMini),
  ),
  falle(
    'n-nr-4',
    'n-rueckwaerts',
    'Das Minimum an der Verzweigung',
    'Hat ein Vorgang mehrere Nachfolger, muss er so früh fertig sein, dass der eiligste Nachfolger rechtzeitig starten kann. Wer bei A den größeren Wert 5 nimmt, lässt C zu spät beginnen und verschiebt das ganze Projekt.',
  ),
  beispiel(
    'n-nr-5',
    'n-rueckwaerts',
    'Das Ticketsystem-Projekt rückwärts',
    'Die Vorwärtsrechnung hat 15 Arbeitstage ergeben (A 2, B 4, C 6, D 3, E 2, F 4, G 2 Tage). Berechne SEZ und SAZ vom Ende her.',
    schritte: [
      'G: Endvorgang, SEZ 15, SAZ 15 - 2 = 13',
      'F: Nachfolger G, SEZ 13, SAZ 13 - 4 = 9',
      'E: Nachfolger G, SEZ 13, SAZ 13 - 2 = 11',
      'D: Nachfolger F, SEZ 9, SAZ 9 - 3 = 6',
      'C: Nachfolger F, SEZ 9, SAZ 9 - 6 = 3',
      'B: SEZ = min(SAZ D 6; SAZ E 11) = 6, SAZ 6 - 4 = 2',
      'A: SEZ = min(SAZ B 2; SAZ C 3) = 2, SAZ 2 - 2 = 0 ✓',
    ],
    ergebnis: 'SAZ/SEZ: A 0/2, B 2/6, C 3/9, D 6/9, E 11/13, F 9/13, G 13/15',
    skizze: const NetzplanDiagramm(_npTicket),
  ),
  vergleich(
    'n-nr-6',
    'n-rueckwaerts',
    'Vorwärts und rückwärts im Vergleich',
    'Die beiden Rechnungen sind spiegelbildlich aufgebaut. Wer eine verstanden hat, kann die andere daraus ableiten.',
    [
      ['', 'vorwärts', 'rückwärts'],
      ['Richtung', 'Start → Ende', 'Ende → Start'],
      ['Startwert', 'FAZ = 0', 'SEZ = Projektdauer'],
      [
        'bei mehreren',
        'Maximum der FEZ der Vorgänger',
        'Minimum der SAZ der Nachfolger',
      ],
      ['Rechnung', 'FEZ = FAZ + D', 'SAZ = SEZ - D'],
    ],
  ),
  konzept(
    'n-nr-7',
    'n-rueckwaerts',
    'Mit vorgegebenem Endtermin',
    'Gibt der Auftraggeber einen festen Endtermin vor, beginnt die Rückwärtsrechnung dort statt bei der errechneten Dauer. Liegt der Termin früher als das errechnete Ende, werden die Puffer negativ. Der Termin ist so nicht zu halten.',
  ),
  beispiel(
    'n-nr-8',
    'n-rueckwaerts',
    'Negativer Puffer',
    'Das kleine Beispiel (A 3, B 2, C 4, D 1 Tage; errechnete Dauer 8) soll schon nach 7 Tagen fertig sein. Rechne rückwärts ab dem Endtermin 7.',
    schritte: [
      'D: SEZ = 7 (Vorgabe), SAZ = 7 - 1 = 6',
      'B: SEZ 6, SAZ 6 - 2 = 4; C: SEZ 6, SAZ 6 - 4 = 2',
      'A: SEZ = min(4; 2) = 2, SAZ = 2 - 3 = -1',
      'Gesamtpuffer GP = SAZ - FAZ: A -1 - 0 = -1, C 2 - 3 = -1, D 6 - 7 = -1, B 4 - 3 = 1',
    ],
    ergebnis:
        'A, C und D haben GP -1: Ohne Gegenmaßnahme wird der Termin um 1 Tag verfehlt.',
  ),
  falle(
    'n-nr-9',
    'n-rueckwaerts',
    'Typische Fehler rückwärts',
    'Die meisten Punktverluste entstehen durch dieselben Fehler.',
    points: [
      'SEZ mit dem FEZ statt dem SAZ des Nachfolgers füllen',
      'An der Verzweigung das Maximum statt des Minimums nehmen',
      'Vorwärts- und Rückwärtsrechnung mischen: erst komplett vorwärts, dann komplett rückwärts',
      'Gegenprobe vergessen: Auf dem kritischen Pfad gilt FAZ = SAZ und FEZ = SEZ.',
    ],
  ),
  merke(
    'n-nr-10',
    'n-rueckwaerts',
    'Merksatz',
    'Das Gegenstück zur Vorwärtsrechnung.',
    satz:
        'Rückwärts: SAZ = SEZ - D, und an der Verzweigung bestimmt der eiligste Nachfolger, also das Minimum.',
  ),

  // ============================================= Gesamtpuffer und freier Puffer
  konzept(
    'n-np-1',
    'n-puffer',
    'Zwei Arten von Luft',
    'Puffer ist die Zeit, um die sich ein Vorgang verschieben oder verlängern darf. Es gibt ihn in zwei Ausprägungen, je nachdem, was geschützt werden soll.',
    points: [
      'Gesamtpuffer (GP): Verschiebung, ohne das Projektende zu gefährden',
      'Freier Puffer (FP): Verschiebung, ohne den frühesten Anfang eines Nachfolgers zu verschieben',
    ],
  ),
  formel(
    'n-np-2',
    'n-puffer',
    'Die Formeln',
    'Für den Gesamtpuffer gibt es zwei gleichwertige Wege. Nutze den zweiten als Gegenprobe.',
    'GP = SAZ - FAZ = SEZ - FEZ\n'
        'FP = min(FAZ aller Nachfolger) - FEZ\n'
        'FP Endvorgang = Projektdauer - FEZ',
  ),
  vergleich(
    'n-np-3',
    'n-puffer',
    'GP und FP im Vergleich',
    'Beide Puffer messen Luft, aber mit unterschiedlichem Bezugspunkt.',
    [
      ['', 'Gesamtpuffer GP', 'freier Puffer FP'],
      ['schützt', 'das Projektende', 'den frühesten Start der Nachfolger'],
      ['Formel', 'SAZ - FAZ', 'min(FAZ Nachfolger) - FEZ'],
      ['kritischer Pfad', '0', '0'],
      ['Größe', 'immer ≥ FP', 'immer ≤ GP'],
    ],
  ),
  beispiel(
    'n-np-4',
    'n-puffer',
    'Ein Beispiel mit Unterschied',
    'Netzwerk für ein Büro: A Planung (2 Tage) ist der Start. B Kabel verlegen (1) folgt auf A, C Dosen setzen (1) auf B. D Switch liefern (5) folgt auf A. E Inbetriebnahme (2) folgt auf C und D. Berechne GP und FP.',
    schritte: [
      'Vorwärts (FAZ/FEZ): A 0/2, B 2/3, C 3/4, D 2/7, E max(4; 7) = 7/9 → Dauer 9',
      'Rückwärts (SAZ/SEZ): E 7/9, C 6/7, D 2/7, B 5/6, A: SEZ min(5; 2) = 2 → 0/2',
      'B: GP = 5 - 2 = 3; FP = FAZ C - FEZ B = 3 - 3 = 0',
      'C: GP = 6 - 3 = 3; FP = FAZ E - FEZ C = 7 - 4 = 3',
      'A, D, E: GP = 0 und FP = 0 → kritisch',
    ],
    ergebnis: 'B: GP 3, FP 0 · C: GP 3, FP 3 · A, D, E: kein Puffer',
    skizze: const NetzplanDiagramm(_npPuffer),
  ),
  konzept(
    'n-np-5',
    'n-puffer',
    'Was die Zahlen bedeuten',
    'B und C liegen in einer Kette und teilen sich dieselben drei Tage Luft. Verbraucht B sie, bleibt für C nichts mehr übrig. Deshalb hat B zwar GP 3, aber FP 0.',
    points: [
      'B verschiebt sich um 2 Tage: C startet 2 Tage später, das Projektende bleibt bei 9.',
      'C verschiebt sich um 2 Tage: niemand merkt es, denn FP = 3.',
      'B verschiebt sich um 4 Tage: 1 Tag mehr als GP → Projektende 10.',
    ],
  ),
  vergleich(
    'n-np-6',
    'n-puffer',
    'Auswirkung einer Verzögerung',
    'Mit GP und FP lässt sich sofort sagen, wen eine Verzögerung um x Tage trifft.',
    [
      ['Verzögerung x', 'Nachfolger', 'Projektende'],
      ['x ≤ FP', 'nicht betroffen', 'nicht betroffen'],
      ['FP < x ≤ GP', 'starten später', 'nicht betroffen'],
      ['x > GP', 'starten später', 'verschiebt sich um x - GP'],
    ],
  ),
  beispiel(
    'n-np-7',
    'n-puffer',
    'Verzögerungen im Ticketsystem-Projekt',
    'Im Ticketsystem-Projekt (Dauer 15) hat C Hardware beschaffen GP 1 und FP 1, E Schulung vorbereiten GP 5 und FP 5. Die Hardware kommt 3 Tage später, und die Schulungsvorbereitung dauert 4 Tage länger. Wie lange dauert das Projekt jetzt?',
    schritte: [
      'C: Verzögerung 3 > GP 1 → Projektende verschiebt sich um 3 - 1 = 2 Tage',
      'E: Verzögerung 4 ≤ FP 5 → weder Nachfolger noch Projektende betroffen',
      'Kontrolle: C endet bei 8 + 3 = 11, F beginnt bei max(11; 9) = 11 und endet bei 15, G endet bei 17',
    ],
    ergebnis: 'Neue Projektdauer 17 Arbeitstage',
  ),
  falle(
    'n-np-8',
    'n-puffer',
    'Gesamtpuffer ist nicht freier Puffer',
    'Die häufigsten Fehler beim Puffer.',
    points: [
      'Den freien Puffer mit dem SAZ statt dem FAZ des Nachfolgers rechnen',
      'Übersehen, dass sich Vorgänge einer Kette einen Gesamtpuffer teilen',
      'Einen freien Puffer größer als den Gesamtpuffer angeben. Das ist unmöglich',
      'Bei mehreren Nachfolgern den größten statt den kleinsten FAZ nehmen',
    ],
  ),
  falle(
    'n-np-9',
    'n-puffer',
    'Puffer ist keine Reserve zum Verplanen',
    'Puffer ergibt sich aus der Struktur des Plans. Wer ihn gleich am Anfang verbraucht („wir haben ja Luft“), hat später keinen mehr und aus einem unkritischen Weg wird ein kritischer.',
  ),
  merke(
    'n-np-10',
    'n-puffer',
    'Merksatz',
    'Die beiden Puffer schützen Unterschiedliches.',
    satz:
        'Gesamtpuffer (SAZ - FAZ) schützt das Projektende, freier Puffer (FAZ Nachfolger - FEZ) schützt den Nachfolger.',
  ),

  // ============================================================= Kritischer Pfad
  konzept(
    'n-nk-1',
    'n-kritisch',
    'Der kritische Pfad',
    'Der kritische Pfad ist die Kette aller Vorgänge mit Gesamtpuffer 0, vom Start- bis zum Endvorgang. Er ist der längste Weg durch den Netzplan und bestimmt die Projektdauer.',
    points: [
      'Jede Verzögerung auf dem kritischen Pfad verschiebt das Projektende um genau diese Zeit.',
      'Kritische Vorgänge werden im Netzplan meist farbig oder mit dickem Rahmen markiert.',
    ],
  ),
  ablauf(
    'n-nk-2',
    'n-kritisch',
    'Kritischen Pfad bestimmen',
    'Nach Vorwärts- und Rückwärtsrechnung ist es nur noch ein kleiner Schritt.',
    [
      'Für jeden Vorgang GP = SAZ - FAZ berechnen',
      'Alle Vorgänge mit GP = 0 markieren',
      'Die markierten Vorgänge vom Start zum Ende verbinden',
      'Gegenprobe: Die Summe ihrer Dauern ergibt die Projektdauer',
    ],
  ),
  skizze(
    'n-nk-3',
    'n-kritisch',
    'Der kritische Pfad im Ticketsystem-Projekt',
    'Im Ticketsystem-Projekt haben A, B, D, F und G einen Gesamtpuffer von 0. Sie bilden den kritischen Pfad.',
    const NetzplanDiagramm(_npTicket),
    points: [
      'Kritischer Pfad: A - B - D - F - G',
      'Gegenprobe: 2 + 4 + 3 + 4 + 2 = 15 Tage = Projektdauer ✓',
      'C (GP 1) und E (GP 5) sind unkritisch.',
    ],
  ),
  skizze(
    'n-nk-4',
    'n-kritisch',
    'Derselbe Plan als Gantt-Diagramm',
    'Im Balkenplan erscheint der kritische Pfad als lückenlose Kette. Die Lücke zwischen dem Ende eines unkritischen Balkens und dem Start seines Nachfolgers ist sein freier Puffer.',
    const GanttDiagramm([
      GanttVorgang('A Ist-Analyse', 0, 2, kritisch: true),
      GanttVorgang('B Konzept', 2, 4, kritisch: true),
      GanttVorgang('C Hardware', 2, 6),
      GanttVorgang('D Installation', 6, 3, kritisch: true),
      GanttVorgang('E Schulung vorb.', 6, 2),
      GanttVorgang('F Systemtest', 9, 4, kritisch: true),
      GanttVorgang('G Go-live', 13, 2, kritisch: true),
    ]),
    points: [
      'C endet bei 8, F beginnt bei 9 → 1 Tag Lücke = FP von C',
      'E endet bei 8, G beginnt bei 13 → 5 Tage Lücke = FP von E',
    ],
  ),
  beispiel(
    'n-nk-5',
    'n-kritisch',
    'Alle Wege vergleichen',
    'Bei kleinen Plänen lässt sich der kritische Pfad auch ohne komplette Rechnung finden: Man zählt alle Wege vom Start zum Ende ab. Welcher Weg im Ticketsystem-Projekt ist der längste?',
    schritte: [
      'A - B - D - F - G: 2 + 4 + 3 + 4 + 2 = 15 Tage',
      'A - C - F - G: 2 + 6 + 4 + 2 = 14 Tage',
      'A - B - E - G: 2 + 4 + 2 + 2 = 10 Tage',
      'Der längste Weg ist der kritische Pfad.',
    ],
    ergebnis: 'Kritischer Pfad A - B - D - F - G mit 15 Tagen',
  ),
  konzept(
    'n-nk-6',
    'n-kritisch',
    'Mehrere kritische Pfade',
    'Sind zwei Wege gleich lang und zugleich die längsten, sind beide kritisch. Das Projekt ist dann besonders anfällig: Jede Verzögerung auf einem der beiden Wege verschiebt das Ende.',
  ),
  konzept(
    'n-nk-7',
    'n-kritisch',
    'Das Projekt beschleunigen',
    'Nur kürzere kritische Vorgänge verkürzen das Projekt. Mehr Tempo bei unkritischen Vorgängen vergrößert bloß deren Puffer.',
    points: [
      'Mehr Ressourcen auf einen kritischen Vorgang setzen (Crashing), kostet Geld',
      'Kritische Vorgänge teilweise parallel statt nacheinander ausführen (Fast Tracking), erhöht das Risiko',
      'Umfang reduzieren, in Absprache mit dem Auftraggeber',
      'Danach neu rechnen: Ein anderer Weg kann jetzt kritisch sein.',
    ],
  ),
  beispiel(
    'n-nk-8',
    'n-kritisch',
    'Eine Verkürzung, die verpufft',
    'Im Ticketsystem-Projekt soll D Installation durch einen zweiten Techniker von 3 auf 1 Tag verkürzt werden. Wie lange dauert das Projekt danach, und was ist jetzt kritisch?',
    schritte: [
      'A - B - D - F - G: 2 + 4 + 1 + 4 + 2 = 13 Tage',
      'A - C - F - G: 2 + 6 + 4 + 2 = 14 Tage (unverändert)',
      'A - B - E - G: 2 + 4 + 2 + 2 = 10 Tage',
      'Der längste Weg ist jetzt A - C - F - G.',
    ],
    ergebnis:
        'Projektdauer 14 statt 15 Tage, trotz 2 Tagen Verkürzung nur 1 Tag gewonnen; neuer kritischer Pfad A - C - F - G',
  ),
  vergleich(
    'n-nk-9',
    'n-kritisch',
    'Verzögerungen einschätzen',
    'Die Folgen einer Verzögerung hängen vom Puffer des Vorgangs ab. Beispiele aus dem Ticketsystem-Projekt (Dauer 15):',
    [
      ['Vorgang', 'Verzögerung', 'Projektende'],
      ['B (kritisch)', '+2 Tage', '+2 → 17 Tage'],
      ['C (GP 1)', '+1 Tag', 'unverändert 15'],
      ['C (GP 1)', '+2 Tage', '+1 → 16 Tage'],
      ['E (GP 5)', '+3 Tage', 'unverändert 15'],
    ],
  ),
  falle(
    'n-nk-10',
    'n-kritisch',
    'Kritisch heißt nicht lang',
    'Ein Vorgang ist nicht kritisch, weil er lange dauert, sondern weil er keinen Puffer hat. Im Ticketsystem-Projekt dauert C mit 6 Tagen am längsten und ist trotzdem unkritisch.',
  ),
  konzept(
    'n-nk-11',
    'n-kritisch',
    'Was die Projektleitung daraus macht',
    'Der kritische Pfad zeigt, wo sich Aufmerksamkeit lohnt. Er ist das wichtigste Steuerungswerkzeug der Terminplanung.',
    points: [
      'Kritische Vorgänge besonders eng überwachen',
      'Personal für Engpässe von Vorgängen mit großem Puffer abziehen, im Beispiel von E',
      'Risiken auf dem kritischen Pfad zuerst behandeln',
    ],
  ),
  merke(
    'n-nk-12',
    'n-kritisch',
    'Merksatz',
    'Daraus folgt, wo bei Terminproblemen angesetzt werden muss.',
    satz:
        'Kritisch heißt: Gesamtpuffer 0, längster Weg. Wer hier Zeit verliert, verliert sie am Projektende. Wer hier Zeit gewinnt, gewinnt sie nur, bis ein anderer Weg kritisch wird.',
  ),
];
