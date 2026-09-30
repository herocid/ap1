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
- Maskottchen **Bit** (`lib/widgets/mascot.dart`), ein kleiner Roboter; führt in der
  Einführung (`/einfuehrung`) durch die App und gibt auf Start-, Quiz- und Ergebnisseite Tipps.
- Tabs: Start · Journey (lernen) · Quiz (abgefragt werden) · Karten · Statistik - kein
  sechster Reiter. Routen nur ASCII (`/pruefung`, nicht `/prüfung` - Umlaute brechen im Web).
- **Journey, Karteikarten und Quiz sind getrennt.** Die Journey lehrt allein alles (kein
  Wissenscheck am Lektionsende, keine Verweise auf Quiz/Karten). Karten = auffrischen,
  Quiz/Prüfung = abfragen. Verbunden werden die drei nur in den **Sessions nach
  Themengebiet** auf der Startseite (`/session-bereich/:areaId`: Lernen -> Karten -> Quiz).
- 20 Abzeichen (`Achievement` in `progress.dart`, Auswertung in
  `lib/core/util/achievements.dart`), stehen oben in der Statistik. Die Namen der ersten
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
- Karten: Rückseite > 15 Zeichen, Vorderseite kurz.
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

## Offen (Stand 30.09.2026)

Store-Vorbereitung (Nutzer legt die Konten bei Google/Apple selbst an):
- Android: Release-Signatur einrichten (build.gradle signiert Release noch mit Debug-Key),
  `flutter build appbundle`. Neue Play-Privatkonten brauchen 14 Tage geschlossenen Test
  mit mind. 12 Testern.
- iOS: Icons ohne Alphakanal erzeugen (`tool/generate_icons_test.dart`), Build über
  Codemagic (Nutzer arbeitet unter Windows, kein Mac), dann TestFlight und Review.
- Datenschutzerklärung und Impressum (Stores verlangen eine Datenschutz-URL), Store-Texte,
  Screenshots. Name „AP1 Coach“ in Stores und DPMA/EUIPO auf Verfügbarkeit prüfen.

App:
- Aufgabenansicht an das Kachel-Design (`ActionTile`, `TileIcon`) angleichen.
- Netzplan-Aufgabe läuft bei 320 px/130 % um 14 px über; Reihenfolge-Aufgaben lassen dem
  Text wenig Breite.
- Zeichnungen auf 320-px-Handys mit 130 % Schrift (Use Case, Netzskizze, Balken mit langen
  Labels) - Geometrietest prüft bei 130 % erst ab 256 px; 11 Netzskizzen scrollen unter
  ca. 340 px seitlich (Knoten enger setzen), lange Gantt-Diagramme ebenfalls.
- Echte Push-Erinnerungen (Einstellung existiert, Benachrichtigung fehlt).
- Dunkelmodus der Screens aus Journey/Start/Aufgaben durchsehen.
- Katalogthemen ohne eigene Lektion prüfen (von den Inhalts-Agenten gemeldet):
  Sortier-/Suchalgorithmen, Sequenz-/Zustandsdiagramm, IEEE 754, JSON/XML/CSV,
  strukturierte Verkabelung, MDM/BYOD, ISMS/Notfallmanagement, E-Mail-Sicherheit, NIS2,
  Unternehmensziele, betriebliche Aufbauorganisation, Aufwandsschätzung.
- Supabase-Projekt ist pausiert; die Live-App nutzt es nicht (kein Anon-Key in Vercel).
  Nach dem Fortsetzen die Seed-Datei einmal im SQL-Editor ausführen.
