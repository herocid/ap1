import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben im IHK-Stil zu Bereich 07: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA07 = [
  // ============================================ Wie ein Vertrag zustande kommt
  tabelle(
    'i7-vz-1',
    'vt-zustandekommen',
    scenario:
        'Ein Systemhaus beschafft für eine Steuerkanzlei 18 Notebooks. In der Akte liegt der Schriftverkehr mit dem Lieferanten.',
    prompt:
        'Ordne jedem Vorgang seine rechtliche Bedeutung zu und gib an, mit welchem Vorgang der Kaufvertrag zustande kommt.',
    zeilen: [
      ['Datum', 'Vorgang', 'Rechtliche Bedeutung'],
      [
        '03.03.',
        'Das Systemhaus fragt per E-Mail nach Preisen für 18 Notebooks.',
        wahl('Anfrage (unverbindlich)', [
          'Antrag',
          'Annahme',
          'neuer Antrag',
        ], 'Eine Anfrage bindet niemanden.'),
      ],
      [
        '05.03.',
        'Der Lieferant schickt ein Angebot, gültig bis 19.03.',
        wahl(
          'Antrag',
          ['Anfrage (unverbindlich)', 'Annahme', 'Aufforderung zum Antrag'],
          'Ein Angebot an einen bestimmten Kunden ist ein verbindlicher Antrag.',
        ),
      ],
      [
        '21.03.',
        'Das Systemhaus bestellt zu den Bedingungen des Angebots.',
        wahl(
          'neuer Antrag',
          ['Annahme', 'Anfrage (unverbindlich)', 'Aufforderung zum Antrag'],
          'Die Frist ist seit dem 19.03. abgelaufen. Eine verspätete Annahme gilt als neuer Antrag (§ 150 Abs. 1 BGB).',
        ),
      ],
      [
        '22.03.',
        'Der Lieferant schickt eine Auftragsbestätigung.',
        wahl('Annahme', [
          'Antrag',
          'neuer Antrag',
          'Anfrage (unverbindlich)',
        ], 'Der Lieferant nimmt den neuen Antrag des Systemhauses an.'),
      ],
      [
        'Ergebnis',
        'Der Kaufvertrag kommt zustande am',
        wahl(
          '22.03.',
          ['05.03.', '21.03.', '19.03.'],
          'Erst an diesem Tag liegen Antrag und Annahme übereinstimmend vor.',
        ),
      ],
    ],
    explanation:
        'Die Anfrage ist unverbindlich. Das Angebot an einen bestimmten Kunden ist ein Antrag, hier befristet bis 19.03. Die Bestellung vom 21.03. kommt zu spät und ist deshalb ein neuer Antrag (§ 150 Abs. 1 BGB). Mit der Auftragsbestätigung vom 22.03. nimmt der Lieferant an. Erst jetzt besteht der Vertrag.',
    punkte: 5,
  ),
  freitext(
    'i7-vz-2',
    'vt-zustandekommen',
    scenario:
        'Ein Vertriebsmitarbeiter vertippt sich im Angebot beim Preis. Die Auszubildende meint: „Dann ist der Vertrag doch sowieso nichtig.“',
    prompt:
        'Erläutere den Unterschied zwischen einem nichtigen und einem anfechtbaren Rechtsgeschäft und nenne je ein Beispiel.',
    kriterien: [
      krit(
        'Nichtig: von Anfang an unwirksam, ohne dass jemand etwas erklären muss',
        punkte: 2,
        stichwoerter: [
          'von Anfang an',
          'unwirksam',
          'automatisch',
          'ohne Erklärung',
        ],
      ),
      krit(
        'Anfechtbar: zunächst wirksam; erst die Anfechtungserklärung macht es rückwirkend nichtig',
        punkte: 2,
        stichwoerter: [
          'zunächst wirksam',
          'Anfechtung',
          'rückwirkend',
          'erklären',
          'gültig bis',
        ],
      ),
      krit(
        'Beispiel nichtig: Geschäft eines Geschäftsunfähigen, Formmangel, Schein- oder Scherzgeschäft, Gesetzes- oder Sittenverstoß',
        stichwoerter: [
          'geschäftsunfähig',
          'Formmangel',
          'Scheingeschäft',
          'Scherz',
          'sittenwidrig',
          'Kind',
        ],
      ),
      krit(
        'Beispiel anfechtbar: Erklärungsirrtum (Tippfehler), Inhalts- oder Eigenschaftsirrtum, arglistige Täuschung, Drohung',
        stichwoerter: [
          'Irrtum',
          'Tippfehler',
          'vertippt',
          'Täuschung',
          'Drohung',
        ],
      ),
    ],
    loesung:
        'Ein nichtiges Rechtsgeschäft ist von Anfang an unwirksam, zum Beispiel ein Kauf, den ein sechsjähriges Kind abschließt, oder ein Grundstückskauf ohne Notar. Ein anfechtbares Rechtsgeschäft ist zunächst wirksam. Erst wenn der Berechtigte die Anfechtung erklärt, wird es rückwirkend nichtig, zum Beispiel beim Tippfehler im Preis (Erklärungsirrtum) oder bei arglistiger Täuschung. Der Vertrag aus der Situation ist also nicht automatisch nichtig, sondern muss unverzüglich angefochten werden.',
    explanation:
        'Je Erläuterung 2 Punkte, je passendes Beispiel 1 Punkt. Andere richtige Beispiele werden ebenfalls gewertet. Achte auf die Abgrenzung: Die Nichtigkeit tritt von selbst ein, die Anfechtung muss erklärt werden.',
    punkte: 6,
  ),
  lueckentext(
    'i7-vz-3',
    'vt-zustandekommen',
    prompt: 'Ergänze den Text zum Vertragsschluss mit den Begriffen.',
    text:
        'Ein Vertrag kommt durch zwei übereinstimmende {0} zustande. Die erste heißt {1}, die zweite {2}. Kataloge, Schaufensterauslagen und Webshops richten sich an die Allgemeinheit und sind nur eine {3}. Wer verspätet oder mit Änderungen zusagt, gibt rechtlich ein neues {4} ab. Kaufverträge über bewegliche Sachen sind {5}, sie können also auch mündlich geschlossen werden.',
    luecken: [
      wort(['Willenserklärungen']),
      wort(['Antrag', 'Angebot'], 'Antrag und Angebot bedeuten dasselbe.'),
      wort(['Annahme']),
      wort(['Aufforderung zum Antrag'], 'Lateinisch: invitatio ad offerendum.'),
      wort(['Angebot', 'Antrag'], '§ 150 BGB.'),
      wort(['formfrei']),
    ],
    wortbank: ['Mahnung', 'Kündigung', 'schriftlich', 'Abnahme'],
    explanation:
        'Antrag (Angebot) und Annahme sind die beiden Willenserklärungen. Werbung an die Allgemeinheit bindet nicht. Eine verspätete oder geänderte Annahme gilt als neuer Antrag (§ 150 BGB). Für Kaufverträge über bewegliche Sachen schreibt das Gesetz keine Form vor.',
    punkte: 3,
    difficulty: 1,
  ),
  markieren(
    'i7-vz-4',
    'vt-zustandekommen',
    scenario:
        'Ein Systemhaus möchte wissen, an welche seiner Erklärungen es rechtlich gebunden ist.',
    prompt:
        'Markiere alle Erklärungen, an die das Systemhaus rechtlich gebunden ist.',
    zeilen: [
      nein(
        'Werbeflyer „Notebooks ab 599 €“ an alle Haushalte',
        'Werbung richtet sich an die Allgemeinheit, sie ist nur eine Aufforderung zum Antrag.',
      ),
      ja(
        'Schriftliches Angebot an eine Kanzlei über 18 Notebooks, gültig 14 Tage',
        'Ein Antrag an einen bestimmten Empfänger bindet bis zum Ablauf der Frist (§§ 145, 148 BGB).',
      ),
      nein(
        'Angebot an einen Kunden mit dem Zusatz „freibleibend“',
        'Mit der Freizeichnungsklausel ist die Bindung ausgeschlossen (§ 145 BGB).',
      ),
      nein(
        'Telefonisches Angebot, das der Kunde im Gespräch nicht annimmt',
        'Ein Antrag unter Anwesenden oder am Telefon kann nur sofort angenommen werden (§ 147 Abs. 1 BGB).',
      ),
      nein(
        'Preisliste im Webshop',
        'Eine Artikelseite ist keine Willenserklärung gegenüber einem bestimmten Kunden.',
      ),
      ja(
        'Auftragsbestätigung auf die fristgerechte Bestellung eines Kunden',
        'Das ist die Annahme. Damit ist der Vertrag geschlossen und für beide verbindlich.',
      ),
    ],
    explanation:
        'Gebunden ist, wer einen Antrag an einen bestimmten Empfänger abgibt (solange die Frist läuft) oder einen Antrag annimmt. Werbung, Preislisten und freibleibende Angebote binden nicht; ein telefonischer Antrag erlischt, wenn er nicht sofort angenommen wird.',
    punkte: 3,
  ),

  // ============================================================ Vertragsarten
  tabelle(
    'i7-vy-1',
    'vt-arten',
    scenario:
        'Eine Agentur stellt ihre IT neu auf und schließt dafür mehrere Verträge.',
    prompt:
        'Ordne jedem Sachverhalt die Vertragsart und die Vorschrift des BGB zu.',
    zeilen: [
      ['Sachverhalt', 'Vertragsart', 'BGB'],
      [
        'Die Agentur erwirbt zehn Grafik-Workstations.',
        wahl('Kaufvertrag', ['Werkvertrag', 'Mietvertrag', 'Leihvertrag']),
        wahl('§ 433', ['§ 535', '§ 611', '§ 631']),
      ],
      [
        'Ein Softwarehaus programmiert zum Festpreis eine Schnittstelle zur Buchhaltung.',
        wahl('Werkvertrag', ['Dienstvertrag', 'Kaufvertrag', 'Mietvertrag']),
        wahl('§ 631', ['§ 433', '§ 598', '§ 611']),
      ],
      [
        'Ein externer Administrator hilft stundenweise aus, abgerechnet nach Aufwand.',
        wahl('Dienstvertrag', ['Werkvertrag', 'Leihvertrag', 'Kaufvertrag']),
        wahl('§ 611', ['§ 631', '§ 535', '§ 433']),
      ],
      [
        'Ein Ticketsystem wird als SaaS für 12 € je Nutzer und Monat genutzt.',
        wahl('Mietvertrag', ['Kaufvertrag', 'Leihvertrag', 'Werkvertrag']),
        wahl('§ 535', ['§ 433', '§ 598', '§ 631']),
      ],
      [
        'Ein Händler überlässt kostenlos für zwei Wochen einen Testmonitor.',
        wahl('Leihvertrag', ['Mietvertrag', 'Kaufvertrag', 'Dienstvertrag']),
        wahl('§ 598', ['§ 535', '§ 611', '§ 433']),
      ],
    ],
    explanation:
        'Eigentum gegen Geld: Kauf (§ 433). Erfolg geschuldet: Werk (§ 631). Tätigkeit geschuldet: Dienst (§ 611). Gebrauch auf Zeit gegen Entgelt: Miete (§ 535). Gebrauch auf Zeit ohne Entgelt: Leihe (§ 598).',
    punkte: 5,
  ),
  freitext(
    'i7-vy-2',
    'vt-arten',
    scenario:
        'Ein Handelsunternehmen lässt von einem Softwarehaus ein Kundenportal entwickeln. Das Softwarehaus schlägt vor, „nach Aufwand“ auf Stundenbasis abzurechnen.',
    prompt:
        'Erläutere zwei Unterschiede zwischen Werkvertrag und Dienstvertrag.',
    kriterien: [
      krit(
        'Geschuldet: beim Werkvertrag ein Erfolg (fertiges Werk), beim Dienstvertrag nur die Tätigkeit',
        punkte: 2,
        stichwoerter: ['Erfolg', 'Ergebnis', 'Tätigkeit', 'Bemühen', 'fertig'],
      ),
      krit(
        'Abnahme und Vergütung: Werkvertrag mit Abnahme, erst dann wird die Vergütung fällig; Dienstvertrag ohne Abnahme, Vergütung nach Zeit',
        punkte: 2,
        stichwoerter: [
          'Abnahme',
          'fällig',
          'nach Stunden',
          'nach Zeit',
          'Aufwand',
        ],
      ),
      krit(
        'Mängel: Werkvertrag mit Mängelrechten (Nacherfüllung, Minderung, Rücktritt); Dienstvertrag kennt keine Gewährleistung',
        punkte: 2,
        stichwoerter: [
          'Mängelrechte',
          'Gewährleistung',
          'Nacherfüllung',
          'Nachbesserung',
          'Mangel',
        ],
      ),
      krit(
        'Risiko: Beim Werkvertrag trägt der Unternehmer das Risiko des Misserfolgs, beim Dienstvertrag der Auftraggeber',
        punkte: 2,
        stichwoerter: ['Risiko', 'Misserfolg', 'trägt', 'Mehraufwand'],
      ),
    ],
    loesung:
        'Beim Werkvertrag schuldet der Unternehmer einen Erfolg, etwa das lauffähige Portal; beim Dienstvertrag nur das Tätigwerden. Deshalb gibt es beim Werkvertrag eine Abnahme, mit der die Vergütung fällig wird, und Mängelrechte, wenn das Werk Fehler hat. Beim Dienstvertrag wird nach geleisteter Zeit bezahlt, auch wenn das Ergebnis ausbleibt. Das Risiko trägt der Auftraggeber.',
    explanation:
        'Je Unterschied 2 Punkte, höchstens 4 Punkte. Für das Handelsunternehmen ist der Werkvertrag günstiger, weil das Softwarehaus für das funktionierende Ergebnis einstehen muss.',
    punkte: 4,
  ),
  paare(
    'i7-vy-3',
    'vt-arten',
    prompt: 'Verbinde jede Vertragsart mit der Hauptpflicht.',
    paare: [
      paar('Kaufvertrag', 'Sache übergeben, Eigentum verschaffen'),
      paar('Mietvertrag', 'Gebrauch auf Zeit gegen Entgelt gewähren'),
      paar('Leihvertrag', 'Gebrauch unentgeltlich gestatten'),
      paar('Werkvertrag', 'versprochenes Werk herstellen'),
      paar('Dienstvertrag', 'versprochene Dienste leisten'),
      paar('Darlehensvertrag', 'Geldbetrag auf Zeit überlassen'),
    ],
    explanation:
        'Die Hauptpflicht entscheidet über die Vertragsart: Eigentum (Kauf), Gebrauch gegen Entgelt (Miete) oder ohne Entgelt (Leihe), Erfolg (Werk), Tätigkeit (Dienst), Geld auf Zeit (Darlehen).',
    difficulty: 1,
  ),
  markieren(
    'i7-vy-4',
    'vt-arten',
    scenario:
        'Für ein Softwareprojekt liegen Klauseln aus zwei verschiedenen Vertragsentwürfen vor.',
    prompt:
        'Markiere alle Klauseln, die für einen Werkvertrag kennzeichnend sind.',
    zeilen: [
      ja(
        'Der Auftragnehmer schuldet eine lauffähige Lagerverwaltung gemäß Pflichtenheft.',
        'Geschuldet ist ein bestimmter Erfolg, das Kennzeichen des Werkvertrags (§ 631 BGB).',
      ),
      nein(
        'Abgerechnet wird monatlich nach geleisteten Stunden zu 95 € je Stunde.',
        'Vergütung nach Zeit ohne Erfolgsbezug spricht für einen Dienstvertrag.',
      ),
      ja(
        'Der Festpreis von 48.000 € wird mit der Abnahme fällig.',
        'Fälligkeit mit Abnahme ist typisch für den Werkvertrag (§ 641 BGB).',
      ),
      nein(
        'Der Auftragnehmer stellt zwei Entwickler zur Unterstützung des Teams bereit.',
        'Geschuldet ist nur Arbeitsleistung, kein Ergebnis. Das spricht für einen Dienstvertrag.',
      ),
      ja(
        'Der Auftraggeber nimmt die Software nach bestandenem Abnahmetest ab.',
        'Die Abnahme als Billigung des Ergebnisses gehört zum Werkvertrag (§ 640 BGB), der Dienstvertrag kennt sie nicht.',
      ),
      ja(
        'Mängel beseitigt der Auftragnehmer innerhalb der Gewährleistungsfrist kostenlos.',
        'Mängelrechte setzen einen geschuldeten Erfolg voraus.',
      ),
    ],
    explanation:
        'Werkvertrag: Erfolg geschuldet, Abnahme, Vergütung bei Abnahme, Gewährleistung. Dienstvertrag: Tätigkeit geschuldet, Vergütung nach Zeit, keine Abnahme. Auf die Überschrift des Vertrags kommt es nicht an.',
    punkte: 4,
  ),
  rechnen(
    'i7-vy-5',
    'vt-arten',
    scenario:
        'Für 18 Notebooks liegen zwei Angebote vor: Kauf zu 1.150 € je Gerät oder Leasing über 36 Monate zu 36 € je Gerät und Monat. Am Ende der Laufzeit gehen die Leasinggeräte zurück.',
    prompt:
        'Berechne, um wie viel Euro das Leasing über die gesamte Laufzeit teurer ist als der Kauf.',
    answer: 2628,
    unit: '€',
    explanation:
        'Kauf: 18 × 1.150 € = 20.700 €. Leasing: 18 × 36 € = 648 € je Monat, × 36 Monate = 23.328 €. Differenz: 23.328 € − 20.700 € = 2.628 €. Dafür bleibt beim Leasing die Liquidität erhalten, und Eigentümer bleibt der Leasinggeber.',
    punkte: 3,
  ),

  // ================================================ Urheberrecht und Lizenzen
  markieren(
    'i7-vu-1',
    'vt-urheber',
    scenario:
        'Eine Agentur hat eine Grafiksoftware lizenziert. Der Hersteller schickt folgenden Auszug aus den Lizenzbedingungen.',
    code:
        'SOFTWARE LICENCE (excerpt)\n'
        '1. The licensee is granted a non-exclusive, non-transferable\n'
        '   right to use the software.\n'
        '2. The software may be installed on up to 20 devices.\n'
        '3. One backup copy may be made for archival purposes.\n'
        '4. The licensee must not modify, decompile or redistribute\n'
        '   the software.\n'
        '5. The licence is valid for 12 months and ends automatically\n'
        '   unless it is renewed.',
    prompt: 'Markiere alles, was nach diesem Auszug zulässig ist.',
    zeilen: [
      ja(
        'Die Agentur installiert die Software auf 18 Arbeitsplätzen.',
        'Nr. 2 erlaubt bis zu 20 Geräte.',
      ),
      nein(
        'Die Agentur verkauft die Lizenz an ein befreundetes Unternehmen weiter.',
        'Nr. 1 nennt die Lizenz „non-transferable“, sie ist also nicht übertragbar.',
      ),
      ja(
        'Ein Administrator legt eine Sicherungskopie für das Archiv an.',
        'Nr. 3 erlaubt eine Sicherungskopie.',
      ),
      nein(
        'Eine Entwicklerin dekompiliert das Programm und passt es an.',
        'Nr. 4 verbietet Ändern und Dekompilieren.',
      ),
      ja(
        'Der Hersteller vergibt dieselbe Software auch an andere Kunden.',
        '„Non-exclusive“ (Nr. 1) bedeutet ein einfaches Nutzungsrecht. Der Hersteller darf also weitere Lizenzen vergeben.',
      ),
      nein(
        'Die Agentur nutzt die Software im 14. Monat ohne Verlängerung weiter.',
        'Nr. 5: Die Lizenz endet nach 12 Monaten automatisch.',
      ),
    ],
    explanation:
        'Non-exclusive = einfaches Nutzungsrecht, non-transferable = nicht übertragbar. Der Auszug erlaubt bis zu 20 Installationen und eine Sicherungskopie, verbietet Ändern, Dekompilieren und Weitergabe und befristet die Nutzung auf 12 Monate.',
    punkte: 3,
    tags: ['englisch'],
  ),
  tabelle(
    'i7-vu-2',
    'vt-urheber',
    scenario:
        'Eine Agentur hat 30 Mitarbeitende und 24 PCs. Messungen zeigen, dass höchstens 12 Personen gleichzeitig mit der Projektsoftware arbeiten. Der Hersteller bietet drei Lizenzmodelle an.',
    prompt:
        'Ermittle je Modell die Anzahl der benötigten Lizenzen und die Jahreskosten.',
    zeilen: [
      ['Lizenzmodell', 'Preis je Lizenz und Jahr', 'Anzahl', 'Jahreskosten'],
      [
        'Named User (je benannter Person)',
        '90 €',
        zahl(30, rationale: 'Jede der 30 Personen braucht eine Lizenz.'),
        zahl(2700, einheit: '€', rationale: '30 × 90 €'),
      ],
      [
        'Gerätelizenz (je PC)',
        '120 €',
        zahl(24, rationale: 'Eine Lizenz je PC.'),
        zahl(2880, einheit: '€', rationale: '24 × 120 €'),
      ],
      [
        'Concurrent User (gleichzeitige Nutzer)',
        '210 €',
        zahl(12, rationale: 'Es zählt die höchste gleichzeitige Nutzung.'),
        zahl(2520, einheit: '€', rationale: '12 × 210 €'),
      ],
    ],
    explanation:
        'Named User: 30 × 90 € = 2.700 €. Gerätelizenz: 24 × 120 € = 2.880 €. Concurrent User: 12 × 210 € = 2.520 €. Am günstigsten ist hier das Concurrent-Modell, obwohl die einzelne Lizenz am teuersten ist.',
    punkte: 6,
  ),
  freitext(
    'i7-vu-3',
    'vt-urheber',
    scenario:
        'Ein angestellter Entwickler eines Systemhauses hat während der Arbeitszeit im Auftrag seines Arbeitgebers ein Inventarisierungstool geschrieben. Er kündigt und will das Tool künftig selbst an Kunden verkaufen.',
    prompt:
        'Erläutere, wem das Urheberrecht und wem die Nutzungsrechte an dem Tool zustehen, und beurteile das Vorhaben des Entwicklers.',
    kriterien: [
      krit(
        'Urheber ist und bleibt der Entwickler als natürliche Person; das Urheberrecht ist nicht übertragbar',
        punkte: 2,
        stichwoerter: [
          'Urheber bleibt',
          'natürliche Person',
          'nicht übertragbar',
          'Entwickler ist Urheber',
          'Schöpfer',
        ],
      ),
      krit(
        'Die vermögensrechtlichen Befugnisse (Nutzungs- und Verwertungsrechte) stehen ausschließlich dem Arbeitgeber zu (§ 69b UrhG)',
        punkte: 2,
        stichwoerter: [
          'Arbeitgeber',
          'Nutzungsrecht',
          'Verwertungsrecht',
          'ausschließlich',
          '69b',
        ],
      ),
      krit(
        'Der Entwickler darf das Tool deshalb ohne Zustimmung des Systemhauses nicht verkaufen',
        punkte: 2,
        stichwoerter: [
          'nicht verkaufen',
          'nicht erlaubt',
          'Zustimmung',
          'unzulässig',
          'darf nicht',
        ],
      ),
    ],
    loesung:
        'Urheber ist der Entwickler, denn Urheber kann nur der Mensch sein, der das Programm geschaffen hat; dieses Recht ist nicht übertragbar. Weil das Tool in Wahrnehmung seiner Aufgaben im Arbeitsverhältnis entstanden ist, stehen alle vermögensrechtlichen Befugnisse ausschließlich dem Arbeitgeber zu (§ 69b UrhG). Der Entwickler darf das Tool daher nicht ohne Zustimmung des Systemhauses verkaufen oder weiterverwenden.',
    explanation:
        'Je Aussage 2 Punkte, höchstens 4 Punkte. Typischer Fehler: „Der Arbeitgeber wird Urheber.“ Er erhält nur die Verwertungsrechte, allerdings vollständig.',
    punkte: 4,
  ),
  freitext(
    'i7-vu-4',
    'vt-urheber',
    scenario:
        'Eine Agentur vergleicht für ihr neues Ticketsystem ein Open-Source-Produkt mit einem proprietären Produkt.',
    prompt:
        'Nenne je zwei Vorteile von Open-Source-Software und von proprietärer Software.',
    kriterien: [
      krit(
        'Open Source: keine Lizenzkosten',
        stichwoerter: ['keine Lizenzkosten', 'kostenlos', 'lizenzfrei'],
      ),
      krit(
        'Open Source: Quellcode einsehbar und an eigene Bedürfnisse anpassbar',
        stichwoerter: [
          'Quellcode',
          'anpassbar',
          'einsehbar',
          'erweiterbar',
          'prüfbar',
        ],
      ),
      krit(
        'Open Source: keine Abhängigkeit von einem Hersteller',
        stichwoerter: [
          'unabhängig',
          'Herstellerbindung',
          'Lock-in',
          'Community',
        ],
      ),
      krit(
        'Proprietär: Support und Gewährleistung durch den Hersteller',
        stichwoerter: [
          'Support',
          'Gewährleistung',
          'Ansprechpartner',
          'Haftung',
        ],
      ),
      krit(
        'Proprietär: geregelte Updates und abgestimmte Integration in andere Produkte',
        stichwoerter: [
          'Updates',
          'Integration',
          'Kompatibilität',
          'Schulungen',
          'Dokumentation',
        ],
      ),
    ],
    loesung:
        'Open Source: keine Lizenzkosten, Quellcode einsehbar und anpassbar, keine Herstellerbindung. Proprietär: Support und Gewährleistung durch den Hersteller, geregelte Updates, gute Integration in andere Produkte des Herstellers.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Achtung: Auch Open-Source-Software hat Lizenzbedingungen, etwa die Copyleft-Pflicht der GPL. Kostenlos heißt nicht frei von Pflichten.',
    punkte: 4,
    difficulty: 1,
  ),

  // ================================================ Service Level Agreements
  tabelle(
    'i7-li-1',
    'sla-inhalte',
    scenario:
        'Eine Agentur prüft das Angebot eines Anbieters für ein gehostetes Ticketsystem. Der Vertrag enthält folgenden Auszug.',
    code:
        'SERVICE LEVEL AGREEMENT (excerpt)\n'
        'Service hours: Monday to Friday, 08:00-18:00\n'
        'Availability: 99.5 % per calendar month,\n'
        '  measured during service hours\n'
        'Response time: priority 1 within 30 minutes\n'
        'Resolution time: priority 1 within 4 hours\n'
        'All times are measured within service hours only.\n'
        'Scheduled maintenance: Saturdays, announced 5 days\n'
        '  in advance; not counted as downtime',
    prompt: 'Werte den Auszug aus und ergänze die Tabelle.',
    zeilen: [
      ['Frage', 'Antwort'],
      [
        'Servicezeit in einem Monat mit 20 Arbeitstagen (in Stunden)',
        zahl(200, einheit: 'h', rationale: '20 Tage × 10 h'),
      ],
      [
        'Höchstens zulässiger Ausfall in diesem Monat (in Minuten)',
        zahl(60, einheit: 'min', rationale: '200 h × 0,005 = 1 h'),
      ],
      [
        'Eine P1-Störung wird am Freitag um 17:45 Uhr gemeldet. Späteste Reaktion:',
        wahl(
          'Montag, 08:15 Uhr',
          ['Freitag, 18:15 Uhr', 'Montag, 08:30 Uhr', 'Samstag, 08:15 Uhr'],
          '15 Minuten am Freitag, die restlichen 15 Minuten ab Montag 08:00 Uhr.',
        ),
      ],
      [
        'Zählt eine angekündigte Wartung am Samstag als Ausfall?',
        wahl('nein', [
          'ja',
          'nur zur Hälfte',
        ], 'Geplante Wartung ist ausdrücklich ausgenommen.'),
      ],
      [
        'Bis wann muss eine P1-Störung von Dienstag, 15:00 Uhr behoben sein?',
        wahl(
          'Mittwoch, 09:00 Uhr',
          ['Dienstag, 19:00 Uhr', 'Dienstag, 15:30 Uhr', 'Mittwoch, 12:00 Uhr'],
          '3 Stunden am Dienstag bis 18:00 Uhr, die vierte Stunde am Mittwoch ab 08:00 Uhr.',
        ),
      ],
    ],
    explanation:
        'Servicezeit: 20 × 10 h = 200 h. Zulässiger Ausfall: 200 h × 0,5 % = 1 h = 60 min. Zeiten laufen nur in der Servicezeit: Von den 30 Minuten Reaktionszeit laufen 15 am Freitag (17:45 bis 18:00 Uhr) und 15 am Montag, also bis 08:15 Uhr. Bei der Lösungszeit sind 15:00 bis 18:00 Uhr 3 h, die vierte Stunde endet am Mittwoch um 09:00 Uhr. Angekündigte Wartung zählt nicht als Ausfall.',
    punkte: 5,
    difficulty: 3,
    tags: ['englisch'],
  ),
  tabelle(
    'i7-li-2',
    'sla-inhalte',
    scenario:
        'Ein Systemhaus vergleicht vier SLA-Angebote. Die Verfügbarkeit bezieht sich jeweils auf die Servicezeit eines Monats.',
    prompt:
        'Berechne für jedes Angebot die höchstens zulässige Ausfallzeit in Minuten.',
    zeilen: [
      ['Verfügbarkeit', 'Servicezeit im Monat', 'Zulässiger Ausfall'],
      [
        '99 %',
        '720 h (24/7)',
        zahl(432, einheit: 'min', rationale: '720 h × 0,01 = 7,2 h'),
      ],
      [
        '99,9 %',
        '720 h (24/7)',
        zahl(43.2, einheit: 'min', rationale: '720 h × 0,001 = 0,72 h'),
      ],
      [
        '98 %',
        '200 h (Mo-Fr, 8-18 Uhr)',
        zahl(240, einheit: 'min', rationale: '200 h × 0,02 = 4 h'),
      ],
      [
        '99,5 %',
        '200 h (Mo-Fr, 8-18 Uhr)',
        zahl(60, einheit: 'min', rationale: '200 h × 0,005 = 1 h'),
      ],
    ],
    explanation:
        'Zulässiger Ausfall = Servicezeit × (100 % − Verfügbarkeit). 720 h × 1 % = 7,2 h = 432 min. 720 h × 0,1 % = 0,72 h = 43,2 min. 200 h × 2 % = 4 h = 240 min. 200 h × 0,5 % = 1 h = 60 min. Die Prozentzahl allein sagt wenig. Entscheidend ist die Servicezeit, auf die sie sich bezieht.',
    punkte: 4,
  ),
  freitext(
    'i7-li-3',
    'sla-inhalte',
    scenario:
        'Ein Handelsunternehmen lagert den Betrieb seines Webshops an einen Dienstleister aus und will die Servicequalität vertraglich absichern.',
    prompt:
        'Nenne fünf Inhalte, die das Service Level Agreement regeln sollte.',
    kriterien: [
      krit(
        'Beschreibung des Service (Leistungsumfang)',
        stichwoerter: ['Leistungsumfang', 'Leistungsbeschreibung', 'Umfang'],
      ),
      krit(
        'Servicezeiten',
        stichwoerter: ['Servicezeit', 'Betriebszeit', 'Supportzeit', '24/7'],
      ),
      krit(
        'Verfügbarkeit in Prozent und Bezugszeitraum',
        stichwoerter: ['Verfügbarkeit', 'Uptime', 'Ausfallzeit'],
      ),
      krit(
        'Reaktionszeit je Priorität',
        stichwoerter: ['Reaktionszeit', 'Antwortzeit', 'Rückmeldung'],
      ),
      krit(
        'Lösungs- bzw. Wiederherstellungszeit',
        stichwoerter: [
          'Lösungszeit',
          'Wiederherstellungszeit',
          'Behebungszeit',
          'Entstörzeit',
        ],
      ),
      krit(
        'Prioritäten und Eskalationswege',
        stichwoerter: ['Priorität', 'Eskalation', 'Störungsklassen'],
      ),
      krit(
        'Messung und Reporting der Kennzahlen',
        stichwoerter: ['Reporting', 'Bericht', 'Messung', 'Kennzahlen'],
      ),
      krit(
        'Folgen bei Nichteinhaltung (Gutschrift, Vertragsstrafe)',
        stichwoerter: [
          'Vertragsstrafe',
          'Gutschrift',
          'Pönale',
          'Minderung',
          'Sanktion',
        ],
      ),
      krit(
        'Wartungsfenster und Mitwirkungspflichten des Kunden',
        stichwoerter: [
          'Wartungsfenster',
          'Wartung',
          'Mitwirkung',
          'Ansprechpartner',
        ],
      ),
    ],
    loesung:
        'Leistungsbeschreibung, Servicezeiten, Verfügbarkeit mit Bezugszeitraum, Reaktions- und Lösungszeiten je Priorität, Eskalationswege, Messverfahren und Reporting, Folgen bei Nichteinhaltung (Gutschrift oder Vertragsstrafe), Wartungsfenster, Mitwirkungspflichten des Kunden.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 5 Punkte. Entscheidend ist, dass jede Zusage messbar ist. „Schnell“ oder „möglichst immer“ lässt sich später nicht prüfen.',
    punkte: 5,
    difficulty: 1,
  ),
  markieren(
    'i7-li-4',
    'sla-inhalte',
    scenario:
        'Ein Dienstleister legt den Entwurf eines SLA vor. Mehrere Regelungen sind so formuliert, dass sie sich später nicht prüfen lassen.',
    prompt: 'Markiere alle Regelungen, die nicht messbar formuliert sind.',
    zeilen: [
      ja(
        'Der Dienst steht dem Kunden möglichst durchgehend zur Verfügung.',
        '„Möglichst“ ist kein Wert. Es fehlen Prozentzahl und Bezugszeitraum.',
      ),
      nein(
        'Servicezeit: Montag bis Freitag, 7 bis 19 Uhr',
        'Eindeutig und prüfbar.',
      ),
      ja(
        'Störungen werden zeitnah bearbeitet.',
        '„Zeitnah“ ist nicht messbar. Nötig sind Reaktions- und Lösungszeiten je Priorität.',
      ),
      nein(
        'Priorität 1: Reaktion innerhalb von 30 Minuten',
        'Konkreter Zeitwert mit Bezug zur Priorität.',
      ),
      ja(
        'Bei Unterschreitung der Verfügbarkeit bemüht sich der Anbieter um eine kulante Lösung.',
        'Keine konkrete Folge. Eine Gutschrift in Prozent wäre prüfbar.',
      ),
      nein(
        'Der Anbieter berichtet bis zum 5. Werktag des Folgemonats über die erreichte Verfügbarkeit.',
        'Inhalt und Termin des Reportings sind klar geregelt.',
      ),
    ],
    explanation:
        'Ein SLA macht Servicequalität messbar. Jede Zusage braucht eine Kennzahl, einen Zielwert und einen Bezugszeitraum, dazu eine konkrete Folge bei Verfehlung. Formulierungen wie „möglichst“, „zeitnah“ oder „kulant“ sind nicht einklagbar.',
    punkte: 3,
  ),
  lueckentext(
    'i7-li-5',
    'sla-inhalte',
    scenario:
        'Der Hosting-Vertrag eines Webshops sichert 99,5 % Verfügbarkeit im Monat bei 24/7-Betrieb zu. Im April (30 Tage) gab es zwei Ausfälle von 3 Stunden und von 4,2 Stunden.',
    prompt: 'Berechne Schritt für Schritt die erreichte Verfügbarkeit.',
    text:
        'Servicezeit im April: {0} h\n'
        'Ausfallzeit gesamt: {1} h\n'
        'Verfügbare Zeit: {2} h\n'
        'Erreichte Verfügbarkeit: {3} %\n'
        'Die zugesagte Verfügbarkeit wurde {4}.',
    luecken: [
      zahl(720, rationale: '30 Tage × 24 h'),
      zahl(7.2, rationale: '3 h + 4,2 h'),
      zahl(712.8, rationale: '720 h − 7,2 h'),
      zahl(99, rationale: '712,8 / 720 = 0,99'),
      wahl('verfehlt', [
        'eingehalten',
        'übertroffen',
      ], '99 % liegt unter den zugesagten 99,5 %.'),
    ],
    mono: true,
    explanation:
        'Servicezeit: 30 × 24 h = 720 h. Ausfall: 3 h + 4,2 h = 7,2 h. Verfügbar: 720 h − 7,2 h = 712,8 h. Verfügbarkeit = 712,8 / 720 × 100 % = 99 %. Zugesagt waren 99,5 % (höchstens 3,6 h Ausfall). Das SLA ist verfehlt.',
    punkte: 5,
  ),

  // ============================================ Support-Level und Eskalation
  paare(
    'i7-ls-1',
    'sla-support',
    prompt: 'Verbinde jedes Support-Level mit seiner Aufgabe.',
    paare: [
      paar('Level 0', 'Selbsthilfe über FAQ und Portal'),
      paar('1st Level', 'Tickets annehmen, Standardfälle lösen'),
      paar('2nd Level', 'Fachspezialisten analysieren den Fall'),
      paar('3rd Level', 'Hersteller ändert das Produkt'),
    ],
    explanation:
        'Level 0: Self-Service. 1st Level: Service Desk als erster Kontakt. 2nd Level: Spezialisten im eigenen Haus. 3rd Level: Hersteller oder Entwicklung, wenn das Produkt selbst geändert werden muss.',
    difficulty: 1,
  ),
  tabelle(
    'i7-ls-2',
    'sla-support',
    scenario:
        'Der Service Desk eines Logistikunternehmens stuft Störungen so ein: Auswirkung hoch = ganzer Standort, mittel = eine Abteilung, niedrig = einzelne Person. Dringlichkeit hoch = die Arbeit steht still, mittel = Frist in den nächsten Tagen, niedrig = es gibt eine Ausweichmöglichkeit.',
    table: [
      ['Auswirkung', 'dringend: hoch', 'mittel', 'niedrig'],
      ['hoch', 'P1', 'P2', 'P3'],
      ['mittel', 'P2', 'P3', 'P4'],
      ['niedrig', 'P3', 'P4', 'P5'],
    ],
    prompt:
        'Bestimme für jedes Ticket Auswirkung, Dringlichkeit und Priorität.',
    zeilen: [
      ['Ticket', 'Auswirkung', 'Dringlichkeit', 'Priorität'],
      [
        'Das WLAN im gesamten Lager ist ausgefallen, alle Handscanner sind offline, Lkw warten.',
        wahl('hoch', ['mittel', 'niedrig']),
        wahl('hoch', ['mittel', 'niedrig']),
        wahl('P1', ['P2', 'P3', 'P4', 'P5']),
      ],
      [
        'Ein Disponent kann nicht drucken; der Drucker im Nachbarbüro funktioniert.',
        wahl('niedrig', ['mittel', 'hoch']),
        wahl('niedrig', ['mittel', 'hoch']),
        wahl('P5', ['P1', 'P2', 'P3', 'P4']),
      ],
      [
        'Die Buchhaltung (6 Personen) kommt nicht ins ERP-System und kann nicht arbeiten.',
        wahl('mittel', ['hoch', 'niedrig']),
        wahl('hoch', ['mittel', 'niedrig']),
        wahl('P2', ['P1', 'P3', 'P4', 'P5']),
      ],
      [
        'Das Notebook einer Außendienstlerin startet nicht; sie kann nicht arbeiten, ein Ersatzgerät gibt es nicht.',
        wahl('niedrig', ['mittel', 'hoch']),
        wahl('hoch', ['mittel', 'niedrig']),
        wahl('P3', ['P1', 'P2', 'P4', 'P5']),
      ],
    ],
    explanation:
        'Auswirkung fragt, wie viele betroffen sind, Dringlichkeit, wie schnell es gehen muss. Lager-WLAN: hoch/hoch = P1. Drucker: niedrig/niedrig = P5. Buchhaltung: mittel/hoch = P2. Notebook: niedrig/hoch = P3. Die Priorität wird aus der Matrix abgelesen, nicht nach Gefühl vergeben.',
    punkte: 6,
  ),
  freitext(
    'i7-ls-3',
    'sla-support',
    scenario:
        'Im Service Desk eines Systemhauses bleibt ein Ticket der Priorität 1 liegen, weil dem 1st Level das Fachwissen fehlt und die Lösungszeit abzulaufen droht.',
    prompt:
        'Erläutere den Unterschied zwischen funktionaler und hierarchischer Eskalation.',
    kriterien: [
      krit(
        'Funktionale Eskalation: Weitergabe an ein höheres Support-Level bzw. an Spezialisten mit mehr Fachwissen',
        punkte: 2,
        stichwoerter: [
          'Fachwissen',
          '2nd Level',
          'Spezialisten',
          'höheres Level',
          'Hersteller',
        ],
      ),
      krit(
        'Hierarchische Eskalation: Einschalten der Führungsebene, die entscheiden und Ressourcen bereitstellen kann',
        punkte: 2,
        stichwoerter: [
          'Führung',
          'Teamleitung',
          'Vorgesetzte',
          'Management',
          'Ressourcen',
          'Entscheidung',
        ],
      ),
    ],
    loesung:
        'Bei der funktionalen Eskalation wandert das Ticket an ein höheres Support-Level mit mehr Fachwissen, etwa vom 1st Level an den 2nd Level oder an den Hersteller. Bei der hierarchischen Eskalation wird die Führungsebene eingeschaltet, zum Beispiel die Teamleitung, weil eine Frist zu reißen droht und über Prioritäten oder zusätzliche Ressourcen entschieden werden muss.',
    explanation:
        'Je Erläuterung 2 Punkte. In der Situation ist beides nötig: funktional, weil Fachwissen fehlt, hierarchisch, weil die Lösungszeit gefährdet ist. Das Ticket bleibt dabei offen und behält seine Historie.',
    punkte: 4,
  ),
  lueckentext(
    'i7-ls-4',
    'sla-support',
    scenario:
        'Der Monatsbericht des Service Desks nennt folgende Zahlen. Das SLA verlangt, dass 95 % der Tickets in der vereinbarten Lösungszeit gelöst werden.',
    table: [
      ['Kennzahl', 'Wert'],
      ['Tickets gesamt', '1.200'],
      ['im 1st Level gelöst', '780'],
      ['in der Lösungszeit gelöst', '1.080'],
    ],
    prompt: 'Berechne die Kennzahlen des Service Desks.',
    text:
        'Erstlösungsquote: {0} %\n'
        'SLA-Erfüllungsquote: {1} %\n'
        'Für 95 % nötige Tickets: {2}\n'
        'Zum Ziel fehlen: {3} Tickets',
    luecken: [
      zahl(65, rationale: '780 / 1.200'),
      zahl(90, rationale: '1.080 / 1.200'),
      zahl(1140, rationale: '1.200 × 0,95'),
      zahl(60, rationale: '1.140 − 1.080'),
    ],
    mono: true,
    explanation:
        'Erstlösungsquote = 780 / 1.200 × 100 % = 65 %. SLA-Erfüllungsquote = 1.080 / 1.200 × 100 % = 90 %. Für 95 % müssten 1.200 × 0,95 = 1.140 Tickets fristgerecht gelöst sein; es fehlen 1.140 − 1.080 = 60 Tickets.',
    punkte: 4,
  ),
  markieren(
    'i7-ls-5',
    'sla-support',
    scenario: 'Der Verlauf eines Tickets im Service Desk wird ausgewertet.',
    prompt:
        'Markiere alle Einträge, die gegen die Regeln eines mehrstufigen Supports verstoßen.',
    zeilen: [
      nein(
        '09:02 Ticket angelegt, Kategorie Netzwerk, Priorität 2',
        'Erfassen, kategorisieren und priorisieren ist Aufgabe des 1st Level.',
      ),
      nein(
        '09:10 1st Level prüft die Wissensdatenbank: keine Lösung',
        'Richtig, zuerst werden bekannte Lösungen geprüft.',
      ),
      ja(
        '09:15 Ticket geschlossen; Anwender soll sich neu beim 2nd Level melden',
        'Ein ungelöstes Ticket wird nie geschlossen, sondern mit seiner Historie weitergegeben.',
      ),
      ja(
        '09:40 2nd Level fragt alle Angaben neu ab; im Ticket steht nichts',
        'Die bisherigen Schritte hätten dokumentiert werden müssen.',
      ),
      nein(
        '10:30 2nd Level findet defekten Switch-Port und patcht um',
        'Fachliche Analyse und Lösung im 2nd Level.',
      ),
      ja(
        '10:35 Ticket geschlossen, ohne Rückmeldung des Anwenders',
        'Geschlossen wird erst, wenn der Anwender die Lösung bestätigt hat.',
      ),
    ],
    mono: true,
    explanation:
        'Beim Eskalieren bleibt das Ticket offen und wandert mit vollständiger Dokumentation weiter. Jeder Schritt wird im Ticket festgehalten, damit niemand doppelt fragt. Geschlossen wird erst nach bestätigter Lösung.',
    punkte: 3,
  ),

  // ============================================= Incident, Problem, Change
  tabelle(
    'i7-lt-1',
    'sla-itil',
    scenario:
        'In der IT-Abteilung eines Onlinehändlers gehen an einem Tag vier Vorgänge ein.',
    prompt: 'Ordne jedem Vorgang den ITIL-Begriff und das Ziel zu.',
    zeilen: [
      ['Vorgang', 'ITIL-Begriff', 'Ziel'],
      [
        'Der Webshop ist seit zehn Minuten nicht erreichbar.',
        wahl('Incident', ['Problem', 'Change', 'Service Request']),
        wahl('Service schnell wiederherstellen', [
          'Ursache dauerhaft beseitigen',
          'Änderung kontrolliert umsetzen',
          'Standardanfrage erfüllen',
        ]),
      ],
      [
        'Der Webshop fällt seit Wochen jeden Montagmorgen aus.',
        wahl('Problem', ['Incident', 'Change', 'Service Request']),
        wahl('Ursache dauerhaft beseitigen', [
          'Service schnell wiederherstellen',
          'Änderung kontrolliert umsetzen',
          'Standardanfrage erfüllen',
        ]),
      ],
      [
        'Der Webserver soll ein neues Betriebssystem erhalten.',
        wahl('Change', ['Incident', 'Problem', 'Service Request']),
        wahl('Änderung kontrolliert umsetzen', [
          'Service schnell wiederherstellen',
          'Ursache dauerhaft beseitigen',
          'Standardanfrage erfüllen',
        ]),
      ],
      [
        'Eine neue Kollegin braucht Zugriff auf das Shop-Backend.',
        wahl('Service Request', ['Incident', 'Problem', 'Change']),
        wahl('Standardanfrage erfüllen', [
          'Service schnell wiederherstellen',
          'Ursache dauerhaft beseitigen',
          'Änderung kontrolliert umsetzen',
        ]),
      ],
    ],
    explanation:
        'Ein Incident ist eine Störung, das Ziel ist die schnelle Wiederherstellung. Ein Problem ist die Ursache hinter (wiederkehrenden) Störungen. Ein Change ist eine geplante Änderung, die bewertet und genehmigt wird. Ein Service Request ist eine Standardanfrage, bei der nichts kaputt ist.',
    punkte: 4,
  ),
  freitext(
    'i7-lt-2',
    'sla-itil',
    scenario:
        'Die Scanner-App im Lager stürzt mehrmals täglich ab. Der Service Desk startet sie jedes Mal neu. Die Lagerleitung fragt, warum „die IT das Problem nicht endlich löst“.',
    prompt:
        'Erläutere den Unterschied zwischen Incident Management und Problem Management.',
    kriterien: [
      krit(
        'Incident Management stellt den Service so schnell wie möglich wieder her, auch mit einem Workaround',
        punkte: 2,
        stichwoerter: [
          'wiederherstellen',
          'schnell',
          'Workaround',
          'Störung beheben',
          'Neustart',
        ],
      ),
      krit(
        'Problem Management sucht und beseitigt die Ursache, damit die Störung nicht wieder auftritt',
        punkte: 2,
        stichwoerter: [
          'Ursache',
          'dauerhaft',
          'Known Error',
          'nicht wieder',
          'Analyse',
        ],
      ),
    ],
    loesung:
        'Das Incident Management soll den Service so schnell wie möglich wiederherstellen, hier durch den Neustart der App als Workaround. Die Ursache bleibt dabei bestehen. Das Problem Management untersucht, warum die App abstürzt, dokumentiert die Ursache als Known Error und sorgt für eine dauerhafte Lösung, die als Change eingeführt wird.',
    explanation:
        'Je Erläuterung 2 Punkte. Merkhilfe: Incident = Symptom schnell beheben, Problem = Ursache finden. Gehäufte gleichartige Incidents sind der typische Anlass, ein Problem zu eröffnen.',
    punkte: 4,
  ),
  reihenfolge(
    'i7-lt-3',
    'sla-itil',
    scenario:
        'Die Firewall eines Unternehmens soll durch ein neues Modell ersetzt werden (Normal Change).',
    prompt: 'Bringe die Schritte des Change in die richtige Reihenfolge.',
    items: [
      'Change-Antrag (Request for Change) erfassen',
      'Auswirkungen und Risiken bewerten',
      'Genehmigung durch die Change Authority, z. B. das CAB',
      'Umsetzung mit Termin und Rückfallplan planen',
      'Change im Wartungsfenster umsetzen und testen',
      'Ergebnis prüfen, dokumentieren und Change abschließen',
    ],
    explanation:
        'Ein Normal Change wird erst beantragt und bewertet, dann genehmigt. Erst danach wird die Umsetzung geplant, mit Rückfallplan für den Fall, dass etwas schiefgeht, und durchgeführt. Am Ende steht die Überprüfung, ob das Ziel erreicht wurde.',
    punkte: 3,
  ),
  lueckentext(
    'i7-lt-4',
    'sla-itil',
    scenario:
        'Der Mailserver einer Agentur hängt sich immer wieder auf. Die Administratoren stellen fest, dass ein fehlerhaftes Update die Ursache ist, und spielen in der Nacht zum Samstag einen Patch ein.',
    prompt: 'Ergänze den Text mit den passenden ITIL-Begriffen.',
    text:
        'Jeder einzelne Ausfall des Mailservers ist ein {0}. Der Neustart, der den Betrieb vorläufig sichert, ist ein {1}. Die Suche nach der Ursache der gehäuften Ausfälle ist Aufgabe des {2}. Die erkannte und dokumentierte Ursache heißt {3}. Das geplante Einspielen des Patches ist ein {4}.',
    luecken: [
      wort(['Incident']),
      wort(['Workaround']),
      wort(['Problem Managements', 'Problem Management']),
      wort(['Known Error']),
      wort(['Change']),
    ],
    wortbank: ['Service Request', 'Event', 'Service Desks', 'SLA'],
    explanation:
        'Incident = einzelne Störung. Workaround = vorläufige Umgehung ohne Ursachenbeseitigung. Problem Management = Ursachenforschung. Known Error = Problem mit bekannter, dokumentierter Ursache. Change = kontrollierte Änderung, hier der Patch.',
    punkte: 5,
  ),

  // ================================================================== Verzug
  lueckentext(
    'i7-gv-1',
    'ls-verzug',
    prompt: 'Ergänze das Prüfschema für den Lieferungsverzug.',
    text:
        'Lieferungsverzug setzt voraus: Die Leistung ist {0}, der Schuldner liefert trotz {1} nicht, und er hat die Verspätung zu {2}. Die Mahnung ist entbehrlich, wenn der Liefertermin nach dem {3} bestimmt ist oder der Schuldner die Lieferung ernsthaft und endgültig {4}. Will der Käufer vom Vertrag zurücktreten, muss er grundsätzlich zuerst eine angemessene {5} setzen.',
    luecken: [
      wort(['fällig']),
      wort(['Mahnung']),
      wort(['vertreten']),
      wort(['Kalender']),
      wort(['verweigert']),
      wort(['Nachfrist']),
    ],
    wortbank: ['Abnahme', 'Skonto', 'gekündigt', 'Rüge'],
    explanation:
        'Verzug (§ 286 BGB): Fälligkeit, Mahnung (oder Entbehrlichkeit) und Vertretenmüssen. Entbehrlich ist die Mahnung vor allem beim Kalendertermin und bei endgültiger Verweigerung. Rücktritt (§ 323 BGB) und Schadensersatz statt der Leistung (§ 281 BGB) verlangen zusätzlich eine erfolglose Nachfrist.',
    punkte: 4,
  ),
  freitext(
    'i7-gv-2',
    'ls-verzug',
    scenario:
        'Ein Systemhaus hat bei einem Distributor 18 Notebooks bestellt. In der Auftragsbestätigung ist der 2. März als Liefertermin zugesagt. Am 4. März trifft folgende E-Mail ein.',
    code:
        'Subject: Delay of your order no. 4417\n\n'
        'Dear customer,\n'
        'we regret to inform you that the 18 notebooks you\n'
        'ordered could not be shipped on 2 March as confirmed.\n'
        'Our own supplier has not delivered the devices to us\n'
        'yet. We expect to ship in about four weeks.\n'
        'We apologise for the inconvenience.\n\n'
        'Kind regards\n'
        'NordBit Distribution',
    prompt:
        'Erläutere anhand der E-Mail, ob sich der Distributor im Lieferungsverzug befindet, und beschreibe zwei Rechte des Systemhauses.',
    kriterien: [
      krit(
        'Verzug liegt vor: Der Termin 2. März ist nach dem Kalender bestimmt, eine Mahnung ist deshalb nicht nötig',
        punkte: 2,
        stichwoerter: [
          'Kalender',
          'ohne Mahnung',
          'keine Mahnung',
          'fester Termin',
          'Mahnung entbehrlich',
        ],
      ),
      krit(
        'Der Distributor hat die Verspätung zu vertreten; dass sein Vorlieferant nicht liefert, entlastet ihn nicht',
        punkte: 2,
        stichwoerter: [
          'vertreten',
          'Verschulden',
          'Vorlieferant',
          'Beschaffungsrisiko',
          'entlastet nicht',
        ],
      ),
      krit(
        'Recht: weiter auf Lieferung bestehen und Ersatz des Verzögerungsschadens verlangen (z. B. Kosten für Leihgeräte)',
        punkte: 2,
        stichwoerter: [
          'Lieferung bestehen',
          'Verzögerungsschaden',
          'Verzugsschaden',
          'Leihgeräte',
          'Erfüllung',
        ],
      ),
      krit(
        'Recht: angemessene Nachfrist setzen und nach erfolglosem Ablauf vom Vertrag zurücktreten',
        punkte: 2,
        stichwoerter: ['Nachfrist', 'Rücktritt', 'zurücktreten'],
      ),
      krit(
        'Recht: nach erfolgloser Nachfrist Schadensersatz statt der Leistung verlangen (z. B. Mehrkosten eines Deckungskaufs)',
        punkte: 2,
        stichwoerter: [
          'Schadensersatz statt',
          'Deckungskauf',
          'Mehrkosten',
          'Ersatzkauf',
        ],
      ),
    ],
    loesung:
        'Der Distributor ist in Verzug: Die Lieferung war am 2. März fällig, der Termin ist kalendermäßig bestimmt, also braucht es keine Mahnung (§ 286 Abs. 2 Nr. 1 BGB). Dass der eigene Lieferant nicht geliefert hat, entlastet ihn in der Regel nicht, denn er trägt das Beschaffungsrisiko. Das Systemhaus kann weiter auf Lieferung bestehen und Ersatz des Verzögerungsschadens verlangen, etwa die Kosten für Leihgeräte. Es kann außerdem eine angemessene Nachfrist setzen und nach deren erfolglosem Ablauf zurücktreten und Schadensersatz statt der Leistung verlangen, etwa die Mehrkosten eines Deckungskaufs.',
    explanation:
        'Prüfung des Verzugs bis zu 2 Punkte, je beschriebenes Recht 2 Punkte, höchstens 6 Punkte. Die angekündigten „four weeks“ ändern am Verzug nichts. Sie sind nur eine Information.',
    punkte: 6,
    difficulty: 3,
    tags: ['englisch'],
  ),
  lueckentext(
    'i7-gv-3',
    'ls-verzug',
    scenario:
        'Ein Systemhaus hat einem Handwerksbetrieb 7.300 € in Rechnung gestellt. Der Betrieb ist seit 60 Tagen im Zahlungsverzug. Nimm für diese Aufgabe einen Basiszinssatz von 2 % an und rechne mit 365 Tagen im Jahr.',
    prompt: 'Berechne die Forderungen aus dem Zahlungsverzug.',
    text:
        'Aufschlag unter Unternehmen: {0} Prozentpunkte\n'
        'Verzugszinssatz: {1} %\n'
        'Zinsen für ein ganzes Jahr: {2} €\n'
        'Zinsen für 60 Tage: {3} €\n'
        'Verzugspauschale: {4} €\n'
        'Zinsen und Pauschale zusammen: {5} €',
    luecken: [
      zahl(9, rationale: '§ 288 Abs. 2 BGB: kein Verbraucher beteiligt'),
      zahl(11, rationale: '2 % + 9 Prozentpunkte'),
      zahl(803, rationale: '7.300 € × 0,11'),
      zahl(132, rationale: '803 € × 60 / 365'),
      zahl(40, rationale: '§ 288 Abs. 5 BGB'),
      zahl(172, rationale: '132 € + 40 €'),
    ],
    mono: true,
    explanation:
        'Unter Unternehmen: Basiszinssatz + 9 Prozentpunkte = 2 % + 9 = 11 %. Jahreszinsen: 7.300 € × 0,11 = 803 €. Für 60 Tage: 803 € × 60 / 365 = 132 €. Dazu die Pauschale von 40 €: 132 € + 40 € = 172 €. Wäre der Schuldner ein Verbraucher, wären es nur 5 Prozentpunkte und keine Pauschale.',
    punkte: 6,
  ),
  markieren(
    'i7-gv-4',
    'ls-verzug',
    scenario:
        'Ein Handwerksbetrieb (Unternehmer) hat eine Rechnung über 4.800 € nicht bezahlt. Im Vertrag ist als Zahlungstermin der 16. Mai vereinbart, heute ist der 30. Mai. Ein Auszubildender hat eine Mahnung entworfen.',
    prompt:
        'Markiere alle Sätze der Mahnung, die fachlich falsch oder ungeeignet sind.',
    zeilen: [
      nein(
        'Zu unserer Rechnung Nr. 2291 über 4.800,00 € konnten wir noch keinen Zahlungseingang feststellen.',
        'Rechnung und Betrag sind eindeutig benannt.',
      ),
      ja(
        'Bitte überweisen Sie den Betrag irgendwann in den nächsten Wochen.',
        'Eine Mahnung muss eindeutig zur Zahlung auffordern und sollte ein konkretes Datum nennen.',
      ),
      ja(
        'Da Sie Verbraucher sind, berechnen wir Verzugszinsen von 9 Prozentpunkten über dem Basiszinssatz.',
        'Der Kunde ist Unternehmer. Die 9 Prozentpunkte gelten gerade, wenn kein Verbraucher beteiligt ist; bei Verbrauchern wären es 5.',
      ),
      nein(
        'Zusätzlich berechnen wir die Verzugspauschale von 40,00 €.',
        'Unter Unternehmern zulässig (§ 288 Abs. 5 BGB).',
      ),
      ja(
        'Verzug tritt erst nach unserer dritten Mahnung ein.',
        'Falsch: Der Zahlungstermin ist nach dem Kalender bestimmt, der Kunde ist seit dem 17. Mai in Verzug.',
      ),
      nein(
        'Sollten Sie inzwischen gezahlt haben, betrachten Sie dieses Schreiben bitte als gegenstandslos.',
        'Üblicher und sinnvoller Schlusssatz.',
      ),
    ],
    explanation:
        'Bei einem vertraglich vereinbarten Kalendertermin tritt Verzug ohne Mahnung ein, hier ab dem 17. Mai. Unter Unternehmern betragen die Verzugszinsen 9 Prozentpunkte über dem Basiszinssatz, dazu kommt die Pauschale von 40 €. Eine Mahnung fordert bestimmt und mit Datum zur Zahlung auf.',
    punkte: 3,
  ),
  reihenfolge(
    'i7-gv-5',
    'ls-verzug',
    scenario:
        'Ein Kunde zahlt eine fällige Rechnung nicht. Das Systemhaus will die Forderung durchsetzen.',
    prompt: 'Bringe die Schritte in die übliche Reihenfolge.',
    items: [
      'Freundliche Zahlungserinnerung schicken',
      'Mahnung mit konkreter Zahlungsfrist schicken',
      'Mahnbescheid beim Mahngericht beantragen',
      'Kunde legt keinen Widerspruch ein',
      'Vollstreckungsbescheid beantragen',
      'Zwangsvollstreckung, z. B. durch den Gerichtsvollzieher',
    ],
    explanation:
        'Erst außergerichtlich erinnern und mahnen, dann das gerichtliche Mahnverfahren: Mahnbescheid, bei ausbleibendem Widerspruch Vollstreckungsbescheid, zuletzt Zwangsvollstreckung. Rechtlich nötig ist höchstens eine Mahnung. Mehrere Mahnstufen sind nur kaufmännische Übung.',
    punkte: 3,
  ),
  tabelle(
    'i7-gv-6',
    'ls-verzug',
    scenario:
        'Fünf Lieferungen sind nicht zum erwarteten Zeitpunkt eingetroffen.',
    prompt:
        'Entscheide für jeden Fall, ob der Lieferant ohne Mahnung in Verzug gerät.',
    zeilen: [
      ['Fall', 'Beurteilung'],
      [
        'Vereinbart ist „Lieferung am 12. Mai“. Am 13. Mai ist nichts da.',
        wahl(
          'Verzug ohne Mahnung',
          ['Verzug erst nach Mahnung', 'kein Verzug (nicht zu vertreten)'],
          'Termin nach dem Kalender bestimmt (§ 286 Abs. 2 Nr. 1 BGB).',
        ),
      ],
      [
        'Vereinbart ist „Lieferung so bald wie möglich“.',
        wahl(
          'Verzug erst nach Mahnung',
          ['Verzug ohne Mahnung', 'kein Verzug (nicht zu vertreten)'],
          'Es gibt keinen bestimmten Termin, der Käufer muss also mahnen.',
        ),
      ],
      [
        'Der Lieferant schreibt: „Wir werden endgültig nicht liefern.“',
        wahl(
          'Verzug ohne Mahnung',
          ['Verzug erst nach Mahnung', 'kein Verzug (nicht zu vertreten)'],
          'Ernsthafte und endgültige Verweigerung (§ 286 Abs. 2 Nr. 3 BGB).',
        ),
      ],
      [
        'Vereinbart ist „Lieferung 10 Tage nach Abruf“. Abruf war am 3. Juni, am 14. Juni ist nichts da.',
        wahl(
          'Verzug ohne Mahnung',
          ['Verzug erst nach Mahnung', 'kein Verzug (nicht zu vertreten)'],
          'Die Frist lässt sich ab dem Abruf nach dem Kalender berechnen (§ 286 Abs. 2 Nr. 2 BGB).',
        ),
      ],
      [
        'Termin 12. Mai; ein unvorhersehbares Hochwasser sperrt das Lager des Lieferanten.',
        wahl(
          'kein Verzug (nicht zu vertreten)',
          ['Verzug ohne Mahnung', 'Verzug erst nach Mahnung'],
          'Ohne Vertretenmüssen kein Verzug (§ 286 Abs. 4 BGB).',
        ),
      ],
    ],
    explanation:
        'Die Mahnung ist entbehrlich bei einem Kalendertermin, bei einer ab einem Ereignis berechenbaren Frist und bei endgültiger Verweigerung. Ohne bestimmten Termin muss gemahnt werden. Hat der Schuldner die Verspätung nicht zu vertreten, etwa bei höherer Gewalt, gerät er gar nicht in Verzug.',
    punkte: 5,
    difficulty: 3,
  ),

  // ================================================ Mängel und Gewährleistung
  paare(
    'i7-gm-1',
    'ls-maengel',
    prompt: 'Verbinde jedes Recht des Käufers mit der passenden Voraussetzung.',
    paare: [
      paar('Nacherfüllung', 'Mangel bei Übergabe, sonst nichts'),
      paar('Rücktritt', 'Frist erfolglos, Mangel nicht unerheblich'),
      paar('Minderung', 'Frist erfolglos, auch bei kleinem Mangel'),
      paar('Schadensersatz', 'zusätzlich Verschulden des Verkäufers'),
      paar('Garantieanspruch', 'freiwillige Zusage, meist vom Hersteller'),
    ],
    explanation:
        'Die Nacherfüllung hat Vorrang und setzt nur den Mangel bei Gefahrübergang voraus. Rücktritt und Minderung verlangen grundsätzlich eine erfolglose Frist; der Rücktritt scheidet bei unerheblichen Mängeln aus. Schadensersatz setzt Verschulden voraus. Die Garantie ist freiwillig und steht neben der Gewährleistung.',
    punkte: 3,
  ),
  freitext(
    'i7-gm-2',
    'ls-maengel',
    scenario:
        'Ein Handelsunternehmen hat bei einem Lieferanten 20 Notebooks gekauft. Bei der Wareneingangsprüfung zeigen drei Geräte Pixelfehler im Display.',
    prompt:
        'Nenne vier Rechte, die einem Käufer bei einem Sachmangel nach § 437 BGB zustehen können.',
    kriterien: [
      krit(
        'Nacherfüllung: Nachbesserung (Reparatur)',
        stichwoerter: [
          'Nachbesserung',
          'Reparatur',
          'Nacherfüllung',
          'reparieren',
        ],
      ),
      krit(
        'Nacherfüllung: Ersatzlieferung (Neulieferung)',
        stichwoerter: [
          'Ersatzlieferung',
          'Neulieferung',
          'Austausch',
          'Umtausch',
        ],
      ),
      krit(
        'Rücktritt vom Kaufvertrag',
        stichwoerter: ['Rücktritt', 'zurücktreten', 'Vertrag auflösen'],
      ),
      krit(
        'Minderung des Kaufpreises',
        stichwoerter: ['Minderung', 'mindern', 'Preisnachlass'],
      ),
      krit(
        'Schadensersatz (bei Verschulden des Verkäufers)',
        stichwoerter: [
          'Schadensersatz',
          'Schadenersatz',
          'Ersatz des Schadens',
        ],
      ),
      krit(
        'Ersatz vergeblicher Aufwendungen',
        stichwoerter: [
          'Aufwendungen',
          'Aufwendungsersatz',
          'vergebliche Kosten',
        ],
      ),
    ],
    loesung:
        'Nacherfüllung als Nachbesserung oder Ersatzlieferung (§ 439 BGB), Rücktritt vom Vertrag, Minderung des Kaufpreises, Schadensersatz oder Ersatz vergeblicher Aufwendungen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Vorrang hat die Nacherfüllung; Rücktritt, Minderung und Schadensersatz statt der Leistung kommen grundsätzlich erst nach erfolgloser Frist in Betracht. Unter Kaufleuten muss der Mangel außerdem unverzüglich gerügt werden (§ 377 HGB).',
    punkte: 4,
    difficulty: 1,
  ),
  tabelle(
    'i7-gm-3',
    'ls-maengel',
    prompt: 'Ordne jedem Sachverhalt die richtige Frist zu.',
    zeilen: [
      ['Sachverhalt', 'Frist'],
      [
        'Verjährung der Mängelansprüche beim Kauf einer neuen beweglichen Sache',
        wahl('2 Jahre', [
          '6 Monate',
          '1 Jahr',
          '3 Jahre',
        ], '§ 438 Abs. 1 Nr. 3 BGB, ab Ablieferung.'),
      ],
      [
        'Beweislastumkehr zugunsten des Verbrauchers beim Verbrauchsgüterkauf',
        wahl('1 Jahr', [
          '6 Monate',
          '2 Jahre',
          '14 Tage',
        ], '§ 477 BGB: seit 2022 ein Jahr.'),
      ],
      [
        'Rüge eines offenen Mangels unter Kaufleuten',
        wahl('unverzüglich', [
          'innerhalb von 14 Tagen',
          'innerhalb von 2 Jahren',
          'innerhalb von 30 Tagen',
        ], '§ 377 HGB. Sonst gilt die Ware als genehmigt.'),
      ],
      [
        'Verjährung, wenn der Verkäufer den Mangel arglistig verschwiegen hat',
        wahl('3 Jahre', [
          '2 Jahre',
          '1 Jahr',
          '6 Monate',
        ], 'Regelmäßige Verjährungsfrist (§ 438 Abs. 3, § 195 BGB).'),
      ],
    ],
    explanation:
        'Gewährleistung für neue Sachen: 2 Jahre ab Ablieferung. Beweislastumkehr beim Verbrauchsgüterkauf: 1 Jahr. Unter Kaufleuten wird unverzüglich geprüft und gerügt. Bei Arglist gilt die regelmäßige Verjährung von 3 Jahren.',
    punkte: 4,
  ),
  lueckentext(
    'i7-gm-4',
    'ls-maengel',
    scenario:
        'Ein Büro hat einen Farblaserdrucker zum Sonderpreis von 1.800 € gekauft. Ein Mangel lässt sich nicht beheben. Ohne Mangel wäre der Drucker 2.000 € wert, mit Mangel 1.500 €. Der Käufer mindert.',
    prompt: 'Berechne die Minderung nach § 441 Abs. 3 BGB.',
    text:
        'Wertverhältnis (mit Mangel / ohne Mangel): {0}\n'
        'Geminderter Kaufpreis: {1} €\n'
        'Minderungsbetrag: {2} €',
    luecken: [
      zahl(0.75, rationale: '1.500 / 2.000'),
      zahl(1350, rationale: '1.800 € × 0,75'),
      zahl(450, rationale: '1.800 € − 1.350 €'),
    ],
    mono: true,
    explanation:
        'Der Kaufpreis wird im Verhältnis der Werte herabgesetzt: 1.500 / 2.000 = 0,75. Geminderter Preis: 1.800 € × 0,75 = 1.350 €. Minderungsbetrag: 1.800 € − 1.350 € = 450 €. Falsch wäre die bloße Wertdifferenz von 500 €, denn das gute Geschäft des Käufers bleibt anteilig erhalten.',
    punkte: 3,
  ),
  markieren(
    'i7-gm-5',
    'ls-maengel',
    scenario:
        'In der Reklamationsabteilung eines IT-Händlers gehen sechs Meldungen ein.',
    prompt:
        'Markiere alle Fälle, in denen ein Sachmangel im Sinne des § 434 BGB vorliegt.',
    zeilen: [
      ja(
        'Ein Notebook hat 8 GB statt der vereinbarten 16 GB Arbeitsspeicher.',
        'Die vereinbarte Beschaffenheit fehlt.',
      ),
      nein(
        'Dem Kunden gefällt die Gehäusefarbe nach zwei Wochen nicht mehr.',
        'Geliefert wurde, was vereinbart war. Reue ist kein Mangel.',
      ),
      ja(
        'Die Montageanleitung des Serverschranks ist fehlerhaft, der Aufbau misslingt.',
        'Eine mangelhafte Montageanleitung ist ein Sachmangel.',
      ),
      nein(
        'Der Akku hält nach drei Jahren normaler Nutzung spürbar kürzer.',
        'Gewöhnlicher Verschleiß nach Gefahrübergang ist kein Mangel.',
      ),
      ja(
        'Statt 10 Switches werden 8 geliefert.',
        'Die vereinbarte Menge gehört zur Beschaffenheit. Eine Zuweniglieferung ist deshalb ein Sachmangel (§ 434 Abs. 2 BGB).',
      ),
      nein(
        'Der Kunde lässt den Monitor beim Auspacken fallen, das Display reißt.',
        'Der Schaden entstand nach der Übergabe durch den Käufer selbst.',
      ),
    ],
    explanation:
        'Ein Sachmangel liegt vor, wenn die Sache bei Gefahrübergang nicht den vereinbarten oder üblichen Anforderungen oder den Montageanforderungen entspricht. Zur Beschaffenheit gehört seit 2022 auch die Menge. Eine Zuweniglieferung ist also selbst ein Sachmangel; die Lieferung einer anderen Sache steht dem Sachmangel gleich (§ 434 Abs. 5 BGB). Verschleiß und selbst verursachte Schäden nach der Übergabe sind keine Mängel.',
    punkte: 3,
  ),

  // =================================================== Abnahme und Protokoll
  tabelle(
    'i7-ga-1',
    'ls-abnahme',
    scenario:
        'Bei der Abnahme eines Kundenportals werden vier Mängel festgestellt. Der Vertrag kennt drei Mängelklassen: betriebsverhindernd (Abnahme wird verweigert), betriebsbehindernd (Abnahme wird in der Regel verweigert) und leicht (Abnahme unter Vorbehalt).',
    prompt: 'Ordne jedem Mangel die Mängelklasse zu.',
    zeilen: [
      ['Festgestellter Mangel', 'Mängelklasse'],
      [
        'Kein Kunde kann sich anmelden.',
        wahl('betriebsverhindernd', [
          'betriebsbehindernd',
          'leicht',
        ], 'Das Portal ist nicht nutzbar.'),
      ],
      [
        'Im Impressum steht ein Tippfehler.',
        wahl('leicht', [
          'betriebsverhindernd',
          'betriebsbehindernd',
        ], 'Die Nutzung ist nicht beeinträchtigt.'),
      ],
      [
        'Der Rechnungsdruck funktioniert nur über einen umständlichen Umweg.',
        wahl('betriebsbehindernd', [
          'betriebsverhindernd',
          'leicht',
        ], 'Nutzbar, aber stark eingeschränkt.'),
      ],
      [
        'Ein Symbol in der Fußzeile ist leicht verschoben.',
        wahl('leicht', [
          'betriebsverhindernd',
          'betriebsbehindernd',
        ], 'Rein optisch, unwesentlich.'),
      ],
    ],
    explanation:
        'Betriebsverhindernd: Nutzung unmöglich. Betriebsbehindernd: Nutzung stark eingeschränkt. Leicht: Nutzung kaum beeinträchtigt. Wegen des Anmeldefehlers darf der Besteller die Abnahme verweigern; wegen unwesentlicher Mängel allein dürfte er es nicht (§ 640 Abs. 1 Satz 2 BGB).',
    punkte: 4,
    difficulty: 1,
  ),
  freitext(
    'i7-ga-2',
    'ls-abnahme',
    scenario:
        'Bei der Abnahme einer Lagerverwaltungssoftware fällt dem Kunden auf, dass der Etikettendruck fehlerhaft ist. Der Projektleiter des Auftragnehmers sagt: „Das beheben wir nächste Woche, unterschreiben Sie ruhig schon einmal.“',
    prompt:
        'Beschreibe zwei Gründe, warum der Kunde den Mangel mit einer Frist in das Abnahmeprotokoll aufnehmen lassen sollte.',
    kriterien: [
      krit(
        'Wer ein Werk trotz bekanntem Mangel ohne Vorbehalt abnimmt, verliert dafür Nacherfüllung, Selbstvornahme, Rücktritt und Minderung (§ 640 Abs. 3 BGB)',
        punkte: 2,
        stichwoerter: [
          'Vorbehalt',
          'Rechte verlieren',
          'verliert',
          'Mängelrechte',
          '640',
        ],
      ),
      krit(
        'Das Protokoll ist der Beweis: Nach der Abnahme muss der Besteller beweisen, dass ein Mangel vorliegt',
        punkte: 2,
        stichwoerter: ['Beweis', 'Beweislast', 'Nachweis', 'belegen'],
      ),
      krit(
        'Mit der Frist ist festgelegt, bis wann nachgebessert wird; nach ihrem Ablauf stehen weitere Rechte offen',
        punkte: 2,
        stichwoerter: ['Frist', 'Termin', 'bis wann', 'verbindlich'],
      ),
      krit(
        'Mit dem Vorbehalt kann der Kunde einen angemessenen Teil der Vergütung zurückhalten',
        punkte: 2,
        stichwoerter: [
          'zurückhalten',
          'einbehalten',
          'Vergütung',
          'Druckmittel',
        ],
      ),
    ],
    loesung:
        'Nimmt der Kunde ohne Vorbehalt ab, obwohl er den Mangel kennt, verliert er dafür seine Rechte auf Nacherfüllung, Selbstvornahme, Rücktritt und Minderung (§ 640 Abs. 3 BGB). Außerdem kehrt sich mit der Abnahme die Beweislast um: Das Protokoll belegt, dass der Mangel schon bei der Abnahme vorlag. Die Frist legt verbindlich fest, bis wann nachgebessert wird, und der Kunde kann bis dahin einen angemessenen Teil der Vergütung zurückhalten.',
    explanation:
        'Je Grund 2 Punkte, höchstens 4 Punkte. Die mündliche Zusage des Projektleiters hilft später wenig. Was nicht im Protokoll steht, lässt sich kaum beweisen.',
    punkte: 4,
  ),
  lueckentext(
    'i7-ga-3',
    'ls-abnahme',
    scenario:
        'Eine Agentur hat für einen Geschäftskunden einen Webshop fertiggestellt. Der Kunde reagiert nicht auf die Bitte um Abnahme.',
    prompt: 'Ergänze den Text zur fiktiven Abnahme.',
    text:
        'Die Agentur setzt dem Kunden nach der {0} des Werks eine angemessene {1} zur Abnahme. Verweigert der Kunde die Abnahme bis dahin nicht unter Angabe mindestens eines {2}, gilt das Werk als {3}. Damit wird die {4} fällig, und die {5} für Mängel liegt nun beim Kunden.',
    luecken: [
      wort(['Fertigstellung']),
      wort(['Frist']),
      wort(['Mangels']),
      wort(['abgenommen']),
      wort(['Vergütung']),
      wort(['Beweislast']),
    ],
    wortbank: ['Mahnung', 'gekündigt', 'Garantie', 'Bestellung'],
    explanation:
        'Fiktive Abnahme nach § 640 Abs. 2 BGB: Fertigstellung, angemessene Frist, keine Verweigerung unter Angabe eines Mangels. Folgen wie bei jeder Abnahme: Vergütung fällig, Gefahrübergang, Beginn der Verjährung, Umkehr der Beweislast.',
    punkte: 3,
  ),
  markieren(
    'i7-ga-4',
    'ls-abnahme',
    scenario:
        'Ein Großhändler testet ein neues Bestellportal gegen das Pflichtenheft. Das Testprotokoll enthält sechs Abweichungen.',
    prompt:
        'Markiere alle Abweichungen, die als wesentliche Mängel die Verweigerung der Abnahme rechtfertigen.',
    zeilen: [
      ja(
        'Bestellungen über 1.000 € werden nicht gespeichert.',
        'Eine Kernfunktion fällt aus, also ein wesentlicher Mangel.',
      ),
      nein(
        'Im Impressum fehlt ein Buchstabe.',
        'Unwesentlich, er wird unter Vorbehalt protokolliert.',
      ),
      ja(
        'Die Anmeldung scheitert bei allen Nutzern mit Umlaut im Namen.',
        'Ein Teil der Nutzer kann das Portal gar nicht verwenden.',
      ),
      nein(
        'Das Logo sitzt fünf Pixel zu weit links.',
        'Rein optische Kleinigkeit.',
      ),
      ja(
        'Der im Pflichtenheft als Muss geforderte PDF-Export der Rechnungen fehlt.',
        'Eine zugesagte Muss-Funktion fehlt vollständig.',
      ),
      nein(
        'Die Startseite lädt in 2,1 statt der vereinbarten 2,0 Sekunden.',
        'Geringfügige Abweichung, die den Gebrauch nicht spürbar beeinträchtigt.',
      ),
    ],
    explanation:
        'Wegen unwesentlicher Mängel darf die Abnahme nicht verweigert werden (§ 640 Abs. 1 Satz 2 BGB). Wesentlich ist ein Mangel, wenn er den vertragsgemäßen Gebrauch spürbar beeinträchtigt, etwa wenn Kernfunktionen fehlen oder versagen. Kleinigkeiten kommen mit Frist ins Protokoll.',
    punkte: 3,
  ),
  rechnen(
    'i7-ga-5',
    'ls-abnahme',
    scenario:
        'Für eine Individualsoftware ist ein Festpreis von 36.000 € vereinbart. 30 % wurden als Abschlag bei Auftragserteilung gezahlt. Die Software wird unter Vorbehalt abgenommen; die Beseitigung des vorbehaltenen Mangels kostet voraussichtlich 600 €. Der Besteller hält das Doppelte dieser Kosten zurück.',
    prompt:
        'Berechne den Betrag, den der Besteller bei der Abnahme zahlen muss.',
    answer: 24000,
    unit: '€',
    explanation:
        'Abschlag: 36.000 € × 0,30 = 10.800 €. Rest: 36.000 € − 10.800 € = 25.200 €. Einbehalt: 2 × 600 € = 1.200 € (§ 641 Abs. 3 BGB: in der Regel das Doppelte der Mängelbeseitigungskosten). Zu zahlen: 25.200 € − 1.200 € = 24.000 €.',
    punkte: 3,
  ),

  // ================================================== Veränderung nach Lewin
  reihenfolge(
    'i7-cl-1',
    'cm-lewin',
    scenario:
        'Ein Logistikunternehmen ersetzt Kommissionierlisten auf Papier durch Handscanner.',
    prompt:
        'Bringe die Maßnahmen in die Reihenfolge, die dem Modell von Lewin entspricht.',
    items: [
      'Die Geschäftsführung erklärt in einer Versammlung, warum die Papierlisten abgelöst werden.',
      'Die Schichten benennen Key-User, die ihre Anforderungen einbringen.',
      'Die Key-User testen die Scanner im Pilotbetrieb.',
      'Alle Beschäftigten werden geschult, die Scanner gehen in Betrieb.',
      'Papierlisten werden nicht mehr gedruckt, der neue Ablauf steht in der Arbeitsanweisung.',
    ],
    explanation:
        'Unfreezing: Gründe erklären und Betroffene beteiligen. Moving: pilotieren, schulen, in Betrieb nehmen. Refreezing: den Rückweg versperren und das Neue zum Standard machen.',
    punkte: 3,
  ),
  tabelle(
    'i7-cl-2',
    'cm-lewin',
    scenario:
        'In der Phase des Veränderns muss entschieden werden, wie ein neues System in Betrieb geht.',
    prompt:
        'Ordne jeder Einführungsstrategie das Vorgehen und den typischen Nachteil zu.',
    zeilen: [
      ['Strategie', 'Vorgehen', 'Typischer Nachteil'],
      [
        'Sofortumstellung (Big Bang)',
        wahl('Stichtag: alt aus, neu an', [
          'alt und neu laufen nebeneinander',
          'erst ein Bereich, dann alle',
          'Modul für Modul umstellen',
        ]),
        wahl('Fehler treffen sofort den ganzen Betrieb', [
          'doppelte Arbeit und Kosten',
          'dauert lange, Schnittstellen nötig',
          'Nutzen kommt für die anderen später',
        ]),
      ],
      [
        'Parallelbetrieb',
        wahl('alt und neu laufen nebeneinander', [
          'Stichtag: alt aus, neu an',
          'erst ein Bereich, dann alle',
          'Modul für Modul umstellen',
        ]),
        wahl('doppelte Arbeit und Kosten', [
          'Fehler treffen sofort den ganzen Betrieb',
          'dauert lange, Schnittstellen nötig',
          'Nutzen kommt für die anderen später',
        ]),
      ],
      [
        'Stufenweise Einführung',
        wahl('Modul für Modul umstellen', [
          'Stichtag: alt aus, neu an',
          'alt und neu laufen nebeneinander',
          'erst ein Bereich, dann alle',
        ]),
        wahl('dauert lange, Schnittstellen nötig', [
          'Fehler treffen sofort den ganzen Betrieb',
          'doppelte Arbeit und Kosten',
          'Nutzen kommt für die anderen später',
        ]),
      ],
      [
        'Pilotbetrieb',
        wahl('erst ein Bereich, dann alle', [
          'Stichtag: alt aus, neu an',
          'alt und neu laufen nebeneinander',
          'Modul für Modul umstellen',
        ]),
        wahl('Nutzen kommt für die anderen später', [
          'Fehler treffen sofort den ganzen Betrieb',
          'doppelte Arbeit und Kosten',
          'dauert lange, Schnittstellen nötig',
        ]),
      ],
    ],
    explanation:
        'Sofortumstellung: schnell und billig, aber riskant. Parallelbetrieb: sicher, aber doppelter Aufwand. Stufenweise: überschaubare Schritte, aber lange Dauer und Schnittstellen zwischen alt und neu. Pilot: Fehler treffen nur einen Bereich, die übrigen profitieren erst später.',
    punkte: 4,
  ),
  freitext(
    'i7-cl-3',
    'cm-lewin',
    scenario:
        'Ein Handelsunternehmen ersetzt sein Warenwirtschaftssystem. Zur Wahl stehen die Sofortumstellung zum Monatsersten und ein vierwöchiger Parallelbetrieb.',
    prompt:
        'Nenne je einen Vorteil und einen Nachteil der Sofortumstellung und des Parallelbetriebs.',
    kriterien: [
      krit(
        'Sofortumstellung, Vorteil: kurze Umstellung, keine Doppelarbeit, geringe Kosten',
        stichwoerter: [
          'keine Doppelarbeit',
          'schnell',
          'kurz',
          'günstig',
          'geringe Kosten',
          'klarer Schnitt',
        ],
      ),
      krit(
        'Sofortumstellung, Nachteil: hohes Risiko, weil Fehler sofort den ganzen Betrieb treffen und kein Rückfall auf das alte System möglich ist',
        stichwoerter: [
          'Risiko',
          'kein Rückfall',
          'Ausfall',
          'Stillstand',
          'Druck',
          'Störungen',
        ],
      ),
      krit(
        'Parallelbetrieb, Vorteil: Sicherheit, weil das alte System als Rückfall bereitsteht und sich die Ergebnisse vergleichen lassen',
        stichwoerter: [
          'Sicherheit',
          'Rückfall',
          'vergleichen',
          'Absicherung',
          'geringes Risiko',
        ],
      ),
      krit(
        'Parallelbetrieb, Nachteil: doppelte Datenpflege, höhere Kosten und Belastung der Beschäftigten',
        stichwoerter: [
          'doppelt',
          'Doppelarbeit',
          'Mehraufwand',
          'Kosten',
          'Belastung',
        ],
      ),
    ],
    loesung:
        'Sofortumstellung: Vorteil ist die kurze Umstellung ohne Doppelarbeit und mit geringen Kosten; Nachteil ist das hohe Risiko, weil Fehler sofort den ganzen Betrieb treffen und es keinen Rückfall gibt. Parallelbetrieb: Vorteil ist die Sicherheit, denn das alte System läuft weiter und die Ergebnisse lassen sich vergleichen; Nachteil sind doppelte Datenpflege, höhere Kosten und die Mehrbelastung der Beschäftigten.',
    explanation:
        'Je Nennung 1 Punkt. Die Wahl hängt vom Risiko ab: Je kritischer das System für den laufenden Betrieb ist, desto eher lohnt der Mehraufwand des Parallelbetriebs.',
    punkte: 4,
  ),
  zuordnen(
    'i7-cl-4',
    'cm-lewin',
    scenario:
        'In einem Fachartikel über die Einführung neuer Software steht der folgende Absatz.',
    code:
        'Rolling out new software is not only a technical task.\n'
        'People need to understand why the old way of working\n'
        'has to change. Explain the reasons early and honestly,\n'
        'and involve the future users when requirements are\n'
        'collected. During the rollout, offer hands-on training\n'
        'and name key users who can answer questions on the\n'
        'spot. Once the new system is live, switch off the old\n'
        'one and update the work instructions, otherwise staff\n'
        'will quietly slide back into old habits.',
    prompt: 'Ordne die im Text genannten Maßnahmen den Phasen nach Lewin zu.',
    buckets: ['Unfreezing', 'Moving', 'Refreezing'],
    items: [
      zu(
        'Praxisnahe Schulungen anbieten',
        1,
        '„hands-on training“ während der Einführung.',
      ),
      zu(
        'Gründe früh und ehrlich erklären',
        0,
        '„explain the reasons early and honestly“ schafft Einsicht.',
      ),
      zu(
        'Das alte System abschalten',
        2,
        '„switch off the old one“ versperrt den Rückweg.',
      ),
      zu(
        'Künftige Nutzer bei den Anforderungen beteiligen',
        0,
        '„involve the future users“: Beteiligung vor der Umstellung.',
      ),
      zu(
        'Key-User als Ansprechpartner benennen',
        1,
        '„name key users“: Begleitung während der Umstellung.',
      ),
      zu(
        'Arbeitsanweisungen aktualisieren',
        2,
        '„update the work instructions“: Das Neue wird zum Standard.',
      ),
    ],
    explanation:
        'Unfreezing: erklären und beteiligen. Moving: schulen und begleiten. Refreezing: Altes abschalten und Standards festschreiben. Sonst rutschen die Beschäftigten laut Text in alte Gewohnheiten zurück („slide back into old habits“).',
    punkte: 3,
    tags: ['englisch'],
  ),
  rechnen(
    'i7-cl-5',
    'cm-lewin',
    scenario:
        'Ein Unternehmen plant einen vierwöchigen Parallelbetrieb. In dieser Zeit pflegen 12 Mitarbeitende die Daten doppelt und brauchen dafür je 5 Stunden zusätzlich pro Woche (38 € je Stunde). Die Lizenz des alten Systems kostet für den zusätzlichen Monat 900 €.',
    prompt: 'Berechne die Mehrkosten des Parallelbetriebs.',
    answer: 10020,
    unit: '€',
    explanation:
        'Mehrarbeit: 12 × 5 h × 4 Wochen = 240 h. Personalkosten: 240 h × 38 € = 9.120 €. Dazu die Lizenz: 9.120 € + 900 € = 10.020 €. Diesen Betrag kostet die Sicherheit, jederzeit auf das alte System zurückfallen zu können.',
    punkte: 3,
  ),

  // ============================================================ Widerstände
  freitext(
    'i7-cw-1',
    'cm-widerstand',
    scenario:
        'Ein Logistikunternehmen stellt die Disposition von Excel-Listen auf eine neue Tourenplanungssoftware um. Mehrere langjährige Disponenten äußern Bedenken.',
    prompt:
        'Beschreibe drei Maßnahmen, mit denen das Unternehmen die Akzeptanz der neuen Software fördern kann.',
    kriterien: [
      krit(
        'Frühzeitig und offen informieren: Gründe, Ziele und Zeitplan erklären',
        punkte: 2,
        stichwoerter: [
          'informieren',
          'kommunizieren',
          'Infoveranstaltung',
          'transparent',
          'erklären',
        ],
      ),
      krit(
        'Nutzen für die tägliche Arbeit aufzeigen, etwa weniger Routinearbeit und weniger Fehler',
        punkte: 2,
        stichwoerter: ['Nutzen', 'Vorteile', 'Entlastung', 'Erleichterung'],
      ),
      krit(
        'Betroffene beteiligen: Anforderungen abfragen, Erfahrung der Disponenten einbeziehen',
        punkte: 2,
        stichwoerter: [
          'beteiligen',
          'einbeziehen',
          'mitgestalten',
          'Feedback',
          'Workshop',
        ],
      ),
      krit(
        'Schulen und klare Anleitungen bereitstellen',
        punkte: 2,
        stichwoerter: [
          'Schulung',
          'schulen',
          'Training',
          'Anleitung',
          'Einweisung',
        ],
      ),
      krit(
        'Key-User bzw. Multiplikatoren als Ansprechpartner benennen, in der Startphase begleiten',
        punkte: 2,
        stichwoerter: [
          'Key-User',
          'Multiplikator',
          'Ansprechpartner',
          'Begleitung',
          'Support',
        ],
      ),
      krit(
        'Im Pilotbetrieb erproben und erste Erfolge sichtbar machen',
        punkte: 2,
        stichwoerter: ['Pilot', 'Testphase', 'Erfolge', 'ausprobieren'],
      ),
      krit(
        'Ängste ernst nehmen: Zusagen zu Arbeitsplatz und Leistungskontrolle, Betriebsrat einbinden',
        punkte: 2,
        stichwoerter: [
          'Ängste',
          'Sorgen',
          'Betriebsrat',
          'Arbeitsplatz',
          'zusichern',
        ],
      ),
    ],
    loesung:
        'Erstens früh und offen informieren, warum umgestellt wird und was sich ändert. Zweitens die Disponenten beteiligen, etwa ihre Anforderungen abfragen und erfahrene Kollegen als Key-User gewinnen. Drittens schulen und in der Startphase begleiten, damit niemand am Können scheitert. Weitere Möglichkeiten: Nutzen für die tägliche Arbeit zeigen, im Pilot erproben, Sorgen um Arbeitsplatz und Kontrolle ernst nehmen.',
    explanation:
        'Je beschriebene Maßnahme 2 Punkte (Maßnahme nennen und kurz ausführen), höchstens 6 Punkte. Die Maßnahmen setzen an den Ursachen an: nicht wissen, nicht können, nicht wollen, nicht dürfen.',
    punkte: 6,
  ),
  markieren(
    'i7-cw-2',
    'cm-widerstand',
    scenario:
        'In einer Schichtbesprechung wird die Einführung von Handscannern im Lager vorgestellt.',
    prompt:
        'Markiere alle Reaktionen, die auf Widerstand gegen die Veränderung hindeuten.',
    zeilen: [
      ja(
        '„Das haben wir schon immer mit Listen gemacht, und es hat funktioniert.“',
        'Offener Widerspruch, also verbal und aktiv.',
      ),
      nein(
        '„Können wir die Schulung auf zwei Termine legen, damit die Schicht besetzt bleibt?“',
        'Ein konstruktiver Vorschlag zur Umsetzung.',
      ),
      ja(
        '„Das betrifft doch eher die Verwaltung, bei uns ist das nicht so wichtig.“',
        'Ausweichen und Bagatellisieren, also verbal und passiv.',
      ),
      ja(
        '„Ich habe gehört, mit den Scannern sollen nur Stellen gestrichen werden.“',
        'Gerüchte und Unruhe sind ein Zeichen von Aufregung.',
      ),
      nein(
        '„Ich würde die Scanner gern im Pilot testen.“',
        'Bereitschaft zur Mitarbeit, kein Widerstand.',
      ),
      ja(
        'Mehrere Beschäftigte schweigen die ganze Besprechung über und schauen auf ihr Handy.',
        'Lustlosigkeit und Rückzug, also nonverbal und passiv. Schweigen ist keine Zustimmung.',
      ),
    ],
    explanation:
        'Widerstand zeigt sich als Widerspruch, Ausweichen, Aufregung oder Lustlosigkeit. Sachliche Fragen und Vorschläge zur Umsetzung sind dagegen Zeichen von Beteiligung. Besonders leicht übersehen wird der verdeckte, passive Widerstand.',
    punkte: 4,
  ),
  paare(
    'i7-cw-3',
    'cm-widerstand',
    prompt:
        'Verbinde jede Strategie im Umgang mit Widerstand mit der Lage, in der sie passt.',
    paare: [
      paar('Information', 'Widerstand aus Unwissen'),
      paar('Beteiligung', 'Betroffene haben wichtiges Wissen'),
      paar('Schulung, Unterstützung', 'Angst und fehlendes Können'),
      paar('Verhandlung, Ausgleich', 'jemand verliert tatsächlich etwas'),
      paar('Anordnung', 'letztes Mittel bei großer Eile'),
    ],
    explanation:
        'Die Strategie richtet sich nach der Ursache: informieren bei Unwissen, beteiligen, wenn die Betroffenen etwas beitragen können, schulen bei fehlendem Können, verhandeln bei echten Verlusten. Anordnung und Druck erzeugen oft nur Scheinanpassung und sind das letzte Mittel.',
    punkte: 3,
  ),
  freitext(
    'i7-cw-4',
    'cm-widerstand',
    scenario:
        'Ein Handelsunternehmen digitalisiert die Rechnungsprüfung: Eingangsrechnungen werden künftig automatisch erfasst und geprüft. Die Sachbearbeitung reagiert zurückhaltend.',
    prompt:
        'Nenne drei Gründe, aus denen Beschäftigte der Digitalisierung ihres Arbeitsplatzes ablehnend gegenüberstehen können.',
    kriterien: [
      krit(
        'Angst um den Arbeitsplatz',
        stichwoerter: ['Arbeitsplatz', 'Stelle', 'Kündigung', 'Jobverlust'],
      ),
      krit(
        'Angst vor Überwachung und Leistungskontrolle',
        stichwoerter: ['Überwachung', 'Kontrolle', 'Leistungskontrolle'],
      ),
      krit(
        'Sorge, das neue System nicht zu beherrschen (Überforderung)',
        stichwoerter: [
          'Überforderung',
          'überfordert',
          'nicht können',
          'Unsicherheit',
          'fehlende Kenntnisse',
        ],
      ),
      krit(
        'Festhalten an gewohnten Abläufen',
        stichwoerter: ['Gewohnheit', 'gewohnt', 'bewährt', 'Routine'],
      ),
      krit(
        'Fehlende Information über Gründe und Nutzen',
        stichwoerter: [
          'Information',
          'nicht informiert',
          'Nutzen unklar',
          'Sinn',
        ],
      ),
      krit(
        'Mehraufwand in der Umstellungsphase',
        stichwoerter: [
          'Mehraufwand',
          'Mehrarbeit',
          'zusätzliche Arbeit',
          'Zeit',
        ],
      ),
      krit(
        'Verlust von Bedeutung oder Expertenstatus',
        stichwoerter: ['Status', 'Bedeutung', 'Entwertung', 'Kompetenzverlust'],
      ),
    ],
    loesung:
        'Angst um den Arbeitsplatz, Angst vor Überwachung und Leistungskontrolle, Sorge vor Überforderung durch das neue System, Festhalten an gewohnten Abläufen, fehlende Information über Gründe und Nutzen, Mehraufwand während der Umstellung, Verlust des eigenen Expertenstatus.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Hinter den Gründen stehen die vier Ursachen nicht wissen, nicht können, nicht wollen und nicht dürfen. Daran richtet sich die passende Maßnahme aus.',
    punkte: 3,
    difficulty: 1,
  ),

  // ========================================================= Kaizen und KVP
  tabelle(
    'i7-ck-1',
    'cm-kaizen',
    scenario:
        'Im Service Desk werden zu viele Tickets falsch kategorisiert. Das Team geht das im Rahmen des KVP an.',
    prompt: 'Ordne jede Tätigkeit der Phase des PDCA-Zyklus zu.',
    zeilen: [
      ['Tätigkeit', 'Phase'],
      [
        'Die neue Checkliste vier Wochen lang in einem Team ausprobieren',
        wahl('Do', ['Plan', 'Check', 'Act']),
      ],
      [
        'Ist-Zustand messen (14 % falsch) und als Ziel 5 % festlegen',
        wahl('Plan', ['Do', 'Check', 'Act']),
      ],
      [
        'Die Checkliste für alle Teams verbindlich machen',
        wahl('Act', ['Plan', 'Do', 'Check']),
      ],
      [
        'Die Fehlerquote nach dem Test auswerten und mit dem Ziel vergleichen',
        wahl('Check', ['Plan', 'Do', 'Act']),
      ],
      [
        'Ursachen analysieren und eine Checkliste entwerfen',
        wahl('Plan', ['Do', 'Check', 'Act']),
      ],
    ],
    explanation:
        'Plan: Ist-Zustand, Ursachen, Ziel und Maßnahme. Do: im Kleinen ausprobieren. Check: Ergebnis mit dem Ziel vergleichen. Act: Erfolgreiches zum Standard machen und von dort den nächsten Zyklus starten.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i7-ck-2',
    'cm-kaizen',
    scenario:
        'Die IT-Leitung eines Handelsunternehmens möchte in ihrer Abteilung einen kontinuierlichen Verbesserungsprozess (KVP) einführen.',
    prompt: 'Nenne vier Merkmale eines KVP.',
    kriterien: [
      krit(
        'Verbesserung in vielen kleinen Schritten',
        stichwoerter: ['kleine Schritte', 'schrittweise', 'kleinen Schritten'],
      ),
      krit(
        'Dauerhaft und ohne Endpunkt',
        stichwoerter: [
          'ständig',
          'dauerhaft',
          'kontinuierlich',
          'laufend',
          'kein Ende',
        ],
      ),
      krit(
        'Alle Mitarbeitenden sind beteiligt, Vorschläge kommen aus dem Team',
        stichwoerter: [
          'alle Mitarbeiter',
          'alle Mitarbeitenden',
          'Team',
          'Beteiligung',
          'Vorschläge',
        ],
      ),
      krit(
        'Jede Verbesserung durchläuft den PDCA-Zyklus',
        stichwoerter: ['PDCA', 'Plan Do Check Act', 'Deming'],
      ),
      krit(
        'Erfolgreiche Verbesserungen werden zum neuen Standard',
        stichwoerter: ['Standard', 'standardisieren', 'festschreiben'],
      ),
      krit(
        'Verschwendung wird sichtbar gemacht und abgebaut',
        stichwoerter: ['Verschwendung', 'Muda', 'unnötig'],
      ),
      krit(
        'Geringe Kosten und geringes Risiko je Schritt',
        stichwoerter: ['geringe Kosten', 'geringes Risiko', 'günstig'],
      ),
    ],
    loesung:
        'Viele kleine Schritte statt eines großen Umbruchs, dauerhaft und ohne Endpunkt, getragen von allen Mitarbeitenden, jede Verbesserung im PDCA-Zyklus, Erfolgreiches wird zum Standard, Verschwendung wird abgebaut, geringes Risiko je Schritt.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Abgrenzung: Die radikale, einmalige Neugestaltung eines Prozesses heißt Business Process Reengineering.',
    punkte: 4,
    difficulty: 1,
  ),
  lueckentext(
    'i7-ck-3',
    'cm-kaizen',
    scenario:
        'Im Service Desk fallen 1.500 Tickets im Monat an. Vor dem KVP-Workshop wurden 14 % falsch kategorisiert, danach noch 6 %. Jedes falsch kategorisierte Ticket verursacht 8 Minuten Nacharbeit. Eine Arbeitsstunde kostet 45 €.',
    prompt: 'Berechne die monatliche Einsparung.',
    text:
        'Falsch kategorisierte Tickets vorher: {0}\n'
        'Falsch kategorisierte Tickets nachher: {1}\n'
        'Eingesparte Nacharbeit: {2} h\n'
        'Einsparung im Monat: {3} €',
    luecken: [
      zahl(210, rationale: '1.500 × 0,14'),
      zahl(90, rationale: '1.500 × 0,06'),
      zahl(16, rationale: '120 × 8 min = 960 min'),
      zahl(720, rationale: '16 h × 45 €'),
    ],
    mono: true,
    explanation:
        'Vorher: 1.500 × 0,14 = 210 Tickets. Nachher: 1.500 × 0,06 = 90 Tickets. Differenz: 120 Tickets × 8 min = 960 min = 16 h. Einsparung: 16 h × 45 € = 720 € im Monat. Kleine Verbesserungen summieren sich. Das ist der Kern von Kaizen.',
    punkte: 4,
  ),
  markieren(
    'i7-ck-4',
    'cm-kaizen',
    scenario:
        'In einem Kaizen-Workshop wird der Ablauf „neues Benutzerkonto anlegen“ Schritt für Schritt aufgeschrieben.',
    prompt: 'Markiere alle Schritte, die Verschwendung (Muda) darstellen.',
    zeilen: [
      nein(
        'Die Fachabteilung füllt den Antrag im Portal aus.',
        'Notwendiger Schritt, denn hier entsteht der Auftrag.',
      ),
      ja(
        'Der Antrag wird ausgedruckt und per Hauspost zur IT gebracht.',
        'Unnötiger Transport und Medienbruch.',
      ),
      ja(
        'Die IT tippt die Daten vom Ausdruck erneut ab.',
        'Doppelerfassung, also Überbearbeitung.',
      ),
      ja(
        'Der Antrag liegt drei Tage zur Unterschrift bei der Teamleitung.',
        'Wartezeit ohne Wertschöpfung.',
      ),
      nein(
        'Die IT legt das Konto an und vergibt die Rechte laut Rollenprofil.',
        'Der eigentliche wertschöpfende Schritt.',
      ),
      ja(
        'Wegen eines Tippfehlers im Namen muss das Konto neu angelegt werden.',
        'Fehler mit Nacharbeit.',
      ),
    ],
    explanation:
        'Verschwendung ist alles, was Aufwand kostet, aber keinen Wert für den Kunden schafft: Transport, Wartezeit, Doppelerfassung, Fehler und Nacharbeit. Würde der Portalantrag direkt digital freigegeben und übernommen, entfielen Ausdruck, Hauspost und Abtippen, und Wartezeit und Tippfehler würden seltener.',
    punkte: 4,
  ),
];
