import '../../models/question.dart';
import '../builders.dart';

/// Wiederkehrender Beispielnetzplan für die Lektionen Vorwärtsrechnung,
/// Rückwärtsrechnung und kritischer Pfad - so rechnen Lernende einen Plan
/// schrittweise zu Ende.
const _netz =
    'Vorgänge (Dauer in Tagen):\n'
    'A: 5 Tage, Startvorgang\n'
    'B: 3 Tage, nach A\n'
    'C: 6 Tage, nach A\n'
    'D: 2 Tage, nach B\n'
    'E: 4 Tage, nach C und D';

/// Ergänzende Aufgaben zu Bereich 01, damit jede Lektion einen Wissenscheck
/// mit mindestens drei Aufgaben hat.
final List<Question> questionsA01Journey = [
  // ===================================================== Was ein Projekt ausmacht
  einfach('a1-pb-1', 'p-begriff',
      prompt: 'Welches Vorhaben ist ein Projekt?',
      choices: [
        ja('Die erstmalige Einführung eines Ticketsystems bis Ende Juni mit festem Budget',
            'Einmalig, mit Ziel, Termin und Budget - alle Merkmale eines Projekts sind erfüllt.'),
        nein('Das wöchentliche Prüfen der Datensicherung',
            'Wiederkehrende Routine in der Linie - kein einmaliges Vorhaben.'),
        nein('Die monatliche Gehaltsabrechnung',
            'Eine klassische Linienaufgabe mit eingespieltem Ablauf.'),
        nein('Der laufende Betrieb des Mailservers',
            'Eine Daueraufgabe ohne festes Ende.'),
      ],
      explanation:
          'Ein Projekt ist einmalig, zielgerichtet und zeitlich wie finanziell begrenzt. Alle anderen Beispiele wiederholen sich oder laufen dauerhaft - sie gehören zum Tagesgeschäft.'),
  mehrfach('a1-pb-2', 'p-begriff',
      prompt: 'Welche Aussagen über Projekte sind richtig?',
      choices: [
        ja('Ein Projekt hat einen festgelegten Anfang und ein festgelegtes Ende.',
            'Die zeitliche Begrenzung gehört zu den Kernmerkmalen.'),
        ja('Projekte haben meist eine eigene, zeitlich begrenzte Organisation.',
            'Rollen wie Projektleitung und Projektteam bestehen nur für die Projektdauer.'),
        nein('Ein Vorhaben ist erst ab einem Budget von 10.000 € ein Projekt.',
            'Größe und Budget sind keine Merkmale - entscheidend ist die Einmaligkeit.'),
        nein('Projekte wiederholen sich regelmäßig in gleicher Form.',
            'Das beschreibt eine Linienaufgabe.'),
        ja('Projekte bergen durch ihre Neuartigkeit höhere Risiken als Routineaufgaben.',
            'Weil Erfahrungswerte fehlen, ist die Unsicherheit größer.'),
      ],
      explanation:
          'Projekte sind einmalig und begrenzt, haben eine eigene Organisation und tragen wegen ihrer Neuartigkeit mehr Risiko. Eine Mindestgröße gibt es nicht.'),

  // ====================================== Projektziele und magisches Dreieck
  einfach('a1-pz-1', 'p-ziele',
      prompt: 'Welches Ziel ist SMART formuliert?',
      choices: [
        ja('Bis 31.03. sind alle 40 Arbeitsplätze auf Windows 11 umgestellt, kein Arbeitsplatz fällt dabei länger als zwei Stunden aus.',
            'Spezifisch, messbar (40 Plätze, 2 Stunden), realistisch und mit Termin.'),
        nein('Die IT soll moderner werden.',
            'Weder spezifisch noch messbar noch terminiert.'),
        nein('Möglichst bald sollen alle Rechner schneller laufen.',
            '„Möglichst bald“ ist kein Termin, „schneller“ keine Messgröße.'),
        nein('Ab sofort gilt 100 % Verfügbarkeit für alle Systeme.',
            'Nicht realistisch - keine IT erreicht dauerhaft 100 %.'),
      ],
      explanation:
          'SMART heißt spezifisch, messbar, attraktiv bzw. akzeptiert, realistisch und terminiert. Nur das erste Ziel lässt sich am Stichtag eindeutig prüfen.'),

  // ====================================================== Organisationsformen
  einfach('a1-po-1', 'p-organisation',
      scenario:
          'Ein Unternehmen führt ein neues ERP-System ein. Das Projekt dauert 18 Monate, hat hohe strategische Bedeutung, und das Team arbeitet in Vollzeit daran.',
      prompt: 'Welche Form der Projektorganisation passt am besten?',
      choices: [
        ja('Reine Projektorganisation',
            'Lang, groß, strategisch und in Vollzeit: Genau dafür wird das Team aus der Linie herausgelöst.'),
        nein('Matrix-Organisation',
            'Passt, wenn Mitarbeitende nur teilweise im Projekt sind - hier arbeiten sie in Vollzeit daran.'),
        nein('Stabs-/Einflussorganisation',
            'Zu schwach: Die Projektleitung könnte in einem so großen Projekt nichts durchsetzen.'),
        nein('Linienorganisation',
            'Das ist keine Form der Projektorganisation, sondern die normale Aufbauorganisation.'),
      ],
      explanation:
          'Je größer, länger und bedeutender ein Projekt ist, desto eher lohnt sich die reine Projektorganisation mit voller Weisungsbefugnis der Projektleitung.'),
  mehrfach('a1-po-2', 'p-organisation',
      prompt: 'Welche Aussagen treffen auf die Matrix-Projektorganisation zu?',
      choices: [
        ja('Die Projektleitung hat fachliche Weisungsbefugnis.',
            'Sie bestimmt, was und wie im Projekt gearbeitet wird.'),
        ja('Mitarbeitende haben zwei Vorgesetzte - im Projekt und in der Linie.',
            'Das ist das Kennzeichen der Matrix.'),
        nein('Die Projektleitung entscheidet über Urlaub und Gehalt der Teammitglieder.',
            'Das ist disziplinarische Weisung - sie bleibt in der Matrix bei der Linie.'),
        ja('Es kann zu Konflikten um Prioritäten kommen.',
            'Wenn Linie und Projekt gleichzeitig Zeit beanspruchen, entsteht Konfliktpotenzial.'),
        nein('Das Team wird für die Projektdauer vollständig aus der Linie herausgelöst.',
            'Das beschreibt die reine Projektorganisation.'),
      ],
      explanation:
          'In der Matrix ist die Weisungsbefugnis geteilt: fachlich beim Projekt, disziplinarisch in der Linie. Das nutzt Ressourcen flexibel, erzeugt aber Prioritätenkonflikte.'),

  // =========================================================== Rollen im Projekt
  zuordnen('a1-pr-1', 'p-rollen',
      prompt: 'Ordne jede Aufgabe der zuständigen Rolle zu.',
      buckets: ['Auftraggeber', 'Lenkungsausschuss', 'Projektleitung', 'Projektteam'],
      items: [
        zu('Gibt das Projekt in Auftrag und stellt das Budget bereit', 0),
        zu('Entscheidet nach einer Eskalation über eine Budgeterhöhung', 1),
        zu('Erstellt den Terminplan und verfolgt den Fortschritt', 2),
        zu('Setzt ein Arbeitspaket um', 3),
        zu('Nimmt das Ergebnis am Projektende ab', 0),
        zu('Schreibt den monatlichen Statusbericht', 2),
      ],
      explanation:
          'Der Auftraggeber beauftragt, finanziert und nimmt ab. Der Lenkungsausschuss entscheidet über Änderungen des Rahmens. Die Projektleitung plant, steuert und berichtet, das Team setzt um.'),
  einfach('a1-pr-2', 'p-rollen',
      scenario:
          'Mitten im Projekt stellt die Projektleiterin fest, dass das Budget um 20 % überschritten wird, wenn der vereinbarte Umfang geliefert werden soll.',
      prompt: 'Wie geht sie richtig vor?',
      choices: [
        ja('Sie eskaliert an den Lenkungsausschuss, der über Budget oder Umfang entscheidet.',
            'Budget und Umfang sind Teil des Auftrags - darüber entscheidet das Gremium, nicht die Projektleitung.'),
        nein('Sie streicht eigenständig zwei Funktionen.',
            'Damit ändert sie den Auftrag, ohne dazu befugt zu sein.'),
        nein('Sie überzieht das Budget, weil der Umfang vereinbart ist.',
            'Eine Überschreitung ohne Freigabe ist ebenfalls eine Änderung des Auftrags.'),
        nein('Sie wartet bis zum Projektende und erklärt die Abweichung im Abschlussbericht.',
            'Je später ein Problem gemeldet wird, desto weniger Handlungsspielraum bleibt.'),
      ],
      explanation:
          'Die Projektleitung steuert innerhalb des Auftrags. Droht der Rahmen gesprengt zu werden, muss sie frühzeitig eskalieren und eine Entscheidung herbeiführen.'),
  mehrfach('a1-pr-3', 'p-rollen',
      prompt: 'Was gehört typischerweise in ein Kick-off-Meeting?',
      choices: [
        ja('Ziele und Nicht-Ziele des Projekts vorstellen',
            'Das gemeinsame Verständnis der Ziele ist der wichtigste Zweck des Kick-offs.'),
        ja('Rollen und Zuständigkeiten klären',
            'Jede Person muss wissen, wer wofür verantwortlich ist.'),
        ja('Kommunikationswege und Spielregeln vereinbaren',
            'Zum Beispiel Termine für Statusmeetings und Kanäle für Rückfragen.'),
        nein('Das Projektergebnis abnehmen',
            'Die Abnahme steht am Ende des Projekts, nicht am Anfang.'),
        nein('Detaillierte Code-Reviews durchführen',
            'Zum Projektstart gibt es noch keinen Code - und Reviews sind keine Aufgabe des Kick-offs.'),
      ],
      explanation:
          'Das Kick-off ist der offizielle Start mit allen Beteiligten. Es schafft ein gemeinsames Verständnis von Zielen, Rollen und Zusammenarbeit.'),

  // ===================================================== Stakeholder analysieren
  zuordnen('a1-ps-1', 'p-stakeholder',
      prompt: 'Ordne jeder Gruppe die passende Strategie der Stakeholder-Matrix zu.',
      buckets: ['eng einbinden', 'zufriedenstellen', 'informieren', 'beobachten'],
      items: [
        zu('Geschäftsführung: hoher Einfluss, großes Interesse', 0),
        zu('Betriebsrat: hoher Einfluss, zunächst geringes Interesse', 1),
        zu('Anwender der Buchhaltung: geringer Einfluss, großes Interesse', 2),
        zu('Reinigungsdienst: geringer Einfluss, geringes Interesse', 3),
      ],
      explanation:
          'Hoch/hoch: eng einbinden. Hoch/gering: zufriedenstellen. Gering/hoch: informieren. Gering/gering: beobachten. Der Betriebsrat ist das klassische Beispiel für „zufriedenstellen“.'),
  reihenfolge('a1-ps-2', 'p-stakeholder',
      prompt: 'Bringe die Schritte der Stakeholderanalyse in die richtige Reihenfolge.',
      items: [
        'Stakeholder identifizieren',
        'Einfluss, Interesse und Einstellung einschätzen',
        'In die Stakeholder-Matrix einordnen',
        'Maßnahmen festlegen und umsetzen',
      ],
      explanation:
          'Erst muss klar sein, wer betroffen ist. Dann wird eingeschätzt und eingeordnet, zuletzt werden daraus Maßnahmen abgeleitet - und die Analyse wird im Projektverlauf aktualisiert.'),

  // ================================================================ Projektphasen
  reihenfolge('a1-vp-1', 'v-phasen',
      prompt: 'Bringe die Projektphasen nach DIN 69901 in die richtige Reihenfolge.',
      items: ['Initialisierung', 'Definition', 'Planung', 'Steuerung', 'Abschluss'],
      explanation:
          'Erst wird das Projekt beauftragt (Initialisierung), dann geklärt, was genau entstehen soll (Definition), dann geplant, umgesetzt und gesteuert, zuletzt abgeschlossen.'),
  zuordnen('a1-vp-2', 'v-phasen',
      prompt: 'In welcher Phase entsteht das jeweilige Ergebnis?',
      buckets: ['Initialisierung', 'Definition', 'Planung', 'Abschluss'],
      items: [
        zu('Der Projektauftrag wird unterschrieben', 0),
        zu('Das Lastenheft wird erstellt', 1),
        zu('Projektstrukturplan und Terminplan entstehen', 2),
        zu('Der Lessons-Learned-Workshop findet statt', 3),
        zu('Die Machbarkeit wird bewertet', 1),
        zu('Der Abschlussbericht wird geschrieben', 3),
      ],
      explanation:
          'Initialisierung: Auftrag. Definition: Ziele, Anforderungen, Machbarkeit. Planung: Struktur, Termine, Kosten. Abschluss: Bericht und Lessons Learned.'),
  einfach('a1-vp-3', 'v-phasen',
      prompt: 'In welcher Phase wird der Projektstrukturplan erstellt?',
      choices: [
        ja('Planung', 'Der PSP ist die Grundlage aller weiteren Pläne und entsteht zu Beginn der Planung.'),
        nein('Definition', 'Hier werden Ziele und Anforderungen geklärt - noch nicht die Arbeitsstruktur.'),
        nein('Initialisierung', 'Hier geht es um die Idee und den Projektauftrag.'),
        nein('Steuerung', 'In der Steuerung wird der Plan umgesetzt und überwacht, nicht erst erstellt.'),
      ],
      explanation:
          'Die Planung beginnt mit dem Projektstrukturplan. Aus ihm entstehen Termin-, Ressourcen- und Kostenplan.'),

  // ============================================================ Wasserfallmodell
  mehrfach('a1-vw-1', 'v-wasserfall',
      prompt: 'Welche Aussagen treffen auf das Wasserfallmodell zu?',
      choices: [
        ja('Die Phasen laufen nacheinander ab.', 'Das ist das Grundprinzip des Modells.'),
        ja('Jede Phase endet mit einem dokumentierten, freigegebenen Ergebnis.',
            'Erst dann beginnt die nächste Phase.'),
        nein('Der Kunde erhält nach jeder Phase lauffähige Teilergebnisse.',
            'Lauffähige Software gibt es erst am Ende - Zwischenergebnisse sind Dokumente.'),
        ja('Es eignet sich für Festpreisprojekte mit klaren Anforderungen.',
            'Stabile Anforderungen lassen sich vorab vollständig planen und kalkulieren.'),
        nein('Anforderungen werden während der Implementierung laufend neu priorisiert.',
            'Das ist typisch für Scrum, nicht für den Wasserfall.'),
      ],
      explanation:
          'Der Wasserfall ist sequenziell und dokumentgetrieben. Er spielt seine Stärken bei klaren, stabilen Anforderungen aus.'),

  // ======================================================== Klassisch oder agil?
  einfach('a1-va-1', 'v-auswahl',
      scenario:
          'Ein Start-up entwickelt eine App. Welche Funktionen die Nutzer wirklich brauchen, soll sich erst durch Rückmeldungen zu frühen Versionen zeigen.',
      prompt: 'Welches Vorgehen passt?',
      choices: [
        ja('Scrum', 'Unklare Anforderungen und frühe Rückmeldungen sind genau die Stärke von Scrum.'),
        nein('Wasserfall', 'Setzt voraus, dass die Anforderungen zu Beginn feststehen - das ist hier nicht der Fall.'),
        nein('Erst alle Anforderungen vollständig klären, dann entscheiden',
            'Genau das ist hier nicht möglich: Die Anforderungen ergeben sich erst aus der Nutzung.'),
        nein('Wasserfall, weil so eine vollständige Dokumentation entsteht',
            'Dokumentation ist kein Grund, wenn das Produkt dabei an den Nutzern vorbeigeht.'),
      ],
      explanation:
          'Wenn sich Anforderungen erst im Lauf des Projekts herausbilden, braucht es kurze Zyklen mit nutzbaren Zwischenergebnissen - also Scrum.'),
  einfach('a1-va-2', 'v-auswahl',
      scenario:
          'Für eine Behörde soll ein Formular nach genau festgelegten gesetzlichen Vorgaben digitalisiert werden. Anforderungen, Festpreis und Termin stehen vertraglich fest.',
      prompt: 'Welches Vorgehensmodell passt?',
      choices: [
        ja('Wasserfall', 'Stabile Anforderungen, Festpreis und fester Termin sprechen für ein vollständig geplantes Vorgehen.'),
        nein('Scrum', 'Scrum spielt seine Stärken bei sich ändernden Anforderungen aus - die gibt es hier nicht.'),
        nein('Scrum, weil agile Methoden immer schneller sind',
            'Agil ist nicht automatisch schneller, sondern flexibler.'),
        nein('Kanban', 'Kanban ist eine Methode zur Visualisierung von Arbeit und seit dem Katalog 2025 kein Prüfungsthema der AP1 mehr.'),
      ],
      explanation:
          'Bei klaren, stabilen Anforderungen und vertraglich fixiertem Rahmen ist der Wasserfall die naheliegende Wahl.'),

  // ============================================================ Agiles Manifest
  einfach('a1-sm-1', 's-manifest',
      prompt: 'Welcher Satz steht so im agilen Manifest?',
      choices: [
        ja('Funktionierende Software ist wichtiger als umfassende Dokumentation.',
            'Das ist einer der vier Werte.'),
        nein('Umfassende Dokumentation ist wichtiger als funktionierende Software.',
            'Genau umgekehrt.'),
        nein('Befolgen eines Plans ist wichtiger als Reagieren auf Veränderung.',
            'Umgekehrt: Reagieren auf Veränderung steht vorn.'),
        nein('Prozesse und Werkzeuge sind wichtiger als Individuen und Interaktionen.',
            'Umgekehrt: Menschen und Zusammenarbeit stehen vorn.'),
      ],
      explanation:
          'Die vier Werte: Individuen und Interaktionen, funktionierende Software, Zusammenarbeit mit dem Kunden und Reagieren auf Veränderung sind wichtiger als die jeweilige rechte Seite.'),
  mehrfach('a1-sm-2', 's-manifest',
      prompt: 'Welche Aussagen entsprechen den Prinzipien des agilen Manifests?',
      choices: [
        ja('Anforderungsänderungen sind auch spät in der Entwicklung willkommen.', 'Eines der zwölf Prinzipien.'),
        ja('Funktionierende Software ist das wichtigste Fortschrittsmaß.', 'Eines der zwölf Prinzipien.'),
        nein('Der Kunde wird nur zu Projektbeginn und bei der Abnahme einbezogen.',
            'Agil heißt laufende Zusammenarbeit mit dem Kunden.'),
        ja('Das Team reflektiert regelmäßig, wie es effektiver werden kann.', 'Eines der zwölf Prinzipien.'),
        nein('Dokumentation ist nicht erlaubt.', 'Dokumentation ist wichtig - funktionierende Software nur wichtiger.'),
      ],
      explanation:
          'Die Prinzipien betonen frühe Auslieferung, Offenheit für Änderungen, enge Zusammenarbeit und regelmäßige Verbesserung.'),
  einfach('a1-sm-3', 's-manifest',
      scenario: 'Ein Kollege sagt: „Agil heißt, wir dokumentieren nichts mehr.“',
      prompt: 'Wie ist die Aussage einzuordnen?',
      choices: [
        ja('Falsch - Dokumentation bleibt wichtig, funktionierende Software ist nur wichtiger.',
            'Das Manifest bewertet die rechte Seite ausdrücklich als wertvoll.'),
        nein('Richtig, so steht es im agilen Manifest.', 'Das Manifest verbietet keine Dokumentation.'),
        nein('Richtig, Scrum verbietet Dokumentation.', 'Scrum kennt sogar dokumentierte Artefakte wie Backlogs und die Definition of Done.'),
        nein('Falsch - agile Teams müssen mehr dokumentieren als Wasserfall-Teams.',
            'Das sagt das Manifest nicht; es setzt nur andere Schwerpunkte.'),
      ],
      explanation: 'Links vor rechts, nicht links statt rechts: Agilität verschiebt Schwerpunkte, sie schafft nichts ab.'),

  // ============================================ Die drei Verantwortlichkeiten
  zuordnen('a1-sr-1', 's-rollen',
      prompt: 'Wer ist in Scrum dafür verantwortlich?',
      buckets: ['Product Owner', 'Scrum Master', 'Developers'],
      items: [
        zu('Das Product Backlog ordnen', 0),
        zu('Ein Hindernis beseitigen, das das Team blockiert', 1),
        zu('Den Plan für den Sprint im Sprint Backlog erstellen', 2),
        zu('Das Produktziel formulieren', 0),
        zu('Das Team in Scrum coachen', 1),
        zu('Die Definition of Done beim Increment einhalten', 2),
      ],
      explanation:
          'Der Product Owner verantwortet den Wert und das Backlog, der Scrum Master die Wirksamkeit des Teams, die Developers das nutzbare Increment in der vereinbarten Qualität.'),
  einfach('a1-sr-2', 's-rollen',
      prompt: 'Wie groß ist ein Scrum Team laut Scrum Guide in der Regel?',
      choices: [
        ja('10 oder weniger Personen', 'So steht es im Scrum Guide: klein genug, um wendig zu bleiben.'),
        nein('Genau 7 Developers', 'Eine feste Zahl gibt es nicht.'),
        nein('Mindestens 12 Personen', 'Größere Teams sollen sich eher in mehrere Scrum Teams aufteilen.'),
        nein('Beliebig groß, solange es einen Product Owner gibt', 'Die Teamgröße ist ausdrücklich begrenzt.'),
      ],
      explanation:
          'Ein Scrum Team umfasst typischerweise zehn oder weniger Personen. Kleine Teams kommunizieren besser und sind produktiver.'),

  // ================================================ Artefakte und Commitments
  einfach('a1-sa-1', 's-artefakte',
      prompt: 'Welches Commitment gehört zum Sprint Backlog?',
      choices: [
        ja('Sprintziel', 'Das Sprintziel gibt dem Sprint Backlog seine Richtung.'),
        nein('Produktziel', 'Das gehört zum Product Backlog.'),
        nein('Definition of Done', 'Die gehört zum Increment.'),
        nein('Velocity', 'Die Velocity ist eine Messgröße, kein Commitment.'),
      ],
      explanation: 'Product Backlog - Produktziel, Sprint Backlog - Sprintziel, Increment - Definition of Done.'),
  mehrfach('a1-sa-2', 's-artefakte',
      prompt: 'Welche Aussagen zur Definition of Done sind richtig?',
      choices: [
        ja('Sie gilt für alle Einträge im Product Backlog.', 'Sie ist ein gemeinsamer Qualitätsmaßstab.'),
        ja('Einträge, die sie nicht erfüllen, werden im Sprint Review nicht als fertig vorgestellt.',
            'Sie gehen zurück ins Product Backlog.'),
        nein('Sie wird für jede User Story neu festgelegt.',
            'Das beschreibt Akzeptanzkriterien.'),
        nein('Sie legt fest, welche Stories im nächsten Sprint drankommen.',
            'Das wird im Sprint Planning entschieden.'),
        ja('Sie schafft ein gemeinsames Verständnis davon, wann Arbeit fertig ist.',
            'Genau dafür ist sie da.'),
      ],
      explanation:
          'Die Definition of Done ist der Qualitätsmaßstab für alle Einträge. Nur was sie erfüllt, gehört zum Increment.'),

  // ============================================================= Scrum-Events
  zuordnen('a1-se-1', 's-events',
      prompt: 'Ordne jede Beschreibung dem passenden Event zu.',
      buckets: ['Sprint Planning', 'Daily Scrum', 'Sprint Review', 'Sprint Retrospective'],
      items: [
        zu('Das Sprintziel wird festgelegt', 0),
        zu('Die Developers planen die nächsten 24 Stunden', 1),
        zu('Stakeholder sehen das Increment und geben Rückmeldung', 2),
        zu('Das Team überlegt, wie es seine Zusammenarbeit verbessern kann', 3),
      ],
      explanation:
          'Planning: was und wie. Daily: nächste 24 Stunden. Review: Produkt mit Stakeholdern. Retrospektive: Zusammenarbeit im Team.'),

  // ============================================= User Stories und Schätzung
  einfach('a1-st-1', 's-stories',
      prompt: 'Welche User Story ist korrekt formuliert?',
      choices: [
        ja('Als Vertriebsmitarbeiter möchte ich Kunden nach Postleitzahl filtern, damit ich Besuche besser planen kann.',
            'Rolle, Ziel und Nutzen sind genannt.'),
        nein('Das System muss eine MySQL-Datenbank verwenden.',
            'Eine technische Vorgabe ohne Rolle und Nutzen - keine User Story.'),
        nein('Als Entwickler möchte ich eine Klasse KundenDAO anlegen.',
            'Beschreibt eine Umsetzung, keinen Nutzen für Anwender.'),
        nein('Filterfunktion für Kunden einbauen.', 'Rolle und Nutzen fehlen.'),
      ],
      explanation: 'Eine User Story folgt dem Muster: Als <Rolle> möchte ich <Ziel>, damit <Nutzen>.'),

  // ======================================================= Aufbau eines Netzplans
  einfach('a1-ng-1', 'n-grundlagen',
      prompt: 'Welche Anordnungsbeziehung ist in Netzplänen der Normalfall?',
      choices: [
        ja('Normalfolge (Ende-Anfang)', 'Der Nachfolger beginnt, wenn der Vorgänger beendet ist.'),
        nein('Anfangsfolge (Anfang-Anfang)', 'Kommt vor, ist aber nicht der Standard.'),
        nein('Endfolge (Ende-Ende)', 'Kommt vor, ist aber nicht der Standard.'),
        nein('Sprungfolge (Anfang-Ende)', 'Selten und in der AP1 kaum relevant.'),
      ],
      explanation: 'In AP1-Netzplänen ist praktisch immer die Normalfolge gemeint.'),
  mehrfach('a1-ng-2', 'n-grundlagen',
      prompt: 'Welche Angaben stehen in einem vollständig berechneten Vorgangsknoten?',
      choices: [
        ja('Frühester Anfang und frühestes Ende (FAZ, FEZ)', 'Ergebnis der Vorwärtsrechnung.'),
        ja('Spätester Anfang und spätestes Ende (SAZ, SEZ)', 'Ergebnis der Rückwärtsrechnung.'),
        ja('Gesamtpuffer und freier Puffer (GP, FP)', 'Werden aus den Zeitpunkten berechnet.'),
        nein('Stundensatz der bearbeitenden Person', 'Kosten gehören in die Kostenplanung, nicht in den Knoten.'),
        nein('Kundenzufriedenheit', 'Keine Größe der Terminplanung.'),
      ],
      explanation: 'Ein Vorgangsknoten enthält Nummer, Bezeichnung, Dauer, die vier Zeitpunkte und die beiden Puffer.'),
  reihenfolge('a1-ng-3', 'n-grundlagen',
      prompt: 'Bringe die Arbeitsschritte der Netzplantechnik in die richtige Reihenfolge.',
      items: [
        'Vorgänge und Dauern auflisten',
        'Vorgänger festlegen',
        'Knoten anordnen und verbinden',
        'Vorwärtsrechnung durchführen',
        'Rückwärtsrechnung durchführen',
        'Puffer und kritischen Pfad ermitteln',
      ],
      explanation: 'Erst die Struktur, dann die Zeitrechnung in beide Richtungen, zuletzt die Auswertung.'),

  // ============================================================ Vorwärtsrechnung
  rechnen('a1-nv-1', 'n-vorwaerts',
      scenario: _netz,
      prompt: 'Wie groß ist der FAZ von Vorgang E?',
      answer: 11,
      unit: 'Tage',
      explanation:
          'A: 0/5. B: 5/8. C: 5/11. D: 8/10.\n'
          'E hat zwei Vorgänger: FAZ = max(FEZ C = 11; FEZ D = 10) = 11.\n'
          'Wer 10 einträgt, lässt E starten, obwohl C noch läuft.'),

  // =========================================================== Rückwärtsrechnung
  rechnen('a1-nr-1', 'n-rueckwaerts',
      scenario: _netz,
      prompt: 'Wie groß ist der SAZ von Vorgang D?',
      answer: 9,
      unit: 'Tage',
      explanation:
          'Vorwärts: E endet bei 15 - das ist die Projektdauer.\n'
          'E: SEZ 15, SAZ 15 - 4 = 11.\n'
          'D: SEZ = SAZ von E = 11, SAZ = 11 - 2 = 9.'),
  rechnen('a1-nr-2', 'n-rueckwaerts',
      scenario: _netz,
      prompt: 'Wie groß ist der SEZ von Vorgang A?',
      answer: 5,
      unit: 'Tage',
      explanation:
          'Rückwärts: E 11/15, D 9/11, C 5/11, B: SEZ = SAZ D = 9, SAZ 6.\n'
          'A hat zwei Nachfolger: SEZ = min(SAZ B = 6; SAZ C = 5) = 5.\n'
          'Das Minimum, weil C als eiligster Nachfolger pünktlich starten muss.'),
  einfach('a1-nr-3', 'n-rueckwaerts',
      prompt: 'Womit beginnt die Rückwärtsrechnung beim letzten Vorgang, wenn kein Endtermin vorgegeben ist?',
      choices: [
        ja('SEZ = FEZ des letzten Vorgangs', 'Die errechnete Projektdauer wird zum spätesten Ende.'),
        nein('SEZ = 0', 'Mit 0 beginnt die Vorwärtsrechnung, nicht die Rückwärtsrechnung.'),
        nein('SEZ = FAZ des letzten Vorgangs', 'Das wäre der Anfang, nicht das Ende des Vorgangs.'),
        nein('SEZ = Summe aller Vorgangsdauern', 'Parallele Vorgänge würden dann doppelt gezählt.'),
      ],
      explanation: 'Ohne vorgegebenen Endtermin ist die Projektdauer aus der Vorwärtsrechnung das späteste Ende.'),

  // ============================================================= Kritischer Pfad
  einfach('a1-nk-1', 'n-kritisch',
      scenario: _netz,
      prompt: 'Welcher Weg ist der kritische Pfad?',
      choices: [
        ja('A - C - E', 'A, C und E haben einen Gesamtpuffer von 0. Länge 5 + 6 + 4 = 15 Tage.'),
        nein('A - B - D - E', 'Dieser Weg dauert nur 14 Tage - B und D haben je einen Tag Puffer.'),
        nein('A - B - C', 'B und C liegen nicht hintereinander, sondern parallel.'),
        nein('Es gibt keinen kritischen Pfad', 'Jeder Netzplan hat mindestens einen kritischen Pfad.'),
      ],
      explanation:
          'GP = SAZ - FAZ: A 0, B 1, C 0, D 1, E 0. Der kritische Pfad verbindet alle Vorgänge ohne Puffer: A - C - E mit 15 Tagen Projektdauer.'),
];
