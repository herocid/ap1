-- ============================================================================
-- AP1 Projektmanagement-Trainer - Grundschema
--
-- Ausfuehren im Supabase SQL Editor (Projekt zcxhrkwbulsedkxcbkkk) in dieser
-- Reihenfolge:
--   20260919090000_ap1_schema.sql   <- diese Datei
--   20260919090100_ap1_seed.sql     <- Aufgaben und Theorie
--
-- Entwurfsentscheidungen:
--  * Alle Tabellen mit Praefix ap1_, damit sie in einem geteilten Projekt
--    nicht mit anderen Anwendungen kollidieren.
--  * Aufgabeninhalte liegen in einer JSONB-Spalte `data`. Sechs Aufgabentypen
--    mit je eigenem Schema in relationale Tabellen zu pressen, waere hier
--    reiner Selbstzweck - gelesen wird immer die ganze Aufgabe.
--  * Fortschritt wird als unveraenderliche Ereignisliste (ap1_attempts)
--    gespeichert. Jede Kennzahl der App - Trefferquote, Streak,
--    Pruefungsreife - laesst sich daraus neu berechnen. Es gibt keinen
--    zweiten, abweichenden Wahrheitsstand.
--  * RLS ist ueberall aktiv: Aufgaben sind oeffentlich lesbar, persoenliche
--    Daten sieht ausschliesslich der jeweilige Nutzer.
-- ============================================================================

-- ---------------------------------------------------------------- Themen ---
create table if not exists public.ap1_topics (
  id          text primary key,
  title       text        not null,
  blurb       text        not null default '',
  -- Geschaetzter Anteil an den PM-Punkten der AP1; Summe ueber alle Themen = 1.
  weight      numeric(4,3) not null check (weight > 0 and weight <= 1),
  sort_order  int          not null default 0,
  created_at  timestamptz  not null default now()
);

comment on table public.ap1_topics is
  'Themengebiete des PM-Teils der AP1.';

