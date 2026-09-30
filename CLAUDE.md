# AP1 Trainer - Arbeitsanweisungen

Flutter-Lern-App für die IHK-Abschlussprüfung Teil 1 (IT-Berufe, Katalog 2025).
Repo: github.com/herocid/ap1, Branch `main`. Konzept: `docs/KONZEPT.md`.

## Umgebung (Windows)

Flutter 3.41.6 liegt in `C:\Users\Student\develop\flutter`. In PowerShell-Befehlen
den PATH voranstellen:

```
$env:Path = "C:\Users\Student\develop\flutter\bin;C:\Program Files\Git\cmd;C:\Program Files\GitHub CLI;" + $env:Path
```

- Prüfen: `flutter analyze` und `flutter test` - beides muss vor jedem Commit sauber sein.
- Web-Vorschau: `.claude/launch.json` (`flutter run -d web-server --web-port 8080`); nach
  Code-Änderungen Server neu starten (kein Hot Reload in der Vorschau).
- Commits: deutsche Conventional Commits (`feat:`, `fix:`, `content:`), Nachricht mit
  mehreren `-m` übergeben, letzte Zeile `Co-Authored-By: Claude <noreply@anthropic.com>`.
- **Pushen nur nach Rückfrage** - `main` wird von Vercel direkt live deployt.

## Getroffene Entscheidungen (nicht neu verhandeln)

- Design „modern und ruhig“ (Material 3), Farbwelt **Tinte und Messing** (`lib/core/theme/app_colors.dart`).
  Kein Violett/Indigo, keine Verläufe, nichts, was nach generischer KI-App aussieht.
  Store-Qualität: keine abgeschnittenen Texte, keine Überläufe.
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
(`konzept`, `vergleich`, `ablauf`, `formel`, `merke`, `falle`, `karte`, `einfach`,
`mehrfach`, `rechnen`, `reihenfolge`, `zuordnen`, `ja`, `nein`, `zu`):

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
| 06 IT-Sicherheit & Datenschutz (18) | offen |
| 07 Vertragsmanagement & Service (12) | offen |

In 07 (`ve-*`, `sl-*`, `ls-*`, `cm-*`)
gibt es bereits Aufgaben mit `subtopicId` - vor dem Schreiben per Grep zählen und nur
ergänzen, was zur Vollständigkeit fehlt.

Danach offen: Redesign der Screens Lernen, Statistik, Aufgabe/Ergebnis; App-Icon und
Startbildschirm; endgültiger App-Name (der Arbeitstitel „AP1 Trainer“ ist belegt).
