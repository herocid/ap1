# AP1 Coach - Arbeitsanweisungen

Flutter-Lern-App für die IHK-Abschlussprüfung Teil 1 (IT-Berufe, Katalog 2025).
Repo: github.com/herocid/ap1, Branch `main`. Konzept: `docs/KONZEPT.md`.

## Umgebung (Windows)

Flutter 3.41.6 liegt in `C:\Users\Student\develop\flutter`. In PowerShell-Befehlen
den PATH voranstellen:

```
$env:Path = "C:\Users\Student\develop\flutter\bin;C:\Program Files\Git\cmd;C:\Program Files\GitHub CLI;" + $env:Path
```

- Prüfen: `flutter analyze` und `flutter test` - beides muss vor jedem Commit sauber sein.
- Web-Vorschau: `.claude/launch.json` (Port 8080 bzw. `ap1-coach-web` auf 8092); nach
  Code-Änderungen Server neu starten (kein Hot Reload in der Vorschau). Der Debug-Loader
  bleibt öfter beim Laden hängen - zuverlässiger: `flutter build web --release`, dann
  `ap1-coach-release` (statisch auf 8093; nach neuem Build Service Worker/Cache leeren).
- Seed-Migration `supabase/migrations/20260920090100_ap1_seed.sql` wird nicht von Hand
  bearbeitet, sondern nach Inhaltsänderungen mit `flutter test tool/generate_seed_sql_test.dart`
  neu erzeugt.
- `dart format` nur auf geänderte Dateien anwenden, nie auf ganz `lib/` - sonst entsteht ein
  riesiger Diff in den Inhaltsdateien.
- Commits: deutsche Conventional Commits (`feat:`, `fix:`, `content:`), Nachricht mit
  mehreren `-m` übergeben, letzte Zeile `Co-Authored-By: Claude <noreply@anthropic.com>`.
- **Pushen nur nach Rückfrage** - `main` wird von Vercel direkt live deployt.

## Getroffene Entscheidungen (nicht neu verhandeln)

- App-Name **AP1 Coach** (`kAppName` in `lib/widgets/brand.dart`); das Dart-Paket heißt
  weiter `ap1_trainer`. Logo („A“ als Gipfel mit Fahne) ist gezeichnet (`LogoPainter`),
  die App-Icons erzeugt `flutter test tool/generate_icons_test.dart`.
- Farbwelt **IT-Blau und Orange** (`lib/core/theme/app_colors.dart`): Blau `#0B63CE` als
  Marke, Orange als Komplementärfarbe für Motivation (Streak, Ziel), Google-Grün/-Rot für
  richtig/falsch, Petrol für Hinweise. Keine Verläufe. Design modern (Material 3);
  Store-Qualität: keine abgeschnittenen Texte, keine Überläufe.
- Orange hat zwei Rollen: `flame` (dunkler, für Text und Icons) und `flameFill` (kräftig,
  nur für Balken und Flächen). Fließtext hat Laufweite 0, nur Versalien-Labels sind gesperrt.
- Startseite: Das Tagesziel ist die einzige vollflächig blaue Karte (`_TodayCard`), „Fehler
  wiederholen“ steht als Zeile darin. Bits Tipp wiederholt keine Zahlen aus den Karten.
- Kartenrückseiten werden nur in der Anzeige gegliedert (`card_back_format.dart`: Stichwörter,
  Rechenwege, „Beispiel:“/„Merke:“), die Kartentexte bleiben unverändert.
- Statistik zeigt ohne Daten Einstiege statt Nullen (`stats_empty.dart`).
- Silbentrennung (`lib/widgets/hyphenation.dart`) ist regelbasiert mit Stammlisten: „st“ wird
  getrennt, „ck“ nie; falsch getrennte Zusammensetzungen über die Stammlisten nachziehen.
- Maskottchen **Bit** (`lib/widgets/mascot.dart`), ein kleiner Roboter; führt in der
  Einführung (`/einfuehrung`) durch die App und gibt auf Start-, Quiz- und Ergebnisseite Tipps.
- Tabs: Start · Journey (lernen) · Quiz (abgefragt werden) · Karten · Statistik - kein
  sechster Reiter. Routen nur ASCII (`/pruefung`, nicht `/prüfung` - Umlaute brechen im Web).
