# AP1 Trainer

Lern-App für die **IHK-Abschlussprüfung Teil 1 der IT-Berufe** — nach dem
Prüfungskatalog ab 2025 (2. überarbeitete Auflage, erstmals angewendet
Frühjahr 2025).

Deckt alle **sieben Katalogbereiche** ab, von Projektmanagement über
Netzwerke und Softwareentwicklung bis IT-Sicherheit, Datenschutz und
Vertragsrecht. Zwei Lernwege pro Thema: **Karteikarten** (Leitner-System) für
den Einstieg, **Übungsaufgaben** mit begründetem Feedback für die Vertiefung.

Flutter (Web, Android, iOS aus einer Codebase) + Supabase.
Läuft **ohne Backend-Konfiguration sofort los** — alle Inhalte sind in der App
eingebaut, Supabase ist ein optionaler Aufsatz.

| Bereich | Themen | Anteil |
| --- | --- | --- |
| 01 Projekte & Projektmanagement | 8 | 22 % |
| 02 Kundenbeziehungen & Kommunikation | 5 | 13 % |
| 03 Informations- & Softwaresysteme | 4 | 18 % |
| 04 Analyse & Entwicklung von Systemen | 8 | 22 % |
| 05 Qualitätssicherung | 2 | 7 % |
| 06 IT-Sicherheit & Datenschutz | 4 | 12 % |
| 07 Vertragsmanagement & Service | 4 | 6 % |

Bereichsnummern und -namen folgen dem amtlichen Katalog. Die Aufteilung in
Themen darunter ist eine fachliche Rekonstruktion — die amtlichen
Unterkapitel-Titel sind nicht frei veröffentlicht. Die Prozentwerte sind
geschätzte Punkteanteile zur Lernsteuerung, keine IHK-Angabe.

---

## Was 2025 gestrichen wurde

Der Katalog hat Themen **entfernt**: SQL und Datenbankabfragen (nach AP2
verschoben), alle Vorgehensmodelle außer Wasserfall und Scrum, Struktogramm
und PAP, Vererbung, RAID/SAN, LTE/5G, SWOT-Analyse, ISO-Normen,
nicht-relationale Datenbanken, Dokumentationsarten.

Die App zeigt diese Liste unter *Katalog → Symbol oben rechts* und stellt ihr
die **neuen** Themen gegenüber (KI-Unterstützung, SMART, Schutzziele,
Hashverfahren und 2FA, Härtung, Barrierefreiheit, ERP/SCM/CRM, IPv4/IPv6,
UML-Aktivitätsdiagramm, Schreibtischtest, Betroffenenrechte, Anonymisierung,
Datenmengen berechnen, HDD vs. SSD).

Aufgaben zu gestrichenen Themen werden nicht gelöscht, sondern mit
`CatalogStatus.removed2025` markiert: Sie fliegen aus jeder Auswahl und aus
der Prüfungsreife, bleiben aber als Nachschlagewerk erhalten. Wer mit einem
Lehrbuch von 2022 lernt, verliert sonst Wochen an Stoff, der nicht mehr
abgefragt wird.

---

## Schnellstart

```bash
flutter pub get
flutter run -d chrome
```

