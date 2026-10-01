import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben im IHK-Stil zu Bereich 03: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA03 = [
  // ======================================================= Komponenten eines PCs
  tabelle(
    'i3-hk-1',
    'h-komponenten',
    scenario:
        'Für den Empfang soll ein kompakter PC beschafft werden. Der Händler schickt das englische Datenblatt.',
    code:
        'Mini PC "NB-510" - Technical Specifications\n'
        'Processor: 6 cores / 12 threads\n'
        'Memory:    16 GB DDR5 (max. 64 GB)\n'
        'Storage:   512 GB NVMe SSD (M.2)\n'
        'Graphics:  integrated\n'
        'Video out: 2x DisplayPort\n'
        'Power:     external adapter, 20 V / 6 A',
    prompt:
        'Ergänze die Tabelle mit den Angaben aus dem Datenblatt. Für die Leistung gilt P = U × I.',
    zeilen: [
      ['Merkmal', 'Wert'],
      ['Threads des Prozessors', zahl(12)],
      ['Höchstausbau Arbeitsspeicher in GB', zahl(64)],
      ['Anzahl der DisplayPort-Ausgänge', zahl(2)],
      [
        'Grafik',
        wahl('im Prozessor integriert', [
          'eigene Grafikkarte',
          'externe Grafikbox',
        ]),
      ],
      ['Leistung des Netzteils in W', zahl(120)],
    ],
    punkte: 5,
    explanation:
        '12 threads = 12 Threads, max. 64 GB = Höchstausbau, 2x DisplayPort = zwei Ausgänge, „integrated“ = Grafik im Prozessor. Netzteil: P = U × I = 20 V × 6 A = 120 W. Je richtiger Zelle 1 Punkt.',
    tags: ['englisch', 'datenblatt'],
  ),
  freitext(
    'i3-hk-2',
    'h-komponenten',
    scenario:
        'Ein Büro-PC mit 8 GB RAM und Festplatte (HDD) wird sehr träge, sobald mehrere Programme offen sind. Der Task-Manager zeigt: Arbeitsspeicher 96 %, Prozessor 20 %, Datenträger 100 %.',
    prompt:
        'Erläutere die Ursache der Trägheit und beschreibe eine geeignete Aufrüstung.',
    kriterien: [
      krit(
        'Ursache: Der Arbeitsspeicher ist voll, das System lagert auf den langsamen Datenträger aus',
        punkte: 2,
        stichwoerter: [
          'auslagern',
          'Auslagerung',
          'RAM voll',
          'Arbeitsspeicher voll',
          'Auslagerungsdatei',
          'swap',
        ],
      ),
      krit(
        'Aufrüstung: mehr Arbeitsspeicher einbauen, damit nicht mehr ausgelagert wird',
        punkte: 2,
        stichwoerter: [
          'mehr RAM',
          'mehr Arbeitsspeicher',
          'RAM erweitern',
          'Arbeitsspeicher aufrüsten',
          '16 GB',
        ],
      ),
      krit(
        'Alternativ oder zusätzlich: HDD durch SSD ersetzen, damit Zugriffe schneller werden',
        punkte: 2,
        stichwoerter: ['SSD', 'NVMe', 'Festplatte ersetzen', 'HDD tauschen'],
      ),
    ],
    punkte: 4,
    loesung:
        'Der Arbeitsspeicher ist nahezu voll. Das Betriebssystem lagert deshalb Speicherseiten auf die Festplatte aus - daher die dauerhafte Datenträgerlast, während der Prozessor kaum arbeitet. Abhilfe: den Arbeitsspeicher erweitern, z. B. auf 16 GB. Zusätzlich hilft eine SSD statt der HDD.',
    explanation:
        'Bewertung: 2 Punkte für die Ursache (voller RAM, Auslagerung), 2 Punkte für eine passende Aufrüstung - höchstens 4 Punkte. Eine schnellere CPU hilft nicht, sie ist nur zu 20 % ausgelastet.',
  ),
  markieren(
    'i3-hk-3',
    'h-komponenten',
    scenario:
        'Für die Buchhaltung soll ein leiser, sparsamer Büro-PC mit zwei Monitoren zusammengestellt werden. Ein Kollege hat eine Stückliste entworfen.',
    prompt:
        'Markiere alle Positionen, die für diesen PC ungeeignet sind oder nicht zusammenpassen.',
    zeilen: [
      nein(
        'Prozessor mit 6 Kernen und integrierter Grafik',
        'Für Büroarbeit mit zwei Monitoren völlig ausreichend.',
      ),
      nein(
        'Mainboard mit DDR5-Steckplätzen und 2 × DisplayPort',
        'Passt zum Prozessor und bedient beide Monitore.',
      ),
      ja(
        '16 GB DDR4-Arbeitsspeicher',
        'DDR4-Module passen mechanisch und elektrisch nicht in DDR5-Steckplätze.',
      ),
      ja(
        'Gaming-Grafikkarte mit 300 W Leistungsaufnahme',
        'Für Buchhaltung überdimensioniert: teuer, laut und stromhungrig - die integrierte Grafik reicht.',
      ),
      nein(
        'NVMe-SSD mit 500 GB',
        'Schnell, leise und groß genug für einen Büro-PC.',
      ),
      nein(
        'Netzteil 300 W mit 80-PLUS-Gold-Siegel',
        'Reicht für einen Büro-PC ohne Grafikkarte und arbeitet effizient.',
      ),
    ],
    explanation:
        'Zwei Positionen fallen heraus: DDR4-RAM passt nicht auf ein DDR5-Mainboard, und die Gaming-Grafikkarte widerspricht den Zielen leise und sparsam - außerdem würde sie das 300-W-Netzteil überfordern.',
  ),
  paare(
    'i3-hk-4',
    'h-komponenten',
    scenario:
        'Für die Einweisung neuer Auszubildender wird ein Schaubild zum Aufbau eines PCs beschriftet.',
    prompt: 'Ordne jeder Komponente ihre Aufgabe zu.',
    paare: [
      paar('Prozessor (CPU)', 'führt die Befehle der Programme aus'),
      paar('Arbeitsspeicher (RAM)', 'hält laufende Programme, flüchtig'),
      paar('Mainboard', 'verbindet alle Komponenten'),
      paar('Netzteil', 'wandelt 230 V in Gleichspannungen'),
      paar('UEFI', 'prüft Hardware, startet Bootloader'),
    ],
    explanation:
        'CPU rechnet, RAM hält die Daten laufender Programme, das Mainboard verbindet alles, das Netzteil liefert die Gleichspannungen, das UEFI startet den Rechner.',
    difficulty: 1,
  ),

  // ======================================================= Speicher: HDD und SSD
  lueckentext(
    'i3-hs-1',
    'h-speicher',
    scenario:
        'In der Poststelle werden an 220 Arbeitstagen im Jahr täglich 400 Dokumente gescannt. Ein Scan belegt im Mittel 250 KiB.',
    prompt:
        'Ermittle den Speicherbedarf Schritt für Schritt. Runde den Jahreswert auf zwei Nachkommastellen.',
    text:
        'Bedarf pro Tag: {0} KiB\n'
        'Bedarf pro Jahr: {1} KiB\n'
        'Bedarf pro Jahr: {2} GiB',
    luecken: [
      zahl(100000, rationale: '400 × 250 KiB'),
      zahl(22000000, rationale: '100.000 KiB × 220 Tage'),
      zahl(20.98, toleranz: 0.01, rationale: '22.000.000 / 1.024 / 1.024'),
    ],
    punkte: 3,
    explanation:
        'Pro Tag: 400 × 250 KiB = 100.000 KiB. Pro Jahr: 100.000 × 220 = 22.000.000 KiB. In GiB: 22.000.000 / 1.024 / 1.024 ≈ 20,98 GiB. Von KiB nach GiB wird zweimal durch 1.024 geteilt.',
  ),
  rechnen(
    'i3-hs-2',
    'h-speicher',
    scenario:
        'Eine Kamera am Wareneingang liefert Bilder mit 1920 × 1080 Pixeln, 24 Bit Farbtiefe und 15 Bildern pro Sekunde. Der Videostrom wird auf 1 % der ursprünglichen Datenmenge komprimiert.',
    prompt:
        'Berechne die Datenrate des komprimierten Videostroms in Mbit/s (1 Mbit = 1.000.000 Bit). Runde auf zwei Nachkommastellen.',
    answer: 7.46,
    tolerance: 0.01,
    unit: 'Mbit/s',
    punkte: 4,
    explanation:
        'Unkomprimiert: 1920 × 1080 × 24 Bit × 15 = 746.496.000 Bit/s = 746,496 Mbit/s. Komprimiert auf 1 %: 746,496 × 0,01 ≈ 7,46 Mbit/s. „Auf 1 %“ heißt Faktor 0,01.',
    difficulty: 3,
  ),
  rechnen(
    'i3-hs-3',
    'h-speicher',
    scenario:
        'Vier Kameras senden je 7,5 Mbit/s. Die Aufnahmen der letzten 72 Stunden sollen gespeichert bleiben.',
    prompt: 'Berechne den Speicherbedarf in GB (1 GB = 1.000 MB = 10⁹ Byte).',
    answer: 972,
    unit: 'GB',
    punkte: 4,
    explanation:
        'Alle Kameras: 4 × 7,5 Mbit/s = 30 Mbit/s = 3,75 MB/s (durch 8). Zeit: 72 h × 3.600 s = 259.200 s. Bedarf: 3,75 MB/s × 259.200 s = 972.000 MB = 972 GB.',
    difficulty: 3,
  ),
  tabelle(
    'i3-hs-4',
    'h-speicher',
    scenario: 'Für einen Kunden sollst du HDD und NVMe-SSD gegenüberstellen.',
    prompt: 'Vervollständige den Vergleich.',
    zeilen: [
      ['Merkmal', 'HDD', 'NVMe-SSD'],
      [
        'Speicherprinzip',
        wahl('magnetische Scheiben', ['Flash-Zellen', 'optische Schicht']),
        wahl('Flash-Zellen', ['magnetische Scheiben', 'optische Schicht']),
      ],
      [
        'übliche Anbindung',
        wahl('SATA', ['PCIe', 'HDMI']),
        wahl('PCIe', ['SATA', 'HDMI']),
      ],
      [
        'Lesen, Größenordnung',
        wahl('150 MB/s', ['3.500 MB/s', '40.000 MB/s']),
        wahl('3.500 MB/s', ['150 MB/s', '15 MB/s']),
      ],
      [
        'typischer Einsatz',
        wahl('großes, günstiges Archiv', [
          'Systemlaufwerk im Notebook',
          'Arbeitsspeicher',
        ]),
        wahl('schnelles Systemlaufwerk', [
          'Langzeitarchiv auf Band',
          'Arbeitsspeicher',
        ]),
      ],
    ],
    punkte: 4,
    explanation:
        'Die HDD speichert magnetisch auf rotierenden Scheiben, hängt an SATA und ist pro GB günstig - gut für Archive. Die NVMe-SSD speichert in Flash-Zellen, hängt an PCIe und liest mehrere GB pro Sekunde - ideal als Systemlaufwerk.',
  ),
  freitext(
    'i3-hs-5',
    'h-speicher',
    scenario:
        'Die Außendienst-Notebooks sollen statt einer HDD künftig eine SSD erhalten.',
    prompt: 'Nenne drei Vorteile einer SSD gegenüber einer HDD im Notebook.',
    kriterien: [
      krit(
        'kürzere Zugriffszeiten, schnelleres Starten und Laden',
        stichwoerter: [
          'schneller',
          'Zugriffszeit',
          'Geschwindigkeit',
          'bootet',
        ],
      ),
      krit(
        'unempfindlich gegen Stöße, da keine beweglichen Teile',
        stichwoerter: [
          'stoßfest',
          'Stöße',
          'robust',
          'keine beweglichen Teile',
          'keine Mechanik',
        ],
      ),
      krit(
        'geringerer Stromverbrauch, längere Akkulaufzeit',
        stichwoerter: ['Strom', 'Energie', 'Akku', 'sparsam'],
      ),
      krit(
        'lautlos und weniger Abwärme',
        stichwoerter: ['leise', 'lautlos', 'geräuschlos', 'Wärme'],
      ),
      krit(
        'kleiner und leichter (M.2-Bauform)',
        stichwoerter: ['leichter', 'kleiner', 'Gewicht', 'M.2', 'Bauform'],
      ),
    ],
    punkte: 3,
    loesung:
        'Eine SSD ist deutlich schneller (kurze Zugriffszeiten), unempfindlich gegen Stöße, weil sie keine beweglichen Teile hat, und braucht weniger Strom - der Akku hält länger. Außerdem arbeitet sie lautlos und ist kleiner und leichter.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 3 Punkte. Andere fachlich richtige Vorteile zählen ebenfalls. Der Preis pro GB ist dagegen ein Vorteil der HDD.',
    difficulty: 1,
  ),

  // ============================================ Schnittstellen und Peripherie
  paare(
    'i3-hi-1',
    'h-schnittstellen',
    scenario:
        'Auf der Rückseite eines neuen PCs sind mehrere Buchsen zu sehen.',
    prompt: 'Ordne jedem Anschluss seinen Zweck zu.',
    paare: [
      paar('RJ45', 'Netzwerkkabel zum Switch'),
      paar('Kaltgerätebuchse', 'Stromkabel für 230 V'),
      paar('DisplayPort', 'Bildsignal, Monitorkette möglich'),
      paar('USB-A', 'Maus, Tastatur, USB-Stick'),
      paar('Klinke 3,5 mm', 'Headset oder Lautsprecher'),
    ],
    punkte: 5,
    explanation:
        'RJ45 ist die Netzwerkbuchse, die Kaltgerätebuchse nimmt das Stromkabel auf, DisplayPort überträgt Bild und Ton und kann Monitore verketten, USB-A bindet Peripherie an, die Klinkenbuchse dient dem Ton.',
    difficulty: 1,
  ),
  freitext(
    'i3-hi-2',
    'h-schnittstellen',
    scenario:
        'An einem Arbeitsplatz sollen drei Monitore betrieben werden. Der PC hat nur einen freien DisplayPort-Ausgang. Der Hersteller empfiehlt Daisy Chaining.',
    prompt:
        'Beschreibe das Daisy Chaining von Monitoren und nenne zwei technische Voraussetzungen.',
    kriterien: [
      krit(
        'Die Monitore werden hintereinander verbunden: vom PC zum ersten Monitor, von dort zum nächsten - nur ein Kabel führt zum PC',
        punkte: 2,
        stichwoerter: [
          'hintereinander',
          'in Reihe',
          'Kette',
          'von Monitor zu Monitor',
          'nacheinander',
        ],
      ),
      krit(
        'Der PC-Ausgang muss Multi-Stream Transport (MST) unterstützen: DisplayPort ab 1.2 oder Thunderbolt',
        stichwoerter: ['MST', 'Multi-Stream', 'DisplayPort 1.2', 'Thunderbolt'],
      ),
      krit(
        'Die Monitore (außer dem letzten) brauchen einen DisplayPort-Ausgang zum Weiterreichen',
        stichwoerter: [
          'DisplayPort-Ausgang',
          'DP OUT',
          'Ausgang am Monitor',
          'weiterreichen',
          'durchschleifen',
        ],
      ),
      krit(
        'Die Datenrate des einen Ausgangs muss für alle Bilder zusammen reichen',
        stichwoerter: ['Bandbreite', 'Datenrate', 'Auflösung', 'teilen'],
      ),
    ],
    punkte: 4,
    loesung:
        'Beim Daisy Chaining werden die Monitore in Reihe geschaltet: Ein Kabel führt vom PC zum ersten Monitor, von dessen Ausgang geht es zum zweiten und von dort zum dritten. Voraussetzungen: Der Ausgang des PCs (DisplayPort ab 1.2 oder Thunderbolt) und die Monitore müssen Multi-Stream Transport unterstützen, und die Monitore in der Kette brauchen einen DisplayPort-Ausgang. Die Datenrate des einen Ausgangs muss für alle Bilder genügen.',
    explanation:
        'Bewertung: 2 Punkte für die Beschreibung, je 1 Punkt für eine Voraussetzung - höchstens 4 Punkte. HDMI eignet sich nicht für eine Monitorkette.',
  ),
  tabelle(
    'i3-hi-3',
    'h-schnittstellen',
    scenario:
        'Für die Arbeitsplätze im Vertrieb liegt das englische Datenblatt eines Monitors vor. Ein Notebook soll über USB-C angeschlossen und ein zweiter Monitor angehängt werden.',
    code:
        'Monitor U27-D - Rear I/O\n'
        '1x DisplayPort 1.4 IN\n'
        '1x DisplayPort 1.4 OUT (MST)\n'
        '1x HDMI 2.0 IN\n'
        '1x USB-C upstream (video, 65 W charging)\n'
        '2x USB-A downstream, 5 Gbit/s\n'
        'AC IN: 100-240 V (IEC C14)',
    prompt: 'Ergänze die Tabelle anhand des Datenblatts.',
    zeilen: [
      ['Frage', 'Antwort'],
      [
        'Anschluss für den zweiten Monitor der Kette',
        wahl('DisplayPort OUT', ['HDMI IN', 'USB-A', 'DisplayPort IN']),
      ],
      ['Ladeleistung für das Notebook in W', zahl(65)],
      ['Datenrate der USB-A-Buchsen in Gbit/s', zahl(5)],
      [
        'Kabel für den Anschluss AC IN',
        wahl('Kaltgerätekabel', ['Patchkabel', 'HDMI-Kabel', 'USB-C-Kabel']),
      ],
    ],
    punkte: 4,
    explanation:
        'Die Kette läuft über DisplayPort OUT (MST). USB-C upstream lädt das Notebook mit 65 W. Die USB-A-Buchsen schaffen 5 Gbit/s (USB 3.2 Gen 1). AC IN mit IEC C14 ist die Kaltgerätebuchse für das Netzkabel.',
    tags: ['englisch', 'datenblatt'],
  ),
  rechnen(
    'i3-hi-4',
    'h-schnittstellen',
    scenario:
        'Ein Belegdrucker wird mit einem Netzteil 24 V / 0,75 A geliefert. Ein Kollege möchte ihn stattdessen über einen USB-Port (5 V) des Kassen-PCs versorgen. Es gilt P = U × I.',
    prompt:
        'Ermittle den Strom in Ampere, den der USB-Port dafür liefern müsste.',
    answer: 3.6,
    tolerance: 0.001,
    unit: 'A',
    punkte: 2,
    explanation:
        'Leistung des Druckers: P = 24 V × 0,75 A = 18 W. Strom bei 5 V: I = P / U = 18 W / 5 V = 3,6 A. Ein USB-A-Port liefert nur 0,5 bis 0,9 A, USB-C ohne Power Delivery bis 3 A - das Netzteil bleibt die richtige Wahl.',
  ),
  markieren(
    'i3-hi-5',
    'h-schnittstellen',
    scenario:
        'Das I/O-Panel eines Notebook-Docks hat die folgenden Buchsen. Ein Monitor soll angeschlossen werden.',
    prompt:
        'Markiere alle Buchsen, über die ein Monitor sein Bildsignal erhalten kann.',
    zeilen: [
      ja('HDMI', 'Überträgt Bild und Ton digital.'),
      ja('DisplayPort', 'Überträgt Bild und Ton digital.'),
      ja(
        'USB-C mit DisplayPort-Modus (Thunderbolt)',
        'Über USB-C kann im DisplayPort-Modus auch das Bild laufen.',
      ),
      nein('RJ45', 'Das ist die Netzwerkbuchse.'),
      nein('USB-A 2.0', 'Für Maus, Tastatur und Speicher - kein Bildausgang.'),
      nein('Klinke 3,5 mm', 'Überträgt nur Ton.'),
      nein('Kaltgerätebuchse', 'Hier steckt das Stromkabel.'),
    ],
    explanation:
        'Bildsignale liefern HDMI, DisplayPort und USB-C im DisplayPort-Modus bzw. Thunderbolt. RJ45 ist Netzwerk, die Klinke Ton, die Kaltgerätebuchse Strom.',
  ),
  lueckentext(
    'i3-hi-6',
    'h-schnittstellen',
    scenario:
        'Für das Intranet entsteht ein Merkblatt zu den Anschlüssen am Arbeitsplatz.',
    prompt: 'Vervollständige die Aussagen zu Schnittstellen.',
    text:
        'Mehrere Monitore lassen sich über {0} hintereinander an einem Ausgang betreiben. '
        'Die Technik dahinter heißt {1}. '
        'Das Netzteil eines PCs wird über die {2} mit dem Stromnetz verbunden. '
        'USB-C beschreibt nur die {3}, nicht die Geschwindigkeit.',
    luecken: [
      wort(['DisplayPort']),
      wort(['Multi-Stream Transport']),
      wort(['Kaltgerätebuchse']),
      wort(['Steckerform']),
    ],
    wortbank: ['HDMI', 'RJ45-Buchse', 'Power over Ethernet', 'Datenrate'],
    punkte: 4,
    explanation:
        'Monitorketten (Daisy Chaining) laufen über DisplayPort mit Multi-Stream Transport. Das Stromkabel steckt in der Kaltgerätebuchse. USB-C ist eine Steckerform - die Datenrate hängt vom Standard dahinter ab.',
  ),
  freitext(
    'i3-hi-7',
    'h-schnittstellen',
    scenario:
        'Die Beschäftigten im Einkauf arbeiten abwechselnd im Büro und unterwegs. Im Büro sollen ihre Notebooks an eine USB-C-Dockingstation angeschlossen werden.',
    prompt: 'Nenne drei Vorteile einer Dockingstation am Arbeitsplatz.',
    kriterien: [
      krit(
        'ein einziges Kabel verbindet das Notebook mit allen Geräten',
        stichwoerter: ['ein Kabel', 'einziges Kabel', 'nur ein Stecker'],
      ),
      krit(
        'das Notebook wird über das Dock geladen',
        stichwoerter: ['laden', 'Strom', 'Power Delivery', 'Netzteil'],
      ),
      krit(
        'externe Monitore, Tastatur und Maus für ergonomisches Arbeiten',
        stichwoerter: ['Monitor', 'Tastatur', 'Maus', 'ergonomisch'],
      ),
      krit(
        'kabelgebundenes Netzwerk über den RJ45-Anschluss des Docks',
        stichwoerter: ['Netzwerk', 'LAN', 'RJ45', 'Ethernet'],
      ),
      krit(
        'schneller Wechsel zwischen mobilem und festem Arbeiten',
        stichwoerter: ['schnell', 'Wechsel', 'mobil', 'flexibel'],
      ),
    ],
    punkte: 3,
    loesung:
        'Über ein einziges USB-C-Kabel hängt das Notebook an Monitoren, Tastatur, Maus und Netzwerk und wird zugleich geladen. Das spart Zeit beim Wechsel zwischen unterwegs und Büro und ermöglicht einen ergonomischen Arbeitsplatz mit großen Bildschirmen.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 3 Punkte. Andere fachlich richtige Vorteile zählen ebenfalls.',
    difficulty: 1,
  ),

  // =================================================== USV und Stromversorgung
  rechnen(
    'i3-hu-1',
    'h-usv',
    scenario:
        'Auf dem Netzteil eines Notebooks steht der folgende Aufdruck. Es gilt P = U × I.',
    code:
        'AC ADAPTER\n'
        'INPUT:  100-240 V ~ 1.5 A, 50-60 Hz\n'
        'OUTPUT: 20 V = 4.5 A',
    prompt:
        'Berechne die Leistung in Watt, die das Netzteil an das Notebook abgeben kann.',
    answer: 90,
    unit: 'W',
    punkte: 2,
    explanation:
        'Maßgeblich ist die Ausgangsseite (OUTPUT): P = U × I = 20 V × 4,5 A = 90 W. Die Angabe INPUT beschreibt die Aufnahme aus der Steckdose.',
    tags: ['englisch'],
    difficulty: 1,
  ),
  lueckentext(
    'i3-hu-2',
    'h-usv',
    scenario:
        'Der Serverschrank eines Kunden soll eine USV erhalten. Geplant werden 25 % Reserve; der Leistungsfaktor der USV beträgt 0,75. Lieferbar sind Modelle mit 1.000 VA, 1.200 VA und 1.500 VA.',
    table: [
      ['Gerät', 'Anzahl', 'Leistung'],
      ['Server', '2', 'je 300 W'],
      ['Switch', '1', '80 W'],
      ['NAS', '1', '60 W'],
      ['Firewall', '1', '40 W'],
    ],
    prompt: 'Dimensioniere die USV Schritt für Schritt.',
    text:
        'Summe der Geräte: {0} W\n'
        'mit Reserve: {1} W\n'
        'nötige Scheinleistung: {2} VA\n'
        'gewähltes Modell: {3}',
    luecken: [
      zahl(780, rationale: '2 × 300 + 80 + 60 + 40'),
      zahl(975, rationale: '780 W × 1,25'),
      zahl(1300, rationale: '975 W / 0,75'),
      wahl('1.500 VA', ['1.000 VA', '1.200 VA']),
    ],
    punkte: 4,
    explanation:
        'Summe: 2 × 300 W + 80 W + 60 W + 40 W = 780 W. Mit 25 % Reserve: 780 W × 1,25 = 975 W. Scheinleistung: 975 W / 0,75 = 1.300 VA. Das nächstgrößere Modell hat 1.500 VA.',
  ),
  tabelle(
    'i3-hu-3',
    'h-usv',
    scenario:
        'Ein Kunde möchte wissen, worin sich die drei angebotenen USV-Typen unterscheiden.',
    prompt: 'Vervollständige den Vergleich der drei USV-Typen.',
    zeilen: [
      ['Merkmal', 'Offline (VFD)', 'Line-Interactive (VI)', 'Online (VFI)'],
      [
        'Umschaltzeit',
        'wenige ms',
        wahl('wenige ms', ['keine', 'mehrere Sekunden']),
        wahl('keine', ['wenige ms', 'mehrere Sekunden']),
      ],
      [
        'gleicht Schwankungen aus',
        wahl('nein', ['ja, per Spannungsregler', 'ja, per Doppelwandlung']),
        wahl('ja, per Spannungsregler', ['nein', 'ja, per Doppelwandlung']),
        wahl('ja, per Doppelwandlung', ['nein', 'ja, per Spannungsregler']),
      ],
      [
        'typischer Einsatz',
        wahl('einzelner Arbeitsplatz-PC', ['Rechenzentrum', 'Großrechner']),
        'kleiner Server, Netzwerkschrank',
        wahl('Rechenzentrum', ['einzelner Arbeitsplatz-PC', 'Drucker']),
      ],
    ],
    punkte: 4,
    explanation:
        'Offline- und Line-Interactive-USV schalten bei Ausfall in wenigen Millisekunden um; die Line-Interactive regelt zusätzlich die Spannung. Die Online-USV versorgt die Last dauerhaft über den Wechselrichter (Doppelwandlung) - ohne Umschaltzeit, aber teurer.',
  ),
  freitext(
    'i3-hu-4',
    'h-usv',
    scenario:
        'Ein Handwerksbetrieb betreibt einen Server im Abstellraum ohne USV. Nach einem kurzen Stromausfall war die Datenbank der Auftragsverwaltung beschädigt.',
    prompt: 'Erläutere zwei Aufgaben, die eine USV in diesem Betrieb erfüllt.',
    kriterien: [
      krit(
        'Sie überbrückt kurze Stromausfälle aus dem Akku, sodass der Server weiterläuft',
        punkte: 2,
        stichwoerter: ['überbrücken', 'Akku', 'weiterlaufen', 'Stromausfall'],
      ),
      krit(
        'Bei längerem Ausfall fährt der Server geordnet herunter - kein Datenverlust, kein beschädigtes Dateisystem',
        punkte: 2,
        stichwoerter: [
          'herunterfahren',
          'geordnet',
          'Datenverlust',
          'Shutdown',
        ],
      ),
      krit(
        'Sie schützt vor Spannungsschwankungen und Überspannung',
        punkte: 2,
        stichwoerter: [
          'Spannungsschwankung',
          'Überspannung',
          'Unterspannung',
          'Spannungsspitzen',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Die USV überbrückt kurze Ausfälle aus ihrem Akku, sodass der Server ohne Unterbrechung weiterläuft. Dauert der Ausfall länger, meldet sie das an den Server, der dann geordnet herunterfährt - offene Dateien und Datenbanken bleiben unbeschädigt. Zusätzlich glättet sie Spannungsschwankungen und Überspannungen.',
    explanation:
        'Bewertung: 2 Punkte je erläuterter Aufgabe, höchstens 4 Punkte. Eine USV ersetzt keine Datensicherung und kein Notstromaggregat für lange Ausfälle.',
  ),
  rechnen(
    'i3-hu-5',
    'h-usv',
    scenario:
        'Ein Server nimmt an 230 V dauerhaft 1,5 A auf und läuft das ganze Jahr (8.760 Stunden). Eine Kilowattstunde kostet 0,30 €. Es gilt P = U × I.',
    prompt: 'Berechne die Stromkosten pro Jahr in Euro.',
    answer: 906.66,
    tolerance: 0.01,
    unit: '€',
    punkte: 4,
    explanation:
        'Leistung: P = 230 V × 1,5 A = 345 W = 0,345 kW. Energie: 0,345 kW × 8.760 h = 3.022,2 kWh. Kosten: 3.022,2 kWh × 0,30 € = 906,66 €.',
  ),
  markieren(
    'i3-hu-6',
    'h-usv',
    scenario:
        'Eine Kollegin hat die jährlichen Betriebskosten des Serverschranks berechnet. Die Ausgangswerte stimmen: drei Server je 200 W, ein Switch 150 W, Dauerbetrieb, 0,30 € pro kWh, Akkutausch 240 € alle 4 Jahre.',
    prompt: 'Markiere die Zeilen, die einen Rechenfehler enthalten.',
    mono: true,
    zeilen: [
      nein('Leistung: 3 × 200 W + 150 W = 750 W', '600 W + 150 W = 750 W.'),
      nein('pro Tag: 750 W × 24 h = 18 kWh', '18.000 Wh sind 18 kWh.'),
      nein('pro Jahr: 18 kWh × 365 = 6.570 kWh', '18 × 365 = 6.570.'),
      ja(
        'Strom: 6.570 kWh × 0,30 € = 197,10 €',
        'Kommafehler: 6.570 × 0,30 = 1.971,00 €.',
      ),
      ja('Akku: 240 € / 4 Jahre = 80 € pro Jahr', '240 / 4 = 60 € pro Jahr.'),
    ],
    explanation:
        'Richtig wäre: Stromkosten 6.570 kWh × 0,30 € = 1.971,00 € und Akkukosten 240 € / 4 = 60 € pro Jahr. Die ersten drei Zeilen stimmen.',
  ),
  paare(
    'i3-hu-7',
    'h-usv',
    scenario:
        'Im Datenblatt einer USV stehen verschiedene Größen mit ihren Einheiten.',
    prompt: 'Ordne jeder Größe ihre Einheit zu.',
    paare: [
      paar('Wirkleistung', 'Watt (W)'),
      paar('Scheinleistung', 'Voltampere (VA)'),
      paar('Spannung', 'Volt (V)'),
      paar('Stromstärke', 'Ampere (A)'),
      paar('Kapazität des Akkus', 'Amperestunden (Ah)'),
      paar('Energie', 'Wattstunden (Wh)'),
    ],
    explanation:
        'Geräte geben ihren Bedarf in Watt an, USVs ihre Leistung in VA. Spannung in Volt mal Strom in Ampere ergibt die Leistung; Spannung mal Akkukapazität in Ah ergibt die Energie in Wh.',
    difficulty: 1,
  ),

  // ======================================================= Green IT und Ergonomie
  freitext(
    'i3-ha-1',
    'h-arbeitsplatz',
    scenario:
        'Ein Mitarbeiter arbeitet seit Wochen mit dem Notebook an einem niedrigen Besprechungstisch, auf einem einfachen Stuhl, mit dem Rücken zum Fenster. Er klagt über Nacken- und Augenbeschwerden.',
    prompt:
        'Nenne vier Maßnahmen, mit denen der Arbeitsplatz ergonomischer wird.',
    kriterien: [
      krit(
        'separater, größerer, höhenverstellbarer Bildschirm',
        stichwoerter: ['Monitor', 'Bildschirm', 'externer Bildschirm'],
      ),
      krit(
        'externe Tastatur und Maus',
        stichwoerter: ['Tastatur', 'Maus', 'Eingabegeräte'],
      ),
      krit(
        'höhenverstellbarer Schreibtisch',
        stichwoerter: ['Tisch', 'Schreibtisch', 'höhenverstellbar'],
      ),
      krit(
        'ergonomischer, verstellbarer Bürostuhl',
        stichwoerter: ['Stuhl', 'Bürostuhl', 'Rückenlehne'],
      ),
      krit(
        'Bildschirm seitlich zum Fenster aufstellen, Blendung und Spiegelung vermeiden',
        stichwoerter: [
          'Fenster',
          'Blendung',
          'Spiegelung',
          'parallel',
          'seitlich',
        ],
      ),
      krit(
        'Dockingstation oder Notebook-Ständer',
        stichwoerter: ['Dockingstation', 'Dock', 'Ständer', 'Notebookständer'],
      ),
    ],
    punkte: 4,
    loesung:
        'Ein separater, höhenverstellbarer Bildschirm (Oberkante auf oder leicht unter Augenhöhe), externe Tastatur und Maus, ein höhenverstellbarer Tisch und ein ergonomischer Bürostuhl. Der Bildschirm steht seitlich zum Fenster, damit nichts blendet oder spiegelt.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte. Ein Notebook allein ist kein Dauerarbeitsplatz: Bildschirm und Tastatur lassen sich nicht getrennt einstellen.',
    difficulty: 1,
  ),
  tabelle(
    'i3-ha-2',
    'h-arbeitsplatz',
    scenario:
        'Für 2.000 Betriebsstunden im Jahr werden zwei Monitore verglichen. Strom kostet 0,35 € pro kWh, betrachtet werden 5 Jahre.',
    table: [
      ['', 'Monitor A', 'Monitor B'],
      ['Kaufpreis', '189 €', '219 €'],
      ['Leistungsaufnahme', '28 W', '18 W'],
    ],
    prompt: 'Vervollständige den Kostenvergleich.',
    zeilen: [
      ['Größe', 'Monitor A', 'Monitor B'],
      ['Verbrauch pro Jahr in kWh', zahl(56), zahl(36)],
      [
        'Stromkosten pro Jahr in €',
        zahl(19.6, toleranz: 0.01),
        zahl(12.6, toleranz: 0.01),
      ],
      ['Gesamtkosten über 5 Jahre in €', zahl(287), zahl(282)],
    ],
    punkte: 6,
    explanation:
        'A: 28 W × 2.000 h = 56 kWh, × 0,35 € = 19,60 € pro Jahr, 189 € + 5 × 19,60 € = 287 €. B: 18 W × 2.000 h = 36 kWh, × 0,35 € = 12,60 €, 219 € + 5 × 12,60 € = 282 €. Über 5 Jahre ist der teurere, sparsamere Monitor B um 5 € günstiger.',
  ),
  markieren(
    'i3-ha-3',
    'h-arbeitsplatz',
    scenario:
        'Bei einer Begehung der Büros notiert die Fachkraft für Arbeitssicherheit die folgenden Beobachtungen.',
    prompt:
        'Markiere alle Beobachtungen, die gegen die Regeln für Bildschirmarbeitsplätze verstoßen.',
    zeilen: [
      ja(
        'Der Monitor steht direkt vor dem Fenster.',
        'Das Gegenlicht blendet - der Monitor gehört seitlich zum Fenster.',
      ),
      nein(
        'Die Oberkante des Monitors liegt leicht unter Augenhöhe.',
        'So bleibt der Kopf entspannt leicht geneigt.',
      ),
      ja(
        'Der Sehabstand beträgt 30 cm.',
        'Zu nah: empfohlen sind etwa 50 bis 70 cm.',
      ),
      nein(
        'Der Schreibtisch ist höhenverstellbar.',
        'Das ermöglicht den Wechsel zwischen Sitzen und Stehen.',
      ),
      ja(
        'Am Dauerarbeitsplatz steht nur ein Notebook ohne externe Tastatur.',
        'Bildschirm und Tastatur müssen sich getrennt aufstellen lassen.',
      ),
      nein(
        'Die Beleuchtungsstärke beträgt 500 Lux.',
        'Das entspricht dem Richtwert für Büroarbeit.',
      ),
    ],
    explanation:
        'Verstöße: Monitor vor dem Fenster (Blendung), zu geringer Sehabstand und ein Notebook als Dauerarbeitsplatz. Monitor auf Augenhöhe, verstellbarer Tisch und 500 Lux sind in Ordnung.',
  ),
  freitext(
    'i3-ha-4',
    'h-arbeitsplatz',
    scenario:
        'Die Geschäftsführung möchte die Stromkosten der 60 Büroarbeitsplätze senken.',
    prompt:
        'Nenne drei Maßnahmen, mit denen sich der Energieverbrauch der Arbeitsplätze verringern lässt.',
    kriterien: [
      krit(
        'Energiesparmodus bzw. automatischen Ruhezustand einrichten',
        stichwoerter: [
          'Energiesparmodus',
          'Ruhezustand',
          'Standby',
          'Energieoptionen',
        ],
      ),
      krit(
        'Geräte nach Feierabend ausschalten, schaltbare Steckdosenleisten',
        stichwoerter: ['ausschalten', 'Steckdosenleiste', 'abschalten'],
      ),
      krit(
        'sparsame Geräte beschaffen (Energielabel, Mini-PCs, Thin Clients, Notebooks)',
        stichwoerter: [
          'sparsame Geräte',
          'Energielabel',
          'Thin Client',
          'Mini-PC',
          'effizient',
        ],
      ),
      krit(
        'Netzteile mit hohem Wirkungsgrad (80 PLUS)',
        stichwoerter: ['Wirkungsgrad', '80 PLUS', 'Netzteil'],
      ),
      krit(
        'Bildschirmhelligkeit reduzieren, Monitore automatisch abschalten',
        stichwoerter: ['Helligkeit', 'Monitor abschalten', 'Bildschirm aus'],
      ),
    ],
    punkte: 3,
    loesung:
        'Energiesparmodus und automatischen Ruhezustand einrichten, Geräte nach Feierabend über schaltbare Steckdosenleisten vom Netz trennen und bei Neubeschaffung auf sparsame Geräte mit effizientem Netzteil achten.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 3 Punkte. Andere fachlich richtige Maßnahmen zählen ebenfalls.',
    difficulty: 1,
  ),

  // ============================================= Aufgaben eines Betriebssystems
  freitext(
    'i3-ba-1',
    'b-aufgaben',
    prompt: 'Nenne vier Aufgaben eines Betriebssystems.',
    scenario:
        'In der Einarbeitung einer neuen Kollegin sollst du erklären, wofür ein Betriebssystem zuständig ist.',
    kriterien: [
      krit(
        'Prozessverwaltung: Rechenzeit auf Programme verteilen',
        stichwoerter: ['Prozess', 'Rechenzeit', 'Scheduling', 'Multitasking'],
      ),
      krit(
        'Speicherverwaltung: Arbeitsspeicher zuteilen und auslagern',
        stichwoerter: ['Speicherverwaltung', 'Arbeitsspeicher', 'RAM'],
      ),
      krit(
        'Geräteverwaltung: Hardware über Treiber ansteuern',
        stichwoerter: ['Geräte', 'Treiber', 'Hardware'],
      ),
      krit(
        'Dateiverwaltung: Dateien und Verzeichnisse im Dateisystem',
        stichwoerter: ['Datei', 'Dateisystem', 'Verzeichnis'],
      ),
      krit(
        'Benutzer- und Rechteverwaltung',
        stichwoerter: ['Benutzer', 'Rechte', 'Anmeldung', 'Konten'],
      ),
      krit(
        'Bereitstellen einer Benutzeroberfläche und von Schnittstellen für Programme',
        stichwoerter: ['Oberfläche', 'Schnittstelle', 'API', 'Shell'],
      ),
    ],
    punkte: 4,
    loesung:
        'Prozessverwaltung (Rechenzeit verteilen), Speicherverwaltung (Arbeitsspeicher zuteilen), Geräteverwaltung (Hardware über Treiber ansteuern), Dateiverwaltung sowie Benutzer- und Rechteverwaltung.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte. Das Betriebssystem vermittelt zwischen Hardware und Anwendungen.',
    difficulty: 1,
  ),
  lueckentext(
    'i3-ba-2',
    'b-aufgaben',
    scenario: 'Der Ressourcenmonitor zeigt für jeden Prozess einen Zustand an.',
    prompt: 'Vervollständige die Beschreibung der Prozesszustände.',
    text:
        'Ein Prozess, der nur noch auf die CPU wartet, ist {0}. '
        'Bekommt er eine Zeitscheibe, ist er {1}. '
        'Wartet er auf Daten vom Datenträger, ist er {2}. '
        'Welcher Prozess als Nächstes rechnen darf, entscheidet der {3}.',
    luecken: [
      wort(['bereit']),
      wort(['rechnend']),
      wort(['blockiert']),
      wort(['Scheduler']),
    ],
    wortbank: ['beendet', 'Treiber', 'Bootloader'],
    punkte: 4,
    explanation:
        'Drei Zustände: bereit (wartet auf die CPU), rechnend (hat die CPU), blockiert (wartet auf Ein- oder Ausgabe). Der Scheduler teilt die Zeitscheiben zu.',
  ),
  paare(
    'i3-ba-3',
    'b-aufgaben',
    scenario:
        'In einer Fehlermeldung des Betriebssystems tauchen mehrere Fachbegriffe auf.',
    prompt: 'Ordne jedem Begriff die passende Erklärung zu.',
    paare: [
      paar('Treiber', 'steuert ein bestimmtes Gerät an'),
      paar('Scheduler', 'verteilt die Rechenzeit'),
      paar('Auslagerungsdatei', 'erweitert den RAM auf dem Datenträger'),
      paar('Kernel', 'Kern mit vollem Hardwarezugriff'),
      paar('Systemaufruf', 'Anfrage eines Programms an den Kernel'),
    ],
    explanation:
        'Treiber übersetzen zur Hardware, der Scheduler teilt die CPU zu, die Auslagerungsdatei nimmt Speicherseiten auf, der Kernel ist der Kern des Systems, und über Systemaufrufe bitten Programme ihn um Dienste.',
  ),
  markieren(
    'i3-ba-4',
    'b-aufgaben',
    scenario:
        'Eine neue Bürosoftware soll verteilt werden. Der Hersteller nennt die Mindestanforderungen, die Inventarliste zeigt den Bestand.',
    code:
        'Minimum requirements\n'
        'OS:   64-bit operating system\n'
        'RAM:  8 GB (16 GB recommended)\n'
        'Disk: 4 GB free space',
    prompt: 'Markiere alle PCs, die die Mindestanforderungen NICHT erfüllen.',
    mono: true,
    zeilen: [
      nein(
        'PC-01: 64 Bit, 8 GB RAM, 120 GB frei',
        'Erfüllt alle drei Anforderungen genau.',
      ),
      ja(
        'PC-02: 32 Bit, 4 GB RAM, 50 GB frei',
        'Verlangt ist ein 64-Bit-System, außerdem fehlen 4 GB RAM.',
      ),
      ja(
        'PC-03: 64 Bit, 4 GB RAM, 200 GB frei',
        'Nur 4 GB statt mindestens 8 GB RAM.',
      ),
      ja(
        'PC-04: 64 Bit, 16 GB RAM, 3 GB frei',
        'Es sind nur 3 GB statt 4 GB frei.',
      ),
      nein(
        'PC-05: 64 Bit, 32 GB RAM, 500 GB frei',
        'Übertrifft alle Anforderungen.',
      ),
    ],
    explanation:
        'Verlangt sind 64 Bit, mindestens 8 GB RAM und 4 GB freier Speicherplatz. PC-02 (32 Bit), PC-03 (4 GB RAM) und PC-04 (3 GB frei) scheitern. „Recommended“ ist nur eine Empfehlung.',
    tags: ['englisch'],
  ),

  // ============================================================== Dateisysteme
  tabelle(
    'i3-bd-1',
    'b-dateisysteme',
    scenario:
        'Für USB-Sticks, einen Windows-Dateiserver und einen Linux-Server muss jeweils ein Dateisystem gewählt werden.',
    prompt: 'Vervollständige den Vergleich der Dateisysteme.',
    zeilen: [
      ['Merkmal', 'FAT32', 'NTFS', 'ext4'],
      [
        'größte Datei',
        wahl('4 GiB', ['16 GiB', 'praktisch unbegrenzt']),
        'praktisch unbegrenzt',
        'praktisch unbegrenzt',
      ],
      [
        'Zugriffsrechte',
        wahl('nein', ['ja', 'nur für Ordner']),
        wahl('ja', ['nein', 'nur für Ordner']),
        'ja',
      ],
      [
        'Journaling',
        'nein',
        wahl('ja', ['nein', 'nur lesend']),
        wahl('ja', ['nein', 'nur lesend']),
      ],
      [
        'typisch für',
        'USB-Sticks',
        wahl('Windows', ['Linux', 'macOS']),
        wahl('Linux', ['Windows', 'macOS']),
      ],
    ],
    punkte: 4,
    explanation:
        'FAT32: höchstens 4 GiB je Datei, keine Rechte, kein Journal - dafür überall lesbar. NTFS (Windows) und ext4 (Linux) kennen große Dateien, Zugriffsrechte und Journaling.',
  ),
  freitext(
    'i3-bd-2',
    'b-dateisysteme',
    scenario:
        'Zehn ausgemusterte PCs sollen an eine Schule gespendet werden. Ein Kollege schlägt vor, die Festplatten vorher schnell zu formatieren.',
    prompt:
        'Erläutere, warum eine Schnellformatierung nicht genügt, und nenne zwei geeignete Verfahren.',
    kriterien: [
      krit(
        'Die Schnellformatierung legt nur ein neues, leeres Inhaltsverzeichnis an - die Daten bleiben erhalten und lassen sich wiederherstellen',
        punkte: 2,
        stichwoerter: [
          'wiederherstellen',
          'Inhaltsverzeichnis',
          'Daten bleiben',
          'rekonstruieren',
          'nicht überschrieben',
        ],
      ),
      krit(
        'Datenträger vollständig überschreiben',
        stichwoerter: ['überschreiben', 'Nullen', 'wipe'],
      ),
      krit(
        'Secure Erase des Herstellers nutzen (vor allem bei SSDs)',
        stichwoerter: [
          'Secure Erase',
          'sicheres Löschen',
          'Herstellerfunktion',
        ],
      ),
      krit(
        'Datenträger physisch vernichten (schreddern)',
        stichwoerter: ['vernichten', 'schreddern', 'zerstören'],
      ),
    ],
    punkte: 4,
    loesung:
        'Bei der Schnellformatierung wird nur ein neues, leeres Dateisystem angelegt; die eigentlichen Daten stehen weiter auf dem Datenträger und lassen sich mit Werkzeugen wiederherstellen. Geeignet sind: den Datenträger vollständig überschreiben, bei SSDs Secure Erase nutzen oder den Datenträger physisch vernichten.',
    explanation:
        'Bewertung: 2 Punkte für die Erläuterung, je 1 Punkt für ein geeignetes Verfahren - höchstens 4 Punkte.',
  ),
  lueckentext(
    'i3-bd-3',
    'b-dateisysteme',
    scenario:
        'Eine Datei ist 10.000 Byte groß. Das Dateisystem arbeitet mit einer Clustergröße von 4 KiB (4.096 Byte).',
    prompt: 'Ermittle die Werte.',
    text:
        'Benötigte Cluster: {0}\n'
        'Belegter Platz: {1} Byte\n'
        'Ungenutzter Rest (Verschnitt): {2} Byte',
    luecken: [
      zahl(3, rationale: '10.000 / 4.096 ≈ 2,44 - aufrunden'),
      zahl(12288, rationale: '3 × 4.096'),
      zahl(2288, rationale: '12.288 - 10.000'),
    ],
    punkte: 3,
    explanation:
        '10.000 / 4.096 ≈ 2,44 - angefangene Cluster zählen voll, also 3 Cluster. Belegt: 3 × 4.096 = 12.288 Byte. Verschnitt: 12.288 - 10.000 = 2.288 Byte.',
  ),
  paare(
    'i3-bd-4',
    'b-dateisysteme',
    scenario:
        'Bei der Arbeit an einem Linux-Server begegnen dir immer wieder dieselben Pfade.',
    prompt: 'Ordne jedem Linux-Pfad seine Bedeutung zu.',
    paare: [
      paar('/', 'Wurzelverzeichnis'),
      paar('/home', 'persönliche Ordner der Benutzer'),
      paar('/etc', 'Konfigurationsdateien'),
      paar('/var/log', 'Protokolldateien'),
      paar('..', 'übergeordnetes Verzeichnis'),
    ],
    explanation:
        'Der Verzeichnisbaum beginnt unter Linux bei /. Benutzerordner liegen unter /home, Konfigurationen unter /etc, Protokolle unter /var/log. Zwei Punkte stehen für das übergeordnete Verzeichnis.',
  ),

  // ======================================================== Benutzer und Rechte
  lueckentext(
    'i3-br-1',
    'b-rechte',
    scenario:
        'Auf einem Linux-Server zeigt ls -l die folgende Zeile (gekürzt: Rechte, Besitzerin, Gruppe, Name).',
    code: '-rw-r----- anna buchhaltung bericht.ods',
    prompt: 'Vervollständige die Aussagen zu den Rechten.',
    text:
        'Die Datei hat aktuell die Rechte chmod {0}. '
        'Mitglieder der Gruppe buchhaltung dürfen die Datei {1}. '
        'Soll die Gruppe auch schreiben dürfen, setzt man chmod {2}. '
        'Ein Skript mit den Rechten rwxr-xr-x hat den Wert {3}.',
    luecken: [
      zahl(640, rationale: 'rw- = 6, r-- = 4, --- = 0'),
      wahl('nur lesen', ['lesen und schreiben', 'gar nicht öffnen']),
      zahl(660, rationale: 'rw- = 6, rw- = 6, --- = 0'),
      zahl(755, rationale: 'rwx = 7, r-x = 5, r-x = 5'),
    ],
    punkte: 4,
    explanation:
        'r = 4, w = 2, x = 1. rw-r----- ergibt 6, 4, 0 = 640: Besitzerin liest und schreibt, die Gruppe liest nur. Mit Schreibrecht für die Gruppe: 660. rwxr-xr-x = 7, 5, 5 = 755.',
  ),
  tabelle(
    'i3-br-2',
    'b-rechte',
    scenario:
        'Für den Dateiserver gilt: Die Buchhaltung bearbeitet Rechnungen, der Vertrieb bearbeitet Angebote. Die Buchhaltung darf Angebote lesen, der Vertrieb sieht keine Rechnungen. Personalakten bearbeitet nur die Geschäftsführung, die außerdem Rechnungen und Angebote lesen darf.',
    prompt:
        'Vervollständige die Berechtigungsmatrix nach dem Prinzip der minimalen Rechte.',
    zeilen: [
      ['Gruppe', 'Rechnungen', 'Angebote', 'Personal'],
      [
        'Buchhaltung',
        wahl('Ändern', ['Lesen', 'kein Zugriff']),
        wahl('Lesen', ['Ändern', 'kein Zugriff']),
        'kein Zugriff',
      ],
      [
        'Vertrieb',
        wahl('kein Zugriff', ['Lesen', 'Ändern']),
        wahl('Ändern', ['Lesen', 'kein Zugriff']),
        wahl('kein Zugriff', ['Lesen', 'Ändern']),
      ],
      [
        'Geschäftsführung',
        'Lesen',
        wahl('Lesen', ['Ändern', 'kein Zugriff']),
        wahl('Ändern', ['Lesen', 'kein Zugriff']),
      ],
    ],
    punkte: 4,
    explanation:
        'Jede Gruppe bekommt nur, was sie für ihre Aufgabe braucht: „Ändern“ nur für die eigenen Unterlagen, „Lesen“ nur dort, wo es ausdrücklich verlangt ist, sonst kein Zugriff. Rechte werden an Gruppen vergeben, nicht an einzelne Personen.',
  ),
  freitext(
    'i3-br-3',
    'b-rechte',
    scenario:
        'In einer kleinen Firma arbeiten alle Beschäftigten mit Administratorrechten, „damit nichts hakt“.',
    prompt:
        'Erläutere, warum nicht alle Beschäftigten Administratorrechte erhalten sollten.',
    kriterien: [
      krit(
        'Schadsoftware läuft mit den Rechten des Benutzers und könnte sich mit Adminrechten systemweit einnisten',
        punkte: 2,
        stichwoerter: [
          'Schadsoftware',
          'Malware',
          'Virus',
          'systemweit',
          'Trojaner',
        ],
      ),
      krit(
        'Benutzer können versehentlich oder absichtlich Systemeinstellungen ändern oder Schutzmechanismen abschalten',
        punkte: 2,
        stichwoerter: [
          'Einstellungen ändern',
          'versehentlich',
          'abschalten',
          'Systemeinstellungen',
          'Fehlbedienung',
        ],
      ),
      krit(
        'Prinzip der minimalen Rechte: Jeder erhält nur die Rechte, die er für seine Aufgabe braucht',
        punkte: 2,
        stichwoerter: [
          'minimale Rechte',
          'Minimalprinzip',
          'Least Privilege',
          'nur nötige Rechte',
        ],
      ),
    ],
    punkte: 3,
    loesung:
        'Nach dem Prinzip der minimalen Rechte erhält jeder nur die Rechte, die er für seine Arbeit braucht. Mit Administratorrechten könnte Schadsoftware, die ein Benutzer versehentlich startet, sich im ganzen System einnisten. Außerdem könnten Benutzer Schutzfunktionen abschalten oder Einstellungen verändern.',
    explanation:
        'Bewertung: Grund plus Folge ergeben die volle Punktzahl - höchstens 3 Punkte. Administrative Arbeiten erledigt ein getrenntes Admin-Konto.',
  ),
  markieren(
    'i3-br-4',
    'b-rechte',
    scenario:
        'Bei der Prüfung eines Linux-Servers siehst du die folgende Ausgabe von ls -l (gekürzt: Rechte, Besitzer, Gruppe, Name).',
    prompt: 'Markiere alle Einträge, deren Rechte ein Sicherheitsrisiko sind.',
    mono: true,
    zeilen: [
      nein(
        '-rw-r--r-- root root hosts',
        'Nur root darf schreiben, alle dürfen lesen - üblich für diese Datei.',
      ),
      ja(
        '-rwxrwxrwx root root backup.sh',
        'Jeder darf das Skript ändern, das root später ausführt.',
      ),
      nein(
        '-rw------- anna anna id_ed25519',
        'Der private Schlüssel ist nur für die Besitzerin lesbar - richtig so.',
      ),
      ja(
        '-rw-rw-rw- root root kunden.csv',
        'Alle Benutzer dürfen die Kundendaten lesen und verändern.',
      ),
      nein(
        'drwxr-x--- anna buchhaltung rechnungen',
        'Nur Besitzerin und Gruppe kommen in den Ordner.',
      ),
    ],
    explanation:
        'Kritisch sind Rechte für „andere“: 777 auf einem Skript, das root ausführt, und 666 auf einer Datei mit Kundendaten. Die übrigen Einträge folgen dem Minimalprinzip.',
  ),

  // ============================================================== Kommandozeile
  markieren(
    'i3-bc-1',
    'b-cli',
    scenario:
        'Das Bild der Kamera am Wareneingang ruckelt. Du pingst vom Arbeitsplatz erst das Gateway, dann die Kamera - beide im eigenen LAN.',
    prompt: 'Markiere alle auffälligen Zeilen der Ausgabe.',
    mono: true,
    zeilen: [
      nein('Gateway: Zeit=1ms TTL=64', 'Im LAN normal.'),
      nein('Gateway: Zeit=2ms TTL=64', 'Im LAN normal.'),
      nein('Gateway: 4 gesendet, 0 verloren', 'Kein Paketverlust.'),
      nein('Kamera: Zeit=3ms TTL=64', 'Im LAN normal.'),
      ja('Kamera: Zeitüberschreitung', 'Auf diese Anfrage kam keine Antwort.'),
      ja(
        'Kamera: Zeit=412ms TTL=64',
        'Im LAN sind wenige Millisekunden üblich.',
      ),
      ja(
        'Kamera: 4 gesendet, 2 verloren (50%)',
        'Die Hälfte der Pakete geht verloren.',
      ),
    ],
    explanation:
        'Das Gateway antwortet schnell und verlustfrei - das eigene Netz ist in Ordnung. Bei der Kamera fallen Zeitüberschreitung, 412 ms Antwortzeit und 50 % Paketverlust auf: Die Strecke zur Kamera ist gestört.',
  ),
  freitext(
    'i3-bc-2',
    'b-cli',
    scenario:
        'Ein ping vom Homeoffice auf den Besprechungsserver der Firma zeigt: Mittelwert 390 ms, Maximum 870 ms, 20 % Paketverlust.',
    prompt:
        'Beschreibe zwei Probleme, die diese Werte bei einer Videokonferenz verursachen.',
    kriterien: [
      krit(
        'Bild ruckelt oder friert ein, weil Pakete fehlen oder zu spät kommen',
        punkte: 2,
        stichwoerter: [
          'ruckeln',
          'ruckelt',
          'einfrieren',
          'friert',
          'Standbild',
        ],
      ),
      krit(
        'Ton kommt verzögert oder abgehackt an, Gesprächspartner fallen sich ins Wort',
        punkte: 2,
        stichwoerter: ['Ton', 'verzögert', 'abgehackt', 'Verzögerung', 'Echo'],
      ),
      krit(
        'Zeitüberschreitungen führen zu Verbindungsabbrüchen',
        punkte: 2,
        stichwoerter: [
          'Abbruch',
          'Abbrüche',
          'Timeout',
          'Zeitüberschreitung',
          'Verbindung bricht',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Die hohe Antwortzeit verzögert Bild und Ton spürbar; die Gesprächspartner fallen sich ins Wort. Durch den Paketverlust fehlen Teile des Datenstroms: Das Bild ruckelt oder friert ein, der Ton klingt abgehackt. Im schlimmsten Fall bricht die Verbindung nach Zeitüberschreitungen ab.',
    explanation:
        'Bewertung: 2 Punkte je beschriebenem Problem, höchstens 4 Punkte. Für Echtzeitanwendungen sind niedrige, gleichmäßige Antwortzeiten und 0 % Verlust wichtig.',
  ),
  paare(
    'i3-bc-3',
    'b-cli',
    scenario:
        'Bei der Fehlersuche an einem Windows-Arbeitsplatz werden mehrere Befehle nacheinander eingesetzt.',
    prompt: 'Ordne jedem Windows-Befehl seine Wirkung zu.',
    paare: [
      paar('ipconfig /all', 'zeigt IP, Maske, Gateway, DNS, MAC'),
      paar('ping', 'prüft, ob ein Ziel antwortet'),
      paar('tracert', 'zeigt die Router auf dem Weg'),
      paar('nslookup', 'prüft die Namensauflösung'),
      paar('ipconfig /renew', 'fordert eine neue DHCP-Adresse an'),
    ],
    explanation:
        'ipconfig zeigt die eigene Konfiguration, ping die Erreichbarkeit, tracert den Weg, nslookup die Namensauflösung. Mit ipconfig /renew holt sich der PC eine neue Adresse vom DHCP-Server.',
  ),
  tabelle(
    'i3-bc-4',
    'b-cli',
    scenario:
        'Für das Wiki der IT-Abteilung entsteht eine Gegenüberstellung der wichtigsten Befehle.',
    prompt: 'Ergänze die fehlenden Befehle.',
    zeilen: [
      ['Aufgabe', 'Windows', 'Linux'],
      [
        'Verzeichnisinhalt anzeigen',
        'dir',
        wort(['ls', 'ls -l']),
      ],
      [
        'Datei kopieren',
        wort(['copy']),
        'cp',
      ],
      [
        'Datei löschen',
        'del',
        wort(['rm']),
      ],
      [
        'Weg der Pakete verfolgen',
        wort(['tracert']),
        'traceroute',
      ],
      [
        'IP-Konfiguration anzeigen',
        wort(['ipconfig', 'ipconfig /all']),
        'ip a',
      ],
    ],
    punkte: 5,
    explanation:
        'dir - ls, copy - cp, del - rm, tracert - traceroute, ipconfig - ip a. Je richtigem Befehl 1 Punkt.',
  ),
  lueckentext(
    'i3-bc-5',
    'b-cli',
    scenario: 'Die Hilfe des Befehls ping zeigt unter Windows diese Optionen.',
    code:
        'Options:\n'
        '  -t        Ping the specified host\n'
        '            until stopped.\n'
        '  -n count  Number of echo requests\n'
        '            to send.\n'
        '  -4        Force using IPv4.\n'
        '  -6        Force using IPv6.',
    prompt: 'Vervollständige die Aussagen anhand der Hilfe.',
    text:
        'Um ein Ziel so lange anzupingen, bis man abbricht, nutzt man die Option {0}. '
        'Genau 10 Anfragen sendet ping {1} 10 ziel. '
        'Soll der Test über IPv6 laufen, ergänzt man {2}.',
    luecken: [
      wahl('-t', ['-n', '-4', '-6']),
      wahl('-n', ['-t', '-4', '-6']),
      wahl('-6', ['-4', '-t', '-n']),
    ],
    punkte: 3,
    explanation:
        '„until stopped“ = bis zum Abbruch: -t. „Number of echo requests“ = Anzahl der Anfragen: -n. „Force using IPv6“ = IPv6 erzwingen: -6.',
    tags: ['englisch'],
    difficulty: 1,
  ),

  // ========================================================= Updates und Härtung
  freitext(
    'i3-bh-1',
    'b-haertung',
    scenario:
        'Ein frisch installierter Linux-Server soll als Webserver im Internet erreichbar sein.',
    prompt:
        'Beschreibe drei Maßnahmen, mit denen du den Server vor der Inbetriebnahme härtest.',
    kriterien: [
      krit(
        'Nicht benötigte Dienste und Programme abschalten oder deinstallieren - weniger Angriffsfläche',
        punkte: 2,
        stichwoerter: [
          'Dienste',
          'deinstallieren',
          'abschalten',
          'deaktivieren',
        ],
      ),
      krit(
        'Alle Sicherheitsupdates einspielen und automatische Updates einrichten',
        punkte: 2,
        stichwoerter: ['Update', 'Patch', 'aktualisieren'],
      ),
      krit(
        'Firewall einrichten: nur benötigte Ports öffnen',
        punkte: 2,
        stichwoerter: ['Firewall', 'Ports schließen', 'Port', 'Paketfilter'],
      ),
      krit(
        'Standardpasswörter ändern, starke Passwörter oder Schlüssel-Anmeldung, kein direkter root-Login',
        punkte: 2,
        stichwoerter: [
          'Passwort',
          'Standardpasswort',
          'root',
          'Schlüssel',
          'SSH-Key',
        ],
      ),
      krit(
        'Rechte nach dem Minimalprinzip vergeben, Dienste mit eingeschränktem Konto betreiben',
        punkte: 2,
        stichwoerter: ['Rechte', 'Minimalprinzip', 'Least Privilege'],
      ),
    ],
    punkte: 6,
    loesung:
        'Nicht benötigte Dienste abschalten oder deinstallieren, damit weniger angreifbar ist. Alle Sicherheitsupdates einspielen und künftige Updates zeitnah installieren. Die Firewall so einstellen, dass nur die benötigten Ports (hier 443, für die Verwaltung 22) offen sind. Außerdem Standardpasswörter ändern und den direkten root-Login per SSH verbieten.',
    explanation:
        'Bewertung: 2 Punkte je beschriebener Maßnahme, höchstens 6 Punkte. Härten heißt: die Angriffsfläche verkleinern.',
  ),
  markieren(
    'i3-bh-2',
    'b-haertung',
    scenario:
        'Auf einem Webserver, der nur HTTPS ausliefern und per SSH verwaltet werden soll, zeigt ss -tulpen diese lauschenden Dienste.',
    prompt: 'Markiere alle Dienste, die abgeschaltet werden sollten.',
    mono: true,
    zeilen: [
      nein('tcp 0.0.0.0:22   sshd', 'SSH wird für die Verwaltung gebraucht.'),
      ja(
        'tcp 0.0.0.0:23   telnetd',
        'Telnet überträgt unverschlüsselt und wird nicht benötigt.',
      ),
      ja(
        'tcp 0.0.0.0:21   vsftpd',
        'FTP überträgt im Klartext und gehört nicht zur Aufgabe des Servers.',
      ),
      nein('tcp 0.0.0.0:443  nginx', 'Das ist der HTTPS-Webdienst.'),
      ja(
        'tcp 0.0.0.0:3389 xrdp',
        'Ein Remotedesktop ist auf dem Webserver nicht vorgesehen.',
      ),
    ],
    explanation:
        'Gebraucht werden nur SSH (22) und HTTPS (443). Telnet (23), FTP (21) und der Remotedesktop (3389) vergrößern die Angriffsfläche und werden abgeschaltet.',
  ),
  lueckentext(
    'i3-bh-3',
    'b-haertung',
    scenario:
        'Die IT-Abteilung beschreibt ihr Vorgehen beim Einspielen von Updates in einer Arbeitsanweisung.',
    prompt: 'Vervollständige die Aussagen zum Patchmanagement.',
    text:
        'Sicherheitsupdates schließen bekannte {0}. '
        'Vor der Verteilung an alle werden Updates auf einem {1} geprüft. '
        'Ein vorher erstellter {2} erlaubt die Rückkehr zum alten Stand. '
        'Ein System ohne Herstellersupport ist {3} und erhält keine Updates mehr.',
    luecken: [
      wort(['Schwachstellen']),
      wort(['Testsystem']),
      wort(['Snapshot']),
      wort(['End of Life']),
    ],
    wortbank: ['Lizenzen', 'Produktivsystem', 'Open Source'],
    punkte: 4,
    explanation:
        'Updates schließen Schwachstellen. Getestet wird vorab auf einem Testsystem; Backup oder Snapshot ermöglichen den Rollback. End-of-Life-Systeme bekommen keine Updates und müssen abgelöst oder isoliert werden.',
  ),
  freitext(
    'i3-bh-4',
    'b-haertung',
    scenario:
        'Eine neue Netzwerkkamera wird laut Handbuch mit dem Benutzer „admin“ und dem Passwort „admin“ ausgeliefert.',
    prompt:
        'Erläutere das Risiko und beschreibe eine Maßnahme bei der Inbetriebnahme.',
    kriterien: [
      krit(
        'Standardpasswörter sind öffentlich bekannt (Handbuch, Internet) - Angreifer können sich ohne Aufwand anmelden',
        punkte: 2,
        stichwoerter: [
          'bekannt',
          'Handbuch',
          'öffentlich',
          'Angreifer',
          'erraten',
        ],
      ),
      krit(
        'Vor der Inbetriebnahme ein eigenes, starkes Passwort setzen',
        punkte: 2,
        stichwoerter: [
          'Passwort ändern',
          'eigenes Passwort',
          'neues Passwort',
          'starkes Passwort',
        ],
      ),
      krit(
        'Firmware aktualisieren und nicht benötigte Dienste abschalten',
        punkte: 2,
        stichwoerter: ['Firmware', 'Update', 'Dienste abschalten'],
      ),
    ],
    punkte: 4,
    loesung:
        'Standardzugangsdaten stehen im Handbuch und sind im Internet zu finden. Bleiben sie unverändert, kann sich jeder im Netz an der Kamera anmelden, das Bild ansehen oder das Gerät für Angriffe missbrauchen. Deshalb wird vor der Inbetriebnahme ein eigenes, starkes Passwort vergeben; zusätzlich wird die Firmware aktualisiert.',
    explanation:
        'Bewertung: 2 Punkte für das Risiko, 2 Punkte für eine Maßnahme - höchstens 4 Punkte.',
  ),

  // =============================================================== ERP, SCM, CRM
  freitext(
    'i3-au-1',
    'an-unternehmen',
    scenario:
        'Ein Großhändler arbeitet mit getrennten Programmen für Einkauf, Lager und Buchhaltung. Kundendaten werden in jedem Programm einzeln gepflegt. Die Geschäftsführung erwägt ein ERP-System.',
    prompt:
        'Erläutere zwei Vorteile eines ERP-Systems gegenüber den bisherigen Einzellösungen.',
    kriterien: [
      krit(
        'Gemeinsame Datenbasis: Daten werden nur einmal erfasst, keine doppelte Pflege und keine Widersprüche',
        punkte: 2,
        stichwoerter: [
          'gemeinsame Datenbasis',
          'einmal erfasst',
          'doppelte',
          'Redundanz',
          'zentrale Daten',
        ],
      ),
      krit(
        'Durchgängige Abläufe: Ein Auftrag läuft ohne Medienbruch durch Vertrieb, Lager und Buchhaltung',
        punkte: 2,
        stichwoerter: [
          'durchgängig',
          'Medienbruch',
          'Prozess',
          'Ablauf',
          'automatisch',
        ],
      ),
      krit(
        'Aktuelle Auswertungen über alle Bereiche, bessere Entscheidungsgrundlage',
        punkte: 2,
        stichwoerter: [
          'Auswertung',
          'Überblick',
          'Transparenz',
          'Kennzahlen',
          'aktuell',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Alle Bereiche arbeiten auf einer gemeinsamen Datenbasis: Kundendaten werden nur einmal gepflegt, Widersprüche entfallen. Ein Auftrag läuft durchgängig vom Vertrieb über das Lager bis zur Rechnung, ohne dass Daten neu eingetippt werden. Außerdem sind bereichsübergreifende Auswertungen jederzeit aktuell.',
    explanation:
        'Bewertung: 2 Punkte je erläutertem Vorteil, höchstens 4 Punkte. Dem stehen hohe Einführungskosten und Schulungsaufwand gegenüber.',
  ),
  tabelle(
    'i3-au-2',
    'an-unternehmen',
    scenario:
        'Die Fachabteilungen eines Händlers melden ihre Anforderungen an neue Software.',
    prompt: 'Wähle zu jeder Anforderung das passende System.',
    zeilen: [
      ['Anforderung', 'System'],
      [
        'Alle Kontakte und Angebote zu einem Kunden auf einen Blick',
        wahl('CRM', ['SCM', 'DMS', 'BI']),
      ],
      [
        'Liefermengen und Termine mit Zulieferern abstimmen',
        wahl('SCM', ['CRM', 'DMS', 'BI']),
      ],
      [
        'Einkauf, Lager und Buchhaltung auf gemeinsamer Datenbasis',
        wahl('ERP', ['CRM', 'DMS', 'BI']),
      ],
      [
        'Verträge revisionssicher ablegen und wiederfinden',
        wahl('DMS', ['CRM', 'SCM', 'ERP']),
      ],
      [
        'Umsatzzahlen aus mehreren Quellen im Dashboard auswerten',
        wahl('BI', ['DMS', 'SCM', 'CRM']),
      ],
    ],
    punkte: 5,
    explanation:
        'CRM verwaltet Kundenbeziehungen, SCM die Lieferkette, ERP integriert die Unternehmensbereiche, ein DMS legt Dokumente ab, BI wertet Daten aus.',
  ),
  paare(
    'i3-au-3',
    'an-unternehmen',
    scenario:
        'Ein Händler führt ein ERP-System ein und legt fest, welche Abteilung welches Modul nutzt.',
    prompt: 'Ordne jedem ERP-Modul seine Aufgabe zu.',
    paare: [
      paar('Vertrieb', 'Angebote und Aufträge erfassen'),
      paar('Einkauf', 'Ware bei Lieferanten bestellen'),
      paar('Lagerwirtschaft', 'Bestände führen'),
      paar('Finanzbuchhaltung', 'Rechnungen und Zahlungen buchen'),
      paar('Personalwesen', 'Gehälter und Arbeitszeiten verwalten'),
    ],
    explanation:
        'Ein ERP-System besteht aus Modulen für die Unternehmensbereiche. Alle greifen auf dieselbe Datenbank zu: Der Auftrag aus dem Vertrieb senkt den Lagerbestand und erzeugt die Rechnung in der Buchhaltung.',
    difficulty: 1,
  ),

  // ================================================== Standard- oder Individualsoftware
  tabelle(
    'i3-as-1',
    'an-software',
    scenario:
        'Für ein neues Ticketsystem werden zwei Produkte per Nutzwertanalyse verglichen. Die Fachabteilung hat Punkte von 1 bis 10 vergeben.',
    table: [
      ['Kriterium', 'Gewicht', 'Produkt A', 'Produkt B'],
      ['Kosten', '40 %', '7', '9'],
      ['Funktionsumfang', '35 %', '8', '6'],
      ['Support', '25 %', '6', '8'],
    ],
    prompt:
        'Berechne die gewichteten Punkte und die Nutzwerte beider Produkte.',
    zeilen: [
      ['Kriterium', 'A gewichtet', 'B gewichtet'],
      ['Kosten', '2,8', zahl(3.6, toleranz: 0.001)],
      [
        'Funktionsumfang',
        zahl(2.8, toleranz: 0.001),
        zahl(2.1, toleranz: 0.001),
      ],
      ['Support', zahl(1.5, toleranz: 0.001), zahl(2.0, toleranz: 0.001)],
      ['Nutzwert', zahl(7.1, toleranz: 0.001), zahl(7.7, toleranz: 0.001)],
    ],
    punkte: 6,
    explanation:
        'Gewichtete Punkte = Gewicht × Punkte. A: 0,4 × 7 = 2,8; 0,35 × 8 = 2,8; 0,25 × 6 = 1,5; Summe 7,1. B: 0,4 × 9 = 3,6; 0,35 × 6 = 2,1; 0,25 × 8 = 2,0; Summe 7,7. Produkt B hat den höheren Nutzwert.',
  ),
  freitext(
    'i3-as-2',
    'an-software',
    scenario:
        'Ein Maschinenbauer braucht eine Software für seine Ersatzteilverwaltung und schwankt zwischen einem fertigen Produkt und einer Eigenentwicklung.',
    prompt:
        'Nenne je zwei Vorteile von Standardsoftware und von Individualsoftware.',
    kriterien: [
      krit(
        'Standardsoftware: sofort verfügbar',
        stichwoerter: ['sofort', 'schnell verfügbar', 'schnell einsetzbar'],
      ),
      krit(
        'Standardsoftware: günstiger, weil sich die Entwicklungskosten auf viele Kunden verteilen',
        stichwoerter: [
          'günstiger',
          'billiger',
          'geringere Kosten',
          'preiswert',
        ],
      ),
      krit(
        'Standardsoftware: erprobt, mit Updates und Support vom Hersteller',
        stichwoerter: ['erprobt', 'Updates', 'Support', 'ausgereift'],
      ),
      krit(
        'Individualsoftware: genau auf die eigenen Abläufe zugeschnitten',
        stichwoerter: [
          'zugeschnitten',
          'passgenau',
          'eigene Abläufe',
          'maßgeschneidert',
          'angepasst',
        ],
      ),
      krit(
        'Individualsoftware: keine Abhängigkeit vom Produktplan eines Herstellers, Quellcode im eigenen Besitz',
        stichwoerter: [
          'Quellcode',
          'unabhängig',
          'Abhängigkeit',
          'eigene Kontrolle',
        ],
      ),
      krit(
        'Individualsoftware: möglicher Wettbewerbsvorteil, keine unnötigen Funktionen',
        stichwoerter: [
          'Wettbewerbsvorteil',
          'keine unnötigen Funktionen',
          'Alleinstellung',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Standardsoftware ist sofort verfügbar und günstiger, weil viele Kunden die Entwicklung bezahlen; sie ist erprobt und wird vom Hersteller gepflegt. Individualsoftware passt genau zu den eigenen Abläufen, und der Auftraggeber bestimmt selbst über Funktionen und Weiterentwicklung.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte (je zwei pro Softwareart). Individualsoftware ist dafür teurer und erst nach der Entwicklung verfügbar.',
    difficulty: 1,
  ),
  rechnen(
    'i3-as-3',
    'an-software',
    scenario:
        'Eine Individualsoftware kostet einmalig 42.000 € und danach 4.000 € Wartung pro Jahr. Eine vergleichbare Standardsoftware kostet 9.600 € Miete pro Jahr.',
    prompt:
        'Ermittle, nach wie vielen vollen Jahren die Individualsoftware erstmals insgesamt günstiger ist.',
    answer: 8,
    unit: 'Jahre',
    punkte: 4,
    explanation:
        'Gleichstand: 42.000 + 4.000 × n = 9.600 × n, also 42.000 = 5.600 × n und n = 7,5. Nach 7 Jahren: 70.000 € gegen 67.200 € - noch teurer. Nach 8 Jahren: 74.000 € gegen 76.800 € - erstmals günstiger.',
    difficulty: 3,
  ),
  paare(
    'i3-as-4',
    'an-software',
    scenario:
        'Im Lastenheft für eine neue Software sollen die Begriffe einheitlich verwendet werden.',
    prompt: 'Ordne jedem Begriff die passende Beschreibung zu.',
    paare: [
      paar('Standardsoftware', 'für viele Kunden entwickelt'),
      paar('Individualsoftware', 'für einen Auftraggeber entwickelt'),
      paar('Branchensoftware', 'Standardsoftware für eine Branche'),
      paar('Customizing', 'Anpassen über Einstellungen'),
      paar('Modifikation', 'Eingriff in den Programmcode'),
    ],
    explanation:
        'Standardsoftware wird für den Markt gebaut, Branchensoftware für eine bestimmte Branche, Individualsoftware für einen Kunden. Customizing nutzt vorgesehene Einstellungen und übersteht Updates; Modifikationen am Code müssen nach jedem Release neu eingebaut werden.',
  ),

  // ============================================================== Lizenzmodelle
  tabelle(
    'i3-al-1',
    'an-lizenzen',
    scenario:
        'Eine Planungssoftware soll von 40 Beschäftigten genutzt werden, davon arbeiten höchstens 15 gleichzeitig damit. Installiert wird sie auf 25 PCs. Der Hersteller bietet drei Lizenzmodelle an.',
    table: [
      ['Modell', 'Preis je Lizenz'],
      ['Named User', '120 €'],
      ['Concurrent User', '290 €'],
      ['Gerätelizenz', '180 €'],
    ],
    prompt:
        'Ermittle je Modell die Anzahl der benötigten Lizenzen und die Kosten.',
    zeilen: [
      ['Modell', 'Anzahl', 'Kosten in €'],
      ['Named User', zahl(40), zahl(4800)],
      ['Concurrent User', zahl(15), zahl(4350)],
      ['Gerätelizenz', zahl(25), zahl(4500)],
    ],
    punkte: 6,
    explanation:
        'Named User: jede berechtigte Person - 40 × 120 € = 4.800 €. Concurrent User: gleichzeitige Nutzung - 15 × 290 € = 4.350 €. Gerätelizenz: je PC - 25 × 180 € = 4.500 €. Am günstigsten ist hier Concurrent User.',
  ),
  freitext(
    'i3-al-2',
    'an-lizenzen',
    scenario:
        'Für die E-Mail-Arbeitsplätze einer Kanzlei stehen ein Open-Source-Programm und ein proprietäres Produkt zur Wahl.',
    prompt:
        'Nenne je zwei Vorteile von Open-Source-Software und von proprietärer Software.',
    kriterien: [
      krit(
        'Open Source: keine Lizenzkosten',
        stichwoerter: ['keine Lizenzkosten', 'kostenlos', 'lizenzkostenfrei'],
      ),
      krit(
        'Open Source: Quellcode einsehbar und anpassbar',
        stichwoerter: ['Quellcode', 'einsehbar', 'anpassbar', 'offen'],
      ),
      krit(
        'Open Source: keine Bindung an einen Hersteller',
        stichwoerter: ['Herstellerbindung', 'unabhängig', 'Abhängigkeit'],
      ),
      krit(
        'Proprietär: Support und Gewährleistung durch den Hersteller',
        stichwoerter: ['Support', 'Gewährleistung', 'Ansprechpartner'],
      ),
      krit(
        'Proprietär: geregelte Updates, klare Verantwortlichkeit',
        stichwoerter: ['Updates', 'Verantwortung', 'geregelt', 'Wartung'],
      ),
      krit(
        'Proprietär: oft gute Integration in andere Produkte des Herstellers',
        stichwoerter: ['Integration', 'integriert', 'aus einer Hand'],
      ),
    ],
    punkte: 4,
    loesung:
        'Open Source: keine Lizenzkosten, der Quellcode ist einsehbar und anpassbar, man ist nicht an einen Hersteller gebunden. Proprietär: Support und Gewährleistung vom Hersteller, geregelte Updates und meist gute Integration in dessen übrige Produkte.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte (je zwei pro Seite). Open Source heißt nicht „ohne Regeln“ - auch diese Lizenzen stellen Bedingungen.',
    difficulty: 1,
  ),
  markieren(
    'i3-al-3',
    'an-lizenzen',
    scenario:
        'Vor dem Kauf einer Zeichensoftware prüfst du den englischen Lizenzvertrag.',
    code:
        'License Agreement (excerpt)\n'
        '1. This license is granted per named user.\n'
        '2. Each user may install the software\n'
        '   on up to two devices.\n'
        '3. The license is a 12-month subscription\n'
        '   and renews automatically.\n'
        '4. Transfer to third parties is\n'
        '   not permitted.',
    prompt: 'Markiere alle Aussagen, die laut Vertrag zutreffen.',
    zeilen: [
      ja(
        'Lizenziert wird jede namentlich benannte Person.',
        '„per named user“ - Punkt 1.',
      ),
      ja(
        'Eine Person darf die Software auf zwei Geräten installieren.',
        '„on up to two devices“ - Punkt 2.',
      ),
      nein(
        'Die Lizenz wird einmal gekauft und gilt unbefristet.',
        'Es ist ein Abonnement über 12 Monate - Punkt 3.',
      ),
      ja(
        'Ohne Kündigung verlängert sich die Lizenz von selbst.',
        '„renews automatically“ - Punkt 3.',
      ),
      nein(
        'Nicht mehr benötigte Lizenzen dürfen weiterverkauft werden.',
        'Die Weitergabe an Dritte ist ausgeschlossen - Punkt 4.',
      ),
      nein(
        'Gezählt werden die gleichzeitig angemeldeten Personen.',
        'Das wäre Concurrent User - hier gilt Named User.',
      ),
    ],
    explanation:
        'Der Vertrag beschreibt ein Named-User-Abonnement: je Person bis zu zwei Geräte, Laufzeit 12 Monate mit automatischer Verlängerung, keine Weitergabe an Dritte.',
    tags: ['englisch'],
  ),
  paare(
    'i3-al-4',
    'an-lizenzen',
    scenario:
        'Bei einer Inventur der Softwarelizenzen tauchen verschiedene Lizenzarten auf.',
    prompt: 'Ordne jeder Lizenz ihr Merkmal zu.',
    paare: [
      paar('GPL', 'Änderungen müssen offengelegt werden'),
      paar('MIT-Lizenz', 'nur der Lizenzhinweis ist Pflicht'),
      paar('OEM-Lizenz', 'an ein Gerät gebunden'),
      paar('Abonnement', 'Nutzung nur während der Laufzeit'),
      paar('Volumenlizenz', 'viele Installationen, ein Vertrag'),
    ],
    explanation:
        'Die GPL hat ein starkes Copyleft, die MIT-Lizenz verlangt nur den Lizenzhinweis. OEM-Lizenzen gehören zu einem Gerät, Abonnements enden mit der Laufzeit, Volumenlizenzen bündeln viele Installationen.',
  ),

  // ====================================== Kollaboration und Social Media
  freitext(
    'i3-ak-1',
    'an-kollaboration',
    scenario:
        'Mehrere Teams eines Betriebs nutzen ohne Wissen der IT-Abteilung private Cloudspeicher und Messenger, um Projektdateien auszutauschen.',
    prompt:
        'Erläutere zwei Risiken dieser Schatten-IT und nenne eine Gegenmaßnahme.',
    kriterien: [
      krit(
        'Datenschutz: personenbezogene Daten liegen bei Anbietern ohne Vertrag zur Auftragsverarbeitung',
        punkte: 2,
        stichwoerter: [
          'Datenschutz',
          'DSGVO',
          'Auftragsverarbeitung',
          'personenbezogen',
        ],
      ),
      krit(
        'Datensicherheit: keine Kontrolle über Zugriffe, Sicherung und Löschung; Firmendaten können abfließen',
        punkte: 2,
        stichwoerter: [
          'Kontrolle',
          'Datenabfluss',
          'Sicherung',
          'Backup',
          'Zugriff',
        ],
      ),
      krit(
        'Daten bleiben beim Ausscheiden von Beschäftigten in deren privaten Konten',
        punkte: 2,
        stichwoerter: ['privates Konto', 'Ausscheiden', 'private Konten'],
      ),
      krit(
        'Gegenmaßnahme: geprüfte offizielle Werkzeuge bereitstellen, klare Regeln und Schulung',
        stichwoerter: [
          'offizielle',
          'Richtlinie',
          'Regeln',
          'Schulung',
          'bereitstellen',
          'Alternative',
        ],
      ),
    ],
    punkte: 5,
    loesung:
        'Die Daten liegen bei Anbietern, mit denen kein Vertrag zur Auftragsverarbeitung besteht - ein Datenschutzverstoß. Die IT hat keine Kontrolle über Zugriffsrechte, Sicherung und Löschung; verlässt jemand die Firma, bleiben die Daten in seinem privaten Konto. Gegenmaßnahme: ein geprüftes, komfortables Werkzeug offiziell bereitstellen und die Nutzung per Richtlinie und Schulung regeln.',
    explanation:
        'Bewertung: 2 Punkte je erläutertem Risiko, 1 Punkt für die Gegenmaßnahme - höchstens 5 Punkte.',
  ),
  tabelle(
    'i3-ak-2',
    'an-kollaboration',
    scenario:
        'Ein Projektteam arbeitet an drei Standorten. Für jede Situation soll das am besten geeignete Werkzeug festgelegt werden.',
    prompt: 'Wähle zu jeder Situation das passende Werkzeug.',
    zeilen: [
      ['Situation', 'Werkzeug'],
      [
        'Wöchentliche Abstimmung aller Standorte mit Bildschirmfreigabe',
        wahl('Videokonferenz', ['Wiki', 'E-Mail', 'Ticketsystem']),
      ],
      [
        'Dauerhaft nachlesbare Anleitungen und Projektwissen',
        wahl('Wiki', ['Videokonferenz', 'Chat', 'Telefon']),
      ],
      [
        'Kurze Rückfrage an eine Kollegin, Antwort in wenigen Minuten',
        wahl('Chat', ['Wiki', 'Ticketsystem', 'Brief']),
      ],
      [
        'Störungsmeldungen erfassen, zuweisen und nachverfolgen',
        wahl('Ticketsystem', ['Chat', 'Videokonferenz', 'Wiki']),
      ],
      [
        'Mehrere Personen schreiben gleichzeitig am selben Bericht',
        wahl('gemeinsames Online-Dokument', [
          'E-Mail-Anhang',
          'Telefon',
          'Ticketsystem',
        ]),
      ],
    ],
    punkte: 5,
    explanation:
        'Videokonferenz für die gleichzeitige Abstimmung, Wiki für dauerhaftes Wissen, Chat für schnelle Rückfragen, Ticketsystem für nachvollziehbare Vorgänge, gemeinsames Dokument statt vieler Fassungen im E-Mail-Anhang.',
    difficulty: 1,
  ),
  lueckentext(
    'i3-ak-3',
    'an-kollaboration',
    scenario:
        'Für das Onboarding neuer Beschäftigter entsteht ein Merkblatt zur Zusammenarbeit.',
    prompt: 'Vervollständige die Aussagen zur Zusammenarbeit.',
    text:
        'Arbeiten alle Beteiligten zur selben Zeit zusammen, heißt das {0}. '
        'Eine E-Mail oder ein Wiki-Beitrag ist dagegen {1}. '
        'Werden Telefonie, Chat und Video in einer Oberfläche gebündelt, spricht man von {2}. '
        'Für personenbezogene Daten bei einem Cloud-Anbieter braucht es einen Vertrag zur {3}.',
    luecken: [
      wort(['synchron']),
      wort(['asynchron']),
      wort(['Unified Communications']),
      wort(['Auftragsverarbeitung']),
    ],
    wortbank: ['Schatten-IT', 'Lizenzprüfung', 'Customizing'],
    punkte: 4,
    explanation:
        'Synchron = gleichzeitig (Telefon, Videokonferenz), asynchron = zeitversetzt (E-Mail, Wiki). Unified Communications bündelt die Kanäle. Verarbeitet ein Anbieter personenbezogene Daten, verlangt die DSGVO einen Vertrag zur Auftragsverarbeitung.',
  ),

  // ============================================================ OSI und TCP/IP
  paare(
    'i3-no-1',
    'nw-modelle',
    scenario: 'Im Netzwerkschrank eines Kunden stehen verschiedene Geräte.',
    prompt: 'Ordne jedem Gerät die OSI-Schicht zu, auf der es arbeitet.',
    paare: [
      paar('Hub, Repeater', 'Schicht 1 - Bitübertragung'),
      paar('Switch', 'Schicht 2 - Sicherung'),
      paar('Router', 'Schicht 3 - Vermittlung'),
      paar('Paketfilter mit Portregeln', 'Schicht 4 - Transport'),
      paar('Proxy für Webseiten', 'Schicht 7 - Anwendung'),
    ],
    explanation:
        'Hub und Repeater verstärken nur Signale (1), der Switch arbeitet mit MAC-Adressen (2), der Router mit IP-Adressen (3). Portregeln betreffen die Transportschicht (4), ein Web-Proxy versteht das Anwendungsprotokoll (7).',
  ),
  tabelle(
    'i3-no-2',
    'nw-modelle',
    scenario:
        'Bei der Fehlersuche hilft es, Adressen und Dateneinheiten den OSI-Schichten zuordnen zu können. Die Zeile für Schicht 7 ist als Beispiel ausgefüllt.',
    prompt: 'Ergänze die Tabelle.',
    zeilen: [
      ['Schicht', 'Name', 'Adresse', 'Dateneinheit'],
      ['7', 'Anwendung', '-', 'Daten'],
      [
        '4',
        wahl('Transport', ['Vermittlung', 'Sicherung', 'Sitzung']),
        wahl('Portnummer', ['IP-Adresse', 'MAC-Adresse']),
        wahl('Segment', ['Paket', 'Frame']),
      ],
      [
        '3',
        wahl('Vermittlung', ['Transport', 'Sicherung', 'Darstellung']),
        wahl('IP-Adresse', ['Portnummer', 'MAC-Adresse']),
        wahl('Paket', ['Segment', 'Frame']),
      ],
      [
        '2',
        wahl('Sicherung', ['Vermittlung', 'Transport', 'Bitübertragung']),
        wahl('MAC-Adresse', ['IP-Adresse', 'Portnummer']),
        wahl('Frame', ['Paket', 'Segment']),
      ],
    ],
    punkte: 6,
    explanation:
        'Schicht 4 Transport: Ports, Segmente. Schicht 3 Vermittlung: IP-Adressen, Pakete. Schicht 2 Sicherung: MAC-Adressen, Frames. Schicht 1 überträgt nur noch Bits.',
  ),
  freitext(
    'i3-no-3',
    'nw-modelle',
    scenario:
        'Ein Softwarehaus entwickelt eine Anwendung mit Dateiübertragung und Sprachchat und muss für beides ein Transportprotokoll wählen.',
    prompt: 'Beschreibe zwei Unterschiede zwischen TCP und UDP.',
    kriterien: [
      krit(
        'TCP baut eine Verbindung auf (Drei-Wege-Handshake), UDP sendet verbindungslos',
        punkte: 2,
        stichwoerter: [
          'verbindungsorientiert',
          'verbindungslos',
          'Handshake',
          'Verbindungsaufbau',
        ],
      ),
      krit(
        'TCP sichert die Übertragung: Bestätigungen, erneutes Senden, richtige Reihenfolge - UDP nicht',
        punkte: 2,
        stichwoerter: [
          'Bestätigung',
          'zuverlässig',
          'erneut senden',
          'Reihenfolge',
          'gesichert',
        ],
      ),
      krit(
        'UDP hat weniger Overhead und Verzögerung - geeignet für Echtzeit wie Sprache und Video',
        punkte: 2,
        stichwoerter: [
          'Overhead',
          'schneller',
          'Echtzeit',
          'Verzögerung',
          'Streaming',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'TCP ist verbindungsorientiert: Vor den Daten wird per Drei-Wege-Handshake eine Verbindung aufgebaut, UDP sendet ohne Verbindungsaufbau. TCP bestätigt den Empfang, sendet Verlorenes erneut und stellt die Reihenfolge sicher; UDP verzichtet darauf, ist dafür schlanker und schneller. Deshalb passt TCP zur Dateiübertragung und UDP zum Sprachchat.',
    explanation:
        'Bewertung: 2 Punkte je beschriebenem Unterschied, höchstens 4 Punkte.',
  ),
  markieren(
    'i3-no-4',
    'nw-modelle',
    scenario:
        'In einem Mitschnitt des Netzverkehrs tauchen verschiedene Protokolle auf.',
    prompt: 'Markiere alle Protokolle, die zur Anwendungsschicht gehören.',
    zeilen: [
      ja('HTTPS', 'Überträgt Webseiten - Anwendungsschicht.'),
      nein('TCP', 'Transportschicht.'),
      ja('DNS', 'Namensauflösung - Anwendungsschicht.'),
      nein('IP', 'Vermittlungsschicht.'),
      ja('SMTP', 'E-Mail-Versand - Anwendungsschicht.'),
      nein('Ethernet', 'Sicherungs- und Bitübertragungsschicht.'),
      nein('UDP', 'Transportschicht.'),
    ],
    explanation:
        'HTTPS, DNS und SMTP sind Anwendungsprotokolle. TCP und UDP arbeiten auf der Transportschicht, IP auf der Vermittlungsschicht, Ethernet darunter.',
    difficulty: 1,
  ),

  // =============================================== Netzwerkgeräte und Verkabelung
  rechnen(
    'i3-ng-1',
    'nw-geraete',
    scenario:
        'An den folgenden Switch sollen 4 Kameras mit je 12 W und 3 Access Points mit je 21 W angeschlossen werden.',
    code:
        'PoE Switch GS-1208P - Datasheet\n'
        'Ports: 8x 1 Gbit/s RJ45 (PoE+)\n'
        'PoE standard: IEEE 802.3af/at\n'
        'Max. power per port: 30 W\n'
        'Total PoE budget: 120 W',
    prompt:
        'Berechne, wie viel Watt des PoE-Budgets nach dem Anschluss aller Geräte noch frei sind.',
    answer: 9,
    unit: 'W',
    punkte: 3,
    explanation:
        'Kameras: 4 × 12 W = 48 W. Access Points: 3 × 21 W = 63 W. Summe: 111 W. Das Gesamtbudget („Total PoE budget“) beträgt 120 W - frei bleiben 120 W - 111 W = 9 W. Je Port sind 30 W erlaubt, das reicht für jedes Gerät.',
    tags: ['englisch', 'datenblatt'],
  ),
  tabelle(
    'i3-ng-2',
    'nw-geraete',
    scenario:
        'Für mehrere Geräte soll der kleinste PoE-Standard bestimmt werden, der die benötigte Leistung liefert.',
    table: [
      ['Standard', 'Leistung am Switch-Port'],
      ['IEEE 802.3af', 'bis 15,4 W'],
      ['IEEE 802.3at', 'bis 30 W'],
      ['IEEE 802.3bt', 'bis 90 W'],
    ],
    prompt: 'Wähle zu jedem Gerät den kleinsten ausreichenden Standard.',
    zeilen: [
      ['Gerät', 'Bedarf', 'Standard'],
      [
        'IP-Telefon',
        '6 W',
        wahl('IEEE 802.3af', ['IEEE 802.3at', 'IEEE 802.3bt']),
      ],
      [
        'Access Point',
        '22 W',
        wahl('IEEE 802.3at', ['IEEE 802.3af', 'IEEE 802.3bt']),
      ],
      [
        'Schwenkkamera mit Heizung',
        '55 W',
        wahl('IEEE 802.3bt', ['IEEE 802.3af', 'IEEE 802.3at']),
      ],
      [
        'Türsprechstelle',
        '12 W',
        wahl('IEEE 802.3af', ['IEEE 802.3at', 'IEEE 802.3bt']),
      ],
    ],
    punkte: 4,
    explanation:
        '6 W und 12 W liegen unter 15,4 W - 802.3af genügt. 22 W übersteigt 15,4 W, passt aber in 30 W - 802.3at. 55 W braucht 802.3bt.',
  ),
  freitext(
    'i3-ng-3',
    'nw-geraete',
    scenario:
        'Im neuen Büro wird ein PC an die Netzwerkdose 3.07 angeschlossen. Die Link-LED bleibt dunkel, obwohl PC und Kabel an einer anderen Dose funktionieren. Im Verteilerschrank steckt am Patchfeld-Port 3.07 kein Kabel.',
    prompt:
        'Erläutere die Ursache und beschreibe, wie der Fehler behoben wird.',
    kriterien: [
      krit(
        'Die Dose ist über das Verlegekabel nur mit dem Patchfeld-Port verbunden; dieser ist nicht mit dem Switch verbunden (nicht gepatcht)',
        punkte: 2,
        stichwoerter: [
          'nicht gepatcht',
          'Patchfeld',
          'kein Patchkabel',
          'nicht mit dem Switch verbunden',
        ],
      ),
      krit(
        'Behebung: Patchkabel vom Patchfeld-Port 3.07 zu einem freien Switch-Port stecken (patchen lassen)',
        punkte: 2,
        stichwoerter: [
          'patchen',
          'Patchkabel stecken',
          'Switch-Port',
          'verbinden',
        ],
      ),
      krit(
        'Alternative: eine bereits gepatchte Dose nutzen',
        stichwoerter: ['andere Dose', 'gepatchte Dose', 'Dose wechseln'],
      ),
    ],
    punkte: 4,
    loesung:
        'Die Netzwerkdose ist über das fest verlegte Kabel nur mit dem Port 3.07 des Patchfelds verbunden. Weil dort kein Patchkabel zum Switch steckt, hat die Dose keine Verbindung ins Netz - sie ist nicht gepatcht. Behebung: Port 3.07 mit einem Patchkabel an einen freien Switch-Port anschließen (lassen) oder den PC an eine gepatchte Dose hängen.',
    explanation:
        'Bewertung: 2 Punkte für die Ursache, 2 Punkte für die Behebung - höchstens 4 Punkte.',
  ),
  markieren(
    'i3-ng-4',
    'nw-geraete',
    scenario:
        'Ein Büro soll auf einer 85 m langen Strecke mit 10 Gbit/s über Kupfer angebunden werden. Ein Lieferant schlägt die folgende Stückliste vor.',
    prompt:
        'Markiere alle Positionen, die für diese Anforderung ungeeignet sind.',
    zeilen: [
      nein(
        'Verlegekabel Cat 6A, geschirmt',
        '10 Gbit/s auf bis zu 100 m - passt.',
      ),
      ja(
        'Patchkabel Cat 5e',
        'Cat 5e schafft nur 1 Gbit/s und bremst die ganze Strecke.',
      ),
      nein('Patchfeld Cat 6A, 24 Ports', 'Passt zur Kategorie des Kabels.'),
      ja(
        '8-Port-Hub als Verteiler im Büro',
        'Hubs sind veraltet, teilen sich die Bandbreite und schaffen keine 10 Gbit/s.',
      ),
      nein('Netzwerkdosen Cat 6A', 'Passen zur Kategorie des Kabels.'),
      nein('Switch mit 10GBASE-T-Ports', 'Liefert die geforderte Datenrate.'),
    ],
    explanation:
        'Die Strecke ist nur so schnell wie ihr schwächstes Glied: Cat-5e-Patchkabel und ein Hub verhindern 10 Gbit/s. Alle Komponenten müssen mindestens Cat 6A entsprechen.',
  ),
  lueckentext(
    'i3-ng-5',
    'nw-geraete',
    scenario:
        'Für den Neubau eines Bürogebäudes wird die Netzwerkverkabelung geplant.',
    prompt: 'Vervollständige die Aussagen zur strukturierten Verkabelung.',
    text:
        'Der Primärbereich verbindet {0} miteinander. '
        'Der Sekundärbereich verbindet die {1} eines Gebäudes. '
        'Im Tertiärbereich führt das Kabel vom Etagenverteiler zur {2}. '
        'Das fest verlegte Kupferkabel darf dort höchstens {3} lang sein.',
    luecken: [
      wort(['Gebäude']),
      wort(['Etagen']),
      wort(['Netzwerkdose']),
      wort(['90 m']),
    ],
    wortbank: ['55 m', 'Server', 'Router'],
    punkte: 4,
    explanation:
        'Primär: zwischen Gebäuden (Glasfaser). Sekundär: zwischen den Etagen. Tertiär: vom Etagenverteiler bis zur Dose - 90 m fest verlegt, mit Patchkabeln zusammen höchstens 100 m.',
  ),

  // =========================================================== IPv4 und Subnetting
  lueckentext(
    'i3-n4-1',
    'nw-ipv4',
    scenario:
        'Ein Drucker hat die Adresse 192.168.20.77/26. Für die Dokumentation wird der Steckbrief seines Subnetzes gebraucht.',
    prompt: 'Ermittle die Werte des Subnetzes.',
    text:
        'Subnetzmaske: {0}\n'
        'Nutzbare Hostadressen: {1}\n'
        'Netzadresse: {2}\n'
        'Broadcastadresse: {3}\n'
        'Erste nutzbare Adresse: {4}\n'
        'Letzte nutzbare Adresse: {5}',
    luecken: [
      wort(['255.255.255.192'], '/26 = 24 + 2 Bit: 128 + 64 = 192'),
      zahl(62, rationale: '2⁶ - 2'),
      wort(['192.168.20.64'], 'Blockgröße 64: 77 liegt im Block 64 bis 127'),
      wort(['192.168.20.127'], 'letzte Adresse des Blocks'),
      wort(['192.168.20.65'], 'Netzadresse + 1'),
      wort(['192.168.20.126'], 'Broadcast - 1'),
    ],
    punkte: 6,
    explanation:
        '/26: Maske 255.255.255.192, Blockgröße 256 - 192 = 64, 2⁶ - 2 = 62 Hosts. Blöcke: 0, 64, 128, 192 - die 77 liegt im Block 64 bis 127. Netz .64, Broadcast .127, Hosts .65 bis .126.',
    tags: ['subnetting'],
  ),
  lueckentext(
    'i3-n4-2',
    'nw-ipv4',
    scenario:
        'Der Server einer Außenstelle hat die Adresse 10.10.8.200/25. Das Gateway erhält die letzte nutzbare Adresse, ein neuer Netzwerkdrucker die vorletzte.',
    prompt: 'Ermittle die Werte.',
    text:
        'Subnetzmaske: {0}\n'
        'Netzadresse: {1}\n'
        'Broadcastadresse: {2}\n'
        'Nutzbare Hostadressen: {3}\n'
        'Adresse des Druckers: {4}',
    luecken: [
      wort(['255.255.255.128'], '/25 = 24 + 1 Bit'),
      wort(['10.10.8.128'], 'Blockgröße 128: 200 liegt im Block 128 bis 255'),
      wort(['10.10.8.255'], 'letzte Adresse des Blocks'),
      zahl(126, rationale: '2⁷ - 2'),
      wort(['10.10.8.253'], 'letzte nutzbare ist .254, die vorletzte .253'),
    ],
    punkte: 5,
    explanation:
        '/25: Maske 255.255.255.128, Blockgröße 128, 2⁷ - 2 = 126 Hosts. Die 200 liegt im oberen Block: Netz 10.10.8.128, Broadcast 10.10.8.255. Letzte nutzbare Adresse .254 (Gateway), vorletzte .253 (Drucker).',
    tags: ['subnetting'],
    difficulty: 3,
  ),
  lueckentext(
    'i3-n4-3',
    'nw-ipv4',
    scenario:
        'Im Netz 172.16.4.0/27 soll ein neuer Netzwerkdrucker eine feste Adresse bekommen. Er erhält die letzte nutzbare Adresse des Netzes. Der Router ist das Standardgateway.',
    skizze: const NetzSkizze(
      [
        NetzKnoten('rt', 'Router .1', NetzTyp.router, 1.5, 0),
        NetzKnoten('sw', 'Switch', NetzTyp.switch_, 1.5, 1.5),
        NetzKnoten('pc', 'PC .10', NetzTyp.pc, 0.5, 3),
        NetzKnoten('dr', 'Drucker', NetzTyp.drucker, 2.5, 3),
      ],
      verbindungen: [
        NetzVerbindung('rt', 'sw'),
        NetzVerbindung('sw', 'pc'),
        NetzVerbindung('sw', 'dr'),
      ],
    ),
    prompt: 'Trage die IPv4-Konfiguration des Druckers ein.',
    text:
        'IP-Adresse: {0}\n'
        'Subnetzmaske: {1}\n'
        'Standardgateway: {2}',
    luecken: [
      wort(['172.16.4.30'], 'Broadcast ist .31, letzte nutzbare .30'),
      wort(['255.255.255.224'], '/27 = 24 + 3 Bit: 128 + 64 + 32'),
      wort(['172.16.4.1'], 'die Adresse des Routers'),
    ],
    punkte: 3,
    explanation:
        '/27: Maske 255.255.255.224, Blockgröße 32. Das Netz 172.16.4.0 reicht bis zum Broadcast 172.16.4.31; die letzte nutzbare Adresse ist 172.16.4.30. Das Gateway ist der Router mit 172.16.4.1.',
    tags: ['subnetting'],
  ),
  markieren(
    'i3-n4-4',
    'nw-ipv4',
    scenario:
        'Ein PC im Netz 192.168.50.0/24 erreicht weder andere Geräte noch das Internet. Das Gateway des Netzes hat die Adresse 192.168.50.1, der DNS-Server 192.168.50.10. Die Adresse wurde von Hand eingetragen.',
    prompt: 'Markiere die fehlerhaften Einträge der Konfiguration.',
    mono: true,
    zeilen: [
      ja(
        'IPv4-Adresse:    192.168.50.255',
        'Das ist die Broadcastadresse des Netzes - sie darf keinem Gerät gehören.',
      ),
      nein('Subnetzmaske:    255.255.255.0', 'Passt zu /24.'),
      ja(
        'Standardgateway: 192.168.5.1',
        'Liegt in einem anderen Netz - richtig wäre 192.168.50.1.',
      ),
      nein('DNS-Server:      192.168.50.10', 'Entspricht der Vorgabe.'),
      nein(
        'DHCP aktiviert:  Nein',
        'Die Adresse wurde bewusst von Hand vergeben.',
      ),
    ],
    explanation:
        'Zwei Fehler: Die Hostadresse ist die Broadcastadresse (.255), und das Gateway liegt mit 192.168.5.1 außerhalb des eigenen Netzes. Nutzbar sind 192.168.50.1 bis .254.',
  ),
  tabelle(
    'i3-n4-5',
    'nw-ipv4',
    scenario:
        'Für die Planung von Subnetzen wird eine Übersicht der gängigen Präfixlängen gebraucht.',
    prompt: 'Ergänze die Übersicht der Präfixlängen.',
    zeilen: [
      ['Präfix', 'Maske', 'Blockgröße', 'nutzbare Hosts'],
      ['/24', '255.255.255.0', '256', '254'],
      ['/25', '255.255.255.128', '128', zahl(126)],
      [
        '/26',
        wort(['255.255.255.192']),
        '64',
        zahl(62),
      ],
      [
        '/27',
        wort(['255.255.255.224']),
        zahl(32),
        zahl(30),
      ],
      ['/28', '255.255.255.240', zahl(16), zahl(14)],
    ],
    punkte: 4,
    explanation:
        'Jedes zusätzliche Netzbit halbiert die Blockgröße: 128, 64, 32, 16. Blockgröße = 256 - letzter Maskenwert, nutzbare Hosts = Blockgröße - 2. Masken: /26 = 192, /27 = 224, /28 = 240.',
    tags: ['subnetting'],
  ),
  freitext(
    'i3-n4-6',
    'nw-ipv4',
    scenario:
        'Die PCs einer Firma haben Adressen aus dem Bereich 192.168.178.0/24. Ein Kunde fragt, warum er diese Rechner nicht direkt aus dem Internet erreichen kann.',
    prompt:
        'Nenne die drei privaten IPv4-Adressbereiche und beschreibe, warum Geräte mit privaten Adressen nicht direkt aus dem Internet erreichbar sind.',
    kriterien: [
      krit(
        '10.0.0.0/8 (10.0.0.0 bis 10.255.255.255)',
        stichwoerter: ['10.0.0.0', '10.x', '10.255.255.255'],
      ),
      krit(
        '172.16.0.0/12 (172.16.0.0 bis 172.31.255.255)',
        stichwoerter: ['172.16', '172.31', '172.16.0.0'],
      ),
      krit(
        '192.168.0.0/16 (192.168.0.0 bis 192.168.255.255)',
        stichwoerter: ['192.168', '192.168.0.0', '192.168.x'],
      ),
      krit(
        'Private Adressen werden im Internet nicht geroutet; nach außen übersetzt der Router sie per NAT auf seine öffentliche Adresse',
        punkte: 2,
        stichwoerter: [
          'nicht geroutet',
          'NAT',
          'nicht weitergeleitet',
          'öffentliche Adresse',
          'nicht routbar',
        ],
      ),
    ],
    punkte: 5,
    loesung:
        'Private Bereiche: 10.0.0.0/8, 172.16.0.0/12 und 192.168.0.0/16. Diese Adressen darf jeder intern verwenden; Router im Internet leiten sie nicht weiter. Ins Internet gelangen die Geräte nur über NAT am Router, der ihre Adresse durch seine öffentliche ersetzt - von außen sind sie deshalb nicht direkt adressierbar.',
    explanation:
        'Bewertung: je Bereich 1 Punkt, 2 Punkte für die Beschreibung - höchstens 5 Punkte.',
  ),
  zuordnen(
    'i3-n4-7',
    'nw-ipv4',
    scenario:
        'In einem Firewall-Protokoll tauchen verschiedene IPv4-Adressen auf.',
    prompt: 'Ordne jede Adresse der richtigen Art zu.',
    buckets: ['privat', 'öffentlich', 'Sonderadresse'],
    items: [
      zu('172.31.255.1', 0, 'Liegt in 172.16.0.0/12 (bis 172.31.255.255).'),
      zu('8.8.4.4', 1, 'Öffentliche Adresse.'),
      zu('127.0.0.1', 2, 'Loopback - der eigene Rechner.'),
      zu('10.4.4.4', 0, 'Liegt in 10.0.0.0/8.'),
      zu('172.32.0.1', 1, 'Knapp außerhalb von 172.16.0.0/12.'),
      zu('169.254.10.10', 2, 'APIPA - selbst vergeben, wenn DHCP fehlt.'),
      zu('192.168.178.20', 0, 'Liegt in 192.168.0.0/16.'),
    ],
    explanation:
        'Privat sind 10.0.0.0/8, 172.16.0.0/12 und 192.168.0.0/16. 127.0.0.0/8 ist Loopback, 169.254.0.0/16 APIPA. 172.32.0.1 liegt knapp außerhalb des privaten Bereichs und ist öffentlich.',
  ),
  tabelle(
    'i3-n4-8',
    'nw-ipv4',
    scenario:
        'Das Netz 192.168.100.0/24 wird in vier gleich große Subnetze für vier Abteilungen geteilt.',
    prompt: 'Ergänze die Subnetztabelle.',
    zeilen: [
      ['Subnetz', 'Netzadresse', 'erster Host', 'Broadcast'],
      ['1', '192.168.100.0', '192.168.100.1', '192.168.100.63'],
      [
        '2',
        wort(['192.168.100.64']),
        '192.168.100.65',
        wort(['192.168.100.127']),
      ],
      [
        '3',
        wort(['192.168.100.128']),
        wort(['192.168.100.129']),
        '192.168.100.191',
      ],
      [
        '4',
        wort(['192.168.100.192']),
        '192.168.100.193',
        wort(['192.168.100.255']),
      ],
    ],
    punkte: 6,
    explanation:
        'Vier Subnetze brauchen 2 zusätzliche Bits: /26 mit Blockgröße 64. Netzadressen .0, .64, .128, .192; Broadcast ist jeweils die Adresse vor dem nächsten Block (.63, .127, .191, .255), der erste Host die Netzadresse plus 1.',
    tags: ['subnetting'],
    difficulty: 3,
  ),

  // ====================================================================== IPv6
  lueckentext(
    'i3-n6-1',
    'nw-ipv6',
    scenario:
        'In der Netzdokumentation sollen IPv6-Adressen einheitlich in der kürzesten Schreibweise stehen.',
    prompt: 'Ergänze die Angaben.',
    text:
        '2001:0db8:0000:0000:0000:0000:0042:0001 lautet gekürzt {0}.\n'
        'fe80:0000:0000:0000:0204:00ff:fe00:0a1b lautet gekürzt {1}.\n'
        'In 2001:db8::7 ersetzt :: genau {2} Blöcke.\n'
        'Der letzte Block von 2001:db8::7 lautet ausgeschrieben {3}.',
    luecken: [
      wort([
        '2001:db8::42:1',
      ], 'führende Nullen weg, vier Null-Blöcke durch ::'),
      wort(['fe80::204:ff:fe00:a1b'], 'drei Null-Blöcke durch ::'),
      zahl(5, rationale: '8 Blöcke - 3 vorhandene'),
      wort(['0007'], 'auf vier Hex-Ziffern auffüllen'),
    ],
    punkte: 4,
    explanation:
        'Regeln: führende Nullen je Block weglassen, die längste Folge von Null-Blöcken einmal durch :: ersetzen. 2001:db8::7 hat drei geschriebene Blöcke, also ersetzt :: 8 - 3 = 5 Blöcke. Ausgeschrieben hat jeder Block vier Hex-Ziffern: 0007.',
  ),
  freitext(
    'i3-n6-2',
    'nw-ipv6',
    scenario:
        'Der Internetanbieter eines Kunden stellt IPv6 bereit. Im Firmennetz laufen aber noch Geräte, die nur IPv4 beherrschen.',
    prompt:
        'Erläutere zwei Möglichkeiten, IPv4 und IPv6 in der Übergangszeit gemeinsam zu betreiben.',
    kriterien: [
      krit(
        'Dual Stack: Geräte und Router haben eine IPv4- und eine IPv6-Adresse und nutzen je nach Ziel das passende Protokoll',
        punkte: 2,
        stichwoerter: [
          'Dual Stack',
          'Dual-Stack',
          'beide Adressen',
          'beide Protokolle',
          'parallel',
        ],
      ),
      krit(
        'Tunneling: IPv6-Pakete werden in IPv4-Pakete verpackt und durch ein IPv4-Netz transportiert (z. B. 6to4)',
        punkte: 2,
        stichwoerter: ['Tunnel', 'Tunneling', '6to4', 'gekapselt', 'verpackt'],
      ),
      krit(
        'Übersetzung: Ein Gateway übersetzt zwischen IPv6 und IPv4 (NAT64)',
        punkte: 2,
        stichwoerter: [
          'NAT64',
          'Übersetzung',
          'übersetzt',
          'Protokollübersetzung',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Dual Stack: Geräte und Router erhalten sowohl eine IPv4- als auch eine IPv6-Adresse und verwenden je nach Ziel das passende Protokoll. Tunneling: IPv6-Pakete werden in IPv4-Pakete gekapselt und so durch Netzabschnitte transportiert, die nur IPv4 beherrschen; am Tunnelende werden sie wieder ausgepackt.',
    explanation:
        'Bewertung: 2 Punkte je erläuterter Möglichkeit, höchstens 4 Punkte. Auch die Übersetzung per NAT64 ist eine gültige Antwort.',
  ),
  tabelle(
    'i3-n6-3',
    'nw-ipv6',
    scenario:
        'In einem Mitschnitt des Netzverkehrs tauchen diese Adressen auf.',
    prompt: 'Bestimme Typ und Reichweite der Adressen.',
    zeilen: [
      ['Adresse', 'Typ', 'Reichweite'],
      [
        'fe80::1c2d:3eff:fe4a:5b6c',
        wahl('Link-Local', ['Global Unicast', 'Multicast', 'Loopback']),
        'nur das eigene Netzsegment',
      ],
      [
        '2a02:8070:d1:1::25',
        wahl('Global Unicast', ['Link-Local', 'Unique Local', 'Multicast']),
        wahl('weltweit routbar', [
          'nur das eigene Netzsegment',
          'nur das eigene Gerät',
        ]),
      ],
      [
        'fd3a:91c2:7b::10',
        wahl('Unique Local', ['Global Unicast', 'Link-Local', 'Loopback']),
        wahl('nur innerhalb der Organisation', [
          'weltweit routbar',
          'nur das eigene Gerät',
        ]),
      ],
      [
        'ff02::1',
        wahl('Multicast', ['Loopback', 'Link-Local', 'Global Unicast']),
        'alle Knoten im Segment',
      ],
      [
        '::1',
        wahl('Loopback', ['Multicast', 'Link-Local', 'Unique Local']),
        'nur das eigene Gerät',
      ],
    ],
    punkte: 4,
    explanation:
        'fe80::/10 Link-Local, 2000::/3 Global Unicast (weltweit routbar), fc00::/7 Unique Local (privat, nur intern), ff00::/8 Multicast, ::1 Loopback.',
  ),
  freitext(
    'i3-n6-4',
    'nw-ipv6',
    scenario:
        'In einer Schulung für Auszubildende sollst du IPv4 und IPv6 gegenüberstellen.',
    prompt: 'Beschreibe zwei Unterschiede zwischen IPv4 und IPv6.',
    kriterien: [
      krit(
        'Adresslänge: 32 Bit bei IPv4, 128 Bit bei IPv6 - viel größerer Adressraum',
        punkte: 2,
        stichwoerter: ['32 Bit', '128 Bit', 'Adressraum', 'mehr Adressen'],
      ),
      krit(
        'Schreibweise: dezimal mit Punkten gegenüber hexadezimal mit Doppelpunkten',
        punkte: 2,
        stichwoerter: ['hexadezimal', 'dezimal', 'Doppelpunkt', 'Schreibweise'],
      ),
      krit(
        'Konfiguration: von Hand oder DHCP gegenüber Selbstkonfiguration (SLAAC)',
        punkte: 2,
        stichwoerter: ['SLAAC', 'Autokonfiguration', 'Selbstkonfiguration'],
      ),
      krit(
        'IPv6 kennt keinen Broadcast und braucht kein NAT; statt ARP gibt es NDP',
        punkte: 2,
        stichwoerter: ['Broadcast', 'NAT', 'NDP', 'ARP', 'Multicast'],
      ),
    ],
    punkte: 4,
    loesung:
        'IPv4-Adressen sind 32 Bit lang und werden dezimal mit Punkten geschrieben, IPv6-Adressen 128 Bit lang und hexadezimal mit Doppelpunkten - der Adressraum ist dadurch um ein Vielfaches größer. IPv6-Geräte können sich per SLAAC selbst konfigurieren; Broadcast und NAT entfallen.',
    explanation:
        'Bewertung: 2 Punkte je beschriebenem Unterschied, höchstens 4 Punkte. Andere fachlich richtige Unterschiede zählen ebenfalls.',
  ),
  paare(
    'i3-n6-5',
    'nw-ipv6',
    scenario:
        'Der Internetanbieter kündigt die Umstellung auf IPv6 an. In seinem Schreiben stehen mehrere Fachbegriffe.',
    prompt: 'Ordne jedem Begriff aus der IPv6-Welt seine Bedeutung zu.',
    paare: [
      paar('SLAAC', 'Gerät bildet seine Adresse selbst'),
      paar('NDP', 'ersetzt ARP'),
      paar('Dual Stack', 'IPv4 und IPv6 parallel'),
      paar('Tunneling', 'IPv6 verpackt in IPv4'),
      paar('/64', 'übliches Präfix im LAN'),
    ],
    explanation:
        'SLAAC ist die Selbstkonfiguration aus dem Präfix des Routers, NDP findet Nachbarn und Router. Dual Stack und Tunneling sind Übergangstechniken. Ein LAN bekommt üblicherweise ein /64-Präfix.',
  ),

  // ============================================ Protokolle, Dienste und Ports
  tabelle(
    'i3-nd-1',
    'nw-dienste',
    scenario:
        'Für die Firewall einer Kanzlei wird eine Liste der benötigten Dienste erstellt.',
    prompt: 'Ergänze Standardport und Zweck.',
    zeilen: [
      ['Protokoll', 'Port', 'Zweck'],
      [
        'SSH',
        zahl(22),
        wahl('verschlüsselte Fernwartung', [
          'Namensauflösung',
          'E-Mails abrufen',
        ]),
      ],
      ['HTTPS', zahl(443), 'verschlüsselte Webseiten'],
      [
        'DNS',
        zahl(53),
        wahl('Namensauflösung', [
          'Adressvergabe',
          'verschlüsselte Fernwartung',
        ]),
      ],
      [
        'IMAPS',
        zahl(993),
        wahl('E-Mails verschlüsselt abrufen', [
          'E-Mails versenden',
          'Dateien übertragen',
        ]),
      ],
      ['RDP', zahl(3389), 'Windows-Remotedesktop'],
    ],
    punkte: 6,
    explanation:
        'SSH 22 (Fernwartung), HTTPS 443, DNS 53 (Namensauflösung), IMAPS 993 (verschlüsselter Mailabruf), RDP 3389. Geöffnet werden nur die Ports, die wirklich gebraucht werden.',
  ),
  tabelle(
    'i3-nd-2',
    'nw-dienste',
    scenario:
        'Am Helpdesk gehen vier Störungsmeldungen ein. Für jede soll festgelegt werden, wie die Vermutung überprüft und wie der Fehler behoben wird.',
    prompt:
        'Wähle zu jeder vermuteten Ursache die passende Überprüfung und Behebung.',
    zeilen: [
      ['Vermutete Ursache', 'Überprüfung', 'Behebung'],
      [
        'Netzwerkkabel defekt',
        wahl('Link-LED an Karte und Switch prüfen', [
          'nslookup aufrufen',
          'ipconfig /flushdns',
        ]),
        wahl('Kabel tauschen', [
          'DNS-Server eintragen',
          'Adresse neu anfordern',
        ]),
      ],
      [
        'Keine Adresse vom DHCP-Server',
        wahl('ipconfig: steht dort 169.254.x.x?', [
          'Link-LED prüfen',
          'nslookup aufrufen',
        ]),
        wahl('DHCP-Server prüfen, ipconfig /renew', [
          'Kabel tauschen',
          'Dose patchen lassen',
        ]),
      ],
      [
        'Netzwerkdose nicht gepatcht',
        wahl('funktionierendes Gerät anschließen', [
          'ipconfig /renew',
          'tracert zum Gateway',
        ]),
        wahl('Dose patchen lassen', [
          'DNS-Cache leeren',
          'Treiber neu installieren',
        ]),
      ],
      [
        'Namensauflösung gestört',
        wahl('ping auf Namen und nslookup', [
          'Link-LED prüfen',
          'Kabeltester anschließen',
        ]),
        wahl('DNS-Server prüfen oder korrigieren', [
          'Kabel tauschen',
          'Dose patchen lassen',
        ]),
      ],
    ],
    punkte: 8,
    explanation:
        'Kabel: Link-LED prüfen, Kabel tauschen. DHCP: ipconfig zeigt 169.254.x.x, dann Server prüfen und Adresse neu anfordern. Dose: mit einem funktionierenden Gerät oder Tester prüfen, patchen lassen. DNS: IP erreichbar, Name nicht - nslookup, dann DNS-Server prüfen. Je Zelle 1 Punkt.',
    tags: ['fehlersuche'],
  ),
  freitext(
    'i3-nd-3',
    'nw-dienste',
    scenario:
        'Die Beschäftigten einer Kanzlei lesen ihre E-Mails am PC, am Notebook und auf dem Smartphone.',
    prompt:
        'Begründe, warum die Postfächer mit IMAP statt mit POP3 eingerichtet werden.',
    kriterien: [
      krit(
        'Bei IMAP bleiben die E-Mails auf dem Server und werden mit allen Geräten synchronisiert',
        punkte: 2,
        stichwoerter: [
          'auf dem Server',
          'synchronisiert',
          'Synchronisation',
          'bleiben',
        ],
      ),
      krit(
        'Alle Geräte zeigen denselben Stand: Ordner, gelesene und gesendete Nachrichten',
        punkte: 2,
        stichwoerter: [
          'gleicher Stand',
          'alle Geräte',
          'mehrere Geräte',
          'Ordner',
          'gelesen',
        ],
      ),
      krit(
        'Die Postfächer lassen sich zentral auf dem Server sichern',
        stichwoerter: ['zentral', 'Sicherung', 'Backup'],
      ),
    ],
    punkte: 2,
    loesung:
        'Bei IMAP bleiben die Nachrichten auf dem Server und werden mit jedem Gerät synchronisiert. PC, Notebook und Smartphone zeigen deshalb denselben Stand samt Ordnern und Lesestatus. POP3 lädt die Mails dagegen auf ein Gerät herunter und löscht sie meist auf dem Server.',
    explanation:
        'Bewertung: Aussage plus Begründung ergeben 2 Punkte. Versendet wird in beiden Fällen mit SMTP.',
  ),
  freitext(
    'i3-nd-4',
    'nw-dienste',
    scenario:
        'Ein Linux-Server in der Cloud soll aus der Ferne verwaltet werden. Der Terminal-Client bietet die Verbindungstypen Seriell, Telnet und SSH an.',
    prompt:
        'Nenne den geeigneten Verbindungstyp mit seinem Standardport und begründe, warum die beiden anderen ausscheiden.',
    kriterien: [
      krit(
        'Verbindungstyp SSH',
        stichwoerter: ['SSH', 'Secure Shell', 'SSH-Verbindung'],
      ),
      krit('Standardport 22', stichwoerter: ['22', 'Port 22', 'TCP 22']),
      krit(
        'Telnet überträgt alles unverschlüsselt, auch Passwörter',
        stichwoerter: ['unverschlüsselt', 'Klartext', 'mitlesen'],
      ),
      krit(
        'Seriell braucht eine direkte Kabelverbindung und funktioniert nicht über das Internet',
        stichwoerter: ['Kabel', 'direkt', 'vor Ort', 'nicht über das Internet'],
      ),
    ],
    loesung:
        'Geeignet ist SSH auf Port 22: Die gesamte Sitzung samt Anmeldung ist verschlüsselt. Telnet überträgt alles im Klartext, Passwörter könnten mitgelesen werden. Eine serielle Verbindung setzt ein direkt am Gerät angeschlossenes Kabel voraus und ist über das Internet nicht möglich.',
    explanation:
        'Bewertung: je 1 Punkt für SSH, Port 22 und die beiden Begründungen - zusammen 4 Punkte.',
  ),
  paare(
    'i3-nd-5',
    'nw-dienste',
    scenario:
        'Im Protokoll der Firewall stehen nur Portnummern, keine Dienstnamen.',
    prompt: 'Ordne jedem Port den Dienst zu.',
    paare: [
      paar('22', 'SSH'),
      paar('53', 'DNS'),
      paar('80', 'HTTP'),
      paar('443', 'HTTPS'),
      paar('993', 'IMAPS'),
      paar('3389', 'RDP'),
    ],
    explanation:
        '22 SSH, 53 DNS, 80 HTTP, 443 HTTPS, 993 IMAPS, 3389 RDP. Diese Standardports sollte man auswendig kennen.',
    difficulty: 1,
  ),
  lueckentext(
    'i3-nd-6',
    'nw-dienste',
    scenario:
        'Ein Kunde hat sich an den englischsprachigen Support seines Mailanbieters gewandt und leitet dir den Chat weiter.',
    code:
        'Agent: Which mail settings do you use?\n'
        'User:  Incoming server on port 143,\n'
        '       no encryption.\n'
        'Agent: Please switch to IMAP over TLS\n'
        '       on port 993. For outgoing mail\n'
        '       use port 587 with STARTTLS.',
    prompt: 'Vervollständige die Zusammenfassung für den Kunden.',
    text:
        'Bisher werden die E-Mails über Port {0} abgerufen, und zwar {1}. '
        'Künftig soll der Abruf über Port {2} laufen. '
        'Für den Versand ist Port {3} einzutragen; das Protokoll dafür ist {4}.',
    luecken: [
      zahl(143),
      wahl('unverschlüsselt', ['verschlüsselt', 'über POP3']),
      zahl(993),
      zahl(587),
      wahl('SMTP', ['IMAP', 'POP3']),
    ],
    punkte: 5,
    explanation:
        '„Incoming“ = eingehend: bisher IMAP auf Port 143 ohne Verschlüsselung, künftig IMAP über TLS auf Port 993. „Outgoing“ = ausgehend: Versand per SMTP über Port 587 mit STARTTLS.',
    tags: ['englisch'],
  ),
  markieren(
    'i3-nd-7',
    'nw-dienste',
    scenario:
        'Ein Webserver soll aus dem Internet nur per HTTPS erreichbar sein. Verwaltet wird er per SSH ausschließlich aus dem Admin-Netz 10.0.9.0/24. Die Firewall enthält die folgenden Regeln.',
    prompt: 'Markiere alle Regeln, die gegen diese Vorgabe verstoßen.',
    mono: true,
    zeilen: [
      nein('allow tcp any -> web:443', 'HTTPS aus dem Internet ist gewollt.'),
      nein(
        'allow tcp 10.0.9.0/24 -> web:22',
        'SSH nur aus dem Admin-Netz - wie verlangt.',
      ),
      ja(
        'allow tcp any -> web:22',
        'SSH wäre aus dem ganzen Internet erreichbar.',
      ),
      ja(
        'allow tcp any -> web:23',
        'Telnet ist unverschlüsselt und nicht vorgesehen.',
      ),
      ja(
        'allow tcp any -> web:3389',
        'Ein Remotedesktop aus dem Internet ist nicht vorgesehen.',
      ),
      nein('deny  ip  any -> any', 'Alles Übrige wird verworfen - richtig.'),
    ],
    explanation:
        'Erlaubt sein sollen nur TCP 443 von überall und TCP 22 aus 10.0.9.0/24. Die Regeln für 22 von überall, 23 und 3389 öffnen unnötige Zugänge und werden entfernt.',
  ),
  reihenfolge(
    'i3-nd-8',
    'nw-dienste',
    scenario:
        'Anna (anna@firma-a.example) schreibt eine E-Mail an Ben (ben@firma-b.example).',
    prompt: 'Bringe den Weg der E-Mail in die richtige Reihenfolge.',
    items: [
      'Annas Mailprogramm übergibt die Nachricht per SMTP an den Mailserver von Firma A',
      'Der Mailserver von Firma A fragt im DNS den MX-Eintrag von firma-b.example ab',
      'Der Mailserver von Firma A überträgt die Nachricht per SMTP an den Mailserver von Firma B',
      'Der Mailserver von Firma B legt die Nachricht in Bens Postfach ab',
      'Bens Mailprogramm ruft die Nachricht per IMAP ab',
    ],
    explanation:
        'Versendet wird immer per SMTP: erst vom Client zum eigenen Server, dann von Server zu Server. Den Zielserver nennt der MX-Eintrag im DNS. Abgerufen wird mit IMAP (oder POP3).',
  ),

  // =============================================== Cloud und Virtualisierung
  tabelle(
    'i3-nc-1',
    'nw-cloud',
    scenario:
        'Vor einem Umzug in die Cloud soll geklärt werden, wer sich bei welchem Servicemodell um was kümmert.',
    prompt: 'Ergänze, wer jeweils zuständig ist.',
    zeilen: [
      ['Ebene', 'IaaS', 'PaaS', 'SaaS'],
      ['Rechenzentrum und Hardware', 'Anbieter', 'Anbieter', 'Anbieter'],
      [
        'Betriebssystem',
        wahl('Kunde', ['Anbieter', 'Hardwarehersteller']),
        wahl('Anbieter', ['Kunde', 'Hardwarehersteller']),
        'Anbieter',
      ],
      [
        'Anwendung',
        'Kunde',
        wahl('Kunde', ['Anbieter', 'Hardwarehersteller']),
        wahl('Anbieter', ['Kunde', 'Hardwarehersteller']),
      ],
      [
        'Daten und Benutzerkonten',
        wahl('Kunde', ['Anbieter', 'Hardwarehersteller']),
        'Kunde',
        wahl('Kunde', ['Anbieter', 'Hardwarehersteller']),
      ],
    ],
    punkte: 6,
    explanation:
        'IaaS: Der Anbieter stellt nur die Infrastruktur, ab dem Betriebssystem ist der Kunde zuständig. PaaS: Der Anbieter pflegt auch Betriebssystem und Laufzeitumgebung, der Kunde seine Anwendung. SaaS: Der Anbieter betreibt alles bis zur Anwendung. Für Daten und Benutzerkonten bleibt immer der Kunde verantwortlich.',
  ),
  freitext(
    'i3-nc-2',
    'nw-cloud',
    scenario:
        'Ein Ingenieurbüro überlegt, seinen Dateiserver durch einen Speicherdienst in der Public Cloud zu ersetzen.',
    prompt:
        'Nenne je zwei Vorteile und zwei Nachteile der Cloud-Lösung gegenüber dem eigenen Server.',
    kriterien: [
      krit(
        'Vorteil: keine Anschaffung eigener Hardware, Kosten nach Nutzung',
        stichwoerter: [
          'Investition',
          'Anschaffung',
          'keine Hardware',
          'nach Nutzung',
        ],
      ),
      krit(
        'Vorteil: Speicher lässt sich schnell erweitern oder verkleinern',
        stichwoerter: ['skalierbar', 'Skalierung', 'erweitern', 'flexibel'],
      ),
      krit(
        'Vorteil: Wartung, Updates und Ausfallsicherheit übernimmt der Anbieter',
        stichwoerter: [
          'Wartung',
          'Updates',
          'Anbieter kümmert',
          'Verfügbarkeit',
        ],
      ),
      krit(
        'Vorteil: Zugriff von überall',
        stichwoerter: ['von überall', 'ortsunabhängig', 'mobil'],
      ),
      krit(
        'Nachteil: Abhängigkeit von der Internetverbindung',
        stichwoerter: ['Internetverbindung', 'Internet', 'offline'],
      ),
      krit(
        'Nachteil: Abhängigkeit vom Anbieter (Lock-in)',
        stichwoerter: ['Abhängigkeit', 'Lock-in', 'Anbieterwechsel'],
      ),
      krit(
        'Nachteil: Datenschutz - Daten liegen außer Haus, Standort und Vertrag müssen geprüft werden',
        stichwoerter: ['Datenschutz', 'DSGVO', 'außer Haus', 'Standort'],
      ),
      krit(
        'Nachteil: laufende Kosten können auf Dauer höher sein',
        stichwoerter: [
          'laufende Kosten',
          'monatliche Kosten',
          'auf Dauer teurer',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Vorteile: keine eigene Hardware und keine hohe Anfangsinvestition; der Speicher wächst nach Bedarf mit, und der Anbieter übernimmt Wartung und Ausfallsicherheit. Nachteile: Ohne Internetverbindung kein Zugriff, Abhängigkeit vom Anbieter, und die Daten liegen außer Haus - Datenschutz und Standort müssen geklärt sein.',
    explanation:
        'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte (je zwei Vorteile und Nachteile).',
    difficulty: 1,
  ),
  rechnen(
    'i3-nc-3',
    'nw-cloud',
    scenario:
        'Ein Cloud-Anbieter sichert für einen Dienst eine Verfügbarkeit von 99,9 % je Monat zu. Gerechnet wird mit 30 Tagen.',
    prompt:
        'Berechne, wie viele Minuten der Dienst im Monat höchstens ausfallen darf.',
    answer: 43.2,
    tolerance: 0.05,
    unit: 'min',
    punkte: 3,
    explanation:
        'Minuten im Monat: 30 × 24 × 60 = 43.200 min. Erlaubter Ausfall: 0,1 % = 0,001. 43.200 min × 0,001 = 43,2 min.',
  ),
  lueckentext(
    'i3-nc-4',
    'nw-cloud',
    scenario:
        'Für Schulungen wird eine virtuelle Maschine gemietet. Sie läuft an 22 Tagen im Monat jeweils 10 Stunden und nutzt 100 GB Speicher.',
    code:
        'Cloud VM "c2-medium" - Pricing\n'
        'vCPU: 2   RAM: 8 GB\n'
        'Price:   0.06 EUR per hour\n'
        'Storage: 0.05 EUR per GB per month\n'
        'Billing: pay as you go',
    prompt: 'Ermittle die Kosten für einen Monat.',
    text:
        'Betriebsstunden: {0} h\n'
        'Kosten für die Laufzeit: {1} €\n'
        'Kosten für den Speicher: {2} €\n'
        'Gesamtkosten: {3} €',
    luecken: [
      zahl(220, rationale: '22 × 10 h'),
      zahl(13.2, toleranz: 0.01, rationale: '220 h × 0,06 €'),
      zahl(5, toleranz: 0.01, rationale: '100 GB × 0,05 €'),
      zahl(18.2, toleranz: 0.01, rationale: '13,20 € + 5,00 €'),
    ],
    punkte: 4,
    explanation:
        'Laufzeit: 22 × 10 h = 220 h, × 0,06 € = 13,20 €. Speicher: 100 GB × 0,05 € = 5,00 €. Zusammen 18,20 €. „Pay as you go“ heißt: bezahlt wird nur die tatsächliche Nutzung.',
    tags: ['englisch'],
  ),
];
