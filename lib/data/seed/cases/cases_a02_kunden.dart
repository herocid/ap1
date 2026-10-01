import '../builders.dart';

/// Fallaufgaben (je 25 Punkte) zu Bereich 02 für die Prüfungssimulation.
///
/// Aufbau, Operatoren und Punktverteilung folgen echten AP1-Aufgaben
/// (Bezugskalkulation mit Leasingvergleich, Eingangsrechnung mit Skonto und
/// GiroCode, Servicequalität mit englischem Text, gewichteter
/// Angebotsvergleich) - mit eigenen Betrieben, Zahlen und Formulierungen.

const _belegHandel =
    'Kassentechnik Weser GmbH, Hameln\n'
    'Rechnung Nr. 2026-0815 vom 14.04.2026\n'
    'Ihre Bestellung vom 07.04.2026\n'
    'Lieferung am 13.04.2026\n\n'
    '4 Bondrucker      x 185,00 €   740,00 €\n'
    '4 Kassenschublade x  92,50 €   370,00 €\n'
    '   Netto zu 19 %             1.110,00 €\n'
    '   + 19 % USt                  210,90 €\n'
    '2 Fachbuch Kasse  x  30,00 €    60,00 €\n'
    '   Netto zu 7 %                 60,00 €\n'
    '   + 7 % USt                     4,20 €\n'
    'Rechnungsbetrag               1.385,10 €\n\n'
    'Zahlbar bis 14.05.2026 ohne Abzug,\n'
    'bis 24.04.2026 abzüglich 2 % Skonto.\n'
    '[GiroCode]';

const _textAgentur =
    'How to handle support tickets well\n\n'
    'Fast answers matter: customers who wait\n'
    'for days often move to a competitor.\n'
    'But answering too quickly without\n'
    'checking the problem leads to wrong\n'
    'solutions and extra work.\n\n'
    'Good support teams follow four rules:\n'
    '- Confirm every ticket within one hour.\n'
    '- Set a priority for each ticket.\n'
    '- Keep the customer informed about\n'
    '  the status.\n'
    '- Document the solution for similar\n'
    '  cases.';

