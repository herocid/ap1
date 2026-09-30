import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 06, Teil 2: Kryptographie, Authentifizierung und Datenschutz.
final List<Flashcard> cardsA06Krypto = [
  // Symmetrische Verschlüsselung
  karte('k-cs-1', 'kr-symmetrisch', 'Symmetrische Verschlüsselung',
      'Sender und Empfänger nutzen denselben geheimen Schlüssel zum Ver- und Entschlüsseln.'),
  karte('k-cs-2', 'kr-symmetrisch', 'AES - Schlüssellängen',
      '128, 192 oder 256 Bit. AES ist der aktuelle Standard für symmetrische Verschlüsselung.'),
  karte('k-cs-3', 'kr-symmetrisch', 'Schlüssel bei n Personen (symm.)',
      'n × (n - 1) / 2 - bei 10 Personen also 45 Schlüssel.'),
  karte('k-cs-4', 'kr-symmetrisch', 'Schlüsselaustauschproblem',
      'Der gemeinsame Schlüssel muss vorab auf einem sicheren Weg zum Gegenüber gelangen.'),
  karte('k-cs-5', 'kr-symmetrisch', 'Warum ist DES veraltet?',
      'Sein Schlüssel hat nur 56 Bit und lässt sich heute durch Ausprobieren knacken.'),

  // Asymmetrische Verschlüsselung
  karte('k-ca-1', 'kr-asymmetrisch', 'Vertraulich an Anna senden',
      'Mit Annas öffentlichem Schlüssel verschlüsseln - nur Annas privater Schlüssel entschlüsselt.'),
  karte('k-ca-2', 'kr-asymmetrisch', 'Digitale Signatur erstellen',
      'Hashwert des Dokuments mit dem eigenen privaten Schlüssel signieren.'),
  karte('k-ca-3', 'kr-asymmetrisch', 'Digitale Signatur prüfen',
      'Mit dem öffentlichen Schlüssel des Absenders prüfen und den Hashwert vergleichen.'),
  karte('k-ca-4', 'kr-asymmetrisch', 'Schlüssel bei n Personen (asymm.)',
      '2 × n - jede Person hat genau ein Schlüsselpaar.'),
  karte('k-ca-5', 'kr-asymmetrisch', 'RSA und ECC',
      'Asymmetrische Verfahren. ECC erreicht dieselbe Sicherheit mit deutlich kürzeren Schlüsseln.'),

  // Hybride Verfahren und Zertifikate
  karte('k-ch-1', 'kr-hybrid', 'Hybride Verschlüsselung',
      'Daten symmetrisch mit Sitzungsschlüssel, Schlüsselaustausch und Echtheitsnachweis asymmetrisch.'),
  karte('k-ch-2', 'kr-hybrid', 'Sitzungsschlüssel bei TLS 1.3',
      'Wird per Diffie-Hellman (ECDHE) ausgehandelt, nicht mit RSA verschlüsselt übertragen.'),
  karte('k-ch-3', 'kr-hybrid', 'Inhalt eines X.509-Zertifikats',
      'Inhaber, öffentlicher Schlüssel, Aussteller, Gültigkeitszeitraum, Seriennummer, Signatur der CA.',
      'Der private Schlüssel steht nie im Zertifikat.'),
  karte('k-ch-4', 'kr-hybrid', 'Certificate Authority (CA)',
      'Zertifizierungsstelle, die mit ihrer Signatur bestätigt, dass ein öffentlicher Schlüssel zu einem Namen gehört.'),
  karte('k-ch-5', 'kr-hybrid', 'S/MIME vs. PGP',
      'Beide sichern E-Mails. S/MIME vertraut CAs, PGP dem Web of Trust.'),

  // Hashverfahren
  karte('k-cx-1', 'kr-hash', 'Eigenschaften einer Hashfunktion',
      'Einwegfunktion, feste Länge, Lawineneffekt, Kollisionsresistenz.'),
  karte('k-cx-2', 'kr-hash', 'SHA-256 in Hex',
      '256 Bit / 4 Bit je Zeichen = 64 Hexadezimalzeichen.'),
  karte('k-cx-3', 'kr-hash', 'Salt',
      'Zufallswert je Konto, der vor dem Hashen an das Passwort gehängt wird - gleiche Passwörter ergeben so verschiedene Hashes.'),
  karte('k-cx-4', 'kr-hash', 'Passwort-Hashverfahren',
      'Bewusst langsame Verfahren wie Argon2 oder bcrypt, nicht einfaches SHA-256.'),
  karte('k-cx-5', 'kr-hash', 'Veraltete Hashverfahren',
      'MD5 und SHA-1 - für beide wurden Kollisionen gefunden.'),

  // Authentifizierung und 2FA
  karte('k-cz-1', 'kr-auth', 'Die drei Schritte beim Login',
      'Identifikation: Wer bist du? Authentifizierung: Beweise es! Autorisierung: Was darfst du?'),
  karte('k-cz-2', 'kr-auth', 'Die drei Faktorkategorien',
      'Wissen (Passwort), Besitz (Smartphone, Token), Inhärenz (Fingerabdruck).'),
  karte('k-cz-3', 'kr-auth', 'Echte 2FA',
      'Zwei Faktoren aus zwei verschiedenen Kategorien, z. B. Passwort und Code vom Smartphone.'),
  karte('k-cz-4', 'kr-auth', 'TOTP',
      'Zeitbasiertes Einmalpasswort aus gemeinsamem Geheimnis und Uhrzeit, meist 30 Sekunden gültig.'),
  karte('k-cz-5', 'kr-auth', 'Passkey',
      'FIDO2-Anmeldung per Schlüsselpaar. Der private Schlüssel bleibt auf dem Gerät - phishingresistent.'),

  // Personenbezogene Daten
  karte('k-xg-1', 'ds-grundlagen', 'Personenbezogene Daten (Art. 4)',
      'Alle Informationen über eine identifizierte oder identifizierbare natürliche Person.'),
  karte('k-xg-2', 'ds-grundlagen', 'Besondere Kategorien (Art. 9)',
      'Gesundheit, ethnische Herkunft, Religion, politische Meinung, Gewerkschaft, genetische und biometrische Daten, Sexualleben.'),
  karte('k-xg-3', 'ds-grundlagen', 'Verantwortlicher',
      'Entscheidet allein oder gemeinsam mit anderen über Zwecke und Mittel der Verarbeitung.'),
  karte('k-xg-4', 'ds-grundlagen', 'Auftragsverarbeiter',
      'Verarbeitet Daten im Auftrag und nach Weisung des Verantwortlichen, z. B. ein Hoster.'),
  karte('k-xg-5', 'ds-grundlagen', 'Ist eine IP-Adresse personenbezogen?',
      'In der Regel ja - sie lässt sich mit Zusatzwissen einem Anschluss und damit einer Person zuordnen.'),

  // Grundsätze der Verarbeitung
  karte('k-xs-1', 'ds-grundsaetze', 'Zweckbindung',
      'Daten nur für festgelegte, eindeutige Zwecke erheben und nicht zweckfremd weiterverarbeiten.'),
  karte('k-xs-2', 'ds-grundsaetze', 'Datenminimierung',
      'Nur so viele Daten erheben, wie für den Zweck nötig sind.'),
  karte('k-xs-3', 'ds-grundsaetze', 'Rechenschaftspflicht',
      'Der Verantwortliche muss die Einhaltung der Grundsätze nachweisen können.'),
  karte('k-xs-4', 'ds-grundsaetze', 'Rechtsgrundlagen nach Art. 6',
      'Einwilligung, Vertrag, rechtliche Verpflichtung, lebenswichtige Interessen, öffentliche Aufgabe, berechtigtes Interesse.'),
  karte('k-xs-5', 'ds-grundsaetze', 'Anforderungen an eine Einwilligung',
      'Freiwillig, informiert, eindeutig und jederzeit widerrufbar.'),

  // Rechte der Betroffenen
  karte('k-xr-1', 'ds-rechte', 'Art. 15 DSGVO',
      'Auskunftsrecht: welche Daten, zu welchem Zweck, an wen, wie lange - mit Kopie.'),
  karte('k-xr-2', 'ds-rechte', 'Art. 17 DSGVO',
      'Recht auf Löschung („Recht auf Vergessenwerden“), begrenzt z. B. durch Aufbewahrungspflichten.'),
  karte('k-xr-3', 'ds-rechte', 'Art. 20 DSGVO',
      'Datenübertragbarkeit: eigene Daten strukturiert und maschinenlesbar erhalten.'),
  karte('k-xr-4', 'ds-rechte', 'Antwortfrist bei Anfragen',
      'Unverzüglich, spätestens nach einem Monat - in komplexen Fällen um zwei Monate verlängerbar.'),
  karte('k-xr-5', 'ds-rechte', 'Art. 77 DSGVO',
      'Beschwerderecht bei einer Datenschutz-Aufsichtsbehörde.'),

  // Anonymisieren und Pseudonymisieren
  karte('k-xa-1', 'ds-anonym', 'Anonymisierung',
      'Personenbezug ist dauerhaft nicht mehr herstellbar - die DSGVO gilt nicht mehr.'),
  karte('k-xa-2', 'ds-anonym', 'Pseudonymisierung',
      'Name durch Kennzeichen ersetzt, Zuordnung mit getrennt aufbewahrtem Zusatzwissen möglich - DSGVO gilt weiter.'),
  karte('k-xa-3', 'ds-anonym', 'Generalisierung',
      'Werte vergröbern, z. B. Alter 34 -> „30 bis 39“ oder PLZ 10115 -> „10xxx“.'),
  karte('k-xa-4', 'ds-anonym', 'Aggregation',
      'Einzelwerte zu Summen oder Durchschnitten zusammenfassen, z. B. Gehalt je Abteilung.'),

  // Technische und organisatorische Maßnahmen
  karte('k-xt-1', 'ds-tom', 'TOM',
      'Technische und organisatorische Maßnahmen nach Art. 32 DSGVO zum Schutz personenbezogener Daten.'),
  karte('k-xt-2', 'ds-tom', 'Zutritt / Zugang / Zugriff',
      'Zutritt: Räume. Zugang: IT-Systeme. Zugriff: Daten und Berechtigungen.'),
  karte('k-xt-3', 'ds-tom', 'Eingabekontrolle',
      'Nachvollziehen, wer wann welche Daten eingegeben, geändert oder gelöscht hat - z. B. per Protokoll.'),
  karte('k-xt-4', 'ds-tom', 'Trennungsgebot',
      'Zu verschiedenen Zwecken erhobene Daten getrennt verarbeiten, z. B. Mandantentrennung.'),
  karte('k-xt-5', 'ds-tom', 'Technisch vs. organisatorisch',
      'Technisch: von der Technik durchgesetzt (Firewall). Organisatorisch: Regeln für Menschen (Schulung).'),
];
