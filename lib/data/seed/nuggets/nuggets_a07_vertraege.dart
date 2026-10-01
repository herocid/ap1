import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 07 - Vertragsmanagement und Service.
final List<Nugget> nuggetsA07 = [
  // ============================================ Wie ein Vertrag zustande kommt
  konzept(
    'n-vz-1',
    'vt-zustandekommen',
    'Rechtsgeschäft und Willenserklärung',
    'Ein Rechtsgeschäft löst eine gewollte Rechtsfolge aus, etwa einen Kauf oder eine Kündigung. Es besteht aus einer oder mehreren Willenserklärungen. Eine Willenserklärung ist die Äußerung eines Willens, der unmittelbar auf eine Rechtsfolge zielt, zum Beispiel „Ich bestelle drei Notebooks“.',
    points: [
      'Ausdrücklich: mündlich, schriftlich, per E-Mail oder per Klick im Webshop',
      'Durch schlüssiges Handeln (konkludent): Ware an der Kasse aufs Band legen',
      'Schweigen ist grundsätzlich keine Willenserklärung',
      'Unter Abwesenden wird eine Erklärung erst mit Zugang wirksam (§ 130 BGB); ein Widerruf muss spätestens gleichzeitig zugehen',
      'Einseitige Rechtsgeschäfte brauchen eine Erklärung, Verträge mindestens zwei übereinstimmende',
    ],
    skizze: BaumDiagramm(
      BaumKnoten('Rechtsgeschäfte', [
        BaumKnoten('einseitig', [], 'Kündigung, Anfechtung'),
        BaumKnoten('mehrseitig = Vertrag', [
          BaumKnoten('einseitig verpflichtend', [], 'Schenkung, Bürgschaft'),
          BaumKnoten('zweiseitig verpflichtend', [], 'Kauf, Miete, Werk'),
        ]),
      ]),
    ),
  ),
  konzept(
    'n-vz-2',
    'vt-zustandekommen',
    'Antrag und Annahme',
    'Ein Vertrag entsteht durch zwei übereinstimmende Willenserklärungen: den Antrag (§ 145 BGB) und die Annahme. Den Antrag kann jede Seite machen: der Verkäufer mit einem verbindlichen Angebot oder der Kunde mit einer Bestellung.',
    points: [
      'Weg 1: Angebot des Händlers (Antrag) + Bestellung des Kunden (Annahme)',
      'Weg 2: Bestellung ohne vorheriges Angebot (Antrag) + Auftragsbestätigung oder sofortige Lieferung (Annahme)',
      'Der Antrag muss die wesentlichen Punkte enthalten: Ware bzw. Leistung, Menge, Preis',
      'Wer einen Antrag macht, ist daran gebunden, solange er ihn nicht ausdrücklich unverbindlich gestellt hat',
    ],
  ),
  vergleich(
    'n-vz-3',
    'vt-zustandekommen',
    'Antrag oder nur Einladung?',
    'Nicht jede Äußerung ist schon ein Antrag. Werbung, Kataloge und Webshop-Seiten richten sich an alle und laden nur dazu ein, selbst einen Antrag abzugeben. Sonst müsste ein Händler mit jedem Interessenten einen Vertrag schließen, auch wenn die Ware längst ausverkauft ist.',
    [
      ['Äußerung', 'Rechtliche Wirkung'],
      ['Anfrage des Kunden', 'unverbindlich, kein Antrag'],
      ['Katalog, Werbung, Webshop', 'Aufforderung zum Antrag'],
      ['Angebot an eine bestimmte Person', 'Antrag, bindend'],
      ['Bestellung', 'Antrag oder Annahme'],
      ['Auftragsbestätigung', 'Annahme'],
    ],
    merksatz:
        'Die Aufforderung zum Antrag heißt lateinisch invitatio ad offerendum.',
  ),
  ablauf(
    'n-vz-4',
    'vt-zustandekommen',
    'Wie lange bindet ein Angebot?',
    'Wer ein Angebot macht, ist daran gebunden, aber nicht unbegrenzt. Beispiel: Ein Systemhaus schickt einer Arztpraxis am Montag per E-Mail ein Angebot über drei Notebooks.',
    [
      'Unter Anwesenden (auch am Telefon): Annahme nur sofort möglich (§ 147 Abs. 1 BGB)',
      'Unter Abwesenden (Brief, E-Mail): bis eine Antwort unter regelmäßigen Umständen zu erwarten ist (§ 147 Abs. 2)',
      'Mit Frist („gültig bis 30.11.“): bis zum Ablauf der Frist (§ 148)',
      'Die Praxis bestellt am Mittwoch zu den Angebotsbedingungen -> Vertrag kommt zustande',
      'Bestellt sie erst nach sechs Wochen oder zu einem anderen Preis -> neuer Antrag (§ 150); das Systemhaus kann annehmen oder ablehnen',
    ],
  ),
  skizze(
    'n-vz-5',
    'vt-zustandekommen',
    'Vertragsschluss im Webshop',
    'Im Onlinehandel ist die Artikelseite nur eine Aufforderung zum Antrag. Den Antrag macht der Kunde mit dem Klick auf „Zahlungspflichtig bestellen“. Die automatische Eingangsbestätigung ist Pflicht, meist aber noch keine Annahme.',
    SequenzDiagramm(
      ['Kunde', 'Webshop'],
      [
        Nachricht(1, 0, 'Artikelseite (kein Antrag)'),
        Nachricht(0, 1, 'Bestellung = Antrag'),
        Nachricht(1, 0, 'Eingangsbestätigung', antwort: true),
        Nachricht(1, 0, 'Versandbestätigung = Annahme', antwort: true),
      ],
    ),
    points: [
      'Die Eingangsbestätigung bestätigt nur, dass die Bestellung angekommen ist (§ 312i BGB)',
      'Entscheidend ist der Wortlaut: „Wir nehmen Ihre Bestellung an“ wäre bereits eine Annahme',
      'Auch das Absenden der Ware gilt als Annahme',
    ],
  ),
  skizze(
    'n-vz-6',
    'vt-zustandekommen',
    'Prüfschema: Ist ein Vertrag entstanden?',
    'Mit diesem Schema prüfst du jeden Fall in der gleichen Reihenfolge. Scheitert eine Frage, entsteht kein Vertrag. Aus der Antwort wird aber ein neuer Antrag, den die andere Seite annehmen kann.',
    FlussDiagramm([
      FlussKnoten(
        'Antrag an bestimmte Person?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] nur Einladung',
      ),
      FlussKnoten(
        'Annahme rechtzeitig?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] neuer Antrag',
      ),
      FlussKnoten(
        'Annahme deckungsgleich?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] neuer Antrag',
      ),
      FlussKnoten('Vertrag geschlossen', form: FlussForm.ende),
    ]),
  ),
  beispiel(
    'n-vz-7',
    'vt-zustandekommen',
    'Rechtsfall: Monitore für die Kanzlei',
    'Ein Systemhaus mailt einer Kanzlei am 3. März ein Angebot: 5 Monitore zu je 240 €, gültig bis 17. März. Die Kanzlei antwortet am 12. März: „Wir nehmen 5 Monitore zu je 220 €.“ Das Systemhaus reagiert nicht. Ist ein Kaufvertrag zustande gekommen?',
    schritte: [
      'Antrag: Angebot an eine bestimmte Kanzlei mit Ware, Menge und Preis, bindend bis 17. März (§ 148 BGB)',
      'Antwort vom 12. März: rechtzeitig, aber mit anderem Preis',
      'Eine abgeänderte Annahme gilt als Ablehnung, verbunden mit einem neuen Antrag (§ 150 Abs. 2 BGB)',
      'Das Systemhaus schweigt auf den neuen Antrag, und Schweigen ist keine Annahme',
    ],
    ergebnis:
        'Kein Vertrag. Die Kanzlei hat nur einen neuen Antrag über 220 € je Monitor gemacht.',
  ),
  vergleich(
    'n-vz-8',
    'vt-zustandekommen',
    'Geschäftsfähigkeit',
    'Wirksam Verträge schließen kann nur, wer geschäftsfähig ist. Die Stufe richtet sich nach dem Alter. Rechtsfähig (also Träger von Rechten und Pflichten) ist dagegen jeder Mensch schon ab der Geburt.',
    [
      ['Alter', 'Stufe', 'Folge'],
      ['unter 7', 'geschäftsunfähig', 'Erklärung nichtig (§ 105)'],
      ['7 bis 17', 'beschränkt geschäftsfähig', 'Zustimmung der Eltern nötig'],
      ['ab 18', 'voll geschäftsfähig', 'uneingeschränkt wirksam'],
    ],
    points: [
      'Ohne Zustimmung geschlossen: schwebend unwirksam, bis die Eltern genehmigen oder ablehnen (§ 108 BGB)',
      'Zustimmungsfrei: Geschäfte, die nur einen rechtlichen Vorteil bringen, z. B. ein Geschenk annehmen (§ 107)',
      'Taschengeldparagraf (§ 110): wirksam, wenn mit frei überlassenen Mitteln vollständig bezahlt wird',
      'Ein Ratenkauf fällt nicht unter § 110, denn er ist erst mit der letzten Rate bezahlt',
    ],
  ),
  vergleich(
    'n-vz-9',
    'vt-zustandekommen',
    'Nichtig oder anfechtbar?',
    'Ein fehlerhaftes Rechtsgeschäft ist entweder von Anfang an nichtig oder nur anfechtbar. Ein anfechtbares Geschäft gilt zunächst. Erst wenn die betroffene Seite die Anfechtung erklärt, wird es rückwirkend nichtig (§ 142 BGB).',
    [
      ['', 'Nichtig', 'Anfechtbar'],
      ['gilt', 'nie wirksam', 'wirksam bis zur Anfechtung'],
      ['Erklärung nötig', 'nein', 'ja, Anfechtung'],
      ['danach', '–', 'von Anfang an nichtig'],
    ],
    points: [
      'Nichtig: Geschäftsunfähige (§ 105), Scheingeschäft (§ 117), Scherzerklärung (§ 118), fehlende gesetzliche Form (§ 125)',
      'Nichtig auch: Verstoß gegen ein gesetzliches Verbot (§ 134) oder gegen die guten Sitten, z. B. Wucher (§ 138)',
      'Anfechtbar: Irrtum (§ 119), falsche Übermittlung (§ 120), arglistige Täuschung oder widerrechtliche Drohung (§ 123)',
    ],
  ),
  vergleich(
    'n-vz-10',
    'vt-zustandekommen',
    'Anfechtungsgründe und Fristen',
    'Anfechten kann nur, wer sich über seine Erklärung geirrt hat oder getäuscht bzw. bedroht wurde. Die Fristen unterscheiden sich deutlich.',
    [
      ['Grund', 'Beispiel', 'Frist'],
      ['Erklärungsirrtum', '1.000 statt 100 Stück getippt', 'unverzüglich'],
      [
        'Inhaltsirrtum',
        '1 „Gros“ bestellt im Glauben, das seien 100 Stück (es sind 144)',
        'unverzüglich',
      ],
      ['Eigenschaftsirrtum', 'Kopie für Original gehalten', 'unverzüglich'],
      [
        'arglistige Täuschung',
        'Unfallwagen als unfallfrei verkauft',
        '1 Jahr ab Entdeckung',
      ],
      [
        'widerrechtliche Drohung',
        'Unterschrift unter Druck',
        '1 Jahr ab Ende der Zwangslage',
      ],
    ],
    points: [
      'Unverzüglich heißt: ohne schuldhaftes Zögern (§ 121 BGB)',
      'Wer wegen Irrtums anficht, ersetzt der anderen Seite den Vertrauensschaden (§ 122 BGB)',
      'Nicht anfechtbar ist der Motivirrtum: falsch kalkuliert oder die Ware doch nicht gebraucht',
    ],
  ),
  vergleich(
    'n-vz-11',
    'vt-zustandekommen',
    'Formvorschriften',
    'Verträge sind grundsätzlich formfrei: Ein Handschlag, ein Telefonat oder eine E-Mail genügt. Nur wo das Gesetz eine Form verlangt, ist sie Pflicht. Fehlt sie, ist das Geschäft nichtig (§ 125 BGB).',
    [
      ['Form', 'Merkmal', 'Beispiel'],
      ['formfrei', 'Regelfall', 'Kauf eines Notebooks'],
      [
        'Textform (§ 126b)',
        'lesbar, Person genannt, z. B. E-Mail',
        'Mieterhöhung bei Wohnraum',
      ],
      [
        'Schriftform (§ 126)',
        'eigenhändige Unterschrift',
        'Kündigung eines Arbeitsvertrags',
      ],
      ['notarielle Beurkundung', 'Notar beurkundet', 'Grundstückskauf'],
    ],
    merksatz:
        'In der Praxis werden IT-Verträge trotzdem schriftlich geschlossen, als Beweis, was vereinbart wurde.',
  ),
  konzept(
    'n-vz-12',
    'vt-zustandekommen',
    'Allgemeine Geschäftsbedingungen',
    'AGB sind vorformulierte Vertragsbedingungen für viele Verträge (§ 305 BGB), etwa die Liefer- und Zahlungsbedingungen eines Onlineshops. Gegenüber Verbrauchern werden sie nur Vertragsbestandteil, wenn bei Vertragsschluss ausdrücklich auf sie hingewiesen wurde und der Kunde sie zumutbar zur Kenntnis nehmen konnte.',
    points: [
      'Individuell ausgehandelte Absprachen haben Vorrang (§ 305b)',
      'Überraschende Klauseln werden nicht Vertragsbestandteil; Unklarheiten gehen zulasten des Verwenders (§ 305c)',
      'Unangemessen benachteiligende Klauseln sind unwirksam (§§ 307–309), z. B. ein Ausschluss der Gewährleistung für neue Waren gegenüber Verbrauchern',
      'Ist eine Klausel unwirksam, bleibt der Vertrag bestehen; statt der Klausel gilt das Gesetz (§ 306)',
    ],
  ),
  falle(
    'n-vz-13',
    'vt-zustandekommen',
    'Freibleibend, Schweigen, Widerruf',
    'Mit „freibleibend“ oder „solange Vorrat reicht“ schränkt der Anbietende seine Bindung ein. Schweigen auf einen Antrag ist grundsätzlich keine Annahme. Ausnahme unter Kaufleuten: Wer einem kaufmännischen Bestätigungsschreiben nicht unverzüglich widerspricht, muss dessen Inhalt gegen sich gelten lassen.',
    points: [
      'Verbraucher können Fernabsatzverträge (Webshop, Telefon) in der Regel 14 Tage ohne Grund widerrufen (§§ 312g, 355 BGB). Das ist ein eigenes Recht, keine Anfechtung',
      'Wer Verbrauchern unbestellte Ware schickt, hat keinen Anspruch auf Bezahlung (§ 241a BGB)',
      'Unternehmer untereinander haben kein gesetzliches Widerrufsrecht',
    ],
  ),
  merke(
    'n-vz-14',
    'vt-zustandekommen',
    'Vertragsschluss auf einen Blick',
    'Prüfe jeden Fall in dieser Reihenfolge: Wer hat den Antrag gemacht, wurde er rechtzeitig und unverändert angenommen, und waren beide geschäftsfähig?',
    points: [
      'Katalog, Werbung, Webshop = Aufforderung zum Antrag',
      'Verspätete oder geänderte Annahme = neuer Antrag',
      'Nichtig = nie wirksam; anfechtbar = wirksam bis zur Anfechtung',
      'Formfrei ist die Regel, Form die Ausnahme',
    ],
    satz:
        'Antrag + rechtzeitige, deckungsgleiche Annahme = Vertrag. Alles andere ist ein neuer Antrag.',
  ),

  // ============================================================ Vertragsarten
  konzept(
    'n-vy-1',
    'vt-arten',
    'Erfolg oder Tätigkeit?',
    'Die wichtigste Frage bei IT-Verträgen lautet: Was genau wird geschuldet? Beim Werkvertrag ein Erfolg, etwa eine funktionierende Software. Beim Dienstvertrag nur das Tätigwerden, etwa Beratungsstunden. Ein bestimmtes Ergebnis ist nicht versprochen.',
    points: [
      'Die Vertragsart entscheidet, ob es eine Abnahme gibt, wann bezahlt wird und welche Rechte bei Fehlern bestehen',
      'Das BGB regelt die typischen Verträge im Besonderen Schuldrecht (§§ 433 ff.)',
    ],
  ),
  vergleich(
    'n-vy-2',
    'vt-arten',
    'Die Vertragsarten mit Paragraphen',
    'Jede Vertragsart hat eine eigene Hauptpflicht. Für die Prüfung solltest du Vertrag, Paragraph und ein IT-Beispiel zusammen nennen können.',
    [
      ['Vertrag', 'Geschuldet', 'IT-Beispiel'],
      [
        'Kauf, §§ 433 ff.',
        'Sache übergeben und übereignen',
        'Hardware, Standardsoftware',
      ],
      ['Werk, §§ 631 ff.', 'ein Erfolg (Werk)', 'Individualsoftware'],
      ['Dienst, §§ 611 ff.', 'eine Tätigkeit', 'Support nach Stunden'],
      [
        'Miete, §§ 535 ff.',
        'Gebrauch auf Zeit gegen Entgelt',
        'Server mieten, SaaS',
      ],
      [
        'Leasing (nicht im BGB)',
        'Gebrauch, Leasinggeber finanziert',
        'Notebookflotte',
      ],
      [
        'Werklieferung, § 650',
        'bewegliche Sache herstellen und liefern',
        'Serverschrank nach Maß',
      ],
    ],
  ),
  vergleich(
    'n-vy-3',
    'vt-arten',
    'Weitere Vertragsarten',
    'Neben den sechs wichtigsten Verträgen kommen in Prüfungen weitere vor. Sie lassen sich meist über ein einziges Merkmal abgrenzen, etwa ob etwas unentgeltlich ist.',
    [
      ['Vertrag', 'Kern', 'Beispiel'],
      [
        'Leihe, §§ 598 ff.',
        'Gebrauch, unentgeltlich',
        'Vorführgerät zum Testen',
      ],
      ['Pacht, §§ 581 ff.', 'Gebrauch und Erträge', 'Kantine samt Ausstattung'],
      [
        'Darlehen, §§ 488 ff.',
        'Geld auf Zeit, meist mit Zins',
        'Kredit für neue Server',
      ],
      [
        'Schenkung, § 516',
        'unentgeltliche Zuwendung',
        'Altgeräte an eine Schule',
      ],
      [
        'Arbeitsvertrag, § 611a',
        'weisungsgebundene Arbeit',
        'Anstellung als Admin',
      ],
    ],
    merksatz:
        'Miete kostet, Leihe ist gratis. Beide überlassen eine Sache nur auf Zeit.',
  ),
  vergleich(
    'n-vy-4',
    'vt-arten',
    'Pflichten der Vertragspartner',
    'Verträge sind meist zweiseitig verpflichtend: Beide Seiten haben Hauptpflichten. Wer eine davon verletzt, löst eine Leistungsstörung aus, etwa Verzug oder einen Mangel.',
    [
      ['Vertrag', 'Anbieter muss', 'Kunde muss'],
      ['Kauf', 'übergeben, übereignen, mangelfrei', 'zahlen, Ware abnehmen'],
      ['Werk', 'Werk mangelfrei herstellen', 'abnehmen, vergüten'],
      ['Dienst', 'Dienste leisten', 'vergüten'],
      ['Miete', 'Gebrauch gewähren, instand halten', 'Miete zahlen'],
    ],
  ),
  konzept(
    'n-vy-5',
    'vt-arten',
    'Kaufvertrag: Verpflichtung und Erfüllung',
    'Mit dem Kaufvertrag verpflichten sich beide Seiten nur (Verpflichtungsgeschäft). Erfüllt wird getrennt davon: Der Verkäufer übergibt und übereignet die Ware, der Käufer zahlt (Erfüllungsgeschäft). Erst mit der Übereignung wechselt das Eigentum.',
    points: [
      'Besitz = tatsächliche Herrschaft (wer das Notebook hat); Eigentum = rechtliche Herrschaft (wem es gehört)',
      'Unter Eigentumsvorbehalt bleibt der Verkäufer Eigentümer, bis vollständig bezahlt ist (§ 449 BGB)',
      'Verbrauchsgüterkauf: Unternehmer verkauft an Verbraucher, mit besonderem Schutz',
      'Handelskauf: zwischen Kaufleuten, mit Rügepflicht (§ 377 HGB)',
      'Bürgerlicher Kauf: Privatperson verkauft an Privatperson',
    ],
  ),
  skizze(
    'n-vy-6',
    'vt-arten',
    'Einen Vertrag einordnen',
    'Mit diesen Fragen ordnest du fast jeden IT-Vertrag zu. Stell sie der Reihe nach und hör bei der ersten Antwort „ja“ auf.',
    FlussDiagramm([
      FlussKnoten(
        'Eigentum an einer Sache?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] Kaufvertrag',
      ),
      FlussKnoten(
        'Gebrauch auf Zeit?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] Miete, Leasing, Leihe',
      ),
      FlussKnoten(
        'Erfolg geschuldet?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] Werkvertrag',
      ),
      FlussKnoten('Dienstvertrag', form: FlussForm.ende),
    ]),
    points: [
      'Gebrauch auf Zeit: gegen Entgelt Miete, unentgeltlich Leihe, finanziert Leasing',
      'Soll eine bewegliche Sache erst hergestellt werden, ist es ein Werklieferungsvertrag mit Kaufrecht',
    ],
  ),
  beispiel(
    'n-vy-7',
    'vt-arten',
    'Drei IT-Verträge einordnen',
    'Ein Autohaus schließt drei Verträge: (1) 12 Notebooks für zusammen 10.800 €, (2) Programmierung einer Online-Terminbuchung zum Festpreis von 18.000 €, (3) Unterstützung durch einen Administrator für 95 € je Stunde.',
    schritte: [
      '(1) Eigentum an fertigen Sachen gegen Geld -> Kaufvertrag (§ 433 BGB)',
      '(2) Ein funktionierendes Ergebnis ist versprochen -> Werkvertrag (§ 631 BGB); die 18.000 € werden mit der Abnahme fällig',
      '(3) Bezahlt wird Arbeitszeit, kein Ergebnis -> Dienstvertrag (§ 611 BGB); es gibt keine Abnahme',
      'Kontrolle: Werk = Erfolg + Abnahme, Dienst = Tätigkeit ohne Abnahme',
    ],
    ergebnis:
        'Kauf, Werk, Dienst: Entscheidend ist jeweils, was geschuldet wird.',
  ),
  vergleich(
    'n-vy-8',
    'vt-arten',
    'Typische IT-Leistungen zugeordnet',
    'Diese Zuordnungen kommen in Prüfungen immer wieder vor. Gemischte Verträge sind häufig. Dann gilt für jeden Teil das passende Recht.',
    [
      ['Leistung', 'Vertragsart'],
      ['Hardware kaufen', 'Kauf'],
      ['Standardsoftware, Dauerlizenz, Einmalpreis', 'Kauf'],
      ['Individualsoftware zum Festpreis', 'Werk'],
      ['Anpassung mit festem Ergebnis', 'Werk'],
      ['Support, Beratung nach Stunden', 'Dienst'],
      ['SaaS, Cloud-Software im Abo', 'Miete'],
      ['Server im Rechenzentrum mieten', 'Miete'],
      ['Geräte leasen', 'Leasing, wie Miete'],
    ],
  ),
  konzept(
    'n-vy-9',
    'vt-arten',
    'SaaS als Miete: was daraus folgt',
    'Der Bundesgerichtshof hat die Bereitstellung von Software über das Internet (ASP) als Miete eingeordnet; für SaaS gilt das nach herrschender Meinung entsprechend. Der Anbieter muss die Software deshalb während der ganzen Laufzeit nutzbar halten (§ 535 BGB). Fällt sie erheblich aus, mindert sich die Gebühr für diese Zeit automatisch (§ 536 BGB), und der Kunde muss keine Frist setzen.',
    points: [
      'Verfügbarkeit und Reaktionszeiten werden zusätzlich im SLA konkret geregelt',
      'Der Kunde muss einen Ausfall melden, sonst kann er Rechte verlieren (§ 536c BGB)',
      'Für Verbraucherverträge über digitale Produkte (Apps, Streaming, Cloud) gelten seit 2022 zusätzlich die §§ 327 ff. BGB, inklusive Update-Pflicht',
    ],
  ),
  konzept(
    'n-vy-10',
    'vt-arten',
    'Leasing und Werklieferung',
    'Leasing ist im BGB nicht eigens geregelt und wird im Kern wie Miete behandelt: Die Leasinggesellschaft kauft das Gerät und überlässt es gegen monatliche Raten. Beim Werklieferungsvertrag stellt der Unternehmer eine bewegliche Sache her und liefert sie; dafür gilt Kaufrecht (§ 650 BGB).',
    points: [
      'Leasing: Die Liquidität bleibt erhalten, Geräte werden nach der Laufzeit erneuert',
      'Mängelrechte gegen den Händler tritt die Leasinggesellschaft meist an den Leasingnehmer ab',
      'Werklieferung: Serverschrank nach Maß, Spezialgehäuse: Kaufrecht, obwohl hergestellt wird',
    ],
  ),
  konzept(
    'n-vy-11',
    'vt-arten',
    'Was ein IT-Vertrag regeln sollte',
    'Egal welche Vertragsart: Streit entsteht fast immer dort, wo der Vertrag schweigt. Diese Punkte gehören in jeden IT-Vertrag.',
    points: [
      'Vertragsparteien und Vertragsgegenstand',
      'Leistungsbeschreibung, z. B. Verweis auf das Pflichtenheft',
      'Vergütung, Zahlungsbedingungen, Termine',
      'Mitwirkungspflichten des Kunden: Testdaten, Ansprechpartner, Zugänge',
      'Abnahme, Gewährleistung, Haftung, Vertragsstrafe',
      'Nutzungsrechte, Datenschutz, Vertraulichkeit',
      'Laufzeit und Kündigung',
    ],
  ),
  falle(
    'n-vy-12',
    'vt-arten',
    'Der Name entscheidet nicht',
    'Steht „Dienstleistungsvertrag“ über einem Vertrag, in dem eine fertige App geschuldet wird, ist es trotzdem ein Werkvertrag. Maßgeblich ist der Inhalt, nicht die Überschrift. Genauso ist ein „Softwarekauf“ als Abo mit monatlicher Gebühr in Wahrheit Miete.',
    points: [
      'Werklieferungsvertrag: Für herzustellende bewegliche Sachen gilt Kaufrecht',
      '„Abnahme“ beim Kauf heißt nur Entgegennahme der Ware. Die Billigung als vertragsgemäß gibt es nur beim Werkvertrag',
    ],
  ),
  merke(
    'n-vy-13',
    'vt-arten',
    'Vertragsarten auf einen Blick',
    'Vier Fragen trennen die wichtigsten Vertragsarten sauber.',
    points: [
      'Eigentum an einer Sache -> Kauf (§ 433)',
      'Erfolg geschuldet -> Werk (§ 631)',
      'Tätigkeit geschuldet -> Dienst (§ 611)',
      'Gebrauch auf Zeit -> Miete (§ 535), Leasing oder Leihe (§ 598)',
    ],
    satz:
        'Werkvertrag = Erfolg + Abnahme. Dienstvertrag = Tätigkeit, keine Abnahme. SaaS = Miete.',
  ),

  // ================================================ Urheberrecht und Lizenzen
  konzept(
    'n-vu-1',
    'vt-urheber',
    'Software ist urheberrechtlich geschützt',
    'Computerprogramme sind nach §§ 69a ff. UrhG geschützt, und zwar in jeder Form: Quellcode, Maschinencode und Entwurfsmaterial. Der Schutz entsteht automatisch mit der Schöpfung, ohne Anmeldung und ohne ©-Vermerk.',
    points: [
      'Voraussetzung: eine eigene geistige Schöpfung; besondere Qualität oder Ästhetik ist nicht nötig (§ 69a Abs. 3)',
      'Nicht geschützt sind Ideen und Grundsätze, auch die einer Schnittstelle (§ 69a Abs. 2)',
      'Die Idee „Terminbuchung per Chatbot“ ist frei; der konkrete Code ist geschützt',
    ],
  ),
  konzept(
    'n-vu-2',
    'vt-urheber',
    'Urheber ist immer ein Mensch',
    'Urheber ist, wer das Werk geschaffen hat (§ 7 UrhG), immer eine natürliche Person, nie eine Firma. Das Urheberrecht selbst ist nicht übertragbar, nur vererbbar (§§ 28, 29 UrhG). Es erlischt 70 Jahre nach dem Tod des Urhebers (§ 64 UrhG).',
    points: [
      'Mehrere Entwickler ohne trennbare Anteile sind Miturheber (§ 8)',
      'Übertragen werden nur Nutzungsrechte. Eine Lizenz ist die Einräumung solcher Rechte',
    ],
  ),
  skizze(
    'n-vu-3',
    'vt-urheber',
    'Was im Urheberrecht steckt',
    'Das Urheberrecht hat zwei Seiten. Das Persönlichkeitsrecht bleibt immer beim Urheber. Die Verwertungsrechte nutzt er selbst oder räumt anderen Nutzungsrechte daran ein.',
    BaumDiagramm(
      BaumKnoten('Urheberrecht', [
        BaumKnoten('Persönlichkeitsrecht', [
          BaumKnoten('Veröffentlichung'),
          BaumKnoten('Namensnennung'),
          BaumKnoten('Schutz vor Entstellung'),
        ]),
        BaumKnoten('Verwertungsrechte', [
          BaumKnoten('Vervielfältigen'),
          BaumKnoten('Bearbeiten'),
          BaumKnoten('Verbreiten, Vermieten'),
          BaumKnoten('Online zugänglich machen'),
        ], '§ 69c'),
      ]),
    ),
    points: [
      'Jede Installation ist eine Vervielfältigung, deshalb braucht man dafür ein Nutzungsrecht',
    ],
  ),
  vergleich(
    'n-vu-4',
    'vt-urheber',
    'Einfach oder ausschließlich?',
    'Nutzungsrechte unterscheiden sich darin, wer sie außerdem noch haben darf (§ 31 UrhG).',
    [
      ['', 'Einfaches Nutzungsrecht', 'Ausschließliches Nutzungsrecht'],
      ['Wirkung', 'Nutzung neben anderen', 'nur der Inhaber nutzt'],
      [
        'Rechteinhaber',
        'darf weitere Lizenzen vergeben',
        'darf keine weiteren vergeben',
      ],
      [
        'Urheber selbst',
        'nutzt weiter',
        'ausgeschlossen, außer er behält sich die Nutzung vor',
      ],
      [
        'Beispiel',
        'Office-Lizenz im Büro',
        'Auftragssoftware exklusiv für einen Kunden',
      ],
    ],
  ),
  vergleich(
    'n-vu-5',
    'vt-urheber',
    'Nutzungsrechte beschränken',
    'Nutzungsrechte lassen sich räumlich, zeitlich und inhaltlich beschränken (§ 31 Abs. 1 UrhG). Was der Vertrag nicht ausdrücklich nennt, gilt im Zweifel nur so weit eingeräumt, wie es der Vertragszweck erfordert (Zweckübertragungslehre, § 31 Abs. 5).',
    [
      ['Beschränkung', 'Beispiel'],
      ['räumlich', 'nur in Deutschland'],
      ['zeitlich', 'Laufzeit 3 Jahre'],
      ['inhaltlich', 'nur intern, höchstens 25 Nutzer'],
    ],
    points: [
      'Wer den Quellcode braucht, etwa für eigene Weiterentwicklung, muss das ausdrücklich vereinbaren',
      'Alternative: Hinterlegung des Quellcodes bei einem Treuhänder (Escrow), falls der Hersteller ausfällt',
    ],
  ),
  ablauf(
    'n-vu-6',
    'vt-urheber',
    'Software im Arbeitsverhältnis',
    'Für Angestellte gibt es eine Sonderregel. Beispiel: Ein Entwickler schreibt im Auftrag seines Arbeitgebers ein Tool für die Kundenverwaltung.',
    [
      'Urheber bleibt der Entwickler als Mensch',
      'Entsteht das Programm in Erfüllung seiner Aufgaben, darf allein der Arbeitgeber alle vermögensrechtlichen Befugnisse ausüben (§ 69b UrhG)',
      'Der Arbeitgeber darf das Tool nutzen, ändern, verkaufen und lizenzieren',
      'Der Entwickler darf es nicht selbst verwerten oder weiterverkaufen',
      'Für Freiberufler und Agenturen gilt § 69b nicht. Dort regelt allein der Vertrag die Rechte',
    ],
  ),
  beispiel(
    'n-vu-7',
    'vt-urheber',
    'Rechtsfall: Wem gehört die App?',
    'Eine Agentur lässt eine App von ihrem angestellten Entwickler programmieren. Ein Zusatzmodul schreibt ein freiberuflicher Entwickler; in seinem Vertrag stehen nur Preis und Termin, nichts zu Nutzungsrechten. Die Agentur will App und Modul exklusiv an einen Kunden lizenzieren.',
    schritte: [
      'Urheber sind in beiden Fällen die Entwickler als Menschen (§ 7 UrhG)',
      'App: Der Angestellte hat sie in Erfüllung seiner Aufgaben geschaffen -> Verwertungsrechte bei der Agentur (§ 69b UrhG)',
      'Modul: § 69b gilt nicht für Freiberufler -> die Agentur hat nur die Rechte, die der Vertragszweck erfordert (§ 31 Abs. 5 UrhG)',
      'Ob ein exklusives Weiterlizenzieren an Dritte gedeckt ist, bleibt unsicher',
      'Lösung: mit dem Freiberufler schriftlich ein ausschließliches, übertragbares Nutzungsrecht vereinbaren',
    ],
    ergebnis:
        'App: Die Agentur darf verwerten. Modul: Rechte erst ausdrücklich vom Freiberufler einräumen lassen.',
  ),
  vergleich(
    'n-vu-8',
    'vt-urheber',
    'Was Nutzer auch ohne Erlaubnis dürfen',
    'Wer ein Programm rechtmäßig nutzt, hat einige gesetzliche Rechte (§§ 69d, 69e UrhG). Sicherungskopie, Testen und Dekompilieren für Schnittstellen kann ihm kein Lizenzvertrag nehmen (§ 69g Abs. 2). Alles darüber hinaus braucht die Zustimmung des Rechteinhabers.',
    [
      ['Handlung', 'Erlaubt?'],
      ['bestimmungsgemäß nutzen, Fehler berichtigen', 'ja, § 69d Abs. 1'],
      ['nötige Sicherungskopie anlegen', 'ja, § 69d Abs. 2'],
      ['Funktion beobachten und testen', 'ja, § 69d Abs. 3'],
      ['dekompilieren für Schnittstellen', 'eng begrenzt, § 69e'],
      ['Kopien weitergeben', 'nein'],
      ['mehr Installationen als lizenziert', 'nein'],
    ],
  ),
  konzept(
    'n-vu-9',
    'vt-urheber',
    'Lizenz statt Eigentum',
    'Wer Software „kauft“, erwirbt ein Nutzungsrecht am Programm, nicht das Programm selbst. Wurde eine Programmkopie mit Zustimmung des Rechteinhabers in der EU verkauft, darf genau diese Kopie weiterverkauft werden (Erschöpfung, § 69c Nr. 3 UrhG).',
    points: [
      'Das gilt nach dem EuGH (UsedSoft, 2012) auch für per Download gekaufte Dauerlizenzen',
      'Voraussetzung: Der Verkäufer macht seine eigene Kopie unbrauchbar',
      'Keine Erschöpfung bei Miete und Abo (SaaS), denn hier wird nichts verkauft',
      'Kostenlos heißt nicht frei: Auch Freeware und Open Source haben Lizenzbedingungen, etwa die Copyleft-Pflicht der GPL',
    ],
  ),
  vergleich(
    'n-vu-10',
    'vt-urheber',
    'Urheberrecht, Patent, Marke',
    'Drei Schutzrechte werden oft verwechselt. Nur das Urheberrecht entsteht ohne Anmeldung.',
    [
      ['', 'Urheberrecht', 'Patent', 'Marke'],
      [
        'schützt',
        'Werk, z. B. Code',
        'technische Erfindung',
        'Kennzeichen, z. B. Logo',
      ],
      ['entsteht', 'automatisch', 'Anmeldung, Prüfung', 'Eintragung'],
      ['Dauer', '70 J. nach Tod', 'max. 20 Jahre', '10 J., verlängerbar'],
    ],
    points: [
      'Software „als solche“ ist nicht patentierbar (§ 1 Abs. 3 PatG), nur technische Erfindungen, in denen Software steckt',
    ],
  ),
  falle(
    'n-vu-11',
    'vt-urheber',
    'Was eine Lizenz erlaubt',
    'Maßgeblich sind die Lizenzbedingungen: Anzahl der Geräte oder Nutzer, Laufzeit, gewerbliche Nutzung. Eine Sicherungskopie darf anfertigen, wer zur Nutzung berechtigt ist, soweit sie für die künftige Nutzung erforderlich ist. Weitergeben darf man sie nicht.',
    points: [
      'Eine Lizenz für 5 Arbeitsplätze erlaubt keine sechste Installation',
      'Verstöße: Anspruch auf Unterlassung und Schadensersatz (§ 97 UrhG), unerlaubte Verwertung ist strafbar (§ 106 UrhG)',
      'Wer einem Freiberufler Code abkauft, ohne Nutzungsrechte zu regeln, hat oft weniger Rechte als gedacht',
    ],
  ),
  merke(
    'n-vu-12',
    'vt-urheber',
    'Wem gehört die Software?',
    'Urheber und Rechteinhaber sind oft verschiedene Personen. Trenne deshalb immer: Wer hat das Werk geschaffen, und wer darf es verwerten?',
    points: [
      'Schutz automatisch, bis 70 Jahre nach dem Tod',
      'Angestellte: Verwertungsrechte beim Arbeitgeber (§ 69b)',
      'Freiberufler: nur was der Vertrag einräumt',
      'Einfach = neben anderen, ausschließlich = allein',
    ],
    satz:
        'Das Urheberrecht bleibt beim Menschen; übertragen werden nur Nutzungsrechte.',
  ),

  // ================================================ Service Level Agreements
  konzept(
    'n-li-1',
    'sla-inhalte',
    'Was ist ein SLA?',
    'Ein Service Level Agreement legt messbar fest, in welcher Qualität ein IT-Dienstleister seine Leistung erbringt. Beispiel: Ein Rechenzentrum betreibt den Webshop eines Kunden und sichert Verfügbarkeit und Reaktionszeiten zu. Ohne SLA ist „guter Service“ nicht prüfbar.',
    points: [
      'Es macht Qualität messbar: jede Zusage als Zahl mit Einheit und Bezugszeitraum',
      'Es ist die Grundlage für Reporting, Abrechnung und Vertragsstrafen',
      'Es wird regelmäßig in Service-Reviews überprüft und angepasst',
    ],
  ),
  vergleich(
    'n-li-2',
    'sla-inhalte',
    'SLA, OLA und UC',
    'Ein SLA kann ein Dienstleister nur halten, wenn er sich intern und bei seinen Lieferanten absichert. Dafür gibt es zwei weitere Vereinbarungen, die das SLA stützen.',
    [
      ['Vereinbarung', 'zwischen', 'Beispiel'],
      ['SLA', 'Dienstleister und Kunde', '99,5 % für den Webshop'],
      ['OLA', 'internen Teams', 'Netzteam übernimmt in 15 min'],
      ['UC', 'Dienstleister und Lieferant', 'Hardwaretausch in 4 h'],
    ],
    points: ['OLA = Operational Level Agreement, UC = Underpinning Contract'],
    merksatz:
        'Die Zeiten in OLA und UC müssen kürzer sein als im SLA, sonst ist das SLA nicht zu halten.',
  ),
  konzept(
    'n-li-3',
    'sla-inhalte',
    'Was in einem SLA steht',
    'Ein vollständiges SLA beantwortet, was geliefert wird, wann, wie gut und was passiert, wenn es nicht klappt.',
    points: [
      'Leistungsbeschreibung: welcher Service, für wen, in welchem Umfang',
      'Servicezeit, z. B. Mo–Fr 8–18 Uhr oder 24/7',
      'Verfügbarkeit in Prozent mit Bezugszeitraum',
      'Prioritäten mit eigenen Reaktions- und Lösungszeiten',
      'Wartungsfenster, Eskalationswege, Ansprechpartner',
      'Messverfahren und Reporting',
      'Mitwirkungspflichten des Kunden',
      'Pönale oder Bonus-Malus-Regel, Laufzeit, Kündigung',
    ],
  ),
  vergleich(
    'n-li-4',
    'sla-inhalte',
    'Die Zeitbegriffe',
    'Diese Begriffe werden in Prüfungen ständig verwechselt. Präge dir genau ein, wann jede Zeit beginnt und endet.',
    [
      ['Begriff', 'Bedeutung'],
      ['Servicezeit', 'Zeitraum, in dem der Service zugesichert ist'],
      ['Supportzeit', 'Zeit, in der der Service Desk erreichbar ist'],
      ['Reaktionszeit', 'Meldung bis zur ersten qualifizierten Rückmeldung'],
      ['Lösungszeit', 'Meldung bis zur Behebung der Störung'],
      ['Wartungsfenster', 'geplante Ausfälle, meist nicht als Ausfall gezählt'],
    ],
    merksatz:
        'Reaktions- und Lösungszeit laufen in der Regel nur während der vereinbarten Servicezeit.',
  ),
  formel(
    'n-li-5',
    'sla-inhalte',
    'Verfügbarkeit berechnen',
    'Die Verfügbarkeit ist der Anteil der vereinbarten Servicezeit, in dem der Service tatsächlich lief. Erst wenn Servicezeit und Bezugszeitraum klar sind, lässt sie sich berechnen.',
    'V = (Servicezeit - Ausfall)\n'
        '    / Servicezeit × 100 %\n'
        '\n'
        'erlaubter Ausfall =\n'
        '  Servicezeit × (100 % - V)',
    points: [
      'Schritt 1: Servicezeit im Bezugszeitraum in Stunden bestimmen',
      'Schritt 2: mit dem erlaubten Ausfallanteil malnehmen, z. B. 0,1 % = 0,001',
      'Schritt 3: in Minuten umrechnen (× 60), wenn danach gefragt ist',
    ],
  ),
  beispiel(
    'n-li-6',
    'sla-inhalte',
    'Erlaubte Ausfallzeit',
    'Ein SLA sichert 99,5 % Verfügbarkeit zu. Servicezeit: Montag bis Freitag, 7 bis 19 Uhr. Bezugszeitraum: ein Monat mit 21 Arbeitstagen. Wie viel Ausfall ist erlaubt?',
    schritte: [
      'Servicezeit pro Tag: 19 − 7 = 12 h',
      'Servicezeit im Monat: 21 × 12 h = 252 h',
      'Erlaubter Anteil: 100 % − 99,5 % = 0,5 % = 0,005',
      'Erlaubter Ausfall: 252 h × 0,005 = 1,26 h',
      'In Minuten: 1,26 h × 60 = 75,6 min',
    ],
    ergebnis: '1,26 h = 75,6 Minuten Ausfall im Monat',
  ),
  beispiel(
    'n-li-7',
    'sla-inhalte',
    'Wurde das SLA eingehalten?',
    'Ein Webshop mit 24/7-Servicezeit fiel im Juni (30 Tage) zweimal aus: 95 und 49 Minuten. Zugesichert sind 99,9 % im Monat.',
    schritte: [
      'Servicezeit: 30 × 24 h = 720 h = 43.200 min',
      'Ausfall gesamt: 95 + 49 = 144 min',
      'V = (43.200 − 144) / 43.200 × 100 % = 43.056 / 43.200 × 100 % ≈ 99,67 %',
      'Gegenprobe: erlaubt wären 43.200 min × 0,001 = 43,2 min; ausgefallen sind 144 min',
    ],
    ergebnis: 'Verfügbarkeit rund 99,67 %; das SLA mit 99,9 % ist verfehlt.',
  ),
  skizze(
    'n-li-8',
    'sla-inhalte',
    'Jede Neun zählt',
    'Jede zusätzliche Neun hinter dem Komma teilt die erlaubte Ausfallzeit durch zehn und macht den Betrieb deutlich teurer. Das Diagramm zeigt den erlaubten Ausfall pro Jahr bei 24/7-Betrieb (8.760 h).',
    BalkenDiagramm([
      Balken('99 %', 87.6),
      Balken('99,5 %', 43.8),
      Balken('99,9 %', 8.76, hervorheben: true),
      Balken('99,99 %', 0.88),
    ], einheit: 'h pro Jahr'),
    table: [
      ['Verfügbarkeit', 'pro Jahr', 'pro 30-Tage-Monat'],
      ['99 %', '87,6 h', '7,2 h'],
      ['99,5 %', '43,8 h', '3,6 h'],
      ['99,9 %', '8,76 h', '43,2 min'],
      ['99,99 %', '52,6 min', '4,3 min'],
    ],
  ),
  formel(
    'n-li-9',
    'sla-inhalte',
    'MTBF und MTTR',
    'Die Verfügbarkeit lässt sich auch aus dem Ausfallverhalten berechnen. MTBF (Mean Time Between Failures) ist die mittlere Betriebszeit zwischen zwei Ausfällen, MTTR (Mean Time To Repair) die mittlere Dauer bis zur Wiederherstellung.',
    'MTBF = Betriebszeit ohne Ausfall\n'
        '       / Anzahl Ausfälle\n'
        'MTTR = gesamte Ausfallzeit\n'
        '       / Anzahl Ausfälle\n'
        '\n'
        'V = MTBF / (MTBF + MTTR) × 100 %',
    points: [
      'Hohe MTBF = seltene Ausfälle, also zuverlässige Technik',
      'Kleine MTTR = schnelle Wiederherstellung, also guter Support',
      'Beide Wege, die Verfügbarkeit zu verbessern: seltener ausfallen oder schneller reparieren',
    ],
  ),
  beispiel(
    'n-li-10',
    'sla-inhalte',
    'MTBF und MTTR ausrechnen',
    'Ein Server war im Monat 720 h lang für den 24/7-Betrieb vorgesehen. Er fiel 3-mal aus, insgesamt 6 Stunden. Berechne MTBF, MTTR und Verfügbarkeit.',
    schritte: [
      'Betriebszeit ohne Ausfall: 720 h − 6 h = 714 h',
      'MTBF = 714 h / 3 = 238 h',
      'MTTR = 6 h / 3 = 2 h',
      'V = 238 / (238 + 2) × 100 % = 238 / 240 × 100 % ≈ 99,17 %',
      'Probe: (720 − 6) / 720 × 100 % = 714 / 720 × 100 % ≈ 99,17 %',
    ],
    ergebnis: 'MTBF 238 h, MTTR 2 h, Verfügbarkeit rund 99,17 %',
  ),
  beispiel(
    'n-li-11',
    'sla-inhalte',
    'Reaktions- und Lösungszeit in der Servicezeit',
    'Servicezeit Montag bis Freitag, 8 bis 18 Uhr. Für Priorität 2 gelten 2 h Reaktionszeit und 8 h Lösungszeit, gezählt nur in der Servicezeit. Eine Störung wird am Donnerstag um 16:00 Uhr gemeldet.',
    schritte: [
      'Reaktion: 16:00 + 2 h = 18:00 Uhr, liegt noch in der Servicezeit',
      'Lösung: Donnerstag 16 bis 18 Uhr = 2 h verbraucht, 6 h bleiben',
      'Die Uhr steht bis Freitag 8:00 Uhr',
      'Freitag 8:00 + 6 h = 14:00 Uhr',
    ],
    ergebnis: 'Reaktion bis Donnerstag 18:00 Uhr, Lösung bis Freitag 14:00 Uhr',
  ),
  beispiel(
    'n-li-12',
    'sla-inhalte',
    'Pönale berechnen',
    'Die monatliche Servicegebühr beträgt 4.000 €. Vereinbart sind 99,5 % Verfügbarkeit; für jeden angefangenen 0,1-Prozentpunkt darunter gibt es 5 % Gutschrift, höchstens 25 %. Gemessen wurden 99,26 %.',
    schritte: [
      'Unterschreitung: 99,5 % − 99,26 % = 0,24 Prozentpunkte',
      'Angefangene 0,1-Schritte: 0,1 + 0,1 + angefangene 0,04 -> 3 Schritte',
      'Gutschrift: 3 × 5 % = 15 %, unter der Obergrenze von 25 %',
      'Betrag: 4.000 € × 0,15 = 600 €',
    ],
    ergebnis: 'Pönale bzw. Gutschrift: 600 €',
  ),
  falle(
    'n-li-13',
    'sla-inhalte',
    'Typische Fehler beim SLA',
    '„99,9 % Verfügbarkeit“ ohne Servicezeit und Bezugszeitraum ist kaum prüfbar: Bei 24/7-Betrieb sind pro Jahr fast 9 Stunden Ausfall erlaubt, pro 30-Tage-Monat nur rund 43 Minuten. Und eine Reaktionszeit von einer Stunde heißt nicht, dass das Problem nach einer Stunde gelöst ist.',
    points: [
      'Wartungsfenster ausdrücklich regeln, sonst zählen sie als Ausfall',
      'Prozent und Prozentpunkte nicht verwechseln: 99,9 % statt 99,5 % sind 0,4 Prozentpunkte mehr',
      'Beim Rechnen die Servicezeit nehmen, nicht die Kalenderzeit, außer bei 24/7',
    ],
  ),
  merke(
    'n-li-14',
    'sla-inhalte',
    'Ein gutes SLA',
    'Ein SLA wirkt nur, wenn du es misst, darüber berichtest und es auch durchsetzt.',
    points: [
      'Kennzahlen klar definiert und messbar',
      'regelmäßiges Reporting an den Kunden',
      'Prioritäten mit eigenen Reaktions- und Lösungszeiten',
      'Pönale oder Gutschrift bei Unterschreitung',
      'intern durch OLAs, extern durch UCs abgesichert',
    ],
    satz:
        'Reaktionszeit ist nicht Lösungszeit, und Verfügbarkeit gilt nur für die Servicezeit.',
  ),

  // ============================================ Support-Level und Eskalation
  konzept(
    'n-ls-1',
    'sla-support',
    'Der Service Desk',
    'Der Service Desk ist die zentrale Anlaufstelle für alle Anfragen und Störungen, der Single Point of Contact (SPOC). Anwender müssen nicht wissen, wer intern zuständig ist. Jede Meldung wird als Ticket erfasst, damit nichts verloren geht und die Bearbeitung nachvollziehbar bleibt.',
    points: [
      'Meldungen annehmen und erfassen',
      'kategorisieren und priorisieren',
      'Standardfälle selbst lösen',
      'alles andere gezielt weitergeben und den Anwender auf dem Laufenden halten',
      'Tickets nach Bestätigung schließen',
    ],
  ),
  vergleich(
    'n-ls-2',
    'sla-support',
    'Organisationsformen des Service Desks',
    'Wie ein Service Desk organisiert ist, hängt von Größe, Standorten und Servicezeiten des Unternehmens ab.',
    [
      ['Form', 'Merkmal'],
      ['zentral', 'ein Standort für alle Anwender'],
      ['lokal', 'eigener Desk an jedem Standort'],
      ['virtuell', 'verteilte Teams, wirken nach außen wie einer'],
      [
        'Follow the Sun',
        'Teams in mehreren Zeitzonen übergeben, so entsteht 24/7',
      ],
    ],
  ),
  skizze(
    'n-ls-3',
    'sla-support',
    'Die Support-Level',
    'Support ist in Stufen organisiert. Unten landen viele einfache Fälle, oben wenige komplexe. Jede Stufe hat mehr Spezialwissen als die darunter.',
    StapelDiagramm(
      [
        StapelEbene('3rd Level', 'Hersteller, Entwicklung'),
        StapelEbene('2nd Level', 'Fachspezialisten'),
        StapelEbene('1st Level', 'Service Desk'),
        StapelEbene('Level 0', 'Self-Service, FAQ'),
      ],
      pyramide: true,
      oben: 'wenige, komplexe Fälle',
      unten: 'viele Standardfälle',
    ),
  ),
  vergleich(
    'n-ls-4',
    'sla-support',
    'Wer macht was?',
    'Die Stufen unterscheiden sich in Aufgabe und Wissen. Ziel ist, möglichst viele Fälle weit unten zu lösen, denn das ist schnell und günstig.',
    [
      ['Level', 'Wer', 'Aufgabe'],
      ['Level 0', 'Anwender selbst', 'Portal, FAQ, Passwort-Reset'],
      ['1st Level', 'Service Desk', 'annehmen, einstufen, Standardfälle lösen'],
      ['2nd Level', 'Fachspezialisten', 'komplexe Fälle, tiefe Analyse'],
      [
        '3rd Level',
        'Hersteller, Entwicklung',
        'Produktfehler, Code-Änderungen',
      ],
    ],
  ),
  vergleich(
    'n-ls-5',
    'sla-support',
    'Supportarten und Kanäle',
    'Support kann auf verschiedenen Wegen geleistet werden. Die meisten Unternehmen kombinieren mehrere Kanäle.',
    [
      ['Art', 'Vorteil', 'Nachteil'],
      ['Telefon-Hotline', 'schnell, persönlich', 'bindet Personal'],
      ['E-Mail, Portal', 'dokumentiert, asynchron', 'langsamere Antwort'],
      ['Chat', 'schnell, mehrere parallel', 'nur für kurze Fälle'],
      ['Remote-Support', 'keine Anfahrt', 'braucht Netz und Zustimmung'],
      ['Vor-Ort-Support', 'bei Hardware nötig', 'teuer, Anfahrt'],
      ['Self-Service', 'rund um die Uhr', 'nur Standardfälle'],
    ],
  ),
  konzept(
    'n-ls-6',
    'sla-support',
    'Das Ticket',
    'Jede Meldung wird als Ticket im Ticketsystem erfasst. So geht nichts verloren, jeder Bearbeiter sieht den Stand, und die SLA-Zeiten lassen sich messen. Gelöste Tickets füllen außerdem die Wissensdatenbank.',
    points: [
      'Ticketnummer, Zeitstempel, Melder mit Kontaktdaten',
      'betroffenes System, Kategorie, Beschreibung der Störung',
      'Auswirkung, Dringlichkeit und daraus die Priorität',
      'Status, Bearbeiter und Historie aller Schritte',
      'Lösung oder Workaround',
    ],
  ),
  skizze(
    'n-ls-7',
    'sla-support',
    'Lebenszyklus eines Tickets',
    'Ein Ticket durchläuft feste Status. Geschlossen wird es erst, wenn der Anwender die Lösung bestätigt hat oder eine vereinbarte Frist ohne Rückmeldung verstrichen ist.',
    FlussDiagramm([
      FlussKnoten('Meldung geht ein', form: FlussForm.start),
      FlussKnoten('Neu: erfasst, priorisiert'),
      FlussKnoten('Zugewiesen'),
      FlussKnoten('In Bearbeitung', seitlich: 'wartet auf Anwender'),
      FlussKnoten(
        'Gelöst?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] eskalieren',
      ),
      FlussKnoten('Gelöst: Anwender bestätigt'),
      FlussKnoten('Geschlossen', form: FlussForm.ende),
    ]),
  ),
  vergleich(
    'n-ls-8',
    'sla-support',
    'Priorität = Auswirkung × Dringlichkeit',
    'Die Priorität eines Tickets ergibt sich aus zwei Fragen: Wie viele oder wie wichtige Prozesse sind betroffen (Auswirkung)? Wie schnell muss es gehen (Dringlichkeit)? Viele SLAs nutzen eine 3×3-Matrix mit fünf Prioritäten.',
    [
      ['Auswirkung', 'D. hoch', 'D. mittel', 'D. niedrig'],
      ['hoch', 'P1', 'P2', 'P3'],
      ['mittel', 'P2', 'P3', 'P4'],
      ['niedrig', 'P3', 'P4', 'P5'],
    ],
    points: [
      'Beispiel: Webshop für alle Kunden down -> Auswirkung hoch, Dringlichkeit hoch -> P1',
      'Drucker einer Abteilung defekt, Ausweichdrucker im Flur -> mittel × niedrig -> P4',
      'Für jede Priorität legt das SLA Reaktions- und Lösungszeiten fest',
    ],
  ),
  vergleich(
    'n-ls-9',
    'sla-support',
    'Funktional oder hierarchisch eskalieren?',
    'Eskalieren heißt: jemanden einschalten, der mehr kann oder mehr entscheiden darf. Es gibt zwei Richtungen, die auch gleichzeitig nötig sein können.',
    [
      ['', 'funktional', 'hierarchisch'],
      ['Richtung', 'zu mehr Fachwissen', 'zur Führungsebene'],
      ['Auslöser', 'Wissen reicht nicht', 'SLA-Bruch droht, Ressourcen fehlen'],
      ['Beispiel', '1st an 2nd Level', 'Teamleitung stellt Techniker ab'],
    ],
    merksatz:
        'Funktional = zu mehr Fachwissen. Hierarchisch = zu mehr Entscheidungsbefugnis.',
  ),
  skizze(
    'n-ls-10',
    'sla-support',
    'Eskalation nach Zeitschwellen',
    'Viele SLAs legen fest, wann automatisch eskaliert wird. Das Beispiel zeigt ein Ticket der Priorität 1 mit 4 Stunden Lösungszeit.',
    FlussDiagramm([
      FlussKnoten('P1-Ticket erfasst', pfeil: 'nach 15 min'),
      FlussKnoten(
        '2nd Level übernimmt',
        pfeil: 'nach 3 h',
        seitlich: 'funktional',
      ),
      FlussKnoten(
        'Teamleitung informiert',
        pfeil: 'nach 4 h',
        seitlich: 'hierarchisch',
      ),
      FlussKnoten('IT-Leitung und Kunde', seitlich: 'SLA verletzt'),
    ]),
    points: [
      'Die Zeitschwellen sind Beispielwerte; sie stehen im jeweiligen SLA',
      'Das Ticketsystem überwacht die Fristen und löst die Eskalation aus',
    ],
  ),
  formel(
    'n-ls-11',
    'sla-support',
    'Kennzahlen des Supports',
    'Mit wenigen Kennzahlen lässt sich die Qualität eines Service Desks messen und mit dem SLA vergleichen.',
    'FLRR = im 1st Level gelöst\n'
        '       / alle Tickets × 100 %\n'
        '\n'
        'SLA-Quote = fristgerecht gelöst\n'
        '            / alle Tickets × 100 %\n'
        '\n'
        'Ø Lösungszeit = Summe Lösungszeiten\n'
        '                / Anzahl Tickets',
    points: [
      'FLRR = First Level Resolution Rate (Erstlösungsquote)',
      'Dazu oft die Kundenzufriedenheit per Kurzumfrage nach Ticketschluss',
    ],
  ),
  beispiel(
    'n-ls-12',
    'sla-support',
    'Kennzahlen ausrechnen',
    'Im März gingen 1.250 Tickets ein. 875 löste der 1st Level ohne Weitergabe, 1.150 wurden innerhalb der SLA-Lösungszeit gelöst. Alle Tickets zusammen brauchten 3.125 Stunden bis zur Lösung.',
    schritte: [
      'FLRR = 875 / 1.250 × 100 % = 70 %',
      'SLA-Quote = 1.150 / 1.250 × 100 % = 92 %',
      'Ø Lösungszeit = 3.125 h / 1.250 = 2,5 h',
    ],
    ergebnis: 'FLRR 70 %, SLA-Quote 92 %, Ø Lösungszeit 2,5 h je Ticket',
  ),
  falle(
    'n-ls-13',
    'sla-support',
    'Ownership statt Ticket-Pingpong',
    'Beim Eskalieren wird das Ticket nicht geschlossen und neu angelegt. Es wandert mit seiner kompletten Historie weiter. Der Service Desk bleibt für den Anwender Ansprechpartner (Ownership) und informiert ihn über den Stand.',
    points: [
      'Der 3rd Level wird nicht direkt vom Anwender angerufen; die Stufen werden der Reihe nach durchlaufen',
      'Ein neues Passwort ist keine Störung, sondern eine Standardanfrage und bekommt keine hohe Priorität',
    ],
  ),
  merke(
    'n-ls-14',
    'sla-support',
    'Support auf einen Blick',
    'Ein guter Support löst viel im 1st Level, eskaliert gezielt und verliert kein Ticket aus den Augen.',
    points: [
      'Service Desk = Single Point of Contact',
      'Level 0 bis 3: vom Self-Service bis zum Hersteller',
      'Priorität = Auswirkung × Dringlichkeit',
      'Kennzahlen: FLRR, SLA-Quote, Ø Lösungszeit',
    ],
    satz:
        'Funktional eskalieren = mehr Wissen, hierarchisch = mehr Befugnis. Das Ticket bleibt immer offen.',
  ),

  // ============================================= Incident, Problem, Change
  konzept(
    'n-lt-1',
    'sla-itil',
    'ITIL',
    'ITIL ist eine Sammlung bewährter Vorgehensweisen (Best Practices) für das IT-Service-Management. Verbreitet und prüfungsrelevant ist ITIL 4 (seit 2019). ITIL ist kein Gesetz und keine Software, sondern ein Leitfaden, den Unternehmen an ihre Bedürfnisse anpassen.',
    points: [
      'Ein Service ermöglicht dem Kunden gewünschte Ergebnisse, ohne dass er bestimmte Kosten und Risiken selbst tragen muss',
      'Wert entsteht gemeinsam mit dem Kunden (Co-Creation)',
      'ITIL 4 spricht von Praktiken (Practices), z. B. Incident Management',
    ],
  ),
  vergleich(
    'n-lt-2',
    'sla-itil',
    'Utility und Warranty',
    'Ein Service schafft nur Wert, wenn beides stimmt: Er tut das Richtige, und er tut es zuverlässig.',
    [
      ['', 'Utility', 'Warranty'],
      ['Frage', 'Erfüllt er den Zweck?', 'Ist er einsatzfähig?'],
      ['kurz', 'fit for purpose', 'fit for use'],
      ['Beispiel', 'Shop kann bestellen', 'verfügbar, sicher, schnell'],
    ],
  ),
  vergleich(
    'n-lt-3',
    'sla-itil',
    'Die Service Value Chain',
    'Herzstück von ITIL 4 ist das Service Value System. In seiner Mitte steht die Service Value Chain mit sechs Aktivitäten, die je nach Anfrage zu Wertströmen kombiniert werden.',
    [
      ['Aktivität', 'Leitfrage'],
      ['Plan', 'Wohin wollen wir?'],
      ['Improve', 'Was verbessern wir?'],
      ['Engage', 'Was braucht der Kunde?'],
      ['Design & Transition', 'Wie gestalten und übergeben wir?'],
      ['Obtain/Build', 'Was beschaffen oder bauen wir?'],
      ['Deliver & Support', 'Wie liefern und betreuen wir?'],
    ],
    points: [
      'Zum Service Value System gehören außerdem Leitprinzipien, Governance, Praktiken und kontinuierliche Verbesserung',
    ],
  ),
  konzept(
    'n-lt-4',
    'sla-itil',
    'Die sieben Leitprinzipien',
    'Die Leitprinzipien von ITIL 4 sind Empfehlungen, die in jeder Situation gelten, vom kleinen Service Desk bis zum großen Rechenzentrum.',
    points: [
      'Fokus auf Wert',
      'Beginne, wo du stehst',
      'Iterativ mit Feedback vorgehen',
      'Zusammenarbeiten und Transparenz fördern',
      'Ganzheitlich denken und arbeiten',
      'Einfach und praktisch halten',
      'Optimieren und automatisieren',
    ],
  ),
  vergleich(
    'n-lt-5',
    'sla-itil',
    'Die vier Dimensionen',
    'Ein Service funktioniert nur, wenn alle vier Dimensionen bedacht sind. Wer nur die Technik plant, vergisst oft Menschen und Lieferanten.',
    [
      ['Dimension', 'Beispiel'],
      ['Organisationen und Personen', 'Rollen, Skills, Kultur'],
      ['Informationen und Technologie', 'Ticketsystem, Datenbanken'],
      ['Partner und Lieferanten', 'Hersteller, Cloud-Anbieter'],
      ['Wertströme und Prozesse', 'Ablauf vom Anruf bis zur Lösung'],
    ],
  ),
  vergleich(
    'n-lt-6',
    'sla-itil',
    'Die zentralen Begriffe',
    'Jede dieser Praktiken verfolgt ein anderes Ziel. In der Prüfung musst du Meldungen sicher zuordnen können.',
    [
      ['Begriff', 'Ziel', 'Beispiel'],
      ['Incident', 'Störung schnell beheben', 'Drucker druckt nicht'],
      [
        'Problem',
        'Ursache finden und beseitigen',
        'Warum fällt der Server jede Woche aus?',
      ],
      [
        'Change',
        'Änderung kontrolliert durchführen',
        'Firewall-Regel anpassen',
      ],
      ['Service Request', 'Standardanfrage erfüllen', 'Passwort zurücksetzen'],
    ],
    points: [
      'Incident: ungeplante Unterbrechung oder Qualitätsminderung eines Service',
      'Problem: Ursache oder mögliche Ursache eines oder mehrerer Incidents',
      'Known Error: analysiertes, aber noch nicht gelöstes Problem, meist mit Workaround',
      'Workaround: Umgehung, die den Service wiederherstellt, ohne die Ursache zu beseitigen',
    ],
  ),
  skizze(
    'n-lt-7',
    'sla-itil',
    'Der Incident-Prozess',
    'Ziel des Incident Managements ist, den Service so schnell wie möglich wiederherzustellen, notfalls mit einem Workaround. Die Ursachensuche ist nicht seine Aufgabe.',
    FlussDiagramm([
      FlussKnoten('Erkennen und erfassen', form: FlussForm.start),
      FlussKnoten('Kategorisieren'),
      FlussKnoten('Priorisieren'),
      FlussKnoten('Erstdiagnose im 1st Level'),
      FlussKnoten(
        'Lösung bekannt?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] eskalieren',
      ),
      FlussKnoten('Lösen, wiederherstellen'),
      FlussKnoten('Schließen, dokumentieren', form: FlussForm.ende),
    ]),
    points: [
      'Major Incident: besonders schwere Störung mit eigenem, beschleunigtem Ablauf',
    ],
  ),
  ablauf(
    'n-lt-8',
    'sla-itil',
    'Vom Incident zum Change',
    'Die Praktiken greifen ineinander. Beispiel: Im Warenlager stürzt die Scanner-App mehrmals täglich ab.',
    [
      'Incident: Der Service Desk startet die App neu: ein Workaround, die Arbeit geht weiter',
      'Häufen sich gleiche Incidents, wird ein Problem eröffnet',
      'Problem Management findet die Ursache: ein Speicherleck nach dem letzten Update',
      'Ursache und Workaround werden als Known Error dokumentiert',
      'Die dauerhafte Lösung, ein Patch, wird als Change bewertet, genehmigt und eingespielt',
      'Danach wird das Problem geschlossen',
    ],
  ),
  vergleich(
    'n-lt-9',
    'sla-itil',
    'Drei Arten von Changes',
    'Nicht jede Änderung braucht dasselbe Genehmigungsverfahren. ITIL 4 nennt die Praktik Change Enablement; wer genehmigt, heißt Change Authority.',
    [
      ['Change', 'Merkmal', 'Genehmigung'],
      ['Standard', 'häufig, geringes Risiko', 'vorab genehmigt'],
      ['Normal', 'geplant, zu bewerten', 'einzeln, oft durch das CAB'],
      ['Emergency', 'sofort nötig', 'beschleunigt, Notfall-CAB'],
    ],
    points: [
      'Standard: neues Standard-Notebook einrichten',
      'Normal: ERP auf neuen Datenbankserver migrieren',
      'Emergency: Sicherheitspatch bei aktiv ausgenutzter Lücke',
    ],
    merksatz: 'CAB = Change Advisory Board, ein Gremium, das Changes bewertet.',
  ),
  vergleich(
    'n-lt-10',
    'sla-itil',
    'Weitere Praktiken',
    'ITIL 4 beschreibt insgesamt 34 Praktiken. Neben Incident, Problem und Change solltest du diese kennen.',
    [
      ['Praktik', 'Aufgabe'],
      ['Service Desk', 'zentrale Anlaufstelle'],
      ['Service Level Management', 'SLAs vereinbaren und überwachen'],
      ['Service Request Management', 'Standardanfragen abwickeln'],
      ['IT Asset Management', 'Geräte und Lizenzen erfassen'],
      ['Monitoring und Event Management', 'Zustände überwachen, Events melden'],
      ['Continual Improvement', 'ständig verbessern'],
    ],
  ),
  beispiel(
    'n-lt-11',
    'sla-itil',
    'Meldungen zuordnen',
    'Beim Service Desk eines Autohauses gehen vier Meldungen ein: (1) Die Werkstattsoftware startet an keinem PC. (2) Seit Wochen stürzt sie jeden Montag ab; die Ursache soll gefunden werden. (3) Ein neuer Azubi braucht ein Benutzerkonto. (4) Der Mailserver soll auf eine neue Version aktualisiert werden.',
    schritte: [
      '(1) Der Service ist gestört -> Incident, hohe Priorität, sofort wiederherstellen',
      '(2) Ursache wiederkehrender Störungen gesucht -> Problem',
      '(3) Nichts ist kaputt, eine vereinbarte Standardleistung -> Service Request',
      '(4) Geplante Änderung an einem Service -> Change, als Normal Change bewerten und genehmigen',
    ],
    ergebnis: 'Incident, Problem, Service Request, Change',
  ),
  falle(
    'n-lt-12',
    'sla-itil',
    'Incident ist nicht Problem',
    'Ein Incident ist erledigt, sobald der Service wieder läuft, auch wenn die Ursache unbekannt bleibt. Die Ursachensuche ist Aufgabe des Problem Managements. Und ein neues Passwort ist kein Incident, sondern ein Service Request, denn kaputt ist ja nichts.',
    points: [
      'Ein Event ist nur eine bedeutsame Zustandsänderung, z. B. Festplatte zu 80 % voll, noch keine Störung',
      'Auch ein Emergency Change wird genehmigt und dokumentiert, nur schneller',
    ],
  ),
  merke(
    'n-lt-13',
    'sla-itil',
    'ITIL in einem Satz',
    'Merke dir die Kernbegriffe als Kette: Störung, Ursache, Änderung, daneben die Standardanfrage.',
    points: [
      'Service Value Chain: Plan, Improve, Engage, Design & Transition, Obtain/Build, Deliver & Support',
      'Vier Dimensionen, sieben Leitprinzipien',
      'Changes: Standard, Normal, Emergency',
    ],
    satz:
        'Incident = wiederherstellen. Problem = Ursache finden. Change = kontrolliert ändern. Service Request = Standardwunsch erfüllen.',
  ),

  // ================================================================== Verzug
  vergleich(
    'n-gv-1',
    'ls-verzug',
    'Leistungsstörungen im Überblick',
    'Ein Vertrag kann auf mehrere Arten gestört werden. Diese Lektion behandelt den Verzug; mangelhafte Lieferungen folgen in der nächsten Lektion.',
    [
      ['Störung', 'Wer', 'Beispiel'],
      ['Lieferungsverzug', 'Verkäufer', 'Server kommt zu spät'],
      ['Schlechtleistung', 'Verkäufer', 'Notebook defekt'],
      ['Annahmeverzug', 'Käufer', 'nimmt Lieferung nicht an'],
      ['Zahlungsverzug', 'Käufer', 'zahlt Rechnung nicht'],
      ['Unmöglichkeit', 'Verkäufer', 'Einzelstück zerstört'],
    ],
  ),
  konzept(
    'n-gv-2',
    'ls-verzug',
    'Was ist Verzug?',
    'Verzug heißt: Eine fällige Leistung kommt nicht rechtzeitig, obwohl sie noch möglich ist (§ 286 BGB). Liefert der Verkäufer zu spät, ist er im Lieferungsverzug. Zahlt der Käufer zu spät, ist er im Zahlungsverzug.',
    points: [
      'Der Schuldner ist jeweils die Seite, die leisten muss',
      'Verzug ist nicht Unmöglichkeit: Die Leistung kann noch erbracht werden, nur eben zu spät',
    ],
  ),
  ablauf(
    'n-gv-3',
    'ls-verzug',
    'Voraussetzungen des Lieferungsverzugs',
    'Prüfe die Voraussetzungen der Reihe nach. Beispiel: Ein Händler soll 20 Notebooks für neue Azubis liefern, die Lieferung bleibt aus.',
    [
      'Fälligkeit: Der vereinbarte Liefertermin ist erreicht',
      'Mahnung: Der Käufer fordert die Lieferung eindeutig ein, formfrei, eine Mahnung genügt',
      'Mahnung entbehrlich (§ 286 Abs. 2): Termin nach dem Kalender bestimmt („am 15.03.“, „14 Tage nach Abruf“), ernsthafte Leistungsverweigerung oder besondere Eilbedürftigkeit',
      'Vertretenmüssen: Der Lieferer hat die Verspätung verschuldet. Das wird vermutet, er muss sich entlasten (§ 286 Abs. 4)',
    ],
  ),
  skizze(
    'n-gv-4',
    'ls-verzug',
    'Ablauf beim Lieferungsverzug',
    'Ist nur „Mitte März“ vereinbart, ist der Termin nicht kalendermäßig bestimmt. Der Käufer muss mahnen und für Rücktritt oder Schadensersatz statt der Leistung zusätzlich eine Nachfrist setzen.',
    SequenzDiagramm(
      ['Käufer', 'Verkäufer'],
      [
        Nachricht(0, 1, 'Bestellung, Lieferung Mitte März'),
        Nachricht(0, 1, 'Mahnung: Verzug beginnt'),
        Nachricht(0, 1, 'Nachfrist bis 10.04.'),
        Nachricht(1, 0, 'keine Lieferung', antwort: true),
        Nachricht(0, 1, 'Rücktritt, Schadensersatz'),
      ],
    ),
    points: [
      'Mahnung und Nachfrist können in einem Schreiben verbunden werden',
      'Angemessen ist eine Frist, in der ein bereits vorbereiteter Lieferer die Leistung noch erbringen kann',
    ],
  ),
  vergleich(
    'n-gv-5',
    'ls-verzug',
    'Rechte beim Lieferungsverzug',
    'Welche Rechte der Käufer hat, hängt davon ab, ob eine Nachfrist abgelaufen ist und ob der Lieferer die Verspätung verschuldet hat.',
    [
      ['Recht', 'Nachfrist?', 'Verschulden?'],
      ['Lieferung verlangen', 'nein', 'nein'],
      ['Ersatz des Verzögerungsschadens', 'nein', 'ja'],
      ['Rücktritt', 'ja', 'nein'],
      ['Schadensersatz statt der Leistung', 'ja', 'ja'],
    ],
    points: [
      'Rücktritt und Schadensersatz lassen sich kombinieren (§ 325 BGB)',
      'Nachfrist entbehrlich: ernsthafte, endgültige Verweigerung oder Fixgeschäft (§ 323 Abs. 2 BGB)',
      'Verzögerungsschaden: z. B. Kosten für Leihgeräte bis zur verspäteten Lieferung',
    ],
  ),
  beispiel(
    'n-gv-6',
    'ls-verzug',
    'Rechtsfall: Deckungskauf',
    'Ein Händler sollte am 15. März 20 Notebooks zu je 890 € liefern. Er liefert nicht; eine Nachfrist bis 5. April verstreicht. Der Händler hatte schlicht vergessen, die Geräte zu bestellen. Der Käufer kauft bei einem anderen Händler zu je 950 €.',
    schritte: [
      'Fälligkeit am 15. März, Mahnung entbehrlich (Kalendertermin) -> Verzug ab 16. März',
      'Nachfrist erfolglos verstrichen -> Rücktritt möglich',
      'Vergessen ist fahrlässig -> Verschulden liegt vor -> Schadensersatz statt der Leistung',
      'Schaden = Mehrkosten des Deckungskaufs: 20 × (950 € − 890 €) = 20 × 60 € = 1.200 €',
    ],
    ergebnis: 'Der Käufer kann 1.200 € Schadensersatz verlangen.',
  ),
  vergleich(
    'n-gv-7',
    'ls-verzug',
    'Das Fixgeschäft',
    'Ist ein Termin so wichtig, dass der Vertrag mit ihm „stehen oder fallen“ soll, liegt ein Fixgeschäft vor, erkennbar an Formulierungen wie „fix“ oder „genau am“. Dann braucht der Käufer keine Nachfrist.',
    [
      ['Art', 'Merkmal', 'Folge'],
      [
        'relatives Fixgeschäft',
        'Termin wesentlich',
        'Rücktritt ohne Nachfrist',
      ],
      [
        'Fixhandelskauf',
        'dasselbe unter Kaufleuten',
        'Erfüllung nur bei sofortiger Anzeige (§ 376 HGB)',
      ],
      [
        'absolutes Fixgeschäft',
        'später sinnlos, z. B. Techniker für den Messetag',
        'Leistung unmöglich',
      ],
    ],
  ),
  konzept(
    'n-gv-8',
    'ls-verzug',
    'Annahmeverzug',
    'Nimmt der Käufer ordnungsgemäß angebotene Ware nicht an, gerät er in Annahmeverzug (§§ 293 ff. BGB). Ein Verschulden des Käufers ist dafür nicht nötig.',
    points: [
      'Der Verkäufer haftet ab dann nur noch für Vorsatz und grobe Fahrlässigkeit (§ 300 BGB)',
      'Er kann die Ware auf Kosten des Käufers einlagern',
      'Unter Kaufleuten kann er sie nach Androhung versteigern lassen (Selbsthilfeverkauf, § 373 HGB)',
      'Er kann weiterhin auf Abnahme und Zahlung bestehen',
    ],
  ),
  formel(
    'n-gv-9',
    'ls-verzug',
    'Zahlungsverzug und Verzugszinsen',
    'Wer eine Geldschuld zu spät zahlt, schuldet Verzugszinsen (§ 288 BGB). Ihre Höhe hängt davon ab, ob ein Verbraucher beteiligt ist. Grundlage ist der Basiszinssatz, den die Bundesbank zum 1. Januar und 1. Juli anpasst (§ 247 BGB).',
    'Verbraucher beteiligt:\n'
        '  Basiszinssatz + 5 Prozentpunkte\n'
        'Nur Unternehmen:\n'
        '  Basiszinssatz + 9 Prozentpunkte\n'
        '  + 40 € Pauschale\n'
        '\n'
        'Zins = Betrag × Satz × Tage / 365',
    points: [
      'Die 40 € Pauschale gibt es nur, wenn der Schuldner kein Verbraucher ist (§ 288 Abs. 5)',
      'Manche Prüfungsaufgaben rechnen mit 360 Tagen (Bankjahr). Nimm immer, was die Aufgabe vorgibt',
    ],
  ),
  skizze(
    'n-gv-10',
    'ls-verzug',
    'Die 30-Tage-Regel',
    'Auch ohne Mahnung kommt der Schuldner einer Geldforderung spätestens in Verzug, wenn er nicht innerhalb von 30 Tagen nach Fälligkeit und Zugang der Rechnung zahlt (§ 286 Abs. 3 BGB). Verbraucher nur, wenn die Rechnung darauf hinweist.',
    GanttDiagramm([
      GanttVorgang('Rechnung fällig, zugegangen', 0, 0),
      GanttVorgang('30 Tage Zahlungsfrist', 0, 30),
      GanttVorgang('Verzug: Zinsen laufen', 30, 30, kritisch: true),
    ]),
    points: [
      'Beispiel: Rechnung am 1. Juni fällig und zugegangen -> Frist 2. Juni bis 1. Juli -> Verzug ab 2. Juli',
      'Mit einer Mahnung oder einem im Vertrag vereinbarten Zahlungstermin tritt Verzug schon früher ein',
    ],
  ),
  beispiel(
    'n-gv-11',
    'ls-verzug',
    'Verzugszinsen berechnen',
    'Ein Systemhaus stellt einem Autohaus 36.500 € für eine Netzwerkinstallation in Rechnung. Das Autohaus zahlt 30 Tage zu spät. Annahme für dieses Beispiel: Basiszinssatz 2,0 % (den aktuellen Wert veröffentlicht die Bundesbank).',
    schritte: [
      'Nur Unternehmen beteiligt -> 2,0 % + 9 Prozentpunkte = 11 %',
      'Zins = 36.500 € × 0,11 × 30 / 365',
      '= 4.015 € × 30 / 365 = 330,00 €',
      'Dazu die Pauschale von 40 € -> 370,00 €',
      'Zum Vergleich mit Privatkunde: 2,0 % + 5 = 7 % -> 36.500 € × 0,07 × 30 / 365 = 210,00 €, keine Pauschale',
    ],
    ergebnis: '330,00 € Verzugszinsen + 40 € Pauschale = 370,00 €',
  ),
  ablauf(
    'n-gv-12',
    'ls-verzug',
    'Vom Mahnen zum Mahnbescheid',
    'Zahlt ein Kunde trotz Mahnung nicht, kann der Gläubiger ohne Klage das gerichtliche Mahnverfahren nutzen.',
    [
      'Außergerichtlich: Zahlungserinnerung und Mahnung',
      'Antrag auf Mahnbescheid beim zuständigen Mahngericht (online möglich)',
      'Der Schuldner kann binnen 2 Wochen widersprechen -> dann folgt ein normales Gerichtsverfahren',
      'Ohne Widerspruch: Antrag auf Vollstreckungsbescheid',
      'Einspruch binnen 2 Wochen möglich, sonst kann vollstreckt werden',
    ],
    merksatz:
        'Forderungen verjähren regelmäßig in 3 Jahren ab Ende des Entstehungsjahres (§§ 195, 199 BGB); der Mahnbescheid hemmt die Verjährung.',
  ),
  falle(
    'n-gv-13',
    'ls-verzug',
    'Prozent oder Prozentpunkte?',
    'Verzugszinsen liegen 5 bzw. 9 Prozentpunkte über dem Basiszinssatz. Bei 2 % Basiszins sind das 7 % bzw. 11 %, nicht 2 % × 1,05. Die drei Mahnungen, die man aus dem Alltag kennt, brauchst du übrigens nicht, denn eine einzige genügt.',
    points: [
      'Ein Zahlungsziel, das der Verkäufer nur einseitig auf die Rechnung schreibt, ersetzt keine Mahnung',
      'Die 30-Tage-Regel gilt nur für Geldforderungen, nicht für den Lieferungsverzug',
      'Für den Rücktritt kommt es auf die Nachfrist an, nicht auf die Zahl der Mahnungen',
    ],
  ),
  merke(
    'n-gv-14',
    'ls-verzug',
    'Verzug auf einen Blick',
    'Beim Verzug prüfst du immer dieselben drei Bausteine. Welche Rechte daraus folgen, hängt von Nachfrist und Verschulden ab.',
    points: [
      'Lieferungsverzug: Lieferung + Verzögerungsschaden sofort, Rücktritt und Schadensersatz statt der Leistung nach Nachfrist',
      'Zahlungsverzug: Zinsen 5 bzw. 9 Prozentpunkte über Basiszins, B2B plus 40 €',
      'Annahmeverzug: Käufer nimmt nicht an, Haftung des Verkäufers sinkt',
    ],
    satz:
        'Verzug = fällig + gemahnt (oder Termin nach Kalender) + zu vertreten.',
  ),

  // ================================================ Mängel und Gewährleistung
  konzept(
    'n-gm-1',
    'ls-maengel',
    'Wann ist eine Sache mangelhaft?',
    'Seit 2022 ist eine Sache nur mangelfrei, wenn sie bei Gefahrübergang drei Anforderungen erfüllt (§ 434 BGB): die vereinbarten (subjektiven), die üblichen (objektiven) und, falls sie montiert wird, die Montageanforderungen. Gefahrübergang ist in der Regel die Übergabe.',
    points: [
      'Subjektiv: vereinbarte Beschaffenheit. Das Gesetz nennt ausdrücklich Art, Menge, Qualität, Funktionalität, Kompatibilität und Interoperabilität',
      'Objektiv: eignet sich für die gewöhnliche Verwendung, hat die übliche Beschaffenheit, hält, was die Werbung verspricht',
      'Montage: fachgerecht montiert, Anleitung korrekt',
      'Rechtsmangel (§ 435): Dritte haben Rechte an der Sache, z. B. Software ohne gültige Lizenz',
    ],
  ),
  vergleich(
    'n-gm-2',
    'ls-maengel',
    'Mängelarten nach Art',
    'Aus den Anforderungen ergeben sich die typischen Mängel. Falschlieferung steht einem Sachmangel gleich (§ 434 Abs. 5), und eine zu geringe Menge verfehlt die vereinbarte Beschaffenheit.',
    [
      ['Mangel', 'Beispiel'],
      ['vereinbarte Beschaffenheit fehlt', '8 statt 16 GB RAM'],
      ['nicht für gewöhnliche Verwendung', 'Notebook-Akku lädt nicht'],
      ['Werbeaussage falsch', '„10 h Akku“, hält 3 h'],
      ['Montagemangel', 'Server falsch eingebaut'],
      ['fehlerhafte Montageanleitung', 'Rack deshalb falsch montiert'],
      ['Falschlieferung', '24- statt 27-Zoll-Monitor'],
      ['Zuweniglieferung', '9 statt 10 Switches'],
      ['Rechtsmangel', 'Software ohne gültige Lizenz'],
    ],
  ),
  vergleich(
    'n-gm-3',
    'ls-maengel',
    'Mängel nach Erkennbarkeit',
    'Nach der Erkennbarkeit unterscheidet man drei Fälle. Wichtig wird das vor allem beim Kauf unter Kaufleuten: Dort muss die Ware unverzüglich geprüft und ein Mangel unverzüglich gerügt werden (§ 377 HGB), sonst gilt sie als genehmigt.',
    [
      ['Art', 'Merkmal', 'Rüge unter Kaufleuten'],
      ['offen', 'bei Prüfung sofort erkennbar', 'unverzüglich nach Lieferung'],
      ['versteckt', 'zeigt sich erst später', 'unverzüglich nach Entdeckung'],
      [
        'arglistig verschwiegen',
        'Verkäufer kannte ihn und schwieg',
        'Verkäufer kann sich nicht auf verspätete Rüge berufen',
      ],
    ],
    merksatz:
        'Private Käufer und Verbraucher trifft keine Rügepflicht; sie haben die volle Gewährleistungsfrist.',
  ),
  skizze(
    'n-gm-4',
    'ls-maengel',
    'Die Rechte des Käufers',
    'Die Rechte bei Mängeln stehen in § 437 BGB und haben eine feste Rangfolge: Zuerst bekommt der Verkäufer die Chance, den Mangel zu beheben. Erst wenn das scheitert, kommen die nachrangigen Rechte.',
    FlussDiagramm([
      FlussKnoten('Mangel bei Übergabe', form: FlussForm.start),
      FlussKnoten('Mangel anzeigen, Frist setzen'),
      FlussKnoten(
        'Nacherfüllung',
        seitlich: 'Käufer wählt: Reparatur oder neue Sache',
      ),
      FlussKnoten(
        'Erfolgreich?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] erledigt',
      ),
      FlussKnoten(
        'Rücktritt oder Minderung',
        seitlich: '+ Schadensersatz bei Verschulden',
      ),
    ]),
  ),
  vergleich(
    'n-gm-5',
    'ls-maengel',
    'Die Rechte im Detail',
    'Vorrangig ist die Nacherfüllung (§ 439). Die übrigen Rechte setzen grundsätzlich voraus, dass eine angemessene Frist zur Nacherfüllung erfolglos abgelaufen ist.',
    [
      ['Recht', 'Inhalt', 'Zusätzlich nötig'],
      ['Nachbesserung', 'Reparatur', '–'],
      ['Ersatzlieferung', 'neue mangelfreie Sache', '–'],
      ['Rücktritt', 'Ware zurück, Geld zurück', 'Mangel nicht unerheblich'],
      ['Minderung', 'Preis herabsetzen', '–'],
      ['Schadensersatz', 'Schaden ersetzen', 'Verschulden'],
    ],
    points: [
      'Die Nacherfüllung gilt nach dem zweiten erfolglosen Versuch als fehlgeschlagen (§ 440 BGB)',
      'Die Kosten der Nacherfüllung (Transport, Arbeit, Material) trägt der Verkäufer (§ 439 Abs. 2)',
      'Rücktritt oder Minderung: Der Käufer muss sich für eines entscheiden',
    ],
  ),
  formel(
    'n-gm-6',
    'ls-maengel',
    'Minderung berechnen',
    'Bei der Minderung wird der Kaufpreis im selben Verhältnis herabgesetzt, in dem der Wert der mangelhaften Sache zum Wert der mangelfreien steht (§ 441 Abs. 3 BGB).',
    'geminderter Preis =\n'
        '  Kaufpreis × Wert mit Mangel\n'
        '            / Wert ohne Mangel\n'
        '\n'
        'Minderungsbetrag =\n'
        '  Kaufpreis - geminderter Preis',
    points: [
      'Die Werte werden geschätzt, notfalls von einem Gutachter',
      'Hat der Käufer schon mehr bezahlt, bekommt er den Minderungsbetrag zurück',
    ],
  ),
  beispiel(
    'n-gm-7',
    'ls-maengel',
    'Minderung durchgerechnet',
    'Ein Büro kauft einen Beamer für 1.200 €. Ein Farbkanal ist zu schwach, die Nachbesserung scheitert zweimal. Ein Gutachter schätzt: Wert ohne Mangel 1.500 €, Wert mit Mangel 1.000 €.',
    schritte: [
      'Verhältnis: 1.000 € / 1.500 € = 2/3',
      'Geminderter Preis: 1.200 € × 2/3 = 800 €',
      'Minderungsbetrag: 1.200 € − 800 € = 400 €',
      'Nicht einfach 1.500 € − 1.000 € = 500 € abziehen, denn es zählt das Verhältnis',
    ],
    ergebnis: 'Das Büro zahlt 800 € und erhält 400 € zurück.',
  ),
  vergleich(
    'n-gm-8',
    'ls-maengel',
    'Gewährleistung, Garantie, Kulanz',
    'Die drei Begriffe klingen ähnlich, haben aber eine völlig andere Grundlage. Gewährleistung und Garantie bestehen unabhängig voneinander.',
    [
      ['', 'Gewährleistung', 'Garantie', 'Kulanz'],
      [
        'Grundlage',
        'Gesetz',
        'freiwilliger Vertrag',
        'freiwillig, ohne Pflicht',
      ],
      [
        'gegenüber',
        'Verkäufer',
        'meist Hersteller',
        'Verkäufer oder Hersteller',
      ],
      ['Dauer', '2 Jahre (neu)', 'frei festgelegt', 'Einzelfall'],
    ],
    points: [
      'Die Gewährleistungsfrist beginnt mit der Ablieferung (§ 438 BGB)',
      'Gebrauchte Sachen: gegenüber Verbrauchern auf 1 Jahr verkürzbar',
      'Unter Unternehmen kann die Gewährleistung vertraglich beschränkt werden, aber nie bei Arglist',
    ],
  ),
  skizze(
    'n-gm-9',
    'ls-maengel',
    'Fristen beim Verbrauchsgüterkauf',
    'Beim Verbrauchsgüterkauf (Unternehmer verkauft an Verbraucher) wird vermutet, dass ein Mangel, der sich im ersten Jahr zeigt, schon bei Übergabe vorlag (§ 477 BGB, seit 2022; vorher 6 Monate). Danach muss der Kunde das beweisen; die Gewährleistung läuft trotzdem zwei Jahre.',
    GanttDiagramm([
      GanttVorgang('Gewährleistung', 0, 24),
      GanttVorgang('Beweislastumkehr', 0, 12, kritisch: true),
      GanttVorgang('Kunde muss beweisen', 12, 12),
    ], einheit: 'Monat'),
  ),
  beispiel(
    'n-gm-10',
    'ls-maengel',
    'Rechtsfall: Displayfehler nach 14 Monaten',
    'Eine Privatkundin kauft bei einem Elektronikhändler ein neues Notebook. Nach 14 Monaten fallen Pixelzeilen aus. Der Händler verweist auf den Hersteller und dessen abgelaufene 1-Jahres-Garantie.',
    schritte: [
      'Verbrauchsgüterkauf: Händler (Unternehmer) verkauft an eine Verbraucherin',
      'Gewährleistung 2 Jahre ab Übergabe -> nach 14 Monaten noch nicht abgelaufen',
      'Beweislastumkehr nur im ersten Jahr -> jetzt muss die Kundin beweisen, dass der Fehler schon bei Übergabe angelegt war, z. B. per Gutachten',
      'Die Herstellergarantie ist unabhängig davon; ihr Ablauf ändert an der Gewährleistung nichts',
      'Anspruchsgegner ist der Händler, nicht der Hersteller',
    ],
    ergebnis:
        'Die Kundin kann vom Händler Nacherfüllung verlangen, muss aber den Mangel bei Übergabe beweisen.',
  ),
  vergleich(
    'n-gm-11',
    'ls-maengel',
    'Mängelrechte bei Kauf und Werk',
    'Beim Werkvertrag, etwa bei Individualsoftware, gelten ähnliche Rechte (§ 634 BGB), mit drei wichtigen Unterschieden.',
    [
      ['', 'Kaufvertrag', 'Werkvertrag'],
      ['Art der Nacherfüllung wählt', 'Käufer', 'Unternehmer'],
      ['Selbstvornahme', 'nein', 'ja, nach Fristablauf'],
      ['Verjährung beginnt mit', 'Übergabe', 'Abnahme'],
    ],
    points: [
      'Selbstvornahme (§ 637): Der Besteller lässt den Mangel selbst beseitigen und verlangt die Kosten ersetzt',
    ],
  ),
  falle(
    'n-gm-12',
    'ls-maengel',
    'Typische Fehler bei Mängeln',
    'Der Mangel muss bei Übergabe vorliegen. Schäden durch falsche Bedienung sind kein Mangel. Ansprechpartner ist der Verkäufer, nicht der Hersteller. Und wer sofort zurücktreten will, muss meist erst Nacherfüllung verlangen.',
    points: [
      'Bei einem unerheblichen Mangel ist der Rücktritt ausgeschlossen, mindern darf der Käufer trotzdem (§ 323 Abs. 5, § 441 BGB)',
      'Waren mit digitalen Elementen, z. B. Smartphones: Der Verkäufer muss Verbrauchern Sicherheitsupdates für einen angemessenen Zeitraum sicherstellen (§ 475b BGB)',
      'Gewährleistung ist nicht Garantie: Das Ende der Garantie beendet die Gewährleistung nicht',
    ],
  ),
  merke(
    'n-gm-13',
    'ls-maengel',
    'Mängel auf einen Blick',
    'Bei jedem Mangelfall stellst du dieselben Fragen: Welcher Mangel, wer ist Vertragspartner, welche Frist läuft, welches Recht kommt zuerst?',
    points: [
      'Sachmangel: subjektiv, objektiv, Montage; Rechtsmangel: Rechte Dritter',
      'Unter Kaufleuten: unverzüglich prüfen und rügen',
      'Gewährleistung 2 Jahre, Beweislastumkehr 1 Jahr (Verbrauchsgüterkauf)',
      'Minderung nach Verhältnis, nicht nach Differenz',
    ],
    satz:
        'Erst Nacherfüllung, dann Rücktritt oder Minderung, Schadensersatz nur bei Verschulden.',
  ),

  // =================================================== Abnahme und Protokoll
  konzept(
    'n-ga-1',
    'ls-abnahme',
    'Was ist die Abnahme?',
    'Beim Werkvertrag erklärt der Besteller mit der Abnahme, dass er das Werk als im Wesentlichen vertragsgemäß anerkennt, etwa eine fertig programmierte Software. Er ist dazu verpflichtet, wenn das Werk vertragsgemäß hergestellt ist (§ 640 Abs. 1 BGB). Wegen unwesentlicher Mängel darf er die Abnahme nicht verweigern.',
    points: [
      'Die Abnahme ist der wichtigste Zeitpunkt im Werkvertrag',
      'Beim Dienstvertrag gibt es keine Abnahme, bezahlt wird die Tätigkeit',
    ],
  ),
  vergleich(
    'n-ga-2',
    'ls-abnahme',
    'Vor und nach der Abnahme',
    'Mit der Abnahme ändert sich die Rechtslage für beide Seiten auf einen Schlag.',
    [
      ['', 'vor der Abnahme', 'nach der Abnahme'],
      ['Vergütung', 'nicht fällig', 'fällig (§ 641)'],
      ['Gefahr zufälliger Zerstörung', 'Unternehmer', 'Besteller (§ 644)'],
      ['Beweislast für Mängel', 'Unternehmer', 'Besteller'],
      ['Verjährung der Mängelrechte', 'läuft nicht', 'beginnt (§ 634a)'],
    ],
    points: [
      'Bei der Herstellung einer Sache verjähren die Mängelansprüche in 2 Jahren ab Abnahme (§ 634a Abs. 1 Nr. 1 BGB)',
    ],
  ),
  vergleich(
    'n-ga-3',
    'ls-abnahme',
    'Arten der Abnahme',
    'Eine Abnahme muss nicht förmlich mit Unterschrift erfolgen. Das Gesetz kennt mehrere Wege.',
    [
      ['Art', 'So läuft es'],
      ['ausdrücklich (förmlich)', 'Abnahmetermin, Protokoll, Unterschrift'],
      [
        'konkludent',
        'durch Verhalten, z. B. vorbehaltlose Zahlung oder Nutzung nach Prüfzeit',
      ],
      [
        'fiktiv (§ 640 Abs. 2)',
        'Frist verstreicht, ohne dass ein Mangel genannt wird',
      ],
      ['Teilabnahme', 'für vereinbarte Teilleistungen, z. B. Meilensteine'],
    ],
  ),
  konzept(
    'n-ga-4',
    'ls-abnahme',
    'Abnahmekriterien vorher festlegen',
    'Woran das Werk gemessen wird, gehört schon ins Pflichtenheft bzw. in den Vertrag, messbar formuliert, etwa „Suchergebnis in unter 2 Sekunden bei 100 gleichzeitigen Nutzern“. Ohne Kriterien entsteht Streit darüber, ob das Werk vertragsgemäß ist.',
    points: [
      'Abnahmetest mit echten Geschäftsfällen in produktionsnaher Umgebung',
      'Testfälle und Testdaten stellt häufig der Kunde; das ist eine Mitwirkungspflicht',
      'Abnahmekriterien = die vereinbarten Anforderungen, nicht spätere Wünsche',
    ],
  ),
  vergleich(
    'n-ga-5',
    'ls-abnahme',
    'Mängelklassen im Protokoll',
    'Viele IT-Verträge teilen Mängel in Klassen ein und legen fest, bei welcher Klasse die Abnahme verweigert werden darf. So sieht eine typische Einteilung aus.',
    [
      ['Klasse', 'Wirkung', 'Typische Folge'],
      ['betriebsverhindernd', 'Nutzung unmöglich', 'Abnahme verweigert'],
      ['betriebsbehindernd', 'Nutzung stark eingeschränkt', 'meist verweigert'],
      ['leicht', 'Nutzung kaum beeinträchtigt', 'Abnahme unter Vorbehalt'],
    ],
  ),
  skizze(
    'n-ga-6',
    'ls-abnahme',
    'Abnehmen oder verweigern?',
    'Nach dem Abnahmetest entscheidet der Besteller. Ein wesentlicher Mangel berechtigt zur Verweigerung, ein unwesentlicher nicht. Er wird als Vorbehalt protokolliert.',
    FlussDiagramm([
      FlussKnoten('Werk fertiggestellt', form: FlussForm.start),
      FlussKnoten('Abnahmetest gegen Pflichtenheft'),
      FlussKnoten(
        'Mängel gefunden?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] Abnahme erklären',
      ),
      FlussKnoten(
        'Mangel wesentlich?',
        form: FlussForm.entscheidung,
        pfeil: '[nein]',
        seitlich: '[ja] verweigern, Frist setzen',
      ),
      FlussKnoten('Abnahme unter Vorbehalt', form: FlussForm.ende),
    ]),
  ),
  ablauf(
    'n-ga-7',
    'ls-abnahme',
    'Eine Abnahme durchführen',
    'Beispiel: Eine Agentur übergibt einem Kunden das fertige Kundenportal.',
    [
      'Fertigstellung anzeigen und Abnahmetermin vereinbaren',
      'Abnahmetest anhand der vereinbarten Kriterien und Testfälle durchführen',
      'Protokoll: Datum, Beteiligte, Gegenstand, Testergebnisse, Mängel mit Klasse und Frist',
      'Erklärung: Abnahme, Abnahme unter Vorbehalt oder Verweigerung mit Begründung',
      'Beide Seiten unterschreiben das Protokoll',
    ],
  ),
  konzept(
    'n-ga-8',
    'ls-abnahme',
    'Die fiktive Abnahme',
    'Damit ein Besteller die Abnahme nicht einfach aussitzen kann, gilt das Werk unter bestimmten Bedingungen als abgenommen (§ 640 Abs. 2 BGB).',
    points: [
      'Der Unternehmer setzt nach Fertigstellung eine angemessene Frist zur Abnahme',
      'Der Besteller verweigert die Abnahme nicht innerhalb der Frist unter Angabe mindestens eines Mangels',
      'Bei Verbrauchern nur, wenn sie mit der Aufforderung in Textform auf diese Folge hingewiesen wurden',
      'Folge: Das Werk gilt als abgenommen, mit allen Wirkungen der Abnahme',
    ],
  ),
  beispiel(
    'n-ga-9',
    'ls-abnahme',
    'Rechtsfall: Kundenportal mit Mängeln',
    'Eine Agentur übergibt einem Großhändler ein Kundenportal zum Festpreis von 24.000 €. Beim Abnahmetest am 2. Juni scheitert der Login für alle Kunden. Nach der Korrektur zeigt der zweite Test am 9. Juni nur noch einen Tippfehler auf der Startseite; seine Beseitigung kostet etwa 150 €.',
    schritte: [
      '2. Juni: Login scheitert -> Portal nicht nutzbar, wesentlicher Mangel -> Abnahme verweigern und Frist zur Beseitigung setzen',
      '9. Juni: Tippfehler -> unwesentlicher Mangel, eine Verweigerung wäre unzulässig (§ 640 Abs. 1)',
      'Abnahme unter Vorbehalt: Tippfehler mit Frist ins Protokoll -> die Rechte daran bleiben erhalten (§ 640 Abs. 3)',
      'Folgen ab 9. Juni: 24.000 € fällig, Gefahrübergang, Verjährung beginnt, Beweislast beim Großhändler',
      'Bis zur Beseitigung darf er einen angemessenen Teil zurückhalten, in der Regel das Doppelte der Kosten: 2 × 150 € = 300 € (§ 641 Abs. 3)',
    ],
    ergebnis:
        'Abnahme am 9. Juni unter Vorbehalt: 23.700 € sofort, 300 € nach Beseitigung des Tippfehlers.',
  ),
  vergleich(
    'n-ga-10',
    'ls-abnahme',
    'Abnahme bei Kauf, Werk und Dienst',
    'Das Wort „Abnahme“ bedeutet je nach Vertrag etwas anderes. Genau das wird in Prüfungen gern abgefragt.',
    [
      ['Vertrag', '„Abnahme“ bedeutet'],
      [
        'Kaufvertrag',
        'Käufer nimmt die Ware körperlich entgegen (§ 433 Abs. 2)',
      ],
      ['Werkvertrag', 'Besteller billigt das Werk als vertragsgemäß (§ 640)'],
      ['Dienstvertrag', 'keine Abnahme, bezahlt wird die Tätigkeit'],
    ],
  ),
  falle(
    'n-ga-11',
    'ls-abnahme',
    'Abnahme ohne Unterschrift',
    'Wer ein Werk nach einer angemessenen Prüfzeit produktiv nutzt und vorbehaltlos bezahlt, kann es konkludent abgenommen haben, auch ganz ohne Protokoll. Und wer ein Werk trotz bekannter Mängel ohne Vorbehalt abnimmt, verliert für diese Mängel Nacherfüllung, Selbstvornahme, Rücktritt und Minderung. Nur der Schadensersatz bleibt (§ 640 Abs. 3 BGB).',
    points: [
      'Rüge Mängel immer schriftlich, bevor du produktiv gehst',
      'Trag bekannte Mängel ins Abnahmeprotokoll ein',
    ],
  ),
  merke(
    'n-ga-12',
    'ls-abnahme',
    'Abnahme auf einen Blick',
    'Die Abnahme ist der Wendepunkt im Werkvertrag. Wer sie sauber dokumentiert, sichert seine Rechte.',
    points: [
      'Pflicht bei vertragsgemäßem Werk, keine Verweigerung wegen unwesentlicher Mängel',
      'Folgen: Vergütung fällig, Gefahrübergang, Verjährungsbeginn, Beweislastumkehr',
      'Arten: ausdrücklich, konkludent, fiktiv, Teilabnahme',
    ],
    satz:
        'Bekannte Mängel gehören ins Abnahmeprotokoll, sonst sind die Rechte darauf weitgehend weg.',
  ),

  // ================================================== Veränderung nach Lewin
  konzept(
    'n-cl-1',
    'cm-lewin',
    'Change Management',
    'Change Management steuert Veränderungen in Organisationen so, dass die Betroffenen sie mittragen, etwa die Einführung eines neuen ERP-Systems oder eines Ticketsystems. Nicht verwechseln mit dem Change nach ITIL: Der meint eine einzelne technische Änderung.',
    points: [
      'Auslöser: neue Technik, Kundenanforderungen, Gesetze, Wettbewerb, Kostendruck',
      'Erfolgsfaktoren: klares Ziel, offene Kommunikation, Beteiligung, Qualifizierung',
      'Das bekannteste Modell stammt von dem Psychologen Kurt Lewin',
    ],
  ),
  konzept(
    'n-cl-2',
    'cm-lewin',
    'Das Drei-Phasen-Modell',
    'Kurt Lewin beschreibt Veränderung als drei Phasen: Auftauen, Verändern, Einfrieren. Das Bild dahinter: Ein fester Zustand muss erst gelockert werden, bevor er sich formen lässt, und danach wieder fest werden.',
    skizze: FlussDiagramm([
      FlussKnoten('Unfreezing (Auftauen)', seitlich: 'Bereitschaft schaffen'),
      FlussKnoten('Moving (Verändern)', seitlich: 'Neues einführen'),
      FlussKnoten('Refreezing (Einfrieren)', seitlich: 'Neues verankern'),
    ]),
  ),
  vergleich(
    'n-cl-3',
    'cm-lewin',
    'Die drei Phasen',
    'Jede Phase hat ihre eigene Aufgabe, und dazu passen jeweils andere Maßnahmen.',
    [
      ['Phase', 'Ziel', 'Maßnahmen'],
      [
        'Unfreezing',
        'Bereitschaft schaffen',
        'informieren, Dringlichkeit zeigen, beteiligen',
      ],
      ['Moving', 'Neues umsetzen', 'schulen, Pilotbetrieb, begleiten'],
      [
        'Refreezing',
        'Neues verankern',
        'Standards festlegen, Altes abschalten, Erfolge zeigen',
      ],
    ],
  ),
  vergleich(
    'n-cl-4',
    'cm-lewin',
    'Die Kraftfeldanalyse',
    'Lewin sieht jeden Zustand als Gleichgewicht zwischen treibenden und hemmenden Kräften. Wer etwas verändern will, stärkt die treibenden Kräfte oder baut, meist wirksamer, die hemmenden ab. Ein Beispiel ist die Einführung eines Ticketsystems.',
    [
      ['treibende Kräfte', 'hemmende Kräfte'],
      ['Postfächer laufen über', 'Gewohnheit: „ging doch immer“'],
      ['Kunden beschweren sich', 'Angst vor Kontrolle'],
      ['keine Kennzahlen', 'keine Zeit für Schulungen'],
    ],
    merksatz:
        'Mehr Druck von der treibenden Seite erzeugt oft mehr Gegendruck. Hemmnisse abbauen wirkt nachhaltiger.',
  ),
  konzept(
    'n-cl-5',
    'cm-lewin',
    'Rollen im Veränderungsprozess',
    'Veränderung braucht klare Rollen. Wer welche Aufgabe hat, sollte schon beim Auftauen feststehen.',
    points: [
      'Sponsor: Führungskraft, die das Ziel vorgibt und Ressourcen bereitstellt',
      'Change Manager: plant und steuert die Veränderung',
      'Key-User bzw. Multiplikatoren: testen früh und helfen später den Kollegen',
      'Betroffene: alle, deren Arbeit sich ändert',
      'Betriebsrat: bestimmt mit, wenn ein System Leistung oder Verhalten überwachen kann (§ 87 Abs. 1 Nr. 6 BetrVG)',
    ],
  ),
  ablauf(
    'n-cl-6',
    'cm-lewin',
    'Beispiel: neues Ticketsystem',
    'Ein IT-Dienstleister ersetzt seine E-Mail-Postfächer für Supportanfragen durch ein Ticketsystem.',
    [
      'Auftauen: Die Leitung zeigt, wie viele Anfragen in Postfächern untergehen, und holt Wünsche des Teams ein',
      'Verändern: Key-User testen im Pilot, alle werden geschult, Fragen werden schnell beantwortet',
      'Einfrieren: Das Postfach wird abgeschaltet, der Ablauf im Handbuch festgeschrieben, Kennzahlen zeigen den Erfolg',
    ],
  ),
  beispiel(
    'n-cl-7',
    'cm-lewin',
    'Maßnahmen den Phasen zuordnen',
    'Ein Logistiker stellt von Papier-Lieferscheinen auf Tablets um. Ordne vier Maßnahmen den Phasen zu: (a) Schulung der Fahrer, (b) Infoveranstaltung zu den Kosten des Papierprozesses, (c) Papierformulare werden nicht mehr gedruckt, (d) Pilot mit fünf Fahrern.',
    schritte: [
      '(b) zeigt, warum sich etwas ändern muss -> Unfreezing',
      '(d) erprobt das Neue -> Moving',
      '(a) befähigt zum Neuen -> Moving',
      '(c) nimmt den Rückweg und macht das Neue zum Standard -> Refreezing',
    ],
    ergebnis: 'Unfreezing: b · Moving: a, d · Refreezing: c',
  ),
  vergleich(
    'n-cl-8',
    'cm-lewin',
    'Lewin und Kotter',
    'John P. Kotter hat Lewins Gedanken in acht Schritte zerlegt. Die ersten vier bereiten vor, die nächsten drei setzen um, der letzte verankert.',
    [
      ['Lewin', 'Kotters Schritte'],
      [
        'Unfreezing',
        '1 Dringlichkeit erzeugen, 2 Führungskoalition bilden, 3 Vision entwickeln, 4 Vision kommunizieren',
      ],
      [
        'Moving',
        '5 Hindernisse beseitigen, 6 schnelle Erfolge zeigen, 7 Erfolge ausbauen',
      ],
      ['Refreezing', '8 in der Kultur verankern'],
    ],
  ),
  konzept(
    'n-cl-11',
    'cm-lewin',
    'Einführungsstrategien',
    'In der Phase des Veränderns geht das neue System in Betrieb. Wie umgestellt wird, entscheidet über Risiko, Kosten und die Belastung der Beschäftigten. Vier Strategien solltest du kennen.',
    points: [
      'Sofortumstellung (Stichtag, Big Bang): Zu einem festen Termin wird das alte System abgeschaltet, alle arbeiten sofort mit dem neuen',
      'Parallelbetrieb: Altes und neues System laufen einige Wochen nebeneinander, die Ergebnisse werden verglichen',
      'Stufenweise Einführung: Das neue System löst das alte Schritt für Schritt ab, etwa Modul für Modul',
      'Pilotbetrieb: Erst eine Abteilung oder ein Standort stellt um, danach folgen die übrigen',
    ],
  ),
  vergleich(
    'n-cl-12',
    'cm-lewin',
    'Vor- und Nachteile der Einführungsstrategien',
    'Keine Strategie ist immer die beste. Je kritischer das System für den laufenden Betrieb ist, desto mehr zählt die Sicherheit.',
    [
      ['Strategie', 'Vorteil', 'Nachteil'],
      [
        'Sofortumstellung',
        'schnell, keine Doppelarbeit, günstig',
        'Fehler treffen sofort alle, kein Rückfall',
      ],
      [
        'Parallelbetrieb',
        'Rückfall möglich, Ergebnisse vergleichbar',
        'doppelte Arbeit, höhere Kosten',
      ],
      [
        'stufenweise',
        'überschaubare Schritte, Lernen unterwegs',
        'dauert lange, Schnittstellen alt/neu',
      ],
      [
        'Pilotbetrieb',
        'Fehler treffen nur einen Bereich',
        'die anderen profitieren erst später',
      ],
    ],
    merksatz:
        'Sofortumstellung spart Aufwand und kostet Sicherheit. Beim Parallelbetrieb ist es umgekehrt.',
  ),
  beispiel(
    'n-cl-13',
    'cm-lewin',
    'Eine Einführungsstrategie wählen',
    'Ein Logistiker mit Dreischichtbetrieb ersetzt in drei Lagerhallen die Papierlisten durch Handscanner. Steht die Kommissionierung, warten sofort Lkw an der Rampe. Welche Strategie passt?',
    schritte: [
      'Sofortumstellung in allen Hallen: Ein Fehler im Scannersystem legt das ganze Lager lahm, ein Rückfall ist nicht vorbereitet -> zu riskant',
      'Parallelbetrieb: Jeder Auftrag müsste auf Papier und im Scanner bestätigt werden -> doppelte Arbeit in allen Schichten',
      'Pilotbetrieb in einer Halle: Fehler treffen nur einen Teil des Lagers, die Erfahrungen fließen in die Schulung der anderen Hallen ein',
      'Danach Halle für Halle umstellen und die Papierlisten jeweils abschaffen (Refreezing)',
    ],
    ergebnis:
        'Pilotbetrieb in einer Halle, danach die übrigen Hallen nacheinander umstellen.',
  ),
  falle(
    'n-cl-9',
    'cm-lewin',
    'Die vergessenen Phasen',
    'Veränderungen scheitern meist nicht in der Umsetzung, sondern am Anfang oder am Ende. Ohne Auftauen fehlt die Einsicht, ohne Einfrieren kehren alle nach wenigen Wochen zu alten Gewohnheiten zurück.',
    points: [
      'In der Phase des Veränderns sinkt die Leistung oft vorübergehend. Das ist normal und kein Zeichen des Scheiterns',
      'Bleibt das alte System verfügbar, ist Refreezing kaum möglich',
    ],
  ),
  merke(
    'n-cl-10',
    'cm-lewin',
    'Lewin in einem Satz',
    'Die Reihenfolge ist fest und lässt sich nicht abkürzen.',
    points: [
      'Unfreezing: Warum? Informieren, beteiligen',
      'Moving: Wie? Schulen, pilotieren, begleiten',
      'Refreezing: Dauerhaft! Standards, Altes abschalten',
    ],
    satz:
        'Erst lockern, dann formen, dann festigen: Unfreezing, Moving, Refreezing.',
  ),

  // ============================================================ Widerstände
  konzept(
    'n-cw-1',
    'cm-widerstand',
    'Widerstand ist normal',
    'Fast jede Veränderung stößt auf Widerstand. Er ist kein böser Wille, sondern ein Signal: Den Betroffenen fehlt etwas. Doppler und Lauterburg fassen das in vier Grundsätzen zusammen.',
    points: [
      'Es gibt keine Veränderung ohne Widerstand',
      'Widerstand enthält immer eine verschlüsselte Botschaft',
      'Wer Widerstand übergeht, erzeugt Blockaden',
      'Mit dem Widerstand arbeiten, nicht gegen ihn',
    ],
  ),
  vergleich(
    'n-cw-2',
    'cm-widerstand',
    'Rational, emotional, politisch',
    'Hinter Widerstand stecken Gründe auf drei Ebenen. Oft wird nur die sachliche Ebene ausgesprochen, obwohl die emotionale überwiegt.',
    [
      ['Ebene', 'Beispiel'],
      ['rational (sachlich)', '„Das neue System ist langsamer.“'],
      ['emotional', 'Angst, Fehler zu machen oder überflüssig zu werden'],
      ['politisch', 'Verlust von Einfluss, Status oder Zuständigkeit'],
    ],
  ),
  vergleich(
    'n-cw-3',
    'cm-widerstand',
    'Vier Ursachen, vier Antworten',
    'Hilfreich ist die Frage, was genau fehlt. Jede Ursache braucht eine andere Antwort.',
    [
      ['Ursache', 'Antwort'],
      ['nicht wissen', 'informieren, Nutzen erklären'],
      ['nicht können', 'schulen, begleiten'],
      ['nicht wollen', 'beteiligen, Vorteile zeigen'],
      ['nicht dürfen', 'Befugnisse und Rahmen klären'],
    ],
  ),
  skizze(
    'n-cw-4',
    'cm-widerstand',
    'Symptome erkennen',
    'Doppler und Lauterburg ordnen die Symptome von Widerstand nach zwei Fragen: Wird geredet (verbal) oder gehandelt (nonverbal)? Wird angegriffen (aktiv) oder ausgewichen (passiv)?',
    QuadrantenDiagramm(
      xAchse: 'passiv → aktiv',
      yAchse: 'nonverbal → verbal',
      obenLinks: Quadrant('Ausweichen', 'Schweigen, Bagatellisieren'),
      obenRechts: Quadrant('Widerspruch', 'Gegenargumente, Vorwürfe'),
      untenLinks: Quadrant('Lustlosigkeit', 'Müdigkeit, Fehlzeiten'),
      untenRechts: Quadrant('Aufregung', 'Unruhe, Gerüchte, Intrigen'),
    ),
  ),
  vergleich(
    'n-cw-5',
    'cm-widerstand',
    'Offen oder verdeckt?',
    'Widerstand zeigt sich nicht immer offen. Verdeckter Widerstand ist schwerer zu erkennen und deshalb gefährlicher, denn er fällt oft erst auf, wenn Termine platzen.',
    [
      ['', 'aktiv', 'passiv'],
      ['offen', 'Widerspruch, Beschwerden', 'Schweigen, Rückzug'],
      [
        'verdeckt',
        'Gerüchte, Stimmungsmache',
        'Verzögern, Dienst nach Vorschrift',
      ],
    ],
  ),
  skizze(
    'n-cw-6',
    'cm-widerstand',
    'Die Veränderungskurve',
    'Nach Richard K. Streich durchlaufen Betroffene sieben Phasen. Die selbst wahrgenommene Kompetenz steigt in der Verneinung kurz an, sackt dann ab und erreicht in der emotionalen Akzeptanz ihren Tiefpunkt, das „Tal der Tränen“. Erst mit dem Ausprobieren steigt sie wieder.',
    BalkenDiagramm(
      [
        Balken('1 Schock', 40),
        Balken('2 Verneinung', 60),
        Balken('3 rationale Einsicht', 35),
        Balken('4 emotionale Akzeptanz', 15, hervorheben: true),
        Balken('5 Ausprobieren', 35),
        Balken('6 Erkenntnis', 65),
        Balken('7 Integration', 85),
      ],
      einheit: '% Kompetenz (schematisch)',
      max: 100,
    ),
  ),
  vergleich(
    'n-cw-7',
    'cm-widerstand',
    'Was in welcher Phase hilft',
    'Wer weiß, wo ein Team auf der Kurve steht, kann passend reagieren.',
    [
      ['Phase', 'Hilfreich'],
      ['Schock, Verneinung', 'informieren, Gründe offen nennen'],
      ['Einsicht, Akzeptanz', 'zuhören, Sorgen ernst nehmen, beteiligen'],
      ['Ausprobieren', 'schulen, Fehler erlauben, begleiten'],
      ['Erkenntnis, Integration', 'Erfolge zeigen, Standards festigen'],
    ],
  ),
  vergleich(
    'n-cw-8',
    'cm-widerstand',
    'Strategien im Umgang mit Widerstand',
    'Kotter und Schlesinger beschreiben Strategien, die je nach Ursache passen. Die oberen sind die Regel, Druck ist die Ausnahme.',
    [
      ['Strategie', 'Wann sinnvoll'],
      ['Information, Kommunikation', 'Widerstand aus Unwissen'],
      ['Beteiligung', 'Betroffene haben wichtiges Wissen'],
      ['Unterstützung, Schulung', 'Angst, fehlendes Können'],
      ['Verhandlung, Ausgleich', 'jemand verliert tatsächlich etwas'],
      ['Anordnung, Druck', 'nur als letztes Mittel, bei großer Eile'],
    ],
  ),
  beispiel(
    'n-cw-9',
    'cm-widerstand',
    'Einen Widerstand analysieren',
    'Bei der Einführung eines neuen ERP-Systems sagt eine erfahrene Sachbearbeiterin: „Die alten Masken kenne ich blind, im neuen System brauche ich für jede Buchung doppelt so lange.“ Seit Wochen erfasst sie Aufträge stillschweigend weiter auf Papier.',
    schritte: [
      'Symptom: Sie umgeht das System ohne Ankündigung -> verdeckter, passiver Widerstand',
      'Ihre Aussage zeigt die Ursache: nicht können, denn ihr fehlt die Routine',
      'Ihr Frust passt zur Phase der Einsicht bzw. Akzeptanz auf der Veränderungskurve',
      'Passend: Einzelschulung, Übersicht der Tastenkürzel, Key-User als Ansprechpartner, Zeit zum Üben',
      'Unpassend: Abmahnung oder Druck, denn das erzeugt nur Scheinanpassung',
    ],
    ergebnis:
        'Ursache „nicht können“. Antwort: gezielt qualifizieren und begleiten.',
  ),
  falle(
    'n-cw-10',
    'cm-widerstand',
    'Druck ist die schlechteste Antwort',
    'Wer Widerstand mit Anweisungen und Sanktionen bricht, erzeugt oft nur Scheinanpassung: Das neue System wird pro forma genutzt, die Arbeit läuft daneben weiter. Beteiligung wirkt nachhaltiger, weil Betroffene zu Mitgestaltenden werden.',
    points: [
      'Schweigen ist keine Zustimmung; oft ist es verdeckter Widerstand',
      'Eine Schulung hilft nicht, wenn die Ursache „nicht wollen“ oder „nicht dürfen“ ist',
    ],
  ),
  merke(
    'n-cw-11',
    'cm-widerstand',
    'Widerstand auf einen Blick',
    'Erkenne den Widerstand zuerst, kläre dann seine Ursache und handle danach passend.',
    points: [
      'Symptome: Widerspruch, Ausweichen, Aufregung, Lustlosigkeit',
      'Ursachen: nicht wissen, nicht können, nicht wollen, nicht dürfen',
      'Tiefpunkt der Kurve: emotionale Akzeptanz',
    ],
    satz:
        'Erst die Ursache klären (nicht wissen, nicht können, nicht wollen, nicht dürfen), dann gezielt handeln.',
  ),

  // ========================================================= Kaizen und KVP
  konzept(
    'n-ck-1',
    'cm-kaizen',
    'Kaizen',
    'Kaizen ist japanisch und bedeutet etwa „Veränderung zum Besseren“. Im deutschen Sprachraum heißt der Ansatz kontinuierlicher Verbesserungsprozess (KVP): viele kleine Verbesserungen, ständig und von allen Mitarbeitenden getragen.',
    points: [
      'kleine, stetige Schritte statt großer Umbrüche',
      'Vorschläge kommen von denen, die die Arbeit machen',
      'Verschwendung (japanisch Muda) erkennen und abbauen',
      'jede Verbesserung wird zum neuen Standard',
    ],
  ),
  vergleich(
    'n-ck-2',
    'cm-kaizen',
    'Kaizen oder Reengineering?',
    'Es gibt zwei gegensätzliche Wege, Prozesse zu verbessern. Business Process Reengineering gestaltet einen Prozess radikal neu.',
    [
      ['', 'Kaizen / KVP', 'Reengineering'],
      ['Tempo', 'evolutionär, stetig', 'radikal, sprunghaft'],
      ['Schritte', 'viele kleine', 'ein großer Umbau'],
      ['Anstoß', 'von unten, alle', 'von oben, Experten'],
      ['Risiko', 'gering', 'hoch'],
    ],
  ),
  skizze(
    'n-ck-3',
    'cm-kaizen',
    'Der PDCA-Zyklus',
    'Jeder einzelne Verbesserungsschritt läuft im PDCA-Zyklus, auch Deming-Kreis genannt. Nach „Act“ beginnt der nächste Zyklus, auf dem neuen, höheren Standard.',
    FlussDiagramm(
      [
        FlussKnoten('Plan: analysieren, planen'),
        FlussKnoten('Do: im Kleinen testen'),
        FlussKnoten('Check: Ergebnis messen'),
        FlussKnoten('Act: standardisieren'),
      ],
      zyklus: true,
      zyklusLabel: 'nächster Zyklus',
    ),
    points: [
      'Plan: Ist-Zustand und Ursache analysieren, Ziel und Maßnahme festlegen',
      'Do: Maßnahme in kleinem Rahmen ausprobieren',
      'Check: mit Kennzahlen prüfen, ob das Ziel erreicht wurde',
      'Act: bei Erfolg zum Standard machen, sonst neu planen',
    ],
  ),
  ablauf(
    'n-ck-4',
    'cm-kaizen',
    'PDCA im Service Desk',
    'Beispiel: Im Service Desk dauert das Anlegen neuer Benutzerkonten zu lange.',
    [
      'Plan: Ursache analysieren: Daten werden dreimal abgetippt; Ziel: Formular mit Vorlage',
      'Do: Die Vorlage vier Wochen im Team testen',
      'Check: Messen. Bearbeitung sinkt von 20 auf 8 Minuten',
      'Act: Die Vorlage wird Standard, dann beginnt der nächste Zyklus',
    ],
  ),
  beispiel(
    'n-ck-5',
    'cm-kaizen',
    'Den Nutzen einer Verbesserung berechnen',
    'Im Service Desk werden pro Monat 150 Benutzerkonten angelegt. Durch eine Vorlage sinkt die Bearbeitungszeit je Konto von 20 auf 8 Minuten. Eine Arbeitsstunde kostet intern 60 €.',
    schritte: [
      'Ersparnis je Konto: 20 − 8 = 12 min, also 12 / 20 = 60 % weniger',
      'Ersparnis pro Monat: 150 × 12 min = 1.800 min = 30 h',
      'Wert pro Monat: 30 h × 60 € = 1.800 €',
      'Wert pro Jahr: 12 × 1.800 € = 21.600 €',
    ],
    ergebnis: '30 Stunden bzw. 1.800 € pro Monat, 21.600 € im Jahr',
  ),
  vergleich(
    'n-ck-6',
    'cm-kaizen',
    'Die sieben Arten der Verschwendung',
    'Muda ist alles, was Aufwand kostet, aber keinen Wert für die Kundschaft schafft. Die sieben klassischen Arten stammen aus der Produktion, lassen sich aber gut auf die IT übertragen.',
    [
      ['Muda', 'im IT-Alltag'],
      ['Transport', 'Daten mehrfach übertragen, viele Übergaben'],
      ['Bestände', 'Tickets, die liegen bleiben'],
      ['Bewegung', 'Infos in fünf Tools zusammensuchen'],
      ['Wartezeit', 'auf Freigaben warten'],
      ['Überproduktion', 'Funktionen, die niemand nutzt'],
      ['Überbearbeitung', 'Berichte, die niemand liest'],
      ['Fehler', 'Nacharbeit, Rückfragen'],
    ],
  ),
  vergleich(
    'n-ck-7',
    'cm-kaizen',
    '5S: Ordnung am Arbeitsplatz',
    'Die 5S-Methode schafft einen aufgeräumten, standardisierten Arbeitsplatz als Grundlage für Verbesserungen, auch digital.',
    [
      ['S', 'Bedeutung', 'IT-Beispiel'],
      ['Seiri', 'Sortieren', 'Unnötiges aussortieren'],
      ['Seiton', 'Systematisch ordnen', 'feste Ablagestruktur'],
      ['Seiso', 'Sauber halten', 'Serverraum, Kabel'],
      ['Seiketsu', 'Standardisieren', 'Namenskonventionen'],
      ['Shitsuke', 'Selbstdisziplin', 'Regeln dauerhaft einhalten'],
    ],
  ),
  konzept(
    'n-ck-8',
    'cm-kaizen',
    'Ursachen finden: fünfmal „Warum?“',
    'Kaizen sucht die Grundursache, nicht das Symptom. Die 5-Why-Methode fragt so lange „Warum?“, bis die eigentliche Ursache auf dem Tisch liegt. Beispiel: Das Anlegen eines Benutzerkontos dauert 20 Minuten.',
    points: [
      'Warum? Die Daten werden abgetippt',
      'Warum? Die Personalabteilung schickt ein eingescanntes PDF',
      'Warum? Es gibt kein digitales Formular',
      'Warum? Niemand hat es je angefragt',
      'Warum? Der Zeitverlust war nicht sichtbar -> Maßnahme: Formular einführen, Zeiten messen',
    ],
  ),
  vergleich(
    'n-ck-9',
    'cm-kaizen',
    'KVP und Vorschlagswesen',
    'Das betriebliche Vorschlagswesen ist älter als KVP und funktioniert anders. Viele Unternehmen nutzen beides.',
    [
      ['', 'KVP', 'Vorschlagswesen'],
      ['wer', 'Team', 'Einzelperson'],
      ['Bereich', 'eigener Arbeitsbereich', 'auch fremde Bereiche'],
      ['Anreiz', 'Verbesserung, Anerkennung', 'Prämie'],
      ['Takt', 'laufend', 'bei Gelegenheit'],
    ],
  ),
  konzept(
    'n-ck-10',
    'cm-kaizen',
    'Gemba und Standards',
    'Kaizen setzt am Ort des Geschehens an, japanisch Gemba. Verbesserungen entstehen dort, wo die Arbeit gemacht wird, nicht im Besprechungsraum. Jede erfolgreiche Verbesserung wird zum neuen Standard; ohne Standard gibt es keinen Ausgangspunkt für den nächsten Schritt.',
    points: [
      'Führungskräfte gehen an den Arbeitsplatz und schauen zu',
      'Standards schriftlich festhalten, z. B. im Handbuch oder als Vorlage',
      'Kennzahlen vorher und nachher messen, sonst ist der Erfolg nicht belegt',
    ],
  ),
  falle(
    'n-ck-11',
    'cm-kaizen',
    'KVP ist kein Projekt',
    'Ein Projekt hat ein Ende, KVP nicht. Wer nach dem ersten Verbesserungszyklus aufhört, betreibt kein Kaizen. Genauso falsch ist es, Kaizen als Aufgabe nur der Qualitätsabteilung oder einer externen Beratung zu sehen.',
    points: [
      'Ein kompletter Neuentwurf eines Prozesses ist Reengineering, kein Kaizen',
    ],
  ),
  merke(
    'n-ck-12',
    'cm-kaizen',
    'Kaizen auf einen Blick',
    'Kaizen ist eine Haltung, bei der jeder täglich ein bisschen verbessert, und zwar mit Methode.',
    points: [
      'Werkzeug: PDCA (Plan, Do, Check, Act)',
      '7 Muda: Transport, Bestände, Bewegung, Wartezeit, Überproduktion, Überbearbeitung, Fehler',
      '5S: Sortieren, Systematisch ordnen, Sauber halten, Standardisieren, Selbstdisziplin',
      'Ursachen mit fünfmal „Warum?“ finden',
    ],
    satz:
        'Kaizen = viele kleine Schritte von allen, ohne Ende. Reengineering = ein großer Schnitt.',
  ),
];
