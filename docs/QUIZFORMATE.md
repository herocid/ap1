# Quizformate - Recherche und Vorschläge für AP1 Coach

Stand: 01.10.2026. Grundlage: Websuche zu Lern-Apps (Duolingo, Quizlet, Anki, Kahoot,
Brilliant, Mimo/Sololearn, Memrise, AP1-Apps) und zur Lernforschung. Quellen am Ende.
Zielgruppe: Azubis, 17-25 Jahre, Handy, Einheiten von 2-10 Minuten.

## 1. Ausgangslage

Vorhanden (`QuestionKind`): Einfachauswahl, Mehrfachauswahl, Rechenaufgabe, Reihenfolge,
Zuordnung, Netzplan. Modi im Reiter Quiz: Kurztest (endlos, gemischt), Bereichs-Quiz,
Prüfungssimulation (90 min), Fehler wiederholen. Dazu Streak, 20 Abzeichen, Maskottchen Bit.

Lücke: Die echte AP1 besteht aus **ungebundenen Aufgaben** (Freitext, Tabellen, Rechnungen
mit Rechenweg, Pseudocode) - die App fragt bisher überwiegend per Auswahl ab. Wiedererkennen
ist leichter als freies Abrufen; genau dieses freie Abrufen wird in der Prüfung verlangt.

## 2. Was die Recherche zeigt (Kurzfassung)

| Erkenntnis | Folge für die App |
| --- | --- |
| **Retrieval Practice**: Abrufen schlägt Wiederlesen; laut Dunlosky et al. (2013) eine der zwei Techniken mit hohem Nutzen | Quiz ist Lernen, nicht nur Messen - viele kurze Abfragen statt seltener langer |
| **Spacing**: verteiltes Üben ist die zweite Technik mit hohem Nutzen (Cepeda et al. 2006) | Aufgaben nach Abstand wieder vorlegen, nicht nur Karten (Anki/FSRS-Prinzip) |
| **Interleaving**: gemischte Aufgabentypen senken die Leistung beim Üben, verbessern aber den späteren Test deutlich (Rohrer & Taylor) | Rechenarten und Bereiche mischen; der Lernende muss erst erkennen, *welches* Verfahren gefragt ist |
| **Desirable difficulties** (Bjork): Erschwernis, die Abruf erzwingt, hilft - reine Hürden nicht | Freie Eingabe vor Auswahl; Zeitdruck nur dort, wo Tempo das Lernziel ist |
| **Feedback** macht Auswahlaufgaben erst sicher: ohne Rückmeldung bleiben falsche Optionen hängen (Butler & Roediger 2008) | Nach jeder Antwort richtige Lösung plus Begründung; die Begründungen je Option gibt es schon |
| **Elaboration/Selbsterklärung**: mittlerer Nutzen, günstig umzusetzen | „Warum?“-Nachfrage und Selbstbewertung nach Kriterien |
| Apps: Duolingo mischt rund ein Dutzend Übungsformen je Lektion (Wortbank, Paare, Lücke); Quizlet „Lernen“ steigert von Auswahl zu freier Eingabe; Mimo/Sololearn nutzen Lücken und Bausteine im Code; Brilliant führt schrittweise durch ein Problem | Abwechslung der Formen, Schwierigkeit steigt mit dem Können, Rechnungen in Schritte zerlegen |
| Kahoot-Studien: Zeitlimits und Ranglisten motivieren viele, stressen aber einen spürbaren Teil und fördern Raten | Zeitdruck freiwillig, Vergleich nur mit der eigenen Bestleistung |

## 3. Aufgabenformen

Für alle Formen gilt: Touch-Ziele mind. 48 x 48 dp (Material) mit 8 dp Abstand, Antworten
im unteren Bildschirmdrittel (Daumenzone), „Prüfen“-Knopf unten fest. Richtig/falsch nie nur
über Farbe, sondern zusätzlich Symbol und Text. Jede Zieh-Geste braucht eine
Tipp-Alternative (WCAG 2.2, 2.5.7). Alles muss bei 320 px und 130 % Schrift ohne Überlauf
laufen (`screens_layout_test.dart`).

