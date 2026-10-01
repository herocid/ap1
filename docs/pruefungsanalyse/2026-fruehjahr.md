# AP1 Frühjahr 2026 - Analyse

Quellen: `AP1-2026-Frühjahr.pdf` (12 Seiten, abfotografiert/gescannt, lesbar) und
`AP1-2026-Frühjahr_Lösung.pdf` (8 Seiten, davon 5 mit Inhalt, 3 leer; digital, sehr gut lesbar).
`AP1-2026-F.pdf` und `AP1-2026-F (2).pdf` sind **byteidentisch** (gleiche Prüfsumme) und zeigen
dieselben 12 Seiten in denselben Bildabmessungen wie `AP1-2026-Frühjahr.pdf`, nur stärker
komprimiert - also Duplikate. Genutzt wurde die größere Fassung. Aufgaben und Lösungen sind in
eigenen Worten beschrieben, nicht zitiert.

## 1. Kopf

| Merkmal | Wert |
| --- | --- |
| Termin | Mittwoch, 25. Februar 2026 |
| Prüfung | Teil 1 der Abschlussprüfung, „Einrichten eines IT-gestützten Arbeitsplatzes“ (Lösung gilt für alle IT-Berufe) |
| Bearbeitungszeit | 90 Minuten |
| Gesamtpunkte | 100 |
| Aufgaben | 4, **je 25 Punkte** |
| Teilaufgaben | 27 |
| Hilfsmittel | nicht programmierbarer, netzunabhängiger Taschenrechner; Konzeptpapier |
| Notenschlüssel (laut Lösung) | 1: 100-92 / 2: unter 92-81 / 3: unter 81-67 / 4: unter 67-50 / 5: unter 50-30 / 6: unter 30 |
| Ausgangssituation | Der Prüfling ist Azubi in einem Systemhaus. Ein Stammkunde (Pharma-Zulieferer) hat ein Logistikzentrum gebaut; das Systemhaus plant die IT der Verladearbeitsplätze: Überwachungskameras, Netz, Abläufe, Versandsoftware. |

## 2. Aufgaben

### Aufgabe 1 - Überwachungskamera analysieren und anbinden (25 P.)

Material: englisches Datenblatt der Kamera (Sensor, Nachtsicht, Auflösung/Bildrate,
Leistungsaufnahme in drei Stufen, Stromversorgung PoE/PoE+/USB-C, Anschlüsse, Setup-Hinweis).

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| aa | Bedeutung von „keine Standardpasswörter“ | beschreiben (zwei Konsequenzen) | Freitext lang | 4 | Datenblatt | Eigenes, regelkonformes Passwort muss gesetzt werden; nicht alle Geräte des Herstellers teilen dasselbe Passwort; ohne gesetztes Passwort meist kein Zugang. 2 P. je Konsequenz. |
| ab | Zweck von Infrarot und Heizung | nennen | Freitext kurz | 2 | Tabelle 5 W / 13 W / 24 W | IR für Nachtaufnahmen; Heizung gegen Vereisung und Beschlag bei Kälte. Je 1 P. |
| ac | PoE-Standard wählen und Stromstärke berechnen | auswählen, berechnen (mA) | Auswahl + Rechnung, Formel P = U x I gegeben | 4 | Tabelle Leistungsbereich -> IEEE 802.3af / 802.3at; 48 V | 24 W liegt nur im Bereich von **802.3at**; I = 24 W / 48 V = 0,5 A = **500 mA**. |
| ad | Datenrate eines Videostreams | berechnen (Rechenweg, volle Mbit/s) | Rechnung im Karoraster | 4 | 1920 x 1080, 30 fps, 24 Bit, Kompression **auf** 30 % | 1920 x 1080 x 24 x 30 / 1.000 / 1.000 x 0,3 = 447,8976 -> **448 Mbit/s**. Mbit dezimal. |
| b | Speicherbedarf für 4 Kameras über 72 h in TiB | berechnen (Rechenweg, aufrunden) | Rechnung im Karoraster | 5 | Ersatzwert 482 Mbit/s | 4 x 448 x 1.000 x 1.000 x 3.600 x 72 / 8 / 1.024^4 = 52,81 -> **53 TiB** (Ersatzwert: 56,81 -> 57 TiB). Bit -> Byte, Sekunden, dezimal -> binär, aufrunden. |
| ca | Vorteil von Daisy Chaining | nennen | Freitext kurz | 1 | 4 Zeilen englischer Text | Weniger Kabel, aufgeräumter Arbeitsplatz. |
| cb | Technische Voraussetzung | erläutern | englischen Text auswerten | 3 | derselbe Text | Multi-Stream Transport muss am DisplayPort-/Thunderbolt-Ausgang des PCs und an den Monitoranschlüssen unterstützt werden. |
| cc | Vier Monitore in Reihe verkabeln | verbinden | Skizze ergänzen (Linien ziehen) | 2 | Zeichnung von 4 Monitoren, Foto eines I/O-Panels (DisplayPort, HDMI, USB, RJ45, Thunderbolt) | Vom Thunderbolt- *oder* DisplayPort-Ausgang zum ersten Monitor, dann von Monitor zu Monitor. Beide Varianten richtig; HDMI nicht. |

