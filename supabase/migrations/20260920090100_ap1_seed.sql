-- ==========================================================================
-- AP1-Trainer - Inhalte
--
-- ACHTUNG: automatisch erzeugt. Nicht von Hand aendern.
-- Quelle:  lib/data/seed/
-- Befehl:  flutter test tool/generate_seed_sql_test.dart
--
-- Alle Aufgaben und Karten sind eigene Formulierungen im Stil
-- der IHK-AP1, keine Originalaufgaben (urheberrechtlich
-- geschuetzt).
--
-- Kein explizites begin/commit: sowohl der Supabase-SQL-Editor
-- als auch `supabase db push` fuehren ein Skript bereits in
-- einer Transaktion aus.
-- ==========================================================================

-- Katalogbereiche -------------------------------------------
insert into public.ap1_areas (id, number, title, blurb, weight, sort_order) values
  ('a01', '01', 'Projekte & Projektmanagement', 'Ziele, Vorgehensmodelle, Termin- und Kostenplanung, Risiken', 0.220, 0),
  ('a02', '02', 'Kundenbeziehungen & Kommunikation', 'Gesprächsführung, Team, Verhandlung, Präsentation, Markt', 0.130, 1),
  ('a03', '03', 'Informations- & Softwaresysteme', 'Hardware, Betriebssysteme, Anwendungssysteme, Netzwerke', 0.180, 2),
  ('a04', '04', 'Analyse & Entwicklung von Systemen', 'Anforderungen, UML, Programmierlogik, Web, Daten, KI', 0.220, 3),
  ('a05', '05', 'Qualitätssicherung', 'QS-Maßnahmen, PDCA, Testverfahren und Testprotokolle', 0.070, 4),
  ('a06', '06', 'IT-Sicherheit & Datenschutz', 'Schutzziele, Maßnahmen, Kryptographie, DSGVO', 0.120, 5),
  ('a07', '07', 'Vertragsmanagement & Service', 'Vertragsarten, SLA, Leistungsstörungen, Change Management', 0.060, 6)
on conflict (id) do update set
  number = excluded.number,
  title = excluded.title,
  blurb = excluded.blurb,
  weight = excluded.weight,
  sort_order = excluded.sort_order;

-- Themen ----------------------------------------------------
insert into public.ap1_topics (id, area_id, title, blurb, weight, sort_order) values
  ('projektorganisation', 'a01', 'Projektgrundlagen & Organisation', 'Projektbegriff, SMART-Ziele, magisches Dreieck, Rollen, Stakeholder', 0.035, 0),
  ('vorgehensmodelle', 'a01', 'Vorgehensmodelle & Phasen', 'Phasenmodell und Wasserfall - der Katalog 2025 kennt nur noch diese und Scrum', 0.020, 1),
  ('agil_scrum', 'a01', 'Agiles Arbeiten & Scrum', 'Rollen, Artefakte, Events, agiles Manifest', 0.040, 2),
  ('netzplan', 'a01', 'Netzplantechnik', 'FAZ/FEZ/SAZ/SEZ, Puffer, kritischer Pfad', 0.040, 3),
  ('terminplanung', 'a01', 'Projektstruktur & Termine', 'Projektstrukturplan, Gantt, Meilensteine, Ressourcen', 0.025, 4),
  ('risikomanagement', 'a01', 'Risikomanagement', 'Risiken erkennen, bewerten, Strategien, Risikomatrix', 0.020, 5),
  ('pm_wirtschaftlichkeit', 'a01', 'Wirtschaftlichkeit von Projekten', 'Machbarkeit, Make-or-Buy, Kalkulation, Break-Even, TCO', 0.025, 6),
  ('projektabschluss', 'a01', 'Projektabschluss', 'Abnahme, Abschlussbericht, Lessons Learned, Übergabe', 0.015, 7),
  ('kommunikation', 'a02', 'Kommunikation & Kundenkontakt', 'Kommunikationsmodelle, adressatengerecht beraten, Ticketsysteme', 0.035, 8),
  ('teamarbeit', 'a02', 'Teamarbeit & Zusammenarbeit', 'Tuckman-Phasen, Feedback, Fehlerkultur, Diversity, Konflikte', 0.025, 9),
  ('verhandlung', 'a02', 'Verhandeln', 'Harvard-Konzept, Win-win, Einwandbehandlung', 0.020, 10),
  ('praesentation', 'a02', 'Präsentieren & Beraten', 'Argumentation, Präsentationstechnik, Quellen, Angebotserstellung', 0.020, 11),
  ('markt_marketing', 'a02', 'Markt, Bedarf & Marketing', 'Marktformen, Bedarfsermittlung, AIDA, ABC-Analyse, Rechtsformen', 0.030, 12),
  ('hardware', 'a03', 'Hardware & Arbeitsplatz', 'CPU, RAM, HDD vs. SSD, Peripherie, USV, Green IT, Ergonomie', 0.040, 13),
  ('betriebssysteme', 'a03', 'Betriebssysteme', 'Prozesse, Dateisysteme, Rechte, Kommandozeile, Härtung', 0.040, 14),
  ('anwendungssysteme', 'a03', 'Anwendungs- & Softwaresysteme', 'ERP, SCM, CRM, Social Media, Lizenzmodelle, Standard vs. Individual', 0.040, 15),
  ('netzwerke', 'a03', 'Netzwerke & Cloud', 'OSI, IPv4/IPv6, Subnetting, Protokolle, Virtualisierung, Container', 0.060, 16),
  ('anforderungen', 'a04', 'Anforderungen, Lasten- & Pflichtenheft', 'Anforderungsarten, Erhebung, Abgrenzung, Abnahmekriterien', 0.035, 17),
  ('uml_modellierung', 'a04', 'UML & Modellierung', 'Use-Case-, Klassen- und Aktivitätsdiagramm', 0.030, 18),
  ('programmierlogik', 'a04', 'Programmierlogik', 'Datentypen, Kontrollstrukturen, Pseudocode, Schreibtischtest', 0.035, 19),
  ('objektorientierung', 'a04', 'Objektorientierung', 'Klasse, Objekt, Attribut, Methode, Kapselung', 0.020, 20),
  ('datenmodellierung', 'a04', 'Datenmodellierung', 'ER-Modell, Beziehungen, Schlüssel, Normalisierung', 0.025, 21),
  ('web_internet', 'a04', 'Web & Internet', 'URL, HTTP, Ablauf eines Seitenaufrufs, HTML/CSS, Barrierefreiheit', 0.030, 22),
  ('multimedia_daten', 'a04', 'Daten & Multimedia', 'Zeichensätze, Kompression, Datenmengen und Übertragungsraten', 0.025, 23),
  ('ki_grundlagen', 'a04', 'KI-Unterstützung', 'Einsatzfelder, Grenzen, Halluzinationen, Datenschutz bei KI', 0.020, 24),
  ('qualitaetsmanagement', 'a05', 'Qualitätsmanagement', 'Konstruktive und analytische QS, PDCA, Qualitätsplanung', 0.030, 25),
  ('testen', 'a05', 'Testverfahren', 'Teststufen, Black-/White-Box, Testfälle, Testprotokoll', 0.040, 26),
  ('schutzziele_bedrohungen', 'a06', 'Schutzziele & Bedrohungen', 'Vertraulichkeit, Integrität, Verfügbarkeit, Angriffsarten, BSI', 0.035, 27),
  ('sicherheitsmassnahmen', 'a06', 'Technische Schutzmaßnahmen', 'Firewall, DMZ, Härtung, WLAN-Sicherheit, Backup, Berechtigungen', 0.030, 28),
  ('kryptographie_auth', 'a06', 'Kryptographie & Authentifizierung', 'Symmetrisch/asymmetrisch, Hashverfahren, Zertifikate, 2FA', 0.025, 29),
  ('datenschutz', 'a06', 'Datenschutz & DSGVO', 'Grundsätze, Betroffenenrechte, Anonymisierung, Pseudonymisierung', 0.030, 30),
  ('vertraege', 'a07', 'Verträge & Recht', 'Kauf-, Werk-, Dienstvertrag, Lizenzen, Urheberrecht', 0.020, 31),
  ('sla_service', 'a07', 'Service & SLA', 'Service Level Agreements, Support-Level, Eskalation, ITIL', 0.015, 32),
  ('leistungsstoerungen', 'a07', 'Leistungsstörungen & Abnahme', 'Verzug, Mängel, Gewährleistung, Abnahmeprotokoll, Soll-Ist', 0.015, 33),
  ('change_management', 'a07', 'Change Management', 'Lewin-Modell, Kaizen, Widerstände, Change-Prozess', 0.010, 34)
on conflict (id) do update set
  area_id = excluded.area_id,
  title = excluded.title,
  blurb = excluded.blurb,
  weight = excluded.weight,
  sort_order = excluded.sort_order;

-- Aufgaben --------------------------------------------------
insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'org-001',
  'projektorganisation',
  'multiple',
  null,
  'Welche Merkmale müssen nach DIN 69901 erfüllt sein, damit ein Vorhaben als Projekt gilt?',
  'Merksatz: E-Z-O-A - Einmaligkeit, Zielvorgabe mit Begrenzung, eigene Organisation, Abgrenzung. Größe und Budget sind bewusst nicht Teil der Definition; sonst wäre jede Norm länder- und branchenabhängig.',
  1,
  ARRAY['din69901', 'projektbegriff']::text[],
  null,
  '{"choices":[{"text":"Einmaligkeit der Bedingungen in ihrer Gesamtheit","is_correct":true,"rationale":"Kernmerkmal. Ein Vorhaben, das jeden Monat identisch abläuft, ist Tagesgeschäft - kein Projekt."},{"text":"Zeitliche, finanzielle und personelle Begrenzung","is_correct":true,"rationale":"Ein Projekt hat einen definierten Anfang und ein definiertes Ende sowie ein festes Budget."},{"text":"Eine eigene, projektspezifische Organisation","is_correct":true,"rationale":"Projektleitung, Team und Entscheidungswege werden eigens für das Vorhaben festgelegt."},{"text":"Mindestens fünf beteiligte Mitarbeitende","is_correct":false,"rationale":"Falsch. Die DIN nennt keine Mindestgröße. Auch ein Zwei-Personen-Vorhaben kann ein Projekt sein."},{"text":"Ein Budget von mindestens 50.000 Euro","is_correct":false,"rationale":"Falsch. Es gibt keine Wertgrenze in der Norm. Unternehmen setzen intern manchmal Schwellen - das ist aber keine Definition."},{"text":"Abgrenzung gegenüber anderen Vorhaben","is_correct":true,"rationale":"Das Projekt muss inhaltlich und organisatorisch klar von der Linie und von anderen Projekten trennbar sein."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'org-002',
  'projektorganisation',
  'matching',
  null,
  'Ordne die Aussagen der passenden Form der Projektorganisation zu.',
  'Faustregel für die Prüfung: Je mehr Macht die Projektleitung hat, desto teurer und störender ist die Organisationsform für die Linie. Rein = viel Macht, hoher Aufwand. Stab = wenig Macht, wenig Aufwand. Matrix liegt dazwischen und wird am häufigsten gewählt.',
  2,
  ARRAY['aufbauorganisation']::text[],
  null,
  '{"buckets":["Reine Projektorganisation","Matrix-Organisation","Stabs-/Einflussorganisation"],"match_items":[{"text":"Mitarbeitende werden vollständig aus der Linie herausgelöst.","bucket":0,"rationale":"Genau das ist das Kennzeichen der reinen (autonomen) Projektorganisation."},{"text":"Die Projektleitung hat volle fachliche und disziplinarische Weisungsbefugnis.","bucket":0,"rationale":"Nur hier ist die Weisungsbefugnis ungeteilt."},{"text":"Weisungsbefugnis ist zwischen Linien- und Projektleitung geteilt.","bucket":1,"rationale":"Der typische Kompromiss - und die typische Konfliktquelle der Matrix."},{"text":"Hohes Konfliktpotenzial durch zwei Vorgesetzte pro Person.","bucket":1,"rationale":"Das klassische Matrix-Problem: zwei Chefs, widersprüchliche Prioritäten."},{"text":"Die Projektleitung koordiniert nur und kann keine Anweisungen geben.","bucket":2,"rationale":"Die Stabsstelle berichtet und koordiniert, entscheidet aber nicht."},{"text":"Geringster organisatorischer Aufwand, dafür schwache Durchsetzungskraft.","bucket":2,"rationale":"Vorteil und Nachteil der Einflussorganisation in einem Satz."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'org-003',
  'projektorganisation',
  'single',
  'Bei der Einführung eines neuen Ticketsystems hat der Betriebsrat hohen Einfluss auf die Entscheidung, zeigt bislang aber wenig Interesse am Projekt.',
  'Welche Strategie sieht die Stakeholder-Matrix (Einfluss/Interesse) für diese Gruppe vor?',
  'Die vier Felder der Stakeholder-Matrix:
- Einfluss hoch / Interesse hoch -> eng einbinden (manage closely)
- Einfluss hoch / Interesse niedrig -> zufriedenstellen (keep satisfied)
- Einfluss niedrig / Interesse hoch -> informieren (keep informed)
- Einfluss niedrig / Interesse niedrig -> beobachten (monitor)
In der Prüfung wird fast immer nach dem Feld "hoher Einfluss, geringes Interesse" gefragt, weil es das unintuitivste ist.',
  2,
  ARRAY['stakeholder']::text[],
  null,
  '{"choices":[{"text":"Zufriedenstellen - regelmäßig informieren, aber nicht überfrachten","is_correct":true,"rationale":"Richtig. Hoher Einfluss + geringes Interesse = \"keep satisfied\". Die Gruppe kann das Projekt kippen, will aber keine Detailflut."},{"text":"Eng einbinden - in alle Entscheidungen einbeziehen","is_correct":false,"rationale":"Das gilt für hohen Einfluss UND hohes Interesse. Hier würde es den Betriebsrat mit Details überfordern und Widerstand erzeugen."},{"text":"Beobachten - minimaler Aufwand","is_correct":false,"rationale":"Das gilt nur bei geringem Einfluss UND geringem Interesse. Wer den Betriebsrat so behandelt, erlebt spätestens bei der Mitbestimmung eine Vollbremsung."},{"text":"Informieren - ausführlich über Fortschritte berichten","is_correct":false,"rationale":"Das ist die Strategie für geringen Einfluss und hohes Interesse, z. B. interessierte Fachanwender."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'org-004',
  'projektorganisation',
  'multiple',
  null,
  'Welche Angaben gehören zwingend in einen Projektauftrag?',
  'Der Projektauftrag ist die Geburtsurkunde des Projekts: Ziel, Nicht-Ziel, Rahmen (Zeit/Budget), Verantwortliche. Alles, was Detailplanung ist (Netzplan, Architektur, Arbeitspakete), kommt danach.',
  2,
  ARRAY['projektauftrag']::text[],
  null,
  '{"choices":[{"text":"Projektziel und messbare Abnahmekriterien","is_correct":true,"rationale":"Ohne messbares Ziel ist später nicht entscheidbar, ob das Projekt erfolgreich war."},{"text":"Benannte Projektleitung mit Befugnissen","is_correct":true,"rationale":"Der Auftrag legitimiert die Projektleitung - sonst hat sie im Unternehmen keinen Stand."},{"text":"Budget- und Terminrahmen","is_correct":true,"rationale":"Die beiden Eckpunkte des magischen Dreiecks neben dem Leistungsumfang."},{"text":"Vollständige technische Systemarchitektur","is_correct":false,"rationale":"Falsch. Die Architektur entsteht erst in der Planungs-/Entwurfsphase. Im Auftrag steht das WAS, nicht das WIE."},{"text":"Nicht-Ziele bzw. Abgrenzung des Projektumfangs","is_correct":true,"rationale":"Oft unterschätzt: Was ausdrücklich NICHT Teil des Projekts ist, verhindert späteren Scope Creep."},{"text":"Der fertige Netzplan aller Vorgänge","is_correct":false,"rationale":"Falsch. Der Netzplan ist ein Ergebnis der Planungsphase, nicht Voraussetzung des Auftrags."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'org-005',
  'projektorganisation',
  'single',
  'Zwei Wochen vor dem Releasetermin fällt auf, dass ein Modul mehr Aufwand braucht als geplant. Der Termin ist vertraglich fixiert, zusätzliches Budget gibt es nicht.',
  'Welche Konsequenz ergibt sich zwangsläufig aus dem magischen Dreieck?',
  'Magisches Dreieck: Zeit, Kosten, Leistung/Qualität. Sind zwei Größen fixiert, ist die dritte die abhängige Variable. In Prüfungsaufgaben steht die Lösung immer in der Aufgabenstellung: schau, welche zwei Ecken als "fest" beschrieben sind.',
  3,
  ARRAY['magisches_dreieck']::text[],
  null,
  '{"choices":[{"text":"Der Leistungsumfang muss reduziert werden.","is_correct":true,"rationale":"Richtig. Zeit und Kosten sind fixiert - im Dreieck bleibt nur die dritte Größe, der Umfang (Qualität/Leistung), als Stellhebel."},{"text":"Die Qualitätssicherung kann entfallen, ohne den Umfang zu ändern.","is_correct":false,"rationale":"Das ist keine neutrale Option: QS zu streichen ist selbst eine Reduzierung der Qualität - also ebenfalls eine Änderung der dritten Größe, nur eine besonders teure."},{"text":"Mehr Personal löst das Problem ohne Nebenwirkung.","is_correct":false,"rationale":"Erstens kostet mehr Personal Budget (das es nicht gibt), zweitens gilt Brooks Law: zusätzliche Leute in einem späten Projekt verzögern es zunächst weiter."},{"text":"Das Projekt muss abgebrochen werden.","is_correct":false,"rationale":"Ein Abbruch ist eine mögliche Managemententscheidung, aber nicht die zwangsläufige Folge des Dreiecks. Gefragt war die logische Konsequenz."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'vor-001',
  'vorgehensmodelle',
  'ordering',
  null,
  'Bringe die Phasen des Wasserfallmodells in die richtige Reihenfolge.',
  'Das Wasserfallmodell läuft streng sequenziell: jede Phase endet mit einem freigegebenen Dokument, erst dann startet die nächste. Das ist zugleich sein größter Nachteil - Fehler aus der Analyse fallen erst im Test auf, und dann ist die Korrektur am teuersten.',
  1,
  ARRAY['wasserfall']::text[],
  null,
  '{"ordered_items":["Analyse / Anforderungsdefinition","Entwurf (Design)","Implementierung","Test / Verifikation","Einführung und Wartung"],"ordering_hint":"Von der ersten zur letzten Phase"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'vor-002',
  'vorgehensmodelle',
  'single',
  null,
  'Welcher Testart steht im V-Modell die Phase "Anforderungsdefinition" gegenüber?',
  'Die Ebenen des V-Modells von oben nach unten:
Anforderungsdefinition <-> Abnahmetest
Systemspezifikation <-> Systemtest
Architektur/Grobentwurf <-> Integrationstest
Feinentwurf/Modulspez. <-> Modultest (Unittest)
Merkhilfe: gleiche Höhe im V = zusammengehöriges Paar. Je höher, desto näher am Kunden.',
  2,
  ARRAY['v-modell']::text[],
  null,
  '{"choices":[{"text":"Abnahmetest","is_correct":true,"rationale":"Richtig. Die oberste linke Ebene (Anforderungen des Auftraggebers) wird gegen die oberste rechte Ebene (Abnahmetest durch den Auftraggeber) geprüft."},{"text":"Modultest","is_correct":false,"rationale":"Der Modul-/Unittest liegt auf der untersten Ebene und prüft gegen die Modulspezifikation bzw. den Feinentwurf."},{"text":"Integrationstest","is_correct":false,"rationale":"Der Integrationstest gehört zum Grobentwurf/Architektur - er prüft das Zusammenspiel der Komponenten."},{"text":"Systemtest","is_correct":false,"rationale":"Der Systemtest gehört zur Systemspezifikation, also eine Ebene unterhalb der Anforderungsdefinition. Er prüft in der Testumgebung, der Abnahmetest beim Kunden."}]}'::jsonb,
  'removed2025'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'vor-003',
  'vorgehensmodelle',
  'matching',
  null,
  'Ordne jede Aussage dem Vorgehensmodell zu, das sie am besten beschreibt.',
  'Für die Prüfung reicht je ein Erkennungsmerkmal pro Modell: Wasserfall = sequenziell, V-Modell = Teststufen-Paare, Spiralmodell = Risikoanalyse pro Zyklus, Scrum = Inkremente in festen Sprints.',
  2,
  ARRAY['modellvergleich']::text[],
  null,
  '{"buckets":["Wasserfall","V-Modell","Spiralmodell","Scrum"],"match_items":[{"text":"Streng sequenziell, jede Phase endet mit einem Dokument.","bucket":0,"rationale":"Das Grundprinzip des Wasserfalls."},{"text":"Jeder Entwicklungsstufe ist eine passende Teststufe zugeordnet.","bucket":1,"rationale":"Das ist genau die Erweiterung, die das V-Modell gegenüber dem Wasserfall bringt."},{"text":"Wiederholte Zyklen mit expliziter Risikoanalyse zu Beginn jedes Zyklus.","bucket":2,"rationale":"Die Risikoanalyse pro Zyklus ist das Markenzeichen des Spiralmodells nach Boehm."},{"text":"Lieferung eines nutzbaren Inkrements am Ende jedes Sprints.","bucket":3,"rationale":"Das Increment ist ein Scrum-Artefakt; es muss die Definition of Done erfüllen."},{"text":"Anforderungen müssen zu Projektbeginn vollständig bekannt sein.","bucket":0,"rationale":"Die zentrale Voraussetzung - und Schwäche - des Wasserfalls."},{"text":"Priorisierung der Arbeit erfolgt fortlaufend durch eine Rolle mit Produktverantwortung.","bucket":3,"rationale":"Der Product Owner verantwortet die Reihenfolge im Product Backlog."}]}'::jsonb,
  'removed2025'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'vor-004',
  'vorgehensmodelle',
  'multiple',
  'Ein Kunde möchte eine Web-Anwendung, hat aber nur eine grobe Vorstellung vom Funktionsumfang und erwartet, dass sich die Anforderungen während der Entwicklung noch ändern.',
  'Welche Argumente sprechen hier für ein agiles Vorgehen?',
  'Entscheidungsregel: Sind die Anforderungen stabil und der Umfang vertraglich fix (z. B. Ausschreibung der öffentlichen Hand), ist klassisch richtig. Sind sie unklar oder veränderlich, ist agil richtig. Der häufigste Fehler in der Prüfung ist die Behauptung, agil brauche keine Dokumentation.',
  2,
  ARRAY['agil_vs_klassisch']::text[],
  null,
  '{"choices":[{"text":"Anforderungen können zwischen den Iterationen angepasst werden.","is_correct":true,"rationale":"Genau der Fall aus dem Szenario: unklare, veränderliche Anforderungen sind das Kernargument für agil."},{"text":"Der Kunde sieht nach jeder Iteration lauffähige Software.","is_correct":true,"rationale":"Früher Feedback-Zyklus. Fehlannahmen fallen nach Wochen auf, nicht nach Monaten."},{"text":"Das Projektbudget lässt sich von Anfang an exakt festschreiben.","is_correct":false,"rationale":"Falsch - das ist eine Stärke des klassischen Vorgehens. Agil arbeitet eher mit festem Budget und variablem Umfang."},{"text":"Der Dokumentationsaufwand entfällt vollständig.","is_correct":false,"rationale":"Falsch. Das agile Manifest sagt \"funktionierende Software MEHR ALS umfassende Dokumentation\" - nicht \"statt\". Dokumentation wird reduziert, nicht abgeschafft."},{"text":"Das Risiko einer kompletten Fehlentwicklung sinkt.","is_correct":true,"rationale":"Durch kurze Zyklen und regelmäßige Abnahme kann man maximal eine Iteration in die falsche Richtung laufen."},{"text":"Ein vollständiges Pflichtenheft ist zu Projektbeginn erforderlich.","is_correct":false,"rationale":"Falsch, das ist klassisches Vorgehen. Agil startet mit einem priorisierten Backlog, das sich weiterentwickelt."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'vor-005',
  'vorgehensmodelle',
  'single',
  null,
  'Warum sind Fehler aus der Analysephase im Wasserfallmodell besonders teuer?',
  'Rule of Ten: Ein Fehler, der in der Analyse 1 Euro kostet, kostet im Entwurf 10, in der Implementierung 100 und beim Kunden 1.000 Euro. Genau dagegen arbeiten V-Modell (früh definierte Tests) und agile Modelle (kurze Feedback-Schleifen).',
  3,
  ARRAY['wasserfall', 'fehlerkosten']::text[],
  null,
  '{"choices":[{"text":"Weil sie erst in der Testphase auffallen und dann alle darauf aufbauenden Phasen korrigiert werden müssen.","is_correct":true,"rationale":"Richtig. Der Aufwand zur Fehlerbehebung steigt mit jeder Phase etwa um den Faktor 10 (Rule of Ten)."},{"text":"Weil die Analysephase das teuerste Personal bindet.","is_correct":false,"rationale":"Die Personalkosten der Analyse sind nicht der Punkt. Entscheidend ist die Fortpflanzung des Fehlers durch alle Folgephasen."},{"text":"Weil das Wasserfallmodell keine Testphase vorsieht.","is_correct":false,"rationale":"Sachlich falsch: Test ist eine eigene Phase im Wasserfall. Nur liegt sie eben am Ende."},{"text":"Weil Analysefehler die Hardwarebeschaffung betreffen.","is_correct":false,"rationale":"Das ist ein Spezialfall, keine allgemeine Begründung."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'scr-001',
  'agil_scrum',
  'single',
  null,
  'Wer entscheidet in Scrum über die Reihenfolge im Product Backlog?',
  'Kurzformel: Product Owner = WAS und in welcher Reihenfolge. Developers = WIE und wie viel. Scrum Master = DASS es funktioniert.',
  1,
  ARRAY['scrum', 'rollen']::text[],
  null,
  '{"choices":[{"text":"Product Owner","is_correct":true,"rationale":"Richtig. Der Product Owner verantwortet die Wertmaximierung und damit die Priorisierung. Er darf sich beraten lassen, entscheidet aber allein."},{"text":"Scrum Master","is_correct":false,"rationale":"Der Scrum Master verantwortet die Wirksamkeit von Scrum - er moderiert, räumt Hindernisse weg und priorisiert gerade nicht."},{"text":"Die Developers","is_correct":false,"rationale":"Die Developers entscheiden, WIE und wie viel sie in einen Sprint nehmen, nicht in welcher Reihenfolge der Product Owner den Wert sieht."},{"text":"Der Lenkungsausschuss","is_correct":false,"rationale":"Ein Lenkungsausschuss ist ein Gremium des klassischen Projektmanagements und in Scrum nicht vorgesehen."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'scr-002',
  'agil_scrum',
  'ordering',
  null,
  'Bringe die Scrum-Events in die Reihenfolge, in der sie innerhalb eines Sprints stattfinden.',
  'Der Sprint selbst ist der Container für alle anderen Events. Wichtig für die Prüfung: Das Review kommt VOR der Retrospektive. Im Review geht es um das Produkt (mit Stakeholdern), in der Retrospektive um die Zusammenarbeit (nur das Scrum Team). Das Refinement ist kein eigenes Event, sondern eine laufende Tätigkeit.',
  2,
  ARRAY['scrum', 'events']::text[],
  null,
  '{"ordered_items":["Sprint Planning","Daily Scrum (täglich)","Sprint Review","Sprint Retrospective"],"ordering_hint":"Vom Sprintbeginn bis zum Sprintende"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'scr-003',
  'agil_scrum',
  'single',
  null,
  'Wie lang ist die Timebox des Daily Scrum bei einem vierwöchigen Sprint?',
  'Timeboxen bei einem Monatssprint (kürzere Sprints -> anteilig kürzer):
- Sprint Planning: max. 8 Stunden
- Daily Scrum: 15 Minuten (immer)
- Sprint Review: max. 4 Stunden
- Sprint Retrospective: max. 3 Stunden
Merkhilfe 8-4-3 und das Daily als Konstante.',
  1,
  ARRAY['scrum', 'timebox']::text[],
  null,
  '{"choices":[{"text":"15 Minuten","is_correct":true,"rationale":"Richtig. Das Daily ist immer auf 15 Minuten begrenzt - unabhängig von der Sprintlänge. Das ist die einzige Timebox, die nicht mitwächst."},{"text":"30 Minuten","is_correct":false,"rationale":"Nein. Diese Zahl verwechselt man leicht mit der anteiligen Skalierung anderer Events."},{"text":"1 Stunde","is_correct":false,"rationale":"Eine Stunde wäre die Größenordnung einer Retrospektive bei kurzen Sprints, nicht des Dailys."},{"text":"Vier Stunden","is_correct":false,"rationale":"Vier Stunden ist die Obergrenze des Sprint Reviews bei einem Monatssprint."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'scr-004',
  'agil_scrum',
  'matching',
  null,
  'Jedes Scrum-Artefakt hat ein "Commitment", das ihm Transparenz gibt. Ordne richtig zu.',
  'Drei Artefakte, drei Commitments: Product Backlog -> Product Goal, Sprint Backlog -> Sprint Goal, Increment -> Definition of Done. Diese Zuordnung wird gern gefragt, weil viele die DoD fälschlich dem Sprint Backlog zuordnen.',
  3,
  ARRAY['scrum', 'artefakte']::text[],
  null,
  '{"buckets":["Product Backlog","Sprint Backlog","Increment"],"match_items":[{"text":"Product Goal","bucket":0,"rationale":"Das Product Goal ist das langfristige Ziel, auf das das Product Backlog einzahlt."},{"text":"Sprint Goal","bucket":1,"rationale":"Das Sprint Goal ist das eine Ziel des Sprints und gehört zum Sprint Backlog."},{"text":"Definition of Done","bucket":2,"rationale":"Die DoD beschreibt, wann ein Increment wirklich fertig - also potenziell auslieferbar - ist."},{"text":"Geordnete Liste aller bekannten Anforderungen an das Produkt","bucket":0,"rationale":"Das ist die Definition des Product Backlogs."},{"text":"Auswahl der Items plus Plan zur Umsetzung für die kommenden Wochen","bucket":1,"rationale":"Sprint Backlog = Sprint Goal + ausgewählte Items + Umsetzungsplan."},{"text":"Das konkrete, nutzbare Ergebnis am Ende des Sprints","bucket":2,"rationale":"Das Increment ist das Arbeitsergebnis, das die DoD erfüllt."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'scr-005',
  'agil_scrum',
  'numeric',
  'Ein Scrum-Team hat in den letzten drei Sprints 28, 32 und 30 Story Points abgeschlossen. Im Product Backlog liegen noch 270 Story Points.',
  'Wie viele weitere Sprints braucht das Team voraussichtlich? Runde auf volle Sprints auf.',
  'Rechenweg:
1. Durchschnittliche Velocity = (28 + 32 + 30) / 3 = 30 Story Points/Sprint
2. 270 SP / 30 SP je Sprint = 9 Sprints
Wäre das Ergebnis krumm (z. B. 9,3), wird aufgerundet - ein halber Sprint existiert in der Planung nicht. Die Velocity wird immer aus abgeschlossenen (Definition of Done erfüllten) Items gebildet, nicht aus angefangenen.',
  2,
  ARRAY['scrum', 'velocity']::text[],
  null,
  '{"answer":9.0,"tolerance":0.0,"unit":"Sprints"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'scr-006',
  'agil_scrum',
  'single',
  null,
  'Wozu dient ein WIP-Limit in Kanban?',
  'Kanban-Kernpraktiken: Workflow visualisieren, WIP limitieren, Fluss steuern, Regeln explizit machen, Feedback etablieren, verbessern. Hintergrund ist das Littlesche Gesetz: Durchlaufzeit = WIP / Durchsatz. Weniger parallele Arbeit bedeutet direkt kürzere Durchlaufzeiten.',
  2,
  ARRAY['kanban', 'wip']::text[],
  null,
  '{"choices":[{"text":"Es begrenzt die Anzahl gleichzeitig bearbeiteter Aufgaben und macht Engpässe sichtbar.","is_correct":true,"rationale":"Richtig. Work in Progress zu begrenzen verkürzt die Durchlaufzeit und zwingt das Team, Aufgaben fertigzustellen, statt neue anzufangen."},{"text":"Es legt fest, wie viele Story Points pro Sprint eingeplant werden.","is_correct":false,"rationale":"Das ist die Velocity in Scrum. Kanban kennt keine Sprints und keine feste Einplanung."},{"text":"Es begrenzt die maximale Teamgröße.","is_correct":false,"rationale":"WIP bezieht sich auf Arbeit, nicht auf Personen."},{"text":"Es definiert, wie lange eine Aufgabe maximal dauern darf.","is_correct":false,"rationale":"Das wäre eine Timebox bzw. ein Service Level Expectation - nicht das WIP-Limit."}]}'::jsonb,
  'removed2025'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'scr-007',
  'agil_scrum',
  'multiple',
  null,
  'Welche Aussagen über User Stories und deren Akzeptanzkriterien sind korrekt?',
  'INVEST als Qualitätscheck für Stories: Independent, Negotiable, Valuable, Estimable, Small, Testable. Der klassische Prüfungsfallstrick ist die Abgrenzung Akzeptanzkriterien (pro Story, fachlich) gegen Definition of Done (teamweit, handwerklich).',
  3,
  ARRAY['scrum', 'user_story']::text[],
  null,
  '{"choices":[{"text":"Das Format lautet: Als <Rolle> möchte ich <Ziel>, um <Nutzen>.","is_correct":true,"rationale":"Das ist das Standardformat. Der \"um ... zu\"-Teil ist der wichtigste und wird am häufigsten weggelassen."},{"text":"Akzeptanzkriterien legen fest, wann die Story als erfüllt gilt.","is_correct":true,"rationale":"Sie sind storyspezifisch und prüfbar - im Gegensatz zur Definition of Done, die für alle Stories gilt."},{"text":"Die Definition of Done ersetzt die Akzeptanzkriterien.","is_correct":false,"rationale":"Falsch. Die DoD gilt teamweit für JEDES Increment (z. B. Code-Review erfolgt, Tests grün). Akzeptanzkriterien sind fachlich und gelten nur für diese eine Story. Beides muss erfüllt sein."},{"text":"Story Points schätzen den Aufwand relativ, nicht in Stunden.","is_correct":true,"rationale":"Relative Schätzung ist stabiler als absolute: Menschen vergleichen zuverlässiger, als sie Stunden schätzen."},{"text":"Eine User Story muss immer in einen Sprint passen.","is_correct":true,"rationale":"Passt sie nicht, wird sie im Refinement geteilt. Eine zu große Story heißt Epic."},{"text":"Der Scrum Master schreibt die User Stories.","is_correct":false,"rationale":"Falsch. Verantwortlich für das Product Backlog ist der Product Owner; formulieren kann sie jeder im Team."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'np-001',
  'netzplan',
  'netzplan',
  'Für die Einführung eines Ticketsystems wurden folgende Vorgänge geplant. Alle Zeiten in Arbeitstagen.',
  'Führe die Vorwärtsrechnung durch: trage FAZ und FEZ für jeden Vorgang ein.',
  'Vorwärtsrechnung, Regel: FAZ = größter FEZ aller Vorgänger (Startvorgang: 0), FEZ = FAZ + Dauer.

A: FAZ 0, FEZ 0+4 = 4
B: FAZ 4 (nach A), FEZ 4+3 = 7
C: FAZ 4 (nach A), FEZ 4+6 = 10
D: FAZ 7 (nach B), FEZ 7+5 = 12
E: FAZ = max(FEZ C = 10, FEZ D = 12) = 12, FEZ 12+2 = 14

Der häufigste Fehler: bei E den kleineren Wert nehmen. Bei mehreren Vorgängern gilt immer das MAXIMUM - der Vorgang kann erst starten, wenn der letzte Vorgänger fertig ist. Projektdauer: 14 Arbeitstage.',
  1,
  ARRAY['vorwärtsrechnung']::text[],
  null,
  '{"activities":[{"id":"A","name":"Anforderungsanalyse","duration":4,"predecessors":[]},{"id":"B","name":"Grobkonzept","duration":3,"predecessors":["A"]},{"id":"C","name":"Hardwarebeschaffung","duration":6,"predecessors":["A"]},{"id":"D","name":"Implementierung","duration":5,"predecessors":["B"]},{"id":"E","name":"Integrationstest","duration":2,"predecessors":["C","D"]}],"asked_fields":["faz","fez"]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'np-002',
  'netzplan',
  'netzplan',
  'Migration eines Warenwirtschaftssystems. Dauer in Arbeitstagen.',
  'Berechne den kompletten Netzplan: FAZ, FEZ, SAZ, SEZ sowie Gesamt- und freien Puffer.',
  'Vorwärts (FAZ = max FEZ der Vorgänger, FEZ = FAZ + D):
A 0/3, B 3/8, C 3/5, D 8/12, E 5/11, F max(12,11)=12/15
Projektdauer = 15 Arbeitstage.

Rückwärts (SEZ = min SAZ der Nachfolger, Endvorgang: SEZ = Projektdauer, SAZ = SEZ - D):
F 12/15, D 8/12, E 6/12, B 3/8, C 4/6, A 0/3

Puffer:
GP = SAZ - FAZ  ->  A 0, B 0, C 1, D 0, E 1, F 0
FP = min(FAZ der Nachfolger) - FEZ  ->  A 0, B 0, C 0, D 0, E 1, F 0

Der Lerneffekt steckt in Vorgang C: GP = 1, aber FP = 0. Man kann C zwar um einen Tag verschieben, ohne das Projektende zu gefährden - aber der Nachfolger E startet dann später. Freier Puffer heißt: verschiebbar OHNE den frühesten Start des Nachfolgers anzutasten. Kritischer Pfad: A - B - D - F.',
  2,
  ARRAY['vollständig', 'puffer']::text[],
  null,
  '{"activities":[{"id":"A","name":"Ist-Analyse","duration":3,"predecessors":[]},{"id":"B","name":"Datenmodell","duration":5,"predecessors":["A"]},{"id":"C","name":"Schulungskonzept","duration":2,"predecessors":["A"]},{"id":"D","name":"Migrationsskripte","duration":4,"predecessors":["B"]},{"id":"E","name":"Schulung","duration":6,"predecessors":["C"]},{"id":"F","name":"Go-Live","duration":3,"predecessors":["D","E"]}],"asked_fields":["faz","fez","saz","sez","gp","fp"]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'np-003',
  'netzplan',
  'numeric',
  'Gegeben ist folgender Netzplan (Dauer in Tagen):
A: 2 Tage, kein Vorgänger
B: 4 Tage, Vorgänger A
C: 3 Tage, Vorgänger A
D: 5 Tage, Vorgänger B
E: 2 Tage, Vorgänger C
F: 1 Tag, Vorgänger D und E',
  'Wie groß ist der Gesamtpuffer (GP) von Vorgang C?',
  'Vorwärtsrechnung:
A 0/2, B 2/6, C 2/5, D 6/11, E 5/7, F max(11,7)=11/12 -> Projektdauer 12

Rückwärtsrechnung:
F 11/12, D 6/11, E 9/11, B 2/6, C 6/9, A 0/2