### 3.1 Wortbank-Lückentext (neu, Priorität hoch)
- **Eignet sich für:** Definitionen, Merksätze, Fachbegriffe im Zusammenhang.
- **Beispiel:** „Beim ___vertrag wird ein Erfolg geschuldet, beim ___vertrag nur die
  Tätigkeit.“ Bank: Werk, Dienst, Kauf, Miet.
- **UX:** Chip antippen füllt die nächste Lücke, Tippen auf die Lücke gibt ihn zurück - kein
  Ziehen nötig. 1-2 Distraktoren mehr als Lücken. Chips umbrechen (`Wrap`), nie scrollen.

### 3.2 Paare antippen (neu)
- **Eignet sich für:** Begriff-Definition, Protokoll-Schicht, Abkürzung-Bedeutung.
- **Beispiel:** HTTP, TCP, IP, Ethernet links - Anwendung, Transport, Vermittlung,
  Sicherung rechts.
- **UX:** Zwei Spalten, erst links, dann rechts tippen; richtiges Paar wird grün und blass,
  falsches wackelt kurz. Höchstens 5 Paare je Bildschirm. Screenreader: Auswahlzustand ansagen.
  Abgrenzung zur vorhandenen Zuordnung: hier 1:1-Paare, dort mehrere Elemente je Kategorie.

### 3.3 Wahr/Falsch-Karten zum Wischen (neu)
- **Eignet sich für:** schnelle Faktenchecks, typische Prüfungsfallen, Aufwärmen.
- **Beispiel:** „Eine IPv6-Adresse ist 64 Bit lang.“ -> falsch (128 Bit).
- **UX:** Wischen rechts/links **und** zwei große Knöpfe „Stimmt“/„Stimmt nicht“. Nach jeder
  Karte ein Satz Begründung. Ratequote 50 % - deshalb nur als Aufwärmer und nie für die
  Prüfungsreife werten; falsche Aussagen immer sofort richtigstellen.

### 3.4 Fehler antippen (Pseudocode, Tabelle, Rechnung) (neu, Priorität hoch)
- **Eignet sich für:** Pseudocode lesen, Schreibtischtest, Rechenwege prüfen - Analyse statt
  Wiedergabe.
- **Beispiel:** Sechs Zeilen Pseudocode, die die Summe eines Arrays bilden sollen; die
  Schleife läuft von 0 bis `laenge` statt bis `laenge - 1`. Die fehlerhafte Zeile antippen.
- **UX:** Ganze Zeile ist das Ziel (mind. 48 dp hoch), Zeilennummern, Festbreitenschrift,
  kein horizontales Scrollen (kurze Zeilen schreiben). Danach erklären, was der Fehler bewirkt.

### 3.5 Tabelle ausfüllen (neu, Priorität hoch)
- **Eignet sich für:** Nutzwertanalyse, Angebotsvergleich, Schreibtischtest,
  Subnetz-Tabelle - das häufigste Antwortformat der echten AP1.
- **Beispiel:** Nutzwertanalyse, Gewichte 40 % Preis / 60 % Leistung. Anbieter A: 8 und 5
  Punkte, Anbieter B: 6 und 7. Gesucht die Nutzwerte: A = 6,2; B = 6,6 -> B gewinnt.
- **UX:** Höchstens 3 Spalten bei 320 px, sonst je Zeile eine Karte. Ein Feld aktiv,
  „Weiter“ springt zum nächsten. Zahlentastatur, Komma und Punkt akzeptieren. Feldweises
  Feedback (welche Zelle falsch ist), Folgefehler kenntlich machen.

### 3.6 Schritt-für-Schritt-Rechnung (Ausbau von „Rechenaufgabe“, Priorität hoch)
- **Eignet sich für:** Speicherbedarf, Übertragungszeit, Stromkosten, Handelskalkulation,
  Subnetting.
