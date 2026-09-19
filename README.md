# AP1 Projektmanagement-Trainer

Lern-App für den **Projektmanagement- und Strukturierungsteil der
IHK-Abschlussprüfung Teil 1** (Fachinformatiker und verwandte IT-Berufe):
Netzplantechnik, Scrum, Lasten-/Pflichtenheft, Wirtschaftlichkeit,
Qualitäts- und Risikomanagement.

Flutter (Web, Android, iOS aus einer Codebase) + Supabase.
Läuft **ohne Backend-Konfiguration sofort los** — die Aufgaben sind in der App
eingebaut, Supabase ist ein optionaler Aufsatz.

---

## Schnellstart

```bash
flutter pub get
flutter run -d chrome
```

Mit Supabase-Anbindung:

```bash
flutter run -d chrome --dart-define=SUPABASE_URL=https://zcxhrkwbulsedkxcbkkk.supabase.co --dart-define=SUPABASE_ANON_KEY=<dein-anon-key>
```

Ohne `SUPABASE_ANON_KEY` startet die App im Offline-Modus: alle 46 Aufgaben
und 11 Theorie-Snacks kommen aus `lib/data/seed/`, der Fortschritt liegt in
`shared_preferences`. Das ist kein Notbetrieb, sondern der Normalfall für
Entwicklung, Demo und Flugmodus.

### Tests

```bash
flutter test
```

53 Tests: Netzplan-Solver (Vorwärts-/Rückwärtsrechnung, GP/FP, kritischer
Pfad), Bewertungslogik aller sechs Aufgabentypen, Fortschritts- und
Auswahl-Algorithmen, Integrität des Aufgabenpools, Onboarding-Flow.

---

## Supabase einrichten

Die App braucht Supabase nicht, um zu laufen — aber für geräteübergreifenden
Fortschritt und redaktionell pflegbare Aufgaben.

1. Im Supabase-SQL-Editor **in dieser Reihenfolge** ausführen:
   - `supabase/migrations/0001_schema.sql` — Tabellen, Sichten, RLS-Policies
   - `supabase/migrations/0002_seed.sql` — Themen, 46 Aufgaben, Theorie-Snacks
2. Anon-/Publishable-Key aus *Project Settings → API* holen.
3. App mit `--dart-define=SUPABASE_ANON_KEY=…` starten.

`0002_seed.sql` wird **generiert**, nicht von Hand gepflegt:

```bash
flutter test tool/generate_seed_sql_test.dart
```

Damit können App-Inhalte und Datenbank nicht auseinanderlaufen. Wer eine
Aufgabe ändert, ändert sie in Dart und lässt das SQL neu erzeugen.

### Datenmodell in Kurzform

| Tabelle | Zweck |
| --- | --- |
| `ap1_topics` | Themengebiete inkl. geschätztem Punkteanteil (`weight`) |
| `ap1_questions` | Aufgaben; typabhängige Nutzdaten in `data jsonb` |
| `ap1_theory` | Theorie-Snacks |
| `ap1_profiles` | Prüfungstermin, Intensität, Darstellung (1:1 zu `auth.users`) |
| `ap1_attempts` | **Unveränderliche Ereignisliste** aller Antworten |
| `ap1_achievements` | Freigeschaltete Erfolge |

`ap1_attempts` ist die einzige Wahrheit über den Lernfortschritt. Trefferquote,
Streak, Fehlerspeicher und Prüfungsreife werden daraus berechnet und nirgends
zusätzlich gespeichert — es kann also keine zwei widersprüchlichen Stände
geben.

RLS ist auf allen Tabellen aktiv: Lerninhalte sind öffentlich lesbar,
persönliche Daten sieht ausschließlich der jeweilige Nutzer. Für
`ap1_attempts` gibt es bewusst **keine** Update-Policy — eine gebuchte Antwort
nachträglich zu korrigieren würde die Statistik fälschen.

---

## Projektstruktur

