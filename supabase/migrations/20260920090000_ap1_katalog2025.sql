-- ============================================================================
-- AP1-Trainer - Erweiterung auf den vollstaendigen Pruefungskatalog 2025
--
-- Bringt drei Dinge:
--   1. Die sieben Katalogbereiche als eigene Tabelle; Themen bekommen eine
--      Bereichszuordnung.
--   2. Einen Katalogstatus an den Aufgaben, damit ab 2025 gestrichene Themen
--      erhalten bleiben, aber nie ausgewaehlt werden.
--   3. Lernkarteikarten samt Leitner-Lernstand je Nutzer.
--
-- Ausfuehren NACH 20260919090000_ap1_schema.sql.
-- Idempotent: mehrfaches Ausfuehren schadet nicht.
-- ============================================================================

-- ------------------------------------------------------ Katalogbereiche ---
create table if not exists public.ap1_areas (
  id         text primary key,
  -- Zweistellige Katalognummer, z. B. "01".
  number     text         not null,
  title      text         not null,
  blurb      text         not null default '',
  -- Geschaetzter Punkteanteil in der AP1; Summe ueber alle Bereiche = 1.
  weight     numeric(4,3) not null check (weight > 0 and weight <= 1),
  sort_order int          not null default 0
);

comment on table public.ap1_areas is
  'Die sieben Bereiche des AP1-Pruefungskatalogs (Auflage 2025).';

alter table public.ap1_topics
  add column if not exists area_id text references public.ap1_areas(id);

create index if not exists ap1_topics_area_idx on public.ap1_topics (area_id);

-- ------------------------------------------------------- Katalogstatus ---
-- 'current'     = im Katalog ab 2025 enthalten
-- 'removed2025' = gestrichen; bleibt als Nachschlagewerk erhalten, wird aber
--                 nicht mehr in Uebungen oder Simulationen ausgewaehlt
alter table public.ap1_questions
  add column if not exists catalog_status text not null default 'current';

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'ap1_questions_catalog_status_chk'
  ) then
    alter table public.ap1_questions
      add constraint ap1_questions_catalog_status_chk
      check (catalog_status in ('current', 'removed2025'));
  end if;
end $$;

-- Der Teilindex bedient die haeufigste Abfrage der App: alle aktiven,
-- pruefungsrelevanten Aufgaben.
create index if not exists ap1_questions_relevant_idx
  on public.ap1_questions (topic_id)
  where is_active and catalog_status = 'current';

-- --------------------------------------------------------- Karteikarten ---
create table if not exists public.ap1_flashcards (
  id         text primary key,
  topic_id   text        not null references public.ap1_topics(id) on delete cascade,
  -- Vorderseite: Begriff, Abkuerzung oder kurze Frage.
  front      text        not null,
  -- Rueckseite: die Antwort, bewusst kurz.
  back       text        not null,
  -- Optionale Eselsbruecke oder Abgrenzung.
  hint       text,
  tags       text[]      not null default '{}',
  is_active  boolean     not null default true,
  sort_order int         not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists ap1_flashcards_topic_idx
  on public.ap1_flashcards (topic_id) where is_active;

drop trigger if exists ap1_flashcards_touch on public.ap1_flashcards;
create trigger ap1_flashcards_touch
  before update on public.ap1_flashcards
  for each row execute function public.ap1_touch_updated_at();

-- ------------------------------------------------ Lernstand je Karte ---
-- Anders als ap1_attempts ist das kein Ereignisprotokoll, sondern der
-- aktuelle Zustand einer Karte: In welchem Leitner-Fach liegt sie, wann ist
-- sie wieder faellig? Genau ein Datensatz je Nutzer und Karte.
create table if not exists public.ap1_card_states (
  user_id       uuid        not null references auth.users(id) on delete cascade,
  card_id       text        not null references public.ap1_flashcards(id) on delete cascade,
  box           smallint    not null default 1 check (box between 1 and 5),
  due_on        date,
  last_seen_at  timestamptz,
  times_correct int         not null default 0 check (times_correct >= 0),
  times_wrong   int         not null default 0 check (times_wrong >= 0),
  updated_at    timestamptz not null default now(),
  primary key (user_id, card_id)
);

-- Die Abfrage "was ist heute faellig" laeuft ueber genau diese beiden Spalten.
create index if not exists ap1_card_states_due_idx
  on public.ap1_card_states (user_id, due_on);

drop trigger if exists ap1_card_states_touch on public.ap1_card_states;
create trigger ap1_card_states_touch
  before update on public.ap1_card_states
  for each row execute function public.ap1_touch_updated_at();

-- ================================================== Row Level Security ===

alter table public.ap1_areas       enable row level security;
alter table public.ap1_flashcards  enable row level security;
alter table public.ap1_card_states enable row level security;

-- Lerninhalte sind oeffentlich lesbar; geschrieben wird nur mit dem
-- Service-Role-Key aus der Redaktion.
drop policy if exists ap1_areas_read on public.ap1_areas;
create policy ap1_areas_read on public.ap1_areas
  for select to anon, authenticated using (true);

drop policy if exists ap1_flashcards_read on public.ap1_flashcards;
create policy ap1_flashcards_read on public.ap1_flashcards
  for select to anon, authenticated using (is_active);

-- Der Lernstand ist persoenlich. Anders als bei ap1_attempts ist hier ein
-- Update ausdruecklich erlaubt - eine Karte wandert ja bei jeder Antwort in
-- ein anderes Fach.
drop policy if exists ap1_card_states_rw on public.ap1_card_states;
create policy ap1_card_states_rw on public.ap1_card_states
  for all to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- ============================================================== Sichten ===

-- Faellige Karten je Nutzer - was die App beim Start des Karteikastens
-- wissen will.
create or replace view public.ap1_due_cards
with (security_invoker = true) as
select
  s.user_id,
  f.id       as card_id,
  f.topic_id,
  t.area_id,
  s.box,
  s.due_on
from public.ap1_card_states s
join public.ap1_flashcards f on f.id = s.card_id
join public.ap1_topics t     on t.id = f.topic_id
where f.is_active
  and (s.due_on is null or s.due_on <= current_date);

-- Kontrolle:
--   select a.number, a.title,
--          count(distinct t.id)  as themen,
--          count(distinct q.id)  as aufgaben,
--          count(distinct f.id)  as karten
--   from public.ap1_areas a
--   left join public.ap1_topics t on t.area_id = a.id
--   left join public.ap1_questions q
--          on q.topic_id = t.id and q.catalog_status = 'current'
--   left join public.ap1_flashcards f on f.topic_id = t.id
--   group by a.number, a.title order by a.number;