- **Beispiel:** Stromkosten eines Servers: 150 W, Dauerbetrieb, 0,30 EUR/kWh.
  Schritt 1: 0,15 kW x 8.760 h = 1.314 kWh. Schritt 2: 1.314 x 0,30 = 394,20 EUR.
- **UX:** Jeder Schritt einzeln geprüft; bei Fehler erst ein Hinweis (Formel), dann die
  Lösung des Schritts, damit der Rest lösbar bleibt (Brilliant-Prinzip). Einheit neben dem
  Feld anzeigen, Toleranz für Rundung festlegen und nennen („auf 2 Nachkommastellen“).

### 3.7 Freitext mit Selbstbewertung nach Kriterien (neu, Priorität hoch)
- **Eignet sich für:** „Erläutern Sie ...“, „Nennen Sie drei ...“ - das Kernformat der IHK.
- **Beispiel:** „Erläutern Sie zwei Vorteile einer USV für einen Serverraum.“ Danach
  Musterlösung mit Checkliste: „Überbrückung bei Stromausfall genannt“, „geordnetes
  Herunterfahren genannt“, „Schutz vor Spannungsschwankungen genannt“ - abhaken ergibt Punkte.
- **UX:** Erst schreiben (oder bewusst „im Kopf beantwortet“ wählen), dann aufdecken.
  Kriterien als große Checkboxen, Punkte wie im IHK-Schlüssel. Ehrlichkeit fördern: Bit
  erinnert, dass nur zählt, was wirklich dastand. Keine automatische Textbewertung
  (offline-first, fehleranfällig). Eingabe nie verlieren (bei App-Wechsel zwischenspeichern).

### 3.8 Reihenfolge (vorhanden, verbessern)
- **Eignet sich für:** Abläufe und Phasen - PDCA, Teamphasen nach Tuckman, Mahnverfahren.
- **Beispiel:** Forming, Storming, Norming, Performing in die richtige Folge bringen.
- **UX:** Ziehgriff plus Pfeiltasten hoch/runter als Alternative; dem Text mehr Breite
  lassen (bekanntes Problem in CLAUDE.md). Höchstens 6 Elemente. Feedback zeigt je Element,
  ob die Position stimmt.

### 3.9 Zuordnen in Kategorien (vorhanden)
- **Eignet sich für:** Abgrenzungen - Schutzziele, Vertragsarten, Kostenarten.
- **Beispiel:** Maßnahmen den Schutzzielen Vertraulichkeit, Integrität, Verfügbarkeit
  zuordnen (Verschlüsselung, Hashwert, redundantes Netzteil).
- **UX:** Element antippen, dann Kategorie antippen. Kategorien als feste Leiste unten.

### 3.10 Antippen in der Zeichnung (neu, nutzt die vorhandenen 15 Diagrammarten)
- **Eignet sich für:** Netzskizzen, Use-Case-, ER- und Gantt-Diagramme lesen.
- **Beispiel:** Netzskizze - „Tippe das Gerät an, das die beiden Subnetze verbindet“ (Router).
  Gantt - „Welcher Vorgang liegt auf dem kritischen Pfad?“
- **UX:** Trefferflächen größer als die gezeichnete Form (mind. 48 dp), nummerierte Marker
  als Alternative zur Fläche, damit auch Screenreader und dicke Daumen treffen.

### 3.11 Freie Kurzeingabe (neu)
- **Eignet sich für:** Zahlen, Abkürzungen, einzelne Fachbegriffe - Abruf ohne Vorgabe.
- **Beispiel:** „Wie viele nutzbare Hostadressen hat ein /26-Netz?“ -> 62.
- **UX:** Groß-/Kleinschreibung und Leerzeichen ignorieren, Synonymliste je Aufgabe, bei
  knapper Abweichung „fast - prüfe die Schreibweise“ statt falsch. Passende Tastatur.

### 3.12 Fallaufgabe mit Teilfragen (neu)
- **Eignet sich für:** Prüfungsnähe - eine Ausgangssituation, 3-4 Teilaufgaben
  verschiedener Formen (Tabelle, Rechnung, Freitext), wie eine IHK-Aufgabe mit 25 Punkten.
