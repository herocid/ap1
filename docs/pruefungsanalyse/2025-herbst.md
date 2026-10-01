# AP1 Herbst 2025 - Analyse

Quellen: `AP1-2025-Herbst.pdf` (15 Seiten, Scan im Querformat, um 90 Grad gedreht) und
`AP1-2025-Herbst_Lösung.pdf` (6 Seiten Lösungshinweise). Aufgaben und Lösungen sind in eigenen
Worten beschrieben, nicht zitiert.

## 1. Kopf

| Merkmal | Wert |
| --- | --- |
| Termin | Mittwoch, 17. September 2025 |
| Prüfung | Teil 1 der Abschlussprüfung, „Einrichten eines IT-gestützten Arbeitsplatzes“ (Lösung gilt für 1201-1205, 6470, 6480 = alle IT-Berufe) |
| Bearbeitungszeit | 90 Minuten |
| Gesamtpunkte | 100 |
| Aufgaben | 4: **25 / 25 / 26 / 24** Punkte |
| Teilaufgaben | 31 |
| Hilfsmittel | nicht programmierbarer, netzunabhängiger Taschenrechner; Konzeptpapier |
| Notenschlüssel (laut Lösung) | 1: 100-92 / 2: unter 92-81 / 3: unter 81-67 / 4: unter 67-50 / 5: unter 50-30 / 6: unter 30 |
| Korrekturhinweise | Lösungen sind Beispiele; andere fachgerechte Antworten zählen voll. Ist eine Anzahl verlangt, gibt es dafür die volle Punktzahl, auch wenn die Lösung mehr aufzählt. Teilpunkte für Teilleistungen. Operator-Stufe (nennen/erklären/beschreiben/erläutern) beachten. |
| Ausgangssituation | Der Prüfling ist Azubi in der IT-Abteilung einer bundesweiten Apothekengruppe mit Onlineshop. Eine neue Filiale wird eröffnet; es geht um Beschaffung, Kassensysteme, Rechnungswesen und ein Kartenterminal. |

## 2. Aufgaben

### Aufgabe 1 - Eingangsrechnung prüfen, Skonto, Veränderung (25 P.)

Material für a-d: ganzseitige Musterrechnung eines Lieferanten (3 Positionen, zwei Steuersätze,
Bestell-/Liefer-/Rechnungsdatum, Zahlungsziel mit Skonto, QR-Code, Bankverbindungen).

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| a | Kaufmännisch relevante Zeitpunkte auf dem Beleg | nennen (mit Datum) | Freitext kurz, aus Beleg ablesen | 3 | Rechnung | Bestellung 05.09., Lieferung 10.09., Rechnungsstellung 11.09. - nur bereits *stattgefundene* Vorgänge (nicht die Zahlungsfristen). 1 P. je Paar Datum + Vorgang. |
| b | Rechnungspositionen kontrollieren | beschreiben (drei Kontrollen) | Freitext lang | 6 | Rechnung | Abgleich mit Bestellung/Lieferung: Artikelbezeichnung, Menge/Einheit, Einzelpreis, Steuersatz (19 % oder 7 %). 2 P. je Kontrolle. Ausdrücklicher Hinweis: nur die *Positionen* zählen, nicht Adresse oder Bankdaten. |
| ca | Skontobetrag | berechnen (kaufmännisch auf 2 Stellen) | Rechnung mit Rechenweg | 2 | Rechnung: brutto 1.130,20 EUR, 2 % Skonto | 1.130,20 x 0,02 = 22,604 -> **22,60 EUR**. Basis ist der Bruttobetrag. |
| cb | Gründe für Rabatt | beschreiben (zwei) | Freitext lang | 4 | - | Mengen-, Neukunden-, Treue-, Zeit-/Frühbezugs-, Personengruppen-, Online-Rabatt, jeweils mit kurzer Erklärung. 2 P. je Grund. „Weitere Lösungen möglich“. |
| da | Inhalt eines GiroCode | nennen (zwei) | Freitext kurz | 2 | QR-Code auf der Rechnung | Daten einer SEPA-Überweisung: Empfänger, IBAN, BIC, Verwendungszweck, Betrag. |
| db | Erleichterungen durch den Code | nennen (zwei) | Freitext kurz | 2 | - | Fehlerfreie Übernahme, kein Abtippen, bessere Zuordnung des Zahlungseingangs. |
| ea | Ursachen für Ablehnung neuer Prozesse | nennen (zwei) | Freitext kurz | 2 | Kurzszenario Automatisierung | Angst um den Arbeitsplatz, Überforderung, Festhalten an Routinen, mehr Leistungsdruck, Kontrollverlust. |
| eb | Maßnahmen gegen die Bedenken | beschreiben (zwei) | Freitext lang | 4 | - | Früh kommunizieren, Nutzen/Aufwertung aufzeigen, schulen, klare Anleitungen, Multiplikatoren, Mitarbeiter einbeziehen, Verbesserungen transparent machen. 2 P. je Maßnahme. |

