# AP1 Frühjahr 2025 - Analyse

Quelle: `AP1-2025-Frühjahr.pdf` (12 Seiten, Scan, gut lesbar). **Es liegt keine Musterlösung vor.**
Alle Angaben in der Spalte „Erwartung“ sind **eigene Lösungen** (fachlich hergeleitet, an den
Bewertungsmustern der Lösungshinweise Herbst 2025 und Frühjahr 2026 orientiert). Aufgaben sind in
eigenen Worten beschrieben, nicht zitiert.

## 1. Kopf

| Merkmal | Wert |
| --- | --- |
| Termin | Dienstag, 25. März 2025 |
| Prüfung | Teil 1 der Abschlussprüfung, „Einrichten eines IT-gestützten Arbeitsplatzes“ (Bogen 1202, FISI; inhaltsgleich für alle IT-Berufe) |
| Bearbeitungszeit | 90 Minuten |
| Gesamtpunkte | 100 |
| Aufgaben | 4 (ungleich gewichtet): **25 / 20 / 30 / 25** Punkte |
| Teilaufgaben | 30 |
| Hilfsmittel | nicht programmierbarer, netzunabhängiger Taschenrechner ohne Kommunikationsmöglichkeit; beigelegtes Konzeptpapier (wird nicht bewertet) |
| Bearbeitungsregeln | Stichworte reichen, sofern nicht ganze Sätze verlangt sind; werden mehr Antworten gegeben als verlangt, zählen nur die ersten; mit gerundeten Zwischenergebnissen weiterrechnen |
| Ausgangssituation | Drei Rechtsanwälte gründen eine Gemeinschaftskanzlei. Der Prüfling arbeitet bei einem IT-Beratungshaus, das die Kanzlei ausstattet: Multifunktionsgerät, sichere E-Mail, Website, KI-Einsatz. |

Die vier Aufgaben sind im Kasten der Ausgangssituation als Themenliste angekündigt
(Gerät auswählen und anschließen / Datensicherheit im E-Mail-Verkehr / Website / KI).

## 2. Aufgaben

### Aufgabe 1 - Multifunktionsgerät auswählen und anschließen (25 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung (eigene Lösung) |
| --- | --- | --- | --- | --- | --- | --- |
| aa | Entscheidungsmatrix (Rangfolge-Nutzwert ohne Gewichtung) für drei Geräte | vervollständigen, bestimmen | Tabelle ausfüllen (4 Kriterien x 3 Geräte + Summenzeile) | 6 | Datentabelle mit 6 Kriterien (Druck-/Scantempo, dpi, Wartung, Toner, Preis); Matrix nutzt nur 4 davon | Rang 3 = bester, 1 = schlechtester Wert je Zeile. Druck 40/62/50 S./min -> 1/3/2; Scan 20/50/40 -> 1/3/2; Wartung 50/10/15 EUR -> 1/3/2; Preis 3.456/2.844/1.656 EUR -> 1/2/3. Summen **4 / 11 / 9**. Vermutlich 1 P. je Zeile plus Summen. |
| ab | Auswahl aus der Matrix ablesen | nennen | Freitext kurz | 1 | eigene Matrix | Gerät 2 (höchste Summe). Folgefehler aus aa wären zu akzeptieren. |
| ac | Monatskosten bei Kauf und 36 Monaten Nutzung | berechnen (mit Rechenweg, auf ganze EUR runden) | Rechnung im Karoraster | 3 | Seitenpreise 0,05 EUR s/w und 0,07 EUR Farbe; Druckvolumen 2.000 s/w + 500 Farbe aus dem Einleitungstext | Anschaffung 2.844 / 36 = 79,00 EUR; Druck 2.000 x 0,05 + 500 x 0,07 = 135,00 EUR; Summe **214 EUR/Monat**. Wer die Wartung (10 EUR) zusätzlich ansetzt, kommt auf 224 EUR - die Formulierung „Kosten für den Druck komplett“ spricht für 214. |
| b | Anschlüsse erkennen: RJ45, USB-A, USB-C, Kaltgerätebuchse | zuordnen | Zuordnung Begriff -> Bildnummer | 4 | vier Piktogramme | RJ45 = 2, USB-A = 1, USB-C = 4, Kaltgerät = 3. Je 1 P. |
| c | Funksymbole erkennen | benennen | Freitext kurz | 2 | zwei Piktogramme | WLAN (Wi-Fi) und Bluetooth, je 1 P. |
| d | Subnetting /26: vorletzte nutzbare Hostadresse | ergänzen | Wert in Netzskizze eintragen | 2 | Netz 192.168.100.0/26 mit zwei PCs (.21, .42) | /26 = 64 Adressen, Bereich .0-.63, Broadcast .63, letzter Host .62 (Gateway), vorletzter **192.168.100.61**. |
| ea | Sicherheitsmaßnahmen aus englischem Herstellertext | nennen (vier) | englischen Text auswerten, Stichworte deutsch | 4 | ca. 9 Zeilen Englisch | Im Text stecken fünf Maßnahmen: Sicherheits-Baseline einspielen, starke/einzigartige Passwörter, eingebaute Firewall aktivieren, regelmäßige/automatische Updates, Speicherintegrität (Schutz vor Code-Injektion). Je 1 P. für vier davon. |
| eb | Warum nicht alle Nutzer Adminrechte bekommen | erläutern (einen Grund) | Freitext lang | 3 | Kurzszenario | Prinzip der minimalen Rechte: Schadsoftware läuft mit den Rechten des Nutzers und könnte sich systemweit installieren; Nutzer können Schutzmechanismen abschalten oder versehentlich Systemeinstellungen ändern. Grund + Folge = volle Punkte. |

