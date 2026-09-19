# Konzept: AP1-Trainer Projektmanagement

Konzept und Begründung der Designentscheidungen. Alles hier Beschriebene ist
im Repository umgesetzt — die Dateiverweise zeigen jeweils auf den Code.

**Positionierung in einem Satz:** Ein Trainer, der nicht Multiple Choice übt,
sondern die drei Aufgabenformen, an denen in der AP1 tatsächlich Punkte
liegen bleiben — Netzplan rechnen, Begriffe abgrenzen, Reihenfolgen kennen.

---

## 1. UI/UX-Design und Design-System

### 1.1 Grundhaltung: ablenkungsfrei heißt nicht schmucklos

Die App wird in der Bahn, in der Berufsschulpause und abends um 22 Uhr im
Bett benutzt. Drei Konsequenzen:

1. **Eine Aufgabe pro Bildschirm.** Kein Seitenmenü, keine Empfehlungen,
   keine Werbung für andere Kurse neben der Aufgabe.
2. **Farbe ist Information, kein Schmuck.** Die einzigen kräftigen
   Farbflächen sind Fortschritt, Streak und Feedback. Der Rest ist grau,
   weiß, schwarz.
3. **Kein Schatten-Overkill.** Karten haben 1px Rahmen und `elevation: 0`
   statt Materialschatten — Schatten auf Schatten wird bei zehn Karten
   untereinander zu Grau-Matsch.

### 1.2 Farbschema

Token in [`lib/core/theme/app_colors.dart`](../lib/core/theme/app_colors.dart).

| Rolle | Hell | Dunkel | Wofür |
| --- | --- | --- | --- |
| Marke | `#5A4FCF` | `#8B83F0` | Primäraktion, aktiver Zustand, Fokus |
| Erfolg | `#15803D` | `#4ADE80` | richtige Antwort, Ziel erreicht |
| Streak | `#EA580C` | `#FB923C` | Serie, kritischer Pfad, Zeitwarnung |
| Fehler | `#BE123C` | `#FB7185` | falsche Antwort |
| Hinweis | `#0E7490` | `#22D3EE` | Erklärungen, Merksätze |
| Hintergrund | `#F7F7FB` | `#0E0E13` | Seitenfläche |
| Karte | `#FFFFFF` | `#17171F` | erhöhte Fläche |

Drei bewusste Entscheidungen:

- **Indigo-Violett statt des üblichen EdTech-Blaus.** Gesättigtes Blau wirkt
  bei 40 Minuten Bildschirmzeit hart; das Violett ist ruhiger und hebt sich
  von der Konkurrenz ab.
- **Dunkelmodus ist nicht schwarz, sondern `#0E0E13`.** Auf OLED „schwimmt"
  weißer Text auf reinem Schwarz sichtbar.
- **Semantik nie nur über Farbe.** Jede Rückmeldung trägt zusätzlich ein
  Icon (Haken / Kreuz / Ziel) und einen Text. Rot-Grün-Schwäche betrifft
  etwa 8 % der männlichen Azubis — in einer Zielgruppe, die überwiegend
  männlich ist, ist das kein Randfall.

Dark und Light sind über eine `ThemeExtension` (`AppSemanticColors`)
gekoppelt: Widgets fragen `context.c.success` ab und nie „bin ich im
Dunkelmodus?".

### 1.3 Typografie

- **Inter** für die gesamte Oberfläche. Auf kleinen Größen deutlich besser
  lesbar als Roboto, und die Ziffern lassen sich auf Tabellenbreite stellen.
- **Tabellenziffern** (`FontFeature.tabularFigures`) für Timer,
  Netzplanwerte, Prozentangaben und Punktestände. Ohne sie springt der
  Countdown bei jeder Sekunde seitlich — genau da, wo man unter Zeitdruck
  hinschaut.
