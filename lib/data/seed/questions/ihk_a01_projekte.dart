import '../../models/question.dart';
import '../builders.dart';

/// Arztpraxis, neue Praxissoftware: Dauer 12, kritisch A - B - D - E - F,
/// C hat GP 1 / FP 1.
const _praxis = [
  Activity(id: 'A', name: 'Anforderungen aufnehmen', duration: 2),
  Activity(id: 'B', name: 'Server bestellen', duration: 4, predecessors: ['A']),
  Activity(
    id: 'C',
    name: 'Altdaten bereinigen',
    duration: 5,
    predecessors: ['A'],
  ),
  Activity(
    id: 'D',
    name: 'Server installieren',
    duration: 2,
    predecessors: ['B'],
  ),
  Activity(
    id: 'E',
    name: 'Daten migrieren',
    duration: 3,
    predecessors: ['C', 'D'],
  ),
  Activity(id: 'F', name: 'Schulung', duration: 1, predecessors: ['E']),
];

/// Druckertausch: Dauer 14, kritisch A - B - D - F, C und E haben GP 4.
const _drucker = [
  Activity(id: 'A', name: 'Ist-Analyse', duration: 3),
  Activity(
    id: 'B',
    name: 'Angebote einholen',
    duration: 4,
    predecessors: ['A'],
  ),
  Activity(
    id: 'C',
    name: 'Standorte festlegen',
    duration: 2,
    predecessors: ['A'],
  ),
  Activity(id: 'D', name: 'Geräte bestellen', duration: 5, predecessors: ['B']),
  Activity(
    id: 'E',
    name: 'Netzwerkdosen prüfen',
    duration: 3,
    predecessors: ['C'],
  ),
  Activity(
    id: 'F',
    name: 'Geräte aufstellen',
    duration: 2,
    predecessors: ['D', 'E'],
  ),
];

/// Dokumentenmanagement: Dauer 15, kritisch A - C - D - F - G,
/// B und E haben GP 3 / FP 3.
const _dms = [
  Activity(id: 'A', name: 'Ist-Analyse', duration: 3),
  Activity(
    id: 'B',
    name: 'Lizenzen beschaffen',
    duration: 2,
    predecessors: ['A'],
  ),
  Activity(
    id: 'C',
    name: 'Server bereitstellen',
    duration: 5,
    predecessors: ['A'],
  ),
  Activity(
    id: 'D',
    name: 'Software installieren',
    duration: 2,
    predecessors: ['B', 'C'],
  ),
  Activity(
    id: 'E',
    name: 'Rechtekonzept erstellen',
    duration: 4,
    predecessors: ['A'],
  ),
  Activity(
    id: 'F',
    name: 'Dokumente importieren',
    duration: 3,
    predecessors: ['D', 'E'],
  ),
  Activity(id: 'G', name: 'Schulung', duration: 2, predecessors: ['F']),
];