- **Journey, Karteikarten und Quiz sind getrennt.** Die Journey lehrt allein alles (kein
  Wissenscheck am Lektionsende, keine Verweise auf Quiz/Karten). Karten = auffrischen,
  Quiz/Prüfung = abfragen. Verbunden werden die drei nur in den **Sessions nach
  Themengebiet** auf der Startseite (`/session-bereich/:areaId`: Lernen -> Karten -> Quiz).
- **Karteikasten** (`lib/features/cards/`, Logik in `lib/data/models/flashcard.dart`): Leitner
  mit 5 Fächern, Selbstbewertung bewusst binär (Nochmal / Wusste ich). Nicht Gewusstes kommt in
  derselben Runde nach 3 Karten wieder, bis es sitzt; für den Kasten zählt nur die erste Antwort
  je Runde. Modi: Fällig, Durchlauf (`CardRun`: alle Karten oder Auswahl bleiben im Pool, bis
  jede gewusst wurde, gespeichert), Zufallsmix, Themenauswahl (`/karten-auswahl`), Schwächen.
  Statistik zeigt Karten (sitzen, Trefferquote, Aktivität `CardActivity`, Durchlauf, schwächste
  Themen, je Bereich).
- **In der ganzen App wird geduzt**, auch in Prüfungs- und Fallaufgaben („Nenne …“,
  „Erläutere …“). Siezen nur in wörtlicher Rede im Material (Kunden-E-Mail, Brief).
- **Quiz und Prüfung bilden die echte AP1 ab** (Analyse der Prüfungen 2021-2026 in
  `docs/pruefungsanalyse/`, Quizformen in `docs/QUIZFORMATE.md`): gesunder Formatmix,
  Auswahlaufgaben höchstens rund 30 % je Runde und je Bereich. Anzeige von Optionen,
  Zuordnungen und Paaren wird gemischt (kein erkennbares Muster). Die
  **Prüfungssimulation** besteht nur aus Fallaufgaben (`ExamCase`, je 25 Punkte, ohne
  Auswahlaufgaben, nach echten IHK-Aufgaben gebaut, aber mit eigenen Texten - die
  Originale sind urheberrechtlich geschützt): ein Modellunternehmen, 4 Fälle aus
  verschiedenen Bereichen, 100 Punkte, 90 Minuten, IHK-Notenschlüssel, Freitext mit
  Selbstbewertung nach Kriterien (Stichworterkennung ist nur ein Vorschlag, offline).
- 20 Abzeichen (`Achievement` in `progress.dart`, Auswertung in
  `lib/core/util/achievements.dart`), stehen ganz unten in der Statistik. Prüfungs-Abzeichen
  rechnen mit Punkten und nur vollen Prüfungen. Die Namen der ersten
  sieben Enum-Werte sind gespeichert und dürfen sich nicht ändern.
- `test/screens_layout_test.dart` rendert alle Screens auf 320/375/412 px mit 100 % und
  130 % Schrift - neue Screens dort eintragen.
- Offline-first: Inhalte als Dart-Daten im Repo, Nutzerdaten in `hive_ce` (kein Isar).
  Schriften sind als Assets gebündelt (kein `google_fonts`).
- Prüfungssimulation 90 Minuten (laut Ausbildungsverordnung), nicht 60.
- KI-erstellte Inhalte werden **ohne** „Entwurf“-Kennzeichnung ausgeliefert (Entscheidung
  des Nutzers) - deshalb Fakten und Rechenwege besonders sorgfältig prüfen.
- Ab 2025 gestrichene Themen (SQL, RAID, Vererbung, Struktogramm/PAP, V-Modell, Kanban,
  SWOT, ISO-Normen, nicht-relationale DBs) bekommen keine neuen Inhalte.

## Learning Journey - Aufbau

7 Bereiche -> 35 Themen (`lib/data/models/topic.dart`) -> 134 Lektionen
(`lib/data/models/subtopic.dart`, Reihenfolge = Lernreihenfolge).