### Aufgabe 2 - Digitales Rechnungsmanagement (25 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| a | Digitale Rechnung: Vor- und Nachteile | nennen (je zwei) | Tabelle ausfüllen (2 Zeilen) | 4 | leere Tabelle | Vorteile: Effizienz, Kostenersparnis, Zugriff/Nachverfolgbarkeit, Integration, Nachhaltigkeit, keine Medienbrüche. Nachteile: Anfangsinvestition, Sicherheitsrisiken, Vorbehalte, Schulungskosten. Je 1 P. |
| ba | UML-Aktivitätsdiagramm zum Rechnungseingang | erstellen | Diagramm zeichnen (Start und erste Aktion vorgegeben) | 9 | Ablauf in 7 Spiegelstrichen; **ganze Notationsübersicht abgedruckt** (Start-/Endknoten, Ablaufende, Schwimmbahnen, Splitting/Synchronisation, Entscheidung/Zusammenführung, Konnektor) | Automatische Prüfung + Entscheidung ok/nicht ok (2 P.); Entscheidung Betrag >= 1.000 -> manuelle Prüfung + Entscheidung (2 P.); je 1 P. für Bezahlen, Archivieren, Parallelisierung (Balken), Ablehnung, Endknoten. Die beiden Ablehnungswege und der ok-Weg werden über Rauten zusammengeführt. |
| bb | Argumente für KI-gestützte Rechnungsprüfung | beschreiben (zwei) | Freitext lang | 4 | - | Lernendes System erkennt Muster; Zeitersparnis; Kostenreduktion; weniger Fehler; skalierbar ohne mehr Personal. 2 P. je Argument. |
| ca | Speicherbedarf pro Tag in KiB | ermitteln (Rechenweg, ganze KiB) | Rechnung im Karoraster | 3 | 14 Rechnungen/h rund um die Uhr, je 124 kB | 24 x 14 = 336 Rechnungen/Tag (1 P.); 124 x 336 x 1.000 / 1.024 = 40.687,5 -> **40.688 KiB** (2 P.). Kern: kB (1.000) in KiB (1.024) umrechnen. |
| cb | Jahresbedarf in GiB bei 30 % Kompression | ermitteln (2 Nachkommastellen) | Rechnung im Karoraster | 3 | Ersatzwert 50.000 KiB/Tag, falls ca fehlt | 40.688 x 365 = 14.851.120 KiB (1 P.); / 1.024 / 1.024 x 0,7 = **9,92 GiB** (2 P.). Mit Ersatzwert: 18.250.000 KiB -> **12,19 GiB**. „Um 30 % verringern“ = Faktor 0,7. |
| cc | Kosten externer Speicher über 10 Jahre | ermitteln | Rechnung im Karoraster | 2 | 21 EUR pro 5 GiB und Jahr; 15 GiB pro Jahr | 15 / 5 = 3 Pakete pro Jahr; 3 x 10 = 30; 30 x 21 = **630 EUR**. (Die Lösung rechnet nicht mit jährlich wachsendem Bestand.) |