-- -------------------------------------------------------------- Aufgaben ---
create table if not exists public.ap1_questions (
  id          text primary key,
  topic_id    text        not null references public.ap1_topics(id) on delete restrict,
  kind        text        not null check (kind in
                ('single','multiple','numeric','ordering','matching','netzplan')),
  scenario    text,
  prompt      text        not null,
  explanation text        not null default '',
  difficulty  smallint    not null default 2 check (difficulty between 1 and 3),
  tags        text[]      not null default '{}',
  source      text,
  -- Typabhaengige Nutzdaten, siehe Question.fromJson in der App:
  --   single/multiple : { "choices": [{text, is_correct, rationale}, ...] }
  --   numeric         : { "answer": 3.65, "tolerance": 0.01, "unit": "Euro" }
  --   ordering        : { "ordered_items": [...], "ordering_hint": "..." }
  --   matching        : { "buckets": [...], "match_items":[{text,bucket,rationale}] }
  --   netzplan        : { "activities":[{id,name,duration,predecessors}],
  --                       "asked_fields":["faz","fez",...] }
  data        jsonb       not null default '{}'::jsonb,
  is_active   boolean     not null default true,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create index if not exists ap1_questions_topic_idx
  on public.ap1_questions (topic_id) where is_active;
create index if not exists ap1_questions_kind_idx
  on public.ap1_questions (kind) where is_active;
create index if not exists ap1_questions_tags_idx
  on public.ap1_questions using gin (tags);

comment on column public.ap1_questions.data is
  'Typabhaengige Nutzdaten. Struktur je kind - siehe Kommentar im Schema.';

-- --------------------------------------------------------- Theorie-Snacks ---
create table if not exists public.ap1_theory (
  id           text primary key,
  topic_id     text    not null references public.ap1_topics(id) on delete cascade,
  title        text    not null,
  lead         text    not null default '',
  points       text[]  not null default '{}',
  merksatz     text    not null default '',
  read_seconds int     not null default 45,
  sort_order   int     not null default 0
);

-- ---------------------------------------------------------------- Profil ---
create table if not exists public.ap1_profiles (
  user_id       uuid primary key references auth.users(id) on delete cascade,
  display_name  text        not null default '',
  beruf         text        not null default 'fiae',
  exam_date     date        not null,
  intensitaet   text        not null default 'solide'
                  check (intensitaet in ('locker','solide','intensiv','endspurt')),
  theme_mode    text        not null default 'system'
                  check (theme_mode in ('system','light','dark')),
  reminder_hour smallint    not null default 18 check (reminder_hour between 0 and 23),
  reminders_on  boolean     not null default true,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

-- ------------------------------------------------------------- Antworten ---
-- Unveraenderliche Ereignisliste. Nichts wird aktualisiert, nur angehaengt.
create table if not exists public.ap1_attempts (
  id          bigint generated always as identity primary key,
  user_id     uuid        not null references auth.users(id) on delete cascade,
  question_id text        not null references public.ap1_questions(id) on delete cascade,
  topic_id    text        not null references public.ap1_topics(id) on delete restrict,
  -- 0.0 bis 1.0 - Teilpunkte sind ausdruecklich vorgesehen.
  score       numeric(4,3) not null check (score >= 0 and score <= 1),
  seconds     int         not null default 0 check (seconds >= 0),
  mode        text        not null default 'uebung'
                check (mode in ('uebung','fokus','pruefung')),
  -- Gruppiert die Antworten eines Simulationslaufs.
  session_id  uuid,
  answered_at timestamptz not null default now()
);

create index if not exists ap1_attempts_user_time_idx
  on public.ap1_attempts (user_id, answered_at desc);
create index if not exists ap1_attempts_user_topic_idx
  on public.ap1_attempts (user_id, topic_id);
create index if not exists ap1_attempts_session_idx
  on public.ap1_attempts (session_id) where session_id is not null;

-- ---------------------------------------------------------------- Erfolge ---
create table if not exists public.ap1_achievements (
  user_id    uuid        not null references auth.users(id) on delete cascade,
  code       text        not null,
  earned_at  timestamptz not null default now(),
  primary key (user_id, code)
);

-- ============================================================== Sichten ===

-- Kennzahlen je Thema und Nutzer. Die App rechnet dasselbe lokal; die Sicht
-- ist fuer Auswertungen und spaetere Server-Funktionen da.
create or replace view public.ap1_topic_stats
with (security_invoker = true) as
select
  a.user_id,
  a.topic_id,
  count(*)                              as attempts,
  count(distinct a.question_id)         as distinct_questions,
  avg(a.score)                          as mastery_plain,
  max(a.answered_at)                    as last_seen
from public.ap1_attempts a
group by a.user_id, a.topic_id;

-- Aufgaben, deren LETZTER Versuch danebenging - der Fehlerspeicher.
create or replace view public.ap1_open_mistakes
with (security_invoker = true) as
select distinct on (a.user_id, a.question_id)
  a.user_id,
  a.question_id,
  a.topic_id,
  a.score,
  a.answered_at
from public.ap1_attempts a
order by a.user_id, a.question_id, a.answered_at desc;

-- ================================================== Row Level Security ===

alter table public.ap1_topics       enable row level security;
alter table public.ap1_questions    enable row level security;
alter table public.ap1_theory       enable row level security;
alter table public.ap1_profiles     enable row level security;
alter table public.ap1_attempts     enable row level security;
alter table public.ap1_achievements enable row level security;

-- Lerninhalte darf jeder lesen, auch anonym. Geschrieben wird ausschliesslich
-- mit dem Service-Role-Key (Redaktion/Import), deshalb gibt es hier bewusst
-- KEINE insert/update-Policy.
drop policy if exists ap1_topics_read on public.ap1_topics;
create policy ap1_topics_read on public.ap1_topics
  for select to anon, authenticated using (true);

drop policy if exists ap1_questions_read on public.ap1_questions;
create policy ap1_questions_read on public.ap1_questions
  for select to anon, authenticated using (is_active);

drop policy if exists ap1_theory_read on public.ap1_theory;
create policy ap1_theory_read on public.ap1_theory
  for select to anon, authenticated using (true);

-- Persoenliche Daten: strikt auf den eigenen Datensatz begrenzt.
drop policy if exists ap1_profiles_rw on public.ap1_profiles;
create policy ap1_profiles_rw on public.ap1_profiles
  for all to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists ap1_attempts_read on public.ap1_attempts;
create policy ap1_attempts_read on public.ap1_attempts
  for select to authenticated using (auth.uid() = user_id);

-- Nur anlegen, nicht aendern: eine bereits gebuchte Antwort nachtraeglich zu
-- korrigieren wuerde die Statistik faelschen.
drop policy if exists ap1_attempts_insert on public.ap1_attempts;
create policy ap1_attempts_insert on public.ap1_attempts
  for insert to authenticated with check (auth.uid() = user_id);

drop policy if exists ap1_attempts_delete on public.ap1_attempts;
create policy ap1_attempts_delete on public.ap1_attempts
  for delete to authenticated using (auth.uid() = user_id);

drop policy if exists ap1_achievements_rw on public.ap1_achievements;
create policy ap1_achievements_rw on public.ap1_achievements
  for all to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- ================================================== Hilfsfunktionen ===

-- Legt beim ersten Login automatisch ein Profil an.
create or replace function public.ap1_handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.ap1_profiles (user_id, exam_date)
  values (new.id, (current_date + interval '120 days')::date)
  on conflict (user_id) do nothing;
  return new;
end;
$$;

drop trigger if exists ap1_on_auth_user_created on auth.users;
create trigger ap1_on_auth_user_created
  after insert on auth.users
  for each row execute function public.ap1_handle_new_user();

-- updated_at pflegen
create or replace function public.ap1_touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists ap1_questions_touch on public.ap1_questions;
create trigger ap1_questions_touch
  before update on public.ap1_questions
  for each row execute function public.ap1_touch_updated_at();

drop trigger if exists ap1_profiles_touch on public.ap1_profiles;
create trigger ap1_profiles_touch
  before update on public.ap1_profiles
  for each row execute function public.ap1_touch_updated_at();