- **JetBrains Mono** ausschließlich für Formeln und Pseudocode.
- **Zeilenhöhe 1.55** im Fließtext und **max. 760px Zeilenbreite**
  (`ReadableWidth`). Erklärungen sind oft fünf bis zehn Zeilen; über die
  volle Breite eines 27-Zoll-Monitors liest die niemand.

Skala: 34 / 24 / 20 / 16 / 14,5 / 11,5 px. Sechs Stufen reichen; wer mehr
braucht, hat ein Hierarchieproblem, kein Typografieproblem.

### 1.4 Abstände, Radien, Breakpoints

4pt-Raster (`Gap.xs` 4 … `Gap.xxxl` 48) in
[`app_spacing.dart`](../lib/core/theme/app_spacing.dart). Kein Wert außerhalb
der Skala — das ist der billigste Weg zu einem ruhigen Layout.

Breakpoints: `compact` 600, `medium` 900, `wide` 1200.
Unter 900px BottomBar, darüber NavigationRail
([`app_shell.dart`](../lib/features/shell/app_shell.dart)). Eine BottomBar
auf einem großen Monitor sieht falsch aus; eine Rail auf dem Handy frisst
Breite.

### 1.5 Gamification — und warum sie hier zurückhaltend ist

Der Feind ist nicht mangelnde Motivation, sondern **falsche Motivation**: Ein
Punktesystem, das Klicks belohnt, erzeugt Azubis, die 200 leichte
Multiple-Choice-Fragen spielen und im Netzplan durchfallen. Deshalb sind alle
Belohnungen an Verhalten gekoppelt, das zum Bestehen beiträgt.

**Prüfungsreife-Indikator (0–100).** Das Leitelement der App, als offener
Ring dargestellt (`ReadinessRing`, 270° mit Lücke unten — liest sich als
Skala, nicht als Tortendiagramm).

```
confidence(Thema) = mastery × (0,45 + 0,55 × coverage)
Prüfungsreife     = Σ  Themengewicht × confidence(Thema)
```

- `mastery` = Trefferquote mit exponentieller Gewichtung (Halbwertszeit etwa
  8 Antworten) — wer sich verbessert, sieht das sofort.
- `coverage` = Anteil der im Thema überhaupt schon gesehenen Aufgaben.
- Themengewicht = geschätzter Punkteanteil in der AP1 (Netzplan 18 %,
  Scrum 16 %, Abschluss 4 % …).

Der entscheidende Punkt: **Nicht angefasste Themen zählen als 0.** Wer sein
Lieblingsthema dreimal durchspielt, kommt nicht über dessen Gewichtsanteil
hinaus. Der Indikator sagt damit etwas Prüfungsrelevantes aus und ist nicht
nur eine Fleißnote. Code: `ProgressState.readiness` in
[`progress.dart`](../lib/data/models/progress.dart).

**Streak.** Eine Flamme und eine Zahl, mehr nicht. Bewusst *keine*
Streak-Wiederbelebung gegen Geld und keine dramatischen Verlustanimationen —
das erzeugt Druck statt Gewohnheit, und wer nach einem verpassten Tag ein
schlechtes Gewissen bekommt, löscht die App.

**Level und XP.** `10 XP` pro voll richtiger Antwort, anteilig bei
Teilpunkten, `2 XP` Trostpunkt fürs Versuchen. **Kein Tempo-Multiplikator** —
der würde zum Raten erziehen. Levelkurve quadratisch (`xp = 45 · level²`).

**Erfolge** ([`Achievement`](../lib/data/models/progress.dart)) — jeder ist
an eine sinnvolle Handlung gekoppelt:

| Erfolg | Bedingung | Warum |
| --- | --- | --- |
| Sieben am Stück | 7 Tage Streak | Gewohnheit |
| Netzplan-Profi | 10 Netzplan-Aufgaben fehlerfrei | schwerstes Thema |
| Fehlerjäger | 20 früher falsche Aufgaben korrigiert | belohnt die *Korrektur*, nicht das Vermeiden |
| Allrounder | in jedem Thema ≥ 5 Aufgaben | gegen Rosinenpicken |
| Ernstfall bestanden | Simulation ≥ 50 % | Prüfungsnähe |

