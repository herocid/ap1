import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 03 - Informations- und Softwaresysteme.
final List<Question> questionsA03 = [
  // ======================================================= Komponenten eines PCs
  zuordnen(
    'a3-hk-1',
    'h-komponenten',
    prompt: 'Ordne jedes Gerät dem passenden Teil des EVA-Prinzips zu.',
    buckets: ['Eingabe', 'Verarbeitung', 'Ausgabe'],
    items: [
      zu('Tastatur', 0),
      zu('Prozessor', 1),
      zu('Monitor', 2),
      zu('Scanner', 0),
      zu('Drucker', 2),
    ],
    explanation:
        'Eingabegeräte liefern Daten, der Prozessor verarbeitet sie, Ausgabegeräte geben das Ergebnis aus.',
  ),
  einfach(
    'a3-hk-2',
    'h-komponenten',
    scenario:
        'Ein Büro-PC wird zäh, sobald mehrere Programme offen sind. Die Festplattenaktivität ist dabei dauerhaft hoch.',
    prompt: 'Welche Aufrüstung hilft am wahrscheinlichsten?',
    choices: [
      ja(
        'Mehr Arbeitsspeicher',
        'Reicht der RAM nicht, lagert das System auf den Datenträger aus. Das erklärt die Dauerlast.',
      ),
      nein(
        'Eine bessere Grafikkarte',
        'Die Grafik spielt bei Büroarbeit kaum eine Rolle.',
      ),
      nein('Ein größerer Monitor', 'Ändert nichts an der Rechenleistung.'),
      nein(
        'Ein stärkeres Netzteil',
        'Die Stromversorgung ist nicht der Engpass.',
      ),
    ],
    explanation:
        'Zu wenig RAM führt zu Auslagerung. Dann arbeitet der Datenträger ständig, und alles wird träge.',
  ),
  mehrfach(
    'a3-hk-3',
    'h-komponenten',
    prompt: 'Welche Aussagen zu UEFI sind richtig?',
    choices: [
      ja(
        'Es ist der Nachfolger des klassischen BIOS.',
        'UEFI hat das BIOS weitgehend abgelöst.',
      ),
      ja(
        'Es unterstützt GPT-Datenträger über 2 TiB.',
        'Das klassische BIOS mit MBR ist auf 2 TiB begrenzt.',
      ),
      ja(
        'Secure Boot startet nur signierte Bootloader.',
        'Das erschwert Schadsoftware, die sich vor dem Betriebssystem einnistet.',
      ),
      nein(
        'UEFI ist ein Betriebssystem.',
        'Es ist Firmware, die das Betriebssystem startet.',
      ),
      nein(
        'UEFI speichert alle Nutzerdaten.',
        'Nutzerdaten liegen auf dem Datenträger.',
      ),
    ],
    explanation:
        'UEFI ist moderne Firmware: große Datenträger, grafische Oberfläche, Secure Boot.',
  ),
  einfach(
    'a3-hk-4',
    'h-komponenten',
    prompt:
        'Im Datenblatt eines Prozessors steht „8 Kerne / 16 Threads“. Was bedeutet das?',
    choices: [
      ja(
        'Jeder der 8 Kerne kann per SMT (Hyper-Threading) zwei Threads abwechselnd bearbeiten.',
        'So werden Wartezeiten eines Kerns besser genutzt.',
      ),
      nein(
        'Der Prozessor hat 16 physische Kerne.',
        'Physisch sind es 8 Kerne, denn Threads sind keine zusätzlichen Kerne.',
      ),
      nein(
        'Der Prozessor ist doppelt so schnell wie einer mit 8 Threads.',
        'SMT bringt meist nur einen Teil mehr Leistung, keine Verdopplung.',
      ),
      nein(
        'Im Rechner stecken zwei Prozessoren mit je 8 Kernen.',
        'Die Angabe bezieht sich auf einen einzelnen Prozessor.',
      ),
    ],
    explanation:
        'Kerne sind eigenständige Recheneinheiten. Mit SMT bearbeitet jeder Kern zwei Threads, was die Auslastung verbessert, aber die Leistung nicht verdoppelt.',
    difficulty: 1,
  ),
  rechnen(
    'a3-hk-5',
    'h-komponenten',
    scenario:
        'Eine Workstation braucht unter Volllast 450 W. Das Netzteil hat bei dieser Last einen Wirkungsgrad von 90 %.',
    prompt: 'Wie viel Leistung nimmt das Netzteil aus der Steckdose auf?',
    answer: 500,
    unit: 'W',
    explanation:
        'Wirkungsgrad = abgegebene / aufgenommene Leistung. Aufnahme = 450 W / 0,9 = 500 W. Die Differenz von 50 W wird zu Wärme.',
  ),
  reihenfolge(
    'a3-hk-6',
    'h-komponenten',
    prompt:
        'Bringe die Schritte beim Start eines PCs in die richtige Reihenfolge.',
    items: [
      'POST: Die Firmware prüft die Hardware',
      'UEFI sucht ein Bootmedium nach der Bootreihenfolge',
      'Der Bootloader wird gestartet (Secure Boot prüft die Signatur)',
      'Der Kernel des Betriebssystems lädt die Treiber',
      'Dienste starten, die Anmeldung erscheint',
    ],
    explanation:
        'Erst prüft die Firmware die Hardware, dann sucht sie das Bootmedium und startet den Bootloader. Dieser lädt den Kernel, der Treiber und Dienste startet.',
  ),
  zuordnen(
    'a3-hk-7',
    'h-komponenten',
    prompt:
        'Reicht für den Arbeitsplatz die im Prozessor integrierte Grafik, oder wird eine dedizierte Grafikkarte gebraucht?',
    buckets: ['integrierte Grafik reicht', 'dedizierte Grafikkarte'],
    items: [
      zu('Buchhaltung mit Tabellenkalkulation', 0),
      zu('3D-Konstruktion mit CAD', 1),
      zu('Schnitt von 4K-Videos', 1),
      zu('Empfang mit Telefon und E-Mail', 0),
      zu('Webentwicklung mit Editor und Browser', 0),
    ],
    explanation:
        'Büro, Kommunikation und Webentwicklung kommen mit der iGPU aus. 3D-Konstruktion und Videoschnitt brauchen Rechenleistung und eigenen Grafikspeicher einer dedizierten Karte.',
  ),
  rechnen(
    'a3-hk-8',
    'h-komponenten',
    scenario:
        'Ein PC hat zwei Module DDR4-3200 im Dual-Channel-Betrieb. Jedes Modul überträgt je Vorgang 64 Bit.',
    prompt: 'Wie hoch ist die theoretische Speicherbandbreite in GB/s?',
    answer: 51.2,
    tolerance: 0.05,
    unit: 'GB/s',
    explanation:
        'DDR4-3200 = 3.200 Mio. Übertragungen pro Sekunde. 64 Bit = 8 Byte. Ein Modul: 3.200 × 8 = 25.600 MB/s = 25,6 GB/s. Dual-Channel: 2 × 25,6 = 51,2 GB/s.',
    difficulty: 3,
  ),
  paare(
    'a3-hk-9',
    'h-komponenten',
    prompt:
        'Ordne jedem Baustein der Von-Neumann-Architektur seine Aufgabe zu.',
    paare: [
      paar('Steuerwerk', 'holt und entschlüsselt Befehle'),
      paar('Rechenwerk (ALU)', 'rechnet und vergleicht'),
      paar('Speicher', 'hält Programme und Daten gemeinsam'),
      paar('Bussystem', 'verbindet die Bausteine'),
      paar('Ein-/Ausgabewerk', 'tauscht Daten mit der Außenwelt'),
    ],
    explanation:
        'Von Neumann: Steuerwerk und Rechenwerk (zusammen die CPU), ein gemeinsamer Speicher für Programme und Daten, Ein-/Ausgabewerk und Bussystem. Das Betriebssystem gehört nicht dazu, es ist Software.',
  ),

  // ======================================================= Speicher: HDD und SSD
  rechnen(
    'a3-hs-1',
    'h-speicher',
    prompt:
        'Eine SSD hat laut Hersteller 500 GB. Wie viele GiB zeigt das Betriebssystem an? (auf eine Nachkommastelle)',
    answer: 465.7,
    tolerance: 0.05,
    unit: 'GiB',
    explanation:
        '500 GB = 500 × 10⁹ Byte. 1 GiB = 1.024³ = 1.073.741.824 Byte. 500.000.000.000 / 1.073.741.824 ≈ 465,7 GiB.',
  ),
  einfach(
    'a3-hs-2',
    'h-speicher',
    scenario:
        'Für ein Außendienst-Notebook soll ein neuer Datenträger gewählt werden.',
    prompt: 'Welcher Datenträger passt am besten?',
    choices: [
      ja(
        'NVMe-SSD',
        'Schnell, stoßfest und stromsparend: ideal für ein mobiles Gerät.',
      ),
      nein(
        '3,5-Zoll-HDD',
        'Passt nicht ins Notebook, ist stoßempfindlich und langsam.',
      ),
      nein('Bandlaufwerk', 'Für Archivierung, nicht für den Arbeitsbetrieb.'),
      nein(
        'USB-Stick als Systemlaufwerk',
        'Zu langsam und unzuverlässig als Hauptdatenträger.',
      ),
    ],
    explanation:
        'SSDs haben keine beweglichen Teile. Für Notebooks sind sie wegen Tempo, Robustheit und Stromverbrauch Standard.',
  ),
  zuordnen(
    'a3-hs-3',
    'h-speicher',
    prompt: 'Auf welchen Datenträger trifft die Aussage zu?',
    buckets: ['HDD', 'SSD'],
    items: [
      zu('Sehr kurze Zugriffszeit, weil kein Lesekopf bewegt wird', 1),
      zu('Günstiger Preis pro Gigabyte, gut für große Archive', 0),
      zu('Unempfindlich gegen Stöße', 1),
      zu('Begrenzte Zahl an Schreibvorgängen, angegeben als TBW', 1),
      zu('Rotierende Magnetscheiben, hörbares Laufgeräusch', 0),
      zu('Als NVMe-Variante mehrere GB/s über PCIe', 1),
    ],
    explanation:
        'SSD: schnell, robust, lautlos, aber mit begrenzter Schreibmenge (TBW). HDD: mechanisch und stoßempfindlich, dafür günstig pro GB.',
  ),
  rechnen(
    'a3-hs-4',
    'h-speicher',
    scenario:
        'Ein Screenshot hat 3840 × 2160 Pixel mit 32 Bit Farbtiefe und wird unkomprimiert gespeichert.',
    prompt:
        'Wie groß ist die Datei in MB (1 MB = 1.000.000 Byte)? Runde auf zwei Nachkommastellen.',
    answer: 33.18,
    tolerance: 0.01,
    unit: 'MB',
    explanation:
        'Pixel: 3840 × 2160 = 8.294.400. 32 Bit = 4 Byte pro Pixel. 8.294.400 × 4 = 33.177.600 Byte. 33.177.600 / 1.000.000 ≈ 33,18 MB.',
  ),
  rechnen(
    'a3-hs-5',
    'h-speicher',
    scenario:
        'Ein Musikstück dauert 3 Minuten und wird unkomprimiert in CD-Qualität gespeichert: 44.100 Hz, 16 Bit, Stereo.',
    prompt:
        'Wie viel Speicher braucht es in MB (1 MB = 1.000.000 Byte)? Runde auf zwei Nachkommastellen.',
    answer: 31.75,
    tolerance: 0.01,
    unit: 'MB',
    explanation:
        'Bit pro Sekunde: 44.100 × 16 × 2 = 1.411.200. Für 180 s: 1.411.200 × 180 = 254.016.000 Bit. Durch 8: 31.752.000 Byte ≈ 31,75 MB.',
    difficulty: 3,
  ),
  rechnen(
    'a3-hs-6',
    'h-speicher',
    scenario:
        'Ein Dateiserver soll die Daten von 25 Beschäftigten mit je 40 GB aufnehmen. Für die nächsten Jahre wird mit 25 % Wachstum gerechnet.',
    prompt: 'Wie viel Speicher wird mindestens benötigt?',
    answer: 1250,
    unit: 'GB',
    explanation:
        'Grundbedarf: 25 × 40 GB = 1.000 GB. Mit 25 % Wachstum: 1.000 GB × 1,25 = 1.250 GB.',
    difficulty: 1,
  ),
  einfach(
    'a3-hs-7',
    'h-speicher',
    scenario:
        'Ein Kunde hat eine M.2-SSD eingebaut und wundert sich, dass sie nur etwa 550 MB/s liest; im Test eines Kollegen waren es 7.000 MB/s.',
    prompt: 'Was ist die wahrscheinlichste Erklärung?',
    choices: [
      ja(
        'Es ist eine M.2-SSD mit SATA-Anbindung statt NVMe.',
        'M.2 ist nur die Bauform; SATA begrenzt auf rund 550 MB/s.',
      ),
      nein(
        'M.2-SSDs sind grundsätzlich auf 550 MB/s begrenzt.',
        'M.2-NVMe-SSDs mit PCIe 4.0 schaffen rund 7 GB/s.',
      ),
      nein(
        'Die SSD ist bereits verschlissen.',
        'Verschleiß senkt nicht die Übertragungsrate auf genau den SATA-Wert.',
      ),
      nein(
        'Das Dateisystem ist falsch formatiert.',
        'Das Dateisystem erklärt keinen Unterschied um den Faktor 13.',
      ),
    ],
    explanation:
        'Entscheidend ist die Anbindung: M.2-SATA liefert SATA-Tempo, erst M.2-NVMe über PCIe erreicht mehrere GB/s.',
  ),
  zuordnen(
    'a3-hs-8',
    'h-speicher',
    prompt: 'Ist der Speicher flüchtig oder nicht flüchtig?',
    buckets: ['flüchtig', 'nicht flüchtig'],
    items: [
      zu('SSD', 1),
      zu('Register', 0),
      zu('USB-Stick', 1),
      zu('Prozessor-Cache', 0),
      zu('Festplatte (HDD)', 1),
      zu('Arbeitsspeicher (RAM)', 0),
    ],
    explanation:
        'Register, Cache und RAM verlieren ihren Inhalt ohne Strom. SSD, HDD und USB-Stick speichern dauerhaft.',
    difficulty: 1,
  ),
  zuordnen(
    'a3-hs-9',
    'h-speicher',
    prompt: 'Um welche Speicherlösung handelt es sich?',
    buckets: ['DAS', 'NAS', 'SAN'],
    items: [
      zu('Externe Festplatte, per USB direkt am Server angeschlossen', 0),
      zu('Gerät im LAN, das Ordner per SMB für alle freigibt', 1),
      zu(
        'Eigenes Speichernetz, das Servern Speicher blockweise bereitstellt',
        2,
      ),
      zu('Speicher für die Dateiablage einer kleinen Kanzlei', 1),
    ],
    explanation:
        'DAS hängt direkt an einem Rechner. NAS stellt Dateien im Netz bereit (SMB, NFS). SAN ist ein eigenes, blockbasiertes Speichernetz für Server.',
  ),

  // ============================================ Schnittstellen und Peripherie
  freitext(
    'a3-hi-1',
    'h-schnittstellen',
    scenario:
        'Ein Kunde hat eine externe SSD „mit USB-C“ gekauft und ist enttäuscht: Sie kopiert kaum schneller als sein alter USB-Stick.',
    prompt:
        'Erläutere, warum die Angabe „USB-C“ nichts über die Geschwindigkeit aussagt.',
    kriterien: [
      krit(
        'USB-C beschreibt nur die Steckerform',
        stichwoerter: ['Steckerform', 'Stecker', 'Bauform', 'Form'],
      ),
      krit(
        'Die Datenrate hängt vom Standard dahinter ab: von USB 2.0 mit 480 Mbit/s bis USB4 mit 40 Gbit/s',
        stichwoerter: ['Standard', 'USB 2.0', 'USB4', 'Version', 'Generation'],
      ),
      krit(
        'Auch Kabel und Anschluss am PC müssen den schnellen Standard unterstützen',
        stichwoerter: [
          'Kabel',
          'Anschluss am PC',
          'beide Seiten',
          'Gegenstelle',
        ],
      ),
    ],
    punkte: 2,
    loesung:
        'USB-C ist nur die Form des Steckers. Welche Datenrate möglich ist, legt der Standard dahinter fest: Über USB-C kann USB 2.0 mit 480 Mbit/s ebenso laufen wie USB4 mit 40 Gbit/s. Außerdem müssen Kabel und Anschluss am PC den schnellen Standard unterstützen.',
    explanation:
        'Stecker und Standard sind zwei Paar Schuhe. Die Datenrate steht im Datenblatt. Bewertung: je Aussage 1 Punkt, höchstens 2 Punkte.',
  ),
  zuordnen(
    'a3-hi-2',
    'h-schnittstellen',
    prompt: 'Ordne die maximale Datenrate zu.',
    buckets: ['480 Mbit/s', '5 Gbit/s', '10 Gbit/s', '40 Gbit/s'],
    items: [
      zu('USB 2.0', 0),
      zu('USB 3.2 Gen 2', 2),
      zu('USB4', 3),
      zu('USB 3.2 Gen 1', 1),
    ],
    explanation:
        'USB 2.0: 480 Mbit/s. USB 3.2 Gen 1: 5 Gbit/s. Gen 2: 10 Gbit/s. USB4: bis 40 Gbit/s.',
  ),
  einfach(
    'a3-hi-3',
    'h-schnittstellen',
    scenario:
        'Eine Kanzlei druckt täglich mehrere hundert Seiten Text in Schwarzweiß.',
    prompt: 'Welches Gerät ist am wirtschaftlichsten?',
    choices: [
      ja(
        'Monochrom-Laserdrucker',
        'Günstige Kosten pro Seite und hohe Geschwindigkeit bei viel Text.',
      ),
      nein(
        'Fotodrucker mit sechs Tintenfarben',
        'Für Fotos gebaut, bei Text teuer pro Seite.',
      ),
      nein(
        'Tintenstrahl-Multifunktionsgerät für den Heimgebrauch',
        'Für geringe Druckvolumen ausgelegt.',
      ),
      nein(
        'Nadeldrucker',
        'Nur noch für Durchschläge relevant, laut und langsam.',
      ),
    ],
    explanation:
        'Bei hohem Textvolumen sind Laserdrucker wegen der niedrigen Seitenkosten die erste Wahl.',
  ),
  rechnen(
    'a3-hi-4',
    'h-schnittstellen',
    scenario:
        'Eine Datensicherung von 30 GB soll auf eine externe SSD mit USB 3.2 Gen 2 (10 Gbit/s) kopiert werden.',
    prompt: 'Wie viele Sekunden dauert das theoretisch mindestens?',
    answer: 24,
    unit: 's',
    explanation:
        '30 GB × 8 = 240 Gbit. 240 Gbit / 10 Gbit/s = 24 s. In der Praxis dauert es wegen Protokoll-Overhead länger.',
  ),
  rechnen(
    'a3-hi-5',
    'h-schnittstellen',
    scenario:
        'Ein Gaming-Monitor soll 2560 × 1440 Pixel mit 144 Hz und 24 Bit Farbtiefe darstellen.',
    prompt:
        'Welche Datenrate braucht das unkomprimierte Bild in Gbit/s? Runde auf zwei Nachkommastellen.',
    answer: 12.74,
    tolerance: 0.01,
    unit: 'Gbit/s',
    explanation:
        'Pixel: 2560 × 1440 = 3.686.400. Bit pro Bild: × 24 = 88.473.600. Pro Sekunde: × 144 = 12.740.198.400 Bit/s ≈ 12,74 Gbit/s. HDMI 2.0 (18 Gbit/s) oder DisplayPort 1.4 reichen dafür.',
    difficulty: 3,
  ),
  rechnen(
    'a3-hi-6',
    'h-schnittstellen',
    scenario:
        'Über eine Internetleitung mit 100 Mbit/s wird eine 1,5 GB große Datei heruntergeladen.',
    prompt: 'Wie viele Sekunden dauert der Download theoretisch mindestens?',
    answer: 120,
    unit: 's',
    explanation:
        '1,5 GB × 8 = 12 Gbit = 12.000 Mbit. 12.000 Mbit / 100 Mbit/s = 120 s, also 2 Minuten.',
  ),
  einfach(
    'a3-hi-7',
    'h-schnittstellen',
    scenario:
        'Ein Besprechungsraum bekommt einen Fernseher, der ein 4K-Bild mit 120 Hz von einem Notebook zeigen soll.',
    prompt: 'Welcher Anschluss erfüllt die Anforderung?',
    choices: [
      ja('HDMI 2.1', 'Mit 48 Gbit/s schafft HDMI 2.1 4K mit 120 Hz.'),
      nein('HDMI 2.0', 'Mit 18 Gbit/s reicht HDMI 2.0 für 4K nur bis 60 Hz.'),
      nein('VGA', 'Analog und veraltet; für 4K ungeeignet.'),
      nein('DVI-D', 'Mit rund 8 Gbit/s zu langsam und ohne Tonübertragung.'),
    ],
    explanation:
        'Für 4K mit 120 Hz braucht es rund 24 Gbit/s Nutzdaten. Das schaffen HDMI 2.1 oder DisplayPort ab 1.4 mit Kompression, nicht aber HDMI 2.0.',
    difficulty: 3,
  ),
  rechnen(
    'a3-hi-8',
    'h-schnittstellen',
    prompt:
        'Wie groß ist die Bildschirmdiagonale eines 24-Zoll-Monitors in Zentimetern? Runde auf zwei Nachkommastellen.',
    answer: 60.96,
    tolerance: 0.01,
    unit: 'cm',
    explanation: '1 Zoll = 2,54 cm. 24 × 2,54 cm = 60,96 cm.',
    difficulty: 1,
  ),
  rechnen(
    'a3-hi-9',
    'h-schnittstellen',
    scenario:
        'Ein Büro druckt 3.000 Seiten im Monat. Eine Tonerkartusche kostet 120 € und reicht für 6.000 Seiten.',
    prompt: 'Wie hoch sind die Tonerkosten pro Jahr?',
    answer: 720,
    unit: '€',
    explanation:
        'Kosten pro Seite: 120 € / 6.000 = 0,02 €. Seiten pro Jahr: 3.000 × 12 = 36.000. Kosten: 36.000 × 0,02 € = 720 €.',
  ),

  // =================================================== USV und Stromversorgung
  rechnen(
    'a3-hu-1',
    'h-usv',
    prompt:
        'Die angeschlossenen Geräte benötigen zusammen 540 W. Geplant werden 20 % Reserve, der Leistungsfaktor der USV beträgt 0,9. Wie viel VA muss die USV mindestens haben?',
    answer: 720,
    unit: 'VA',
    explanation: '540 W × 1,2 = 648 W. Scheinleistung = 648 W / 0,9 = 720 VA.',
  ),
  lueckentext(
    'a3-hu-2',
    'h-usv',
    prompt: 'Vervollständige die Aussagen zu den USV-Typen.',
    text:
        'Die {0} versorgt die Last dauerhaft über den Wechselrichter und hat deshalb {1} Umschaltzeit. '
        'Die {2} schaltet erst bei einem Netzausfall auf den Akku um und bietet nur Grundschutz. '
        'Die {3} gleicht zusätzlich Spannungsschwankungen über einen Regler aus.',
    luecken: [
      wahl('Online-USV', ['Offline-USV', 'Line-Interactive-USV']),
      wahl('keine', ['eine kurze', 'eine lange']),
      wahl('Offline-USV', ['Online-USV', 'Steckdosenleiste']),
      wahl('Line-Interactive-USV', ['Offline-USV', 'Steckdosenleiste']),
    ],
    explanation:
        'Die Online-USV (Doppelwandler) bietet den höchsten Schutz ohne Umschaltzeit, kostet aber mehr und hat höhere Verluste. Offline schaltet nur um, Line-Interactive regelt zusätzlich die Spannung.',
  ),
  einfach(
    'a3-hu-3',
    'h-usv',
    prompt:
        'Wie lang muss die Überbrückungszeit einer USV für einen Server mindestens sein?',
    choices: [
      ja(
        'Lang genug, um den Server geordnet herunterzufahren',
        'Das verhindert Datenverlust und beschädigte Dateisysteme.',
      ),
      nein(
        'Mindestens 24 Stunden',
        'Das wäre für eine USV unüblich und sehr teuer.',
      ),
      nein(
        'Wenige Millisekunden',
        'Das reicht nur zum Überbrücken einer Umschaltung.',
      ),
      nein(
        'Egal, Hauptsache sie hat einen Akku',
        'Eine zu kurze Zeit schützt nicht vor Datenverlust.',
      ),
    ],
    explanation:
        'Die USV soll den Betrieb überbrücken, bis alle Systeme sauber herunterfahren, idealerweise automatisch ausgelöst.',
  ),
  rechnen(
    'a3-hu-4',
    'h-usv',
    prompt:
        'Eine USV hat eine Scheinleistung von 2.000 VA und einen Leistungsfaktor von 0,7. Wie viel Wirkleistung kann sie höchstens liefern?',
    answer: 1400,
    unit: 'W',
    explanation:
        'Wirkleistung = Scheinleistung × Leistungsfaktor = 2.000 VA × 0,7 = 1.400 W.',
    difficulty: 1,
  ),
  rechnen(
    'a3-hu-5',
    'h-usv',
    scenario:
        'Eine kleine USV hat 2 Akkus mit je 12 V und 7 Ah. Der Wechselrichter arbeitet mit 90 % Wirkungsgrad. Angeschlossen ist eine Last von 300 W.',
    prompt:
        'Wie viele Minuten überbrückt die USV nach vereinfachter Rechnung? Runde auf eine Nachkommastelle.',
    answer: 30.2,
    tolerance: 0.1,
    unit: 'min',
    explanation:
        'Energie: 2 × 12 V × 7 Ah = 168 Wh. Nutzbar: 168 Wh × 0,9 = 151,2 Wh. Zeit: 151,2 Wh / 300 W = 0,504 h. 0,504 × 60 ≈ 30,2 min.',
    difficulty: 3,
  ),
  zuordnen(
    'a3-hu-6',
    'h-usv',
    prompt: 'Welcher USV-Typ ist gemeint?',
    buckets: ['Offline (VFD)', 'Line-Interactive (VI)', 'Online (VFI)'],
    items: [
      zu('Versorgt die Last dauerhaft über den Wechselrichter', 2),
      zu('Schaltet erst bei Netzausfall auf den Akku um', 0),
      zu('Günstiger Grundschutz für einen einzelnen Arbeitsplatz', 0),
      zu('Höchster Schutz im Rechenzentrum, keine Umschaltzeit', 2),
      zu('Regelt Spannungsschwankungen aus, schaltet bei Ausfall um', 1),
    ],
    explanation:
        'Offline (VFD) schaltet nur um, Line-Interactive (VI) regelt zusätzlich die Spannung, Online (VFI) entkoppelt die Last vollständig vom Netz.',
  ),
  mehrfach(
    'a3-hu-7',
    'h-usv',
    scenario: 'Für den Serverschrank wird eine USV angeschafft.',
    prompt: 'Welche Geräte gehören an die USV?',
    choices: [
      ja('Die Server', 'Sie müssen weiterlaufen oder sauber herunterfahren.'),
      ja(
        'Der Core-Switch',
        'Ohne Switch erreichen die Server weder Clients noch die USV-Software.',
      ),
      ja(
        'Die Firewall',
        'Sie hält die Verbindung nach außen und schützt das Netz.',
      ),
      nein(
        'Der Laserdrucker im Flur',
        'Beim Aufheizen zieht er viel Strom und kann die USV überlasten.',
      ),
      nein(
        'Ein Heizlüfter im Serverraum',
        'Hohe Dauerlast, nicht geschäftskritisch.',
      ),
    ],
    explanation:
        'An die USV kommt, was bei einem Ausfall weiterlaufen oder geordnet herunterfahren muss. Laserdrucker und Heizgeräte überlasten sie nur.',
  ),
  reihenfolge(
    'a3-hu-8',
    'h-usv',
    prompt:
        'Bringe die Schritte bei einem längeren Stromausfall in die richtige Reihenfolge.',
    items: [
      'Die USV versorgt die Last aus dem Akku',
      'Die USV meldet den Ausfall an die Server-Software',
      'Die Restlaufzeit unterschreitet die eingestellte Schwelle',
      'Anwendungen und virtuelle Maschinen werden heruntergefahren',
      'Die Hosts und zuletzt Speicher und Netzwerk werden abgeschaltet',
    ],
    explanation:
        'Erst überbrückt der Akku, dann informiert die USV die Software. Unter der Schwelle wird von oben nach unten heruntergefahren: Anwendungen und VMs vor Hosts, Speicher und Netzwerk zuletzt.',
  ),
  rechnen(
    'a3-hu-9',
    'h-usv',
    scenario:
        'Im Serverschrank hängen drei Server mit je 250 W, ein Switch mit 100 W und ein Speichersystem mit 250 W. Geplant werden 20 % Reserve, der Leistungsfaktor der USV ist 0,8.',
    prompt: 'Wie viel VA muss die USV mindestens haben?',
    answer: 1650,
    unit: 'VA',
    explanation:
        'Summe: 3 × 250 W + 100 W + 250 W = 1.100 W. Mit Reserve: 1.100 W × 1,2 = 1.320 W. Scheinleistung: 1.320 W / 0,8 = 1.650 VA.',
  ),

  // ======================================================= Green IT und Ergonomie
  rechnen(
    'a3-ha-1',
    'h-arbeitsplatz',
    prompt:
        'Ein Monitor verbraucht 25 W und läuft 10 Stunden am Tag an 250 Tagen im Jahr. Strom kostet 0,32 € pro kWh. Wie hoch sind die jährlichen Stromkosten?',
    answer: 20,
    tolerance: 0.01,
    unit: '€',
    explanation:
        '25 W × 10 h × 250 = 62.500 Wh = 62,5 kWh. 62,5 kWh × 0,32 € = 20,00 €.',
  ),
  mehrfach(
    'a3-ha-2',
    'h-arbeitsplatz',
    prompt: 'Welche Maßnahmen gehören zu Green IT?',
    choices: [
      ja(
        'Server virtualisieren und konsolidieren',
        'Weniger physische Server brauchen weniger Energie.',
      ),
      ja(
        'Geräte automatisch in den Energiesparmodus versetzen',
        'Senkt den Verbrauch in Pausen.',
      ),
      ja('Altgeräte fachgerecht recyceln', 'Schont Ressourcen und Umwelt.'),
      nein(
        'Alle Geräte jedes Jahr ersetzen',
        'Die Herstellung verbraucht viel Energie; lange Nutzung ist nachhaltiger.',
      ),
      nein(
        'Bildschirmschoner mit Animation dauerhaft laufen lassen',
        'Verbraucht unnötig Strom.',
      ),
    ],
    explanation:
        'Green IT senkt Energie- und Ressourcenverbrauch über den gesamten Lebenszyklus.',
  ),
  lueckentext(
    'a3-ha-3',
    'h-arbeitsplatz',
    prompt: 'Vervollständige die Regeln für die Aufstellung eines Bildschirms.',
    text:
        'Die Oberkante des Bildschirms liegt {0}. '
        'Die Blickrichtung verläuft {1}. '
        'Der Sehabstand beträgt etwa {2}.',
    luecken: [
      wahl('auf oder leicht unter Augenhöhe', [
        'deutlich über Augenhöhe',
        'auf Höhe der Tischplatte',
      ], 'So bleibt die Kopfhaltung entspannt.'),
      wahl(
        'parallel zum Fenster',
        ['zum Fenster hin', 'vom Fenster weg'],
        'Sonst blendet das Gegenlicht oder das Fenster spiegelt sich.',
      ),
      wahl('50 bis 70 cm', ['20 bis 30 cm', '120 bis 150 cm']),
    ],
    explanation:
        'Die Arbeitsstättenverordnung verlangt blendfreie Bildschirmarbeitsplätze: Oberkante auf oder leicht unter Augenhöhe, Blick parallel zum Fenster, Abstand etwa eine Armlänge.',
  ),
  rechnen(
    'a3-ha-4',
    'h-arbeitsplatz',
    scenario:
        'In einer Firma bleiben 30 PCs nach Feierabend eingeschaltet und brauchen im Leerlauf je 35 W, und zwar jeweils 14 Stunden an 250 Arbeitstagen. Strom kostet 0,30 € pro kWh.',
    prompt: 'Wie hoch sind die vermeidbaren Stromkosten pro Jahr?',
    answer: 1102.5,
    tolerance: 0.01,
    unit: '€',
    explanation:
        'Je PC: 35 W × 14 h × 250 = 122.500 Wh = 122,5 kWh. Alle: 122,5 kWh × 30 = 3.675 kWh. Kosten: 3.675 kWh × 0,30 € = 1.102,50 €.',
    difficulty: 3,
  ),
  rechnen(
    'a3-ha-5',
    'h-arbeitsplatz',
    scenario:
        'Ein alter Monitor braucht 65 W, ein neuer 25 W. Der Monitor läuft 2.500 Stunden im Jahr, Strom kostet 0,30 € pro kWh. Der neue Monitor kostet 240 €.',
    prompt:
        'Nach wie vielen Jahren hat sich der neue Monitor allein über die Stromersparnis bezahlt gemacht?',
    answer: 8,
    unit: 'Jahre',
    explanation:
        'Ersparnis: 65 W - 25 W = 40 W. Pro Jahr: 40 W × 2.500 h = 100.000 Wh = 100 kWh. In Euro: 100 kWh × 0,30 € = 30 €. Amortisation: 240 € / 30 € pro Jahr = 8 Jahre.',
  ),
  zuordnen(
    'a3-ha-6',
    'h-arbeitsplatz',
    prompt: 'Welches Siegel ist gemeint?',
    buckets: ['80 PLUS', 'TCO Certified', 'Blauer Engel', 'EU-Energielabel'],
    items: [
      zu('Umwelt, Ergonomie und soziale Bedingungen in der Herstellung', 1),
      zu(
        'Deutsches Umweltzeichen: sparsam, schadstoffarm, recyclinggerecht',
        2,
      ),
      zu('Effizienzklassen von A bis G, z. B. bei Monitoren', 3),
      zu('Bescheinigt den Wirkungsgrad eines Netzteils', 0),
    ],
    explanation:
        '80 PLUS bewertet Netzteile, TCO Certified Nachhaltigkeit und Ergonomie, der Blaue Engel die Umweltverträglichkeit, das EU-Energielabel die Effizienzklasse.',
  ),
  mehrfach(
    'a3-ha-7',
    'h-arbeitsplatz',
    prompt:
        'Welche Anforderungen an einen Bildschirmarbeitsplatz sind richtig?',
    choices: [
      ja(
        'Blickrichtung parallel zum Fenster',
        'So entstehen weder Blendung noch Spiegelungen.',
      ),
      ja(
        'Sehabstand etwa 50 bis 70 cm',
        'Etwa eine Armlänge, bei großen Monitoren mehr.',
      ),
      ja(
        'Beleuchtung von mindestens 500 Lux',
        'So viel verlangen die Arbeitsstättenregeln für Büroarbeit.',
      ),
      nein(
        'Monitoroberkante deutlich über Augenhöhe',
        'Das führt zu Nackenverspannungen.',
      ),
      nein(
        'Raumtemperatur von höchstens 16 °C',
        'Für sitzende Büroarbeit gelten mindestens 20 °C.',
      ),
    ],
    explanation:
        'Monitor parallel zum Fenster, auf oder leicht unter Augenhöhe, 50 bis 70 cm entfernt, 500 Lux und mindestens 20 °C.',
  ),
  paare(
    'a3-ha-8',
    'h-arbeitsplatz',
    prompt: 'Ordne jeder Vorschrift zu, was sie regelt.',
    paare: [
      paar('Arbeitsstättenverordnung', 'Bildschirmarbeitsplätze'),
      paar(
        'Elektrogesetz (ElektroG)',
        'Rücknahme und Entsorgung von Altgeräten',
      ),
      paar('DSGVO', 'Umgang mit personenbezogenen Daten'),
      paar('Urheberrechtsgesetz', 'Schutz geistiger Werke wie Software'),
    ],
    explanation:
        'Die Bildschirmarbeit ist in der Arbeitsstättenverordnung geregelt; der Arbeitgeber muss dafür eine Gefährdungsbeurteilung durchführen. Das ElektroG regelt die Entsorgung, die DSGVO den Datenschutz, das Urheberrecht den Schutz von Software.',
    difficulty: 1,
  ),
  einfach(
    'a3-ha-9',
    'h-arbeitsplatz',
    scenario: '40 alte Büro-PCs mit Festplatten sollen ausgemustert werden.',
    prompt: 'Wie geht man richtig vor?',
    choices: [
      ja(
        'Datenträger sicher löschen oder vernichten, dann über einen zertifizierten Entsorger recyceln',
        'So sind Datenschutz und fachgerechte Entsorgung erfüllt.',
      ),
      nein(
        'Die Geräte über den Restmüll entsorgen',
        'Elektrogeräte dürfen nicht in den Restmüll.',
      ),
      nein(
        'Die Geräte unverändert an Beschäftigte verschenken',
        'Auf den Festplatten liegen noch Firmendaten.',
      ),
      nein(
        'Die Festplatten schnell formatieren und die PCs verkaufen',
        'Nach einer Schnellformatierung lassen sich Daten wiederherstellen.',
      ),
    ],
    explanation:
        'Erst die Daten zuverlässig beseitigen und das dokumentieren, dann die Geräte nach dem ElektroG über Rücknahmestellen oder zertifizierte Entsorger recyceln.',
  ),

  // ============================================= Aufgaben eines Betriebssystems
  zuordnen(
    'a3-ba-1',
    'b-aufgaben',
    prompt: 'Welche Aufgabe des Betriebssystems ist gemeint?',
    buckets: [
      'Prozessverwaltung',
      'Speicherverwaltung',
      'Geräteverwaltung',
      'Benutzerverwaltung',
    ],
    items: [
      zu('Nur angemeldete Konten erhalten Zugriff', 3),
      zu('Ein Treiber steuert den neuen Drucker an', 2),
      zu('Rechenzeit wird zwischen laufenden Programmen verteilt', 0),
      zu('Bei zu wenig RAM wird auf den Datenträger ausgelagert', 1),
    ],
    explanation:
        'Das Betriebssystem verwaltet Prozesse, Speicher, Geräte, Dateien und Benutzer.',
  ),
  freitext(
    'a3-ba-2',
    'b-aufgaben',
    scenario:
        'Im Task-Manager zeigt ein Browser 12 Prozesse und über 200 Threads.',
    prompt:
        'Erläutere den Unterschied zwischen einem Prozess und einem Thread.',
    kriterien: [
      krit(
        'Prozess: ein laufendes Programm mit eigenem Speicherbereich',
        stichwoerter: [
          'laufendes Programm',
          'eigener Speicher',
          'eigenem Speicher',
          'Adressraum',
        ],
      ),
      krit(
        'Thread: ein Ausführungsstrang innerhalb eines Prozesses, der sich dessen Speicher mit den anderen Threads teilt',
        stichwoerter: [
          'innerhalb',
          'Ausführungsstrang',
          'teilt',
          'gemeinsamer Speicher',
        ],
      ),
    ],
    loesung:
        'Ein Prozess ist ein laufendes Programm mit eigenem, geschütztem Speicherbereich. Ein Thread ist ein Ausführungsstrang innerhalb eines Prozesses; mehrere Threads eines Prozesses teilen sich dessen Speicher und arbeiten auf denselben Daten.',
    explanation:
        'Prozess: laufendes Programm mit eigenem Speicherbereich. Thread: Ausführungsstrang innerhalb eines Prozesses. Bewertung: je Begriff 1 Punkt.',
  ),
  freitext(
    'a3-ba-3',
    'b-aufgaben',
    scenario:
        'Ein neuer Etikettendrucker wird angeschlossen. Windows meldet „Unbekanntes Gerät“.',
    prompt: 'Beschreibe die Aufgabe eines Gerätetreibers.',
    kriterien: [
      krit(
        'Der Treiber übersetzt zwischen dem Betriebssystem und einer bestimmten Hardware',
        punkte: 2,
        stichwoerter: ['übersetzt', 'Schnittstelle', 'vermittelt', 'ansteuern'],
      ),
      krit(
        'Ohne passenden Treiber kann das Betriebssystem das Gerät nicht oder nur eingeschränkt nutzen',
        stichwoerter: [
          'ohne Treiber',
          'nicht nutzen',
          'nicht ansprechen',
          'erkennt',
        ],
      ),
    ],
    punkte: 2,
    loesung:
        'Ein Gerätetreiber ist ein Programm, das zwischen dem Betriebssystem und einem bestimmten Gerät übersetzt: Er kennt die Befehle der Hardware und stellt dem System einheitliche Funktionen bereit. Ohne Treiber kann das Betriebssystem das Gerät nicht ansprechen. Daher die Meldung.',
    explanation:
        'Treiber sind die Brücke zwischen dem allgemeinen Betriebssystem und einem konkreten Gerät. Bewertung: höchstens 2 Punkte.',
  ),
  rechnen(
    'a3-ba-4',
    'b-aufgaben',
    prompt:
        'Wie viel Arbeitsspeicher kann ein 32-Bit-Betriebssystem höchstens adressieren, wenn jede Adresse auf 1 Byte zeigt? Gib das Ergebnis in GiB an.',
    answer: 4,
    unit: 'GiB',
    explanation:
        '2³² Adressen × 1 Byte = 4.294.967.296 Byte. 4.294.967.296 / 1.024³ = 4 GiB. Mehr RAM braucht ein 64-Bit-System.',
  ),
  einfach(
    'a3-ba-5',
    'b-aufgaben',
    prompt:
        'Ein Prozess wartet darauf, dass Daten von der SSD gelesen werden. In welchem Zustand ist er?',
    choices: [
      ja(
        'blockiert',
        'Er wartet auf ein Ereignis (Ein-/Ausgabe) und kann so lange nicht rechnen.',
      ),
      nein(
        'bereit',
        'Bereit heißt: Er könnte sofort rechnen und wartet nur auf die CPU.',
      ),
      nein('rechnend', 'Er läuft gerade nicht, weil ihm Daten fehlen.'),
      nein(
        'beendet',
        'Der Prozess existiert weiter und setzt nach dem Lesen fort.',
      ),
    ],
    explanation:
        'Wartet ein Prozess auf Ein- oder Ausgabe, ist er blockiert. Sind die Daten da, wechselt er nach „bereit“ und bekommt später wieder CPU-Zeit.',
  ),
  einfach(
    'a3-ba-6',
    'b-aufgaben',
    prompt: 'Was kennzeichnet präemptives Multitasking?',
    choices: [
      ja(
        'Das Betriebssystem entzieht einem Prozess nach seiner Zeitscheibe die CPU.',
        'So kann ein hängendes Programm das System nicht blockieren.',
      ),
      nein(
        'Jedes Programm gibt die CPU freiwillig ab.',
        'Das ist kooperatives Multitasking.',
      ),
      nein(
        'Es läuft immer nur ein einziges Programm.',
        'Das wäre Singletasking.',
      ),
      nein(
        'Jedes Programm braucht einen eigenen Prozessorkern.',
        'Multitasking funktioniert auch auf einem Kern durch schnellen Wechsel.',
      ),
    ],
    explanation:
        'Beim präemptiven Multitasking verteilt der Scheduler Zeitscheiben und kann Prozesse jederzeit unterbrechen. Das ist heute Standard bei allen verbreiteten Betriebssystemen.',
  ),
  zuordnen(
    'a3-ba-7',
    'b-aufgaben',
    prompt: 'Läuft die Software im Kernelmodus oder im Benutzermodus?',
    buckets: ['Kernelmodus', 'Benutzermodus'],
    items: [
      zu('Textverarbeitung', 1),
      zu('Speicherverwaltung des Betriebssystems', 0),
      zu('Gerätetreiber für die Netzwerkkarte', 0),
      zu('Webbrowser', 1),
    ],
    explanation:
        'Kernel und Treiber haben vollen Hardwarezugriff (Kernelmodus). Anwendungen laufen eingeschränkt im Benutzermodus und nutzen Systemaufrufe.',
  ),
  mehrfach(
    'a3-ba-8',
    'b-aufgaben',
    prompt: 'Welche Aussagen zum virtuellen Speicher sind richtig?',
    choices: [
      ja(
        'Jeder Prozess erhält einen eigenen Adressraum.',
        'So können Programme sich nicht gegenseitig überschreiben.',
      ),
      ja(
        'Seiten können auf den Datenträger ausgelagert werden.',
        'Unter Windows in die Auslagerungsdatei, unter Linux in den Swap.',
      ),
      ja(
        'Häufiges Auslagern macht das System deutlich langsamer.',
        'Der Datenträger ist viel langsamer als RAM.',
      ),
      nein(
        'Virtueller Speicher macht zusätzlichen RAM überflüssig.',
        'Auslagern ist nur eine Notlösung, echter RAM ist viel schneller.',
      ),
      nein(
        'Virtueller Speicher ist ein anderer Name für den Cache.',
        'Der Cache ist ein schneller Hardwarespeicher im Prozessor.',
      ),
    ],
    explanation:
        'Das Betriebssystem bildet virtuelle Adressen auf echten RAM ab und lagert bei Bedarf aus. Das schützt Prozesse voreinander, ersetzt aber keinen RAM.',
  ),

  // ============================================================== Dateisysteme
  einfach(
    'a3-bd-1',
    'b-dateisysteme',
    scenario:
        'Ein 6 GB großes Video soll auf einen USB-Stick kopiert werden, der an Windows- und Mac-Rechnern funktionieren muss. Der Stick ist mit FAT32 formatiert, der Kopiervorgang bricht ab.',
    prompt: 'Welches Dateisystem sollte gewählt werden?',
    choices: [
      ja(
        'exFAT',
        'Unterstützt große Dateien und ist unter Windows und macOS lesbar und schreibbar.',
      ),
      nein(
        'FAT32',
        'Dateien über 4 GB sind nicht möglich, und genau daran scheitert der Vorgang.',
      ),
      nein('ext4', 'Wird von Windows und macOS nicht direkt unterstützt.'),
      nein(
        'NTFS',
        'macOS kann NTFS standardmäßig nur lesen, nicht beschreiben.',
      ),
    ],
    explanation:
        'exFAT ist das Dateisystem für Wechseldatenträger mit großen Dateien und breiter Kompatibilität.',
  ),
  zuordnen(
    'a3-bd-2',
    'b-dateisysteme',
    prompt: 'Welches Dateisystem passt zum Einsatz?',
    buckets: ['NTFS', 'ext4', 'exFAT'],
    items: [
      zu('Systemlaufwerk eines Windows-Servers mit Berechtigungen', 0),
      zu('Systempartition eines Linux-Servers', 1),
      zu('SD-Karte einer Kamera mit großen Videodateien', 2),
      zu('Dateiserver-Freigabe mit NTFS-Rechten', 0),
    ],
    explanation:
        'NTFS für Windows mit Rechten, ext4 für Linux, exFAT für austauschbare Datenträger.',
  ),
  freitext(
    'a3-bd-3',
    'b-dateisysteme',
    scenario:
        'Nach einem Stromausfall ist ein Server mit NTFS nach Sekunden wieder bereit. Ein alter Rechner mit FAT32 prüft dagegen minutenlang den ganzen Datenträger.',
    prompt: 'Erläutere den Vorteil eines Journaling-Dateisystems.',
    kriterien: [
      krit(
        'Geplante Änderungen werden zuerst in einem Journal protokolliert',
        stichwoerter: [
          'Journal',
          'protokolliert',
          'Protokoll',
          'aufgezeichnet',
        ],
      ),
      krit(
        'Nach einem Absturz lässt sich das Dateisystem schnell wieder in einen konsistenten Zustand bringen',
        stichwoerter: ['konsistent', 'schnell', 'Wiederherstellung', 'Absturz'],
      ),
    ],
    loesung:
        'Ein Journaling-Dateisystem schreibt geplante Änderungen zuerst in ein Journal. Nach einem Absturz zeigt das Journal, welche Änderungen unvollständig waren; sie werden abgeschlossen oder verworfen. So ist das Dateisystem schnell wieder konsistent, ohne dass der ganze Datenträger geprüft werden muss.',
    explanation:
        'Journaling protokolliert geplante Änderungen und beschleunigt so die Wiederherstellung nach Abstürzen. Es schützt die Struktur des Dateisystems, nicht jede gerade geschriebene Datei. Bewertung: je Aussage 1 Punkt.',
  ),
  rechnen(
    'a3-bd-4',
    'b-dateisysteme',
    scenario:
        'Eine Datei ist 18.000 Byte groß. Das Dateisystem arbeitet mit einer Clustergröße von 4 KiB.',
    prompt: 'Wie viele Byte belegt die Datei auf dem Datenträger?',
    answer: 20480,
    unit: 'Byte',
    explanation:
        '4 KiB = 4.096 Byte. 18.000 / 4.096 ≈ 4,39 - angefangene Cluster zählen voll, also 5 Cluster. 5 × 4.096 = 20.480 Byte.',
  ),
  einfach(
    'a3-bd-5',
    'b-dateisysteme',
    scenario:
        'Du befindest dich unter Linux im Verzeichnis /home/anna und gibst cd ../ben/projekt ein.',
    prompt: 'In welchem Verzeichnis landest du?',
    choices: [
      ja(
        '/home/ben/projekt',
        '„..“ führt eine Ebene nach oben nach /home, von dort nach ben/projekt.',
      ),
      nein('/home/anna/ben/projekt', 'Das wäre der relative Pfad ohne „..“.'),
      nein('/ben/projekt', 'Das wäre ein absoluter Pfad ab der Wurzel.'),
      nein(
        '/home/anna/../projekt',
        'Kein gültiges Ergebnis - „..“ wird aufgelöst, und ben fehlt.',
      ),
    ],
    explanation:
        'Relative Pfade gehen vom aktuellen Verzeichnis aus; „..“ steht für das übergeordnete Verzeichnis.',
    difficulty: 1,
  ),
  reihenfolge(
    'a3-bd-6',
    'b-dateisysteme',
    prompt:
        'Ein neuer Datenträger wird in einen Server eingebaut. Bringe die Schritte in die richtige Reihenfolge.',
    items: [
      'Partitionstabelle anlegen und partitionieren',
      'Partition mit einem Dateisystem formatieren',
      'Laufwerksbuchstaben zuweisen bzw. einhängen',
      'Zugriffsrechte festlegen',
    ],
    explanation:
        'Ohne Partition kein Dateisystem, ohne Dateisystem kein Einhängen, und Rechte lassen sich erst auf einem eingebundenen Dateisystem setzen.',
  ),
  einfach(
    'a3-bd-7',
    'b-dateisysteme',
    scenario:
        'Eine neue 4-TB-Festplatte wird mit MBR-Partitionstabelle eingerichtet. Windows bietet nur rund 2 TB zur Nutzung an.',
    prompt: 'Wie löst du das Problem?',
    choices: [
      ja(
        'Den Datenträger mit GPT initialisieren',
        'GPT hat die 2-TiB-Grenze von MBR nicht.',
      ),
      nein(
        'Mit FAT32 statt NTFS formatieren',
        'Die Grenze liegt in der Partitionstabelle, nicht im Dateisystem.',
      ),
      nein(
        'Vier primäre Partitionen anlegen',
        'Auch mehrere MBR-Partitionen kommen nicht über die 2-TiB-Grenze.',
      ),
      nein('Die Festplatte umtauschen', 'Die Festplatte ist in Ordnung.'),
    ],
    explanation:
        'MBR kann höchstens 2 TiB adressieren. GPT (mit UEFI) unterstützt praktisch unbegrenzt große Datenträger.',
  ),
  mehrfach(
    'a3-bd-8',
    'b-dateisysteme',
    prompt: 'Welche Aussagen zum Löschen von Daten sind richtig?',
    choices: [
      ja(
        'Nach einer Schnellformatierung lassen sich Daten oft wiederherstellen.',
        'Nur das Inhaltsverzeichnis wird neu angelegt.',
      ),
      ja(
        'Vor der Entsorgung müssen Datenträger sicher überschrieben oder vernichtet werden.',
        'Sonst gelangen Daten in fremde Hände.',
      ),
      ja(
        'Bei SSDs eignet sich die Funktion Secure Erase des Herstellers.',
        'Einfaches Überschreiben erreicht bei SSDs nicht jede Zelle.',
      ),
      nein(
        'Das Leeren des Papierkorbs löscht Daten unwiderruflich.',
        'Nur der Verweis verschwindet, die Daten bleiben zunächst erhalten.',
      ),
      nein(
        'Eine Schnellformatierung überschreibt alle Daten mit Nullen.',
        'Sie legt nur ein neues, leeres Dateisystem an.',
      ),
    ],
    explanation:
        'Löschen und Formatieren entfernen meist nur Verweise. Sicher sind Überschreiben, Secure Erase oder physische Vernichtung mit Nachweis.',
  ),

  // ======================================================== Benutzer und Rechte
  lueckentext(
    'a3-br-1',
    'b-rechte',
    scenario: 'Eine Datei erhält mit chmod 754 neue Rechte.',
    prompt: 'Welche Rechte gelten für wen?',
    text:
        'Besitzer: {0}\n'
        'Gruppe: {1}\n'
        'Andere: {2}',
    luecken: [
      wahl('rwx', ['rw-', 'r-x', 'r--'], '7 = 4 + 2 + 1'),
      wahl('r-x', ['rwx', 'rw-', 'r--'], '5 = 4 + 1'),
      wahl('r--', ['r-x', 'rw-', '--x'], '4'),
    ],
    explanation:
        'r = 4, w = 2, x = 1. 7 = 4 + 2 + 1 = rwx, 5 = 4 + 1 = r-x, 4 = r--. Zusammen: rwxr-xr--.',
  ),
  einfach(
    'a3-br-2',
    'b-rechte',
    scenario:
        'Eine neue Mitarbeiterin in der Buchhaltung soll auf den Ordner „Rechnungen“ zugreifen können.',
    prompt: 'Wie vergibt man die Rechte am besten?',
    choices: [
      ja(
        'Sie wird Mitglied der Gruppe Buchhaltung, die die nötigen Rechte hat.',
        'Rechte an Gruppen erleichtern Verwaltung und Kontrolle.',
      ),
      nein(
        'Sie erhält Vollzugriff direkt auf den Ordner.',
        'Mehr Rechte als nötig und schwer nachzuhalten.',
      ),
      nein(
        'Sie bekommt das Administratorkonto.',
        'Verstößt grob gegen das Minimalprinzip.',
      ),
      nein(
        'Sie nutzt das Konto ihrer Vorgängerin.',
        'Geteilte Konten machen Handlungen nicht mehr zuordenbar.',
      ),
    ],
    explanation:
        'Minimalprinzip und Gruppenrechte: Jede Person bekommt über ihre Rolle genau die Rechte, die sie braucht.',
  ),
  einfach(
    'a3-br-3',
    'b-rechte',
    scenario:
        'Auf einen Ordner gilt die Freigabeberechtigung „Lesen“ und die NTFS-Berechtigung „Ändern“.',
    prompt: 'Welche Rechte hat ein Benutzer beim Zugriff über das Netzwerk?',
    choices: [
      ja(
        'Lesen',
        'Beim Netzzugriff gilt die strengere der beiden Berechtigungen.',
      ),
      nein('Ändern', 'Das gilt nur bei lokalem Zugriff.'),
      nein(
        'Vollzugriff',
        'Keine der beiden Berechtigungen gewährt Vollzugriff.',
      ),
      nein('Kein Zugriff', 'Beide Berechtigungen erlauben mindestens Lesen.'),
    ],
    explanation:
        'Freigabe- und NTFS-Rechte werden kombiniert: wirksam ist immer die restriktivere Berechtigung.',
  ),
  rechnen(
    'a3-br-4',
    'b-rechte',
    prompt:
        'Eine Datei soll die Rechte rw-r----- erhalten. Welche Zahl gehört hinter chmod?',
    answer: 640,
    explanation:
        'Besitzer rw- = 4 + 2 = 6. Gruppe r-- = 4. Andere --- = 0. Ergebnis: chmod 640.',
  ),
  rechnen(
    'a3-br-5',
    'b-rechte',
    scenario: 'ls -l zeigt: -rwxr-x--x 1 root admins 4096 backup.sh',
    prompt: 'Welcher chmod-Wert entspricht diesen Rechten?',
    answer: 751,
    explanation:
        'Das erste Zeichen „-“ ist der Dateityp. Besitzer rwx = 7, Gruppe r-x = 4 + 1 = 5, andere --x = 1. Ergebnis: 751.',
    difficulty: 3,
  ),
  zuordnen(
    'a3-br-6',
    'b-rechte',
    prompt:
        'Welches Recht braucht man für die Aktion in einem Linux-Verzeichnis?',
    buckets: ['r', 'w', 'x'],
    items: [
      zu('Eine neue Datei im Verzeichnis anlegen', 1),
      zu('Eine Datei im Verzeichnis löschen', 1),
      zu('Mit cd in das Verzeichnis wechseln', 2),
      zu('Die Dateinamen im Verzeichnis auflisten', 0),
    ],
    explanation:
        'Bei Verzeichnissen heißt r auflisten, w Einträge anlegen, löschen oder umbenennen und x hineinwechseln.',
    difficulty: 3,
  ),
  zuordnen(
    'a3-br-7',
    'b-rechte',
    prompt: 'Gehört der Vorgang zur Authentifizierung oder zur Autorisierung?',
    buckets: ['Authentifizierung', 'Autorisierung'],
    items: [
      zu('Passwort bei der Anmeldung eingeben', 0),
      zu('Die Gruppe Buchhaltung darf den Ordner Rechnungen ändern', 1),
      zu('Fingerabdruck am Notebook scannen', 0),
      zu('Eine Datei erhält die Rechte chmod 640', 1),
      zu('Einmalcode aus der Authenticator-App eintippen', 0),
      zu('Die Rolle Praktikant darf nur lesen', 1),
    ],
    explanation:
        'Authentifizierung: Wer bist du (Passwort, Token, Fingerabdruck)? Autorisierung: Was darfst du (Rechte, Rollen)? Erst wird die Identität geprüft, dann gelten die Rechte.',
    difficulty: 1,
  ),
  einfach(
    'a3-br-8',
    'b-rechte',
    scenario:
        'Ein Mitarbeiter ist Mitglied der Gruppen Vertrieb und Praktikanten. Auf einem Ordner hat Vertrieb die NTFS-Berechtigung „Ändern: Zulassen“, Praktikanten haben „Schreiben: Verweigern“.',
    prompt: 'Was darf er in dem Ordner?',
    choices: [
      ja(
        'Lesen, aber nicht schreiben',
        'Ein ausdrückliches Verweigern hat Vorrang vor jedem Zulassen.',
      ),
      nein(
        'Alles, was „Ändern“ erlaubt',
        'Das Verweigern der Praktikanten-Gruppe hebt das Schreibrecht auf.',
      ),
      nein(
        'Gar nichts',
        'Verweigert ist nur Schreiben, Lesen bleibt über Vertrieb erlaubt.',
      ),
      nein('Vollzugriff', 'Keine der beiden Gruppen hat Vollzugriff.'),
    ],
    explanation:
        'NTFS-Rechte mehrerer Gruppen addieren sich, aber ein ausdrückliches Verweigern schlägt jedes Zulassen.',
    difficulty: 3,
  ),
  einfach(
    'a3-br-9',
    'b-rechte',
    scenario:
        'Die Datei start.sh hat die Rechte rw-r--r--. Du gibst chmod u+x start.sh ein.',
    prompt: 'Welche Rechte hat die Datei danach?',
    choices: [
      ja(
        'rwxr--r--',
        'u+x fügt nur dem Besitzer (user) das Ausführungsrecht hinzu.',
      ),
      nein('rwxr-xr-x', 'Das wäre a+x: Ausführen für alle.'),
      nein('rw-r--r-x', 'o steht für andere, u für den Besitzer.'),
      nein('--x------', '+ fügt hinzu, es ersetzt nicht die übrigen Rechte.'),
    ],
    explanation:
        'Symbolisch: u = Besitzer, g = Gruppe, o = andere, a = alle. + fügt ein Recht hinzu, - entfernt es, = setzt genau.',
  ),

  // ============================================================== Kommandozeile
  zuordnen(
    'a3-bc-1',
    'b-cli',
    prompt: 'Ordne jedem Windows-Befehl das Linux-Gegenstück zu.',
    buckets: ['ls', 'cp', 'ip a', 'traceroute'],
    items: [zu('ipconfig', 2), zu('dir', 0), zu('tracert', 3), zu('copy', 1)],
    explanation: 'dir → ls, copy → cp, ipconfig → ip a, tracert → traceroute.',
  ),
  einfach(
    'a3-bc-2',
    'b-cli',
    scenario:
        'ping 8.8.8.8 funktioniert, ping www.beispiel.de meldet „Host nicht gefunden“.',
    prompt: 'Wo liegt das Problem am wahrscheinlichsten?',
    choices: [
      ja(
        'Bei der Namensauflösung (DNS)',
        'Die Verbindung ins Internet steht; nur Namen werden nicht in Adressen übersetzt.',
      ),
      nein(
        'Beim Netzwerkkabel',
        'Dann würde auch der Ping auf die IP-Adresse scheitern.',
      ),
      nein(
        'Beim Standardgateway',
        'Ohne Gateway wäre auch 8.8.8.8 nicht erreichbar.',
      ),
      nein(
        'Beim DHCP-Server',
        'Der Rechner hat offensichtlich eine funktionierende Adresse.',
      ),
    ],
    explanation:
        'IP-Adressen erreichbar, Namen nicht: Das ist das Muster eines DNS-Problems, das du mit nslookup prüfen kannst.',
  ),
  reihenfolge(
    'a3-bc-3',
    'b-cli',
    prompt:
        'In welcher Reihenfolge grenzt man einen Netzwerkfehler von innen nach außen ein?',
    items: [
      'ipconfig: eigene IP-Konfiguration prüfen',
      'ping auf das Standardgateway',
      'ping auf eine externe IP-Adresse',
      'nslookup bzw. ping auf einen Namen',
    ],
    explanation:
        'Erst die eigene Konfiguration, dann das lokale Netz, dann das Routing ins Internet, zuletzt die Namensauflösung.',
  ),
  einfach(
    'a3-bc-4',
    'b-cli',
    scenario:
        'ipconfig zeigt bei einem Arbeitsplatz-PC die Adresse 169.254.23.7 mit der Maske 255.255.0.0 und kein Standardgateway.',
    prompt: 'Was ist die wahrscheinlichste Ursache?',
    choices: [
      ja(
        'Der PC hat keine Antwort von einem DHCP-Server erhalten.',
        '169.254.x.x ist eine APIPA-Adresse, die sich der PC selbst gibt.',
      ),
      nein(
        'Der DNS-Server ist ausgefallen.',
        'DNS hat mit der Adressvergabe nichts zu tun.',
      ),
      nein(
        'Der PC hat eine gültige öffentliche Adresse.',
        '169.254.0.0/16 ist nicht öffentlich und nicht routbar.',
      ),
      nein(
        'Die Firewall blockiert ping.',
        'Das erklärt nicht die selbst vergebene Adresse.',
      ),
    ],
    explanation:
        'Eine 169.254er-Adresse ohne Gateway heißt: DHCP hat nicht geantwortet. Kabel, Switchport, VLAN und DHCP-Server prüfen, dann ipconfig /renew.',
  ),
  zuordnen(
    'a3-bc-5',
    'b-cli',
    prompt: 'Welcher Linux-Befehl erfüllt die Aufgabe?',
    buckets: ['pwd', 'grep', 'df -h', 'sudo'],
    items: [
      zu('In einer Logdatei nach „error“ suchen', 1),
      zu('Einen Befehl mit Administratorrechten ausführen', 3),
      zu('Den freien Platz auf den Datenträgern anzeigen', 2),
      zu('Das aktuelle Verzeichnis anzeigen', 0),
    ],
    explanation:
        'pwd zeigt den Pfad, grep sucht Text, df -h zeigt belegten und freien Speicher, sudo führt mit erhöhten Rechten aus.',
  ),
  paare(
    'a3-bc-6',
    'b-cli',
    scenario: 'In einem Skript steht die Zeile: echo Fehler >> log.txt',
    prompt: 'Ordne jedem Zeichen bzw. Befehl seine Wirkung zu.',
    paare: [
      paar('>', 'überschreibt die Zieldatei'),
      paar('>>', 'hängt an die Zieldatei an'),
      paar('|', 'gibt die Ausgabe an den nächsten Befehl'),
      paar('grep', 'filtert Zeilen nach einem Suchtext'),
    ],
    explanation:
        '> leitet die Ausgabe in eine Datei um und überschreibt sie, >> hängt an. Die Zeile im Skript ergänzt log.txt also um „Fehler“. | verkettet Befehle, grep (Windows: findstr) sucht Text.',
    difficulty: 1,
  ),
  einfach(
    'a3-bc-7',
    'b-cli',
    scenario:
        'Ein Webserver hat eine neue IP-Adresse bekommen. Ein Windows-Client landet trotz korrigiertem DNS-Eintrag noch bei der alten Adresse.',
    prompt: 'Welcher Befehl hilft auf dem Client?',
    choices: [
      ja(
        'ipconfig /flushdns',
        'Leert den DNS-Zwischenspeicher, sodass der Name neu aufgelöst wird.',
      ),
      nein('ipconfig /release', 'Gibt nur die eigene DHCP-Adresse ab.'),
      nein(
        'gpupdate /force',
        'Wendet Gruppenrichtlinien an, betrifft den DNS-Cache nicht.',
      ),
      nein('tracert', 'Zeigt nur den Weg der Pakete.'),
    ],
    explanation:
        'Der Client hat die alte Antwort noch im DNS-Cache. ipconfig /flushdns löscht ihn, danach wird der Name neu aufgelöst.',
  ),
  einfach(
    'a3-bc-8',
    'b-cli',
    scenario:
        'Ein Webserver antwortet nicht auf ping, die Webseite lässt sich im Browser aber problemlos öffnen.',
    prompt: 'Was ist die wahrscheinlichste Erklärung?',
    choices: [
      ja(
        'Eine Firewall blockiert ICMP, das Protokoll hinter ping.',
        'Der Webdienst auf Port 443 ist trotzdem erreichbar.',
      ),
      nein(
        'Der Server ist ausgefallen.',
        'Dann ließe sich die Webseite nicht öffnen.',
      ),
      nein(
        'Die DNS-Auflösung ist defekt.',
        'Dann würde auch der Browser den Server nicht finden.',
      ),
      nein(
        'Das Netzwerkkabel des Clients ist defekt.',
        'Dann ginge gar nichts.',
      ),
    ],
    explanation:
        'Kein ping heißt nicht offline. Dienste prüft man gezielt am Port, z. B. mit Test-NetConnection server -Port 443.',
  ),
  mehrfach(
    'a3-bc-9',
    'b-cli',
    prompt:
        'Ein Skript enthält die Zeile tar -czf /backup/projekt.tar.gz /home/anna/projekt. Welche Aussagen sind richtig?',
    choices: [
      ja(
        'Es packt den Ordner /home/anna/projekt in ein Archiv.',
        'tar fasst Dateien zu einem Archiv zusammen.',
      ),
      ja(
        'Das Archiv wird komprimiert.',
        'Die Option z steht für gzip-Kompression.',
      ),
      ja(
        'Das Archiv landet unter /backup/projekt.tar.gz.',
        'Hinter -f steht der Name der Archivdatei.',
      ),
      nein(
        'Der Ordner wird nach dem Packen gelöscht.',
        'tar lässt die Originaldateien unverändert.',
      ),
      nein(
        'Das Skript läuft automatisch jede Nacht.',
        'Dafür muss es zusätzlich zeitgesteuert werden, etwa per cron.',
      ),
    ],
    explanation:
        'tar -czf erstellt (c) ein gzip-komprimiertes (z) Archiv in die Datei (f). Automatisiert wird mit cron bzw. der Windows-Aufgabenplanung.',
    difficulty: 3,
  ),

  // ========================================================= Updates und Härtung
  mehrfach(
    'a3-bh-1',
    'b-haertung',
    prompt: 'Welche Maßnahmen gehören zur Härtung eines Servers?',
    choices: [
      ja(
        'Nicht benötigte Dienste deaktivieren',
        'Jeder laufende Dienst ist ein mögliches Angriffsziel.',
      ),
      ja(
        'Standardpasswörter ändern',
        'Standardpasswörter sind öffentlich bekannt.',
      ),
      ja('Sicherheitsupdates zeitnah einspielen', 'Schließt bekannte Lücken.'),
      nein(
        'Alle Ports in der Firewall öffnen, um Probleme zu vermeiden',
        'Genau das vergrößert die Angriffsfläche.',
      ),
      nein(
        'Allen Benutzern Administratorrechte geben',
        'Verstößt gegen das Minimalprinzip.',
      ),
    ],
    explanation:
        'Härtung verkleinert die Angriffsfläche: weniger Dienste, sichere Zugänge, aktuelle Software, restriktive Rechte.',
  ),
  freitext(
    'a3-bh-2',
    'b-haertung',
    scenario:
        'Ein Sicherheitsportal warnt vor einer Zero-Day-Lücke in einer verbreiteten Fernwartungssoftware, die bereits ausgenutzt wird.',
    prompt:
        'Erläutere, was eine Zero-Day-Lücke ist, und nenne eine Schutzmaßnahme.',
    kriterien: [
      krit(
        'Eine Schwachstelle, für die es noch kein Update des Herstellers gibt',
        punkte: 2,
        stichwoerter: [
          'kein Update',
          'kein Patch',
          'noch nicht geschlossen',
          'unbekannt',
        ],
      ),
      krit(
        'Schutz bis zum Patch: betroffenen Dienst abschalten oder abschotten, Rechte beschränken, System überwachen',
        stichwoerter: [
          'abschalten',
          'abschotten',
          'isolieren',
          'Rechte',
          'überwachen',
          'Härtung',
        ],
      ),
    ],
    loesung:
        'Eine Zero-Day-Lücke ist eine Schwachstelle, für die der Hersteller noch kein Update bereitstellt. Er hatte „null Tage“ Zeit zu reagieren. Bis ein Patch erscheint, helfen nur Härtung und Umgehungen: den betroffenen Dienst abschalten oder vom Internet abschotten, Rechte beschränken und das System überwachen.',
    explanation:
        'Gegen Zero-Day-Lücken helfen nur Härtung, Rechtebeschränkung und Überwachung, bis ein Patch erscheint. Bewertung: 2 Punkte für die Erklärung, 1 Punkt für eine Maßnahme.',
  ),
  reihenfolge(
    'a3-bh-3',
    'b-haertung',
    prompt:
        'Bringe die Schritte des Patchmanagements in die richtige Reihenfolge.',
    items: [
      'Updates erfassen und bewerten',
      'Auf Testsystemen prüfen',
      'Schrittweise verteilen',
      'Erfolg kontrollieren und dokumentieren',
    ],
    explanation:
        'Getestet wird vor der Verteilung. Ein fehlerhaftes Update kann sonst alle Systeme gleichzeitig lahmlegen.',
  ),
  zuordnen(
    'a3-bh-4',
    'b-haertung',
    prompt: 'Auf welcher Ebene setzt die Härtungsmaßnahme an?',
    buckets: ['Konten', 'Dienste und Ports', 'System'],
    items: [
      zu('Nicht benötigte Ports in der Firewall schließen', 1),
      zu('Datenträger mit BitLocker verschlüsseln', 2),
      zu('Standardpasswort des Administrators ändern', 0),
      zu('Secure Boot aktivieren', 2),
      zu('Anmeldung mit zweitem Faktor einführen', 0),
      zu('Telnet-Dienst deinstallieren', 1),
    ],
    explanation:
        'Härtung setzt auf allen Ebenen an: sichere Konten, möglichst wenige Dienste und offene Ports sowie ein geschütztes, aktuelles System.',
  ),
  einfach(
    'a3-bh-5',
    'b-haertung',
    scenario:
        'In der Produktion steuert ein PC mit einem Betriebssystem ohne Herstellersupport eine Maschine. Die Steuersoftware läuft auf keinem neueren System.',
    prompt: 'Welche Maßnahme ist am sinnvollsten?',
    choices: [
      ja(
        'Den PC vom übrigen Netz abschotten und die Ablösung planen',
        'Ohne Updates bleibt jede neue Lücke offen; Isolation begrenzt das Risiko.',
      ),
      nein(
        'Nichts tun, solange die Maschine läuft',
        'Das Risiko wächst mit jeder neu entdeckten Lücke.',
      ),
      nein(
        'Den PC direkt ins Internet stellen, damit er Updates sucht',
        'Es gibt keine Updates mehr. So vergrößert sich nur die Angriffsfläche.',
      ),
      nein(
        'Den Virenschutz deinstallieren, um Leistung zu sparen',
        'Schwächt den Schutz zusätzlich.',
      ),
    ],
    explanation:
        'End-of-Life-Systeme bekommen keine Sicherheitsupdates. Wenn sie nicht sofort ersetzt werden können, werden sie isoliert und ihre Ablösung wird geplant.',
  ),
  einfach(
    'a3-bh-6',
    'b-haertung',
    prompt:
        'Warum werden Updates in Unternehmen in Wellen verteilt, zuerst an eine Pilotgruppe?',
    choices: [
      ja(
        'Fehlerhafte Updates fallen so auf, bevor sie alle Rechner lahmlegen.',
        'Die Pilotgruppe wirkt als Frühwarnsystem.',
      ),
      nein(
        'Weil Updates sonst nicht installiert werden können',
        'Technisch ginge die Verteilung an alle gleichzeitig.',
      ),
      nein(
        'Um Lizenzkosten zu sparen',
        'Updates werden nicht pro Welle lizenziert.',
      ),
      nein(
        'Weil Pilotrechner schneller sind',
        'Die Geschwindigkeit spielt dafür keine Rolle.',
      ),
    ],
    explanation:
        'Gestaffelte Verteilung mit Backup oder Snapshot vorab begrenzt den Schaden eines fehlerhaften Updates und ermöglicht einen Rollback.',
    difficulty: 1,
  ),
  mehrfach(
    'a3-bh-7',
    'b-haertung',
    prompt: 'Welche Maßnahmen härten den SSH-Zugang eines Linux-Servers?',
    choices: [
      ja(
        'Anmeldung als root direkt per SSH verbieten',
        'Angreifer kennen den Namen root; persönliche Konten mit sudo sind sicherer.',
      ),
      ja(
        'Anmeldung mit Schlüsselpaar statt Passwort',
        'Schlüssel lassen sich nicht erraten.',
      ),
      ja('Den SSH-Server aktuell halten', 'Schließt bekannte Lücken.'),
      nein(
        'Zusätzlich Telnet auf Port 23 anbieten',
        'Telnet überträgt alles im Klartext.',
      ),
      nein(
        'Ein einfaches gemeinsames Passwort für alle Admins',
        'Leicht zu erraten und nicht einer Person zuordenbar.',
      ),
    ],
    explanation:
        'Sicherer SSH-Zugang: kein direkter root-Login, Schlüssel statt Passwort, persönliche Konten, aktuelle Software.',
  ),
  einfach(
    'a3-bh-8',
    'b-haertung',
    prompt: 'Wozu dient unter Linux der Befehl ss -tulpen bei der Härtung?',
    choices: [
      ja(
        'Er zeigt, welche Programme auf welchen Ports lauschen.',
        'So findest du Dienste, die abgeschaltet werden können.',
      ),
      nein(
        'Er schließt alle offenen Ports.',
        'ss zeigt nur an, es ändert nichts.',
      ),
      nein(
        'Er installiert Sicherheitsupdates.',
        'Dafür ist die Paketverwaltung zuständig.',
      ),
      nein('Er verschlüsselt die Festplatte.', 'Dafür gibt es z. B. LUKS.'),
    ],
    explanation:
        'Vor dem Abschalten steht die Bestandsaufnahme: ss -tulpen (Linux) oder netstat -an (Windows) listet die lauschenden Ports.',
  ),

  // =============================================================== ERP, SCM, CRM
  zuordnen(
    'a3-au-1',
    'an-unternehmen',
    prompt: 'Welches System unterstützt die Aufgabe am besten?',
    buckets: ['ERP', 'SCM', 'CRM'],
    items: [
      zu(
        'Finanzbuchhaltung, Lager und Personal auf einer gemeinsamen Datenbasis',
        0,
      ),
      zu('Liefermengen mit Zulieferern abstimmen', 1),
      zu('Die Historie aller Gespräche mit einem Kunden einsehen', 2),
      zu('Vertriebschancen und Angebote verfolgen', 2),
      zu('Transportwege und Lagerbestände entlang der Lieferkette planen', 1),
    ],
    explanation:
        'ERP: gesamtes Unternehmen. SCM: Lieferkette. CRM: Kundenbeziehungen.',
  ),
  einfach(
    'a3-au-2',
    'an-unternehmen',
    prompt:
        'Welcher Vorteil ergibt sich aus der gemeinsamen Datenbank eines ERP-Systems?',
    choices: [
      ja(
        'Alle Abteilungen arbeiten mit denselben aktuellen Daten, doppelte Erfassung entfällt.',
        'Das ist der Kern der Integration.',
      ),
      nein(
        'Jede Abteilung kann ihre Daten unabhängig verändern.',
        'Genau das soll vermieden werden.',
      ),
      nein(
        'Das System braucht keine Datensicherung.',
        'Gerade zentrale Daten müssen gesichert werden.',
      ),
      nein(
        'Es sind keine Benutzerrechte nötig.',
        'Rechte sind bei zentralen Daten besonders wichtig.',
      ),
    ],
    explanation:
        'ERP integriert die Unternehmensbereiche: Eine Buchung im Einkauf ist sofort im Lager und in der Buchhaltung sichtbar.',
  ),
  lueckentext(
    'a3-au-3',
    'an-unternehmen',
    prompt: 'Ergänze die ausgeschriebenen Abkürzungen.',
    text:
        'CRM steht für Customer {0} Management. '
        'ERP steht für Enterprise {1} Planning. '
        'SCM steht für Supply {2} Management.',
    luecken: [
      wort(['Relationship']),
      wort(['Resource']),
      wort(['Chain']),
    ],
    wortbank: ['Risk', 'Record', 'Cloud'],
    explanation:
        'CRM = Customer Relationship Management (Kundenbeziehungen), ERP = Enterprise Resource Planning (Planung der Unternehmensressourcen), SCM = Supply Chain Management (Lieferkette).',
    difficulty: 1,
  ),
  zuordnen(
    'a3-au-4',
    'an-unternehmen',
    prompt: 'Zu welchem Bereich des CRM gehört die Tätigkeit?',
    buckets: ['operatives CRM', 'analytisches CRM', 'kommunikatives CRM'],
    items: [
      zu(
        'Anfragen aus E-Mail, Telefon und Chat in einer Oberfläche bündeln',
        2,
      ),
      zu('Umsatz je Kundengruppe vergleichen', 1),
      zu('Ein Service-Ticket bearbeiten', 0),
      zu('Auswerten, welche Kunden abzuwandern drohen', 1),
      zu('Ein Angebot für einen Kunden erstellen', 0),
    ],
    explanation:
        'Operativ: Tagesgeschäft mit dem Kunden. Analytisch: Auswertung der Kundendaten. Kommunikativ: Steuerung und Bündelung der Kontaktkanäle.',
    difficulty: 3,
  ),
  zuordnen(
    'a3-au-5',
    'an-unternehmen',
    prompt: 'Welches System passt zur Anforderung?',
    buckets: ['DMS', 'BI', 'HRM', 'CMS'],
    items: [
      zu('Bewerbungen, Urlaubsanträge und Arbeitszeiten verwalten', 2),
      zu('Die Firmenwebseite ohne Programmierkenntnisse pflegen', 3),
      zu('Verträge revisionssicher ablegen und per Volltext finden', 0),
      zu(
        'Umsatzkennzahlen aus mehreren Systemen in einem Dashboard auswerten',
        1,
      ),
    ],
    explanation:
        'DMS verwaltet Dokumente, BI wertet Daten aus, HRM unterstützt das Personalwesen, ein CMS pflegt Webinhalte.',
  ),
  reihenfolge(
    'a3-au-6',
    'an-unternehmen',
    prompt:
        'Bringe die Stationen eines Kundenauftrags im ERP-System in die richtige Reihenfolge.',
    items: [
      'Vertrieb erfasst den Auftrag',
      'Lager prüft die Verfügbarkeit',
      'Fehlende Ware wird beschafft oder gefertigt',
      'Versand liefert, der Bestand sinkt',
      'Buchhaltung stellt die Rechnung und überwacht die Zahlung',
    ],
    explanation:
        'Der Auftrag durchläuft Vertrieb, Lager, Beschaffung bzw. Produktion, Versand und Buchhaltung. Jedes Modul arbeitet mit denselben Daten weiter.',
  ),
  einfach(
    'a3-au-7',
    'an-unternehmen',
    prompt:
        'Wie heißt der strukturierte, elektronische Austausch von Bestellungen und Rechnungen zwischen den Systemen zweier Unternehmen?',
    choices: [
      ja(
        'EDI (Electronic Data Interchange)',
        'Geschäftsdokumente werden in festen Formaten automatisch ausgetauscht.',
      ),
      nein('CRM', 'CRM verwaltet Kundenbeziehungen im eigenen Unternehmen.'),
      nein(
        'BI',
        'BI wertet Daten aus, tauscht sie aber nicht mit Partnern aus.',
      ),
      nein('DMS', 'Ein DMS legt Dokumente ab.'),
    ],
    explanation:
        'EDI verbindet die Systeme von Geschäftspartnern. Ein Beispiel ist die E-Rechnung, die Unternehmen in Deutschland seit 2025 empfangen können müssen.',
  ),
  mehrfach(
    'a3-au-8',
    'an-unternehmen',
    prompt:
        'Welche Nachteile oder Risiken hat die Einführung eines ERP-Systems?',
    choices: [
      ja(
        'Hohe Einführungskosten',
        'Lizenzen, Beratung und Datenübernahme kosten viel.',
      ),
      ja('Abhängigkeit vom Hersteller', 'Ein Wechsel ist später aufwendig.'),
      ja(
        'Schulungsaufwand für alle Beschäftigten',
        'Neue Abläufe müssen gelernt werden.',
      ),
      nein(
        'Doppelte Datenhaltung in den Abteilungen',
        'Genau die beseitigt ein ERP-System.',
      ),
      nein(
        'Keine Auswertungen mehr möglich',
        'Im Gegenteil: Auswertungen werden einfacher.',
      ),
    ],
    explanation:
        'ERP bringt Integration und Transparenz, verlangt aber Investitionen, Schulung und bindet an einen Hersteller.',
  ),

  // ================================================== Standard- oder Individualsoftware
  zuordnen(
    'a3-as-1',
    'an-software',
    prompt: 'Auf welche Art von Software trifft die Aussage zu?',
    buckets: ['Standardsoftware', 'Individualsoftware'],
    items: [
      zu('Sofort verfügbar', 0),
      zu('Genau auf die eigenen Abläufe zugeschnitten', 1),
      zu('Die Entwicklungskosten verteilen sich auf viele Kunden', 0),
      zu('Der Auftraggeber bestimmt über die Weiterentwicklung', 1),
      zu('Hohe Anfangskosten und lange Wartezeit', 1),
      zu('Updates für alle Kunden kommen vom Hersteller', 0),
    ],
    explanation:
        'Standardsoftware: günstig, schnell verfügbar, vom Hersteller gepflegt. Individualsoftware: passgenau und selbstbestimmt, aber teuer und erst nach der Entwicklung verfügbar.',
  ),
  einfach(
    'a3-as-2',
    'an-software',
    prompt: 'Was versteht man unter Customizing?',
    choices: [
      ja(
        'Anpassen von Standardsoftware über Einstellungen, ohne den Programmcode zu ändern',
        'Bleibt bei Updates erhalten.',
      ),
      nein(
        'Neuentwicklung einer Software für einen Kunden',
        'Das ist Individualentwicklung.',
      ),
      nein('Verkauf von Software an Kunden', 'Das ist Vertrieb.'),
      nein(
        'Deinstallation nicht benötigter Programme',
        'Das ist Teil der Härtung.',
      ),
    ],
    explanation:
        'Customizing nutzt die vom Hersteller vorgesehenen Anpassungsmöglichkeiten.',
  ),
  einfach(
    'a3-as-3',
    'an-software',
    scenario:
        'Eine Zahnarztpraxis sucht Software für Terminplanung, Patientenakte und Abrechnung mit den Krankenkassen.',
    prompt: 'Welche Art Software liegt nahe?',
    choices: [
      ja(
        'Branchensoftware für Zahnarztpraxen',
        'Auf genau diese Abläufe und Vorgaben zugeschnitten.',
      ),
      nein(
        'Eine Individualentwicklung',
        'Für einen Standardbedarf unnötig teuer.',
      ),
      nein(
        'Ein allgemeines Tabellenkalkulationsprogramm',
        'Deckt Abrechnung und Akten nicht rechtssicher ab.',
      ),
      nein('Ein Grafikprogramm', 'Passt nicht zum Bedarf.'),
    ],
    explanation:
        'Branchensoftware verbindet den Preisvorteil von Standardsoftware mit branchenspezifischen Funktionen.',
  ),
  rechnen(
    'a3-as-4',
    'an-software',
    scenario:
        'Eine Standardsoftware kostet 15.000 € Lizenz und 5.000 € Einführung. Die jährliche Wartung beträgt 18 % des Lizenzpreises.',
    prompt: 'Wie hoch sind die Gesamtkosten über 4 Jahre?',
    answer: 30800,
    unit: '€',
    explanation:
        'Wartung: 18 % × 15.000 € = 2.700 € pro Jahr, × 4 = 10.800 €. Gesamt: 15.000 € + 5.000 € + 10.800 € = 30.800 €.',
  ),
  rechnen(
    'a3-as-5',
    'an-software',
    scenario:
        'In einer Nutzwertanalyse werden Kosten mit 50 %, Funktionsumfang mit 30 % und Support mit 20 % gewichtet. Ein Produkt erhält 6, 8 und 9 Punkte.',
    prompt: 'Wie hoch ist sein Nutzwert?',
    answer: 7.2,
    tolerance: 0.01,
    unit: 'Punkte',
    explanation: '0,5 × 6 + 0,3 × 8 + 0,2 × 9 = 3,0 + 2,4 + 1,8 = 7,2 Punkte.',
  ),
  zuordnen(
    'a3-as-6',
    'an-software',
    prompt:
        'Was passiert mit der Anpassung beim nächsten Release-Update der Standardsoftware in der Regel?',
    buckets: ['bleibt erhalten', 'muss neu eingebaut werden'],
    items: [
      zu('Customizing: eigene Felder und Formulare', 0),
      zu('Geänderter Programmcode des Herstellers', 1),
      zu('Parametrisierung über vorgesehene Einstellungen', 0),
      zu('Direkt im Quellcode umgeschriebene Preisberechnung', 1),
    ],
    explanation:
        'Vorgesehene Einstellungen übersteht jedes Update. Modifikationen am Herstellercode überschreibt das neue Release. Sie müssen neu eingebaut und getestet werden.',
  ),
  reihenfolge(
    'a3-as-7',
    'an-software',
    prompt:
        'Bringe die Schritte einer Softwareauswahl in die richtige Reihenfolge.',
    items: [
      'Ist-Zustand und Probleme erfassen',
      'Anforderungen im Lastenheft festhalten',
      'Markt sichten und Longlist erstellen',
      'Mit Muss-Kriterien auf eine Shortlist kürzen',
      'Teststellung mit echten Abläufen',
      'Nutzwertanalyse und Entscheidung',
    ],
    explanation:
        'Erst wird der Bedarf geklärt, dann der Markt gesichtet und eingegrenzt, anschließend getestet und nachvollziehbar entschieden.',
  ),
  zuordnen(
    'a3-as-8',
    'an-software',
    prompt: 'Zu welcher Softwareart gehört das Programm?',
    buckets: ['Systemsoftware', 'Anwendungssoftware', 'Entwicklungssoftware'],
    items: [
      zu('Compiler', 2),
      zu('Druckertreiber', 0),
      zu('Betriebssystem', 0),
      zu('Tabellenkalkulation', 1),
      zu('ERP-System', 1),
    ],
    explanation:
        'Systemsoftware betreibt die Hardware, Anwendungssoftware löst Aufgaben der Nutzer, Entwicklungssoftware dient zum Erstellen von Software.',
    difficulty: 1,
  ),

  // ============================================================== Lizenzmodelle
  zuordnen(
    'a3-al-1',
    'an-lizenzen',
    prompt: 'Ordne die Beschreibung der Lizenzart zu.',
    buckets: ['Open Source', 'Freeware', 'Shareware', 'proprietär'],
    items: [
      zu('Zum Testen kostenlos, danach kostenpflichtig', 2),
      zu('Kostenlos, aber Quellcode geschlossen', 1),
      zu('Quellcode geheim, Nutzung gegen Lizenzgebühr', 3),
      zu('Quellcode offen, darf verändert und weitergegeben werden', 0),
    ],
    explanation:
        'Entscheidend sind Kosten und Zugang zum Quellcode. Die beiden Merkmale sind unabhängig voneinander.',
  ),
  einfach(
    'a3-al-2',
    'an-lizenzen',
    scenario:
        'Eine Firma baut eine unter der GPL lizenzierte Bibliothek in ihr Produkt ein, verändert sie und verkauft das Produkt.',
    prompt: 'Was ist die Folge?',
    choices: [
      ja(
        'Der Quellcode der veränderten Fassung muss unter der GPL offengelegt werden.',
        'Das verlangt das Copyleft der GPL.',
      ),
      nein(
        'Nichts: Open Source darf beliebig genutzt werden.',
        'Auch Open-Source-Lizenzen stellen Bedingungen.',
      ),
      nein(
        'Der Verkauf ist grundsätzlich verboten.',
        'Verkaufen ist erlaubt, nur unter den Bedingungen der GPL.',
      ),
      nein(
        'Es muss eine Gebühr an die Entwickler gezahlt werden.',
        'Die GPL verlangt keine Gebühr.',
      ),
    ],
    explanation:
        'Copyleft bedeutet: Wer GPL-Code verändert weitergibt, muss seine Änderungen ebenfalls unter der GPL veröffentlichen.',
  ),
  einfach(
    'a3-al-3',
    'an-lizenzen',
    scenario:
        'In einem Callcenter arbeiten 60 Beschäftigte im Schichtbetrieb, höchstens 20 sind gleichzeitig angemeldet.',
    prompt: 'Welches Lizenzmodell ist am günstigsten?',
    choices: [
      ja(
        'Concurrent User: gezählt werden gleichzeitige Anmeldungen',
        'Es reichen 20 Lizenzen.',
      ),
      nein(
        'Named User: Jede berechtigte Person braucht eine Lizenz',
        'Dafür wären 60 Lizenzen nötig.',
      ),
      nein(
        'OEM-Lizenz',
        'Ist an ein Gerät gebunden und passt nicht zum Schichtbetrieb.',
      ),
      nein(
        'Einzelplatzlizenz pro Rechner mit Lizenz für alle 60 Personen',
        'Unnötig viele Lizenzen.',
      ),
    ],
    explanation:
        'Wenn viele Personen nie gleichzeitig arbeiten, sind Concurrent-User-Lizenzen oft deutlich günstiger.',
  ),
  rechnen(
    'a3-al-4',
    'an-lizenzen',
    scenario:
        'Eine Software kostet als Dauerlizenz 1.800 € plus 300 € Wartung pro Jahr. Als Abonnement kostet sie 50 € im Monat.',
    prompt: 'Nach wie vielen Jahren sind beide Varianten gleich teuer?',
    answer: 6,
    unit: 'Jahre',
    explanation:
        'Abo pro Jahr: 50 € × 12 = 600 €. Gleichsetzen: 1.800 + 300n = 600n, also 1.800 = 300n und n = 6. Nach 6 Jahren kosten beide 3.600 €, danach ist der Kauf günstiger.',
    difficulty: 3,
  ),
  rechnen(
    'a3-al-5',
    'an-lizenzen',
    scenario:
        'Ein Unternehmen hat 120 Beschäftigte, die eine Software nutzen, davon höchstens 35 gleichzeitig. Eine Named-User-Lizenz kostet 90 €, eine Concurrent-User-Lizenz 280 €.',
    prompt: 'Wie viel Euro spart das günstigere Modell gegenüber dem teureren?',
    answer: 1000,
    unit: '€',
    explanation:
        'Named User: 120 × 90 € = 10.800 €. Concurrent User: 35 × 280 € = 9.800 €. Concurrent ist günstiger, Ersparnis: 10.800 € - 9.800 € = 1.000 €.',
  ),
  einfach(
    'a3-al-6',
    'an-lizenzen',
    prompt: 'Was erlaubt eine Bibliothek unter der LGPL?',
    choices: [
      ja(
        'Sie darf in geschlossene Software eingebunden werden; Änderungen an der Bibliothek selbst bleiben offen.',
        'Das ist das „schwache“ Copyleft der LGPL.',
      ),
      nein(
        'Sie darf gar nicht in kommerzieller Software verwendet werden.',
        'Die LGPL erlaubt gerade die Nutzung in kommerzieller Software.',
      ),
      nein(
        'Das gesamte Programm muss dann unter der LGPL stehen.',
        'Das wäre das starke Copyleft der GPL.',
      ),
      nein(
        'Sie ist Freeware ohne offenen Quellcode.',
        'Die LGPL ist eine Open-Source-Lizenz.',
      ),
    ],
    explanation:
        'LGPL: Nutzung als Bibliothek auch in proprietärer Software erlaubt. Wer die Bibliothek selbst verändert und weitergibt, muss diese Änderungen offenlegen.',
    difficulty: 3,
  ),
  einfach(
    'a3-al-7',
    'an-lizenzen',
    scenario:
        'Ein Entwicklerteam möchte eine unter der MIT-Lizenz stehende Bibliothek in einer kommerziellen, geschlossenen App verwenden.',
    prompt: 'Was ist zu beachten?',
    choices: [
      ja(
        'Der Lizenz- und Urheberhinweis muss mitgeliefert werden.',
        'Mehr verlangt die freizügige MIT-Lizenz nicht.',
      ),
      nein(
        'Der gesamte Quellcode der App muss offengelegt werden.',
        'Das wäre Copyleft, die MIT-Lizenz hat keins.',
      ),
      nein(
        'Die Nutzung ist verboten.',
        'Die MIT-Lizenz erlaubt auch kommerzielle Nutzung.',
      ),
      nein(
        'Es muss eine Lizenzgebühr gezahlt werden.',
        'Die MIT-Lizenz ist kostenlos.',
      ),
    ],
    explanation:
        'Freizügige Lizenzen wie MIT, Apache oder BSD erlauben die Nutzung in geschlossener Software, verlangen aber den Lizenzhinweis.',
  ),
  mehrfach(
    'a3-al-8',
    'an-lizenzen',
    prompt: 'Welche Aussagen zum Lizenzmanagement sind richtig?',
    choices: [
      ja(
        'Unterlizenzierung kann zu Nachzahlungen und Schadenersatz führen.',
        'Es liegt eine Urheberrechtsverletzung vor.',
      ),
      ja(
        'Ungenutzte Lizenzen kosten unnötig Geld.',
        'Überlizenzierung ist verschwendetes Budget.',
      ),
      ja(
        'Beim Austritt eines Mitarbeiters sollte seine Lizenz neu zugewiesen werden.',
        'So wird keine zusätzliche Lizenz gekauft.',
      ),
      nein(
        'Wer eine Lizenz gekauft hat, darf die Software beliebig oft installieren.',
        'Die Lizenz legt fest, wie oft installiert werden darf.',
      ),
      nein(
        'Hersteller dürfen niemals prüfen, ob korrekt lizenziert ist.',
        'Viele Verträge erlauben Audits.',
      ),
    ],
    explanation:
        'Lizenzmanagement gleicht Installationen und Lizenzen ab und schützt so vor rechtlichen Risiken und unnötigen Kosten.',
  ),
  einfach(
    'a3-al-9',
    'an-lizenzen',
    scenario:
        'Ein fünf Jahre alter PC wird durch einen neuen ersetzt. Auf dem alten lief Windows mit einer OEM-Lizenz.',
    prompt: 'Darf die Lizenz auf den neuen PC übertragen werden?',
    choices: [
      ja(
        'Nein, die OEM-Lizenz ist an das Gerät gebunden, mit dem sie verkauft wurde.',
        'Für den neuen PC braucht es eine eigene Lizenz.',
      ),
      nein(
        'Ja, jede Lizenz darf beliebig umziehen.',
        'Das gilt gerade für OEM-Lizenzen nicht.',
      ),
      nein(
        'Ja, wenn der alte PC noch läuft.',
        'Dann liefe die Software sogar doppelt.',
      ),
      nein(
        'Nur wenn der neue PC schneller ist.',
        'Die Leistung spielt keine Rolle.',
      ),
    ],
    explanation:
        'OEM-Lizenzen sind günstig, weil sie an ein Gerät gebunden sind. Umziehen lassen sich Voll- oder Volumenlizenzen.',
    difficulty: 1,
  ),

  // ====================================== Kollaboration und Social Media
  zuordnen(
    'a3-ak-1',
    'an-kollaboration',
    prompt: 'Synchrone oder asynchrone Zusammenarbeit?',
    buckets: ['synchron', 'asynchron'],
    items: [
      zu('Videokonferenz', 0),
      zu('E-Mail', 1),
      zu('Wiki', 1),
      zu('Telefonat', 0),
      zu('Kommentar in einem Ticket', 1),
    ],
    explanation: 'Synchron heißt gleichzeitig, asynchron zeitversetzt.',
  ),
  einfach(
    'a3-ak-2',
    'an-kollaboration',
    scenario:
        'Ein Team möchte Kundendaten in einem kostenlosen Online-Whiteboard sammeln, das ein Mitarbeiter privat registriert hat.',
    prompt: 'Was ist problematisch?',
    choices: [
      ja(
        'Für personenbezogene Daten fehlt ein Vertrag zur Auftragsverarbeitung, und der Speicherort ist ungeklärt.',
        'Die DSGVO verlangt geregelte Verarbeitung durch Dienstleister.',
      ),
      nein(
        'Online-Whiteboards dürfen grundsätzlich nicht genutzt werden.',
        'Sie sind erlaubt, wenn ein Vertrag sie regelt.',
      ),
      nein(
        'Nichts, solange das Tool kostenlos ist.',
        'Kosten ändern nichts an den Datenschutzpflichten.',
      ),
      nein(
        'Nur die Farbe der Notizen ist nicht einheitlich.',
        'Kein Datenschutzproblem.',
      ),
    ],
    explanation:
        'Personenbezogene Daten in Cloud-Werkzeugen brauchen einen Vertrag zur Auftragsverarbeitung und einen geprüften Anbieter.',
  ),
  freitext(
    'a3-ak-3',
    'an-kollaboration',
    scenario:
        'Ein Auszubildender postet ein Foto aus dem Serverraum. Im Hintergrund ist ein Whiteboard mit Zugangsdaten zu erkennen. Die Firma will nun eine Social-Media-Richtlinie einführen.',
    prompt: 'Nenne drei Punkte, die eine Social-Media-Richtlinie regelt.',
    kriterien: [
      krit(
        'wer im Namen des Unternehmens posten darf',
        stichwoerter: ['im Namen', 'wer posten', 'Zuständigkeit', 'offiziell'],
      ),
      krit(
        'welche Informationen vertraulich bleiben (Interna, Kundendaten, Fotos aus dem Betrieb)',
        stichwoerter: ['vertraulich', 'Interna', 'Geschäftsgeheimnis', 'Fotos'],
      ),
      krit(
        'Tonfall und Umgang mit Kritik und Beschwerden',
        stichwoerter: ['Kritik', 'Tonfall', 'Beschwerden', 'Umgangston'],
      ),
      krit(
        'Datenschutz und Urheberrecht, etwa Bildrechte',
        stichwoerter: ['Datenschutz', 'Urheberrecht', 'Bildrechte'],
      ),
      krit(
        'Trennung von privater Meinung und Aussagen des Unternehmens',
        stichwoerter: ['private Meinung', 'privat', 'Trennung'],
      ),
    ],
    punkte: 3,
    loesung:
        'Die Richtlinie legt fest, wer im Namen des Unternehmens posten darf, welche Informationen vertraulich bleiben (etwa Interna, Kundendaten und Fotos aus dem Betrieb) und wie mit Kritik umgegangen wird. Dazu kommen Hinweise zu Datenschutz und Urheberrecht.',
    explanation:
        'Eine Richtlinie gibt Sicherheit im Umgang mit sozialen Medien und schützt vor Reputationsschäden. Bewertung: je Nennung 1 Punkt, höchstens 3 Punkte.',
  ),
  zuordnen(
    'a3-ak-4',
    'an-kollaboration',
    prompt:
        'In welches Feld der Raum-Zeit-Matrix gehört die Form der Zusammenarbeit?',
    buckets: [
      'gleicher Ort, gleiche Zeit',
      'verteilt, gleiche Zeit',
      'verteilt, zeitversetzt',
    ],
    items: [
      zu('Telefonat mit dem Kunden', 1),
      zu('Besprechung im Konferenzraum', 0),
      zu('Videokonferenz mit dem Homeoffice', 1),
      zu('E-Mail an die Niederlassung', 2),
      zu('Workshop am Whiteboard vor Ort', 0),
      zu('Beitrag im Wiki', 2),
    ],
    explanation:
        'Die Matrix fragt: Sind alle am selben Ort? Arbeiten alle gleichzeitig? Präsenzbesprechung, Videokonferenz und E-Mail stehen für drei der vier Felder.',
  ),
  einfach(
    'a3-ak-5',
    'an-kollaboration',
    scenario:
        'Ein Vertriebsteam tauscht Angebotsunterlagen über einen privaten Cloudspeicher aus, weil der offizielle Dateiserver von unterwegs nicht erreichbar ist.',
    prompt: 'Wie nennt man dieses Phänomen?',
    choices: [
      ja(
        'Schatten-IT',
        'Dienste werden ohne Wissen und Kontrolle der IT genutzt.',
      ),
      nein(
        'Hybrid Cloud',
        'Das ist ein geplantes Bereitstellungsmodell, keine eigenmächtige Nutzung.',
      ),
      nein('Customizing', 'Das ist das Anpassen von Standardsoftware.'),
      nein(
        'Unified Communications',
        'Das bündelt offizielle Kommunikationskanäle.',
      ),
    ],
    explanation:
        'Schatten-IT entsteht oft, wenn offizielle Werkzeuge fehlen oder unpraktisch sind. Abhilfe: gute offizielle Lösung, klare Regeln, Aufklärung.',
  ),
  mehrfach(
    'a3-ak-6',
    'an-kollaboration',
    prompt: 'Was gehört typischerweise in eine Social-Media-Richtlinie?',
    choices: [
      ja(
        'Wer im Namen des Unternehmens posten darf',
        'Klare Zuständigkeiten verhindern Fehlkommunikation.',
      ),
      ja(
        'Welche Informationen vertraulich bleiben',
        'Interna und Kundendaten gehören nicht in soziale Netzwerke.',
      ),
      ja(
        'Wie mit Kritik und Beschwerden umgegangen wird',
        'Das beugt Empörungswellen vor.',
      ),
      nein(
        'Die Gehälter der Beschäftigten',
        'Die gehören nicht in eine Richtlinie für soziale Netzwerke.',
      ),
      nein(
        'Ein generelles Verbot privater Konten',
        'Private Nutzung kann die Richtlinie nicht allgemein verbieten.',
      ),
    ],
    explanation:
        'Die Richtlinie regelt Zuständigkeiten, Vertraulichkeit, Tonfall und Umgang mit Kritik sowie Hinweise zu Datenschutz und Urheberrecht.',
  ),
  einfach(
    'a3-ak-7',
    'an-kollaboration',
    prompt:
        'Was versteht man unter Unified Communications and Collaboration (UCC)?',
    choices: [
      ja(
        'Telefonie, Chat, Video, Präsenzstatus und Dateiablage in einer gemeinsamen Oberfläche',
        'Alle Kanäle sind gebündelt und mit einem Konto nutzbar.',
      ),
      nein(
        'Ein Gesetz zur einheitlichen Kommunikation',
        'UCC ist ein technisches Konzept.',
      ),
      nein('Eine Verschlüsselung für E-Mails', 'Das wäre z. B. S/MIME.'),
      nein(
        'Ein anderes Wort für Schatten-IT',
        'UCC ist gerade die offizielle, geplante Lösung.',
      ),
    ],
    explanation:
        'UCC-Plattformen wie Microsoft Teams bündeln die Kommunikationskanäle. Telefoniert wird per VoIP über das Datennetz.',
    difficulty: 1,
  ),
  einfach(
    'a3-ak-8',
    'an-kollaboration',
    prompt:
        'Welcher Vorteil ergibt sich, wenn ein Team ein Dokument zentral in der Cloud bearbeitet statt es per E-Mail-Anhang zu verschicken?',
    choices: [
      ja(
        'Alle arbeiten an derselben aktuellen Fassung, frühere Stände bleiben im Versionsverlauf.',
        'Es entstehen keine widersprüchlichen Kopien.',
      ),
      nein(
        'Datenschutz spielt dann keine Rolle mehr.',
        'Auch in der Cloud gelten Datenschutzpflichten.',
      ),
      nein(
        'Es sind keine Zugriffsrechte mehr nötig.',
        'Rechte bleiben wichtig: lesen, kommentieren, bearbeiten.',
      ),
      nein(
        'Das Dokument kann nicht mehr verloren gehen.',
        'Auch Cloud-Daten brauchen Sicherung und Rechteverwaltung.',
      ),
    ],
    explanation:
        'Gemeinsame Dokumente vermeiden Versionschaos. Rechte, Freigabelinks und Datenschutz müssen trotzdem sauber geregelt sein.',
  ),

  // ============================================================ OSI und TCP/IP
  zuordnen(
    'a3-no-1',
    'nw-modelle',
    prompt: 'Auf welcher OSI-Schicht arbeitet das Gerät bzw. Protokoll?',
    buckets: ['Schicht 2', 'Schicht 3', 'Schicht 4', 'Schicht 7'],
    items: [
      zu('Switch', 0),
      zu('Router', 1),
      zu('TCP', 2),
      zu('HTTP', 3),
      zu('IP', 1),
      zu('UDP', 2),
    ],
    explanation:
        'Switch: Sicherung (MAC). Router und IP: Vermittlung. TCP/UDP: Transport. HTTP: Anwendung.',
  ),
  reihenfolge(
    'a3-no-2',
    'nw-modelle',
    prompt:
        'Bringe die OSI-Schichten in die richtige Reihenfolge, von Schicht 1 nach 7.',
    items: [
      'Bitübertragung',
      'Sicherung',
      'Vermittlung',
      'Transport',
      'Sitzung',
      'Darstellung',
      'Anwendung',
    ],
    explanation:
        'Von unten nach oben: Bitübertragung, Sicherung, Vermittlung, Transport, Sitzung, Darstellung, Anwendung.',
  ),
  zuordnen(
    'a3-no-3',
    'nw-modelle',
    prompt: 'Welches Transportprotokoll passt zur Anwendung?',
    buckets: ['TCP', 'UDP'],
    items: [
      zu(
        'Videotelefonie',
        1,
        'Verzögerung stört mehr als ein verlorenes Paket.',
      ),
      zu('Webseite laden', 0, 'Die Seite muss vollständig ankommen.'),
      zu(
        'DNS-Anfrage',
        1,
        'Kurze Frage, kurze Antwort, ohne Verbindungsaufbau.',
      ),
      zu('E-Mail versenden', 0, 'Jedes Byte muss ankommen.'),
      zu(
        'Live-Übertragung eines Vortrags',
        1,
        'Echtzeit geht vor Vollständigkeit.',
      ),
      zu('Datei herunterladen', 0, 'Fehlende Teile werden erneut gesendet.'),
    ],
    explanation:
        'TCP sichert die Übertragung mit Bestätigungen und erneutem Senden; das ist richtig, wenn alles vollständig ankommen muss. Bei Echtzeitanwendungen zählt geringe Verzögerung mehr als Vollständigkeit. Deshalb UDP.',
  ),
  reihenfolge(
    'a3-no-4',
    'nw-modelle',
    prompt:
        'Bringe die Nachrichten des TCP-Verbindungsaufbaus in die richtige Reihenfolge.',
    items: [
      'Client sendet SYN',
      'Server antwortet mit SYN-ACK',
      'Client bestätigt mit ACK',
      'Datenübertragung beginnt',
    ],
    explanation:
        'Drei-Wege-Handshake: SYN, SYN-ACK, ACK. Erst danach steht die Verbindung und Daten fließen.',
    difficulty: 1,
  ),
  zuordnen(
    'a3-no-5',
    'nw-modelle',
    prompt: 'Wie heißt die Dateneinheit auf der jeweiligen OSI-Schicht?',
    buckets: ['Segment', 'Paket', 'Frame', 'Bit'],
    items: [
      zu('Sicherungsschicht', 2),
      zu('Transportschicht (TCP)', 0),
      zu('Bitübertragungsschicht', 3),
      zu('Vermittlungsschicht', 1),
    ],
    explanation:
        'Kapselung von oben nach unten: Daten, Segment (Schicht 4), Paket (Schicht 3), Frame (Schicht 2), Bits (Schicht 1).',
  ),
  zuordnen(
    'a3-no-6',
    'nw-modelle',
    prompt: 'Zu welcher Schicht des TCP/IP-Modells gehört das Protokoll?',
    buckets: ['Anwendung', 'Transport', 'Internet', 'Netzzugang'],
    items: [
      zu('Ethernet', 3),
      zu('TCP', 1),
      zu('DNS', 0),
      zu('IP', 2),
      zu('HTTP', 0),
      zu('UDP', 1),
    ],
    explanation:
        'Das TCP/IP-Modell fasst OSI 5-7 zur Anwendungsschicht und OSI 1-2 zum Netzzugang zusammen. Transport und Internet entsprechen OSI 4 und 3.',
  ),
  einfach(
    'a3-no-7',
    'nw-modelle',
    prompt: 'Wozu dient ARP?',
    choices: [
      ja(
        'Es ermittelt im lokalen Netz zur IP-Adresse die passende MAC-Adresse.',
        'Die Anfrage geht per Broadcast an alle, der Besitzer antwortet.',
      ),
      nein('Es vergibt IP-Adressen an Clients.', 'Das ist DHCP.'),
      nein('Es übersetzt Namen in IP-Adressen.', 'Das ist DNS.'),
      nein('Es verschlüsselt Datenpakete.', 'ARP verschlüsselt nichts.'),
    ],
    explanation:
        'ARP (Address Resolution Protocol) verbindet Schicht 3 und Schicht 2: Aus der IP-Adresse wird die MAC-Adresse für den Frame.',
  ),
  lueckentext(
    'a3-no-8',
    'nw-modelle',
    prompt: 'Ergänze die Zahlen zu Portnummern.',
    text:
        'Eine Portnummer ist {0} Bit lang. '
        'Die Well-known Ports für Standarddienste wie HTTP oder SSH reichen von 0 bis {1}. '
        'Der höchste mögliche Port ist {2}.',
    luecken: [
      zahl(16),
      zahl(1023, rationale: 'z. B. 22 (SSH), 80 (HTTP), 443 (HTTPS)'),
      zahl(65535, rationale: '2¹⁶ - 1'),
    ],
    explanation:
        'Ports sind 16 Bit lang und reichen von 0 bis 65.535: Well-known bis 1.023, Registered bis 49.151, darüber dynamische Client-Ports.',
  ),
  einfach(
    'a3-no-9',
    'nw-modelle',
    prompt:
        'Ein Paket wird über drei Router ins Internet geschickt (ohne NAT). Welche Adresse ändert sich auf jedem Teilstück?',
    choices: [
      ja(
        'Die MAC-Adressen im Frame',
        'Jeder Router packt das Paket in einen neuen Frame für das nächste Teilstück.',
      ),
      nein('Die Ziel-IP-Adresse', 'Sie bleibt von Quelle bis Ziel gleich.'),
      nein('Die Quell-IP-Adresse', 'Ohne NAT bleibt auch sie gleich.'),
      nein(
        'Der Zielport',
        'Der Port gehört zur Transportschicht und bleibt unverändert.',
      ),
    ],
    explanation:
        'MAC-Adressen gelten nur im lokalen Netz, IP-Adressen Ende zu Ende. Deshalb wechseln die MAC-Adressen an jedem Router.',
    difficulty: 3,
  ),

  // =============================================== Netzwerkgeräte und Verkabelung
  zuordnen(
    'a3-ng-1',
    'nw-geraete',
    prompt: 'Welches Gerät übernimmt die Aufgabe?',
    buckets: ['Switch', 'Router', 'Access Point'],
    items: [
      zu('Verbindet zwei verschiedene IP-Netze miteinander', 1),
      zu('Leitet Frames anhand der MAC-Adresse an den richtigen Port', 0),
      zu('Bindet WLAN-Geräte an das kabelgebundene Netz an', 2),
      zu('Begrenzt Broadcasts auf das eigene Netz', 1),
      zu('Lernt, an welchem Port welches Gerät hängt', 0),
    ],
    explanation:
        'Zwischen Netzen vermittelt der Router (Schicht 3), innerhalb eines Netzes der Switch (Schicht 2). Der Access Point bringt WLAN-Geräte ins kabelgebundene Netz.',
  ),
  einfach(
    'a3-ng-2',
    'nw-geraete',
    scenario:
        'In einer Produktionshalle soll eine Netzwerkverbindung direkt neben starken Elektromotoren verlegt werden.',
    prompt: 'Welches Übertragungsmedium ist am besten geeignet?',
    choices: [
      ja(
        'Glasfaser',
        'Überträgt Licht und ist unempfindlich gegen elektromagnetische Störungen.',
      ),
      nein(
        'Ungeschirmtes Cat-5e-Kabel',
        'Störanfällig in der Nähe starker Motoren.',
      ),
      nein(
        'WLAN',
        'Kann durch Metall und Störquellen stark beeinträchtigt werden.',
      ),
      nein(
        'Koaxialkabel eines alten Busnetzes',
        'Veraltet und für heutige Netze ungeeignet.',
      ),
    ],
    explanation:
        'Wo elektromagnetische Störungen drohen, ist Glasfaser die sichere Wahl.',
  ),
  mehrfach(
    'a3-ng-3',
    'nw-geraete',
    prompt: 'Welche Aussagen zu VLANs sind richtig?',
    choices: [
      ja(
        'Sie teilen einen physischen Switch in logisch getrennte Netze.',
        'Das ist der Zweck von VLANs.',
      ),
      ja(
        'Sie können Gäste-WLAN und Firmennetz voneinander trennen.',
        'Ein typischer Einsatzzweck.',
      ),
      nein(
        'Für jedes VLAN wird ein eigener physischer Switch benötigt.',
        'Genau das ersparen VLANs.',
      ),
      ja(
        'Zwischen VLANs muss geroutet werden.',
        'Geräte in verschiedenen VLANs erreichen sich nur über einen Router bzw. Layer-3-Switch.',
      ),
      nein(
        'VLANs erhöhen automatisch die Übertragungsgeschwindigkeit.',
        'Sie trennen Netze, sie beschleunigen sie nicht.',
      ),
    ],
    explanation:
        'VLANs trennen Netze logisch auf gemeinsamer Hardware; Kommunikation zwischen ihnen läuft über Routing.',
  ),
  zuordnen(
    'a3-ng-4',
    'nw-geraete',
    prompt: 'Ordne dem WLAN-Standard seinen Namen zu.',
    buckets: ['Wi-Fi 4', 'Wi-Fi 5', 'Wi-Fi 6', 'Wi-Fi 7'],
    items: [
      zu('IEEE 802.11be', 3),
      zu('IEEE 802.11n', 0),
      zu('IEEE 802.11ac', 1),
      zu('IEEE 802.11ax', 2),
    ],
    explanation:
        '802.11n = Wi-Fi 4, 802.11ac = Wi-Fi 5, 802.11ax = Wi-Fi 6 (mit 6 GHz: Wi-Fi 6E), 802.11be = Wi-Fi 7.',
  ),
  einfach(
    'a3-ng-5',
    'nw-geraete',
    prompt:
        'Ein Switch empfängt einen Frame, dessen Ziel-MAC-Adresse noch nicht in seiner Tabelle steht. Was tut er?',
    choices: [
      ja(
        'Er sendet den Frame an alle Ports außer dem Eingangsport.',
        'Dieses Fluten stellt sicher, dass das Ziel ihn erhält.',
      ),
      nein(
        'Er verwirft den Frame.',
        'Dann wäre ein unbekanntes Ziel nie erreichbar.',
      ),
      nein(
        'Er schickt den Frame an den Router.',
        'Der Switch kennt keine Router-Logik auf Schicht 2.',
      ),
      nein(
        'Er fragt per DNS nach dem Ziel.',
        'DNS löst Namen auf, keine MAC-Adressen.',
      ),
    ],
    explanation:
        'Unbekannte Ziele werden geflutet. Antwortet das Ziel, lernt der Switch dessen Port und leitet künftig gezielt weiter.',
  ),
  einfach(
    'a3-ng-6',
    'nw-geraete',
    scenario:
        'Ein Serverraum soll mit einem 80 m entfernten Etagenverteiler per Kupfer mit 10 Gbit/s verbunden werden.',
    prompt:
        'Welches Kabel ist die kleinste Kategorie, die das zuverlässig schafft?',
    choices: [
      ja('Cat 6A', '10 Gbit/s auf bis zu 100 m.'),
      nein('Cat 5e', 'Nur 1 Gbit/s.'),
      nein('Cat 6', '10 Gbit/s nur bis etwa 55 m.'),
      nein(
        'Cat 8',
        'Schafft mehr, aber nur bis 30 m und ist daher für 80 m ungeeignet.',
      ),
    ],
    explanation:
        'Für 10GBASE-T über die volle Länge von 100 m braucht es mindestens Cat 6A. Cat 6 reicht nur für kürzere Strecken.',
  ),
  einfach(
    'a3-ng-7',
    'nw-geraete',
    prompt:
        'Bei welcher Topologie trifft der Ausfall des zentralen Geräts alle angeschlossenen Geräte, ein Kabelfehler dagegen nur eines?',
    choices: [
      ja('Stern', 'Jedes Gerät hat ein eigenes Kabel zum zentralen Switch.'),
      nein('Bus', 'Beim Bus legt schon ein einzelner Kabelfehler alles lahm.'),
      nein(
        'Vermaschtes Netz',
        'Es gibt mehrere Wege, kein einzelnes zentrales Gerät.',
      ),
      nein('Ring', 'Beim Ring stört eine Unterbrechung den ganzen Ring.'),
    ],
    explanation:
        'Der Stern ist heute Standard: robust gegen Kabelfehler, aber abhängig vom zentralen Switch.',
    difficulty: 1,
  ),
  rechnen(
    'a3-ng-8',
    'nw-geraete',
    scenario:
        'Ein Router hat drei belegte Schnittstellen. An jeder hängt ein Switch mit acht PCs, VLANs gibt es nicht.',
    prompt: 'Wie viele Broadcastdomänen gibt es?',
    answer: 3,
    explanation:
        'Switches leiten Broadcasts an alle ihre Ports weiter, Router nicht. Jede Router-Schnittstelle bildet daher eine eigene Broadcastdomäne: 3.',
    difficulty: 3,
  ),
  einfach(
    'a3-ng-9',
    'nw-geraete',
    scenario:
        'Die Skizze zeigt ein Netz mit zwei VLANs. Auf dem Router ist noch kein Routing zwischen den VLANs eingerichtet.',
    skizze: const NetzSkizze(
      [
        NetzKnoten('rt', 'Router', NetzTyp.router, 2, 0),
        NetzKnoten('sw', 'Switch', NetzTyp.switch_, 2, 2),
        NetzKnoten('v1', 'PC Verwaltung', NetzTyp.pc, 0.5, 4),
        NetzKnoten('v2', 'Drucker', NetzTyp.drucker, 1.5, 4),
        NetzKnoten('p1', 'PC Halle 1', NetzTyp.pc, 2.5, 4),
        NetzKnoten('p2', 'PC Halle 2', NetzTyp.pc, 3.5, 4),
      ],
      verbindungen: [
        NetzVerbindung('rt', 'sw', label: 'Trunk'),
        NetzVerbindung('sw', 'v1'),
        NetzVerbindung('sw', 'v2'),
        NetzVerbindung('sw', 'p1'),
        NetzVerbindung('sw', 'p2'),
      ],
      zonen: [
        NetzZone('VLAN 10', 0, 3.3, 1.95, 4.8),
        NetzZone('VLAN 20', 2.05, 3.3, 4, 4.8),
      ],
    ),
    prompt: 'Welche Geräte kann der PC Verwaltung erreichen?',
    choices: [
      ja('Nur den Drucker', 'Er liegt im selben VLAN 10.'),
      nein(
        'Alle Geräte am Switch',
        'VLANs trennen die Geräte trotz gemeinsamen Switches.',
      ),
      nein('Nur die PCs in der Halle', 'Die liegen im anderen VLAN 20.'),
      nein(
        'Gar kein Gerät',
        'Innerhalb seines VLANs funktioniert die Kommunikation.',
      ),
    ],
    explanation:
        'Innerhalb eines VLANs verbindet der Switch direkt. Zwischen VLANs braucht es Routing, und das ist hier noch nicht eingerichtet.',
  ),
  rechnen(
    'a3-ng-10',
    'nw-geraete',
    scenario:
        'Ein PoE-Switch hat ein Leistungsbudget von 370 W. Angeschlossen sind 8 Access Points mit je 25,5 W und 12 IP-Telefone mit je 7 W.',
    prompt: 'Wie viel Watt bleiben im PoE-Budget noch frei?',
    answer: 82,
    unit: 'W',
    explanation:
        'Access Points: 8 × 25,5 W = 204 W. Telefone: 12 × 7 W = 84 W. Summe: 288 W. Frei: 370 W - 288 W = 82 W.',
  ),

  // =========================================================== IPv4 und Subnetting
  rechnen(
    'a3-n4-1',
    'nw-ipv4',
    prompt: 'Wie viele nutzbare Hostadressen hat ein Netz mit dem Präfix /27?',
    answer: 30,
    unit: 'Hosts',
    explanation:
        '32 - 27 = 5 Hostbits. 2⁵ = 32 Adressen, abzüglich Netz- und Broadcastadresse = 30 Hosts.',
  ),
  lueckentext(
    'a3-n4-2',
    'nw-ipv4',
    scenario: 'Ein Server hat die Adresse 172.16.5.200/26.',
    prompt: 'Ermittle Netz- und Broadcastadresse seines Subnetzes.',
    text:
        'Netzadresse: {0}\n'
        'Broadcastadresse: {1}',
    luecken: [
      wort(['172.16.5.192'], 'Blockgröße 64: 200 liegt im Block ab .192'),
      wort(['172.16.5.255'], 'der nächste Block begänne bei .256'),
    ],
    explanation:
        '/26 = Blockgröße 64. Netze: .0, .64, .128, .192. 200 liegt ab .192 - Netzadresse .192, Broadcast .255.',
  ),
  einfach(
    'a3-n4-3',
    'nw-ipv4',
    prompt: 'Welche Adresse ist eine private IPv4-Adresse?',
    choices: [
      ja(
        '172.20.10.5',
        'Liegt im privaten Bereich 172.16.0.0 bis 172.31.255.255.',
      ),
      nein('172.32.1.1', 'Liegt knapp außerhalb von 172.16.0.0/12.'),
      nein('8.8.8.8', 'Öffentliche Adresse.'),
      nein(
        '169.254.3.4',
        'APIPA-Adresse: nicht privat im Sinne von RFC 1918, sondern selbst vergeben.',
      ),
    ],
    explanation:
        'Private Bereiche: 10.0.0.0/8, 172.16.0.0/12 (bis 172.31.x.x), 192.168.0.0/16.',
  ),
  rechnen(
    'a3-n4-4',
    'nw-ipv4',
    prompt:
        'Das Netz 10.0.0.0/24 soll in Subnetze mit mindestens 50 nutzbaren Hosts aufgeteilt werden, und zwar in so viele wie möglich. Wie viele Subnetze entstehen?',
    answer: 4,
    unit: 'Subnetze',
    explanation:
        '50 Hosts brauchen 6 Hostbits (2⁶ - 2 = 62). Präfix: 32 - 6 = /26. Aus /24 werden 2² = 4 Subnetze mit je 62 Hosts.',
  ),
  lueckentext(
    'a3-n4-5',
    'nw-ipv4',
    scenario: 'Ein Drucker hat die Adresse 10.20.30.140/27.',
    prompt: 'Ermittle Netz- und Broadcastadresse seines Subnetzes.',
    text:
        'Netzadresse: {0}\n'
        'Broadcastadresse: {1}',
    luecken: [
      wort(['10.20.30.128'], 'Blöcke .96, .128, .160 - 140 liegt ab .128'),
      wort(['10.20.30.159'], 'eine Adresse vor dem nächsten Block .160'),
    ],
    explanation:
        '/27 = 255.255.255.224, Blockgröße 256 - 224 = 32. 140 / 32 = 4,375 - der Block beginnt bei 4 × 32 = 128. Netz .128, Broadcast .159.',
  ),
  rechnen(
    'a3-n4-6',
    'nw-ipv4',
    prompt: 'Wie viele nutzbare Hostadressen hat ein Netz mit dem Präfix /22?',
    answer: 1022,
    unit: 'Hosts',
    explanation:
        '32 - 22 = 10 Hostbits. 2¹⁰ = 1.024 Adressen, minus Netz- und Broadcastadresse = 1.022 Hosts.',
  ),
  einfach(
    'a3-n4-7',
    'nw-ipv4',
    prompt:
        'Wie lautet die Broadcastadresse des Netzes, in dem 10.1.77.5/21 liegt?',
    choices: [
      ja(
        '10.1.79.255',
        '/21: Blockgröße 8 im dritten Oktett. 77 liegt im Block 72 bis 79.',
      ),
      nein(
        '10.1.77.255',
        'Das wäre richtig bei /24 - hier umfasst das Netz acht Werte im dritten Oktett.',
      ),
      nein('10.1.72.255', 'Das Netz endet nicht bei 72, sondern bei 79.'),
      nein('10.1.80.255', '80 gehört bereits zum nächsten Block.'),
    ],
    explanation:
        '/21 = 255.255.248.0, Blockgröße im dritten Oktett 256 - 248 = 8. Blöcke 64, 72, 80 - 77 liegt in 72 bis 79. Netz 10.1.72.0, Broadcast 10.1.79.255.',
    difficulty: 3,
  ),
  lueckentext(
    'a3-n4-8',
    'nw-ipv4',
    prompt: 'Ergänze die Angaben zum Präfix /27.',
    text:
        'Subnetzmaske: {0}\n'
        'Blockgröße: {1}',
    luecken: [
      wort(['255.255.255.224'], '27 Einsen: drei volle Oktette plus 3 Bit'),
      zahl(32, rationale: '256 - 224'),
    ],
    explanation:
        'Nach 24 Bit folgen noch 3 Einsen im letzten Oktett: 11100000 = 128 + 64 + 32 = 224. Die Blockgröße ist 256 - 224 = 32.',
    difficulty: 1,
  ),
  rechnen(
    'a3-n4-9',
    'nw-ipv4',
    prompt:
        'Das Netz 172.16.0.0/16 wird in Subnetze mit dem Präfix /20 aufgeteilt. Wie viele Subnetze entstehen?',
    answer: 16,
    unit: 'Subnetze',
    explanation:
        'Geliehene Bits: 20 - 16 = 4. Anzahl Subnetze: 2⁴ = 16, jedes mit 2¹² - 2 = 4.094 Hosts.',
  ),
  lueckentext(
    'a3-n4-10',
    'nw-ipv4',
    scenario:
        'Für die Dokumentation wird der Hostbereich des Netzes 192.168.5.64/26 gebraucht.',
    prompt: 'Ermittle die erste und die letzte nutzbare Hostadresse.',
    text:
        'Erste nutzbare Adresse: {0}\n'
        'Letzte nutzbare Adresse: {1}',
    luecken: [
      wort(['192.168.5.65'], 'Netzadresse + 1'),
      wort(['192.168.5.126'], 'Broadcast .127 - 1'),
    ],
    explanation:
        'Blockgröße 64: Netz .64, erster Host .65, letzter Host .126, Broadcast .127.',
  ),
  einfach(
    'a3-n4-11',
    'nw-ipv4',
    scenario:
        'Ein PC hat die Adresse 192.168.1.35/28, der Netzwerkdrucker 192.168.1.50/28. Der PC erreicht den Drucker nur, wenn das Standardgateway funktioniert.',
    prompt: 'Woran liegt das?',
    choices: [
      ja(
        'Die beiden Adressen liegen in verschiedenen Subnetzen.',
        '/28 = Blockgröße 16: .32 bis .47 und .48 bis .63.',
      ),
      nein(
        'Der Drucker hat eine ungültige Adresse.',
        '.50 ist ein gültiger Host im Netz .48/28.',
      ),
      nein(
        'Drucker brauchen immer ein Gateway.',
        'Im selben Subnetz geht die Kommunikation direkt.',
      ),
      nein('Die Maske /28 erlaubt nur 2 Hosts.', '/28 hat 14 nutzbare Hosts.'),
    ],
    explanation:
        'Bei /28 beträgt die Blockgröße 16. PC (.35) liegt in .32 bis .47, der Drucker (.50) in .48 bis .63 - zwei Netze, also Weg über das Gateway.',
    difficulty: 3,
  ),
  rechnen(
    'a3-n4-12',
    'nw-ipv4',
    prompt:
        'Ein Netz soll mindestens 500 Geräte aufnehmen. Welche Präfixlänge (Zahl nach dem Schrägstrich) hat das kleinste passende Netz?',
    answer: 23,
    explanation:
        'Gesucht: kleinstes n mit 2ⁿ - 2 ≥ 500. 2⁸ - 2 = 254 reicht nicht, 2⁹ - 2 = 510 reicht. 9 Hostbits ergeben 32 - 9 = /23.',
  ),
  einfach(
    'a3-n4-13',
    'nw-ipv4',
    scenario: 'Die Bitdarstellung zeigt eine IP-Adresse und ihre Subnetzmaske.',
    skizze: const BitDiagramm([
      BitZeile('IP 10.0.5.73', '00001010.00000000.00000101.01001001', netz: 29),
      BitZeile('Maske /29', '11111111.11111111.11111111.11111000', netz: 29),
    ], legende: 'markiert = Netzanteil'),
    prompt: 'Wie lautet die Netzadresse?',
    choices: [
      ja('10.0.5.72', 'Letztes Oktett: 01001001 UND 11111000 = 01001000 = 72.'),
      nein('10.0.5.64', 'Das wäre die Netzadresse bei /26.'),
      nein('10.0.5.73', 'Das ist die Hostadresse.'),
      nein(
        '10.0.5.79',
        'Das ist die Broadcastadresse (alle drei Hostbits auf 1).',
      ),
    ],
    explanation:
        'Bitweises UND im letzten Oktett: 73 = 01001001, Maske 248 = 11111000, Ergebnis 01001000 = 72. Blockgröße 8, Broadcast 72 + 7 = 79.',
    difficulty: 3,
  ),
  reihenfolge(
    'a3-n4-14',
    'nw-ipv4',
    prompt:
        'In welcher Reihenfolge bestimmst du zu einer IP-Adresse mit Präfix das Subnetz?',
    items: [
      'Maske aufschreiben und Blockgröße berechnen',
      'Block suchen, in dem die Adresse liegt',
      'Netzadresse = Anfang dieses Blocks',
      'Broadcast = Anfang des nächsten Blocks minus 1',
      'Hostbereich = dazwischen liegende Adressen',
    ],
    explanation:
        'Die Blockmethode: Blockgröße = 256 - Maskenwert, Block finden, Netzadresse und Broadcast ablesen, Hosts liegen dazwischen.',
  ),
  mehrfach(
    'a3-n4-15',
    'nw-ipv4',
    prompt:
        'Welche Adressen dürfen im Netz 192.168.10.0/26 einem Gerät zugewiesen werden?',
    choices: [
      ja('192.168.10.1', 'Erster nutzbarer Host.'),
      ja('192.168.10.30', 'Liegt im Hostbereich .1 bis .62.'),
      ja('192.168.10.62', 'Letzter nutzbarer Host.'),
      nein('192.168.10.0', 'Das ist die Netzadresse.'),
      nein('192.168.10.63', 'Das ist die Broadcastadresse.'),
      nein('192.168.10.64', 'Gehört bereits zum nächsten Subnetz.'),
    ],
    explanation:
        '/26: Netz .0, Hosts .1 bis .62, Broadcast .63. Die .64 ist die Netzadresse des nächsten Blocks.',
  ),

  // ====================================================================== IPv6
  einfach(
    'a3-n6-1',
    'nw-ipv6',
    prompt:
        'Wie lautet die kürzestmögliche Schreibweise von 2001:0db8:0000:0000:0000:0001:0000:0abc?',
    choices: [
      ja(
        '2001:db8::1:0:abc',
        'Führende Nullen entfernt, die längste Null-Folge (drei Blöcke) durch :: ersetzt.',
      ),
      nein(
        '2001:db8::1::abc',
        ':: darf nur einmal vorkommen, sonst ist die Adresse mehrdeutig und damit ungültig.',
      ),
      nein(
        '2001:db8:0:0:0:1::abc',
        'Gültig, aber länger: Hier ersetzt :: nur einen einzelnen Null-Block statt der längsten Folge.',
      ),
      nein(
        '21:db8::1:0:abc',
        'Nur führende Nullen dürfen entfallen, aus 2001 wird nicht 21.',
      ),
    ],
    explanation:
        'Zwei Regeln: führende Nullen je Block weglassen und genau eine Folge von Null-Blöcken durch :: ersetzen. Am kürzesten wird es, wenn man die längste Folge ersetzt.',
  ),
  zuordnen(
    'a3-n6-2',
    'nw-ipv6',
    prompt: 'Um welchen Adresstyp handelt es sich?',
    buckets: ['Link-Local', 'Global Unicast', 'Loopback', 'Multicast'],
    items: [
      zu('2a00:1450:4001::200e', 1),
      zu('ff02::1', 3),
      zu('fe80::1a2b:3c4d', 0),
      zu('::1', 2),
    ],
    explanation:
        'fe80:: Link-Local, 2000::/3 Global Unicast, ::1 Loopback, ff00::/8 Multicast.',
  ),
  lueckentext(
    'a3-n6-3',
    'nw-ipv6',
    prompt: 'Ergänze die Zahlen zum Aufbau der Adressen.',
    text:
        'Eine IPv6-Adresse hat {0} Bit. '
        'Sie wird in {1} Blöcken zu je {2} Bit geschrieben. '
        'Eine IPv4-Adresse hat dagegen nur {3} Bit.',
    luecken: [zahl(128), zahl(8), zahl(16), zahl(32)],
    explanation:
        'IPv6 nutzt 128 Bit: acht Blöcke zu je 16 Bit, hexadezimal geschrieben, typischerweise 64 Bit Präfix und 64 Bit Interface-ID. IPv4 hat 32 Bit.',
    difficulty: 1,
  ),
  einfach(
    'a3-n6-4',
    'nw-ipv6',
    prompt:
        'Wie lautet die kürzestmögliche Schreibweise von 2001:0db8:0000:0000:0001:0000:0000:0000?',
    choices: [
      ja(
        '2001:db8:0:0:1::',
        'Die längere Null-Folge (drei Blöcke am Ende) wird durch :: ersetzt.',
      ),
      nein(
        '2001:db8::1:0:0:0',
        'Gültig, aber länger; hier wurde die kürzere Folge ersetzt.',
      ),
      nein('2001:db8::1::', 'Zweimal :: ist ungültig.'),
      nein(
        '2001:db8:0:0:1:0::',
        'Gültig, aber :: ersetzt hier nicht die ganze Null-Folge.',
      ),
    ],
    explanation:
        'Gibt es mehrere Null-Folgen, wird die längste durch :: ersetzt. Hier sind das die drei Blöcke am Ende.',
    difficulty: 3,
  ),
  rechnen(
    'a3-n6-5',
    'nw-ipv6',
    prompt:
        'Ein Unternehmen erhält das Präfix 2001:db8:a0b::/48. Wie viele /64-Subnetze kann es daraus bilden?',
    answer: 65536,
    unit: 'Subnetze',
    explanation: 'Bits für Subnetze: 64 - 48 = 16. 2¹⁶ = 65.536 Subnetze.',
  ),
  rechnen(
    'a3-n6-6',
    'nw-ipv6',
    prompt: 'Für wie viele Null-Blöcke steht :: in der Adresse fe80::1:2?',
    answer: 5,
    unit: 'Blöcke',
    explanation:
        'Eine IPv6-Adresse hat 8 Blöcke. Vorhanden sind fe80, 1 und 2 - also 3. Der Doppelpunkt ersetzt 8 - 3 = 5 Null-Blöcke.',
    difficulty: 1,
  ),
  einfach(
    'a3-n6-7',
    'nw-ipv6',
    prompt:
        'Welche Interface-ID bildet ein Gerät mit der MAC-Adresse 00:50:56:ab:cd:ef nach EUI-64?',
    choices: [
      ja(
        '0250:56ff:feab:cdef',
        'ff:fe in der Mitte eingefügt und das 7. Bit umgedreht: 00 wird 02.',
      ),
      nein(
        '0050:56ff:feab:cdef',
        'Das 7. Bit von links wurde nicht umgedreht.',
      ),
      nein('0250:56fe:ffab:cdef', 'Eingefügt wird ff:fe, nicht fe:ff.'),
      nein(
        '0250:56ab:cdef:fffe',
        'ff:fe gehört in die Mitte der MAC-Adresse, nicht ans Ende.',
      ),
    ],
    explanation:
        'EUI-64: MAC teilen (00:50:56 | ab:cd:ef), ff:fe einfügen, im ersten Byte das 7. Bit umdrehen (00000000 -> 00000010 = 02). Ergebnis 0250:56ff:feab:cdef.',
    difficulty: 3,
  ),
  zuordnen(
    'a3-n6-8',
    'nw-ipv6',
    prompt: 'Gibt es das Merkmal nur bei IPv4, nur bei IPv6 oder bei beiden?',
    buckets: ['nur IPv4', 'nur IPv6', 'beide'],
    items: [
      zu('ARP zur Adressauflösung', 0),
      zu('Neighbor Discovery (NDP)', 1),
      zu('Selbstkonfiguration per SLAAC', 1),
      zu('Multicast', 2),
      zu('Adressvergabe über einen DHCP-Server', 2),
      zu('Broadcast-Adressen', 0),
    ],
    explanation:
        'IPv6 verzichtet auf Broadcast und ARP und nutzt NDP und SLAAC. Multicast und DHCP (als DHCPv6) gibt es in beiden Versionen.',
    difficulty: 3,
  ),
  einfach(
    'a3-n6-9',
    'nw-ipv6',
    prompt:
        'Welche Adresse ist eine Unique Local Address (privat, vergleichbar mit 192.168.x.x)?',
    choices: [
      ja(
        'fd12:3456:789a::1',
        'fd00::/8 gehört zum Bereich fc00::/7 der Unique Local Addresses.',
      ),
      nein('fe80::1', 'Link-Local, nur im eigenen Segment gültig.'),
      nein('2a00:1450::1', 'Global Unicast aus 2000::/3.'),
      nein('ff02::1', 'Multicast an alle Knoten im Segment.'),
    ],
    explanation:
        'Unique Local Addresses beginnen mit fc oder fd (fc00::/7) und werden im Internet nicht geroutet.',
  ),

  // ============================================ Protokolle, Dienste und Ports
  reihenfolge(
    'a3-nd-1',
    'nw-dienste',
    prompt:
        'Bringe die Schritte der DHCP-Adressvergabe in die richtige Reihenfolge.',
    items: ['Discover', 'Offer', 'Request', 'Acknowledge'],
    explanation:
        'DORA: Der Client sucht, der Server bietet an, der Client fordert an, der Server bestätigt.',
  ),
  zuordnen(
    'a3-nd-2',
    'nw-dienste',
    prompt: 'Ordne jedem Dienst seinen Standardport zu.',
    buckets: ['22', '53', '443', '3389'],
    items: [
      zu('SSH', 0),
      zu('Windows-Remotedesktop (RDP)', 3),
      zu('HTTPS', 2),
      zu('DNS', 1),
    ],
    explanation:
        'SSH 22, DNS 53, HTTPS 443, RDP 3389. Diese Ports tauchen in Firewall-Aufgaben regelmäßig auf.',
  ),
  paare(
    'a3-nd-3',
    'nw-dienste',
    prompt: 'Ordne jedem DNS-Eintrag seine Bedeutung zu.',
    paare: [
      paar('A', 'Name zu IPv4-Adresse'),
      paar('AAAA', 'Name zu IPv6-Adresse'),
      paar('MX', 'Mailserver der Domain'),
      paar('CNAME', 'Alias auf einen anderen Namen'),
      paar('PTR', 'Adresse zu Name'),
    ],
    explanation:
        'A: Name zu IPv4, AAAA: Name zu IPv6, MX: zuständiger Mailserver (Mail Exchanger), CNAME: Alias, PTR: Rückwärtsauflösung von der Adresse zum Namen.',
  ),
  freitext(
    'a3-nd-4',
    'nw-dienste',
    scenario:
        'Ein neues Notebook wird ans Firmennetz angeschlossen und ist ohne weitere Einstellungen sofort online.',
    prompt: 'Nenne vier Angaben, die ein Client per DHCP erhält.',
    kriterien: [
      krit('IP-Adresse', stichwoerter: ['IP-Adresse', 'IP', 'IPv4-Adresse']),
      krit(
        'Subnetzmaske',
        stichwoerter: ['Subnetzmaske', 'Maske', 'Netzmaske'],
      ),
      krit(
        'Standardgateway',
        stichwoerter: ['Gateway', 'Standardgateway', 'Router'],
      ),
      krit('DNS-Server', stichwoerter: ['DNS', 'DNS-Server', 'Nameserver']),
      krit(
        'Gültigkeitsdauer der Adresse (Lease)',
        stichwoerter: ['Lease', 'Gültigkeit', 'Leasedauer'],
      ),
    ],
    punkte: 4,
    loesung:
        'IP-Adresse, Subnetzmaske, Standardgateway und DNS-Server, befristet über eine Lease. Die MAC-Adresse stammt dagegen nicht vom DHCP-Server; sie ist in der Netzwerkkarte hinterlegt.',
    explanation:
        'DHCP verteilt die Netzwerkkonfiguration automatisch, befristet über eine Lease. Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte.',
  ),
  zuordnen(
    'a3-nd-5',
    'nw-dienste',
    prompt: 'Ordne jedem Dienst seinen Standardport zu.',
    buckets: ['25', '123', '993', '995'],
    items: [
      zu('NTP (Zeitsynchronisation)', 1),
      zu('POP3S', 3),
      zu('IMAPS', 2),
      zu('SMTP zwischen Mailservern', 0),
    ],
    explanation:
        'SMTP 25 (Einlieferung durch Clients 587), NTP 123 über UDP, IMAPS 993 und POP3S 995 - die verschlüsselten Varianten von IMAP (143) und POP3 (110).',
  ),
  einfach(
    'a3-nd-6',
    'nw-dienste',
    scenario:
        'Nach der Einführung von VLANs erhalten die PCs in VLAN 20 nur noch 169.254er-Adressen. Der DHCP-Server steht in VLAN 10 und funktioniert dort einwandfrei.',
    prompt: 'Was muss eingerichtet werden?',
    choices: [
      ja(
        'Ein DHCP-Relay auf dem Router bzw. Layer-3-Switch für VLAN 20',
        'Es leitet die Broadcast-Anfragen gezielt an den DHCP-Server weiter.',
      ),
      nein(
        'Ein zweiter DNS-Server',
        'DNS hat mit der Adressvergabe nichts zu tun.',
      ),
      nein(
        'Feste APIPA-Adressen für alle PCs',
        'APIPA-Adressen sind nicht routbar und keine Lösung.',
      ),
      nein(
        'Ein größerer Adressbereich im DHCP-Server',
        'Die Anfragen kommen gar nicht erst beim Server an.',
      ),
    ],
    explanation:
        'DHCP-Discover ist ein Broadcast und endet am Router. Ein DHCP-Relay (IP-Helper) leitet die Anfragen in das Netz des Servers weiter.',
    difficulty: 3,
  ),
  einfach(
    'a3-nd-7',
    'nw-dienste',
    prompt: 'Welcher DNS-Eintrag ordnet einem Namen eine IPv6-Adresse zu?',
    choices: [
      ja(
        'AAAA',
        'Vier A, weil die IPv6-Adresse viermal so lang ist wie eine IPv4-Adresse.',
      ),
      nein('A', 'Der A-Eintrag enthält eine IPv4-Adresse.'),
      nein('MX', 'Der MX-Eintrag nennt den Mailserver.'),
      nein('PTR', 'Der PTR-Eintrag löst eine Adresse in einen Namen auf.'),
    ],
    explanation:
        'A: Name zu IPv4, AAAA: Name zu IPv6, PTR: Adresse zu Name, MX: Mailserver, CNAME: Alias.',
    difficulty: 1,
  ),
  einfach(
    'a3-nd-8',
    'nw-dienste',
    scenario:
        'In einem Büro surfen 50 Geräte mit privaten Adressen gleichzeitig im Internet.',
    prompt:
        'Wie viele öffentliche IPv4-Adressen braucht der Router mindestens, wenn er PAT (NAT-Overload) nutzt?',
    choices: [
      ja(
        'Eine',
        'PAT unterscheidet die Verbindungen der Geräte über die Portnummern.',
      ),
      nein(
        '50',
        'Das wäre nötig, wenn jedes Gerät eine eigene öffentliche Adresse bekäme.',
      ),
      nein(
        'Keine',
        'Ohne öffentliche Adresse ist das Internet nicht erreichbar.',
      ),
      nein(
        'Zwei: eine für ein- und eine für ausgehenden Verkehr',
        'PAT kommt mit einer Adresse für beide Richtungen aus.',
      ),
    ],
    explanation:
        'PAT übersetzt private Adresse und Port auf die öffentliche Adresse mit eigenem Port. So teilen sich viele Geräte eine öffentliche IPv4-Adresse.',
  ),
  zuordnen(
    'a3-nd-9',
    'nw-dienste',
    prompt: 'Durch welche sichere Variante wird das Klartextprotokoll ersetzt?',
    buckets: ['SSH', 'HTTPS', 'SFTP', 'IMAPS'],
    items: [
      zu('Telnet', 0),
      zu('FTP', 2),
      zu('IMAP auf Port 143', 3),
      zu('HTTP', 1),
    ],
    explanation:
        'Telnet -> SSH (22), HTTP -> HTTPS (443), FTP -> SFTP (22) oder FTPS, IMAP -> IMAPS (993).',
  ),
  mehrfach(
    'a3-nd-10',
    'nw-dienste',
    prompt: 'Welche Aussagen zu IMAP und POP3 sind richtig?',
    choices: [
      ja(
        'Bei IMAP bleiben die E-Mails auf dem Server.',
        'Deshalb ist der Stand auf allen Geräten gleich.',
      ),
      ja(
        'POP3 lädt E-Mails meist herunter und löscht sie auf dem Server.',
        'Dann liegen sie nur auf einem Gerät.',
      ),
      ja(
        'IMAPS nutzt standardmäßig Port 993.',
        'Die verschlüsselte Variante von IMAP.',
      ),
      nein('Mit POP3 werden E-Mails versendet.', 'Versendet wird mit SMTP.'),
      nein(
        'IMAP eignet sich nicht für mehrere Geräte.',
        'Gerade dafür ist IMAP gedacht.',
      ),
    ],
    explanation:
        'IMAP synchronisiert mit dem Server, POP3 holt Mails ab. Versendet wird immer per SMTP.',
  ),
  reihenfolge(
    'a3-nd-11',
    'nw-dienste',
    prompt:
        'Ein Client ruft www.beispiel.de auf, nichts ist im Cache. Bringe die Schritte der Namensauflösung in die richtige Reihenfolge.',
    items: [
      'Client fragt seinen DNS-Resolver',
      'Resolver fragt einen Root-Server',
      'Root-Server verweist auf den Server für .de',
      'Server für .de verweist auf den Nameserver von beispiel.de',
      'Nameserver von beispiel.de liefert die IP-Adresse',
      'Resolver antwortet dem Client und speichert das Ergebnis im Cache',
    ],
    explanation:
        'Der Client fragt rekursiv, der Resolver arbeitet sich iterativ von der Wurzel über die Top-Level-Domain bis zum autoritativen Server durch.',
    difficulty: 3,
  ),
  einfach(
    'a3-nd-12',
    'nw-dienste',
    scenario:
        'Ein Webserver in der DMZ soll aus dem Internet ausschließlich verschlüsselt erreichbar sein.',
    prompt: 'Welche Freigabe braucht die Firewall?',
    choices: [
      ja('Eingehend TCP-Port 443 zum Webserver', 'HTTPS nutzt TCP 443.'),
      nein(
        'Eingehend TCP-Port 80 zum Webserver',
        'Port 80 ist unverschlüsseltes HTTP.',
      ),
      nein(
        'Eingehend UDP-Port 53 zum Webserver',
        'Das ist DNS, nicht der Webdienst.',
      ),
      nein(
        'Alle Ports zum Webserver',
        'Das widerspricht dem Minimalprinzip bei Firewallregeln.',
      ),
    ],
    explanation:
        'Nur benötigte Ports öffnen: Für HTTPS genügt TCP 443. Oft leitet Port 80 lediglich auf HTTPS um.',
  ),

  // =============================================== Cloud und Virtualisierung
  zuordnen(
    'a3-nc-1',
    'nw-cloud',
    prompt: 'Welches Servicemodell liegt vor?',
    buckets: ['IaaS', 'PaaS', 'SaaS'],
    items: [
      zu(
        'Eine virtuelle Maschine mieten und selbst das Betriebssystem pflegen',
        0,
      ),
      zu(
        'Eigene Web-App hochladen, die Laufzeitumgebung stellt der Anbieter',
        1,
      ),
      zu('Office-Programme im Browser nutzen', 2),
      zu('Speicherplatz und virtuelle Netze buchen', 0),
      zu('Ein CRM-System als Online-Dienst abonnieren', 2),
    ],
    explanation:
        'IaaS: Infrastruktur. PaaS: Plattform. SaaS: fertige Anwendung.',
  ),
  zuordnen(
    'a3-nc-2',
    'nw-cloud',
    prompt:
        'Trifft das Merkmal auf eine virtuelle Maschine oder auf einen Container zu?',
    buckets: ['Virtuelle Maschine', 'Container'],
    items: [
      zu('Teilt sich den Kernel des Host-Betriebssystems', 1),
      zu('Enthält ein vollständiges eigenes Betriebssystem', 0),
      zu('Startet in Sekunden', 1),
      zu('Läuft auf einem Hypervisor', 0),
      zu('Stärker vom Host und von anderen Instanzen isoliert', 0),
      zu('Sehr leichtgewichtig, viele Instanzen je Host', 1),
    ],
    explanation:
        'VMs virtualisieren Hardware und bringen ein eigenes Betriebssystem mit: stark isoliert, aber schwergewichtig. Container virtualisieren auf Betriebssystemebene, teilen den Kernel und starten in Sekunden.',
  ),
  zuordnen(
    'a3-nc-3',
    'nw-cloud',
    prompt: 'Um welche Art von Software handelt es sich?',
    buckets: ['Hypervisor Typ 1', 'Hypervisor Typ 2', 'kein Hypervisor'],
    items: [
      zu('VirtualBox', 1, 'Läuft als Programm auf einem Betriebssystem.'),
      zu('VMware ESXi', 0, 'Läuft direkt auf der Hardware.'),
      zu('Docker', 2, 'Eine Container-Engine.'),
      zu(
        'VMware Workstation',
        1,
        'Läuft als Programm auf einem Betriebssystem.',
      ),
      zu('Microsoft Hyper-V', 0, 'Läuft direkt auf der Hardware.'),
    ],
    explanation:
        'Typ 1: direkt auf der Hardware (ESXi, Hyper-V, KVM). Typ 2: auf einem Betriebssystem (VirtualBox, Workstation). Docker ist eine Container-Engine und kein Hypervisor.',
  ),
  rechnen(
    'a3-nc-4',
    'nw-cloud',
    prompt:
        'Ein Anbieter garantiert im SLA eine Verfügbarkeit von 99,5 % pro Jahr (365 Tage). Wie viele Stunden darf der Dienst höchstens ausfallen?',
    answer: 43.8,
    tolerance: 0.01,
    unit: 'h',
    explanation:
        'Stunden pro Jahr: 365 × 24 = 8.760 h. Erlaubter Ausfall: 0,5 % = 0,005. 8.760 h × 0,005 = 43,8 h.',
  ),
  rechnen(
    'a3-nc-5',
    'nw-cloud',
    scenario:
        'Ein eigener Server kostet 8.000 € in der Anschaffung und 1.500 € pro Jahr für Strom und Wartung. Eine vergleichbare Cloud-VM kostet 350 € im Monat.',
    prompt:
        'Um wie viel Euro ist die günstigere Variante über 4 Jahre billiger?',
    answer: 2800,
    unit: '€',
    explanation:
        'Eigener Server: 8.000 € + 1.500 € × 4 = 14.000 €. Cloud: 350 € × 48 Monate = 16.800 €. Der eigene Server ist 16.800 € - 14.000 € = 2.800 € günstiger.',
  ),
  rechnen(
    'a3-nc-6',
    'nw-cloud',
    scenario:
        '8 physische Server mit je 250 W werden auf 2 Virtualisierungshosts mit je 500 W zusammengelegt. Alle laufen rund um die Uhr (8.760 h), Strom kostet 0,28 € pro kWh.',
    prompt: 'Wie viel Stromkosten spart das pro Jahr?',
    answer: 2452.8,
    tolerance: 0.01,
    unit: '€',
    explanation:
        'Vorher: 8 × 250 W = 2.000 W. Nachher: 2 × 500 W = 1.000 W. Ersparnis 1 kW × 8.760 h = 8.760 kWh. 8.760 kWh × 0,28 € = 2.452,80 €.',
    difficulty: 3,
  ),
  zuordnen(
    'a3-nc-7',
    'nw-cloud',
    prompt: 'Welches Bereitstellungsmodell liegt vor?',
    buckets: [
      'Public Cloud',
      'Private Cloud',
      'Hybrid Cloud',
      'Community Cloud',
    ],
    items: [
      zu('Personaldaten intern, der Webshop beim großen Cloud-Anbieter', 2),
      zu(
        'Eine Cloud-Plattform im eigenen Rechenzentrum, nur für die eigene Firma',
        1,
      ),
      zu('Ein Online-Speicherdienst für beliebige Kunden', 0),
      zu(
        'Mehrere Kliniken teilen sich eine Cloud mit gleichen Datenschutzanforderungen',
        3,
      ),
    ],
    explanation:
        'Public: für alle. Private: für ein Unternehmen. Hybrid: Kombination aus beidem. Community: für eine Gruppe mit gemeinsamen Anforderungen.',
  ),
  einfach(
    'a3-nc-8',
    'nw-cloud',
    scenario:
        'Ein Unternehmen mietet bei einem Cloud-Anbieter virtuelle Server (IaaS) und installiert darauf Linux und seine Anwendung.',
    prompt:
        'Wer ist für die Sicherheitsupdates des Linux-Betriebssystems zuständig?',
    choices: [
      ja(
        'Das Unternehmen selbst',
        'Bei IaaS stellt der Anbieter nur die Infrastruktur, das Betriebssystem pflegt der Kunde.',
      ),
      nein('Der Cloud-Anbieter', 'Das wäre bei PaaS oder SaaS der Fall.'),
      nein(
        'Niemand, Cloud-Server brauchen keine Updates',
        'Auch virtuelle Server haben Schwachstellen.',
      ),
      nein(
        'Der Hersteller der Hardware',
        'Die Hardware liegt beim Anbieter, das Betriebssystem beim Kunden.',
      ),
    ],
    explanation:
        'Geteilte Verantwortung: Bei IaaS verantwortet der Kunde Betriebssystem, Anwendung, Daten und Zugänge.',
  ),
  einfach(
    'a3-nc-9',
    'nw-cloud',
    scenario:
        'Ein Webshop hält dem Ansturm im Weihnachtsgeschäft nicht stand. Statt einer größeren VM werden automatisch drei zusätzliche VMs hinter einem Lastverteiler gestartet.',
    prompt: 'Wie nennt man diese Art der Skalierung?',
    choices: [
      ja(
        'Horizontale Skalierung (scale out)',
        'Es werden mehr Maschinen hinzugefügt.',
      ),
      nein(
        'Vertikale Skalierung (scale up)',
        'Das wäre eine größere Maschine mit mehr CPU und RAM.',
      ),
      nein(
        'Konsolidierung',
        'Konsolidierung fasst Server zusammen, statt mehr zu starten.',
      ),
      nein('Customizing', 'Das ist das Anpassen von Standardsoftware.'),
    ],
    explanation:
        'Horizontal = mehr Instanzen, vertikal = größere Instanz. Die schnelle, automatische Anpassung an die Last nennt man Elastizität.',
  ),
  mehrfach(
    'a3-nc-10',
    'nw-cloud',
    prompt:
        'Welche Punkte sind vor dem Umzug personenbezogener Daten in eine Public Cloud zu klären?',
    choices: [
      ja(
        'Vertrag zur Auftragsverarbeitung nach Art. 28 DSGVO',
        'Der Anbieter verarbeitet Daten im Auftrag.',
      ),
      ja(
        'Standort der Rechenzentren',
        'Übermittlungen in Drittländer brauchen eine Rechtsgrundlage.',
      ),
      ja(
        'Möglichkeit, die Daten wieder zu exportieren',
        'Das vermeidet eine Abhängigkeit vom Anbieter.',
      ),
      nein(
        'Ob der Anbieter die Daten beliebig weiterverwenden darf',
        'Das darf ein Auftragsverarbeiter gerade nicht.',
      ),
      nein(
        'Nichts. Der Anbieter trägt die volle Verantwortung',
        'Verantwortlich bleibt das Unternehmen selbst.',
      ),
    ],
    explanation:
        'Auch in der Cloud bleibt das Unternehmen verantwortlich: Vertrag, Standort, Verschlüsselung und Ausstiegsstrategie müssen geklärt sein.',
  ),
];
