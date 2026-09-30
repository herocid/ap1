import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 07 - Vertragsmanagement und Service.
final List<Nugget> nuggetsA07 = [
  // ============================================ Wie ein Vertrag zustande kommt
  konzept('n-vz-1', 'vt-zustandekommen', 'Antrag und Annahme',
      'Ein Vertrag entsteht durch zwei übereinstimmende Willenserklärungen: den Antrag und die Annahme. Den Antrag kann jede Seite machen - der Verkäufer mit einem verbindlichen Angebot oder der Kunde mit einer Bestellung.',
      points: [
        'Angebot des Händlers + Bestellung des Kunden = Vertrag',
        'Bestellung ohne vorheriges Angebot + Auftragsbestätigung = Vertrag',
        'Schweigen gilt grundsätzlich nicht als Annahme',
      ]),
  vergleich('n-vz-2', 'vt-zustandekommen', 'Antrag oder nur Einladung?',
      'Nicht jede Äußerung ist schon ein Antrag. Werbung, Kataloge und Webshop-Seiten laden nur dazu ein, selbst einen Antrag abzugeben.',
      [
        ['Äußerung', 'Rechtliche Wirkung'],
        ['Anfrage des Kunden', 'unverbindlich, kein Antrag'],
        ['Katalog, Werbung, Webshop', 'Aufforderung zum Antrag'],
        ['Angebot an eine bestimmte Person', 'Antrag, bindend'],
        ['Bestellung', 'Antrag oder Annahme'],
        ['Auftragsbestätigung', 'Annahme'],
      ],
      merksatz: 'Die Aufforderung zum Antrag heißt lateinisch invitatio ad offerendum.'),
  ablauf('n-vz-3', 'vt-zustandekommen', 'Wie lange bindet ein Angebot?',
      'Wer ein Angebot macht, ist daran gebunden - aber nicht unbegrenzt. Beispiel: Ein Systemhaus schickt einer Arztpraxis am Montag per E-Mail ein Angebot über drei Notebooks.',
      [
        'Unter Anwesenden (auch am Telefon): Annahme nur sofort möglich',
        'Unter Abwesenden (Brief, E-Mail): bis eine Antwort unter regelmäßigen Umständen zu erwarten ist',
        'Mit Frist („gültig bis 30.11.“): bis zum Ablauf der Frist',
        'Die Praxis bestellt am Mittwoch zu den Angebotsbedingungen -> Vertrag kommt zustande',
        'Bestellt sie erst nach sechs Wochen oder mit anderem Preis -> neuer Antrag, das Systemhaus kann annehmen oder ablehnen',
      ]),
  konzept('n-vz-4', 'vt-zustandekommen', 'Wer darf Verträge schließen?',
      'Wirksam handeln kann nur, wer geschäftsfähig ist. Das Alter entscheidet über die Stufe.',
      points: [
        'Unter 7 Jahren: geschäftsunfähig - Erklärungen sind nichtig',
        '7 bis 17 Jahre: beschränkt geschäftsfähig - Verträge brauchen die Zustimmung der Eltern',
        'Ausnahme Taschengeldparagraf: Kauf mit Mitteln, die zur freien Verfügung überlassen wurden, ist wirksam',
        'Ab 18 Jahren: voll geschäftsfähig',
        'Grundsätzlich formfrei; Formvorschriften nur in Sonderfällen, z. B. notarielle Beurkundung beim Grundstückskauf',
      ]),
  falle('n-vz-5', 'vt-zustandekommen', '„Freibleibend“ und AGB',
      'Mit Klauseln wie „freibleibend“ oder „solange Vorrat reicht“ schränkt der Anbietende die Bindung an sein Angebot ein. Allgemeine Geschäftsbedingungen gelten nur, wenn bei Vertragsschluss auf sie hingewiesen wurde und die andere Seite sie zur Kenntnis nehmen konnte.',
      points: [
        'Individuell ausgehandelte Absprachen haben Vorrang vor AGB',
        'Überraschende Klauseln werden nicht Vertragsbestandteil',
      ],
      merksatz: 'Antrag + deckungsgleiche, rechtzeitige Annahme = Vertrag. Alles andere ist ein neuer Antrag.'),

  // ============================================================ Vertragsarten
  konzept('n-vy-1', 'vt-arten', 'Erfolg oder Tätigkeit?',
      'Die wichtigste Frage bei IT-Verträgen lautet: Was genau wird geschuldet? Beim Werkvertrag ein Erfolg, etwa eine funktionierende Software. Beim Dienstvertrag nur das Tätigwerden, etwa Beratungsstunden - ein bestimmtes Ergebnis ist nicht versprochen.'),
  vergleich('n-vy-2', 'vt-arten', 'Die Vertragsarten im Überblick',
      'Jede Vertragsart regelt eine andere Hauptpflicht.',
      [
        ['Vertrag', 'Geschuldet wird', 'IT-Beispiel'],
        ['Kaufvertrag', 'Übergabe und Eigentum an einer Sache', 'Hardware, Standardsoftware'],
        ['Werkvertrag', 'ein Erfolg (Werk)', 'Individualsoftware'],
        ['Dienstvertrag', 'eine Tätigkeit', 'Support nach Aufwand'],
        ['Mietvertrag', 'Gebrauch auf Zeit gegen Entgelt', 'Server mieten, SaaS'],
        ['Leasingvertrag', 'Gebrauch, Leasinggeber finanziert', 'Notebookflotte'],
        ['Werklieferungsvertrag', 'Herstellung und Lieferung einer beweglichen Sache', 'Sonderanfertigung Serverschrank'],
      ]),
  ablauf('n-vy-3', 'vt-arten', 'Einen Vertrag einordnen',
      'Mit drei Fragen lässt sich fast jeder IT-Vertrag zuordnen. Beispiel: Eine Agentur soll für einen Webshop ein Buchungsmodul programmieren, Festpreis 18.000 €.',
      [
        'Geht es um Eigentum an einer fertigen Sache? Nein -> kein Kauf',
        'Geht es nur um Gebrauch auf Zeit? Nein -> keine Miete',
        'Wird ein Ergebnis versprochen? Ja, ein funktionierendes Modul -> Werkvertrag',
        'Folge: Es gibt eine Abnahme, und erst danach wird die Vergütung fällig',
      ]),
  falle('n-vy-4', 'vt-arten', 'Der Name entscheidet nicht',
      'Steht „Dienstleistungsvertrag“ über einem Vertrag, in dem eine fertige App geschuldet wird, ist es trotzdem ein Werkvertrag. Maßgeblich ist der Inhalt. Leasing ist im BGB nicht eigens geregelt und wird im Kern wie Miete behandelt.',
      points: [
        'Werklieferungsvertrag: Auf herzustellende bewegliche Sachen wird Kaufrecht angewendet',
        'SaaS und Cloud-Dienste werden typischerweise als Miete eingeordnet',
      ]),
  merke('n-vy-5', 'vt-arten', 'Auf einen Blick',
      'Vier Fragen trennen die Vertragsarten sauber.',
      points: [
        'Eigentum an einer Sache -> Kauf',
        'Erfolg geschuldet -> Werk',
        'Tätigkeit geschuldet -> Dienst',
        'Gebrauch auf Zeit -> Miete oder Leasing',
      ],
      satz: 'Werkvertrag = Erfolg + Abnahme. Dienstvertrag = Tätigkeit, keine Abnahme.'),

  // ================================================ Urheberrecht und Lizenzen
  konzept('n-vu-1', 'vt-urheber', 'Urheberrecht entsteht von selbst',
      'Computerprogramme sind urheberrechtlich geschützt. Der Schutz entsteht automatisch mit der Schöpfung - ohne Anmeldung, ohne Vermerk. Urheber ist immer der Mensch, der das Werk geschaffen hat.',
      points: [
        'Das Urheberrecht selbst ist nicht übertragbar, nur vererbbar',
        'Schutzdauer: bis 70 Jahre nach dem Tod des Urhebers',
        'Übertragen werden Nutzungsrechte - das ist eine Lizenz',
      ]),
  vergleich('n-vu-2', 'vt-urheber', 'Einfach oder ausschließlich?',
      'Nutzungsrechte unterscheiden sich darin, wer sie noch haben darf.',
      [
        ['', 'Einfaches Nutzungsrecht', 'Ausschließliches Nutzungsrecht'],
        ['Wirkung', 'Nutzung neben anderen', 'nur der Inhaber nutzt'],
        ['Urheber', 'darf weitere Lizenzen vergeben', 'ist selbst ausgeschlossen, wenn vereinbart'],
        ['Beispiel', 'Office-Lizenz im Büro', 'Auftragssoftware exklusiv für einen Kunden'],
      ],
      merksatz: 'Nutzungsrechte lassen sich zeitlich, räumlich und inhaltlich beschränken.'),
  ablauf('n-vu-3', 'vt-urheber', 'Software im Arbeitsverhältnis',
      'Beispiel: Ein Entwickler schreibt im Auftrag seines Arbeitgebers ein Tool für die Kundenverwaltung.',
      [
        'Urheber bleibt der Entwickler als Mensch',
        'Entsteht das Programm in Erfüllung seiner Aufgaben, stehen alle vermögensrechtlichen Befugnisse dem Arbeitgeber zu (§ 69b UrhG)',
        'Der Arbeitgeber darf das Tool nutzen, ändern, verkaufen und lizenzieren',
        'Der Entwickler darf es nicht einfach selbst weiterverkaufen',
      ]),
  falle('n-vu-4', 'vt-urheber', 'Was eine Lizenz erlaubt',
      'Maßgeblich sind die Lizenzbedingungen: Anzahl der Geräte oder Nutzer, Laufzeit, gewerbliche Nutzung. Eine Sicherungskopie darf anfertigen, wer zur Nutzung berechtigt ist, soweit sie für die künftige Nutzung erforderlich ist (§ 69d UrhG) - weitergeben darf man sie nicht.',
      points: [
        'Eine Lizenz für 5 Arbeitsplätze erlaubt keine sechste Installation',
        'Kostenlos heißt nicht frei: auch Freeware und Open Source haben Lizenzbedingungen',
      ]),
  merke('n-vu-5', 'vt-urheber', 'Wem gehört die Software?',
      'Urheber und Rechteinhaber sind oft verschiedene Personen.',
      satz: 'Das Urheberrecht bleibt beim Menschen - übertragen werden nur Nutzungsrechte.'),

  // ================================================ Service Level Agreements
  konzept('n-li-1', 'sla-inhalte', 'Was ist ein SLA?',
      'Ein Service Level Agreement legt messbar fest, in welcher Qualität ein IT-Dienstleister seine Leistung erbringt. Beispiel: Ein Rechenzentrum betreibt den Webshop eines Kunden und sichert Verfügbarkeit und Reaktionszeiten zu.',
      points: [
        'Servicezeiten, z. B. Mo-Fr 8-18 Uhr oder 24/7',
        'Verfügbarkeit in Prozent',
        'Reaktions- und Lösungszeiten je Priorität',
        'Messung, Reporting und Vertragsstrafe (Pönale)',
      ]),
  vergleich('n-li-2', 'sla-inhalte', 'Reaktionszeit oder Lösungszeit?',
      'Diese beiden Zeiten werden ständig verwechselt.',
      [
        ['Kennzahl', 'Endet mit'],
        ['Reaktionszeit', 'erster qualifizierter Rückmeldung'],
        ['Lösungszeit', 'Behebung der Störung'],
        ['Servicezeit', 'Zeitraum, in dem das SLA gilt'],
      ],
      merksatz: 'Die Uhr läuft in der Regel nur während der vereinbarten Servicezeit.'),
  formel('n-li-3', 'sla-inhalte', 'Erlaubte Ausfallzeit berechnen',
      'Die Verfügbarkeit bezieht sich immer auf einen Bezugszeitraum. Erst wenn der klar ist, lässt sich der erlaubte Ausfall berechnen.',
      'Ausfall = Servicezeit × (100 % - V)\n'
          '\n'
          '24/7, 1 Jahr, 99,9 %:\n'
          '365 × 24 h = 8.760 h\n'
          '8.760 h × 0,001 = 8,76 h\n'
          '\n'
          'Mo-Fr 8-18 Uhr, 22 Tage, 99 %:\n'
          '22 × 10 h = 220 h\n'
          '220 h × 0,01 = 2,2 h = 132 min',
      points: [
        'Tatsächliche Verfügbarkeit = (Servicezeit - Ausfall) / Servicezeit × 100 %',
      ]),
  falle('n-li-4', 'sla-inhalte', 'Ohne Bezugszeitraum wertlos',
      '„99,9 % Verfügbarkeit“ ohne Angabe von Servicezeit und Messzeitraum ist kaum prüfbar. Bei 24/7-Betrieb sind bezogen auf ein Jahr insgesamt fast 9 Stunden Ausfall erlaubt, bezogen auf einen 30-Tage-Monat nur rund 43 Minuten. Auch geplante Wartungsfenster müssen geregelt sein.'),
  merke('n-li-5', 'sla-inhalte', 'Ein gutes SLA',
      'Ein SLA wirkt nur, wenn es gemessen und durchgesetzt wird.',
      points: [
        'Kennzahlen klar definiert und messbar',
        'regelmäßiges Reporting an den Kunden',
        'Prioritäten mit eigenen Reaktions- und Lösungszeiten',
        'Pönale oder Gutschrift bei Unterschreitung',
      ],
      satz: 'Reaktionszeit ist nicht Lösungszeit - und Verfügbarkeit gilt nur für die Servicezeit.'),

  // ============================================ Support-Level und Eskalation
  konzept('n-ls-1', 'sla-support', 'Der Service Desk',
      'Der Service Desk ist die zentrale Anlaufstelle für alle Anfragen - der Single Point of Contact. Anwender müssen nicht wissen, wer intern zuständig ist. Jede Meldung wird als Ticket erfasst, damit nichts verloren geht und die Bearbeitung nachvollziehbar bleibt.'),
  vergleich('n-ls-2', 'sla-support', 'Drei Support-Level',
      'Je höher das Level, desto spezieller das Wissen und desto weniger Fälle.',
      [
        ['Level', 'Wer', 'Aufgabe'],
        ['1st Level', 'Service Desk', 'annehmen, einstufen, Standardfälle lösen'],
        ['2nd Level', 'Fachspezialisten', 'komplexe Fälle, tiefe Analyse'],
        ['3rd Level', 'Hersteller, Entwicklung', 'Produktfehler, Code-Änderungen'],
      ]),
  vergleich('n-ls-3', 'sla-support', 'Priorität = Auswirkung × Dringlichkeit',
      'Die Priorität eines Tickets ergibt sich aus zwei Fragen: Wie viele sind betroffen (Auswirkung) und wie schnell muss es gehen (Dringlichkeit)? Beispiel: Der Webshop ist komplett down -> hoch × hoch = Priorität 1.',
      [
        ['Auswirkung', 'Dringlichkeit hoch', 'Dringlichkeit niedrig'],
        ['hoch (viele)', 'Priorität 1', 'Priorität 2'],
        ['niedrig (einer)', 'Priorität 2', 'Priorität 3'],
      ]),
  formel('n-ls-4', 'sla-support', 'First Level Resolution Rate',
      'Die Erstlösungsquote zeigt, wie viele Tickets der 1st Level ohne Weitergabe löst. Je höher, desto schneller die Hilfe und desto günstiger der Support.',
      'FLRR = im 1st Level gelöst\n'
          '       / alle Tickets × 100 %\n'
          '\n'
          '1.200 Tickets, davon 780\n'
          'im 1st Level gelöst:\n'
          '780 / 1.200 = 0,65 = 65 %'),
  falle('n-ls-5', 'sla-support', 'Zwei Arten der Eskalation',
      'Funktionale Eskalation gibt ein Ticket an ein höheres Support-Level mit mehr Fachwissen weiter. Hierarchische Eskalation schaltet die Führungsebene ein - etwa wenn ein SLA-Bruch droht oder zusätzliche Ressourcen nötig sind.',
      merksatz: 'Funktional = zu mehr Fachwissen. Hierarchisch = zu mehr Entscheidungsbefugnis.'),

  // ============================================= Incident, Problem, Change
  konzept('n-lt-1', 'sla-itil', 'ITIL',
      'ITIL ist eine Sammlung bewährter Vorgehensweisen (Best Practices) für das IT-Service-Management. Sie ist kein Gesetz und keine Software, sondern ein Leitfaden, den Unternehmen an ihre Bedürfnisse anpassen.'),
  vergleich('n-lt-2', 'sla-itil', 'Vier Prozesse unterscheiden',
      'Jeder Prozess verfolgt ein anderes Ziel.',
      [
        ['Prozess', 'Ziel', 'Beispiel'],
        ['Incident', 'Störung schnell beheben', 'Drucker druckt nicht'],
        ['Problem', 'Ursache finden und beseitigen', 'Warum fällt der Server jede Woche aus?'],
        ['Change', 'Änderung kontrolliert durchführen', 'Firewall-Regel anpassen'],
        ['Service Request', 'Standardanfrage erfüllen', 'Passwort zurücksetzen'],
      ]),
  ablauf('n-lt-3', 'sla-itil', 'Vom Incident zum Change',
      'Die Prozesse greifen ineinander. Beispiel: Im Warenlager stürzt die Scanner-App mehrmals täglich ab.',
      [
        'Incident: Der Service Desk startet die App neu - Workaround, die Arbeit geht weiter',
        'Häufen sich gleiche Incidents, wird ein Problem eröffnet',
        'Problem Management findet die Ursache: ein Speicherleck nach dem letzten Update',
        'Ursache und Workaround werden als Known Error dokumentiert',
        'Die dauerhafte Lösung, ein Patch, wird als Change geplant, genehmigt und eingespielt',
      ]),
  vergleich('n-lt-4', 'sla-itil', 'Drei Arten von Changes',
      'Nicht jede Änderung braucht dasselbe Genehmigungsverfahren.',
      [
        ['Change', 'Merkmal', 'Genehmigung'],
        ['Standard', 'häufig, geringes Risiko', 'vorab genehmigt'],
        ['Normal', 'geplant, zu bewerten', 'einzeln, oft durch das CAB'],
        ['Emergency', 'sofort nötig', 'beschleunigt, Notfall-CAB'],
      ],
      merksatz: 'CAB = Change Advisory Board, ein Gremium, das Changes bewertet.'),
  falle('n-lt-5', 'sla-itil', 'Incident ist nicht Problem',
      'Ein Incident ist erledigt, sobald der Service wieder läuft - auch wenn die Ursache unbekannt bleibt. Die Ursachensuche ist Aufgabe des Problem Managements. Und ein neues Passwort ist kein Incident, sondern ein Service Request: Nichts ist kaputt.',
      merksatz: 'Incident = wiederherstellen. Problem = Ursache finden. Change = kontrolliert ändern.'),

  // ================================================================== Verzug
  konzept('n-gv-1', 'ls-verzug', 'Was ist Verzug?',
      'Verzug heißt: Eine fällige Leistung kommt nicht rechtzeitig. Liefert der Verkäufer zu spät, ist er im Lieferungsverzug. Zahlt der Käufer zu spät, ist er im Zahlungsverzug.'),
  ablauf('n-gv-2', 'ls-verzug', 'Voraussetzungen des Lieferungsverzugs',
      'Beispiel: Ein Händler soll 20 Notebooks für neue Azubis liefern, die Lieferung bleibt aus.',
      [
        'Fälligkeit: Der Liefertermin ist erreicht',
        'Mahnung: Der Käufer fordert die Lieferung ausdrücklich an',
        'Die Mahnung entfällt bei einem kalendermäßig bestimmten Termin („am 15.03.“) und beim Fixgeschäft',
        'Verschulden: Der Händler hat die Verspätung zu vertreten - wichtig vor allem für Schadensersatz',
      ]),
  vergleich('n-gv-3', 'ls-verzug', 'Rechte beim Lieferungsverzug',
      'Ohne Nachfrist bleibt der Vertrag bestehen. Erst nach einer angemessenen Nachfrist kann der Käufer vom Vertrag loskommen.',
      [
        ['Wann', 'Recht des Käufers'],
        ['ohne Nachfrist', 'Lieferung verlangen'],
        ['ohne Nachfrist', 'und Ersatz des Verzugsschadens'],
        ['nach Nachfrist', 'Rücktritt vom Vertrag'],
        ['nach Nachfrist', 'Schadensersatz statt der Leistung'],
      ],
      merksatz: 'Rücktritt und Schadensersatz statt der Leistung lassen sich kombinieren.'),
  formel('n-gv-4', 'ls-verzug', 'Zahlungsverzug und Verzugszinsen',
      'Ohne Mahnung kommt der Schuldner spätestens 30 Tage nach Fälligkeit und Zugang der Rechnung in Verzug - Verbraucher nur, wenn die Rechnung darauf hinweist. Dann fallen Verzugszinsen an.',
      'Verbraucher beteiligt:\n'
          '  Basiszins + 5 Prozentpunkte\n'
          'Nur Unternehmen:\n'
          '  Basiszins + 9 Prozentpunkte\n'
          '  + 40 € Pauschale\n'
          '\n'
          'Zins = Betrag × Satz × Tage / 365',
      points: [
        'Beispiel: 10.000 €, nur Unternehmen, Basiszins angenommen 2 %',
        '10.000 € × 11 % × 73 / 365 = 220,00 € Verzugszinsen',
      ]),
  falle('n-gv-5', 'ls-verzug', 'Prozent oder Prozentpunkte?',
      'Verzugszinsen liegen 5 bzw. 9 Prozentpunkte über dem Basiszinssatz. Bei 2 % Basiszins sind das 7 % bzw. 11 % - nicht 2 % × 1,05. Und die drei Mahnungen aus dem Alltag sind keine Voraussetzung: Eine einzige Mahnung genügt.',
      merksatz: 'Verzug = fällig + gemahnt (oder Termin nach Kalender) + zu vertreten.'),

  // ================================================ Mängel und Gewährleistung
  vergleich('n-gm-1', 'ls-maengel', 'Welche Mängel gibt es?',
      'Eine Sache ist mangelhaft, wenn sie bei Übergabe nicht so ist, wie sie sein soll.',
      [
        ['Mangel', 'Beispiel'],
        ['Beschaffenheit', 'Notebook mit defektem Akku'],
        ['Montage', 'Server falsch eingebaut, falsche Anleitung'],
        ['Falschlieferung', 'Monitor 24 statt 27 Zoll'],
        ['Rechtsmangel', 'Software ohne gültige Lizenz verkauft'],
      ]),
  vergleich('n-gm-2', 'ls-maengel', 'Wann wird ein Mangel erkannt?',
      'Nach der Erkennbarkeit unterscheidet man drei Fälle.',
      [
        ['Art', 'Merkmal'],
        ['offen', 'bei Prüfung sofort erkennbar'],
        ['versteckt', 'zeigt sich erst später'],
        ['arglistig verschwiegen', 'Verkäufer kannte ihn und schwieg'],
      ],
      merksatz: 'Unter Kaufleuten gilt die Rügepflicht: Ware unverzüglich prüfen und Mängel unverzüglich melden (§ 377 HGB).'),
  ablauf('n-gm-3', 'ls-maengel', 'Rechte des Käufers',
      'Beispiel: Eine Arztpraxis kauft einen Drucker, der nach zwei Wochen Papier zerknittert.',
      [
        'Vorrangig: Nacherfüllung - der Käufer wählt Nachbesserung (Reparatur) oder Ersatzlieferung',
        'Der Verkäufer bekommt eine angemessene Frist zur Nacherfüllung',
        'Scheitert sie, kann der Käufer nachrangig zurücktreten oder den Preis mindern',
        'Zusätzlich Schadensersatz, wenn der Verkäufer den Mangel zu vertreten hat',
      ]),
  vergleich('n-gm-4', 'ls-maengel', 'Gewährleistung oder Garantie?',
      'Die beiden Begriffe klingen ähnlich, haben aber eine völlig andere Grundlage.',
      [
        ['', 'Gewährleistung', 'Garantie'],
        ['Grundlage', 'Gesetz', 'freiwilliges Versprechen'],
        ['Gegenüber', 'Verkäufer', 'meist Hersteller'],
        ['Dauer', '2 Jahre (neue Sache)', 'frei festgelegt'],
      ]),
  falle('n-gm-5', 'ls-maengel', 'Die Beweislastumkehr',
      'Beim Verbrauchsgüterkauf wird vermutet, dass ein Mangel, der sich im ersten Jahr nach Übergabe zeigt, schon bei Übergabe vorlag (seit 2022; früher sechs Monate). Danach muss die Kundin oder der Kunde das beweisen - die Gewährleistung läuft aber trotzdem zwei Jahre.',
      merksatz: 'Erst Nacherfüllung, dann Rücktritt, Minderung oder Schadensersatz.'),

  // =================================================== Abnahme und Protokoll
  konzept('n-ga-1', 'ls-abnahme', 'Was ist die Abnahme?',
      'Beim Werkvertrag erklärt der Besteller mit der Abnahme, dass er das Werk als im Wesentlichen vertragsgemäß anerkennt. Er ist dazu verpflichtet, wenn das Werk vertragsgemäß hergestellt ist (§ 640 BGB). Wegen unwesentlicher Mängel darf er die Abnahme nicht verweigern.'),
  konzept('n-ga-2', 'ls-abnahme', 'Was die Abnahme auslöst',
      'Mit der Abnahme ändert sich die Rechtslage für beide Seiten.',
      points: [
        'Die Vergütung wird fällig',
        'Die Gefahr geht auf den Besteller über',
        'Die Verjährungsfrist für Mängelansprüche beginnt',
        'Beweislast kehrt sich um: Jetzt muss der Besteller Mängel beweisen',
      ]),
  ablauf('n-ga-3', 'ls-abnahme', 'Eine Abnahme durchführen',
      'Beispiel: Eine Agentur übergibt einem Kunden das fertige Kundenportal.',
      [
        'Abnahmetest gegen die vereinbarten Anforderungen durchführen',
        'Protokoll: Datum, Beteiligte, Gegenstand, festgestellte Mängel mit Frist',
        'Entscheidung: Abnahme, Abnahme unter Vorbehalt oder Verweigerung',
        'Beide Seiten unterschreiben das Protokoll',
      ]),
  falle('n-ga-4', 'ls-abnahme', 'Abnahme ohne Unterschrift',
      'Die Abnahme kann auch fingiert werden: Setzt der Unternehmer nach Fertigstellung eine angemessene Frist und verweigert der Besteller die Abnahme nicht unter Angabe mindestens eines Mangels, gilt das Werk als abgenommen. Auch die produktive Nutzung ohne Beanstandung kann als Abnahme gewertet werden.',
      points: [
        'Bei Verbrauchern nur, wenn sie in Textform auf diese Folge hingewiesen wurden',
      ]),
  merke('n-ga-5', 'ls-abnahme', 'Bekannte Mängel vorbehalten',
      'Wer ein Werk trotz bekannter Mängel ohne Vorbehalt abnimmt, verliert wichtige Rechte zu diesen Mängeln, etwa Nacherfüllung und Minderung.',
      satz: 'Bekannte Mängel gehören ins Abnahmeprotokoll - sonst sind die Rechte darauf weitgehend weg.'),

  // ================================================== Veränderung nach Lewin
  konzept('n-cl-1', 'cm-lewin', 'Das Drei-Phasen-Modell',
      'Kurt Lewin beschreibt Veränderung in Organisationen als drei Phasen: Auftauen, Verändern, Einfrieren. Das Bild dahinter: Ein fester Zustand muss erst gelockert werden, bevor er sich formen lässt, und danach wieder fest werden.'),
  vergleich('n-cl-2', 'cm-lewin', 'Die drei Phasen',
      'Jede Phase hat eine eigene Aufgabe.',
      [
        ['Phase', 'Ziel', 'Maßnahmen'],
        ['Unfreezing (Auftauen)', 'Bereitschaft schaffen', 'informieren, Dringlichkeit zeigen, beteiligen'],
        ['Moving (Verändern)', 'Neues umsetzen', 'schulen, Pilotbetrieb, begleiten'],
        ['Refreezing (Einfrieren)', 'Neues verankern', 'Standards festlegen, Erfolge zeigen'],
      ]),
  ablauf('n-cl-3', 'cm-lewin', 'Beispiel: neues Ticketsystem',
      'Ein IT-Dienstleister ersetzt seine E-Mail-Postfächer für Supportanfragen durch ein Ticketsystem.',
      [
        'Auftauen: Die Leitung zeigt, wie viele Anfragen in Postfächern untergehen, und holt Wünsche des Teams ein',
        'Verändern: Key-User testen im Pilot, alle werden geschult, Fragen werden schnell beantwortet',
        'Einfrieren: Das Postfach wird abgeschaltet, der Ablauf im Handbuch festgeschrieben, Kennzahlen zeigen den Erfolg',
      ]),
  falle('n-cl-4', 'cm-lewin', 'Die vergessenen Phasen',
      'Veränderungen scheitern meist nicht in der Umsetzung, sondern am Anfang oder am Ende. Ohne Auftauen fehlt die Einsicht, ohne Einfrieren kehren alle nach wenigen Wochen zu alten Gewohnheiten zurück. In der Phase des Veränderns sinkt die Leistung oft vorübergehend - das ist normal.'),
  merke('n-cl-5', 'cm-lewin', 'Lewin in einem Satz',
      'Die Reihenfolge ist fest und lässt sich nicht abkürzen.',
      satz: 'Erst lockern, dann formen, dann festigen: Unfreezing, Moving, Refreezing.'),

  // ============================================================ Widerstände
  konzept('n-cw-1', 'cm-widerstand', 'Widerstand ist normal',
      'Fast jede Veränderung stößt auf Widerstand. Er ist kein böser Wille, sondern ein Signal: Den Betroffenen fehlt etwas. Wer die Ursache kennt, kann gezielt reagieren.'),
  vergleich('n-cw-2', 'cm-widerstand', 'Vier Ursachen, vier Antworten',
      'Hinter Widerstand stecken meist vier Ursachen.',
      [
        ['Ursache', 'Antwort'],
        ['nicht wissen', 'informieren, Nutzen erklären'],
        ['nicht können', 'schulen, begleiten'],
        ['nicht wollen', 'beteiligen, Vorteile zeigen'],
        ['nicht dürfen', 'Befugnisse und Rahmen klären'],
      ]),
  vergleich('n-cw-3', 'cm-widerstand', 'Woran man Widerstand erkennt',
      'Widerstand zeigt sich nicht immer offen. Verdeckter Widerstand ist schwerer zu erkennen und deshalb gefährlicher.',
      [
        ['', 'aktiv', 'passiv'],
        ['offen', 'Widerspruch, Beschwerden', 'Schweigen, Rückzug'],
        ['verdeckt', 'Gerüchte, Stimmungsmache', 'Verzögern, Dienst nach Vorschrift'],
      ]),
  ablauf('n-cw-4', 'cm-widerstand', 'Die Veränderungskurve',
      'Viele Menschen durchlaufen bei Veränderungen ähnliche Phasen. Die wahrgenommene eigene Kompetenz sinkt zunächst und steigt erst mit Übung wieder.',
      [
        'Schock und Ablehnung: „Das brauchen wir nicht.“',
        'Einsicht: Die Notwendigkeit wird verstanden',
        'Akzeptanz und Ausprobieren: erste Erfolge, auch Rückschläge',
        'Integration: Das Neue wird selbstverständlich',
      ]),
  falle('n-cw-5', 'cm-widerstand', 'Druck ist die schlechteste Antwort',
      'Wer Widerstand mit Anweisungen und Sanktionen bricht, erzeugt oft nur Scheinanpassung: Das neue System wird pro forma genutzt, die Arbeit läuft daneben weiter. Beteiligung wirkt nachhaltiger, weil Betroffene zu Mitgestaltenden werden.',
      merksatz: 'Erst die Ursache klären - nicht wissen, nicht können, nicht wollen, nicht dürfen -, dann gezielt handeln.'),

  // ========================================================= Kaizen und KVP
  konzept('n-ck-1', 'cm-kaizen', 'Kaizen',
      'Kaizen ist japanisch und bedeutet etwa „Veränderung zum Besseren“. Im deutschen Sprachraum heißt der Ansatz kontinuierlicher Verbesserungsprozess (KVP): viele kleine Verbesserungen, ständig und von allen Mitarbeitenden getragen.',
      points: [
        'kleine, stetige Schritte statt großer Umbrüche',
        'Vorschläge kommen von denen, die die Arbeit machen',
        'Verschwendung (japanisch Muda) erkennen und abbauen',
      ]),
  vergleich('n-ck-2', 'cm-kaizen', 'Kaizen oder Reengineering?',
      'Es gibt zwei gegensätzliche Wege, Prozesse zu verbessern.',
      [
        ['', 'Kaizen / KVP', 'Innovation / Reengineering'],
        ['Tempo', 'evolutionär, stetig', 'radikal, sprunghaft'],
        ['Schritte', 'viele kleine', 'ein großer Umbau'],
        ['Beteiligte', 'alle Mitarbeitenden', 'Management, Experten'],
        ['Risiko', 'gering', 'hoch'],
      ]),
  ablauf('n-ck-3', 'cm-kaizen', 'PDCA als Werkzeug',
      'Jeder Verbesserungsschritt läuft im PDCA-Zyklus. Beispiel: Im Service Desk dauert das Anlegen neuer Benutzerkonten zu lange.',
      [
        'Plan: Ursache analysieren - Daten werden dreimal abgetippt; Ziel: Formular mit Vorlage',
        'Do: Die Vorlage vier Wochen im Team testen',
        'Check: Messen - Bearbeitung sinkt von 20 auf 8 Minuten',
        'Act: Die Vorlage wird Standard, dann beginnt der nächste Zyklus',
      ]),
  konzept('n-ck-4', 'cm-kaizen', 'Verschwendung erkennen',
      'Muda ist alles, was Aufwand kostet, aber keinen Wert für die Kundschaft schafft. Im IT-Alltag sind das zum Beispiel:',
      points: [
        'Wartezeiten, etwa auf Freigaben',
        'Doppelarbeit und unnötige Übergaben',
        'Fehler und Nacharbeit',
        'Funktionen, die niemand nutzt',
      ]),
  falle('n-ck-5', 'cm-kaizen', 'KVP ist kein Projekt',
      'Ein Projekt hat ein Ende, KVP nicht. Wer nach dem ersten Verbesserungszyklus aufhört, betreibt kein Kaizen. Ebenso falsch: Kaizen als Aufgabe nur der Qualitätsabteilung zu sehen.',
      merksatz: 'Kaizen = viele kleine Schritte von allen, ohne Ende. Reengineering = ein großer Schnitt.'),
];