GP(C) = SAZ(C) - FAZ(C) = 6 - 2 = 4 Tage.
Gegenprobe über die andere Formel: GP = SEZ - FEZ = 9 - 5 = 4. Stimmen beide Werte nicht überein, steckt ein Rechenfehler in der Rückwärtsrechnung.',
  2,
  ARRAY['gesamtpuffer']::text[],
  null,
  '{"answer":4.0,"tolerance":0.0,"unit":"Tage"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
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
  '{"choices":[{"text":"Die Zeit, um die der Vorgang verschoben werden kann, ohne den frühesten Anfang seiner Nachfolger zu verändern.","is_correct":true,"rationale":"Richtig. FP = kleinster FAZ der Nachfolger minus eigener FEZ. Diesen Puffer darf man aufbrauchen, ohne dass es irgendjemand anders merkt."},{"text":"Die Zeit, um die der Vorgang verschoben werden kann, ohne das Projektende zu gefährden.","is_correct":false,"rationale":"Das ist die Definition des GESAMTpuffers (GP = SAZ - FAZ). Der GP ist immer größer oder gleich dem FP."},{"text":"Die Differenz zwischen geplanter und tatsächlicher Dauer.","is_correct":false,"rationale":"Das wäre eine Abweichung im Projektcontrolling, kein Puffer aus der Netzplantechnik."},{"text":"Die Reservezeit, die das Projektteam zusätzlich einplant.","is_correct":false,"rationale":"Das ist eine Sicherheitsreserve. Puffer im Netzplan werden berechnet, nicht eingeplant."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'np-005',
  'netzplan',
  'multiple',
  null,
  'Welche Aussagen über den kritischen Pfad sind richtig?',
  'Der kritische Pfad ist der längste Weg vom Start- zum Endvorgang und damit die Kette ohne Puffer. Praktische Konsequenz fürs Projekt: Ressourcen und Aufmerksamkeit gehören zuerst dorthin. Bei Verkürzungsaufgaben immer nach jedem Schritt neu rechnen - der kritische Pfad kann wandern.',
  2,
  ARRAY['kritischer_pfad']::text[],
  null,
  '{"choices":[{"text":"Alle Vorgänge auf ihm haben einen Gesamtpuffer von 0.","is_correct":true,"rationale":"Das ist die Definition. Genau daran erkennt man ihn in der Rechnung."},{"text":"Er ist der längste Weg durch den Netzplan.","is_correct":true,"rationale":"Der längste Weg bestimmt die Projektdauer - deshalb hat er keinen Puffer."},{"text":"Verzögert sich ein Vorgang auf ihm um 2 Tage, verzögert sich das Projektende um 2 Tage.","is_correct":true,"rationale":"Ohne Puffer schlägt jede Verzögerung eins zu eins aufs Projektende durch."},{"text":"Ein Netzplan hat immer genau einen kritischen Pfad.","is_correct":false,"rationale":"Falsch. Es kann mehrere gleich lange kritische Pfade geben - dann ist das Projekt besonders anfällig, weil es mehrere pufferlose Ketten gibt."},{"text":"Er enthält immer die Vorgänge mit der längsten Einzeldauer.","is_correct":false,"rationale":"Falsch. Ein einzelner langer Vorgang kann parallel liegen und viel Puffer haben. Entscheidend ist die Kette, nicht die Einzeldauer."},{"text":"Eine Verkürzung eines Vorgangs auf dem kritischen Pfad verkürzt immer das Projekt um denselben Betrag.","is_correct":false,"rationale":"Falsch, und das ist der beliebteste Stolperstein: verkürzt man genug, wird ein anderer Weg zum kritischen Pfad und die Verkürzung verpufft ab diesem Punkt."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'np-006',
  'netzplan',
  'netzplan',
  'Aufbau eines neuen Serverraums, sieben Vorgänge, Dauer in Arbeitstagen.',
  'Ermittle für jeden Vorgang den Gesamtpuffer und den freien Puffer.',
  'Vorwärts: A 0/2, B 2/6, C 2/8, D 6/9, E 6/8, F max(9,8)=9/13, G max(8,13)=13/16. Projektdauer 16 Tage.

Rückwärts: G 13/16, F 9/13, E 11/13, D 6/9, C 3/9, B 2/6, A 0/2.

GP = SAZ - FAZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0
FP = min(FAZ Nachfolger) - FEZ: A 0, B 0, C 1, D 0, E 5, F 0, G 0

Kritischer Pfad: A - B - D - F - G (16 Tage).
Vorgang E hat mit 5 Tagen den größten Spielraum - hier kann man ohne Risiko Personal abziehen, wenn es auf dem kritischen Pfad brennt. Achtung bei C: die Lieferung dauert zwar am längsten (6 Tage), liegt aber trotzdem nicht auf dem kritischen Pfad.',
  3,
  ARRAY['puffer', 'kritischer_pfad']::text[],
  null,
  '{"activities":[{"id":"A","name":"Planung","duration":2,"predecessors":[]},{"id":"B","name":"Elektro-Vorbereitung","duration":4,"predecessors":["A"]},{"id":"C","name":"Lieferung Racks","duration":6,"predecessors":["A"]},{"id":"D","name":"Klimatechnik","duration":3,"predecessors":["B"]},{"id":"E","name":"Netzwerkverkabelung","duration":2,"predecessors":["B"]},{"id":"F","name":"Hardware-Montage","duration":4,"predecessors":["D","C"]},{"id":"G","name":"Inbetriebnahme","duration":3,"predecessors":["E","F"]}],"asked_fields":["gp","fp"]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'np-007',
  'netzplan',
  'numeric',
  'A: 5 Tage, kein Vorgänger
B: 3 Tage, kein Vorgänger
C: 4 Tage, Vorgänger A und B
D: 6 Tage, Vorgänger A
E: 2 Tage, Vorgänger C und D',
  'Wie lang dauert das Gesamtprojekt?',
  'Alle Wege durchrechnen und den längsten nehmen:
A - C - E = 5 + 4 + 2 = 11
B - C - E = 3 + 4 + 2 = 9
A - D - E = 5 + 6 + 2 = 13  <- längster Weg
Projektdauer = 13 Tage, kritischer Pfad A - D - E.
Kontrolle über die Vorwärtsrechnung: C startet bei max(5, 3) = 5, endet bei 9. D endet bei 11. E startet bei max(9, 11) = 11 und endet bei 13.',
  1,
  ARRAY['projektdauer']::text[],
  null,
  '{"answer":13.0,"tolerance":0.0,"unit":"Tage"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'tp-001',
  'terminplanung',
  'single',
  null,
  'Welchen Vorteil hat ein Netzplan gegenüber einem einfachen Balkenplan (Gantt-Diagramm)?',
  'Arbeitsteilung in der Praxis: mit dem Netzplan rechnen, mit dem Balkenplan kommunizieren. Moderne Tools erzeugen den Gantt direkt aus den Netzplandaten und zeichnen den kritischen Pfad rot ein - in der Prüfung muss man beides aber getrennt beherrschen.',
  2,
  ARRAY['gantt']::text[],
  null,
  '{"choices":[{"text":"Er zeigt Abhängigkeiten und Puffer explizit und macht den kritischen Pfad berechenbar.","is_correct":true,"rationale":"Richtig. Der Netzplan ist ein Rechenmodell: Puffer und kritischer Pfad ergeben sich rechnerisch, nicht durch Hinsehen."},{"text":"Er stellt den Zeitverlauf anschaulicher dar.","is_correct":false,"rationale":"Das ist gerade die Stärke des Balkenplans: Die Zeitachse ist maßstabsgetreu und auf einen Blick lesbar."},{"text":"Er benötigt keine Angabe von Vorgangsdauern.","is_correct":false,"rationale":"Ohne Dauern gibt es keine Vorwärts- und Rückwärtsrechnung. Der Netzplan braucht sie zwingend."},{"text":"Er eignet sich besser für die Präsentation vor der Geschäftsführung.","is_correct":false,"rationale":"Umgekehrt. Für Präsentationen nimmt man den Balkenplan, weil er ohne Erklärung verständlich ist."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'tp-002',
  'terminplanung',
  'single',
  null,
  'Was kennzeichnet einen Meilenstein in der Projektplanung?',
  'Meilensteine sind Entscheidungspunkte: Ergebnis da oder nicht, weiter oder nicht. Gute Meilensteine sind binär prüfbar formuliert ("Pflichtenheft vom Kunden unterzeichnet"), nicht schwammig ("Konzept weitgehend fertig"). In der Meilensteintrendanalyse (MTA) trägt man über die Zeit auf, wie sich die geplanten Meilensteintermine verschieben - eine steigende Linie bedeutet Verzug.',
  1,
  ARRAY['meilenstein']::text[],
  null,
  '{"choices":[{"text":"Ein Ereignis mit der Dauer null, an dem ein definiertes Zwischenergebnis vorliegt.","is_correct":true,"rationale":"Richtig. Ein Meilenstein verbraucht keine Zeit und keine Ressourcen - er stellt nur fest, ob ein Ergebnis erreicht ist."},{"text":"Der längste Vorgang im Projekt.","is_correct":false,"rationale":"Das hat mit Meilensteinen nichts zu tun; lange Vorgänge sind einfach Vorgänge."},{"text":"Ein Vorgang, der besonders viel Budget bindet.","is_correct":false,"rationale":"Budget ist kein Kriterium. Ein Meilenstein kostet definitionsgemäß nichts."},{"text":"Der Abschluss des gesamten Projekts.","is_correct":false,"rationale":"Der Projektabschluss IST ein Meilenstein, aber Meilensteine gibt es während des gesamten Projekts."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'tp-003',
  'terminplanung',
  'multiple',
  null,
  'Ein Meilensteintrendanalyse-Diagramm zeigt für einen Meilenstein eine nach oben steigende Linie. Welche Schlüsse sind zulässig?',
  'MTA-Lesehilfe: waagerecht = im Plan, steigend = Verzug, fallend = früher fertig, Zickzack = unsichere Schätzung bzw. instabile Planung. Ein Zickzack ist ein Warnsignal für die Planungsqualität, auch wenn der Endtermin am Ende stimmt.',
  2,
  ARRAY['mta']::text[],
  null,
  '{"choices":[{"text":"Der Meilenstein verschiebt sich immer weiter nach hinten.","is_correct":true,"rationale":"Richtig. Steigende Linie = der prognostizierte Termin wird bei jedem Berichtszeitpunkt später."},{"text":"Es besteht Handlungsbedarf, z. B. Ressourcen umsteuern oder Umfang kürzen.","is_correct":true,"rationale":"Die MTA ist ein Frühwarninstrument - der Zweck ist genau dieses Gegensteuern."},{"text":"Der Meilenstein wird früher als geplant erreicht.","is_correct":false,"rationale":"Falsch, das wäre eine FALLENDE Linie. Steigend = später."},{"text":"Das Projekt liegt im Plan.","is_correct":false,"rationale":"Falsch. Im Plan bedeutet eine waagerechte Linie."},{"text":"Die Ursache der Verzögerung lässt sich direkt aus dem Diagramm ablesen.","is_correct":false,"rationale":"Falsch. Die MTA zeigt, DASS sich etwas verschiebt, nicht WARUM. Die Ursachenanalyse ist eine separate Aufgabe."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'tp-004',
  'terminplanung',
  'numeric',
  'Für ein Arbeitspaket sind 120 Personentage veranschlagt. Es stehen 4 Entwickler zur Verfügung, die jedoch nur zu 75 % für das Projekt verfügbar sind (der Rest geht in Support und Linientätigkeit).',
  'Wie viele Arbeitstage dauert das Arbeitspaket? Runde auf volle Tage auf.',
  'Rechenweg:
1. Tatsächliche Kapazität pro Tag = 4 Entwickler x 0,75 = 3 Personentage/Tag
2. Dauer = 120 Personentage / 3 Personentage pro Tag = 40 Arbeitstage

Typischer Fehler: 120 / 4 = 30 Tage - die Verfügbarkeit wird vergessen. In Prüfungsaufgaben ist der Verfügbarkeitsgrad fast immer der eigentliche Prüfpunkt. Merke außerdem: Personentage sind Aufwand, Arbeitstage sind Dauer. Die beiden Einheiten zu verwechseln kostet in der Klausur sofort Punkte.',
  3,
  ARRAY['ressourcenplanung']::text[],
  null,
  '{"answer":40.0,"tolerance":0.0,"unit":"Arbeitstage"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'lh-001',
  'anforderungen',
  'matching',
  null,
  'Ordne jede Aussage dem richtigen Dokument zu. (Nach DIN 69901-5)',
  'Eselsbrücke: LAstenheft = Auftraggeber (der die Last verteilt), PFlichtenheft = Auftragnehmer (der die Pflicht übernimmt). Reihenfolge: Lastenheft -> Ausschreibung -> Angebote -> Zuschlag -> Pflichtenheft -> Genehmigung -> Umsetzung -> Abnahme gegen das Pflichtenheft.',
  1,
  ARRAY['lastenheft', 'pflichtenheft']::text[],
  null,
  '{"buckets":["Lastenheft","Pflichtenheft"],"match_items":[{"text":"Wird vom Auftraggeber erstellt.","bucket":0,"rationale":"Merksatz: Der Auftraggeber lädt dem Auftragnehmer die Last auf."},{"text":"Wird vom Auftragnehmer erstellt.","bucket":1,"rationale":"Der Auftragnehmer beschreibt, wie er die Pflicht erfüllt."},{"text":"Beschreibt das WAS und WOFÜR - die Gesamtheit der Anforderungen.","bucket":0,"rationale":"Das Lastenheft ist bewusst lösungsneutral formuliert."},{"text":"Beschreibt das WIE und WOMIT - die konkrete technische Umsetzung.","bucket":1,"rationale":"Erst im Pflichtenheft werden Technologien, Schnittstellen und Architektur festgelegt."},{"text":"Ist Grundlage für die Ausschreibung und den Angebotsvergleich.","bucket":0,"rationale":"Alle Anbieter bekommen dasselbe Lastenheft - nur so sind Angebote vergleichbar."},{"text":"Wird vom Auftraggeber genehmigt und ist Grundlage der Abnahme.","bucket":1,"rationale":"Das genehmigte Pflichtenheft ist der vertragliche Maßstab, gegen den abgenommen wird."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'lh-002',
  'anforderungen',
  'matching',
  null,
  'Handelt es sich um eine funktionale oder eine nicht-funktionale Anforderung?',
  'Testfrage zur Abgrenzung: Kann man die Anforderung als "Das System TUT etwas" formulieren? Dann funktional. Beschreibt sie eher, WIE GUT das System etwas tut (schnell, sicher, verfügbar, bedienbar, wartbar, portabel), dann nicht-funktional. Die sechs Qualitätsmerkmale nach ISO 25010 sind eine gute Checkliste für nicht-funktionale Anforderungen.',
  2,
  ARRAY['anforderungsarten']::text[],
  null,
  '{"buckets":["Funktional","Nicht-funktional"],"match_items":[{"text":"Das System muss Rechnungen als PDF exportieren können.","bucket":0,"rationale":"Eine konkrete Fähigkeit des Systems - also funktional."},{"text":"Die Suchanfrage muss in unter 2 Sekunden beantwortet werden.","bucket":1,"rationale":"Performance ist eine Qualitätseigenschaft, kein Funktionsumfang."},{"text":"Benutzer müssen sich mit Zwei-Faktor-Authentifizierung anmelden können.","bucket":0,"rationale":"Die Anmeldung mit 2FA ist eine Funktion, die das System bereitstellen muss."},{"text":"Die Anwendung muss zu 99,5 % im Jahr verfügbar sein.","bucket":1,"rationale":"Verfügbarkeit ist eine klassische nicht-funktionale Anforderung."},{"text":"Die Oberfläche muss der BITV 2.0 für Barrierefreiheit entsprechen.","bucket":1,"rationale":"Eine Randbedingung bzw. Qualitätsanforderung - sie beschreibt keine einzelne Funktion."},{"text":"Administratoren können Benutzerkonten sperren und entsperren.","bucket":0,"rationale":"Wieder eine konkrete Fähigkeit - funktional."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'lh-003',
  'anforderungen',
  'multiple',
  null,
  'Was zeichnet eine gut formulierte Anforderung aus?',
  'Merkhilfe für Anforderungsqualität: eindeutig, vollständig, widerspruchsfrei, prüfbar, notwendig, verständlich, priorisiert. Priorisierung erfolgt oft nach MuSCoW: Must have, Should have, Could have, Won t have.',
  2,
  ARRAY['anforderungsqualität']::text[],
  null,
  '{"choices":[{"text":"Sie ist eindeutig und lässt nur eine Interpretation zu.","is_correct":true,"rationale":"Mehrdeutigkeit ist die Hauptursache für Streit bei der Abnahme."},{"text":"Sie ist überprüfbar bzw. testbar.","is_correct":true,"rationale":"Wenn niemand entscheiden kann, ob sie erfüllt ist, ist sie wertlos."},{"text":"Sie ist vollständig - es fehlen keine notwendigen Angaben.","is_correct":true,"rationale":"Klassisches Kriterium aus der Anforderungsanalyse."},{"text":"Sie enthält bereits die technische Lösung.","is_correct":false,"rationale":"Falsch, zumindest im Lastenheft. Eine vorweggenommene Lösung schließt bessere Alternativen aus. Das WIE gehört ins Pflichtenheft."},{"text":"Sie ist mit anderen Anforderungen widerspruchsfrei.","is_correct":true,"rationale":"Widersprüche fallen sonst erst in der Umsetzung auf - dann ist die Korrektur teuer."},{"text":"Sie ist möglichst allgemein gehalten, um flexibel zu bleiben.","is_correct":false,"rationale":"Falsch. \"Das System soll benutzerfreundlich sein\" ist nicht flexibel, sondern unprüfbar. Flexibilität erreicht man über Prioritäten, nicht über Vagheit."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'lh-004',
  'leistungsstoerungen',
  'single',
  'Ein Dienstleister liefert eine Software aus. Bei der Abnahme stellt der Kunde zwei kleinere Mängel fest, die den Betrieb nicht verhindern.',
  'Was ist die übliche und rechtlich sinnvolle Vorgehensweise?',
  'Was an der Abnahme hängt: Fälligkeit der Vergütung, Gefahrübergang, Beginn der Verjährungsfrist für Gewährleistung und die Umkehr der Beweislast (danach muss der Kunde den Mangel beweisen). Deshalb ist das Abnahmeprotokoll mit Mängelliste kein Formalkram, sondern der wichtigste Zettel im Projekt.',
  2,
  ARRAY['abnahme']::text[],
  null,
  '{"choices":[{"text":"Abnahme unter Vorbehalt: Mängel werden protokolliert und mit Frist zur Beseitigung vereinbart.","is_correct":true,"rationale":"Richtig. Die Abnahme unter Vorbehalt hält die Mängelrechte aufrecht und blockiert trotzdem nicht den Produktivstart."},{"text":"Vollständige Verweigerung der Abnahme bis alle Mängel beseitigt sind.","is_correct":false,"rationale":"Bei unwesentlichen Mängeln ist die Verweigerung in der Regel unzulässig (vgl. Werkvertragsrecht) und schadet dem Kunden selbst, weil der Nutzen ausbleibt."},{"text":"Vorbehaltlose Abnahme, die Mängel werden formlos per E-Mail gemeldet.","is_correct":false,"rationale":"Gefährlich: Mit der vorbehaltlosen Abnahme verliert der Kunde bei bekannten Mängeln seine Rechte darauf."},{"text":"Die Abnahme entfällt, weil die Software bereits läuft.","is_correct":false,"rationale":"Die Abnahme ist ein formaler Rechtsakt mit erheblichen Folgen (Gefahrübergang, Fälligkeit der Vergütung, Beginn der Gewährleistung). Sie entfällt nicht durch Nutzung - im Gegenteil kann Nutzung als konkludente Abnahme gelten."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'lh-005',
  'anforderungen',
  'ordering',
  null,
  'Bringe die Schritte einer klassischen Fremdvergabe in die richtige Reihenfolge.',
  'Die zwei Stellen, an denen in der Prüfung gern getauscht wird: (1) Das Pflichtenheft kommt NACH der Vergabe - vorher weiß man ja gar nicht, wer es schreibt. (2) Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft, weil nur das Pflichtenheft die prüfbare Konkretisierung enthält.',
  2,
  ARRAY['ablauf']::text[],
  null,
  '{"ordered_items":["Lastenheft durch den Auftraggeber erstellen","Ausschreibung und Einholung von Angeboten","Angebotsvergleich und Vergabeentscheidung","Pflichtenheft durch den Auftragnehmer erstellen","Genehmigung des Pflichtenhefts durch den Auftraggeber","Realisierung","Abnahme gegen das Pflichtenheft"],"ordering_hint":"Vom ersten bis zum letzten Schritt"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'lh-006',
  'change_management',
  'single',
  'Während der Realisierung bittet die Fachabteilung den Entwickler mehrfach direkt um "kleine Zusatzfunktionen". Der Termin ist unverändert.',
  'Wie sollte die Projektleitung darauf reagieren?',
  'Change-Request-Prozess: Antrag erfassen -> Auswirkung auf Zeit, Kosten und Qualität bewerten -> Entscheidung durch den befugten Gremium bzw. Auftraggeber -> bei Annahme Planung und Pflichtenheft fortschreiben. Der Kern ist Transparenz: Jeder soll sehen, was eine Änderung kostet.',
  3,
  ARRAY['scope_creep']::text[],
  null,
  '{"choices":[{"text":"Jede Änderung über einen definierten Change-Request-Prozess mit Aufwands- und Terminbewertung führen.","is_correct":true,"rationale":"Richtig. Änderungen sind nicht verboten - sie müssen nur bewertet und entschieden werden, statt still im Hintergrund zu passieren."},{"text":"Die Zusatzwünsche ablehnen, weil das Pflichtenheft unterschrieben ist.","is_correct":false,"rationale":"Pauschale Ablehnung ist praxisfern und beschädigt die Zusammenarbeit. Anforderungen ändern sich - das Problem ist der unkontrollierte Weg, nicht die Änderung selbst."},{"text":"Die Wünsche kurzfristig mit umsetzen, solange sie klein sind.","is_correct":false,"rationale":"Genau so entsteht Scope Creep: viele kleine, nie bewertete Erweiterungen sprengen am Ende Termin und Budget, und niemand kann hinterher sagen, warum."},{"text":"Die Entscheidung dem Entwickler überlassen, der den Aufwand am besten einschätzen kann.","is_correct":false,"rationale":"Der Entwickler kann den Aufwand schätzen, aber nicht über Umfang, Budget und Termin entscheiden. Das ist eine Projektleitungs- bzw. Auftraggeberentscheidung."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'wi-001',
  'pm_wirtschaftlichkeit',
  'numeric',
  'Nutzwertanalyse für ein Ticketsystem. Bewertungsskala 1 (schlecht) bis 5 (sehr gut).

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

