import '../builders.dart';

/// Fallaufgaben (je 25 Punkte) zu Bereich 01, Teil 2 für die Prüfungssimulation.
///
/// Schwerpunkt Beschaffung und Wirtschaftlichkeit, im Aufbau angelehnt an
/// echte AP1-Aufgaben: Entscheidungsmatrix, Bezugskalkulation, Monatskosten,
/// Kauf oder Leasing, Nutzwertanalyse, Make or Buy, Amortisation.
final List<ExamCase> casesA01Planung = [
  // ------------------------------------------------------------ Systemhaus
  fall(
    'f-a01w-systemhaus',
    firma: 'systemhaus',
    bereich: 'a01',
    titel: 'Dokumentenscanner für die Kanzlei auswählen',
    situation:
        'Die Steuerkanzlei Albers & Partner stellt mit dem Umzug auf die digitale Akte um. Für den Posteingang soll ein Dokumentenscanner beschafft werden, der monatlich rund 6.000 Seiten verarbeitet. Kessler & Brandt hat drei Geräte in die engere Wahl genommen. Du bereitest die Entscheidung vor und begleitest die Beschaffung.',
    teile: [
      tabelle(
        'f-a01w-systemhaus-a',
        'w-nutzwert',
        table: [
          ['Merkmal', 'ScanPro 40', 'DocuJet S', 'Aktiv 3000'],
          ['Scantempo (Seiten/min)', '45', '60', '35'],
          ['Einzug (Blatt)', '50', '100', '80'],
          ['Auflösung (dpi)', '600', '600', '1.200'],
          ['Schnittstellen', 'USB', 'USB, LAN', 'USB, LAN, WLAN'],
          ['Wartung je Monat', '12 €', '20 €', '8 €'],
          ['Preis (netto)', '1.080 €', '1.512 €', '864 €'],
        ],
        prompt:
            'Die Kanzlei entscheidet nach Scantempo, Einzug, Wartungskosten und Preis. Je Kriterium erhält das beste Gerät 3 Punkte, das schlechteste 1 Punkt. Vervollständige die Entscheidungsmatrix und bilde die Summen. (6 P.)',
        punkte: 6,
        zeilen: [
          ['Kriterium', 'ScanPro 40', 'DocuJet S', 'Aktiv 3000'],
          ['Scantempo', '2', '3', '1'],
          ['Einzug', zahl(1), zahl(3), zahl(2)],
          ['Wartung je Monat', zahl(2), zahl(1), zahl(3)],
          ['Preis', zahl(2), zahl(1), zahl(3)],
          ['Summe', zahl(7), zahl(8), zahl(9)],
        ],
        explanation:
            'Beim Einzug sind 100 Blatt am besten (3 Punkte), es folgen 80 Blatt (2) und 50 Blatt (1). Bei Wartung und Preis ist der kleinste Wert der beste: Aktiv 3000 erhält je 3 Punkte, DocuJet S je 1 Punkt.\n'
            'Summen: ScanPro 40: 2 + 1 + 2 + 2 = 7, DocuJet S: 3 + 3 + 1 + 1 = 8, Aktiv 3000: 1 + 2 + 3 + 3 = 9.\n'
            'Auflösung und Schnittstellen stehen in der Datentabelle, gehören aber nicht zu den vier Kriterien.',
      ),
      lueckentext(
        'f-a01w-systemhaus-b',
        'w-nutzwert',
        prompt:
            'Nenne das Gerät, das nach der Entscheidungsmatrix auszuwählen ist. (2 P.)',
        punkte: 2,
        text:
            'Auszuwählen ist das Gerät {0}, weil es mit {1} Punkten die höchste Summe erreicht.',
        luecken: [
          wahl('Aktiv 3000', ['ScanPro 40', 'DocuJet S']),
          zahl(9, rationale: '1 + 2 + 3 + 3 = 9.'),
        ],
        explanation:
            'Bei der Vorgabe „3 Punkte für den besten Wert“ gewinnt die höchste Summe: Aktiv 3000 mit 9 Punkten vor DocuJet S (8) und ScanPro 40 (7).',
      ),
      rechnen(
        'f-a01w-systemhaus-c',
        'w-kalkulation',
        scenario:
            'Die Kanzlei kauft den Aktiv 3000 für 864 € und nutzt ihn 48 Monate. Für Verschleißteile (Einzugsrollen, Reinigung) fallen 0,004 € je gescannter Seite an, dazu kommt die Wartung laut Datentabelle.',
        prompt:
            'Berechne die monatlichen Kosten des Scanners bei 6.000 Seiten im Monat. (3 P.)',
        punkte: 3,
        answer: 50,
        unit: '€',
        explanation:
            'Anschaffung: 864 € / 48 Monate = 18 €\n'
            'Verschleiß: 6.000 Seiten × 0,004 € = 24 €\n'
            'Wartung: 8 €\n'
            'Monatskosten: 18 € + 24 € + 8 € = 50 €\n'
            'Die Angaben stehen an drei Stellen: Situation (Seitenzahl), Datentabelle (Wartung, Preis) und Teilaufgabe.',
      ),
      freitext(
        'f-a01w-systemhaus-d',
        'sm-zugriff',
        scenario:
            'Der Scanner wird ins Kanzleinetz eingebunden und verschickt Scans per E-Mail. Das Handbuch enthält Hinweise zur sicheren Einrichtung.',
        code:
            'SECURE SETUP\n'
            'Before first use, change the default\n'
            'administrator password. Enable encrypted\n'
            'transmission (TLS) for scan-to-e-mail.\n'
            'Restrict scan-to-folder destinations to\n'
            'approved network shares. Install firmware\n'
            'updates as soon as they are released.\n'
            'Activate automatic deletion of scanned\n'
            'images from the internal memory after\n'
            'each job.',
        prompt:
            'Nenne vier Sicherheitsmaßnahmen, die der Hersteller empfiehlt. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Das Standard-Administratorpasswort vor der ersten Nutzung ändern',
            stichwoerter: ['Passwort', 'Kennwort', 'Standardpasswort'],
          ),
          krit(
            'Verschlüsselte Übertragung (TLS) für Scan-to-E-Mail aktivieren',
            stichwoerter: ['verschlüsselt', 'Verschlüsselung', 'TLS'],
          ),
          krit(
            'Scan-Ziele auf freigegebene Netzlaufwerke beschränken',
            stichwoerter: [
              'Netzlaufwerk',
              'Freigaben',
              'Ordner',
              'Ziele beschränken',
              'einschränken',
            ],
          ),
          krit(
            'Firmware-Updates sofort nach Erscheinen installieren',
            stichwoerter: ['Firmware', 'Update', 'Aktualisierung'],
          ),
          krit(
            'Scans nach jedem Auftrag automatisch aus dem internen Speicher löschen',
            stichwoerter: ['löschen', 'Löschung', 'interner Speicher'],
          ),
        ],
        loesung:
            'Standardpasswort des Administrators ändern, verschlüsselte Übertragung (TLS) für Scan-to-E-Mail einschalten, Scan-Ziele auf freigegebene Netzlaufwerke beschränken, Firmware-Updates zeitnah einspielen. Außerdem sollten Scans nach jedem Auftrag automatisch aus dem Gerätespeicher gelöscht werden.',
        explanation:
            'Im Text stehen fünf Maßnahmen, verlangt sind vier. Jede Nennung bringt 1 Punkt. Du antwortest auf Deutsch, Stichworte genügen.',
      ),
      freitext(
        'f-a01w-systemhaus-e',
        'w-nutzwert',
        prompt:
            'Erläutere einen Nachteil einer Entscheidungsmatrix, die ohne Gewichtung arbeitet. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Alle Kriterien zählen gleich viel, obwohl sie für die Kanzlei unterschiedlich wichtig sein können.',
            punkte: 2,
            stichwoerter: [
              'gleich wichtig',
              'gleich viel',
              'gleich gewichtet',
              'Gewichtung fehlt',
              'unterschiedlich wichtig',
            ],
          ),
          krit(
            'Die Größe der Unterschiede geht verloren: Ein knapper und ein deutlicher Vorsprung geben dieselben Punkte.',
            punkte: 2,
            stichwoerter: [
              'Abstand',
              'Abstände',
              'knapp',
              'wie groß',
              'Unterschied',
            ],
          ),
          krit(
            'Dadurch kann die Entscheidung am tatsächlichen Bedarf vorbeigehen.',
            stichwoerter: [
              'Bedarf',
              'falsche Entscheidung',
              'anderes Ergebnis',
              'verfälscht',
            ],
          ),
        ],
        loesung:
            'Ohne Gewichtung zählt jedes Kriterium gleich viel. Ist der Kanzlei zum Beispiel das Scantempo viel wichtiger als der Preis, bildet die Matrix das nicht ab. Die Entscheidung kann deshalb am tatsächlichen Bedarf vorbeigehen.',
        explanation:
            'Der Nachteil bringt 2 Punkte, die Folge 1 Punkt. Im Beispiel gewinnt das langsamste Gerät, weil Preis und Wartung genauso viel zählen wie das Scantempo.',
      ),
      lueckentext(
        'f-a01w-systemhaus-f',
        'w-kalkulation',
        scenario:
            'Die Rechnung für den Aktiv 3000 lautet über 864,00 € netto zuzüglich 19 % Umsatzsteuer. Zahlungsbedingung: 2 % Skonto bei Zahlung innerhalb von 10 Tagen.',
        prompt:
            'Berechne den Überweisungsbetrag bei Zahlung mit Skonto (kaufmännisch auf zwei Nachkommastellen). (3 P.)',
        punkte: 3,
        text:
            'Rechnungsbetrag brutto: {0} €\n'
            'Skontobetrag: {1} €\n'
            'Überweisungsbetrag: {2} €',
        luecken: [
          zahl(1028.16, toleranz: 0.01, rationale: '864 € × 1,19.'),
          zahl(20.56, toleranz: 0.01, rationale: '2 % von 1.028,16 €.'),
          zahl(1007.6, toleranz: 0.01, rationale: '1.028,16 € - 20,56 €.'),
        ],
        explanation:
            'Umsatzsteuer: 864 € × 0,19 = 164,16 €, brutto 1.028,16 €\n'
            'Skonto: 1.028,16 € × 0,02 = 20,5632 €, gerundet 20,56 € (Basis ist der Bruttobetrag)\n'
            'Überweisung: 1.028,16 € - 20,56 € = 1.007,60 €',
      ),
      freitext(
        'f-a01w-systemhaus-g',
        'r-strategien',
        prompt:
            'Beschreibe zwei Risiken bei Beschaffung oder Einführung des Scanners und je eine passende Gegenmaßnahme. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Lieferverzug zum Umzugstermin: verbindlichen Liefertermin vereinbaren oder ein Leihgerät einplanen',
            punkte: 2,
            stichwoerter: [
              'Lieferverzug',
              'Lieferung',
              'verspätet',
              'Liefertermin',
              'Leihgerät',
            ],
          ),
          krit(
            'Ausfall des einzigen Scanners: Wartungsvertrag mit Austauschgerät abschließen',
            punkte: 2,
            stichwoerter: [
              'Ausfall',
              'defekt',
              'Wartungsvertrag',
              'Ersatzgerät',
              'Austausch',
            ],
          ),
          krit(
            'Bedienfehler oder fehlende Akzeptanz: Beschäftigte einweisen und schulen',
            punkte: 2,
            stichwoerter: [
              'Schulung',
              'Einweisung',
              'Akzeptanz',
              'Bedienfehler',
            ],
          ),
          krit(
            'Scanner arbeitet nicht mit der Kanzleisoftware zusammen: vor dem Kauf mit einem Testgerät prüfen',
            punkte: 2,
            stichwoerter: [
              'kompatibel',
              'Testgerät',
              'Teststellung',
              'Schnittstelle',
              'Kanzleisoftware',
            ],
          ),
          krit(
            'Vertrauliche Scans bleiben im Gerätespeicher: automatische Löschung aktivieren',
            punkte: 2,
            stichwoerter: ['vertraulich', 'Datenschutz', 'Gerätespeicher'],
          ),
        ],
        loesung:
            'Risiko 1: Der Scanner wird nicht rechtzeitig zum Umzug geliefert. Maßnahme: verbindlichen Liefertermin vereinbaren und ein Leihgerät einplanen. Risiko 2: Der einzige Scanner fällt aus und der Posteingang staut sich. Maßnahme: Wartungsvertrag mit Austauschgerät abschließen.',
        explanation:
            'Jedes Risiko mit Maßnahme bringt 2 Punkte, höchstens 4. Andere sinnvolle Risiken sind möglich. Entscheidend ist, dass die Maßnahme zum Risiko passt.',
      ),
    ],
  ),

  // ---------------------------------------------------------------- Handel
  fall(
    'f-a01w-handel',
    firma: 'handel',
    bereich: 'a01',
    titel: 'Notebooks für mobiles Arbeiten beschaffen',
    situation:
        'Die Grünwerk Gartenbedarf GmbH stattet 20 Beschäftigte aus Einkauf und Kundenservice mit Notebooks für mobiles Arbeiten aus. Der IT-Abteilung liegen zwei Kaufangebote und ein Leasingangebot vor. Du sollst die Angebote rechnerisch vergleichen und die Entscheidung vorbereiten.',
    teile: [
      tabelle(
        'f-a01w-handel-a',
        'w-kalkulation',
        table: [
          ['', 'Bürowelt24', 'TechnoPart'],
          ['Listenpreis je Notebook', '980,00 €', '940,00 €'],
          ['Menge', '20 Stück', '20 Stück'],
          ['Rabatt', '12 %', '8 %'],
          ['Skonto', '2 %', '3 %'],
          ['Lieferung', 'frei Haus', 'ab Werk, Fracht 140,00 €'],
        ],
        prompt:
            'Ermittle die Bezugspreise beider Lieferanten für die gesamte Bestellung. Skonto wird genutzt. (8 P.)',
        punkte: 8,
        zeilen: [
          ['Position', 'Bürowelt24 (€)', 'TechnoPart (€)'],
          ['Listenpreis gesamt', '19.600,00', '18.800,00'],
          ['- Rabatt', zahl(2352, toleranz: 0.01), zahl(1504, toleranz: 0.01)],
          [
            '= Zieleinkaufspreis',
            zahl(17248, toleranz: 0.01),
            zahl(17296, toleranz: 0.01),
          ],
          [
            '- Skonto',
            zahl(344.96, toleranz: 0.01),
            zahl(518.88, toleranz: 0.01),
          ],
          [
            '= Bareinkaufspreis',
            zahl(16903.04, toleranz: 0.01),
            zahl(16777.12, toleranz: 0.01),
          ],
          ['+ Bezugskosten', '0,00', '140,00'],
          [
            '= Bezugspreis',
            zahl(16903.04, toleranz: 0.01),
            zahl(16917.12, toleranz: 0.01),
          ],
        ],
        explanation:
            'Bürowelt24: 19.600 € - 12 % (2.352 €) = 17.248 €; - 2 % Skonto (344,96 €) = 16.903,04 €; frei Haus, also Bezugspreis 16.903,04 €\n'
            'TechnoPart: 18.800 € - 8 % (1.504 €) = 17.296 €; - 3 % Skonto (518,88 €) = 16.777,12 €; + 140 € Fracht = 16.917,12 €\n'
            'Skonto wird vom Zieleinkaufspreis gerechnet. Trotz des niedrigeren Listenpreises ist TechnoPart am Ende 14,08 € teurer.',
      ),
      freitext(
        'f-a01w-handel-b',
        'w-nutzwert',
        prompt:
            'Nenne drei Gründe, aus denen sich ein Unternehmen für einen teureren Lieferanten entscheiden kann. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Kürzere Lieferzeit oder höhere Termintreue',
            stichwoerter: [
              'Lieferzeit',
              'Termintreue',
              'pünktlich',
              'schneller',
            ],
          ),
          krit(
            'Besserer Service und Support',
            stichwoerter: ['Service', 'Support', 'Vor-Ort', 'Ansprechpartner'],
          ),
          krit(
            'Längere Garantie oder Kulanz bei Reklamationen',
            stichwoerter: [
              'Garantie',
              'Kulanz',
              'Reklamation',
              'Gewährleistung',
            ],
          ),
          krit(
            'Zuverlässigkeit und gute Erfahrungen mit dem Lieferanten',
            stichwoerter: [
              'Zuverlässigkeit',
              'zuverlässig',
              'Erfahrung',
              'Stammlieferant',
            ],
          ),
          krit(
            'Höhere Qualität der Ware',
            stichwoerter: ['Qualität', 'hochwertig', 'Verarbeitung'],
          ),
          krit(
            'Günstigere Zahlungsbedingungen oder Nachhaltigkeit',
            stichwoerter: [
              'Zahlungsziel',
              'Zahlungsbedingungen',
              'Nachhaltigkeit',
              'Umwelt',
            ],
          ),
        ],
        loesung:
            'Zum Beispiel: kürzere Lieferzeit, besserer Service bei Störungen und längere Garantie. Auch Zuverlässigkeit, Qualität der Geräte oder günstigere Zahlungsbedingungen können den Ausschlag geben.',
        explanation:
            'Jede Nennung bringt 1 Punkt, höchstens 3. Der Bezugspreis ist nur der quantitative Teil des Angebotsvergleichs. Qualitative Kriterien können ihn überstimmen.',
      ),
      freitext(
        'f-a01w-handel-c',
        'vt-arten',
        scenario:
            'Alternativ bietet die Hausbank Leasing an: 20 Notebooks für 27,50 € je Gerät und Monat, Laufzeit 36 Monate, mit Kaufoption am Vertragsende.',
        prompt:
            'Beschreibe das Grundprinzip des Leasings und erkläre, wer während der Laufzeit Eigentümer und wer Besitzer der Notebooks ist. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Leasing: Die Geräte werden gegen regelmäßige Raten für eine vertraglich festgelegte Zeit zur Nutzung überlassen.',
            punkte: 2,
            stichwoerter: [
              'Nutzung',
              'Nutzungsrecht',
              'überlassen',
              'Raten',
              'auf Zeit',
              'Laufzeit',
            ],
          ),
          krit(
            'Eigentümer bleibt der Leasinggeber (die Bank).',
            stichwoerter: ['Leasinggeber', 'Eigentümer bleibt', 'Bank'],
          ),
          krit(
            'Besitzer ist der Leasingnehmer (Grünwerk), der die Geräte tatsächlich nutzt.',
            stichwoerter: ['Leasingnehmer', 'Besitzer', 'Grünwerk'],
          ),
        ],
        loesung:
            'Beim Leasing überlässt der Leasinggeber die Notebooks für eine fest vereinbarte Laufzeit gegen monatliche Raten zur Nutzung. Eigentümer bleibt der Leasinggeber (die Bank), Besitzer ist der Leasingnehmer Grünwerk, der die Geräte tatsächlich in Händen hat.',
        explanation:
            'Das Grundprinzip bringt 2 Punkte, Eigentümer und Besitzer je 1 Punkt. Eigentum ist die rechtliche Herrschaft über die Sache, Besitz die tatsächliche.',
      ),
      rechnen(
        'f-a01w-handel-d',
        'w-makeorbuy',
        scenario:
            'Leasing: 20 Notebooks zu je 27,50 € im Monat, Laufzeit 36 Monate. Kauf: Bezugspreis des günstigeren Lieferanten (Ersatzwert, falls Teilaufgabe a nicht gelöst wurde: 16.900,00 €).',
        prompt:
            'Ermittle, um wie viel Euro das Leasing über die Laufzeit teurer ist als der Kauf. (3 P.)',
        punkte: 3,
        answer: 2896.96,
        tolerance: 3.05,
        unit: '€',
        explanation:
            'Leasing: 20 × 27,50 € × 36 Monate = 19.800,00 €\n'
            'Kauf: 16.903,04 € (Bürowelt24)\n'
            'Mehrkosten des Leasings: 19.800,00 € - 16.903,04 € = 2.896,96 €\n'
            'Mit dem Ersatzwert 16.900,00 € ergeben sich 2.900,00 €. Auch dieses Ergebnis wird gewertet.',
      ),
      freitext(
        'f-a01w-handel-e',
        'vt-arten',
        prompt:
            'Nenne drei Vorteile, die das Leasing für Grünwerk trotz der höheren Gesamtkosten hat. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Die Liquidität bleibt erhalten, weil keine hohe Anfangsinvestition anfällt',
            stichwoerter: [
              'Liquidität',
              'Anfangsinvestition',
              'kein Kapital',
              'Eigenkapital',
              'flüssige Mittel',
            ],
          ),
          krit(
            'Gleichbleibende, planbare monatliche Raten',
            stichwoerter: [
              'planbar',
              'kalkulierbar',
              'gleichbleibend',
              'feste Raten',
            ],
          ),
          krit(
            'Nach der Laufzeit können aktuelle Geräte geleast werden',
            stichwoerter: [
              'aktuelle Geräte',
              'neue Geräte',
              'Technikwechsel',
              'modern',
              'austauschen',
            ],
          ),
          krit(
            'Der Kreditspielraum bei der Bank wird geschont',
            stichwoerter: ['Kreditspielraum', 'Kreditlinie', 'Kredit'],
          ),
          krit(
            'Die Raten sind als Betriebsausgaben absetzbar',
            stichwoerter: ['Betriebsausgabe', 'steuerlich', 'absetzbar'],
          ),
        ],
        loesung:
            'Die Liquidität bleibt erhalten, weil keine hohe Anfangsinvestition anfällt. Die monatlichen Raten sind gleichbleibend und gut planbar. Nach 36 Monaten können aktuelle Geräte geleast werden.',
        explanation:
            'Jede Nennung bringt 1 Punkt, höchstens 3. Dem stehen die höheren Gesamtkosten und die feste Bindung über die Laufzeit gegenüber.',
      ),
      lueckentext(
        'f-a01w-handel-f',
        'w-kalkulation',
        scenario:
            'Grünwerk entscheidet sich für den Kauf bei Bürowelt24 (Bezugspreis 16.903,04 €) und nutzt die Notebooks 36 Monate. Je Notebook fallen 6 € im Monat für die Sicherheitssoftware an. Der Wartungsvertrag für alle Geräte kostet 1.080 € im Jahr.',
        prompt:
            'Berechne die laufenden Kosten je Monat für alle 20 Notebooks (auf zwei Nachkommastellen). (4 P.)',
        punkte: 4,
        text:
            'Anschaffung je Monat: {0} €\n'
            'Software je Monat: {1} €\n'
            'Wartung je Monat: {2} €\n'
            'Summe je Monat: {3} €',
        luecken: [
          zahl(469.53, toleranz: 0.01, rationale: '16.903,04 € / 36.'),
          zahl(120, toleranz: 0.01, rationale: '20 × 6 €.'),
          zahl(90, toleranz: 0.01, rationale: '1.080 € / 12.'),
          zahl(679.53, toleranz: 0.01, rationale: '469,53 + 120 + 90.'),
        ],
        explanation:
            'Anschaffung: 16.903,04 € / 36 Monate = 469,53 € (gerundet)\n'
            'Software: 20 × 6 € = 120 €\n'
            'Wartung: 1.080 € / 12 = 90 €\n'
            'Summe: 469,53 € + 120 € + 90 € = 679,53 € je Monat',
      ),
    ],
  ),

  // --------------------------------------------------------------- Agentur
  fall(
    'f-a01w-agentur',
    firma: 'agentur',
    bereich: 'a01',
    titel: 'Ticketsystem auswählen: Nutzwert, Kosten, Make or Buy',
    situation:
        'Die Pixelhafen Medien GmbH will Kundenanfragen künftig über ein Ticketsystem bearbeiten. 12 Mitarbeitende aus Projektleitung und Support sollen damit arbeiten. Drei Produkte stehen zur Wahl, außerdem schlägt ein Entwickler vor, das System selbst zu programmieren. Du bereitest die Entscheidung für die Geschäftsführung vor.',
    teile: [
      tabelle(
        'f-a01w-agentur-a',
        'w-nutzwert',
        table: [
          ['Punkte (1 bis 5)', 'HelpWave', 'TicketBase', 'DeskOne'],
          ['Bedienung', '5', '3', '4'],
          ['Funktionsumfang', '3', '5', '3'],
          ['Support', '3', '4', '2'],
          ['Preis', '4', '3', '5'],
          ['Betriebsart', 'SaaS', 'on-premise', 'SaaS'],
        ],
        prompt:
            'Vervollständige die Nutzwertanalyse (gewichteter Wert = Gewicht × Punkte). (6 P.)',
        punkte: 6,
        zeilen: [
          ['Kriterium', 'Gewicht', 'HelpWave', 'TicketBase', 'DeskOne'],
          ['Bedienung', '30', '150', zahl(90), '120'],
          ['Funktionsumfang', '25', zahl(75), '125', '75'],
          ['Support', '20', '60', zahl(80), '40'],
          ['Preis', zahl(25), '100', '75', zahl(125)],
          ['Summe', '100', zahl(385), zahl(370), zahl(360)],
        ],
        explanation:
            'Fehlendes Gewicht: 100 - 30 - 25 - 20 = 25.\n'
            'TicketBase Bedienung 30 × 3 = 90, Support 20 × 4 = 80; HelpWave Funktionsumfang 25 × 3 = 75; DeskOne Preis 25 × 5 = 125.\n'
            'Summen: HelpWave 150 + 75 + 60 + 100 = 385, TicketBase 90 + 125 + 80 + 75 = 370, DeskOne 120 + 75 + 40 + 125 = 360.',
      ),
      freitext(
        'f-a01w-agentur-b',
        'w-nutzwert',
        scenario:
            'Ein Großkunde verlangt vertraglich, dass seine Daten nur auf Servern der Agentur gespeichert werden (on-premise).',
        prompt:
            'Nenne den Anbieter, der unter dieser Bedingung auszuwählen ist, und begründe deine Wahl. (2 P.)',
        punkte: 2,
        kriterien: [
          krit(
            'Auszuwählen ist TicketBase.',
            stichwoerter: ['TicketBase', 'Ticket Base', 'Ticketbase'],
          ),
          krit(
            'HelpWave und DeskOne scheiden als SaaS-Lösungen aus, denn die Bedingung ist ein K.-o.-Kriterium.',
            stichwoerter: [
              'SaaS',
              'scheiden aus',
              'ausgeschlossen',
              'K.-o.',
              'Muss-Kriterium',
              'on-premise',
            ],
          ),
        ],
        loesung:
            'TicketBase. HelpWave hat zwar den höchsten Nutzwert, ist aber wie DeskOne eine SaaS-Lösung und verfehlt damit die Muss-Bedingung „on-premise“. Beide scheiden vor dem Punktevergleich aus.',
        explanation:
            '1 Punkt für die Wahl, 1 Punkt für den Ausschlussgrund. Ein K.-o.-Kriterium schlägt den Nutzwert: Wer es verfehlt, scheidet aus, egal wie viele Punkte er hat.',
      ),
      rechnen(
        'f-a01w-agentur-c',
        'w-kalkulation',
        scenario:
            'TicketBase kostet 15 € je Nutzer und Monat. Für die Einführung ist eine ganztägige Schulung (8 Stunden) aller 12 Nutzer nötig, der Trainer berechnet pauschal 1.500 €. Während der Schulung können die Mitarbeitenden keine Kundenstunden abrechnen; ihr Stundensatz beträgt 85 €.',
        prompt:
            'Errechne die Kosten für TicketBase im ersten Jahr einschließlich des entgangenen Umsatzes. (4 P.)',
        punkte: 4,
        answer: 11820,
        unit: '€',
        explanation:
            'Lizenzen: 12 Nutzer × 15 € × 12 Monate = 2.160 €\n'
            'Schulung: 1.500 €\n'
            'Entgangener Umsatz: 12 Personen × 8 h × 85 € = 8.160 €\n'
            'Summe: 2.160 € + 1.500 € + 8.160 € = 11.820 €\n'
            'Der entgangene Umsatz ist der größte Posten: Wer ihn weglässt, unterschätzt die Kosten deutlich.',
      ),
      freitext(
        'f-a01w-agentur-d',
        'w-makeorbuy',
        scenario:
            'Der Hersteller von TicketBase beschreibt den Leistungsumfang auf Englisch.',
        code:
            'TicketBase Business - what you get\n'
            'Included in the licence fee:\n'
            '- unlimited tickets and customer contacts\n'
            '- software updates during the contract term\n'
            '- e-mail support on working days,\n'
            '  response within 8 hours\n'
            '- one remote onboarding session (2 hours)\n'
            '- mobile app for agents\n'
            'Not included: on-site installation,\n'
            'data migration, individual training',
        prompt:
            'Nenne vier Leistungen, die in der Lizenzgebühr enthalten sind. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Unbegrenzte Zahl von Tickets und Kundenkontakten',
            stichwoerter: ['unbegrenzt', 'unbeschränkt', 'beliebig viele'],
          ),
          krit(
            'Software-Updates während der Vertragslaufzeit',
            stichwoerter: ['Update', 'Updates', 'Aktualisierung'],
          ),
          krit(
            'E-Mail-Support an Werktagen mit Antwort innerhalb von 8 Stunden',
            stichwoerter: ['Support', 'E-Mail', 'Werktagen', '8 Stunden'],
          ),
          krit(
            'Eine Einführung per Fernsitzung (2 Stunden)',
            stichwoerter: [
              'Einführung',
              'Onboarding',
              'Fernsitzung',
              'remote',
              'Einweisung',
            ],
          ),
          krit(
            'Mobile App für die Bearbeiter',
            stichwoerter: ['App', 'mobil', 'Smartphone'],
          ),
        ],
        loesung:
            'Enthalten sind unbegrenzt viele Tickets und Kundenkontakte, Software-Updates während der Vertragslaufzeit, E-Mail-Support an Werktagen (Antwort innerhalb von 8 Stunden) und eine zweistündige Einführung per Fernsitzung. Dazu kommt eine mobile App.',
        explanation:
            'Jede Nennung bringt 1 Punkt, höchstens 4. Nicht enthalten sind Installation vor Ort, Datenübernahme und individuelle Schulung. Diese Kosten kommen im Vergleich noch hinzu.',
      ),
      lueckentext(
        'f-a01w-agentur-e',
        'w-makeorbuy',
        scenario:
            'Für die Eigenentwicklung schätzt der Entwickler 400 Stunden. Die Wartung würde 40 Stunden im Jahr kosten. Gerechnet wird mit 75 € je Stunde und einer Nutzungsdauer von 5 Jahren. Die gekaufte Lösung kostet 15 € je Nutzer und Monat.',
        prompt:
            'Berechne, ab wie vielen Nutzern die Eigenentwicklung genauso teuer ist wie der Kauf. (5 P.)',
        punkte: 5,
        text:
            'Entwicklungskosten: {0} €\n'
            'Wartungskosten in 5 Jahren: {1} €\n'
            'Gesamtkosten der Eigenentwicklung: {2} €\n'
            'Kosten der Eigenentwicklung je Jahr: {3} €\n'
            'Gleichstand bei {4} Nutzern',
        luecken: [
          zahl(30000, rationale: '400 h × 75 €.'),
          zahl(15000, rationale: '40 h × 75 € × 5 Jahre.'),
          zahl(45000, rationale: '30.000 € + 15.000 €.'),
          zahl(9000, rationale: '45.000 € / 5 Jahre.'),
          zahl(50, rationale: '9.000 € / 180 € je Nutzer und Jahr.'),
        ],
        explanation:
            'Entwicklung: 400 h × 75 € = 30.000 €\n'
            'Wartung: 40 h × 75 € × 5 = 15.000 €\n'
            'Summe: 45.000 € über 5 Jahre, also 9.000 € je Jahr\n'
            'Kauf je Nutzer und Jahr: 15 € × 12 = 180 €\n'
            'Gleichstand: 9.000 € / 180 € = 50 Nutzer. Erst darüber lohnt sich die Eigenentwicklung.',
      ),
      freitext(
        'f-a01w-agentur-f',
        'w-makeorbuy',
        prompt:
            'Pixelhafen hat 12 Nutzer. Begründe mit zwei Argumenten, ob die Agentur das Ticketsystem selbst entwickeln oder kaufen sollte. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Kaufen: 12 Nutzer liegen weit unter dem Gleichstand von 50 Nutzern. Der Kauf ist deutlich günstiger.',
            punkte: 2,
            stichwoerter: [
              'Gleichstand',
              '50 Nutzer',
              'günstiger',
              'wirtschaftlicher',
              'weit unter',
            ],
          ),
          krit(
            'Die Entwickler werden für bezahlte Kundenprojekte gebraucht. Eigenentwicklung bedeutet entgangenen Umsatz.',
            punkte: 2,
            stichwoerter: [
              'Kundenprojekte',
              'Kerngeschäft',
              'entgangener Umsatz',
              'Kapazität',
              'abrechenbar',
            ],
          ),
          krit(
            'Die gekaufte Lösung ist sofort verfügbar und erprobt, Updates und Wartung liefert der Hersteller.',
            punkte: 2,
            stichwoerter: [
              'sofort verfügbar',
              'erprobt',
              'ausgereift',
              'Hersteller',
              'schneller',
            ],
          ),
        ],
        loesung:
            'Die Agentur sollte kaufen. Mit 12 Nutzern liegt sie weit unter dem Gleichstand von 50 Nutzern: Der Kauf kostet 12 × 180 € = 2.160 € im Jahr, die Eigenentwicklung 9.000 €. Außerdem würden 400 Entwicklerstunden für bezahlte Kundenprojekte fehlen.',
        explanation:
            'Jedes Argument bringt 2 Punkte, höchstens 4. Eine begründete Entscheidung für die Eigenentwicklung (etwa wegen sehr spezieller Abläufe) wäre ebenfalls zu werten. Die Rechnung spricht hier aber klar für den Kauf.',
      ),
    ],
  ),

  // -------------------------------------------------------------- Logistik
  fall(
    'f-a01w-logistik',
    firma: 'logistik',
    bereich: 'a01',
    titel: 'Handscanner für die neue Lagerhalle beschaffen',
    situation:
        'Für die neue Lagerhalle benötigt die Elbtal Logistik AG 40 robuste Handscanner. Sie ersetzen dort die bisherigen Papierlisten bei der Einlagerung. Die Halle geht in drei Wochen in Betrieb, gearbeitet wird in drei Schichten zu je 8 Stunden. Der IT-Abteilung liegen drei Angebote vor, eines davon auf Englisch.',
    teile: [
      lueckentext(
        'f-a01w-logistik-a',
        'w-kalkulation',
        code:
            'OFFER - ScanTrack Europe B.V.\n'
            'Model:      ST-700 rugged handheld\n'
            'Quantity:   40 units\n'
            'Unit price: EUR 620.00 net\n'
            'Discount:   8 % on orders of\n'
            '            25 units or more\n'
            'Freight:    EUR 180.00\n'
            'Payment:    3 % cash discount within\n'
            '            14 days, 30 days net\n'
            'Delivery:   4 weeks\n'
            'Battery:    10 h per charge',
        prompt:
            'Ermittle den Bezugspreis des Angebots von ScanTrack. Skonto wird genutzt. (5 P.)',
        punkte: 5,
        text:
            'Listenpreis gesamt: {0} €\n'
            'Rabatt: {1} €\n'
            'Zieleinkaufspreis: {2} €\n'
            'Skonto: {3} €\n'
            'Bezugspreis: {4} €',
        luecken: [
          zahl(24800, toleranz: 0.01, rationale: '40 × 620 €.'),
          zahl(1984, toleranz: 0.01, rationale: '8 % von 24.800 €.'),
          zahl(22816, toleranz: 0.01, rationale: '24.800 € - 1.984 €.'),
          zahl(684.48, toleranz: 0.01, rationale: '3 % von 22.816 €.'),
          zahl(
            22311.52,
            toleranz: 0.01,
            rationale: '22.816 € - 684,48 € + 180 € Fracht.',
          ),
        ],
        explanation:
            'Listenpreis: 40 × 620 € = 24.800 €\n'
            'Rabatt (discount) 8 %: 1.984 €, Zieleinkaufspreis 22.816 €\n'
            'Skonto (cash discount) 3 % von 22.816 €: 684,48 €, Bareinkaufspreis 22.131,52 €\n'
            'Fracht (freight): + 180 € = 22.311,52 €',
      ),
      tabelle(
        'f-a01w-logistik-b',
        'w-nutzwert',
        table: [
          ['', 'ScanTrack', 'LagerTec', 'HandyScan'],
          ['Bezugspreis', '22.311,52 €', '24.900,00 €', '23.400,00 €'],
          ['Lieferzeit', '4 Wochen', '1 Woche', '2 Wochen'],
          ['Akkulaufzeit', '10 h', '12 h', '8 h'],
          ['Austausch bei Defekt', '5 Werktage', '1 Werktag', '2 Werktage'],
        ],
        prompt:
            'Bewerte die Angebote: Je Kriterium erhält das beste Angebot 3 Punkte, das schlechteste 1 Punkt. Trage die gewichteten Punkte (Punkte × Gewicht) und die Summen ein. (6 P.)',
        punkte: 6,
        zeilen: [
          ['Kriterium (Gewicht)', 'ScanTrack', 'LagerTec', 'HandyScan'],
          ['Preis (10)', '30', '10', '20'],
          ['Lieferzeit (6)', zahl(6), zahl(18), zahl(12)],
          ['Akkulaufzeit (8)', zahl(16), zahl(24), zahl(8)],
          ['Austausch (6)', zahl(6), zahl(18), zahl(12)],
          ['Summe', zahl(58), zahl(70), zahl(52)],
        ],
        explanation:
            'Lieferzeit: LagerTec 3 × 6 = 18, HandyScan 2 × 6 = 12, ScanTrack 1 × 6 = 6\n'
            'Akkulaufzeit: LagerTec 3 × 8 = 24, ScanTrack 2 × 8 = 16, HandyScan 1 × 8 = 8\n'
            'Austausch: LagerTec 18, HandyScan 12, ScanTrack 6\n'
            'Summen: ScanTrack 30 + 6 + 16 + 6 = 58, LagerTec 10 + 18 + 24 + 18 = 70, HandyScan 20 + 12 + 8 + 12 = 52',
      ),
      freitext(
        'f-a01w-logistik-c',
        'w-nutzwert',
        prompt:
            'Nenne den Lieferanten, der den Auftrag erhalten soll, und begründe die Entscheidung. (2 P.)',
        punkte: 2,
        kriterien: [
          krit(
            'Den Auftrag erhält LagerTec.',
            stichwoerter: ['LagerTec', 'Lager Tec', 'Lagertech'],
          ),
          krit(
            'LagerTec hat trotz des höchsten Preises mit 70 Punkten die höchste gewichtete Summe. Außerdem liefern nur LagerTec und HandyScan vor dem Hallenstart.',
            stichwoerter: [
              '70',
              'höchste Summe',
              'meisten Punkte',
              'Lieferzeit',
              'rechtzeitig',
            ],
          ),
        ],
        loesung:
            'LagerTec. Das Angebot erreicht mit 70 Punkten die höchste gewichtete Summe, obwohl es das teuerste ist. Außerdem liefert LagerTec in einer Woche und damit rechtzeitig vor dem Start der Halle.',
        explanation:
            '1 Punkt für die Wahl, 1 Punkt für die Begründung. Wer nur auf den Preis schaut, würde ScanTrack wählen. Dessen Lieferzeit von 4 Wochen käme aber zu spät.',
      ),
      rechnen(
        'f-a01w-logistik-d',
        'w-kalkulation',
        scenario:
            'Elbtal kauft die 40 Scanner bei LagerTec für 24.900,00 € und nutzt sie 48 Monate. Der Wartungsvertrag kostet 1.500 € im Jahr. Für Ersatzakkus werden 45 € im Monat eingeplant.',
        prompt:
            'Berechne die monatlichen Kosten der Scanner (auf zwei Nachkommastellen). (4 P.)',
        punkte: 4,
        answer: 688.75,
        tolerance: 0.01,
        unit: '€',
        explanation:
            'Anschaffung: 24.900 € / 48 Monate = 518,75 €\n'
            'Wartung: 1.500 € / 12 = 125,00 €\n'
            'Ersatzakkus: 45,00 €\n'
            'Monatskosten: 518,75 € + 125,00 € + 45,00 € = 688,75 €',
      ),
      rechnen(
        'f-a01w-logistik-e',
        'w-breakeven',
        scenario:
            'Gegenüber den Papierlisten sparen die Scanner Arbeitszeit im Wert von 1.900 € im Monat. Dem stehen die laufenden Kosten für Wartung und Ersatzakkus von zusammen 170 € im Monat gegenüber. Die Anschaffung kostet 24.900 €.',
        prompt:
            'Berechne, nach wie vielen vollen Monaten sich die Anschaffung amortisiert hat. (4 P.)',
        punkte: 4,
        answer: 15,
        unit: 'Monate',
        explanation:
            'Rückfluss je Monat: 1.900 € - 170 € = 1.730 €\n'
            'Amortisation: 24.900 € / 1.730 € = 14,39 Monate\n'
            'Nach 14 Monaten sind erst 24.220 € zurückgeflossen. Erst nach 15 vollen Monaten ist die Anschaffung gedeckt. Es wird aufgerundet.',
      ),
      freitext(
        'f-a01w-logistik-f',
        'r-strategien',
        prompt:
            'Beschreibe zwei Risiken bei der Einführung der Handscanner und je eine geeignete Gegenmaßnahme. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Lieferverzug zum Hallenstart: festen Liefertermin mit Vertragsstrafe vereinbaren oder übergangsweise mit Papierlisten arbeiten',
            punkte: 2,
            stichwoerter: [
              'Lieferverzug',
              'Lieferung',
              'verspätet',
              'Vertragsstrafe',
              'Liefertermin',
            ],
          ),
          krit(
            'Geräte fallen im Schichtbetrieb aus: Ersatzgeräte vorhalten und Wartungsvertrag mit schnellem Austausch abschließen',
            punkte: 2,
            stichwoerter: [
              'Ausfall',
              'defekt',
              'Ersatzgeräte',
              'Austausch',
              'Wartungsvertrag',
            ],
          ),
          krit(
            'Akkus halten keine Schicht durch: Wechselakkus und Ladestationen bereitstellen',
            punkte: 2,
            stichwoerter: ['Akku', 'Wechselakku', 'Ladestation', 'Laufzeit'],
          ),
          krit(
            'Lücken im WLAN der Halle: Funkausleuchtung vor dem Start messen und Access Points ergänzen',
            punkte: 2,
            stichwoerter: [
              'WLAN',
              'Funkabdeckung',
              'Ausleuchtung',
              'Access Point',
              'Empfang',
            ],
          ),
          krit(
            'Beschäftigte kommen mit den Geräten nicht zurecht: Schulung in allen Schichten',
            punkte: 2,
            stichwoerter: [
              'Schulung',
              'Einweisung',
              'Akzeptanz',
              'Bedienfehler',
            ],
          ),
        ],
        loesung:
            'Risiko 1: Scanner fallen im Schichtbetrieb aus und die Einlagerung stockt. Maßnahme: Ersatzgeräte vorhalten und einen Wartungsvertrag mit Austausch am nächsten Werktag abschließen. Risiko 2: Das WLAN der neuen Halle hat Funklücken. Maßnahme: Ausleuchtung vor dem Start messen und Access Points ergänzen.',
        explanation:
            'Jedes Risiko mit passender Maßnahme bringt 2 Punkte, höchstens 4. Andere sinnvolle Risiken sind möglich.',
      ),
    ],
  ),
];
