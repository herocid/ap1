# AP1 Herbst 2022 – Prüfungsanalyse

Quelle: `AP1-2022-Herbst.pdf` (13 Seiten, Scan) und `AP1-2022-Herbst_Lösung.pdf` (amtliche
Lösungshinweise, 6 Seiten, Scan). Die Aufgaben sind urheberrechtlich geschützt; hier stehen nur
Struktur, Thema, Format und Lösungserwartung in eigenen Worten.

## 1. Kopf

| Merkmal | Wert |
| --- | --- |
| Termin | Mittwoch, 21. September 2022 |
| Bearbeitungszeit | 90 Minuten |
| Gesamtpunkte | 100 |
| Anzahl Aufgaben | 4 (27 Teilaufgaben) |
| Punkte je Aufgabe | 23 / 25 / 28 / 24 |
| Hilfsmittel | nicht programmierter, netzunabhängiger Taschenrechner ohne Kommunikationsmöglichkeit; Konzeptpapier; **im Aufgabensatz eingeheftet: zweiseitige SQL-Syntaxübersicht** (heraustrennbar) und eine Legende zur Chen-Notation für ER-Modelle |
| Bearbeitungsregeln | Stichworte genügen, wenn nicht ganze Sätze verlangt sind; überzählige Nennungen werden nicht gewertet |
| Notenschlüssel | 1: 100–92, 2: unter 92–81, 3: unter 81–67, 4: unter 67–50, 5: unter 50–30, 6: unter 30 |
| Korrekturhinweis | Lösungen sind Beispiele, andere fachgerechte Antworten zählen voll; Teilpunkte für Teilleistungen (bis auf 0,5 Punkte genau). |
| Ausgangssituation | Der Ausbildungsbetrieb stellt Verpackungsmaterial her und will wegen stark gestiegener Nachfrage die Produktion stärker automatisieren. Man gehört zur Arbeitsgruppe, die das Vorhaben plant: Projektrahmen, Datenmengen und Speicher für eine Kamera-Qualitätskontrolle, IPv6-Netz für IoT-Geräte, Beschaffung, Datenbank und Maschinensteuerung. |

## 2. Aufgaben im Detail

### Aufgabe 1 – Markt, Projektschritte, Stakeholder, Personal (23 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| aa | Marktform bei wenigen Anbietern und vielen Nachfragern | nennen | Freitext kurz (ein Begriff) | 1 | ein Satz Marktbeschreibung | Angebotsoligopol. | relevant |
| ab | Marktform bei vielen Anbietern | nennen | Freitext kurz (ein Begriff) | 1 | – | Polypol. | relevant |
| b | Inhalte von Projektschritten (Ist-Zustand, Soll-Konzept, Planung, Umsetzung, Zielprüfung, Ausblick) | beschreiben (je 1 Aspekt) | Tabelle ausfüllen (6 Zellen, Stichpunkte) | 6 | Tabelle mit 7 Schritten, erster Schritt als Beispiel | Z. B. Ist: Schwächen des aktuellen Ablaufs; Soll: Ziel festlegen; Planung: Phasen modellieren; Umsetzung: neue Abläufe einführen; Prüfung: Wirkung messen; Ausblick: weitere Optimierungen festhalten. 1 Punkt je Zelle. | relevant |
| c | Stakeholder und ihr Einfluss | beschreiben (3 Gruppen) | Freitext mittel | 3 | – | Z. B. Anteilseigner (Finanzierungsbereitschaft), Mitarbeiter (Akzeptanz), Lieferanten (Umsetzbarkeit automatischer Bestellungen). 1 Punkt je Gruppe mit Einfluss. | relevant |
| d | Externer Projektberater: Vor- und Nachteile | nennen (zusammen 5, Aufteilung frei) | Freitext kurz in zwei Blöcken | 5 | – | Vorteile: Erfahrung/Spezialisierung, Entlastung des Personals, Methodenkompetenz, bessere Risikoeinschätzung. Nachteile: Kosten, Know-how bleibt außen, Abhängigkeit, kennt interne Abläufe nicht, mehr Schnittstellen, Datenschutzaufwand. | relevant |
| e | Effektiver Stundensatz interner Fachkräfte | berechnen | Rechnung (Rechenweg im Karoraster) | 5 | Jahresdaten: 260 Arbeitstage, 7,8 h/Tag, 30 Urlaubs-, 5 Krankheits-, 5 Feiertage, 140.000 € Jahreskosten; Vergleichssatz extern 85 €/h | Produktive Tage 260 − 30 − 5 − 5 = 220; 220 × 7,8 = 1.716 h; 140.000 / 1.716 = 81,59 €/h. | relevant |
| f | Dienstvertrag oder Werkvertrag | begründet empfehlen | Freitext mittel | 2 | – | Werkvertrag, weil ein Ergebnis geschuldet wird; beim Dienstvertrag nur die Tätigkeit. | relevant |