### Aufgabe 3 - Kartenterminal einrichten (26 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| a | Gesundheitsdaten: erhöhter Schutz und Rechtsgrundlage | begründen, nennen | Freitext lang | 3 | - | 2 P. Begründung (besonders schützenswerte personenbezogene Daten, Einwilligung nötig), 1 P. Grundlage (DSGVO, BDSG; auch § 291 SGB V). |
| b | Authentifizierungsfaktoren Biometrie / Wissen / Besitz | ergänzen | Tabelle ausfüllen (4 Zellen; Spalte Fingerabdruck als Muster) | 4 | Tabelle Methode / Vorteil / Risiko | Passwort: kein Hilfsmittel oder Lesegerät nötig - kann verraten, ausgespäht, geknackt werden. Chipkarte: kann Daten speichern, weitergebbar - kann gestohlen und missbraucht werden. 1 P. je Zelle. |
| c | Softwareupdate vor Inbetriebnahme | beschreiben (einen Grund) | Freitext lang | 2 | - | Fehler beheben, gegen Angriffe härten, an aktuelle Anforderungen anpassen. |
| d | Risiko manipulierter Geräte (Lieferkette) | beschreiben (ein Risiko) | Freitext lang | 2 | - | Unbemerkt eingebaute Abhör-/Auslesefunktionen, deaktivierte Sicherheitsfunktionen. |
| ea | Nötiger Strom am USB-Port | ermitteln | Rechnung, Formel P = U x I gegeben | 2 | Netzteil 24 V / 0,5 A; USB 5 V | P = 24 x 0,5 = 12 W; I = 12 / 5 = **2,4 A**. |
| eb | Störungen und USB-Stromversorgung | begründen | Freitext lang | 3 | Hinweis: weitere USB-Geräte am PC | 2,4 A liefert nicht jeder USB-Port (je nach Typ A/C); Versorgung dann instabil -> Netzteil bevorzugen. |
| f | IPv4-Konfiguration des Terminals | konfigurieren | Formularfelder (IP, Maske, Gateway) | 3 | Netzskizze: Router .1, Konnektor .10, PC .25 im Netz 172.16.10.0/24 | Letzte mögliche Adresse **172.16.10.254**, Maske **255.255.255.0**, Gateway **172.16.10.1**. Je 1 P. |
| g | Richtige Netzwerkdose wählen | auswählen, begründen | Freitext lang, Foto auswerten | 3 | Foto zweier Doppeldosen (3/4, 5/6) und eines Patchfelds mit Switch | Ports 3 und 4 sind am Patchfeld nicht mit dem Switch verbunden -> nur Dose 5 oder 6 funktioniert (alternativ umpatchen). |
| h | Digitale Signatur: Erstellen und Prüfen | beschreiben anhand Skizze | Freitext lang | 4 | Schlüssel-Skizze (dieselbe Grafik wie Frühjahr 2025, anders beschriftet) | Hash der Nachricht bilden, mit **privatem Schlüssel des Absenders** verschlüsseln = Signatur, mit Nachricht senden; Empfänger entschlüsselt mit **öffentlichem Schlüssel des Absenders** (Authentizität), berechnet den Hash neu und vergleicht (Integrität). Auch die Kurzfassung (mit privatem Schlüssel signieren, mit öffentlichem prüfen) reicht für volle Punkte. |

### Aufgabe 4 - Datenbank und Algorithmen (24 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| aa | Primärschlüssel | beschreiben (auf Deutsch, mit Textbezug) | englischen Text auswerten | 2 | 7 Zeilen Englisch aus einer Fachzeitschrift | Eindeutiger Bezeichner für jeden Datensatz. |
| ab | Fremdschlüssel | beschreiben | englischen Text auswerten | 2 | derselbe Text | Verknüpft Tabellen, indem er auf den Primärschlüssel einer anderen Tabelle verweist. |
| ac | Vorteil verknüpfter Tabellen | beschreiben | englischen Text auswerten | 2 | derselbe Text | Effiziente Datenorganisation, weniger Redundanz. |
| b | ER-Modell in Chen-Notation erweitern | modellieren | Diagramm zeichnen (eine Entität mit Attributen und zwei leere Rauten vorgegeben) | 8 | 6 Regeln als Spiegelstriche, Liste von 12 Attributen mit Erklärung | 2 neue Entitäten (2 P.), 2 Kardinalitäten: Medikament n:m Wirkstoff, Medikament n:1 Lieferant (2 P.), Primärschlüssel in allen drei Entitäten (1 P.), Attribute sinnvoll zugeordnet (2 P.), Attribut „Dosierung“ an der n:m-Beziehung (1 P.). Aufgelöste Zwischentabelle ist ebenfalls zulässig. Fremdschlüssel nicht verlangt. |
| ca | Code zeilenweise erklären | erläutern (3 Zeilen) | Freitext lang zu Code | 3 | 5 Zeilen englischer Pseudocode (Schleife, Bedingung, Ausgabe) | Schleife über alle Elemente / Vergleich Menge < Limit / Ausgabe des Namens mit Hinweistext. 1 P. je Zeile. |
| cb | Schreibtischtest | durchführen, Ausgabe angeben | Code lesen, Ausgabe notieren | 2 | Liste mit 4 Datensätzen (Mengen 50, 22, 25, 30), Limit 25 | Nur der Eintrag mit 22 wird ausgegeben. Falle: 25 < 25 ist falsch. |
| da | Fehler im Pseudocode finden | erläutern | Freitext lang zu Code | 3 | 6 Zeilen deutscher Pseudocode (Summe über Preis x Menge) | Startwert 0 wird in der Schleife *multipliziert* statt addiert -> Ergebnis bleibt immer 0. |
| db | Fehlerhafte Zeile korrigieren | korrigieren | Codezeile schreiben | 2 | - | Summenzeile mit `+` statt `*`. Korrektur direkt im Code zulässig. |

