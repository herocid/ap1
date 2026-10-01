# AP1 Herbst 2021 – Prüfungsanalyse

Quelle: `AP1-2021-Herbst.pdf` (11 Seiten, Scan) und `AP1-2021-Herbst_Lösung.pdf` (13 Seiten, Scan).
Die Aufgaben sind urheberrechtlich geschützt; hier stehen nur Struktur, Thema, Format und
Lösungserwartung in eigenen Worten.

## 1. Kopf

| Merkmal | Wert |
| --- | --- |
| Termin | Mittwoch, 29. September 2021 (erste AP1 nach neuer Ausbildungsordnung 2020) |
| Bearbeitungszeit | 90 Minuten |
| Gesamtpunkte | 100 |
| Anzahl Aufgaben | 4 (23 Teilaufgaben) |
| Punkte je Aufgabe | 25 / 25 / 26 / 24 |
| Hilfsmittel | nicht programmierter, netzunabhängiger Taschenrechner ohne Kommunikationsmöglichkeit; Konzeptpapier aus dem Aufgabensatz (wird nicht bewertet) |
| Bearbeitungsregeln | stichwortartige Antworten zulässig, sofern nicht ausdrücklich ganze Sätze verlangt sind; werden mehr Angaben geliefert als gefordert, zählen nur die ersten; mit gerundeten Zwischenergebnissen wird weitergerechnet |
| Ausgangssituation | Man arbeitet in einem Systemhaus, das den Umzug einer Arztpraxis an einen neuen Standort plant und dabei Teile der IT erneuert. Die vier Aufgaben folgen dem Projekt: Planung/Netzplan, Energiebilanz der Hardware plus Skript, Postfach-Migration und Kundenberatung, Datenschutz/Datensicherung. |
| Art der Lösung | Kein amtlicher IHK-Lösungsbogen, sondern kommentierte Lösungserläuterungen eines Verlags: ausführliche Rechenwege und Erklärungen, aber **keine Punktaufteilung** je Teilleistung. |

## 2. Aufgaben im Detail

Spalte „Katalog 2025“: **relevant** = weiter prüfbar, **gestrichen** = Thema steht auf der Streichliste.

### Aufgabe 1 – Projekt planen, Netzplan vervollständigen (25 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Projektmerkmale | nennen (4) | Freitext kurz | 4 | nur Situationstext | Vier aus: Einmaligkeit/Neuartigkeit, konkretes Ziel, zeitliche Begrenzung, begrenzte Ressourcen, Komplexität/Umfang, eigene Projektorganisation. Vermutlich 1 Punkt je Nennung. | relevant |
| b | SMART-Kriterien | nennen (4) | Lückenschema: Buchstaben M, A, R, T vorgegeben, S als Beispiel ausgefüllt | 4 | Buchstabenraster | messbar, akzeptiert (auch attraktiv/erreichbar), realistisch (auch relevant), terminiert; deutsch oder englisch zulässig. | relevant |
| c | Netzplan: FAZ, FEZ, SAZ, SEZ, Gesamtpuffer, freier Puffer eintragen | eintragen/ergänzen | Diagramm ergänzen (Netzplan ausfüllen) | 14 | Vorgangsliste mit 11 Vorgängen A–K (Dauer in Stunden, Vorgänger), Knotenlegende, vorgezeichneter Netzplan; A und B komplett, C–F teilweise gefüllt, G–K leer; Formeln für FP und GP stehen als Hinweis dabei | Vorwärtsrechnung: A 0–2, B 2–6, C 6–9, D 6–14, E 6–8, F 6–11, G 14–18, H 8–9, I 18–21, J 21–22, K 22–24 (Projektdauer 24 h). Rückwärtsrechnung: K 22–24, J 21–22, I 18–21, G 14–18, H 17–18, D 6–14, C 11–14, E 15–17, F 17–22. Puffer (GP/FP): C 5/5, E 9/0, F 11/11, H 9/9, alle übrigen 0/0. Zusätzlich müssen die Vorgangsbuchstaben G–K den leeren Knoten richtig zugewiesen werden. | relevant |
| d | Kritischer Pfad | markieren | Diagramm ergänzen (Pfad einzeichnen) | 1 | eigener Netzplan aus c | A – B – D – G – I – J – K (alle Vorgänge mit GP = 0 und FP = 0). | relevant |
| e | Auswirkung einer Verzögerung (Vorgang H um 4 h) | beschreiben | Freitext kurz/mittel | 2 | eigener Netzplan | Kein Einfluss auf das Projektende, weil H 9 h Gesamt- und freien Puffer hat und 4 h darunter liegen. Begründung über Puffer wird erwartet. | relevant |