### Aufgabe 2 – Datenmengen, Speichersysteme, Kennzeichnung (25 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Anzahl Kameraaufnahmen pro Tag | ermitteln | Rechnung mit Rechenweg | 2 | Bandgeschwindigkeit 30,48 m/min, Scanlänge 30,48 cm, 12 h Betrieb pro Tag | 30,48 m / 0,3048 m = 100 Aufnahmen/min; × 60 = 6.000/h; × 12 = 72.000 pro Tag. | relevant |
| ba | Bildgröße eines Scans in MiB | ermitteln | Rechnung mit Rechenweg | 4 | Scanfläche 50,80 cm × 30,48 cm, 400 dpi, 16 Bit Farbtiefe, 1 Zoll = 2,54 cm | 20 Zoll × 400 = 8.000 px; 12 Zoll × 400 = 4.800 px; 38.400.000 Pixel × 16 Bit = 614.400.000 Bit; / 8 = 76.800.000 Byte; / 1.024 = 75.000 KiB; / 1.024 ≈ 73,2 MiB (Lösung nennt 73,25). Je 1 Punkt für Pixel, Bit, Byte; je 0,5 für KiB und MiB. | relevant |
| bb | Datenvolumen pro Tag in TiB | ermitteln, aufrunden | Rechnung mit Rechenweg | 2 | eigene Ergebnisse oder Ersatzwerte (100.000 Scans, 70 MiB) | 72.000 × 73,25 MiB = 5.274.000 MiB; / 1.024 = 5.150,39 GiB; / 1.024 = 5,03 TiB → aufgerundet 6 TiB. Mit Ersatzwerten: 6,68 → 7 TiB. 0,5 Punkte je Rechenschritt. | relevant |
| ca | Nettokapazität RAID 5 mit ungleich großen Platten | berechnen | Rechnung mit Rechenweg, Ergebnisfelder | 4 | 2 Platten à 3 TB, 7 Platten à 2 TB, RAID-Controller | Kleinste Plattengröße bestimmt: (9 − 1) × 2 TB = 16 TB. 2 Punkte für die Erkenntnis „kleinste gemeinsame Kapazität“, 2 Punkte für das Ergebnis. | **gestrichen** (RAID) |
| cb | Kapazität als JBOD | ermitteln | Rechnung mit Rechenweg | 2 | dieselben Platten | 2 × 3 + 7 × 2 = 20 (alle Kapazitäten werden addiert). | gestrichen (RAID-Umfeld) |
| cc | JBOD gegenüber RAID 0 | beschreiben (2 Vorteile) | Freitext mittel | 4 | – | Zwei aus: kein RAID-Controller nötig, volle Nutzung ungleich großer Platten, keine identischen Platten nötig, einfach erweiterbar. 2 Punkte je Vorteil. | **gestrichen** (RAID) |
| d | SAN gegenüber NAS | nennen (3 Vorteile) | Freitext kurz | 3 | – | Drei aus: höhere Performance, blockorientiert und betriebssystemunabhängig, sehr gut skalierbar, zentrale Verwaltung, unterbrechungsfreie Erweiterung, zeitnahe Sicherung. | relevant |
| e | QR-Code und RFID: je Vor- und Nachteil | gegenüberstellen | Tabelle ausfüllen (4 Zellen), Zeile Barcode als Beispiel | 4 | Tabelle | QR: einfach/günstig, viele Daten – aber Sichtkontakt nötig, schmutzempfindlich. RFID: ohne Sichtkontakt lesbar, viele Daten – aber teurer und aufwendiger. 1 Punkt je Zelle. | relevant |