/// Aufgaben im IHK-Stil zu Bereich 01, Teil 1: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA01Projekte = [
  // ===================================================== Was ein Projekt ausmacht
  markieren(
    'i1-pb-1',
    'p-begriff',
    scenario:
        'Das Autohaus Lindner (35 Beschäftigte) ersetzt seine alte Telefonanlage durch Cloud-Telefonie. Im Projektauftrag und in den Notizen der IT stehen folgende Angaben.',
    prompt:
        'Markiere alle Angaben, die ein Merkmal eines Projekts beschreiben.',
    zeilen: [
      ja(
        'Eine solche Umstellung hat das Autohaus noch nie durchgeführt.',
        'Einmaligkeit bzw. Neuartigkeit - das Kernmerkmal eines Projekts.',
      ),
      nein(
        'Die Telefonanlage wird an jedem Werktag von 7 bis 18 Uhr genutzt.',
        'Beschreibt den laufenden Betrieb, kein Merkmal des Vorhabens.',
      ),
      ja(
        'Am 30.09. müssen alle 42 Nebenstellen umgestellt sein.',
        'Klares Ziel mit festem Endtermin - zeitliche Begrenzung.',
      ),
      ja(
        'Für das Vorhaben stehen 18.000 € und 25 Personentage bereit.',
        'Begrenzte finanzielle und personelle Ressourcen.',
      ),
      nein(
        'Der Support setzt jede Woche vergessene Mailbox-PINs zurück.',
        'Wiederkehrende Routine - eine Linienaufgabe.',
      ),
      ja(
        'IT, Verkauf und Werkstatt bilden für die Dauer der Umstellung ein eigenes Team mit Projektleiterin.',
        'Projektspezifische Organisation auf Zeit.',
      ),
      nein(
        'Der Vertrag mit dem bisherigen Anbieter läuft seit 2015.',
        'Eine Information zur Ausgangslage, kein Projektmerkmal.',
      ),
    ],
    explanation:
        'Projektmerkmale sind Einmaligkeit, ein klares Ziel, zeitliche Begrenzung, begrenzte Ressourcen und eine eigene Organisation. Angaben zum laufenden Betrieb oder zu Routinetätigkeiten gehören nicht dazu.',
    punkte: 4,
  ),
  freitext(
    'i1-pb-2',
    'p-begriff',
    scenario:
        'Die Zahnarztpraxis Dr. Sommer zieht zum 01.04. in neue Räume. Dein Ausbildungsbetrieb plant dafür Netzwerk, Server und acht Arbeitsplätze neu. Dein Ausbilder sagt: „Das ist ein klassisches Projekt.“',
    prompt: 'Nenne vier Merkmale, die ein Vorhaben zu einem Projekt machen.',
    kriterien: [
      krit(
        'Einmaligkeit bzw. Neuartigkeit des Vorhabens',
        stichwoerter: [
          'einmalig',
          'neuartig',
          'erstmalig',
          'einzigartig',
          'keine Routine',
        ],
      ),
      krit(
        'Klares, konkretes Ziel',
        stichwoerter: ['Ziel', 'Zielvorgabe', 'zielgerichtet', 'Zielsetzung'],
      ),
      krit(
        'Zeitliche Begrenzung: fester Anfang und festes Ende',
        stichwoerter: [
          'zeitlich begrenzt',
          'zeitliche Begrenzung',
          'befristet',
          'Endtermin',
          'Anfang und Ende',
          'Termin',
        ],
      ),
      krit(
        'Begrenzte Ressourcen (Budget, Personal)',
        stichwoerter: [
          'Budget',
          'Ressourcen',
          'Kosten',
          'finanziell',
          'personell',
        ],
      ),
      krit(
        'Eigene, projektspezifische Organisation (Projektleitung, Team)',
        stichwoerter: [
          'Organisation',
          'Projektteam',
          'Projektleitung',
          'eigenes Team',
        ],
      ),
      krit(
        'Komplexität und Risiko',
        stichwoerter: ['komplex', 'Risiko', 'Unsicherheit', 'Umfang'],
      ),
    ],
    loesung:
        'Ein Projekt ist einmalig bzw. neuartig, hat ein klares Ziel, ist zeitlich begrenzt (fester Anfang und fester Endtermin), verfügt über begrenzte Ressourcen (Budget, Personal) und hat eine eigene Projektorganisation. Hinzu kommen Komplexität und ein höheres Risiko als bei Routineaufgaben.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Stichworte genügen. Andere fachlich richtige Merkmale wie Komplexität oder Risiko zählen ebenfalls.',
    punkte: 4,
    difficulty: 1,
  ),
  tabelle(
    'i1-pb-3',
    'p-begriff',
    scenario:
        'Die IT-Abteilung der Spedition Vogt listet ihre Vorhaben für das nächste Quartal auf.',
    prompt:
        'Ordne jedes Vorhaben ein und wähle das Merkmal, das den Ausschlag gibt.',
    zeilen: [
      ['Vorhaben', 'Einordnung', 'Ausschlaggebend'],
      [
        'Einführung einer Tourenplanungssoftware bis 30.06.',
        wahl('Projekt', ['Linienaufgabe', 'Meilenstein']),
        wahl('einmalig, mit Endtermin', ['wiederkehrend', 'ohne festes Ende']),
      ],
      [
        'Tägliche Kontrolle der Backup-Protokolle',
        wahl('Linienaufgabe', ['Projekt', 'Meilenstein']),
        wahl('wiederkehrend', ['einmalig, mit Endtermin', 'neuartig']),
      ],
      [
        'Betreuung der 60 Fahrer-Tablets im laufenden Betrieb',
        wahl('Linienaufgabe', ['Projekt', 'Meilenstein']),
        wahl('ohne festes Ende', ['einmalig, mit Endtermin', 'neuartig']),
      ],
      [
        'Umzug des Serverraums ins neue Lager innerhalb von acht Wochen',
        wahl('Projekt', ['Linienaufgabe', 'Meilenstein']),
        wahl('einmalig, mit Endtermin', ['wiederkehrend', 'ohne festes Ende']),
      ],
    ],
    explanation:
        'Die Softwareeinführung und der Serverraum-Umzug sind einmalig und haben einen Endtermin - Projekte. Backup-Kontrolle und Gerätebetreuung wiederholen sich bzw. laufen dauerhaft - Linienaufgaben. Ein Meilenstein ist ein Zeitpunkt, kein Vorhaben.',
    punkte: 4,
    difficulty: 1,
  ),

  // ====================================== Projektziele und magisches Dreieck
  freitext(
    'i1-pz-1',
    'p-ziele',
    scenario:
        'Die Bäckereikette Kornblum (12 Filialen) will ihre Kassen erneuern. Im Entwurf des Projektauftrags steht als Ziel: „Die Kassen in den Filialen sollen bald moderner und schneller werden.“',
    prompt:
        'Erläutere zwei Gründe, warum dieses Ziel nicht SMART formuliert ist.',
    kriterien: [
      krit(
        'Nicht messbar: „moderner“ und „schneller“ sind keine Kennzahlen; es fehlt ein prüfbarer Wert, z. B. „ein Kassiervorgang dauert höchstens 20 Sekunden“.',
        punkte: 2,
        stichwoerter: [
          'messbar',
          'Kennzahl',
          'Messgröße',
          'messen',
          'nicht prüfbar',
        ],
      ),
      krit(
        'Nicht terminiert: „bald“ ist kein Datum; es fehlt ein Endtermin, z. B. „bis 30.09.“.',
        punkte: 2,
        stichwoerter: [
          'terminiert',
          'Termin',
          'Datum',
          'Zeitpunkt',
          'bald',
          'Frist',
        ],
      ),
      krit(
        'Nicht spezifisch: Es bleibt offen, welche Kassen in welchen Filialen gemeint sind und was genau erneuert wird.',
        punkte: 2,
        stichwoerter: [
          'spezifisch',
          'ungenau',
          'unklar',
          'konkret',
          'eindeutig',
        ],
      ),
    ],
    loesung:
        'Das Ziel ist nicht messbar: „moderner“ und „schneller“ lassen sich nicht prüfen, es fehlt eine Kennzahl. Es ist nicht terminiert: „bald“ nennt kein Datum. Außerdem ist es nicht spezifisch, weil offenbleibt, welche Kassen gemeint sind. SMART wäre: „Bis 30.09. sind alle 36 Kassen der 12 Filialen ersetzt; ein Kassiervorgang dauert höchstens 20 Sekunden.“',
    explanation:
        'Je Grund 2 Punkte (Kriterium nennen und am Beispiel begründen), höchstens 4 Punkte. SMART: spezifisch, messbar, attraktiv bzw. akzeptiert, realistisch, terminiert.',
    punkte: 4,
  ),
  lueckentext(
    'i1-pz-2',
    'p-ziele',
    scenario:
        'Projekt „Neue Kassen“ bei Kornblum: 36 Kassen, Budget 54.000 €, Fertigstellung bis 30.06. Im Mai verlangt die Geschäftsführung zusätzlich Selbstbedienungskassen in vier Filialen.',
    prompt: 'Ergänze die Auswertung nach dem magischen Dreieck.',
    text:
        'Der Zusatzwunsch erhöht im magischen Dreieck die {0}. Soll der Termin 30.06. bleiben, steigen die {1}, etwa durch zusätzliche Techniker. Soll das Budget bleiben, verschiebt sich der {2}. Bleiben Budget und Termin unverändert, leidet die {3}. Die schleichende Ausweitung des Umfangs ohne mehr Zeit und Geld heißt {4}.',
    luecken: [
      wahl('Leistung', ['Zeit', 'Kosten'], 'Mehr Umfang ist mehr Leistung.'),
      wahl('Kosten', ['Risiken', 'Nicht-Ziele'], 'Mehr Personal kostet Geld.'),
      wahl('Termin', ['Umfang', 'Auftraggeber'], 'Mehr Arbeit braucht Zeit.'),
      wahl('Qualität', [
        'Teamgröße',
        'Projektdauer',
      ], 'Wo nichts nachgibt, wird an der Qualität gespart.'),
      wahl(
        'Scope Creep',
        ['Gold Plating', 'Change Request'],
        'Gold Plating käme vom Team selbst; ein Change Request wäre der geordnete Weg.',
      ),
    ],
    explanation:
        'Leistung, Zeit und Kosten hängen zusammen: Wächst die Leistung, muss eine andere Ecke nachgeben - mehr Kosten oder ein späterer Termin. Sonst sinkt die Qualität. Gegen Scope Creep helfen Nicht-Ziele und ein formales Änderungsverfahren.',
    punkte: 5,
  ),
  rechnen(
    'i1-pz-3',
    'p-ziele',
    scenario:
        'Für die Ausstattung von 30 Arbeitsplätzen der Hausverwaltung Reimann gilt das Kostenziel „höchstens 36.000 €“. Das Angebot nennt je Arbeitsplatz 950 € für das Gerät und 120 € für die Installation, dazu einmalig 2.400 € für die Schulung.',
    prompt:
        'Berechne, um wie viel Euro das Angebot unter dem Kostenziel liegt.',
    answer: 1500,
    unit: '€',
    explanation:
        'Je Arbeitsplatz: 950 € + 120 € = 1.070 €.\n'
        '30 Arbeitsplätze: 30 × 1.070 € = 32.100 €.\n'
        'Mit Schulung: 32.100 € + 2.400 € = 34.500 €.\n'
        'Abstand zum Kostenziel: 36.000 € - 34.500 € = 1.500 €.',
    punkte: 3,
  ),
  markieren(
    'i1-pz-4',
    'p-ziele',
    scenario:
        'Im Zielkatalog des Projekts „Digitales Bestellwesen“ der Großküche Mahlwerk stehen sieben Einträge.',
    prompt: 'Markiere alle Ziele, die messbar und terminiert formuliert sind.',
    zeilen: [
      ja(
        'Ab 01.09. werden 100 % der Bestellungen im neuen System erfasst.',
        'Kennzahl (100 %) und Termin (01.09.) sind genannt.',
      ),
      nein(
        'Die Bestellung soll deutlich einfacher werden.',
        'Weder Messgröße noch Termin.',
      ),
      ja(
        'Bis 30.11. sinkt die Fehlerquote bei Bestellungen von 6 % auf höchstens 2 %.',
        'Messbar über die Fehlerquote und terminiert.',
      ),
      nein(
        'Wir führen eine Bestell-App ein.',
        'Eine Maßnahme - sie beschreibt den Weg, keinen prüfbaren Zustand.',
      ),
      nein(
        'Die Lieferanten sollen möglichst bald angebunden sein.',
        '„Möglichst bald“ ist kein Termin, eine Kennzahl fehlt.',
      ),
      ja(
        'Bis 15.10. sind alle 24 Mitarbeitenden der Küche geschult.',
        'Anzahl und Datum machen das Ziel prüfbar.',
      ),
      nein(
        'Bis 31.12. ist das Bestellwesen spürbar schneller.',
        'Terminiert, aber „spürbar schneller“ lässt sich nicht messen.',
      ),
    ],
    explanation:
        'Ein Ziel ist erst prüfbar, wenn eine Kennzahl und ein Termin genannt sind. Maßnahmen („Wir führen ... ein“) und weiche Formulierungen („deutlich“, „spürbar“, „bald“) erfüllen das nicht.',
    punkte: 3,
  ),

  // ====================================================== Organisationsformen
  freitext(
    'i1-po-1',
    'p-organisation',
    scenario:
        'Die Hartwig Maschinenbau GmbH (220 Beschäftigte) führt in neun Monaten ein CRM-System ein. Sechs Fachleute aus Vertrieb, Service und IT sollen jeweils zu etwa 40 % mitarbeiten; ihre Abteilungen können nicht ganz auf sie verzichten. Die Projektleiterin soll Aufgaben und Termine im Projekt verbindlich vorgeben können.',
    prompt:
        'Entscheide, welche Form der Projektorganisation passt, und begründe deine Wahl mit zwei Argumenten.',
    kriterien: [
      krit('Matrix-Projektorganisation', stichwoerter: ['Matrix']),
      krit(
        'Die Fachleute arbeiten nur anteilig (40 %) mit und bleiben in ihren Abteilungen - das Team wird nicht aus der Linie herausgelöst.',
        punkte: 2,
        stichwoerter: [
          'anteilig',
          '40 %',
          'bleiben in der Linie',
          'Teilzeit',
          'Abteilung',
          'nicht herausgelöst',
        ],
      ),
      krit(
        'Die Projektleiterin braucht fachliche Weisungsbefugnis; in der Stabs-/Einflussorganisation hätte sie keine.',
        punkte: 2,
        stichwoerter: [
          'fachliche Weisung',
          'Weisungsbefugnis',
          'durchsetzen',
          'verbindlich',
        ],
      ),
      krit(
        'Eine reine Projektorganisation wäre zu aufwendig, weil die Abteilungen die Fachleute weiter brauchen.',
        punkte: 2,
        stichwoerter: [
          'reine Projektorganisation',
          'zu aufwendig',
          'herauslösen',
          'Vollzeit',
        ],
      ),
    ],
    loesung:
        'Es passt die Matrix-Projektorganisation. Die sechs Fachleute arbeiten nur zu 40 % mit und bleiben in ihren Abteilungen; eine reine Projektorganisation, die sie ganz herauslöst, wäre zu aufwendig. Zugleich braucht die Projektleiterin fachliche Weisungsbefugnis, um Aufgaben und Termine verbindlich vorzugeben - die hätte sie in der Stabs-/Einflussorganisation nicht.',
    explanation:
        '1 Punkt für die Organisationsform, je Argument 2 Punkte, höchstens 5 Punkte. In der Matrix führt die Projektleitung fachlich, die Linie disziplinarisch.',
    punkte: 5,
  ),
  lueckentext(
    'i1-po-2',
    'p-organisation',
    scenario:
        'Die Personalabteilung der Hartwig Maschinenbau GmbH beschreibt für das Intranet, wie sich die drei Formen der Projektorganisation unterscheiden.',
    prompt: 'Setze die passenden Begriffe ein.',
    text:
        'In der Matrix-Projektorganisation hat die Projektleitung die {0} Weisungsbefugnis, die {1} Weisungsbefugnis bleibt bei der Linie. In der reinen Projektorganisation hat die Projektleitung {2} Befugnisse, und das Team ist ganz aus der Linie {3}. In der Stabs-/Einflussorganisation hat sie {4} Weisungsbefugnis und kann nur {5}.',
    luecken: [
      wort(['fachliche'], 'Was und wie im Projekt gearbeitet wird.'),
      wort(['disziplinarische'], 'Urlaub, Beurteilung, Gehalt.'),
      wort(['beide'], 'Fachlich und disziplinarisch.'),
      wort(['herausgelöst'], 'Die Teammitglieder arbeiten nur fürs Projekt.'),
      wort(['keine'], 'Die Entscheidungen trifft weiter die Linie.'),
      wort(['koordinieren'], 'Beraten, informieren, abstimmen.'),
    ],
    wortbank: ['finanzielle', 'eingegliedert', 'entscheiden', 'geteilte'],
    explanation:
        'Rein: volle Befugnis, Team herausgelöst. Matrix: fachlich die Projektleitung, disziplinarisch die Linie. Stab/Einfluss: keine Weisungsbefugnis, nur Koordination.',
    punkte: 3,
  ),
  zuordnen(
    'i1-po-3',
    'p-organisation',
    scenario:
        'Die Nordfracht AG wickelt mehrere Projekte gleichzeitig ab - jedes in der Form, die zu ihm passt.',
    prompt:
        'Ordne jeder Beschreibung die passende Form der Projektorganisation zu.',
    buckets: [
      'Reine Projektorganisation',
      'Matrix-Organisation',
      'Stabs-/Einflussorganisation',
    ],
    items: [
      zu(
        'Vier Kolleginnen überarbeiten in fünf Wochen nebenbei die Vorlagen im Intranet; ein Koordinator hält die Fäden zusammen.',
        2,
        'Klein, kurz, nebenbei - eine koordinierende Stelle ohne Weisungsbefugnis genügt.',
      ),
      zu(
        'Zwölf Beschäftigte werden für zwei Jahre freigestellt, um ein neues Rechenzentrum aufzubauen.',
        0,
        'Groß, lang, in Vollzeit - das Team wird aus der Linie herausgelöst.',
      ),
      zu(
        'Eine Netzwerkadministratorin arbeitet zu 30 % im Projekt „WLAN-Ausbau“ und zu 70 % weiter im Betrieb.',
        1,
        'Anteilige Mitarbeit mit zwei Vorgesetzten ist typisch für die Matrix.',
      ),
      zu(
        'Die Projektleitung entscheidet auch über Urlaub und Beurteilung der Teammitglieder.',
        0,
        'Disziplinarische Befugnis hat die Projektleitung nur in der reinen Projektorganisation.',
      ),
      zu(
        'Die Projektleitung kann nur empfehlen; entschieden wird in den Fachabteilungen.',
        2,
        'Keine Weisungsbefugnis - Kennzeichen der Einflussorganisation.',
      ),
      zu(
        'Über die Arbeitsinhalte bestimmt die Projektleitung, über Gehalt und Urlaub der Abteilungsleiter.',
        1,
        'Geteilte Weisungsbefugnis: fachlich das Projekt, disziplinarisch die Linie.',
      ),
    ],
    explanation:
        'Entscheidend sind Größe, Dauer und die Frage, wie viel die Projektleitung zu sagen hat: volle Befugnis (rein), nur fachliche (Matrix) oder keine (Stab/Einfluss).',
    punkte: 3,
  ),
  freitext(
    'i1-po-4',
    'p-organisation',
    scenario:
        'Für den Aufbau eines neuen Logistikzentrums löst die Nordfracht AG 15 Beschäftigte für 18 Monate vollständig aus ihren Abteilungen heraus (reine Projektorganisation).',
    prompt: 'Nenne zwei Vorteile und zwei Nachteile dieser Organisationsform.',
    kriterien: [
      krit(
        'Vorteil: klare Zuständigkeit - die Projektleitung hat die volle Weisungsbefugnis',
        stichwoerter: [
          'Weisungsbefugnis',
          'klare Zuständigkeit',
          'ein Vorgesetzter',
          'klare Verantwortung',
          'Entscheidungswege',
        ],
      ),
      krit(
        'Vorteil: volle Konzentration des Teams auf das Projekt, schnelle Entscheidungen',
        stichwoerter: [
          'Konzentration',
          'Fokus',
          'Vollzeit',
          'schnelle Entscheidungen',
          'schnell',
        ],
      ),
      krit(
        'Vorteil: hohe Identifikation des Teams mit dem Projekt',
        stichwoerter: [
          'Identifikation',
          'Motivation',
          'Teamgeist',
          'Zusammenhalt',
        ],
      ),
      krit(
        'Nachteil: hoher Aufwand und hohe Kosten, weil die Personen in ihren Abteilungen fehlen',
        stichwoerter: [
          'teuer',
          'Kosten',
          'Aufwand',
          'fehlen in der Abteilung',
          'Ersatz',
        ],
      ),
      krit(
        'Nachteil: Rückkehrproblem - nach Projektende müssen alle wieder in die Linie eingegliedert werden',
        stichwoerter: [
          'Rückkehr',
          'Wiedereingliederung',
          'nach Projektende',
          'zurück in die Linie',
          'eingliedern',
        ],
      ),
      krit(
        'Nachteil: schwankende Auslastung - Spezialisten sind zeitweise nicht voll beschäftigt',
        stichwoerter: [
          'Auslastung',
          'Leerlauf',
          'nicht ausgelastet',
          'unterfordert',
        ],
      ),
    ],
    loesung:
        'Vorteile: Die Projektleitung hat die volle Weisungsbefugnis, die Zuständigkeiten sind klar; das Team konzentriert sich ganz auf das Projekt und identifiziert sich damit. Nachteile: Die Form ist teuer, weil die Personen in ihren Abteilungen fehlen; nach Projektende müssen alle wieder eingegliedert werden (Rückkehrproblem).',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte (zwei Vorteile, zwei Nachteile). Die reine Projektorganisation lohnt sich bei großen, langen und wichtigen Projekten.',
    punkte: 4,
  ),

  // =========================================================== Rollen im Projekt
  tabelle(
    'i1-pr-1',
    'p-rollen',
    scenario:
        'Im Projekt „Neue Zeiterfassung“ des Pflegeheims Lindenhof gilt: Die Projektleiterin erstellt den Terminplan selbst; der Auftraggeber verantwortet ihn und entscheidet über die Freigabe; das Projektteam wird vorher nach seinen Aufwänden gefragt. Die Schulungen führt das Team durch, verantwortet werden sie von der Projektleiterin; der Auftraggeber erhält danach nur die Teilnehmerliste.',
    prompt:
        'Trage die RACI-Buchstaben ein (R = führt durch, A = verantwortet und entscheidet, C = wird befragt, I = wird informiert).',
    zeilen: [
      ['Aufgabe', 'Auftraggeber', 'Projektleitung', 'Projektteam'],
      [
        'Terminplan erstellen',
        wahl('A', ['R', 'C', 'I'], 'Verantwortet und gibt frei.'),
        wahl('R', ['A', 'C', 'I'], 'Erstellt den Plan selbst.'),
        wahl('C', ['R', 'A', 'I'], 'Wird nach den Aufwänden gefragt.'),
      ],
      [
        'Schulungen durchführen',
        wahl('I', ['R', 'A', 'C'], 'Erhält nur die Teilnehmerliste.'),
        wahl('A', ['R', 'C', 'I'], 'Verantwortet die Schulungen.'),
        wahl('R', ['A', 'C', 'I'], 'Führt die Schulungen durch.'),
      ],
    ],
    explanation:
        'RACI: R = Responsible (führt durch), A = Accountable (verantwortet und entscheidet, genau einmal je Aufgabe), C = Consulted (wird vorher befragt), I = Informed (wird danach informiert).',
    punkte: 3,
  ),
  freitext(
    'i1-pr-2',
    'p-rollen',
    scenario:
        'Für die Einführung eines Dokumentenmanagementsystems bei der Stadtwerke Auental GmbH wird ein Lenkungsausschuss aus Geschäftsführung, IT-Leitung und Leitung Kundenservice gebildet.',
    prompt: 'Beschreibe zwei Aufgaben des Lenkungsausschusses im Projekt.',
    kriterien: [
      krit(
        'Er entscheidet über Änderungen am Projektrahmen: Budget, Endtermin oder Umfang.',
        punkte: 2,
        stichwoerter: ['Budget', 'Umfang', 'Änderung', 'Rahmen', 'Endtermin'],
      ),
      krit(
        'Er ist Eskalationsinstanz: Er entscheidet Probleme und Konflikte, die die Projektleitung nicht selbst lösen kann.',
        punkte: 2,
        stichwoerter: [
          'Eskalation',
          'eskaliert',
          'Konflikt',
          'nicht selbst lösen',
        ],
      ),
      krit(
        'Er nimmt die Statusberichte entgegen, überwacht den Fortschritt und gibt Meilensteine bzw. Phasen frei.',
        punkte: 2,
        stichwoerter: [
          'Statusbericht',
          'Meilenstein',
          'Freigabe',
          'überwacht',
          'kontrolliert',
          'Fortschritt',
        ],
      ),
      krit(
        'Er unterstützt die Projektleitung, z. B. indem er Personal aus den Abteilungen bereitstellt.',
        punkte: 2,
        stichwoerter: [
          'Ressourcen',
          'unterstützt',
          'bereitstellen',
          'Rückendeckung',
          'Personal',
        ],
      ),
    ],
    loesung:
        'Der Lenkungsausschuss entscheidet über Änderungen am Projektrahmen, also über Budget, Endtermin und Umfang. Er ist außerdem die Eskalationsinstanz für Probleme, die die Projektleitung nicht selbst lösen kann, nimmt die Statusberichte entgegen und gibt Meilensteine frei.',
    explanation:
        'Je Aufgabe 2 Punkte (Aufgabe nennen und kurz ausführen), höchstens 4 Punkte. Die Projektleitung steuert innerhalb des Auftrags, der Lenkungsausschuss entscheidet über den Rahmen.',
    punkte: 4,
  ),
  markieren(
    'i1-pr-3',
    'p-rollen',
    scenario:
        'Projektleiter Jonas Weber steuert die Erneuerung des WLAN im Hotel Seeblick (Budget 40.000 €, Endtermin 31.05.). In dieser Woche stehen mehrere Entscheidungen an.',
    prompt:
        'Markiere alle Entscheidungen, die nicht er, sondern Lenkungsausschuss oder Auftraggeber treffen.',
    zeilen: [
      ja(
        'Das Budget um 6.000 € erhöhen, weil zusätzliche Access Points nötig sind',
        'Das Budget gehört zum Projektrahmen - darüber entscheidet der Lenkungsausschuss.',
      ),
      nein(
        'Die Reihenfolge zweier Arbeitspakete tauschen, ohne dass sich der Endtermin ändert',
        'Feinplanung innerhalb des Auftrags ist Aufgabe der Projektleitung.',
      ),
      ja(
        'Den Endtermin auf den 30.06. verschieben',
        'Der Endtermin ist Teil des Auftrags.',
      ),
      nein(
        'Ein zusätzliches Statusmeeting mit dem Team ansetzen',
        'Die Zusammenarbeit im Team organisiert die Projektleitung selbst.',
      ),
      ja(
        'Das Außengelände aus dem Projektumfang streichen',
        'Eine Änderung des Umfangs ändert den Auftrag.',
      ),
      nein(
        'Einem Teammitglied ein anderes Arbeitspaket zuteilen',
        'Aufgaben im Projekt zu verteilen gehört zur Steuerung.',
      ),
      ja(
        'Das fertige WLAN abnehmen',
        'Die Abnahme ist Sache des Auftraggebers.',
      ),
    ],
    explanation:
        'Die Projektleitung plant und steuert innerhalb des Auftrags. Budget, Endtermin und Umfang bilden den Rahmen - Änderungen daran entscheidet der Lenkungsausschuss; die Abnahme erklärt der Auftraggeber.',
    punkte: 4,
  ),

  // ===================================================== Stakeholder analysieren
  tabelle(
    'i1-ps-1',
    'p-stakeholder',
    scenario:
        'Die Stadtbibliothek Rheinfelden führt Selbstverbuchungs-Terminals ein. Die Projektleitung beschreibt vier Gruppen:\n'
        '- Amtsleiterin: gibt das Budget frei und fragt jede Woche nach dem Stand\n'
        '- Personalrat: kann die Einführung blockieren, hat sich bisher nicht dafür interessiert\n'
        '- Angestellte an der Theke: arbeiten täglich mit den Terminals, entscheiden aber nichts\n'
        '- Getränkelieferant des Lesecafés: weder betroffen noch beteiligt',
    prompt: 'Vervollständige die Stakeholder-Matrix.',
    zeilen: [
      ['Stakeholder', 'Einfluss / Interesse', 'Strategie'],
      [
        'Amtsleiterin',
        wahl('hoch / hoch', [
          'hoch / gering',
          'gering / hoch',
          'gering / gering',
        ]),
        wahl('eng einbinden', [
          'zufriedenstellen',
          'informieren',
          'beobachten',
        ]),
      ],
      [
        'Personalrat',
        wahl('hoch / gering', [
          'hoch / hoch',
          'gering / hoch',
          'gering / gering',
        ]),
        wahl('zufriedenstellen', [
          'eng einbinden',
          'informieren',
          'beobachten',
        ]),
      ],
      [
        'Angestellte an der Theke',
        wahl('gering / hoch', [
          'hoch / hoch',
          'hoch / gering',
          'gering / gering',
        ]),
        wahl('informieren', [
          'eng einbinden',
          'zufriedenstellen',
          'beobachten',
        ]),
      ],
      [
        'Getränkelieferant',
        wahl('gering / gering', [
          'hoch / hoch',
          'hoch / gering',
          'gering / hoch',
        ]),
        wahl('beobachten', [
          'eng einbinden',
          'zufriedenstellen',
          'informieren',
        ]),
      ],
    ],
    explanation:
        'Hoher Einfluss und hohes Interesse: eng einbinden. Hoher Einfluss, geringes Interesse: zufriedenstellen. Geringer Einfluss, hohes Interesse: informieren. Beides gering: beobachten.',
    punkte: 4,
  ),
  freitext(
    'i1-ps-2',
    'p-stakeholder',
    scenario:
        'Die Möbelspedition Brandt führt neue Handscanner im Lager ein. Die Projektleiterin schreibt dem internationalen Projektteam eine E-Mail.',
    code:
        'Subject: Kick-off new warehouse scanners\n'
        '\n'
        'Hi team,\n'
        'before we start, please keep the following\n'
        'people in the loop:\n'
        '- The works council must agree, because the\n'
        '  scanners record picking times per employee.\n'
        '- Our managing director pays for the project\n'
        '  and wants a short report every two weeks.\n'
        '- The shift supervisors will train their staff.\n'
        '- The scanner vendor delivers the devices in\n'
        '  week 12.\n'
        '- Our data protection officer has to check\n'
        '  which data is stored.\n'
        'Best regards, Aylin',
    prompt: 'Nenne vier Stakeholder, die in der E-Mail genannt werden.',
    kriterien: [
      krit(
        'Betriebsrat (works council)',
        stichwoerter: [
          'Betriebsrat',
          'works council',
          'Arbeitnehmervertretung',
        ],
      ),
      krit(
        'Geschäftsführer bzw. Geschäftsführung (managing director)',
        stichwoerter: [
          'Geschäftsführer',
          'Geschäftsführung',
          'Geschäftsleitung',
          'managing director',
        ],
      ),
      krit(
        'Schichtleiter (shift supervisors)',
        stichwoerter: [
          'Schichtleiter',
          'Schichtführer',
          'Schichtleitung',
          'shift supervisor',
        ],
      ),
      krit(
        'Lagermitarbeitende (staff)',
        stichwoerter: [
          'Lagermitarbeiter',
          'Mitarbeiter',
          'Mitarbeitende',
          'Lagerpersonal',
          'Beschäftigte',
          'staff',
        ],
      ),
      krit(
        'Lieferant bzw. Hersteller der Scanner (vendor)',
        stichwoerter: [
          'Lieferant',
          'Hersteller',
          'Händler',
          'Anbieter',
          'vendor',
        ],
      ),
      krit(
        'Datenschutzbeauftragter (data protection officer)',
        stichwoerter: [
          'Datenschutzbeauftragter',
          'Datenschutzbeauftragte',
          'Datenschutz',
          'data protection officer',
        ],
      ),
    ],
    loesung:
        'Genannt werden der Betriebsrat (works council), der Geschäftsführer (managing director), die Schichtleiter (shift supervisors) mit ihren Mitarbeitenden (staff), der Lieferant der Scanner (vendor) und der Datenschutzbeauftragte (data protection officer).',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Der Betriebsrat muss zustimmen, weil die Scanner Leistungsdaten je Person erfassen (§ 87 Abs. 1 Nr. 6 BetrVG).',
    punkte: 4,
  ),
  freitext(
    'i1-ps-3',
    'p-stakeholder',
    scenario:
        'Bei der Elektro Wenzel GmbH sollen 25 Monteure ihre Arbeitszeiten künftig per App statt auf Papier erfassen. Mehrere Monteure äußern Bedenken („Kontrolle“, „zu kompliziert“).',
    prompt:
        'Beschreibe zwei Maßnahmen, mit denen die Projektleitung die Akzeptanz bei den Monteuren erhöht.',
    kriterien: [
      krit(
        'Früh und offen informieren: Ziele, Nutzen und Zeitplan erklären, etwa in einer Infoveranstaltung.',
        punkte: 2,
        stichwoerter: [
          'informieren',
          'Information',
          'Infoveranstaltung',
          'Kommunikation',
          'erklären',
          'transparent',
        ],
      ),
      krit(
        'Betroffene beteiligen: Monteure als Testnutzer bzw. Key-User einbinden und ihre Rückmeldungen berücksichtigen.',
        punkte: 2,
        stichwoerter: [
          'beteiligen',
          'einbinden',
          'einbeziehen',
          'Key-User',
          'Pilot',
          'Testnutzer',
          'Feedback',
        ],
      ),
      krit(
        'Schulen und unterstützen: Schulungen, Kurzanleitung und feste Ansprechperson anbieten.',
        punkte: 2,
        stichwoerter: [
          'Schulung',
          'schulen',
          'Training',
          'Anleitung',
          'Ansprechpartner',
          'Support',
        ],
      ),
      krit(
        'Bedenken ernst nehmen: mit dem Betriebsrat regeln, dass die Daten nicht zur Leistungskontrolle genutzt werden.',
        punkte: 2,
        stichwoerter: [
          'Betriebsrat',
          'Betriebsvereinbarung',
          'Leistungskontrolle',
          'Bedenken',
          'Ängste',
          'Sorgen',
        ],
      ),
    ],
    loesung:
        'Die Projektleitung informiert früh und offen über Ziele, Nutzen und Zeitplan, etwa in einer Infoveranstaltung. Sie beteiligt die Monteure, zum Beispiel als Testnutzer in einer Pilotphase, und berücksichtigt deren Rückmeldungen. Schulungen und eine feste Ansprechperson nehmen die Sorge, die App sei zu kompliziert; eine Regelung mit dem Betriebsrat schließt Leistungskontrolle aus.',
    explanation:
        'Je Maßnahme 2 Punkte (Maßnahme und kurze Ausführung), höchstens 4 Punkte. Grundsatz: Betroffene zu Beteiligten machen - geringer Einfluss, hohes Interesse heißt mindestens „informieren“.',
    punkte: 4,
  ),

  // ================================================================ Projektphasen
  tabelle(
    'i1-vp-1',
    'v-phasen',
    scenario:
        'Der Phasenplan für das Projekt „Neues Kundenportal“ der Volksbank Weserland zeigt die fünf Projektphasen nach DIN 69901 in Wochen.',
    skizze: const GanttDiagramm([
      GanttVorgang('Initialisierung', 0, 2),
      GanttVorgang('Definition', 2, 3),
      GanttVorgang('Planung', 5, 3),
      GanttVorgang('Steuerung', 8, 10),
      GanttVorgang('Abschluss', 18, 2),
    ], einheit: 'Woche'),
    table: [
      ['Phase', 'Beginn nach Woche', 'Dauer in Wochen'],
      ['Initialisierung', '0', '2'],
      ['Definition', '2', '3'],
      ['Planung', '5', '3'],
      ['Steuerung', '8', '10'],
      ['Abschluss', '18', '2'],
    ],
    prompt: 'Werte den Phasenplan aus.',
    zeilen: [
      ['Frage', 'Antwort'],
      ['Gesamtdauer des Projekts in Wochen', zahl(20)],
      ['Anteil der Planung an der Gesamtdauer in %', zahl(15)],
      [
        'Der Projektauftrag ist unterschrieben am Ende von Woche',
        zahl(
          2,
          rationale: 'Der Projektauftrag schließt die Initialisierung ab.',
        ),
      ],
      [
        'Phase, in der das Lastenheft entsteht',
        wahl('Definition', ['Initialisierung', 'Planung', 'Steuerung']),
      ],
      [
        'Phase mit Soll-Ist-Vergleich und Statusberichten',
        wahl('Steuerung', ['Definition', 'Planung', 'Abschluss']),
      ],
      [
        'Termin- und Kostenplan sind freigegeben am Ende von Woche',
        zahl(
          8,
          rationale:
              'Die Pläne schließen die Planung ab, die nach Woche 8 endet.',
        ),
      ],
    ],
    explanation:
        'Gesamtdauer: 2 + 3 + 3 + 10 + 2 = 20 Wochen. Anteil der Planung: 3 / 20 = 15 %. Die Initialisierung endet mit dem Projektauftrag (Woche 2), in der Definition entsteht das Lastenheft, die Planung endet mit den freigegebenen Plänen (Woche 8), in der Steuerung wird überwacht und berichtet.',
    punkte: 6,
  ),
  freitext(
    'i1-vp-2',
    'v-phasen',
    scenario:
        'Das Projekt „Umstellung auf Windows 11“ der Kreisverwaltung Hohenau ist technisch fertig: Alle 180 Arbeitsplätze laufen.',
    prompt: 'Nenne drei Tätigkeiten, die in der Abschlussphase noch anstehen.',
    kriterien: [
      krit(
        'Abnahme des Ergebnisses durch den Auftraggeber',
        stichwoerter: ['Abnahme', 'abnehmen', 'Abnahmeprotokoll'],
      ),
      krit(
        'Abschlussbericht schreiben (Soll-Ist-Vergleich von Terminen, Kosten und Leistung)',
        stichwoerter: [
          'Abschlussbericht',
          'Soll-Ist',
          'Nachkalkulation',
          'Bericht',
        ],
      ),
      krit(
        'Lessons Learned: Erfahrungen auswerten und festhalten',
        stichwoerter: ['Lessons Learned', 'Erfahrungen', 'Rückblick', 'lernen'],
      ),
      krit(
        'Übergabe an den Betrieb samt Dokumentation',
        stichwoerter: ['Übergabe', 'Dokumentation', 'Betrieb', 'Support'],
      ),
      krit(
        'Projektteam auflösen und Ressourcen zurückgeben',
        stichwoerter: [
          'auflösen',
          'Auflösung',
          'Team entlasten',
          'Entlastung',
          'zurück in die Linie',
        ],
      ),
    ],
    loesung:
        'In der Abschlussphase nimmt der Auftraggeber das Ergebnis ab, die Projektleitung schreibt den Abschlussbericht und das Team hält seine Erfahrungen in einem Lessons-Learned-Workshop fest. Außerdem wird das Ergebnis mit Dokumentation an den Betrieb übergeben und das Projektteam aufgelöst.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Der Abschluss ist eine eigene Phase nach DIN 69901 - ohne Abnahme und Auswertung ist ein Projekt nicht beendet.',
    punkte: 3,
    difficulty: 1,
  ),
  reihenfolge(
    'i1-vp-3',
    'v-phasen',
    scenario:
        'Die Tierklinik Am Stadtwald führt eine digitale Patientenakte ein.',
    prompt:
        'Bringe die Tätigkeiten in die Reihenfolge, in der sie im Projekt anfallen.',
    items: [
      'Klinikleitung unterschreibt den Projektauftrag',
      'Anforderungen im Lastenheft festhalten',
      'Projektstrukturplan und Terminplan erstellen',
      'Wöchentlicher Soll-Ist-Vergleich mit Statusbericht',
      'Abnahme durch die Klinikleitung',
      'Lessons-Learned-Workshop mit dem Team',
    ],
    explanation:
        'Initialisierung (Projektauftrag), Definition (Lastenheft), Planung (Struktur- und Terminplan), Steuerung (Soll-Ist-Vergleich, Statusbericht), Abschluss (Abnahme, danach Lessons Learned).',
    punkte: 3,
  ),

  // ============================================================ Wasserfallmodell
  freitext(
    'i1-vw-1',
    'v-wasserfall',
    scenario:
        'Die Gemeinde Altenried lässt eine Software für die Vergabe von Kita-Plätzen entwickeln. Die Gemeinde hat ein Lastenheft geschrieben, das beauftragte Softwarehaus erstellt daraus das Pflichtenheft.',
    prompt: 'Erläutere den Unterschied zwischen Lastenheft und Pflichtenheft.',
    kriterien: [
      krit(
        'Das Lastenheft erstellt der Auftraggeber (hier die Gemeinde).',
        stichwoerter: ['Auftraggeber', 'Kunde', 'Gemeinde'],
      ),
      krit(
        'Das Lastenheft beschreibt, was das System leisten soll und wofür (Anforderungen).',
        stichwoerter: ['was', 'wofür', 'Anforderungen'],
      ),
      krit(
        'Das Pflichtenheft erstellt der Auftragnehmer (hier das Softwarehaus).',
        stichwoerter: [
          'Auftragnehmer',
          'Softwarehaus',
          'Dienstleister',
          'Lieferant',
        ],
      ),
      krit(
        'Das Pflichtenheft beschreibt, wie und womit die Anforderungen umgesetzt werden.',
        stichwoerter: ['wie', 'womit', 'Umsetzung', 'umgesetzt', 'Lösung'],
      ),
    ],
    loesung:
        'Das Lastenheft schreibt der Auftraggeber. Es beschreibt, was das System leisten soll und wofür - also die Anforderungen. Das Pflichtenheft schreibt der Auftragnehmer. Es beschreibt, wie und womit er die Anforderungen umsetzt, und wird vom Auftraggeber freigegeben.',
    explanation:
        'Je Aspekt 1 Punkt: Verfasser und Inhalt des Lastenhefts, Verfasser und Inhalt des Pflichtenhefts. Merkhilfe: Lastenheft = Was und Wofür, Pflichtenheft = Wie und Womit.',
    punkte: 4,
  ),
  rechnen(
    'i1-vw-2',
    'v-wasserfall',
    scenario:
        'Im Wasserfallprojekt „Lagerverwaltung“ ist das Pflichtenheft freigegeben. Der Kunde stellt einen Change Request für eine zusätzliche Etikettendruck-Funktion. Das Softwarehaus schätzt: 3 Tage Entwurf zu 720 € je Tag, 5 Tage Implementierung zu 640 € je Tag und 2 Tage Test zu 560 € je Tag. Auf die Summe kommt ein Zuschlag von 10 % für das Projektmanagement.',
    prompt: 'Berechne die Kosten des Change Requests.',
    answer: 7128,
    unit: '€',
    explanation:
        'Entwurf: 3 × 720 € = 2.160 €\n'
        'Implementierung: 5 × 640 € = 3.200 €\n'
        'Test: 2 × 560 € = 1.120 €\n'
        'Summe: 2.160 € + 3.200 € + 1.120 € = 6.480 €\n'
        'Zuschlag: 6.480 € × 0,10 = 648 €\n'
        'Kosten des Change Requests: 6.480 € + 648 € = 7.128 €.',
    punkte: 4,
  ),
  markieren(
    'i1-vw-3',
    'v-wasserfall',
    scenario:
        'Ein Softwarehaus entwickelt zum Festpreis eine Auftragsverwaltung nach dem Wasserfallmodell. Im Projekttagebuch stehen diese Einträge.',
    prompt: 'Markiere alle Einträge, die dem Wasserfallmodell widersprechen.',
    zeilen: [
      ja(
        'Die Implementierung beginnt, obwohl der Entwurf noch nicht freigegeben ist.',
        'Eine Phase beginnt erst, wenn das Ergebnis der vorherigen freigegeben ist.',
      ),
      nein(
        'Das Pflichtenheft wird vom Kunden unterschrieben, bevor der Entwurf startet.',
        'Genau so vorgesehen: Das freigegebene Dokument ist die Grundlage der nächsten Phase.',
      ),
      ja(
        'Ein neuer Kundenwunsch wird ohne Bewertung direkt eingebaut.',
        'Änderungen laufen über einen Change Request mit Bewertung von Termin und Kosten.',
      ),
      nein(
        'Die Entwickler testen ihre Module schon während der Implementierung.',
        'Modultests bei der Implementierung sind üblich; die Testphase prüft danach das Gesamtsystem.',
      ),
      ja(
        'Der Kunde erhält alle zwei Wochen ein lauffähiges Teilprodukt und priorisiert danach neu.',
        'Das ist das Vorgehen von Scrum - im Wasserfall gibt es lauffähige Software erst am Ende.',
      ),
      nein(
        'Am Ende der Testphase steht ein Testprotokoll.',
        'Jede Phase endet mit einem dokumentierten Ergebnis.',
      ),
    ],
    explanation:
        'Der Wasserfall ist sequenziell und dokumentgetrieben: Jede Phase endet mit einem freigegebenen Ergebnis, Änderungen laufen über Change Requests, lauffähige Software entsteht erst am Ende.',
    punkte: 3,
  ),

  // ======================================================== Klassisch oder agil?
  freitext(
    'i1-va-1',
    'v-auswahl',
    scenario:
        'Der Tischlerei-Verbund Holzwerk Nord will ein Kundenportal, in dem Kunden Küchen konfigurieren. Die Geschäftsführung hat erst grobe Ideen und erwartet, dass sich viele Wünsche erst beim Ausprobieren zeigen. Eine Mitarbeiterin des Vertriebs kann alle zwei Wochen einen halben Tag Rückmeldung geben. Erste Funktionen sollen möglichst früh online gehen; das Monatsbudget ist fest.',
    prompt:
        'Entscheide dich für Wasserfall oder Scrum und begründe deine Entscheidung mit zwei Argumenten aus der Situation.',
    kriterien: [
      krit('Vorgehensmodell: Scrum', stichwoerter: ['Scrum', 'agil']),
      krit(
        'Die Anforderungen sind unklar und werden sich ändern - in Scrum wird das Product Backlog laufend neu geordnet.',
        punkte: 2,
        stichwoerter: [
          'unklar',
          'ändern',
          'grobe Ideen',
          'nicht fest',
          'Anforderungen',
        ],
      ),
      krit(
        'Die Kundin ist regelmäßig verfügbar und kann im Sprint Review Rückmeldung geben.',
        punkte: 2,
        stichwoerter: [
          'Rückmeldung',
          'Feedback',
          'verfügbar',
          'Sprint Review',
          'alle zwei Wochen',
        ],
      ),
      krit(
        'Früher Nutzen: Nach jedem Sprint entsteht ein nutzbares Increment, erste Funktionen gehen früh online.',
        punkte: 2,
        stichwoerter: [
          'früh',
          'Increment',
          'Inkrement',
          'Teilergebnis',
          'nutzbar',
        ],
      ),
      krit(
        'Festes Monatsbudget bei offenem Umfang passt zu Scrum: Zeit und Kosten stehen fest, der Umfang ergibt sich.',
        punkte: 2,
        stichwoerter: [
          'Budget',
          'Umfang variabel',
          'Umfang offen',
          'Kosten fest',
        ],
      ),
    ],
    loesung:
        'Scrum. Die Anforderungen sind erst grob bekannt und werden sich durch das Ausprobieren ändern; ein Pflichtenheft für den Wasserfall lässt sich so nicht schreiben. Die Vertriebsmitarbeiterin kann alle zwei Wochen Rückmeldung geben - das passt zu zweiwöchigen Sprints mit Sprint Review. Außerdem liefert jeder Sprint ein nutzbares Increment, sodass erste Funktionen früh online gehen.',
    explanation:
        '1 Punkt für das Modell, je Argument 2 Punkte, höchstens 5 Punkte. Gewertet werden nur Argumente aus der Situation - „Scrum ist schneller“ oder „moderner“ zählt nicht.',
    punkte: 5,
  ),
  tabelle(
    'i1-va-2',
    'v-auswahl',
    scenario:
        'Ein Softwarehaus erstellt für seine neuen Auszubildenden eine Übersicht der beiden Vorgehensmodelle.',
    prompt: 'Vervollständige den Vergleich.',
    zeilen: [
      ['Merkmal', 'Wasserfall', 'Scrum'],
      [
        'Planung',
        wahl('vollständig vorab', ['im Detail je Sprint', 'gar nicht']),
        wahl('im Detail je Sprint', ['vollständig vorab', 'gar nicht']),
      ],
      [
        'Anforderungen',
        wahl('fest im Pflichtenheft', [
          'veränderlich im Backlog',
          'nicht festgehalten',
        ]),
        wahl('veränderlich im Backlog', [
          'fest im Pflichtenheft',
          'nicht festgehalten',
        ]),
      ],
      [
        'Nutzbares Ergebnis',
        wahl('am Projektende', ['nach jedem Sprint', 'nach jedem Daily']),
        wahl('nach jedem Sprint', ['am Projektende', 'nach jedem Daily']),
      ],
      [
        'Fest im magischen Dreieck',
        wahl('Umfang', ['Zeit und Kosten', 'nichts']),
        wahl('Zeit und Kosten', ['Umfang', 'nichts']),
      ],
    ],
    explanation:
        'Wasserfall: vollständig vorab geplant, Anforderungen fest im Pflichtenheft, Ergebnis am Ende, Umfang fest. Scrum: Detailplanung je Sprint, veränderliches Product Backlog, nutzbares Increment nach jedem Sprint, Zeit und Kosten fest.',
    punkte: 4,
  ),
  freitext(
    'i1-va-3',
    'v-auswahl',
    scenario:
        'Dein Ausbildungsbetrieb soll für einen britischen Kunden eine Schnittstelle zu dessen Lagerverwaltung entwickeln. Der Kunde schreibt:',
    code:
        'Dear project team,\n'
        '\n'
        'please find attached our complete requirements\n'
        'specification (84 pages). The scope is final and\n'
        'will not change. We expect a fixed-price offer\n'
        'and delivery by 30 November. Our auditors require\n'
        'the full design documentation before development\n'
        'starts. Please note that our staff will not be\n'
        'available for regular meetings during the project.\n'
        '\n'
        'Kind regards, H. Clarke',
    prompt:
        'Der Betrieb entscheidet sich für das Wasserfallmodell. Nenne drei Aussagen der E-Mail, die diese Entscheidung stützen.',
    kriterien: [
      krit(
        'Die Anforderungen liegen vollständig vor und ändern sich nicht (complete specification, scope is final).',
        stichwoerter: [
          'Anforderungen',
          'vollständig',
          'final',
          'ändern sich nicht',
          'Spezifikation',
          'Umfang steht fest',
        ],
      ),
      krit(
        'Der Kunde erwartet ein Festpreisangebot (fixed-price offer).',
        stichwoerter: ['Festpreis', 'fixed price', 'fester Preis'],
      ),
      krit(
        'Es gibt einen festen Liefertermin (delivery by 30 November).',
        stichwoerter: ['Termin', 'Liefertermin', 'Lieferung', '30. November'],
      ),
      krit(
        'Die vollständige Entwurfsdokumentation wird vor Entwicklungsbeginn verlangt (auditors).',
        stichwoerter: ['Dokumentation', 'Prüfer', 'Auditoren', 'Entwurf'],
      ),
      krit(
        'Die Mitarbeitenden des Kunden stehen nicht für regelmäßige Treffen zur Verfügung.',
        stichwoerter: [
          'nicht verfügbar',
          'keine Zeit',
          'keine regelmäßigen',
          'Treffen',
          'Meetings',
        ],
      ),
    ],
    loesung:
        'Für den Wasserfall spricht: Die Anforderungen liegen vollständig vor und der Umfang ändert sich nicht. Der Kunde verlangt einen Festpreis und einen festen Liefertermin (30. November). Seine Prüfer wollen die vollständige Entwurfsdokumentation vor Entwicklungsbeginn, und seine Mitarbeitenden stehen nicht für regelmäßige Treffen bereit - Sprint Reviews wären also kaum möglich.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Stabile Anforderungen, Festpreis, Dokumentationspflicht und ein kaum verfügbarer Kunde sind die klassischen Argumente für den Wasserfall.',
    punkte: 3,
  ),

  // ============================================================ Agiles Manifest
  markieren(
    'i1-sm-1',
    's-manifest',
    scenario:
        'Ein international besetztes Entwicklungsteam der Medisoft GmbH hat sich Arbeitsregeln gegeben und an die Bürowand gehängt.',
    prompt:
        'Markiere alle Regeln, die den Werten und Prinzipien des agilen Manifests widersprechen.',
    zeilen: [
      ja(
        'We deliver the software once, after 12 months, when everything is finished.',
        'Widerspricht dem Prinzip, funktionierende Software früh und regelmäßig zu liefern.',
      ),
      nein(
        'We talk to each other every day instead of only writing tickets.',
        'Passt: Individuen und Interaktionen, direkte Gespräche.',
      ),
      ja(
        'Requirements are frozen after the first week; later changes are rejected.',
        'Widerspricht „Reagieren auf Veränderung“ - Änderungen sind auch spät willkommen.',
      ),
      nein(
        'Our customer sees the product every two weeks and gives feedback.',
        'Passt: Zusammenarbeit mit dem Kunden.',
      ),
      ja(
        'Progress is measured by the number of pages in the specification.',
        'Das wichtigste Fortschrittsmaß ist funktionierende Software, nicht Papier.',
      ),
      nein(
        'After each iteration we discuss how to work better.',
        'Passt: regelmäßig reflektieren und das Verhalten anpassen.',
      ),
      nein(
        'We document what is needed to operate the software.',
        'Passt: Dokumentation bleibt wertvoll, sie ist nur nachrangig.',
      ),
    ],
    explanation:
        'Das Manifest verlangt frühe und regelmäßige Lieferung, Offenheit für Änderungen und funktionierende Software als Fortschrittsmaß. Dokumentation ist nicht verboten - links vor rechts, nicht links statt rechts.',
    punkte: 3,
  ),
  paare(
    'i1-sm-2',
    's-manifest',
    scenario:
        'Ein Softwarehaus aus Erfurt stellt auf Scrum um. Die Scrum Masterin zeigt dem Team, wo sich die Prinzipien des agilen Manifests in Scrum wiederfinden.',
    prompt: 'Verbinde jedes Prinzip mit seiner Umsetzung in Scrum.',
    paare: [
      paar('Häufig liefern', 'Increment in jedem Sprint'),
      paar('Änderungen willkommen', 'Product Backlog neu ordnen'),
      paar('Täglich zusammenarbeiten', 'Daily Scrum'),
      paar('Software als Fortschrittsmaß', 'Sprint Review am Increment'),
      paar('Reflektieren und anpassen', 'Sprint Retrospective'),
    ],
    explanation:
        'Scrum setzt die Prinzipien in feste Bestandteile um: Jeder Sprint liefert ein Increment, das Product Backlog nimmt Änderungen auf, das Daily Scrum sorgt für tägliche Abstimmung, im Review zählt das lauffähige Ergebnis und in der Retrospektive verbessert das Team seine Arbeitsweise.',
    punkte: 3,
  ),
  freitext(
    'i1-sm-3',
    's-manifest',
    scenario:
        'Die Webagentur Kliq will agil arbeiten. Der Geschäftsführer bittet dich, dem Team die Grundlage zu erklären: das agile Manifest.',
    prompt:
        'Nenne die vier Werte des agilen Manifests (jeweils die Seite, die höher geschätzt wird).',
    kriterien: [
      krit(
        'Individuen und Interaktionen (mehr als Prozesse und Werkzeuge)',
        stichwoerter: ['Individuen', 'Interaktionen', 'Menschen'],
      ),
      krit(
        'Funktionierende Software (mehr als umfassende Dokumentation)',
        stichwoerter: [
          'funktionierende Software',
          'lauffähige Software',
          'funktionierendes Produkt',
          'Software',
        ],
      ),
      krit(
        'Zusammenarbeit mit dem Kunden (mehr als Vertragsverhandlung)',
        stichwoerter: ['Kunden', 'Kunde', 'Kundenzusammenarbeit'],
      ),
      krit(
        'Reagieren auf Veränderung (mehr als das Befolgen eines Plans)',
        stichwoerter: ['Veränderung', 'Änderungen', 'reagieren', 'flexibel'],
      ),
    ],
    loesung:
        'Individuen und Interaktionen sind wichtiger als Prozesse und Werkzeuge. Funktionierende Software ist wichtiger als umfassende Dokumentation. Zusammenarbeit mit dem Kunden ist wichtiger als Vertragsverhandlung. Reagieren auf Veränderung ist wichtiger als das Befolgen eines Plans.',
    explanation:
        'Je Wert 1 Punkt. Die rechte Seite bleibt wertvoll - die linke wird nur höher geschätzt. Das Manifest von 2001 umfasst vier Werte und zwölf Prinzipien.',
    punkte: 4,
    difficulty: 1,
  ),

  // ============================================ Die drei Verantwortlichkeiten
  tabelle(
    'i1-sr-1',
    's-rollen',
    scenario:
        'Das Fintech-Unternehmen Paylane arbeitet mit Scrum. Im englischen Team-Handbuch steht:',
    code:
        'Team handbook - who does what\n'
        '\n'
        'Maria decides which backlog item is most\n'
        'valuable and in which order the items are built.\n'
        '\n'
        'Tom makes sure the Scrum events take place,\n'
        'keeps them within the timebox and helps to\n'
        'remove impediments.\n'
        '\n'
        'Ali, Jana and Chen build the product. They plan\n'
        'their own work for the sprint and make sure\n'
        'every item meets the Definition of Done.',
    prompt:
        'Welche Scrum-Verantwortlichkeit gehört jeweils dazu? Vervollständige die Tabelle.',
    zeilen: [
      ['Person oder Aufgabe', 'Verantwortlichkeit'],
      [
        'Maria',
        wahl('Product Owner', ['Scrum Master', 'Developers']),
      ],
      [
        'Tom',
        wahl('Scrum Master', ['Product Owner', 'Developers']),
      ],
      [
        'Ali, Jana und Chen',
        wahl('Developers', ['Product Owner', 'Scrum Master']),
      ],
      [
        'Formuliert das Produktziel',
        wahl('Product Owner', ['Scrum Master', 'Developers']),
      ],
      [
        'Erstellt den Plan im Sprint Backlog',
        wahl('Developers', ['Product Owner', 'Scrum Master']),
      ],
      [
        'Coacht das Team im Selbstmanagement',
        wahl('Scrum Master', ['Product Owner', 'Developers']),
      ],
    ],
    explanation:
        'Maria ordnet das Product Backlog nach Wert - Product Owner. Tom sorgt für wirksame Events und beseitigt Hindernisse (impediments) - Scrum Master. Ali, Jana und Chen bauen das Produkt, planen ihren Sprint selbst und halten die Definition of Done ein - Developers.',
    punkte: 3,
  ),
  freitext(
    'i1-sr-2',
    's-rollen',
    scenario:
        'Die Stadtwerke Lahntal entwickeln mit einem Scrum Team eine Kunden-App. Frau Demir aus dem Vertrieb übernimmt die Verantwortlichkeit Product Owner.',
    prompt: 'Beschreibe zwei Aufgaben, die Frau Demir als Product Owner hat.',
    kriterien: [
      krit(
        'Sie formuliert das Produktziel und macht es allen verständlich.',
        punkte: 2,
        stichwoerter: ['Produktziel', 'Product Goal', 'Vision'],
      ),
      krit(
        'Sie pflegt das Product Backlog: Einträge erstellen und verständlich beschreiben.',
        punkte: 2,
        stichwoerter: [
          'Product Backlog',
          'Backlog pflegen',
          'Einträge',
          'User Stories',
        ],
      ),
      krit(
        'Sie ordnet die Einträge des Product Backlogs nach ihrem Wert (Priorisierung).',
        punkte: 2,
        stichwoerter: [
          'priorisieren',
          'Priorisierung',
          'ordnet',
          'Reihenfolge',
        ],
      ),
      krit(
        'Sie vertritt die Interessen der Stakeholder und verantwortet den Wert des Produkts.',
        punkte: 2,
        stichwoerter: ['Stakeholder', 'Wert', 'Kunden', 'Nutzen'],
      ),
      krit(
        'Nur sie darf einen Sprint abbrechen, wenn das Sprintziel hinfällig geworden ist.',
        punkte: 2,
        stichwoerter: ['abbrechen', 'Abbruch', 'Sprint abbrechen'],
      ),
    ],
    loesung:
        'Frau Demir formuliert das Produktziel und macht es dem Team und den Stakeholdern verständlich. Sie pflegt das Product Backlog und ordnet seine Einträge nach ihrem Wert - sie entscheidet also, was als Nächstes gebaut wird. Dabei vertritt sie die Interessen der Stakeholder.',
    explanation:
        'Je Aufgabe 2 Punkte, höchstens 4 Punkte. Der Product Owner ist eine Person, kein Gremium, und verantwortet den Wert des Produkts.',
    punkte: 4,
  ),
  markieren(
    'i1-sr-3',
    's-rollen',
    scenario:
        'Die Versicherung Albatros sucht per Stellenanzeige eine Scrum Masterin oder einen Scrum Master. Im Entwurf steht unter „Ihre Aufgaben“:',
    prompt:
        'Markiere alle Punkte, die laut Scrum Guide nicht zur Verantwortlichkeit des Scrum Masters gehören.',
    zeilen: [
      ja(
        'Sie weisen den Entwicklern täglich ihre Aufgaben zu.',
        'Die Developers organisieren ihre Arbeit selbst.',
      ),
      nein(
        'Sie coachen das Team in Selbstmanagement und interdisziplinärer Zusammenarbeit.',
        'Kernaufgabe des Scrum Masters.',
      ),
      ja(
        'Sie legen fest, welche Funktionen als Nächstes gebaut werden.',
        'Über Inhalt und Reihenfolge entscheidet der Product Owner.',
      ),
      nein(
        'Sie sorgen dafür, dass Hindernisse beseitigt werden.',
        'Gehört zum Dienst am Scrum Team.',
      ),
      ja(
        'Sie sind disziplinarische Führungskraft des Teams und genehmigen Urlaub.',
        'Im Scrum Team gibt es keine Hierarchie; der Scrum Master ist kein Vorgesetzter.',
      ),
      nein(
        'Sie achten darauf, dass alle Scrum-Events stattfinden und die Timebox einhalten.',
        'So beschreibt es der Scrum Guide.',
      ),
      nein(
        'Sie unterstützen den Product Owner mit Techniken für die Backlog-Pflege.',
        'Der Scrum Master dient auch dem Product Owner.',
      ),
    ],
    explanation:
        'Der Scrum Master verantwortet die Wirksamkeit des Scrum Teams: Er coacht, sorgt für produktive Events und dafür, dass Hindernisse verschwinden. Er verteilt keine Arbeit, priorisiert keine Inhalte und ist kein Vorgesetzter.',
    punkte: 3,
  ),

  // ================================================ Artefakte und Commitments
  zuordnen(
    'i1-sa-1',
    's-artefakte',
    scenario:
        'Ein Scrum Team entwickelt die Buchungs-App der Kletterhalle Gipfelglück.',
    prompt: 'Ordne jeden Punkt dem Artefakt zu, in das er gehört.',
    buckets: ['Product Backlog', 'Sprint Backlog', 'Increment'],
    items: [
      zu(
        'Wunsch der Hallenleitung nach Gutscheinen, noch nicht geschätzt',
        0,
        'Alles, was das Produkt einmal können soll, steht im Product Backlog.',
      ),
      zu(
        'Fertig getestete und geprüfte Kursbuchung',
        2,
        'Erfüllt die Definition of Done - Teil des Increments.',
      ),
      zu(
        'Aufgabe „Datenbankfeld für Kursleiter anlegen“ für diesen Sprint',
        1,
        'Der Plan der Developers für den laufenden Sprint.',
      ),
      zu(
        'Produktziel: „Mitglieder buchen jeden Kurs in unter einer Minute“',
        0,
        'Das Produktziel ist das Commitment des Product Backlogs.',
      ),
      zu(
        'Sprintziel: „Kurse lassen sich online stornieren“',
        1,
        'Das Sprintziel ist das Commitment des Sprint Backlogs.',
      ),
      zu(
        'Stornofunktion, die alle Tests bestanden hat und dokumentiert ist',
        2,
        'Nutzbar und „done“ - gehört zum Increment.',
      ),
    ],
    explanation:
        'Product Backlog: alle Wünsche, Commitment Produktziel. Sprint Backlog: Sprintziel, ausgewählte Einträge und Plan der Developers. Increment: alles, was die Definition of Done erfüllt.',
    punkte: 3,
  ),
  freitext(
    'i1-sa-2',
    's-artefakte',
    scenario:
        'Im Sprint Review der Kletterhallen-App fragt die Hallenleitung: „Ihr redet von Akzeptanzkriterien und von der Definition of Done - ist das nicht dasselbe?“',
    prompt:
        'Erläutere den Unterschied zwischen der Definition of Done und Akzeptanzkriterien.',
    kriterien: [
      krit(
        'Die Definition of Done gilt für alle Einträge gleichermaßen.',
        stichwoerter: [
          'alle Einträge',
          'alle Stories',
          'jede Story',
          'jeden Eintrag',
          'für alle',
          'allgemein',
        ],
      ),
      krit(
        'Die Definition of Done beschreibt die Qualität, z. B. Code geprüft, Tests grün, dokumentiert.',
        stichwoerter: [
          'Qualität',
          'getestet',
          'Tests',
          'Review',
          'dokumentiert',
        ],
      ),
      krit(
        'Akzeptanzkriterien gelten nur für eine einzelne User Story.',
        stichwoerter: [
          'einzelne',
          'eine Story',
          'je Story',
          'pro Story',
          'bestimmte Story',
          'individuell',
        ],
      ),
      krit(
        'Akzeptanzkriterien beschreiben das fachliche Verhalten dieser Story.',
        stichwoerter: ['fachlich', 'Verhalten', 'Funktion', 'inhaltlich'],
      ),
    ],
    loesung:
        'Die Definition of Done gilt für alle Einträge und beschreibt die Qualität, die jedes Ergebnis haben muss, etwa „Code geprüft, alle Tests grün, dokumentiert“. Akzeptanzkriterien gelten nur für eine einzelne User Story und beschreiben deren fachliches Verhalten, etwa „Bei einer Stornierung bis 24 Stunden vorher wird der Betrag gutgeschrieben“.',
    explanation:
        'Je Aspekt 1 Punkt: Geltungsbereich und Inhalt der Definition of Done, Geltungsbereich und Inhalt der Akzeptanzkriterien. Fertig ist eine Story erst, wenn beides erfüllt ist.',
    punkte: 4,
  ),
  markieren(
    'i1-sa-3',
    's-artefakte',
    scenario:
        'Die Definition of Done des Teams verlangt: Code-Review erfolgt, alle automatischen Tests grün, Dokumentation aktualisiert. Stand am letzten Sprinttag:',
    table: [
      ['Story', 'Review', 'Tests', 'Doku'],
      ['Kurs buchen', 'ja', 'grün', 'ja'],
      ['Kurs stornieren', 'ja', 'grün', 'ja'],
      ['Warteliste', 'ja', '2 rot', 'ja'],
      ['Gutschein einlösen', 'nein', 'grün', 'ja'],
      ['Profilbild ändern', 'ja', 'grün', 'nein'],
      ['Lastschrift', 'ja', 'grün', 'ja'],
    ],
    prompt:
        'Markiere alle Stories, die zum Increment gehören und im Sprint Review als fertig gezeigt werden.',
    zeilen: [
      ja('Kurs buchen', 'Review, Tests und Dokumentation sind erfüllt.'),
      ja('Kurs stornieren', 'Alle drei Punkte der Definition of Done erfüllt.'),
      nein('Warteliste', 'Zwei Tests schlagen fehl - nicht „done“.'),
      nein('Gutschein einlösen', 'Das Code-Review fehlt.'),
      nein('Profilbild ändern', 'Die Dokumentation ist nicht aktualisiert.'),
      ja('Lastschrift', 'Alle drei Punkte der Definition of Done erfüllt.'),
    ],
    explanation:
        'Zum Increment gehört nur, was die Definition of Done vollständig erfüllt. Die drei unfertigen Stories gehen zurück ins Product Backlog und zählen nicht zur Velocity - „fast fertig“ gibt es nicht.',
    punkte: 3,
  ),

  // ============================================================= Scrum-Events
  tabelle(
    'i1-se-1',
    's-events',
    scenario:
        'Das Scrum Team der Reederei Hansekai wechselt von Monatssprints auf Sprints von zwei Wochen. Die Scrum Masterin rechnet die Timeboxen anteilig um.',
    prompt:
        'Trage die Höchstdauern ein (in Stunden, beim Daily Scrum in Minuten).',
    zeilen: [
      ['Event', 'Monatssprint', '2-Wochen-Sprint'],
      ['Sprint Planning (h)', zahl(8), zahl(4)],
      ['Sprint Review (h)', zahl(4), zahl(2)],
      ['Sprint Retrospective (h)', zahl(3), zahl(1.5)],
      [
        'Daily Scrum (min)',
        zahl(15),
        zahl(15, rationale: 'Das Daily bleibt immer bei 15 Minuten.'),
      ],
    ],
    explanation:
        'Der Scrum Guide nennt für einen Monatssprint: Planning 8 h, Review 4 h, Retrospektive 3 h. Anteilig für zwei Wochen (Faktor 0,5): 4 h, 2 h und 1,5 h. Das Daily Scrum dauert unabhängig von der Sprintlänge höchstens 15 Minuten.',
    punkte: 4,
  ),
  paare(
    'i1-se-2',
    's-events',
    scenario:
        'Das Scrum Team der Reederei Hansekai erklärt einer neuen Kollegin die fünf Events.',
    prompt: 'Verbinde jedes Scrum-Event mit seinem Zweck.',
    paare: [
      paar('Sprint', 'Rahmen für alle anderen Events'),
      paar('Sprint Planning', 'Sprintziel und Plan festlegen'),
      paar('Daily Scrum', 'Fortschritt zum Sprintziel prüfen'),
      paar('Sprint Review', 'Increment mit Stakeholdern prüfen'),
      paar('Sprint Retrospective', 'Zusammenarbeit verbessern'),
    ],
    explanation:
        'Der Sprint ist der Container für alle anderen Events. Planning: warum, was, wie. Daily: Fortschritt prüfen und die nächsten 24 Stunden planen. Review: das Produkt mit Stakeholdern prüfen. Retrospektive: die Arbeitsweise des Teams verbessern.',
    punkte: 3,
    difficulty: 1,
  ),
  lueckentext(
    'i1-se-3',
    's-events',
    scenario:
        'Ein neu gegründetes Scrum Team der Solarfirma Heliotec hat seinen Sprintkalender verschickt:',
    code:
        'Sprint 7 calendar (sprint length: 2 weeks)\n'
        '\n'
        'Mon wk 1  09:00-13:00  Sprint Planning\n'
        'daily     09:00-09:30  Daily Scrum (team lead\n'
        '                       collects status reports)\n'
        'Thu wk 2  14:00-15:00  Sprint Retrospective\n'
        'Fri wk 2  10:00-12:00  Sprint Review with\n'
        '                       customers',
    prompt: 'Prüfe den Kalender am Scrum Guide und ergänze die Auswertung.',
    text:
        'Das Sprint Planning dauert {0} Stunden - bei anteiliger Umrechnung ist das für einen 2-Wochen-Sprint zulässig. Das Daily Scrum überschreitet seine Timebox um {1} Minuten. Außerdem ist es kein {2} an eine Führungskraft, sondern ein Event der Developers. Die Retrospektive liegt hier {3} dem Sprint Review; richtig ist die Reihenfolge erst {4}, dann Retrospektive.',
    luecken: [
      zahl(4, rationale: '09:00 bis 13:00 Uhr.'),
      zahl(15, rationale: '30 Minuten geplant, 15 Minuten erlaubt.'),
      wahl('Statusbericht', ['Planungstreffen', 'Abnahmetermin']),
      wahl('vor', ['nach', 'gleichzeitig mit']),
      wahl('Review', ['Planning', 'Daily Scrum']),
    ],
    explanation:
        'Planning: 8 h × 0,5 = 4 h - passt. Daily: 30 min geplant, 15 min erlaubt, also 15 min zu lang; es dient den Developers, nicht dem Bericht an Vorgesetzte. Die Retrospektive ist das letzte Event des Sprints und folgt auf das Review.',
    punkte: 5,
  ),
  reihenfolge(
    'i1-se-4',
    's-events',
    scenario:
        'Das Team von Heliotec plant seinen nächsten zweiwöchigen Sprint.',
    prompt: 'Bringe den Ablauf eines Sprints in die richtige Reihenfolge.',
    items: [
      'Sprint Planning: Sprintziel festlegen, Einträge auswählen',
      'Tägliche Arbeit am Increment mit Daily Scrum',
      'Sprint Review: Increment mit Stakeholdern prüfen',
      'Sprint Retrospective: Zusammenarbeit verbessern',
      'Der nächste Sprint beginnt unmittelbar',
    ],
    explanation:
        'Ein Sprint beginnt mit dem Planning, dann wird täglich gearbeitet und im Daily Scrum abgestimmt. Am Ende stehen erst das Review (Produkt), dann die Retrospektive (Zusammenarbeit). Der nächste Sprint schließt ohne Pause an.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i1-se-5',
    's-events',
    scenario:
        'Der Geschäftsführer von Heliotec möchte die beiden Termine am Sprintende zusammenlegen: „Das ist doch beides ein Rückblick.“',
    prompt:
        'Erläutere den Unterschied zwischen Sprint Review und Sprint Retrospective.',
    kriterien: [
      krit(
        'Im Sprint Review geht es um das Produkt: Das Increment wird geprüft.',
        stichwoerter: ['Produkt', 'Increment', 'Inkrement', 'Ergebnis'],
      ),
      krit(
        'Am Sprint Review nehmen neben dem Scrum Team die Stakeholder teil und geben Rückmeldung.',
        stichwoerter: ['Stakeholder', 'Kunden', 'Rückmeldung', 'Feedback'],
      ),
      krit(
        'In der Retrospektive geht es um die Zusammenarbeit: Abläufe, Werkzeuge, Miteinander.',
        stichwoerter: [
          'Zusammenarbeit',
          'Arbeitsweise',
          'Prozess',
          'Abläufe',
          'Miteinander',
        ],
      ),
      krit(
        'An der Retrospektive nimmt nur das Scrum Team teil; Ergebnis sind Verbesserungsmaßnahmen.',
        stichwoerter: [
          'nur das Scrum Team',
          'nur das Team',
          'ohne Stakeholder',
          'Verbesserung',
          'Maßnahmen',
        ],
      ),
    ],
    loesung:
        'Im Sprint Review prüfen Scrum Team und Stakeholder gemeinsam das Produkt, also das Increment, und beraten die nächsten Schritte. In der Retrospektive spricht nur das Scrum Team über seine Zusammenarbeit - Abläufe, Werkzeuge, Miteinander - und vereinbart Verbesserungen. Wegen der unterschiedlichen Themen und Teilnehmer bleiben es zwei Events.',
    explanation:
        'Je Aspekt 1 Punkt: Thema und Teilnehmer des Reviews, Thema und Teilnehmer der Retrospektive. Kurz: Review = Produkt mit Stakeholdern, Retrospektive = Zusammenarbeit im Team.',
    punkte: 4,
  ),

  // ============================================= User Stories und Schätzung
  freitext(
    'i1-st-1',
    's-stories',
    scenario:
        'Für die Lager-App der Getränke Fischer KG notiert der Product Owner aus einem Gespräch: „Die Lageristen wollen den Barcode einer Palette scannen können. Dann müssen sie den Lagerplatz nicht mehr von Hand eintippen.“',
    prompt: 'Formuliere daraus eine User Story nach dem üblichen Muster.',
    kriterien: [
      krit(
        'Rolle: „Als Lagerist ...“',
        stichwoerter: [
          'als Lagerist',
          'als Lagermitarbeiter',
          'als Lagerarbeiter',
          'als Mitarbeiter',
        ],
      ),
      krit(
        'Ziel: „... möchte ich den Barcode einer Palette scannen ...“',
        stichwoerter: ['möchte ich', 'will ich', 'Barcode', 'scannen'],
      ),
      krit(
        'Nutzen: „... damit ich den Lagerplatz nicht mehr von Hand eintippen muss.“',
        stichwoerter: ['damit', 'um zu', 'nicht eintippen', 'von Hand'],
      ),
    ],
    loesung:
        'Als Lagerist möchte ich den Barcode einer Palette scannen, damit ich den Lagerplatz nicht mehr von Hand eintippen muss.',
    explanation:
        'Je Bestandteil 1 Punkt: Rolle, Ziel, Nutzen. Das Muster lautet „Als <Rolle> möchte ich <Ziel>, damit <Nutzen>“. Ohne Nutzen lässt sich eine Story nicht priorisieren.',
    punkte: 3,
  ),
  tabelle(
    'i1-st-2',
    's-stories',
    scenario:
        'Ein Sprint von 8 Arbeitstagen startet mit 40 Story Points. Die Ideallinie im Burndown-Chart fällt gleichmäßig auf null. Das Team trägt jeden zweiten Tag den Ist-Stand ein.',
    prompt:
        'Trage die laut Ideallinie noch offenen Story Points ein und bewerte den Stand.',
    zeilen: [
      ['Nach Tag', 'Ideal offen', 'Ist offen', 'Stand'],
      [
        '2',
        zahl(30),
        '32',
        wahl('hinter dem Plan', ['im Plan', 'vor dem Plan']),
      ],
      [
        '4',
        zahl(20),
        '20',
        wahl('im Plan', ['hinter dem Plan', 'vor dem Plan']),
      ],
      [
        '6',
        zahl(10),
        '6',
        wahl('vor dem Plan', ['im Plan', 'hinter dem Plan']),
      ],
    ],
    explanation:
        'Abbau je Tag: 40 SP / 8 Tage = 5 SP. Ideal offen nach Tag 2: 40 - 10 = 30, nach Tag 4: 40 - 20 = 20, nach Tag 6: 40 - 30 = 10. Liegt der Ist-Wert über der Ideallinie (32 > 30), ist das Team hinter dem Plan; liegt er darunter (6 < 10), ist es voraus.',
    punkte: 3,
  ),
  paare(
    'i1-st-3',
    's-stories',
    scenario:
        'Im Refinement prüft das Team der Getränke Fischer KG seine User Stories an den INVEST-Kriterien.',
    prompt: 'Verbinde jedes Kriterium mit seiner Bedeutung.',
    paare: [
      paar('Independent', 'unabhängig umsetzbar'),
      paar('Negotiable', 'verhandelbar'),
      paar('Valuable', 'bringt einen Wert'),
      paar('Estimable', 'lässt sich schätzen'),
      paar('Small', 'passt in einen Sprint'),
      paar('Testable', 'über Akzeptanzkriterien prüfbar'),
    ],
    explanation:
        'INVEST: Independent (unabhängig), Negotiable (verhandelbar), Valuable (wertvoll), Estimable (schätzbar), Small (klein genug für einen Sprint), Testable (prüfbar über Akzeptanzkriterien).',
    punkte: 3,
    difficulty: 1,
  ),
  rechnen(
    'i1-st-4',
    's-stories',
    scenario:
        'Das Team der Getränke Fischer KG hat in den letzten drei Sprints 26, 30 und 34 Story Points fertiggestellt. Für das Release stehen noch 150 Story Points im Product Backlog. Ein Sprint dauert 2 Wochen.',
    prompt:
        'Berechne, nach wie vielen Wochen das Release voraussichtlich fertig ist.',
    answer: 10,
    unit: 'Wochen',
    explanation:
        'Velocity = (26 + 30 + 34) / 3 = 90 / 3 = 30 Story Points je Sprint.\n'
        'Sprints = 150 / 30 = 5.\n'
        'Dauer = 5 Sprints × 2 Wochen = 10 Wochen.',
    punkte: 3,
  ),

  // ======================================================= Aufbau eines Netzplans
  tabelle(
    'i1-ng-1',
    'n-grundlagen',
    scenario:
        'Die Kanzlei Berger & Thoms bekommt ein neues WLAN. Der Techniker beschreibt den Ablauf: „Zuerst messen wir die Räume aus (A). Danach können wir gleichzeitig die Access Points bestellen (B) und die Kabelwege planen (C). Die Kabel verlegen wir (D), sobald die Kabelwege geplant sind. Montieren (E) können wir erst, wenn die Access Points geliefert und die Kabel verlegt sind. Zum Schluss kommt die Abnahmemessung (F).“',
    prompt: 'Vervollständige die Vorgangsliste um die direkten Vorgänger.',
    zeilen: [
      ['Nr.', 'Vorgang', 'Vorgänger'],
      ['A', 'Räume ausmessen', '-'],
      [
        'B',
        'Access Points bestellen',
        wahl('A', ['keiner', 'C']),
      ],
      [
        'C',
        'Kabelwege planen',
        wahl('A', ['keiner', 'B']),
      ],
      [
        'D',
        'Kabel verlegen',
        wahl('C', ['A', 'B, C']),
      ],
      [
        'E',
        'Access Points montieren',
        wahl('B, D', [
          'B, C',
          'A, B, D',
          'D',
        ], 'Nur direkte Vorgänger: Lieferung (B) und verlegte Kabel (D).'),
      ],
      [
        'F',
        'Abnahmemessung',
        wahl('E', ['D, E', 'B, D, E']),
      ],
    ],
    explanation:
        'B und C folgen beide auf A (Verzweigung). D braucht nur die geplanten Kabelwege (C). E wartet auf B und D (Zusammenführung). In die Liste gehören nur direkte Vorgänger - A oder C bei E einzutragen wäre überflüssig.',
    punkte: 5,
  ),
  markieren(
    'i1-ng-2',
    'n-grundlagen',
    scenario:
        'Eine Auszubildende hat für den Umbau eines Besprechungsraums eine Vorgangsliste erstellt. Vor der Berechnung prüfst du die Liste.',
    table: [
      ['Nr.', 'Vorgang', 'Dauer', 'Vorgänger'],
      ['A', 'Bedarf klären', '2', '-'],
      ['B', 'Display bestellen', '5', 'A'],
      ['C', 'Wandhalterung montieren', '1', 'E'],
      ['D', 'Kabel verlegen', '2', 'A'],
      ['E', 'Display aufhängen', '1', 'B, C'],
      ['F', 'Konferenzsystem einrichten', '2', 'D, E, G'],
    ],
    prompt:
        'Markiere alle Aussagen, die einen Fehler der Liste zutreffend beschreiben.',
    zeilen: [
      ja(
        'C und E verweisen gegenseitig aufeinander - eine Schleife, die sich nicht berechnen lässt.',
        'C wartet auf E, E wartet auf C: Keiner von beiden könnte je beginnen.',
      ),
      nein(
        'A ist fehlerhaft, weil jeder Vorgang einen Vorgänger braucht.',
        'Jeder Netzplan braucht mindestens einen Startvorgang ohne Vorgänger.',
      ),
      ja(
        'F nennt den Vorgänger G, den es in der Liste nicht gibt.',
        'Ein Vorgänger muss als Vorgang in der Liste stehen.',
      ),
      nein(
        'B und D dürfen nicht denselben Vorgänger haben.',
        'Eine Verzweigung ist erlaubt: B und D können parallel laufen.',
      ),
      nein(
        'E ist fehlerhaft, weil ein Vorgang höchstens einen Vorgänger haben darf.',
        'Mehrere Vorgänger sind erlaubt (Zusammenführung).',
      ),
    ],
    explanation:
        'Ein Netzplan darf keine Schleifen enthalten, und jeder genannte Vorgänger muss existieren. Startvorgänge ohne Vorgänger, Verzweigungen und Zusammenführungen sind dagegen normal. Richtig wäre hier: C nach A, E nach B und C.',
    punkte: 2,
  ),
  freitext(
    'i1-ng-3',
    'n-grundlagen',
    scenario:
        'Für die Erneuerung der Kassen im Freizeitbad Aquamar soll der Zeitplan dargestellt werden. Zur Wahl stehen ein Gantt-Diagramm und ein Netzplan.',
    prompt: 'Nenne je zwei Merkmale des Gantt-Diagramms und des Netzplans.',
    kriterien: [
      krit(
        'Gantt-Diagramm: Vorgänge als Balken über einer Zeitachse',
        stichwoerter: ['Balken', 'Zeitachse', 'Balkendiagramm', 'Balkenplan'],
      ),
      krit(
        'Gantt-Diagramm: Beginn, Ende und Dauer direkt ablesbar, leicht verständlich',
        stichwoerter: [
          'ablesbar',
          'anschaulich',
          'übersichtlich',
          'leicht verständlich',
          'Beginn und Ende',
        ],
      ),
      krit(
        'Gantt-Diagramm: parallele Vorgänge und Meilensteine sichtbar',
        stichwoerter: ['Meilenstein', 'parallel', 'gleichzeitig'],
      ),
      krit(
        'Netzplan: zeigt die Abhängigkeiten zwischen den Vorgängen (Vorgänger, Nachfolger)',
        stichwoerter: [
          'Abhängigkeiten',
          'Vorgänger',
          'Nachfolger',
          'Reihenfolge',
        ],
      ),
      krit(
        'Netzplan: früheste und späteste Anfangs- und Endzeitpunkte',
        stichwoerter: ['früheste', 'späteste', 'FAZ', 'SEZ', 'Zeitpunkte'],
      ),
      krit(
        'Netzplan: Pufferzeiten und kritischer Pfad',
        stichwoerter: [
          'Puffer',
          'kritischer Pfad',
          'kritischen Pfad',
          'kritisch',
        ],
      ),
    ],
    loesung:
        'Gantt-Diagramm: Die Vorgänge stehen als Balken über einer Zeitachse; Beginn, Ende und Dauer sind direkt ablesbar, das Diagramm ist leicht verständlich. Netzplan: Er zeigt die Abhängigkeiten zwischen den Vorgängen, die frühesten und spätesten Zeitpunkte sowie Puffer und kritischen Pfad.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte (je zwei pro Darstellung). Das Gantt-Diagramm ist das anschauliche Bild, der Netzplan das Rechenmodell.',
    punkte: 4,
  ),

  // ============================================================ Vorwärtsrechnung
  tabelle(
    'i1-nv-1',
    'n-vorwaerts',
    scenario:
        'Die Druckerei Farbwerk zieht ihren Serverraum in ein neues Gebäude um (Dauer in Arbeitstagen, Start bei 0).',
    prompt: 'Führe die Vorwärtsrechnung durch und trage FAZ und FEZ ein.',
    zeilen: [
      ['Vorgang', 'Dauer', 'Vorg.', 'FAZ', 'FEZ'],
      ['A Bestandsaufnahme', '2', '-', '0', '2'],
      ['B Rack bestellen', '5', 'A', zahl(2), zahl(7)],
      ['C Kabelwege planen', '3', 'A', zahl(2), zahl(5)],
      ['D Rack montieren', '2', 'B', zahl(7), zahl(9)],
      ['E Kabel verlegen', '3', 'C', zahl(5), zahl(8)],
      [
        'F Server einbauen',
        '3',
        'D, E',
        zahl(9, rationale: 'max(FEZ D 9; FEZ E 8) = 9'),
        zahl(12),
      ],
      ['G Test und Abnahme', '2', 'F', zahl(12), zahl(14)],
    ],
    explanation:
        'FAZ = größter FEZ der Vorgänger, FEZ = FAZ + Dauer.\n'
        'A 0/2, B 2/7, C 2/5, D 7/9, E 5/8.\n'
        'F hat zwei Vorgänger: FAZ = max(FEZ D 9; FEZ E 8) = 9, FEZ = 12.\n'
        'G 12/14 - die Projektdauer beträgt 14 Arbeitstage.',
    punkte: 6,
  ),
  netzplanAufgabe(
    'i1-nv-2',
    'n-vorwaerts',
    scenario:
        'Die Hausarztpraxis Dr. Albrecht stellt auf eine neue Praxissoftware um. Dauer in Arbeitstagen, Start bei 0.',
    prompt:
        'Führe die Vorwärtsrechnung durch: Trage FAZ und FEZ für jeden Vorgang ein.',
    vorgaenge: _praxis,
    gefragt: const [NodeField.faz, NodeField.fez],
    explanation:
        'FAZ = größter FEZ der Vorgänger (Start: 0), FEZ = FAZ + Dauer.\n'
        'A: 0 / 2\n'
        'B: 2 / 2 + 4 = 6\n'
        'C: 2 / 2 + 5 = 7\n'
        'D: 6 / 6 + 2 = 8\n'
        'E: max(FEZ C 7; FEZ D 8) = 8 / 8 + 3 = 11\n'
        'F: 11 / 11 + 1 = 12\n'
        'Projektdauer: 12 Arbeitstage.',
    punkte: 6,
    difficulty: 2,
  ),
  markieren(
    'i1-nv-3',
    'n-vorwaerts',
    scenario:
        'Für die Ausstattung eines Videokonferenzraums beim Ingenieurbüro Stahl hat ein Kollege die Vorwärtsrechnung durchgeführt (Dauer in Tagen, Start bei 0). Drei Vorgänge enthalten falsche Werte.',
    table: [
      ['Nr.', 'Vorgang', 'Dauer', 'Vorgänger'],
      ['A', 'Raum vermessen', '3', '-'],
      ['B', 'Möbel bestellen', '2', 'A'],
      ['C', 'Technik liefern lassen', '5', 'A'],
      ['D', 'Möbel aufbauen', '4', 'B'],
      ['E', 'Verkabelung vorbereiten', '2', 'B, C'],
      ['F', 'Technik montieren', '3', 'D, E'],
      ['G', 'Einweisung', '1', 'F'],
    ],
    prompt:
        'Rechne nach und markiere die Vorgänge mit fehlerhaftem FAZ oder FEZ.',
    mono: true,
    zeilen: [
      nein('A  FAZ 0   FEZ 3', 'Startvorgang: 0 + 3 = 3 - richtig.'),
      nein('B  FAZ 3   FEZ 5', 'FAZ = FEZ von A = 3, FEZ = 3 + 2 = 5.'),
      nein('C  FAZ 3   FEZ 8', 'FAZ = FEZ von A = 3, FEZ = 3 + 5 = 8.'),
      ja(
        'D  FAZ 3   FEZ 7',
        'D folgt auf B, nicht auf A: FAZ = FEZ von B = 5, FEZ = 5 + 4 = 9.',
      ),
      ja(
        'E  FAZ 5   FEZ 7',
        'Bei zwei Vorgängern zählt der größere FEZ: max(5; 8) = 8, FEZ = 8 + 2 = 10.',
      ),
      nein(
        'F  FAZ 10  FEZ 13',
        'max(FEZ D 9; FEZ E 10) = 10, FEZ = 10 + 3 = 13 - richtig.',
      ),
      ja('G  FAZ 13  FEZ 13', 'Die Dauer fehlt: FEZ = 13 + 1 = 14.'),
    ],
    explanation:
        'Richtig ist: A 0/3, B 3/5, C 3/8, D 5/9, E 8/10, F 10/13, G 13/14. Typische Fehler: falscher Vorgänger (D), kleinster statt größter FEZ bei mehreren Vorgängern (E), Dauer nicht addiert (G).',
    punkte: 3,
    difficulty: 3,
  ),
  rechnen(
    'i1-nv-4',
    'n-vorwaerts',
    scenario:
        'Die Stadtbücherei Lindau bekommt ein neues Kassensystem (Dauer in Arbeitstagen, Start bei 0):\n'
        'A Bestellung auslösen: 2, Startvorgang\n'
        'B Kasse montieren: 3, nach A - zwischen A und B liegen 6 Tage Lieferzeit\n'
        'C Artikeldaten aufbereiten: 5, nach A (ohne Wartezeit)\n'
        'D Inbetriebnahme: 2, nach B und C',
    prompt: 'Berechne das früheste Ende (FEZ) der Inbetriebnahme.',
    answer: 13,
    unit: 'Tage',
    explanation:
        'A: FAZ 0, FEZ 2.\n'
        'B: FAZ = FEZ A + Lieferzeit = 2 + 6 = 8, FEZ = 8 + 3 = 11.\n'
        'C: FAZ 2, FEZ 2 + 5 = 7.\n'
        'D: FAZ = max(FEZ B 11; FEZ C 7) = 11, FEZ = 11 + 2 = 13.',
    punkte: 3,
    difficulty: 3,
  ),

  // =========================================================== Rückwärtsrechnung
  tabelle(
    'i1-nr-1',
    'n-rueckwaerts',
    scenario:
        'Der Pflegedienst Sonnenhof führt eine mobile Zeiterfassung ein. Die Vorwärtsrechnung ist erledigt, die Projektdauer beträgt 13 Arbeitstage.',
    prompt: 'Führe die Rückwärtsrechnung durch und trage SAZ und SEZ ein.',
    zeilen: [
      ['Vorgang', 'Dauer', 'Nachf.', 'SAZ', 'SEZ'],
      [
        'A Anforderungen klären',
        '2',
        'B, C',
        zahl(0),
        zahl(2, rationale: 'min(SAZ B 2; SAZ C 4) = 2'),
      ],
      ['B Software anpassen', '5', 'D', zahl(2), zahl(7)],
      ['C Smartphones beschaffen', '3', 'E', zahl(4), zahl(7)],
      ['D Testbetrieb', '4', 'F', zahl(7), zahl(11)],
      ['E Smartphones einrichten', '4', 'F', zahl(7), zahl(11)],
      ['F Schulung', '2', '-', zahl(11), zahl(13)],
    ],
    explanation:
        'SEZ des Endvorgangs = Projektdauer, sonst SEZ = kleinster SAZ der Nachfolger; SAZ = SEZ - Dauer.\n'
        'F: 13 / 13 - 2 = 11\n'
        'D: SEZ 11, SAZ 7 · E: SEZ 11, SAZ 7\n'
        'B: SEZ = SAZ D = 7, SAZ 2 · C: SEZ = SAZ E = 7, SAZ 4\n'
        'A: SEZ = min(SAZ B 2; SAZ C 4) = 2, SAZ 0 - die Probe stimmt.',
    punkte: 6,
  ),
  netzplanAufgabe(
    'i1-nr-2',
    'n-rueckwaerts',
    scenario:
        'Die Steuerberatung Kranich tauscht ihre Drucker aus. Dauer in Arbeitstagen; die Vorwärtsrechnung ergibt eine Projektdauer von 14 Tagen.',
    prompt:
        'Führe die Rückwärtsrechnung durch: Trage SAZ und SEZ für jeden Vorgang ein.',
    vorgaenge: _drucker,
    gefragt: const [NodeField.saz, NodeField.sez],
    explanation:
        'SEZ Endvorgang = Projektdauer, sonst SEZ = kleinster SAZ der Nachfolger; SAZ = SEZ - Dauer.\n'
        'F: 14 / 14 - 2 = 12\n'
        'D: SEZ = SAZ F = 12, SAZ 12 - 5 = 7\n'
        'E: SEZ = SAZ F = 12, SAZ 12 - 3 = 9\n'
        'B: SEZ = SAZ D = 7, SAZ 7 - 4 = 3\n'
        'C: SEZ = SAZ E = 9, SAZ 9 - 2 = 7\n'
        'A: SEZ = min(SAZ B 3; SAZ C 7) = 3, SAZ 3 - 3 = 0 - die Probe stimmt.',
    punkte: 6,
    difficulty: 2,
  ),
  markieren(
    'i1-nr-3',
    'n-rueckwaerts',
    scenario:
        'Die Buchhandlung Seitenweise stellt auf ein neues Kassensystem um (Dauer in Tagen). Die Vorwärtsrechnung stimmt, die Projektdauer beträgt 15 Tage. In der Rückwärtsrechnung einer Kollegin stecken Fehler in drei Vorgängen.',
    table: [
      ['Nr.', 'Dauer', 'Vorgänger', 'FAZ', 'FEZ'],
      ['A', '4', '-', '0', '4'],
      ['B', '3', 'A', '4', '7'],
      ['C', '6', 'A', '4', '10'],
      ['D', '4', 'B', '7', '11'],
      ['E', '2', 'C', '10', '12'],
      ['F', '3', 'D, E', '12', '15'],
    ],
    prompt:
        'Rechne nach und markiere die Vorgänge mit fehlerhaftem SAZ oder SEZ.',
    mono: true,
    zeilen: [
      nein(
        'F  SAZ 12  SEZ 15',
        'Endvorgang: SEZ = Projektdauer 15, SAZ = 15 - 3 = 12.',
      ),
      nein('E  SAZ 10  SEZ 12', 'SEZ = SAZ von F = 12, SAZ = 12 - 2 = 10.'),
      ja(
        'D  SAZ 7   SEZ 11',
        'Hier wurden FAZ und FEZ abgeschrieben. Richtig: SEZ = SAZ von F = 12, SAZ = 12 - 4 = 8.',
      ),
      nein('C  SAZ 4   SEZ 10', 'SEZ = SAZ von E = 10, SAZ = 10 - 6 = 4.'),
      ja(
        'B  SAZ 6   SEZ 8',
        'SEZ = SAZ von D = 8 stimmt, aber SAZ = 8 - 3 = 5.',
      ),
      ja(
        'A  SAZ 1   SEZ 5',
        'Bei zwei Nachfolgern zählt der kleinere SAZ: min(SAZ B 5; SAZ C 4) = 4, SAZ = 4 - 4 = 0.',
      ),
    ],
    explanation:
        'Richtig ist (SAZ/SEZ): F 12/15, E 10/12, D 8/12, C 4/10, B 5/8, A 0/4. Typische Fehler: Werte der Vorwärtsrechnung übernommen (D), falsch subtrahiert (B), größter statt kleinster SAZ der Nachfolger (A).',
    punkte: 3,
    difficulty: 3,
  ),
  lueckentext(
    'i1-nr-4',
    'n-rueckwaerts',
    scenario:
        'Kassensystem der Buchhandlung Seitenweise (Dauer in Tagen, Projektdauer 15). Die Vorwärtsrechnung stimmt; in der Rückwärtsrechnung sind die Vorgänge D, B und A fehlerhaft.',
    code:
        'Vg  D  Vorg.  FAZ FEZ | SAZ SEZ\n'
        'A   4  -        0   4 |   1   5\n'
        'B   3  A        4   7 |   6   8\n'
        'C   6  A        4  10 |   4  10\n'
        'D   4  B        7  11 |   7  11\n'
        'E   2  C       10  12 |  10  12\n'
        'F   3  D, E    12  15 |  12  15',
    prompt: 'Trage die richtigen Werte ein.',
    text:
        'Vorgang D: SEZ = {0}, SAZ = {1}\n'
        'Vorgang B: SAZ = {2}\n'
        'Vorgang A: SEZ = {3}, SAZ = {4}',
    luecken: [
      zahl(12, rationale: 'SEZ D = SAZ des Nachfolgers F = 12'),
      zahl(8, rationale: '12 - 4 = 8'),
      zahl(5, rationale: 'SEZ B = SAZ D = 8; 8 - 3 = 5'),
      zahl(4, rationale: 'min(SAZ B 5; SAZ C 4) = 4'),
      zahl(0, rationale: '4 - 4 = 0'),
    ],
    explanation:
        'Rückwärts von hinten: F 12/15. D: SEZ = SAZ F = 12, SAZ = 12 - 4 = 8. B: SEZ = SAZ D = 8, SAZ = 8 - 3 = 5. A: SEZ = min(SAZ B 5; SAZ C 4) = 4, SAZ = 4 - 4 = 0. Probe: Der Startvorgang auf dem kritischen Pfad hat SAZ = FAZ = 0.',
    punkte: 5,
    difficulty: 3,
  ),

  // ============================================= Gesamtpuffer und freier Puffer
  tabelle(
    'i1-np-1',
    'n-puffer',
    scenario:
        'Die Gesamtschule Elbufer erneuert ihr Schulnetz (Dauer in Arbeitstagen). Vorwärts- und Rückwärtsrechnung liegen vor.',
    table: [
      ['Nr.', 'Vorg.', 'FAZ', 'FEZ', 'SAZ', 'SEZ'],
      ['A', '-', '0', '2', '0', '2'],
      ['B', 'A', '2', '8', '2', '8'],
      ['C', 'A', '2', '5', '3', '6'],
      ['D', 'C', '5', '7', '6', '8'],
      ['E', 'B, D', '8', '12', '8', '12'],
      ['F', 'C', '5', '8', '9', '12'],
      ['G', 'E, F', '12', '14', '12', '14'],
    ],
    prompt:
        'Berechne für jeden Vorgang den Gesamtpuffer (GP = SAZ - FAZ) und den freien Puffer (FP = kleinster FAZ der Nachfolger - FEZ).',
    zeilen: [
      ['Vorgang', 'GP', 'FP'],
      ['A', '0', '0'],
      ['B', zahl(0), zahl(0)],
      [
        'C',
        zahl(1),
        zahl(0, rationale: 'Nachfolger D und F: min(FAZ 5; FAZ 5) - FEZ 5 = 0'),
      ],
      ['D', zahl(1), zahl(1, rationale: 'FAZ E 8 - FEZ D 7 = 1')],
      ['E', zahl(0), zahl(0)],
      ['F', zahl(4), zahl(4, rationale: 'FAZ G 12 - FEZ F 8 = 4')],
      ['G', zahl(0), zahl(0)],
    ],
    explanation:
        'GP = SAZ - FAZ: B 0, C 3 - 2 = 1, D 6 - 5 = 1, E 0, F 9 - 5 = 4, G 0.\n'
        'FP = kleinster FAZ der Nachfolger - FEZ: C: 5 - 5 = 0, D: 8 - 7 = 1, F: 12 - 8 = 4, alle anderen 0.\n'
        'C hat Gesamtpuffer, aber keinen freien Puffer: Jede Verzögerung von C schiebt D und F nach hinten.',
    punkte: 6,
  ),
  lueckentext(
    'i1-np-2',
    'n-puffer',
    scenario:
        'Im Netzplan für die Einführung eines Ticketsystems bei der Wohnbau Rhein-Main hat der Vorgang „Schulungsunterlagen erstellen“ einen Gesamtpuffer von 5 Tagen und einen freien Puffer von 2 Tagen.',
    prompt: 'Ergänze die Folgen der Verzögerungen (jeweils in Tagen).',
    text:
        'Verzögert sich der Vorgang um 2 Tage, beginnt sein Nachfolger frühestens {0} Tage später. Bei 4 Tagen Verzögerung beginnt der Nachfolger frühestens {1} Tage später, und das Projektende verschiebt sich um {2} Tage. Bei 7 Tagen Verzögerung verschiebt sich das Projektende um {3} Tage.',
    luecken: [
      zahl(0, rationale: '2 Tage ≤ FP 2: Der Nachfolger merkt nichts.'),
      zahl(2, rationale: '4 - FP 2 = 2'),
      zahl(0, rationale: '4 Tage ≤ GP 5: Das Projektende bleibt.'),
      zahl(2, rationale: '7 - GP 5 = 2'),
    ],
    explanation:
        'Bis zum freien Puffer (2 Tage) bleibt alles unverändert. Darüber startet der Nachfolger später: 4 - 2 = 2 Tage. Das Projektende verschiebt sich erst, wenn der Gesamtpuffer überschritten wird: 7 - 5 = 2 Tage.',
    punkte: 4,
  ),
  freitext(
    'i1-np-3',
    'n-puffer',
    scenario:
        'Im Statusmeeting der Wohnbau Rhein-Main fragt der Auftraggeber: „Im Netzplan stehen je Vorgang zwei Puffer. Wozu braucht man beide?“',
    prompt:
        'Erläutere den Unterschied zwischen Gesamtpuffer und freiem Puffer.',
    kriterien: [
      krit(
        'Gesamtpuffer: Zeit, um die sich ein Vorgang verschieben darf, ohne das Projektende zu gefährden (GP = SAZ - FAZ).',
        punkte: 2,
        stichwoerter: [
          'Projektende',
          'Endtermin',
          'Projektdauer',
          'Gesamtdauer',
          'SAZ - FAZ',
        ],
      ),
      krit(
        'Freier Puffer: Zeit, um die sich ein Vorgang verschieben darf, ohne den frühesten Anfang eines Nachfolgers zu verschieben (FP = FAZ Nachfolger - FEZ).',
        punkte: 2,
        stichwoerter: [
          'Nachfolger',
          'nachfolgenden',
          'Folgevorgang',
          'nächsten Vorgang',
        ],
      ),
    ],
    loesung:
        'Der Gesamtpuffer gibt an, um wie viel sich ein Vorgang verschieben darf, ohne dass sich das Projektende verschiebt (GP = SAZ - FAZ). Der freie Puffer gibt an, um wie viel er sich verschieben darf, ohne dass ein Nachfolger später als zu seinem frühesten Anfang beginnt (FP = FAZ des Nachfolgers - FEZ). Der freie Puffer ist nie größer als der Gesamtpuffer.',
    explanation:
        'Je Puffer 2 Punkte: Der Gesamtpuffer schützt das Projektende, der freie Puffer schützt die Nachfolger. Wer nur den freien Puffer verbraucht, stört niemanden.',
    punkte: 4,
  ),

  // ============================================================= Kritischer Pfad
  markieren(
    'i1-nk-1',
    'n-kritisch',
    scenario:
        'Die Messebau Kranz GmbH plant den IT-Aufbau für einen Messestand (Dauer in Stunden). Der Netzplan ist berechnet.',
    table: [
      ['Nr.', 'Dauer', 'FAZ', 'FEZ', 'SAZ', 'SEZ'],
      ['A', '2', '0', '2', '0', '2'],
      ['B', '4', '2', '6', '3', '7'],
      ['C', '6', '2', '8', '2', '8'],
      ['D', '3', '6', '9', '7', '10'],
      ['E', '2', '8', '10', '8', '10'],
      ['F', '5', '8', '13', '9', '14'],
      ['G', '4', '10', '14', '10', '14'],
      ['H', '1', '14', '15', '14', '15'],
    ],
    prompt: 'Markiere alle Vorgänge, die auf dem kritischen Pfad liegen.',
    zeilen: [
      ja('Vorgang A', 'GP = SAZ - FAZ = 0 - 0 = 0 → kritisch.'),
      nein('Vorgang B', 'GP = 3 - 2 = 1 → eine Stunde Puffer.'),
      ja('Vorgang C', 'GP = 2 - 2 = 0 → kritisch.'),
      nein('Vorgang D', 'GP = 7 - 6 = 1.'),
      ja('Vorgang E', 'GP = 8 - 8 = 0 → kritisch.'),
      nein('Vorgang F', 'GP = 9 - 8 = 1.'),
      ja('Vorgang G', 'GP = 10 - 10 = 0 → kritisch.'),
      ja('Vorgang H', 'GP = 14 - 14 = 0 → kritisch.'),
    ],
    explanation:
        'Kritisch sind alle Vorgänge mit Gesamtpuffer 0, also mit SAZ = FAZ. Der kritische Pfad lautet A - C - E - G - H mit 2 + 6 + 2 + 4 + 1 = 15 Stunden. B, D und F haben je 1 Stunde Puffer.',
    punkte: 3,
  ),
  rechnen(
    'i1-nk-2',
    'n-kritisch',
    scenario:
        'Für den Rollout neuer Kassen in den Filialen der Modekette Lunara schickt der britische Dienstleister einen Statusbericht:',
    code:
        'Status report - week 14\n'
        '\n'
        'Task C (install cabling) is on the critical\n'
        'path. It will be finished 2 working days late\n'
        'because the cable trays were delivered late.\n'
        '\n'
        'Task E (configure printers) has a total float\n'
        'of 4 days. It will be finished 3 working days\n'
        'late.\n'
        '\n'
        'All other tasks are on schedule.',
    prompt:
        'Berechne, um wie viele Arbeitstage sich das Projektende verschiebt, wenn nicht gegengesteuert wird.',
    answer: 2,
    unit: 'Tage',
    explanation:
        'Vorgang C liegt auf dem kritischen Pfad (Gesamtpuffer 0): Seine 2 Tage Verspätung verschieben das Projektende um 2 Tage.\n'
        'Vorgang E hat 4 Tage Gesamtpuffer (total float); 3 Tage Verspätung liegen darunter und ändern am Projektende nichts.\n'
        'Verschiebung insgesamt: 2 Arbeitstage.',
    punkte: 3,
  ),
  freitext(
    'i1-nk-3',
    'n-kritisch',
    scenario:
        'Der Netzplan für den Kassen-Rollout bei Lunara zeigt den kritischen Pfad A - C - F - G.',
    prompt:
        'Erläutere, was der kritische Pfad ist und welche Folge eine Verzögerung auf ihm hat.',
    kriterien: [
      krit(
        'Der kritische Pfad ist der längste Weg durch den Netzplan; er bestimmt die Projektdauer.',
        punkte: 2,
        stichwoerter: [
          'längste',
          'längster',
          'Projektdauer',
          'bestimmt die Dauer',
          'Mindestdauer',
        ],
      ),
      krit(
        'Alle Vorgänge auf ihm haben einen Gesamtpuffer von 0.',
        stichwoerter: [
          'Puffer',
          'Gesamtpuffer',
          'kein Puffer',
          'ohne Puffer',
          'GP = 0',
        ],
      ),
      krit(
        'Jede Verzögerung eines kritischen Vorgangs verschiebt das Projektende um dieselbe Zeit.',
        punkte: 2,
        stichwoerter: [
          'Projektende',
          'Endtermin',
          'verschiebt',
          'verzögert das Projekt',
          'gesamte Projekt',
        ],
      ),
    ],
    loesung:
        'Der kritische Pfad ist der längste Weg vom Start- zum Endvorgang und bestimmt damit die Projektdauer. Alle Vorgänge auf ihm haben keinen Puffer (Gesamtpuffer 0). Verzögert sich einer dieser Vorgänge, verschiebt sich das Projektende um genau diese Zeit.',
    explanation:
        'Höchstens 4 Punkte: Definition (längster Weg, bestimmt die Projektdauer), Erkennungsmerkmal (GP = 0) und Folge einer Verzögerung. Ein Netzplan kann auch mehrere kritische Pfade haben.',
    punkte: 4,
  ),
  lueckentext(
    'i1-nk-4',
    'n-kritisch',
    scenario: 'Website-Relaunch der Brauerei Hopfenhof (Dauer in Tagen):',
    table: [
      ['Nr.', 'Vorgang', 'Dauer', 'Vorgänger'],
      ['A', 'Konzept', '4', '-'],
      ['B', 'Design', '7', 'A'],
      ['C', 'Inhalte schreiben', '5', 'A'],
      ['D', 'Programmierung', '3', 'B'],
      ['E', 'Inhalte einpflegen', '4', 'C'],
      ['F', 'Freigabe', '2', 'D, E'],
    ],
    prompt: 'Werte den Netzplan aus.',
    text:
        'Der Weg A - B - D - F dauert {0} Tage, der Weg A - C - E - F dauert {1} Tage. Die Projektdauer beträgt also {2} Tage. Wird B durch eine zweite Designerin von 7 auf 4 Tage verkürzt, dauert das Projekt noch {3} Tage. Kritisch ist dann {4}.',
    luecken: [
      zahl(16, rationale: '4 + 7 + 3 + 2 = 16'),
      zahl(15, rationale: '4 + 5 + 4 + 2 = 15'),
      zahl(16, rationale: 'Der längste Weg bestimmt die Dauer.'),
      zahl(
        15,
        rationale: 'A - B - D - F dauert nur noch 13, A - C - E - F 15.',
      ),
      wahl('der Weg A - C - E - F', [
        'der Weg A - B - D - F',
        'jeder der beiden Wege',
      ]),
    ],
    explanation:
        'Vorher: A - B - D - F = 4 + 7 + 3 + 2 = 16 (kritisch), A - C - E - F = 4 + 5 + 4 + 2 = 15.\n'
        'Nachher: A - B - D - F = 4 + 4 + 3 + 2 = 13, A - C - E - F = 15.\n'
        'Der kritische Pfad wandert: Von 3 Tagen Verkürzung bleibt nur 1 Tag Gewinn. Nach jeder Verkürzung neu rechnen.',
    punkte: 5,
    difficulty: 3,
  ),
  netzplanAufgabe(
    'i1-nk-5',
    'n-kritisch',
    scenario:
        'Das Architekturbüro Linde führt ein Dokumentenmanagementsystem ein. Dauer in Arbeitstagen, Start bei 0. Es gilt: GP = SAZ - FAZ, FP = kleinster FAZ der Nachfolger - FEZ.',
    prompt:
        'Berechne den Netzplan vollständig und bestimme so den kritischen Pfad.',
    vorgaenge: _dms,
    gefragt: const [
      NodeField.faz,
      NodeField.fez,
      NodeField.saz,
      NodeField.sez,
      NodeField.gp,
      NodeField.fp,
    ],
    explanation:
        'Vorwärts (FAZ/FEZ): A 0/3, B 3/5, C 3/8, D max(5; 8) = 8/10, E 3/7, F max(10; 7) = 10/13, G 13/15.\n'
        'Rückwärts (SAZ/SEZ): G 13/15, F 10/13, D 8/10, E 6/10, C 3/8, B 6/8, A min(6; 3; 6) = 3 → 0/3.\n'
        'GP: B 3, E 3, alle anderen 0. FP: B 8 - 5 = 3, E 10 - 7 = 3.\n'
        'Kritischer Pfad: A - C - D - F - G mit 3 + 5 + 2 + 3 + 2 = 15 Arbeitstagen.',
    punkte: 9,
  ),
];
