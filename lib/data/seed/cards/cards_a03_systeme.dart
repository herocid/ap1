import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 03 - Informations- und Softwaresysteme.
final List<Flashcard> cardsA03 = [
  // Komponenten
  karte(
    'k-hk-1',
    'h-komponenten',
    'EVA-Prinzip',
    'Eingabe, Verarbeitung, Ausgabe - ergänzt um die Speicherung.',
  ),
  karte(
    'k-hk-2',
    'h-komponenten',
    'Kennzahlen einer CPU',
    'Anzahl Kerne und Threads, Taktfrequenz, Cache-Größe.',
  ),
  karte(
    'k-hk-3',
    'h-komponenten',
    'Warum ist RAM flüchtig?',
    'Er verliert seinen Inhalt ohne Strom. Dauerhaft gespeichert wird auf SSD oder Festplatte.',
  ),
  karte(
    'k-hk-4',
    'h-komponenten',
    'UEFI',
    'Moderne Firmware als Nachfolger des BIOS: unterstützt GPT, große Datenträger und Secure Boot.',
  ),
  karte(
    'k-hk-5',
    'h-komponenten',
    'Sockel',
    'Steckplatz für den Prozessor auf dem Mainboard - CPU und Sockel müssen zusammenpassen.',
  ),
  karte(
    'k-hk-6',
    'h-komponenten',
    'POST',
    'Power-On Self-Test: Die Firmware prüft nach dem Einschalten CPU, RAM und Grafik.',
  ),
  karte(
    'k-hk-7',
    'h-komponenten',
    'Von-Neumann-Architektur',
    'Steuerwerk und Rechenwerk (CPU), gemeinsamer Speicher für Programme und Daten, Ein-/Ausgabe, Bussystem.',
  ),
  karte(
    'k-hk-8',
    'h-komponenten',
    'Wirkungsgrad eines Netzteils',
    'Aufnahme = Abgabe / Wirkungsgrad. 300 W bei 90 % -> rund 333 W aus der Steckdose.',
  ),

  // Speicher
  karte(
    'k-hs-1',
    'h-speicher',
    'SSD vs. HDD',
    'SSD: Flash, schnell, robust, teurer pro GB. HDD: Magnetscheiben, langsamer, günstiger pro GB.',
  ),
  karte(
    'k-hs-2',
    'h-speicher',
    'NVMe',
    'Protokoll für SSDs über PCIe - mehrere GB/s, deutlich schneller als SATA (ca. 600 MB/s).',
  ),
  karte(
    'k-hs-3',
    'h-speicher',
    'GB vs. GiB',
    'GB: 1.000³ Byte (dezimal). GiB: 1.024³ Byte (binär).',
    'Darum zeigt eine 1-TB-Platte unter Windows rund 931 „GB“.',
  ),
  karte(
    'k-hs-4',
    'h-speicher',
    'TBW',
    'Terabytes Written - wie viele Daten eine SSD laut Hersteller insgesamt schreiben kann.',
  ),
  karte(
    'k-hs-5',
    'h-speicher',
    'Speicherhierarchie',
    'Register - Cache - RAM - SSD - HDD - Band: nach unten langsamer, günstiger, größer.',
  ),
  karte(
    'k-hs-6',
    'h-speicher',
    'M.2',
    'Eine Bauform, kein Tempo: M.2-SATA ca. 550 MB/s, M.2-NVMe mehrere GB/s.',
  ),
  karte(
    'k-hs-7',
    'h-speicher',
    'Größe eines Bildes',
    'Breite × Höhe × Farbtiefe in Byte. 1920 × 1080 × 3 Byte ≈ 6,22 MB.',
  ),
  karte(
    'k-hs-8',
    'h-speicher',
    'NAS vs. SAN',
    'NAS: Dateispeicher im Netz (SMB, NFS). SAN: eigenes, blockbasiertes Speichernetz für Server.',
  ),

  // Schnittstellen
  karte(
    'k-hi-1',
    'h-schnittstellen',
    'USB 3.2 Gen 1',
    '5 Gbit/s - früher USB 3.0 genannt.',
  ),
  karte(
    'k-hi-2',
    'h-schnittstellen',
    'USB-C',
    'Eine Steckerform, keine Geschwindigkeit. Dahinter kann USB 2.0 bis USB4 stecken.',
  ),
  karte(
    'k-hi-3',
    'h-schnittstellen',
    'DisplayPort vs. VGA',
    'DisplayPort: digital, Bild und Ton. VGA: analog, veraltet.',
  ),
  karte(
    'k-hi-4',
    'h-schnittstellen',
    'IPS-Panel',
    'Gute Farbwiedergabe und stabile Blickwinkel - verbreitet bei Büro- und Grafikmonitoren.',
  ),
  karte(
    'k-hi-5',
    'h-schnittstellen',
    'Full HD / WQHD / 4K',
    '1920 × 1080 / 2560 × 1440 / 3840 × 2160 Pixel.',
  ),
  karte(
    'k-hi-6',
    'h-schnittstellen',
    'Übertragungszeit',
    'Zeit = Datenmenge in Bit / Datenrate in Bit/s. Byte × 8 = Bit.',
  ),
  karte(
    'k-hi-7',
    'h-schnittstellen',
    'Thunderbolt',
    'Thunderbolt 3 und 4: 40 Gbit/s über den USB-C-Stecker. Thunderbolt 5: 80 Gbit/s.',
  ),
  karte(
    'k-hi-8',
    'h-schnittstellen',
    'HDMI 2.0 vs. 2.1',
    'HDMI 2.0: 18 Gbit/s, 4K bis 60 Hz. HDMI 2.1: 48 Gbit/s, z. B. 4K mit 120 Hz.',
  ),

  // USV
  karte(
    'k-hu-1',
    'h-usv',
    'Online-USV (Doppelwandler)',
    'Versorgt die Last dauerhaft über den Wechselrichter - keine Umschaltzeit, bester Schutz.',
  ),
  karte(
    'k-hu-2',
    'h-usv',
    'Offline-USV',
    'Schaltet erst bei Stromausfall auf den Akku um - günstiger Grundschutz.',
  ),
  karte(
    'k-hu-3',
    'h-usv',
    'Watt und VA',
    'Watt = VA × Leistungsfaktor. Eine 1000-VA-USV mit Faktor 0,6 liefert nur 600 W.',
  ),
  karte(
    'k-hu-4',
    'h-usv',
    'Überbrückungszeit',
    'Wie lange der Akku die Last versorgt - mindestens lang genug für ein geordnetes Herunterfahren.',
  ),
  karte(
    'k-hu-5',
    'h-usv',
    'VFD / VI / VFI',
    'Offline / Line-Interactive / Online - von netzabhängig bis unabhängig von Spannung und Frequenz.',
  ),
  karte(
    'k-hu-6',
    'h-usv',
    'Überbrückungszeit berechnen',
    'Zeit (h) = Akku-Energie (Wh) × Wirkungsgrad / Last (W). Energie = V × Ah × Anzahl Akkus.',
  ),
  karte(
    'k-hu-7',
    'h-usv',
    'USV dimensionieren',
    'Watt addieren, Reserve aufschlagen, durch den Leistungsfaktor teilen = nötige VA.',
  ),

  // Arbeitsplatz
  karte(
    'k-ha-1',
    'h-arbeitsplatz',
    'Green IT - Maßnahmen',
    'Energieeffiziente Geräte, Stromsparmodi, Virtualisierung, lange Nutzung, fachgerechtes Recycling.',
  ),
  karte(
    'k-ha-2',
    'h-arbeitsplatz',
    'Energiekosten',
    'kWh = Watt × Stunden / 1.000. Kosten = kWh × Preis pro kWh.',
  ),
  karte(
    'k-ha-3',
    'h-arbeitsplatz',
    'Monitorposition',
    'Oberkante auf oder leicht unter Augenhöhe, etwa eine Armlänge entfernt, seitlich zum Fenster.',
  ),
  karte(
    'k-ha-4',
    'h-arbeitsplatz',
    'Rechtsgrundlage Bildschirmarbeit',
    'Arbeitsstättenverordnung (ArbStättV), Anhang zu Bildschirmarbeitsplätzen.',
  ),
  karte(
    'k-ha-5',
    'h-arbeitsplatz',
    'Beleuchtung im Büro',
    'Mindestens 500 Lux laut den Technischen Regeln für Arbeitsstätten.',
  ),
  karte(
    'k-ha-6',
    'h-arbeitsplatz',
    'Blauer Engel',
    'Deutsches Umweltzeichen: sparsam, schadstoffarm, recyclinggerecht.',
  ),
  karte(
    'k-ha-7',
    'h-arbeitsplatz',
    'Altgeräte entsorgen',
    'Nicht in den Restmüll (ElektroG): Daten sicher löschen, dann Rücknahme oder zertifizierter Entsorger.',
  ),

  // Betriebssystem
  karte(
    'k-ba-1',
    'b-aufgaben',
    'Aufgaben eines Betriebssystems',
    'Prozess-, Speicher-, Datei-, Geräte- und Benutzerverwaltung sowie Benutzerschnittstelle.',
  ),
  karte(
    'k-ba-2',
    'b-aufgaben',
    'Prozess vs. Thread',
    'Prozess: laufendes Programm mit eigenem Speicher. Thread: Ausführungsstrang in einem Prozess.',
  ),
  karte(
    'k-ba-3',
    'b-aufgaben',
    'Kernel',
    'Kern des Betriebssystems mit vollem Hardwarezugriff.',
  ),
  karte(
    'k-ba-4',
    'b-aufgaben',
    'Treiber',
    'Software, die zwischen Betriebssystem und einem bestimmten Gerät übersetzt.',
  ),
  karte(
    'k-ba-5',
    'b-aufgaben',
    'Prozesszustände',
    'bereit, rechnend, blockiert - blockiert heißt: wartet auf Ein- oder Ausgabe.',
  ),
  karte(
    'k-ba-6',
    'b-aufgaben',
    'Präemptives Multitasking',
    'Das Betriebssystem entzieht einem Prozess nach seiner Zeitscheibe die CPU.',
  ),
  karte(
    'k-ba-7',
    'b-aufgaben',
    '32-Bit-Grenze',
    '2³² Byte = 4 GiB adressierbarer Arbeitsspeicher. Mehr braucht ein 64-Bit-System.',
  ),
  karte(
    'k-ba-8',
    'b-aufgaben',
    'Auslagerung',
    'Reicht der RAM nicht, werden Speicherseiten ausgelagert: pagefile.sys (Windows), Swap (Linux).',
  ),

  // Dateisysteme
  karte(
    'k-bd-1',
    'b-dateisysteme',
    'NTFS',
    'Windows-Dateisystem mit Rechten, Journaling und Verschlüsselung.',
  ),
  karte(
    'k-bd-2',
    'b-dateisysteme',
    'FAT32 - größte Datei',
    '4 GiB minus 1 Byte. Keine Rechteverwaltung, kein Journaling.',
  ),
  karte(
    'k-bd-3',
    'b-dateisysteme',
    'exFAT',
    'Für USB-Sticks und SD-Karten: große Dateien, gute Kompatibilität, keine Rechte.',
  ),
  karte(
    'k-bd-4',
    'b-dateisysteme',
    'GPT vs. MBR',
    'GPT: große Datenträger, viele Partitionen, UEFI. MBR: max. 2 TiB, 4 primäre Partitionen.',
  ),
  karte(
    'k-bd-5',
    'b-dateisysteme',
    'Journaling',
    'Änderungen werden vorab protokolliert - nach einem Absturz ist das Dateisystem schnell wieder konsistent.',
  ),
  karte(
    'k-bd-6',
    'b-dateisysteme',
    'Absoluter vs. relativer Pfad',
    'Absolut ab der Wurzel (/home/anna), relativ vom aktuellen Verzeichnis aus (../ben).',
  ),
  karte(
    'k-bd-7',
    'b-dateisysteme',
    'Größe auf dem Datenträger',
    'Angefangene Cluster zählen voll: 10.000 Byte belegen bei 4-KiB-Clustern 12.288 Byte.',
  ),
  karte(
    'k-bd-8',
    'b-dateisysteme',
    'Schnellformatierung',
    'Legt nur ein neues Inhaltsverzeichnis an - die Daten sind oft wiederherstellbar.',
  ),

  // Rechte
  karte(
    'k-br-1',
    'b-rechte',
    'Minimalprinzip',
    'Jeder bekommt nur die Rechte, die er für seine Aufgabe braucht.',
  ),
  karte(
    'k-br-2',
    'b-rechte',
    'chmod 640',
    'rw- r-- --- : Besitzer lesen und schreiben, Gruppe lesen, andere nichts.',
  ),
  karte(
    'k-br-3',
    'b-rechte',
    'Werte der Linux-Rechte',
    'r = 4, w = 2, x = 1. Pro Benutzerklasse addiert.',
  ),
  karte(
    'k-br-4',
    'b-rechte',
    'Freigabe- und NTFS-Rechte',
    'Beide gelten beim Netzzugriff - wirksam ist die strengere.',
  ),
  karte(
    'k-br-5',
    'b-rechte',
    'chmod 754',
    'rwxr-xr-- : Besitzer alles, Gruppe lesen und ausführen, andere nur lesen.',
  ),
  karte(
    'k-br-6',
    'b-rechte',
    'x bei einem Verzeichnis',
    'Erlaubt das Hineinwechseln mit cd. r erlaubt das Auflisten, w das Anlegen und Löschen.',
  ),
  karte(
    'k-br-7',
    'b-rechte',
    'Authentifizierung vs. Autorisierung',
    'Authentifizierung: Wer bist du? Autorisierung: Was darfst du?',
  ),
  karte(
    'k-br-8',
    'b-rechte',
    'NTFS: Verweigern',
    'Ein ausdrückliches Verweigern hat Vorrang vor jedem Zulassen.',
  ),

  // CLI
  karte(
    'k-bc-1',
    'b-cli',
    'Windows ipconfig - Linux?',
    'ip a (früher ifconfig).',
  ),
  karte(
    'k-bc-2',
    'b-cli',
    'tracert / traceroute',
    'Zeigt den Weg der Pakete über die einzelnen Router bis zum Ziel.',
  ),
  karte(
    'k-bc-3',
    'b-cli',
    'nslookup',
    'Fragt einen DNS-Server nach der Adresse zu einem Namen - prüft die Namensauflösung.',
  ),
  karte(
    'k-bc-4',
    'b-cli',
    'sudo',
    'Führt unter Linux einen einzelnen Befehl mit Administratorrechten aus.',
  ),
  karte(
    'k-bc-5',
    'b-cli',
    'grep',
    'Durchsucht Dateien oder Ausgaben nach einem Text.',
  ),
  karte(
    'k-bc-6',
    'b-cli',
    '> und >>',
    '> leitet die Ausgabe in eine Datei und überschreibt sie, >> hängt an.',
  ),
  karte(
    'k-bc-7',
    'b-cli',
    'ipconfig /flushdns',
    'Leert unter Windows den DNS-Zwischenspeicher, damit Namen neu aufgelöst werden.',
  ),
  karte(
    'k-bc-8',
    'b-cli',
    '169.254.x.x in ipconfig',
    'APIPA-Adresse: Kein DHCP-Server hat geantwortet - Kabel, VLAN und DHCP prüfen.',
  ),

  // Härtung
  karte(
    'k-bh-1',
    'b-haertung',
    'Härtung',
    'Angriffsfläche verkleinern: unnötige Dienste entfernen, Standardpasswörter ändern, Updates, Firewall, Rechte beschränken.',
  ),
  karte(
    'k-bh-2',
    'b-haertung',
    'Zero-Day',
    'Schwachstelle, für die es noch kein Update gibt.',
  ),
  karte(
    'k-bh-3',
    'b-haertung',
    'Patchmanagement',
    'Updates erfassen, bewerten, testen, verteilen, kontrollieren, dokumentieren.',
  ),
  karte(
    'k-bh-4',
    'b-haertung',
    'Datenträgerverschlüsselung',
    'Schützt Daten bei Verlust oder Diebstahl des Geräts, z. B. BitLocker (Windows) oder LUKS (Linux).',
  ),
  karte(
    'k-bh-5',
    'b-haertung',
    'End of Life',
    'Kein Support und keine Sicherheitsupdates mehr - System ablösen oder vom Netz abschotten.',
  ),
  karte(
    'k-bh-6',
    'b-haertung',
    'Gestaffelter Rollout',
    'Updates in Wellen verteilen: IT, Pilotgruppe, alle übrigen - vorher Backup oder Snapshot.',
  ),
  karte(
    'k-bh-7',
    'b-haertung',
    'ss -tulpen / netstat -an',
    'Zeigen die lauschenden Ports - Grundlage, um unnötige Dienste abzuschalten.',
  ),

  // ERP, SCM, CRM
  karte(
    'k-au-1',
    'an-unternehmen',
    'ERP',
    'Enterprise Resource Planning: integriert alle Unternehmensbereiche mit gemeinsamer Datenbank.',
  ),
  karte(
    'k-au-2',
    'an-unternehmen',
    'SCM',
    'Supply Chain Management: steuert die Lieferkette von Lieferanten über Beschaffung bis zur Logistik.',
  ),
  karte(
    'k-au-3',
    'an-unternehmen',
    'CRM',
    'Customer Relationship Management: bündelt alle Kundenkontakte, Vertrieb, Marketing und Service.',
  ),
  karte(
    'k-au-4',
    'an-unternehmen',
    'Vorteil einer gemeinsamen Datenbank',
    'Keine doppelte Datenhaltung - alle Bereiche arbeiten mit denselben, aktuellen Daten.',
  ),
  karte(
    'k-au-5',
    'an-unternehmen',
    'Operatives CRM',
    'Unterstützt den Kundenkontakt im Alltag: Angebote, Service-Tickets, Vertriebschancen.',
  ),
  karte(
    'k-au-6',
    'an-unternehmen',
    'Analytisches CRM',
    'Wertet Kundendaten aus, z. B. Umsatz je Kunde oder Kündigungsrisiko.',
  ),
  karte(
    'k-au-7',
    'an-unternehmen',
    'EDI',
    'Electronic Data Interchange: automatischer Austausch von Bestellungen und Rechnungen zwischen Unternehmen.',
  ),
  karte(
    'k-au-8',
    'an-unternehmen',
    'DMS',
    'Dokumentenmanagementsystem: Dokumente ablegen, finden und versionieren.',
  ),

  // Standard vs Individual
  karte(
    'k-as-1',
    'an-software',
    'Standardsoftware',
    'Für viele Kunden entwickelt: günstig, sofort verfügbar, aber nicht maßgeschneidert.',
  ),
  karte(
    'k-as-2',
    'an-software',
    'Individualsoftware',
    'Für einen Kunden entwickelt: passgenau, aber teuer und erst nach Entwicklung verfügbar.',
  ),
  karte(
    'k-as-3',
    'an-software',
    'Customizing',
    'Anpassen von Standardsoftware über Einstellungen - ohne den Programmcode zu ändern.',
  ),
  karte(
    'k-as-4',
    'an-software',
    'Branchensoftware',
    'Standardsoftware, die auf die Bedürfnisse einer bestimmten Branche zugeschnitten ist.',
  ),
  karte(
    'k-as-5',
    'an-software',
    'Modifikation',
    'Änderung am Programmcode einer Standardsoftware - geht bei Updates oft verloren.',
  ),
  karte(
    'k-as-6',
    'an-software',
    'TCO',
    'Total Cost of Ownership: alle Kosten über die Nutzungsdauer, nicht nur der Kaufpreis.',
  ),
  karte(
    'k-as-7',
    'an-software',
    'On-Premises vs. SaaS',
    'Kauf und Betrieb im eigenen Haus gegenüber Miete der Software als Dienst beim Anbieter.',
  ),

  // Lizenzen
  karte(
    'k-al-3',
    'an-lizenzen',
    'GPL',
    'Copyleft-Lizenz: Veränderte Versionen dürfen nur unter der GPL weitergegeben werden.',
  ),
  karte(
    'k-al-4',
    'an-lizenzen',
    'MIT-Lizenz',
    'Freizügige Open-Source-Lizenz: Nutzung auch in geschlossener Software, Lizenzhinweis nötig.',
  ),
  karte(
    'k-al-5',
    'an-lizenzen',
    'Freeware vs. Open Source',
    'Freeware ist kostenlos, der Quellcode aber geschlossen. Open Source legt den Quellcode offen.',
  ),
  karte(
    'k-al-6',
    'an-lizenzen',
    'OEM-Lizenz',
    'An ein bestimmtes Gerät gebunden und mit ihm verkauft.',
  ),
  karte(
    'k-al-7',
    'an-lizenzen',
    'Named vs. Concurrent User',
    'Named User: jede berechtigte Person zählt. Concurrent User: nur gleichzeitig angemeldete.',
  ),
  karte(
    'k-al-8',
    'an-lizenzen',
    'LGPL',
    'Schwaches Copyleft: Bibliothek darf in geschlossene Software, Änderungen an ihr bleiben offen.',
  ),
  karte(
    'k-al-9',
    'an-lizenzen',
    'Unterlizenzierung',
    'Mehr Installationen als Lizenzen - Urheberrechtsverletzung, Nachzahlung und Schadenersatz drohen.',
  ),
  karte(
    'k-al-10',
    'an-lizenzen',
    'Kauf oder Abo?',
    'Kaufpreis + Wartung × n = Abo × n setzen und nach n (Jahre) auflösen.',
  ),

  // Kollaboration
  karte(
    'k-ak-1',
    'an-kollaboration',
    'Synchrone Kommunikation',
    'Alle sind gleichzeitig dabei - Videokonferenz, Telefon, Live-Chat.',
  ),
  karte(
    'k-ak-2',
    'an-kollaboration',
    'Asynchrone Kommunikation',
    'Zeitversetzt - E-Mail, Wiki, Ticketsystem, gemeinsame Dokumente.',
  ),
  karte(
    'k-ak-3',
    'an-kollaboration',
    'Social-Media-Richtlinie',
    'Regelt, wer im Namen des Unternehmens postet und was vertraulich bleibt.',
  ),
  karte(
    'k-ak-4',
    'an-kollaboration',
    'Auftragsverarbeitungsvertrag',
    'Pflicht, wenn ein Dienstleister personenbezogene Daten im Auftrag verarbeitet - auch bei Cloud-Werkzeugen.',
  ),
  karte(
    'k-ak-5',
    'an-kollaboration',
    'Raum-Zeit-Matrix',
    'Ordnet Werkzeuge nach Ort (gleich oder verteilt) und Zeit (gleichzeitig oder versetzt).',
  ),
  karte(
    'k-ak-6',
    'an-kollaboration',
    'Schatten-IT',
    'Dienste, die Beschäftigte ohne Wissen und Kontrolle der IT nutzen.',
  ),
  karte(
    'k-ak-7',
    'an-kollaboration',
    'UCC',
    'Unified Communications and Collaboration: Telefonie, Chat, Video und Präsenz in einer Oberfläche.',
  ),

  // OSI
  karte(
    'k-no-1',
    'nw-modelle',
    'OSI-Schichten von 7 nach 1',
    'Anwendung, Darstellung, Sitzung, Transport, Vermittlung, Sicherung, Bitübertragung.',
  ),
  karte(
    'k-no-2',
    'nw-modelle',
    'OSI-Schicht eines Switches',
    'Schicht 2 (Sicherung) - arbeitet mit MAC-Adressen.',
  ),
  karte(
    'k-no-3',
    'nw-modelle',
    'OSI-Schicht eines Routers',
    'Schicht 3 (Vermittlung) - arbeitet mit IP-Adressen.',
  ),
  karte(
    'k-no-4',
    'nw-modelle',
    'TCP vs. UDP',
    'TCP: verbindungsorientiert, zuverlässig. UDP: verbindungslos, schnell, ohne Garantie.',
  ),
  karte(
    'k-no-5',
    'nw-modelle',
    'Kapselung',
    'Jede Schicht fügt beim Senden ihre Steuerinformationen hinzu: Segment, Paket, Frame, Bits.',
  ),
  karte(
    'k-no-6',
    'nw-modelle',
    'TCP-Handshake',
    'SYN - SYN-ACK - ACK, danach steht die Verbindung.',
  ),
  karte(
    'k-no-7',
    'nw-modelle',
    'ARP',
    'Ermittelt im lokalen Netz zur IP-Adresse die MAC-Adresse.',
  ),
  karte(
    'k-no-8',
    'nw-modelle',
    'TCP/IP-Modell',
    'Anwendung, Transport, Internet, Netzzugang.',
  ),
  karte(
    'k-no-9',
    'nw-modelle',
    'Well-known Ports',
    '0 bis 1.023 - Standarddienste wie SSH (22), HTTP (80), HTTPS (443).',
  ),

  // Geräte
  karte(
    'k-ng-2',
    'nw-geraete',
    'Switch vs. Hub',
    'Switch leitet gezielt per MAC-Adresstabelle weiter, Hub sendet an alle.',
  ),
  karte(
    'k-ng-3',
    'nw-geraete',
    'Access Point',
    'Bindet WLAN-Geräte in das kabelgebundene Netz ein.',
  ),
  karte(
    'k-ng-4',
    'nw-geraete',
    'Cat 6A',
    'Twisted-Pair-Kabel für 10 Gbit/s bis 100 m.',
  ),
  karte(
    'k-ng-5',
    'nw-geraete',
    'VLAN',
    'Logische Aufteilung eines physischen Switches in getrennte Netze.',
  ),
  karte(
    'k-ng-6',
    'nw-geraete',
    'Cat 6 und 10 Gbit/s',
    '10 Gbit/s nur bis etwa 55 m - für volle 100 m braucht es Cat 6A.',
  ),
  karte(
    'k-ng-7',
    'nw-geraete',
    'Wi-Fi 6 / Wi-Fi 7',
    'IEEE 802.11ax / IEEE 802.11be.',
  ),
  karte(
    'k-ng-8',
    'nw-geraete',
    'Broadcastdomäne',
    'Bereich, den ein Broadcast erreicht - endet am Router, jedes VLAN bildet eine eigene.',
  ),
  karte(
    'k-ng-9',
    'nw-geraete',
    'PoE',
    'Power over Ethernet: Strom über das Netzwerkkabel - 802.3af 15,4 W, at 30 W, bt bis 90 W.',
  ),
  karte(
    'k-ng-10',
    'nw-geraete',
    'Singlemode vs. Multimode',
    'Singlemode: dünner Kern, Laser, viele Kilometer. Multimode: dickerer Kern, einige hundert Meter.',
  ),

  // IPv4
  karte(
    'k-n4-1',
    'nw-ipv4',
    'Private IPv4-Bereiche',
    '10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16.',
  ),
  karte(
    'k-n4-2',
    'nw-ipv4',
    'Nutzbare Hosts',
    '2^(32 - Präfix) - 2. Netz- und Broadcastadresse sind nicht vergebbar.',
  ),
  karte(
    'k-n4-3',
    'nw-ipv4',
    '/26 als Maske',
    '255.255.255.192 - Blockgröße 64, 62 nutzbare Hosts.',
  ),
  karte(
    'k-n4-4',
    'nw-ipv4',
    'APIPA',
    '169.254.x.x - selbst vergebene Adresse, wenn kein DHCP-Server antwortet.',
  ),
  karte(
    'k-n4-5',
    'nw-ipv4',
    '/30',
    '255.255.255.252 - 2 nutzbare Hosts, typisch für Punkt-zu-Punkt-Verbindungen.',
  ),
  karte(
    'k-n4-6',
    'nw-ipv4',
    'Blockgröße',
    '256 - Wert des Maskenoktetts, z. B. /27: 256 - 224 = 32.',
  ),
  karte(
    'k-n4-7',
    'nw-ipv4',
    '/27 als Maske',
    '255.255.255.224 - Blockgröße 32, 30 nutzbare Hosts.',
  ),
  karte(
    'k-n4-8',
    'nw-ipv4',
    'Netzadresse berechnen',
    'IP-Adresse bitweise UND Maske - alle Hostbits werden 0. Broadcast: alle Hostbits 1.',
  ),
  karte(
    'k-n4-9',
    'nw-ipv4',
    '/28 als Maske',
    '255.255.255.240 - Blockgröße 16, 14 nutzbare Hosts.',
  ),
  karte(
    'k-n4-10',
    'nw-ipv4',
    'VLSM',
    'Subnetze unterschiedlicher Größe - immer mit dem größten Netz beginnen.',
  ),

  // IPv6
  karte(
    'k-n6-1',
    'nw-ipv6',
    'Länge einer IPv6-Adresse',
    '128 Bit, acht Blöcke zu je 16 Bit in Hexadezimal.',
  ),
  karte(
    'k-n6-2',
    'nw-ipv6',
    'Regeln zum Kürzen',
    'Führende Nullen je Block weglassen. Eine Folge von Null-Blöcken einmal durch :: ersetzen.',
  ),
  karte(
    'k-n6-3',
    'nw-ipv6',
    'fe80::/10',
    'Link-Local - nur im eigenen Netzsegment gültig.',
  ),
  karte(
    'k-n6-4',
    'nw-ipv6',
    '::1',
    'Loopback - der eigene Rechner, wie 127.0.0.1 bei IPv4.',
  ),
  karte(
    'k-n6-5',
    'nw-ipv6',
    'Broadcast in IPv6?',
    'Gibt es nicht - Multicast übernimmt die Aufgabe.',
  ),
  karte(
    'k-n6-6',
    'nw-ipv6',
    'fc00::/7',
    'Unique Local Address - privat, im Internet nicht geroutet, meist mit fd beginnend.',
  ),
  karte(
    'k-n6-7',
    'nw-ipv6',
    'SLAAC',
    'Das Gerät bildet seine Adresse selbst aus dem Präfix des Routers und einer Interface-ID.',
  ),
  karte(
    'k-n6-8',
    'nw-ipv6',
    'EUI-64',
    'Interface-ID aus der MAC-Adresse: ff:fe in die Mitte einfügen, 7. Bit umdrehen.',
  ),
  karte(
    'k-n6-9',
    'nw-ipv6',
    'NDP',
    'Neighbor Discovery Protocol - ersetzt bei IPv6 das ARP und findet Router.',
  ),

  // Dienste
  karte(
    'k-nd-1',
    'nw-dienste',
    'DHCP - DORA',
    'Discover, Offer, Request, Acknowledge.',
  ),
  karte(
    'k-nd-2',
    'nw-dienste',
    'DNS-Eintrag MX',
    'Nennt den Mailserver einer Domain.',
  ),
  karte(
    'k-nd-3',
    'nw-dienste',
    'HTTPS-Port',
    '443 - verschlüsselte Webseiten. Unverschlüsseltes HTTP nutzt Port 80.',
  ),
  karte(
    'k-nd-4',
    'nw-dienste',
    'SSH-Port',
    '22 - verschlüsselte Fernwartung, ersetzt das unsichere Telnet (Port 23).',
  ),
  karte(
    'k-nd-5',
    'nw-dienste',
    'IMAP vs. POP3',
    'IMAP: Mails bleiben auf dem Server, synchron auf mehreren Geräten. POP3: Mails werden meist heruntergeladen.',
  ),
  karte(
    'k-nd-6',
    'nw-dienste',
    'DNS-Eintrag AAAA',
    'Ordnet einem Namen eine IPv6-Adresse zu (A: IPv4).',
  ),
  karte(
    'k-nd-7',
    'nw-dienste',
    'PAT (NAT-Overload)',
    'Viele private Adressen teilen sich eine öffentliche - unterschieden über die Ports.',
  ),
  karte(
    'k-nd-8',
    'nw-dienste',
    'DHCP-Relay',
    'Leitet DHCP-Broadcasts über den Router zu einem Server in einem anderen Subnetz weiter.',
  ),
  karte(
    'k-nd-9',
    'nw-dienste',
    'SMTP-Ports',
    '25 zwischen Mailservern, 587 für die Einlieferung durch Mailprogramme.',
  ),
  karte(
    'k-nd-10',
    'nw-dienste',
    'NTP',
    'Port 123/UDP - synchronisiert die Uhrzeit, wichtig für Protokolle und Anmeldung.',
  ),

  // Cloud
  karte(
    'k-nc-1',
    'nw-cloud',
    'IaaS',
    'Infrastructure as a Service: virtuelle Server, Speicher und Netz mieten.',
  ),
  karte(
    'k-nc-2',
    'nw-cloud',
    'PaaS',
    'Platform as a Service: Laufzeitumgebung und Dienste, ohne Server selbst zu verwalten.',
  ),
  karte(
    'k-nc-3',
    'nw-cloud',
    'SaaS',
    'Software as a Service: fertige Anwendung im Browser, z. B. Office online.',
  ),
  karte(
    'k-nc-4',
    'nw-cloud',
    'Hypervisor Typ 1',
    'Läuft direkt auf der Hardware, z. B. VMware ESXi, Hyper-V, KVM.',
  ),
  karte(
    'k-nc-5',
    'nw-cloud',
    'Container vs. VM',
    'Container teilen den Kernel des Hosts und starten in Sekunden. VMs haben ein eigenes Betriebssystem.',
  ),
  karte(
    'k-nc-6',
    'nw-cloud',
    'Hybrid Cloud',
    'Kombination aus Private und Public Cloud, z. B. sensible Daten intern, Webshop beim Anbieter.',
  ),
  karte(
    'k-nc-7',
    'nw-cloud',
    'SLA 99,9 %',
    'Höchstens 8,76 Stunden Ausfall pro Jahr (8.760 h × 0,001).',
  ),
  karte(
    'k-nc-8',
    'nw-cloud',
    'Scale up vs. scale out',
    'Vertikal: größere Maschine. Horizontal: mehr Maschinen hinter einem Lastverteiler.',
  ),
  karte(
    'k-nc-9',
    'nw-cloud',
    'Geteilte Verantwortung',
    'Daten und Zugänge verantwortet immer der Kunde - bei IaaS zusätzlich das Betriebssystem.',
  ),
];
