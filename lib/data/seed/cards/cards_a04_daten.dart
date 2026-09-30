import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 04, Teil 2: Datenmodellierung, Web, Daten und
/// Multimedia, KI-Grundlagen.
final List<Flashcard> cardsA04Daten = [
  // ER-Modell
  karte('k-de-1', 'dm-erm', 'Entität vs. Entitätstyp',
      'Entität: ein einzelnes Objekt (Kundin Yilmaz). Entitätstyp: die Zusammenfassung gleichartiger Entitäten (Kunde).'),
  karte('k-de-2', 'dm-erm', 'Attribut',
      'Eigenschaft eines Entitätstyps, z. B. Name oder E-Mail eines Kunden.'),
  karte('k-de-3', 'dm-erm', 'Chen-Notation: Symbole',
      'Rechteck = Entitätstyp, Raute = Beziehung, Ellipse = Attribut, unterstrichen = Schlüsselattribut.'),
  karte('k-de-4', 'dm-erm', 'Kann eine Beziehung Attribute haben?',
      'Ja - z. B. „Menge“ an der Beziehung Bestellung „enthält“ Artikel.'),

  // Kardinalitäten
  karte('k-dk-1', 'dm-kardinalitaet', '1:n - Beispiel',
      'Abteilung - Mitarbeiter: Eine Abteilung hat viele Mitarbeiter, jeder gehört zu genau einer Abteilung.'),
  karte('k-dk-2', 'dm-kardinalitaet', 'n:m auflösen',
      'Über eine Zwischentabelle mit den Primärschlüsseln beider Seiten als Fremdschlüssel -> zwei 1:n-Beziehungen.'),
  karte('k-dk-3', 'dm-kardinalitaet', 'Fremdschlüssel bei 1:n',
      'Kommt in die Tabelle der n-Seite, z. B. AbteilungsNr in Mitarbeiter.'),
  karte('k-dk-4', 'dm-kardinalitaet', 'Min-Max (0,n)',
      'Die Entität nimmt mindestens 0-mal (optional) und höchstens beliebig oft an der Beziehung teil.'),

  // Schlüssel
  karte('k-dl-1', 'dm-schluessel', 'Primärschlüssel',
      'Identifiziert jeden Datensatz eindeutig, darf nie leer sein und sollte sich nicht ändern.'),
  karte('k-dl-2', 'dm-schluessel', 'Fremdschlüssel',
      'Spalte, die auf den Primärschlüssel einer anderen Tabelle verweist - darf sich wiederholen.'),
  karte('k-dl-3', 'dm-schluessel', 'Surrogatschlüssel',
      'Künstlicher Schlüssel ohne fachliche Bedeutung, vom System vergeben, z. B. fortlaufende KundenNr.'),
  karte('k-dl-4', 'dm-schluessel', 'Referenzielle Integrität',
      'Jeder Fremdschlüsselwert muss als Primärschlüssel in der referenzierten Tabelle existieren.'),
  karte('k-dl-5', 'dm-schluessel', 'Zusammengesetzter Schlüssel',
      'Primärschlüssel aus mehreren Spalten, z. B. BestellNr + ArtikelNr in Bestellposition.'),

  // Normalisierung
  karte('k-dn-1', 'dm-normalisierung', '1NF',
      'Alle Attributwerte sind atomar, es gibt keine Wiederholungsgruppen.'),
  karte('k-dn-2', 'dm-normalisierung', '2NF',
      '1NF und jedes Nichtschlüsselattribut hängt vom gesamten Primärschlüssel ab, nicht nur von einem Teil.'),
  karte('k-dn-3', 'dm-normalisierung', '3NF',
      '2NF und kein Nichtschlüsselattribut hängt transitiv (über ein anderes Nichtschlüsselattribut) vom Schlüssel ab.'),
  karte('k-dn-4', 'dm-normalisierung', 'Die drei Anomalien',
      'Einfüge-, Änderungs- und Löschanomalie - Folgen von Redundanz in nicht normalisierten Tabellen.'),

  // URL
  karte('k-wu-1', 'wi-url', 'Reihenfolge der URL-Teile',
      'Schema :// Host : Port / Pfad ? Query # Fragment'),
  karte('k-wu-2', 'wi-url', 'Standardports',
      'http: 80, https: 443, ftp: 21.'),
  karte('k-wu-3', 'wi-url', 'Fragment (#)',
      'Sprungmarke innerhalb der Seite - wird nicht an den Server übertragen.'),
  karte('k-wu-4', 'wi-url', 'Query (?)',
      'Parameter für den Server als Schlüssel=Wert-Paare, getrennt mit &, z. B. ?farbe=rot&seite=2.'),

  // HTTP
  karte('k-wh-1', 'wi-http', 'GET, POST, PUT, DELETE',
      'Abrufen, Daten senden/Neues anlegen, Ressource ersetzen, Ressource löschen.'),
  karte('k-wh-2', 'wi-http', 'Statuscode-Klassen',
      '1xx Information, 2xx Erfolg, 3xx Umleitung, 4xx Client-Fehler, 5xx Server-Fehler.'),
  karte('k-wh-3', 'wi-http', '401 vs. 403',
      '401: nicht (erfolgreich) angemeldet. 403: angemeldet bzw. bekannt, aber kein Zugriff erlaubt.'),
  karte('k-wh-4', 'wi-http', 'Zustandslos',
      'Jede HTTP-Anfrage steht für sich. Sitzungen werden z. B. über Cookies mit Sitzungs-ID gehalten.'),
  karte('k-wh-5', 'wi-http', 'HTTPS',
      'HTTP über eine mit TLS verschlüsselte Verbindung, Standardport 443.'),

  // Seitenaufruf
  karte('k-wa-1', 'wi-aufruf', 'Ablauf Seitenaufruf',
      'URL -> DNS -> TCP-Handshake -> TLS-Handshake -> HTTP-Request -> Response -> Rendern und Nachladen.'),
  karte('k-wa-2', 'wi-aufruf', '3-Way-Handshake',
      'SYN (Client) -> SYN-ACK (Server) -> ACK (Client). Danach steht die TCP-Verbindung.'),
  karte('k-wa-3', 'wi-aufruf', 'Aufgabe von DNS',
      'Übersetzt einen Hostnamen in die zugehörige IP-Adresse.'),
  karte('k-wa-4', 'wi-aufruf', 'TLS-Handshake',
      'Server weist sich per Zertifikat aus, beide Seiten handeln einen Sitzungsschlüssel aus.'),

  // HTML und CSS
  karte('k-wt-1', 'wi-html', 'HTML, CSS, JavaScript',
      'HTML: Struktur und Bedeutung. CSS: Gestaltung. JavaScript: Verhalten.'),
  karte('k-wt-2', 'wi-html', 'Aufbau einer CSS-Regel',
      'Selektor { Eigenschaft: Wert; } - z. B. h1 { color: navy; }'),
  karte('k-wt-3', 'wi-html', 'Klasse vs. ID',
      'Klasse (.name) beliebig oft pro Seite, ID (#name) genau einmal pro Seite.'),
  karte('k-wt-4', 'wi-html', 'Media Query',
      'CSS-Regel mit Bedingung, z. B. @media (max-width: 600px) - Grundlage für responsives Design.'),

  // Barrierefreiheit
  karte('k-wf-1', 'wi-barrierefrei', 'WCAG-Prinzipien',
      'Wahrnehmbar, bedienbar, verständlich, robust.'),
  karte('k-wf-2', 'wi-barrierefrei', 'BITV 2.0',
      'Verordnung zur Barrierefreiheit von Websites und Apps öffentlicher Stellen des Bundes.'),
  karte('k-wf-3', 'wi-barrierefrei', 'BFSG',
      'Barrierefreiheitsstärkungsgesetz: seit 28.06.2025 Pflicht für viele Produkte und Dienste privater Anbieter, z. B. Online-Shops.'),
  karte('k-wf-4', 'wi-barrierefrei', 'Alt-Text',
      'Textalternative für Bilder. Beschreibt Inhalt oder Zweck; dekorative Bilder bekommen alt="".'),
  karte('k-wf-5', 'wi-barrierefrei', 'Mindestkontrast (WCAG AA)',
      '4,5:1 für normalen Text, 3:1 für großen Text.'),

  // Zahlensysteme
  karte('k-mz-1', 'md-zahlensysteme', 'Stellenwerte eines Bytes',
      '128, 64, 32, 16, 8, 4, 2, 1 - von links nach rechts.'),
  karte('k-mz-2', 'md-zahlensysteme', 'Nibble-Trick',
      'Je 4 Bit ergeben eine Hex-Ziffer: 1001 1100 = 9C.'),
  karte('k-mz-3', 'md-zahlensysteme', 'Hex-Ziffern A bis F',
      'A = 10, B = 11, C = 12, D = 13, E = 14, F = 15.'),
  karte('k-mz-4', 'md-zahlensysteme', 'Divisionsrestverfahren',
      'Wiederholt durch die Basis teilen, Reste von unten nach oben lesen.'),

  // Zeichensätze
  karte('k-mc-1', 'md-zeichen', 'ASCII',
      '7 Bit, 128 Zeichen - ohne Umlaute. „A“ = 65, „a“ = 97, „0“ = 48.'),
  karte('k-mc-2', 'md-zeichen', 'UTF-8',
      'Kodierung für Unicode mit 1 bis 4 Byte je Zeichen, ASCII-kompatibel. Umlaute: 2 Byte, €: 3 Byte.'),
  karte('k-mc-3', 'md-zeichen', 'Unicode-Codepoint',
      'Eindeutige Nummer eines Zeichens, geschrieben als U+hex, z. B. ä = U+00E4.'),
  karte('k-mc-4', 'md-zeichen', 'Mojibake',
      'Zeichensalat durch falsch interpretierte Kodierung, z. B. UTF-8 als Latin-1: „Ã¼“ statt „ü“.'),

  // Datenmengen
  karte('k-md-1', 'md-datenmengen', 'Datenmenge Bild',
      'Breite × Höhe × Farbtiefe (Bit), durch 8 für Byte.'),
  karte('k-md-2', 'md-datenmengen', 'Datenmenge Audio',
      'Abtastrate × Bittiefe × Kanäle × Sekunden (Bit).'),
  karte('k-md-3', 'md-datenmengen', 'Datenmenge Video (unkomprimiert)',
      'Breite × Höhe × Farbtiefe × Bilder pro Sekunde × Sekunden (Bit).'),
  karte('k-md-4', 'md-datenmengen', 'kB vs. KiB',
      '1 kB = 1.000 Byte (dezimal), 1 KiB = 1.024 Byte (binär).'),

  // Übertragung
  karte('k-mu-1', 'md-uebertragung', 'Übertragungsdauer',
      'Dauer = Datenmenge in Bit / Datenrate in Bit pro Sekunde.'),
  karte('k-mu-2', 'md-uebertragung', '1 Mbit/s',
      '1.000.000 Bit pro Sekunde - Datenraten werden dezimal angegeben.'),
  karte('k-mu-3', 'md-uebertragung', 'MB -> Mbit',
      'Mal 8: 500 MB = 4.000 Mbit.'),
  karte('k-mu-4', 'md-uebertragung', 'Upload vs. Download',
      'Beim Hochladen, z. B. Cloud-Backup, zählt die meist kleinere Upload-Rate.'),

  // Kompression
  karte('k-mx-1', 'md-kompression', 'Verlustfreie Formate',
      'ZIP, PNG, FLAC - das Original lässt sich exakt wiederherstellen.'),
  karte('k-mx-2', 'md-kompression', 'Verlustbehaftete Formate',
      'JPEG, MP3, AAC, H.264, H.265 - Details werden dauerhaft weggelassen.'),
  karte('k-mx-3', 'md-kompression', 'RLE',
      'Lauflängenkodierung: Folgen gleicher Zeichen als Anzahl + Zeichen, z. B. AAAAA -> 5A.'),
  karte('k-mx-4', 'md-kompression', 'SVG',
      'Vektorformat: beliebig skalierbar ohne Qualitätsverlust - ideal für Logos und Icons.'),

  // KI-Grundlagen
  karte('k-ig-1', 'ki-grundlagen', 'Schwache vs. starke KI',
      'Schwach: löst bestimmte Aufgaben (alle heutigen Systeme). Stark: allgemeine, menschenähnliche Intelligenz - gibt es bisher nicht.'),
  karte('k-ig-2', 'ki-grundlagen', 'Überwachtes Lernen',
      'Lernen aus Beispielen mit bekannter richtiger Antwort (Label), z. B. markierte Spam-Mails.'),
  karte('k-ig-3', 'ki-grundlagen', 'Deep Learning',
      'Maschinelles Lernen mit neuronalen Netzen aus vielen verborgenen Schichten.'),
  karte('k-ig-4', 'ki-grundlagen', 'LLM',
      'Großes Sprachmodell: sagt auf Basis von Trainingsdaten das jeweils nächste Token vorher.'),

  // KI im Arbeitsalltag
  karte('k-ie-1', 'ki-einsatz', 'Bausteine eines Prompts',
      'Rolle, Kontext, Aufgabe, Format - und bei Bedarf Beispiele.'),
  karte('k-ie-2', 'ki-einsatz', 'Typische Einsatzfelder',
      'Code-Assistenz, Support-Chatbot, Texte zusammenfassen, Tickets klassifizieren.'),
  karte('k-ie-3', 'ki-einsatz', 'KI-Ergebnis prüfen',
      'Lesen, verstehen, testen - die Verantwortung bleibt beim Menschen.'),
  karte('k-ie-4', 'ki-einsatz', 'Wann besser keine KI?',
      'Bei Aufgaben mit festen Regeln, z. B. Rechnungsbeträge - ein normales Programm ist zuverlässiger.'),

  // Grenzen und Recht
  karte('k-ir-1', 'ki-grenzen', 'Halluzination',
      'Überzeugend formulierte, aber falsche oder erfundene Ausgabe eines KI-Modells.'),
  karte('k-ir-2', 'ki-grenzen', 'Bias',
      'Verzerrung: Das Modell übernimmt Ungleichgewichte aus seinen Trainingsdaten.'),
  karte('k-ir-3', 'ki-grenzen', 'AI Act - Risikostufen',
      'Unannehmbar (verboten), hoch (strenge Pflichten), begrenzt (Transparenz), minimal (keine besonderen Pflichten).'),
  karte('k-ir-4', 'ki-grenzen', 'Datenschutz bei KI-Tools',
      'Keine personenbezogenen oder vertraulichen Daten in öffentliche, nicht freigegebene Tools eingeben.'),
];
