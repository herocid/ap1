# AP1 Frühjahr 2024 - Analyse

Quelle: `AP1 Frühjahr 2024.pdf` (10 Seiten, abfotografiert, mit Textebene) und
`AP1 Frühjahr 2024 Lösung.pdf` (offizielle Lösungshinweise, 4 Seiten, abfotografiert). Die
Dateinamen enthalten auf der Platte zerlegte Umlaute (`Fru╠êhjahr`, `Lo╠êsung`). Aufgaben sind in
eigenen Worten beschrieben, nicht zitiert.

## Kopf

| Merkmal | Wert |
| --- | --- |
| Termin | Mittwoch, 28. Februar 2024 |
| Bearbeitungszeit | 90 Minuten |
| Gesamtpunkte | 100 |
| Aufgaben | 4 (ohne Belegsatz) |
| Punkte je Aufgabe | 26 / 24 / 24 / 26 |
| Hilfsmittel | nicht programmierbarer, netzunabhängiger Taschenrechner ohne Kommunikationsmöglichkeit; Konzeptpapier |

Ausgangssituation: Man ist Auszubildender in der IT-Abteilung eines Herstellers von
Kunststoffteilen nach Kundenwunsch. Dort werden fünf CAD-Arbeitsplätze beschafft, eingerichtet, ins
Netz gebracht und abgesichert.

## Aufgabe 1 - Angebotsauswahl, Kosten, Anschlüsse, Kaufvertrag (26 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| aa | Nutzwertanalyse für vier Anbieter mit vier Kriterien (Grafikkarte 20, RAM 25, Monitor 40, Preis ?) vervollständigen, Rangfolge bilden | ermitteln | Tabelle ausfüllen mit Rechnung (6 Lücken: Punkte, gewichtete Werte, ein Gewicht, Summen) + Rangfolge | 4 | Matrix mit Lücken; Hinweis, dass Anbieter 3 nur eine SaaS-Lösung liefert | Fehlendes Gewicht 15 (Rest auf 100), fehlende Punkte durch Rückrechnen (gewichteter Wert / Gewicht), Summen 285 / 215 / 355 / 310. Rangfolge 3 - 4 - 1 - 2. 0,5 P je Zahl, 1 P Rangfolge; Folgefehler werden berücksichtigt. | relevant |
| ab | Auswahl unter der neuen Bedingung „nur on-premise“ | auswählen | Freitext kurz (Entscheidung mit Ausschlussgrund) | 2 | eigene Tabelle, Zusatzbedingung | Anbieter 4. 1 P für die Wahl, 1 P für den Ausschluss von Anbieter 3 wegen der KO-Bedingung. | relevant |
| b | Laufende Monatskosten für fünf Arbeitsplätze | berechnen | Rechnung mit Rechenweg (Rechenkästchen) | 7 | Angebot: Monitor 450 EUR, PC 720 EUR, Software 50 EUR je Monat und Platz, Wartung 1.200 EUR je Jahr, 5 % Rabatt auf Hardware; Nutzungsdauer 4 bzw. 3 Jahre | Monitore: 5 x 450 - 5 % = 2.137,50 / 48 = 44,53 EUR (2 P). PCs: 5 x 720 - 5 % = 3.420 / 36 = 95,00 EUR (2 P). Wartung 100 EUR (1 P). Software 250 EUR (1 P). Summe 489,53 EUR (1 P, Folgefehler zählen). | relevant |
| c | Monitoranschlüsse erkennen (HDMI, USB-C, DVI, DisplayPort) | zuordnen | Zuordnung: 4 Begriffe zu 4 nummerierten Abbildungen | 4 | Piktogramme von vier Buchsen/Steckern | DVI = 1, DisplayPort = 2, HDMI = 3, USB-C = 4. 1 P je Zuordnung. | relevant |
| d | Zeitpunkt des Vertragsschlusses bei Bestellung ohne Auftragsbestätigung | erläutern, begründen | Freitext kurz | 2 | drei Daten: Bestellung, Lieferung, Rechnung | Vertrag kommt mit der Lieferung zustande (1 P): Bestellung = Antrag, Lieferung = Annahme durch schlüssiges Handeln (1 P). | relevant |
| e | Inhalte eines Kaufvertrags (nicht die Willenserklärungen) | nennen | Freitext kurz (3) | 3 | - | Kaufgegenstand, Menge, Preis, Zahlungs- und Lieferbedingungen, Liefertermin. 1 P je Nennung. | relevant |
| fa | Kaufvertragsstörungen | nennen | Freitext kurz (2) | 2 | - | Lieferverzug, mangelhafte Lieferung. | relevant |
| fb | Je Störung eine vorbeugende bzw. reagierende Maßnahme des Käufers | angeben | Freitext kurz (2) | 2 | eigene Antwort aus fa | Verzug: mahnen, Lieferkette prüfen. Mangel: Ware sofort prüfen, Lieferanten sorgfältig auswählen, Konventionalstrafe vereinbaren. Andere Maßnahmen möglich. | relevant |