- **Beispiel:** „Die Muster GmbH stattet 12 Arbeitsplätze neu aus“: a) Angebotsvergleich
  (Listenpreis 1.000 EUR, 10 % Rabatt, 2 % Skonto, 18 EUR Bezugskosten -> Bezugspreis
  900 EUR), b) passende Vertragsart zuordnen, c) zwei Ergonomie-Anforderungen nennen.
- **UX:** Ausgangssituation einklappbar oben angeheftet, damit niemand zurückscrollen muss.
  Punkte je Teilaufgabe sichtbar.

### 3.13 Sicherheitsabfrage „Wie sicher bist du?“ (Zusatz zu jeder Form)
- **Eignet sich für:** Selbsteinschätzung; trennt Wissen von Glückstreffern.
- **UX:** Nach der Antwort, vor der Auflösung, zwei Knöpfe „sicher“ / „geraten“. Geratene
  Treffer kommen früher wieder. Abschaltbar, nicht bei jeder Aufgabe (z. B. jede dritte).

**Reihenfolge der Umsetzung:** 3.7 Freitext, 3.6 Schrittrechnung, 3.5 Tabelle, 3.1 Wortbank,
3.4 Fehler antippen - danach 3.2, 3.3, 3.11, 3.12, 3.10, 3.13.

## 4. Quiz-Modi

| Modus | Beschreibung | Begründung |
| --- | --- | --- |
| **Prüfungsaufgabe des Tages** (Top 1) | Täglich eine Fallaufgabe im IHK-Stil (3.12) mit Punkten und Musterlösung, 5-8 Minuten, für alle gleich | Übt das echte Format in kleiner Dosis; fester Tagesanker für die Streak; erzeugt Spacing ganz nebenbei |
| **Schwächen-Training** (Top 2) | 10 Aufgaben, gewichtet nach Fehlerquote, „geraten“-Markierung und Abstand seit dem letzten Abruf; Bereiche gemischt | Verbindet Spacing, Interleaving und Retrieval; lenkt Übungszeit dorthin, wo sie am meisten bringt. Ersetzt den bisherigen `fokus`-Modus als sichtbaren Hauptknopf |
| **Fehler-Wiederholung mit Abstand** (Top 3) | Vorhandenes „Fehler wiederholen“ ausbauen: Eine Aufgabe gilt erst als erledigt, wenn sie an zwei verschiedenen Tagen richtig war; in der Runde kommt ein Fehler nach 3-4 anderen Aufgaben erneut | Sofortiges Wiederholen prüft nur das Kurzzeitgedächtnis; mit Abstand wird daraus echtes Lernen. Kleiner Umbau, großer Effekt |
| Blitzrunde | 60-90 Sekunden, nur schnelle Formen (Wahr/Falsch, Paare, Kurzeingabe), Bestwert zählt | Passt in Bus und Pause; nur für Faktenwissen und freiwillig - nie für Rechnungen oder Freitext |
| Marathon ohne Fehler | Endlos, endet beim ersten (oder dritten) Fehler; Rekord je Bereich | Reizvoll für Fortgeschrittene, belohnt Sorgfalt statt Tempo. Fehler am Ende trotzdem erklären |
| Themen-Duell gegen sich selbst | Gleiches Themenset wie beim letzten Mal; Vergleich mit eigener Quote und Zeit | Wettbewerb ohne Rangliste und ohne Server (offline-first); zeigt Fortschritt greifbar |
| Mini-Prüfung | 20 Minuten, eine Aufgabe je Bereich, Feedback erst am Ende | Brücke zwischen Kurztest und 90-Minuten-Simulation, die im Alltag selten jemand startet |
| Kurztest (vorhanden) | Endlos, gemischt, Sofort-Feedback | Bleibt als Einstieg ohne Hürde |

Warum diese Top 3: Sie zielen auf die größte Lücke (Prüfungsformat), nutzen die beiden am
besten belegten Lerntechniken (Abruf, Verteilung) und bauen auf Vorhandenem auf
(`openMistakes`, Bereichs-Readiness, Streak). Blitzrunde und Marathon sind Würze, nicht Kern.

