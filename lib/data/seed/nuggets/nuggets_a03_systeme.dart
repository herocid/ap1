import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 03, Teil 1: Hardware, Arbeitsplatz und
/// Betriebssysteme.
final List<Nugget> nuggetsA03Systeme = [
  // ======================================================= Komponenten eines PCs
  skizze(
    'n-hk-1',
    'h-komponenten',
    'Das EVA-Prinzip',
    'Jeder Computer arbeitet nach demselben Grundmuster: Daten kommen herein, werden verarbeitet und als Ergebnis ausgegeben. Dazu kommt die Speicherung, damit Daten einen Neustart überleben.',
    const FlussDiagramm([
      FlussKnoten('Eingabe', seitlich: 'Tastatur, Maus, Scanner'),
      FlussKnoten('Verarbeitung', seitlich: 'CPU mit Arbeitsspeicher'),
      FlussKnoten('Ausgabe', seitlich: 'Monitor, Drucker, Boxen'),
    ]),
    points: [
      'Speicherung: SSD oder Festplatte bewahren Daten dauerhaft auf',
      'Manche Geräte sind beides: Ein Touchscreen oder ein Netzwerkanschluss dient der Ein- und der Ausgabe',
    ],
  ),
  konzept(
    'n-hk-2',
    'h-komponenten',
    'Der Aufbau nach von Neumann',
    'Fast alle Computer folgen bis heute der Von-Neumann-Architektur: ein Prozessor, ein gemeinsamer Speicher für Programme und Daten sowie Ein- und Ausgabewerke, verbunden über ein Bussystem.',
    table: [
      ['Baustein', 'Aufgabe'],
      ['Steuerwerk', 'holt und entschlüsselt Befehle, steuert den Ablauf'],
      ['Rechenwerk (ALU)', 'rechnet und vergleicht'],
      ['Speicher', 'hält Programme und Daten gemeinsam'],
      ['Ein-/Ausgabewerk', 'verbindet mit der Peripherie'],
      ['Bussystem', 'Datenbus, Adressbus, Steuerbus'],
    ],
    merksatz: 'Steuerwerk und Rechenwerk bilden zusammen den Prozessor (CPU).',
  ),
  vergleich(
    'n-hk-3',
    'h-komponenten',
    'Die wichtigsten Komponenten',
    'Jede Komponente hat Kennzahlen, auf die es beim Kauf ankommt.',
    [
      ['Komponente', 'Aufgabe', 'Kennzahlen'],
      ['Prozessor (CPU)', 'führt Befehle aus', 'Kerne, Threads, Takt, Cache'],
      [
        'Arbeitsspeicher (RAM)',
        'hält laufende Programme',
        'Kapazität, DDR4/DDR5, Takt',
      ],
      [
        'Mainboard',
        'verbindet alle Komponenten',
        'Sockel, Chipsatz, Steckplätze',
      ],
      [
        'Grafik (GPU)',
        'berechnet die Bildausgabe',
        'integriert oder dediziert, VRAM',
      ],
      ['Datenträger', 'speichert dauerhaft', 'Kapazität, Anbindung, Tempo'],
      [
        'Netzteil',
        'versorgt alles mit Strom',
        'Leistung in Watt, Wirkungsgrad',
      ],
    ],
  ),
  konzept(
    'n-hk-4',
    'h-komponenten',
    'Kennzahlen des Prozessors',
    'Die Leistung einer CPU hängt nicht nur am Takt. Im Datenblatt stehen mehrere Werte, die du deuten können musst.',
    table: [
      ['Kennzahl', 'Bedeutung'],
      ['Kerne', 'eigenständige Recheneinheiten: echte Parallelität'],
      [
        'Threads',
        'gleichzeitige Befehlsstränge; mit SMT (Hyper-Threading) 2 je Kern',
      ],
      ['Takt (GHz)', 'Arbeitsschritte pro Sekunde; Basis- und Boost-Takt'],
      ['Cache (L1-L3)', 'sehr schneller Zwischenspeicher auf dem Chip'],
      ['TDP (Watt)', 'Wärmeabgabe: bestimmt Kühlung und Verbrauch'],
      ['Architektur', 'Befehlssatz, z. B. x86-64 oder ARM'],
    ],
    merksatz:
        'Ein Prozessor mit „8 Kernen / 16 Threads“ nutzt SMT: Jeder Kern bearbeitet zwei Threads abwechselnd, ist dadurch aber nicht doppelt so schnell.',
  ),
  konzept(
    'n-hk-5',
    'h-komponenten',
    'Arbeitsspeicher (RAM)',
    'Der Arbeitsspeicher hält laufende Programme und ihre Daten. Er ist flüchtig: Ohne Strom ist der Inhalt weg. Reicht er nicht, lagert das Betriebssystem auf die SSD aus. Das ist um ein Vielfaches langsamer und macht den Rechner träge.',
    points: [
      'Generation: DDR4 und DDR5 sind nicht steckkompatibel',
      'Kapazität: fürs Büro heute 16 GB, für Entwicklung und CAD 32 GB und mehr',
      'Dual-Channel: zwei gleiche Module verdoppeln die Bandbreite',
      'ECC-RAM erkennt und korrigiert Bitfehler: Standard in Servern',
    ],
  ),
  beispiel(
    'n-hk-6',
    'h-komponenten',
    'Bandbreite des Arbeitsspeichers',
    'Ein PC hat zwei Module DDR5-4800 im Dual-Channel-Betrieb. Wie hoch ist die theoretische Speicherbandbreite?',
    schritte: [
      'DDR5-4800 bedeutet 4.800 Millionen Übertragungen pro Sekunde (MT/s)',
      'Ein Modul überträgt je Vorgang 64 Bit = 8 Byte',
      'Ein Modul: 4.800 MT/s × 8 Byte = 38.400 MB/s = 38,4 GB/s',
      'Dual-Channel verdoppelt: 2 × 38,4 GB/s = 76,8 GB/s',
    ],
    ergebnis: '76,8 GB/s theoretische Bandbreite',
  ),
  vergleich(
    'n-hk-7',
    'h-komponenten',
    'Mainboard und Formfaktor',
    'Das Mainboard verbindet alles. Sockel und Chipsatz bestimmen, welche CPU passt, und an den Steckplätzen siehst du, was sich erweitern lässt.',
    [
      ['Element', 'Zweck'],
      ['Sockel', 'Aufnahme der CPU, z. B. AM5 oder LGA1700'],
      ['Chipsatz', 'steuert Schnittstellen und Erweiterungen'],
      ['DIMM-Slots', 'Arbeitsspeicher'],
      ['PCIe-Slots', 'Grafikkarte (x16), Netzwerkkarten'],
      ['M.2-Slot', 'SSD direkt auf dem Board'],
    ],
    points: [
      'Formfaktoren: ATX (groß, viele Steckplätze), Micro-ATX, Mini-ITX (klein, für kompakte PCs)',
    ],
  ),
  vergleich(
    'n-hk-8',
    'h-komponenten',
    'Grafik: integriert oder dediziert?',
    'Für Office-Arbeit genügt die im Prozessor eingebaute Grafik. Rechenintensive Bildarbeit braucht eine eigene Karte.',
    [
      ['', 'integriert (iGPU)', 'dediziert (Grafikkarte)'],
      ['Ort', 'im Prozessor', 'eigene Steckkarte'],
      [
        'Speicher',
        'nutzt den Arbeitsspeicher',
        'eigener Grafikspeicher (VRAM)',
      ],
      ['Leistung', 'Büro, Video', '3D, CAD, Spiele, KI'],
      ['Verbrauch', 'gering', 'hoch, eigene Stromanschlüsse'],
    ],
  ),
  beispiel(
    'n-hk-9',
    'h-komponenten',
    'Netzteil und Wirkungsgrad',
    'Ein PC braucht unter Last 300 W. Das Netzteil hat einen Wirkungsgrad von 90 %. Wie viel Leistung nimmt es aus der Steckdose auf, und wie viel geht als Wärme verloren?',
    schritte: [
      'Wirkungsgrad η = abgegebene Leistung / aufgenommene Leistung',
      'Aufnahme = 300 W / 0,9 = 333,3 W',
      'Verlust = 333,3 W - 300 W = 33,3 W, sie wird zu Wärme',
    ],
    ergebnis: 'rund 333 W Aufnahme, 33 W Verlust',
    merksatz:
        'Das Siegel 80 PLUS garantiert mindestens 80 % Wirkungsgrad, höhere Stufen wie Gold oder Platinum noch mehr.',
  ),
  skizze(
    'n-hk-10',
    'h-komponenten',
    'Der Bootvorgang',
    'Nach dem Einschalten übernimmt die Firmware auf dem Mainboard, bis das Betriebssystem läuft.',
    const FlussDiagramm([
      FlussKnoten('Einschalten', form: FlussForm.start),
      FlussKnoten('POST: Hardware-Selbsttest'),
      FlussKnoten('UEFI sucht Bootmedium', seitlich: 'nach Bootreihenfolge'),
      FlussKnoten('Bootloader starten', seitlich: 'Secure Boot prüft Signatur'),
      FlussKnoten('Kernel lädt Treiber'),
      FlussKnoten('Dienste und Anmeldung', form: FlussForm.ende),
    ]),
    points: [
      'POST (Power-On Self-Test) prüft CPU, RAM und Grafik und meldet Fehler per Piepton oder Anzeige',
      'Die Bootreihenfolge legt fest, ob zuerst SSD, USB-Stick oder Netzwerk (PXE) versucht wird',
    ],
  ),
  vergleich(
    'n-hk-11',
    'h-komponenten',
    'BIOS oder UEFI?',
    'UEFI hat das klassische BIOS abgelöst. Umgangssprachlich heißt das Einstellungsmenü trotzdem oft noch „BIOS“.',
    [
      ['', 'BIOS', 'UEFI'],
      ['Stand', 'seit den 1980ern', 'heutiger Standard'],
      ['Partitionstabelle', 'MBR, max. 2 TiB', 'GPT, sehr große Datenträger'],
      ['Oberfläche', 'Text, Tastatur', 'grafisch, auch mit Maus'],
      ['Secure Boot', 'nein', 'ja: startet nur signierte Bootloader'],
    ],
  ),
  vergleich(
    'n-hk-12',
    'h-komponenten',
    'Welcher Rechner für welchen Arbeitsplatz?',
    'In der Prüfung sollst du oft begründen, welche Ausstattung zu einem Einsatz passt. Diese Richtwerte helfen dabei.',
    [
      ['Einsatz', 'CPU / RAM', 'Grafik / Speicher'],
      ['Büro', '4-6 Kerne, 16 GB', 'integriert, 512 GB SSD'],
      ['Entwicklung', '8+ Kerne, 32 GB', 'integriert, 1 TB NVMe'],
      ['CAD, Video', '8+ Kerne, 32-64 GB', 'dediziert, schnelle NVMe'],
      ['Thin Client', 'sparsam, 4-8 GB', 'Programme laufen auf dem Server'],
    ],
    points: [
      'Notebook statt Desktop, wenn mobil gearbeitet wird; dann auch Akku, Gewicht und Dockingstation bedenken',
    ],
  ),
  falle(
    'n-hk-13',
    'h-komponenten',
    'Passt die Komponente?',
    'Ein Prozessor passt nur in ein Mainboard mit passendem Sockel und Chipsatz. Arbeitsspeicher muss zur unterstützten Generation passen: DDR5-Module passen nicht in DDR4-Steckplätze. Und eine starke Grafikkarte braucht ein Netzteil mit genug Leistung und den passenden Anschlüssen.',
  ),
  merke(
    'n-hk-14',
    'h-komponenten',
    'Das Wichtigste zu Komponenten',
    'Diese Punkte solltest du zu den PC-Komponenten sicher beherrschen.',
    points: [
      'EVA: Eingabe, Verarbeitung, Ausgabe plus Speicherung',
      'CPU: Kerne, Threads, Takt, Cache, TDP',
      'RAM ist flüchtig; zu wenig RAM macht den Rechner träge',
      'Start: POST, UEFI, Bootloader, Kernel',
    ],
    satz:
        'Kläre zuerst, was der Arbeitsplatz braucht, und wähle dann Komponenten, die zueinander passen.',
  ),

  // ======================================================= Speicher: HDD und SSD
  skizze(
    'n-hs-1',
    'h-speicher',
    'Die Speicherhierarchie',
    'Je näher ein Speicher am Prozessor liegt, desto schneller, teurer und kleiner ist er. Deshalb kombiniert jeder Rechner mehrere Stufen.',
    const StapelDiagramm(
      [
        StapelEbene('Register', 'Bytes, im Prozessorkern'),
        StapelEbene('Cache L1-L3', 'KB bis MB, auf dem Chip'),
        StapelEbene('Arbeitsspeicher', 'GB, flüchtig'),
        StapelEbene('SSD', 'TB, nicht flüchtig'),
        StapelEbene('HDD', 'viele TB, mechanisch'),
        StapelEbene('Band / Archiv', 'Langzeitsicherung'),
      ],
      pyramide: true,
      oben: 'schnell, teuer, klein',
      unten: 'langsam, günstig, groß',
    ),
  ),
  vergleich(
    'n-hs-2',
    'h-speicher',
    'Flüchtig oder nicht flüchtig?',
    'Flüchtige Speicher verlieren ihren Inhalt ohne Strom. Nicht flüchtige behalten ihn, deshalb landen deine Dateien dort.',
    [
      ['Art', 'Beispiele', 'Einsatz'],
      ['flüchtig', 'Register, Cache, RAM', 'laufende Programme'],
      [
        'nicht flüchtig',
        'SSD, HDD, USB-Stick, Band',
        'Dateien, System, Backup',
      ],
      ['Firmware-Speicher', 'Flash auf dem Mainboard', 'UEFI'],
    ],
  ),
  vergleich(
    'n-hs-3',
    'h-speicher',
    'HDD oder SSD?',
    'Die beiden Technologien unterscheiden sich grundlegend.',
    [
      ['', 'HDD (Festplatte)', 'SSD'],
      [
        'Technik',
        'rotierende Magnetscheiben',
        'Flash-Speicher, keine Mechanik',
      ],
      ['Zugriffszeit', 'ca. 5-10 ms', 'unter 0,1 ms'],
      ['Preis pro GB', 'günstiger', 'teurer'],
      ['Stöße', 'empfindlich', 'robust'],
      ['Geräusch, Strom', 'hörbar, mehr Strom', 'lautlos, sparsam'],
      ['Einsatz', 'Archive, Backups', 'System, Programme, Laptops'],
    ],
  ),
  vergleich(
    'n-hs-4',
    'h-speicher',
    'Anbindung und Bauform von SSDs',
    'Auch SSDs sind nicht gleich schnell. Entscheidend ist die Anbindung, nicht die Form.',
    [
      ['Variante', 'Anbindung', 'Lesen bis ca.'],
      ['2,5-Zoll-SSD', 'SATA', '550 MB/s'],
      ['M.2 SATA', 'SATA', '550 MB/s'],
      ['M.2 NVMe, PCIe 3.0', '4 PCIe-Lanes', '3,5 GB/s'],
      ['M.2 NVMe, PCIe 4.0', '4 PCIe-Lanes', '7 GB/s'],
      ['M.2 NVMe, PCIe 5.0', '4 PCIe-Lanes', '14 GB/s'],
    ],
    merksatz:
        'M.2 ist nur die Bauform. Ob schnell (NVMe) oder langsam (SATA), steht im Datenblatt.',
  ),
  vergleich(
    'n-hs-5',
    'h-speicher',
    'Wechselmedien und Netzwerkspeicher',
    'Nicht jeder Speicher steckt im PC. Für Austausch, Sicherung und gemeinsam genutzte Daten gibt es eigene Lösungen.',
    [
      ['Speicher', 'Merkmal'],
      ['USB-Stick, SD-Karte', 'Flash, mobil, für den Datenaustausch'],
      ['Magnetband (LTO)', 'günstig pro TB, langlebig, für Archiv und Backup'],
      ['DAS', 'Direct Attached Storage: direkt am Server angeschlossen'],
      ['NAS', 'Dateispeicher im Netz, Zugriff per SMB oder NFS'],
      ['SAN', 'eigenes Speichernetz, blockbasiert, für Server'],
    ],
  ),
  vergleich(
    'n-hs-6',
    'h-speicher',
    'Dezimal oder binär?',
    'Hersteller rechnen mit Zehnerpotenzen, Betriebssysteme wie Windows oft mit Zweierpotenzen. Für die binären Einheiten gibt es eigene Namen mit „bi“.',
    [
      ['Stufe', 'dezimal', 'binär'],
      ['Kilo / Kibi', '1 kB = 1.000 B', '1 KiB = 1.024 B'],
      ['Mega / Mebi', '1 MB = 1.000² B', '1 MiB = 1.024² B'],
      ['Giga / Gibi', '1 GB = 1.000³ B', '1 GiB = 1.024³ B'],
      ['Tera / Tebi', '1 TB = 1.000⁴ B', '1 TiB = 1.024⁴ B'],
    ],
    points: [
      '1 Byte = 8 Bit: Datenraten stehen meist in Bit pro Sekunde, Dateigrößen in Byte',
    ],
  ),
  formel(
    'n-hs-7',
    'h-speicher',
    'Umrechnen zwischen den Einheiten',
    'Umgerechnet wird am sichersten über die Byte-Zahl: erst den Wert in Byte ausrechnen, dann durch die Zieleinheit teilen.',
    'Byte = Wert × 1.000^n   (k: n=1, M: 2, G: 3, T: 4)\n'
        'Byte = Wert × 1.024^n   (Ki: n=1, Mi: 2, Gi: 3, Ti: 4)\n'
        'Bit  = Byte × 8',
    merksatz:
        'Willst du von GB nach GiB, rechnest du erst die Byte-Zahl aus und teilst sie dann durch 1.024³.',
  ),
  beispiel(
    'n-hs-8',
    'h-speicher',
    'Wo sind die Gigabytes hin?',
    'Eine neue SSD ist mit 1 TB beschriftet. Windows zeigt nur rund 931 „GB“ an. Rechne nach, ob etwas fehlt.',
    schritte: [
      'Herstellerangabe: 1 TB = 1.000⁴ Byte = 1.000.000.000.000 Byte',
      '1 GiB = 1.024³ Byte = 1.073.741.824 Byte',
      '1.000.000.000.000 / 1.073.741.824 ≈ 931,32',
      'Windows rechnet in GiB, beschriftet aber mit „GB“',
    ],
    ergebnis: '1 TB ≈ 931,32 GiB, es fehlt nichts',
  ),
  beispiel(
    'n-hs-9',
    'h-speicher',
    'Speicherbedarf eines Bildes',
    'Ein Foto hat 1920 × 1080 Pixel mit 24 Bit Farbtiefe und wird unkomprimiert gespeichert. Wie groß ist die Datei?',
    schritte: [
      'Pixelzahl: 1920 × 1080 = 2.073.600 Pixel',
      'Farbtiefe: 24 Bit = 3 Byte pro Pixel',
      'Größe: 2.073.600 × 3 Byte = 6.220.800 Byte',
      'in MB: 6.220.800 / 1.000.000 ≈ 6,22 MB, in MiB: 6.220.800 / 1.048.576 ≈ 5,93 MiB',
    ],
    ergebnis: 'rund 6,22 MB (5,93 MiB)',
  ),
  beispiel(
    'n-hs-10',
    'h-speicher',
    'Speicherbedarf von Audio',
    'Eine Minute Musik in CD-Qualität: 44.100 Hz Abtastrate, 16 Bit je Abtastwert, Stereo (2 Kanäle), unkomprimiert. Wie viel Speicher braucht sie?',
    schritte: [
      'Bit pro Sekunde: 44.100 × 16 × 2 = 1.411.200 Bit/s',
      'eine Minute: 1.411.200 × 60 = 84.672.000 Bit',
      'in Byte: 84.672.000 / 8 = 10.584.000 Byte',
      'in MB: 10.584.000 / 1.000.000 ≈ 10,58 MB',
    ],
    ergebnis: 'rund 10,6 MB pro Minute',
  ),
  beispiel(
    'n-hs-11',
    'h-speicher',
    'Speicherkapazität planen',
    'Ein Dateiserver soll die Daten von 40 Beschäftigten mit je 25 GB aufnehmen. Geplant werden 30 % Wachstum und auf das Ergebnis 20 % Reserve. Wie groß muss der Speicher mindestens sein?',
    schritte: [
      'Grundbedarf: 40 × 25 GB = 1.000 GB',
      'mit Wachstum: 1.000 GB × 1,3 = 1.300 GB',
      'mit Reserve: 1.300 GB × 1,2 = 1.560 GB',
      'nächste handelsübliche Größe wählen, z. B. 2 TB',
    ],
    ergebnis: 'mindestens 1.560 GB: gewählt werden 2 TB',
  ),
  falle(
    'n-hs-12',
    'h-speicher',
    'SSDs verschleißen',
    'Flash-Zellen vertragen nur eine begrenzte Zahl von Schreibvorgängen. Hersteller geben die Haltbarkeit als TBW (Terabytes Written) an. Für Büro-PCs reicht das meist viele Jahre, für schreibintensive Server muss man es einplanen.',
  ),
  merke(
    'n-hs-13',
    'h-speicher',
    'Das Wichtigste zu Speichern',
    'Diese Punkte solltest du zu Speichern und Einheiten sicher beherrschen.',
    points: [
      'Hierarchie: Register - Cache - RAM - SSD - HDD - Band',
      'SSD schnell und robust, HDD günstig pro GB',
      'M.2 ist die Bauform, NVMe die schnelle Anbindung',
      '1 TB = 1.000⁴ Byte ≈ 931 GiB',
      'Bild: Pixel × Farbtiefe; Audio: Abtastrate × Bit × Kanäle × Sekunden',
    ],
    satz:
        'Bei Speicherrechnungen zuerst alles in Byte umrechnen. Dann ist die Einheit nie das Problem.',
  ),

  // ============================================ Schnittstellen und Peripherie
  konzept(
    'n-hi-1',
    'h-schnittstellen',
    'Was eine Schnittstelle ist',
    'Eine Schnittstelle verbindet Komponenten oder Geräte über einen festgelegten Stecker, ein elektrisches Signal und ein Protokoll. Heute übertragen fast alle seriell: Bit für Bit, dafür sehr schnell.',
    table: [
      ['Art', 'Beispiele'],
      ['intern', 'PCIe, SATA, M.2'],
      ['extern, Daten', 'USB, Thunderbolt'],
      ['extern, Bild', 'HDMI, DisplayPort'],
      ['Netzwerk', 'RJ45 (Ethernet), WLAN'],
      ['kabellos, nah', 'Bluetooth, NFC'],
    ],
  ),
  vergleich(
    'n-hi-2',
    'h-schnittstellen',
    'USB-Generationen und Thunderbolt',
    'Die USB-Namen haben sich mehrfach geändert. Entscheidend ist die Datenrate im Datenblatt.',
    [
      ['Standard', 'max. Datenrate'],
      ['USB 2.0', '480 Mbit/s'],
      ['USB 3.2 Gen 1 (früher USB 3.0)', '5 Gbit/s'],
      ['USB 3.2 Gen 2', '10 Gbit/s'],
      ['USB 3.2 Gen 2x2', '20 Gbit/s'],
      ['USB4', '20 oder 40 Gbit/s'],
      ['USB4 Version 2.0', '80 Gbit/s'],
      ['Thunderbolt 3 und 4', '40 Gbit/s'],
      ['Thunderbolt 5', '80 Gbit/s'],
    ],
  ),
  konzept(
    'n-hi-3',
    'h-schnittstellen',
    'Stecker und Strom über USB',
    'USB-C ist eine verdrehsichere Steckerform. Über sie können Daten, Bild (DisplayPort-Modus) und Strom zugleich laufen.',
    points: [
      'Typ A: flacher Stecker am PC, Typ B: Drucker und Geräte, Micro-B: ältere Handys',
      'USB Power Delivery: bis 100 W, seit Version 3.1 bis 240 W',
      'Thunderbolt nutzt ebenfalls den USB-C-Stecker',
    ],
  ),
  falle(
    'n-hi-4',
    'h-schnittstellen',
    'USB-C ist kein Tempo',
    'USB-C beschreibt nur die Form des Steckers. Über einen USB-C-Anschluss kann USB 2.0 mit 480 Mbit/s laufen oder USB4 mit 40 Gbit/s. Welche Geschwindigkeit möglich ist, steht im Datenblatt, nicht auf dem Stecker. Auch das Kabel muss die Datenrate schaffen.',
  ),
  formel(
    'n-hi-5',
    'h-schnittstellen',
    'Übertragungszeit berechnen',
    'Datenraten werden in Bit pro Sekunde angegeben, Dateigrößen in Byte. Vor dem Teilen muss beides in dieselbe Einheit.',
    'Zeit (s) = Datenmenge (Bit) / Datenrate (Bit/s)\n'
        '1 Byte   = 8 Bit\n'
        '1 Gbit/s = 1.000 Mbit/s = 1.000.000.000 Bit/s',
    merksatz:
        'Die Rechnung ergibt den theoretischen Bestwert. In der Praxis kostet Protokoll-Overhead zusätzlich Zeit.',
  ),
  beispiel(
    'n-hi-6',
    'h-schnittstellen',
    'USB 2.0 gegen USB 3.2 Gen 1',
    'Ein 12-GB-Video soll auf einen externen Datenträger kopiert werden. Wie lange dauert das theoretisch mit USB 2.0 und mit USB 3.2 Gen 1?',
    schritte: [
      'Datenmenge in Bit: 12 GB × 8 = 96 Gbit = 96.000 Mbit',
      'USB 2.0: 96.000 Mbit / 480 Mbit/s = 200 s',
      'USB 3.2 Gen 1: 96.000 Mbit / 5.000 Mbit/s = 19,2 s',
      'Verhältnis: 200 s / 19,2 s ≈ 10,4-mal schneller',
    ],
    ergebnis: 'USB 2.0: 200 s (3 min 20 s), USB 3.2 Gen 1: 19,2 s',
  ),
  vergleich(
    'n-hi-7',
    'h-schnittstellen',
    'Bildschirmanschlüsse',
    'Für aktuelle Monitore sind digitale Anschlüsse Standard. Welche Auflösung und Bildrate möglich ist, hängt von der Version ab.',
    [
      ['Anschluss', 'Signal', 'max. Datenrate'],
      ['VGA', 'analog, nur Bild', 'veraltet'],
      ['DVI-D', 'digital, nur Bild', 'ca. 8 Gbit/s'],
      ['HDMI 2.0', 'digital, Bild und Ton', '18 Gbit/s'],
      ['HDMI 2.1', 'digital, Bild und Ton', '48 Gbit/s'],
      ['DisplayPort 1.4', 'digital, Bild und Ton', '32,4 Gbit/s'],
      ['DisplayPort 2.1', 'digital, Bild und Ton', 'bis 80 Gbit/s'],
    ],
    points: [
      'HDMI: Standard bei Fernsehern und Beamern',
      'DisplayPort: verbreitet bei PC-Monitoren, mehrere Monitore hintereinander möglich (MST)',
    ],
  ),
  beispiel(
    'n-hi-8',
    'h-schnittstellen',
    'Reicht der Anschluss für 4K?',
    'Ein Monitor soll 3840 × 2160 Pixel mit 60 Hz und 24 Bit Farbtiefe zeigen. Welche Datenrate braucht das unkomprimierte Bild, und reicht HDMI 2.0?',
    schritte: [
      'Pixel pro Bild: 3840 × 2160 = 8.294.400',
      'Bit pro Bild: 8.294.400 × 24 = 199.065.600 Bit',
      'pro Sekunde: 199.065.600 × 60 ≈ 11,94 Gbit/s',
      'HDMI 2.0 schafft 18 Gbit/s. Das reicht; HDMI 1.4 mit 10,2 Gbit/s nicht',
    ],
    ergebnis: 'rund 11,9 Gbit/s: HDMI 2.0 genügt',
  ),
  vergleich(
    'n-hi-9',
    'h-schnittstellen',
    'Monitore vergleichen',
    'Diese Kennzahlen stehen in jedem Monitor-Datenblatt und entscheiden über die Eignung.',
    [
      ['Kennzahl', 'Bedeutung'],
      ['Auflösung', 'Full HD 1920 × 1080, WQHD 2560 × 1440, 4K 3840 × 2160'],
      ['Diagonale', 'in Zoll, 1 Zoll = 2,54 cm'],
      ['Bildwiederholrate', 'in Hz, wichtig für flüssige Bewegung'],
      ['Reaktionszeit', 'in ms: kurze Zeiten vermeiden Schlieren'],
      ['Panel IPS', 'gute Farben und Blickwinkel'],
      ['Panel VA', 'hoher Kontrast'],
      ['Panel TN', 'schnell und günstig, schwache Blickwinkel'],
      ['OLED', 'perfektes Schwarz, teurer'],
    ],
  ),
  beispiel(
    'n-hi-10',
    'h-schnittstellen',
    'Diagonale und Pixeldichte',
    'Ein 27-Zoll-Monitor hat WQHD-Auflösung (2560 × 1440). Wie groß ist die Diagonale in cm, und wie hoch ist die Pixeldichte?',
    schritte: [
      'Diagonale: 27 × 2,54 cm = 68,58 cm',
      'Pixel auf der Diagonale (Pythagoras): √(2560² + 1440²) = √8.627.200 ≈ 2.937,2',
      'Pixeldichte: 2.937,2 / 27 Zoll ≈ 108,8 ppi (Pixel pro Zoll)',
    ],
    ergebnis: '68,6 cm Diagonale, rund 109 ppi',
  ),
  beispiel(
    'n-hi-11',
    'h-schnittstellen',
    'Laser oder Tinte? Kosten pro Seite',
    'Ein Büro druckt 2.000 Seiten im Monat. Toner kostet 80 € und reicht für 4.000 Seiten, eine Tintenpatrone kostet 25 € und reicht für 500 Seiten. Wie hoch sind die monatlichen Kosten für das Verbrauchsmaterial?',
    table: [
      ['', 'Laserdrucker', 'Tintenstrahl'],
      ['Stärke', 'schnell, günstig bei viel Text', 'Fotos, günstiges Gerät'],
      ['Material', 'Toner', 'Tintenpatronen'],
      ['passt zu', 'hohem Druckvolumen', 'wenig Druck, Fotos'],
    ],
    schritte: [
      'Laser: 80 € / 4.000 Seiten = 0,02 € pro Seite',
      'Tinte: 25 € / 500 Seiten = 0,05 € pro Seite',
      'Laser: 2.000 × 0,02 € = 40 € pro Monat',
      'Tinte: 2.000 × 0,05 € = 100 € pro Monat',
    ],
    ergebnis: 'Laser 40 €, Tinte 100 € im Monat',
  ),
  konzept(
    'n-hi-12',
    'h-schnittstellen',
    'Dockingstation, Bluetooth und NFC',
    'Am mobilen Arbeitsplatz verbindet oft ein einziges Kabel das Notebook mit allem Übrigen, und kurze Funkstrecken ersetzen Kabel.',
    points: [
      'Dockingstation über USB-C oder Thunderbolt: Strom, Monitore, Netzwerk und USB-Geräte über ein Kabel',
      'Bluetooth: Funk über wenige Meter für Maus, Tastatur und Headset',
      'NFC: wenige Zentimeter, z. B. zum Bezahlen oder Koppeln von Geräten',
      'KVM-Switch: ein Satz Tastatur, Monitor und Maus für mehrere Rechner',
    ],
  ),
  konzept(
    'n-hi-15',
    'h-schnittstellen',
    'Daisy Chaining: Monitore in Reihe',
    'Beim Daisy Chaining hängen mehrere Monitore hintereinander an einem einzigen Bildausgang des PCs. Das Signal läuft vom PC zum ersten Monitor und von dessen Ausgang weiter zum nächsten. Die Technik dahinter heißt Multi-Stream Transport (MST). Sie gehört zu DisplayPort ab Version 1.2; auch Thunderbolt kann Monitore verketten.',
    table: [
      ['Voraussetzung', 'Warum'],
      [
        'PC-Ausgang mit MST',
        'DisplayPort oder Thunderbolt: HDMI kann keine Kette',
      ],
      [
        'Monitor mit DP-Ausgang',
        'reicht das Signal weiter; der letzte braucht keinen',
      ],
      [
        'genug Bandbreite',
        'alle Bilder teilen sich die Datenrate des einen Ausgangs',
      ],
    ],
    points: [
      'Vorteil: weniger Kabel zum PC, aufgeräumter Arbeitsplatz, ein Ausgang genügt',
      'MST muss oft erst im Menü des Monitors eingeschaltet werden',
      'Verkabelung: PC-Ausgang -> Monitor 1 IN, Monitor 1 OUT -> Monitor 2 IN und so weiter',
    ],
  ),
  beispiel(
    'n-hi-16',
    'h-schnittstellen',
    'Reicht ein Ausgang für drei Monitore?',
    'Drei Full-HD-Monitore (1920 × 1080, 60 Hz, 24 Bit) sollen als Kette an einem DisplayPort-1.4-Ausgang (32,4 Gbit/s) laufen. Reicht die Datenrate für die unkomprimierten Bilder?',
    schritte: [
      'ein Monitor: 1920 × 1080 × 24 Bit × 60 = 2.985.984.000 Bit/s ≈ 2,99 Gbit/s',
      'drei Monitore: 3 × 2,99 Gbit/s ≈ 8,96 Gbit/s',
      'Vergleich: 8,96 Gbit/s liegt deutlich unter 32,4 Gbit/s',
      'Zusätzlich prüfen: PC-Ausgang und die ersten beiden Monitore müssen MST unterstützen',
    ],
    ergebnis: 'rund 9 Gbit/s, die Kette passt an einen DisplayPort-1.4-Ausgang',
  ),
  vergleich(
    'n-hi-17',
    'h-schnittstellen',
    'Anschlüsse am Gerät erkennen',
    'Auf der Rückseite eines PCs sitzt das I/O-Panel mit allen Buchsen. In der Prüfung werden solche Buchsen als Bild gezeigt. Du musst sie benennen und ihren Zweck kennen.',
    [
      ['Anschluss', 'Merkmal', 'Zweck'],
      ['RJ45', 'achtpolig, Rastnase', 'Netzwerkkabel (LAN)'],
      ['USB-A', 'flach, rechteckig', 'Maus, Tastatur, Stick'],
      ['USB-C', 'klein, oval, verdrehsicher', 'Daten, Bild, Strom'],
      ['HDMI', 'flach, zwei schräge Ecken', 'Bild und Ton'],
      ['DisplayPort', 'eine schräge Ecke', 'Bild, Ton, Monitorkette'],
      ['Klinke 3,5 mm', 'rund', 'Headset, Lautsprecher'],
      ['Kaltgerätebuchse', 'drei flache Stifte', 'Netzkabel 230 V'],
    ],
    points: [
      'Die Kaltgerätebuchse (IEC C14) sitzt am Netzteil von PC, Monitor oder Drucker, hier steckt das Stromkabel',
      'Thunderbolt nutzt die USB-C-Buchse und ist mit einem Blitz gekennzeichnet',
    ],
  ),
  beispiel(
    'n-hi-18',
    'h-schnittstellen',
    'Reicht der Strom am USB-Port?',
    'Ein Kartenleser wird mit einem Netzteil 9 V / 2 A geliefert. Er soll stattdessen über USB (5 V) versorgt werden. Welchen Strom müsste der USB-Port liefern? Es gilt P = U × I.',
    table: [
      ['Anschluss', 'Strom bei 5 V', 'Leistung'],
      ['USB 2.0 Typ A', '0,5 A', '2,5 W'],
      ['USB 3.x Typ A', '0,9 A', '4,5 W'],
      ['USB-C', 'bis 3 A', '15 W'],
      ['USB Power Delivery', 'höhere Spannung', 'bis 100 W, neu bis 240 W'],
    ],
    schritte: [
      'Leistung des Geräts: P = U × I = 9 V × 2 A = 18 W',
      'Strom bei 5 V: I = P / U = 18 W / 5 V = 3,6 A',
      'Vergleich: Ein USB-A-Port liefert 0,5 bzw. 0,9 A, USB-C ohne Power Delivery bis 3 A',
      'Der Port würde also überlastet, und das Gerät liefe instabil oder gar nicht',
    ],
    ergebnis:
        '3,6 A; das schafft ein normaler USB-Port nicht, also bleibt es beim Netzteil',
  ),
  falle(
    'n-hi-13',
    'h-schnittstellen',
    'Megabit ist nicht Megabyte',
    'Eine „100-Mbit-Leitung“ überträgt höchstens 12,5 MB pro Sekunde. Wer Mbit/s und MB/s verwechselt, liegt um den Faktor 8 daneben. Achte auf das kleine b (Bit) und das große B (Byte).',
  ),
  merke(
    'n-hi-14',
    'h-schnittstellen',
    'Das Wichtigste zu Schnittstellen',
    'Diese Werte und Regeln solltest du zu Schnittstellen sicher kennen.',
    points: [
      'USB 2.0: 480 Mbit/s, 3.2 Gen 1: 5 Gbit/s, Gen 2: 10 Gbit/s, USB4: bis 40 Gbit/s',
      'Thunderbolt 3 und 4: 40 Gbit/s',
      'HDMI und DisplayPort: Bild und Ton digital, VGA: analog',
      'Zeit = Datenmenge in Bit / Datenrate in Bit/s',
    ],
    satz: 'Der Stecker sagt nichts über das Tempo, und Byte mal 8 ergibt Bit.',
  ),

  // =================================================== USV und Stromversorgung
  konzept(
    'n-hu-1',
    'h-usv',
    'Wozu eine USV?',
    'Eine unterbrechungsfreie Stromversorgung (USV) überbrückt Stromausfälle mit einem Akku und glättet Störungen im Netz. Server und Netzwerktechnik laufen weiter, lange genug, um sie geordnet herunterzufahren.',
    points: [
      'Stromausfall',
      'Spannungseinbrüche und Überspannung',
      'kurze Spannungsspitzen, etwa durch Blitz oder Schaltvorgänge',
      'Frequenzschwankungen',
    ],
  ),
  vergleich(
    'n-hu-2',
    'h-usv',
    'Drei USV-Typen',
    'Die Typen unterscheiden sich darin, wie stark sie die Last vom Stromnetz entkoppeln. Die Kürzel VFD, VI und VFI sagen, wovon die Ausgangsspannung abhängt.',
    [
      ['Typ', 'Klasse', 'Arbeitsweise', 'Umschalten'],
      [
        'Offline (Standby)',
        'VFD',
        'Last am Netz, bei Ausfall Akku',
        'ca. 4-10 ms',
      ],
      [
        'Line-Interactive',
        'VI',
        'regelt zusätzlich die Spannung',
        'ca. 2-4 ms',
      ],
      ['Online (Doppelwandler)', 'VFI', 'Last immer am Wechselrichter', '0 ms'],
    ],
    points: [
      'VFD: Ausgang abhängig von Spannung und Frequenz des Netzes',
      'VI: Ausgang unabhängig von der Netzspannung',
      'VFI: Ausgang unabhängig von Spannung und Frequenz, bester Schutz',
    ],
  ),
  skizze(
    'n-hu-3',
    'h-usv',
    'So arbeitet die Online-USV',
    'Bei der Online-USV fließt der Strom immer über Gleichrichter und Wechselrichter. Fällt das Netz aus, speist der Akku den Zwischenkreis, ohne jede Umschaltung.',
    const FlussDiagramm([
      FlussKnoten('Stromnetz (230 V ~)'),
      FlussKnoten('Gleichrichter', seitlich: 'lädt den Akku'),
      FlussKnoten('Zwischenkreis mit Akku'),
      FlussKnoten('Wechselrichter'),
      FlussKnoten('Server, Switch, Firewall'),
    ]),
    points: [
      'Bypass: Bei Defekt oder Wartung schaltet die USV die Last direkt ans Netz',
      'Nachteil: Die ständige Wandlung kostet Wirkungsgrad, also Strom und Wärme',
    ],
  ),
  formel(
    'n-hu-4',
    'h-usv',
    'Scheinleistung, Wirkleistung, Leistungsfaktor',
    'Geräte geben ihren Bedarf in Watt an (Wirkleistung P), USVs ihre Leistung meist in VA (Scheinleistung S). Beide verbindet der Leistungsfaktor, oft als cos φ angegeben.',
    'P (W)  = S (VA) × Leistungsfaktor\n'
        'S (VA) = P (W) / Leistungsfaktor\n'
        'nötige VA = Summe W × (1 + Reserve) / Faktor',
    merksatz:
        'Der Leistungsfaktor ist höchstens 1. Deshalb ist die VA-Zahl immer mindestens so groß wie die Watt-Zahl.',
  ),
  beispiel(
    'n-hu-5',
    'h-usv',
    'Eine USV dimensionieren',
    'Im Serverschrank hängen die Geräte aus der Tabelle. Geplant werden 20 % Reserve, der Leistungsfaktor der USV ist 0,8. Wie groß muss die USV sein?',
    table: [
      ['Gerät', 'Anzahl', 'Leistung'],
      ['Server', '2', 'je 350 W'],
      ['Switch', '1', '60 W'],
      ['Firewall', '1', '40 W'],
      ['NAS', '1', '50 W'],
    ],
    schritte: [
      'Summe: 2 × 350 W + 60 W + 40 W + 50 W = 850 W',
      'mit Reserve: 850 W × 1,2 = 1.020 W',
      'Scheinleistung: 1.020 W / 0,8 = 1.275 VA',
      'nächstgrößeres Modell wählen: 1.500 VA, liefert 1.500 × 0,8 = 1.200 W',
    ],
    ergebnis: 'mindestens 1.275 VA: gewählt wird eine 1.500-VA-USV',
  ),
  beispiel(
    'n-hu-6',
    'h-usv',
    'Wie viel Watt schafft die USV?',
    'Eine USV hat 3.000 VA bei einem Leistungsfaktor von 0,9. Angeschlossen werden sollen Geräte mit zusammen 2.500 W. Reicht das?',
    schritte: [
      'Wirkleistung der USV: 3.000 VA × 0,9 = 2.700 W',
      'Vergleich: 2.500 W ≤ 2.700 W, die Last passt',
      'Auslastung: 2.500 W / 2.700 W ≈ 92,6 %',
      'Reserve nur noch 200 W; für Erweiterungen zu knapp',
    ],
    ergebnis: 'reicht knapp (92,6 % Auslastung): besser größer planen',
  ),
  formel(
    'n-hu-7',
    'h-usv',
    'Die Überbrückungszeit abschätzen',
    'Wie lange der Akku reicht, hängt von seiner Energie und der Last ab. Die Energie in Wattstunden ergibt sich aus Spannung mal Kapazität.',
    'Energie (Wh) = Spannung (V) × Kapazität (Ah) × Anzahl Akkus\n'
        'Zeit (h)     = Energie (Wh) × Wirkungsgrad / Last (W)\n'
        'Zeit (min)   = Zeit (h) × 60',
    merksatz:
        'Das ist eine Näherung. Genaue Werte liefern die Laufzeittabellen der Hersteller; bei halber Last hält der Akku oft mehr als doppelt so lange.',
  ),
  beispiel(
    'n-hu-8',
    'h-usv',
    'Überbrückungszeit berechnen',
    'Eine USV hat 4 Akkus mit je 12 V und 9 Ah. Der Wechselrichter arbeitet mit 90 % Wirkungsgrad, die Last beträgt 650 W. Wie lange überbrückt sie?',
    schritte: [
      'Energie: 4 × 12 V × 9 Ah = 432 Wh',
      'nutzbar: 432 Wh × 0,9 = 388,8 Wh',
      'Zeit: 388,8 Wh / 650 W ≈ 0,598 h',
      'in Minuten: 0,598 h × 60 ≈ 35,9 min',
    ],
    ergebnis: 'rund 36 Minuten',
  ),
  ablauf(
    'n-hu-9',
    'h-usv',
    'Automatisch herunterfahren',
    'Eine USV nützt nur, wenn die Server rechtzeitig und geordnet herunterfahren. Das übernimmt eine Software, die mit der USV kommuniziert.',
    [
      'Stromausfall: Die USV versorgt die Last aus dem Akku',
      'Die USV meldet den Ausfall über USB oder Netzwerk (SNMP-Karte) an die Server',
      'Sinkt die Restlaufzeit unter eine Schwelle, z. B. 10 Minuten, startet das Herunterfahren',
      'Reihenfolge: erst Anwendungen und VMs, dann Hosts, zuletzt Speicher und Netzwerk',
      'Kehrt der Strom zurück, lädt die USV den Akku und die Systeme starten wieder',
    ],
  ),
  konzept(
    'n-hu-10',
    'h-usv',
    'Betrieb und Wartung',
    'Auch eine USV braucht Pflege. Die Akkus altern und sind das Bauteil, das am häufigsten ausfällt.',
    points: [
      'Akkus nach etwa 3 bis 5 Jahren tauschen, bei Wärme früher',
      'Raumtemperatur um 20-25 °C halten: Hitze verkürzt die Lebensdauer',
      'regelmäßige Selbsttests und Überwachung per Software',
      'für lange Ausfälle: zusätzlich ein Notstromaggregat',
    ],
  ),
  formel(
    'n-hu-14',
    'h-usv',
    'Elektrische Leistung: P = U × I',
    'Die Leistung eines Geräts ergibt sich aus Spannung mal Stromstärke. Die Formel steht in der Prüfung meist dabei, umstellen musst du sie selbst. Auf dem Typenschild eines Netzteils stehen Spannung und Strom, etwa „20 V / 4,5 A“.',
    'P (W) = U (V) × I (A)\n'
        'I (A) = P (W) / U (V)\n'
        'U (V) = P (W) / I (A)\n'
        '1 A   = 1.000 mA',
    points: [
      'Netzspannung in Deutschland: 230 V',
      'Eine mit 16 A abgesicherte Steckdose liefert höchstens 230 V × 16 A = 3.680 W',
      'Netzteil 20 V / 4,5 A: P = 20 V × 4,5 A = 90 W',
    ],
    merksatz:
        'Gleiche Leistung bei kleinerer Spannung heißt größerer Strom: 12 W sind bei 24 V nur 0,5 A, bei 5 V aber 2,4 A.',
  ),
  beispiel(
    'n-hu-15',
    'h-usv',
    'Hält die Steckdosenleiste das aus?',
    'Auf einer Steckdosenleiste steht „max. 16 A / 230 V“. Angeschlossen werden sollen die Geräte aus der Tabelle. Ist das zulässig?',
    table: [
      ['Gerät', 'Anzahl', 'Leistung'],
      ['PC mit Monitor', '2', 'je 300 W'],
      ['Laserdrucker', '1', '1.100 W'],
      ['Heizlüfter', '1', '2.000 W'],
    ],
    schritte: [
      'Höchstleistung der Leiste: P = U × I = 230 V × 16 A = 3.680 W',
      'Summe der Geräte: 2 × 300 W + 1.100 W + 2.000 W = 3.700 W',
      'Strom der Geräte: I = P / U = 3.700 W / 230 V ≈ 16,09 A',
      'Vergleich: 16,09 A liegt über 16 A, die Leiste wäre überlastet',
    ],
    ergebnis:
        'nicht zulässig: 3.700 W bzw. 16,09 A überschreiten 3.680 W bzw. 16 A',
  ),
  falle(
    'n-hu-11',
    'h-usv',
    'Watt ist nicht VA',
    'Eine USV mit „1000 VA“ liefert bei einem Leistungsfaktor von 0,6 nur 600 Watt. Wer die Watt der Geräte direkt mit den VA der USV vergleicht, kauft ein zu kleines Gerät.',
  ),
  falle(
    'n-hu-12',
    'h-usv',
    'Laserdrucker gehören nicht an die USV',
    'Laserdrucker ziehen beim Aufheizen der Fixiereinheit kurzzeitig sehr viel Strom und können eine USV überlasten. Angeschlossen wird nur, was beim Ausfall weiterlaufen oder sauber herunterfahren muss.',
  ),
  merke(
    'n-hu-13',
    'h-usv',
    'Das Wichtigste zur USV',
    'Diese Punkte solltest du zur USV sicher beherrschen.',
    points: [
      'Offline (VFD) < Line-Interactive (VI) < Online (VFI)',
      'P = S × Leistungsfaktor, S = P / Leistungsfaktor',
      'Reserve einplanen, dann das nächstgrößere Modell wählen',
      'Zeit (h) = Wh × Wirkungsgrad / W',
    ],
    satz:
        'Addiere erst die Watt, schlag die Reserve auf und teile dann durch den Leistungsfaktor.',
  ),

  // ======================================================= Green IT und Ergonomie
  konzept(
    'n-ha-1',
    'h-arbeitsplatz',
    'Green IT',
    'Green IT verringert den Ressourcen- und Energieverbrauch der IT über den gesamten Lebenszyklus: Herstellung, Nutzung und Entsorgung.',
    points: [
      'energieeffiziente Geräte, z. B. mit Energieeffizienzlabel',
      'Stromsparmodi und automatisches Abschalten',
      'Server virtualisieren und konsolidieren',
      'Geräte lange nutzen und reparieren',
      'Altgeräte fachgerecht recyceln',
    ],
  ),
  vergleich(
    'n-ha-2',
    'h-arbeitsplatz',
    'Umwelt- und Effizienzsiegel',
    'Beim Einkauf helfen Siegel, energiesparende und umweltverträgliche Geräte zu erkennen.',
    [
      ['Siegel', 'steht für'],
      ['EU-Energielabel', 'Effizienzklasse A bis G, z. B. bei Monitoren'],
      ['Energy Star', 'geringer Stromverbrauch, auch im Standby'],
      ['Blauer Engel', 'sparsam, schadstoffarm, recyclinggerecht'],
      ['TCO Certified', 'Umwelt, Ergonomie und faire Herstellung'],
      ['80 PLUS', 'Wirkungsgrad von Netzteilen'],
    ],
  ),
  formel(
    'n-ha-3',
    'h-arbeitsplatz',
    'Energiekosten berechnen',
    'Leistung mal Zeit ergibt die verbrauchte Energie. Weil Strom pro Kilowattstunde abgerechnet wird, teilst du Wattstunden durch 1.000.',
    'Verbrauch (kWh) = Leistung (W) × Stunden / 1.000\n'
        'Kosten (€)      = Verbrauch (kWh) × Preis (€/kWh)',
  ),
  beispiel(
    'n-ha-4',
    'h-arbeitsplatz',
    'Stromkosten eines Arbeitsplatzes',
    'Ein PC braucht 60 W und läuft 8 Stunden an 220 Arbeitstagen. Strom kostet 0,30 € pro kWh. Wie hoch sind die jährlichen Stromkosten?',
    schritte: [
      'Betriebsstunden: 8 h × 220 = 1.760 h',
      'Energie: 60 W × 1.760 h = 105.600 Wh',
      'in kWh: 105.600 Wh / 1.000 = 105,6 kWh',
      'Kosten: 105,6 kWh × 0,30 €/kWh = 31,68 €',
    ],
    ergebnis: '31,68 € pro Jahr',
  ),
  beispiel(
    'n-ha-5',
    'h-arbeitsplatz',
    'Was das Laufenlassen über Nacht kostet',
    '25 PCs bleiben nach Feierabend an und brauchen im Leerlauf je 40 W, und zwar jeweils 16 Stunden an 250 Arbeitstagen. Strom kostet 0,32 € pro kWh. Wie viel kostet das im Jahr?',
    schritte: [
      'Stunden: 16 h × 250 = 4.000 h',
      'je PC: 40 W × 4.000 h = 160.000 Wh = 160 kWh',
      'alle PCs: 160 kWh × 25 = 4.000 kWh',
      'Kosten: 4.000 kWh × 0,32 €/kWh = 1.280 €',
    ],
    ergebnis: '1.280 € pro Jahr, allein für den Leerlauf',
  ),
  beispiel(
    'n-ha-6',
    'h-arbeitsplatz',
    'Lohnt sich ein sparsamer Monitor?',
    'Ein alter Monitor braucht 45 W, ein neuer 20 W. Er läuft 2.000 Stunden im Jahr, Strom kostet 0,30 € pro kWh, der neue Monitor 180 €. Nach wie vielen Jahren hat er sich allein über den Strom bezahlt gemacht?',
    schritte: [
      'Ersparnis: 45 W - 20 W = 25 W',
      'pro Jahr: 25 W × 2.000 h = 50.000 Wh = 50 kWh',
      'in Euro: 50 kWh × 0,30 €/kWh = 15 € pro Jahr',
      'Amortisation: 180 € / 15 € pro Jahr = 12 Jahre',
    ],
    ergebnis: '12 Jahre; allein wegen des Stroms lohnt der Tausch nicht',
    merksatz:
        'Green IT heißt auch: funktionierende Geräte lange nutzen. Die Herstellung verbraucht oft mehr Energie als Jahre des Betriebs.',
  ),
  konzept(
    'n-ha-7',
    'h-arbeitsplatz',
    'Rechtliche Grundlagen der Bildschirmarbeit',
    'Die Arbeitsstättenverordnung (ArbStättV) regelt in ihrem Anhang die Anforderungen an Bildschirmarbeitsplätze. Der Arbeitgeber muss die Gefährdungen beurteilen und die Arbeitsplätze danach einrichten, auch eingerichtete Telearbeitsplätze.',
    points: [
      'Arbeitsschutzgesetz: Gefährdungsbeurteilung ist Pflicht des Arbeitgebers',
      'Technische Regeln für Arbeitsstätten (ASR) nennen konkrete Werte, etwa für Licht und Temperatur',
      'Der Arbeitgeber muss eine Untersuchung der Augen anbieten; eine nötige Bildschirmbrille bezahlt er',
    ],
  ),
  vergleich(
    'n-ha-8',
    'h-arbeitsplatz',
    'Der ergonomische Bildschirmarbeitsplatz',
    'Diese Richtwerte aus Verordnung und Arbeitsstättenregeln solltest du kennen.',
    [
      ['Bereich', 'Empfehlung'],
      ['Monitor', 'Oberkante auf oder leicht unter Augenhöhe, leicht geneigt'],
      ['Sehabstand', 'ca. 50-70 cm, bei großen Monitoren mehr'],
      ['Aufstellung', 'Blick parallel zum Fenster, ohne Blendung'],
      ['Stuhl', 'höhenverstellbar, Füße flach, Knie etwa 90°'],
      ['Tisch, Tastatur', 'Unterarme waagerecht, Platz für die Handballen'],
      ['Beleuchtung', 'mindestens 500 Lux'],
      ['Raumtemperatur', 'mindestens 20 °C bei Büroarbeit'],
      ['Lärm', 'höchstens 55 dB(A) bei konzentrierter Arbeit'],
    ],
  ),
  konzept(
    'n-ha-9',
    'h-arbeitsplatz',
    'Pausen und Arbeitsorganisation',
    'Bildschirmarbeit soll regelmäßig durch Pausen oder andere Tätigkeiten unterbrochen werden. Kurze, häufige Pausen entlasten Augen und Rücken besser als eine lange.',
    points: [
      'Tätigkeitswechsel: Telefonate, Besprechungen oder Ablage zwischendurch',
      'Blick in die Ferne entspannt die Augen',
      'Software muss zur Aufgabe passen und darf nicht überfordern',
    ],
  ),
  konzept(
    'n-ha-10',
    'h-arbeitsplatz',
    'Altgeräte richtig entsorgen',
    'Elektrogeräte gehören nicht in den Restmüll. Nach dem Elektro- und Elektronikgerätegesetz (ElektroG) gehen sie über Rücknahmestellen oder zertifizierte Entsorger ins Recycling.',
    points: [
      'Vorher alle Datenträger sicher löschen oder physisch vernichten: Datenschutz!',
      'Die Vernichtung mit einem Nachweis dokumentieren lassen',
      'Noch brauchbare Geräte aufbereiten und weiterverwenden (Refurbishing)',
    ],
  ),
  falle(
    'n-ha-11',
    'h-arbeitsplatz',
    'Standby frisst Strom',
    'Geräte im Standby verbrauchen weiter Strom. Bei vielen Arbeitsplätzen und 24 Stunden am Tag summiert sich das. Schaltbare Steckdosenleisten oder zeitgesteuertes Abschalten sparen hier echtes Geld.',
  ),
  merke(
    'n-ha-12',
    'h-arbeitsplatz',
    'Das Wichtigste zu Green IT und Ergonomie',
    'Diese Formeln und Richtwerte solltest du sicher beherrschen.',
    points: [
      'kWh = W × h / 1.000, Kosten = kWh × Preis',
      'Siegel: Energielabel, Energy Star, Blauer Engel, TCO, 80 PLUS',
      'Monitor: Oberkante auf Augenhöhe, 50-70 cm, parallel zum Fenster',
      'Altgeräte: Daten löschen, dann fachgerecht recyceln',
    ],
    satz:
        'Die sparsamste Kilowattstunde ist die, die nicht verbraucht wird, und das umweltfreundlichste Gerät oft das, das weiter genutzt wird.',
  ),

  // ============================================= Aufgaben eines Betriebssystems
  skizze(
    'n-ba-1',
    'b-aufgaben',
    'Wo das Betriebssystem sitzt',
    'Das Betriebssystem liegt zwischen Hardware und Anwendungen. Programme sprechen die Hardware nie direkt an, sondern immer über das Betriebssystem.',
    const StapelDiagramm([
      StapelEbene('Benutzer'),
      StapelEbene('Anwendungen', 'Browser, Office, ERP-Client'),
      StapelEbene('Betriebssystem', 'Kernel, Treiber, Dienste'),
      StapelEbene('Hardware', 'CPU, RAM, Datenträger, Geräte'),
    ]),
  ),
  vergleich(
    'n-ba-2',
    'b-aufgaben',
    'Was ein Betriebssystem leistet',
    'Das Betriebssystem vermittelt zwischen Hardware und Anwendungen und verwaltet dafür alle Betriebsmittel.',
    [
      ['Aufgabe', 'Bedeutung'],
      ['Prozessverwaltung', 'verteilt Rechenzeit an laufende Programme'],
      [
        'Speicherverwaltung',
        'teilt den Arbeitsspeicher zu, lagert bei Bedarf aus',
      ],
      ['Dateiverwaltung', 'organisiert Dateien und Ordner im Dateisystem'],
      ['Geräteverwaltung', 'steuert Hardware über Treiber'],
      ['Benutzerverwaltung', 'Konten, Anmeldung und Rechte'],
      ['Benutzerschnittstelle', 'grafische Oberfläche oder Kommandozeile'],
    ],
  ),
  konzept(
    'n-ba-3',
    'b-aufgaben',
    'Kernel, Treiber und Benutzermodus',
    'Der Kernel ist der Kern des Betriebssystems und hat vollen Zugriff auf die Hardware (Kernelmodus). Anwendungen laufen im eingeschränkten Benutzermodus und fordern Dienste über Systemaufrufe an. Treiber übersetzen zwischen Kernel und einem bestimmten Gerät.',
    merksatz:
        'Stürzt eine Anwendung ab, bleibt das System stabil. Ein fehlerhafter Treiber im Kernel kann dagegen das ganze System anhalten.',
  ),
  vergleich(
    'n-ba-4',
    'b-aufgaben',
    'Prozess und Thread',
    'Beide Begriffe tauchen im Task-Manager auf. Ein Prozess kann mehrere Threads enthalten.',
    [
      ['', 'Prozess', 'Thread'],
      ['ist', 'ein laufendes Programm', 'ein Ausführungsstrang im Prozess'],
      [
        'Speicher',
        'eigener, geschützter Bereich',
        'teilt den Speicher des Prozesses',
      ],
      [
        'Absturz',
        'betrifft nur diesen Prozess',
        'kann den ganzen Prozess beenden',
      ],
      ['Beispiel', 'Textverarbeitung', 'Rechtschreibprüfung neben der Eingabe'],
    ],
  ),
  skizze(
    'n-ba-5',
    'b-aufgaben',
    'Prozesszustände',
    'Ein Prozess ist nicht ständig aktiv. Der Scheduler des Betriebssystems schaltet ihn zwischen Zuständen hin und her.',
    const FlussDiagramm([
      FlussKnoten('erzeugt', form: FlussForm.start),
      FlussKnoten('bereit', pfeil: 'Scheduler teilt CPU zu'),
      FlussKnoten('rechnend', seitlich: 'wartet auf E/A: blockiert'),
      FlussKnoten('beendet', form: FlussForm.ende),
    ]),
    points: [
      'bereit: wartet nur noch auf Rechenzeit',
      'rechnend: läuft gerade auf einem Kern; ist die Zeitscheibe abgelaufen, geht er zurück nach „bereit“',
      'blockiert: wartet auf Eingabe, Datenträger oder Netzwerk und wird danach wieder „bereit“',
    ],
  ),
  konzept(
    'n-ba-6',
    'b-aufgaben',
    'Multitasking und Scheduling',
    'Ein Kern führt zu jedem Zeitpunkt nur einen Thread aus. Das Betriebssystem teilt die Rechenzeit in kurze Zeitscheiben und wechselt so schnell, dass alles gleichzeitig zu laufen scheint. Mehrere Kerne ermöglichen echte Parallelität.',
    table: [
      ['Verfahren', 'Merkmal'],
      ['präemptiv', 'das Betriebssystem entzieht die CPU; heute Standard'],
      [
        'kooperativ',
        'das Programm gibt die CPU freiwillig ab; ein hängendes Programm blockiert alles',
      ],
    ],
  ),
  konzept(
    'n-ba-7',
    'b-aufgaben',
    'Virtueller Speicher',
    'Jeder Prozess bekommt einen eigenen virtuellen Adressraum, den das Betriebssystem auf den echten Arbeitsspeicher abbildet. So können sich Programme nicht gegenseitig überschreiben.',
    points: [
      'Paging: Der Speicher wird in Seiten fester Größe verwaltet, oft 4 KiB',
      'Reicht der RAM nicht, werden Seiten ausgelagert: unter Windows in die Auslagerungsdatei (pagefile.sys), unter Linux in den Swap',
      'Häufiges Auslagern bremst stark, dann hilft mehr RAM',
    ],
  ),
  vergleich(
    'n-ba-8',
    'b-aufgaben',
    'Betriebssysteme nach Einsatz',
    'Betriebssysteme sind auf ihren Einsatzzweck zugeschnitten.',
    [
      ['Einsatz', 'Beispiele', 'Merkmal'],
      ['Desktop', 'Windows 11, macOS, Ubuntu', 'grafische Oberfläche'],
      ['Server', 'Windows Server, Linux', 'Dienste, oft ohne GUI'],
      ['Mobil', 'Android, iOS', 'Touch, App-Stores'],
      ['Embedded', 'Router, Maschinen, Autos', 'klein, oft Echtzeit'],
    ],
  ),
  vergleich(
    'n-ba-9',
    'b-aufgaben',
    'Client- und Server-Betriebssystem',
    'Server-Betriebssysteme stellen Dienste für viele Clients bereit und sind darauf ausgelegt, dauerhaft zu laufen.',
    [
      ['', 'Client', 'Server'],
      ['Zweck', 'Arbeitsplatz einer Person', 'Dienste für viele'],
      ['Rollen', 'Office, Browser', 'Verzeichnis, DNS, DHCP, Dateien, Web'],
      ['Hardware', 'ein Nutzer', 'viel RAM, mehrere CPUs'],
      ['Lizenz (Windows)', 'pro Gerät', 'pro Kern plus Zugriffslizenzen (CAL)'],
    ],
  ),
  beispiel(
    'n-ba-10',
    'b-aufgaben',
    '32 oder 64 Bit?',
    'Wie viel Arbeitsspeicher kann ein 32-Bit-Betriebssystem höchstens adressieren, und warum braucht ein Rechner mit 16 GB RAM ein 64-Bit-System?',
    schritte: [
      '32-Bit-Adressen: 2³² verschiedene Adressen, je Adresse 1 Byte',
      '2³² Byte = 4.294.967.296 Byte',
      'in GiB: 4.294.967.296 / 1.024³ = 4 GiB',
      '64 Bit: 2⁶⁴ Byte = 16 EiB, weit mehr, als ein heutiger Rechner hat',
    ],
    ergebnis: '32 Bit: höchstens 4 GiB; für 16 GB braucht es 64 Bit',
  ),
  falle(
    'n-ba-11',
    'b-aufgaben',
    'Treiber aus unsicheren Quellen',
    'Treiber laufen mit Kernelrechten. Ein fehlerhafter oder manipulierter Treiber kann das System lahmlegen oder Schadcode mit höchsten Rechten ausführen. Deshalb nur signierte Treiber vom Hersteller oder über die Updatefunktion des Betriebssystems installieren.',
  ),
  merke(
    'n-ba-12',
    'b-aufgaben',
    'Das Wichtigste zum Betriebssystem',
    'Diese Punkte solltest du zu den Aufgaben eines Betriebssystems sicher beherrschen.',
    points: [
      'Aufgaben: Prozesse, Speicher, Dateien, Geräte, Benutzer, Oberfläche',
      'Kernelmodus: voller Hardwarezugriff, Benutzermodus: eingeschränkt',
      'Prozess: eigener Speicher, Thread: teilt ihn',
      'Zustände: bereit, rechnend, blockiert',
      '32 Bit: höchstens 4 GiB adressierbar',
    ],
    satz:
        'Das Betriebssystem ist der Vermittler: Anwendungen fragen, das Betriebssystem entscheidet und spricht mit der Hardware.',
  ),

  // ============================================================== Dateisysteme
  konzept(
    'n-bd-1',
    'b-dateisysteme',
    'Wozu ein Dateisystem?',
    'Ein Datenträger kennt nur nummerierte Blöcke. Erst das Dateisystem macht daraus Dateien und Ordner: Es merkt sich, welche Blöcke zu welcher Datei gehören, wie sie heißt, wer sie lesen darf und wann sie geändert wurde.',
    points: [
      'Cluster (Zuordnungseinheit): kleinste Einheit, die eine Datei belegen kann, oft 4 KiB',
      'Metadaten: Name, Größe, Zeitstempel, Besitzer, Rechte',
      'Verzeichnisstruktur: Ordner als Baum',
    ],
  ),
  skizze(
    'n-bd-2',
    'b-dateisysteme',
    'Der Verzeichnisbaum unter Linux',
    'Linux kennt keine Laufwerksbuchstaben. Alles hängt in einem einzigen Baum ab der Wurzel „/“, auch weitere Datenträger, die an einer Stelle eingehängt (gemountet) werden.',
    const BaumDiagramm(
      BaumKnoten('/', [
        BaumKnoten('bin', [], 'Programme'),
        BaumKnoten('etc', [], 'Konfiguration'),
        BaumKnoten('home', [BaumKnoten('anna', [], 'Nutzerdaten')]),
        BaumKnoten('var', [BaumKnoten('log', [], 'Protokolle')]),
        BaumKnoten('mnt', [BaumKnoten('usb', [], 'eingehängter Stick')]),
      ], 'Wurzel'),
    ),
  ),
  vergleich(
    'n-bd-3',
    'b-dateisysteme',
    'Pfade unter Windows und Linux',
    'Die beiden Welten schreiben Pfade unterschiedlich.',
    [
      ['', 'Windows', 'Linux'],
      ['Wurzel', 'je Laufwerk: C:\\, D:\\', 'ein Baum: /'],
      ['Trennzeichen', 'Backslash \\', 'Slash /'],
      ['Groß/klein', 'egal', 'wird unterschieden'],
      ['Nutzerordner', 'C:\\Users\\anna', '/home/anna'],
    ],
  ),
  konzept(
    'n-bd-4',
    'b-dateisysteme',
    'Absolute und relative Pfade',
    'Ein absoluter Pfad beginnt an der Wurzel und gilt überall. Ein relativer Pfad geht vom aktuellen Verzeichnis aus. „.“ steht für das aktuelle, „..“ für das übergeordnete Verzeichnis.',
    code:
        'aktuell:  /home/anna\n'
        'absolut:  /home/anna/berichte/q1.txt\n'
        'relativ:  berichte/q1.txt\n'
        'höher:    ../ben/notizen.txt\n'
        '       =  /home/ben/notizen.txt',
  ),
  vergleich(
    'n-bd-5',
    'b-dateisysteme',
    'Dateisysteme im Vergleich',
    'Das Dateisystem legt fest, wie Daten organisiert werden und welche Grenzen gelten.',
    [
      ['Dateisystem', 'Einsatz', 'größte Datei'],
      ['FAT32', 'ältere Sticks, Kameras', '4 GiB - 1 Byte'],
      ['exFAT', 'USB-Sticks, SD-Karten', 'praktisch unbegrenzt'],
      ['NTFS', 'Windows', '16 TiB und mehr'],
      ['ext4', 'Linux', '16 TiB'],
      ['APFS', 'macOS, iOS', 'praktisch unbegrenzt'],
    ],
  ),
  vergleich(
    'n-bd-6',
    'b-dateisysteme',
    'Funktionen und Kompatibilität',
    'Ob ein Dateisystem Rechte kennt und welches Betriebssystem es ohne Zusatzsoftware beschreiben kann, entscheidet oft die Wahl.',
    [
      ['Dateisystem', 'Rechte, Journal', 'Windows · macOS · Linux'],
      ['FAT32', 'nein', 'ja · ja · ja'],
      ['exFAT', 'nein', 'ja · ja · ja'],
      ['NTFS', 'ja', 'ja · nur lesen · ja'],
      ['ext4', 'ja', 'nein · nein · ja'],
    ],
    points: [
      'macOS schreibt ohne Zusatzsoftware nicht auf NTFS, Windows liest kein ext4',
      'Für Wechseldatenträger zwischen allen Systemen ist exFAT die richtige Wahl',
    ],
  ),
  konzept(
    'n-bd-7',
    'b-dateisysteme',
    'Journaling',
    'Ein Journaling-Dateisystem protokolliert geplante Änderungen, bevor es sie ausführt. Stürzt der Rechner mitten im Schreiben ab, lässt sich das Dateisystem anhand des Journals schnell in einen konsistenten Zustand bringen. NTFS und ext4 arbeiten so, FAT32 und exFAT nicht.',
  ),
  vergleich(
    'n-bd-8',
    'b-dateisysteme',
    'MBR oder GPT?',
    'Vor dem Dateisystem kommt die Partitionstabelle. Sie teilt den Datenträger in Bereiche (Partitionen).',
    [
      ['', 'MBR', 'GPT'],
      ['max. Größe', '2 TiB', 'praktisch unbegrenzt'],
      ['Partitionen', '4 primäre', 'unter Windows bis zu 128'],
      ['Firmware', 'BIOS', 'UEFI'],
      ['Sicherung', 'keine Kopie', 'Kopie am Ende des Datenträgers'],
    ],
  ),
  beispiel(
    'n-bd-9',
    'b-dateisysteme',
    'Größe auf dem Datenträger',
    'Eine Textdatei ist 10.000 Byte groß, die Clustergröße beträgt 4 KiB. Wie viel Platz belegt sie tatsächlich?',
    schritte: [
      'Clustergröße: 4 KiB = 4.096 Byte',
      'benötigte Cluster: 10.000 / 4.096 ≈ 2,44; angefangene Cluster zählen voll, also 3',
      'belegt: 3 × 4.096 Byte = 12.288 Byte',
      'Verschnitt: 12.288 Byte - 10.000 Byte = 2.288 Byte',
    ],
    ergebnis: '12.288 Byte belegt, davon 2.288 Byte ungenutzt',
    merksatz:
        'Darum zeigt Windows bei Dateien „Größe“ und „Größe auf Datenträger“ getrennt an.',
  ),
  ablauf(
    'n-bd-10',
    'b-dateisysteme',
    'Einen Datenträger einrichten',
    'Bevor ein neuer Datenträger Dateien aufnehmen kann, sind mehrere Schritte nötig.',
    [
      'Partitionieren: Partitionstabelle (GPT) anlegen und Bereiche festlegen. Windows: Datenträgerverwaltung oder diskpart, Linux: fdisk oder parted',
      'Formatieren: Dateisystem anlegen. Windows: format, Linux: mkfs.ext4',
      'Einbinden: Laufwerksbuchstaben zuweisen (Windows) oder an einem Verzeichnis einhängen (Linux: mount, dauerhaft über /etc/fstab)',
      'Rechte setzen: festlegen, wer lesen und schreiben darf',
    ],
  ),
  falle(
    'n-bd-11',
    'b-dateisysteme',
    'Formatieren ist nicht löschen',
    'Eine Schnellformatierung legt nur ein neues, leeres Inhaltsverzeichnis an. Die alten Daten liegen weiter auf dem Datenträger und lassen sich mit Werkzeugen wiederherstellen. Vor der Weitergabe oder Entsorgung überschreibst du ihn deshalb sicher, bei SSDs per Secure Erase, oder du vernichtest den Datenträger.',
  ),
  falle(
    'n-bd-12',
    'b-dateisysteme',
    'Die 4-GB-Grenze',
    'Auf einen FAT32-Stick passt keine einzelne Datei über 4 GiB, egal wie viel Platz frei ist. Wer ein großes Image oder Video kopieren will, formatiert den Stick mit exFAT oder NTFS.',
  ),
  merke(
    'n-bd-13',
    'b-dateisysteme',
    'Das Wichtigste zu Dateisystemen',
    'Diese Punkte solltest du zu Dateisystemen sicher beherrschen.',
    points: [
      'Linux: ein Baum ab /, Windows: Laufwerksbuchstaben',
      'FAT32: höchstens 4 GiB pro Datei, keine Rechte',
      'exFAT: Wechseldatenträger mit großen Dateien',
      'NTFS (Windows) und ext4 (Linux): Rechte und Journaling',
      'GPT mit UEFI für große Datenträger, MBR höchstens 2 TiB',
    ],
    satz:
        'Erst partitionieren, dann formatieren und einbinden, und für jeden Zweck wählst du das passende Dateisystem.',
  ),

  // ======================================================== Benutzer und Rechte
  konzept(
    'n-br-1',
    'b-rechte',
    'Anmelden und Berechtigen',
    'Zugriffsschutz läuft in zwei Schritten: Die Authentifizierung prüft, wer du bist, etwa per Passwort und zweitem Faktor. Die Autorisierung legt fest, was du danach darfst.',
    table: [
      ['Konto', 'Merkmal'],
      ['lokales Konto', 'gilt nur auf einem Rechner'],
      ['Domänenkonto', 'zentral verwaltet, z. B. im Active Directory'],
      ['Dienstkonto', 'für Dienste und Programme, nicht für Menschen'],
      ['Administrator / root', 'volle Rechte, nur für die Verwaltung'],
    ],
  ),
  konzept(
    'n-br-2',
    'b-rechte',
    'Das Minimalprinzip',
    'Jeder Benutzer erhält nur die Rechte, die er für seine Aufgabe braucht, nicht mehr (Least Privilege). Rechte werden an Gruppen vergeben, nicht an einzelne Personen: Wechselt jemand die Abteilung, wechselt er nur die Gruppe.',
  ),
  skizze(
    'n-br-3',
    'b-rechte',
    'Rechte über Gruppen vergeben',
    'Die Rechte hängen an der Gruppe, Personen werden Mitglied. So bleibt nachvollziehbar, wer warum Zugriff hat.',
    const FlussDiagramm([
      FlussKnoten('Benutzerin Anna', pfeil: 'ist Mitglied von'),
      FlussKnoten('Gruppe Buchhaltung', pfeil: 'hat Berechtigung'),
      FlussKnoten('Ändern', pfeil: 'auf'),
      FlussKnoten('Ordner Rechnungen', form: FlussForm.dokument),
    ]),
    points: [
      'Wechselt Anna die Abteilung, wird nur ihre Gruppenmitgliedschaft geändert',
      'Verlässt sie das Unternehmen, wird ihr Konto sofort gesperrt',
    ],
  ),
  formel(
    'n-br-4',
    'b-rechte',
    'Linux-Rechte lesen',
    'Unter Linux gibt es drei Rechte für drei Benutzerklassen: Besitzer, Gruppe und alle anderen. Jedes Recht hat einen Zahlenwert.',
    'r = lesen      = 4\n'
        'w = schreiben  = 2\n'
        'x = ausführen  = 1\n'
        '\n'
        'Besitzer  Gruppe  andere\n'
        '  rwx      r-x     r--\n'
        '   7        5       4',
    merksatz:
        'Pro Benutzerklasse werden die Werte addiert: 7 = 4 + 2 + 1, 5 = 4 + 1, 4 = nur lesen, 0 = keine Rechte.',
  ),
  skizze(
    'n-br-5',
    'b-rechte',
    'Oktal ist binär in Dreiergruppen',
    'Jede Oktalziffer steht für drei Bit, genau die drei Rechte r, w und x. Eine 1 heißt: Recht gesetzt.',
    const BitDiagramm([
      BitZeile('754 (rwxr-xr--)', '111 101 100'),
      BitZeile('640 (rw-r-----)', '110 100 000'),
    ], legende: 'Jede Dreiergruppe: r (4), w (2), x (1)'),
  ),
  vergleich(
    'n-br-6',
    'b-rechte',
    'r, w, x bei Dateien und Verzeichnissen',
    'Dieselben drei Buchstaben bedeuten bei Verzeichnissen etwas anderes als bei Dateien.',
    [
      ['Recht', 'bei einer Datei', 'bei einem Verzeichnis'],
      ['r', 'Inhalt lesen', 'Inhalt auflisten'],
      ['w', 'Inhalt ändern', 'Dateien anlegen, löschen, umbenennen'],
      ['x', 'als Programm ausführen', 'hineinwechseln (cd)'],
    ],
  ),
  beispiel(
    'n-br-7',
    'b-rechte',
    'chmod 754 aufschlüsseln',
    'Ein Skript bekommt mit chmod 754 neue Rechte. Welche Rechte haben Besitzer, Gruppe und andere?',
    schritte: [
      '7 = 4 + 2 + 1 -> rwx: der Besitzer liest, schreibt und führt aus',
      '5 = 4 + 1 -> r-x: die Gruppe liest und führt aus',
      '4 = 4 -> r--: alle anderen dürfen nur lesen',
    ],
    ergebnis: 'rwxr-xr--',
  ),
  beispiel(
    'n-br-8',
    'b-rechte',
    'Eine ls-Ausgabe deuten',
    'Die Ausgabe von ls -l zeigt die folgende Zeile. Wer darf was, und welcher chmod-Wert passt?',
    code: '-rwxr-x--- 1 anna buchhaltung 2048 bericht.sh',
    schritte: [
      'Erstes Zeichen „-“: eine normale Datei (d stünde für ein Verzeichnis)',
      'Besitzerin anna: rwx = 4 + 2 + 1 = 7',
      'Gruppe buchhaltung: r-x = 4 + 0 + 1 = 5',
      'alle anderen: --- = 0',
    ],
    ergebnis:
        'chmod 750: Anna alles, Buchhaltung lesen und ausführen, andere nichts',
  ),
  konzept(
    'n-br-9',
    'b-rechte',
    'Rechte und Besitzer ändern',
    'Neben der Zahlenschreibweise kennt chmod eine symbolische Schreibweise. Den Besitzer und die Gruppe ändert chown.',
    code:
        'chmod 640 liste.txt     # rw-r-----\n'
        'chmod u+x skript.sh     # Besitzer: + ausführen\n'
        'chmod g-w,o=r plan.txt  # Gruppe - schreiben, andere nur lesen\n'
        'chown anna:vertrieb plan.txt',
    points: [
      'u = Besitzer (user), g = Gruppe, o = andere (others), a = alle',
      '+ fügt ein Recht hinzu, - entfernt es, = setzt genau diese Rechte',
    ],
  ),
  vergleich(
    'n-br-10',
    'b-rechte',
    'NTFS-Berechtigungen',
    'Windows kennt abgestufte Standardberechtigungen, die aufeinander aufbauen.',
    [
      ['Berechtigung', 'erlaubt'],
      ['Lesen', 'Dateien öffnen und anzeigen'],
      ['Schreiben', 'Dateien anlegen, Inhalt ändern'],
      ['Lesen, Ausführen', 'zusätzlich Programme starten'],
      ['Ändern', 'lesen, schreiben und löschen'],
      ['Vollzugriff', 'zusätzlich Rechte ändern, Besitz übernehmen'],
    ],
    points: [
      'Rechte werden vom übergeordneten Ordner übernommen, solange man das nicht abschaltet',
      'Ein ausdrückliches „Verweigern“ hat Vorrang vor „Zulassen“',
    ],
  ),
  beispiel(
    'n-br-11',
    'b-rechte',
    'Freigabe- und NTFS-Rechte kombinieren',
    'Der Ordner „Projekte“ ist mit der Freigabeberechtigung „Ändern“ freigegeben. Die Gruppe Vertrieb hat die NTFS-Berechtigung „Lesen“. Welche Rechte hat ein Vertriebsmitarbeiter über das Netzwerk und direkt am Server?',
    schritte: [
      'Über das Netzwerk gelten beide Ebenen: Freigabe „Ändern“ und NTFS „Lesen“',
      'Wirksam ist die strengere von beiden: Lesen',
      'Direkt am Server (lokal) gilt nur NTFS: ebenfalls Lesen',
    ],
    ergebnis: 'über das Netzwerk: Lesen, lokal: Lesen',
    merksatz:
        'In der Praxis setzt man die Freigabe meist großzügig und steuert den Zugriff eigentlich über die NTFS-Rechte.',
  ),
  falle(
    'n-br-12',
    'b-rechte',
    'Sammelkonten und Rechte-Wildwuchs',
    'Geteilte Konten wie „azubi“ oder „lager“ machen Handlungen nicht mehr einer Person zuordenbar. Und wer Rechte direkt an Personen vergibt und beim Abteilungswechsel nie entzieht, sammelt über Jahre immer mehr Zugriff an. Regelmäßige Rechteprüfungen decken das auf.',
  ),
  konzept(
    'n-br-13',
    'b-rechte',
    'Admin nur zum Administrieren',
    'Auch Administratoren arbeiten im Alltag mit einem normalen Konto und wechseln nur für Verwaltungsaufgaben die Rechte: unter Linux mit sudo, unter Windows über die Benutzerkontensteuerung (UAC). So richtet Schadsoftware im Alltagskonto weniger Schaden an.',
  ),
  merke(
    'n-br-14',
    'b-rechte',
    'Das Wichtigste zu Benutzern und Rechten',
    'Diese Punkte solltest du zu Benutzern und Rechten sicher beherrschen.',
    points: [
      'Authentifizierung: wer? Autorisierung: was?',
      'Rechte an Gruppen, nicht an Personen und nach dem Minimalprinzip',
      'Linux: r = 4, w = 2, x = 1, je für Besitzer, Gruppe, andere',
      'Netzwerkzugriff: die strengere aus Freigabe und NTFS gilt',
      'Verweigern schlägt Zulassen',
    ],
    satz:
        'Vergib so wenig Rechte wie möglich und so viele wie nötig, und zwar immer über Gruppen.',
  ),

  // ============================================================== Kommandozeile
  konzept(
    'n-bc-1',
    'b-cli',
    'Warum Kommandozeile?',
    'Viele Server haben keine grafische Oberfläche, und Wiederkehrendes lässt sich mit Befehlen automatisieren. Wer die Kommandozeile beherrscht, arbeitet schneller und findet Fehler auch per Fernzugriff.',
    table: [
      ['Shell', 'System', 'Merkmal'],
      ['cmd', 'Windows', 'klassische Eingabeaufforderung'],
      ['PowerShell', 'Windows, auch Linux', 'Cmdlets, arbeitet mit Objekten'],
      ['bash / zsh', 'Linux, macOS', 'Standard-Shells, Skripte'],
    ],
  ),
  vergleich(
    'n-bc-2',
    'b-cli',
    'Dateien und Ordner',
    'Hier siehst du die wichtigsten Befehle für die tägliche Arbeit im Vergleich.',
    [
      ['Aufgabe', 'Windows (cmd)', 'Linux'],
      ['Inhalt anzeigen', 'dir', 'ls'],
      ['Ordner wechseln', 'cd', 'cd'],
      ['aktueller Ordner', 'cd (ohne Ziel)', 'pwd'],
      ['Kopieren', 'copy', 'cp'],
      ['Verschieben', 'move', 'mv'],
      ['Löschen', 'del', 'rm'],
      ['Ordner anlegen', 'mkdir', 'mkdir'],
      ['Datei ausgeben', 'type', 'cat'],
      ['Text suchen', 'findstr', 'grep'],
      ['Hilfe', 'befehl /?', 'man befehl'],
    ],
  ),
  vergleich(
    'n-bc-3',
    'b-cli',
    'Netzwerk-Diagnose',
    'Mit diesen Befehlen findest du die meisten Netzwerkfehler.',
    [
      ['Aufgabe', 'Windows', 'Linux'],
      ['IP-Konfiguration', 'ipconfig', 'ip a'],
      ['Erreichbarkeit', 'ping', 'ping'],
      ['Weg der Pakete', 'tracert', 'traceroute'],
      ['Namen auflösen', 'nslookup', 'nslookup, dig'],
      ['Verbindungen, Ports', 'netstat', 'ss, netstat'],
      ['ARP-Tabelle', 'arp -a', 'ip neigh'],
      ['Routingtabelle', 'route print', 'ip route'],
    ],
  ),
  vergleich(
    'n-bc-4',
    'b-cli',
    'Wichtige Windows-Befehle',
    'Diese Befehle der Windows-Eingabeaufforderung helfen im Support-Alltag.',
    [
      ['Befehl', 'Zweck'],
      ['ipconfig /all', 'volle IP-Konfiguration mit MAC, DHCP, DNS'],
      ['ipconfig /release, /renew', 'DHCP-Adresse abgeben und neu anfordern'],
      ['ipconfig /flushdns', 'DNS-Zwischenspeicher leeren'],
      ['ping -t', 'Dauerping bis Strg + C'],
      ['netstat -an', 'alle Verbindungen und offenen Ports'],
      ['gpupdate /force', 'Gruppenrichtlinien neu anwenden'],
      ['tasklist, taskkill', 'Prozesse anzeigen, beenden'],
      ['shutdown /r /t 0', 'sofort neu starten'],
    ],
  ),
  vergleich(
    'n-bc-5',
    'b-cli',
    'Wichtige Linux-Befehle',
    'Diese Befehle brauchst du im Serverbetrieb immer wieder.',
    [
      ['Befehl', 'Zweck'],
      ['ls -la', 'alle Dateien mit Rechten anzeigen'],
      ['grep', 'Text in Dateien suchen'],
      ['chmod, chown', 'Rechte bzw. Besitzer ändern'],
      ['sudo', 'Befehl mit Administratorrechten'],
      ['ps, top', 'laufende Prozesse anzeigen'],
      ['kill', 'Prozess beenden'],
      ['df -h, du -sh', 'freier Platz, Größe eines Ordners'],
      ['apt update', 'Paketlisten aktualisieren (Debian, Ubuntu)'],
      ['man', 'Hilfe zu einem Befehl'],
    ],
  ),
  konzept(
    'n-bc-6',
    'b-cli',
    'Ausgaben umleiten und verketten',
    'Befehle lassen sich kombinieren. Die Zeichen dafür funktionieren unter Windows und Linux gleich.',
    code:
        'ls -l | grep txt         # Ausgabe an grep weiterreichen\n'
        'dir > liste.txt          # in Datei schreiben (überschreibt)\n'
        'echo Fehler >> log.txt   # an Datei anhängen\n'
        'ping 10.0.0.1 && echo OK # zweiter Befehl nur bei Erfolg',
    points: [
      '| (Pipe): Die Ausgabe des ersten Befehls wird zur Eingabe des zweiten',
      '> überschreibt eine Datei, >> hängt an',
    ],
  ),
  konzept(
    'n-bc-7',
    'b-cli',
    'PowerShell',
    'PowerShell-Befehle heißen Cmdlets und folgen dem Muster Verb-Nomen. Sie geben Objekte statt Text zurück, die sich gezielt filtern und sortieren lassen.',
    code:
        'Get-ChildItem C:\\Daten         # wie dir\n'
        'Get-Process | Sort-Object CPU   # Prozesse sortiert\n'
        'Test-NetConnection srv01 -Port 443\n'
        'Get-NetIPConfiguration          # wie ipconfig',
  ),
  beispiel(
    'n-bc-8',
    'b-cli',
    'Eine ipconfig-Ausgabe deuten',
    'Ein Nutzer meldet „kein Netz“. ipconfig zeigt die folgende Ausgabe. Was ist die Ursache, und was tust du?',
    code:
        'Ethernet-Adapter Ethernet:\n'
        '   IPv4-Adresse . . : 169.254.23.7\n'
        '   Subnetzmaske . . : 255.255.0.0\n'
        '   Standardgateway  :',
    schritte: [
      '169.254.x.x ist eine APIPA-Adresse: Der Rechner hat sich selbst eine Adresse gegeben',
      'Das passiert, wenn kein DHCP-Server antwortet. Deshalb fehlt auch das Gateway',
      'Prüfen: Kabel und Link-LED, Switchport bzw. VLAN, läuft der DHCP-Server?',
      'Danach mit ipconfig /release und ipconfig /renew eine Adresse neu anfordern',
    ],
    ergebnis: 'DHCP-Problem: Der Rechner hat keine Adresse vom Server erhalten',
  ),
  skizze(
    'n-bc-9',
    'b-cli',
    'Netzwerkfehler von innen nach außen',
    'Geprüft wird Schritt für Schritt vom eigenen Rechner nach außen. Der erste Fehlschlag zeigt, wo das Problem liegt.',
    const FlussDiagramm([
      FlussKnoten(
        'ping 127.0.0.1 ok?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] TCP/IP-Stack',
      ),
      FlussKnoten(
        'gültige IP (ipconfig)?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] DHCP, Kabel',
      ),
      FlussKnoten(
        'ping Gateway ok?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] lokales Netz',
      ),
      FlussKnoten(
        'ping 8.8.8.8 ok?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] Routing, Provider',
      ),
      FlussKnoten(
        'nslookup ok?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] DNS-Problem',
      ),
      FlussKnoten('Netzwerk in Ordnung', form: FlussForm.ende),
    ]),
  ),
  beispiel(
    'n-bc-14',
    'b-cli',
    'Eine Ping-Ausgabe lesen',
    'Das Bild einer Netzwerkkamera ruckelt. Ein ping auf die Kamera im eigenen LAN liefert die folgende Ausgabe. Welche Werte sind auffällig, und was folgt daraus?',
    code:
        'ping 192.168.10.50\n'
        'Antwort: Zeit=3ms TTL=64\n'
        'Zeitüberschreitung der Anforderung.\n'
        'Antwort: Zeit=480ms TTL=64\n'
        'Antwort: Zeit=5ms TTL=64\n'
        'Gesendet = 4, Empfangen = 3,\n'
        'Verloren = 1 (25% Verlust)\n'
        'Minimum = 3ms, Maximum = 480ms,\n'
        'Mittelwert = 162ms',
    schritte: [
      'Paketverlust: 1 von 4 Anfragen blieb unbeantwortet, also 25 % statt 0 %',
      'Antwortzeit: Im LAN sind wenige Millisekunden normal, 480 ms ist ein Ausreißer',
      'Mittelwert: (3 + 480 + 5) / 3 ≈ 162 ms; gemittelt wird nur über die Antworten',
      'Folgen: ruckelndes oder einfrierendes Bild, Zeitüberschreitungen, Verbindungsabbrüche',
      'Mögliche Ursachen: defektes Kabel oder Stecker, schwaches WLAN, überlastete Leitung',
    ],
    ergebnis:
        'auffällig sind 25 % Verlust und 480 ms Maximum, die Verbindung zur Kamera ist gestört',
  ),
  vergleich(
    'n-bc-15',
    'b-cli',
    'Kennwerte einer Ping-Ausgabe',
    'ping schickt kleine Testpakete (ICMP) an ein Ziel und misst, ob und wie schnell die Antwort zurückkommt. Diese Werte liest du aus der Ausgabe.',
    [
      ['Wert', 'Bedeutung', 'auffällig, wenn'],
      ['Zeit (Latenz)', 'Laufzeit hin und zurück', 'im LAN mehr als wenige ms'],
      ['Verlust', 'Anteil ohne Antwort', 'größer als 0 %'],
      [
        'Zeitüberschreitung',
        'keine Antwort in der Wartezeit',
        'sie überhaupt auftritt',
      ],
      ['Min / Max', 'kleinste und größte Zeit', 'beide weit auseinanderliegen'],
      ['TTL', 'restliche Router-Sprünge', '- (sinkt je Router um 1)'],
    ],
    points: [
      'Stark schwankende Zeiten (Jitter) stören vor allem Sprache und Video',
      'Hohe Latenz und Paketverlust führen zu Ruckeln, Wartezeiten und abgebrochenen Verbindungen',
    ],
  ),
  falle(
    'n-bc-10',
    'b-cli',
    'Ping heißt nicht Internet',
    'Wenn ping auf 8.8.8.8 klappt, aber nicht auf google.de, funktioniert das Netzwerk; nur die Namensauflösung ist gestört. Wer hier den Router neu startet, sucht an der falschen Stelle.',
  ),
  falle(
    'n-bc-11',
    'b-cli',
    'Kein Ping heißt nicht offline',
    'Viele Firewalls blockieren ICMP, das Protokoll hinter ping. Antwortet ein Server nicht auf ping, kann er trotzdem laufen. Dann prüfst du den Dienst direkt, etwa mit Test-NetConnection und der Portnummer.',
  ),
  konzept(
    'n-bc-12',
    'b-cli',
    'Ein kleines Skript lesen',
    'Wiederkehrende Aufgaben werden in Skripte geschrieben. Solche Zeilen musst du lesen und erklären können.',
    code: r'''
#!/bin/bash
# Projektordner mit Datum im Namen sichern
ZIEL=/backup/projekt_$(date +%F).tar.gz
tar -czf "$ZIEL" /home/anna/projekt
echo "Gesichert nach $ZIEL"''',
    points: [
      '#!/bin/bash legt fest, welche Shell das Skript ausführt',
      r'$(date +%F) setzt das Datum ein, z. B. 2026-09-30',
      'tar -czf packt den Ordner komprimiert in ein Archiv',
      'Automatisch ausführen: unter Linux per cron, unter Windows mit der Aufgabenplanung',
    ],
  ),
  merke(
    'n-bc-13',
    'b-cli',
    'Das Wichtigste zur Kommandozeile',
    'Diese Befehle und Regeln solltest du sicher beherrschen.',
    points: [
      'dir/ls, copy/cp, move/mv, del/rm, type/cat',
      'ipconfig / ip a, tracert / traceroute, nslookup',
      'Diagnose von innen nach außen: 127.0.0.1, IP, Gateway, extern, DNS',
      '| verkettet, > überschreibt, >> hängt an',
    ],
    satz: 'IP-Adresse erreichbar, Name nicht? Dann liegt es am DNS.',
  ),

  // ========================================================= Updates und Härtung
  konzept(
    'n-bh-1',
    'b-haertung',
    'Was Härtung bedeutet',
    'Härtung macht ein System widerstandsfähiger, indem die Angriffsfläche verkleinert wird: Was nicht vorhanden ist, kann nicht angegriffen werden.',
    points: [
      'nicht benötigte Dienste und Programme entfernen',
      'Standardpasswörter und Standardkonten ändern oder deaktivieren',
      'Updates zeitnah einspielen',
      'Firewall aktivieren, nur nötige Ports öffnen',
      'Administratorrechte einschränken',
      'Datenträger verschlüsseln, z. B. mit BitLocker oder LUKS',
    ],
  ),
  vergleich(
    'n-bh-2',
    'b-haertung',
    'Härtung auf allen Ebenen',
    'Härtung ist kein einzelner Schalter. Sie setzt überall an, wo ein Angreifer ansetzen könnte.',
    [
      ['Ebene', 'Maßnahmen'],
      ['Konten', 'Standardpasswörter ändern, Gastkonto aus, MFA'],
      ['Dienste', 'Unnötiges deinstallieren, Ports schließen'],
      ['System', 'Updates, Secure Boot, Verschlüsselung'],
      ['Netz', 'Hostfirewall, sichere Protokolle wie SSH statt Telnet'],
      ['Überwachung', 'Protokollierung, Virenschutz, Alarme'],
    ],
  ),
  vergleich(
    'n-bh-3',
    'b-haertung',
    'Arten von Updates',
    'Nicht jedes Update hat dieselbe Dringlichkeit.',
    [
      ['Art', 'Inhalt'],
      ['Sicherheitsupdate (Patch)', 'schließt eine Schwachstelle'],
      ['Hotfix', 'dringende Einzelkorrektur'],
      ['Funktionsupdate', 'neue Funktionen, neue Version'],
      ['Firmware-Update', 'Software in Geräten: UEFI, Router, Drucker'],
      ['Treiber-Update', 'Fehlerbehebung für Hardware'],
    ],
  ),
  ablauf(
    'n-bh-4',
    'b-haertung',
    'Patchmanagement',
    'Updates werden in Unternehmen nicht einfach auf alle Rechner verteilt, sondern in einem wiederkehrenden Ablauf.',
    [
      'Inventar: Welche Systeme und Softwarestände gibt es?',
      'Informieren: Herstellerhinweise und Warnungen, etwa vom BSI, verfolgen',
      'Bewerten: Wie kritisch ist die Lücke, welche Systeme sind betroffen?',
      'Testen: auf Testsystemen oder bei einer Pilotgruppe',
      'Verteilen: schrittweise, im Wartungsfenster, mit Rückfallplan',
      'Kontrollieren und dokumentieren: Sind alle Systeme aktuell?',
    ],
    skizze: const FlussDiagramm(
      [
        FlussKnoten('Erfassen'),
        FlussKnoten('Bewerten'),
        FlussKnoten('Testen'),
        FlussKnoten('Verteilen'),
        FlussKnoten('Kontrollieren'),
      ],
      zyklus: true,
      zyklusLabel: 'neue Updates',
    ),
  ),
  konzept(
    'n-bh-5',
    'b-haertung',
    'Updates gestaffelt ausrollen',
    'Ein fehlerhaftes Update auf allen Rechnern zugleich kann den ganzen Betrieb lahmlegen. Deshalb wird in Wellen verteilt und vorher gesichert.',
    points: [
      'Welle 1: IT-Abteilung und Testgeräte',
      'Welle 2: Pilotgruppe aus verschiedenen Abteilungen',
      'Welle 3: alle übrigen Systeme',
      'vorher Backup oder Snapshot, damit ein Rollback möglich ist',
      'zentral verteilen, z. B. mit WSUS, Intune oder der Paketverwaltung',
    ],
  ),
  konzept(
    'n-bh-6',
    'b-haertung',
    'Zero-Day-Lücken',
    'Eine Zero-Day-Lücke ist eine Schwachstelle, für die es noch kein Update gibt. Der Hersteller hatte „null Tage“ Zeit zu reagieren. Hier helfen nur Härtung, eingeschränkte Rechte und Überwachung, bis ein Patch erscheint.',
  ),
  konzept(
    'n-bh-7',
    'b-haertung',
    'Wenn der Support endet',
    'Erreicht ein Produkt das Ende seines Supports (End of Life), gibt es keine Sicherheitsupdates mehr. Jede neu entdeckte Lücke bleibt dann offen. Windows 10 etwa erhält seit dem 14. Oktober 2025 regulär keine Updates mehr.',
    points: [
      'Supportende früh einplanen und die Ablösung budgetieren',
      'nicht ersetzbare Altsysteme vom übrigen Netz abschotten',
      'übergangsweise kostenpflichtige Verlängerungen (ESU) prüfen',
    ],
  ),
  konzept(
    'n-bh-8',
    'b-haertung',
    'Offene Ports finden',
    'Jeder Dienst, der auf einem Port lauscht, ist eine mögliche Angriffsstelle. Ermittle zuerst, was offen ist, schalte dann Unnötiges ab und öffne die Firewall nur für das, was gebraucht wird.',
    code:
        'Windows: netstat -an\n'
        'Linux:   ss -tulpen   (lauschende Ports mit Programm)',
  ),
  vergleich(
    'n-bh-9',
    'b-haertung',
    'Einen Webserver härten',
    'Bei der Prüfung eines Webservers fällt Folgendes auf. So behebst du jeden Befund.',
    [
      ['Befund', 'Maßnahme'],
      ['Telnet aktiv (Port 23)', 'abschalten, SSH nutzen'],
      ['Login admin/admin', 'Passwort ändern, persönliche Konten'],
      [
        'SSH-Login als root erlaubt',
        'root-Login sperren, Schlüssel statt Passwort',
      ],
      ['FTP für Uploads', 'SFTP verwenden'],
      ['letztes Update vor 8 Monaten', 'patchen, Updates automatisieren'],
      ['Beispielseiten installiert', 'entfernen'],
    ],
  ),
  konzept(
    'n-bh-10',
    'b-haertung',
    'Verschlüsselung und Schutzsoftware',
    'Härtung begrenzt auch die Folgen, wenn trotzdem etwas passiert.',
    points: [
      'Datenträgerverschlüsselung (BitLocker, LUKS, FileVault) schützt bei Verlust oder Diebstahl',
      'Virenschutz bzw. Endpoint-Schutz erkennt Schadsoftware',
      'Protokollierung zeigt, was passiert ist; die Uhrzeit dafür per NTP synchron halten',
      'Benutzer arbeiten ohne Administratorrechte',
    ],
  ),
  falle(
    'n-bh-11',
    'b-haertung',
    'Updates auf später verschieben',
    'Viele erfolgreiche Angriffe nutzen Lücken, für die längst ein Patch existiert. Sicherheitsupdates wochenlang aufzuschieben, ist eines der größten Risiken in kleinen Unternehmen.',
  ),
  merke(
    'n-bh-12',
    'b-haertung',
    'Das Wichtigste zur Härtung',
    'Diese Punkte solltest du zu Updates und Härtung sicher beherrschen.',
    points: [
      'Angriffsfläche verkleinern: Dienste, Ports, Konten, Rechte',
      'Patchmanagement: erfassen, bewerten, testen, verteilen, kontrollieren',
      'Zero-Day: noch kein Patch, Härtung und Überwachung helfen',
      'End of Life: keine Updates mehr; ablösen oder abschotten',
    ],
    satz:
        'Was nicht läuft, kann nicht angegriffen werden, und was läuft, muss aktuell sein.',
  ),
];
