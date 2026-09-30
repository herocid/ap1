import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 04, Teil 2: Datenmodellierung, Web, Daten und
/// Multimedia, KI-Grundlagen.
final List<Flashcard> cardsA04Daten = [
  // ER-Modell
  karte(
    'k-de-1',
    'dm-erm',
    'Entität vs. Entitätstyp',
    'Entität: ein einzelnes Objekt (Kundin Yilmaz). Entitätstyp: die Zusammenfassung gleichartiger Entitäten (Kunde).',
  ),
  karte(
    'k-de-2',
    'dm-erm',
    'Attribut',
    'Eigenschaft eines Entitätstyps, z. B. Name oder E-Mail eines Kunden.',
  ),
  karte(
    'k-de-3',
    'dm-erm',
    'Chen-Notation: Symbole',
    'Rechteck = Entitätstyp, Raute = Beziehung, Ellipse = Attribut, unterstrichen = Schlüsselattribut.',
  ),
  karte(
    'k-de-4',
    'dm-erm',
    'Kann eine Beziehung Attribute haben?',
    'Ja - z. B. „Menge“ an der Beziehung Bestellung „enthält“ Artikel.',
  ),
  karte(
    'k-de-5',
    'dm-erm',
    'Vom Text zum ERM',
    'Substantive mit eigenen Daten = Entitätstypen, Eigenschaften = Attribute, Verben = Beziehungen.',
  ),
  karte(
    'k-de-6',
    'dm-erm',
    'ERM -> Tabelle',
    'Entitätstyp = Tabelle, Entität = Zeile, Attribut = Spalte, Schlüsselattribut = Primärschlüssel.',
  ),
  karte(
    'k-de-7',
    'dm-erm',
    'Abgeleitetes Attribut',
    'Wird aus anderen Werten berechnet, z. B. Alter aus Geburtsdatum - wird nicht gespeichert.',
  ),

  // Kardinalitäten
  karte(
    'k-dk-1',
    'dm-kardinalitaet',
    '1:n - Beispiel',
    'Abteilung - Mitarbeiter: Eine Abteilung hat viele Mitarbeiter, jeder gehört zu genau einer Abteilung.',
  ),
  karte(
    'k-dk-2',
    'dm-kardinalitaet',
    'n:m auflösen',
    'Über eine Zwischentabelle mit den Primärschlüsseln beider Seiten als Fremdschlüssel -> zwei 1:n-Beziehungen.',
  ),
  karte(
    'k-dk-3',
    'dm-kardinalitaet',
    'Fremdschlüssel bei 1:n',
    'Kommt in die Tabelle der n-Seite, z. B. AbteilungsNr in Mitarbeiter.',
  ),
  karte(
    'k-dk-4',
    'dm-kardinalitaet',
    'Min-Max (0,n)',
    'Die Entität nimmt mindestens 0-mal (optional) und höchstens beliebig oft an der Beziehung teil.',
  ),
  karte(
    'k-dk-5',
    'dm-kardinalitaet',
    'Modifizierte Chen-Notation',
    '1 = genau eins, c = keins oder eins, m = mindestens eins, mc = beliebig viele (auch keins).',
  ),
  karte(
    'k-dk-6',
    'dm-kardinalitaet',
    'Kardinalität bestimmen',
    'Beide Richtungen lesen: Wie viele B hat ein A - und wie viele A hat ein B?',
  ),
  karte(
    'k-dk-7',
    'dm-kardinalitaet',
    '1:1 umsetzen',
    'Fremdschlüssel auf einer der beiden Seiten, der dort nur einmal vorkommen darf.',
  ),

  // Schlüssel
  karte(
    'k-dl-1',
    'dm-schluessel',
    'Primärschlüssel',
    'Identifiziert jeden Datensatz eindeutig, darf nie leer sein und sollte sich nicht ändern.',
  ),
  karte(
    'k-dl-2',
    'dm-schluessel',
    'Fremdschlüssel',
    'Spalte, die auf den Primärschlüssel einer anderen Tabelle verweist - darf sich wiederholen.',
  ),
  karte(
    'k-dl-3',
    'dm-schluessel',
    'Surrogatschlüssel',
    'Künstlicher Schlüssel ohne fachliche Bedeutung, vom System vergeben, z. B. fortlaufende KundenNr.',
  ),
  karte(
    'k-dl-4',
    'dm-schluessel',
    'Referenzielle Integrität',
    'Jeder Fremdschlüsselwert muss als Primärschlüssel in der referenzierten Tabelle existieren.',
  ),
  karte(
    'k-dl-5',
    'dm-schluessel',
    'Zusammengesetzter Schlüssel',
    'Primärschlüssel aus mehreren Spalten, z. B. BestellNr + ArtikelNr in Bestellposition.',
  ),
  karte(
    'k-dl-6',
    'dm-schluessel',
    'Alternativschlüssel',
    'Schlüsselkandidat, der nicht als Primärschlüssel gewählt wurde, z. B. Steuer-ID neben PersNr.',
  ),
  karte(
    'k-dl-7',
    'dm-schluessel',
    'Tabellenschreibweise',
    'Tabelle (Spalten), Primärschlüssel unterstrichen, Fremdschlüssel markiert: Bestellung (BestellNr, Datum, KundenNr FK).',
  ),

  // Normalisierung
  karte(
    'k-dn-1',
    'dm-normalisierung',
    '1NF',
    'Alle Attributwerte sind atomar, es gibt keine Wiederholungsgruppen.',
  ),
  karte(
    'k-dn-2',
    'dm-normalisierung',
    '2NF',
    '1NF und jedes Nichtschlüsselattribut hängt vom gesamten Primärschlüssel ab, nicht nur von einem Teil.',
  ),
  karte(
    'k-dn-3',
    'dm-normalisierung',
    '3NF',
    '2NF und kein Nichtschlüsselattribut hängt transitiv (über ein anderes Nichtschlüsselattribut) vom Schlüssel ab.',
  ),
  karte(
    'k-dn-4',
    'dm-normalisierung',
    'Die drei Anomalien',
    'Einfüge-, Änderungs- und Löschanomalie - Folgen von Redundanz in nicht normalisierten Tabellen.',
  ),
  karte(
    'k-dn-5',
    'dm-normalisierung',
    'Funktionale Abhängigkeit A -> B',
    'Zu jedem Wert von A gehört genau ein Wert von B, z. B. KundenNr -> Name.',
  ),
  karte(
    'k-dn-6',
    'dm-normalisierung',
    'Partielle Abhängigkeit',
    'Ein Attribut hängt nur von einem Teil eines zusammengesetzten Schlüssels ab - verletzt die 2NF.',
  ),
  karte(
    'k-dn-7',
    'dm-normalisierung',
    'Transitive Abhängigkeit',
    'Ein Attribut hängt über ein Nichtschlüsselattribut vom Schlüssel ab: BestNr -> KdNr -> Name - verletzt die 3NF.',
  ),

  // URL
  karte(
    'k-wu-1',
    'wi-url',
    'Reihenfolge der URL-Teile',
    'Schema :// Host : Port / Pfad ? Query # Fragment',
  ),
  karte('k-wu-2', 'wi-url', 'Standardports', 'http: 80, https: 443, ftp: 21.'),
  karte(
    'k-wu-3',
    'wi-url',
    'Fragment (#)',
    'Sprungmarke innerhalb der Seite - wird nicht an den Server übertragen.',
  ),
  karte(
    'k-wu-4',
    'wi-url',
    'Query (?)',
    'Parameter für den Server als Schlüssel=Wert-Paare, getrennt mit &, z. B. ?farbe=rot&seite=2.',
  ),
  karte(
    'k-wu-5',
    'wi-url',
    'Domainnamen lesen',
    'Von rechts: TLD, davor die Domain, links davon Subdomains - shop.example.com.',
  ),
  karte(
    'k-wu-6',
    'wi-url',
    'Prozentkodierung',
    '% und Bytewert in hex: Leerzeichen = %20, ä = %C3%A4.',
  ),
  karte(
    'k-wu-7',
    'wi-url',
    '../datei.html',
    'Relativer Pfad: eine Ordnerebene höher als die aktuelle Seite.',
  ),

  // HTTP
  karte(
    'k-wh-1',
    'wi-http',
    'GET, POST, PUT, DELETE',
    'Abrufen, Daten senden/Neues anlegen, Ressource ersetzen, Ressource löschen.',
  ),
  karte(
    'k-wh-2',
    'wi-http',
    'Statuscode-Klassen',
    '1xx Information, 2xx Erfolg, 3xx Umleitung, 4xx Client-Fehler, 5xx Server-Fehler.',
  ),
  karte(
    'k-wh-3',
    'wi-http',
    '401 vs. 403',
    '401: nicht (erfolgreich) angemeldet. 403: angemeldet bzw. bekannt, aber kein Zugriff erlaubt.',
  ),
  karte(
    'k-wh-4',
    'wi-http',
    'Zustandslos',
    'Jede HTTP-Anfrage steht für sich. Sitzungen werden z. B. über Cookies mit Sitzungs-ID gehalten.',
  ),
  karte(
    'k-wh-5',
    'wi-http',
    'HTTPS',
    'HTTP über eine mit TLS verschlüsselte Verbindung, Standardport 443.',
  ),
  karte(
    'k-wh-6',
    'wi-http',
    'GET vs. POST',
    'GET: Daten in der URL, für Abrufe und Suchen. POST: Daten im Body, für Formulare, Login, Upload.',
  ),
  karte(
    'k-wh-7',
    'wi-http',
    '301 vs. 302',
    '301: dauerhaft umgezogen. 302: vorübergehend woanders. Neue Adresse im Header Location.',
  ),
  karte(
    'k-wh-8',
    'wi-http',
    'Aufbau einer HTTP-Nachricht',
    'Startzeile, Header-Zeilen, Leerzeile, Body (Inhalt).',
  ),

  // Seitenaufruf
  karte(
    'k-wa-1',
    'wi-aufruf',
    'Ablauf Seitenaufruf',
    'URL -> DNS -> TCP-Handshake -> TLS-Handshake -> HTTP-Request -> Response -> Rendern und Nachladen.',
  ),
  karte(
    'k-wa-2',
    'wi-aufruf',
    '3-Way-Handshake',
    'SYN (Client) -> SYN-ACK (Server) -> ACK (Client). Danach steht die TCP-Verbindung.',
  ),
  karte(
    'k-wa-3',
    'wi-aufruf',
    'Aufgabe von DNS',
    'Übersetzt einen Hostnamen in die zugehörige IP-Adresse.',
  ),
  karte(
    'k-wa-4',
    'wi-aufruf',
    'TLS-Handshake',
    'Server weist sich per Zertifikat aus, beide Seiten handeln einen Sitzungsschlüssel aus.',
  ),
  karte(
    'k-wa-5',
    'wi-aufruf',
    'DNS: Port und Protokoll',
    'Port 53, normalerweise über UDP.',
  ),
  karte(
    'k-wa-6',
    'wi-aufruf',
    'DNS-Auflösung ohne Cache',
    'Resolver -> Root-Server -> TLD-Server -> autoritativer Nameserver -> IP-Adresse.',
  ),
  karte(
    'k-wa-7',
    'wi-aufruf',
    'TTL bei DNS',
    'Gültigkeitsdauer eines Eintrags im Cache - danach wird neu gefragt.',
  ),

  // HTML und CSS
  karte(
    'k-wt-1',
    'wi-html',
    'HTML, CSS, JavaScript',
    'HTML: Struktur und Bedeutung. CSS: Gestaltung. JavaScript: Verhalten.',
  ),
  karte(
    'k-wt-2',
    'wi-html',
    'Aufbau einer CSS-Regel',
    'Selektor { Eigenschaft: Wert; } - z. B. h1 { color: navy; }',
  ),
  karte(
    'k-wt-3',
    'wi-html',
    'Klasse vs. ID',
    'Klasse (.name) beliebig oft pro Seite, ID (#name) genau einmal pro Seite.',
  ),
  karte(
    'k-wt-4',
    'wi-html',
    'Media Query',
    'CSS-Regel mit Bedingung, z. B. @media (max-width: 600px) - Grundlage für responsives Design.',
  ),
  karte(
    'k-wt-5',
    'wi-html',
    'HTML-Grundgerüst',
    '<!DOCTYPE html>, <html lang="de">, <head> mit meta charset und title, <body> mit dem sichtbaren Inhalt.',
  ),
  karte(
    'k-wt-6',
    'wi-html',
    'CSS-Box-Modell',
    'Von außen nach innen: margin, border, padding, content.',
  ),
  karte(
    'k-wt-7',
    'wi-html',
    'Welche CSS-Regel gewinnt?',
    'Die spezifischere: ID vor Klasse vor Element. Bei Gleichstand die spätere Regel.',
  ),
  karte(
    'k-wt-8',
    'wi-html',
    'Formularfeld wird nicht gesendet',
    'Es fehlt das Attribut name - nur Felder mit name werden als name=wert übertragen.',
  ),

  // Barrierefreiheit
  karte(
    'k-wf-1',
    'wi-barrierefrei',
    'WCAG-Prinzipien',
    'Wahrnehmbar, bedienbar, verständlich, robust.',
  ),
  karte(
    'k-wf-2',
    'wi-barrierefrei',
    'BITV 2.0',
    'Verordnung zur Barrierefreiheit von Websites und Apps öffentlicher Stellen des Bundes.',
  ),
  karte(
    'k-wf-3',
    'wi-barrierefrei',
    'BFSG',
    'Barrierefreiheitsstärkungsgesetz: seit 28.06.2025 Pflicht für viele Produkte und Dienste privater Anbieter, z. B. Online-Shops.',
  ),
  karte(
    'k-wf-4',
    'wi-barrierefrei',
    'Alt-Text',
    'Textalternative für Bilder. Beschreibt Inhalt oder Zweck; dekorative Bilder bekommen alt="".',
  ),
  karte(
    'k-wf-5',
    'wi-barrierefrei',
    'Mindestkontrast (WCAG AA)',
    '4,5:1 für normalen Text, 3:1 für großen Text.',
  ),
  karte(
    'k-wf-6',
    'wi-barrierefrei',
    'WCAG-Konformitätsstufen',
    'A: Grundanforderungen, AA: gesetzlicher Standard, AAA: höchste Stufe (z. B. Kontrast 7:1).',
  ),
  karte(
    'k-wf-7',
    'wi-barrierefrei',
    'label im Formular',
    'Sichtbare Beschriftung, per for/id mit dem Feld verknüpft - ein Platzhalter ersetzt sie nicht.',
  ),

  // Zahlensysteme
  karte(
    'k-mz-1',
    'md-zahlensysteme',
    'Stellenwerte eines Bytes',
    '128, 64, 32, 16, 8, 4, 2, 1 - von links nach rechts.',
  ),
  karte(
    'k-mz-2',
    'md-zahlensysteme',
    'Nibble-Trick',
    'Je 4 Bit ergeben eine Hex-Ziffer: 1001 1100 = 9C.',
  ),
  karte(
    'k-mz-3',
    'md-zahlensysteme',
    'Hex-Ziffern A bis F',
    'A = 10, B = 11, C = 12, D = 13, E = 14, F = 15.',
  ),
  karte(
    'k-mz-4',
    'md-zahlensysteme',
    'Divisionsrestverfahren',
    'Wiederholt durch die Basis teilen, Reste von unten nach oben lesen.',
  ),
  karte(
    'k-mz-5',
    'md-zahlensysteme',
    'Zweierkomplement bilden',
    'Betrag binär schreiben, alle Bits umkehren, 1 addieren. 8 Bit: -128 bis +127.',
  ),
  karte(
    'k-mz-6',
    'md-zahlensysteme',
    'Wie viele Werte in n Bit?',
    '2^n Werte, ohne Vorzeichen 0 bis 2^n - 1. 8 Bit: 256 Werte (0-255).',
  ),
  karte(
    'k-mz-7',
    'md-zahlensysteme',
    'Binär <-> oktal',
    'Je 3 Bit ergeben eine Oktalziffer: 110 101 = 65 (oktal) = 53 (dezimal).',
  ),
  karte(
    'k-mz-8',
    'md-zahlensysteme',
    'Binär: 1 + 1',
    '= 0 mit Übertrag 1 (binär 10). 1 + 1 + 1 = 1 mit Übertrag 1.',
  ),

  // Zeichensätze
  karte(
    'k-mc-1',
    'md-zeichen',
    'ASCII',
    '7 Bit, 128 Zeichen - ohne Umlaute. „A“ = 65, „a“ = 97, „0“ = 48.',
  ),
  karte(
    'k-mc-2',
    'md-zeichen',
    'UTF-8',
    'Kodierung für Unicode mit 1 bis 4 Byte je Zeichen, ASCII-kompatibel. Umlaute: 2 Byte, €: 3 Byte.',
  ),
  karte(
    'k-mc-3',
    'md-zeichen',
    'Unicode-Codepoint',
    'Eindeutige Nummer eines Zeichens, geschrieben als U+hex, z. B. ä = U+00E4.',
  ),
  karte(
    'k-mc-4',
    'md-zeichen',
    'Mojibake',
    'Zeichensalat durch falsch interpretierte Kodierung, z. B. UTF-8 als Latin-1: „Ã¼“ statt „ü“.',
  ),
  karte(
    'k-mc-5',
    'md-zeichen',
    'ASCII-Bereiche',
    'Leerzeichen 32, Ziffern 48-57, A-Z 65-90, a-z 97-122.',
  ),
  karte(
    'k-mc-6',
    'md-zeichen',
    'UTF-8: Byte je Zeichen',
    'Bis U+007F: 1, bis U+07FF: 2, bis U+FFFF: 3, darüber: 4 Byte.',
  ),
  karte(
    'k-mc-7',
    'md-zeichen',
    'Zeichensatz vs. Kodierung',
    'Zeichensatz: welche Nummer ein Zeichen hat (Unicode). Kodierung: wie die Nummer als Bytes gespeichert wird (UTF-8).',
  ),

  // Datenmengen
  karte(
    'k-md-1',
    'md-datenmengen',
    'Datenmenge Bild',
    'Breite × Höhe × Farbtiefe (Bit), durch 8 für Byte.',
  ),
  karte(
    'k-md-2',
    'md-datenmengen',
    'Datenmenge Audio',
    'Abtastrate × Bittiefe × Kanäle × Sekunden (Bit).',
  ),
  karte(
    'k-md-3',
    'md-datenmengen',
    'Datenmenge Video (unkomprimiert)',
    'Breite × Höhe × Farbtiefe × Bilder pro Sekunde × Sekunden (Bit).',
  ),
  karte(
    'k-md-4',
    'md-datenmengen',
    'kB vs. KiB',
    '1 kB = 1.000 Byte (dezimal), 1 KiB = 1.024 Byte (binär).',
  ),
  karte(
    'k-md-5',
    'md-datenmengen',
    '1 MiB in Byte',
    '1.024² = 1.048.576 Byte (1 MB = 1.000.000 Byte).',
  ),
  karte(
    'k-md-6',
    'md-datenmengen',
    '1 GiB in Byte',
    '1.024³ = 1.073.741.824 Byte (1 GB = 1.000.000.000 Byte).',
  ),
  karte(
    'k-md-7',
    'md-datenmengen',
    'Größe aus der Bitrate',
    'Bitrate × Dauer in s, dann durch 8: 320 kbit/s × 240 s = 9,6 MB.',
  ),
  karte(
    'k-md-8',
    'md-datenmengen',
    'CD-Qualität',
    '44,1 kHz, 16 Bit, Stereo = 1.411,2 kbit/s - rund 10,6 MB pro Minute.',
  ),

  // Übertragung
  karte(
    'k-mu-1',
    'md-uebertragung',
    'Übertragungsdauer',
    'Dauer = Datenmenge in Bit / Datenrate in Bit pro Sekunde.',
  ),
  karte(
    'k-mu-2',
    'md-uebertragung',
    '1 Mbit/s',
    '1.000.000 Bit pro Sekunde - Datenraten werden dezimal angegeben.',
  ),
  karte(
    'k-mu-3',
    'md-uebertragung',
    'MB -> Mbit',
    'Mal 8: 500 MB = 4.000 Mbit.',
  ),
  karte(
    'k-mu-4',
    'md-uebertragung',
    'Upload vs. Download',
    'Beim Hochladen, z. B. Cloud-Backup, zählt die meist kleinere Upload-Rate.',
  ),
  karte(
    'k-mu-5',
    'md-uebertragung',
    'Nötige Datenrate',
    'Datenrate = Datenmenge in Bit / Zeit in Sekunden.',
  ),
  karte(
    'k-mu-6',
    'md-uebertragung',
    'MB/s -> Mbit/s',
    'Mal 8: 12,5 MB/s = 100 Mbit/s.',
  ),
  karte(
    'k-mu-7',
    'md-uebertragung',
    'Overhead einrechnen',
    'Nutzdatenrate = Datenrate × Nutzanteil, z. B. 100 Mbit/s × 0,8 = 80 Mbit/s.',
  ),

  // Kompression
  karte(
    'k-mx-1',
    'md-kompression',
    'Verlustfreie Formate',
    'ZIP, PNG, FLAC - das Original lässt sich exakt wiederherstellen.',
  ),
  karte(
    'k-mx-2',
    'md-kompression',
    'Verlustbehaftete Formate',
    'JPEG, MP3, AAC, H.264, H.265 - Details werden dauerhaft weggelassen.',
  ),
  karte(
    'k-mx-3',
    'md-kompression',
    'RLE',
    'Lauflängenkodierung: Folgen gleicher Zeichen als Anzahl + Zeichen, z. B. AAAAA -> 5A.',
  ),
  karte(
    'k-mx-4',
    'md-kompression',
    'SVG',
    'Vektorformat: beliebig skalierbar ohne Qualitätsverlust - ideal für Logos und Icons.',
  ),
  karte(
    'k-mx-5',
    'md-kompression',
    'Einsparung in Prozent',
    '(1 - komprimiert / Original) × 100 %. Faktor = Original / komprimiert.',
  ),
  karte(
    'k-mx-6',
    'md-kompression',
    'Huffman-Kodierung',
    'Verlustfrei: häufige Zeichen bekommen kurze Codes, seltene lange.',
  ),
  karte(
    'k-mx-7',
    'md-kompression',
    'Container vs. Codec',
    'Container (MP4, MKV) bündelt Spuren, der Codec (H.264, AAC) komprimiert sie.',
  ),

  // KI-Grundlagen
  karte(
    'k-ig-1',
    'ki-grundlagen',
    'Schwache vs. starke KI',
    'Schwach: löst bestimmte Aufgaben (alle heutigen Systeme). Stark: allgemeine, menschenähnliche Intelligenz - gibt es bisher nicht.',
  ),
  karte(
    'k-ig-2',
    'ki-grundlagen',
    'Überwachtes Lernen',
    'Lernen aus Beispielen mit bekannter richtiger Antwort (Label), z. B. markierte Spam-Mails.',
  ),
  karte(
    'k-ig-3',
    'ki-grundlagen',
    'Deep Learning',
    'Maschinelles Lernen mit neuronalen Netzen aus vielen verborgenen Schichten.',
  ),
  karte(
    'k-ig-4',
    'ki-grundlagen',
    'LLM',
    'Großes Sprachmodell: sagt auf Basis von Trainingsdaten das jeweils nächste Token vorher.',
  ),
  karte(
    'k-ig-5',
    'ki-grundlagen',
    'Unüberwachtes Lernen',
    'Muster in Daten ohne Label finden, z. B. Kunden in Gruppen einteilen (Clustering).',
  ),
  karte(
    'k-ig-6',
    'ki-grundlagen',
    'Bestärkendes Lernen',
    'Lernen durch Belohnung und Strafe für Aktionen, z. B. ein Roboter lernt Greifen.',
  ),
  karte(
    'k-ig-7',
    'ki-grundlagen',
    'Overfitting',
    'Das Modell lernt die Trainingsdaten auswendig: dort sehr gut, bei neuen Daten schlecht.',
  ),
  karte(
    'k-ig-8',
    'ki-grundlagen',
    'Trainings- vs. Testdaten',
    'Mit Trainingsdaten lernt das Modell, mit ungesehenen Testdaten wird es bewertet.',
  ),

  // KI im Arbeitsalltag
  karte(
    'k-ie-1',
    'ki-einsatz',
    'Bausteine eines Prompts',
    'Rolle, Kontext, Aufgabe, Format - und bei Bedarf Beispiele.',
  ),
  karte(
    'k-ie-2',
    'ki-einsatz',
    'Typische Einsatzfelder',
    'Code-Assistenz, Support-Chatbot, Texte zusammenfassen, Tickets klassifizieren.',
  ),
  karte(
    'k-ie-3',
    'ki-einsatz',
    'KI-Ergebnis prüfen',
    'Lesen, verstehen, testen - die Verantwortung bleibt beim Menschen.',
  ),
  karte(
    'k-ie-4',
    'ki-einsatz',
    'Wann besser keine KI?',
    'Bei Aufgaben mit festen Regeln, z. B. Rechnungsbeträge - ein normales Programm ist zuverlässiger.',
  ),
  karte(
    'k-ie-5',
    'ki-einsatz',
    'Few-Shot-Prompting',
    'Prompt mit einigen Beispielen für die gewünschte Antwort.',
  ),
  karte(
    'k-ie-6',
    'ki-einsatz',
    'KI-Kompetenz (AI Act)',
    'Seit 2.2.2025: Wer KI-Systeme einsetzt, sorgt für ausreichend geschultes Personal.',
  ),
  karte(
    'k-ie-7',
    'ki-einsatz',
    'Was nie in den Prompt gehört',
    'Passwörter, API-Schlüssel, Kundendaten und vertraulicher Code - jedenfalls nicht in öffentliche KI-Dienste.',
  ),

  // Grenzen und Recht
  karte(
    'k-ir-1',
    'ki-grenzen',
    'Halluzination',
    'Überzeugend formulierte, aber falsche oder erfundene Ausgabe eines KI-Modells.',
  ),
  karte(
    'k-ir-2',
    'ki-grenzen',
    'Bias',
    'Verzerrung: Das Modell übernimmt Ungleichgewichte aus seinen Trainingsdaten.',
  ),
  karte(
    'k-ir-3',
    'ki-grenzen',
    'AI Act - Risikostufen',
    'Unannehmbar (verboten), hoch (strenge Pflichten), begrenzt (Transparenz), minimal (keine besonderen Pflichten).',
  ),
  karte(
    'k-ir-4',
    'ki-grenzen',
    'Datenschutz bei KI-Tools',
    'Keine personenbezogenen oder vertraulichen Daten in öffentliche, nicht freigegebene Tools eingeben.',
  ),
  karte(
    'k-ir-5',
    'ki-grenzen',
    'Verboten nach dem AI Act',
    'U. a. Social Scoring und Emotionserkennung am Arbeitsplatz und in Bildungseinrichtungen.',
  ),
  karte(
    'k-ir-6',
    'ki-grenzen',
    'Prompt Injection',
    'Versteckte Anweisungen in Texten, die das Modell verarbeitet, sollen es manipulieren.',
  ),
  karte(
    'k-ir-7',
    'ki-grenzen',
    'Anbieter vs. Betreiber (AI Act)',
    'Anbieter entwickelt und vertreibt das KI-System, Betreiber setzt es beruflich ein.',
  ),
];