**Tagesziel** statt Gesamtziel: eine Fortschrittsleiste, die abends voll
sein kann. „Noch 156 Lerntage" motiviert niemanden, „3 von 15 heute" schon.

**Bewusst weggelassen:** Ranglisten (demotivieren die unteren 80 %),
Herzen/Leben (bestrafen Übung), tägliche Lootboxen, Avatare.

### 1.6 Komplexe Aufgaben bedienbar machen

Das ist der technisch und gestalterisch anspruchsvollste Teil und
gleichzeitig das Alleinstellungsmerkmal. Sechs Aufgabentypen in
[`lib/widgets/question_types/`](../lib/widgets/question_types/).

**Netzplan** ([`netzplan_question.dart`](../lib/widgets/question_types/netzplan_question.dart)):

- **Nicht zusammenklicken lassen.** Eine frühe Version des Konzepts sah
  Drag-and-drop von Vorgangsknoten vor. Falsch: Geprüft wird das *Rechnen*
  von FAZ/FEZ/SAZ/SEZ, nicht das Anordnen von Kästchen. Die App ordnet den
  Plan deshalb automatisch nach topologischen Ebenen an und zeichnet die
  Pfeile (`_EdgePainter`, Bézier-Kurven mit Pfeilspitzen). Der Lernende füllt
  die Zellen.
- **Nur gefragte Felder sind Eingabefelder.** Bei einer
  Vorwärtsrechnungs-Aufgabe sind SAZ/SEZ/GP/FP sichtbar, aber leer und grau —
  die gewohnte Knotenform bleibt erhalten, ohne die spätere Lösung zu
  verraten.
- **Touch ≠ Desktop.** Unter 600px öffnet ein Tipp auf eine Zelle ein
  **eigenes Ziffernfeld** als Bottom Sheet
  ([`number_input.dart`](../lib/widgets/question_types/number_input.dart)):
  Die Systemtastatur verdeckt auf dem Handy sonst genau die Tabelle, in die
  man einträgt, und liefert je nach Hersteller mal Komma, mal Punkt. Ab
  600px wird direkt in die Zelle getippt, mit Tab-Sprung zur nächsten.
- **Hilfe auf Abruf.** Ein „Regeln"-Chip blendet die Formeln ein, die für
  *diese* Aufgabe gebraucht werden. Nach dem Prüfen kommt ein
  „Kritischer Pfad"-Schalter dazu, der die pufferlose Kette orange
  hervorhebt.
- **Zellgenaues Feedback.** Jede Zelle wird einzeln grün/rot, falsche Zellen
  zeigen den richtigen Wert klein darunter. Teilpunkte pro Zelle.
- **Ehrlich horizontal scrollen** statt zoomen. Ein Pinch-Zoom sieht in der
  Demo gut aus, macht aber 40px-Eingabefelder unzuverlässig treffbar.

**Reihenfolge** (`ordering_question.dart`): Ziehen am Griff **und**
Pfeiltasten pro Zeile. Drag-and-drop allein ist auf dem Desktop fummelig und
mit Tastatur gar nicht bedienbar. Startreihenfolge deterministisch gemischt
(Seed aus der Aufgaben-ID) — dieselbe Aufgabe startet immer gleich, und eine
zufällig korrekte Startreihenfolge wird abgefangen.

**Zuordnung** (`matching_question.dart`): **Kein** Drag zwischen Spalten. Auf
einem 5-Zoll-Display ist das unbedienbar, sobald die Texte länger als drei
Wörter sind — und „Wird vom Auftraggeber erstellt" ist länger. Stattdessen
steht unter jeder Aussage eine Reihe antippbarer Kategorien. Ein Tipp pro
Zuordnung, identisch auf Touch und Maus.

