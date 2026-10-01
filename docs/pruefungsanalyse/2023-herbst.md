# AP1 Herbst 2023 - Analyse

Quelle: `AP1-2023-Herbst.pdf` (12 Seiten, Scan mit handschriftlichen Antworten eines Prüflings) und
`AP1-2023-Herbst_Lösung.pdf`. `AP Teil 1_Herbst 2023.pdf` ist byte-identisch mit
`AP1-2023-Herbst.pdf`; `AP 1 - Herbst 2023.pdf` ist dieselbe Prüfung als kleinerer Scan mit
Textebene (am besten durchsuchbar). Aufgaben sind in eigenen Worten beschrieben, nicht zitiert.

**Achtung:** Die Lösungsdatei sind keine offiziellen IHK-Lösungshinweise, sondern
Lösungserläuterungen eines Verlags (u-form). Sie enthalten ausführliche Musterantworten und
Hintergrundwissen, aber **keine Punkteaufteilung** innerhalb der Teilaufgaben.

## Kopf

| Merkmal | Wert |
| --- | --- |
| Termin | Dienstag, 19. September 2023 |
| Bearbeitungszeit | 90 Minuten |
| Gesamtpunkte | 100 |
| Aufgaben | 4, dazu ein heraustrennbares Blatt „SQL-Syntax (Auszug)“ über zwei Seiten |
| Punkte je Aufgabe | 25 / 25 / 22 / 28 |
| Hilfsmittel | nicht programmierbarer, netzunabhängiger Taschenrechner; Konzeptpapier; SQL-Syntaxblatt |

Ausgangssituation: Ein Systemhaus, das Software für Handwerksbetriebe herstellt und anpasst, will
seine Kundenbetreuung verbessern und richtet einen 24/7-Service als eigene Abteilung mit passenden
(Tele-)Arbeitsplätzen ein.

## Aufgabe 1 - Servicequalität, Kundenbedarf, Kommunikation (25 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | UML-Anwendungsfalldiagramm zum Störungsmeldeprozess vervollständigen | ergänzen | Diagramm ergänzen: fehlende Anwendungsfälle und Akteursnamen eintragen | 6 | vier Stichpunkte zum Ist-Prozess, angefangenes Diagramm (Systemgrenze, drei Akteure, zwei Use Cases, zwei include-Beziehungen) | Akteure Kunde, IT-Abteilung, Serviceteam; fehlende Fälle: Meldung senden, Arbeitsplanung erstellen, Priorisierung, Rückmeldung geben. „Beinhaltet immer“ im Text = include (nicht extend). | relevant |
| ba | Schwachstellen des Ist-Ablaufs (Meldung nur per E-Mail, Verwaltung in Tabellenkalkulation, Planung einmal pro Woche, Servicezeiten nur werktags) | beschreiben | Freitext lang (2 Kritikpunkte) | 4 | Prozessbeschreibung | Eingeschränkter Meldeweg, Datenhaltung nicht revisionssicher/unübersichtlich, langsamer Planungstakt, fehlende Automatisierung mit Fehlerrisiko. Weitere Punkte möglich. | relevant |
| bb | Maßnahmen für bessere Servicequalität | nennen | Freitext kurz (2) | 2 | - | Ticketsystem, Automatisierung, Kundenfeedback, 24/7-Support, SLAs, CRM. | relevant |
| c | Methoden der Bedarfsanalyse | nennen | Freitext kurz (3) | 3 | - | Interviews/Fokusgruppen, schriftliche Befragung, Marktforschung, Auswertung von Nutzungsdaten oder Beschwerden, Social-Media-Monitoring. | relevant |
| da | Englischer Text zur Preisgestaltung von Dienstleistungen: Risiko zu hoher Preise | benennen | Englischen Text auswerten, Antwort auf Deutsch | 1 | englischer Kurztext (ca. 90 Wörter) mit vier Aufzählungspunkten | Kunden lehnen ab, kein Absatz. | relevant |
| db | wie da: Risiko zu niedriger Preise | benennen | Englischen Text auswerten | 1 | wie da | Kosten werden nicht gedeckt. | relevant |
| dc | wie da: die vier genannten Aspekte der Preisfindung | nennen | Englischen Text auswerten (4 Punkte übersetzen) | 4 | wie da | Kosten berechnen, Kunden kennen, Markt beobachten, Preismodell wählen. | relevant |
| e | Kundenaussage nach dem Vier-Ohren-Modell deuten | beurteilen | Strukturierte Antwort: vier vorgegebene Felder (Sache, Selbstaussage, Beziehung, Appell) | 4 | Kundenzitat | Sache: Kritik an den Preisen. Selbstaussage: Kunde ist unzufrieden. Beziehung: fühlt sich schlecht behandelt. Appell: Preise senken oder mehr Leistung bieten. | relevant |

