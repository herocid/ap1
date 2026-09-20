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
  ('a02', '02', 'Kundenbeziehungen & Kommunikation', 'Gespraechsfuehrung, Team, Verhandlung, Praesentation, Markt', 0.130, 1),
  ('a03', '03', 'Informations- & Softwaresysteme', 'Hardware, Betriebssysteme, Anwendungssysteme, Netzwerke', 0.180, 2),
  ('a04', '04', 'Analyse & Entwicklung von Systemen', 'Anforderungen, UML, Programmierlogik, Web, Daten, KI', 0.220, 3),
  ('a05', '05', 'Qualitaetssicherung', 'QS-Massnahmen, PDCA, Testverfahren und Testprotokolle', 0.070, 4),
  ('a06', '06', 'IT-Sicherheit & Datenschutz', 'Schutzziele, Massnahmen, Kryptographie, DSGVO', 0.120, 5),
  ('a07', '07', 'Vertragsmanagement & Service', 'Vertragsarten, SLA, Leistungsstoerungen, Change Management', 0.060, 6)
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
  ('projektabschluss', 'a01', 'Projektabschluss', 'Abnahme, Abschlussbericht, Lessons Learned, Uebergabe', 0.015, 7),
  ('kommunikation', 'a02', 'Kommunikation & Kundenkontakt', 'Kommunikationsmodelle, adressatengerecht beraten, Ticketsysteme', 0.035, 8),
  ('teamarbeit', 'a02', 'Teamarbeit & Zusammenarbeit', 'Tuckman-Phasen, Feedback, Fehlerkultur, Diversity, Konflikte', 0.025, 9),
  ('verhandlung', 'a02', 'Verhandeln', 'Harvard-Konzept, Win-win, Einwandbehandlung', 0.020, 10),
  ('praesentation', 'a02', 'Praesentieren & Beraten', 'Argumentation, Praesentationstechnik, Quellen, Angebotserstellung', 0.020, 11),
  ('markt_marketing', 'a02', 'Markt, Bedarf & Marketing', 'Marktformen, Bedarfsermittlung, AIDA, ABC-Analyse, Rechtsformen', 0.030, 12),
  ('hardware', 'a03', 'Hardware & Arbeitsplatz', 'CPU, RAM, HDD vs. SSD, Peripherie, USV, Green IT, Ergonomie', 0.040, 13),
  ('betriebssysteme', 'a03', 'Betriebssysteme', 'Prozesse, Dateisysteme, Rechte, Kommandozeile, Haertung', 0.040, 14),
  ('anwendungssysteme', 'a03', 'Anwendungs- & Softwaresysteme', 'ERP, SCM, CRM, Social Media, Lizenzmodelle, Standard vs. Individual', 0.040, 15),
  ('netzwerke', 'a03', 'Netzwerke & Cloud', 'OSI, IPv4/IPv6, Subnetting, Protokolle, Virtualisierung, Container', 0.060, 16),
  ('anforderungen', 'a04', 'Anforderungen, Lasten- & Pflichtenheft', 'Anforderungsarten, Erhebung, Abgrenzung, Abnahmekriterien', 0.035, 17),
  ('uml_modellierung', 'a04', 'UML & Modellierung', 'Use-Case-, Klassen- und Aktivitaetsdiagramm', 0.030, 18),
  ('programmierlogik', 'a04', 'Programmierlogik', 'Datentypen, Kontrollstrukturen, Pseudocode, Schreibtischtest', 0.035, 19),
  ('objektorientierung', 'a04', 'Objektorientierung', 'Klasse, Objekt, Attribut, Methode, Kapselung', 0.020, 20),
  ('datenmodellierung', 'a04', 'Datenmodellierung', 'ER-Modell, Beziehungen, Schluessel, Normalisierung', 0.025, 21),
  ('web_internet', 'a04', 'Web & Internet', 'URL, HTTP, Ablauf eines Seitenaufrufs, HTML/CSS, Barrierefreiheit', 0.030, 22),
  ('multimedia_daten', 'a04', 'Daten & Multimedia', 'Zeichensaetze, Kompression, Datenmengen und Uebertragungsraten', 0.025, 23),
  ('ki_grundlagen', 'a04', 'KI-Unterstuetzung', 'Einsatzfelder, Grenzen, Halluzinationen, Datenschutz bei KI', 0.020, 24),
  ('qualitaetsmanagement', 'a05', 'Qualitaetsmanagement', 'Konstruktive und analytische QS, PDCA, Qualitaetsplanung', 0.030, 25),
  ('testen', 'a05', 'Testverfahren', 'Teststufen, Black-/White-Box, Testfaelle, Testprotokoll', 0.040, 26),
  ('schutzziele_bedrohungen', 'a06', 'Schutzziele & Bedrohungen', 'Vertraulichkeit, Integritaet, Verfuegbarkeit, Angriffsarten, BSI', 0.035, 27),
  ('sicherheitsmassnahmen', 'a06', 'Technische Schutzmassnahmen', 'Firewall, DMZ, Haertung, WLAN-Sicherheit, Backup, Berechtigungen', 0.030, 28),
  ('kryptographie_auth', 'a06', 'Kryptographie & Authentifizierung', 'Symmetrisch/asymmetrisch, Hashverfahren, Zertifikate, 2FA', 0.025, 29),
  ('datenschutz', 'a06', 'Datenschutz & DSGVO', 'Grundsaetze, Betroffenenrechte, Anonymisierung, Pseudonymisierung', 0.030, 30),
  ('vertraege', 'a07', 'Vertraege & Recht', 'Kauf-, Werk-, Dienstvertrag, Lizenzen, Urheberrecht', 0.020, 31),
  ('sla_service', 'a07', 'Service & SLA', 'Service Level Agreements, Support-Level, Eskalation, ITIL', 0.015, 32),
  ('leistungsstoerungen', 'a07', 'Leistungsstoerungen & Abnahme', 'Verzug, Maengel, Gewaehrleistung, Abnahmeprotokoll, Soll-Ist', 0.015, 33),
  ('change_management', 'a07', 'Change Management', 'Lewin-Modell, Kaizen, Widerstaende, Change-Prozess', 0.010, 34)
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
  'Welche Merkmale muessen nach DIN 69901 erfuellt sein, damit ein Vorhaben als Projekt gilt?',
  'Merksatz: E-Z-O-A - Einmaligkeit, Zielvorgabe mit Begrenzung, eigene Organisation, Abgrenzung. Groesse und Budget sind bewusst nicht Teil der Definition; sonst waere jede Norm laendes- und branchenabhaengig.',
  1,
  ARRAY['din69901', 'projektbegriff']::text[],
  null,
  '{"choices":[{"text":"Einmaligkeit der Bedingungen in ihrer Gesamtheit","is_correct":true,"rationale":"Kernmerkmal. Ein Vorhaben, das jeden Monat identisch ablaeuft, ist Tagesgeschaeft - kein Projekt."},{"text":"Zeitliche, finanzielle und personelle Begrenzung","is_correct":true,"rationale":"Ein Projekt hat einen definierten Anfang und ein definiertes Ende sowie ein festes Budget."},{"text":"Eine eigene, projektspezifische Organisation","is_correct":true,"rationale":"Projektleitung, Team und Entscheidungswege werden eigens fuer das Vorhaben festgelegt."},{"text":"Mindestens fuenf beteiligte Mitarbeitende","is_correct":false,"rationale":"Falsch. Die DIN nennt keine Mindestgroesse. Auch ein Zwei-Personen-Vorhaben kann ein Projekt sein."},{"text":"Ein Budget von mindestens 50.000 Euro","is_correct":false,"rationale":"Falsch. Es gibt keine Wertgrenze in der Norm. Unternehmen setzen intern manchmal Schwellen - das ist aber keine Definition."},{"text":"Abgrenzung gegenueber anderen Vorhaben","is_correct":true,"rationale":"Das Projekt muss inhaltlich und organisatorisch klar von der Linie und von anderen Projekten trennbar sein."}]}'::jsonb,
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
  'Faustregel fuer die Pruefung: Je mehr Macht die Projektleitung hat, desto teurer und stoerender ist die Organisationsform fuer die Linie. Rein = viel Macht, hoher Aufwand. Stab = wenig Macht, wenig Aufwand. Matrix liegt dazwischen und wird am haeufigsten gewaehlt.',
  2,
  ARRAY['aufbauorganisation']::text[],
  null,
  '{"buckets":["Reine Projektorganisation","Matrix-Organisation","Stabs-/Einflussorganisation"],"match_items":[{"text":"Mitarbeitende werden vollstaendig aus der Linie herausgeloest.","bucket":0,"rationale":"Genau das ist das Kennzeichen der reinen (autonomen) Projektorganisation."},{"text":"Die Projektleitung hat volle fachliche und disziplinarische Weisungsbefugnis.","bucket":0,"rationale":"Nur hier ist die Weisungsbefugnis ungeteilt."},{"text":"Weisungsbefugnis ist zwischen Linien- und Projektleitung geteilt.","bucket":1,"rationale":"Der typische Kompromiss - und die typische Konfliktquelle der Matrix."},{"text":"Hohes Konfliktpotenzial durch zwei Vorgesetzte pro Person.","bucket":1,"rationale":"Das klassische Matrix-Problem: zwei Chefs, widerspruechliche Prioritaeten."},{"text":"Die Projektleitung koordiniert nur und kann keine Anweisungen geben.","bucket":2,"rationale":"Die Stabsstelle berichtet und koordiniert, entscheidet aber nicht."},{"text":"Geringster organisatorischer Aufwand, dafuer schwache Durchsetzungskraft.","bucket":2,"rationale":"Vorteil und Nachteil der Einflussorganisation in einem Satz."}]}'::jsonb,
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
  '{"choices":[{"text":"Zufriedenstellen - regelmaessig informieren, aber nicht ueberfrachten","is_correct":true,"rationale":"Richtig. Hoher Einfluss + geringes Interesse = \"keep satisfied\". Die Gruppe kann das Projekt kippen, will aber keine Detailflut."},{"text":"Eng einbinden - in alle Entscheidungen einbeziehen","is_correct":false,"rationale":"Das gilt fuer hohen Einfluss UND hohes Interesse. Hier wuerde es den Betriebsrat mit Details ueberfordern und Widerstand erzeugen."},{"text":"Beobachten - minimaler Aufwand","is_correct":false,"rationale":"Das gilt nur bei geringem Einfluss UND geringem Interesse. Wer den Betriebsrat so behandelt, erlebt spaetestens bei der Mitbestimmung eine Vollbremsung."},{"text":"Informieren - ausfuehrlich ueber Fortschritte berichten","is_correct":false,"rationale":"Das ist die Strategie fuer geringen Einfluss und hohes Interesse, z. B. interessierte Fachanwender."}]}'::jsonb,
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
  'Welche Angaben gehoeren zwingend in einen Projektauftrag?',
  'Der Projektauftrag ist die Geburtsurkunde des Projekts: Ziel, Nicht-Ziel, Rahmen (Zeit/Budget), Verantwortliche. Alles, was Detailplanung ist (Netzplan, Architektur, Arbeitspakete), kommt danach.',
  2,
  ARRAY['projektauftrag']::text[],
  null,
  '{"choices":[{"text":"Projektziel und messbare Abnahmekriterien","is_correct":true,"rationale":"Ohne messbares Ziel ist spaeter nicht entscheidbar, ob das Projekt erfolgreich war."},{"text":"Benannte Projektleitung mit Befugnissen","is_correct":true,"rationale":"Der Auftrag legitimiert die Projektleitung - sonst hat sie im Unternehmen keinen Stand."},{"text":"Budget- und Terminrahmen","is_correct":true,"rationale":"Die beiden Eckpunkte des magischen Dreiecks neben dem Leistungsumfang."},{"text":"Vollstaendige technische Systemarchitektur","is_correct":false,"rationale":"Falsch. Die Architektur entsteht erst in der Planungs-/Entwurfsphase. Im Auftrag steht das WAS, nicht das WIE."},{"text":"Nicht-Ziele bzw. Abgrenzung des Projektumfangs","is_correct":true,"rationale":"Oft unterschaetzt: Was ausdruecklich NICHT Teil des Projekts ist, verhindert spaeteren Scope Creep."},{"text":"Der fertige Netzplan aller Vorgaenge","is_correct":false,"rationale":"Falsch. Der Netzplan ist ein Ergebnis der Planungsphase, nicht Voraussetzung des Auftrags."}]}'::jsonb,
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
  'Zwei Wochen vor dem Releasetermin faellt auf, dass ein Modul mehr Aufwand braucht als geplant. Der Termin ist vertraglich fixiert, zusaetzliches Budget gibt es nicht.',
  'Welche Konsequenz ergibt sich zwangslaeufig aus dem magischen Dreieck?',
  'Magisches Dreieck: Zeit, Kosten, Leistung/Qualitaet. Sind zwei Groessen fixiert, ist die dritte die abhaengige Variable. In Pruefungsaufgaben steht die Loesung immer in der Aufgabenstellung: schau, welche zwei Ecken als "fest" beschrieben sind.',
  3,
  ARRAY['magisches_dreieck']::text[],
  null,
  '{"choices":[{"text":"Der Leistungsumfang muss reduziert werden.","is_correct":true,"rationale":"Richtig. Zeit und Kosten sind fixiert - im Dreieck bleibt nur die dritte Groesse, der Umfang (Qualitaet/Leistung), als Stellhebel."},{"text":"Die Qualitaetssicherung kann entfallen, ohne den Umfang zu aendern.","is_correct":false,"rationale":"Das ist keine neutrale Option: QS zu streichen ist selbst eine Reduzierung der Qualitaet - also ebenfalls eine Aenderung der dritten Groesse, nur eine besonders teure."},{"text":"Mehr Personal loest das Problem ohne Nebenwirkung.","is_correct":false,"rationale":"Erstens kostet mehr Personal Budget (das es nicht gibt), zweitens gilt Brooks Law: zusaetzliche Leute in einem spaeten Projekt verzoegern es zunaechst weiter."},{"text":"Das Projekt muss abgebrochen werden.","is_correct":false,"rationale":"Ein Abbruch ist eine mögliche Managemententscheidung, aber nicht die zwangslaeufige Folge des Dreiecks. Gefragt war die logische Konsequenz."}]}'::jsonb,
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
  'Das Wasserfallmodell laeuft streng sequenziell: jede Phase endet mit einem freigegebenen Dokument, erst dann startet die naechste. Das ist zugleich sein groesster Nachteil - Fehler aus der Analyse fallen erst im Test auf, und dann ist die Korrektur am teuersten.',
  1,
  ARRAY['wasserfall']::text[],
  null,
  '{"ordered_items":["Analyse / Anforderungsdefinition","Entwurf (Design)","Implementierung","Test / Verifikation","Einfuehrung und Wartung"],"ordering_hint":"Von der ersten zur letzten Phase"}'::jsonb,
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
  '{"choices":[{"text":"Abnahmetest","is_correct":true,"rationale":"Richtig. Die oberste linke Ebene (Anforderungen des Auftraggebers) wird gegen die oberste rechte Ebene (Abnahmetest durch den Auftraggeber) geprueft."},{"text":"Modultest","is_correct":false,"rationale":"Der Modul-/Unittest liegt auf der untersten Ebene und prueft gegen die Modulspezifikation bzw. den Feinentwurf."},{"text":"Integrationstest","is_correct":false,"rationale":"Der Integrationstest gehoert zum Grobentwurf/Architektur - er prueft das Zusammenspiel der Komponenten."},{"text":"Systemtest","is_correct":false,"rationale":"Der Systemtest gehoert zur Systemspezifikation, also eine Ebene unterhalb der Anforderungsdefinition. Er prueft in der Testumgebung, der Abnahmetest beim Kunden."}]}'::jsonb,
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
  'Fuer die Pruefung reicht je ein Erkennungsmerkmal pro Modell: Wasserfall = sequenziell, V-Modell = Teststufen-Paare, Spiralmodell = Risikoanalyse pro Zyklus, Scrum = Inkremente in festen Sprints.',
  2,
  ARRAY['modellvergleich']::text[],
  null,
  '{"buckets":["Wasserfall","V-Modell","Spiralmodell","Scrum"],"match_items":[{"text":"Streng sequenziell, jede Phase endet mit einem Dokument.","bucket":0,"rationale":"Das Grundprinzip des Wasserfalls."},{"text":"Jeder Entwicklungsstufe ist eine passende Teststufe zugeordnet.","bucket":1,"rationale":"Das ist genau die Erweiterung, die das V-Modell gegenueber dem Wasserfall bringt."},{"text":"Wiederholte Zyklen mit expliziter Risikoanalyse zu Beginn jedes Zyklus.","bucket":2,"rationale":"Die Risikoanalyse pro Zyklus ist das Markenzeichen des Spiralmodells nach Boehm."},{"text":"Lieferung eines nutzbaren Inkrements am Ende jedes Sprints.","bucket":3,"rationale":"Das Increment ist ein Scrum-Artefakt; es muss die Definition of Done erfuellen."},{"text":"Anforderungen muessen zu Projektbeginn vollstaendig bekannt sein.","bucket":0,"rationale":"Die zentrale Voraussetzung - und Schwaeche - des Wasserfalls."},{"text":"Priorisierung der Arbeit erfolgt fortlaufend durch eine Rolle mit Produktverantwortung.","bucket":3,"rationale":"Der Product Owner verantwortet die Reihenfolge im Product Backlog."}]}'::jsonb,
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
  'Ein Kunde moechte eine Web-Anwendung, hat aber nur eine grobe Vorstellung vom Funktionsumfang und erwartet, dass sich die Anforderungen waehrend der Entwicklung noch aendern.',
  'Welche Argumente sprechen hier fuer ein agiles Vorgehen?',
  'Entscheidungsregel: Sind die Anforderungen stabil und der Umfang vertraglich fix (z. B. Ausschreibung der oeffentlichen Hand), ist klassisch richtig. Sind sie unklar oder veraenderlich, ist agil richtig. Der haeufigste Fehler in der Pruefung ist die Behauptung, agil brauche keine Dokumentation.',
  2,
  ARRAY['agil_vs_klassisch']::text[],
  null,
  '{"choices":[{"text":"Anforderungen koennen zwischen den Iterationen angepasst werden.","is_correct":true,"rationale":"Genau der Fall aus dem Szenario: unklare, veraenderliche Anforderungen sind das Kernargument fuer agil."},{"text":"Der Kunde sieht nach jeder Iteration lauffaehige Software.","is_correct":true,"rationale":"Frueher Feedback-Zyklus. Fehlannahmen fallen nach Wochen auf, nicht nach Monaten."},{"text":"Das Projektbudget laesst sich von Anfang an exakt festschreiben.","is_correct":false,"rationale":"Falsch - das ist eine Staerke des klassischen Vorgehens. Agil arbeitet eher mit festem Budget und variablem Umfang."},{"text":"Der Dokumentationsaufwand entfaellt vollstaendig.","is_correct":false,"rationale":"Falsch. Das agile Manifest sagt \"funktionierende Software MEHR ALS umfassende Dokumentation\" - nicht \"statt\". Dokumentation wird reduziert, nicht abgeschafft."},{"text":"Das Risiko einer kompletten Fehlentwicklung sinkt.","is_correct":true,"rationale":"Durch kurze Zyklen und regelmaessige Abnahme kann man maximal eine Iteration in die falsche Richtung laufen."},{"text":"Ein vollstaendiges Pflichtenheft ist zu Projektbeginn erforderlich.","is_correct":false,"rationale":"Falsch, das ist klassisches Vorgehen. Agil startet mit einem priorisierten Backlog, das sich weiterentwickelt."}]}'::jsonb,
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
  'Rule of Ten: Ein Fehler, der in der Analyse 1 Euro kostet, kostet im Entwurf 10, in der Implementierung 100 und beim Kunden 1.000 Euro. Genau dagegen arbeiten V-Modell (frueh definierte Tests) und agile Modelle (kurze Feedback-Schleifen).',
  3,
  ARRAY['wasserfall', 'fehlerkosten']::text[],
  null,
  '{"choices":[{"text":"Weil sie erst in der Testphase auffallen und dann alle darauf aufbauenden Phasen korrigiert werden muessen.","is_correct":true,"rationale":"Richtig. Der Aufwand zur Fehlerbehebung steigt mit jeder Phase etwa um den Faktor 10 (Rule of Ten)."},{"text":"Weil die Analysephase das teuerste Personal bindet.","is_correct":false,"rationale":"Die Personalkosten der Analyse sind nicht der Punkt. Entscheidend ist die Fortpflanzung des Fehlers durch alle Folgephasen."},{"text":"Weil das Wasserfallmodell keine Testphase vorsieht.","is_correct":false,"rationale":"Sachlich falsch: Test ist eine eigene Phase im Wasserfall. Nur liegt sie eben am Ende."},{"text":"Weil Analysefehler die Hardwarebeschaffung betreffen.","is_correct":false,"rationale":"Das ist ein Spezialfall, keine allgemeine Begruendung."}]}'::jsonb,
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
  'Wer entscheidet in Scrum ueber die Reihenfolge im Product Backlog?',
  'Kurzformel: Product Owner = WAS und in welcher Reihenfolge. Developers = WIE und wie viel. Scrum Master = DASS es funktioniert.',
  1,
  ARRAY['scrum', 'rollen']::text[],
  null,
  '{"choices":[{"text":"Product Owner","is_correct":true,"rationale":"Richtig. Der Product Owner verantwortet die Wertmaximierung und damit die Priorisierung. Er darf sich beraten lassen, entscheidet aber allein."},{"text":"Scrum Master","is_correct":false,"rationale":"Der Scrum Master verantwortet die Wirksamkeit von Scrum - er moderiert, raeumt Hindernisse weg und priorisiert gerade nicht."},{"text":"Die Developers","is_correct":false,"rationale":"Die Developers entscheiden, WIE und wie viel sie in einen Sprint nehmen, nicht in welcher Reihenfolge der Product Owner den Wert sieht."},{"text":"Der Lenkungsausschuss","is_correct":false,"rationale":"Ein Lenkungsausschuss ist ein Gremium des klassischen Projektmanagements und in Scrum nicht vorgesehen."}]}'::jsonb,
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
  'Der Sprint selbst ist der Container fuer alle anderen Events. Wichtig fuer die Pruefung: Das Review kommt VOR der Retrospektive. Im Review geht es um das Produkt (mit Stakeholdern), in der Retrospektive um die Zusammenarbeit (nur das Scrum Team). Das Refinement ist kein eigenes Event, sondern eine laufende Taetigkeit.',
  2,
  ARRAY['scrum', 'events']::text[],
  null,
  '{"ordered_items":["Sprint Planning","Daily Scrum (taeglich)","Sprint Review","Sprint Retrospective"],"ordering_hint":"Vom Sprintbeginn bis zum Sprintende"}'::jsonb,
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
  '{"choices":[{"text":"15 Minuten","is_correct":true,"rationale":"Richtig. Das Daily ist immer auf 15 Minuten begrenzt - unabhaengig von der Sprintlaenge. Das ist die einzige Timebox, die nicht mitwaechst."},{"text":"30 Minuten","is_correct":false,"rationale":"Nein. Diese Zahl verwechselt man leicht mit der anteiligen Skalierung anderer Events."},{"text":"1 Stunde","is_correct":false,"rationale":"Eine Stunde waere die Groessenordnung einer Retrospektive bei kurzen Sprints, nicht des Dailys."},{"text":"Vier Stunden","is_correct":false,"rationale":"Vier Stunden ist die Obergrenze des Sprint Reviews bei einem Monatssprint."}]}'::jsonb,
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
  'Drei Artefakte, drei Commitments: Product Backlog -> Product Goal, Sprint Backlog -> Sprint Goal, Increment -> Definition of Done. Diese Zuordnung wird gern gefragt, weil viele die DoD faelschlich dem Sprint Backlog zuordnen.',
  3,
  ARRAY['scrum', 'artefakte']::text[],
  null,
  '{"buckets":["Product Backlog","Sprint Backlog","Increment"],"match_items":[{"text":"Product Goal","bucket":0,"rationale":"Das Product Goal ist das langfristige Ziel, auf das das Product Backlog einzahlt."},{"text":"Sprint Goal","bucket":1,"rationale":"Das Sprint Goal ist das eine Ziel des Sprints und gehoert zum Sprint Backlog."},{"text":"Definition of Done","bucket":2,"rationale":"Die DoD beschreibt, wann ein Increment wirklich fertig - also potenziell auslieferbar - ist."},{"text":"Geordnete Liste aller bekannten Anforderungen an das Produkt","bucket":0,"rationale":"Das ist die Definition des Product Backlogs."},{"text":"Auswahl der Items plus Plan zur Umsetzung fuer die kommenden Wochen","bucket":1,"rationale":"Sprint Backlog = Sprint Goal + ausgewaehlte Items + Umsetzungsplan."},{"text":"Das konkrete, nutzbare Ergebnis am Ende des Sprints","bucket":2,"rationale":"Das Increment ist das Arbeitsergebnis, das die DoD erfuellt."}]}'::jsonb,
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
Waere das Ergebnis krumm (z. B. 9,3), wird aufgerundet - ein halber Sprint existiert in der Planung nicht. Die Velocity wird immer aus abgeschlossenen (Definition of Done erfuellten) Items gebildet, nicht aus angefangenen.',
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
  'Kanban-Kernpraktiken: Workflow visualisieren, WIP limitieren, Fluss steuern, Regeln explizit machen, Feedback etablieren, verbessern. Hintergrund ist das Littlesche Gesetz: Durchlaufzeit = WIP / Durchsatz. Weniger parallele Arbeit bedeutet direkt kuerzere Durchlaufzeiten.',
  2,
  ARRAY['kanban', 'wip']::text[],
  null,
  '{"choices":[{"text":"Es begrenzt die Anzahl gleichzeitig bearbeiteter Aufgaben und macht Engpaesse sichtbar.","is_correct":true,"rationale":"Richtig. Work in Progress zu begrenzen verkuerzt die Durchlaufzeit und zwingt das Team, Aufgaben fertigzustellen, statt neue anzufangen."},{"text":"Es legt fest, wie viele Story Points pro Sprint eingeplant werden.","is_correct":false,"rationale":"Das ist die Velocity in Scrum. Kanban kennt keine Sprints und keine feste Einplanung."},{"text":"Es begrenzt die maximale Teamgroesse.","is_correct":false,"rationale":"WIP bezieht sich auf Arbeit, nicht auf Personen."},{"text":"Es definiert, wie lange eine Aufgabe maximal dauern darf.","is_correct":false,"rationale":"Das waere eine Timebox bzw. ein Service Level Expectation - nicht das WIP-Limit."}]}'::jsonb,
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
  'Welche Aussagen ueber User Stories und deren Akzeptanzkriterien sind korrekt?',
  'INVEST als Qualitaetscheck fuer Stories: Independent, Negotiable, Valuable, Estimable, Small, Testable. Der klassische Pruefungsfallstrick ist die Abgrenzung Akzeptanzkriterien (pro Story, fachlich) gegen Definition of Done (teamweit, handwerklich).',
  3,
  ARRAY['scrum', 'user_story']::text[],
  null,
  '{"choices":[{"text":"Das Format lautet: Als <Rolle> moechte ich <Ziel>, um <Nutzen>.","is_correct":true,"rationale":"Das ist das Standardformat. Der \"um ... zu\"-Teil ist der wichtigste und wird am haeufigsten weggelassen."},{"text":"Akzeptanzkriterien legen fest, wann die Story als erfuellt gilt.","is_correct":true,"rationale":"Sie sind storyspezifisch und pruefbar - im Gegensatz zur Definition of Done, die fuer alle Stories gilt."},{"text":"Die Definition of Done ersetzt die Akzeptanzkriterien.","is_correct":false,"rationale":"Falsch. Die DoD gilt teamweit fuer JEDES Increment (z. B. Code-Review erfolgt, Tests gruen). Akzeptanzkriterien sind fachlich und gelten nur fuer diese eine Story. Beides muss erfuellt sein."},{"text":"Story Points schaetzen den Aufwand relativ, nicht in Stunden.","is_correct":true,"rationale":"Relative Schaetzung ist stabiler als absolute: Menschen vergleichen zuverlaessiger, als sie Stunden schaetzen."},{"text":"Eine User Story muss immer in einen Sprint passen.","is_correct":true,"rationale":"Passt sie nicht, wird sie im Refinement geteilt. Eine zu grosse Story heisst Epic."},{"text":"Der Scrum Master schreibt die User Stories.","is_correct":false,"rationale":"Falsch. Verantwortlich fuer das Product Backlog ist der Product Owner; formulieren kann sie jeder im Team."}]}'::jsonb,
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
  '{"choices":[{"text":"Die Zeit, um die der Vorgang verschoben werden kann, ohne den fruehesten Anfang seiner Nachfolger zu veraendern.","is_correct":true,"rationale":"Richtig. FP = kleinster FAZ der Nachfolger minus eigener FEZ. Diesen Puffer darf man aufbrauchen, ohne dass es irgendjemand anders merkt."},{"text":"Die Zeit, um die der Vorgang verschoben werden kann, ohne das Projektende zu gefaehrden.","is_correct":false,"rationale":"Das ist die Definition des GESAMTpuffers (GP = SAZ - FAZ). Der GP ist immer groesser oder gleich dem FP."},{"text":"Die Differenz zwischen geplanter und tatsaechlicher Dauer.","is_correct":false,"rationale":"Das waere eine Abweichung im Projektcontrolling, kein Puffer aus der Netzplantechnik."},{"text":"Die Reservezeit, die das Projektteam zusaetzlich einplant.","is_correct":false,"rationale":"Das ist eine Sicherheitsreserve. Puffer im Netzplan werden berechnet, nicht eingeplant."}]}'::jsonb,
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
  'Welche Aussagen ueber den kritischen Pfad sind richtig?',
  'Der kritische Pfad ist der laengste Weg vom Start- zum Endvorgang und damit die Kette ohne Puffer. Praktische Konsequenz fuers Projekt: Ressourcen und Aufmerksamkeit gehoeren zuerst dorthin. Bei Verkuerzungsaufgaben immer nach jedem Schritt neu rechnen - der kritische Pfad kann wandern.',
  2,
  ARRAY['kritischer_pfad']::text[],
  null,
  '{"choices":[{"text":"Alle Vorgaenge auf ihm haben einen Gesamtpuffer von 0.","is_correct":true,"rationale":"Das ist die Definition. Genau daran erkennt man ihn in der Rechnung."},{"text":"Er ist der laengste Weg durch den Netzplan.","is_correct":true,"rationale":"Der laengste Weg bestimmt die Projektdauer - deshalb hat er keinen Puffer."},{"text":"Verzoegert sich ein Vorgang auf ihm um 2 Tage, verzoegert sich das Projektende um 2 Tage.","is_correct":true,"rationale":"Ohne Puffer schlaegt jede Verzoegerung eins zu eins aufs Projektende durch."},{"text":"Ein Netzplan hat immer genau einen kritischen Pfad.","is_correct":false,"rationale":"Falsch. Es kann mehrere gleich lange kritische Pfade geben - dann ist das Projekt besonders anfaellig, weil es mehrere pufferlose Ketten gibt."},{"text":"Er enthaelt immer die Vorgaenge mit der laengsten Einzeldauer.","is_correct":false,"rationale":"Falsch. Ein einzelner langer Vorgang kann parallel liegen und viel Puffer haben. Entscheidend ist die Kette, nicht die Einzeldauer."},{"text":"Eine Verkuerzung eines Vorgangs auf dem kritischen Pfad verkuerzt immer das Projekt um denselben Betrag.","is_correct":false,"rationale":"Falsch, und das ist der beliebteste Stolperstein: verkuerzt man genug, wird ein anderer Weg zum kritischen Pfad und die Verkuerzung verpufft ab diesem Punkt."}]}'::jsonb,
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
  'Welchen Vorteil hat ein Netzplan gegenueber einem einfachen Balkenplan (Gantt-Diagramm)?',
  'Arbeitsteilung in der Praxis: mit dem Netzplan rechnen, mit dem Balkenplan kommunizieren. Moderne Tools erzeugen den Gantt direkt aus den Netzplandaten und zeichnen den kritischen Pfad rot ein - in der Pruefung muss man beides aber getrennt beherrschen.',
  2,
  ARRAY['gantt']::text[],
  null,
  '{"choices":[{"text":"Er zeigt Abhaengigkeiten und Puffer explizit und macht den kritischen Pfad berechenbar.","is_correct":true,"rationale":"Richtig. Der Netzplan ist ein Rechenmodell: Puffer und kritischer Pfad ergeben sich rechnerisch, nicht durch Hinsehen."},{"text":"Er stellt den Zeitverlauf anschaulicher dar.","is_correct":false,"rationale":"Das ist gerade die Staerke des Balkenplans: Die Zeitachse ist massstabsgetreu und auf einen Blick lesbar."},{"text":"Er benoetigt keine Angabe von Vorgangsdauern.","is_correct":false,"rationale":"Ohne Dauern gibt es keine Vorwaerts- und Rueckwaertsrechnung. Der Netzplan braucht sie zwingend."},{"text":"Er eignet sich besser fuer die Praesentation vor der Geschaeftsfuehrung.","is_correct":false,"rationale":"Umgekehrt. Fuer Praesentationen nimmt man den Balkenplan, weil er ohne Erklaerung verstaendlich ist."}]}'::jsonb,
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
  'Meilensteine sind Entscheidungspunkte: Ergebnis da oder nicht, weiter oder nicht. Gute Meilensteine sind binaer pruefbar formuliert ("Pflichtenheft vom Kunden unterzeichnet"), nicht schwammig ("Konzept weitgehend fertig"). In der Meilensteintrendanalyse (MTA) traegt man ueber die Zeit auf, wie sich die geplanten Meilensteintermine verschieben - eine steigende Linie bedeutet Verzug.',
  1,
  ARRAY['meilenstein']::text[],
  null,
  '{"choices":[{"text":"Ein Ereignis mit der Dauer null, an dem ein definiertes Zwischenergebnis vorliegt.","is_correct":true,"rationale":"Richtig. Ein Meilenstein verbraucht keine Zeit und keine Ressourcen - er stellt nur fest, ob ein Ergebnis erreicht ist."},{"text":"Der laengste Vorgang im Projekt.","is_correct":false,"rationale":"Das hat mit Meilensteinen nichts zu tun; lange Vorgaenge sind einfach Vorgaenge."},{"text":"Ein Vorgang, der besonders viel Budget bindet.","is_correct":false,"rationale":"Budget ist kein Kriterium. Ein Meilenstein kostet definitionsgemaess nichts."},{"text":"Der Abschluss des gesamten Projekts.","is_correct":false,"rationale":"Der Projektabschluss IST ein Meilenstein, aber Meilensteine gibt es waehrend des gesamten Projekts."}]}'::jsonb,
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
  'Ein Meilensteintrendanalyse-Diagramm zeigt fuer einen Meilenstein eine nach oben steigende Linie. Welche Schluesse sind zulaessig?',
  'MTA-Lesehilfe: waagerecht = im Plan, steigend = Verzug, fallend = frueher fertig, Zickzack = unsichere Schaetzung bzw. instabile Planung. Ein Zickzack ist ein Warnsignal fuer die Planungsqualitaet, auch wenn der Endtermin am Ende stimmt.',
  2,
  ARRAY['mta']::text[],
  null,
  '{"choices":[{"text":"Der Meilenstein verschiebt sich immer weiter nach hinten.","is_correct":true,"rationale":"Richtig. Steigende Linie = der prognostizierte Termin wird bei jedem Berichtszeitpunkt spaeter."},{"text":"Es besteht Handlungsbedarf, z. B. Ressourcen umsteuern oder Umfang kuerzen.","is_correct":true,"rationale":"Die MTA ist ein Fruehwarninstrument - der Zweck ist genau dieses Gegensteuern."},{"text":"Der Meilenstein wird frueher als geplant erreicht.","is_correct":false,"rationale":"Falsch, das waere eine FALLENDE Linie. Steigend = spaeter."},{"text":"Das Projekt liegt im Plan.","is_correct":false,"rationale":"Falsch. Im Plan bedeutet eine waagerechte Linie."},{"text":"Die Ursache der Verzoegerung laesst sich direkt aus dem Diagramm ablesen.","is_correct":false,"rationale":"Falsch. Die MTA zeigt, DASS sich etwas verschiebt, nicht WARUM. Die Ursachenanalyse ist eine separate Aufgabe."}]}'::jsonb,
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
  'Fuer ein Arbeitspaket sind 120 Personentage veranschlagt. Es stehen 4 Entwickler zur Verfuegung, die jedoch nur zu 75 % fuer das Projekt verfuegbar sind (der Rest geht in Support und Linientaetigkeit).',
  'Wie viele Arbeitstage dauert das Arbeitspaket? Runde auf volle Tage auf.',
  'Rechenweg:
