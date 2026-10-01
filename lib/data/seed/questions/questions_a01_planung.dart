import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben zu Bereich 01, Teil 2: Terminplanung, Risiko, Wirtschaftlichkeit
/// und Projektabschluss.
///
/// Ergänzt die Altaufgaben mit Lektionszuordnung aus `seed_netzplan.dart`
/// (tp-001..tp-004) und `seed_anforderungen.dart` (wi-001..wi-005,
/// qr-001, qr-002, qr-004, ab-001..ab-003).
final List<Question> questionsA01Planung = [
  // ========================================================= Projektstrukturplan
  lueckentext(
    'a1-tp-1',
    't-psp',
    scenario:
        'Im Projekthandbuch eines Systemhauses soll der Projektstrukturplan (PSP) in wenigen Sätzen erklärt werden.',
    prompt: 'Vervollständigen Sie den Text mit den passenden Begriffen.',
    text:
        'Der PSP zeigt, {0} im Projekt zu tun ist - aber nicht, {1} es erledigt wird.\n'
        'Seine unterste Ebene bilden die {2}.\n'
        'Reihenfolge und Abhängigkeiten zeigt erst der {3}.',
    luecken: [
      wort(['was'], 'Der PSP gliedert den Inhalt des Projekts.'),
      wort(['wann'], 'Termine enthält der PSP nicht.'),
      wort(['Arbeitspakete'], 'Sie werden nicht weiter zerlegt.'),
      wort(['Netzplan'], 'Dort stehen Vorgänger und Nachfolger.'),
    ],
    wortbank: ['Meilensteine', 'Lastenheft', 'warum'],
    explanation:
        'Der PSP zeigt, WAS zu tun ist - nicht WANN und in welcher Reihenfolge. Seine unterste Ebene sind die Arbeitspakete; Reihenfolge und Termine kommen erst im Netzplan oder Gantt-Diagramm dazu.',
  ),
  zuordnen(
    'a1-tp-2',
    't-psp',
    prompt: 'Nach welchem Prinzip ist der jeweilige PSP gegliedert?',
    buckets: ['objektorientiert', 'funktionsorientiert', 'phasenorientiert'],
    items: [
      zu('Server - Clients - Netzwerk', 0, 'Bestandteile des Ergebnisses.'),
      zu('Beschaffen - Installieren - Testen', 1, 'Tätigkeiten, die anfallen.'),
      zu(
        'Analyse - Entwurf - Umsetzung - Einführung',
        2,
        'Projektphasen in zeitlicher Folge.',
      ),
      zu(
        'Hardware - Software - Dokumentation',
        0,
        'Teile des fertigen Ergebnisses.',
      ),
      zu(
        'Planen - Programmieren - Schulen',
        1,
        'Tätigkeiten, keine Ergebnisteile.',
      ),
      zu(
        'Konzeptphase - Realisierungsphase - Betriebsphase',
        2,
        'Die Gliederung folgt den Phasen.',
      ),
    ],
    explanation:
        'Objektorientiert: Bestandteile des Ergebnisses. Funktionsorientiert: Tätigkeiten. Phasenorientiert: Projektphasen.',
  ),
  freitext(
    'a1-tp-3',
    't-psp',
    scenario:
        'Eine Projektleiterin prüft den PSP eines Auszubildenden und stellt fest, dass mehrere Arbeitspakete zu grob beschrieben sind.',
    prompt: 'Nennen Sie drei Eigenschaften eines guten Arbeitspakets. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Ein eindeutig abgegrenztes, prüfbares Ergebnis',
        stichwoerter: ['prüfbar', 'Ergebnis', 'abgegrenzt', 'eindeutig'],
      ),
      krit(
        'Genau eine verantwortliche Person',
        stichwoerter: ['verantwortlich', 'Verantwortlicher', 'zuständig'],
      ),
      krit(
        'Ein schätzbarer Aufwand',
        stichwoerter: ['Aufwand', 'schätzbar', 'geschätzt'],
      ),
      krit(
        'Überschaubare Größe - es wird im PSP nicht weiter zerlegt',
        stichwoerter: [
          'überschaubar',
          'nicht weiter zerlegt',
          'unterste Ebene',
        ],
      ),
    ],
    loesung:
        'Ein gutes Arbeitspaket hat ein eindeutig abgegrenztes, prüfbares Ergebnis, genau eine verantwortliche Person und einen schätzbaren Aufwand. Es ist überschaubar und wird im PSP nicht weiter zerlegt.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Das Arbeitspaket ist die kleinste, eindeutig verantwortete und schätzbare Einheit im PSP.',
  ),
  einfach(
    'a1-tp-4',
    't-psp',
    scenario:
        'Der PSP für eine neue Telefonanlage hat auf Ebene 1 die Elemente „Telefonanlage“, „Endgeräte“, „Verkabelung“ und „Headsets“.',
    prompt: 'Nach welchem Prinzip ist Ebene 1 gegliedert?',
    choices: [
      ja(
        'objektorientiert',
        'Alle vier Elemente sind Bestandteile des fertigen Ergebnisses.',
      ),
      nein(
        'funktionsorientiert',
        'Dann stünden Tätigkeiten wie „Beschaffen“ oder „Installieren“ auf Ebene 1.',
      ),
      nein(
        'phasenorientiert',
        'Dann stünden Phasen wie „Analyse“ oder „Einführung“ auf Ebene 1.',
      ),
      nein(
        'zeitorientiert',
        'Diese Gliederungsart gibt es nicht - der PSP enthält keine Zeitangaben.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Die Leitfrage „Woraus besteht das Ergebnis?“ führt zur objektorientierten Gliederung. Tätigkeiten stünden in einem funktionsorientierten, Phasen in einem phasenorientierten PSP.',
  ),
  einfach(
    'a1-tp-5',
    't-psp',
    scenario:
        'Im PSP hat die Teilaufgabe „Entwurf“ den Code 2. Darunter liegen die Arbeitspakete „Datenmodell“, „Oberfläche“ und „Schnittstellen“ in dieser Reihenfolge. Codiert wird numerisch.',
    prompt: 'Welchen PSP-Code erhält das Arbeitspaket „Schnittstellen“?',
    choices: [
      ja('2.3', 'Drittes Element unter Teilaufgabe 2.'),
      nein('3.2', 'Das wäre das zweite Element unter Teilaufgabe 3.'),
      nein(
        '2.0.3',
        'Jede Ebene bekommt genau eine Stelle - eine Null dazwischen gibt es nicht.',
      ),
      nein('3', 'Das wäre eine eigene Teilaufgabe auf Ebene 1.'),
    ],
    explanation:
        'Beim numerischen Code steht je Ebene eine Zahl, getrennt durch Punkte. Das dritte Arbeitspaket unter Teilaufgabe 2 heißt also 2.3.',
  ),
  mehrfach(
    'a1-tp-6',
    't-psp',
    prompt: 'Welche Aussagen zum Projektstrukturplan sind richtig?',
    choices: [
      ja(
        'Die Arbeitspakete einer Teilaufgabe decken zusammen deren gesamten Umfang ab.',
        'Das ist die 100-%-Regel: nichts fehlt, nichts ist doppelt.',
      ),
      ja(
        'Der PSP ist die Grundlage für Aufwandsschätzung, Kosten- und Terminplanung.',
        'Geschätzt und geplant wird je Arbeitspaket.',
      ),
      ja(
        'Jedes Arbeitspaket erhält einen eindeutigen PSP-Code.',
        'Über den Code werden Aufwände und Kosten zugeordnet.',
      ),
      nein(
        'Der PSP zeigt, welches Arbeitspaket zuerst erledigt wird.',
        'Reihenfolge und Abhängigkeiten zeigt erst der Netzplan.',
      ),
      nein(
        'Ein Meilenstein ist die unterste Ebene des PSP.',
        'Die unterste Ebene sind Arbeitspakete; Meilensteine gehören in den Terminplan.',
      ),
    ],
    explanation:
        'Der PSP beantwortet die Frage WAS: vollständig (100-%-Regel), eindeutig codiert und bis zu verantwortbaren Arbeitspaketen zerlegt. Zeit und Reihenfolge kommen erst danach.',
  ),
  reihenfolge(
    'a1-tp-7',
    't-psp',
    prompt: 'Bringe die Planungsschritte in die richtige Reihenfolge.',
    items: [
      'Projektstrukturplan erstellen',
      'Aufwand und Dauer je Arbeitspaket schätzen',
      'Abhängigkeiten zwischen Arbeitspaketen festlegen',
      'Netzplan berechnen',
      'Gantt-Diagramm erstellen',
    ],
    explanation:
        'Erst wird festgelegt, was zu tun ist (PSP), dann wie lange es dauert. Mit den Abhängigkeiten lässt sich der Netzplan rechnen, das Gantt-Diagramm stellt das Ergebnis anschaulich dar.',
  ),

  // ================================================ Gantt-Diagramm und Meilensteine
  rechnen(
    'a1-tg-1',
    't-gantt',
    scenario:
        'Das Gantt-Diagramm zeigt die Planung für einen Serverumzug. Hervorgehobene Balken sind kritisch, der letzte Eintrag ist ein Meilenstein.',
    skizze: const GanttDiagramm([
      GanttVorgang('A Umzug planen', 0, 2, kritisch: true),
      GanttVorgang('B Rack aufbauen', 2, 2),
      GanttVorgang('C Daten sichern', 2, 3, kritisch: true),
      GanttVorgang('D Server umziehen', 5, 2, kritisch: true),
      GanttVorgang('E Test', 7, 1, kritisch: true),
      GanttVorgang('Server live', 8, 0, kritisch: true),
    ], einheit: 'Tag'),
    prompt: 'Wie viele Tage dauert das Projekt insgesamt?',
    answer: 8,
    unit: 'Tage',
    difficulty: 1,
    explanation:
        'Die Projektdauer ergibt sich aus dem kritischen Pfad A - C - D - E:\n'
        '2 + 3 + 2 + 1 = 8 Tage.\n'
        'Das Ende des letzten Vorgangs E liegt bei 7 + 1 = 8, dort steht der Meilenstein „Server live“.',
  ),
  einfach(
    'a1-tg-2',
    't-gantt',
    scenario:
        'Gleicher Plan wie zuvor: A 0-2, B 2-4, C 2-5, D 5-7 (braucht B und C), E 7-8.',
    skizze: const GanttDiagramm([
      GanttVorgang('A Umzug planen', 0, 2, kritisch: true),
      GanttVorgang('B Rack aufbauen', 2, 2),
      GanttVorgang('C Daten sichern', 2, 3, kritisch: true),
      GanttVorgang('D Server umziehen', 5, 2, kritisch: true),
      GanttVorgang('E Test', 7, 1, kritisch: true),
      GanttVorgang('Server live', 8, 0, kritisch: true),
    ], einheit: 'Tag'),
    prompt: 'Welcher Vorgang hat Puffer, und wie viel?',
    choices: [
      ja(
        'B, 1 Tag',
        'B endet bei 4, D beginnt erst bei 5 - B darf 1 Tag später fertig werden.',
      ),
      nein(
        'B, 2 Tage',
        'D startet bei 5, B endet bei 4: der Abstand ist 1 Tag, nicht 2.',
      ),
      nein(
        'C, 1 Tag',
        'C endet genau bei 5, wenn D beginnt - C liegt auf dem kritischen Pfad.',
      ),
      nein(
        'Kein Vorgang hat Puffer',
        'B endet vor dem Start seines Nachfolgers D.',
      ),
    ],
    explanation:
        'D braucht B und C und startet beim späteren Ende, also bei 5 (Ende von C). B ist schon bei 4 fertig und hat damit 5 - 4 = 1 Tag Puffer. Alle anderen Vorgänge sind kritisch.',
  ),
  markieren(
    'a1-tg-3',
    't-gantt',
    scenario:
        'Im Terminplan für die Einführung einer Lagersoftware sollen Meilensteine festgelegt werden. Zur Auswahl stehen sechs Formulierungen.',
    prompt:
        'Markieren Sie alle Formulierungen, die sich als Meilenstein eignen.',
    zeilen: [
      ja(
        'Pflichtenheft vom Kunden unterschrieben',
        'Ein prüfbares Ereignis ohne Dauer - erreicht oder nicht.',
      ),
      nein(
        'Pflichtenheft erstellen',
        'Das ist eine Tätigkeit mit Dauer, also ein Vorgang.',
      ),
      ja('Abnahmetest bestanden', 'Ein abgeschlossenes, prüfbares Ergebnis.'),
      nein('Testphase', 'Eine Phase hat eine Dauer - ein Meilenstein nicht.'),
      ja(
        'Hardware vollständig geliefert',
        'Ein eindeutig feststellbares Ereignis.',
      ),
      nein(
        'Programmierung zu 80 % fertig',
        'Nicht eindeutig prüfbar; Meilensteine kennen kein „fast“.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Meilensteine markieren prüfbare Ergebnisse mit der Dauer 0. Gut formuliert sind sie als abgeschlossenes Ereignis, zum Beispiel „... freigegeben“ oder „... bestanden“.',
  ),
  zuordnen(
    'a1-tg-4',
    't-gantt',
    prompt: 'Welche Darstellung ist für die jeweilige Aufgabe besser geeignet?',
    buckets: ['Gantt-Diagramm', 'Netzplan'],
    items: [
      zu(
        'Terminplan im Statusmeeting mit der Geschäftsführung zeigen',
        0,
        'Der Balkenplan ist ohne Erklärung verständlich.',
      ),
      zu(
        'Gesamtpuffer eines Vorgangs berechnen',
        1,
        'Puffer ergeben sich aus Vorwärts- und Rückwärtsrechnung.',
      ),
      zu(
        'Kritischen Pfad rechnerisch bestimmen',
        1,
        'Der Netzplan ist das Rechenmodell.',
      ),
      zu(
        'Auf einen Blick zeigen, welche Arbeiten gleichzeitig laufen',
        0,
        'Parallele Balken sieht man sofort auf der Zeitachse.',
      ),
      zu(
        'Fortschritt mit einer Heute-Linie darstellen',
        0,
        'Die Zeitachse macht Verzug sichtbar.',
      ),
      zu(
        'Früheste und späteste Anfangszeitpunkte ermitteln',
        1,
        'FAZ und SAZ werden im Netzplan berechnet.',
      ),
    ],
    explanation:
        'Mit dem Netzplan wird gerechnet (Puffer, kritischer Pfad, FAZ/SAZ), mit dem Gantt-Diagramm kommuniziert (Zeitbezug, Parallelität, Fortschritt).',
  ),
  einfach(
    'a1-tg-5',
    't-gantt',
    scenario:
        'In der Meilensteintrendanalyse springt die Linie eines Meilensteins von Bericht zu Bericht abwechselnd nach oben und unten, endet aber beim ursprünglich geplanten Termin.',
    prompt: 'Was sagt dieser Verlauf aus?',
    choices: [
      ja(
        'Die Prognosen waren unsicher, die Planung hat stark geschwankt.',
        'Ein Zickzack zeigt instabile Schätzungen - ein Warnsignal für die Planungsqualität.',
      ),
      nein(
        'Das Projekt war gut geplant, weil der Termin am Ende stimmt.',
        'Der Endtermin passt zufällig - die Schwankungen zeigen unzuverlässige Prognosen.',
      ),
      nein(
        'Der Meilenstein wurde mehrfach erreicht.',
        'Ein Meilenstein wird genau einmal erreicht, wenn die Linie die Diagonale trifft.',
      ),
      nein(
        'Es bestand nie Handlungsbedarf.',
        'Jeder Ausschlag nach oben war ein angekündigter Verzug, der Reaktion erforderte.',
      ),
    ],
    explanation:
        'MTA-Lesehilfe: waagerecht = Termin hält, steigend = Verzug, fallend = früher fertig, Zickzack = unsichere Planung. Die MTA zeigt den Trend, nicht die Ursache.',
  ),
  reihenfolge(
    'a1-tg-6',
    't-gantt',
    prompt:
        'Bringe die Schritte zum Zeichnen eines Gantt-Diagramms aus einer Vorgangsliste in die richtige Reihenfolge.',
    items: [
      'Vorgänge mit Dauer und Vorgängern auflisten',
      'Vorgänge ohne Vorgänger bei Zeitpunkt 0 beginnen lassen',
      'Start jedes Nachfolgers beim spätesten Ende seiner Vorgänger festlegen',
      'Balken mit ihrer Dauer auf der Zeitachse einzeichnen',
      'Meilensteine als Raute ergänzen und kritische Vorgänge markieren',
    ],
    explanation:
        'Erst die Daten, dann die Startzeitpunkte von vorn nach hinten (Ende = Start + Dauer, Nachfolger starten beim spätesten Vorgängerende), dann zeichnen und zuletzt Meilensteine und kritische Vorgänge hervorheben.',
  ),
  rechnen(
    'a1-tg-7',
    't-gantt',
    scenario:
        'Vorgang A (4 Tage) und Vorgang B (6 Tage) beginnen beide bei Zeitpunkt 0. C (3 Tage) braucht A und B. D (2 Tage) braucht C.',
    prompt: 'Zu welchem Zeitpunkt (in Tagen) ist D frühestens fertig?',
    answer: 11,
    unit: 'Tage',
    explanation:
        'A endet bei 0 + 4 = 4, B bei 0 + 6 = 6.\n'
        'C startet beim späteren Ende seiner Vorgänger, also bei 6, und endet bei 6 + 3 = 9.\n'
        'D startet bei 9 und endet bei 9 + 2 = 11.\n'
        'Typischer Fehler: C schon bei 4 starten lassen - dann wäre B noch nicht fertig.',
  ),

  // ================================================== Ressourcen und Aufwand
  rechnen(
    'a1-tr-1',
    't-ressourcen',
    prompt:
        'Ein Arbeitspaket hat einen Aufwand von 24 Personentagen. Zwei Mitarbeiter arbeiten zu je 60 % daran. Wie viele Arbeitstage dauert es?',
    answer: 20,
    unit: 'Arbeitstage',
    explanation:
        'Dauer = Aufwand / (Personen × Verfügbarkeit) = 24 / (2 × 0,6) = 24 / 1,2 = 20 Arbeitstage.',
  ),
  paare(
    'a1-tr-2',
    't-ressourcen',
    scenario: 'In der Ressourcenplanung werden vier Begriffe oft verwechselt.',
    prompt: 'Ordnen Sie jedem Begriff seine Bedeutung zu.',
    paare: [
      paar('Aufwand', 'Arbeitsmenge in Personentagen'),
      paar('Dauer', 'Zeitspanne in Arbeitstagen'),
      paar('Verfügbarkeit', 'Anteil der Arbeitszeit für das Projekt'),
      paar('Kapazität', 'Verfügbare Personentage im Zeitraum'),
    ],
    explanation:
        'Aufwand = Arbeitsmenge (PT), Dauer = Kalenderzeit (AT). Mehr Personen senken die Dauer, nicht den Aufwand. Die Kapazität ergibt sich aus Arbeitstagen mal Verfügbarkeit.',
  ),
  rechnen(
    'a1-tr-3',
    't-ressourcen',
    scenario:
        'Der Juni hat 21 Arbeitstage. Anna ist zu 100 % im Projekt, Ben zu 50 %. Can ist zu 80 % im Projekt und hat im Juni 6 Tage Urlaub.',
    prompt:
        'Wie viele Personentage stehen dem Projekt im Juni zur Verfügung? (eine Nachkommastelle)',
    answer: 43.5,
    tolerance: 0.05,
    unit: 'PT',
    explanation:
        'Anna: 21 AT × 1,0 = 21,0 PT\n'
        'Ben: 21 AT × 0,5 = 10,5 PT\n'
        'Can: (21 - 6) AT × 0,8 = 15 × 0,8 = 12,0 PT\n'
        'Summe: 21,0 + 10,5 + 12,0 = 43,5 PT\n'
        'Wichtig: erst die Urlaubstage abziehen, dann mit der Verfügbarkeit multiplizieren.',
  ),
  rechnen(
    'a1-tr-4',
    't-ressourcen',
    scenario:
        'Für ein Arbeitspaket liegen drei Schätzungen vor: optimistisch 8 PT, wahrscheinlich 12 PT, pessimistisch 22 PT.',
    prompt: 'Welchen Erwartungswert liefert die Drei-Punkt-Schätzung?',
    answer: 13,
    unit: 'PT',
    explanation:
        'Erwartungswert = (O + 4 × M + P) / 6\n'
        '= (8 + 4 × 12 + 22) / 6\n'
        '= (8 + 48 + 22) / 6 = 78 / 6 = 13 PT.\n'
        'Der wahrscheinlichste Wert zählt vierfach; der weit entfernte pessimistische Wert zieht das Ergebnis über 12.',
  ),
  rechnen(
    'a1-tr-5',
    't-ressourcen',
    scenario:
        'Für die Umstellung von 240 Arbeitsplätzen rechnet man 0,5 PT je Arbeitsplatz. Die Umstellung muss in 20 Arbeitstagen erledigt sein. Die Techniker sind zu 75 % für das Projekt verfügbar.',
    prompt: 'Wie viele Techniker werden mindestens benötigt?',
    answer: 8,
    unit: 'Techniker',
    difficulty: 3,
    explanation:
        'Aufwand: 240 × 0,5 PT = 120 PT\n'
        'Personen = Aufwand / (Dauer × Verfügbarkeit) = 120 / (20 × 0,75) = 120 / 15 = 8 Techniker.\n'
        'Ergäbe sich eine krumme Zahl, würde man aufrunden.',
  ),
  mehrfach(
    'a1-tr-6',
    't-ressourcen',
    scenario:
        'Das Ressourcenhistogramm einer Administratorin zeigt für KW 12 eine Auslastung von 150 %, für KW 14 nur 40 %.',
    prompt:
        'Welche Maßnahmen sind geeignet, die Überlast in KW 12 auszugleichen?',
    choices: [
      ja(
        'Einen Vorgang mit ausreichendem Puffer in KW 14 verschieben',
        'Kapazitätsausgleich innerhalb des Puffers kostet weder Geld noch Termin.',
      ),
      ja(
        'Arbeit auf eine Kollegin mit freier Kapazität umverteilen',
        'Die Last wird auf mehrere Schultern verteilt.',
      ),
      ja(
        'Für KW 12 externe Unterstützung einkaufen',
        'Zusätzliche Kapazität löst den Engpass - kostet aber Geld.',
      ),
      nein(
        'Die Überlast ignorieren, weil sie nur eine Woche dauert',
        'Eine Planung über 100 % ist nicht umsetzbar - der Verzug kommt sicher.',
      ),
      nein(
        'Einen kritischen Vorgang nach hinten schieben, ohne den Endtermin zu ändern',
        'Kritische Vorgänge haben keinen Puffer - jede Verschiebung verschiebt das Projektende.',
      ),
    ],
    explanation:
        'Zuerst werden Lösungen genutzt, die weder Geld noch Termin kosten (Verschieben im Puffer, Umverteilen). Danach folgen zusätzliche Kapazität oder - in Absprache mit dem Auftraggeber - Termin- oder Umfangsänderungen.',
  ),
  einfach(
    'a1-tr-7',
    't-ressourcen',
    scenario:
        'Ein Softwareprojekt liegt drei Wochen hinter dem Plan. Die Leitung will kurzfristig vier neue Entwickler hinzuholen, die das System noch nicht kennen.',
    prompt: 'Womit ist zunächst zu rechnen?',
    choices: [
      ja(
        'Das Projekt wird zunächst eher langsamer, weil Einarbeitung und Abstimmung Zeit kosten.',
        'Das beschreibt das Brookssche Gesetz.',
      ),
      nein(
        'Der Verzug ist sofort aufgeholt.',
        'Neue Leute brauchen Einarbeitung - oft durch die erfahrenen Entwickler.',
      ),
      nein(
        'Der Aufwand in Personentagen sinkt.',
        'Der Aufwand bleibt mindestens gleich, durch Einarbeitung steigt er sogar.',
      ),
      nein(
        'Die Verfügbarkeit der bisherigen Entwickler steigt.',
        'Sie sinkt eher, weil sie die neuen einarbeiten.',
      ),
    ],
    explanation:
        'Mehr Personal senkt die Dauer nur, wenn sich die Arbeit sauber aufteilen lässt und die Einarbeitung kurz ist. In verspäteten Softwareprojekten verzögert zusätzliches Personal zunächst weiter (Brookssches Gesetz).',
  ),

  // ======================================= Der Risikomanagement-Prozess
  reihenfolge(
    'a1-rp-1',
    'r-prozess',
    prompt:
        'Bringe die Schritte des Risikomanagements in die richtige Reihenfolge.',
    items: [
      'Risiken identifizieren',
      'Risiken bewerten',
      'Maßnahmen planen',
      'Risiken überwachen',
    ],
    explanation:
        'Ein Kreislauf: Nach dem Überwachen beginnt die Identifikation neuer Risiken von vorn.',
  ),
  markieren(
    'a1-rp-2',
    'r-prozess',
    scenario:
        'Im Kick-off einer Serverumstellung wurden Einträge für das Risikoregister gesammelt. Einige davon sind bereits eingetreten.',
    prompt:
        'Markieren Sie alle Einträge, die kein Risiko, sondern ein Problem beschreiben.',
    zeilen: [
      nein(
        'Der einzige Datenbankexperte könnte während der Migration krank werden.',
        'Ein mögliches künftiges Ereignis - also ein Risiko.',
      ),
      ja(
        'Die Lizenzschlüssel wurden nicht geliefert.',
        'Bereits eingetreten - ein Problem.',
      ),
      nein(
        'Die Schnittstelle zum ERP-System ist möglicherweise inkompatibel.',
        'Noch ungewiss - ein Risiko.',
      ),
      ja(
        'Zwei Entwickler sind seit Montag krank.',
        'Bereits eingetreten - ein Problem.',
      ),
      ja(
        'Das Budget ist bereits um 10 % überschritten.',
        'Bereits eingetreten - ein Problem.',
      ),
      nein(
        'Die Fachabteilung könnte die Schulung absagen.',
        'Kann eintreten, muss aber nicht - ein Risiko.',
      ),
    ],
    explanation:
        'Ein Risiko liegt in der Zukunft und kann eintreten. Ein Problem ist bereits eingetreten - es gehört in die Problembehandlung, nicht ins Risikoregister.',
  ),
  freitext(
    'a1-rp-3',
    'r-prozess',
    scenario:
        'Für ein Migrationsprojekt wird ein Risikoregister angelegt. Die Vorlage soll alle nötigen Spalten enthalten.',
    prompt:
        'Nennen Sie vier Angaben, die das Risikoregister zu jedem Risiko enthält. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Beschreibung und Ursache des Risikos',
        stichwoerter: ['Beschreibung', 'Ursache', 'Bezeichnung'],
      ),
      krit(
        'Eintrittswahrscheinlichkeit',
        stichwoerter: [
          'Wahrscheinlichkeit',
          'Eintrittswahrscheinlichkeit',
          'wahrscheinlich',
        ],
      ),
      krit(
        'Schadenshöhe bzw. Auswirkung',
        stichwoerter: ['Schaden', 'Schadenshöhe', 'Auswirkung'],
      ),
      krit(
        'Risikowert bzw. Priorität',
        stichwoerter: ['Risikowert', 'Priorität', 'Kennzahl'],
      ),
      krit(
        'Geplante Maßnahme',
        stichwoerter: ['Maßnahme', 'Gegenmaßnahme', 'Strategie'],
      ),
      krit(
        'Verantwortliche Person (Risikoeigner)',
        stichwoerter: ['verantwortlich', 'Risikoeigner', 'zuständig'],
      ),
      krit(
        'Status und Frühwarnindikator',
        stichwoerter: ['Status', 'Frühwarnindikator', 'Indikator'],
      ),
    ],
    loesung:
        'Beschreibung mit Ursache, Eintrittswahrscheinlichkeit, Schadenshöhe und die geplante Maßnahme. Dazu kommen Risikowert, verantwortliche Person und Status.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Das Register dokumentiert jedes Risiko mit Bewertung, Maßnahme, Verantwortlichem und Status.',
  ),
  zuordnen(
    'a1-rp-4',
    'r-prozess',
    prompt: 'Ordne jedes Risiko der passenden Risikoart zu.',
    buckets: ['technisch', 'personell', 'terminlich', 'rechtlich'],
    items: [
      zu(
        'Die neue Schnittstelle zum ERP-System könnte nicht funktionieren.',
        0,
        'Die Ursache liegt in der Technik.',
      ),
      zu(
        'Der einzige Datenbankexperte könnte kündigen.',
        1,
        'Die Ursache liegt bei einer Person.',
      ),
      zu(
        'Der Lieferant könnte die Server zu spät liefern.',
        2,
        'Gefährdet ist vor allem der Zeitplan.',
      ),
      zu(
        'Die geplante Cloud-Lösung könnte gegen die DSGVO verstoßen.',
        3,
        'Es geht um die Einhaltung von Gesetzen.',
      ),
      zu(
        'Die neue Hardware könnte mit dem Betriebssystem inkompatibel sein.',
        0,
        'Ein technisches Zusammenspiel ist unsicher.',
      ),
      zu(
        'Während der Urlaubszeit könnte das Team unterbesetzt sein.',
        1,
        'Es fehlen Personen.',
      ),
    ],
    explanation:
        'Wer Risiken nach Arten sammelt - technisch, personell, wirtschaftlich, organisatorisch, terminlich, rechtlich -, übersieht weniger. Eingeordnet wird nach der Ursache bzw. dem Hauptbereich der Gefährdung.',
  ),
  einfach(
    'a1-rp-5',
    'r-prozess',
    prompt:
        'Welche Risikobeschreibung ist für das Risikoregister am besten geeignet?',
    choices: [
      ja(
        'Weil nur ein Admin die Firewall kennt, könnte bei seinem Ausfall die Umstellung stocken, sodass sich der Go-live verschiebt.',
        'Ursache, Ereignis und Auswirkung sind genannt - das Risiko lässt sich bewerten und gezielt behandeln.',
      ),
      nein(
        'Das Projekt könnte scheitern.',
        'Viel zu ungenau - daraus lässt sich keine Maßnahme ableiten.',
      ),
      nein(
        'Der Admin ist krank.',
        'Das ist bereits eingetreten, also ein Problem.',
      ),
      nein('Firewall', 'Ein Stichwort ist keine Risikobeschreibung.'),
    ],
    explanation:
        'Ein gut beschriebenes Risiko folgt dem Muster „Weil (Ursache) könnte (Ereignis), sodass (Auswirkung)“. Erst dann lassen sich Wahrscheinlichkeit und Schaden sinnvoll schätzen.',
  ),
  freitext(
    'a1-rp-6',
    'r-prozess',
    scenario:
        'Vor dem Start eines Rechenzentrumsumzugs sollen möglichst viele Risiken gefunden werden.',
    prompt:
        'Nennen Sie drei Methoden, mit denen sich Risiken identifizieren lassen. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Brainstorming im Projektteam',
        stichwoerter: ['Brainstorming', 'Workshop', 'Ideensammlung'],
      ),
      krit(
        'Checklisten aus früheren Projekten',
        stichwoerter: ['Checkliste', 'Checklisten', 'Prüfliste'],
      ),
      krit(
        'Befragung von Fachleuten',
        stichwoerter: ['Befragung', 'Experten', 'Fachleute', 'Interview'],
      ),
      krit(
        'Auswertung von Lessons Learned früherer Projekte',
        stichwoerter: ['Lessons Learned', 'Erfahrungen', 'frühere Projekte'],
      ),
    ],
    loesung:
        'Brainstorming im Projektteam, Checklisten aus früheren Projekten und die Befragung von Fachleuten. Auch die Auswertung von Lessons Learned hilft.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Kein Verfahren findet alle Risiken. Deshalb kombiniert man Kreativität (Brainstorming), Erfahrung (Checklisten, Lessons Learned) und Fachwissen (Befragungen).',
  ),
  freitext(
    'a1-rp-7',
    'r-prozess',
    scenario:
        'Im Risikoregister eines Rollout-Projekts gibt es die Spalte „Frühwarnindikator“. Ein neues Teammitglied fragt nach ihrem Zweck.',
    prompt:
        'Erläutern Sie, wozu ein Frühwarnindikator dient, und nennen Sie ein Beispiel. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Er zeigt frühzeitig an, dass ein Risiko wahrscheinlicher wird oder bald eintreten könnte.',
        punkte: 2,
        stichwoerter: [
          'frühzeitig',
          'rechtzeitig',
          'Anzeichen',
          'wahrscheinlicher',
          'bevorsteht',
        ],
      ),
      krit(
        'So bleibt Zeit, die vorbereitete Maßnahme zu starten.',
        stichwoerter: ['Maßnahme', 'reagieren', 'gegensteuern', 'einleiten'],
      ),
      krit(
        'Beispiel: Der Lieferant bestätigt den Liefertermin nicht.',
        stichwoerter: [
          'Lieferant',
          'Liefertermin',
          'Krankmeldungen',
          'Überstunden',
          'Ist-Kosten',
        ],
      ),
    ],
    loesung:
        'Ein Frühwarnindikator ist ein beobachtbares Anzeichen dafür, dass ein Risiko wahrscheinlicher wird. So kann die vorbereitete Maßnahme rechtzeitig gestartet werden. Beispiel: Der Lieferant bestätigt den Liefertermin nicht - Hinweis auf drohenden Lieferverzug.',
    explanation:
        'Zweck 2 Punkte, Beispiel 1 Punkt. Beim Überwachen beobachtet der Risikoeigner die Frühwarnindikatoren; schlagen sie an, wird die geplante Maßnahme ausgelöst.',
  ),

  // =========================================================== Risiken bewerten
  rechnen(
    'a1-rb-1',
    'r-bewertung',
    prompt:
        'Ein Risiko tritt mit 25 % Wahrscheinlichkeit ein und verursacht dann 36.000 € Schaden. Wie hoch ist der Risikowert?',
    answer: 9000,
    unit: '€',
    explanation:
        'Risikowert = Wahrscheinlichkeit × Schaden = 0,25 × 36.000 € = 9.000 €.',
  ),
  einfach(
    'a1-rb-2',
    'r-bewertung',
    scenario:
        'R1: 10 % Wahrscheinlichkeit, 80.000 € Schaden\n'
        'R2: 40 % Wahrscheinlichkeit, 15.000 € Schaden\n'
        'R3: 60 % Wahrscheinlichkeit, 5.000 € Schaden',
    prompt: 'Welches Risiko sollte zuerst behandelt werden?',
    choices: [
      ja('R1', 'Höchster Risikowert: 0,10 × 80.000 € = 8.000 €.'),
      nein('R2', 'Risikowert 6.000 € - an zweiter Stelle.'),
      nein('R3', 'Zwar am wahrscheinlichsten, aber nur 3.000 € Risikowert.'),
      nein(
        'Alle drei gleichzeitig, weil sie gleich wichtig sind',
        'Die Risikowerte unterscheiden sich deutlich.',
      ),
    ],
    explanation:
        'Priorisiert wird nach dem Risikowert, nicht nach der Wahrscheinlichkeit allein: R1 8.000 €, R2 6.000 €, R3 3.000 €.',
  ),
  rechnen(
    'a1-rb-3',
    'r-bewertung',
    scenario:
        'In einer 3×3-Risikomatrix werden Wahrscheinlichkeit und Auswirkung mit 1 (gering), 2 (mittel) und 3 (hoch) bewertet. Die Risikokennzahl ist das Produkt beider Stufen.',
    prompt:
        'Ein Risiko hat eine hohe Eintrittswahrscheinlichkeit und eine mittlere Auswirkung. Wie hoch ist die Risikokennzahl?',
    answer: 6,
    difficulty: 1,
    explanation:
        'Wahrscheinlichkeit hoch = 3, Auswirkung mittel = 2.\n'
        'Risikokennzahl = 3 × 2 = 6.\n'
        'Mit 6 liegt das Risiko im roten Bereich (6 bis 9) - es braucht sofort eine Maßnahme.',
  ),
  rechnen(
    'a1-rb-4',
    'r-bewertung',
    scenario:
        'Ein Hardwaredefekt tritt mit 25 % Wahrscheinlichkeit ein und verursacht dann 60.000 € Schaden. Ein Wartungsvertrag für 7.000 € senkt die Wahrscheinlichkeit auf 10 %.',
    prompt: 'Um wie viel Euro senkt der Wartungsvertrag den Risikowert?',
    answer: 9000,
    unit: '€',
    explanation:
        'Risikowert vorher: 0,25 × 60.000 € = 15.000 €\n'
        'Risikowert nachher: 0,10 × 60.000 € = 6.000 €\n'
        'Senkung: 15.000 € - 6.000 € = 9.000 €\n'
        'Da 9.000 € Nutzen mehr sind als 7.000 € Kosten, lohnt sich der Vertrag wirtschaftlich.',
  ),
  einfach(
    'a1-rb-5',
    'r-bewertung',
    scenario:
        'Die Risikomatrix zeigt waagerecht die Eintrittswahrscheinlichkeit und senkrecht die Auswirkung.',
    skizze: const QuadrantenDiagramm(
      xAchse: 'Eintrittswahrscheinlichkeit',
      yAchse: 'Auswirkung',
      obenLinks: Quadrant('oben links'),
      obenRechts: Quadrant('oben rechts'),
      untenLinks: Quadrant('unten links'),
      untenRechts: Quadrant('unten rechts'),
    ),
    prompt:
        'Ein totaler Datenverlust im Rechenzentrum ist sehr unwahrscheinlich, würde aber das Unternehmen gefährden. Wo liegt dieses Risiko?',
    choices: [
      ja(
        'oben links',
        'Geringe Wahrscheinlichkeit (links), sehr hohe Auswirkung (oben).',
      ),
      nein('oben rechts', 'Dort liegen Risiken, die auch häufig eintreten.'),
      nein('unten links', 'Dort liegen seltene Risiken mit kleinem Schaden.'),
      nein('unten rechts', 'Dort liegen häufige Risiken mit kleinem Schaden.'),
    ],
    explanation:
        'Die Lage ergibt sich aus beiden Achsen: selten = links, schwer = oben. Solche Risiken bekommen trotz kleinem Risikowert eine Maßnahme, typisch ist das Übertragen (Versicherung) plus Vorsorge wie Backups.',
  ),
  einfach(
    'a1-rb-6',
    'r-bewertung',
    scenario:
        'Risiko A: 50 % Wahrscheinlichkeit, 4.000 € Schaden.\nRisiko B: 2 % Wahrscheinlichkeit, 100.000 € Schaden.',
    prompt: 'Welche Aussage ist richtig?',
    choices: [
      ja(
        'Beide haben einen Risikowert von 2.000 €; B verdient wegen des hohen Einzelschadens trotzdem besondere Beachtung.',
        'Gleicher Erwartungswert, aber ein Eintritt von B wäre ungleich schwerer zu verkraften.',
      ),
      nein(
        'A ist wichtiger, weil es wahrscheinlicher ist.',
        'Priorisiert wird nach dem Produkt, nicht nach der Wahrscheinlichkeit allein.',
      ),
      nein(
        'B hat den höheren Risikowert.',
        '0,02 × 100.000 € = 2.000 € - genau wie A.',
      ),
      nein(
        'Beide können ignoriert werden, weil ihr Risikowert klein ist.',
        'Auch kleine Risikowerte werden bewusst behandelt, B könnte existenzgefährdend sein.',
      ),
    ],
    difficulty: 3,
    explanation:
        'A: 0,50 × 4.000 € = 2.000 €. B: 0,02 × 100.000 € = 2.000 €. Die Rechnung macht beide gleich - hier zeigt sich die Schwäche des Risikowerts: Seltene, aber schwere Risiken muss man gesondert betrachten.',
  ),
  rechnen(
    'a1-rb-7',
    'r-bewertung',
    scenario:
        'R1: 15 % Wahrscheinlichkeit, 20.000 € Schaden\n'
        'R2: 5 % Wahrscheinlichkeit, 90.000 € Schaden\n'
        'R3: 30 % Wahrscheinlichkeit, 8.000 € Schaden',
    prompt: 'Wie hoch ist der größte der drei Risikowerte?',
    answer: 4500,
    unit: '€',
    explanation:
        'R1: 0,15 × 20.000 € = 3.000 €\n'
        'R2: 0,05 × 90.000 € = 4.500 €\n'
        'R3: 0,30 × 8.000 € = 2.400 €\n'
        'Größter Wert: R2 mit 4.500 € - obwohl es das unwahrscheinlichste Risiko ist.',
  ),

  // =========================================================== Risikostrategien
  einfach(
    'a1-rs-1',
    'r-strategien',
    scenario:
        'Das Team verzichtet auf ein neues, noch unerprobtes Framework und nutzt stattdessen das bewährte.',
    prompt: 'Welche Risikostrategie wird angewendet?',
    choices: [
      ja('Vermeiden', 'Die riskante Ursache wird nicht eingegangen.'),
      nein(
        'Vermindern',
        'Dann würde man das neue Framework nutzen, aber z. B. mit Schulung absichern.',
      ),
      nein('Übertragen', 'Dabei würden die Folgen auf Dritte verlagert.'),
      nein(
        'Akzeptieren',
        'Dann würde man das Framework bewusst trotz Risiko einsetzen.',
      ),
    ],
    explanation:
        'Wer auf die risikobehaftete Tätigkeit ganz verzichtet, vermeidet das Risiko.',
  ),
  zuordnen(
    'a1-rs-2',
    'r-strategien',
    prompt: 'Ordne jede Maßnahme der passenden Risikostrategie zu.',
    buckets: ['Vermeiden', 'Vermindern', 'Übertragen', 'Akzeptieren'],
    items: [
      zu(
        'Die Datenmigration wird vorher an einer Kopie der Datenbank geprobt.',
        1,
        'Ein Fehlschlag wird unwahrscheinlicher, bleibt aber möglich.',
      ),
      zu(
        'Statt ein eigenes Verschlüsselungsverfahren zu entwickeln, wird ein etabliertes genutzt.',
        0,
        'Die riskante Eigenentwicklung entfällt ganz.',
      ),
      zu(
        'Der Transport der Server wird versichert.',
        2,
        'Den finanziellen Schaden trägt die Versicherung.',
      ),
      zu(
        'Dass ein Monitor beim Aufbau zerkratzt, wird ohne Maßnahme hingenommen.',
        3,
        'Kleiner Schaden, bewusst getragen.',
      ),
      zu(
        'Zwei weitere Admins werden in die Firewall-Konfiguration eingearbeitet.',
        1,
        'Der Ausfall einer Person wiegt weniger schwer.',
      ),
      zu(
        'Die Wartung geht mit Reaktionszeiten und Vertragsstrafe an einen Dienstleister.',
        2,
        'Die Folgen eines Ausfalls trägt vertraglich der Dienstleister mit.',
      ),
    ],
    explanation:
        'Testfrage: Kann das Risiko danach noch eintreten? Nein -> vermeiden. Ja, aber seltener oder milder -> vermindern. Ja, aber ein Dritter trägt die Folgen -> übertragen. Ja, und man trägt es bewusst -> akzeptieren.',
  ),
  lueckentext(
    'a1-rs-3',
    'r-strategien',
    scenario:
        'Mit einer einfachen Testfrage lässt sich jede Maßnahme einer Risikostrategie zuordnen: Kann das Risiko danach noch eintreten?',
    prompt: 'Wählen Sie zu jeder Beschreibung die passende Strategie.',
    text:
        'Das Risiko kann nicht mehr eintreten, weil die Ursache entfällt: {0}.\n'
        'Es kann noch eintreten, aber seltener oder mit kleinerem Schaden: {1}.\n'
        'Es kann noch eintreten, die finanziellen Folgen trägt ein Dritter: {2}.\n'
        'Es kann noch eintreten und wird bewusst ohne Maßnahme getragen: {3}.',
    luecken: [
      wahl('Vermeiden', ['Vermindern', 'Übertragen', 'Akzeptieren']),
      wahl('Vermindern', ['Vermeiden', 'Übertragen', 'Akzeptieren']),
      wahl('Übertragen', ['Vermeiden', 'Vermindern', 'Akzeptieren']),
      wahl('Akzeptieren', ['Vermeiden', 'Vermindern', 'Übertragen']),
    ],
    difficulty: 1,
    explanation:
        'Vermindern senkt Wahrscheinlichkeit oder Auswirkung, beseitigt das Risiko aber nicht. Beim Vermeiden ist die Ursache weg, das Risiko kann nicht mehr eintreten. Übertragen ändert, wer den Schaden trägt; Akzeptieren heißt bewusst nichts tun.',
  ),
  rechnen(
    'a1-rs-4',
    'r-strategien',
    scenario:
        'Ein Risiko tritt mit 30 % Wahrscheinlichkeit ein und kostet dann 50.000 €. Eine Schulung senkt die Wahrscheinlichkeit auf 10 %, ein Notfallplan senkt den Schaden auf 30.000 €.',
    prompt: 'Wie hoch ist das Restrisiko (Risikowert nach beiden Maßnahmen)?',
    answer: 3000,
    unit: '€',
    explanation:
        'Vorher: 0,30 × 50.000 € = 15.000 €.\n'
        'Nachher wirken beide Maßnahmen zusammen: 0,10 × 30.000 € = 3.000 €.\n'
        'Das Restrisiko von 3.000 € wird neu eingestuft und z. B. bewusst akzeptiert.',
  ),
  freitext(
    'a1-rs-5',
    'r-strategien',
    scenario:
        'Für die Lieferung neuer Server wurde eine Transportversicherung abgeschlossen. Ein Teammitglied schlägt vor, das Risiko „Transportschaden“ aus dem Risikoregister zu streichen.',
    prompt:
        'Erläutern Sie zwei Gründe, warum das Risiko trotz Versicherung weiter überwacht wird. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Die Versicherung verhindert den Schaden nicht - das Ereignis kann mit gleicher Wahrscheinlichkeit eintreten.',
        punkte: 2,
        stichwoerter: [
          'verhindert nicht',
          'weiterhin eintreten',
          'Wahrscheinlichkeit bleibt',
          'trotzdem eintreten',
        ],
      ),
      krit(
        'Der Terminverzug bleibt im Projekt: Beschädigte Server müssen neu beschafft werden.',
        punkte: 2,
        stichwoerter: ['Termin', 'Verzug', 'Verzögerung', 'Zeitplan'],
      ),
      krit(
        'Nicht alle Folgen sind gedeckt, etwa Selbstbeteiligung oder Ansehensverlust beim Kunden.',
        punkte: 2,
        stichwoerter: [
          'Selbstbeteiligung',
          'Ansehen',
          'Image',
          'nicht gedeckt',
        ],
      ),
    ],
    loesung:
        'Die Versicherung ersetzt nur den finanziellen Schaden - der Transportschaden selbst kann genauso wahrscheinlich eintreten wie vorher. Tritt er ein, verzögert sich das Projekt trotzdem, weil die Server neu beschafft werden müssen.',
    explanation:
        'Je Grund 2 Punkte, höchstens 4. Übertragen verlagert den finanziellen Schaden, nicht das Ereignis - deshalb kombiniert man Übertragen oft mit Vermindern.',
  ),
  zuordnen(
    'a1-rs-6',
    'r-strategien',
    scenario:
        'Für das Risiko „Ausfall des zentralen Servers“ wurden sechs Maßnahmen gesammelt.',
    prompt:
        'Wirkt die Maßnahme präventiv (vor dem Eintritt) oder korrektiv (nach dem Eintritt)?',
    buckets: ['präventiv', 'korrektiv'],
    items: [
      zu(
        'Wiederanlaufplan, der nach einem Ausfall abgearbeitet wird',
        1,
        'Er greift erst nach dem Eintritt und begrenzt den Schaden.',
      ),
      zu(
        'Zweiten Administrator einarbeiten',
        0,
        'Senkt die Wahrscheinlichkeit eines Engpasses.',
      ),
      zu(
        'Server mit redundanten Netzteilen kaufen',
        0,
        'Der Ausfall wird unwahrscheinlicher.',
      ),
      zu(
        'Datensicherung auf den Ersatzserver zurückspielen',
        1,
        'Wird erst nach dem Ausfall ausgeführt.',
      ),
      zu(
        'Sicherheitsupdates regelmäßig einspielen',
        0,
        'Beugt Ausfällen durch Schwachstellen vor.',
      ),
      zu(
        'Betroffene Abteilungen über den Ausfall informieren',
        1,
        'Teil des Notfallplans nach dem Eintritt.',
      ),
    ],
    explanation:
        'Präventive Maßnahmen wirken vor dem Eintritt und senken die Wahrscheinlichkeit. Korrektive Maßnahmen (Notfallpläne) sind vorbereitet und greifen erst, wenn das Risiko eingetreten ist.',
  ),

  // ============================================== Projektkosten kalkulieren
  rechnen(
    'a1-wk-1',
    'w-kalkulation',
    prompt:
        'Ein Mitarbeiter kostet das Unternehmen 54.000 € pro Jahr und hat 1.350 produktive Stunden. Wie hoch ist sein Stundensatz?',
    answer: 40,
    unit: '€/h',
    explanation:
        'Stundensatz = Jahreskosten / produktive Stunden = 54.000 € / 1.350 h = 40 €/h.',
  ),
  rechnen(
    'a1-wk-2',
    'w-kalkulation',
    prompt:
        'Listenpreis 2.500 €, 8 % Rabatt, 3 % Skonto, 45 € Bezugskosten. Wie hoch ist der Bezugspreis? (zwei Nachkommastellen)',
    answer: 2276,
    tolerance: 0.01,
    unit: '€',
    explanation:
        'Listenpreis 2.500,00 €\n'
        '- 8 % Rabatt = 200,00 € -> Zieleinkaufspreis 2.300,00 €\n'
        '- 3 % Skonto vom Zieleinkaufspreis = 69,00 € -> Bareinkaufspreis 2.231,00 €\n'
        '+ Bezugskosten 45,00 € -> Bezugspreis 2.276,00 €',
  ),
  rechnen(
    'a1-wk-3',
    'w-kalkulation',
    scenario:
        'Ein Administrator verdient 52.000 € brutto im Jahr, der Arbeitgeber zahlt zusätzlich 22 % Lohnnebenkosten. Von 250 Arbeitstagen fallen 30 Tage Urlaub, 8 Tage Krankheit und 12 Tage Weiterbildung weg. Ein Arbeitstag hat 8 Stunden.',
    prompt: 'Wie hoch ist sein Stundensatz? (zwei Nachkommastellen)',
    answer: 39.65,
    tolerance: 0.01,
    unit: '€/h',
    difficulty: 3,
    explanation:
        'Personalkosten: 52.000 € × 1,22 = 63.440 €\n'
        'Produktive Tage: 250 - 30 - 8 - 12 = 200 Tage\n'
        'Produktive Stunden: 200 × 8 h = 1.600 h\n'
        'Stundensatz: 63.440 € / 1.600 h = 39,65 €/h',
  ),
  rechnen(
    'a1-wk-4',
    'w-kalkulation',
    scenario:
        'Für ein Kundenprojekt sind 80 Stunden zu je 45 € geplant. Der Gemeinkostenzuschlag beträgt 60 % auf die Personalkosten, dazu kommen 1.200 € Sachkosten. Kalkuliert wird mit 12 % Gewinnzuschlag auf die Selbstkosten.',
    prompt: 'Wie hoch ist der Nettoangebotspreis? (zwei Nachkommastellen)',
    answer: 7795.2,
    tolerance: 0.01,
    unit: '€',
    difficulty: 3,
    explanation:
        'Personalkosten: 80 h × 45 €/h = 3.600,00 €\n'
        '+ Gemeinkosten 60 %: 3.600 € × 0,6 = 2.160,00 €\n'
        '+ Sachkosten: 1.200,00 €\n'
        '= Selbstkosten: 6.960,00 €\n'
        '+ Gewinn 12 %: 6.960 € × 0,12 = 835,20 €\n'
        '= Nettoangebotspreis: 7.795,20 €',
  ),
  rechnen(
    'a1-wk-5',
    'w-kalkulation',
    scenario:
        'Angebot A: Listenpreis 4.800 €, 5 % Rabatt, 2 % Skonto, Lieferung frei Haus.\n'
        'Angebot B: Listenpreis 4.600 €, kein Rabatt, 3 % Skonto, 80 € Versandkosten.\n'
        'In beiden Fällen wird Skonto genutzt.',
    prompt:
        'Um wie viel Euro ist das günstigere Angebot billiger als das andere? (zwei Nachkommastellen)',
    answer: 73.2,
    tolerance: 0.01,
    unit: '€',
    difficulty: 3,
    explanation:
        'A: 4.800 € - 5 % (240 €) = 4.560 €; - 2 % Skonto (91,20 €) = 4.468,80 €; + 0 € = 4.468,80 €\n'
        'B: 4.600 € - 3 % Skonto (138 €) = 4.462,00 €; + 80 € = 4.542,00 €\n'
        'A ist günstiger: 4.542,00 € - 4.468,80 € = 73,20 €.\n'
        'Obwohl B den niedrigeren Listenpreis hat, gewinnt A - erst der Bezugspreis zeigt das.',
  ),
  zuordnen(
    'a1-wk-6',
    'w-kalkulation',
    prompt:
        'Handelt es sich um Einzelkosten des Projekts oder um Gemeinkosten?',
    buckets: ['Einzelkosten des Projekts', 'Gemeinkosten'],
    items: [
      zu(
        'Stunden der Projektmitarbeiter laut Zeiterfassung',
        0,
        'Direkt dem Projekt zurechenbar.',
      ),
      zu(
        'Für das Projekt gekaufte Switches',
        0,
        'Nur für dieses Projekt beschafft.',
      ),
      zu('Miete für das Bürogebäude', 1, 'Fällt für das ganze Unternehmen an.'),
      zu(
        'Gehalt der Buchhaltung',
        1,
        'Unterstützt alle Projekte, wird über Zuschlag verteilt.',
      ),
      zu(
        'Lizenz, die nur für dieses Projekt beschafft wird',
        0,
        'Eindeutig dem Projekt zuzuordnen.',
      ),
      zu(
        'Strom für das gesamte Rechenzentrum',
        1,
        'Nicht direkt einem Projekt zurechenbar.',
      ),
    ],
    explanation:
        'Einzelkosten lassen sich einem Projekt direkt zuordnen (Projektstunden, projektbezogener Einkauf). Gemeinkosten fallen für das ganze Unternehmen an und werden über einen Zuschlagssatz anteilig verrechnet.',
  ),
  paare(
    'a1-wk-7',
    'w-kalkulation',
    scenario:
        'Ein Systemhaus kalkuliert jedes Kundenprojekt zu drei Zeitpunkten.',
    prompt: 'Ordnen Sie jeder Kalkulation Zeitpunkt und Zweck zu.',
    paare: [
      paar('Vorkalkulation', 'Vor dem Projekt: Angebot und Budget'),
      paar('Mitkalkulation', 'Im Projekt: laufender Soll-Ist-Vergleich'),
      paar('Nachkalkulation', 'Nach dem Projekt: Abgleich mit echten Kosten'),
    ],
    difficulty: 1,
    explanation:
        'Vorkalkulation (vorher, für Angebot und Budget), Mitkalkulation (während, zur Steuerung), Nachkalkulation (danach, zum Abgleich mit den echten Kosten und als Lernquelle).',
  ),

  // ============================================================ Nutzwertanalyse
  markieren(
    'a1-wn-1',
    'w-nutzwert',
    scenario:
        'Ein Auszubildender hat für die Auswahl eines Cloud-Speichers eine Nutzwertanalyse erstellt und beschreibt sein Vorgehen.',
    prompt:
        'Markieren Sie alle Aussagen, die einen Fehler in der Nutzwertanalyse beschreiben.',
    zeilen: [
      ja(
        'Die Gewichte ergeben zusammen 120 %.',
        'Die Gewichte müssen genau 100 % ergeben.',
      ),
      nein(
        'Die Kriterien sind unterschiedlich gewichtet.',
        'Das ist der Sinn der Gewichtung.',
      ),
      ja(
        'Die Punkte wurden ohne Gewichtung addiert.',
        'Dann hätten alle Kriterien dasselbe Gewicht.',
      ),
      nein(
        'Es wurden vier Alternativen verglichen.',
        'Beliebig viele Alternativen sind möglich.',
      ),
      ja(
        'Ein Anbieter verfehlt ein Muss-Kriterium und wurde trotzdem gewählt.',
        'Muss-Kriterien sind K.-o.-Kriterien und werden vorab geprüft.',
      ),
      ja(
        'Der teuerste Anbieter bekam beim Preis die meisten Punkte.',
        'Höher ist immer besser: Der günstigste Anbieter erhält beim Preis die meisten Punkte.',
      ),
    ],
    explanation:
        'Gewichte summieren sich zu 100 %, Punkte werden mit dem Gewicht multipliziert, Muss-Kriterien werden vorab geprüft. Auf der Punkteskala ist höher immer besser - auch beim Preis.',
  ),
  rechnen(
    'a1-wn-2',
    'w-nutzwert',
    scenario:
        'Kriterien und Gewichte: Funktionsumfang 50 %, Preis 30 %, Support 20 %.\n'
        'Anbieter X erhält auf einer Skala von 0 bis 10: Funktionsumfang 7, Preis 9, Support 5.',
    prompt: 'Wie hoch ist der Nutzwert von Anbieter X? (eine Nachkommastelle)',
    answer: 7.2,
    tolerance: 0.01,
    unit: 'Punkte',
    explanation:
        'Funktionsumfang: 0,50 × 7 = 3,5\n'
        'Preis: 0,30 × 9 = 2,7\n'
        'Support: 0,20 × 5 = 1,0\n'
        'Nutzwert: 3,5 + 2,7 + 1,0 = 7,2 Punkte',
  ),
  einfach(
    'a1-wn-3',
    'w-nutzwert',
    scenario:
        'Gewichte: Sicherheit 40 %, Preis 35 %, Bedienung 25 %. Skala 0 bis 10.\n'
        'Anbieter P: Sicherheit 6, Preis 9, Bedienung 8.\n'
        'Anbieter Q: Sicherheit 9, Preis 5, Bedienung 7.',
    prompt: 'Welcher Anbieter hat den höheren Nutzwert?',
    choices: [
      ja(
        'P mit 7,55 Punkten',
        '0,40 × 6 + 0,35 × 9 + 0,25 × 8 = 2,40 + 3,15 + 2,00 = 7,55.',
      ),
      nein('Q mit 7,10 Punkten', 'Q erreicht 7,10, liegt damit aber hinter P.'),
      nein(
        'Q, weil er bei der Sicherheit mit dem höchsten Gewicht vorn liegt',
        'Das stärkste Kriterium allein entscheidet nicht - es zählt die Summe.',
      ),
      nein(
        'Beide liegen gleichauf',
        'P 7,55 und Q 7,10 unterscheiden sich um 0,45 Punkte.',
      ),
    ],
    explanation:
        'P: 2,40 + 3,15 + 2,00 = 7,55. Q: 0,40 × 9 + 0,35 × 5 + 0,25 × 7 = 3,60 + 1,75 + 1,75 = 7,10. P gewinnt, weil sein Vorsprung beim Preis den Rückstand bei der Sicherheit mehr als ausgleicht.',
  ),
  rechnen(
    'a1-wn-4',
    'w-nutzwert',
    scenario:
        'Eine Nutzwertanalyse hat drei Kriterien: Preis, Service und Lieferzeit. Preis ist mit 45 %, Service mit 35 % gewichtet.',
    prompt: 'Wie hoch muss das Gewicht der Lieferzeit sein?',
    answer: 20,
    unit: '%',
    difficulty: 1,
    explanation:
        'Die Gewichte ergeben zusammen 100 %: 100 % - 45 % - 35 % = 20 %.',
  ),
  reihenfolge(
    'a1-wn-5',
    'w-nutzwert',
    prompt:
        'Bringe die Schritte der Nutzwertanalyse in die richtige Reihenfolge.',
    items: [
      'Bewertungskriterien festlegen',
      'Kriterien gewichten',
      'Alternativen je Kriterium mit Punkten bewerten',
      'Teilnutzwerte (Gewicht × Punkte) berechnen',
      'Teilnutzwerte zum Nutzwert addieren',
      'Alternative mit dem höchsten Nutzwert wählen',
    ],
    explanation:
        'Kriterien und Gewichte stehen fest, bevor bewertet wird - sonst ließe sich das Ergebnis über die Gewichte steuern. Danach folgen Punkte, Teilnutzwerte, Summe und Entscheidung.',
  ),
  einfach(
    'a1-wn-6',
    'w-nutzwert',
    scenario:
        'Muss-Kriterium: Die Server stehen in der EU.\n'
        'Anbieter A: Nutzwert 8,2, Serverstandort USA.\n'
        'Anbieter B: Nutzwert 7,4, Serverstandort Frankfurt.\n'
        'Anbieter C: Nutzwert 6,9, Serverstandort Wien.',
    prompt: 'Welcher Anbieter wird gewählt?',
    choices: [
      ja(
        'B',
        'A scheidet am K.-o.-Kriterium aus; von B und C hat B den höheren Nutzwert.',
      ),
      nein(
        'A',
        'A verfehlt das Muss-Kriterium und scheidet vor jeder Punktrechnung aus.',
      ),
      nein(
        'C',
        'C erfüllt das Muss-Kriterium, hat aber einen niedrigeren Nutzwert als B.',
      ),
      nein(
        'Keiner, die Analyse muss neu gemacht werden',
        'Zwei Anbieter erfüllen das Muss-Kriterium - die Entscheidung ist möglich.',
      ),
    ],
    explanation:
        'Muss-Kriterien werden vorab als K.-o.-Kriterien geprüft. Wer sie verfehlt, scheidet aus - egal wie hoch sein Nutzwert wäre. Unter den übrigen gewinnt der höchste Nutzwert.',
  ),

  // ================================================================== Make or Buy
  freitext(
    'a1-wm-1',
    'w-makeorbuy',
    scenario:
        'Ein Onlinehändler überlegt, sein Retourenportal selbst zu entwickeln (Make) oder eine fertige Lösung zu kaufen (Buy).',
    prompt:
        'Nennen Sie je zwei Argumente für die Eigenentwicklung und für den Kauf. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Make: Die Lösung passt genau zu den eigenen Abläufen.',
        stichwoerter: [
          'passgenau',
          'maßgeschneidert',
          'individuell',
          'eigene Abläufe',
        ],
      ),
      krit(
        'Make: Das Know-how bleibt im Unternehmen.',
        stichwoerter: ['Know-how', 'Wissen', 'Kompetenz'],
      ),
      krit(
        'Make: Keine Abhängigkeit von einem Anbieter.',
        stichwoerter: ['unabhängig', 'Abhängigkeit', 'Kontrolle'],
      ),
      krit(
        'Buy: Die Lösung ist sofort verfügbar.',
        stichwoerter: ['sofort', 'schnell verfügbar', 'Zeit', 'schneller'],
      ),
      krit(
        'Buy: Geringere Entwicklungskosten.',
        stichwoerter: ['Entwicklungskosten', 'günstiger', 'Kosten'],
      ),
      krit(
        'Buy: Ausgereiftes Produkt, Wartung und Updates liefert der Hersteller.',
        stichwoerter: ['ausgereift', 'erprobt', 'Wartung', 'Updates'],
      ),
    ],
    loesung:
        'Make: Die Lösung passt genau zu den eigenen Abläufen, und das Know-how bleibt im Unternehmen. Buy: Die Lösung ist sofort verfügbar und verursacht geringere Entwicklungskosten.',
    explanation:
        'Je Argument 1 Punkt, höchstens 4. Make punktet mit Passgenauigkeit, Know-how und Unabhängigkeit; Buy mit Geschwindigkeit und geringeren Entwicklungskosten.',
  ),
  rechnen(
    'a1-wm-2',
    'w-makeorbuy',
    prompt:
        'Eine Softwarelösung kostet 12.000 € in der Anschaffung. Pro Jahr fallen 3.000 € für Wartung und Lizenzen an. Wie hoch sind die Gesamtkosten (TCO) bei vier Jahren Nutzung?',
    answer: 24000,
    unit: '€',
    explanation:
        'TCO = Anschaffung + laufende Kosten über die Nutzungsdauer = 12.000 € + 4 × 3.000 € = 24.000 €.',
  ),
  rechnen(
    'a1-wm-3',
    'w-makeorbuy',
    scenario:
        'Eigenfertigung: 9.000 € Fixkosten, danach 15 € je Stück.\nFremdbezug: 45 € je Stück, keine Fixkosten.',
    prompt:
        'Bei welcher Stückzahl sind die Kosten beider Varianten gleich (kritische Menge)?',
    answer: 300,
    unit: 'Stück',
    explanation:
        'Gleichsetzen: 9.000 + 15x = 45x\n'
        '9.000 = 30x\n'
        'x = 9.000 / 30 = 300 Stück\n'
        'Probe: make 9.000 € + 300 × 15 € = 13.500 €, buy 300 × 45 € = 13.500 €.\n'
        'Darunter ist der Fremdbezug günstiger, darüber die Eigenfertigung.',
  ),
  rechnen(
    'a1-wm-4',
    'w-makeorbuy',
    scenario:
        'Variante Kauf: Lizenz 18.000 € einmalig, Wartung 3.000 € pro Jahr.\nVariante SaaS: 700 € pro Monat, alles inklusive.\nNutzungsdauer: 3 Jahre.',
    prompt:
        'Um wie viel Euro ist die günstigere Variante über die Nutzungsdauer billiger?',
    answer: 1800,
    unit: '€',
    explanation:
        'Kauf: 18.000 € + 3 × 3.000 € = 27.000 €\n'
        'SaaS: 700 € × 36 Monate = 25.200 €\n'
        'Differenz: 27.000 € - 25.200 € = 1.800 € zugunsten von SaaS.\n'
        'Wichtig: Monatspreise auf dieselbe Nutzungsdauer hochrechnen.',
  ),
  einfach(
    'a1-wm-5',
    'w-makeorbuy',
    scenario:
        'Das Diagramm zeigt die Kosten von Eigenerstellung (Make: 4.000 € fix + 10 € je Stück) und Fremdbezug (Buy: 30 € je Stück). Benötigt werden 120 Stück.',
    skizze: const GeradenDiagramm(
      xAchse: 'Stück',
      yAchse: 'Kosten in €',
      xMax: 400,
      yMax: 12000,
      geraden: [Gerade('Make', 4000, 10), Gerade('Buy', 0, 30)],
      punkte: [DiagrammPunkt(200, 6000, 'kritische Menge')],
    ),
    prompt: 'Welche Aussage ist richtig?',
    choices: [
      ja(
        'Buy ist günstiger, weil 120 Stück unter der kritischen Menge von 200 Stück liegen.',
        'Make kostet 4.000 € + 1.200 € = 5.200 €, Buy 120 × 30 € = 3.600 €.',
      ),
      nein(
        'Make ist günstiger, weil die Stückkosten niedriger sind.',
        'Bei kleinen Mengen überwiegen die Fixkosten von Make.',
      ),
      nein(
        'Beide Varianten kosten bei 120 Stück gleich viel.',
        'Gleich teuer sind sie erst bei 200 Stück.',
      ),
      nein(
        'Buy ist immer günstiger, weil keine Fixkosten anfallen.',
        'Ab 200 Stück ist Make günstiger.',
      ),
    ],
    explanation:
        'Kritische Menge: 4.000 / (30 - 10) = 200 Stück. Links vom Schnittpunkt liegt die Buy-Gerade unter der Make-Geraden, rechts davon darüber. Bei 120 Stück spart Buy 1.600 €.',
  ),
  zuordnen(
    'a1-wm-6',
    'w-makeorbuy',
    prompt: 'Spricht das Argument eher für Make oder für Buy?',
    buckets: ['spricht für Make', 'spricht für Buy'],
    items: [
      zu(
        'Die Lösung ist ein Wettbewerbsvorteil des Unternehmens.',
        0,
        'Kernkompetenzen gibt man nicht aus der Hand.',
      ),
      zu(
        'Die Lösung wird in vier Wochen gebraucht.',
        1,
        'Ein fertiges Produkt ist sofort verfügbar.',
      ),
      zu(
        'Im Haus fehlen Entwickler mit passendem Know-how.',
        1,
        'Ohne Know-how ist Eigenentwicklung riskant.',
      ),
      zu(
        'Die Abläufe sind so speziell, dass Standardsoftware sie nicht abbildet.',
        0,
        'Nur eine Eigenentwicklung passt genau.',
      ),
      zu(
        'Es gibt ein bewährtes Standardprodukt mit großem Anwenderkreis.',
        1,
        'Ausgereift, gepflegt, günstig durch viele Kunden.',
      ),
      zu(
        'Die Abhängigkeit von einem Anbieter soll vermieden werden.',
        0,
        'Mit Make behält man die Kontrolle.',
      ),
    ],
    explanation:
        'Make: Kernkompetenz, sehr spezielle Anforderungen, Unabhängigkeit, vorhandenes Know-how. Buy: Zeitdruck, fehlendes Know-how, ausgereifte Standardprodukte, geringere Entwicklungskosten.',
  ),
  paare(
    'a1-wm-7',
    'w-makeorbuy',
    scenario:
        'Vor einer Make-or-Buy-Entscheidung prüft eine Machbarkeitsanalyse, ob ein Weg überhaupt gangbar ist.',
    prompt: 'Ordnen Sie jeder Art der Machbarkeit ihre Leitfrage zu.',
    paare: [
      paar('technisch', 'Mit vorhandener Technik umsetzbar?'),
      paar('wirtschaftlich', 'Übersteigt der Nutzen die Kosten?'),
      paar('rechtlich', 'Mit Datenschutz und Lizenzrecht vereinbar?'),
      paar('zeitlich', 'Bis zum geforderten Termin fertig?'),
      paar('organisatorisch', 'Passen Personal und Abläufe dazu?'),
    ],
    explanation:
        'Die Machbarkeitsanalyse prüft vor der Entscheidung technisch, wirtschaftlich, rechtlich, organisatorisch und zeitlich, ob ein Weg gangbar ist.',
  ),

  // ===================================================== Break-even und Amortisation
  rechnen(
    'a1-wb-1',
    'w-breakeven',
    prompt:
        'Ein Produkt kostet 120 €, die variablen Stückkosten betragen 70 €, die Fixkosten 25.000 €. Ab welcher Menge ist die Gewinnschwelle erreicht?',
    answer: 500,
    unit: 'Stück',
    explanation:
        'Deckungsbeitrag = 120 € - 70 € = 50 €. Break-even-Menge = 25.000 € / 50 € = 500 Stück.',
  ),
  rechnen(
    'a1-wb-2',
    'w-breakeven',
    prompt:
        'Eine Investition kostet 30.000 €. Sie spart jährlich 9.000 €, verursacht aber 1.500 € laufende Kosten pro Jahr. Nach wie vielen Jahren ist sie amortisiert? (eine Nachkommastelle)',
    answer: 4,
    tolerance: 0.05,
    unit: 'Jahre',
    explanation:
        'Rückfluss pro Jahr = 9.000 € - 1.500 € = 7.500 €. Amortisationsdauer = 30.000 € / 7.500 € = 4,0 Jahre.',
  ),
  rechnen(
    'a1-wb-3',
    'w-breakeven',
    scenario:
        'Ein Softwareprodukt wird für 90 € verkauft. Je Lizenz fallen 30 € variable Kosten an, die Fixkosten betragen 20.000 €.',
    prompt: 'Ab welcher ganzen Stückzahl sind alle Kosten erstmals gedeckt?',
    answer: 334,
    unit: 'Stück',
    explanation:
        'Deckungsbeitrag: 90 € - 30 € = 60 €\n'
        'Break-even-Menge: 20.000 € / 60 € = 333,33 Stück\n'
        'Mit 333 Stück fehlen noch 20 €; erst ab 334 Stück sind die Kosten gedeckt - also aufrunden.',
  ),
  rechnen(
    'a1-wb-4',
    'w-breakeven',
    scenario:
        'Preis 120 € je Stück, variable Stückkosten 70 €, Fixkosten 25.000 €. Verkauft werden 700 Stück.',
    prompt: 'Wie hoch ist der Gewinn?',
    answer: 10000,
    unit: '€',
    explanation:
        'Deckungsbeitrag je Stück: 120 € - 70 € = 50 €\n'
        'Gesamtdeckungsbeitrag: 700 × 50 € = 35.000 €\n'
        'Gewinn: 35.000 € - 25.000 € = 10.000 €\n'
        'Probe: Erlös 84.000 € - Kosten (25.000 € + 49.000 €) = 10.000 €.',
  ),
  rechnen(
    'a1-wb-5',
    'w-breakeven',
    scenario:
        'Eine Investition kostet 45.000 €. Sie spart 16.000 € pro Jahr und verursacht 4.000 € laufende Kosten pro Jahr.',
    prompt: 'Nach wie vielen Monaten ist die Investition amortisiert?',
    answer: 45,
    unit: 'Monate',
    explanation:
        'Rückfluss pro Jahr: 16.000 € - 4.000 € = 12.000 €\n'
        'Amortisationsdauer: 45.000 € / 12.000 € = 3,75 Jahre\n'
        'In Monaten: 3,75 × 12 = 45 Monate (3 Jahre und 9 Monate).',
  ),
  rechnen(
    'a1-wb-6',
    'w-breakeven',
    scenario:
        'Eine neue Serverlösung kostet 40.000 €. Über ihre Nutzungsdauer bringt sie Einsparungen von insgesamt 52.000 €.',
    prompt: 'Wie hoch ist der Return on Investment (ROI) in Prozent?',
    answer: 30,
    unit: '%',
    explanation:
        'Gewinn: 52.000 € - 40.000 € = 12.000 €\n'
        'ROI = Gewinn / eingesetztes Kapital × 100 % = 12.000 € / 40.000 € × 100 % = 30 %.',
  ),
  einfach(
    'a1-wb-7',
    'w-breakeven',
    scenario:
        'Das Diagramm zeigt Erlös (50 € je Stück), Gesamtkosten (10.000 € fix + 30 € je Stück) und Fixkosten eines Wartungspakets.',
    skizze: const GeradenDiagramm(
      xAchse: 'Menge',
      yAchse: 'Euro',
      xMax: 1000,
      yMax: 50000,
      geraden: [
        Gerade('Erlös', 0, 50),
        Gerade('Gesamtkosten', 10000, 30),
        Gerade('Fixkosten', 10000, 0),
      ],
      punkte: [DiagrammPunkt(500, 25000, 'Break-even')],
    ),
    prompt: 'Welche Aussage zum Diagramm ist richtig?',
    choices: [
      ja(
        'Rechts vom Schnittpunkt liegt die Gewinnzone.',
        'Dort liegt die Erlösgerade über der Kostengeraden.',
      ),
      nein(
        'Die Gesamtkostengerade beginnt bei 0.',
        'Sie beginnt bei den Fixkosten von 10.000 €.',
      ),
      nein(
        'Im Schnittpunkt ist der Gewinn am größten.',
        'Im Schnittpunkt ist der Gewinn genau 0.',
      ),
      nein(
        'Die waagerechte Gerade zeigt die variablen Kosten.',
        'Waagerecht verlaufen die Fixkosten - sie hängen nicht von der Menge ab.',
      ),
    ],
    explanation:
        'Break-even-Menge: 10.000 € / (50 € - 30 €) = 500 Stück. Links davon Verlust, rechts Gewinn; der senkrechte Abstand zwischen Erlös- und Kostengerade ist der Gewinn bzw. Verlust.',
  ),

  // ============================================================ Abnahme und Übergabe
  freitext(
    'a1-aa-1',
    'a-abnahme',
    scenario:
        'Bei der Abnahme einer Lagerverwaltung streiten Auftraggeber und Auftragnehmer, ob die Anforderung „Die Software soll schnell reagieren“ erfüllt ist.',
    prompt:
        'Erläutern Sie zwei Gründe, warum Abnahmekriterien schon im Pflichtenheft prüfbar formuliert sein müssen. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Abgenommen wird gegen das Vereinbarte - nur was vereinbart ist, kann der Auftraggeber einfordern.',
        punkte: 2,
        stichwoerter: ['vereinbart', 'einfordern', 'Maßstab', 'Pflichtenheft'],
      ),
      krit(
        'Nur messbare Kriterien lassen eine eindeutige Entscheidung „erfüllt oder nicht erfüllt“ zu.',
        punkte: 2,
        stichwoerter: ['messbar', 'eindeutig', 'objektiv', 'Zielwert'],
      ),
      krit(
        'Prüfbare Kriterien vermeiden Streit und Verzögerungen bei der Abnahme.',
        punkte: 2,
        stichwoerter: ['Streit', 'Konflikt', 'Diskussion', 'Auslegung'],
      ),
    ],
    loesung:
        'Bei der Abnahme wird das Ergebnis gegen die vereinbarten Anforderungen geprüft. „Schnell“ hat keinen Zielwert - ob das Kriterium erfüllt ist, bleibt Ansichtssache. Mit „Antwortzeit höchstens 2 s“ lässt sich eindeutig entscheiden, und Streit bei der Abnahme wird vermieden.',
    explanation:
        'Je Grund 2 Punkte, höchstens 4. Abgenommen wird gegen vereinbarte Kriterien. Deshalb müssen Anforderungen und Abnahmekriterien vorher prüfbar formuliert sein.',
  ),
  zuordnen(
    'a1-aa-2',
    'a-abnahme',
    prompt: 'Zu welcher Ebene des Projektabschlusses gehört die Tätigkeit?',
    buckets: ['sachlich', 'wirtschaftlich', 'personell'],
    items: [
      zu('Übergabe an den IT-Betrieb', 0, 'Es geht um das Ergebnis.'),
      zu('Nachkalkulation erstellen', 1, 'Es geht um Kosten.'),
      zu(
        'Teammitglieder kehren in ihre Abteilungen zurück',
        2,
        'Es geht um Menschen.',
      ),
      zu(
        'Abnahme durch den Auftraggeber',
        0,
        'Das Ergebnis wird geprüft und angenommen.',
      ),
      zu('Offene Rechnungen begleichen', 1, 'Das Budget wird geschlossen.'),
      zu(
        'Leistungen des Teams würdigen',
        2,
        'Anerkennung für die Beteiligten.',
      ),
    ],
    explanation:
        'Sachlich: Ergebnis. Wirtschaftlich: Kosten und Budget. Personell: Team und Menschen.',
  ),
  mehrfach(
    'a1-aa-3',
    'a-abnahme',
    prompt: 'Welche Rechtsfolgen hat die Abnahme bei einem Werkvertrag?',
    choices: [
      ja(
        'Die Vergütung wird fällig.',
        'Der Auftragnehmer darf die Schlussrechnung stellen.',
      ),
      ja(
        'Die Verjährungsfrist für Mängelansprüche beginnt.',
        'Ab der Abnahme läuft die Frist.',
      ),
      ja(
        'Die Beweislast für Mängel geht auf den Auftraggeber über.',
        'Vorher muss der Auftragnehmer die Mangelfreiheit belegen, danach der Auftraggeber den Mangel.',
      ),
      nein(
        'Der Auftragnehmer haftet ab sofort für keine Mängel mehr.',
        'Mängelansprüche bestehen weiter - nur die Verjährung beginnt.',
      ),
      nein(
        'Das Projektteam ist automatisch aufgelöst.',
        'Die Teamauflösung ist ein eigener, späterer Schritt.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Die Abnahme (§ 640 BGB) ist ein rechtlicher Wendepunkt: Vergütung fällig, Gefahrübergang, Umkehr der Beweislast, Beginn der Verjährung der Mängelansprüche. Deshalb wird sie sorgfältig protokolliert.',
  ),
  einfach(
    'a1-aa-4',
    'a-abnahme',
    scenario:
        'Bei der Abnahme eines Webshops laufen alle Funktionen wie vereinbart. Nur in einer Fehlermeldung steht ein Tippfehler.',
    prompt: 'Wie sollte der Auftraggeber entscheiden?',
    choices: [
      ja(
        'Abnehmen und den Tippfehler als Mangel mit Frist ins Protokoll aufnehmen',
        'Unwesentlicher Mangel: Abnahme unter Vorbehalt, der Mangel wird festgehalten.',
      ),
      nein(
        'Die Abnahme verweigern, bis alles fehlerfrei ist',
        'Wegen unwesentlicher Mängel darf die Abnahme nicht verweigert werden.',
      ),
      nein(
        'Abnehmen, ohne den Tippfehler zu erwähnen',
        'Wer einen bekannten Mangel nicht vorbehält, verliert wichtige Mängelrechte.',
      ),
      nein(
        'Die Abnahme auf unbestimmte Zeit verschieben',
        'Das verzögert Übergabe und Rechnung ohne sachlichen Grund.',
      ),
    ],
    explanation:
        'Wesentliche Mängel berechtigen zur Verweigerung, unwesentliche nicht. Bekannte Mängel werden im Abnahmeprotokoll mit Frist zur Behebung festgehalten - sonst sind sie später schwer durchzusetzen.',
  ),
  freitext(
    'a1-aa-5',
    'a-abnahme',
    scenario:
        'Ein Systemhaus übergibt einem Kunden eine neue Telefonanlage. Die Abnahme soll in einem Protokoll festgehalten werden.',
    prompt: 'Nennen Sie vier Inhalte eines Abnahmeprotokolls. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Datum und Ort der Abnahme',
        stichwoerter: ['Datum', 'Ort', 'Termin'],
      ),
      krit(
        'Teilnehmer beider Seiten',
        stichwoerter: ['Teilnehmer', 'Beteiligte', 'Anwesende'],
      ),
      krit(
        'Prüfgegenstand bzw. Leistungsumfang',
        stichwoerter: ['Prüfgegenstand', 'Gegenstand', 'Leistungsumfang'],
      ),
      krit(
        'Festgestellte Mängel mit Frist zur Behebung',
        stichwoerter: ['Mängel', 'Mangel', 'Frist'],
      ),
      krit(
        'Entscheidung: abgenommen, unter Vorbehalt oder verweigert',
        stichwoerter: ['Entscheidung', 'abgenommen', 'Vorbehalt', 'verweigert'],
      ),
      krit(
        'Unterschriften beider Seiten',
        stichwoerter: ['Unterschrift', 'Unterschriften', 'unterschrieben'],
      ),
    ],
    loesung:
        'Datum und Teilnehmer, Prüfgegenstand, festgestellte Mängel mit Frist zur Behebung, die Entscheidung (abgenommen, unter Vorbehalt oder verweigert) und die Unterschriften beider Seiten.',
    difficulty: 1,
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Das Abnahmeprotokoll dokumentiert, was geprüft wurde, welche Mängel bestehen und wie entschieden wurde. Ohne Protokoll steht im Streitfall Aussage gegen Aussage.',
  ),
  zuordnen(
    'a1-aa-6',
    'a-abnahme',
    prompt: 'Welche Einführungsstrategie wird jeweils beschrieben?',
    buckets: [
      'Stichtag (Big Bang)',
      'Parallelbetrieb',
      'stufenweise',
      'Pilotbetrieb',
    ],
    items: [
      zu(
        'Am Montag wird das alte System abgeschaltet und das neue gestartet.',
        0,
        'Alles wechselt auf einen Schlag.',
      ),
      zu(
        'Vier Wochen lang werden alle Buchungen in beiden Systemen erfasst.',
        1,
        'Altes und neues System laufen gleichzeitig.',
      ),
      zu(
        'Erst wird die Lohnbuchhaltung umgestellt, drei Monate später die Finanzbuchhaltung.',
        2,
        'Modul für Modul.',
      ),
      zu(
        'Eine Filiale arbeitet zuerst mit dem neuen Kassensystem, die anderen folgen nach der Auswertung.',
        3,
        'Ein Bereich erprobt das System unter Echtbedingungen.',
      ),
    ],
    explanation:
        'Stichtag: schnell, aber riskant. Parallelbetrieb: sicher, aber doppelter Aufwand. Stufenweise: Modul für Modul. Pilot: ein Bereich startet komplett, die übrigen folgen nach der Auswertung.',
  ),
  einfach(
    'a1-aa-7',
    'a-abnahme',
    scenario:
        'Ein Kunde nutzt die gelieferte Software seit sechs Wochen produktiv und hat keine Mängel gemeldet. Ein Abnahmeprotokoll wurde nie unterschrieben.',
    prompt: 'Wie ist die Lage in der Regel zu beurteilen?',
    choices: [
      ja(
        'Die Software gilt als stillschweigend (konkludent) abgenommen.',
        'Die vorbehaltlose produktive Nutzung zeigt, dass der Kunde das Werk annimmt.',
      ),
      nein(
        'Die Software gilt als nicht abgenommen, weil das Protokoll fehlt.',
        'Eine Abnahme ist auch ohne Protokoll durch schlüssiges Verhalten möglich.',
      ),
      nein(
        'Die Abnahme gilt als verweigert.',
        'Verweigert wird ausdrücklich und unter Nennung von Mängeln.',
      ),
      nein(
        'Eine Abnahme ist bei Software grundsätzlich nicht nötig.',
        'Bei Werkverträgen über Software ist die Abnahme zentral.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Neben der förmlichen Abnahme mit Protokoll gibt es die stillschweigende (konkludente) Abnahme durch vorbehaltlose Nutzung und die fiktive Abnahme nach Fristablauf. Für klare Verhältnisse sorgt nur die förmliche Abnahme.',
  ),

  // ====================================================== Abschlussbericht und Soll-Ist
  rechnen(
    'a1-ab-1',
    'a-bericht',
    prompt:
        'Geplant waren Kosten von 60.000 €, tatsächlich angefallen sind 69.000 €. Wie groß ist die Abweichung in Prozent?',
    answer: 15,
    unit: '%',
    explanation:
        'Abweichung = (Ist - Soll) / Soll × 100 = (69.000 - 60.000) / 60.000 × 100 = 15 %.',
  ),
  lueckentext(
    'a1-ab-2',
    'a-bericht',
    scenario:
        'Für den Abschlussbericht eines Rollout-Projekts wird der Soll-Ist-Vergleich vorbereitet.',
    prompt: 'Vervollständigen Sie die Regeln für den Soll-Ist-Vergleich.',
    text:
        'Abweichung absolut = {0} minus {1}\n'
        'Abweichung relativ = Abweichung absolut geteilt durch {2}, mal 100 %\n'
        'Wertvoll wird der Vergleich erst, wenn die Abweichungen {3} werden.',
    luecken: [
      wahl('Ist', ['Soll', 'Budgetrest'], 'Vom Ist wird das Soll abgezogen.'),
      wahl('Soll', ['Ist', 'Budgetrest'], 'Das Soll ist der Plan.'),
      wahl('das Soll', [
        'das Ist',
        'die Summe aus Soll und Ist',
      ], 'Bezugsgröße ist immer der Plan.'),
      wahl('begründet', [
        'gerundet',
        'geschönt',
      ], 'Erst die Ursachen helfen künftigen Projekten.'),
    ],
    explanation:
        'Abweichung = Ist - Soll, relativ bezogen auf das Soll. Ein Soll-Ist-Vergleich nennt Abweichungen und erklärt, wie sie entstanden sind - erst die Ursachen machen ihn für künftige Projekte nützlich.',
  ),
  rechnen(
    'a1-ab-3',
    'a-bericht',
    prompt:
        'Ein Projekt war mit 16 Wochen geplant und dauerte tatsächlich 18 Wochen. Wie groß ist die Terminabweichung in Prozent? (eine Nachkommastelle)',
    answer: 12.5,
    tolerance: 0.05,
    unit: '%',
    explanation:
        'Abweichung absolut: 18 - 16 = 2 Wochen\n'
        'Abweichung relativ: 2 / 16 × 100 % = 12,5 %\n'
        'Bezugsgröße ist immer das Soll (16 Wochen), nicht das Ist.',
  ),
  rechnen(
    'a1-ab-4',
    'a-bericht',
    scenario:
        'Geplant waren 420 Stunden zu 55 €/h. Tatsächlich wurden 462 Stunden zum selben Stundensatz gebucht.',
    prompt: 'Wie hoch ist die Abweichung der Personalkosten in Euro?',
    answer: 2310,
    unit: '€',
    explanation:
        'Soll: 420 h × 55 €/h = 23.100 €\n'
        'Ist: 462 h × 55 €/h = 25.410 €\n'
        'Abweichung: 25.410 € - 23.100 € = 2.310 € (kürzer: 42 h × 55 €/h)\n'
        'Relativ: 2.310 / 23.100 × 100 % = 10 %.',
  ),
  rechnen(
    'a1-ab-5',
    'a-bericht',
    scenario:
        'Im Projektauftrag standen 20 Muss-Anforderungen. Bei Projektende sind 17 davon umgesetzt.',
    prompt: 'Wie hoch ist der Zielerreichungsgrad in Prozent?',
    answer: 85,
    unit: '%',
    difficulty: 1,
    explanation:
        'Zielerreichungsgrad = erreichte / geplante Ziele × 100 % = 17 / 20 × 100 % = 85 %.',
  ),
  einfach(
    'a1-ab-6',
    'a-bericht',
    scenario: 'Geplant waren 50.000 €, tatsächlich angefallen sind 45.000 €.',
    prompt: 'Wie lautet die Kostenabweichung korrekt?',
    choices: [
      ja(
        '-5.000 €, also 10 % unter Plan',
        '(45.000 - 50.000) / 50.000 × 100 % = -10 %.',
      ),
      nein(
        '-5.000 €, also 11,1 % unter Plan',
        'Hier wurde falsch auf das Ist (45.000 €) bezogen.',
      ),
      nein(
        '+10 %, das Budget wurde überschritten',
        'Das Ist liegt unter dem Soll - eine Unterschreitung.',
      ),
      nein('+5.000 €', 'Ist minus Soll ergibt -5.000 €.'),
    ],
    explanation:
        'Absolute Abweichung = Ist - Soll = -5.000 €. Relative Abweichung = -5.000 / 50.000 × 100 % = -10 %. Negativ heißt bei Kosten: günstiger als geplant.',
  ),
  freitext(
    'a1-ab-7',
    'a-bericht',
    scenario:
        'Die Nachkalkulation eines Softwareprojekts zeigt: Statt der geplanten 60.000 € sind 69.000 € angefallen. Im Abschlussbericht soll die Abweichung begründet werden.',
    prompt:
        'Nennen Sie drei mögliche Ursachen für eine Kostenüberschreitung. (3 P.)',
    punkte: 3,
    kriterien: [
      krit(
        'Der Aufwand wurde in der Planung zu niedrig geschätzt.',
        stichwoerter: ['geschätzt', 'Schätzfehler', 'unterschätzt', 'Aufwand'],
      ),
      krit(
        'Änderungswünsche wurden umgesetzt, ohne das Budget anzupassen.',
        stichwoerter: ['Änderungswünsche', 'Änderungen', 'Zusatzwünsche'],
      ),
      krit(
        'Lieferverzug führte zu Wartezeiten des Teams.',
        stichwoerter: ['Lieferverzug', 'Wartezeiten', 'Lieferung'],
      ),
      krit(
        'Ausfall von Teammitgliedern, teurer externer Ersatz',
        stichwoerter: ['Ausfall', 'krank', 'extern'],
      ),
      krit(
        'Technische Probleme verursachten Mehrarbeit.',
        stichwoerter: ['technische Probleme', 'Fehler', 'Mehrarbeit'],
      ),
      krit(
        'Preise für Hardware oder Lizenzen sind gestiegen.',
        stichwoerter: ['Preise', 'Preissteigerung', 'teurer'],
      ),
    ],
    loesung:
        'Der Aufwand wurde zu niedrig geschätzt, Änderungswünsche wurden ohne Budgetanpassung umgesetzt, und ein Lieferverzug führte zu Wartezeiten des Teams.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Typische Ursachen sind Schätzfehler, Änderungswünsche ohne Anpassung von Budget und Termin, Ausfälle, Lieferverzug und technische Probleme. Zu jeder Ursache gehört eine Empfehlung für künftige Projekte.',
  ),

  // ============================================================== Lessons Learned
  einfach(
    'a1-al-1',
    'a-lessons',
    scenario:
        'Zu Beginn des Lessons-Learned-Workshops sagt die Teamleiterin: „Heute klären wir, wer an der Verspätung schuld war.“',
    prompt: 'Was ist daran problematisch?',
    choices: [
      ja(
        'Schuldzuweisungen verhindern offene Beiträge - es geht um Ursachen und Verbesserungen.',
        'Wer Angst vor Schuld hat, schweigt - und die wichtigsten Erkenntnisse gehen verloren.',
      ),
      nein(
        'Nichts, Verantwortliche müssen benannt werden.',
        'Genau das macht den Workshop wertlos.',
      ),
      nein(
        'Lessons Learned finden nur bei erfolgreichen Projekten statt.',
        'Gerade gescheiterte Projekte sind lehrreich.',
      ),
      nein(
        'Die Teamleiterin darf am Workshop nicht teilnehmen.',
        'Ihre Teilnahme ist nicht das Problem.',
      ),
    ],
    explanation:
        'Lessons Learned fragen nach Ursachen und Verbesserungen, nicht nach Schuldigen.',
  ),
  reihenfolge(
    'a1-al-2',
    'a-lessons',
    prompt:
        'Bringe die Schritte eines Lessons-Learned-Workshops in die richtige Reihenfolge.',
    items: [
      'Vorbereiten',
      'Erfahrungen sammeln',
      'Ursachen analysieren',
      'Empfehlungen ableiten',
      'Dokumentieren und zugänglich machen',
    ],
    explanation:
        'Aus gesammelten Erfahrungen werden über die Ursachenanalyse konkrete Empfehlungen - und die müssen für andere auffindbar abgelegt werden.',
  ),
  zuordnen(
    'a1-al-3',
    'a-lessons',
    scenario:
        'Im Lessons-Learned-Workshop werden Erfahrungen nach Start - Stop - Continue sortiert: neu einführen, was gefehlt hat; abschaffen, was geschadet hat; beibehalten, was sich bewährt hat.',
    prompt: 'Ordne jede Praxis der passenden Kategorie zu.',
    buckets: ['Start', 'Stop', 'Continue'],
    items: [
      zu(
        'Testdatenbank schon zu Projektbeginn aufsetzen (fehlte diesmal)',
        0,
        'Etwas, das künftig neu gemacht werden soll.',
      ),
      zu(
        'Firewall-Freigaben gleich beim Projektstart beantragen (kam diesmal zu spät)',
        0,
        'Eine neue Praxis für künftige Projekte.',
      ),
      zu(
        'Anforderungen nur mündlich abstimmen',
        1,
        'Führte zu Streit über den Umfang - abschaffen.',
      ),
      zu(
        'Wochenendarbeit als Standardlösung bei Verzug',
        1,
        'Schadet dem Team und verdeckt Planungsfehler.',
      ),
      zu(
        'Tägliche 15-Minuten-Abstimmung im Team',
        2,
        'Hat sich bewährt - beibehalten.',
      ),
      zu(
        'Gemeinsame Aufgabenliste im Wiki',
        2,
        'Hat allen Überblick gegeben - beibehalten.',
      ),
    ],
    explanation:
        'Start - Stop - Continue übersetzt Erfahrungen direkt in Handlungen. Wichtig: Auch Erfolge (Continue) werden gesammelt, nicht nur Fehler.',
  ),
  markieren(
    'a1-al-4',
    'a-lessons',
    scenario:
        'Im Lessons-Learned-Workshop wurden Karten gesammelt. Ins Wiki sollen nur Einträge, nach denen ein fremdes Team handeln kann.',
    prompt: 'Markieren Sie alle brauchbar formulierten Lessons.',
    zeilen: [
      ja(
        'Die Firewall-Freigabe dauerte 10 Tage und verzögerte den Go-live - Freigaben künftig beim Projektstart beantragen.',
        'Situation, Ursache und konkrete Empfehlung - ein fremdes Team kann danach handeln.',
      ),
      nein(
        'Die Kommunikation muss besser werden.',
        'Zu vage - niemand weiß, was konkret zu tun ist.',
      ),
      nein(
        'Herr Meier hat die Freigabe zu spät beantragt.',
        'Eine Schuldzuweisung, keine Lesson.',
      ),
      ja(
        'Testdaten fehlten bis Woche 6, weil niemand zuständig war - künftig im Kick-off eine verantwortliche Person benennen.',
        'Ursache und Empfehlung sind klar benannt.',
      ),
      nein(
        'Insgesamt lief alles gut.',
        'Daraus folgt keine übertragbare Erkenntnis.',
      ),
      ja(
        'Die tägliche 15-Minuten-Abstimmung hat Rückfragen früh geklärt - beibehalten.',
        'Auch Erfolge gehören dazu, mit klarer Empfehlung.',
      ),
    ],
    explanation:
        'Eine brauchbare Lesson nennt Situation, Ursache und Empfehlung. Sie ist konkret, ohne Schuldzuweisung und für andere Projekte verständlich.',
  ),
  mehrfach(
    'a1-al-5',
    'a-lessons',
    prompt:
        'Wie stellst du sicher, dass Lessons Learned beim nächsten Projekt ankommen?',
    choices: [
      ja(
        'Ergebnisse zentral im Wiki oder Projektportal ablegen',
        'Dort findet sie das nächste Team.',
      ),
      ja(
        'Einträge nach Projektart, Technik und Phase verschlagworten',
        'So werden sie gezielt gefunden.',
      ),
      ja(
        'Checklisten und Vorlagen mit den Erkenntnissen anpassen',
        'Dann wirken sie automatisch mit.',
      ),
      nein(
        'Das Protokoll im persönlichen Postfach der Projektleiterin speichern',
        'Dort findet es niemand sonst.',
      ),
      nein(
        'Die Auswertung ein Jahr nach Projektende durchführen',
        'Dann sind die Erinnerungen verblasst.',
      ),
    ],
    explanation:
        'Lessons Learned wirken nur, wenn sie zeitnah erhoben, zentral und auffindbar abgelegt und in Checklisten und Projektstarts eingebunden werden.',
  ),
  zuordnen(
    'a1-al-6',
    'a-lessons',
    scenario:
        'Am Projektende entstehen zwei Dokumente: der Abschlussbericht und die Lessons Learned.',
    prompt: 'Zu welchem Dokument gehört die Aussage?',
    buckets: ['Abschlussbericht', 'Lessons Learned'],
    items: [
      zu('Empfehlungen für künftige Projekte', 1, 'Der Blick geht nach vorn.'),
      zu(
        'Soll-Ist-Vergleich von Kosten und Terminen',
        0,
        'Kern des Abschlussberichts.',
      ),
      zu(
        'Richtet sich vor allem an künftige Projektteams',
        1,
        'Sie sollen aus den Erfahrungen lernen.',
      ),
      zu(
        'Richtet sich an Auftraggeber und Lenkungsausschuss',
        0,
        'Sie wollen wissen, was herausgekommen ist.',
      ),
      zu(
        'Was lief gut und soll beibehalten werden?',
        1,
        'Typische Frage im Workshop.',
      ),
      zu(
        'Grad der Zielerreichung des Projekts',
        0,
        'Bewertet das Ergebnis dieses Projekts.',
      ),
    ],
    explanation:
        'Der Abschlussbericht beantwortet „Was ist herausgekommen?“ für Auftraggeber und Lenkungsausschuss. Lessons Learned beantworten „Was lernen wir daraus?“ für künftige Projektteams.',
  ),
  einfach(
    'a1-al-7',
    'a-lessons',
    prompt: 'Wann sollten Erfahrungen am besten gesichert werden?',
    choices: [
      ja(
        'Zeitnah am Projektende und zusätzlich nach wichtigen Phasen oder Meilensteinen',
        'Frische Erinnerungen, und das laufende Projekt profitiert schon.',
      ),
      nein(
        'Frühestens ein Jahr nach Projektende, mit Abstand',
        'Dann ist vieles vergessen.',
      ),
      nein(
        'Nur, wenn das Projekt gescheitert ist',
        'Auch Erfolge sind lehrreich.',
      ),
      nein(
        'Ausschließlich vor dem Projektstart',
        'Vor dem Start gibt es noch keine Erfahrungen aus diesem Projekt.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Lessons Learned gehören zeitnah ans Projektende; projektbegleitend nach Phasen und Meilensteinen (in Scrum nach jedem Sprint als Retrospektive) nutzen sie schon dem laufenden Projekt.',
  ),
];