### Aufgabe 2 - Datensicherheit im E-Mail-Verkehr (20 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung (eigene Lösung) |
| --- | --- | --- | --- | --- | --- | --- |
| aa | Rechtsgrundlage für erhöhte Sicherheitsanforderungen (Anwalt-Mandant) | nennen | Freitext kurz | 1 | - | DSGVO oder BDSG; berufsbezogen auch anwaltliche Verschwiegenheit (§ 203 StGB, BRAO). |
| ab | Zweck dieser Rechtsgrundlage | beschreiben | Freitext lang | 2 | - | Schutz personenbezogener Daten und des Rechts auf informationelle Selbstbestimmung; Verarbeitung nur zweckgebunden und geschützt vor unbefugtem Zugriff. |
| ba | Ablauf asymmetrische Ver- und Entschlüsselung | beschreiben anhand Skizze | Freitext lang | 4 | Skizze: Absender/Empfänger, je privates und öffentliches Schlüsselsymbol, Brief/verschlossener Brief | Absender verschlüsselt mit dem **öffentlichen Schlüssel des Empfängers**; verschlüsselte Nachricht wird übertragen; Empfänger entschlüsselt mit **seinem privaten Schlüssel**; nur er besitzt ihn. Vermutlich 2 P. je Seite. |
| bb | Erreichtes Schutzziel | nennen | Freitext kurz | 1 | - | Vertraulichkeit. |
| bc | Asymmetrisch vs. symmetrisch | nennen (1 Vorteil, 1 Nachteil) | Freitext kurz | 2 | - | Vorteil: kein geheimer Schlüsselaustausch nötig / weniger Schlüssel. Nachteil: rechenaufwendiger, langsamer. |
| c | Open Source vs. proprietär | nennen (je zwei Vorteile) | Freitext kurz | 4 | - | Open Source: keine Lizenzkosten, Quellcode einsehbar/anpassbar, keine Herstellerbindung. Proprietär: Herstellersupport/Gewährleistung, gute Integration ins Betriebssystem, geregelte Updates. Je 1 P. |
| da | Zweck eines SHA-256-Hashwerts beim Download | erläutern | Freitext lang | 4 | Tabelle Dateiname + Hashwert | Nach dem Download Hash selbst berechnen und vergleichen; gleich = Datei unverändert und vollständig (Integrität), ungleich = manipuliert oder beschädigt -> nicht installieren. |
| db | IMAP statt POP3 | begründen | Freitext lang | 2 | - | Mails bleiben auf dem Server und werden synchronisiert -> gleiche Sicht auf mehreren Geräten, Ordner serverseitig, zentral sicherbar. |