1. Tatsaechliche Kapazitaet pro Tag = 4 Entwickler x 0,75 = 3 Personentage/Tag
2. Dauer = 120 Personentage / 3 Personentage pro Tag = 40 Arbeitstage

Typischer Fehler: 120 / 4 = 30 Tage - die Verfuegbarkeit wird vergessen. In Pruefungsaufgaben ist der Verfuegbarkeitsgrad fast immer der eigentliche Pruefpunkt. Merke ausserdem: Personentage sind Aufwand, Arbeitstage sind Dauer. Die beiden Einheiten zu verwechseln kostet in der Klausur sofort Punkte.',
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
  'Eselsbruecke: LAstenheft = Auftraggeber (der die Last verteilt), PFlichtenheft = Auftragnehmer (der die Pflicht uebernimmt). Reihenfolge: Lastenheft -> Ausschreibung -> Angebote -> Zuschlag -> Pflichtenheft -> Genehmigung -> Umsetzung -> Abnahme gegen das Pflichtenheft.',
  1,
  ARRAY['lastenheft', 'pflichtenheft']::text[],
  null,
  '{"buckets":["Lastenheft","Pflichtenheft"],"match_items":[{"text":"Wird vom Auftraggeber erstellt.","bucket":0,"rationale":"Merksatz: Der Auftraggeber laedt dem Auftragnehmer die Last auf."},{"text":"Wird vom Auftragnehmer erstellt.","bucket":1,"rationale":"Der Auftragnehmer beschreibt, wie er die Pflicht erfuellt."},{"text":"Beschreibt das WAS und WOFUER - die Gesamtheit der Anforderungen.","bucket":0,"rationale":"Das Lastenheft ist bewusst loesungsneutral formuliert."},{"text":"Beschreibt das WIE und WOMIT - die konkrete technische Umsetzung.","bucket":1,"rationale":"Erst im Pflichtenheft werden Technologien, Schnittstellen und Architektur festgelegt."},{"text":"Ist Grundlage fuer die Ausschreibung und den Angebotsvergleich.","bucket":0,"rationale":"Alle Anbieter bekommen dasselbe Lastenheft - nur so sind Angebote vergleichbar."},{"text":"Wird vom Auftraggeber genehmigt und ist Grundlage der Abnahme.","bucket":1,"rationale":"Das genehmigte Pflichtenheft ist der vertragliche Massstab, gegen den abgenommen wird."}]}'::jsonb,
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
  'Testfrage zur Abgrenzung: Kann man die Anforderung als "Das System TUT etwas" formulieren? Dann funktional. Beschreibt sie eher, WIE GUT das System etwas tut (schnell, sicher, verfuegbar, bedienbar, wartbar, portabel), dann nicht-funktional. Die sechs Qualitaetsmerkmale nach ISO 25010 sind eine gute Checkliste fuer nicht-funktionale Anforderungen.',
  2,
  ARRAY['anforderungsarten']::text[],
  null,
  '{"buckets":["Funktional","Nicht-funktional"],"match_items":[{"text":"Das System muss Rechnungen als PDF exportieren koennen.","bucket":0,"rationale":"Eine konkrete Faehigkeit des Systems - also funktional."},{"text":"Die Suchanfrage muss in unter 2 Sekunden beantwortet werden.","bucket":1,"rationale":"Performance ist eine Qualitaetseigenschaft, kein Funktionsumfang."},{"text":"Benutzer muessen sich mit Zwei-Faktor-Authentifizierung anmelden koennen.","bucket":0,"rationale":"Die Anmeldung mit 2FA ist eine Funktion, die das System bereitstellen muss."},{"text":"Die Anwendung muss zu 99,5 % im Jahr verfuegbar sein.","bucket":1,"rationale":"Verfuegbarkeit ist eine klassische nicht-funktionale Anforderung."},{"text":"Die Oberflaeche muss der BITV 2.0 fuer Barrierefreiheit entsprechen.","bucket":1,"rationale":"Eine Randbedingung bzw. Qualitaetsanforderung - sie beschreibt keine einzelne Funktion."},{"text":"Administratoren koennen Benutzerkonten sperren und entsperren.","bucket":0,"rationale":"Wieder eine konkrete Faehigkeit - funktional."}]}'::jsonb,
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
  'Merkhilfe fuer Anforderungsqualitaet: eindeutig, vollstaendig, widerspruchsfrei, pruefbar, notwendig, verstaendlich, priorisiert. Priorisierung erfolgt oft nach MuSCoW: Must have, Should have, Could have, Won t have.',
  2,
  ARRAY['anforderungsqualitaet']::text[],
  null,
  '{"choices":[{"text":"Sie ist eindeutig und laesst nur eine Interpretation zu.","is_correct":true,"rationale":"Mehrdeutigkeit ist die Hauptursache fuer Streit bei der Abnahme."},{"text":"Sie ist ueberpruefbar bzw. testbar.","is_correct":true,"rationale":"Wenn niemand entscheiden kann, ob sie erfuellt ist, ist sie wertlos."},{"text":"Sie ist vollstaendig - es fehlen keine notwendigen Angaben.","is_correct":true,"rationale":"Klassisches Kriterium aus der Anforderungsanalyse."},{"text":"Sie enthaelt bereits die technische Loesung.","is_correct":false,"rationale":"Falsch, zumindest im Lastenheft. Eine vorweggenommene Loesung schliesst bessere Alternativen aus. Das WIE gehoert ins Pflichtenheft."},{"text":"Sie ist mit anderen Anforderungen widerspruchsfrei.","is_correct":true,"rationale":"Widersprueche fallen sonst erst in der Umsetzung auf - dann ist die Korrektur teuer."},{"text":"Sie ist moeglichst allgemein gehalten, um flexibel zu bleiben.","is_correct":false,"rationale":"Falsch. \"Das System soll benutzerfreundlich sein\" ist nicht flexibel, sondern unpruefbar. Flexibilitaet erreicht man ueber Prioritaeten, nicht ueber Vagheit."}]}'::jsonb,
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
  'Ein Dienstleister liefert eine Software aus. Bei der Abnahme stellt der Kunde zwei kleinere Maengel fest, die den Betrieb nicht verhindern.',
  'Was ist die uebliche und rechtlich sinnvolle Vorgehensweise?',
  'Was an der Abnahme haengt: Faelligkeit der Verguetung, Gefahruebergang, Beginn der Verjaehrungsfrist fuer Gewaehrleistung und die Umkehr der Beweislast (danach muss der Kunde den Mangel beweisen). Deshalb ist das Abnahmeprotokoll mit Maengelliste kein Formalkram, sondern der wichtigste Zettel im Projekt.',
  2,
  ARRAY['abnahme']::text[],
  null,
  '{"choices":[{"text":"Abnahme unter Vorbehalt: Maengel werden protokolliert und mit Frist zur Beseitigung vereinbart.","is_correct":true,"rationale":"Richtig. Die Abnahme unter Vorbehalt haelt die Maengelrechte aufrecht und blockiert trotzdem nicht den Produktivstart."},{"text":"Vollstaendige Verweigerung der Abnahme bis alle Maengel beseitigt sind.","is_correct":false,"rationale":"Bei unwesentlichen Maengeln ist die Verweigerung in der Regel unzulaessig (vgl. Werkvertragsrecht) und schadet dem Kunden selbst, weil der Nutzen ausbleibt."},{"text":"Vorbehaltlose Abnahme, die Maengel werden formlos per E-Mail gemeldet.","is_correct":false,"rationale":"Gefaehrlich: Mit der vorbehaltlosen Abnahme verliert der Kunde bei bekannten Maengeln seine Rechte darauf."},{"text":"Die Abnahme entfaellt, weil die Software bereits laeuft.","is_correct":false,"rationale":"Die Abnahme ist ein formaler Rechtsakt mit erheblichen Folgen (Gefahruebergang, Faelligkeit der Verguetung, Beginn der Gewaehrleistung). Sie entfaellt nicht durch Nutzung - im Gegenteil kann Nutzung als konkludente Abnahme gelten."}]}'::jsonb,
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
  'Die zwei Stellen, an denen in der Pruefung gern getauscht wird: (1) Das Pflichtenheft kommt NACH der Vergabe - vorher weiss man ja gar nicht, wer es schreibt. (2) Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft, weil nur das Pflichtenheft die pruefbare Konkretisierung enthaelt.',
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
  'Waehrend der Realisierung bittet die Fachabteilung den Entwickler mehrfach direkt um "kleine Zusatzfunktionen". Der Termin ist unveraendert.',
  'Wie sollte die Projektleitung darauf reagieren?',
  'Change-Request-Prozess: Antrag erfassen -> Auswirkung auf Zeit, Kosten und Qualitaet bewerten -> Entscheidung durch den befugten Gremium bzw. Auftraggeber -> bei Annahme Planung und Pflichtenheft fortschreiben. Der Kern ist Transparenz: Jeder soll sehen, was eine Aenderung kostet.',
  3,
  ARRAY['scope_creep']::text[],
  null,
  '{"choices":[{"text":"Jede Aenderung ueber einen definierten Change-Request-Prozess mit Aufwands- und Terminbewertung fuehren.","is_correct":true,"rationale":"Richtig. Aenderungen sind nicht verboten - sie muessen nur bewertet und entschieden werden, statt still im Hintergrund zu passieren."},{"text":"Die Zusatzwuensche ablehnen, weil das Pflichtenheft unterschrieben ist.","is_correct":false,"rationale":"Pauschale Ablehnung ist praxisfern und beschaedigt die Zusammenarbeit. Anforderungen aendern sich - das Problem ist der unkontrollierte Weg, nicht die Aenderung selbst."},{"text":"Die Wuensche kurzfristig mit umsetzen, solange sie klein sind.","is_correct":false,"rationale":"Genau so entsteht Scope Creep: viele kleine, nie bewertete Erweiterungen sprengen am Ende Termin und Budget, und niemand kann hinterher sagen, warum."},{"text":"Die Entscheidung dem Entwickler ueberlassen, der den Aufwand am besten einschaetzen kann.","is_correct":false,"rationale":"Der Entwickler kann den Aufwand schaetzen, aber nicht ueber Umfang, Budget und Termin entscheiden. Das ist eine Projektleitungs- bzw. Auftraggeberentscheidung."}]}'::jsonb,
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
  'Ablauf der Nutzwertanalyse: 1. Kriterien festlegen, 2. gewichten (Summe 100 %), 3. Alternativen je Kriterium bewerten, 4. Teilnutzwerte = Gewicht x Bewertung, 5. aufsummieren, 6. hoechster Nutzwert gewinnt.