## Aufgabe 2 - Netzwerkeinstellungen prüfen (24 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Bedeutung der LED an der Netzwerkbuchse (Dauerlicht / Blinken) | interpretieren | Freitext lang (zwei vorgegebene Satzanfänge) | 4 | Foto einer RJ45-Buchse | Dauerlicht: physische Verbindung (Link) zum Switch steht, evtl. Anzeige der Geschwindigkeit. Blinken: Daten werden übertragen. Herstellerabhängige Antworten zulässig. | relevant |
| b | OSI-Schichten 7, 3, 2, 1 benennen und vier Begriffe zuordnen (MAC-Adresse, DHCP, IPv6-Adresse, Buchse) | benennen, zuordnen | Tabelle ausfüllen (Schichtname + Begriff, Schicht 4 als Beispiel) | 4 | Ausschnitt einer `ipconfig /all`-Ausgabe, Tabelle mit Beispielzeile | 7 Anwendung - DHCP; 3 Vermittlung - IPv6-Adresse; 2 Sicherung - MAC-Adresse; 1 Bitübertragung - Buchse. Deutsch oder Englisch. | relevant |
| c | Link-lokale IPv6-Adresse analysieren | nennen | Kurzantwort mit konkreten Werten (4 Felder) | 5 | IPv6-Adresse aus der Ausgabe | Länge 128 Bit (1 P); ungekürzt `fe80:0000:0000:0000:521a:c5ff:fef2:38b7` (2 P); Präfixlänge 64 (1 P); Interface-Identifier = die letzten vier Blöcke (1 P). | relevant |
| d | Was der DHCP-Server dem Client liefert | nennen | Kurzantwort aus Material | 2 | `ipconfig`-Ausgabe (wiederholt) | IPv4-Adresse und Subnetzmaske; die konkreten Werte zählen ebenfalls. | relevant |
| e | Aufgabe von ARP | erläutern | Freitext lang, am Beispiel | 3 | Ausgabe von `arp -a` (eine Zeile: IP, MAC, Typ dynamisch) | Zu einer IP-Adresse im LAN wird die zugehörige MAC-Adresse ermittelt - mit den Werten aus der Abbildung. | relevant |
| f | Erreichbarkeit einer IP prüfen | angeben | Kurzantwort (Befehl) | 2 | wie e | `ping` mit der Ziel-IP; `tracert` oder ähnliche Befehle gelten. | relevant |
| g | IP- und MAC-Adressen den beiden Rechnern zuordnen | zuordnen | Zuordnung/Lückenfelder in einer Skizze (4 Felder) | 4 | Skizze mit zwei PCs, Werte aus beiden Ausgaben | Eigener PC: IP und MAC aus `ipconfig`; anderer PC: IP und MAC aus der ARP-Tabelle. | relevant |