### Aufgabe 2 – Energiebilanz der Hardware, Skriptfehler (25 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Wirkungsgrad Netzteil, Leistungsaufnahme, Energiekosten pro Monat | errechnen | Rechnung mit Rechenweg, Ergebnisse in Tabelle eintragen | 6 | Tabelle mit zwei PCs (Wirkungsgrad 43 % bzw. 76 %, je 60 W Nutzleistung, ein Wert vorgerechnet), Betriebszeit 9 h/Tag an 20 Tagen, 30 ct/kWh, englische Kurzdefinition von „Efficiency“ | Betriebsstunden 20 × 9 = 180 h. Aufnahme PC-B: 60 W / 0,76 = 78,95 W (PC-A: 60 / 0,43 = 139,53 W vorgegeben). Kosten: 180 h × 139,53 W × 0,30 €/kWh = 7,53 €; 180 h × 78,95 W × 0,30 €/kWh = 4,26 €. | relevant |
| b | Amortisationsdauer (Mehrpreis gegen Stromersparnis) | berechnen | Rechnung mit Rechenweg | 4 | Mehrpreis 100 €; Ersatzwerte für a) (6,83 € / 4,78 €) als Hinweis | Ersparnis 7,53 − 4,26 = 3,27 €/Monat; 100 / 3,27 = 30,58 → nach 31 Monaten. Mit Ersatzwerten: 48,78 → 49 Monate. Aufrunden auf volle Monate. | relevant |
| c | Energiesparmaßnahmen am IT-Arbeitsplatz | Vorschläge machen (3) | Freitext kurz | 3 | – | Drei aus z. B.: schaltbare Steckdosen gegen Standby-Verbrauch, energieeffiziente Geräte/Label, Thin Clients bzw. virtualisierte Arbeitsplätze, automatisches Herunterfahren, effiziente Netzteile. Offene Liste. | relevant |
| d | Elektrische Belastbarkeit einer Mehrfachsteckdose (P = U × I) | durch Rechnung nachweisen | Rechnung mit Rechenweg und Schlusssatz | 4 | Geräteliste: 3 PCs je 180 W, Drucker 400 W, Kaffeemaschine 1.200 W, Klimagerät 2.000 W; Aufdruck „max. 16 A“ | Zulässig: 230 V × 16 A = 3.680 W. Bedarf: 3 × 180 + 400 + 1.200 + 2.000 = 4.140 W > 3.680 W → nicht gleichzeitig betreibbar. Netzspannung 230 V muss man selbst wissen. | relevant |
| e | Fehlersuche in einem PowerShell-Skript (freier Speicher in Prozent, Warnung unter 15 %) | korrigieren (2 Fehler) | Code korrigieren: fehlerhafte Zeilen in der rechten Tabellenspalte neu schreiben; dazu englischen Text auswerten | 8 | Skript zeilenweise in einer Tabelle, Fehlerbeschreibung (Warnung trotz 50 % Füllstand), englischer Handbuchauszug mit Vergleichsoperatoren (-eq, -ne, -gt, -ge, -lt, -le) und zwei Cmdlet-Beschreibungen | Fehler 1: Faktor 1000 statt 100 bei der Prozentrechnung. Fehler 2: Vergleich „größer als“ statt „kleiner als“ (-gt → -lt). Vermutlich 4 Punkte je korrigierter Zeile. | relevant (Programmierlogik, Fehlersuche, Englisch) |