Kontrolle: Die Gewichtungen müssen in Summe 100 % ergeben, sonst ist das Ergebnis nicht vergleichbar. Und der Nutzwert kann nie über dem Maximum der Skala (hier 5) liegen.',
  2,
  ARRAY['nutzwertanalyse']::text[],
  null,
  '{"answer":3.65,"tolerance":0.01}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'wi-002',
  'pm_wirtschaftlichkeit',
  'single',
  null,
  'Wozu dient die Nutzwertanalyse?',
  'Ablauf der Nutzwertanalyse: 1. Kriterien festlegen, 2. gewichten (Summe 100 %), 3. Alternativen je Kriterium bewerten, 4. Teilnutzwerte = Gewicht x Bewertung, 5. aufsummieren, 6. höchster Nutzwert gewinnt.
Schwäche, nach der gern gefragt wird: Gewichtung und Bewertung sind subjektiv. Wer das Ergebnis vorher kennt, kann es über die Gewichtung herbeiführen - deshalb Kriterien VOR dem Blick auf die Angebote festlegen.',
  2,
  ARRAY['nutzwertanalyse']::text[],
  null,
  '{"choices":[{"text":"Zum Vergleich von Alternativen anhand mehrerer, unterschiedlich gewichteter und teils nicht monetärer Kriterien.","is_correct":true,"rationale":"Richtig. Ihre Stärke ist, dass sie weiche Faktoren wie Bedienbarkeit oder Zukunftssicherheit vergleichbar macht."},{"text":"Zur Berechnung des exakten Return on Investment.","is_correct":false,"rationale":"Der ROI ist eine rein monetäre Kennzahl. Die Nutzwertanalyse liefert dimensionslose Punkte, keine Euro."},{"text":"Zur Ermittlung der Projektdauer.","is_correct":false,"rationale":"Das leistet die Netzplantechnik."},{"text":"Zur rechtssicheren Dokumentation gegenüber dem Auftraggeber.","is_correct":false,"rationale":"Sie kann eine Entscheidung nachvollziehbar machen, ist aber kein Rechtsdokument."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'wi-003',
  'pm_wirtschaftlichkeit',
  'numeric',
  'Eine Virtualisierungslösung kostet einmalig 48.000 Euro. Dadurch sinken die laufenden Kosten um 15.000 Euro pro Jahr.',
  'Nach wie vielen Jahren ist die Investition amortisiert? (Eine Nachkommastelle)',
  'Amortisationsdauer = Investitionssumme / jährlicher Rückfluss
= 48.000 Euro / 15.000 Euro pro Jahr = 3,2 Jahre

In Worten: nach rund 3 Jahren und 2-3 Monaten hat sich die Anschaffung bezahlt gemacht. Achtung bei Aufgaben, in denen zusätzlich laufende Kosten der neuen Lösung genannt werden - dann muss man erst den NETTO-Rückfluss bilden (Einsparung minus neue laufende Kosten) und erst damit rechnen.',
  2,
  ARRAY['amortisation']::text[],
  null,
  '{"answer":3.2,"tolerance":0.05,"unit":"Jahre"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'wi-004',
  'pm_wirtschaftlichkeit',
  'numeric',
  'Ein Angebot für Netzwerk-Hardware:
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
  '{"answer":10246.0,"tolerance":0.5,"unit":"Euro"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'wi-005',
  'pm_wirtschaftlichkeit',
  'multiple',
  null,
  'Welche Positionen gehören in eine TCO-Betrachtung (Total Cost of Ownership) für eine Serverbeschaffung?',
  'TCO betrachtet den gesamten Lebenszyklus: Beschaffung, Betrieb, Wartung, Schulung, Ausfallkosten, Außerbetriebnahme. Der Sinn ist, das billigste Angebot vom günstigsten zu unterscheiden. Wichtig zur Abgrenzung: TCO = nur Kosten. ROI und Wirtschaftlichkeitsrechnung = Kosten UND Nutzen.',
  2,
  ARRAY['tco']::text[],
  null,
  '{"choices":[{"text":"Anschaffungskosten der Hardware","is_correct":true,"rationale":"Die direkten Anschaffungskosten sind der offensichtliche Teil - meist der kleinere."},{"text":"Strom- und Klimatisierungskosten über die Nutzungsdauer","is_correct":true,"rationale":"Laufende Betriebskosten sind bei Servern oft höher als der Kaufpreis."},{"text":"Lizenz- und Wartungsverträge","is_correct":true,"rationale":"Wiederkehrende Kosten, die sich über 5 Jahre erheblich summieren."},{"text":"Schulungsaufwand für die Administratoren","is_correct":true,"rationale":"Auch indirekte Personalkosten gehören dazu - das unterscheidet TCO vom reinen Anschaffungspreis."},{"text":"Der Umsatz, der mit dem neuen System erzielt wird","is_correct":false,"rationale":"Falsch. TCO betrachtet ausschließlich die KOSTEN. Erträge gehören in eine Wirtschaftlichkeits- oder ROI-Rechnung."},{"text":"Entsorgungs- und Migrationskosten am Ende der Nutzungsdauer","is_correct":true,"rationale":"Der oft vergessene letzte Lebenszyklusabschnitt gehört ausdrücklich dazu."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qr-001',
  'risikomanagement',
  'numeric',
  'Für das Risiko "Ausfall des Hauptlieferanten" wurde eine Eintrittswahrscheinlichkeit von 20 % und eine Schadenshöhe von 80.000 Euro geschätzt.',
  'Wie hoch ist der Risikowert (Erwartungswert) in Euro?',
  'Risikowert = Eintrittswahrscheinlichkeit x Schadenshöhe
= 0,20 x 80.000 Euro = 16.000 Euro

Der Risikowert ist die Obergrenze für sinnvolle Gegenmaßnahmen: Eine Maßnahme, die 25.000 Euro kostet, lohnt sich hier nicht. Deshalb werden Risiken nach dem Risikowert priorisiert und nicht nach der Schadenshöhe allein.',
  1,
  ARRAY['risikobewertung']::text[],
  null,
  '{"answer":16000.0,"tolerance":0.0,"unit":"Euro"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qr-002',
  'risikomanagement',
  'matching',
  null,
  'Ordne jede Maßnahme der passenden Risikostrategie zu.',
  'Vier Strategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit oder Auswirkung runter), Überwälzen (Dritter trägt das Risiko), Akzeptieren (bewusst tragen).
Der häufigste Fehler ist die Verwechslung von Vermeiden und Vermindern. Testfrage: Kann das Risiko danach überhaupt noch eintreten? Ja -> Vermindern. Nein -> Vermeiden.',
  2,
  ARRAY['risikostrategien']::text[],
  null,
  '{"buckets":["Vermeiden","Vermindern","Überwälzen","Akzeptieren"],"match_items":[{"text":"Auf den Einsatz einer unausgereiften Technologie wird verzichtet.","bucket":0,"rationale":"Die Ursache wird komplett beseitigt - die Eintrittswahrscheinlichkeit sinkt auf null."},{"text":"Zusätzliche Code-Reviews und automatisierte Tests werden eingeführt.","bucket":1,"rationale":"Die Eintrittswahrscheinlichkeit sinkt, das Risiko bleibt aber grundsätzlich bestehen."},{"text":"Eine Betriebshaftpflichtversicherung wird abgeschlossen.","bucket":2,"rationale":"Der finanzielle Schaden geht auf einen Dritten über - klassisches Überwälzen."},{"text":"Die Entwicklung wird an einen Dienstleister mit Festpreis vergeben.","bucket":2,"rationale":"Das Kostenrisiko trägt beim Festpreis der Auftragnehmer."},{"text":"Ein Restrisiko mit sehr geringem Schadenswert wird bewusst in Kauf genommen und dokumentiert.","bucket":3,"rationale":"Akzeptieren ist eine legitime Strategie - entscheidend ist, dass es bewusst und dokumentiert geschieht."},{"text":"Ein Backup-Rechenzentrum wird bereitgehalten, um die Ausfalldauer zu begrenzen.","bucket":1,"rationale":"Die Auswirkung wird reduziert. Das Risiko selbst bleibt bestehen - also Vermindern, nicht Vermeiden."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qr-003',
  'qualitaetsmanagement',
  'multiple',
  null,
  'Welche der folgenden Maßnahmen sind KONSTRUKTIVE Qualitätssicherungsmaßnahmen?',
  'Einfache Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler (Standards, Methoden, Werkzeuge, Schulung, Templates). ANALYTISCH = nachher, findet Fehler (Test, Review, Inspektion, statische Analyse, Audit).
Grenzfall, der gern gefragt wird: Ein Linter ist konstruktiv, wenn er beim Schreiben eingreift, und analytisch, wenn er im Nachhinein über fertigen Code läuft. In der Prüfung zählt die Einordnung als Werkzeugvorgabe - also konstruktiv.',
  2,
  ARRAY['qualitätssicherung']::text[],
  null,
  '{"choices":[{"text":"Verbindliche Coding-Standards und Styleguides","is_correct":true,"rationale":"Konstruktiv: Sie verhindern Fehler von vornherein, statt sie hinterher zu finden."},{"text":"Einsatz erprobter Frameworks und Entwurfsmuster","is_correct":true,"rationale":"Ebenfalls vorbeugend - das Rad nicht neu erfinden heißt, dessen Fehler nicht neu zu machen."},{"text":"Schulung der Entwickler vor Projektbeginn","is_correct":true,"rationale":"Qualifikation ist eine klassische konstruktive Maßnahme."},{"text":"Durchführung von Modul- und Integrationstests","is_correct":false,"rationale":"Das ist ANALYTISCHE QS: Tests finden vorhandene Fehler, sie verhindern sie nicht."},{"text":"Code-Review nach Fertigstellung eines Moduls","is_correct":false,"rationale":"Ebenfalls analytisch - es wird ein bereits erstelltes Artefakt geprüft."},{"text":"Einsatz einer einheitlichen Entwicklungsumgebung mit Linter-Konfiguration","is_correct":true,"rationale":"Vorbeugend: Der Linter verhindert bestimmte Fehlerklassen schon beim Tippen."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qr-004',
  'risikomanagement',
  'single',
  'In der Risikomatrix liegt Risiko X bei geringer Eintrittswahrscheinlichkeit, aber existenzbedrohender Schadenshöhe (z. B. vollständiger Datenverlust ohne Backup).',
  'Wie ist mit einem solchen Risiko umzugehen?',
  'Die Risikomatrix (Wahrscheinlichkeit x Auswirkung) hat eine eingebaute Schwäche: Sie behandelt "oft, aber harmlos" und "selten, aber katastrophal" gleich, wenn das Produkt gleich ist. In der Praxis zieht man deshalb eine Toleranzgrenze: Schäden oberhalb einer bestimmten Höhe werden unabhängig von der Wahrscheinlichkeit behandelt. Genau deshalb gibt es Backups, obwohl Totalausfälle selten sind.',
  3,
  ARRAY['risikomatrix']::text[],
  null,
  '{"choices":[{"text":"Es muss trotz geringer Wahrscheinlichkeit behandelt werden, weil der Schaden untragbar wäre.","is_correct":true,"rationale":"Richtig. Bei existenzbedrohenden Schäden greift die reine Erwartungswertlogik nicht mehr - ein Schaden, den man nicht überlebt, darf nicht eintreten."},{"text":"Es kann akzeptiert werden, weil der Risikowert rechnerisch niedrig ist.","is_correct":false,"rationale":"Genau der Denkfehler. Ein rechnerisch kleiner Erwartungswert hilft nicht, wenn der Einzelfall das Unternehmen beendet."},{"text":"Es ist nachrangig gegenüber Risiken mit mittlerer Wahrscheinlichkeit und mittlerem Schaden.","is_correct":false,"rationale":"Falsch. Bei gleicher Rechengröße hat das Risiko mit dem katastrophalen Schadenspotenzial Vorrang."},{"text":"Es gehört nicht in das Risikoregister, weil es unwahrscheinlich ist.","is_correct":false,"rationale":"Ins Register gehören alle identifizierten Risiken. Erst die Bewertung entscheidet über Maßnahmen."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'ab-001',
  'projektabschluss',
  'single',
  null,
  'Was ist das Ziel einer Lessons-Learned-Sitzung?',
  'Lessons Learned funktionieren nur unter drei Bedingungen: zeitnah (nicht Monate später), ohne Schuldzuweisung und mit dokumentiertem Ergebnis an einem Ort, an dem das nächste Projekt es auch findet. Eine Sitzung, deren Protokoll in einem Ordner verschwindet, ist verlorene Zeit.',
  1,
  ARRAY['lessons_learned']::text[],
  null,
  '{"choices":[{"text":"Erfahrungen systematisch sichern, damit künftige Projekte davon profitieren.","is_correct":true,"rationale":"Richtig. Der Wert entsteht erst dadurch, dass die Erkenntnisse dokumentiert und in der Organisation verfügbar gemacht werden."},{"text":"Die Verantwortlichen für Fehler im Projekt benennen.","is_correct":false,"rationale":"Genau das Gegenteil. Sobald Schuldzuweisungen drohen, sagt niemand mehr, was wirklich schieflief - und die Sitzung ist wertlos."},{"text":"Die Abnahme des Projektergebnisses durch den Kunden.","is_correct":false,"rationale":"Die Abnahme ist ein eigener, vorgelagerter Schritt."},{"text":"Die Schlussrechnung für den Kunden erstellen.","is_correct":false,"rationale":"Das ist kaufmännischer Projektabschluss, nicht Erfahrungssicherung."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'ab-002',
  'projektabschluss',
  'multiple',
  null,
  'Was gehört in einen Projektabschlussbericht?',
  'Der Projektabschluss hat drei Ebenen: sachlich-technisch (Abnahme, Übergabe an den Betrieb, Restarbeiten), kaufmännisch (Schlussrechnung, Nachkalkulation, Projekt schließen) und personell (Teamauflösung, Rückführung in die Linie, Würdigung). Die personelle Ebene wird am häufigsten vergessen - und ist die, an die sich das Team am längsten erinnert.',
  2,
  ARRAY['abschlussbericht']::text[],
  null,
  '{"choices":[{"text":"Soll-Ist-Vergleich von Terminen, Kosten und Leistungsumfang","is_correct":true,"rationale":"Der Kern des Berichts: Was war geplant, was ist herausgekommen, warum die Abweichung?"},{"text":"Zielerreichungsgrad bezogen auf den Projektauftrag","is_correct":true,"rationale":"Gemessen wird gegen das, was im Auftrag stand - nicht gegen das, was unterwegs daraus wurde."},{"text":"Lessons Learned und Verbesserungsvorschläge","is_correct":true,"rationale":"Die Erfahrungssicherung gehört in den Bericht, nicht nur ins Sitzungsprotokoll."},{"text":"Übergabe an Betrieb bzw. Linie mit benannten Verantwortlichen","is_correct":true,"rationale":"Ohne klare Übergabe bleibt das Projektteam ewig zuständig - ein häufiger Praxisfehler."},{"text":"Der vollständige Quellcode der Anwendung","is_correct":false,"rationale":"Falsch. Der Code gehört ins Versionsverwaltungssystem, nicht in den Bericht. Der Bericht verweist darauf."},{"text":"Offene Punkte und Restrisiken","is_correct":true,"rationale":"Was nicht erledigt wurde, muss benannt und an jemanden übergeben werden."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'ab-003',
  'projektabschluss',
  'ordering',
  null,
  'Bringe die Schritte des Projektabschlusses in eine sinnvolle Reihenfolge.',
  'Zwei Stellen, an denen gern getauscht wird: Die Abnahme kommt VOR der Übergabe an den Betrieb - man übergibt nichts, was der Kunde nicht angenommen hat. Und die Teamauflösung kommt ZULETZT, weil man für Bericht und Lessons Learned die Leute noch braucht. Wer das Team vorher auflöst, bekommt weder das eine noch das andere in brauchbarer Qualität.',
  2,
  ARRAY['projektabschluss']::text[],
  null,
  '{"ordered_items":["Restarbeiten abschließen und Projektergebnis fertigstellen","Abnahme durch den Auftraggeber mit Abnahmeprotokoll","Übergabe an den Betrieb bzw. die Linienorganisation","Projektabschlussbericht mit Soll-Ist-Vergleich erstellen","Lessons Learned durchführen und dokumentieren","Projektteam formal auflösen und Ressourcen freigeben"],"ordering_hint":"Vom ersten bis zum letzten Schritt"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qm-001',
  'qualitaetsmanagement',
  'ordering',
  null,
  'Bringe die Phasen des PDCA-Zyklus in die richtige Reihenfolge.',
  'Der PDCA-Zyklus (auch Deming-Kreis) ist das Grundmuster jeder kontinuierlichen Verbesserung. Zwei Punkte werden gern falsch verstanden:
- "Do" heißt ausprobieren im kleinen Rahmen, nicht flächendeckend ausrollen. Das Ausrollen passiert erst in "Act".
- Der Zyklus endet nicht, sondern beginnt von vorn - deshalb Kreis und nicht Liste.',
  1,
  ARRAY['pdca']::text[],
  null,
  '{"ordered_items":["Plan - Ziel festlegen und Maßnahme planen","Do - Maßnahme im Kleinen ausprobieren","Check - Ergebnis mit dem Ziel vergleichen","Act - bei Erfolg zum Standard machen, sonst nachbessern"],"ordering_hint":"Beginne mit der Planung"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qm-002',
  'qualitaetsmanagement',
  'single',
  null,
  'Was bedeutet Qualität im Sinne des Qualitätsmanagements?',
  'Qualität = Erfüllungsgrad der Anforderungen. Daraus folgt eine praktische Konsequenz: Ohne prüfbar formulierte Anforderungen kann man Qualität gar nicht feststellen. Deshalb hängen Anforderungsanalyse und Qualitätssicherung unmittelbar zusammen - und deshalb ist eine unprüfbare Anforderung wie "benutzerfreundlich" ein Qualitätsproblem, bevor die erste Zeile Code geschrieben ist.',
  2,
  ARRAY['qualitätsbegriff']::text[],
  null,
  '{"choices":[{"text":"Der Grad, in dem ein Produkt die festgelegten Anforderungen erfüllt.","is_correct":true,"rationale":"Richtig. Qualität ist relativ zu den vereinbarten Anforderungen - nicht absolut."},{"text":"Die technisch bestmögliche Ausführung eines Produkts.","is_correct":false,"rationale":"Falsch. Das wäre Perfektion. Ein Produkt, das teurer ist als gefordert, hat nicht mehr Qualität, sondern verschwendet Budget."},{"text":"Die Abwesenheit jeglicher Fehler.","is_correct":false,"rationale":"Falsch. Nullfehler ist ein Ziel, keine Definition. Auch ein Produkt mit bekannten, akzeptierten Restmängeln kann die Anforderungen erfüllen."},{"text":"Die Zufriedenheit der Entwickler mit dem Ergebnis.","is_correct":false,"rationale":"Falsch. Maßstab ist die Anforderung des Kunden, nicht das Empfinden des Teams."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qm-003',
  'qualitaetsmanagement',
  'matching',
  null,
  'Ordne die Maßnahmen der konstruktiven oder analytischen Qualitätssicherung zu.',
  'Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler (Standards, Methoden, Werkzeuge, Schulung, Templates). ANALYTISCH = nachher, findet Fehler (Test, Review, Inspektion, Audit).
Merksatz: Der Test findet den Fehler, der Standard verhindert ihn. Wirtschaftlich ist konstruktive QS fast immer überlegen - siehe Rule of Ten.',
  2,
  ARRAY['qs_maßnahmen']::text[],
  null,
  '{"buckets":["Konstruktiv (verhindert Fehler)","Analytisch (findet Fehler)"],"match_items":[{"text":"Verbindlicher Styleguide für die Programmierung","bucket":0,"rationale":"Eine Vorgabe, die bestimmte Fehler gar nicht erst entstehen lässt."},{"text":"Code-Review eines fertigen Moduls","bucket":1,"rationale":"Ein bereits erstelltes Artefakt wird geprüft - also analytisch."},{"text":"Schulung der Entwickler vor Projektbeginn","bucket":0,"rationale":"Qualifikation ist eine klassische vorbeugende Maßnahme."},{"text":"Automatisierter Unit-Test in der Build-Pipeline","bucket":1,"rationale":"Tests finden vorhandene Fehler, sie verhindern sie nicht."},{"text":"Einsatz eines erprobten Frameworks statt Eigenentwicklung","bucket":0,"rationale":"Das Rad nicht neu erfinden heißt, dessen Fehler nicht neu zu machen."},{"text":"Abnahmetest durch den Auftraggeber","bucket":1,"rationale":"Prüfung des fertigen Produkts - analytisch."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'qm-004',
  'qualitaetsmanagement',
  'multiple',
  'Ein Team startet ein Projekt und legt seine Qualitätsziele fest.',
  'Welche Festlegungen gehören in die Qualitätsplanung?',
  'Qualitätsplanung beantwortet vier Fragen: Was wird gemessen? Welcher Zielwert gilt? Wann und wie wird geprüft? Wer ist verantwortlich?
Der häufigste Fehler in der Praxis ist, Qualitätsziele nur qualitativ zu formulieren ("hohe Performance"). Ohne Zahl ist das keine Planung, sondern ein Wunsch.',
  2,
  ARRAY['qualitätsplanung']::text[],
  null,
  '{"choices":[{"text":"Welche Qualitätsmerkmale gemessen werden und mit welchem Zielwert","is_correct":true,"rationale":"Ohne Zielwert ist später nicht entscheidbar, ob die Qualität erreicht wurde."},{"text":"Welche Prüfmaßnahmen wann durchgeführt werden","is_correct":true,"rationale":"Der Prüfplan legt fest, an welchen Punkten geprüft wird - sonst prüft am Ende niemand."},{"text":"Wer für die Qualitätssicherung verantwortlich ist","is_correct":true,"rationale":"Ohne benannte Verantwortung wird QS die Aufgabe, die jeder für die anderen für zuständig hält."},{"text":"Die konkrete Anzahl der zu erwartenden Fehler","is_correct":false,"rationale":"Falsch. Eine Fehlerzahl lässt sich nicht sinnvoll im Voraus festlegen. Man plant Maßnahmen und Schwellwerte, keine Fehlerquoten als Ziel."},{"text":"Die Definition of Done bzw. die Abnahmekriterien","is_correct":true,"rationale":"Die Festlegung, wann etwas fertig ist, ist der Kern der Qualitätsplanung."},{"text":"Der vollständige Quellcode der Testfälle","is_correct":false,"rationale":"Falsch. Testfälle entstehen später in der Umsetzung. Geplant wird, DASS und WIE getestet wird."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'te-001',
  'testen',
  'ordering',
  null,
  'Bringe die Teststufen in die Reihenfolge, in der sie üblicherweise durchlaufen werden.',
  'Die vier Teststufen bauen aufeinander auf: Je höher die Stufe, desto größer der Prüfgegenstand und desto näher am Kunden.
- Modultest: entwickelt meist der Programmierer selbst.
- Integrationstest: prüft Schnittstellen zwischen Komponenten.
- Systemtest: prüft das Gesamtsystem gegen die Spezifikation, in einer möglichst produktionsähnlichen Testumgebung.
- Abnahmetest: prüft gegen die Anforderungen des Auftraggebers, in dessen Verantwortung.
Systemtest und Abnahmetest werden gern verwechselt: der Systemtest ist Sache des Auftragnehmers, der Abnahmetest die des Auftraggebers.',
  2,
  ARRAY['teststufen']::text[],
  null,
  '{"ordered_items":["Modultest (Unittest) - einzelne Funktion oder Klasse","Integrationstest - Zusammenspiel mehrerer Komponenten","Systemtest - das komplette System in der Testumgebung","Abnahmetest - das System beim Auftraggeber"],"ordering_hint":"Vom kleinsten Prüfgegenstand zum größten"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'te-002',
  'testen',
  'matching',
  null,
  'Black-Box- oder White-Box-Test?',
  'Black-Box: Testfälle aus den Anforderungen, ohne Kenntnis des Codes. Typische Verfahren sind Äquivalenzklassenbildung und Grenzwertanalyse.
White-Box: Testfälle aus der Struktur des Codes, mit Überdeckungskriterien wie Anweisungs- oder Zweigabdeckung.
Faustregel für die Prüfung: Steht "kennt den Code nicht" oder "gegen die Anforderungen", ist es Black-Box. Steht "Zweig", "Pfad", "Coverage" oder "Schleifenlogik", ist es White-Box.',
  2,
  ARRAY['blackbox', 'whitebox']::text[],
  null,
  '{"buckets":["Black-Box","White-Box"],"match_items":[{"text":"Der Tester kennt den Quellcode nicht und prüft nur Eingabe und Ausgabe.","bucket":0,"rationale":"Genau die Definition: die innere Struktur bleibt eine schwarze Kiste."},{"text":"Die Testfälle werden so gewählt, dass jeder Programmzweig einmal durchlaufen wird.","bucket":1,"rationale":"Zweigabdeckung setzt Kenntnis des Codes voraus - also White-Box."},{"text":"Grundlage sind ausschließlich die Anforderungen aus dem Pflichtenheft.","bucket":0,"rationale":"Anforderungsbasiertes Testen ohne Blick in den Code."},{"text":"Der Entwickler prüft seine eigene Schleifenlogik mit Grenzwerten für den Zähler.","bucket":1,"rationale":"Die Logik im Inneren wird gezielt adressiert."},{"text":"Der Abnahmetest durch den Fachbereich.","bucket":0,"rationale":"Der Fachbereich testet fachlich gegen die Anforderungen, nicht gegen den Code."},{"text":"Code-Coverage wird als Kennzahl erhoben.","bucket":1,"rationale":"Überdeckungsmaße beziehen sich zwangsläufig auf den Quellcode."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'te-003',
  'testen',
  'multiple',
  null,
  'Was gehört in einen vollständigen Testfall?',
  'Ein Testfall besteht aus: Kennung, Vorbedingung, Eingabe, erwartetes Ergebnis - und nach der Durchführung zusätzlich dem tatsächlichen Ergebnis sowie dem Urteil bestanden/nicht bestanden. Erst das zusammen ergibt das Testprotokoll.
Der häufigste Fehler in Prüfungsaufgaben: das Soll-Ergebnis vergessen. Ein Test ohne Soll-Ergebnis kann nicht fehlschlagen und ist damit wertlos.',
  2,
  ARRAY['testfall', 'testprotokoll']::text[],
  null,
  '{"choices":[{"text":"Eindeutige Testfall-Nummer oder -Bezeichnung","is_correct":true,"rationale":"Ohne Kennung lässt sich ein Fehler später nicht dem Testfall zuordnen."},{"text":"Vorbedingung bzw. Ausgangszustand","is_correct":true,"rationale":"Ein Testfall ist nur reproduzierbar, wenn der Startzustand definiert ist."},{"text":"Konkrete Eingabedaten","is_correct":true,"rationale":"\"Irgendeine gültige Eingabe\" ist kein Testfall, sondern eine Absichtserklärung."},{"text":"Das erwartete Ergebnis (Soll-Ergebnis)","is_correct":true,"rationale":"Der wichtigste Teil. Ohne Soll-Ergebnis kann niemand entscheiden, ob der Test bestanden ist."},{"text":"Der Name des Entwicklers, der den Fehler verursacht hat","is_correct":false,"rationale":"Falsch - und schädlich. Testfälle dienen der Fehlersuche, nicht der Schuldzuweisung."},{"text":"Die geschätzte Dauer der Fehlerbehebung","is_correct":false,"rationale":"Falsch. Das ist eine Planungsgröße für die Korrektur, kein Bestandteil des Testfalls."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'te-004',
  'testen',
  'single',
  'Eine Entwicklerin geht einen fremden Algorithmus Zeile für Zeile auf Papier durch und notiert nach jeder Anweisung die aktuellen Variablenwerte.',
  'Wie heißt dieses Verfahren?',
  'Der Schreibtischtest (auch Trockentest oder Code-Walkthrough) ist ein statisches Verfahren: Der Code wird gelesen und nachvollzogen, nicht ausgeführt.
Praktisch geht man mit einer Wertetabelle vor - eine Spalte je Variable, eine Zeile je Durchlauf. Genau diese Tabelle verlangt die AP1 häufig als Lösung. Wer sie sauber führt, findet den Fehler fast von selbst; wer im Kopf rechnet, verrechnet sich.',
  2,
  ARRAY['schreibtischtest']::text[],
  null,
  '{"choices":[{"text":"Schreibtischtest","is_correct":true,"rationale":"Richtig. Der Code wird ohne Ausführung manuell nachvollzogen - im Katalog 2025 ausdrücklich genannt."},{"text":"Regressionstest","is_correct":false,"rationale":"Falsch. Ein Regressionstest prüft nach einer Änderung, ob bisher funktionierende Teile noch laufen."},{"text":"Integrationstest","is_correct":false,"rationale":"Falsch. Der Integrationstest prüft das Zusammenspiel mehrerer Komponenten, nicht eine einzelne Anweisungsfolge."},{"text":"Lasttest","is_correct":false,"rationale":"Falsch. Ein Lasttest prüft das Verhalten unter hoher Beanspruchung."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'te-005',
  'testen',
  'single',
  'Nach der Korrektur eines Fehlers im Rechnungsmodul funktioniert plötzlich der Export nicht mehr, der vorher lief.',
  'Welche Testart hätte das verhindern können?',
  'Regression heißt Rückschritt: Eine Änderung macht etwas kaputt, das vorher funktionierte. Der Regressionstest läuft deshalb nach JEDER Änderung und wiederholt die bisherigen Tests.
Genau deshalb lohnt sich Testautomatisierung: Manuell wiederholt niemand hundert Tests nach jedem Bugfix. Automatisiert kostet es Minuten.',
  3,
  ARRAY['regressionstest']::text[],
  null,
  '{"choices":[{"text":"Regressionstest","is_correct":true,"rationale":"Richtig. Der Regressionstest wiederholt bereits bestandene Tests, um genau solche Nebenwirkungen zu entdecken."},{"text":"Abnahmetest","is_correct":false,"rationale":"Der Abnahmetest findet am Ende beim Kunden statt - dann ist der Schaden schon da."},{"text":"Lasttest","is_correct":false,"rationale":"Ein Lasttest prüft Verhalten unter Last, nicht die fachliche Korrektheit nach Änderungen."},{"text":"Usability-Test","is_correct":false,"rationale":"Der prüft die Bedienbarkeit, nicht die Funktion."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  've-001',
  'vertraege',
  'matching',
  null,
  'Ordne die Beschreibung der passenden Vertragsart zu.',
  'Die Abgrenzung entscheidet sich an einer Frage: Wird ein ERFOLG geschuldet oder eine TÄTIGKEIT?
- Werkvertrag: Erfolg. Es gibt eine Abnahme, und erst danach wird gezahlt. Typisch für Individualsoftware und Projekte mit Festpreis.
- Dienstvertrag: Tätigkeit. Bezahlt wird nach Aufwand, es gibt keine Abnahme. Typisch für Beratung, Support und Zeitverträge.
- Kaufvertrag: Übereignung einer Sache, etwa Standardsoftware auf Datenträger oder Hardware.
Für die Prüfung wichtig: Die Bezeichnung im Vertrag entscheidet nicht - maßgeblich ist, was tatsächlich geschuldet wird.',
  2,
  ARRAY['vertragsarten']::text[],
  null,
  '{"buckets":["Kaufvertrag","Werkvertrag","Dienstvertrag"],"match_items":[{"text":"Geschuldet wird ein konkreter Erfolg, zum Beispiel eine fertige, abnahmefähige Software.","bucket":1,"rationale":"Erfolg geschuldet = Werkvertrag. Deshalb gibt es hier eine Abnahme."},{"text":"Geschuldet wird die Tätigkeit als solche, nicht ein bestimmtes Ergebnis.","bucket":2,"rationale":"Dienstvertrag: bezahlt wird die geleistete Arbeit, etwa bei Beratung oder Personalgestellung."},{"text":"Übereignung einer Sache gegen Zahlung des Kaufpreises.","bucket":0,"rationale":"Der klassische Kaufvertrag, zum Beispiel beim Hardwareeinkauf."},{"text":"Die Vergütung wird mit der Abnahme fällig.","bucket":1,"rationale":"Typisch für den Werkvertrag - ohne Abnahme keine Fälligkeit."},{"text":"Ein externer Administrator wird stundenweise für Support bereitgestellt.","bucket":2,"rationale":"Bereitgestellt wird Arbeitszeit, kein definiertes Werk."},{"text":"Gewährleistung richtet sich nach dem Zustand der gelieferten Sache bei Gefahrübergang.","bucket":0,"rationale":"Sachmangelhaftung des Kaufrechts."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  've-002',
  'vertraege',
  'multiple',
  null,
  'Welche Aussagen zu Softwarelizenzen sind richtig?',
  'Vier Begriffe sauber trennen:
- Freeware: kostenlos, Quellcode geschlossen.
- Open Source: Quellcode offen, oft mit Pflichten (Copyleft).
- Proprietär: kostenpflichtig, Quellcode geschlossen.
- SaaS/Abo: Nutzungsrecht auf Zeit, Betrieb beim Anbieter.
Lizenzmodelle nach Zählweise: pro Gerät, pro benanntem Nutzer, pro gleichzeitigem Nutzer (concurrent), pro CPU/Core, nutzungsabhängig.',
  2,
  ARRAY['lizenzen']::text[],
  null,
  '{"choices":[{"text":"Eine Einzelplatzlizenz berechtigt zur Installation auf einem bestimmten Arbeitsplatz.","is_correct":true,"rationale":"Die klassische Form - gebunden an ein Gerät oder einen benannten Nutzer."},{"text":"Bei einer Concurrent-User-Lizenz zählt die Zahl der gleichzeitigen Nutzer.","is_correct":true,"rationale":"Nicht die Zahl der installierten Kopien, sondern die gleichzeitige Nutzung ist begrenzt."},{"text":"Open-Source-Software darf immer kostenlos und uneingeschränkt kommerziell genutzt werden.","is_correct":false,"rationale":"Falsch. Open Source heißt offener Quellcode, nicht bedingungslos frei. Copyleft-Lizenzen wie die GPL verpflichten dazu, Änderungen unter derselben Lizenz weiterzugeben."},{"text":"Bei einem Software-Abonnement (SaaS) erwirbt man Nutzungsrechte auf Zeit, kein Eigentum.","is_correct":true,"rationale":"Läuft das Abo aus, endet das Nutzungsrecht - ein wesentlicher Unterschied zum Kauf."},{"text":"Eine Volumenlizenz ist immer günstiger als der Einzelkauf derselben Stückzahl.","is_correct":false,"rationale":"In der Regel ja, aber \"immer\" ist falsch. Volumenlizenzen haben Mindestabnahmen und Laufzeiten, die sich bei kleinen Stückzahlen nicht rechnen."},{"text":"Freeware ist kostenlos, der Quellcode ist aber nicht zwingend offen.","is_correct":true,"rationale":"Genau der Unterschied zu Open Source: kostenlos sagt nichts über den Quellcode."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  've-003',
  'vertraege',
  'single',
  'Eine Auszubildende entwickelt während ihrer Arbeitszeit ein Skript, das im Betrieb produktiv eingesetzt wird.',
  'Wie ist die urheberrechtliche Lage in Deutschland?',
  'Kern des deutschen Urheberrechts: Urheber ist immer die natürliche Person, die das Werk geschaffen hat. Dieses Recht kann man weder verkaufen noch verschenken - nur vererben.
Was übertragen wird, sind NUTZUNGSRECHTE: einfach (mehrere dürfen nutzen) oder ausschließlich (nur einer). Bei Software, die in Erfüllung des Arbeitsvertrags entsteht, erhält der Arbeitgeber die ausschließlichen Nutzungsrechte.',
  2,
  ARRAY['urheberrecht']::text[],
  null,
  '{"choices":[{"text":"Die Urheberin bleibt sie selbst, die Nutzungsrechte liegen aber beim Arbeitgeber.","is_correct":true,"rationale":"Richtig. Das Urheberrecht ist in Deutschland nicht übertragbar; übertragen werden nur Nutzungsrechte - bei Arbeitnehmern regelmäßig automatisch an den Arbeitgeber."},{"text":"Der Arbeitgeber wird automatisch Urheber der Software.","is_correct":false,"rationale":"Falsch. Urheber kann nur eine natürliche Person sein, und das Urheberrecht selbst ist nicht übertragbar."},{"text":"Die Auszubildende kann die Nutzung jederzeit untersagen.","is_correct":false,"rationale":"Falsch. Für im Arbeitsverhältnis geschaffene Software erwirbt der Arbeitgeber die Nutzungsrechte."},{"text":"Software ist urheberrechtlich nicht geschützt, nur patentierbar.","is_correct":false,"rationale":"Falsch. Computerprogramme sind ausdrücklich urheberrechtlich geschützt. Reine Software ist in Europa umgekehrt kaum patentierbar."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  've-004',
  'vertraege',
  'multiple',
  null,
  'Was sollte ein IT-Dienstleistungsvertrag mindestens regeln?',
  'Mindestinhalte: Vertragsparteien, Leistungsbeschreibung, Vergütung, Termine, Mitwirkungspflichten des Auftraggebers, Abnahme, Gewährleistung, Haftung, Datenschutz/Geheimhaltung, Laufzeit und Kündigung.