## Aufgabe 2 - Telearbeitsplatz, Ergonomie, Hotline-Kalkulation (25 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Was ein Telearbeitsplatz zusätzlich zum PC braucht | nennen, begründen | Freitext lang (2 Anschaffungen/Maßnahmen mit Begründung) | 4 | - | Z. B. sichere Internetverbindung, Headset, Telefon, Webcam, Drucker/Scanner, Schulung, Zugangsrichtlinien, ergonomische Möbel - jeweils mit Zweck. | relevant |
| b | Warum ein Tablet kein Bildschirmarbeitsplatz ist | erläutern | Freitext lang (2 Aspekte) | 4 | - | Kleiner Bildschirm senkt Produktivität, Software oft nicht kompatibel; ferner fehlende Tastatur/Maus, Ergonomie, Leistung, Anschlüsse. | relevant |
| c | Notebook ergonomischer machen | beschreiben | Freitext lang (2 Möglichkeiten) | 4 | - | Externer Monitor, externe Tastatur und Maus, Dockingstation, Notebook-Ständer. | relevant |
| d | Homeoffice aus Sicht der Beschäftigten | eintragen | Tabelle ausfüllen (2 Vorteile, 2 Nachteile) | 4 | leere Zweispaltentabelle | Vorteile: flexible Zeit, kein Pendeln, Work-Life-Balance. Nachteile: Isolation, Ablenkung, Vermischung von Beruf und Privat, erschwerte Teamkommunikation. | relevant |
| e | Einheitlicher Minutenpreis für eine Nacht-Hotline über drei Support-Level | berechnen | Rechnung mit Rechenweg, aufrunden auf ganze Cent | 5 | Tabelle: Bereitschafts-Stundensatz (12 / 15 / 20 EUR), Minutensatz bei Anruf (0,50 / 1,00 / 1,50 EUR), Anrufminuten je Nacht (150 / 100 / 50); Bereitschaft 20:00-06:00 Uhr | 10 h x (12 + 15 + 20) = 470 EUR; Anrufkosten 75 + 100 + 75 = 250 EUR; gesamt 720 EUR; 150 + 100 + 50 = 300 min; 720 / 300 = 2,40 EUR je Minute. | relevant |
| f | Kunden die kostenpflichtige Hotline erklären | formulieren | Freitext in ganzen Sätzen (2 Argumente, für eine E-Mail) | 4 | - | Transparenz/Kostenkontrolle, Verursacherprinzip, qualifiziertes Personal rund um die Uhr, Zusatzleistung ist nicht im Softwarepreis kalkuliert. | relevant |