### Aufgabe 3 – Postfach-Migration vorbereiten, Kunden beraten (26 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Inhalte eines Lastenhefts | benennen (5) | Freitext kurz | 5 | kurze Einleitung mit Definition Lastenheft | Fünf aus: Projektziele, Ausgangssituation/Ist-Zustand, funktionale Anforderungen, nicht funktionale Anforderungen, Sicherheitsanforderungen, zeitlicher Rahmen, Vorstellung des Auftraggebers. | relevant |
| ba | Gesamtkosten einer Dienstleistung | berechnen | Rechnung mit Rechenweg | 2 | Textaufgabe: 130 €/h, 2 h je Postfach, 20 Postfächer; Öffnungs-/Schließzeiten als Ablenker | 130 × 2 × 20 = 5.200 €. | relevant |
| bb | Dauer in Arbeitstagen bei zwei Personen | ermitteln | Rechnung mit Rechenweg | 2 | 2 Mitarbeiter, 8 h pro Tag | 40 h / 8 h / 2 = 2,5 → aufgerundet 3 Tage. | relevant |
| c | Fernwartung gegenüber Vor-Ort-Wartung | nennen (2 Vorteile, 2 Nachteile) | Freitext kurz | 4 | – | Vorteile z. B. keine Fahrtkosten, umweltschonender, Spezialisten leicht zuschaltbar. Nachteile z. B. Datenschutzrisiko bei Patientendaten, Kosten für gesicherte Verbindung, keine Hilfe bei Verbindungsausfall, erschwerte Kommunikation. | relevant |
| d | Schulungsformen (Schulung am Arbeitsplatz, Webinar, Video-Tutorial, Multiplikatoren-Schulung) | beschreiben (3 von 4 wählen) | Freitext lang, je vorgegebenem Begriff zwei bis drei Zeilen | 6 | vier vorgegebene Begriffe | Je Form eine kurze Beschreibung des Ablaufs und der Besonderheit (z. B. Webinar: fester Termin online mit Fragemöglichkeit; Video: zeitlich flexibel, keine Interaktion; Multiplikator: wenige Geschulte geben Wissen weiter). 2 Punkte je Form. | relevant |
| e | RAID 0, 1, 5 erklären und Empfehlung begründen | erklären und begründen | Freitext lang (elf Zeilen) | 7 | Anforderungen des Kunden im Text: Ausfall einer Platte abfangen, Nutzkapazität soll nicht stark sinken | RAID 0: keine Redundanz, schnell, Ausfall = Datenverlust. RAID 1: Spiegelung, nur 50 % nutzbar. RAID 5: verteilte Parität, mind. 3 Platten, bei 3 Platten rund ein Drittel Verlust, verkraftet einen Ausfall. Empfehlung RAID 5. | **gestrichen** (RAID) |

### Aufgabe 4 – Datenschutz und Datensicherung (24 Punkte)

| Teil | Thema | Operator | Antwortformat | Pkt. | Gegebenes Material | Erwartung der Lösung | Katalog 2025 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| a | Schutzziele (Vertraulichkeit, Integrität, Verfügbarkeit) den Maßnahmen zuordnen | ankreuzen und begründen | Zuordnung (ein Kreuz je Zeile) plus Kurzbegründung in Tabelle | 6 | Tabelle mit fünf Maßnahmen, erste Zeile als Beispiel gelöst → vier zu bearbeiten | Datensicherung → Verfügbarkeit; Festplattenverschlüsselung → Vertraulichkeit; zentrale Dokumentbearbeitung auf dem Server → Integrität; Hashwertprüfung bei Installation → Integrität. Je Zeile Kreuz plus Begründung; andere Zuordnung bei schlüssiger Begründung möglich. | relevant |
| b | BSI-Grundschutz: Maßnahmen zu „Autoupdate“ und „Rollentrennung“ | je eine Maßnahme nennen | Freitext kurz | 2 | zwei vorgegebene Anforderungen | Automatische Updates für Betriebssystem/Virensignaturen aktivieren; Rollen-/Rechtekonzept nach dem Prinzip der geringsten Rechte, Administration nur durch Admin-Konten. | relevant |
| c | Schutzbedarfsfeststellung begründen | Begründung hinzufügen | Tabelle ausfüllen (Freitext in Zellen) | 6 | Tabelle der drei Schutzbedarfskategorien; Tabelle mit vier Anwendungen, Schutzziel und Kategorie vorgegeben, erste Zeile als Beispiel | Drei Begründungen: Textverarbeitung/Verfügbarkeit mittel (Ausfall überbrückbar, Arbeit nachholbar); Telemedizin/Vertraulichkeit hoch (vertrauliche Patientendaten); Patientendaten/Integrität sehr hoch (falsche Daten gefährden Behandlung). 2 Punkte je Zeile. | relevant |
| d | Besonders geschützte Daten und Rechtsgrundlage | Auskunft geben und benennen | Freitext kurz | 2 | – | Personenbezogene Daten, hier Patienten-/Gesundheitsdaten; Rechtsgrundlage DSGVO bzw. BDSG. | relevant |
| e | Kriterien sicherer Passwörter mit Wirkung | anführen (2) und beschreiben | Freitext lang | 4 | – | Zwei aus: ausreichende Länge (erschwert Brute Force), großer Zeichenvorrat, kein persönlicher Bezug, keine Wörterbuchwörter, je Zugang ein eigenes Passwort. Je Kriterium 1 Punkt Nennung + 1 Punkt Wirkung. | relevant |
| fa | Risiken eines schwachen Backup-Konzepts (wöchentlich, auf Partition derselben Platte) | beschreiben (2) | Freitext mittel | 2 | Kurzbeschreibung des Ist-Zustands | Zwei aus: bis zu sechs Tage Datenverlust, Sicherung liegt auf demselben Datenträger (ein Defekt trifft beide), keine räumliche Trennung (Brand, Diebstahl). | relevant |
| fb | Verbesserungsvorschlag Datensicherung | Vorschlag unterbreiten | Freitext mittel | 2 | – | Z. B. wöchentliche Vollsicherung plus tägliche inkrementelle Sicherung, auf externes Medium, räumlich getrennt aufbewahrt. | relevant |

