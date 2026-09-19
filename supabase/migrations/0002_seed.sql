-- ==========================================================================
-- AP1 Projektmanagement-Trainer - Inhalte
--
-- ACHTUNG: automatisch erzeugt. Nicht von Hand aendern.
-- Quelle:  lib/data/seed/*.dart
-- Befehl:  flutter test tool/generate_seed_sql_test.dart
--
-- Alle Aufgaben sind eigene Formulierungen im Stil der IHK-AP1,
-- keine Originalaufgaben (die sind urheberrechtlich geschuetzt).
-- ==========================================================================

begin;

-- Themen ----------------------------------------------------
insert into public.ap1_topics (id, title, blurb, weight, sort_order) values
  ('projektorganisation', 'Projektorganisation & Rollen', 'Projektarten, Aufbauorganisation, Stakeholder, Projektauftrag', 0.100, 0),
  ('vorgehensmodelle', 'Vorgehensmodelle & Phasen', 'Wasserfall, V-Modell, Spiralmodell, Phasenabgrenzung', 0.120, 1),
  ('agil_scrum', 'Agile Methoden & Scrum', 'Rollen, Artefakte, Events, Kanban, agiles Manifest', 0.160, 2),
  ('netzplan', 'Netzplantechnik', 'FAZ/FEZ/SAZ/SEZ, Puffer, kritischer Pfad', 0.180, 3),
  ('terminplanung', 'Gantt & Meilensteine', 'Balkenplan, Meilensteintrendanalyse, Ressourcenplanung', 0.100, 4),
  ('lastenheft', 'Lasten- & Pflichtenheft', 'Anforderungsarten, Abgrenzung, Inhalte, Abnahme', 0.140, 5),
  ('wirtschaftlichkeit', 'Wirtschaftlichkeit & Nutzwert', 'Angebotsvergleich, Nutzwertanalyse, Amortisation, TCO', 0.100, 6),
  ('qualitaet_risiko', 'Qualitaet & Risiko', 'QS-Massnahmen, Testarten, Risikomatrix, Massnahmenstrategien', 0.060, 7),
  ('abschluss', 'Abschluss & Kommunikation', 'Projektabschluss, Doku, Praesentation, Lessons Learned', 0.040, 8)
on conflict (id) do update set
  title = excluded.title,
  blurb = excluded.blurb,
  weight = excluded.weight,
  sort_order = excluded.sort_order;

-- Aufgaben --------------------------------------------------
insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'org-001',
  'projektorganisation',
  'multiple',
  null,
  'Welche Merkmale muessen nach DIN 69901 erfuellt sein, damit ein Vorhaben als Projekt gilt?',
  'Merksatz: E-Z-O-A - Einmaligkeit, Zielvorgabe mit Begrenzung, eigene Organisation, Abgrenzung. Groesse und Budget sind bewusst nicht Teil der Definition; sonst waere jede Norm laendes- und branchenabhaengig.',
  1,
  ARRAY['din69901', 'projektbegriff']::text[],
  null,
  '{"choices":[{"text":"Einmaligkeit der Bedingungen in ihrer Gesamtheit","is_correct":true,"rationale":"Kernmerkmal. Ein Vorhaben, das jeden Monat identisch ablaeuft, ist Tagesgeschaeft - kein Projekt."},{"text":"Zeitliche, finanzielle und personelle Begrenzung","is_correct":true,"rationale":"Ein Projekt hat einen definierten Anfang und ein definiertes Ende sowie ein festes Budget."},{"text":"Eine eigene, projektspezifische Organisation","is_correct":true,"rationale":"Projektleitung, Team und Entscheidungswege werden eigens fuer das Vorhaben festgelegt."},{"text":"Mindestens fuenf beteiligte Mitarbeitende","is_correct":false,"rationale":"Falsch. Die DIN nennt keine Mindestgroesse. Auch ein Zwei-Personen-Vorhaben kann ein Projekt sein."},{"text":"Ein Budget von mindestens 50.000 Euro","is_correct":false,"rationale":"Falsch. Es gibt keine Wertgrenze in der Norm. Unternehmen setzen intern manchmal Schwellen - das ist aber keine Definition."},{"text":"Abgrenzung gegenueber anderen Vorhaben","is_correct":true,"rationale":"Das Projekt muss inhaltlich und organisatorisch klar von der Linie und von anderen Projekten trennbar sein."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'org-002',
  'projektorganisation',
  'matching',
  null,
  'Ordne die Aussagen der passenden Form der Projektorganisation zu.',
  'Faustregel fuer die Pruefung: Je mehr Macht die Projektleitung hat, desto teurer und stoerender ist die Organisationsform fuer die Linie. Rein = viel Macht, hoher Aufwand. Stab = wenig Macht, wenig Aufwand. Matrix liegt dazwischen und wird am haeufigsten gewaehlt.',
  2,
  ARRAY['aufbauorganisation']::text[],
  null,
  '{"buckets":["Reine Projektorganisation","Matrix-Organisation","Stabs-/Einflussorganisation"],"match_items":[{"text":"Mitarbeitende werden vollstaendig aus der Linie herausgeloest.","bucket":0,"rationale":"Genau das ist das Kennzeichen der reinen (autonomen) Projektorganisation."},{"text":"Die Projektleitung hat volle fachliche und disziplinarische Weisungsbefugnis.","bucket":0,"rationale":"Nur hier ist die Weisungsbefugnis ungeteilt."},{"text":"Weisungsbefugnis ist zwischen Linien- und Projektleitung geteilt.","bucket":1,"rationale":"Der typische Kompromiss - und die typische Konfliktquelle der Matrix."},{"text":"Hohes Konfliktpotenzial durch zwei Vorgesetzte pro Person.","bucket":1,"rationale":"Das klassische Matrix-Problem: zwei Chefs, widerspruechliche Prioritaeten."},{"text":"Die Projektleitung koordiniert nur und kann keine Anweisungen geben.","bucket":2,"rationale":"Die Stabsstelle berichtet und koordiniert, entscheidet aber nicht."},{"text":"Geringster organisatorischer Aufwand, dafuer schwache Durchsetzungskraft.","bucket":2,"rationale":"Vorteil und Nachteil der Einflussorganisation in einem Satz."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'org-003',
  'projektorganisation',
  'single',
  'Bei der Einfuehrung eines neuen Ticketsystems hat der Betriebsrat hohen Einfluss auf die Entscheidung, zeigt bislang aber wenig Interesse am Projekt.',
  'Welche Strategie sieht die Stakeholder-Matrix (Einfluss/Interesse) fuer diese Gruppe vor?',
  'Die vier Felder der Stakeholder-Matrix:
- Einfluss hoch / Interesse hoch -> eng einbinden (manage closely)
- Einfluss hoch / Interesse niedrig -> zufriedenstellen (keep satisfied)
- Einfluss niedrig / Interesse hoch -> informieren (keep informed)
- Einfluss niedrig / Interesse niedrig -> beobachten (monitor)
In der Pruefung wird fast immer nach dem Feld "hoher Einfluss, geringes Interesse" gefragt, weil es das unintuitivste ist.',
  2,
  ARRAY['stakeholder']::text[],
  null,
  '{"choices":[{"text":"Zufriedenstellen - regelmaessig informieren, aber nicht ueberfrachten","is_correct":true,"rationale":"Richtig. Hoher Einfluss + geringes Interesse = \"keep satisfied\". Die Gruppe kann das Projekt kippen, will aber keine Detailflut."},{"text":"Eng einbinden - in alle Entscheidungen einbeziehen","is_correct":false,"rationale":"Das gilt fuer hohen Einfluss UND hohes Interesse. Hier wuerde es den Betriebsrat mit Details ueberfordern und Widerstand erzeugen."},{"text":"Beobachten - minimaler Aufwand","is_correct":false,"rationale":"Das gilt nur bei geringem Einfluss UND geringem Interesse. Wer den Betriebsrat so behandelt, erlebt spaetestens bei der Mitbestimmung eine Vollbremsung."},{"text":"Informieren - ausfuehrlich ueber Fortschritte berichten","is_correct":false,"rationale":"Das ist die Strategie fuer geringen Einfluss und hohes Interesse, z. B. interessierte Fachanwender."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'org-004',
  'projektorganisation',
  'multiple',
  null,
  'Welche Angaben gehoeren zwingend in einen Projektauftrag?',
  'Der Projektauftrag ist die Geburtsurkunde des Projekts: Ziel, Nicht-Ziel, Rahmen (Zeit/Budget), Verantwortliche. Alles, was Detailplanung ist (Netzplan, Architektur, Arbeitspakete), kommt danach.',
  2,
  ARRAY['projektauftrag']::text[],
  null,
  '{"choices":[{"text":"Projektziel und messbare Abnahmekriterien","is_correct":true,"rationale":"Ohne messbares Ziel ist spaeter nicht entscheidbar, ob das Projekt erfolgreich war."},{"text":"Benannte Projektleitung mit Befugnissen","is_correct":true,"rationale":"Der Auftrag legitimiert die Projektleitung - sonst hat sie im Unternehmen keinen Stand."},{"text":"Budget- und Terminrahmen","is_correct":true,"rationale":"Die beiden Eckpunkte des magischen Dreiecks neben dem Leistungsumfang."},{"text":"Vollstaendige technische Systemarchitektur","is_correct":false,"rationale":"Falsch. Die Architektur entsteht erst in der Planungs-/Entwurfsphase. Im Auftrag steht das WAS, nicht das WIE."},{"text":"Nicht-Ziele bzw. Abgrenzung des Projektumfangs","is_correct":true,"rationale":"Oft unterschaetzt: Was ausdruecklich NICHT Teil des Projekts ist, verhindert spaeteren Scope Creep."},{"text":"Der fertige Netzplan aller Vorgaenge","is_correct":false,"rationale":"Falsch. Der Netzplan ist ein Ergebnis der Planungsphase, nicht Voraussetzung des Auftrags."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'org-005',
  'projektorganisation',
  'single',
  'Zwei Wochen vor dem Releasetermin faellt auf, dass ein Modul mehr Aufwand braucht als geplant. Der Termin ist vertraglich fixiert, zusaetzliches Budget gibt es nicht.',
  'Welche Konsequenz ergibt sich zwangslaeufig aus dem magischen Dreieck?',
  'Magisches Dreieck: Zeit, Kosten, Leistung/Qualitaet. Sind zwei Groessen fixiert, ist die dritte die abhaengige Variable. In Pruefungsaufgaben steht die Loesung immer in der Aufgabenstellung: schau, welche zwei Ecken als "fest" beschrieben sind.',
  3,
  ARRAY['magisches_dreieck']::text[],
  null,
  '{"choices":[{"text":"Der Leistungsumfang muss reduziert werden.","is_correct":true,"rationale":"Richtig. Zeit und Kosten sind fixiert - im Dreieck bleibt nur die dritte Groesse, der Umfang (Qualitaet/Leistung), als Stellhebel."},{"text":"Die Qualitaetssicherung kann entfallen, ohne den Umfang zu aendern.","is_correct":false,"rationale":"Das ist keine neutrale Option: QS zu streichen ist selbst eine Reduzierung der Qualitaet - also ebenfalls eine Aenderung der dritten Groesse, nur eine besonders teure."},{"text":"Mehr Personal loest das Problem ohne Nebenwirkung.","is_correct":false,"rationale":"Erstens kostet mehr Personal Budget (das es nicht gibt), zweitens gilt Brooks Law: zusaetzliche Leute in einem spaeten Projekt verzoegern es zunaechst weiter."},{"text":"Das Projekt muss abgebrochen werden.","is_correct":false,"rationale":"Ein Abbruch ist eine mögliche Managemententscheidung, aber nicht die zwangslaeufige Folge des Dreiecks. Gefragt war die logische Konsequenz."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'vor-001',
  'vorgehensmodelle',
  'ordering',
  null,
  'Bringe die Phasen des Wasserfallmodells in die richtige Reihenfolge.',
  'Das Wasserfallmodell laeuft streng sequenziell: jede Phase endet mit einem freigegebenen Dokument, erst dann startet die naechste. Das ist zugleich sein groesster Nachteil - Fehler aus der Analyse fallen erst im Test auf, und dann ist die Korrektur am teuersten.',
  1,
  ARRAY['wasserfall']::text[],
  null,
  '{"ordered_items":["Analyse / Anforderungsdefinition","Entwurf (Design)","Implementierung","Test / Verifikation","Einfuehrung und Wartung"],"ordering_hint":"Von der ersten zur letzten Phase"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'vor-002',
  'vorgehensmodelle',
  'single',
  null,
  'Welcher Testart steht im V-Modell die Phase "Anforderungsdefinition" gegenueber?',
  'Die Ebenen des V-Modells von oben nach unten:
Anforderungsdefinition <-> Abnahmetest
Systemspezifikation <-> Systemtest
Architektur/Grobentwurf <-> Integrationstest
Feinentwurf/Modulspez. <-> Modultest (Unittest)
Merkhilfe: gleiche Hoehe im V = zusammengehoeriges Paar. Je hoeher, desto naeher am Kunden.',
  2,
  ARRAY['v-modell']::text[],
  null,
  '{"choices":[{"text":"Abnahmetest","is_correct":true,"rationale":"Richtig. Die oberste linke Ebene (Anforderungen des Auftraggebers) wird gegen die oberste rechte Ebene (Abnahmetest durch den Auftraggeber) geprueft."},{"text":"Modultest","is_correct":false,"rationale":"Der Modul-/Unittest liegt auf der untersten Ebene und prueft gegen die Modulspezifikation bzw. den Feinentwurf."},{"text":"Integrationstest","is_correct":false,"rationale":"Der Integrationstest gehoert zum Grobentwurf/Architektur - er prueft das Zusammenspiel der Komponenten."},{"text":"Systemtest","is_correct":false,"rationale":"Der Systemtest gehoert zur Systemspezifikation, also eine Ebene unterhalb der Anforderungsdefinition. Er prueft in der Testumgebung, der Abnahmetest beim Kunden."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'vor-003',
  'vorgehensmodelle',
  'matching',
  null,
  'Ordne jede Aussage dem Vorgehensmodell zu, das sie am besten beschreibt.',
  'Fuer die Pruefung reicht je ein Erkennungsmerkmal pro Modell: Wasserfall = sequenziell, V-Modell = Teststufen-Paare, Spiralmodell = Risikoanalyse pro Zyklus, Scrum = Inkremente in festen Sprints.',
  2,
  ARRAY['modellvergleich']::text[],
  null,
  '{"buckets":["Wasserfall","V-Modell","Spiralmodell","Scrum"],"match_items":[{"text":"Streng sequenziell, jede Phase endet mit einem Dokument.","bucket":0,"rationale":"Das Grundprinzip des Wasserfalls."},{"text":"Jeder Entwicklungsstufe ist eine passende Teststufe zugeordnet.","bucket":1,"rationale":"Das ist genau die Erweiterung, die das V-Modell gegenueber dem Wasserfall bringt."},{"text":"Wiederholte Zyklen mit expliziter Risikoanalyse zu Beginn jedes Zyklus.","bucket":2,"rationale":"Die Risikoanalyse pro Zyklus ist das Markenzeichen des Spiralmodells nach Boehm."},{"text":"Lieferung eines nutzbaren Inkrements am Ende jedes Sprints.","bucket":3,"rationale":"Das Increment ist ein Scrum-Artefakt; es muss die Definition of Done erfuellen."},{"text":"Anforderungen muessen zu Projektbeginn vollstaendig bekannt sein.","bucket":0,"rationale":"Die zentrale Voraussetzung - und Schwaeche - des Wasserfalls."},{"text":"Priorisierung der Arbeit erfolgt fortlaufend durch eine Rolle mit Produktverantwortung.","bucket":3,"rationale":"Der Product Owner verantwortet die Reihenfolge im Product Backlog."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'vor-004',
  'vorgehensmodelle',
  'multiple',
  'Ein Kunde moechte eine Web-Anwendung, hat aber nur eine grobe Vorstellung vom Funktionsumfang und erwartet, dass sich die Anforderungen waehrend der Entwicklung noch aendern.',
  'Welche Argumente sprechen hier fuer ein agiles Vorgehen?',
  'Entscheidungsregel: Sind die Anforderungen stabil und der Umfang vertraglich fix (z. B. Ausschreibung der oeffentlichen Hand), ist klassisch richtig. Sind sie unklar oder veraenderlich, ist agil richtig. Der haeufigste Fehler in der Pruefung ist die Behauptung, agil brauche keine Dokumentation.',
  2,
  ARRAY['agil_vs_klassisch']::text[],
  null,
  '{"choices":[{"text":"Anforderungen koennen zwischen den Iterationen angepasst werden.","is_correct":true,"rationale":"Genau der Fall aus dem Szenario: unklare, veraenderliche Anforderungen sind das Kernargument fuer agil."},{"text":"Der Kunde sieht nach jeder Iteration lauffaehige Software.","is_correct":true,"rationale":"Frueher Feedback-Zyklus. Fehlannahmen fallen nach Wochen auf, nicht nach Monaten."},{"text":"Das Projektbudget laesst sich von Anfang an exakt festschreiben.","is_correct":false,"rationale":"Falsch - das ist eine Staerke des klassischen Vorgehens. Agil arbeitet eher mit festem Budget und variablem Umfang."},{"text":"Der Dokumentationsaufwand entfaellt vollstaendig.","is_correct":false,"rationale":"Falsch. Das agile Manifest sagt \"funktionierende Software MEHR ALS umfassende Dokumentation\" - nicht \"statt\". Dokumentation wird reduziert, nicht abgeschafft."},{"text":"Das Risiko einer kompletten Fehlentwicklung sinkt.","is_correct":true,"rationale":"Durch kurze Zyklen und regelmaessige Abnahme kann man maximal eine Iteration in die falsche Richtung laufen."},{"text":"Ein vollstaendiges Pflichtenheft ist zu Projektbeginn erforderlich.","is_correct":false,"rationale":"Falsch, das ist klassisches Vorgehen. Agil startet mit einem priorisierten Backlog, das sich weiterentwickelt."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'vor-005',
  'vorgehensmodelle',
  'single',
  null,
  'Warum sind Fehler aus der Analysephase im Wasserfallmodell besonders teuer?',
  'Rule of Ten: Ein Fehler, der in der Analyse 1 Euro kostet, kostet im Entwurf 10, in der Implementierung 100 und beim Kunden 1.000 Euro. Genau dagegen arbeiten V-Modell (frueh definierte Tests) und agile Modelle (kurze Feedback-Schleifen).',
  3,
  ARRAY['wasserfall', 'fehlerkosten']::text[],
  null,
  '{"choices":[{"text":"Weil sie erst in der Testphase auffallen und dann alle darauf aufbauenden Phasen korrigiert werden muessen.","is_correct":true,"rationale":"Richtig. Der Aufwand zur Fehlerbehebung steigt mit jeder Phase etwa um den Faktor 10 (Rule of Ten)."},{"text":"Weil die Analysephase das teuerste Personal bindet.","is_correct":false,"rationale":"Die Personalkosten der Analyse sind nicht der Punkt. Entscheidend ist die Fortpflanzung des Fehlers durch alle Folgephasen."},{"text":"Weil das Wasserfallmodell keine Testphase vorsieht.","is_correct":false,"rationale":"Sachlich falsch: Test ist eine eigene Phase im Wasserfall. Nur liegt sie eben am Ende."},{"text":"Weil Analysefehler die Hardwarebeschaffung betreffen.","is_correct":false,"rationale":"Das ist ein Spezialfall, keine allgemeine Begruendung."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'scr-001',
  'agil_scrum',
  'single',
  null,
  'Wer entscheidet in Scrum ueber die Reihenfolge im Product Backlog?',
  'Kurzformel: Product Owner = WAS und in welcher Reihenfolge. Developers = WIE und wie viel. Scrum Master = DASS es funktioniert.',
  1,
  ARRAY['scrum', 'rollen']::text[],
  null,
  '{"choices":[{"text":"Product Owner","is_correct":true,"rationale":"Richtig. Der Product Owner verantwortet die Wertmaximierung und damit die Priorisierung. Er darf sich beraten lassen, entscheidet aber allein."},{"text":"Scrum Master","is_correct":false,"rationale":"Der Scrum Master verantwortet die Wirksamkeit von Scrum - er moderiert, raeumt Hindernisse weg und priorisiert gerade nicht."},{"text":"Die Developers","is_correct":false,"rationale":"Die Developers entscheiden, WIE und wie viel sie in einen Sprint nehmen, nicht in welcher Reihenfolge der Product Owner den Wert sieht."},{"text":"Der Lenkungsausschuss","is_correct":false,"rationale":"Ein Lenkungsausschuss ist ein Gremium des klassischen Projektmanagements und in Scrum nicht vorgesehen."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'scr-002',
  'agil_scrum',
  'ordering',
  null,
  'Bringe die Scrum-Events in die Reihenfolge, in der sie innerhalb eines Sprints stattfinden.',
  'Der Sprint selbst ist der Container fuer alle anderen Events. Wichtig fuer die Pruefung: Das Review kommt VOR der Retrospektive. Im Review geht es um das Produkt (mit Stakeholdern), in der Retrospektive um die Zusammenarbeit (nur das Scrum Team). Das Refinement ist kein eigenes Event, sondern eine laufende Taetigkeit.',
  2,
  ARRAY['scrum', 'events']::text[],
  null,
  '{"ordered_items":["Sprint Planning","Daily Scrum (taeglich)","Sprint Review","Sprint Retrospective"],"ordering_hint":"Vom Sprintbeginn bis zum Sprintende"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'scr-003',
  'agil_scrum',
  'single',
  null,
  'Wie lang ist die Timebox des Daily Scrum bei einem vierwoechigen Sprint?',
  'Timeboxen bei einem Monatssprint (kuerzere Sprints -> anteilig kuerzer):
- Sprint Planning: max. 8 Stunden
- Daily Scrum: 15 Minuten (immer)
- Sprint Review: max. 4 Stunden
- Sprint Retrospective: max. 3 Stunden
Merkhilfe 8-4-3 und das Daily als Konstante.',
  1,
  ARRAY['scrum', 'timebox']::text[],
  null,
  '{"choices":[{"text":"15 Minuten","is_correct":true,"rationale":"Richtig. Das Daily ist immer auf 15 Minuten begrenzt - unabhaengig von der Sprintlaenge. Das ist die einzige Timebox, die nicht mitwaechst."},{"text":"30 Minuten","is_correct":false,"rationale":"Nein. Diese Zahl verwechselt man leicht mit der anteiligen Skalierung anderer Events."},{"text":"1 Stunde","is_correct":false,"rationale":"Eine Stunde waere die Groessenordnung einer Retrospektive bei kurzen Sprints, nicht des Dailys."},{"text":"Vier Stunden","is_correct":false,"rationale":"Vier Stunden ist die Obergrenze des Sprint Reviews bei einem Monatssprint."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'scr-004',
  'agil_scrum',
  'matching',
  null,
  'Jedes Scrum-Artefakt hat ein "Commitment", das ihm Transparenz gibt. Ordne richtig zu.',
  'Drei Artefakte, drei Commitments: Product Backlog -> Product Goal, Sprint Backlog -> Sprint Goal, Increment -> Definition of Done. Diese Zuordnung wird gern gefragt, weil viele die DoD faelschlich dem Sprint Backlog zuordnen.',
  3,
  ARRAY['scrum', 'artefakte']::text[],
  null,
  '{"buckets":["Product Backlog","Sprint Backlog","Increment"],"match_items":[{"text":"Product Goal","bucket":0,"rationale":"Das Product Goal ist das langfristige Ziel, auf das das Product Backlog einzahlt."},{"text":"Sprint Goal","bucket":1,"rationale":"Das Sprint Goal ist das eine Ziel des Sprints und gehoert zum Sprint Backlog."},{"text":"Definition of Done","bucket":2,"rationale":"Die DoD beschreibt, wann ein Increment wirklich fertig - also potenziell auslieferbar - ist."},{"text":"Geordnete Liste aller bekannten Anforderungen an das Produkt","bucket":0,"rationale":"Das ist die Definition des Product Backlogs."},{"text":"Auswahl der Items plus Plan zur Umsetzung fuer die kommenden Wochen","bucket":1,"rationale":"Sprint Backlog = Sprint Goal + ausgewaehlte Items + Umsetzungsplan."},{"text":"Das konkrete, nutzbare Ergebnis am Ende des Sprints","bucket":2,"rationale":"Das Increment ist das Arbeitsergebnis, das die DoD erfuellt."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'scr-005',
  'agil_scrum',
  'numeric',
  'Ein Scrum-Team hat in den letzten drei Sprints 28, 32 und 30 Story Points abgeschlossen. Im Product Backlog liegen noch 270 Story Points.',
  'Wie viele weitere Sprints braucht das Team voraussichtlich? Runde auf volle Sprints auf.',
  'Rechenweg:
1. Durchschnittliche Velocity = (28 + 32 + 30) / 3 = 30 Story Points/Sprint
2. 270 SP / 30 SP je Sprint = 9 Sprints
Waere das Ergebnis krumm (z. B. 9,3), wird aufgerundet - ein halber Sprint existiert in der Planung nicht. Die Velocity wird immer aus abgeschlossenen (Definition of Done erfuellten) Items gebildet, nicht aus angefangenen.',
  2,
  ARRAY['scrum', 'velocity']::text[],
  null,
  '{"answer":9.0,"tolerance":0.0,"unit":"Sprints"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'scr-006',
  'agil_scrum',
  'single',
  null,
  'Wozu dient ein WIP-Limit in Kanban?',
  'Kanban-Kernpraktiken: Workflow visualisieren, WIP limitieren, Fluss steuern, Regeln explizit machen, Feedback etablieren, verbessern. Hintergrund ist das Littlesche Gesetz: Durchlaufzeit = WIP / Durchsatz. Weniger parallele Arbeit bedeutet direkt kuerzere Durchlaufzeiten.',
  2,
  ARRAY['kanban', 'wip']::text[],
  null,
  '{"choices":[{"text":"Es begrenzt die Anzahl gleichzeitig bearbeiteter Aufgaben und macht Engpaesse sichtbar.","is_correct":true,"rationale":"Richtig. Work in Progress zu begrenzen verkuerzt die Durchlaufzeit und zwingt das Team, Aufgaben fertigzustellen, statt neue anzufangen."},{"text":"Es legt fest, wie viele Story Points pro Sprint eingeplant werden.","is_correct":false,"rationale":"Das ist die Velocity in Scrum. Kanban kennt keine Sprints und keine feste Einplanung."},{"text":"Es begrenzt die maximale Teamgroesse.","is_correct":false,"rationale":"WIP bezieht sich auf Arbeit, nicht auf Personen."},{"text":"Es definiert, wie lange eine Aufgabe maximal dauern darf.","is_correct":false,"rationale":"Das waere eine Timebox bzw. ein Service Level Expectation - nicht das WIP-Limit."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'scr-007',
  'agil_scrum',
  'multiple',
  null,
  'Welche Aussagen ueber User Stories und deren Akzeptanzkriterien sind korrekt?',
  'INVEST als Qualitaetscheck fuer Stories: Independent, Negotiable, Valuable, Estimable, Small, Testable. Der klassische Pruefungsfallstrick ist die Abgrenzung Akzeptanzkriterien (pro Story, fachlich) gegen Definition of Done (teamweit, handwerklich).',
  3,
  ARRAY['scrum', 'user_story']::text[],
  null,
  '{"choices":[{"text":"Das Format lautet: Als <Rolle> moechte ich <Ziel>, um <Nutzen>.","is_correct":true,"rationale":"Das ist das Standardformat. Der \"um ... zu\"-Teil ist der wichtigste und wird am haeufigsten weggelassen."},{"text":"Akzeptanzkriterien legen fest, wann die Story als erfuellt gilt.","is_correct":true,"rationale":"Sie sind storyspezifisch und pruefbar - im Gegensatz zur Definition of Done, die fuer alle Stories gilt."},{"text":"Die Definition of Done ersetzt die Akzeptanzkriterien.","is_correct":false,"rationale":"Falsch. Die DoD gilt teamweit fuer JEDES Increment (z. B. Code-Review erfolgt, Tests gruen). Akzeptanzkriterien sind fachlich und gelten nur fuer diese eine Story. Beides muss erfuellt sein."},{"text":"Story Points schaetzen den Aufwand relativ, nicht in Stunden.","is_correct":true,"rationale":"Relative Schaetzung ist stabiler als absolute: Menschen vergleichen zuverlaessiger, als sie Stunden schaetzen."},{"text":"Eine User Story muss immer in einen Sprint passen.","is_correct":true,"rationale":"Passt sie nicht, wird sie im Refinement geteilt. Eine zu grosse Story heisst Epic."},{"text":"Der Scrum Master schreibt die User Stories.","is_correct":false,"rationale":"Falsch. Verantwortlich fuer das Product Backlog ist der Product Owner; formulieren kann sie jeder im Team."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'np-001',
  'netzplan',
  'netzplan',
  'Fuer die Einfuehrung eines Ticketsystems wurden folgende Vorgaenge geplant. Alle Zeiten in Arbeitstagen.',
  'Fuehre die Vorwaertsrechnung durch: trage FAZ und FEZ fuer jeden Vorgang ein.',
  'Vorwaertsrechnung, Regel: FAZ = groesster FEZ aller Vorgaenger (Startvorgang: 0), FEZ = FAZ + Dauer.

A: FAZ 0, FEZ 0+4 = 4
B: FAZ 4 (nach A), FEZ 4+3 = 7
C: FAZ 4 (nach A), FEZ 4+6 = 10
D: FAZ 7 (nach B), FEZ 7+5 = 12
E: FAZ = max(FEZ C = 10, FEZ D = 12) = 12, FEZ 12+2 = 14

Der haeufigste Fehler: bei E den kleineren Wert nehmen. Bei mehreren Vorgaengern gilt immer das MAXIMUM - der Vorgang kann erst starten, wenn der letzte Vorgaenger fertig ist. Projektdauer: 14 Arbeitstage.',
  1,
  ARRAY['vorwaertsrechnung']::text[],
  null,
  '{"activities":[{"id":"A","name":"Anforderungsanalyse","duration":4,"predecessors":[]},{"id":"B","name":"Grobkonzept","duration":3,"predecessors":["A"]},{"id":"C","name":"Hardwarebeschaffung","duration":6,"predecessors":["A"]},{"id":"D","name":"Implementierung","duration":5,"predecessors":["B"]},{"id":"E","name":"Integrationstest","duration":2,"predecessors":["C","D"]}],"asked_fields":["faz","fez"]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'np-002',
  'netzplan',
  'netzplan',
  'Migration eines Warenwirtschaftssystems. Dauer in Arbeitstagen.',
  'Berechne den kompletten Netzplan: FAZ, FEZ, SAZ, SEZ sowie Gesamt- und freien Puffer.',
  'Vorwaerts (FAZ = max FEZ der Vorgaenger, FEZ = FAZ + D):
A 0/3, B 3/8, C 3/5, D 8/12, E 5/11, F max(12,11)=12/15
Projektdauer = 15 Arbeitstage.

Rueckwaerts (SEZ = min SAZ der Nachfolger, Endvorgang: SEZ = Projektdauer, SAZ = SEZ - D):
F 12/15, D 8/12, E 6/12, B 3/8, C 4/6, A 0/3

Puffer:
GP = SAZ - FAZ  ->  A 0, B 0, C 1, D 0, E 1, F 0
FP = min(FAZ der Nachfolger) - FEZ  ->  A 0, B 0, C 0, D 0, E 1, F 0

Der Lerneffekt steckt in Vorgang C: GP = 1, aber FP = 0. Man kann C zwar um einen Tag verschieben, ohne das Projektende zu gefaehrden - aber der Nachfolger E startet dann spaeter. Freier Puffer heisst: verschiebbar OHNE den fruehesten Start des Nachfolgers anzutasten. Kritischer Pfad: A - B - D - F.',
  2,
  ARRAY['vollstaendig', 'puffer']::text[],
  null,
  '{"activities":[{"id":"A","name":"Ist-Analyse","duration":3,"predecessors":[]},{"id":"B","name":"Datenmodell","duration":5,"predecessors":["A"]},{"id":"C","name":"Schulungskonzept","duration":2,"predecessors":["A"]},{"id":"D","name":"Migrationsskripte","duration":4,"predecessors":["B"]},{"id":"E","name":"Schulung","duration":6,"predecessors":["C"]},{"id":"F","name":"Go-Live","duration":3,"predecessors":["D","E"]}],"asked_fields":["faz","fez","saz","sez","gp","fp"]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'np-003',
  'netzplan',
  'numeric',
  'Gegeben ist folgender Netzplan (Dauer in Tagen):
A: 2 Tage, kein Vorgaenger
B: 4 Tage, Vorgaenger A
C: 3 Tage, Vorgaenger A
D: 5 Tage, Vorgaenger B
E: 2 Tage, Vorgaenger C
F: 1 Tag, Vorgaenger D und E',
  'Wie gross ist der Gesamtpuffer (GP) von Vorgang C?',
  'Vorwaertsrechnung:
A 0/2, B 2/6, C 2/5, D 6/11, E 5/7, F max(11,7)=11/12 -> Projektdauer 12

Rueckwaertsrechnung:
F 11/12, D 6/11, E 9/11, B 2/6, C 6/9, A 0/2

GP(C) = SAZ(C) - FAZ(C) = 6 - 2 = 4 Tage.
Gegenprobe ueber die andere Formel: GP = SEZ - FEZ = 9 - 5 = 4. Stimmen beide Werte nicht ueberein, steckt ein Rechenfehler in der Rueckwaertsrechnung.',
  2,
  ARRAY['gesamtpuffer']::text[],
  null,
  '{"answer":4.0,"tolerance":0.0,"unit":"Tage"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'np-004',
  'netzplan',
  'single',
  null,
  'Was sagt der freie Puffer (FP) eines Vorgangs aus?',
  'GP = SAZ - FAZ = SEZ - FEZ: Spielraum bis das PROJEKTENDE kippt.
FP = min(FAZ der Nachfolger) - FEZ: Spielraum bis der NACHFOLGER betroffen ist.
Es gilt immer FP <= GP. Auf dem kritischen Pfad sind beide 0. Ein Vorgang mit GP > 0 und FP = 0 hat zwar Luft bis zum Projektende, nimmt sie aber direkt dem Nachfolger weg.',
  2,
  ARRAY['puffer', 'definition']::text[],
  null,
  '{"choices":[{"text":"Die Zeit, um die der Vorgang verschoben werden kann, ohne den fruehesten Anfang seiner Nachfolger zu veraendern.","is_correct":true,"rationale":"Richtig. FP = kleinster FAZ der Nachfolger minus eigener FEZ. Diesen Puffer darf man aufbrauchen, ohne dass es irgendjemand anders merkt."},{"text":"Die Zeit, um die der Vorgang verschoben werden kann, ohne das Projektende zu gefaehrden.","is_correct":false,"rationale":"Das ist die Definition des GESAMTpuffers (GP = SAZ - FAZ). Der GP ist immer groesser oder gleich dem FP."},{"text":"Die Differenz zwischen geplanter und tatsaechlicher Dauer.","is_correct":false,"rationale":"Das waere eine Abweichung im Projektcontrolling, kein Puffer aus der Netzplantechnik."},{"text":"Die Reservezeit, die das Projektteam zusaetzlich einplant.","is_correct":false,"rationale":"Das ist eine Sicherheitsreserve. Puffer im Netzplan werden berechnet, nicht eingeplant."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'np-005',
  'netzplan',
  'multiple',
  null,
  'Welche Aussagen ueber den kritischen Pfad sind richtig?',
  'Der kritische Pfad ist der laengste Weg vom Start- zum Endvorgang und damit die Kette ohne Puffer. Praktische Konsequenz fuers Projekt: Ressourcen und Aufmerksamkeit gehoeren zuerst dorthin. Bei Verkuerzungsaufgaben immer nach jedem Schritt neu rechnen - der kritische Pfad kann wandern.',
  2,
  ARRAY['kritischer_pfad']::text[],
  null,
  '{"choices":[{"text":"Alle Vorgaenge auf ihm haben einen Gesamtpuffer von 0.","is_correct":true,"rationale":"Das ist die Definition. Genau daran erkennt man ihn in der Rechnung."},{"text":"Er ist der laengste Weg durch den Netzplan.","is_correct":true,"rationale":"Der laengste Weg bestimmt die Projektdauer - deshalb hat er keinen Puffer."},{"text":"Verzoegert sich ein Vorgang auf ihm um 2 Tage, verzoegert sich das Projektende um 2 Tage.","is_correct":true,"rationale":"Ohne Puffer schlaegt jede Verzoegerung eins zu eins aufs Projektende durch."},{"text":"Ein Netzplan hat immer genau einen kritischen Pfad.","is_correct":false,"rationale":"Falsch. Es kann mehrere gleich lange kritische Pfade geben - dann ist das Projekt besonders anfaellig, weil es mehrere pufferlose Ketten gibt."},{"text":"Er enthaelt immer die Vorgaenge mit der laengsten Einzeldauer.","is_correct":false,"rationale":"Falsch. Ein einzelner langer Vorgang kann parallel liegen und viel Puffer haben. Entscheidend ist die Kette, nicht die Einzeldauer."},{"text":"Eine Verkuerzung eines Vorgangs auf dem kritischen Pfad verkuerzt immer das Projekt um denselben Betrag.","is_correct":false,"rationale":"Falsch, und das ist der beliebteste Stolperstein: verkuerzt man genug, wird ein anderer Weg zum kritischen Pfad und die Verkuerzung verpufft ab diesem Punkt."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'np-006',
  'netzplan',
  'netzplan',
  'Aufbau eines neuen Serverraums, sieben Vorgaenge, Dauer in Arbeitstagen.',
  'Ermittle fuer jeden Vorgang den Gesamtpuffer und den freien Puffer.',
  'Vorwaerts: A 0/2, B 2/6, C 2/8, D 6/9, E 6/8, F max(9,8)=9/13, G max(8,13)=13/16. Projektdauer 16 Tage.

Rueckwaerts: G 13/16, F 9/13, E 11/13, D 6/9, C 3/9, B 2/6, A 0/2.

GP = SAZ - FAZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0
FP = min(FAZ Nachfolger) - FEZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0

Kritischer Pfad: A - B - D - F - G (16 Tage).
Vorgang E hat mit 5 Tagen den groessten Spielraum - hier kann man ohne Risiko Personal abziehen, wenn es auf dem kritischen Pfad brennt. Achtung bei C: die Lieferung dauert zwar am laengsten (6 Tage), liegt aber trotzdem nicht auf dem kritischen Pfad.',
  3,
  ARRAY['puffer', 'kritischer_pfad']::text[],
  null,
  '{"activities":[{"id":"A","name":"Planung","duration":2,"predecessors":[]},{"id":"B","name":"Elektro-Vorbereitung","duration":4,"predecessors":["A"]},{"id":"C","name":"Lieferung Racks","duration":6,"predecessors":["A"]},{"id":"D","name":"Klimatechnik","duration":3,"predecessors":["B"]},{"id":"E","name":"Netzwerkverkabelung","duration":2,"predecessors":["B"]},{"id":"F","name":"Hardware-Montage","duration":4,"predecessors":["D","C"]},{"id":"G","name":"Inbetriebnahme","duration":3,"predecessors":["E","F"]}],"asked_fields":["gp","fp"]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'np-007',
  'netzplan',
  'numeric',
  'A: 5 Tage, kein Vorgaenger
B: 3 Tage, kein Vorgaenger
C: 4 Tage, Vorgaenger A und B
D: 6 Tage, Vorgaenger A
E: 2 Tage, Vorgaenger C und D',
  'Wie lang dauert das Gesamtprojekt?',
  'Alle Wege durchrechnen und den laengsten nehmen:
A - C - E = 5 + 4 + 2 = 11
B - C - E = 3 + 4 + 2 = 9
A - D - E = 5 + 6 + 2 = 13  <- laengster Weg
Projektdauer = 13 Tage, kritischer Pfad A - D - E.
Kontrolle ueber die Vorwaertsrechnung: C startet bei max(5, 3) = 5, endet bei 9. D endet bei 11. E startet bei max(9, 11) = 11 und endet bei 13.',
  1,
  ARRAY['projektdauer']::text[],
  null,
  '{"answer":13.0,"tolerance":0.0,"unit":"Tage"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'tp-001',
  'terminplanung',
  'single',
  null,
  'Welchen Vorteil hat ein Netzplan gegenueber einem einfachen Balkenplan (Gantt-Diagramm)?',
  'Arbeitsteilung in der Praxis: mit dem Netzplan rechnen, mit dem Balkenplan kommunizieren. Moderne Tools erzeugen den Gantt direkt aus den Netzplandaten und zeichnen den kritischen Pfad rot ein - in der Pruefung muss man beides aber getrennt beherrschen.',
  2,
  ARRAY['gantt']::text[],
  null,
  '{"choices":[{"text":"Er zeigt Abhaengigkeiten und Puffer explizit und macht den kritischen Pfad berechenbar.","is_correct":true,"rationale":"Richtig. Der Netzplan ist ein Rechenmodell: Puffer und kritischer Pfad ergeben sich rechnerisch, nicht durch Hinsehen."},{"text":"Er stellt den Zeitverlauf anschaulicher dar.","is_correct":false,"rationale":"Das ist gerade die Staerke des Balkenplans: Die Zeitachse ist massstabsgetreu und auf einen Blick lesbar."},{"text":"Er benoetigt keine Angabe von Vorgangsdauern.","is_correct":false,"rationale":"Ohne Dauern gibt es keine Vorwaerts- und Rueckwaertsrechnung. Der Netzplan braucht sie zwingend."},{"text":"Er eignet sich besser fuer die Praesentation vor der Geschaeftsfuehrung.","is_correct":false,"rationale":"Umgekehrt. Fuer Praesentationen nimmt man den Balkenplan, weil er ohne Erklaerung verstaendlich ist."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'tp-002',
  'terminplanung',
  'single',
  null,
  'Was kennzeichnet einen Meilenstein in der Projektplanung?',
  'Meilensteine sind Entscheidungspunkte: Ergebnis da oder nicht, weiter oder nicht. Gute Meilensteine sind binaer pruefbar formuliert ("Pflichtenheft vom Kunden unterzeichnet"), nicht schwammig ("Konzept weitgehend fertig"). In der Meilensteintrendanalyse (MTA) traegt man ueber die Zeit auf, wie sich die geplanten Meilensteintermine verschieben - eine steigende Linie bedeutet Verzug.',
  1,
  ARRAY['meilenstein']::text[],
  null,
  '{"choices":[{"text":"Ein Ereignis mit der Dauer null, an dem ein definiertes Zwischenergebnis vorliegt.","is_correct":true,"rationale":"Richtig. Ein Meilenstein verbraucht keine Zeit und keine Ressourcen - er stellt nur fest, ob ein Ergebnis erreicht ist."},{"text":"Der laengste Vorgang im Projekt.","is_correct":false,"rationale":"Das hat mit Meilensteinen nichts zu tun; lange Vorgaenge sind einfach Vorgaenge."},{"text":"Ein Vorgang, der besonders viel Budget bindet.","is_correct":false,"rationale":"Budget ist kein Kriterium. Ein Meilenstein kostet definitionsgemaess nichts."},{"text":"Der Abschluss des gesamten Projekts.","is_correct":false,"rationale":"Der Projektabschluss IST ein Meilenstein, aber Meilensteine gibt es waehrend des gesamten Projekts."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'tp-003',
  'terminplanung',
  'multiple',
  null,
  'Ein Meilensteintrendanalyse-Diagramm zeigt fuer einen Meilenstein eine nach oben steigende Linie. Welche Schluesse sind zulaessig?',
  'MTA-Lesehilfe: waagerecht = im Plan, steigend = Verzug, fallend = frueher fertig, Zickzack = unsichere Schaetzung bzw. instabile Planung. Ein Zickzack ist ein Warnsignal fuer die Planungsqualitaet, auch wenn der Endtermin am Ende stimmt.',
  2,
  ARRAY['mta']::text[],
  null,
  '{"choices":[{"text":"Der Meilenstein verschiebt sich immer weiter nach hinten.","is_correct":true,"rationale":"Richtig. Steigende Linie = der prognostizierte Termin wird bei jedem Berichtszeitpunkt spaeter."},{"text":"Es besteht Handlungsbedarf, z. B. Ressourcen umsteuern oder Umfang kuerzen.","is_correct":true,"rationale":"Die MTA ist ein Fruehwarninstrument - der Zweck ist genau dieses Gegensteuern."},{"text":"Der Meilenstein wird frueher als geplant erreicht.","is_correct":false,"rationale":"Falsch, das waere eine FALLENDE Linie. Steigend = spaeter."},{"text":"Das Projekt liegt im Plan.","is_correct":false,"rationale":"Falsch. Im Plan bedeutet eine waagerechte Linie."},{"text":"Die Ursache der Verzoegerung laesst sich direkt aus dem Diagramm ablesen.","is_correct":false,"rationale":"Falsch. Die MTA zeigt, DASS sich etwas verschiebt, nicht WARUM. Die Ursachenanalyse ist eine separate Aufgabe."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'tp-004',
  'terminplanung',
  'numeric',
  'Fuer ein Arbeitspaket sind 120 Personentage veranschlagt. Es stehen 4 Entwickler zur Verfuegung, die jedoch nur zu 75 % fuer das Projekt verfuegbar sind (der Rest geht in Support und Linientaetigkeit).',
  'Wie viele Arbeitstage dauert das Arbeitspaket? Runde auf volle Tage auf.',
  'Rechenweg:
1. Tatsaechliche Kapazitaet pro Tag = 4 Entwickler x 0,75 = 3 Personentage/Tag
2. Dauer = 120 Personentage / 3 Personentage pro Tag = 40 Arbeitstage

Typischer Fehler: 120 / 4 = 30 Tage - die Verfuegbarkeit wird vergessen. In Pruefungsaufgaben ist der Verfuegbarkeitsgrad fast immer der eigentliche Pruefpunkt. Merke ausserdem: Personentage sind Aufwand, Arbeitstage sind Dauer. Die beiden Einheiten zu verwechseln kostet in der Klausur sofort Punkte.',
  3,
  ARRAY['ressourcenplanung']::text[],
  null,
  '{"answer":40.0,"tolerance":0.0,"unit":"Arbeitstage"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'lh-001',
  'lastenheft',
  'matching',
  null,
  'Ordne jede Aussage dem richtigen Dokument zu. (Nach DIN 69901-5)',
  'Eselsbruecke: LAstenheft = Auftraggeber (der die Last verteilt), PFlichtenheft = Auftragnehmer (der die Pflicht uebernimmt). Reihenfolge: Lastenheft -> Ausschreibung -> Angebote -> Zuschlag -> Pflichtenheft -> Genehmigung -> Umsetzung -> Abnahme gegen das Pflichtenheft.',
  1,
  ARRAY['lastenheft', 'pflichtenheft']::text[],
  null,
  '{"buckets":["Lastenheft","Pflichtenheft"],"match_items":[{"text":"Wird vom Auftraggeber erstellt.","bucket":0,"rationale":"Merksatz: Der Auftraggeber laedt dem Auftragnehmer die Last auf."},{"text":"Wird vom Auftragnehmer erstellt.","bucket":1,"rationale":"Der Auftragnehmer beschreibt, wie er die Pflicht erfuellt."},{"text":"Beschreibt das WAS und WOFUER - die Gesamtheit der Anforderungen.","bucket":0,"rationale":"Das Lastenheft ist bewusst loesungsneutral formuliert."},{"text":"Beschreibt das WIE und WOMIT - die konkrete technische Umsetzung.","bucket":1,"rationale":"Erst im Pflichtenheft werden Technologien, Schnittstellen und Architektur festgelegt."},{"text":"Ist Grundlage fuer die Ausschreibung und den Angebotsvergleich.","bucket":0,"rationale":"Alle Anbieter bekommen dasselbe Lastenheft - nur so sind Angebote vergleichbar."},{"text":"Wird vom Auftraggeber genehmigt und ist Grundlage der Abnahme.","bucket":1,"rationale":"Das genehmigte Pflichtenheft ist der vertragliche Massstab, gegen den abgenommen wird."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'lh-002',
  'lastenheft',
  'matching',
  null,
  'Handelt es sich um eine funktionale oder eine nicht-funktionale Anforderung?',
  'Testfrage zur Abgrenzung: Kann man die Anforderung als "Das System TUT etwas" formulieren? Dann funktional. Beschreibt sie eher, WIE GUT das System etwas tut (schnell, sicher, verfuegbar, bedienbar, wartbar, portabel), dann nicht-funktional. Die sechs Qualitaetsmerkmale nach ISO 25010 sind eine gute Checkliste fuer nicht-funktionale Anforderungen.',
  2,
  ARRAY['anforderungsarten']::text[],
  null,
  '{"buckets":["Funktional","Nicht-funktional"],"match_items":[{"text":"Das System muss Rechnungen als PDF exportieren koennen.","bucket":0,"rationale":"Eine konkrete Faehigkeit des Systems - also funktional."},{"text":"Die Suchanfrage muss in unter 2 Sekunden beantwortet werden.","bucket":1,"rationale":"Performance ist eine Qualitaetseigenschaft, kein Funktionsumfang."},{"text":"Benutzer muessen sich mit Zwei-Faktor-Authentifizierung anmelden koennen.","bucket":0,"rationale":"Die Anmeldung mit 2FA ist eine Funktion, die das System bereitstellen muss."},{"text":"Die Anwendung muss zu 99,5 % im Jahr verfuegbar sein.","bucket":1,"rationale":"Verfuegbarkeit ist eine klassische nicht-funktionale Anforderung."},{"text":"Die Oberflaeche muss der BITV 2.0 fuer Barrierefreiheit entsprechen.","bucket":1,"rationale":"Eine Randbedingung bzw. Qualitaetsanforderung - sie beschreibt keine einzelne Funktion."},{"text":"Administratoren koennen Benutzerkonten sperren und entsperren.","bucket":0,"rationale":"Wieder eine konkrete Faehigkeit - funktional."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'lh-003',
  'lastenheft',
  'multiple',
  null,
  'Was zeichnet eine gut formulierte Anforderung aus?',
  'Merkhilfe fuer Anforderungsqualitaet: eindeutig, vollstaendig, widerspruchsfrei, pruefbar, notwendig, verstaendlich, priorisiert. Priorisierung erfolgt oft nach MuSCoW: Must have, Should have, Could have, Won t have.',
  2,
  ARRAY['anforderungsqualitaet']::text[],
  null,
  '{"choices":[{"text":"Sie ist eindeutig und laesst nur eine Interpretation zu.","is_correct":true,"rationale":"Mehrdeutigkeit ist die Hauptursache fuer Streit bei der Abnahme."},{"text":"Sie ist ueberpruefbar bzw. testbar.","is_correct":true,"rationale":"Wenn niemand entscheiden kann, ob sie erfuellt ist, ist sie wertlos."},{"text":"Sie ist vollstaendig - es fehlen keine notwendigen Angaben.","is_correct":true,"rationale":"Klassisches Kriterium aus der Anforderungsanalyse."},{"text":"Sie enthaelt bereits die technische Loesung.","is_correct":false,"rationale":"Falsch, zumindest im Lastenheft. Eine vorweggenommene Loesung schliesst bessere Alternativen aus. Das WIE gehoert ins Pflichtenheft."},{"text":"Sie ist mit anderen Anforderungen widerspruchsfrei.","is_correct":true,"rationale":"Widersprueche fallen sonst erst in der Umsetzung auf - dann ist die Korrektur teuer."},{"text":"Sie ist moeglichst allgemein gehalten, um flexibel zu bleiben.","is_correct":false,"rationale":"Falsch. \"Das System soll benutzerfreundlich sein\" ist nicht flexibel, sondern unpruefbar. Flexibilitaet erreicht man ueber Prioritaeten, nicht ueber Vagheit."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'lh-004',
  'lastenheft',
  'single',
  'Ein Dienstleister liefert eine Software aus. Bei der Abnahme stellt der Kunde zwei kleinere Maengel fest, die den Betrieb nicht verhindern.',
  'Was ist die uebliche und rechtlich sinnvolle Vorgehensweise?',
  'Was an der Abnahme haengt: Faelligkeit der Verguetung, Gefahruebergang, Beginn der Verjaehrungsfrist fuer Gewaehrleistung und die Umkehr der Beweislast (danach muss der Kunde den Mangel beweisen). Deshalb ist das Abnahmeprotokoll mit Maengelliste kein Formalkram, sondern der wichtigste Zettel im Projekt.',
  2,
  ARRAY['abnahme']::text[],
  null,
  '{"choices":[{"text":"Abnahme unter Vorbehalt: Maengel werden protokolliert und mit Frist zur Beseitigung vereinbart.","is_correct":true,"rationale":"Richtig. Die Abnahme unter Vorbehalt haelt die Maengelrechte aufrecht und blockiert trotzdem nicht den Produktivstart."},{"text":"Vollstaendige Verweigerung der Abnahme bis alle Maengel beseitigt sind.","is_correct":false,"rationale":"Bei unwesentlichen Maengeln ist die Verweigerung in der Regel unzulaessig (vgl. Werkvertragsrecht) und schadet dem Kunden selbst, weil der Nutzen ausbleibt."},{"text":"Vorbehaltlose Abnahme, die Maengel werden formlos per E-Mail gemeldet.","is_correct":false,"rationale":"Gefaehrlich: Mit der vorbehaltlosen Abnahme verliert der Kunde bei bekannten Maengeln seine Rechte darauf."},{"text":"Die Abnahme entfaellt, weil die Software bereits laeuft.","is_correct":false,"rationale":"Die Abnahme ist ein formaler Rechtsakt mit erheblichen Folgen (Gefahruebergang, Faelligkeit der Verguetung, Beginn der Gewaehrleistung). Sie entfaellt nicht durch Nutzung - im Gegenteil kann Nutzung als konkludente Abnahme gelten."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'lh-005',
  'lastenheft',
  'ordering',
  null,
  'Bringe die Schritte einer klassischen Fremdvergabe in die richtige Reihenfolge.',
  'Die zwei Stellen, an denen in der Pruefung gern getauscht wird: (1) Das Pflichtenheft kommt NACH der Vergabe - vorher weiss man ja gar nicht, wer es schreibt. (2) Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft, weil nur das Pflichtenheft die pruefbare Konkretisierung enthaelt.',
  2,
  ARRAY['ablauf']::text[],
  null,
  '{"ordered_items":["Lastenheft durch den Auftraggeber erstellen","Ausschreibung und Einholung von Angeboten","Angebotsvergleich und Vergabeentscheidung","Pflichtenheft durch den Auftragnehmer erstellen","Genehmigung des Pflichtenhefts durch den Auftraggeber","Realisierung","Abnahme gegen das Pflichtenheft"],"ordering_hint":"Vom ersten bis zum letzten Schritt"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'lh-006',
  'lastenheft',
  'single',
  'Waehrend der Realisierung bittet die Fachabteilung den Entwickler mehrfach direkt um "kleine Zusatzfunktionen". Der Termin ist unveraendert.',
  'Wie sollte die Projektleitung darauf reagieren?',
  'Change-Request-Prozess: Antrag erfassen -> Auswirkung auf Zeit, Kosten und Qualitaet bewerten -> Entscheidung durch den befugten Gremium bzw. Auftraggeber -> bei Annahme Planung und Pflichtenheft fortschreiben. Der Kern ist Transparenz: Jeder soll sehen, was eine Aenderung kostet.',
  3,
  ARRAY['scope_creep']::text[],
  null,
  '{"choices":[{"text":"Jede Aenderung ueber einen definierten Change-Request-Prozess mit Aufwands- und Terminbewertung fuehren.","is_correct":true,"rationale":"Richtig. Aenderungen sind nicht verboten - sie muessen nur bewertet und entschieden werden, statt still im Hintergrund zu passieren."},{"text":"Die Zusatzwuensche ablehnen, weil das Pflichtenheft unterschrieben ist.","is_correct":false,"rationale":"Pauschale Ablehnung ist praxisfern und beschaedigt die Zusammenarbeit. Anforderungen aendern sich - das Problem ist der unkontrollierte Weg, nicht die Aenderung selbst."},{"text":"Die Wuensche kurzfristig mit umsetzen, solange sie klein sind.","is_correct":false,"rationale":"Genau so entsteht Scope Creep: viele kleine, nie bewertete Erweiterungen sprengen am Ende Termin und Budget, und niemand kann hinterher sagen, warum."},{"text":"Die Entscheidung dem Entwickler ueberlassen, der den Aufwand am besten einschaetzen kann.","is_correct":false,"rationale":"Der Entwickler kann den Aufwand schaetzen, aber nicht ueber Umfang, Budget und Termin entscheiden. Das ist eine Projektleitungs- bzw. Auftraggeberentscheidung."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'wi-001',
  'wirtschaftlichkeit',
  'numeric',
  'Nutzwertanalyse fuer ein Ticketsystem. Bewertungsskala 1 (schlecht) bis 5 (sehr gut).

Kriterium (Gewichtung) - Bewertung Anbieter B:
Funktionsumfang (40 %) - 4
Bedienbarkeit (25 %) - 3
Support (20 %) - 5
Preis (15 %) - 2',
  'Wie hoch ist der Gesamtnutzwert von Anbieter B? (Zwei Nachkommastellen)',
  'Rechenweg - jedes Kriterium: Gewichtung x Bewertung, dann summieren:
Funktionsumfang: 0,40 x 4 = 1,60
Bedienbarkeit:   0,25 x 3 = 0,75
Support:         0,20 x 5 = 1,00
Preis:           0,15 x 2 = 0,30
Gesamtnutzwert = 1,60 + 0,75 + 1,00 + 0,30 = 3,65

Kontrolle: Die Gewichtungen muessen in Summe 100 % ergeben, sonst ist das Ergebnis nicht vergleichbar. Und der Nutzwert kann nie ueber dem Maximum der Skala (hier 5) liegen.',
  2,
  ARRAY['nutzwertanalyse']::text[],
  null,
  '{"answer":3.65,"tolerance":0.01}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'wi-002',
  'wirtschaftlichkeit',
  'single',
  null,
  'Wozu dient die Nutzwertanalyse?',
  'Ablauf der Nutzwertanalyse: 1. Kriterien festlegen, 2. gewichten (Summe 100 %), 3. Alternativen je Kriterium bewerten, 4. Teilnutzwerte = Gewicht x Bewertung, 5. aufsummieren, 6. hoechster Nutzwert gewinnt.
Schwaeche, nach der gern gefragt wird: Gewichtung und Bewertung sind subjektiv. Wer das Ergebnis vorher kennt, kann es ueber die Gewichtung herbeifuehren - deshalb Kriterien VOR dem Blick auf die Angebote festlegen.',
  2,
  ARRAY['nutzwertanalyse']::text[],
  null,
  '{"choices":[{"text":"Zum Vergleich von Alternativen anhand mehrerer, unterschiedlich gewichteter und teils nicht monetaerer Kriterien.","is_correct":true,"rationale":"Richtig. Ihre Staerke ist, dass sie weiche Faktoren wie Bedienbarkeit oder Zukunftssicherheit vergleichbar macht."},{"text":"Zur Berechnung des exakten Return on Investment.","is_correct":false,"rationale":"Der ROI ist eine rein monetaere Kennzahl. Die Nutzwertanalyse liefert dimensionslose Punkte, keine Euro."},{"text":"Zur Ermittlung der Projektdauer.","is_correct":false,"rationale":"Das leistet die Netzplantechnik."},{"text":"Zur rechtssicheren Dokumentation gegenueber dem Auftraggeber.","is_correct":false,"rationale":"Sie kann eine Entscheidung nachvollziehbar machen, ist aber kein Rechtsdokument."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'wi-003',
  'wirtschaftlichkeit',
  'numeric',
  'Eine Virtualisierungsloesung kostet einmalig 48.000 Euro. Dadurch sinken die laufenden Kosten um 15.000 Euro pro Jahr.',
  'Nach wie vielen Jahren ist die Investition amortisiert? (Eine Nachkommastelle)',
  'Amortisationsdauer = Investitionssumme / jaehrlicher Rueckfluss
= 48.000 Euro / 15.000 Euro pro Jahr = 3,2 Jahre

In Worten: nach rund 3 Jahren und 2-3 Monaten hat sich die Anschaffung bezahlt gemacht. Achtung bei Aufgaben, in denen zusaetzlich laufende Kosten der neuen Loesung genannt werden - dann muss man erst den NETTO-Rueckfluss bilden (Einsparung minus neue laufende Kosten) und erst damit rechnen.',
  2,
  ARRAY['amortisation']::text[],
  null,
  '{"answer":3.2,"tolerance":0.05,"unit":"Jahre"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'wi-004',
  'wirtschaftlichkeit',
  'numeric',
  'Ein Angebot fuer Netzwerk-Hardware:
Listeneinkaufspreis: 12.000,00 Euro
Rabatt: 15 %
Skonto: 2 % bei Zahlung innerhalb von 10 Tagen
Bezugskosten (Fracht, Versicherung): 250,00 Euro',
  'Wie hoch ist der Bezugspreis (Einstandspreis) bei Skontoausnutzung? (in Euro, zwei Nachkommastellen)',
  'Bezugskalkulation - immer in dieser Reihenfolge:
Listeneinkaufspreis            12.000,00
- Rabatt 15 %                 - 1.800,00
= Zieleinkaufspreis            10.200,00
- Skonto 2 % (von 10.200)     -   204,00
= Bareinkaufspreis              9.996,00
+ Bezugskosten                +   250,00
= Bezugspreis/Einstandspreis   10.246,00 Euro

Zwei klassische Fehler: (1) Skonto vom Listenpreis statt vom Zieleinkaufspreis rechnen, (2) die Bezugskosten vor dem Skontoabzug addieren - auf Fracht gibt es kein Skonto.',
  3,
  ARRAY['angebotsvergleich', 'bezugskalkulation']::text[],
  null,
  '{"answer":10246.0,"tolerance":0.5,"unit":"Euro"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'wi-005',
  'wirtschaftlichkeit',
  'multiple',
  null,
  'Welche Positionen gehoeren in eine TCO-Betrachtung (Total Cost of Ownership) fuer eine Serverbeschaffung?',
  'TCO betrachtet den gesamten Lebenszyklus: Beschaffung, Betrieb, Wartung, Schulung, Ausfallkosten, Ausserbetriebnahme. Der Sinn ist, das billigste Angebot vom guenstigsten zu unterscheiden. Wichtig zur Abgrenzung: TCO = nur Kosten. ROI und Wirtschaftlichkeitsrechnung = Kosten UND Nutzen.',
  2,
  ARRAY['tco']::text[],
  null,
  '{"choices":[{"text":"Anschaffungskosten der Hardware","is_correct":true,"rationale":"Die direkten Anschaffungskosten sind der offensichtliche Teil - meist der kleinere."},{"text":"Strom- und Klimatisierungskosten ueber die Nutzungsdauer","is_correct":true,"rationale":"Laufende Betriebskosten sind bei Servern oft hoeher als der Kaufpreis."},{"text":"Lizenz- und Wartungsvertraege","is_correct":true,"rationale":"Wiederkehrende Kosten, die sich ueber 5 Jahre erheblich summieren."},{"text":"Schulungsaufwand fuer die Administratoren","is_correct":true,"rationale":"Auch indirekte Personalkosten gehoeren dazu - das unterscheidet TCO vom reinen Anschaffungspreis."},{"text":"Der Umsatz, der mit dem neuen System erzielt wird","is_correct":false,"rationale":"Falsch. TCO betrachtet ausschliesslich die KOSTEN. Ertraege gehoeren in eine Wirtschaftlichkeits- oder ROI-Rechnung."},{"text":"Entsorgungs- und Migrationskosten am Ende der Nutzungsdauer","is_correct":true,"rationale":"Der oft vergessene letzte Lebenszyklusabschnitt gehoert ausdruecklich dazu."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'qr-001',
  'qualitaet_risiko',
  'numeric',
  'Fuer das Risiko "Ausfall des Hauptlieferanten" wurde eine Eintrittswahrscheinlichkeit von 20 % und eine Schadenshoehe von 80.000 Euro geschaetzt.',
  'Wie hoch ist der Risikowert (Erwartungswert) in Euro?',
  'Risikowert = Eintrittswahrscheinlichkeit x Schadenshoehe
= 0,20 x 80.000 Euro = 16.000 Euro

Der Risikowert ist die Obergrenze fuer sinnvolle Gegenmassnahmen: Eine Massnahme, die 25.000 Euro kostet, lohnt sich hier nicht. Deshalb werden Risiken nach dem Risikowert priorisiert und nicht nach der Schadenshoehe allein.',
  1,
  ARRAY['risikobewertung']::text[],
  null,
  '{"answer":16000.0,"tolerance":0.0,"unit":"Euro"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'qr-002',
  'qualitaet_risiko',
  'matching',
  null,
  'Ordne jede Massnahme der passenden Risikostrategie zu.',
  'Vier Strategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit oder Auswirkung runter), Ueberwaelzen (Dritter traegt das Risiko), Akzeptieren (bewusst tragen).
Der haeufigste Fehler ist die Verwechslung von Vermeiden und Vermindern. Testfrage: Kann das Risiko danach ueberhaupt noch eintreten? Ja -> Vermindern. Nein -> Vermeiden.',
  2,
  ARRAY['risikostrategien']::text[],
  null,
  '{"buckets":["Vermeiden","Vermindern","Ueberwaelzen","Akzeptieren"],"match_items":[{"text":"Auf den Einsatz einer unausgereiften Technologie wird verzichtet.","bucket":0,"rationale":"Die Ursache wird komplett beseitigt - die Eintrittswahrscheinlichkeit sinkt auf null."},{"text":"Zusaetzliche Code-Reviews und automatisierte Tests werden eingefuehrt.","bucket":1,"rationale":"Die Eintrittswahrscheinlichkeit sinkt, das Risiko bleibt aber grundsaetzlich bestehen."},{"text":"Eine Betriebshaftpflichtversicherung wird abgeschlossen.","bucket":2,"rationale":"Der finanzielle Schaden geht auf einen Dritten ueber - klassisches Ueberwaelzen."},{"text":"Die Entwicklung wird an einen Dienstleister mit Festpreis vergeben.","bucket":2,"rationale":"Das Kostenrisiko traegt beim Festpreis der Auftragnehmer."},{"text":"Ein Restrisiko mit sehr geringem Schadenswert wird bewusst in Kauf genommen und dokumentiert.","bucket":3,"rationale":"Akzeptieren ist eine legitime Strategie - entscheidend ist, dass es bewusst und dokumentiert geschieht."},{"text":"Ein Backup-Rechenzentrum wird bereitgehalten, um die Ausfalldauer zu begrenzen.","bucket":1,"rationale":"Die Auswirkung wird reduziert. Das Risiko selbst bleibt bestehen - also Vermindern, nicht Vermeiden."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'qr-003',
  'qualitaet_risiko',
  'multiple',
  null,
  'Welche der folgenden Massnahmen sind KONSTRUKTIVE Qualitaetssicherungsmassnahmen?',
  'Einfache Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler (Standards, Methoden, Werkzeuge, Schulung, Templates). ANALYTISCH = nachher, findet Fehler (Test, Review, Inspektion, statische Analyse, Audit).
Grenzfall, der gern gefragt wird: Ein Linter ist konstruktiv, wenn er beim Schreiben eingreift, und analytisch, wenn er im Nachhinein ueber fertigen Code laeuft. In der Pruefung zaehlt die Einordnung als Werkzeugvorgabe - also konstruktiv.',
  2,
  ARRAY['qualitaetssicherung']::text[],
  null,
  '{"choices":[{"text":"Verbindliche Coding-Standards und Styleguides","is_correct":true,"rationale":"Konstruktiv: Sie verhindern Fehler von vornherein, statt sie hinterher zu finden."},{"text":"Einsatz erprobter Frameworks und Entwurfsmuster","is_correct":true,"rationale":"Ebenfalls vorbeugend - das Rad nicht neu erfinden heisst, dessen Fehler nicht neu zu machen."},{"text":"Schulung der Entwickler vor Projektbeginn","is_correct":true,"rationale":"Qualifikation ist eine klassische konstruktive Massnahme."},{"text":"Durchfuehrung von Modul- und Integrationstests","is_correct":false,"rationale":"Das ist ANALYTISCHE QS: Tests finden vorhandene Fehler, sie verhindern sie nicht."},{"text":"Code-Review nach Fertigstellung eines Moduls","is_correct":false,"rationale":"Ebenfalls analytisch - es wird ein bereits erstelltes Artefakt geprueft."},{"text":"Einsatz einer einheitlichen Entwicklungsumgebung mit Linter-Konfiguration","is_correct":true,"rationale":"Vorbeugend: Der Linter verhindert bestimmte Fehlerklassen schon beim Tippen."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'qr-004',
  'qualitaet_risiko',
  'single',
  'In der Risikomatrix liegt Risiko X bei geringer Eintrittswahrscheinlichkeit, aber existenzbedrohender Schadenshoehe (z. B. vollstaendiger Datenverlust ohne Backup).',
  'Wie ist mit einem solchen Risiko umzugehen?',
  'Die Risikomatrix (Wahrscheinlichkeit x Auswirkung) hat eine eingebaute Schwaeche: Sie behandelt "oft, aber harmlos" und "selten, aber katastrophal" gleich, wenn das Produkt gleich ist. In der Praxis zieht man deshalb eine Toleranzgrenze: Schaeden oberhalb einer bestimmten Hoehe werden unabhaengig von der Wahrscheinlichkeit behandelt. Genau deshalb gibt es Backups, obwohl Totalausfaelle selten sind.',
  3,
  ARRAY['risikomatrix']::text[],
  null,
  '{"choices":[{"text":"Es muss trotz geringer Wahrscheinlichkeit behandelt werden, weil der Schaden untragbar waere.","is_correct":true,"rationale":"Richtig. Bei existenzbedrohenden Schaeden greift die reine Erwartungswertlogik nicht mehr - ein Schaden, den man nicht ueberlebt, darf nicht eintreten."},{"text":"Es kann akzeptiert werden, weil der Risikowert rechnerisch niedrig ist.","is_correct":false,"rationale":"Genau der Denkfehler. Ein rechnerisch kleiner Erwartungswert hilft nicht, wenn der Einzelfall das Unternehmen beendet."},{"text":"Es ist nachrangig gegenueber Risiken mit mittlerer Wahrscheinlichkeit und mittlerem Schaden.","is_correct":false,"rationale":"Falsch. Bei gleicher Rechengroesse hat das Risiko mit dem katastrophalen Schadenspotenzial Vorrang."},{"text":"Es gehoert nicht in das Risikoregister, weil es unwahrscheinlich ist.","is_correct":false,"rationale":"Ins Register gehoeren alle identifizierten Risiken. Erst die Bewertung entscheidet ueber Massnahmen."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'ab-001',
  'abschluss',
  'single',
  null,
  'Was ist das Ziel einer Lessons-Learned-Sitzung?',
  'Lessons Learned funktionieren nur unter drei Bedingungen: zeitnah (nicht Monate spaeter), ohne Schuldzuweisung und mit dokumentiertem Ergebnis an einem Ort, an dem das naechste Projekt es auch findet. Eine Sitzung, deren Protokoll in einem Ordner verschwindet, ist verlorene Zeit.',
  1,
  ARRAY['lessons_learned']::text[],
  null,
  '{"choices":[{"text":"Erfahrungen systematisch sichern, damit kuenftige Projekte davon profitieren.","is_correct":true,"rationale":"Richtig. Der Wert entsteht erst dadurch, dass die Erkenntnisse dokumentiert und in der Organisation verfuegbar gemacht werden."},{"text":"Die Verantwortlichen fuer Fehler im Projekt benennen.","is_correct":false,"rationale":"Genau das Gegenteil. Sobald Schuldzuweisungen drohen, sagt niemand mehr, was wirklich schieflief - und die Sitzung ist wertlos."},{"text":"Die Abnahme des Projektergebnisses durch den Kunden.","is_correct":false,"rationale":"Die Abnahme ist ein eigener, vorgelagerter Schritt."},{"text":"Die Schlussrechnung fuer den Kunden erstellen.","is_correct":false,"rationale":"Das ist kaufmaennischer Projektabschluss, nicht Erfahrungssicherung."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'ab-002',
  'abschluss',
  'multiple',
  null,
  'Was gehoert in einen Projektabschlussbericht?',
  'Der Projektabschluss hat drei Ebenen: sachlich-technisch (Abnahme, Uebergabe an den Betrieb, Restarbeiten), kaufmaennisch (Schlussrechnung, Nachkalkulation, Projekt schliessen) und personell (Teamaufloesung, Rueckfuehrung in die Linie, Wuerdigung). Die personelle Ebene wird am haeufigsten vergessen - und ist die, an die sich das Team am laengsten erinnert.',
  2,
  ARRAY['abschlussbericht']::text[],
  null,
  '{"choices":[{"text":"Soll-Ist-Vergleich von Terminen, Kosten und Leistungsumfang","is_correct":true,"rationale":"Der Kern des Berichts: Was war geplant, was ist herausgekommen, warum die Abweichung?"},{"text":"Zielerreichungsgrad bezogen auf den Projektauftrag","is_correct":true,"rationale":"Gemessen wird gegen das, was im Auftrag stand - nicht gegen das, was unterwegs daraus wurde."},{"text":"Lessons Learned und Verbesserungsvorschlaege","is_correct":true,"rationale":"Die Erfahrungssicherung gehoert in den Bericht, nicht nur ins Sitzungsprotokoll."},{"text":"Uebergabe an Betrieb bzw. Linie mit benannten Verantwortlichen","is_correct":true,"rationale":"Ohne klare Uebergabe bleibt das Projektteam ewig zustaendig - ein haeufiger Praxisfehler."},{"text":"Der vollstaendige Quellcode der Anwendung","is_correct":false,"rationale":"Falsch. Der Code gehoert ins Versionsverwaltungssystem, nicht in den Bericht. Der Bericht verweist darauf."},{"text":"Offene Punkte und Restrisiken","is_correct":true,"rationale":"Was nicht erledigt wurde, muss benannt und an jemanden uebergeben werden."}]}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data)
values (
  'ab-003',
  'abschluss',
  'ordering',
  null,
  'Bringe die Schritte des Projektabschlusses in eine sinnvolle Reihenfolge.',
  'Zwei Stellen, an denen gern getauscht wird: Die Abnahme kommt VOR der Uebergabe an den Betrieb - man uebergibt nichts, was der Kunde nicht angenommen hat. Und die Teamaufloesung kommt ZULETZT, weil man fuer Bericht und Lessons Learned die Leute noch braucht. Wer das Team vorher aufloest, bekommt weder das eine noch das andere in brauchbarer Qualitaet.',
  2,
  ARRAY['projektabschluss']::text[],
  null,
  '{"ordered_items":["Restarbeiten abschliessen und Projektergebnis fertigstellen","Abnahme durch den Auftraggeber mit Abnahmeprotokoll","Uebergabe an den Betrieb bzw. die Linienorganisation","Projektabschlussbericht mit Soll-Ist-Vergleich erstellen","Lessons Learned durchfuehren und dokumentieren","Projektteam formal aufloesen und Ressourcen freigeben"],"ordering_hint":"Vom ersten bis zum letzten Schritt"}'::jsonb
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  kind = excluded.kind,
  scenario = excluded.scenario,
  prompt = excluded.prompt,
  explanation = excluded.explanation,
  difficulty = excluded.difficulty,
  tags = excluded.tags,
  data = excluded.data,
  is_active = true;

-- Theorie-Snacks --------------------------------------------
insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-org-1',
  'projektorganisation',
  'Was ein Projekt zum Projekt macht',
  'Die DIN 69901 definiert vier Merkmale. Fehlt eines davon, ist es Tagesgeschaeft - egal wie aufwendig es sich anfuehlt.',
  ARRAY['Einmaligkeit der Bedingungen in ihrer Gesamtheit', 'Zielvorgabe mit zeitlicher, finanzieller und personeller Begrenzung', 'Eigene, projektspezifische Organisation', 'Abgrenzung gegenueber anderen Vorhaben', 'Nicht enthalten: eine Mindestgroesse oder ein Mindestbudget']::text[],
  'Einmalig, begrenzt, eigene Organisation, abgegrenzt - vier Haken, sonst kein Projekt.',
  45,
  0
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-org-2',
  'projektorganisation',
  'Drei Organisationsformen in einer Minute',
  'Die Frage ist immer dieselbe: Wie viel Macht hat die Projektleitung gegenueber der Linie?',
  ARRAY['Reine Projektorganisation: Team komplett aus der Linie geloest, Projektleitung hat volle Weisungsbefugnis. Schnell, aber teuer und nach Projektende gibt es ein Rueckkehrproblem.', 'Matrix: Weisungsbefugnis geteilt - fachlich beim Projekt, disziplinarisch in der Linie. Flexibel, aber Dauerkonflikt um Prioritaeten.', 'Stabs-/Einflussorganisation: Projektleitung koordiniert nur, ohne Weisungsrecht. Billig, aber zahnlos.']::text[],
  'Viel Macht = viel Aufwand. Die Matrix ist der Kompromiss - und deshalb der Normalfall.',
  45,
  1
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-vor-1',
  'vorgehensmodelle',
  'Wasserfall, V-Modell, Spirale',
  'Drei klassische Modelle, drei Erkennungsmerkmale.',
  ARRAY['Wasserfall: streng sequenziell, jede Phase endet mit einem freigegebenen Dokument. Voraussetzung: Anforderungen sind vollstaendig bekannt.', 'V-Modell: wie Wasserfall, aber jeder Entwicklungsstufe ist eine Teststufe zugeordnet (Anforderung <-> Abnahmetest, Systemspez. <-> Systemtest, Architektur <-> Integrationstest, Feinentwurf <-> Modultest).', 'Spiralmodell: wiederholte Zyklen, jeder beginnt mit einer Risikoanalyse. Fuer grosse, riskante Vorhaben.', 'Rule of Ten: Ein Fehler kostet in jeder spaeteren Phase etwa das Zehnfache.']::text[],
  'Gleiche Hoehe im V = zusammengehoeriges Paar. Je hoeher, desto naeher am Kunden.',
  45,
  2
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-scr-1',
  'agil_scrum',
  'Scrum auf einer Karte',
  'Drei Verantwortlichkeiten, drei Artefakte, fuenf Events. Mehr steht nicht im Scrum Guide.',
  ARRAY['Verantwortlichkeiten: Product Owner (WAS und Reihenfolge), Developers (WIE und wie viel), Scrum Master (DASS es funktioniert).', 'Artefakte mit Commitment: Product Backlog -> Product Goal, Sprint Backlog -> Sprint Goal, Increment -> Definition of Done.', 'Events: Sprint (Container), Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective. Refinement ist KEIN Event, sondern eine laufende Taetigkeit.', 'Timeboxen bei Monatssprint: Planning 8 h, Daily 15 min, Review 4 h, Retrospektive 3 h.']::text[],
  'Review = Produkt, mit Stakeholdern. Retrospektive = Zusammenarbeit, nur das Team. Review kommt zuerst.',
  45,
  3
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-np-1',
  'netzplan',
  'Netzplan: die sechs Werte',
  'Erst alles vorwaerts, dann alles rueckwaerts, dann die Puffer. In dieser Reihenfolge, nie gemischt.',
  ARRAY['Vorwaerts: FAZ = groesster FEZ aller Vorgaenger (Start: 0). FEZ = FAZ + Dauer.', 'Projektdauer = groesster FEZ im gesamten Plan.', 'Rueckwaerts: SEZ = kleinster SAZ aller Nachfolger (Endvorgang: SEZ = Projektdauer). SAZ = SEZ - Dauer.', 'Gesamtpuffer GP = SAZ - FAZ = SEZ - FEZ.', 'Freier Puffer FP = kleinster FAZ der Nachfolger - eigener FEZ.', 'Kritischer Pfad = alle Vorgaenge mit GP = 0, zugleich der laengste Weg.']::text[],
  'Vorwaerts das MAXIMUM, rueckwaerts das MINIMUM. Wer das vertauscht, rechnet den halben Plan falsch.',
  45,
  4
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-np-2',
  'netzplan',
  'GP oder FP? Der Unterschied in 20 Sekunden',
  'Beide Puffer sagen, wie viel Luft ein Vorgang hat - aber bis wohin, ist verschieden.',
  ARRAY['Gesamtpuffer: Verschiebung ohne das PROJEKTENDE zu gefaehrden. Kann aber den Nachfolger nach hinten druecken.', 'Freier Puffer: Verschiebung ohne den fruehesten Start des NACHFOLGERS anzutasten. Merkt sonst niemand.', 'Es gilt immer FP <= GP.', 'Auf dem kritischen Pfad sind beide null.', 'Typischer Fall: GP = 2, FP = 0. Luft bis zum Projektende vorhanden - aber nur, indem man sie dem Nachfolger wegnimmt.']::text[],
  'GP schaut aufs Projektende, FP schaut auf den Nachbarn.',
  45,
  5
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-tp-1',
  'terminplanung',
  'Gantt, Meilenstein, MTA',
  'Mit dem Netzplan rechnet man, mit dem Balkenplan redet man.',
  ARRAY['Gantt/Balkenplan: massstabsgetreue Zeitachse, auf einen Blick lesbar. Abhaengigkeiten und Puffer sind aber nicht direkt ablesbar.', 'Meilenstein: Ereignis mit Dauer null, an dem ein definiertes Zwischenergebnis vorliegt. Binaer pruefbar formulieren.', 'Meilensteintrendanalyse: geplante Termine ueber Berichtszeitpunkte auftragen. Waagerecht = im Plan, steigend = Verzug, fallend = frueher fertig, Zickzack = unsichere Planung.', 'Dauer = Aufwand / (Anzahl Personen x Verfuegbarkeitsgrad). Personentage sind Aufwand, Arbeitstage sind Dauer.']::text[],
  'Steigende MTA-Linie heisst spaeter, nicht frueher. Das wird am haeufigsten verwechselt.',
  45,
  6
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-lh-1',
  'lastenheft',
  'Lastenheft vs. Pflichtenheft',
  'Zwei Dokumente, zwei Absender, zwei Zeitpunkte.',
  ARRAY['Lastenheft: vom AUFTRAGGEBER, beschreibt das WAS und WOFUER, loesungsneutral. Grundlage der Ausschreibung.', 'Pflichtenheft: vom AUFTRAGNEHMER, beschreibt das WIE und WOMIT. Entsteht NACH der Vergabe und wird vom Auftraggeber genehmigt.', 'Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft.', 'Funktional = "Das System tut X". Nicht-funktional = "Das System tut X schnell/sicher/verfuegbar/barrierefrei".', 'Gute Anforderung: eindeutig, vollstaendig, widerspruchsfrei, pruefbar, notwendig, priorisiert (MuSCoW).']::text[],
  'LAstenheft = Auftraggeber verteilt die Last. PFlichtenheft = Auftragnehmer nennt seine Pflicht.',
  45,
  7
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-wi-1',
  'wirtschaftlichkeit',
  'Rechnen im PM-Teil',
  'Vier Rechnungen decken den Grossteil der Punkte ab.',
  ARRAY['Nutzwertanalyse: je Kriterium Gewicht x Bewertung, dann summieren. Gewichte muessen 100 % ergeben.', 'Amortisation: Investitionssumme / jaehrlicher Netto-Rueckfluss.', 'Bezugskalkulation: Listenpreis - Rabatt = Zieleinkaufspreis; - Skonto = Bareinkaufspreis; + Bezugskosten = Bezugspreis. Skonto nie vom Listenpreis, Bezugskosten nie vor dem Skonto.', 'Risikowert = Eintrittswahrscheinlichkeit x Schadenshoehe.', 'TCO = nur Kosten ueber den gesamten Lebenszyklus. Ertraege gehoeren in die ROI-Rechnung.']::text[],
  'Bei Prozentaufgaben immer fragen: Prozent WOVON? Das ist der haeufigste Punktverlust.',
  45,
  8
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-qr-1',
  'qualitaet_risiko',
  'Qualitaet und Risiko',
  'Zwei Sortierungen, die fast jede Aufgabe abdecken.',
  ARRAY['Konstruktive QS = vorher, verhindert Fehler: Standards, Templates, Werkzeuge, Schulung, Frameworks.', 'Analytische QS = nachher, findet Fehler: Test, Review, Inspektion, statische Analyse, Audit.', 'Risikostrategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit oder Auswirkung runter), Ueberwaelzen (Versicherung, Festpreis), Akzeptieren (bewusst und dokumentiert).', 'Testfrage Vermeiden vs. Vermindern: Kann das Risiko danach noch eintreten? Ja -> vermindert. Nein -> vermieden.']::text[],
  'Test findet Fehler, Standard verhindert sie. Das ist die ganze Unterscheidung.',
  45,
  9
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values (
  'th-ab-1',
  'abschluss',
  'Projektabschluss richtig',
  'Drei Ebenen - die dritte wird am haeufigsten vergessen.',
  ARRAY['Sachlich-technisch: Restarbeiten, Abnahme mit Protokoll, Uebergabe an den Betrieb.', 'Kaufmaennisch: Schlussrechnung, Nachkalkulation, Projekt buchhalterisch schliessen.', 'Personell: Team aufloesen, Rueckfuehrung in die Linie, Wuerdigung der Leistung.', 'Lessons Learned: zeitnah, ohne Schuldzuweisung, dokumentiert an einem auffindbaren Ort.', 'Reihenfolge: Abnahme vor Uebergabe, Teamaufloesung zuletzt.']::text[],
  'Wer das Team vor dem Abschlussbericht aufloest, bekommt keinen brauchbaren Bericht.',
  45,
  10
)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

commit;

-- Kontrolle:
--   select topic_id, count(*) from public.ap1_questions group by 1 order by 1;
-- erwartet: 46 Aufgaben, 9 Themen, 11 Theorie-Snacks.