Die Mitwirkungspflichten werden am häufigsten vergessen und führen am häufigsten zu Streit: Wenn der Auftraggeber Testdaten oder Ansprechpartner nicht liefert, kann der Auftragnehmer den Termin nicht halten - ohne Regelung steht dann Aussage gegen Aussage.',
  1,
  ARRAY['vertragsbestandteile']::text[],
  null,
  '{"choices":[{"text":"Leistungsbeschreibung bzw. Verweis auf das Pflichtenheft","is_correct":true,"rationale":"Ohne beschriebene Leistung lässt sich später nicht feststellen, ob erfüllt wurde."},{"text":"Vergütung und Zahlungsbedingungen","is_correct":true,"rationale":"Höhe, Fälligkeit und Zahlungsziel gehören zwingend hinein."},{"text":"Termine und Fristen","is_correct":true,"rationale":"Ohne Termin gibt es keinen Verzug - und damit keine Handhabe bei Verspätung."},{"text":"Regelungen zu Gewährleistung und Haftung","is_correct":true,"rationale":"Legt fest, wer bei Mängeln und Schäden in welchem Umfang einsteht."},{"text":"Die Namen aller eingesetzten Entwickler","is_correct":false,"rationale":"Falsch. Das wäre unpraktikabel - Personal wechselt. Geregelt werden höchstens Qualifikationsanforderungen."},{"text":"Vereinbarungen zu Datenschutz und Vertraulichkeit","is_correct":true,"rationale":"Bei Zugriff auf personenbezogene Daten ist ein Auftragsverarbeitungsvertrag sogar Pflicht."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'sl-001',
  'sla_service',
  'multiple',
  null,
  'Was regelt ein Service Level Agreement (SLA)?',
  'Ein SLA macht Servicequalität messbar und einklagbar. Die vier Größen, die man auseinanderhalten muss:
- Servicezeit: wann der Service überhaupt erbracht wird (z. B. Mo-Fr 8-18 Uhr).
- Verfügbarkeit: Anteil der Servicezeit ohne Störung.
- Reaktionszeit: bis zur ersten qualifizierten Rückmeldung.
- Wiederherstellungszeit: bis die Störung behoben ist.
Typische Prüfungsfalle: "Reaktionszeit 1 Stunde" bedeutet NICHT, dass das Problem nach einer Stunde gelöst ist.',
  2,
  ARRAY['sla']::text[],
  null,
  '{"choices":[{"text":"Verfügbarkeit des Dienstes, meist als Prozentwert pro Zeitraum","is_correct":true,"rationale":"Die zentrale Kennzahl, zum Beispiel 99,5 % im Monat."},{"text":"Reaktionszeit - wie schnell auf eine Störung reagiert wird","is_correct":true,"rationale":"Reaktionszeit ist die Zeit bis zur ersten Rückmeldung, nicht bis zur Lösung."},{"text":"Wiederherstellungszeit - wie schnell die Störung behoben sein muss","is_correct":true,"rationale":"Die zweite Zeitgröße. Reaktions- und Wiederherstellungszeit werden ständig verwechselt."},{"text":"Servicezeiten, in denen die vereinbarten Werte gelten","is_correct":true,"rationale":"Ein SLA mit 15 Minuten Reaktionszeit ist wertlos, wenn unklar bleibt, ob das auch sonntags um 3 Uhr gilt."},{"text":"Den Quellcode der betriebenen Anwendung","is_correct":false,"rationale":"Falsch. Quellcode-Fragen regelt gegebenenfalls ein Hinterlegungsvertrag (Escrow), nicht das SLA."},{"text":"Folgen bei Nichteinhaltung, etwa Vergütungsminderung","is_correct":true,"rationale":"Ohne Konsequenz ist ein SLA eine Absichtserklärung."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'sl-002',
  'sla_service',
  'numeric',
  'Ein SLA sichert eine Verfügbarkeit von 99,5 % zu. Die vereinbarte Servicezeit beträgt 24 Stunden an 30 Tagen im Monat.',
  'Wie viele Minuten Ausfall sind in diesem Monat höchstens zulässig?',
  'Rechenweg:
1. Servicezeit im Monat = 30 Tage x 24 h x 60 min = 43.200 Minuten
2. Zulässige Ausfallquote = 100 % - 99,5 % = 0,5 % = 0,005
3. Erlaubter Ausfall = 43.200 x 0,005 = 216 Minuten (3,6 Stunden)

Merke die Größenordnungen - danach wird gern gefragt:
99 % = rund 7,2 Stunden Ausfall im Monat
99,5 % = rund 3,6 Stunden
99,9 % = rund 43 Minuten
Jede Neun kostet ungefähr den Faktor 10 an Aufwand.',
  3,
  ARRAY['verfügbarkeit']::text[],
  null,
  '{"answer":216.0,"tolerance":1.0,"unit":"Minuten"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'sl-003',
  'sla_service',
  'single',
  'Ein Anwender meldet, dass sein Drucker nicht mehr reagiert. Der Mitarbeiter am Telefon nimmt die Störung auf, prüft die Standardlösungen und kann sie nicht beheben.',
  'Was passiert als Nächstes im mehrstufigen Support?',
  'Die Supportstufen:
- 1st Level: Annahme, Klassifizierung, Lösung bekannter Standardfälle. Ziel ist eine hohe Erstlösungsquote.
- 2nd Level: Fachspezialisten mit tieferem Systemwissen.
- 3rd Level: Hersteller oder Entwicklung, bei Fehlern im Produkt selbst.
Wichtig für die Prüfung: Das Ticket bleibt beim Eskalieren bestehen und wandert mit seiner kompletten Historie. Der Anwender behält einen Ansprechpartner - das nennt sich Ownership-Prinzip.',
  2,
  ARRAY['support_level']::text[],
  null,
  '{"choices":[{"text":"Eskalation an den 2nd-Level-Support mit dokumentiertem Ticket","is_correct":true,"rationale":"Richtig. Der 1st Level nimmt auf, klassifiziert und löst Standardfälle; alles andere geht dokumentiert weiter nach oben."},{"text":"Das Ticket wird geschlossen, der Anwender meldet sich neu.","is_correct":false,"rationale":"Falsch. Ein ungelöstes Ticket wird nie geschlossen - der Vorgang und seine Historie müssen erhalten bleiben."},{"text":"Direkte Weitergabe an den Hersteller (3rd Level).","is_correct":false,"rationale":"Falsch. Die Stufen werden der Reihe nach durchlaufen. Der 3rd Level ist der Hersteller bzw. die Entwicklung und wird erst eingeschaltet, wenn der 2nd Level nicht weiterkommt."},{"text":"Der Anwender erhält Administratorrechte, um es selbst zu lösen.","is_correct":false,"rationale":"Falsch und sicherheitstechnisch fatal. Rechteausweitung ist keine Supportmaßnahme."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'ls-001',
  'leistungsstoerungen',
  'single',
  'Ein Lieferant hat eine Serverlieferung für den 1. Oktober fest zugesagt. Am 10. Oktober ist nichts geliefert.',
  'Welche Voraussetzung für Lieferverzug ist hier erfüllt?',
  'Verzug setzt voraus: fällige Leistung, Nichtleistung, Verschulden des Schuldners und grundsätzlich eine Mahnung.
Die Mahnung entfällt unter anderem, wenn ein Termin nach dem Kalender bestimmt ist ("Lieferung am 1. Oktober") oder wenn der Schuldner die Leistung ernsthaft und endgültig verweigert.
Beim ZAHLUNGSverzug gilt zusätzlich: Spätestens 30 Tage nach Zugang einer Rechnung tritt Verzug auch ohne Mahnung ein - bei Verbrauchern nur, wenn darauf hingewiesen wurde.',
  2,
  ARRAY['verzug']::text[],
  null,
  '{"choices":[{"text":"Die Leistung ist fällig und der Termin kalendermäßig bestimmt - es braucht keine Mahnung.","is_correct":true,"rationale":"Richtig. Bei einem kalendermäßig festgelegten Termin tritt Verzug automatisch mit Fristablauf ein."},{"text":"Verzug tritt erst ein, wenn der Kunde dreimal gemahnt hat.","is_correct":false,"rationale":"Falsch. Drei Mahnungen sind ein Mythos aus der Praxis, keine Rechtsvoraussetzung."},{"text":"Verzug setzt immer eine schriftliche Mahnung voraus.","is_correct":false,"rationale":"Falsch. Eine Mahnung ist nur nötig, wenn kein kalendermäßig bestimmter Termin vereinbart wurde."},{"text":"Verzug tritt automatisch 30 Tage nach Vertragsschluss ein.","is_correct":false,"rationale":"Die 30-Tage-Regel gilt für den Zahlungsverzug nach Rechnungszugang, nicht für Lieferverzug."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'ls-002',
  'leistungsstoerungen',
  'ordering',
  null,
  'In welcher Reihenfolge stehen dem Kunden die Mängelrechte beim Werkvertrag üblicherweise zu?',
  'Der Vorrang der Nacherfüllung ist das Grundprinzip: Der Auftragnehmer bekommt zuerst die Gelegenheit, selbst nachzubessern. Erst wenn das scheitert oder eine gesetzte Frist fruchtlos verstreicht, stehen die weiteren Rechte offen.
Praktische Konsequenz: Wer sofort mindert oder einen anderen Dienstleister beauftragt, ohne eine Frist zur Nacherfüllung zu setzen, verliert seine Ansprüche. Deshalb gehört in jede Mangelanzeige eine konkrete Frist.',
  3,
  ARRAY['mängelrechte']::text[],
  null,
  '{"ordered_items":["Nacherfüllung verlangen (Mangelbeseitigung oder Neuherstellung)","Nach erfolgloser Fristsetzung: Selbstvornahme und Ersatz der Kosten","Minderung der Vergütung oder Rücktritt vom Vertrag","Schadensersatz bzw. Ersatz vergeblicher Aufwendungen"],"ordering_hint":"Vom vorrangigen zum nachrangigen Recht"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'ls-003',
  'leistungsstoerungen',
  'multiple',
  null,
  'Was gehört in ein Abnahmeprotokoll?',
  'An der Abnahme hängen vier Rechtsfolgen: Fälligkeit der Vergütung, Gefahrübergang, Beginn der Verjährungsfrist für Mängelansprüche und die Umkehr der Beweislast - danach muss der Kunde beweisen, dass ein Mangel schon bei Abnahme vorlag.
Deshalb ist das Abnahmeprotokoll kein Formalkram, sondern der wichtigste Zettel im Projekt. Wer bekannte Mängel nicht protokolliert, verliert die Rechte darauf.',
  2,
  ARRAY['abnahmeprotokoll']::text[],
  null,
  '{"choices":[{"text":"Datum, Ort und die anwesenden Personen beider Seiten","is_correct":true,"rationale":"Ohne Beteiligte und Datum ist das Protokoll als Nachweis wertlos."},{"text":"Gegenstand der Abnahme mit Verweis auf das Pflichtenheft","is_correct":true,"rationale":"Abgenommen wird gegen ein definiertes Soll - der Verweis stellt das her."},{"text":"Liste der festgestellten Mängel mit Fristen zur Beseitigung","is_correct":true,"rationale":"Der wichtigste Teil. Nicht protokollierte Mängel gelten bei vorbehaltloser Abnahme als akzeptiert."},{"text":"Erklärung, ob die Abnahme erfolgt, unter Vorbehalt erfolgt oder verweigert wird","is_correct":true,"rationale":"Diese Erklärung ist der eigentliche Rechtsakt."},{"text":"Unterschriften beider Vertragsparteien","is_correct":true,"rationale":"Erst die Unterschriften machen das Protokoll zum Nachweis."},{"text":"Die interne Kalkulation des Auftragnehmers","is_correct":false,"rationale":"Falsch. Die Kalkulation ist ein Geschäftsgeheimnis des Auftragnehmers und hat im Protokoll nichts zu suchen."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'cm-001',
  'change_management',
  'ordering',
  null,
  'Bringe die drei Phasen des Lewin-Modells in die richtige Reihenfolge.',
  'Lewins Modell erklärt, warum Veränderungen scheitern: Meist wird die erste oder die letzte Phase übersprungen.
- Ohne "Unfreeze" fehlt die Einsicht, dass sich etwas ändern muss - die Betroffenen halten am Alten fest.
- Ohne "Refreeze" fällt die Organisation nach einigen Wochen in alte Gewohnheiten zurück, weil der neue Zustand nie verankert wurde.
In der Change-Phase sinkt die Leistung typischerweise vorübergehend ab - das ist normal und kein Zeichen des Scheiterns.',
  2,
  ARRAY['lewin']::text[],
  null,
  '{"ordered_items":["Unfreeze - Auftauen: Veränderungsbedarf verdeutlichen, Widerstände ansprechen","Change - Verändern: neue Abläufe einführen und begleiten","Refreeze - Einfrieren: den neuen Zustand stabilisieren und zum Standard machen"],"ordering_hint":"Von der Vorbereitung zur Verankerung"}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'cm-002',
  'change_management',
  'multiple',
  'Bei der Einführung eines neuen Ticketsystems weigern sich mehrere erfahrene Mitarbeitende, das System zu nutzen.',
  'Welche Maßnahmen sind geeignet, den Widerstand abzubauen?',
  'Widerstand ist kein Defekt der Mitarbeitenden, sondern eine Information: Er zeigt, dass Sinn, Können oder Beteiligung fehlen.
Die drei typischen Ursachen und ihre Gegenmittel:
- "Ich verstehe es nicht" -> informieren, Nutzen erklären.
- "Ich kann es nicht" -> schulen, begleiten.
- "Ich will es nicht" -> beteiligen, Bedenken ernst nehmen.
Anordnung und Sanktion sind das letzte Mittel, nicht das erste.',
  2,
  ARRAY['widerstand']::text[],
  null,
  '{"choices":[{"text":"Die Betroffenen frühzeitig einbeziehen und ihre Erfahrung in die Gestaltung einfließen lassen","is_correct":true,"rationale":"Beteiligung ist die wirksamste Maßnahme - wer mitgestaltet hat, blockiert selten."},{"text":"Den Nutzen für die tägliche Arbeit konkret und nachvollziehbar erklären","is_correct":true,"rationale":"Widerstand entsteht oft aus fehlendem Sinn, nicht aus Bequemlichkeit."},{"text":"Schulungen und eine Begleitung in der Umstellungsphase anbieten","is_correct":true,"rationale":"Ein Teil des Widerstands ist schlicht Unsicherheit im Umgang mit dem Neuen."},{"text":"Die Nutzung per Anweisung durchsetzen und Verstöße sanktionieren","is_correct":false,"rationale":"Falsch als erste Maßnahme. Druck erzeugt Scheinanpassung: Das System wird formal benutzt und die eigentliche Arbeit läuft weiter daneben."},{"text":"Erfahrene Mitarbeitende als Multiplikatoren gewinnen","is_correct":true,"rationale":"Wer die Skeptiker zu Vorbildern macht, dreht den Widerstand in Unterstützung."},{"text":"Das alte System sofort abschalten, um Ausweichen zu verhindern","is_correct":false,"rationale":"Falsch als alleinige Maßnahme. Ein harter Schnitt ohne Vorbereitung erzeugt Chaos und verfestigt die Ablehnung."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

insert into public.ap1_questions
  (id, topic_id, kind, scenario, prompt, explanation, difficulty, tags, source, data, catalog_status)
