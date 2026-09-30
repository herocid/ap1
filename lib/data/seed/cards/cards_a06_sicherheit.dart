import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 06, Teil 1: Schutzziele, Bedrohungen und
/// technische Schutzmaßnahmen.
final List<Flashcard> cardsA06Sicherheit = [
  // Schutzziele
  karte('k-zz-1', 'sz-schutzziele', 'Vertraulichkeit',
      'Nur befugte Personen können die Daten lesen.'),
  karte('k-zz-2', 'sz-schutzziele', 'Integrität',
      'Daten sind korrekt und unverändert - Änderungen werden bemerkt.'),
  karte('k-zz-3', 'sz-schutzziele', 'Verfügbarkeit',
      'Systeme und Daten sind nutzbar, wenn sie gebraucht werden.'),
  karte('k-zz-4', 'sz-schutzziele', 'Authentizität vs. Verbindlichkeit',
      'Authentizität: Echtheit und Herkunft sind prüfbar. Verbindlichkeit: Eine Handlung kann nicht abgestritten werden.'),
  karte('k-zz-5', 'sz-schutzziele', '99,9 % Verfügbarkeit (24/7)',
      '0,001 × 8.760 h = 8,76 h Ausfall pro Jahr erlaubt.'),

  // Schadsoftware
  karte('k-zm-1', 'sz-schadsoftware', 'Virus',
      'Hängt sich an eine Wirtsdatei und wird aktiv, wenn diese ausgeführt wird.'),
  karte('k-zm-2', 'sz-schadsoftware', 'Wurm',
      'Verbreitet sich selbstständig über das Netz, meist über Sicherheitslücken - ohne Wirtsdatei.'),
  karte('k-zm-3', 'sz-schadsoftware', 'Trojaner',
      'Als nützliches Programm getarnt, wird vom Nutzer selbst installiert und verbreitet sich nicht selbst.'),
  karte('k-zm-4', 'sz-schadsoftware', 'Ransomware',
      'Verschlüsselt Daten und fordert Lösegeld für die Entschlüsselung.'),
  karte('k-zm-5', 'sz-schadsoftware', 'Rootkit und Botnetz',
      'Rootkit: versteckt Schadsoftware tief im System. Botnetz: viele ferngesteuerte Rechner, z. B. für DDoS.'),

  // Angriffe
  karte('k-za-1', 'sz-angriffe', 'Social Engineering',
      'Manipulation von Menschen statt Angriff auf Technik - über Hilfsbereitschaft, Autorität, Zeitdruck oder Neugier.'),
  karte('k-za-2', 'sz-angriffe', 'Spear-Phishing',
      'Gezielt auf eine Person oder Firma zugeschnittene Phishing-Nachricht.'),
  karte('k-za-3', 'sz-angriffe', 'CEO-Fraud',
      'Angebliche Geschäftsführung fordert eine eilige, vertrauliche Überweisung.',
      'Schutz: Vier-Augen-Prinzip und Rückruf über bekannte Nummer.'),
  karte('k-za-4', 'sz-angriffe', 'DoS vs. DDoS',
      'DoS: Überlastung eines Dienstes aus einer Quelle. DDoS: aus vielen Quellen, meist einem Botnetz.'),
  karte('k-za-5', 'sz-angriffe', 'Man-in-the-Middle',
      'Angreifer schaltet sich unbemerkt zwischen zwei Partner und kann mitlesen oder verändern.'),

  // Schutzbedarf
  karte('k-zb-1', 'sz-schutzbedarf', 'Schutzbedarfskategorien (BSI)',
      'normal: begrenzt, überschaubar. hoch: beträchtlich. sehr hoch: existenziell bedrohlich.'),
  karte('k-zb-2', 'sz-schutzbedarf', 'Maximumprinzip',
      'Der höchste Schutzbedarf der Anwendungen gilt für das ganze System.'),
  karte('k-zb-3', 'sz-schutzbedarf', 'Kumulationseffekt',
      'Viele kleine Schäden summieren sich - der Schutzbedarf des Systems steigt.'),
  karte('k-zb-4', 'sz-schutzbedarf', 'Verteilungseffekt',
      'Eine Anwendung läuft redundant auf mehreren Systemen - ein einzelnes System kann niedriger eingestuft werden.'),
  karte('k-zb-5', 'sz-schutzbedarf', 'Vererbung des Schutzbedarfs',
      'Geschäftsprozess -> Anwendung -> IT-System -> Raum.'),

  // Firewall
  karte('k-yf-1', 'sm-firewall', 'Paketfilter (zustandslos)',
      'Prüft jedes Paket einzeln nach IP-Adressen, Ports und Protokoll (Schicht 3 und 4).'),
  karte('k-yf-2', 'sm-firewall', 'Stateful Inspection',
      'Merkt sich Verbindungen und lässt passende Antwortpakete automatisch durch.'),
  karte('k-yf-3', 'sm-firewall', 'Application-Level-Gateway',
      'Proxy, der Inhalte des Anwendungsprotokolls prüft (Schicht 7).'),
  karte('k-yf-4', 'sm-firewall', 'DMZ',
      'Eigenes Netzsegment für aus dem Internet erreichbare Server, getrennt vom internen LAN.'),
  karte('k-yf-5', 'sm-firewall', 'Default Deny',
      'Letzte Regel: Alles, was nicht ausdrücklich erlaubt ist, wird verworfen.'),

  // Datensicherung
  karte('k-yb-1', 'sm-backup', 'Inkrementelle Sicherung',
      'Sichert Änderungen seit der letzten Sicherung jeder Art. Restore: Voll + alle Inkremente.'),
  karte('k-yb-2', 'sm-backup', 'Differenzielle Sicherung',
      'Sichert Änderungen seit der letzten Vollsicherung. Restore: Voll + letzte differenzielle.'),
  karte('k-yb-3', 'sm-backup', '3-2-1-Regel',
      '3 Kopien, 2 verschiedene Speichermedien, 1 Kopie außer Haus.'),
  karte('k-yb-4', 'sm-backup', 'Großvater-Vater-Sohn',
      'Generationenprinzip: tägliche (Sohn), wöchentliche (Vater) und monatliche (Großvater) Sicherungen.'),
  karte('k-yb-5', 'sm-backup', 'RPO vs. RTO',
      'RPO: maximal hinnehmbarer Datenverlust. RTO: maximale Zeit bis zum Wiederanlauf.'),

  // WLAN
  karte('k-yw-1', 'sm-wlan', 'WEP, WPA/TKIP',
      'Veraltet und unsicher - nicht mehr verwenden.'),
  karte('k-yw-2', 'sm-wlan', 'WPA3-Personal',
      'Anmeldung mit SAE - verhindert Offline-Wörterbuchangriffe auf das WLAN-Passwort.'),
  karte('k-yw-3', 'sm-wlan', '802.1X',
      'Portbasierte Anmeldung: Supplicant, Authenticator (Access Point) und RADIUS-Server.'),
  karte('k-yw-4', 'sm-wlan', 'Warum WPS abschalten?',
      'Die PIN wird in zwei Hälften geprüft - höchstens 11.000 Versuche genügen.'),
  karte('k-yw-5', 'sm-wlan', 'Gastnetz',
      'Eigenes WLAN, meist eigenes VLAN, nur mit Internetzugang - getrennt vom internen Netz.'),

  // Zugriffsschutz und Härtung
  karte('k-yz-1', 'sm-zugriff', 'Zutritt / Zugang / Zugriff',
      'Zutritt: Räume. Zugang: IT-Systeme. Zugriff: bestimmte Daten und Funktionen.'),
  karte('k-yz-2', 'sm-zugriff', 'Minimalprinzip',
      'Jedes Konto erhält nur die Rechte, die es für seine Aufgabe braucht (Least Privilege).'),
  karte('k-yz-3', 'sm-zugriff', 'Need-to-know',
      'Jede Person erhält nur die Informationen, die sie für ihre Aufgabe braucht.'),
  karte('k-yz-4', 'sm-zugriff', 'RBAC',
      'Rollenbasierte Rechtevergabe: Rechte hängen an Rollen, Personen erhalten Rollen.'),
  karte('k-yz-5', 'sm-zugriff', 'Härtung',
      'Angriffsfläche verkleinern: unnötige Dienste und Ports aus, Standardpasswörter ändern, Updates einspielen.'),
];
