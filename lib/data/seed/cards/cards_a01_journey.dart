import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten zu Bereich 01, Teil 1 (Projektorganisation,
/// Vorgehensmodelle, Scrum, Netzplantechnik) - ergänzend zu
/// `cards_a01_projekte.dart`. Bestehende IDs bleiben unverändert.
final List<Flashcard> cardsA01Journey = [
  // Was ein Projekt ausmacht
  karte(
    'k-pb-1',
    'p-begriff',
    'Vier Merkmale eines Projekts',
    'Einmaligkeit, Zielvorgabe, Begrenzung (Zeit, Budget, Personal), eigene Projektorganisation.',
    'Fehlt eines davon, ist es eine Linienaufgabe.',
  ),
  karte(
    'k-pb-2',
    'p-begriff',
    'Linienaufgabe',
    'Wiederkehrende Tätigkeit, die in der bestehenden Aufbauorganisation erledigt wird - zum Beispiel täglicher Support oder monatliches Patchen.',
  ),
  karte(
    'k-pb-3',
    'p-begriff',
    'Ist Größe ein Projektmerkmal?',
    'Nein. Weder Budget noch Teamgröße entscheiden, sondern Einmaligkeit und Begrenzung.',
    'Ein zweiwöchiges, einmaliges Vorhaben kann ein Projekt sein.',
  ),
  karte(
    'k-pb-4',
    'p-begriff',
    'Projektmanagement (DIN 69901)',
    'Gesamtheit von Führungsaufgaben, -organisation, -techniken und -mitteln für Initiierung, Definition, Planung, Steuerung und Abschluss von Projekten.',
  ),
  karte(
    'k-pb-5',
    'p-begriff',
    'Projektarten nach Inhalt',
    'Investitionsprojekt (z. B. neue Server), Organisationsprojekt (neuer Ablauf), Entwicklungsprojekt (neues Produkt, z. B. eine App).',
  ),
  karte(
    'k-pb-6',
    'p-begriff',
    'Internes vs. externes Projekt',
    'Intern: Auftraggeber im eigenen Unternehmen. Extern: Auftrag eines Kunden, meist mit Vertrag.',
  ),
  karte(
    'k-pb-7',
    'p-begriff',
    'Warum Projekte scheitern',
    'Unklare Ziele, fehlende Unterstützung der Leitung, schlechte Kommunikation, unrealistische Planung, Scope Creep, unbehandelte Risiken.',
  ),

  // Projektziele und magisches Dreieck
  karte(
    'k-pz-1',
    'p-ziele',
    'Die drei Zielarten',
    'Sachziel (Leistung und Qualität), Terminziel, Kostenziel - die drei Ecken des magischen Dreiecks.',
  ),
  karte(
    'k-pz-2',
    'p-ziele',
    'Zielbeziehungen',
    'Komplementär: Ziele fördern sich. Konkurrierend: Ziele behindern sich. Indifferent: Ziele beeinflussen sich nicht.',
    'Konkurrierende Ziele müssen priorisiert werden.',
  ),
  karte(
    'k-pz-3',
    'p-ziele',
    'Scope Creep',
    'Schleichende Ausweitung des Projektumfangs, ohne dass Zeit und Budget mitwachsen.',
    'Vorbeugen: Nicht-Ziele im Projektauftrag und ein formales Änderungsverfahren.',
  ),

  // Organisationsformen
  karte(
    'k-po-1',
    'p-organisation',
    'Fachliche vs. disziplinarische Weisung',
    'Fachlich: was und wie gearbeitet wird. Disziplinarisch: Urlaub, Beurteilung, Gehalt, Abmahnung.',
  ),
  karte(
    'k-po-2',
    'p-organisation',
    'Rückkehrproblem',
    'Nachteil der reinen Projektorganisation: Nach Projektende müssen die herausgelösten Mitarbeitenden wieder in der Linie untergebracht werden.',
  ),
  karte(
    'k-po-3',
    'p-organisation',
    'Wann Matrix-Organisation?',
    'Bei mittleren Projekten, wenn Mitarbeitende anteilig mitarbeiten, in ihren Abteilungen bleiben und die Projektleitung fachlich führen soll.',
  ),
  karte(
    'k-po-4',
    'p-organisation',
    'Wann Einflussorganisation?',
    'Bei kleinen, kurzen, risikoarmen Projekten, in denen alle nur nebenbei mitarbeiten.',
  ),

  // Rollen
  karte(
    'k-pr-1',
    'p-rollen',
    'Kernaufgaben der Projektleitung',
    'Planen, organisieren, steuern und kontrollieren, berichten.',
    'Sie führt das Projekt innerhalb des Auftrags - den Auftrag selbst ändert der Auftraggeber.',
  ),
  karte(
    'k-pr-2',
    'p-rollen',
    'RACI-Matrix',
    'Responsible: führt durch. Accountable: verantwortet und entscheidet (genau eine Person). Consulted: wird gefragt. Informed: wird informiert.',
  ),
  karte(
    'k-pr-3',
    'p-rollen',
    'Kongruenzprinzip (AKV)',
    'Aufgabe, Kompetenz und Verantwortung einer Rolle müssen übereinstimmen.',
    'Wer für das Budget verantwortlich ist, braucht auch die Befugnis, darüber zu verfügen.',
  ),
  karte(
    'k-pr-4',
    'p-rollen',
    'Ampel im Statusbericht',
    'Grün: im Plan. Gelb: Abweichung, die Projektleitung steuert selbst gegen. Rot: Rahmen gefährdet, Entscheidung des Lenkungsausschusses nötig.',
  ),

  // Stakeholder
  karte(
    'k-ps-1',
    'p-stakeholder',
    'Schritte der Stakeholderanalyse',
    'Identifizieren, Einfluss und Interesse einschätzen, in die Matrix einordnen, Maßnahmen festlegen und umsetzen.',
  ),
  karte(
    'k-ps-2',
    'p-stakeholder',
    'Achsen des Stakeholder-Portfolios',
    'Einfluss (Macht) und Interesse (Betroffenheit). Daraus folgen: eng einbinden, zufriedenstellen, informieren, beobachten.',
  ),
  karte(
    'k-ps-3',
    'p-stakeholder',
    'Kommunikationsplan',
    'Legt fest, wer welche Information wann und auf welchem Weg erhält - abgeleitet aus der Stakeholderanalyse.',
  ),
  karte(
    'k-ps-4',
    'p-stakeholder',
    'Betriebsrat im IT-Projekt',
    'Bestimmt mit bei technischen Einrichtungen, mit denen sich Leistung oder Verhalten der Beschäftigten überwachen lassen (§ 87 Abs. 1 Nr. 6 BetrVG).',
    'Früh einbeziehen - sonst kann er die Einführung stoppen.',
  ),

  // Projektphasen
  karte(
    'k-vp-1',
    'v-phasen',
    'Phasen nach DIN 69901',
    'Initialisierung, Definition, Planung, Steuerung, Abschluss.',
  ),
  karte(
    'k-vp-2',
    'v-phasen',
    'Ergebnis der Initialisierung',
    'Ein vom Auftraggeber unterschriebener Projektauftrag und eine benannte Projektleitung.',
  ),
  karte(
    'k-vp-3',
    'v-phasen',
    'Phase vs. Meilenstein',
    'Phase: Zeitraum, in dem gearbeitet wird. Meilenstein: Zeitpunkt ohne Dauer, meist am Phasenende, mit prüfbarem Ergebnis.',
  ),
  karte(
    'k-vp-4',
    'v-phasen',
    'Ergebnis der Definitionsphase',
    'Geklärte Ziele und Anforderungen (Lastenheft), Machbarkeitsbewertung, Stakeholderanalyse.',
  ),
  karte(
    'k-vp-5',
    'v-phasen',
    'Ergebnis der Planungsphase',
    'Projektstrukturplan, Terminplan (Netzplan, Gantt), Ressourcen- und Kostenplan, Risikoplanung.',
  ),

  // Wasserfallmodell
  karte(
    'k-vw-1',
    'v-wasserfall',
    'Lastenheft vs. Pflichtenheft',
    'Lastenheft: vom Auftraggeber - WAS und WOFÜR. Pflichtenheft: vom Auftragnehmer - WIE und WOMIT.',
  ),
  karte(
    'k-vw-2',
    'v-wasserfall',
    'Change Request im Wasserfall',
    'Formaler Änderungsantrag nach einer Freigabe: Aufwand und Folgen für Termin und Kosten bewerten, dann entscheiden und neu vereinbaren.',
  ),

  // Klassisch oder agil?
  karte(
    'k-va-1',
    'v-auswahl',
    'Das umgedrehte Dreieck',
    'Wasserfall: Umfang fest, Zeit und Kosten geschätzt. Scrum: Zeit und Kosten fest, Umfang variabel.',
  ),
  karte(
    'k-va-2',
    'v-auswahl',
    'Hybrides Vorgehen',
    'Rahmen, Budget und Meilensteine werden klassisch geplant, die Entwicklung läuft darin in Sprints.',
  ),
  karte(
    'k-va-3',
    'v-auswahl',
    'Ist agil schneller?',
    'Nicht automatisch. Scrum liefert früher nutzbare Teile und senkt das Risiko einer Fehlentwicklung; das Gesamtprojekt wird aber nicht zwingend kürzer.',
  ),

  // Agiles Manifest
  karte(
    'k-sm-1',
    's-manifest',
    'Agiles Manifest - Entstehung',
    '2001 von 17 Softwareentwicklern verfasst - als Antwort auf schwerfällige, dokumentlastige Vorgehensweisen.',
  ),
  karte(
    'k-sm-2',
    's-manifest',
    'Individuen und Interaktionen ...',
    '... sind wichtiger als Prozesse und Werkzeuge.',
  ),
  karte(
    'k-sm-3',
    's-manifest',
    'Reagieren auf Veränderung ...',
    '... ist wichtiger als das Befolgen eines Plans.',
    'Pläne bleiben wichtig - sie werden nur angepasst, wenn sich die Lage ändert.',
  ),
  karte(
    'k-sm-4',
    's-manifest',
    'Wichtigstes Fortschrittsmaß (agil)',
    'Funktionierende Software.',
    'Nicht erledigte Aufgaben oder geschriebene Dokumente.',
  ),
  karte(
    'k-sm-5',
    's-manifest',
    'Zusammenarbeit mit dem Kunden ...',
    '... ist wichtiger als Vertragsverhandlung.',
  ),
  karte(
    'k-sm-6',
    's-manifest',
    'Nachhaltiges Tempo',
    'Prinzip des Manifests: Alle Beteiligten sollen ein gleichmäßiges Tempo auf Dauer halten können - keine Dauerüberstunden.',
  ),
  karte(
    'k-sm-7',
    's-manifest',
    'Agil vs. Scrum',
    'Agil: Werte und Prinzipien des Manifests. Scrum: ein konkretes Rahmenwerk, das diese Werte umsetzt.',
  ),

  // Die drei Verantwortlichkeiten
  karte(
    'k-sr-1',
    's-rollen',
    'Drei Säulen der Empirie',
    'Transparenz, Überprüfung, Anpassung.',
    'Scrum entscheidet auf Grundlage dessen, was beobachtet wird.',
  ),
  karte(
    'k-sr-2',
    's-rollen',
    'Die fünf Scrum-Werte',
    'Commitment, Fokus, Offenheit, Respekt, Mut.',
  ),
  karte(
    'k-sr-3',
    's-rollen',
    'Merkmale des Scrum Teams',
    'In der Regel 10 Personen oder weniger; interdisziplinär, selbstmanagend, ohne Unterteams und Hierarchien.',
  ),

  // Artefakte
  karte(
    'k-sa-1',
    's-artefakte',
    'Produktziel',
    'Beschreibt den künftigen Zustand des Produkts. Es ist das Commitment des Product Backlogs und gibt allen Einträgen eine Richtung.',
  ),
  karte(
    'k-sa-2',
    's-artefakte',
    'Sprint Backlog',
    'Sprintziel (warum) + ausgewählte Product Backlog Items (was) + Plan (wie). Es gehört den Developers.',
  ),
  karte(
    'k-sa-3',
    's-artefakte',
    'Increment',
    'Nutzbarer, geprüfter Schritt zum Produktziel. Entsteht, sobald ein Eintrag die Definition of Done erfüllt.',
    'Darf auch schon vor dem Sprint Review ausgeliefert werden.',
  ),
  karte(
    'k-sa-4',
    's-artefakte',
    'Product Backlog Refinement',
    'Laufende Tätigkeit, kein Event: Einträge zerlegen, präzisieren und schätzen, bis sie in einen Sprint passen.',
  ),

  // Events
  karte(
    'k-se-1',
    's-events',
    'Sprint',
    'Fester Zeitraum von höchstens einem Monat, in dem ein nutzbares Increment entsteht. Er ist der Rahmen für alle anderen Events.',
  ),
  karte(
    'k-se-2',
    's-events',
    'Sprint Planning: drei Themen',
    'Warum ist der Sprint wertvoll (Sprintziel)? Was kann erledigt werden? Wie wird die Arbeit erledigt?',
  ),
  karte(
    'k-se-3',
    's-events',
    'Wer darf einen Sprint abbrechen?',
    'Nur der Product Owner - wenn das Sprintziel hinfällig geworden ist.',
  ),
  karte(
    'k-se-4',
    's-events',
    'Timeboxen im 2-Wochen-Sprint',
    'Anteilig umgerechnet: Planning 4 h, Daily 15 min, Review 2 h, Retrospektive 1,5 h.',
  ),

  // User Stories und Schätzung
  karte(
    'k-st-1',
    's-stories',
    'Die 3 C einer User Story',
    'Card (kurze Beschreibung), Conversation (Details im Gespräch), Confirmation (Akzeptanzkriterien).',
  ),
  karte(
    'k-st-2',
    's-stories',
    'Planning Poker',
    'Verdeckt schätzen, gleichzeitig aufdecken, Extremwerte begründen, erneut schätzen.',
    'Das gleichzeitige Aufdecken verhindert den Ankereffekt.',
  ),
  karte(
    'k-st-3',
    's-stories',
    'Burndown-Chart',
    'Zeigt die im Sprint noch offene Arbeit über die Zeit. Liegen die Ist-Werte über der Ideallinie, ist das Team hinter dem Plan.',
  ),

  // Aufbau eines Netzplans
  karte(
    'k-ng-1',
    'n-grundlagen',
    'Normalfolge',
    'Ende-Anfang-Beziehung: Der Nachfolger beginnt, wenn der Vorgänger beendet ist. Der Standardfall in der AP1.',
  ),
  karte(
    'k-ngl-1',
    'n-grundlagen',
    'Aufbau des Vorgangsknotens',
    'Oben FAZ | Dauer | FEZ, in der Mitte Nummer und Bezeichnung, unten SAZ | GP | SEZ; der FP steht oft in einem eigenen Feld.',
    'In der Prüfung gilt immer die Legende der Aufgabe.',
  ),
  karte(
    'k-ngl-2',
    'n-grundlagen',
    'Die vier Anordnungsbeziehungen',
    'Normalfolge (Ende-Anfang), Anfangsfolge (Anfang-Anfang), Endfolge (Ende-Ende), Sprungfolge (Anfang-Ende).',
  ),
  karte(
    'k-ngl-3',
    'n-grundlagen',
    'Nachfolger statt Vorgänger gegeben',
    'Umdrehen: Steht bei A „Nachfolger B“, ist A Vorgänger von B.',
  ),

  // Vorwärtsrechnung
  karte(
    'k-nv-1',
    'n-vorwaerts',
    'FAZ bei mehreren Vorgängern',
    'Der größte FEZ aller Vorgänger.',
    'Der Vorgang muss warten, bis der letzte Vorgänger fertig ist.',
  ),
  karte(
    'k-nv-2',
    'n-vorwaerts',
    'FAZ mit Zeitabstand',
    'FAZ Nachfolger = FEZ Vorgänger + Zeitabstand, zum Beispiel eine Lieferzeit.',
  ),
  karte(
    'k-nv-3',
    'n-vorwaerts',
    'Zählweise ab 1',
    'FAZ Start = 1, FEZ = FAZ + D - 1, FAZ Nachfolger = FEZ Vorgänger + 1.',
    'Ab 0 gerechnet gilt einfach FEZ = FAZ + D.',
  ),
  karte(
    'k-nv-4',
    'n-vorwaerts',
    'Mehrere Startvorgänge',
    'Alle bekommen FAZ 0. Die Projektdauer ist der größte FEZ aller Endvorgänge.',
  ),

  // Rückwärtsrechnung
  karte(
    'k-nr-1',
    'n-rueckwaerts',
    'SEZ bei mehreren Nachfolgern',
    'Der kleinste SAZ aller Nachfolger.',
    'Der eiligste Nachfolger bestimmt, wann der Vorgang spätestens fertig sein muss.',
  ),
  karte(
    'k-nr-2',
    'n-rueckwaerts',
    'Startwert der Rückwärtsrechnung',
    'Beim letzten Vorgang gilt SEZ = FEZ, also die Projektdauer - sofern kein fester Endtermin vorgegeben ist.',
  ),
  karte(
    'k-nr-3',
    'n-rueckwaerts',
    'Negativer Gesamtpuffer',
    'Entsteht, wenn ein vorgegebener Endtermin vor dem errechneten Ende liegt. Ohne Gegenmaßnahme wird der Termin verfehlt.',
  ),
  karte(
    'k-nr-4',
    'n-rueckwaerts',
    'Gegenprobe der Rückwärtsrechnung',
    'Auf dem kritischen Pfad gilt FAZ = SAZ und FEZ = SEZ; der Startvorgang hat wieder SAZ 0.',
  ),

  // Puffer
  karte(
    'k-np-1',
    'n-puffer',
    'Formel freier Puffer',
    'FP = kleinster FAZ der Nachfolger - FEZ des Vorgangs.',
  ),
  karte(
    'k-np-2',
    'n-puffer',
    'Verzögerung um x Tage',
    'x ≤ FP: keine Folgen. FP < x ≤ GP: Nachfolger beginnen später. x > GP: Projektende verschiebt sich um x - GP.',
  ),
  karte(
    'k-np-3',
    'n-puffer',
    'Freier Puffer des Endvorgangs',
    'Projektdauer - FEZ des Endvorgangs. Auf dem kritischen Pfad ist er 0.',
  ),

  // Kritischer Pfad
  karte(
    'k-nk-1',
    'n-kritisch',
    'Crashing vs. Fast Tracking',
    'Crashing: mehr Ressourcen auf kritische Vorgänge - kostet Geld. Fast Tracking: kritische Vorgänge teilweise parallel - erhöht das Risiko.',
  ),
  karte(
    'k-nk-2',
    'n-kritisch',
    'Kritischer Pfad per Wegvergleich',
    'Die Dauern aller Wege vom Start- zum Endvorgang addieren - der längste Weg ist kritisch.',
  ),
  karte(
    'k-nk-3',
    'n-kritisch',
    'Ist der längste Vorgang kritisch?',
    'Nicht unbedingt. Kritisch ist, wer keinen Puffer hat - nicht, wer lange dauert.',
  ),
];