## 3. Beobachtungen

**Operatoren und Formulierungen**
- Durchgängig Handlungssituation in der Du-/Sie-Rolle („Sie sind Mitarbeiter …“, „Ihr Kollege bittet Sie …“). Jede Teilaufgabe beginnt mit ein bis drei Sätzen Kontext, dann folgt genau ein Arbeitsauftrag mit Operator und Anzahl.
- Häufigste Operatoren: nennen/benennen (7×), beschreiben (4×), berechnen/errechnen/ermitteln (5×), dazu je einmal eintragen, markieren, korrigieren, nachweisen, erklären + begründen, zuordnen + begründen.
- Die verlangte Anzahl steht fast immer im Auftrag („vier Merkmale“, „zwei Vorteile sowie zwei Nachteile“, „drei von vier“).

**Punkteverteilung**
- 1 Punkt je Nennung, 2 Punkte je beschriebener/begründeter Einheit. Teilaufgaben haben meist 2–6 Punkte.
- Ein einzelner großer Block: der Netzplan mit 14 Punkten (plus 3 Folgepunkte) – allein 17 % der Prüfung.
- Zweitgrößter Block: Skriptkorrektur mit 8 Punkten für zwei Fehler.

**Rechenanteil**
- 18 Punkte reine Rechenaufgaben (Energie, Amortisation, Strombelastung, Kosten, Dauer) plus 14 Punkte Netzplan-Rechnung = knapp ein Drittel der Punkte.
- Alle Rechnungen sind ein- bis dreischrittig, aber mit Einheitenwechsel (W → kWh, ct → €) und Rundungsvorgabe.
- Ersatzwerte für Folgeaufgaben werden mitgeliefert („falls Sie a) nicht lösen konnten, rechnen Sie mit …“).

**Materialien**
- Vorgangsliste und halb ausgefüllter Netzplan, Wertetabellen, Karoraster für Rechenwege, Skript in zweispaltiger Tabelle, englischer Handbuchauszug, Tabellen mit Beispielzeile.
- Fast jede Tabelle enthält eine bereits gelöste Beispielzeile, die Stil und Umfang der erwarteten Antwort vorgibt.

**Stolperfallen**
- Wirkungsgrad: Nutzleistung muss durch den Wirkungsgrad **geteilt** werden (nicht multipliziert).
- Amortisation und Arbeitstage müssen **aufgerundet** werden (31 statt 30,58; 3 statt 2,5).
- 230 V Netzspannung steht nicht in der Aufgabe.
- Ablenker im Text: Öffnungszeiten der Praxis sind für die Kostenrechnung unerheblich.
- Netzplan: freier Puffer von E ist 0, obwohl der Gesamtpuffer 9 beträgt (Nachfolger H startet direkt); bei G zählt der größere Vorgänger-FEZ (14 von D, nicht 9 von C).
- Skript: zwei verschiedene Fehlerarten (Rechenfaktor und Vergleichsoperator); die Lösung ergibt sich nur mit dem englischen Operatorenblatt.
- Mehr Nennungen als verlangt bringen nichts – nur die ersten werden gewertet.