**Auswahlaufgaben** (`choice_question.dart`): Nach dem Prüfen wird **jede**
Option eingefärbt und mit ihrer Begründung versehen, nicht nur die
angekreuzte — siehe Abschnitt 2.3.

Mindestgröße aller Trefferflächen: 40×40px.

---

## 2. User Journey und Onboarding

### 2.1 Erster Start: vier Schritte, keine Hürde

[`onboarding_screen.dart`](../lib/features/onboarding/onboarding_screen.dart)

| Schritt | Frage | Wirkung |
| --- | --- | --- |
| 1 | Vorname (optional) | Ansprache |
| 2 | Ausbildungsberuf | Wahl der Beispiele |
| 3 | **Prüfungstermin** | Tagespensum und Themenreihenfolge |
| 4 | **Zeitbudget** (10/20/35/60 Min.) | Tagesziel |

**Kein Konto, keine E-Mail, keine Einwilligung vor dem ersten
Erfolgserlebnis.** Registrieren kann man später in den Einstellungen, um den
Fortschritt auf mehrere Geräte zu bekommen. Jede Pflichtregistrierung vor dem
ersten Nutzen kostet in dieser Zielgruppe massiv Abbrüche.

Schritt 3 bietet die üblichen IHK-Termine (Anfang März, Ende September) als
Chips an, mit dem ehrlichen Hinweis, dass die genauen Termine die eigene IHK
festlegt. Schritt 4 zeigt sofort die Rechnung: „Bei 166 Tagen und 15 Aufgaben
pro Tag kommst du auf rund 2490 bearbeitete Aufgaben."

Nach dem letzten Schritt steht ein fertiger Lernplan — nicht ein leeres
Dashboard mit der Aufforderung, selbst ein Thema zu wählen.

### 2.2 Der automatische Lernplan

[`study_plan.dart`](../lib/core/util/study_plan.dart)

1. **Wiederholungspuffer abziehen:** 15 % der verbleibenden Zeit, mindestens
   2, höchstens 10 Tage. Neuer Stoff in den letzten Tagen vor der Prüfung
   schadet mehr, als er nützt.
2. **Themen nach Dringlichkeit sortieren:**
   `Dringlichkeit = Prüfungsgewicht × (1 − confidence)`. Nicht nach
   Kapitelnummer — Kapitel 1 ist selten das, was am meisten Punkte bringt.
3. **Lerntage proportional verteilen**, jedes Thema bekommt mindestens einen
   Tag.
4. **Ehrlich sein, wenn es nicht reicht:** Passt das Pensum nicht in die
   Zeit, sagt der Plan das und nennt die nötige Tagesdosis — statt ein
   unerreichbares Ziel auszuwerfen.

Der Plan ist ein Vorschlag, keine Sperre. Jedes Thema lässt sich jederzeit
direkt üben.

### 2.3 Die Lernschleife

```
Theorie-Snack  →  Aufgabe  →  Antwort  →  Sofortiges Feedback  →  nächste
 (nur wenn                                mit Begründung JE Option
  neues Thema)                            + Gesamterklärung
```

**Theorie-Snack** ([`theory_sheet.dart`](../lib/features/learn/theory_sheet.dart)):
30–60 Sekunden Lesezeit, als Bottom Sheet, nicht als eigener Screen — der
Snack ist eine Fußnote zur Aufgabe, kein Kapitel. Er erscheint automatisch
beim ersten Kontakt mit einem Thema und ist danach jederzeit über das
Buch-Symbol abrufbar. Struktur: ein Satz Einstieg, 4–6 prüfungsrelevante
Fakten, ein Merksatz. Beispiel Netzplan: *„Vorwärts das MAXIMUM, rückwärts
das MINIMUM. Wer das vertauscht, rechnet den halben Plan falsch."*

