import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 06, Teil 1: Schutzziele, Bedrohungen und
/// technische Schutzmaßnahmen.
final List<Flashcard> cardsA06Sicherheit = [
  // Schutzziele
  karte(
    'k-zz-1',
    'sz-schutzziele',
    'Vertraulichkeit',
    'Nur befugte Personen können die Daten lesen.',
  ),
  karte(
    'k-zz-2',
    'sz-schutzziele',
    'Integrität',
    'Daten sind korrekt und unverändert - Änderungen werden bemerkt.',
  ),
  karte(
    'k-zz-3',
    'sz-schutzziele',
    'Verfügbarkeit',
    'Systeme und Daten sind nutzbar, wenn sie gebraucht werden.',
  ),
  karte(
    'k-zz-4',
    'sz-schutzziele',
    'Authentizität vs. Verbindlichkeit',
    'Authentizität: Echtheit und Herkunft sind prüfbar. Verbindlichkeit: Eine Handlung kann nicht abgestritten werden.',
  ),
  karte(
    'k-zz-5',
    'sz-schutzziele',
    '99,9 % Verfügbarkeit (24/7)',
    '0,001 × 8.760 h = 8,76 h Ausfall pro Jahr erlaubt.',
  ),
  karte(
    'k-zz-6',
    'sz-schutzziele',
    'Formel maximale Ausfallzeit',
    'Ausfallzeit = (100 % - Verfügbarkeit) × vereinbarte Betriebszeit.',
    '24/7: 8.760 h pro Jahr, 720 h pro 30-Tage-Monat.',
  ),
  karte(
    'k-zz-7',
    'sz-schutzziele',
    'Verfügbarkeit in Reihe',
    'Alle Komponenten müssen laufen: Verfügbarkeiten multiplizieren, z. B. 0,99 × 0,995 = 98,505 %.',
  ),
  karte(
    'k-zz-8',
    'sz-schutzziele',
    'Verfügbarkeit parallel (redundant)',
    '1 - Produkt der Ausfallwahrscheinlichkeiten, z. B. 1 - 0,01 × 0,01 = 99,99 %.',
  ),

  // Schadsoftware
  karte(
    'k-zm-1',
    'sz-schadsoftware',
    'Virus',
    'Hängt sich an eine Wirtsdatei und wird aktiv, wenn diese ausgeführt wird.',
  ),
  karte(
    'k-zm-2',
    'sz-schadsoftware',
    'Wurm',
    'Verbreitet sich selbstständig über das Netz, meist über Sicherheitslücken - ohne Wirtsdatei.',
  ),
  karte(
    'k-zm-3',
    'sz-schadsoftware',
    'Trojaner',
    'Als nützliches Programm getarnt, wird vom Nutzer selbst installiert und verbreitet sich nicht selbst.',
  ),
  karte(
    'k-zm-4',
    'sz-schadsoftware',
    'Ransomware',
    'Verschlüsselt Daten und fordert Lösegeld für die Entschlüsselung.',
  ),
  karte(
    'k-zm-5',
    'sz-schadsoftware',
    'Rootkit und Botnetz',
    'Rootkit: versteckt Schadsoftware tief im System. Botnetz: viele ferngesteuerte Rechner, z. B. für DDoS.',
  ),
  karte(
    'k-zm-6',
    'sz-schadsoftware',
    'Zero-Day-Lücke',
    'Sicherheitslücke, die dem Hersteller noch unbekannt ist oder für die es noch kein Update gibt.',
  ),
  karte(
    'k-zm-7',
    'sz-schadsoftware',
    'Erste Schritte bei Befall',
    'Vom Netz trennen, Arbeit einstellen, IT-Notfall melden, Beobachtungen notieren, nur nach Anweisung handeln.',
  ),
  karte(
    'k-zm-8',
    'sz-schadsoftware',
    'Signatur- vs. Verhaltenserkennung',
    'Signatur: erkennt bekannte Schädlinge an Mustern. Verhalten: erkennt verdächtige Aktionen wie Massenverschlüsselung zur Laufzeit.',
  ),

  // Angriffe
  karte(
    'k-za-1',
    'sz-angriffe',
    'Social Engineering',
    'Manipulation von Menschen statt Angriff auf Technik - über Hilfsbereitschaft, Autorität, Zeitdruck oder Neugier.',
  ),
  karte(
    'k-za-2',
    'sz-angriffe',
    'Spear-Phishing',
    'Gezielt auf eine Person oder Firma zugeschnittene Phishing-Nachricht.',
  ),
  karte(
    'k-za-3',
    'sz-angriffe',
    'CEO-Fraud',
    'Angebliche Geschäftsführung fordert eine eilige, vertrauliche Überweisung.',
    'Schutz: Vier-Augen-Prinzip und Rückruf über bekannte Nummer.',
  ),
  karte(
    'k-za-4',
    'sz-angriffe',
    'DoS vs. DDoS',
    'DoS: Überlastung eines Dienstes aus einer Quelle. DDoS: aus vielen Quellen, meist einem Botnetz.',
  ),
  karte(
    'k-za-5',
    'sz-angriffe',
    'Man-in-the-Middle',
    'Angreifer schaltet sich unbemerkt zwischen zwei Partner und kann mitlesen oder verändern.',
  ),
  karte(
    'k-za-6',
    'sz-angriffe',
    'SQL-Injection',
    'Formulareingabe wird als Teil einer Datenbankabfrage ausgeführt. Schutz: Eingaben prüfen, vorbereitete Abfragen.',
  ),
  karte(
    'k-za-7',
    'sz-angriffe',
    'Cross-Site-Scripting (XSS)',
    'Eingeschleuster Skriptcode läuft im Browser anderer Nutzer. Schutz: Ausgaben maskieren, Eingaben prüfen.',
  ),
  karte(
    'k-za-8',
    'sz-angriffe',
    'Credential Stuffing',
    'Erbeutete Zugangsdaten eines Dienstes werden bei anderen Diensten ausprobiert. Schutz: je Dienst eigenes Passwort, MFA.',
  ),

  // Schutzbedarf
  karte(
    'k-zb-1',
    'sz-schutzbedarf',
    'Schutzbedarfskategorien (BSI)',
    'normal: begrenzt, überschaubar. hoch: beträchtlich. sehr hoch: existenziell bedrohlich.',
  ),
  karte(
    'k-zb-2',
    'sz-schutzbedarf',
    'Maximumprinzip',
    'Der höchste Schutzbedarf der Anwendungen gilt für das ganze System.',
  ),
  karte(
    'k-zb-3',
    'sz-schutzbedarf',
    'Kumulationseffekt',
    'Viele kleine Schäden summieren sich - der Schutzbedarf des Systems steigt.',
  ),
  karte(
    'k-zb-4',
    'sz-schutzbedarf',
    'Verteilungseffekt',
    'Eine Anwendung läuft redundant auf mehreren Systemen - ein einzelnes System kann niedriger eingestuft werden.',
  ),
  karte(
    'k-zb-5',
    'sz-schutzbedarf',
    'Vererbung des Schutzbedarfs',
    'Geschäftsprozess -> Anwendung -> IT-System -> Raum.',
  ),
  karte(
    'k-zb-6',
    'sz-schutzbedarf',
    'Vorgehen Standard-Absicherung (BSI 200-2)',
    'Strukturanalyse, Schutzbedarfsfeststellung, Modellierung, IT-Grundschutz-Check, Risikoanalyse, Umsetzung.',
  ),
  karte(
    'k-zb-7',
    'sz-schutzbedarf',
    'Die sechs Schadensszenarien',
    'Rechtsverstöße, informationelle Selbstbestimmung, persönliche Unversehrtheit, Aufgabenerfüllung, Innen-/Außenwirkung, Finanzen.',
  ),
  karte(
    'k-zb-8',
    'sz-schutzbedarf',
    'Basis-, Kern-, Standard-Absicherung',
    'Basis: schneller Einstieg überall. Kern: zuerst die Kronjuwelen. Standard: umfassend nach vollständiger Methodik.',
  ),

  // Firewall
  karte(
    'k-yf-1',
    'sm-firewall',
    'Paketfilter (zustandslos)',
    'Prüft jedes Paket einzeln nach IP-Adressen, Ports und Protokoll (Schicht 3 und 4).',
  ),
  karte(
    'k-yf-2',
    'sm-firewall',
    'Stateful Inspection',
    'Merkt sich Verbindungen und lässt passende Antwortpakete automatisch durch.',
  ),
  karte(
    'k-yf-3',
    'sm-firewall',
    'Application-Level-Gateway',
    'Proxy, der Inhalte des Anwendungsprotokolls prüft (Schicht 7).',
  ),
  karte(
    'k-yf-4',
    'sm-firewall',
    'DMZ',
    'Eigenes Netzsegment für aus dem Internet erreichbare Server, getrennt vom internen LAN.',
  ),
  karte(
    'k-yf-5',
    'sm-firewall',
    'Default Deny',
    'Letzte Regel: Alles, was nicht ausdrücklich erlaubt ist, wird verworfen.',
  ),
  karte(
    'k-yf-6',
    'sm-firewall',
    'IDS vs. IPS',
    'IDS erkennt Angriffe und meldet sie (passiv). IPS erkennt und blockiert sie (aktiv im Datenstrom).',
  ),
  karte(
    'k-yf-7',
    'sm-firewall',
    'Ports 22, 25, 53, 443, 3389',
    'SSH, SMTP, DNS, HTTPS, RDP.',
  ),
  karte(
    'k-yf-8',
    'sm-firewall',
    'Client-to-Site vs. Site-to-Site-VPN',
    'Client-to-Site: einzelnes Gerät ins Firmennetz (Homeoffice). Site-to-Site: zwei Standorte dauerhaft gekoppelt.',
  ),

  // Datensicherung
  karte(
    'k-yb-1',
    'sm-backup',
    'Inkrementelle Sicherung',
    'Sichert Änderungen seit der letzten Sicherung jeder Art. Restore: Voll + alle Inkremente.',
  ),
  karte(
    'k-yb-2',
    'sm-backup',
    'Differenzielle Sicherung',
    'Sichert Änderungen seit der letzten Vollsicherung. Restore: Voll + letzte differenzielle.',
  ),
  karte(
    'k-yb-3',
    'sm-backup',
    '3-2-1-Regel',
    '3 Kopien, 2 verschiedene Speichermedien, 1 Kopie außer Haus.',
  ),
  karte(
    'k-yb-4',
    'sm-backup',
    'Großvater-Vater-Sohn',
    'Generationenprinzip: tägliche (Sohn), wöchentliche (Vater) und monatliche (Großvater) Sicherungen.',
  ),
  karte(
    'k-yb-5',
    'sm-backup',
    'RPO vs. RTO',
    'RPO: maximal hinnehmbarer Datenverlust. RTO: maximale Zeit bis zum Wiederanlauf.',
  ),
  karte(
    'k-yb-6',
    'sm-backup',
    'Archivbit',
    'Dateimerkmal, das bei Änderung gesetzt wird. Voll und inkrementell setzen es zurück, differenziell nicht.',
  ),
  karte(
    'k-yb-7',
    'sm-backup',
    'Speicherbedarf differenziell (Beispiel)',
    '10 GB Änderung pro Tag, Mo bis Sa: 10 + 20 + 30 + 40 + 50 + 60 = 210 GB plus Vollsicherung.',
  ),
  karte(
    'k-yb-8',
    'sm-backup',
    'Warum ist Synchronisation kein Backup?',
    'Sie übernimmt Löschungen und Verschlüsselung durch Ransomware sofort und bewahrt keine alten Stände.',
  ),

  // WLAN
  karte(
    'k-yw-1',
    'sm-wlan',
    'WEP, WPA/TKIP',
    'Veraltet und unsicher - nicht mehr verwenden.',
  ),
  karte(
    'k-yw-2',
    'sm-wlan',
    'WPA3-Personal',
    'Anmeldung mit SAE - verhindert Offline-Wörterbuchangriffe auf das WLAN-Passwort.',
  ),
  karte(
    'k-yw-3',
    'sm-wlan',
    '802.1X',
    'Portbasierte Anmeldung: Supplicant, Authenticator (Access Point) und RADIUS-Server.',
  ),
  karte(
    'k-yw-4',
    'sm-wlan',
    'Warum WPS abschalten?',
    'Die PIN wird in zwei Hälften geprüft - höchstens 11.000 Versuche genügen.',
  ),
  karte(
    'k-yw-5',
    'sm-wlan',
    'Gastnetz',
    'Eigenes WLAN, meist eigenes VLAN, nur mit Internetzugang - getrennt vom internen Netz.',
  ),
  karte(
    'k-yw-6',
    'sm-wlan',
    'Personal vs. Enterprise',
    'Personal: ein gemeinsames Passwort. Enterprise: persönliche Zugangsdaten je Person, Prüfung per RADIUS über 802.1X.',
  ),
  karte(
    'k-yw-7',
    'sm-wlan',
    'Evil Twin',
    'Gefälschter Access Point mit dem Namen (SSID) eines echten WLANs, um Verkehr abzufangen.',
  ),
  karte(
    'k-yw-8',
    'sm-wlan',
    'Versteckte SSID und MAC-Filter',
    'Scheinsicherheit: SSID ist trotzdem sichtbar, MAC-Adressen lassen sich fälschen.',
  ),

  // Zugriffsschutz und Härtung
  karte(
    'k-yz-1',
    'sm-zugriff',
    'Zutritt / Zugang / Zugriff',
    'Zutritt: Räume. Zugang: IT-Systeme. Zugriff: bestimmte Daten und Funktionen.',
  ),
  karte(
    'k-yz-2',
    'sm-zugriff',
    'Minimalprinzip',
    'Jedes Konto erhält nur die Rechte, die es für seine Aufgabe braucht (Least Privilege).',
  ),
  karte(
    'k-yz-3',
    'sm-zugriff',
    'Need-to-know',
    'Jede Person erhält nur die Informationen, die sie für ihre Aufgabe braucht.',
  ),
  karte(
    'k-yz-4',
    'sm-zugriff',
    'RBAC',
    'Rollenbasierte Rechtevergabe: Rechte hängen an Rollen, Personen erhalten Rollen.',
  ),
  karte(
    'k-yz-5',
    'sm-zugriff',
    'Härtung',
    'Angriffsfläche verkleinern: unnötige Dienste und Ports aus, Standardpasswörter ändern, Updates einspielen.',
  ),
  karte(
    'k-yz-6',
    'sm-zugriff',
    'DAC vs. MAC',
    'DAC: Besitzer vergibt Rechte an eigenen Dateien. MAC: System erzwingt feste Sicherheitsstufen.',
  ),
  karte(
    'k-yz-7',
    'sm-zugriff',
    'Defense in Depth',
    'Verteidigung in mehreren unabhängigen Schichten: Gebäude, Netz, System, Anwendung, Daten, Menschen.',
  ),
  karte(
    'k-yz-8',
    'sm-zugriff',
    'Rechte bei Abteilungswechsel',
    'Alte Rolle entziehen, neue zuordnen - sonst sammeln sich Rechte an.',
  ),
];