### Aufgabe 3 - Aufbau und Betrieb einer Website (30 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung (eigene Lösung) |
| --- | --- | --- | --- | --- | --- | --- |
| aa | Netzplan vervollständigen (FAZ, FEZ, SAZ, SEZ, GP, FP) | eintragen | Netzplan ergänzen (ganzseitig, quer gedruckt) | 9 | Vorgangsliste A-J mit Dauer (h) und Vorgängern; Knoten A-E vorausgefüllt, G mit FAZ und Dauer; Formeln für GP und FP sind abgedruckt | F: 137/152, SAZ 138, SEZ 153, GP 1, FP 1. G: 27/35, SAZ 143, SEZ 151, GP 116, FP 0. H: 35/37, SAZ 151, SEZ 153, GP 116, FP 116. I: 137/153, SAZ 137, SEZ 153, GP 0, FP 0. J: 153/157, SAZ 153, SEZ 157, GP 0, FP 0. Projektdauer 157 h. |
| ab | Kritischer Pfad | nennen | Freitext kurz | 1 | eigener Netzplan | A - B - D - E - I - J. |
| b | Dynamische vs. statische Website | erläutern (Unterschied) | Freitext lang | 3 | - | Statisch: feste Dateien, jeder sieht dasselbe. Dynamisch: Seite wird bei Aufruf serverseitig (oft aus Datenbank) erzeugt, Inhalte nutzer-/eingabeabhängig, pflegbar über CMS. |
| c | Sprachen für dynamische Webinhalte | nennen (drei) | Freitext kurz | 3 | - | z. B. PHP, JavaScript, Python, Java, C#, Ruby. Je 1 P. |
| d | Schreibtischtest einer Python-Funktion mit drei Rückgabewerten | berechnen (zwei Nachkommastellen) | Code lesen + Rechnung | 6 | 5 Zeilen Python, ein Aufruf mit vier Zahlen | 33.000 / 12.000 = **2,75**; 5.562 / 12.000 x 100 = **46,35**; (12.000 - 7.554) / 12.000 x 100 = **37,05**. Je 2 P. |
| e | Pseudocode mit vierfach verschachtelter Verzweigung auswerten | angeben (Rückgabe für zwei Aufrufe) | Code lesen, Ergebnisstring notieren | 8 | ca. 28 Zeilen deutscher Pseudocode (Wenn/Sonst, wenn/Sonst) | Aufruf 1 (1.5, wahr, wahr, 80): 80 > 80 ist falsch, 80 > 50 wahr -> Ergebnis „Gut“-Zweig mit SEO-Hinweis. Aufruf 2 (3.0, wahr, falsch, 45): Ladezeit nicht < 2, HTML valide, nicht mobilfreundlich -> „langsam und nicht mobilfreundlich“. Je 4 P. |

### Aufgabe 4 - KI-Einsatz vorbereiten (25 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung (eigene Lösung) |
| --- | --- | --- | --- | --- | --- | --- |
| a | KI-Einsatz in einem Geschäftsprozess | auswählen (drei Schritte), beschreiben | Tabelle ausfüllen (Prozessschritt -> KI-Möglichkeit) | 6 | Ablauf in 5 Schritten, englische Kurzdefinition von KI (2 Sätze), ein Beispiel vorgegeben | z. B. Spracherkennung/Zusammenfassung bei der Fallerfassung, automatische Terminvorschläge aus Kalendern, Recherche ähnlicher Urteile, Vorbereitung von Unterlagen für das Erstgespräch. 2 P. je Schritt. |
| b | Vorteil von KI für skeptische Mitarbeiter | erläutern (einen) | Freitext lang | 2 | - | Entlastung von Routinearbeit, mehr Zeit für anspruchsvolle Aufgaben, weniger Fehler. |
| c | Jahreskosten eines KI-Chatbots inkl. entgangenem Umsatz | errechnen | Rechnung im Karoraster | 4 | 100 EUR/Nutzer/Monat, Pflichtschulung 1.800 EUR/Jahr (3 h), Stundensatz 200 EUR, 3 Anwälte | Lizenz 3 x 100 x 12 = 3.600 EUR; Schulung 1.800 EUR; entgangener Umsatz 3 x 3 h x 200 = 1.800 EUR; Summe **7.200 EUR**. Liest man die Schulung als Preis je Person, sind es 3.600 + 5.400 + 1.800 = 10.800 EUR - die Angabe ist mehrdeutig, beide Rechenwege dürften akzeptiert werden. |
| d | Öffentlicher Rechtsauskunfts-Chatbot | beschreiben (1 Vorteil, 1 Nachteil) | Freitext lang | 4 | Kurzszenario | Vorteil: rund um die Uhr erreichbar, gewinnt Mandanten, entlastet Personal. Nachteil: falsche Auskünfte (Haftung/Image), Datenschutz bei sensiblen Eingaben, weniger bezahlte Erstberatung. Je 2 P. |
| ea | Sichere Fernverbindung zum Cloud-Server einrichten | angeben | Formular ausfüllen (Host, Port, Verbindungstyp ankreuzen) | 3 | Serverdaten, Terminal-Dialog (englisch), Porttabelle | Host 32.42.230.33, Port **22**, Typ **SSH**. Je 1 P. |
| eb | Warum nicht Telnet oder Seriell | begründen | Freitext lang | 2 | - | Telnet überträgt unverschlüsselt (auch Passwörter); seriell braucht eine direkte Kabelverbindung und geht nicht über das Internet. |
| fa | Begriff Redundanz (Daten) | erklären | Freitext lang | 2 | - | Dieselbe Information ist mehrfach gespeichert. |
| fb | Problem durch Redundanz | beschreiben | Freitext lang | 2 | - | Inkonsistenz/Änderungsanomalie: Änderung wird nur an einer Stelle gepflegt, Daten widersprechen sich; außerdem mehr Speicher und Pflegeaufwand. |