**Feedback — der eigentliche Produktkern.** Die meisten Prüfungstrainer
zeigen „Falsch, richtig wäre C". Das lehrt nichts. Hier bekommt **jede
Antwortoption** eine eigene Begründung, die auch erklärt, warum sie falsch
ist:

> **B) Eng einbinden — in alle Entscheidungen einbeziehen**
> Das gilt für hohen Einfluss UND hohes Interesse. Hier würde es den
> Betriebsrat mit Details überfordern und Widerstand erzeugen.

Dazu kommt eine Gesamterklärung mit Rechenweg bzw. Systematik:

> Die vier Felder der Stakeholder-Matrix: … In der Prüfung wird fast immer
> nach „hoher Einfluss, geringes Interesse" gefragt, weil es das
> unintuitivste ist.

Ein Integritätstest erzwingt das: **keine Antwortoption ohne Begründung,
keine Aufgabe mit einer Erklärung unter 40 Zeichen**
([`seed_integrity_test.dart`](../test/seed_integrity_test.dart)).

**Teilpunkte statt Alles-oder-nichts.** Mehrfachauswahl: `(richtig − falsch
angekreuzt) / gesamt richtig`, damit „alles ankreuzen" keine Gewinnstrategie
ist. Reihenfolge: paarweise Ordnungsgenauigkeit, ein vertauschtes Paar
kostet nicht alles. Netzplan und Zuordnung: anteilig pro Zelle bzw. Item.

**Kein Zurückblättern im Übungsmodus.** Eine geprüfte Aufgabe ist erledigt
und in der Statistik gebucht. Sonst entsteht die Versuchung, eine falsche
Antwort „ungeschehen" zu machen — und die Statistik wird wertlos.

### 2.4 Danach

- **Falsche Aufgaben landen im Fehlerspeicher** und bekommen bei der nächsten
  Auswahl die höchste Priorität. Sie verschwinden erst, wenn sie richtig
  beantwortet wurden.
- **Auswertung** mit Themenaufschlüsselung und jeder Aufgabe aufklappbar zum
  Nachlesen.
- **Adaptive Auswahl** der nächsten Runde
  ([`question_selector.dart`](../lib/core/util/question_selector.dart)):
  Fehlerspeicher (+100) → Themenschwäche × Prüfungsgewicht (bis +200) →
  noch nie gesehen (+40) → Wiederholungsabstand (+1,5/Tag, gedeckelt bei 30)
  → Schwierigkeit passend zum Können (−12 pro Stufe Abweichung) → etwas
  Rauschen, damit zwei Sessions nicht identisch sind.

---

## 3. Feature-Architektur (MVP)

### 3.1 Die vier entscheidenden Features

**1. Adaptive Lernschleife mit begründetem Sofort-Feedback.**
Ohne sie ist die App eine Karteikarten-App. Der Unterschied zwischen „Falsch,
richtig ist C" und einer Begründung pro Option ist der Unterschied zwischen
Abfragen und Lernen. Umfasst: sechs Aufgabentypen, Teilpunkte,
Fehlerspeicher, Theorie-Snacks.

**2. Interaktiver Netzplan.**
Das Alleinstellungsmerkmal. Netzplantechnik ist das punktstärkste und
unbeliebteste Thema, und kein Wettbewerber löst es auf dem Handy gut. Wer
Netzplan auf dem Handy üben kann, hat einen Grund, genau diese App zu
installieren. Zugleich ist es die Komponente mit dem höchsten Aufwand —
deshalb steht sie im MVP und nicht in Phase 2, wo sie nie fertig würde.

**3. Prüfungsreife-Indikator mit Lernplan.**
Beantwortet die einzige Frage, die Azubis wirklich umtreibt: *„Reicht das
schon?"* Er liefert außerdem den Grund, morgen wiederzukommen — eine Zahl,
die man steigen sehen will. Ohne ihn ist die App ein Aufgabenstapel ohne
Richtung.

