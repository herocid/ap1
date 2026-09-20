import '../models/question.dart';

/// Kurzform fuer eine Antwortoption.
Choice _c(String text, bool correct, String rationale) =>
    Choice(text: text, isCorrect: correct, rationale: rationale);

/// Projektorganisation, Vorgehensmodelle, agiles Arbeiten.
///
/// Alle Aufgaben sind eigene Formulierungen im Stil der AP1 - keine
/// Originalaufgaben der IHK (die sind urheberrechtlich geschuetzt).
final List<Question> seedGrundlagen = [
  // ---------------------------------------------------------------- Organisation
  Question(
    id: 'org-001',
    topicId: 'projektorganisation',
    kind: QuestionKind.multiple,
    difficulty: 1,
    tags: ['din69901', 'projektbegriff'],
    prompt:
        'Welche Merkmale muessen nach DIN 69901 erfuellt sein, damit ein Vorhaben '
        'als Projekt gilt?',
    choices: [
      _c('Einmaligkeit der Bedingungen in ihrer Gesamtheit', true,
          'Kernmerkmal. Ein Vorhaben, das jeden Monat identisch ablaeuft, ist Tagesgeschaeft - kein Projekt.'),
      _c('Zeitliche, finanzielle und personelle Begrenzung', true,
          'Ein Projekt hat einen definierten Anfang und ein definiertes Ende sowie ein festes Budget.'),
      _c('Eine eigene, projektspezifische Organisation', true,
          'Projektleitung, Team und Entscheidungswege werden eigens fuer das Vorhaben festgelegt.'),
      _c('Mindestens fuenf beteiligte Mitarbeitende', false,
          'Falsch. Die DIN nennt keine Mindestgroesse. Auch ein Zwei-Personen-Vorhaben kann ein Projekt sein.'),
      _c('Ein Budget von mindestens 50.000 Euro', false,
          'Falsch. Es gibt keine Wertgrenze in der Norm. Unternehmen setzen intern manchmal Schwellen - das ist aber keine Definition.'),
      _c('Abgrenzung gegenueber anderen Vorhaben', true,
          'Das Projekt muss inhaltlich und organisatorisch klar von der Linie und von anderen Projekten trennbar sein.'),
    ],
    explanation:
        'Merksatz: E-Z-O-A - Einmaligkeit, Zielvorgabe mit Begrenzung, eigene '
        'Organisation, Abgrenzung. Groesse und Budget sind bewusst nicht Teil '
        'der Definition; sonst waere jede Norm laendes- und branchenabhaengig.',
  ),

  Question(
    id: 'org-002',
    topicId: 'projektorganisation',
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['aufbauorganisation'],
    prompt:
        'Ordne die Aussagen der passenden Form der Projektorganisation zu.',
    buckets: ['Reine Projektorganisation', 'Matrix-Organisation', 'Stabs-/Einflussorganisation'],
    matchItems: const [
      MatchItem(
        text: 'Mitarbeitende werden vollstaendig aus der Linie herausgeloest.',
        bucket: 0,
        rationale: 'Genau das ist das Kennzeichen der reinen (autonomen) Projektorganisation.',
      ),
      MatchItem(
        text: 'Die Projektleitung hat volle fachliche und disziplinarische Weisungsbefugnis.',
        bucket: 0,
        rationale: 'Nur hier ist die Weisungsbefugnis ungeteilt.',
      ),
      MatchItem(
        text: 'Weisungsbefugnis ist zwischen Linien- und Projektleitung geteilt.',
        bucket: 1,
        rationale: 'Der typische Kompromiss - und die typische Konfliktquelle der Matrix.',
      ),
      MatchItem(
        text: 'Hohes Konfliktpotenzial durch zwei Vorgesetzte pro Person.',
        bucket: 1,
        rationale: 'Das klassische Matrix-Problem: zwei Chefs, widerspruechliche Prioritaeten.',
      ),
      MatchItem(
        text: 'Die Projektleitung koordiniert nur und kann keine Anweisungen geben.',
        bucket: 2,
        rationale: 'Die Stabsstelle berichtet und koordiniert, entscheidet aber nicht.',
      ),
      MatchItem(
        text: 'Geringster organisatorischer Aufwand, dafuer schwache Durchsetzungskraft.',
        bucket: 2,
        rationale: 'Vorteil und Nachteil der Einflussorganisation in einem Satz.',
      ),
    ],
    explanation:
        'Faustregel fuer die Pruefung: Je mehr Macht die Projektleitung hat, '
        'desto teurer und stoerender ist die Organisationsform fuer die Linie. '
        'Rein = viel Macht, hoher Aufwand. Stab = wenig Macht, wenig Aufwand. '
        'Matrix liegt dazwischen und wird am haeufigsten gewaehlt.',
  ),

  Question(
    id: 'org-003',
    topicId: 'projektorganisation',
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['stakeholder'],
    scenario:
        'Bei der Einfuehrung eines neuen Ticketsystems hat der Betriebsrat hohen '
        'Einfluss auf die Entscheidung, zeigt bislang aber wenig Interesse am '
        'Projekt.',
    prompt:
        'Welche Strategie sieht die Stakeholder-Matrix (Einfluss/Interesse) fuer '
        'diese Gruppe vor?',
    choices: [
      _c('Zufriedenstellen - regelmaessig informieren, aber nicht ueberfrachten', true,
          'Richtig. Hoher Einfluss + geringes Interesse = "keep satisfied". Die Gruppe kann das Projekt kippen, will aber keine Detailflut.'),
      _c('Eng einbinden - in alle Entscheidungen einbeziehen', false,
          'Das gilt fuer hohen Einfluss UND hohes Interesse. Hier wuerde es den Betriebsrat mit Details ueberfordern und Widerstand erzeugen.'),
      _c('Beobachten - minimaler Aufwand', false,
          'Das gilt nur bei geringem Einfluss UND geringem Interesse. Wer den Betriebsrat so behandelt, erlebt spaetestens bei der Mitbestimmung eine Vollbremsung.'),
      _c('Informieren - ausfuehrlich ueber Fortschritte berichten', false,
          'Das ist die Strategie fuer geringen Einfluss und hohes Interesse, z. B. interessierte Fachanwender.'),
    ],
    explanation:
        'Die vier Felder der Stakeholder-Matrix:\n'
        '- Einfluss hoch / Interesse hoch -> eng einbinden (manage closely)\n'
        '- Einfluss hoch / Interesse niedrig -> zufriedenstellen (keep satisfied)\n'
        '- Einfluss niedrig / Interesse hoch -> informieren (keep informed)\n'
        '- Einfluss niedrig / Interesse niedrig -> beobachten (monitor)\n'
        'In der Pruefung wird fast immer nach dem Feld "hoher Einfluss, geringes '
        'Interesse" gefragt, weil es das unintuitivste ist.',
  ),

  Question(
    id: 'org-004',
    topicId: 'projektorganisation',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['projektauftrag'],
    prompt: 'Welche Angaben gehoeren zwingend in einen Projektauftrag?',
    choices: [
      _c('Projektziel und messbare Abnahmekriterien', true,
          'Ohne messbares Ziel ist spaeter nicht entscheidbar, ob das Projekt erfolgreich war.'),
      _c('Benannte Projektleitung mit Befugnissen', true,
          'Der Auftrag legitimiert die Projektleitung - sonst hat sie im Unternehmen keinen Stand.'),
      _c('Budget- und Terminrahmen', true,
          'Die beiden Eckpunkte des magischen Dreiecks neben dem Leistungsumfang.'),
      _c('Vollstaendige technische Systemarchitektur', false,
          'Falsch. Die Architektur entsteht erst in der Planungs-/Entwurfsphase. Im Auftrag steht das WAS, nicht das WIE.'),
      _c('Nicht-Ziele bzw. Abgrenzung des Projektumfangs', true,
          'Oft unterschaetzt: Was ausdruecklich NICHT Teil des Projekts ist, verhindert spaeteren Scope Creep.'),
      _c('Der fertige Netzplan aller Vorgaenge', false,
          'Falsch. Der Netzplan ist ein Ergebnis der Planungsphase, nicht Voraussetzung des Auftrags.'),
    ],
    explanation:
        'Der Projektauftrag ist die Geburtsurkunde des Projekts: Ziel, Nicht-Ziel, '
        'Rahmen (Zeit/Budget), Verantwortliche. Alles, was Detailplanung ist '
        '(Netzplan, Architektur, Arbeitspakete), kommt danach.',
  ),

  Question(
    id: 'org-005',
    topicId: 'projektorganisation',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['magisches_dreieck'],
    scenario:
        'Zwei Wochen vor dem Releasetermin faellt auf, dass ein Modul mehr Aufwand '
        'braucht als geplant. Der Termin ist vertraglich fixiert, zusaetzliches '
        'Budget gibt es nicht.',
    prompt: 'Welche Konsequenz ergibt sich zwangslaeufig aus dem magischen Dreieck?',
    choices: [
      _c('Der Leistungsumfang muss reduziert werden.', true,
          'Richtig. Zeit und Kosten sind fixiert - im Dreieck bleibt nur die dritte Groesse, der Umfang (Qualitaet/Leistung), als Stellhebel.'),
      _c('Die Qualitaetssicherung kann entfallen, ohne den Umfang zu aendern.', false,
          'Das ist keine neutrale Option: QS zu streichen ist selbst eine Reduzierung der Qualitaet - also ebenfalls eine Aenderung der dritten Groesse, nur eine besonders teure.'),
      _c('Mehr Personal loest das Problem ohne Nebenwirkung.', false,
          'Erstens kostet mehr Personal Budget (das es nicht gibt), zweitens gilt Brooks Law: zusaetzliche Leute in einem spaeten Projekt verzoegern es zunaechst weiter.'),
      _c('Das Projekt muss abgebrochen werden.', false,
          'Ein Abbruch ist eine mögliche Managemententscheidung, aber nicht die zwangslaeufige Folge des Dreiecks. Gefragt war die logische Konsequenz.'),
    ],
    explanation:
        'Magisches Dreieck: Zeit, Kosten, Leistung/Qualitaet. Sind zwei Groessen '
        'fixiert, ist die dritte die abhaengige Variable. In Pruefungsaufgaben '
        'steht die Loesung immer in der Aufgabenstellung: schau, welche zwei '
        'Ecken als "fest" beschrieben sind.',
  ),

  // ------------------------------------------------------------ Vorgehensmodelle
  Question(
    id: 'vor-001',
    topicId: 'vorgehensmodelle',
    kind: QuestionKind.ordering,
    difficulty: 1,
    tags: ['wasserfall'],
    prompt:
        'Bringe die Phasen des Wasserfallmodells in die richtige Reihenfolge.',
    orderingHint: 'Von der ersten zur letzten Phase',
    orderedItems: const [
      'Analyse / Anforderungsdefinition',
      'Entwurf (Design)',
      'Implementierung',
      'Test / Verifikation',
      'Einfuehrung und Wartung',
    ],
    explanation:
        'Das Wasserfallmodell laeuft streng sequenziell: jede Phase endet mit '
        'einem freigegebenen Dokument, erst dann startet die naechste. Das ist '
        'zugleich sein groesster Nachteil - Fehler aus der Analyse fallen erst '
        'im Test auf, und dann ist die Korrektur am teuersten.',
  ),

  Question(
    id: 'vor-002',
    topicId: 'vorgehensmodelle',
    // V-Modell ist ab 2025 nicht mehr Teil des AP1-Katalogs. Die Teststufen
    // selbst bleiben relevant - dafuer gibt es eigene Aufgaben im Thema Testen.
    catalogStatus: CatalogStatus.removed2025,
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['v-modell'],
    prompt:
        'Welcher Testart steht im V-Modell die Phase "Anforderungsdefinition" '
        'gegenueber?',
    choices: [
      _c('Abnahmetest', true,
          'Richtig. Die oberste linke Ebene (Anforderungen des Auftraggebers) wird gegen die oberste rechte Ebene (Abnahmetest durch den Auftraggeber) geprueft.'),
      _c('Modultest', false,
          'Der Modul-/Unittest liegt auf der untersten Ebene und prueft gegen die Modulspezifikation bzw. den Feinentwurf.'),
      _c('Integrationstest', false,
          'Der Integrationstest gehoert zum Grobentwurf/Architektur - er prueft das Zusammenspiel der Komponenten.'),
      _c('Systemtest', false,
          'Der Systemtest gehoert zur Systemspezifikation, also eine Ebene unterhalb der Anforderungsdefinition. Er prueft in der Testumgebung, der Abnahmetest beim Kunden.'),
    ],
    explanation:
        'Die Ebenen des V-Modells von oben nach unten:\n'
        'Anforderungsdefinition <-> Abnahmetest\n'
        'Systemspezifikation <-> Systemtest\n'
        'Architektur/Grobentwurf <-> Integrationstest\n'
        'Feinentwurf/Modulspez. <-> Modultest (Unittest)\n'
        'Merkhilfe: gleiche Hoehe im V = zusammengehoeriges Paar. Je hoeher, '
        'desto naeher am Kunden.',
  ),

  Question(
    id: 'vor-003',
    topicId: 'vorgehensmodelle',
    // Vergleicht Spiralmodell und V-Modell mit - beide ab 2025 gestrichen.
    catalogStatus: CatalogStatus.removed2025,
    kind: QuestionKind.matching,
    difficulty: 2,
    tags: ['modellvergleich'],
    prompt: 'Ordne jede Aussage dem Vorgehensmodell zu, das sie am besten beschreibt.',
    buckets: ['Wasserfall', 'V-Modell', 'Spiralmodell', 'Scrum'],
    matchItems: const [
      MatchItem(
        text: 'Streng sequenziell, jede Phase endet mit einem Dokument.',
        bucket: 0,
        rationale: 'Das Grundprinzip des Wasserfalls.',
      ),
      MatchItem(
        text: 'Jeder Entwicklungsstufe ist eine passende Teststufe zugeordnet.',
        bucket: 1,
        rationale: 'Das ist genau die Erweiterung, die das V-Modell gegenueber dem Wasserfall bringt.',
      ),
      MatchItem(
        text: 'Wiederholte Zyklen mit expliziter Risikoanalyse zu Beginn jedes Zyklus.',
        bucket: 2,
        rationale: 'Die Risikoanalyse pro Zyklus ist das Markenzeichen des Spiralmodells nach Boehm.',
      ),
      MatchItem(
        text: 'Lieferung eines nutzbaren Inkrements am Ende jedes Sprints.',
        bucket: 3,
        rationale: 'Das Increment ist ein Scrum-Artefakt; es muss die Definition of Done erfuellen.',
      ),
      MatchItem(
        text: 'Anforderungen muessen zu Projektbeginn vollstaendig bekannt sein.',
        bucket: 0,
        rationale: 'Die zentrale Voraussetzung - und Schwaeche - des Wasserfalls.',
      ),
      MatchItem(
        text: 'Priorisierung der Arbeit erfolgt fortlaufend durch eine Rolle mit Produktverantwortung.',
        bucket: 3,
        rationale: 'Der Product Owner verantwortet die Reihenfolge im Product Backlog.',
      ),
    ],
    explanation:
        'Fuer die Pruefung reicht je ein Erkennungsmerkmal pro Modell: '
        'Wasserfall = sequenziell, V-Modell = Teststufen-Paare, Spiralmodell = '
        'Risikoanalyse pro Zyklus, Scrum = Inkremente in festen Sprints.',
  ),

  Question(
    id: 'vor-004',
    topicId: 'vorgehensmodelle',
    kind: QuestionKind.multiple,
    difficulty: 2,
    tags: ['agil_vs_klassisch'],
    scenario:
        'Ein Kunde moechte eine Web-Anwendung, hat aber nur eine grobe Vorstellung '
        'vom Funktionsumfang und erwartet, dass sich die Anforderungen waehrend '
        'der Entwicklung noch aendern.',
    prompt: 'Welche Argumente sprechen hier fuer ein agiles Vorgehen?',
    choices: [
      _c('Anforderungen koennen zwischen den Iterationen angepasst werden.', true,
          'Genau der Fall aus dem Szenario: unklare, veraenderliche Anforderungen sind das Kernargument fuer agil.'),
      _c('Der Kunde sieht nach jeder Iteration lauffaehige Software.', true,
          'Frueher Feedback-Zyklus. Fehlannahmen fallen nach Wochen auf, nicht nach Monaten.'),
      _c('Das Projektbudget laesst sich von Anfang an exakt festschreiben.', false,
          'Falsch - das ist eine Staerke des klassischen Vorgehens. Agil arbeitet eher mit festem Budget und variablem Umfang.'),
      _c('Der Dokumentationsaufwand entfaellt vollstaendig.', false,
          'Falsch. Das agile Manifest sagt "funktionierende Software MEHR ALS umfassende Dokumentation" - nicht "statt". Dokumentation wird reduziert, nicht abgeschafft.'),
      _c('Das Risiko einer kompletten Fehlentwicklung sinkt.', true,
          'Durch kurze Zyklen und regelmaessige Abnahme kann man maximal eine Iteration in die falsche Richtung laufen.'),
      _c('Ein vollstaendiges Pflichtenheft ist zu Projektbeginn erforderlich.', false,
          'Falsch, das ist klassisches Vorgehen. Agil startet mit einem priorisierten Backlog, das sich weiterentwickelt.'),
    ],
    explanation:
        'Entscheidungsregel: Sind die Anforderungen stabil und der Umfang '
        'vertraglich fix (z. B. Ausschreibung der oeffentlichen Hand), ist '
        'klassisch richtig. Sind sie unklar oder veraenderlich, ist agil '
        'richtig. Der haeufigste Fehler in der Pruefung ist die Behauptung, '
        'agil brauche keine Dokumentation.',
  ),

  Question(
    id: 'vor-005',
    topicId: 'vorgehensmodelle',
    kind: QuestionKind.single,
    difficulty: 3,
    tags: ['wasserfall', 'fehlerkosten'],
    prompt:
        'Warum sind Fehler aus der Analysephase im Wasserfallmodell besonders teuer?',
    choices: [
      _c('Weil sie erst in der Testphase auffallen und dann alle darauf aufbauenden Phasen korrigiert werden muessen.', true,
          'Richtig. Der Aufwand zur Fehlerbehebung steigt mit jeder Phase etwa um den Faktor 10 (Rule of Ten).'),
      _c('Weil die Analysephase das teuerste Personal bindet.', false,
          'Die Personalkosten der Analyse sind nicht der Punkt. Entscheidend ist die Fortpflanzung des Fehlers durch alle Folgephasen.'),
      _c('Weil das Wasserfallmodell keine Testphase vorsieht.', false,
          'Sachlich falsch: Test ist eine eigene Phase im Wasserfall. Nur liegt sie eben am Ende.'),
      _c('Weil Analysefehler die Hardwarebeschaffung betreffen.', false,
          'Das ist ein Spezialfall, keine allgemeine Begruendung.'),
    ],
    explanation:
        'Rule of Ten: Ein Fehler, der in der Analyse 1 Euro kostet, kostet im '
        'Entwurf 10, in der Implementierung 100 und beim Kunden 1.000 Euro. '
        'Genau dagegen arbeiten V-Modell (frueh definierte Tests) und agile '
        'Modelle (kurze Feedback-Schleifen).',
  ),

  // ------------------------------------------------------------------ Scrum
  Question(
    id: 'scr-001',
    topicId: 'agil_scrum',
    kind: QuestionKind.single,
    difficulty: 1,
    tags: ['scrum', 'rollen'],
    prompt: 'Wer entscheidet in Scrum ueber die Reihenfolge im Product Backlog?',
    choices: [
      _c('Product Owner', true,
          'Richtig. Der Product Owner verantwortet die Wertmaximierung und damit die Priorisierung. Er darf sich beraten lassen, entscheidet aber allein.'),
      _c('Scrum Master', false,
          'Der Scrum Master verantwortet die Wirksamkeit von Scrum - er moderiert, raeumt Hindernisse weg und priorisiert gerade nicht.'),
      _c('Die Developers', false,
          'Die Developers entscheiden, WIE und wie viel sie in einen Sprint nehmen, nicht in welcher Reihenfolge der Product Owner den Wert sieht.'),
      _c('Der Lenkungsausschuss', false,
          'Ein Lenkungsausschuss ist ein Gremium des klassischen Projektmanagements und in Scrum nicht vorgesehen.'),
    ],
    explanation:
        'Kurzformel: Product Owner = WAS und in welcher Reihenfolge. '
        'Developers = WIE und wie viel. Scrum Master = DASS es funktioniert.',
  ),

  Question(
    id: 'scr-002',
    topicId: 'agil_scrum',
    kind: QuestionKind.ordering,
    difficulty: 2,
    tags: ['scrum', 'events'],
    prompt:
        'Bringe die Scrum-Events in die Reihenfolge, in der sie innerhalb eines '
        'Sprints stattfinden.',
    orderingHint: 'Vom Sprintbeginn bis zum Sprintende',
    orderedItems: const [
      'Sprint Planning',
      'Daily Scrum (taeglich)',
      'Sprint Review',
      'Sprint Retrospective',
    ],
    explanation:
        'Der Sprint selbst ist der Container fuer alle anderen Events. '
        'Wichtig fuer die Pruefung: Das Review kommt VOR der Retrospektive. '
        'Im Review geht es um das Produkt (mit Stakeholdern), in der '
        'Retrospektive um die Zusammenarbeit (nur das Scrum Team). '
        'Das Refinement ist kein eigenes Event, sondern eine laufende Taetigkeit.',
  ),

  Question(
    id: 'scr-003',
    topicId: 'agil_scrum',
    kind: QuestionKind.single,
    difficulty: 1,
    tags: ['scrum', 'timebox'],
    prompt:
        'Wie lang ist die Timebox des Daily Scrum bei einem vierwoechigen Sprint?',
    choices: [
      _c('15 Minuten', true,
          'Richtig. Das Daily ist immer auf 15 Minuten begrenzt - unabhaengig von der Sprintlaenge. Das ist die einzige Timebox, die nicht mitwaechst.'),
      _c('30 Minuten', false,
          'Nein. Diese Zahl verwechselt man leicht mit der anteiligen Skalierung anderer Events.'),
      _c('1 Stunde', false,
          'Eine Stunde waere die Groessenordnung einer Retrospektive bei kurzen Sprints, nicht des Dailys.'),
      _c('Vier Stunden', false,
          'Vier Stunden ist die Obergrenze des Sprint Reviews bei einem Monatssprint.'),
    ],
    explanation:
        'Timeboxen bei einem Monatssprint (kuerzere Sprints -> anteilig kuerzer):\n'
        '- Sprint Planning: max. 8 Stunden\n'
        '- Daily Scrum: 15 Minuten (immer)\n'
        '- Sprint Review: max. 4 Stunden\n'
        '- Sprint Retrospective: max. 3 Stunden\n'
        'Merkhilfe 8-4-3 und das Daily als Konstante.',
  ),

  Question(
    id: 'scr-004',
    topicId: 'agil_scrum',
    kind: QuestionKind.matching,
    difficulty: 3,
    tags: ['scrum', 'artefakte'],
    prompt:
        'Jedes Scrum-Artefakt hat ein "Commitment", das ihm Transparenz gibt. '
        'Ordne richtig zu.',
    buckets: ['Product Backlog', 'Sprint Backlog', 'Increment'],
    matchItems: const [
      MatchItem(
        text: 'Product Goal',
        bucket: 0,
        rationale: 'Das Product Goal ist das langfristige Ziel, auf das das Product Backlog einzahlt.',
      ),
      MatchItem(
        text: 'Sprint Goal',
        bucket: 1,
        rationale: 'Das Sprint Goal ist das eine Ziel des Sprints und gehoert zum Sprint Backlog.',
      ),
      MatchItem(
        text: 'Definition of Done',
        bucket: 2,
        rationale: 'Die DoD beschreibt, wann ein Increment wirklich fertig - also potenziell auslieferbar - ist.',
      ),
      MatchItem(
        text: 'Geordnete Liste aller bekannten Anforderungen an das Produkt',
        bucket: 0,
        rationale: 'Das ist die Definition des Product Backlogs.',
      ),
      MatchItem(
        text: 'Auswahl der Items plus Plan zur Umsetzung fuer die kommenden Wochen',
        bucket: 1,
        rationale: 'Sprint Backlog = Sprint Goal + ausgewaehlte Items + Umsetzungsplan.',
      ),
      MatchItem(
        text: 'Das konkrete, nutzbare Ergebnis am Ende des Sprints',
        bucket: 2,
        rationale: 'Das Increment ist das Arbeitsergebnis, das die DoD erfuellt.',
      ),
    ],
    explanation:
        'Drei Artefakte, drei Commitments: Product Backlog -> Product Goal, '
        'Sprint Backlog -> Sprint Goal, Increment -> Definition of Done. '
        'Diese Zuordnung wird gern gefragt, weil viele die DoD faelschlich dem '
        'Sprint Backlog zuordnen.',
  ),

  Question(
    id: 'scr-005',
    topicId: 'agil_scrum',
    kind: QuestionKind.numeric,
    difficulty: 2,
    tags: ['scrum', 'velocity'],
    scenario:
        'Ein Scrum-Team hat in den letzten drei Sprints 28, 32 und 30 Story Points '
        'abgeschlossen. Im Product Backlog liegen noch 270 Story Points.',
    prompt:
        'Wie viele weitere Sprints braucht das Team voraussichtlich? '
        'Runde auf volle Sprints auf.',
    numericAnswer: 9,
    numericTolerance: 0,
    unit: 'Sprints',
    explanation:
        'Rechenweg:\n'
        '1. Durchschnittliche Velocity = (28 + 32 + 30) / 3 = 30 Story Points/Sprint\n'
        '2. 270 SP / 30 SP je Sprint = 9 Sprints\n'
        'Waere das Ergebnis krumm (z. B. 9,3), wird aufgerundet - ein halber '
        'Sprint existiert in der Planung nicht. Die Velocity wird immer aus '
        'abgeschlossenen (Definition of Done erfuellten) Items gebildet, nicht '
        'aus angefangenen.',
  ),

  Question(
    id: 'scr-006',
    topicId: 'agil_scrum',
    // Kanban zaehlt ab 2025 zu den gestrichenen Methoden.
    catalogStatus: CatalogStatus.removed2025,
    kind: QuestionKind.single,
    difficulty: 2,
    tags: ['kanban', 'wip'],
    prompt: 'Wozu dient ein WIP-Limit in Kanban?',
    choices: [
      _c('Es begrenzt die Anzahl gleichzeitig bearbeiteter Aufgaben und macht Engpaesse sichtbar.', true,
          'Richtig. Work in Progress zu begrenzen verkuerzt die Durchlaufzeit und zwingt das Team, Aufgaben fertigzustellen, statt neue anzufangen.'),
      _c('Es legt fest, wie viele Story Points pro Sprint eingeplant werden.', false,
          'Das ist die Velocity in Scrum. Kanban kennt keine Sprints und keine feste Einplanung.'),
      _c('Es begrenzt die maximale Teamgroesse.', false,
          'WIP bezieht sich auf Arbeit, nicht auf Personen.'),
      _c('Es definiert, wie lange eine Aufgabe maximal dauern darf.', false,
          'Das waere eine Timebox bzw. ein Service Level Expectation - nicht das WIP-Limit.'),
    ],
    explanation:
        'Kanban-Kernpraktiken: Workflow visualisieren, WIP limitieren, Fluss '
        'steuern, Regeln explizit machen, Feedback etablieren, verbessern. '
        'Hintergrund ist das Littlesche Gesetz: Durchlaufzeit = WIP / Durchsatz. '
        'Weniger parallele Arbeit bedeutet direkt kuerzere Durchlaufzeiten.',
  ),

  Question(
    id: 'scr-007',
    topicId: 'agil_scrum',
    kind: QuestionKind.multiple,
    difficulty: 3,
    tags: ['scrum', 'user_story'],
    prompt:
        'Welche Aussagen ueber User Stories und deren Akzeptanzkriterien sind korrekt?',
    choices: [
      _c('Das Format lautet: Als <Rolle> moechte ich <Ziel>, um <Nutzen>.', true,
          'Das ist das Standardformat. Der "um ... zu"-Teil ist der wichtigste und wird am haeufigsten weggelassen.'),
      _c('Akzeptanzkriterien legen fest, wann die Story als erfuellt gilt.', true,
          'Sie sind storyspezifisch und pruefbar - im Gegensatz zur Definition of Done, die fuer alle Stories gilt.'),
      _c('Die Definition of Done ersetzt die Akzeptanzkriterien.', false,
          'Falsch. Die DoD gilt teamweit fuer JEDES Increment (z. B. Code-Review erfolgt, Tests gruen). Akzeptanzkriterien sind fachlich und gelten nur fuer diese eine Story. Beides muss erfuellt sein.'),
      _c('Story Points schaetzen den Aufwand relativ, nicht in Stunden.', true,
          'Relative Schaetzung ist stabiler als absolute: Menschen vergleichen zuverlaessiger, als sie Stunden schaetzen.'),
      _c('Eine User Story muss immer in einen Sprint passen.', true,
          'Passt sie nicht, wird sie im Refinement geteilt. Eine zu grosse Story heisst Epic.'),
      _c('Der Scrum Master schreibt die User Stories.', false,
          'Falsch. Verantwortlich fuer das Product Backlog ist der Product Owner; formulieren kann sie jeder im Team.'),
    ],
    explanation:
        'INVEST als Qualitaetscheck fuer Stories: Independent, Negotiable, '
        'Valuable, Estimable, Small, Testable. Der klassische Pruefungsfallstrick '
        'ist die Abgrenzung Akzeptanzkriterien (pro Story, fachlich) gegen '
        'Definition of Done (teamweit, handwerklich).',
  ),
];