values (
  'cm-003',
  'change_management',
  'single',
  null,
  'Was kennzeichnet Kaizen bzw. den kontinuierlichen Verbesserungsprozess?',
  'Kaizen (japanisch: Veränderung zum Besseren) steht für den kontinuierlichen Verbesserungsprozess (KVP). Kernideen: kleine Schritte statt großer Sprünge, Beteiligung aller Mitarbeitenden, Standardisierung des Erreichten und Wiederholung.
Der Zusammenhang zum PDCA-Zyklus ist direkt: PDCA ist das Werkzeug, mit dem jeder einzelne Kaizen-Schritt durchlaufen wird.
Abgrenzung für die Prüfung: Kaizen = viele kleine Schritte, evolutionär. Reengineering = ein großer Schnitt, revolutionär.',
  2,
  ARRAY['kaizen']::text[],
  null,
  '{"choices":[{"text":"Laufende Verbesserung in vielen kleinen Schritten, getragen von allen Mitarbeitenden","is_correct":true,"rationale":"Richtig. Die Summe vieler kleiner Schritte, nicht der eine große Wurf."},{"text":"Einmalige, grundlegende Neugestaltung der Geschäftsprozesse","is_correct":false,"rationale":"Das ist Business Process Reengineering - der radikale Gegenentwurf zu Kaizen."},{"text":"Verbesserung ausschließlich durch die Führungsebene","is_correct":false,"rationale":"Falsch. Kaizen lebt davon, dass Verbesserungsvorschläge von denen kommen, die die Arbeit täglich machen."},{"text":"Ein Verfahren zur Fehlersuche im Quellcode","is_correct":false,"rationale":"Falsch. Kaizen ist eine Haltung zur Prozessverbesserung, kein Testverfahren."}]}'::jsonb,
  'current'
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
  catalog_status = excluded.catalog_status,
  is_active = true;

-- Karteikarten ----------------------------------------------
insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-01', 'projektorganisation', 'Projekt (DIN 69901)', 'Vorhaben mit Einmaligkeit der Bedingungen, zeitlicher/finanzieller/personeller Begrenzung, eigener Organisation und Abgrenzung gegenüber anderen Vorhaben.', 'Vier Haken: einmalig, begrenzt, eigene Organisation, abgegrenzt. Keine Mindestgröße, kein Mindestbudget.', '{}', 0)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-02', 'projektorganisation', 'Magisches Dreieck', 'Zeit, Kosten und Leistung/Qualität. Sind zwei Größen fixiert, ist die dritte die abhängige Variable.', 'In Prüfungsaufgaben steht die Lösung in der Angabe: Welche zwei Ecken werden als fest beschrieben?', '{}', 1)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-03', 'projektorganisation', 'SMART-Ziele', 'Spezifisch, Messbar, Attraktiv (akzeptiert), Realistisch, Terminiert.', 'Neu im Katalog 2025. "Die Software soll besser werden" ist kein SMARTes Ziel - es fehlt alles außer S.', '{}', 2)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-04', 'projektorganisation', 'Reine Projektorganisation', 'Das Team wird vollständig aus der Linie herausgelöst. Die Projektleitung hat fachliche UND disziplinarische Weisungsbefugnis.', 'Viel Macht, viel Aufwand - und nach Projektende ein Rückkehrproblem.', '{}', 3)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-05', 'projektorganisation', 'Matrix-Organisation', 'Weisungsbefugnis geteilt: fachlich beim Projekt, disziplinarisch in der Linie.', 'Der Normalfall - und die Dauerquelle von Prioritätenkonflikten, weil jeder zwei Chefs hat.', '{}', 4)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-06', 'projektorganisation', 'Stabs-/Einflussorganisation', 'Die Projektleitung koordiniert und berichtet, hat aber kein Weisungsrecht.', 'Billig und zahnlos - das Gegenstück zur reinen Projektorganisation.', '{}', 5)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-07', 'projektorganisation', 'Stakeholder', 'Alle Personen und Gruppen, die vom Projekt betroffen sind oder es beeinflussen können - intern wie extern.', 'Betriebsrat, Kunden, Lieferanten, Fachabteilungen, Behörden.', '{}', 6)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-08', 'projektorganisation', 'Stakeholder-Matrix: hoher Einfluss, geringes Interesse', 'Strategie "zufriedenstellen": regelmäßig informieren, aber nicht mit Details überfrachten.', 'Das unintuitivste Feld - und deshalb das am häufigsten gefragte.', '{}', 7)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-09', 'projektorganisation', 'Stakeholder-Matrix: die vier Felder', 'Einfluss+Interesse hoch = eng einbinden. Einfluss hoch/Interesse niedrig = zufriedenstellen. Einfluss niedrig/Interesse hoch = informieren. Beides niedrig = beobachten.', null, '{}', 8)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-10', 'projektorganisation', 'Projektauftrag', 'Die Geburtsurkunde des Projekts: Ziel, Nicht-Ziele, Termin- und Budgetrahmen, benannte Projektleitung mit Befugnissen, Abnahmekriterien.', 'Kein Netzplan und keine Architektur - das ist Detailplanung und kommt danach.', '{}', 9)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-11', 'projektorganisation', 'Nicht-Ziele im Projektauftrag', 'Ausdrückliche Festlegung, was NICHT zum Projektumfang gehört.', 'Der billigste Schutz gegen Scope Creep - und der am häufigsten vergessene Abschnitt.', '{}', 10)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-12', 'projektorganisation', 'Kick-off-Meeting', 'Startveranstaltung eines Projekts: Ziele, Rollen, Vorgehen und Spielregeln werden allen Beteiligten gemeinsam vorgestellt.', 'Zweck ist gemeinsames Verständnis, nicht Detailplanung.', '{}', 11)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-13', 'projektorganisation', 'Meilenstein', 'Ereignis mit der Dauer null, an dem ein definiertes Zwischenergebnis vorliegt. Verbraucht weder Zeit noch Ressourcen.', 'Binär prüfbar formulieren: "Pflichtenheft unterzeichnet", nicht "Konzept weitgehend fertig".', '{}', 12)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-14', 'projektorganisation', 'Lenkungsausschuss', 'Entscheidungsgremium oberhalb der Projektleitung: gibt Budget frei, entscheidet über Change Requests und Eskalationen.', 'In Scrum nicht vorgesehen - dort entscheidet der Product Owner über Inhalte.', '{}', 13)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-org-15', 'projektorganisation', 'Aufgaben der Projektleitung', 'Planen, steuern, kontrollieren, Team führen, Stakeholder informieren, Risiken managen, Abweichungen melden.', 'Nicht: selbst programmieren. Die Projektleitung verantwortet das Wie-Viel und Wann, nicht die Umsetzung.', '{}', 14)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-01', 'vorgehensmodelle', 'Vorgehensmodelle im Katalog 2025', 'Nur noch Wasserfallmodell und Scrum. V-Modell, Spiralmodell, XP und Kanban sind gestrichen.', 'Wer noch V-Modell paukt, lernt an der AP1 vorbei.', '{}', 15)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-02', 'vorgehensmodelle', 'Wasserfallmodell', 'Streng sequenzielles Vorgehen: jede Phase endet mit einem freigegebenen Dokument, erst dann startet die nächste.', 'Voraussetzung: Anforderungen sind zu Projektbeginn vollständig bekannt.', '{}', 16)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-03', 'vorgehensmodelle', 'Phasen des Wasserfallmodells', 'Analyse/Anforderungsdefinition, Entwurf, Implementierung, Test, Einführung und Wartung.', null, '{}', 17)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-04', 'vorgehensmodelle', 'Rule of Ten', 'Die Kosten der Fehlerbehebung verzehnfachen sich mit jeder Phase, in der der Fehler unentdeckt bleibt.', 'Analyse 1 Euro, Entwurf 10, Implementierung 100, beim Kunden 1.000.', '{}', 18)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-05', 'vorgehensmodelle', 'Größter Nachteil des Wasserfalls', 'Fehler aus der Analyse fallen erst im Test auf - dann müssen alle darauf aufbauenden Phasen korrigiert werden.', null, '{}', 19)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-06', 'vorgehensmodelle', 'Vorteile des Wasserfalls', 'Klare Struktur, gute Planbarkeit, feste Kosten und Termine, einfache Fortschrittskontrolle, vollständige Dokumentation.', null, '{}', 20)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-07', 'vorgehensmodelle', 'Wann Wasserfall, wann agil?', 'Anforderungen stabil und vertraglich fixiert -> Wasserfall. Anforderungen unklar oder veränderlich -> agil.', 'Öffentliche Ausschreibung = Wasserfall. Produktentwicklung mit unklarem Zielbild = Scrum.', '{}', 21)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-08', 'vorgehensmodelle', 'Phasenmodell (4 Phasen)', 'Initiierung, Planung, Durchführung/Steuerung, Abschluss.', 'Gilt modellunabhängig für jedes Projekt - auch für ein agiles.', '{}', 22)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-09', 'vorgehensmodelle', 'Iterativ-inkrementell', 'Iterativ = in wiederholten Durchläufen verfeinern. Inkrementell = in auslieferbaren Teilstücken wachsen.', 'Scrum ist beides. Der Unterschied wird gern verwechselt.', '{}', 23)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-10', 'vorgehensmodelle', 'Agiles Manifest: die vier Werte', 'Individuen und Interaktionen MEHR ALS Prozesse und Werkzeuge; funktionierende Software MEHR ALS umfassende Dokumentation; Zusammenarbeit mit dem Kunden MEHR ALS Vertragsverhandlung; Reagieren auf Veränderung MEHR ALS Befolgen eines Plans.', '"Mehr als", nicht "statt". Agil heißt nicht dokumentationsfrei - das ist der häufigste Prüfungsfehler.', '{}', 24)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-11', 'vorgehensmodelle', 'Lastenheft im Wasserfall', 'Entsteht in der Analysephase und ist Grundlage der Ausschreibung. Danach folgt das Pflichtenheft des Auftragnehmers.', null, '{}', 25)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-vor-12', 'vorgehensmodelle', 'Warum Phasen mit Dokumenten enden', 'Das Dokument ist das prüfbare Ergebnis und die Freigabegrundlage. Ohne Freigabe kein Phasenübergang - so entsteht Verbindlichkeit.', null, '{}', 26)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-01', 'agil_scrum', 'Scrum: die drei Verantwortlichkeiten', 'Product Owner, Scrum Master, Developers.', 'Product Owner = WAS und in welcher Reihenfolge. Developers = WIE und wie viel. Scrum Master = DASS es funktioniert.', '{}', 27)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-02', 'agil_scrum', 'Product Owner', 'Verantwortet die Wertmaximierung des Produkts und die Reihenfolge im Product Backlog. Entscheidet allein über die Priorisierung.', 'Darf sich beraten lassen - aber niemand priorisiert gegen ihn.', '{}', 28)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-03', 'agil_scrum', 'Scrum Master', 'Verantwortet die Wirksamkeit von Scrum: moderiert Events, räumt Hindernisse weg, coacht Team und Organisation.', 'Kein Projektleiter, kein Vorgesetzter, priorisiert nichts.', '{}', 29)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-04', 'agil_scrum', 'Developers', 'Erstellen das Increment. Entscheiden, WIE gearbeitet wird und wie viel in den Sprint passt.', null, '{}', 30)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-05', 'agil_scrum', 'Die drei Scrum-Artefakte', 'Product Backlog, Sprint Backlog, Increment.', null, '{}', 31)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-06', 'agil_scrum', 'Commitments der Artefakte', 'Product Backlog -> Product Goal. Sprint Backlog -> Sprint Goal. Increment -> Definition of Done.', 'Wird gern gefragt, weil viele die DoD fälschlich dem Sprint Backlog zuordnen.', '{}', 32)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-07', 'agil_scrum', 'Die fünf Scrum-Events', 'Sprint (Container), Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective.', 'Refinement ist KEIN Event, sondern eine laufende Tätigkeit.', '{}', 33)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-08', 'agil_scrum', 'Timeboxen bei einem Monatssprint', 'Sprint Planning max. 8 h, Daily Scrum 15 min, Sprint Review max. 4 h, Retrospective max. 3 h.', 'Merkhilfe 8-4-3 und das Daily als Konstante - es bleibt immer 15 Minuten.', '{}', 34)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-09', 'agil_scrum', 'Review vs. Retrospective', 'Review = das Produkt, mit Stakeholdern. Retrospective = die Zusammenarbeit, nur das Scrum Team. Das Review kommt zuerst.', null, '{}', 35)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-10', 'agil_scrum', 'Definition of Done', 'Teamweit gültige Checkliste, wann ein Increment wirklich fertig und potenziell auslieferbar ist.', 'Gilt für JEDE Story. Nicht verwechseln mit Akzeptanzkriterien, die pro Story gelten.', '{}', 36)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-11', 'agil_scrum', 'Akzeptanzkriterien', 'Fachliche, prüfbare Bedingungen einer einzelnen User Story.', 'Story-spezifisch. Die Definition of Done ist handwerklich und teamweit - beides muss erfüllt sein.', '{}', 37)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-12', 'agil_scrum', 'User-Story-Format', 'Als <Rolle> möchte ich <Ziel>, um <Nutzen>.', 'Der "um ... zu"-Teil ist der wichtigste - und der am häufigsten weggelassene.', '{}', 38)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-13', 'agil_scrum', 'INVEST', 'Independent, Negotiable, Valuable, Estimable, Small, Testable - Qualitätscheck für User Stories.', null, '{}', 39)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-14', 'agil_scrum', 'Story Points', 'Relative Aufwandsschätzung statt Stunden. Menschen vergleichen zuverlässiger, als sie absolute Zeiten schätzen.', null, '{}', 40)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-15', 'agil_scrum', 'Velocity', 'Durchschnittlich pro Sprint abgeschlossene Story Points. Nur fertige (DoD erfüllte) Items zählen.', 'Restaufwand / Velocity = verbleibende Sprints, immer aufgerundet.', '{}', 41)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-scr-16', 'agil_scrum', 'Epic', 'Eine User Story, die zu groß für einen Sprint ist. Wird im Refinement in kleinere Stories geteilt.', null, '{}', 42)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-01', 'netzplan', 'FAZ', 'Frühester Anfangszeitpunkt = größter FEZ aller Vorgänger. Startvorgang: 0.', 'Vorwärts immer das MAXIMUM - der Vorgang startet erst, wenn der letzte Vorgänger fertig ist.', '{}', 43)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-02', 'netzplan', 'FEZ', 'Frühester Endzeitpunkt = FAZ + Dauer.', null, '{}', 44)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-03', 'netzplan', 'SEZ', 'Spätester Endzeitpunkt = kleinster SAZ aller Nachfolger. Endvorgang: SEZ = Projektdauer.', 'Rückwärts immer das MINIMUM.', '{}', 45)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-04', 'netzplan', 'SAZ', 'Spätester Anfangszeitpunkt = SEZ - Dauer.', null, '{}', 46)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-05', 'netzplan', 'Gesamtpuffer GP', 'GP = SAZ - FAZ = SEZ - FEZ. Zeit, um die ein Vorgang verschoben werden kann, ohne das Projektende zu gefährden.', 'Stimmen beide Formeln nicht überein, steckt ein Rechenfehler in der Rückwärtsrechnung.', '{}', 47)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-06', 'netzplan', 'Freier Puffer FP', 'FP = kleinster FAZ der Nachfolger - eigener FEZ. Verschiebung, ohne den frühesten Start des Nachfolgers anzutasten.', 'GP schaut aufs Projektende, FP schaut auf den Nachbarn. Es gilt immer FP <= GP.', '{}', 48)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-07', 'netzplan', 'Kritischer Pfad', 'Der längste Weg durch den Netzplan. Alle Vorgänge darauf haben Gesamtpuffer 0.', 'Verzögerung dort schlägt eins zu eins aufs Projektende durch.', '{}', 49)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-08', 'netzplan', 'Kann es mehrere kritische Pfade geben?', 'Ja. Mehrere gleich lange Wege sind alle kritisch - das Projekt ist dann besonders anfällig.', null, '{}', 50)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-09', 'netzplan', 'Projektdauer im Netzplan', 'Der größte FEZ im gesamten Plan - gleichbedeutend mit der Länge des kritischen Pfads.', null, '{}', 51)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-10', 'netzplan', 'Reihenfolge der Netzplanrechnung', 'Erst komplett vorwärts (FAZ/FEZ), dann komplett rückwärts (SEZ/SAZ), dann die Puffer. Nie mischen.', null, '{}', 52)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-11', 'netzplan', 'GP > 0 und FP = 0 - was heißt das?', 'Der Vorgang hat Luft bis zum Projektende, nimmt sie aber vollständig dem Nachfolger weg.', 'Der Lieblingsfall der Prüfer, weil er den Unterschied der Puffer erzwingt.', '{}', 53)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-12', 'netzplan', 'Vorgangsknoten-Netzplan (MPM)', 'Vorgänge stehen in den Knoten, Pfeile zeigen die Abhängigkeiten. Das in der AP1 übliche Verfahren.', null, '{}', 54)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-13', 'netzplan', 'Vorgang auf dem kritischen Pfad verkürzen', 'Verkürzt das Projekt - aber nur so lange, bis ein anderer Weg kritisch wird. Danach verpufft die Verkürzung.', 'Nach jedem Schritt neu rechnen: der kritische Pfad wandert.', '{}', 55)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-14', 'netzplan', 'Wo Ressourcen hingehören', 'Zuerst auf den kritischen Pfad. Vorgänge mit hohem Puffer können warten oder Personal abgeben.', null, '{}', 56)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-np-15', 'netzplan', 'Netzplan vs. Balkenplan', 'Netzplan = Rechenmodell, macht Puffer und kritischen Pfad berechenbar. Balkenplan = Kommunikationsmittel, maßstabsgetreu und ohne Erklärung lesbar.', 'Mit dem Netzplan rechnen, mit dem Gantt reden.', '{}', 57)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-01', 'terminplanung', 'Projektstrukturplan (PSP)', 'Zerlegung des Projekts in Teilprojekte, Arbeitspakete und Vorgänge - die Grundlage jeder weiteren Planung.', 'Beantwortet das WAS, noch nicht das WANN.', '{}', 58)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-02', 'terminplanung', 'Arbeitspaket', 'Kleinste Einheit des PSP: klar abgrenzbar, einer Person zuordenbar, mit eigenem Ergebnis, Aufwand und Termin.', null, '{}', 59)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-03', 'terminplanung', 'Gantt-Diagramm', 'Balkenplan mit maßstabsgetreuer Zeitachse. Auf einen Blick lesbar, zeigt Abhängigkeiten und Puffer aber nicht direkt.', null, '{}', 60)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-04', 'terminplanung', 'Meilensteintrendanalyse (MTA)', 'Trägt die geplanten Meilensteintermine über die Berichtszeitpunkte auf.', 'Waagerecht = im Plan. Steigend = Verzug. Fallend = früher fertig. Zickzack = unsichere Planung.', '{}', 61)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-05', 'terminplanung', 'Steigende MTA-Linie', 'Der Meilenstein verschiebt sich immer weiter nach hinten - Verzug.', 'Wird oft falsch herum gelesen. Steigend = später, nicht früher.', '{}', 62)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-06', 'terminplanung', 'Personentag vs. Arbeitstag', 'Personentag = Aufwand (wie viel Arbeit). Arbeitstag = Dauer (wie lange es dauert).', 'Die beiden zu verwechseln kostet in der Klausur sofort Punkte.', '{}', 63)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-07', 'terminplanung', 'Dauer aus Aufwand berechnen', 'Dauer = Aufwand / (Anzahl Personen x Verfügbarkeitsgrad).', '120 PT bei 4 Leuten zu 75 % sind nicht 30, sondern 40 Tage.', '{}', 64)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-08', 'terminplanung', 'Verfügbarkeitsgrad', 'Anteil der Arbeitszeit, der tatsächlich dem Projekt zur Verfügung steht - der Rest geht in Linie, Support, Urlaub.', 'In Prüfungsaufgaben fast immer der eigentliche Prüfpunkt.', '{}', 65)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-09', 'terminplanung', 'Brooks Law', 'Zusätzliches Personal in einem verspäteten Projekt verzögert es zunächst weiter - Einarbeitung und Kommunikation kosten Zeit.', null, '{}', 66)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-10', 'terminplanung', 'Vorwärts- vs. Rückwärtsterminierung', 'Vorwärts: vom Starttermin aus rechnen, Ergebnis ist das frühestmögliche Ende. Rückwärts: vom Endtermin aus rechnen, Ergebnis ist der spätestmögliche Start.', null, '{}', 67)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-11', 'terminplanung', 'Pufferzeit sinnvoll einsetzen', 'Puffer werden berechnet, nicht erfunden. Eine zusätzliche Sicherheitsreserve ist etwas anderes als der Puffer aus dem Netzplan.', null, '{}', 68)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-12', 'terminplanung', 'Ressourcenhistogramm', 'Stellt die Auslastung einer Ressource über die Zeit dar - macht Überlastspitzen sichtbar.', null, '{}', 69)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-13', 'terminplanung', 'Gut formulierter Meilenstein', 'Binär prüfbar: erreicht oder nicht. "Abnahmeprotokoll unterzeichnet" statt "Testphase fast fertig".', null, '{}', 70)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-tp-14', 'terminplanung', 'Soll-Ist-Vergleich', 'Gegenüberstellung von geplanten und tatsächlichen Werten bei Terminen, Kosten und Leistung - Grundlage jeder Steuerung.', null, '{}', 71)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-01', 'risikomanagement', 'Risikowert (Erwartungswert)', 'Risikowert = Eintrittswahrscheinlichkeit x Schadenshöhe.', '20 % x 80.000 Euro = 16.000 Euro. Das ist zugleich die Obergrenze für sinnvolle Gegenmaßnahmen.', '{}', 72)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-02', 'risikomanagement', 'Die vier Risikostrategien', 'Vermeiden, Vermindern, Überwälzen, Akzeptieren.', null, '{}', 73)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-03', 'risikomanagement', 'Risiko vermeiden', 'Die Ursache wird beseitigt, das Risiko kann danach nicht mehr eintreten.', 'Beispiel: auf eine unausgereifte Technologie verzichten.', '{}', 74)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-04', 'risikomanagement', 'Risiko vermindern', 'Eintrittswahrscheinlichkeit oder Auswirkung werden reduziert - das Risiko bleibt aber bestehen.', 'Testfrage: Kann es danach noch eintreten? Ja -> vermindert. Nein -> vermieden.', '{}', 75)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-05', 'risikomanagement', 'Risiko überwälzen', 'Ein Dritter trägt das Risiko: Versicherung, Festpreisvertrag, Auslagerung an einen Dienstleister.', null, '{}', 76)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-06', 'risikomanagement', 'Risiko akzeptieren', 'Das Restrisiko wird bewusst getragen und dokumentiert - legitim bei kleinem Schadenspotenzial.', 'Entscheidend ist "bewusst und dokumentiert", nicht "ignoriert".', '{}', 77)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-07', 'risikomanagement', 'Risikomatrix', 'Portfolio aus Eintrittswahrscheinlichkeit und Auswirkung. Je weiter rechts oben, desto dringender.', null, '{}', 78)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-08', 'risikomanagement', 'Schwäche der Risikomatrix', 'Sie behandelt "oft, aber harmlos" und "selten, aber katastrophal" gleich, wenn das Produkt gleich ist.', 'Deshalb gibt es Backups, obwohl Totalausfälle selten sind.', '{}', 79)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-09', 'risikomanagement', 'Existenzbedrohendes Risiko', 'Muss unabhängig von der Wahrscheinlichkeit behandelt werden - ein Schaden, den man nicht überlebt, darf nicht eintreten.', null, '{}', 80)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-10', 'risikomanagement', 'Risikoregister', 'Verzeichnis aller identifizierten Risiken mit Bewertung, Maßnahme und verantwortlicher Person.', 'Hinein gehören ALLE identifizierten Risiken - erst die Bewertung entscheidet über Maßnahmen.', '{}', 81)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-11', 'risikomanagement', 'Restrisiko', 'Das Risiko, das nach allen Maßnahmen übrig bleibt. Es wird bewusst getragen und dokumentiert.', null, '{}', 82)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-12', 'risikomanagement', 'Schritte des Risikomanagements', 'Identifizieren, bewerten, Maßnahmen festlegen, überwachen - laufend, nicht einmalig zu Projektbeginn.', null, '{}', 83)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ri-13', 'risikomanagement', 'Risiko vs. Problem', 'Ein Risiko kann eintreten (Zukunft, Wahrscheinlichkeit). Ein Problem ist bereits eingetreten (Gegenwart, Maßnahme nötig).', null, '{}', 84)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-01', 'pm_wirtschaftlichkeit', 'Nutzwertanalyse', 'Vergleicht Alternativen anhand gewichteter, auch nicht-monetärer Kriterien. Teilnutzwert = Gewicht x Bewertung, Summe = Gesamtnutzwert.', 'Gewichte müssen zusammen 100 % ergeben. Kriterien VOR dem Blick auf die Angebote festlegen.', '{}', 85)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-02', 'pm_wirtschaftlichkeit', 'Schwäche der Nutzwertanalyse', 'Gewichtung und Bewertung sind subjektiv - wer das Wunschergebnis kennt, kann es über die Gewichte herbeiführen.', null, '{}', 86)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-03', 'pm_wirtschaftlichkeit', 'Amortisationsdauer', 'Investitionssumme / jährlicher Netto-Rückfluss.', 'Netto heißt: Einsparung minus neue laufende Kosten.', '{}', 87)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-04', 'pm_wirtschaftlichkeit', 'Bezugskalkulation', 'Listeneinkaufspreis - Rabatt = Zieleinkaufspreis; - Skonto = Bareinkaufspreis; + Bezugskosten = Bezugspreis.', 'Skonto nie vom Listenpreis. Bezugskosten nie vor dem Skonto - auf Fracht gibt es kein Skonto.', '{}', 88)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-05', 'pm_wirtschaftlichkeit', 'TCO', 'Total Cost of Ownership: alle Kosten über den gesamten Lebenszyklus - Anschaffung, Betrieb, Wartung, Schulung, Außerbetriebnahme.', 'Nur Kosten, keine Erträge. Erträge gehören in die ROI-Rechnung.', '{}', 89)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-06', 'pm_wirtschaftlichkeit', 'Break-Even-Point', 'Die Absatzmenge, bei der Erlöse und Gesamtkosten gleich sind. Menge = Fixkosten / (Preis - variable Stückkosten).', 'Der Nenner heißt Deckungsbeitrag pro Stück.', '{}', 90)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-07', 'pm_wirtschaftlichkeit', 'Deckungsbeitrag', 'Preis minus variable Kosten. Der Betrag, der zur Deckung der Fixkosten beiträgt.', null, '{}', 91)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-08', 'pm_wirtschaftlichkeit', 'Fixkosten vs. variable Kosten', 'Fixkosten fallen unabhängig von der Menge an (Miete, Gehälter). Variable Kosten wachsen mit der Menge (Material, Lizenzen pro Nutzer).', null, '{}', 92)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-09', 'pm_wirtschaftlichkeit', 'Make-or-Buy', 'Entscheidung zwischen Eigenfertigung und Fremdbezug - anhand von Kosten, Know-how, Kapazität, Abhängigkeit und strategischer Bedeutung.', 'Nicht nur rechnen: Kern-Know-how gibt man nicht aus der Hand, auch wenn extern billiger wäre.', '{}', 93)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-10', 'pm_wirtschaftlichkeit', 'Effektivität vs. Effizienz', 'Effektivität = die richtigen Dinge tun (Wirksamkeit). Effizienz = die Dinge richtig tun (Wirtschaftlichkeit).', 'Effektiv ohne effizient ist teuer. Effizient ohne effektiv ist sinnlos.', '{}', 94)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-11', 'pm_wirtschaftlichkeit', 'Stundensatz berechnen', '(Personalkosten + anteilige Gemeinkosten + Gewinnaufschlag) / produktive Stunden.', 'Produktive Stunden, nicht Anwesenheitsstunden - Urlaub, Krankheit und interne Zeiten gehen ab.', '{}', 95)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-12', 'pm_wirtschaftlichkeit', 'Vor- und Nachkalkulation', 'Vorkalkulation schätzt vor dem Projekt, Nachkalkulation vergleicht danach Ist mit Soll.', 'Ohne Nachkalkulation schätzt man beim nächsten Mal genauso falsch.', '{}', 96)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-13', 'pm_wirtschaftlichkeit', 'Machbarkeitsanalyse', 'Prüft vor Projektstart technische, wirtschaftliche, rechtliche, organisatorische und terminliche Realisierbarkeit.', null, '{}', 97)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-14', 'pm_wirtschaftlichkeit', 'Wirtschaftlichkeit', 'Verhältnis von Ertrag zu Aufwand. Ein Projekt ist wirtschaftlich, wenn der Nutzen die Kosten übersteigt.', null, '{}', 98)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-wi-15', 'pm_wirtschaftlichkeit', 'Gemeinkosten', 'Kosten, die sich einem einzelnen Projekt nicht direkt zurechnen lassen (Miete, Verwaltung, IT). Sie werden über Zuschlagssätze verteilt.', null, '{}', 99)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-01', 'projektabschluss', 'Die drei Ebenen des Projektabschlusses', 'Sachlich-technisch (Abnahme, Übergabe), kaufmännisch (Schlussrechnung, Nachkalkulation), personell (Teamauflösung, Würdigung).', 'Die personelle Ebene wird am häufigsten vergessen - und ist die, an die sich das Team am längsten erinnert.', '{}', 100)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-02', 'projektabschluss', 'Lessons Learned', 'Systematische Sicherung der Erfahrungen, damit künftige Projekte davon profitieren.', 'Zeitnah, ohne Schuldzuweisung, dokumentiert an einem auffindbaren Ort - sonst wertlos.', '{}', 101)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-03', 'projektabschluss', 'Reihenfolge beim Abschluss', 'Restarbeiten, Abnahme, Übergabe an den Betrieb, Abschlussbericht, Lessons Learned, Teamauflösung.', 'Abnahme VOR Übergabe. Teamauflösung ZULETZT - vorher braucht man die Leute noch.', '{}', 102)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-04', 'projektabschluss', 'Inhalt des Projektabschlussberichts', 'Soll-Ist-Vergleich von Terminen, Kosten und Leistung, Zielerreichungsgrad, offene Punkte und Restrisiken, Lessons Learned, Übergabe.', 'Nicht der Quellcode - der gehört in die Versionsverwaltung, der Bericht verweist darauf.', '{}', 103)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-05', 'projektabschluss', 'Zielerreichungsgrad', 'Gemessen wird gegen den Projektauftrag - nicht gegen das, was unterwegs daraus geworden ist.', null, '{}', 104)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-06', 'projektabschluss', 'Übergabe an den Betrieb', 'Benannte Verantwortliche, Betriebsdokumentation, Schulung und vereinbarter Support. Sonst bleibt das Projektteam ewig zuständig.', null, '{}', 105)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-07', 'projektabschluss', 'Nachkalkulation', 'Gegenüberstellung der geplanten und tatsächlichen Kosten nach Projektende - Grundlage besserer Schätzungen.', null, '{}', 106)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-08', 'projektabschluss', 'Warum Lessons Learned ohne Schuldzuweisung', 'Sobald Schuldzuweisungen drohen, sagt niemand mehr, was wirklich schieflief - und die Sitzung ist wertlos.', null, '{}', 107)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-09', 'projektabschluss', 'Projektabschluss trotz Abbruch', 'Auch ein abgebrochenes Projekt wird formal abgeschlossen: Ergebnisse sichern, Kosten abrechnen, Erfahrungen dokumentieren.', null, '{}', 108)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-10', 'projektabschluss', 'Restarbeiten', 'Offene Punkte, die den Projektabschluss nicht verhindern, aber benannt und jemandem übergeben werden müssen.', null, '{}', 109)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-11', 'projektabschluss', 'Teamauflösung', 'Rückführung in die Linie, Feedback und Würdigung der Leistung - erst nach Bericht und Lessons Learned.', null, '{}', 110)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.ap1_flashcards
  (id, topic_id, front, back, hint, tags, sort_order)