```
lib/
  core/
    env.dart                 Laufzeit-Konfiguration (--dart-define)
    router.dart              go_router inkl. Onboarding-Redirect
    theme/                   Design-Tokens, Theme hell/dunkel
    util/
      question_selector.dart Welche Aufgabe kommt als Nächstes (adaptiv)
      study_plan.dart        Lernplan aus Prüfungstermin und Wissensstand
  data/
    models/
      netzplan.dart          Vorwärts-/Rückwärtsterminierung, Puffer, krit. Pfad
      question.dart          6 Aufgabentypen + Bewertung mit Teilpunkten
      progress.dart          Historie, Streak, Level, Prüfungsreife
      profile.dart, theory.dart, topic.dart
    seed/                    Die 46 Aufgaben und 11 Theorie-Snacks
    repositories/            Lokaler Speicher, Aufgaben-Repository
  state/                     Riverpod-Provider, Session-Controller
  widgets/
    question_types/          Ein Renderer je Aufgabentyp
  features/
    onboarding/ dashboard/ learn/ exam/ stats/ settings/ shell/
supabase/migrations/         Schema und generierter Seed
tool/                        SQL-Generator
```

---

## Fachliche Grundlagen der App

**Prüfungsreife** (0–100): gewichteter Mittelwert der Themen-Confidence,
gewichtet mit dem geschätzten Punkteanteil des Themas in der AP1.
`confidence = mastery × (0,45 + 0,55 × coverage)` — Können *und* Abdeckung.
Nicht angefasste Themen zählen als 0, damit der Wert nicht dadurch steigt,
dass man sein Lieblingsthema dreimal durchspielt.

**Aufgabenauswahl**: Priorität aus Fehlerspeicher (stärkster Treiber),
Themenschwäche × Prüfungsgewicht, Neuheit, Wiederholungsabstand und passender
Schwierigkeit — plus etwas Rauschen, damit zwei Sessions nicht identisch sind.

**Netzplan**: Zu jeder Netzplan-Aufgabe sind nur die Vorgänge hinterlegt.
FAZ/FEZ/SAZ/SEZ, Gesamt- und freier Puffer sowie der kritische Pfad werden vom
`NetzplanSolver` berechnet. Eine Musterlösung kann deshalb gar nicht von der
Aufgabe abweichen.

Konvention (nullbasiert, wie in der AP1 üblich):

```
FAZ = max(FEZ aller Vorgänger),  Startvorgang: 0
FEZ = FAZ + Dauer
SEZ = min(SAZ aller Nachfolger), Endvorgang: Projektdauer
SAZ = SEZ − Dauer
GP  = SAZ − FAZ = SEZ − FEZ
FP  = min(FAZ der Nachfolger) − FEZ
```

---

## Inhalte und Recht

Alle Aufgaben sind **eigene Formulierungen im Stil der IHK-AP1**. Es werden
keine Originalaufgaben verwendet — die sind urheberrechtlich geschützt.
Angaben zu Themengewichtung und Prüfungsterminen sind Schätzungen zur
Lernsteuerung und keine Auskunft einer IHK.

---

## Stand

Lauffähiges MVP. Umgesetzt: Onboarding mit Lernplan, adaptive Lernschleife mit
Sofort-Feedback, sechs Aufgabentypen inkl. interaktivem Netzplan,
Prüfungssimulation mit Countdown, Fehlerspeicher, Statistik, Erfolge,
Hell-/Dunkelmodus, responsives Layout für Touch und Desktop.

Nicht enthalten (bewusst nach dem MVP): Registrierung und
Geräte-Synchronisation, Push-Erinnerungen, redaktionelles Backend,
Spaced-Repetition mit echten Intervallen (aktuell nur Abstandsbonus),
weitere Aufgabentypen (Freitext, Diagramm zeichnen).

Details zu Konzept und Designentscheidungen: [`docs/KONZEPT.md`](docs/KONZEPT.md)
