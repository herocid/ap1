import '../../models/flashcard.dart';
import '../builders.dart';

/// Karten zu Bereich 01, Teil 2: Terminplanung, Risiko, Wirtschaftlichkeit
/// und Projektabschluss.
///
/// Ergänzt die Karten c-tp-*, c-ri-*, c-wi-* und c-ab-* aus
/// `cards_a01_projekte.dart`.
final List<Flashcard> cardsA01Planung = [
  // Projektstrukturplan
  karte(
    'k-tp-1',
    't-psp',
    'Gliederungsarten des PSP',
    'Objektorientiert (Bestandteile), funktionsorientiert (Tätigkeiten), phasenorientiert (Projektphasen) - oder gemischt.',
  ),
  karte(
    'k-tp-2',
    't-psp',
    'Was der PSP nicht zeigt',
    'Reihenfolge, Abhängigkeiten und Termine. Die kommen erst im Netzplan bzw. Gantt-Diagramm dazu.',
  ),
  karte(
    'k-tp-3',
    't-psp',
    '100-%-Regel',
    'Die Elemente einer Ebene decken zusammen genau den Umfang des übergeordneten Elements ab - nichts fehlt, nichts doppelt.',
  ),
  karte(
    'k-tp-4',
    't-psp',
    'PSP-Code 2.1.3',
    'Teilaufgabe 2, darin Teilaufgabe 1, darin Arbeitspaket 3 - also ein Element auf Ebene 3.',
  ),
  karte(
    'k-tp-5',
    't-psp',
    'Top-down vs. Bottom-up',
    'Top-down: Projekt schrittweise zerlegen (bekannte Projekte). Bottom-up: Tätigkeiten sammeln und gruppieren (neuartige Projekte).',
  ),
  karte(
    'k-tp-6',
    't-psp',
    'Arbeitspaketbeschreibung',
    'PSP-Code, Name, Verantwortliche/r, Ergebnis, Voraussetzungen, Aufwand, Termin.',
  ),

  // Gantt-Diagramm und Meilensteine
  karte(
    'k-tg-1',
    't-gantt',
    'Normalfolge (Ende-Anfang)',
    'Der Nachfolger beginnt, wenn der Vorgänger endet - die Standardbeziehung im Netzplan und Gantt-Diagramm.',
  ),
  karte(
    'k-tg-2',
    't-gantt',
    'Startzeitpunkt eines Nachfolgers',
    'Das späteste Ende aller seiner Vorgänger. Ende = Start + Dauer.',
  ),
  karte(
    'k-tg-3',
    't-gantt',
    'MTA: Wann ist ein Meilenstein erreicht?',
    'Wenn seine Linie die Diagonale trifft - Berichtszeitpunkt und prognostizierter Termin sind dann gleich.',
  ),
  karte(
    'k-tg-4',
    't-gantt',
    'Meilenstein im Gantt-Diagramm',
    'Raute auf der Zeitachse, Dauer 0, verbraucht keine Ressourcen.',
  ),

  // Ressourcen und Aufwand
  karte(
    'k-tr-1',
    't-ressourcen',
    'Drei-Punkt-Schätzung',
    'Erwartungswert = (optimistisch + 4 × wahrscheinlich + pessimistisch) / 6.',
    'O = 6, M = 9, P = 18 -> (6 + 36 + 18) / 6 = 10 PT.',
  ),
  karte(
    'k-tr-2',
    't-ressourcen',
    'Benötigte Personen berechnen',
    'Personen = Aufwand / (Dauer × Verfügbarkeit) - immer aufrunden.',
  ),
  karte(
    'k-tr-3',
    't-ressourcen',
    'Nettokapazität',
    'Arbeitstage minus Urlaub, Krankheit, Schulung - dann mal Verfügbarkeitsgrad. Ergebnis in Personentagen.',
  ),
  karte(
    'k-tr-4',
    't-ressourcen',
    'Kapazitätsausgleich',
    'Überlast beseitigen: Vorgänge im Puffer verschieben, Arbeit umverteilen, Überstunden, Zusatzkapazität, zuletzt Termin oder Umfang ändern.',
  ),

  // Der Risikomanagement-Prozess
  karte(
    'k-rp-1',
    'r-prozess',
    'Risiken identifizieren - Methoden',
    'Brainstorming, Checklisten, Lessons Learned früherer Projekte, Befragung von Fachleuten.',
  ),
  karte(
    'k-rp-2',
    'r-prozess',
    'Risikoarten',
    'Technisch, personell, wirtschaftlich, organisatorisch, terminlich, rechtlich.',
  ),
  karte(
    'k-rp-3',
    'r-prozess',
    'Ein Risiko beschreiben',
    'Ursache - Ereignis - Auswirkung: „Weil ..., könnte ..., sodass ...“.',
  ),
  karte(
    'k-rp-4',
    'r-prozess',
    'Frühwarnindikator',
    'Beobachtbares Zeichen, dass ein Risiko wahrscheinlicher wird - z. B. Lieferant bestätigt den Termin nicht.',
  ),
  karte(
    'k-rp-5',
    'r-prozess',
    'Risikoeigner',
    'Die Person, die ein bestimmtes Risiko überwacht und bei Bedarf die geplante Maßnahme auslöst.',
  ),

  // Risiken bewerten
  karte(
    'k-rb-1',
    'r-bewertung',
    'Priorisierung von Risiken',
    'Nach Risikowert absteigend - existenzbedrohende Risiken zusätzlich immer gesondert behandeln.',
  ),
  karte(
    'k-rb-2',
    'r-bewertung',
    'Qualitativ vs. quantitativ bewerten',
    'Qualitativ: Stufen gering/mittel/hoch (1-3), Ergebnis Risikokennzahl. Quantitativ: Prozent × Euro, Ergebnis Risikowert.',
  ),
  karte(
    'k-rb-3',
    'r-bewertung',
    '3×3-Matrix: Farben',
    'Kennzahl 1-2 grün (beobachten), 3-4 gelb (Maßnahmen planen), 6-9 rot (sofort handeln).',
  ),
  karte(
    'k-rb-4',
    'r-bewertung',
    'Lohnt sich eine Maßnahme?',
    'Wenn Risikowert vorher minus Risikowert nachher größer ist als die Kosten der Maßnahme.',
  ),

  // Risikostrategien
  karte(
    'k-rs-1',
    'r-strategien',
    'Präventiv vs. korrektiv',
    'Präventiv: wirkt vor dem Eintritt, senkt die Wahrscheinlichkeit. Korrektiv (Notfallplan): greift nach dem Eintritt, begrenzt den Schaden.',
  ),
  karte(
    'k-rs-2',
    'r-strategien',
    'Strategie nach Lage in der Matrix',
    'Häufig und teuer: vermeiden. Selten, aber teuer: übertragen. Häufig, aber billig: vermindern. Selten und billig: akzeptieren.',
  ),
  karte(
    'k-rs-3',
    'r-strategien',
    'Restrisiko berechnen',
    'Neue Wahrscheinlichkeit × neue Schadenshöhe nach allen Maßnahmen - danach neu einstufen.',
  ),

  // Projektkosten kalkulieren
  karte(
    'k-wk-1',
    'w-kalkulation',
    'Schema Angebotskalkulation',
    'Personaleinzelkosten + Gemeinkostenzuschlag + Sachkosten = Selbstkosten; + Gewinn = netto; + 19 % USt = brutto.',
  ),
  karte(
    'k-wk-2',
    'w-kalkulation',
    'Einzel- vs. Gemeinkosten',
    'Einzelkosten sind dem Projekt direkt zurechenbar (Projektstunden, gekaufte Hardware). Gemeinkosten nur anteilig über einen Zuschlag (Miete, Verwaltung).',
  ),
  karte(
    'k-wk-3',
    'w-kalkulation',
    'Tagessatz',
    'Stundensatz × Stunden pro Arbeitstag, meist × 8.',
  ),
  karte(
    'k-wk-4',
    'w-kalkulation',
    'Quantitativer Angebotsvergleich',
    'Für jedes Angebot den Bezugspreis berechnen - erst Rabatt, Skonto und Bezugskosten zeigen, welches wirklich günstiger ist.',
  ),

  // Nutzwertanalyse
  karte(
    'k-wn-1',
    'w-nutzwert',
    'Schritte der Nutzwertanalyse',
    'Kriterien festlegen, gewichten (Summe 100 %), bewerten, Punkte × Gewicht, addieren, höchsten Nutzwert wählen.',
  ),
  karte(
    'k-wn-2',
    'w-nutzwert',
    'K.-o.-Kriterium',
    'Mussanforderung, die jede Alternative erfüllen muss. Wer sie verfehlt, scheidet vor der Nutzwertberechnung aus.',
  ),
  karte(
    'k-wn-3',
    'w-nutzwert',
    'Teilnutzwert',
    'Gewicht × Punkte eines Kriteriums, z. B. 0,40 × 8 = 3,20. Summe der Teilnutzwerte = Nutzwert.',
  ),
  karte(
    'k-wn-4',
    'w-nutzwert',
    'Quantitativer vs. qualitativer Vergleich',
    'Quantitativ: Preise und Kosten in Euro (Bezugskalkulation). Qualitativ: gewichtete Kriterien mit Punkten (Nutzwertanalyse).',
  ),
  karte(
    'k-wn-5',
    'w-nutzwert',
    'Knappes Ergebnis - was tun?',
    'Prüfen, ob das Ergebnis kippt, wenn man ein Gewicht leicht ändert. Wenn ja, ist die Entscheidung nicht robust.',
  ),

  // Make or Buy
  karte(
    'k-wm-1',
    'w-makeorbuy',
    'Make vs. Buy - Kernargumente',
    'Make: passgenau, Know-how bleibt im Haus. Buy: schnell verfügbar, geringere Entwicklungskosten, aber Abhängigkeit vom Anbieter.',
  ),
  karte(
    'k-wm-2',
    'w-makeorbuy',
    'Kritische Menge',
    '(Fixkosten make - Fixkosten buy) / (Stückpreis buy - Stückkosten make). Dort kosten beide Wege gleich viel.',
  ),
  karte(
    'k-wm-3',
    'w-makeorbuy',
    'Unter- und oberhalb der kritischen Menge',
    'Darunter gewinnt der Weg mit niedrigen Fixkosten (meist buy), darüber der mit niedrigen Stückkosten (meist make).',
  ),
  karte(
    'k-wm-4',
    'w-makeorbuy',
    'Qualitative Make-or-Buy-Kriterien',
    'Kernkompetenz, Know-how und Kapazität, Zeitbedarf, Abhängigkeit vom Anbieter, Datenschutz und Sicherheit.',
  ),

  // Break-even und Amortisation
  karte(
    'k-wb-1',
    'w-breakeven',
    'Amortisation mit laufenden Kosten',
    'Amortisationsdauer = Investition / (Einsparung - laufende Kosten) pro Jahr.',
  ),
  karte(
    'k-wb-2',
    'w-breakeven',
    'Gewinn bei Menge x',
    'Deckungsbeitrag je Stück × x - Fixkosten.',
    '20 € × 800 - 10.000 € = 6.000 €.',
  ),
  karte(
    'k-wb-3',
    'w-breakeven',
    'Return on Investment (ROI)',
    'ROI = Gewinn / eingesetztes Kapital × 100 %. Gewinn = Rückflüsse - Investition.',
  ),
  karte(
    'k-wb-4',
    'w-breakeven',
    'Krumme Break-even-Menge',
    'Immer aufrunden: 333,3 Stück heißt 334 Stück, denn bei 333 sind die Kosten noch nicht gedeckt.',
  ),
  karte(
    'k-wb-5',
    'w-breakeven',
    'Amortisation in Monaten',
    'Nachkommateil der Jahre × 12: 3,75 Jahre = 3 Jahre und 0,75 × 12 = 9 Monate.',
  ),

  // Abnahme und Übergabe
  karte(
    'k-aa-1',
    'a-abnahme',
    'Rechtsfolgen der Abnahme',
    'Vergütung fällig, Gefahrübergang, Beweislast für Mängel beim Auftraggeber, Verjährung der Mängelansprüche beginnt.',
  ),
  karte(
    'k-aa-2',
    'a-abnahme',
    'Unwesentlicher Mangel bei der Abnahme',
    'Kein Grund zur Verweigerung - abnehmen und den Mangel mit Frist ins Protokoll aufnehmen (Vorbehalt).',
  ),
  karte(
    'k-aa-3',
    'a-abnahme',
    'Konkludente Abnahme',
    'Stillschweigende Abnahme durch schlüssiges Verhalten, z. B. vorbehaltlose produktive Nutzung.',
  ),
  karte(
    'k-aa-4',
    'a-abnahme',
    'Einführungsstrategien',
    'Stichtag (Big Bang), Parallelbetrieb, stufenweise Einführung, Pilotbetrieb.',
  ),
  karte(
    'k-aa-5',
    'a-abnahme',
    'Parallelbetrieb',
    'Altes und neues System laufen eine Zeit lang gleichzeitig: sicherer Rückfall, aber doppelter Aufwand.',
  ),

  // Abschlussbericht und Soll-Ist
  karte(
    'k-ab-1',
    'a-bericht',
    'Relative Abweichung',
    '(Ist - Soll) / Soll × 100 % - Bezugsgröße ist immer das Soll.',
  ),
  karte(
    'k-ab-2',
    'a-bericht',
    'Zielerreichungsgrad berechnen',
    'Erreichte / geplante Ziele × 100 %, z. B. 7 von 8 Muss-Anforderungen = 87,5 %.',
  ),
  karte(
    'k-ab-3',
    'a-bericht',
    'Typische Ursachen für Abweichungen',
    'Schätzfehler, Änderungswünsche ohne Budgetanpassung, Personalausfall, Lieferverzug, technische Probleme.',
  ),
  karte(
    'k-ab-4',
    'a-bericht',
    'Soll-Ist-Vergleich: drei Größen',
    'Leistung (Umfang, Qualität), Zeit (Termine) und Kosten (Budget) - die Ecken des magischen Dreiecks.',
  ),

  // Lessons Learned
  karte(
    'k-al-1',
    'a-lessons',
    'Lessons Learned bei Projektabbruch?',
    'Ja - gerade abgebrochene Projekte liefern die wertvollsten Erkenntnisse.',
  ),
  karte(
    'k-al-2',
    'a-lessons',
    'Ablauf eines Lessons-Learned-Workshops',
    'Vorbereiten, sammeln (gut/schlecht), Ursachen analysieren, Empfehlungen ableiten, dokumentieren und zugänglich machen.',
  ),
  karte(
    'k-ll-1',
    'a-lessons',
    'Start - Stop - Continue',
    'Start: Was neu anfangen? Stop: Was lassen? Continue: Was beibehalten?',
  ),
  karte(
    'k-ll-2',
    'a-lessons',
    'Eine gute Lesson',
    'Situation, Ursache und konkrete Empfehlung - verständlich für ein fremdes Team, ohne Schuldzuweisung.',
  ),
  karte(
    'k-ll-3',
    'a-lessons',
    'Lessons Learned vs. Abschlussbericht',
    'Lessons Learned: Was lernen wir daraus (für künftige Teams)? Abschlussbericht: Was ist herausgekommen (für den Auftraggeber)?',
  ),
  karte(
    'k-ll-4',
    'a-lessons',
    'Wann Lessons Learned?',
    'Zeitnah am Projektende und zusätzlich nach Phasen oder Meilensteinen; in Scrum als Retrospektive nach jedem Sprint.',
  ),
];
