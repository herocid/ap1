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

/// Home-Office-Einführung: Dauer 14, kritischer Pfad A - B - D - F,
/// C hat GP 4 / FP 2, E hat GP 2 / FP 2.
const _home = [
  Activity(id: 'A', name: 'Bedarf ermitteln', duration: 3),
  Activity(
    id: 'B',
    name: 'Laptops beschaffen',
    duration: 4,
    predecessors: ['A'],
  ),
  Activity(id: 'C', name: 'VPN planen', duration: 2, predecessors: ['A']),
  Activity(
    id: 'D',
    name: 'Laptops einrichten',
    duration: 5,
    predecessors: ['B'],
  ),
  Activity(
    id: 'E',
    name: 'VPN einrichten',
    duration: 3,
    predecessors: ['B', 'C'],
  ),
  Activity(id: 'F', name: 'Rollout', duration: 2, predecessors: ['D', 'E']),
];

const _homeText =
    'Einführung von Home-Office-Arbeitsplätzen (Dauer in Arbeitstagen):\n'
    'A Bedarf ermitteln: 3, Startvorgang\n'
    'B Laptops beschaffen: 4, nach A\n'
    'C VPN planen: 2, nach A\n'
    'D Laptops einrichten: 5, nach B\n'
    'E VPN einrichten: 3, nach B und C\n'
    'F Rollout: 2, nach D und E';

/// Schulungsraum: zwei gleich lange kritische Pfade (Dauer 10).
const _raum = [
  Activity(id: 'A', name: 'Planung', duration: 2),
  Activity(id: 'B', name: 'Möbel bestellen', duration: 5, predecessors: ['A']),
  Activity(id: 'C', name: 'Netz verkabeln', duration: 3, predecessors: ['A']),
  Activity(id: 'D', name: 'PCs einrichten', duration: 4, predecessors: ['C']),
  Activity(id: 'E', name: 'Möbel aufbauen', duration: 2, predecessors: ['B']),
  Activity(id: 'F', name: 'Abnahme', duration: 1, predecessors: ['D', 'E']),
];

const _mini = [
  Activity(id: 'A', name: 'Analyse', duration: 3),
  Activity(id: 'B', name: 'Konzept', duration: 2, predecessors: ['A']),
  Activity(id: 'C', name: 'Hardware', duration: 4, predecessors: ['A']),
  Activity(id: 'D', name: 'Test', duration: 1, predecessors: ['B', 'C']),
];