Schwaeche, nach der gern gefragt wird: Gewichtung und Bewertung sind subjektiv. Wer das Ergebnis vorher kennt, kann es ueber die Gewichtung herbeifuehren - deshalb Kriterien VOR dem Blick auf die Angebote festlegen.',
  2,
  ARRAY['nutzwertanalyse']::text[],
  null,
  '{"choices":[{"text":"Zum Vergleich von Alternativen anhand mehrerer, unterschiedlich gewichteter und teils nicht monetaerer Kriterien.","is_correct":true,"rationale":"Richtig. Ihre Staerke ist, dass sie weiche Faktoren wie Bedienbarkeit oder Zukunftssicherheit vergleichbar macht."},{"text":"Zur Berechnung des exakten Return on Investment.","is_correct":false,"rationale":"Der ROI ist eine rein monetaere Kennzahl. Die Nutzwertanalyse liefert dimensionslose Punkte, keine Euro."},{"text":"Zur Ermittlung der Projektdauer.","is_correct":false,"rationale":"Das leistet die Netzplantechnik."},{"text":"Zur rechtssicheren Dokumentation gegenueber dem Auftraggeber.","is_correct":false,"rationale":"Sie kann eine Entscheidung nachvollziehbar machen, ist aber kein Rechtsdokument."}]}'::jsonb,
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
  'Eine Virtualisierungsloesung kostet einmalig 48.000 Euro. Dadurch sinken die laufenden Kosten um 15.000 Euro pro Jahr.',
  'Nach wie vielen Jahren ist die Investition amortisiert? (Eine Nachkommastelle)',
  'Amortisationsdauer = Investitionssumme / jaehrlicher Rueckfluss
= 48.000 Euro / 15.000 Euro pro Jahr = 3,2 Jahre

In Worten: nach rund 3 Jahren und 2-3 Monaten hat sich die Anschaffung bezahlt gemacht. Achtung bei Aufgaben, in denen zusaetzlich laufende Kosten der neuen Loesung genannt werden - dann muss man erst den NETTO-Rueckfluss bilden (Einsparung minus neue laufende Kosten) und erst damit rechnen.',
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
  'Welche Positionen gehoeren in eine TCO-Betrachtung (Total Cost of Ownership) fuer eine Serverbeschaffung?',
  'TCO betrachtet den gesamten Lebenszyklus: Beschaffung, Betrieb, Wartung, Schulung, Ausfallkosten, Ausserbetriebnahme. Der Sinn ist, das billigste Angebot vom guenstigsten zu unterscheiden. Wichtig zur Abgrenzung: TCO = nur Kosten. ROI und Wirtschaftlichkeitsrechnung = Kosten UND Nutzen.',
  2,
  ARRAY['tco']::text[],
  null,
  '{"choices":[{"text":"Anschaffungskosten der Hardware","is_correct":true,"rationale":"Die direkten Anschaffungskosten sind der offensichtliche Teil - meist der kleinere."},{"text":"Strom- und Klimatisierungskosten ueber die Nutzungsdauer","is_correct":true,"rationale":"Laufende Betriebskosten sind bei Servern oft hoeher als der Kaufpreis."},{"text":"Lizenz- und Wartungsvertraege","is_correct":true,"rationale":"Wiederkehrende Kosten, die sich ueber 5 Jahre erheblich summieren."},{"text":"Schulungsaufwand fuer die Administratoren","is_correct":true,"rationale":"Auch indirekte Personalkosten gehoeren dazu - das unterscheidet TCO vom reinen Anschaffungspreis."},{"text":"Der Umsatz, der mit dem neuen System erzielt wird","is_correct":false,"rationale":"Falsch. TCO betrachtet ausschliesslich die KOSTEN. Ertraege gehoeren in eine Wirtschaftlichkeits- oder ROI-Rechnung."},{"text":"Entsorgungs- und Migrationskosten am Ende der Nutzungsdauer","is_correct":true,"rationale":"Der oft vergessene letzte Lebenszyklusabschnitt gehoert ausdruecklich dazu."}]}'::jsonb,
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
  'Fuer das Risiko "Ausfall des Hauptlieferanten" wurde eine Eintrittswahrscheinlichkeit von 20 % und eine Schadenshoehe von 80.000 Euro geschaetzt.',
  'Wie hoch ist der Risikowert (Erwartungswert) in Euro?',
  'Risikowert = Eintrittswahrscheinlichkeit x Schadenshoehe