**4. Prüfungssimulation unter Zeitdruck.**
Der Realitätstest. Wer 90 % im Übungsmodus schafft und in der Prüfung
scheitert, ist am Zeitdruck gescheitert, nicht am Wissen. Liefert zusätzlich
den stärksten Motivationsmoment der App — die erste Note.

Alles andere ist Phase 2: Konto und Synchronisation, Push-Erinnerungen,
Lerngruppen, redaktionelles Backend, Freitextaufgaben.

### 3.2 Prüfungssimulationsmodus

[`exam_intro_screen.dart`](../lib/features/exam/exam_intro_screen.dart),
[`session_screen.dart`](../lib/features/learn/session_screen.dart)

**Drei Formate:**

| Format | Aufgaben | Zeit | Zweck |
| --- | --- | --- | --- |
| Kurztest | 10 | 20 Min. | Zeitgefühl aufbauen |
| Halbe Prüfung | 18 | 45 Min. | Woche vor der AP1 |
| Komplette Simulation | 30 | 90 Min. | Ernstfall |

**Regeln stehen vor dem Start, nicht als Hinweis mittendrin.** Wer sich auf
Zeitdruck einlässt, soll wissen, worauf.

**Was im Prüfungsmodus anders ist:**

| | Übung | Simulation |
| --- | --- | --- |
| Feedback | sofort, mit Erklärung | **erst nach Abgabe** |
| Zurückblättern | nein | **ja, frei** |
| Markieren für später | – | **ja (Lesezeichen)** |
| Aufgabenübersicht | – | **ja (Raster mit Status)** |
| Countdown | – | **ja, hart** |
| Themenauswahl | adaptiv nach Schwäche | **nach Punkteanteil der AP1** |

Die letzte Zeile ist die wichtigste: Die Simulation trainiert nicht, was man
schlecht kann, sondern bildet ab, was drankommt. Genau das unterscheidet sie
vom Training (`QuestionSelector.forExam`).

**Details, die Prüfungsnähe erzeugen:**

- Countdown in Tabellenziffern, unter 5 Minuten orange, unter 1 Minute rot.
- Zeit abgelaufen → **automatische Abgabe**, keine Kulanzsekunden.
- Unbeantwortete Aufgaben zählen mit **0 Punkten** — wie eine leere Zeile im
  Prüfungsbogen. Vor der Abgabe wird gezählt, wie viele offen sind.
- Abbruch verwirft den Lauf, damit sich niemand durch Neustarts eine bessere
  Note erschleicht.
- Keine Farben, keine Häkchen, kein „gut gemacht" während des Laufs.

**Nach der Abgabe** kommt das, was die Simulation erst nützlich macht:
Prozentwert **und IHK-Note** (100-Punkte-Schlüssel: ≥92 = 1, ≥81 = 2,
≥67 = 3, ≥50 = 4, ≥30 = 5), Aufschlüsselung nach Themen, und jede Aufgabe
aufklappbar mit der vollständigen Erklärung. Wer nach der Simulation nur
„58 %" sieht, hat nichts gelernt.

Der Ton der Rückmeldung unter 50 %: *„Das ist eine Übung, kein Urteil —
arbeite die schwächsten Themen unten der Reihe nach ab."*

---

## 4. Technische Umsetzung

### 4.1 Empfehlung: Flutter + Supabase

Umgesetzt, nicht nur empfohlen.

**Flutter**, weil:
- Eine Codebase für Android, iOS **und** Web. Für ein Solo-Team ist das der
  Unterschied zwischen einer und drei Plattformen.
- Der Netzplan ist gezeichnete, pixelgenaue UI mit eigenem `CustomPainter`.
  In Flutter ist das eine Klasse; in React Native wäre es SVG-Gefummel mit
  Bridge-Overhead.
- Web als vollwertiges Ziel: Azubis lernen auch am Schul-PC, wo sie nichts
  installieren dürfen. Als PWA installierbar, ohne App-Store-Review — man
  kann täglich ausliefern.