Inhalte je Bereich in drei Dateien, gebaut mit den Helfern aus `lib/data/seed/builders.dart`
(`konzept`, `vergleich`, `ablauf`, `formel`, `beispiel`, `skizze`, `merke`, `falle`, `karte`,
`einfach`, `mehrfach`, `rechnen`, `reihenfolge`, `zuordnen`, `netzplanAufgabe`, `ja`, `nein`, `zu`).
`beispiel` = durchgerechnetes Beispiel (Aufgabe, Lösungsweg, Ergebnis); `skizze` bzw. der
Parameter `skizze:` = Zeichnung aus `lib/data/models/diagram.dart` (15 Arten, gezeichnet in
`lib/widgets/diagrams/`, Stimmigkeit prüft `test/diagram_test.dart`, Geometrie
`test/diagram_geometry_test.dart`):

Aufgaben im IHK-Stil (`lib/data/seed/builders_ihk.dart`): `lueckentext` (Dropdown `wahl`,
Wortbank, Eingabe `wort`/`zahl`), `tabelle`, `freitext` (Kriterien `krit` mit Stichwörtern,
Musterlösung), `markieren`, `paare`, Fallaufgabe `fall` (Firma aus `ExamCompanies`, genau
25 Punkte). Jede Aufgabe kann Material tragen (`table:`, `code:`, `skizze:`) und `punkte:`.
Regeln prüft `test/ihk_integrity_test.dart`. Ansichten in `lib/widgets/question_types/`,
Prüfungslauf in `lib/features/exam/`, Auswahl in `lib/core/util/exam_composer.dart`.

- `lib/data/seed/questions/ihk_aNN_*.dart` (neue Formate) und
  `lib/data/seed/cases/cases_aNN_*.dart` (Fallaufgaben) sind schon registriert
- `lib/data/seed/nuggets/nuggets_aNN_*.dart` -> in `nuggets_data.dart` registrieren
- `lib/data/seed/cards/cards_aNN_*.dart` -> in `cards_data.dart` registrieren
- `lib/data/seed/questions/questions_aNN_*.dart` -> in `seed_data.dart` registrieren

Vorlage für Stil und Tiefe: `nuggets_a03_netze.dart`, `cards_a03_systeme.dart`,
`questions_a03_systeme.dart`.

### Qualitätsregeln (von Tests erzwungen)

- Jede Lektion: **mind. 4 Lernschritte, 3 Aufgaben, 4 Karteikarten** (`journey_integrity_test.dart`).
- Lernschritte einer Lektion stehen am Stück, didaktisch aufbauend:
  Einstieg/Konzept -> Details/Vergleich -> Ablauf/Formel mit durchgerechnetem Beispiel ->
  Prüfungsfalle -> Merksatz. Text mind. 30 Zeichen, keine Füllsätze.
- Aufgaben: jede Option mit Begründung (auch warum falsch), Erklärung > 40 Zeichen,
  Einfachauswahl genau 1 richtig, Mehrfachauswahl mind. 2 richtig, Zuordnung nutzt jede
  Kategorie, Rechenaufgaben mit Rechenweg in der Erklärung. Eindeutig formulieren.
- Karten: Rückseite > 15 Zeichen, Vorderseite max. 120 Zeichen (Test). Best Practice: Vorderseite
  als präzise Frage (kein bloßer Begriff, keine Ja/Nein-Frage), eine Karte = ein Gedanke,
  Rückseite knapp (Ziel < 220 Zeichen), Aufzählungen bis ca. 4, Rechenkarten mit Rechenweg,
  verwechselbare Begriffe als eigene Abgrenzungskarte. Karten-IDs nie ändern (Lernstand hängt dran).
- IDs eindeutig: Lernschritte `n-xx-N`, Karten `k-xx-N`, Aufgaben `aB-xx-N`.

## Stand

| Bereich | Status |
| --- | --- |
| 01 Projekte & Projektmanagement (31 Lektionen) | fertig |
| 02 Kundenbeziehungen & Kommunikation (16) | fertig |
| 03 Informations- & Softwaresysteme (20) | fertig |
| 04 Analyse & Entwicklung von Systemen (30) | fertig |
| 05 Qualitätssicherung (7) | fertig |
| 06 IT-Sicherheit & Datenschutz (18) | fertig |
| 07 Vertragsmanagement & Service (12) | fertig |