values ('c-ab-12', 'projektabschluss', 'Projektdokumentation zum Abschluss', 'Zusammenführung aller Ergebnisdokumente an einem Ort, damit Betrieb und Folgeprojekte darauf zugreifen können.', null, '{}', 111)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  front = excluded.front,
  back = excluded.back,
  hint = excluded.hint,
  tags = excluded.tags,
  sort_order = excluded.sort_order,
  is_active = true;

-- Theorie-Snacks --------------------------------------------
insert into public.ap1_theory
  (id, topic_id, title, lead, points, merksatz, read_seconds, sort_order)
values ('th-org-1', 'projektorganisation', 'Was ein Projekt zum Projekt macht', 'Die DIN 69901 definiert vier Merkmale. Fehlt eines davon, ist es Tagesgeschäft - egal wie aufwendig es sich anfühlt.', ARRAY['Einmaligkeit der Bedingungen in ihrer Gesamtheit', 'Zielvorgabe mit zeitlicher, finanzieller und personeller Begrenzung', 'Eigene, projektspezifische Organisation', 'Abgrenzung gegenüber anderen Vorhaben', 'Nicht enthalten: eine Mindestgröße oder ein Mindestbudget']::text[], 'Einmalig, begrenzt, eigene Organisation, abgegrenzt - vier Haken, sonst kein Projekt.', 45, 0)
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
values ('th-org-2', 'projektorganisation', 'Drei Organisationsformen in einer Minute', 'Die Frage ist immer dieselbe: Wie viel Macht hat die Projektleitung gegenüber der Linie?', ARRAY['Reine Projektorganisation: Team komplett aus der Linie gelöst, Projektleitung hat volle Weisungsbefugnis. Schnell, aber teuer und nach Projektende gibt es ein Rückkehrproblem.', 'Matrix: Weisungsbefugnis geteilt - fachlich beim Projekt, disziplinarisch in der Linie. Flexibel, aber Dauerkonflikt um Prioritäten.', 'Stabs-/Einflussorganisation: Projektleitung koordiniert nur, ohne Weisungsrecht. Billig, aber zahnlos.']::text[], 'Viel Macht = viel Aufwand. Die Matrix ist der Kompromiss - und deshalb der Normalfall.', 45, 1)
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
values ('th-vor-1', 'vorgehensmodelle', 'Vorgehensmodelle im Katalog 2025', 'Der Prüfungskatalog ab 2025 kennt nur noch zwei Vorgehensmodelle: Wasserfall und Scrum. V-Modell, Spiralmodell, XP und Kanban sind gestrichen.', ARRAY['Wasserfall: streng sequenziell, jede Phase endet mit einem freigegebenen Dokument. Voraussetzung: Anforderungen sind zu Projektbeginn vollständig bekannt.', 'Phasen: Analyse, Entwurf, Implementierung, Test, Einführung und Wartung.', 'Stärke: klare Struktur, gute Planbarkeit, feste Kosten und Termine.', 'Schwäche: Fehler aus der Analyse fallen erst im Test auf. Rule of Ten - jede spätere Phase verzehnfacht die Korrekturkosten.', 'Scrum als Gegenentwurf: kurze Zyklen, Anforderungen dürfen sich zwischen den Sprints ändern.', 'Entscheidungsregel: Anforderungen stabil und vertraglich fix -> Wasserfall. Anforderungen unklar oder veränderlich -> Scrum.']::text[], 'Für die AP1 ab 2025 reichen zwei Modelle. Wer noch V-Modell und Spirale paukt, lernt an der Prüfung vorbei.', 45, 2)
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
values ('th-scr-1', 'agil_scrum', 'Scrum auf einer Karte', 'Drei Verantwortlichkeiten, drei Artefakte, fünf Events. Mehr steht nicht im Scrum Guide.', ARRAY['Verantwortlichkeiten: Product Owner (WAS und Reihenfolge), Developers (WIE und wie viel), Scrum Master (DASS es funktioniert).', 'Artefakte mit Commitment: Product Backlog -> Product Goal, Sprint Backlog -> Sprint Goal, Increment -> Definition of Done.', 'Events: Sprint (Container), Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective. Refinement ist KEIN Event, sondern eine laufende Tätigkeit.', 'Timeboxen bei Monatssprint: Planning 8 h, Daily 15 min, Review 4 h, Retrospektive 3 h.']::text[], 'Review = Produkt, mit Stakeholdern. Retrospektive = Zusammenarbeit, nur das Team. Review kommt zuerst.', 45, 3)
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
values ('th-np-1', 'netzplan', 'Netzplan: die sechs Werte', 'Erst alles vorwärts, dann alles rückwärts, dann die Puffer. In dieser Reihenfolge, nie gemischt.', ARRAY['Vorwärts: FAZ = größter FEZ aller Vorgänger (Start: 0). FEZ = FAZ + Dauer.', 'Projektdauer = größter FEZ im gesamten Plan.', 'Rückwärts: SEZ = kleinster SAZ aller Nachfolger (Endvorgang: SEZ = Projektdauer). SAZ = SEZ - Dauer.', 'Gesamtpuffer GP = SAZ - FAZ = SEZ - FEZ.', 'Freier Puffer FP = kleinster FAZ der Nachfolger - eigener FEZ.', 'Kritischer Pfad = alle Vorgänge mit GP = 0, zugleich der längste Weg.']::text[], 'Vorwärts das MAXIMUM, rückwärts das MINIMUM. Wer das vertauscht, rechnet den halben Plan falsch.', 45, 4)
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
values ('th-np-2', 'netzplan', 'GP oder FP? Der Unterschied in 20 Sekunden', 'Beide Puffer sagen, wie viel Luft ein Vorgang hat - aber bis wohin, ist verschieden.', ARRAY['Gesamtpuffer: Verschiebung ohne das PROJEKTENDE zu gefährden. Kann aber den Nachfolger nach hinten drücken.', 'Freier Puffer: Verschiebung ohne den frühesten Start des NACHFOLGERS anzutasten. Merkt sonst niemand.', 'Es gilt immer FP <= GP.', 'Auf dem kritischen Pfad sind beide null.', 'Typischer Fall: GP = 2, FP = 0. Luft bis zum Projektende vorhanden - aber nur, indem man sie dem Nachfolger wegnimmt.']::text[], 'GP schaut aufs Projektende, FP schaut auf den Nachbarn.', 45, 5)
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
values ('th-tp-1', 'terminplanung', 'Gantt, Meilenstein, MTA', 'Mit dem Netzplan rechnet man, mit dem Balkenplan redet man.', ARRAY['Gantt/Balkenplan: maßstabsgetreue Zeitachse, auf einen Blick lesbar. Abhängigkeiten und Puffer sind aber nicht direkt ablesbar.', 'Meilenstein: Ereignis mit Dauer null, an dem ein definiertes Zwischenergebnis vorliegt. Binär prüfbar formulieren.', 'Meilensteintrendanalyse: geplante Termine über Berichtszeitpunkte auftragen. Waagerecht = im Plan, steigend = Verzug, fallend = früher fertig, Zickzack = unsichere Planung.', 'Dauer = Aufwand / (Anzahl Personen x Verfügbarkeitsgrad). Personentage sind Aufwand, Arbeitstage sind Dauer.']::text[], 'Steigende MTA-Linie heißt später, nicht früher. Das wird am häufigsten verwechselt.', 45, 6)
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
values ('th-lh-1', 'anforderungen', 'Lastenheft vs. Pflichtenheft', 'Zwei Dokumente, zwei Absender, zwei Zeitpunkte.', ARRAY['Lastenheft: vom AUFTRAGGEBER, beschreibt das WAS und WOFÜR, lösungsneutral. Grundlage der Ausschreibung.', 'Pflichtenheft: vom AUFTRAGNEHMER, beschreibt das WIE und WOMIT. Entsteht NACH der Vergabe und wird vom Auftraggeber genehmigt.', 'Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft.', 'Funktional = "Das System tut X". Nicht-funktional = "Das System tut X schnell/sicher/verfügbar/barrierefrei".', 'Gute Anforderung: eindeutig, vollständig, widerspruchsfrei, prüfbar, notwendig, priorisiert (MuSCoW).']::text[], 'LAstenheft = Auftraggeber verteilt die Last. PFlichtenheft = Auftragnehmer nennt seine Pflicht.', 45, 7)
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
values ('th-wi-1', 'pm_wirtschaftlichkeit', 'Rechnen im PM-Teil', 'Vier Rechnungen decken den Großteil der Punkte ab.', ARRAY['Nutzwertanalyse: je Kriterium Gewicht x Bewertung, dann summieren. Gewichte müssen 100 % ergeben.', 'Amortisation: Investitionssumme / jährlicher Netto-Rückfluss.', 'Bezugskalkulation: Listenpreis - Rabatt = Zieleinkaufspreis; - Skonto = Bareinkaufspreis; + Bezugskosten = Bezugspreis. Skonto nie vom Listenpreis, Bezugskosten nie vor dem Skonto.', 'Risikowert = Eintrittswahrscheinlichkeit x Schadenshöhe.', 'TCO = nur Kosten über den gesamten Lebenszyklus. Erträge gehören in die ROI-Rechnung.']::text[], 'Bei Prozentaufgaben immer fragen: Prozent WOVON? Das ist der häufigste Punktverlust.', 45, 8)
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
values ('th-qr-1', 'qualitaetsmanagement', 'Qualität und Risiko', 'Zwei Sortierungen, die fast jede Aufgabe abdecken.', ARRAY['Konstruktive QS = vorher, verhindert Fehler: Standards, Templates, Werkzeuge, Schulung, Frameworks.', 'Analytische QS = nachher, findet Fehler: Test, Review, Inspektion, statische Analyse, Audit.', 'Risikostrategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit oder Auswirkung runter), Überwälzen (Versicherung, Festpreis), Akzeptieren (bewusst und dokumentiert).', 'Testfrage Vermeiden vs. Vermindern: Kann das Risiko danach noch eintreten? Ja -> vermindert. Nein -> vermieden.']::text[], 'Test findet Fehler, Standard verhindert sie. Das ist die ganze Unterscheidung.', 45, 9)
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
values ('th-ab-1', 'projektabschluss', 'Projektabschluss richtig', 'Drei Ebenen - die dritte wird am häufigsten vergessen.', ARRAY['Sachlich-technisch: Restarbeiten, Abnahme mit Protokoll, Übergabe an den Betrieb.', 'Kaufmännisch: Schlussrechnung, Nachkalkulation, Projekt buchhalterisch schließen.', 'Personell: Team auflösen, Rückführung in die Linie, Würdigung der Leistung.', 'Lessons Learned: zeitnah, ohne Schuldzuweisung, dokumentiert an einem auffindbaren Ort.', 'Reihenfolge: Abnahme vor Übergabe, Teamauflösung zuletzt.']::text[], 'Wer das Team vor dem Abschlussbericht auflöst, bekommt keinen brauchbaren Bericht.', 45, 10)
on conflict (id) do update set
  topic_id = excluded.topic_id,
  title = excluded.title,
  lead = excluded.lead,
  points = excluded.points,
  merksatz = excluded.merksatz,
  read_seconds = excluded.read_seconds,
  sort_order = excluded.sort_order;

-- Kontrolle:
--   select count(*) from public.ap1_questions where catalog_status = 'current';
-- erwartet: 7 Bereiche, 35 Themen, 65 aktive Aufgaben (68 gesamt), 112 Karten, 11 Theorie-Snacks.