final List<ExamCase> casesA02 = [
  // ------------------------------------------------------------ Systemhaus
  fall(
    'f-a02-systemhaus',
    firma: 'systemhaus',
    bereich: 'a02',
    titel: 'Notebooks für die Kanzlei: Bezugspreis, Kauf oder Leasing',
    situation:
        'Für die neuen Büroräume der Steuerkanzlei Albers & Partner beschafft die Kessler & Brandt IT-Systemhaus GmbH 18 Notebooks. Drei Lieferanten haben Angebote abgegeben. Du ermittelst die Bezugspreise und bereitest für die Kanzlei den Vergleich zwischen Kauf und Leasing vor.',
    teile: [
      tabelle(
        'f-a02-systemhaus-a',
        'pr-angebot',
        scenario:
            'Die drei Angebote gelten jeweils für 18 Notebooks. Bei Lieferung „ab Werk“ berechnet die Spedition für die Abholung pauschal 90,00 €; „frei Haus“ heißt, der Lieferant trägt die Transportkosten. Skonto wird immer genutzt.',
        table: [
          ['Lieferant', 'Stückpreis', 'Rabatt', 'Skonto', 'Lieferung'],
          ['L1', '950,00 €', '10 %', '2 %', 'frei Haus'],
          ['L2', '900,00 €', '6 %', '3 %', 'ab Werk'],
          ['L3', '880,00 €', '-', '2 %', 'frei Haus'],
        ],
        prompt:
            'Ermittle die Bezugspreise: Ergänze die fehlenden Beträge im Kalkulationsschema (in €).',
        zeilen: [
          ['Schritt', 'L1', 'L2', 'L3'],
          ['Listeneinkaufspreis', '17.100,00', '16.200,00', '15.840,00'],
          [
            '- Rabatt',
            zahl(1710, toleranz: 0.01, rationale: '10 % von 17.100'),
            zahl(972, toleranz: 0.01, rationale: '6 % von 16.200'),
            '0,00',
          ],
          [
            '= Zieleinkaufspreis',
            zahl(15390, toleranz: 0.01),
            zahl(15228, toleranz: 0.01),
            '15.840,00',
          ],
          [
            '- Skonto',
            zahl(307.8, toleranz: 0.01, rationale: '2 % von 15.390'),
            zahl(456.84, toleranz: 0.01, rationale: '3 % von 15.228'),
            '316,80',
          ],
          [
            '= Bareinkaufspreis',
            zahl(15082.2, toleranz: 0.01),
            zahl(14771.16, toleranz: 0.01),
            '15.523,20',
          ],
          [
            '+ Bezugskosten',
            '0,00',
            zahl(90, toleranz: 0.01, rationale: 'ab Werk: Spedition 90 €'),
            '0,00',
          ],
          [
            '= Bezugspreis',
            zahl(15082.2, toleranz: 0.01),
            zahl(14861.16, toleranz: 0.01),
            '15.523,20',
          ],
        ],
        punkte: 10,
        explanation:
            'L1: 17.100 − 10 % (1.710) = 15.390; − 2 % Skonto (307,80) = 15.082,20; frei Haus → Bezugspreis 15.082,20 €. L2: 16.200 − 6 % (972) = 15.228; − 3 % Skonto (456,84) = 14.771,16; + 90 € Spedition = 14.861,16 €. L3: 15.840 − 2 % (316,80) = 15.523,20 €. Skonto wird vom Zieleinkaufspreis gerechnet; L2 ist trotz der Bezugskosten am günstigsten.',
        difficulty: 3,
      ),
      freitext(
        'f-a02-systemhaus-b',
        'pr-angebot',
        scenario:
            'Die Einkaufsleiterin überlegt, trotz des höheren Bezugspreises bei Lieferant L1 zu bestellen.',
        prompt:
            'Nenne drei Gründe, die für die Wahl eines teureren Lieferanten sprechen können.',
        kriterien: [
          krit(
            'Zuverlässigkeit und Termintreue',
            stichwoerter: ['zuverlässig', 'Termintreue', 'pünktlich'],
          ),
          krit(
            'Kürzere Lieferzeit',
            stichwoerter: [
              'Lieferzeit',
              'schneller liefern',
              'sofort lieferbar',
            ],
          ),
          krit(
            'Besserer Service und Support',
            stichwoerter: [
              'Service',
              'Support',
              'Betreuung',
              'Ansprechpartner',
            ],
          ),
          krit(
            'Kulanz bei Reklamationen',
            stichwoerter: ['Kulanz', 'Reklamation', 'kulant'],
          ),
          krit(
            'Höhere Qualität bzw. längere Garantie',
            stichwoerter: ['Qualität', 'Garantie', 'Gewährleistung'],
          ),
          krit(
            'Gute Erfahrungen aus der bisherigen Zusammenarbeit',
            stichwoerter: ['Erfahrung', 'Zusammenarbeit', 'Stammlieferant'],
          ),
        ],
        punkte: 3,
        loesung:
            'Für einen teureren Lieferanten sprechen zum Beispiel seine Zuverlässigkeit und Termintreue, ein besserer Service mit festem Ansprechpartner und Kulanz bei Reklamationen. Auch eine kürzere Lieferzeit, bessere Qualität oder längere Garantie können den Aufpreis rechtfertigen.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3. Der Bezugspreis ist nur das quantitative Kriterium. Qualitative Kriterien wie Zuverlässigkeit, Service, Kulanz, Lieferzeit und Qualität können einen höheren Preis aufwiegen.',
      ),
      lueckentext(
        'f-a02-systemhaus-c',
        'vt-arten',
        scenario:
            'Die Kanzlei könnte die 18 Notebooks statt zu kaufen auch leasen: 36 Monate Laufzeit, 470,00 € Rate je Monat für alle Geräte, mit Kaufoption.',
        prompt: 'Ergänze die Beschreibung des Leasings.',
        text:
            'Beim Leasing erhält die Kanzlei gegen eine monatliche Rate ein zeitlich begrenztes {0} an den Notebooks. Eigentümer der Geräte bleibt der {1}, Besitzer ist der {2}. Rechtlich wird Leasing im Kern wie ein {3} behandelt.',
        luecken: [
          wahl('Nutzungsrecht', [
            'Eigentumsrecht',
            'Rückgaberecht',
          ], 'Leasing = Gebrauch auf Zeit gegen Entgelt.'),
          wahl('Leasinggeber', [
            'Leasingnehmer',
            'Hersteller',
          ], 'Ihm gehören die Geräte.'),
          wahl(
            'Leasingnehmer',
            ['Leasinggeber', 'Lieferant'],
            'Er hat die Geräte in seiner tatsächlichen Gewalt und nutzt sie.',
          ),
          wahl('Mietvertrag', [
            'Kaufvertrag',
            'Werkvertrag',
          ], 'Leasing ist im BGB nicht eigens geregelt.'),
        ],
        punkte: 4,
        explanation:
            'Leasing ist ein zeitlich begrenztes, vertraglich vereinbartes Nutzungsrecht gegen Raten. Eigentümer bleibt der Leasinggeber, Besitzer ist der Leasingnehmer. Rechtlich wird Leasing im Kern wie Miete behandelt.',
      ),
      rechnen(
        'f-a02-systemhaus-d',
        'pr-angebot',
        scenario:
            'Kauf bei Lieferant L2: Bezugspreis 14.861,16 €. Leasing: 36 Monate zu je 470,00 €.',
        prompt:
            'Berechne, um wie viel Euro das Leasing über die gesamte Laufzeit teurer ist als der Kauf.',
        answer: 2058.84,
        unit: '€',
        tolerance: 0.01,
        punkte: 3,
        explanation:
            'Leasing gesamt: 36 × 470,00 € = 16.920,00 €. Differenz zum Kauf: 16.920,00 € − 14.861,16 € = 2.058,84 €. Das Leasing ist um 2.058,84 € teurer, schont aber die Liquidität.',
      ),
      freitext(
        'f-a02-systemhaus-e',
        'vt-arten',
        scenario:
            'Obwohl das Leasing in der Summe teurer ist, zeigt die Kanzlei Interesse daran.',
        prompt: 'Nenne drei Vorteile des Leasings gegenüber dem Kauf.',
        kriterien: [
          krit(
            'Die Liquidität bleibt erhalten, weil kein hoher Kaufpreis auf einmal anfällt.',
            stichwoerter: [
              'Liquidität',
              'flüssig',
              'zahlungsfähig',
              'auf einmal',
            ],
          ),
          krit(
            'Eigenkapital und Kreditspielraum werden geschont.',
            stichwoerter: ['Eigenkapital', 'Kredit', 'Kreditrahmen'],
          ),
          krit(
            'Gleichbleibende Raten sind gut planbar.',
            stichwoerter: [
              'planbar',
              'gleichbleibend',
              'feste Raten',
              'kalkulierbar',
            ],
          ),
          krit(
            'Nach der Laufzeit können neue Geräte geleast werden. Die Technik bleibt aktuell.',
            stichwoerter: [
              'aktuell',
              'neue Geräte',
              'Technikwechsel',
              'neueste',
              'modern',
            ],
          ),
          krit(
            'Leasingraten sind als Betriebsausgaben steuerlich absetzbar.',
            stichwoerter: [
              'steuerlich',
              'Betriebsausgabe',
              'absetzbar',
              'Steuer',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Beim Leasing bleibt die Liquidität erhalten, weil die Kanzlei nicht rund 15.000 € auf einmal zahlen muss. Die gleichbleibenden Raten sind gut planbar. Nach 36 Monaten kann sie auf neue Geräte wechseln, die Technik bleibt aktuell.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3. Vorteile des Leasings: Liquidität bleibt erhalten, Eigenkapital und Kreditspielraum werden geschont, planbare Raten, regelmäßiger Technikwechsel, steuerliche Vorteile.',
      ),
      freitext(
        'f-a02-systemhaus-f',
        'vt-arten',
        scenario: 'Das Leasingangebot enthält eine Kaufoption.',
        prompt: 'Erläutere, was die Kaufoption für die Kanzlei bedeutet.',
        kriterien: [
          krit(
            'Am Ende der Laufzeit kann die Kanzlei die Notebooks kaufen. Sie muss es aber nicht.',
            stichwoerter: [
              'Ende der Laufzeit',
              'Vertragsende',
              'kaufen',
              'übernehmen',
              'erwerben',
            ],
          ),
          krit(
            'Der Kaufpreis ist der vereinbarte Restwert; mit dem Kauf wird die Kanzlei Eigentümerin.',
            stichwoerter: ['Restwert', 'Eigentümer', 'Eigentum', 'Buchwert'],
          ),
        ],
        punkte: 2,
        loesung:
            'Die Kaufoption gibt der Kanzlei das Recht, die Notebooks am Ende der Laufzeit zum vereinbarten Restwert zu kaufen. Nutzt sie die Option, wird sie Eigentümerin; andernfalls gibt sie die Geräte zurück.',
        explanation:
            '1 Punkt für das Recht zum Kauf am Vertragsende, 1 Punkt für Restwert bzw. Eigentumsübergang. Eine Option ist ein Recht, keine Pflicht.',
      ),
    ],
  ),

  // ---------------------------------------------------------------- Handel
  fall(
    'f-a02-handel',
    firma: 'handel',
    bereich: 'a02',
    titel: 'Eingangsrechnung der Filiale Göttingen prüfen',
    situation:
        'Für die neue Filiale in Göttingen hat die Grünwerk Gartenbedarf GmbH bei der Kassentechnik Weser GmbH Kassenzubehör bestellt. Die Rechnung ist eingetroffen, heute ist der 16.04.2026. Du unterstützt die Buchhaltung bei der Prüfung und Zahlung. Zugleich will die Buchhaltung Eingangsrechnungen künftig automatisch einlesen und prüfen lassen.',
    teile: [
      tabelle(
        'f-a02-handel-a',
        'pr-angebot',
        code: _belegHandel,
        prompt: 'Ordne jedem Datum des Belegs den kaufmännischen Vorgang zu.',
        zeilen: [
          ['Datum', 'Vorgang'],
          [
            '07.04.2026',
            wahl('Bestellung', [
              'Lieferung',
              'Rechnungsstellung',
              'Ende der Skontofrist',
              'Ende des Zahlungsziels',
            ]),
          ],
          [
            '13.04.2026',
            wahl('Lieferung', [
              'Bestellung',
              'Rechnungsstellung',
              'Ende der Skontofrist',
              'Ende des Zahlungsziels',
            ]),
          ],
          [
            '14.04.2026',
            wahl('Rechnungsstellung', [
              'Bestellung',
              'Lieferung',
              'Ende der Skontofrist',
              'Ende des Zahlungsziels',
            ]),
          ],
          [
            '24.04.2026',
            wahl('Ende der Skontofrist', [
              'Bestellung',
              'Lieferung',
              'Rechnungsstellung',
              'Ende des Zahlungsziels',
            ]),
          ],
          [
            '14.05.2026',
            wahl('Ende des Zahlungsziels', [
              'Bestellung',
              'Lieferung',
              'Rechnungsstellung',
              'Ende der Skontofrist',
            ]),
          ],
        ],
        punkte: 3,
        explanation:
            'Bereits stattgefunden haben drei Vorgänge: Bestellung am 07.04., Lieferung am 13.04. und Rechnungsstellung am 14.04.2026. Der 24.04. (Skontofrist) und der 14.05. (Zahlungsziel) sind Fristen, die noch laufen.',
      ),
      freitext(
        'f-a02-handel-b',
        'pr-angebot',
        code: _belegHandel,
        prompt:
            'Beschreibe drei Kontrollen, die du an den Rechnungspositionen vornimmst.',
        kriterien: [
          krit(
            'Artikel: Stimmen die berechneten Artikel mit Bestellung und Lieferschein überein?',
            punkte: 2,
            stichwoerter: ['Artikel', 'Bezeichnung', 'Ware', 'Produkt'],
          ),
          krit(
            'Menge: Wurde nur berechnet, was bestellt und geliefert wurde?',
            punkte: 2,
            stichwoerter: ['Menge', 'Stückzahl', 'Anzahl', 'Lieferschein'],
          ),
          krit(
            'Einzelpreis: Entspricht er der Bestellung bzw. dem Angebot?',
            punkte: 2,
            stichwoerter: ['Einzelpreis', 'Preis', 'Stückpreis', 'Rabatt'],
          ),
          krit(
            'Steuersatz: 19 % für Geräte, 7 % für das Fachbuch?',
            punkte: 2,
            stichwoerter: [
              'Steuersatz',
              'Umsatzsteuer',
              'Mehrwertsteuer',
              '19 %',
              '7 %',
            ],
          ),
          krit(
            'Rechnerische Richtigkeit: Menge × Einzelpreis und Summen nachrechnen.',
            punkte: 2,
            stichwoerter: [
              'nachrechnen',
              'rechnerisch',
              'Summe',
              'Gesamtpreis',
              'multiplizieren',
            ],
          ),
        ],
        punkte: 6,
        loesung:
            'Ich vergleiche je Position die Menge mit Bestellung und Lieferschein (4 Bondrucker, 4 Kassenschubladen, 2 Bücher). Ich prüfe, ob die Einzelpreise der Bestellung entsprechen. Und ich kontrolliere den Steuersatz: 19 % für die Geräte, 7 % für das Fachbuch.',
        explanation:
            'Je beschriebener Kontrolle 2 Punkte, höchstens 6. Gewertet werden nur Kontrollen der Positionen (Artikel, Menge, Einzelpreis, Steuersatz, Rechenweg), nicht Anschrift oder Bankverbindung.',
      ),
      rechnen(
        'f-a02-handel-c',
        'pr-angebot',
        code: _belegHandel,
        prompt:
            'Die Rechnung wird am 22.04.2026 bezahlt. Berechne den Skontobetrag. Runde kaufmännisch auf zwei Nachkommastellen.',
        answer: 27.70,
        unit: '€',
        tolerance: 0.005,
        punkte: 2,
        explanation:
            'Der 22.04. liegt in der Skontofrist. Skonto wird vom Rechnungsbetrag (brutto) berechnet: 1.385,10 € × 0,02 = 27,702 € → 27,70 €. Überwiesen werden 1.385,10 € − 27,70 € = 1.357,40 €.',
      ),
      freitext(
        'f-a02-handel-d',
        'pr-angebot',
        scenario:
            'Beim nächsten Einkauf will Grünwerk mit der Kassentechnik Weser GmbH über einen Rabatt verhandeln.',
        prompt:
            'Beschreibe zwei Gründe, aus denen ein Lieferant einen Rabatt gewährt.',
        kriterien: [
          krit(
            'Mengenrabatt: Nachlass für die Abnahme großer Stückzahlen.',
            punkte: 2,
            stichwoerter: [
              'Menge',
              'Stückzahl',
              'große Bestellung',
              'Mengenrabatt',
            ],
          ),
          krit(
            'Treuerabatt: Nachlass für langjährige Stammkunden.',
            punkte: 2,
            stichwoerter: ['Treue', 'Stammkunde', 'langjährig'],
          ),
          krit(
            'Neukundenrabatt: Nachlass für die erste Bestellung, um Kunden zu gewinnen.',
            punkte: 2,
            stichwoerter: ['Neukunde', 'erste Bestellung', 'Erstbestellung'],
          ),
          krit(
            'Frühbezugs- oder Saisonrabatt: Nachlass für Bestellungen lange vor dem Bedarf oder außerhalb der Saison.',
            punkte: 2,
            stichwoerter: ['Frühbezug', 'Saison', 'frühzeitig', 'Frühbucher'],
          ),
          krit(
            'Sonderrabatt: Nachlass bei Aktionen, Auslaufmodellen oder Lagerräumung.',
            punkte: 2,
            stichwoerter: [
              'Aktion',
              'Auslaufmodell',
              'Räumung',
              'Sonderrabatt',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Mengenrabatt: Wer viele Stück auf einmal abnimmt, zahlt je Stück weniger, weil der Lieferant Aufwand spart. Treuerabatt: Langjährige Stammkunden erhalten einen Nachlass, damit sie beim Lieferanten bleiben.',
        explanation:
            'Je beschriebenem Grund 2 Punkte, höchstens 4. Rabattarten: Mengen-, Treue-, Neukunden-, Frühbezugs- und Sonderrabatt. Skonto ist dagegen kein Rabatt, sondern ein Nachlass für schnelle Zahlung.',
      ),
      freitext(
        'f-a02-handel-e',
        'pr-angebot',
        scenario: 'Auf der Rechnung ist ein GiroCode abgedruckt.',
        prompt: 'Nenne zwei Angaben, die im GiroCode enthalten sind.',
        kriterien: [
          krit(
            'Name des Zahlungsempfängers',
            stichwoerter: ['Empfänger', 'Name', 'Kontoinhaber'],
          ),
          krit(
            'IBAN des Empfängers',
            stichwoerter: ['IBAN', 'Kontonummer', 'Bankverbindung'],
          ),
          krit('BIC der Bank', stichwoerter: ['BIC', 'Bankleitzahl', 'SWIFT']),
          krit(
            'Betrag der Überweisung',
            stichwoerter: ['Betrag', 'Summe', 'Rechnungsbetrag'],
          ),
          krit(
            'Verwendungszweck',
            stichwoerter: ['Verwendungszweck', 'Rechnungsnummer', 'Zweck'],
          ),
        ],
        punkte: 2,
        loesung:
            'Der GiroCode enthält die Daten einer SEPA-Überweisung, zum Beispiel die IBAN des Empfängers und den Betrag. Außerdem: Name des Empfängers, BIC und Verwendungszweck.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2. Der GiroCode ist ein QR-Code mit den Daten einer SEPA-Überweisung: Empfänger, IBAN, BIC, Betrag und Verwendungszweck.',
      ),
      markieren(
        'f-a02-handel-f',
        'pr-angebot',
        scenario:
            'Die Buchhaltung überlegt, Rechnungen künftig nur noch per GiroCode zu bezahlen.',
        prompt: 'Markiere alle Aussagen zum GiroCode, die zutreffen.',
        zeilen: [
          ja(
            'Die Überweisungsdaten müssen nicht mehr abgetippt werden.',
            'Die Banking-App übernimmt alle Daten aus dem Code.',
          ),
          nein(
            'Die Zahlung wird beim Scannen sofort ohne Freigabe ausgeführt.',
            'Die Überweisung muss wie jede andere in der App freigegeben werden.',
          ),
          ja(
            'Zahlendreher bei IBAN und Betrag werden vermieden.',
            'Was nicht getippt wird, kann nicht vertippt werden.',
          ),
          nein(
            'Der GiroCode ersetzt die Prüfung der Rechnung.',
            'Der Code enthält nur Zahlungsdaten. Ob die Rechnung stimmt, muss weiter geprüft werden.',
          ),
          ja(
            'Der Lieferant kann den Zahlungseingang leichter zuordnen.',
            'Der Verwendungszweck ist richtig vorbelegt.',
          ),
        ],
        punkte: 2,
        explanation:
            'Erleichterungen durch den GiroCode: kein Abtippen, fehlerfreie Übernahme der Daten, bessere Zuordnung des Zahlungseingangs. Freigabe und Rechnungsprüfung bleiben nötig; wer Skonto abzieht, passt den Betrag in der App an.',
      ),
      freitext(
        'f-a02-handel-g',
        'cm-widerstand',
        scenario:
            'Die Buchhaltung soll Eingangsrechnungen künftig automatisch einlesen und prüfen lassen. Einige Beschäftigte lehnen das neue Verfahren ab.',
        prompt:
            'Nenne zwei mögliche Ursachen für die Ablehnung des neuen Verfahrens.',
        kriterien: [
          krit(
            'Angst um den eigenen Arbeitsplatz',
            stichwoerter: [
              'Arbeitsplatz',
              'Jobverlust',
              'überflüssig',
              'Stelle',
            ],
          ),
          krit(
            'Angst vor Überforderung durch die neue Software',
            stichwoerter: ['Überforderung', 'überfordert', 'zu kompliziert'],
          ),
          krit(
            'Festhalten an gewohnten Abläufen',
            stichwoerter: ['Gewohnheit', 'gewohnt', 'Routine', 'bewährt'],
          ),
          krit(
            'Sorge vor mehr Kontrolle und Leistungsdruck',
            stichwoerter: ['Kontrolle', 'Leistungsdruck', 'Überwachung'],
          ),
          krit(
            'Fehlende Information über Gründe und Nutzen',
            stichwoerter: [
              'Information',
              'nicht informiert',
              'Unwissenheit',
              'unklar',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Mögliche Ursachen sind die Angst, durch die Automatisierung den Arbeitsplatz zu verlieren, und die Sorge, mit der neuen Software überfordert zu sein. Weitere: Festhalten an Routinen, Angst vor Kontrolle, fehlende Information.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2. Widerstand gegen Veränderungen entsteht meist aus Angst (Arbeitsplatz, Überforderung, Kontrolle), aus Gewohnheit oder weil Gründe und Nutzen nicht erklärt wurden.',
      ),
      freitext(
        'f-a02-handel-h',
        'cm-widerstand',
        scenario:
            'Die Leiterin der Buchhaltung will die Bedenken der Beschäftigten ernst nehmen.',
        prompt:
            'Beschreibe zwei Maßnahmen, mit denen sie den Bedenken begegnen kann.',
        kriterien: [
          krit(
            'Früh und offen informieren: Gründe, Zeitplan und Folgen für die Arbeitsplätze erklären.',
            punkte: 2,
            stichwoerter: [
              'informieren',
              'kommunizieren',
              'erklären',
              'offen',
              'Transparenz',
            ],
          ),
          krit(
            'Schulen: Die Beschäftigten rechtzeitig in die neue Software einarbeiten.',
            punkte: 2,
            stichwoerter: [
              'Schulung',
              'schulen',
              'geschult',
              'schulen',
              'einarbeiten',
              'Training',
              'Anleitung',
            ],
          ),
          krit(
            'Beteiligen: Beschäftigte in Auswahl und Testphase einbeziehen und Rückmeldungen aufnehmen.',
            punkte: 2,
            stichwoerter: [
              'beteiligen',
              'einbeziehen',
              'mitwirken',
              'Pilotgruppe',
              'Feedback',
            ],
          ),
          krit(
            'Nutzen zeigen: Entlastung von Routinearbeit und anspruchsvollere Aufgaben herausstellen.',
            punkte: 2,
            stichwoerter: ['Nutzen', 'Entlastung', 'Vorteile', 'Aufwertung'],
          ),
        ],
        punkte: 4,
        loesung:
            'Sie informiert früh und offen über Gründe und Zeitplan und stellt klar, dass niemand seinen Arbeitsplatz verliert, sondern das Abtippen entfällt. Außerdem schult sie alle rechtzeitig und bezieht erfahrene Kolleginnen in die Testphase ein.',
        explanation:
            'Je beschriebener Maßnahme 2 Punkte, höchstens 4. Gegen Widerstände helfen frühe Kommunikation, Schulung, Beteiligung und das Aufzeigen des persönlichen Nutzens.',
      ),
    ],
  ),

  // --------------------------------------------------------------- Agentur
  fall(
    'f-a02-agentur',
    firma: 'agentur',
    bereich: 'a02',
    titel: 'Servicequalität und Kundenkommunikation im Support',
    situation:
        'Die Pixelhafen Medien GmbH führt ein Ticketsystem ein, weil sich Kunden über lange Wartezeiten beschweren. Bisher läuft der Support so: Kunden melden Störungen ausschließlich per E-Mail an ein Sammelpostfach. Ein Administrator trägt die Meldungen von Hand in eine Tabellenkalkulation ein. Einmal pro Woche verteilt die Teamleiterin die Aufgaben. Erreichbar ist der Support montags bis freitags von 9 bis 15 Uhr.',
    teile: [
      tabelle(
        'f-a02-agentur-a',
        'u-usecase',
        scenario:
            'Für das neue Ticketsystem wird ein Anwendungsfalldiagramm vorbereitet. Künftig gilt: Der Kunde meldet eine Störung im Portal und kann den Status abfragen. Das Serviceteam priorisiert und bearbeitet die Tickets; zum Bearbeiten gehört immer eine Rückmeldung an den Kunden. Die Teamleitung erstellt die Arbeitsplanung.',
        prompt:
            'Ergänze für das Diagramm: Welcher Akteur gehört zu welchem Anwendungsfall, und welche Beziehung besteht in der letzten Zeile?',
        zeilen: [
          ['Anwendungsfall', 'Akteur / Beziehung'],
          [
            'Störung melden',
            wahl('Kunde', ['Serviceteam', 'Teamleitung']),
          ],
          [
            'Status abfragen',
            wahl('Kunde', ['Serviceteam', 'Teamleitung']),
          ],
          [
            'Ticket priorisieren',
            wahl('Serviceteam', ['Kunde', 'Teamleitung']),
          ],
          [
            'Ticket bearbeiten',
            wahl('Serviceteam', ['Kunde', 'Teamleitung']),
          ],
          [
            'Arbeitsplanung erstellen',
            wahl('Teamleitung', ['Kunde', 'Serviceteam']),
          ],
          [
            '„Ticket bearbeiten“ → „Rückmeldung geben“',
            wahl('include', [
              'extend',
              'keine Beziehung',
            ], '„Gehört immer dazu“ bedeutet include.'),
          ],
        ],
        punkte: 6,
        explanation:
            'Akteure stehen außerhalb des Systems und lösen Anwendungsfälle aus: Kunde (melden, Status abfragen), Serviceteam (priorisieren, bearbeiten), Teamleitung (Arbeitsplanung). „Gehört immer dazu“ ist eine include-Beziehung; extend wäre eine Erweiterung, die nur unter einer Bedingung eintritt.',
      ),
      freitext(
        'f-a02-agentur-b',
        'k-kunde',
        prompt:
            'Beschreibe zwei Schwachstellen des bisherigen Ablaufs im Support (siehe Situation).',
        kriterien: [
          krit(
            'Nur ein Meldeweg (E-Mail an ein Sammelpostfach): Meldungen gehen leicht unter, es gibt keine Eingangsbestätigung.',
            punkte: 2,
            stichwoerter: [
              'E-Mail',
              'Meldeweg',
              'Sammelpostfach',
              'nur per Mail',
            ],
          ),
          krit(
            'Verwaltung von Hand in einer Tabellenkalkulation: fehleranfällig, unübersichtlich, kein Status für den Kunden.',
            punkte: 2,
            stichwoerter: [
              'Tabellenkalkulation',
              'von Hand',
              'manuell',
              'Excel',
              'fehleranfällig',
            ],
          ),
          krit(
            'Aufgaben werden nur einmal pro Woche verteilt: Dringende Störungen bleiben tagelang liegen.',
            punkte: 2,
            stichwoerter: [
              'einmal pro Woche',
              'wöchentlich',
              'Wartezeit',
              'Priorisierung',
            ],
          ),
          krit(
            'Eingeschränkte Servicezeiten (Mo-Fr 9-15 Uhr): Außerhalb dieser Zeiten erreicht der Kunde niemanden.',
            punkte: 2,
            stichwoerter: [
              'Servicezeit',
              'Erreichbarkeit',
              'erreichbar',
              '15 Uhr',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Erstens werden die Aufgaben nur einmal pro Woche verteilt. Eine dringende Störung kann also tagelang liegen bleiben. Zweitens werden die Meldungen von Hand in eine Tabelle übertragen: Das ist fehleranfällig, und weder Kunde noch Team sehen den aktuellen Status.',
        explanation:
            'Je beschriebener Schwachstelle 2 Punkte, höchstens 4. Kritikpunkte: nur ein Meldeweg, manuelle und unübersichtliche Datenhaltung, langsamer Planungstakt ohne Priorisierung, kurze Servicezeiten.',
      ),
      freitext(
        'f-a02-agentur-c',
        'k-kunde',
        prompt:
            'Nenne zwei Maßnahmen, mit denen die Agentur ihre Servicequalität verbessern kann.',
        kriterien: [
          krit(
            'Ticketsystem mit automatischer Eingangsbestätigung und Statusanzeige',
            stichwoerter: [
              'Ticketsystem',
              'Eingangsbestätigung',
              'Status',
              'Portal',
            ],
          ),
          krit(
            'Feste Reaktionszeiten vereinbaren (SLA)',
            stichwoerter: ['SLA', 'Reaktionszeit', 'Service Level'],
          ),
          krit(
            'Servicezeiten ausweiten',
            stichwoerter: [
              'Servicezeit',
              'Erreichbarkeit',
              'länger erreichbar',
              'Hotline',
            ],
          ),
          krit(
            'Kundenzufriedenheit regelmäßig abfragen',
            stichwoerter: [
              'Kundenfeedback',
              'Zufriedenheit',
              'Umfrage',
              'Befragung',
            ],
          ),
          krit(
            'Tickets täglich priorisieren und verteilen',
            stichwoerter: ['täglich', 'priorisieren', 'Priorität'],
          ),
          krit(
            'Wissensdatenbank bzw. FAQ für häufige Fragen',
            stichwoerter: ['Wissensdatenbank', 'FAQ', 'Selbsthilfe'],
          ),
        ],
        punkte: 2,
        loesung:
            'Zum Beispiel ein Ticketsystem mit automatischer Eingangsbestätigung und vereinbarte Reaktionszeiten (SLA). Weitere: längere Servicezeiten, tägliche Priorisierung, Kundenbefragungen, Wissensdatenbank.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2. Servicequalität steigt durch schnelle, nachvollziehbare und verlässliche Bearbeitung: Ticketsystem, SLA, längere Erreichbarkeit, Kundenfeedback.',
      ),
      freitext(
        'f-a02-agentur-d',
        'm-bedarf',
        scenario:
            'Bevor das Ticketsystem eingerichtet wird, will die Agentur wissen, was ihre Kunden vom Support erwarten.',
        prompt:
            'Nenne drei Methoden, mit denen sich der Bedarf der Kunden ermitteln lässt.',
        kriterien: [
          krit(
            'Interview bzw. persönliches Gespräch',
            stichwoerter: ['Interview', 'Gespräch', 'Telefonat'],
          ),
          krit(
            'Schriftliche Befragung mit Fragebogen',
            stichwoerter: ['Fragebogen', 'Umfrage', 'Befragung'],
          ),
          krit(
            'Beobachtung der Abläufe',
            stichwoerter: ['Beobachtung', 'beobachten'],
          ),
          krit(
            'Workshop mit ausgewählten Kunden',
            stichwoerter: ['Workshop', 'Fokusgruppe'],
          ),
          krit(
            'Auswertung vorhandener Unterlagen, z. B. bisheriger Beschwerden und Störungsmeldungen',
            stichwoerter: [
              'Auswertung',
              'Beschwerden',
              'Dokumente',
              'Unterlagen',
              'vorhandene Daten',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Geeignet sind Interviews mit wichtigen Kunden, ein Online-Fragebogen an alle Kunden und die Auswertung der bisherigen Beschwerden und Störungsmeldungen. Auch ein Workshop oder die Beobachtung der Abläufe sind möglich.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3. Methoden der Bedarfsermittlung: Interview, Fragebogen, Beobachtung, Workshop und die Auswertung vorhandener Unterlagen.',
      ),
      lueckentext(
        'f-a02-agentur-e',
        'k-kunde',
        scenario:
            'In einem englischen Fachblog findest du Hinweise zur Ticketbearbeitung.',
        code: _textAgentur,
        prompt: 'Ergänze die beiden Risiken, die der Text nennt.',
        text:
            'Wer Kunden tagelang warten lässt, riskiert laut Text, dass sie {0}. Wer zu schnell antwortet, ohne das Problem zu prüfen, verursacht {1}.',
        luecken: [
          wahl('zu einem Wettbewerber wechseln', [
            'weniger Tickets schreiben',
            'höhere Preise zahlen',
          ], '„move to a competitor“'),
          wahl('falsche Lösungen und Mehrarbeit', [
            'zufriedenere Kunden',
            'niedrigere Kosten',
          ], '„wrong solutions and extra work“'),
        ],
        punkte: 2,
        explanation:
            'Zu langsam: „customers who wait for days often move to a competitor“: Kunden wandern zur Konkurrenz ab. Zu schnell: „leads to wrong solutions and extra work“: falsche Lösungen und zusätzliche Arbeit.',
      ),
      freitext(
        'f-a02-agentur-f',
        'k-kunde',
        code: _textAgentur,
        prompt:
            'Nenne auf Deutsch die vier Regeln guter Ticketbearbeitung aus dem Text.',
        kriterien: [
          krit(
            'Jedes Ticket innerhalb einer Stunde bestätigen.',
            stichwoerter: [
              'bestätigen',
              'Bestätigung',
              'einer Stunde',
              'Eingang',
            ],
          ),
          krit(
            'Für jedes Ticket eine Priorität festlegen.',
            stichwoerter: ['Priorität', 'priorisieren', 'Dringlichkeit'],
          ),
          krit(
            'Den Kunden über den Status auf dem Laufenden halten.',
            stichwoerter: [
              'Status',
              'informieren',
              'auf dem Laufenden',
              'Bearbeitungsstand',
            ],
          ),
          krit(
            'Die Lösung für ähnliche Fälle dokumentieren.',
            stichwoerter: [
              'dokumentieren',
              'Dokumentation',
              'festhalten',
              'aufschreiben',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Erstens jedes Ticket innerhalb einer Stunde bestätigen. Zweitens für jedes Ticket eine Priorität festlegen. Drittens den Kunden über den Status informieren. Viertens die Lösung für ähnliche Fälle dokumentieren.',
        explanation:
            'Je Regel 1 Punkt. Vokabeln: to confirm = bestätigen, to set a priority = eine Priorität festlegen, to keep informed = auf dem Laufenden halten, to document = dokumentieren.',
      ),
      tabelle(
        'f-a02-agentur-g',
        'k-modelle',
        scenario:
            'Ein Kunde ruft an und sagt: „Seit drei Tagen warte ich auf eine Antwort. Bei dem, was wir Ihnen zahlen!“',
        prompt:
            'Deute die Aussage nach dem Vier-Seiten-Modell: Wähle zu jeder Seite die passende Botschaft.',
        zeilen: [
          ['Seite', 'Botschaft'],
          [
            'Sachinhalt',
            wahl('Seit drei Tagen gibt es keine Antwort.', [
              'Ich bin verärgert und enttäuscht.',
              'Sie nehmen mich als Kunden nicht ernst.',
              'Antworten Sie schneller!',
            ]),
          ],
          [
            'Selbstoffenbarung',
            wahl('Ich bin verärgert und enttäuscht.', [
              'Seit drei Tagen gibt es keine Antwort.',
              'Sie nehmen mich als Kunden nicht ernst.',
              'Antworten Sie schneller!',
            ]),
          ],
          [
            'Beziehung',
            wahl('Sie nehmen mich als Kunden nicht ernst.', [
              'Seit drei Tagen gibt es keine Antwort.',
              'Ich bin verärgert und enttäuscht.',
              'Antworten Sie schneller!',
            ]),
          ],
          [
            'Appell',
            wahl('Antworten Sie schneller!', [
              'Seit drei Tagen gibt es keine Antwort.',
              'Ich bin verärgert und enttäuscht.',
              'Sie nehmen mich als Kunden nicht ernst.',
            ]),
          ],
        ],
        punkte: 4,
        explanation:
            'Sachinhalt: die Tatsache (drei Tage ohne Antwort). Selbstoffenbarung: was der Kunde über sich zeigt (Ärger). Beziehung: wie er das Verhältnis sieht (fühlt sich nicht ernst genommen). Appell: was er erreichen will (schnellere Antwort).',
      ),
    ],
  ),

  // -------------------------------------------------------------- Logistik
  fall(
    'f-a02-logistik',
    firma: 'logistik',
    bereich: 'a02',
    titel: 'Monitore für die Disposition: gewichteter Angebotsvergleich',
    situation:
        'Die Elbtal Logistik AG modernisiert 24 Arbeitsplätze der Disposition und beschafft dafür 24 Monitore. Die IT-Abteilung hat drei Angebote eingeholt. Du vergleichst die Angebote nach Preis und Leistung, bereitest die Zahlung vor und stellst das Ergebnis der Leitung der Disposition vor.',
    teile: [
      lueckentext(
        'f-a02-logistik-a',
        'm-markt',
        scenario:
            'Bei der Marktbeobachtung fällt auf: Software für die Lagerverwaltung bieten nur wenige Hersteller an, Monitore dagegen sehr viele Händler.',
        prompt: 'Trage die Marktformen ein.',
        text:
            'Wenige Anbieter stehen vielen Nachfragern gegenüber: Die Marktform heißt {0}. Viele Anbieter stehen vielen Nachfragern gegenüber: Die Marktform heißt {1}.',
        luecken: [
          wort([
            'Angebotsoligopol',
            'Oligopol',
          ], 'Wenige Anbieter, viele Nachfrager.'),
          wort([
            'Polypol',
          ], 'Viele Anbieter, viele Nachfrager: vollständige Konkurrenz.'),
        ],
        punkte: 2,
        explanation:
            'Wenige Anbieter und viele Nachfrager bilden ein Angebotsoligopol, viele Anbieter und viele Nachfrager ein Polypol. Im Polypol bestimmt der Wettbewerb den Preis, und das ist gut für den Einkauf.',
      ),
      tabelle(
        'f-a02-logistik-b',
        'pr-angebot',
        scenario:
            'Die drei Angebote je Monitor. „Ab Werk“ heißt: Die Elbtal Logistik AG trägt die Fracht selbst, hier 6,00 € je Stück. „Frei Haus“ heißt: Der Lieferant trägt die Transportkosten.',
        table: [
          ['Lieferant', 'Listenpreis', 'Lieferung', 'Lieferzeit'],
          ['L1', '200,00 €', 'ab Werk', '5 Wochen'],
          ['L2', '215,00 €', 'frei Haus', '3 Wochen'],
          ['L3', '240,00 €', 'frei Haus', '1 Woche'],
        ],
        prompt: 'Ermittle den Bezugspreis je Monitor.',
        zeilen: [
          ['Lieferant', 'Bezugspreis je Stück in €'],
          ['L1', zahl(206, toleranz: 0.01, rationale: '200 € + 6 € Fracht')],
          ['L2', zahl(215, toleranz: 0.01, rationale: 'frei Haus')],
          ['L3', zahl(240, toleranz: 0.01, rationale: 'frei Haus')],
        ],
        punkte: 3,
        explanation:
            'Rabatt und Skonto gibt es hier nicht. Entscheidend ist die Lieferbedingung. L1 „ab Werk“: 200 € + 6 € Fracht = 206 €. L2 und L3 liefern frei Haus: 215 € und 240 €.',
      ),
      tabelle(
        'f-a02-logistik-c',
        'w-nutzwert',
        scenario:
            'Bezugspreise je Stück: L1 206 €, L2 215 €, L3 240 €. Lieferzeiten: L1 5 Wochen, L2 3 Wochen, L3 1 Woche. Bewertet wird mit Rangpunkten: 3 = bester, 1 = schlechtester Wert je Kriterium. Qualität und Erfahrungen sind bereits bewertet.',
        prompt:
            'Vergib die Rangpunkte für Preis und Lieferzeit und berechne für jeden Lieferanten die gewichtete Summe (Punkte × Gewicht, aufaddiert).',
        zeilen: [
          ['Kriterium', 'Gewicht', 'L1', 'L2', 'L3'],
          [
            'Bezugspreis',
            '40',
            zahl(3, rationale: 'günstigster Preis'),
            zahl(2),
            zahl(1, rationale: 'teuerster Preis'),
          ],
          [
            'Lieferzeit',
            '20',
            zahl(1, rationale: 'längste Lieferzeit'),
            zahl(2),
            zahl(3, rationale: 'kürzeste Lieferzeit'),
          ],
          ['Qualität', '25', '2', '1', '3'],
          ['Erfahrungen', '15', '1', '2', '3'],
          [
            'Summe gewichtet',
            '100',
            zahl(205, rationale: '120 + 20 + 50 + 15'),
            zahl(175, rationale: '80 + 40 + 25 + 30'),
            zahl(220, rationale: '40 + 60 + 75 + 45'),
          ],
        ],
        punkte: 7,
        explanation:
            'Beim Preis ist der niedrigste Wert der beste (L1 = 3), bei der Lieferzeit die kürzeste (L3 = 3). L1: 3 × 40 + 1 × 20 + 2 × 25 + 1 × 15 = 205. L2: 2 × 40 + 2 × 20 + 1 × 25 + 2 × 15 = 175. L3: 1 × 40 + 3 × 20 + 3 × 25 + 3 × 15 = 220. L3 gewinnt trotz des höchsten Preises.',
        difficulty: 3,
      ),
      freitext(
        'f-a02-logistik-d',
        'pr-angebot',
        scenario:
            'Die Nutzwertanalyse spricht für Lieferant L3, obwohl er am teuersten ist.',
        prompt:
            'Nenne drei Gründe, die allgemein für die Wahl eines teureren Lieferanten sprechen können.',
        kriterien: [
          krit(
            'Kürzere Lieferzeit',
            stichwoerter: ['Lieferzeit', 'schneller', 'sofort lieferbar'],
          ),
          krit(
            'Höhere Qualität der Ware',
            stichwoerter: ['Qualität', 'hochwertig', 'langlebig'],
          ),
          krit(
            'Zuverlässigkeit und Termintreue',
            stichwoerter: ['zuverlässig', 'Termintreue', 'pünktlich'],
          ),
          krit(
            'Besserer Service, Garantie und Kulanz',
            stichwoerter: ['Service', 'Garantie', 'Kulanz', 'Support'],
          ),
          krit(
            'Gute Erfahrungen und geringe Reklamationsquote',
            stichwoerter: ['Erfahrung', 'Reklamation', 'Zusammenarbeit'],
          ),
        ],
        punkte: 3,
        loesung:
            'Für einen teureren Lieferanten sprechen eine kürzere Lieferzeit, eine höhere Qualität der Ware und gute Erfahrungen mit seiner Zuverlässigkeit. Auch Service, Garantie und Kulanz zählen.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3. Wer nur auf den Preis schaut, entscheidet oft falsch: Lieferzeit, Qualität, Zuverlässigkeit, Service und Kulanz haben ebenfalls einen Wert.',
      ),
      rechnen(
        'f-a02-logistik-e',
        'pr-angebot',
        scenario:
            'Die Rechnung von L3 über 24 Monitore zu je 240,00 € netto zuzüglich 19 % Umsatzsteuer trifft ein. Zahlungsbedingung: 30 Tage ohne Abzug, innerhalb von 10 Tagen abzüglich 2 % Skonto.',
        prompt:
            'Berechne den Skontobetrag bei Zahlung innerhalb der Skontofrist. Runde kaufmännisch auf zwei Nachkommastellen.',
        answer: 137.09,
        unit: '€',
        tolerance: 0.005,
        punkte: 2,
        explanation:
            'Netto: 24 × 240,00 € = 5.760,00 €. Umsatzsteuer 19 %: 1.094,40 €. Rechnungsbetrag brutto: 6.854,40 €. Skonto: 6.854,40 € × 0,02 = 137,088 € → 137,09 €. Skonto wird beim Bezahlen vom Bruttobetrag berechnet.',
      ),
      freitext(
        'f-a02-logistik-f',
        'pr-angebot',
        scenario:
            'L3 bietet an, Rechnungen künftig nur noch als E-Rechnung zu schicken. Die Buchhaltung der Elbtal Logistik AG arbeitet bisher mit Papierrechnungen.',
        prompt:
            'Nenne zwei Vorteile und zwei Nachteile digitaler Rechnungen für die Elbtal Logistik AG.',
        kriterien: [
          krit(
            'Vorteil: schnellere, automatische Verarbeitung ohne Abtippen',
            stichwoerter: [
              'schneller',
              'automatisch',
              'Zeitersparnis',
              'effizient',
            ],
          ),
          krit(
            'Vorteil: geringere Kosten für Papier, Druck, Porto und Ablage',
            stichwoerter: ['Papier', 'Porto', 'Druckkosten', 'Kostenersparnis'],
          ),
          krit(
            'Vorteil: weniger Erfassungsfehler, kein Medienbruch',
            stichwoerter: ['Fehler', 'Medienbruch', 'Tippfehler'],
          ),
          krit(
            'Vorteil: Rechnungen sind schnell auffindbar und nachverfolgbar',
            stichwoerter: [
              'auffindbar',
              'nachverfolgen',
              'Archiv',
              'wiederfinden',
            ],
          ),
          krit(
            'Nachteil: Kosten für Software und Einführung',
            stichwoerter: [
              'Anschaffung',
              'Investition',
              'Einführung',
              'Software',
            ],
          ),
          krit(
            'Nachteil: Schulungsaufwand und Vorbehalte der Beschäftigten',
            stichwoerter: [
              'Schulung',
              'schulen',
              'geschult',
              'Vorbehalte',
              'Einarbeitung',
              'Akzeptanz',
            ],
          ),
          krit(
            'Nachteil: Abhängigkeit von der IT und Sicherheitsrisiken',
            stichwoerter: [
              'abhängig',
              'Ausfall',
              'Sicherheitsrisiko',
              'Angriff',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Vorteile: Rechnungen werden automatisch eingelesen und schneller bearbeitet; Kosten für Papier, Porto und Ablage entfallen. Nachteile: Die Einführung kostet Geld für Software, und die Beschäftigten müssen geschult werden.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 4. Vorteile: Effizienz, Kostenersparnis, weniger Fehler, schneller Zugriff. Nachteile: Anfangsinvestition, Schulungsaufwand, Sicherheitsrisiken und Abhängigkeit von der IT.',
      ),
      freitext(
        'f-a02-logistik-g',
        'pr-praesentation',
        scenario:
            'Du stellst das Ergebnis des Angebotsvergleichs der Leitung der Disposition in fünf Minuten vor. Die Zuhörer sind keine IT-Fachleute.',
        prompt:
            'Beschreibe zwei Punkte, die du bei dieser Präsentation beachtest, damit sie adressatengerecht ist.',
        kriterien: [
          krit(
            'Den Nutzen für die Disposition und die Kosten in den Mittelpunkt stellen statt technischer Details.',
            punkte: 2,
            stichwoerter: [
              'Nutzen',
              'Kosten',
              'Vorteile für',
              'wirtschaftlich',
            ],
          ),
          krit(
            'Fachbegriffe vermeiden oder erklären.',
            punkte: 2,
            stichwoerter: [
              'Fachbegriffe',
              'Fachsprache',
              'verständlich',
              'einfache Sprache',
            ],
          ),
          krit(
            'Das Ergebnis der Nutzwertanalyse als einfaches Diagramm oder kurze Tabelle zeigen.',
            punkte: 2,
            stichwoerter: ['Diagramm', 'Tabelle', 'visualisieren', 'Grafik'],
          ),
          krit(
            'Mit einer klaren Empfehlung schließen und Fragen zulassen.',
            punkte: 2,
            stichwoerter: ['Empfehlung', 'Fazit', 'Entscheidung', 'Fragen'],
          ),
        ],
        punkte: 4,
        loesung:
            'Ich erkläre den Nutzen für die Disposition, zum Beispiel die schnelle Lieferung in einer Woche und die bessere Qualität, statt technische Daten aufzuzählen. Das Ergebnis der Nutzwertanalyse zeige ich als einfaches Balkendiagramm und schließe mit einer klaren Empfehlung für L3.',
        explanation:
            'Je beschriebenem Punkt 2 Punkte, höchstens 4. Adressatengerecht präsentieren heißt: Nutzen statt Technik, verständliche Sprache, Zahlen visualisieren und eine klare Empfehlung geben.',
      ),
    ],
  ),
];
