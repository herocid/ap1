import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben zu Bereich 01, Teil 2: Terminplanung, Risiko, Wirtschaftlichkeit
/// und Projektabschluss.
final List<Question> questionsA01Planung = [
  // ========================================================= Projektstrukturplan
  einfach('a1-tp-1', 't-psp',
      prompt: 'Was enthält ein Projektstrukturplan NICHT?',
      choices: [
        ja('Die zeitliche Reihenfolge der Arbeitspakete',
            'Reihenfolge und Termine kommen erst im Netzplan oder Gantt-Diagramm dazu.'),
        nein('Teilaufgaben', 'Die gehören in die mittleren Ebenen des PSP.'),
        nein('Arbeitspakete', 'Die unterste Ebene des PSP.'),
        nein('Die Gliederung des Gesamtprojekts', 'Genau das ist der PSP.'),
      ],
      explanation: 'Der PSP zeigt, WAS zu tun ist - nicht WANN und in welcher Reihenfolge.'),
  zuordnen('a1-tp-2', 't-psp',
      prompt: 'Nach welchem Prinzip ist der jeweilige PSP gegliedert?',
      buckets: ['objektorientiert', 'funktionsorientiert', 'phasenorientiert'],
      items: [
        zu('Server - Clients - Netzwerk', 0),
        zu('Beschaffen - Installieren - Testen', 1),
        zu('Analyse - Entwurf - Umsetzung - Einführung', 2),
        zu('Hardware - Software - Dokumentation', 0),
        zu('Planen - Programmieren - Schulen', 1),
        zu('Konzeptphase - Realisierungsphase - Betriebsphase', 2),
      ],
      explanation:
          'Objektorientiert: Bestandteile des Ergebnisses. Funktionsorientiert: Tätigkeiten. Phasenorientiert: Projektphasen.'),
  mehrfach('a1-tp-3', 't-psp',
      prompt: 'Welche Eigenschaften hat ein gutes Arbeitspaket?',
      choices: [
        ja('Ein eindeutig abgegrenztes, prüfbares Ergebnis', 'Sonst lässt sich nicht feststellen, wann es fertig ist.'),
        ja('Genau eine verantwortliche Person', 'Geteilte Verantwortung heißt oft: niemand fühlt sich zuständig.'),
        ja('Ein schätzbarer Aufwand', 'Nur so lassen sich Termine und Kosten planen.'),
        nein('Es umfasst mindestens drei Monate Arbeit', 'Arbeitspakete sollen überschaubar sein, nicht möglichst groß.'),
        nein('Es wird im PSP in weitere Arbeitspakete zerlegt', 'Das Arbeitspaket ist die unterste Ebene - es wird nicht weiter zerlegt.'),
      ],
      explanation: 'Das Arbeitspaket ist die kleinste, eindeutig verantwortete und schätzbare Einheit im PSP.'),

  // ================================================== Ressourcen und Aufwand
  rechnen('a1-tr-1', 't-ressourcen',
      prompt:
          'Ein Arbeitspaket hat einen Aufwand von 24 Personentagen. Zwei Mitarbeiter arbeiten zu je 60 % daran. Wie viele Arbeitstage dauert es?',
      answer: 20,
      unit: 'Arbeitstage',
      explanation: 'Dauer = Aufwand / (Personen × Verfügbarkeit) = 24 / (2 × 0,6) = 24 / 1,2 = 20 Arbeitstage.'),
  einfach('a1-tr-2', 't-ressourcen',
      prompt: 'Was beschreibt der Aufwand eines Arbeitspakets?',
      choices: [
        ja('Die Menge an Arbeit, zum Beispiel in Personentagen', 'Aufwand misst Arbeit, nicht Zeit.'),
        nein('Die Zeitspanne im Kalender', 'Das ist die Dauer.'),
        nein('Die Kosten des Arbeitspakets', 'Kosten ergeben sich erst aus Aufwand mal Stundensatz.'),
        nein('Die Anzahl der beteiligten Personen', 'Die beeinflusst die Dauer, nicht den Aufwand.'),
      ],
      explanation: 'Aufwand = Arbeitsmenge (PT), Dauer = Kalenderzeit (AT). Mehr Personen senken die Dauer, nicht den Aufwand.'),

  // ======================================= Der Risikomanagement-Prozess
  reihenfolge('a1-rp-1', 'r-prozess',
      prompt: 'Bringe die Schritte des Risikomanagements in die richtige Reihenfolge.',
      items: ['Risiken identifizieren', 'Risiken bewerten', 'Maßnahmen planen', 'Risiken überwachen'],
      explanation: 'Ein Kreislauf: Nach dem Überwachen beginnt die Identifikation neuer Risiken von vorn.'),
  einfach('a1-rp-2', 'r-prozess',
      prompt: 'Welche Situation beschreibt ein Risiko und kein Problem?',
      choices: [
        ja('Der einzige Datenbankexperte könnte während der Migration krank werden.',
            'Ein mögliches künftiges Ereignis - also ein Risiko.'),
        nein('Der Server ist gestern ausgefallen.', 'Bereits eingetreten - ein Problem.'),
        nein('Die Lieferung kam drei Tage zu spät.', 'Bereits eingetreten - ein Problem.'),
        nein('Das Budget ist bereits um 10 % überschritten.', 'Bereits eingetreten - ein Problem.'),
      ],
      explanation: 'Ein Risiko liegt in der Zukunft und kann eintreten. Ein Problem ist bereits eingetreten.'),
  mehrfach('a1-rp-3', 'r-prozess',
      prompt: 'Was gehört in ein Risikoregister?',
      choices: [
        ja('Beschreibung und Ursache des Risikos', 'Grundlage jedes Eintrags.'),
        ja('Eintrittswahrscheinlichkeit und Schadenshöhe', 'Grundlage der Bewertung.'),
        ja('Maßnahme und verantwortliche Person', 'Ohne Verantwortlichen passiert nichts.'),
        nein('Die Gehaltsliste des Teams', 'Gehört nicht in das Risikoregister.'),
        nein('Der Quellcode des Projekts', 'Gehört ins Versionsverwaltungssystem.'),
      ],
      explanation: 'Das Register dokumentiert jedes Risiko mit Bewertung, Maßnahme, Verantwortlichem und Status.'),

  // =========================================================== Risiken bewerten
  rechnen('a1-rb-1', 'r-bewertung',
      prompt: 'Ein Risiko tritt mit 25 % Wahrscheinlichkeit ein und verursacht dann 36.000 € Schaden. Wie hoch ist der Risikowert?',
      answer: 9000,
      unit: '€',
      explanation: 'Risikowert = Wahrscheinlichkeit × Schaden = 0,25 × 36.000 € = 9.000 €.'),
  einfach('a1-rb-2', 'r-bewertung',
      scenario:
          'R1: 10 % Wahrscheinlichkeit, 80.000 € Schaden\n'
          'R2: 40 % Wahrscheinlichkeit, 15.000 € Schaden\n'
          'R3: 60 % Wahrscheinlichkeit, 5.000 € Schaden',
      prompt: 'Welches Risiko sollte zuerst behandelt werden?',
      choices: [
        ja('R1', 'Höchster Risikowert: 0,10 × 80.000 € = 8.000 €.'),
        nein('R2', 'Risikowert 6.000 € - an zweiter Stelle.'),
        nein('R3', 'Zwar am wahrscheinlichsten, aber nur 3.000 € Risikowert.'),
        nein('Alle drei gleichzeitig, weil sie gleich wichtig sind', 'Die Risikowerte unterscheiden sich deutlich.'),
      ],
      explanation: 'Priorisiert wird nach dem Risikowert, nicht nach der Wahrscheinlichkeit allein: R1 8.000 €, R2 6.000 €, R3 3.000 €.'),

  // =========================================================== Risikostrategien
  einfach('a1-rs-1', 'r-strategien',
      scenario: 'Das Team verzichtet auf ein neues, noch unerprobtes Framework und nutzt stattdessen das bewährte.',
      prompt: 'Welche Risikostrategie wird angewendet?',
      choices: [
        ja('Vermeiden', 'Die riskante Ursache wird nicht eingegangen.'),
        nein('Vermindern', 'Dann würde man das neue Framework nutzen, aber z. B. mit Schulung absichern.'),
        nein('Übertragen', 'Dabei würden die Folgen auf Dritte verlagert.'),
        nein('Akzeptieren', 'Dann würde man das Framework bewusst trotz Risiko einsetzen.'),
      ],
      explanation: 'Wer auf die risikobehaftete Tätigkeit ganz verzichtet, vermeidet das Risiko.'),

  // ============================================== Projektkosten kalkulieren
  rechnen('a1-wk-1', 'w-kalkulation',
      prompt:
          'Ein Mitarbeiter kostet das Unternehmen 54.000 € pro Jahr und hat 1.350 produktive Stunden. Wie hoch ist sein Stundensatz?',
      answer: 40,
      unit: '€/h',
      explanation: 'Stundensatz = Jahreskosten / produktive Stunden = 54.000 € / 1.350 h = 40 €/h.'),
  rechnen('a1-wk-2', 'w-kalkulation',
      prompt:
          'Listenpreis 2.500 €, 8 % Rabatt, 3 % Skonto, 45 € Bezugskosten. Wie hoch ist der Bezugspreis? (zwei Nachkommastellen)',
      answer: 2276,
      tolerance: 0.01,
      unit: '€',
      explanation:
          'Listenpreis 2.500,00 €\n'
          '- 8 % Rabatt = 200,00 € -> Zieleinkaufspreis 2.300,00 €\n'
          '- 3 % Skonto vom Zieleinkaufspreis = 69,00 € -> Bareinkaufspreis 2.231,00 €\n'
          '+ Bezugskosten 45,00 € -> Bezugspreis 2.276,00 €'),

  // ============================================================ Nutzwertanalyse
  mehrfach('a1-wn-1', 'w-nutzwert',
      prompt: 'Welche Fehler machen eine Nutzwertanalyse ungültig?',
      choices: [
        ja('Die Gewichte ergeben zusammen 120 %', 'Die Gewichte müssen genau 100 % ergeben.'),
        ja('Die Punkte werden ohne Gewichtung addiert', 'Dann hätten alle Kriterien dasselbe Gewicht.'),
        nein('Die Kriterien sind unterschiedlich gewichtet', 'Das ist der Sinn der Gewichtung.'),
        nein('Es werden mehr als zwei Alternativen verglichen', 'Beliebig viele Alternativen sind möglich.'),
        ja('Ein Anbieter verfehlt ein Muss-Kriterium und wird trotzdem gewählt',
            'Muss-Kriterien sind K.-o.-Kriterien und werden vorab geprüft.'),
      ],
      explanation: 'Gewichte summieren sich zu 100 %, Punkte werden mit dem Gewicht multipliziert, Muss-Kriterien werden vorab geprüft.'),

  // ================================================================== Make or Buy
  mehrfach('a1-wm-1', 'w-makeorbuy',
      prompt: 'Welche Argumente sprechen für eine Eigenentwicklung (Make)?',
      choices: [
        ja('Die Lösung passt genau zu den eigenen Abläufen', 'Maßgeschneidert statt Standard.'),
        ja('Das Know-how bleibt im Unternehmen', 'Man versteht und beherrscht die eigene Lösung.'),
        nein('Die Lösung ist sofort verfügbar', 'Das spricht für den Kauf.'),
        ja('Es gibt keine Abhängigkeit von einem Anbieter', 'Kein Risiko, dass ein Anbieter Preise erhöht oder das Produkt einstellt.'),
        nein('Die Entwicklungskosten sind gering', 'Eigenentwicklung ist meist teuer - das spricht eher für Buy.'),
      ],
      explanation: 'Make punktet mit Passgenauigkeit, Know-how und Unabhängigkeit; Buy mit Geschwindigkeit und geringeren Entwicklungskosten.'),
  rechnen('a1-wm-2', 'w-makeorbuy',
      prompt:
          'Eine Softwarelösung kostet 12.000 € in der Anschaffung. Pro Jahr fallen 3.000 € für Wartung und Lizenzen an. Wie hoch sind die Gesamtkosten (TCO) bei vier Jahren Nutzung?',
      answer: 24000,
      unit: '€',
      explanation: 'TCO = Anschaffung + laufende Kosten über die Nutzungsdauer = 12.000 € + 4 × 3.000 € = 24.000 €.'),

  // ===================================================== Break-even und Amortisation
  rechnen('a1-wb-1', 'w-breakeven',
      prompt: 'Ein Produkt kostet 120 €, die variablen Stückkosten betragen 70 €, die Fixkosten 25.000 €. Ab welcher Menge ist die Gewinnschwelle erreicht?',
      answer: 500,
      unit: 'Stück',
      explanation: 'Deckungsbeitrag = 120 € - 70 € = 50 €. Break-even-Menge = 25.000 € / 50 € = 500 Stück.'),
  rechnen('a1-wb-2', 'w-breakeven',
      prompt:
          'Eine Investition kostet 30.000 €. Sie spart jährlich 9.000 €, verursacht aber 1.500 € laufende Kosten pro Jahr. Nach wie vielen Jahren ist sie amortisiert? (eine Nachkommastelle)',
      answer: 4,
      tolerance: 0.05,
      unit: 'Jahre',
      explanation: 'Rückfluss pro Jahr = 9.000 € - 1.500 € = 7.500 €. Amortisationsdauer = 30.000 € / 7.500 € = 4,0 Jahre.'),

  // ============================================================ Abnahme und Übergabe
  einfach('a1-aa-1', 'a-abnahme',
      prompt: 'Wogegen prüft der Auftraggeber das Ergebnis bei der Abnahme?',
      choices: [
        ja('Gegen die vereinbarten Anforderungen und Abnahmekriterien, z. B. aus dem Pflichtenheft',
            'Nur was vereinbart war, kann eingefordert werden.'),
        nein('Gegen die Erwartungen von Anwendern, die im Projekt nicht beteiligt waren',
            'Nicht vereinbarte Erwartungen sind kein Maßstab der Abnahme.'),
        nein('Gegen das verbrauchte Budget', 'Das Budget ist Teil der Nachkalkulation, nicht der Abnahme.'),
        nein('Gegen die Zahl der geleisteten Arbeitsstunden', 'Aufwand sagt nichts über die Qualität des Ergebnisses.'),
      ],
      explanation: 'Abgenommen wird gegen vereinbarte Kriterien. Deshalb müssen Anforderungen und Abnahmekriterien vorher prüfbar formuliert sein.'),
  zuordnen('a1-aa-2', 'a-abnahme',
      prompt: 'Zu welcher Ebene des Projektabschlusses gehört die Tätigkeit?',
      buckets: ['sachlich', 'wirtschaftlich', 'personell'],
      items: [
        zu('Übergabe an den IT-Betrieb', 0),
        zu('Nachkalkulation erstellen', 1),
        zu('Teammitglieder kehren in ihre Abteilungen zurück', 2),
        zu('Abnahme durch den Auftraggeber', 0),
        zu('Offene Rechnungen begleichen', 1),
        zu('Leistungen des Teams würdigen', 2),
      ],
      explanation: 'Sachlich: Ergebnis. Wirtschaftlich: Kosten und Budget. Personell: Team und Menschen.'),

  // ====================================================== Abschlussbericht und Soll-Ist
  rechnen('a1-ab-1', 'a-bericht',
      prompt: 'Geplant waren Kosten von 60.000 €, tatsächlich angefallen sind 69.000 €. Wie groß ist die Abweichung in Prozent?',
      answer: 15,
      unit: '%',
      explanation: 'Abweichung = (Ist - Soll) / Soll × 100 = (69.000 - 60.000) / 60.000 × 100 = 15 %.'),
  einfach('a1-ab-2', 'a-bericht',
      prompt: 'Was macht einen Soll-Ist-Vergleich im Abschlussbericht wirklich wertvoll?',
      choices: [
        ja('Die Abweichungen werden begründet', 'Erst die Ursachen machen den Vergleich für künftige Projekte nützlich.'),
        nein('Er enthält möglichst viele Kennzahlen', 'Menge ersetzt keine Erklärung.'),
        nein('Er benennt die Schuldigen für Verzögerungen', 'Schuldzuweisungen verhindern offene Aufarbeitung.'),
        nein('Er zeigt nur positive Abweichungen', 'Ein beschönigter Bericht ist wertlos.'),
      ],
      explanation: 'Ein Soll-Ist-Vergleich nennt Abweichungen und erklärt, wie sie entstanden sind.'),

  // ============================================================== Lessons Learned
  einfach('a1-al-1', 'a-lessons',
      scenario: 'Zu Beginn des Lessons-Learned-Workshops sagt die Teamleiterin: „Heute klären wir, wer an der Verspätung schuld war.“',
      prompt: 'Was ist daran problematisch?',
      choices: [
        ja('Schuldzuweisungen verhindern offene Beiträge - es geht um Ursachen und Verbesserungen.',
            'Wer Angst vor Schuld hat, schweigt - und die wichtigsten Erkenntnisse gehen verloren.'),
        nein('Nichts, Verantwortliche müssen benannt werden.', 'Genau das macht den Workshop wertlos.'),
        nein('Lessons Learned finden nur bei erfolgreichen Projekten statt.', 'Gerade gescheiterte Projekte sind lehrreich.'),
        nein('Die Teamleiterin darf am Workshop nicht teilnehmen.', 'Ihre Teilnahme ist nicht das Problem.'),
      ],
      explanation: 'Lessons Learned fragen nach Ursachen und Verbesserungen, nicht nach Schuldigen.'),
  reihenfolge('a1-al-2', 'a-lessons',
      prompt: 'Bringe die Schritte eines Lessons-Learned-Workshops in die richtige Reihenfolge.',
      items: [
        'Vorbereiten',
        'Erfahrungen sammeln',
        'Ursachen analysieren',
        'Empfehlungen ableiten',
        'Dokumentieren und zugänglich machen',
      ],
      explanation: 'Aus gesammelten Erfahrungen werden über die Ursachenanalyse konkrete Empfehlungen - und die müssen für andere auffindbar abgelegt werden.'),
];