### Aufgabe 2 - IP-Adressierung, Fehlersuche, Netzplan (25 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| a | Subnetting für 192.168.16.52/25 | errechnen | vier Werte eintragen | 4 | nur die Adresse | Maske **255.255.255.128**, **126** nutzbare Adressen, Netz **192.168.16.0**, Broadcast **192.168.16.127**. Je 1 P. |
| b | Systematische Netzwerk-Fehlersuche | angeben (Überprüfung + Behebung) | Tabelle ausfüllen (4 Zeilen x 2 Spalten; eine Musterzeile) | 8 | Tabelle mit 5 Fehlerbildern | Kabel defekt: Link-LED prüfen - Kabel tauschen. Falsche Adresse/Range: `ipconfig` - korrekte Adresse zuweisen (lassen). Dose nicht gepatcht: Tester oder funktionierendes Gerät anschließen - patchen lassen/Dose wechseln. Namensauflösung: Ping auf Namen, `nslookup` - DNS-Server prüfen/Ticket. 1 P. je Zelle. |
| c | IPv4 vs. IPv6 | beschreiben (zwei Unterschiede) | Freitext lang | 4 | - | 32 vs. 128 Bit; Größe des Adressraums; Schreibweise dezimal mit Punkten vs. hexadezimal mit Doppelpunkten; Konfiguration manuell/DHCP vs. SLAAC; schlankerer Header. 2 P. je Unterschied. |
| d | IPv4 und IPv6 gemeinsam betreiben | erläutern (eine Möglichkeit) | Freitext lang | 3 | - | Dual-Stack (Geräte haben beide Adressen) oder Tunneling (z. B. 6to4, IPv6 in IPv4 gekapselt). |
| e | Fehler in einem fertigen Netzplan finden | korrigieren, eintragen | Netzplan prüfen + Tabelle (Vorgang / Feld / Korrektur), eine Musterzeile | 6 | Vorgangsliste A-G, ausgefüllter Netzplan mit 4 Fehlern, Legende mit Formeln | D: GP 5 (nicht 6); F: SAZ 17 (nicht 15); F: SEZ 20 (nicht 18). 1 P. für Vorgang + Feld, 1 P. für den Wert. Auch rein formale Funde (z. B. GP bei F) zählen. |

