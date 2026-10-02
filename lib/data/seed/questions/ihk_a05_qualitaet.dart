import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben im IHK-Stil zu Bereich 05: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA05 = [
  // ======================================== Qualität und Qualitätssicherung
  paare(
    'i5-qg-1',
    'qm-grundlagen',
    scenario:
        'Ein Softwarehaus überarbeitet sein Qualitätshandbuch. Im Glossar sollen sechs Grundbegriffe der Qualitätssicherung erklärt werden.',
    prompt: 'Ordne jedem Begriff die passende Erklärung zu. (6 P.)',
    punkte: 6,
    paare: [
      paar('konstruktive QS', 'Fehler von vornherein vermeiden'),
      paar('analytische QS', 'Fehler in fertigen Ergebnissen finden'),
      paar('statische Prüfung', 'Prüfen, ohne das Programm auszuführen'),
      paar('dynamische Prüfung', 'Prüfen durch Ausführen des Programms'),
      paar('Verifikation', 'Prüfung gegen die Spezifikation'),
      paar('Validierung', 'Prüfung gegen den Bedarf des Kunden'),
    ],
    explanation:
        'Konstruktive QS beugt vor (Richtlinien, Schulung), analytische prüft nach (Review, Test). Statisch heißt ohne, dynamisch mit Ausführung des Programms. Die Verifikation fragt: Ist es richtig gebaut? Die Validierung fragt: Ist das Richtige gebaut?',
  ),
  lueckentext(
    'i5-qg-2',
    'qm-grundlagen',
    scenario:
        'In einem Projekt kostet die Korrektur eines Anforderungsfehlers in der Anforderungsphase 40 €. Nach der Zehnerregel verzehnfachen sich die Kosten mit jeder weiteren Phase. Drei solcher Fehler werden erst im Systemtest gefunden (zwei Phasen später), ein weiterer erst im Betrieb (drei Phasen später).',
    prompt: 'Berechne die Fehlerkosten nach der Zehnerregel. (5 P.)',
    punkte: 5,
    text:
        'Kosten je Fehler im Systemtest: {0} €\n'
        'Kosten der drei Fehler im Systemtest: {1} €\n'
        'Kosten des Fehlers im Betrieb: {2} €\n'
        'Fehlerkosten insgesamt: {3} €\n'
        'Kosten, wenn alle vier Fehler sofort entdeckt worden wären: {4} €',
    luecken: [
      zahl(4000, rationale: '40 € × 10 × 10.'),
      zahl(12000, rationale: '3 × 4.000 €.'),
      zahl(40000, rationale: '40 € × 10 × 10 × 10.'),
      zahl(52000, rationale: '12.000 € + 40.000 €.'),
      zahl(160, rationale: '4 × 40 €.'),
    ],
    explanation:
        'Zwei Phasen später: 40 € × 10² = 4.000 € je Fehler, für drei Fehler 12.000 €.\n'
        'Drei Phasen später: 40 € × 10³ = 40.000 €.\n'
        'Zusammen sind das 52.000 €. Bei sofortiger Entdeckung wären es nur 4 × 40 € = 160 € gewesen. Deshalb lohnen sich Reviews der Anforderungen.',
  ),
  freitext(
    'i5-qg-3',
    'qm-grundlagen',
    scenario:
        'Eine Agentur will die Qualität ihrer Webanwendungen verbessern und plant konstruktive und analytische Maßnahmen.',
    prompt:
        'Erläutere den Unterschied zwischen konstruktiver und analytischer Qualitätssicherung und nenne je ein Beispiel. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Konstruktive QS beugt vor: Fehler sollen gar nicht erst entstehen.',
        stichwoerter: ['vorbeugen', 'vermeiden', 'verhindern', 'vorher'],
      ),
      krit(
        'Beispiel konstruktiv: Programmierrichtlinien, Vorlagen, Schulungen, Werkzeuge',
        stichwoerter: [
          'Richtlinie',
          'Konvention',
          'Vorlage',
          'Schulung',
          'Standard',
        ],
      ),
      krit(
        'Analytische QS prüft fertige Ergebnisse und findet vorhandene Fehler.',
        stichwoerter: ['finden', 'aufdecken', 'prüfen', 'nachträglich'],
      ),
      krit(
        'Beispiel analytisch: Review, Inspektion, Test, statische Codeanalyse',
        stichwoerter: ['Review', 'Test', 'Inspektion', 'Codeanalyse'],
      ),
    ],
    loesung:
        'Konstruktive QS verhindert Fehler von vornherein, zum Beispiel durch verbindliche Programmierrichtlinien. Analytische QS findet Fehler in bereits erstellten Ergebnissen, zum Beispiel durch ein Code-Review oder einen Test.',
    explanation:
        'Je Erklärung und je Beispiel 1 Punkt. Beide ergänzen sich: Konstruktive Maßnahmen senken die Zahl der Fehler, analytische finden die verbleibenden.',
  ),

  // ================================================== Qualitätsanforderungen
  tabelle(
    'i5-qe-1',
    'qm-merkmale',
    scenario:
        'Im Lastenheft für ein Kundenportal stehen vier Anforderungen. Vor der Übernahme ins Pflichtenheft wird geprüft, welcher Art sie sind und ob sie messbar formuliert sind.',
    prompt:
        'Ordne jede Anforderung ein und beurteile, ob sie prüfbar ist. (4 P.)',
    punkte: 4,
    zeilen: [
      ['Anforderung', 'Art', 'Prüfbar?'],
      [
        'Die Suche antwortet in höchstens 2 s.',
        wahl('nicht funktional', ['funktional', 'keine Anforderung']),
        wahl('messbar', ['nicht messbar', 'keine Anforderung']),
      ],
      [
        'Das Portal soll benutzerfreundlich sein.',
        wahl('nicht funktional', ['funktional', 'keine Anforderung']),
        wahl('nicht messbar', ['messbar', 'keine Anforderung']),
      ],
      [
        'Kunden können Rechnungen als PDF herunterladen.',
        wahl('funktional', ['nicht funktional', 'keine Anforderung']),
        wahl('messbar', ['nicht messbar', 'keine Anforderung']),
      ],
      [
        'Das Portal soll möglichst immer erreichbar sein.',
        wahl('nicht funktional', ['funktional', 'keine Anforderung']),
        wahl('nicht messbar', ['messbar', 'keine Anforderung']),
      ],
    ],
    explanation:
        'Antwortzeit, Bedienbarkeit und Erreichbarkeit beschreiben, WIE GUT das Portal arbeitet, sie sind also nicht funktional. Der PDF-Download ist eine Funktion und lässt sich eindeutig testen (vorhanden oder nicht). „Benutzerfreundlich“ und „möglichst immer“ haben keinen Zielwert. Besser wäre zum Beispiel „Verfügbarkeit mindestens 99,5 % im Monat“.',
  ),
  lueckentext(
    'i5-qe-2',
    'qm-merkmale',
    scenario:
        'Für einen Webshop ist eine Verfügbarkeit von 99,5 % je Monat vereinbart (Monat mit 30 Tagen, Betrieb rund um die Uhr). Im Juni war der Shop insgesamt 4 Stunden nicht erreichbar.',
    prompt: 'Prüfe, ob die vereinbarte Verfügbarkeit eingehalten wurde. (6 P.)',
    punkte: 6,
    text:
        'Stunden im Monat: {0} h\n'
        'Erlaubter Ausfall: {1} % der Zeit, das sind {2} h bzw. {3} min\n'
        'Erreichte Verfügbarkeit im Juni: {4} % (zwei Nachkommastellen)\n'
        'Die Vereinbarung wurde {5}.',
    luecken: [
      zahl(720, rationale: '30 × 24 h.'),
      zahl(0.5, toleranz: 0.001, rationale: '100 % - 99,5 %.'),
      zahl(3.6, toleranz: 0.01, rationale: '720 h × 0,005.'),
      zahl(216, rationale: '3,6 h × 60.'),
      zahl(99.44, toleranz: 0.01, rationale: '716 / 720 × 100 %.'),
      wahl('nicht eingehalten', ['eingehalten', 'übertroffen']),
    ],
    explanation:
        'Monat: 30 × 24 h = 720 h. Erlaubt: 0,5 % von 720 h = 3,6 h = 216 min.\n'
        'Juni: (720 - 4) / 720 = 716 / 720 = 99,44 %.\n'
        '4 h Ausfall sind mehr als 3,6 h. Die Verfügbarkeit von 99,5 % wurde verfehlt.',
  ),
  freitext(
    'i5-qe-3',
    'qm-merkmale',
    scenario:
        'Ein Logistikunternehmen lässt eine App für seine Handscanner entwickeln. Im Lastenheft steht: „Die Buchung einer Palette soll schnell gehen.“',
    prompt:
        'Formuliere die Anforderung so um, dass sie bei der Abnahme prüfbar ist, und nenne die Bestandteile, die du dabei ergänzt hast. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Messgröße genannt (Antwortzeit/Dauer der Buchung)',
        stichwoerter: ['Antwortzeit', 'Dauer', 'Sekunde', 'Messgröße'],
      ),
      krit(
        'konkreter Zielwert (z. B. höchstens 1 s)',
        stichwoerter: ['höchstens', 'maximal', 'max', 'Zielwert'],
      ),
      krit(
        'Bedingung genannt (z. B. bei 50 gleichzeitigen Scannern, im WLAN der Halle)',
        stichwoerter: ['bei', 'gleichzeitig', 'Bedingung', 'Last'],
      ),
      krit(
        'Abnahmekriterium/Prüfmethode (z. B. 95 % der Buchungen im Lasttest)',
        stichwoerter: ['95', 'Prozent', 'Lasttest', 'Abnahme', 'Test'],
      ),
    ],
    loesung:
        '„Bei 50 gleichzeitig angemeldeten Scannern ist in 95 % der Fälle die Buchung einer Palette nach höchstens 1 Sekunde bestätigt; geprüft wird mit einem Lasttest.“ Ergänzt wurden Messgröße (Antwortzeit), Zielwert (1 s), Bedingung (50 Scanner) und Abnahmekriterium (95 %, Lasttest).',
    explanation:
        'Je Bestandteil 1 Punkt. Ohne Zielwert und Bedingung kann niemand entscheiden, ob „schnell“ erreicht ist. Die Abnahme würde zum Streit.',
  ),
  paare(
    'i5-qe-4',
    'qm-merkmale',
    scenario:
        'In einem Lastenheft stehen unscharfe Formulierungen. Sie sollen durch messbare Größen ersetzt werden.',
    prompt:
        'Verbinde jede unscharfe Formulierung mit einer passenden Messgröße. (4 P.)',
    punkte: 4,
    paare: [
      paar('„Die Seite soll schnell laden.“', 'Ladezeit in Sekunden'),
      paar(
        '„Der Dienst soll immer laufen.“',
        'Verfügbarkeit in Prozent pro Monat',
      ),
      paar(
        '„Neue Nutzer sollen gut zurechtkommen.“',
        'Einarbeitungszeit bis zur ersten Buchung ohne Hilfe',
      ),
      paar(
        '„Nach einem Ausfall soll es bald weitergehen.“',
        'Wiederanlaufzeit in Minuten',
      ),
    ],
    explanation:
        'Jede unscharfe Formulierung bekommt eine Messgröße, zu der dann noch Zielwert und Bedingung kommen, etwa „Ladezeit höchstens 2 s bei 500 Nutzern“.',
  ),

  // ======================================================= PDCA und KVP
  tabelle(
    'i5-qp-1',
    'qm-pdca',
    scenario:
        'Die Hotline eines Systemhauses will mehr Anfragen beim ersten Kontakt lösen. Das Ziel ist eine Erstlösungsquote von mindestens 50 %. Vor der Maßnahme (Wissensdatenbank für die Hotline) wurden 120 von 400 Tickets beim ersten Kontakt gelöst, in der Pilotphase 198 von 360.',
    prompt: 'Werte die Pilotphase für die Phase Check aus. (5 P.)',
    punkte: 5,
    zeilen: [
      ['Kennzahl', 'Wert'],
      ['Erstlösungsquote vorher (%)', zahl(30)],
      ['Erstlösungsquote im Pilot (%)', zahl(55)],
      ['Veränderung in Prozentpunkten', zahl(25)],
      [
        'Ziel erreicht?',
        wahl('ja', ['nein', 'nicht messbar']),
      ],
      [
        'Folge in der Phase Act',
        wahl('Maßnahme wird Standard', [
          'Maßnahme wird verworfen',
          'Ziel wird gesenkt',
        ]),
      ],
    ],
    explanation:
        'Vorher: 120 / 400 = 30 %. Pilot: 198 / 360 = 55 %. Veränderung: 55 - 30 = 25 Prozentpunkte. 55 % liegen über dem Ziel von 50 %, es ist also erreicht. In der Phase Act wird die Wissensdatenbank deshalb für die ganze Hotline verbindlich eingeführt.',
  ),
  lueckentext(
    'i5-qp-2',
    'qm-pdca',
    scenario:
        'Ein IT-Dienstleister beschreibt in seinem Qualitätshandbuch, wie Verbesserungen ablaufen.',
    prompt: 'Setze die Phasen des PDCA-Zyklus an die richtige Stelle. (4 P.)',
    punkte: 4,
    text:
        'In der Phase {0} werden Ursachen analysiert, ein messbares Ziel gesetzt und die Maßnahme geplant.\n'
        'In der Phase {1} wird die Maßnahme in kleinem Rahmen erprobt.\n'
        'In der Phase {2} wird das Ergebnis mit dem Ziel verglichen.\n'
        'In der Phase {3} wird die Maßnahme bei Erfolg zum Standard, sonst wird nachgebessert.',
    luecken: [
      wort(['Plan'], 'Planen.'),
      wort(['Do'], 'Ausprobieren.'),
      wort(['Check'], 'Prüfen.'),
      wort(['Act'], 'Handeln.'),
    ],
    wortbank: ['Test', 'Review'],
    explanation:
        'Die Reihenfolge lautet Plan (analysieren, Ziel setzen, Maßnahme planen), Do (im Kleinen erproben), Check (Soll und Ist vergleichen), Act (standardisieren oder nachbessern). Danach beginnt der nächste Zyklus.',
  ),
  freitext(
    'i5-qp-3',
    'qm-pdca',
    scenario:
        'Ein Service-Desk hat eine neue Ticketvorlage vier Wochen lang erprobt. In der Phase Check liegt die Auswertung vor.',
    prompt:
        'Beschreibe, was in der Phase Act geschieht, für den Fall, dass das Ziel erreicht wurde, und für den Fall, dass es verfehlt wurde. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Ziel erreicht: Die Maßnahme wird zum verbindlichen Standard, dokumentiert und auf alle Bereiche ausgeweitet.',
        punkte: 2,
        stichwoerter: [
          'Standard',
          'standardisieren',
          'verbindlich',
          'ausweiten',
          'alle Bereiche',
          'dokumentieren',
        ],
      ),
      krit(
        'Ziel verfehlt: Ursachen klären, Maßnahme anpassen und einen neuen Zyklus starten.',
        punkte: 2,
        stichwoerter: [
          'Ursache',
          'anpassen',
          'nachbessern',
          'neuer Zyklus',
          'erneut',
        ],
      ),
    ],
    loesung:
        'Wurde das Ziel erreicht, wird die neue Ticketvorlage zum verbindlichen Standard für alle Teams und dokumentiert. Wurde es verfehlt, werden die Ursachen untersucht, die Maßnahme angepasst und in einem neuen Zyklus erneut erprobt.',
    explanation:
        'Je Fall 2 Punkte. Act hat immer zwei Ausgänge. In beiden Fällen dreht sich der Zyklus weiter, genau das macht PDCA zum Werkzeug der kontinuierlichen Verbesserung.',
  ),

  // ============================================================ Teststufen
  paare(
    'i5-ss-1',
    'ts-stufen',
    scenario:
        'Im Testkonzept einer Lagerverwaltung werden die Teststufen und der Regressionstest beschrieben.',
    prompt: 'Ordne jedem Test seinen Prüfgegenstand zu. (5 P.)',
    punkte: 5,
    paare: [
      paar('Komponententest', 'Einzelne Funktion oder Klasse'),
      paar('Integrationstest', 'Schnittstellen zwischen Komponenten'),
      paar('Systemtest', 'Gesamtsystem gegen das Pflichtenheft'),
      paar('Abnahmetest', 'Kunde entscheidet über die Annahme'),
      paar('Regressionstest', 'Wiederholung nach einer Änderung'),
    ],
    explanation:
        'Der Prüfgegenstand wächst von Stufe zu Stufe: Komponente, Schnittstellen, Gesamtsystem, Abnahme durch den Auftraggeber. Der Regressionstest ist keine Stufe, sondern eine Testart: Nach Änderungen werden bestandene Tests wiederholt.',
  ),
  freitext(
    'i5-ss-2',
    'ts-stufen',
    scenario:
        'Ein Softwarehaus liefert eine Auftragsverwaltung an einen Großhändler. Vor der Übergabe findet der Systemtest statt, danach der Abnahmetest.',
    prompt:
        'Erläutere zwei Unterschiede zwischen Systemtest und Abnahmetest. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Verantwortung: Den Systemtest führt der Auftragnehmer durch, den Abnahmetest der Auftraggeber.',
        punkte: 2,
        stichwoerter: [
          'Auftragnehmer',
          'Auftraggeber',
          'Kunde',
          'Hersteller',
          'Anwender',
        ],
      ),
      krit(
        'Maßstab: Systemtest gegen die Spezifikation (Pflichtenheft), Abnahmetest gegen die vereinbarten Abnahmekriterien mit Entscheidung über die Annahme.',
        punkte: 2,
        stichwoerter: [
          'Pflichtenheft',
          'Spezifikation',
          'Abnahmekriterien',
          'Annahme',
          'Entscheidung',
        ],
      ),
      krit(
        'Umgebung: Systemtest in der Testumgebung, Abnahmetest mit echten Geschäftsfällen in der Umgebung des Kunden.',
        punkte: 2,
        stichwoerter: [
          'Testumgebung',
          'echte Daten',
          'Echtdaten',
          'Geschäftsfälle',
          'produktiv',
        ],
      ),
    ],
    loesung:
        'Den Systemtest führt der Auftragnehmer durch und prüft das Gesamtsystem gegen das Pflichtenheft. Den Abnahmetest führt der Auftraggeber durch: Er prüft gegen die vereinbarten Abnahmekriterien und entscheidet über die Annahme.',
    explanation:
        'Je Unterschied 2 Punkte, höchstens 4. Merkhilfe: Im Systemtest weist der Auftragnehmer nach, dass er richtig gebaut hat. Im Abnahmetest entscheidet der Kunde.',
  ),
  markieren(
    'i5-ss-3',
    'ts-stufen',
    scenario:
        'Im Testplan eines Webshops stehen sechs Tests. Die Projektleitung will wissen, welche davon nicht funktionale Eigenschaften prüfen.',
    prompt:
        'Markiere alle Tests, die eine nicht funktionale Eigenschaft prüfen. (3 P.)',
    punkte: 3,
    zeilen: [
      ja(
        'Lasttest mit 500 gleichzeitigen Nutzern',
        'Prüft das Zeitverhalten unter Last, also eine Qualitätseigenschaft.',
      ),
      nein(
        'Test der Rabattberechnung im Warenkorb',
        'Prüft eine Funktion: Wird richtig gerechnet?',
      ),
      ja('Usability-Test mit fünf Kundinnen', 'Prüft die Bedienbarkeit.'),
      nein(
        'Test der Bestellbestätigung per E-Mail',
        'Prüft eine Funktion: Wird die Mail verschickt?',
      ),
      ja(
        'Stresstest bis zum Ausfall des Servers',
        'Prüft das Verhalten über der Belastungsgrenze.',
      ),
      nein(
        'Test der Artikelsuche nach Stichwort',
        'Prüft eine Funktion: Werden die richtigen Artikel gefunden?',
      ),
    ],
    explanation:
        'Funktionale Tests prüfen, WAS das System tut (Rabatt, Mail, Suche). Nicht funktionale Tests prüfen, WIE GUT es das tut: Last- und Stresstest (Effizienz, Zuverlässigkeit), Usability-Test (Benutzbarkeit).',
  ),

  // ================================================ Black-Box und White-Box
  tabelle(
    'i5-sv-1',
    'ts-verfahren',
    scenario:
        'Eine Funktion berechnet die Versandkosten eines Pakets. Für den Test werden vier Aufrufe vorbereitet.',
    code:
        'funktion versand(gewicht, express)\n'
        '  preis = 4\n'
        '  WENN gewicht > 5 DANN\n'
        '    preis = preis + 3\n'
        '  ENDE WENN\n'
        '  WENN express = wahr DANN\n'
        '    preis = preis * 2\n'
        '  ENDE WENN\n'
        '  RÜCKGABE preis',
    prompt:
        'Ermittle per Schreibtischtest das Soll-Ergebnis jedes Testfalls. (4 P.)',
    punkte: 4,
    zeilen: [
      ['Testfall', 'gewicht', 'express', 'Rückgabe'],
      ['T1', '2', 'falsch', zahl(4)],
      ['T2', '8', 'falsch', zahl(7)],
      ['T3', '2', 'wahr', zahl(8)],
      ['T4', '8', 'wahr', zahl(14)],
    ],
    explanation:
        'T1: keine Bedingung erfüllt, preis = 4.\n'
        'T2: 8 > 5, also 4 + 3 = 7.\n'
        'T3: nur express, also 4 × 2 = 8.\n'
        'T4: erst 4 + 3 = 7, dann 7 × 2 = 14.\n'
        'Die Reihenfolge der Anweisungen entscheidet: erst der Zuschlag, dann die Verdopplung.',
  ),
  lueckentext(
    'i5-sv-2',
    'ts-verfahren',
    scenario:
        'Für die Funktion versand gibt es die Testfälle T1 (gewicht 2, express falsch) und T4 (gewicht 8, express wahr). Jede der beiden Abfragen hat einen Ja- und einen Nein-Zweig.',
    code:
        'funktion versand(gewicht, express)\n'
        '  preis = 4\n'
        '  WENN gewicht > 5 DANN\n'
        '    preis = preis + 3\n'
        '  ENDE WENN\n'
        '  WENN express = wahr DANN\n'
        '    preis = preis * 2\n'
        '  ENDE WENN\n'
        '  RÜCKGABE preis',
    prompt: 'Bestimme die Überdeckung durch die Testfälle. (4 P.)',
    punkte: 4,
    text:
        'T1 allein durchläuft {0} von 4 Zweigen, die Zweigüberdeckung beträgt {1} %.\n'
        'T1 und T4 zusammen erreichen eine Zweigüberdeckung von {2} %.\n'
        'T4 allein erreicht eine Anweisungsüberdeckung von {3} %.',
    luecken: [
      zahl(2, rationale: 'Beide Nein-Zweige.'),
      zahl(50, rationale: '2 / 4 × 100 %.'),
      zahl(100, rationale: 'T4 ergänzt beide Ja-Zweige.'),
      zahl(100, rationale: 'T4 führt jede Anweisung aus.'),
    ],
    explanation:
        'T1 nimmt bei beiden Abfragen den Nein-Zweig: 2 von 4 Zweigen = 50 %. T4 nimmt beide Ja-Zweige, zusammen 100 % Zweigüberdeckung. T4 allein führt jede Anweisung aus (100 % Anweisungsüberdeckung), deckt aber nur die Hälfte der Zweige ab.',
  ),
  paare(
    'i5-sv-3',
    'ts-verfahren',
    scenario:
        'In der Testschulung eines Softwarehauses werden die Begriffe der Testverfahren wiederholt.',
    prompt: 'Ordne jedem Begriff die passende Erklärung zu. (6 P.)',
    punkte: 6,
    paare: [
      paar('Black-Box-Test', 'Testfälle aus der Spezifikation'),
      paar('White-Box-Test', 'Testfälle aus dem Quellcode'),
      paar('Äquivalenzklasse', 'Eingaben mit gleichem Verhalten'),
      paar('Grenzwertanalyse', 'Werte an den Rändern der Klassen'),
      paar('Zweigüberdeckung', 'Jeder Ja- und Nein-Ausgang einmal'),
      paar('Anweisungsüberdeckung', 'Jede Anweisung mindestens einmal'),
    ],
    explanation:
        'Der Black-Box-Test prüft von außen nach der Spezifikation (Äquivalenzklassen, Grenzwerte), der White-Box-Test mit Blick in den Code (Anweisungs- und Zweigüberdeckung). Die Zweigüberdeckung ist strenger als die Anweisungsüberdeckung.',
  ),
  freitext(
    'i5-sv-4',
    'ts-verfahren',
    scenario:
        'Ein Entwicklungsteam diskutiert, ob für ein Abrechnungsmodul Black-Box- oder White-Box-Tests wichtiger sind.',
    prompt:
        'Beschreibe je einen Vorteil des Black-Box-Tests und des White-Box-Tests. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Black-Box: prüft aus Sicht der Anforderungen, unabhängig von der Umsetzung, und findet auch fehlende oder falsch verstandene Funktionen.',
        punkte: 2,
        stichwoerter: [
          'Anforderungen',
          'Spezifikation',
          'Anwendersicht',
          'unabhängig',
          'fehlende Funktionen',
        ],
      ),
      krit(
        'White-Box: nutzt die Kenntnis des Codes und deckt nicht durchlaufene Zweige und Anweisungen auf, die Überdeckung ist messbar.',
        punkte: 2,
        stichwoerter: [
          'Zweige',
          'Pfade',
          'Überdeckung',
          'Codekenntnis',
          'Struktur',
          'toter Code',
        ],
      ),
    ],
    loesung:
        'Der Black-Box-Test prüft das Verhalten gegen die Anforderungen, ohne den Code zu kennen. So fallen auch fehlende Funktionen auf. Der White-Box-Test nutzt die Kenntnis des Codes und stellt sicher, dass jeder Zweig mindestens einmal durchlaufen wird; die Überdeckung lässt sich messen.',
    explanation:
        'Je Vorteil 2 Punkte. Die Verfahren ergänzen sich: Der Black-Box-Test findet, was fehlt oder falsch verstanden wurde, der White-Box-Test findet, was im Code nie getestet wurde.',
  ),

  // ====================================================== Testfälle entwerfen
  tabelle(
    'i5-sf-1',
    'ts-testfaelle',
    scenario:
        'Im Urlaubsantrag eines Personalportals wird die Zahl der Urlaubstage als ganze Zahl eingegeben. Erlaubt sind 1 bis 30 Tage.',
    prompt: 'Bilde die Äquivalenzklassen und trage die Grenzwerte ein. (5 P.)',
    punkte: 5,
    zeilen: [
      ['Äquivalenzklasse', 'Art', 'kleinster Wert', 'größter Wert'],
      [
        'kleiner als 1',
        wahl('ungültig', ['gültig', 'nicht testbar']),
        '-',
        zahl(0),
      ],
      [
        '1 bis 30',
        wahl('gültig', ['ungültig', 'nicht testbar']),
        zahl(1),
        zahl(30),
      ],
      [
        'größer als 30',
        wahl('ungültig', ['gültig', 'nicht testbar']),
        zahl(31),
        '-',
      ],
    ],
    explanation:
        'Es gibt drei Klassen: zu klein (ungültig), 1 bis 30 (gültig), zu groß (ungültig). Die Grenzwertanalyse testet die Werte direkt an den Übergängen: 0 und 1 sowie 30 und 31. Dort entstehen typische Fehler wie > statt >=.',
  ),
  tabelle(
    'i5-sf-2',
    'ts-testfaelle',
    scenario:
        'Ein Webshop gewährt Rabatt auf den Bestellwert (ganze Euro): unter 100 € kein Rabatt, von 100 € bis 499 € 5 %, ab 500 € 10 %. Negative Bestellwerte werden mit einer Fehlermeldung abgelehnt.',
    prompt:
        'Vervollständige die Testfalltabelle: Soll-Rabatt in Euro und Art des Testwerts. (8 P.)',
    punkte: 8,
    zeilen: [
      ['Nr.', 'Bestellwert (€)', 'Soll-Rabatt (€)', 'Art des Testwerts'],
      [
        '1',
        '99',
        zahl(0),
        wahl('Grenzwert', ['Repräsentant', 'Negativtest']),
      ],
      ['2', '100', zahl(5), 'Grenzwert'],
      [
        '3',
        '300',
        zahl(15),
        wahl('Repräsentant', ['Grenzwert', 'Negativtest']),
      ],
      ['4', '499', zahl(24.95, toleranz: 0.01), 'Grenzwert'],
      ['5', '500', zahl(50), 'Grenzwert'],
      [
        '6',
        '-20',
        'Fehlermeldung',
        wahl('Negativtest', ['Grenzwert', 'Repräsentant']),
      ],
    ],
    explanation:
        '99 €: kein Rabatt (0 €). 100 €: 5 % = 5 €. 300 €: 5 % = 15 €. 499 €: 5 % = 24,95 €. 500 €: 10 % = 50 €.\n'
        '99/100 und 499/500 sind Grenzwerte an den Klassenübergängen, 300 ist ein Repräsentant aus der Mitte der Klasse, -20 prüft als Negativtest eine ungültige Eingabe.',
  ),
  markieren(
    'i5-sf-3',
    'ts-testfaelle',
    scenario:
        'In einem Bewerbungsformular ist das Alter als ganze Zahl von 18 bis 67 Jahren zulässig. Eine Kollegin hat sechs Testfälle entworfen.',
    prompt: 'Markiere alle Testfälle, die fehlerhaft sind. (3 P.)',
    punkte: 3,
    zeilen: [
      nein(
        'TF1: Eingabe 18, Soll: angenommen',
        '18 ist die untere Grenze und gültig.',
      ),
      ja(
        'TF2: Eingabe 17, Soll: angenommen',
        '17 liegt unter der Grenze und muss abgelehnt werden.',
      ),
      ja(
        'TF3: Eingabe 67, Soll: abgelehnt',
        '67 ist die obere Grenze und noch gültig.',
      ),
      nein(
        'TF4: Eingabe 68, Soll: abgelehnt',
        '68 liegt über der Grenze, die Ablehnung ist also richtig.',
      ),
      nein(
        'TF5: Eingabe „abc“, Soll: Fehlermeldung',
        'Ein sinnvoller Negativtest für nicht numerische Eingaben.',
      ),
      ja(
        'TF6: Eingabe 40, Soll: nicht angegeben',
        'Ohne erwartetes Ergebnis lässt sich nicht entscheiden, ob der Test bestanden ist.',
      ),
    ],
    explanation:
        '„18 bis 67“ schließt beide Grenzen ein: 17 und 68 werden abgelehnt, 18 und 67 angenommen. Jeder Testfall braucht außerdem ein Soll-Ergebnis, das vor der Durchführung feststeht.',
  ),
  freitext(
    'i5-sf-4',
    'ts-testfaelle',
    scenario:
        'Eine Auszubildende soll für die Anmeldung eines Kundenportals Testfälle schreiben, die auch ein anderer Tester ohne Rückfrage ausführen kann.',
    prompt:
        'Nenne vier Angaben, die ein vollständig beschriebener Testfall enthält. (4 P.)',
    punkte: 4,
    kriterien: [
      krit(
        'Eindeutige Kennung oder Bezeichnung des Testfalls',
        stichwoerter: ['Kennung', 'Nummer', 'Bezeichnung', 'Testfall-ID'],
      ),
      krit(
        'Vorbedingung (Ausgangszustand)',
        stichwoerter: ['Vorbedingung', 'Ausgangszustand', 'Voraussetzung'],
      ),
      krit(
        'Eingaben bzw. Testdaten',
        stichwoerter: ['Eingabe', 'Testdaten', 'Eingabewerte'],
      ),
      krit(
        'Auszuführende Schritte',
        stichwoerter: ['Schritte', 'Ablauf', 'Aktion', 'Durchführung'],
      ),
      krit(
        'Erwartetes Ergebnis (Soll-Ergebnis)',
        stichwoerter: ['Soll', 'erwartet', 'erwartetes Ergebnis'],
      ),
      krit(
        'Nachbedingung (Zustand nach dem Test)',
        stichwoerter: ['Nachbedingung', 'Endzustand', 'Zustand danach'],
      ),
    ],
    loesung:
        'Ein Testfall enthält eine eindeutige Kennung, die Vorbedingung (z. B. „Nutzer ist registriert“), die Eingaben bzw. Testdaten mit den auszuführenden Schritten und das erwartete Ergebnis (Soll).',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Das Ist-Ergebnis gehört nicht zum Testfall, sondern entsteht erst bei der Durchführung und steht im Testprotokoll.',
  ),

  // ============================================ Testplanung und Testprotokoll
  tabelle(
    'i5-sp-1',
    'ts-protokoll',
    scenario:
        'Im Testprotokoll eines Bestellformulars sind Soll- und Ist-Ergebnisse eingetragen. Die Spalte „Ergebnis“ fehlt noch. Bei TF-05 war der Mailserver der Testumgebung nicht erreichbar.',
    prompt: 'Bewerte jeden Testfall. (5 P.)',
    punkte: 5,
    zeilen: [
      ['Testfall', 'Soll', 'Ist', 'Ergebnis'],
      [
        'TF-01',
        'Meldung „Pflichtfeld“',
        'Meldung „Pflichtfeld“',
        wahl('bestanden', ['fehlgeschlagen', 'blockiert']),
      ],
      [
        'TF-02',
        'Rabatt 5 %',
        'Rabatt 0 %',
        wahl('fehlgeschlagen', ['bestanden', 'blockiert']),
      ],
      [
        'TF-03',
        'PDF wird erzeugt',
        'PDF wird erzeugt',
        wahl('bestanden', ['fehlgeschlagen', 'blockiert']),
      ],
      [
        'TF-04',
        'Eingabe abgelehnt',
        'Eingabe angenommen',
        wahl('fehlgeschlagen', ['bestanden', 'blockiert']),
      ],
      [
        'TF-05',
        'Mail an Kunden',
        'nicht durchführbar',
        wahl('blockiert', ['bestanden', 'fehlgeschlagen']),
      ],
    ],
    explanation:
        'Bestanden ist ein Testfall nur, wenn Ist und Soll übereinstimmen (TF-01, TF-03). Bei TF-02 und TF-04 weicht das Ist vom Soll ab. Beide sind fehlgeschlagen und bekommen eine Fehlermeldung. TF-05 konnte nicht ausgeführt werden. Er ist blockiert, wird nachgeholt und zählt bis dahin nicht als bestanden.',
  ),
  lueckentext(
    'i5-sp-2',
    'ts-protokoll',
    scenario:
        'Im Systemtest eines Kundenportals waren 80 Testfälle geplant. 75 wurden durchgeführt, davon 66 bestanden. Endekriterium: Mindestens 95 % der durchgeführten Testfälle sind bestanden.',
    prompt: 'Werte den Teststand aus. (4 P.)',
    punkte: 4,
    text:
        'Durchgeführt wurden {0} % der geplanten Testfälle (zwei Nachkommastellen).\n'
        'Bestehensquote der durchgeführten Testfälle: {1} %\n'
        'Fehlgeschlagen sind {2} Testfälle.\n'
        'Das Endekriterium ist {3}.',
    luecken: [
      zahl(93.75, toleranz: 0.01, rationale: '75 / 80 × 100 %.'),
      zahl(88, rationale: '66 / 75 × 100 %.'),
      zahl(9, rationale: '75 - 66.'),
      wahl('nicht erfüllt', ['erfüllt', 'nicht prüfbar']),
    ],
    explanation:
        'Durchführungsquote: 75 / 80 = 93,75 %. Bestehensquote: 66 / 75 = 88 %. Fehlgeschlagen: 75 - 66 = 9. Mit 88 % ist das Endekriterium von 95 % verfehlt. Die Fehler werden behoben und nachgetestet, die fünf offenen Testfälle werden nachgeholt.',
  ),
  markieren(
    'i5-sp-3',
    'ts-protokoll',
    scenario:
        'Ein Team nutzt drei Fehlerklassen: kritisch (Absturz, Datenverlust oder Hauptfunktion ohne Umgehung blockiert), schwer (Funktion gestört, Umgehung möglich), kosmetisch (optischer Mangel).',
    prompt: 'Markiere alle falsch eingestuften Fehlermeldungen. (3 P.)',
    punkte: 3,
    zeilen: [
      nein(
        'F-11: Tippfehler im Menüpunkt „Einstelungen“: kosmetisch',
        'Ein optischer Mangel ohne Einfluss auf die Funktion.',
      ),
      ja(
        'F-12: Beim Speichern gehen Kundendaten verloren: kosmetisch',
        'Datenverlust ist ein kritischer Fehler.',
      ),
      nein(
        'F-13: Export gelingt nur über einen Umweg: schwer',
        'Die Funktion ist gestört, eine Umgehung ist aber möglich. Das ist ein schwerer Fehler.',
      ),
      ja(
        'F-14: Logo um zwei Pixel verschoben: kritisch',
        'Ein optischer Mangel ist kosmetisch.',
      ),
      nein(
        'F-15: Anwendung stürzt beim Start ab: kritisch',
        'Ein Absturz ist kritisch.',
      ),
      ja(
        'F-16: Bestellen ist ohne Umgehung unmöglich: schwer',
        'Eine Hauptfunktion ist ohne Umgehung blockiert. Das ist ein kritischer Fehler.',
      ),
    ],
    explanation:
        'Die Fehlerklasse richtet sich nach der Auswirkung: Datenverlust, Absturz und blockierte Hauptfunktionen sind kritisch, gestörte Funktionen mit Umgehung schwer und optische Mängel kosmetisch. Die Priorität (wie dringend der Fehler behoben wird) wird getrennt davon festgelegt.',
  ),
  paare(
    'i5-sp-4',
    'ts-protokoll',
    scenario:
        'Für das Qualitätshandbuch werden die Dokumente und Schritte rund um die Testdurchführung beschrieben.',
    prompt: 'Ordne jedem Begriff seine Aufgabe zu. (6 P.)',
    punkte: 6,
    paare: [
      paar('Testkonzept', 'Plant Ziele, Umfang und Endekriterien'),
      paar('Testfall', 'Legt Eingabe und Soll-Ergebnis fest'),
      paar('Testprotokoll', 'Hält das Ist-Ergebnis fest'),
      paar('Fehlermeldung', 'Beschreibt die Abweichung nachstellbar'),
      paar('Nachtest', 'Wiederholt den fehlgeschlagenen Testfall'),
      paar('Regressionstest', 'Sucht Nebenwirkungen der Korrektur'),
    ],
    explanation:
        'Vor dem Test entstehen das Testkonzept und die Testfälle. Bei der Durchführung wird das Testprotokoll geführt, bei Abweichungen kommt eine Fehlermeldung dazu. Nach der Korrektur folgen der Nachtest des betroffenen Testfalls und der Regressionstest der übrigen Funktionen.',
  ),
];