Alle 134 Lektionen haben Lernschritte, Aufgaben und Karten. `test/nuggets_layout_test.dart`
rendert jeden Lernschritt bei 320 px mit 100 % und 130 % Schrift.

Stand 01.10.2026: Journey vertieft auf rund 1.560 Lernschritte (10-15 je Lektion, über
200 Zeichnungen und Rechenbeispiele), rund 1.040 Aufgaben und 1.020 Karten; von
Prüf-Agenten nachgerechnet. Zielgröße je Lektion: 8-14 Lernschritte, mind. 6 Aufgaben,
mind. 6 Karten (Test erzwingt weiter nur 4/3/4).

Stand 01.10.2026 (Karteikarten): rund 3.020 Karten (mind. 15 je Lektion, meist 18-25), alle
Vorderseiten als Fragen nach Best Practice überarbeitet; neu abgedeckt u. a. Aufwandsschätzung,
Unternehmensziele, Aufbauorganisation, strukturierte Verkabelung, Such-/Sortieralgorithmen,
Sequenz-/Zustandsdiagramm, IEEE 754, JSON/XML/CSV, ISMS/BCM, NIS2, E-Mail-Sicherheit, MDM/BYOD
(nur als Karten). Nach Abgleich mit dem Katalog 2025 wurden Karten zu nicht enthaltenen
Themen entfernt (Delphi/Function Points, IEEE 754, JSON/XML/CSV, Sequenz-/Zustandsdiagramm,
Such-/Sortieralgorithmen, NIS2, SPF/DKIM/DMARC, MDM/BYOD, strukturierte Verkabelung) sowie
gestrichene (Fragetechniken, Eisberg, Audit, ISO-25010-Merkmale); jetzt 2.923 Karten.
Lektionen „Qualitätsanforderungen“ (05) und „Kundengespräch“ (02) auf den Katalog gekürzt.

Stand 01.10.2026 (Quiz/Prüfung): rund 1.600 Aufgaben plus rund 290 Teilaufgaben in 44
Fallaufgaben (11 je Modellunternehmen); Auswahlanteil je Bereich 17-29 % (vorher 47-68 %).
Rechtsangaben der neuen Aufgaben gegen Gesetzestexte geprüft.

## Design-Ausbau (Plan, Stand 02.10.2026)

Schritt für Schritt umsetzen, nach jedem Schritt testen, pushen und dem Nutzer berichten
(er behält sein Nutzungslimit im Blick).

1. Look: Plus Jakarta Sans (OFL) für Überschriften und große Zahlen, Inter bleibt für
   Fließtext; große Kernzahlen (48-56 px); weiche Schatten statt grauer Rahmen in `AppCard`;
   Akzentfarbe je Bereich (7 Töne aus der Blau-Orange-Familie, keine Verläufe);
   Dunkelmodus vertiefen (tieferes Blau-Schwarz, leuchtende Akzente).
2. Bewegung: zentrales Haptik-System (Auswahl, richtig, falsch, Meilenstein); weiche
   Seitenübergänge für alle Routen; Lektion wächst aus der Kachel (Hero-Animation).
3. Funktionen: Auswertung der Prüfungssimulation je Bereich (Balken, „hier die meisten
   Punkte verloren“, Training starten); persönliche Begrüßung nach Tageszeit mit
   Restminuten bis zum Tagesziel.
4. Bit: mehr Präsenz (Tipps und Motivation je Bereich), ggf. Neugestaltung der Figur.

## Offen (Stand 02.10.2026)

Inhalte:
- Erledigt am 02.10.2026: Karten, Aufgaben, Fallaufgaben und ältere `seed_*.dart` sind je
  Datei von Hand geglättet (rund 950 Stellen) und zusammen mit den Lernschritten fachlich
  zweitgeprüft (alle Rechnungen nachgerechnet, Rechtsangaben teils am Gesetzestext). Weiter
  gilt: keine Skripte für Ersetzungen, krit-Stichwörter und Rechnungen nicht anfassen.