### Aufgabe 3 – IPv6 im IoT-Testnetz, Angebotsvergleich (28 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Vorteile von IPv6 für IoT | nennen (2) | Freitext kurz | 2 | – | Zwei aus: nahezu unbegrenzter Adressraum, weltweite Erreichbarkeit jedes Geräts, integrierte Sicherheit (IPsec), schlankerer Header. | relevant |
| b | IPv6-Adresse zerlegen: 48-Bit-Standortpräfix und 16-Bit-Subnetz-ID ungekürzt | identifizieren und angeben | Kurzangabe (zwei Hex-Werte) | 4 | verkürzte Adresse 2001:da8:5f2d:28::/64 mit Hinweis auf die Aufteilung 48 + 16 Bit | Präfix 2001:0da8:5f2d, Subnetz-ID 0028 (führende Nullen ergänzen). 2 Punkte je Teil. | relevant |
| c | Anzahl möglicher Teilnetze | angeben | Rechnung (einzeilig, Potenz) | 2 | 16 Bit Subnetz-ID | 2^16 = 65.536. | relevant |
| d | IPv6-Adressen und Gateway in einem Netzplan vergeben | vergeben | Diagramm ergänzen: sechs Lücken in einer Netzskizze | 6 | Skizze mit Router (…:29::1/64), Switch (…::2), drei Endgeräten; eine Endgeräteadresse (…::20) vorgegeben; Vorgabe, Endgeräte und Netzgeräte in getrennten Adressbereichen zu halten | Alle Geräte im Netz 2001:da8:5f2d:29::/64, Gateway überall die Routeradresse …::1; freie Endgeräteadressen z. B. …::18 und …::19. Andere stimmige Lösungen zulässig. 1 Punkt je Feld. | relevant |
| e | Erreichbarkeit von Loopback und Gateway prüfen | Befehle angeben (2) | Freitext kurz (Kommandozeile) | 2 | – | ping auf ::1 und ping auf die Gateway-Adresse. | relevant |
| f | Herkunft und Art einer fe80-Adresse | Grund angeben, Adressart benennen | Konsolenausgabe auswerten, Freitext kurz | 2 | Befehl zur Anzeige der Adressen und eine fe80-Adresse | Automatisch erzeugte Link-Local-Adresse (Unicast). | relevant |
| g | Bezugspreis und gewichteter Angebotsvergleich (Nutzwertanalyse) | berechnen, bewerten, entscheiden | Tabelle ausfüllen mit Rechnung (2 Tabellen) | 10 | Angebotstabelle für drei Lieferanten (Listenpreis 1.000/1.100/1.300 €, Lieferbedingungen „ab Werk 15 €“, „frachtfrei“, „frei Haus“, Lieferzeit 5/3/1 Wochen, Qualität, Kundenrückmeldungen); Bewertungstabelle mit Gewichten 11/8/9/5, Skala 1–3 | Bezugspreis: 1.015 € beim ersten Anbieter, 1.300 € beim dritten; die Lösungshinweise zeigen die Bezugspreise nicht einzeln, sondern nur die Rangfolge (günstigster = 3 Punkte). Punkte je Kriterium (Preis/Lieferzeit/Qualität/Erfahrung): Anbieter 1: 3/1/2/1 → 33+8+18+5 = 64; Anbieter 2: 2/2/1/2 → 22+16+9+10 = 57; Anbieter 3: 1/3/3/3 → 11+24+27+15 = 77. Entscheidung für Anbieter 3 trotz höchstem Preis. | relevant |

### Aufgabe 4 – SQL, Steuerungsfunktion, ER-Modell (24 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| aa | SQL: Spalten eines Datensatzes per Schlüssel abfragen | SQL-Befehl angeben | Code schreiben (SQL) | 3 | Tabellenstruktur (fünf Spalten, Primärschlüssel), SQL-Syntaxblatt | SELECT der vier Spalten ohne Schlüssel, FROM, WHERE auf die Auftragsnummer. | **gestrichen** (SQL) |
| ab | SQL: Datensätze mit bestimmter Dicke zählen | SQL-Befehl angeben | Code schreiben (SQL) | 4 | wie aa | COUNT mit Filter auf die Dicke (Lösung über GROUP BY/HAVING; WHERE ist gleichwertig). | **gestrichen** (SQL) |
| ac | SQL: Stückzahlen summieren mit drei Bedingungen | SQL-Befehl angeben | Code schreiben (SQL) | 4 | wie aa | SUM über die Mengenspalte, WHERE mit drei per AND verknüpften Bedingungen. | **gestrichen** (SQL) |
| b | Funktion mit Schleife und Abbruchbedingung (Notaus) | Struktogramm ergänzen | Pseudocode ergänzen: 5 leere Zeilen in vorgegebenem Struktogramm | 7 | Beschreibung von drei API-Funktionen (Maße setzen, ein Stück fertigen, Notaus abfragen), Array mit vier Werten (Index 0–3), Struktogramm mit drei vorgegebenen Kopfzeilen | Maße aus Index 0–2 setzen; Schleife solange Zähler < Stückzahl (Index 3) **und** Notaus nicht ausgelöst; im Rumpf fertigen, Notaus erneut abfragen, Zähler erhöhen. Zeilen mit Maße setzen, Fertigen, Zähler: je 1 Punkt; Schleifenbedingung und erneute Notaus-Abfrage: je 2 Punkte. Reihenfolge im Rumpf frei. | Darstellung **gestrichen** (Struktogramm), Logik weiter relevant |
| c | ER-Modell: Attribute, Primärschlüssel, Kardinalität ergänzen | vervollständigen | Diagramm ergänzen/zeichnen | 6 | Fließtext mit Anforderungen, Rumpfdiagramm (zwei Entitäten, Beziehungsraute, zwei leere Kardinalitätsfelder), Legende Chen-Notation | Maschine: eindeutige Nummer (Schlüssel), Bezeichnung, Baujahr, Spezifikation. Produktionsdaten: Auftragsnummer (Schlüssel), Breite, Länge, Dicke, (Anzahl,) Zeitstempel. Beziehung 1 : n. Kardinalität 1 Punkt, Schlüssel 2 Punkte, Attribute 3 Punkte; Fremdschlüssel nicht verlangt. | relevant (relationale Datenmodellierung) |

