import '../builders.dart';

/// Fallaufgaben (je 25 Punkte) zu Bereich 07 für die Prüfungssimulation.
///
/// Aufbau wie in der AP1: viele kleine Freitext-Teilaufgaben (nennen,
/// beschreiben, erläutern), dazu eine Rechnung, eine Tabelle und ein
/// englischer Text. Keine Auswahlaufgaben.
final List<ExamCase> casesA07 = [
  // ------------------------------------------------------------ Systemhaus
  fall(
    'f-a07-systemhaus',
    firma: 'systemhaus',
    bereich: 'a07',
    titel: 'Notebooks für die Kanzlei: Kaufvertrag, Lieferverzug, Einführung',
    situation:
        'Für die Steuerkanzlei Albers & Partner hat die Kessler & Brandt IT-Systemhaus GmbH bei einem Distributor 18 Notebooks bestellt. Die Kanzlei zieht am 9. März in die neuen Räume und will dann sofort mit den neuen Geräten arbeiten. Mit dem Umzug führt die Kanzlei außerdem eine digitale Aktenverwaltung ein, die die Papierakten ablöst. Du bearbeitest den Vorgang im Team Kundenprojekte.',
    teile: [
      freitext(
        'f-a07-systemhaus-a',
        'vt-zustandekommen',
        table: [
          ['Datum', 'Vorgang'],
          ['03.02.', 'Anfrage von Kessler & Brandt beim Distributor'],
          ['05.02.', 'Angebot des Distributors, gültig bis 19.02.'],
          ['12.02.', 'Bestellung zu den Bedingungen des Angebots'],
          ['13.02.', 'Auftragsbestätigung, Liefertermin 2. März'],
        ],
        prompt:
            'Erläutere, an welchem Tag der Kaufvertrag mit dem Distributor zustande gekommen ist.',
        kriterien: [
          krit(
            'Der Vertrag ist am 12.02. zustande gekommen',
            stichwoerter: ['12.02', '12. Februar', 'Bestellung'],
          ),
          krit(
            'Begründung: Das Angebot ist der Antrag, die fristgerechte Bestellung zu unveränderten Bedingungen die Annahme',
            stichwoerter: [
              'Antrag',
              'Annahme',
              'Willenserklärungen',
              'fristgerecht',
              'innerhalb der Frist',
            ],
          ),
        ],
        loesung:
            'Der Kaufvertrag ist am 12.02. zustande gekommen. Das Angebot vom 05.02. ist der Antrag; die Bestellung vom 12.02. erfolgt innerhalb der Frist und ohne Änderungen und ist damit die Annahme. Die Auftragsbestätigung vom 13.02. bestätigt den Vertrag nur noch, die Anfrage vom 03.02. war unverbindlich.',
        explanation:
            '1 Punkt für den Zeitpunkt, 1 Punkt für die Begründung mit Antrag und Annahme. Wäre die Bestellung erst nach dem 19.02. eingegangen, wäre sie ein neuer Antrag gewesen und erst die Auftragsbestätigung die Annahme.',
        punkte: 2,
      ),
      freitext(
        'f-a07-systemhaus-b',
        'vt-arten',
        prompt:
            'Nenne drei Inhalte, die in einem Kaufvertrag über die Notebooks geregelt sein sollten.',
        kriterien: [
          krit(
            'Kaufgegenstand (Art, Modell, Ausstattung)',
            stichwoerter: [
              'Kaufgegenstand',
              'Ware',
              'Modell',
              'Artikel',
              'Art',
            ],
          ),
          krit(
            'Menge (Stückzahl)',
            stichwoerter: ['Menge', 'Stückzahl', 'Anzahl'],
          ),
          krit(
            'Preis je Gerät',
            stichwoerter: ['Preis', 'Kaufpreis', 'Rabatt'],
          ),
          krit(
            'Zahlungsbedingungen',
            stichwoerter: ['Zahlungsbedingungen', 'Zahlungsziel', 'Skonto'],
          ),
          krit(
            'Lieferbedingungen und Liefertermin',
            stichwoerter: [
              'Liefertermin',
              'Lieferbedingungen',
              'Lieferzeit',
              'Versandkosten',
            ],
          ),
          krit(
            'Gewährleistung, Erfüllungsort und Gerichtsstand',
            stichwoerter: [
              'Gewährleistung',
              'Erfüllungsort',
              'Gerichtsstand',
              'Eigentumsvorbehalt',
            ],
          ),
        ],
        loesung:
            'Kaufgegenstand (Art und Ausstattung der Notebooks), Menge, Preis, Zahlungsbedingungen, Lieferbedingungen und Liefertermin; außerdem zum Beispiel Eigentumsvorbehalt, Gewährleistung, Erfüllungsort und Gerichtsstand.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Gefragt sind Inhalte des Vertrags, nicht die Willenserklärungen Antrag und Annahme.',
        punkte: 3,
      ),
      lueckentext(
        'f-a07-systemhaus-c',
        'ls-verzug',
        scenario:
            'Am 6. März sind die Notebooks noch nicht eingetroffen. Der Distributor nennt als Grund einen Engpass bei seinem Vorlieferanten.',
        prompt:
            'Prüfe, ob sich der Distributor im Lieferungsverzug befindet. Ergänze dazu den Text.',
        text:
            'Die Lieferung ist seit dem 2. März {0}. Weil der Liefertermin nach dem {1} bestimmt ist, ist eine {2} nicht erforderlich. Den Engpass beim Vorlieferanten hat der Distributor zu {3}. Der Distributor befindet sich also im Verzug.',
        luecken: [
          wort(['fällig']),
          wort(['Kalender']),
          wort(['Mahnung']),
          wort(['vertreten']),
        ],
        wortbank: ['Abnahme', 'Nachfrist', 'verjährt', 'Rüge'],
        explanation:
            'Verzug nach § 286 BGB: Fälligkeit, Mahnung oder deren Entbehrlichkeit (hier Kalendertermin, Abs. 2 Nr. 1) und Vertretenmüssen (Abs. 4). Der Verkäufer trägt in der Regel das Beschaffungsrisiko. Die Nachfrist gehört nicht zu den Voraussetzungen des Verzugs, sondern erst zu Rücktritt und Schadensersatz statt der Leistung.',
        punkte: 4,
      ),
      freitext(
        'f-a07-systemhaus-d',
        'ls-verzug',
        prompt:
            'Beschreibe zwei Rechte, die Kessler & Brandt wegen des Lieferungsverzugs gegenüber dem Distributor zustehen.',
        kriterien: [
          krit(
            'Auf der Lieferung bestehen und Ersatz des Verzögerungsschadens verlangen, z. B. Kosten für Leihgeräte',
            punkte: 2,
            stichwoerter: [
              'Lieferung bestehen',
              'Verzögerungsschaden',
              'Verzugsschaden',
              'Leihgeräte',
              'Erfüllung',
            ],
          ),
          krit(
            'Angemessene Nachfrist setzen und nach erfolglosem Ablauf vom Vertrag zurücktreten',
            punkte: 2,
            stichwoerter: ['Rücktritt', 'zurücktreten', 'Nachfrist'],
          ),
          krit(
            'Nach erfolgloser Nachfrist Schadensersatz statt der Leistung verlangen, z. B. Mehrkosten eines Deckungskaufs',
            punkte: 2,
            stichwoerter: [
              'Schadensersatz statt',
              'Deckungskauf',
              'Mehrkosten',
              'Ersatzkauf',
            ],
          ),
        ],
        loesung:
            'Kessler & Brandt kann weiter Lieferung verlangen und zusätzlich den Verzögerungsschaden ersetzt verlangen, etwa die Miete für Leihgeräte. Alternativ kann das Systemhaus eine angemessene Nachfrist setzen und nach deren erfolglosem Ablauf vom Vertrag zurücktreten und Schadensersatz statt der Leistung verlangen, etwa die Mehrkosten, wenn die Notebooks teurer bei einem anderen Händler gekauft werden müssen.',
        explanation:
            'Je beschriebenes Recht 2 Punkte, höchstens 4 Punkte. Ohne Nachfrist bleibt der Vertrag bestehen; erst die erfolglose Nachfrist öffnet den Weg zu Rücktritt und Schadensersatz statt der Leistung.',
        punkte: 4,
      ),
      rechnen(
        'f-a07-systemhaus-e',
        'ls-verzug',
        scenario:
            'Damit die Kanzlei pünktlich starten kann, mietet Kessler & Brandt 18 Leihgeräte zu 9 € je Gerät und Tag. Die bestellten Notebooks treffen 12 Tage nach dem Start der Miete ein.',
        prompt:
            'Berechne den Verzögerungsschaden, den Kessler & Brandt vom Distributor ersetzt verlangen kann.',
        answer: 1944,
        unit: '€',
        explanation:
            'Mietkosten je Tag: 18 × 9 € = 162 €. Für 12 Tage: 162 € × 12 = 1.944 €. Der Verzögerungsschaden ist ohne Nachfrist ersatzfähig, weil der Distributor in Verzug ist (§§ 280, 286 BGB).',
        punkte: 3,
      ),
      tabelle(
        'f-a07-systemhaus-f',
        'sla-inhalte',
        scenario:
            'Für den laufenden Betrieb schließt die Kanzlei mit Kessler & Brandt einen Wartungsvertrag: Servicezeit Montag bis Freitag von 8 bis 18 Uhr, Verfügbarkeit des Dateiservers 99 % der Servicezeit je Monat. Im ersten Monat mit 21 Arbeitstagen fällt der Server innerhalb der Servicezeit insgesamt 4,2 Stunden aus.',
        prompt: 'Ermittle die Kennzahlen für diesen Monat.',
        zeilen: [
          ['Kennzahl', 'Wert'],
          [
            'Servicezeit im Monat (in Stunden)',
            zahl(210, einheit: 'h', rationale: '21 Tage × 10 h'),
          ],
          [
            'Höchstens zulässiger Ausfall (in Minuten)',
            zahl(126, einheit: 'min', rationale: '210 h × 0,01 = 2,1 h'),
          ],
          [
            'Erreichte Verfügbarkeit (in Prozent)',
            zahl(98, einheit: '%', rationale: '(210 − 4,2) / 210'),
          ],
          [
            'SLA eingehalten?',
            wahl('nein', [
              'ja',
              'nicht feststellbar',
            ], '98 % liegt unter den zugesagten 99 %.'),
          ],
        ],
        explanation:
            'Servicezeit: 21 × 10 h = 210 h. Zulässiger Ausfall: 210 h × 1 % = 2,1 h = 126 min. Erreicht: (210 h − 4,2 h) / 210 h = 205,8 / 210 = 0,98 = 98 %. Das SLA ist verfehlt - der Ausfall war doppelt so lang wie erlaubt.',
        punkte: 4,
      ),
      freitext(
        'f-a07-systemhaus-g',
        'cm-widerstand',
        scenario:
            'Zur Vorbereitung der Einführung der digitalen Akte liest die Kanzleileitung einen englischen Fachbeitrag.',
        code:
            'Employees rarely resist new software itself. What they\n'
            'resist is the uncertainty that comes with it. Some are\n'
            'afraid of losing their job when tasks are automated.\n'
            'Others worry that they will not be able to handle the\n'
            'new tool. Many simply do not see why a routine that has\n'
            'worked for years should be changed, and some suspect\n'
            'that the system will be used to monitor their work.',
        prompt:
            'Benenne drei Gründe für Widerstand gegen neue Software, die der Text anführt.',
        kriterien: [
          krit(
            'Angst, den Arbeitsplatz durch Automatisierung zu verlieren',
            stichwoerter: ['Arbeitsplatz', 'Job', 'Stelle', 'Automatisierung'],
          ),
          krit(
            'Sorge, das neue Werkzeug nicht bedienen zu können',
            stichwoerter: [
              'nicht bedienen',
              'überfordert',
              'Überforderung',
              'nicht beherrschen',
              'nicht können',
            ],
          ),
          krit(
            'Fehlende Einsicht, warum Bewährtes geändert werden soll',
            stichwoerter: [
              'Bewährtes',
              'Routine',
              'Gewohnheit',
              'nicht einsehen',
              'Einsicht',
            ],
          ),
          krit(
            'Verdacht, das System diene der Überwachung der Arbeit',
            stichwoerter: ['Überwachung', 'Kontrolle', 'überwachen'],
          ),
          krit(
            'Allgemeine Unsicherheit durch die Veränderung',
            stichwoerter: ['Unsicherheit', 'Ungewissheit', 'unsicher'],
          ),
        ],
        loesung:
            'Der Text nennt: Angst vor dem Verlust des Arbeitsplatzes durch Automatisierung, Sorge, das neue Werkzeug nicht zu beherrschen, fehlende Einsicht, warum ein bewährter Ablauf geändert werden soll, und den Verdacht, das System werde zur Überwachung der Arbeit genutzt.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Gewertet wird nur, was im Text steht; geantwortet wird auf Deutsch und sinngemäß, nicht wörtlich übersetzt.',
        punkte: 3,
        tags: ['englisch'],
      ),
      freitext(
        'f-a07-systemhaus-h',
        'cm-lewin',
        scenario:
            'Die Kanzlei überlegt, Papierakte und digitale Akte drei Monate lang parallel zu führen, statt zum Umzugstermin sofort umzustellen.',
        prompt:
            'Beschreibe einen Nachteil des Parallelbetriebs gegenüber der Sofortumstellung.',
        kriterien: [
          krit(
            'Doppelte Arbeit: Jeder Vorgang muss in beiden Systemen gepflegt werden, das belastet die Beschäftigten',
            punkte: 2,
            stichwoerter: [
              'doppelt',
              'Doppelarbeit',
              'Mehraufwand',
              'Mehrarbeit',
              'Belastung',
            ],
          ),
          krit(
            'Höhere Kosten, weil beide Systeme weiter betrieben werden',
            punkte: 2,
            stichwoerter: ['Kosten', 'teurer', 'beide Systeme'],
          ),
          krit(
            'Abweichende Datenstände und Festhalten am Alten: Die Beschäftigten arbeiten weiter mit der Papierakte',
            punkte: 2,
            stichwoerter: [
              'Datenstände',
              'inkonsistent',
              'Abweichungen',
              'am Alten festhalten',
              'alte Gewohnheiten',
            ],
          ),
        ],
        loesung:
            'Beim Parallelbetrieb muss jeder Vorgang sowohl in der Papierakte als auch in der digitalen Akte gepflegt werden. Das bedeutet doppelte Arbeit und höhere Kosten und kann zu abweichenden Datenständen führen. Außerdem bleiben die Beschäftigten leichter bei der gewohnten Papierakte.',
        explanation:
            '2 Punkte für einen beschriebenen Nachteil (nennen und kurz ausführen). Der Vorteil des Parallelbetriebs - die Sicherheit durch den Rückfall auf das alte Verfahren - war nicht gefragt.',
        punkte: 2,
      ),
    ],
  ),

  // ---------------------------------------------------------------- Handel
  fall(
    'f-a07-handel',
    firma: 'handel',
    bereich: 'a07',
    titel: 'Kassensysteme für Göttingen: Mangel, Zahlungsverzug, Akzeptanz',
    situation:
        'Für die neue Filiale in Göttingen hat die Grünwerk Gartenbedarf GmbH bei einem Fachhändler sechs Kassensysteme mit Handscanner gekauft. Bei der Anlieferung stellt die IT-Abteilung fest, dass zwei Scanner keine Barcodes lesen. Das neue Kassensystem soll später auch in den drei bestehenden Filialen die alten Kassen ablösen. Du unterstützt die IT-Abteilung bei der Abwicklung.',
    teile: [
      reihenfolge(
        'f-a07-handel-a',
        'ls-maengel',
        prompt:
            'Bringe das Vorgehen der Grünwerk GmbH gegenüber dem Fachhändler in die richtige Reihenfolge.',
        items: [
          'Kassensysteme bei der Anlieferung unverzüglich prüfen',
          'Mangel dem Fachhändler unverzüglich anzeigen (rügen)',
          'Nacherfüllung verlangen und eine angemessene Frist setzen',
          'Nach erfolgloser Frist Minderung oder Rücktritt erklären',
        ],
        explanation:
            'Unter Kaufleuten muss die Ware unverzüglich geprüft und ein Mangel unverzüglich gerügt werden (§ 377 HGB), sonst gilt sie als genehmigt. Danach hat die Nacherfüllung Vorrang; erst nach erfolgloser Frist kommen Minderung oder Rücktritt in Betracht.',
        punkte: 3,
      ),
      freitext(
        'f-a07-handel-b',
        'ls-maengel',
        prompt:
            'Nenne die beiden Arten der Nacherfüllung und gib an, wer beim Kaufvertrag zwischen ihnen wählt.',
        kriterien: [
          krit(
            'Nachbesserung (Beseitigung des Mangels, Reparatur)',
            stichwoerter: [
              'Nachbesserung',
              'Reparatur',
              'reparieren',
              'Beseitigung',
            ],
          ),
          krit(
            'Ersatzlieferung (Lieferung einer mangelfreien Sache)',
            stichwoerter: [
              'Ersatzlieferung',
              'Neulieferung',
              'Austausch',
              'mangelfreie Sache',
            ],
          ),
          krit(
            'Die Wahl hat der Käufer',
            stichwoerter: ['Käufer', 'Grünwerk', 'Kunde wählt'],
          ),
        ],
        loesung:
            'Nacherfüllung bedeutet Nachbesserung (der Händler repariert die Scanner) oder Ersatzlieferung (er liefert mangelfreie Scanner). Beim Kaufvertrag wählt grundsätzlich der Käufer, hier also die Grünwerk GmbH (§ 439 Abs. 1 BGB).',
        explanation:
            'Je Angabe 1 Punkt. Der Verkäufer darf die gewählte Art nur verweigern, wenn sie unverhältnismäßig teuer ist. Beim Werkvertrag wählt dagegen der Unternehmer.',
        punkte: 3,
      ),
      lueckentext(
        'f-a07-handel-c',
        'ls-maengel',
        scenario:
            'Der Fachhändler kann die beiden Scanner auch im zweiten Versuch nicht instand setzen. Grünwerk behält die Kassen und mindert den Kaufpreis. Je Kassensystem wurden 1.500 € gezahlt. Ohne Mangel ist ein System 1.600 € wert, mit dem Mangel 1.200 €.',
        prompt:
            'Berechne die Minderung für die beiden mangelhaften Kassensysteme.',
        text:
            'Wertverhältnis (mit Mangel / ohne Mangel): {0}\n'
            'Geminderter Preis je Kassensystem: {1} €\n'
            'Minderung je Kassensystem: {2} €\n'
            'Minderung für beide Systeme: {3} €',
        luecken: [
          zahl(0.75, rationale: '1.200 / 1.600'),
          zahl(1125, rationale: '1.500 € × 0,75'),
          zahl(375, rationale: '1.500 € − 1.125 €'),
          zahl(750, rationale: '2 × 375 €'),
        ],
        mono: true,
        explanation:
            'Wertverhältnis: 1.200 / 1.600 = 0,75. Geminderter Preis: 1.500 € × 0,75 = 1.125 €. Minderung je System: 1.500 € − 1.125 € = 375 €, für zwei Systeme 750 € (§ 441 Abs. 3 BGB). Die bloße Wertdifferenz von 400 € wäre falsch.',
        punkte: 4,
      ),
      freitext(
        'f-a07-handel-d',
        'vt-arten',
        scenario:
            'Ein Softwarehaus soll eine Schnittstelle zwischen dem Kassensystem und dem Webshop programmieren. Es bietet einen Vertrag „nach Aufwand“ oder einen Vertrag zum Festpreis mit Abnahme an.',
        prompt:
            'Begründe, ob für Grünwerk ein Dienstvertrag oder ein Werkvertrag geeigneter ist.',
        kriterien: [
          krit(
            'Empfehlung: Werkvertrag',
            stichwoerter: [
              'Werkvertrag',
              'Werksvertrag',
              'Festpreis mit Abnahme',
            ],
          ),
          krit(
            'Begründung: Beim Werkvertrag wird ein Erfolg (funktionierende Schnittstelle) geschuldet, beim Dienstvertrag nur die Tätigkeit',
            stichwoerter: [
              'Erfolg',
              'Ergebnis',
              'funktionierend',
              'Abnahme',
              'Gewährleistung',
              'nur Tätigkeit',
            ],
          ),
        ],
        loesung:
            'Geeigneter ist der Werkvertrag: Das Softwarehaus schuldet dann eine funktionierende Schnittstelle, also einen Erfolg. Vergütung wird erst mit der Abnahme fällig, und bei Fehlern hat Grünwerk Mängelrechte. Beim Dienstvertrag wäre nur die Tätigkeit geschuldet und jede Stunde zu bezahlen, auch wenn die Schnittstelle nicht funktioniert.',
        explanation:
            '1 Punkt für die Empfehlung, 1 Punkt für die Begründung über den geschuldeten Erfolg.',
        punkte: 2,
      ),
      tabelle(
        'f-a07-handel-e',
        'ls-verzug',
        scenario:
            'Ein Gartenbaubetrieb (Unternehmer) hat bei Grünwerk Ware für 5.840 € bezogen und zahlt 45 Tage nach Eintritt des Verzugs. Nimm einen Basiszinssatz von 2 % an und rechne mit 365 Tagen im Jahr.',
        prompt:
            'Berechne die Ansprüche der Grünwerk GmbH aus dem Zahlungsverzug.',
        zeilen: [
          ['Größe', 'Wert'],
          [
            'Verzugszinssatz (in Prozent)',
            zahl(11, einheit: '%', rationale: '2 % + 9 Prozentpunkte'),
          ],
          [
            'Verzugszinsen für 45 Tage',
            zahl(
              79.2,
              toleranz: 0.01,
              einheit: '€',
              rationale: '5.840 € × 0,11 × 45 / 365',
            ),
          ],
          [
            'Verzugspauschale',
            zahl(40, einheit: '€', rationale: '§ 288 Abs. 5 BGB'),
          ],
          [
            'Zinsen und Pauschale zusammen',
            zahl(
              119.2,
              toleranz: 0.01,
              einheit: '€',
              rationale: '79,20 € + 40 €',
            ),
          ],
        ],
        explanation:
            'Kein Verbraucher beteiligt: 2 % + 9 Prozentpunkte = 11 % (§ 288 Abs. 2 BGB). Zinsen: 5.840 € × 0,11 = 642,40 € im Jahr; × 45 / 365 = 79,20 €. Dazu die Pauschale von 40 €: zusammen 119,20 €.',
        punkte: 4,
      ),
      freitext(
        'f-a07-handel-f',
        'cm-widerstand',
        scenario:
            'In den drei bestehenden Filialen arbeitet das Verkaufspersonal seit zwölf Jahren mit den alten Kassen. Die Ankündigung des neuen Systems stößt auf Skepsis.',
        prompt:
            'Nenne drei Bedenken, die das Verkaufspersonal gegen das neue Kassensystem haben könnte.',
        kriterien: [
          krit(
            'Sorge, die neue Kasse nicht sicher bedienen zu können',
            stichwoerter: [
              'bedienen',
              'Überforderung',
              'überfordert',
              'Unsicherheit',
              'Fehler machen',
            ],
          ),
          krit(
            'Längere Wartezeiten und Stress an der Kasse in der Umstellungsphase',
            stichwoerter: ['Wartezeit', 'Stress', 'Schlangen', 'langsamer'],
          ),
          krit(
            'Angst vor Überwachung und Leistungskontrolle',
            stichwoerter: ['Überwachung', 'Kontrolle', 'Leistungskontrolle'],
          ),
          krit(
            'Angst um den Arbeitsplatz',
            stichwoerter: ['Arbeitsplatz', 'Stelle', 'Personalabbau'],
          ),
          krit(
            'Festhalten am Gewohnten: Die alte Kasse funktioniert doch',
            stichwoerter: [
              'Gewohnheit',
              'gewohnt',
              'bewährt',
              'funktioniert doch',
            ],
          ),
          krit(
            'Mehraufwand durch Schulungen und Einarbeitung',
            stichwoerter: ['Mehraufwand', 'Schulung', 'Einarbeitung', 'Zeit'],
          ),
        ],
        loesung:
            'Zum Beispiel: Sorge, die neue Kasse nicht sicher bedienen zu können; Stress und längere Wartezeiten für Kunden in der Umstellungsphase; Angst vor Leistungskontrolle; Angst um den Arbeitsplatz; Festhalten am Gewohnten; zusätzlicher Aufwand für Schulung und Einarbeitung.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Andere nachvollziehbare Bedenken werden ebenfalls gewertet.',
        punkte: 3,
      ),
      freitext(
        'f-a07-handel-g',
        'cm-widerstand',
        prompt:
            'Beschreibe zwei Maßnahmen, mit denen die IT-Abteilung diesen Bedenken begegnen kann.',
        kriterien: [
          krit(
            'Frühzeitig informieren: Gründe, Zeitplan und Nutzen des neuen Systems erklären',
            punkte: 2,
            stichwoerter: [
              'informieren',
              'kommunizieren',
              'erklären',
              'Nutzen',
              'transparent',
            ],
          ),
          krit(
            'Schulungen an der neuen Kasse und klare Kurzanleitungen',
            punkte: 2,
            stichwoerter: [
              'Schulung',
              'schulen',
              'Training',
              'Anleitung',
              'üben',
            ],
          ),
          krit(
            'Erfahrene Verkäuferinnen und Verkäufer als Key-User bzw. Multiplikatoren einsetzen',
            punkte: 2,
            stichwoerter: ['Key-User', 'Multiplikator', 'Ansprechpartner'],
          ),
          krit(
            'Personal einbeziehen: Wünsche abfragen, Rückmeldungen aus Göttingen berücksichtigen',
            punkte: 2,
            stichwoerter: [
              'einbeziehen',
              'beteiligen',
              'Feedback',
              'Rückmeldung',
            ],
          ),
          krit(
            'In der Startphase vor Ort begleiten und Ansprechpartner bereitstellen',
            punkte: 2,
            stichwoerter: ['begleiten', 'vor Ort', 'Unterstützung', 'Hotline'],
          ),
        ],
        loesung:
            'Erstens früh und offen informieren, warum die alten Kassen abgelöst werden und welche Vorteile das neue System im Alltag bringt. Zweitens das Personal vor dem Start an der neuen Kasse schulen und in den ersten Tagen vor Ort begleiten. Weitere Möglichkeiten: erfahrene Kolleginnen und Kollegen als Key-User einsetzen, Rückmeldungen aus der Filiale Göttingen einbeziehen.',
        explanation:
            'Je beschriebene Maßnahme 2 Punkte, höchstens 4 Punkte. Die Maßnahmen sollen zu den Bedenken passen: Information gegen Unwissen, Schulung gegen Unsicherheit, Beteiligung gegen Ablehnung.',
        punkte: 4,
      ),
      freitext(
        'f-a07-handel-h',
        'cm-lewin',
        scenario:
            'Das neue Kassensystem läuft zunächst nur in der Filiale Göttingen. Die drei anderen Filialen folgen erst ein Vierteljahr später.',
        prompt: 'Erläutere einen Vorteil dieses Vorgehens (Pilotbetrieb).',
        kriterien: [
          krit(
            'Fehler und Störungen treffen nur eine Filiale; das Risiko für das Gesamtunternehmen ist begrenzt',
            punkte: 2,
            stichwoerter: [
              'Risiko',
              'nur eine Filiale',
              'begrenzt',
              'Fehler',
              'Störungen',
            ],
          ),
          krit(
            'Erfahrungen aus dem Piloten fließen in Schulung und Einführung der übrigen Filialen ein',
            punkte: 2,
            stichwoerter: [
              'Erfahrungen',
              'lernen',
              'verbessern',
              'Erkenntnisse',
            ],
          ),
          krit(
            'Positive Erfahrungen der Pilotfiliale erhöhen die Akzeptanz in den anderen Filialen',
            punkte: 2,
            stichwoerter: ['Akzeptanz', 'überzeugen', 'Vorbild', 'Erfolge'],
          ),
        ],
        loesung:
            'Im Pilotbetrieb treffen Fehler und Kinderkrankheiten nur die Filiale Göttingen; die anderen Filialen verkaufen ungestört weiter. Die Erfahrungen aus dem Piloten können genutzt werden, um das System und die Schulungen zu verbessern, bevor die übrigen Filialen umgestellt werden.',
        explanation:
            '2 Punkte für einen erläuterten Vorteil (Aussage plus Folge). Nachteil des Piloten: Die übrigen Filialen profitieren erst später, und zeitweise sind zwei Systeme zu betreuen.',
        punkte: 2,
      ),
    ],
  ),

  // --------------------------------------------------------------- Agentur
  fall(
    'f-a07-agentur',
    firma: 'agentur',
    bereich: 'a07',
    titel: 'Ticketsystem aus der Cloud: Verträge, SLA und Akzeptanz',
    situation:
        'Die Pixelhafen Medien GmbH löst das gemeinsame E-Mail-Postfach für Kundenanfragen durch ein Ticketsystem ab, das ein Anbieter als Cloud-Dienst für alle 30 Mitarbeitenden bereitstellt. Ein Softwarehaus programmiert dazu eine Schnittstelle zur Zeiterfassung der Agentur. Einige Projektleiter möchten Kundenanfragen lieber weiter per E-Mail bearbeiten. Du unterstützt die beiden Administratoren bei der Einführung.',
    teile: [
      tabelle(
        'f-a07-agentur-a',
        'vt-arten',
        prompt:
            'Ordne den drei Vereinbarungen die Vertragsart und die Vorschrift des BGB zu.',
        zeilen: [
          ['Vereinbarung', 'Vertragsart', 'BGB'],
          [
            'Nutzung des Ticketsystems für 12 € je Nutzer und Monat',
            wahl('Mietvertrag', [
              'Kaufvertrag',
              'Werkvertrag',
              'Dienstvertrag',
            ]),
            wahl('§ 535', ['§ 433', '§ 611', '§ 631']),
          ],
          [
            'Programmierung der Schnittstelle zum Festpreis von 6.500 €',
            wahl('Werkvertrag', [
              'Dienstvertrag',
              'Mietvertrag',
              'Kaufvertrag',
            ]),
            wahl('§ 631', ['§ 433', '§ 535', '§ 611']),
          ],
          [
            'Ein Berater begleitet die Einführung, abgerechnet nach Stunden',
            wahl('Dienstvertrag', [
              'Werkvertrag',
              'Mietvertrag',
              'Kaufvertrag',
            ]),
            wahl('§ 611', ['§ 631', '§ 535', '§ 433']),
          ],
        ],
        explanation:
            'Software as a Service ist Gebrauchsüberlassung auf Zeit gegen Entgelt, also Miete (§ 535 BGB). Die Schnittstelle zum Festpreis ist ein geschuldeter Erfolg: Werkvertrag (§ 631 BGB). Die Beratung nach Stunden ist bloße Tätigkeit: Dienstvertrag (§ 611 BGB).',
        punkte: 6,
      ),
      lueckentext(
        'f-a07-agentur-b',
        'sla-inhalte',
        scenario:
            'Der Vertrag mit dem Cloud-Anbieter enthält den folgenden Auszug. Im ersten Monat (30 Tage) war das Ticketsystem zweimal nicht erreichbar: einmal 30 Minuten und einmal 56,4 Minuten.',
        code:
            'SERVICE LEVELS (excerpt)\n'
            'The service is provided 24 hours a day, 7 days a week.\n'
            'Availability: 99.9 % per calendar month.\n'
            'Service credit: for each started 0.1 percentage point\n'
            'below the agreed availability, the customer receives\n'
            'a credit of 10 % of the monthly fee.',
        prompt:
            'Werte den Auszug aus und berechne die Gutschrift. Die Monatsgebühr beträgt 30 × 12 € = 360 €.',
        text:
            'Minuten des Monats: {0}\n'
            'Zulässiger Ausfall: {1} min\n'
            'Erreichte Verfügbarkeit: {2} %\n'
            'Gutschrift: {3} €',
        luecken: [
          zahl(43200, rationale: '30 × 24 × 60'),
          zahl(43.2, toleranz: 0.01, rationale: '43.200 min × 0,001'),
          zahl(99.8, toleranz: 0.01, rationale: '(43.200 − 86,4) / 43.200'),
          zahl(36, rationale: '0,1 Prozentpunkte darunter: 10 % von 360 €'),
        ],
        mono: true,
        explanation:
            'Monat: 30 × 24 × 60 = 43.200 min. Zulässig: 43.200 × 0,1 % = 43,2 min. Ausfall: 30 + 56,4 = 86,4 min. Verfügbarkeit: (43.200 − 86,4) / 43.200 = 0,998 = 99,8 %. Das sind 0,1 Prozentpunkte unter dem Ziel, also 10 % von 360 € = 36 € Gutschrift.',
        punkte: 4,
        tags: ['englisch'],
      ),
      freitext(
        'f-a07-agentur-c',
        'sla-inhalte',
        prompt:
            'Nenne drei weitere Inhalte, die neben der Verfügbarkeit im Service Level Agreement geregelt sein sollten.',
        kriterien: [
          krit(
            'Reaktionszeit bei Störungen',
            stichwoerter: ['Reaktionszeit', 'Antwortzeit', 'Rückmeldung'],
          ),
          krit(
            'Lösungs- bzw. Wiederherstellungszeit',
            stichwoerter: [
              'Lösungszeit',
              'Wiederherstellungszeit',
              'Behebungszeit',
            ],
          ),
          krit(
            'Servicezeiten des Supports und Erreichbarkeit',
            stichwoerter: [
              'Servicezeit',
              'Supportzeit',
              'Erreichbarkeit',
              'Hotline',
            ],
          ),
          krit(
            'Prioritäten und Eskalationswege',
            stichwoerter: ['Priorität', 'Eskalation', 'Störungsklassen'],
          ),
          krit(
            'Wartungsfenster',
            stichwoerter: ['Wartungsfenster', 'Wartung', 'Wartungszeiten'],
          ),
          krit(
            'Reporting und Messverfahren',
            stichwoerter: ['Reporting', 'Bericht', 'Messung'],
          ),
          krit(
            'Datensicherung und Wiederherstellung der Daten',
            stichwoerter: [
              'Datensicherung',
              'Backup',
              'Wiederherstellung der Daten',
            ],
          ),
        ],
        loesung:
            'Zum Beispiel: Reaktionszeit und Lösungszeit je Priorität, Servicezeiten des Supports, Eskalationswege, Wartungsfenster, Reporting der Kennzahlen, Regelungen zur Datensicherung.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Die Verfügbarkeit und die Gutschrift sind bereits geregelt und zählen deshalb nicht.',
        punkte: 3,
      ),
      freitext(
        'f-a07-agentur-d',
        'ls-abnahme',
        scenario:
            'Das Softwarehaus meldet die Schnittstelle als fertig. Die Administratoren testen sie und wollen sie abnehmen.',
        prompt:
            'Nenne drei Rechtsfolgen, die die Abnahme der Schnittstelle auslöst.',
        kriterien: [
          krit(
            'Die Vergütung wird fällig',
            stichwoerter: ['Vergütung', 'fällig', 'Zahlung', 'Werklohn'],
          ),
          krit(
            'Die Verjährungsfrist für Mängelansprüche beginnt',
            stichwoerter: [
              'Verjährung',
              'Gewährleistungsfrist',
              'Frist beginnt',
            ],
          ),
          krit(
            'Die Gefahr geht auf den Besteller über',
            stichwoerter: ['Gefahrübergang', 'Gefahr', 'Risiko geht über'],
          ),
          krit(
            'Die Beweislast für Mängel liegt nun beim Besteller',
            stichwoerter: ['Beweislast', 'beweisen', 'Nachweis'],
          ),
          krit(
            'Rechte wegen bekannter, nicht vorbehaltener Mängel gehen verloren',
            stichwoerter: ['Vorbehalt', 'bekannte Mängel', 'Rechte verlieren'],
          ),
        ],
        loesung:
            'Mit der Abnahme wird die Vergütung fällig, die Verjährungsfrist für Mängelansprüche beginnt, die Gefahr geht auf die Agentur über und die Beweislast kehrt sich um: Künftig muss die Agentur beweisen, dass ein Mangel vorliegt. Bekannte Mängel muss sie sich im Protokoll vorbehalten.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Deshalb gehören festgestellte Mängel mit Frist in das Abnahmeprotokoll.',
        punkte: 3,
      ),
      markieren(
        'f-a07-agentur-e',
        'cm-widerstand',
        scenario:
            'In der Teamrunde stellt die Geschäftsführung das Ticketsystem vor. Du notierst die Reaktionen.',
        prompt:
            'Markiere alle Reaktionen, die auf Widerstand gegen die Einführung hindeuten.',
        zeilen: [
          ja(
            '„Meine Kunden schreiben mir direkt, das hat immer funktioniert.“',
            'Offener Widerspruch gegen die Veränderung.',
          ),
          nein(
            '„Wie sehe ich im Ticketsystem, welche Anfragen zu meinem Projekt gehören?“',
            'Sachliche Frage zur Nutzung - Interesse, kein Widerstand.',
          ),
          ja(
            'Ein Projektleiter wechselt jedes Mal das Thema, sobald es um den Starttermin geht.',
            'Ausweichen - verbal und passiv.',
          ),
          ja(
            'Auf dem Flur heißt es, das System diene nur dazu, Antwortzeiten zu überwachen.',
            'Gerüchte und Unruhe - Aufregung.',
          ),
          nein(
            '„Ich würde gern in der Testphase mitmachen.“',
            'Bereitschaft zur Beteiligung.',
          ),
          ja(
            'Zwei Kolleginnen sagen nichts und erscheinen nicht zur angesetzten Schulung.',
            'Rückzug und Lustlosigkeit - verdeckter Widerstand.',
          ),
        ],
        explanation:
            'Widerstand zeigt sich als Widerspruch, Ausweichen, Aufregung oder Lustlosigkeit. Sachliche Fragen und die Bereitschaft zum Testen sind Zeichen von Beteiligung. Vier der sechs Reaktionen deuten auf Widerstand hin.',
        punkte: 3,
      ),
      freitext(
        'f-a07-agentur-f',
        'cm-widerstand',
        prompt:
            'Beschreibe zwei Maßnahmen, mit denen die Agentur die Akzeptanz des Ticketsystems fördern kann.',
        kriterien: [
          krit(
            'Früh informieren: zeigen, wie viele Anfragen im Postfach untergehen und was das Ticketsystem verbessert',
            punkte: 2,
            stichwoerter: [
              'informieren',
              'kommunizieren',
              'erklären',
              'Nutzen',
              'transparent',
            ],
          ),
          krit(
            'Projektleiter beteiligen, z. B. Kategorien und Abläufe gemeinsam festlegen',
            punkte: 2,
            stichwoerter: [
              'beteiligen',
              'einbeziehen',
              'mitgestalten',
              'gemeinsam',
            ],
          ),
          krit(
            'Schulungen und Kurzanleitungen anbieten',
            punkte: 2,
            stichwoerter: ['Schulung', 'schulen', 'Training', 'Anleitung'],
          ),
          krit(
            'Key-User benennen, die in der Startphase Fragen beantworten',
            punkte: 2,
            stichwoerter: ['Key-User', 'Multiplikator', 'Ansprechpartner'],
          ),
          krit(
            'Regeln zur Auswertung festlegen: keine individuelle Leistungskontrolle',
            punkte: 2,
            stichwoerter: [
              'Leistungskontrolle',
              'Überwachung',
              'Regeln',
              'zusichern',
            ],
          ),
          krit(
            'Altes Postfach nach der Umstellung abschalten und erste Erfolge sichtbar machen',
            punkte: 2,
            stichwoerter: ['abschalten', 'Erfolge', 'Kennzahlen'],
          ),
        ],
        loesung:
            'Erstens die Projektleiter beteiligen: Kategorien, Zuständigkeiten und Abläufe im Ticketsystem werden gemeinsam festgelegt, damit das System zu ihrer Arbeit passt. Zweitens schulen und begleiten: kurze Schulungen, eine Kurzanleitung und Key-User als Ansprechpartner. Weitere Möglichkeiten: den Nutzen mit Zahlen belegen, zusichern, dass keine individuelle Leistungskontrolle stattfindet.',
        explanation:
            'Je beschriebene Maßnahme 2 Punkte, höchstens 4 Punkte. Druck und Anordnung wären das letzte Mittel und erzeugen oft nur Scheinanpassung.',
        punkte: 4,
      ),
      freitext(
        'f-a07-agentur-g',
        'cm-widerstand',
        prompt:
            'Erläutere einen Vorteil, den das Ticketsystem den skeptischen Projektleitern im Arbeitsalltag bringt.',
        kriterien: [
          krit(
            'Keine Anfrage geht verloren: Jede Anfrage hat einen Status und eine zuständige Person',
            punkte: 2,
            stichwoerter: [
              'verloren',
              'Status',
              'Zuständigkeit',
              'nachverfolgen',
            ],
          ),
          krit(
            'Vertretung wird einfacher: Kolleginnen und Kollegen sehen den gesamten Verlauf',
            punkte: 2,
            stichwoerter: ['Vertretung', 'Verlauf', 'Historie', 'Urlaub'],
          ),
          krit(
            'Weniger Rückfragen und Suchaufwand, mehr Zeit für die Projektarbeit',
            punkte: 2,
            stichwoerter: [
              'Rückfragen',
              'Suchen',
              'Zeit',
              'Entlastung',
              'Überblick',
            ],
          ),
        ],
        loesung:
            'Im Ticketsystem geht keine Kundenanfrage mehr unter: Jede Anfrage hat eine zuständige Person und einen sichtbaren Status. Das entlastet die Projektleiter, weil sie nicht mehr im Postfach suchen müssen und bei Urlaub oder Krankheit die Vertretung den gesamten Verlauf sieht.',
        explanation:
            '2 Punkte für einen erläuterten Vorteil aus Sicht der Betroffenen (Aussage plus Folge). Vorteile nur für das Unternehmen, etwa Auswertungen für die Geschäftsführung, überzeugen Skeptiker kaum.',
        punkte: 2,
      ),
    ],
  ),

  // -------------------------------------------------------------- Logistik
  fall(
    'f-a07-logistik',
    firma: 'logistik',
    bereich: 'a07',
    titel: 'Handscanner für die neue Halle: Lieferverzug, Support, Einführung',
    situation:
        'Für die neue Lagerhalle hat die Elbtal Logistik AG bei einem Händler 60 Handscanner zu je 380 € bestellt. Im Kaufvertrag ist die Lieferung am 15. April vereinbart; am 4. Mai soll die Halle in Betrieb gehen. Am 20. April sind die Scanner noch nicht geliefert, der Händler vertröstet am Telefon. In der neuen Halle sollen die Scanner die Kommissionierlisten auf Papier ersetzen.',
    teile: [
      freitext(
        'f-a07-logistik-a',
        'ls-verzug',
        prompt:
            'Prüfe, ob sich der Händler am 20. April im Lieferungsverzug befindet. Begründe dein Ergebnis.',
        kriterien: [
          krit(
            'Die Lieferung ist seit dem 15. April fällig und nicht erfolgt',
            stichwoerter: ['fällig', 'Fälligkeit', 'nicht geliefert'],
          ),
          krit(
            'Eine Mahnung ist entbehrlich, weil der Liefertermin nach dem Kalender bestimmt ist',
            punkte: 2,
            stichwoerter: [
              'Kalender',
              'keine Mahnung',
              'ohne Mahnung',
              'Mahnung entbehrlich',
              'fester Termin',
            ],
          ),
          krit(
            'Der Händler hat die Verspätung zu vertreten (Verschulden wird vermutet) - er ist seit dem 16. April in Verzug',
            stichwoerter: [
              'vertreten',
              'Verschulden',
              'in Verzug',
              '16. April',
            ],
          ),
        ],
        loesung:
            'Ja, der Händler ist in Verzug. Die Lieferung war am 15. April fällig und ist nicht erfolgt. Eine Mahnung ist nicht nötig, weil der Termin nach dem Kalender bestimmt ist (§ 286 Abs. 2 Nr. 1 BGB). Dass der Händler die Verspätung nicht zu vertreten hätte, ist nicht ersichtlich; sein Verschulden wird vermutet. Verzug besteht daher seit dem 16. April.',
        explanation:
            '1 Punkt Fälligkeit, 2 Punkte Entbehrlichkeit der Mahnung mit Begründung, 1 Punkt Vertretenmüssen und Ergebnis. Das Vertrösten am Telefon ändert nichts am Verzug.',
        punkte: 4,
      ),
      reihenfolge(
        'f-a07-logistik-b',
        'ls-verzug',
        scenario:
            'Die IT-Abteilung will sich notfalls vom Vertrag lösen und die Scanner woanders beschaffen.',
        prompt: 'Bringe die Schritte in die rechtlich richtige Reihenfolge.',
        items: [
          'Dem Händler eine angemessene Nachfrist zur Lieferung setzen',
          'Die Nachfrist verstreicht, ohne dass geliefert wird',
          'Rücktritt vom Kaufvertrag erklären',
          'Scanner bei einem anderen Händler kaufen und die Mehrkosten als Schadensersatz fordern',
        ],
        explanation:
            'Rücktritt (§ 323 BGB) und Schadensersatz statt der Leistung (§ 281 BGB) setzen grundsätzlich eine erfolglos abgelaufene angemessene Nachfrist voraus. Wer ohne Nachfrist woanders kauft, riskiert, die Scanner doppelt abnehmen und bezahlen zu müssen.',
        punkte: 3,
      ),
      rechnen(
        'f-a07-logistik-c',
        'ls-verzug',
        scenario:
            'Nach erfolgloser Nachfrist kauft Elbtal Logistik die 60 Scanner bei einem anderen Händler zu je 410 €. Für die Expresslieferung fallen zusätzlich 240 € an.',
        prompt:
            'Berechne den Schaden, den Elbtal Logistik vom ersten Händler als Schadensersatz statt der Leistung verlangen kann.',
        answer: 2040,
        unit: '€',
        explanation:
            'Mehrpreis je Scanner: 410 € − 380 € = 30 €. Für 60 Scanner: 60 × 30 € = 1.800 €. Dazu der Expresszuschlag: 1.800 € + 240 € = 2.040 €. Ersetzt werden nur die Mehrkosten, nicht der gesamte Kaufpreis.',
        punkte: 3,
      ),
      tabelle(
        'f-a07-logistik-d',
        'sla-support',
        scenario:
            'Für die Scanner gilt intern ein SLA. Auswirkung hoch = ganze Halle, mittel = eine Schicht oder Abteilung, niedrig = einzelne Person. Dringlichkeit hoch = die Arbeit steht still, mittel = Arbeit eingeschränkt möglich, niedrig = Ersatzgerät vorhanden.',
        table: [
          ['Auswirkung', 'dringend: hoch', 'mittel', 'niedrig'],
          ['hoch', 'P1: 15 min', 'P2: 1 h', 'P3: 4 h'],
          ['mittel', 'P2: 1 h', 'P3: 4 h', 'P4: 8 h'],
          ['niedrig', 'P3: 4 h', 'P4: 8 h', 'P5: 24 h'],
        ],
        prompt:
            'Bestimme für jede Störung die Priorität und die Reaktionszeit laut Matrix.',
        zeilen: [
          ['Störung', 'Priorität', 'Reaktionszeit'],
          [
            'Das WLAN der neuen Halle fällt aus, kein Scanner bucht mehr, die Verladung steht.',
            wahl('P1', ['P2', 'P3', 'P4', 'P5']),
            wahl('15 min', ['1 h', '4 h', '8 h', '24 h']),
          ],
          [
            'Der Scanner eines Kommissionierers ist defekt; im Schichtbüro liegen Ersatzgeräte.',
            wahl('P5', ['P1', 'P2', 'P3', 'P4']),
            wahl('24 h', ['15 min', '1 h', '4 h', '8 h']),
          ],
          [
            'In der Spätschicht synchronisieren alle Scanner nur verzögert; gearbeitet wird langsamer.',
            wahl('P3', ['P1', 'P2', 'P4', 'P5']),
            wahl('4 h', ['15 min', '1 h', '8 h', '24 h']),
          ],
        ],
        explanation:
            'WLAN-Ausfall: ganze Halle (hoch), Arbeit steht still (hoch) = P1, 15 min. Einzelner Scanner mit Ersatzgerät: niedrig/niedrig = P5, 24 h. Verzögerte Synchronisation in einer Schicht: mittel/mittel = P3, 4 h.',
        punkte: 5,
      ),
      freitext(
        'f-a07-logistik-e',
        'cm-lewin',
        scenario:
            'Zur Planung der Inbetriebnahme liegt der IT-Abteilung ein englischer Text vor.',
        code:
            'There is more than one way to put a new system into\n'
            'operation. With a direct cutover, the old system is\n'
            'switched off on a fixed date and everybody starts using\n'
            'the new one at once. In a parallel run, both systems are\n'
            'used side by side for some weeks and the results are\n'
            'compared. A pilot introduces the new system in one\n'
            'department or site first; the lessons learned there are\n'
            'used before it is rolled out to the rest of the company.',
        prompt:
            'Benenne die drei Einführungsstrategien, die der Text beschreibt.',
        kriterien: [
          krit(
            'Sofortumstellung zu einem Stichtag (direct cutover)',
            stichwoerter: [
              'Sofortumstellung',
              'Stichtag',
              'Big Bang',
              'Direktumstellung',
            ],
          ),
          krit(
            'Parallelbetrieb von altem und neuem System (parallel run)',
            stichwoerter: ['Parallelbetrieb', 'parallel', 'nebeneinander'],
          ),
          krit(
            'Pilotbetrieb in einer Abteilung oder an einem Standort (pilot)',
            stichwoerter: [
              'Pilot',
              'Pilotbetrieb',
              'Pilotphase',
              'Testbereich',
            ],
          ),
        ],
        loesung:
            'Der Text beschreibt die Sofortumstellung zu einem Stichtag (direct cutover), den Parallelbetrieb von altem und neuem System (parallel run) und den Pilotbetrieb in einer Abteilung oder an einem Standort, bevor alle umgestellt werden (pilot).',
        explanation:
            'Je Nennung 1 Punkt. Die stufenweise Einführung Modul für Modul ist eine vierte Strategie, steht aber nicht im Text und wird hier nicht gewertet.',
        punkte: 3,
        tags: ['englisch'],
      ),
      freitext(
        'f-a07-logistik-f',
        'cm-lewin',
        prompt:
            'Beschreibe einen Nachteil der Sofortumstellung für den Dreischichtbetrieb im Lager.',
        kriterien: [
          krit(
            'Störungen des neuen Systems treffen den Betrieb sofort und vollständig; ohne Rückfall auf die Papierlisten steht die Kommissionierung',
            punkte: 2,
            stichwoerter: [
              'Störungen',
              'Stillstand',
              'kein Rückfall',
              'Ausfall',
              'Risiko',
            ],
          ),
          krit(
            'Hoher Druck auf die Beschäftigten: Alle Schichten müssen vom ersten Tag an sicher mit den Scannern arbeiten',
            punkte: 2,
            stichwoerter: [
              'Druck',
              'Stress',
              'alle Schichten',
              'Überforderung',
            ],
          ),
        ],
        loesung:
            'Bei der Sofortumstellung gibt es keinen Rückfall auf die Papierlisten. Störungen des neuen Systems treffen den Betrieb daher sofort und in allen drei Schichten - im schlimmsten Fall stehen Kommissionierung und Verladung. Außerdem müssen alle Beschäftigten vom ersten Tag an sicher mit den Scannern umgehen können, was den Druck erhöht.',
        explanation:
            '2 Punkte für einen beschriebenen Nachteil (nennen und auf den Betrieb beziehen). Gefragt war ein Nachteil - Vorteile wie die kurze Umstellungsdauer bringen keine Punkte.',
        punkte: 2,
      ),
      freitext(
        'f-a07-logistik-g',
        'cm-widerstand',
        scenario:
            'Der Betriebsrat berichtet, dass viele Lagerbeschäftigte die Scanner skeptisch sehen.',
        prompt:
            'Nenne drei Gründe für die Vorbehalte der Lagerbeschäftigten gegen die Handscanner.',
        kriterien: [
          krit(
            'Angst vor Überwachung: Die Scanner erfassen, wer wie schnell arbeitet',
            stichwoerter: ['Überwachung', 'Kontrolle', 'Leistungskontrolle'],
          ),
          krit(
            'Angst um den Arbeitsplatz durch die Automatisierung',
            stichwoerter: ['Arbeitsplatz', 'Stelle', 'Personalabbau'],
          ),
          krit(
            'Unsicherheit im Umgang mit der neuen Technik',
            stichwoerter: [
              'Unsicherheit',
              'Überforderung',
              'überfordert',
              'Bedienung',
              'Technik',
            ],
          ),
          krit(
            'Festhalten an den gewohnten Papierlisten',
            stichwoerter: ['Gewohnheit', 'gewohnt', 'bewährt', 'Papierlisten'],
          ),
          krit(
            'Fehlende Information über Gründe und Nutzen',
            stichwoerter: ['Information', 'nicht informiert', 'Nutzen', 'Sinn'],
          ),
          krit(
            'Höherer Zeitdruck und Mehraufwand in der Umstellungsphase',
            stichwoerter: ['Zeitdruck', 'Mehraufwand', 'Mehrarbeit', 'Stress'],
          ),
        ],
        loesung:
            'Angst vor Überwachung und Leistungskontrolle, Angst um den Arbeitsplatz, Unsicherheit im Umgang mit der neuen Technik, Festhalten an den gewohnten Papierlisten, fehlende Information über Gründe und Nutzen, Zeitdruck in der Umstellungsphase.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Weil die Scanner Leistung und Verhalten erfassen können, hat der Betriebsrat ein Mitbestimmungsrecht (§ 87 Abs. 1 Nr. 6 BetrVG).',
        punkte: 3,
      ),
      freitext(
        'f-a07-logistik-h',
        'cm-widerstand',
        prompt:
            'Erläutere eine Maßnahme, mit der die IT-Abteilung die Akzeptanz fördern kann und die den Dreischichtbetrieb berücksichtigt.',
        kriterien: [
          krit(
            'Schulungen in jeder Schicht anbieten, damit alle Beschäftigten während ihrer Arbeitszeit geschult werden',
            punkte: 2,
            stichwoerter: ['Schulung', 'schulen', 'jede Schicht', 'Training'],
          ),
          krit(
            'Je Schicht Key-User benennen, die vor Ort Fragen beantworten',
            punkte: 2,
            stichwoerter: ['Key-User', 'Multiplikator', 'Ansprechpartner'],
          ),
          krit(
            'Alle Schichten informieren und beteiligen, z. B. Infotermine zu jedem Schichtwechsel',
            punkte: 2,
            stichwoerter: [
              'informieren',
              'beteiligen',
              'Schichtwechsel',
              'Infoveranstaltung',
            ],
          ),
          krit(
            'Mit dem Betriebsrat regeln, dass die Scannerdaten nicht zur individuellen Leistungskontrolle dienen',
            punkte: 2,
            stichwoerter: [
              'Betriebsrat',
              'Betriebsvereinbarung',
              'Leistungskontrolle',
            ],
          ),
        ],
        loesung:
            'Die IT-Abteilung schult die Beschäftigten in jeder der drei Schichten während der Arbeitszeit an den Scannern und benennt je Schicht einen Key-User, der in den ersten Wochen als Ansprechpartner vor Ort ist. So wird niemand ausgeschlossen, und Fragen werden auch nachts sofort geklärt.',
        explanation:
            '2 Punkte für eine erläuterte Maßnahme mit Bezug zum Schichtbetrieb. Eine einzige Schulung am Vormittag würde zwei Drittel der Belegschaft nicht erreichen.',
        punkte: 2,
      ),
    ],
  ),
];
