import '../../models/flashcard.dart';
import '../builders.dart';

/// Ergänzende Karten zu Bereich 01, damit jede Lektion der Journey
/// mindestens vier Karten hat.
final List<Flashcard> cardsA01Journey = [
  // Was ein Projekt ausmacht
  karte('k-pb-1', 'p-begriff', 'Vier Merkmale eines Projekts',
      'Einmaligkeit, Zielvorgabe, Begrenzung (Zeit, Budget, Personal), eigene Projektorganisation.',
      'Fehlt eines davon, ist es eine Linienaufgabe.'),
  karte('k-pb-2', 'p-begriff', 'Linienaufgabe',
      'Wiederkehrende Tätigkeit, die in der bestehenden Aufbauorganisation erledigt wird - zum Beispiel täglicher Support oder monatliches Patchen.'),
  karte('k-pb-3', 'p-begriff', 'Ist Größe ein Projektmerkmal?',
      'Nein. Weder Budget noch Teamgröße entscheiden, sondern Einmaligkeit und Begrenzung.',
      'Ein zweiwöchiges, einmaliges Vorhaben kann ein Projekt sein.'),

  // Organisationsformen
  karte('k-po-1', 'p-organisation', 'Fachliche vs. disziplinarische Weisung',
      'Fachlich: was und wie gearbeitet wird. Disziplinarisch: Urlaub, Beurteilung, Gehalt, Abmahnung.'),

  // Rollen
  karte('k-pr-1', 'p-rollen', 'Kernaufgaben der Projektleitung',
      'Planen, organisieren, steuern und kontrollieren, berichten.',
      'Sie führt das Projekt innerhalb des Auftrags - den Auftrag selbst ändert der Auftraggeber.'),

  // Stakeholder
  karte('k-ps-1', 'p-stakeholder', 'Schritte der Stakeholderanalyse',
      'Identifizieren, Einfluss und Interesse einschätzen, in die Matrix einordnen, Maßnahmen festlegen und umsetzen.'),

  // Projektphasen
  karte('k-vp-1', 'v-phasen', 'Phasen nach DIN 69901',
      'Initialisierung, Definition, Planung, Steuerung, Abschluss.'),
  karte('k-vp-2', 'v-phasen', 'Ergebnis der Initialisierung',
      'Ein vom Auftraggeber unterschriebener Projektauftrag und eine benannte Projektleitung.'),

  // Agiles Manifest
  karte('k-sm-1', 's-manifest', 'Agiles Manifest - Entstehung',
      '2001 von 17 Softwareentwicklern verfasst - als Antwort auf schwerfällige, dokumentlastige Vorgehensweisen.'),
  karte('k-sm-2', 's-manifest', 'Individuen und Interaktionen ...',
      '... sind wichtiger als Prozesse und Werkzeuge.'),
  karte('k-sm-3', 's-manifest', 'Reagieren auf Veränderung ...',
      '... ist wichtiger als das Befolgen eines Plans.',
      'Pläne bleiben wichtig - sie werden nur angepasst, wenn sich die Lage ändert.'),
  karte('k-sm-4', 's-manifest', 'Wichtigstes Fortschrittsmaß (agil)',
      'Funktionierende Software.',
      'Nicht erledigte Aufgaben oder geschriebene Dokumente.'),

  // Artefakte
  karte('k-sa-1', 's-artefakte', 'Produktziel',
      'Beschreibt den künftigen Zustand des Produkts. Es ist das Commitment des Product Backlogs und gibt allen Einträgen eine Richtung.'),

  // Events
  karte('k-se-1', 's-events', 'Sprint',
      'Fester Zeitraum von höchstens einem Monat, in dem ein nutzbares Increment entsteht. Er ist der Rahmen für alle anderen Events.'),

  // Netzplan
  karte('k-ng-1', 'n-grundlagen', 'Normalfolge',
      'Ende-Anfang-Beziehung: Der Nachfolger beginnt, wenn der Vorgänger beendet ist. Der Standardfall in der AP1.'),
  karte('k-nv-1', 'n-vorwaerts', 'FAZ bei mehreren Vorgängern',
      'Der größte FEZ aller Vorgänger.',
      'Der Vorgang muss warten, bis der letzte Vorgänger fertig ist.'),
  karte('k-nr-1', 'n-rueckwaerts', 'SEZ bei mehreren Nachfolgern',
      'Der kleinste SAZ aller Nachfolger.',
      'Der eiligste Nachfolger bestimmt, wann der Vorgang spätestens fertig sein muss.'),
  karte('k-nr-2', 'n-rueckwaerts', 'Startwert der Rückwärtsrechnung',
      'Beim letzten Vorgang gilt SEZ = FEZ, also die Projektdauer - sofern kein fester Endtermin vorgegeben ist.'),
  karte('k-np-1', 'n-puffer', 'Formel freier Puffer',
      'FP = kleinster FAZ der Nachfolger - FEZ des Vorgangs.'),

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
