import '../../models/flashcard.dart';
import '../builders.dart';

/// Karten zu Bereich 01, Teil 2: Terminplanung, Risiko, Wirtschaftlichkeit
/// und Projektabschluss.
final List<Flashcard> cardsA01Planung = [
  // Projektstrukturplan
  karte('k-tp-1', 't-psp', 'Gliederungsarten des PSP',
      'Objektorientiert (Bestandteile), funktionsorientiert (Tätigkeiten), phasenorientiert (Projektphasen) - oder gemischt.'),
  karte('k-tp-2', 't-psp', 'Was der PSP nicht zeigt',
      'Reihenfolge, Abhängigkeiten und Termine. Die kommen erst im Netzplan bzw. Gantt-Diagramm dazu.'),

  // Risiken
  karte('k-rp-1', 'r-prozess', 'Risiken identifizieren - Methoden',
      'Brainstorming, Checklisten, Lessons Learned früherer Projekte, Befragung von Fachleuten.'),
  karte('k-rb-1', 'r-bewertung', 'Priorisierung von Risiken',
      'Nach Risikowert absteigend - existenzbedrohende Risiken zusätzlich immer gesondert behandeln.'),

  // Wirtschaftlichkeit
  karte('k-wn-1', 'w-nutzwert', 'Schritte der Nutzwertanalyse',
      'Kriterien festlegen, gewichten (Summe 100 %), bewerten, Punkte × Gewicht, addieren, höchsten Nutzwert wählen.'),
  karte('k-wn-2', 'w-nutzwert', 'K.-o.-Kriterium',
      'Mussanforderung, die jede Alternative erfüllen muss. Wer sie verfehlt, scheidet vor der Nutzwertberechnung aus.'),
  karte('k-wm-1', 'w-makeorbuy', 'Make vs. Buy - Kernargumente',
      'Make: passgenau, Know-how bleibt im Haus. Buy: schnell verfügbar, geringere Entwicklungskosten, aber Abhängigkeit vom Anbieter.'),
  karte('k-wb-1', 'w-breakeven', 'Amortisation mit laufenden Kosten',
      'Amortisationsdauer = Investition / (Einsparung - laufende Kosten) pro Jahr.'),

  // Lessons Learned
  karte('k-al-1', 'a-lessons', 'Lessons Learned bei Projektabbruch?',
      'Ja - gerade abgebrochene Projekte liefern die wertvollsten Erkenntnisse.'),
  karte('k-al-2', 'a-lessons', 'Ablauf eines Lessons-Learned-Workshops',
      'Vorbereiten, sammeln (gut/schlecht), Ursachen analysieren, Empfehlungen ableiten, dokumentieren und zugänglich machen.'),
];