- Rechtsstand im Blick behalten: § 38 BDSG (20-Personen-Schwelle für den
  Datenschutzbeauftragten) soll laut Bundesregierung gestrichen werden; E-Rechnung
  (Ausstellungspflicht ab 2027/2028, betrifft u. a. `k-pa-27`, `f-a02-logistik-f`);
  KI-Verordnung nach dem Digital Omnibus (VO (EU) 2026/1744: Art. 4 nur noch „Maßnahmen zur
  KI-Kompetenz“, Hochrisiko-Pflichten ab 02.12.2027 bzw. 02.08.2028; Zeittafel `n-ir-9`
  ist darauf ergänzt, Quelle waren Kanzleibeiträge, nicht das Amtsblatt).
- Festgelegt am 02.10.2026: Die Zehnerregel rechnet überall mit fünf Phasen (Anforderung,
  Entwurf, Implementierung, Test, Betrieb). Die OEM-Bindung steht als „laut
  Lizenzbedingungen des Herstellers“. Der Katalog 2025 nennt als Vorgehensmodelle nur
  Wasserfall und Scrum (per IT-Berufe-Podcast bestätigt).
- Einheitlich entscheiden (nicht geändert, weil Geschmacksfrage): Pflichtenheft „nach der
  Vergabe“, Pfadschreibweise „A - C - E“ in Netzplan-Aufgaben, alternative Kriterien, deren
  Summe über der Aufgabenpunktzahl liegt.

Quiz/Prüfung:
- Prüfungslauf: Die Ausgangssituation steht bei Teilaufgabe a) als Anriss mit „Ganz lesen“
  (`exam_widgets.dart`), Thema und Schwierigkeit sind dort ausgeblendet (`showMeta: false`,
  wie auf dem echten Bogen). Offen: `CaseContextBox` im normalen Quiz zeigt die Situation
  weiter in voller Länge.
- Bits Sprechblase (`MascotSays`) wird unter 360 px Breite oder über 115 % Schrift kompakt.
  Die Lektionsleiste zeigt den Titel immer ganz (bricht um), auf der Übersicht nur den
  Schließen-Knopf.
- `test/ui_shots_test.dart` erzeugt auch Journey, Lektion (alle Schritte) und Prüfungslauf.
- Blitzrunde (60 Sekunden) wird nicht gebaut (Entscheidung des Nutzers, 02.10.2026);
  KI-Bewertung von Freitext bewusst nicht (Kosten, Server, online) - nur auf Wunsch des
  Nutzers.
- Bewertung (`question_parts.dart`): Kurze Stichwörter bis 4 Zeichen zählen nur als ganzes
  Wort, mit Endung oder am Ende einer Zusammensetzung („Java“ trifft nicht „JavaScript“),
  Füllwörter wie „nicht“ zählen nie. Eingabelücken vergleichen ohne Leerzeichen, mit
  vereinheitlichten Operatoren (≥ wie >=) und ohne äußere eckige Klammern.

Store-Vorbereitung (Nutzer legt die Konten bei Google/Apple selbst an):
- Android: Release-Signatur einrichten (build.gradle signiert Release noch mit Debug-Key),
  `flutter build appbundle`. Neue Play-Privatkonten brauchen 14 Tage geschlossenen Test
  mit mind. 12 Testern.
- iOS: Icons ohne Alphakanal erzeugen (`tool/generate_icons_test.dart`), Build über
  Codemagic (Nutzer arbeitet unter Windows, kein Mac), dann TestFlight und Review.
- Datenschutzerklärung und Impressum (Stores verlangen eine Datenschutz-URL), Store-Texte,
  Screenshots. Name „AP1 Coach“ in Stores und DPMA/EUIPO auf Verfügbarkeit prüfen.

App:
- Lern-Erinnerungen (`lib/core/notifications/`) sind gebaut, aber noch nicht auf echtem
  Android/iOS-Gerät getestet (Berechtigungsdialog, Symbol in der Statusleiste).
- Diagramme in Extremfällen (Use Case, Fluss, ERM bei 236 px und 130 % Schrift).
- Kein Crash-Reporting, kein „Fehler melden“-Knopf.
- Supabase-Projekt ist pausiert; die Live-App nutzt es nicht (kein Anon-Key in Vercel).
  Nach dem Fortsetzen die Seed-Datei einmal im SQL-Editor ausführen.
