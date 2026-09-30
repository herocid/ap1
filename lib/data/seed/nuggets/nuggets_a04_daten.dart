import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 04, Teil 2: Datenmodellierung, Web, Daten und
/// Multimedia, KI-Grundlagen.
final List<Nugget> nuggetsA04Daten = [
  // ================================================================ ER-Modell
  konzept('n-de-1', 'dm-erm', 'Entität und Entitätstyp',
      'Eine Entität ist ein einzelnes, unterscheidbares Objekt, über das Daten gespeichert werden - etwa die Kundin Frau Yilmaz oder die Rechnung 2025-117. Gleichartige Entitäten fasst man zu einem Entitätstyp zusammen, zum Beispiel „Kunde“ oder „Rechnung“.'),
  konzept('n-de-2', 'dm-erm', 'Attribute und Beziehungen',
      'Attribute beschreiben die Eigenschaften eines Entitätstyps, Beziehungen verbinden Entitätstypen miteinander.',
      points: [
        'Attribute von „Kunde“: Kundennummer, Name, E-Mail, Ort',
        'Beziehung: Kunde „erteilt“ Auftrag',
        'Auch eine Beziehung kann Attribute haben: „Menge“ bei Auftrag „enthält“ Artikel',
      ]),
  vergleich('n-de-3', 'dm-erm', 'Die Chen-Notation',
      'Im ER-Diagramm nach Peter Chen hat jedes Element eine feste Form. Linien verbinden Attribute mit ihrem Entitätstyp und Entitätstypen mit ihren Beziehungen.',
      [
        ['Symbol', 'steht für', 'Beispiel'],
        ['Rechteck', 'Entitätstyp', 'Kunde'],
        ['Raute', 'Beziehung', 'erteilt'],
        ['Ellipse', 'Attribut', 'Name'],
        ['unterstrichen', 'Schlüsselattribut', 'Kundennummer'],
      ]),
  ablauf('n-de-4', 'dm-erm', 'Vom Text zum ER-Modell',
      'Beispiel Arztpraxis: „Patienten sind bei einer Krankenkasse versichert. Zu jedem Patienten werden Name und Geburtsdatum gespeichert, zu jeder Kasse Name und Kassennummer.“',
      [
        'Substantive suchen -> Kandidaten für Entitätstypen: Patient, Krankenkasse',
        'Beschreibende Angaben als Attribute zuordnen: Name und Geburtsdatum zu Patient',
        'Verben werden zu Beziehungen: Patient „ist versichert bei“ Krankenkasse',
        'Pro Entitätstyp ein Schlüsselattribut festlegen, z. B. Patientennummer',
      ]),
  falle('n-de-5', 'dm-erm', 'Attribut oder eigener Entitätstyp?',
      'Nicht jedes Substantiv wird ein Entitätstyp. „Ort“ ist meist nur ein Attribut des Kunden. Sobald zu einer Sache eigene Eigenschaften gespeichert werden sollen - etwa zu einer Abteilung Name, Standort und Leitung -, wird sie ein eigener Entitätstyp.',
      merksatz: 'Rechteck = Entitätstyp, Raute = Beziehung, Ellipse = Attribut.'),

  // ============================================================ Kardinalitäten
  konzept('n-dk-1', 'dm-kardinalitaet', 'Was die Kardinalität angibt',
      'Die Kardinalität legt fest, mit wie vielen Entitäten des anderen Typs eine Entität höchstens in Beziehung stehen kann. Eine Beziehung liest man immer in beide Richtungen: Wie viele B hat ein A - und wie viele A hat ein B?'),
  vergleich('n-dk-2', 'dm-kardinalitaet', 'Die drei Grundtypen',
      'Welcher Typ gilt, entscheiden die Regeln des Auftraggebers. Die Beispiele zeigen übliche Regeln.',
      [
        ['Typ', 'Beispiel', 'Lesart'],
        ['1:1', 'Mitarbeiter - Dienstwagen', 'jeder hat höchstens einen des anderen'],
        ['1:n', 'Abteilung - Mitarbeiter', 'eine Abteilung hat viele, jeder gehört zu einer'],
        ['n:m', 'Schüler - Kurs', 'beide Seiten haben viele'],
      ]),
  ablauf('n-dk-3', 'dm-kardinalitaet', 'n:m auflösen',
      'Relationale Tabellen können n:m nicht direkt speichern. Beispiel Webshop: Eine Bestellung enthält viele Artikel, ein Artikel steckt in vielen Bestellungen.',
      [
        'Zwischentabelle anlegen: Bestellposition',
        'Primärschlüssel beider Seiten als Fremdschlüssel aufnehmen: BestellNr und ArtikelNr',
        'Beide zusammen bilden den Primärschlüssel der Zwischentabelle',
        'Attribute der Beziehung dort ablegen, z. B. Menge',
        'Ergebnis: zwei 1:n-Beziehungen - Bestellung 1:n Bestellposition, Artikel 1:n Bestellposition',
      ]),
  konzept('n-dk-4', 'dm-kardinalitaet', 'Wohin der Fremdschlüssel kommt',
      'Bei 1:n wandert der Primärschlüssel der 1-Seite als Fremdschlüssel in die Tabelle der n-Seite: Die Tabelle Mitarbeiter bekommt die Spalte AbteilungsNr. Bei 1:1 genügt ein Fremdschlüssel auf einer der beiden Seiten, der dort nur einmal vorkommen darf.'),
  konzept('n-dk-5', 'dm-kardinalitaet', 'Min-Max-Notation am Rande',
      'Neben der Chen-Notation gibt es Paare wie (0,n) oder (1,1). Sie sagen, wie oft eine Entität mindestens und höchstens an der Beziehung teilnimmt, und stehen deshalb auf der anderen Seite als die Chen-Angabe. Ein Mitarbeiter gehört zu genau einer Abteilung -> (1,1) steht beim Mitarbeiter. Eine 0 als Minimum heißt: Die Teilnahme ist optional.'),
  falle('n-dk-6', 'dm-kardinalitaet', 'Nur eine Richtung gelesen',
      'Aus „Ein Kunde erteilt viele Aufträge“ allein folgt noch nicht 1:n. Erst die Gegenrichtung entscheidet: Gehört jeder Auftrag genau einem Kunden, ist es 1:n. Können mehrere Kunden gemeinsam einen Auftrag erteilen, wäre es n:m.',
      merksatz: 'n:m wird immer über eine Zwischentabelle in zwei 1:n-Beziehungen aufgelöst.'),

  // ================================================================ Schlüssel
  konzept('n-dl-1', 'dm-schluessel', 'Der Primärschlüssel',
      'Der Primärschlüssel identifiziert jeden Datensatz einer Tabelle eindeutig. Er darf nie leer sein, darf sich in der Tabelle nicht wiederholen und sollte sich nicht ändern.'),
  vergleich('n-dl-2', 'dm-schluessel', 'Schlüsselarten',
      'Schlüssel unterscheiden sich darin, woher ihr Wert kommt und welche Aufgabe sie haben.',
      [
        ['Schlüssel', 'Merkmal', 'Beispiel'],
        ['natürlich', 'fachliches Merkmal', 'ISBN eines Buchs'],
        ['künstlich (Surrogat)', 'vom System vergeben, ohne Bedeutung', 'KundenNr 10457'],
        ['zusammengesetzt', 'mehrere Spalten gemeinsam', 'BestellNr + ArtikelNr'],
        ['Fremdschlüssel', 'verweist auf einen Primärschlüssel', 'KundenNr in Bestellung'],
      ]),
  konzept('n-dl-3', 'dm-schluessel', 'Warum oft künstliche Schlüssel',
      'Natürliche Merkmale sind selten dauerhaft eindeutig und stabil: Namen wiederholen sich, E-Mail-Adressen ändern sich, Kfz-Kennzeichen werden neu vergeben. Ein künstlicher Schlüssel wird vom System vergeben, ist garantiert eindeutig und ändert sich nie.'),
  ablauf('n-dl-4', 'dm-schluessel', 'Referenzielle Integrität',
      'Referenzielle Integrität heißt: Jeder Fremdschlüsselwert verweist auf einen vorhandenen Primärschlüssel. Beispiel: Tabelle Bestellung mit der Spalte KundenNr.',
      [
        'Neue Bestellung für KundenNr 999 - Kunde 999 gibt es nicht -> wird abgelehnt',
        'Kunde 10457 soll gelöscht werden, hat aber Bestellungen -> Löschen wird verhindert',
        'Alternative Löschweitergabe (Kaskade): Mit dem Kunden werden seine Bestellungen mitgelöscht',
        'Ohne diese Prüfung entstehen verwaiste Datensätze',
      ]),
  falle('n-dl-5', 'dm-schluessel', 'Fremdschlüssel dürfen sich wiederholen',
      'Anders als der Primärschlüssel ist ein Fremdschlüssel nicht eindeutig: Dieselbe KundenNr steht in jeder Bestellung dieses Kunden. Genau das macht die 1:n-Beziehung aus.',
      merksatz: 'Primärschlüssel: eindeutig, nie leer, stabil. Fremdschlüssel: Verweis auf den Primärschlüssel einer anderen Tabelle.'),

  // ============================================================ Normalisierung
  vergleich('n-dn-1', 'dm-normalisierung', 'Drei Anomalien',
      'Eine Tabelle, die Bestellungen, Kunden und Artikel auf einmal speichert, enthält Redundanz - und daraus entstehen Anomalien.',
      [
        ['Anomalie', 'Problem'],
        ['Einfügen', 'neuer Artikel erst speicherbar, wenn er bestellt wurde'],
        ['Ändern', 'Kunde zieht um -> Ort in vielen Zeilen ändern, sonst widersprüchlich'],
        ['Löschen', 'einzige Bestellung gelöscht -> Kundendaten sind mit weg'],
      ]),
  vergleich('n-dn-2', 'dm-normalisierung', 'Die drei Normalformen',
      'Normalisierung beseitigt Redundanz Schritt für Schritt. Jede Normalform setzt die vorige voraus.',
      [
        ['Form', 'Regel'],
        ['1NF', 'alle Werte atomar, keine Wiederholungsgruppen'],
        ['2NF', '1NF + jedes Nichtschlüsselattribut hängt vom ganzen Schlüssel ab'],
        ['3NF', '2NF + keine transitiven Abhängigkeiten zwischen Nichtschlüsselattributen'],
      ]),
  konzept('n-dn-3', 'dm-normalisierung', 'Das Ausgangsbeispiel',
      'Ein Webshop speichert jede Bestellung in einer Zeile: BestellNr 1001, Datum 12.03., KundenNr K7, Name Meyer, Ort Köln, Artikel „2× Maus (A1, 15 €), 1× Tastatur (A2, 40 €)“. Das Feld Artikel enthält mehrere Werte auf einmal.'),
  ablauf('n-dn-4', 'dm-normalisierung', '1NF: Werte atomar machen',
      'Jede Zelle darf nur einen einzigen Wert enthalten.',
      [
        'Artikelliste auflösen: eine Zeile pro Bestellposition',
        'Zusammengesetzte Angaben trennen: Menge, ArtikelNr, Bezeichnung, Preis als eigene Spalten',
        'Schlüssel festlegen: BestellNr + ArtikelNr',
        'Ergebnis: zwei Zeilen für Bestellung 1001 - Maus und Tastatur',
      ]),
  ablauf('n-dn-5', 'dm-normalisierung', '2NF und 3NF',
      'Jetzt werden die Abhängigkeiten der Nichtschlüsselattribute geprüft.',
      [
        '2NF: Datum, KundenNr, Name, Ort hängen nur von BestellNr ab -> Tabelle Bestellung',
        '2NF: Bezeichnung und Preis hängen nur von ArtikelNr ab -> Tabelle Artikel',
        'Menge hängt vom ganzen Schlüssel ab -> bleibt in Bestellposition',
        '3NF: Name und Ort hängen über KundenNr von BestellNr ab (transitiv) -> Tabelle Kunde, KundenNr bleibt als Fremdschlüssel in Bestellung',
        'Ergebnis: Kunde, Bestellung, Artikel, Bestellposition',
      ]),
  falle('n-dn-6', 'dm-normalisierung', '2NF nur bei zusammengesetztem Schlüssel',
      'Eine Tabelle in 1NF mit einspaltigem Primärschlüssel ist automatisch in 2NF - ein Attribut kann nicht von einem Teil eines einzelnen Schlüssels abhängen. Die 2NF-Prüfung lohnt sich nur bei zusammengesetzten Schlüsseln.',
      merksatz: 'Jedes Attribut hängt vom Schlüssel ab, vom ganzen Schlüssel und von nichts als dem Schlüssel.'),

  // ============================================================ Aufbau einer URL
  konzept('n-wu-1', 'wi-url', 'Eine URL adressiert eine Ressource',
      'Eine URL (Uniform Resource Locator) sagt dem Browser, mit welchem Protokoll er welchen Server ansprechen und welche Ressource er dort abrufen soll. Jeder Teil hat eine feste Position und ein eigenes Trennzeichen.'),
  formel('n-wu-2', 'wi-url', 'Eine URL zerlegt',
      'Beispiel aus einem Webshop, auf Zeilen verteilt:',
      'https://shop.example.com:8443\n'
          '/produkte/maus\n'
          '?farbe=rot&seite=2\n'
          '#details',
      points: [
        'Subdomain shop, Domain example und TLD com bilden den Host',
        'Die Query-Parameter werden mit & getrennt',
      ]),
  vergleich('n-wu-3', 'wi-url', 'Die Teile im Einzelnen',
      'Jeder Bestandteil hat eine eigene Aufgabe.',
      [
        ['Teil', 'Wert', 'Aufgabe'],
        ['Schema', 'https', 'Protokoll'],
        ['Host', 'shop.example.com', 'Server'],
        ['Port', '8443', 'Dienst auf dem Server'],
        ['Pfad', '/produkte/maus', 'Ressource auf dem Server'],
        ['Query', 'farbe=rot&seite=2', 'Parameter für den Server'],
        ['Fragment', 'details', 'Sprungmarke in der Seite'],
      ]),
  vergleich('n-wu-4', 'wi-url', 'Standardports',
      'Fehlt der Port in der URL, nimmt der Browser den Standardport des Schemas.',
      [
        ['Schema', 'Standardport'],
        ['http', '80'],
        ['https', '443'],
        ['ftp', '21'],
      ],
      merksatz: 'https://example.com ist dasselbe wie https://example.com:443.'),
  falle('n-wu-5', 'wi-url', 'Das Fragment bleibt im Browser',
      'Alles hinter # schickt der Browser nicht an den Server - er springt damit nur zu einer Stelle der Seite. Wer Daten an den Server übergeben will, nutzt die Query hinter ?. Und: www ist keine Pflicht, sondern nur eine übliche Subdomain.'),
  merke('n-wu-6', 'wi-url', 'Die Reihenfolge',
      'Die Bestandteile stehen immer in derselben Reihenfolge. Pflicht sind nur Schema und Host.',
      satz: 'Schema :// Host : Port / Pfad ? Query # Fragment'),

  // ============================================================ HTTP und HTTPS
  konzept('n-wh-1', 'wi-http', 'Anfrage und Antwort',
      'HTTP (Hypertext Transfer Protocol) arbeitet nach dem Client-Server-Prinzip: Der Browser schickt einen Request mit Methode, Pfad und Headern. Der Server antwortet mit einer Response aus Statuscode, Headern und Inhalt - etwa dem HTML einer Seite.'),
  vergleich('n-wh-2', 'wi-http', 'Die wichtigsten Methoden',
      'Die Methode sagt dem Server, was mit der Ressource geschehen soll.',
      [
        ['Methode', 'Zweck', 'Beispiel'],
        ['GET', 'Ressource abrufen', 'Produktseite laden'],
        ['POST', 'Daten senden, Neues anlegen', 'Bestellung abschicken'],
        ['PUT', 'Ressource ersetzen oder anlegen', 'Kundendaten speichern'],
        ['DELETE', 'Ressource löschen', 'Adresse aus dem Konto entfernen'],
      ]),
  vergleich('n-wh-3', 'wi-http', 'Statuscode-Klassen',
      'Die erste Ziffer des dreistelligen Codes verrät, wie die Anfrage ausgegangen ist.',
      [
        ['Klasse', 'Bedeutung', 'Beispiele'],
        ['1xx', 'Information', '100 Continue'],
        ['2xx', 'Erfolg', '200, 201'],
        ['3xx', 'Umleitung', '301, 304'],
        ['4xx', 'Fehler beim Client', '400, 401, 403, 404'],
        ['5xx', 'Fehler beim Server', '500, 503'],
      ]),
  konzept('n-wh-4', 'wi-http', 'Die Codes im Alltag',
      'Diese Codes kommen im Support und in Prüfungen am häufigsten vor.',
      points: [
        '200 OK: Anfrage erfolgreich',
        '201 Created: neue Ressource angelegt, etwa nach POST',
        '301 Moved Permanently: dauerhaft umgezogen, neue Adresse im Header Location',
        '304 Not Modified: Der Browser darf seine Kopie aus dem Cache verwenden',
        '400 Bad Request: Anfrage fehlerhaft aufgebaut',
        '404 Not Found: Ressource gibt es nicht',
        '500 Internal Server Error: Fehler im Serverprogramm',
        '503 Service Unavailable: Server überlastet oder in Wartung',
      ]),
  konzept('n-wh-5', 'wi-http', 'Zustandslos - und Cookies',
      'HTTP ist zustandslos: Jede Anfrage steht für sich, der Server erinnert sich nicht an die vorige. Damit Warenkorb oder Login erhalten bleiben, setzt der Server ein Cookie mit einer Sitzungs-ID, das der Browser bei jeder weiteren Anfrage mitschickt.'),
  falle('n-wh-6', 'wi-http', '401 ist nicht 403',
      '401 Unauthorized heißt: nicht angemeldet oder Anmeldung fehlgeschlagen. 403 Forbidden heißt: Der Server weiß, wer anfragt, verweigert aber den Zugriff. Und HTTPS ist kein eigenes Protokoll, sondern HTTP über eine TLS-verschlüsselte Verbindung - Standardport 443 statt 80.',
      merksatz: '4xx: Das Problem liegt bei der Anfrage. 5xx: Das Problem liegt beim Server.'),

  // ============================================ Was beim Seitenaufruf passiert
  konzept('n-wa-1', 'wi-aufruf', 'Viele Protokolle für eine Seite',
      'Zwischen der Eingabe der Adresse und der fertigen Seite arbeiten mehrere Protokolle zusammen: DNS findet die IP-Adresse, TCP baut eine zuverlässige Verbindung auf, TLS verschlüsselt sie, HTTP überträgt die Inhalte.'),
  ablauf('n-wa-2', 'wi-aufruf', 'Der Weg zur Seite',
      'Beispiel: Eine Kundin gibt https://shop.example.com in die Adresszeile ein.',
      [
        'Browser zerlegt die URL: Schema https, Host shop.example.com, Port 443',
        'DNS-Auflösung: Der Hostname wird in eine IP-Adresse übersetzt',
        'TCP-Verbindung zum Server über den 3-Way-Handshake',
        'TLS-Handshake: Zertifikat prüfen, Sitzungsschlüssel aushandeln',
        'HTTP-Request: GET / an den Server',
        'HTTP-Response: Statuscode 200 und das HTML der Seite',
        'Browser rendert die Seite und lädt CSS, JavaScript und Bilder nach',
      ]),
  vergleich('n-wa-3', 'wi-aufruf', 'Wo DNS zuerst sucht',
      'Bevor eine DNS-Anfrage ins Netz geht, prüft der Rechner seine Zwischenspeicher.',
      [
        ['Stelle', 'Inhalt'],
        ['Browser-Cache', 'kürzlich aufgelöste Namen'],
        ['Betriebssystem', 'DNS-Cache und hosts-Datei'],
        ['DNS-Resolver', 'z. B. im Router oder beim Provider, fragt notfalls Root-, TLD- und zuständigen Nameserver'],
      ]),
  ablauf('n-wa-4', 'wi-aufruf', 'Der 3-Way-Handshake',
      'TCP stellt vor dem ersten Datenpaket sicher, dass beide Seiten bereit sind.',
      [
        'Client -> Server: SYN (Verbindungswunsch)',
        'Server -> Client: SYN-ACK (Bestätigung und eigener Verbindungswunsch)',
        'Client -> Server: ACK (Bestätigung) - die Verbindung steht',
      ],
      merksatz: 'Erst danach folgen TLS-Handshake und HTTP-Request.'),
  falle('n-wa-5', 'wi-aufruf', 'DNS liefert nur die Adresse',
      'DNS übersetzt den Namen in eine IP-Adresse - die Seite selbst kommt danach per HTTP vom Webserver. Und TLS folgt auf die TCP-Verbindung, nicht umgekehrt: Ohne bestehende Verbindung kann nichts verschlüsselt ausgehandelt werden.'),
  merke('n-wa-6', 'wi-aufruf', 'Die Merkkette',
      'Eine Seite besteht meist aus vielen Dateien. Für jedes nachgeladene Bild und Skript stellt der Browser eine eigene HTTP-Anfrage.',
      satz: 'Name -> IP (DNS) -> Verbindung (TCP) -> Verschlüsselung (TLS) -> Anfrage und Antwort (HTTP) -> Darstellung (Rendern).'),

  // ============================================================== HTML und CSS
  vergleich('n-wt-1', 'wi-html', 'Drei Sprachen, drei Aufgaben',
      'Eine Webseite trennt Inhalt, Aussehen und Verhalten.',
      [
        ['Sprache', 'Aufgabe', 'Beispiel'],
        ['HTML', 'Struktur und Bedeutung', 'Überschrift, Absatz, Link'],
        ['CSS', 'Gestaltung', 'Farben, Schrift, Abstände'],
        ['JavaScript', 'Verhalten', 'Menü aufklappen, Inhalte nachladen'],
      ]),
  formel('n-wt-2', 'wi-html', 'Aufbau eines HTML-Elements',
      'Ein Element besteht meist aus Start-Tag, Inhalt und End-Tag. Attribute im Start-Tag liefern Zusatzangaben.',
      '<a href="/kontakt">Kontakt</a>\n'
          '<img src="logo.png" alt="Logo">',
      points: [
        'a ist das Element (Link), href das Attribut, „Kontakt“ der Inhalt',
        'img hat kein End-Tag - ein leeres Element',
      ]),
  vergleich('n-wt-3', 'wi-html', 'Semantische Tags',
      'Semantische Tags sagen, welche Rolle ein Bereich hat. Das hilft Screenreadern und Suchmaschinen.',
      [
        ['Tag', 'Bedeutung'],
        ['<header>', 'Kopfbereich'],
        ['<nav>', 'Navigation'],
        ['<main>', 'Hauptinhalt'],
        ['<article>', 'eigenständiger Beitrag'],
        ['<footer>', 'Fußbereich'],
      ]),
  formel('n-wt-4', 'wi-html', 'Eine CSS-Regel',
      'Eine CSS-Regel besteht aus einem Selektor und Deklarationen aus Eigenschaft und Wert.',
      'h1 { color: navy; }\n'
          '.hinweis { font-size: 1.2rem; }\n'
          '#kopf { background: white; }',
      points: [
        'h1 wählt alle Überschriften erster Ordnung',
        '.hinweis wählt alle Elemente mit class="hinweis"',
        '#kopf wählt das eine Element mit id="kopf"',
      ]),
  konzept('n-wt-5', 'wi-html', 'Responsive Design',
      'Eine responsive Seite passt ihr Layout an die Bildschirmbreite an. Media Queries legen CSS-Regeln fest, die nur unter Bedingungen gelten - etwa @media (max-width: 600px) für schmale Handydisplays. Dazu kommen flexible Raster und mitwachsende Bilder.'),
  falle('n-wt-6', 'wi-html', 'Klasse, ID und falsche Semantik',
      'Eine ID darf pro Seite nur einmal vorkommen, eine Klasse beliebig oft. Und Gestaltung gehört ins CSS: Wer einen Text nur wegen der großen Schrift als h1 auszeichnet, verfälscht die Struktur - Screenreader lesen die Seite dann falsch gegliedert vor.',
      merksatz: 'HTML sagt, was etwas ist. CSS sagt, wie es aussieht. JavaScript sagt, was es tut.'),

  // ========================================================== Barrierefreiheit
  konzept('n-wf-1', 'wi-barrierefrei', 'Für wen Barrierefreiheit zählt',
      'Barrierefreie Webangebote sind für alle nutzbar - auch für Menschen mit Seh-, Hör-, motorischen oder kognitiven Einschränkungen und für ältere Menschen. Davon profitieren auch alle, die in greller Sonne oder mit einer Hand am Handy arbeiten.'),
  vergleich('n-wf-2', 'wi-barrierefrei', 'Die vier WCAG-Prinzipien',
      'Die Web Content Accessibility Guidelines (WCAG) des W3C ordnen alle Anforderungen vier Prinzipien zu.',
      [
        ['Prinzip', 'Beispiel'],
        ['wahrnehmbar', 'Alt-Text für Bilder, Untertitel für Videos'],
        ['bedienbar', 'alles per Tastatur erreichbar, sichtbarer Fokus'],
        ['verständlich', 'klare Sprache, verständliche Fehlermeldungen'],
        ['robust', 'sauberes HTML, das Hilfsmittel auswerten können'],
      ]),
  ablauf('n-wf-3', 'wi-barrierefrei', 'Eine Seite prüfen',
      'Beispiel: Ein Azubi prüft das Kontaktformular des Webshops.',
      [
        'Nur mit der Tab-Taste bedienen: Erreicht man jedes Feld und den Senden-Button?',
        'Bilder prüfen: Inhaltliche Bilder brauchen einen Alt-Text, dekorative ein leeres alt=""',
        'Kontrast messen: normaler Text mindestens 4,5:1 (WCAG-Stufe AA)',
        'Mit einem Screenreader testen: Sind alle Felder richtig beschriftet?',
        'Fehlermeldung prüfen: Steht dort in Worten, was falsch ist?',
      ]),
  vergleich('n-wf-4', 'wi-barrierefrei', 'Die Rechtslage',
      'In Deutschland regeln zwei Vorschriften die digitale Barrierefreiheit. Kleinstunternehmen, die Dienstleistungen anbieten (unter 10 Beschäftigte und höchstens 2 Mio. € Jahresumsatz oder Bilanzsumme), sind vom BFSG ausgenommen.',
      [
        ['Vorschrift', 'gilt für'],
        ['BITV 2.0', 'Websites und Apps öffentlicher Stellen des Bundes (die Länder haben eigene Regeln)'],
        ['BFSG', 'seit 28.06.2025 viele Produkte und Dienste privater Anbieter, z. B. Online-Shops, E-Book-Reader, Bankdienste'],
      ]),
  falle('n-wf-5', 'wi-barrierefrei', 'Farbe allein reicht nicht',
      'Pflichtfelder nur rot markieren oder Fehler nur mit einer roten Umrandung zeigen, schließt Menschen mit Farbsehschwäche aus - die Information muss auch als Text oder Symbol erkennbar sein. Ebenso hilft ein Alt-Text wie „bild1.jpg“ niemandem: Er soll Inhalt oder Zweck des Bildes beschreiben.',
      merksatz: 'WCAG: wahrnehmbar, bedienbar, verständlich, robust.'),

  // ============================================================= Zahlensysteme
  vergleich('n-mz-1', 'md-zahlensysteme', 'Vier Zahlensysteme',
      'Jedes Stellenwertsystem hat eine Basis: Die Ziffern werden mit Potenzen dieser Basis gewichtet.',
      [
        ['System', 'Basis', 'Ziffern'],
        ['Dezimal', '10', '0-9'],
        ['Binär (Dual)', '2', '0 und 1'],
        ['Oktal', '8', '0-7'],
        ['Hexadezimal', '16', '0-9, A-F (A = 10, F = 15)'],
      ]),
  formel('n-mz-2', 'md-zahlensysteme', 'Binär -> dezimal über Stellenwerte',
      'Die Stellenwerte verdoppeln sich von rechts nach links. Addiert werden die Werte der Stellen, an denen eine 1 steht.',
      'Stelle: 128 64 32 16 8 4 2 1\n'
          'Bit:      1  0  1  1 0 1 1 0\n'
          '128 + 32 + 16 + 4 + 2 = 182'),
  formel('n-mz-3', 'md-zahlensysteme', 'Dezimal -> binär: Divisionsrest',
      'Die Zahl wird so lange durch 2 geteilt, bis 0 herauskommt. Die Reste von unten nach oben gelesen ergeben die Binärzahl.',
      '156 : 2 = 78 Rest 0\n'
          '78 : 2 = 39 Rest 0\n'
          '39 : 2 = 19 Rest 1\n'
          '19 : 2 = 9 Rest 1\n'
          '9 : 2 = 4 Rest 1\n'
          '4 : 2 = 2 Rest 0\n'
          '2 : 2 = 1 Rest 0\n'
          '1 : 2 = 0 Rest 1\n'
          '-> 1001 1100',
      merksatz: 'Probe: 128 + 16 + 8 + 4 = 156.'),
  formel('n-mz-4', 'md-zahlensysteme', 'Hexadezimal mit dem Nibble-Trick',
      'Vier Bit (ein Nibble) ergeben genau eine Hex-Ziffer. So rechnet man zwischen binär und hex ohne Umweg über dezimal.',
      '1001 1100\n'
          '   9    C  -> 9C\n'
          'Hex -> dezimal:\n'
          '9 × 16 + 12 × 1 = 156',
      points: [
        'Oktal funktioniert genauso mit Dreiergruppen: 010 011 100 = 234 (oktal)',
        'Für dezimal -> hex geht auch das Divisionsrestverfahren mit 16',
      ]),
  falle('n-mz-5', 'md-zahlensysteme', 'Rückwärts gelesen',
      'Beim Divisionsrestverfahren liest man die Reste von unten nach oben. Wer von oben liest, erhält die Zahl spiegelverkehrt: 0011 1001 statt 1001 1100. Und Hex-Buchstaben sind Ziffern: B steht für den Wert 11.',
      merksatz: '1 Byte = 8 Bit = 2 Hex-Ziffern: Werte von 0 bis 255 bzw. 00 bis FF.'),

  // ============================================================= Zeichensätze
  konzept('n-mc-1', 'md-zeichen', 'Zeichen sind Zahlen',
      'Ein Computer speichert Buchstaben als Zahlen. Ein Zeichensatz legt fest, welche Zahl für welches Zeichen steht, eine Kodierung, wie diese Zahl als Bytes gespeichert wird. Beispiel: „A“ hat den Wert 65 (hex 41).'),
  vergleich('n-mc-2', 'md-zeichen', 'Von ASCII zu Unicode',
      'Jeder neue Zeichensatz löste das Platzproblem des vorigen.',
      [
        ['Zeichensatz', 'Umfang', 'Inhalt'],
        ['ASCII', '7 Bit, 128 Zeichen', 'englische Buchstaben, Ziffern, Steuerzeichen'],
        ['ISO 8859-1 (Latin-1)', '8 Bit, 256 Zeichen', 'westeuropäisch, mit ä, ö, ü, ß'],
        ['Unicode', 'über 1,1 Mio. Codepoints', 'alle Schriften, Symbole, Emojis'],
      ]),
  vergleich('n-mc-3', 'md-zeichen', 'UTF-8 - variable Länge',
      'UTF-8 speichert jeden Unicode-Codepoint in 1 bis 4 Byte. Die ersten 128 Zeichen sind identisch mit ASCII - eine reine ASCII-Datei ist also gültiges UTF-8.',
      [
        ['Zeichen', 'Codepoint', 'UTF-8'],
        ['A', 'U+0041', '1 Byte'],
        ['ä', 'U+00E4', '2 Byte'],
        ['€', 'U+20AC', '3 Byte'],
        ['Emoji (Smiley)', 'U+1F600', '4 Byte'],
      ]),
  formel('n-mc-4', 'md-zeichen', 'Bytes zählen',
      'Wie groß ist das Wort „Grüße“ in UTF-8? Jedes Zeichen wird einzeln gezählt.',
      'G  r  ü  ß  e\n'
          '1 +1 +2 +2 +1 = 7 Byte\n'
          'Latin-1: 5 × 1 = 5 Byte',
      points: [
        'UTF-16 nutzt 2 oder 4 Byte je Zeichen - „Grüße“ braucht dort 10 Byte',
      ]),
  falle('n-mc-5', 'md-zeichen', 'Mojibake',
      'Wird UTF-8-Text als Latin-1 gelesen, erscheinen aus einem Umlaut zwei fremde Zeichen: Aus „Müller“ wird „MÃ¼ller“. Die Daten sind nicht kaputt, nur falsch interpretiert. Abhilfe: überall dieselbe Kodierung festlegen, z. B. UTF-8 in Datenbank, Datei und HTML-Kopf.',
      merksatz: 'ASCII: 7 Bit. UTF-8: 1 bis 4 Byte, ASCII-kompatibel, Umlaute brauchen 2 Byte.'),

  // ======================================================= Datenmengen berechnen
  vergleich('n-md-1', 'md-datenmengen', 'Bit, Byte und Präfixe',
      '1 Byte = 8 Bit. Hersteller rechnen dezimal, Betriebssysteme oft binär - jede Aufgabe muss sagen, welche Einheit gemeint ist.',
      [
        ['Dezimal (SI)', 'Binär (IEC)'],
        ['1 kB = 1.000 Byte', '1 KiB = 1.024 Byte'],
        ['1 MB = 1.000² Byte', '1 MiB = 1.024² Byte'],
        ['1 GB = 1.000³ Byte', '1 GiB = 1.024³ Byte'],
      ]),
  formel('n-md-2', 'md-datenmengen', 'Bilder',
      'Ein unkomprimiertes Rasterbild speichert für jedes Pixel so viele Bit, wie die Farbtiefe angibt.',
      'Bit = Breite × Höhe × Farbtiefe\n'
          '\n'
          '1920 × 1080 × 24 Bit\n'
          '= 49.766.400 Bit\n'
          '= 6.220.800 Byte ≈ 6,22 MB',
      merksatz: '24 Bit Farbtiefe = 3 Byte pro Pixel = 2²⁴ = 16.777.216 Farben.'),
  formel('n-md-3', 'md-datenmengen', 'Audio',
      'Bei Audio wird das Signal viele Male pro Sekunde abgetastet. Jeder Messwert hat eine feste Bittiefe, und das für jeden Kanal.',
      'Bit = Abtastrate × Bittiefe\n'
          '      × Kanäle × Sekunden\n'
          '\n'
          'CD-Qualität, 1 Minute Stereo:\n'
          '44.100 × 16 × 2 × 60\n'
          '= 84.672.000 Bit\n'
          '= 10.584.000 Byte ≈ 10,6 MB'),
  formel('n-md-4', 'md-datenmengen', 'Video',
      'Unkomprimiertes Video ist eine Folge von Einzelbildern. Die Bildgröße wird mit den Bildern pro Sekunde und der Dauer multipliziert.',
      'Bit = Breite × Höhe × Farbtiefe\n'
          '      × Bilder/s × Sekunden\n'
          '\n'
          '1280 × 720 × 24 × 25 × 1 s\n'
          '= 552.960.000 Bit\n'
          '= 69.120.000 Byte ≈ 69 MB',
      merksatz: 'Schon eine Sekunde HD-Video ohne Ton sind rund 69 MB - deshalb wird Video praktisch immer komprimiert.'),
  falle('n-md-5', 'md-datenmengen', 'Bit, Byte, MB und MiB',
      'Die häufigsten Fehler: Farbtiefe in Bit nicht durch 8 geteilt, Stereo vergessen (× 2) oder dezimal und binär gemischt. 6.220.800 Byte sind 6,22 MB, aber nur 5,93 MiB.'),
  merke('n-md-6', 'md-datenmengen', 'Das Rechenschema',
      'Ein fester Ablauf verhindert Einheitenfehler bei jeder Datenmengen-Aufgabe.',
      satz: 'Erst alles in Bit ausrechnen, dann durch 8 teilen, dann in die geforderte Einheit umrechnen.'),

  // ================================================== Übertragungsdauer berechnen
  konzept('n-mu-1', 'md-uebertragung', 'Datenrate in Bit pro Sekunde',
      'Anbieter geben Datenraten in Bit pro Sekunde an, und zwar dezimal: 1 Mbit/s sind 1.000.000 Bit/s. Dateigrößen stehen dagegen meist in Byte. Für die Dauer müssen beide Angaben in dieselbe Einheit.'),
  formel('n-mu-2', 'md-uebertragung', 'Die Grundformel',
      'Die Übertragungsdauer ergibt sich aus Datenmenge und Datenrate.',
      'Dauer (s) = Datenmenge (Bit)\n'
          '            / Datenrate (Bit/s)\n'
          '\n'
          '1 Byte = 8 Bit\n'
          '1 Mbit/s = 1.000.000 Bit/s',
      merksatz: 'Byte × 8 = Bit - erst dann durch die Datenrate teilen.'),
  ablauf('n-mu-3', 'md-uebertragung', 'Durchgerechnet',
      'Beispiel: Ein 500-MB-Update (1 MB = 1.000.000 Byte) wird mit 50 Mbit/s geladen.',
      [
        'Byte in Bit: 500 MB × 8 = 4.000 Mbit',
        'Durch die Datenrate teilen: 4.000 Mbit / 50 Mbit/s = 80 s',
        'Bei Bedarf umrechnen: 80 s = 1 min 20 s',
      ]),
  vergleich('n-mu-4', 'md-uebertragung', 'Upload, Download, Overhead',
      'Die tatsächliche Dauer hängt von mehr als der Tarifangabe ab.',
      [
        ['Einfluss', 'Wirkung'],
        ['Upload', 'oft deutlich langsamer als Download, z. B. 250/40 Mbit/s'],
        ['Overhead', 'Protokoll-Header kosten Bandbreite, die Nutzdatenrate sinkt'],
        ['geteilte Leitung', 'mehrere Nutzer teilen sich die Bandbreite'],
      ]),
  falle('n-mu-5', 'md-uebertragung', 'Faktor 8 vergessen',
      'Der Klassiker: 500 MB bei 50 Mbit/s dauern nicht 10 s, sondern 80 s - Megabyte und Megabit unterscheiden sich um den Faktor 8. Bei einem Backup in die Cloud zählt außerdem die Upload-Rate, nicht die Download-Rate.',
      merksatz: 'Dauer = Datenmenge in Bit / Datenrate in Bit pro Sekunde.'),

  // =================================================== Kompression und Formate
  vergleich('n-mx-1', 'md-kompression', 'Verlustfrei oder verlustbehaftet',
      'Kompression verkleinert Daten. Entscheidend ist, ob das Original danach Bit für Bit zurückkommt.',
      [
        ['', 'verlustfrei', 'verlustbehaftet'],
        ['Prinzip', 'Redundanz entfernen', 'unwichtige Details weglassen'],
        ['Original', 'exakt wiederherstellbar', 'nicht wiederherstellbar'],
        ['Beispiele', 'ZIP, PNG, FLAC', 'JPEG, MP3, AAC, H.264, H.265'],
      ]),
  formel('n-mx-2', 'md-kompression', 'Lauflängenkodierung (RLE)',
      'RLE ersetzt eine Folge gleicher Zeichen durch Anzahl und Zeichen. Das Verfahren ist verlustfrei.',
      'AAAAABBBCCCCCCCC (16 Zeichen)\n'
          '-> 5A3B8C (6 Zeichen)',
      merksatz: 'Bei ständig wechselnden Zeichen wird es länger: ABCD -> 1A1B1C1D.'),
  formel('n-mx-3', 'md-kompression', 'Kompression bewerten',
      'Das Ergebnis gibt man als Faktor oder als Einsparung in Prozent an. Der Begriff „Kompressionsrate“ wird uneinheitlich verwendet - rechne immer genau das, was die Aufgabe fragt.',
      'Faktor = Original / komprimiert\n'
          'Einsparung = (1 - kompr./Orig.)\n'
          '             × 100 %\n'
          '\n'
          'RLE-Beispiel 16 -> 6 Zeichen:\n'
          'Faktor = 16 / 6 ≈ 2,67\n'
          'Einsparung = (1 - 6/16) × 100\n'
          '           = 62,5 %'),
  vergleich('n-mx-4', 'md-kompression', 'Raster oder Vektor',
      'Unabhängig von der Kompression unterscheiden sich Grafikformate darin, wie sie ein Bild beschreiben.',
      [
        ['', 'Raster', 'Vektor'],
        ['speichert', 'Pixel', 'Formen, Linien, Kurven'],
        ['Vergrößern', 'wird pixelig', 'bleibt scharf'],
        ['Formate', 'JPEG, PNG', 'SVG'],
        ['Einsatz', 'Fotos', 'Logos, Icons, Diagramme'],
      ]),
  falle('n-mx-5', 'md-kompression', 'Das falsche Format',
      'JPEG erzeugt an harten Kanten und Schrift sichtbare Artefakte und kennt keine Transparenz - für Logos und Screenshots sind PNG oder SVG besser. Umgekehrt werden Fotos als PNG unnötig groß. Und ein JPEG, das man als PNG speichert, bekommt verlorene Details nicht zurück.',
      merksatz: 'Verlustbehaftet ist unumkehrbar: Was einmal weggelassen wurde, bleibt weg.'),

  // ============================================================ KI-Grundlagen
  konzept('n-ig-1', 'ki-grundlagen', 'Was KI heißt',
      'Künstliche Intelligenz (KI) bezeichnet Systeme, die Aufgaben lösen, für die man sonst menschliche Intelligenz braucht - etwa Sprache verstehen oder Bilder erkennen. Heutige Systeme gelten als schwache KI: stark in einem Aufgabenfeld, ohne menschenähnliches Verständnis. Eine starke KI mit allgemeiner Intelligenz wie ein Mensch gibt es bisher nicht.'),
  vergleich('n-ig-2', 'ki-grundlagen', 'Drei Arten des maschinellen Lernens',
      'Beim Machine Learning (ML) wird ein Modell nicht Regel für Regel programmiert, sondern aus Trainingsdaten gelernt.',
      [
        ['Art', 'Daten', 'Beispiel'],
        ['überwacht', 'Beispiele mit richtiger Antwort (Label)', 'Spamfilter aus markierten E-Mails'],
        ['unüberwacht', 'Daten ohne Label', 'Kunden in Gruppen einteilen'],
        ['bestärkend', 'Belohnung für gute Aktionen', 'Roboter lernt Greifen'],
      ]),
  konzept('n-ig-3', 'ki-grundlagen', 'Neuronale Netze und Deep Learning',
      'Ein künstliches neuronales Netz besteht aus Schichten von Neuronen, die über gewichtete Verbindungen verknüpft sind. Beim Training werden die Gewichte so lange angepasst, bis die Ausgaben passen. Deep Learning nutzt Netze mit vielen verborgenen Schichten - die Grundlage heutiger Bild- und Spracherkennung.'),
  ablauf('n-ig-4', 'ki-grundlagen', 'Wie ein Sprachmodell antwortet',
      'Ein großes Sprachmodell (LLM) ist generative KI: Es erzeugt neue Texte, statt nur einzuordnen. Beispiel: Der Prompt lautet „Die Hauptstadt von Frankreich ist“.',
      [
        'Der Text wird in Tokens zerlegt - Wörter, Wortteile oder Satzzeichen',
        'Das Modell berechnet für jedes mögliche nächste Token eine Wahrscheinlichkeit',
        'Ein wahrscheinliches Token wird gewählt, hier „Paris“',
        'Das Token wird angehängt, und der Vorgang wiederholt sich bis zum Ende der Antwort',
      ]),
  falle('n-ig-5', 'ki-grundlagen', 'Wahrscheinlich ist nicht wahr',
      'Ein Sprachmodell schlägt nicht in einer Faktendatenbank nach, sondern erzeugt wahrscheinlichen Text. Der klingt fast immer flüssig, ist aber nicht automatisch richtig. Außerdem kennt das Modell nur Wissen bis zum Stand seiner Trainingsdaten, sofern es nicht zusätzlich z. B. im Web sucht.',
      merksatz: 'KI umfasst Machine Learning, Machine Learning umfasst Deep Learning. Ein LLM sagt das jeweils nächste Token vorher.'),

  // ======================================================= KI im Arbeitsalltag
  vergleich('n-ie-1', 'ki-einsatz', 'Einsatzfelder im IT-Alltag',
      'KI-Werkzeuge entlasten vor allem bei Routinearbeit mit Text und Code.',
      [
        ['Einsatz', 'Beispiel'],
        ['Code-Assistenz', 'Funktion vorschlagen, Fehler erklären, Tests entwerfen'],
        ['Support-Chatbot', 'Standardfragen rund um die Uhr beantworten'],
        ['Zusammenfassen', 'langen Ticketverlauf auf fünf Punkte kürzen'],
        ['Klassifizieren', 'neue Tickets nach Kategorie und Dringlichkeit sortieren'],
        ['Formulieren', 'Kundenmail in klarer Sprache entwerfen'],
      ]),
  vergleich('n-ie-2', 'ki-einsatz', 'Bausteine eines guten Prompts',
      'Ein Sprachmodell kennt die Situation nur aus dem Prompt. Je genauer er ist, desto brauchbarer die Antwort.',
      [
        ['Baustein', 'Beispiel'],
        ['Rolle', 'Du arbeitest im Support eines Webshops.'],
        ['Kontext', 'Die Kundin wartet seit 10 Tagen auf ihr Paket.'],
        ['Aufgabe', 'Formuliere eine Antwortmail.'],
        ['Format', 'höflich, höchstens 120 Wörter, mit Betreff'],
        ['Beispiele', 'eine frühere, gelungene Antwort als Muster'],
      ]),
  ablauf('n-ie-3', 'ki-einsatz', 'Vom Prompt zum geprüften Ergebnis',
      'Beispiel: Ein Azubi lässt sich eine Funktion schreiben, die Postleitzahlen prüft.',
      [
        'Prompt mit Rolle, Kontext, Aufgabe und Format formulieren',
        'Antwort lesen und verstehen - nicht einfach übernehmen',
        'Fachlich prüfen: Tests ausführen, Grenzfälle wie „01067“ mit führender Null testen',
        'Nachschärfen: Fehler oder fehlende Punkte im nächsten Prompt benennen',
        'Erst das geprüfte Ergebnis einsetzen - die Verantwortung bleibt beim Menschen',
      ]),
  konzept('n-ie-4', 'ki-einsatz', 'Wann KI nicht passt',
      'Für Aufgaben mit festen Regeln - etwa eine Rechnungssumme mit Mehrwertsteuer berechnen - ist ein normales Programm zuverlässiger und günstiger. KI lohnt sich bei unscharfen Aufgaben mit Sprache, Bildern und Mustern.'),
  falle('n-ie-5', 'ki-einsatz', 'Geprüft wird immer',
      'KI-Code kann veraltete Bibliotheken, Sicherheitslücken oder frei erfundene Funktionen enthalten, eine Kundenantwort falsche Zusagen. Wer das Ergebnis ungeprüft weitergibt, trägt die Verantwortung - nicht das Werkzeug.',
      merksatz: 'Prompt = Rolle + Kontext + Aufgabe + Format (+ Beispiele). Das Ergebnis wird immer geprüft.'),

  // ================================================= Grenzen, Risiken und Recht
  konzept('n-ir-1', 'ki-grenzen', 'Halluzinationen',
      'Eine Halluzination ist eine überzeugend formulierte, aber falsche oder erfundene Ausgabe - etwa ein Gesetzesparagraf, den es nicht gibt, oder eine Quelle mit erfundenem Titel. Sie entsteht, weil das Modell wahrscheinliche statt geprüfte Texte erzeugt.'),
  vergleich('n-ir-2', 'ki-grenzen', 'Weitere Risiken',
      'Neben Halluzinationen gibt es Risiken, die rechtliche Folgen haben können.',
      [
        ['Risiko', 'Beispiel'],
        ['Bias (Verzerrung)', 'Bewerbungs-KI benachteiligt Frauen, weil früher meist Männer eingestellt wurden'],
        ['Datenschutz', 'Kundendaten landen in einem öffentlichen Chatbot'],
        ['Urheberrecht', 'Ausgabe gleicht stark einem geschützten Werk'],
        ['Transparenz', 'Nutzer merken nicht, dass sie mit einer KI sprechen'],
      ]),
  ablauf('n-ir-3', 'ki-grenzen', 'Sicher mit KI-Werkzeugen arbeiten',
      'Beispiel: Ein Mitarbeiter will eine Kundenbeschwerde mit einem Chatbot beantworten lassen.',
      [
        'Prüfen, ob das Werkzeug im Unternehmen freigegeben ist',
        'Keine personenbezogenen oder vertraulichen Daten in öffentliche Tools eingeben - Namen, Kundennummern, Passwörter vorher entfernen',
        'Ausgabe auf Fakten prüfen, Quellen gegenchecken',
        'KI-Einsatz kennzeichnen, wo andere davon wissen müssen',
      ]),
  vergleich('n-ir-4', 'ki-grenzen', 'Die EU-KI-Verordnung (AI Act)',
      'Die KI-Verordnung der EU ist seit 1. August 2024 in Kraft und gilt stufenweise; die Verbote gelten seit 2. Februar 2025. Sie teilt KI-Systeme nach ihrem Risiko ein.',
      [
        ['Risiko', 'Beispiel', 'Folge'],
        ['unannehmbar', 'Social Scoring', 'verboten'],
        ['hoch', 'Bewerberauswahl, Kreditprüfung', 'strenge Pflichten, z. B. menschliche Aufsicht'],
        ['begrenzt', 'Chatbot, Deepfake', 'Transparenz: KI kenntlich machen'],
        ['minimal', 'Spamfilter, KI in Spielen', 'keine besonderen Pflichten'],
      ]),
  falle('n-ir-5', 'ki-grenzen', 'KI-Ergebnis heißt nicht rechtefrei',
      'Reine KI-Erzeugnisse ohne menschlichen schöpferischen Beitrag sind in Deutschland in der Regel nicht urheberrechtlich geschützt - trotzdem kann eine Ausgabe ein fremdes Werk verletzen. Und die DSGVO gilt auch hier: Wer personenbezogene Daten eingibt, verarbeitet sie.',
      merksatz: 'AI Act: Je höher das Risiko, desto strenger die Regeln - von verboten bis frei.'),
];
