import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben im IHK-Stil zu Bereich 02: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA02 = [
  // =================================================== Kommunikationsmodelle
  tabelle(
    'i2-km-1',
    'k-modelle',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH betreut die Steuerkanzlei Albers & Partner. Die Büroleiterin der Kanzlei schreibt ins Ticket: „Der Drucker am Empfang druckt schon wieder nicht!“',
    prompt:
        'Ordne in der Tabelle jeder Botschaft die passende Seite der Nachricht nach Schulz von Thun zu.',
    zeilen: [
      ['Botschaft', 'Seite der Nachricht'],
      [
        'Der Drucker am Empfang druckt nicht.',
        wahl('Sachinhalt', [
          'Selbstoffenbarung',
          'Beziehung',
          'Appell',
        ], 'Eine überprüfbare Tatsache: reine Sachinformation.'),
      ],
      [
        'Ich bin genervt und stehe unter Zeitdruck.',
        wahl(
          'Selbstoffenbarung',
          ['Sachinhalt', 'Beziehung', 'Appell'],
          'Die Absenderin gibt etwas über sich selbst preis.',
        ),
      ],
      [
        'Auf euren Support kann man sich nicht verlassen.',
        wahl(
          'Beziehung',
          ['Sachinhalt', 'Selbstoffenbarung', 'Appell'],
          'Sagt, was sie vom Empfänger hält: „schon wieder“ klingt nach Vorwurf.',
        ),
      ],
      [
        'Kümmert euch sofort darum!',
        wahl('Appell', [
          'Sachinhalt',
          'Selbstoffenbarung',
          'Beziehung',
        ], 'Die Aufforderung, etwas zu tun.'),
      ],
    ],
    punkte: 4,
    explanation:
        'Jede Nachricht hat vier Seiten: Sachinhalt (worüber informiere ich), Selbstoffenbarung (was zeige ich von mir), Beziehung (wie stehe ich zu dir) und Appell (was sollst du tun). Im Support zählen zuerst Sachinhalt und Appell.',
  ),
  freitext(
    'i2-km-2',
    'k-modelle',
    scenario:
        'Ein Techniker der Pixelhafen Medien GmbH ruft aus dem Auto bei schlechter Verbindung eine Kundin an: „Ihr CMS braucht ein Update, sonst läuft das Plugin nicht mehr.“ Die Kundin versteht nur Bruchstücke und weiß nicht, was ein CMS ist. Der Techniker legt auf, ohne nachzufragen.',
    prompt:
        'Beschreibe anhand des Sender-Empfänger-Modells zwei Ursachen für das Missverständnis.',
    kriterien: [
      krit(
        'Störung im Kanal: Die schlechte Telefonverbindung verfälscht die Nachricht auf dem Weg zur Empfängerin.',
        punkte: 2,
        stichwoerter: [
          'Kanal',
          'Verbindung',
          'Störung',
          'Rauschen',
          'Empfang',
          'gestört',
        ],
      ),
      krit(
        'Kein gemeinsamer Zeichenvorrat: Die Kundin kennt die Fachbegriffe (CMS, Plugin) nicht und kann die Nachricht nicht entschlüsseln.',
        punkte: 2,
        stichwoerter: [
          'Zeichenvorrat',
          'Fachbegriff',
          'Fachsprache',
          'decodieren',
          'entschlüsseln',
          'Fachwort',
        ],
      ),
      krit(
        'Fehlende Rückmeldung: Der Techniker prüft nicht, ob die Nachricht richtig angekommen ist.',
        punkte: 2,
        stichwoerter: [
          'Rückmeldung',
          'Feedback',
          'nachfragen',
          'Rückfrage',
          'Kontrollfrage',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Erstens ist der Kanal gestört: Durch die schlechte Verbindung kommt nur ein Teil der Nachricht an. Zweitens fehlt ein gemeinsamer Zeichenvorrat: Die Kundin kennt die Fachbegriffe CMS und Plugin nicht und kann die Nachricht deshalb nicht entschlüsseln. Außerdem fehlt die Rückmeldung: Der Techniker fragt nicht nach, ob sie ihn verstanden hat.',
    explanation:
        'Je beschriebener Ursache 2 Punkte, höchstens 4. Das Sender-Empfänger-Modell kennt drei typische Fehlerquellen: Störungen im Kanal, fehlender gemeinsamer Zeichenvorrat (Codieren und Decodieren) und fehlende Rückmeldung.',
  ),
  lueckentext(
    'i2-km-3',
    'k-modelle',
    scenario:
        'In der IT-Abteilung der Elbtal Logistik AG streiten zwei Administratoren seit Wochen über die Benennung von Servern. Die Teamleiterin vermutet, dass es eigentlich um etwas anderes geht.',
    prompt: 'Setze die passenden Begriffe nach Watzlawick ein.',
    text:
        'Nach Watzlawick hat jede Kommunikation einen {0} und einen {1}. Der Inhalt sind die Zahlen, Daten und Fakten, über die gesprochen wird. Die Beziehung zeigt sich vor allem in {2} und Tonfall. Sie {3} darüber, wie eine Sachaussage ankommt. Ein Dauerstreit über eine Kleinigkeit ist deshalb oft ein Zeichen für einen verdeckten {4}.',
    luecken: [
      wort(['Inhaltsaspekt'], 'Das, worüber gesprochen wird.'),
      wort(['Beziehungsaspekt'], 'Wie die Gesprächspartner zueinander stehen.'),
      wort(['Gefühlen'], 'Gefühle gehören zur Beziehungsebene.'),
      wort(['entscheidet'], 'Die Beziehung bestimmt, wie der Inhalt ankommt.'),
      wort([
        'Beziehungskonflikt',
      ], 'Der Sachstreit überdeckt das eigentliche Problem.'),
    ],
    wortbank: ['Kanalstörung', 'Zeichenvorrat', 'Appell'],
    punkte: 5,
    explanation:
        'Das 2. Axiom nach Watzlawick: Jede Kommunikation hat einen Inhalts- und einen Beziehungsaspekt, wobei der Beziehungsaspekt den Inhaltsaspekt bestimmt. Solange nur über Servernamen gestritten wird, bleibt der eigentliche Konflikt ungelöst.',
  ),

  // ======================================================== Gesprächsführung
  paare(
    'i2-kg-1',
    'k-gespraech',
    scenario:
        'Du bereitest bei der Kessler & Brandt IT-Systemhaus GmbH das Erstgespräch mit der Steuerkanzlei Albers & Partner vor und planst den Ablauf.',
    prompt: 'Ordne jeder Gesprächsphase ihr Ziel zu.',
    paare: [
      paar('Kontakt und Begrüßung', 'Vertrauen aufbauen, Gesprächsziel nennen'),
      paar('Bedarfsermittlung', 'Ist-Situation, Ziele und Rahmen klären'),
      paar('Lösung mit Nutzen', 'Vorschlag am Kundenproblem begründen'),
      paar('Einwände klären', 'Bedenken ernst nehmen und ausräumen'),
      paar('Abschluss', 'nächste Schritte verbindlich vereinbaren'),
      paar('Nachbereitung', 'Gesprächsnotiz und Angebot erstellen'),
    ],
    punkte: 3,
    explanation:
        'Jede Phase hat ein eigenes Ziel. Wer die Bedarfsermittlung überspringt, bietet eine Lösung an, die nicht zum Problem passt; ohne Abschluss bleibt offen, wie es weitergeht.',
  ),
  markieren(
    'i2-kg-2',
    'k-gespraech',
    scenario:
        'Gesprächsprotokoll aus dem IT-Support der Grünwerk Gartenbedarf GmbH: Eine Filialmitarbeiterin meldet aufgeregt, dass die Kasse keine Bons mehr druckt. Notiert sind die Äußerungen des Supporters (S).',
    prompt:
        'Markiere alle Äußerungen des Supporters, die Gesprächsstörer sind.',
    zeilen: [
      ja(
        'S: „Das kann gar nicht sein, gestern lief die Kasse noch.“',
        'Widersprechen stellt die Kundin infrage.',
      ),
      nein(
        'S: „Seit wann genau druckt die Kasse keine Bons mehr?“',
        'Eine gezielte Nachfrage fördert das Gespräch.',
      ),
      ja(
        'S: „Das steht alles in der Anleitung, die wir verschickt haben.“',
        'Belehren wirkt von oben herab.',
      ),
      nein(
        'S: „Sie meinen also, dass der Druck nach dem Bezahlen gar nicht erst startet?“',
        'Zusammenfassen mit eigenen Worten sichert das Verständnis.',
      ),
      ja(
        'S: „Ist ja nur ein Bondrucker, da gibt es Schlimmeres.“',
        'Bagatellisieren nimmt das Anliegen nicht ernst.',
      ),
      nein(
        'S: „Ich verstehe, dass das bei vollem Laden sehr ärgerlich ist.“',
        'Den Ärger anzuerkennen beruhigt die Beziehungsebene.',
      ),
      ja(
        'S: „Moment, lassen Sie mich mal. Ich erkläre Ihnen jetzt, wie so ein Drucker funktioniert.“',
        'Unterbrechen und ungefragtes Dozieren blockieren das Gespräch.',
      ),
    ],
    punkte: 4,
    explanation:
        'Gesprächsstörer sind Widersprechen, Belehren, Bagatellisieren und Unterbrechen. Gesprächsförderer sind Nachfragen, Zusammenfassen und das Anerkennen von Gefühlen.',
  ),
  freitext(
    'i2-kg-3',
    'k-gespraech',
    scenario:
        'Ein Kunde der Pixelhafen Medien GmbH beschwert sich aufgebracht am Telefon: Seine neue Website sei „eine Katastrophe“, die Bestellungen kämen nicht mehr an.',
    prompt:
        'Beschreibe zwei Verhaltensweisen, mit denen du dieses Beschwerdegespräch zielführend führst.',
    kriterien: [
      krit(
        'Ärger anerkennen statt rechtfertigen: Beziehungsebene beruhigen („Das ist ärgerlich, wenn Bestellungen fehlen.“).',
        punkte: 2,
        stichwoerter: [
          'Ärger',
          'Verständnis',
          'anerkennen',
          'Gefühl',
          'Beziehung',
        ],
      ),
      krit(
        'Sachverhalt gezielt klären: nachfragen, seit wann und was genau nicht ankommt.',
        punkte: 2,
        stichwoerter: [
          'nachfragen',
          'seit wann',
          'klären',
          'Frage',
          'Fehlermeldung',
        ],
      ),
      krit(
        'Ergebnis zusammenfassen und bestätigen lassen.',
        punkte: 2,
        stichwoerter: [
          'zusammenfassen',
          'bestätigen',
          'eigenen Worten',
          'wiedergeben',
        ],
      ),
      krit(
        'Ausreden lassen, keine Gesprächsstörer (nicht unterbrechen, belehren, bagatellisieren).',
        punkte: 2,
        stichwoerter: ['ausreden', 'unterbrechen', 'belehren', 'Störer'],
      ),
      krit(
        'Nächsten Schritt verbindlich zusagen (Prüfung, Rückruf mit Uhrzeit).',
        punkte: 2,
        stichwoerter: [
          'Rückruf',
          'zusagen',
          'nächster Schritt',
          'Uhr',
          'verbindlich',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Ich lasse den Kunden ausreden und erkenne seinen Ärger an: „Das ist ärgerlich, wenn keine Bestellungen ankommen.“ Dann kläre ich sachlich nach: „Seit wann fehlen die Bestellungen, und erscheint eine Fehlermeldung?“ Zum Schluss sage ich einen konkreten nächsten Schritt zu, etwa einen Rückruf bis 15 Uhr.',
    explanation:
        'Je beschriebener Verhaltensweise 2 Punkte, höchstens 4. Bei Beschwerden zuerst die Beziehungsebene beruhigen, dann die Sache klären und verbindlich abschließen.',
  ),
  lueckentext(
    'i2-kg-4',
    'k-gespraech',
    scenario:
        'Du sprichst für die IT-Abteilung der Elbtal Logistik AG mit dem Leiter der Disposition über neue Arbeitsplatzrechner.',
    prompt: 'Wähle für jede Lücke den passenden Begriff.',
    text:
        'Nach der Begrüßung beginnt die {0}. Du lässt dir zuerst die {1} schildern: „Wie arbeiten Ihre Disponenten heute?“ Danach klärst du {2} wie Budget und Termin. Bevor du eine Lösung vorschlägst, {3} du das Ergebnis und lässt es bestätigen. Die Lösung begründest du mit ihrem {4} für den Kunden.',
    luecken: [
      wahl('Bedarfsermittlung', [
        'Nachbereitung',
        'Einwandbehandlung',
      ], 'Hier wird geklärt, was der Kunde braucht.'),
      wahl('Ist-Situation', [
        'Lösung',
        'Rechnung',
      ], 'Wie heute gearbeitet wird.'),
      wahl('Rahmenbedingungen', [
        'Einwände',
        'Gesprächsstörer',
      ], 'Budget, Termin, Nutzerzahl.'),
      wahl('fasst zusammen', [
        'verkaufst',
        'bagatellisierst',
      ], 'Sichert, dass du richtig verstanden hast.'),
      wahl('Nutzen', [
        'Preis',
        'Merkmal',
      ], 'Merkmal allein überzeugt nicht. Der Nutzen schon.'),
    ],
    punkte: 5,
    explanation:
        'Erst verstehen, dann lösen: Die Bedarfsermittlung klärt Ist-Situation, Ziele und Rahmen. Eine Zusammenfassung sichert das Verständnis, dann wird die Lösung mit ihrem Nutzen begründet.',
  ),

  // ============================================ Kunden beraten und betreuen
  freitext(
    'i2-kk-1',
    'k-kunde',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH hat am Freitag die Postfächer eines englischsprachigen Kunden auf einen neuen Mailserver umgezogen. Am Montag trifft diese E-Mail ein.',
    code:
        'Subject: Problems after the migration\n\n'
        'Hello support team,\n'
        'since you moved our mailboxes to the new\n'
        'server last Friday, three things do not\n'
        'work anymore: Our shared calendar is empty,\n'
        'two colleagues cannot send e-mails with\n'
        'attachments larger than 5 MB, and the\n'
        'out-of-office replies are sent twice.\n'
        'We lose time every day. Please call me\n'
        'before 4 pm today.\n\n'
        'Kind regards\n'
        'Sarah Miller, Office Manager',
    prompt: 'Nenne die drei Probleme, die die Kundin in der E-Mail beschreibt.',
    kriterien: [
      krit(
        'Der gemeinsame Kalender ist leer.',
        stichwoerter: ['Kalender', 'calendar', 'Termine'],
      ),
      krit(
        'Zwei Kollegen können keine E-Mails mit Anhängen über 5 MB senden.',
        stichwoerter: [
          'Anhang',
          'Anhänge',
          'attachment',
          '5 MB',
          'Dateianhang',
        ],
      ),
      krit(
        'Abwesenheitsnotizen werden doppelt verschickt.',
        stichwoerter: [
          'Abwesenheit',
          'out-of-office',
          'doppelt',
          'zweimal',
          'Abwesenheitsnotiz',
        ],
      ),
    ],
    loesung:
        'Erstens ist der gemeinsame Kalender leer. Zweitens können zwei Kollegen keine E-Mails mit Anhängen über 5 MB versenden. Drittens werden die Abwesenheitsnotizen doppelt verschickt.',
    explanation:
        'Je Nennung 1 Punkt. Vokabeln: shared calendar = gemeinsamer Kalender, attachment = Anhang, out-of-office reply = Abwesenheitsnotiz, twice = zweimal. Geantwortet wird wie in der Prüfung auf Deutsch.',
  ),
  freitext(
    'i2-kk-2',
    'k-kunde',
    scenario:
        'Bei der Kessler & Brandt IT-Systemhaus GmbH trifft am Montagmorgen die Beschwerde einer Kundin ein. Seit dem Umzug ihrer Postfächer funktionieren drei Dinge nicht mehr.',
    code:
        '... We lose time every day.\n'
        'Please call me before 4 pm today.\n\n'
        'Kind regards\n'
        'Sarah Miller, Office Manager',
    prompt:
        'Beschreibe zwei Schritte, mit denen du professionell auf diese Beschwerde reagierst.',
    kriterien: [
      krit(
        'Wie gewünscht noch heute vor 16 Uhr zurückrufen und die Probleme mit Fragen klären.',
        punkte: 2,
        stichwoerter: [
          'zurückrufen',
          'Rückruf',
          'anrufen',
          '16 Uhr',
          'Telefon',
        ],
      ),
      krit(
        'Verständnis zeigen und sich für die Unannehmlichkeiten entschuldigen.',
        punkte: 2,
        stichwoerter: [
          'Verständnis',
          'entschuldigen',
          'bedauern',
          'ernst nehmen',
        ],
      ),
      krit(
        'Ticket anlegen, priorisieren und eine Lösung mit Termin zusagen.',
        punkte: 2,
        stichwoerter: ['Ticket', 'priorisieren', 'Lösung', 'Termin', 'zusagen'],
      ),
      krit(
        'Nach der Behebung nachfassen und die Ursache dokumentieren.',
        punkte: 2,
        stichwoerter: ['nachfassen', 'dokumentieren', 'Ursache', 'bestätigen'],
      ),
    ],
    punkte: 4,
    loesung:
        'Ich rufe die Kundin wie gewünscht noch heute vor 16 Uhr zurück, zeige Verständnis für den Ärger und kläre die drei Probleme mit gezielten Fragen. Danach lege ich ein Ticket mit hoher Priorität an, nenne ihr einen verbindlichen Termin für die Lösung und frage nach der Behebung nach, ob alles wieder funktioniert.',
    explanation:
        'Je beschriebenem Schritt 2 Punkte, höchstens 4. Beschwerdebehandlung: zuhören, Verständnis zeigen, Sachverhalt klären, Lösung mit Termin anbieten, umsetzen und nachfassen. Wichtig: den Rückrufwunsch (before 4 pm = vor 16 Uhr) einhalten.',
  ),
  freitext(
    'i2-kk-3',
    'k-kunde',
    scenario:
        'Im Webshop der Grünwerk Gartenbedarf GmbH bleiben Kundenbeschwerden über verspätete Lieferungen seit Wochen unbeantwortet. In einem Bewertungsportal häufen sich Ein-Sterne-Bewertungen.',
    prompt:
        'Erläutere zwei wirtschaftliche Folgen, die dem Unternehmen dadurch drohen.',
    kriterien: [
      krit(
        'Imageverlust: Schlechte Bewertungen schrecken mögliche Neukunden ab.',
        punkte: 2,
        stichwoerter: [
          'Image',
          'Bewertung',
          'Reputation',
          'Ansehen',
          'schlechter Ruf',
        ],
      ),
      krit(
        'Kunden wandern zur Konkurrenz ab, der Umsatz sinkt.',
        punkte: 2,
        stichwoerter: [
          'abwandern',
          'Umsatz',
          'Konkurrenz',
          'wechseln',
          'Kunden verlieren',
        ],
      ),
      krit(
        'Stammkunden bestellen nicht wieder und empfehlen den Shop nicht weiter.',
        punkte: 2,
        stichwoerter: [
          'weiterempfehlen',
          'Stammkunden',
          'Empfehlung',
          'Folgeaufträge',
        ],
      ),
      krit(
        'Neue Kunden zu gewinnen kostet mehr (Werbung, Rabatte) als bestehende zu halten.',
        punkte: 2,
        stichwoerter: ['Neukunden', 'Werbung', 'Werbekosten', 'Akquise'],
      ),
    ],
    punkte: 4,
    loesung:
        'Erstens droht ein Imageverlust: Die schlechten Bewertungen sind öffentlich und schrecken neue Kunden ab. Zweitens wandern verärgerte Kunden zu Wettbewerbern ab. Der Umsatz sinkt, und Weiterempfehlungen bleiben aus. Verlorene Kunden zurückzugewinnen kostet zusätzlich Geld für Werbung und Rabatte.',
    explanation:
        'Je erläuterter Folge 2 Punkte, höchstens 4. Unbeantwortete Beschwerden kosten doppelt: durch Imageverlust nach außen und durch Abwanderung der bestehenden Kunden. Ein Beschwerdemanagement ist deshalb auch wirtschaftlich sinnvoll.',
  ),

  // ============================================== Teamphasen nach Tuckman
  tabelle(
    'i2-tt-1',
    'te-phasen',
    scenario:
        'Bei der Pixelhafen Medien GmbH führt ein Team aus fünf Personen das neue Ticketsystem ein. Die Projektleiterin notiert über mehrere Wochen ihre Beobachtungen.',
    prompt:
        'Trage zu jeder Beobachtung die Teamphase nach Tuckman und die passende Aufgabe der Leitung ein.',
    zeilen: [
      ['Beobachtung', 'Phase', 'Aufgabe der Leitung'],
      [
        'Alle sind höflich und warten ab.',
        wahl('Forming', ['Storming', 'Norming', 'Performing']),
        wahl('Ziele und Aufgaben erklären', [
          'Konflikte moderieren',
          'Regeln festhalten',
          'Freiraum geben',
        ]),
      ],
      [
        'Zwei streiten, wessen Konzept gilt.',
        wahl('Storming', ['Forming', 'Norming', 'Performing']),
        wahl('Konflikte moderieren', [
          'Ziele und Aufgaben erklären',
          'Regeln festhalten',
          'Freiraum geben',
        ]),
      ],
      [
        'Das Team legt fest, wie Tickets benannt werden.',
        wahl('Norming', ['Forming', 'Storming', 'Performing']),
        wahl('Regeln festhalten', [
          'Ziele und Aufgaben erklären',
          'Konflikte moderieren',
          'Freiraum geben',
        ]),
      ],
      [
        'Die Arbeit läuft selbstständig und zügig.',
        wahl('Performing', ['Forming', 'Storming', 'Norming']),
        wahl('Freiraum geben', [
          'Ziele und Aufgaben erklären',
          'Konflikte moderieren',
          'Regeln festhalten',
        ]),
      ],
    ],
    punkte: 4,
    explanation:
        'Forming: Orientierung. Die Leitung gibt Ziele und Struktur vor. Storming: Machtkämpfe. Die Leitung moderiert. Norming: Regeln entstehen. Die Leitung hält sie fest. Performing: Das Team arbeitet eingespielt. Die Leitung gibt Freiraum.',
  ),
  freitext(
    'i2-tt-2',
    'te-phasen',
    scenario:
        'Für die Anbindung der neuen Lagerhalle stellt die Elbtal Logistik AG ein Projektteam aus sechs Personen zusammen, die sich bisher kaum kennen. Morgen ist das erste Treffen.',
    prompt:
        'Beschreibe zwei Maßnahmen, mit denen die Projektleitung das Team in der Forming-Phase unterstützt.',
    kriterien: [
      krit(
        'Kennenlernen ermöglichen, z. B. mit einer Vorstellungsrunde im Kick-off.',
        punkte: 2,
        stichwoerter: [
          'kennenlernen',
          'Vorstellungsrunde',
          'Kick-off',
          'vorstellen',
        ],
      ),
      krit(
        'Ziele und Auftrag des Projekts klar erklären.',
        punkte: 2,
        stichwoerter: ['Ziel', 'Auftrag', 'Projektziel', 'Erwartungen'],
      ),
      krit(
        'Aufgaben und Zuständigkeiten vorgeben, damit alle Orientierung haben.',
        punkte: 2,
        stichwoerter: [
          'Zuständigkeit',
          'Aufgabenverteilung',
          'Rollenverteilung',
          'Orientierung',
          'Struktur',
        ],
      ),
      krit(
        'Erste Regeln der Zusammenarbeit und Kommunikationswege festlegen.',
        punkte: 2,
        stichwoerter: [
          'Regeln',
          'Kommunikationswege',
          'Ansprechpartner',
          'Termine',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Die Projektleitung beginnt mit einer Vorstellungsrunde, damit sich alle kennenlernen und Unsicherheit abbauen. Außerdem erklärt sie Ziel und Auftrag des Projekts und verteilt die ersten Aufgaben klar, denn in der Forming-Phase braucht das Team Orientierung und Struktur von der Leitung.',
    explanation:
        'Je beschriebener Maßnahme 2 Punkte, höchstens 4. Im Forming sind die Mitglieder höflich, unsicher und abwartend. Die Leitung führt deshalb eng: kennenlernen lassen, Ziele erklären, Aufgaben und Regeln vorgeben.',
  ),
  markieren(
    'i2-tt-3',
    'te-phasen',
    scenario:
        'Auszug aus dem Projekttagebuch eines Teams der Grünwerk Gartenbedarf GmbH, das die IT der neuen Filiale in Göttingen plant.',
    prompt: 'Markiere alle Einträge, die auf die Storming-Phase hinweisen.',
    zeilen: [
      ja(
        'Zwei Kollegen diskutieren lautstark, wer die Netzplanung leiten darf.',
        'Machtkampf um Rollen: typisch für Storming.',
      ),
      nein(
        'Beim ersten Treffen stellen sich alle vor und bleiben zurückhaltend.',
        'Höflich und abwartend. Das ist Forming.',
      ),
      ja(
        'Die vorgeschlagene Aufgabenverteilung wird offen infrage gestellt.',
        'Zuständigkeiten werden ausgehandelt: Storming.',
      ),
      nein(
        'Das Team einigt sich auf feste Regeln für die Dokumentation.',
        'Gemeinsame Regeln entstehen im Norming.',
      ),
      ja(
        'Es bilden sich zwei Lager, die jeweils ihr eigenes Konzept durchsetzen wollen.',
        'Cliquenbildung und Streit um Ideen - Storming.',
      ),
      nein(
        'Jeder kennt seine Aufgabe, Probleme löst das Team selbstständig.',
        'Eingespielte Zusammenarbeit - Performing.',
      ),
    ],
    explanation:
        'In der Storming-Phase ringen die Mitglieder um Rollen, Einfluss und Ideen: Es gibt Machtkämpfe, Lagerbildung und offene Kritik an der Aufgabenverteilung. Die Leitung moderiert, bis das Team im Norming Regeln findet.',
  ),

  // ============================================ Feedback und Fehlerkultur
  markieren(
    'i2-tf-1',
    'te-feedback',
    scenario:
        'Protokoll eines Feedbackgesprächs bei der Kessler & Brandt IT-Systemhaus GmbH: Ein Ausbilder gibt einem Auszubildenden Rückmeldung zum gestrigen Einsatz in der Steuerkanzlei Albers & Partner.',
    prompt: 'Markiere alle Aussagen, die gegen die Feedbackregeln verstoßen.',
    zeilen: [
      ja(
        '„Du bist einfach unzuverlässig.“',
        'Bewertet die Person statt ein konkretes Verhalten.',
      ),
      nein(
        '„Mir ist aufgefallen, dass gestern das Übergabeprotokoll gefehlt hat.“',
        'Konkrete, zeitnahe Beobachtung als Ich-Botschaft.',
      ),
      ja(
        '„Immer vergisst du die Dokumentation.“',
        'Die Verallgemeinerung „immer“ wirkt als Vorwurf.',
      ),
      nein(
        '„Dadurch musste die Kanzlei heute noch einmal bei uns nachfragen.“',
        'Beschreibt sachlich die Wirkung.',
      ),
      ja(
        '„Das hätte ich dir schon im Frühjahr sagen müssen.“',
        'Feedback soll zeitnah kommen, nicht Monate später.',
      ),
      ja(
        '„Die anderen im Team finden das übrigens auch.“',
        'Feedback gibt man aus eigener Wahrnehmung, nicht im Namen anderer.',
      ),
      nein(
        '„Ich wünsche mir, dass du das Protokoll direkt vor Ort ausfüllst.“',
        'Ein konkreter, umsetzbarer Wunsch.',
      ),
    ],
    punkte: 4,
    explanation:
        'Gutes Feedback ist konkret, zeitnah, beschreibend und eine Ich-Botschaft: Wahrnehmung, Wirkung, Wunsch. Verstöße sind Bewertungen der Person, Verallgemeinerungen („immer“), verspätete Kritik und das Berufen auf andere.',
  ),
  freitext(
    'i2-tf-2',
    'te-feedback',
    scenario:
        'Deine Kollegin in der IT der Elbtal Logistik AG hat in dieser Woche zweimal Handscanner ausgegeben, ohne sie in die Inventarliste einzutragen. Heute wurde deshalb ein Gerät eine Stunde lang gesucht.',
    prompt:
        'Formuliere ein Feedback an die Kollegin nach der WWW-Methode (Wahrnehmung, Wirkung, Wunsch).',
    kriterien: [
      krit(
        'Wahrnehmung: konkrete Beobachtung ohne Wertung („Mir ist aufgefallen, dass zweimal der Eintrag in der Inventarliste fehlte“).',
        stichwoerter: [
          'aufgefallen',
          'beobachtet',
          'gesehen',
          'bemerkt',
          'wahrgenommen',
          'festgestellt',
        ],
      ),
      krit(
        'Wirkung: Folge der Beobachtung („Dadurch haben wir heute eine Stunde nach einem Gerät gesucht“).',
        stichwoerter: [
          'dadurch',
          'deshalb',
          'deswegen',
          'führt dazu',
          'Folge',
          'gesucht',
        ],
      ),
      krit(
        'Wunsch: konkrete Bitte für die Zukunft („Ich wünsche mir, dass du jede Ausgabe sofort einträgst“).',
        stichwoerter: [
          'wünsche',
          'bitte',
          'Wunsch',
          'künftig',
          'in Zukunft',
          'möchte',
        ],
      ),
    ],
    loesung:
        '„Mir ist aufgefallen, dass diese Woche zweimal ein Handscanner ausgegeben wurde, ohne dass er in der Inventarliste steht. Dadurch haben wir heute eine Stunde nach einem Gerät gesucht. Ich wünsche mir, dass du jede Ausgabe sofort einträgst.“',
    explanation:
        'Je Teil 1 Punkt: Wahrnehmung (konkret, ohne „immer“ und ohne Bewertung der Person), Wirkung (was daraus folgte) und Wunsch (was sich ändern soll). Alles als Ich-Botschaft.',
  ),
  freitext(
    'i2-tf-3',
    'te-feedback',
    scenario:
        'Bei der Pixelhafen Medien GmbH hat ein Entwickler versehentlich die Live-Website eines Kunden überschrieben und den Fehler erst nach zwei Tagen gemeldet, und zwar aus Angst vor Ärger. Die Geschäftsführung will die Fehlerkultur verbessern.',
    prompt:
        'Erläutere zwei Vorteile einer offenen Fehlerkultur für die Agentur.',
    kriterien: [
      krit(
        'Fehler werden sofort gemeldet, der Schaden bleibt kleiner.',
        punkte: 2,
        stichwoerter: [
          'früh',
          'sofort',
          'Schaden',
          'rechtzeitig',
          'schnell gemeldet',
        ],
      ),
      krit(
        'Aus Fehlern wird gelernt (Lessons Learned), sie wiederholen sich nicht.',
        punkte: 2,
        stichwoerter: [
          'lernen',
          'Lessons Learned',
          'wiederholen',
          'gelernt',
          'Lernchance',
        ],
      ),
      krit(
        'Ursachen werden gesucht und Abläufe verbessert, die Qualität steigt.',
        punkte: 2,
        stichwoerter: [
          'Ursache',
          'Prozess',
          'Ablauf',
          'Qualität',
          'verbessern',
        ],
      ),
      krit(
        'Weniger Angst und mehr Vertrauen im Team.',
        punkte: 2,
        stichwoerter: ['Angst', 'Vertrauen', 'Zusammenarbeit', 'Betriebsklima'],
      ),
    ],
    punkte: 4,
    loesung:
        'Wenn niemand Angst vor Schuldzuweisungen haben muss, werden Fehler sofort gemeldet. Die Website wäre nach Minuten statt nach zwei Tagen wiederhergestellt worden, und der Schaden wäre kleiner. Außerdem wird nach der Ursache gesucht, etwa nach einer fehlenden Freigabe vor dem Einspielen. So lernt das ganze Team daraus und der Fehler wiederholt sich nicht.',
    explanation:
        'Je erläutertem Vorteil 2 Punkte, höchstens 4. In einer guten Fehlerkultur gelten Fehler als Lernchance: Es wird nach Ursachen gefragt, nicht nach Schuldigen. Vertuschte Fehler werden dagegen größer.',
  ),

  // ============================================== Konflikte und Vielfalt
  lueckentext(
    'i2-tk-1',
    'te-konflikte',
    scenario:
        'Zwei Schichtleiter der Elbtal Logistik AG streiten seit Monaten über die Verteilung der Handscanner. Inzwischen suchen beide Verbündete in ihren Teams und reden schlecht übereinander.',
    prompt: 'Ergänze die Angaben zum Eskalationsmodell nach Glasl.',
    text:
        'Glasl beschreibt {0} Eskalationsstufen in {1} Hauptphasen. Wer Verbündete sucht, steht auf Stufe 4 (Images und Koalitionen) und damit in der Phase {2}. In dieser Phase braucht es meist {3}. In der letzten Phase, {4}, nehmen beide sogar eigenen Schaden in Kauf.',
    luecken: [
      zahl(9, rationale: 'Von „Verhärtung“ bis „gemeinsam in den Abgrund“.'),
      zahl(3, rationale: 'win-win, win-lose und lose-lose mit je drei Stufen.'),
      wahl('win-lose', [
        'win-win',
        'lose-lose',
      ], 'Stufe 4 bis 6: Einer soll gewinnen, der andere verlieren.'),
      wahl('einen neutralen Dritten', [
        'mehr Zeit',
        'eine Abmahnung',
      ], 'Etwa eine Moderation oder Mediation.'),
      wahl('lose-lose', [
        'win-win',
        'win-lose',
      ], 'Stufe 7 bis 9: Hauptsache, der andere verliert mehr.'),
    ],
    punkte: 5,
    explanation:
        'Glasl: 9 Stufen in 3 Phasen. Stufe 1-3 (win-win) lösen die Beteiligten noch selbst. Stufe 4-6 (win-lose) brauchen meist einen neutralen Dritten. Stufe 7-9 (lose-lose) lassen sich nur noch durch einen Machteingriff von außen stoppen.',
    difficulty: 3,
  ),
  freitext(
    'i2-tk-2',
    'te-konflikte',
    scenario:
        'In der IT-Abteilung der Grünwerk Gartenbedarf GmbH beanspruchen zwei Kollegen denselben Testserver und sprechen kaum noch miteinander. Die Abteilungsleiterin lädt beide zu einem Konfliktgespräch ein.',
    prompt:
        'Beschreibe zwei Schritte, mit denen das Konfliktgespräch zu einer tragfähigen Lösung führt.',
    kriterien: [
      krit(
        'Beide schildern nacheinander ihre Sichtweise, ohne unterbrochen zu werden.',
        punkte: 2,
        stichwoerter: [
          'Sichtweise',
          'schildern',
          'ausreden',
          'Standpunkt',
          'anhören',
          'zuhören',
        ],
      ),
      krit(
        'Die Interessen hinter den Forderungen klären (Wozu wird der Server wann gebraucht?).',
        punkte: 2,
        stichwoerter: [
          'Interesse',
          'Bedürfnis',
          'wozu',
          'Hintergrund',
          'warum',
        ],
      ),
      krit(
        'Gemeinsam Lösungen sammeln und eine auswählen, die beide mittragen (Konsens).',
        punkte: 2,
        stichwoerter: [
          'Lösung',
          'Konsens',
          'gemeinsam',
          'Vorschläge',
          'Optionen',
        ],
      ),
      krit(
        'Die Vereinbarung festhalten und später überprüfen.',
        punkte: 2,
        stichwoerter: [
          'Vereinbarung',
          'festhalten',
          'überprüfen',
          'schriftlich',
          'kontrollieren',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Zuerst schildern beide nacheinander ihre Sicht, ohne unterbrochen zu werden. Die Abteilungsleiterin moderiert. Danach klärt sie die Interessen: Wozu und wann braucht jeder den Server? Auf dieser Grundlage sammeln alle gemeinsam Lösungen, etwa einen zweiten virtuellen Testserver, und halten die Vereinbarung fest.',
    explanation:
        'Je beschriebenem Schritt 2 Punkte, höchstens 4. Ein Konfliktgespräch läuft so: Sichtweisen anhören, Interessen klären, Lösungen sammeln, Vereinbarung treffen und später überprüfen. Ziel ist der Konsens, nicht ein fauler Kompromiss.',
  ),
  markieren(
    'i2-tk-3',
    'te-konflikte',
    scenario:
        'Die Pixelhafen Medien GmbH sucht Verstärkung für die IT-Administration. Der Entwurf der Stellenanzeige enthält die folgenden Formulierungen.',
    prompt:
        'Markiere alle Formulierungen, die gegen das Allgemeine Gleichbehandlungsgesetz (AGG) verstoßen können.',
    zeilen: [
      ja(
        '„Höchstalter 30 Jahre“',
        'Benachteiligung wegen des Alters ohne sachlichen Grund.',
      ),
      nein(
        '„Fachinformatiker/in (m/w/d) für Systemintegration“',
        'Geschlechtsneutral formuliert, die Qualifikation ist eine sachliche Anforderung.',
      ),
      ja(
        '„Deutsch als Muttersprache“',
        'Benachteiligt mittelbar wegen der ethnischen Herkunft: zulässig wäre „sehr gute Deutschkenntnisse“.',
      ),
      nein(
        '„Sehr gute Deutschkenntnisse in Wort und Schrift“',
        'Eine Anforderung der Tätigkeit, die jeder unabhängig von der Herkunft erfüllen kann.',
      ),
      ja(
        '„Wir suchen einen belastbaren jungen Mann“',
        'Benachteiligung wegen Geschlecht und Alter.',
      ),
      nein(
        '„Führerschein Klasse B für Kundeneinsätze erforderlich“',
        'Sachlich durch die Tätigkeit begründet.',
      ),
    ],
    explanation:
        'Das AGG verbietet Benachteiligungen wegen ethnischer Herkunft, Geschlecht, Religion oder Weltanschauung, Behinderung, Alter und sexueller Identität. Stellenanzeigen müssen deshalb neutral formuliert sein; Anforderungen brauchen einen sachlichen Bezug zur Tätigkeit.',
  ),

  // ====================================================== Das Harvard-Konzept
  tabelle(
    'i2-vh-1',
    've-harvard',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH verhandelt mit der Steuerkanzlei Albers & Partner über einen Wartungsvertrag. Du notierst Aussagen aus dem Gespräch.',
    prompt: 'Ordne jede Aussage nach dem Harvard-Konzept ein.',
    zeilen: [
      ['Aussage', 'Einordnung'],
      [
        '„Wir zahlen höchstens 400 € im Monat.“',
        wahl('Position', [
          'Interesse',
          'Option',
          'neutrales Kriterium',
        ], 'Eine feste Forderung.'),
      ],
      [
        '„In der Abgabefrist darf unsere IT keinen Tag ausfallen.“',
        wahl('Interesse', [
          'Position',
          'Option',
          'neutrales Kriterium',
        ], 'Das eigentliche Bedürfnis hinter den Forderungen.'),
      ],
      [
        '„Wir könnten die kurze Reaktionszeit nur von Januar bis Mai vereinbaren.“',
        wahl('Option', [
          'Position',
          'Interesse',
          'neutrales Kriterium',
        ], 'Ein Lösungsvorschlag, der beiden nützt.'),
      ],
      [
        '„Schauen wir, was vergleichbare Verträge am Markt kosten.“',
        wahl(
          'neutrales Kriterium',
          ['Position', 'Interesse', 'Option'],
          'Ein objektiver Maßstab, den beide anerkennen können.',
        ),
      ],
      [
        '„Die Reaktionszeit muss immer eine Stunde betragen.“',
        wahl('Position', [
          'Interesse',
          'Option',
          'neutrales Kriterium',
        ], 'Wieder eine Forderung. Das Warum bleibt offen.'),
      ],
    ],
    punkte: 5,
    explanation:
        'Positionen sind Forderungen, Interessen die Gründe dahinter. Wer das Interesse kennt (kein Ausfall in der Abgabefrist), findet Optionen, die beiden nützen (hier eine gestaffelte Reaktionszeit). Marktpreise sind ein neutrales Kriterium.',
  ),
  freitext(
    'i2-vh-2',
    've-harvard',
    scenario:
        'Ein Lieferant der Grünwerk Gartenbedarf GmbH verlangt für 20 Notebooks 5 % mehr als im Vorjahr. Der Einkaufsleiter sagt verärgert: „Entweder der alte Preis oder wir wechseln!“ Du sollst die nächste Verhandlungsrunde nach dem Harvard-Konzept vorbereiten.',
    prompt:
        'Erläutere zwei Prinzipien des Harvard-Konzepts und wie du sie in dieser Verhandlung anwendest.',
    kriterien: [
      krit(
        'Menschen und Probleme trennen: sachlich bleiben und den Ärger nicht am Gesprächspartner auslassen.',
        punkte: 2,
        stichwoerter: [
          'Menschen und Probleme',
          'Person und Sache',
          'sachlich',
          'trennen',
          'Sachebene',
        ],
      ),
      krit(
        'Interessen statt Positionen: klären, warum der Lieferant erhöht und was Grünwerk wirklich braucht.',
        punkte: 2,
        stichwoerter: ['Interesse', 'Position', 'warum', 'Hintergrund'],
      ),
      krit(
        'Optionen zum beiderseitigen Vorteil: z. B. größere Menge, längere Vertragslaufzeit oder frühere Zahlung gegen den alten Preis.',
        punkte: 2,
        stichwoerter: [
          'Option',
          'Varianten',
          'beiderseitig',
          'Win-win',
          'Möglichkeiten',
        ],
      ),
      krit(
        'Neutrale Kriterien: Marktpreise oder Vergleichsangebote als Maßstab nutzen.',
        punkte: 2,
        stichwoerter: [
          'neutral',
          'Kriterien',
          'Marktpreis',
          'Vergleichsangebot',
          'objektiv',
          'Maßstab',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Interessen statt Positionen: Ich frage, warum der Lieferant erhöht (etwa gestiegene Einkaufspreise), und kläre, was Grünwerk wirklich braucht, nämlich planbare Kosten. Optionen zum beiderseitigen Vorteil: Ich schlage zum Beispiel einen Rahmenvertrag über zwei Jahre oder eine frühere Zahlung vor, wenn dafür der alte Preis bleibt. Als neutrales Kriterium ziehe ich Vergleichsangebote heran.',
    explanation:
        'Je erläutertem und angewendetem Prinzip 2 Punkte, höchstens 4. Die vier Prinzipien: Menschen und Probleme trennen, Interessen statt Positionen, Optionen zum beiderseitigen Vorteil, neutrale Kriterien. Die Drohung des Einkaufsleiters ist dagegen hartes Feilschen um Positionen.',
  ),
  rechnen(
    'i2-vh-3',
    've-harvard',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH braucht 50 Monitore. Lieferant B hat verbindlich 180,00 € je Stück angeboten. Das ist die BATNA. Lieferant A, mit dem gerade verhandelt wird, verlangt 200,00 € je Stück. Service und Garantie sind bei beiden gleich.',
    prompt:
        'Berechne, wie viel Prozent Rabatt Lieferant A mindestens geben muss, damit sein Angebot nicht teurer ist als die BATNA.',
    answer: 10,
    unit: '%',
    tolerance: 0.01,
    punkte: 3,
    explanation:
        'BATNA (Lieferant B): 50 × 180 € = 9.000 €. Lieferant A: 50 × 200 € = 10.000 €. Nötiger Nachlass: 10.000 € − 9.000 € = 1.000 €. Rabatt = 1.000 € / 10.000 € × 100 = 10 %. Ein schlechteres Ergebnis als die BATNA lohnt sich nicht. Dann kauft das Systemhaus bei B.',
  ),

  // ============================================ Argumentieren und Einwände
  freitext(
    'i2-ve-1',
    've-einwaende',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH hat einem englischsprachigen Kunden ein Managed-Backup für 89 € im Monat angeboten. Die Geschäftsführerin antwortet per E-Mail.',
    code:
        'Dear Mr Schulz,\n'
        'thank you for your offer for the managed\n'
        'backup. To be honest, 89 euros per month\n'
        'seems too expensive to us. We also fear\n'
        'that the setup will disturb our daily\n'
        'work, and we are not sure whether our\n'
        'data is safe in a cloud.\n\n'
        'Best regards\n'
        'Emma Clark',
    prompt: 'Nenne die drei Einwände, die die Kundin gegen das Angebot hat.',
    kriterien: [
      krit(
        'Der Preis von 89 € im Monat ist ihr zu hoch.',
        stichwoerter: ['Preis', 'teuer', 'Kosten', 'expensive', '89'],
      ),
      krit(
        'Die Einrichtung könnte den Arbeitsalltag stören.',
        stichwoerter: [
          'Einrichtung',
          'stören',
          'Installation',
          'Arbeitsalltag',
          'Betrieb',
          'Setup',
        ],
      ),
      krit(
        'Sie zweifelt, ob die Daten in der Cloud sicher sind.',
        stichwoerter: ['Cloud', 'sicher', 'Sicherheit', 'Datensicherheit'],
      ),
    ],
    loesung:
        'Die Kundin findet erstens den Preis von 89 € im Monat zu hoch. Zweitens befürchtet sie, dass die Einrichtung den Arbeitsalltag stört. Drittens ist sie unsicher, ob ihre Daten in der Cloud sicher sind.',
    explanation:
        'Je Nennung 1 Punkt. Vokabeln: too expensive = zu teuer, setup = Einrichtung, to disturb = stören, safe = sicher. Jeder Einwand wird einzeln behandelt. Erst nachfragen, dann mit Nutzen argumentieren.',
  ),
  tabelle(
    'i2-ve-2',
    've-einwaende',
    scenario:
        'Die Elbtal Logistik AG modernisiert die Arbeitsplätze der Disposition. Du bereitest für den Leiter der Disposition die Nutzenargumentation vor.',
    prompt:
        'Vervollständige die Tabelle: Wähle zu jedem Merkmal den Vorteil und den Nutzen für die Disposition.',
    zeilen: [
      ['Merkmal', 'Vorteil', 'Nutzen'],
      [
        'Zwei 27-Zoll-Monitore',
        wahl('mehr Fenster nebeneinander', [
          'Programme starten schneller',
          'läuft bei Stromausfall weiter',
        ]),
        wahl('Touren und Lagerplan zugleich im Blick', [
          'kein Warten beim Schichtwechsel',
          'laufende Aufträge gehen nicht verloren',
        ]),
      ],
      [
        'SSD statt Festplatte',
        wahl('Programme starten schneller', [
          'mehr Fenster nebeneinander',
          'läuft bei Stromausfall weiter',
        ]),
        wahl('kein Warten beim Schichtwechsel', [
          'Touren und Lagerplan zugleich im Blick',
          'laufende Aufträge gehen nicht verloren',
        ]),
      ],
      [
        'USV am Arbeitsplatz',
        wahl('läuft bei Stromausfall weiter', [
          'mehr Fenster nebeneinander',
          'Programme starten schneller',
        ]),
        wahl('laufende Aufträge gehen nicht verloren', [
          'Touren und Lagerplan zugleich im Blick',
          'kein Warten beim Schichtwechsel',
        ]),
      ],
    ],
    punkte: 3,
    explanation:
        'Nutzenargumentation: Merkmal (Eigenschaft des Produkts) → Vorteil (was es dadurch besser kann) → Nutzen (konkreter Gewinn für genau diesen Kunden). Kunden entscheiden nach dem Nutzen, nicht nach der Technik.',
  ),
  freitext(
    'i2-ve-3',
    've-einwaende',
    scenario:
        'Ein Filialleiter der Grünwerk Gartenbedarf GmbH lehnt die neuen Kassen-Tablets ab: „Die sind viel zu kompliziert für meine Leute.“',
    prompt:
        'Beschreibe zwei Methoden der Einwandbehandlung und formuliere jeweils eine passende Antwort.',
    kriterien: [
      krit(
        'Rückfrage: „Was genau erscheint Ihnen kompliziert?“ Das klärt, was hinter dem Einwand steckt.',
        punkte: 2,
        stichwoerter: ['Rückfrage', 'Gegenfrage', 'nachfragen', 'was genau'],
      ),
      krit(
        'Ja-aber-Methode: erst zustimmen, dann ein Gegenargument ergänzen („Ja, die Umstellung braucht etwas Übung. Dafür entfällt das Nachtragen am Abend“).',
        punkte: 2,
        stichwoerter: ['Ja-aber', 'zustimmen', 'Gegenargument'],
      ),
      krit(
        'Bumerang-Methode: den Einwand zum Argument machen („Gerade weil Ihre Leute wenig Zeit haben, hilft die geführte Bedienung“).',
        punkte: 2,
        stichwoerter: ['Bumerang', 'gerade weil', 'gerade deshalb'],
      ),
      krit(
        'Referenzmethode: auf gute Erfahrungen anderer verweisen („Die Filiale Kassel arbeitet seit drei Monaten problemlos damit“).',
        punkte: 2,
        stichwoerter: [
          'Referenz',
          'andere Filiale',
          'Erfahrungen',
          'andere Kunden',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Rückfrage: „Was genau erscheint Ihnen kompliziert?“ So erfahre ich, ob es um die Bedienung oder um die Einarbeitung geht. Bumerang-Methode: „Gerade weil Ihre Leute wenig Zeit haben, hilft das Tablet: Es führt Schritt für Schritt durch den Kassiervorgang.“',
    explanation:
        'Je Methode mit passender Antwort 2 Punkte, höchstens 4. Methoden: Rückfrage (Hintergrund klären), Ja-aber (zustimmen und ergänzen), Bumerang (Einwand wird zum Argument), Referenz (zufriedene Anwender nennen). Nie direkt widersprechen.',
  ),

  // ================================================== Präsentationen aufbauen
  freitext(
    'i2-pp-1',
    'pr-praesentation',
    scenario:
        'Du sollst der Geschäftsführung der Elbtal Logistik AG in zehn Minuten vorstellen, warum die Disposition neue Arbeitsplatzrechner braucht. Die Zuhörer sind Kaufleute ohne IT-Hintergrund.',
    prompt:
        'Beschreibe zwei Maßnahmen, mit denen du die Präsentation adressatengerecht gestaltest.',
    kriterien: [
      krit(
        'Nutzen, Kosten und Risiken in den Mittelpunkt stellen statt technischer Details.',
        punkte: 2,
        stichwoerter: [
          'Nutzen',
          'Kosten',
          'Risiken',
          'wirtschaftlich',
          'Einsparung',
        ],
      ),
      krit(
        'Fachbegriffe vermeiden oder kurz erklären.',
        punkte: 2,
        stichwoerter: [
          'Fachbegriffe',
          'Fachsprache',
          'verständlich',
          'einfache Sprache',
        ],
      ),
      krit(
        'Zahlen als Diagramm zeigen und wenig Text auf die Folien setzen.',
        punkte: 2,
        stichwoerter: [
          'Diagramm',
          'visualisieren',
          'Grafik',
          'wenig Text',
          'Schaubild',
        ],
      ),
      krit(
        'Mit einer klaren Empfehlung und der Bitte um Entscheidung schließen.',
        punkte: 2,
        stichwoerter: [
          'Empfehlung',
          'Entscheidung',
          'Fazit',
          'Handlungsaufforderung',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Ich stelle den Nutzen und die Kosten in den Mittelpunkt, zum Beispiel die eingesparte Wartezeit je Schicht, und verzichte auf technische Details wie Prozessortypen. Fachbegriffe ersetze ich durch verständliche Worte, und die Zahlen zeige ich als einfaches Balkendiagramm. Am Schluss steht eine klare Empfehlung, über die die Geschäftsführung entscheiden kann.',
    explanation:
        'Je beschriebener Maßnahme 2 Punkte, höchstens 4. Adressatengerecht heißt: Sprache, Tiefe und Beispiele an die Zuhörer anpassen. Entscheider brauchen Nutzen, Kosten, Risiken und eine Empfehlung, keine Technikdetails.',
  ),
  markieren(
    'i2-pp-2',
    'pr-praesentation',
    scenario:
        'Ein Kollege bei der Pixelhafen Medien GmbH zeigt dir den Entwurf seiner Kundenpräsentation. Folie 4 zeigt die Entwicklung der Websitebesuche über zwölf Monate.',
    prompt: 'Markiere alle Punkte, die an der Folie verbessert werden müssen.',
    zeilen: [
      ja(
        'Die Werteachse beginnt bei 9.000 statt bei 0.',
        'Eine abgeschnittene Achse übertreibt die Unterschiede.',
      ),
      nein(
        'Der Verlauf ist als Liniendiagramm dargestellt.',
        'Linien sind die richtige Wahl für eine Entwicklung über die Zeit.',
      ),
      ja(
        'An der Werteachse fehlt die Einheit.',
        'Ohne Einheit bleibt unklar, was die Zahlen bedeuten.',
      ),
      ja(
        'Unter dem Diagramm stehen acht ganze Sätze in Schriftgröße 10.',
        'Zu viel und zu kleiner Text. Das Publikum liest, statt zuzuhören.',
      ),
      nein(
        'Die Folie trägt eine Überschrift mit der Kernaussage.',
        'Eine Kernaussage pro Folie ist genau richtig.',
      ),
      ja(
        'Eine Quellenangabe für die Zahlen fehlt.',
        'Zahlen brauchen eine nachprüfbare Quelle.',
      ),
      nein(
        'Farben und Schriftart entsprechen den übrigen Folien.',
        'Ein einheitliches Design wirkt ruhig und professionell.',
      ),
    ],
    punkte: 4,
    explanation:
        'Ehrliche Diagramme haben eine Achse ab 0, eine Einheit und eine Quelle. Gute Folien tragen eine Kernaussage, wenig Text in großer Schrift und ein einheitliches Design.',
  ),
  zuordnen(
    'i2-pp-3',
    'pr-praesentation',
    scenario:
        'Du gliederst für die Kessler & Brandt IT-Systemhaus GmbH die Präsentation des neuen IT-Konzepts vor der Steuerkanzlei Albers & Partner.',
    prompt: 'Ordne die Bausteine dem richtigen Teil der Präsentation zu.',
    buckets: ['Einleitung', 'Hauptteil', 'Schluss'],
    items: [
      zu('Vergleich der drei Lösungsvarianten mit Kosten', 1),
      zu('Einstiegsfrage: „Was kostet Sie ein Tag ohne IT?“', 0),
      zu('Zusammenfassung der Kernaussagen', 2),
      zu('Vorstellung von Thema und Ablauf', 0),
      zu('Zeitplan der Umsetzung im Einzelnen', 1),
      zu('Empfehlung und Bitte um Entscheidung', 2),
    ],
    punkte: 3,
    explanation:
        'Einleitung: Aufmerksamkeit gewinnen, Thema und Ablauf nennen. Hauptteil: Inhalte logisch aufbauen und belegen. Schluss: Kernaussagen zusammenfassen und zum Handeln auffordern.',
  ),

  // ============================================= Informationsquellen bewerten
  tabelle(
    'i2-pq-1',
    'pr-quellen',
    scenario:
        'Für die Website eines Kunden sucht die Pixelhafen Medien GmbH Fotos mit Creative-Commons-Lizenz. Die Website dient dem Verkauf, einzelne Fotos sollen zugeschnitten und eingefärbt werden.',
    prompt: 'Trage für jede Lizenz ein, was erlaubt ist.',
    zeilen: [
      ['Lizenz', 'kommerzielle Nutzung', 'Bearbeitung'],
      [
        'CC BY',
        wahl('erlaubt', ['nicht erlaubt', 'nur ohne Namensnennung']),
        wahl('erlaubt', ['nicht erlaubt', 'nur unter gleicher Lizenz']),
      ],
      [
        'CC BY-SA',
        wahl('erlaubt', ['nicht erlaubt', 'nur ohne Namensnennung']),
        wahl(
          'nur unter gleicher Lizenz',
          ['nicht erlaubt', 'erlaubt'],
          'SA = Share Alike: Weitergabe unter gleichen Bedingungen.',
        ),
      ],
      [
        'CC BY-NC',
        wahl('nicht erlaubt', [
          'erlaubt',
          'nur ohne Namensnennung',
        ], 'NC = Non Commercial.'),
        wahl('erlaubt', ['nicht erlaubt', 'nur unter gleicher Lizenz']),
      ],
      [
        'CC BY-ND',
        wahl('erlaubt', ['nicht erlaubt', 'nur ohne Namensnennung']),
        wahl('nicht erlaubt', [
          'erlaubt',
          'nur unter gleicher Lizenz',
        ], 'ND = No Derivatives: keine Bearbeitung.'),
      ],
    ],
    punkte: 4,
    explanation:
        'CC-Bausteine: BY = Namensnennung (immer nötig), SA = Weitergabe unter gleicher Lizenz, NC = nicht kommerziell, ND = keine Bearbeitung. Für eine Verkaufs-Website mit bearbeiteten Fotos eignen sich CC BY und, mit der Auflage gleicher Lizenz: CC BY-SA.',
  ),
  freitext(
    'i2-pq-2',
    'pr-quellen',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH sucht ein NAS für die neue Filiale. Bei der Recherche im Mai 2026 findest du diesen Beitrag.',
    code:
        'SpeedyNAS Blog - posted 14 March 2019\n'
        'Author: SpeedyNAS Marketing Team\n\n'
        '"Our SpeedyNAS 400 is the fastest and\n'
        'most reliable storage on the market.\n'
        'Independent tests are not necessary -\n'
        'trust our experience!"',
    prompt:
        'Bewerte die Quelle: Beschreibe zwei Gründe, warum sie als Grundlage für die Kaufentscheidung nicht ausreicht.',
    kriterien: [
      krit(
        'Objektivität: Der Hersteller schreibt über sein eigenes Produkt und hat ein Verkaufsinteresse.',
        punkte: 2,
        stichwoerter: [
          'Hersteller',
          'objektiv',
          'Verkaufsinteresse',
          'Werbung',
          'Marketing',
          'neutral',
        ],
      ),
      krit(
        'Aktualität: Der Beitrag stammt von 2019 und ist für Hardware veraltet.',
        punkte: 2,
        stichwoerter: ['aktuell', 'veraltet', '2019', 'Aktualität', 'Datum'],
      ),
      krit(
        'Nachprüfbarkeit: Es gibt keine Belege, unabhängige Tests werden sogar abgelehnt.',
        punkte: 2,
        stichwoerter: [
          'Beleg',
          'nachprüfbar',
          'unabhängig',
          'Nachweis',
          'überprüfen',
          'Tests',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Die Quelle ist nicht objektiv: Der Text stammt vom Marketing des Herstellers, der sein Produkt verkaufen will. Außerdem ist sie nicht aktuell: Der Beitrag ist von 2019 und damit sieben Jahre alt. Hinzu kommt, dass die Behauptungen nicht belegt sind; unabhängige Tests werden sogar für unnötig erklärt.',
    explanation:
        'Je beschriebenem Grund 2 Punkte, höchstens 4. Quellen werden nach Aktualität, Urheber, Objektivität, Nachprüfbarkeit und Relevanz bewertet. Herstellerangaben immer mit einer unabhängigen zweiten Quelle abgleichen (most reliable = am zuverlässigsten, independent tests = unabhängige Tests).',
  ),
  markieren(
    'i2-pq-3',
    'pr-quellen',
    scenario:
        'Für eine Kundenpräsentation der Kessler & Brandt IT-Systemhaus GmbH hast du ein Quellenverzeichnis angelegt. Vor der Abgabe prüfst du die Einträge.',
    prompt: 'Markiere alle Einträge, die als Quellenangabe nicht ausreichen.',
    zeilen: [
      nein(
        'Müller, A. (2024): Netzwerke planen. 3. Aufl., Bonn: IT-Verlag.',
        'Autor, Jahr, Titel, Auflage, Ort und Verlag: vollständig für ein Buch.',
      ),
      ja('www.irgendwo.de', 'Autor, Titel, genaue URL und Abrufdatum fehlen.'),
      nein(
        'BSI (2025): Ransomware - Maßnahmenkatalog. https://www.bsi.bund.de/ransomware, abgerufen am 12.05.2026.',
        'Herausgeber, Jahr, Titel, URL und Abrufdatum sind genannt.',
      ),
      ja(
        'Google-Suche nach „VLAN“',
        'Eine Suchmaschine ist keine Quelle: angegeben wird die gefundene Seite.',
      ),
      ja(
        'Schmidt, T. (2023): VLAN-Grundlagen. https://example.org/vlan',
        'Bei Internetquellen fehlt hier das Abrufdatum.',
      ),
      nein(
        'Eigene Messung der Übertragungsrate am 03.06.2026, Protokoll im Anhang.',
        'Eine eigene Erhebung ist eine Primärquelle und nachvollziehbar belegt.',
      ),
    ],
    explanation:
        'Eine Internetquelle braucht Autor oder Herausgeber, Jahr, Titel, URL und Abrufdatum, denn Webseiten ändern sich. Bei Büchern gehören Auflage, Ort und Verlag dazu. Suchmaschinen sind nur der Weg zur Quelle, nicht die Quelle selbst.',
  ),

  // ==================================================== Anfrage, Angebot, Vergleich
  markieren(
    'i2-pa-1',
    'pr-angebot',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH hat für die neue Filiale in Göttingen bei der Bürotechnik Nordhessen GmbH bestellt (Tabelle). Vereinbart ist Lieferung frei Haus. Laut Lieferschein wurde alles wie bestellt geliefert. Jetzt liegt die Eingangsrechnung vor.',
    table: [
      ['Bestellung', 'Menge', 'Einzelpreis netto', 'USt'],
      ['Monitor 27 Zoll', '6', '189,00 €', '19 %'],
      ['Dockingstation', '6', '129,00 €', '19 %'],
      ['HDMI-Kabel 2 m', '12', '7,50 €', '19 %'],
      ['Fachbuch Netzwerktechnik', '2', '40,00 €', '7 %'],
    ],
    prompt:
        'Markiere alle Rechnungspositionen, die von der Bestellung abweichen.',
    zeilen: [
      nein(
        'Pos. 1: 6 Monitor 27 Zoll × 189,00 € = 1.134,00 €, USt 19 %',
        'Menge, Einzelpreis und Steuersatz stimmen mit der Bestellung überein.',
      ),
      ja(
        'Pos. 2: 6 Dockingstation × 139,00 € = 834,00 €, USt 19 %',
        'Bestellt wurde zu 129,00 € - der Einzelpreis ist 10,00 € zu hoch.',
      ),
      ja(
        'Pos. 3: 15 HDMI-Kabel 2 m × 7,50 € = 112,50 €, USt 19 %',
        'Bestellt und geliefert wurden 12 Stück, berechnet werden 15.',
      ),
      ja(
        'Pos. 4: 2 Fachbuch Netzwerktechnik × 40,00 € = 80,00 €, USt 19 %',
        'Für Bücher gilt der ermäßigte Steuersatz von 7 %.',
      ),
      nein(
        'Pos. 5: Versand frei Haus = 0,00 €',
        'Frei Haus war vereinbart. Es dürfen keine Versandkosten anfallen.',
      ),
    ],
    explanation:
        'Jede Rechnungsposition wird mit Bestellung und Lieferschein abgeglichen: Artikel, Menge, Einzelpreis und Steuersatz. Hier sind drei Positionen falsch (Preis, Menge, Steuersatz). Die Rechnung wird reklamiert und erst nach Korrektur bezahlt.',
  ),
  tabelle(
    'i2-pa-2',
    'pr-angebot',
    scenario:
        'Auf der Eingangsrechnung der Bürotechnik Nordhessen GmbH an die Grünwerk Gartenbedarf GmbH stehen mehrere Datumsangaben. Heute ist der 12.03.2026.',
    code:
        'Rechnung Nr. R-10482\n'
        'Rechnungsdatum:        10.03.2026\n'
        'Ihre Bestellung vom:   02.03.2026\n'
        'Lieferdatum:           09.03.2026\n'
        'Zahlbar bis 09.04.2026 ohne Abzug,\n'
        'bis 20.03.2026 mit 2 % Skonto.',
    prompt:
        'Ordne jedem Datum den kaufmännischen Vorgang zu und gib an, ob er bereits stattgefunden hat.',
    zeilen: [
      ['Datum', 'Vorgang', 'schon erfolgt?'],
      [
        '02.03.2026',
        wahl('Bestellung', [
          'Lieferung',
          'Rechnungsstellung',
          'Ende der Skontofrist',
          'Ende des Zahlungsziels',
        ]),
        wahl('ja', ['nein', 'nicht erkennbar']),
      ],
      [
        '09.03.2026',
        wahl('Lieferung', [
          'Bestellung',
          'Rechnungsstellung',
          'Ende der Skontofrist',
          'Ende des Zahlungsziels',
        ]),
        wahl('ja', ['nein', 'nicht erkennbar']),
      ],
      [
        '10.03.2026',
        wahl('Rechnungsstellung', [
          'Bestellung',
          'Lieferung',
          'Ende der Skontofrist',
          'Ende des Zahlungsziels',
        ]),
        wahl('ja', ['nein', 'nicht erkennbar']),
      ],
      [
        '20.03.2026',
        wahl('Ende der Skontofrist', [
          'Bestellung',
          'Lieferung',
          'Rechnungsstellung',
          'Ende des Zahlungsziels',
        ]),
        wahl('nein', ['ja', 'nicht erkennbar']),
      ],
      [
        '09.04.2026',
        wahl('Ende des Zahlungsziels', [
          'Bestellung',
          'Lieferung',
          'Rechnungsstellung',
          'Ende der Skontofrist',
        ]),
        wahl('nein', ['ja', 'nicht erkennbar']),
      ],
    ],
    punkte: 5,
    explanation:
        'Bereits stattgefunden haben Bestellung (02.03.), Lieferung (09.03.) und Rechnungsstellung (10.03.). Skontofrist (20.03.) und Zahlungsziel (09.04.) sind Fristen in der Zukunft. Wird nach „stattgefundenen Vorgängen“ gefragt, zählen nur die ersten drei.',
  ),
  tabelle(
    'i2-pa-3',
    'pr-angebot',
    scenario:
        'Die Bürotechnik Nordhessen GmbH schickt der Grünwerk Gartenbedarf GmbH eine korrigierte Rechnung. Zahlungsbedingung: 30 Tage ohne Abzug, bei Zahlung innerhalb von 10 Tagen 2 % Skonto vom Rechnungsbetrag.',
    table: [
      ['Position', 'Menge', 'Einzelpreis netto', 'USt'],
      ['Monitor 27 Zoll', '6', '189,00 €', '19 %'],
      ['Dockingstation', '6', '129,00 €', '19 %'],
      ['HDMI-Kabel 2 m', '12', '7,50 €', '19 %'],
      ['Fachbuch Netzwerktechnik', '2', '40,00 €', '7 %'],
    ],
    prompt:
        'Vervollständige die Rechnung. Runde kaufmännisch auf zwei Nachkommastellen.',
    zeilen: [
      ['Zeile', 'Betrag in €'],
      [
        'Nettobetrag zu 19 %',
        zahl(1998, toleranz: 0.01, rationale: '1.134 + 774 + 90'),
      ],
      [
        '+ 19 % Umsatzsteuer',
        zahl(379.62, toleranz: 0.01, rationale: '1.998 × 0,19'),
      ],
      ['Nettobetrag zu 7 %', zahl(80, toleranz: 0.01, rationale: '2 × 40')],
      ['+ 7 % Umsatzsteuer', zahl(5.6, toleranz: 0.01, rationale: '80 × 0,07')],
      [
        '= Rechnungsbetrag (brutto)',
        zahl(2463.22, toleranz: 0.01, rationale: '1.998 + 379,62 + 80 + 5,60'),
      ],
      [
        '- 2 % Skonto',
        zahl(49.26, toleranz: 0.01, rationale: '2.463,22 × 0,02 = 49,2644'),
      ],
      [
        '= Überweisungsbetrag',
        zahl(2413.96, toleranz: 0.01, rationale: '2.463,22 − 49,26'),
      ],
    ],
    punkte: 7,
    explanation:
        'Netto 19 %: 6 × 189 € + 6 × 129 € + 12 × 7,50 € = 1.134 € + 774 € + 90 € = 1.998,00 €; USt 19 % = 379,62 €. Netto 7 %: 2 × 40 € = 80,00 €; USt 7 % = 5,60 €. Rechnungsbetrag: 1.998,00 + 379,62 + 80,00 + 5,60 = 2.463,22 €. Skonto: 2 % von 2.463,22 € = 49,2644 → 49,26 €. Überweisung: 2.463,22 € − 49,26 € = 2.413,96 €.',
    difficulty: 3,
  ),
  rechnen(
    'i2-pa-4',
    'pr-angebot',
    scenario:
        'Die Elbtal Logistik AG erhält eine Rechnung über Zubehör für Handscanner: Rechnungsbetrag brutto 1.368,90 €. Zahlungsbedingung: „Zahlbar innerhalb von 30 Tagen ohne Abzug, innerhalb von 14 Tagen abzüglich 2 % Skonto.“ Die Rechnung wird am achten Tag bezahlt.',
    prompt:
        'Berechne den Skontobetrag. Runde kaufmännisch auf zwei Nachkommastellen.',
    answer: 27.38,
    unit: '€',
    tolerance: 0.005,
    punkte: 2,
    explanation:
        'Skonto wird beim Bezahlen vom Rechnungsbetrag (brutto) berechnet: 1.368,90 € × 0,02 = 27,378 € → gerundet 27,38 €. Überwiesen werden 1.368,90 € − 27,38 € = 1.341,52 €. Der achte Tag liegt innerhalb der Skontofrist von 14 Tagen.',
  ),
  freitext(
    'i2-pa-5',
    'pr-angebot',
    scenario:
        'Auf der Rechnung eines Lieferanten der Pixelhafen Medien GmbH ist unten rechts ein QR-Code mit der Beschriftung „GiroCode“ abgedruckt.',
    prompt: 'Nenne drei Angaben, die im GiroCode gespeichert sind.',
    kriterien: [
      krit(
        'Name des Zahlungsempfängers',
        stichwoerter: ['Empfänger', 'Name', 'Kontoinhaber', 'Begünstigter'],
      ),
      krit(
        'IBAN des Empfängers',
        stichwoerter: ['IBAN', 'Kontonummer', 'Bankverbindung'],
      ),
      krit('BIC der Bank', stichwoerter: ['BIC', 'Bankleitzahl', 'SWIFT']),
      krit(
        'Betrag der Überweisung',
        stichwoerter: ['Betrag', 'Summe', 'Rechnungsbetrag'],
      ),
      krit(
        'Verwendungszweck, z. B. die Rechnungsnummer',
        stichwoerter: [
          'Verwendungszweck',
          'Rechnungsnummer',
          'Zweck',
          'Referenz',
        ],
      ),
    ],
    punkte: 3,
    loesung:
        'Der GiroCode enthält die Daten einer SEPA-Überweisung: den Namen des Zahlungsempfängers, seine IBAN (und BIC), den Betrag und den Verwendungszweck, zum Beispiel die Rechnungsnummer.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Der GiroCode ist ein QR-Code mit den Daten einer SEPA-Überweisung. Die Banking-App füllt die Überweisung nach dem Scannen aus: Tippfehler entfallen, und der Lieferant kann die Zahlung über den Verwendungszweck zuordnen.',
  ),
  freitext(
    'i2-pa-6',
    'pr-angebot',
    scenario:
        'Die Elbtal Logistik AG erhält im Monat rund 900 Eingangsrechnungen, bisher überwiegend auf Papier. Die Buchhaltung will auf E-Rechnungen und eine digitale Rechnungsverarbeitung umstellen.',
    prompt:
        'Nenne zwei Vorteile und zwei Nachteile der Umstellung für das Unternehmen.',
    kriterien: [
      krit(
        'Vorteil: schnellere, automatische Verarbeitung ohne Abtippen',
        stichwoerter: [
          'schneller',
          'automatisch',
          'Zeitersparnis',
          'effizient',
          'abtippen',
        ],
      ),
      krit(
        'Vorteil: geringere Kosten für Papier, Druck, Porto und Ablage',
        stichwoerter: ['Papier', 'Porto', 'Druckkosten', 'Kostenersparnis'],
      ),
      krit(
        'Vorteil: weniger Erfassungsfehler, kein Medienbruch',
        stichwoerter: ['Fehler', 'Medienbruch', 'Tippfehler'],
      ),
      krit(
        'Vorteil: Rechnungen sind schnell auffindbar und nachverfolgbar',
        stichwoerter: [
          'auffindbar',
          'nachverfolgen',
          'Archiv',
          'Zugriff',
          'wiederfinden',
        ],
      ),
      krit(
        'Nachteil: Kosten für Software und Einführung',
        stichwoerter: [
          'Anschaffung',
          'Investition',
          'Einführung',
          'Software',
          'Lizenz',
        ],
      ),
      krit(
        'Nachteil: Schulungsaufwand und Vorbehalte der Beschäftigten',
        stichwoerter: [
          'Schulung',
          'schulen',
          'geschult',
          'Vorbehalte',
          'Einarbeitung',
          'Akzeptanz',
          'Umgewöhnung',
        ],
      ),
      krit(
        'Nachteil: Abhängigkeit von der IT und Sicherheitsrisiken',
        stichwoerter: [
          'abhängig',
          'Ausfall',
          'Sicherheitsrisiko',
          'Angriff',
          'Datensicherheit',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Vorteile: Die Rechnungen werden automatisch eingelesen und dadurch schneller bearbeitet; außerdem entfallen Kosten für Papier, Porto und Ablage. Nachteile: Die Umstellung kostet Geld für Software und Einführung, und die Beschäftigten müssen geschult werden.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Digitale Rechnungen sparen Zeit, Kosten und Erfassungsfehler und lassen sich leicht wiederfinden. Dem stehen Einführungskosten, Schulungsaufwand und die Abhängigkeit von einer sicheren IT gegenüber.',
  ),
  paare(
    'i2-pa-7',
    'pr-angebot',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH überarbeitet ihre Preisliste und legt fest, wofür Kunden einen Preisnachlass erhalten.',
    prompt: 'Ordne jeder Nachlassart den passenden Anlass zu.',
    paare: [
      paar('Mengenrabatt', 'Abnahme großer Stückzahlen'),
      paar('Treuerabatt', 'langjährige Geschäftsbeziehung'),
      paar('Neukundenrabatt', 'erste Bestellung'),
      paar('Frühbezugsrabatt', 'Bestellung lange vor dem Liefertermin'),
      paar('Skonto', 'Zahlung innerhalb kurzer Frist'),
      paar('Bonus', 'nachträglich bei erreichtem Jahresumsatz'),
    ],
    punkte: 3,
    explanation:
        'Rabatt ist ein Nachlass auf den Listenpreis, der sofort abgezogen wird, etwa für Menge, Treue, Neukunden oder frühe Bestellung. Skonto belohnt die schnelle Zahlung. Der Bonus wird nachträglich gewährt, wenn ein vereinbarter Umsatz erreicht ist.',
  ),
  tabelle(
    'i2-pa-8',
    'pr-angebot',
    scenario:
        'Die Pixelhafen Medien GmbH rüstet die Arbeitsplätze der Grafik auf und hat bei einem britischen Händler ein Angebot über acht Notebooks eingeholt.',
    code:
        'NordTech Supplies Ltd. - QUOTATION Q-2231\n\n'
        'Item:       8 x Business Laptop 14"\n'
        'Unit price: EUR 720.00 (net)\n'
        'Discount:   5 % quantity discount\n'
        'Payment:    30 days net; 2 % cash\n'
        '            discount within 10 days\n'
        'Delivery:   EUR 45.00 flat rate\n'
        'Valid until 30 June 2026',
    prompt:
        'Stelle die Bezugskalkulation für das Angebot auf (alle Beträge netto in €). Das Skonto wird genutzt.',
    zeilen: [
      ['Schritt', 'Betrag in €'],
      ['Listeneinkaufspreis', zahl(5760, toleranz: 0.01, rationale: '8 × 720')],
      ['- Rabatt', zahl(288, toleranz: 0.01, rationale: '5 % von 5.760')],
      ['= Zieleinkaufspreis', zahl(5472, toleranz: 0.01)],
      ['- Skonto', zahl(109.44, toleranz: 0.01, rationale: '2 % von 5.472')],
      ['= Bareinkaufspreis', zahl(5362.56, toleranz: 0.01)],
      [
        '+ Bezugskosten',
        zahl(45, toleranz: 0.01, rationale: 'Delivery: flat rate'),
      ],
      ['= Bezugspreis', zahl(5407.56, toleranz: 0.01)],
    ],
    punkte: 7,
    explanation:
        'Vokabeln: unit price = Stückpreis, quantity discount = Mengenrabatt, cash discount = Skonto, flat rate = Pauschale. Rechnung: 8 × 720 € = 5.760 €; − 5 % Rabatt (288 €) = 5.472 €; − 2 % Skonto (109,44 €) = 5.362,56 €; + 45 € Lieferung = 5.407,56 € Bezugspreis.',
  ),
  markieren(
    'i2-pa-9',
    'pr-angebot',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH stellt der Steuerkanzlei Albers & Partner eine Rechnung über 4.800,00 € netto aus. Vor dem Versand prüfst du den Entwurf auf die Pflichtangaben nach § 14 Umsatzsteuergesetz.',
    prompt:
        'Markiere alle Angaben, die auf dieser Rechnung gesetzlich vorgeschrieben sind.',
    zeilen: [
      ja(
        'Fortlaufende Rechnungsnummer',
        'Pflichtangabe. Jede Rechnung muss eindeutig sein.',
      ),
      ja(
        'Steuernummer oder USt-IdNr. des Systemhauses',
        'Pflichtangabe des leistenden Unternehmens.',
      ),
      nein(
        'Telefonnummer des Sachbearbeiters',
        'Kundenfreundlich, aber nicht vorgeschrieben.',
      ),
      ja('Ausstellungsdatum der Rechnung', 'Pflichtangabe.'),
      ja(
        'Zeitpunkt der Lieferung oder Leistung',
        'Pflichtangabe, auch wenn er mit dem Rechnungsdatum übereinstimmt.',
      ),
      nein(
        'GiroCode für die Überweisung',
        'Ein freiwilliger Service für den Kunden.',
      ),
      ja(
        'Menge und Bezeichnung der Leistung',
        'Pflichtangabe. Der Kunde muss prüfen können, was berechnet wird.',
      ),
      ja(
        'Steuersatz und Steuerbetrag',
        'Pflichtangabe, zusammen mit dem Nettobetrag je Steuersatz.',
      ),
      nein(
        'Unterschrift der Geschäftsführung',
        'Rechnungen müssen nicht unterschrieben werden.',
      ),
    ],
    punkte: 4,
    explanation:
        'Pflichtangaben nach § 14 UStG: Name und Anschrift beider Unternehmen, Steuernummer oder USt-IdNr. des Rechnungsstellers, Rechnungsdatum, fortlaufende Rechnungsnummer, Menge und Art der Leistung, Liefer- bzw. Leistungszeitpunkt, Nettobetrag je Steuersatz, Steuersatz und Steuerbetrag.',
  ),
  freitext(
    'i2-pa-10',
    'pr-angebot',
    scenario:
        'In der Buchhaltung der Grünwerk Gartenbedarf GmbH trifft die Rechnung eines Lieferanten über Kassenzubehör ein. Bestellung und Lieferschein liegen vor.',
    prompt:
        'Beschreibe drei Kontrollen, die du an den Rechnungspositionen durchführst, bevor die Rechnung bezahlt wird.',
    kriterien: [
      krit(
        'Artikel: Stimmen die berechneten Artikel mit Bestellung und Lieferschein überein?',
        punkte: 2,
        stichwoerter: ['Artikel', 'Bezeichnung', 'Ware', 'Produkt'],
      ),
      krit(
        'Menge: Wurde nur berechnet, was bestellt und geliefert wurde?',
        punkte: 2,
        stichwoerter: ['Menge', 'Stückzahl', 'Anzahl', 'Lieferschein'],
      ),
      krit(
        'Einzelpreis: Entspricht er dem Angebot bzw. der Bestellung, sind vereinbarte Rabatte berücksichtigt?',
        punkte: 2,
        stichwoerter: ['Einzelpreis', 'Preis', 'Rabatt', 'Stückpreis'],
      ),
      krit(
        'Steuersatz: Ist je Position der richtige Umsatzsteuersatz (19 % oder 7 %) angesetzt?',
        punkte: 2,
        stichwoerter: [
          'Steuersatz',
          'Umsatzsteuer',
          'Mehrwertsteuer',
          '19 %',
          '7 %',
        ],
      ),
      krit(
        'Rechnerische Richtigkeit: Menge × Einzelpreis und die Summen nachrechnen.',
        punkte: 2,
        stichwoerter: [
          'nachrechnen',
          'rechnerisch',
          'Summe',
          'Gesamtpreis',
          'multiplizieren',
        ],
      ),
    ],
    punkte: 6,
    loesung:
        'Erstens vergleiche ich die berechnete Menge je Position mit Bestellung und Lieferschein. Es darf nur berechnet werden, was bestellt und geliefert wurde. Zweitens prüfe ich den Einzelpreis gegen die Bestellung, einschließlich vereinbarter Rabatte. Drittens kontrolliere ich den Steuersatz: 19 % für Geräte und Zubehör, 7 % zum Beispiel für Bücher.',
    explanation:
        'Je beschriebener Kontrolle 2 Punkte, höchstens 6. Gefragt sind nur die Rechnungspositionen: Artikel, Menge, Einzelpreis, Steuersatz und die rechnerische Richtigkeit. Anschrift oder Bankverbindung gehören nicht zu den Positionen.',
  ),

  // ======================================================== Markt und Marktformen
  lueckentext(
    'i2-mm-1',
    'm-markt',
    scenario:
        'Die Pixelhafen Medien GmbH bietet Website-Wartung für Handwerksbetriebe in der Region Leipzig an. Die Marktforschung ergibt: Marktpotenzial 4,0 Mio. € pro Jahr, Marktvolumen 3,0 Mio. € pro Jahr, eigener Umsatz in diesem Markt 450.000 €.',
    prompt: 'Berechne die Kennzahlen und ergänze den Text.',
    text:
        'Der Marktanteil der Agentur beträgt {0} %. Der Sättigungsgrad des Marktes liegt bei {1} %. Noch nicht ausgeschöpft sind {2} Mio. € des Marktpotenzials. Läge der Sättigungsgrad nahe 100 %, gäbe es {3} neue Kunden zu gewinnen.',
    luecken: [
      zahl(15, toleranz: 0.01, rationale: '450.000 / 3.000.000 × 100'),
      zahl(75, toleranz: 0.01, rationale: '3,0 / 4,0 × 100'),
      zahl(1, toleranz: 0.01, rationale: '4,0 − 3,0'),
      wahl('kaum noch', [
        'sehr viele',
        'doppelt so viele',
      ], 'Ein gesättigter Markt wächst nicht mehr.'),
    ],
    punkte: 4,
    explanation:
        'Marktanteil = eigener Umsatz / Marktvolumen × 100 = 450.000 € / 3.000.000 € × 100 = 15 %. Sättigungsgrad = Marktvolumen / Marktpotenzial × 100 = 3,0 / 4,0 × 100 = 75 %. Unerschlossen: 4,0 − 3,0 = 1,0 Mio. €. In einem gesättigten Markt wächst man nur noch auf Kosten der Konkurrenz.',
  ),
  freitext(
    'i2-mm-2',
    'm-markt',
    scenario:
        'Für die Lagerverwaltung nutzt die Elbtal Logistik AG eine Spezialsoftware, die nur ein einziger Hersteller anbietet. Der Hersteller kündigt eine Preiserhöhung von 25 % an.',
    prompt:
        'Erläutere zwei Nachteile, die ein Angebotsmonopol für die Kunden hat.',
    kriterien: [
      krit(
        'Der Anbieter kann den Preis weitgehend selbst bestimmen, weil die Konkurrenz fehlt.',
        punkte: 2,
        stichwoerter: ['Preis', 'diktieren', 'teuer', 'Preiserhöhung'],
      ),
      krit(
        'Die Kunden können nicht auf einen anderen Anbieter ausweichen und sind abhängig.',
        punkte: 2,
        stichwoerter: [
          'abhängig',
          'ausweichen',
          'Alternative',
          'wechseln',
          'keine Wahl',
        ],
      ),
      krit(
        'Ohne Wettbewerb fehlt der Anreiz für Qualität, Service und Weiterentwicklung.',
        punkte: 2,
        stichwoerter: [
          'Qualität',
          'Service',
          'Innovation',
          'Anreiz',
          'Weiterentwicklung',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Im Angebotsmonopol gibt es keine Konkurrenz: Der Hersteller kann den Preis weitgehend selbst festlegen, wie die Erhöhung um 25 % zeigt. Die Elbtal Logistik AG kann nicht einfach wechseln und ist vom Anbieter abhängig. Zudem fehlt ihm der Druck, Qualität und Service zu verbessern.',
    explanation:
        'Je erläutertem Nachteil 2 Punkte, höchstens 4. Im Monopol steht ein Anbieter vielen Nachfragern gegenüber. Seine Preismacht ist nur durch die Zahlungsbereitschaft der Kunden begrenzt; Wettbewerb als Antrieb für Qualität und Innovation fehlt.',
  ),
  tabelle(
    'i2-mm-3',
    'm-markt',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH untersucht den regionalen Markt für einen Ersatzakku für Mähroboter. Je nach Preis ändern sich die angebotene und die nachgefragte Menge (in Stück pro Monat).',
    prompt:
        'Trage für jeden Preis die tatsächlich verkaufte Menge und die Marktlage ein.',
    zeilen: [
      ['Preis', 'Angebot', 'Nachfrage', 'verkauft', 'Marktlage'],
      [
        '20 €',
        '100',
        '500',
        zahl(100),
        wahl('Nachfrageüberhang', ['Angebotsüberhang', 'Gleichgewicht']),
      ],
      [
        '30 €',
        '200',
        '400',
        zahl(200),
        wahl('Nachfrageüberhang', ['Angebotsüberhang', 'Gleichgewicht']),
      ],
      [
        '40 €',
        '300',
        '300',
        zahl(300),
        wahl('Gleichgewicht', ['Angebotsüberhang', 'Nachfrageüberhang']),
      ],
      [
        '50 €',
        '400',
        '200',
        zahl(200),
        wahl('Angebotsüberhang', ['Nachfrageüberhang', 'Gleichgewicht']),
      ],
    ],
    punkte: 4,
    explanation:
        'Verkauft werden kann immer nur die kleinere der beiden Mengen. Bei 20 € und 30 € wollen mehr Kunden kaufen, als angeboten wird (Nachfrageüberhang). Bei 50 € bleiben Anbieter auf Ware sitzen (Angebotsüberhang). Beim Gleichgewichtspreis von 40 € ist die verkaufte Menge mit 300 Stück am größten.',
  ),

  // ============================================================== Bedarf ermitteln
  freitext(
    'i2-mb-1',
    'm-bedarf',
    scenario:
        'Die Steuerkanzlei Albers & Partner mit 18 Beschäftigten bezieht neue Büroräume und lässt ihre IT von der Kessler & Brandt IT-Systemhaus GmbH erneuern. Du bereitest die Bedarfsanalyse für die Arbeitsplatzrechner vor.',
    prompt: 'Nenne vier Informationen, die du beim Kunden erheben musst.',
    kriterien: [
      krit(
        'Anzahl der Arbeitsplätze bzw. Nutzer',
        stichwoerter: [
          'Anzahl',
          'Arbeitsplätze',
          'Nutzer',
          'Mitarbeiter',
          'wie viele',
        ],
      ),
      krit(
        'Eingesetzte Software und deren Anforderungen',
        stichwoerter: ['Software', 'Anwendungen', 'Programme', 'Anforderungen'],
      ),
      krit(
        'Budget des Kunden',
        stichwoerter: ['Budget', 'Kostenrahmen', 'Preisvorstellung'],
      ),
      krit(
        'Zeitrahmen, z. B. der Umzugstermin',
        stichwoerter: ['Termin', 'Zeitrahmen', 'Umzug', 'Frist'],
      ),
      krit(
        'Vorhandene Hardware, die weiterverwendet werden soll (Ist-Zustand)',
        stichwoerter: [
          'vorhanden',
          'Ist-Zustand',
          'Bestand',
          'weiterverwenden',
          'Inventar',
        ],
      ),
      krit(
        'Mobiles Arbeiten oder Homeoffice',
        stichwoerter: ['mobil', 'Homeoffice', 'Notebook', 'unterwegs'],
      ),
      krit(
        'Anforderungen an Datenschutz und Sicherheit (Mandantendaten)',
        stichwoerter: [
          'Datenschutz',
          'Sicherheit',
          'Verschlüsselung',
          'Mandantendaten',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Ich erhebe die Anzahl der Arbeitsplätze, die eingesetzte Software mit ihren Anforderungen (z. B. Kanzleisoftware), das Budget und den Zeitrahmen bis zum Umzug. Dazu kommt, welche vorhandenen Geräte weiterverwendet werden und ob mobil gearbeitet wird.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Eine Bedarfsanalyse beginnt mit der Ist-Aufnahme: Nutzer, Software, vorhandene Geräte. Dazu kommen die Rahmenbedingungen Budget, Termine und besondere Anforderungen wie Datenschutz.',
  ),
  lueckentext(
    'i2-mb-2',
    'm-bedarf',
    scenario:
        'Eine Mitarbeiterin im Kundenservice der Grünwerk Gartenbedarf GmbH soll künftig mobil arbeiten.',
    prompt: 'Wähle für jede Lücke den passenden Begriff.',
    text:
        'Die Mitarbeiterin empfindet es als Mangel, zu Hause nicht auf das Shopsystem zugreifen zu können. Das ist ein {0}. Die Geschäftsführung stellt 1.200 € je Arbeitsplatz bereit: Mit der Kaufkraft wird daraus {1}. Mit der Bestellung der Notebooks beim Händler entsteht {2}. Dass auch ein VPN-Zugang nötig ist, hat niemand bedacht. Das ist ein {3} Bedarf.',
    luecken: [
      wahl('Bedürfnis', [
        'Bedarf',
        'Angebot',
      ], 'Ein empfundener Mangel mit dem Wunsch, ihn zu beheben.'),
      wahl('Bedarf', [
        'Nachfrage',
        'ein Bedürfnis',
      ], 'Bedürfnis plus Kaufkraft.'),
      wahl('Nachfrage', [
        'Bedarf',
        'ein Bedürfnis',
      ], 'Bedarf, der am Markt wirksam wird.'),
      wahl('latenter', [
        'offener',
        'gesättigter',
      ], 'Vorhanden, aber dem Kunden nicht bewusst.'),
    ],
    punkte: 4,
    explanation:
        'Bedürfnis (empfundener Mangel) → Bedarf (Bedürfnis mit Kaufkraft) → Nachfrage (Bedarf wird am Markt wirksam). Offener Bedarf wird genannt, latenter Bedarf ist unbewusst: gute Beratung macht ihn sichtbar.',
  ),
  tabelle(
    'i2-mb-3',
    'm-bedarf',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH ermittelt bei mehreren Kunden den Bedarf. Für jede Situation soll die Methode gewählt werden, die am besten passt.',
    prompt: 'Wähle zu jeder Situation die passende Methode.',
    zeilen: [
      ['Situation', 'Methode'],
      [
        '240 Beschäftigte sollen vergleichbar angeben, welche Funktionen sie nutzen.',
        wahl('Fragebogen', [
          'Interview',
          'Beobachtung',
          'Workshop',
          'Dokumente prüfen',
        ], 'Viele Beteiligte, vergleichbare Antworten.'),
      ],
      [
        'Die Geschäftsführerin soll ihre Ziele ausführlich schildern, Rückfragen sind nötig.',
        wahl('Interview', [
          'Fragebogen',
          'Beobachtung',
          'Workshop',
          'Dokumente prüfen',
        ], 'Tiefe Einblicke, Rückfragen möglich.'),
      ],
      [
        'Es soll sichtbar werden, wie die Warenannahme tatsächlich abläuft.',
        wahl('Beobachtung', [
          'Fragebogen',
          'Interview',
          'Workshop',
          'Dokumente prüfen',
        ], 'Zeigt die tatsächlichen Abläufe am Arbeitsplatz.'),
      ],
      [
        'Einkauf, Lager und Buchhaltung sollen sich auf gemeinsame Anforderungen einigen.',
        wahl('Workshop', [
          'Fragebogen',
          'Interview',
          'Beobachtung',
          'Dokumente prüfen',
        ], 'Mehrere Abteilungen an einem Tisch.'),
      ],
      [
        'Der Gerätebestand soll anhand der Inventarliste erfasst werden.',
        wahl('Dokumente prüfen', [
          'Fragebogen',
          'Interview',
          'Beobachtung',
          'Workshop',
        ], 'Vorhandene Unterlagen auswerten.'),
      ],
    ],
    punkte: 5,
    explanation:
        'Interview: tief, aber zeitaufwendig. Fragebogen: viele Personen, vergleichbar, keine Rückfragen. Beobachtung: echte Abläufe. Dokumente prüfen: Inventarlisten, Handbücher, Verträge. Workshop: mehrere Abteilungen einigen sich gemeinsam.',
  ),

  // ================================================ Marketing-Mix und AIDA
  paare(
    'i2-mk-1',
    'm-marketing',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH ordnet ihre Produkte den Phasen des Produktlebenszyklus zu, um das Marketing anzupassen.',
    prompt: 'Ordne jeder Phase den typischen Umsatzverlauf zu.',
    paare: [
      paar('Einführung', 'gering, oft noch Verluste'),
      paar('Wachstum', 'steigt stark'),
      paar('Reife', 'hoch, wächst nur noch langsam'),
      paar('Sättigung', 'stagniert'),
      paar('Rückgang', 'sinkt'),
    ],
    punkte: 3,
    explanation:
        'Produktlebenszyklus: Einführung (bekannt machen), Wachstum (Vertrieb ausbauen), Reife (von der Konkurrenz abheben), Sättigung (Preisaktionen, Produkt verändern), Rückgang (Nachfolger einführen oder Produkt vom Markt nehmen).',
  ),
  tabelle(
    'i2-mk-2',
    'm-marketing',
    scenario:
        'Die Pixelhafen Medien GmbH ordnet ihre vier Leistungen in die BCG-Matrix ein, um zu entscheiden, wo sie investiert.',
    prompt:
        'Trage für jede Leistung das Feld der Matrix und die passende Strategie ein.',
    zeilen: [
      ['Leistung', 'Marktwachstum', 'Marktanteil', 'Feld', 'Strategie'],
      [
        'KI-Texterstellung',
        'hoch',
        'niedrig',
        wahl('Question Mark', ['Star', 'Cash Cow', 'Poor Dog']),
        wahl('fördern oder aufgeben', [
          'Gewinne abschöpfen',
          'unverändert lassen',
        ]),
      ],
      [
        'Webshop-Entwicklung',
        'hoch',
        'hoch',
        wahl('Star', ['Question Mark', 'Cash Cow', 'Poor Dog']),
        wahl('investieren', ['aufgeben', 'Gewinne abschöpfen']),
      ],
      [
        'Website-Wartung',
        'niedrig',
        'hoch',
        wahl('Cash Cow', ['Question Mark', 'Star', 'Poor Dog']),
        wahl('Gewinne abschöpfen', ['aufgeben', 'stark investieren']),
      ],
      [
        'Flash-Animationen',
        'niedrig',
        'niedrig',
        wahl('Poor Dog', ['Question Mark', 'Star', 'Cash Cow']),
        wahl('aufgeben', ['investieren', 'Gewinne abschöpfen']),
      ],
    ],
    punkte: 4,
    explanation:
        'BCG-Matrix: Question Marks (hohes Wachstum, kleiner Anteil) fördern oder aufgeben, Stars (hoch, groß) investieren, Cash Cows (niedrig, groß) Gewinne abschöpfen, Poor Dogs (niedrig, klein) aufgeben. Die Cash Cows finanzieren die Stars und Question Marks.',
    difficulty: 3,
  ),
  freitext(
    'i2-mk-3',
    'm-marketing',
    scenario:
        'Die Pixelhafen Medien GmbH bringt ein eigenes Baukastensystem für Websites auf den Markt und diskutiert den Einführungspreis.',
    prompt:
        'Erläutere den Unterschied zwischen der Penetrationsstrategie und der Abschöpfungsstrategie (Skimming).',
    kriterien: [
      krit(
        'Penetration: niedriger Einstiegspreis, um schnell Marktanteile zu gewinnen; später wird der Preis erhöht.',
        punkte: 2,
        stichwoerter: ['niedrig', 'günstig', 'Marktanteile', 'erhöhen'],
      ),
      krit(
        'Abschöpfung: hoher Einstiegspreis, um die Zahlungsbereitschaft der ersten Käufer zu nutzen; später wird der Preis gesenkt.',
        punkte: 2,
        stichwoerter: ['hoch', 'hoher', 'Zahlungsbereitschaft', 'senken'],
      ),
    ],
    loesung:
        'Bei der Penetrationsstrategie startet das Produkt mit einem niedrigen Preis, um schnell viele Kunden und Marktanteile zu gewinnen; später wird der Preis angehoben. Bei der Abschöpfungsstrategie ist der Preis zum Start hoch, um die Zahlungsbereitschaft der ersten Käufer zu nutzen; danach wird er schrittweise gesenkt.',
    explanation:
        'Je richtig erläuterter Strategie 2 Punkte. Penetration: niedrig einsteigen, später erhöhen; sinnvoll bei viel Konkurrenz. Abschöpfung: hoch einsteigen, später senken; sinnvoll bei neuartigen Produkten ohne Konkurrenz.',
  ),

  // ============================================================== ABC-Analyse
  tabelle(
    'i2-ma-1',
    'm-abc',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH wertet die Jahresumsätze von fünf Kunden aus (zusammen 200.000 €). Klassengrenzen: A bis einschließlich 75 % kumuliert, B bis einschließlich 95 %, C der Rest.',
    prompt:
        'Vervollständige die ABC-Analyse: Anteil am Gesamtumsatz, kumulierter Anteil (jeweils in %) und Klasse.',
    zeilen: [
      ['Kunde', 'Umsatz', 'Anteil %', 'kumuliert %', 'Klasse'],
      ['Kanzlei Albers', '90.000 €', '45', '45', 'A'],
      [
        'Autohaus Rehm',
        '60.000 €',
        zahl(30),
        zahl(75),
        wahl('A', ['B', 'C'], '75 % liegt noch auf der A-Grenze.'),
      ],
      [
        'Praxis Dr. Lohse',
        '24.000 €',
        zahl(12),
        zahl(87),
        wahl('B', ['A', 'C']),
      ],
      [
        'Bäckerei Timm',
        '16.000 €',
        zahl(8),
        zahl(95),
        wahl('B', ['A', 'C'], '95 % liegt noch auf der B-Grenze.'),
      ],
      [
        'Tischlerei Voß',
        '10.000 €',
        zahl(5),
        zahl(100),
        wahl('C', ['A', 'B']),
      ],
    ],
    punkte: 6,
    explanation:
        'Anteil = Umsatz / 200.000 € × 100: 30 %, 12 %, 8 %, 5 %. Kumuliert: 45 → 75 → 87 → 95 → 100 %. Bis einschließlich 75 % A (Albers, Rehm), bis einschließlich 95 % B (Lohse, Timm), darüber C (Voß). Zwei von fünf Kunden bringen drei Viertel des Umsatzes.',
    difficulty: 3,
  ),
  freitext(
    'i2-ma-2',
    'm-abc',
    scenario:
        'Die ABC-Analyse der Kessler & Brandt IT-Systemhaus GmbH zeigt: Zwei von fünf Kunden bringen 75 % des Umsatzes, der kleinste Kunde nur 5 %.',
    prompt:
        'Erläutere zwei Schlussfolgerungen, die das Systemhaus aus diesem Ergebnis ziehen kann.',
    kriterien: [
      krit(
        'A-Kunden intensiv und persönlich betreuen, weil sie den Großteil des Umsatzes bringen.',
        punkte: 2,
        stichwoerter: [
          'A-Kunden',
          'intensiv',
          'persönlich',
          'Key Account',
          'bevorzugt',
        ],
      ),
      krit(
        'C-Kunden standardisiert und kostengünstig betreuen, z. B. über Ticketsystem und Standardverträge.',
        punkte: 2,
        stichwoerter: [
          'C-Kunden',
          'standardisiert',
          'kostengünstig',
          'effizient',
          'Ticketsystem',
        ],
      ),
      krit(
        'Abhängigkeit erkennen: Fällt ein A-Kunde weg, fehlt ein großer Teil des Umsatzes. Also weitere Kunden aufbauen.',
        punkte: 2,
        stichwoerter: ['abhängig', 'Risiko', 'Wegfall', 'Klumpenrisiko'],
      ),
      krit(
        'B-Kunden gezielt zu A-Kunden entwickeln.',
        punkte: 2,
        stichwoerter: ['B-Kunden', 'entwickeln', 'ausbauen', 'Potenzial'],
      ),
    ],
    punkte: 4,
    loesung:
        'Die beiden A-Kunden werden besonders intensiv und persönlich betreut, zum Beispiel mit festen Ansprechpartnern, weil an ihnen drei Viertel des Umsatzes hängen. C-Kunden werden dagegen standardisiert und kostengünstig über das Ticketsystem betreut. Zugleich zeigt die Analyse ein Risiko: Der Wegfall eines A-Kunden würde das Systemhaus hart treffen.',
    explanation:
        'Je erläuterter Schlussfolgerung 2 Punkte, höchstens 4. Die ABC-Analyse trennt Wichtiges von Unwichtigem: Aufwand dort einsetzen, wo der Wert liegt (A), und dort sparen, wo er gering ist (C).',
  ),
  lueckentext(
    'i2-ma-3',
    'm-abc',
    scenario:
        'Im Ersatzteillager der Elbtal Logistik AG liegen 40 verschiedene Artikel mit einem Jahresverbrauchswert von zusammen 250.000 €. Die 6 wertvollsten Artikel kommen zusammen auf 187.500 €.',
    prompt: 'Berechne die Anteile und ergänze den Text.',
    text:
        'Die 6 Artikel machen {0} % aller Artikel aus (Mengenanteil), aber {1} % des Verbrauchswerts (Wertanteil). Sie bilden deshalb die {2}-Klasse. Ihr Bestand wird {3} geplant und überwacht.',
    luecken: [
      zahl(15, toleranz: 0.01, rationale: '6 / 40 × 100'),
      zahl(75, toleranz: 0.01, rationale: '187.500 / 250.000 × 100'),
      wahl('A', ['B', 'C'], 'Wenige Artikel mit hohem Wertanteil.'),
      wahl('besonders genau', [
        'nur einmal im Jahr',
        'gar nicht',
      ], 'Bei A-Gütern lohnt sich der Aufwand.'),
    ],
    punkte: 4,
    explanation:
        'Mengenanteil: 6 / 40 × 100 = 15 %. Wertanteil: 187.500 € / 250.000 € × 100 = 75 %. Wenige Artikel mit hohem Wertanteil sind A-Güter: Sie werden genau disponiert, ihre Preise intensiv verhandelt.',
  ),

  // ================================================ Rechtsformen von Unternehmen
  tabelle(
    'i2-mr-1',
    'm-rechtsformen',
    scenario:
        'Zwei Administratoren der Pixelhafen Medien GmbH wollen sich mit einem IT-Service selbstständig machen und vergleichen vier Rechtsformen.',
    prompt: 'Vervollständige den Vergleich der Rechtsformen.',
    zeilen: [
      ['Rechtsform', 'Art', 'Haftung der Gesellschafter', 'Leitung'],
      [
        'OHG',
        wahl('Personengesellschaft', [
          'Kapitalgesellschaft',
          'Einzelunternehmen',
        ]),
        wahl('alle unbeschränkt', [
          'nur Komplementär unbeschränkt',
          'auf Einlage beschränkt',
        ]),
        wahl('alle Gesellschafter', [
          'Komplementär',
          'Geschäftsführer',
          'Vorstand',
        ]),
      ],
      [
        'KG',
        wahl('Personengesellschaft', [
          'Kapitalgesellschaft',
          'Einzelunternehmen',
        ]),
        wahl('nur Komplementär unbeschränkt', [
          'alle unbeschränkt',
          'auf Einlage beschränkt',
        ]),
        wahl('Komplementär', [
          'alle Gesellschafter',
          'Geschäftsführer',
          'Vorstand',
        ]),
      ],
      [
        'GmbH',
        wahl('Kapitalgesellschaft', [
          'Personengesellschaft',
          'Einzelunternehmen',
        ]),
        wahl('auf Einlage beschränkt', [
          'alle unbeschränkt',
          'nur Komplementär unbeschränkt',
        ]),
        wahl('Geschäftsführer', [
          'alle Gesellschafter',
          'Komplementär',
          'Vorstand',
        ]),
      ],
      [
        'AG',
        wahl('Kapitalgesellschaft', [
          'Personengesellschaft',
          'Einzelunternehmen',
        ]),
        wahl('auf Einlage beschränkt', [
          'alle unbeschränkt',
          'nur Komplementär unbeschränkt',
        ]),
        wahl('Vorstand', [
          'alle Gesellschafter',
          'Komplementär',
          'Geschäftsführer',
        ]),
      ],
    ],
    punkte: 6,
    explanation:
        'OHG und KG sind Personengesellschaften: In der OHG haften alle unbeschränkt und führen die Geschäfte, in der KG nur der Komplementär. Der Kommanditist haftet bis zur Einlage. GmbH und AG sind Kapitalgesellschaften: Es haftet das Gesellschaftsvermögen, die Gesellschafter riskieren nur ihre Einlage. Geleitet werden sie vom Geschäftsführer bzw. Vorstand.',
  ),
  freitext(
    'i2-mr-2',
    'm-rechtsformen',
    scenario:
        'Zwei Auszubildende der Kessler & Brandt IT-Systemhaus GmbH planen nach der Ausbildung ein eigenes Unternehmen für Smart-Home-Installationen und überlegen, welche Rechtsform passt.',
    prompt:
        'Nenne drei Kriterien, die bei der Wahl der Rechtsform eine Rolle spielen.',
    kriterien: [
      krit(
        'Haftung (beschränkt oder mit dem Privatvermögen)',
        stichwoerter: ['Haftung', 'haften', 'Privatvermögen'],
      ),
      krit(
        'Kapitalbedarf bzw. gesetzliches Mindestkapital',
        stichwoerter: [
          'Kapital',
          'Stammkapital',
          'Eigenkapital',
          'Finanzierung',
        ],
      ),
      krit(
        'Geschäftsführung und Entscheidungsbefugnis',
        stichwoerter: [
          'Geschäftsführung',
          'Leitung',
          'Entscheidung',
          'Mitsprache',
          'Vertretung',
        ],
      ),
      krit(
        'Aufwand und Kosten der Gründung (Notar, Handelsregister)',
        stichwoerter: [
          'Gründungskosten',
          'Gründungsaufwand',
          'Notar',
          'Formalitäten',
          'Handelsregister',
        ],
      ),
      krit(
        'Besteuerung und Gewinnverteilung',
        stichwoerter: ['Steuer', 'Gewinn', 'Besteuerung'],
      ),
      krit(
        'Ansehen und Kreditwürdigkeit bei Banken und Kunden',
        stichwoerter: ['Kreditwürdigkeit', 'Ansehen', 'Image', 'seriös'],
      ),
    ],
    punkte: 3,
    loesung:
        'Wichtig sind die Haftung (beschränkt oder mit dem Privatvermögen), das nötige Mindestkapital und die Frage, wer die Geschäfte führt und entscheidet. Weitere Kriterien sind die Gründungskosten, die Besteuerung und die Kreditwürdigkeit.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Die Rechtsform bestimmt Haftung, Mindestkapital, Leitung, Gründungsaufwand und Besteuerung. Wer wenig Kapital hat und nicht privat haften will, landet oft bei der UG (haftungsbeschränkt).',
  ),
  lueckentext(
    'i2-mr-3',
    'm-rechtsformen',
    scenario:
        'Die Elbtal Logistik AG ist eine Aktiengesellschaft. Für die Azubi-Zeitung sollst du erklären, wer im Unternehmen was entscheidet.',
    prompt: 'Setze die passenden Begriffe ein.',
    text:
        'Der {0} leitet die AG und vertritt sie nach außen. Der {1} bestellt und überwacht ihn. Die Aktionäre treffen sich in der {2} und beschließen dort über die Verwendung des Gewinns. Für Schulden der AG haftet nur das {3}.',
    luecken: [
      wort(['Vorstand'], 'Das Leitungsorgan der AG.'),
      wort(['Aufsichtsrat'], 'Das Kontrollorgan der AG.'),
      wort(['Hauptversammlung'], 'Die Versammlung der Aktionäre.'),
      wort([
        'Gesellschaftsvermögen',
      ], 'Die Aktionäre riskieren nur ihre Einlage.'),
    ],
    wortbank: [
      'Geschäftsführer',
      'Gesellschafterversammlung',
      'Privatvermögen',
    ],
    punkte: 4,
    explanation:
        'Die drei Organe der AG: Vorstand (Leitung), Aufsichtsrat (bestellt und überwacht den Vorstand) und Hauptversammlung (Aktionäre; beschließt über den Gewinn und wählt Mitglieder des Aufsichtsrats). Geschäftsführer und Gesellschafterversammlung gehören zur GmbH.',
  ),
];
