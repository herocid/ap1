import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben im IHK-Stil zu Bereich 04, Teil 2: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA04Daten = [
  // ================================================================ ER-Modell
  zuordnen(
    'i4-de-1',
    'dm-erm',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH will die Wartung von Kundengeräten in einer Datenbank erfassen. Techniker warten Geräte; ein Techniker wartet im Lauf der Zeit viele Geräte, ein Gerät wird von verschiedenen Technikern gewartet. Zu jeder Wartung werden das Datum und die Dauer festgehalten.',
    skizze: ErmDiagramm(
      [ErmEntitaet('Techniker'), ErmEntitaet('Gerät')],
      beziehungen: [ErmBeziehung('Techniker', 'wartet', 'Gerät', 'n', 'm')],
    ),
    prompt:
        'Ordne jedes Attribut dem Element des ER-Modells zu, an dem es eingetragen wird.',
    buckets: ['Techniker', 'Gerät', 'Beziehung „wartet“'],
    items: [
      zu('Seriennummer', 1, 'Kennzeichnet genau ein Gerät.'),
      zu(
        'Wartungsdatum',
        2,
        'Gehört zur einzelnen Wartung, also zur Kombination aus Techniker und Gerät.',
      ),
      zu('Personalnummer', 0, 'Kennzeichnet genau einen Techniker.'),
      zu('Hersteller', 1, 'Eigenschaft des Geräts.'),
      zu(
        'Dauer in Minuten',
        2,
        'Jede Wartung dauert unterschiedlich lang. Weder Techniker noch Gerät haben „eine“ Dauer.',
      ),
      zu('Qualifikation', 0, 'Eigenschaft des Technikers.'),
      zu('Nachname', 0, 'Eigenschaft des Technikers.'),
      zu('Standort beim Kunden', 1, 'Eigenschaft des Geräts.'),
    ],
    explanation:
        'Attribute, die nur für die Kombination zweier Entitäten einen Sinn ergeben (Wartungsdatum, Dauer), gehören an die Beziehung. Alles, was eine Entität allein beschreibt, steht an der Entität. In der Prüfung kostet genau diese Unterscheidung regelmäßig Punkte.',
    punkte: 4,
    difficulty: 3,
  ),
  lueckentext(
    'i4-de-2',
    'dm-erm',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH hat für ihren Webshop das folgende ER-Modell in Chen-Notation erstellt.',
    skizze: ErmDiagramm(
      [
        ErmEntitaet(
          'Kunde',
          attribute: ['KundenNr', 'Name', 'Ort'],
          schluessel: ['KundenNr'],
        ),
        ErmEntitaet(
          'Bestellung',
          attribute: ['BestellNr', 'Datum'],
          schluessel: ['BestellNr'],
        ),
        ErmEntitaet(
          'Artikel',
          attribute: ['ArtikelNr', 'Bezeichnung', 'Preis'],
          schluessel: ['ArtikelNr'],
        ),
      ],
      beziehungen: [
        ErmBeziehung('Kunde', 'gibt auf', 'Bestellung', '1', 'n'),
        ErmBeziehung('Bestellung', 'enthält', 'Artikel', 'n', 'm'),
      ],
    ),
    prompt: 'Ergänze die Aussagen zum ER-Modell.',
    text:
        'Das Modell enthält {0} Entitätstypen. Der Primärschlüssel von Artikel ist {1}. '
        'Eine Bestellung gehört zu {2} Kunden. '
        'Ein Artikel kann in {3} Bestellungen vorkommen. '
        'Die Beziehung „enthält“ hat die Kardinalität {4}.',
    luecken: [
      zahl(3, rationale: 'Kunde, Bestellung und Artikel.'),
      wahl('ArtikelNr', [
        'Bezeichnung',
        'Preis',
        'BestellNr',
      ], 'Das unterstrichene Attribut ist der Primärschlüssel.'),
      wahl('genau einem', [
        'beliebig vielen',
        'keinem',
      ], 'Auf der Seite von Kunde steht die 1.'),
      wahl('beliebig vielen', [
        'genau einer',
        'höchstens einer',
      ], 'Auf der Seite der Bestellung steht n.'),
      wahl('n:m', ['1:n', '1:1'], 'Auf beiden Seiten steht „viele“.'),
    ],
    explanation:
        'Chen-Notation lesen: Rechtecke sind Entitätstypen, die Raute ist die Beziehung, unterstrichen ist der Primärschlüssel. Die Kardinalität liest man immer in beide Richtungen: Ein Kunde gibt n Bestellungen auf, eine Bestellung gehört zu 1 Kunden (1:n). Bestellung und Artikel stehen in einer n:m-Beziehung.',
    punkte: 5,
  ),
  freitext(
    'i4-de-3',
    'dm-erm',
    scenario:
        'Im Lager der Elbtal Logistik AG werden Artikel auf Lagerplätzen eingelagert. Ein Artikel kann auf mehreren Lagerplätzen liegen, auf einem Lagerplatz können mehrere Artikel liegen. Ein Kollege möchte das Attribut „Menge“ beim Entitätstyp Artikel eintragen.',
    prompt:
        'Erläutere, warum das Attribut „Menge“ an die Beziehung zwischen Artikel und Lagerplatz gehört und nicht an den Entitätstyp Artikel.',
    kriterien: [
      krit(
        'Die Menge hängt von der Kombination aus Artikel und Lagerplatz ab. Sie beschreibt, wie viel eines Artikels auf einem bestimmten Platz liegt.',
        punkte: 2,
        stichwoerter: [
          'Kombination',
          'beiden',
          'je Lagerplatz',
          'pro Lagerplatz',
          'bestimmten Platz',
        ],
      ),
      krit(
        'Beim Artikel könnte nur ein einziger Wert stehen. Die Mengen der einzelnen Lagerplätze ließen sich nicht unterscheiden.',
        punkte: 2,
        stichwoerter: [
          'nur ein Wert',
          'einziger Wert',
          'mehrere Lagerplätze',
          'nicht unterscheiden',
          'Gesamtmenge',
        ],
      ),
    ],
    loesung:
        'Die Menge ist keine Eigenschaft des Artikels allein: Derselbe Artikel liegt auf mehreren Lagerplätzen in unterschiedlicher Stückzahl. Die Menge gehört deshalb zur Kombination aus Artikel und Lagerplatz, also an die Beziehung. Stünde sie beim Artikel, gäbe es nur einen einzigen Wert, und die Bestände der einzelnen Plätze ließen sich nicht festhalten.',
    explanation:
        'Je Aspekt 2 Punkte: Abhängigkeit von beiden Entitäten und die Folge eines falschen Eintrags. Andere fachlich richtige Formulierungen zählen ebenso. Bei der Umsetzung in Tabellen landet die Menge in der Zwischentabelle.',
    punkte: 4,
  ),
  markieren(
    'i4-de-4',
    'dm-erm',
    scenario:
        'Die Pixelhafen Medien GmbH beschreibt ihr neues Ticketsystem so: „Kunden mit Firmenname und Telefonnummer eröffnen Tickets. Jedes Ticket hat eine Priorität und ein Eröffnungsdatum. Mitarbeiter mit Kürzel und Abteilung bearbeiten die Tickets.“',
    prompt: 'Markiere alle Begriffe, die im ER-Modell zu Entitätstypen werden.',
    zeilen: [
      ja('Kunde', 'Zu Kunden werden eigene Daten gespeichert.'),
      nein('Telefonnummer', 'Eigenschaft des Kunden, also ein Attribut.'),
      ja('Ticket', 'Ein Ticket hat eigene Attribute wie Priorität und Datum.'),
      nein('Priorität', 'Eigenschaft des Tickets, also ein Attribut.'),
      nein(
        'bearbeiten',
        'Ein Verb zwischen zwei Entitätstypen, also eine Beziehung.',
      ),
      ja('Mitarbeiter', 'Mitarbeiter haben eigene Attribute.'),
      nein('Eröffnungsdatum', 'Eigenschaft des Tickets, also ein Attribut.'),
      nein('eröffnen', 'Verbindet Kunde und Ticket, also eine Beziehung.'),
    ],
    explanation:
        'Entitätstypen sind die Dinge, über die eigene Daten gespeichert werden: Kunde, Ticket, Mitarbeiter. Beschreibende Angaben werden Attribute, Verben zwischen den Entitätstypen werden Beziehungen.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i4-de-5',
    'dm-erm',
    scenario:
        'In einem englischsprachigen Handbuch zur Datenmodellierung steht der folgende Abschnitt.',
    code:
        'An entity-relationship model\n'
        'describes the data of a company\n'
        'before any table is created.\n'
        'An entity is a real object, for\n'
        'example one customer or one\n'
        'product. Attributes describe an\n'
        'entity, such as a name or a\n'
        'price. A relationship connects\n'
        'two entities: a customer places\n'
        'an order. The model is discussed\n'
        'with the customer first, because\n'
        'mistakes are cheap to fix at\n'
        'this early stage.',
    prompt:
        'Beschreibe auf Deutsch anhand des Textes, was eine Entität und was eine Beziehung ist. Gib außerdem an, warum das Modell laut Text zuerst mit dem Kunden besprochen wird.',
    kriterien: [
      krit(
        'Entität: ein reales Objekt, z. B. ein einzelner Kunde oder ein Produkt.',
        punkte: 1,
        stichwoerter: [
          'reales Objekt',
          'Objekt',
          'Gegenstand',
          'einzelner Kunde',
        ],
      ),
      krit(
        'Beziehung: verbindet zwei Entitäten, z. B. ein Kunde gibt eine Bestellung auf.',
        punkte: 1,
        stichwoerter: [
          'verbindet',
          'Verbindung',
          'verknüpft',
          'zwei Entitäten',
        ],
      ),
      krit(
        'Grund: Fehler lassen sich in dieser frühen Phase günstig beheben.',
        punkte: 2,
        stichwoerter: [
          'günstig',
          'billig',
          'frühe Phase',
          'früh',
          'wenig Aufwand',
          'Fehler',
        ],
      ),
    ],
    loesung:
        'Eine Entität ist ein reales Objekt, etwa ein bestimmter Kunde oder ein Produkt. Eine Beziehung verbindet zwei Entitäten miteinander, zum Beispiel gibt ein Kunde eine Bestellung auf. Das Modell wird zuerst mit dem Kunden besprochen, weil sich Fehler in dieser frühen Phase noch mit wenig Aufwand beheben lassen.',
    explanation:
        'Geantwortet wird auf Deutsch und mit Bezug zum Text: je 1 Punkt für Entität und Beziehung, 2 Punkte für den Grund (Fehler sind früh günstig zu beheben). Eine wörtliche Übersetzung ist nicht nötig, Stichworte genügen.',
    punkte: 4,
    tags: ['englisch'],
  ),
  paare(
    'i4-de-6',
    'dm-erm',
    scenario:
        'Für eine Schulung der neuen Auszubildenden stellst du die Grundbegriffe des ER-Modells zusammen.',
    prompt: 'Ordne jedem Begriff die passende Erklärung zu.',
    paare: [
      paar('Entität', 'ein einzelnes, unterscheidbares Objekt'),
      paar('Entitätstyp', 'Menge gleichartiger Objekte'),
      paar('Attribut', 'Eigenschaft, die ein Objekt beschreibt'),
      paar('Beziehung', 'Verbindung zwischen Objekten'),
      paar('Schlüsselattribut', 'identifiziert ein Objekt eindeutig'),
    ],
    explanation:
        'Die Kundin mit der Nummer 10457 ist eine Entität, „Kunde“ der Entitätstyp. Attribute beschreiben, Beziehungen verbinden, das Schlüsselattribut identifiziert eindeutig und wird später zum Primärschlüssel.',
    punkte: 3,
    difficulty: 1,
  ),

  // ============================================================ Kardinalitäten
  lueckentext(
    'i4-dk-1',
    'dm-kardinalitaet',
    scenario:
        'Die Pixelhafen Medien GmbH modelliert ihre Projektverwaltung. Es gelten diese Regeln:\n'
        '- Jedes Projekt gehört zu genau einem Kunden, ein Kunde kann mehrere Projekte beauftragen.\n'
        '- An einem Projekt arbeiten mehrere Mitarbeiter, ein Mitarbeiter arbeitet an mehreren Projekten.\n'
        '- Jeder Mitarbeiter hat höchstens einen Firmenlaptop, jeder Laptop ist genau einem Mitarbeiter zugeteilt.',
    skizze: ErmDiagramm(
      [
        ErmEntitaet('Kunde'),
        ErmEntitaet('Projekt'),
        ErmEntitaet('Mitarbeiter'),
        ErmEntitaet('Laptop'),
      ],
      beziehungen: [
        ErmBeziehung('Kunde', 'beauftragt', 'Projekt', '?', '?'),
        ErmBeziehung('Mitarbeiter', 'arbeitet an', 'Projekt', '?', '?'),
        ErmBeziehung('Mitarbeiter', 'nutzt', 'Laptop', '?', '?'),
      ],
    ),
    prompt: 'Ergänze die Kardinalitäten der drei Beziehungen.',
    text:
        'Kunde - Projekt: {0}\n'
        'Mitarbeiter - Projekt: {1}\n'
        'Mitarbeiter - Laptop: {2}',
    luecken: [
      wahl('1:n', [
        'n:1',
        'n:m',
        '1:1',
      ], 'Ein Kunde, viele Projekte. Die 1 steht beim Kunden.'),
      wahl('n:m', [
        '1:n',
        'n:1',
        '1:1',
      ], 'Viele Mitarbeiter je Projekt und viele Projekte je Mitarbeiter.'),
      wahl('1:1', ['1:n', 'n:1', 'n:m'], 'Auf beiden Seiten höchstens einer.'),
    ],
    explanation:
        'Jede Regel in beide Richtungen lesen. Kunde - Projekt: ein Kunde hat viele Projekte, ein Projekt genau einen Kunden -> 1:n. Mitarbeiter - Projekt: viele auf beiden Seiten -> n:m. Mitarbeiter - Laptop: höchstens einer auf beiden Seiten -> 1:1.',
    punkte: 3,
  ),
  tabelle(
    'i4-dk-2',
    'dm-kardinalitaet',
    scenario:
        'Bei der Kessler & Brandt IT-Systemhaus GmbH besuchen Mitarbeiter Schulungen. Ein Mitarbeiter besucht mehrere Schulungen, eine Schulung hat mehrere Teilnehmer. Zu jeder Teilnahme wird das Datum gespeichert. Vorhanden sind die Tabellen Mitarbeiter (PersNr, Name) und Schulung (SchulungsNr, Titel).',
    prompt:
        'Löse die n:m-Beziehung auf: Vervollständige die Zwischentabelle „Teilnahme“.',
    zeilen: [
      ['Spalte', 'Schlüsselrolle', 'verweist auf Tabelle'],
      [
        'PersNr',
        wahl('Teil des Primärschlüssels und Fremdschlüssel', [
          'nur Primärschlüssel',
          'kein Schlüssel',
        ]),
        wahl('Mitarbeiter', ['Schulung', 'keine']),
      ],
      [
        'SchulungsNr',
        wahl('Teil des Primärschlüssels und Fremdschlüssel', [
          'nur Fremdschlüssel',
          'kein Schlüssel',
        ]),
        wahl('Schulung', ['Mitarbeiter', 'keine']),
      ],
      [
        'Datum',
        wahl('kein Schlüssel', [
          'nur Primärschlüssel',
          'nur Fremdschlüssel',
        ], 'Attribut der Beziehung.'),
        'keine',
      ],
    ],
    explanation:
        'Eine n:m-Beziehung wird durch eine Zwischentabelle in zwei 1:n-Beziehungen aufgelöst. Die Zwischentabelle übernimmt die Primärschlüssel beider Seiten als Fremdschlüssel; zusammen bilden sie ihren Primärschlüssel. Attribute der Beziehung wie das Datum kommen als normale Spalten dazu.',
    punkte: 5,
  ),
  freitext(
    'i4-dk-3',
    'dm-kardinalitaet',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH bezieht Artikel von Lieferanten. Ein Lieferant liefert viele Artikel, derselbe Artikel kann von mehreren Lieferanten bezogen werden. Eine Kollegin schlägt vor, in der Tabelle Artikel einfach die Spalte LieferantNr zu ergänzen.',
    prompt:
        'Erläutere, warum dieser Vorschlag die Beziehung nicht abbilden kann, und beschreibe die richtige Umsetzung im relationalen Modell.',
    kriterien: [
      krit(
        'Mit einer Spalte LieferantNr in Artikel kann jeder Artikel nur genau einen Lieferanten haben. Das wäre 1:n statt n:m.',
        punkte: 2,
        stichwoerter: [
          'nur einen Lieferanten',
          'ein Lieferant',
          '1:n',
          'nur einer',
          'einzigen Lieferanten',
        ],
      ),
      krit(
        'Richtig ist eine Zwischentabelle mit ArtikelNr und LieferantNr als Fremdschlüsseln (zusammen Primärschlüssel).',
        punkte: 2,
        stichwoerter: [
          'Zwischentabelle',
          'Verknüpfungstabelle',
          'Beziehungstabelle',
          'Hilfstabelle',
          'dritte Tabelle',
        ],
      ),
    ],
    loesung:
        'Eine einzelne Fremdschlüsselspalte LieferantNr in Artikel kann pro Artikel nur einen Lieferanten aufnehmen. Damit wäre nur eine 1:n-Beziehung abgebildet, verlangt ist aber n:m. Richtig ist eine Zwischentabelle, z. B. Lieferbeziehung, mit den Fremdschlüsseln ArtikelNr und LieferantNr, die gemeinsam den Primärschlüssel bilden. So entstehen zwei 1:n-Beziehungen.',
    explanation:
        '2 Punkte für die Begründung (eine Spalte = nur ein Lieferant, also 1:n), 2 Punkte für die Zwischentabelle mit beiden Fremdschlüsseln. Mehrere Spalten Lieferant1, Lieferant2 wären ebenfalls falsch: Sie verletzen die 1NF.',
    punkte: 4,
  ),
  markieren(
    'i4-dk-4',
    'dm-kardinalitaet',
    scenario:
        'Für die Datenbank der Elbtal Logistik AG wurden die folgenden Regeln aufgenommen. Bei der Umsetzung in Tabellen soll der Aufwand geschätzt werden.',
    prompt:
        'Markiere alle Regeln, für deren Umsetzung eine Zwischentabelle nötig ist.',
    zeilen: [
      nein(
        'Jeder Handscanner ist genau einer Halle zugeordnet, eine Halle hat viele Handscanner.',
        '1:n, Fremdschlüssel HallenNr in Handscanner genügt.',
      ),
      ja(
        'Eine Lieferung enthält viele Artikel, ein Artikel kommt in vielen Lieferungen vor.',
        'n:m, nur mit Zwischentabelle abbildbar.',
      ),
      ja(
        'Ein Fahrer fährt im Lauf des Jahres viele LKW, ein LKW wird von vielen Fahrern gefahren.',
        'n:m, Zwischentabelle, z. B. Fahrt.',
      ),
      nein(
        'Jede Lieferung kommt von genau einem Lieferanten, ein Lieferant schickt viele Lieferungen.',
        '1:n, Fremdschlüssel LieferantNr in Lieferung.',
      ),
      nein(
        'Jeder Schichtleiter hat genau ein Diensthandy, jedes Diensthandy gehört genau einem Schichtleiter.',
        '1:1, ein Fremdschlüssel auf einer der beiden Seiten reicht.',
      ),
      ja(
        'Ein Mitarbeiter besitzt mehrere Staplerscheine, ein Staplerschein-Typ wird von vielen Mitarbeitern erworben.',
        'n:m, Zwischentabelle mit PersNr und ScheinTyp.',
      ),
    ],
    explanation:
        'Nur n:m-Beziehungen brauchen eine Zwischentabelle. Bei 1:n kommt der Fremdschlüssel in die Tabelle der n-Seite, bei 1:1 auf eine der beiden Seiten.',
    punkte: 3,
  ),
  lueckentext(
    'i4-dk-5',
    'dm-kardinalitaet',
    scenario:
        'Das ER-Modell des Grünwerk-Webshops soll in Tabellen umgesetzt werden.',
    skizze: ErmDiagramm(
      [
        ErmEntitaet('Lieferant'),
        ErmEntitaet('Artikel'),
        ErmEntitaet('Bestellung'),
        ErmEntitaet('Kunde'),
      ],
      beziehungen: [
        ErmBeziehung('Lieferant', 'liefert', 'Artikel', '1', 'n'),
        ErmBeziehung('Bestellung', 'enthält', 'Artikel', 'n', 'm'),
        ErmBeziehung('Kunde', 'gibt auf', 'Bestellung', '1', 'n'),
      ],
    ),
    prompt: 'Ermittle, was bei der Umsetzung mindestens entsteht.',
    text:
        'Tabellen insgesamt: {0}\n'
        'davon Zwischentabellen: {1}\n'
        'Fremdschlüsselspalten insgesamt: {2}',
    luecken: [
      zahl(5, rationale: '4 Entitätstypen + 1 Zwischentabelle.'),
      zahl(1, rationale: 'Nur „enthält“ ist n:m.'),
      zahl(
        4,
        rationale:
            'LieferantNr in Artikel, KundenNr in Bestellung, BestellNr und ArtikelNr in der Zwischentabelle.',
      ),
    ],
    explanation:
        'Vier Entitätstypen ergeben 4 Tabellen. Die n:m-Beziehung „enthält“ braucht eine Zwischentabelle: 4 + 1 = 5. Fremdschlüssel: je einer für die beiden 1:n-Beziehungen (LieferantNr in Artikel, KundenNr in Bestellung) und zwei in der Zwischentabelle: 1 + 1 + 2 = 4.',
    punkte: 3,
    difficulty: 3,
  ),
  tabelle(
    'i4-dk-6',
    'dm-kardinalitaet',
    scenario:
        'Das ER-Modell der Personalverwaltung der Elbtal Logistik AG liegt vor.',
    skizze: ErmDiagramm(
      [
        ErmEntitaet('Abteilung'),
        ErmEntitaet('Mitarbeiter'),
        ErmEntitaet('Schicht'),
      ],
      beziehungen: [
        ErmBeziehung('Abteilung', 'beschäftigt', 'Mitarbeiter', '1', 'n'),
        ErmBeziehung('Mitarbeiter', 'arbeitet in', 'Schicht', 'n', 'm'),
      ],
    ),
    prompt:
        'Lies das Diagramm in beide Richtungen und vervollständige die Aussagen.',
    zeilen: [
      ['Aussage', 'Anzahl'],
      [
        'Ein Mitarbeiter gehört zu ... Abteilung(en).',
        wahl('genau einer', ['mehreren', 'keiner']),
      ],
      [
        'Eine Abteilung beschäftigt ... Mitarbeiter.',
        wahl('mehrere', ['genau einen', 'höchstens einen']),
      ],
      [
        'Ein Mitarbeiter arbeitet in ... Schicht(en).',
        wahl('mehreren', ['genau einer', 'höchstens einer']),
      ],
      [
        'In einer Schicht arbeiten ... Mitarbeiter.',
        wahl('mehrere', ['genau ein', 'höchstens ein']),
      ],
    ],
    explanation:
        'Die Zahl an einer Entität sagt, wie viele davon zu EINER Entität der Gegenseite gehören. 1 bei Abteilung: ein Mitarbeiter hat eine Abteilung. n bei Mitarbeiter: eine Abteilung hat viele Mitarbeiter. n und m: auf beiden Seiten viele.',
    punkte: 4,
  ),

  // ================================================================ Schlüssel
  markieren(
    'i4-dl-1',
    'dm-schluessel',
    scenario:
        'Die Datenbank des Grünwerk-Webshops besteht aus den folgenden Tabellen. Unterstrichen wären in der Dokumentation nur die Primärschlüssel. Die Fremdschlüssel sind noch nicht gekennzeichnet.',
    table: [
      ['Tabelle', 'Spalten'],
      ['Kunde', 'KundenNr, Name, Ort'],
      ['Bestellung', 'BestellNr, Datum, KundenNr'],
      ['Artikel', 'ArtikelNr, Bezeichnung, LieferantNr'],
      ['Position', 'BestellNr, ArtikelNr, Menge'],
      ['Lieferant', 'LieferantNr, Firma'],
    ],
    prompt: 'Markiere alle Spalten, die Fremdschlüssel sind.',
    zeilen: [
      nein('Kunde.KundenNr', 'Primärschlüssel der Tabelle Kunde.'),
      ja('Bestellung.KundenNr', 'Verweist auf den Primärschlüssel von Kunde.'),
      nein('Bestellung.Datum', 'Beschreibendes Attribut ohne Schlüsselrolle.'),
      ja(
        'Artikel.LieferantNr',
        'Verweist auf den Primärschlüssel von Lieferant.',
      ),
      ja(
        'Position.BestellNr',
        'Teil des Primärschlüssels und zugleich Fremdschlüssel auf Bestellung.',
      ),
      ja(
        'Position.ArtikelNr',
        'Teil des Primärschlüssels und zugleich Fremdschlüssel auf Artikel.',
      ),
      nein('Position.Menge', 'Attribut der Beziehung, kein Schlüssel.'),
      nein('Lieferant.LieferantNr', 'Primärschlüssel der Tabelle Lieferant.'),
    ],
    mono: true,
    explanation:
        'Ein Fremdschlüssel ist eine Spalte, die auf den Primärschlüssel einer anderen Tabelle verweist. In der Zwischentabelle Position sind BestellNr und ArtikelNr beides: gemeinsam Primärschlüssel und einzeln Fremdschlüssel.',
    punkte: 4,
  ),
  markieren(
    'i4-dl-2',
    'dm-schluessel',
    scenario:
        'In der Tabelle Kunde gibt es genau die Kundennummern K1, K2 und K3. In die Tabelle Bestellung (BestellNr, Datum, KundenNr) sollen die folgenden Datensätze importiert werden. BestellNr ist Primärschlüssel, KundenNr Fremdschlüssel auf Kunde; die referenzielle Integrität ist aktiv.',
    prompt: 'Markiere alle Datensätze, die die Datenbank ablehnt.',
    zeilen: [
      nein('B101 | 02.03. | K1', 'Neue BestellNr, vorhandener Kunde.'),
      nein(
        'B102 | 02.03. | K1',
        'Derselbe Kunde darf mehrfach bestellen: Fremdschlüssel dürfen sich wiederholen.',
      ),
      ja(
        'B103 | 03.03. | K7',
        'K7 gibt es in Kunde nicht: Verstoß gegen die referenzielle Integrität.',
      ),
      ja(
        'B101 | 04.03. | K2',
        'Die BestellNr B101 ist schon vergeben. Ein Primärschlüssel muss eindeutig sein.',
      ),
      nein('B104 | 04.03. | K3', 'Neue BestellNr, vorhandener Kunde.'),
      ja('(leer) | 05.03. | K2', 'Ein Primärschlüssel darf nicht leer sein.'),
    ],
    mono: true,
    explanation:
        'Drei Regeln greifen: Der Primärschlüssel ist eindeutig (B101 doppelt) und nie leer, und jeder Fremdschlüsselwert muss als Primärschlüssel in der referenzierten Tabelle existieren (K7 fehlt). Wiederholte Fremdschlüsselwerte sind dagegen normal.',
    punkte: 3,
    difficulty: 3,
  ),
  freitext(
    'i4-dl-3',
    'dm-schluessel',
    scenario:
        'Die Steuerkanzlei Albers & Partner fragt, wozu die Tabellen Mandant (MandantNr, Name) und Vorgang (VorgangNr, Betreff, MandantNr) Schlüssel brauchen.',
    prompt:
        'Beschreibe am Beispiel die Aufgabe des Primärschlüssels und die Aufgabe des Fremdschlüssels.',
    kriterien: [
      krit(
        'Primärschlüssel (MandantNr in Mandant, VorgangNr in Vorgang): identifiziert jeden Datensatz eindeutig.',
        punkte: 2,
        stichwoerter: [
          'eindeutig',
          'identifiziert',
          'Identifikation',
          'unverwechselbar',
          'einmalig',
        ],
      ),
      krit(
        'Fremdschlüssel (MandantNr in Vorgang): verweist auf den Primärschlüssel der Tabelle Mandant und verknüpft so die Tabellen.',
        punkte: 2,
        stichwoerter: [
          'verweist',
          'Verweis',
          'verknüpft',
          'Verknüpfung',
          'Beziehung',
          'referenziert',
        ],
      ),
    ],
    loesung:
        'Der Primärschlüssel identifiziert jeden Datensatz einer Tabelle eindeutig: Über die MandantNr wird genau ein Mandant, über die VorgangNr genau ein Vorgang angesprochen. Der Fremdschlüssel MandantNr in der Tabelle Vorgang verweist auf den Primärschlüssel der Tabelle Mandant und verknüpft so jeden Vorgang mit seinem Mandanten.',
    explanation:
        'Je Schlüssel 2 Punkte: Aussage plus Bezug zum Beispiel. Primärschlüssel = eindeutige Identifikation, Fremdschlüssel = Verweis auf den Primärschlüssel einer anderen Tabelle. Stichworte genügen.',
    punkte: 4,
    difficulty: 1,
  ),
  markieren(
    'i4-dl-4',
    'dm-schluessel',
    scenario:
        'In einer englischen Fachzeitschrift steht ein kurzer Beitrag über relationale Datenbanken.',
    code:
        'In a relational database every\n'
        'table needs a primary key. Its\n'
        'value must be unique and must\n'
        'never be empty. Many companies\n'
        'use a simple number that is\n'
        'created by the system, because\n'
        'names or e-mail addresses can\n'
        'change. A foreign key stores\n'
        'the primary key of another\n'
        'table. This link keeps related\n'
        'data together and avoids\n'
        'storing the same data twice.',
    prompt: 'Markiere alle Aussagen, die sich dem Text entnehmen lassen.',
    zeilen: [
      ja(
        'Der Wert eines Primärschlüssels darf nicht leer sein.',
        '„must never be empty“.',
      ),
      ja(
        'Viele Unternehmen verwenden eine vom System erzeugte Nummer als Schlüssel.',
        '„a simple number that is created by the system“.',
      ),
      nein(
        'E-Mail-Adressen sind als Primärschlüssel besonders gut geeignet.',
        'Im Gegenteil: Der Text nennt sie als Beispiel für Werte, die sich ändern können.',
      ),
      ja(
        'Ein Fremdschlüssel enthält den Primärschlüssel einer anderen Tabelle.',
        '„stores the primary key of another table“.',
      ),
      nein(
        'Jede Tabelle braucht mindestens einen Fremdschlüssel.',
        'Verlangt wird nur ein Primärschlüssel für jede Tabelle.',
      ),
      ja(
        'Durch die Verknüpfung müssen dieselben Daten nicht doppelt gespeichert werden.',
        '„avoids storing the same data twice“.',
      ),
      nein(
        'Fremdschlüssel müssen eindeutig sein.',
        'Das steht nicht im Text. Eindeutig sein muss der Primärschlüssel.',
      ),
    ],
    explanation:
        'Der Text nennt vier Aussagen: Primärschlüssel eindeutig und nie leer, oft eine vom System vergebene Nummer (weil sich Namen und E-Mail-Adressen ändern), Fremdschlüssel speichert den Primärschlüssel einer anderen Tabelle, die Verknüpfung vermeidet doppelte Speicherung. Nur werten, was wirklich im Text steht.',
    punkte: 4,
    tags: ['englisch'],
  ),
  lueckentext(
    'i4-dl-5',
    'dm-schluessel',
    scenario:
        'Du ergänzt das Glossar im Wiki der IT-Abteilung um den Eintrag „Schlüssel in relationalen Datenbanken“.',
    prompt: 'Setze die passenden Begriffe ein.',
    text:
        'Ein {0} identifiziert jeden Datensatz einer Tabelle eindeutig. '
        'Ein {1} verweist auf den Primärschlüssel einer anderen Tabelle. '
        'Besteht ein Schlüssel aus mehreren Spalten, heißt er {2}. '
        'Eine vom System vergebene Nummer ohne fachliche Bedeutung ist ein {3} Schlüssel. '
        'Dass jeder Fremdschlüsselwert als Primärschlüssel vorhanden sein muss, nennt man {4}.',
    luecken: [
      wort(['Primärschlüssel']),
      wort(['Fremdschlüssel']),
      wort(['zusammengesetzt']),
      wort(['künstlicher']),
      wort(['referenzielle Integrität']),
    ],
    wortbank: ['Alternativschlüssel', 'Redundanz', 'atomar', 'natürlicher'],
    explanation:
        'Primärschlüssel = eindeutige Identifikation, Fremdschlüssel = Verweis auf einen Primärschlüssel. Ein zusammengesetzter Schlüssel besteht aus mehreren Spalten, ein künstlicher Schlüssel (Surrogatschlüssel) hat keine fachliche Bedeutung. Die referenzielle Integrität verhindert Verweise ins Leere.',
    punkte: 5,
    difficulty: 1,
  ),
  tabelle(
    'i4-dl-6',
    'dm-schluessel',
    scenario:
        'Für die Datenbank der Pixelhafen Medien GmbH sind die Primärschlüssel festzulegen.',
    prompt: 'Wähle für jede Tabelle den geeigneten Primärschlüssel.',
    zeilen: [
      ['Tabelle (Spalten)', 'Primärschlüssel'],
      [
        'Raum (RaumNr, Etage, Sitzplätze)',
        wahl('RaumNr', ['Etage', 'Etage + Sitzplätze']),
      ],
      [
        'Projektmitarbeit (ProjektNr, PersNr, Rolle): jede Person ist je Projekt einmal eingetragen',
        wahl('ProjektNr + PersNr', ['ProjektNr', 'PersNr', 'Rolle']),
      ],
      [
        'Ansprechpartner (Vorname, Nachname, Firma, Telefon)',
        wahl('künstliche Nummer ergänzen', [
          'Nachname',
          'Vorname + Nachname',
          'Telefon',
        ]),
      ],
      [
        'Rechnung (RechnungsNr, Datum, Betrag, KundenNr)',
        wahl('RechnungsNr', ['KundenNr', 'Datum + Betrag']),
      ],
    ],
    explanation:
        'Ein Primärschlüssel ist eindeutig, nie leer und stabil. RaumNr und RechnungsNr erfüllen das. In der Zwischentabelle Projektmitarbeit ist erst die Kombination ProjektNr + PersNr eindeutig. Namen und Telefonnummern können doppelt vorkommen oder sich ändern, dann wird ein künstlicher Schlüssel ergänzt. KundenNr in Rechnung ist ein Fremdschlüssel und wiederholt sich.',
    punkte: 4,
  ),
  freitext(
    'i4-dl-7',
    'dm-schluessel',
    scenario:
        'In der Datenbank der Elbtal Logistik AG verweist die Tabelle Lieferung über den Fremdschlüssel LieferantNr auf die Tabelle Lieferant. Eine Sachbearbeiterin will einen Lieferanten löschen, zu dem noch 14 Lieferungen gespeichert sind. Die Datenbank meldet einen Fehler.',
    prompt:
        'Erläutere, warum die Datenbank das Löschen ablehnt. Nenne außerdem eine Möglichkeit, wie mit dem Lieferanten stattdessen verfahren werden kann.',
    kriterien: [
      krit(
        'Referenzielle Integrität: Die 14 Lieferungen würden sonst auf einen nicht mehr vorhandenen Lieferanten verweisen (verwaiste Datensätze).',
        punkte: 2,
        stichwoerter: [
          'referenzielle Integrität',
          'verwaist',
          'ins Leere',
          'nicht mehr vorhanden',
          'Fremdschlüssel',
        ],
      ),
      krit(
        'Möglichkeit: Lieferanten als inaktiv kennzeichnen, statt ihn zu löschen.',
        punkte: 1,
        stichwoerter: [
          'inaktiv',
          'deaktivieren',
          'sperren',
          'Kennzeichen',
          'archivieren',
        ],
      ),
      krit(
        'Möglichkeit: zuerst die abhängigen Lieferungen löschen oder umhängen bzw. Löschweitergabe einrichten.',
        punkte: 1,
        stichwoerter: [
          'Löschweitergabe',
          'kaskadierend',
          'Kaskade',
          'zuerst die Lieferungen',
          'abhängigen Datensätze',
        ],
      ),
    ],
    loesung:
        'Die referenzielle Integrität verlangt, dass jeder Fremdschlüsselwert als Primärschlüssel existiert. Würde der Lieferant gelöscht, verwiesen die 14 Lieferungen auf einen Lieferanten, den es nicht mehr gibt. Stattdessen kann der Lieferant als inaktiv gekennzeichnet werden; alternativ müssten zuerst die abhängigen Lieferungen gelöscht oder eine Löschweitergabe eingerichtet werden, was hier wegen der Aufbewahrung der Belege kaum sinnvoll ist.',
    explanation:
        '2 Punkte für die Begründung über die referenzielle Integrität, 1 Punkt für eine genannte Möglichkeit. Verlangt ist nur eine, die Lösungsliste ist länger. In der Praxis werden Stammdaten mit abhängigen Belegen deaktiviert statt gelöscht.',
    punkte: 3,
  ),

  // ============================================================ Normalisierung
  markieren(
    'i4-dn-1',
    'dm-normalisierung',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH führt ihre Bestellungen bisher in einer einzigen Tabelle. Die Kundin Yilmaz (K2) zieht von Kassel nach Köln um.',
    table: [
      ['Zeile', 'BestellNr', 'KundenNr', 'Name', 'Ort', 'Artikel'],
      ['1', 'B101', 'K1', 'Brandt', 'Kassel', 'Spaten'],
      ['2', 'B102', 'K2', 'Yilmaz', 'Kassel', 'Rasenmäher'],
      ['3', 'B103', 'K3', 'Nowak', 'Fulda', 'Gießkanne'],
      ['4', 'B104', 'K2', 'Yilmaz', 'Kassel', 'Gartenschlauch'],
      ['5', 'B105', 'K1', 'Brandt', 'Kassel', 'Harke'],
      ['6', 'B106', 'K2', 'Yilmaz', 'Kassel', 'Spaten'],
    ],
    prompt:
        'Markiere alle Zeilen, in denen der Ort geändert werden muss, damit die Daten widerspruchsfrei bleiben.',
    zeilen: [
      nein('Zeile 1', 'Kunde Brandt (K1) wohnt weiter in Kassel.'),
      ja('Zeile 2', 'Bestellung der Kundin Yilmaz (K2).'),
      nein('Zeile 3', 'Kunde Nowak (K3) ist nicht betroffen.'),
      ja('Zeile 4', 'Bestellung der Kundin Yilmaz (K2).'),
      nein(
        'Zeile 5',
        'Kunde Brandt wohnt zwar in Kassel, zieht aber nicht um.',
      ),
      ja('Zeile 6', 'Bestellung der Kundin Yilmaz (K2).'),
    ],
    explanation:
        'Der Ort der Kundin ist redundant in drei Zeilen gespeichert. Wird nur eine davon geändert, widersprechen sich die Daten: eine Änderungsanomalie. In normalisierter Form stünde der Ort genau einmal in einer Tabelle Kunde.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i4-dn-2',
    'dm-normalisierung',
    scenario:
        'Die Pixelhafen Medien GmbH verwaltet Kundenprojekte bisher in einer Tabellenkalkulation. Der Auszug zeigt drei Zeilen.',
    table: [
      ['ProjektNr', 'Titel', 'Kunde', 'Telefon Kunde'],
      ['P1', 'Relaunch Website', 'Bäckerei Krume', '0341 5550101'],
      ['P2', 'Newsletter', 'Bäckerei Krume', '0341 5550101'],
      ['P3', 'Onlineshop', 'Bäckerei Krume', '0341 5550101'],
    ],
    prompt:
        'Erkläre anhand der Tabelle den Begriff Redundanz und beschreibe ein Problem, das dadurch entstehen kann.',
    kriterien: [
      krit(
        'Redundanz: Dieselbe Information (Kundenname und Telefonnummer) ist mehrfach gespeichert.',
        punkte: 2,
        stichwoerter: [
          'mehrfach',
          'doppelt',
          'mehrmals',
          'wiederholt',
          'dieselbe Information',
        ],
      ),
      krit(
        'Problem: Inkonsistenz. Wird die Telefonnummer nur in einer Zeile geändert, widersprechen sich die Daten (Änderungsanomalie).',
        punkte: 2,
        stichwoerter: [
          'Inkonsistenz',
          'inkonsistent',
          'widersprechen',
          'widersprüchlich',
          'Änderungsanomalie',
          'Anomalie',
        ],
      ),
      krit(
        'Problem: höherer Speicherbedarf und mehr Pflegeaufwand.',
        punkte: 2,
        stichwoerter: [
          'Speicherbedarf',
          'Speicherplatz',
          'Pflegeaufwand',
          'Aufwand',
        ],
      ),
    ],
    loesung:
        'Redundanz bedeutet, dass dieselbe Information mehrfach gespeichert ist. Hier stehen Name und Telefonnummer der Bäckerei Krume in jeder Projektzeile. Ändert sich die Telefonnummer und wird sie nur in einer Zeile angepasst, widersprechen sich die Daten (Inkonsistenz, Änderungsanomalie). Außerdem kostet die Mehrfachspeicherung Speicherplatz und Pflegeaufwand.',
    explanation:
        '2 Punkte für die Erklärung (mehrfach gespeicherte gleiche Information), 2 Punkte für ein beschriebenes Problem. Verlangt ist ein Problem, die Liste nennt zwei, gewertet wird bis zur Höchstpunktzahl von 4.',
    punkte: 4,
  ),
  lueckentext(
    'i4-dn-3',
    'dm-normalisierung',
    scenario:
        'Die Tabelle Kurstermin der Kessler & Brandt IT-Systemhaus GmbH hat die Spalten KursNr, TeilnehmerNr, Kurstitel, Teilnehmername, RaumNr und Raumgröße. Primärschlüssel ist KursNr + TeilnehmerNr. Der Kurstitel hängt nur von der KursNr ab; jeder Kurs findet in genau einem Raum statt, die Raumgröße hängt von der RaumNr ab. Alle Werte sind atomar.',
    prompt: 'Ergänze die Beurteilung der Tabelle.',
    text:
        'Die Tabelle erfüllt die {0}, weil alle Werte atomar sind. '
        'Der Kurstitel hängt nur von einem Teil des Schlüssels ab, eine {1} Abhängigkeit, die die {2} verletzt. '
        'Die Raumgröße hängt über die RaumNr von der KursNr ab, eine {3} Abhängigkeit, die die {4} verletzt.',
    luecken: [
      wahl('1NF', ['2NF', '3NF']),
      wahl('partielle', ['transitive', 'redundante']),
      wahl('2NF', ['1NF', '3NF']),
      wahl('transitive', ['partielle', 'atomare']),
      wahl('3NF', ['1NF', '2NF']),
    ],
    explanation:
        '1NF: atomare Werte. 2NF: Kein Nichtschlüsselattribut hängt nur von einem Teil eines zusammengesetzten Schlüssels ab (partielle Abhängigkeit). 3NF: Kein Nichtschlüsselattribut hängt über ein anderes Nichtschlüsselattribut vom Schlüssel ab (transitive Abhängigkeit). Kurstitel und Raumdaten werden in eigene Tabellen ausgelagert.',
    punkte: 5,
    difficulty: 3,
  ),
  freitext(
    'i4-dn-4',
    'dm-normalisierung',
    scenario:
        'Die Elbtal Logistik AG speichert ihre Stapler und deren Wartungsfirmen in einer Tabelle. Zu jedem Stapler steht die zuständige Wartungsfirma mit Telefonnummer in derselben Zeile.',
    table: [
      ['StaplerNr', 'Typ', 'Wartungsfirma', 'Telefon'],
      ['S1', 'Schubmast', 'Hubtec', '0391 5550140'],
      ['S2', 'Gegengewicht', 'Hubtec', '0391 5550140'],
      ['S3', 'Schubmast', 'Liftwerk', '0391 5550177'],
    ],
    prompt:
        'Beschreibe anhand der Tabelle zwei Anomalien, die beim Arbeiten mit diesen Daten auftreten können.',
    kriterien: [
      krit(
        'Änderungsanomalie: Ändert sich die Telefonnummer von Hubtec und wird sie nur in einer Zeile angepasst, widersprechen sich die Daten.',
        punkte: 2,
        stichwoerter: [
          'Änderungsanomalie',
          'ändern',
          'Änderung',
          'widersprechen',
          'inkonsistent',
        ],
      ),
      krit(
        'Löschanomalie: Wird Stapler S3 gelöscht, gehen auch Name und Telefonnummer der Firma Liftwerk verloren.',
        punkte: 2,
        stichwoerter: [
          'Löschanomalie',
          'löschen',
          'gelöscht',
          'verloren',
          'gehen verloren',
        ],
      ),
      krit(
        'Einfügeanomalie: Eine neue Wartungsfirma lässt sich erst speichern, wenn ihr ein Stapler zugeordnet ist.',
        punkte: 2,
        stichwoerter: [
          'Einfügeanomalie',
          'einfügen',
          'anlegen',
          'neue Wartungsfirma',
          'ohne Stapler',
        ],
      ),
    ],
    loesung:
        'Änderungsanomalie: Die Telefonnummer von Hubtec steht in zwei Zeilen. Wird sie nur in einer geändert, sind die Daten widersprüchlich. Löschanomalie: Wird der einzige Stapler der Firma Liftwerk (S3) gelöscht, verschwinden auch die Daten der Firma. Einfügeanomalie: Eine neue Wartungsfirma kann erst erfasst werden, wenn ihr ein Stapler zugeordnet ist.',
    explanation:
        'Je beschriebener Anomalie 2 Punkte, verlangt sind zwei von drei. Ursache ist die Redundanz: Die Firmendaten gehören in eine eigene Tabelle Wartungsfirma, auf die der Stapler per Fremdschlüssel verweist.',
    punkte: 4,
  ),

  // ============================================================ Aufbau einer URL
  tabelle(
    'i4-wu-1',
    'wi-url',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH testet eine neue Version ihres Webshops. Im Testprotokoll steht diese Adresse: https://shop.gruenwerk.example:8443/artikel/liste?kat=rasen#top',
    prompt:
        'Zerlege die URL: Trage zu jedem Bestandteil den Wert aus der Adresse ein.',
    zeilen: [
      ['Bestandteil', 'Wert'],
      [
        'Schema (Protokoll)',
        wort(['https', 'https://']),
      ],
      [
        'Host',
        wort(['shop.gruenwerk.example']),
      ],
      ['Port', zahl(8443)],
      [
        'Pfad',
        wort(['/artikel/liste', 'artikel/liste']),
      ],
      [
        'Query',
        wort(['kat=rasen', '?kat=rasen']),
      ],
      [
        'Fragment',
        wort(['top', '#top']),
      ],
    ],
    explanation:
        'Aufbau: Schema://Host:Port/Pfad?Query#Fragment. Das Schema steht vor ://, der Host reicht bis zum Doppelpunkt, danach folgt der Port. Der Pfad beginnt mit /, die Query hinter ?, das Fragment hinter #.',
    punkte: 6,
  ),
  paare(
    'i4-wu-2',
    'wi-url',
    scenario:
        'Ein neuer Kollege im Kundenservice soll Fehlermeldungen mit URL besser einordnen können.',
    prompt: 'Ordne jedem Bestandteil einer URL seine Aufgabe zu.',
    paare: [
      paar('Schema', 'legt das Protokoll fest'),
      paar('Host', 'benennt den Server'),
      paar('Port', 'wählt den Dienst auf dem Server'),
      paar('Pfad', 'benennt die Ressource'),
      paar('Query', 'übergibt Parameter an den Server'),
      paar('Fragment', 'Sprungziel innerhalb der Seite'),
    ],
    explanation:
        'Schema = Protokoll (http, https), Host = Server, Port = Dienst (ohne Angabe 80 bzw. 443), Pfad = Ressource, Query = Parameter als name=wert, Fragment = Stelle in der Seite. Es wird nicht an den Server geschickt.',
    punkte: 3,
    difficulty: 1,
  ),
  markieren(
    'i4-wu-3',
    'wi-url',
    scenario:
        'Beschäftigte der Grünwerk Gartenbedarf GmbH erhalten E-Mails mit Links, die angeblich zum Firmenportal führen. Die echte Domain des Unternehmens ist gruenwerk.example.',
    prompt:
        'Markiere alle Links, die NICHT zu einem Server der Domain gruenwerk.example führen.',
    zeilen: [
      nein(
        'https://portal.gruenwerk.example/login',
        'Host portal.gruenwerk.example: Subdomain der echten Domain.',
      ),
      ja(
        'https://gruenwerk.example.login-sicher.test/',
        'Die Domain steht direkt vor der TLD: login-sicher.test. „gruenwerk.example“ ist hier nur Subdomain.',
      ),
      ja(
        'https://gruenwerk-example.test/portal',
        'Andere Domain: gruenwerk-example mit der TLD test.',
      ),
      nein(
        'https://gruenwerk.example/portal?id=7',
        'Die echte Domain, Pfad und Query ändern daran nichts.',
      ),
      ja(
        'https://login.example/gruenwerk.example',
        'Der Host ist login.example. Der Firmenname steht nur im Pfad.',
      ),
      nein(
        'https://shop.gruenwerk.example:8443/',
        'Echte Domain mit Subdomain shop und abweichendem Port.',
      ),
    ],
    mono: true,
    explanation:
        'Entscheidend ist der Host zwischen :// und dem nächsten /. Ihn liest man von rechts: erst die TLD, direkt davor die registrierte Domain. Alles links davon sind frei wählbare Subdomains, alles hinter dem ersten / ist nur Pfad. Beides nutzen Phishing-Links aus.',
    punkte: 3,
    difficulty: 3,
  ),
  lueckentext(
    'i4-wu-4',
    'wi-url',
    scenario:
        'Die Seite https://www.pixelhafen.example/kunden/projekte/liste.html enthält mehrere Links.',
    prompt:
        'Gib an, welche Adresse der Browser beim Klick auf den jeweiligen Link aufruft.',
    text:
        'href="details.html" führt zu {0}\n'
        'href="../kontakt.html" führt zu {1}\n'
        'href="/impressum.html" führt zu {2}',
    luecken: [
      wahl(
        '…/kunden/projekte/details.html',
        ['…/kunden/details.html', '…/details.html'],
        'Ohne Zusatz: gleicher Ordner wie die aktuelle Seite.',
      ),
      wahl(
        '…/kunden/kontakt.html',
        ['…/kunden/projekte/kontakt.html', '…/kontakt.html'],
        '.. geht vom Ordner /kunden/projekte/ eine Ebene höher.',
      ),
      wahl('…/impressum.html', [
        '…/kunden/impressum.html',
        '…/kunden/projekte/impressum.html',
      ], 'Ein führender / beginnt an der Wurzel des Servers.'),
    ],
    explanation:
        'Relative Adressen werden vom Ordner der aktuellen Seite aus aufgelöst: Dateiname allein = gleicher Ordner, ../ = eine Ebene höher, führender / = ab der Wurzel. Schema und Host (https://www.pixelhafen.example) bleiben jeweils erhalten.',
    punkte: 3,
  ),

  // ============================================================ HTTP und HTTPS
  tabelle(
    'i4-wh-1',
    'wi-http',
    scenario:
        'Im Zugriffsprotokoll des Grünwerk-Webshops tauchen verschiedene HTTP-Statuscodes auf. Für die Fehlersuche soll geklärt werden, was sie bedeuten und wo die Ursache liegt.',
    prompt: 'Vervollständige die Tabelle.',
    zeilen: [
      ['Code', 'Bedeutung', 'Ursache liegt'],
      [
        '200',
        wahl('Anfrage erfolgreich', [
          'Seite nicht gefunden',
          'dauerhaft umgezogen',
        ]),
        'nirgends (kein Fehler)',
      ],
      [
        '301',
        wahl('dauerhaft umgezogen', [
          'Zugriff verweigert',
          'interner Serverfehler',
        ]),
        'nirgends (Umleitung)',
      ],
      [
        '403',
        wahl('Zugriff verweigert', [
          'Seite nicht gefunden',
          'Dienst nicht verfügbar',
        ]),
        wahl('bei der Anfrage (Client)', ['beim Server', 'beim DNS']),
      ],
      [
        '404',
        wahl('Seite nicht gefunden', [
          'Zugriff verweigert',
          'Anfrage erfolgreich',
        ]),
        wahl('bei der Anfrage (Client)', ['beim Server', 'beim DNS']),
      ],
      [
        '500',
        wahl('interner Serverfehler', [
          'Seite nicht gefunden',
          'dauerhaft umgezogen',
        ]),
        wahl('beim Server', ['bei der Anfrage (Client)', 'beim DNS']),
      ],
      [
        '503',
        wahl('Dienst nicht verfügbar', [
          'Zugriff verweigert',
          'Anfrage erfolgreich',
        ]),
        wahl('beim Server', ['bei der Anfrage (Client)', 'beim DNS']),
      ],
    ],
    explanation:
        'Die erste Ziffer bestimmt die Klasse: 2xx Erfolg, 3xx Umleitung, 4xx Fehler in der Anfrage (falsche Adresse, fehlende Rechte), 5xx Fehler beim Server (Programmfehler, Überlastung, Wartung). Ein Statuscode kommt immer aus der HTTP-Antwort, DNS und Verbindung haben also funktioniert.',
    punkte: 5,
  ),
  markieren(
    'i4-wh-2',
    'wi-http',
    scenario:
        'Kunden der Grünwerk Gartenbedarf GmbH melden, dass der Webshop zeitweise nicht funktioniert. Du siehst dir einen Auszug aus dem Zugriffsprotokoll des Webservers an (Uhrzeit, Methode, Pfad, Statuscode).',
    prompt:
        'Markiere alle Zeilen, die auf einen Fehler auf der Seite des Servers hinweisen.',
    zeilen: [
      nein('10:02:11 GET /artikel/17 200', '200 OK: erfolgreich.'),
      nein(
        '10:02:14 GET /artikle/17 404',
        '404: Tippfehler im Pfad, ein Fehler in der Anfrage.',
      ),
      ja(
        '10:02:19 POST /warenkorb 500',
        '500 Internal Server Error: Programmfehler auf dem Server.',
      ),
      nein(
        '10:02:25 GET /alt/katalog 301',
        '301: dauerhafte Umleitung, kein Fehler.',
      ),
      ja(
        '10:02:31 POST /kasse 503',
        '503 Service Unavailable: Server überlastet oder in Wartung.',
      ),
      nein(
        '10:02:40 GET /admin 403',
        '403: Zugriff verweigert, ein Fehler auf Client-Seite (fehlende Berechtigung).',
      ),
      ja(
        '10:02:48 GET /artikel/22 500',
        '500: wieder ein Fehler der Serveranwendung.',
      ),
    ],
    mono: true,
    explanation:
        'Serverfehler erkennt man an 5xx: 500 (Programmfehler) und 503 (Dienst nicht verfügbar). 4xx-Codes wie 403 und 404 gehen auf die Anfrage zurück, 2xx und 3xx sind keine Fehler.',
    punkte: 3,
  ),
  freitext(
    'i4-wh-3',
    'wi-http',
    scenario:
        'Die Steuerkanzlei Albers & Partner will ein Mandantenportal anbieten. Ein Partner fragt, warum das Portal nur über HTTPS und nicht über HTTP erreichbar sein soll.',
    prompt:
        'Beschreibe zwei Vorteile, die HTTPS gegenüber HTTP für das Mandantenportal hat.',
    kriterien: [
      krit(
        'Vertraulichkeit: Die Daten (Anmeldedaten, Dokumente) werden per TLS verschlüsselt übertragen und können nicht mitgelesen werden.',
        punkte: 2,
        stichwoerter: [
          'verschlüsselt',
          'Verschlüsselung',
          'mitlesen',
          'Vertraulichkeit',
          'abhören',
        ],
      ),
      krit(
        'Authentizität: Der Server weist sich mit einem Zertifikat aus. Mandanten erkennen, dass sie mit dem echten Portal verbunden sind.',
        punkte: 2,
        stichwoerter: [
          'Zertifikat',
          'Authentizität',
          'echter Server',
          'Identität',
          'ausweisen',
        ],
      ),
      krit(
        'Integrität: Die Daten können unterwegs nicht unbemerkt verändert werden.',
        punkte: 2,
        stichwoerter: [
          'Integrität',
          'verändert',
          'manipuliert',
          'Manipulation',
          'unverändert',
        ],
      ),
    ],
    loesung:
        'HTTPS überträgt HTTP über eine TLS-verschlüsselte Verbindung. Vorteil 1: Anmeldedaten und Dokumente können unterwegs nicht mitgelesen werden (Vertraulichkeit). Vorteil 2: Der Server weist sich mit einem Zertifikat aus, sodass die Mandanten sicher sind, mit dem echten Portal zu kommunizieren (Authentizität). Zusätzlich lassen sich die Daten unterwegs nicht unbemerkt verändern (Integrität).',
    explanation:
        'Je beschriebenem Vorteil 2 Punkte, verlangt sind zwei von drei: Vertraulichkeit, Authentizität des Servers, Integrität. Weitere sinnvolle Antworten wie das Vertrauen der Nutzer oder Browserwarnungen bei HTTP zählen ebenfalls.',
    punkte: 4,
  ),
  lueckentext(
    'i4-wh-4',
    'wi-http',
    scenario:
        'Ein Mandant meldet sich am Portal der Kanzlei an. Der Browser schickt das Formular mit Benutzername und Passwort über HTTPS an den Server portal.albers.example.',
    prompt: 'Ergänze die Anfrage und die Aussagen dazu.',
    text:
        '{0} /login HTTP/1.1\n'
        'Host: {1}\n'
        '\n'
        'Standardport der Verbindung: {2}\n'
        'Antwort bei falschem Passwort: {3}',
    luecken: [
      wahl('POST', [
        'GET',
        'DELETE',
      ], 'Die Formulardaten gehören in den Body, nicht in die URL.'),
      wahl('portal.albers.example', [
        '/login',
        'HTTP/1.1',
      ], 'Der Header Host nennt den Hostnamen.'),
      wahl('443', ['80', '8080'], 'Standardport von HTTPS.'),
      wahl('401 Unauthorized', [
        '404 Not Found',
        '500 Internal Server Error',
      ], 'Die Anmeldung ist fehlgeschlagen.'),
    ],
    mono: true,
    explanation:
        'Die Startzeile besteht aus Methode, Ziel und Version. Passwörter werden mit POST im Body gesendet. Bei GET stünden sie in der URL, im Verlauf und in Protokollen. HTTPS nutzt Port 443. Eine fehlgeschlagene Anmeldung beantwortet der Server mit 401.',
    punkte: 4,
  ),

  // ============================================ Was beim Seitenaufruf passiert
  reihenfolge(
    'i4-wa-1',
    'wi-aufruf',
    scenario:
        'Eine Kundin ruft im Grünwerk-Webshop die Seite https://shop.gruenwerk.example/angebote auf. Die Seite ist dynamisch: Die aktuellen Angebote stehen in einer Datenbank.',
    prompt:
        'Bringe die Schritte vom Absenden der Adresse bis zur fertigen Seite in die richtige Reihenfolge.',
    items: [
      'DNS liefert die IP-Adresse zu shop.gruenwerk.example',
      'Browser baut die TCP-Verbindung zum Server auf',
      'TLS-Handshake sichert die Verbindung',
      'Browser sendet den HTTP-Request GET /angebote',
      'Serverprogramm liest die Angebote aus der Datenbank und erzeugt daraus HTML',
      'Server schickt die HTTP-Response mit dem HTML',
      'Browser rendert die Seite und lädt Bilder und CSS nach',
    ],
    explanation:
        'Name -> IP (DNS) -> Verbindung (TCP) -> Verschlüsselung (TLS) -> Anfrage (HTTP). Bei einer dynamischen Seite erzeugt ein Programm auf dem Server das HTML erst jetzt aus den Daten der Datenbank. Der Browser erhält nur das fertige HTML und stellt es dar.',
    punkte: 4,
  ),
  freitext(
    'i4-wa-2',
    'wi-aufruf',
    scenario:
        'Die Pixelhafen Medien GmbH berät einen Handwerksbetrieb, der bisher eine statische Website hat. Der Betrieb möchte künftig Referenzen selbst pflegen und einen Kundenbereich mit Anmeldung anbieten.',
    prompt:
        'Erläutere den Unterschied zwischen einer statischen und einer dynamischen Website.',
    kriterien: [
      krit(
        'Statisch: Die Seiten liegen als fertige Dateien auf dem Server; jeder Besucher erhält denselben Inhalt.',
        punkte: 2,
        stichwoerter: [
          'fertige Dateien',
          'feste Dateien',
          'gleichen Inhalt',
          'denselben Inhalt',
          'unverändert',
        ],
      ),
      krit(
        'Dynamisch: Die Seite wird beim Aufruf von einem Programm auf dem Server erzeugt, meist aus einer Datenbank, abhängig von Nutzer oder Eingabe.',
        punkte: 2,
        stichwoerter: [
          'beim Aufruf',
          'erzeugt',
          'generiert',
          'Datenbank',
          'serverseitig',
          'abhängig vom Nutzer',
        ],
      ),
    ],
    loesung:
        'Bei einer statischen Website liegen fertige HTML-Dateien auf dem Server und werden unverändert ausgeliefert. Jeder Besucher sieht dasselbe, Änderungen erfordern das Bearbeiten der Dateien. Bei einer dynamischen Website erzeugt ein Programm auf dem Server die Seite bei jedem Aufruf neu, meist aus einer Datenbank. Der Inhalt kann vom angemeldeten Nutzer oder von Eingaben abhängen und lässt sich über ein Redaktionssystem (CMS) pflegen.',
    explanation:
        'Je Seite des Vergleichs 2 Punkte: statisch = fertige Dateien, gleicher Inhalt für alle; dynamisch = beim Aufruf serverseitig erzeugt, oft aus einer Datenbank, nutzer- oder eingabeabhängig. Für Kundenbereich und selbst gepflegte Referenzen braucht der Betrieb eine dynamische Website.',
    punkte: 4,
  ),
  zuordnen(
    'i4-wa-3',
    'wi-aufruf',
    scenario:
        'Die Pixelhafen Medien GmbH sortiert Kundenanfragen danach, ob eine statische Website genügt oder eine dynamische nötig ist.',
    prompt: 'Ordne jede Anforderung der passenden Art von Website zu.',
    buckets: ['statische Website genügt', 'dynamische Website nötig'],
    items: [
      zu(
        'Warenkorb mit Bestellung',
        1,
        'Der Inhalt hängt vom einzelnen Besucher ab.',
      ),
      zu(
        'Visitenkarte eines Malerbetriebs mit Anschrift und Öffnungszeiten',
        0,
        'Der Inhalt ist für alle gleich und ändert sich selten.',
      ),
      zu(
        'Kundenbereich mit Anmeldung und eigenen Rechnungen',
        1,
        'Die Seite wird je Nutzer aus der Datenbank erzeugt.',
      ),
      zu(
        'Einmalige Einladungsseite zu einem Firmenjubiläum',
        0,
        'Fester Inhalt ohne Eingaben.',
      ),
      zu(
        'Suche über den aktuellen Lagerbestand',
        1,
        'Das Ergebnis hängt von der Eingabe und den aktuellen Daten ab.',
      ),
      zu(
        'Online-Handbuch, das zweimal im Jahr neu erzeugt wird',
        0,
        'Fertige Dateien reichen aus.',
      ),
    ],
    explanation:
        'Statisch reicht, wenn alle Besucher denselben, selten geänderten Inhalt sehen. Sobald der Inhalt vom Nutzer, von Eingaben oder von aktuellen Daten abhängt (Anmeldung, Warenkorb, Suche), muss ein Programm auf dem Server die Seite beim Aufruf erzeugen.',
    punkte: 3,
  ),
  freitext(
    'i4-wa-4',
    'wi-aufruf',
    scenario:
        'Für den Kundenbereich des Handwerksbetriebs soll die Website künftig dynamisch erzeugt werden. Der Kunde fragt, womit solche Seiten programmiert werden.',
    prompt:
        'Nenne drei Programmiersprachen, mit denen sich dynamische Webinhalte auf dem Server erzeugen lassen.',
    kriterien: [
      krit('PHP als serverseitige Sprache', stichwoerter: ['PHP']),
      krit('Python als serverseitige Sprache', stichwoerter: ['Python']),
      krit(
        'JavaScript (auf dem Server mit Node.js)',
        stichwoerter: ['JavaScript', 'Node.js', 'Node', 'TypeScript'],
      ),
      krit('Java als serverseitige Sprache', stichwoerter: ['Java']),
      krit('C# (ASP.NET)', stichwoerter: ['C#', 'CSharp', 'ASP.NET', 'ASP']),
      krit('Ruby als serverseitige Sprache', stichwoerter: ['Ruby']),
    ],
    loesung:
        'Zum Beispiel PHP, Python und JavaScript (Node.js); ebenso richtig sind Java, C# (ASP.NET) oder Ruby. HTML und CSS zählen nicht: Sie sind Auszeichnungs- bzw. Gestaltungssprachen und werden vom Server nur ausgeliefert.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Die Lösungsliste ist länger als verlangt. Serverseitige Sprachen erzeugen das HTML, bevor es zum Browser geschickt wird. HTML und CSS sind keine Programmiersprachen.',
    punkte: 3,
    difficulty: 1,
  ),

  // ============================================================== HTML und CSS
  markieren(
    'i4-wt-1',
    'wi-html',
    scenario:
        'Eine Auszubildende der Pixelhafen Medien GmbH hat eine Angebotsseite geschrieben. Der Browser zeigt die Seite fehlerhaft an. Du prüfst den Quelltext.',
    prompt: 'Markiere alle Zeilen, die einen Syntaxfehler enthalten.',
    zeilen: [
      nein('<!DOCTYPE html>', 'Korrekte Dokumenttyp-Angabe.'),
      nein('<html lang="de">', 'Korrekt, mit Sprachangabe.'),
      ja(
        '<head><title>Angebote</titel></head>',
        'Das End-Tag ist falsch geschrieben: </title> statt </titel>.',
      ),
      nein('<body>', 'Korrekt.'),
      ja(
        '<h1>Unsere Angebote</h2>',
        'Start- und End-Tag passen nicht zusammen: h1 wird mit </h1> geschlossen.',
      ),
      nein(
        '<img src="spaten.jpg" alt="Spaten">',
        'Korrekt: img braucht kein End-Tag und hat einen Alt-Text.',
      ),
      ja(
        '<a href="kontakt.html>Kontakt</a>',
        'Das schließende Anführungszeichen des Attributwerts fehlt.',
      ),
      nein('</body></html>', 'Korrekt geschlossen.'),
    ],
    mono: true,
    explanation:
        'Drei Fehler: falsch geschriebenes End-Tag (</titel>), nicht zusammenpassende Tags (<h1> ... </h2>) und ein Attributwert ohne schließendes Anführungszeichen. Elemente bestehen aus Start-Tag, Inhalt und passendem End-Tag; Attribute stehen als name="wert" im Start-Tag.',
    punkte: 3,
  ),
  lueckentext(
    'i4-wt-2',
    'wi-html',
    scenario:
        'Für die Angebotsseite fehlen noch einige Stellen in HTML und CSS. Hinweise sollen rot erscheinen; sie sind im HTML mit class="hinweis" ausgezeichnet.',
    prompt: 'Ergänze den Quelltext.',
    text:
        '<h1>Angebote der Woche{0}\n'
        '<a {1}="agb.html">AGB</a>\n'
        '<img src="logo.png" {2}="Logo">\n'
        '\n'
        '{3} { color: red; }',
    luecken: [
      wahl(
        '</h1>',
        ['<h1>', '</h2>', '<\\h1>'],
        'Das End-Tag wiederholt den Namen mit vorangestelltem Schrägstrich.',
      ),
      wahl('href', ['src', 'link'], 'Das Ziel eines Links steht in href.'),
      wahl('alt', ['title', 'href'], 'Der Alternativtext steht in alt.'),
      wahl('.hinweis', [
        '#hinweis',
        'hinweis',
      ], 'Klassen werden mit einem Punkt ausgewählt.'),
    ],
    mono: true,
    explanation:
        'Ein Element wird mit </name> geschlossen, hier </h1>. href nennt das Linkziel, alt den Alternativtext eines Bildes. In CSS wählt .hinweis alle Elemente mit class="hinweis" aus, #hinweis nur das Element mit id="hinweis".',
    punkte: 4,
  ),
  paare(
    'i4-wt-3',
    'wi-html',
    scenario:
        'Du erstellst für neue Auszubildende eine Übersicht der wichtigsten HTML-Elemente.',
    prompt: 'Ordne jedem Element seine Bedeutung zu.',
    paare: [
      paar('<h1>', 'Hauptüberschrift'),
      paar('<p>', 'Absatz'),
      paar('<a>', 'Link'),
      paar('<img>', 'Bild'),
      paar('<ul>', 'ungeordnete Liste'),
      paar('<table>', 'Tabelle'),
    ],
    explanation:
        'HTML beschreibt, was etwas ist: h1 bis h6 sind Überschriften, p ein Absatz, a ein Link (anchor), img ein Bild, ul eine Aufzählung (unordered list) und table eine Tabelle.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i4-wt-4',
    'wi-html',
    scenario:
        'Auf den alten Seiten eines Kunden der Pixelhafen Medien GmbH stehen Farben und Schriftgrößen direkt in jedem einzelnen HTML-Element. Beim Relaunch soll die Gestaltung in eine zentrale CSS-Datei ausgelagert werden.',
    prompt:
        'Erläutere zwei Vorteile der Trennung von Struktur (HTML) und Gestaltung (CSS).',
    kriterien: [
      krit(
        'Zentrale Pflege: Eine Änderung in der CSS-Datei wirkt auf alle Seiten, also weniger Aufwand.',
        punkte: 2,
        stichwoerter: [
          'zentral',
          'eine Stelle',
          'alle Seiten',
          'einmal ändern',
          'Pflege',
          'Wartung',
        ],
      ),
      krit(
        'Einheitliches Erscheinungsbild auf allen Seiten.',
        punkte: 2,
        stichwoerter: [
          'einheitlich',
          'konsistent',
          'gleiches Aussehen',
          'Corporate Design',
        ],
      ),
      krit(
        'Übersichtlicheres HTML und bessere Zugänglichkeit: Die Struktur bleibt für Screenreader und Suchmaschinen klar.',
        punkte: 2,
        stichwoerter: [
          'übersichtlich',
          'Screenreader',
          'barrierefrei',
          'Suchmaschinen',
          'lesbar',
        ],
      ),
      krit(
        'Verschiedene Darstellungen für dieselbe Struktur, z. B. für Handy, Desktop oder Druck.',
        punkte: 2,
        stichwoerter: [
          'responsiv',
          'responsive',
          'Handy',
          'Druck',
          'Geräte',
          'Media Query',
        ],
      ),
    ],
    loesung:
        'Erstens lässt sich die Gestaltung zentral pflegen: Eine Änderung in der CSS-Datei, etwa einer Farbe, wirkt sofort auf allen Seiten. Zweitens sehen alle Seiten einheitlich aus. Außerdem bleibt das HTML übersichtlich und seine Struktur für Screenreader und Suchmaschinen klar, und dieselbe Seite kann für Handy, Desktop oder Druck unterschiedlich dargestellt werden.',
    explanation:
        'Je erläutertem Vorteil 2 Punkte, verlangt sind zwei. Kern: HTML sagt, was etwas ist, CSS sagt, wie es aussieht. So wird Gestaltung einmal zentral festgelegt statt in jedem Element.',
    punkte: 4,
  ),

  // ========================================================== Barrierefreiheit
  freitext(
    'i4-wf-1',
    'wi-barrierefrei',
    scenario:
        'Der Webshop der Grünwerk Gartenbedarf GmbH muss nach dem Barrierefreiheitsstärkungsgesetz barrierefrei sein. Bei einer Prüfung fällt auf: Produktbilder haben keine Beschreibung, hellgraue Schrift steht auf weißem Grund, das Menü lässt sich nur mit der Maus öffnen und Produktvideos haben keinen Text.',
    prompt:
        'Beschreibe drei Maßnahmen, mit denen der Webshop barrierefreier wird.',
    kriterien: [
      krit(
        'Produktbilder erhalten aussagekräftige Alternativtexte, die Screenreader vorlesen.',
        punkte: 2,
        stichwoerter: [
          'Alt-Text',
          'Alternativtext',
          'alt',
          'Bildbeschreibung',
          'Screenreader',
        ],
      ),
      krit(
        'Kontrast erhöhen: dunklere Schrift, mindestens 4,5:1 für normalen Text.',
        punkte: 2,
        stichwoerter: ['Kontrast', '4,5:1', 'dunklere Schrift', 'lesbar'],
      ),
      krit(
        'Menü und alle Funktionen per Tastatur bedienbar machen, mit sichtbarem Fokus.',
        punkte: 2,
        stichwoerter: ['Tastatur', 'Tab-Taste', 'Fokus', 'ohne Maus'],
      ),
      krit(
        'Videos mit Untertiteln oder einem Transkript versehen.',
        punkte: 2,
        stichwoerter: ['Untertitel', 'Transkript', 'Textfassung'],
      ),
      krit(
        'Schrift vergrößerbar halten und verständliche Sprache bzw. klare Fehlermeldungen verwenden.',
        punkte: 2,
        stichwoerter: [
          'vergrößern',
          'Schriftgröße',
          'einfache Sprache',
          'verständlich',
          'Fehlermeldung',
        ],
      ),
    ],
    loesung:
        'Erstens erhalten alle Produktbilder aussagekräftige Alternativtexte, damit Screenreader sie vorlesen können. Zweitens wird der Kontrast erhöht, etwa dunkle Schrift auf hellem Grund mit mindestens 4,5:1. Drittens wird das Menü vollständig per Tastatur bedienbar gemacht und der Fokus sichtbar hervorgehoben. Zusätzlich sollten die Videos Untertitel oder ein Transkript bekommen.',
    explanation:
        'Je beschriebener Maßnahme 2 Punkte, höchstens 6. Verlangt sind drei, die Situation bietet vier Ansatzpunkte. Die Maßnahmen folgen den WCAG-Prinzipien wahrnehmbar (Alt-Text, Kontrast, Untertitel) und bedienbar (Tastatur).',
    punkte: 6,
  ),
  markieren(
    'i4-wf-2',
    'wi-barrierefrei',
    scenario:
        'Vor der Freigabe prüfst du einen Ausschnitt der Bestellseite auf Barrierefreiheit.',
    prompt:
        'Markiere alle Zeilen, die gegen Regeln der Barrierefreiheit verstoßen.',
    zeilen: [
      nein(
        '<h1>Ihre Bestellung</h1>',
        'Eine klare Hauptüberschrift hilft bei der Orientierung.',
      ),
      ja(
        '<img src="rasenmaeher.jpg">',
        'Inhaltliches Bild ohne alt-Attribut: Screenreader lesen nur den Dateinamen vor.',
      ),
      nein(
        '<label for="plz">Postleitzahl</label>',
        'Sichtbare Beschriftung, per for mit dem Feld verknüpft.',
      ),
      nein(
        '<input id="plz" name="plz" type="text">',
        'Das Feld ist über die id mit seinem label verbunden.',
      ),
      ja(
        '<input name="ort" placeholder="Ort">',
        'Nur ein Platzhalter, kein label: Der Hinweis verschwindet beim Tippen.',
      ),
      ja(
        '<a href="agb.html">hier klicken</a>',
        'Der Linktext sagt nichts über das Ziel. Besser „AGB lesen“.',
      ),
      nein(
        '<button type="submit">Kostenpflichtig bestellen</button>',
        'Ein echtes button-Element mit aussagekräftigem Text.',
      ),
      ja(
        '<p style="color:#ccc">Pflichtfeld</p>',
        'Hellgrau auf Weiß hat zu wenig Kontrast.',
      ),
    ],
    mono: true,
    explanation:
        'Vier Verstöße: fehlender Alt-Text, Eingabefeld ohne label, nichtssagender Linktext und zu geringer Kontrast. Barrierefrei heißt: Inhalte haben eine Textalternative, Felder eine verknüpfte Beschriftung, Links ein erkennbares Ziel und Texte genug Kontrast.',
    punkte: 4,
  ),
  lueckentext(
    'i4-wf-3',
    'wi-barrierefrei',
    scenario:
        'Für das Pflichtenheft des Webshop-Relaunchs fasst du die Anforderungen an die Barrierefreiheit zusammen.',
    prompt: 'Setze die passenden Begriffe ein.',
    text:
        'Die meisten privaten Online-Shops müssen seit dem 28.06.2025 nach dem {0} barrierefrei sein. '
        'Maßstab sind die vier Prinzipien der {1}: wahrnehmbar, bedienbar, verständlich und robust. '
        'Inhaltliche Bilder brauchen einen {2}. '
        'Alle Funktionen müssen auch ohne Maus per {3} erreichbar sein. '
        'Videos erhalten {4}.',
    luecken: [
      wort(['BFSG']),
      wort(['WCAG']),
      wort(['Alternativtext']),
      wort(['Tastatur']),
      wort(['Untertitel']),
    ],
    wortbank: ['DSGVO', 'BITV', 'Platzhalter', 'Farbe'],
    explanation:
        'Das Barrierefreiheitsstärkungsgesetz (BFSG) verpflichtet seit 28.06.2025 viele private Anbieter. Die WCAG nennen vier Prinzipien. Typische Maßnahmen: Alternativtexte, Tastaturbedienung, Untertitel, ausreichender Kontrast. Die BITV 2.0 gilt für öffentliche Stellen des Bundes.',
    punkte: 5,
  ),

  // ============================================================= Zahlensysteme
  tabelle(
    'i4-mz-1',
    'md-zahlensysteme',
    scenario:
        'In der Dokumentation eines Netzwerkgeräts der Elbtal Logistik AG stehen Registerwerte teils dezimal, teils binär und teils hexadezimal.',
    prompt: 'Vervollständige die Tabelle. Schreibe Binärzahlen mit 8 Bit.',
    zeilen: [
      ['dezimal', 'binär', 'hexadezimal'],
      [
        '200',
        wort(['1100 1000', '11001000']),
        wort(['C8']),
      ],
      [
        zahl(110),
        '0110 1110',
        wort(['6E']),
      ],
      [
        zahl(63),
        wort(['0011 1111', '00111111', '111111']),
        '3F',
      ],
    ],
    explanation:
        '200 = 128 + 64 + 8 = 1100 1000; die Vierergruppen 1100 und 1000 ergeben C und 8. 0110 1110 = 64 + 32 + 8 + 4 + 2 = 110; 0110 = 6, 1110 = E. 3F = 3 × 16 + 15 = 63; 3 = 0011, F = 1111. Jede Hex-Ziffer entspricht genau vier Bit.',
    punkte: 6,
  ),
  lueckentext(
    'i4-mz-2',
    'md-zahlensysteme',
    scenario:
        'Ein Messgerät liefert zwei Statusbytes A und B, die ausgewertet werden sollen.',
    skizze: BitDiagramm([
      BitZeile('A', '1011 0110'),
      BitZeile('B', '0100 1101'),
    ]),
    prompt: 'Ermittle die Werte der beiden Bytes.',
    text:
        'A dezimal: {0}\n'
        'A hexadezimal: {1}\n'
        'B dezimal: {2}\n'
        'B hexadezimal: {3}\n'
        'A + B dezimal: {4}',
    luecken: [
      zahl(182, rationale: '128 + 32 + 16 + 4 + 2.'),
      wort(['B6'], '1011 = B, 0110 = 6.'),
      zahl(77, rationale: '64 + 8 + 4 + 1.'),
      wort(['4D'], '0100 = 4, 1101 = D.'),
      zahl(259, rationale: '182 + 77.'),
    ],
    explanation:
        'Stellenwerte eines Bytes: 128 64 32 16 8 4 2 1. A = 128 + 32 + 16 + 4 + 2 = 182, B = 64 + 8 + 4 + 1 = 77. Für Hex je vier Bit zusammenfassen: 1011 0110 = B6, 0100 1101 = 4D. 182 + 77 = 259. Das passt nicht mehr in 8 Bit (höchstens 255).',
    punkte: 5,
  ),
  tabelle(
    'i4-mz-3',
    'md-zahlensysteme',
    scenario:
        'Für die Nummerierung von Lagerplätzen, Geräten und Farben soll geklärt werden, wie viele Werte sich mit einer bestimmten Anzahl Bit darstellen lassen. Die erste Zeile ist als Muster ausgefüllt.',
    prompt: 'Ergänze die Tabelle.',
    zeilen: [
      ['Bit', 'Anzahl Werte', 'größter Wert (ab 0)'],
      ['4', '16', '15'],
      ['8', zahl(256), zahl(255)],
      ['10', zahl(1024), zahl(1023)],
      ['16', zahl(65536), zahl(65535)],
    ],
    explanation:
        'Mit n Bit gibt es 2^n verschiedene Werte. Weil die Zählung bei 0 beginnt, ist der größte Wert 2^n - 1: 8 Bit -> 256 Werte, 0 bis 255; 10 Bit -> 1.024 Werte, 0 bis 1.023; 16 Bit -> 65.536 Werte, 0 bis 65.535.',
    punkte: 3,
  ),
  markieren(
    'i4-mz-4',
    'md-zahlensysteme',
    scenario:
        'In verschiedenen Protokolldateien steht derselbe Sensorwert 90 (dezimal) in unterschiedlicher Schreibweise, daneben aber auch andere Werte.',
    prompt: 'Markiere alle Angaben, die dem Dezimalwert 90 entsprechen.',
    zeilen: [
      ja('hexadezimal 5A', '5 × 16 + 10 = 90.'),
      nein('hexadezimal A5', '10 × 16 + 5 = 165. Ziffern vertauscht.'),
      ja('binär 0101 1010', '64 + 16 + 8 + 2 = 90.'),
      nein('binär 0101 1001', '64 + 16 + 8 + 1 = 89.'),
      ja('oktal 132', '1 × 64 + 3 × 8 + 2 = 90.'),
      nein('hexadezimal 90', '9 × 16 + 0 = 144.'),
    ],
    mono: true,
    explanation:
        '90 = 5 × 16 + 10 = 5A (hex) = 0101 1010 (binär) = 132 (oktal: 64 + 24 + 2). Dieselben Ziffern bedeuten in jedem Zahlensystem etwas anderes: „90“ hexadezimal ist dezimal 144.',
    punkte: 3,
  ),

  // ============================================================= Zeichensätze
  tabelle(
    'i4-mc-1',
    'md-zeichen',
    scenario:
        'Eine Schnittstelle der Grünwerk Gartenbedarf GmbH begrenzt Kundennamen auf eine feste Anzahl Byte. Die Daten werden in UTF-8 übertragen.',
    prompt: 'Gib an, wie viele Byte das Zeichen bzw. der Text in UTF-8 belegt.',
    zeilen: [
      ['Zeichen / Text', 'Codepoint', 'Byte in UTF-8'],
      ['A', 'U+0041', zahl(1)],
      ['ä', 'U+00E4', zahl(2)],
      ['€', 'U+20AC', zahl(3)],
      ['Emoji', 'U+1F600', zahl(4)],
      ['Grüße', '-', zahl(7)],
    ],
    explanation:
        'UTF-8 braucht bis U+007F 1 Byte (ASCII), bis U+07FF 2 Byte (Umlaute, ß), bis U+FFFF 3 Byte (€), darüber 4 Byte (Emojis). „Grüße“: G, r, e je 1 Byte, ü und ß je 2 Byte = 3 + 4 = 7 Byte.',
    punkte: 5,
  ),
  lueckentext(
    'i4-mc-2',
    'md-zeichen',
    scenario:
        'Für eine Prüfroutine brauchst du einige ASCII-Codes. Bekannt sind die Werte aus der Tabelle.',
    table: [
      ['Zeichen', 'dezimal'],
      ['0', '48'],
      ['A', '65'],
      ['a', '97'],
    ],
    prompt: 'Ermittle die fehlenden Werte.',
    text:
        '„D“ dezimal: {0}\n'
        '„d“ dezimal: {1}\n'
        '„7“ dezimal: {2}\n'
        '„A“ hexadezimal: {3}',
    luecken: [
      zahl(68, rationale: '65 + 3.'),
      zahl(100, rationale: '97 + 3 bzw. 68 + 32.'),
      zahl(55, rationale: '48 + 7.'),
      zahl(41, rationale: '65 = 4 × 16 + 1.'),
    ],
    explanation:
        'Buchstaben und Ziffern liegen im ASCII-Code lückenlos hintereinander: D = 65 + 3 = 68, d = 97 + 3 = 100 (Kleinbuchstaben liegen 32 hinter den Großbuchstaben), 7 = 48 + 7 = 55. 65 dezimal = 4 × 16 + 1 = 41 hexadezimal.',
    punkte: 4,
  ),
  freitext(
    'i4-mc-3',
    'md-zeichen',
    scenario:
        'Nach dem Import einer Kundenliste aus dem alten Warenwirtschaftssystem steht im Webshop der Grünwerk Gartenbedarf GmbH „GÃ¤rtner“ statt „Gärtner“ und „MÃ¼ller“ statt „Müller“.',
    prompt:
        'Erläutere die Ursache des Fehlers und beschreibe eine Maßnahme, mit der er sich künftig vermeiden lässt.',
    kriterien: [
      krit(
        'Ursache: Die Datei ist in UTF-8 kodiert, wird aber mit einer anderen Kodierung (z. B. ISO 8859-1) gelesen. Die zwei Byte eines Umlauts erscheinen als zwei Zeichen.',
        punkte: 2,
        stichwoerter: [
          'Kodierung',
          'Zeichensatz',
          'UTF-8',
          'ISO 8859-1',
          'Latin-1',
          'Encoding',
        ],
      ),
      krit(
        'Maßnahme: Durchgängig dieselbe Kodierung (UTF-8) festlegen bzw. beim Import die richtige Kodierung angeben.',
        punkte: 2,
        stichwoerter: [
          'einheitlich',
          'durchgängig',
          'dieselbe Kodierung',
          'beim Import angeben',
          'festlegen',
          'konvertieren',
        ],
      ),
    ],
    loesung:
        'Die Daten wurden in UTF-8 geschrieben, beim Import aber mit einer anderen Kodierung gelesen, etwa ISO 8859-1. In UTF-8 belegt ein Umlaut zwei Byte; diese werden als zwei einzelne Zeichen dargestellt. Abhilfe: in allen Systemen einheitlich UTF-8 verwenden und beim Import ausdrücklich die Kodierung der Quelldatei angeben oder die Datei vorher konvertieren.',
    explanation:
        '2 Punkte für die Ursache (Schreiben und Lesen mit unterschiedlicher Kodierung), 2 Punkte für die Maßnahme (einheitliche Kodierung bzw. Angabe beim Import). Die Daten selbst sind nicht beschädigt, sie werden nur falsch gedeutet.',
    punkte: 4,
  ),
  paare(
    'i4-mc-4',
    'md-zeichen',
    scenario:
        'In einem Übergabeprotokoll tauchen mehrere Begriffe zu Zeichensätzen auf, die du für die Kollegen einordnest.',
    prompt: 'Ordne jedem Begriff die passende Beschreibung zu.',
    paare: [
      paar('ASCII', '7 Bit, 128 Zeichen, keine Umlaute'),
      paar('ISO 8859-1', '8 Bit, westeuropäische Zeichen'),
      paar('Unicode', 'Zeichensatz mit Codepoints für alle Schriften'),
      paar('UTF-8', 'Kodierung mit 1 bis 4 Byte je Zeichen'),
      paar('Codepoint', 'Nummer eines Zeichens, z. B. U+00E4'),
    ],
    explanation:
        'ASCII ist ein 7-Bit-Code mit 128 Zeichen. ISO 8859-1 (Latin-1) erweitert auf 8 Bit mit Umlauten. Unicode gibt jedem Zeichen eine Nummer (Codepoint); UTF-8 legt fest, wie diese Nummern als 1 bis 4 Byte gespeichert werden.',
    punkte: 3,
    difficulty: 1,
  ),

  // ======================================================= Datenmengen berechnen
  lueckentext(
    'i4-md-1',
    'md-datenmengen',
    scenario:
        'Im Lager der Elbtal Logistik AG werden Lieferscheine gescannt und archiviert. Rund um die Uhr fallen im Durchschnitt 22 Lieferscheine pro Stunde an, ein Scan ist 96 kB groß (1 kB = 1.000 Byte, 1 KiB = 1.024 Byte). Das Archivsystem verringert den Speicherbedarf durch Kompression um 25 %. Ein Jahr hat 365 Tage.',
    prompt:
        'Ermittle schrittweise den Speicherbedarf. Runde nur das Endergebnis auf zwei Nachkommastellen.',
    text:
        'Lieferscheine pro Tag: {0}\n'
        'Speicherbedarf pro Tag in KiB: {1}\n'
        'Speicherbedarf pro Jahr in KiB: {2}\n'
        'Jahresbedarf in GiB mit Kompression: {3}',
    luecken: [
      zahl(528, rationale: '22 × 24.'),
      zahl(49500, rationale: '528 × 96 × 1.000 / 1.024.'),
      zahl(18067500, rationale: '49.500 × 365.'),
      zahl(
        12.92,
        toleranz: 0.01,
        einheit: 'GiB',
        rationale: '18.067.500 / 1.024 / 1.024 × 0,75.',
      ),
    ],
    explanation:
        '22 × 24 = 528 Lieferscheine pro Tag. 528 × 96 kB = 50.688 kB = 50.688.000 Byte; / 1.024 = 49.500 KiB. × 365 = 18.067.500 KiB pro Jahr. / 1.024 / 1.024 = 17,23 GiB. „Um 25 % verringern“ heißt, es bleiben 75 %: 17,23 × 0,75 ≈ 12,92 GiB. Fallen: kB ist dezimal, KiB binär, und „um 25 %“ ergibt den Faktor 0,75.',
    punkte: 6,
    difficulty: 3,
  ),
  tabelle(
    'i4-md-2',
    'md-datenmengen',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH fotografiert 2.500 Artikel für den Webshop. Die Kamera liefert Bilder mit 4.000 × 3.000 Pixeln und 24 Bit Farbtiefe. Vor dem Speichern werden die Bilder als JPEG auf 15 % ihrer unkomprimierten Größe komprimiert. Es gilt 1 MB = 1.000.000 Byte und 1 GiB = 1.024³ Byte.',
    prompt:
        'Berechne die Zwischenschritte. Runde den letzten Wert auf zwei Nachkommastellen.',
    zeilen: [
      ['Schritt', 'Ergebnis'],
      ['Ein Foto unkomprimiert in MB', zahl(36)],
      ['Ein Foto als JPEG in MB', zahl(5.4, toleranz: 0.01)],
      ['Alle 2.500 Fotos in MB', zahl(13500, toleranz: 0.5)],
      ['Alle 2.500 Fotos in GiB', zahl(12.57, toleranz: 0.01)],
    ],
    explanation:
        '4.000 × 3.000 = 12.000.000 Pixel × 3 Byte = 36.000.000 Byte = 36 MB. „Auf 15 %“ heißt, es bleiben 15 %: 36 × 0,15 = 5,4 MB. × 2.500 = 13.500 MB = 13.500.000.000 Byte. / 1.024³ ≈ 12,57 GiB. Achtung: „auf 15 %“ (Faktor 0,15) ist nicht „um 15 %“ (Faktor 0,85).',
    punkte: 5,
  ),
  lueckentext(
    'i4-md-3',
    'md-datenmengen',
    scenario:
        'Die Hotline der Kessler & Brandt IT-Systemhaus GmbH zeichnet mit Einwilligung der Kunden Gespräche zu Schulungszwecken auf: 16 kHz Abtastrate, 16 Bit, Mono, unkomprimiert. Ein Gespräch dauert im Schnitt 4 Minuten, pro Tag werden 150 Gespräche aufgezeichnet. Es gilt 1 MB = 1.000.000 Byte und 1 MiB = 1.024² Byte.',
    prompt:
        'Berechne den Speicherbedarf. Runde den letzten Wert auf zwei Nachkommastellen.',
    text:
        'Ein Gespräch in Byte: {0}\n'
        'Alle Gespräche eines Tages in MB: {1}\n'
        'Alle Gespräche eines Tages in MiB: {2}',
    luecken: [
      zahl(7680000, rationale: '16.000 × 16 × 1 × 240 / 8.'),
      zahl(1152, rationale: '7,68 MB × 150.'),
      zahl(1098.63, toleranz: 0.01, rationale: '1.152.000.000 / 1.024².'),
    ],
    explanation:
        'Audio: Abtastrate × Bittiefe × Kanäle × Sekunden. 16.000 × 16 × 1 × 240 s = 61.440.000 Bit; / 8 = 7.680.000 Byte = 7,68 MB je Gespräch. × 150 = 1.152 MB pro Tag = 1.152.000.000 Byte. / 1.048.576 ≈ 1.098,63 MiB.',
    punkte: 4,
  ),
  lueckentext(
    'i4-md-4',
    'md-datenmengen',
    scenario:
        'Die Elbtal Logistik AG plant für den Außenbereich 8 Kameras. Jede Kamera liefert 2.560 × 1.440 Pixel mit 24 Bit Farbtiefe und 20 Bildern pro Sekunde. Der Videocodec komprimiert den Datenstrom auf 2 % der unkomprimierten Datenrate. Die Aufnahmen aller Kameras sollen 7 Tage (168 Stunden) gespeichert werden. Es gilt 1 Mbit = 1.000.000 Bit und 1 TiB = 1.024⁴ Byte.',
    prompt:
        'Berechne Datenrate und Speicherbedarf. Rechne in den Folgeschritten mit dem gerundeten Wert weiter.',
    text:
        'Unkomprimierte Datenrate einer Kamera in Mbit/s (eine Nachkommastelle): {0}\n'
        'Komprimierte Datenrate in Mbit/s (auf volle Mbit/s aufrunden): {1}\n'
        'Speicherbedarf aller 8 Kameras für 168 Stunden in TiB (auf volle TiB aufrunden): {2}',
    luecken: [
      zahl(
        1769.5,
        toleranz: 0.05,
        rationale: '2.560 × 1.440 × 24 × 20 / 1.000.000.',
      ),
      zahl(36, rationale: '1.769,472 × 0,02 = 35,39 -> 36.'),
      zahl(20, rationale: '19,80 TiB -> aufrunden.'),
    ],
    explanation:
        '2.560 × 1.440 × 24 Bit × 20 Bilder/s = 1.769.472.000 Bit/s ≈ 1.769,5 Mbit/s. Auf 2 %: × 0,02 = 35,39 -> 36 Mbit/s. Speicher: 8 × 36.000.000 Bit/s × 3.600 s × 168 h = 174.182.400.000.000 Bit; / 8 = 21.772.800.000.000 Byte; / 1.024⁴ ≈ 19,80 TiB -> 20 TiB. Aufrunden, weil der Speicher reichen muss. Fallen: Bit in Byte (/ 8), Stunden in Sekunden, Mbit dezimal, TiB binär.',
    punkte: 7,
    difficulty: 3,
  ),
  markieren(
    'i4-md-5',
    'md-datenmengen',
    scenario:
        'Ein Auszubildender der Pixelhafen Medien GmbH berechnet die Größe eines unkomprimierten Screenshots (1.920 × 1.080 Pixel, 24 Bit Farbtiefe) in MiB. Jede Zeile rechnet mit dem richtigen Ergebnis der Vorzeile weiter. Du prüfst den Rechenweg.',
    prompt: 'Markiere alle Zeilen, die einen Fehler enthalten.',
    zeilen: [
      nein('1.920 × 1.080 = 2.073.600 Pixel', 'Breite × Höhe stimmt.'),
      nein(
        '2.073.600 × 24 = 49.766.400 Bit',
        'Pixel × Farbtiefe in Bit ergibt Bit.',
      ),
      ja(
        '49.766.400 / 10 = 4.976.640 Byte',
        '1 Byte hat 8 Bit: 49.766.400 / 8 = 6.220.800 Byte.',
      ),
      ja(
        '6.220.800 / 1.000 = 6.220,8 KiB',
        'KiB ist binär: 6.220.800 / 1.024 = 6.075 KiB. Durch 1.000 ergäbe kB.',
      ),
      nein('6.075 / 1.024 ≈ 5,93 MiB', '6.075 / 1.024 = 5,93. Richtig.'),
    ],
    mono: true,
    explanation:
        'Richtig: 1.920 × 1.080 × 24 = 49.766.400 Bit; / 8 = 6.220.800 Byte; / 1.024 = 6.075 KiB; / 1.024 ≈ 5,93 MiB. Die beiden klassischen Fehler: Bit und Byte verwechselt (Faktor 8) sowie dezimale und binäre Vorsätze gemischt (1.000 statt 1.024).',
    punkte: 4,
  ),
  tabelle(
    'i4-md-6',
    'md-datenmengen',
    scenario:
        'In Angeboten und Datenblättern stehen Speichergrößen mal mit dezimalen (kB, MB, GB), mal mit binären Vorsätzen (KiB, MiB, GiB, TiB). Für den Angebotsvergleich rechnest du um.',
    prompt: 'Rechne die Angaben um.',
    zeilen: [
      ['gegeben', 'gesucht in', 'Ergebnis'],
      ['3 MB', 'kB', zahl(3000)],
      ['5 GB', 'MB', zahl(5000)],
      ['2 GiB', 'MiB', zahl(2048)],
      ['4.096 KiB', 'MiB', zahl(4)],
      ['1 TiB', 'GiB', zahl(1024)],
      ['1 KiB', 'Byte', zahl(1024)],
    ],
    explanation:
        'Dezimale Vorsätze (k, M, G, T) steigen je Stufe um den Faktor 1.000, binäre (Ki, Mi, Gi, Ti) um den Faktor 1.024. 3 MB = 3.000 kB, 5 GB = 5.000 MB; 2 GiB = 2.048 MiB, 4.096 KiB = 4 MiB, 1 TiB = 1.024 GiB, 1 KiB = 1.024 Byte.',
    punkte: 3,
    difficulty: 1,
  ),
  rechnen(
    'i4-md-7',
    'md-datenmengen',
    scenario:
        'Für das Belegarchiv der Elbtal Logistik AG werden 34 GiB Cloud-Speicher benötigt. Der Anbieter verkauft Speicher nur in Paketen zu je 10 GiB; ein Paket kostet 12 € pro Jahr. Der Bedarf bleibt über die Laufzeit gleich.',
    prompt: 'Berechne die Speicherkosten für 5 Jahre.',
    answer: 240,
    unit: '€',
    explanation:
        '34 GiB / 10 GiB = 3,4 -> es müssen 4 Pakete gebucht werden (aufrunden). 4 Pakete × 12 € = 48 € pro Jahr. 48 € × 5 Jahre = 240 €.',
    punkte: 2,
  ),

  // ================================================== Übertragungsdauer berechnen
  lueckentext(
    'i4-mu-1',
    'md-uebertragung',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH sichert für die Steuerkanzlei Albers & Partner nachts 72 GB (1 GB = 1.000.000.000 Byte) in ein Rechenzentrum. Der Anschluss der Kanzlei bietet 100 Mbit/s im Download und 25 Mbit/s im Upload. Durch Protokoll-Overhead steigt die zu übertragende Datenmenge um 10 %.',
    prompt:
        'Berechne schrittweise die Dauer der Sicherung. Runde den letzten Wert auf zwei Nachkommastellen.',
    text:
        'Datenmenge in Mbit: {0}\n'
        'Datenmenge mit Overhead in Mbit: {1}\n'
        'Dauer in Sekunden: {2}\n'
        'Dauer in Stunden: {3}',
    luecken: [
      zahl(576000, rationale: '72.000 MB × 8.'),
      zahl(633600, rationale: '576.000 × 1,1.'),
      zahl(25344, rationale: '633.600 / 25. Beim Sichern zählt der Upload.'),
      zahl(7.04, toleranz: 0.01, rationale: '25.344 / 3.600.'),
    ],
    explanation:
        '72 GB = 72.000 MB; × 8 = 576.000 Mbit. Mit 10 % Overhead: × 1,1 = 633.600 Mbit. Die Sicherung wird hochgeladen, also zählt die Upload-Rate: 633.600 / 25 Mbit/s = 25.344 s. / 3.600 = 7,04 Stunden. Fallen: Byte in Bit umrechnen (× 8) und Upload statt Download verwenden.',
    punkte: 5,
  ),
  lueckentext(
    'i4-mu-2',
    'md-uebertragung',
    scenario:
        'Für die neue Lagerhalle der Elbtal Logistik AG sollen 10 Kameras des folgenden Typs beschafft werden. Das Datenblatt des Herstellers liegt nur auf Englisch vor.',
    code:
        'IP Camera DomeView 4 - Data Sheet\n'
        'Resolution:    1920 x 1080 pixels\n'
        'Frame rate:    15 fps\n'
        'Colour depth:  24 bit\n'
        'Video codec:   H.265, reduces\n'
        '               the data rate\n'
        '               to 0.5 %\n'
        'Power supply:  PoE\n'
        'Network port:  100 Mbit/s',
    prompt:
        'Entnimm dem Datenblatt die nötigen Werte und berechne die Datenraten (1 Mbit = 1.000.000 Bit).',
    text:
        'Bilder pro Sekunde: {0}\n'
        'Unkomprimierte Datenrate in Mbit/s (eine Nachkommastelle): {1}\n'
        'Komprimierte Datenrate in Mbit/s (auf volle Mbit/s aufrunden): {2}\n'
        'Datenrate aller 10 Kameras in Mbit/s: {3}',
    luecken: [
      zahl(15, rationale: 'Frame rate: 15 fps (frames per second).'),
      zahl(
        746.5,
        toleranz: 0.05,
        rationale: '1.920 × 1.080 × 24 × 15 / 1.000.000.',
      ),
      zahl(4, rationale: '746,496 × 0,005 = 3,73 -> 4.'),
      zahl(40, rationale: '10 × 4.'),
    ],
    explanation:
        'Frame rate = Bildrate: 15 Bilder pro Sekunde. 1.920 × 1.080 × 24 Bit × 15 = 746.496.000 Bit/s ≈ 746,5 Mbit/s. „Reduces the data rate to 0.5 %“ heißt auf 0,5 %: × 0,005 = 3,73 -> aufgerundet 4 Mbit/s. 10 Kameras: 40 Mbit/s. Der Netzwerkanschluss (100 Mbit/s) ist die höchstmögliche, nicht die tatsächliche Datenrate.',
    punkte: 5,
    difficulty: 3,
    tags: ['englisch'],
  ),
  tabelle(
    'i4-mu-3',
    'md-uebertragung',
    scenario:
        'Die IT der Grünwerk Gartenbedarf GmbH schätzt ab, wie lange typische Übertragungen dauern. Es gilt 1 MB = 1.000.000 Byte, 1 GB = 1.000 MB; Overhead bleibt unberücksichtigt.',
    prompt: 'Berechne die Übertragungsdauer in Sekunden.',
    zeilen: [
      ['Datenmenge', 'Datenrate', 'Dauer in s'],
      ['500 MB', '100 Mbit/s', zahl(40)],
      ['750 MB', '50 Mbit/s', zahl(120)],
      ['2 GB', '16 Mbit/s', zahl(1000)],
      ['4,5 GB', '1 Gbit/s', zahl(36)],
    ],
    explanation:
        'Dauer = Datenmenge in Bit / Datenrate in Bit/s. 500 MB × 8 = 4.000 Mbit / 100 = 40 s. 750 × 8 = 6.000 / 50 = 120 s. 2.000 × 8 = 16.000 / 16 = 1.000 s. 4.500 × 8 = 36.000 Mbit / 1.000 Mbit/s = 36 s.',
    punkte: 4,
  ),
  markieren(
    'i4-mu-4',
    'md-uebertragung',
    scenario:
        'Die Filiale Göttingen soll eine 3-GB-Datei (1 GB = 1.000 MB) in die Zentrale hochladen. Der Anschluss der Filiale hat 100 Mbit/s im Download und 20 Mbit/s im Upload. Ein Kollege hat die Dauer berechnet; du prüfst seinen Rechenweg.',
    prompt: 'Markiere alle Zeilen, die einen Fehler enthalten.',
    zeilen: [
      nein('3 GB = 3.000 MB', 'Dezimal umgerechnet. Richtig.'),
      nein('3.000 MB × 8 = 24.000 Mbit', 'Byte in Bit: × 8. Richtig.'),
      ja(
        'Datenrate für den Upload: 100 Mbit/s',
        'Beim Hochladen zählt die Upload-Rate von 20 Mbit/s.',
      ),
      ja(
        'Dauer = Datenrate / Datenmenge',
        'Umgekehrt: Dauer = Datenmenge / Datenrate.',
      ),
      nein(
        '24.000 Mbit / 20 Mbit/s = 1.200 s',
        'Mit der Upload-Rate gerechnet. Richtig.',
      ),
      nein('1.200 s = 20 min', '1.200 / 60 = 20. Richtig.'),
    ],
    mono: true,
    explanation:
        'Richtig: 3 GB = 24.000 Mbit; beim Hochladen gilt die Upload-Rate; Dauer = Datenmenge / Datenrate = 24.000 / 20 = 1.200 s = 20 min. Die Fehler: Download- statt Upload-Rate und die verdrehte Formel.',
    punkte: 3,
  ),
  freitext(
    'i4-mu-5',
    'md-uebertragung',
    scenario:
        'Für die Datensicherung der Kanzlei wurde eine Übertragungsdauer von rund 7 Stunden berechnet. In der ersten Nacht dauert die Sicherung jedoch fast 10 Stunden.',
    prompt:
        'Erläutere zwei mögliche Gründe, warum eine Übertragung in der Praxis länger dauert als berechnet.',
    kriterien: [
      krit(
        'Die Leitung wird mit anderen Anwendungen oder Nutzern geteilt. Es steht nicht die volle Datenrate zur Verfügung.',
        punkte: 2,
        stichwoerter: [
          'geteilt',
          'andere Nutzer',
          'gleichzeitig',
          'ausgelastet',
          'Auslastung',
        ],
      ),
      krit(
        'Der Anbieter liefert nicht dauerhaft die vertraglich genannte Maximalrate („bis zu“).',
        punkte: 2,
        stichwoerter: [
          'bis zu',
          'Maximalrate',
          'schwankt',
          'Schwankung',
          'tatsächliche Datenrate',
        ],
      ),
      krit(
        'Protokoll-Overhead und Übertragungswiederholungen vergrößern die zu sendende Datenmenge.',
        punkte: 2,
        stichwoerter: [
          'Overhead',
          'Header',
          'Wiederholung',
          'erneut senden',
          'Paketverlust',
        ],
      ),
      krit(
        'Die Gegenstelle oder ein Gerät auf dem Weg begrenzt die Rate (Server, WLAN, langsame Festplatte, Verschlüsselung).',
        punkte: 2,
        stichwoerter: [
          'Server',
          'Gegenstelle',
          'WLAN',
          'Festplatte',
          'Engpass',
          'Flaschenhals',
        ],
      ),
    ],
    loesung:
        'Erstens teilt sich die Sicherung die Leitung mit anderen Anwendungen, sodass nicht die volle Upload-Rate zur Verfügung steht. Zweitens ist die vertragliche Datenrate ein Höchstwert („bis zu“), die tatsächliche Rate schwankt. Weitere Gründe: Protokoll-Overhead und wiederholt gesendete Pakete sowie Engpässe bei der Gegenstelle, im WLAN oder beim Lesen und Verschlüsseln der Daten.',
    explanation:
        'Je erläutertem Grund 2 Punkte, verlangt sind zwei. Die berechnete Dauer ist ein Bestwert: Sie setzt voraus, dass die volle Datenrate ununterbrochen und nur für diese Übertragung zur Verfügung steht.',
    punkte: 4,
  ),
  lueckentext(
    'i4-mu-6',
    'md-uebertragung',
    scenario:
        'In der neuen Lagerhalle der Elbtal Logistik AG senden 12 Kameras ihre Bilder über einen gemeinsamen Uplink mit 100 Mbit/s an den Aufzeichnungsserver. Jede Kamera erzeugt einen Datenstrom von 6 Mbit/s. Der Uplink soll höchstens zu 80 % ausgelastet werden.',
    prompt: 'Prüfe, ob der Uplink ausreicht.',
    text:
        'Datenrate aller Kameras in Mbit/s: {0}\n'
        'Zulässige Auslastung des Uplinks in Mbit/s: {1}\n'
        'Verbleibende Reserve in Mbit/s: {2}\n'
        'Der Uplink ist damit {3}.',
    luecken: [
      zahl(72, rationale: '12 × 6.'),
      zahl(80, rationale: '100 × 0,8.'),
      zahl(8, rationale: '80 - 72.'),
      wahl('ausreichend', [
        'zu knapp',
        'überlastet',
      ], '72 Mbit/s liegen unter der Grenze von 80 Mbit/s.'),
    ],
    explanation:
        '12 Kameras × 6 Mbit/s = 72 Mbit/s. 80 % von 100 Mbit/s = 80 Mbit/s. 80 - 72 = 8 Mbit/s Reserve. Der Uplink reicht aus, eine 14. Kamera (84 Mbit/s) würde die Grenze aber überschreiten.',
    punkte: 4,
    difficulty: 1,
  ),

  // =================================================== Kompression und Formate
  lueckentext(
    'i4-mx-1',
    'md-kompression',
    scenario:
        'Eine Videodatei der Pixelhafen Medien GmbH ist unkomprimiert 80 MB groß. In drei Angeboten von Software-Herstellern wird die Kompression unterschiedlich beschrieben.',
    prompt: 'Berechne jeweils die Größe der komprimierten Datei.',
    text:
        'Angebot A, „verringert die Größe um 30 %“: {0} MB\n'
        'Angebot B, „verringert die Größe auf 30 %“: {1} MB\n'
        'Angebot C, „Kompressionsfaktor 4:1“: {2} MB\n'
        'Einsparung bei Angebot C in Prozent: {3}',
    luecken: [
      zahl(56, rationale: '80 × 0,7.'),
      zahl(24, rationale: '80 × 0,3.'),
      zahl(20, rationale: '80 / 4.'),
      zahl(75, rationale: '(1 - 20 / 80) × 100.'),
    ],
    explanation:
        '„Um 30 %“: Es bleiben 70 % -> 80 × 0,7 = 56 MB. „Auf 30 %“: Es bleiben 30 % -> 80 × 0,3 = 24 MB. Faktor 4:1: 80 / 4 = 20 MB, das ist eine Einsparung von (1 - 20 / 80) × 100 = 75 %. Das kleine Wort „um“ oder „auf“ entscheidet über das Ergebnis.',
    punkte: 4,
  ),
  freitext(
    'i4-mx-2',
    'md-kompression',
    scenario:
        'Die Pixelhafen Medien GmbH bereitet für einen Kunden Bildmaterial auf: Produktfotos für die Website und eingescannte Vertragsunterlagen für das Archiv. Der Kunde fragt, ob er alles einfach „stark als JPEG komprimieren“ kann.',
    prompt:
        'Erläutere den Unterschied zwischen verlustfreier und verlustbehafteter Kompression und gib an, welche Art für die beiden Einsatzzwecke jeweils geeignet ist.',
    kriterien: [
      krit(
        'Verlustfrei: Das Original lässt sich exakt wiederherstellen (z. B. PNG, ZIP).',
        punkte: 1,
        stichwoerter: [
          'exakt',
          'vollständig wiederherstellen',
          'ohne Verlust',
          'Original',
          'bitgenau',
        ],
      ),
      krit(
        'Verlustbehaftet: Kaum wahrnehmbare Details werden entfernt, das Original ist nicht wiederherstellbar, dafür viel kleinere Dateien (z. B. JPEG).',
        punkte: 1,
        stichwoerter: [
          'Details entfernt',
          'weggelassen',
          'nicht wiederherstellbar',
          'Qualitätsverlust',
          'kleiner',
        ],
      ),
      krit(
        'Produktfotos für die Website: verlustbehaftet (JPEG), kleine Dateien, kurze Ladezeit.',
        punkte: 1,
        stichwoerter: ['Produktfotos', 'Fotos', 'Website', 'Ladezeit', 'JPEG'],
      ),
      krit(
        'Vertragsunterlagen im Archiv: verlustfrei, Schrift bleibt scharf und der Inhalt unverändert.',
        punkte: 1,
        stichwoerter: [
          'Vertragsunterlagen',
          'Archiv',
          'Dokumente',
          'Schrift',
          'unverändert',
          'PNG',
        ],
      ),
    ],
    loesung:
        'Verlustfreie Kompression stellt das Original exakt wieder her, spart aber weniger Platz. Verlustbehaftete Kompression entfernt Details, die kaum wahrgenommen werden; die Datei wird viel kleiner, das Original lässt sich aber nicht zurückgewinnen. Für Produktfotos auf der Website eignet sich verlustbehaftetes JPEG (kurze Ladezeiten). Die Vertragsunterlagen im Archiv sollten verlustfrei gespeichert werden, damit Schrift und Inhalt unverändert bleiben.',
    explanation:
        'Je 1 Punkt für die beiden Erklärungen und für die beiden Zuordnungen. Verlustbehaftete Verfahren passen zu Fotos, Musik und Video; verlustfrei bleibt alles, was exakt erhalten werden muss: Texte, Programme, Dokumente, Grafiken mit harten Kanten.',
    punkte: 4,
  ),
  markieren(
    'i4-mx-3',
    'md-kompression',
    scenario:
        'Ein Kunde der Pixelhafen Medien GmbH kann eine gelieferte MP4-Datei nicht abspielen. Im englischen Hilfetext des Abspielprogramms steht der folgende Abschnitt.',
    code:
        'A video file usually consists\n'
        'of a container and one or more\n'
        'codecs. The container, for\n'
        'example MP4, only holds the\n'
        'video and audio tracks\n'
        'together. The codec, such as\n'
        'H.264, compresses the pictures.\n'
        'A player can open a file only\n'
        'if it supports the codec that\n'
        'was used. Most video codecs are\n'
        'lossy: details that viewers\n'
        'hardly notice are removed.',
    prompt: 'Markiere alle Aussagen, die sich dem Text entnehmen lassen.',
    zeilen: [
      ja(
        'Der Container hält Video- und Tonspuren zusammen.',
        '„holds the video and audio tracks together“.',
      ),
      ja(
        'Der Codec komprimiert die Bilder.',
        '„The codec ... compresses the pictures“.',
      ),
      nein(
        'MP4 ist ein Codec.',
        'MP4 wird als Beispiel für einen Container genannt.',
      ),
      ja(
        'Ob eine Datei abgespielt werden kann, hängt vom verwendeten Codec ab.',
        '„only if it supports the codec that was used“.',
      ),
      nein(
        'Die meisten Videocodecs arbeiten verlustfrei.',
        '„lossy“ bedeutet verlustbehaftet.',
      ),
      ja(
        'Entfernt werden Details, die Zuschauer kaum bemerken.',
        '„details that viewers hardly notice are removed“.',
      ),
      nein(
        'Eine MP4-Datei enthält immer genau eine Spur.',
        'Der Text spricht von mehreren Spuren („tracks“).',
      ),
    ],
    explanation:
        'Der Text trennt Container (MP4: hält die Spuren zusammen) und Codec (H.264: komprimiert). Abspielbar ist eine Datei nur, wenn das Programm den Codec unterstützt. Die Endung allein sagt wenig. „Lossy“ heißt verlustbehaftet.',
    punkte: 4,
    tags: ['englisch'],
  ),
  paare(
    'i4-mx-4',
    'md-kompression',
    scenario:
        'Für die Medienrichtlinie der Agentur stellst du die wichtigsten Dateiformate mit ihren Eigenschaften zusammen.',
    prompt: 'Ordne jedem Format die passende Eigenschaft zu.',
    paare: [
      paar('JPEG', 'verlustbehaftet, für Fotos'),
      paar('PNG', 'verlustfreies Rasterbild mit Transparenz'),
      paar('SVG', 'Vektorgrafik, beliebig skalierbar'),
      paar('MP3', 'verlustbehaftetes Audio'),
      paar('FLAC', 'verlustfreies Audio'),
      paar('ZIP', 'verlustfreies Archiv für beliebige Dateien'),
    ],
    explanation:
        'JPEG und MP3 lassen kaum wahrnehmbare Details weg. PNG, FLAC und ZIP stellen das Original exakt wieder her. SVG beschreibt Formen statt Pixel und bleibt deshalb in jeder Größe scharf.',
    punkte: 3,
    difficulty: 1,
  ),

  // ============================================================ KI-Grundlagen
  freitext(
    'i4-ig-1',
    'ki-grundlagen',
    scenario:
        'Die Geschäftsführung der Elbtal Logistik AG hat einen englischen Fachartikel über künstliche Intelligenz erhalten und bittet dich um eine kurze Auswertung.',
    code:
        'Artificial intelligence (AI) is\n'
        'the ability of computer systems\n'
        'to perform tasks that normally\n'
        'require human intelligence.\n'
        'Machine learning is a part of\n'
        'AI: the system is not programmed\n'
        'with fixed rules, but learns\n'
        'patterns from large amounts of\n'
        'example data. Typical uses are\n'
        'recognising speech, sorting\n'
        'e-mails and detecting faulty\n'
        'products in photos.',
    prompt:
        'Beschreibe auf Deutsch anhand des Textes, wodurch sich maschinelles Lernen von klassischer Programmierung unterscheidet. Nenne außerdem zwei der im Text genannten Anwendungen.',
    kriterien: [
      krit(
        'Unterschied: Das System erhält keine fest programmierten Regeln, sondern lernt Muster aus vielen Beispieldaten.',
        punkte: 2,
        stichwoerter: [
          'lernt',
          'Muster',
          'Beispieldaten',
          'keine festen Regeln',
          'Daten',
        ],
      ),
      krit(
        'Anwendung: Sprache erkennen',
        stichwoerter: ['Sprache', 'Spracherkennung', 'gesprochene'],
      ),
      krit(
        'Anwendung: E-Mails sortieren',
        stichwoerter: ['E-Mail', 'Mails', 'sortieren'],
      ),
      krit(
        'Anwendung: fehlerhafte Produkte auf Fotos erkennen',
        stichwoerter: [
          'fehlerhafte Produkte',
          'Fotos',
          'Bilder',
          'defekte',
          'Qualitätskontrolle',
        ],
      ),
    ],
    loesung:
        'Beim maschinellen Lernen wird das System nicht mit festen Regeln programmiert, sondern lernt Muster aus großen Mengen von Beispieldaten. Genannte Anwendungen: Spracherkennung, das Sortieren von E-Mails und das Erkennen fehlerhafter Produkte auf Fotos.',
    explanation:
        '2 Punkte für den Unterschied (lernen aus Beispieldaten statt fester Regeln), je 1 Punkt für zwei der drei genannten Anwendungen. Gewertet wird nur, was im Text steht. Eigene Beispiele zählen hier nicht.',
    punkte: 4,
    tags: ['englisch'],
  ),
  lueckentext(
    'i4-ig-2',
    'ki-grundlagen',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH testet einen lernenden Spamfilter mit 200 E-Mails, die er im Training nicht gesehen hat: 100 Spam-Mails und 100 erwünschte Mails.',
    table: [
      ['Tatsächlich', 'als Spam erkannt', 'als erwünscht eingestuft'],
      ['Spam (100)', '90', '10'],
      ['erwünscht (100)', '5', '95'],
    ],
    prompt: 'Werte den Test aus.',
    text:
        'Richtig eingeordnete Mails: {0}\n'
        'Genauigkeit in Prozent: {1}\n'
        'Anteil der Spam-Mails, die der Filter übersehen hat, in Prozent: {2}',
    luecken: [
      zahl(185, rationale: '90 + 95.'),
      zahl(92.5, toleranz: 0.05, rationale: '185 / 200 × 100.'),
      zahl(10, rationale: '10 von 100 Spam-Mails.'),
    ],
    explanation:
        'Richtig sind die erkannten Spam-Mails (90) und die durchgelassenen erwünschten Mails (95): 185. Genauigkeit = richtige Entscheidungen / alle Testfälle = 185 / 200 = 92,5 %. Übersehen wurden 10 von 100 Spam-Mails = 10 %. Bewertet wird immer mit Testdaten, die das Modell noch nicht kennt.',
    punkte: 3,
  ),
  paare(
    'i4-ig-3',
    'ki-grundlagen',
    scenario:
        'Für eine interne Schulung zur KI-Kompetenz erstellst du ein kurzes Glossar.',
    prompt: 'Ordne jedem Begriff die passende Erklärung zu.',
    paare: [
      paar('Trainingsdaten', 'Beispiele, aus denen das Modell lernt'),
      paar('Label', 'richtige Antwort zu einem Beispiel'),
      paar('Testdaten', 'ungesehene Daten zur Bewertung'),
      paar('Token', 'Textbaustein eines Sprachmodells'),
      paar('Overfitting', 'Trainingsdaten auswendig gelernt'),
      paar('Halluzination', 'plausibel klingende, falsche Ausgabe'),
    ],
    explanation:
        'Ein Modell lernt aus Trainingsdaten, beim überwachten Lernen mit Labels. Geprüft wird es mit ungesehenen Testdaten. Overfitting zeigt sich an guten Trainings- und schlechten Testergebnissen. Sprachmodelle arbeiten mit Tokens und können Falsches überzeugend formulieren.',
    punkte: 3,
    difficulty: 1,
  ),
  freitext(
    'i4-ig-4',
    'ki-grundlagen',
    scenario:
        'Die Elbtal Logistik AG lässt ein Modell trainieren, das auf Fotos beschädigte Pakete erkennt. Alle Trainingsfotos wurden in Halle 1 bei Tageslicht aufgenommen. Im Training erkennt das Modell 99 % der Fälle richtig, im Betrieb in der neuen Halle mit Kunstlicht nur noch 68 %.',
    prompt:
        'Erläutere die wahrscheinliche Ursache und beschreibe eine Maßnahme, mit der sich das Ergebnis verbessern lässt.',
    kriterien: [
      krit(
        'Ursache: Die Trainingsdaten sind einseitig (nur Halle 1, nur Tageslicht). Das Modell ist darauf überangepasst (Overfitting) und verallgemeinert schlecht.',
        punkte: 2,
        stichwoerter: [
          'Overfitting',
          'überangepasst',
          'einseitig',
          'nicht repräsentativ',
          'auswendig',
          'verallgemeinert',
        ],
      ),
      krit(
        'Maßnahme: mit mehr und vielfältigeren Fotos trainieren (andere Hallen, Kunstlicht, verschiedene Blickwinkel).',
        punkte: 2,
        stichwoerter: [
          'vielfältiger',
          'mehr Daten',
          'weitere Fotos',
          'andere Halle',
          'Kunstlicht',
          'neu trainieren',
        ],
      ),
      krit(
        'Maßnahme: das Modell vor dem Einsatz mit getrennten Testdaten aus der realen Umgebung prüfen.',
        punkte: 2,
        stichwoerter: [
          'Testdaten',
          'testen',
          'prüfen',
          'reale Umgebung',
          'Validierung',
        ],
      ),
    ],
    loesung:
        'Die Trainingsfotos stammen nur aus Halle 1 bei Tageslicht. Das Modell hat sich an diese Bedingungen überangepasst (Overfitting) und kommt mit dem Kunstlicht der neuen Halle nicht zurecht. Maßnahme: das Modell mit zusätzlichen, vielfältigeren Fotos aus allen Hallen und Lichtverhältnissen neu trainieren und vor dem Einsatz mit getrennten Testdaten aus der realen Umgebung bewerten.',
    explanation:
        '2 Punkte für die Ursache (einseitige Trainingsdaten, Overfitting), 2 Punkte für eine beschriebene Maßnahme. Ein großer Abstand zwischen Trainings- und Praxisergebnis ist das typische Zeichen dafür, dass das Modell nicht verallgemeinert.',
    punkte: 4,
  ),

  // ======================================================= KI im Arbeitsalltag
  tabelle(
    'i4-ie-1',
    'ki-einsatz',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH möchte KI im Support einsetzen. Der Ablauf einer Störungsmeldung besteht aus fünf Schritten. Für den ersten Schritt ist die KI-Unterstützung als Muster eingetragen.',
    prompt:
        'Wähle zu jedem weiteren Prozessschritt die passende Möglichkeit der KI-Unterstützung.',
    zeilen: [
      ['Prozessschritt', 'KI-Unterstützung'],
      [
        '1. Kunde schildert das Problem am Telefon',
        'Gespräch automatisch in Text umwandeln',
      ],
      [
        '2. Ticket wird einem Fachteam zugewiesen',
        wahl('Ticket nach seinem Inhalt klassifizieren', [
          'Gesprochenes in Text umwandeln',
          'Antwortmail formulieren',
        ]),
      ],
      [
        '3. Techniker sucht nach der Ursache',
        wahl('ähnliche gelöste Tickets vorschlagen', [
          'Ticket nach Inhalt klassifizieren',
          'Verlauf zusammenfassen',
        ]),
      ],
      [
        '4. Techniker antwortet dem Kunden',
        wahl('Antwortentwurf erstellen, den der Techniker prüft', [
          'Antwort ohne Prüfung versenden',
          'ähnliche Tickets vorschlagen',
        ]),
      ],
      [
        '5. Übergabe des offenen Tickets an die nächste Schicht',
        wahl('langen Ticketverlauf zusammenfassen', [
          'Gesprochenes in Text umwandeln',
          'Ticket ungelesen schließen',
        ]),
      ],
    ],
    explanation:
        'KI eignet sich für Sprache, Text und Muster: Transkribieren, Klassifizieren, ähnliche Fälle finden, Entwürfe schreiben, Zusammenfassen. Was an Kunden geht, wird vorher von einem Menschen geprüft. Die Verantwortung bleibt beim Techniker.',
    punkte: 4,
  ),
  freitext(
    'i4-ie-2',
    'ki-einsatz',
    scenario:
        'Einige Techniker der Kessler & Brandt IT-Systemhaus GmbH stehen der KI-gestützten Ticketbearbeitung skeptisch gegenüber. Die Teamleitung möchte in der nächsten Besprechung für die Einführung werben.',
    prompt:
        'Beschreibe zwei Argumente, die für den Einsatz von KI in der Ticketbearbeitung sprechen.',
    kriterien: [
      krit(
        'Entlastung von Routinearbeit: Sortieren, Zusammenfassen und Entwürfe übernimmt die KI, und es bleibt mehr Zeit für schwierige Fälle.',
        punkte: 2,
        stichwoerter: [
          'Routine',
          'Entlastung',
          'entlastet',
          'mehr Zeit',
          'Zeitersparnis',
        ],
      ),
      krit(
        'Schnellere Bearbeitung: Kunden erhalten früher eine Antwort, Tickets landen sofort beim richtigen Team.',
        punkte: 2,
        stichwoerter: [
          'schneller',
          'Wartezeit',
          'Bearbeitungszeit',
          'sofort',
          'Reaktionszeit',
        ],
      ),
      krit(
        'Wissen nutzen: Das System erkennt Muster und findet ähnliche gelöste Fälle, die ein Einzelner nicht kennt.',
        punkte: 2,
        stichwoerter: [
          'Muster',
          'ähnliche Fälle',
          'Wissen',
          'Wissensdatenbank',
          'Erfahrung',
        ],
      ),
      krit(
        'Gleichbleibende Qualität und weniger Flüchtigkeitsfehler, auch bei hohem Ticketaufkommen ohne zusätzliches Personal.',
        punkte: 2,
        stichwoerter: [
          'Qualität',
          'weniger Fehler',
          'skalierbar',
          'ohne mehr Personal',
          'Kosten',
        ],
      ),
    ],
    loesung:
        'Erstens entlastet die KI von Routinearbeit wie dem Vorsortieren und Zusammenfassen von Tickets, sodass den Technikern mehr Zeit für anspruchsvolle Störungen bleibt. Zweitens werden Tickets schneller bearbeitet: Sie gelangen sofort zum richtigen Team, und Kunden erhalten früher eine Antwort. Weitere Argumente: Die KI findet ähnliche gelöste Fälle und hält die Qualität auch bei vielen Tickets konstant.',
    explanation:
        'Je beschriebenem Argument 2 Punkte (Aussage plus kurze Ausführung), verlangt sind zwei. Typische Argumente: Entlastung, Zeitersparnis, Mustererkennung, gleichbleibende Qualität, Skalierbarkeit ohne mehr Personal.',
    punkte: 4,
  ),
  rechnen(
    'i4-ie-3',
    'ki-einsatz',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH will für 25 Beschäftigte im Kundenservice einen KI-Assistenten lizenzieren. Vor dem Start nimmt jeder Nutzer an einer Schulung teil; in dieser Zeit fällt seine Arbeitszeit aus.',
    table: [
      ['Position', 'Angabe'],
      ['Lizenz', '28 € je Nutzer und Monat'],
      ['Schulung durch Trainer', '1.200 € einmalig'],
      ['Dauer der Schulung', '2 Stunden je Nutzer'],
      ['Kosten der Arbeitszeit', '45 € je Stunde'],
    ],
    prompt:
        'Berechne die Gesamtkosten im ersten Jahr einschließlich der ausgefallenen Arbeitszeit.',
    answer: 11850,
    unit: '€',
    explanation:
        'Lizenz: 25 × 28 € × 12 = 8.400 €. Trainer: 1.200 €. Ausgefallene Arbeitszeit: 25 × 2 h × 45 € = 2.250 €. Summe: 8.400 + 1.200 + 2.250 = 11.850 €. Die Arbeitszeit während der Schulung ist ein Kostenbestandteil, der leicht vergessen wird.',
    punkte: 4,
  ),
  freitext(
    'i4-ie-4',
    'ki-einsatz',
    scenario:
        'Ein Kollege beschwert sich, der KI-Assistent liefere nur unbrauchbare Antworten. Sein Prompt lautet: „Schreib was über Backups.“',
    prompt: 'Nenne vier Angaben, die ein guter Prompt enthalten sollte.',
    kriterien: [
      krit(
        'Rolle, aus deren Sicht geantwortet werden soll',
        stichwoerter: ['Rolle', 'Perspektive', 'du bist'],
      ),
      krit(
        'Kontext bzw. Hintergrund der Situation',
        stichwoerter: ['Kontext', 'Hintergrund', 'Situation', 'Zielgruppe'],
      ),
      krit(
        'Klare Aufgabe bzw. Ziel',
        stichwoerter: ['Aufgabe', 'Ziel', 'Auftrag', 'Anweisung'],
      ),
      krit(
        'Gewünschtes Format und Umfang der Antwort',
        stichwoerter: ['Format', 'Umfang', 'Länge', 'Tabelle', 'Stil'],
      ),
      krit(
        'Beispiele für die gewünschte Antwort (Few-Shot)',
        stichwoerter: ['Beispiel', 'Few-Shot', 'Muster'],
      ),
      krit(
        'Einschränkungen, z. B. was nicht enthalten sein soll',
        stichwoerter: [
          'Einschränkung',
          'Grenzen',
          'nicht enthalten',
          'Vorgaben',
        ],
      ),
    ],
    loesung:
        'Ein guter Prompt nennt die Rolle (z. B. „Du bist IT-Administratorin“), den Kontext (kleines Büro mit 20 Arbeitsplätzen), die klare Aufgabe (Backup-Konzept vorschlagen) und das gewünschte Format (Tabelle mit höchstens zehn Zeilen). Hilfreich sind außerdem Beispiele und Einschränkungen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4. Die Lösungsliste ist länger als verlangt. Merkhilfe: Rolle, Kontext, Aufgabe, Format. Vertrauliche und personenbezogene Daten gehören nicht in den Prompt.',
    punkte: 4,
    difficulty: 1,
  ),

  // ================================================= Grenzen, Risiken und Recht
  markieren(
    'i4-ir-1',
    'ki-grenzen',
    scenario:
        'Ein Kunde fragt nach dem Router NetGate R20. Ein Kollege lässt die Antwort von einem KI-Chatbot formulieren. Du vergleichst die Aussagen mit dem Datenblatt des Herstellers. Eine Zeitschrift namens „NetzProfi“ lässt sich nirgends finden.',
    table: [
      ['Merkmal', 'Datenblatt'],
      ['LAN-Ports', '4 × 1 Gbit/s'],
      ['WLAN', 'Wi-Fi 6'],
      ['VPN', 'WireGuard'],
      ['Garantie', '2 Jahre'],
    ],
    prompt:
        'Markiere alle Aussagen des Chatbots, die auf eine Halluzination hindeuten.',
    zeilen: [
      nein(
        '„Der Router hat vier Gigabit-LAN-Ports.“',
        'Stimmt mit dem Datenblatt überein.',
      ),
      ja(
        '„Er funkt nach Wi-Fi 7.“',
        'Laut Datenblatt Wi-Fi 6. Die Angabe ist erfunden.',
      ),
      nein(
        '„Als VPN-Verfahren steht WireGuard bereit.“',
        'Stimmt mit dem Datenblatt überein.',
      ),
      ja(
        '„Die Garantie beträgt fünf Jahre.“',
        'Laut Datenblatt 2 Jahre. Eine falsche Zusage mit rechtlichen Folgen.',
      ),
      ja(
        '„Laut NetzProfi 03/2025 ist er Testsieger.“',
        'Die Quelle existiert nicht. Erfundene Belege sind typisch für Halluzinationen.',
      ),
      nein(
        '„Das WLAN arbeitet nach Wi-Fi 6.“',
        'Stimmt mit dem Datenblatt überein.',
      ),
    ],
    explanation:
        'Halluzinationen sind flüssig formulierte, aber falsche oder erfundene Angaben, oft Zahlen, Normen und Quellen. Erkennen lassen sie sich nur durch den Abgleich mit verlässlichen Unterlagen wie dem Datenblatt. Vor dem Versand an Kunden muss ein Mensch prüfen.',
    punkte: 3,
  ),
  freitext(
    'i4-ir-2',
    'ki-grenzen',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH will im Webshop einen KI-Chatbot einsetzen, der Kundenfragen zu Bestellungen, Lieferzeiten und Reklamationen selbstständig beantwortet.',
    prompt:
        'Beschreibe zwei Risiken, die mit dem Einsatz des Chatbots verbunden sind.',
    kriterien: [
      krit(
        'Falsche Auskünfte (Halluzinationen), z. B. erfundene Lieferzeiten oder Zusagen. Folge: verärgerte Kunden, Imageschaden, rechtliche Ansprüche.',
        punkte: 2,
        stichwoerter: [
          'falsche Auskunft',
          'Halluzination',
          'erfunden',
          'falsche Zusage',
          'Falschinformation',
        ],
      ),
      krit(
        'Datenschutz: Der Chatbot verarbeitet personenbezogene Daten, die beim externen Anbieter landen können (Rechtsgrundlage, AVV nötig).',
        punkte: 2,
        stichwoerter: [
          'Datenschutz',
          'personenbezogen',
          'DSGVO',
          'Kundendaten',
          'AVV',
        ],
      ),
      krit(
        'Manipulation: Durch geschickte Eingaben (Prompt Injection) lässt sich der Chatbot zu unerwünschten Aussagen oder Rabatten bringen.',
        punkte: 2,
        stichwoerter: [
          'Prompt Injection',
          'Manipulation',
          'manipulieren',
          'austricksen',
          'Missbrauch',
        ],
      ),
      krit(
        'Akzeptanz: Kunden fühlen sich abgewimmelt, wenn kein Mensch erreichbar ist oder nicht erkennbar ist, dass eine KI antwortet (Transparenzpflicht).',
        punkte: 2,
        stichwoerter: [
          'Akzeptanz',
          'kein Mensch',
          'unzufrieden',
          'Transparenz',
          'Kennzeichnung',
        ],
      ),
    ],
    loesung:
        'Risiko 1: Der Chatbot kann falsche Auskünfte geben, etwa erfundene Lieferzeiten oder Zusagen bei Reklamationen. Das verärgert Kunden und kann rechtliche Folgen haben. Risiko 2: Der Chatbot verarbeitet personenbezogene Kundendaten; ohne Rechtsgrundlage und Vertrag mit dem Anbieter drohen Datenschutzverstöße. Weitere Risiken sind die Manipulation durch geschickte Eingaben und fehlende Akzeptanz, wenn kein Mensch erreichbar ist.',
    explanation:
        'Je beschriebenem Risiko 2 Punkte (Risiko plus Folge), verlangt sind zwei. Nach der EU-KI-Verordnung muss außerdem erkennbar sein, dass die Kunden mit einer KI kommunizieren.',
    punkte: 4,
  ),
  paare(
    'i4-ir-3',
    'ki-grenzen',
    scenario:
        'Für die KI-Richtlinie der Pixelhafen Medien GmbH ordnest du jedem Risiko eine Gegenmaßnahme zu.',
    prompt: 'Ordne jedem Risiko die passende Gegenmaßnahme zu.',
    paare: [
      paar('Halluzination', 'Fakten und Quellen nachprüfen'),
      paar('Bias', 'ausgewogene Trainingsdaten verwenden'),
      paar('Datenabfluss', 'keine vertraulichen Daten eingeben'),
      paar('Prompt Injection', 'Rechte des Assistenten begrenzen'),
      paar('blindes Vertrauen', 'Mensch trifft die Entscheidung'),
    ],
    explanation:
        'Halluzinationen fängt nur die Prüfung der Fakten ab. Gegen Bias helfen ausgewogene Daten und Kontrollen je Gruppe. Vertrauliche und personenbezogene Daten gehören nicht in öffentliche Werkzeuge. Gegen Prompt Injection begrenzt man, was der Assistent tun darf. Und am Ende entscheidet ein Mensch.',
    punkte: 3,
  ),
  freitext(
    'i4-ir-4',
    'ki-grenzen',
    scenario:
        'Die Pixelhafen Medien GmbH erarbeitet eine Richtlinie für den Umgang mit KI-Werkzeugen. Als Grundlage dient ein Abschnitt aus einem englischen Leitfaden.',
    code:
        'Generative AI tools are useful,\n'
        'but they bring risks. They can\n'
        'produce answers that sound\n'
        'correct but are wrong. Their\n'
        'training data may contain\n'
        'prejudice, so some groups of\n'
        'people are treated unfairly.\n'
        'Confidential data that\n'
        'employees type into a public\n'
        'tool may leave the company.\n'
        'Finally, staff may trust the\n'
        'results too much and stop\n'
        'checking them.',
    prompt: 'Nenne auf Deutsch drei Risiken, die der Text beschreibt.',
    kriterien: [
      krit(
        'Antworten, die richtig klingen, aber falsch sind',
        stichwoerter: [
          'falsch',
          'falsche Antworten',
          'Halluzination',
          'fehlerhaft',
        ],
      ),
      krit(
        'Vorurteile in den Trainingsdaten: Gruppen werden unfair behandelt',
        stichwoerter: [
          'Vorurteil',
          'unfair',
          'Bias',
          'benachteiligt',
          'Diskriminierung',
        ],
      ),
      krit(
        'Vertrauliche Daten können das Unternehmen verlassen',
        stichwoerter: [
          'vertrauliche Daten',
          'Datenabfluss',
          'verlassen',
          'Geheimnisse',
          'öffentliches Tool',
        ],
      ),
      krit(
        'Beschäftigte vertrauen den Ergebnissen zu sehr und prüfen nicht mehr',
        stichwoerter: [
          'zu sehr vertrauen',
          'blind',
          'nicht mehr prüfen',
          'ungeprüft',
          'Vertrauen',
        ],
      ),
    ],
    loesung:
        'Der Text nennt vier Risiken: Antworten können richtig klingen, aber falsch sein. Die Trainingsdaten können Vorurteile enthalten, sodass Gruppen unfair behandelt werden. Vertrauliche Daten, die in ein öffentliches Werkzeug eingegeben werden, können das Unternehmen verlassen. Beschäftigte können den Ergebnissen zu sehr vertrauen und sie nicht mehr prüfen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3. Der Text enthält vier Risiken. Stichworte auf Deutsch genügen. „Prejudice“ bedeutet Vorurteil, „confidential“ vertraulich.',
    punkte: 3,
    tags: ['englisch'],
  ),
];