- Ein Widget-Test deckt alle Plattformen ab.

**Supabase**, weil:
- Postgres statt Dokumentdatenbank. Die Auswertungen sind relationale Fragen
  („Trefferquote je Thema der letzten 30 Tage").
- **Row Level Security** löst die Mehrbenutzertrennung in der Datenbank statt
  in selbstgeschriebener Middleware. Für ein kleines Team ist das der
  wichtigste Punkt: Der Datenschutzfehler, den man nicht schreiben kann,
  passiert nicht.
- Auth, Storage und Edge Functions sind dabei. Kein eigener Server.
- Kostenlos bis in den niedrigen vierstelligen Nutzerbereich.

**Ausdrücklich nicht gewählt:**
React Native (Netzplan-Zeichnung zu aufwendig) · Firebase (Auswertungen in
Firestore werden teuer und umständlich) · eigenes Node-Backend (Wartung, die
ein Solo-Team nicht leisten sollte) · reines Web (kein App-Store, keine Push
auf iOS).

### 4.2 Bibliotheken

| Zweck | Wahl | Begründung |
| --- | --- | --- |
| State | `flutter_riverpod` | compile-sicher, testbar ohne Widget-Baum |
| Navigation | `go_router` | deklarativ, Deep Links, Web-URLs umsonst |
| Backend | `supabase_flutter` | Auth + Postgres + Realtime |
| Lokal | `shared_preferences` | reicht für Profil und Historie |
| Schrift | `google_fonts` | Inter und JetBrains Mono |
| i18n | `intl` | deutsche Datums- und Zahlenformate |

Bewusst **kein** Code-Generator (`freezed`, `json_serializable`,
`riverpod_generator`): Bei dieser Projektgröße kostet `build_runner` mehr
Zeit, als er spart, und ein Neueinsteiger versteht handgeschriebene
`fromJson`-Methoden sofort.

### 4.3 Architektur

```
UI (features/, widgets/)
  ↓ liest und schreibt über
State (Riverpod-Provider, SessionController)
  ↓ nutzt
Domain (models/ mit Logik: NetzplanSolver, Question.grade, ProgressState)
  ↓ lädt aus
Data (repositories/: LocalStore, QuestionRepository)
  ↓
Supabase  |  eingebaute Seed-Daten
```

Drei tragende Entscheidungen:

**1. Offline-first, nicht offline-fähig.** Ohne `SUPABASE_ANON_KEY` läuft die
App vollständig gegen die eingebauten Aufgaben. Supabase ist ein Aufsatz, kein
Fundament. Das hält die Einstiegshürde bei null, macht die App im Flugmodus
benutzbar und die Entwicklung unabhängig vom Backend. Jeder Netzwerkfehler
fällt auf die Seed-Daten zurück — eine leere Aufgabenliste wäre für die App
fataler als veraltete Inhalte.

**2. Der Fortschritt ist eine Ereignisliste.** `ap1_attempts` ist
unveränderlich und die einzige Wahrheit. Trefferquote, Streak, Fehlerspeicher
und Prüfungsreife werden daraus *berechnet* und nirgends zusätzlich
gespeichert. Es kann also keine zwei widersprüchlichen Stände geben, und eine
geänderte Formel wirkt rückwirkend auf alle Daten. Deshalb hat
`ap1_attempts` bewusst **keine** Update-Policy.

**3. Aufgaben tragen ihre Lösung nicht, sie berechnen sie.** Bei
Netzplan-Aufgaben sind nur die Vorgänge gespeichert; FAZ/FEZ/SAZ/SEZ, Puffer
und kritischer Pfad kommen aus dem `NetzplanSolver`. Eine Musterlösung kann
gar nicht von der Aufgabe abweichen — bei 46 handgepflegten Aufgaben ist das
der Unterschied zwischen vertrauenswürdig und peinlich.

### 4.4 Datenbank

Schema in [`..._ap1_schema.sql`](../supabase/migrations/20260919090000_ap1_schema.sql),
Inhalte in `..._ap1_seed.sql`. Alle Tabellen mit Präfix `ap1_`, damit sie in einem
geteilten Supabase-Projekt nichts kaputt machen.

Aufgabeninhalte liegen in einer `jsonb`-Spalte `data`. Sechs Aufgabentypen mit
je eigenem Schema in relationale Tabellen zu pressen, wäre Selbstzweck —
gelesen wird immer die ganze Aufgabe, nie einzelne Antwortoptionen.

Die Seed-Migration wird aus den Dart-Daten **generiert**
([`tool/generate_seed_sql_test.dart`](../tool/generate_seed_sql_test.dart)).
Zwei Quellen für dieselben 46 Aufgaben von Hand zu pflegen, geht garantiert
schief.

### 4.5 Qualitätssicherung

53 Tests, Schwerpunkt auf dem, was lautlos falsch sein kann:

- **Netzplan-Solver** gegen handgerechnete Pläne, inklusive des Falls
  GP = 1 / FP = 0 (den verwechseln selbst Lehrbücher).
- **Bewertungslogik** aller sechs Typen inklusive Teilpunkte und der Frage,
  ob „alles ankreuzen" Punkte bringt (tut es nicht).
- **Integrität des Aufgabenpools**: eindeutige IDs, existierende Themen,
  Begründung an jeder Option, Einfachauswahl mit genau einer Lösung,
  Zuordnungen ohne Leerverweise, Netzpläne ohne unbekannte Vorgänger,
  JSON-Roundtrip, Themengewichte in Summe 1.
- **Fortschrittslogik**: Prüfungsreife bleibt in \[0, 100], ein einzelnes
  Thema kann sie nicht über sein Gewicht heben, Fehlerspeicher enthält nur
  den jeweils letzten Fehlversuch.

Eine fachlich falsche Aufgabe fällt in einer Lern-App niemandem auf — eine
strukturell kaputte schon, und zwar dem Nutzer mitten in der Session.

### 4.6 Betrieb

- **Web:** `flutter build web` → Netlify/Vercel/Cloudflare Pages. Statisch,
  kostenlos, täglich ausrollbar.
- **Android/iOS:** Fastlane in GitHub Actions, wenn die Stores drankommen.
- **Inhalte:** liegen in Git, nicht nur in der Datenbank. Aufgaben sind Code
  und gehen durch Review.
- **Kosten** in der Startphase: Supabase Free (0 €), Hosting (0 €),
  Apple Developer 99 €/Jahr und Google Play 25 € einmalig, sobald die Stores
  dazukommen.

---

## 5. Was fehlt und in welcher Reihenfolge

| Priorität | Feature | Warum noch nicht |
| --- | --- | --- |
| Hoch | Konto + Geräte-Synchronisation | Erst wenn genug Inhalte da sind, dass sich Fortschritt lohnt |
| Hoch | Aufgabenpool auf 300+ | 46 reichen für die Mechanik, nicht für 166 Lerntage |
| Mittel | Push-Erinnerungen zur Lernzeit | Braucht Konto und iOS-Zertifikate |
| Mittel | Echte Spaced Repetition (SM-2) | Aktuell nur Abstandsbonus; lohnt erst bei größerem Pool |
| Mittel | Redaktionelles Backend | Solange Aufgaben aus Git kommen, unnötig |
| Niedrig | Freitextaufgaben mit LLM-Bewertung | Teuer, fehleranfällig, kein AP1-Pflichtformat |
| Niedrig | Lerngruppen | Nettes Extra, kein Bestehensfaktor |

Die ehrlichste Priorität steht oben in der zweiten Zeile: **Inhalte.** Die
Mechanik dieser App ist fertig; was sie tragfähig macht, sind 300 statt 46
Aufgaben.