## Aufgabe 3 - Datenschutz und Sicherheit am Telearbeitsplatz (22 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Rechtsgrundlagen des Datenschutzes in Deutschland | nennen | Freitext kurz (2) | 2 | - | DSGVO, BDSG; auch Landesdatenschutzgesetze, StGB. | relevant |
| b | Technisch-organisatorische Maßnahmen für vier Bereiche (Zutritt zum Telearbeitsplatz, sichere Anmeldung, sichere Kommunikation, Datenträgertransport) | nennen | Tabelle ausfüllen (4 Zeilen, eine Zeile als Beispiel vorgegeben) | 4 | Tabelle mit Beispielzeile | Abschließbarer Raum/Schrank; Biometrie oder Mehr-Faktor-Anmeldung; VPN/verschlüsselte Übertragung; gesicherte Transportbehälter. Eine Maßnahme je Bereich. | relevant |
| ca | Kriterien für sichere Passwörter | nennen | Freitext kurz (2) | 2 | Szenario: SSD-Verschlüsselung mit TPM, Passwort beim Start, getrennter Wiederherstellungsschlüssel | Länge, Zeichenmix, kein Personenbezug, kein Wörterbuchwort, je Zugang ein eigenes Passwort. | relevant |
| cb | Aufbewahrungsorte für den Wiederherstellungsschlüssel (Cloud, USB-Stick, Ausdruck) bewerten | beurteilen | Tabelle ausfüllen (je ein Vor- und Nachteil, erste Zeile als Beispiel) | 3 | Tabelle mit Beispielzeile | Cloud: überall erreichbar / Anbieter angreifbar. USB: offline nutzbar / kann verloren gehen. Ausdruck: nicht digital angreifbar / unverschlüsselt, kann verblassen oder verloren gehen. | relevant |
| cc | Schutzziele Vertraulichkeit und Integrität auf die SSD beziehen | beschreiben | Freitext lang | 4 | - | Vertraulichkeit: nur Befugte können lesen. Integrität: unbefugte Änderungen werden erkannt. | relevant |
| cd | Schutz bei Diebstahl des ganzen Laptops | beurteilen | Freitext kurz | 2 | - | Ohne Passwort kein Zugriff auf die Daten; Schutz hängt am Passwort. | relevant |
| da | Sicherheitsvorteil eines VPN | beschreiben | Freitext kurz | 2 | - | Verschlüsselter Tunnel über unsichere Netze, Schutz vor Mitlesen. | relevant |
| db | Identifizierung mit persönlichem digitalem Zertifikat | beschreiben | Freitext lang | 3 | - | Zertifizierungsstelle prüft die Identität und stellt das Zertifikat aus; der Inhaber weist sich damit eindeutig gegenüber dem Firmenserver aus. | relevant |

## Aufgabe 4 - Projektplanung, Datenbankentwurf, SQL (28 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| aa | Merkmale von Gantt-Diagramm und Netzplan | nennen | Freitext kurz (je 2) | 4 | - | Gantt: Balken über Zeitachse, Start/Ende sichtbar, leicht verständlich, Meilensteine. Netzplan: früheste/späteste Zeitpunkte, Puffer, kritischer Pfad, Abhängigkeiten. | relevant |
| ab | Phasen des Datenbankentwurfs ordnen | in Reihenfolge bringen | Reihenfolge: 6 Ziffern in eine Kästchenleiste eintragen (erste Phase vorgegeben) | 3 | nummerierte Phasenliste | Anforderungsanalyse -> konzeptioneller Entwurf -> logischer Entwurf -> Entwurf der Verteilung -> physischer Entwurf/Implementierung -> Test und Validierung -> Anwendung und Wartung. | relevant |
| ba | Gantt-Diagramm aus Textbeschreibung erstellen, Abhängigkeiten einzeichnen | erstellen | Diagramm zeichnen: Balken in ein Raster (7 Vorgänge x 22 Tage) eintragen, erster Vorgang vorgegeben | 6 | Fließtext mit Dauern und Nachfolgern | A Tag 1-3; B 4-9 (6 T); C 10-13 (4 T); D 4-11 (8 T); E 4-8 (5 T); F 14-16 (3 T); G 17-18 (2 T). | relevant |
| bb | Frühestes Projektende | ermitteln | Kurzantwort (Zahl) | 1 | eigenes Diagramm | 18 Tage. | relevant |
| bc | Vorgang mit dem größten Puffer | ermitteln | Kurzantwort (Buchstabe) | 1 | eigenes Diagramm | Vorgang E (5 Tage Puffer). | relevant |
| ca | ER-Diagramm um eine Entität „Tätigkeit“ mit Attributen und Beziehungen erweitern | ergänzen | Diagramm ergänzen (Entität, Attribute, Beziehungen, Kardinalitäten) | 5 | ERD mit Kunde, Ticket, Mitarbeiter (Chen-Notation), Anforderungstext | Neue Entität mit Schlüssel, Beschreibung, Ergebnis, Start- und Endzeit, Fremdschlüsseln auf Ticket und Mitarbeiter; Ticket 1:n Tätigkeit, Mitarbeiter 1:n Tätigkeit. | relevant (ER-Modell) |
| cb | SQL: Anzahl je Gruppe | erstellen | SQL schreiben | 2 | ERD, SQL-Syntaxblatt | `SELECT` Spalte, `COUNT(...)` ... `GROUP BY` Spalte. | **gestrichen (SQL)** |
| cc | SQL: Anzahl verschiedener Werte | erstellen | SQL schreiben | 3 | wie cb | `COUNT(DISTINCT ...)` auf die Kundenspalte der Tickettabelle. | **gestrichen (SQL)** |
| cd | Gegebene SQL-Abfrage lesen und Ergebnis beschreiben | analysieren, beschreiben | Code lesen, Freitext | 3 | SELECT mit `MONTH(NOW()) - MONTH(...) > 2`, Zustandsfilter, `ORDER BY ... ASC` | Offene Tickets, deren Erfassungsmonat mehr als zwei Monate zurückliegt, mit vier Spalten, aufsteigend nach Datum (älteste zuerst). | **gestrichen (SQL)** |