= 0,20 x 80.000 Euro = 16.000 Euro

Der Risikowert ist die Obergrenze fuer sinnvolle Gegenmassnahmen: Eine Massnahme, die 25.000 Euro kostet, lohnt sich hier nicht. Deshalb werden Risiken nach dem Risikowert priorisiert und nicht nach der Schadenshoehe allein.',
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
  'Ordne jede Massnahme der passenden Risikostrategie zu.',
  'Vier Strategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit oder Auswirkung runter), Ueberwaelzen (Dritter traegt das Risiko), Akzeptieren (bewusst tragen).
Der haeufigste Fehler ist die Verwechslung von Vermeiden und Vermindern. Testfrage: Kann das Risiko danach ueberhaupt noch eintreten? Ja -> Vermindern. Nein -> Vermeiden.',
  2,
  ARRAY['risikostrategien']::text[],
  null,
  '{"buckets":["Vermeiden","Vermindern","Ueberwaelzen","Akzeptieren"],"match_items":[{"text":"Auf den Einsatz einer unausgereiften Technologie wird verzichtet.","bucket":0,"rationale":"Die Ursache wird komplett beseitigt - die Eintrittswahrscheinlichkeit sinkt auf null."},{"text":"Zusaetzliche Code-Reviews und automatisierte Tests werden eingefuehrt.","bucket":1,"rationale":"Die Eintrittswahrscheinlichkeit sinkt, das Risiko bleibt aber grundsaetzlich bestehen."},{"text":"Eine Betriebshaftpflichtversicherung wird abgeschlossen.","bucket":2,"rationale":"Der finanzielle Schaden geht auf einen Dritten ueber - klassisches Ueberwaelzen."},{"text":"Die Entwicklung wird an einen Dienstleister mit Festpreis vergeben.","bucket":2,"rationale":"Das Kostenrisiko traegt beim Festpreis der Auftragnehmer."},{"text":"Ein Restrisiko mit sehr geringem Schadenswert wird bewusst in Kauf genommen und dokumentiert.","bucket":3,"rationale":"Akzeptieren ist eine legitime Strategie - entscheidend ist, dass es bewusst und dokumentiert geschieht."},{"text":"Ein Backup-Rechenzentrum wird bereitgehalten, um die Ausfalldauer zu begrenzen.","bucket":1,"rationale":"Die Auswirkung wird reduziert. Das Risiko selbst bleibt bestehen - also Vermindern, nicht Vermeiden."}]}'::jsonb,
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
  'Welche der folgenden Massnahmen sind KONSTRUKTIVE Qualitaetssicherungsmassnahmen?',
  'Einfache Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler (Standards, Methoden, Werkzeuge, Schulung, Templates). ANALYTISCH = nachher, findet Fehler (Test, Review, Inspektion, statische Analyse, Audit).
Grenzfall, der gern gefragt wird: Ein Linter ist konstruktiv, wenn er beim Schreiben eingreift, und analytisch, wenn er im Nachhinein ueber fertigen Code laeuft. In der Pruefung zaehlt die Einordnung als Werkzeugvorgabe - also konstruktiv.',
  2,
  ARRAY['qualitaetssicherung']::text[],
  null,
  '{"choices":[{"text":"Verbindliche Coding-Standards und Styleguides","is_correct":true,"rationale":"Konstruktiv: Sie verhindern Fehler von vornherein, statt sie hinterher zu finden."},{"text":"Einsatz erprobter Frameworks und Entwurfsmuster","is_correct":true,"rationale":"Ebenfalls vorbeugend - das Rad nicht neu erfinden heisst, dessen Fehler nicht neu zu machen."},{"text":"Schulung der Entwickler vor Projektbeginn","is_correct":true,"rationale":"Qualifikation ist eine klassische konstruktive Massnahme."},{"text":"Durchfuehrung von Modul- und Integrationstests","is_correct":false,"rationale":"Das ist ANALYTISCHE QS: Tests finden vorhandene Fehler, sie verhindern sie nicht."},{"text":"Code-Review nach Fertigstellung eines Moduls","is_correct":false,"rationale":"Ebenfalls analytisch - es wird ein bereits erstelltes Artefakt geprueft."},{"text":"Einsatz einer einheitlichen Entwicklungsumgebung mit Linter-Konfiguration","is_correct":true,"rationale":"Vorbeugend: Der Linter verhindert bestimmte Fehlerklassen schon beim Tippen."}]}'::jsonb,
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
  'In der Risikomatrix liegt Risiko X bei geringer Eintrittswahrscheinlichkeit, aber existenzbedrohender Schadenshoehe (z. B. vollstaendiger Datenverlust ohne Backup).',
  'Wie ist mit einem solchen Risiko umzugehen?',
  'Die Risikomatrix (Wahrscheinlichkeit x Auswirkung) hat eine eingebaute Schwaeche: Sie behandelt "oft, aber harmlos" und "selten, aber katastrophal" gleich, wenn das Produkt gleich ist. In der Praxis zieht man deshalb eine Toleranzgrenze: Schaeden oberhalb einer bestimmten Hoehe werden unabhaengig von der Wahrscheinlichkeit behandelt. Genau deshalb gibt es Backups, obwohl Totalausfaelle selten sind.',
  3,
  ARRAY['risikomatrix']::text[],
  null,
  '{"choices":[{"text":"Es muss trotz geringer Wahrscheinlichkeit behandelt werden, weil der Schaden untragbar waere.","is_correct":true,"rationale":"Richtig. Bei existenzbedrohenden Schaeden greift die reine Erwartungswertlogik nicht mehr - ein Schaden, den man nicht ueberlebt, darf nicht eintreten."},{"text":"Es kann akzeptiert werden, weil der Risikowert rechnerisch niedrig ist.","is_correct":false,"rationale":"Genau der Denkfehler. Ein rechnerisch kleiner Erwartungswert hilft nicht, wenn der Einzelfall das Unternehmen beendet."},{"text":"Es ist nachrangig gegenueber Risiken mit mittlerer Wahrscheinlichkeit und mittlerem Schaden.","is_correct":false,"rationale":"Falsch. Bei gleicher Rechengroesse hat das Risiko mit dem katastrophalen Schadenspotenzial Vorrang."},{"text":"Es gehoert nicht in das Risikoregister, weil es unwahrscheinlich ist.","is_correct":false,"rationale":"Ins Register gehoeren alle identifizierten Risiken. Erst die Bewertung entscheidet ueber Massnahmen."}]}'::jsonb,
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
  'Lessons Learned funktionieren nur unter drei Bedingungen: zeitnah (nicht Monate spaeter), ohne Schuldzuweisung und mit dokumentiertem Ergebnis an einem Ort, an dem das naechste Projekt es auch findet. Eine Sitzung, deren Protokoll in einem Ordner verschwindet, ist verlorene Zeit.',
  1,
  ARRAY['lessons_learned']::text[],
  null,
  '{"choices":[{"text":"Erfahrungen systematisch sichern, damit kuenftige Projekte davon profitieren.","is_correct":true,"rationale":"Richtig. Der Wert entsteht erst dadurch, dass die Erkenntnisse dokumentiert und in der Organisation verfuegbar gemacht werden."},{"text":"Die Verantwortlichen fuer Fehler im Projekt benennen.","is_correct":false,"rationale":"Genau das Gegenteil. Sobald Schuldzuweisungen drohen, sagt niemand mehr, was wirklich schieflief - und die Sitzung ist wertlos."},{"text":"Die Abnahme des Projektergebnisses durch den Kunden.","is_correct":false,"rationale":"Die Abnahme ist ein eigener, vorgelagerter Schritt."},{"text":"Die Schlussrechnung fuer den Kunden erstellen.","is_correct":false,"rationale":"Das ist kaufmaennischer Projektabschluss, nicht Erfahrungssicherung."}]}'::jsonb,
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
  'Was gehoert in einen Projektabschlussbericht?',
  'Der Projektabschluss hat drei Ebenen: sachlich-technisch (Abnahme, Uebergabe an den Betrieb, Restarbeiten), kaufmaennisch (Schlussrechnung, Nachkalkulation, Projekt schliessen) und personell (Teamaufloesung, Rueckfuehrung in die Linie, Wuerdigung). Die personelle Ebene wird am haeufigsten vergessen - und ist die, an die sich das Team am laengsten erinnert.',
  2,
  ARRAY['abschlussbericht']::text[],
  null,
  '{"choices":[{"text":"Soll-Ist-Vergleich von Terminen, Kosten und Leistungsumfang","is_correct":true,"rationale":"Der Kern des Berichts: Was war geplant, was ist herausgekommen, warum die Abweichung?"},{"text":"Zielerreichungsgrad bezogen auf den Projektauftrag","is_correct":true,"rationale":"Gemessen wird gegen das, was im Auftrag stand - nicht gegen das, was unterwegs daraus wurde."},{"text":"Lessons Learned und Verbesserungsvorschlaege","is_correct":true,"rationale":"Die Erfahrungssicherung gehoert in den Bericht, nicht nur ins Sitzungsprotokoll."},{"text":"Uebergabe an Betrieb bzw. Linie mit benannten Verantwortlichen","is_correct":true,"rationale":"Ohne klare Uebergabe bleibt das Projektteam ewig zustaendig - ein haeufiger Praxisfehler."},{"text":"Der vollstaendige Quellcode der Anwendung","is_correct":false,"rationale":"Falsch. Der Code gehoert ins Versionsverwaltungssystem, nicht in den Bericht. Der Bericht verweist darauf."},{"text":"Offene Punkte und Restrisiken","is_correct":true,"rationale":"Was nicht erledigt wurde, muss benannt und an jemanden uebergeben werden."}]}'::jsonb,
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
  'Zwei Stellen, an denen gern getauscht wird: Die Abnahme kommt VOR der Uebergabe an den Betrieb - man uebergibt nichts, was der Kunde nicht angenommen hat. Und die Teamaufloesung kommt ZULETZT, weil man fuer Bericht und Lessons Learned die Leute noch braucht. Wer das Team vorher aufloest, bekommt weder das eine noch das andere in brauchbarer Qualitaet.',
  2,
  ARRAY['projektabschluss']::text[],
  null,
  '{"ordered_items":["Restarbeiten abschliessen und Projektergebnis fertigstellen","Abnahme durch den Auftraggeber mit Abnahmeprotokoll","Uebergabe an den Betrieb bzw. die Linienorganisation","Projektabschlussbericht mit Soll-Ist-Vergleich erstellen","Lessons Learned durchfuehren und dokumentieren","Projektteam formal aufloesen und Ressourcen freigeben"],"ordering_hint":"Vom ersten bis zum letzten Schritt"}'::jsonb,
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
- "Do" heisst ausprobieren im kleinen Rahmen, nicht flaechendeckend ausrollen. Das Ausrollen passiert erst in "Act".
- Der Zyklus endet nicht, sondern beginnt von vorn - deshalb Kreis und nicht Liste.',
  1,
  ARRAY['pdca']::text[],
  null,
  '{"ordered_items":["Plan - Ziel festlegen und Massnahme planen","Do - Massnahme im Kleinen ausprobieren","Check - Ergebnis mit dem Ziel vergleichen","Act - bei Erfolg zum Standard machen, sonst nachbessern"],"ordering_hint":"Beginne mit der Planung"}'::jsonb,
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
  'Was bedeutet Qualitaet im Sinne des Qualitaetsmanagements?',
  'Qualitaet = Erfuellungsgrad der Anforderungen. Daraus folgt eine praktische Konsequenz: Ohne pruefbar formulierte Anforderungen kann man Qualitaet gar nicht feststellen. Deshalb haengen Anforderungsanalyse und Qualitaetssicherung unmittelbar zusammen - und deshalb ist eine unpruefbare Anforderung wie "benutzerfreundlich" ein Qualitaetsproblem, bevor die erste Zeile Code geschrieben ist.',
  2,
  ARRAY['qualitaetsbegriff']::text[],
  null,
  '{"choices":[{"text":"Der Grad, in dem ein Produkt die festgelegten Anforderungen erfuellt.","is_correct":true,"rationale":"Richtig. Qualitaet ist relativ zu den vereinbarten Anforderungen - nicht absolut."},{"text":"Die technisch bestmoegliche Ausfuehrung eines Produkts.","is_correct":false,"rationale":"Falsch. Das waere Perfektion. Ein Produkt, das teurer ist als gefordert, hat nicht mehr Qualitaet, sondern verschwendet Budget."},{"text":"Die Abwesenheit jeglicher Fehler.","is_correct":false,"rationale":"Falsch. Nullfehler ist ein Ziel, keine Definition. Auch ein Produkt mit bekannten, akzeptierten Restmaengeln kann die Anforderungen erfuellen."},{"text":"Die Zufriedenheit der Entwickler mit dem Ergebnis.","is_correct":false,"rationale":"Falsch. Massstab ist die Anforderung des Kunden, nicht das Empfinden des Teams."}]}'::jsonb,
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
  'Ordne die Massnahmen der konstruktiven oder analytischen Qualitaetssicherung zu.',
  'Trennlinie: KONSTRUKTIV = vorher, verhindert Fehler (Standards, Methoden, Werkzeuge, Schulung, Templates). ANALYTISCH = nachher, findet Fehler (Test, Review, Inspektion, Audit).
Merksatz: Der Test findet den Fehler, der Standard verhindert ihn. Wirtschaftlich ist konstruktive QS fast immer ueberlegen - siehe Rule of Ten.',
  2,
  ARRAY['qs_massnahmen']::text[],
  null,
  '{"buckets":["Konstruktiv (verhindert Fehler)","Analytisch (findet Fehler)"],"match_items":[{"text":"Verbindlicher Styleguide fuer die Programmierung","bucket":0,"rationale":"Eine Vorgabe, die bestimmte Fehler gar nicht erst entstehen laesst."},{"text":"Code-Review eines fertigen Moduls","bucket":1,"rationale":"Ein bereits erstelltes Artefakt wird geprueft - also analytisch."},{"text":"Schulung der Entwickler vor Projektbeginn","bucket":0,"rationale":"Qualifikation ist eine klassische vorbeugende Massnahme."},{"text":"Automatisierter Unit-Test in der Build-Pipeline","bucket":1,"rationale":"Tests finden vorhandene Fehler, sie verhindern sie nicht."},{"text":"Einsatz eines erprobten Frameworks statt Eigenentwicklung","bucket":0,"rationale":"Das Rad nicht neu erfinden heisst, dessen Fehler nicht neu zu machen."},{"text":"Abnahmetest durch den Auftraggeber","bucket":1,"rationale":"Pruefung des fertigen Produkts - analytisch."}]}'::jsonb,
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
  'Ein Team startet ein Projekt und legt seine Qualitaetsziele fest.',
  'Welche Festlegungen gehoeren in die Qualitaetsplanung?',
  'Qualitaetsplanung beantwortet vier Fragen: Was wird gemessen? Welcher Zielwert gilt? Wann und wie wird geprueft? Wer ist verantwortlich?
Der haeufigste Fehler in der Praxis ist, Qualitaetsziele nur qualitativ zu formulieren ("hohe Performance"). Ohne Zahl ist das keine Planung, sondern ein Wunsch.',
  2,
  ARRAY['qualitaetsplanung']::text[],
  null,
  '{"choices":[{"text":"Welche Qualitaetsmerkmale gemessen werden und mit welchem Zielwert","is_correct":true,"rationale":"Ohne Zielwert ist spaeter nicht entscheidbar, ob die Qualitaet erreicht wurde."},{"text":"Welche Pruefmassnahmen wann durchgefuehrt werden","is_correct":true,"rationale":"Der Pruefplan legt fest, an welchen Punkten geprueft wird - sonst prueft am Ende niemand."},{"text":"Wer fuer die Qualitaetssicherung verantwortlich ist","is_correct":true,"rationale":"Ohne benannte Verantwortung wird QS die Aufgabe, die jeder fuer die anderen fuer zustaendig haelt."},{"text":"Die konkrete Anzahl der zu erwartenden Fehler","is_correct":false,"rationale":"Falsch. Eine Fehlerzahl laesst sich nicht sinnvoll im Voraus festlegen. Man plant Massnahmen und Schwellwerte, keine Fehlerquoten als Ziel."},{"text":"Die Definition of Done bzw. die Abnahmekriterien","is_correct":true,"rationale":"Die Festlegung, wann etwas fertig ist, ist der Kern der Qualitaetsplanung."},{"text":"Der vollstaendige Quellcode der Testfaelle","is_correct":false,"rationale":"Falsch. Testfaelle entstehen spaeter in der Umsetzung. Geplant wird, DASS und WIE getestet wird."}]}'::jsonb,
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
  'Bringe die Teststufen in die Reihenfolge, in der sie ueblicherweise durchlaufen werden.',
  'Die vier Teststufen bauen aufeinander auf: Je hoeher die Stufe, desto groesser der Pruefgegenstand und desto naeher am Kunden.