## 5. Feedback und Motivation

### Nach jeder Antwort
- Sofort und eindeutig: Symbol, Farbe und ein Wort („Richtig“ / „Noch nicht“), dazu kurze
  Haptik. Ton nur, wenn eingeschaltet.
- Immer die richtige Lösung zeigen, auch bei richtiger Antwort eine Zeile „Warum“.
  Bei falscher Antwort zuerst die Begründung zur **gewählten** Option, dann die Lösung.
- Bei Rechnungen den Rechenweg aufklappbar; bei Freitext die Kriterienliste.
- Erklärung in 2-3 Zeilen, „Mehr dazu“ führt in den Lernschritt - als Angebot, nicht als Zwang.
- Der Lernende bestimmt das Tempo: „Weiter“-Knopf, kein automatisches Weiterspringen.
- Fortschrittsbalken der Runde oben; Serie richtiger Antworten nur klein anzeigen.
- Bit meldet sich höchstens bei besonderen Momenten (erste richtige nach Fehlern,
  5er-Serie), nicht nach jeder Aufgabe.

### Am Rundenende
- Eine Kernzahl groß (z. B. „8 von 10“), darunter höchstens drei weitere: Zeit, Veränderung
  der Bereichs-Readiness, Streak.
- „Das sitzt“ / „Das kommt wieder“ als zwei kurze Listen nach Thema - wichtiger als Punkte.
- Genau ein empfohlener nächster Schritt (z. B. „3 Fehler wiederholen“), dazu „Fertig“.
- Abzeichen nur, wenn eines neu ist. Konfetti nur bei echten Meilensteinen.
- Vergleich nur mit sich selbst (Bestwert, letzte Runde).
- Bei schlechter Runde: sachlich und nach vorn gerichtet („Subnetting kommt morgen wieder“),
  kein Mitleid, keine Schelte.

### Über Tage hinweg
- Streak an einer kleinen, erreichbaren Tagesleistung festmachen (eine Aufgabe des Tages
  reicht). Ein „Streak-Schutz“ pro Woche nimmt die Angst vor dem Abreißen.
- Fortschritt als Prüfungsreife je Bereich zeigen, nicht als Punktekonto.
- Erinnerungen höchstens eine pro Tag, zur selbst gewählten Zeit, abschaltbar.

## 6. Was man lassen sollte

- **Leben, Herzen, Energie:** Fehler bestrafen und das Üben sperren - genau die Schwachen
  hören dann auf. In einer Prüfungs-App gehört Fehlermachen zum Lernen.
- **Zeitdruck als Standard:** fördert Raten und stresst; in Studien zu Kahoot nennt ein
  großer Teil der Lernenden Zeitlimits als belastend. Timer nur in Blitzrunde und Simulation.
- **Öffentliche Ranglisten:** demotivieren die unteren Plätze und brauchen Server und Konten.
- **Schuld-Benachrichtigungen** („Bit ist traurig“) und Streak-Druck, der zu
  Alibi-Aufgaben führt - Tagesziel ist Lernen, nicht Zählerpflege.
- **Nur Auswahlaufgaben:** trainiert Wiedererkennen; die AP1 verlangt freies Formulieren.
- **Auswahl ohne Auflösung:** falsche Optionen prägen sich sonst als richtig ein.
- **Fangfragen und doppelte Verneinungen:** prüfen Lesen statt Wissen. Distraktoren sollen
  typische Denkfehler abbilden.
- **Sofortiges stumpfes Wiederholen** derselben Aufgabe direkt nach dem Fehler - wirkt wie
  Lernen, ist aber nur Kurzzeitgedächtnis.
- **Ziehen ohne Alternative, kleine Ziele, horizontales Scrollen** in Code und Tabellen.
- **Animationen, die warten lassen:** jede Sekunde Feier nach jeder Aufgabe kostet bei
  10 Aufgaben spürbar Zeit. Kurz, überspringbar, „Bewegung reduzieren“ beachten.
