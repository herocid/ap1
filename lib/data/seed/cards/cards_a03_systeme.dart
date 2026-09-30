import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 03 - Informations- und Softwaresysteme.
final List<Flashcard> cardsA03 = [
  // Komponenten
  karte('k-hk-1', 'h-komponenten', 'EVA-Prinzip',
      'Eingabe, Verarbeitung, Ausgabe - ergänzt um die Speicherung.'),
  karte('k-hk-2', 'h-komponenten', 'Kennzahlen einer CPU',
      'Anzahl Kerne und Threads, Taktfrequenz, Cache-Größe.'),
  karte('k-hk-3', 'h-komponenten', 'Warum ist RAM flüchtig?',
      'Er verliert seinen Inhalt ohne Strom. Dauerhaft gespeichert wird auf SSD oder Festplatte.'),
  karte('k-hk-4', 'h-komponenten', 'UEFI',
      'Moderne Firmware als Nachfolger des BIOS: unterstützt GPT, große Datenträger und Secure Boot.'),
  karte('k-hk-5', 'h-komponenten', 'Sockel',
      'Steckplatz für den Prozessor auf dem Mainboard - CPU und Sockel müssen zusammenpassen.'),

  // Speicher
  karte('k-hs-1', 'h-speicher', 'SSD vs. HDD',
      'SSD: Flash, schnell, robust, teurer pro GB. HDD: Magnetscheiben, langsamer, günstiger pro GB.'),
  karte('k-hs-2', 'h-speicher', 'NVMe',
      'Protokoll für SSDs über PCIe - mehrere GB/s, deutlich schneller als SATA (ca. 600 MB/s).'),
  karte('k-hs-3', 'h-speicher', 'GB vs. GiB',
      'GB: 1.000³ Byte (dezimal). GiB: 1.024³ Byte (binär).',
      'Darum zeigt eine 1-TB-Platte unter Windows rund 931 „GB“.'),
  karte('k-hs-4', 'h-speicher', 'TBW',
      'Terabytes Written - wie viele Daten eine SSD laut Hersteller insgesamt schreiben kann.'),

  // Schnittstellen
  karte('k-hi-1', 'h-schnittstellen', 'USB 3.2 Gen 1',
      '5 Gbit/s - früher USB 3.0 genannt.'),
  karte('k-hi-2', 'h-schnittstellen', 'USB-C',
      'Eine Steckerform, keine Geschwindigkeit. Dahinter kann USB 2.0 bis USB4 stecken.'),
  karte('k-hi-3', 'h-schnittstellen', 'DisplayPort vs. VGA',
      'DisplayPort: digital, Bild und Ton. VGA: analog, veraltet.'),
  karte('k-hi-4', 'h-schnittstellen', 'IPS-Panel',
      'Gute Farbwiedergabe und stabile Blickwinkel - verbreitet bei Büro- und Grafikmonitoren.'),
  karte('k-hi-5', 'h-schnittstellen', 'Full HD / WQHD / 4K',
      '1920 × 1080 / 2560 × 1440 / 3840 × 2160 Pixel.'),

  // USV
  karte('k-hu-1', 'h-usv', 'Online-USV (Doppelwandler)',
      'Versorgt die Last dauerhaft über den Wechselrichter - keine Umschaltzeit, bester Schutz.'),
  karte('k-hu-2', 'h-usv', 'Offline-USV',
      'Schaltet erst bei Stromausfall auf den Akku um - günstiger Grundschutz.'),
  karte('k-hu-3', 'h-usv', 'Watt und VA',
      'Watt = VA × Leistungsfaktor. Eine 1000-VA-USV mit Faktor 0,6 liefert nur 600 W.'),
  karte('k-hu-4', 'h-usv', 'Überbrückungszeit',
      'Wie lange der Akku die Last versorgt - mindestens lang genug für ein geordnetes Herunterfahren.'),

  // Arbeitsplatz
  karte('k-ha-1', 'h-arbeitsplatz', 'Green IT - Maßnahmen',
      'Energieeffiziente Geräte, Stromsparmodi, Virtualisierung, lange Nutzung, fachgerechtes Recycling.'),
  karte('k-ha-2', 'h-arbeitsplatz', 'Energiekosten',
      'kWh = Watt × Stunden / 1.000. Kosten = kWh × Preis pro kWh.'),
  karte('k-ha-3', 'h-arbeitsplatz', 'Monitorposition',
      'Oberkante auf oder leicht unter Augenhöhe, etwa eine Armlänge entfernt, seitlich zum Fenster.'),
  karte('k-ha-4', 'h-arbeitsplatz', 'Rechtsgrundlage Bildschirmarbeit',
      'Arbeitsstättenverordnung (ArbStättV), Anhang zu Bildschirmarbeitsplätzen.'),

  // Betriebssystem
  karte('k-ba-1', 'b-aufgaben', 'Aufgaben eines Betriebssystems',
      'Prozess-, Speicher-, Datei-, Geräte- und Benutzerverwaltung sowie Benutzerschnittstelle.'),
  karte('k-ba-2', 'b-aufgaben', 'Prozess vs. Thread',
      'Prozess: laufendes Programm mit eigenem Speicher. Thread: Ausführungsstrang in einem Prozess.'),
  karte('k-ba-3', 'b-aufgaben', 'Kernel',
      'Kern des Betriebssystems mit vollem Hardwarezugriff.'),
  karte('k-ba-4', 'b-aufgaben', 'Treiber',
      'Software, die zwischen Betriebssystem und einem bestimmten Gerät übersetzt.'),

  // Dateisysteme
  karte('k-bd-1', 'b-dateisysteme', 'NTFS',
      'Windows-Dateisystem mit Rechten, Journaling und Verschlüsselung.'),
  karte('k-bd-2', 'b-dateisysteme', 'FAT32 - größte Datei',
      '4 GB. Keine Rechteverwaltung.'),
  karte('k-bd-3', 'b-dateisysteme', 'exFAT',
      'Für USB-Sticks und SD-Karten: große Dateien, gute Kompatibilität, keine Rechte.'),
  karte('k-bd-4', 'b-dateisysteme', 'GPT vs. MBR',
      'GPT: große Datenträger, viele Partitionen, UEFI. MBR: max. 2 TiB, 4 primäre Partitionen.'),

  // Rechte
  karte('k-br-1', 'b-rechte', 'Minimalprinzip',
      'Jeder bekommt nur die Rechte, die er für seine Aufgabe braucht.'),
  karte('k-br-2', 'b-rechte', 'chmod 640',
      'rw- r-- --- : Besitzer lesen und schreiben, Gruppe lesen, andere nichts.'),
  karte('k-br-3', 'b-rechte', 'Werte der Linux-Rechte',
      'r = 4, w = 2, x = 1. Pro Benutzerklasse addiert.'),
  karte('k-br-4', 'b-rechte', 'Freigabe- und NTFS-Rechte',
      'Beide gelten beim Netzzugriff - wirksam ist die strengere.'),

  // CLI
  karte('k-bc-1', 'b-cli', 'Windows ipconfig - Linux?',
      'ip a (früher ifconfig).'),
  karte('k-bc-2', 'b-cli', 'tracert / traceroute',
      'Zeigt den Weg der Pakete über die einzelnen Router bis zum Ziel.'),
  karte('k-bc-3', 'b-cli', 'nslookup',
      'Fragt einen DNS-Server nach der Adresse zu einem Namen - prüft die Namensauflösung.'),
  karte('k-bc-4', 'b-cli', 'sudo',
      'Führt unter Linux einen einzelnen Befehl mit Administratorrechten aus.'),
  karte('k-bc-5', 'b-cli', 'grep',
      'Durchsucht Dateien oder Ausgaben nach einem Text.'),

  // Härtung
  karte('k-bh-1', 'b-haertung', 'Härtung',
      'Angriffsfläche verkleinern: unnötige Dienste entfernen, Standardpasswörter ändern, Updates, Firewall, Rechte beschränken.'),
  karte('k-bh-2', 'b-haertung', 'Zero-Day',
      'Schwachstelle, für die es noch kein Update gibt.'),
  karte('k-bh-3', 'b-haertung', 'Patchmanagement',
      'Updates erfassen, bewerten, testen, verteilen, kontrollieren, dokumentieren.'),
  karte('k-bh-4', 'b-haertung', 'Datenträgerverschlüsselung',
      'Schützt Daten bei Verlust oder Diebstahl des Geräts, z. B. BitLocker (Windows) oder LUKS (Linux).'),

  // ERP, SCM, CRM
  karte('k-au-1', 'an-unternehmen', 'ERP',
      'Enterprise Resource Planning: integriert alle Unternehmensbereiche mit gemeinsamer Datenbank.'),
  karte('k-au-2', 'an-unternehmen', 'SCM',
      'Supply Chain Management: steuert die Lieferkette von Lieferanten über Beschaffung bis zur Logistik.'),
  karte('k-au-3', 'an-unternehmen', 'CRM',
      'Customer Relationship Management: bündelt alle Kundenkontakte, Vertrieb, Marketing und Service.'),
  karte('k-au-4', 'an-unternehmen', 'Vorteil einer gemeinsamen Datenbank',
      'Keine doppelte Datenhaltung - alle Bereiche arbeiten mit denselben, aktuellen Daten.'),

  // Standard vs Individual
  karte('k-as-1', 'an-software', 'Standardsoftware',
      'Für viele Kunden entwickelt: günstig, sofort verfügbar, aber nicht maßgeschneidert.'),
  karte('k-as-2', 'an-software', 'Individualsoftware',
      'Für einen Kunden entwickelt: passgenau, aber teuer und erst nach Entwicklung verfügbar.'),
  karte('k-as-3', 'an-software', 'Customizing',
      'Anpassen von Standardsoftware über Einstellungen - ohne den Programmcode zu ändern.'),
  karte('k-as-4', 'an-software', 'Branchensoftware',
      'Standardsoftware, die auf die Bedürfnisse einer bestimmten Branche zugeschnitten ist.'),

  // Lizenzen
  karte('k-al-3', 'an-lizenzen', 'GPL',
      'Copyleft-Lizenz: Veränderte Versionen dürfen nur unter der GPL weitergegeben werden.'),
  karte('k-al-4', 'an-lizenzen', 'MIT-Lizenz',
      'Freizügige Open-Source-Lizenz: Nutzung auch in geschlossener Software, Lizenzhinweis nötig.'),
  karte('k-al-5', 'an-lizenzen', 'Freeware vs. Open Source',
      'Freeware ist kostenlos, der Quellcode aber geschlossen. Open Source legt den Quellcode offen.'),
  karte('k-al-6', 'an-lizenzen', 'OEM-Lizenz',
      'An ein bestimmtes Gerät gebunden und mit ihm verkauft.'),

  // Kollaboration
  karte('k-ak-1', 'an-kollaboration', 'Synchrone Kommunikation',
      'Alle sind gleichzeitig dabei - Videokonferenz, Telefon, Live-Chat.'),
  karte('k-ak-2', 'an-kollaboration', 'Asynchrone Kommunikation',
      'Zeitversetzt - E-Mail, Wiki, Ticketsystem, gemeinsame Dokumente.'),
  karte('k-ak-3', 'an-kollaboration', 'Social-Media-Richtlinie',
      'Regelt, wer im Namen des Unternehmens postet und was vertraulich bleibt.'),
  karte('k-ak-4', 'an-kollaboration', 'Auftragsverarbeitungsvertrag',
      'Pflicht, wenn ein Dienstleister personenbezogene Daten im Auftrag verarbeitet - auch bei Cloud-Werkzeugen.'),

  // OSI
  karte('k-no-1', 'nw-modelle', 'OSI-Schichten von 7 nach 1',
      'Anwendung, Darstellung, Sitzung, Transport, Vermittlung, Sicherung, Bitübertragung.'),
  karte('k-no-2', 'nw-modelle', 'OSI-Schicht eines Switches',
      'Schicht 2 (Sicherung) - arbeitet mit MAC-Adressen.'),
  karte('k-no-3', 'nw-modelle', 'OSI-Schicht eines Routers',
      'Schicht 3 (Vermittlung) - arbeitet mit IP-Adressen.'),
  karte('k-no-4', 'nw-modelle', 'TCP vs. UDP',
      'TCP: verbindungsorientiert, zuverlässig. UDP: verbindungslos, schnell, ohne Garantie.'),
  karte('k-no-5', 'nw-modelle', 'Kapselung',
      'Jede Schicht fügt beim Senden ihre Steuerinformationen hinzu: Segment, Paket, Frame, Bits.'),

  // Geräte
  karte('k-ng-2', 'nw-geraete', 'Switch vs. Hub',
      'Switch leitet gezielt per MAC-Adresstabelle weiter, Hub sendet an alle.'),
  karte('k-ng-3', 'nw-geraete', 'Access Point',
      'Bindet WLAN-Geräte in das kabelgebundene Netz ein.'),
  karte('k-ng-4', 'nw-geraete', 'Cat 6A',
      'Twisted-Pair-Kabel für 10 Gbit/s bis 100 m.'),
  karte('k-ng-5', 'nw-geraete', 'VLAN',
      'Logische Aufteilung eines physischen Switches in getrennte Netze.'),

  // IPv4
  karte('k-n4-1', 'nw-ipv4', 'Private IPv4-Bereiche',
      '10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16.'),
  karte('k-n4-2', 'nw-ipv4', 'Nutzbare Hosts',
      '2^(32 - Präfix) - 2. Netz- und Broadcastadresse sind nicht vergebbar.'),
  karte('k-n4-3', 'nw-ipv4', '/26 als Maske',
      '255.255.255.192 - Blockgröße 64, 62 nutzbare Hosts.'),
  karte('k-n4-4', 'nw-ipv4', 'APIPA',
      '169.254.x.x - selbst vergebene Adresse, wenn kein DHCP-Server antwortet.'),
  karte('k-n4-5', 'nw-ipv4', '/30',
      '255.255.255.252 - 2 nutzbare Hosts, typisch für Punkt-zu-Punkt-Verbindungen.'),

  // IPv6
  karte('k-n6-1', 'nw-ipv6', 'Länge einer IPv6-Adresse',
      '128 Bit, acht Blöcke zu je 16 Bit in Hexadezimal.'),
  karte('k-n6-2', 'nw-ipv6', 'Regeln zum Kürzen',
      'Führende Nullen je Block weglassen. Eine Folge von Null-Blöcken einmal durch :: ersetzen.'),
  karte('k-n6-3', 'nw-ipv6', 'fe80::/10',
      'Link-Local - nur im eigenen Netzsegment gültig.'),
  karte('k-n6-4', 'nw-ipv6', '::1',
      'Loopback - der eigene Rechner, wie 127.0.0.1 bei IPv4.'),
  karte('k-n6-5', 'nw-ipv6', 'Broadcast in IPv6?',
      'Gibt es nicht - Multicast übernimmt die Aufgabe.'),

  // Dienste
  karte('k-nd-1', 'nw-dienste', 'DHCP - DORA',
      'Discover, Offer, Request, Acknowledge.'),
  karte('k-nd-2', 'nw-dienste', 'DNS-Eintrag MX',
      'Nennt den Mailserver einer Domain.'),
  karte('k-nd-3', 'nw-dienste', 'HTTPS-Port',
      '443 - verschlüsselte Webseiten. Unverschlüsseltes HTTP nutzt Port 80.'),
  karte('k-nd-4', 'nw-dienste', 'SSH-Port',
      '22 - verschlüsselte Fernwartung, ersetzt das unsichere Telnet (Port 23).'),
  karte('k-nd-5', 'nw-dienste', 'IMAP vs. POP3',
      'IMAP: Mails bleiben auf dem Server, synchron auf mehreren Geräten. POP3: Mails werden meist heruntergeladen.'),

  // Cloud
  karte('k-nc-1', 'nw-cloud', 'IaaS',
      'Infrastructure as a Service: virtuelle Server, Speicher und Netz mieten.'),
  karte('k-nc-2', 'nw-cloud', 'PaaS',
      'Platform as a Service: Laufzeitumgebung und Dienste, ohne Server selbst zu verwalten.'),
  karte('k-nc-3', 'nw-cloud', 'SaaS',
      'Software as a Service: fertige Anwendung im Browser, z. B. Office online.'),
  karte('k-nc-4', 'nw-cloud', 'Hypervisor Typ 1',
      'Läuft direkt auf der Hardware, z. B. VMware ESXi, Hyper-V, KVM.'),
  karte('k-nc-5', 'nw-cloud', 'Container vs. VM',
      'Container teilen den Kernel des Hosts und starten in Sekunden. VMs haben ein eigenes Betriebssystem.'),
];