- Modultest: entwickelt meist der Programmierer selbst.
- Integrationstest: prueft Schnittstellen zwischen Komponenten.
- Systemtest: prueft das Gesamtsystem gegen die Spezifikation, in einer moeglichst produktionsaehnlichen Testumgebung.
- Abnahmetest: prueft gegen die Anforderungen des Auftraggebers, in dessen Verantwortung.
Systemtest und Abnahmetest werden gern verwechselt: der Systemtest ist Sache des Auftragnehmers, der Abnahmetest die des Auftraggebers.',
  2,
  ARRAY['teststufen']::text[],
  null,
  '{"ordered_items":["Modultest (Unittest) - einzelne Funktion oder Klasse","Integrationstest - Zusammenspiel mehrerer Komponenten","Systemtest - das komplette System in der Testumgebung","Abnahmetest - das System beim Auftraggeber"],"ordering_hint":"Vom kleinsten Pruefgegenstand zum groessten"}'::jsonb,
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
  'Black-Box: Testfaelle aus den Anforderungen, ohne Kenntnis des Codes. Typische Verfahren sind Aequivalenzklassenbildung und Grenzwertanalyse.
White-Box: Testfaelle aus der Struktur des Codes, mit Ueberdeckungskriterien wie Anweisungs- oder Zweigabdeckung.
Faustregel fuer die Pruefung: Steht "kennt den Code nicht" oder "gegen die Anforderungen", ist es Black-Box. Steht "Zweig", "Pfad", "Coverage" oder "Schleifenlogik", ist es White-Box.',
  2,
  ARRAY['blackbox', 'whitebox']::text[],
  null,
  '{"buckets":["Black-Box","White-Box"],"match_items":[{"text":"Der Tester kennt den Quellcode nicht und prueft nur Eingabe und Ausgabe.","bucket":0,"rationale":"Genau die Definition: die innere Struktur bleibt eine schwarze Kiste."},{"text":"Die Testfaelle werden so gewaehlt, dass jeder Programmzweig einmal durchlaufen wird.","bucket":1,"rationale":"Zweigabdeckung setzt Kenntnis des Codes voraus - also White-Box."},{"text":"Grundlage sind ausschliesslich die Anforderungen aus dem Pflichtenheft.","bucket":0,"rationale":"Anforderungsbasiertes Testen ohne Blick in den Code."},{"text":"Der Entwickler prueft seine eigene Schleifenlogik mit Grenzwerten fuer den Zaehler.","bucket":1,"rationale":"Die Logik im Inneren wird gezielt adressiert."},{"text":"Der Abnahmetest durch den Fachbereich.","bucket":0,"rationale":"Der Fachbereich testet fachlich gegen die Anforderungen, nicht gegen den Code."},{"text":"Code-Coverage wird als Kennzahl erhoben.","bucket":1,"rationale":"Ueberdeckungsmasse beziehen sich zwangslaeufig auf den Quellcode."}]}'::jsonb,
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
  'Was gehoert in einen vollstaendigen Testfall?',
  'Ein Testfall besteht aus: Kennung, Vorbedingung, Eingabe, erwartetes Ergebnis - und nach der Durchfuehrung zusaetzlich dem tatsaechlichen Ergebnis sowie dem Urteil bestanden/nicht bestanden. Erst das zusammen ergibt das Testprotokoll.
Der haeufigste Fehler in Pruefungsaufgaben: das Soll-Ergebnis vergessen. Ein Test ohne Soll-Ergebnis kann nicht fehlschlagen und ist damit wertlos.',
  2,
  ARRAY['testfall', 'testprotokoll']::text[],
  null,
  '{"choices":[{"text":"Eindeutige Testfall-Nummer oder -Bezeichnung","is_correct":true,"rationale":"Ohne Kennung laesst sich ein Fehler spaeter nicht dem Testfall zuordnen."},{"text":"Vorbedingung bzw. Ausgangszustand","is_correct":true,"rationale":"Ein Testfall ist nur reproduzierbar, wenn der Startzustand definiert ist."},{"text":"Konkrete Eingabedaten","is_correct":true,"rationale":"\"Irgendeine gueltige Eingabe\" ist kein Testfall, sondern eine Absichtserklaerung."},{"text":"Das erwartete Ergebnis (Soll-Ergebnis)","is_correct":true,"rationale":"Der wichtigste Teil. Ohne Soll-Ergebnis kann niemand entscheiden, ob der Test bestanden ist."},{"text":"Der Name des Entwicklers, der den Fehler verursacht hat","is_correct":false,"rationale":"Falsch - und schaedlich. Testfaelle dienen der Fehlersuche, nicht der Schuldzuweisung."},{"text":"Die geschaetzte Dauer der Fehlerbehebung","is_correct":false,"rationale":"Falsch. Das ist eine Planungsgroesse fuer die Korrektur, kein Bestandteil des Testfalls."}]}'::jsonb,
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
  'Eine Entwicklerin geht einen fremden Algorithmus Zeile fuer Zeile auf Papier durch und notiert nach jeder Anweisung die aktuellen Variablenwerte.',
  'Wie heisst dieses Verfahren?',
  'Der Schreibtischtest (auch Trockentest oder Code-Walkthrough) ist ein statisches Verfahren: Der Code wird gelesen und nachvollzogen, nicht ausgefuehrt.
Praktisch geht man mit einer Wertetabelle vor - eine Spalte je Variable, eine Zeile je Durchlauf. Genau diese Tabelle verlangt die AP1 haeufig als Loesung. Wer sie sauber fuehrt, findet den Fehler fast von selbst; wer im Kopf rechnet, verrechnet sich.',
  2,
  ARRAY['schreibtischtest']::text[],
  null,
  '{"choices":[{"text":"Schreibtischtest","is_correct":true,"rationale":"Richtig. Der Code wird ohne Ausfuehrung manuell nachvollzogen - im Katalog 2025 ausdruecklich genannt."},{"text":"Regressionstest","is_correct":false,"rationale":"Falsch. Ein Regressionstest prueft nach einer Aenderung, ob bisher funktionierende Teile noch laufen."},{"text":"Integrationstest","is_correct":false,"rationale":"Falsch. Der Integrationstest prueft das Zusammenspiel mehrerer Komponenten, nicht eine einzelne Anweisungsfolge."},{"text":"Lasttest","is_correct":false,"rationale":"Falsch. Ein Lasttest prueft das Verhalten unter hoher Beanspruchung."}]}'::jsonb,
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
  'Nach der Korrektur eines Fehlers im Rechnungsmodul funktioniert ploetzlich der Export nicht mehr, der vorher lief.',
  'Welche Testart haette das verhindern koennen?',
  'Regression heisst Rueckschritt: Eine Aenderung macht etwas kaputt, das vorher funktionierte. Der Regressionstest laeuft deshalb nach JEDER Aenderung und wiederholt die bisherigen Tests.
Genau deshalb lohnt sich Testautomatisierung: Manuell wiederholt niemand hundert Tests nach jedem Bugfix. Automatisiert kostet es Minuten.',
  3,
  ARRAY['regressionstest']::text[],
  null,
  '{"choices":[{"text":"Regressionstest","is_correct":true,"rationale":"Richtig. Der Regressionstest wiederholt bereits bestandene Tests, um genau solche Nebenwirkungen zu entdecken."},{"text":"Abnahmetest","is_correct":false,"rationale":"Der Abnahmetest findet am Ende beim Kunden statt - dann ist der Schaden schon da."},{"text":"Lasttest","is_correct":false,"rationale":"Ein Lasttest prueft Verhalten unter Last, nicht die fachliche Korrektheit nach Aenderungen."},{"text":"Usability-Test","is_correct":false,"rationale":"Der prueft die Bedienbarkeit, nicht die Funktion."}]}'::jsonb,
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
  'Die Abgrenzung entscheidet sich an einer Frage: Wird ein ERFOLG geschuldet oder eine TAETIGKEIT?
- Werkvertrag: Erfolg. Es gibt eine Abnahme, und erst danach wird gezahlt. Typisch fuer Individualsoftware und Projekte mit Festpreis.
- Dienstvertrag: Taetigkeit. Bezahlt wird nach Aufwand, es gibt keine Abnahme. Typisch fuer Beratung, Support und Zeitverträge.
- Kaufvertrag: Uebereignung einer Sache, etwa Standardsoftware auf Datentraeger oder Hardware.
Fuer die Pruefung wichtig: Die Bezeichnung im Vertrag entscheidet nicht - massgeblich ist, was tatsaechlich geschuldet wird.',
  2,
  ARRAY['vertragsarten']::text[],
  null,
  '{"buckets":["Kaufvertrag","Werkvertrag","Dienstvertrag"],"match_items":[{"text":"Geschuldet wird ein konkreter Erfolg, zum Beispiel eine fertige, abnahmefaehige Software.","bucket":1,"rationale":"Erfolg geschuldet = Werkvertrag. Deshalb gibt es hier eine Abnahme."},{"text":"Geschuldet wird die Taetigkeit als solche, nicht ein bestimmtes Ergebnis.","bucket":2,"rationale":"Dienstvertrag: bezahlt wird die geleistete Arbeit, etwa bei Beratung oder Personalgestellung."},{"text":"Uebereignung einer Sache gegen Zahlung des Kaufpreises.","bucket":0,"rationale":"Der klassische Kaufvertrag, zum Beispiel beim Hardwareeinkauf."},{"text":"Die Verguetung wird mit der Abnahme faellig.","bucket":1,"rationale":"Typisch fuer den Werkvertrag - ohne Abnahme keine Faelligkeit."},{"text":"Ein externer Administrator wird stundenweise fuer Support bereitgestellt.","bucket":2,"rationale":"Bereitgestellt wird Arbeitszeit, kein definiertes Werk."},{"text":"Gewaehrleistung richtet sich nach dem Zustand der gelieferten Sache bei Gefahruebergang.","bucket":0,"rationale":"Sachmangelhaftung des Kaufrechts."}]}'::jsonb,
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
- Proprietaer: kostenpflichtig, Quellcode geschlossen.
- SaaS/Abo: Nutzungsrecht auf Zeit, Betrieb beim Anbieter.
Lizenzmodelle nach Zaehlweise: pro Geraet, pro benanntem Nutzer, pro gleichzeitigem Nutzer (concurrent), pro CPU/Core, nutzungsabhaengig.',
  2,
  ARRAY['lizenzen']::text[],
  null,
  '{"choices":[{"text":"Eine Einzelplatzlizenz berechtigt zur Installation auf einem bestimmten Arbeitsplatz.","is_correct":true,"rationale":"Die klassische Form - gebunden an ein Geraet oder einen benannten Nutzer."},{"text":"Bei einer Concurrent-User-Lizenz zaehlt die Zahl der gleichzeitigen Nutzer.","is_correct":true,"rationale":"Nicht die Zahl der installierten Kopien, sondern die gleichzeitige Nutzung ist begrenzt."},{"text":"Open-Source-Software darf immer kostenlos und uneingeschraenkt kommerziell genutzt werden.","is_correct":false,"rationale":"Falsch. Open Source heisst offener Quellcode, nicht bedingungslos frei. Copyleft-Lizenzen wie die GPL verpflichten dazu, Aenderungen unter derselben Lizenz weiterzugeben."},{"text":"Bei einem Software-Abonnement (SaaS) erwirbt man Nutzungsrechte auf Zeit, kein Eigentum.","is_correct":true,"rationale":"Laeuft das Abo aus, endet das Nutzungsrecht - ein wesentlicher Unterschied zum Kauf."},{"text":"Eine Volumenlizenz ist immer guenstiger als der Einzelkauf derselben Stueckzahl.","is_correct":false,"rationale":"In der Regel ja, aber \"immer\" ist falsch. Volumenlizenzen haben Mindestabnahmen und Laufzeiten, die sich bei kleinen Stueckzahlen nicht rechnen."},{"text":"Freeware ist kostenlos, der Quellcode ist aber nicht zwingend offen.","is_correct":true,"rationale":"Genau der Unterschied zu Open Source: kostenlos sagt nichts ueber den Quellcode."}]}'::jsonb,
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
  'Eine Auszubildende entwickelt waehrend ihrer Arbeitszeit ein Skript, das im Betrieb produktiv eingesetzt wird.',
  'Wie ist die urheberrechtliche Lage in Deutschland?',
  'Kern des deutschen Urheberrechts: Urheber ist immer die natuerliche Person, die das Werk geschaffen hat. Dieses Recht kann man weder verkaufen noch verschenken - nur vererben.
Was uebertragen wird, sind NUTZUNGSRECHTE: einfach (mehrere duerfen nutzen) oder ausschliesslich (nur einer). Bei Software, die in Erfuellung des Arbeitsvertrags entsteht, erhaelt der Arbeitgeber die ausschliesslichen Nutzungsrechte.',
  2,
  ARRAY['urheberrecht']::text[],
  null,
  '{"choices":[{"text":"Die Urheberin bleibt sie selbst, die Nutzungsrechte liegen aber beim Arbeitgeber.","is_correct":true,"rationale":"Richtig. Das Urheberrecht ist in Deutschland nicht uebertragbar; uebertragen werden nur Nutzungsrechte - bei Arbeitnehmern regelmaessig automatisch an den Arbeitgeber."},{"text":"Der Arbeitgeber wird automatisch Urheber der Software.","is_correct":false,"rationale":"Falsch. Urheber kann nur eine natuerliche Person sein, und das Urheberrecht selbst ist nicht uebertragbar."},{"text":"Die Auszubildende kann die Nutzung jederzeit untersagen.","is_correct":false,"rationale":"Falsch. Fuer im Arbeitsverhaeltnis geschaffene Software erwirbt der Arbeitgeber die Nutzungsrechte."},{"text":"Software ist urheberrechtlich nicht geschuetzt, nur patentierbar.","is_correct":false,"rationale":"Falsch. Computerprogramme sind ausdruecklich urheberrechtlich geschuetzt. Reine Software ist in Europa umgekehrt kaum patentierbar."}]}'::jsonb,
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
  'Mindestinhalte: Vertragsparteien, Leistungsbeschreibung, Verguetung, Termine, Mitwirkungspflichten des Auftraggebers, Abnahme, Gewaehrleistung, Haftung, Datenschutz/Geheimhaltung, Laufzeit und Kuendigung.
Die Mitwirkungspflichten werden am haeufigsten vergessen und fuehren am haeufigsten zu Streit: Wenn der Auftraggeber Testdaten oder Ansprechpartner nicht liefert, kann der Auftragnehmer den Termin nicht halten - ohne Regelung steht dann Aussage gegen Aussage.',
  1,
  ARRAY['vertragsbestandteile']::text[],
  null,
  '{"choices":[{"text":"Leistungsbeschreibung bzw. Verweis auf das Pflichtenheft","is_correct":true,"rationale":"Ohne beschriebene Leistung laesst sich spaeter nicht feststellen, ob erfuellt wurde."},{"text":"Verguetung und Zahlungsbedingungen","is_correct":true,"rationale":"Hoehe, Faelligkeit und Zahlungsziel gehoeren zwingend hinein."},{"text":"Termine und Fristen","is_correct":true,"rationale":"Ohne Termin gibt es keinen Verzug - und damit keine Handhabe bei Verspaetung."},{"text":"Regelungen zu Gewaehrleistung und Haftung","is_correct":true,"rationale":"Legt fest, wer bei Maengeln und Schaeden in welchem Umfang einsteht."},{"text":"Die Namen aller eingesetzten Entwickler","is_correct":false,"rationale":"Falsch. Das waere unpraktikabel - Personal wechselt. Geregelt werden hoechstens Qualifikationsanforderungen."},{"text":"Vereinbarungen zu Datenschutz und Vertraulichkeit","is_correct":true,"rationale":"Bei Zugriff auf personenbezogene Daten ist ein Auftragsverarbeitungsvertrag sogar Pflicht."}]}'::jsonb,
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
  'Ein SLA macht Servicequalitaet messbar und einklagbar. Die vier Groessen, die man auseinanderhalten muss:
- Servicezeit: wann der Service ueberhaupt erbracht wird (z. B. Mo-Fr 8-18 Uhr).
- Verfuegbarkeit: Anteil der Servicezeit ohne Stoerung.
- Reaktionszeit: bis zur ersten qualifizierten Rueckmeldung.
- Wiederherstellungszeit: bis die Stoerung behoben ist.
Typische Pruefungsfalle: "Reaktionszeit 1 Stunde" bedeutet NICHT, dass das Problem nach einer Stunde geloest ist.',
  2,
  ARRAY['sla']::text[],
  null,
  '{"choices":[{"text":"Verfuegbarkeit des Dienstes, meist als Prozentwert pro Zeitraum","is_correct":true,"rationale":"Die zentrale Kennzahl, zum Beispiel 99,5 % im Monat."},{"text":"Reaktionszeit - wie schnell auf eine Stoerung reagiert wird","is_correct":true,"rationale":"Reaktionszeit ist die Zeit bis zur ersten Rueckmeldung, nicht bis zur Loesung."},{"text":"Wiederherstellungszeit - wie schnell die Stoerung behoben sein muss","is_correct":true,"rationale":"Die zweite Zeitgroesse. Reaktions- und Wiederherstellungszeit werden staendig verwechselt."},{"text":"Servicezeiten, in denen die vereinbarten Werte gelten","is_correct":true,"rationale":"Ein SLA mit 15 Minuten Reaktionszeit ist wertlos, wenn unklar bleibt, ob das auch sonntags um 3 Uhr gilt."},{"text":"Den Quellcode der betriebenen Anwendung","is_correct":false,"rationale":"Falsch. Quellcode-Fragen regelt gegebenenfalls ein Hinterlegungsvertrag (Escrow), nicht das SLA."},{"text":"Folgen bei Nichteinhaltung, etwa Verguetungsminderung","is_correct":true,"rationale":"Ohne Konsequenz ist ein SLA eine Absichtserklaerung."}]}'::jsonb,
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
  'Ein SLA sichert eine Verfuegbarkeit von 99,5 % zu. Die vereinbarte Servicezeit betraegt 24 Stunden an 30 Tagen im Monat.',
  'Wie viele Minuten Ausfall sind in diesem Monat hoechstens zulaessig?',
  'Rechenweg:
1. Servicezeit im Monat = 30 Tage x 24 h x 60 min = 43.200 Minuten
2. Zulaessige Ausfallquote = 100 % - 99,5 % = 0,5 % = 0,005
3. Erlaubter Ausfall = 43.200 x 0,005 = 216 Minuten (3,6 Stunden)

Merke die Groessenordnungen - danach wird gern gefragt:
99 % = rund 7,2 Stunden Ausfall im Monat
99,5 % = rund 3,6 Stunden
99,9 % = rund 43 Minuten
Jede Neun kostet ungefaehr den Faktor 10 an Aufwand.',
  3,
  ARRAY['verfuegbarkeit']::text[],
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
  'Ein Anwender meldet, dass sein Drucker nicht mehr reagiert. Der Mitarbeiter am Telefon nimmt die Stoerung auf, prueft die Standardloesungen und kann sie nicht beheben.',
  'Was passiert als Naechstes im mehrstufigen Support?',
  'Die Supportstufen:
- 1st Level: Annahme, Klassifizierung, Loesung bekannter Standardfaelle. Ziel ist eine hohe Erstloesungsquote.
- 2nd Level: Fachspezialisten mit tieferem Systemwissen.
- 3rd Level: Hersteller oder Entwicklung, bei Fehlern im Produkt selbst.
Wichtig fuer die Pruefung: Das Ticket bleibt beim Eskalieren bestehen und wandert mit seiner kompletten Historie. Der Anwender behaelt einen Ansprechpartner - das nennt sich Ownership-Prinzip.',
  2,
  ARRAY['support_level']::text[],
  null,
  '{"choices":[{"text":"Eskalation an den 2nd-Level-Support mit dokumentiertem Ticket","is_correct":true,"rationale":"Richtig. Der 1st Level nimmt auf, klassifiziert und loest Standardfaelle; alles andere geht dokumentiert weiter nach oben."},{"text":"Das Ticket wird geschlossen, der Anwender meldet sich neu.","is_correct":false,"rationale":"Falsch. Ein ungeloestes Ticket wird nie geschlossen - der Vorgang und seine Historie muessen erhalten bleiben."},{"text":"Direkte Weitergabe an den Hersteller (3rd Level).","is_correct":false,"rationale":"Falsch. Die Stufen werden der Reihe nach durchlaufen. Der 3rd Level ist der Hersteller bzw. die Entwicklung und wird erst eingeschaltet, wenn der 2nd Level nicht weiterkommt."},{"text":"Der Anwender erhaelt Administratorrechte, um es selbst zu loesen.","is_correct":false,"rationale":"Falsch und sicherheitstechnisch fatal. Rechteausweitung ist keine Supportmassnahme."}]}'::jsonb,
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
  'Ein Lieferant hat eine Serverlieferung fuer den 1. Oktober fest zugesagt. Am 10. Oktober ist nichts geliefert.',
  'Welche Voraussetzung fuer Lieferverzug ist hier erfuellt?',
  'Verzug setzt voraus: faellige Leistung, Nichtleistung, Verschulden des Schuldners und grundsaetzlich eine Mahnung.
Die Mahnung entfaellt unter anderem, wenn ein Termin nach dem Kalender bestimmt ist ("Lieferung am 1. Oktober") oder wenn der Schuldner die Leistung ernsthaft und endgueltig verweigert.
Beim ZAHLUNGSverzug gilt zusaetzlich: Spaetestens 30 Tage nach Zugang einer Rechnung tritt Verzug auch ohne Mahnung ein - bei Verbrauchern nur, wenn darauf hingewiesen wurde.',
  2,
  ARRAY['verzug']::text[],
  null,
  '{"choices":[{"text":"Die Leistung ist faellig und der Termin kalendermaessig bestimmt - es braucht keine Mahnung.","is_correct":true,"rationale":"Richtig. Bei einem kalendermaessig festgelegten Termin tritt Verzug automatisch mit Fristablauf ein."},{"text":"Verzug tritt erst ein, wenn der Kunde dreimal gemahnt hat.","is_correct":false,"rationale":"Falsch. Drei Mahnungen sind ein Mythos aus der Praxis, keine Rechtsvoraussetzung."},{"text":"Verzug setzt immer eine schriftliche Mahnung voraus.","is_correct":false,"rationale":"Falsch. Eine Mahnung ist nur noetig, wenn kein kalendermaessig bestimmter Termin vereinbart wurde."},{"text":"Verzug tritt automatisch 30 Tage nach Vertragsschluss ein.","is_correct":false,"rationale":"Die 30-Tage-Regel gilt fuer den Zahlungsverzug nach Rechnungszugang, nicht fuer Lieferverzug."}]}'::jsonb,
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
  'In welcher Reihenfolge stehen dem Kunden die Maengelrechte beim Werkvertrag ueblicherweise zu?',
  'Der Vorrang der Nacherfuellung ist das Grundprinzip: Der Auftragnehmer bekommt zuerst die Gelegenheit, selbst nachzubessern. Erst wenn das scheitert oder eine gesetzte Frist fruchtlos verstreicht, stehen die weiteren Rechte offen.
Praktische Konsequenz: Wer sofort mindert oder einen anderen Dienstleister beauftragt, ohne eine Frist zur Nacherfuellung zu setzen, verliert seine Ansprueche. Deshalb gehoert in jede Mangelanzeige eine konkrete Frist.',
  3,
  ARRAY['maengelrechte']::text[],
  null,
  '{"ordered_items":["Nacherfuellung verlangen (Mangelbeseitigung oder Neuherstellung)","Nach erfolgloser Fristsetzung: Selbstvornahme und Ersatz der Kosten","Minderung der Verguetung oder Ruecktritt vom Vertrag","Schadensersatz bzw. Ersatz vergeblicher Aufwendungen"],"ordering_hint":"Vom vorrangigen zum nachrangigen Recht"}'::jsonb,
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
  'Was gehoert in ein Abnahmeprotokoll?',
  'An der Abnahme haengen vier Rechtsfolgen: Faelligkeit der Verguetung, Gefahruebergang, Beginn der Verjaehrungsfrist fuer Maengelansprueche und die Umkehr der Beweislast - danach muss der Kunde beweisen, dass ein Mangel schon bei Abnahme vorlag.
Deshalb ist das Abnahmeprotokoll kein Formalkram, sondern der wichtigste Zettel im Projekt. Wer bekannte Maengel nicht protokolliert, verliert die Rechte darauf.',
  2,
  ARRAY['abnahmeprotokoll']::text[],
  null,
  '{"choices":[{"text":"Datum, Ort und die anwesenden Personen beider Seiten","is_correct":true,"rationale":"Ohne Beteiligte und Datum ist das Protokoll als Nachweis wertlos."},{"text":"Gegenstand der Abnahme mit Verweis auf das Pflichtenheft","is_correct":true,"rationale":"Abgenommen wird gegen ein definiertes Soll - der Verweis stellt das her."},{"text":"Liste der festgestellten Maengel mit Fristen zur Beseitigung","is_correct":true,"rationale":"Der wichtigste Teil. Nicht protokollierte Maengel gelten bei vorbehaltloser Abnahme als akzeptiert."},{"text":"Erklaerung, ob die Abnahme erfolgt, unter Vorbehalt erfolgt oder verweigert wird","is_correct":true,"rationale":"Diese Erklaerung ist der eigentliche Rechtsakt."},{"text":"Unterschriften beider Vertragsparteien","is_correct":true,"rationale":"Erst die Unterschriften machen das Protokoll zum Nachweis."},{"text":"Die interne Kalkulation des Auftragnehmers","is_correct":false,"rationale":"Falsch. Die Kalkulation ist ein Geschaeftsgeheimnis des Auftragnehmers und hat im Protokoll nichts zu suchen."}]}'::jsonb,
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
  'Lewins Modell erklaert, warum Veraenderungen scheitern: Meist wird die erste oder die letzte Phase uebersprungen.
- Ohne "Unfreeze" fehlt die Einsicht, dass sich etwas aendern muss - die Betroffenen halten am Alten fest.
- Ohne "Refreeze" faellt die Organisation nach einigen Wochen in alte Gewohnheiten zurueck, weil der neue Zustand nie verankert wurde.
In der Change-Phase sinkt die Leistung typischerweise voruebergehend ab - das ist normal und kein Zeichen des Scheiterns.',
  2,
  ARRAY['lewin']::text[],
  null,
  '{"ordered_items":["Unfreeze - Auftauen: Veraenderungsbedarf verdeutlichen, Widerstaende ansprechen","Change - Veraendern: neue Ablaeufe einfuehren und begleiten","Refreeze - Einfrieren: den neuen Zustand stabilisieren und zum Standard machen"],"ordering_hint":"Von der Vorbereitung zur Verankerung"}'::jsonb,
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
  'Bei der Einfuehrung eines neuen Ticketsystems weigern sich mehrere erfahrene Mitarbeitende, das System zu nutzen.',
  'Welche Massnahmen sind geeignet, den Widerstand abzubauen?',
  'Widerstand ist kein Defekt der Mitarbeitenden, sondern eine Information: Er zeigt, dass Sinn, Koennen oder Beteiligung fehlen.
Die drei typischen Ursachen und ihre Gegenmittel:
- "Ich verstehe es nicht" -> informieren, Nutzen erklaeren.
- "Ich kann es nicht" -> schulen, begleiten.
- "Ich will es nicht" -> beteiligen, Bedenken ernst nehmen.
Anordnung und Sanktion sind das letzte Mittel, nicht das erste.',
  2,
  ARRAY['widerstand']::text[],
  null,
  '{"choices":[{"text":"Die Betroffenen fruehzeitig einbeziehen und ihre Erfahrung in die Gestaltung einfliessen lassen","is_correct":true,"rationale":"Beteiligung ist die wirksamste Massnahme - wer mitgestaltet hat, blockiert selten."},{"text":"Den Nutzen fuer die tägliche Arbeit konkret und nachvollziehbar erklaeren","is_correct":true,"rationale":"Widerstand entsteht oft aus fehlendem Sinn, nicht aus Bequemlichkeit."},{"text":"Schulungen und eine Begleitung in der Umstellungsphase anbieten","is_correct":true,"rationale":"Ein Teil des Widerstands ist schlicht Unsicherheit im Umgang mit dem Neuen."},{"text":"Die Nutzung per Anweisung durchsetzen und Verstoesse sanktionieren","is_correct":false,"rationale":"Falsch als erste Massnahme. Druck erzeugt Scheinanpassung: Das System wird formal benutzt und die eigentliche Arbeit laeuft weiter daneben."},{"text":"Erfahrene Mitarbeitende als Multiplikatoren gewinnen","is_correct":true,"rationale":"Wer die Skeptiker zu Vorbildern macht, dreht den Widerstand in Unterstuetzung."},{"text":"Das alte System sofort abschalten, um Ausweichen zu verhindern","is_correct":false,"rationale":"Falsch als alleinige Massnahme. Ein harter Schnitt ohne Vorbereitung erzeugt Chaos und verfestigt die Ablehnung."}]}'::jsonb,
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
  'Kaizen (japanisch: Veraenderung zum Besseren) steht fuer den kontinuierlichen Verbesserungsprozess (KVP). Kernideen: kleine Schritte statt grosser Spruenge, Beteiligung aller Mitarbeitenden, Standardisierung des Erreichten und Wiederholung.