## 3. Beobachtungen

**Operatoren und Punkte.** „Beschreiben“ dominiert (13x), dann „nennen“ (5x) und
„ermitteln/berechnen“ (5x). Die Lösung bestätigt die Faustregel **nennen = 1 P. je Punkt,
beschreiben = 2 P. je Punkt**. Bei Rechnungen gibt es 1 P. für den Zwischenschritt und 2 P. für
das Endergebnis. Diagramme werden nach Elementen bepunktet (je Entität, Kardinalität, Aktion 1-2 P.).

**Offenheit.** Unter fast jeder Freitextlösung steht ein Zusatz wie „weitere Lösungen möglich“.
Die Lösungslisten sind länger als verlangt (5-7 Punkte, verlangt 2) - für die App heißt das:
Kriterienlisten mit „mindestens n von m“.

**Rechnen.** 12 P. in fünf Teilaufgaben: Prozent (Skonto), Einheiten (kB -> KiB -> GiB),
Dreisatz (Speicherkosten), Elektrik (P = U x I, Formel gegeben). Ersatzwerte für Folgefehler.

**Material.** Vollständige Rechnung als Beleg, Notationsübersicht UML, Netzskizze, **Fotos**
(Netzwerkdosen, Patchfeld), Schlüssel-Skizze, englischer Fachtext, Attributliste, zwei Codestücke.

**Stolperfallen.**
- 1a: nur vergangene Vorgänge; 1b: nur Rechnungspositionen.
- Skonto vom Brutto, kaufmännisch runden.
- kB ist dezimal, KiB binär; „um 30 % verringern“ ergibt Faktor 0,7.
- Speicherkosten: Lösung rechnet linear (3 Pakete x 10 Jahre), nicht kumuliert.
- Signatur ist nicht Verschlüsselung: hier privater Schlüssel des *Absenders*.
- Grenzwert `<` bei gleichem Wert; Multiplikation mit 0.
- Chen: Attribut an der Beziehung, n:1-Richtung laut Text („immer von einem Lieferanten“).

**Neu seit Katalog 2025.**
- **Kaufmännische Belegarbeit** (Rechnung lesen, Skonto/Rabatt, GiroCode) als ganze Aufgabe.
- **KI** als Argumentationsaufgabe (4 P.) im Prozesskontext.
- **Change Management/Akzeptanz** bei Digitalisierung (6 P.).
- **UML-Aktivitätsdiagramm selbst zeichnen** (9 P.) - mit abgedruckter Notationshilfe.
- **ER-Modell in Chen-Notation** (8 P.) statt SQL-Abfragen.
- **Pseudocode: erklären, testen, Fehler finden und korrigieren** (10 P.) statt Struktogramm.
- **Lieferkettensicherheit**, Signatur, Mehr-Faktor-Kategorien.
- Englisch mit drei direkten Verständnisfragen (6 P.).
- Nicht enthalten: SQL, RAID, Netzplan, Barrierefreiheit, Testen/QS, Vertragsrecht.