## 3. Beobachtungen

**Operatoren und Punkte.** Häufigster Operator ist „nennen“ (9x, meist 1 P. je Nennung), danach
„erläutern“/„beschreiben“/„begründen“ (11x, 2-4 P.). Die Faustregel: nennen = 1 P. je Stichwort,
beschreiben/erläutern = 2 P. je Aussage (Aussage + Folge). Die größten Einzelposten sind der
Netzplan (9 P.), die Pseudocode-Auswertung (8 P.) und die beiden Tabellen (je 6 P.).

**Verteilung.** Ungleiche Aufgabengewichte (25/20/30/25) - das gibt es nur 2025, 2026 ist auf
4 x 25 normiert. Freitext (kurz + lang) macht 45 P. aus, Rechnen im engeren Sinn nur 7 P.,
dazu 6 P. Rechnen im Schreibtischtest und 2 P. Subnetting.

**Material.** Datentabelle, Piktogramme, Netzskizze, englischer Fließtext, Schlüssel-Skizze,
Hashwert-Tabelle, Netzplan mit Vorgangsliste, Python-Code, deutscher Pseudocode, Prozesskästchen,
Terminal-Dialog mit Porttabelle. Fast jede Teilaufgabe hat ein Stück Material.

**Stolperfallen.**
- Die Matrix nutzt nur 4 von 6 Kriterien; bei Kosten ist der *kleinste* Wert der beste (Rang 3).
- Monatskosten: Angaben stehen an drei Stellen (Einleitung, Tabelle, Teilaufgabe).
- „Vorletzte“ Adresse, nicht letzte; /26 statt des gewohnten /24.
- Grenzwert im Pseudocode: `> 80` bei Eingabe 80 ist falsch.
- FP und GP im Netzplan sind zwei verschiedene Felder; G hat GP 116, aber FP 0.
- Zweimal mehrdeutige Kostenangaben (Wartung, Schulung) - Rechenweg sauber aufschreiben.

**Neu seit Katalog 2025.**
- **KI als eigene 25-Punkte-Aufgabe** (Einsatz im Prozess, Akzeptanz, Kosten, Chancen/Risiken).
- **Pseudocode und echter Code statt Struktogramm/PAP**: 14 P. reines Code-Lesen.
- **Web-Grundlagen** (statisch/dynamisch, Sprachen, SEO und Web-Kennzahlen als Kontext).
- **Wirtschaftlichkeit mit Opportunitätskosten** (entgangener Umsatz).
- Datenschutz nur knapp (3 P.), aber berufsbezogen eingekleidet.
- Nicht mehr vorhanden: SQL, RAID, Struktogramm. Kein Thema dieser Prüfung: Barrierefreiheit,
  Qualitätssicherung/Testen (nur als Vorgangsname im Netzplan), Verträge.
