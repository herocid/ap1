import '../../models/nugget.dart';
import '../builders.dart';

/// Lernschritte Bereich 04, Teil 2: Datenmodellierung, Web, Daten und
/// Multimedia, KI-Grundlagen.
final List<Nugget> nuggetsA04Daten = [
  // ================================================================ ER-Modell
  konzept(
    'n-de-1',
    'dm-erm',
    'Erst modellieren, dann speichern',
    'Bevor eine Datenbank entsteht, planst du, welche Daten sie enthält und wie sie zusammenhängen. Das Entity-Relationship-Modell (ERM) beschreibt das fachlich und unabhängig von einer Software. Erst danach übersetzt du es in Tabellen.',
    points: [
      'Konzeptionell: ERM (was gibt es, wie hängt es zusammen?)',
      'Logisch: relationales Modell (welche Tabellen, Spalten und Schlüssel?)',
      'Physisch: Umsetzung in einem konkreten Datenbanksystem',
    ],
  ),
  konzept(
    'n-de-2',
    'dm-erm',
    'Entität und Entitätstyp',
    'Eine Entität ist ein einzelnes, unterscheidbares Objekt, über das Daten gespeichert werden, etwa die Kundin Frau Yilmaz oder die Rechnung 2025-117. Gleichartige Entitäten fasst man zu einem Entitätstyp zusammen, zum Beispiel „Kunde“ oder „Rechnung“.',
    points: [
      'Entitäten können Personen (Kunde), Dinge (Artikel), Orte (Filiale) oder Vorgänge (Bestellung) sein',
      'Im Diagramm erscheint nur der Entitätstyp, nie die einzelne Entität',
    ],
  ),
  konzept(
    'n-de-3',
    'dm-erm',
    'Attribute und Beziehungen',
    'Attribute beschreiben die Eigenschaften eines Entitätstyps, Beziehungen verbinden Entitätstypen miteinander. Ein Schlüsselattribut macht jede Entität eindeutig unterscheidbar.',
    points: [
      'Attribute von „Kunde“: KundenNr, Name, E-Mail, Ort',
      'Schlüsselattribut von „Kunde“: KundenNr, wird unterstrichen',
      'Beziehung als Verb: Kunde „erteilt“ Auftrag',
      'Auch eine Beziehung kann Attribute haben: „Menge“ bei Auftrag „enthält“ Artikel',
    ],
  ),
  vergleich(
    'n-de-4',
    'dm-erm',
    'Die Chen-Notation',
    'Im ER-Diagramm nach Peter Chen hat jedes Element eine feste Form. Linien verbinden Attribute mit ihrem Entitätstyp und Entitätstypen mit ihren Beziehungen.',
    [
      ['Symbol', 'steht für', 'Beispiel'],
      ['Rechteck', 'Entitätstyp', 'Kunde'],
      ['Raute', 'Beziehung', 'erteilt'],
      ['Ellipse', 'Attribut', 'Name'],
      ['unterstrichen', 'Schlüsselattribut', 'KundenNr'],
      ['Zahl an der Linie', 'Kardinalität', '1, n, m'],
    ],
  ),
  skizze(
    'n-de-5',
    'dm-erm',
    'Ein ERM für einen Webshop',
    'So sieht ein kleines ERM aus: drei Entitätstypen mit ihren Attributen, verbunden über zwei Beziehungen. Der Primärschlüssel jedes Entitätstyps ist unterstrichen.',
    ErmDiagramm(
      [
        ErmEntitaet(
          'Kunde',
          attribute: ['KundenNr', 'Name', 'E-Mail'],
          schluessel: ['KundenNr'],
        ),
        ErmEntitaet(
          'Auftrag',
          attribute: ['AuftragsNr', 'Datum'],
          schluessel: ['AuftragsNr'],
        ),
        ErmEntitaet(
          'Artikel',
          attribute: ['ArtikelNr', 'Bezeichnung', 'Preis'],
          schluessel: ['ArtikelNr'],
        ),
      ],
      beziehungen: [
        ErmBeziehung('Kunde', 'erteilt', 'Auftrag', '1', 'n'),
        ErmBeziehung('Auftrag', 'enthält', 'Artikel', 'n', 'm'),
      ],
    ),
    points: [
      'Ein Kunde erteilt viele Aufträge, jeder Auftrag stammt von einem Kunden (1:n)',
      'Ein Auftrag enthält viele Artikel, ein Artikel steckt in vielen Aufträgen (n:m)',
      'Die Menge je Artikel gehört als Attribut an die Beziehung „enthält“',
    ],
  ),
  vergleich(
    'n-de-6',
    'dm-erm',
    'Besondere Attribute',
    'Nicht jedes Attribut ist ein einfacher Einzelwert. Für die spätere Tabelle ist wichtig, welche Art vorliegt.',
    [
      ['Art', 'Beispiel', 'Umgang'],
      ['zusammengesetzt', 'Adresse', 'in Straße, PLZ, Ort zerlegen'],
      ['mehrwertig', 'mehrere Telefonnummern', 'eigener Entitätstyp'],
      ['abgeleitet', 'Alter aus Geburtsdatum', 'berechnen, nicht speichern'],
    ],
  ),
  ablauf(
    'n-de-7',
    'dm-erm',
    'Vom Text zum ER-Modell',
    'In der Prüfung steht meist ein kurzer Text mit den Anforderungen. Mit diesem Vorgehen entsteht daraus Schritt für Schritt das ERM.',
    [
      'Substantive markieren: Kandidaten für Entitätstypen',
      'Prüfen: Werden zu dem Begriff eigene Daten gespeichert? Dann Entitätstyp, sonst Attribut',
      'Beschreibende Angaben als Attribute zuordnen',
      'Verben zwischen zwei Entitätstypen werden zu Beziehungen',
      'Kardinalitäten aus Formulierungen wie „genau ein“ oder „mehrere“ ablesen',
      'Je Entitätstyp einen Primärschlüssel festlegen und unterstreichen',
    ],
  ),
  beispiel(
    'n-de-8',
    'dm-erm',
    'Durchgespielt: Fahrradverleih',
    '„Ein Verleih hat mehrere Filialen (Nummer, Ort). Jedes Fahrrad (Rahmennummer, Typ) gehört zu genau einer Filiale. Kunden (Kundennummer, Name) leihen Fahrräder aus, gespeichert wird das Ausleihdatum. Ein Kunde leiht viele Räder, ein Rad wird von vielen Kunden geliehen.“',
    schritte: [
      'Substantive mit eigenen Daten: Filiale, Fahrrad, Kunde -> drei Entitätstypen',
      'Attribute zuordnen: Filiale (FilialNr, Ort), Fahrrad (RahmenNr, Typ), Kunde (KundenNr, Name)',
      'Verben zu Beziehungen: Filiale „besitzt“ Fahrrad, Kunde „leiht“ Fahrrad',
      'Kardinalitäten: Jedes Rad gehört zu genau einer Filiale -> 1:n. Kunde und Rad: beidseitig viele -> n:m',
      'Das Ausleihdatum gehört weder nur zum Kunden noch nur zum Rad -> Attribut der Beziehung „leiht“',
    ],
    ergebnis:
        'Filiale 1:n Fahrrad, Kunde n:m Fahrrad. Das Ausleihdatum hängt an der Beziehung „leiht“.',
    skizze: ErmDiagramm(
      [
        ErmEntitaet(
          'Filiale',
          attribute: ['FilialNr', 'Ort'],
          schluessel: ['FilialNr'],
        ),
        ErmEntitaet(
          'Fahrrad',
          attribute: ['RahmenNr', 'Typ'],
          schluessel: ['RahmenNr'],
        ),
        ErmEntitaet(
          'Kunde',
          attribute: ['KundenNr', 'Name'],
          schluessel: ['KundenNr'],
        ),
      ],
      beziehungen: [
        ErmBeziehung('Filiale', 'besitzt', 'Fahrrad', '1', 'n'),
        ErmBeziehung('Kunde', 'leiht', 'Fahrrad', 'n', 'm'),
      ],
    ),
  ),
  vergleich(
    'n-de-9',
    'dm-erm',
    'Vom ERM zur Tabelle',
    'Anschließend überführst du das ERM in das relationale Modell. Dabei findet jedes Element des ERM seine Entsprechung in der Tabelle.',
    [
      ['ERM', 'Relationales Modell'],
      ['Entitätstyp', 'Tabelle (Relation)'],
      ['Entität', 'Zeile (Datensatz, Tupel)'],
      ['Attribut', 'Spalte'],
      ['Schlüsselattribut', 'Primärschlüssel'],
      ['Beziehung', 'Fremdschlüssel oder Zwischentabelle'],
    ],
  ),
  falle(
    'n-de-10',
    'dm-erm',
    'Attribut oder eigener Entitätstyp?',
    'Nicht jedes Substantiv wird ein Entitätstyp. „Ort“ ist meist nur ein Attribut des Kunden. Sobald zu einer Sache eigene Eigenschaften gespeichert werden sollen (etwa zu einer Abteilung Name, Standort und Leitung), wird sie ein eigener Entitätstyp.',
  ),
  falle(
    'n-de-11',
    'dm-erm',
    'Fremdschlüssel gehören nicht ins ERM',
    'Im ERM zeigt die Linie über die Raute, wer mit wem verbunden ist. Einen Fremdschlüssel wie KundenNr als Attribut beim Auftrag einzutragen, ist doppelt gemoppelt, denn er entsteht erst beim Übergang ins relationale Modell. Ebenso häufig vergessen: die Kardinalitäten an jeder Linie.',
  ),
  merke(
    'n-de-12',
    'dm-erm',
    'Das Wichtigste zum ERM',
    'Ein ERM beschreibt fachlich, welche Daten es gibt und wie sie zusammenhängen.',
    points: [
      'Substantiv mit eigenen Daten = Entitätstyp, Eigenschaft = Attribut, Verb = Beziehung',
      'Jeder Entitätstyp braucht ein unterstrichenes Schlüsselattribut',
      'An jede Beziehungslinie gehört eine Kardinalität',
    ],
    satz: 'Rechteck = Entitätstyp, Raute = Beziehung, Ellipse = Attribut.',
  ),

  // ============================================================ Kardinalitäten
  konzept(
    'n-dk-1',
    'dm-kardinalitaet',
    'Was die Kardinalität angibt',
    'Die Kardinalität legt fest, mit wie vielen Entitäten des anderen Typs eine Entität höchstens in Beziehung stehen kann. Eine Beziehung liest man immer in beide Richtungen: Wie viele B hat ein A, und wie viele A hat ein B?',
  ),
  vergleich(
    'n-dk-2',
    'dm-kardinalitaet',
    'Die drei Grundtypen',
    'Welcher Typ gilt, entscheiden die Regeln des Auftraggebers. Die Beispiele zeigen übliche Regeln.',
    [
      ['Typ', 'Beispiel', 'Lesart'],
      [
        '1:1',
        'Mitarbeiter - Dienstwagen',
        'jeder hat höchstens einen des anderen',
      ],
      [
        '1:n',
        'Abteilung - Mitarbeiter',
        'eine Abteilung hat viele, jeder gehört zu einer',
      ],
      ['n:m', 'Schüler - Kurs', 'beide Seiten haben viele'],
    ],
  ),
  skizze(
    'n-dk-3',
    'dm-kardinalitaet',
    'Alle drei in einem Diagramm',
    'Die Kardinalität steht in der Chen-Notation an der Linie neben dem Entitätstyp, von dem „so viele“ vorkommen können. Lies: Eine Abteilung hat n Mitarbeiter, ein Mitarbeiter gehört zu 1 Abteilung.',
    ErmDiagramm(
      [
        ErmEntitaet(
          'Abteilung',
          attribute: ['AbtNr', 'Bezeichnung'],
          schluessel: ['AbtNr'],
        ),
        ErmEntitaet(
          'Mitarbeiter',
          attribute: ['PersNr', 'Name'],
          schluessel: ['PersNr'],
        ),
        ErmEntitaet(
          'Dienstwagen',
          attribute: ['Kennzeichen', 'Modell'],
          schluessel: ['Kennzeichen'],
        ),
        ErmEntitaet(
          'Projekt',
          attribute: ['ProjNr', 'Titel'],
          schluessel: ['ProjNr'],
        ),
      ],
      beziehungen: [
        ErmBeziehung('Abteilung', 'beschäftigt', 'Mitarbeiter', '1', 'n'),
        ErmBeziehung('Mitarbeiter', 'fährt', 'Dienstwagen', '1', '1'),
        ErmBeziehung('Mitarbeiter', 'arbeitet mit', 'Projekt', 'n', 'm'),
      ],
    ),
  ),
  ablauf(
    'n-dk-4',
    'dm-kardinalitaet',
    'Kardinalität in zwei Sätzen bestimmen',
    'Mit zwei Testsätzen findest du den Typ sicher. Beispiel: Kunde und Rechnung.',
    [
      'Satz 1: „Ein Kunde hat ... Rechnungen“ -> viele',
      'Satz 2: „Eine Rechnung gehört zu ... Kunden“ -> genau einem',
      'Kombinieren: einmal „viele“, einmal „eins“ -> 1:n',
      'Die 1 steht beim Kunden, das n bei der Rechnung',
    ],
    table: [
      ['Satz 1', 'Satz 2', 'Typ'],
      ['höchstens eins', 'höchstens eins', '1:1'],
      ['viele', 'höchstens eins', '1:n'],
      ['viele', 'viele', 'n:m'],
    ],
  ),
  vergleich(
    'n-dk-5',
    'dm-kardinalitaet',
    'Genauer: Muss oder kann?',
    'Die einfache Chen-Notation sagt nur „eins“ oder „viele“. Die modifizierte Chen-Notation unterscheidet zusätzlich, ob die Teilnahme Pflicht ist.',
    [
      ['Zeichen', 'Bedeutung', 'Anzahl'],
      ['1', 'genau eins', '1'],
      ['c', 'keins oder eins', '0 oder 1'],
      ['m', 'mindestens eins', '1 bis viele'],
      ['mc', 'beliebig viele', '0 bis viele'],
    ],
    points: [
      'Beispiel: Abteilung 1 : mc Mitarbeiter: jeder Mitarbeiter hat genau eine Abteilung, eine neue Abteilung darf noch leer sein',
    ],
  ),
  konzept(
    'n-dk-6',
    'dm-kardinalitaet',
    'Min-Max-Notation',
    'Paare wie (0,n) oder (1,1) sagen, wie oft eine Entität mindestens und höchstens an der Beziehung teilnimmt. Sie stehen deshalb auf der anderen Seite als die Chen-Angabe: Ein Mitarbeiter gehört zu genau einer Abteilung -> (1,1) steht beim Mitarbeiter.',
    points: [
      'Abteilung (0,n) - beschäftigt - (1,1) Mitarbeiter',
      'Eine 0 als Minimum heißt: Die Teilnahme ist optional',
      'In der Krähenfuß-Notation vieler Werkzeuge markiert der dreizackige „Fuß“ die n-Seite',
    ],
  ),
  ablauf(
    'n-dk-7',
    'dm-kardinalitaet',
    'n:m auflösen',
    'Relationale Tabellen können n:m nicht direkt speichern. Beispiel Webshop: Eine Bestellung enthält viele Artikel, ein Artikel steckt in vielen Bestellungen.',
    [
      'Zwischentabelle anlegen: Bestellposition',
      'Primärschlüssel beider Seiten als Fremdschlüssel aufnehmen: BestellNr und ArtikelNr',
      'Beide zusammen bilden den Primärschlüssel der Zwischentabelle',
      'Attribute der Beziehung dort ablegen, z. B. Menge',
      'Ergebnis: zwei 1:n-Beziehungen: Bestellung 1:n Bestellposition, Artikel 1:n Bestellposition',
    ],
  ),
  skizze(
    'n-dk-8',
    'dm-kardinalitaet',
    'Nach der Auflösung',
    'Aus einer n:m-Beziehung werden zwei 1:n-Beziehungen. Die Zwischentabelle steht in der Mitte und trägt die n-Seite beider Beziehungen.',
    ErmDiagramm(
      [
        ErmEntitaet(
          'Bestellung',
          attribute: ['BestellNr', 'Datum'],
          schluessel: ['BestellNr'],
        ),
        ErmEntitaet(
          'Bestellposition',
          attribute: ['BestellNr', 'ArtikelNr', 'Menge'],
          schluessel: ['BestellNr', 'ArtikelNr'],
        ),
        ErmEntitaet(
          'Artikel',
          attribute: ['ArtikelNr', 'Bezeichnung'],
          schluessel: ['ArtikelNr'],
        ),
      ],
      beziehungen: [
        ErmBeziehung('Bestellung', 'hat', 'Bestellposition', '1', 'n'),
        ErmBeziehung('Artikel', 'steht in', 'Bestellposition', '1', 'n'),
      ],
    ),
  ),
  vergleich(
    'n-dk-9',
    'dm-kardinalitaet',
    'Wohin der Fremdschlüssel kommt',
    'Die Kardinalität entscheidet, wie die Beziehung im relationalen Modell umgesetzt wird.',
    [
      ['Typ', 'Umsetzung'],
      ['1:1', 'Fremdschlüssel auf einer Seite, dort nur einmal erlaubt'],
      ['1:n', 'Fremdschlüssel in der Tabelle der n-Seite'],
      ['n:m', 'Zwischentabelle mit zwei Fremdschlüsseln'],
    ],
    merksatz:
        'Bei 1:n wandert der Primärschlüssel der 1-Seite als Fremdschlüssel auf die n-Seite.',
  ),
  beispiel(
    'n-dk-10',
    'dm-kardinalitaet',
    'Durchgerechnet: Wie viele Tabellen?',
    'Ein Datenmodell hat die Entitätstypen Kunde, Bestellung, Artikel und Lieferant. Kunde - Bestellung ist 1:n, Bestellung - Artikel ist n:m, Lieferant - Artikel ist 1:n. Wie viele Tabellen entstehen?',
    schritte: [
      'Jeder Entitätstyp wird eine Tabelle: 4 Tabellen',
      'Kunde - Bestellung (1:n): Fremdschlüssel KundenNr in Bestellung, keine neue Tabelle',
      'Lieferant - Artikel (1:n): Fremdschlüssel LieferantNr in Artikel, keine neue Tabelle',
      'Bestellung - Artikel (n:m): Zwischentabelle Bestellposition, + 1 Tabelle',
      'Summe: 4 + 1 = 5',
    ],
    ergebnis:
        '5 Tabellen: Kunde, Bestellung, Artikel, Lieferant, Bestellposition.',
    code:
        'Kunde (KundenNr PK, Name)\n'
        'Lieferant (LiefNr PK, Firma)\n'
        'Bestellung (BestellNr PK,\n'
        '  Datum, KundenNr FK)\n'
        'Artikel (ArtikelNr PK,\n'
        '  Bezeichnung, LiefNr FK)\n'
        'Bestellposition (\n'
        '  BestellNr PK FK,\n'
        '  ArtikelNr PK FK, Menge)',
  ),
  falle(
    'n-dk-11',
    'dm-kardinalitaet',
    'Nur eine Richtung gelesen',
    'Aus „Ein Kunde erteilt viele Aufträge“ allein folgt noch nicht 1:n. Erst die Gegenrichtung entscheidet: Gehört jeder Auftrag genau einem Kunden, ist es 1:n. Können mehrere Kunden gemeinsam einen Auftrag erteilen, wäre es n:m.',
  ),
  falle(
    'n-dk-12',
    'dm-kardinalitaet',
    'Fremdschlüssel auf der falschen Seite',
    'Eine Spalte MitarbeiterNr in der Tabelle Abteilung kann nur einen einzigen Mitarbeiter aufnehmen. Das passt nicht zu „eine Abteilung hat viele“. Der Fremdschlüssel gehört immer auf die n-Seite. Umgekehrt braucht 1:n keine Zwischentabelle, nur n:m.',
  ),
  merke(
    'n-dk-13',
    'dm-kardinalitaet',
    'Das Wichtigste zu Kardinalitäten',
    'Kardinalitäten bestimmen, wie viele Tabellen und Fremdschlüssel entstehen.',
    points: [
      'Immer beide Richtungen lesen',
      '1:n -> Fremdschlüssel auf die n-Seite',
      'n:m -> Zwischentabelle mit zusammengesetztem Schlüssel',
    ],
    satz:
        'n:m wird immer über eine Zwischentabelle in zwei 1:n-Beziehungen aufgelöst.',
  ),

  // ================================================================ Schlüssel
  konzept(
    'n-dl-1',
    'dm-schluessel',
    'Der Primärschlüssel',
    'Der Primärschlüssel (PK, primary key) identifiziert jeden Datensatz einer Tabelle eindeutig. Er darf nie leer sein, darf sich in der Tabelle nicht wiederholen und sollte sich nicht ändern.',
    points: [
      'eindeutig: kein Wert kommt doppelt vor',
      'nie leer: jeder Datensatz hat einen Wert',
      'stabil: ändert sich während der Lebensdauer nicht',
      'minimal: enthält keine überflüssigen Spalten',
    ],
  ),
  vergleich(
    'n-dl-2',
    'dm-schluessel',
    'Schlüsselarten',
    'Schlüssel unterscheiden sich darin, woher ihr Wert kommt und welche Aufgabe sie haben.',
    [
      ['Schlüssel', 'Merkmal', 'Beispiel'],
      ['natürlich', 'fachliches Merkmal', 'ISBN eines Buchs'],
      [
        'künstlich (Surrogat)',
        'vom System vergeben, ohne Bedeutung',
        'KundenNr 10457',
      ],
      ['zusammengesetzt', 'mehrere Spalten gemeinsam', 'BestellNr + ArtikelNr'],
      [
        'Fremdschlüssel',
        'verweist auf einen Primärschlüssel',
        'KundenNr in Bestellung',
      ],
    ],
  ),
  konzept(
    'n-dl-3',
    'dm-schluessel',
    'Schlüsselkandidaten',
    'Oft kommen mehrere Spalten als Primärschlüssel in Frage. Jede davon ist ein Schlüsselkandidat. Einer wird zum Primärschlüssel gewählt, die übrigen heißen Alternativschlüssel und bleiben trotzdem eindeutig.',
    points: [
      'Tabelle Mitarbeiter: PersNr und Steuer-ID sind beide eindeutig',
      'Gewählt wird meist die kurze, stabile PersNr',
      'Die Steuer-ID bleibt Alternativschlüssel. Doppelte Werte wären ein Fehler',
    ],
  ),
  konzept(
    'n-dl-4',
    'dm-schluessel',
    'Warum oft künstliche Schlüssel',
    'Natürliche Merkmale sind selten dauerhaft eindeutig und stabil: Namen wiederholen sich, E-Mail-Adressen ändern sich, Kfz-Kennzeichen werden neu vergeben. Ein künstlicher Schlüssel wird vom System vergeben, ist garantiert eindeutig und ändert sich nie.',
  ),
  konzept(
    'n-dl-5',
    'dm-schluessel',
    'Der Fremdschlüssel',
    'Ein Fremdschlüssel (FK, foreign key) ist eine Spalte, deren Werte auf den Primärschlüssel einer anderen Tabelle verweisen. So entsteht die Verbindung zwischen zwei Tabellen, ohne Daten doppelt zu speichern.',
    points: [
      'KundenNr in Bestellung verweist auf KundenNr in Kunde',
      'Er darf sich wiederholen: ein Kunde, viele Bestellungen',
      'Er darf leer sein, wenn die Beziehung optional ist',
      'Der Name muss nicht gleich sein, der Wertebereich schon',
    ],
  ),
  formel(
    'n-dl-6',
    'dm-schluessel',
    'Die Tabellenschreibweise',
    'Das relationale Modell wird in der Prüfung oft als Text notiert: Tabellenname, dann die Spalten in Klammern. Den Primärschlüssel unterstreichst du, Fremdschlüssel markierst du, etwa mit einem Pfeil oder dem Zusatz FK.',
    'Kunde (KundenNr PK, Name, Ort)\n'
        '\n'
        'Bestellung (BestellNr PK,\n'
        '  Datum, KundenNr FK)\n'
        '\n'
        'Position (BestellNr PK FK,\n'
        '  ArtikelNr PK FK, Menge)',
    points: [
      'PK = Primärschlüssel (im Heft unterstrichen)',
      'FK = Fremdschlüssel mit Verweis auf eine andere Tabelle',
      'Eine Spalte kann beides sein, wie BestellNr in Position',
    ],
  ),
  beispiel(
    'n-dl-7',
    'dm-schluessel',
    'Über den Fremdschlüssel suchen',
    'Die Tabelle Bestellung ist unten abgebildet, die Tabelle Kunde im Kasten. Wer hat Bestellung 5003 aufgegeben, und wie viele Bestellungen hat diese Person?',
    table: [
      ['BestellNr', 'Datum', 'KundenNr'],
      ['5001', '03.02.', 'K1'],
      ['5002', '03.02.', 'K2'],
      ['5003', '04.02.', 'K2'],
    ],
    code:
        'Kunde\n'
        'KundenNr  Name   Ort\n'
        'K1        Meyer  Köln\n'
        'K2        Aydin  Bonn',
    schritte: [
      'In Bestellung die Zeile mit BestellNr 5003 suchen: KundenNr = K2',
      'In Kunde den Primärschlüssel K2 suchen: Name Aydin, Ort Bonn',
      'In Bestellung alle Zeilen mit KundenNr K2 zählen: 5002 und 5003',
    ],
    ergebnis:
        'Frau oder Herr Aydin aus Bonn, mit 2 Bestellungen. Der Fremdschlüssel K2 wiederholt sich.',
  ),
  ablauf(
    'n-dl-8',
    'dm-schluessel',
    'Referenzielle Integrität',
    'Referenzielle Integrität heißt: Jeder Fremdschlüsselwert verweist auf einen vorhandenen Primärschlüssel. Die Datenbank prüft das bei jeder Änderung. Beispiel: Bestellung mit der Spalte KundenNr.',
    [
      'Neue Bestellung für KundenNr 999: Kunde 999 gibt es nicht -> wird abgelehnt',
      'Kunde 10457 soll gelöscht werden, hat aber Bestellungen -> Löschen wird verhindert',
      'Alternative Löschweitergabe (Kaskade): Mit dem Kunden werden seine Bestellungen mitgelöscht',
      'Alternative: Fremdschlüssel auf leer setzen, wenn die Beziehung optional ist',
      'Ohne diese Prüfung entstehen verwaiste Datensätze',
    ],
  ),
  vergleich(
    'n-dl-9',
    'dm-schluessel',
    'Zwischentabelle: zusammengesetzt oder künstlich?',
    'Für eine Zwischentabelle gibt es zwei übliche Lösungen. Beide sind richtig, wenn die Regeln passen.',
    [
      ['Variante', 'Schlüssel', 'passt, wenn'],
      [
        'zusammengesetzt',
        'BestellNr + ArtikelNr',
        'jede Kombination nur einmal',
      ],
      ['künstlich', 'PositionsNr', 'Kombination darf mehrfach vorkommen'],
    ],
    points: [
      'Beispiel für mehrfach: derselbe Patient hat mehrmals Termine beim selben Arzt, dann ist PatientNr + ArztNr nicht eindeutig',
    ],
  ),
  falle(
    'n-dl-10',
    'dm-schluessel',
    'Fremdschlüssel dürfen sich wiederholen',
    'Anders als der Primärschlüssel ist ein Fremdschlüssel nicht eindeutig: Dieselbe KundenNr steht in jeder Bestellung dieses Kunden. Genau das macht die 1:n-Beziehung aus. Wer in der Prüfung „Fremdschlüssel sind eindeutig“ ankreuzt, verwechselt die beiden.',
  ),
  falle(
    'n-dl-11',
    'dm-schluessel',
    'Schlechte Primärschlüssel',
    'Name, Telefonnummer oder E-Mail taugen nicht als Primärschlüssel, weil sie nicht sicher eindeutig, nicht stabil oder manchmal leer sind. Auch ein zusammengesetzter Schlüssel aus mehr Spalten als nötig ist falsch, denn er ist nicht minimal.',
  ),
  merke(
    'n-dl-12',
    'dm-schluessel',
    'Das Wichtigste zu Schlüsseln',
    'Primär- und Fremdschlüssel arbeiten immer zusammen.',
    points: [
      'PK: eindeutig, nie leer, stabil, minimal',
      'FK: verweist auf einen PK, darf sich wiederholen',
      'Referenzielle Integrität verhindert Verweise ins Leere',
    ],
    satz: 'Primärschlüssel identifiziert, Fremdschlüssel verbindet.',
  ),

  // ============================================================ Normalisierung
  konzept(
    'n-dn-1',
    'dm-normalisierung',
    'Warum normalisieren?',
    'Normalisierung zerlegt eine Tabelle so, dass jede Information genau einmal gespeichert wird. Doppelte Daten (Redundanz) kosten Platz und führen zu Widersprüchen, sobald nur eine Kopie geändert wird.',
    points: [
      'Ziel: Redundanz vermeiden, Anomalien verhindern',
      'Weg: Tabelle Schritt für Schritt in 1NF, 2NF und 3NF bringen',
      'Es geht keine Information verloren, sie wird nur verteilt',
    ],
  ),
  konzept(
    'n-dn-2',
    'dm-normalisierung',
    'Funktionale Abhängigkeit',
    'B ist von A funktional abhängig (A -> B), wenn zu jedem Wert von A genau ein Wert von B gehört. Beispiel: KundenNr -> Name. Kennt man die KundenNr, steht der Name fest.',
    points: [
      'voll: B hängt vom ganzen Schlüssel ab (BestellNr + ArtikelNr -> Menge)',
      'partiell: B hängt nur von einem Teil des Schlüssels ab (ArtikelNr -> Bezeichnung)',
      'transitiv: B hängt über ein Nichtschlüsselattribut ab (BestellNr -> KundenNr -> Name)',
    ],
  ),
  vergleich(
    'n-dn-3',
    'dm-normalisierung',
    'Die drei Normalformen',
    'Jede Normalform setzt die vorige voraus und beseitigt eine bestimmte Art von Redundanz.',
    [
      ['Form', 'Regel'],
      ['1NF', 'alle Werte atomar, keine Wiederholungsgruppen'],
      ['2NF', '1NF + keine partiellen Abhängigkeiten vom Schlüssel'],
      ['3NF', '2NF + keine transitiven Abhängigkeiten'],
    ],
  ),
  konzept(
    'n-dn-4',
    'dm-normalisierung',
    'Die Ausgangstabelle',
    'Ein Webshop speichert jede Bestellung in einer einzigen Zeile. Die Spalten Kunde und Artikel enthalten mehrere Werte auf einmal. Die Tabelle ist nicht normalisiert.',
    table: [
      ['BestNr', 'Datum', 'Kunde', 'Artikel'],
      [
        '1001',
        '12.03.',
        'K7 Meyer, Köln',
        '2 Maus (A1, 15 €); 1 Tastatur (A2, 40 €)',
      ],
      ['1002', '13.03.', 'K9 Aydin, Bonn', '1 Maus (A1, 15 €)'],
      ['1003', '13.03.', 'K7 Meyer, Köln', '3 Kabel (A3, 5 €)'],
    ],
    points: [
      'Kunde vereint KdNr, Name und Ort in einem Feld',
      'Artikel ist eine Wiederholungsgruppe: eine Liste mit Menge, ArtNr, Bezeichnung und Preis',
    ],
  ),
  beispiel(
    'n-dn-5',
    'dm-normalisierung',
    'Schritt 1: erste Normalform',
    'Bringe die Ausgangstabelle in die 1NF: Jede Zelle darf nur einen einzigen Wert enthalten.',
    schritte: [
      'Zusammengesetzte Felder trennen: Kunde -> KdNr, Name, Ort',
      'Wiederholungsgruppe auflösen: eine Zeile pro bestelltem Artikel',
      'Artikelangaben trennen: ArtNr, Bez, Preis, Menge als eigene Spalten',
      'Schlüssel bestimmen: BestNr allein ist nicht mehr eindeutig (1001 steht zweimal) -> BestNr + ArtNr',
    ],
    code:
        'Bestellung (BestNr PK, ArtNr PK,\n'
        '  Datum, KdNr, Name, Ort,\n'
        '  Bez, Preis, Menge)',
    table: [
      ['BestNr', 'ArtNr', 'Name', 'Bez'],
      ['1001', 'A1', 'Meyer', 'Maus'],
      ['1001', 'A2', 'Meyer', 'Tastatur'],
      ['1002', 'A1', 'Aydin', 'Maus'],
      ['1003', 'A3', 'Meyer', 'Kabel'],
    ],
    ergebnis:
        '1NF erreicht: 4 Zeilen, alle Werte atomar, Schlüssel BestNr + ArtNr. Aber: Meyer steht dreimal, Maus zweimal.',
  ),
  vergleich(
    'n-dn-6',
    'dm-normalisierung',
    'Die Anomalien der 1NF-Tabelle',
    'Die Redundanz in der 1NF-Tabelle führt zu drei typischen Fehlern bei der Pflege der Daten.',
    [
      ['Anomalie', 'am Beispiel'],
      [
        'Einfügen',
        'neuer Artikel A4 ohne Bestellung nicht speicherbar: BestNr fehlt im Schlüssel',
      ],
      [
        'Ändern',
        'Meyer zieht um -> Ort in 3 Zeilen ändern, sonst widersprüchlich',
      ],
      ['Löschen', 'Bestellung 1002 löschen -> Kundin Aydin ist mit weg'],
    ],
  ),
  beispiel(
    'n-dn-7',
    'dm-normalisierung',
    'Schritt 2: zweite Normalform',
    'Der Schlüssel ist zusammengesetzt (BestNr + ArtNr). Prüfe für jedes Nichtschlüsselattribut, ob es vom ganzen Schlüssel oder nur von einem Teil abhängt.',
    schritte: [
      'Datum, KdNr, Name, Ort hängen nur von BestNr ab (partiell) -> eigene Tabelle Bestellung',
      'Bez und Preis hängen nur von ArtNr ab (partiell) -> eigene Tabelle Artikel',
      'Menge hängt von BestNr und ArtNr gemeinsam ab (voll) -> bleibt in Position',
      'Die Schlüsselteile bleiben in Position und werden dort zu Fremdschlüsseln',
    ],
    code:
        'Bestellung (BestNr PK, Datum,\n'
        '  KdNr, Name, Ort)\n'
        'Artikel (ArtNr PK, Bez, Preis)\n'
        'Position (BestNr PK FK,\n'
        '  ArtNr PK FK, Menge)',
    ergebnis:
        '2NF erreicht: 3 Tabellen. Maus steht nur noch einmal in Artikel, Meyer aber noch zweimal in Bestellung.',
  ),
  beispiel(
    'n-dn-8',
    'dm-normalisierung',
    'Schritt 3: dritte Normalform',
    'Jetzt suchst du Abhängigkeiten zwischen Nichtschlüsselattributen. In Bestellung gilt: BestNr -> KdNr -> Name, Ort.',
    schritte: [
      'Name und Ort hängen über KdNr vom Schlüssel ab (transitiv)',
      'KdNr, Name, Ort in eine eigene Tabelle Kunde auslagern, KdNr wird dort Primärschlüssel',
      'KdNr bleibt als Fremdschlüssel in Bestellung',
      'Artikel und Position prüfen: keine transitiven Abhängigkeiten',
    ],
    table: [
      ['Tabelle', 'Primärschlüssel', 'Fremdschlüssel'],
      ['Kunde', 'KdNr', '-'],
      ['Bestellung', 'BestNr', 'KdNr'],
      ['Artikel', 'ArtNr', '-'],
      ['Position', 'BestNr + ArtNr', 'BestNr, ArtNr'],
    ],
    ergebnis:
        '3NF erreicht: Kunde, Bestellung, Artikel, Position: jede Information steht genau einmal.',
  ),
  skizze(
    'n-dn-9',
    'dm-normalisierung',
    'Das Ergebnis als Diagramm',
    'Die vier Tabellen der 3NF und ihre Beziehungen. Aus der ursprünglichen n:m-Beziehung zwischen Bestellung und Artikel ist die Tabelle Position geworden.',
    ErmDiagramm(
      [
        ErmEntitaet(
          'Kunde',
          attribute: ['KdNr', 'Name', 'Ort'],
          schluessel: ['KdNr'],
        ),
        ErmEntitaet(
          'Bestellung',
          attribute: ['BestNr', 'Datum', 'KdNr'],
          schluessel: ['BestNr'],
        ),
        ErmEntitaet(
          'Position',
          attribute: ['BestNr', 'ArtNr', 'Menge'],
          schluessel: ['BestNr', 'ArtNr'],
        ),
        ErmEntitaet(
          'Artikel',
          attribute: ['ArtNr', 'Bez', 'Preis'],
          schluessel: ['ArtNr'],
        ),
      ],
      beziehungen: [
        ErmBeziehung('Kunde', 'gibt auf', 'Bestellung', '1', 'n'),
        ErmBeziehung('Bestellung', 'hat', 'Position', '1', 'n'),
        ErmBeziehung('Artikel', 'steht in', 'Position', '1', 'n'),
      ],
    ),
  ),
  ablauf(
    'n-dn-10',
    'dm-normalisierung',
    'Das Prüfschema für die Prüfung',
    'Mit dieser Reihenfolge normalisierst du jede Tabelle ohne etwas zu übersehen.',
    [
      '1NF: Mehrfachwerte und Listen auflösen, Schlüssel bestimmen',
      '2NF: Ist der Schlüssel zusammengesetzt? Dann partielle Abhängigkeiten auslagern',
      '3NF: Hängt ein Nichtschlüsselattribut von einem anderen ab? Dann auslagern',
      'Fremdschlüssel setzen, damit die Tabellen verbunden bleiben',
      'Probe: Lässt sich jede ursprüngliche Zeile wieder zusammensetzen?',
    ],
  ),
  falle(
    'n-dn-11',
    'dm-normalisierung',
    '2NF nur bei zusammengesetztem Schlüssel',
    'Eine Tabelle in 1NF mit einspaltigem Primärschlüssel ist automatisch in 2NF, denn ein Attribut kann nicht von einem Teil eines einzelnen Schlüssels abhängen. Die 2NF-Prüfung lohnt sich nur bei zusammengesetzten Schlüsseln, die 3NF-Prüfung immer.',
  ),
  falle(
    'n-dn-12',
    'dm-normalisierung',
    'Listenpreis oder Verkaufspreis?',
    'Der Preis in Artikel ist der aktuelle Listenpreis. Soll festgehalten werden, zu welchem Preis damals verkauft wurde, gehört ein eigener Verkaufspreis in Position. Das ist keine Redundanz, sondern eine andere Information. Berechnete Werte wie Positionssumme = Menge × Preis werden dagegen nicht gespeichert.',
  ),
  merke(
    'n-dn-13',
    'dm-normalisierung',
    'Das Wichtigste zur Normalisierung',
    'Jede Stufe beseitigt eine Art von Abhängigkeit.',
    points: [
      '1NF: atomar',
      '2NF: keine partielle Abhängigkeit',
      '3NF: keine transitive Abhängigkeit',
    ],
    satz:
        'Jedes Attribut hängt vom Schlüssel ab, vom ganzen Schlüssel und von nichts als dem Schlüssel.',
  ),

  // ============================================================ Aufbau einer URL
  konzept(
    'n-wu-1',
    'wi-url',
    'Eine URL adressiert eine Ressource',
    'Eine URL (Uniform Resource Locator) sagt dem Browser, mit welchem Protokoll er welchen Server ansprechen und welche Ressource er dort abrufen soll. Jeder Teil hat eine feste Position und ein eigenes Trennzeichen.',
    points: [
      'Ressource: eine Seite, ein Bild, eine Datei oder ein Datensatz einer Schnittstelle',
      'Oberbegriff URI: jede eindeutige Kennung einer Ressource. Eine URL ist ein URI mit Ortsangabe',
    ],
  ),
  formel(
    'n-wu-2',
    'wi-url',
    'Eine URL zerlegt',
    'Beispiel aus einem Webshop, zum Lesen auf Zeilen verteilt. Im Browser steht alles ohne Leerzeichen in einer Zeile.',
    'https://shop.example.com:8443\n'
        '/produkte/maus\n'
        '?farbe=rot&seite=2\n'
        '#details',
    points: [
      'Subdomain shop, Domain example und TLD com bilden den Host',
      'Die Query-Parameter sind Schlüssel=Wert-Paare, getrennt mit &',
    ],
  ),
  skizze(
    'n-wu-3',
    'wi-url',
    'Die Bestandteile als Baum',
    'Die Zeichnung ordnet jedem Teil der Beispiel-URL seine Bezeichnung zu. Der Host zerfällt noch einmal in Subdomain, Domain und Top-Level-Domain.',
    BaumDiagramm(
      BaumKnoten('URL', [
        BaumKnoten('Schema', [], 'https'),
        BaumKnoten('Host', [
          BaumKnoten('Subdomain', [], 'shop'),
          BaumKnoten('Domain', [], 'example'),
          BaumKnoten('TLD', [], 'com'),
        ], 'shop.example.com'),
        BaumKnoten('Port', [], '8443'),
        BaumKnoten('Pfad', [], '/produkte/maus'),
        BaumKnoten('Query', [], 'farbe=rot&seite=2'),
        BaumKnoten('Fragment', [], 'details'),
      ]),
    ),
  ),
  vergleich(
    'n-wu-4',
    'wi-url',
    'Die Teile im Einzelnen',
    'Jeder Bestandteil hat eine eigene Aufgabe und ein eigenes Trennzeichen.',
    [
      ['Teil', 'Trenner', 'Aufgabe'],
      ['Schema', 'endet mit ://', 'Protokoll, z. B. https'],
      ['Host', '-', 'Server als Name oder IP-Adresse'],
      ['Port', 'beginnt mit :', 'Dienst auf dem Server'],
      ['Pfad', 'beginnt mit /', 'Ressource auf dem Server'],
      ['Query', 'beginnt mit ?', 'Parameter für den Server'],
      ['Fragment', 'beginnt mit #', 'Sprungmarke in der Seite'],
    ],
  ),
  vergleich(
    'n-wu-5',
    'wi-url',
    'Domainnamen von rechts lesen',
    'Ein Hostname ist hierarchisch aufgebaut. Die höchste Ebene steht ganz rechts, jede Ebene nach links ist eine Unterteilung.',
    [
      ['Ebene', 'Beispiel', 'vergeben von'],
      ['Top-Level-Domain', 'de, com, org', 'ICANN/IANA'],
      [
        'Second-Level-Domain',
        'example',
        'Registrierungsstelle, für .de die DENIC',
      ],
      ['Subdomain', 'shop, www', 'Inhaber der Domain selbst'],
    ],
    points: [
      'Der vollständige Name shop.example.com heißt FQDN (Fully Qualified Domain Name)',
    ],
  ),
  vergleich(
    'n-wu-6',
    'wi-url',
    'Standardports',
    'Fehlt der Port in der URL, nimmt der Browser den Standardport des Schemas. Nur abweichende Ports müssen angegeben werden.',
    [
      ['Schema', 'Standardport'],
      ['http', '80'],
      ['https', '443'],
      ['ftp', '21'],
    ],
    merksatz: 'https://example.com ist dasselbe wie https://example.com:443.',
  ),
  konzept(
    'n-wu-7',
    'wi-url',
    'Absolute und relative Adressen',
    'Innerhalb einer Website verweisen Links oft relativ. Der Browser ergänzt sie anhand der aktuellen Seite zur vollständigen URL. Beispiel: Die aktuelle Seite ist https://shop.example.com/hilfe/faq.html.',
    code:
        'https://shop.example.com/agb\n'
        '  -> absolut, vollständig\n'
        '/kontakt\n'
        '  -> ab Wurzel: .../kontakt\n'
        'versand.html\n'
        '  -> gleicher Ordner:\n'
        '     .../hilfe/versand.html\n'
        '../index.html\n'
        '  -> eine Ebene höher:\n'
        '     .../index.html',
  ),
  konzept(
    'n-wu-8',
    'wi-url',
    'Sonderzeichen in URLs',
    'In einer URL sind nur bestimmte Zeichen erlaubt. Leerzeichen, Umlaute und Zeichen mit Sonderbedeutung wie & werden prozentkodiert: ein % und der Bytewert in Hexadezimal.',
    points: [
      'Leerzeichen -> %20 (in Formularparametern auch +)',
      'ä -> %C3%A4: die zwei UTF-8-Bytes des Zeichens',
      '& im Wert selbst -> %26, damit es nicht als Trenner gilt',
      'Umlaut-Domains wie müller.de werden intern als xn--mller-kva.de übertragen (Punycode)',
    ],
  ),
  beispiel(
    'n-wu-9',
    'wi-url',
    'Durchgespielt: URL zerlegen',
    'Zerlege die URL https://www.azubi-portal.de/kurse/it?jahr=2025&ort=koeln#termine in ihre Bestandteile und nenne den verwendeten Port.',
    schritte: [
      'Bis :// lesen: Schema https',
      'Bis zum nächsten / (kein : davor): Host www.azubi-portal.de mit Subdomain www, Domain azubi-portal, TLD de',
      'Kein Port angegeben -> Standardport von https: 443',
      'Ab / bis ?: Pfad /kurse/it',
      'Ab ? bis #: Query jahr=2025&ort=koeln mit zwei Parametern',
      'Nach #: Fragment termine, bleibt im Browser',
    ],
    table: [
      ['Teil', 'Wert'],
      ['Schema', 'https'],
      ['Host', 'www.azubi-portal.de'],
      ['Port', '443 (Standard)'],
      ['Pfad', '/kurse/it'],
      ['Query', 'jahr=2025&ort=koeln'],
      ['Fragment', 'termine'],
    ],
    ergebnis:
        'Sechs Bestandteile, Port 443. An den Server gehen alle Teile außer dem Fragment.',
  ),
  falle(
    'n-wu-10',
    'wi-url',
    'Das Fragment bleibt im Browser',
    'Alles hinter # schickt der Browser nicht an den Server. Er springt damit nur zu einer Stelle der Seite. Wer Daten an den Server übergeben will, nutzt die Query hinter ?. Und: www ist keine Pflicht, sondern nur eine übliche Subdomain.',
  ),
  falle(
    'n-wu-11',
    'wi-url',
    'Die echte Domain steht rechts',
    'Phishing-Adressen nutzen aus, dass man von links liest: In https://bank.de.konto-check.example/login ist die echte Domain konto-check.example. „bank.de“ ist nur eine Subdomain davon. Maßgeblich ist, was direkt vor dem ersten einzelnen / steht, von rechts gelesen.',
  ),
  merke(
    'n-wu-12',
    'wi-url',
    'Die Reihenfolge',
    'Die Bestandteile stehen immer in derselben Reihenfolge. Pflicht sind nur Schema und Host, alles andere ist optional.',
    points: [
      'Port fehlt -> Standardport (http 80, https 443)',
      'Query geht an den Server, Fragment nicht',
      'Hostnamen von rechts lesen: TLD, Domain, Subdomain',
    ],
    satz: 'Schema :// Host : Port / Pfad ? Query # Fragment',
  ),

  // ============================================================ HTTP und HTTPS
  konzept(
    'n-wh-1',
    'wi-http',
    'Anfrage und Antwort',
    'HTTP (Hypertext Transfer Protocol) arbeitet nach dem Client-Server-Prinzip: Der Browser schickt einen Request mit Methode, Pfad und Headern. Der Server antwortet mit einer Response aus Statuscode, Headern und Inhalt, etwa dem HTML einer Seite.',
    points: [
      'HTTP ist ein Protokoll der Anwendungsschicht und nutzt TCP',
      'Jede Datei der Seite (HTML, CSS, Bild, Skript) wird einzeln angefragt',
    ],
  ),
  skizze(
    'n-wh-2',
    'wi-http',
    'Eine Seite, mehrere Anfragen',
    'Zuerst holt der Browser das HTML. Darin findet er Verweise auf weitere Dateien und fragt jede davon mit einem eigenen Request an.',
    SequenzDiagramm(
      ['Browser', 'Webserver'],
      [
        Nachricht(0, 1, 'GET /index.html'),
        Nachricht(1, 0, '200 OK + HTML', antwort: true),
        Nachricht(0, 1, 'GET /style.css'),
        Nachricht(1, 0, '200 OK + CSS', antwort: true),
        Nachricht(0, 1, 'GET /logo.png'),
        Nachricht(1, 0, '404 Not Found', antwort: true),
      ],
    ),
  ),
  konzept(
    'n-wh-3',
    'wi-http',
    'So sieht eine Nachricht aus',
    'Request und Response sind gleich gebaut: eine Startzeile, dann Header-Zeilen, eine Leerzeile und zuletzt der Inhalt (Body).',
    code:
        'GET /produkte?seite=2 HTTP/1.1\n'
        'Host: shop.example.com\n'
        'Accept: text/html\n'
        'Cookie: sid=4f9a\n'
        '\n'
        'HTTP/1.1 200 OK\n'
        'Content-Type: text/html\n'
        'Content-Length: 5120\n'
        '\n'
        '<!DOCTYPE html> ...',
    points: [
      'Request-Startzeile: Methode, Pfad mit Query, Version',
      'Response-Startzeile: Version, Statuscode, Text',
      'Header wie Host, Content-Type oder Cookie liefern Zusatzangaben',
      'HTTP/2 und HTTP/3 übertragen dieselben Inhalte binär und effizienter, HTTP/3 über QUIC auf UDP',
    ],
  ),
  vergleich(
    'n-wh-4',
    'wi-http',
    'Die wichtigsten Methoden',
    'Die Methode sagt dem Server, was mit der Ressource geschehen soll. Webschnittstellen (REST-APIs) nutzen sie genau so.',
    [
      ['Methode', 'Zweck', 'Beispiel'],
      ['GET', 'Ressource abrufen', 'Produktseite laden'],
      ['POST', 'Daten senden, Neues anlegen', 'Bestellung abschicken'],
      ['PUT', 'Ressource ersetzen oder anlegen', 'Kundendaten speichern'],
      ['PATCH', 'Ressource teilweise ändern', 'nur die E-Mail ändern'],
      ['DELETE', 'Ressource löschen', 'Adresse entfernen'],
    ],
  ),
  vergleich(
    'n-wh-5',
    'wi-http',
    'GET oder POST?',
    'Beide Methoden können Daten an den Server schicken, aber auf unterschiedlichem Weg.',
    [
      ['Merkmal', 'GET', 'POST'],
      ['Daten stehen', 'in der URL (Query)', 'im Body'],
      ['sichtbar in', 'Verlauf, Lesezeichen, Logs', 'nicht in der URL'],
      ['Datenmenge', 'begrenzt', 'auch große Dateien'],
      ['wiederholen', 'unbedenklich', 'legt evtl. doppelt an'],
      ['Einsatz', 'Suchen, Abrufen', 'Formulare, Login, Upload'],
    ],
  ),
  vergleich(
    'n-wh-6',
    'wi-http',
    'Statuscode-Klassen',
    'Der Statuscode ist dreistellig. Die erste Ziffer verrät, wie die Anfrage ausgegangen ist.',
    [
      ['Klasse', 'Bedeutung', 'Beispiele'],
      ['1xx', 'Information', '100 Continue'],
      ['2xx', 'Erfolg', '200, 201, 204'],
      ['3xx', 'Umleitung', '301, 302, 304'],
      ['4xx', 'Fehler beim Client', '400, 401, 403, 404'],
      ['5xx', 'Fehler beim Server', '500, 502, 503'],
    ],
  ),
  vergleich(
    'n-wh-7',
    'wi-http',
    'Die Codes im Alltag',
    'Diese Codes kommen im Support und in Prüfungen am häufigsten vor.',
    [
      ['Code', 'Bedeutung'],
      ['200 OK', 'Anfrage erfolgreich'],
      ['201 Created', 'neue Ressource angelegt, etwa nach POST'],
      [
        '301 Moved Permanently',
        'dauerhaft umgezogen, neue Adresse im Header Location',
      ],
      ['302 Found', 'vorübergehend woanders'],
      ['304 Not Modified', 'Kopie im Browser-Cache ist noch aktuell'],
      ['400 Bad Request', 'Anfrage fehlerhaft aufgebaut'],
      ['401 Unauthorized', 'nicht oder falsch angemeldet'],
      ['403 Forbidden', 'angemeldet, aber keine Berechtigung'],
      ['404 Not Found', 'Ressource gibt es nicht'],
      ['500 Internal Server Error', 'Fehler im Serverprogramm'],
      ['503 Service Unavailable', 'Server überlastet oder in Wartung'],
    ],
  ),
  beispiel(
    'n-wh-8',
    'wi-http',
    'Durchgespielt: ein Server-Log lesen',
    'Eine Kundin meldet Probleme im Webshop. Das Log des Webservers zeigt ihre letzten fünf Anfragen. Wo liegt jeweils das Problem?',
    table: [
      ['Anfrage', 'Code'],
      ['GET /login', '200'],
      ['POST /login', '401'],
      ['GET /admin', '403'],
      ['GET /bilder/logo.png', '404'],
      ['POST /bestellung', '500'],
    ],
    schritte: [
      '200: Die Login-Seite wurde korrekt ausgeliefert',
      '401: Anmeldung fehlgeschlagen, etwa ein falsches Passwort',
      '403: Sie ist nun bekannt, darf den Admin-Bereich aber nicht sehen, und das ist richtig so',
      '404: Das Logo fehlt auf dem Server oder der Pfad im HTML ist falsch',
      '500: Beim Anlegen der Bestellung ist das Serverprogramm abgestürzt',
    ],
    ergebnis:
        'Nur der 500er ist ein Fehler auf dem Server, der 404er ein Fehler der Website. 401 und 403 sind gewolltes Verhalten.',
  ),
  konzept(
    'n-wh-9',
    'wi-http',
    'Zustandslosigkeit und Cookies',
    'HTTP ist zustandslos: Jede Anfrage steht für sich, der Server erinnert sich nicht an die vorige. Damit Warenkorb oder Login erhalten bleiben, setzt der Server ein Cookie mit einer Sitzungs-ID, das der Browser bei jeder weiteren Anfrage mitschickt.',
    points: [
      'Server setzt: Set-Cookie: sid=4f9a',
      'Browser schickt bei jeder Anfrage: Cookie: sid=4f9a',
      'Der Server ordnet über die Sitzungs-ID Warenkorb und Login zu',
    ],
  ),
  vergleich(
    'n-wh-10',
    'wi-http',
    'HTTP und HTTPS',
    'HTTPS ist kein eigenes Protokoll, sondern HTTP über eine mit TLS verschlüsselte Verbindung.',
    [
      ['Merkmal', 'HTTP', 'HTTPS'],
      ['Standardport', '80', '443'],
      ['Verschlüsselung', 'keine', 'TLS'],
      ['Mitlesen im WLAN', 'möglich', 'nicht möglich'],
      ['Server-Identität', 'ungeprüft', 'per Zertifikat geprüft'],
      ['Browser zeigt', 'Warnung „nicht sicher“', 'Schloss-Symbol'],
    ],
    points: [
      'HTTPS sichert Vertraulichkeit (verschlüsselt), Integrität (unverändert) und Authentizität (echter Server)',
    ],
  ),
  konzept(
    'n-wh-11',
    'wi-http',
    'Was HTTPS verbirgt und was nicht',
    'Mit HTTPS sind Pfad, Query, Header, Cookies und Inhalt verschlüsselt. Sichtbar bleiben für Netzbetreiber aber die IP-Adresse des Servers, meist der Hostname und die Menge der übertragenen Daten.',
    points: [
      'Verschlüsselt: /konto?id=42, Passwörter, Formulardaten, Cookies',
      'Sichtbar: dass du mit shop.example.com sprichst, wann und wie viel',
    ],
  ),
  falle(
    'n-wh-12',
    'wi-http',
    '401 ist nicht 403',
    '401 Unauthorized heißt: nicht angemeldet oder Anmeldung fehlgeschlagen. 403 Forbidden heißt: Der Server weiß, wer anfragt, verweigert aber den Zugriff. Und eine falsch eingetippte Adresse ist ein Client-Fehler (404), kein Server-Fehler.',
  ),
  falle(
    'n-wh-13',
    'wi-http',
    'Schloss heißt nicht seriös',
    'Das Schloss zeigt nur, dass die Verbindung verschlüsselt ist und das Zertifikat zum Hostnamen passt. Auch Phishing-Seiten haben gültige Zertifikate, du sprichst dann eben verschlüsselt mit dem Betrüger. Ob die Seite vertrauenswürdig ist, sagt erst die Domain.',
  ),
  merke(
    'n-wh-14',
    'wi-http',
    'Das Wichtigste zu HTTP',
    'HTTP regelt, wie Browser und Server Anfragen und Antworten austauschen.',
    points: [
      'Request: Methode + Pfad + Header (+ Body)',
      'Response: Statuscode + Header + Body',
      'GET liest, POST sendet, PUT ersetzt, DELETE löscht',
      'HTTPS = HTTP über TLS, Port 443',
    ],
    satz:
        '2xx Erfolg, 3xx Umleitung, 4xx Fehler beim Client, 5xx Fehler beim Server.',
  ),

  // ============================================ Was beim Seitenaufruf passiert
  konzept(
    'n-wa-1',
    'wi-aufruf',
    'Viele Protokolle für eine Seite',
    'Zwischen der Eingabe der Adresse und der fertigen Seite arbeiten mehrere Protokolle zusammen: DNS findet die IP-Adresse, TCP baut eine zuverlässige Verbindung auf, TLS verschlüsselt sie, HTTP überträgt die Inhalte.',
  ),
  skizze(
    'n-wa-2',
    'wi-aufruf',
    'Wo die Protokolle arbeiten',
    'Im TCP/IP-Modell liegen HTTP und DNS in der Anwendungsschicht. TLS sitzt dazwischen: Es verschlüsselt, was HTTP an TCP übergibt.',
    StapelDiagramm([
      StapelEbene('Anwendung', 'HTTP, DNS'),
      StapelEbene('Verschlüsselung', 'TLS (bei HTTPS)'),
      StapelEbene('Transport', 'TCP, DNS meist UDP'),
      StapelEbene('Internet', 'IP'),
      StapelEbene('Netzzugang', 'Ethernet, WLAN'),
    ]),
  ),
  ablauf(
    'n-wa-3',
    'wi-aufruf',
    'Der Weg zur Seite',
    'Beispiel: Eine Kundin gibt https://shop.example.com in die Adresszeile ein. Das passiert bis zur fertigen Seite:',
    [
      'Browser zerlegt die URL: Schema https, Host shop.example.com, Port 443',
      'DNS-Auflösung: Der Hostname wird in eine IP-Adresse übersetzt',
      'Die Pakete gehen über das Standardgateway (Router) ins Internet',
      'TCP-Verbindung zum Server über den 3-Way-Handshake',
      'TLS-Handshake: Zertifikat prüfen, Sitzungsschlüssel aushandeln',
      'HTTP-Request: GET / an den Server',
      'HTTP-Response: Statuscode 200 und das HTML der Seite',
      'Browser rendert die Seite und lädt CSS, JavaScript und Bilder nach',
    ],
  ),
  skizze(
    'n-wa-4',
    'wi-aufruf',
    'Der Aufruf als Sequenzdiagramm',
    'Die Zeichnung zeigt dieselben Schritte als Nachrichten zwischen den Beteiligten, von oben nach unten in zeitlicher Reihenfolge.',
    SequenzDiagramm(
      ['Browser', 'DNS-Server', 'Webserver'],
      [
        Nachricht(0, 1, 'IP von shop.example.com?'),
        Nachricht(1, 0, '203.0.113.10', antwort: true),
        Nachricht(0, 2, 'TCP: SYN'),
        Nachricht(2, 0, 'TCP: SYN-ACK', antwort: true),
        Nachricht(0, 2, 'TCP: ACK'),
        Nachricht(0, 2, 'TLS: ClientHello'),
        Nachricht(2, 0, 'TLS: Zertifikat', antwort: true),
        Nachricht(0, 2, 'HTTP: GET /'),
        Nachricht(2, 0, 'HTTP: 200 OK + HTML', antwort: true),
      ],
    ),
  ),
  vergleich(
    'n-wa-5',
    'wi-aufruf',
    'Wo DNS zuerst sucht',
    'Bevor eine DNS-Anfrage ins Netz geht, prüft der Rechner seine Zwischenspeicher. Jeder Eintrag hat eine Gültigkeitsdauer (TTL).',
    [
      ['Stelle', 'Inhalt'],
      ['Browser-Cache', 'kürzlich aufgelöste Namen'],
      ['Betriebssystem', 'DNS-Cache und hosts-Datei'],
      ['DNS-Resolver', 'z. B. im Router oder beim Provider'],
    ],
  ),
  ablauf(
    'n-wa-6',
    'wi-aufruf',
    'Wenn kein Cache hilft',
    'Kennt der Resolver den Namen nicht, fragt er sich von oben durch die DNS-Hierarchie, von rechts nach links durch den Namen.',
    [
      'Resolver fragt einen Root-Server: Wer ist für .com zuständig?',
      'Root verweist auf die Nameserver der TLD .com',
      'TLD-Server verweist auf den zuständigen Nameserver von example.com',
      'Dieser (autoritative) Nameserver liefert die IP-Adresse von shop.example.com',
      'Der Resolver speichert die Antwort für die Dauer der TTL und gibt sie an den Client',
    ],
  ),
  ablauf(
    'n-wa-7',
    'wi-aufruf',
    'Der 3-Way-Handshake',
    'TCP stellt vor dem ersten Datenpaket sicher, dass beide Seiten bereit sind. Erst danach folgen TLS-Handshake und HTTP-Request.',
    [
      'Client -> Server: SYN (Verbindungswunsch)',
      'Server -> Client: SYN-ACK (Bestätigung und eigener Verbindungswunsch)',
      'Client -> Server: ACK (Bestätigung). Die Verbindung steht',
    ],
    skizze: SequenzDiagramm(
      ['Client', 'Server'],
      [
        Nachricht(0, 1, 'SYN'),
        Nachricht(1, 0, 'SYN-ACK', antwort: true),
        Nachricht(0, 1, 'ACK'),
      ],
    ),
  ),
  ablauf(
    'n-wa-8',
    'wi-aufruf',
    'Der TLS-Handshake, vereinfacht',
    'TLS verbindet asymmetrische und symmetrische Verschlüsselung (hybrides Verfahren): Mit dem Zertifikat wird der Server geprüft, dann einigen sich beide auf einen gemeinsamen Sitzungsschlüssel.',
    [
      'Client -> Server: ClientHello mit unterstützten Verfahren',
      'Server -> Client: gewähltes Verfahren und Zertifikat mit öffentlichem Schlüssel',
      'Client prüft das Zertifikat: vertrauenswürdige Zertifizierungsstelle, gültig, passt zum Hostnamen',
      'Schlüsselaustausch (z. B. Diffie-Hellman): Beide berechnen denselben Sitzungsschlüssel',
      'Ab jetzt: schnelle symmetrische Verschlüsselung, z. B. mit AES',
    ],
  ),
  konzept(
    'n-wa-9',
    'wi-aufruf',
    'Rendern: aus Text wird eine Seite',
    'Der Browser liest das HTML und baut daraus einen Baum aller Elemente, das DOM. Für jede verlinkte Datei stellt er eine eigene Anfrage, wendet das CSS an und führt JavaScript aus. Bereits geladene Dateien nimmt er, solange sie gültig sind, aus dem Cache.',
    points: [
      'HTML -> DOM (Struktur)',
      'CSS -> Aussehen jedes Elements',
      'JavaScript -> Verhalten, kann das DOM verändern',
    ],
  ),
  vergleich(
    'n-wa-13',
    'wi-aufruf',
    'Statische und dynamische Website',
    'Was der Server zwischen Anfrage und Antwort tut, hängt von der Art der Website ab. Eine statische Seite liegt fertig auf dem Server, eine dynamische wird bei jedem Aufruf neu zusammengebaut.',
    [
      ['Merkmal', 'statisch', 'dynamisch'],
      ['Entstehung', 'fertige Dateien', 'beim Aufruf vom Programm erzeugt'],
      ['Inhalt', 'für alle gleich', 'je nach Nutzer, Eingabe, Daten'],
      ['Pflege', 'Dateien bearbeiten', 'über CMS und Datenbank'],
      ['Beispiel', 'Visitenkarten-Seite', 'Webshop, Kundenportal'],
    ],
    merksatz:
        'Statisch: Der Server liefert aus. Dynamisch: Der Server rechnet erst und liefert dann aus.',
  ),
  ablauf(
    'n-wa-14',
    'wi-aufruf',
    'So entsteht eine dynamische Seite',
    'Bei einer dynamischen Website startet der Webserver nach dem HTTP-Request ein Programm. Erst dessen Ergebnis geht als Response an den Browser. Der Browser sieht nur fertiges HTML, nie das Programm selbst.',
    [
      'Browser sendet den Request, z. B. GET /angebote',
      'Webserver übergibt die Anfrage an ein serverseitiges Programm',
      'Programm liest die nötigen Daten aus der Datenbank',
      'Programm setzt die Daten in eine HTML-Vorlage ein',
      'Server schickt das fertige HTML als Response zurück',
    ],
    merksatz:
        'Ein CMS (Content-Management-System) ist ein fertiges Programm dieser Art. Damit pflegst du Inhalte, ohne zu programmieren.',
  ),
  konzept(
    'n-wa-15',
    'wi-aufruf',
    'Serverseitige und clientseitige Sprachen',
    'Dynamische Inhalte entstehen mit Programmiersprachen, die auf dem Server laufen. Im Browser laufen dagegen nur HTML, CSS und JavaScript. Die Prüfung fragt gern nach Beispielen für serverseitige Sprachen.',
    points: [
      'Serverseitig: PHP, Python, Java, C#, Ruby, JavaScript (Node.js)',
      'Clientseitig im Browser: JavaScript, dazu HTML und CSS',
      'HTML und CSS sind keine Programmiersprachen: sie beschreiben Struktur und Aussehen',
      'JavaScript kann beides: im Browser und mit Node.js auf dem Server',
    ],
  ),
  vergleich(
    'n-wa-10',
    'wi-aufruf',
    'Fehlerbild und Ursache',
    'Wer den Ablauf kennt, findet Fehler schnell: Die Meldung verrät, an welchem Schritt es hakt.',
    [
      ['Fehlerbild', 'betroffener Schritt'],
      ['„Server nicht gefunden“', 'DNS-Auflösung'],
      ['Zeitüberschreitung', 'Verbindung: Server aus, Firewall, Routing'],
      ['Zertifikatswarnung', 'TLS-Handshake'],
      ['Code 404', 'HTTP: Pfad falsch'],
      ['Code 500', 'HTTP: Fehler im Serverprogramm'],
      ['Seite ohne Layout', 'CSS-Datei nicht geladen'],
    ],
  ),
  falle(
    'n-wa-11',
    'wi-aufruf',
    'DNS liefert nur die Adresse',
    'DNS übersetzt den Namen in eine IP-Adresse. Die Seite selbst kommt danach per HTTP vom Webserver. Und TLS folgt auf die TCP-Verbindung, nicht umgekehrt: Ohne bestehende Verbindung kann nichts verschlüsselt ausgehandelt werden.',
  ),
  merke(
    'n-wa-12',
    'wi-aufruf',
    'Die Merkkette',
    'Eine Seite besteht meist aus vielen Dateien. Für jedes nachgeladene Bild und Skript stellt der Browser eine eigene HTTP-Anfrage.',
    satz:
        'Name -> IP (DNS) -> Verbindung (TCP) -> Verschlüsselung (TLS) -> Anfrage und Antwort (HTTP) -> Darstellung (Rendern).',
  ),

  // ============================================================== HTML und CSS
  vergleich(
    'n-wt-1',
    'wi-html',
    'Drei Sprachen, drei Aufgaben',
    'Eine Webseite trennt Inhalt, Aussehen und Verhalten. HTML und CSS sind keine Programmiersprachen, sondern eine Auszeichnungs- und eine Gestaltungssprache.',
    [
      ['Sprache', 'Aufgabe', 'Beispiel'],
      ['HTML', 'Struktur und Bedeutung', 'Überschrift, Absatz, Link'],
      ['CSS', 'Gestaltung', 'Farben, Schrift, Abstände'],
      ['JavaScript', 'Verhalten', 'Menü aufklappen, Inhalte nachladen'],
    ],
  ),
  konzept(
    'n-wt-2',
    'wi-html',
    'Das HTML-Grundgerüst',
    'Jede HTML-Seite hat denselben Rahmen. Der head enthält Angaben über die Seite, die nicht direkt sichtbar sind, der body den sichtbaren Inhalt.',
    code:
        '<!DOCTYPE html>\n'
        '<html lang="de">\n'
        '<head>\n'
        '  <meta charset="utf-8">\n'
        '  <title>Azubi-Shop</title>\n'
        '  <link rel="stylesheet"\n'
        '        href="style.css">\n'
        '</head>\n'
        '<body>\n'
        '  <h1>Willkommen</h1>\n'
        '  <p>Unser Angebot.</p>\n'
        '</body>\n'
        '</html>',
    points: [
      '<!DOCTYPE html>: Das Dokument ist HTML5',
      'lang="de": Sprache der Seite, wichtig für Screenreader',
      'meta charset: Zeichenkodierung, heute UTF-8',
      'title: Text im Browser-Tab und in Suchergebnissen',
    ],
  ),
  skizze(
    'n-wt-3',
    'wi-html',
    'Das DOM: HTML als Baum',
    'Weil Elemente ineinander verschachtelt sind, ergibt jede HTML-Seite einen Baum. Der Browser nennt ihn DOM (Document Object Model). CSS und JavaScript greifen über diesen Baum auf die Elemente zu.',
    BaumDiagramm(
      BaumKnoten('html', [
        BaumKnoten('head', [BaumKnoten('meta'), BaumKnoten('title')]),
        BaumKnoten('body', [
          BaumKnoten('header', [BaumKnoten('h1')]),
          BaumKnoten('main', [BaumKnoten('p'), BaumKnoten('img')]),
          BaumKnoten('footer'),
        ]),
      ]),
    ),
  ),
  formel(
    'n-wt-4',
    'wi-html',
    'Aufbau eines HTML-Elements',
    'Ein Element besteht meist aus Start-Tag, Inhalt und End-Tag. Attribute im Start-Tag liefern Zusatzangaben als name="wert".',
    '<a href="/kontakt">Kontakt</a>\n'
        '<img src="logo.png" alt="Logo">',
    points: [
      'a ist das Element (Link), href das Attribut, „Kontakt“ der Inhalt',
      'img hat kein End-Tag, es ist ein leeres Element',
      'Elemente werden sauber verschachtelt: was zuletzt geöffnet wurde, wird zuerst geschlossen',
    ],
  ),
  vergleich(
    'n-wt-5',
    'wi-html',
    'Die wichtigsten Tags',
    'Mit diesen Elementen lässt sich fast jede Seite aufbauen.',
    [
      ['Tag', 'Zweck'],
      ['<h1> bis <h6>', 'Überschriften, h1 nur einmal'],
      ['<p>', 'Absatz'],
      ['<a href>', 'Link'],
      ['<img src alt>', 'Bild mit Textalternative'],
      ['<ul>, <ol>, <li>', 'Aufzählung, nummerierte Liste, Eintrag'],
      ['<table>, <tr>, <th>, <td>', 'Tabelle, Zeile, Kopf-, Datenzelle'],
      ['<form>, <input>, <label>', 'Formular, Eingabefeld, Beschriftung'],
      ['<div>, <span>', 'neutrale Container ohne Bedeutung'],
    ],
  ),
  konzept(
    'n-wt-6',
    'wi-html',
    'Ein Formular',
    'Formulare schicken Eingaben an den Server. Das Attribut method bestimmt die HTTP-Methode, action das Ziel. Nur Felder mit name werden übertragen.',
    code:
        '<form action="/login"\n'
        '      method="post">\n'
        '  <label for="mail">E-Mail</label>\n'
        '  <input id="mail" name="mail"\n'
        '         type="email" required>\n'
        '  <button type="submit">\n'
        '    Anmelden</button>\n'
        '</form>',
    points: [
      'method="post": Daten im Body, nicht in der URL',
      'label for="mail" gehört zum Feld mit id="mail". Screenreader lesen die Beschriftung vor',
      'type="email" und required: Der Browser prüft die Eingabe vorab',
    ],
  ),
  vergleich(
    'n-wt-7',
    'wi-html',
    'Semantische Tags',
    'Semantische Tags sagen, welche Rolle ein Bereich hat. Das hilft Screenreadern und Suchmaschinen. div und span leisten das nicht.',
    [
      ['Tag', 'Bedeutung'],
      ['<header>', 'Kopfbereich'],
      ['<nav>', 'Navigation'],
      ['<main>', 'Hauptinhalt, einmal pro Seite'],
      ['<article>', 'eigenständiger Beitrag'],
      ['<section>', 'thematischer Abschnitt'],
      ['<footer>', 'Fußbereich'],
    ],
  ),
  formel(
    'n-wt-8',
    'wi-html',
    'Eine CSS-Regel',
    'Eine CSS-Regel besteht aus einem Selektor und Deklarationen aus Eigenschaft und Wert. Der Selektor legt fest, für welche Elemente die Regel gilt.',
    'h1 { color: navy; }\n'
        '.hinweis { font-size: 1.2rem; }\n'
        '#kopf { background: white; }',
    points: [
      'h1 wählt alle Überschriften erster Ordnung (Elementselektor)',
      '.hinweis wählt alle Elemente mit class="hinweis" (Klassenselektor)',
      '#kopf wählt das eine Element mit id="kopf" (ID-Selektor)',
      'Gelten mehrere Regeln, gewinnt die genauere: ID vor Klasse vor Element; bei Gleichstand die spätere',
    ],
  ),
  vergleich(
    'n-wt-9',
    'wi-html',
    'CSS einbinden',
    'CSS kann an drei Stellen stehen. Üblich ist eine externe Datei, weil sie für alle Seiten gilt und der Browser sie zwischenspeichert.',
    [
      ['Weg', 'Beispiel', 'Einsatz'],
      [
        'extern',
        '<link rel="stylesheet" href="style.css">',
        'Standard für ganze Website',
      ],
      ['intern', '<style> ... </style> im head', 'einzelne Seite'],
      ['inline', '<p style="color:red">', 'Ausnahme, schwer wartbar'],
    ],
  ),
  skizze(
    'n-wt-10',
    'wi-html',
    'Das Box-Modell',
    'Jedes Element ist für CSS ein Rechteck aus vier Schichten. Von außen nach innen: Außenabstand, Rahmen, Innenabstand, Inhalt.',
    StapelDiagramm(
      [
        StapelEbene('margin', 'Außenabstand zu Nachbarn'),
        StapelEbene('border', 'Rahmen'),
        StapelEbene('padding', 'Innenabstand zum Inhalt'),
        StapelEbene('content', 'Inhalt: Text, Bild'),
      ],
      oben: 'außen',
      unten: 'innen',
    ),
    points: [
      'Beispiel: p { margin: 16px; padding: 8px; border: 1px solid gray; }',
    ],
  ),
  konzept(
    'n-wt-11',
    'wi-html',
    'Responsive Design',
    'Eine responsive Seite passt ihr Layout an die Bildschirmbreite an. Media Queries legen CSS-Regeln fest, die nur unter Bedingungen gelten. Dazu kommen flexible Raster und mitwachsende Bilder.',
    code:
        '<meta name="viewport"\n'
        '  content="width=device-width,\n'
        '           initial-scale=1">\n'
        '\n'
        '@media (max-width: 600px) {\n'
        '  .spalte { width: 100%; }\n'
        '}',
    points: [
      'Viewport-Angabe im head: Das Handy zeigt die Seite in echter Breite statt verkleinert',
      'Die Regel in @media gilt nur bis 600 px Breite: Spalten stehen dann untereinander',
      'Mobile First: erst für kleine Bildschirme gestalten, dann erweitern',
    ],
  ),
  falle(
    'n-wt-12',
    'wi-html',
    'Klasse, ID und falsche Semantik',
    'Eine ID darf pro Seite nur einmal vorkommen, eine Klasse beliebig oft. Und Gestaltung gehört ins CSS: Wer einen Text nur wegen der großen Schrift als h1 auszeichnet oder Überschriftenebenen überspringt, verfälscht die Struktur. Screenreader lesen die Seite dann falsch gegliedert vor.',
  ),
  merke(
    'n-wt-13',
    'wi-html',
    'Das Wichtigste zu HTML und CSS',
    'Halte Struktur, Gestaltung und Verhalten sauber getrennt.',
    points: [
      'Grundgerüst: DOCTYPE, html, head, body',
      'Element = Start-Tag + Inhalt + End-Tag, Attribute als name="wert"',
      'CSS: Selektor { Eigenschaft: Wert; } - Element, .klasse, #id',
    ],
    satz:
        'HTML sagt, was etwas ist. CSS sagt, wie es aussieht. JavaScript sagt, was es tut.',
  ),

  // ========================================================== Barrierefreiheit
  konzept(
    'n-wf-1',
    'wi-barrierefrei',
    'Für wen Barrierefreiheit zählt',
    'Barrierefreie Webangebote sind für alle nutzbar, auch für Menschen mit Seh-, Hör-, motorischen oder kognitiven Einschränkungen und für ältere Menschen. Davon profitieren auch alle, die in greller Sonne oder mit einer Hand am Handy arbeiten.',
  ),
  vergleich(
    'n-wf-2',
    'wi-barrierefrei',
    'Einschränkung, Hilfsmittel, Maßnahme',
    'Wer weiß, wie Betroffene das Web nutzen, erkennt, worauf es bei der Gestaltung ankommt.',
    [
      ['Einschränkung', 'Hilfsmittel', 'Maßnahme'],
      [
        'blind',
        'Screenreader, Braillezeile',
        'Alt-Texte, saubere Überschriften',
      ],
      ['sehbehindert', 'Vergrößerung', 'Zoom bis 200 %, hoher Kontrast'],
      ['Farbsehschwäche', '-', 'Info nie nur über Farbe'],
      ['gehörlos', '-', 'Untertitel, Transkript'],
      [
        'motorisch',
        'Tastatur, Sprachsteuerung',
        'alles per Tastatur, große Klickflächen',
      ],
      ['kognitiv', '-', 'einfache Sprache, klare Struktur'],
    ],
  ),
  vergleich(
    'n-wf-3',
    'wi-barrierefrei',
    'Die vier WCAG-Prinzipien',
    'Die Web Content Accessibility Guidelines (WCAG) des W3C ordnen alle Anforderungen vier Prinzipien zu.',
    [
      ['Prinzip', 'Beispiel'],
      ['wahrnehmbar', 'Alt-Text für Bilder, Untertitel für Videos'],
      ['bedienbar', 'alles per Tastatur erreichbar, sichtbarer Fokus'],
      ['verständlich', 'klare Sprache, verständliche Fehlermeldungen'],
      ['robust', 'sauberes HTML, das Hilfsmittel auswerten können'],
    ],
  ),
  vergleich(
    'n-wf-4',
    'wi-barrierefrei',
    'Konformitätsstufen',
    'Jedes WCAG-Erfolgskriterium gehört zu einer von drei Stufen. Gesetzlich gefordert ist in der EU in der Regel Stufe AA.',
    [
      ['Stufe', 'Bedeutung'],
      ['A', 'Grundanforderungen, z. B. Alt-Texte'],
      [
        'AA',
        'Standard, z. B. Kontrast 4,5:1 (von BITV 2.0 und BFSG gefordert)',
      ],
      [
        'AAA',
        'höchste Stufe, z. B. Kontrast 7:1 (nicht für ganze Websites verlangt)',
      ],
    ],
  ),
  konzept(
    'n-wf-5',
    'wi-barrierefrei',
    'Alt-Texte richtig schreiben',
    'Der Alt-Text ersetzt das Bild für alle, die es nicht sehen. Er beschreibt Inhalt oder Zweck, nicht das Dateiformat.',
    code:
        '<img src="team.jpg"\n'
        '  alt="Support-Team am Empfang">\n'
        '\n'
        '<img src="linie.png" alt="">\n'
        '\n'
        '<a href="/"><img src="logo.svg"\n'
        '  alt="Startseite Azubi-Shop"></a>',
    points: [
      'Inhaltliches Bild: beschreiben, was wichtig ist',
      'Dekoratives Bild: alt="". Der Screenreader überspringt es',
      'Bild als Link: den Zweck nennen, nicht das Aussehen',
      'Vorrang hat semantisches HTML, ARIA-Attribute wie aria-label nur ergänzend',
    ],
  ),
  formel(
    'n-wf-6',
    'wi-barrierefrei',
    'Kontrast messen',
    'Das Kontrastverhältnis vergleicht die relative Helligkeit (Luminanz) von Text und Hintergrund. Es reicht von 1:1 (gleiche Farbe) bis 21:1 (Schwarz auf Weiß). Messen kannst du es mit einem Kontrast-Prüfwerkzeug.',
    'Kontrast = (L hell + 0,05)\n'
        '         / (L dunkel + 0,05)\n'
        '\n'
        'Schwarz auf Weiß:\n'
        '(1 + 0,05) / (0 + 0,05) = 21',
    table: [
      ['Text', 'WCAG AA'],
      ['normal', 'mind. 4,5:1'],
      ['groß (ab 18 pt, fett ab 14 pt)', 'mind. 3:1'],
      ['Bedienelemente, Grafiken', 'mind. 3:1'],
    ],
    points: [
      'Grau #767676 auf Weiß erreicht 4,54:1 und damit gerade noch AA',
      'Grau #777777 auf Weiß erreicht nur 4,48:1 und besteht damit nicht',
    ],
  ),
  ablauf(
    'n-wf-7',
    'wi-barrierefrei',
    'Eine Seite prüfen',
    'Viele Mängel findest du ohne Spezialwissen. Beispiel: Ein Azubi prüft das Kontaktformular des Webshops.',
    [
      'Nur mit der Tab-Taste bedienen: Erreicht man jedes Feld und den Senden-Button, ist der Fokus sichtbar?',
      'Bilder prüfen: Inhaltliche Bilder brauchen einen Alt-Text, dekorative ein leeres alt=""',
      'Kontrast messen: normaler Text mindestens 4,5:1',
      'Auf 200 % zoomen: Bleibt alles lesbar, ohne dass Inhalte abgeschnitten werden?',
      'Mit einem Screenreader testen: Sind Felder beschriftet, Überschriften sinnvoll gegliedert?',
      'Fehlermeldung prüfen: Steht dort in Worten, was falsch ist und wie es richtig geht?',
    ],
  ),
  beispiel(
    'n-wf-8',
    'wi-barrierefrei',
    'Durchgespielt: Mängel zuordnen',
    'Bei der Prüfung des Kontaktformulars findet der Azubi vier Mängel. Ordne jeden einem WCAG-Prinzip zu und nenne eine Abhilfe.',
    table: [
      ['Befund', 'Prinzip'],
      ['Pflichtfelder nur rot umrandet', 'wahrnehmbar'],
      ['Datumsauswahl nur per Maus', 'bedienbar'],
      ['Fehler: „Eingabe ungültig“', 'verständlich'],
      ['Felder ohne label-Element', 'robust'],
    ],
    schritte: [
      'Rote Umrandung: Farbe allein reicht nicht -> zusätzlich „Pflichtfeld“ oder * mit Erklärung',
      'Datumsauswahl: per Tastatur bedienbar machen oder Eingabe als Text erlauben',
      'Fehlermeldung: Feld und Lösung nennen, etwa „Bitte das Datum als TT.MM.JJJJ eingeben“',
      'label for=... ergänzen, damit Hilfsmittel jedes Feld eindeutig benennen können',
    ],
    ergebnis:
        'Je ein Mangel pro Prinzip. Alle vier lassen sich mit wenig Aufwand beheben.',
  ),
  vergleich(
    'n-wf-9',
    'wi-barrierefrei',
    'Die Rechtslage',
    'In Deutschland regeln zwei Vorschriften die digitale Barrierefreiheit. Kleinstunternehmen, die Dienstleistungen anbieten (unter 10 Beschäftigte und höchstens 2 Mio. € Jahresumsatz oder Bilanzsumme), sind vom BFSG ausgenommen.',
    [
      ['Vorschrift', 'gilt für'],
      [
        'BITV 2.0',
        'Websites und Apps öffentlicher Stellen des Bundes (die Länder haben eigene Regeln)',
      ],
      [
        'BFSG',
        'seit 28.06.2025 viele Produkte und Dienste privater Anbieter, z. B. Online-Shops, E-Book-Reader, Bankdienste',
      ],
    ],
    points: [
      'Öffentliche Stellen veröffentlichen eine Erklärung zur Barrierefreiheit mit Feedback-Möglichkeit',
    ],
  ),
  falle(
    'n-wf-10',
    'wi-barrierefrei',
    'Farbe allein reicht nicht',
    'Wer Pflichtfelder nur rot markiert oder Fehler nur mit einer roten Umrandung zeigt, schließt Menschen mit Farbsehschwäche aus. Die Information muss auch als Text oder Symbol erkennbar sein. Ebenso hilft ein Alt-Text wie „bild1.jpg“ niemandem.',
  ),
  falle(
    'n-wf-11',
    'wi-barrierefrei',
    'Platzhalter ist keine Beschriftung',
    'Ein grauer Platzhaltertext im Feld verschwindet beim Tippen, hat oft zu wenig Kontrast und wird nicht von jedem Screenreader vorgelesen. Jedes Feld braucht ein sichtbares label. Auch ein „Barrierefreiheits-Plugin“, das man nachträglich einbindet, ersetzt keine barrierefreie Umsetzung.',
  ),
  merke(
    'n-wf-12',
    'wi-barrierefrei',
    'Das Wichtigste zur Barrierefreiheit',
    'Barrierefreiheit ist Pflicht für öffentliche Stellen und viele Unternehmen und nützt allen Nutzern.',
    points: [
      'Alt-Texte, Untertitel, Tastaturbedienung, Kontrast 4,5:1',
      'Information nie nur über Farbe',
      'BITV 2.0: öffentliche Stellen, BFSG: private Anbieter seit 28.06.2025',
    ],
    satz: 'WCAG: wahrnehmbar, bedienbar, verständlich, robust.',
  ),

  // ============================================================= Zahlensysteme
  vergleich(
    'n-mz-1',
    'md-zahlensysteme',
    'Vier Zahlensysteme',
    'Computer rechnen binär, Menschen dezimal. Hexadezimal und oktal sind Kurzschreibweisen für lange Binärzahlen. Jedes System hat eine Basis und so viele Ziffern, wie die Basis angibt.',
    [
      ['System', 'Basis', 'Ziffern'],
      ['Dezimal', '10', '0-9'],
      ['Binär (Dual)', '2', '0 und 1'],
      ['Oktal', '8', '0-7'],
      ['Hexadezimal', '16', '0-9, A-F (A = 10 ... F = 15)'],
    ],
    points: [
      'Kennzeichnung binär: 1011₂ oder 0b1011',
      'Kennzeichnung hex: 9C₁₆, 0x9C oder 9Ch',
      'Ohne Kennzeichnung ist „10“ mehrdeutig: zehn, zwei, acht oder sechzehn',
    ],
  ),
  formel(
    'n-mz-2',
    'md-zahlensysteme',
    'Das Stellenwertprinzip',
    'In jedem Stellenwertsystem zählt eine Ziffer so viel, wie ihre Stelle wert ist. Die Stellenwerte sind Potenzen der Basis, von rechts mit Basis hoch 0 beginnend.',
    'Wert = Ziffer × Basis^Stelle\n'
        '\n'
        '305 = 3×10^2 + 0×10^1 + 5×10^0\n'
        '    = 300 + 0 + 5',
    table: [
      ['Stelle', 'Basis 2', 'Basis 8', 'Basis 16'],
      ['0', '1', '1', '1'],
      ['1', '2', '8', '16'],
      ['2', '4', '64', '256'],
      ['3', '8', '512', '4.096'],
      ['4', '16', '4.096', '65.536'],
    ],
  ),
  beispiel(
    'n-mz-3',
    'md-zahlensysteme',
    'Binär -> dezimal',
    'Wandle die Binärzahl 1011 0110 in eine Dezimalzahl um.',
    code:
        '128  64  32  16   8   4   2   1\n'
        '  1   0   1   1   0   1   1   0',
    schritte: [
      'Stellenwerte über die Bits schreiben: rechts mit 1 beginnen, nach links verdoppeln',
      'Nur die Stellen mit einer 1 zählen: 128, 32, 16, 4 und 2',
      'Addieren: 128 + 32 + 16 + 4 + 2 = 182',
    ],
    ergebnis: '1011 0110 (binär) = 182 (dezimal)',
  ),
  beispiel(
    'n-mz-4',
    'md-zahlensysteme',
    'Dezimal -> binär: Divisionsrest',
    'Wandle 156 in eine Binärzahl um. Dazu teilst du die Zahl so lange durch 2, bis 0 herauskommt.',
    code:
        '156 : 2 = 78  Rest 0\n'
        ' 78 : 2 = 39  Rest 0\n'
        ' 39 : 2 = 19  Rest 1\n'
        ' 19 : 2 =  9  Rest 1\n'
        '  9 : 2 =  4  Rest 1\n'
        '  4 : 2 =  2  Rest 0\n'
        '  2 : 2 =  1  Rest 0\n'
        '  1 : 2 =  0  Rest 1',
    schritte: [
      'Teilen und jeden Rest notieren, bis das Ergebnis 0 ist',
      'Die Reste von unten nach oben lesen: 1001 1100',
      'Probe: 128 + 16 + 8 + 4 = 156',
    ],
    ergebnis: '156 (dezimal) = 1001 1100 (binär)',
  ),
  beispiel(
    'n-mz-5',
    'md-zahlensysteme',
    'Dezimal -> binär: Stellenwerte abziehen',
    'Wandle 200 in eine Binärzahl um, diesmal ohne Division. Du prüfst von links, ob der Stellenwert noch hineinpasst.',
    schritte: [
      '128 passt in 200 -> Bit 1, Rest 200 - 128 = 72',
      '64 passt in 72 -> Bit 1, Rest 72 - 64 = 8',
      '32 und 16 passen nicht in 8 -> Bits 0 und 0',
      '8 passt in 8 -> Bit 1, Rest 0',
      '4, 2 und 1 -> Bits 0, 0, 0',
    ],
    ergebnis: '200 (dezimal) = 1100 1000 (binär)',
    skizze: BitDiagramm([BitZeile('200', '1100 1000')]),
  ),
  vergleich(
    'n-mz-6',
    'md-zahlensysteme',
    'Die ersten 16 Zahlen',
    'Diese Tabelle solltest du sicher können. Jede Hex-Ziffer steht für genau vier Bit.',
    [
      ['Dezimal', 'Binär', 'Hex'],
      ['0', '0000', '0'],
      ['1', '0001', '1'],
      ['2', '0010', '2'],
      ['3', '0011', '3'],
      ['4', '0100', '4'],
      ['5', '0101', '5'],
      ['6', '0110', '6'],
      ['7', '0111', '7'],
      ['8', '1000', '8'],
      ['9', '1001', '9'],
      ['10', '1010', 'A'],
      ['11', '1011', 'B'],
      ['12', '1100', 'C'],
      ['13', '1101', 'D'],
      ['14', '1110', 'E'],
      ['15', '1111', 'F'],
    ],
  ),
  beispiel(
    'n-mz-7',
    'md-zahlensysteme',
    'Binär <-> hex mit dem Nibble-Trick',
    'Wandle 1001 1100 in Hexadezimal um und 3F zurück in binär. Vier Bit (ein Nibble) ergeben genau eine Hex-Ziffer.',
    schritte: [
      'Binärzahl von rechts in Vierergruppen teilen: 1001 | 1100',
      'Jede Gruppe einzeln übersetzen: 1001 = 9, 1100 = 12 = C -> 9C',
      'Rückweg: jede Hex-Ziffer in vier Bit: 3 = 0011, F = 1111 -> 0011 1111',
      'Probe über dezimal: 9C = 9 × 16 + 12 = 156, 3F = 3 × 16 + 15 = 63',
    ],
    ergebnis: '1001 1100 = 9C (hex) und 3F (hex) = 0011 1111',
    skizze: BitDiagramm([
      BitZeile('9C = 156', '1001 1100'),
      BitZeile('3F = 63', '0011 1111'),
    ]),
  ),
  beispiel(
    'n-mz-8',
    'md-zahlensysteme',
    'Hex <-> dezimal',
    'Wandle 2F3 (hex) in eine Dezimalzahl um und rechne zur Probe zurück.',
    code:
        '755 : 16 = 47  Rest 3\n'
        ' 47 : 16 =  2  Rest 15 = F\n'
        '  2 : 16 =  0  Rest 2\n'
        '-> von unten gelesen: 2F3',
    schritte: [
      'Stellenwerte von rechts: 1, 16, 256',
      'F = 15 einsetzen: 2 × 256 + 15 × 16 + 3 × 1',
      '512 + 240 + 3 = 755',
      'Probe mit dem Divisionsrestverfahren durch 16 (Kasten): Reste 3, F, 2 von unten gelesen = 2F3',
    ],
    ergebnis: '2F3 (hex) = 755 (dezimal)',
  ),
  beispiel(
    'n-mz-9',
    'md-zahlensysteme',
    'Oktal',
    'Wandle 157 (oktal) in dezimal und binär um. Im Oktalsystem ergeben je drei Bit eine Ziffer.',
    schritte: [
      'Stellenwerte 64, 8, 1: 1 × 64 + 5 × 8 + 7 × 1 = 64 + 40 + 7 = 111',
      'Binär: jede Ziffer in drei Bit: 1 = 001, 5 = 101, 7 = 111',
      'Zusammen: 001 101 111 = 110 1111',
      'Probe: 64 + 32 + 8 + 4 + 2 + 1 = 111',
    ],
    ergebnis: '157 (oktal) = 111 (dezimal) = 110 1111 (binär)',
    merksatz:
        'Anwendung: Linux-Dateirechte. 754 = 111 101 100 = rwx r-x r-- für Besitzer, Gruppe, andere.',
  ),
  konzept(
    'n-mz-10',
    'md-zahlensysteme',
    'Wie viele Werte passen in n Bit?',
    'Mit n Bit lassen sich 2^n verschiedene Werte darstellen, ohne Vorzeichen von 0 bis 2^n - 1. Umgekehrt: Wer 1.000 Werte braucht, benötigt 10 Bit, denn 2^10 = 1.024 reicht, 2^9 = 512 nicht.',
    table: [
      ['Bit', 'Werte', 'Beispiel'],
      ['4', '16', 'eine Hex-Ziffer'],
      ['8', '256 (0-255)', 'ein Byte, IPv4-Oktett'],
      ['16', '65.536', 'Portnummern'],
      ['24', '16.777.216', 'True-Color-Farben'],
      ['32', '4.294.967.296', 'IPv4-Adressen'],
    ],
  ),
  konzept(
    'n-mz-11',
    'md-zahlensysteme',
    'Negative Zahlen: Zweierkomplement',
    'Für negative Zahlen nutzen Computer das Zweierkomplement. Das höchste Bit zählt dabei negativ: Bei 8 Bit hat es den Wert -128. Eine 1 ganz links heißt also: Die Zahl ist negativ.',
    points: [
      'Wertebereich mit 8 Bit: -128 bis +127',
      'Vorteil: Subtrahieren wird zum Addieren einer negativen Zahl',
      'Bilden: Betrag binär schreiben, alle Bits umkehren, 1 addieren',
    ],
  ),
  beispiel(
    'n-mz-12',
    'md-zahlensysteme',
    'Durchgerechnet: -45 in 8 Bit',
    'Stelle -45 im 8-Bit-Zweierkomplement dar.',
    schritte: [
      'Betrag binär: 45 = 32 + 8 + 4 + 1 = 0010 1101',
      'Alle Bits umkehren (Einerkomplement): 1101 0010',
      '1 addieren: 1101 0010 + 1 = 1101 0011',
      'Probe: -128 + 64 + 16 + 2 + 1 = -45',
    ],
    ergebnis: '-45 = 1101 0011 (8-Bit-Zweierkomplement)',
    skizze: BitDiagramm([
      BitZeile('+45', '0010 1101'),
      BitZeile('umgekehrt', '1101 0010'),
      BitZeile('+1 = -45', '1101 0011'),
    ]),
  ),
  beispiel(
    'n-mz-13',
    'md-zahlensysteme',
    'Binär addieren und subtrahieren',
    'Berechne 90 + 55 und 90 - 55 im Binärsystem mit 8 Bit.',
    code:
        '  0101 1010   (90)\n'
        '+ 0011 0111   (55)\n'
        '= 1001 0001  (145)',
    schritte: [
      'Regeln: 0 + 0 = 0, 0 + 1 = 1, 1 + 1 = 0 mit Übertrag 1, 1 + 1 + 1 = 1 mit Übertrag 1',
      'Stellenweise von rechts addieren (Kasten): Ergebnis 1001 0001 = 128 + 16 + 1 = 145',
      'Für 90 - 55 wird -55 addiert: 55 = 0011 0111, umkehren 1100 1000, + 1 = 1100 1001',
      '0101 1010 + 1100 1001 = 1 0010 0011. Der Übertrag ins 9. Bit fällt weg',
      '0010 0011 = 32 + 2 + 1 = 35',
    ],
    ergebnis: '90 + 55 = 1001 0001 (145), 90 - 55 = 0010 0011 (35)',
  ),
  falle(
    'n-mz-14',
    'md-zahlensysteme',
    'Rückwärts gelesen und falsch gedeutet',
    'Beim Divisionsrestverfahren liest man die Reste von unten nach oben. Wer von oben liest, erhält die Zahl spiegelverkehrt: 0011 1001 statt 1001 1100. Hex-Buchstaben sind Ziffern: B steht für 11. Und ob 1101 0011 die Zahl 211 oder -45 ist, entscheidet allein, ob mit oder ohne Vorzeichen gerechnet wird.',
  ),
  merke(
    'n-mz-15',
    'md-zahlensysteme',
    'Das Wichtigste zu Zahlensystemen',
    'Mit Stellenwerten, Division und Nibble-Trick löst du jede Umrechnung.',
    points: [
      'Nach dezimal: Ziffer × Stellenwert, dann addieren',
      'Von dezimal: durch die Basis teilen, Reste von unten lesen',
      'Binär <-> hex: 4 Bit = 1 Ziffer, binär <-> oktal: 3 Bit = 1 Ziffer',
      'Zweierkomplement: umkehren, + 1',
    ],
    satz: '1 Byte = 8 Bit = 2 Hex-Ziffern: Werte von 0 bis 255 bzw. 00 bis FF.',
  ),

  // ============================================================= Zeichensätze
  konzept(
    'n-mc-1',
    'md-zeichen',
    'Zeichen sind Zahlen',
    'Ein Computer speichert Buchstaben als Zahlen. Ein Zeichensatz legt fest, welche Zahl für welches Zeichen steht, eine Kodierung, wie diese Zahl als Bytes gespeichert wird. Beispiel: „A“ hat den Wert 65 (hex 41).',
  ),
  vergleich(
    'n-mc-2',
    'md-zeichen',
    'Von ASCII zu Unicode',
    'Jeder neue Zeichensatz löste das Platzproblem des vorigen.',
    [
      ['Zeichensatz', 'Umfang', 'Inhalt'],
      [
        'ASCII',
        '7 Bit, 128 Zeichen',
        'englische Buchstaben, Ziffern, Steuerzeichen',
      ],
      [
        'Latin-1 (ISO 8859-1)',
        '8 Bit, 256 Zeichen',
        'westeuropäisch, mit ä, ö, ü, ß, aber ohne €',
      ],
      [
        'Unicode',
        'über 1,1 Mio. Codepoints',
        'alle Schriften, Symbole, Emojis',
      ],
    ],
  ),
  vergleich(
    'n-mc-3',
    'md-zeichen',
    'Die ASCII-Tabelle im Überblick',
    'Die Zeichen sind in Blöcken sortiert. Wer die Anfänge kennt, kann jeden Code herleiten.',
    [
      ['Bereich', 'dezimal', 'hex'],
      ['Steuerzeichen', '0-31, 127', '00-1F, 7F'],
      ['Leerzeichen', '32', '20'],
      ['Ziffern 0-9', '48-57', '30-39'],
      ['A-Z', '65-90', '41-5A'],
      ['a-z', '97-122', '61-7A'],
    ],
    points: [
      'Kleinbuchstabe = Großbuchstabe + 32: a = 97',
      'Die Ziffer „7“ hat den Code 55, nicht 7',
      'Zeilenumbruch (LF) = 10, Tabulator = 9',
    ],
  ),
  beispiel(
    'n-mc-4',
    'md-zeichen',
    'Durchgerechnet: „IHK“ in ASCII',
    'Kodiere das Wort „IHK“ in ASCII: dezimal, hexadezimal und binär.',
    schritte: [
      'Von A = 65 aus zählen: H = 72, I = 73, K = 75',
      'In hex: 73 = 4 × 16 + 9 = 49, 72 = 48, 75 = 4 × 16 + 11 = 4B',
      'In binär je Hex-Ziffer vier Bit: 4 = 0100, 9 = 1001, 8 = 1000, B = 1011',
      'Jedes Zeichen belegt ein Byte, das Wort also 3 Byte',
    ],
    ergebnis: 'I = 73 = 49h, H = 72 = 48h, K = 75 = 4Bh, zusammen 3 Byte',
    skizze: BitDiagramm([
      BitZeile('I', '0100 1001'),
      BitZeile('H', '0100 1000'),
      BitZeile('K', '0100 1011'),
    ]),
  ),
  konzept(
    'n-mc-5',
    'md-zeichen',
    'Unicode: ein Code für jedes Zeichen',
    'Unicode vergibt jedem Zeichen aller Schriften eine eindeutige Nummer, den Codepoint. Er wird als U+ mit mindestens vier Hex-Ziffern geschrieben. Platz ist für 1.114.112 Codepoints (U+0000 bis U+10FFFF), über 150.000 sind vergeben.',
    points: [
      'A = U+0041, ä = U+00E4, € = U+20AC',
      'Die ersten 128 Codepoints sind identisch mit ASCII',
      'Unicode ist der Zeichensatz. Wie er in Bytes gespeichert wird, regeln Kodierungen: UTF-8, UTF-16, UTF-32',
    ],
  ),
  vergleich(
    'n-mc-6',
    'md-zeichen',
    'UTF-8: 1 bis 4 Byte',
    'UTF-8 speichert jeden Codepoint mit so wenigen Bytes wie nötig. Die Byteanzahl hängt vom Bereich ab, in dem der Codepoint liegt.',
    [
      ['Codepoint', 'Byte', 'Beispiele'],
      ['U+0000 bis U+007F', '1', 'A, 7, ?'],
      ['U+0080 bis U+07FF', '2', 'ä, ö, ü, ß, é'],
      ['U+0800 bis U+FFFF', '3', '€, chinesische Zeichen'],
      ['ab U+10000', '4', 'Emojis'],
    ],
  ),
  skizze(
    'n-mc-7',
    'md-zeichen',
    'So sehen die Bytes aus',
    'Am Anfang jedes Bytes steht, wie es zu lesen ist. So erkennt ein Programm auch mitten im Text, wo ein Zeichen beginnt.',
    BitDiagramm(
      [
        BitZeile('A (1 Byte)', '01000001'),
        BitZeile('ä (2 Byte)', '11000011 10100100'),
        BitZeile('€ (3 Byte)', '11100010 10000010 10101100'),
      ],
      legende:
          'Startbyte 0... = 1 Byte, 110... = 2 Byte, 1110... = 3 Byte, 11110... = 4 Byte. Folgebytes beginnen mit 10.',
    ),
    points: [
      'A = 41h, ä = C3 A4, € = E2 82 AC',
      'Die übrigen Bits ergeben zusammen den Codepoint: bei ä 000 1110 0100 = E4',
    ],
  ),
  beispiel(
    'n-mc-8',
    'md-zeichen',
    'Durchgerechnet: Bytes zählen',
    'Wie viele Byte belegen „Grüße“ und „Preis: 5 €“ in UTF-8? Zähle jedes Zeichen einzeln, auch Leerzeichen und Satzzeichen.',
    code:
        'G  r  ü  ß  e\n'
        '1 +1 +2 +2 +1 = 7 Byte',
    schritte: [
      '„Grüße“: G, r, e je 1 Byte, ü und ß je 2 Byte -> 3 + 4 = 7 Byte',
      '„Preis: 5 €“ hat 10 Zeichen: P, r, e, i, s, Doppelpunkt, Leerzeichen, 5, Leerzeichen sind 9 ASCII-Zeichen = 9 Byte',
      'Das €-Zeichen braucht 3 Byte -> 9 + 3 = 12 Byte',
      'Zum Vergleich in Latin-1: „Grüße“ = 5 Byte, in UTF-16 = 10 Byte',
    ],
    ergebnis: '„Grüße“ = 7 Byte, „Preis: 5 €“ = 12 Byte in UTF-8',
  ),
  vergleich(
    'n-mc-9',
    'md-zeichen',
    'UTF-8, UTF-16, UTF-32',
    'Alle drei kodieren dieselben Unicode-Zeichen, aber unterschiedlich platzsparend.',
    [
      ['Kodierung', 'Byte je Zeichen', 'ASCII-kompatibel'],
      ['UTF-8', '1 bis 4', 'ja'],
      ['UTF-16', '2 oder 4', 'nein'],
      ['UTF-32', 'immer 4', 'nein'],
    ],
    points: [
      'UTF-8 ist Standard im Web, in E-Mails und Dateien',
      'UTF-16 nutzen Windows, Java und JavaScript intern',
    ],
  ),
  konzept(
    'n-mc-10',
    'md-zeichen',
    'Die Kodierung angeben',
    'Einer Bytefolge sieht man nicht an, wie sie kodiert ist. Deshalb liefert man die Kodierung mit, und zwar in der Datei, im HTTP-Header oder in der Datenbank.',
    code:
        '<meta charset="utf-8">\n'
        '\n'
        'Content-Type: text/html;\n'
        '  charset=utf-8',
    points: [
      'Im HTML-Kopf: meta charset',
      'Im HTTP-Header: Content-Type mit charset',
      'Optional am Dateianfang: Byte Order Mark (BOM), bei UTF-8 EF BB BF',
    ],
  ),
  falle(
    'n-mc-11',
    'md-zeichen',
    'Mojibake',
    'Wird UTF-8-Text als Latin-1 gelesen, erscheinen aus einem Umlaut zwei fremde Zeichen: Aus „Müller“ wird „MÃ¼ller“, weil die zwei Bytes C3 BC einzeln gedeutet werden. Die Daten sind nicht kaputt, nur falsch interpretiert. Abhilfe schaffst du, indem du überall dieselbe Kodierung festlegst, z. B. UTF-8 in Datenbank, Datei und HTML-Kopf.',
  ),
  falle(
    'n-mc-12',
    'md-zeichen',
    'Zeichen sind nicht gleich Byte',
    'Ein Feld mit 10 Byte Platz fasst in UTF-8 zehn ASCII-Zeichen, aber nur fünf Umlaute. Ähnlich bei der SMS: Mit dem GSM-Zeichensatz passen 160 Zeichen hinein. Ein einziges Emoji schaltet auf UCS-2 um, dann sind es nur noch 70.',
  ),
  merke(
    'n-mc-13',
    'md-zeichen',
    'Das Wichtigste zu Zeichensätzen',
    'Zeichensatz = welche Nummer, Kodierung = welche Bytes.',
    points: [
      'ASCII: 7 Bit, 128 Zeichen, A = 65, a = 97, 0 = 48',
      'Unicode: Codepoints U+0000 bis U+10FFFF',
      'UTF-8: 1 Byte für ASCII, 2 für Umlaute, 3 für €, 4 für Emojis',
    ],
    satz:
        'ASCII: 7 Bit. UTF-8: 1 bis 4 Byte, ASCII-kompatibel, Umlaute brauchen 2 Byte.',
  ),

  // ======================================================= Datenmengen berechnen
  konzept(
    'n-md-1',
    'md-datenmengen',
    'Bit und Byte',
    'Ein Bit ist die kleinste Informationseinheit: 0 oder 1. Acht Bit ergeben ein Byte. Speicher und Dateigrößen werden in Byte angegeben, Datenraten in Bit pro Sekunde.',
    points: [
      '1 Byte = 8 Bit, 4 Bit = 1 Nibble',
      'Abkürzung: b oder bit für Bit, B für Byte. 1 MB ist das Achtfache von 1 Mbit',
      'n Bit können 2^n Zustände annehmen',
    ],
  ),
  vergleich(
    'n-md-2',
    'md-datenmengen',
    'Dezimale und binäre Präfixe',
    'Hersteller von Festplatten und Netztechnik rechnen dezimal in Tausenderschritten. Betriebssysteme rechnen oft binär in 1.024er-Schritten. Windows schreibt dann trotzdem „GB“.',
    [
      ['Dezimal (SI)', 'Binär (IEC)'],
      ['1 kB = 1.000 Byte', '1 KiB = 1.024 Byte'],
      ['1 MB = 1.000² Byte', '1 MiB = 1.024² = 1.048.576 Byte'],
      ['1 GB = 1.000³ Byte', '1 GiB = 1.024³ = 1.073.741.824 Byte'],
      ['1 TB = 1.000⁴ Byte', '1 TiB = 1.024⁴ = 1.099.511.627.776 Byte'],
    ],
    points: [
      'Kilo mit kleinem k (kB), Kibi mit großem K (KiB)',
      'Je größer die Einheit, desto größer der Unterschied: 2,4 % bei KiB, rund 10 % bei TiB',
    ],
  ),
  formel(
    'n-md-3',
    'md-datenmengen',
    'Einheiten umrechnen',
    'Zur größeren Einheit teilst du, zur kleineren nimmst du mal. Bit und Byte trennt immer der Faktor 8.',
    'Bit  -> Byte : / 8\n'
        'Byte -> kB   : / 1.000\n'
        'kB   -> MB   : / 1.000\n'
        'Byte -> KiB  : / 1.024\n'
        'KiB  -> MiB  : / 1.024\n'
        '\n'
        'MB  -> Byte  : × 1.000.000\n'
        'MiB -> Byte  : × 1.048.576',
  ),
  beispiel(
    'n-md-4',
    'md-datenmengen',
    'Warum die Festplatte „kleiner“ ist',
    'Eine Festplatte hat laut Verpackung 2 TB. Windows zeigt „1,81 TB“ an. Rechne nach, wie viele TiB 2 TB sind.',
    schritte: [
      '2 TB in Byte: 2 × 1.000⁴ = 2.000.000.000.000 Byte',
      '1 TiB in Byte: 1.024⁴ = 1.099.511.627.776 Byte',
      'Teilen: 2.000.000.000.000 / 1.099.511.627.776 ≈ 1,819',
      'Windows rechnet binär, schreibt aber „TB“ und zeigt nur zwei Nachkommastellen: 1,81',
    ],
    ergebnis:
        '2 TB ≈ 1,82 TiB. Es fehlt kein Speicher, nur die Einheit ist eine andere.',
  ),
  formel(
    'n-md-5',
    'md-datenmengen',
    'Speicherbedarf eines Bildes',
    'Ein unkomprimiertes Rasterbild speichert für jedes Pixel so viele Bit, wie die Farbtiefe angibt.',
    'Bit  = Breite × Höhe × Farbtiefe\n'
        'Byte = Bit / 8',
    table: [
      ['Farbtiefe', 'Farben', 'Einsatz'],
      ['1 Bit', '2', 'Schwarzweiß'],
      ['8 Bit', '256', 'Graustufen, GIF'],
      ['16 Bit', '65.536', 'High Color'],
      ['24 Bit', '16.777.216', 'True Color: RGB je 8 Bit'],
      ['32 Bit', '16.777.216', 'True Color + 8 Bit Transparenz'],
    ],
  ),
  beispiel(
    'n-md-6',
    'md-datenmengen',
    'Durchgerechnet: ein Full-HD-Bild',
    'Wie groß ist ein unkomprimiertes Bild mit 1920 × 1080 Pixeln und 24 Bit Farbtiefe, in MB und in MiB?',
    schritte: [
      'Pixel: 1920 × 1080 = 2.073.600',
      'Bit: 2.073.600 × 24 = 49.766.400 Bit',
      'Byte: 49.766.400 / 8 = 6.220.800 Byte (kürzer: 24 Bit = 3 Byte je Pixel)',
      'MB: 6.220.800 / 1.000.000 ≈ 6,22 MB',
      'MiB: 6.220.800 / 1.048.576 ≈ 5,93 MiB',
    ],
    ergebnis: '6.220.800 Byte ≈ 6,22 MB ≈ 5,93 MiB',
  ),
  beispiel(
    'n-md-7',
    'md-datenmengen',
    'Durchgerechnet: Scan mit dpi',
    'Ein Foto im Format 4 × 6 Zoll wird mit 300 dpi (Punkte pro Zoll) und 24 Bit Farbtiefe gescannt. Wie groß ist die Datei unkomprimiert in MB?',
    schritte: [
      'Breite in Pixeln: 4 Zoll × 300 dpi = 1.200 Pixel',
      'Höhe in Pixeln: 6 Zoll × 300 dpi = 1.800 Pixel',
      'Pixel: 1.200 × 1.800 = 2.160.000',
      'Byte: 2.160.000 × 3 Byte = 6.480.000 Byte',
      'MB: 6.480.000 / 1.000.000 = 6,48 MB',
    ],
    ergebnis: '6,48 MB',
    merksatz:
        '1 Zoll = 2,54 cm. Sind Maße in cm angegeben, erst in Zoll umrechnen.',
  ),
  beispiel(
    'n-md-8',
    'md-datenmengen',
    'Durchgerechnet: Audio',
    'Wie groß ist eine Minute Musik in CD-Qualität (44,1 kHz, 16 Bit, Stereo), unkomprimiert? Bei Audio wird das Signal viele Male pro Sekunde abgetastet, und jeder Messwert hat eine feste Bittiefe.',
    code:
        'Bit = Abtastrate × Bittiefe\n'
        '      × Kanäle × Sekunden',
    schritte: [
      '44,1 kHz = 44.100 Messwerte pro Sekunde',
      'Je Kanal: 44.100 × 16 Bit = 705.600 Bit/s',
      'Stereo = 2 Kanäle: 705.600 × 2 = 1.411.200 Bit/s',
      'Eine Minute: 1.411.200 × 60 s = 84.672.000 Bit',
      'Byte: 84.672.000 / 8 = 10.584.000 Byte',
    ],
    ergebnis: '10.584.000 Byte ≈ 10,58 MB pro Minute',
  ),
  beispiel(
    'n-md-9',
    'md-datenmengen',
    'Durchgerechnet: Video',
    'Unkomprimiertes Video ist eine Folge von Einzelbildern. Wie viel Speicher braucht eine Sekunde HD-Video (1280 × 720, 24 Bit, 25 Bilder pro Sekunde) ohne Ton, und eine Minute?',
    code:
        'Bit = Breite × Höhe × Farbtiefe\n'
        '      × Bilder/s × Sekunden',
    schritte: [
      'Ein Bild: 1280 × 720 = 921.600 Pixel × 3 Byte = 2.764.800 Byte',
      'Eine Sekunde: 2.764.800 × 25 = 69.120.000 Byte ≈ 69,12 MB',
      'Eine Minute: 69.120.000 × 60 = 4.147.200.000 Byte ≈ 4,15 GB',
    ],
    ergebnis: '≈ 69,12 MB pro Sekunde, ≈ 4,15 GB pro Minute',
    merksatz: 'Deshalb wird Video praktisch immer komprimiert.',
  ),
  beispiel(
    'n-md-10',
    'md-datenmengen',
    'Durchgerechnet: Wie viele Fotos passen?',
    'Eine Kamera speichert Bilder mit 4.000 × 3.000 Pixeln und 24 Bit Farbtiefe unkomprimiert. Wie viele Bilder passen auf eine 64-GB-Speicherkarte (1 GB = 1.000.000.000 Byte)?',
    schritte: [
      'Ein Bild: 4.000 × 3.000 = 12.000.000 Pixel × 3 Byte = 36.000.000 Byte',
      'Karte: 64 GB = 64.000.000.000 Byte',
      'Teilen: 64.000.000.000 / 36.000.000 ≈ 1.777,8',
      'Ein angefangenes Bild passt nicht -> abrunden',
    ],
    ergebnis: '1.777 Bilder',
  ),
  beispiel(
    'n-md-11',
    'md-datenmengen',
    'Durchgerechnet: über die Bitrate',
    'Bei komprimierten Dateien gibt man die Bitrate an, also die Datenmenge pro Sekunde. Wie groß ist ein 4 Minuten langes MP3 mit 320 kbit/s?',
    code: 'Datenmenge = Bitrate × Dauer',
    schritte: [
      '320 kbit/s = 320.000 Bit/s (Bitraten sind dezimal)',
      '4 min = 240 s',
      '320.000 × 240 = 76.800.000 Bit',
      '76.800.000 / 8 = 9.600.000 Byte',
    ],
    ergebnis: '9.600.000 Byte = 9,6 MB',
  ),
  beispiel(
    'n-md-14',
    'md-datenmengen',
    'Durchgerechnet: Datenrate einer Kamera',
    'Bei Videostreams fragt die Prüfung nach der Datenrate in Mbit/s. Eine Kamera liefert 1920 × 1080 Pixel, 24 Bit Farbtiefe und 25 Bilder pro Sekunde (fps). Der Codec komprimiert auf 1 % der Rohdaten. Wie hoch ist die Datenrate in vollen Mbit/s?',
    code:
        'Mbit/s = Breite × Höhe\n'
        '  × Farbtiefe × Bilder/s\n'
        '  / 1.000.000 × Faktor',
    schritte: [
      'Ein Bild: 1920 × 1080 × 24 Bit = 49.766.400 Bit',
      'Pro Sekunde: 49.766.400 × 25 = 1.244.160.000 Bit/s',
      'In Mbit/s (dezimal): / 1.000.000 = 1.244,16 Mbit/s',
      'Kompression auf 1 %: × 0,01 = 12,44 Mbit/s',
      'Auf volle Mbit/s aufrunden, damit die Leitung reicht: 13 Mbit/s',
    ],
    ergebnis: '13 Mbit/s je Kamera',
    merksatz:
        '„Auf 1 %“ heißt Faktor 0,01. „um 1 %“ wäre Faktor 0,99. Datenraten rechnet man in Bit und dezimal.',
  ),
  beispiel(
    'n-md-15',
    'md-datenmengen',
    'Durchgerechnet: Speicher für mehrere Kameras',
    'Aus der Datenrate folgt der Speicherbedarf. 5 Kameras mit je 13 Mbit/s zeichnen 30 Tage lang ununterbrochen auf. Wie viele TiB Speicher sind mindestens nötig (1 TiB = 1.024⁴ Byte)?',
    schritte: [
      'Alle Kameras: 5 × 13 Mbit/s = 65 Mbit/s = 65.000.000 Bit/s',
      'Dauer: 30 Tage × 24 h × 3.600 s = 2.592.000 s',
      'Bit: 65.000.000 × 2.592.000 = 168.480.000.000.000 Bit',
      'Byte: / 8 = 21.060.000.000.000 Byte',
      'TiB: viermal durch 1.024 teilen ≈ 19,15 TiB',
      'Der Speicher muss reichen -> aufrunden',
    ],
    ergebnis: '20 TiB',
    merksatz:
        'Vier Stolperstellen: Bit in Byte (/ 8), Zeit in Sekunden, Mbit dezimal, TiB binär, und am Ende aufrunden.',
  ),
  falle(
    'n-md-12',
    'md-datenmengen',
    'Bit, Byte, MB und MiB',
    'Am häufigsten passiert es, dass die Farbtiefe in Bit nicht durch 8 geteilt, Stereo vergessen (× 2), Minuten nicht in Sekunden umgerechnet oder dezimal und binär gemischt werden. 6.220.800 Byte sind 6,22 MB, aber nur 5,93 MiB. Lies genau, welche Einheit die Aufgabe verlangt.',
  ),
  merke(
    'n-md-13',
    'md-datenmengen',
    'Das Rechenschema',
    'Ein fester Ablauf verhindert Einheitenfehler bei jeder Datenmengen-Aufgabe.',
    points: [
      'Bild: Breite × Höhe × Farbtiefe',
      'Audio: Abtastrate × Bittiefe × Kanäle × Sekunden',
      'Video: Bild × Bilder/s × Sekunden',
      'Komprimiert: Bitrate × Sekunden',
    ],
    satz:
        'Erst alles in Bit ausrechnen, dann durch 8 teilen, dann in die geforderte Einheit umrechnen.',
  ),

  // ================================================== Übertragungsdauer berechnen
  konzept(
    'n-mu-1',
    'md-uebertragung',
    'Datenrate in Bit pro Sekunde',
    'Die Datenrate (umgangssprachlich Bandbreite) gibt an, wie viele Bit pro Sekunde übertragen werden. Anbieter rechnen dezimal: 1 Mbit/s sind 1.000.000 Bit/s. Dateigrößen stehen dagegen meist in Byte. Für die Dauer musst du beide in dieselbe Einheit bringen.',
    points: [
      'Schreibweisen: Mbit/s, Mb/s oder Mbps, alle meinen Megabit pro Sekunde',
      'MB/s (Megabyte pro Sekunde) ist das Achtfache',
    ],
  ),
  formel(
    'n-mu-2',
    'md-uebertragung',
    'Die Grundformel',
    'Die Übertragungsdauer ergibt sich aus Datenmenge und Datenrate. Umgestellt lassen sich auch Datenmenge oder nötige Datenrate berechnen.',
    't = D / R\n'
        '\n'
        't: Dauer in s\n'
        'D: Datenmenge in Bit\n'
        'R: Datenrate in Bit/s\n'
        '\n'
        'D = R × t      R = D / t',
    merksatz: 'Byte × 8 = Bit, erst dann durch die Datenrate teilen.',
  ),
  beispiel(
    'n-mu-3',
    'md-uebertragung',
    'Durchgerechnet: Update laden',
    'Ein 500-MB-Update (1 MB = 1.000.000 Byte) wird mit 50 Mbit/s geladen. Wie lange dauert das ohne Overhead?',
    schritte: [
      'Byte in Bit: 500 MB × 8 = 4.000 Mbit',
      'Durch die Datenrate teilen: 4.000 Mbit / 50 Mbit/s = 80 s',
      'Umrechnen: 80 s = 1 min 20 s',
    ],
    ergebnis: '80 s = 1 min 20 s',
  ),
  beispiel(
    'n-mu-4',
    'md-uebertragung',
    'Durchgerechnet: binäre Dateigröße',
    'Eine 4-GiB-Installationsdatei wird über ein 100-Mbit/s-Netz kopiert. Wie lange dauert das ohne Overhead? Achtung: Die Datei ist binär, die Datenrate dezimal angegeben.',
    schritte: [
      '4 GiB in Byte: 4 × 1.073.741.824 = 4.294.967.296 Byte',
      'In Bit: 4.294.967.296 × 8 = 34.359.738.368 Bit',
      'Datenrate in Bit/s: 100 Mbit/s = 100.000.000 Bit/s',
      'Dauer: 34.359.738.368 / 100.000.000 ≈ 343,6 s',
      'Umrechnen: 343,6 s - 300 s = 43,6 s -> 5 min 44 s',
    ],
    ergebnis: '≈ 343,6 s ≈ 5 min 44 s',
  ),
  beispiel(
    'n-mu-5',
    'md-uebertragung',
    'Durchgerechnet: nötige Datenrate',
    'Ein nächtliches Backup von 30 GB (1 GB = 1.000.000.000 Byte) soll in höchstens einer Stunde in die Cloud hochgeladen sein. Welche Upload-Rate ist mindestens nötig?',
    schritte: [
      'Datenmenge in Bit: 30 GB × 8 = 240 Gbit = 240.000 Mbit',
      'Zeit in Sekunden: 1 h = 3.600 s',
      'Nach R umstellen: R = D / t = 240.000 Mbit / 3.600 s ≈ 66,7 Mbit/s',
    ],
    ergebnis:
        'mindestens 66,7 Mbit/s Upload. Ein Anschluss mit 40 Mbit/s Upload reicht nicht.',
  ),
  beispiel(
    'n-mu-6',
    'md-uebertragung',
    'Durchgerechnet: mit Overhead',
    'Eine 1,2-GB-Datei (1 GB = 1.000.000.000 Byte) wird über eine 100-Mbit/s-Leitung übertragen. Wegen Protokoll-Headern stehen nur 80 % der Datenrate für Nutzdaten zur Verfügung.',
    schritte: [
      'Datenmenge in Bit: 1,2 GB × 8 = 9,6 Gbit = 9.600 Mbit',
      'Nutzdatenrate: 100 Mbit/s × 0,8 = 80 Mbit/s',
      'Dauer: 9.600 Mbit / 80 Mbit/s = 120 s',
    ],
    ergebnis: '120 s = 2 min (ohne Overhead wären es 96 s)',
  ),
  vergleich(
    'n-mu-7',
    'md-uebertragung',
    'Upload, Download, Overhead',
    'Die tatsächliche Dauer hängt von mehr als der Tarifangabe ab.',
    [
      ['Einfluss', 'Wirkung'],
      ['Upload', 'oft deutlich langsamer als Download, z. B. 250/40 Mbit/s'],
      [
        'Overhead',
        'Protokoll-Header kosten Datenrate, die Nutzdatenrate sinkt',
      ],
      ['geteilte Leitung', 'mehrere Nutzer teilen sich die Datenrate'],
      ['langsamstes Glied', 'WLAN, Server oder Festplatte können bremsen'],
    ],
  ),
  vergleich(
    'n-mu-8',
    'md-uebertragung',
    'Typische Datenraten',
    'Diese Größenordnungen helfen, Ergebnisse auf Plausibilität zu prüfen. Alle Angaben sind Bruttowerte.',
    [
      ['Technik', 'Datenrate'],
      ['Fast Ethernet', '100 Mbit/s'],
      ['Gigabit-Ethernet', '1 Gbit/s = 1.000 Mbit/s'],
      ['USB 2.0', '480 Mbit/s'],
      ['USB 3.2 Gen 1', '5 Gbit/s'],
      ['VDSL Supervectoring', 'bis 250 Mbit/s Download'],
    ],
  ),
  skizze(
    'n-mu-9',
    'md-uebertragung',
    'Dieselbe Datei, verschiedene Leitungen',
    'Eine 5-GB-Datei sind 40.000 Mbit. Die Balken zeigen die Dauer in Sekunden bei verschiedenen Datenraten: Doppelte Datenrate heißt halbe Dauer.',
    BalkenDiagramm([
      Balken('16 Mbit/s', 2500),
      Balken('50 Mbit/s', 800),
      Balken('100 Mbit/s', 400, hervorheben: true),
      Balken('250 Mbit/s', 160),
      Balken('1.000 Mbit/s', 40),
    ], einheit: 's'),
    points: [
      '40.000 Mbit / 16 Mbit/s = 2.500 s ≈ 41,7 min',
      '40.000 Mbit / 1.000 Mbit/s = 40 s',
    ],
  ),
  beispiel(
    'n-mu-10',
    'md-uebertragung',
    'Durchgerechnet: MB/s oder Mbit/s?',
    'Ein Kunde hat einen 100-Mbit/s-Tarif. Sein Browser zeigt beim Download 11 MB/s an. Er beschwert sich, er bekomme nur ein Zehntel. Stimmt das?',
    schritte: [
      'Anzeige in Bit umrechnen: 11 MB/s × 8 = 88 Mbit/s',
      'Mit dem Tarif vergleichen: 88 / 100 = 88 %',
      'Höchstmöglicher Wert: 100 Mbit/s / 8 = 12,5 MB/s',
    ],
    ergebnis:
        'Er erhält 88 % der Tarifrate. Der Rest ist üblicher Overhead. Die Beschwerde ist unbegründet.',
  ),
  falle(
    'n-mu-11',
    'md-uebertragung',
    'Faktor 8 vergessen',
    'Der Klassiker: 500 MB bei 50 Mbit/s dauern nicht 10 s, sondern 80 s, denn Megabyte und Megabit unterscheiden sich um den Faktor 8. Bei einem Backup in die Cloud zählt außerdem die Upload-Rate, nicht die Download-Rate.',
  ),
  falle(
    'n-mu-12',
    'md-uebertragung',
    'Einheiten gemischt',
    'Ist die Datei in GiB, die Leitung aber in Mbit/s angegeben, rechnest du erst alles in Bit um, einmal mit 1.024, einmal mit 1.000. Das Ergebnis in Sekunden musst du oft noch in Minuten oder Stunden umrechnen (1 h = 3.600 s).',
  ),
  merke(
    'n-mu-13',
    'md-uebertragung',
    'Das Wichtigste zur Übertragungsdauer',
    'Rechne alles in Bit und Sekunden um und teile dann.',
    points: [
      'Datenmenge in Bit: Byte × 8, Präfix beachten',
      'Datenrate in Bit/s: dezimal, 1 Mbit/s = 1.000.000 Bit/s',
      'Overhead: Datenrate × Nutzanteil',
      'Upload für Hochladen, Download für Herunterladen',
    ],
    satz: 'Dauer = Datenmenge in Bit / Datenrate in Bit pro Sekunde.',
  ),

  // =================================================== Kompression und Formate
  konzept(
    'n-mx-1',
    'md-kompression',
    'Wozu Kompression?',
    'Kompression verkleinert Daten, damit sie weniger Speicher brauchen und schneller übertragen werden. Ein Codec (Kodierer/Dekodierer) packt die Daten beim Speichern und entpackt sie beim Abspielen.',
    points: [
      'Unkomprimiert: 1 min Full-HD-Video sind mehrere GB',
      'Komprimiert mit H.264: meist deutlich unter 100 MB',
    ],
  ),
  vergleich(
    'n-mx-2',
    'md-kompression',
    'Verlustfrei oder verlustbehaftet',
    'Entscheidend ist, ob das Original nach dem Entpacken Bit für Bit zurückkommt.',
    [
      ['Merkmal', 'verlustfrei', 'verlustbehaftet'],
      ['Prinzip', 'Redundanz entfernen', 'unwichtige Details weglassen'],
      ['Original', 'exakt wiederherstellbar', 'nicht wiederherstellbar'],
      ['Ersparnis', 'meist gering bis mittel', 'hoch'],
      ['Beispiele', 'ZIP, PNG, FLAC', 'JPEG, MP3, AAC, H.264, H.265'],
      ['Einsatz', 'Programme, Texte, Archive', 'Fotos, Musik, Video'],
    ],
  ),
  beispiel(
    'n-mx-3',
    'md-kompression',
    'Durchgerechnet: Lauflängenkodierung (RLE)',
    'RLE ersetzt eine Folge gleicher Zeichen durch Anzahl und Zeichen. Kodiere AAAAABBBCCCCCCCC und bewerte das Ergebnis.',
    schritte: [
      'Folgen zählen: 5 × A, 3 × B, 8 × C',
      'Als Anzahl + Zeichen schreiben: 5A3B8C',
      'Länge vorher: 16 Zeichen, nachher: 6 Zeichen',
      'Faktor: 16 / 6 ≈ 2,67, Einsparung: (1 - 6/16) × 100 % = 62,5 %',
    ],
    ergebnis: '5A3B8C: 62,5 % kleiner, verlustfrei umkehrbar',
    merksatz:
        'Bei ständig wechselnden Zeichen wird es länger: ABCD -> 1A1B1C1D. RLE lohnt sich nur bei langen Wiederholungen, etwa einfarbigen Flächen.',
  ),
  konzept(
    'n-mx-4',
    'md-kompression',
    'Weitere verlustfreie Verfahren',
    'Verlustfreie Verfahren nutzen aus, dass Daten Muster und Wiederholungen enthalten. ZIP und PNG kombinieren zwei davon (Deflate).',
    points: [
      'Wörterbuchverfahren (LZ): Wiederholte Zeichenketten werden durch einen Verweis auf ihr erstes Vorkommen ersetzt',
      'Huffman-Kodierung: Häufige Zeichen bekommen kurze Codes, seltene lange',
      'Deflate = Wörterbuch + Huffman, genutzt in ZIP und PNG',
    ],
  ),
  beispiel(
    'n-mx-5',
    'md-kompression',
    'Durchgerechnet: Huffman-Kodierung',
    'Der Text AAAAABBC soll kodiert werden. Mit fester Länge braucht jedes der drei Zeichen 2 Bit. Wie viel spart eine Huffman-Kodierung?',
    schritte: [
      'Häufigkeiten: A 5-mal, B 2-mal, C 1-mal',
      'Die zwei seltensten zusammenfassen: B + C = 3, dann mit A: 3 + 5 = 8 (Baum)',
      'Codes aus dem Baum: A = 0, B = 10, C = 11',
      'Feste Länge: 8 Zeichen × 2 Bit = 16 Bit',
      'Huffman: 5 × 1 + 2 × 2 + 1 × 2 = 11 Bit',
      'Einsparung: (1 - 11/16) × 100 % = 31,25 %',
    ],
    ergebnis: '11 statt 16 Bit: 31,25 % gespart, verlustfrei',
    skizze: BaumDiagramm(
      BaumKnoten('Wurzel', [
        BaumKnoten('A', [], '5×, Code 0'),
        BaumKnoten('B oder C', [
          BaumKnoten('B', [], '2×, Code 10'),
          BaumKnoten('C', [], '1×, Code 11'),
        ], '3×, Code 1...'),
      ], '8 Zeichen'),
    ),
  ),
  konzept(
    'n-mx-6',
    'md-kompression',
    'Wie verlustbehaftete Verfahren sparen',
    'Verlustbehaftete Verfahren lassen weg, was Menschen kaum wahrnehmen. Wie viel weggelassen wird, bestimmt die Qualitätsstufe bzw. Bitrate.',
    points: [
      'MP3, AAC: Töne, die von lauteren überdeckt werden oder kaum hörbar sind, werden nicht gespeichert (Psychoakustik)',
      'JPEG: Farbinformation wird gröber gespeichert als Helligkeit, feine Details in 8 × 8-Pixel-Blöcken vereinfacht',
      'Video (H.264, H.265): nur einzelne Vollbilder, dazwischen nur die Änderungen zum vorigen Bild',
    ],
  ),
  formel(
    'n-mx-7',
    'md-kompression',
    'Kompression bewerten',
    'Das Ergebnis gibt man als Faktor oder als Einsparung in Prozent an. Weil der Begriff „Kompressionsrate“ uneinheitlich verwendet wird, rechnest du immer genau das, was die Aufgabe fragt.',
    'Faktor = Original / komprimiert\n'
        '\n'
        'Einsparung =\n'
        '  (1 - komprimiert / Original)\n'
        '  × 100 %\n'
        '\n'
        'Restgröße =\n'
        '  komprimiert / Original × 100 %',
  ),
  beispiel(
    'n-mx-8',
    'md-kompression',
    'Durchgerechnet: WAV zu MP3',
    'Ein 3 Minuten langes Musikstück in CD-Qualität ist als WAV 31.752.000 Byte groß. Es wird als MP3 mit 128 kbit/s gespeichert. Berechne Größe, Faktor und Einsparung.',
    schritte: [
      'MP3-Größe über die Bitrate: 128.000 Bit/s × 180 s = 23.040.000 Bit',
      'In Byte: 23.040.000 / 8 = 2.880.000 Byte = 2,88 MB',
      'Faktor: 31.752.000 / 2.880.000 ≈ 11,0',
      'Einsparung: (1 - 2.880.000 / 31.752.000) × 100 % ≈ 90,9 %',
    ],
    ergebnis: '2,88 MB, Faktor ≈ 11, rund 90,9 % kleiner',
  ),
  vergleich(
    'n-mx-9',
    'md-kompression',
    'Formate im Überblick',
    'Für jede Aufgabe gibt es ein passendes Format. In der Prüfung sollst du deine Wahl oft begründen.',
    [
      ['Format', 'Art', 'Einsatz'],
      ['JPEG', 'verlustbehaftet', 'Fotos'],
      ['PNG', 'verlustfrei, Transparenz', 'Grafiken, Screenshots'],
      ['GIF', 'verlustfrei, max. 256 Farben', 'einfache Animationen'],
      ['WebP', 'beides möglich', 'Bilder im Web'],
      ['SVG', 'Vektor', 'Logos, Icons'],
      ['MP3, AAC', 'verlustbehaftet', 'Musik, Streaming'],
      ['FLAC', 'verlustfrei', 'Audio-Archiv'],
      ['H.264, H.265', 'verlustbehaftet', 'Video'],
    ],
  ),
  vergleich(
    'n-mx-10',
    'md-kompression',
    'Raster oder Vektor',
    'Unabhängig von der Kompression unterscheiden sich Grafikformate darin, wie sie ein Bild beschreiben.',
    [
      ['Merkmal', 'Raster', 'Vektor'],
      ['speichert', 'Pixel', 'Formen, Linien, Kurven'],
      ['Vergrößern', 'wird pixelig', 'bleibt scharf'],
      ['Formate', 'JPEG, PNG, GIF', 'SVG'],
      ['Einsatz', 'Fotos', 'Logos, Icons, Diagramme'],
    ],
  ),
  konzept(
    'n-mx-11',
    'md-kompression',
    'Container und Codec',
    'MP4 oder MKV sind Container: Sie bündeln mehrere Spuren in einer Datei. Wie jede Spur komprimiert ist, bestimmt der Codec. Die Dateiendung verrät deshalb nicht, ob ein Gerät die Datei abspielen kann.',
    points: [
      'Videospur: z. B. H.264, H.265 oder AV1',
      'Tonspur: z. B. AAC',
      'Dazu Untertitel und Kapitelmarken',
    ],
  ),
  falle(
    'n-mx-12',
    'md-kompression',
    'Das falsche Format',
    'JPEG erzeugt an harten Kanten und Schrift sichtbare Artefakte und kennt keine Transparenz. Für Logos und Screenshots sind PNG oder SVG besser. Umgekehrt werden Fotos als PNG unnötig groß. Und ein JPEG, das man als PNG speichert, bekommt verlorene Details nicht zurück.',
  ),
  falle(
    'n-mx-13',
    'md-kompression',
    'Doppelt komprimieren bringt nichts',
    'Ein ZIP-Archiv voller JPEGs oder MP3s ist kaum kleiner als die Dateien selbst, denn sie sind schon komprimiert. Wird ein JPEG mehrfach bearbeitet und neu gespeichert, sinkt die Qualität jedes Mal weiter (Generationsverlust).',
  ),
  merke(
    'n-mx-14',
    'md-kompression',
    'Das Wichtigste zur Kompression',
    'Die Wahl des Verfahrens hängt davon ab, ob Details verloren gehen dürfen.',
    points: [
      'Verlustfrei: ZIP, PNG, FLAC, GIF (für Programme, Texte, Grafiken)',
      'Verlustbehaftet: JPEG, MP3, AAC, H.264 (für Fotos, Musik, Video)',
      'Einsparung = (1 - neu/alt) × 100 %',
    ],
    satz:
        'Verlustbehaftet ist unumkehrbar: Was einmal weggelassen wurde, bleibt weg.',
  ),

  // ============================================================ KI-Grundlagen
  konzept(
    'n-ig-1',
    'ki-grundlagen',
    'Was KI heißt',
    'Künstliche Intelligenz (KI) bezeichnet Systeme, die Aufgaben lösen, für die man sonst menschliche Intelligenz braucht, etwa Sprache verstehen oder Bilder erkennen. Heutige Systeme gelten als schwache KI: stark in einem Aufgabenfeld, ohne menschenähnliches Verständnis.',
    points: [
      'Schwache KI: spezialisiert, etwa Übersetzer, Spamfilter, Chatbot',
      'Starke KI: allgemeine Intelligenz wie ein Mensch (gibt es bisher nicht)',
    ],
  ),
  skizze(
    'n-ig-2',
    'ki-grundlagen',
    'Die Begriffe ineinander',
    'KI ist der Oberbegriff. Machine Learning ist ein Teil davon, Deep Learning ein Teil des Machine Learning. Generative KI wie Sprachmodelle baut auf Deep Learning auf.',
    BaumDiagramm(
      BaumKnoten('Künstliche Intelligenz', [
        BaumKnoten('Regelbasierte Systeme', [], 'z. B. Expertensystem'),
        BaumKnoten('Machine Learning', [
          BaumKnoten('Klassische Verfahren', [], 'z. B. Entscheidungsbaum'),
          BaumKnoten('Deep Learning', [
            BaumKnoten('Generative KI', [], 'z. B. LLM, Bildgenerator'),
          ], 'viele Schichten'),
        ], 'lernt aus Daten'),
      ]),
    ),
  ),
  vergleich(
    'n-ig-3',
    'ki-grundlagen',
    'Programmieren oder lernen lassen',
    'Beim Machine Learning (ML) werden die Regeln nicht von Menschen geschrieben, sondern aus Beispieldaten gelernt. Das Ergebnis heißt Modell.',
    [
      ['Merkmal', 'klassisches Programm', 'Machine Learning'],
      ['Eingabe', 'Regeln + Daten', 'Daten + richtige Ergebnisse'],
      ['Ausgabe', 'Ergebnisse', 'Regeln (Modell)'],
      ['Beispiel', 'Rabatt ab 100 € Einkauf', 'Spam an Mustern erkennen'],
      ['Verhalten', 'vorhersehbar, erklärbar', 'statistisch, fehlbar'],
    ],
  ),
  vergleich(
    'n-ig-4',
    'ki-grundlagen',
    'Drei Arten des maschinellen Lernens',
    'Die Lernarten unterscheiden sich darin, welche Daten zum Training vorliegen.',
    [
      ['Art', 'Daten', 'Beispiel'],
      [
        'überwacht',
        'Beispiele mit richtiger Antwort (Label)',
        'Spamfilter aus markierten E-Mails',
      ],
      ['unüberwacht', 'Daten ohne Label', 'Kunden in Gruppen einteilen'],
      [
        'bestärkend',
        'Belohnung oder Strafe für Aktionen',
        'Roboter lernt Greifen',
      ],
    ],
  ),
  vergleich(
    'n-ig-5',
    'ki-grundlagen',
    'Typische Aufgaben',
    'Was ein Modell tun soll, bestimmt die Art der Aufgabe.',
    [
      ['Aufgabe', 'Ergebnis', 'Beispiel'],
      ['Klassifikation', 'eine Kategorie', 'Ticket: Hardware, Software, Netz'],
      ['Regression', 'ein Zahlenwert', 'Preis eines Gebrauchtwagens'],
      ['Clustering', 'Gruppen ähnlicher Daten', 'Kundensegmente'],
      ['Generierung', 'neuer Inhalt', 'Text, Bild, Code'],
    ],
    points: [
      'Klassifikation und Regression sind überwachtes Lernen, Clustering unüberwachtes',
    ],
  ),
  skizze(
    'n-ig-6',
    'ki-grundlagen',
    'So entsteht ein Modell',
    'Mit einem einzigen Durchgang ist ein Modell nicht fertig. Der Ablauf wiederholt sich, bis die Qualität reicht, und auch im Betrieb wird es weiter beobachtet.',
    FlussDiagramm([
      FlussKnoten('Start', form: FlussForm.start),
      FlussKnoten('Daten sammeln'),
      FlussKnoten('Bereinigen und labeln'),
      FlussKnoten('Aufteilen: Training/Test'),
      FlussKnoten('Modell trainieren'),
      FlussKnoten('Mit Testdaten prüfen'),
      FlussKnoten(
        'Gut genug?',
        form: FlussForm.entscheidung,
        pfeil: '[ja]',
        seitlich: '[nein] nachbessern',
      ),
      FlussKnoten('Einsetzen (Inferenz)'),
      FlussKnoten('Im Betrieb überwachen'),
      FlussKnoten('Ende', form: FlussForm.ende),
    ]),
  ),
  konzept(
    'n-ig-7',
    'ki-grundlagen',
    'Trainings- und Testdaten',
    'Die Daten werden vor dem Training aufgeteilt, oft etwa 80 zu 20. Mit den Trainingsdaten lernt das Modell, mit den Testdaten prüfst du, wie gut es mit Beispielen umgeht, die es noch nie gesehen hat.',
    points: [
      'Beispiel: 10.000 markierte Bilder -> 8.000 zum Training, 2.000 zum Test',
      'Overfitting: Das Modell lernt die Trainingsdaten auswendig. Dort ist es sehr gut, bei neuen Daten schlecht',
      'Underfitting: Das Modell ist zu einfach und erkennt nicht einmal die Trainingsdaten gut',
      'Qualität der Daten entscheidet: Fehler und Lücken in den Daten lernt das Modell mit',
    ],
  ),
  beispiel(
    'n-ig-8',
    'ki-grundlagen',
    'Durchgerechnet: Wie gut ist der Spamfilter?',
    'Ein trainierter Spamfilter wird mit 200 Testmails geprüft, davon sind 40 Spam. Die Tabelle zeigt, wie er entschieden hat. Wie hoch ist die Genauigkeit?',
    table: [
      ['tatsächlich', 'als Spam erkannt', 'als kein Spam'],
      ['Spam (40)', '36', '4'],
      ['kein Spam (160)', '8', '152'],
    ],
    schritte: [
      'Richtige Entscheidungen: 36 Spam erkannt + 152 gute Mails durchgelassen = 188',
      'Genauigkeit: 188 / 200 = 0,94 = 94 %',
      'Fehler: 4 Spam-Mails rutschen durch, 8 echte Mails landen im Spam-Ordner (falsch positiv)',
    ],
    ergebnis:
        'Trotz 94 % Genauigkeit gehen 8 echte Mails verloren, und das kann im Betrieb stören.',
  ),
  konzept(
    'n-ig-9',
    'ki-grundlagen',
    'Neuronale Netze und Deep Learning',
    'Ein künstliches neuronales Netz besteht aus Schichten von Neuronen, die über gewichtete Verbindungen verknüpft sind. Beim Training werden die Gewichte so lange angepasst, bis die Ausgaben passen. Deep Learning nutzt Netze mit vielen verborgenen Schichten.',
    skizze: StapelDiagramm(
      [
        StapelEbene('Ausgabeschicht', 'z. B. Spam / kein Spam'),
        StapelEbene('verborgene Schicht 2'),
        StapelEbene('verborgene Schicht 1'),
        StapelEbene('Eingabeschicht', 'z. B. Wörter der Mail'),
      ],
      oben: 'Ergebnis',
      unten: 'Eingabe',
    ),
  ),
  vergleich(
    'n-ig-10',
    'ki-grundlagen',
    'Begriffe rund um Sprachmodelle',
    'Große Sprachmodelle (LLM, Large Language Model) sind generative KI: Sie erzeugen neue Texte, statt nur einzuordnen.',
    [
      ['Begriff', 'Bedeutung'],
      ['Prompt', 'Eingabe, Anweisung an das Modell'],
      ['Token', 'Textbaustein: Wort, Wortteil, Satzzeichen'],
      [
        'Kontextfenster',
        'wie viele Tokens das Modell auf einmal berücksichtigt',
      ],
      ['Parameter', 'gelernte Gewichte, bei LLMs Milliarden'],
      ['Training', 'Modell lernt aus Daten, sehr rechenintensiv'],
      ['Inferenz', 'fertiges Modell beantwortet Anfragen'],
    ],
  ),
  ablauf(
    'n-ig-11',
    'ki-grundlagen',
    'Wie ein Sprachmodell antwortet',
    'Ein LLM erzeugt seine Antwort Stück für Stück. Beispiel: Der Prompt lautet „Die Hauptstadt von Frankreich ist“.',
    [
      'Der Text wird in Tokens zerlegt: Wörter, Wortteile oder Satzzeichen',
      'Das Modell berechnet für jedes mögliche nächste Token eine Wahrscheinlichkeit',
      'Ein wahrscheinliches Token wird gewählt, hier „Paris“',
      'Das Token wird angehängt, und der Vorgang wiederholt sich bis zum Ende der Antwort',
    ],
  ),
  falle(
    'n-ig-12',
    'ki-grundlagen',
    'Wahrscheinlich ist nicht wahr',
    'Ein Sprachmodell schlägt nicht in einer Faktendatenbank nach, sondern erzeugt wahrscheinlichen Text. Der klingt fast immer flüssig, ist aber nicht automatisch richtig. Außerdem kennt das Modell nur Wissen bis zum Stand seiner Trainingsdaten, sofern es nicht zusätzlich z. B. im Web sucht.',
  ),
  falle(
    'n-ig-13',
    'ki-grundlagen',
    'Mit den Trainingsdaten getestet',
    'Wird ein Modell mit denselben Daten geprüft, mit denen es trainiert wurde, sieht die Genauigkeit viel zu gut aus. Overfitting fällt so nicht auf. Testdaten müssen für das Modell neu sein.',
  ),
  merke(
    'n-ig-14',
    'ki-grundlagen',
    'Das Wichtigste zu KI-Grundlagen',
    'KI lernt Muster aus Daten und ist dabei nur so gut wie diese Daten.',
    points: [
      'Überwacht: mit Label, unüberwacht: ohne Label, bestärkend: mit Belohnung',
      'Training mit Trainingsdaten, Prüfung mit ungesehenen Testdaten',
      'LLM: sagt Token für Token das wahrscheinlich nächste vorher',
    ],
    satz:
        'KI umfasst Machine Learning, Machine Learning umfasst Deep Learning.',
  ),

  // ======================================================= KI im Arbeitsalltag
  vergleich(
    'n-ie-1',
    'ki-einsatz',
    'Einsatzfelder im IT-Alltag',
    'KI-Werkzeuge entlasten vor allem bei Routinearbeit mit Text und Code.',
    [
      ['Einsatz', 'Beispiel'],
      [
        'Code-Assistenz',
        'Funktion vorschlagen, Fehler erklären, Tests entwerfen',
      ],
      ['Support-Chatbot', 'Standardfragen rund um die Uhr beantworten'],
      ['Zusammenfassen', 'langen Ticketverlauf auf fünf Punkte kürzen'],
      [
        'Klassifizieren',
        'neue Tickets nach Kategorie und Dringlichkeit sortieren',
      ],
      ['Formulieren', 'Kundenmail in klarer Sprache entwerfen'],
      ['Übersetzen', 'Anleitung für ausländische Kollegen'],
    ],
  ),
  vergleich(
    'n-ie-2',
    'ki-einsatz',
    'Einsatzfelder in Unternehmen',
    'Auch außerhalb der IT-Abteilung ist KI verbreitet, oft unauffällig in Geräten und Programmen.',
    [
      ['Einsatz', 'Beispiel'],
      ['Bilderkennung', 'Kamera prüft Bauteile auf Kratzer'],
      [
        'vorausschauende Wartung',
        'Sensordaten melden Verschleiß vor dem Ausfall',
      ],
      ['Betrugserkennung', 'ungewöhnliche Zahlungen werden gestoppt'],
      ['Empfehlungen', '„Kunden kauften auch“ im Webshop'],
      ['Spracherkennung', 'Diktat, Sprachsteuerung, Transkription'],
    ],
  ),
  vergleich(
    'n-ie-3',
    'ki-einsatz',
    'Bausteine eines guten Prompts',
    'Ein Sprachmodell kennt die Situation nur aus dem Prompt. Je genauer er ist, desto brauchbarer die Antwort.',
    [
      ['Baustein', 'Beispiel'],
      ['Rolle', 'Du arbeitest im Support eines Webshops.'],
      ['Kontext', 'Die Kundin wartet seit 10 Tagen auf ihr Paket.'],
      ['Aufgabe', 'Formuliere eine Antwortmail.'],
      ['Format', 'höflich, höchstens 120 Wörter, mit Betreff'],
      ['Beispiele', 'eine frühere, gelungene Antwort als Muster'],
    ],
  ),
  beispiel(
    'n-ie-4',
    'ki-einsatz',
    'Durchgespielt: einen Prompt verbessern',
    'Ein Azubi fragt: „Schreib was über Backups.“ Die Antwort ist allgemein und zu lang. Verbessere den Prompt mit den Bausteinen.',
    schritte: [
      'Rolle ergänzen: Wer soll antworten? -> IT-Administrator',
      'Kontext ergänzen: Für wen? -> Büro mit 12 Arbeitsplätzen und einem NAS',
      'Aufgabe präzisieren: Was genau? -> Backup-Konzept nach der 3-2-1-Regel',
      'Format festlegen: Wie? -> Tabelle, höchstens 8 Zeilen',
      'Keine vertraulichen Angaben wie Passwörter oder IP-Pläne eintragen',
    ],
    code:
        'Du bist IT-Administrator.\n'
        'Unser Büro hat 12 PCs und\n'
        'ein NAS. Schlage ein Backup-\n'
        'Konzept nach der 3-2-1-Regel\n'
        'vor. Antworte als Tabelle mit\n'
        'höchstens 8 Zeilen.',
    ergebnis:
        'Rolle, Kontext, Aufgabe und Format machen die Antwort passgenau und prüfbar.',
  ),
  vergleich(
    'n-ie-5',
    'ki-einsatz',
    'Prompt-Techniken',
    'Neben den Bausteinen helfen einige Techniken, bessere Antworten zu bekommen.',
    [
      ['Technik', 'Vorgehen'],
      ['Zero-Shot', 'Aufgabe ohne Beispiel stellen'],
      [
        'Few-Shot',
        'ein bis drei Beispiele für die gewünschte Antwort mitgeben',
      ],
      ['Zerlegen', 'große Aufgabe in kleine Schritte aufteilen'],
      ['Nachschärfen', 'Antwort bewerten und gezielt korrigieren lassen'],
      ['Rückfragen erlauben', '„Frag nach, wenn Angaben fehlen.“'],
    ],
  ),
  ablauf(
    'n-ie-6',
    'ki-einsatz',
    'Vom Prompt zum geprüften Ergebnis',
    'Gute Ergebnisse entstehen in Schleifen. Beispiel: Ein Azubi lässt sich eine Funktion schreiben, die Postleitzahlen prüft.',
    [
      'Prompt mit Rolle, Kontext, Aufgabe und Format formulieren',
      'Antwort lesen und verstehen, nicht einfach übernehmen',
      'Fachlich prüfen: Tests ausführen, Grenzfälle wie „01067“ mit führender Null testen',
      'Nachschärfen: Fehler oder fehlende Punkte im nächsten Prompt benennen',
      'Erst das geprüfte Ergebnis einsetzen. Die Verantwortung bleibt beim Menschen',
    ],
  ),
  vergleich(
    'n-ie-7',
    'ki-einsatz',
    'Passt KI zur Aufgabe?',
    'KI lohnt sich bei unscharfen Aufgaben mit Sprache, Bildern und Mustern. Für feste Regeln ist ein normales Programm zuverlässiger und günstiger.',
    [
      ['Aufgabe', 'KI geeignet?'],
      ['Ticket zusammenfassen', 'ja: Sprache, kleine Fehler verkraftbar'],
      ['Bilder nach Mängeln sortieren', 'ja: Muster erkennen'],
      ['Rechnungssumme mit MwSt.', 'nein: feste Rechenregel'],
      ['Kündigung verbindlich bestätigen', 'nur mit menschlicher Prüfung'],
    ],
  ),
  konzept(
    'n-ie-8',
    'ki-einsatz',
    'KI sicher im Unternehmen einsetzen',
    'Unternehmen regeln den KI-Einsatz meist in einer Richtlinie: welche Werkzeuge erlaubt sind und welche Daten hinein dürfen. Seit Februar 2025 verlangt die EU-KI-Verordnung außerdem, dass Mitarbeitende, die KI einsetzen, ausreichend geschult sind (KI-Kompetenz).',
    points: [
      'Unternehmenslizenz statt privatem Konto',
      'Auftragsverarbeitungsvertrag (AVV) nach DSGVO mit dem Anbieter',
      'Keine Nutzung der Eingaben für das Training des Anbieters',
      'Für sensible Daten: Modell im eigenen Rechenzentrum oder in der EU',
    ],
  ),
  ablauf(
    'n-ie-9',
    'ki-einsatz',
    'Einen Support-Chatbot einführen',
    'Typische Prüfungssituation: Ein IT-Dienstleister will auf seiner Website einen KI-Chatbot für Kundenfragen anbieten.',
    [
      'Ziel festlegen: welche Fragen der Bot beantworten soll, welche nicht',
      'Wissensbasis anbinden: FAQ und Handbücher, damit er aus geprüften Quellen antwortet',
      'Datenschutz klären: AVV, keine sensiblen Daten abfragen, Datenschutzhinweis ergänzen',
      'Transparenz: deutlich zeigen, dass ein KI-System antwortet',
      'Übergabe an einen Menschen einbauen, wenn der Bot nicht weiterweiß',
      'Vor dem Start testen, im Betrieb Antworten stichprobenartig prüfen',
    ],
  ),
  falle(
    'n-ie-10',
    'ki-einsatz',
    'Geprüft wird immer',
    'KI-Code kann veraltete Bibliotheken, Sicherheitslücken oder frei erfundene Funktionen enthalten, und eine Kundenantwort kann falsche Zusagen machen. Dass Code kompiliert, heißt nur, dass er syntaktisch stimmt. Wer das Ergebnis ungeprüft weitergibt, trägt die Verantwortung, nicht das Werkzeug.',
  ),
  falle(
    'n-ie-11',
    'ki-einsatz',
    'Geheimnisse gehören nicht in den Prompt',
    'Passwörter, API-Schlüssel, Kundendaten oder interner Quellcode haben in öffentlichen KI-Diensten nichts zu suchen, denn Eingaben können gespeichert und ausgewertet werden. Anonymisiere die Daten vor dem Einfügen oder nutze ein freigegebenes Unternehmenswerkzeug.',
  ),
  merke(
    'n-ie-12',
    'ki-einsatz',
    'Das Wichtigste zum KI-Einsatz',
    'KI ist ein Werkzeug für Text, Code und Muster und kein Ersatz für Fachwissen.',
    points: [
      'Gut für: zusammenfassen, klassifizieren, entwerfen, übersetzen',
      'Nicht für: feste Rechenregeln, ungeprüfte verbindliche Aussagen',
      'Nur freigegebene Werkzeuge, keine vertraulichen Daten',
    ],
    satz:
        'Prompt = Rolle + Kontext + Aufgabe + Format (+ Beispiele). Das Ergebnis wird immer geprüft.',
  ),

  // ================================================= Grenzen, Risiken und Recht
  konzept(
    'n-ir-1',
    'ki-grenzen',
    'Halluzinationen',
    'Eine Halluzination ist eine überzeugend formulierte, aber falsche oder erfundene Ausgabe, etwa ein Gesetzesparagraf, den es nicht gibt, oder eine Quelle mit erfundenem Titel. Sie entsteht, weil das Modell wahrscheinliche statt geprüfte Texte erzeugt.',
    points: [
      'Besonders gefährdet: Zahlen, Zitate, Quellen, Namen, Rechtsfragen',
      'Gegenmittel: Quellen verlangen und prüfen, Fakten gegenchecken',
    ],
  ),
  vergleich(
    'n-ir-2',
    'ki-grenzen',
    'Weitere Risiken',
    'Neben Halluzinationen gibt es Risiken, die rechtliche Folgen haben können.',
    [
      ['Risiko', 'Beispiel'],
      [
        'Bias (Verzerrung)',
        'Bewerbungs-KI benachteiligt Frauen, weil früher meist Männer eingestellt wurden',
      ],
      ['Datenschutz', 'Kundendaten landen in einem öffentlichen Chatbot'],
      ['Urheberrecht', 'Ausgabe gleicht stark einem geschützten Werk'],
      ['Transparenz', 'Nutzer merken nicht, dass sie mit einer KI sprechen'],
      ['Deepfakes', 'gefälschte Stimme des Chefs fordert eine Überweisung'],
    ],
  ),
  konzept(
    'n-ir-3',
    'ki-grenzen',
    'Wie Bias entsteht',
    'Ein Modell übernimmt die Muster seiner Trainingsdaten, auch die unfairen. Sind Gruppen unterrepräsentiert oder spiegeln die Daten frühere Benachteiligung, trifft das Modell verzerrte Entscheidungen.',
    points: [
      'Ursachen: einseitige Datenauswahl, fehlerhafte Labels, historische Ungleichheit',
      'Gegenmaßnahmen: ausgewogene Daten, Ergebnisse je Gruppe testen, Menschen entscheiden lassen',
    ],
  ),
  konzept(
    'n-ir-4',
    'ki-grenzen',
    'Die Blackbox',
    'Bei tiefen neuronalen Netzen lässt sich oft nicht nachvollziehen, warum sie so entschieden haben. Bei Entscheidungen über Menschen (Kredit, Bewerbung) ist das ein Problem: Betroffene haben ein Recht darauf, die Entscheidung zu verstehen und anzufechten.',
    points: [
      'Erklärbare KI (Explainable AI) versucht, Entscheidungen nachvollziehbar zu machen',
      'DSGVO Art. 22: Niemand muss sich einer ausschließlich automatisierten Entscheidung mit erheblicher Wirkung unterwerfen',
    ],
  ),
  konzept(
    'n-ir-5',
    'ki-grenzen',
    'Technische Grenzen',
    'Sprachmodelle haben Grenzen, und die musst du kennen, um ihre Antworten richtig einzuschätzen.',
    points: [
      'Wissensstand: nur bis zum Ende der Trainingsdaten',
      'Kontextfenster: sehr lange Dokumente werden nicht vollständig berücksichtigt',
      'Rechnen und exakte Logik: fehleranfällig ohne Hilfswerkzeug',
      'Prompt Injection: versteckte Anweisungen in Webseiten oder Dokumenten können das Modell manipulieren',
      'Hoher Energie- und Rechenbedarf beim Training und Betrieb',
    ],
  ),
  vergleich(
    'n-ir-6',
    'ki-grenzen',
    'DSGVO beim KI-Einsatz',
    'Sobald personenbezogene Daten in ein KI-System gelangen, gilt die DSGVO wie bei jeder anderen Verarbeitung.',
    [
      ['Grundsatz', 'bedeutet für KI'],
      [
        'Rechtsgrundlage',
        'Verarbeitung muss erlaubt sein, z. B. Einwilligung oder Vertrag',
      ],
      [
        'Zweckbindung',
        'Daten nur für den genannten Zweck, nicht fürs Training',
      ],
      ['Datenminimierung', 'nur so viele Daten wie nötig, besser anonymisiert'],
      ['Auftragsverarbeitung', 'mit externem Anbieter einen AVV schließen'],
      ['Transparenz', 'Betroffene über den KI-Einsatz informieren'],
    ],
  ),
  ablauf(
    'n-ir-7',
    'ki-grenzen',
    'Sicher mit KI-Werkzeugen arbeiten',
    'Beispiel: Ein Mitarbeiter will eine Kundenbeschwerde mit einem Chatbot beantworten lassen.',
    [
      'Prüfen, ob das Werkzeug im Unternehmen freigegeben ist',
      'Keine personenbezogenen oder vertraulichen Daten in öffentliche Tools eingeben. Namen, Kundennummern, Passwörter vorher entfernen',
      'Ausgabe auf Fakten prüfen, Quellen gegenchecken',
      'KI-Einsatz kennzeichnen, wo andere davon wissen müssen',
    ],
  ),
  vergleich(
    'n-ir-8',
    'ki-grenzen',
    'Die EU-KI-Verordnung (AI Act)',
    'Die KI-Verordnung der EU teilt KI-Systeme nach ihrem Risiko für Gesundheit, Sicherheit und Grundrechte ein. Je höher das Risiko, desto strenger die Regeln.',
    [
      ['Risiko', 'Beispiel', 'Folge'],
      [
        'unannehmbar',
        'Social Scoring, Emotionserkennung am Arbeitsplatz',
        'verboten',
      ],
      [
        'hoch',
        'Bewerberauswahl, Kreditprüfung',
        'strenge Pflichten, z. B. menschliche Aufsicht',
      ],
      ['begrenzt', 'Chatbot, Deepfake', 'Transparenz: KI kenntlich machen'],
      ['minimal', 'Spamfilter, KI in Spielen', 'keine besonderen Pflichten'],
    ],
  ),
  vergleich(
    'n-ir-9',
    'ki-grenzen',
    'Seit wann was gilt',
    'Der AI Act gilt stufenweise. Die ersten Pflichten sind bereits wirksam, weitere folgen.',
    [
      ['Datum', 'was gilt'],
      ['1. August 2024', 'Verordnung in Kraft'],
      ['2. Februar 2025', 'Verbote und Pflicht zur KI-Kompetenz'],
      [
        '2. August 2025',
        'Pflichten für KI-Modelle mit allgemeinem Verwendungszweck',
      ],
    ],
    points: ['Pflichten für Hochrisiko-Systeme greifen erst später'],
  ),
  vergleich(
    'n-ir-10',
    'ki-grenzen',
    'Anbieter und Betreiber',
    'Der AI Act verteilt Pflichten nach Rollen. Ein Unternehmen, das ein fertiges KI-Werkzeug nutzt, ist meist Betreiber.',
    [
      ['Rolle', 'wer', 'Beispielpflicht'],
      [
        'Anbieter',
        'entwickelt das System, bringt es auf den Markt',
        'Dokumentation, Risikomanagement',
      ],
      [
        'Betreiber',
        'setzt das System im Beruf ein',
        'bestimmungsgemäß nutzen, Personal schulen',
      ],
    ],
  ),
  beispiel(
    'n-ir-11',
    'ki-grenzen',
    'Durchgespielt: Systeme einordnen',
    'Ein Unternehmen plant drei KI-Projekte: einen Chatbot auf der Website, eine KI, die Bewerbungen vorsortiert, und eine Kamera, die die Stimmung der Mitarbeitenden auswertet. Ordne jedes nach dem AI Act ein.',
    schritte: [
      'Chatbot: spricht mit Menschen -> begrenztes Risiko, muss sich als KI zu erkennen geben',
      'Bewerbungs-KI: Beschäftigung ist ein Hochrisiko-Bereich -> strenge Pflichten wie menschliche Aufsicht, Dokumentation, gute Datenqualität',
      'Emotionserkennung am Arbeitsplatz: grundsätzlich verboten (unannehmbares Risiko), Ausnahmen nur aus medizinischen oder Sicherheitsgründen',
    ],
    ergebnis:
        'Chatbot: begrenzt, Bewerbungs-KI: hoch, Stimmungskamera: verboten. Dieses Projekt wird gestrichen.',
  ),
  falle(
    'n-ir-12',
    'ki-grenzen',
    'KI-Ergebnis heißt nicht rechtefrei',
    'Reine KI-Erzeugnisse ohne menschlichen schöpferischen Beitrag sind in Deutschland in der Regel nicht urheberrechtlich geschützt. Trotzdem kann eine Ausgabe ein fremdes Werk verletzen. Und die DSGVO gilt auch hier: Wer personenbezogene Daten eingibt, verarbeitet sie.',
  ),
  falle(
    'n-ir-13',
    'ki-grenzen',
    'Minimales Risiko heißt nicht regelfrei',
    'Auch für einen Spamfilter ohne besondere Pflichten nach dem AI Act gelten DSGVO, Urheberrecht und Haftung weiter. Die Risikoklasse richtet sich nach dem Einsatzzweck, nicht nach der Technik: Dasselbe Sprachmodell ist im Kundenchat begrenztes, bei der Bewerberauswahl hohes Risiko.',
  ),
  merke(
    'n-ir-14',
    'ki-grenzen',
    'Das Wichtigste zu Grenzen und Recht',
    'KI-Ergebnisse brauchen menschliche Kontrolle, technisch und rechtlich.',
    points: [
      'Halluzination: plausibel, aber falsch. Immer prüfen',
      'Bias: Verzerrung aus den Trainingsdaten',
      'DSGVO: keine personenbezogenen Daten in nicht freigegebene Tools',
      'AI Act: unannehmbar, hoch, begrenzt, minimal',
    ],
    satz:
        'AI Act: Je höher das Risiko, desto strenger die Regeln, von verboten bis frei.',
  ),
];