## 3. Beobachtungen

**Operatoren und Formulierungen**
- Auffällig viele Rechenaufträge: berechnen/ermitteln 8×, fast immer mit dem Zusatz, dass der Rechenweg anzugeben ist. Nennen 6×, beschreiben 3×, dazu SQL-Befehl angeben 3×.
- Wahlfreiheit bei Aufzählungen: „insgesamt fünf Vor- und/oder Nachteile“.
- Ersatzwerte für Folgerechnungen werden wieder mitgegeben.

**Punkteverteilung**
- Die Lösungshinweise vergeben bei Rechnungen Punkte **je Rechenschritt**, teils in halben Punkten – der Rechenweg ist also selbst die Leistung, nicht nur das Ergebnis.
- Größter Block: gewichteter Angebotsvergleich mit 10 Punkten. Danach Struktogramm (7), Netzskizze (6), ER-Modell (6), Projektschritt-Tabelle (6).
- Kleinste Einheiten: 1 Punkt für einen einzelnen Fachbegriff (Marktform).

**Rechenanteil**
- 31 Punkte Rechnen (Stundensatz, Scans, Bildgröße, Tagesvolumen, RAID, JBOD, Teilnetze, Nutzwertanalyse) – die rechenstärkste der drei Prüfungen.
- Typisch sind Einheitenketten: cm → Zoll → Pixel → Bit → Byte → KiB → MiB → GiB → TiB.

**Materialien**
- Wertelisten, zwei Angebots-/Bewertungstabellen, Netzskizze mit Lücken, Tabellenstruktur, SQL-Syntaxblatt als eingeheftetes Hilfsmittel, Struktogramm-Rumpf, ER-Rumpfdiagramm mit Notationslegende.
- Kein englischer Text, keine Fotos oder Screenshots.

**Stolperfallen**
- Binärpräfixe: durch 1.024 teilen, nicht durch 1.000; Bit → Byte nicht vergessen.
- „Auf volle TiB aufrunden“: 5,03 wird zu 6, nicht zu 5.
- RAID 5 mit gemischten Platten: Die kleinste Platte bestimmt die Kapazität, die 3-TB-Platten zählen nur mit 2 TB.
- Die Lösungshinweise sind stellenweise selbst ungenau (73,25 statt rechnerisch 73,24 MiB; TB und TiB bei JBOD vermischt; Ersatzrechnung mit „100 MiB“ überschrieben, gerechnet wird mit 70 MiB) – Folgefehler und abweichende Rundung werden daher großzügig bewertet.
- Stundensatz: Urlaubs-, Krankheits- und Feiertage zuerst von den Arbeitstagen abziehen.
- Lieferbedingungen: „Ab Werk“ erhöht den Bezugspreis, „frei Haus“ nicht. Beim zweiten Anbieter steht „frachtfrei“ zusammen mit einem Betrag von 10 € – das ist uneindeutig (1.100 oder 1.110 €), ändert die Rangfolge aber nicht. Die Begriffe der Lieferbedingungen muss man kennen.
- Nutzwertanalyse: Der teuerste Anbieter gewinnt; wer nur auf den Preis schaut, entscheidet falsch.
- Struktogramm: Der Notaus-Status muss **in** der Schleife neu abgefragt werden, sonst ändert sich die Abbruchbedingung nie (dafür gibt es 2 der 7 Punkte).
- IPv6: Standardgateway ist die Routeradresse, nicht die des Switches; alle Geräte brauchen dasselbe /64-Präfix.
- Gestrichene Inhalte machen hier 28 von 100 Punkten aus (SQL 11, RAID/JBOD 10, Struktogramm 7) – diese Prüfung ist nur noch teilweise als Vorlage geeignet.