## Beobachtungen

- **Operatoren:** nennen (8x), beschreiben (6x), beurteilen (3x), erläutern, begründen, ergänzen
  (2x), erstellen (3x), berechnen, ermitteln (2x), formulieren, in Reihenfolge bringen, analysieren.
- **Punkteverteilung:** 31 Teilaufgaben, im Mittel gut 3 Punkte. Viele 2- und 4-Punkte-Aufgaben
  nach dem Muster „zwei Dinge nennen / zwei Dinge beschreiben“. Größte Einzelposten: Use-Case-
  Diagramm (6), Gantt-Diagramm (6), ERD (5), Rechnung (5).
- **Rechnen:** nur eine echte Rechenaufgabe (5 P) plus zwei abgelesene Werte aus dem Gantt-Diagramm
  (2 P) - deutlich weniger als in den Nachbarprüfungen.
- **Diagramme:** 17 Punkte für drei Diagramme (Use Case ergänzen, Gantt zeichnen, ERD ergänzen).
  Immer ist ein Teil vorgegeben; es wird nie „auf leerem Blatt“ begonnen.
- **Materialien:** Prozessbeschreibung, angefangenes Use-Case-Diagramm, englischer Fachtext,
  Kostentabelle, Tabellen mit Beispielzeile, Gantt-Raster, ERD, SQL-Abfrage, SQL-Syntaxblatt.
- **Englisch:** kurzer, einfacher Text; gefragt ist reines Wiederfinden und Übersetzen (6 P).
- **Stolperfallen:**
  - Use Case: „immer“ im Text bedeutet include, nicht extend; Akteure stehen außerhalb der
    Systemgrenze.
  - Hotline-Rechnung: Bereitschaftsstunden (10 h über Mitternacht) und Anrufminuten sind zwei
    getrennte Kostenblöcke; geteilt wird durch die Summe der Anrufminuten, nicht durch 600 Minuten.
  - Gantt: Die Vorgangsbeschreibung nennt einen Nachfolger doppelt; man muss selbst erkennen, dass F
    erst nach C, D und E starten kann. Puffer ergibt sich aus dem Abstand zum Start des Nachfolgers.
  - ERD: Kardinalitäten und Fremdschlüssel nicht vergessen.
  - Die SQL-Analyseaufgabe hat einen fachlichen Haken (reine Monatsdifferenz über den Jahreswechsel),
    die Musterlösung verlangt aber nur die Beschreibung des beabsichtigten Ergebnisses.
  - Verlangt die Aufgabe „in ganzen Sätzen“, zählen Stichworte nicht.
- **Katalog 2025:** 8 Punkte SQL sind gestrichen; alles andere (92 Punkte) bleibt relevant.