### Aufgabe 3 - Recht, Wirtschaft, Betrieb, Arbeitsplatz (25 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| a | Rechtliche Pflicht bei Videoüberwachung | beschreiben (eine) | Freitext lang | 2 | - | Hinweisschild; keine Personen im öffentlichen Raum erfassen; geschützte Speicherung; Speicherfristen einhalten. |
| ba | Lieferverkehr per Videoerfassung unterstützen | erläutern (eine Möglichkeit) | Freitext lang | 3 | - | LKW-Ankunft erkennen, Bestellung zuordnen (z. B. KI-gestützt), Ladestelle zuweisen; alternativ automatische Erfassung von Datum/Uhrzeit in einer Datenbank. |
| bb | Wirtschaftliche Vorteile besserer Abläufe | nennen (zwei) | Freitext kurz | 2 | - | Kürzere Standzeiten, zügigeres Be-/Entladen, schnellere Auslieferung, bessere Auslastung. |
| ca | Rechte des Käufers bei Lieferverzug | beschreiben (eines) | Freitext lang | 2 | - | Auf Lieferung bestehen; Rücktritt; Schadensersatz statt der Leistung; Ersatz des Verzugsschadens. |
| cb | Folge von Imageverlust | beschreiben (eine) | Freitext lang | 2 | - | Weniger Neukunden, Umsatzrückgang durch Abwanderung, schwierigere Personalgewinnung. |
| da | Private IPv4-Adressen und Internet | beschreiben | Freitext lang | 2 | Tabelle mit drei 192.168.178.x/24-Adressen | Private Adressen, werden im Internet nicht geroutet, von außen nicht direkt erreichbar. |
| db | Ping-Ausgabe auswerten | nennen (kritischen Wert), beschreiben (Problem) | Freitext lang, Screenshot auswerten | 3 | Konsolen-Screenshot mit drei Ping-Läufen | Dritte Kamera: Mittelwert 466 ms (1 P.; auch 863 ms Maximum zulässig); Folge: ruckelndes/einfrierendes Bild, Timeouts (2 P.). |
| ea | Beispiele für Change-Management-Anlässe | benennen (drei) | englischen Text auswerten | 3 | 5 Zeilen Englisch (mit Quellenangabe) | Sinngemäß: Umstrukturierung, Neuverteilung von Ressourcen, geänderte Geschäftsprozesse/-systeme, neue digitale Technik. |
| eb | Sofortumstellung vs. Parallelbetrieb | beschreiben (einen Nachteil) | Freitext lang | 2 | - | Störungen der neuen Software treffen den Betrieb direkt; höherer Druck auf die Mitarbeiter. |
| ec | Arbeitsplatz ergonomischer gestalten | nennen (vier) | Freitext kurz, Foto auswerten | 4 | Foto: Laptop auf kleinem Tisch, einfacher Stuhl | Separater, höhenverstellbarer, größerer Bildschirm; mehrere Bildschirme; gute Auflösung; höhenverstellbarer Tisch; ergonomischer Stuhl. Je 1 P. |

### Aufgabe 4 - Versandsoftware: OOP, Pseudocode, ER-Modell (25 P.)

| Teil | Thema | Operator | Antwortformat | P. | Material | Erwartung laut Lösung |
| --- | --- | --- | --- | --- | --- | --- |
| a | OOP gegenüber prozedural | nennen (zwei Vorteile) | Freitext kurz | 2 | - | Wiederverwendbarkeit, Erweiterbarkeit, Wartbarkeit; auch Vererbung, Kapselung, Polymorphie. |
| ba | UML-Klassendiagramm ergänzen | ergänzen | Diagramm ausfüllen (Klassenname, vier Attribute mit Typ und Sichtbarkeit) | 5 | Beschreibung der vier Attribute; Methodenzeile vorgegeben | 1 P. Klassenname, je 1 P. pro Attribut in der Form `- name: double`. |
| bb | Schreibtischtest: Versandkosten mit Schleife, Verzweigung, Rabatt | berechnen | Code lesen + vier Ergebnisse | 10 | ca. 25 Zeilen englischer Pseudocode, vier Startwerte, Liste mit drei Paketen | Paket 1 (3,2 kg, Express): 6,98 + 12,95 = **19,93**; Paket 2 (8 kg): **6,98**; Paket 3 (12 kg, Express): 13,98 + 12,95 = **26,93** (je 2 P.). Summe 53,84 >= 40 -> x 0,875 = **47,11 EUR** (4 P.). |
| c | ER-Diagramm für Artikel und LKW | ergänzen | Diagramm zeichnen (zwei Entitätskästen vorgegeben, einer leer) | 8 | Fließtext mit 8 Attributen | Beziehung zeichnen und benennen (2 P.), n:m (1 P.), Primärschlüssel je Entität (2 P.), übrige 6 Attribute richtig zugeordnet je 0,5 P. (3 P.). Verladezeit und Menge gehören an die *Beziehung*. |