Mit Supabase-Anbindung (siehe [Supabase einrichten](#supabase-einrichten)):

```bash
flutter run -d chrome --dart-define-from-file=env.json
```

Ohne `SUPABASE_ANON_KEY` startet die App im Offline-Modus: alle Aufgaben,
Karteikarten und Theorie-Snacks kommen aus `lib/data/seed/`, der Fortschritt
liegt in `shared_preferences`. Das ist kein Notbetrieb, sondern der Normalfall
für Entwicklung, Demo und Flugmodus.

### Tests

```bash
flutter test
```

81 Tests: Netzplan-Solver (Vorwärts-/Rückwärtsrechnung, GP/FP, kritischer
Pfad), Bewertungslogik aller sechs Aufgabentypen, Leitner-Karteikasten,
Fortschritts- und Auswahl-Algorithmen, Integrität von Aufgabenpool und
Kartensammlung, Bereichsgewichte, Onboarding-Flow.

Die Integritätstests setzen Qualitätsschwellen durch, die beim Ausbau leicht
verrutschen: keine Antwortoption ohne Begründung, kein Thema mit ein oder
zwei Aufgaben (schlimmer als keine — die Auswahl würde sie ständig
wiederholen), keine doppelten Kartenvorderseiten, Themengewichte je Bereich
exakt passend.

---

## Supabase einrichten

Die App braucht Supabase nicht, um zu laufen — aber für geräteübergreifenden
Fortschritt und redaktionell pflegbare Aufgaben.

Projekt-Ref dieses Setups: `zcxhrkwbulsedkxcbkkk`

### Schritt 1 — Migrationen einspielen

Zwei Wege, beide führen zum selben Ergebnis. Die Migrationen sind
**idempotent** (`on conflict do update`), ein zweiter Lauf schadet also nicht.

**Weg A — Supabase-CLI (empfohlen, kein Copy-Paste)**

```bash
npx supabase login
```

```bash
npx supabase link --project-ref zcxhrkwbulsedkxcbkkk
```

```bash
npx supabase db push
```

`login` öffnet den Browser; `link` fragt nach dem Datenbank-Passwort
(Dashboard → Project Settings → Database). Beides bleibt in der CLI und
landet nicht im Repository.

**Weg B — SQL-Editor im Dashboard (ohne Installation)**

Öffne den SQL-Editor und führe **nacheinander** aus:

1. `supabase/migrations/20260919090000_ap1_schema.sql` einfügen, *Run*
2. `supabase/migrations/20260920090000_ap1_katalog2025.sql` einfügen, *Run*
3. `supabase/migrations/20260920090100_ap1_seed.sql` einfügen, *Run*

Die Reihenfolge ist zwingend — der Seed setzt die Tabellen voraus.
Die dritte Datei ist rund 200 KB groß; der Editor verarbeitet das, braucht
aber einen Moment.

**Kontrolle** (in beiden Fällen):

```sql
select a.number, a.title,
       count(distinct t.id) as themen,
       count(distinct q.id) as aufgaben,
       count(distinct f.id) as karten
from public.ap1_areas a
left join public.ap1_topics t on t.area_id = a.id
left join public.ap1_questions q
       on q.topic_id = t.id and q.catalog_status = 'current'
left join public.ap1_flashcards f on f.topic_id = t.id
group by a.number, a.title order by a.number;
```

Erwartet: 7 Bereiche, 35 Themen, 65 prüfungsrelevante Aufgaben (68 inklusive
der gestrichenen) und 112 Karteikarten.

### Schritt 2 — Anon-Key eintragen

```bash
cp env.example.json env.json
```

Dann in `env.json` den **anon/public**-Key aus
*Project Settings → API Keys* eintragen — **nicht** den `service_role`-Key,
der gehört niemals in eine Client-App. `env.json` steht in `.gitignore`.

### Schritt 3 — App mit Backend starten

```bash
flutter run -d chrome --dart-define-from-file=env.json
```

In den Einstellungen der App steht dann *„Mit Supabase verbunden"* statt
*„Offline-Modus"*. Bleibt es beim Offline-Modus, ist der Key leer oder falsch —
die App fällt in dem Fall bewusst auf die eingebauten Aufgaben zurück, statt
einen leeren Bildschirm zu zeigen.

### Datenmodell in Kurzform

| Tabelle | Zweck |
| --- | --- |
| `ap1_areas` | Die sieben Katalogbereiche mit Punkteanteil |
| `ap1_topics` | Themen mit Bereichszuordnung und Punkteanteil |
| `ap1_questions` | Aufgaben; typabhängige Nutzdaten in `data jsonb` |
| `ap1_flashcards` | Lernkarteikarten |
| `ap1_card_states` | Leitner-Fach und Wiedervorlage je Nutzer und Karte |
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

## Deployment (Vercel)

Vercels Build-Container kennt Flutter nicht, deshalb holt sich
[`tool/vercel-build.sh`](tool/vercel-build.sh) das SDK selbst und erzeugt
`build/web`. Gesteuert wird das über [`vercel.json`](vercel.json) — Vercel
erkennt beides automatisch, es ist keine Einstellung im Dashboard nötig.

Damit die App dort gegen Supabase läuft, unter
*Project Settings → Environment Variables* setzen:

| Variable | Wert |
| --- | --- |
| `SUPABASE_URL` | `https://zcxhrkwbulsedkxcbkkk.supabase.co` |
| `SUPABASE_ANON_KEY` | der anon/publishable Key |

Fehlt `SUPABASE_ANON_KEY`, wird trotzdem deployt — die App läuft dann im
Offline-Modus mit den eingebauten Aufgaben.

**Aktueller Stand:** Die Live-Seite läuft bewusst im Offline-Modus. Solange es
keine Registrierung gibt, liegt der Fortschritt ohnehin nur lokal im Browser;
der einzige Gewinn einer Verbindung wäre, dass Aufgabenänderungen in der
Datenbank ohne Redeploy erscheinen. Dafür den Key zu veröffentlichen lohnt sich
noch nicht. Sobald Auth dazukommt, die beiden Variablen setzen.

Der Key ist im ausgelieferten Bundle sichtbar. Das ist bei Client-Apps
unvermeidbar und genau der Grund, warum der Zugriff über RLS abgesichert ist
und nicht über die Geheimhaltung des Keys. Der `service_role`-Key darf hier
niemals stehen.

Der erste Build dauert wegen des Flutter-Clones etwa 3–5 Minuten.

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
