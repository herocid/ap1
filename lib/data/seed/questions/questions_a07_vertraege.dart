import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 07 - Vertragsmanagement und Service.
///
/// Ergänzt die Altaufgaben aus `seed_qs_service.dart` und
/// `seed_anforderungen.dart`, die bereits Lektionen zugeordnet sind.
final List<Question> questionsA07 = [
  // ============================================ Wie ein Vertrag zustande kommt
  einfach(
    'a7-vz-1',
    'vt-zustandekommen',
    scenario:
        'Ein Systemhaus verschickt seinen Frühjahrskatalog mit Preisen an alle Kunden. Eine Arztpraxis bestellt daraufhin per E-Mail drei Notebooks zum Katalogpreis. Das Systemhaus bestätigt den Auftrag am nächsten Tag.',
    prompt: 'Welche Erklärung ist hier der Antrag?',
    choices: [
      ja(
        'Die Bestellung der Arztpraxis',
        'Der Katalog richtet sich an alle und ist nur eine Aufforderung zum Antrag. Den ersten verbindlichen Schritt macht die Praxis mit ihrer Bestellung.',
      ),
      nein(
        'Der Katalog des Systemhauses',
        'Ein Katalog richtet sich an einen unbestimmten Personenkreis. Er ist eine invitatio ad offerendum, kein Antrag.',
      ),
      nein(
        'Die Auftragsbestätigung des Systemhauses',
        'Sie ist die Annahme des Antrags. Mit ihr kommt der Vertrag zustande.',
      ),
      nein(
        'Es gibt keinen Antrag, weil nichts unterschrieben wurde',
        'Kaufverträge sind grundsätzlich formfrei, eine E-Mail genügt.',
      ),
    ],
    explanation:
        'Der Katalog ist nur eine Aufforderung zum Antrag. Der Antrag ist die Bestellung, die Auftragsbestätigung ist die Annahme. Mit der Annahme ist der Kaufvertrag geschlossen.',
  ),
  zuordnen(
    'a7-vz-2',
    'vt-zustandekommen',
    scenario:
        'Ein IT-Händler hat einer Kanzlei am 2. Mai ein schriftliches Angebot über zehn Monitore gemacht, gültig bis 16. Mai.',
    prompt: 'Ordne jede Erklärung ihrer rechtlichen Wirkung zu.',
    buckets: ['Antrag', 'Annahme', 'weder Antrag noch Annahme'],
    items: [
      zu(
        'Das Angebot des Händlers vom 2. Mai',
        0,
        'Richtet sich an eine bestimmte Person und ist verbindlich.',
      ),
      zu(
        'Die Kanzlei bestellt am 10. Mai zu genau den Angebotsbedingungen.',
        1,
        'Rechtzeitig und inhaltlich deckungsgleich. Der Vertrag kommt zustande.',
      ),
      zu(
        'Die Kanzlei bestellt am 20. Mai zu den Angebotsbedingungen.',
        0,
        'Die Frist ist abgelaufen. Eine verspätete Annahme gilt als neuer Antrag.',
      ),
      zu(
        'Die Kanzlei bestellt am 10. Mai, verlangt aber 10 % Rabatt.',
        0,
        'Eine abgeänderte Annahme gilt als Ablehnung verbunden mit einem neuen Antrag.',
      ),
      zu(
        'Die Kanzlei fragt vorher an, was 27-Zoll-Monitore kosten.',
        2,
        'Eine Anfrage ist unverbindlich.',
      ),
      zu(
        'Der Händler wirbt in einer Fachzeitschrift für Monitore.',
        2,
        'Werbung ist nur eine Aufforderung zum Antrag.',
      ),
    ],
    explanation:
        'Ein Vertrag entsteht nur, wenn die Annahme rechtzeitig kommt und dem Antrag genau entspricht. Verspätete oder geänderte Annahmen sind neue Anträge. Anfragen und Werbung binden niemanden.',
  ),
  tabelle(
    'a7-vz-3',
    'vt-zustandekommen',
    prompt:
        'Bestimme für jeden Fall die Geschäftsfähigkeit und die Wirksamkeit des Geschäfts.',
    zeilen: [
      ['Fall', 'Geschäftsfähigkeit', 'Das Geschäft ist'],
      [
        'Ein 6-jähriges Kind kauft ein Videospiel für 60 €.',
        wahl('geschäftsunfähig', [
          'beschränkt geschäftsfähig',
          'voll geschäftsfähig',
        ], 'Unter 7 Jahren ist man geschäftsunfähig.'),
        wahl(
          'nichtig',
          ['wirksam', 'schwebend unwirksam'],
          'Die Willenserklärung eines Geschäftsunfähigen ist nichtig (§ 105 BGB).',
        ),
      ],
      [
        'Eine 15-Jährige kauft von ihrem Taschengeld bar eine Maus für 20 €.',
        wahl('beschränkt geschäftsfähig', [
          'geschäftsunfähig',
          'voll geschäftsfähig',
        ], 'Von 7 bis 17 Jahren.'),
        wahl(
          'wirksam',
          ['nichtig', 'schwebend unwirksam'],
          'Taschengeldparagraf (§ 110 BGB): mit eigenen Mitteln sofort bezahlt.',
        ),
      ],
      [
        'Ein 17-Jähriger schließt ohne Wissen der Eltern einen Handyvertrag über 24 Monate.',
        wahl('beschränkt geschäftsfähig', [
          'geschäftsunfähig',
          'voll geschäftsfähig',
        ], 'Von 7 bis 17 Jahren.'),
        wahl(
          'schwebend unwirksam',
          ['wirksam', 'nichtig'],
          'Erst die Genehmigung der Eltern macht den Vertrag wirksam (§ 108 BGB).',
        ),
      ],
      [
        'Eine 19-jährige Auszubildende least ein Notebook.',
        wahl('voll geschäftsfähig', [
          'geschäftsunfähig',
          'beschränkt geschäftsfähig',
        ], 'Ab 18 Jahren.'),
        wahl('wirksam', [
          'nichtig',
          'schwebend unwirksam',
        ], 'Volljährige schließen Verträge ohne Zustimmung anderer.'),
      ],
    ],
    explanation:
        'Unter 7 Jahren: geschäftsunfähig, Erklärungen sind nichtig. 7 bis 17 Jahre: beschränkt geschäftsfähig, Verträge sind bis zur Genehmigung der Eltern schwebend unwirksam, außer beim Taschengeldparagrafen. Ab 18: voll geschäftsfähig.',
    punkte: 4,
  ),

  einfach(
    'a7-vz-4',
    'vt-zustandekommen',
    scenario:
        'Ein Onlineshop zeigt ein Notebook wegen eines Eingabefehlers für 89 € statt 899 €. Ein Kunde bestellt sofort. Er erhält eine automatische E-Mail: „Vielen Dank, wir haben Ihre Bestellung erhalten.“',
    prompt: 'Ist damit ein Kaufvertrag zustande gekommen?',
    choices: [
      ja(
        'Nein. Die Artikelseite ist nur eine Aufforderung zum Antrag, und die Eingangsbestätigung ist noch keine Annahme.',
        'Der Kunde hat den Antrag gemacht. Die E-Mail bestätigt nur den Zugang der Bestellung, eine Annahme steht noch aus.',
      ),
      nein(
        'Ja, weil der im Shop angezeigte Preis verbindlich ist.',
        'Webshop-Seiten richten sich an alle und sind keine Anträge. Der Shop muss nicht zu jedem angezeigten Preis verkaufen.',
      ),
      nein(
        'Ja, weil jede Bestätigungs-E-Mail eine Annahme ist.',
        'Entscheidend ist der Wortlaut: „Bestellung erhalten“ bestätigt nur den Eingang, „Wir nehmen an“ wäre eine Annahme.',
      ),
      nein(
        'Nein, weil Verträge im Internet schriftlich geschlossen werden müssen.',
        'Kaufverträge sind formfrei, auch im Internet genügt ein Klick.',
      ),
    ],
    explanation:
        'Die Artikelseite ist nur eine Aufforderung zum Antrag, die Bestellung ist der Antrag, und die Eingangsbestätigung bestätigt bloß den Zugang (§ 312i BGB). Erst eine Auftrags- oder Versandbestätigung wäre die Annahme. Hätte der Shop angenommen, könnte er wegen des Eingabefehlers (Erklärungsirrtum) unverzüglich anfechten.',
    difficulty: 2,
  ),
  zuordnen(
    'a7-vz-5',
    'vt-zustandekommen',
    prompt: 'Ist das Rechtsgeschäft nichtig, anfechtbar oder wirksam?',
    buckets: ['nichtig', 'anfechtbar', 'wirksam'],
    items: [
      zu(
        'Zwei Personen verkaufen ein Grundstück per Handschlag, ohne Notar.',
        0,
        'Die gesetzlich vorgeschriebene notarielle Form fehlt (§ 125 BGB).',
      ),
      zu(
        'Ein Kunde kauft Monitore und stellt später fest, dass er sie gar nicht braucht.',
        2,
        'Ein Motivirrtum ist kein Anfechtungsgrund, der Vertrag bleibt wirksam.',
      ),
      zu(
        'Ein Systemhaus hat intern falsch kalkuliert und merkt, dass der vereinbarte Preis zu niedrig ist.',
        2,
        'Ein interner Kalkulationsirrtum ist ein Motivirrtum und berechtigt nicht zur Anfechtung.',
      ),
      zu(
        'Ein 6-jähriges Kind kauft ein Videospiel für 60 €.',
        0,
        'Unter 7 Jahren ist man geschäftsunfähig, deshalb ist die Erklärung nichtig (§ 105 BGB).',
      ),
      zu(
        'Ein Verkäufer verschweigt bewusst einen reparierten Wasserschaden am Server.',
        1,
        'Arglistige Täuschung nach § 123 BGB: anfechtbar innerhalb eines Jahres ab Entdeckung.',
      ),
      zu(
        'Ein Händler tippt im Angebot 1.000 statt 100 Stück.',
        1,
        'Erklärungsirrtum nach § 119 Abs. 1 BGB: unverzüglich anfechtbar.',
      ),
    ],
    explanation:
        'Nichtig: Geschäftsunfähigkeit, fehlende Form, Schein- und Scherzgeschäft, Gesetzes- oder Sittenverstoß. Anfechtbar: Erklärungs-, Inhalts- und Eigenschaftsirrtum, Täuschung, Drohung. Wer sich nur über seine Beweggründe irrt, bleibt an den Vertrag gebunden.',
    difficulty: 2,
  ),
  markieren(
    'a7-vz-6',
    'vt-zustandekommen',
    scenario:
        'Ein Onlinehändler verkauft Hardware an Verbraucher. Seine Allgemeinen Geschäftsbedingungen (AGB) enthalten unter anderem die folgenden Klauseln.',
    prompt:
        'Markiere alle Klauseln, die gegenüber Verbrauchern unwirksam sind.',
    zeilen: [
      ja(
        '§ 3 Die Gewährleistung für Neuware ist ausgeschlossen.',
        'Beim Verbrauchsgüterkauf ist die Gewährleistung für neue Sachen zwingend.',
      ),
      nein(
        '§ 4 Der Kaufpreis ist innerhalb von 14 Tagen nach Erhalt der Rechnung zu zahlen.',
        'Ein übliches Zahlungsziel benachteiligt niemanden unangemessen.',
      ),
      ja(
        '§ 5 (im Abschnitt „Versand“) Mit der Bestellung wird der Kunde Mitglied im kostenpflichtigen Premium-Club.',
        'Überraschende Klausel. Sie wird nicht Vertragsbestandteil (§ 305c BGB).',
      ),
      nein(
        '§ 6 Die Ware bleibt bis zur vollständigen Bezahlung Eigentum des Verkäufers.',
        'Der Eigentumsvorbehalt ist üblich und zulässig (§ 449 BGB).',
      ),
      ja(
        '§ 7 Der Verkäufer haftet nicht für Schäden, auch nicht bei Vorsatz und grober Fahrlässigkeit.',
        'Ein solcher Haftungsausschluss ist in AGB unwirksam (§ 309 Nr. 7 BGB).',
      ),
      nein(
        '§ 8 Der Versand innerhalb Deutschlands kostet 4,90 €.',
        'Klare Preisangabe, mit der jeder Kunde rechnet.',
      ),
    ],
    explanation:
        'AGB unterliegen einer Inhaltskontrolle: Überraschende Klauseln werden nicht Vertragsbestandteil, unangemessene sind unwirksam. Der übrige Vertrag bleibt bestehen; statt der unwirksamen Klausel gilt das Gesetz (§ 306 BGB). Individuell ausgehandelte Absprachen gehen AGB immer vor (§ 305b BGB).',
    difficulty: 2,
  ),
  einfach(
    'a7-vz-7',
    'vt-zustandekommen',
    scenario:
        'Ein Systemhaus hat einer Kanzlei per E-Mail 50 Switches zu je 129 € angeboten. Gemeint waren 219 €, der Vertriebsmitarbeiter hat Ziffern vertauscht. Die Kanzlei nimmt sofort an. Der Fehler fällt dem Systemhaus zwei Tage später auf.',
    prompt: 'Was sollte das Systemhaus tun?',
    choices: [
      ja(
        'Unverzüglich die Anfechtung wegen Erklärungsirrtums erklären',
        'Ein Zahlendreher ist ein Erklärungsirrtum (§ 119 Abs. 1 BGB). Angefochten werden muss ohne schuldhaftes Zögern (§ 121 BGB).',
      ),
      nein(
        'Nichts. Der Vertrag ist wegen des falschen Preises automatisch nichtig',
        'Ein Irrtum macht den Vertrag nur anfechtbar. Ohne Anfechtung bleibt er wirksam.',
      ),
      nein(
        'Sich ein Jahr Zeit lassen und dann anfechten',
        'Die Jahresfrist gilt nur bei arglistiger Täuschung und Drohung.',
      ),
      nein(
        'Den Vertrag innerhalb von 14 Tagen widerrufen',
        'Ein Widerrufsrecht hat nur ein Verbraucher, etwa im Fernabsatz, nicht der verkaufende Unternehmer.',
      ),
    ],
    explanation:
        'Bei einem Erklärungsirrtum ist der Vertrag wirksam, aber anfechtbar. Die Anfechtung muss unverzüglich nach Entdeckung erklärt werden; danach ist der Vertrag rückwirkend nichtig. Das Systemhaus muss der Kanzlei dann den Vertrauensschaden ersetzen (§ 122 BGB).',
    difficulty: 3,
  ),
  einfach(
    'a7-vz-8',
    'vt-zustandekommen',
    scenario:
        'Die Skizze zeigt den Schriftverkehr zwischen einem Händler und einem Kunden.',
    skizze: SequenzDiagramm(
      ['Kunde', 'Händler'],
      [
        Nachricht(1, 0, 'Angebot, gültig bis 30.04.'),
        Nachricht(0, 1, 'Bestellung am 05.05.'),
        Nachricht(1, 0, 'Auftragsbestätigung', antwort: true),
      ],
    ),
    prompt: 'Mit welcher Erklärung kommt der Vertrag zustande?',
    choices: [
      ja(
        'Mit der Auftragsbestätigung des Händlers',
        'Die Bestellung kam nach Fristablauf und ist deshalb ein neuer Antrag. Den nimmt der Händler mit der Auftragsbestätigung an.',
      ),
      nein(
        'Mit der Bestellung des Kunden',
        'Sie wäre nur bei rechtzeitigem Eingang eine Annahme gewesen. Nach dem 30.04. ist sie ein neuer Antrag (§ 150 Abs. 1 BGB).',
      ),
      nein(
        'Mit dem Angebot des Händlers',
        'Ein Angebot allein ist nur der Antrag; es braucht immer eine Annahme.',
      ),
      nein(
        'Es kommt kein Vertrag zustande, weil die Frist abgelaufen ist.',
        'Der Fristablauf beendet nur die Bindung an das erste Angebot. Der neue Antrag kann trotzdem angenommen werden.',
      ),
    ],
    explanation:
        'Eine verspätete Annahme gilt als neuer Antrag (§ 150 Abs. 1 BGB). Deshalb ist hier die Bestellung vom 05.05. der Antrag und die Auftragsbestätigung die Annahme. Hätte der Kunde bis 30.04. bestellt, wäre schon die Bestellung die Annahme gewesen.',
    difficulty: 2,
  ),

  // ============================================================ Vertragsarten
  zuordnen(
    'a7-vy-1',
    'vt-arten',
    prompt: 'Ordne jede Vereinbarung der passenden Vertragsart zu.',
    buckets: ['Kaufvertrag', 'Werkvertrag', 'Dienstvertrag', 'Mietvertrag'],
    items: [
      zu(
        'Ein Büro kauft zehn Drucker.',
        0,
        'Übergabe und Eigentum an Sachen gegen Kaufpreis.',
      ),
      zu(
        'Eine Agentur programmiert zum Festpreis eine individuelle App für die Lagerverwaltung.',
        1,
        'Geschuldet ist ein funktionierendes Ergebnis.',
      ),
      zu(
        'Ein Administrator unterstützt stundenweise den Support, abgerechnet nach Aufwand.',
        2,
        'Geschuldet ist die Tätigkeit, kein bestimmtes Ergebnis.',
      ),
      zu(
        'Ein CRM wird als SaaS für 49 € pro Nutzer und Monat genutzt.',
        3,
        'Nutzung auf Zeit gegen Entgelt, also typischerweise Miete.',
      ),
      zu(
        'Ein Webshop-Betreiber nutzt 12 Monate lang einen Server im Rechenzentrum gegen Monatsgebühr.',
        3,
        'Gebrauchsüberlassung auf Zeit.',
      ),
      zu(
        'Ein Unternehmen erwirbt Standardsoftware mit unbefristeter Lizenz gegen Einmalzahlung.',
        0,
        'Dauerhafte Überlassung gegen Einmalzahlung wird wie ein Kauf behandelt.',
      ),
    ],
    explanation:
        'Frag dich, was geschuldet wird: Eigentum oder dauerhafte Überlassung spricht für Kauf, ein Erfolg für den Werkvertrag, die bloße Tätigkeit für den Dienstvertrag und Gebrauch auf Zeit gegen Entgelt für Miete.',
  ),
  einfach(
    'a7-vy-2',
    'vt-arten',
    scenario:
        'Ein Softwarehaus bucht eine freiberufliche Entwicklerin: „Unterstützung des Entwicklungsteams, 40 Stunden pro Woche, Abrechnung nach geleisteten Stunden.“ Ein bestimmtes Ergebnis wird nicht vereinbart.',
    prompt: 'Welche Vertragsart liegt vor?',
    choices: [
      ja(
        'Dienstvertrag',
        'Geschuldet ist das Tätigwerden, bezahlt wird nach Aufwand.',
      ),
      nein(
        'Werkvertrag',
        'Dafür müsste ein bestimmter Erfolg, etwa ein fertiges Modul, geschuldet sein.',
      ),
      nein(
        'Werklieferungsvertrag',
        'Er betrifft die Herstellung und Lieferung beweglicher Sachen.',
      ),
      nein('Kaufvertrag', 'Es wird keine Sache übereignet.'),
    ],
    explanation:
        'Entscheidend ist, was geschuldet wird. Hier ist es nur die Arbeitsleistung, kein Ergebnis. Deshalb liegt ein Dienstvertrag vor: ohne Abnahme, vergütet nach Stunden.',
  ),

  einfach(
    'a7-vy-3',
    'vt-arten',
    scenario:
        'Ein Autohaus nutzt eine Online-Terminbuchung als SaaS für 79 € im Monat. Wegen eines Fehlers beim Anbieter ist die Anwendung drei Tage lang nicht erreichbar.',
    prompt:
        'Welche Vertragsart liegt typischerweise vor, und was folgt daraus für die Monatsgebühr?',
    choices: [
      ja(
        'Mietvertrag: Die Gebühr mindert sich für die Ausfallzeit kraft Gesetzes.',
        'SaaS ist Gebrauchsüberlassung auf Zeit. Bei einem erheblichen Mangel der Mietsache mindert sich die Miete automatisch (§ 536 BGB).',
      ),
      nein(
        'Kaufvertrag: Das Autohaus muss erst Nacherfüllung verlangen.',
        'Es wird nichts dauerhaft übereignet, sondern Nutzung auf Zeit gewährt.',
      ),
      nein(
        'Werkvertrag: Das Autohaus muss die Software erneut abnehmen.',
        'Geschuldet ist nicht die Herstellung eines Werks, sondern die laufende Bereitstellung.',
      ),
      nein(
        'Dienstvertrag: Die Gebühr ist voll zu zahlen, weil nur eine Tätigkeit geschuldet ist.',
        'Der Anbieter schuldet die nutzbare Bereitstellung der Software, nicht bloß ein Bemühen.',
      ),
    ],
    explanation:
        'Software as a Service wird als Miete eingeordnet (§ 535 BGB). Der Anbieter muss die Software während der Laufzeit gebrauchstauglich halten. Fällt sie erheblich aus, ist der Kunde für diese Zeit ganz oder teilweise von der Miete befreit (§ 536 BGB); er muss den Ausfall aber melden.',
    difficulty: 2,
  ),
  lueckentext(
    'a7-vy-4',
    'vt-arten',
    prompt: 'Ergänze die Aussagen zum Werkvertrag.',
    text:
        'Beim Werkvertrag schuldet der Unternehmer einen {0}, zum Beispiel eine lauffähige Software. Die Vergütung wird grundsätzlich mit der {1} fällig. Bei Mängeln entscheidet der {2}, ob nachgebessert oder neu hergestellt wird. Wird nur die Tätigkeit geschuldet, liegt ein {3} vor. Für die Herstellung und Lieferung beweglicher Sachen gilt {4}.',
    luecken: [
      wahl('Erfolg', [
        'Arbeitseinsatz',
        'Kaufpreis',
      ], 'Kennzeichen des Werkvertrags (§ 631 BGB).'),
      wahl('Abnahme', ['Bestellung', 'Lieferung der Rechnung'], '§ 641 BGB.'),
      wahl(
        'Unternehmer',
        ['Besteller', 'Gutachter'],
        '§ 635 BGB, also anders als beim Kauf, wo der Käufer wählt.',
      ),
      wahl('Dienstvertrag', ['Kaufvertrag', 'Mietvertrag']),
      wahl('Kaufrecht', [
        'Mietrecht',
        'Dienstvertragsrecht',
      ], 'Werklieferungsvertrag nach § 650 BGB.'),
    ],
    explanation:
        'Beim Werkvertrag ist ein Erfolg geschuldet. Die Vergütung wird mit der Abnahme fällig, und über die Art der Nacherfüllung entscheidet der Unternehmer. Wird nur Tätigkeit geschuldet, ist es ein Dienstvertrag; wird eine bewegliche Sache hergestellt und geliefert, gilt Kaufrecht.',
    difficulty: 2,
  ),
  zuordnen(
    'a7-vy-5',
    'vt-arten',
    prompt: 'Ordne jede Vereinbarung der passenden Vertragsart zu.',
    buckets: ['Leihe', 'Pacht', 'Darlehen', 'Leasing'],
    items: [
      zu(
        'Ein Händler überlässt einer Schule kostenlos für vier Wochen einen Beamer.',
        0,
        'Unentgeltliche Gebrauchsüberlassung auf Zeit (§ 598 BGB).',
      ),
      zu(
        'Ein Betreiber übernimmt die Betriebskantine samt Ausstattung gegen Entgelt und behält die Einnahmen.',
        1,
        'Gebrauch plus Fruchtziehung, also Erträge (§ 581 BGB).',
      ),
      zu(
        'Eine Bank stellt 50.000 € für neue Server bereit, zurückzuzahlen mit Zinsen.',
        2,
        'Geld auf Zeit gegen Zins (§ 488 BGB).',
      ),
      zu(
        'Eine Leasinggesellschaft kauft 40 Notebooks und überlässt sie 36 Monate gegen monatliche Raten.',
        3,
        'Finanzierte Gebrauchsüberlassung, im Kern wie Miete behandelt.',
      ),
      zu(
        'Ein Kollege überlässt einem anderen unentgeltlich für eine Woche sein Messgerät.',
        0,
        'Unentgeltlich, auf Zeit: Leihe.',
      ),
    ],
    explanation:
        'Bei der Leihe ist der Gebrauch unentgeltlich. Die Pacht umfasst Gebrauch und Erträge gegen Entgelt. Beim Darlehen gibt es Geld oder vertretbare Sachen auf Zeit. Leasing ist eine vom Leasinggeber finanzierte Gebrauchsüberlassung und im BGB nicht eigens geregelt.',
    difficulty: 2,
  ),
  einfach(
    'a7-vy-6',
    'vt-arten',
    scenario:
        'Ein Systemhaus liefert einem Kunden einen Server unter Eigentumsvorbehalt. Der Server steht beim Kunden im Rechenzentrum, bezahlt ist erst die Hälfte des Kaufpreises.',
    prompt: 'Wer ist Eigentümer und wer ist Besitzer des Servers?',
    choices: [
      ja(
        'Eigentümer: Systemhaus; Besitzer: Kunde',
        'Unter Eigentumsvorbehalt geht das Eigentum erst mit vollständiger Zahlung über (§ 449 BGB). Die tatsächliche Herrschaft hat der Kunde.',
      ),
      nein(
        'Eigentümer und Besitzer: Kunde',
        'Das Eigentum wechselt wegen des Vorbehalts erst nach vollständiger Zahlung.',
      ),
      nein(
        'Eigentümer: Kunde; Besitzer: Systemhaus',
        'Umgekehrt: Das Systemhaus hat den Server nicht mehr in seiner Gewalt.',
      ),
      nein(
        'Beide sind je zur Hälfte Eigentümer.',
        'Eine Teilzahlung führt nicht zu anteiligem Eigentum.',
      ),
    ],
    explanation:
        'Besitz ist die tatsächliche Herrschaft, Eigentum die rechtliche. Beim Eigentumsvorbehalt übergibt der Verkäufer die Sache, bleibt aber bis zur vollständigen Zahlung Eigentümer und kann sie bei Zahlungsausfall nach Rücktritt zurückverlangen.',
    difficulty: 1,
  ),

  // ================================================ Urheberrecht und Lizenzen
  lueckentext(
    'a7-vu-1',
    'vt-urheber',
    prompt: 'Ergänze die Aussagen zum Urheberrecht an Software.',
    text:
        'Der Schutz eines Programms entsteht {0}. Er endet {1} Jahre nach dem Tod des Urhebers. Das Urheberrecht selbst ist {2}. An andere weitergegeben werden {3}; sie können zeitlich, räumlich und inhaltlich {4} werden.',
    luecken: [
      wahl(
        'automatisch mit der Schöpfung',
        ['mit der Anmeldung beim Patentamt', 'mit dem ©-Vermerk'],
        'Eine Anmeldung oder ein Vermerk ist nicht nötig.',
      ),
      wahl('70', ['20', '50'], 'Gesetzliche Schutzdauer (§ 64 UrhG).'),
      wahl(
        'nicht übertragbar, nur vererbbar',
        ['frei verkäuflich', 'auf 10 Jahre befristet'],
        'Urheber bleibt der Mensch, der das Werk geschaffen hat.',
      ),
      wahl('Nutzungsrechte', ['Patente', 'Markenrechte']),
      wahl(
        'beschränkt',
        ['vererbt', 'angemeldet'],
        'Zum Beispiel drei Jahre, nur in Deutschland, nur für interne Zwecke.',
      ),
    ],
    explanation:
        'Urheberrecht entsteht automatisch, bleibt beim Menschen, der das Werk geschaffen hat, und endet 70 Jahre nach dessen Tod. Weitergegeben werden nur Nutzungsrechte.',
  ),
  einfach(
    'a7-vu-2',
    'vt-urheber',
    scenario:
        'Eine Agentur entwickelt für einen Webshop-Betreiber eine Rabattsoftware. Im Vertrag erhält der Kunde ein ausschließliches, zeitlich und räumlich unbeschränktes Nutzungsrecht. Ein Jahr später möchte die Agentur dieselbe Software an einen Konkurrenten des Kunden lizenzieren.',
    prompt: 'Wie ist die Lage?',
    choices: [
      ja(
        'Das ist unzulässig, weil das ausschließliche Nutzungsrecht jede Nutzung durch andere ausschließt.',
        'Ein ausschließliches Nutzungsrecht erlaubt nur dem Inhaber die Nutzung und schließt die Vergabe weiterer Lizenzen aus.',
      ),
      nein(
        'Das ist zulässig, weil die Urheber bei der Agentur arbeiten.',
        'Wer Urheber ist, ändert nichts daran, dass das ausschließliche Nutzungsrecht beim Kunden liegt.',
      ),
      nein(
        'Das ist unzulässig, weil der Kunde durch den Vertrag Urheber geworden ist.',
        'Die Begründung stimmt nicht: Das Urheberrecht ist nicht übertragbar, der Kunde hat nur ein Nutzungsrecht.',
      ),
      nein(
        'Das ist zulässig, weil nach einem Jahr alle Nutzungsrechte automatisch erlöschen.',
        'Das Nutzungsrecht ist zeitlich unbeschränkt vereinbart.',
      ),
    ],
    explanation:
        'Einfaches Nutzungsrecht: Der Rechteinhaber darf weitere Lizenzen vergeben. Ausschließliches Nutzungsrecht: Nur der Inhaber nutzt, weitere Lizenzen sind ausgeschlossen. Das Urheberrecht selbst wechselt nie.',
  ),

  einfach(
    'a7-vu-3',
    'vt-urheber',
    scenario:
        'Ein Softwarehaus beauftragt einen freiberuflichen Entwickler mit einem Plug-in. Der Vertrag regelt Preis und Liefertermin, aber keine Nutzungsrechte.',
    prompt: 'Welche Aussage trifft zu?',
    choices: [
      ja(
        'Das Softwarehaus erhält nur die Nutzungsrechte, die der Vertragszweck erfordert. Es sollte sie ausdrücklich regeln.',
        'Zweckübertragungslehre (§ 31 Abs. 5 UrhG): Nicht genannte Rechte gelten nur im Umfang des Vertragszwecks als eingeräumt.',
      ),
      nein(
        'Das Softwarehaus erhält automatisch alle Verwertungsrechte, wie bei einem Angestellten.',
        '§ 69b UrhG gilt nur für Arbeitnehmer, nicht für Freiberufler.',
      ),
      nein(
        'Das Softwarehaus wird Urheber, weil es das Plug-in bezahlt hat.',
        'Urheber ist immer der Mensch, der das Werk geschaffen hat.',
      ),
      nein(
        'Das Plug-in ist nicht geschützt, weil kein ©-Vermerk angebracht ist.',
        'Der Schutz entsteht automatisch mit der Schöpfung.',
      ),
    ],
    explanation:
        'Bei Freiberuflern und Agenturen regelt allein der Vertrag die Nutzungsrechte. Fehlt eine Regelung, bekommt der Auftraggeber nur, was für den Vertragszweck nötig ist. Wer Code weiterverkaufen oder exklusiv nutzen will, muss das ausdrücklich vereinbaren.',
    difficulty: 3,
  ),
  zuordnen(
    'a7-vu-4',
    'vt-urheber',
    prompt:
        'Darf der rechtmäßige Nutzer das ohne gesonderte Zustimmung des Rechteinhabers?',
    buckets: ['ohne Zustimmung erlaubt', 'nur mit Zustimmung oder Lizenz'],
    items: [
      zu(
        'Einen Fehler beheben, der die bestimmungsgemäße Nutzung verhindert, wenn der Vertrag nichts anderes regelt',
        0,
        '§ 69d Abs. 1 UrhG erlaubt die Fehlerberichtigung.',
      ),
      zu(
        'Den Quellcode ändern und die neue Version verkaufen',
        1,
        'Bearbeitung und Verbreitung brauchen die Zustimmung.',
      ),
      zu(
        'Das Programm beobachten und testen, um seine Funktionsweise zu verstehen',
        0,
        '§ 69d Abs. 3 UrhG.',
      ),
      zu(
        'Das Programm auf 12 statt der lizenzierten 10 Rechner installieren',
        1,
        'Jede Installation ist eine Vervielfältigung und braucht ein Nutzungsrecht.',
      ),
      zu(
        'Eine Sicherungskopie anlegen, die für die weitere Nutzung erforderlich ist',
        0,
        '§ 69d Abs. 2 UrhG: kann vertraglich nicht untersagt werden.',
      ),
      zu(
        'Kopien des Programms an Kunden weitergeben',
        1,
        'Verbreitung ist dem Rechteinhaber vorbehalten (§ 69c UrhG).',
      ),
    ],
    explanation:
        '§§ 69d und 69e UrhG garantieren Mindestrechte: bestimmungsgemäße Nutzung mit Fehlerberichtigung, nötige Sicherungskopie, Beobachten und Testen, eng begrenzt auch Dekompilieren für Schnittstellen. Vervielfältigen, Bearbeiten und Verbreiten darüber hinaus erfordert eine Lizenz.',
    difficulty: 2,
  ),
  mehrfach(
    'a7-vu-5',
    'vt-urheber',
    prompt: 'Welche Aussagen zum Weiterverkauf von Software sind richtig?',
    choices: [
      ja(
        'Eine mit Zustimmung des Rechteinhabers in der EU verkaufte Programmkopie darf grundsätzlich weiterverkauft werden.',
        'Erschöpfungsgrundsatz nach § 69c Nr. 3 UrhG.',
      ),
      ja(
        'Das gilt nach dem EuGH auch für per Download gekaufte, unbefristete Lizenzen.',
        'Urteil UsedSoft (2012).',
      ),
      ja(
        'Der Verkäufer muss seine eigene Kopie unbrauchbar machen.',
        'Sonst würde die Software vervielfältigt statt weitergegeben.',
      ),
      nein(
        'Ein SaaS-Abonnement darf an einen Dritten weiterverkauft werden, weil sich das Recht erschöpft hat.',
        'Bei Miete und Abo wird keine Kopie verkauft, also gibt es nichts, was sich erschöpfen könnte.',
      ),
      nein(
        'Wer eine gebrauchte Lizenz kauft, wird Urheber des Programms.',
        'Er erwirbt nur ein Nutzungsrecht. Urheber bleibt der Entwickler.',
      ),
    ],
    explanation:
        'Erschöpfung: Ist eine Kopie einmal mit Zustimmung in der EU verkauft, kann der Rechteinhaber ihren Weiterverkauf nicht verbieten. Voraussetzung ist eine Dauerlizenz gegen Einmalzahlung und dass der Verkäufer seine Kopie unbrauchbar macht. Für Miete und Abos gilt das nicht.',
    difficulty: 3,
  ),
  einfach(
    'a7-vu-6',
    'vt-urheber',
    scenario:
        'Ein Start-up hat eine App entwickelt, mit der Kunden per Chatbot Termine buchen. Ein Konkurrent bringt eine App mit derselben Idee heraus; den Code hat er komplett selbst geschrieben.',
    prompt: 'Kann das Start-up urheberrechtlich dagegen vorgehen?',
    choices: [
      ja(
        'Nein, Ideen und Grundsätze sind nicht geschützt, nur ihre konkrete Umsetzung im Code.',
        '§ 69a Abs. 2 UrhG: Ideen und Grundsätze, auch von Schnittstellen, sind frei.',
      ),
      nein(
        'Ja, weil das Start-up die Idee zuerst hatte.',
        'Zeitlicher Vorrang schützt keine Idee.',
      ),
      nein(
        'Ja, das Urheberrecht schützt jede App mit gleicher Funktion 70 Jahre lang.',
        'Geschützt ist das konkrete Programm, nicht die Funktion.',
      ),
      nein(
        'Ja, sobald das Start-up die App beim Patentamt anmeldet, gilt das Urheberrecht rückwirkend.',
        'Das Urheberrecht hat mit dem Patentamt nichts zu tun, und Software als solche ist nicht patentierbar.',
      ),
    ],
    explanation:
        'Das Urheberrecht schützt Computerprogramme in ihrer konkreten Ausdrucksform: Quellcode, Maschinencode, Entwurfsmaterial. Die zugrunde liegende Idee bleibt frei. Wer Code nicht kopiert, sondern selbst schreibt, verletzt kein Urheberrecht.',
    difficulty: 2,
  ),

  // ================================================ Service Level Agreements
  rechnen(
    'a7-li-1',
    'sla-inhalte',
    scenario:
        'Ein SLA für ein Warenwirtschaftssystem legt die Servicezeit auf Montag bis Freitag, 8 bis 18 Uhr fest. Zugesichert sind 99 % Verfügbarkeit, bezogen auf die Servicezeit eines Monats. Der betrachtete Monat hat 22 Arbeitstage.',
    prompt:
        'Wie viele Minuten Ausfall sind innerhalb der Servicezeit in diesem Monat höchstens zulässig?',
    answer: 132,
    unit: 'Minuten',
    explanation:
        'Servicezeit = 22 Tage × 10 h = 220 h. Erlaubter Ausfall = 220 h × (100 % - 99 %) = 220 h × 0,01 = 2,2 h. 2,2 h × 60 = 132 Minuten.',
  ),
  einfach(
    'a7-li-2',
    'sla-inhalte',
    scenario:
        'Ein SLA sieht eine Servicezeit von Montag bis Freitag, 8 bis 18 Uhr vor und eine Reaktionszeit von 2 Stunden. Die Reaktionszeit zählt nur innerhalb der Servicezeit. Eine Störung wird am Freitag um 17:30 Uhr gemeldet.',
    prompt: 'Bis wann muss der Dienstleister spätestens reagieren?',
    choices: [
      ja(
        'Montag, 9:30 Uhr',
        'Am Freitag laufen 30 Minuten bis 18 Uhr, die restlichen 90 Minuten ab Montag 8 Uhr.',
      ),
      nein(
        'Freitag, 19:30 Uhr',
        'Nach 18 Uhr läuft die Uhr nicht weiter. Dann ist keine Servicezeit.',
      ),
      nein(
        'Montag, 10:00 Uhr',
        'Dabei wären die 30 Minuten vom Freitag nicht angerechnet.',
      ),
      nein('Samstag, 9:30 Uhr', 'Samstag gehört nicht zur Servicezeit.'),
    ],
    explanation:
        'Die Reaktionszeit zählt nur in der Servicezeit. Am Freitag laufen von 17:30 bis 18:00 Uhr 30 min. Der Rest von 120 min − 30 min = 90 min läuft ab Montag 8:00 Uhr, also bis Montag 9:30 Uhr.',
  ),

  rechnen(
    'a7-li-3',
    'sla-inhalte',
    scenario:
        'Ein Cloud-Anbieter sichert für seinen Speicherdienst 99,95 % Verfügbarkeit bei 24/7-Betrieb zu, bezogen auf ein Jahr mit 365 Tagen.',
    prompt: 'Wie viele Minuten Ausfall sind pro Jahr höchstens erlaubt?',
    answer: 262.8,
    tolerance: 0.1,
    unit: 'Minuten',
    explanation:
        'Servicezeit = 365 × 24 h = 8.760 h. Erlaubter Anteil = 100 % − 99,95 % = 0,05 % = 0,0005. Erlaubter Ausfall = 8.760 h × 0,0005 = 4,38 h. In Minuten: 4,38 × 60 = 262,8 Minuten.',
    difficulty: 2,
  ),
  rechnen(
    'a7-li-4',
    'sla-inhalte',
    scenario:
        'Ein Storage-System war im Quartal für 2.160 Stunden Betrieb vorgesehen (24/7). Es fiel 4-mal aus, insgesamt 8 Stunden lang.',
    prompt: 'Wie hoch ist die MTBF (Mean Time Between Failures) in Stunden?',
    answer: 538,
    unit: 'h',
    explanation:
        'Betriebszeit ohne Ausfall = 2.160 h − 8 h = 2.152 h. MTBF = Betriebszeit / Anzahl Ausfälle = 2.152 h / 4 = 538 h. Zum Vergleich: MTTR = 8 h / 4 = 2 h.',
    difficulty: 2,
  ),
  rechnen(
    'a7-li-5',
    'sla-inhalte',
    prompt:
        'Ein Server hat eine MTBF von 495 Stunden und eine MTTR von 5 Stunden. Wie hoch ist seine Verfügbarkeit in Prozent?',
    answer: 99,
    unit: '%',
    explanation:
        'V = MTBF / (MTBF + MTTR) × 100 % = 495 / (495 + 5) × 100 % = 495 / 500 × 100 % = 0,99 × 100 % = 99 %.',
    difficulty: 2,
  ),
  einfach(
    'a7-li-6',
    'sla-inhalte',
    scenario:
        'Ein SLA mit 24/7-Servicezeit legt für Priorität 1 fest: Reaktionszeit 1 Stunde, Lösungszeit 4 Stunden. Eine Störung wird um 9:00 Uhr gemeldet. Um 9:40 Uhr ruft ein Techniker zurück und beginnt mit der Analyse; um 14:30 Uhr ist der Fehler behoben.',
    prompt: 'Wie ist die Einhaltung des SLA zu bewerten?',
    choices: [
      ja(
        'Reaktionszeit eingehalten, Lösungszeit überschritten',
        'Reaktion nach 40 min (erlaubt bis 10:00 Uhr), Lösung erst nach 5,5 h (erlaubt bis 13:00 Uhr).',
      ),
      nein(
        'Reaktions- und Lösungszeit eingehalten',
        'Die Lösung hätte bis 13:00 Uhr erfolgen müssen.',
      ),
      nein(
        'Reaktionszeit überschritten, Lösungszeit eingehalten',
        'Die Rückmeldung um 9:40 Uhr lag innerhalb der Stunde.',
      ),
      nein(
        'Beide Zeiten überschritten',
        'Die Reaktionszeit wurde eingehalten.',
      ),
    ],
    explanation:
        'Beide Zeiten beginnen mit der Meldung um 9:00 Uhr. Reaktionszeit bis 10:00 Uhr: Rückruf um 9:40 Uhr, eingehalten. Lösungszeit bis 13:00 Uhr: behoben um 14:30 Uhr, um 1,5 h überschritten.',
    difficulty: 1,
  ),
  rechnen(
    'a7-li-7',
    'sla-inhalte',
    scenario:
        'Die monatliche Servicegebühr beträgt 3.000 €. Vereinbart sind 99,8 % Verfügbarkeit. Für jeden angefangenen 0,1-Prozentpunkt darunter erhält der Kunde 4 % Gutschrift, höchstens 20 %. Gemessen wurden 99,55 %.',
    prompt: 'Wie hoch ist die Gutschrift in Euro?',
    answer: 360,
    unit: '€',
    explanation:
        'Unterschreitung = 99,8 % − 99,55 % = 0,25 Prozentpunkte. Angefangene 0,1-Schritte: 0,1 + 0,1 + angefangene 0,05 = 3 Schritte. Gutschrift = 3 × 4 % = 12 % (unter der Grenze von 20 %). 3.000 € × 0,12 = 360 €.',
    difficulty: 3,
  ),
  zuordnen(
    'a7-li-8',
    'sla-inhalte',
    scenario: 'Ein IT-Dienstleister betreibt den Webshop eines Kunden.',
    prompt: 'Um welche Art von Vereinbarung handelt es sich jeweils?',
    buckets: ['SLA', 'OLA', 'UC'],
    items: [
      zu(
        'Der Hardware-Hersteller tauscht defekte Serverteile innerhalb von 4 Stunden.',
        2,
        'Vertrag mit einem externen Lieferanten.',
      ),
      zu(
        'Das interne Netzwerkteam sagt dem Service Desk zu, P1-Tickets in 15 Minuten zu übernehmen.',
        1,
        'Interne Vereinbarung zwischen Teams.',
      ),
      zu(
        'Die Datenbank-Admins sagen dem Betriebsteam zu, Backups täglich bis 6 Uhr abzuschließen.',
        1,
        'Interne Vereinbarung zwischen zwei Teams des Dienstleisters.',
      ),
      zu(
        'Der Internetprovider garantiert dem Dienstleister 99,95 % Verfügbarkeit der Anbindung.',
        2,
        'Vertrag mit einem externen Zulieferer.',
      ),
      zu(
        'Der Kunde erhält monatlich einen Bericht über die erreichten Reaktionszeiten.',
        0,
        'Reporting an den Kunden ist Teil des SLA.',
      ),
      zu(
        'Der Dienstleister sichert dem Kunden 99,9 % Verfügbarkeit des Webshops zu.',
        0,
        'Vereinbarung mit dem Kunden.',
      ),
    ],
    explanation:
        'Ein SLA schließt der Dienstleister mit dem Kunden. Ein OLA gilt zwischen internen Einheiten des Dienstleisters, ein UC (Underpinning Contract) zwischen Dienstleister und externem Lieferanten. OLA und UC müssen strengere Werte haben als das SLA, damit es gehalten werden kann.',
    difficulty: 2,
  ),

  // ============================================ Support-Level und Eskalation
  rechnen(
    'a7-ls-1',
    'sla-support',
    prompt:
        'Der Service Desk hat im Quartal 1.500 Tickets erfasst. 1.020 davon wurden im 1st Level gelöst, ohne weitergegeben zu werden. Wie hoch ist die First Level Resolution Rate?',
    answer: 68,
    unit: '%',
    explanation:
        'FLRR = im 1st Level gelöste Tickets / alle Tickets × 100 % = 1.020 / 1.500 × 100 % = 0,68 × 100 % = 68 %.',
  ),
  zuordnen(
    'a7-ls-2',
    'sla-support',
    prompt:
        'Handelt es sich um eine funktionale oder eine hierarchische Eskalation?',
    buckets: ['funktionale Eskalation', 'hierarchische Eskalation'],
    items: [
      zu(
        'Der 1st Level gibt ein Datenbankproblem an den Datenbankspezialisten im 2nd Level.',
        0,
        'Weitergabe an mehr Fachwissen.',
      ),
      zu(
        'Die Teamleitung wird informiert, weil die Lösungszeit für ein Ticket der Priorität 1 überschritten zu werden droht.',
        1,
        'Die Führungsebene wird eingeschaltet.',
      ),
      zu(
        'Der 2nd Level meldet einen reproduzierbaren Programmfehler an den Hersteller.',
        0,
        'Der Hersteller ist der 3rd Level mit mehr Fachwissen zum Produkt.',
      ),
      zu(
        'Die IT-Leitung stellt für einen Großausfall zusätzliche Techniker ab.',
        1,
        'Entscheidung über Ressourcen durch die Führung.',
      ),
    ],
    explanation:
        'Funktional heißt: an ein höheres Support-Level mit mehr Fachwissen. Hierarchisch heißt: an die Führungsebene, die entscheiden und Ressourcen bereitstellen kann.',
  ),
  einfach(
    'a7-ls-3',
    'sla-support',
    prompt:
        'Welches Ticket erhält nach der Prioritätsmatrix (Auswirkung × Dringlichkeit) die höchste Priorität?',
    choices: [
      ja(
        'Der Webshop ist während der Geschäftszeit für alle Kunden nicht erreichbar.',
        'Viele Betroffene (hohe Auswirkung) und jede Minute kostet Umsatz (hohe Dringlichkeit).',
      ),
      nein(
        'Ein Mitarbeiter wünscht sich ein anderes Hintergrundbild.',
        'Geringe Auswirkung, keine Dringlichkeit, zudem keine Störung.',
      ),
      nein(
        'Die Druckfunktion eines Arbeitsplatzes fällt aus, ein funktionierender Drucker steht im Nebenraum.',
        'Ein Nutzer betroffen, und es gibt eine Ausweichmöglichkeit.',
      ),
      nein(
        'Für nächsten Monat soll ein Konto für eine neue Auszubildende angelegt werden.',
        'Eine planbare Standardanfrage ohne Eile.',
      ),
    ],
    explanation:
        'Priorität ergibt sich aus Auswirkung (wie viele sind betroffen) und Dringlichkeit (wie schnell muss es gehen). Nur der Webshop-Ausfall ist in beiden Dimensionen hoch.',
  ),

  einfach(
    'a7-ls-4',
    'sla-support',
    scenario:
        'Die Prioritätsmatrix eines Service Desks kombiniert Auswirkung (hoch, mittel, niedrig) und Dringlichkeit (hoch, mittel, niedrig) zu P1 bis P5: hoch/hoch = P1, mittel/mittel = P3, niedrig/niedrig = P5. Der Drucker einer Abteilung mit 15 Personen fällt aus. Im Nachbarflur steht ein Ausweichdrucker, die Druckaufträge sind nicht zeitkritisch.',
    prompt: 'Welche Priorität bekommt das Ticket?',
    choices: [
      ja(
        'P4',
        'Eine Abteilung ist betroffen (Auswirkung mittel), es gibt eine Ausweichmöglichkeit und keine Eile (Dringlichkeit niedrig). Mittel × niedrig ergibt P4.',
      ),
      nein(
        'P2',
        'P2 wäre hoch × mittel oder mittel × hoch; dafür fehlt die Dringlichkeit.',
      ),
      nein(
        'P3',
        'P3 wäre mittel × mittel. Durch den Ausweichdrucker ist die Dringlichkeit aber niedrig.',
      ),
      nein(
        'P5',
        'P5 wäre niedrig × niedrig. Mit 15 Personen ist mehr als ein Einzelner betroffen.',
      ),
    ],
    explanation:
        'In der 3×3-Matrix steigt die Nummer mit jeder Stufe, die Auswirkung oder Dringlichkeit niedriger ist: hoch/hoch P1, mittel/mittel P3, mittel/niedrig P4, niedrig/niedrig P5. Hier ist die Auswirkung mittel und die Dringlichkeit niedrig, das ergibt P4.',
    difficulty: 2,
  ),
  reihenfolge(
    'a7-ls-5',
    'sla-support',
    scenario:
        'Eine Anwenderin ruft beim Service Desk an: Ihr ERP-Client meldet beim Start einen Datenbankfehler.',
    prompt: 'Bringe die Bearbeitung des Tickets in die richtige Reihenfolge.',
    items: [
      'Anruf entgegennehmen und Ticket anlegen',
      'Kategorie und Priorität festlegen',
      'Bekannte Standardlösungen prüfen, ohne Erfolg',
      'Funktionale Eskalation an den 2nd Level mit dokumentiertem Ticket',
      'Lösung umsetzen und im Ticket dokumentieren',
      'Lösung von der Anwenderin bestätigen lassen und Ticket schließen',
    ],
    explanation:
        'Der 1st Level erfasst, kategorisiert und priorisiert das Ticket. Kann er die Störung nicht lösen, eskaliert er funktional. Das Ticket bleibt offen und behält seine Historie. Geschlossen wird erst nach bestätigter Lösung.',
    difficulty: 1,
  ),
  zuordnen(
    'a7-ls-6',
    'sla-support',
    prompt: 'Welches Support-Level ist jeweils zuständig?',
    buckets: ['Level 0', '1st Level', '2nd Level', '3rd Level'],
    items: [
      zu(
        'Der Softwarehersteller behebt einen Programmfehler mit einem Patch.',
        3,
        'Änderung am Produkt selbst.',
      ),
      zu(
        'Der Service Desk löst ein bekanntes Druckerproblem per Anleitung am Telefon.',
        1,
        'Standardfall mit bekannter Lösung.',
      ),
      zu(
        'Ein Netzwerkadministrator untersucht Paketverluste zwischen zwei Standorten.',
        2,
        'Spezialwissen im eigenen Haus.',
      ),
      zu(
        'Ein Anwender setzt sein Passwort im Self-Service-Portal selbst zurück.',
        0,
        'Selbsthilfe ohne Service Desk.',
      ),
      zu(
        'Ein Mitarbeiter findet in der FAQ, wie er das VPN einrichtet.',
        0,
        'Wissensdatenbank für Anwender.',
      ),
      zu(
        'Ein Datenbankspezialist analysiert langsame Abfragen im ERP-System.',
        2,
        'Tiefes Fachwissen nötig.',
      ),
    ],
    explanation:
        'Level 0 ist der Self-Service. Im 1st Level arbeitet der Service Desk mit Standardlösungen, im 2nd Level sitzen interne Fachspezialisten. Der 3rd Level ist der Hersteller oder die Entwicklung und kommt ins Spiel, wenn das Produkt selbst geändert werden muss.',
    difficulty: 1,
  ),
  rechnen(
    'a7-ls-7',
    'sla-support',
    prompt:
        'Von 640 Tickets eines Monats wurden 592 innerhalb der vereinbarten Lösungszeit gelöst. Wie hoch ist die SLA-Erfüllungsquote in Prozent?',
    answer: 92.5,
    tolerance: 0.05,
    unit: '%',
    explanation:
        'SLA-Quote = fristgerecht gelöste Tickets / alle Tickets × 100 % = 592 / 640 × 100 % = 0,925 × 100 % = 92,5 %.',
    difficulty: 1,
  ),
  paare(
    'a7-ls-8',
    'sla-support',
    prompt: 'Verbinde jede Supportform mit ihrem Kennzeichen.',
    paare: [
      paar('Self-Service-Portal', 'entlastet den 1st Level bei Standardfällen'),
      paar('Remote-Support', 'spart Anfahrt, braucht Zustimmung'),
      paar('Vor-Ort-Support', 'nötig, wenn Hardware getauscht wird'),
      paar('Follow the Sun', '24/7 durch Teams in mehreren Zeitzonen'),
      paar('Telefon-Hotline', 'schnelle persönliche Klärung'),
    ],
    explanation:
        'Die Supportkanäle haben verschiedene Stärken: Self-Service für Standardfälle, Telefon und Chat für schnelle Hilfe, Remote für Softwareprobleme (nur mit Zustimmung des Anwenders), Vor-Ort für Hardware. Follow the Sun heißt, dass Teams in mehreren Zeitzonen Tickets übergeben. So entsteht Support rund um die Uhr.',
    difficulty: 2,
  ),

  // ============================================= Incident, Problem, Change
  zuordnen(
    'a7-lt-1',
    'sla-itil',
    prompt: 'Ordne jeden Vorgang dem passenden ITIL-Begriff zu.',
    buckets: ['Incident', 'Problem', 'Change', 'Service Request'],
    items: [
      zu(
        'Der Mailserver ist ausgefallen, niemand kann E-Mails senden.',
        0,
        'Eine akute Störung, die schnell behoben werden muss.',
      ),
      zu(
        'Der Mailserver fällt seit Wochen jeden Montag aus, die Ursache soll gefunden werden.',
        1,
        'Ursachenforschung für wiederkehrende Störungen.',
      ),
      zu(
        'Die Firewall soll eine neue Regel für den Webshop erhalten.',
        2,
        'Eine geplante Änderung an der Infrastruktur.',
      ),
      zu(
        'Eine neue Mitarbeiterin benötigt ein Benutzerkonto.',
        3,
        'Standardanfrage, nichts ist kaputt.',
      ),
      zu(
        'Ein Anwender hat sein Passwort vergessen und braucht ein neues.',
        3,
        'Klassischer Service Request.',
      ),
      zu(
        'Die Buchhaltungssoftware startet bei einer Nutzerin nicht mehr.',
        0,
        'Ein Service funktioniert nicht wie vorgesehen.',
      ),
    ],
    explanation:
        'Ein Incident ist eine Störung, bei der der Service schnell wiederhergestellt werden muss. Beim Problem geht es um die Ursache, beim Change um eine kontrollierte Änderung. Ein Service Request ist eine Standardanfrage ohne Störung.',
  ),
  paare(
    'a7-lt-2',
    'sla-itil',
    prompt: 'Verbinde jeden ITIL-Begriff mit seiner Bedeutung.',
    paare: [
      paar('Incident', 'Störung: Service schnell wiederherstellen'),
      paar('Problem', 'Ursache hinter Störungen'),
      paar('Known Error', 'Problem mit bekannter, dokumentierter Ursache'),
      paar('Workaround', 'vorläufige Umgehung ohne Ursachenbehebung'),
      paar('Standard Change', 'häufig, risikoarm, vorab genehmigt'),
      paar('Emergency Change', 'dringend, beschleunigt genehmigt'),
    ],
    explanation:
        'Incident Management stellt wieder her, Problem Management beseitigt Ursachen, Change Management steuert Änderungen je nach Risiko als Standard, Normal oder Emergency Change. Auch ein Emergency Change wird genehmigt und dokumentiert, nur schneller.',
  ),
  reihenfolge(
    'a7-lt-3',
    'sla-itil',
    scenario: 'Die Scanner-App im Lager stürzt mehrmals täglich ab.',
    prompt: 'Bringe die Schritte in die richtige Reihenfolge.',
    items: [
      'Anwender melden den Absturz, der Service Desk stellt den Betrieb per Neustart wieder her',
      'Wegen gehäufter gleichartiger Störungen wird ein Problem eröffnet',
      'Die Ursache wird gefunden und als Known Error mit Workaround dokumentiert',
      'Die dauerhafte Lösung wird als Change bewertet und genehmigt',
      'Der Change wird umgesetzt und das Problem geschlossen',
    ],
    explanation:
        'Erst wird der Betrieb wiederhergestellt (Incident), dann die Ursache gesucht (Problem, Known Error), zuletzt die dauerhafte Lösung kontrolliert eingeführt (Change).',
  ),

  einfach(
    'a7-lt-4',
    'sla-itil',
    prompt: 'Was ist nach ITIL ein Workaround?',
    choices: [
      ja(
        'Eine vorübergehende Umgehung, die den Service wiederherstellt, ohne die Ursache zu beseitigen',
        'Beispiel: App neu starten, bis ein Patch das Speicherleck behebt.',
      ),
      nein(
        'Die dauerhafte Beseitigung der Ursache eines Problems',
        'Das ist die eigentliche Lösung, meist umgesetzt als Change.',
      ),
      nein(
        'Ein vorab genehmigter Standard Change',
        'Ein Standard Change ist eine risikoarme, wiederkehrende Änderung.',
      ),
      nein(
        'Eine Standardanfrage eines Anwenders',
        'Das ist ein Service Request.',
      ),
    ],
    explanation:
        'Ein Workaround reduziert oder beseitigt die Auswirkung eines Incidents oder Problems, ohne die Ursache zu beheben. Er wird zusammen mit dem Known Error dokumentiert, damit der Service Desk ihn bei weiteren Meldungen sofort anwenden kann.',
    difficulty: 1,
  ),
  zuordnen(
    'a7-lt-5',
    'sla-itil',
    prompt: 'Um welche Art von Change handelt es sich?',
    buckets: ['Standard Change', 'Normal Change', 'Emergency Change'],
    items: [
      zu(
        'Sofort einen Sicherheitspatch für eine aktiv ausgenutzte Lücke einspielen',
        2,
        'Muss sofort passieren, also beschleunigte Genehmigung.',
      ),
      zu(
        'Ein Standard-Notebook für eine neue Mitarbeiterin nach Checkliste einrichten',
        0,
        'Häufig, risikoarm, vorab genehmigt.',
      ),
      zu(
        'Eine neue Firewall-Architektur einführen',
        1,
        'Größere geplante Änderung mit Bewertung.',
      ),
      zu(
        'Das ERP-System auf einen neuen Datenbankserver migrieren',
        1,
        'Geplant, aber riskant. Sie muss einzeln bewertet und genehmigt werden.',
      ),
      zu(
        'Die monatlich freigegebenen Updates der Virenschutz-Signaturen einspielen',
        0,
        'Wiederkehrend und vorab freigegeben.',
      ),
    ],
    explanation:
        'Standard Change: häufig, geringes Risiko, vorab genehmigt. Normal Change: geplant, wird bewertet und von der Change Authority (oft dem CAB) genehmigt. Emergency Change: dringend, beschleunigt genehmigt, trotzdem dokumentiert.',
    difficulty: 2,
  ),
  mehrfach(
    'a7-lt-6',
    'sla-itil',
    prompt: 'Welche Aussagen zu ITIL 4 sind richtig?',
    choices: [
      ja(
        'Die Service Value Chain besteht aus sechs Aktivitäten, darunter Engage und Deliver & Support.',
        'Dazu kommen Plan, Improve, Design & Transition und Obtain/Build.',
      ),
      ja(
        'ITIL 4 beschreibt vier Dimensionen des Service-Managements.',
        'Organisationen und Personen, Informationen und Technologie, Partner und Lieferanten, Wertströme und Prozesse.',
      ),
      ja(
        '„Fokus auf Wert“ ist eines der sieben Leitprinzipien.',
        'Es steht an erster Stelle der Leitprinzipien.',
      ),
      nein(
        'ITIL ist ein Gesetz, das alle IT-Dienstleister in der EU einhalten müssen.',
        'ITIL ist eine freiwillige Best-Practice-Sammlung.',
      ),
      nein(
        'ITIL 4 schreibt eine bestimmte Ticket-Software vor.',
        'ITIL ist herstellerneutral und beschreibt keine konkrete Software.',
      ),
    ],
    explanation:
        'ITIL 4 besteht aus dem Service Value System mit Leitprinzipien, Governance, Service Value Chain, Praktiken und kontinuierlicher Verbesserung sowie den vier Dimensionen. Es ist ein anpassbarer Leitfaden, weder Gesetz noch Produkt.',
    difficulty: 2,
  ),
  einfach(
    'a7-lt-7',
    'sla-itil',
    scenario:
        'Das Monitoring meldet, dass die Festplatte eines Dateiservers zu 80 % gefüllt ist. Der Server läuft normal, niemand ist beeinträchtigt.',
    prompt: 'Wie ist die Meldung nach ITIL einzuordnen?',
    choices: [
      ja(
        'Als Event, also eine bedeutsame Zustandsänderung, aber noch keine Störung',
        'Der Service ist nicht unterbrochen oder beeinträchtigt, also liegt kein Incident vor.',
      ),
      nein(
        'Als Incident der Priorität 1',
        'Ein Incident setzt eine Unterbrechung oder Qualitätsminderung voraus, und die gibt es hier nicht.',
      ),
      nein(
        'Als Problem, weil die Ursache unbekannt ist',
        'Ein Problem ist die Ursache von Incidents. Hier gibt es noch keinen Incident.',
      ),
      nein(
        'Als Emergency Change',
        'Es ist keine Änderung, sondern eine Meldung des Monitorings.',
      ),
    ],
    explanation:
        'Events sind Zustandsänderungen, die für das Management eines Service bedeutsam sind. Aus einem Event kann eine Aktion folgen, etwa Speicher erweitern. Erst wenn die Platte vollläuft und der Service gestört ist, entsteht ein Incident.',
    difficulty: 2,
  ),

  // ================================================================== Verzug
  rechnen(
    'a7-gv-1',
    'ls-verzug',
    scenario:
        'Ein Systemhaus hat einem Handwerksbetrieb eine Rechnung über 8.000 € gestellt. Beide sind Unternehmen, kein Verbraucher ist beteiligt. Der Betrieb ist 146 Tage im Zahlungsverzug. Der Basiszinssatz beträgt in dieser Aufgabe 1,5 %.',
    prompt:
        'Wie hoch sind die Verzugszinsen ohne die Pauschale? (Zins = Betrag × Satz × Tage / 365, auf Cent runden)',
    answer: 336,
    tolerance: 0.01,
    unit: '€',
    explanation:
        'Zinssatz unter Unternehmen = 1,5 % + 9 Prozentpunkte = 10,5 %. Zins = 8.000 € × 0,105 × 146 / 365 = 840 € × 0,4 = 336,00 €. Die 40 € Pauschale kommen gesondert hinzu.',
  ),
  einfach(
    'a7-gv-2',
    'ls-verzug',
    scenario:
        'Ein Händler sollte am 15. März 20 Notebooks liefern. Der Termin ist verstrichen, es handelt sich nicht um ein Fixgeschäft, und der Händler hat die Lieferung nicht verweigert. Der Käufer möchte die Geräte nun woanders kaufen.',
    prompt:
        'Was muss der Käufer grundsätzlich tun, bevor er vom Vertrag zurücktreten kann?',
    choices: [
      ja(
        'Dem Händler eine angemessene Nachfrist zur Lieferung setzen',
        'Erst wenn die Nachfrist erfolglos verstreicht, ist der Rücktritt möglich.',
      ),
      nein(
        'Sofort zurücktreten, weil der Termin verstrichen ist',
        'Ohne Nachfrist geht das nur in Ausnahmefällen, etwa beim Fixgeschäft.',
      ),
      nein(
        'Den Händler dreimal schriftlich mahnen',
        'Drei Mahnungen sind ein Mythos. Für den Rücktritt kommt es auf die Nachfrist an.',
      ),
      nein(
        '30 Tage abwarten',
        'Die 30-Tage-Regel betrifft den Zahlungsverzug, nicht die Lieferung.',
      ),
    ],
    explanation:
        'Beim Lieferungsverzug kann der Käufer zunächst Lieferung und Ersatz des Verzugsschadens verlangen. Rücktritt und Schadensersatz statt der Leistung setzen grundsätzlich eine erfolglos verstrichene angemessene Nachfrist voraus.',
  ),
  tabelle(
    'a7-gv-3',
    'ls-verzug',
    scenario: 'Drei Schuldner sind mit einer Rechnung im Zahlungsverzug.',
    prompt:
        'Gib für jeden Fall den gesetzlichen Aufschlag auf den Basiszinssatz an und ob die Pauschale von 40 € verlangt werden kann.',
    zeilen: [
      ['Fall', 'Aufschlag', '40-€-Pauschale'],
      [
        'Ein Handwerksbetrieb zahlt die Rechnung eines Systemhauses nicht.',
        wahl('9 Prozentpunkte', [
          '5 Prozentpunkte',
          '12 Prozentpunkte',
        ], 'Kein Verbraucher beteiligt (§ 288 Abs. 2 BGB).'),
        wahl('ja', [
          'nein',
          'nur nach der dritten Mahnung',
        ], 'Der Schuldner ist kein Verbraucher (§ 288 Abs. 5 BGB).'),
      ],
      [
        'Eine Privatkundin zahlt die Rechnung eines Computerladens nicht.',
        wahl('5 Prozentpunkte', [
          '9 Prozentpunkte',
          '12 Prozentpunkte',
        ], 'Ein Verbraucher ist beteiligt (§ 288 Abs. 1 BGB).'),
        wahl('nein', [
          'ja',
          'nur nach der dritten Mahnung',
        ], 'Gegenüber Verbrauchern gibt es keine Pauschale.'),
      ],
      [
        'Eine Stadtverwaltung zahlt die Rechnung eines Softwarehauses nicht.',
        wahl(
          '9 Prozentpunkte',
          ['5 Prozentpunkte', '12 Prozentpunkte'],
          'Auch ein öffentlicher Auftraggeber ist kein Verbraucher.',
        ),
        wahl('ja', [
          'nein',
          'nur nach der dritten Mahnung',
        ], 'Der Schuldner ist kein Verbraucher.'),
      ],
    ],
    explanation:
        'Verzugszins: 5 Prozentpunkte über Basiszins, wenn ein Verbraucher beteiligt ist, 9 Prozentpunkte, wenn kein Verbraucher beteiligt ist. Die Pauschale von 40 € gibt es nur, wenn der Schuldner kein Verbraucher ist. Drei Mahnungen verlangt das Gesetz nirgends.',
    punkte: 3,
  ),

  zuordnen(
    'a7-gv-4',
    'ls-verzug',
    scenario:
        'Ein Lieferant ist mit der Lieferung von Netzwerkkomponenten in Verzug. Er hat die Verspätung verschuldet.',
    prompt:
        'Welche Rechte hat der Käufer sofort, welche erst nach einer erfolglosen Nachfrist?',
    buckets: ['sofort (ohne Nachfrist)', 'erst nach erfolgloser Nachfrist'],
    items: [
      zu(
        'Auf der Lieferung bestehen',
        0,
        'Der Erfüllungsanspruch besteht ohnehin.',
      ),
      zu(
        'Schadensersatz statt der Leistung, z. B. Mehrkosten eines Deckungskaufs',
        1,
        '§ 281 BGB verlangt ebenfalls eine erfolglose Nachfrist.',
      ),
      zu(
        'Vom Vertrag zurücktreten',
        1,
        '§ 323 BGB verlangt grundsätzlich eine erfolglose Nachfrist.',
      ),
      zu(
        'Ersatz des Verzögerungsschadens, z. B. Kosten für Leihgeräte',
        0,
        'Setzt Verzug und Verschulden voraus, aber keine Nachfrist.',
      ),
    ],
    explanation:
        'Ohne Nachfrist bleibt der Vertrag bestehen: Der Käufer kann Lieferung und Ersatz des Verzögerungsschadens verlangen. Erst nach erfolgloser Nachfrist kann er sich vom Vertrag lösen, durch Rücktritt und/oder Schadensersatz statt der Leistung.',
    difficulty: 2,
  ),
  rechnen(
    'a7-gv-5',
    'ls-verzug',
    scenario:
        'Vereinbart war die Lieferung von 15 Monitoren zu je 210 €. Der Lieferer liefert schuldhaft nicht, auch eine angemessene Nachfrist verstreicht. Der Käufer kauft die Monitore bei einem anderen Händler zu je 238 €.',
    prompt:
        'Wie hoch ist der Schadensersatz statt der Leistung (Mehrkosten des Deckungskaufs)?',
    answer: 420,
    unit: '€',
    explanation:
        'Mehrkosten je Monitor = 238 € − 210 € = 28 €. Schaden = 15 × 28 € = 420 €. Voraussetzungen: Fälligkeit, erfolglose Nachfrist und Verschulden des Lieferers (§ 281 BGB).',
    difficulty: 1,
  ),
  rechnen(
    'a7-gv-6',
    'ls-verzug',
    scenario:
        'Ein Privatkunde zahlt die Rechnung eines Computerladens über 2.920 € 60 Tage zu spät. Nimm für diese Aufgabe einen Basiszinssatz von 1,5 % an.',
    prompt:
        'Wie hoch sind die Verzugszinsen? (Zins = Betrag × Satz × Tage / 365, auf Cent runden)',
    answer: 31.2,
    tolerance: 0.01,
    unit: '€',
    explanation:
        'Weil ein Verbraucher beteiligt ist, gilt: 1,5 % + 5 Prozentpunkte = 6,5 %. Zins = 2.920 € × 0,065 × 60 / 365 = 189,80 € × 60 / 365 = 11.388 € / 365 = 31,20 €. Eine 40-€-Pauschale gibt es gegenüber Verbrauchern nicht.',
    difficulty: 2,
  ),
  einfach(
    'a7-gv-7',
    'ls-verzug',
    scenario:
        'Ein Systemhaus schickt einem Maschinenbauunternehmen eine sofort fällige Rechnung, die am 1. Juni zugeht. Im Vertrag ist kein Zahlungstermin vereinbart, und das Systemhaus mahnt nicht.',
    prompt: 'Ab wann ist das Unternehmen spätestens im Zahlungsverzug?',
    choices: [
      ja(
        'Ab dem 2. Juli',
        'Die 30-Tage-Frist läuft vom 2. Juni bis zum 1. Juli. Ab dem 2. Juli ist das Unternehmen in Verzug.',
      ),
      nein(
        'Ab dem 2. Juni',
        'Ohne Mahnung oder vereinbarten Termin tritt Verzug nicht schon am Tag nach Zugang ein.',
      ),
      nein('Ab dem 1. August', 'Die Frist beträgt 30 Tage, nicht zwei Monate.'),
      nein(
        'Gar nicht, solange nicht gemahnt wurde',
        'Für Entgeltforderungen gilt die 30-Tage-Regel auch ohne Mahnung (§ 286 Abs. 3 BGB).',
      ),
    ],
    explanation:
        'Nach § 286 Abs. 3 BGB kommt der Schuldner einer Entgeltforderung spätestens in Verzug, wenn er nicht innerhalb von 30 Tagen nach Fälligkeit und Zugang der Rechnung zahlt. Da ein Unternehmen zahlt, ist kein Hinweis in der Rechnung nötig. Die Rechnung geht am 1. Juni zu, die Frist endet am 1. Juli, der Verzug beginnt am 2. Juli.',
    difficulty: 2,
  ),
  einfach(
    'a7-gv-8',
    'ls-verzug',
    scenario:
        'Ein Händler bringt am vereinbarten Tag einen Server zum Kunden. Der Kunde verweigert grundlos die Annahme. Auf dem Rücktransport wird der Server durch eine leichte Unachtsamkeit des Fahrers beschädigt.',
    prompt: 'Wie ist die Rechtslage?',
    choices: [
      ja(
        'Der Kunde ist im Annahmeverzug; der Händler haftet nur noch für Vorsatz und grobe Fahrlässigkeit, also nicht für diesen Schaden.',
        '§ 300 Abs. 1 BGB mildert die Haftung des Verkäufers während des Annahmeverzugs.',
      ),
      nein(
        'Der Händler ist im Lieferungsverzug.',
        'Er hat pünktlich und ordnungsgemäß angeboten; die Störung liegt beim Kunden.',
      ),
      nein(
        'Der Händler haftet voll, weil ihm der Server noch gehört.',
        'Während des Annahmeverzugs haftet er für leichte Fahrlässigkeit gerade nicht.',
      ),
      nein(
        'Annahmeverzug liegt nur vor, wenn der Kunde die Verweigerung verschuldet hat.',
        'Annahmeverzug setzt kein Verschulden voraus.',
      ),
    ],
    explanation:
        'Annahmeverzug (§§ 293 ff. BGB): Der Gläubiger nimmt die ordnungsgemäß angebotene Leistung nicht an. Verschulden ist nicht nötig. Folgen: Haftungsmilderung auf Vorsatz und grobe Fahrlässigkeit, Ersatz von Mehraufwendungen, unter Kaufleuten Selbsthilfeverkauf. Der Kunde muss trotzdem zahlen.',
    difficulty: 3,
  ),

  // ================================================ Mängel und Gewährleistung
  zuordnen(
    'a7-gm-1',
    'ls-maengel',
    prompt: 'Ordne jeden Mangel nach seiner Erkennbarkeit ein.',
    buckets: [
      'offener Mangel',
      'versteckter Mangel',
      'arglistig verschwiegener Mangel',
    ],
    items: [
      zu(
        'Ein gelieferter Monitor hat einen deutlich sichtbaren Kratzer im Display.',
        0,
        'Bei der Prüfung sofort erkennbar.',
      ),
      zu(
        'Die SSD eines neuen Servers fällt nach drei Monaten wegen eines Fertigungsfehlers aus.',
        1,
        'Der Fehler zeigt sich erst im Betrieb.',
      ),
      zu(
        'Ein Händler verkauft ein Notebook als neu, obwohl er weiß, dass es ein reparierter Rückläufer ist.',
        2,
        'Der Verkäufer kannte den Mangel und hat ihn verschwiegen.',
      ),
      zu(
        'Der Akku eines Tablets hält nach sechs Wochen nur noch 20 Minuten, weil die Zellen fehlerhaft sind.',
        1,
        'Bei Übergabe nicht erkennbar.',
      ),
    ],
    explanation:
        'Ein offener Mangel ist sofort erkennbar, ein versteckter zeigt sich erst später. Arglistig verschwiegen ist ein Mangel, den der Verkäufer kannte und bewusst nicht offengelegt hat.',
  ),
  einfach(
    'a7-gm-2',
    'ls-maengel',
    scenario:
        'Eine Privatkundin kauft bei einem Händler ein neues Notebook. Nach drei Monaten fällt die Tastatur aus. Der Mangel war schon bei Übergabe angelegt.',
    prompt: 'Was kann sie vom Händler zuerst verlangen?',
    choices: [
      ja(
        'Nacherfüllung, also nach ihrer Wahl Reparatur oder ein neues Gerät',
        'Beim Kaufvertrag hat die Nacherfüllung Vorrang, und grundsätzlich wählt der Käufer die Art.',
      ),
      nein(
        'Sofort den vollen Kaufpreis zurück',
        'Rücktritt ist nachrangig und setzt grundsätzlich eine gescheiterte Nacherfüllung voraus.',
      ),
      nein(
        'Nacherfüllung. Die Art bestimmt der Händler',
        'Beim Kauf wählt der Käufer. Beim Werkvertrag wählt dagegen der Unternehmer.',
      ),
      nein(
        'Nichts, sie muss sich an den Hersteller wenden',
        'Die Gewährleistung richtet sich gegen den Verkäufer, nicht gegen den Hersteller.',
      ),
    ],
    explanation:
        'Reihenfolge der Käuferrechte: zuerst Nacherfüllung (Nachbesserung oder Ersatzlieferung, Wahl beim Käufer). Scheitert sie, folgen Rücktritt oder Minderung, bei Verschulden zusätzlich Schadensersatz.',
  ),
  zuordnen(
    'a7-gm-3',
    'ls-maengel',
    prompt: 'Gehört das Merkmal zur Gewährleistung oder zur Garantie?',
    buckets: ['Gewährleistung', 'Garantie'],
    items: [
      zu(
        'Freiwilliges Versprechen, meist des Herstellers',
        1,
        'Niemand ist verpflichtet, eine Garantie zu geben.',
      ),
      zu(
        'Gesetzlich vorgeschrieben',
        0,
        'Die Mängelhaftung des Verkäufers folgt aus dem BGB.',
      ),
      zu(
        'Richtet sich gegen den Verkäufer',
        0,
        'Vertragspartner ist der Händler, nicht der Hersteller.',
      ),
      zu(
        'Dauer und Umfang legt der Geber selbst fest',
        1,
        'Etwa „3 Jahre auf den Akku“.',
      ),
      zu(
        'Beträgt bei neuen Sachen 2 Jahre ab Übergabe',
        0,
        '§ 438 Abs. 1 Nr. 3 BGB.',
      ),
      zu(
        'Ihr Ablauf lässt die Rechte gegen den Händler unberührt',
        1,
        'Endet die Garantie, läuft die Gewährleistung unabhängig davon weiter.',
      ),
    ],
    explanation:
        'Gewährleistung ist gesetzlich, richtet sich gegen den Verkäufer und läuft bei neuen Sachen 2 Jahre. Die Garantie ist freiwillig und kommt hinzu. Beim Handelskauf gilt außerdem die unverzügliche Rügepflicht nach § 377 HGB.',
  ),

  rechnen(
    'a7-gm-4',
    'ls-maengel',
    scenario:
        'Ein Büro kauft einen Großformatdrucker für 2.400 €. Die Nachbesserung eines Mangels scheitert zweimal. Ein Gutachter schätzt den Wert ohne Mangel auf 3.000 €, mit Mangel auf 2.250 €.',
    prompt: 'Um wie viel Euro wird der Kaufpreis gemindert?',
    answer: 600,
    unit: '€',
    explanation:
        'Geminderter Preis = Kaufpreis × Wert mit Mangel / Wert ohne Mangel = 2.400 € × 2.250 / 3.000 = 2.400 € × 0,75 = 1.800 €. Minderungsbetrag = 2.400 € − 1.800 € = 600 € (§ 441 Abs. 3 BGB). Falsch wäre 3.000 € − 2.250 € = 750 €.',
    difficulty: 2,
  ),
  zuordnen(
    'a7-gm-5',
    'ls-maengel',
    prompt: 'Ordne jeden Fall der passenden Mangelart zu.',
    buckets: [
      'Sachmangel (Beschaffenheit)',
      'Montagemangel',
      'Falsch- oder Zuweniglieferung',
      'Rechtsmangel',
    ],
    items: [
      zu(
        'Eine Office-Suite wird mit einem gefälschten Lizenzschlüssel verkauft.',
        3,
        'Der Rechteinhaber kann die Nutzung untersagen: Recht eines Dritten.',
      ),
      zu(
        'Ein Notebook hat 8 statt der vereinbarten 16 GB RAM.',
        0,
        'Die vereinbarte Beschaffenheit fehlt.',
      ),
      zu(
        'Statt Druckermodell A wird Modell B geliefert.',
        2,
        'Eine andere als die geschuldete Sache.',
      ),
      zu(
        'Der Techniker des Verkäufers baut die Netzwerkkarte falsch ein, der Server startet nicht.',
        1,
        'Unsachgemäße Montage durch den Verkäufer.',
      ),
      zu(
        'Beworben sind 10 Stunden Akkulaufzeit, tatsächlich sind es 3.',
        0,
        'Die Sache hält nicht, was die Werbung verspricht. Damit verfehlt sie die objektiven Anforderungen.',
      ),
      zu('Statt 10 Switches werden 8 geliefert.', 2, 'Zu geringe Menge.'),
    ],
    explanation:
        'Ein Sachmangel liegt vor, wenn die vereinbarte oder übliche Beschaffenheit fehlt (§ 434 BGB). Beim Montagemangel ist die Montage oder die Montageanleitung fehlerhaft. Auch Falsch- und Zuweniglieferung gelten als Sachmangel. Beim Rechtsmangel haben Dritte Rechte an der Sache (§ 435 BGB).',
    difficulty: 2,
  ),
  reihenfolge(
    'a7-gm-6',
    'ls-maengel',
    scenario:
        'Ein Unternehmen hat bei einem Händler zehn Dockingstationen gekauft. Bei der Eingangsprüfung stellt es fest, dass zwei davon keinen Monitor ansteuern.',
    prompt: 'Bringe das Vorgehen des Käufers in die richtige Reihenfolge.',
    items: [
      'Ware unverzüglich prüfen und den Mangel unverzüglich rügen',
      'Nacherfüllung verlangen und eine angemessene Frist setzen',
      'Zweiter Versuch der Nacherfüllung scheitert ebenfalls',
      'Rücktritt oder Minderung erklären, bei Verschulden zusätzlich Schadensersatz',
    ],
    explanation:
        'Unter Kaufleuten gilt die Rügepflicht nach § 377 HGB. Dann hat die Nacherfüllung Vorrang; nach dem zweiten erfolglosen Versuch gilt sie als fehlgeschlagen (§ 440 BGB). Erst danach kommen Rücktritt oder Minderung und, bei Verschulden, Schadensersatz.',
    difficulty: 1,
  ),
  mehrfach(
    'a7-gm-7',
    'ls-maengel',
    scenario:
        'Eine Privatperson kauft bei einem Elektronikhändler ein neues Smartphone.',
    prompt: 'Welche Aussagen sind richtig?',
    choices: [
      ja(
        'Die Gewährleistungsfrist beträgt 2 Jahre ab Übergabe.',
        '§ 438 Abs. 1 Nr. 3 BGB für neue bewegliche Sachen.',
      ),
      ja(
        'Zeigt sich ein Mangel in den ersten 12 Monaten, wird vermutet, dass er schon bei Übergabe vorlag.',
        'Beweislastumkehr beim Verbrauchsgüterkauf, § 477 BGB.',
      ),
      ja(
        'Der Händler muss sicherstellen, dass sie für einen angemessenen Zeitraum Sicherheitsupdates erhält.',
        'Aktualisierungspflicht bei Waren mit digitalen Elementen, § 475b BGB.',
      ),
      nein(
        'Der Händler kann die Gewährleistung in seinen AGB ausschließen.',
        'Beim Verbrauchsgüterkauf ist die Gewährleistung für neue Sachen zwingend.',
      ),
      nein(
        'Nach Ablauf der einjährigen Herstellergarantie hat sie keine Rechte mehr.',
        'Die gesetzliche Gewährleistung gegen den Händler läuft unabhängig davon 2 Jahre.',
      ),
    ],
    explanation:
        'Verbrauchsgüterkauf: 2 Jahre Gewährleistung, Beweislastumkehr im ersten Jahr, Update-Pflicht bei digitalen Elementen, kein Ausschluss per AGB. Eine Herstellergarantie ist freiwillig. Sie kommt hinzu und verkürzt die Gewährleistung nicht.',
    difficulty: 2,
  ),
  einfach(
    'a7-gm-8',
    'ls-maengel',
    scenario:
        'Ein neuer Monitor für 400 € hat einen kaum sichtbaren Kratzer am Standfuß. Die Nachbesserung ist zweimal gescheitert.',
    prompt: 'Welches Recht steht dem Käufer jetzt zu?',
    choices: [
      ja(
        'Minderung des Kaufpreises',
        'Minderung ist auch bei einem unerheblichen Mangel möglich (§ 441 Abs. 1 BGB).',
      ),
      nein(
        'Rücktritt vom Vertrag',
        'Bei einem unerheblichen Mangel ist der Rücktritt ausgeschlossen (§ 323 Abs. 5 BGB).',
      ),
      nein(
        'Keines, weil der Mangel geringfügig ist',
        'Auch ein kleiner Mangel ist ein Mangel, nur der Rücktritt ist ausgeschlossen.',
      ),
      nein(
        'Nur Ansprüche aus der Herstellergarantie',
        'Die gesetzliche Gewährleistung gegen den Verkäufer besteht unabhängig von einer Garantie.',
      ),
    ],
    explanation:
        'Nach gescheiterter Nacherfüllung kann der Käufer zurücktreten oder mindern. Der Rücktritt setzt aber einen nicht unerheblichen Mangel voraus. Bei einem kleinen Kratzer bleibt deshalb die Minderung: Der Preis sinkt im Verhältnis zum Wertverlust.',
    difficulty: 3,
  ),

  // =================================================== Abnahme und Protokoll
  einfach(
    'a7-ga-1',
    'ls-abnahme',
    scenario:
        'Eine Agentur hat einem Großhändler ein Kundenportal fertiggestellt. Sie fordert ihn schriftlich auf, das Portal innerhalb von 14 Tagen abzunehmen. Der Großhändler reagiert nicht und nennt keinen Mangel.',
    prompt: 'Welche Folge hat das nach Ablauf der Frist?',
    choices: [
      ja(
        'Das Werk gilt als abgenommen.',
        'Fiktive Abnahme: Frist gesetzt und nicht unter Angabe eines Mangels verweigert.',
      ),
      nein(
        'Ohne Unterschrift unter ein Protokoll gibt es keine Abnahme.',
        'Die Abnahme kann auch fingiert werden. Eine Unterschrift ist nicht zwingend.',
      ),
      nein('Der Vertrag ist aufgelöst.', 'Schweigen löst keinen Vertrag auf.'),
      nein(
        'Die Agentur muss so lange neue Fristen setzen, bis der Kunde antwortet.',
        'Das Gesetz schützt den Unternehmer gerade vor dieser Hängepartie.',
      ),
    ],
    explanation:
        'Setzt der Unternehmer nach Fertigstellung eine angemessene Frist und verweigert der Besteller die Abnahme nicht unter Angabe mindestens eines Mangels, gilt das Werk als abgenommen (§ 640 Abs. 2 BGB). Die Vergütung wird damit fällig.',
  ),
  freitext(
    'a7-ga-2',
    'ls-abnahme',
    scenario:
        'Ein Softwarehaus hat ein Kundenportal fertiggestellt. Der Auftraggeber unterschreibt das Abnahmeprotokoll.',
    prompt: 'Nenne drei Rechtsfolgen der Abnahme beim Werkvertrag.',
    kriterien: [
      krit(
        'Die Vergütung wird fällig',
        stichwoerter: ['Vergütung', 'fällig', 'Zahlung', 'Werklohn'],
      ),
      krit(
        'Die Verjährungsfrist für Mängelansprüche beginnt',
        stichwoerter: ['Verjährung', 'Gewährleistungsfrist', 'Frist beginnt'],
      ),
      krit(
        'Die Gefahr geht auf den Besteller über',
        stichwoerter: ['Gefahrübergang', 'Gefahr', 'Risiko geht über'],
      ),
      krit(
        'Die Beweislast kehrt sich um: Der Besteller muss Mängel beweisen',
        stichwoerter: ['Beweislast', 'beweisen', 'Nachweis'],
      ),
    ],
    loesung:
        'Die Vergütung wird fällig, die Verjährungsfrist für Mängelansprüche beginnt, die Gefahr geht auf den Besteller über, und die Beweislast kehrt sich um: Nach der Abnahme muss der Besteller beweisen, dass ein Mangel vorliegt.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Die Mängelrechte selbst enden mit der Abnahme nicht. Sie bestehen bis zur Verjährung weiter.',
    punkte: 3,
  ),

  einfach(
    'a7-ga-3',
    'ls-abnahme',
    scenario:
        'Eine Agentur liefert eine Bestell-App (Werkvertrag). Alle Funktionen laufen fehlerfrei, nur ein Button hat eine falsche Farbe. Der Kunde verweigert deshalb Abnahme und Zahlung.',
    prompt: 'Wie ist die Lage?',
    choices: [
      ja(
        'Die Verweigerung ist unzulässig, denn wegen unwesentlicher Mängel darf die Abnahme nicht verweigert werden.',
        '§ 640 Abs. 1 Satz 2 BGB. Der Farbfehler wird unter Vorbehalt protokolliert und nachgebessert.',
      ),
      nein(
        'Die Verweigerung ist zulässig, weil jeder Mangel die Abnahme verhindert.',
        'Nur wesentliche Mängel berechtigen zur Verweigerung.',
      ),
      nein(
        'Eine Abnahme ist gar nicht nötig, weil es ein Dienstvertrag ist.',
        'Geschuldet ist eine fertige App, also ein Erfolg: Werkvertrag mit Abnahme.',
      ),
      nein(
        'Die Agentur muss den gesamten Preis erstatten.',
        'Dafür gibt es keinerlei Grundlage, denn das Werk ist im Wesentlichen vertragsgemäß.',
      ),
    ],
    explanation:
        'Der Besteller muss ein vertragsgemäß hergestelltes Werk abnehmen und darf das wegen unwesentlicher Mängel nicht verweigern. Richtig ist die Abnahme unter Vorbehalt: Der Mangel kommt mit Frist ins Protokoll, die Rechte daran bleiben erhalten.',
    difficulty: 2,
  ),
  zuordnen(
    'a7-ga-4',
    'ls-abnahme',
    prompt: 'Um welche Art der Abnahme handelt es sich?',
    buckets: ['ausdrücklich', 'konkludent', 'fiktiv'],
    items: [
      zu(
        'Beide Seiten unterschreiben ein Abnahmeprotokoll.',
        0,
        'Förmliche Abnahme.',
      ),
      zu(
        'Der Kunde lässt eine gesetzte Abnahmefrist verstreichen, ohne einen Mangel zu nennen.',
        2,
        '§ 640 Abs. 2 BGB: Das Werk gilt als abgenommen.',
      ),
      zu(
        'Der Kunde nutzt die Software nach der Testphase monatelang produktiv und zahlt ohne Beanstandung.',
        1,
        'Billigung durch schlüssiges Verhalten.',
      ),
      zu(
        'Der Projektleiter des Kunden schreibt: „Wir nehmen das System hiermit ab.“',
        0,
        'Eine ausdrückliche Erklärung, auch per E-Mail.',
      ),
    ],
    explanation:
        'Ausdrücklich: Erklärung oder Protokoll. Konkludent: Verhalten, das die Billigung zeigt, etwa vorbehaltlose Zahlung und Nutzung nach Prüfzeit. Fiktiv: Frist nach Fertigstellung verstreicht, ohne dass der Besteller unter Angabe eines Mangels verweigert.',
    difficulty: 2,
  ),
  reihenfolge(
    'a7-ga-5',
    'ls-abnahme',
    scenario:
        'Eine Agentur hat für einen Großhändler ein Kundenportal fertiggestellt.',
    prompt: 'Bringe die Schritte der Abnahme in die richtige Reihenfolge.',
    items: [
      'Fertigstellung anzeigen und Abnahmetermin vereinbaren',
      'Abnahmetest anhand der vereinbarten Testfälle durchführen',
      'Festgestellte Mängel mit Klasse und Frist im Protokoll erfassen',
      'Abnahme erklären, unter Vorbehalt erklären oder verweigern',
      'Protokoll von beiden Seiten unterschreiben lassen',
    ],
    explanation:
        'Getestet wird gegen die vorher vereinbarten Kriterien. Die Mängel werden protokolliert, bevor die Erklärung abgegeben wird. Nur so bleiben die Rechte an bekannten Mängeln erhalten. Die Unterschriften machen das Protokoll zum Beweis.',
    difficulty: 1,
  ),
  rechnen(
    'a7-ga-6',
    'ls-abnahme',
    scenario:
        'Ein Werk wurde unter Vorbehalt abgenommen. Offen ist noch ein Mangel, dessen Beseitigung voraussichtlich 750 € kostet.',
    prompt:
        'Welchen Betrag der fälligen Vergütung darf der Besteller in der Regel zurückhalten, bis der Mangel beseitigt ist?',
    answer: 1500,
    unit: '€',
    explanation:
        'Nach § 641 Abs. 3 BGB darf der Besteller nach der Abnahme einen angemessenen Teil der Vergütung zurückhalten, in der Regel das Doppelte der voraussichtlichen Mängelbeseitigungskosten: 2 × 750 € = 1.500 €.',
    difficulty: 3,
  ),
  einfach(
    'a7-ga-7',
    'ls-abnahme',
    scenario: 'Ein Unternehmen kauft 30 Standard-Monitore bei einem Händler.',
    prompt:
        'Was bedeutet hier die Pflicht des Käufers zur „Abnahme“ (§ 433 Abs. 2 BGB)?',
    choices: [
      ja(
        'Die Monitore körperlich entgegenzunehmen',
        'Beim Kauf heißt Abnahme nur Entgegennahme der Ware.',
      ),
      nein(
        'Die Monitore als vertragsgemäß zu billigen; erst dann wird der Kaufpreis fällig',
        'Das beschreibt die Abnahme beim Werkvertrag (§ 640 BGB).',
      ),
      nein(
        'Ein Abnahmeprotokoll mit Mängelklassen zu erstellen',
        'Das ist bei Werkverträgen üblich, beim Kauf nicht vorgesehen.',
      ),
      nein(
        'Nichts, denn beim Kaufvertrag gibt es keine Pflicht zur Abnahme',
        'Doch: § 433 Abs. 2 BGB verpflichtet den Käufer, die Sache abzunehmen.',
      ),
    ],
    explanation:
        'Das Wort Abnahme bedeutet je nach Vertrag etwas anderes: beim Kauf die körperliche Entgegennahme, beim Werkvertrag die Billigung des Werks als im Wesentlichen vertragsgemäß mit Fälligkeit der Vergütung, Gefahrübergang und Beginn der Verjährung.',
    difficulty: 2,
  ),

  // ================================================== Veränderung nach Lewin
  zuordnen(
    'a7-cl-1',
    'cm-lewin',
    scenario:
        'Ein IT-Dienstleister ersetzt seine Support-Postfächer durch ein Ticketsystem.',
    prompt: 'Ordne jede Maßnahme der passenden Phase nach Lewin zu.',
    buckets: ['Unfreezing', 'Moving', 'Refreezing'],
    items: [
      zu(
        'Zwei Key-User testen das System vier Wochen im Pilotbetrieb.',
        1,
        'Erprobung während der Umstellung.',
      ),
      zu(
        'Im Kick-off zeigt die Leitung, wie viele Anfragen in den Postfächern liegen geblieben sind.',
        0,
        'Macht den Veränderungsbedarf sichtbar.',
      ),
      zu(
        'Die alten Postfächer werden abgeschaltet und der neue Ablauf in die Arbeitsanweisung aufgenommen.',
        2,
        'Der neue Zustand wird verankert.',
      ),
      zu(
        'Das Team wird nach seinen Anforderungen an das neue System gefragt.',
        0,
        'Beteiligung schafft Bereitschaft.',
      ),
      zu(
        'Alle Mitarbeitenden werden am Ticketsystem geschult.',
        1,
        'Das Neue wird umgesetzt.',
      ),
    ],
    explanation:
        'Unfreezing schafft Einsicht und Bereitschaft, Moving setzt das Neue um, Refreezing macht es zum dauerhaften Standard.',
  ),
  einfach(
    'a7-cl-2',
    'cm-lewin',
    scenario:
        'Ein neues CRM wurde mit guten Schulungen eingeführt. Zwei Monate später pflegen viele Mitarbeitende ihre Kundendaten wieder in privaten Excel-Listen. Die Listen waren nie abgeschafft worden.',
    prompt: 'Welche Phase nach Lewin wurde vernachlässigt?',
    choices: [
      ja(
        'Refreezing',
        'Der neue Zustand wurde nicht verankert. Das Alte blieb verfügbar, deshalb kehren alle zurück.',
      ),
      nein(
        'Unfreezing',
        'Die Einführung hat stattgefunden. Das Problem ist der Rückfall danach.',
      ),
      nein('Moving', 'Die Umsetzung mit Schulungen lief laut Szenario gut.'),
      nein(
        'Keine: Rückfälle sind nach Lewin unvermeidlich',
        'Gerade das Refreezing soll Rückfälle verhindern.',
      ),
    ],
    explanation:
        'Ohne Refreezing fällt eine Organisation in alte Gewohnheiten zurück. Typische Maßnahmen: Altes abschalten, Standards festschreiben, Erfolge sichtbar machen.',
  ),

  einfach(
    'a7-cl-3',
    'cm-lewin',
    scenario:
        'Vor der Einführung eines neuen ERP-Systems zeigt die Geschäftsführung in einer Betriebsversammlung, wie viel Zeit durch doppelte Datenerfassung verloren geht, und bittet alle um Verbesserungsideen.',
    prompt: 'Zu welcher Phase nach Lewin gehört diese Maßnahme?',
    choices: [
      ja(
        'Unfreezing',
        'Der Veränderungsbedarf wird sichtbar gemacht und die Betroffenen werden beteiligt. Das schafft Bereitschaft.',
      ),
      nein(
        'Moving',
        'In dieser Phase wird das Neue bereits eingeführt, etwa durch Schulungen und Pilotbetrieb.',
      ),
      nein(
        'Refreezing',
        'Hier wird das Neue verankert; das System ist aber noch gar nicht eingeführt.',
      ),
      nein(
        'Keiner, denn Lewins Modell betrifft nur technische Änderungen',
        'Lewins Modell beschreibt gerade die organisatorische und menschliche Seite von Veränderungen.',
      ),
    ],
    explanation:
        'Unfreezing: Dringlichkeit zeigen, informieren, beteiligen. Moving: schulen, pilotieren, begleiten. Refreezing: Standards festschreiben, Altes abschalten, Erfolge sichtbar machen.',
    difficulty: 1,
  ),
  mehrfach(
    'a7-cl-4',
    'cm-lewin',
    scenario:
        'Ein IT-Dienstleister führt ein Ticketsystem ein. In einer Kraftfeldanalyse wurden als hemmende Kräfte Unsicherheit im Umgang mit dem System, Angst vor Leistungskontrolle und Zeitmangel ermittelt.',
    prompt: 'Welche Maßnahmen schwächen gezielt die hemmenden Kräfte?',
    choices: [
      ja(
        'Schulungen gegen die Unsicherheit im Umgang mit dem neuen System',
        'Setzt direkt an der Unsicherheit an.',
      ),
      ja(
        'Mit dem Betriebsrat vereinbaren, dass die Daten nicht zur individuellen Leistungskontrolle genutzt werden',
        'Nimmt die Angst vor Kontrolle.',
      ),
      ja(
        'Im Arbeitsplan Zeit für die Umstellung einplanen',
        'Beseitigt den Zeitmangel.',
      ),
      nein(
        'Die Zahl unbeantworteter Anfragen im Intranet veröffentlichen',
        'Das stärkt eine treibende Kraft, baut aber keine hemmende ab.',
      ),
      nein(
        'Den Starttermin ohne Ankündigung vorziehen',
        'Das erhöht Unsicherheit und Zeitdruck, also die hemmenden Kräfte.',
      ),
    ],
    explanation:
        'Nach Lewin verändert sich ein Zustand, wenn das Gleichgewicht der Kräfte verschoben wird. Hemmende Kräfte abzubauen wirkt meist nachhaltiger, als die treibenden zu verstärken, weil mehr Druck oft mehr Gegendruck erzeugt.',
    difficulty: 3,
  ),
  zuordnen(
    'a7-cl-5',
    'cm-lewin',
    prompt: 'Ordne die Schritte nach Kotter der passenden Phase nach Lewin zu.',
    buckets: ['Unfreezing', 'Moving', 'Refreezing'],
    items: [
      zu(
        'Eine Vision entwickeln und kommunizieren',
        0,
        'Kotter Schritte 3 und 4.',
      ),
      zu(
        'Neue Verhaltensweisen in der Unternehmenskultur verankern',
        2,
        'Kotter Schritt 8.',
      ),
      zu('Schnelle Erfolge sichtbar machen', 1, 'Kotter Schritt 6.'),
      zu('Ein Gefühl der Dringlichkeit erzeugen', 0, 'Kotter Schritt 1.'),
      zu('Hindernisse beseitigen', 1, 'Kotter Schritt 5.'),
    ],
    explanation:
        'Kotters acht Schritte verfeinern Lewin: Schritte 1 bis 4 (Dringlichkeit, Führungskoalition, Vision, Kommunikation) entsprechen dem Unfreezing, 5 bis 7 (Hindernisse beseitigen, schnelle Erfolge, Erfolge ausbauen) dem Moving, Schritt 8 (Verankerung) dem Refreezing.',
    difficulty: 2,
  ),
  paare(
    'a7-cl-6',
    'cm-lewin',
    prompt: 'Verbinde jede Rolle im Veränderungsprozess mit ihrer Aufgabe.',
    paare: [
      paar('Sponsor', 'gibt Ziel und Ressourcen vor'),
      paar('Change Manager', 'plant und steuert die Veränderung'),
      paar('Key-User', 'testet früh, unterstützt die Kollegen'),
      paar('Betriebsrat', 'bestimmt bei Überwachungstechnik mit'),
    ],
    explanation:
        'Der Sponsor ist die Führungskraft hinter der Veränderung, der Change Manager steuert sie. Key-User bzw. Multiplikatoren tragen Wissen und Akzeptanz ins Team. Der Betriebsrat bestimmt mit, wenn ein System Leistung oder Verhalten überwachen kann (§ 87 Abs. 1 Nr. 6 BetrVG).',
    difficulty: 1,
  ),
  einfach(
    'a7-cl-7',
    'cm-lewin',
    scenario:
        'Ein Teamleiter will ein Ticketsystem einführen, das auswertet, wie viele Tickets jeder Mitarbeitende pro Stunde schließt. Der Betriebsrat wurde bisher nicht beteiligt.',
    prompt: 'Was ist zu beachten?',
    choices: [
      ja(
        'Der Betriebsrat hat ein Mitbestimmungsrecht, weil das System zur Überwachung von Leistung und Verhalten geeignet ist.',
        '§ 87 Abs. 1 Nr. 6 BetrVG.',
      ),
      nein(
        'Der Betriebsrat muss nur informiert werden, wenn Daten ins Ausland übertragen werden.',
        'Die Mitbestimmung hängt an der Eignung zur Überwachung, nicht am Speicherort.',
      ),
      nein(
        'Mitbestimmung gilt nur für Hardware, nicht für Software.',
        'Auch Software ist eine technische Einrichtung im Sinne des Gesetzes.',
      ),
      nein(
        'Der Betriebsrat ist nur bei Kündigungen zu beteiligen.',
        'Er hat zahlreiche Mitbestimmungsrechte, unter anderem bei technischen Überwachungseinrichtungen.',
      ),
    ],
    explanation:
        'Systeme, die Leistung oder Verhalten der Beschäftigten überwachen können, dürfen nur mit Zustimmung des Betriebsrats eingeführt werden. Frühe Beteiligung klärt den Rahmen („nicht dürfen“) und baut die Angst vor Kontrolle ab.',
    difficulty: 2,
  ),

  // ============================================================ Widerstände
  zuordnen(
    'a7-cw-1',
    'cm-widerstand',
    prompt: 'Welche Ursache steckt hinter der Aussage?',
    buckets: ['nicht wissen', 'nicht können', 'nicht wollen', 'nicht dürfen'],
    items: [
      zu(
        '„Mir hat niemand erklärt, warum wir überhaupt wechseln.“',
        0,
        'Es fehlt Information.',
      ),
      zu(
        '„Ich finde mich in der neuen Oberfläche einfach nicht zurecht.“',
        1,
        'Es fehlen Fähigkeiten, hier hilft eine Schulung.',
      ),
      zu(
        '„Ich würde Tickets gern selbst schließen, habe aber keine Berechtigung dazu.“',
        3,
        'Es fehlt die Befugnis.',
      ),
      zu(
        '„Meine Excel-Liste gebe ich nicht auf, egal was das neue System kann.“',
        2,
        'Es fehlt die Bereitschaft.',
      ),
    ],
    explanation:
        'Zu jeder Ursache gehört eine Maßnahme: Wer nicht weiß, wird informiert. Wer nicht kann, wird geschult. Wer nicht will, wird beteiligt und sieht die Vorteile. Wer nicht darf, braucht geklärte Befugnisse.',
  ),
  einfach(
    'a7-cw-2',
    'cm-widerstand',
    prompt: 'Welches Verhalten ist ein Beispiel für verdeckten Widerstand?',
    choices: [
      ja(
        'Ein Mitarbeiter stimmt in Besprechungen zu, verschleppt aber seit Wochen ohne Begründung die Datenmigration.',
        'Der Widerstand wird nicht ausgesprochen, sondern zeigt sich im Verzögern.',
      ),
      nein(
        'Eine Mitarbeiterin widerspricht in der Teambesprechung deutlich dem Zeitplan.',
        'Das ist offener Widerstand. Er ist sichtbar und lässt sich ansprechen.',
      ),
      nein(
        'Ein Team schreibt eine Beschwerde über die Einführung an die Geschäftsleitung.',
        'Auch das ist offen geäußerter Widerstand.',
      ),
      nein(
        'Ein Auszubildender fragt nach zusätzlichen Schulungsterminen.',
        'Das ist kein Widerstand, sondern Lernbereitschaft.',
      ),
    ],
    explanation:
        'Offener Widerstand wird ausgesprochen, verdeckter zeigt sich indirekt: Verzögern, Dienst nach Vorschrift, Gerüchte. Verdeckter Widerstand ist schwerer zu erkennen und deshalb gefährlicher.',
  ),

  zuordnen(
    'a7-cw-3',
    'cm-widerstand',
    scenario: 'Ein Unternehmen stellt auf ein neues CRM-System um.',
    prompt:
        'Ordne jedes Verhalten dem passenden Symptom nach Doppler und Lauterburg zu.',
    buckets: ['Widerspruch', 'Ausweichen', 'Aufregung', 'Lustlosigkeit'],
    items: [
      zu(
        'In Besprechungen wechselt ein Kollege jedes Mal das Thema, wenn es um das CRM geht.',
        1,
        'Verbal und passiv: Ablenken, Bagatellisieren.',
      ),
      zu(
        'Auf dem Flur machen Gerüchte über geplante Entlassungen die Runde.',
        2,
        'Nonverbal und aktiv: Unruhe, Stimmungsmache.',
      ),
      zu(
        'Eine Mitarbeiterin wirkt in Schulungen unaufmerksam und meldet sich häufiger krank.',
        3,
        'Nonverbal und passiv: Rückzug, innere Kündigung.',
      ),
      zu(
        '„Das ist doch völliger Unsinn, der alte Prozess war viel besser!“',
        0,
        'Verbal und aktiv: offener Gegenangriff.',
      ),
    ],
    explanation:
        'Doppler und Lauterburg ordnen Widerstand nach verbal/nonverbal und aktiv/passiv: Widerspruch (verbal, aktiv), Ausweichen (verbal, passiv), Aufregung (nonverbal, aktiv), Lustlosigkeit (nonverbal, passiv).',
    difficulty: 2,
  ),
  reihenfolge(
    'a7-cw-4',
    'cm-widerstand',
    prompt:
        'Bringe die sieben Phasen der Veränderungskurve nach Streich in die richtige Reihenfolge.',
    items: [
      'Schock',
      'Verneinung',
      'Rationale Einsicht',
      'Emotionale Akzeptanz („Tal der Tränen“)',
      'Ausprobieren',
      'Erkenntnis',
      'Integration',
    ],
    explanation:
        'Die sieben Phasen: Schock, Verneinung, rationale Einsicht, emotionale Akzeptanz, Ausprobieren, Erkenntnis, Integration. Die wahrgenommene Kompetenz erreicht bei der emotionalen Akzeptanz ihren Tiefpunkt und steigt mit dem Ausprobieren wieder.',
    difficulty: 2,
  ),
  tabelle(
    'a7-cw-5',
    'cm-widerstand',
    scenario:
        'Bei der Einführung eines neuen ERP-Systems äußern sich vier Mitarbeitende.',
    prompt:
        'Bestimme zu jeder Aussage die Ursache des Widerstands und die passende Maßnahme.',
    zeilen: [
      ['Aussage', 'Ursache', 'Passende Maßnahme'],
      [
        '„Ich komme mit den neuen Masken einfach nicht zurecht.“',
        wahl('nicht können', ['nicht wissen', 'nicht wollen', 'nicht dürfen']),
        wahl('schulen und begleiten', [
          'Gründe und Nutzen erklären',
          'beteiligen, Bedenken ernst nehmen',
          'Befugnisse klären',
        ]),
      ],
      [
        '„Warum wir umstellen, hat uns keiner gesagt.“',
        wahl('nicht wissen', ['nicht können', 'nicht wollen', 'nicht dürfen']),
        wahl('Gründe und Nutzen erklären', [
          'schulen und begleiten',
          'beteiligen, Bedenken ernst nehmen',
          'Befugnisse klären',
        ]),
      ],
      [
        '„Ich würde Aufträge gern selbst freigeben, mir fehlt aber die Berechtigung.“',
        wahl('nicht dürfen', ['nicht wissen', 'nicht können', 'nicht wollen']),
        wahl('Befugnisse klären', [
          'Gründe und Nutzen erklären',
          'schulen und begleiten',
          'beteiligen, Bedenken ernst nehmen',
        ]),
      ],
      [
        '„Das alte System gebe ich nicht her, egal was das neue kann.“',
        wahl('nicht wollen', ['nicht wissen', 'nicht können', 'nicht dürfen']),
        wahl('beteiligen, Bedenken ernst nehmen', [
          'Gründe und Nutzen erklären',
          'schulen und begleiten',
          'Befugnisse klären',
        ]),
      ],
    ],
    explanation:
        'Widerstand ist ein Signal, das man entschlüsseln muss. Wer nicht weiß, wird informiert. Wer nicht kann, wird geschult. Wer nicht will, wird beteiligt und sieht die Vorteile. Wer nicht darf, braucht geklärte Befugnisse. Anordnung und Sanktion sind das letzte Mittel.',
    punkte: 4,
    difficulty: 1,
  ),
  einfach(
    'a7-cw-6',
    'cm-widerstand',
    scenario:
        'Durch die Automatisierung der Rechnungsprüfung fällt ein großer Teil der Aufgaben eines Sachbearbeiters weg. Er befürchtet, seine Stelle zu verlieren, und blockiert das Projekt.',
    prompt: 'Welche Strategie passt am besten?',
    choices: [
      ja(
        'Offen informieren und verhandeln: neue Aufgabe, Weiterbildung, Zusage zur Weiterbeschäftigung',
        'Er verliert tatsächlich etwas. Dann helfen Information und ein fairer Ausgleich.',
      ),
      nein(
        'Die Automatisierung bis zum Start geheim halten',
        'Das verstärkt Misstrauen und Gerüchte.',
      ),
      nein(
        'Ihn per Anweisung zur Mitarbeit verpflichten',
        'Druck löst die Angst nicht und erzeugt Scheinanpassung.',
      ),
      nein(
        'Nur eine Schulung zum neuen System anbieten',
        'Das Problem ist nicht fehlendes Können, sondern die Sorge um den Arbeitsplatz.',
      ),
    ],
    explanation:
        'Die passende Strategie hängt von der Ursache ab. Bei einem realen Verlust helfen Information, Beteiligung sowie Verhandlung und Ausgleich. Schulung hilft bei „nicht können“, Anordnung ist das letzte Mittel.',
    difficulty: 2,
  ),

  // ========================================================= Kaizen und KVP
  zuordnen(
    'a7-ck-1',
    'cm-kaizen',
    prompt:
        'Ist die Maßnahme eher Kaizen (KVP) oder Business Process Reengineering?',
    buckets: ['Kaizen / KVP', 'Business Process Reengineering'],
    items: [
      zu(
        'Der Service Desk verkürzt die Bearbeitungszeit mit neuen Textbausteinen.',
        0,
        'Kleine Verbesserung aus dem Team heraus.',
      ),
      zu(
        'Die gesamte Auftragsabwicklung wird von Grund auf neu gestaltet.',
        1,
        'Radikaler Neuentwurf eines Prozesses.',
      ),
      zu(
        'Eine Auszubildende schlägt vor, Lieferscheine direkt beim Wareneingang zu scannen. Das Team probiert es aus.',
        0,
        'Vorschlag von der Basis, kleiner Schritt.',
      ),
      zu(
        'Alle Abteilungen werden aufgelöst und entlang der Kundenprozesse neu organisiert.',
        1,
        'Grundlegender, einmaliger Umbruch.',
      ),
    ],
    explanation:
        'Kaizen: viele kleine, stetige Verbesserungen von allen Mitarbeitenden. Reengineering: radikale, grundlegende Neugestaltung, meist von oben angestoßen.',
  ),
  reihenfolge(
    'a7-ck-2',
    'cm-kaizen',
    scenario:
        'Im Service Desk dauert das Anlegen neuer Benutzerkonten zu lange.',
    prompt: 'Bringe die Schritte des PDCA-Zyklus in die richtige Reihenfolge.',
    items: [
      'Ursache analysieren und als Ziel ein Formular mit Vorlage festlegen',
      'Die Vorlage vier Wochen im Team ausprobieren',
      'Messen, ob die Bearbeitungszeit gesunken ist',
      'Die Vorlage zum Standard machen und den nächsten Zyklus beginnen',
    ],
    hint: 'Plan, Do, Check, Act',
    explanation:
        'In Plan legst du Ursache und Ziel fest, in Do probierst du die Lösung im kleinen Rahmen aus. In Check misst du das Ergebnis, in Act wird Erfolgreiches zum Standard und der nächste Zyklus beginnt.',
  ),
  zuordnen(
    'a7-ck-3',
    'cm-kaizen',
    prompt: 'Welche Art der Verschwendung (Muda) liegt jeweils vor?',
    buckets: ['Wartezeit', 'Fehler', 'Überproduktion', 'Bewegung'],
    items: [
      zu(
        'Ein falsch eingerichtetes Benutzerkonto muss komplett neu angelegt werden.',
        1,
        'Nacharbeit wegen eines Fehlers.',
      ),
      zu(
        'Ein Admin sucht Zugangsdaten in fünf verschiedenen Tools zusammen.',
        3,
        'Unnötige Such- und Laufwege, übertragen auf die digitale Arbeit.',
      ),
      zu(
        'Das Team entwickelt Funktionen, die kein Kunde bestellt hat und niemand nutzt.',
        2,
        'Mehr produziert als gebraucht.',
      ),
      zu(
        'Ein Techniker wartet zwei Tage auf die Freigabe einer Bestellung.',
        0,
        'Stillstand ohne Wertschöpfung.',
      ),
    ],
    explanation:
        'Die sieben Arten der Verschwendung sind Transport, Bestände, Bewegung, Wartezeit, Überproduktion, Überbearbeitung und Fehler. Kaizen macht sie sichtbar und baut sie in kleinen Schritten ab.',
    difficulty: 2,
  ),
  rechnen(
    'a7-ck-4',
    'cm-kaizen',
    scenario:
        'Nach einem KVP-Workshop sinkt die Bearbeitungszeit je Ticket im Service Desk von 18 auf 12 Minuten. Pro Monat fallen 900 Tickets an.',
    prompt: 'Wie viele Arbeitsstunden spart das Team pro Monat?',
    answer: 90,
    unit: 'h',
    explanation:
        'Ersparnis je Ticket = 18 min − 12 min = 6 min. Pro Monat = 900 × 6 min = 5.400 min. In Stunden: 5.400 / 60 = 90 h.',
    difficulty: 1,
  ),
  tabelle(
    'a7-ck-5',
    'cm-kaizen',
    prompt:
        'Vergleiche Kaizen (KVP) und Business Process Reengineering anhand der Merkmale.',
    zeilen: [
      ['Merkmal', 'Kaizen / KVP', 'Reengineering'],
      [
        'Umfang der Änderung',
        wahl('viele kleine Schritte', [
          'radikaler Neuentwurf',
          'keine Änderung',
        ]),
        wahl('radikaler Neuentwurf', [
          'viele kleine Schritte',
          'keine Änderung',
        ]),
      ],
      [
        'Wer treibt die Änderung?',
        wahl('alle Mitarbeitenden', [
          'vor allem Leitung und Berater',
          'allein der Kunde',
        ]),
        wahl('vor allem Leitung und Berater', [
          'alle Mitarbeitenden',
          'allein der Kunde',
        ]),
      ],
      [
        'Zeitlicher Verlauf',
        wahl('ständig, ohne Endpunkt', [
          'einmaliger großer Schnitt',
          'nur nach Störungen',
        ]),
        wahl('einmaliger großer Schnitt', [
          'ständig, ohne Endpunkt',
          'nur nach Störungen',
        ]),
      ],
    ],
    explanation:
        'Kaizen bzw. KVP bedeutet ständige Verbesserung in kleinen Schritten durch alle Mitarbeitenden; jeder Schritt läuft im PDCA-Zyklus und wird zum neuen Standard. Business Process Reengineering gestaltet einen Prozess einmalig und radikal neu, meist von oben angestoßen.',
    punkte: 3,
    difficulty: 1,
  ),
  paare(
    'a7-ck-6',
    'cm-kaizen',
    prompt: 'Verbinde jeden Schritt der 5S-Methode mit seiner Bedeutung.',
    paare: [
      paar('Seiri', 'Sortieren: Unnötiges entfernen'),
      paar('Seiton', 'Systematisch ordnen'),
      paar('Seiso', 'Sauber halten'),
      paar('Seiketsu', 'Standardisieren'),
      paar('Shitsuke', 'Selbstdisziplin: Regeln einhalten'),
    ],
    explanation:
        '5S: Seiri (Sortieren), Seiton (Systematisch ordnen), Seiso (Sauber halten), Seiketsu (Standardisieren), Shitsuke (Selbstdisziplin). Die Methode schafft geordnete, standardisierte Arbeitsplätze als Grundlage für Kaizen.',
    difficulty: 2,
  ),
  zuordnen(
    'a7-ck-7',
    'cm-kaizen',
    prompt:
        'Passt das Merkmal eher zum KVP oder zum betrieblichen Vorschlagswesen?',
    buckets: ['KVP', 'betriebliches Vorschlagswesen'],
    items: [
      zu(
        'Für angenommene Vorschläge gibt es eine Prämie.',
        1,
        'Typischer Anreiz im Vorschlagswesen.',
      ),
      zu(
        'Verbesserung ist Teil der täglichen Arbeit.',
        0,
        'KVP ist in den Alltag eingebaut.',
      ),
      zu(
        'Eine Einzelperson reicht einen Vorschlag für eine andere Abteilung ein.',
        1,
        'Einzelvorschlag, auch für fremde Bereiche.',
      ),
      zu(
        'Ein Team verbessert laufend die Abläufe im eigenen Bereich.',
        0,
        'Teamarbeit, eigener Bereich, ständig.',
      ),
    ],
    explanation:
        'KVP: Teams verbessern kontinuierlich ihren eigenen Arbeitsbereich, Anreiz ist die Verbesserung selbst. Betriebliches Vorschlagswesen: Einzelne reichen gelegentlich Vorschläge ein, auch für andere Bereiche, und erhalten meist eine Prämie.',
    difficulty: 1,
  ),
];