## 3. Beobachtungen

**Operatoren und Punkte.** „Beschreiben“/„erläutern“ 12x, „nennen“/„benennen“ 6x,
„berechnen“ 5x, „ergänzen“/„korrigieren“/„verbinden“ 4x. Erstmals halbe Punkte (0,5 je Attribut).
Größte Einzelposten: Schreibtischtest (10 P.), Fehlersuch-Tabelle (8 P.), ER-Diagramm (8 P.).

**Verteilung.** 4 x 25 Punkte, klar thematisch getrennt: Hardware/Rechnen - Netz -
Recht/Wirtschaft/Betrieb - Entwicklung. Der Netz- und Hardwareanteil ist mit rund 40 P. deutlich
höher als 2025; IT-Sicherheit/Datenschutz fällt auf 6 P.

**Rechnen.** 13 P. reine Rechenaufgaben plus 4 P. Subnetting plus 10 P. Rechnen im Schreibtischtest.
Formel P = U x I wird wieder mitgegeben. Die Speicheraufgabe ist eine fünfstufige Kette.

**Material.** Englisches Datenblatt, zwei englische Fließtexte, Normtabelle, Foto I/O-Panel,
Monitorskizze, fertiger Netzplan mit Fehlern, Ping-Screenshot, Arbeitsplatzfoto, Pseudocode,
vorgegebene Diagrammrahmen.

**Stolperfallen.**
- Kompression **auf** 30 % (Faktor 0,3) - im Herbst 2025 hieß es **um** 30 % (Faktor 0,7).
- Mbit/s dezimal, TiB binär; durch 8 teilen; **aufrunden**, weil Speicher reichen muss.
- /25: Die Adresse .52 liegt im unteren Teilnetz; 126 Hosts, nicht 128.
- Netzplan-Fehlersuche: Vorwärts- und Rückwärtsrechnung komplett nachrechnen; bei F sind SAZ
  und SEZ falsch, der eingetragene Puffer stimmt.
- Rabattgrenze `>= 40` wird erst nach der Schleife auf die Summe angewandt; Expresszuschlag je Paket.
- ER: Attribute der Beziehung nicht einer Entität zuschlagen.
- Daisy Chain: HDMI-Ausgang ist die naheliegende, aber falsche Wahl.

**Neu seit Katalog 2025.**
- **Netzplan als Fehlersuche** statt Ausfüllen - neues Format.
- **Strukturierte Fehlersuche im Netz** (Prüfung + Behebung) als Tabelle, **Ping-Screenshot** lesen.
- **IPv6**: Unterschiede und Übergangstechniken (Dual-Stack, Tunneling).
- **PoE-Standards, Daisy Chaining/MST, Videodatenrate** - aktuelle Hardwarethemen aus Datenblättern.
- **UML-Klassendiagramm und OOP-Begriffe**; **ER-Diagramm** zum zweiten Mal in Folge (8 P.).
- **Pseudocode-Schreibtischtest** als größter Einzelposten.
- **Change Management, Einführungsstrategie, Ergonomie, Lieferverzug, Videoüberwachung** -
  viele kleine 2-Punkte-Fragen quer durch den Katalog.
- KI nur noch als Stichwort in einer Musterlösung, keine eigene Aufgabe.
- Nicht enthalten: SQL, RAID, Struktogramm, Barrierefreiheit, Testen/QS, Kryptographie.