## Aufgabe 3 - Dateiformat, Speicherbedarf, Netzteil, Stromkosten (24 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Wege der Informationsbeschaffung zu einem unbekannten Dateiformat | nennen | Freitext kurz (3) | 3 | - | Suchmaschine, Foren, Hersteller fragen, Fachliteratur, Handbuch, KI-Chatbot. | relevant |
| b | Fremdes 3D-Format im eigenen CAD-System nutzbar machen | nennen | Freitext kurz (1) | 2 | - | Import-/Exportfunktion, Konverter nutzen oder selbst schreiben. | relevant |
| c | Textdatei (ASCII) gegen Binärdatei | erläutern | Freitext lang | 4 | - | ASCII: Zeichen, mit jedem Editor les- und änderbar (2 P). Binär: nur mit passender Anwendung verarbeitbar (2 P). | relevant |
| da | Speicherbedarf von 3.840 Punkten mit je drei 32-Bit-Koordinaten in KiB | berechnen | Rechnung mit Rechenweg | 3 | Angaben im Text | 3 x 4 Byte x 3.840 = 46.080 Byte / 1.024 = 45 KiB. | relevant |
| db | Anzahl darstellbarer Farben bei 3 x 8 Bit | berechnen | Rechnung | 2 | - | 256 x 256 x 256 = 2^24 = 16.777.216. | relevant |
| dc | Prozentualer Mehrbedarf je Punkt durch die Farbe | berechnen | Rechnung | 3 | - | 12 Byte -> 15 Byte, also 3 / 12 = 25 % mehr. | relevant |
| e | Netzteil dimensionieren | berechnen, benennen | Rechnung mit Rechenweg + Auswahl | 4 | Komponententabelle (Leistung je Stück, Anzahl), Netzteile in 50-W-Schritten von 400 bis 1.200 W, 10 % Puffer | 20 + 172 + 12 + 4 x 5 + 310 + 2 x 5 + 2 x 8 = 560 W; + 10 % = 616 W; nächstgrößeres Netzteil 650 W. 3 P Rechnung, 1 P Auswahl. | relevant |
| f | Jährliche Stromkosten | berechnen | Rechnung mit Rechenweg | 3 | 200 Tage x 9 h, Wirkungsgrad 90 %, Auslastung 50 %, 0,40 EUR/kWh; Ersatzwert 750 W falls e fehlt | 1.800 h x (0,650 kW / 0,9) x 0,5 x 0,40 = 260,00 EUR; mit Ersatzwert 300,00 EUR. | relevant |

## Aufgabe 4 - Mobiles Arbeiten, Datensicherung, Malware, Übertragungsdauer (26 Punkte)

| Teil | Thema | Operator | Antwortformat | P | Material | Erwartung der Musterlösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Geheimhaltung beim Arbeiten unterwegs: Maßnahme und Folge bei Nichtbeachtung | nennen, ergänzen | Tabelle ausfüllen (3 Zeilen x 2 Spalten, Beispielzeile vorgegeben) | 6 | Tabelle mit Beispiel | Z. B. Zugangsschutz/Passwort - Unbefugte nutzen das Gerät; Verschlüsselung - Daten lesbar; lokale Sicherung - Verfügbarkeit verloren; VPN - Übertragung abgreifbar. Weitere sinnvolle Lösungen möglich. | relevant |
| b | Funktionsweise VPN | erklären | Freitext kurz | 2 | - | Verschlüsselte, für Dritte nicht einsehbare Verbindung über ein öffentliches Netz ins entfernte Netz. | relevant |
| c | Tagesvollsicherung auf mehrere externe Festplatten | nennen | Freitext kurz (3 Aspekte) | 3 | - | Datenträger verschlüsseln, in fester Reihenfolge rotieren, nach dem letzten wieder mit dem ersten beginnen; Generationenprinzip als Stichwort zulässig. | relevant |
| da | Arten von Malware | nennen | Freitext kurz (3) | 3 | - | Virus, Wurm, Trojaner, Spyware, Adware, Backdoor, Scareware, Ransomware, Keylogger ... 1 P je Art. | relevant |
| db | Je Art ein typisches Merkmal | zuordnen, beschreiben | Freitext kurz (3) | 3 | eigene Antwort aus da | Z. B. Virus befällt Programme, Wurm verbreitet sich selbstständig, Trojaner tarnt sich als nützliche Software, Ransomware verschlüsselt und erpresst. 1 P je Merkmal. | relevant |
| e | Weitere Schutzmaßnahmen gegen Malware (neben Virenscanner) | erläutern | Freitext kurz (3) | 3 | - | Keine fremden Datenträger, keine Downloads aus unsicheren Quellen, keine aktiven Inhalte/Makros ausführen, Updates, Mitarbeiter sensibilisieren. | relevant |
| f | Übertragungsdauer für 1 GiB bei gemessener Upload-Rate | berechnen | Rechnung mit Rechenweg, Ergebnis aufrunden und in min + s angeben | 6 | Speedtest-Ergebnis mit Download 75,78 Mbit/s und Upload 50,02 Mbit/s | 1 x 1.024^3 x 8 Bit / (50,02 x 1.000.000 Bit/s) = 171,73 s -> 172 s = 2 min 52 s. Je 1 P für: GiB in Byte, Byte in Bit, Mbit/s in Bit/s, Division, Ergebnis, Umrechnung in min/s. Teilpunkte möglich. | relevant |