- **Zu viele Zahlen** (XP, Level, Münzen, Ligen nebeneinander): lenkt vom Stoff ab.
  Streak, Abzeichen und Prüfungsreife reichen.
- **Themen im Block ohne Mischung** als einziger Weg: fühlt sich gut an, hält schlechter.
- **Gestrichene Themen** (SQL, RAID, Struktogramm usw.) in neuen Formen wieder einführen.

## 7. Quellen

Lernforschung
- Dunlosky et al. (2013), Improving Students' Learning With Effective Learning Techniques: https://www.whz.de/fileadmin/lehre/hochschuldidaktik/docs/dunloskiimprovingstudentlearning.pdf
- Dunlosky, Strengthening the Student Toolbox (Kurzfassung): https://www.aft.org/ae/fall2013/dunlosky
- Cepeda et al. (2006), Meta-Analyse zum Spacing: http://www.lscp.net/persons/ramus/docs/EPR20.pdf
- Karpicke & Roediger (2007), Expanding Retrieval Practice: https://learninglab.psych.purdue.edu/downloads/2007/2007_Karpicke_Roediger_JEPLMC.pdf
- Karpicke, Retrieval-Based Learning: A Decade of Progress: https://files.eric.ed.gov/fulltext/ED599273.pdf
- Rohrer et al., Interleaved Practice Improves Mathematics Learning: https://files.eric.ed.gov/fulltext/ED557355.pdf
- Taylor & Rohrer (2010), The Effects of Interleaved Practice: http://uweb.cas.usf.edu/~drohrer/pdfs/Taylor&Rohrer2010ACP.pdf
- Butler & Roediger (2008), Feedback bei Multiple-Choice-Tests: https://link.springer.com/article/10.3758/MC.36.3.604
- Bjork, Desirable Difficulties (Überblick): https://www.structural-learning.com/post/desirable-difficulties

Lern-Apps
- Duolingo, Lernansatz und Übungsformen: https://blog.duolingo.com/duolingo-101-how-to-learn-a-language-on-duolingo
- Duolingo, Streak: https://www.duolingo.com/help/what-is-a-streak
- Duolingo Match Madness (Paare gegen die Uhr): https://duoplanet.com/duolingo-match-madness/
- Quizlet, Lernmodi: https://quizlet.com/gb/features/study-modes
- Quizlet „Lernen“ (steigende Schwierigkeit der Fragetypen): https://help.quizlet.com/hc/en-us/articles/360030986971-Studying-with-Learn
- Anki, Algorithmus und FSRS: https://faqs.ankiweb.net/what-spaced-repetition-algorithm
- Memrise, Modi und Testarten: https://memrisebeta.zendesk.com/hc/en-us/articles/4578351044625-What-features-and-modes-are-available-in-the-app-How-will-I-be-tested
- Mimo vs. Sololearn (Lücken und Bausteine im Code): https://mimo.org/blog/mimo-vs-sololearn
- Brilliant, Lernen durch Problemlösen: https://brilliant.org/faq/
- Kahoot, Zeitdruck und Stress (Studie): https://pmc.ncbi.nlm.nih.gov/articles/PMC11949424/
- Kahoot, Meta-Analyse (2025): https://onlinelibrary.wiley.com/doi/10.1111/jcal.13084

AP1-Apps (Wettbewerb)
- AP1 Trainer: https://www.ap1-trainer.de/
- AP1 Trainer Pro: https://ap1-trainer-pro.de/
- IT-Lernapp (Simulatoren): https://it-lernapp.de/
- Lernarena (Simulationen im IHK-Stil): https://lernarena.app/

UX und Barrierefreiheit
- Android, Größe von Touch-Zielen (48 dp): https://support.google.com/accessibility/android/answer/7101858?hl=en
- WCAG 2.2, 2.5.7 Ziehbewegungen: https://www.digitala11y.com/understanding-sc-2-5-7-dragging-movements/
- WCAG 2.2, 2.5.8 Zielgröße: https://www.allaccessible.org/blog/wcag-258-target-size-minimum-implementation-guide