Der Zusammenhang zum PDCA-Zyklus ist direkt: PDCA ist das Werkzeug, mit dem jeder einzelne Kaizen-Schritt durchlaufen wird.
Abgrenzung fuer die Pruefung: Kaizen = viele kleine Schritte, evolutionaer. Reengineering = ein grosser Schnitt, revolutionaer.',
  2,
  ARRAY['kaizen']::text[],
  null,
  '{"choices":[{"text":"Laufende Verbesserung in vielen kleinen Schritten, getragen von allen Mitarbeitenden","is_correct":true,"rationale":"Richtig. Die Summe vieler kleiner Schritte, nicht der eine grosse Wurf."},{"text":"Einmalige, grundlegende Neugestaltung der Geschaeftsprozesse","is_correct":false,"rationale":"Das ist Business Process Reengineering - der radikale Gegenentwurf zu Kaizen."},{"text":"Verbesserung ausschliesslich durch die Fuehrungsebene","is_correct":false,"rationale":"Falsch. Kaizen lebt davon, dass Verbesserungsvorschlaege von denen kommen, die die Arbeit taeglich machen."},{"text":"Ein Verfahren zur Fehlersuche im Quellcode","is_correct":false,"rationale":"Falsch. Kaizen ist eine Haltung zur Prozessverbesserung, kein Testverfahren."}]}'::jsonb,
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
values ('c-org-01', 'projektorganisation', 'Projekt (DIN 69901)', 'Vorhaben mit Einmaligkeit der Bedingungen, zeitlicher/finanzieller/personeller Begrenzung, eigener Organisation und Abgrenzung gegenueber anderen Vorhaben.', 'Vier Haken: einmalig, begrenzt, eigene Organisation, abgegrenzt. Keine Mindestgroesse, kein Mindestbudget.', '{}', 0)
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
values ('c-org-02', 'projektorganisation', 'Magisches Dreieck', 'Zeit, Kosten und Leistung/Qualitaet. Sind zwei Groessen fixiert, ist die dritte die abhaengige Variable.', 'In Pruefungsaufgaben steht die Loesung in der Angabe: Welche zwei Ecken werden als fest beschrieben?', '{}', 1)
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
values ('c-org-03', 'projektorganisation', 'SMART-Ziele', 'Spezifisch, Messbar, Attraktiv (akzeptiert), Realistisch, Terminiert.', 'Neu im Katalog 2025. "Die Software soll besser werden" ist kein SMARTes Ziel - es fehlt alles ausser S.', '{}', 2)
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
values ('c-org-04', 'projektorganisation', 'Reine Projektorganisation', 'Das Team wird vollstaendig aus der Linie herausgeloest. Die Projektleitung hat fachliche UND disziplinarische Weisungsbefugnis.', 'Viel Macht, viel Aufwand - und nach Projektende ein Rueckkehrproblem.', '{}', 3)
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
values ('c-org-05', 'projektorganisation', 'Matrix-Organisation', 'Weisungsbefugnis geteilt: fachlich beim Projekt, disziplinarisch in der Linie.', 'Der Normalfall - und die Dauerquelle von Prioritaetenkonflikten, weil jeder zwei Chefs hat.', '{}', 4)
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
values ('c-org-06', 'projektorganisation', 'Stabs-/Einflussorganisation', 'Die Projektleitung koordiniert und berichtet, hat aber kein Weisungsrecht.', 'Billig und zahnlos - das Gegenstueck zur reinen Projektorganisation.', '{}', 5)
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
values ('c-org-07', 'projektorganisation', 'Stakeholder', 'Alle Personen und Gruppen, die vom Projekt betroffen sind oder es beeinflussen koennen - intern wie extern.', 'Betriebsrat, Kunden, Lieferanten, Fachabteilungen, Behoerden.', '{}', 6)
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
values ('c-org-08', 'projektorganisation', 'Stakeholder-Matrix: hoher Einfluss, geringes Interesse', 'Strategie "zufriedenstellen": regelmaessig informieren, aber nicht mit Details ueberfrachten.', 'Das unintuitivste Feld - und deshalb das am haeufigsten gefragte.', '{}', 7)
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
values ('c-org-11', 'projektorganisation', 'Nicht-Ziele im Projektauftrag', 'Ausdrueckliche Festlegung, was NICHT zum Projektumfang gehoert.', 'Der billigste Schutz gegen Scope Creep - und der am haeufigsten vergessene Abschnitt.', '{}', 10)
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
values ('c-org-12', 'projektorganisation', 'Kick-off-Meeting', 'Startveranstaltung eines Projekts: Ziele, Rollen, Vorgehen und Spielregeln werden allen Beteiligten gemeinsam vorgestellt.', 'Zweck ist gemeinsames Verstaendnis, nicht Detailplanung.', '{}', 11)
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
values ('c-org-13', 'projektorganisation', 'Meilenstein', 'Ereignis mit der Dauer null, an dem ein definiertes Zwischenergebnis vorliegt. Verbraucht weder Zeit noch Ressourcen.', 'Binaer pruefbar formulieren: "Pflichtenheft unterzeichnet", nicht "Konzept weitgehend fertig".', '{}', 12)
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
values ('c-org-14', 'projektorganisation', 'Lenkungsausschuss', 'Entscheidungsgremium oberhalb der Projektleitung: gibt Budget frei, entscheidet ueber Change Requests und Eskalationen.', 'In Scrum nicht vorgesehen - dort entscheidet der Product Owner ueber Inhalte.', '{}', 13)
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
values ('c-org-15', 'projektorganisation', 'Aufgaben der Projektleitung', 'Planen, steuern, kontrollieren, Team fuehren, Stakeholder informieren, Risiken managen, Abweichungen melden.', 'Nicht: selbst programmieren. Die Projektleitung verantwortet das Wie-Viel und Wann, nicht die Umsetzung.', '{}', 14)
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
values ('c-vor-02', 'vorgehensmodelle', 'Wasserfallmodell', 'Streng sequenzielles Vorgehen: jede Phase endet mit einem freigegebenen Dokument, erst dann startet die naechste.', 'Voraussetzung: Anforderungen sind zu Projektbeginn vollstaendig bekannt.', '{}', 16)
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
values ('c-vor-03', 'vorgehensmodelle', 'Phasen des Wasserfallmodells', 'Analyse/Anforderungsdefinition, Entwurf, Implementierung, Test, Einfuehrung und Wartung.', null, '{}', 17)
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
values ('c-vor-05', 'vorgehensmodelle', 'Groesster Nachteil des Wasserfalls', 'Fehler aus der Analyse fallen erst im Test auf - dann muessen alle darauf aufbauenden Phasen korrigiert werden.', null, '{}', 19)
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
values ('c-vor-06', 'vorgehensmodelle', 'Vorteile des Wasserfalls', 'Klare Struktur, gute Planbarkeit, feste Kosten und Termine, einfache Fortschrittskontrolle, vollstaendige Dokumentation.', null, '{}', 20)
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
values ('c-vor-07', 'vorgehensmodelle', 'Wann Wasserfall, wann agil?', 'Anforderungen stabil und vertraglich fixiert -> Wasserfall. Anforderungen unklar oder veraenderlich -> agil.', 'Oeffentliche Ausschreibung = Wasserfall. Produktentwicklung mit unklarem Zielbild = Scrum.', '{}', 21)
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
values ('c-vor-08', 'vorgehensmodelle', 'Phasenmodell (4 Phasen)', 'Initiierung, Planung, Durchfuehrung/Steuerung, Abschluss.', 'Gilt modellunabhaengig fuer jedes Projekt - auch fuer ein agiles.', '{}', 22)
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
values ('c-vor-09', 'vorgehensmodelle', 'Iterativ-inkrementell', 'Iterativ = in wiederholten Durchlaeufen verfeinern. Inkrementell = in auslieferbaren Teilstuecken wachsen.', 'Scrum ist beides. Der Unterschied wird gern verwechselt.', '{}', 23)
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
values ('c-vor-10', 'vorgehensmodelle', 'Agiles Manifest: die vier Werte', 'Individuen und Interaktionen MEHR ALS Prozesse und Werkzeuge; funktionierende Software MEHR ALS umfassende Dokumentation; Zusammenarbeit mit dem Kunden MEHR ALS Vertragsverhandlung; Reagieren auf Veraenderung MEHR ALS Befolgen eines Plans.', '"Mehr als", nicht "statt". Agil heisst nicht dokumentationsfrei - das ist der haeufigste Pruefungsfehler.', '{}', 24)
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
values ('c-vor-12', 'vorgehensmodelle', 'Warum Phasen mit Dokumenten enden', 'Das Dokument ist das pruefbare Ergebnis und die Freigabegrundlage. Ohne Freigabe kein Phasenuebergang - so entsteht Verbindlichkeit.', null, '{}', 26)
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
values ('c-scr-02', 'agil_scrum', 'Product Owner', 'Verantwortet die Wertmaximierung des Produkts und die Reihenfolge im Product Backlog. Entscheidet allein ueber die Priorisierung.', 'Darf sich beraten lassen - aber niemand priorisiert gegen ihn.', '{}', 28)
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
values ('c-scr-03', 'agil_scrum', 'Scrum Master', 'Verantwortet die Wirksamkeit von Scrum: moderiert Events, raeumt Hindernisse weg, coacht Team und Organisation.', 'Kein Projektleiter, kein Vorgesetzter, priorisiert nichts.', '{}', 29)
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
values ('c-scr-06', 'agil_scrum', 'Commitments der Artefakte', 'Product Backlog -> Product Goal. Sprint Backlog -> Sprint Goal. Increment -> Definition of Done.', 'Wird gern gefragt, weil viele die DoD faelschlich dem Sprint Backlog zuordnen.', '{}', 32)
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
values ('c-scr-07', 'agil_scrum', 'Die fuenf Scrum-Events', 'Sprint (Container), Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective.', 'Refinement ist KEIN Event, sondern eine laufende Taetigkeit.', '{}', 33)
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
values ('c-scr-10', 'agil_scrum', 'Definition of Done', 'Teamweit gueltige Checkliste, wann ein Increment wirklich fertig und potenziell auslieferbar ist.', 'Gilt fuer JEDE Story. Nicht verwechseln mit Akzeptanzkriterien, die pro Story gelten.', '{}', 36)
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
values ('c-scr-11', 'agil_scrum', 'Akzeptanzkriterien', 'Fachliche, pruefbare Bedingungen einer einzelnen User Story.', 'Story-spezifisch. Die Definition of Done ist handwerklich und teamweit - beides muss erfuellt sein.', '{}', 37)
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
values ('c-scr-12', 'agil_scrum', 'User-Story-Format', 'Als <Rolle> moechte ich <Ziel>, um <Nutzen>.', 'Der "um ... zu"-Teil ist der wichtigste - und der am haeufigsten weggelassene.', '{}', 38)
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
values ('c-scr-13', 'agil_scrum', 'INVEST', 'Independent, Negotiable, Valuable, Estimable, Small, Testable - Qualitaetscheck fuer User Stories.', null, '{}', 39)
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
values ('c-scr-14', 'agil_scrum', 'Story Points', 'Relative Aufwandsschaetzung statt Stunden. Menschen vergleichen zuverlaessiger, als sie absolute Zeiten schaetzen.', null, '{}', 40)
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
values ('c-scr-15', 'agil_scrum', 'Velocity', 'Durchschnittlich pro Sprint abgeschlossene Story Points. Nur fertige (DoD erfuellte) Items zaehlen.', 'Restaufwand / Velocity = verbleibende Sprints, immer aufgerundet.', '{}', 41)
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
values ('c-scr-16', 'agil_scrum', 'Epic', 'Eine User Story, die zu gross fuer einen Sprint ist. Wird im Refinement in kleinere Stories geteilt.', null, '{}', 42)
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
values ('c-np-01', 'netzplan', 'FAZ', 'Fruehester Anfangszeitpunkt = groesster FEZ aller Vorgaenger. Startvorgang: 0.', 'Vorwaerts immer das MAXIMUM - der Vorgang startet erst, wenn der letzte Vorgaenger fertig ist.', '{}', 43)
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
values ('c-np-02', 'netzplan', 'FEZ', 'Fruehester Endzeitpunkt = FAZ + Dauer.', null, '{}', 44)
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
values ('c-np-03', 'netzplan', 'SEZ', 'Spaetester Endzeitpunkt = kleinster SAZ aller Nachfolger. Endvorgang: SEZ = Projektdauer.', 'Rueckwaerts immer das MINIMUM.', '{}', 45)
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
values ('c-np-04', 'netzplan', 'SAZ', 'Spaetester Anfangszeitpunkt = SEZ - Dauer.', null, '{}', 46)
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
values ('c-np-05', 'netzplan', 'Gesamtpuffer GP', 'GP = SAZ - FAZ = SEZ - FEZ. Zeit, um die ein Vorgang verschoben werden kann, ohne das Projektende zu gefaehrden.', 'Stimmen beide Formeln nicht ueberein, steckt ein Rechenfehler in der Rueckwaertsrechnung.', '{}', 47)
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
values ('c-np-06', 'netzplan', 'Freier Puffer FP', 'FP = kleinster FAZ der Nachfolger - eigener FEZ. Verschiebung, ohne den fruehesten Start des Nachfolgers anzutasten.', 'GP schaut aufs Projektende, FP schaut auf den Nachbarn. Es gilt immer FP <= GP.', '{}', 48)
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
values ('c-np-07', 'netzplan', 'Kritischer Pfad', 'Der laengste Weg durch den Netzplan. Alle Vorgaenge darauf haben Gesamtpuffer 0.', 'Verzoegerung dort schlaegt eins zu eins aufs Projektende durch.', '{}', 49)
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
values ('c-np-08', 'netzplan', 'Kann es mehrere kritische Pfade geben?', 'Ja. Mehrere gleich lange Wege sind alle kritisch - das Projekt ist dann besonders anfaellig.', null, '{}', 50)
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
values ('c-np-09', 'netzplan', 'Projektdauer im Netzplan', 'Der groesste FEZ im gesamten Plan - gleichbedeutend mit der Laenge des kritischen Pfads.', null, '{}', 51)
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
values ('c-np-10', 'netzplan', 'Reihenfolge der Netzplanrechnung', 'Erst komplett vorwaerts (FAZ/FEZ), dann komplett rueckwaerts (SEZ/SAZ), dann die Puffer. Nie mischen.', null, '{}', 52)
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
values ('c-np-11', 'netzplan', 'GP > 0 und FP = 0 - was heisst das?', 'Der Vorgang hat Luft bis zum Projektende, nimmt sie aber vollstaendig dem Nachfolger weg.', 'Der Lieblingsfall der Pruefer, weil er den Unterschied der Puffer erzwingt.', '{}', 53)
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
values ('c-np-12', 'netzplan', 'Vorgangsknoten-Netzplan (MPM)', 'Vorgaenge stehen in den Knoten, Pfeile zeigen die Abhaengigkeiten. Das in der AP1 uebliche Verfahren.', null, '{}', 54)
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
values ('c-np-13', 'netzplan', 'Vorgang auf dem kritischen Pfad verkuerzen', 'Verkuerzt das Projekt - aber nur so lange, bis ein anderer Weg kritisch wird. Danach verpufft die Verkuerzung.', 'Nach jedem Schritt neu rechnen: der kritische Pfad wandert.', '{}', 55)
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
values ('c-np-14', 'netzplan', 'Wo Ressourcen hingehoeren', 'Zuerst auf den kritischen Pfad. Vorgaenge mit hohem Puffer koennen warten oder Personal abgeben.', null, '{}', 56)
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
values ('c-np-15', 'netzplan', 'Netzplan vs. Balkenplan', 'Netzplan = Rechenmodell, macht Puffer und kritischen Pfad berechenbar. Balkenplan = Kommunikationsmittel, massstabsgetreu und ohne Erklaerung lesbar.', 'Mit dem Netzplan rechnen, mit dem Gantt reden.', '{}', 57)
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
values ('c-tp-01', 'terminplanung', 'Projektstrukturplan (PSP)', 'Zerlegung des Projekts in Teilprojekte, Arbeitspakete und Vorgaenge - die Grundlage jeder weiteren Planung.', 'Beantwortet das WAS, noch nicht das WANN.', '{}', 58)
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
values ('c-tp-03', 'terminplanung', 'Gantt-Diagramm', 'Balkenplan mit massstabsgetreuer Zeitachse. Auf einen Blick lesbar, zeigt Abhaengigkeiten und Puffer aber nicht direkt.', null, '{}', 60)
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
values ('c-tp-04', 'terminplanung', 'Meilensteintrendanalyse (MTA)', 'Traegt die geplanten Meilensteintermine ueber die Berichtszeitpunkte auf.', 'Waagerecht = im Plan. Steigend = Verzug. Fallend = frueher fertig. Zickzack = unsichere Planung.', '{}', 61)
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
values ('c-tp-05', 'terminplanung', 'Steigende MTA-Linie', 'Der Meilenstein verschiebt sich immer weiter nach hinten - Verzug.', 'Wird oft falsch herum gelesen. Steigend = spaeter, nicht frueher.', '{}', 62)
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
values ('c-tp-07', 'terminplanung', 'Dauer aus Aufwand berechnen', 'Dauer = Aufwand / (Anzahl Personen x Verfuegbarkeitsgrad).', '120 PT bei 4 Leuten zu 75 % sind nicht 30, sondern 40 Tage.', '{}', 64)
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
values ('c-tp-08', 'terminplanung', 'Verfuegbarkeitsgrad', 'Anteil der Arbeitszeit, der tatsaechlich dem Projekt zur Verfuegung steht - der Rest geht in Linie, Support, Urlaub.', 'In Pruefungsaufgaben fast immer der eigentliche Pruefpunkt.', '{}', 65)
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
values ('c-tp-09', 'terminplanung', 'Brooks Law', 'Zusaetzliches Personal in einem verspaeteten Projekt verzoegert es zunaechst weiter - Einarbeitung und Kommunikation kosten Zeit.', null, '{}', 66)
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
values ('c-tp-10', 'terminplanung', 'Vorwaerts- vs. Rueckwaertsterminierung', 'Vorwaerts: vom Starttermin aus rechnen, Ergebnis ist das fruehestmoegliche Ende. Rueckwaerts: vom Endtermin aus rechnen, Ergebnis ist der spaetestmoegliche Start.', null, '{}', 67)
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
values ('c-tp-11', 'terminplanung', 'Pufferzeit sinnvoll einsetzen', 'Puffer werden berechnet, nicht erfunden. Eine zusaetzliche Sicherheitsreserve ist etwas anderes als der Puffer aus dem Netzplan.', null, '{}', 68)
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
values ('c-tp-12', 'terminplanung', 'Ressourcenhistogramm', 'Stellt die Auslastung einer Ressource ueber die Zeit dar - macht Ueberlastspitzen sichtbar.', null, '{}', 69)
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
values ('c-tp-13', 'terminplanung', 'Gut formulierter Meilenstein', 'Binaer pruefbar: erreicht oder nicht. "Abnahmeprotokoll unterzeichnet" statt "Testphase fast fertig".', null, '{}', 70)
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
values ('c-tp-14', 'terminplanung', 'Soll-Ist-Vergleich', 'Gegenueberstellung von geplanten und tatsaechlichen Werten bei Terminen, Kosten und Leistung - Grundlage jeder Steuerung.', null, '{}', 71)
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
values ('c-ri-01', 'risikomanagement', 'Risikowert (Erwartungswert)', 'Risikowert = Eintrittswahrscheinlichkeit x Schadenshoehe.', '20 % x 80.000 Euro = 16.000 Euro. Das ist zugleich die Obergrenze fuer sinnvolle Gegenmassnahmen.', '{}', 72)
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
values ('c-ri-02', 'risikomanagement', 'Die vier Risikostrategien', 'Vermeiden, Vermindern, Ueberwaelzen, Akzeptieren.', null, '{}', 73)
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
values ('c-ri-05', 'risikomanagement', 'Risiko ueberwaelzen', 'Ein Dritter traegt das Risiko: Versicherung, Festpreisvertrag, Auslagerung an einen Dienstleister.', null, '{}', 76)
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
values ('c-ri-08', 'risikomanagement', 'Schwaeche der Risikomatrix', 'Sie behandelt "oft, aber harmlos" und "selten, aber katastrophal" gleich, wenn das Produkt gleich ist.', 'Deshalb gibt es Backups, obwohl Totalausfaelle selten sind.', '{}', 79)
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
values ('c-ri-09', 'risikomanagement', 'Existenzbedrohendes Risiko', 'Muss unabhaengig von der Wahrscheinlichkeit behandelt werden - ein Schaden, den man nicht ueberlebt, darf nicht eintreten.', null, '{}', 80)
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
values ('c-ri-10', 'risikomanagement', 'Risikoregister', 'Verzeichnis aller identifizierten Risiken mit Bewertung, Massnahme und verantwortlicher Person.', 'Hinein gehoeren ALLE identifizierten Risiken - erst die Bewertung entscheidet ueber Massnahmen.', '{}', 81)
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
values ('c-ri-11', 'risikomanagement', 'Restrisiko', 'Das Risiko, das nach allen Massnahmen uebrig bleibt. Es wird bewusst getragen und dokumentiert.', null, '{}', 82)
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
values ('c-ri-12', 'risikomanagement', 'Schritte des Risikomanagements', 'Identifizieren, bewerten, Massnahmen festlegen, ueberwachen - laufend, nicht einmalig zu Projektbeginn.', null, '{}', 83)
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
values ('c-ri-13', 'risikomanagement', 'Risiko vs. Problem', 'Ein Risiko kann eintreten (Zukunft, Wahrscheinlichkeit). Ein Problem ist bereits eingetreten (Gegenwart, Massnahme noetig).', null, '{}', 84)
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
values ('c-wi-01', 'pm_wirtschaftlichkeit', 'Nutzwertanalyse', 'Vergleicht Alternativen anhand gewichteter, auch nicht-monetaerer Kriterien. Teilnutzwert = Gewicht x Bewertung, Summe = Gesamtnutzwert.', 'Gewichte muessen zusammen 100 % ergeben. Kriterien VOR dem Blick auf die Angebote festlegen.', '{}', 85)
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
values ('c-wi-02', 'pm_wirtschaftlichkeit', 'Schwaeche der Nutzwertanalyse', 'Gewichtung und Bewertung sind subjektiv - wer das Wunschergebnis kennt, kann es ueber die Gewichte herbeifuehren.', null, '{}', 86)
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
values ('c-wi-03', 'pm_wirtschaftlichkeit', 'Amortisationsdauer', 'Investitionssumme / jaehrlicher Netto-Rueckfluss.', 'Netto heisst: Einsparung minus neue laufende Kosten.', '{}', 87)
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
values ('c-wi-05', 'pm_wirtschaftlichkeit', 'TCO', 'Total Cost of Ownership: alle Kosten ueber den gesamten Lebenszyklus - Anschaffung, Betrieb, Wartung, Schulung, Ausserbetriebnahme.', 'Nur Kosten, keine Ertraege. Ertraege gehoeren in die ROI-Rechnung.', '{}', 89)
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
values ('c-wi-06', 'pm_wirtschaftlichkeit', 'Break-Even-Point', 'Die Absatzmenge, bei der Erloese und Gesamtkosten gleich sind. Menge = Fixkosten / (Preis - variable Stueckkosten).', 'Der Nenner heisst Deckungsbeitrag pro Stueck.', '{}', 90)
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
values ('c-wi-07', 'pm_wirtschaftlichkeit', 'Deckungsbeitrag', 'Preis minus variable Kosten. Der Betrag, der zur Deckung der Fixkosten beitraegt.', null, '{}', 91)
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
values ('c-wi-08', 'pm_wirtschaftlichkeit', 'Fixkosten vs. variable Kosten', 'Fixkosten fallen unabhaengig von der Menge an (Miete, Gehaelter). Variable Kosten wachsen mit der Menge (Material, Lizenzen pro Nutzer).', null, '{}', 92)
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
values ('c-wi-09', 'pm_wirtschaftlichkeit', 'Make-or-Buy', 'Entscheidung zwischen Eigenfertigung und Fremdbezug - anhand von Kosten, Know-how, Kapazitaet, Abhaengigkeit und strategischer Bedeutung.', 'Nicht nur rechnen: Kern-Know-how gibt man nicht aus der Hand, auch wenn extern billiger waere.', '{}', 93)
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
values ('c-wi-10', 'pm_wirtschaftlichkeit', 'Effektivitaet vs. Effizienz', 'Effektivitaet = die richtigen Dinge tun (Wirksamkeit). Effizienz = die Dinge richtig tun (Wirtschaftlichkeit).', 'Effektiv ohne effizient ist teuer. Effizient ohne effektiv ist sinnlos.', '{}', 94)
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
values ('c-wi-12', 'pm_wirtschaftlichkeit', 'Vor- und Nachkalkulation', 'Vorkalkulation schaetzt vor dem Projekt, Nachkalkulation vergleicht danach Ist mit Soll.', 'Ohne Nachkalkulation schaetzt man beim naechsten Mal genauso falsch.', '{}', 96)
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
values ('c-wi-13', 'pm_wirtschaftlichkeit', 'Machbarkeitsanalyse', 'Prueft vor Projektstart technische, wirtschaftliche, rechtliche, organisatorische und terminliche Realisierbarkeit.', null, '{}', 97)
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
values ('c-wi-14', 'pm_wirtschaftlichkeit', 'Wirtschaftlichkeit', 'Verhaeltnis von Ertrag zu Aufwand. Ein Projekt ist wirtschaftlich, wenn der Nutzen die Kosten uebersteigt.', null, '{}', 98)
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
values ('c-wi-15', 'pm_wirtschaftlichkeit', 'Gemeinkosten', 'Kosten, die sich einem einzelnen Projekt nicht direkt zurechnen lassen (Miete, Verwaltung, IT). Sie werden ueber Zuschlagssaetze verteilt.', null, '{}', 99)
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
values ('c-ab-01', 'projektabschluss', 'Die drei Ebenen des Projektabschlusses', 'Sachlich-technisch (Abnahme, Uebergabe), kaufmaennisch (Schlussrechnung, Nachkalkulation), personell (Teamaufloesung, Wuerdigung).', 'Die personelle Ebene wird am haeufigsten vergessen - und ist die, an die sich das Team am laengsten erinnert.', '{}', 100)
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
values ('c-ab-02', 'projektabschluss', 'Lessons Learned', 'Systematische Sicherung der Erfahrungen, damit kuenftige Projekte davon profitieren.', 'Zeitnah, ohne Schuldzuweisung, dokumentiert an einem auffindbaren Ort - sonst wertlos.', '{}', 101)
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
values ('c-ab-03', 'projektabschluss', 'Reihenfolge beim Abschluss', 'Restarbeiten, Abnahme, Uebergabe an den Betrieb, Abschlussbericht, Lessons Learned, Teamaufloesung.', 'Abnahme VOR Uebergabe. Teamaufloesung ZULETZT - vorher braucht man die Leute noch.', '{}', 102)
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
values ('c-ab-04', 'projektabschluss', 'Inhalt des Projektabschlussberichts', 'Soll-Ist-Vergleich von Terminen, Kosten und Leistung, Zielerreichungsgrad, offene Punkte und Restrisiken, Lessons Learned, Uebergabe.', 'Nicht der Quellcode - der gehoert in die Versionsverwaltung, der Bericht verweist darauf.', '{}', 103)
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
values ('c-ab-06', 'projektabschluss', 'Uebergabe an den Betrieb', 'Benannte Verantwortliche, Betriebsdokumentation, Schulung und vereinbarter Support. Sonst bleibt das Projektteam ewig zustaendig.', null, '{}', 105)
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
values ('c-ab-07', 'projektabschluss', 'Nachkalkulation', 'Gegenueberstellung der geplanten und tatsaechlichen Kosten nach Projektende - Grundlage besserer Schaetzungen.', null, '{}', 106)
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
values ('c-ab-10', 'projektabschluss', 'Restarbeiten', 'Offene Punkte, die den Projektabschluss nicht verhindern, aber benannt und jemandem uebergeben werden muessen.', null, '{}', 109)
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
values ('c-ab-11', 'projektabschluss', 'Teamaufloesung', 'Rueckfuehrung in die Linie, Feedback und Wuerdigung der Leistung - erst nach Bericht und Lessons Learned.', null, '{}', 110)
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
values ('c-ab-12', 'projektabschluss', 'Projektdokumentation zum Abschluss', 'Zusammenfuehrung aller Ergebnisdokumente an einem Ort, damit Betrieb und Folgeprojekte darauf zugreifen koennen.', null, '{}', 111)
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
values ('th-org-1', 'projektorganisation', 'Was ein Projekt zum Projekt macht', 'Die DIN 69901 definiert vier Merkmale. Fehlt eines davon, ist es Tagesgeschaeft - egal wie aufwendig es sich anfuehlt.', ARRAY['Einmaligkeit der Bedingungen in ihrer Gesamtheit', 'Zielvorgabe mit zeitlicher, finanzieller und personeller Begrenzung', 'Eigene, projektspezifische Organisation', 'Abgrenzung gegenueber anderen Vorhaben', 'Nicht enthalten: eine Mindestgroesse oder ein Mindestbudget']::text[], 'Einmalig, begrenzt, eigene Organisation, abgegrenzt - vier Haken, sonst kein Projekt.', 45, 0)
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
values ('th-org-2', 'projektorganisation', 'Drei Organisationsformen in einer Minute', 'Die Frage ist immer dieselbe: Wie viel Macht hat die Projektleitung gegenueber der Linie?', ARRAY['Reine Projektorganisation: Team komplett aus der Linie geloest, Projektleitung hat volle Weisungsbefugnis. Schnell, aber teuer und nach Projektende gibt es ein Rueckkehrproblem.', 'Matrix: Weisungsbefugnis geteilt - fachlich beim Projekt, disziplinarisch in der Linie. Flexibel, aber Dauerkonflikt um Prioritaeten.', 'Stabs-/Einflussorganisation: Projektleitung koordiniert nur, ohne Weisungsrecht. Billig, aber zahnlos.']::text[], 'Viel Macht = viel Aufwand. Die Matrix ist der Kompromiss - und deshalb der Normalfall.', 45, 1)
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
values ('th-vor-1', 'vorgehensmodelle', 'Vorgehensmodelle im Katalog 2025', 'Der Pruefungskatalog ab 2025 kennt nur noch zwei Vorgehensmodelle: Wasserfall und Scrum. V-Modell, Spiralmodell, XP und Kanban sind gestrichen.', ARRAY['Wasserfall: streng sequenziell, jede Phase endet mit einem freigegebenen Dokument. Voraussetzung: Anforderungen sind zu Projektbeginn vollstaendig bekannt.', 'Phasen: Analyse, Entwurf, Implementierung, Test, Einfuehrung und Wartung.', 'Staerke: klare Struktur, gute Planbarkeit, feste Kosten und Termine.', 'Schwaeche: Fehler aus der Analyse fallen erst im Test auf. Rule of Ten - jede spaetere Phase verzehnfacht die Korrekturkosten.', 'Scrum als Gegenentwurf: kurze Zyklen, Anforderungen duerfen sich zwischen den Sprints aendern.', 'Entscheidungsregel: Anforderungen stabil und vertraglich fix -> Wasserfall. Anforderungen unklar oder veraenderlich -> Scrum.']::text[], 'Fuer die AP1 ab 2025 reichen zwei Modelle. Wer noch V-Modell und Spirale paukt, lernt an der Pruefung vorbei.', 45, 2)
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
values ('th-scr-1', 'agil_scrum', 'Scrum auf einer Karte', 'Drei Verantwortlichkeiten, drei Artefakte, fuenf Events. Mehr steht nicht im Scrum Guide.', ARRAY['Verantwortlichkeiten: Product Owner (WAS und Reihenfolge), Developers (WIE und wie viel), Scrum Master (DASS es funktioniert).', 'Artefakte mit Commitment: Product Backlog -> Product Goal, Sprint Backlog -> Sprint Goal, Increment -> Definition of Done.', 'Events: Sprint (Container), Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective. Refinement ist KEIN Event, sondern eine laufende Taetigkeit.', 'Timeboxen bei Monatssprint: Planning 8 h, Daily 15 min, Review 4 h, Retrospektive 3 h.']::text[], 'Review = Produkt, mit Stakeholdern. Retrospektive = Zusammenarbeit, nur das Team. Review kommt zuerst.', 45, 3)
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
values ('th-np-1', 'netzplan', 'Netzplan: die sechs Werte', 'Erst alles vorwaerts, dann alles rueckwaerts, dann die Puffer. In dieser Reihenfolge, nie gemischt.', ARRAY['Vorwaerts: FAZ = groesster FEZ aller Vorgaenger (Start: 0). FEZ = FAZ + Dauer.', 'Projektdauer = groesster FEZ im gesamten Plan.', 'Rueckwaerts: SEZ = kleinster SAZ aller Nachfolger (Endvorgang: SEZ = Projektdauer). SAZ = SEZ - Dauer.', 'Gesamtpuffer GP = SAZ - FAZ = SEZ - FEZ.', 'Freier Puffer FP = kleinster FAZ der Nachfolger - eigener FEZ.', 'Kritischer Pfad = alle Vorgaenge mit GP = 0, zugleich der laengste Weg.']::text[], 'Vorwaerts das MAXIMUM, rueckwaerts das MINIMUM. Wer das vertauscht, rechnet den halben Plan falsch.', 45, 4)
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
values ('th-np-2', 'netzplan', 'GP oder FP? Der Unterschied in 20 Sekunden', 'Beide Puffer sagen, wie viel Luft ein Vorgang hat - aber bis wohin, ist verschieden.', ARRAY['Gesamtpuffer: Verschiebung ohne das PROJEKTENDE zu gefaehrden. Kann aber den Nachfolger nach hinten druecken.', 'Freier Puffer: Verschiebung ohne den fruehesten Start des NACHFOLGERS anzutasten. Merkt sonst niemand.', 'Es gilt immer FP <= GP.', 'Auf dem kritischen Pfad sind beide null.', 'Typischer Fall: GP = 2, FP = 0. Luft bis zum Projektende vorhanden - aber nur, indem man sie dem Nachfolger wegnimmt.']::text[], 'GP schaut aufs Projektende, FP schaut auf den Nachbarn.', 45, 5)
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
values ('th-tp-1', 'terminplanung', 'Gantt, Meilenstein, MTA', 'Mit dem Netzplan rechnet man, mit dem Balkenplan redet man.', ARRAY['Gantt/Balkenplan: massstabsgetreue Zeitachse, auf einen Blick lesbar. Abhaengigkeiten und Puffer sind aber nicht direkt ablesbar.', 'Meilenstein: Ereignis mit Dauer null, an dem ein definiertes Zwischenergebnis vorliegt. Binaer pruefbar formulieren.', 'Meilensteintrendanalyse: geplante Termine ueber Berichtszeitpunkte auftragen. Waagerecht = im Plan, steigend = Verzug, fallend = frueher fertig, Zickzack = unsichere Planung.', 'Dauer = Aufwand / (Anzahl Personen x Verfuegbarkeitsgrad). Personentage sind Aufwand, Arbeitstage sind Dauer.']::text[], 'Steigende MTA-Linie heisst spaeter, nicht frueher. Das wird am haeufigsten verwechselt.', 45, 6)
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
values ('th-lh-1', 'anforderungen', 'Lastenheft vs. Pflichtenheft', 'Zwei Dokumente, zwei Absender, zwei Zeitpunkte.', ARRAY['Lastenheft: vom AUFTRAGGEBER, beschreibt das WAS und WOFUER, loesungsneutral. Grundlage der Ausschreibung.', 'Pflichtenheft: vom AUFTRAGNEHMER, beschreibt das WIE und WOMIT. Entsteht NACH der Vergabe und wird vom Auftraggeber genehmigt.', 'Abgenommen wird gegen das Pflichtenheft, nicht gegen das Lastenheft.', 'Funktional = "Das System tut X". Nicht-funktional = "Das System tut X schnell/sicher/verfuegbar/barrierefrei".', 'Gute Anforderung: eindeutig, vollstaendig, widerspruchsfrei, pruefbar, notwendig, priorisiert (MuSCoW).']::text[], 'LAstenheft = Auftraggeber verteilt die Last. PFlichtenheft = Auftragnehmer nennt seine Pflicht.', 45, 7)
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
values ('th-wi-1', 'pm_wirtschaftlichkeit', 'Rechnen im PM-Teil', 'Vier Rechnungen decken den Grossteil der Punkte ab.', ARRAY['Nutzwertanalyse: je Kriterium Gewicht x Bewertung, dann summieren. Gewichte muessen 100 % ergeben.', 'Amortisation: Investitionssumme / jaehrlicher Netto-Rueckfluss.', 'Bezugskalkulation: Listenpreis - Rabatt = Zieleinkaufspreis; - Skonto = Bareinkaufspreis; + Bezugskosten = Bezugspreis. Skonto nie vom Listenpreis, Bezugskosten nie vor dem Skonto.', 'Risikowert = Eintrittswahrscheinlichkeit x Schadenshoehe.', 'TCO = nur Kosten ueber den gesamten Lebenszyklus. Ertraege gehoeren in die ROI-Rechnung.']::text[], 'Bei Prozentaufgaben immer fragen: Prozent WOVON? Das ist der haeufigste Punktverlust.', 45, 8)
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
values ('th-qr-1', 'qualitaetsmanagement', 'Qualitaet und Risiko', 'Zwei Sortierungen, die fast jede Aufgabe abdecken.', ARRAY['Konstruktive QS = vorher, verhindert Fehler: Standards, Templates, Werkzeuge, Schulung, Frameworks.', 'Analytische QS = nachher, findet Fehler: Test, Review, Inspektion, statische Analyse, Audit.', 'Risikostrategien: Vermeiden (Ursache weg), Vermindern (Wahrscheinlichkeit oder Auswirkung runter), Ueberwaelzen (Versicherung, Festpreis), Akzeptieren (bewusst und dokumentiert).', 'Testfrage Vermeiden vs. Vermindern: Kann das Risiko danach noch eintreten? Ja -> vermindert. Nein -> vermieden.']::text[], 'Test findet Fehler, Standard verhindert sie. Das ist die ganze Unterscheidung.', 45, 9)
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
values ('th-ab-1', 'projektabschluss', 'Projektabschluss richtig', 'Drei Ebenen - die dritte wird am haeufigsten vergessen.', ARRAY['Sachlich-technisch: Restarbeiten, Abnahme mit Protokoll, Uebergabe an den Betrieb.', 'Kaufmaennisch: Schlussrechnung, Nachkalkulation, Projekt buchhalterisch schliessen.', 'Personell: Team aufloesen, Rueckfuehrung in die Linie, Wuerdigung der Leistung.', 'Lessons Learned: zeitnah, ohne Schuldzuweisung, dokumentiert an einem auffindbaren Ort.', 'Reihenfolge: Abnahme vor Uebergabe, Teamaufloesung zuletzt.']::text[], 'Wer das Team vor dem Abschlussbericht aufloest, bekommt keinen brauchbaren Bericht.', 45, 10)
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
