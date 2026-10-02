import '../../models/question.dart';
import '../builders.dart';

/// Fallaufgaben (je 25 Punkte) zu Bereich 04, Teil 2 für die Prüfungssimulation.
///
/// Aufbau, Operatoren und Punktverteilung folgen den AP1-Prüfungen 2025/2026
/// (ER-Modell mit 8 Punkten, Datenmengen-Kette, englisches Material, KI und
/// Web als Freitext) - mit eigenen Betrieben, Zahlen und Formulierungen.
final List<ExamCase> casesA04Daten = [
  // =========================================================== Systemhaus (1)
  fall(
    'f-a04d-systemhaus',
    firma: 'systemhaus',
    bereich: 'a04',
    titel: 'Geräteverwaltung und Belegarchiv der Kanzlei',
    situation:
        'Die Steuerkanzlei Albers & Partner will ihre IT-Geräte künftig in einer Datenbank verwalten und Papierbelege einscannen und digital archivieren. Die Kessler & Brandt IT-Systemhaus GmbH plant beides. Du arbeitest am Datenmodell mit, schätzt den Speicherbedarf ab und bereitest eine Empfehlung zum Einsatz von KI bei der Belegerfassung vor.',
    teile: [
      freitext(
        'f-a04d-systemhaus-a',
        'dm-schluessel',
        scenario:
            'Zur Einarbeitung hast du einen Abschnitt aus einem englischen Fachbuch über Datenbanken erhalten.',
        code:
            'Good database design starts\n'
            'with keys. The primary key is\n'
            'a column whose value\n'
            'identifies exactly one record\n'
            'in a table. A foreign key in\n'
            'another table points to this\n'
            'primary key. By linking tables\n'
            'in this way, each fact is\n'
            'stored only once, which saves\n'
            'storage space and prevents\n'
            'contradictory data.',
        prompt:
            'Beschreibe auf Deutsch anhand des Textes die Aufgabe des Primärschlüssels und einen Vorteil verknüpfter Tabellen.',
        kriterien: [
          krit(
            'Primärschlüssel: Spalte, deren Wert genau einen Datensatz einer Tabelle identifiziert.',
            punkte: 2,
            stichwoerter: [
              'identifiziert',
              'eindeutig',
              'genau einen Datensatz',
              'einen Datensatz',
            ],
          ),
          krit(
            'Vorteil: Jede Information wird nur einmal gespeichert, das spart Speicherplatz.',
            punkte: 2,
            stichwoerter: [
              'nur einmal',
              'einmal gespeichert',
              'Speicherplatz',
              'Redundanz',
            ],
          ),
          krit(
            'Vorteil: Widersprüchliche Daten werden verhindert.',
            punkte: 2,
            stichwoerter: [
              'widersprüchlich',
              'Widerspruch',
              'inkonsistent',
              'Inkonsistenz',
            ],
          ),
        ],
        loesung:
            'Der Primärschlüssel ist eine Spalte, deren Wert genau einen Datensatz einer Tabelle identifiziert. Durch die Verknüpfung über Fremdschlüssel wird jede Information nur einmal gespeichert; das spart Speicherplatz und verhindert widersprüchliche Daten.',
        explanation:
            'Für die Aufgabe des Primärschlüssels gibt es 2 Punkte, für einen Vorteil ebenfalls 2. Der Text nennt zwei Vorteile (Speicherplatz, keine widersprüchlichen Daten). Antworte auf Deutsch und mit Bezug zum Text.',
        punkte: 4,
        tags: ['englisch'],
      ),
      zuordnen(
        'f-a04d-systemhaus-b',
        'dm-erm',
        scenario:
            'Für die Geräteverwaltung gelten diese Regeln:\n'
            '- Ein Mitarbeiter nutzt mehrere Geräte; manche Geräte (z. B. der Besprechungslaptop) werden von mehreren Mitarbeitern genutzt.\n'
            '- Zu jeder Nutzung werden Ausgabe- und Rückgabedatum festgehalten.\n'
            '- Jedes Gerät stammt von genau einem Lieferanten; ein Lieferant liefert viele Geräte.',
        skizze: ErmDiagramm(
          [
            ErmEntitaet('Mitarbeiter'),
            ErmEntitaet('Gerät'),
            ErmEntitaet('Lieferant'),
          ],
          beziehungen: [
            ErmBeziehung('Mitarbeiter', 'nutzt', 'Gerät', '?', '?'),
            ErmBeziehung('Gerät', 'stammt von', 'Lieferant', '?', '?'),
          ],
        ),
        prompt:
            'Ergänze das ER-Modell: Ordne jedes Attribut dem Element zu, an dem es eingetragen wird.',
        buckets: ['Mitarbeiter', 'Gerät', 'Lieferant', 'Beziehung „nutzt“'],
        items: [
          zu('Inventarnummer', 1, 'Kennzeichnet genau ein Gerät.'),
          zu(
            'Ausgabedatum',
            3,
            'Gehört zur einzelnen Nutzung eines Geräts durch einen Mitarbeiter.',
          ),
          zu('Personalnummer', 0, 'Kennzeichnet genau einen Mitarbeiter.'),
          zu('Firmenname', 2, 'Eigenschaft des Lieferanten.'),
          zu('Gerätetyp', 1, 'Eigenschaft des Geräts.'),
          zu(
            'Rückgabedatum',
            3,
            'Gehört zur einzelnen Nutzung, nicht zum Gerät allein.',
          ),
          zu('Nachname', 0, 'Eigenschaft des Mitarbeiters.'),
          zu('Kaufdatum', 1, 'Jedes Gerät wurde genau einmal gekauft.'),
        ],
        explanation:
            'Je richtig zugeordnetem Attribut ein halber Punkt. Ausgabe- und Rückgabedatum beschreiben die Kombination aus Mitarbeiter und Gerät und gehören deshalb an die Beziehung „nutzt“. Das Kaufdatum gibt es dagegen je Gerät nur einmal.',
        punkte: 4,
        difficulty: 3,
      ),
      lueckentext(
        'f-a04d-systemhaus-c',
        'dm-kardinalitaet',
        scenario:
            'Es gelten weiter die Regeln der Geräteverwaltung: Ein Mitarbeiter nutzt mehrere Geräte, ein Gerät kann von mehreren Mitarbeitern genutzt werden. Jedes Gerät stammt von genau einem Lieferanten, ein Lieferant liefert viele Geräte.',
        prompt: 'Ergänze die Kardinalitäten und die Folge für die Tabellen.',
        text:
            'Mitarbeiter - Gerät: {0}\n'
            'Gerät - Lieferant: {1}\n'
            'Eine Zwischentabelle ist nötig für die Beziehung {2}.',
        luecken: [
          wahl('n:m', ['1:n', 'n:1', '1:1'], 'Viele auf beiden Seiten.'),
          wahl('n:1', [
            '1:n',
            'n:m',
            '1:1',
          ], 'Viele Geräte gehören zu einem Lieferanten.'),
          wahl('nutzt', [
            'stammt von',
            'beide Beziehungen',
          ], 'Nur n:m-Beziehungen brauchen eine Zwischentabelle.'),
        ],
        explanation:
            'Mitarbeiter - Gerät ist n:m (viele auf beiden Seiten) und wird über eine Zwischentabelle umgesetzt. Gerät - Lieferant ist n:1, denn viele Geräte stammen von einem Lieferanten. Hier genügt der Fremdschlüssel LieferantNr in der Tabelle Gerät.',
        punkte: 3,
      ),
      markieren(
        'f-a04d-systemhaus-d',
        'dm-schluessel',
        scenario:
            'Für die drei Entitätstypen Mitarbeiter, Gerät und Lieferant sind die Primärschlüssel festzulegen.',
        prompt: 'Markiere alle Attribute, die sich als Primärschlüssel eignen.',
        zeilen: [
          ja(
            'Personalnummer',
            'Eindeutig, stabil und nie leer, damit identifiziert sie einen Mitarbeiter.',
          ),
          nein('Nachname', 'Mehrere Mitarbeiter können gleich heißen.'),
          ja('Inventarnummer', 'Wird je Gerät genau einmal vergeben.'),
          nein('Gerätetyp', 'Viele Geräte haben denselben Typ.'),
          ja(
            'Lieferantennummer',
            'Vom System vergeben und eindeutig je Lieferant.',
          ),
          nein(
            'Kaufdatum',
            'An einem Tag können mehrere Geräte gekauft werden.',
          ),
        ],
        explanation:
            'Ein Primärschlüssel muss jeden Datensatz eindeutig identifizieren, darf nie leer sein und soll sich nicht ändern. Das leisten die vergebenen Nummern; Namen, Typen und Datumsangaben können mehrfach vorkommen.',
        punkte: 2,
        difficulty: 1,
      ),
      lueckentext(
        'f-a04d-systemhaus-e',
        'md-datenmengen',
        scenario:
            'Die Kanzlei scannt Belege an 4 Scanplätzen. An jedem Platz werden 8 Stunden am Tag im Durchschnitt 9 Belege pro Stunde gescannt. Ein Scan ist 310 kB groß (1 kB = 1.000 Byte, 1 KiB = 1.024 Byte).',
        prompt: 'Ermittle den Speicherbedarf pro Tag. Runde auf volle KiB auf.',
        text:
            'Belege pro Tag: {0}\n'
            'Speicherbedarf pro Tag in KiB: {1}',
        luecken: [
          zahl(288, rationale: '4 × 8 × 9.'),
          zahl(87188, toleranz: 0.5, rationale: '288 × 310 × 1.000 / 1.024.'),
        ],
        explanation:
            '4 Plätze × 8 h × 9 Belege = 288 Belege pro Tag (1 Punkt). 288 × 310 kB = 89.280 kB = 89.280.000 Byte; / 1.024 = 87.187,5 -> 87.188 KiB (2 Punkte). Achte auf die Einheiten: kB ist dezimal (1.000), KiB binär (1.024).',
        punkte: 3,
      ),
      lueckentext(
        'f-a04d-systemhaus-f',
        'md-datenmengen',
        scenario:
            'Pro Tag fallen 87.188 KiB an gescannten Belegen an. Die Kanzlei arbeitet an 250 Tagen im Jahr. Das Archivsystem verringert den Speicherbedarf durch Kompression um 35 %.',
        prompt:
            'Ermittle den Jahresbedarf. Runde das Endergebnis auf zwei Nachkommastellen.',
        text:
            'Speicherbedarf pro Jahr in KiB: {0}\n'
            'Jahresbedarf in GiB mit Kompression: {1}',
        luecken: [
          zahl(21797000, rationale: '87.188 × 250.'),
          zahl(
            13.51,
            toleranz: 0.01,
            einheit: 'GiB',
            rationale: '21.797.000 / 1.024 / 1.024 × 0,65.',
          ),
        ],
        explanation:
            '87.188 × 250 = 21.797.000 KiB (1 Punkt). / 1.024 / 1.024 = 20,79 GiB; „um 35 % verringern“ heißt, es bleiben 65 %: × 0,65 ≈ 13,51 GiB (2 Punkte).',
        punkte: 3,
        difficulty: 3,
      ),
      rechnen(
        'f-a04d-systemhaus-g',
        'md-datenmengen',
        scenario:
            'Die Kanzlei bucht für das Belegarchiv 14 GiB Speicher bei einem Rechenzentrum. Speicher gibt es nur in Paketen zu je 4 GiB; ein Paket kostet 16 € pro Jahr. Der gebuchte Speicher bleibt über die Laufzeit gleich.',
        prompt: 'Ermittle die Speicherkosten für 6 Jahre.',
        answer: 384,
        unit: '€',
        explanation:
            '14 / 4 = 3,5 -> 4 Pakete (aufrunden). 4 × 16 € = 64 € pro Jahr. 64 € × 6 Jahre = 384 €.',
        punkte: 2,
        difficulty: 1,
      ),
      freitext(
        'f-a04d-systemhaus-h',
        'ki-einsatz',
        scenario:
            'Bisher tippen Mitarbeitende der Kanzlei Rechnungsdaten wie Datum, Betrag und Absender von Hand aus den gescannten Belegen ab. Künftig soll eine KI diese Daten automatisch erkennen und den passenden Mandanten vorschlagen.',
        prompt:
            'Beschreibe zwei Argumente, die für die KI-gestützte Belegerfassung sprechen.',
        kriterien: [
          krit(
            'Zeitersparnis: Das Abtippen entfällt, Belege werden schneller verarbeitet.',
            punkte: 2,
            stichwoerter: [
              'Zeitersparnis',
              'schneller',
              'Zeit',
              'Abtippen entfällt',
            ],
          ),
          krit(
            'Weniger Fehler: Tippfehler und Zahlendreher beim manuellen Erfassen werden vermieden.',
            punkte: 2,
            stichwoerter: [
              'weniger Fehler',
              'Tippfehler',
              'Zahlendreher',
              'Fehlerquote',
            ],
          ),
          krit(
            'Entlastung: Mitarbeitende haben mehr Zeit für anspruchsvolle Aufgaben, und die Kosten sinken.',
            punkte: 2,
            stichwoerter: [
              'Entlastung',
              'Routine',
              'Kosten',
              'anspruchsvolle Aufgaben',
            ],
          ),
          krit(
            'Lernendes System: Es erkennt Muster und wird mit jeder Korrektur besser; mehr Belege sind ohne zusätzliches Personal möglich.',
            punkte: 2,
            stichwoerter: [
              'Muster',
              'lernt',
              'skalierbar',
              'ohne zusätzliches Personal',
            ],
          ),
        ],
        loesung:
            'Erstens spart die automatische Erkennung Zeit: Datum, Betrag und Absender müssen nicht mehr abgetippt werden. Zweitens sinkt die Fehlerquote, weil Tippfehler und Zahlendreher entfallen. Weitere Argumente: Die Mitarbeitenden werden von Routinearbeit entlastet, das System lernt aus Korrekturen und bewältigt mehr Belege ohne zusätzliches Personal.',
        explanation:
            'Je beschriebenem Argument 2 Punkte, verlangt sind zwei. Typische Antworten: Zeitersparnis, weniger Fehler, Kostenreduktion, Mustererkennung, Skalierbarkeit ohne mehr Personal. Die Vorschläge der KI werden trotzdem stichprobenartig geprüft.',
        punkte: 4,
      ),
    ],
  ),

  // =============================================================== Handel
  fall(
    'f-a04d-handel',
    firma: 'handel',
    bereich: 'a04',
    titel: 'Website und Webshop-Daten für die Filiale Göttingen',
    situation:
        'Zur Eröffnung der Filiale Göttingen überarbeitet die Grünwerk Gartenbedarf GmbH ihren Internetauftritt. Die bisher statischen Filialseiten sollen dynamisch werden, das Datenmodell des Webshops wird geprüft und für alle Artikel entstehen neue Produktfotos. Du unterstützt die IT-Abteilung bei diesen Arbeiten.',
    teile: [
      freitext(
        'f-a04d-handel-a',
        'wi-aufruf',
        scenario:
            'Die Filialseiten mit Öffnungszeiten und Angeboten sind bisher statisch. Die Geschäftsleitung fragt, was eine dynamische Website davon unterscheidet.',
        prompt:
            'Erläutere den Unterschied zwischen einer statischen und einer dynamischen Website.',
        kriterien: [
          krit(
            'Statisch: fertige Dateien auf dem Server, jeder Besucher sieht denselben Inhalt.',
            punkte: 2,
            stichwoerter: [
              'fertige Dateien',
              'feste Dateien',
              'denselben Inhalt',
              'gleichen Inhalt',
            ],
          ),
          krit(
            'Dynamisch: Die Seite wird beim Aufruf auf dem Server erzeugt, oft aus einer Datenbank; Inhalte hängen von Nutzer oder Eingabe ab.',
            punkte: 2,
            stichwoerter: [
              'beim Aufruf',
              'erzeugt',
              'generiert',
              'Datenbank',
              'serverseitig',
            ],
          ),
        ],
        loesung:
            'Eine statische Website besteht aus fertigen Dateien, die der Server unverändert ausliefert. Alle Besucher sehen dasselbe. Eine dynamische Website wird bei jedem Aufruf von einem Programm auf dem Server erzeugt, meist aus einer Datenbank. Ihr Inhalt kann vom Nutzer oder von Eingaben abhängen und über ein Redaktionssystem gepflegt werden.',
        explanation:
            'Für die volle Punktzahl müssen beide Seiten des Vergleichs erkennbar sein. Statisch heißt: feste Dateien, gleicher Inhalt für alle. Dynamisch heißt: beim Aufruf auf dem Server erzeugt, abhängig von Nutzer oder Eingabe.',
        punkte: 3,
      ),
      freitext(
        'f-a04d-handel-b',
        'wi-aufruf',
        scenario:
            'Für die dynamischen Filialseiten muss ein Programm auf dem Webserver laufen.',
        prompt:
            'Nenne drei Programmiersprachen, mit denen dynamische Webinhalte erzeugt werden können.',
        kriterien: [
          krit(
            'PHP als Sprache für dynamische Webinhalte',
            stichwoerter: ['PHP'],
          ),
          krit(
            'Python als Sprache für dynamische Webinhalte',
            stichwoerter: ['Python'],
          ),
          krit(
            'JavaScript (z. B. mit Node.js)',
            stichwoerter: ['JavaScript', 'Node.js', 'Node', 'TypeScript'],
          ),
          krit(
            'Java als Sprache für dynamische Webinhalte',
            stichwoerter: ['Java'],
          ),
          krit(
            'C# (ASP.NET)',
            stichwoerter: ['C#', 'CSharp', 'ASP.NET', 'ASP'],
          ),
          krit(
            'Ruby als Sprache für dynamische Webinhalte',
            stichwoerter: ['Ruby'],
          ),
        ],
        loesung:
            'Zum Beispiel PHP, Python und JavaScript; ebenfalls richtig sind Java, C# oder Ruby.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3. HTML und CSS zählen nicht, denn sie sind keine Programmiersprachen.',
        punkte: 3,
        difficulty: 1,
      ),
      tabelle(
        'f-a04d-handel-c',
        'wi-url',
        scenario:
            'Die neue Filialseite ist unter dieser Adresse erreichbar: https://www.gruenwerk.example/filialen/goettingen?tag=samstag#anfahrt',
        prompt:
            'Trage die Bestandteile der URL ein. Gib beim Port den Wert an, den der Browser verwendet.',
        zeilen: [
          ['Bestandteil', 'Wert'],
          [
            'Schema',
            wort(['https', 'https://']),
          ],
          [
            'Host',
            wort(['www.gruenwerk.example']),
          ],
          ['Port', zahl(443, rationale: 'Standardport von https.')],
          [
            'Pfad',
            wort(['/filialen/goettingen', 'filialen/goettingen']),
          ],
          [
            'Query',
            wort(['tag=samstag', '?tag=samstag']),
          ],
          [
            'Fragment',
            wort(['anfahrt', '#anfahrt']),
          ],
        ],
        explanation:
            'Je Zelle ein halber Punkt. Aufbau: Schema://Host:Port/Pfad?Query#Fragment. Fehlt der Port, nimmt der Browser den Standardport des Schemas, bei https ist das 443.',
        punkte: 3,
      ),
      freitext(
        'f-a04d-handel-d',
        'dm-normalisierung',
        scenario:
            'Die Filialen führen ihre Bestände bisher in einer Tabellenkalkulation. In jeder Artikelzeile stehen auch Name und Telefonnummer des Lieferanten.',
        table: [
          ['ArtikelNr', 'Artikel', 'Lieferant', 'Telefon'],
          ['A10', 'Spaten', 'Hortex', '0561 5550120'],
          ['A11', 'Harke', 'Hortex', '0561 5550120'],
          ['A12', 'Gießkanne', 'Hortex', '0561 5550120'],
        ],
        prompt: 'Erkläre anhand der Tabelle den Begriff Redundanz.',
        kriterien: [
          krit(
            'Dieselbe Information (Name und Telefonnummer des Lieferanten) ist mehrfach gespeichert.',
            punkte: 2,
            stichwoerter: ['mehrfach', 'doppelt', 'mehrmals', 'wiederholt'],
          ),
        ],
        loesung:
            'Redundanz bedeutet, dass dieselbe Information mehrfach gespeichert ist. Hier stehen Name und Telefonnummer des Lieferanten Hortex in jeder Artikelzeile.',
        explanation:
            '2 Punkte gibt es für die Erklärung mit Bezug zur Tabelle: Dieselbe Information ist mehrfach vorhanden.',
        punkte: 2,
        difficulty: 1,
      ),
      freitext(
        'f-a04d-handel-e',
        'dm-normalisierung',
        scenario:
            'In der Bestandstabelle der Filialen stehen Name und Telefonnummer des Lieferanten Hortex in jeder seiner drei Artikelzeilen.',
        prompt:
            'Beschreibe ein Problem, das durch diese redundante Speicherung entstehen kann.',
        kriterien: [
          krit(
            'Inkonsistenz: Wird die Telefonnummer nur in einer Zeile geändert, widersprechen sich die Daten (Änderungsanomalie).',
            punkte: 2,
            stichwoerter: [
              'Inkonsistenz',
              'inkonsistent',
              'widersprechen',
              'widersprüchlich',
              'Änderungsanomalie',
            ],
          ),
          krit(
            'Mehr Speicherbedarf und höherer Pflegeaufwand.',
            punkte: 2,
            stichwoerter: [
              'Speicherbedarf',
              'Speicherplatz',
              'Pflegeaufwand',
              'Aufwand',
            ],
          ),
          krit(
            'Löschanomalie: Werden alle Artikel des Lieferanten gelöscht, gehen auch seine Kontaktdaten verloren.',
            punkte: 2,
            stichwoerter: ['Löschanomalie', 'gehen verloren', 'verloren'],
          ),
        ],
        loesung:
            'Ändert sich die Telefonnummer des Lieferanten, muss sie in allen drei Zeilen angepasst werden. Wird eine Zeile vergessen, widersprechen sich die Daten (Inkonsistenz, Änderungsanomalie). Außerdem steigen Speicherbedarf und Pflegeaufwand.',
        explanation:
            '2 Punkte für ein beschriebenes Problem. Am häufigsten wird die Inkonsistenz durch unvollständige Änderungen genannt. Auch Speicher- und Pflegeaufwand oder die Löschanomalie zählen.',
        punkte: 2,
      ),
      lueckentext(
        'f-a04d-handel-f',
        'dm-kardinalitaet',
        scenario:
            'Im Webshop enthält eine Bestellung viele Artikel, und ein Artikel kommt in vielen Bestellungen vor. Zu jedem bestellten Artikel wird die Menge gespeichert. Vorhanden sind die Tabellen Bestellung (BestellNr, Datum) und Artikel (ArtikelNr, Bezeichnung, Preis).',
        prompt: 'Ergänze die Umsetzung im relationalen Modell.',
        text:
            'Die Beziehung zwischen Bestellung und Artikel hat die Kardinalität {0}. '
            'Sie wird durch eine {1} namens Bestellposition aufgelöst. '
            'Deren Primärschlüssel besteht aus {2}. '
            'Die Menge wird in der Tabelle {3} gespeichert.',
        luecken: [
          wahl('n:m', ['1:n', '1:1']),
          wahl('Zwischentabelle', [
            'Fremdschlüsselspalte',
            'Kopie der Tabelle Artikel',
          ]),
          wahl('BestellNr + ArtikelNr', ['BestellNr', 'ArtikelNr', 'Menge']),
          wahl('Bestellposition', ['Bestellung', 'Artikel']),
        ],
        explanation:
            'Je Lücke 1 Punkt. n:m-Beziehungen werden durch eine Zwischentabelle in zwei 1:n-Beziehungen aufgelöst. Die Zwischentabelle enthält die Primärschlüssel beider Seiten als Fremdschlüssel (zusammen ihr Primärschlüssel) und die Attribute der Beziehung, hier die Menge.',
        punkte: 4,
      ),
      lueckentext(
        'f-a04d-handel-g',
        'md-datenmengen',
        scenario:
            'Für 1.800 Artikel werden je 4 Fotos aufgenommen, zusammen 7.200 Fotos. Die Kamera liefert 6.000 × 4.000 Pixel mit 24 Bit Farbtiefe. Als JPEG gespeichert verringert sich die Größe eines Fotos um 90 %. Die Fotos werden aus Göttingen über einen Anschluss mit 40 Mbit/s im Upload in die Zentrale übertragen. Es gilt 1 MB = 1.000.000 Byte, 1 GB = 1.000 MB.',
        prompt:
            'Berechne Speicherbedarf und Übertragungsdauer. Runde die Dauer auf eine Nachkommastelle.',
        text:
            'Ein Foto unkomprimiert in MB: {0}\n'
            'Ein Foto als JPEG in MB: {1}\n'
            'Alle 7.200 Fotos als JPEG in GB: {2}\n'
            'Dauer des Uploads in Minuten: {3}',
        luecken: [
          zahl(72, rationale: '6.000 × 4.000 × 3 Byte.'),
          zahl(7.2, toleranz: 0.01, rationale: '72 × 0,1.'),
          zahl(51.84, toleranz: 0.01, rationale: '7,2 MB × 7.200.'),
          zahl(172.8, toleranz: 0.05, rationale: '414.720 Mbit / 40 / 60.'),
        ],
        explanation:
            '6.000 × 4.000 = 24.000.000 Pixel × 3 Byte = 72.000.000 Byte = 72 MB. „Um 90 %“: Es bleiben 10 % -> 7,2 MB. × 7.200 = 51.840 MB = 51,84 GB. Upload: 51.840 MB × 8 = 414.720 Mbit; / 40 Mbit/s = 10.368 s; / 60 = 172,8 min.',
        punkte: 4,
        difficulty: 3,
      ),
      markieren(
        'f-a04d-handel-h',
        'wi-aufruf',
        scenario:
            'Für die Pflege der Filialseiten soll ein Redaktionssystem eingesetzt werden. In der englischen Produktbeschreibung steht:',
        code:
            'A content management system\n'
            '(CMS) lets employees change\n'
            'the texts and pictures of a\n'
            'website without programming\n'
            'skills. The content is stored\n'
            'in a database. When a visitor\n'
            'opens a page, the server\n'
            'builds it from a template and\n'
            'the current content. Regular\n'
            'updates of the CMS are\n'
            'important, because old\n'
            'versions are a common target\n'
            'for attackers.',
        prompt: 'Markiere alle Aussagen, die sich dem Text entnehmen lassen.',
        zeilen: [
          ja(
            'Beschäftigte können Texte und Bilder ohne Programmierkenntnisse ändern.',
            '„without programming skills“.',
          ),
          ja(
            'Die Inhalte liegen in einer Datenbank.',
            '„The content is stored in a database“.',
          ),
          nein(
            'Jede Seite liegt als fertige Datei auf dem Server.',
            'Im Gegenteil: Der Server baut die Seite beim Aufruf zusammen.',
          ),
          ja(
            'Der Server erzeugt die Seite aus einer Vorlage und dem aktuellen Inhalt.',
            '„builds it from a template and the current content“.',
          ),
          nein(
            'Ein CMS muss nach der Einrichtung nicht mehr aktualisiert werden.',
            'Der Text nennt regelmäßige Updates ausdrücklich als wichtig.',
          ),
          ja(
            'Veraltete Versionen werden häufig angegriffen.',
            '„old versions are a common target for attackers“.',
          ),
        ],
        explanation:
            'Je richtig entnommener Aussage 1 Punkt. Der Text beschreibt eine dynamische Website: Inhalte in der Datenbank, Seitenaufbau beim Aufruf aus Vorlage (template) und Inhalt, Pflege ohne Programmierkenntnisse und regelmäßige Updates als Schutz vor Angriffen.',
        punkte: 4,
        tags: ['englisch'],
      ),
    ],
  ),

  // =============================================================== Agentur
  fall(
    'f-a04d-agentur',
    firma: 'agentur',
    bereich: 'a04',
    titel: 'KI-Assistent und Datenmodell für das Ticketsystem',
    situation:
        'Die Pixelhafen Medien GmbH führt ein Ticketsystem für Kundenanfragen ein. Ein KI-Assistent soll die 12 Beschäftigten im Support bei der Bearbeitung unterstützen. Du bereitest die Entscheidung über den KI-Einsatz vor und arbeitest am Datenmodell des Ticketsystems mit.',
    teile: [
      tabelle(
        'f-a04d-agentur-a',
        'ki-einsatz',
        scenario:
            'Eine Kundenanfrage durchläuft im Support fünf Schritte. Für den ersten Schritt ist als Muster eingetragen, wie KI unterstützen kann.',
        prompt:
            'Wähle für die Schritte 2 bis 5 jeweils die passende Möglichkeit der KI-Unterstützung.',
        zeilen: [
          ['Prozessschritt', 'KI-Unterstützung'],
          [
            '1. Anfrage geht per E-Mail ein',
            'Anliegen aus dem Text herauslesen und als Ticket anlegen',
          ],
          [
            '2. Ticket erhält Kategorie und Priorität',
            wahl('Kategorie und Priorität vorschlagen', [
              'Rechnung an den Kunden erstellen',
              'Ticket ohne Prüfung schließen',
            ]),
          ],
          [
            '3. Bearbeiter sucht eine Lösung',
            wahl('ähnliche gelöste Tickets anzeigen', [
              'Kategorie und Priorität vorschlagen',
              'Kundendaten löschen',
            ]),
          ],
          [
            '4. Bearbeiter antwortet dem Kunden',
            wahl('Antwortentwurf zur Prüfung erstellen', [
              'Antwort ungeprüft absenden',
              'ähnliche Tickets anzeigen',
            ]),
          ],
          [
            '5. Monatsbericht für die Teamleitung',
            wahl('häufige Probleme aus allen Tickets zusammenfassen', [
              'Antwortentwurf erstellen',
              'Priorität vorschlagen',
            ]),
          ],
        ],
        explanation:
            'Je Schritt 1 Punkt. KI eignet sich für Sprache und Muster: Inhalte erkennen, klassifizieren, ähnliche Fälle finden, Texte entwerfen und zusammenfassen. Was den Kunden erreicht, prüft vorher ein Mensch.',
        punkte: 4,
      ),
      freitext(
        'f-a04d-agentur-b',
        'ki-einsatz',
        scenario:
            'Zwei Beschäftigte im Support befürchten, der KI-Assistent mache ihre Arbeit überflüssig.',
        prompt:
            'Erläutere einen Vorteil, den der KI-Assistent für die Beschäftigten im Support hat.',
        kriterien: [
          krit(
            'Entlastung von Routinearbeit (Sortieren, Zusammenfassen), also mehr Zeit für anspruchsvolle Anfragen.',
            punkte: 2,
            stichwoerter: [
              'Routine',
              'Entlastung',
              'entlastet',
              'mehr Zeit',
              'anspruchsvolle',
            ],
          ),
          krit(
            'Schnellere Lösungen: Der Assistent findet ähnliche Fälle, die der Einzelne nicht kennt.',
            punkte: 2,
            stichwoerter: [
              'schneller',
              'ähnliche Fälle',
              'Wissen',
              'Lösungsvorschlag',
            ],
          ),
          krit(
            'Weniger Fehler und gleichmäßige Qualität der Antworten.',
            punkte: 2,
            stichwoerter: ['weniger Fehler', 'Qualität', 'einheitlich'],
          ),
        ],
        loesung:
            'Der Assistent nimmt den Beschäftigten Routinearbeit wie das Vorsortieren und Zusammenfassen ab. Dadurch bleibt mehr Zeit für anspruchsvolle Kundenanfragen; die Entscheidung trifft weiterhin der Mensch.',
        explanation:
            '2 Punkte für einen erläuterten Vorteil (Aussage plus Folge). Typisch sind die Entlastung von Routine, mehr Zeit für anspruchsvolle Aufgaben und weniger Fehler.',
        punkte: 2,
        difficulty: 1,
      ),
      rechnen(
        'f-a04d-agentur-c',
        'ki-einsatz',
        scenario:
            'Für den KI-Assistenten liegen die folgenden Angaben vor. Während der Schulung können die Beschäftigten keine Kundenaufträge bearbeiten; dieser entgangene Umsatz gehört zu den Kosten.',
        table: [
          ['Position', 'Angabe'],
          ['Nutzer im Support', '12'],
          ['Lizenz', '35 € je Nutzer und Monat'],
          ['Einrichtung', '1.500 € einmalig'],
          ['Schulung', '3 Stunden je Nutzer'],
          ['Entgangener Umsatz', '60 € je Stunde'],
        ],
        prompt: 'Errechne die Gesamtkosten des KI-Assistenten im ersten Jahr.',
        answer: 8700,
        unit: '€',
        explanation:
            'Lizenz: 12 × 35 € × 12 Monate = 5.040 €. Einrichtung: 1.500 €. Entgangener Umsatz: 12 × 3 h × 60 € = 2.160 €. Summe: 5.040 + 1.500 + 2.160 = 8.700 €.',
        punkte: 4,
      ),
      freitext(
        'f-a04d-agentur-d',
        'ki-grenzen',
        scenario:
            'Der KI-Assistent wird von einem externen Anbieter als Cloud-Dienst betrieben. Die Tickets enthalten Namen, E-Mail-Adressen und teils Zugangsdaten der Kunden.',
        prompt:
            'Beschreibe zwei Risiken, die beim Einsatz des KI-Assistenten zu beachten sind.',
        kriterien: [
          krit(
            'Datenschutz und Vertraulichkeit: Personenbezogene Daten und Zugangsdaten gelangen zum externen Anbieter.',
            punkte: 2,
            stichwoerter: [
              'Datenschutz',
              'personenbezogen',
              'DSGVO',
              'vertraulich',
              'Zugangsdaten',
            ],
          ),
          krit(
            'Falsche Vorschläge (Halluzinationen): Der Assistent formuliert überzeugend klingende, aber falsche Antworten.',
            punkte: 2,
            stichwoerter: [
              'Halluzination',
              'falsche Antwort',
              'falsche Vorschläge',
              'erfunden',
              'fehlerhaft',
            ],
          ),
          krit(
            'Blindes Vertrauen: Beschäftigte übernehmen Vorschläge ungeprüft.',
            punkte: 2,
            stichwoerter: [
              'ungeprüft',
              'blind',
              'verlassen sich',
              'ohne Prüfung',
            ],
          ),
          krit(
            'Abhängigkeit vom Anbieter: Ausfall des Dienstes, Preiserhöhungen.',
            punkte: 2,
            stichwoerter: [
              'Abhängigkeit',
              'Ausfall',
              'Anbieter',
              'Preiserhöhung',
            ],
          ),
        ],
        loesung:
            'Risiko 1: Die Tickets enthalten personenbezogene Daten und Zugangsdaten, die bei der Verarbeitung zum externen Anbieter gelangen. Ohne Vertrag und Schutzmaßnahmen ist das ein Datenschutzverstoß. Risiko 2: Der Assistent kann überzeugend klingende, aber falsche Lösungen vorschlagen; werden sie ungeprüft übernommen, erhalten Kunden falsche Auskünfte.',
        explanation:
            'Je beschriebenem Risiko 2 Punkte, verlangt sind zwei. Dagegen helfen ein Auftragsverarbeitungsvertrag, das Entfernen sensibler Daten vor der Verarbeitung und die Prüfung jeder Antwort vor dem Versand.',
        punkte: 4,
      ),
      lueckentext(
        'f-a04d-agentur-e',
        'dm-kardinalitaet',
        scenario:
            'Für das Ticketsystem gelten diese Regeln:\n'
            '- Jedes Ticket stammt von genau einem Kunden; ein Kunde kann viele Tickets eröffnen.\n'
            '- An einem Ticket können mehrere Mitarbeiter arbeiten; ein Mitarbeiter bearbeitet viele Tickets.',
        skizze: ErmDiagramm(
          [
            ErmEntitaet('Kunde'),
            ErmEntitaet('Ticket'),
            ErmEntitaet('Mitarbeiter'),
          ],
          beziehungen: [
            ErmBeziehung('Kunde', 'eröffnet', 'Ticket', '?', '?'),
            ErmBeziehung('Mitarbeiter', 'bearbeitet', 'Ticket', '?', '?'),
          ],
        ),
        prompt: 'Ergänze die Kardinalitäten im ER-Modell.',
        text:
            'Kunde - Ticket: {0}\n'
            'Mitarbeiter - Ticket: {1}\n'
            'Der Fremdschlüssel KundenNr steht in der Tabelle {2}.',
        luecken: [
          wahl('1:n', ['n:1', 'n:m', '1:1'], 'Ein Kunde, viele Tickets.'),
          wahl('n:m', ['1:n', 'n:1', '1:1'], 'Viele auf beiden Seiten.'),
          wahl('Ticket', [
            'Kunde',
            'Mitarbeiter',
          ], 'Der Fremdschlüssel kommt auf die n-Seite.'),
        ],
        explanation:
            'Kunde - Ticket ist 1:n; der Fremdschlüssel KundenNr steht auf der n-Seite, also in Ticket. Mitarbeiter - Ticket ist n:m und braucht eine Zwischentabelle.',
        punkte: 3,
      ),
      zuordnen(
        'f-a04d-agentur-f',
        'dm-erm',
        scenario:
            'Im Ticketsystem eröffnen Kunden Tickets, Mitarbeiter bearbeiten sie. Zu jeder Bearbeitung eines Tickets durch einen Mitarbeiter wird die aufgewendete Zeit erfasst.',
        prompt:
            'Ordne jedes Attribut dem Element des ER-Modells zu, an dem es eingetragen wird.',
        buckets: ['Kunde', 'Ticket', 'Mitarbeiter', 'Beziehung „bearbeitet“'],
        items: [
          zu('Betreff', 1, 'Eigenschaft des Tickets.'),
          zu('Kürzel', 2, 'Eigenschaft des Mitarbeiters.'),
          zu(
            'Aufgewendete Zeit',
            3,
            'Hängt von Mitarbeiter und Ticket gemeinsam ab.',
          ),
          zu('Firmenname', 0, 'Eigenschaft des Kunden.'),
          zu('Ticketnummer', 1, 'Schlüsselattribut des Tickets.'),
          zu('Kundennummer', 0, 'Schlüsselattribut des Kunden.'),
          zu('Eröffnungsdatum', 1, 'Jedes Ticket wird genau einmal eröffnet.'),
          zu('Abteilung', 2, 'Eigenschaft des Mitarbeiters.'),
        ],
        explanation:
            'Je richtig zugeordnetem Attribut ein halber Punkt. Die aufgewendete Zeit gehört an die Beziehung: Sie gilt für genau einen Mitarbeiter an genau einem Ticket. Das Eröffnungsdatum gibt es je Ticket nur einmal, es bleibt deshalb beim Ticket.',
        punkte: 4,
        difficulty: 3,
      ),
      freitext(
        'f-a04d-agentur-g',
        'ki-einsatz',
        scenario:
            'Der Anbieter beschreibt seinen Assistenten in der englischen Produktinformation so:',
        code:
            'The AI assistant reads every\n'
            'new support ticket and\n'
            'suggests a category and a\n'
            'priority. It does not replace\n'
            'the support team: an employee\n'
            'checks each suggestion and\n'
            'makes the final decision. The\n'
            'assistant learns from\n'
            'corrected tickets, so its\n'
            'suggestions improve over\n'
            'time. Customer names should\n'
            'be removed before data is\n'
            'used for training.',
        prompt:
            'Beschreibe auf Deutsch anhand des Textes, welche Aufgabe der KI-Assistent übernimmt und welche Aufgabe bei den Beschäftigten bleibt.',
        kriterien: [
          krit(
            'Assistent: liest jedes neue Ticket und schlägt Kategorie und Priorität vor.',
            punkte: 2,
            stichwoerter: [
              'schlägt vor',
              'Vorschlag',
              'Kategorie',
              'Priorität',
            ],
          ),
          krit(
            'Beschäftigte: prüfen jeden Vorschlag und treffen die endgültige Entscheidung.',
            punkte: 2,
            stichwoerter: [
              'prüfen',
              'prüft',
              'endgültige Entscheidung',
              'entscheiden',
              'entscheidet',
            ],
          ),
          krit(
            'Zusatz: Der Assistent lernt aus korrigierten Tickets; Kundennamen werden vor dem Training entfernt.',
            punkte: 1,
            stichwoerter: [
              'lernt',
              'korrigierten Tickets',
              'Kundennamen entfernen',
              'Training',
            ],
          ),
        ],
        loesung:
            'Der KI-Assistent liest jedes neue Ticket und schlägt eine Kategorie und eine Priorität vor. Er ersetzt das Team nicht: Ein Mitarbeiter prüft jeden Vorschlag und trifft die endgültige Entscheidung. Aus korrigierten Tickets lernt der Assistent dazu; Kundennamen sollen vor dem Training entfernt werden.',
        explanation:
            '2 Punkte für die Aufgabe des Assistenten (vorschlagen), 2 Punkte für die Aufgabe der Beschäftigten (prüfen und entscheiden). Antworte auf Deutsch, Stichworte mit Textbezug genügen.',
        punkte: 4,
        tags: ['englisch'],
      ),
    ],
  ),

  // ============================================================= Logistik (1)
  fall(
    'f-a04d-logistik',
    firma: 'logistik',
    bereich: 'a04',
    titel: 'Videoüberwachung der neuen Lagerhalle',
    situation:
        'Die neue Lagerhalle der Elbtal Logistik AG erhält 10 Kameras, die Rampen und Lagerzonen erfassen. Die Aufnahmen werden auf einem zentralen Server gespeichert. Du wertest das Datenblatt der Kameras aus, berechnest Datenrate und Speicherbedarf und modellierst, welche Kamera welche Lagerzone erfasst.',
    teile: [
      tabelle(
        'f-a04d-logistik-a',
        'md-datenmengen',
        scenario: 'Der Hersteller liefert zu den Kameras dieses Datenblatt.',
        code:
            'Outdoor Camera SkyGuard 8\n'
            'Technical data\n'
            'Resolution:    3840 x 2160\n'
            'Frame rate:    12 fps\n'
            'Colour depth:  24 bit\n'
            'Compression:   H.265, stream\n'
            '               is reduced to\n'
            '               1 % of the\n'
            '               raw data\n'
            'Night vision:  up to 30 m\n'
            'Storage:       no local\n'
            '               storage',
        prompt: 'Entnimm dem Datenblatt die folgenden Werte.',
        zeilen: [
          ['Merkmal', 'Wert'],
          ['Bilder pro Sekunde', zahl(12)],
          ['Farbtiefe in Bit', zahl(24)],
          ['Reichweite der Nachtsicht in Metern', zahl(30)],
        ],
        explanation:
            'Je Wert 1 Punkt. Frame rate = Bildrate (12 fps = 12 Bilder pro Sekunde), colour depth = Farbtiefe, night vision up to 30 m = Nachtsicht bis 30 Meter. „No local storage“ heißt: Die Kamera speichert nicht selbst, die Aufnahmen müssen auf den Server.',
        punkte: 3,
        difficulty: 1,
        tags: ['englisch'],
      ),
      lueckentext(
        'f-a04d-logistik-b',
        'md-uebertragung',
        scenario:
            'Laut Datenblatt liefert eine Kamera 3.840 × 2.160 Pixel mit 24 Bit Farbtiefe und 12 Bildern pro Sekunde. Der Codec verringert den Datenstrom auf 1 % der unkomprimierten Datenrate. Es gilt 1 Mbit = 1.000.000 Bit.',
        prompt: 'Berechne die Datenrate des Videostreams einer Kamera.',
        text:
            'Unkomprimiert in Mbit/s (eine Nachkommastelle): {0}\n'
            'Komprimiert in Mbit/s (auf volle Mbit/s aufrunden): {1}',
        luecken: [
          zahl(
            2388.8,
            toleranz: 0.05,
            rationale: '3.840 × 2.160 × 24 × 12 / 1.000.000.',
          ),
          zahl(24, rationale: '2.388,79 × 0,01 = 23,89 -> 24.'),
        ],
        explanation:
            '3.840 × 2.160 × 24 Bit × 12 Bilder/s = 2.388.787.200 Bit/s ≈ 2.388,8 Mbit/s (2 Punkte). „Auf 1 %“: × 0,01 = 23,89 -> 24 Mbit/s (2 Punkte). Mbit ist dezimal; „auf 1 %“ bedeutet Faktor 0,01.',
        punkte: 4,
        difficulty: 3,
      ),
      lueckentext(
        'f-a04d-logistik-c',
        'md-datenmengen',
        scenario:
            'Die Aufnahmen aller 10 Kameras sollen 96 Stunden lang gespeichert werden. Rechne mit der in der vorigen Teilaufgabe ermittelten Datenrate je Kamera; falls du dort kein Ergebnis hast, rechne mit 26 Mbit/s. Es gilt 1 TiB = 1.024⁴ Byte.',
        prompt: 'Berechne den Speicherbedarf. Runde auf volle TiB auf.',
        text:
            'Datenrate aller 10 Kameras in Mbit/s: {0}\n'
            'Speicherbedarf für 96 Stunden in TiB: {1}',
        luecken: [
          Blank(
            ['240', '260'],
            numeric: true,
            rationale: '10 × 24 Mbit/s (mit Ersatzwert: 10 × 26 = 260).',
          ),
          Blank(
            ['10', '11'],
            numeric: true,
            unit: 'TiB',
            rationale: '9,43 TiB -> 10 (mit Ersatzwert: 10,22 -> 11).',
          ),
        ],
        explanation:
            '10 × 24 = 240 Mbit/s (1 Punkt). 240.000.000 Bit/s × 3.600 s/h × 96 h =82.944.000.000.000 Bit; / 8 = 10.368.000.000.000 Byte; / 1.024⁴ ≈ 9,43 TiB -> aufgerundet 10 TiB (4 Punkte). Mit dem Ersatzwert 26 Mbit/s: 10,22 -> 11 TiB. Aufgerundet wird, weil der Speicher reichen muss.',
        punkte: 5,
        difficulty: 3,
      ),
      zuordnen(
        'f-a04d-logistik-d',
        'dm-erm',
        scenario:
            'In einer Datenbank soll festgehalten werden, welche Kamera welche Lagerzone erfasst. Eine Kamera erfasst mehrere Lagerzonen, eine Lagerzone wird von mehreren Kameras erfasst. Zu jeder Zuordnung werden die Blickrichtung und das Datum der Einrichtung gespeichert.',
        skizze: ErmDiagramm(
          [ErmEntitaet('Kamera'), ErmEntitaet('Lagerzone')],
          beziehungen: [
            ErmBeziehung('Kamera', 'erfasst', 'Lagerzone', '?', '?'),
          ],
        ),
        prompt:
            'Ergänze das ER-Diagramm: Ordne jedes Attribut dem richtigen Element zu.',
        buckets: ['Kamera', 'Lagerzone', 'Beziehung „erfasst“'],
        items: [
          zu('IP-Adresse', 0, 'Eigenschaft der Kamera.'),
          zu(
            'Blickrichtung',
            2,
            'Gilt für eine Kamera in Bezug auf eine bestimmte Zone.',
          ),
          zu('Zonennummer', 1, 'Schlüsselattribut der Lagerzone.'),
          zu('Modell', 0, 'Eigenschaft der Kamera.'),
          zu('Fläche in m²', 1, 'Eigenschaft der Lagerzone.'),
          zu(
            'Eingerichtet am',
            2,
            'Datum der einzelnen Zuordnung von Kamera und Zone.',
          ),
          zu('Kameranummer', 0, 'Schlüsselattribut der Kamera.'),
          zu('Bezeichnung der Zone', 1, 'Eigenschaft der Lagerzone.'),
        ],
        explanation:
            'Je richtig zugeordnetem Attribut ein halber Punkt. Blickrichtung und Einrichtungsdatum beschreiben die Kombination aus Kamera und Zone. Deshalb gehören sie an die Beziehung, nicht an eine der beiden Entitäten.',
        punkte: 4,
        difficulty: 3,
      ),
      lueckentext(
        'f-a04d-logistik-e',
        'dm-kardinalitaet',
        scenario:
            'Eine Kamera (KameraNr, Modell, IP-Adresse) erfasst mehrere Lagerzonen (ZonenNr, Bezeichnung, Fläche); eine Lagerzone wird von mehreren Kameras erfasst.',
        prompt:
            'Ergänze Kardinalität und Schlüssel für das ER-Diagramm und seine Umsetzung in Tabellen.',
        text:
            'Kardinalität der Beziehung „erfasst“: {0}\n'
            'Primärschlüssel von Kamera: {1}\n'
            'Primärschlüssel von Lagerzone: {2}\n'
            'Primärschlüssel der Zwischentabelle: {3}',
        luecken: [
          wahl('n:m', ['1:n', '1:1']),
          wahl('KameraNr', ['Modell', 'IP-Adresse', 'ZonenNr']),
          wahl('ZonenNr', ['Bezeichnung', 'Fläche', 'KameraNr']),
          wahl('KameraNr + ZonenNr', ['KameraNr', 'ZonenNr', 'Blickrichtung']),
        ],
        explanation:
            'Viele Kameras je Zone und viele Zonen je Kamera: n:m (1 Punkt). Die Nummern identifizieren Kamera und Zone eindeutig (je 1 Punkt). Die Zwischentabelle übernimmt beide Schlüssel als Fremdschlüssel; gemeinsam bilden sie ihren Primärschlüssel (1 Punkt).',
        punkte: 4,
      ),
      freitext(
        'f-a04d-logistik-f',
        'ki-einsatz',
        scenario:
            'Die Kameras an den Rampen erfassen ankommende LKW. Die Disposition möchte die Bilder nutzen, um den Lieferverkehr besser zu steuern.',
        prompt:
            'Erläutere eine Möglichkeit, wie die Videoerfassung mit Hilfe von KI den Lieferverkehr unterstützen kann.',
        kriterien: [
          krit(
            'Die KI erkennt ankommende LKW bzw. deren Kennzeichen automatisch in den Bildern.',
            punkte: 1,
            stichwoerter: [
              'erkennt',
              'Kennzeichen',
              'Kennzeichenerkennung',
              'Bilderkennung',
              'automatisch',
            ],
          ),
          krit(
            'Die Ankunft wird der passenden Lieferung bzw. Bestellung zugeordnet und mit Datum und Uhrzeit erfasst.',
            punkte: 1,
            stichwoerter: [
              'zuordnen',
              'zugeordnet',
              'Lieferung',
              'Bestellung',
              'Uhrzeit',
            ],
          ),
          krit(
            'Nutzen: Dem LKW wird automatisch eine freie Rampe zugewiesen, Wartezeiten sinken, Personal wird rechtzeitig informiert.',
            punkte: 1,
            stichwoerter: [
              'Rampe',
              'zuweisen',
              'Wartezeit',
              'informiert',
              'freie',
            ],
          ),
        ],
        loesung:
            'Eine KI-gestützte Bilderkennung liest das Kennzeichen eines ankommenden LKW, ordnet es der angekündigten Lieferung zu und erfasst Datum und Uhrzeit der Ankunft. Das System weist dem LKW automatisch eine freie Rampe zu und informiert das Lagerpersonal. So sinken die Wartezeiten.',
        explanation:
            '3 Punkte für eine nachvollziehbar erläuterte Möglichkeit: Was erkennt die KI, was geschieht mit der Information, welcher Nutzen entsteht. Andere sinnvolle Lösungen (z. B. freie Stellplätze zählen, Beladung dokumentieren) zählen ebenso.',
        punkte: 3,
      ),
      freitext(
        'f-a04d-logistik-g',
        'ki-grenzen',
        scenario:
            'Die KI zur Kennzeichenerkennung wurde nur mit Bildern bei Tageslicht trainiert. Die Halle wird aber im Dreischichtbetrieb rund um die Uhr angefahren.',
        prompt:
            'Beschreibe ein Risiko, das sich daraus für den Einsatz der KI ergibt.',
        kriterien: [
          krit(
            'Bei Dunkelheit, Regen oder verschmutzten Kennzeichen erkennt die KI falsch oder gar nicht, weil solche Bilder im Training fehlten.',
            punkte: 2,
            stichwoerter: [
              'Dunkelheit',
              'nachts',
              'falsch erkannt',
              'nicht erkannt',
              'Trainingsdaten',
              'Fehlerkennung',
            ],
          ),
          krit(
            'Folge: LKW werden falschen Lieferungen oder Rampen zugeordnet. Das Ergebnis muss von Menschen kontrolliert werden.',
            punkte: 2,
            stichwoerter: [
              'falsch zugeordnet',
              'falsche Rampe',
              'kontrolliert',
              'prüfen',
              'Verzögerung',
            ],
          ),
        ],
        loesung:
            'Weil Nachtaufnahmen im Training fehlten, erkennt die KI Kennzeichen bei Dunkelheit unzuverlässig. LKW werden dann falsch oder gar nicht zugeordnet; ohne Kontrolle durch Menschen entstehen Fehler und Verzögerungen an den Rampen.',
        explanation:
            '2 Punkte für ein beschriebenes Risiko: Einseitige Trainingsdaten führen zu Fehlern unter Bedingungen, die das Modell nicht kennt. Deshalb braucht das Training Daten aus allen Schichten, und die Ergebnisse müssen überwacht werden.',
        punkte: 2,
      ),
    ],
  ),

  // ============================================================= Logistik (2)
  fall(
    'f-a04d-logistik2',
    firma: 'logistik',
    bereich: 'a04',
    titel: 'Lieferscheine digital erfassen und archivieren',
    situation:
        'Im Wareneingang der Elbtal Logistik AG werden Lieferscheine bisher auf Papier abgelegt. Künftig werden sie gescannt, von einer KI ausgelesen und digital archiviert; die Daten fließen in eine Datenbank. Du berechnest den Speicherbedarf und arbeitest am Datenmodell mit.',
    teile: [
      freitext(
        'f-a04d-logistik2-a',
        'ki-einsatz',
        scenario:
            'Bisher gleichen Sachbearbeiter jeden Lieferschein von Hand mit der Bestellung ab. Eine KI soll die gescannten Lieferscheine auslesen und Abweichungen melden.',
        prompt:
            'Beschreibe zwei Argumente, die für die KI-gestützte Prüfung der Lieferscheine sprechen.',
        kriterien: [
          krit(
            'Zeitersparnis: Lieferscheine werden in Sekunden geprüft, der Wareneingang wird schneller gebucht.',
            punkte: 2,
            stichwoerter: ['Zeitersparnis', 'schneller', 'Zeit', 'Sekunden'],
          ),
          krit(
            'Weniger Fehler: Abweichungen bei Menge oder Artikel werden zuverlässig erkannt, auch bei Müdigkeit in der Nachtschicht.',
            punkte: 2,
            stichwoerter: [
              'weniger Fehler',
              'Abweichungen',
              'zuverlässig',
              'Fehlerquote',
            ],
          ),
          krit(
            'Lernendes System: Es erkennt Muster und unterschiedliche Formulare verschiedener Lieferanten.',
            punkte: 2,
            stichwoerter: ['Muster', 'lernt', 'lernendes System', 'Formulare'],
          ),
          krit(
            'Kosten und Skalierbarkeit: Mehr Lieferscheine lassen sich ohne zusätzliches Personal bewältigen.',
            punkte: 2,
            stichwoerter: [
              'Kosten',
              'skalierbar',
              'ohne zusätzliches Personal',
              'Personal',
            ],
          ),
        ],
        loesung:
            'Erstens spart die KI Zeit: Jeder Lieferschein ist in Sekunden geprüft, der Wareneingang kann schneller gebucht werden. Zweitens sinkt die Fehlerquote, weil Abweichungen bei Menge oder Artikel zuverlässig auffallen. Außerdem lernt das System die Formulare der Lieferanten und bewältigt mehr Belege ohne zusätzliches Personal.',
        explanation:
            'Je beschriebenem Argument 2 Punkte, verlangt sind zwei. Typisch sind Zeitersparnis, weniger Fehler, Kostenreduktion, Mustererkennung und Skalierbarkeit.',
        punkte: 4,
      ),
      lueckentext(
        'f-a04d-logistik2-b',
        'md-datenmengen',
        scenario:
            'Im Wareneingang fallen rund um die Uhr durchschnittlich 35 Lieferscheine pro Stunde an. Ein Scan ist 180 kB groß (1 kB = 1.000 Byte, 1 KiB = 1.024 Byte).',
        prompt: 'Ermittle den Speicherbedarf pro Tag. Runde auf ganze KiB.',
        text:
            'Lieferscheine pro Tag: {0}\n'
            'Speicherbedarf pro Tag in KiB: {1}',
        luecken: [
          zahl(840, rationale: '35 × 24.'),
          zahl(147656, toleranz: 1, rationale: '840 × 180 × 1.000 / 1.024.'),
        ],
        explanation:
            '35 × 24 = 840 Lieferscheine pro Tag (1 Punkt). 840 × 180 kB = 151.200 kB = 151.200.000 Byte; / 1.024 = 147.656,25 -> 147.656 KiB (2 Punkte). kB ist dezimal, KiB binär.',
        punkte: 3,
      ),
      lueckentext(
        'f-a04d-logistik2-c',
        'md-datenmengen',
        scenario:
            'Pro Tag fallen 147.656 KiB an. Das Archiv verringert den Speicherbedarf durch Kompression um 40 %. Ein Jahr hat 365 Tage.',
        prompt:
            'Ermittle den Jahresbedarf. Runde das Endergebnis auf zwei Nachkommastellen.',
        text:
            'Speicherbedarf pro Jahr in KiB: {0}\n'
            'Jahresbedarf in GiB mit Kompression: {1}',
        luecken: [
          zahl(53894440, rationale: '147.656 × 365.'),
          zahl(
            30.84,
            toleranz: 0.01,
            einheit: 'GiB',
            rationale: '53.894.440 / 1.024 / 1.024 × 0,6.',
          ),
        ],
        explanation:
            '147.656 × 365 = 53.894.440 KiB (1 Punkt). / 1.024 / 1.024 = 51,40 GiB; „um 40 % verringern“: Es bleiben 60 % -> × 0,6 ≈ 30,84 GiB (2 Punkte).',
        punkte: 3,
        difficulty: 3,
      ),
      rechnen(
        'f-a04d-logistik2-d',
        'md-datenmengen',
        scenario:
            'Für das Archiv werden 35 GiB bei einem Cloud-Anbieter gebucht. Speicher gibt es nur in Paketen zu je 10 GiB; ein Paket kostet 14 € pro Monat.',
        prompt: 'Ermittle die Speicherkosten für 12 Monate.',
        answer: 672,
        unit: '€',
        explanation:
            '35 / 10 = 3,5 -> 4 Pakete (aufrunden). 4 × 14 € = 56 € pro Monat. 56 € × 12 = 672 €.',
        punkte: 2,
        difficulty: 1,
      ),
      freitext(
        'f-a04d-logistik2-e',
        'dm-normalisierung',
        scenario:
            'Der Softwarelieferant begründet in seiner englischen Dokumentation, warum die alte Tabellenkalkulation abgelöst werden soll.',
        code:
            'Redundancy means that the same\n'
            'information is stored more\n'
            'than once. In the old\n'
            'spreadsheet the address of a\n'
            'supplier appears in every\n'
            'delivery row. If the address\n'
            'changes, every row must be\n'
            'updated; if one row is\n'
            'forgotten, the data becomes\n'
            'inconsistent. Storing each\n'
            'supplier only once in a\n'
            'separate table solves this\n'
            'problem.',
        prompt:
            'Erkläre auf Deutsch anhand des Textes den Begriff Redundanz und beschreibe das Problem, das dadurch entsteht. Gib außerdem die im Text genannte Lösung an.',
        kriterien: [
          krit(
            'Redundanz: Dieselbe Information ist mehrfach gespeichert (die Lieferantenadresse in jeder Lieferzeile).',
            punkte: 1,
            stichwoerter: [
              'mehrfach',
              'mehr als einmal',
              'doppelt',
              'mehrmals',
            ],
          ),
          krit(
            'Problem: Bei einer Adressänderung müssen alle Zeilen angepasst werden; wird eine vergessen, sind die Daten widersprüchlich.',
            punkte: 2,
            stichwoerter: [
              'alle Zeilen',
              'vergessen',
              'widersprüchlich',
              'inkonsistent',
              'Inkonsistenz',
            ],
          ),
          krit(
            'Lösung: Jeden Lieferanten nur einmal in einer eigenen Tabelle speichern.',
            punkte: 1,
            stichwoerter: [
              'eigene Tabelle',
              'separate Tabelle',
              'nur einmal',
              'eigenen Tabelle',
            ],
          ),
        ],
        loesung:
            'Redundanz heißt, dass dieselbe Information mehrfach gespeichert ist, hier die Lieferantenadresse in jeder Lieferzeile. Ändert sich die Adresse, müssen alle Zeilen angepasst werden; wird eine vergessen, werden die Daten widersprüchlich. Die Lösung ist, jeden Lieferanten nur einmal in einer eigenen Tabelle zu speichern.',
        explanation:
            '1 Punkt für den Begriff, 2 Punkte für das Problem (unvollständige Änderung führt zu Inkonsistenz), 1 Punkt für die Lösung. „Spreadsheet“ ist die Tabellenkalkulation, „supplier“ der Lieferant.',
        punkte: 4,
        tags: ['englisch'],
      ),
      tabelle(
        'f-a04d-logistik2-f',
        'dm-erm',
        scenario:
            'Ein Lieferschein enthält mehrere Artikel, ein Artikel kommt auf vielen Lieferscheinen vor. Im ER-Modell gibt es die Entitätstypen Lieferschein und Artikel sowie die Beziehung „enthält“.',
        prompt:
            'Gib für jedes Attribut an, wo es im ER-Modell eingetragen wird.',
        zeilen: [
          ['Attribut', 'gehört zu'],
          [
            'Lieferdatum',
            wahl('Lieferschein', ['Artikel', 'Beziehung „enthält“']),
          ],
          [
            'Artikelbezeichnung',
            wahl('Artikel', ['Lieferschein', 'Beziehung „enthält“']),
          ],
          [
            'Gelieferte Menge',
            wahl('Beziehung „enthält“', ['Lieferschein', 'Artikel']),
          ],
          [
            'Gewicht je Stück',
            wahl('Artikel', ['Lieferschein', 'Beziehung „enthält“']),
          ],
          [
            'Name des Fahrers',
            wahl('Lieferschein', ['Artikel', 'Beziehung „enthält“']),
          ],
          [
            'Chargennummer der gelieferten Ware',
            wahl('Beziehung „enthält“', ['Lieferschein', 'Artikel']),
          ],
        ],
        explanation:
            'Je Attribut ein halber Punkt. Menge und Chargennummer gelten für einen Artikel auf einem bestimmten Lieferschein und gehören deshalb an die Beziehung. Lieferdatum und Fahrer beschreiben den Lieferschein, Bezeichnung und Stückgewicht den Artikel.',
        punkte: 3,
        difficulty: 3,
      ),
      lueckentext(
        'f-a04d-logistik2-g',
        'dm-schluessel',
        scenario:
            'Das ER-Modell aus Lieferschein (LieferscheinNr, Lieferdatum) und Artikel (ArtikelNr, Bezeichnung) mit der Beziehung „enthält“ wird in Tabellen umgesetzt. Die Zwischentabelle heißt Lieferposition.',
        prompt: 'Ergänze Kardinalität und Schlüssel.',
        text:
            'Kardinalität Lieferschein - Artikel: {0}\n'
            'Primärschlüssel von Lieferschein: {1}\n'
            'Primärschlüssel von Lieferposition: {2}',
        luecken: [
          wahl('n:m', ['1:n', '1:1']),
          wahl('LieferscheinNr', ['Lieferdatum', 'ArtikelNr']),
          wahl('LieferscheinNr + ArtikelNr', [
            'LieferscheinNr',
            'ArtikelNr',
            'Menge',
          ]),
        ],
        explanation:
            'Viele Artikel je Lieferschein und viele Lieferscheine je Artikel: n:m. Die LieferscheinNr identifiziert den Lieferschein. In der Zwischentabelle Lieferposition bilden die beiden Fremdschlüssel LieferscheinNr und ArtikelNr gemeinsam den Primärschlüssel.',
        punkte: 3,
      ),
      freitext(
        'f-a04d-logistik2-h',
        'md-kompression',
        scenario:
            'Die gescannten Lieferscheine müssen als Nachweis mehrere Jahre aufbewahrt werden. Ein Kollege schlägt vor, sie zum Platzsparen stark verlustbehaftet zu komprimieren.',
        prompt:
            'Erläutere, warum für die Lieferscheine eine verlustfreie Kompression gewählt werden sollte.',
        kriterien: [
          krit(
            'Verlustfrei: Das Original lässt sich exakt wiederherstellen; verlustbehaftet gehen Details unwiederbringlich verloren.',
            punkte: 2,
            stichwoerter: [
              'exakt',
              'wiederherstellen',
              'Original',
              'unwiederbringlich',
              'gehen verloren',
            ],
          ),
          krit(
            'Bei Belegen müssen Schrift, Zahlen und Stempel lesbar und unverändert bleiben, denn Artefakte könnten Mengen oder Nummern unleserlich machen.',
            punkte: 2,
            stichwoerter: [
              'lesbar',
              'unverändert',
              'Schrift',
              'Nachweis',
              'Artefakte',
              'unleserlich',
            ],
          ),
        ],
        loesung:
            'Bei verlustfreier Kompression lässt sich das Original exakt wiederherstellen. Eine verlustbehaftete Kompression entfernt Details endgültig; kleine Schrift, Zahlen oder Stempel können dadurch unleserlich werden. Da die Lieferscheine als Nachweis dienen, müssen sie unverändert und lesbar bleiben.',
        explanation:
            'Für die volle Punktzahl gehören zwei Gedanken zusammen: Verlustfrei heißt exakt wiederherstellbar, und Belege müssen als Nachweis unverändert lesbar bleiben. Verlustbehaftet passt zu Fotos, Musik und Video.',
        punkte: 3,
      ),
    ],
  ),

  // =========================================================== Systemhaus (2)
  fall(
    'f-a04d-systemhaus2',
    firma: 'systemhaus',
    bereich: 'a04',
    titel: 'Mandantenportal der Kanzlei in Betrieb nehmen',
    situation:
        'Die Steuerkanzlei Albers & Partner erhält ein Mandantenportal, über das Mandanten Dokumente hochladen und abrufen. Die Kessler & Brandt IT-Systemhaus GmbH richtet das Portal unter https://portal.albers.example ein. Du begleitest den Test vor der Freigabe.',
    teile: [
      freitext(
        'f-a04d-systemhaus2-a',
        'wi-http',
        scenario:
            'Das Portal ist ausschließlich über HTTPS erreichbar. Ein Partner der Kanzlei fragt, was das den Mandanten bringt.',
        prompt:
            'Beschreibe zwei Vorteile von HTTPS gegenüber HTTP für das Mandantenportal.',
        kriterien: [
          krit(
            'Vertraulichkeit: Anmeldedaten und Dokumente werden verschlüsselt übertragen und können nicht mitgelesen werden.',
            punkte: 2,
            stichwoerter: [
              'verschlüsselt',
              'Verschlüsselung',
              'mitlesen',
              'Vertraulichkeit',
            ],
          ),
          krit(
            'Authentizität: Der Server weist sich per Zertifikat aus, Mandanten sind also sicher mit dem echten Portal verbunden.',
            punkte: 2,
            stichwoerter: ['Zertifikat', 'Authentizität', 'echte', 'Identität'],
          ),
          krit(
            'Integrität: Daten können unterwegs nicht unbemerkt verändert werden.',
            punkte: 2,
            stichwoerter: [
              'Integrität',
              'verändert',
              'manipuliert',
              'Manipulation',
            ],
          ),
        ],
        loesung:
            'HTTPS überträgt die Daten TLS-verschlüsselt: Anmeldedaten und Steuerunterlagen können unterwegs nicht mitgelesen werden. Außerdem weist sich der Server mit einem Zertifikat aus, sodass Mandanten sicher sind, mit dem echten Portal verbunden zu sein. Zusätzlich lassen sich die Daten nicht unbemerkt verändern.',
        explanation:
            'Je beschriebenem Vorteil 2 Punkte, verlangt sind zwei. Infrage kommen Vertraulichkeit, Authentizität des Servers und Integrität.',
        punkte: 4,
      ),
      reihenfolge(
        'f-a04d-systemhaus2-b',
        'wi-aufruf',
        scenario:
            'Im Test ruft eine Mandantin die Adresse https://portal.albers.example/dokumente zum ersten Mal auf.',
        prompt:
            'Bringe die Schritte bis zur angezeigten Seite in die richtige Reihenfolge.',
        items: [
          'DNS-Auflösung von portal.albers.example',
          'TCP-Verbindung zum Server auf Port 443',
          'TLS-Handshake mit Prüfung des Zertifikats',
          'HTTP-Request GET /dokumente',
          'Server erzeugt die Seite und sendet die HTTP-Response',
          'Browser rendert die Seite',
        ],
        explanation:
            'Erst wird der Name in eine IP-Adresse übersetzt (DNS), dann die Verbindung aufgebaut (TCP) und gesichert (TLS). Danach folgen Anfrage und Antwort (HTTP), zuletzt stellt der Browser die Seite dar.',
        punkte: 3,
      ),
      tabelle(
        'f-a04d-systemhaus2-c',
        'wi-http',
        scenario:
            'Im Testprotokoll des Portals sind drei Situationen beschrieben, in denen der Server mit einem Fehlercode antwortet.',
        prompt: 'Wähle den HTTP-Statuscode, der zur Situation passt.',
        zeilen: [
          ['Situation', 'Statuscode'],
          [
            'Angemeldete Mandantin ruft ein Dokument eines anderen Mandanten auf',
            wahl('403', ['200', '404', '500']),
          ],
          [
            'Link auf ein Dokument, das inzwischen gelöscht wurde',
            wahl('404', ['301', '403', '503']),
          ],
          [
            'Das Portalprogramm stürzt beim Hochladen einer Datei ab',
            wahl('500', ['200', '401', '404']),
          ],
        ],
        explanation:
            'Je Zeile 1 Punkt. 403 Forbidden: angemeldet, aber ohne Berechtigung. 404 Not Found: Die Ressource gibt es nicht. 500 Internal Server Error: Fehler im Programm auf dem Server. Merke dir: 4xx steht für Fehler in der Anfrage, 5xx für Fehler beim Server.',
        punkte: 3,
      ),
      markieren(
        'f-a04d-systemhaus2-d',
        'wi-html',
        scenario:
            'Die Anmeldeseite des Portals wird fehlerhaft angezeigt. Du prüfst den HTML-Quelltext des Formulars.',
        prompt: 'Markiere alle Zeilen, die einen Syntaxfehler enthalten.',
        zeilen: [
          nein('<form action="/login" method="post">', 'Korrektes Start-Tag.'),
          ja(
            '<label for="user">Benutzername</lable>',
            'End-Tag falsch geschrieben: </label>.',
          ),
          nein(
            '<input id="user" name="user" type="text">',
            'Korrekt: input hat kein End-Tag.',
          ),
          nein('<label for="pw">Passwort</label>', 'Korrekt.'),
          ja(
            '<input id="pw" name="pw" type="password>',
            'Das schließende Anführungszeichen nach password fehlt.',
          ),
          ja(
            '<button type="submit">Anmelden</buton>',
            'End-Tag falsch geschrieben: </button>.',
          ),
          nein('</form>', 'Korrekt geschlossen.'),
        ],
        mono: true,
        explanation:
            'Je gefundenem Fehler 1 Punkt: zwei falsch geschriebene End-Tags (</lable>, </buton>) und ein Attributwert ohne schließendes Anführungszeichen. Start- und End-Tag müssen denselben Namen tragen, Attributwerte stehen vollständig in Anführungszeichen.',
        punkte: 3,
      ),
      freitext(
        'f-a04d-systemhaus2-e',
        'wi-barrierefrei',
        scenario:
            'Unter den Mandanten sind auch ältere und sehbehinderte Menschen. Das Portal soll deshalb barrierefrei bedienbar sein.',
        prompt:
            'Beschreibe zwei Maßnahmen, mit denen das Portal barrierefrei gestaltet wird.',
        kriterien: [
          krit(
            'Alle Funktionen per Tastatur bedienbar, mit sichtbarem Fokus.',
            punkte: 2,
            stichwoerter: ['Tastatur', 'Fokus', 'ohne Maus'],
          ),
          krit(
            'Ausreichender Kontrast und vergrößerbare Schrift.',
            punkte: 2,
            stichwoerter: [
              'Kontrast',
              'Schriftgröße',
              'vergrößern',
              'vergrößerbar',
            ],
          ),
          krit(
            'Formularfelder mit sichtbaren, verknüpften Beschriftungen (label) und verständlichen Fehlermeldungen.',
            punkte: 2,
            stichwoerter: [
              'label',
              'Beschriftung',
              'Fehlermeldung',
              'beschriftet',
            ],
          ),
          krit(
            'Alternativtexte für Bilder und Symbole, damit Screenreader sie vorlesen können.',
            punkte: 2,
            stichwoerter: [
              'Alternativtext',
              'Alt-Text',
              'Screenreader',
              'vorlesen',
            ],
          ),
        ],
        loesung:
            'Erstens müssen alle Funktionen (Anmelden, Hochladen, Abrufen) auch ohne Maus per Tastatur erreichbar sein, mit sichtbarem Fokus. Zweitens brauchen Texte ausreichend Kontrast und müssen sich vergrößern lassen. Außerdem erhalten Formularfelder verknüpfte Beschriftungen und Symbole Alternativtexte für Screenreader.',
        explanation:
            'Je beschriebener Maßnahme 2 Punkte, verlangt sind zwei. Maßstab sind die WCAG-Prinzipien wahrnehmbar, bedienbar, verständlich, robust.',
        punkte: 4,
      ),
      lueckentext(
        'f-a04d-systemhaus2-f',
        'md-uebertragung',
        scenario:
            'Ein Mandant lädt zum Jahresabschluss ein Paket mit 850 MB (1 MB = 1.000.000 Byte) hoch. Sein Anschluss bietet 100 Mbit/s im Download und 20 Mbit/s im Upload. Durch Protokoll-Overhead steigt die zu übertragende Datenmenge um 5 %.',
        prompt:
            'Berechne die Dauer des Uploads. Runde das Endergebnis auf zwei Nachkommastellen.',
        text:
            'Datenmenge in Mbit: {0}\n'
            'Datenmenge mit Overhead in Mbit: {1}\n'
            'Dauer in Sekunden: {2}\n'
            'Dauer in Minuten: {3}',
        luecken: [
          zahl(6800, rationale: '850 × 8.'),
          zahl(7140, rationale: '6.800 × 1,05.'),
          zahl(357, rationale: '7.140 / 20. Es zählt die Upload-Rate.'),
          zahl(5.95, toleranz: 0.01, rationale: '357 / 60.'),
        ],
        explanation:
            'Je Schritt 1 Punkt. 850 MB × 8 = 6.800 Mbit. Mit 5 % Overhead: × 1,05 = 7.140 Mbit. Beim Hochladen zählt die Upload-Rate: 7.140 / 20 = 357 s = 5,95 min.',
        punkte: 4,
      ),
      freitext(
        'f-a04d-systemhaus2-g',
        'wi-aufruf',
        scenario:
            'Im Test lädt das Portal langsam. Der Hersteller der Portalsoftware gibt in seiner englischen Dokumentation Hinweise.',
        code:
            'A slow portal frustrates users.\n'
            'Three simple measures make\n'
            'pages load faster. First,\n'
            'compress images and documents\n'
            'before they are sent. Second,\n'
            'allow the browser to cache\n'
            'files that rarely change,\n'
            'such as the logo. Third,\n'
            'reduce the number of requests\n'
            'by combining small script\n'
            'files into one.',
        prompt:
            'Nenne auf Deutsch die drei Maßnahmen, die der Text empfiehlt. Gib außerdem an, welches Beispiel der Text für selten geänderte Dateien nennt.',
        kriterien: [
          krit(
            'Bilder und Dokumente vor dem Senden komprimieren',
            stichwoerter: ['komprimieren', 'Kompression', 'verkleinern'],
          ),
          krit(
            'Selten geänderte Dateien im Browser zwischenspeichern (Cache)',
            stichwoerter: [
              'Cache',
              'zwischenspeichern',
              'cachen',
              'Zwischenspeicher',
            ],
          ),
          krit(
            'Anzahl der Anfragen verringern, indem kleine Skriptdateien zusammengefasst werden',
            stichwoerter: [
              'Anfragen',
              'Requests',
              'zusammenfassen',
              'zusammenführen',
              'weniger',
            ],
          ),
          krit(
            'Beispiel für selten geänderte Dateien: das Logo',
            stichwoerter: ['Logo'],
          ),
        ],
        loesung:
            'Erstens Bilder und Dokumente vor dem Senden komprimieren. Zweitens dem Browser erlauben, selten geänderte Dateien zwischenzuspeichern (Cache). Als Beispiel nennt der Text das Logo. Drittens die Zahl der Anfragen verringern, indem kleine Skriptdateien zu einer zusammengefasst werden.',
        explanation:
            'Je Nennung 1 Punkt: komprimieren, im Browser zwischenspeichern, Anfragen verringern, dazu das Beispiel Logo. Stichworte auf Deutsch genügen.',
        punkte: 4,
        tags: ['englisch'],
      ),
    ],
  ),
];