## Beobachtungen

- **Operatoren:** nennen (11x), berechnen (7x), erläutern/erklären (5x), zuordnen (3x), angeben
  (2x), ermitteln, auswählen, interpretieren, benennen.
- **Punkteverteilung:** 30 Teilaufgaben; fast durchgehend 1 P je Nennung. Rechenaufgaben werden
  schrittweise bepunktet (jeder Umrechnungsschritt ein Punkt), Folgefehler und ein vorgegebener
  Ersatzwert verhindern Punktketten-Verluste.
- **Rechnen:** rund 32 Punkte in acht Aufgaben - die rechenlastigste der drei Prüfungen, diesmal
  überwiegend technisch (Speicher, Farbtiefe, Leistung, Stromkosten, Datenrate) plus eine
  Kostenrechnung und eine Nutzwertanalyse.
- **Materialien:** Nutzwertmatrix mit Lücken, Angebot, Piktogramme von Anschlüssen, Foto einer
  Netzwerkbuchse, Konsolenausgaben (`ipconfig /all`, `arp -a`), Skizze mit zwei PCs,
  Komponententabelle, Speedtest-Anzeige, Tabellen mit Beispielzeile. Kein englischer Text, kein
  UML, kein SQL, kein Code.
- **Stil:** stark handlungsorientiert; mehrere Teilaufgaben greifen auf dasselbe Material zu (die
  Konsolenausgabe wird im Heft sogar wiederholt abgedruckt).
- **Stolperfallen:**
  - Nutzwertanalyse rückwärts: fehlende Punkte aus gewichtetem Wert und Gewicht errechnen; das
    fehlende Gewicht ergibt sich aus der Summe 100.
  - KO-Kriterium schlägt die höchste Punktzahl.
  - Monatskosten: Rabatt nur auf Hardware, Monitore und PCs haben verschiedene Nutzungsdauern,
    Wartung ist ein Jahresbetrag für alle Geräte, Software gilt je Platz.
  - Vertragsschluss durch Lieferung, nicht durch Bestellung oder Rechnung.
  - DHCP gehört auf Schicht 7, die IP-Adresse auf Schicht 3, die MAC-Adresse auf Schicht 2.
  - IPv6: `::` richtig mit Nullblöcken auffüllen, führende Nullen ergänzen.
  - Speicher: Bit in Byte, dann durch 1.024 (KiB), nicht durch 1.000.
  - Netzteil: Stückzahlen beachten, erst Puffer aufschlagen, dann auf die nächste Stufe aufrunden.
  - Stromkosten: durch den Wirkungsgrad teilen (Aufnahme aus dem Netz ist höher), dann Auslastung.
  - Übertragungsdauer: Upload statt Download nehmen; GiB binär (1.024^3), Mbit/s dezimal (10^6);
    aufrunden statt kaufmännisch runden.
- **Katalog 2025:** keine gestrichenen Inhalte - alle 100 Punkte bleiben relevant.
