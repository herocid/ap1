import '../builders.dart';

const _versandCode =
    ' 1 funktion versand(wert)\n'
    ' 2   WENN wert < 1 ODER wert > 5000 DANN\n'
    ' 3     RÜCKGABE "Fehler"\n'
    ' 4   ENDE WENN\n'
    ' 5   WENN wert < 50 DANN\n'
    ' 6     RÜCKGABE 4.90\n'
    ' 7   ENDE WENN\n'
    ' 8   WENN wert <= 200 DANN\n'
    ' 9     RÜCKGABE 2.90\n'
    '10   ENDE WENN\n'
    '11   RÜCKGABE 0';

/// Fallaufgaben (je 25 Punkte) zu Bereich 05 für die Prüfungssimulation.
final List<ExamCase> casesA05 = [
  // --------------------------------------------------------------- Agentur
  fall(
    'f-a05-agentur',
    firma: 'agentur',
    bereich: 'a05',
    titel: 'Versandkostenfunktion eines Webshops testen',
    situation:
        'Pixelhafen entwickelt für einen Fahrradhändler einen Webshop. Die Funktion versand(wert) berechnet die Versandkosten aus dem Bestellwert in ganzen Euro. Gültig sind Bestellwerte von 1 € bis 5.000 €: Unter 50 € kostet der Versand 4,90 €, von 50 € bis 199 € 2,90 €, ab 200 € ist er kostenlos. Alle anderen Werte führen zu einer Fehlermeldung. Du sollst die Funktion vor der Übergabe an den Kunden testen.',
    teile: [
      tabelle(
        'f-a05-agentur-a',
        'ts-testfaelle',
        prompt:
            'Vervollständige die Äquivalenzklassen für den Bestellwert: Gib je Klasse an, ob sie gültig ist, und nenne das Soll-Ergebnis. (6 P.)',
        punkte: 6,
        zeilen: [
          ['Bestellwert', 'Klasse', 'Soll-Ergebnis'],
          [
            'kleiner als 1',
            wahl('ungültig', ['gültig', 'nicht testbar']),
            wahl('Fehlermeldung', ['4,90 €', '2,90 €', '0,00 €']),
          ],
          [
            '1 bis 49',
            'gültig',
            wahl('4,90 €', ['2,90 €', '0,00 €', 'Fehlermeldung']),
          ],
          [
            '50 bis 199',
            wahl('gültig', ['ungültig', 'nicht testbar']),
            wahl('2,90 €', ['4,90 €', '0,00 €', 'Fehlermeldung']),
          ],
          [
            '200 bis 5.000',
            'gültig',
            wahl('0,00 €', ['4,90 €', '2,90 €', 'Fehlermeldung']),
          ],
          [
            'größer als 5.000',
            wahl('ungültig', ['gültig', 'nicht testbar']),
            wahl('Fehlermeldung', ['4,90 €', '2,90 €', '0,00 €']),
          ],
        ],
        explanation:
            'Es gibt fünf Klassen: zwei ungültige (unter 1 und über 5.000) mit Fehlermeldung und drei gültige mit jeweils eigenem Ergebnis (4,90 €, 2,90 € und 0,00 €). Aus jeder Klasse genügt ein Repräsentant, etwa -5, 20, 120, 800 und 6.000.',
      ),
      tabelle(
        'f-a05-agentur-b',
        'ts-testfaelle',
        prompt:
            'Ergänze für die Grenzwertanalyse die beiden Testwerte direkt links und rechts jedes Übergangs. (4 P.)',
        punkte: 4,
        zeilen: [
          ['Übergang', 'Wert links', 'Wert rechts'],
          ['ungültig | 1 bis 49', '0', '1'],
          ['1 bis 49 | 50 bis 199', zahl(49), zahl(50)],
          ['50 bis 199 | 200 bis 5.000', zahl(199), zahl(200)],
          ['200 bis 5.000 | ungültig', zahl(5000), zahl(5001)],
        ],
        explanation:
            'Getestet wird der letzte Wert der einen und der erste Wert der nächsten Klasse: 0/1, 49/50, 199/200 und 5.000/5.001. Zusammen sind das acht Grenzwerte.',
      ),
      lueckentext(
        'f-a05-agentur-c',
        'pl-schreibtischtest',
        scenario: 'Ein Kollege hat die Funktion so umgesetzt:',
        code: _versandCode,
        prompt:
            'Gib an, welchen Wert der abgebildete Code für die vier Aufrufe zurückgibt. (4 P.)',
        punkte: 4,
        text:
            'versand(49) liefert {0}\n'
            'versand(50) liefert {1}\n'
            'versand(200) liefert {2}\n'
            'versand(201) liefert {3}',
        luecken: [
          zahl(4.9, toleranz: 0.001, rationale: '49 < 50 ist wahr.'),
          zahl(
            2.9,
            toleranz: 0.001,
            rationale: '50 < 50 ist falsch, 50 <= 200 ist wahr.',
          ),
          zahl(2.9, toleranz: 0.001, rationale: '200 <= 200 ist wahr.'),
          zahl(0, rationale: 'Keine Bedingung trifft zu.'),
        ],
        explanation:
            'versand(49): Zeile 5 trifft zu, Rückgabe 4.90.\n'
            'versand(50): Zeile 5 trifft nicht zu, Zeile 8 (50 <= 200) trifft zu, Rückgabe 2.90.\n'
            'versand(200): Zeile 8 (200 <= 200) trifft zu, Rückgabe 2.90. Laut Vorgabe müsste der Versand ab 200 € kostenlos sein.\n'
            'versand(201): keine Bedingung trifft zu, Rückgabe 0.',
      ),
      markieren(
        'f-a05-agentur-d',
        'ts-verfahren',
        scenario:
            'Der Test mit dem Bestellwert 200 liefert 2,90 € statt 0,00 €.',
        code: _versandCode,
        prompt: 'Markiere die Zeile, die den Fehler verursacht. (2 P.)',
        punkte: 2,
        mono: true,
        zeilen: [
          nein(
            ' 2   WENN wert < 1 ODER wert > 5000 DANN',
            'Die Prüfung auf ungültige Werte stimmt mit der Vorgabe überein.',
          ),
          nein(
            ' 5   WENN wert < 50 DANN',
            'Die Bedingung stimmt, denn „unter 50 €“ schließt 50 aus.',
          ),
          nein(' 6     RÜCKGABE 4.90', 'Der Betrag entspricht der Vorgabe.'),
          ja(
            ' 8   WENN wert <= 200 DANN',
            'Richtig wäre wert < 200 (oder wert <= 199). Ab 200 € ist der Versand kostenlos.',
          ),
          nein(' 9     RÜCKGABE 2.90', 'Der Betrag entspricht der Vorgabe.'),
          nein('11   RÜCKGABE 0', 'Kostenloser Versand ist hier richtig.'),
        ],
        explanation:
            'In Zeile 8 steht <= statt <. Dadurch fällt der Bestellwert 200 noch in die Klasse „50 bis 199“. Richtig wäre: WENN wert < 200 DANN. In der Prüfung gibt es dafür 1 Punkt für die Fundstelle und 1 Punkt für den richtigen Operator.',
      ),
      freitext(
        'f-a05-agentur-e',
        'ts-testfaelle',
        prompt:
            'Erläutere, warum zusätzlich zu den Repräsentanten der Äquivalenzklassen auch die Grenzwerte getestet werden. Beziehe dich auf den gefundenen Fehler. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Fehler treten gehäuft an den Rändern der Klassen auf, typisch sind falsche Vergleichsoperatoren (<= statt <).',
            punkte: 2,
            stichwoerter: [
              'Ränder',
              'Grenzen',
              'Vergleichsoperator',
              'Operator',
              'Klassengrenze',
            ],
          ),
          krit(
            'Ein Repräsentant aus der Mitte der Klasse (z. B. 120 oder 800) hätte den Fehler nicht aufgedeckt, nur der Grenzwert 200.',
            punkte: 2,
            stichwoerter: [
              'Mitte',
              'Repräsentant',
              'nicht aufgedeckt',
              'unentdeckt',
              'nur der Wert 200',
              'nicht gefunden',
            ],
          ),
        ],
        loesung:
            'An den Klassengrenzen entstehen besonders häufig Fehler, etwa durch einen falschen Vergleichsoperator. Im Beispiel liefern Repräsentanten wie 120 € und 800 € richtige Ergebnisse. Erst der Grenzwert 200 € zeigt, dass im Code <= statt < steht.',
        explanation:
            'Je Aspekt 2 Punkte. Äquivalenzklassen sorgen dafür, dass jeder Fall einmal vorkommt, und die Grenzwertanalyse prüft gezielt die Übergänge.',
      ),
      lueckentext(
        'f-a05-agentur-f',
        'ts-protokoll',
        scenario: 'Die Entwicklung meldet den Fehler als behoben.',
        prompt: 'Vervollständige das weitere Vorgehen. (2 P.)',
        punkte: 2,
        text:
            'Zuerst wird der fehlgeschlagene Testfall mit dem Bestellwert 200 wiederholt, das ist der {0}.\n'
            'Danach prüft der {1}, ob die Korrektur andere Funktionen beschädigt hat.',
        luecken: [
          wahl('Nachtest', ['Abnahmetest', 'Lasttest']),
          wahl('Regressionstest', ['Stresstest', 'Usability-Test']),
        ],
        explanation:
            'Der Nachtest bestätigt, dass genau dieser Fehler behoben ist. Der Regressionstest wiederholt die übrigen, bereits bestandenen Testfälle und schließt Nebenwirkungen aus. Erst danach wird die Fehlermeldung geschlossen.',
      ),
      freitext(
        'f-a05-agentur-g',
        'qm-merkmale',
        prompt:
            'Neben den Funktionen soll das Pflichtenheft auch nicht funktionale Anforderungen an den Webshop des Fahrradhändlers enthalten. Formuliere drei solche Anforderungen messbar. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Antwortzeit mit Zielwert (z. B. Seite lädt in max. 2 s bei 300 Nutzern)',
            stichwoerter: ['Ladezeit', 'Antwortzeit', 'Sekunde', ' s '],
          ),
          krit(
            'Verfügbarkeit in Prozent (z. B. mind. 99,5 % pro Monat)',
            stichwoerter: ['Verfügbarkeit', '%', 'Prozent', 'erreichbar'],
          ),
          krit(
            'Bedienbarkeit messbar (z. B. Bestellung in höchstens 5 Klicks)',
            stichwoerter: ['Klick', 'Minute', 'ohne Hilfe', 'Bedienung'],
          ),
          krit(
            'Sicherheit prüfbar (z. B. Zahlungsdaten nur per TLS übertragen, Passwörter gehasht)',
            stichwoerter: ['TLS', 'HTTPS', 'Hash', 'verschlüsselt'],
          ),
          krit(
            'Wiederanlauf/Kompatibilität prüfbar (z. B. nach Ausfall in 30 min wieder online, läuft in den drei häufigsten Browsern)',
            stichwoerter: ['Wiederanlauf', 'Browser', 'Smartphone', 'Ausfall'],
          ),
        ],
        loesung:
            'Die Produktseiten laden bei 300 gleichzeitigen Besuchern in höchstens 2 Sekunden. Der Shop ist mindestens 99,5 % pro Monat erreichbar. Eine Bestellung ist in höchstens 5 Klicks abgeschlossen. Auch prüfbare Sicherheits- oder Browseranforderungen sind richtig.',
        explanation:
            'Je messbar formulierter Anforderung 1 Punkt, höchstens 3. Ohne Zielwert („schnell“, „sicher“) gibt es keinen Punkt, denn die Anforderung wäre bei der Abnahme nicht prüfbar.',
      ),
    ],
  ),

  // -------------------------------------------------------------- Logistik
  fall(
    'f-a05-logistik',
    firma: 'logistik',
    bereich: 'a05',
    titel: 'Abnahmetest der Scanner-App für den Wareneingang',
    situation:
        'Ein Softwarehaus hat für die Elbtal Logistik AG eine App geliefert, mit der im Wareneingang der neuen Halle Paletten per Handscanner gebucht werden. Laut Pflichtenheft ist je Palette eine Menge von 1 bis 120 Kartons zulässig, andere Mengen werden mit einer Fehlermeldung abgelehnt. Die IT-Abteilung führt den Abnahmetest durch. Du protokollierst die Ergebnisse.',
    teile: [
      tabelle(
        'f-a05-logistik-a',
        'ts-protokoll',
        prompt: 'Bewerte die fünf Testfälle des Testprotokolls. (5 P.)',
        punkte: 5,
        zeilen: [
          ['Testfall', 'Menge', 'Soll', 'Ist', 'Ergebnis'],
          [
            'TF-01',
            '1',
            'gebucht',
            'gebucht',
            wahl('bestanden', ['fehlgeschlagen', 'blockiert']),
          ],
          [
            'TF-02',
            '120',
            'gebucht',
            'Fehler',
            wahl('fehlgeschlagen', ['bestanden', 'blockiert']),
          ],
          [
            'TF-03',
            '121',
            'Fehler',
            'Fehler',
            wahl('bestanden', ['fehlgeschlagen', 'blockiert']),
          ],
          [
            'TF-04',
            '0',
            'Fehler',
            'gebucht',
            wahl('fehlgeschlagen', ['bestanden', 'blockiert']),
          ],
          [
            'TF-05',
            '60',
            'gebucht',
            'gebucht',
            wahl('bestanden', ['fehlgeschlagen', 'blockiert']),
          ],
        ],
        explanation:
            'Ein Testfall ist bestanden, wenn Ist und Soll übereinstimmen: TF-01, TF-03 und TF-05. Bei TF-02 wird die zulässige Menge 120 abgelehnt, bei TF-04 die unzulässige Menge 0 gebucht. Beide sind fehlgeschlagen. Auch eine korrekt ausgelöste Fehlermeldung (TF-03) ist ein bestandener Test.',
      ),
      lueckentext(
        'f-a05-logistik-b',
        'ts-testfaelle',
        scenario:
            'Im Code der App steht die Bedingung: WENN menge >= 0 UND menge < 120 DANN buchen.',
        prompt: 'Werte das Testprotokoll aus. (4 P.)',
        punkte: 4,
        text:
            'Bestehensquote: {0} %\n'
            'Richtig wäre die Bedingung: menge >= {1} UND menge <= {2}\n'
            'Beide Fehler wurden mit Testwerten der {3} gefunden.',
        luecken: [
          zahl(60, rationale: '3 von 5 Testfällen.'),
          zahl(1, rationale: 'Die Menge 0 darf nicht gebucht werden.'),
          zahl(120, rationale: 'Die Menge 120 muss noch gebucht werden.'),
          wahl('Grenzwertanalyse', ['Zweigüberdeckung', 'Lastmessung']),
        ],
        explanation:
            'Bestehensquote: 3 / 5 = 60 %. Zulässig ist 1 bis 120, also menge >= 1 UND menge <= 120. Im Code sind beide Grenzen um eins verschoben. Gefunden wurden die Fehler mit 0 und 120, also Werten direkt an den Klassengrenzen. Der Repräsentant 60 (TF-05) hätte nichts gezeigt.',
      ),
      zuordnen(
        'f-a05-logistik-c',
        'a-abnahme',
        scenario: 'Bei der Abnahme werden fünf Feststellungen notiert.',
        prompt: 'Stufe jede Feststellung ein. (4 P.)',
        punkte: 4,
        buckets: [
          'wesentlicher Mangel',
          'unwesentlicher Mangel',
          'kein Mangel (neuer Wunsch)',
        ],
        items: [
          zu(
            'Im Menü steht „Wareineingang“ statt „Wareneingang“.',
            1,
            'Ein Schreibfehler stört die Nutzung nicht.',
          ),
          zu(
            'Eine volle Palette mit 120 Kartons lässt sich nicht buchen.',
            0,
            'Eine zugesicherte Kernfunktion fehlt.',
          ),
          zu(
            'Die Schichtleitung wünscht sich zusätzlich eine Statistik je Schicht.',
            2,
            'Nicht im Pflichtenheft vereinbart, also ein Änderungsantrag.',
          ),
          zu(
            'Die Menge 0 wird als Wareneingang gebucht.',
            0,
            'Das führt zu falschen Beständen im Lager, die Kernfunktion arbeitet fehlerhaft.',
          ),
          zu(
            'Der Bestätigungston ist leise, die Buchung funktioniert.',
            1,
            'Kleine Beeinträchtigung, die Funktion ist gegeben.',
          ),
        ],
        explanation:
            'Wesentlich sind Mängel, die die vereinbarte Nutzung verhindern oder verfälschen (Buchung von 120 und von 0). Schreibfehler und ein leiser Ton sind unwesentlich. Die Statistik war nicht vereinbart und ist deshalb kein Mangel, sondern ein neuer Wunsch.',
      ),
      freitext(
        'f-a05-logistik-d',
        'a-abnahme',
        prompt:
            'Begründe, ob Elbtal die Abnahme erklären sollte, und beschreibe das weitere Vorgehen. (4 P.)',
        punkte: 4,
        kriterien: [
          krit(
            'Die Abnahme wird verweigert, weil wesentliche Mängel vorliegen.',
            punkte: 2,
            stichwoerter: [
              'verweigern',
              'verweigert',
              'nicht abnehmen',
              'ablehnen',
              'wesentliche Mängel',
            ],
          ),
          krit(
            'Die Mängel werden im Abnahmeprotokoll festgehalten, dem Auftragnehmer wird eine Frist zur Nachbesserung gesetzt.',
            punkte: 2,
            stichwoerter: [
              'Protokoll',
              'Frist',
              'Nachbesserung',
              'dokumentieren',
              'festhalten',
            ],
          ),
          krit(
            'Nach der Korrektur folgen Nachtest und Regressionstest, danach ein neuer Abnahmetermin.',
            punkte: 2,
            stichwoerter: [
              'Nachtest',
              'Regressionstest',
              'erneut testen',
              'neuer Termin',
              'wiederholen',
            ],
          ),
        ],
        loesung:
            'Elbtal sollte die Abnahme verweigern, weil mit den beiden Buchungsfehlern wesentliche Mängel vorliegen. Die Mängel werden im Abnahmeprotokoll festgehalten und dem Softwarehaus wird eine Frist zur Nachbesserung gesetzt. Nach der Korrektur wird erneut getestet und ein neuer Abnahmetermin vereinbart.',
        explanation:
            'Je Aspekt 2 Punkte, höchstens 4. Wegen unwesentlicher Mängel allein dürfte Elbtal die Abnahme nicht verweigern. Solche Mängel werden nur mit Vorbehalt ins Protokoll aufgenommen.',
      ),
      freitext(
        'f-a05-logistik-e',
        'ts-protokoll',
        prompt:
            'Nenne drei Angaben, die die Fehlermeldung zu TF-02 an das Softwarehaus enthalten muss. (3 P.)',
        punkte: 3,
        kriterien: [
          krit(
            'Schritte und Eingaben, mit denen sich der Fehler nachstellen lässt (Menge 120)',
            stichwoerter: [
              'Schritte',
              'Eingabe',
              'nachstellen',
              'reproduzieren',
            ],
          ),
          krit(
            'Soll- und Ist-Ergebnis',
            stichwoerter: ['Soll', 'Ist-Ergebnis', 'erwartet', 'tatsächlich'],
          ),
          krit(
            'Testumgebung: App-Version und Scannermodell',
            stichwoerter: ['Version', 'Umgebung', 'Scannermodell', 'Gerät'],
          ),
          krit(
            'Fehlerklasse und Priorität',
            stichwoerter: ['Fehlerklasse', 'Priorität', 'Schwere'],
          ),
          krit(
            'Kennung, Titel, Datum und Name des Testers',
            stichwoerter: ['Kennung', 'Titel', 'Datum', 'Tester', 'Nummer'],
          ),
        ],
        loesung:
            'In die Meldung gehören die Schritte zum Nachstellen (Palette scannen, Menge 120 eingeben), das Soll-Ergebnis „gebucht“ und das Ist-Ergebnis „Fehlermeldung“ sowie die Testumgebung mit App-Version und Scannermodell. Richtig sind außerdem Fehlerklasse und Priorität.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3. Eine Fehlermeldung muss so genau sein, dass die Entwicklung den Fehler ohne Rückfrage nachstellen kann.',
      ),
      paare(
        'f-a05-logistik-f',
        'qm-merkmale',
        scenario:
            'Im Pflichtenheft stehen neben den Funktionen auch nicht funktionale Anforderungen an die App. Für die Abnahme muss jede testbar sein.',
        prompt: 'Ordne jeder Anforderung die passende Prüfmethode zu. (3 P.)',
        punkte: 3,
        paare: [
          paar('Buchung in höchstens 1 s', 'Lasttest mit Zeitmessung'),
          paar(
            'Kein Datenverlust bei WLAN-Abbruch',
            'WLAN während der Buchung trennen und Datenbestand prüfen',
          ),
          paar(
            'Mit Arbeitshandschuhen bedienbar',
            'Usability-Test mit Lagerpersonal in Handschuhen',
          ),
          paar(
            'Läuft auf zwei Scannermodellen',
            'Testfälle auf beiden Geräten ausführen',
          ),
        ],
        explanation:
            'Zu jeder nicht funktionalen Anforderung gehört eine Prüfmethode, die ein eindeutiges Ergebnis liefert: Zeit messen, Störung herbeiführen, echte Nutzer beobachten, auf jeder Zielplattform testen.',
      ),
      rechnen(
        'f-a05-logistik-g',
        'ts-protokoll',
        scenario:
            'Für die Wiederholung des Abnahmetests werden 60 Testfälle festgelegt. Endekriterium: Mindestens 95 % der Testfälle sind bestanden.',
        prompt:
            'Berechne, wie viele Testfälle höchstens fehlschlagen dürfen. (2 P.)',
        punkte: 2,
        answer: 3,
        unit: 'Testfälle',
        explanation:
            '95 % von 60 = 57 Testfälle müssen bestanden sein. Höchstens 60 - 57 = 3 dürfen fehlschlagen (5 % von 60 = 3).',
      ),
    ],
  ),
];