/// Aufgaben zu Bereich 01, Teil 1 (Projektorganisation, Vorgehensmodelle,
/// Scrum, Netzplantechnik). Bestehende IDs bleiben unverändert - der
/// Lernfortschritt ist daran gespeichert.
final List<Question> questionsA01Journey = [
  // ===================================================== Was ein Projekt ausmacht
  einfach(
    'a1-pb-1',
    'p-begriff',
    prompt: 'Welches Vorhaben ist ein Projekt?',
    choices: [
      ja(
        'Die erstmalige Einführung eines Ticketsystems bis Ende Juni mit festem Budget',
        'Einmalig, mit Ziel, Termin und Budget - alle Merkmale eines Projekts sind erfüllt.',
      ),
      nein(
        'Das wöchentliche Prüfen der Datensicherung',
        'Wiederkehrende Routine in der Linie - kein einmaliges Vorhaben.',
      ),
      nein(
        'Die monatliche Gehaltsabrechnung',
        'Eine klassische Linienaufgabe mit eingespieltem Ablauf.',
      ),
      nein(
        'Der laufende Betrieb des Mailservers',
        'Eine Daueraufgabe ohne festes Ende.',
      ),
    ],
    explanation:
        'Ein Projekt ist einmalig, zielgerichtet und zeitlich wie finanziell begrenzt. Alle anderen Beispiele wiederholen sich oder laufen dauerhaft - sie gehören zum Tagesgeschäft.',
  ),
  mehrfach(
    'a1-pb-2',
    'p-begriff',
    prompt: 'Welche Aussagen über Projekte sind richtig?',
    choices: [
      ja(
        'Ein Projekt hat einen festgelegten Anfang und ein festgelegtes Ende.',
        'Die zeitliche Begrenzung gehört zu den Kernmerkmalen.',
      ),
      ja(
        'Projekte haben meist eine eigene, zeitlich begrenzte Organisation.',
        'Rollen wie Projektleitung und Projektteam bestehen nur für die Projektdauer.',
      ),
      nein(
        'Ein Vorhaben ist erst ab einem Budget von 10.000 € ein Projekt.',
        'Größe und Budget sind keine Merkmale - entscheidend ist die Einmaligkeit.',
      ),
      nein(
        'Projekte wiederholen sich regelmäßig in gleicher Form.',
        'Das beschreibt eine Linienaufgabe.',
      ),
      ja(
        'Projekte bergen durch ihre Neuartigkeit höhere Risiken als Routineaufgaben.',
        'Weil Erfahrungswerte fehlen, ist die Unsicherheit größer.',
      ),
    ],
    explanation:
        'Projekte sind einmalig und begrenzt, haben eine eigene Organisation und tragen wegen ihrer Neuartigkeit mehr Risiko. Eine Mindestgröße gibt es nicht.',
  ),
  zuordnen(
    'a1-pb-3',
    'p-begriff',
    scenario:
        'Die IT-Abteilung eines Großhändlers sammelt ihre Aufgaben für das kommende Jahr.',
    prompt: 'Ordne jedes Vorhaben richtig ein.',
    buckets: ['Projekt', 'Linienaufgabe'],
    items: [
      zu(
        'Erstmalige Einführung eines ERP-Systems bis Jahresende',
        0,
        'Einmalig, mit festem Ende und eigenem Team.',
      ),
      zu(
        'Tägliche Kontrolle der Datensicherung',
        1,
        'Wiederkehrende Routine ohne Ende.',
      ),
      zu(
        'Umzug des Serverraums in ein externes Rechenzentrum',
        0,
        'Einmaliges Vorhaben mit Termin und Budget.',
      ),
      zu(
        'Monatliches Einspielen von Sicherheitsupdates',
        1,
        'Eingespielter, wiederkehrender Ablauf.',
      ),
      zu(
        'Entwicklung einer App für einen Kunden',
        0,
        'Einmalig, mit Ziel, Termin und Budget.',
      ),
      zu(
        'Passwörter im Support zurücksetzen',
        1,
        'Daueraufgabe des Tagesgeschäfts.',
      ),
    ],
    explanation:
        'Projekte sind einmalig, zielgerichtet und begrenzt. Wiederkehrende oder dauerhafte Tätigkeiten sind Linienaufgaben - auch wenn sie umfangreich sind.',
    difficulty: 1,
  ),
  einfach(
    'a1-pb-4',
    'p-begriff',
    scenario:
        'Die Geschäftsführung der Müller GmbH legt fest, dass jedes Vorhaben ab 20.000 € Budget als Projekt geführt wird. Ein Kollege folgert: „Unter 20.000 € gibt es bei uns also keine Projekte.“',
    prompt: 'Wie ist die Aussage nach DIN 69901 zu bewerten?',
    choices: [
      ja(
        'Falsch - die Grenze ist eine interne Regel; nach der Norm entscheidet die Einmaligkeit der Bedingungen, nicht das Budget.',
        'Die DIN 69901 kennt keine Wertgrenze. Unternehmen dürfen intern Schwellen festlegen, das ändert aber nichts am Projektbegriff.',
      ),
      nein(
        'Richtig - die DIN 69901 schreibt ein Mindestbudget von 20.000 € vor.',
        'Eine solche Grenze gibt es in der Norm nicht.',
      ),
      nein(
        'Richtig - kleine Vorhaben sind immer Linienaufgaben.',
        'Auch ein kleines, einmaliges Vorhaben mit Ziel und Begrenzung ist ein Projekt.',
      ),
      nein(
        'Falsch - Projekte beginnen erst ab 50.000 €.',
        'Auch diese Grenze ist frei erfunden; Größe ist kein Projektmerkmal.',
      ),
    ],
    explanation:
        'Nach DIN 69901 ist ein Projekt durch die Einmaligkeit der Bedingungen in ihrer Gesamtheit gekennzeichnet (Ziel, Begrenzung, Abgrenzung, eigene Organisation). Budget oder Teamgröße sind keine Kriterien.',
  ),
  mehrfach(
    'a1-pb-5',
    'p-begriff',
    scenario: 'Die IT-Leitung eines Pflegedienstes plant mehrere Vorhaben.',
    prompt: 'Welche davon sind Projekte?',
    choices: [
      ja(
        'Einführung einer neuen Firewall-Lösung bis Quartalsende mit eigenem Budget',
        'Einmalig, begrenzt und mit klarem Ziel.',
      ),
      nein(
        'Wöchentliche Auswertung der Firewall-Protokolle',
        'Wiederkehrende Routine.',
      ),
      ja(
        'Umstellung aller Standorte auf Internettelefonie innerhalb von sechs Monaten',
        'Einmaliges Vorhaben mit Termin.',
      ),
      nein('Laufende Wartung der Drucker', 'Daueraufgabe ohne Ende.'),
      ja(
        'Dreimonatiger Test von Tablets für die mobile Pflegedokumentation',
        'Auch ein Pilotversuch ist einmalig und begrenzt - also ein Projekt.',
      ),
    ],
    explanation:
        'Entscheidend ist, ob ein Vorhaben einmalig, zielgerichtet und zeitlich begrenzt ist. Wiederkehrende Tätigkeiten wie Protokollauswertung oder Wartung bleiben Linienaufgaben.',
  ),
  einfach(
    'a1-pb-6',
    'p-begriff',
    prompt:
        'Welche Beschreibung passt zum Begriff Projektmanagement nach DIN 69901?',
    choices: [
      ja(
        'Gesamtheit von Führungsaufgaben, -organisation, -techniken und -mitteln für Initiierung, Definition, Planung, Steuerung und Abschluss von Projekten',
        'So definiert die Norm Projektmanagement.',
      ),
      nein(
        'Die fachliche Umsetzung der Arbeitspakete durch das Projektteam',
        'Das ist die Projektarbeit selbst, nicht deren Management.',
      ),
      nein(
        'Die dauerhafte Leitung einer Abteilung',
        'Das ist Linienführung, kein Projektmanagement.',
      ),
      nein(
        'Ausschließlich das Erstellen von Netzplänen',
        'Der Netzplan ist nur eine von vielen Techniken des Projektmanagements.',
      ),
    ],
    explanation:
        'Projektmanagement umfasst alles, was ein Projekt führt: planen, organisieren, steuern, kontrollieren und kommunizieren - von der Initiierung bis zum Abschluss.',
    difficulty: 1,
  ),

  // ====================================== Projektziele und magisches Dreieck
  einfach(
    'a1-pz-1',
    'p-ziele',
    prompt: 'Welches Ziel ist SMART formuliert?',
    choices: [
      ja(
        'Bis 31.03. sind alle 40 Arbeitsplätze auf Windows 11 umgestellt, kein Arbeitsplatz fällt dabei länger als zwei Stunden aus.',
        'Spezifisch, messbar (40 Plätze, 2 Stunden), realistisch und mit Termin.',
      ),
      nein(
        'Die IT soll moderner werden.',
        'Weder spezifisch noch messbar noch terminiert.',
      ),
      nein(
        'Möglichst bald sollen alle Rechner schneller laufen.',
        '„Möglichst bald“ ist kein Termin, „schneller“ keine Messgröße.',
      ),
      nein(
        'Ab sofort gilt 100 % Verfügbarkeit für alle Systeme.',
        'Nicht realistisch - keine IT erreicht dauerhaft 100 %.',
      ),
    ],
    explanation:
        'SMART heißt spezifisch, messbar, attraktiv bzw. akzeptiert, realistisch und terminiert. Nur das erste Ziel lässt sich am Stichtag eindeutig prüfen.',
  ),
  zuordnen(
    'a1-pz-2',
    'p-ziele',
    scenario:
        'Im Projektauftrag für ein neues Ticketsystem stehen mehrere Ziele.',
    prompt: 'Ordne jedes Ziel der passenden Zielart zu.',
    buckets: ['Sachziel', 'Terminziel', 'Kostenziel'],
    items: [
      zu(
        'Das System verarbeitet 500 Tickets pro Stunde.',
        0,
        'Beschreibt Leistung und Qualität des Ergebnisses.',
      ),
      zu('Go-live spätestens am 30.06.', 1, 'Legt fest, bis wann.'),
      zu(
        'Das Projektbudget beträgt höchstens 40.000 €.',
        2,
        'Legt fest, was es kosten darf.',
      ),
      zu(
        'Alle 60 Mitarbeitenden sind im neuen System geschult.',
        0,
        'Beschreibt ein Ergebnis, also die Leistung.',
      ),
      zu(
        'Das Pflichtenheft ist bis KW 12 freigegeben.',
        1,
        'Ein Zwischentermin (Meilenstein).',
      ),
      zu(
        'Die Lizenzkosten liegen bei höchstens 500 € im Monat.',
        2,
        'Eine Kostenvorgabe.',
      ),
    ],
    explanation:
        'Sachziele beschreiben, was in welcher Qualität entsteht, Terminziele bis wann, Kostenziele was es kosten darf. Zusammen bilden sie die drei Ecken des magischen Dreiecks.',
    difficulty: 1,
  ),
  einfach(
    'a1-pz-3',
    'p-ziele',
    scenario:
        'Kurz vor Projektende wünscht der Kunde zwei zusätzliche Funktionen. Der Go-live-Termin darf sich nicht verschieben, und an der Qualität soll nicht gespart werden.',
    prompt: 'Was folgt daraus nach dem magischen Dreieck?',
    choices: [
      ja(
        'Die Kosten steigen, zum Beispiel für zusätzliches Personal oder Überstunden.',
        'Mehr Leistung bei festem Termin geht nur mit mehr Ressourcen - also höheren Kosten.',
      ),
      nein(
        'Nichts - zusätzliche Funktionen verändern das Dreieck nicht.',
        'Mehr Funktionen sind mehr Leistung; eine andere Ecke muss nachgeben.',
      ),
      nein(
        'Die Kosten sinken, weil schneller gearbeitet wird.',
        'Schnelleres Arbeiten bei mehr Umfang kostet mehr, nicht weniger.',
      ),
      nein(
        'Der Termin verschiebt sich automatisch.',
        'Der Termin ist laut Aufgabe fest - er ist gerade nicht der Stellhebel.',
      ),
    ],
    explanation:
        'Leistung steigt, Zeit und Qualität sind fest. Im magischen Dreieck bleibt nur eine Größe, die nachgeben kann: die Kosten.',
  ),
  einfach(
    'a1-pz-4',
    'p-ziele',
    scenario:
        'Ziel 1: Das Projekt soll zwei Monate früher fertig werden. Ziel 2: Die Projektkosten sollen um 10 % sinken.',
    prompt: 'Welche Zielbeziehung liegt vor?',
    choices: [
      ja(
        'Konkurrierend',
        'Früher fertig werden braucht meist mehr Personal oder Überstunden - das erschwert das Sparziel.',
      ),
      nein(
        'Komplementär',
        'Komplementäre Ziele fördern sich gegenseitig; diese beiden behindern sich.',
      ),
      nein(
        'Indifferent',
        'Indifferente Ziele beeinflussen sich nicht - Zeit und Kosten hängen aber eng zusammen.',
      ),
      nein(
        'Identisch',
        'Die Ziele betreffen unterschiedliche Größen: Zeit und Kosten.',
      ),
    ],
    explanation:
        'Zeit und Kosten sind zwei Ecken des magischen Dreiecks. Wird die eine verbessert, gerät die andere meist unter Druck - die Ziele konkurrieren und müssen priorisiert werden.',
  ),
  mehrfach(
    'a1-pz-5',
    'p-ziele',
    scenario:
        'Im Projektauftrag steht: „Wir wollen die Kundenzufriedenheit deutlich verbessern.“',
    prompt: 'Welche SMART-Kriterien erfüllt dieses Ziel nicht?',
    choices: [
      ja(
        'Messbar',
        '„Deutlich“ ist keine Kennzahl - es fehlt ein Messwert wie eine Note oder ein Prozentsatz.',
      ),
      ja(
        'Terminiert',
        'Es gibt kein Datum, bis wann das Ziel erreicht sein soll.',
      ),
      nein(
        'Attraktiv / akzeptiert',
        'Ob das Ziel mitgetragen wird, lässt sich aus der Formulierung nicht ablesen - bessere Kundenzufriedenheit ist grundsätzlich gewünscht.',
      ),
      nein(
        'Es beschreibt eine Maßnahme statt eines Zustands.',
        'Kein SMART-Kriterium - und das Ziel beschreibt tatsächlich einen gewünschten Zustand.',
      ),
    ],
    explanation:
        'Ein SMART-Ziel wäre zum Beispiel: „Bis 31.12. steigt die durchschnittliche Bewertung in der Kundenumfrage von 3,4 auf mindestens 4,0 von 5 Punkten.“ Erst Kennzahl und Termin machen das Ziel prüfbar.',
  ),
  einfach(
    'a1-pz-6',
    'p-ziele',
    scenario:
        'Während der Einführung eines Online-Shops bittet der Vertriebsleiter „nebenbei“ um eine Anbindung an das Warenwirtschaftssystem. Im Projektauftrag ist sie nicht erwähnt.',
    prompt: 'Wie heißt die Gefahr, und was beugt ihr vor?',
    choices: [
      ja(
        'Scope Creep - ausdrücklich formulierte Nicht-Ziele im Projektauftrag',
        'Der Umfang wächst schleichend ohne mehr Zeit und Budget. Nicht-Ziele machen klar, was nicht dazugehört.',
      ),
      nein(
        'Gold Plating - mehr Tests einplanen',
        'Gold Plating heißt, das Team baut von sich aus Extras ein. Hier kommt der Wunsch von außen.',
      ),
      nein(
        'Brooks’ Law - zusätzliches Personal einstellen',
        'Brooks’ Law beschreibt, dass zusätzliches Personal ein verspätetes Projekt weiter verzögert - passt nicht zur Situation.',
      ),
      nein(
        'Kritischer Pfad - einen Netzplan erstellen',
        'Der Netzplan hilft bei Terminen, verhindert aber keine Umfangsausweitung.',
      ),
    ],
    explanation:
        'Scope Creep ist die schleichende Ausweitung des Projektumfangs. Nicht-Ziele im Projektauftrag und ein formales Änderungsverfahren schützen davor: Neue Wünsche werden bewertet und bei Bedarf mit mehr Zeit oder Budget beauftragt.',
  ),

  // ====================================================== Organisationsformen
  einfach(
    'a1-po-1',
    'p-organisation',
    scenario:
        'Ein Unternehmen führt ein neues ERP-System ein. Das Projekt dauert 18 Monate, hat hohe strategische Bedeutung, und das Team arbeitet in Vollzeit daran.',
    prompt: 'Welche Form der Projektorganisation passt am besten?',
    choices: [
      ja(
        'Reine Projektorganisation',
        'Lang, groß, strategisch und in Vollzeit: Genau dafür wird das Team aus der Linie herausgelöst.',
      ),
      nein(
        'Matrix-Organisation',
        'Passt, wenn Mitarbeitende nur teilweise im Projekt sind - hier arbeiten sie in Vollzeit daran.',
      ),
      nein(
        'Stabs-/Einflussorganisation',
        'Zu schwach: Die Projektleitung könnte in einem so großen Projekt nichts durchsetzen.',
      ),
      nein(
        'Linienorganisation',
        'Das ist keine Form der Projektorganisation, sondern die normale Aufbauorganisation.',
      ),
    ],
    explanation:
        'Je größer, länger und bedeutender ein Projekt ist, desto eher lohnt sich die reine Projektorganisation mit voller Weisungsbefugnis der Projektleitung.',
  ),
  mehrfach(
    'a1-po-2',
    'p-organisation',
    prompt: 'Welche Aussagen treffen auf die Matrix-Projektorganisation zu?',
    choices: [
      ja(
        'Die Projektleitung hat fachliche Weisungsbefugnis.',
        'Sie bestimmt, was und wie im Projekt gearbeitet wird.',
      ),
      ja(
        'Mitarbeitende haben zwei Vorgesetzte - im Projekt und in der Linie.',
        'Das ist das Kennzeichen der Matrix.',
      ),
      nein(
        'Die Projektleitung entscheidet über Urlaub und Gehalt der Teammitglieder.',
        'Das ist disziplinarische Weisung - sie bleibt in der Matrix bei der Linie.',
      ),
      ja(
        'Es kann zu Konflikten um Prioritäten kommen.',
        'Wenn Linie und Projekt gleichzeitig Zeit beanspruchen, entsteht Konfliktpotenzial.',
      ),
      nein(
        'Das Team wird für die Projektdauer vollständig aus der Linie herausgelöst.',
        'Das beschreibt die reine Projektorganisation.',
      ),
    ],
    explanation:
        'In der Matrix ist die Weisungsbefugnis geteilt: fachlich beim Projekt, disziplinarisch in der Linie. Das nutzt Ressourcen flexibel, erzeugt aber Prioritätenkonflikte.',
  ),
  einfach(
    'a1-po-3',
    'p-organisation',
    skizze: const BaumDiagramm(
      BaumKnoten('Geschäftsführung', [
        BaumKnoten('Projektkoordination', [], 'Stabsstelle'),
        BaumKnoten('Vertrieb', [BaumKnoten('Mitarbeitende')]),
        BaumKnoten('IT', [BaumKnoten('Mitarbeitende')]),
      ]),
    ),
    prompt: 'Welche Form der Projektorganisation zeigt das Organigramm?',
    choices: [
      ja(
        'Stabs-/Einflussorganisation',
        'Die Projektkoordination hängt als Stabsstelle an der Geschäftsführung; die Mitarbeitenden bleiben in ihren Abteilungen.',
      ),
      nein(
        'Reine Projektorganisation',
        'Dann gäbe es eine eigene Projekteinheit, der die Teammitglieder direkt unterstellt sind.',
      ),
      nein(
        'Matrix-Organisation',
        'Die Matrix zeigt sich als Kreuzung von Abteilungen und Projekten - jede Person hätte zwei Vorgesetzte.',
      ),
      nein(
        'Lenkungsausschuss',
        'Das ist ein Gremium, keine Organisationsform.',
      ),
    ],
    explanation:
        'Eine Stabsstelle berät und koordiniert, hat aber keine Weisungsbefugnis. Typisch für die Einflussorganisation: Die Projektleitung sitzt neben der Linie, die Entscheidungen trifft weiter die Linie.',
  ),
  einfach(
    'a1-po-4',
    'p-organisation',
    scenario:
        'Frau Kaya arbeitet zu 50 % im Projekt „Neues CRM“. Sie möchte im August zwei Wochen Urlaub nehmen. Das Unternehmen nutzt die Matrix-Projektorganisation.',
    prompt: 'Wer genehmigt den Urlaub?',
    choices: [
      ja(
        'Ihr Linienvorgesetzter',
        'Urlaub ist eine disziplinarische Angelegenheit - die bleibt in der Matrix bei der Linie. Sinnvollerweise stimmt er sich mit der Projektleitung ab.',
      ),
      nein(
        'Die Projektleitung',
        'Sie hat nur fachliche Weisungsbefugnis: Aufgaben, Termine, Qualität.',
      ),
      nein(
        'Der Lenkungsausschuss',
        'Er entscheidet über den Projektrahmen, nicht über Urlaub einzelner Personen.',
      ),
      nein(
        'Der Auftraggeber',
        'Er beauftragt das Projekt, führt aber keine Mitarbeitenden.',
      ),
    ],
    explanation:
        'In der Matrix führt die Projektleitung fachlich (was und wie), die Linie disziplinarisch (Urlaub, Beurteilung, Gehalt).',
  ),
  zuordnen(
    'a1-po-5',
    'p-organisation',
    prompt:
        'Ordne jeden Vor- oder Nachteil der passenden Organisationsform zu.',
    buckets: [
      'Reine Projektorganisation',
      'Matrix-Organisation',
      'Stabs-/Einflussorganisation',
    ],
    items: [
      zu(
        'Nach Projektende müssen alle in die Linie zurückkehren.',
        0,
        'Das Rückkehrproblem entsteht nur, wenn das Team herausgelöst wurde.',
      ),
      zu(
        'Das Team identifiziert sich stark mit dem Projekt.',
        0,
        'Volle Zeit, ein Vorgesetzter, ein Ziel.',
      ),
      zu(
        'Mitarbeitende haben zwei Vorgesetzte.',
        1,
        'Fachlich die Projektleitung, disziplinarisch die Linie.',
      ),
      zu(
        'Spezialisten können flexibel in mehreren Projekten arbeiten.',
        1,
        'Sie bleiben in der Linie und arbeiten anteilig mit.',
      ),
      zu(
        'Die Projektleitung kann Entscheidungen nicht durchsetzen.',
        2,
        'Sie hat keine Weisungsbefugnis.',
      ),
      zu(
        'Keine Umorganisation nötig, sehr geringer Aufwand.',
        2,
        'Alle bleiben, wo sie sind; nur eine koordinierende Stelle kommt hinzu.',
      ),
    ],
    explanation:
        'Rein: klare Macht, hoher Aufwand, Rückkehrproblem. Matrix: flexibel, aber zwei Vorgesetzte. Einfluss: billig, aber ohne Durchsetzungskraft.',
  ),
  einfach(
    'a1-po-6',
    'p-organisation',
    scenario:
        'Ein Mittelständler überarbeitet die Startseite seines Intranets. Dauer sechs Wochen, geringes Risiko, alle Beteiligten arbeiten nur nebenbei mit.',
    prompt: 'Welche Form der Projektorganisation ist angemessen?',
    choices: [
      ja(
        'Stabs-/Einflussorganisation',
        'Klein, kurz, risikoarm und nebenbei - eine koordinierende Projektleitung genügt.',
      ),
      nein(
        'Reine Projektorganisation',
        'Viel zu aufwendig: Niemand muss dafür aus seiner Abteilung herausgelöst werden.',
      ),
      nein(
        'Matrix-Organisation',
        'Möglich, aber für ein so kleines Vorhaben mehr Aufwand als nötig.',
      ),
      nein(
        'Gar keine Organisation',
        'Auch ein kleines Projekt braucht klare Zuständigkeiten.',
      ),
    ],
    explanation:
        'Die Organisationsform richtet sich nach Größe, Dauer, Risiko und Einbindung der Mitarbeitenden. Kleine, risikoarme Projekte werden meist in der Einflussorganisation abgewickelt.',
  ),

  // =========================================================== Rollen im Projekt
  zuordnen(
    'a1-pr-1',
    'p-rollen',
    prompt: 'Ordne jede Aufgabe der zuständigen Rolle zu.',
    buckets: [
      'Auftraggeber',
      'Lenkungsausschuss',
      'Projektleitung',
      'Projektteam',
    ],
    items: [
      zu('Gibt das Projekt in Auftrag und stellt das Budget bereit', 0),
      zu('Entscheidet nach einer Eskalation über eine Budgeterhöhung', 1),
      zu('Erstellt den Terminplan und verfolgt den Fortschritt', 2),
      zu('Setzt ein Arbeitspaket um', 3),
      zu('Nimmt das Ergebnis am Projektende ab', 0),
      zu('Schreibt den monatlichen Statusbericht', 2),
    ],
    explanation:
        'Der Auftraggeber beauftragt, finanziert und nimmt ab. Der Lenkungsausschuss entscheidet über Änderungen des Rahmens. Die Projektleitung plant, steuert und berichtet, das Team setzt um.',
  ),
  einfach(
    'a1-pr-2',
    'p-rollen',
    scenario:
        'Mitten im Projekt stellt die Projektleiterin fest, dass das Budget um 20 % überschritten wird, wenn der vereinbarte Umfang geliefert werden soll.',
    prompt: 'Wie geht sie richtig vor?',
    choices: [
      ja(
        'Sie eskaliert an den Lenkungsausschuss, der über Budget oder Umfang entscheidet.',
        'Budget und Umfang sind Teil des Auftrags - darüber entscheidet das Gremium, nicht die Projektleitung.',
      ),
      nein(
        'Sie streicht eigenständig zwei Funktionen.',
        'Damit ändert sie den Auftrag, ohne dazu befugt zu sein.',
      ),
      nein(
        'Sie überzieht das Budget, weil der Umfang vereinbart ist.',
        'Eine Überschreitung ohne Freigabe ist ebenfalls eine Änderung des Auftrags.',
      ),
      nein(
        'Sie wartet bis zum Projektende und erklärt die Abweichung im Abschlussbericht.',
        'Je später ein Problem gemeldet wird, desto weniger Handlungsspielraum bleibt.',
      ),
    ],
    explanation:
        'Die Projektleitung steuert innerhalb des Auftrags. Droht der Rahmen gesprengt zu werden, muss sie frühzeitig eskalieren und eine Entscheidung herbeiführen.',
  ),
  mehrfach(
    'a1-pr-3',
    'p-rollen',
    prompt: 'Was gehört typischerweise in ein Kick-off-Meeting?',
    choices: [
      ja(
        'Ziele und Nicht-Ziele des Projekts vorstellen',
        'Das gemeinsame Verständnis der Ziele ist der wichtigste Zweck des Kick-offs.',
      ),
      ja(
        'Rollen und Zuständigkeiten klären',
        'Jede Person muss wissen, wer wofür verantwortlich ist.',
      ),
      ja(
        'Kommunikationswege und Spielregeln vereinbaren',
        'Zum Beispiel Termine für Statusmeetings und Kanäle für Rückfragen.',
      ),
      nein(
        'Das Projektergebnis abnehmen',
        'Die Abnahme steht am Ende des Projekts, nicht am Anfang.',
      ),
      nein(
        'Detaillierte Code-Reviews durchführen',
        'Zum Projektstart gibt es noch keinen Code - und Reviews sind keine Aufgabe des Kick-offs.',
      ),
    ],
    explanation:
        'Das Kick-off ist der offizielle Start mit allen Beteiligten. Es schafft ein gemeinsames Verständnis von Zielen, Rollen und Zusammenarbeit.',
  ),
  einfach(
    'a1-pr-4',
    'p-rollen',
    scenario:
        'In der RACI-Matrix eines Projekts steht in der Zeile „Abnahme des Systems“ beim Auftraggeber ein A.',
    prompt: 'Was bedeutet das?',
    choices: [
      ja(
        'Der Auftraggeber verantwortet die Abnahme und entscheidet darüber.',
        'A steht für Accountable: verantwortlich für das Ergebnis, trifft die Entscheidung.',
      ),
      nein(
        'Der Auftraggeber wird über die Abnahme nur informiert.',
        'Das wäre I - Informed.',
      ),
      nein(
        'Der Auftraggeber wird vorher um Rat gefragt.',
        'Das wäre C - Consulted.',
      ),
      nein(
        'Der Auftraggeber führt die Abnahmetests selbst durch.',
        'Das wäre R - Responsible. R und A können zusammenfallen, A allein heißt aber „verantwortet und entscheidet“.',
      ),
    ],
    explanation:
        'RACI: R = Responsible (führt durch), A = Accountable (verantwortet, entscheidet; genau eine Person je Aufgabe), C = Consulted (wird gefragt), I = Informed (wird informiert).',
  ),
  reihenfolge(
    'a1-pr-5',
    'p-rollen',
    scenario:
        'Ein Problem im Projekt lässt sich auf der jeweiligen Ebene nicht lösen und muss weitergegeben werden.',
    prompt:
        'Bringe die Stufen des Eskalationswegs in die richtige Reihenfolge.',
    items: [
      'Teammitglied versucht, das Problem im Arbeitspaket zu lösen',
      'Projektleitung entscheidet im Rahmen des Projektauftrags',
      'Lenkungsausschuss entscheidet über Budget, Termin oder Umfang',
      'Geschäftsführung entscheidet über Fortsetzung oder Abbruch',
    ],
    explanation:
        'Probleme werden auf der niedrigsten Ebene gelöst, die dazu befugt ist. Erst wenn die Befugnis nicht reicht, geht die Entscheidung eine Stufe höher - bis im Extremfall über Fortsetzung oder Abbruch entschieden wird.',
    difficulty: 1,
  ),
  einfach(
    'a1-pr-6',
    'p-rollen',
    scenario:
        'Im Statusbericht meldet die Projektleitung: Termine gelb, Kosten rot, Leistung grün.',
    prompt: 'Was bedeutet die rote Ampel bei den Kosten?',
    choices: [
      ja(
        'Der Kostenrahmen ist gefährdet; es braucht eine Entscheidung des Lenkungsausschusses.',
        'Rot heißt: Die Projektleitung kann die Abweichung im Rahmen ihres Auftrags nicht mehr ausgleichen.',
      ),
      nein('Die Kosten liegen genau im Plan.', 'Das wäre grün.'),
      nein(
        'Es gibt eine Abweichung, die die Projektleitung selbst ausgleicht.',
        'Das beschreibt gelb.',
      ),
      nein(
        'Das Projekt ist damit automatisch abgebrochen.',
        'Über einen Abbruch entscheiden Auftraggeber bzw. Lenkungsausschuss - rot ist ein Warnsignal, keine Entscheidung.',
      ),
    ],
    explanation:
        'Die Ampel im Statusbericht: grün = im Plan, gelb = Abweichung, die die Projektleitung selbst steuert, rot = Rahmen gefährdet, Entscheidung von oben nötig.',
  ),
  mehrfach(
    'a1-pr-7',
    'p-rollen',
    prompt: 'Welche Aufgaben gehören zur Projektleitung?',
    choices: [
      ja(
        'Terminplan erstellen und fortschreiben',
        'Planen ist Kernaufgabe der Projektleitung.',
      ),
      ja(
        'Soll-Ist-Vergleiche durchführen und gegensteuern',
        'Steuern und Kontrollieren gehören dazu.',
      ),
      ja(
        'Statusberichte an den Lenkungsausschuss schreiben',
        'Berichten ist Pflicht der Projektleitung.',
      ),
      nein(
        'Eine Budgeterhöhung genehmigen',
        'Das entscheidet der Lenkungsausschuss bzw. der Auftraggeber.',
      ),
      nein(
        'Das Projektergebnis abnehmen',
        'Die Abnahme ist Sache des Auftraggebers.',
      ),
    ],
    explanation:
        'Die Projektleitung plant, organisiert, führt, steuert und berichtet - innerhalb des Auftrags. Entscheidungen über den Rahmen und die Abnahme liegen beim Auftraggeber und beim Lenkungsausschuss.',
  ),
  einfach(
    'a1-pr-8',
    'p-rollen',
    scenario:
        'Eine Projektleiterin soll für die Einhaltung des Budgets verantwortlich sein, darf aber keine einzige Bestellung selbst freigeben.',
    prompt: 'Gegen welches Prinzip verstößt diese Regelung?',
    choices: [
      ja(
        'Kongruenzprinzip - Aufgabe, Kompetenz und Verantwortung müssen übereinstimmen',
        'Wer Verantwortung trägt, braucht die passenden Befugnisse.',
      ),
      nein(
        'Minimalprinzip',
        'Ein Grundsatz der Wirtschaftlichkeit - hat mit Rollen nichts zu tun.',
      ),
      nein(
        'Prinzip der Einmaligkeit',
        'Ein Merkmal von Projekten, kein Organisationsprinzip.',
      ),
      nein(
        'Pareto-Prinzip',
        'Die 80/20-Regel betrifft Prioritäten, nicht die Rollengestaltung.',
      ),
    ],
    explanation:
        'Nach dem Kongruenzprinzip (AKV-Prinzip) müssen Aufgaben, Kompetenzen und Verantwortung deckungsgleich sein. Ohne Befugnisse kann niemand sinnvoll für ein Ergebnis geradestehen.',
    difficulty: 3,
  ),

  // ===================================================== Stakeholder analysieren
  zuordnen(
    'a1-ps-1',
    'p-stakeholder',
    prompt:
        'Ordne jeder Gruppe die passende Strategie der Stakeholder-Matrix zu.',
    buckets: ['eng einbinden', 'zufriedenstellen', 'informieren', 'beobachten'],
    items: [
      zu('Geschäftsführung: hoher Einfluss, großes Interesse', 0),
      zu('Betriebsrat: hoher Einfluss, zunächst geringes Interesse', 1),
      zu('Anwender der Buchhaltung: geringer Einfluss, großes Interesse', 2),
      zu('Reinigungsdienst: geringer Einfluss, geringes Interesse', 3),
    ],
    explanation:
        'Hoch/hoch: eng einbinden. Hoch/gering: zufriedenstellen. Gering/hoch: informieren. Gering/gering: beobachten. Der Betriebsrat ist das klassische Beispiel für „zufriedenstellen“.',
  ),
  reihenfolge(
    'a1-ps-2',
    'p-stakeholder',
    prompt:
        'Bringe die Schritte der Stakeholderanalyse in die richtige Reihenfolge.',
    items: [
      'Stakeholder identifizieren',
      'Einfluss, Interesse und Einstellung einschätzen',
      'In die Stakeholder-Matrix einordnen',
      'Maßnahmen festlegen und umsetzen',
    ],
    explanation:
        'Erst muss klar sein, wer betroffen ist. Dann wird eingeschätzt und eingeordnet, zuletzt werden daraus Maßnahmen abgeleitet - und die Analyse wird im Projektverlauf aktualisiert.',
  ),
  einfach(
    'a1-ps-3',
    'p-stakeholder',
    scenario:
        'Die Beschäftigten der Buchhaltung werden täglich mit der neuen Software arbeiten. Auf Projektentscheidungen haben sie kaum Einfluss.',
    prompt: 'Welche Strategie ist für diese Gruppe angemessen?',
    choices: [
      ja(
        'Informieren - regelmäßig über Stand und Schulungen auf dem Laufenden halten',
        'Geringer Einfluss, hohes Interesse: Die Gruppe will und muss Bescheid wissen.',
      ),
      nein(
        'Eng einbinden - an allen Entscheidungen beteiligen',
        'Das gilt für hohen Einfluss und hohes Interesse.',
      ),
      nein(
        'Zufriedenstellen - nur knapp berichten',
        'Das gilt für hohen Einfluss und geringes Interesse.',
      ),
      nein(
        'Beobachten - kaum Aufwand',
        'Das gilt, wenn Einfluss und Interesse gering sind.',
      ),
    ],
    explanation:
        'Im Stakeholder-Portfolio liegt die Buchhaltung unten rechts: geringer Einfluss, hohes Interesse → informieren, etwa per Newsletter, Demo-Termin und Schulungsplan.',
    difficulty: 1,
  ),
  mehrfach(
    'a1-ps-4',
    'p-stakeholder',
    scenario: 'Ein Energieversorger führt ein Online-Kundenportal ein.',
    prompt: 'Welche Stakeholder sind extern?',
    choices: [
      ja(
        'Kundinnen und Kunden',
        'Sie gehören nicht zum Unternehmen, nutzen aber das Portal.',
      ),
      ja('Der Hosting-Dienstleister', 'Ein externer Vertragspartner.'),
      ja(
        'Die Datenschutz-Aufsichtsbehörde',
        'Eine Behörde außerhalb des Unternehmens.',
      ),
      nein(
        'Der Betriebsrat',
        'Er vertritt die eigenen Beschäftigten - ein interner Stakeholder.',
      ),
      nein(
        'Die Vertriebsabteilung',
        'Eine Abteilung des eigenen Unternehmens.',
      ),
    ],
    explanation:
        'Interne Stakeholder gehören zum eigenen Unternehmen (Abteilungen, Beschäftigte, Betriebsrat, Geschäftsführung). Externe stehen außerhalb: Kunden, Lieferanten, Dienstleister, Behörden.',
  ),
  einfach(
    'a1-ps-5',
    'p-stakeholder',
    scenario:
        'Ein Unternehmen führt ein Ticketsystem ein, das für jede Mitarbeiterin speichert, wie lange sie für jedes Ticket braucht.',
    prompt: 'Warum muss der Betriebsrat frühzeitig einbezogen werden?',
    choices: [
      ja(
        'Er hat ein Mitbestimmungsrecht bei technischen Einrichtungen, mit denen sich Leistung oder Verhalten der Beschäftigten überwachen lassen.',
        'So regelt es § 87 Abs. 1 Nr. 6 BetrVG. Ohne Einigung darf das System so nicht eingeführt werden.',
      ),
      nein(
        'Er muss jede Softwarebeschaffung genehmigen.',
        'Zu weit gefasst - sein Mitbestimmungsrecht hängt an der Überwachungsmöglichkeit.',
      ),
      nein(
        'Er ist grundsätzlich Auftraggeber aller IT-Projekte.',
        'Der Betriebsrat vertritt die Beschäftigten, er beauftragt keine Projekte.',
      ),
      nein(
        'Nur aus Höflichkeit - rechtlich spielt er keine Rolle.',
        'Falsch: Er hat hier ein gesetzliches Mitbestimmungsrecht.',
      ),
    ],
    explanation:
        'Systeme, die Leistungs- oder Verhaltensdaten erfassen, sind mitbestimmungspflichtig. Wird der Betriebsrat zu spät beteiligt, kann er die Einführung stoppen - deshalb gehört er früh in die Stakeholderanalyse.',
    difficulty: 3,
  ),
  zuordnen(
    'a1-ps-6',
    'p-stakeholder',
    prompt: 'Ordne jede Maßnahme der Strategie zu, zu der sie passt.',
    buckets: ['eng einbinden', 'zufriedenstellen', 'informieren', 'beobachten'],
    items: [
      zu('Sitz im Lenkungsausschuss', 0, 'Beteiligung an Entscheidungen.'),
      zu(
        'Gemeinsame Workshops zu den Anforderungen',
        0,
        'Aktive Mitgestaltung.',
      ),
      zu('Kurzer Statusbericht einmal im Monat', 1, 'Knapp, aber regelmäßig.'),
      zu('Newsletter mit Schulungsterminen', 2, 'Auf dem Laufenden halten.'),
      zu(
        'Gelegentlich prüfen, ob sich die Lage ändert',
        3,
        'Geringer Aufwand.',
      ),
    ],
    explanation:
        'Eng einbinden heißt mitentscheiden lassen, zufriedenstellen heißt knapp und regelmäßig abstimmen, informieren heißt auf dem Laufenden halten, beobachten heißt mit wenig Aufwand im Blick behalten.',
  ),
  einfach(
    'a1-ps-7',
    'p-stakeholder',
    prompt: 'Was legt ein Kommunikationsplan fest?',
    choices: [
      ja(
        'Wer welche Information wann und auf welchem Weg erhält',
        'Genau das ist sein Zweck - er folgt aus der Stakeholderanalyse.',
      ),
      nein(
        'In welcher Reihenfolge die Vorgänge ablaufen',
        'Das zeigt der Netzplan.',
      ),
      nein(
        'Welche Personen welches Gehalt bekommen',
        'Das ist keine Projektkommunikation.',
      ),
      nein(
        'Welche Risiken wie wahrscheinlich sind',
        'Das steht in der Risikoanalyse.',
      ),
    ],
    explanation:
        'Der Kommunikationsplan übersetzt die Stakeholderanalyse in konkrete Maßnahmen: Empfänger, Inhalt, Medium und Rhythmus - etwa „Lenkungsausschuss, Statusbericht, monatliche Sitzung“.',
    difficulty: 1,
  ),

  // ================================================================ Projektphasen
  reihenfolge(
    'a1-vp-1',
    'v-phasen',
    prompt:
        'Bringe die Projektphasen nach DIN 69901 in die richtige Reihenfolge.',
    items: [
      'Initialisierung',
      'Definition',
      'Planung',
      'Steuerung',
      'Abschluss',
    ],
    explanation:
        'Erst wird das Projekt beauftragt (Initialisierung), dann geklärt, was genau entstehen soll (Definition), dann geplant, umgesetzt und gesteuert, zuletzt abgeschlossen.',
  ),
  zuordnen(
    'a1-vp-2',
    'v-phasen',
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
        'Initialisierung: Auftrag. Definition: Ziele, Anforderungen, Machbarkeit. Planung: Struktur, Termine, Kosten. Abschluss: Bericht und Lessons Learned.',
  ),
  einfach(
    'a1-vp-3',
    'v-phasen',
    prompt: 'In welcher Phase wird der Projektstrukturplan erstellt?',
    choices: [
      ja(
        'Planung',
        'Der PSP ist die Grundlage aller weiteren Pläne und entsteht zu Beginn der Planung.',
      ),
      nein(
        'Definition',
        'Hier werden Ziele und Anforderungen geklärt - noch nicht die Arbeitsstruktur.',
      ),
      nein(
        'Initialisierung',
        'Hier geht es um die Idee und den Projektauftrag.',
      ),
      nein(
        'Steuerung',
        'In der Steuerung wird der Plan umgesetzt und überwacht, nicht erst erstellt.',
      ),
    ],
    explanation:
        'Die Planung beginnt mit dem Projektstrukturplan. Aus ihm entstehen Termin-, Ressourcen- und Kostenplan.',
  ),
  einfach(
    'a1-vp-4',
    'v-phasen',
    prompt: 'Was ist ein Meilenstein?',
    choices: [
      ja(
        'Ein Ereignis ohne Dauer, an dem ein prüfbares Zwischenergebnis vorliegt',
        'Meilensteine sind Zeitpunkte, keine Zeiträume.',
      ),
      nein(
        'Die längste Phase eines Projekts',
        'Eine Phase ist ein Zeitraum - ein Meilenstein hat keine Dauer.',
      ),
      nein(
        'Ein Arbeitspaket mit besonders hohem Aufwand',
        'Arbeitspakete verbrauchen Zeit und Ressourcen, Meilensteine nicht.',
      ),
      nein(
        'Das wöchentliche Statusmeeting',
        'Ein wiederkehrender Termin ist kein Meilenstein.',
      ),
    ],
    explanation:
        'Ein Meilenstein markiert meist das Ende einer Phase. An ihm wird geprüft, ob das Ergebnis vorliegt, und entschieden, ob die nächste Phase beginnen darf.',
    difficulty: 1,
  ),
  mehrfach(
    'a1-vp-5',
    'v-phasen',
    prompt: 'Welche Meilensteine sind gut formuliert?',
    choices: [
      ja(
        'Pflichtenheft vom Kunden unterschrieben',
        'Eindeutig prüfbar: unterschrieben oder nicht.',
      ),
      ja(
        'Alle 40 Access Points montiert und abgenommen',
        'Konkret und prüfbar.',
      ),
      ja(
        'Server geliefert und im Rack eingebaut',
        'Ein klarer, prüfbarer Zustand.',
      ),
      nein(
        'Konzept größtenteils fertig',
        '„Größtenteils“ lässt sich nicht eindeutig prüfen.',
      ),
      nein(
        'Programmierung läuft gut',
        'Eine Einschätzung, kein prüfbares Ergebnis.',
      ),
    ],
    explanation:
        'Ein guter Meilenstein ist binär prüfbar: Er ist erreicht oder nicht. Formulierungen wie „weitgehend“ oder „läuft gut“ lassen Raum für Interpretation und taugen nicht zur Steuerung.',
  ),
  einfach(
    'a1-vp-6',
    'v-phasen',
    scenario:
        'Das Team vergleicht jede Woche die geplanten mit den tatsächlich verbrauchten Stunden, leitet Gegenmaßnahmen ab und schreibt einen Statusbericht.',
    prompt: 'In welcher Projektphase befindet es sich?',
    choices: [
      ja(
        'Steuerung',
        'Soll-Ist-Vergleich, Gegenmaßnahmen und Statusberichte sind typisch für die Steuerung.',
      ),
      nein('Planung', 'In der Planung werden die Soll-Werte erst festgelegt.'),
      nein('Definition', 'Hier werden Ziele und Anforderungen geklärt.'),
      nein(
        'Abschluss',
        'Hier wird abgenommen und Bilanz gezogen, nicht laufend gesteuert.',
      ),
    ],
    explanation:
        'In der Steuerungsphase wird der Plan umgesetzt und überwacht: Soll und Ist werden verglichen, Abweichungen führen zu Gegenmaßnahmen, der Stand wird berichtet.',
  ),
  einfach(
    'a1-vp-7',
    'v-phasen',
    prompt: 'Welche Aussage zu Projektphasen und Wasserfallphasen ist richtig?',
    choices: [
      ja(
        'Projektphasen beschreiben das Management des Projekts, Wasserfallphasen die Entwicklung des Produkts.',
        'Die DIN-Phasen gelten für jedes Projekt; die Wasserfallphasen sind ein Vorgehensmodell für die Entwicklung.',
      ),
      nein(
        'Beides ist dasselbe, nur mit anderen Namen.',
        'Die Blickwinkel sind verschieden: Führung vs. Entwicklung.',
      ),
      nein(
        'Agile Projekte haben keinen Anfang und kein Ende.',
        'Auch ein Scrum-Projekt wird beauftragt und abgeschlossen.',
      ),
      nein(
        'Die Implementierung ist eine Phase nach DIN 69901.',
        'Die DIN-Phasen sind Initialisierung, Definition, Planung, Steuerung und Abschluss.',
      ),
    ],
    explanation:
        'Projektmanagement-Phasen (DIN 69901) und Entwicklungsphasen (Wasserfall) ergänzen sich: Die Entwicklung läuft vor allem in der Steuerungsphase des Projekts ab.',
    difficulty: 3,
  ),

  // ============================================================ Wasserfallmodell
  mehrfach(
    'a1-vw-1',
    'v-wasserfall',
    prompt: 'Welche Aussagen treffen auf das Wasserfallmodell zu?',
    choices: [
      ja(
        'Die Phasen laufen nacheinander ab.',
        'Das ist das Grundprinzip des Modells.',
      ),
      ja(
        'Jede Phase endet mit einem dokumentierten, freigegebenen Ergebnis.',
        'Erst dann beginnt die nächste Phase.',
      ),
      nein(
        'Der Kunde erhält nach jeder Phase lauffähige Teilergebnisse.',
        'Lauffähige Software gibt es erst am Ende - Zwischenergebnisse sind Dokumente.',
      ),
      ja(
        'Es eignet sich für Festpreisprojekte mit klaren Anforderungen.',
        'Stabile Anforderungen lassen sich vorab vollständig planen und kalkulieren.',
      ),
      nein(
        'Anforderungen werden während der Implementierung laufend neu priorisiert.',
        'Das ist typisch für Scrum, nicht für den Wasserfall.',
      ),
    ],
    explanation:
        'Der Wasserfall ist sequenziell und dokumentgetrieben. Er spielt seine Stärken bei klaren, stabilen Anforderungen aus.',
  ),
  rechnen(
    'a1-vw-2',
    'v-wasserfall',
    scenario:
        'Ein Fehler in der Anforderungsanalyse ließe sich dort für 50 € beheben. Er wird aber erst in der Testphase entdeckt - drei Phasen später (Entwurf, Implementierung, Test).',
    prompt: 'Was kostet die Behebung nach der Faustregel „Rule of Ten“?',
    answer: 50000,
    unit: '€',
    explanation:
        'Rule of Ten: Die Kosten verzehnfachen sich je Phase, in der der Fehler unentdeckt bleibt.\n'
        'Entwurf: 50 € × 10 = 500 €\n'
        'Implementierung: 500 € × 10 = 5.000 €\n'
        'Test: 5.000 € × 10 = 50.000 €\n'
        'Kurz: 50 € × 10³ = 50.000 €.',
  ),
  zuordnen(
    'a1-vw-3',
    'v-wasserfall',
    prompt:
        'In welcher Phase des Wasserfallmodells entsteht das jeweilige Ergebnis?',
    buckets: ['Anforderungsanalyse', 'Entwurf', 'Implementierung', 'Test'],
    items: [
      zu('Lastenheft', 0, 'Beschreibt die Anforderungen des Auftraggebers.'),
      zu(
        'Pflichtenheft',
        0,
        'Beschreibt, wie der Auftragnehmer die Anforderungen umsetzt.',
      ),
      zu(
        'Datenmodell und Systemarchitektur',
        1,
        'Der Entwurf legt die Struktur fest.',
      ),
      zu(
        'Beschreibung der Schnittstellen',
        1,
        'Teil des technischen Entwurfs.',
      ),
      zu('Programmcode', 2, 'Entsteht bei der Umsetzung.'),
      zu(
        'Testprotokoll',
        3,
        'Dokumentiert die Prüfung gegen die Anforderungen.',
      ),
    ],
    explanation:
        'Jede Wasserfallphase liefert ein Dokument, das die nächste Phase als verbindliche Vorgabe nutzt: Anforderungen → Entwurf → Code → Testergebnisse.',
  ),
  einfach(
    'a1-vw-4',
    'v-wasserfall',
    scenario:
        'Das Pflichtenheft ist freigegeben, die Implementierung läuft. Der Kunde wünscht jetzt eine zusätzliche Exportfunktion.',
    prompt: 'Wie wird im Wasserfallmodell korrekt vorgegangen?',
    choices: [
      ja(
        'Change Request: Aufwand und Folgen für Termin und Kosten bewerten, dann entscheiden und neu vereinbaren',
        'Änderungen an freigegebenen Ergebnissen laufen über ein formales Änderungsverfahren.',
      ),
      nein(
        'Die Funktion sofort einbauen, der Kunde hat immer recht',
        'So wächst der Umfang ohne Anpassung von Zeit und Budget (Scope Creep).',
      ),
      nein(
        'Den Wunsch ablehnen, weil Änderungen im Wasserfall verboten sind',
        'Änderungen sind möglich, nur eben formal geregelt und meist teuer.',
      ),
      nein(
        'Die Funktion im nächsten Sprint einplanen',
        'Sprints gibt es in Scrum, nicht im Wasserfall.',
      ),
    ],
    explanation:
        'Im Wasserfall ist das freigegebene Pflichtenheft verbindlich. Neue Wünsche werden als Change Request bewertet; Auftraggeber und Auftragnehmer vereinbaren dann Mehrkosten und neue Termine.',
  ),
  einfach(
    'a1-vw-5',
    'v-wasserfall',
    prompt:
        'Welches Dokument beschreibt, wie und womit der Auftragnehmer die Anforderungen umsetzt?',
    choices: [
      ja(
        'Pflichtenheft',
        'Es wird vom Auftragnehmer erstellt und beantwortet das Wie und Womit.',
      ),
      nein(
        'Lastenheft',
        'Das Lastenheft schreibt der Auftraggeber - es beschreibt das Was und Wofür.',
      ),
      nein(
        'Testprotokoll',
        'Es dokumentiert Testergebnisse, keine Umsetzungsplanung.',
      ),
      nein(
        'Projektauftrag',
        'Er startet das Projekt, beschreibt aber keine technische Umsetzung.',
      ),
    ],
    explanation:
        'Lastenheft (Auftraggeber): Was soll das System leisten und wofür? Pflichtenheft (Auftragnehmer): Wie und womit wird es umgesetzt? Beide entstehen in der Anforderungsanalyse.',
    difficulty: 1,
  ),
  mehrfach(
    'a1-vw-6',
    'v-wasserfall',
    prompt: 'Welche Nachteile hat das Wasserfallmodell?',
    choices: [
      ja(
        'Der Kunde sieht lauffähige Software erst spät.',
        'Zwischenergebnisse sind Dokumente.',
      ),
      ja(
        'Späte Änderungen sind teuer.',
        'Alle abgeschlossenen Phasen müssen nachgearbeitet werden.',
      ),
      ja(
        'Fehler aus der Analyse fallen oft erst im Test auf.',
        'Der Test liegt am Ende der Kette.',
      ),
      nein(
        'Es gibt keine Dokumentation.',
        'Im Gegenteil - das Modell ist stark dokumentgetrieben.',
      ),
      nein(
        'Kosten und Termine lassen sich nicht planen.',
        'Gute Planbarkeit ist gerade eine Stärke.',
      ),
    ],
    explanation:
        'Die Stärken des Wasserfalls - Planbarkeit, Dokumentation, klare Struktur - erkauft man mit wenig Flexibilität: späte Rückmeldung, teure Änderungen, spät entdeckte Analysefehler.',
  ),

  // ======================================================== Klassisch oder agil?
  einfach(
    'a1-va-1',
    'v-auswahl',
    scenario:
        'Ein Start-up entwickelt eine App. Welche Funktionen die Nutzer wirklich brauchen, soll sich erst durch Rückmeldungen zu frühen Versionen zeigen.',
    prompt: 'Welches Vorgehen passt?',
    choices: [
      ja(
        'Scrum',
        'Unklare Anforderungen und frühe Rückmeldungen sind genau die Stärke von Scrum.',
      ),
      nein(
        'Wasserfall',
        'Setzt voraus, dass die Anforderungen zu Beginn feststehen - das ist hier nicht der Fall.',
      ),
      nein(
        'Erst alle Anforderungen vollständig klären, dann entscheiden',
        'Genau das ist hier nicht möglich: Die Anforderungen ergeben sich erst aus der Nutzung.',
      ),
      nein(
        'Wasserfall, weil so eine vollständige Dokumentation entsteht',
        'Dokumentation ist kein Grund, wenn das Produkt dabei an den Nutzern vorbeigeht.',
      ),
    ],
    explanation:
        'Wenn sich Anforderungen erst im Lauf des Projekts herausbilden, braucht es kurze Zyklen mit nutzbaren Zwischenergebnissen - also Scrum.',
  ),
  einfach(
    'a1-va-2',
    'v-auswahl',
    scenario:
        'Für eine Behörde soll ein Formular nach genau festgelegten gesetzlichen Vorgaben digitalisiert werden. Anforderungen, Festpreis und Termin stehen vertraglich fest.',
    prompt: 'Welches Vorgehensmodell passt?',
    choices: [
      ja(
        'Wasserfall',
        'Stabile Anforderungen, Festpreis und fester Termin sprechen für ein vollständig geplantes Vorgehen.',
      ),
      nein(
        'Scrum',
        'Scrum spielt seine Stärken bei sich ändernden Anforderungen aus - die gibt es hier nicht.',
      ),
      nein(
        'Scrum, weil agile Methoden immer schneller sind',
        'Agil ist nicht automatisch schneller, sondern flexibler.',
      ),
      nein(
        'Ohne festes Vorgehen einfach loslegen',
        'Bei vertraglich fixiertem Umfang, Preis und Termin braucht es ein planbares, dokumentiertes Vorgehen.',
      ),
    ],
    explanation:
        'Bei klaren, stabilen Anforderungen und vertraglich fixiertem Rahmen ist der Wasserfall die naheliegende Wahl.',
  ),
  einfach(
    'a1-va-3',
    'v-auswahl',
    prompt:
        'Welche Größen des magischen Dreiecks sind in Scrum typischerweise fest, welche variabel?',
    choices: [
      ja(
        'Zeit und Kosten fest, Umfang variabel',
        'Sprints haben eine feste Länge, das Team kostet pro Sprint gleich viel - was geliefert wird, entscheidet die Priorisierung.',
      ),
      nein(
        'Umfang fest, Zeit und Kosten variabel',
        'Das ist die Logik des Wasserfalls.',
      ),
      nein(
        'Alle drei Größen fest',
        'Dann gäbe es keinen Spielraum - das magische Dreieck lässt das nicht zu.',
      ),
      nein(
        'Alle drei Größen variabel',
        'Ohne feste Größe wäre das Projekt nicht steuerbar.',
      ),
    ],
    explanation:
        'Scrum dreht das Dreieck um: Zeit (Sprints) und Kosten (Team) stehen fest, der Umfang ergibt sich. Wird es eng, fallen die am wenigsten wertvollen Einträge weg - nicht der Termin.',
  ),
  einfach(
    'a1-va-4',
    'v-auswahl',
    scenario:
        'Ein Team liefert im ersten Sprint eine einfache Suchfunktion. Im zweiten Sprint verbessert es genau diese Suche anhand von Nutzerfeedback.',
    prompt:
        'Welcher Begriff beschreibt die Verbesserung im zweiten Sprint am treffendsten?',
    choices: [
      ja(
        'Iterativ',
        'Ein vorhandenes Ergebnis wird in einer Wiederholung verbessert.',
      ),
      nein(
        'Inkrementell',
        'Inkrementell hieße, eine neue Funktion hinzuzufügen - etwa einen Warenkorb.',
      ),
      nein(
        'Sequenziell',
        'Sequenziell ist der Wasserfall: Phasen einmal nacheinander.',
      ),
      nein(
        'Linear',
        'Linear beschreibt ebenfalls einen einmaligen Durchlauf ohne Wiederholung.',
      ),
    ],
    explanation:
        'Iterativ = in Wiederholungen verbessern. Inkrementell = in Teilstücken erweitern. Scrum ist beides: Jeder Sprint fügt etwas hinzu und verbessert Vorhandenes.',
  ),
  zuordnen(
    'a1-va-5',
    'v-auswahl',
    prompt: 'Ordne jedes Argument dem Modell zu, für das es spricht.',
    buckets: ['spricht für Wasserfall', 'spricht für Scrum'],
    items: [
      zu(
        'Die Anforderungen stehen in einer Ausschreibung vollständig fest.',
        0,
        'Stabile Anforderungen lassen sich vorab planen.',
      ),
      zu(
        'Festpreis für einen fest definierten Leistungsumfang',
        0,
        'Fester Umfang ist die Logik des Wasserfalls.',
      ),
      zu(
        'Der Kunde kann alle zwei Wochen Rückmeldung geben.',
        1,
        'Passt zu regelmäßigen Sprint Reviews.',
      ),
      zu(
        'Die Anforderungen ergeben sich erst aus der Nutzung.',
        1,
        'Unklare Anforderungen sprechen für kurze Zyklen.',
      ),
      zu(
        'Die Behörde verlangt eine vollständige Dokumentation vorab.',
        0,
        'Dokumentation vor der Umsetzung ist typisch für den Wasserfall.',
      ),
      zu(
        'Früh nutzbare Teilergebnisse sind erwünscht.',
        1,
        'Jeder Sprint liefert ein nutzbares Increment.',
      ),
    ],
    explanation:
        'Wasserfall passt bei stabilen Anforderungen, festem Vertrag und Dokumentationspflicht. Scrum passt bei unklaren Anforderungen, verfügbarem Kunden und dem Wunsch nach frühem Nutzen.',
  ),
  mehrfach(
    'a1-va-6',
    'v-auswahl',
    prompt:
        'Welche Begründungen für den Einsatz von Scrum sind fachlich tragfähig?',
    choices: [
      ja(
        'Die Anforderungen sind unklar und werden sich ändern.',
        'Das Kernargument für agiles Vorgehen.',
      ),
      ja(
        'Der Kunde möchte früh nutzbare Teilergebnisse.',
        'Scrum liefert nach jedem Sprint ein Increment.',
      ),
      ja(
        'Regelmäßiges Feedback senkt das Risiko einer Fehlentwicklung.',
        'Man kann höchstens einen Sprint in die falsche Richtung laufen.',
      ),
      nein(
        'Scrum ist immer schneller als der Wasserfall.',
        'Scrum ist flexibler, nicht automatisch schneller.',
      ),
      nein(
        'In Scrum muss nichts dokumentiert werden.',
        'Auch Scrum dokumentiert - nur nicht alles im Voraus.',
      ),
    ],
    explanation:
        'Tragfähige Argumente beziehen sich auf die Situation: Unsicherheit der Anforderungen, Verfügbarkeit des Kunden, Wunsch nach frühem Nutzen. Pauschale Behauptungen wie „schneller“ oder „ohne Doku“ sind falsch.',
  ),

  // ============================================================ Agiles Manifest
  einfach(
    'a1-sm-1',
    's-manifest',
    prompt: 'Welcher Satz steht so im agilen Manifest?',
    choices: [
      ja(
        'Funktionierende Software ist wichtiger als umfassende Dokumentation.',
        'Das ist einer der vier Werte.',
      ),
      nein(
        'Umfassende Dokumentation ist wichtiger als funktionierende Software.',
        'Genau umgekehrt.',
      ),
      nein(
        'Befolgen eines Plans ist wichtiger als Reagieren auf Veränderung.',
        'Umgekehrt: Reagieren auf Veränderung steht vorn.',
      ),
      nein(
        'Prozesse und Werkzeuge sind wichtiger als Individuen und Interaktionen.',
        'Umgekehrt: Menschen und Zusammenarbeit stehen vorn.',
      ),
    ],
    explanation:
        'Die vier Werte: Individuen und Interaktionen, funktionierende Software, Zusammenarbeit mit dem Kunden und Reagieren auf Veränderung sind wichtiger als die jeweilige rechte Seite.',
  ),
  mehrfach(
    'a1-sm-2',
    's-manifest',
    prompt: 'Welche Aussagen entsprechen den Prinzipien des agilen Manifests?',
    choices: [
      ja(
        'Anforderungsänderungen sind auch spät in der Entwicklung willkommen.',
        'Eines der zwölf Prinzipien.',
      ),
      ja(
        'Funktionierende Software ist das wichtigste Fortschrittsmaß.',
        'Eines der zwölf Prinzipien.',
      ),
      nein(
        'Der Kunde wird nur zu Projektbeginn und bei der Abnahme einbezogen.',
        'Agil heißt laufende Zusammenarbeit mit dem Kunden.',
      ),
      ja(
        'Das Team reflektiert regelmäßig, wie es effektiver werden kann.',
        'Eines der zwölf Prinzipien.',
      ),
      nein(
        'Dokumentation ist nicht erlaubt.',
        'Dokumentation ist wichtig - funktionierende Software nur wichtiger.',
      ),
    ],
    explanation:
        'Die Prinzipien betonen frühe Auslieferung, Offenheit für Änderungen, enge Zusammenarbeit und regelmäßige Verbesserung.',
  ),
  einfach(
    'a1-sm-3',
    's-manifest',
    scenario: 'Ein Kollege sagt: „Agil heißt, wir dokumentieren nichts mehr.“',
    prompt: 'Wie ist die Aussage einzuordnen?',
    choices: [
      ja(
        'Falsch - Dokumentation bleibt wichtig, funktionierende Software ist nur wichtiger.',
        'Das Manifest bewertet die rechte Seite ausdrücklich als wertvoll.',
      ),
      nein(
        'Richtig, so steht es im agilen Manifest.',
        'Das Manifest verbietet keine Dokumentation.',
      ),
      nein(
        'Richtig, Scrum verbietet Dokumentation.',
        'Scrum kennt sogar dokumentierte Artefakte wie Backlogs und die Definition of Done.',
      ),
      nein(
        'Falsch - agile Teams müssen mehr dokumentieren als Wasserfall-Teams.',
        'Das sagt das Manifest nicht; es setzt nur andere Schwerpunkte.',
      ),
    ],
    explanation:
        'Links vor rechts, nicht links statt rechts: Agilität verschiebt Schwerpunkte, sie schafft nichts ab.',
  ),
  zuordnen(
    'a1-sm-4',
    's-manifest',
    prompt:
        'Welche Seite der vier Werte des agilen Manifests wird höher geschätzt?',
    buckets: ['wird höher geschätzt', 'wird geringer geschätzt'],
    items: [
      zu('Individuen und Interaktionen', 0, 'Linke Seite des ersten Werts.'),
      zu('Prozesse und Werkzeuge', 1, 'Rechte Seite des ersten Werts.'),
      zu('Zusammenarbeit mit dem Kunden', 0, 'Linke Seite des dritten Werts.'),
      zu('Vertragsverhandlung', 1, 'Rechte Seite des dritten Werts.'),
      zu('Funktionierende Software', 0, 'Linke Seite des zweiten Werts.'),
      zu('Befolgen eines Plans', 1, 'Rechte Seite des vierten Werts.'),
    ],
    explanation:
        'Höher geschätzt: Individuen und Interaktionen, funktionierende Software, Zusammenarbeit mit dem Kunden, Reagieren auf Veränderung. Die rechte Seite bleibt wertvoll, sie ist nur nachrangig.',
    difficulty: 1,
  ),
  einfach(
    'a1-sm-5',
    's-manifest',
    prompt:
        'Was ist nach den Prinzipien des agilen Manifests das wichtigste Fortschrittsmaß?',
    choices: [
      ja('Funktionierende Software', 'So steht es im siebten Prinzip.'),
      nein(
        'Die Anzahl geschriebener Dokumentseiten',
        'Dokumente zeigen keinen nutzbaren Fortschritt.',
      ),
      nein(
        'Die Zahl der geleisteten Arbeitsstunden',
        'Aufwand ist kein Ergebnis.',
      ),
      nein(
        'Die Einhaltung des ursprünglichen Plans',
        'Reagieren auf Veränderung ist wichtiger als der Plan.',
      ),
    ],
    explanation:
        'Agil zählt, was nutzbar ist: Funktionierende Software zeigt echten Fortschritt. In Scrum wird er deshalb im Sprint Review am Increment geprüft.',
    difficulty: 1,
  ),
  einfach(
    'a1-sm-6',
    's-manifest',
    prompt:
        'Wann und von wem wurde das Manifest für agile Softwareentwicklung verfasst?',
    choices: [
      ja(
        '2001 von 17 Softwareentwicklern',
        'Die Gruppe traf sich 2001 und formulierte vier Werte und zwölf Prinzipien.',
      ),
      nein(
        '1970 von Winston W. Royce',
        'Royce wird mit dem Wasserfallmodell verbunden.',
      ),
      nein(
        '2020 von Ken Schwaber und Jeff Sutherland',
        'Die beiden haben den Scrum Guide 2020 veröffentlicht. Sie gehörten zwar 2001 zu den 17 Unterzeichnern, das Manifest selbst ist aber von 2001.',
      ),
      nein(
        '2025 von der IHK für den Prüfungskatalog',
        'Die IHK hat das Manifest nicht verfasst.',
      ),
    ],
    explanation:
        'Das agile Manifest entstand 2001 als Antwort auf schwerfällige, dokumentlastige Vorgehensweisen. Es beschreibt Werte und Prinzipien, keine konkrete Methode.',
  ),
  einfach(
    'a1-sm-7',
    's-manifest',
    scenario:
        'In einem Team arbeiten seit Wochen alle bis spät abends und am Wochenende, um einen Termin zu halten.',
    prompt:
        'Gegen welches Prinzip des agilen Manifests verstößt das am deutlichsten?',
    choices: [
      ja(
        'Nachhaltiges Tempo, das alle Beteiligten auf Dauer halten können',
        'Dauerhafte Überstunden sind nicht nachhaltig und senken auf Dauer Qualität und Motivation.',
      ),
      nein(
        'Änderungen sind auch spät willkommen',
        'Hier geht es nicht um Änderungen der Anforderungen.',
      ),
      nein(
        'Das Gespräch von Angesicht zu Angesicht ist am wirksamsten',
        'Die Kommunikation ist nicht das Problem.',
      ),
      nein(
        'Einfachheit ist essenziell',
        'Betrifft das Vermeiden unnötiger Arbeit, nicht die Arbeitszeit.',
      ),
    ],
    explanation:
        'Das achte Prinzip fordert ein gleichmäßiges, dauerhaft haltbares Tempo. Dauerhafte Überlastung führt zu Fehlern und Ausfällen - agile Teams planen deshalb mit ihrer realistischen Kapazität.',
    difficulty: 3,
  ),
  einfach(
    'a1-sm-8',
    's-manifest',
    prompt: 'Welche Aussage über „agil“ und „Scrum“ stimmt?',
    choices: [
      ja(
        'Das agile Manifest beschreibt Werte und Prinzipien; Scrum ist ein Rahmenwerk, das sie umsetzt.',
        'Agil ist die Haltung, Scrum eine konkrete Ausprägung.',
      ),
      nein(
        'Agil und Scrum sind Synonyme.',
        'Scrum ist nur ein agiles Rahmenwerk unter mehreren.',
      ),
      nein(
        'Das agile Manifest schreibt Sprints von zwei Wochen vor.',
        'Das Manifest nennt keine Sprints - die kommen aus Scrum.',
      ),
      nein(
        'Scrum ist älter als das agile Manifest und widerspricht ihm.',
        'Scrum wurde schon in den 1990er-Jahren beschrieben, widerspricht dem Manifest aber nicht, sondern setzt es um.',
      ),
    ],
    explanation:
        'Das Manifest liefert die Werte (was ist wichtig?), Scrum den Rahmen (wie arbeiten wir konkret?) mit Verantwortlichkeiten, Events und Artefakten.',
  ),

  // ============================================ Die drei Verantwortlichkeiten
  zuordnen(
    'a1-sr-1',
    's-rollen',
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
        'Der Product Owner verantwortet den Wert und das Backlog, der Scrum Master die Wirksamkeit des Teams, die Developers das nutzbare Increment in der vereinbarten Qualität.',
  ),
  einfach(
    'a1-sr-2',
    's-rollen',
    prompt: 'Wie groß ist ein Scrum Team laut Scrum Guide in der Regel?',
    choices: [
      ja(
        '10 oder weniger Personen',
        'So steht es im Scrum Guide: klein genug, um wendig zu bleiben.',
      ),
      nein('Genau 7 Developers', 'Eine feste Zahl gibt es nicht.'),
      nein(
        'Mindestens 12 Personen',
        'Größere Teams sollen sich eher in mehrere Scrum Teams aufteilen.',
      ),
      nein(
        'Beliebig groß, solange es einen Product Owner gibt',
        'Die Teamgröße ist ausdrücklich begrenzt.',
      ),
    ],
    explanation:
        'Ein Scrum Team umfasst typischerweise zehn oder weniger Personen. Kleine Teams kommunizieren besser und sind produktiver.',
  ),
  einfach(
    'a1-sr-3',
    's-rollen',
    scenario:
        'Mitten im Sprint verlangt der Vertriebsleiter von den Developers, sofort eine dringende Funktion für einen Großkunden einzubauen.',
    prompt: 'Wie ist nach Scrum richtig vorzugehen?',
    choices: [
      ja(
        'Er wendet sich an den Product Owner, der den Wunsch ins Product Backlog aufnimmt und einordnet.',
        'Über Inhalte und Reihenfolge entscheidet allein der Product Owner; der laufende Sprint bleibt geschützt.',
      ),
      nein(
        'Die Developers bauen die Funktion sofort ein.',
        'Dann würde jemand außerhalb des Teams den Sprint steuern - das gefährdet das Sprintziel.',
      ),
      nein(
        'Der Scrum Master entscheidet über die Priorität.',
        'Der Scrum Master priorisiert keine Inhalte.',
      ),
      nein(
        'Der Vertriebsleiter bricht den Sprint ab.',
        'Einen Sprint abbrechen darf nur der Product Owner.',
      ),
    ],
    explanation:
        'Alle Wünsche laufen über den Product Owner in das Product Backlog. Ist der Wunsch wertvoll genug, kommt er in einen der nächsten Sprints. Nur wenn das Sprintziel hinfällig wird, kann der Product Owner den Sprint abbrechen.',
  ),
  mehrfach(
    'a1-sr-4',
    's-rollen',
    prompt: 'Welche Aufgaben hat der Scrum Master?',
    choices: [
      ja(
        'Das Team im Selbstmanagement coachen',
        'Teil seines Dienstes am Scrum Team.',
      ),
      ja(
        'Dafür sorgen, dass Hindernisse beseitigt werden',
        'Eine seiner Kernaufgaben.',
      ),
      ja(
        'Dem Product Owner Techniken für die Backlog-Pflege zeigen',
        'Er dient auch dem Product Owner.',
      ),
      nein(
        'Den Developers Aufgaben zuteilen',
        'Die Developers organisieren ihre Arbeit selbst.',
      ),
      nein(
        'Die Reihenfolge im Product Backlog festlegen',
        'Das ist Sache des Product Owners.',
      ),
    ],
    explanation:
        'Der Scrum Master verantwortet die Wirksamkeit des Scrum Teams. Er dient dem Team, dem Product Owner und der Organisation - er verteilt aber keine Arbeit und entscheidet nicht über Inhalte.',
  ),
  einfach(
    'a1-sr-5',
    's-rollen',
    scenario:
        'Die Developers prüfen im Daily Scrum, wie weit sie mit dem Sprintziel sind.',
    prompt: 'Welche Säule der Empirie in Scrum wird hier vor allem gelebt?',
    choices: [
      ja('Überprüfung', 'Der Fortschritt wird regelmäßig geprüft.'),
      nein(
        'Transparenz',
        'Transparenz ist Voraussetzung dafür, aber das Prüfen selbst ist Überprüfung.',
      ),
      nein(
        'Commitment',
        'Commitment ist ein Scrum-Wert, keine Säule der Empirie.',
      ),
      nein(
        'Hierarchie',
        'Scrum kennt keine Hierarchie im Team - und sie ist keine Säule.',
      ),
    ],
    explanation:
        'Die drei Säulen sind Transparenz, Überprüfung und Anpassung. Im Daily wird überprüft; passen die Developers danach ihren Plan an, folgt die Anpassung.',
  ),
  einfach(
    'a1-sr-6',
    's-rollen',
    prompt: 'Welche Aussage über den Product Owner ist richtig?',
    choices: [
      ja(
        'Er ist eine einzelne Person, kein Gremium.',
        'Andere dürfen beraten, die Verantwortung trägt eine Person.',
      ),
      nein(
        'Er ist ein Ausschuss aus allen Fachbereichsleitungen.',
        'Ein Gremium widerspricht dem Scrum Guide.',
      ),
      nein(
        'Er ist der disziplinarische Vorgesetzte der Developers.',
        'Im Scrum Team gibt es keine Hierarchie.',
      ),
      nein(
        'Er leitet das Daily Scrum.',
        'Das Daily ist ein Event der Developers.',
      ),
    ],
    explanation:
        'Der Product Owner ist eine Person, die für den Wert des Produkts verantwortlich ist. Er formuliert das Produktziel und ordnet das Product Backlog; die Organisation respektiert seine Entscheidungen.',
    difficulty: 1,
  ),
  mehrfach(
    'a1-sr-7',
    's-rollen',
    prompt: 'Welche Eigenschaften hat ein Scrum Team laut Scrum Guide 2020?',
    choices: [
      ja(
        'Es ist interdisziplinär.',
        'Es hat alle Fähigkeiten, um in jedem Sprint Wert zu schaffen.',
      ),
      ja(
        'Es ist selbstmanagend.',
        'Es entscheidet selbst, wer was wann und wie tut.',
      ),
      ja(
        'Es gibt keine Unterteams und keine Hierarchien.',
        'So steht es im Scrum Guide.',
      ),
      nein(
        'Der Scrum Master ist Vorgesetzter der Developers.',
        'Der Scrum Master führt, indem er dient - nicht als Vorgesetzter.',
      ),
      nein(
        'Ein Team hat mehrere Product Owner, je Fachbereich einen.',
        'Es gibt genau einen Product Owner.',
      ),
    ],
    explanation:
        'Ein Scrum Team besteht aus einem Product Owner, einem Scrum Master und Developers - klein, interdisziplinär, selbstmanagend, ohne Unterteams und Hierarchien.',
  ),

  // ================================================ Artefakte und Commitments
  einfach(
    'a1-sa-1',
    's-artefakte',
    prompt: 'Welches Commitment gehört zum Sprint Backlog?',
    choices: [
      ja(
        'Sprintziel',
        'Das Sprintziel gibt dem Sprint Backlog seine Richtung.',
      ),
      nein('Produktziel', 'Das gehört zum Product Backlog.'),
      nein('Definition of Done', 'Die gehört zum Increment.'),
      nein('Velocity', 'Die Velocity ist eine Messgröße, kein Commitment.'),
    ],
    explanation:
        'Product Backlog - Produktziel, Sprint Backlog - Sprintziel, Increment - Definition of Done.',
  ),
  mehrfach(
    'a1-sa-2',
    's-artefakte',
    prompt: 'Welche Aussagen zur Definition of Done sind richtig?',
    choices: [
      ja(
        'Sie gilt für alle Einträge im Product Backlog.',
        'Sie ist ein gemeinsamer Qualitätsmaßstab.',
      ),
      ja(
        'Einträge, die sie nicht erfüllen, werden im Sprint Review nicht als fertig vorgestellt.',
        'Sie gehen zurück ins Product Backlog.',
      ),
      nein(
        'Sie wird für jede User Story neu festgelegt.',
        'Das beschreibt Akzeptanzkriterien.',
      ),
      nein(
        'Sie legt fest, welche Stories im nächsten Sprint drankommen.',
        'Das wird im Sprint Planning entschieden.',
      ),
      ja(
        'Sie schafft ein gemeinsames Verständnis davon, wann Arbeit fertig ist.',
        'Genau dafür ist sie da.',
      ),
    ],
    explanation:
        'Die Definition of Done ist der Qualitätsmaßstab für alle Einträge. Nur was sie erfüllt, gehört zum Increment.',
  ),
  einfach(
    'a1-sa-3',
    's-artefakte',
    prompt: 'Wem gehört das Sprint Backlog?',
    choices: [
      ja(
        'Den Developers',
        'Es ist ihr Plan für den Sprint; nur sie ändern ihn.',
      ),
      nein(
        'Dem Product Owner',
        'Er verantwortet das Product Backlog, nicht das Sprint Backlog.',
      ),
      nein(
        'Dem Scrum Master',
        'Er sorgt für wirksames Scrum, plant aber nicht die Arbeit.',
      ),
      nein(
        'Den Stakeholdern',
        'Sie geben Rückmeldung im Review, planen aber nicht den Sprint.',
      ),
    ],
    explanation:
        'Das Sprint Backlog ist ein Plan von und für die Developers: Sprintziel, ausgewählte Einträge und der Plan zur Umsetzung. Sie aktualisieren es im Sprint laufend.',
    difficulty: 1,
  ),
  einfach(
    'a1-sa-4',
    's-artefakte',
    scenario:
        'Am Sprintende ist eine Story programmiert, aber noch nicht getestet. Die Definition of Done verlangt bestandene automatische Tests.',
    prompt: 'Wie wird die Story behandelt?',
    choices: [
      ja(
        'Sie gilt nicht als fertig, gehört nicht zum Increment und geht zurück ins Product Backlog.',
        'Ohne erfüllte Definition of Done ist ein Eintrag nicht fertig.',
      ),
      nein(
        'Sie wird als fertig gezählt, die Tests werden später nachgeholt.',
        'Das würde die Definition of Done aushebeln.',
      ),
      nein(
        'Der Sprint wird verlängert, bis die Tests fertig sind.',
        'Sprints haben eine feste Länge.',
      ),
      nein(
        'Sie zählt zur Hälfte in die Velocity.',
        'Es gibt keine halben Punkte - nur fertige Einträge zählen.',
      ),
    ],
    explanation:
        'Die Definition of Done ist nicht verhandelbar. Unfertige Einträge werden weder im Review als fertig gezeigt noch in der Velocity gezählt; der Product Owner ordnet sie im Product Backlog neu ein.',
  ),
  zuordnen(
    'a1-sa-5',
    's-artefakte',
    prompt:
        'Gehört die Aussage zur Definition of Done oder ist sie ein Akzeptanzkriterium einer einzelnen Story?',
    buckets: ['Definition of Done', 'Akzeptanzkriterium'],
    items: [
      zu(
        'Der Code wurde von einer zweiten Person geprüft.',
        0,
        'Gilt für jeden Eintrag - handwerkliche Qualität.',
      ),
      zu(
        'Alle automatischen Tests sind grün.',
        0,
        'Teamweiter Qualitätsstandard.',
      ),
      zu(
        'Bei falschem Passwort erscheint eine Fehlermeldung.',
        1,
        'Fachliches Verhalten einer Login-Story.',
      ),
      zu(
        'Die Sendungsnummer wird auf der Bestellseite angezeigt.',
        1,
        'Fachliches Verhalten einer bestimmten Story.',
      ),
      zu('Die Dokumentation ist aktualisiert.', 0, 'Gilt für alle Einträge.'),
      zu(
        'Der Warenkorb zeigt den Gesamtpreis inklusive Mehrwertsteuer.',
        1,
        'Fachliche Anforderung an eine Story.',
      ),
    ],
    explanation:
        'Die Definition of Done gilt für alle Einträge und beschreibt die Qualität (geprüft, getestet, dokumentiert). Akzeptanzkriterien gelten für eine Story und beschreiben ihr fachliches Verhalten.',
  ),
  mehrfach(
    'a1-sa-6',
    's-artefakte',
    prompt: 'Welche Aussagen zum Increment sind richtig?',
    choices: [
      ja(
        'Es entsteht, sobald ein Eintrag die Definition of Done erfüllt.',
        'So beschreibt es der Scrum Guide.',
      ),
      ja(
        'In einem Sprint können mehrere Increments entstehen.',
        'Jeder fertige Eintrag kann eines bilden.',
      ),
      ja(
        'Es darf schon vor dem Sprint Review ausgeliefert werden.',
        'Das Review ist kein Freigabetor.',
      ),
      nein(
        'Es darf erst nach Freigabe im Sprint Review entstehen.',
        'Es entsteht mit Erfüllung der Definition of Done.',
      ),
      nein(
        'Es enthält auch halbfertige Einträge.',
        'Halbfertiges gehört nie zum Increment.',
      ),
    ],
    explanation:
        'Das Increment ist ein nutzbarer, geprüfter Schritt zum Produktziel. Es baut auf allen vorherigen auf; sein Commitment ist die Definition of Done.',
    difficulty: 3,
  ),
  einfach(
    'a1-sa-7',
    's-artefakte',
    prompt: 'Was ist Product Backlog Refinement?',
    choices: [
      ja(
        'Eine laufende Tätigkeit, bei der Einträge zerlegt, präzisiert und geschätzt werden',
        'Sie bereitet Einträge für kommende Sprints vor.',
      ),
      nein(
        'Eines der fünf Scrum-Events mit fester Timebox',
        'Refinement ist ausdrücklich kein Event.',
      ),
      nein(
        'Das Abnahmetreffen mit dem Kunden am Sprintende',
        'Das ist das Sprint Review.',
      ),
      nein(
        'Die Verbesserung der Zusammenarbeit im Team',
        'Das ist Thema der Retrospektive.',
      ),
    ],
    explanation:
        'Im Refinement werden Einträge so lange zerlegt und präzisiert, bis sie in einen Sprint passen. Der Product Owner erklärt und ordnet, die Developers schätzen die Größe.',
  ),

  // ============================================================= Scrum-Events
  zuordnen(
    'a1-se-1',
    's-events',
    prompt: 'Ordne jede Beschreibung dem passenden Event zu.',
    buckets: [
      'Sprint Planning',
      'Daily Scrum',
      'Sprint Review',
      'Sprint Retrospective',
    ],
    items: [
      zu('Das Sprintziel wird festgelegt', 0),
      zu('Die Developers planen die nächsten 24 Stunden', 1),
      zu('Stakeholder sehen das Increment und geben Rückmeldung', 2),
      zu('Das Team überlegt, wie es seine Zusammenarbeit verbessern kann', 3),
    ],
    explanation:
        'Planning: was und wie. Daily: nächste 24 Stunden. Review: Produkt mit Stakeholdern. Retrospektive: Zusammenarbeit im Team.',
  ),
  rechnen(
    'a1-se-2',
    's-events',
    scenario:
        'Ein Team arbeitet in 2-Wochen-Sprints. Für einen Monatssprint (4 Wochen) sieht der Scrum Guide für das Sprint Planning höchstens 8 Stunden vor.',
    prompt:
        'Wie viele Stunden darf das Sprint Planning bei anteiliger Umrechnung höchstens dauern?',
    answer: 4,
    unit: 'Stunden',
    explanation:
        'Anteil: 2 Wochen / 4 Wochen = 0,5.\n'
        'Sprint Planning: 8 h × 0,5 = 4 h.\n'
        'Entsprechend: Review 4 h × 0,5 = 2 h, Retrospektive 3 h × 0,5 = 1,5 h. Das Daily bleibt bei 15 Minuten.',
    difficulty: 1,
  ),
  einfach(
    'a1-se-3',
    's-events',
    prompt: 'Wer darf einen laufenden Sprint abbrechen?',
    choices: [
      ja(
        'Nur der Product Owner',
        'Er darf es, wenn das Sprintziel hinfällig geworden ist.',
      ),
      nein(
        'Der Scrum Master',
        'Er sorgt für wirksames Scrum, entscheidet aber nicht über Inhalte.',
      ),
      nein(
        'Die Developers',
        'Sie planen den Sprint, brechen ihn aber nicht ab.',
      ),
      nein(
        'Jeder Stakeholder',
        'Stakeholder wenden sich an den Product Owner.',
      ),
    ],
    explanation:
        'Ein Sprint wird nur abgebrochen, wenn sein Ziel obsolet ist - etwa weil sich der Markt geändert hat. Diese Befugnis hat allein der Product Owner.',
  ),
  einfach(
    'a1-se-4',
    's-events',
    scenario:
        'Im Daily Scrum lässt sich der Abteilungsleiter von jedem Developer ausführlich berichten, was er gestern getan hat, und verteilt dann die Aufgaben für heute.',
    prompt: 'Was ist daran nicht Scrum-konform?',
    choices: [
      ja(
        'Das Daily ist ein Event der Developers, um den Fortschritt zum Sprintziel zu prüfen und ihren Plan selbst anzupassen.',
        'Es ist kein Statusbericht an eine Führungskraft, und Aufgaben verteilen die Developers selbst.',
      ),
      nein(
        'Das Daily müsste mindestens eine Stunde dauern.',
        'Die Timebox beträgt 15 Minuten.',
      ),
      nein(
        'Nur der Scrum Master darf im Daily sprechen.',
        'Das Daily gehört den Developers.',
      ),
      nein(
        'Es ist alles korrekt, so läuft ein Daily ab.',
        'Berichten an Vorgesetzte und Aufgabenzuteilung von außen widersprechen dem Selbstmanagement.',
      ),
    ],
    explanation:
        'Im Daily Scrum organisieren sich die Developers selbst. Sie prüfen den Fortschritt zum Sprintziel und planen die nächsten 24 Stunden - ohne Berichtspflicht an Vorgesetzte.',
  ),
  mehrfach(
    'a1-se-5',
    's-events',
    prompt: 'Welche Aussagen zum Sprint Review sind richtig?',
    choices: [
      ja(
        'Wichtige Stakeholder geben Rückmeldung zum Ergebnis.',
        'Deshalb sind sie eingeladen.',
      ),
      ja(
        'Das Product Backlog kann danach angepasst werden.',
        'Die Rückmeldungen fließen in die Planung ein.',
      ),
      ja(
        'Bei einem Monatssprint dauert es höchstens 4 Stunden.',
        'Das ist die Timebox des Reviews.',
      ),
      nein(
        'Es ist eine reine Präsentation ohne Diskussion.',
        'Es ist eine Arbeitssitzung.',
      ),
      nein(
        'Nur das Scrum Team nimmt teil, Gäste sind ausgeschlossen.',
        'Das trifft auf die Retrospektive zu.',
      ),
    ],
    explanation:
        'Im Sprint Review prüfen Scrum Team und Stakeholder gemeinsam das Ergebnis und beraten die nächsten Schritte. Es liegt vor der Retrospektive und dauert beim Monatssprint höchstens 4 Stunden.',
  ),
  einfach(
    'a1-se-6',
    's-events',
    prompt: 'Welche Frage wird im Sprint Planning beantwortet?',
    choices: [
      ja(
        'Warum ist dieser Sprint wertvoll, und was ist das Sprintziel?',
        'Das ist das erste der drei Themen im Planning.',
      ),
      nein(
        'Wie kann das Team seine Zusammenarbeit verbessern?',
        'Das klärt die Retrospektive.',
      ),
      nein(
        'Was halten die Stakeholder vom Ergebnis?',
        'Das klärt das Sprint Review.',
      ),
      nein(
        'Was hat jeder gestern gemacht?',
        'Eine typische, aber nicht mehr vorgeschriebene Frage im Daily.',
      ),
    ],
    explanation:
        'Das Sprint Planning beantwortet drei Fragen: Warum ist der Sprint wertvoll (Sprintziel)? Was kann erledigt werden? Wie wird die Arbeit erledigt? Ergebnis ist das Sprint Backlog.',
    difficulty: 1,
  ),

  // ============================================= User Stories und Schätzung
  einfach(
    'a1-st-1',
    's-stories',
    prompt: 'Welche User Story ist korrekt formuliert?',
    choices: [
      ja(
        'Als Vertriebsmitarbeiter möchte ich Kunden nach Postleitzahl filtern, damit ich Besuche besser planen kann.',
        'Rolle, Ziel und Nutzen sind genannt.',
      ),
      nein(
        'Das System muss eine MySQL-Datenbank verwenden.',
        'Eine technische Vorgabe ohne Rolle und Nutzen - keine User Story.',
      ),
      nein(
        'Als Entwickler möchte ich eine Klasse KundenDAO anlegen.',
        'Beschreibt eine Umsetzung, keinen Nutzen für Anwender.',
      ),
      nein('Filterfunktion für Kunden einbauen.', 'Rolle und Nutzen fehlen.'),
    ],
    explanation:
        'Eine User Story folgt dem Muster: Als <Rolle> möchte ich <Ziel>, damit <Nutzen>.',
  ),
  rechnen(
    'a1-st-2',
    's-stories',
    scenario:
        'Ein Scrum Team hat in den letzten drei Sprints 34, 28 und 31 Story Points fertiggestellt. Im Product Backlog liegen noch 210 Story Points.',
    prompt:
        'Wie viele Sprints braucht das Team voraussichtlich noch? Runde auf ganze Sprints auf.',
    answer: 7,
    unit: 'Sprints',
    explanation:
        'Velocity = (34 + 28 + 31) / 3 = 93 / 3 = 31 Story Points je Sprint.\n'
        'Restliche Sprints = 210 / 31 = 6,77.\n'
        'Aufrunden, weil es keinen angefangenen Sprint gibt: 7 Sprints.',
  ),
  rechnen(
    'a1-st-3',
    's-stories',
    scenario:
        'Ein Sprint dauert 10 Arbeitstage. Geplant sind 50 Story Points. Die Ideallinie im Burndown-Chart fällt gleichmäßig auf null.',
    prompt:
        'Wie viele Story Points sollten laut Ideallinie nach Tag 6 noch offen sein?',
    answer: 20,
    unit: 'SP',
    explanation:
        'Abbau je Tag: 50 SP / 10 Tage = 5 SP pro Tag.\n'
        'Nach 6 Tagen abgebaut: 6 × 5 = 30 SP.\n'
        'Noch offen: 50 - 30 = 20 SP. Liegt der Ist-Wert darüber, ist das Team hinter dem Plan.',
  ),
  einfach(
    'a1-st-4',
    's-stories',
    scenario:
        'Eine Story lautet: „Als Buchhalterin möchte ich das komplette neue Buchhaltungsmodul nutzen, damit ich effizienter arbeite.“ Das Team schätzt sie auf 100 Story Points.',
    prompt:
        'Gegen welches INVEST-Kriterium verstößt die Story am deutlichsten?',
    choices: [
      ja(
        'Small',
        'Mit 100 Punkten passt sie in keinen Sprint - sie ist ein Epic und muss zerlegt werden.',
      ),
      nein('Valuable', 'Ein Nutzen ist genannt.'),
      nein('Negotiable', 'Nichts deutet auf eine starre Vorgabe hin.'),
      nein(
        'Independent',
        'Eine Abhängigkeit zu anderen Stories ist nicht erkennbar.',
      ),
    ],
    explanation:
        'Eine Story, die zu groß für einen Sprint ist, heißt Epic. Im Refinement wird sie in kleinere Stories geteilt, etwa „Rechnungen erfassen“, „Zahlungen buchen“, „Mahnungen erstellen“.',
  ),
  reihenfolge(
    'a1-st-5',
    's-stories',
    prompt:
        'Bringe die Schritte des Planning Pokers in die richtige Reihenfolge.',
    items: [
      'Der Product Owner stellt die Story vor, Fragen werden geklärt',
      'Jede Person wählt verdeckt eine Karte',
      'Alle decken gleichzeitig auf',
      'Höchster und niedrigster Wert werden begründet',
      'Erneut schätzen, bis sich das Team einigt',
    ],
    explanation:
        'Erst verstehen, dann verdeckt schätzen und gleichzeitig aufdecken - das verhindert den Ankereffekt. Große Abweichungen werden besprochen, weil sie auf unterschiedliches Verständnis hinweisen.',
  ),
  einfach(
    'a1-st-6',
    's-stories',
    prompt:
        'Warum decken beim Planning Poker alle ihre Karte gleichzeitig auf?',
    choices: [
      ja(
        'Damit sich niemand am zuerst genannten Wert orientiert',
        'Das gleichzeitige Aufdecken verhindert den Ankereffekt.',
      ),
      nein('Damit das Schätzen schneller geht', 'Tempo ist nicht der Grund.'),
      nein(
        'Damit der Scrum Master den Mittelwert bilden kann',
        'Es wird kein Mittelwert gebildet, sondern diskutiert.',
      ),
      nein(
        'Weil der Product Owner die Karten einsammeln muss',
        'Der Product Owner schätzt nicht mit.',
      ),
    ],
    explanation:
        'Nennt jemand zuerst einen Wert, orientieren sich die anderen unbewusst daran. Verdeckte Karten sorgen für unabhängige Schätzungen; Abweichungen machen Missverständnisse sichtbar.',
    difficulty: 1,
  ),
  mehrfach(
    'a1-st-7',
    's-stories',
    prompt: 'Welche Aussagen zu Story Points und Velocity sind richtig?',
    choices: [
      ja(
        'Story Points sind eine relative Schätzung.',
        'Man vergleicht mit einer Referenz-Story.',
      ),
      ja(
        'Story Points fassen Umfang, Komplexität und Unsicherheit zusammen.',
        'Deshalb sind sie keine Zeitangabe.',
      ),
      ja(
        'Velocity-Werte verschiedener Teams sind nicht vergleichbar.',
        'Jedes Team hat seine eigene Punkteskala.',
      ),
      nein(
        'Ein Story Point entspricht einer Arbeitsstunde.',
        'Story Points lassen sich nicht in Stunden umrechnen.',
      ),
      nein(
        'Angefangene Stories zählen anteilig zur Velocity.',
        'Nur fertige Einträge (Definition of Done) zählen.',
      ),
    ],
    explanation:
        'Story Points messen die relative Größe. Die Velocity ist die durchschnittliche Menge fertiger Punkte je Sprint - ein Planungswert für ein Team, kein Leistungsvergleich.',
  ),

  // ======================================================= Aufbau eines Netzplans
  einfach(
    'a1-ng-1',
    'n-grundlagen',
    prompt: 'Welche Anordnungsbeziehung ist in Netzplänen der Normalfall?',
    choices: [
      ja(
        'Normalfolge (Ende-Anfang)',
        'Der Nachfolger beginnt, wenn der Vorgänger beendet ist.',
      ),
      nein(
        'Anfangsfolge (Anfang-Anfang)',
        'Kommt vor, ist aber nicht der Standard.',
      ),
      nein('Endfolge (Ende-Ende)', 'Kommt vor, ist aber nicht der Standard.'),
      nein('Sprungfolge (Anfang-Ende)', 'Selten und in der AP1 kaum relevant.'),
    ],
    explanation:
        'In AP1-Netzplänen ist praktisch immer die Normalfolge gemeint.',
  ),
  mehrfach(
    'a1-ng-2',
    'n-grundlagen',
    prompt:
        'Welche Angaben stehen in einem vollständig berechneten Vorgangsknoten?',
    choices: [
      ja(
        'Frühester Anfang und frühestes Ende (FAZ, FEZ)',
        'Ergebnis der Vorwärtsrechnung.',
      ),
      ja(
        'Spätester Anfang und spätestes Ende (SAZ, SEZ)',
        'Ergebnis der Rückwärtsrechnung.',
      ),
      ja(
        'Gesamtpuffer und freier Puffer (GP, FP)',
        'Werden aus den Zeitpunkten berechnet.',
      ),
      nein(
        'Stundensatz der bearbeitenden Person',
        'Kosten gehören in die Kostenplanung, nicht in den Knoten.',
      ),
      nein('Kundenzufriedenheit', 'Keine Größe der Terminplanung.'),
    ],
    explanation:
        'Ein Vorgangsknoten enthält Nummer, Bezeichnung, Dauer, die vier Zeitpunkte und die beiden Puffer.',
  ),
  reihenfolge(
    'a1-ng-3',
    'n-grundlagen',
    prompt:
        'Bringe die Arbeitsschritte der Netzplantechnik in die richtige Reihenfolge.',
    items: [
      'Vorgänge und Dauern auflisten',
      'Vorgänger festlegen',
      'Knoten anordnen und verbinden',
      'Vorwärtsrechnung durchführen',
      'Rückwärtsrechnung durchführen',
      'Puffer und kritischen Pfad ermitteln',
    ],
    explanation:
        'Erst die Struktur, dann die Zeitrechnung in beide Richtungen, zuletzt die Auswertung.',
  ),
  zuordnen(
    'a1-ng-4',
    'n-grundlagen',
    prompt: 'In welchem Rechenschritt wird der jeweilige Wert ermittelt?',
    buckets: ['Vorwärtsrechnung', 'Rückwärtsrechnung', 'Pufferberechnung'],
    items: [
      zu('FAZ', 0, 'Frühester Anfang: größter FEZ der Vorgänger.'),
      zu('FEZ', 0, 'Frühestes Ende: FAZ + Dauer.'),
      zu('SEZ', 1, 'Spätestes Ende: kleinster SAZ der Nachfolger.'),
      zu('SAZ', 1, 'Spätester Anfang: SEZ - Dauer.'),
      zu('GP', 2, 'Gesamtpuffer: SAZ - FAZ.'),
      zu('FP', 2, 'Freier Puffer: kleinster FAZ der Nachfolger - FEZ.'),
    ],
    explanation:
        'Vorwärts entstehen die frühesten Zeitpunkte, rückwärts die spätesten. Aus beiden werden anschließend die Puffer berechnet.',
    difficulty: 1,
  ),
  einfach(
    'a1-ng-5',
    'n-grundlagen',
    skizze: const NetzplanDiagramm(_mini, mitWerten: false),
    prompt: 'Welche Vorgänge sind direkte Vorgänger von D?',
    choices: [
      ja('B und C', 'Von B und von C führt je ein Pfeil zu D.'),
      nein(
        'A, B und C',
        'A ist nur indirekter Vorgänger - zwischen A und D liegen B bzw. C.',
      ),
      nein('Nur C', 'Auch von B führt ein Pfeil zu D.'),
      nein(
        'D hat keinen Vorgänger',
        'D ist der Endvorgang, nicht der Startvorgang.',
      ),
    ],
    explanation:
        'Direkte Vorgänger sind die Vorgänge, von denen ein Pfeil unmittelbar zum Vorgang führt. D darf erst beginnen, wenn B und C beendet sind.',
    difficulty: 1,
  ),
  einfach(
    'a1-ng-6',
    'n-grundlagen',
    scenario:
        'Eine Vorgangsliste nennt statt der Vorgänger die Nachfolger:\n'
        'A: Nachfolger B, C\n'
        'B: Nachfolger D\n'
        'C: Nachfolger D, E\n'
        'D: Nachfolger F\n'
        'E: Nachfolger F\n'
        'F: kein Nachfolger',
    prompt: 'Welche Vorgänger hat D?',
    choices: [
      ja(
        'B und C',
        'D steht bei B und bei C als Nachfolger - also sind beide Vorgänger von D.',
      ),
      nein('Nur B', 'Auch C nennt D als Nachfolger.'),
      nein('F', 'F ist der Nachfolger von D, nicht sein Vorgänger.'),
      nein(
        'C und E',
        'E ist kein Vorgänger von D; E und D laufen parallel und führen beide zu F.',
      ),
    ],
    explanation:
        'Nachfolgerangaben werden umgedreht: Steht D bei X als Nachfolger, ist X Vorgänger von D. Bei B und bei C steht D - also hat D die Vorgänger B und C.',
  ),
  rechnen(
    'a1-ng-7',
    'n-grundlagen',
    scenario:
        'Vorgang A (Bestellung) hat ein frühestes Ende FEZ = 5. Zwischen A und dem Nachfolger B (Einbau) liegt eine Lieferzeit von 3 Tagen als Zeitabstand (Normalfolge).',
    prompt: 'Welchen FAZ hat B?',
    answer: 8,
    unit: 'Tage',
    explanation:
        'Bei einer Normalfolge mit Zeitabstand gilt: FAZ Nachfolger = FEZ Vorgänger + Abstand.\n'
        'FAZ B = 5 + 3 = 8.',
  ),
  einfach(
    'a1-ng-8',
    'n-grundlagen',
    prompt:
        'Welche Information liefert ein berechneter Netzplan, die ein einfaches Gantt-Diagramm nicht direkt zeigt?',
    choices: [
      ja(
        'Pufferzeiten und kritischen Pfad',
        'Sie entstehen erst durch Vorwärts- und Rückwärtsrechnung.',
      ),
      nein(
        'Die Dauer der Vorgänge',
        'Die zeigt das Gantt-Diagramm als Balkenlänge.',
      ),
      nein(
        'Die Bezeichnung der Vorgänge',
        'Die stehen auch im Gantt-Diagramm.',
      ),
      nein(
        'Eine Zeitachse',
        'Die Zeitachse ist gerade die Stärke des Gantt-Diagramms.',
      ),
    ],
    explanation:
        'Das Gantt-Diagramm ist ein anschaulicher Balkenplan. Der Netzplan ist das Rechenmodell: Er macht Abhängigkeiten, Puffer und den kritischen Pfad berechenbar.',
  ),

  // ============================================================ Vorwärtsrechnung
  rechnen(
    'a1-nv-1',
    'n-vorwaerts',
    scenario: _netz,
    prompt: 'Wie groß ist der FAZ von Vorgang E?',
    answer: 11,
    unit: 'Tage',
    explanation:
        'A: 0/5. B: 5/8. C: 5/11. D: 8/10.\n'
        'E hat zwei Vorgänger: FAZ = max(FEZ C = 11; FEZ D = 10) = 11.\n'
        'Wer 10 einträgt, lässt E starten, obwohl C noch läuft.',
  ),
  netzplanAufgabe(
    'a1-nv-2',
    'n-vorwaerts',
    scenario:
        'Ein Unternehmen richtet Home-Office-Arbeitsplätze ein. Dauer in Arbeitstagen.',
    prompt:
        'Führe die Vorwärtsrechnung durch: Trage FAZ und FEZ für jeden Vorgang ein.',
    vorgaenge: _home,
    gefragt: const [NodeField.faz, NodeField.fez],
    explanation:
        'FAZ = größter FEZ der Vorgänger (Start: 0), FEZ = FAZ + Dauer.\n'
        'A: 0 / 0 + 3 = 3\n'
        'B: 3 / 3 + 4 = 7\n'
        'C: 3 / 3 + 2 = 5\n'
        'D: 7 / 7 + 5 = 12\n'
        'E: max(FEZ B 7; FEZ C 5) = 7 / 7 + 3 = 10\n'
        'F: max(FEZ D 12; FEZ E 10) = 12 / 12 + 2 = 14\n'
        'Projektdauer: 14 Arbeitstage.',
    difficulty: 2,
  ),
  rechnen(
    'a1-nv-3',
    'n-vorwaerts',
    scenario:
        'Vorgänge (Dauer in Tagen):\n'
        'A: 4, kein Vorgänger\n'
        'B: 6, kein Vorgänger\n'
        'C: 3, nach A\n'
        'D: 2, nach A und B\n'
        'E: 5, nach C und D',
    prompt: 'Wie groß ist der FAZ von Vorgang E?',
    answer: 8,
    unit: 'Tage',
    explanation:
        'A und B sind Startvorgänge: A 0/4, B 0/6.\n'
        'C: FAZ = FEZ A = 4, FEZ 7.\n'
        'D: FAZ = max(FEZ A 4; FEZ B 6) = 6, FEZ 8.\n'
        'E: FAZ = max(FEZ C 7; FEZ D 8) = 8.',
  ),
  einfach(
    'a1-nv-4',
    'n-vorwaerts',
    scenario:
        'Ein Vorgang hat drei Vorgänger: X mit FEZ 9, Y mit FEZ 12 und Z mit FEZ 7.',
    prompt: 'Welchen FAZ hat der Vorgang?',
    choices: [
      ja(
        '12',
        'Er kann erst beginnen, wenn der letzte Vorgänger (Y) fertig ist - das Maximum.',
      ),
      nein('7', 'Das Minimum - dann liefen X und Y noch.'),
      nein('9', 'Dann liefe Y noch drei Tage.'),
      nein('28', 'Die FEZ werden nicht addiert.'),
    ],
    explanation:
        'Vorwärtsrechnung: FAZ = max(FEZ aller Vorgänger) = max(9; 12; 7) = 12.',
    difficulty: 1,
  ),
  rechnen(
    'a1-nv-5',
    'n-vorwaerts',
    scenario:
        'Die Aufgabe zählt Tage ab 1: Der Startvorgang A (4 Tage) beginnt an Tag 1. Vorgang B (3 Tage) folgt auf A.',
    prompt: 'An welchem Tag endet B frühestens (FEZ)? Gib die Tagesnummer an.',
    answer: 7,
    explanation:
        'Bei Zählung ab 1 gilt: FEZ = FAZ + Dauer - 1, FAZ Nachfolger = FEZ Vorgänger + 1.\n'
        'A: FAZ 1, FEZ 1 + 4 - 1 = 4.\n'
        'B: FAZ 4 + 1 = 5, FEZ 5 + 3 - 1 = 7.\n'
        'Probe: Zusammen 7 Tage Arbeit, B endet am 7. Tag.',
    difficulty: 3,
  ),

  // =========================================================== Rückwärtsrechnung
  rechnen(
    'a1-nr-1',
    'n-rueckwaerts',
    scenario: _netz,
    prompt: 'Wie groß ist der SAZ von Vorgang D?',
    answer: 9,
    unit: 'Tage',
    explanation:
        'Vorwärts: E endet bei 15 - das ist die Projektdauer.\n'
        'E: SEZ 15, SAZ 15 - 4 = 11.\n'
        'D: SEZ = SAZ von E = 11, SAZ = 11 - 2 = 9.',
  ),
  rechnen(
    'a1-nr-2',
    'n-rueckwaerts',
    scenario: _netz,
    prompt: 'Wie groß ist der SEZ von Vorgang A?',
    answer: 5,
    unit: 'Tage',
    explanation:
        'Rückwärts: E 11/15, D 9/11, C 5/11, B: SEZ = SAZ D = 9, SAZ 6.\n'
        'A hat zwei Nachfolger: SEZ = min(SAZ B = 6; SAZ C = 5) = 5.\n'
        'Das Minimum, weil C als eiligster Nachfolger pünktlich starten muss.',
  ),
  einfach(
    'a1-nr-3',
    'n-rueckwaerts',
    prompt:
        'Womit beginnt die Rückwärtsrechnung beim letzten Vorgang, wenn kein Endtermin vorgegeben ist?',
    choices: [
      ja(
        'SEZ = FEZ des letzten Vorgangs',
        'Die errechnete Projektdauer wird zum spätesten Ende.',
      ),
      nein(
        'SEZ = 0',
        'Mit 0 beginnt die Vorwärtsrechnung, nicht die Rückwärtsrechnung.',
      ),
      nein(
        'SEZ = FAZ des letzten Vorgangs',
        'Das wäre der Anfang, nicht das Ende des Vorgangs.',
      ),
      nein(
        'SEZ = Summe aller Vorgangsdauern',
        'Parallele Vorgänge würden dann doppelt gezählt.',
      ),
    ],
    explanation:
        'Ohne vorgegebenen Endtermin ist die Projektdauer aus der Vorwärtsrechnung das späteste Ende.',
  ),
  netzplanAufgabe(
    'a1-nr-4',
    'n-rueckwaerts',
    scenario:
        'Home-Office-Einführung, Dauer in Arbeitstagen. Die Vorwärtsrechnung ergibt eine Projektdauer von 14 Tagen.',
    prompt:
        'Führe die Rückwärtsrechnung durch: Trage SEZ und SAZ für jeden Vorgang ein.',
    vorgaenge: _home,
    gefragt: const [NodeField.saz, NodeField.sez],
    explanation:
        'SEZ Endvorgang = Projektdauer, sonst SEZ = kleinster SAZ der Nachfolger; SAZ = SEZ - Dauer.\n'
        'F: 14 / 14 - 2 = 12\n'
        'D: SEZ = SAZ F = 12, SAZ 12 - 5 = 7\n'
        'E: SEZ = SAZ F = 12, SAZ 12 - 3 = 9\n'
        'C: SEZ = SAZ E = 9, SAZ 9 - 2 = 7\n'
        'B: SEZ = min(SAZ D 7; SAZ E 9) = 7, SAZ 7 - 4 = 3\n'
        'A: SEZ = min(SAZ B 3; SAZ C 7) = 3, SAZ 3 - 3 = 0 ✓',
    difficulty: 2,
  ),
  einfach(
    'a1-nr-5',
    'n-rueckwaerts',
    scenario:
        'Ein Vorgang hat drei Nachfolger: P mit SAZ 10, Q mit SAZ 8 und R mit SAZ 14.',
    prompt: 'Welchen SEZ hat der Vorgang?',
    choices: [
      ja(
        '8',
        'Er muss fertig sein, bevor der eiligste Nachfolger Q spätestens beginnen muss - das Minimum.',
      ),
      nein('14', 'Dann würde Q zu spät beginnen und das Projekt verschieben.'),
      nein('10', 'Auch dann käme Q zu spät.'),
      nein('32', 'SAZ-Werte werden nicht addiert.'),
    ],
    explanation:
        'Rückwärtsrechnung: SEZ = min(SAZ aller Nachfolger) = min(10; 8; 14) = 8.',
    difficulty: 1,
  ),
  rechnen(
    'a1-nr-6',
    'n-rueckwaerts',
    scenario:
        'Die Vorwärtsrechnung eines Netzplans ergibt eine Projektdauer von 20 Tagen. Der Auftraggeber verlangt die Fertigstellung nach 18 Tagen. Die Rückwärtsrechnung startet deshalb mit SEZ = 18.',
    prompt:
        'Um wie viele Tage wird der Termin verfehlt, wenn nichts unternommen wird?',
    answer: 2,
    unit: 'Tage',
    explanation:
        'Startet die Rückwärtsrechnung beim Endtermin 18 statt bei 20, sind alle SAZ und SEZ um 2 kleiner.\n'
        'Auf dem kritischen Pfad gilt dann GP = SAZ - FAZ = -2.\n'
        'Ein negativer Gesamtpuffer von -2 bedeutet: Ohne Gegenmaßnahme wird der Termin um 2 Tage verfehlt.',
    difficulty: 3,
  ),
  einfach(
    'a1-nr-7',
    'n-rueckwaerts',
    prompt:
        'Woran erkennst du, dass die Rückwärtsrechnung (ohne vorgegebenen Endtermin) vermutlich stimmt?',
    choices: [
      ja(
        'Der Startvorgang auf dem kritischen Pfad hat SAZ = FAZ = 0.',
        'Auf dem kritischen Pfad fallen früheste und späteste Zeitpunkte zusammen.',
      ),
      nein(
        'Alle SAZ-Werte sind größer als die Projektdauer.',
        'SAZ-Werte liegen immer innerhalb der Projektdauer.',
      ),
      nein(
        'Alle Vorgänge haben denselben SEZ.',
        'Das wäre nur bei völlig parallelen Vorgängen so.',
      ),
      nein(
        'Die Summe aller SAZ ergibt die Projektdauer.',
        'Diese Summe hat keine Bedeutung.',
      ),
    ],
    explanation:
        'Gegenprobe: Rechnet man ohne Endtermin rückwärts, muss am Startvorgang des kritischen Pfads wieder SAZ = 0 herauskommen. Steht dort etwas anderes, steckt ein Fehler in der Rechnung.',
  ),
  rechnen(
    'a1-nr-8',
    'n-rueckwaerts',
    scenario: _homeText,
    prompt: 'Wie groß ist der SAZ von Vorgang C?',
    answer: 7,
    unit: 'Tage',
    explanation:
        'Vorwärts: A 0/3, B 3/7, C 3/5, D 7/12, E max(7; 5) = 7/10, F max(12; 10) = 12/14.\n'
        'Rückwärts: F 12/14, D 7/12, E: SEZ 12, SAZ 9.\n'
        'C hat nur den Nachfolger E: SEZ C = SAZ E = 9, SAZ C = 9 - 2 = 7.',
  ),

  // ============================================= Gesamtpuffer und freier Puffer
  netzplanAufgabe(
    'a1-np-1',
    'n-puffer',
    scenario: 'Home-Office-Einführung, Dauer in Arbeitstagen.',
    prompt:
        'Berechne für jeden Vorgang den Gesamtpuffer und den freien Puffer.',
    vorgaenge: _home,
    gefragt: const [NodeField.gp, NodeField.fp],
    explanation:
        'Vorwärts (FAZ/FEZ): A 0/3, B 3/7, C 3/5, D 7/12, E 7/10, F 12/14.\n'
        'Rückwärts (SAZ/SEZ): F 12/14, D 7/12, E 9/12, C 7/9, B 3/7, A 0/3.\n'
        'GP = SAZ - FAZ: A 0, B 0, C 4, D 0, E 2, F 0.\n'
        'FP = kleinster FAZ der Nachfolger - FEZ: C 7 - 5 = 2, E 12 - 10 = 2, alle anderen 0.\n'
        'C hat GP 4, aber nur FP 2: Nach 2 Tagen Verschiebung startet E später.',
    difficulty: 3,
  ),
  rechnen(
    'a1-np-2',
    'n-puffer',
    scenario: _homeText,
    prompt: 'Wie groß ist der freie Puffer von Vorgang C?',
    answer: 2,
    unit: 'Tage',
    explanation:
        'Vorwärts: C 3/5, E: FAZ = max(FEZ B 7; FEZ C 5) = 7.\n'
        'C hat nur den Nachfolger E.\n'
        'FP C = FAZ E - FEZ C = 7 - 5 = 2 Tage.\n'
        'Zum Vergleich: GP C = SAZ - FAZ = 7 - 3 = 4 Tage.',
  ),
  einfach(
    'a1-np-3',
    'n-puffer',
    scenario:
        'Vorgang X hat einen Gesamtpuffer von 4 Tagen und einen freien Puffer von 1 Tag. X verzögert sich um 3 Tage.',
    prompt: 'Welche Folge hat das?',
    choices: [
      ja(
        'Die Nachfolger beginnen 2 Tage später, das Projektende bleibt unverändert.',
        '3 Tage > FP 1 → Nachfolger um 3 - 1 = 2 Tage später; 3 Tage ≤ GP 4 → Projektende sicher.',
      ),
      nein(
        'Das Projektende verschiebt sich um 3 Tage.',
        'Dafür müsste die Verzögerung den Gesamtpuffer übersteigen.',
      ),
      nein(
        'Nichts, weder Nachfolger noch Projektende sind betroffen.',
        'Die Verzögerung ist größer als der freie Puffer.',
      ),
      nein(
        'Das Projektende verschiebt sich um 2 Tage.',
        'Das Projektende ist erst betroffen, wenn der Gesamtpuffer überschritten wird.',
      ),
    ],
    explanation:
        'Bis zur Höhe des freien Puffers merkt niemand etwas. Darüber hinaus starten die Nachfolger später. Das Projektende verschiebt sich erst, wenn die Verzögerung größer ist als der Gesamtpuffer.',
  ),
  rechnen(
    'a1-np-4',
    'n-puffer',
    scenario:
        'Ein Vorgang mit einem Gesamtpuffer von 2 Tagen verzögert sich um 5 Tage.',
    prompt: 'Um wie viele Tage verschiebt sich das Projektende?',
    answer: 3,
    unit: 'Tage',
    explanation:
        'Der Gesamtpuffer fängt 2 Tage auf.\n'
        'Verschiebung des Projektendes = Verzögerung - GP = 5 - 2 = 3 Tage.',
  ),
  mehrfach(
    'a1-np-5',
    'n-puffer',
    prompt: 'Welche Aussagen zu Gesamtpuffer und freiem Puffer sind richtig?',
    choices: [
      ja(
        'Der freie Puffer ist nie größer als der Gesamtpuffer.',
        'Es gilt immer FP ≤ GP.',
      ),
      ja(
        'Auf dem kritischen Pfad ist der Gesamtpuffer 0.',
        'Daran erkennt man kritische Vorgänge.',
      ),
      ja(
        'GP = SEZ - FEZ',
        'Gleichwertig zu GP = SAZ - FAZ - gut als Gegenprobe.',
      ),
      nein(
        'Der freie Puffer wird mit dem SAZ des Nachfolgers berechnet.',
        'Richtig ist der FAZ des Nachfolgers.',
      ),
      nein('GP = FAZ - SAZ', 'Vorzeichen vertauscht: GP = SAZ - FAZ.'),
    ],
    explanation:
        'GP = SAZ - FAZ = SEZ - FEZ schützt das Projektende. FP = kleinster FAZ der Nachfolger - FEZ schützt die Nachfolger. Weil der Nachfolger selbst Puffer haben kann, ist FP ≤ GP.',
  ),

  // ============================================================= Kritischer Pfad
  einfach(
    'a1-nk-1',
    'n-kritisch',
    scenario: _netz,
    prompt: 'Welcher Weg ist der kritische Pfad?',
    choices: [
      ja(
        'A - C - E',
        'A, C und E haben einen Gesamtpuffer von 0. Länge 5 + 6 + 4 = 15 Tage.',
      ),
      nein(
        'A - B - D - E',
        'Dieser Weg dauert nur 14 Tage - B und D haben je einen Tag Puffer.',
      ),
      nein(
        'A - B - C',
        'B und C liegen nicht hintereinander, sondern parallel.',
      ),
      nein(
        'Es gibt keinen kritischen Pfad',
        'Jeder Netzplan hat mindestens einen kritischen Pfad.',
      ),
    ],
    explanation:
        'GP = SAZ - FAZ: A 0, B 1, C 0, D 1, E 0. Der kritische Pfad verbindet alle Vorgänge ohne Puffer: A - C - E mit 15 Tagen Projektdauer.',
  ),
  netzplanAufgabe(
    'a1-nk-2',
    'n-kritisch',
    scenario: 'Einrichtung eines Schulungsraums, Dauer in Arbeitstagen.',
    prompt:
        'Berechne den Netzplan vollständig und markiere so den kritischen Pfad.',
    vorgaenge: _raum,
    explanation:
        'Vorwärts: A 0/2, B 2/7, C 2/5, D 5/9, E 7/9, F max(9; 9) = 9/10.\n'
        'Rückwärts: F 9/10, D 5/9, E 7/9, B 2/7, C 2/5, A: SEZ min(2; 2) = 2 → 0/2.\n'
        'GP: alle Vorgänge 0.\n'
        'Es gibt zwei kritische Pfade: A - B - E - F (2 + 5 + 2 + 1 = 10) und A - C - D - F (2 + 3 + 4 + 1 = 10). Jede Verzögerung irgendwo verschiebt das Projektende.',
  ),
  einfach(
    'a1-nk-3',
    'n-kritisch',
    scenario:
        'Einrichtung eines Schulungsraums (Dauer in Tagen):\n'
        'A Planung: 2, Start\n'
        'B Möbel bestellen: 5, nach A\n'
        'C Netz verkabeln: 3, nach A\n'
        'D PCs einrichten: 4, nach C\n'
        'E Möbel aufbauen: 2, nach B\n'
        'F Abnahme: 1, nach D und E',
    prompt: 'Welche Aussage zum kritischen Pfad trifft zu?',
    choices: [
      ja(
        'Es gibt zwei kritische Pfade: A - B - E - F und A - C - D - F mit je 10 Tagen.',
        'Beide Wege sind gleich lang und zugleich die längsten.',
      ),
      nein(
        'Nur A - B - E - F ist kritisch.',
        'A - C - D - F ist mit 10 Tagen genauso lang.',
      ),
      nein(
        'Nur A - C - D - F ist kritisch.',
        'A - B - E - F ist mit 10 Tagen genauso lang.',
      ),
      nein(
        'B ist unkritisch, weil Möbel nichts mit IT zu tun haben.',
        'Kritisch ist, was keinen Puffer hat - der Inhalt spielt keine Rolle.',
      ),
    ],
    explanation:
        'Weg 1: A - B - E - F = 2 + 5 + 2 + 1 = 10. Weg 2: A - C - D - F = 2 + 3 + 4 + 1 = 10. Beide sind am längsten, also kritisch; kein Vorgang hat Puffer. Das Projekt ist dadurch besonders anfällig.',
  ),
  rechnen(
    'a1-nk-4',
    'n-kritisch',
    scenario:
        '$_netz\nVorgang C wird durch zusätzliches Personal von 6 auf 3 Tage verkürzt.',
    prompt: 'Wie lange dauert das Projekt danach?',
    answer: 14,
    unit: 'Tage',
    explanation:
        'Vorher: A - C - E = 5 + 6 + 4 = 15 (kritisch), A - B - D - E = 5 + 3 + 2 + 4 = 14.\n'
        'Nachher: A - C - E = 5 + 3 + 4 = 12, A - B - D - E = 14.\n'
        'Der längste Weg ist jetzt A - B - D - E mit 14 Tagen. Von 3 Tagen Verkürzung bleibt nur 1 Tag übrig - der kritische Pfad ist gewandert.',
    difficulty: 3,
  ),
  einfach(
    'a1-nk-5',
    'n-kritisch',
    scenario:
        'Ein kritischer Vorgang droht sich zu verzögern. Die Projektleitung braucht kurzfristig eine zusätzliche Fachkraft und kann sie von einem anderen Vorgang abziehen.',
    prompt: 'Von welchem Vorgang sollte sie am ehesten jemanden abziehen?',
    choices: [
      ja(
        'Von einem Vorgang mit Gesamtpuffer 6 Tage',
        'Er kann sich am stärksten verzögern, ohne das Projektende zu gefährden.',
      ),
      nein(
        'Von einem anderen kritischen Vorgang',
        'Dann verzögert sich dieser - und das Projektende direkt mit.',
      ),
      nein(
        'Von einem Vorgang mit Gesamtpuffer 1 Tag',
        'Wenig Luft - schon eine kleine Verzögerung macht ihn kritisch.',
      ),
      nein(
        'Vom Vorgang mit der längsten Dauer',
        'Die Dauer sagt nichts über den Puffer aus.',
      ),
    ],
    explanation:
        'Ressourcen gehören auf den kritischen Pfad. Abgezogen wird dort, wo am meisten Puffer ist - danach sollte man neu rechnen, ob der Puffer noch reicht.',
  ),
  mehrfach(
    'a1-nk-6',
    'n-kritisch',
    prompt: 'Mit welchen Maßnahmen lässt sich die Projektdauer verkürzen?',
    choices: [
      ja(
        'Mehr Personal auf einen kritischen Vorgang setzen',
        'Verkürzt den kritischen Pfad (Crashing).',
      ),
      ja(
        'Kritische Vorgänge teilweise parallel ausführen',
        'Verkürzt den kritischen Pfad (Fast Tracking).',
      ),
      ja(
        'Den Umfang eines kritischen Vorgangs reduzieren',
        'Weniger Arbeit auf dem kritischen Pfad - in Absprache mit dem Auftraggeber.',
      ),
      nein(
        'Einen unkritischen Vorgang beschleunigen',
        'Vergrößert nur dessen Puffer, das Projektende bleibt.',
      ),
      nein(
        'Die Puffer der unkritischen Vorgänge erhöhen',
        'Puffer entsteht aus der Struktur und verkürzt nichts.',
      ),
    ],
    explanation:
        'Nur Maßnahmen auf dem kritischen Pfad verkürzen das Projekt - und nur so lange, bis ein anderer Weg kritisch wird. Danach immer neu rechnen.',
  ),
  einfach(
    'a1-nk-7',
    'n-kritisch',
    scenario:
        'Das Gantt-Diagramm zeigt einen Plan in Normalfolge. B und C folgen auf A, D folgt auf B und C. Die Zahlen sind Tage.',
    skizze: const GanttDiagramm([
      GanttVorgang('A Analyse', 0, 3),
      GanttVorgang('B Konzept', 3, 2),
      GanttVorgang('C Hardware', 3, 4),
      GanttVorgang('D Test', 7, 1),
    ]),
    prompt: 'Welcher Vorgang hat Puffer, und wie viel?',
    choices: [
      ja('B mit 2 Tagen', 'B endet bei 5, D beginnt erst bei 7 - 2 Tage Luft.'),
      nein(
        'C mit 4 Tagen',
        'C endet bei 7 und D beginnt sofort - C ist kritisch. 4 ist nur seine Dauer.',
      ),
      nein(
        'D mit 1 Tag',
        'D ist der Endvorgang auf dem kritischen Pfad; 1 ist seine Dauer.',
      ),
      nein(
        'A mit 3 Tagen',
        'A ist der Startvorgang; B und C beginnen direkt danach.',
      ),
    ],
    explanation:
        'Kritischer Pfad: A - C - D (3 + 4 + 1 = 8 Tage), lückenlos. B endet bei 5, sein Nachfolger D beginnt bei 7: B hat 2 Tage Puffer (GP = FP = 2).',
  ),
];
