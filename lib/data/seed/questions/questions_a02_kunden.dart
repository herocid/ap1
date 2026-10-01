import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 02 - Kundenbeziehungen und Kommunikation.
final List<Question> questionsA02 = [
  // =================================================== Kommunikationsmodelle
  zuordnen(
    'a2-km-1',
    'k-modelle',
    scenario:
        'Ein Kunde sagt am Telefon: „Das Update hat schon wieder alles kaputt gemacht.“',
    prompt: 'Ordne jede Deutung der passenden Seite der Nachricht zu.',
    buckets: ['Sachinhalt', 'Selbstoffenbarung', 'Beziehung', 'Appell'],
    items: [
      zu('Ich bin frustriert.', 1),
      zu('Nach dem Update funktioniert etwas nicht.', 0),
      zu('Macht das Update rückgängig!', 3),
      zu('Ihr liefert schlechte Arbeit.', 2),
    ],
    explanation:
        'Nach Schulz von Thun sendet jede Nachricht vier Botschaften: Sache, Selbstoffenbarung, Beziehung und Appell. Im Support hilft es, vor allem den Sachinhalt und den Appell zu hören.',
  ),
  paare(
    'a2-km-2',
    'k-modelle',
    scenario:
        'In einer Schulung zur Kundenkommunikation werden vier Kommunikationsmodelle vorgestellt.',
    prompt: 'Ordne jedem Modell seine Kernaussage zu.',
    paare: [
      paar('Sender-Empfänger-Modell', 'gemeinsamer Zeichenvorrat nötig'),
      paar('Vier-Seiten-Modell', 'vier Botschaften in jeder Nachricht'),
      paar(
        '2. Axiom nach Watzlawick',
        'Beziehung prägt, wie der Inhalt ankommt',
      ),
      paar('1. Axiom nach Watzlawick', 'auch Schweigen ist eine Botschaft'),
    ],
    explanation:
        'Sender-Empfänger: Verständigung braucht einen gemeinsamen Zeichenvorrat. Schulz von Thun: Sache, Selbstoffenbarung, Beziehung, Appell. Watzlawick: Die Beziehung bestimmt, wie ein Inhalt verstanden wird (2. Axiom), und man kann nicht nicht kommunizieren (1. Axiom). Wer im Kundentermin aufs Handy schaut, sendet eine Botschaft.',
  ),
  einfach(
    'a2-km-3',
    'k-modelle',
    scenario:
        'Ein Administrator erklärt einer Sachbearbeiterin: „Ihr DNS-Resolver liefert NXDOMAIN.“ Sie versteht nichts.',
    prompt: 'Welche Ursache beschreibt das Sender-Empfänger-Modell?',
    choices: [
      ja(
        'Sender und Empfänger haben keinen gemeinsamen Zeichenvorrat.',
        'Die Fachbegriffe sind der Empfängerin unbekannt. Die Nachricht kann nicht entschlüsselt werden.',
      ),
      nein(
        'Der Kanal ist gestört.',
        'Die Worte kommen an, sie werden nur nicht verstanden.',
      ),
      nein(
        'Die Empfängerin hört nur mit dem Beziehungsohr.',
        'Das ist eine Deutung nach Schulz von Thun, hier fehlt schlicht das Fachwissen.',
      ),
      nein(
        'Die Botschaft ist nonverbal.',
        'Sie ist verbal, nur unverständlich.',
      ),
    ],
    explanation:
        'Verständigung setzt einen gemeinsamen Zeichenvorrat voraus. Fachsprache gegenüber Laien verletzt genau diese Bedingung.',
  ),

  mehrfach(
    'a2-km-4',
    'k-modelle',
    scenario:
        'Im Teammeeting sagt der Projektleiter zu einer Auszubildenden: „Die Präsentation beim Kunden ist morgen um neun.“ Sie antwortet gereizt: „Ich weiß, ich bin ja nicht blöd.“',
    prompt:
        'Welche Aussagen erklären die Reaktion mit dem Vier-Seiten-Modell richtig?',
    choices: [
      ja(
        'Sie hat die Aussage vor allem mit dem Beziehungsohr gehört.',
        'Sie fühlt sich bevormundet. Das ist eine Deutung auf der Beziehungsebene.',
      ),
      ja(
        'Der Sachinhalt (der Termin) ist bei ihr angekommen.',
        '„Ich weiß“ zeigt, dass die Sachinformation verstanden wurde.',
      ),
      ja(
        'Sie könnte den Appell „Sei gut vorbereitet“ als Misstrauen gedeutet haben.',
        'Appell und Beziehung werden oft zusammen gehört: Die Aufforderung wirkt wie ein Zweifel an ihr.',
      ),
      nein(
        'Die Nachricht wurde im Kanal gestört.',
        'Kanalstörungen erklärt das Sender-Empfänger-Modell; hier kam akustisch alles an.',
      ),
      nein(
        'Der Projektleiter hat keine Selbstoffenbarung gesendet.',
        'Jede Nachricht enthält alle vier Seiten, also auch eine Selbstoffenbarung, etwa dass ihm der Termin wichtig ist.',
      ),
    ],
    explanation:
        'Nach Schulz von Thun enthält jede Nachricht vier Seiten. Die Auszubildende hört vor allem mit dem Beziehungsohr („Er hält mich für vergesslich“). Der Sachinhalt ist angekommen, eine Kanalstörung liegt nicht vor.',
  ),
  zuordnen(
    'a2-km-5',
    'k-modelle',
    prompt: 'Welches Axiom nach Watzlawick zeigt sich in der Situation?',
    buckets: [
      'Man kann nicht nicht kommunizieren',
      'Inhalts- und Beziehungsaspekt',
      'Interpunktion',
      'digital und analog',
    ],
    items: [
      zu(
        'Dieselbe Kritik nimmt ein Azubi vom geschätzten Ausbilder an, vom unbeliebten Kollegen nicht.',
        1,
      ),
      zu(
        'Ein Kollege beantwortet eine E-Mail gar nicht. Die Absenderin deutet das als Ablehnung.',
        0,
      ),
      zu('Der Kunde sagt „Sehr schön“ und rollt dabei mit den Augen.', 3),
      zu(
        'Teamleiterin: „Ich kontrolliere, weil ihr Fehler macht.“ Team: „Wir machen Fehler, weil du uns ständig kontrollierst.“',
        2,
      ),
    ],
    explanation:
        'Auch Schweigen ist eine Botschaft (1. Axiom). Die Beziehung bestimmt, wie ein Inhalt ankommt (2.). Bei der Interpunktion sieht jeder den Auslöser beim anderen (3.). Worte (digital) und Körpersprache (analog) senden gleichzeitig, hier widersprüchlich (4.).',
    difficulty: 3,
  ),
  einfach(
    'a2-km-6',
    'k-modelle',
    scenario:
        'Zwei Entwickler streiten seit Wochen heftig darüber, ob im Code Tabs oder Leerzeichen verwendet werden. Eigentlich fühlt sich einer von ihnen übergangen, weil der andere die Teamleitung bekommen hat.',
    prompt: 'Welches Modell erklärt diesen Streit am besten?',
    choices: [
      ja(
        'Watzlawicks 2. Axiom: Die gestörte Beziehungsebene bestimmt, wie der Inhalt ankommt.',
        'Die Kränkung wirkt auf der Beziehungsebene und macht die harmlose Sachfrage zum Dauerstreit.',
      ),
      nein(
        'Das Sender-Empfänger-Modell: Es fehlt ein gemeinsamer Zeichenvorrat.',
        'Beide kennen die Begriffe genau; am Verstehen liegt es nicht.',
      ),
      nein(
        'Das Tuckman-Modell: Das Team ist in der Performing-Phase.',
        'In der Performing-Phase arbeitet ein Team konfliktarm; verdeckte Motive erklärt Tuckman nicht.',
      ),
      nein(
        'Verbal, paraverbal, nonverbal: Die Körpersprache widerspricht den Worten.',
        'Von widersprüchlichen Signalen ist keine Rede. Der Grund liegt in der Beziehung, nicht in der Körpersprache.',
      ),
    ],
    explanation:
        'Nach Watzlawick hat jede Nachricht einen Inhalts- und einen Beziehungsaspekt, und die Beziehung bestimmt den Inhalt. Gefühle wie Kränkung steuern deshalb das Gespräch. Solange nur über Tabs gestritten wird, bleibt der eigentliche Konflikt ungelöst.',
  ),
  zuordnen(
    'a2-km-7',
    'k-modelle',
    scenario:
        'Du beobachtest ein Kundengespräch und notierst, worüber Botschaften gesendet werden.',
    prompt: 'Ordne jedes Signal der richtigen Ebene der Kommunikation zu.',
    buckets: ['verbal', 'paraverbal', 'nonverbal'],
    items: [
      zu('Lautstärke', 1),
      zu('Blickkontakt', 2),
      zu('Wortwahl', 0),
      zu('Sprechtempo', 1),
      zu('Gestik', 2),
      zu('Tonfall', 1),
      zu('Fachbegriffe', 0),
      zu('Körperhaltung', 2),
    ],
    explanation:
        'Verbal sind die Worte, paraverbal ist die Art des Sprechens (Tonfall, Lautstärke, Tempo, Pausen), nonverbal die Körpersprache (Mimik, Gestik, Blickkontakt, Haltung).',
    difficulty: 1,
  ),

  // ======================================================== Gesprächsführung
  zuordnen(
    'a2-kg-1',
    'k-gespraech',
    scenario:
        'Du führst ein Beratungsgespräch mit einer Steuerkanzlei, die ein neues Dokumentenmanagement sucht.',
    prompt: 'In welche Gesprächsphase gehört die Äußerung?',
    buckets: ['Kontakt', 'Bedarfsermittlung', 'Lösung mit Nutzen', 'Abschluss'],
    items: [
      zu(
        '„Schön, dass es heute klappt. Ich möchte verstehen, wo es bei Ihnen hakt.“',
        0,
        'Begrüßung und Gesprächsziel gehören zum Kontakt.',
      ),
      zu(
        '„Wie legen Sie Mandantenunterlagen heute ab?“',
        1,
        'Die Ist-Situation wird erfragt.',
      ),
      zu(
        '„Wie viele Mitarbeitende sollen damit arbeiten, und bis wann?“',
        1,
        'Rahmenbedingungen gehören zur Bedarfsermittlung.',
      ),
      zu(
        '„Mit der Volltextsuche finden Sie jede Akte in Sekunden statt Minuten.“',
        2,
        'Ein Merkmal wird in einen Nutzen für den Kunden übersetzt.',
      ),
      zu(
        '„Ich schicke Ihnen das Angebot bis Freitag und rufe Montag an.“',
        3,
        'Nächste Schritte verbindlich vereinbaren schließt das Gespräch ab.',
      ),
    ],
    explanation:
        'Kontakt schafft Orientierung, die Bedarfsermittlung klärt Ist, Ziel und Rahmen, die Lösung wird mit ihrem Nutzen begründet, der Abschluss legt nächste Schritte fest.',
  ),
  einfach(
    'a2-kg-2',
    'k-gespraech',
    scenario:
        'Eine Kundin schildert aufgebracht, dass der Export ihrer Buchhaltungssoftware seit gestern abbricht und der Monatsabschluss drängt.',
    prompt: 'Welche Reaktion ist für den Einstieg am besten geeignet?',
    choices: [
      ja(
        '„Das ist ärgerlich, gerade vor dem Abschluss. Welche Meldung erscheint beim Export?“',
        'Erkennt den Ärger an (Beziehungsebene) und klärt dann gezielt den Sachverhalt.',
      ),
      nein(
        '„Das kann eigentlich nicht sein, bei anderen Kunden läuft es.“',
        'Widerspricht und stellt die Kundin in Frage, ein Gesprächsstörer.',
      ),
      nein(
        '„Haben Sie das Handbuch gelesen?“',
        'Wirkt belehrend und blockiert das Gespräch.',
      ),
      nein(
        '„Beruhigen Sie sich erst einmal.“',
        'Übergeht das Anliegen und verstärkt oft den Ärger.',
      ),
    ],
    explanation:
        'Bei Beschwerden erst die Beziehungsebene beruhigen (Ärger anerkennen), dann sachlich nachfragen. Widersprechen, Belehren und Abwiegeln sind Gesprächsstörer.',
  ),
  reihenfolge(
    'a2-kg-3',
    'k-gespraech',
    prompt:
        'Bringe die Phasen eines Beratungsgesprächs in eine sinnvolle Reihenfolge.',
    items: [
      'Begrüßung und Gesprächsziel klären',
      'Ist-Situation, Ziele und Rahmen ermitteln',
      'Verständnis durch Zusammenfassen sichern',
      'Lösung vorschlagen und mit dem Nutzen begründen',
      'Nächste Schritte vereinbaren',
    ],
    explanation:
        'Erst verstehen, dann lösen: Wer vor der Bedarfsermittlung eine Lösung anbietet, rät nur.',
  ),

  zuordnen(
    'a2-kg-4',
    'k-gespraech',
    scenario:
        'Ein Handwerksbetrieb sucht ein Warenwirtschaftssystem. In der Bedarfsermittlung notierst du die Antworten.',
    prompt: 'Welcher Teil der Bedarfsermittlung wird geklärt?',
    buckets: ['Ist-Situation', 'Ziel', 'Rahmenbedingung'],
    items: [
      zu(
        'Bestellungen werden heute in Excel-Listen erfasst.',
        0,
        'Beschreibt, wie heute gearbeitet wird.',
      ),
      zu(
        'Fehlbestände sollen künftig automatisch gemeldet werden.',
        1,
        'Beschreibt, was danach besser sein soll.',
      ),
      zu(
        'Das Budget liegt bei 8.000 Euro.',
        2,
        'Budget begrenzt die möglichen Lösungen.',
      ),
      zu(
        'Das System muss bis zum Jahreswechsel laufen.',
        2,
        'Ein Termin ist eine Rahmenbedingung.',
      ),
      zu(
        'Lagerbestände werden einmal im Monat von Hand gezählt.',
        0,
        'Auch das ist der heutige Ablauf.',
      ),
      zu(
        'Die Inventur soll höchstens noch einen Tag dauern.',
        1,
        'Ein messbares Ziel des Kunden.',
      ),
    ],
    explanation:
        'Eine vollständige Bedarfsermittlung klärt die Ist-Situation (wie heute), die Ziele (was besser werden soll) und den Rahmen (Budget, Termin, Nutzer, Schnittstellen). Erst dann folgt die Lösung.',
    difficulty: 1,
  ),
  zuordnen(
    'a2-kg-5',
    'k-gespraech',
    scenario:
        'In einer Schulung für den Support werden Formulierungen gegenüber Kunden und Kollegen bewertet.',
    prompt:
        'Ist die Formulierung eine echte Ich-Botschaft oder eine Du-Botschaft?',
    buckets: ['echte Ich-Botschaft', 'Du-Botschaft (auch verkappt)'],
    items: [
      zu(
        '„Ich kann erst weitermachen, wenn ich die Zugangsdaten habe.“',
        0,
        'Beschreibt die eigene Lage und einen Wunsch.',
      ),
      zu(
        '„Sie haben mir schon wieder nichts geschickt.“',
        1,
        'Vorwurf an die Person.',
      ),
      zu(
        '„Ich finde, du bist total unzuverlässig.“',
        1,
        'Beginnt mit „Ich“, bewertet aber die Person: verkappt.',
      ),
      zu(
        '„Ich verliere den Faden, wenn ich unterbrochen werde. Lass mich bitte ausreden.“',
        0,
        'Beobachtung, Wirkung, Wunsch.',
      ),
      zu('„Ihr meldet euch ja nie.“', 1, 'Verallgemeinernder Vorwurf.'),
      zu(
        '„Ich brauche die Freigabe bis Donnerstag, damit der Termin hält.“',
        0,
        'Eigener Bedarf mit Begründung.',
      ),
    ],
    explanation:
        'Eine echte Ich-Botschaft beschreibt Beobachtung, Wirkung auf mich und Wunsch, ohne die Person zu bewerten. „Ich finde, du bist ...“ ist eine verkappte Du-Botschaft.',
  ),
  einfach(
    'a2-kg-6',
    'k-gespraech',
    scenario:
        'Ein Kunde schickt zum dritten Mal eine Fehlermeldung ohne Angabe, was er vorher gemacht hat.',
    prompt: 'Welche Formulierung ist eine gelungene Ich-Botschaft?',
    choices: [
      ja(
        '„Ich kann den Fehler nur nachstellen, wenn ich weiß, was Sie vorher geklickt haben. Können Sie mir die Schritte kurz aufschreiben?“',
        'Beschreibt die eigene Lage, die Wirkung und einen konkreten Wunsch.',
      ),
      nein(
        '„Sie schicken mir immer unvollständige Beschreibungen.“',
        'Sie-Botschaft mit Verallgemeinerung „immer“. Sie wirkt als Vorwurf.',
      ),
      nein(
        '„Ich finde, Sie sind da ziemlich nachlässig.“',
        'Beginnt zwar mit „Ich“, bewertet aber die Person. Das ist eine verdeckte Du-Botschaft.',
      ),
      nein(
        '„Man sollte eine Fehlermeldung schon vollständig beschreiben.“',
        'Man-Botschaft: unpersönlich und belehrend.',
      ),
    ],
    explanation:
        'Eine echte Ich-Botschaft beschreibt Beobachtung, Wirkung und Wunsch aus eigener Sicht, ohne die Person zu bewerten. Ein „Ich finde, Sie sind ...“ ist eine getarnte Du-Botschaft.',
  ),
  zuordnen(
    'a2-kg-7',
    'k-gespraech',
    scenario:
        'Im Support reagieren Mitarbeitende unterschiedlich auf eine Kundenbeschwerde.',
    prompt: 'Ist die Reaktion ein Gesprächsförderer oder ein Gesprächsstörer?',
    buckets: ['Gesprächsförderer', 'Gesprächsstörer'],
    items: [
      zu('„Das steht doch im Handbuch.“', 1, 'Belehren wirkt von oben herab.'),
      zu(
        '„Was genau passiert, wenn Sie auf Speichern klicken?“',
        0,
        'Eine gezielte Nachfrage fördert das Gespräch.',
      ),
      zu(
        '„Ist doch halb so wild.“',
        1,
        'Bagatellisieren nimmt das Anliegen nicht ernst.',
      ),
      zu(
        '„Sie meinen also, dass der Fehler nur morgens auftritt?“',
        0,
        'Zusammenfassen sichert das Verstehen.',
      ),
      zu(
        'Den Kunden mitten im Satz unterbrechen',
        1,
        'Wer unterbricht, signalisiert Desinteresse.',
      ),
      zu(
        '„Ich verstehe, dass Sie das ärgert.“',
        0,
        'Gefühle anzuerkennen entspannt das Gespräch.',
      ),
    ],
    explanation:
        'Gesprächsstörer sind z. B. Belehren, Bagatellisieren, Unterbrechen, ungefragte Ratschläge. Gesprächsförderer sind Nachfragen, Zusammenfassen, Ich-Botschaften und das Anerkennen von Gefühlen.',
    difficulty: 1,
  ),

  // ============================================ Kunden beraten und betreuen
  reihenfolge(
    'a2-kk-1',
    'k-kunde',
    prompt:
        'Bringe die Bearbeitungsschritte eines Tickets in die richtige Reihenfolge.',
    items: [
      'Anfrage erfassen',
      'Kategorisieren',
      'Priorisieren',
      'Bearbeiten oder weiterleiten',
      'Lösung dokumentieren und bestätigen lassen',
      'Ticket schließen',
    ],
    explanation:
        'Erst vollständig erfassen und einordnen, dann bearbeiten. Geschlossen wird erst, wenn die Lösung dokumentiert und vom Kunden bestätigt ist.',
  ),
  tabelle(
    'a2-kk-2',
    'k-kunde',
    scenario:
        'Im Service gilt: Auswirkung hoch = ganzes Unternehmen, mittel = eine Abteilung, gering = eine Person. Dringlichkeit hoch = Lösung heute nötig, mittel = diese Woche, gering = ohne Termin.\n'
        'Priorität 1 = beide hoch; Priorität 2 = einmal hoch und einmal mittel; Priorität 3 = alle übrigen Kombinationen.',
    prompt:
        'Bestimme für jedes Ticket Auswirkung, Dringlichkeit und Priorität.',
    zeilen: [
      ['Ticket', 'Auswirkung', 'Dringlichkeit', 'Priorität'],
      [
        'Der Mailserver ist ausgefallen, niemand im Unternehmen kann arbeiten.',
        wahl('hoch', ['mittel', 'gering']),
        wahl('hoch', ['mittel', 'gering']),
        wahl('1', ['2', '3']),
      ],
      [
        'In der Buchhaltung startet die Lohnsoftware nicht. Die Löhne müssen heute raus.',
        wahl('mittel', ['hoch', 'gering']),
        wahl('hoch', ['mittel', 'gering']),
        wahl('2', ['1', '3']),
      ],
      [
        'Eine Mitarbeiterin wünscht sich einen zweiten Monitor, ein Termin ist nicht genannt.',
        wahl('gering', ['hoch', 'mittel']),
        wahl('gering', ['hoch', 'mittel']),
        wahl('3', ['1', '2']),
      ],
    ],
    explanation:
        'Die Priorität ergibt sich aus Auswirkung und Dringlichkeit. Mailserver: ganzes Unternehmen und sofort, also Priorität 1. Lohnsoftware: eine Abteilung (mittel), Frist heute (hoch), also Priorität 2. Monitorwunsch: eine Person, kein Termin, also Priorität 3.',
  ),
  einfach(
    'a2-kk-3',
    'k-kunde',
    scenario:
        'Die Geschäftsführerin eines Kunden fragt, warum eine Firewall angeschafft werden soll.',
    prompt: 'Welche Antwort ist adressatengerecht?',
    choices: [
      ja(
        '„Sie schützt Ihr Firmennetz vor Angriffen aus dem Internet und verringert das Risiko teurer Ausfälle.“',
        'Nennt Nutzen und Wirkung in ihrer Sprache.',
      ),
      nein(
        '„Weil sie stateful Packet Inspection auf Layer 4 macht.“',
        'Technisch richtig, für die Geschäftsführung aber unverständlich.',
      ),
      nein('„Weil man das heute eben so macht.“', 'Keine Begründung.'),
      nein(
        '„Das würde zu lange dauern, das zu erklären.“',
        'Verweigert die Beratung.',
      ),
    ],
    explanation:
        'Entscheider brauchen Nutzen, Risiken und Kosten, keine Technikdetails. Adressatengerecht heißt, die Sprache an das Gegenüber anzupassen.',
  ),

  einfach(
    'a2-kk-4',
    'k-kunde',
    scenario:
        'Ein Kunde unterbricht dich ständig und erklärt, er kenne sich mit Netzwerken ohnehin besser aus als du.',
    prompt: 'Wie reagierst du am professionellsten?',
    choices: [
      ja(
        'Sein Wissen anerkennen und sachlich-fachlich argumentieren',
        'Beim „Besserwisser“ hilft es, sein Wissen zu würdigen und bei Fakten zu bleiben.',
      ),
      nein(
        'Ihm nachweisen, dass er falsch liegt',
        'Führt zum Machtkampf. Der Kunde verliert das Gesicht.',
      ),
      nein(
        'Das Gespräch sofort abbrechen',
        'Verweigert die Beratung und verärgert den Kunden.',
      ),
      nein(
        'Nur noch mit Ja und Nein antworten',
        'Wirkt beleidigt und bringt das Gespräch nicht weiter.',
      ),
    ],
    explanation:
        'Kundentypen helfen bei der Reaktion: Den „Besserwisser“ nimmt man mit Anerkennung und sachlichen Argumenten mit, statt mit ihm um Recht zu streiten.',
    difficulty: 1,
  ),
  zuordnen(
    'a2-kk-5',
    'k-kunde',
    prompt: 'Ist der Kommunikationskanal synchron oder asynchron?',
    buckets: ['synchron', 'asynchron'],
    items: [
      zu('Videokonferenz', 0),
      zu('Telefonat mit dem Kunden', 0),
      zu('Brief', 1),
      zu('Eintrag im Ticketsystem', 1),
      zu('E-Mail', 1),
      zu('Fernwartungssitzung, bei der der Kunde zusieht', 0),
    ],
    explanation:
        'Synchron heißt: Beide sind gleichzeitig beteiligt (Telefon, Videokonferenz, Fernwartung). Asynchron heißt: Die Antwort kann zeitversetzt kommen (E-Mail, Ticket, Brief). Das lässt sich leichter dokumentieren.',
    difficulty: 1,
  ),
  einfach(
    'a2-kk-6',
    'k-kunde',
    scenario:
        'Im Service gilt: Auswirkung hoch = ganzes Unternehmen, mittel = eine Abteilung, gering = eine Person. Dringlichkeit hoch = Frist heute, mittel = diese Woche, gering = ohne Termin.\n'
        'Priorität: hoch/hoch = 1; einmal hoch und einmal mittel = 2; beide mittel oder einmal hoch und einmal gering = 3.\n'
        'Die Buchhaltung meldet: Die Lohnsoftware startet auf keinem der fünf Rechner der Abteilung. Die Löhne müssen heute überwiesen werden.',
    prompt: 'Welche Priorität erhält das Ticket?',
    choices: [
      ja(
        'Priorität 2',
        'Auswirkung mittel (eine Abteilung) und Dringlichkeit hoch (Frist heute).',
      ),
      nein('Priorität 1', 'Dafür müsste das ganze Unternehmen betroffen sein.'),
      nein(
        'Priorität 3',
        'Die Frist heute macht das Ticket hoch dringlich. Das ergibt mehr als 3.',
      ),
      nein('Priorität 5', 'Passt nur zu geringer Auswirkung ohne Termin.'),
    ],
    explanation:
        'Die Priorität ergibt sich aus Auswirkung und Dringlichkeit. Betroffen ist eine Abteilung (mittel), die Frist ist heute (hoch). Laut Matrix: einmal hoch und einmal mittel = Priorität 2.',
  ),
  reihenfolge(
    'a2-kk-7',
    'k-kunde',
    scenario:
        'Eine Kundin beschwert sich, dass ein zugesagter Techniker nicht erschienen ist.',
    prompt:
        'Bringe die Schritte der Beschwerdebehandlung in eine sinnvolle Reihenfolge.',
    items: [
      'Zuhören und ausreden lassen',
      'Verständnis zeigen und für den Hinweis danken',
      'Sachverhalt mit Fragen klären',
      'Lösung anbieten und Termin vereinbaren',
      'Lösung umsetzen und bei der Kundin nachfassen',
      'Beschwerde dokumentieren und Ursache abstellen',
    ],
    explanation:
        'Erst den Ärger aufnehmen, dann klären und lösen. Zum Schluss wird die Beschwerde dokumentiert und die Ursache abgestellt, damit sie sich nicht wiederholt.',
  ),

  // ============================================== Teamphasen nach Tuckman
  reihenfolge(
    'a2-tt-1',
    'te-phasen',
    prompt: 'Bringe die Teamphasen nach Tuckman in die richtige Reihenfolge.',
    items: ['Forming', 'Storming', 'Norming', 'Performing', 'Adjourning'],
    explanation: 'Orientierung, Konflikt, Regeln, Leistung, Auflösung.',
  ),
  einfach(
    'a2-tt-2',
    'te-phasen',
    scenario:
        'Im neuen Projektteam gibt es ständig Diskussionen darüber, wer welche Aufgaben übernimmt und wessen Vorschlag umgesetzt wird.',
    prompt: 'In welcher Phase befindet sich das Team?',
    choices: [
      ja(
        'Storming',
        'Rollen und Einfluss werden ausgehandelt; das ist typisch für die Konfliktphase.',
      ),
      nein('Forming', 'Da wäre das Team noch vorsichtig und höflich.'),
      nein('Norming', 'Da hätte man sich bereits auf Regeln geeinigt.'),
      nein(
        'Performing',
        'Da würde das Team konfliktarm und effektiv arbeiten.',
      ),
    ],
    explanation:
        'Offene Auseinandersetzungen über Rollen und Macht kennzeichnen die Storming-Phase.',
  ),
  lueckentext(
    'a2-tt-3',
    'te-phasen',
    scenario:
        'Ein neu zusammengestelltes Projektteam durchläuft die Teamphasen nach Tuckman.',
    prompt: 'Setze die Phasen an der richtigen Stelle ein.',
    text:
        'Im {0} lernen sich die Mitglieder kennen und sind noch zurückhaltend. Im {1} wird um Rollen und Einfluss gestritten. Im {2} einigt sich das Team auf gemeinsame Regeln. Sie festzuhalten stabilisiert die Zusammenarbeit. Im {3} arbeitet es selbstständig und effektiv.',
    luecken: [
      wort(['Forming'], 'Orientierung.'),
      wort(['Storming'], 'Konflikt.'),
      wort(['Norming'], 'Regeln.'),
      wort(['Performing'], 'Leistung.'),
    ],
    wortbank: ['Adjourning', 'Brainstorming'],
    explanation:
        'Forming (Orientierung), Storming (Konflikt), Norming (Regeln), Performing (Leistung), Adjourning (Auflösung). In der Norming-Phase hilft es am meisten, die gemeinsam vereinbarten Regeln festzuhalten.',
  ),

  zuordnen(
    'a2-tt-4',
    'te-phasen',
    scenario:
        'Ein Projektteam führt über mehrere Monate ein neues Ticketsystem ein.',
    prompt: 'In welcher Teamphase fällt die Aussage?',
    buckets: ['Forming', 'Storming', 'Norming', 'Performing', 'Adjourning'],
    items: [
      zu('„Warum soll ausgerechnet dein Konzept umgesetzt werden?“', 1),
      zu('„Du testest, ich spiele es ein. Heute sind wir fertig.“', 3),
      zu('„Ich weiß noch gar nicht, was hier von mir erwartet wird.“', 0),
      zu('„Lasst uns festhalten: Code-Reviews immer vor dem Merge.“', 2),
      zu(
        '„Die Übergabe an den Betrieb ist erledigt. Danke für die tolle Zusammenarbeit!“',
        4,
      ),
    ],
    explanation:
        'Forming: Orientierung und Unsicherheit. Storming: Machtkämpfe um Rollen und Ideen. Norming: gemeinsame Regeln. Performing: selbstständige, eingespielte Arbeit. Adjourning: Abschluss und Abschied.',
  ),
  einfach(
    'a2-tt-5',
    'te-phasen',
    scenario:
        'Ein eingespieltes Team arbeitet seit Monaten selbstständig und effektiv. Nun kommen zwei neue Kolleginnen dazu, und die Projektziele werden geändert. Plötzlich gibt es wieder Streit um Zuständigkeiten.',
    prompt: 'Wie lässt sich die Situation nach Tuckman erklären?',
    choices: [
      ja(
        'Das Team ist durch die Veränderungen in die Storming-Phase zurückgefallen.',
        'Neue Mitglieder und neue Ziele stellen Rollen wieder infrage, ein typischer Rückfall.',
      ),
      nein(
        'Das Team ist in der Adjourning-Phase.',
        'Das Team löst sich nicht auf, es verändert sich.',
      ),
      nein(
        'Das Team ist gescheitert, weil es nicht in der Performing-Phase bleibt.',
        'Rückfälle in frühere Phasen sind normal und kein Scheitern.',
      ),
      nein(
        'Das Team ist in der Forming-Phase, weil dort gestritten wird.',
        'Im Forming sind Teams höflich und abwartend; gestritten wird im Storming.',
      ),
    ],
    explanation:
        'Die Phasen nach Tuckman sind kein Einbahnweg. Ändern sich Zusammensetzung oder Ziele, fällt ein Team oft zurück (hier ins Storming, weil Rollen neu ausgehandelt werden).',
  ),
  mehrfach(
    'a2-tt-6',
    'te-phasen',
    scenario:
        'Im neuen Projektteam wird heftig darüber gestritten, wer welche Aufgaben übernimmt.',
    prompt: 'Was sollte die Teamleitung in dieser Phase tun?',
    choices: [
      ja(
        'Konflikte offen ansprechen und moderieren',
        'Storming braucht Moderation, damit Konflikte geklärt werden.',
      ),
      ja(
        'Helfen, Rollen und Zuständigkeiten zu klären',
        'Geklärte Rollen beenden die Machtkämpfe.',
      ),
      ja(
        'Unterschiedliche Sichtweisen sichtbar machen und fair diskutieren lassen',
        'So werden Konflikte sachlich ausgetragen statt unterdrückt.',
      ),
      nein(
        'Konflikte unterdrücken, damit Ruhe einkehrt',
        'Unterdrückte Konflikte verlängern das Storming und brechen später wieder auf.',
      ),
      nein(
        'Sich ganz zurückziehen und das Team allein machen lassen',
        'Viel Freiraum passt zur Performing-Phase, nicht zum Storming.',
      ),
    ],
    explanation:
        'In der Storming-Phase ringen die Mitglieder um Rollen und Einfluss. Die Leitung moderiert Konflikte und hilft, Rollen zu klären. So kommt das Team ins Norming.',
  ),
  zuordnen(
    'a2-tt-7',
    'te-phasen',
    prompt: 'Zu welchem Schwerpunkt gehört die Teamrolle nach Belbin?',
    buckets: ['Handeln', 'Kommunikation', 'Wissen'],
    items: [
      zu('Umsetzer', 0),
      zu('Koordinator', 1),
      zu('Teamarbeiter', 1),
      zu('Beobachter', 2),
      zu('Macher', 0),
      zu('Perfektionist', 0),
      zu('Wegbereiter', 1),
      zu('Neuerer', 2),
      zu('Spezialist', 2),
    ],
    explanation:
        'Belbin beschreibt neun Rollen: handlungsorientiert (Macher, Umsetzer, Perfektionist), kommunikationsorientiert (Koordinator, Teamarbeiter, Wegbereiter) und wissensorientiert (Neuerer, Beobachter, Spezialist).',
    difficulty: 3,
  ),

  // ============================================ Feedback und Fehlerkultur
  einfach(
    'a2-tf-1',
    'te-feedback',
    prompt: 'Welche Aussage entspricht den Feedbackregeln?',
    choices: [
      ja(
        '„Mir ist aufgefallen, dass im Testprotokoll gestern drei Testfälle fehlten.“',
        'Konkret, zeitnah, beschreibend und als Ich-Botschaft.',
      ),
      nein(
        '„Du arbeitest immer schlampig.“',
        'Pauschal, bewertend und als Du-Botschaft.',
      ),
      nein(
        '„Irgendwas stimmt mit deinen Tests nicht.“',
        'Unkonkret: Der andere weiß nicht, was er ändern soll.',
      ),
      nein(
        '„Das hätte ich dir schon vor drei Monaten sagen sollen.“',
        'Nicht zeitnah.',
      ),
    ],
    explanation:
        'Gutes Feedback beschreibt ein konkretes Verhalten zeitnah aus der eigenen Wahrnehmung.',
  ),
  lueckentext(
    'a2-tf-2',
    'te-feedback',
    scenario:
        'Dein Ausbilder gibt dir nach einer Kundenpräsentation kritisches Feedback.',
    prompt:
        'Wähle für jede Lücke, wie du dich als Feedback-Nehmer richtig verhältst.',
    text:
        'Du hörst zu und lässt ihn {0}. Ist etwas unklar, {1} du. Du verzichtest darauf, dich zu {2}, und antwortest nicht mit Gegenkritik. Am Ende {3} du dich und entscheidest selbst, was du umsetzt.',
    luecken: [
      wahl('ausreden', [
        'warten',
        'raten',
      ], 'Nur so kommt die Rückmeldung vollständig an.'),
      wahl('fragst nach', [
        'widersprichst',
        'schweigst',
      ], 'Nachfragen hilft, das Feedback richtig zu verstehen.'),
      wahl('rechtfertigen', [
        'bedanken',
        'informieren',
      ], 'Rechtfertigungen blockieren das Gespräch.'),
      wahl('bedankst', [
        'beschwerst',
        'verteidigst',
      ], 'Feedback ist ein Geschenk, auch wenn es unbequem ist.'),
    ],
    explanation:
        'Wer Feedback annimmt, hört zu, fragt bei Unklarheit nach, rechtfertigt sich nicht und bedankt sich. Was er davon umsetzt, entscheidet er danach selbst.',
  ),
  tabelle(
    'a2-tf-3',
    'te-feedback',
    scenario:
        'Das Johari-Fenster ordnet Informationen über eine Person danach, wem sie bekannt sind.',
    prompt: 'Trage die vier Bereiche des Johari-Fensters ein.',
    zeilen: [
      ['Wissen', 'mir bekannt', 'mir unbekannt'],
      [
        'anderen bekannt',
        wahl('Öffentliche Person', [
          'Blinder Fleck',
          'Private Person',
          'Unbekanntes',
        ]),
        wahl('Blinder Fleck', [
          'Öffentliche Person',
          'Private Person',
          'Unbekanntes',
        ], 'Diesen Bereich verkleinert Feedback.'),
      ],
      [
        'anderen unbekannt',
        wahl(
          'Private Person',
          ['Öffentliche Person', 'Blinder Fleck', 'Unbekanntes'],
          'Diesen Bereich verkleinert, wer etwas von sich preisgibt.',
        ),
        wahl('Unbekanntes', [
          'Öffentliche Person',
          'Blinder Fleck',
          'Private Person',
        ]),
      ],
    ],
    explanation:
        'Öffentlich: mir und anderen bekannt. Blinder Fleck: nur anderen bekannt. Privat: nur mir bekannt. Unbekannt: niemandem bekannt. Feedback macht bewusst, wie man auf andere wirkt, und der blinde Fleck schrumpft.',
  ),

  reihenfolge(
    'a2-tf-4',
    'te-feedback',
    prompt:
        'Bringe die Teile eines Feedbacks nach der WWW-Methode in die richtige Reihenfolge.',
    items: [
      '„Mir ist aufgefallen, dass du diese Woche dreimal zu spät zum Daily kamst.“',
      '„Dadurch mussten wir den Stand noch einmal erklären.“',
      '„Ich wünsche mir, dass du kurz Bescheid gibst, wenn es später wird.“',
    ],
    explanation:
        'WWW steht für Wahrnehmung (was ich beobachtet habe), Wirkung (was das bei mir oder im Team bewirkt hat) und Wunsch (was ich mir künftig wünsche).',
    difficulty: 1,
  ),
  zuordnen(
    'a2-tf-5',
    'te-feedback',
    prompt:
        'In welchen Bereich des Johari-Fensters gehört die Beobachtung über Lara?',
    buckets: [
      'Öffentliche Person',
      'Blinder Fleck',
      'Private Person',
      'Unbekanntes',
    ],
    items: [
      zu(
        'Lara merkt nicht, dass sie andere in Meetings oft unterbricht. Den Kollegen fällt es auf.',
        1,
      ),
      zu('Alle im Team wissen, dass Lara sehr gut programmiert.', 0),
      zu(
        'Lara hat ein Talent zum Moderieren, das weder sie noch andere bisher bemerkt haben.',
        3,
      ),
      zu('Lara hat Angst vor Präsentationen, erzählt aber niemandem davon.', 2),
    ],
    explanation:
        'Öffentlich: mir und anderen bekannt. Blinder Fleck: nur anderen bekannt. Privat: nur mir bekannt. Unbekannt: niemandem bekannt. Feedback verkleinert den blinden Fleck, Selbstoffenbarung den privaten Bereich.',
  ),
  einfach(
    'a2-tf-6',
    'te-feedback',
    scenario:
        'Nach einem Kundentermin sagt deine Ausbilderin: „Du hast dem Kunden beim Erklären kaum in die Augen geschaut.“',
    prompt: 'Wie reagierst du richtig?',
    choices: [
      ja(
        '„Danke, das war mir nicht bewusst. An welcher Stelle ist dir das aufgefallen?“',
        'Bedanken und nachfragen. So nimmt man Feedback richtig an.',
      ),
      nein(
        '„Das stimmt nicht, ich habe ihn oft angesehen.“',
        'Rechtfertigen blockiert das Feedback.',
      ),
      nein(
        '„Du hast ja selbst die ganze Zeit aufs Handy geschaut.“',
        'Ein Gegenangriff macht aus dem Feedback einen Streit.',
      ),
      nein(
        'Schweigend nicken und schnell das Thema wechseln',
        'Ohne Nachfragen und Dank verpufft das Feedback.',
      ),
    ],
    explanation:
        'Feedback-Nehmer hören zu, rechtfertigen sich nicht, fragen bei Unklarheit nach und bedanken sich. Was sie davon umsetzen, entscheiden sie danach selbst.',
    difficulty: 1,
  ),
  mehrfach(
    'a2-tf-7',
    'te-feedback',
    prompt: 'Woran erkennt man eine gute Fehlerkultur im Unternehmen?',
    choices: [
      ja(
        'Fehler werden offen angesprochen.',
        'Nur bekannte Fehler lassen sich beheben.',
      ),
      ja(
        'Es wird nach Ursachen gefragt, nicht nach Schuldigen.',
        'Die Frage nach der Ursache führt zu Verbesserungen.',
      ),
      ja(
        'Erkenntnisse aus Fehlern werden festgehalten, z. B. als Lessons Learned.',
        'So lernt das ganze Unternehmen daraus.',
      ),
      nein(
        'Wer einen Fehler macht, wird vor dem Team ermahnt.',
        'Bloßstellen erzeugt Angst, Fehler werden dann verschwiegen.',
      ),
      nein(
        'Fehler werden still und schnell behoben, ohne darüber zu sprechen.',
        'Dann kann niemand daraus lernen, der Fehler wiederholt sich.',
      ),
    ],
    explanation:
        'In einer guten Fehlerkultur gelten Fehler als Lernchance. Offenheit und Ursachenanalyse statt Schuldzuweisung verhindern, dass kleine Fehler vertuscht werden und zu großen Problemen wachsen.',
    difficulty: 1,
  ),

  // ============================================== Konflikte und Vielfalt
  zuordnen(
    'a2-tk-1',
    'te-konflikte',
    prompt: 'Um welche Konfliktart handelt es sich?',
    buckets: [
      'Sachkonflikt',
      'Beziehungskonflikt',
      'Verteilungskonflikt',
      'Rollenkonflikt',
    ],
    items: [
      zu('Zwei Kollegen gehen sich seit einer Kränkung aus dem Weg.', 1),
      zu('Zwei Entwickler streiten, ob React oder Vue eingesetzt wird.', 0),
      zu(
        'Ein Mitarbeiter soll gleichzeitig im Projekt und in der Linie Vollzeit leisten.',
        3,
      ),
      zu('Zwei Teams beanspruchen dasselbe Testsystem.', 2),
    ],
    explanation:
        'Sachkonflikt: Methoden. Beziehungskonflikt: Personen. Verteilungskonflikt: knappe Ressourcen. Rollenkonflikt: widersprüchliche Erwartungen an eine Person.',
  ),
  paare(
    'a2-tk-2',
    'te-konflikte',
    scenario:
        'Zwei Teams streiten um denselben Testserver. Je nach Vorgehen endet der Konflikt unterschiedlich.',
    prompt: 'Ordne jedem Grundmuster der Konfliktlösung sein Ergebnis zu.',
    paare: [
      paar('Flucht', 'der Konflikt bleibt ungelöst'),
      paar('Durchsetzen', 'ein Gewinner, ein Verlierer'),
      paar('Delegation', 'ein Dritter entscheidet'),
      paar('Kompromiss', 'beide geben teilweise nach'),
      paar('Konsens', 'beide Interessen voll erfüllt'),
    ],
    explanation:
        'Am nachhaltigsten ist der Konsens: Beide erarbeiten eine neue Lösung, die ihre Interessen voll erfüllt. Beim Kompromiss bleibt oft Unzufriedenheit, beim Durchsetzen ein Verlierer, bei der Flucht der ganze Konflikt.',
  ),
  freitext(
    'a2-tk-3',
    'te-konflikte',
    scenario:
        'Bei der Auswahl neuer Auszubildender will ein Betrieb das Allgemeine Gleichbehandlungsgesetz (AGG) einhalten.',
    prompt:
        'Nenne vier Merkmale, wegen derer das AGG eine Benachteiligung verbietet.',
    kriterien: [
      krit(
        'Rasse oder ethnische Herkunft',
        stichwoerter: ['Herkunft', 'ethnisch', 'Rasse', 'Hautfarbe'],
      ),
      krit('Geschlecht', stichwoerter: ['Geschlecht']),
      krit(
        'Religion oder Weltanschauung',
        stichwoerter: ['Religion', 'Weltanschauung', 'Glaube'],
      ),
      krit(
        'Behinderung',
        stichwoerter: ['Behinderung', 'behindert', 'Handicap'],
      ),
      krit('Lebensalter', stichwoerter: ['Alter', 'Lebensalter']),
      krit(
        'Sexuelle Identität',
        stichwoerter: ['sexuell', 'Orientierung', 'Identität'],
      ),
    ],
    punkte: 4,
    loesung:
        'Das AGG verbietet Benachteiligungen wegen der ethnischen Herkunft, des Geschlechts, der Religion oder Weltanschauung, einer Behinderung, des Alters und der sexuellen Identität.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Das AGG schützt vor Diskriminierung, etwa bei Einstellung, Bezahlung und Beförderung. Die Mitbestimmung regelt dagegen das Betriebsverfassungsgesetz.',
  ),

  reihenfolge(
    'a2-tk-4',
    'te-konflikte',
    prompt:
        'Bringe diese Eskalationsstufen nach Glasl in die Reihenfolge, in der ein Konflikt eskaliert.',
    items: [
      'Verhärtung',
      'Debatte und Polemik',
      'Taten statt Worte',
      'Gesichtsverlust',
      'Gemeinsam in den Abgrund',
    ],
    explanation:
        'Glasl beschreibt neun Stufen: 1 Verhärtung, 2 Debatte, 3 Taten statt Worte, 4 Images und Koalitionen, 5 Gesichtsverlust, 6 Drohstrategien, 7 begrenzte Vernichtungsschläge, 8 Zersplitterung, 9 gemeinsam in den Abgrund.',
    difficulty: 3,
  ),
  einfach(
    'a2-tk-5',
    'te-konflikte',
    scenario:
        'Zwei Abteilungsleiter streiten seit Monaten um Budget. Inzwischen droht einer öffentlich damit, interne Fehler des anderen an die Geschäftsführung weiterzugeben, wenn dieser nicht nachgibt.',
    prompt: 'In welcher Hauptphase nach Glasl befindet sich der Konflikt?',
    choices: [
      ja(
        'win-lose: Eine Seite will gewinnen, die andere soll verlieren.',
        'Drohstrategien sind Stufe 6 - die letzte Stufe der win-lose-Phase.',
      ),
      nein(
        'win-win: Beide können noch gewinnen.',
        'Die win-win-Phase umfasst Stufe 1 bis 3, dort wird noch über die Sache gestritten.',
      ),
      nein(
        'lose-lose: Beide nehmen eigenen Schaden in Kauf.',
        'Das beginnt erst mit Stufe 7, wenn gezielt geschadet wird, auch um den Preis eigener Verluste.',
      ),
      nein(
        'Konsens: Beide erarbeiten eine gemeinsame Lösung.',
        'Konsens ist eine Lösungsform, keine Eskalationsphase.',
      ),
    ],
    explanation:
        'Stufe 4 bis 6 (Koalitionen, Gesichtsverlust, Drohstrategien) bilden die win-lose-Phase. Hier hilft meist nur noch ein neutraler Dritter, etwa eine Mediation.',
    difficulty: 3,
  ),
  zuordnen(
    'a2-tk-6',
    'te-konflikte',
    scenario: 'Zwei Teams streiten, wer den einzigen Testserver nutzen darf.',
    prompt: 'Welches Grundmuster der Konfliktlösung liegt vor?',
    buckets: ['Flucht', 'Delegation', 'Kompromiss', 'Konsens'],
    items: [
      zu(
        'Die Abteilungsleiterin soll entscheiden, welches Team den Server bekommt.',
        1,
      ),
      zu('Das Thema wird im Meeting immer wieder vertagt.', 0),
      zu(
        'Die Teams stellen fest, dass ein zweiter virtueller Server die Anforderungen beider vollständig erfüllt.',
        3,
      ),
      zu(
        'Jedes Team darf den Server an zweieinhalb Tagen pro Woche nutzen, obwohl beide ihn täglich bräuchten.',
        2,
      ),
    ],
    explanation:
        'Flucht vermeidet den Konflikt. Bei der Delegation entscheidet ein Dritter. Beim Kompromiss geben beide etwas nach. Beim Konsens entsteht eine neue Lösung, die beide Interessen voll erfüllt.',
  ),
  mehrfach(
    'a2-tk-7',
    'te-konflikte',
    prompt: 'Welche Merkmale kennzeichnen eine Mediation?',
    choices: [
      ja(
        'Ein neutraler Dritter strukturiert das Gespräch.',
        'Der Mediator leitet das Verfahren.',
      ),
      ja(
        'Die Beteiligten erarbeiten die Lösung selbst.',
        'Eigenverantwortung ist der Kern der Mediation.',
      ),
      ja(
        'Die Teilnahme ist freiwillig.',
        'Niemand kann zur Mediation gezwungen werden.',
      ),
      nein(
        'Der Mediator trifft am Ende eine verbindliche Entscheidung.',
        'Entscheidet ein Dritter, ist das Delegation oder ein Schiedsverfahren.',
      ),
      nein(
        'Der Mediator berät nur eine der beiden Parteien.',
        'Ein Mediator ist allparteilich und unterstützt alle Seiten gleichermaßen.',
      ),
    ],
    explanation:
        'Mediation ist freiwillig, vertraulich und allparteilich. Der Mediator führt durch das Gespräch, die Lösung finden die Parteien selbst.',
  ),

  // ====================================================== Das Harvard-Konzept
  lueckentext(
    'a2-vh-1',
    've-harvard',
    scenario:
        'Vor einer Vertragsverhandlung wiederholst du die vier Prinzipien des Harvard-Konzepts.',
    prompt: 'Setze die passenden Begriffe ein.',
    text:
        'Das Harvard-Konzept hat vier Prinzipien: {0} und Probleme getrennt behandeln, {1} statt Positionen in den Mittelpunkt stellen, {2} zum beiderseitigen Vorteil entwickeln und neutrale {3} verwenden.',
    luecken: [
      wort(['Menschen'], 'Erstes Prinzip.'),
      wort(['Interessen'], 'Zweites Prinzip.'),
      wort(['Optionen'], 'Drittes Prinzip.'),
      wort(['Kriterien'], 'Viertes Prinzip.'),
    ],
    wortbank: ['Forderungen', 'Drohungen', 'Preise'],
    explanation:
        'Die vier Prinzipien: Menschen und Probleme trennen, Interessen statt Positionen, Optionen zum beiderseitigen Vorteil, neutrale Kriterien. Hoch einzusteigen oder die Position nie zu ändern ist dagegen Feilschen um Positionen.',
  ),
  einfach(
    'a2-vh-2',
    've-harvard',
    scenario:
        'Ein Kunde fordert: „Die Software muss bis Freitag komplett fertig sein.“ Auf Nachfrage erfährt der Projektleiter, dass am Montag eine Messe beginnt, auf der die Software gezeigt werden soll.',
    prompt: 'Wie geht man nach dem Harvard-Konzept vor?',
    choices: [
      ja(
        'Eine vorführbare Demo-Version bis Freitag vorschlagen, die fertige Software folgt später.',
        'Erfüllt das eigentliche Interesse (Präsentation auf der Messe) und entlastet den Termin.',
      ),
      nein(
        'Auf der ursprünglichen Planung bestehen.',
        'Ignoriert das Interesse des Kunden.',
      ),
      nein(
        'Zusagen, obwohl es nicht zu schaffen ist.',
        'Löst das Problem nicht, sondern verschiebt es.',
      ),
      nein(
        'Den Preis erhöhen, damit der Kunde zurückweicht.',
        'Druck statt Lösung.',
      ),
    ],
    explanation:
        'Hinter der Position („bis Freitag fertig“) steht ein Interesse („Messe am Montag“). Wer das Interesse bedient, findet oft eine bessere Lösung für beide.',
  ),
  freitext(
    'a2-vh-3',
    've-harvard',
    scenario:
        'Ein Systemhaus verhandelt mit einem Lieferanten über 50 Monitore. Ein zweiter Lieferant hat bereits ein verbindliches Angebot abgegeben.',
    prompt:
        'Erläutere, was die BATNA ist und wozu sie in dieser Verhandlung dient.',
    kriterien: [
      krit(
        'Die BATNA ist die beste Alternative, falls keine Einigung zustande kommt; hier das Angebot des zweiten Lieferanten.',
        stichwoerter: [
          'Alternative',
          'zweiter Lieferant',
          'anderes Angebot',
          'ohne Einigung',
        ],
      ),
      krit(
        'Sie ist die Messlatte: Ein Verhandlungsergebnis lohnt sich nur, wenn es besser ist als die BATNA.',
        stichwoerter: [
          'Messlatte',
          'Untergrenze',
          'besser als',
          'Grenze',
          'Maßstab',
          'schlechter als',
        ],
      ),
    ],
    loesung:
        'Die BATNA (Best Alternative to a Negotiated Agreement) ist die beste Alternative für den Fall, dass die Verhandlung scheitert; hier das verbindliche Angebot des zweiten Lieferanten. Sie dient als Messlatte: Das Systemhaus stimmt nur einem Ergebnis zu, das besser ist als diese Alternative.',
    explanation:
        '1 Punkt für die Erklärung (beste Alternative ohne Einigung), 1 Punkt für den Zweck (Messlatte bzw. Untergrenze). Wer seine BATNA kennt, lässt sich nicht zu einer schlechten Einigung drängen.',
  ),

  zuordnen(
    'a2-vh-4',
    've-harvard',
    scenario:
        'Ein Projektleiter verhandelt mit einem verärgerten Kunden über einen verschobenen Liefertermin.',
    prompt: 'Welches Prinzip des Harvard-Konzepts wendet er an?',
    buckets: [
      'Menschen und Probleme trennen',
      'Interessen statt Positionen',
      'Optionen entwickeln',
      'Neutrale Kriterien',
    ],
    items: [
      zu('„Wozu genau brauchen Sie das System schon im März?“', 1),
      zu(
        '„Ich verstehe Ihren Ärger. Lassen Sie uns gemeinsam auf den Zeitplan schauen.“',
        0,
      ),
      zu(
        '„Orientieren wir uns an den Reaktionszeiten, die im SLA vereinbart sind.“',
        3,
      ),
      zu(
        '„Lassen Sie uns drei Varianten durchrechnen, bevor wir uns festlegen.“',
        2,
      ),
    ],
    explanation:
        'Gefühle anerkennen und die Sache gemeinsam angehen trennt Mensch und Problem. Die Warum-Frage deckt Interessen auf. Mehrere Varianten sind Optionen. Das SLA ist ein neutraler Maßstab.',
  ),
  einfach(
    'a2-vh-5',
    've-harvard',
    scenario:
        'Eine Kundin fordert: „Wir brauchen 20 zusätzliche Softwarelizenzen, und zwar sofort.“ Auf Nachfrage erklärt sie, dass nächste Woche zehn Praktikanten für vier Wochen anfangen.',
    prompt: 'Was ist hier das Interesse der Kundin?',
    choices: [
      ja(
        'Die Praktikanten sollen ab nächster Woche arbeiten können.',
        'Das ist das Warum hinter der Forderung.',
      ),
      nein(
        '20 zusätzliche Lizenzen',
        'Das ist die Position, also die konkrete Forderung.',
      ),
      nein('Ein möglichst niedriger Preis', 'Davon ist keine Rede.'),
      nein('Eine sofortige Lieferung', 'Auch das ist Teil der Position.'),
    ],
    explanation:
        'Die Position ist „20 Lizenzen sofort“, das Interesse „die Praktikanten sollen arbeiten können“. Wer das Interesse kennt, findet Optionen, etwa zehn befristete Lizenzen für vier Wochen.',
  ),
  einfach(
    'a2-vh-6',
    've-harvard',
    scenario:
        'Ein Systemhaus verhandelt mit Lieferant A über 50 Monitore. Lieferant B hat bereits verbindlich 180 € je Monitor mit zwei Jahren Garantie angeboten. A verlangt 190 € je Monitor, gibt aber drei Jahre Vor-Ort-Garantie.',
    prompt: 'Welche Aussage zur BATNA des Systemhauses ist richtig?',
    choices: [
      ja(
        'Die BATNA ist das Angebot von B: A muss insgesamt, also mit Preis und Garantie, besser sein, damit sich die Einigung lohnt.',
        'Die BATNA ist die beste verfügbare Alternative, falls die Verhandlung mit A scheitert.',
      ),
      nein(
        'Die BATNA ist der Preis von 190 €.',
        'Das ist das Angebot in der laufenden Verhandlung, keine Alternative.',
      ),
      nein(
        'Die BATNA ist immer der niedrigste Preis am Markt.',
        'Sie ist die beste tatsächlich verfügbare eigene Alternative, nicht irgendein Marktpreis.',
      ),
      nein(
        'Eine BATNA hat nur der Lieferant, nicht der Käufer.',
        'Beide Seiten haben eine BATNA; hier ist es für das Systemhaus Lieferant B.',
      ),
    ],
    explanation:
        'BATNA = Best Alternative to a Negotiated Agreement. Sie ist die Messlatte: Ein Ergebnis mit A lohnt sich nur, wenn es insgesamt besser ist als das sichere Angebot von B.',
    difficulty: 3,
  ),
  zuordnen(
    'a2-vh-7',
    've-harvard',
    scenario:
        'In einer Preisverhandlung zeigen die Beteiligten unterschiedliche Verhaltensweisen.',
    prompt: 'Zu welchem Verhandlungsstil gehört das Verhalten?',
    buckets: ['harter Stil', 'weicher Stil', 'sachgerecht (Harvard)'],
    items: [
      zu(
        'Mit einer stark überhöhten Forderung einsteigen',
        0,
        'Hartes Feilschen um Positionen.',
      ),
      zu(
        'Nach den Gründen hinter einer Forderung fragen',
        2,
        'Interessen statt Positionen.',
      ),
      zu(
        'Um des lieben Friedens willen sofort nachgeben',
        1,
        'Die Beziehung ist wichtiger als das Ergebnis.',
      ),
      zu(
        'Objektive Maßstäbe wie Marktpreise heranziehen',
        2,
        'Neutrale Beurteilungskriterien.',
      ),
      zu('Mit Abbruch drohen, um Druck aufzubauen', 0, 'Druck statt Lösung.'),
      zu(
        'Mehrere Lösungsvarianten entwickeln, bevor entschieden wird',
        2,
        'Optionen zum beiderseitigen Vorteil.',
      ),
    ],
    explanation:
        'Sachgerecht verhandeln heißt: hart in der Sache, weich zu den Menschen. Weder Druck (harter Stil) noch Nachgeben (weicher Stil), sondern Interessen, Optionen und neutrale Kriterien.',
    difficulty: 1,
  ),

  // ============================================ Argumentieren und Einwände
  zuordnen(
    'a2-ve-1',
    've-einwaende',
    prompt: 'Welche Methode der Einwandbehandlung wird angewendet?',
    buckets: ['Ja-aber', 'Bumerang', 'Rückfrage', 'Referenz'],
    items: [
      zu(
        '„Gerade weil Ihr Team klein ist, entlastet das System es spürbar.“',
        1,
      ),
      zu(
        '„Ja, der Preis ist höher. Dafür ist die Wartung drei Jahre inklusive.“',
        0,
      ),
      zu('„Ein Betrieb Ihrer Größe nutzt es seit zwei Jahren erfolgreich.“', 3),
      zu('„Was genau erscheint Ihnen zu kompliziert?“', 2),
    ],
    explanation:
        'Ja-aber: zustimmen und ergänzen. Bumerang: Einwand wird zum Argument. Rückfrage: Hintergrund klären. Referenz: auf zufriedene Kunden verweisen.',
  ),
  reihenfolge(
    'a2-ve-2',
    've-einwaende',
    scenario:
        'Du empfiehlst einem Kunden Rechner mit SSD und baust dein Argument als Nutzenargumentation auf.',
    prompt:
        'Bringe die Aussagen in die Reihenfolge Merkmal - Vorteil - Nutzen.',
    items: [
      '„Der Rechner hat eine SSD mit 1 TB.“',
      '„Dadurch startet er in wenigen Sekunden.“',
      '„Ihre Mitarbeitenden verlieren morgens keine Zeit mehr mit Warten.“',
    ],
    explanation:
        'Kunden kaufen Nutzen, nicht Technik. Überzeugend ist die Kette Merkmal (SSD) - Vorteil (startet schnell) - Nutzen (keine Wartezeit für die Mitarbeitenden).',
  ),
  einfach(
    'a2-ve-3',
    've-einwaende',
    scenario:
        'Am Ende einer Präsentation sagt der Kunde: „Ich muss noch mal drüber schlafen.“ Vorher war er begeistert.',
    prompt: 'Wie reagiert man am besten?',
    choices: [
      ja(
        'Mit einer Rückfrage den eigentlichen Grund herausfinden',
        'Es könnte ein Vorwand sein. Die Rückfrage deckt den wahren Grund auf.',
      ),
      nein(
        'Sofort einen Rabatt anbieten',
        'Setzt voraus, dass es am Preis liegt, vielleicht zu Unrecht.',
      ),
      nein(
        'Das Gespräch beenden',
        'Verschenkt die Chance, einen echten Einwand zu klären.',
      ),
      nein('Dem Kunden widersprechen', 'Erzeugt Abwehr.'),
    ],
    explanation:
        'Unkonkrete Aussagen nach vorheriger Zustimmung sind oft Vorwände. Eine offene Rückfrage bringt den echten Einwand ans Licht.',
  ),

  zuordnen(
    'a2-ve-4',
    've-einwaende',
    scenario:
        'Du stellst einem Außendienstleiter ein leichtes Business-Notebook vor.',
    prompt: 'Ist die Aussage ein Merkmal, ein Vorteil oder ein Nutzen?',
    buckets: ['Merkmal', 'Vorteil', 'Nutzen'],
    items: [
      zu('Der Akku hält bis zu 14 Stunden.', 0),
      zu('Das Notebook wiegt 1,1 kg.', 0),
      zu('Sie können einen ganzen Messetag ohne Steckdose präsentieren.', 2),
      zu(
        'Ihre Außendienstler kommen entspannt beim Kunden an, ohne schwer zu schleppen.',
        2,
      ),
      zu('Man braucht unterwegs kein Ladegerät.', 1),
      zu('Es lässt sich leicht überallhin mitnehmen.', 1),
    ],
    explanation:
        'Das Merkmal ist eine Eigenschaft des Produkts, der Vorteil das, was es dadurch besser kann, der Nutzen der konkrete Gewinn für genau diesen Kunden, oft als Sie-Formulierung.',
  ),
  einfach(
    'a2-ve-5',
    've-einwaende',
    scenario:
        'Ein Kunde sagt: „Ihr System ist doch viel zu umfangreich für unser kleines Team.“ Die Beraterin antwortet: „Gerade für kleine Teams ist es ideal, weil es viele Routineaufgaben automatisch erledigt.“',
    prompt: 'Welche Methode der Einwandbehandlung wendet sie an?',
    choices: [
      ja(
        'Bumerang-Methode',
        'Der Einwand „kleines Team“ wird selbst zum Argument für das System.',
      ),
      nein(
        'Ja-aber-Methode',
        'Dann hätte sie zuerst zugestimmt und ein anderes Argument danebengestellt.',
      ),
      nein('Referenzmethode', 'Sie verweist auf keinen anderen Kunden.'),
      nein(
        'Rückfrage-Methode',
        'Sie stellt keine Frage, sondern antwortet mit einem Argument.',
      ),
    ],
    explanation:
        'Bei der Bumerang-Methode wird der Grund gegen den Kauf in einen Grund dafür verwandelt: „Gerade weil ...“. Bei Ja-aber bleibt der Einwand stehen und wird durch ein anderes Argument ausgeglichen.',
  ),
  reihenfolge(
    'a2-ve-6',
    've-einwaende',
    prompt:
        'Bringe die Schritte der Einwandbehandlung in die richtige Reihenfolge.',
    items: [
      'Zuhören und ausreden lassen',
      'Verständnis zeigen',
      'Einwand mit einer Rückfrage klären',
      'Passende Methode anwenden',
      'Zustimmung des Kunden sichern',
    ],
    explanation:
        'Erst zuhören und Verständnis zeigen, dann klären, ob der Einwand echt ist und was genau dahintersteckt. Erst danach antworten und am Ende prüfen, ob der Einwand ausgeräumt ist.',
    difficulty: 1,
  ),
  mehrfach(
    'a2-ve-7',
    've-einwaende',
    scenario:
        'Eine Kundin sagt zu deinem Angebot für ein Managed-Backup: „Das ist mir zu teuer.“',
    prompt: 'Welche Reaktionen sind sinnvoll?',
    choices: [
      ja(
        '„Zu teuer im Vergleich wozu?“',
        'Eine Rückfrage klärt, woran die Kundin den Preis misst.',
      ),
      ja(
        '„Ja, der Preis ist höher als eine USB-Festplatte. Dafür läuft die Sicherung automatisch und außer Haus.“',
        'Ja-aber: zustimmen und ein Gegenargument ergänzen.',
      ),
      ja(
        '„Auf den Tag gerechnet sind das knapp 3 € - weniger, als ein verlorener Auftrag kostet.“',
        'Den Preis auf kleine Einheiten umrechnen und mit dem Nutzen verbinden.',
      ),
      nein(
        '„Da irren Sie sich, das ist ein fairer Preis.“',
        'Direkter Widerspruch erzeugt Abwehr.',
      ),
      nein(
        'Sofort 20 % Rabatt anbieten, ohne nachzufragen',
        'Ohne Rückfrage weißt du nicht, ob es wirklich am Preis liegt, und verschenkst Marge.',
      ),
    ],
    explanation:
        'Bei Preiseinwänden erst nachfragen, dann mit Ja-aber, Nutzen oder Preisumrechnung antworten. Widersprechen und vorschnelle Rabatte sind typische Fehler.',
  ),

  // ================================================== Präsentationen aufbauen
  zuordnen(
    'a2-pp-1',
    'pr-praesentation',
    prompt: 'Welche Diagrammart eignet sich am besten?',
    buckets: ['Balkendiagramm', 'Liniendiagramm', 'Kreisdiagramm'],
    items: [
      zu('Kosten dreier Angebote vergleichen', 0),
      zu('Entwicklung der Ticketzahlen über zwölf Monate', 1),
      zu('Anteil der Betriebssysteme im Unternehmen', 2),
      zu('Umsatz je Abteilung gegenüberstellen', 0),
      zu('Verlauf der Serverauslastung über einen Tag', 1),
    ],
    explanation:
        'Balken vergleichen, Linien zeigen Entwicklungen, Kreise zeigen Anteile an einem Ganzen.',
  ),
  markieren(
    'a2-pp-2',
    'pr-praesentation',
    scenario:
        'Ein Kollege zeigt dir den Entwurf seiner Präsentationsfolien für einen Kundentermin.',
    prompt:
        'Markiere alle Eigenschaften, die gegen die Regeln guter Foliengestaltung verstoßen.',
    zeilen: [
      ja(
        'Auf den Folien stehen ganze Absätze, die er vorlesen will.',
        'Dann lesen die Zuhörer, statt zuzuhören.',
      ),
      nein(
        'Jede Folie hat genau eine Kernaussage.',
        'Hält die Aufmerksamkeit auf dem Wesentlichen.',
      ),
      ja(
        'Jede Folie hat ein anderes Design.',
        'Wirkt unruhig und unprofessionell.',
      ),
      nein(
        'Zahlen werden als Diagramm gezeigt.',
        'Grafiken erfasst man schneller als Zahlenkolonnen.',
      ),
      ja(
        'Die Schrift ist klein, damit alles auf eine Folie passt.',
        'Folien brauchen wenig Text in großer Schrift.',
      ),
      nein(
        'Schrift und Farben sind einheitlich.',
        'Ein einheitliches Erscheinungsbild wirkt ruhig.',
      ),
    ],
    explanation:
        'Gute Folien sind knapp, einheitlich und visuell: eine Kernaussage pro Folie, wenig Text in großer Schrift, Diagramme statt Zahlenkolonnen. Der Vortrag liefert die Erklärung.',
  ),
  lueckentext(
    'a2-pp-3',
    'pr-praesentation',
    scenario: 'Du bereitest eine Präsentation für einen Kundentermin vor.',
    prompt: 'Wähle für jede Lücke den passenden Begriff.',
    text:
        'Am Anfang klärst du {0} der Präsentation. Danach sammelst du Inhalte und {1} sie. Die Folien gestaltest du erst, wenn {2} steht. Zum Schluss {3} du den Vortrag.',
    luecken: [
      wahl(
        'Ziel und Zielgruppe',
        ['Schriftart und Farben', 'die Foliennummern'],
        'Ohne Ziel und Zielgruppe lassen sich Inhalte nicht auswählen.',
      ),
      wahl('gliederst', [
        'druckst',
        'animierst',
      ], 'Erst ordnen, dann gestalten.'),
      wahl('die Gliederung', [
        'das Design',
        'die Kleiderordnung',
      ], 'Das Design ist der letzte inhaltliche Schritt.'),
      wahl('übst', ['kürzt', 'verschickst'], 'Geübt wird, wenn alles steht.'),
    ],
    explanation:
        'Erst klären, was die Zuhörer danach wissen oder tun sollen und was sie mitbringen. Dann Inhalte sammeln, gliedern, Folien gestalten und zum Schluss üben.',
  ),

  reihenfolge(
    'a2-pp-4',
    'pr-praesentation',
    scenario:
        'Du sollst dem Vorstand eines Kunden ein neues Sicherheitskonzept präsentieren.',
    prompt:
        'Bringe die Schritte der Vorbereitung in eine sinnvolle Reihenfolge.',
    items: [
      'Ziel und Zielgruppe klären',
      'Inhalte sammeln und auswählen',
      'Inhalte gliedern',
      'Folien und Medien gestalten',
      'Vortrag üben',
    ],
    explanation:
        'Ohne Ziel und Zielgruppe lassen sich Inhalte nicht sinnvoll auswählen. Erst wenn Inhalt und Gliederung stehen, werden Folien gestaltet; geübt wird zum Schluss.',
    difficulty: 1,
  ),
  zuordnen(
    'a2-pp-5',
    'pr-praesentation',
    prompt: 'Welches Medium passt am besten zur Situation?',
    buckets: ['Flipchart', 'Beamer', 'Handout', 'Pinnwand'],
    items: [
      zu(
        'Die Teilnehmenden sollen Details nach dem Termin nachlesen können.',
        2,
      ),
      zu(
        'Ein Video und Screenshots der neuen Software sollen gezeigt werden.',
        1,
      ),
      zu(
        'In einem Workshop werden Ideen auf Karten gesammelt und gruppiert.',
        3,
      ),
      zu(
        'In einer kleinen Runde wird eine Agenda vorbereitet, die den ganzen Tag sichtbar hängen bleibt.',
        0,
      ),
    ],
    explanation:
        'Handouts dienen zum Nachlesen, der Beamer zeigt Bilder und Videos, an der Pinnwand werden Karten gesammelt und sortiert (Metaplan), ein Flipchart-Blatt bleibt für kleine Gruppen sichtbar hängen.',
  ),
  einfach(
    'a2-pp-6',
    'pr-praesentation',
    scenario:
        'In einer Präsentation zeigt ein Balkendiagramm die Kosten zweier Angebote: 7.988 € und 8.075 €. Die Achse beginnt bei 7.900 €.',
    prompt: 'Was ist an diesem Diagramm problematisch?',
    choices: [
      ja(
        'Der Unterschied von 87 € wirkt, als wäre ein Angebot doppelt so teuer.',
        'Ab 7.900 € gemessen ist ein Balken 88 €, der andere 175 € lang, ein verzerrter Eindruck.',
      ),
      nein(
        'Balkendiagramme sind für Kostenvergleiche ungeeignet.',
        'Im Gegenteil: Balken sind die richtige Wahl für Vergleiche.',
      ),
      nein(
        'Es müsste ein Kreisdiagramm sein.',
        'Die Beträge sind keine Anteile eines Ganzen.',
      ),
      nein(
        'Die Achse müsste bei 8.075 € enden.',
        'Das Ende der Achse ist nicht das Problem, sondern ihr Anfang.',
      ),
    ],
    explanation:
        'Eine Achse, die nicht bei 0 beginnt, übertreibt Unterschiede. Ehrliche Diagramme haben beschriftete Achsen ab 0, eine Einheit und eine Quelle.',
  ),
  mehrfach(
    'a2-pp-7',
    'pr-praesentation',
    prompt: 'Welche Verhaltensweisen wirken beim Präsentieren souverän?',
    choices: [
      ja(
        'Blickkontakt mit dem ganzen Publikum halten',
        'Bindet alle Zuhörer ein.',
      ),
      ja('Frei sprechen mit Stichwortkarten', 'Wirkt kompetent und lebendig.'),
      ja(
        'Bewusst Pausen setzen',
        'Gibt Zeit zum Nachdenken und betont Kernaussagen.',
      ),
      nein(
        'Mit dem Rücken zum Publikum von der Leinwand ablesen',
        'Verliert den Kontakt zu den Zuhörern.',
      ),
      nein(
        'Möglichst schnell sprechen, um Zeit zu sparen',
        'Überfordert das Publikum und wirkt nervös.',
      ),
    ],
    explanation:
        'Souverän wirkt, wer Blickkontakt hält, frei spricht, laut und eher langsam redet und Pausen setzt. Folien vorzulesen oder zu hetzen kostet Aufmerksamkeit.',
    difficulty: 1,
  ),

  // ============================================= Informationsquellen bewerten
  zuordnen(
    'a2-pq-1',
    'pr-quellen',
    prompt: 'Primär- oder Sekundärquelle?',
    buckets: ['Primärquelle', 'Sekundärquelle'],
    items: [
      zu('Offizielles Datenblatt des Herstellers', 0),
      zu('Beitrag in einem IT-Forum', 1),
      zu('Text der DSGVO', 0),
      zu('Zusammenfassung der DSGVO in einem Blog', 1),
      zu('Eigene Messung der Übertragungsrate', 0),
    ],
    explanation:
        'Primärquellen liefern Originalinformation, Sekundärquellen bereiten sie auf und können dabei Fehler einbauen.',
  ),
  freitext(
    'a2-pq-2',
    'pr-quellen',
    scenario:
        'Für ein Kundenangebot recherchierst du im Internet nach Informationen zu einem neuen WLAN-Standard.',
    prompt:
        'Nenne drei Kriterien, nach denen du die Qualität einer Informationsquelle bewertest.',
    kriterien: [
      krit(
        'Aktualität: Gerade in der IT veralten Informationen schnell',
        stichwoerter: ['aktuell', 'Aktualität', 'Datum', 'veraltet'],
      ),
      krit(
        'Urheber und seine Kompetenz',
        stichwoerter: [
          'Urheber',
          'Autor',
          'Herausgeber',
          'Kompetenz',
          'Verfasser',
        ],
      ),
      krit(
        'Objektivität: Verfolgt der Autor ein Verkaufsinteresse?',
        stichwoerter: [
          'objektiv',
          'neutral',
          'Verkaufsinteresse',
          'Werbung',
          'unabhängig',
        ],
      ),
      krit(
        'Nachprüfbarkeit: Sind die Aussagen belegt?',
        stichwoerter: [
          'nachprüfbar',
          'Belege',
          'Quellenangabe',
          'überprüfbar',
          'nachvollziehbar',
        ],
      ),
      krit(
        'Relevanz für die eigene Fragestellung',
        stichwoerter: ['Relevanz', 'relevant', 'passend'],
      ),
    ],
    punkte: 3,
    loesung:
        'Ich prüfe die Aktualität (Datum der Veröffentlichung), den Urheber und seine Kompetenz sowie die Objektivität, also ob der Autor ein Verkaufsinteresse hat. Weitere Kriterien sind Nachprüfbarkeit und Relevanz.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Aktualität, Urheber, Objektivität, Nachprüfbarkeit und Relevanz entscheiden über die Qualität einer Quelle, nicht Länge oder Zahl der Bilder.',
  ),
  einfach(
    'a2-pq-3',
    'pr-quellen',
    prompt:
        'Wie geht man mit einer Antwort eines KI-Chatbots für eine Präsentation um?',
    choices: [
      ja(
        'Wichtige Aussagen an einer Primärquelle überprüfen',
        'KI-Antworten können plausibel klingen und trotzdem falsch sein.',
      ),
      nein(
        'Direkt übernehmen, weil KI keine Fehler macht',
        'KI-Modelle können Fakten erfinden.',
      ),
      nein('Als Primärquelle zitieren', 'Ein Chatbot ist keine Primärquelle.'),
      nein(
        'Gar nicht verwenden, weil KI verboten ist',
        'Der Einsatz ist erlaubt, die Prüfung notwendig.',
      ),
    ],
    explanation:
        'KI kann bei der Recherche helfen, ersetzt aber keine Quelle. Aussagen müssen belegt werden.',
  ),

  einfach(
    'a2-pq-4',
    'pr-quellen',
    scenario:
        'Für eine Präsentation, mit der dein Betrieb einen Neukunden gewinnen will, möchtest du ein Foto aus der Bildersuche verwenden. Es steht unter der Lizenz CC BY-NC.',
    prompt: 'Darfst du das Foto verwenden?',
    choices: [
      ja(
        'Nein: NC schließt kommerzielle Nutzung aus, und die Präsentation dient geschäftlichen Zwecken.',
        'Eine Kundenakquise ist eine geschäftliche Nutzung.',
      ),
      nein(
        'Ja, mit Namensnennung ist jede Nutzung erlaubt.',
        'BY verlangt die Namensnennung, NC verbietet aber zusätzlich die kommerzielle Nutzung.',
      ),
      nein(
        'Ja: Bilder aus der Suchmaschine sind frei verwendbar.',
        'Auffindbar heißt nicht frei nutzbar. Die Lizenz entscheidet.',
      ),
      nein(
        'Ja, wenn du das Bild vorher bearbeitest.',
        'Eine Bearbeitung ändert nichts am NC-Baustein.',
      ),
    ],
    explanation:
        'Creative-Commons-Bausteine: BY = Namensnennung, SA = gleiche Bedingungen, NC = nicht kommerziell, ND = keine Bearbeitung. Für eine geschäftliche Präsentation scheidet ein NC-Bild aus.',
  ),
  mehrfach(
    'a2-pq-5',
    'pr-quellen',
    prompt:
        'Unter welchen Bedingungen darfst du nach dem Zitatrecht einen Absatz aus einem Fachartikel in deine Präsentation übernehmen?',
    choices: [
      ja(
        'Die Quelle wird deutlich angegeben.',
        'Ohne Quellenangabe ist es kein erlaubtes Zitat.',
      ),
      ja(
        'Das Zitat belegt oder erläutert eine eigene Aussage.',
        'Es braucht einen Zitatzweck.',
      ),
      ja(
        'Der Umfang ist auf das Nötige beschränkt.',
        'Nur so viel wie für den Zweck erforderlich.',
      ),
      nein(
        'Der Text wird leicht umformuliert, damit er nicht auffällt.',
        'Fremde Gedanken ohne Kennzeichnung sind ein Plagiat, auch umformuliert.',
      ),
      nein(
        'Der Artikel ist älter als ein Jahr.',
        'Das Alter spielt keine Rolle. Das Urheberrecht gilt bis 70 Jahre nach dem Tod des Urhebers.',
      ),
    ],
    explanation:
        'Das Zitatrecht (§ 51 UrhG) erlaubt Zitate ohne Erlaubnis, wenn ein Zitatzweck besteht, der Umfang angemessen ist, das Zitat unverändert bleibt und die Quelle genannt wird.',
  ),
  zuordnen(
    'a2-pq-6',
    'pr-quellen',
    prompt: 'Welche Wirkung hat die Sucheingabe?',
    buckets: [
      'exakte Wortfolge',
      'Begriff ausschließen',
      'nur eine Website',
      'nur ein Dateityp',
    ],
    items: [
      zu('switch -nintendo', 1),
      zu('"Fehlercode 0x80070005"', 0),
      zu('filetype:pdf handbuch', 3),
      zu('site:bsi.bund.de ransomware', 2),
    ],
    explanation:
        'Anführungszeichen suchen die genaue Wortfolge, ein Minus schließt Begriffe aus, site: beschränkt auf eine Domain, filetype: auf einen Dateityp.',
    difficulty: 1,
  ),
  einfach(
    'a2-pq-7',
    'pr-quellen',
    prompt:
        'Welche Angaben gehören bei einer Internetquelle zusätzlich zu Autor, Jahr und Titel in die Quellenangabe?',
    choices: [
      ja(
        'URL und Abrufdatum',
        'Webseiten ändern sich. Das Datum zeigt, welcher Stand gemeint ist.',
      ),
      nein('ISBN und Auflage', 'Das sind Angaben für Bücher.'),
      nein(
        'Nur der Name der Suchmaschine',
        'Die Suchmaschine ist nicht die Quelle.',
      ),
      nein(
        'Die IP-Adresse des Servers',
        'Sie ist für die Quellenangabe nicht üblich und nicht nötig.',
      ),
    ],
    explanation:
        'Eine Internetquelle wird angegeben mit Autor, Jahr, Titel, Website, URL und Abrufdatum. So lässt sich die Information wiederfinden, auch wenn sich die Seite später ändert.',
    difficulty: 1,
  ),

  // ==================================================== Anfrage, Angebot, Vergleich
  lueckentext(
    'a2-pa-1',
    'pr-angebot',
    scenario:
        'Ein Kunde bittet ein Systemhaus per E-Mail um Preise für zehn Notebooks. Das Systemhaus schickt ein Angebot ohne Einschränkung, der Kunde bestellt drei Tage später unverändert.',
    prompt: 'Wähle für jede Lücke die richtige Ergänzung.',
    text:
        'Die Anfrage des Kunden ist rechtlich {0}. Das Angebot ist für das Systemhaus {1}. Mit der rechtzeitigen, unveränderten Bestellung {2}. Der Zusatz „freibleibend“ im Angebot wäre eine {3}.',
    luecken: [
      wahl('unverbindlich', [
        'verbindlich',
        'unwirksam',
      ], 'Wer anfragt, muss nicht kaufen.'),
      wahl(
        'verbindlich',
        ['unverbindlich', 'nur eine Werbung'],
        'Ein Angebot ist ein Antrag. Der Anbieter ist daran gebunden.',
      ),
      wahl('kommt der Vertrag zustande', [
        'entsteht ein neues Angebot',
        'endet die Bindung',
      ], 'Antrag und Annahme stimmen überein.'),
      wahl('Freizeichnungsklausel', [
        'Auftragsbestätigung',
        'Mängelrüge',
      ], 'Sie schränkt die Bindung des Angebots ein.'),
    ],
    explanation:
        'Anfrage: unverbindlich. Angebot: verbindlich, sofern es nicht durch eine Freizeichnungsklausel eingeschränkt ist. Wird es rechtzeitig und unverändert angenommen, kommt der Vertrag zustande.',
  ),
  einfach(
    'a2-pa-2',
    'pr-angebot',
    scenario:
        'Ein Händler schickt per E-Mail ein Angebot ohne Frist. Der Kunde antwortet erst nach sechs Wochen mit einer Bestellung.',
    prompt: 'Ist der Händler noch gebunden?',
    choices: [
      ja(
        'Nein, unter Abwesenden bindet ein Angebot nur so lange, wie unter normalen Umständen mit einer Antwort zu rechnen ist.',
        'Sechs Wochen sind deutlich zu lang. Die Bestellung ist ein neues Angebot des Kunden.',
      ),
      nein(
        'Ja: Angebote gelten unbegrenzt.',
        'Ohne Frist gilt die übliche Antwortzeit.',
      ),
      nein(
        'Ja: E-Mail-Angebote gelten immer drei Monate.',
        'Eine solche Regel gibt es nicht.',
      ),
      nein(
        'Nein: E-Mail-Angebote sind nie verbindlich.',
        'Auch E-Mail-Angebote binden.',
      ),
    ],
    explanation:
        'Ohne Frist bindet ein Angebot unter Abwesenden nur für die übliche Antwortzeit. Eine verspätete Annahme gilt als neues Angebot.',
  ),
  freitext(
    'a2-pa-3',
    'pr-angebot',
    scenario:
        'Du erstellst für einen Kunden ein Angebot über die Einrichtung von fünf Arbeitsplätzen.',
    prompt: 'Nenne vier Angaben, die in ein vollständiges Angebot gehören.',
    kriterien: [
      krit(
        'Art, Güte und Menge der Leistung',
        stichwoerter: [
          'Menge',
          'Güte',
          'Leistungsbeschreibung',
          'Beschaffenheit',
          'Artikel',
        ],
      ),
      krit('Preis und Preisnachlässe', stichwoerter: ['Preis', 'Rabatt']),
      krit(
        'Lieferzeit',
        stichwoerter: ['Lieferzeit', 'Liefertermin', 'Lieferdatum'],
      ),
      krit(
        'Liefer- bzw. Versandbedingungen',
        stichwoerter: ['Lieferbedingungen', 'Versand', 'frei Haus', 'Fracht'],
      ),
      krit(
        'Zahlungsbedingungen',
        stichwoerter: [
          'Zahlungsbedingungen',
          'Zahlungsziel',
          'Skonto',
          'Zahlung',
        ],
      ),
      krit(
        'Gewährleistung bzw. Garantie',
        stichwoerter: ['Gewährleistung', 'Garantie'],
      ),
      krit(
        'Gültigkeit des Angebots',
        stichwoerter: ['gültig', 'Gültigkeit', 'Bindefrist', 'befristet'],
      ),
    ],
    punkte: 4,
    loesung:
        'In das Angebot gehören Art, Güte und Menge der Leistung, der Preis mit Rabatt und Skonto, die Lieferzeit und die Zahlungsbedingungen. Außerdem: Lieferbedingungen, Gewährleistung und Gültigkeit.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Ein Angebot beschreibt Leistung, Preis, Zahlungs- und Lieferbedingungen sowie Gewährleistung und Gültigkeit. Die interne Kalkulation gehört nicht hinein.',
  ),

  rechnen(
    'a2-pa-4',
    'pr-angebot',
    scenario:
        'Ein Händler bietet 5 Laserdrucker zu je 400 € netto an. Er gewährt 10 % Rabatt und 3 % Skonto, die Bezugskosten betragen pauschal 30 €.',
    prompt: 'Berechne den Bezugspreis für alle fünf Drucker.',
    answer: 1776,
    unit: '€',
    tolerance: 0.01,
    explanation:
        'Listeneinkaufspreis: 5 × 400 € = 2.000 €. Rabatt 10 % = 200 € → Zieleinkaufspreis 1.800 €. Skonto 3 % von 1.800 € = 54 € → Bareinkaufspreis 1.746 €. Plus Bezugskosten 30 € → Bezugspreis 1.776 €.',
  ),
  rechnen(
    'a2-pa-5',
    'pr-angebot',
    scenario:
        'Für 12 Monitore liegen zwei Angebote vor.\n'
        'Angebot 1: 250 € je Stück, 8 % Rabatt, 2 % Skonto, Versand 36 €.\n'
        'Angebot 2: 240 € je Stück, 5 % Rabatt, kein Skonto, frei Haus.',
    prompt:
        'Um wie viel Euro unterscheiden sich die Bezugspreise der beiden Angebote?',
    answer: 4.8,
    unit: '€',
    tolerance: 0.01,
    explanation:
        'Angebot 1: 12 × 250 € = 3.000 €; − 8 % Rabatt (240 €) = 2.760 €; − 2 % Skonto (55,20 €) = 2.704,80 €; + 36 € Versand = 2.740,80 €. Angebot 2: 12 × 240 € = 2.880 €; − 5 % Rabatt (144 €) = 2.736 €; kein Skonto, frei Haus = 2.736,00 €. Differenz: 2.740,80 € − 2.736,00 € = 4,80 € - Angebot 2 ist günstiger.',
    difficulty: 3,
  ),
  reihenfolge(
    'a2-pa-6',
    'pr-angebot',
    prompt:
        'Bringe die Positionen der Bezugskalkulation in die richtige Reihenfolge.',
    items: [
      'Listeneinkaufspreis',
      '- Liefererrabatt',
      '= Zieleinkaufspreis',
      '- Liefererskonto',
      '= Bareinkaufspreis',
      '+ Bezugskosten',
      '= Bezugspreis',
    ],
    explanation:
        'Erst wird der Rabatt vom Listenpreis abgezogen, dann das Skonto vom Zieleinkaufspreis. Die Bezugskosten kommen zum Schluss dazu, weil sie weder rabattiert noch skontiert werden.',
    difficulty: 1,
  ),
  einfach(
    'a2-pa-7',
    'pr-angebot',
    scenario:
        'Ein Händler schreibt in sein Angebot über zehn Notebooks: „Preis freibleibend“. Wenige Tage später bestellt der Kunde fristgerecht zu den angebotenen Bedingungen. Inzwischen ist der Einkaufspreis des Händlers gestiegen.',
    prompt: 'Was gilt?',
    choices: [
      ja(
        'Der Händler ist an Ware und Menge gebunden, darf aber einen anderen Preis verlangen.',
        '„Preis freibleibend“ schränkt die Bindung nur beim Preis ein.',
      ),
      nein(
        'Das gesamte Angebot ist unverbindlich.',
        'Das wäre bei „freibleibend“ oder „unverbindlich“ ohne Zusatz der Fall.',
      ),
      nein(
        'Der Händler muss zum ursprünglichen Preis liefern.',
        'Der Preis ist ausdrücklich freigezeichnet.',
      ),
      nein(
        'Der Kunde darf den Preis selbst festlegen.',
        'Die Freizeichnung gibt dem Händler, nicht dem Kunden Spielraum.',
      ),
    ],
    explanation:
        'Freizeichnungsklauseln schränken die Bindung eines Angebots ein. „Preis freibleibend“ betrifft nur den Preis, „solange der Vorrat reicht“ nur die Menge, „freibleibend“ allein das ganze Angebot.',
  ),
  rechnen(
    'a2-pa-8',
    'pr-angebot',
    scenario:
        'Zahlungsbedingung eines Lieferanten: „Zahlbar innerhalb von 30 Tagen netto, bei Zahlung innerhalb von 10 Tagen 2 % Skonto.“',
    prompt:
        'Welchem Jahreszinssatz entspricht das Skonto nach der Näherungsformel (Jahr = 360 Tage)?',
    answer: 36,
    unit: '%',
    tolerance: 0.1,
    explanation:
        'Wer das Skonto nutzt, zahlt 30 − 10 = 20 Tage früher und spart dafür 2 %. Jahreszins ≈ Skontosatz × 360 / (Zahlungsziel − Skontofrist) = 2 % × 360 / 20 = 36 %. Skonto zu nutzen lohnt sich also fast immer.',
    difficulty: 3,
  ),
  rechnen(
    'a2-pa-9',
    'pr-angebot',
    scenario:
        'Du erstellst ein Angebot: Hardware 2.300 € netto, dazu 8 Arbeitsstunden zu je 90 € netto. Es gilt der Umsatzsteuersatz von 19 %.',
    prompt: 'Wie hoch ist der Angebotspreis brutto?',
    answer: 3593.8,
    unit: '€',
    tolerance: 0.01,
    explanation:
        'Arbeit: 8 × 90 € = 720 €. Nettobetrag: 2.300 € + 720 € = 3.020 €. Umsatzsteuer: 19 % von 3.020 € = 573,80 €. Bruttobetrag: 3.020 € + 573,80 € = 3.593,80 €.',
  ),

  // ======================================================== Markt und Marktformen
  zuordnen(
    'a2-mm-1',
    'm-markt',
    prompt: 'Welche Marktform liegt vor? (jeweils viele Nachfrager)',
    buckets: ['Polypol', 'Oligopol', 'Monopol'],
    items: [
      zu('Hunderte IT-Dienstleister bieten in einer Region Support an.', 0),
      zu(
        'Drei große Anbieter teilen sich den Markt für Cloud-Infrastruktur.',
        1,
      ),
      zu('Nur ein Anbieter vertreibt eine vorgeschriebene Fachsoftware.', 2),
      zu('Viele Onlinehändler verkaufen dieselben USB-Sticks.', 0),
    ],
    explanation: 'Polypol: viele Anbieter. Oligopol: wenige. Monopol: einer.',
  ),
  tabelle(
    'a2-mm-2',
    'm-markt',
    scenario:
        'Das Marktformenschema kombiniert die Zahl der Anbieter mit der Zahl der Nachfrager.',
    prompt: 'Trage zu jeder Kombination die Marktform ein.',
    zeilen: [
      ['Anbieter', 'Nachfrager', 'Marktform'],
      [
        'viele',
        'viele',
        wahl('Polypol', ['Angebotsoligopol', 'Angebotsmonopol']),
      ],
      [
        'wenige',
        'viele',
        wahl('Angebotsoligopol', ['Polypol', 'Nachfrageoligopol']),
      ],
      [
        'einer',
        'viele',
        wahl('Angebotsmonopol', ['Nachfragemonopol', 'Angebotsoligopol']),
      ],
      [
        'viele',
        'einer',
        wahl('Nachfragemonopol', ['Angebotsmonopol', 'Polypol']),
      ],
      [
        'wenige',
        'wenige',
        wahl('zweiseitiges Oligopol', ['Angebotsoligopol', 'Polypol']),
      ],
    ],
    explanation:
        'Polypol: viele Anbieter und viele Nachfrager. Oligopol: wenige. Monopol: einer. Je weniger Anbieter, desto größer ihre Macht über den Preis; am größten im Angebotsmonopol.',
  ),
  einfach(
    'a2-mm-3',
    'm-markt',
    prompt:
        'Eine Behörde ist der einzige Abnehmer eines speziellen Verwaltungssystems, das viele Firmen entwickeln könnten. Welche Marktform liegt vor?',
    choices: [
      ja('Nachfragemonopol', 'Viele Anbieter, ein einziger Nachfrager.'),
      nein('Angebotsmonopol', 'Dann gäbe es nur einen Anbieter.'),
      nein('Polypol', 'Dafür bräuchte es viele Nachfrager.'),
      nein('Oligopol', 'Das beschreibt wenige Anbieter.'),
    ],
    explanation:
        'Marktformen gibt es auf beiden Seiten. Ein einziger Nachfrager bildet ein Nachfragemonopol.',
  ),

  rechnen(
    'a2-mm-4',
    'm-markt',
    scenario:
        'Der Markt für Webhosting in einer Region hat ein Volumen von 2,5 Mio. € pro Jahr. Ein Anbieter setzt dort 175.000 € um.',
    prompt: 'Wie hoch ist sein Marktanteil in Prozent?',
    answer: 7,
    unit: '%',
    tolerance: 0.01,
    explanation:
        'Marktanteil = eigener Umsatz / Marktvolumen × 100 = 175.000 € / 2.500.000 € × 100 = 7 %.',
    difficulty: 1,
  ),
  rechnen(
    'a2-mm-5',
    'm-markt',
    scenario:
        'Für Smartwatches in Deutschland schätzt ein Marktforschungsinstitut ein Marktpotenzial von 800.000 Geräten pro Jahr. Tatsächlich verkauft werden 600.000 Geräte.',
    prompt: 'Wie hoch ist der Sättigungsgrad des Marktes in Prozent?',
    answer: 75,
    unit: '%',
    tolerance: 0.01,
    explanation:
        'Sättigungsgrad = Marktvolumen / Marktpotenzial × 100 = 600.000 / 800.000 × 100 = 75 %. Ein Viertel des Potenzials ist noch nicht ausgeschöpft.',
  ),
  zuordnen(
    'a2-mm-6',
    'm-markt',
    prompt:
        'Handelt es sich um Marktanalyse, Marktbeobachtung oder Marktprognose?',
    buckets: ['Marktanalyse', 'Marktbeobachtung', 'Marktprognose'],
    items: [
      zu(
        'Wie hat sich die Nachfrage nach Cloud-Telefonie seit 2022 entwickelt?',
        1,
      ),
      zu(
        'Wie viele Handwerksbetriebe im Kreis nutzen derzeit eine digitale Zeiterfassung?',
        0,
      ),
      zu(
        'Wie viele Arztpraxen werden 2030 voraussichtlich Videosprechstunden anbieten?',
        2,
      ),
      zu(
        'Monatliche Auswertung der Preise der drei wichtigsten Wettbewerber über ein Jahr',
        1,
      ),
    ],
    explanation:
        'Die Marktanalyse ist eine Momentaufnahme zu einem Zeitpunkt, die Marktbeobachtung verfolgt die Entwicklung über einen Zeitraum, die Marktprognose schätzt die Zukunft.',
  ),
  einfach(
    'a2-mm-7',
    'm-markt',
    prompt: 'Welche Maßnahme gehört zur Primärforschung?',
    choices: [
      ja(
        'Eine Online-Umfrage unter den eigenen Kunden',
        'Die Daten werden neu und selbst erhoben.',
      ),
      nein(
        'Die Auswertung eines Branchenberichts',
        'Vorhandene Daten - Sekundärforschung.',
      ),
      nein(
        'Zahlen des Statistischen Bundesamts',
        'Amtliche Statistik ist eine Sekundärquelle.',
      ),
      nein(
        'Die Analyse der eigenen Umsatzstatistik',
        'Auch interne, bereits vorhandene Daten gehören zur Sekundärforschung.',
      ),
    ],
    explanation:
        'Primärforschung erhebt neue Daten (Befragung, Beobachtung, Test). Sekundärforschung wertet vorhandene Daten aus, auch interne wie die eigene Umsatzstatistik.',
    difficulty: 2,
  ),
  einfach(
    'a2-mm-8',
    'm-markt',
    prompt:
        'Wenige große Hersteller liefern Kassensysteme an wenige große Handelsketten. Welche Marktform liegt vor?',
    choices: [
      ja(
        'Zweiseitiges Oligopol',
        'Wenige Anbieter treffen auf wenige Nachfrager.',
      ),
      nein('Angebotsoligopol', 'Das setzt viele Nachfrager voraus.'),
      nein('Nachfrageoligopol', 'Das setzt viele Anbieter voraus.'),
      nein('Polypol', 'Das setzt viele Anbieter und viele Nachfrager voraus.'),
    ],
    explanation:
        'Im Marktformenschema werden Anbieter und Nachfrager kombiniert. Wenige Anbieter und wenige Nachfrager ergeben ein zweiseitiges (bilaterales) Oligopol.',
    difficulty: 3,
  ),
  lueckentext(
    'a2-mm-9',
    'm-markt',
    scenario:
        'Auf dem Markt für gebrauchte Business-Notebooks liegt der Gleichgewichtspreis bei 300 €. Die Händler verlangen derzeit 380 €.',
    prompt: 'Wähle für jede Lücke den passenden Begriff.',
    text:
        'Beim Preis von 380 € ist die angebotene Menge {0} als die nachgefragte. Es entsteht ein {1}. Die Händler bleiben auf Ware sitzen, der Preis wird deshalb tendenziell {2}. Beim Gleichgewichtspreis sind angebotene und nachgefragte Menge {3}.',
    luecken: [
      wahl('größer', [
        'kleiner',
        'genauso groß',
      ], 'Bei hohem Preis wird viel angeboten und wenig nachgefragt.'),
      wahl('Angebotsüberhang', [
        'Nachfrageüberhang',
        'Marktgleichgewicht',
      ], 'Mehr Angebot als Nachfrage.'),
      wahl('sinken', [
        'steigen',
        'gleich bleiben',
      ], 'Die Anbieter senken die Preise, um zu verkaufen.'),
      wahl('gleich groß', [
        'beide null',
        'unabhängig vom Preis',
      ], 'Dort schneiden sich Angebots- und Nachfragekurve.'),
    ],
    explanation:
        'Im Gleichgewicht schneiden sich Angebots- und Nachfragekurve. Liegt der Preis darüber, bleiben Anbieter auf Ware sitzen (Angebotsüberhang). Der Preis sinkt Richtung Gleichgewicht.',
  ),

  // ============================================================== Bedarf ermitteln
  reihenfolge(
    'a2-mb-1',
    'm-bedarf',
    prompt:
        'Bringe die Begriffe in die richtige Reihenfolge, vom ersten Gefühl bis zum Kauf.',
    items: ['Bedürfnis', 'Bedarf', 'Nachfrage'],
    explanation:
        'Bedürfnis (Mangel), Bedarf (Bedürfnis mit Kaufkraft), Nachfrage (am Markt wirksamer Bedarf).',
  ),
  reihenfolge(
    'a2-mb-2',
    'm-bedarf',
    scenario:
        'Ein Verkäufer will seine Argumente an den Bedürfnissen der Kunden ausrichten und nutzt dafür die Bedürfnispyramide nach Maslow.',
    prompt:
        'Bringe die Stufen der Pyramide in die richtige Reihenfolge, von unten nach oben.',
    items: [
      'Grundbedürfnisse',
      'Sicherheitsbedürfnisse',
      'Soziale Bedürfnisse',
      'Wertschätzung',
      'Selbstverwirklichung',
    ],
    explanation:
        'Die Pyramide von unten: Grundbedürfnisse, Sicherheit, soziale Bedürfnisse, Wertschätzung, Selbstverwirklichung. Ein sicherer, unbefristeter Arbeitsvertrag spricht zum Beispiel die zweite Stufe an.',
  ),
  einfach(
    'a2-mb-3',
    'm-bedarf',
    scenario:
        'Ein Kleinbetrieb mit drei Arbeitsplätzen wünscht sich einen großen Rack-Server, „weil das professionell ist“. Gespeichert werden sollen nur Office-Dateien.',
    prompt: 'Wie berät man richtig?',
    choices: [
      ja(
        'Den tatsächlichen Bedarf klären und eine passende Lösung wie ein NAS empfehlen',
        'Gute Beratung orientiert sich am Bedarf, nicht am Wunsch.',
      ),
      nein(
        'Den Server liefern, der Kunde hat es so gewollt',
        'Überdimensioniert und teuer ohne Nutzen.',
      ),
      nein('Den Auftrag ablehnen', 'Verschenkt eine sinnvolle Lösung.'),
      nein(
        'Zwei Server empfehlen, um auf der sicheren Seite zu sein',
        'Noch weiter vom Bedarf entfernt.',
      ),
    ],
    explanation:
        'Wunsch ist nicht Bedarf. Wer den echten Bedarf ermittelt, spart dem Kunden Geld und gewinnt Vertrauen.',
  ),

  zuordnen(
    'a2-mb-4',
    'm-bedarf',
    prompt: 'Handelt es sich um ein Bedürfnis, einen Bedarf oder Nachfrage?',
    buckets: ['Bedürfnis', 'Bedarf', 'Nachfrage'],
    items: [
      zu(
        'Eine Arztpraxis empfindet die langen Wartezeiten am Empfang als Mangel.',
        0,
      ),
      zu(
        'Timo wünscht sich einen schnelleren Rechner für seine Grafikarbeiten.',
        0,
      ),
      zu('Timo bestellt den Rechner im Onlineshop.', 2),
      zu('Timo hat 1.500 € gespart und könnte sich den Rechner leisten.', 1),
    ],
    explanation:
        'Ein Bedürfnis ist ein empfundener Mangel. Kommt Kaufkraft dazu, wird daraus Bedarf. Tritt der Bedarf am Markt auf, etwa durch eine Bestellung, ist es Nachfrage.',
    difficulty: 1,
  ),
  einfach(
    'a2-mb-5',
    'm-bedarf',
    scenario:
        'Bei der Bedarfsanalyse wünscht sich ein Kunde nur „schnellere Rechner“. Du stellst fest, dass seine Daten nirgends gesichert werden. Daran hat er selbst nicht gedacht.',
    prompt: 'Wie nennt man den Bedarf an einer Datensicherung in diesem Fall?',
    choices: [
      ja('latenter Bedarf', 'Er besteht, ist dem Kunden aber nicht bewusst.'),
      nein(
        'offener Bedarf',
        'Offen wäre er, wenn der Kunde ihn selbst nennen würde.',
      ),
      nein(
        'Luxusbedürfnis',
        'Eine Datensicherung dient der Sicherheit, nicht dem Luxus.',
      ),
      nein(
        'Nachfrage',
        'Nachfrage entsteht erst, wenn der Kunde am Markt kauft.',
      ),
    ],
    explanation:
        'Offener Bedarf wird vom Kunden genannt, latenter Bedarf ist vorhanden, aber unbewusst. Gute Beratung macht latenten Bedarf sichtbar.',
  ),
  einfach(
    'a2-mb-6',
    'm-bedarf',
    scenario:
        'Ein Unternehmen mit 120 Mitarbeitenden an drei Standorten will wissen, welche Funktionen eine neue Kollaborationssoftware haben soll. Die Antworten sollen vergleichbar sein und schnell ausgewertet werden.',
    prompt: 'Welche Methode der Bedarfsermittlung eignet sich am besten?',
    choices: [
      ja(
        'Ein standardisierter Online-Fragebogen',
        'Erreicht viele Personen und liefert vergleichbare, schnell auswertbare Antworten.',
      ),
      nein(
        'Einzelinterviews mit allen 120 Mitarbeitenden',
        'Liefert tiefe Einblicke, ist bei 120 Personen aber viel zu aufwendig.',
      ),
      nein(
        'Beobachtung an jedem Arbeitsplatz',
        'Zeigt Abläufe, ist bei drei Standorten sehr aufwendig und liefert keine Wünsche.',
      ),
      nein(
        'Auswertung alter Handbücher',
        'Zeigt den Ist-Zustand, aber nicht, was künftig gebraucht wird.',
      ),
    ],
    explanation:
        'Bei vielen Beteiligten und dem Wunsch nach vergleichbaren Antworten ist der Fragebogen die passende Methode. Interviews und Workshops eignen sich eher für wenige Personen oder tiefe Details.',
  ),
  zuordnen(
    'a2-mb-7',
    'm-bedarf',
    prompt: 'Welche Stufe der Maslow-Pyramide spricht das Verkaufsargument an?',
    buckets: [
      'Sicherheit',
      'Soziale Bedürfnisse',
      'Wertschätzung',
      'Selbstverwirklichung',
    ],
    items: [
      zu(
        'Team-Chat, damit sich Mitarbeitende im Homeoffice nicht isoliert fühlen',
        1,
      ),
      zu('Automatisches Backup, damit keine Kundendaten verloren gehen', 0),
      zu('Weiterbildung zur Spezialistin für IT-Sicherheit', 3),
      zu('Das neueste Premium-Smartphone als Statussymbol', 2),
    ],
    explanation:
        'Maslow von unten: Grundbedürfnisse, Sicherheit, soziale Bedürfnisse, Wertschätzung, Selbstverwirklichung. Wer das Bedürfnis kennt, wählt das passende Argument.',
  ),
  reihenfolge(
    'a2-mb-8',
    'm-bedarf',
    prompt:
        'Bringe die Schritte einer Bedarfsanalyse in die richtige Reihenfolge.',
    items: [
      'Ist-Zustand aufnehmen',
      'Schwachstellen erkennen',
      'Soll-Zustand festlegen',
      'Bedarf dokumentieren und vom Kunden bestätigen lassen',
    ],
    explanation:
        'Erst wird erfasst, was vorhanden ist, dann was fehlt oder stört. Daraus ergibt sich das Soll. Zum Schluss wird der Bedarf schriftlich festgehalten und vom Kunden bestätigt.',
    difficulty: 1,
  ),

  // ================================================ Marketing-Mix und AIDA
  zuordnen(
    'a2-mk-1',
    'm-marketing',
    prompt: 'Zu welchem Instrument des Marketing-Mix gehört die Maßnahme?',
    buckets: [
      'Produktpolitik',
      'Preispolitik',
      'Distributionspolitik',
      'Kommunikationspolitik',
    ],
    items: [
      zu('10 % Frühbucherrabatt gewähren', 1),
      zu('Drei Jahre Vor-Ort-Garantie ins Angebot aufnehmen', 0),
      zu('Einen Stand auf einer IT-Messe betreiben', 3),
      zu('Die Software zusätzlich über einen Onlineshop vertreiben', 2),
    ],
    explanation:
        'Produkt: was angeboten wird. Preis: zu welchen Konditionen. Distribution: über welchen Weg. Kommunikation: wie es bekannt wird.',
  ),
  reihenfolge(
    'a2-mk-2',
    'm-marketing',
    prompt: 'Bringe die Stufen der AIDA-Formel in die richtige Reihenfolge.',
    items: ['Attention', 'Interest', 'Desire', 'Action'],
    explanation:
        'Aufmerksamkeit wecken, Interesse erzeugen, Wunsch auslösen, zum Handeln bewegen.',
  ),
  paare(
    'a2-mk-3',
    'm-marketing',
    scenario:
        'Ein Systemhaus entwirft eine Werbeanzeige für sein Cloud-Backup nach der AIDA-Formel.',
    prompt: 'Ordne jedes Element der Anzeige der passenden AIDA-Stufe zu.',
    paare: [
      paar('Attention', 'auffällige Überschrift: „Daten weg?“'),
      paar('Interest', 'Zahlen zu Datenverlusten im Mittelstand'),
      paar('Desire', 'Beschreibung, wie bequem die Lösung ist'),
      paar('Action', '„Jetzt 30 Tage kostenlos testen“'),
    ],
    explanation:
        'AIDA: Aufmerksamkeit wecken (Attention), Interesse erzeugen (Interest), Wunsch auslösen (Desire), zum Handeln bewegen (Action), etwa kaufen, testen oder anrufen.',
  ),

  zuordnen(
    'a2-mk-4',
    'm-marketing',
    prompt: 'Welche preispolitische Strategie wird verfolgt?',
    buckets: ['Penetration', 'Abschöpfung (Skimming)', 'Preisdifferenzierung'],
    items: [
      zu(
        'Ein Messenger ist zum Start kostenlos, um schnell viele Nutzer zu gewinnen, später kommen Gebühren.',
        0,
      ),
      zu(
        'Ein neuer Cloud-Speicher startet mit 1 € im Monat, später kostet er 5 €.',
        0,
      ),
      zu(
        'Dieselbe Software kostet für Schüler 20 €, für Unternehmen 200 €.',
        2,
      ),
      zu(
        'Eine neue Spielkonsole kostet zum Start 699 €, ein Jahr später 499 €.',
        1,
      ),
    ],
    explanation:
        'Penetration: niedrig einsteigen, um schnell Marktanteile zu gewinnen, später erhöhen. Abschöpfung: hoch einsteigen und die Zahlungsbereitschaft früher Käufer nutzen, später senken. Preisdifferenzierung: gleiche Leistung, unterschiedliche Preise je Zielgruppe.',
  ),
  zuordnen(
    'a2-mk-5',
    'm-marketing',
    prompt: 'In welches Feld der BCG-Matrix gehört das Produkt?',
    buckets: ['Question Mark', 'Star', 'Cash Cow', 'Poor Dog'],
    items: [
      zu('Marktführer bei Cloud-Backup in einem stark wachsenden Markt', 1),
      zu('Neue KI-Software: Markt wächst stark, eigener Anteil noch klein', 0),
      zu('Kleiner Anteil am schrumpfenden Markt für Faxgeräte', 3),
      zu('Marktführer bei Druckerwartung, der Markt wächst kaum noch', 2),
    ],
    explanation:
        'Die BCG-Matrix kombiniert Marktwachstum und relativen Marktanteil: Question Marks (hohes Wachstum, kleiner Anteil), Stars (hoch, groß), Cash Cows (niedrig, groß), Poor Dogs (niedrig, klein).',
    difficulty: 3,
  ),
  freitext(
    'a2-mk-6',
    'm-marketing',
    scenario:
        'Ein IT-Dienstleister eröffnet einen zweiten Standort und will ihn in der Region bekannt machen.',
    prompt:
        'Nenne drei Instrumente der Kommunikationspolitik, die er dafür einsetzen kann.',
    kriterien: [
      krit(
        'Werbung, z. B. Anzeigen, Plakate oder Online-Werbung',
        stichwoerter: ['Werbung', 'Anzeige', 'Plakat', 'Flyer'],
      ),
      krit(
        'Öffentlichkeitsarbeit (PR), z. B. eine Pressemitteilung zur Eröffnung',
        stichwoerter: [
          'Öffentlichkeitsarbeit',
          'Public Relations',
          'Pressemitteilung',
          'Presse',
        ],
      ),
      krit(
        'Verkaufsförderung, z. B. Eröffnungsaktion oder Messestand',
        stichwoerter: [
          'Verkaufsförderung',
          'Eröffnungsaktion',
          'Messe',
          'Gutschein',
          'Promotion',
        ],
      ),
      krit(
        'Online-Marketing, z. B. Newsletter und soziale Medien',
        stichwoerter: [
          'Newsletter',
          'Social Media',
          'Online-Marketing',
          'soziale Medien',
          'Website',
        ],
      ),
      krit('Sponsoring', stichwoerter: ['Sponsoring', 'Sponsor']),
      krit(
        'Persönlicher Verkauf',
        stichwoerter: ['persönlicher Verkauf', 'Außendienst', 'Kundenbesuch'],
      ),
    ],
    punkte: 3,
    loesung:
        'Geeignet sind Werbung (z. B. Anzeigen in der Regionalzeitung), Öffentlichkeitsarbeit (Pressemitteilung zur Eröffnung) und Online-Marketing (Newsletter an Bestandskunden). Auch Verkaufsförderung, Sponsoring und persönlicher Verkauf gehören dazu.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Zur Kommunikationspolitik zählen Werbung, Verkaufsförderung, Public Relations, persönlicher Verkauf, Online-Marketing und Sponsoring. Rabatte gehören zur Preispolitik, Vertriebswege zur Distributionspolitik.',
    difficulty: 1,
  ),
  einfach(
    'a2-mk-7',
    'm-marketing',
    scenario:
        'Der Umsatz einer Buchhaltungssoftware ist hoch, wächst aber kaum noch. Viele Konkurrenten bieten ähnliche Produkte an.',
    prompt:
        'In welcher Phase des Produktlebenszyklus ist das Produkt, und was passt dazu?',
    choices: [
      ja(
        'Reife: sich mit Zusatzfunktionen und Service von der Konkurrenz abheben',
        'Hoher, kaum noch wachsender Umsatz bei starker Konkurrenz kennzeichnet die Reife.',
      ),
      nein(
        'Einführung: das Produkt erst bekannt machen',
        'In der Einführung ist der Umsatz noch gering.',
      ),
      nein(
        'Wachstum: den Vertrieb stark ausbauen',
        'Im Wachstum steigt der Umsatz stark an.',
      ),
      nein(
        'Rückgang: das Produkt sofort vom Markt nehmen',
        'Der Umsatz sinkt nicht, er ist hoch.',
      ),
    ],
    explanation:
        'Phasen: Einführung (geringer Umsatz), Wachstum (starker Anstieg), Reife (hoch, wächst langsam), Sättigung (stagniert), Rückgang (sinkt). In der Reife geht es darum, sich von Wettbewerbern abzuheben.',
  ),

  // ============================================================== ABC-Analyse
  rechnen(
    'a2-ma-1',
    'm-abc',
    scenario:
        'Jahresumsatz je Produkt (gesamt 100.000 €):\n'
        'P1: 50.000 €\nP2: 25.000 €\nP3: 12.000 €\nP4: 8.000 €\nP5: 5.000 €',
    prompt:
        'Wie groß ist der kumulierte Umsatzanteil von P1 und P2 in Prozent?',
    answer: 75,
    unit: '%',
    explanation:
        'P1: 50.000 / 100.000 = 50 %. P2: 25 %. Kumuliert: 50 % + 25 % = 75 %. Bei einer üblichen A-Grenze von 75 bis 80 % gehören beide zur A-Klasse.',
  ),
  reihenfolge(
    'a2-ma-2',
    'm-abc',
    prompt: 'Bringe die Schritte der ABC-Analyse in die richtige Reihenfolge.',
    items: [
      'Wert je Objekt ermitteln',
      'Nach Wert absteigend sortieren',
      'Anteil am Gesamtwert berechnen',
      'Anteile kumulieren',
      'Klassen A, B und C zuordnen',
    ],
    explanation:
        'Ohne Sortierung und Kumulierung lassen sich die Klassengrenzen nicht ziehen.',
  ),
  tabelle(
    'a2-ma-3',
    'm-abc',
    scenario:
        'Ein Systemhaus hat seine Kunden mit einer ABC-Analyse nach dem Umsatz eingeteilt.',
    prompt: 'Trage zu jeder Klasse die typischen Merkmale ein.',
    zeilen: [
      ['Klasse', 'Anzahl Kunden', 'Umsatzanteil', 'Betreuung'],
      [
        'A',
        wahl('wenige', ['viele', 'mittlere Zahl']),
        wahl('groß', ['mittel', 'klein']),
        wahl('persönlich und intensiv', ['nach Bedarf', 'standardisiert']),
      ],
      [
        'B',
        wahl('mittlere Zahl', ['wenige', 'viele']),
        wahl('mittel', ['groß', 'klein']),
        wahl('nach Bedarf', ['persönlich und intensiv', 'standardisiert']),
      ],
      [
        'C',
        wahl('viele', ['wenige', 'mittlere Zahl']),
        wahl('klein', ['groß', 'mittel']),
        wahl('standardisiert', ['persönlich und intensiv', 'nach Bedarf']),
      ],
    ],
    explanation:
        'A: wenige Kunden mit großem Umsatzanteil, intensiv betreuen. C: viele Kunden mit kleinem Umsatzanteil, effizient und standardisiert betreuen, aber nicht kündigen. B liegt dazwischen.',
  ),

  rechnen(
    'a2-ma-4',
    'm-abc',
    scenario:
        'Ein Artikel wird 250-mal im Jahr zu je 36 € eingekauft. Der Jahresverbrauchswert aller Lagerartikel beträgt 60.000 €.',
    prompt: 'Wie groß ist der Wertanteil dieses Artikels in Prozent?',
    answer: 15,
    unit: '%',
    tolerance: 0.01,
    explanation:
        'Verbrauchswert = Menge × Preis = 250 × 36 € = 9.000 €. Anteil = 9.000 € / 60.000 € × 100 = 15 %.',
    difficulty: 1,
  ),
  einfach(
    'a2-ma-5',
    'm-abc',
    scenario:
        'Klassengrenzen: A bis 75 % kumuliert, B bis 90 %, C der Rest.\n'
        'Kumulierte Wertanteile nach Sortierung: Server 45 %, Lizenzen 72 %, Notebooks 86 %, Monitore 93 %, Zubehör 100 %.',
    prompt: 'Welcher Klasse werden die Notebooks zugeordnet?',
    choices: [
      ja(
        'B',
        '86 % liegt über der A-Grenze von 75 % und unter der B-Grenze von 90 %.',
      ),
      nein('A', 'Zur A-Klasse gehören nur Server und Lizenzen (bis 72 %).'),
      nein('C', 'Die C-Klasse beginnt erst oberhalb von 90 % kumuliert.'),
      nein(
        'Das lässt sich ohne Einzelanteile nicht sagen.',
        'Für die Zuordnung reicht der kumulierte Anteil.',
      ),
    ],
    explanation:
        'Maßgeblich ist der kumulierte Anteil: Server (45 %) und Lizenzen (72 %) sind A, Notebooks (86 %) sind B, Monitore (93 %) und Zubehör (100 %) sind C.',
  ),
  rechnen(
    'a2-ma-6',
    'm-abc',
    scenario:
        'Jahresumsätze von fünf Kunden (gesamt 250.000 €):\n'
        'Kunde A: 100.000 €\nKunde B: 75.000 €\nKunde C: 40.000 €\nKunde D: 20.000 €\nKunde E: 15.000 €',
    prompt:
        'Wie hoch ist der kumulierte Umsatzanteil der Kunden A, B und C in Prozent?',
    answer: 86,
    unit: '%',
    tolerance: 0.01,
    explanation:
        'Anteile: A = 100.000 / 250.000 × 100 = 40 %, B = 75.000 / 250.000 × 100 = 30 %, C = 40.000 / 250.000 × 100 = 16 %. Kumuliert: 40 % + 30 % + 16 % = 86 %.',
  ),
  mehrfach(
    'a2-ma-7',
    'm-abc',
    prompt: 'Welche Maßnahmen passen zu C-Kunden?',
    choices: [
      ja(
        'Bestellung über ein Onlineportal',
        'Effiziente, standardisierte Abwicklung.',
      ),
      ja(
        'Standardverträge statt individueller Verhandlungen',
        'Spart Aufwand bei kleinen Umsätzen.',
      ),
      ja(
        'Support über das Ticketsystem statt regelmäßiger Vor-Ort-Besuche',
        'Kostengünstige Betreuung.',
      ),
      nein(
        'Ein fester persönlicher Key-Account-Manager',
        'Intensive Betreuung lohnt sich vor allem bei A-Kunden.',
      ),
      nein(
        'Jährliche Verhandlungsrunden über Sonderkonditionen',
        'Dieser Aufwand ist A-Kunden vorbehalten.',
      ),
    ],
    explanation:
        'C-Kunden bringen wenig Umsatz, sind aber zahlreich. Sie werden effizient und standardisiert betreut, damit sich der Aufwand lohnt. Intensive Betreuung gilt den A-Kunden.',
    difficulty: 1,
  ),

  // ================================================ Rechtsformen von Unternehmen
  zuordnen(
    'a2-mr-1',
    'm-rechtsformen',
    prompt: 'Ordne die Aussage der passenden Rechtsform zu.',
    buckets: ['GmbH', 'AG', 'KG', 'Einzelunternehmen'],
    items: [
      zu('Organe sind Vorstand, Aufsichtsrat und Hauptversammlung', 1),
      zu('25.000 € Stammkapital, Haftung mit dem Gesellschaftsvermögen', 0),
      zu('Eine Person entscheidet allein und haftet unbeschränkt', 3),
      zu(
        'Ein Gesellschafter haftet unbeschränkt, ein anderer nur mit seiner Einlage',
        2,
      ),
    ],
    explanation:
        'GmbH: Stammkapital 25.000 €. AG: drei Organe. KG: Komplementär und Kommanditist. Einzelunternehmen: Inhaber haftet allein und voll.',
  ),
  einfach(
    'a2-mr-2',
    'm-rechtsformen',
    scenario:
        'Zwei Auszubildende wollen nebenbei einen kleinen IT-Service gründen. Sie haben kaum Startkapital, wollen aber nicht mit ihrem Privatvermögen haften.',
    prompt: 'Welche Rechtsform passt?',
    choices: [
      ja(
        'UG (haftungsbeschränkt)',
        'Haftungsbeschränkt wie eine GmbH, aber schon ab 1 € Stammkapital.',
      ),
      nein(
        'GbR',
        'Die Gesellschafter haften unbeschränkt mit ihrem Privatvermögen.',
      ),
      nein('AG', 'Braucht 50.000 € Grundkapital und ist sehr aufwendig.'),
      nein('OHG', 'Alle Gesellschafter haften unbeschränkt.'),
    ],
    explanation:
        'Die UG verbindet Haftungsbeschränkung mit minimalem Startkapital. Sie muss dafür Gewinne ansparen, bis 25.000 € erreicht sind.',
  ),
  einfach(
    'a2-mr-3',
    'm-rechtsformen',
    prompt:
        'Womit haften die Gesellschafter einer GmbH für Schulden der Gesellschaft?',
    choices: [
      ja(
        'Nur mit ihrer Einlage; die GmbH haftet mit ihrem Gesellschaftsvermögen',
        'Das Privatvermögen der Gesellschafter ist grundsätzlich geschützt.',
      ),
      nein(
        'Unbeschränkt mit ihrem Privatvermögen',
        'Das gilt bei Personengesellschaften wie OHG oder GbR.',
      ),
      nein(
        'Gar nicht, eine GmbH haftet nie',
        'Die GmbH haftet, aber mit ihrem eigenen Vermögen.',
      ),
      nein(
        'Nur mit dem Geschäftsführergehalt',
        'Eine solche Regel gibt es nicht.',
      ),
    ],
    explanation:
        'Bei Kapitalgesellschaften haftet das Gesellschaftsvermögen. Gesellschafter riskieren ihre Einlage, außer sie haben sich zusätzlich persönlich verbürgt.',
  ),
  rechnen(
    'a2-mr-4',
    'm-rechtsformen',
    scenario:
        'Eine UG (haftungsbeschränkt) erzielt einen Jahresüberschuss von 18.000 €. Einen Verlustvortrag aus dem Vorjahr gibt es nicht.',
    prompt:
        'Welchen Betrag muss sie mindestens in die gesetzliche Rücklage einstellen?',
    answer: 4500,
    unit: '€',
    tolerance: 0.01,
    explanation:
        'Nach § 5a GmbHG muss die UG ein Viertel ihres Jahresüberschusses (vermindert um einen Verlustvortrag) zurücklegen: 18.000 € × 25 % = 4.500 €. Das gilt, bis das Stammkapital auf mindestens 25.000 € erhöht ist.',
  ),
  rechnen(
    'a2-mr-5',
    'm-rechtsformen',
    scenario:
        'Die Schneider IT KG schuldet einem Lieferanten 80.000 €. Das Vermögen der KG reicht nur für 35.000 €. Komplementär ist Herr Schneider, Kommanditistin ist Frau Kaya, die ihre Einlage von 15.000 € vollständig eingezahlt hat.',
    prompt:
        'Wie viel Euro muss Herr Schneider aus seinem Privatvermögen zahlen?',
    answer: 45000,
    unit: '€',
    tolerance: 0.01,
    explanation:
        'Aus dem Vermögen der KG werden 35.000 € gezahlt, offen bleiben 80.000 € − 35.000 € = 45.000 €. Frau Kaya haftet nur bis zur Höhe ihrer Einlage, die sie bereits voll eingezahlt hat. Sie muss nichts nachzahlen. Der Komplementär haftet unbeschränkt und trägt die 45.000 €.',
    difficulty: 3,
  ),
  zuordnen(
    'a2-mr-6',
    'm-rechtsformen',
    prompt:
        'Welches Mindestkapital schreibt das Gesetz für die Rechtsform vor?',
    buckets: ['kein Mindestkapital', '1 €', '25.000 €', '50.000 €'],
    items: [
      zu('OHG', 0),
      zu('GbR', 0),
      zu('AG', 3),
      zu('GmbH', 2),
      zu('UG (haftungsbeschränkt)', 1),
      zu('KG', 0),
    ],
    explanation:
        'Personengesellschaften brauchen kein Mindestkapital, weil die Gesellschafter persönlich haften. GmbH: 25.000 € Stammkapital, UG: ab 1 €, AG: 50.000 € Grundkapital.',
    difficulty: 1,
  ),
  paare(
    'a2-mr-7',
    'm-rechtsformen',
    scenario:
        'Ein Lieferant fordert 60.000 € von einer OHG mit drei Gesellschaftern.',
    prompt: 'Ordne jedem Haftungsmerkmal der OHG seine Bedeutung zu.',
    paare: [
      paar('unbeschränkt', 'auch mit dem Privatvermögen'),
      paar('unmittelbar', 'Gläubiger fordert direkt vom Gesellschafter'),
      paar('solidarisch', 'jeder haftet für die gesamte Schuld'),
    ],
    explanation:
        'OHG-Gesellschafter haften unbeschränkt (mit dem Privatvermögen), unmittelbar (Gläubiger können direkt fordern) und solidarisch (jeder für die ganze Schuld). Ein Mindestkapital gibt es bei der OHG nicht.',
  ),
  einfach(
    'a2-mr-8',
    'm-rechtsformen',
    prompt: 'Was ist eine GmbH & Co. KG?',
    choices: [
      ja(
        'Eine KG, deren Komplementär eine GmbH ist',
        'Die unbeschränkt haftende Gesellschafterin ist eine GmbH. So haftet im Ergebnis keine natürliche Person privat.',
      ),
      nein(
        'Eine GmbH mit zusätzlichen Kommanditisten',
        'Rechtlich ist sie eine KG, keine GmbH.',
      ),
      nein(
        'Eine Kapitalgesellschaft mit 50.000 € Grundkapital',
        'Das beschreibt die AG.',
      ),
      nein(
        'Ein Zusammenschluss aus einer GmbH und einer AG',
        'Eine AG ist daran nicht beteiligt.',
      ),
    ],
    explanation:
        'Die GmbH & Co. KG ist eine Personengesellschaft (KG). Ihr Komplementär ist eine GmbH, die nur mit ihrem Gesellschaftsvermögen haftet. Die Kommanditisten haften bis zu ihrer Einlage.',
  ),
];
