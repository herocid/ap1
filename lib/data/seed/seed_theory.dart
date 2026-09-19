import '../models/theory.dart';

/// Theorie-Snacks: pro Thema ein bis zwei Karten, die vor der ersten Aufgabe
/// erscheinen und danach jederzeit abrufbar sind.
final List<TheorySnack> seedTheory = [
  const TheorySnack(
    id: 'th-org-1',
    topicId: 'projektorganisation',
    title: 'Was ein Projekt zum Projekt macht',
    lead:
        'Die DIN 69901 definiert vier Merkmale. Fehlt eines davon, ist es '
        'Tagesgeschaeft - egal wie aufwendig es sich anfuehlt.',
    points: [
      'Einmaligkeit der Bedingungen in ihrer Gesamtheit',
      'Zielvorgabe mit zeitlicher, finanzieller und personeller Begrenzung',
      'Eigene, projektspezifische Organisation',
      'Abgrenzung gegenueber anderen Vorhaben',
      'Nicht enthalten: eine Mindestgroesse oder ein Mindestbudget',
    ],
    merksatz:
        'Einmalig, begrenzt, eigene Organisation, abgegrenzt - vier Haken, '
        'sonst kein Projekt.',
  ),
  const TheorySnack(
    id: 'th-org-2',
    topicId: 'projektorganisation',
    title: 'Drei Organisationsformen in einer Minute',
    lead:
        'Die Frage ist immer dieselbe: Wie viel Macht hat die Projektleitung '
        'gegenueber der Linie?',
    points: [
      'Reine Projektorganisation: Team komplett aus der Linie geloest, '
          'Projektleitung hat volle Weisungsbefugnis. Schnell, aber teuer und '
          'nach Projektende gibt es ein Rueckkehrproblem.',
      'Matrix: Weisungsbefugnis geteilt - fachlich beim Projekt, '
          'disziplinarisch in der Linie. Flexibel, aber Dauerkonflikt um '
          'Prioritaeten.',
      'Stabs-/Einflussorganisation: Projektleitung koordiniert nur, ohne '
          'Weisungsrecht. Billig, aber zahnlos.',
    ],
    merksatz:
        'Viel Macht = viel Aufwand. Die Matrix ist der Kompromiss - und '
        'deshalb der Normalfall.',
  ),
  const TheorySnack(
    id: 'th-vor-1',
    topicId: 'vorgehensmodelle',
    title: 'Wasserfall, V-Modell, Spirale',
    lead: 'Drei klassische Modelle, drei Erkennungsmerkmale.',
    points: [
      'Wasserfall: streng sequenziell, jede Phase endet mit einem freigegebenen '
          'Dokument. Voraussetzung: Anforderungen sind vollstaendig bekannt.',
      'V-Modell: wie Wasserfall, aber jeder Entwicklungsstufe ist eine '
          'Teststufe zugeordnet (Anforderung <-> Abnahmetest, '
          'Systemspez. <-> Systemtest, Architektur <-> Integrationstest, '
          'Feinentwurf <-> Modultest).',
      'Spiralmodell: wiederholte Zyklen, jeder beginnt mit einer '
          'Risikoanalyse. Fuer grosse, riskante Vorhaben.',
      'Rule of Ten: Ein Fehler kostet in jeder spaeteren Phase etwa das '
          'Zehnfache.',
    ],
    merksatz:
        'Gleiche Hoehe im V = zusammengehoeriges Paar. Je hoeher, desto naeher '
        'am Kunden.',
  ),
  const TheorySnack(
    id: 'th-scr-1',
    topicId: 'agil_scrum',
    title: 'Scrum auf einer Karte',
    lead:
        'Drei Verantwortlichkeiten, drei Artefakte, fuenf Events. Mehr steht '
        'nicht im Scrum Guide.',
    points: [
      'Verantwortlichkeiten: Product Owner (WAS und Reihenfolge), Developers '
          '(WIE und wie viel), Scrum Master (DASS es funktioniert).',
      'Artefakte mit Commitment: Product Backlog -> Product Goal, '
          'Sprint Backlog -> Sprint Goal, Increment -> Definition of Done.',
      'Events: Sprint (Container), Sprint Planning, Daily Scrum, Sprint Review, '
          'Sprint Retrospective. Refinement ist KEIN Event, sondern eine '
          'laufende Taetigkeit.',
      'Timeboxen bei Monatssprint: Planning 8 h, Daily 15 min, Review 4 h, '
          'Retrospektive 3 h.',
    ],
    merksatz:
        'Review = Produkt, mit Stakeholdern. Retrospektive = Zusammenarbeit, '
        'nur das Team. Review kommt zuerst.',
  ),
  const TheorySnack(
    id: 'th-np-1',
    topicId: 'netzplan',
    title: 'Netzplan: die sechs Werte',
    lead:
        'Erst alles vorwaerts, dann alles rueckwaerts, dann die Puffer. '
        'In dieser Reihenfolge, nie gemischt.',
    points: [
      'Vorwaerts: FAZ = groesster FEZ aller Vorgaenger (Start: 0). '
          'FEZ = FAZ + Dauer.',
      'Projektdauer = groesster FEZ im gesamten Plan.',
      'Rueckwaerts: SEZ = kleinster SAZ aller Nachfolger (Endvorgang: '
          'SEZ = Projektdauer). SAZ = SEZ - Dauer.',
      'Gesamtpuffer GP = SAZ - FAZ = SEZ - FEZ.',
      'Freier Puffer FP = kleinster FAZ der Nachfolger - eigener FEZ.',
      'Kritischer Pfad = alle Vorgaenge mit GP = 0, zugleich der laengste Weg.',
    ],
    merksatz:
        'Vorwaerts das MAXIMUM, rueckwaerts das MINIMUM. Wer das vertauscht, '
        'rechnet den halben Plan falsch.',
  ),
  const TheorySnack(
    id: 'th-np-2',
    topicId: 'netzplan',
    title: 'GP oder FP? Der Unterschied in 20 Sekunden',
    lead:
        'Beide Puffer sagen, wie viel Luft ein Vorgang hat - aber bis wohin, '
        'ist verschieden.',
    points: [
      'Gesamtpuffer: Verschiebung ohne das PROJEKTENDE zu gefaehrden. '
          'Kann aber den Nachfolger nach hinten druecken.',
      'Freier Puffer: Verschiebung ohne den fruehesten Start des NACHFOLGERS '
          'anzutasten. Merkt sonst niemand.',
      'Es gilt immer FP <= GP.',
      'Auf dem kritischen Pfad sind beide null.',
      'Typischer Fall: GP = 2, FP = 0. Luft bis zum Projektende vorhanden - '
          'aber nur, indem man sie dem Nachfolger wegnimmt.',
    ],
    merksatz: 'GP schaut aufs Projektende, FP schaut auf den Nachbarn.',
  ),
  const TheorySnack(
    id: 'th-tp-1',
    topicId: 'terminplanung',
    title: 'Gantt, Meilenstein, MTA',
    lead: 'Mit dem Netzplan rechnet man, mit dem Balkenplan redet man.',
    points: [
      'Gantt/Balkenplan: massstabsgetreue Zeitachse, auf einen Blick lesbar. '
          'Abhaengigkeiten und Puffer sind aber nicht direkt ablesbar.',
      'Meilenstein: Ereignis mit Dauer null, an dem ein definiertes '
          'Zwischenergebnis vorliegt. Binaer pruefbar formulieren.',
      'Meilensteintrendanalyse: geplante Termine ueber Berichtszeitpunkte '
          'auftragen. Waagerecht = im Plan, steigend = Verzug, fallend = '
          'frueher fertig, Zickzack = unsichere Planung.',
      'Dauer = Aufwand / (Anzahl Personen x Verfuegbarkeitsgrad). '
          'Personentage sind Aufwand, Arbeitstage sind Dauer.',
    ],
    merksatz:
        'Steigende MTA-Linie heisst spaeter, nicht frueher. Das wird am '
        'haeufigsten verwechselt.',
  ),
  const TheorySnack(
    id: 'th-lh-1',
    topicId: 'lastenheft',
    title: 'Lastenheft vs. Pflichtenheft',
    lead: 'Zwei Dokumente, zwei Absender, zwei Zeitpunkte.',
    points: [
      'Lastenheft: vom AUFTRAGGEBER, beschreibt das WAS und WOFUER, '
          'loesungsneutral. Grundlage der Ausschreibung.',
      'Pflichtenheft: vom AUFTRAGNEHMER, beschreibt das WIE und WOMIT. '
          'Entsteht NACH der Vergabe und wird vom Auftraggeber genehmigt.',
      'Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft.',
      'Funktional = "Das System tut X". Nicht-funktional = "Das System tut X '
          'schnell/sicher/verfuegbar/barrierefrei".',
      'Gute Anforderung: eindeutig, vollstaendig, widerspruchsfrei, pruefbar, '
          'notwendig, priorisiert (MuSCoW).',
    ],
    merksatz:
        'LAstenheft = Auftraggeber verteilt die Last. PFlichtenheft = '
        'Auftragnehmer nennt seine Pflicht.',
  ),
  const TheorySnack(
    id: 'th-wi-1',
    topicId: 'wirtschaftlichkeit',
    title: 'Rechnen im PM-Teil',
    lead: 'Vier Rechnungen decken den Grossteil der Punkte ab.',
    points: [
      'Nutzwertanalyse: je Kriterium Gewicht x Bewertung, dann summieren. '
          'Gewichte muessen 100 % ergeben.',
      'Amortisation: Investitionssumme / jaehrlicher Netto-Rueckfluss.',
      'Bezugskalkulation: Listenpreis - Rabatt = Zieleinkaufspreis; '
          '- Skonto = Bareinkaufspreis; + Bezugskosten = Bezugspreis. '
          'Skonto nie vom Listenpreis, Bezugskosten nie vor dem Skonto.',
      'Risikowert = Eintrittswahrscheinlichkeit x Schadenshoehe.',
      'TCO = nur Kosten ueber den gesamten Lebenszyklus. Ertraege gehoeren in '
          'die ROI-Rechnung.',
    ],
    merksatz:
        'Bei Prozentaufgaben immer fragen: Prozent WOVON? Das ist der '
        'haeufigste Punktverlust.',
  ),
  const TheorySnack(
    id: 'th-qr-1',
    topicId: 'qualitaet_risiko',
    title: 'Qualitaet und Risiko',
    lead: 'Zwei Sortierungen, die fast jede Aufgabe abdecken.',
    points: [
      'Konstruktive QS = vorher, verhindert Fehler: Standards, Templates, '
          'Werkzeuge, Schulung, Frameworks.',
      'Analytische QS = nachher, findet Fehler: Test, Review, Inspektion, '
          'statische Analyse, Audit.',
      'Risikostrategien: Vermeiden (Ursache weg), Vermindern '
          '(Wahrscheinlichkeit oder Auswirkung runter), Ueberwaelzen '
          '(Versicherung, Festpreis), Akzeptieren (bewusst und dokumentiert).',
      'Testfrage Vermeiden vs. Vermindern: Kann das Risiko danach noch '
          'eintreten? Ja -> vermindert. Nein -> vermieden.',
    ],
    merksatz:
        'Test findet Fehler, Standard verhindert sie. Das ist die ganze '
        'Unterscheidung.',
  ),
  const TheorySnack(
    id: 'th-ab-1',
    topicId: 'abschluss',
    title: 'Projektabschluss richtig',
    lead: 'Drei Ebenen - die dritte wird am haeufigsten vergessen.',
    points: [
      'Sachlich-technisch: Restarbeiten, Abnahme mit Protokoll, Uebergabe an '
          'den Betrieb.',
      'Kaufmaennisch: Schlussrechnung, Nachkalkulation, Projekt buchhalterisch '
          'schliessen.',
      'Personell: Team aufloesen, Rueckfuehrung in die Linie, Wuerdigung der '
          'Leistung.',
      'Lessons Learned: zeitnah, ohne Schuldzuweisung, dokumentiert an einem '
          'auffindbaren Ort.',
      'Reihenfolge: Abnahme vor Uebergabe, Teamaufloesung zuletzt.',
    ],
    merksatz:
        'Wer das Team vor dem Abschlussbericht aufloest, bekommt keinen '
        'brauchbaren Bericht.',
  ),
];
