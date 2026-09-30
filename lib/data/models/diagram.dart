import 'package:flutter/foundation.dart';

import 'netzplan.dart';

/// Eine Zeichnung in einem Lernschritt oder einer Aufgabe.
///
/// Die AP1 fragt viel Grafisches ab: Schichtenmodelle, Netzpläne, UML- und
/// ER-Diagramme, Gantt-Diagramme, Break-even-Kurven, Netzwerkskizzen,
/// Bitmuster. Statt Bilder einzubinden, beschreiben die Inhaltsdateien die
/// Zeichnung als Daten; `DiagramView` setzt sie in jeder Breite und im
/// Dunkelmodus sauber um. Jede Art ist bewusst schlicht gehalten: Die
/// Autorin legt Reihenfolge und grobe Anordnung fest, die App zeichnet.
@immutable
sealed class Diagram {
  const Diagram();

  /// Kennung in JSON.
  String get type;

  Map<String, dynamic> toJsonData();

  Map<String, dynamic> toJson() => {'type': type, ...toJsonData()};

  static Diagram? fromJson(Map<String, dynamic>? j) {
    if (j == null) return null;
    List<Map<String, dynamic>> list(String key) =>
        ((j[key] as List?) ?? const [])
            .map((e) => (e as Map).cast<String, dynamic>())
            .toList();
    List<String> strings(Object? v) =>
        ((v as List?) ?? const []).cast<String>().toList();
    double d(Object? v) => (v as num?)?.toDouble() ?? 0;

    return switch (j['type']) {
      'stapel' => StapelDiagramm(
        [
          for (final e in list('ebenen'))
            StapelEbene(e['label'] as String, e['detail'] as String?),
        ],
        pyramide: j['pyramide'] == true,
        oben: j['oben'] as String?,
        unten: j['unten'] as String?,
      ),
      'fluss' => FlussDiagramm(
        [
          for (final e in list('knoten'))
            FlussKnoten(
              e['label'] as String,
              form: FlussForm.values.firstWhere(
                (f) => f.name == e['form'],
                orElse: () => FlussForm.schritt,
              ),
              pfeil: e['pfeil'] as String?,
              seitlich: e['seitlich'] as String?,
            ),
        ],
        zyklus: j['zyklus'] == true,
        zyklusLabel: j['zyklus_label'] as String?,
      ),
      'baum' => BaumDiagramm(
        BaumKnoten.fromJson((j['wurzel'] as Map).cast<String, dynamic>()),
      ),
      'sequenz' => SequenzDiagramm(strings(j['teilnehmer']), [
        for (final e in list('nachrichten'))
          Nachricht(
            (e['von'] as num).toInt(),
            (e['an'] as num).toInt(),
            e['text'] as String,
            antwort: e['antwort'] == true,
          ),
      ]),
      'quadranten' => QuadrantenDiagramm(
        xAchse: j['x_achse'] as String,
        yAchse: j['y_achse'] as String,
        obenLinks: Quadrant.fromJson(j['ol']),
        obenRechts: Quadrant.fromJson(j['or']),
        untenLinks: Quadrant.fromJson(j['ul']),
        untenRechts: Quadrant.fromJson(j['ur']),
      ),
      'balken' => BalkenDiagramm(
        [
          for (final e in list('balken'))
            Balken(
              e['label'] as String,
              d(e['wert']),
              hervorheben: e['hervorheben'] == true,
            ),
        ],
        einheit: j['einheit'] as String?,
        max: (j['max'] as num?)?.toDouble(),
      ),
      'gantt' => GanttDiagramm([
        for (final e in list('vorgaenge'))
          GanttVorgang(
            e['label'] as String,
            (e['start'] as num).toInt(),
            (e['dauer'] as num).toInt(),
            kritisch: e['kritisch'] == true,
          ),
      ], einheit: (j['einheit'] ?? 'Tag') as String),
      'geraden' => GeradenDiagramm(
        xAchse: j['x_achse'] as String,
        yAchse: j['y_achse'] as String,
        xMax: d(j['x_max']),
        yMax: d(j['y_max']),
        geraden: [
          for (final e in list('geraden'))
            Gerade(e['label'] as String, d(e['start']), d(e['steigung'])),
        ],
        punkte: [
          for (final e in list('punkte'))
            DiagrammPunkt(d(e['x']), d(e['y']), e['label'] as String),
        ],
      ),
      'klassen' => KlassenDiagramm(
        [
          for (final e in list('klassen'))
            UmlKlasse(
              e['name'] as String,
              attribute: strings(e['attribute']),
              methoden: strings(e['methoden']),
              stereotyp: e['stereotyp'] as String?,
            ),
        ],
        beziehungen: [
          for (final e in list('beziehungen'))
            UmlBeziehung(
              (e['von'] as num).toInt(),
              (e['zu'] as num).toInt(),
              art: UmlArt.values.firstWhere(
                (a) => a.name == e['art'],
                orElse: () => UmlArt.assoziation,
              ),
              multVon: e['mult_von'] as String?,
              multZu: e['mult_zu'] as String?,
              label: e['label'] as String?,
            ),
        ],
      ),
      'erm' => ErmDiagramm(
        [
          for (final e in list('entitaeten'))
            ErmEntitaet(
              e['name'] as String,
              attribute: strings(e['attribute']),
              schluessel: strings(e['schluessel']),
            ),
        ],
        beziehungen: [
          for (final e in list('beziehungen'))
            ErmBeziehung(
              e['a'] as String,
              e['name'] as String,
              e['b'] as String,
              e['kard_a'] as String,
              e['kard_b'] as String,
            ),
        ],
      ),
      'usecase' => UseCaseDiagramm(
        system: j['system'] as String,
        faelle: strings(j['faelle']),
        akteure: [
          for (final e in list('akteure'))
            UcAkteur(
              e['name'] as String,
              ((e['faelle'] as List?) ?? const [])
                  .map((i) => (i as num).toInt())
                  .toList(),
            ),
        ],
        beziehungen: [
          for (final e in list('beziehungen'))
            UcBeziehung(
              (e['von'] as num).toInt(),
              (e['zu'] as num).toInt(),
              e['art'] == 'extend' ? UcArt.extend : UcArt.include,
            ),
        ],
      ),
      'netz' => NetzSkizze(
        [
          for (final e in list('knoten'))
            NetzKnoten(
              e['id'] as String,
              e['label'] as String,
              NetzTyp.values.firstWhere(
                (t) => t.name == e['typ'],
                orElse: () => NetzTyp.pc,
              ),
              d(e['x']),
              d(e['y']),
            ),
        ],
        verbindungen: [
          for (final e in list('verbindungen'))
            NetzVerbindung(
              e['a'] as String,
              e['b'] as String,
              label: e['label'] as String?,
              funk: e['funk'] == true,
            ),
        ],
        zonen: [
          for (final e in list('zonen'))
            NetzZone(
              e['label'] as String,
              d(e['x0']),
              d(e['y0']),
              d(e['x1']),
              d(e['y1']),
            ),
        ],
      ),
      'bits' => BitDiagramm([
        for (final e in list('zeilen'))
          BitZeile(
            e['label'] as String,
            e['bits'] as String,
            netz: (e['netz'] as num?)?.toInt(),
          ),
      ], legende: j['legende'] as String?),
      'netzplan' => NetzplanDiagramm([
        for (final e in list('vorgaenge')) Activity.fromJson(e),
      ], mitWerten: j['mit_werten'] != false),
      'netzplan_legende' => const NetzplanLegende(),
      _ => null,
    };
  }
}

// ------------------------------------------------------------------ Stapel

/// Übereinanderliegende Schichten, oben zuerst: OSI- und TCP/IP-Modell,
/// Speicherhierarchie ([pyramide]), Schichtenarchitektur, Maslow.
class StapelDiagramm extends Diagram {
  const StapelDiagramm(
    this.ebenen, {
    this.pyramide = false,
    this.oben,
    this.unten,
  });

  final List<StapelEbene> ebenen;

  /// Als Pyramide zeichnen: oben schmal, unten breit.
  final bool pyramide;

  /// Beschriftung am oberen / unteren Ende, z. B. „schnell, teuer“.
  final String? oben;
  final String? unten;

  @override
  String get type => 'stapel';

  @override
  Map<String, dynamic> toJsonData() => {
    'ebenen': [
      for (final e in ebenen)
        {'label': e.label, if (e.detail != null) 'detail': e.detail},
    ],
    if (pyramide) 'pyramide': true,
    if (oben != null) 'oben': oben,
    if (unten != null) 'unten': unten,
  };
}

class StapelEbene {
  const StapelEbene(this.label, [this.detail]);
  final String label;

  /// Rechts neben / unter der Ebene, z. B. Protokolle oder Geräte.
  final String? detail;
}

// ------------------------------------------------------------------- Fluss

enum FlussForm {
  /// Rechteck mit runden Ecken: Aktion, Phase, Schritt.
  schritt,

  /// Raute: Entscheidung (Aktivitätsdiagramm).
  entscheidung,

  /// Gefüllter Kreis: Startknoten.
  start,

  /// Kreis mit Ring: Endknoten.
  ende,

  /// Rechteck mit Wellenkante: Dokument / Ergebnis.
  dokument,
}

/// Knoten von oben nach unten mit Pfeilen dazwischen: Phasenmodelle,
/// Abläufe, Aktivitätsdiagramme, EVA-Prinzip, Datenfluss.
class FlussDiagramm extends Diagram {
  const FlussDiagramm(this.knoten, {this.zyklus = false, this.zyklusLabel});

  final List<FlussKnoten> knoten;

  /// Pfeil vom letzten zurück zum ersten Knoten (PDCA, Sprint, Kaizen).
  final bool zyklus;
  final String? zyklusLabel;

  @override
  String get type => 'fluss';

  @override
  Map<String, dynamic> toJsonData() => {
    'knoten': [
      for (final k in knoten)
        {
          'label': k.label,
          if (k.form != FlussForm.schritt) 'form': k.form.name,
          if (k.pfeil != null) 'pfeil': k.pfeil,
          if (k.seitlich != null) 'seitlich': k.seitlich,
        },
    ],
    if (zyklus) 'zyklus': true,
    if (zyklusLabel != null) 'zyklus_label': zyklusLabel,
  };
}

class FlussKnoten {
  const FlussKnoten(
    this.label, {
    this.form = FlussForm.schritt,
    this.pfeil,
    this.seitlich,
  });

  final String label;
  final FlussForm form;

  /// Beschriftung des Pfeils zum NÄCHSTEN Knoten, z. B. „[ja]“.
  final String? pfeil;

  /// Seitenausgang nach rechts, z. B. „[nein] Fehlermeldung anzeigen“.
  final String? seitlich;
}

// -------------------------------------------------------------------- Baum

/// Hierarchie: Projektstrukturplan, Organigramm, Verzeichnisbaum, DNS.
class BaumDiagramm extends Diagram {
  const BaumDiagramm(this.wurzel);
  final BaumKnoten wurzel;

  @override
  String get type => 'baum';

  @override
  Map<String, dynamic> toJsonData() => {'wurzel': wurzel.toJson()};
}

class BaumKnoten {
  const BaumKnoten(this.label, [this.kinder = const [], this.detail]);

  final String label;
  final List<BaumKnoten> kinder;

  /// Klein unter dem Label, z. B. PSP-Code „1.2“ oder „5 PT“.
  final String? detail;

  Map<String, dynamic> toJson() => {
    'label': label,
    if (kinder.isNotEmpty) 'kinder': [for (final k in kinder) k.toJson()],
    if (detail != null) 'detail': detail,
  };

  factory BaumKnoten.fromJson(Map<String, dynamic> j) =>
      BaumKnoten(j['label'] as String, [
        for (final k in (j['kinder'] as List?) ?? const [])
          BaumKnoten.fromJson((k as Map).cast<String, dynamic>()),
      ], j['detail'] as String?);
}

// ----------------------------------------------------------------- Sequenz

/// Nachrichten zwischen Beteiligten, zeitlich von oben nach unten:
/// TCP-Handshake, DHCP (DORA), HTTP, TLS, hybride Verschlüsselung.
/// 2 bis 4 Teilnehmer.
class SequenzDiagramm extends Diagram {
  const SequenzDiagramm(this.teilnehmer, this.nachrichten);

  final List<String> teilnehmer;
  final List<Nachricht> nachrichten;

  @override
  String get type => 'sequenz';

  @override
  Map<String, dynamic> toJsonData() => {
    'teilnehmer': teilnehmer,
    'nachrichten': [
      for (final n in nachrichten)
        {
          'von': n.von,
          'an': n.an,
          'text': n.text,
          if (n.antwort) 'antwort': true,
        },
    ],
  };
}

class Nachricht {
  const Nachricht(this.von, this.an, this.text, {this.antwort = false});

  /// Index in [SequenzDiagramm.teilnehmer].
  final int von;
  final int an;
  final String text;

  /// Gestrichelt gezeichnet (Antwort).
  final bool antwort;
}

// -------------------------------------------------------------- Quadranten

/// 2x2-Matrix mit Achsen: Stakeholder-Portfolio, Risikomatrix,
/// Eisenhower, BCG-Matrix, Johari-Fenster.
class QuadrantenDiagramm extends Diagram {
  const QuadrantenDiagramm({
    required this.xAchse,
    required this.yAchse,
    required this.obenLinks,
    required this.obenRechts,
    required this.untenLinks,
    required this.untenRechts,
  });

  /// Beschriftung der waagerechten Achse (nach rechts steigend).
  final String xAchse;

  /// Beschriftung der senkrechten Achse (nach oben steigend).
  final String yAchse;
  final Quadrant obenLinks;
  final Quadrant obenRechts;
  final Quadrant untenLinks;
  final Quadrant untenRechts;

  @override
  String get type => 'quadranten';

  @override
  Map<String, dynamic> toJsonData() => {
    'x_achse': xAchse,
    'y_achse': yAchse,
    'ol': obenLinks.toJson(),
    'or': obenRechts.toJson(),
    'ul': untenLinks.toJson(),
    'ur': untenRechts.toJson(),
  };
}

class Quadrant {
  const Quadrant(this.titel, [this.text]);
  final String titel;
  final String? text;

  Map<String, dynamic> toJson() => {
    'titel': titel,
    if (text != null) 'text': text,
  };

  static Quadrant fromJson(Object? j) {
    final m = (j as Map).cast<String, dynamic>();
    return Quadrant(m['titel'] as String, m['text'] as String?);
  }
}

// ------------------------------------------------------------------ Balken

/// Waagerechte Balken: Nutzwerte, ABC-Analyse, Umfrageergebnisse,
/// Übertragungszeiten.
class BalkenDiagramm extends Diagram {
  const BalkenDiagramm(this.balken, {this.einheit, this.max});

  final List<Balken> balken;
  final String? einheit;

  /// Skalenende; ohne Angabe der größte Wert.
  final double? max;

  @override
  String get type => 'balken';

  @override
  Map<String, dynamic> toJsonData() => {
    'balken': [
      for (final b in balken)
        {
          'label': b.label,
          'wert': b.wert,
          if (b.hervorheben) 'hervorheben': true,
        },
    ],
    if (einheit != null) 'einheit': einheit,
    if (max != null) 'max': max,
  };
}

class Balken {
  const Balken(this.label, this.wert, {this.hervorheben = false});
  final String label;
  final double wert;
  final bool hervorheben;
}

// ------------------------------------------------------------------- Gantt

/// Balkenplan über der Zeit. Ein Vorgang mit Dauer 0 ist ein Meilenstein.
class GanttDiagramm extends Diagram {
  const GanttDiagramm(this.vorgaenge, {this.einheit = 'Tag'});

  final List<GanttVorgang> vorgaenge;

  /// Einheit der Zeitachse, z. B. „Tag“, „KW“, „Woche“.
  final String einheit;

  @override
  String get type => 'gantt';

  @override
  Map<String, dynamic> toJsonData() => {
    'vorgaenge': [
      for (final v in vorgaenge)
        {
          'label': v.label,
          'start': v.start,
          'dauer': v.dauer,
          if (v.kritisch) 'kritisch': true,
        },
    ],
    'einheit': einheit,
  };
}

class GanttVorgang {
  const GanttVorgang(
    this.label,
    this.start,
    this.dauer, {
    this.kritisch = false,
  });
  final String label;

  /// Beginn als Zeitpunkt 0, 1, 2 ... (Ende des vorigen Zeitabschnitts).
  final int start;
  final int dauer;

  /// Auf dem kritischen Pfad - wird hervorgehoben.
  final bool kritisch;
}

// ----------------------------------------------------------------- Geraden

/// Koordinatensystem mit Geraden y = start + steigung * x: Break-even
/// (Kosten und Erlös), Make-or-Buy, Kostenvergleich.
class GeradenDiagramm extends Diagram {
  const GeradenDiagramm({
    required this.xAchse,
    required this.yAchse,
    required this.xMax,
    required this.yMax,
    required this.geraden,
    this.punkte = const [],
  });

  final String xAchse;
  final String yAchse;
  final double xMax;
  final double yMax;
  final List<Gerade> geraden;

  /// Hervorgehobene Punkte, z. B. der Break-even-Punkt.
  final List<DiagrammPunkt> punkte;

  @override
  String get type => 'geraden';

  @override
  Map<String, dynamic> toJsonData() => {
    'x_achse': xAchse,
    'y_achse': yAchse,
    'x_max': xMax,
    'y_max': yMax,
    'geraden': [
      for (final g in geraden)
        {'label': g.label, 'start': g.start, 'steigung': g.steigung},
    ],
    'punkte': [
      for (final p in punkte) {'x': p.x, 'y': p.y, 'label': p.label},
    ],
  };
}

class Gerade {
  const Gerade(this.label, this.start, this.steigung);
  final String label;

  /// y-Achsenabschnitt (z. B. Fixkosten).
  final double start;

  /// Anstieg je x-Einheit (z. B. variable Stückkosten oder Preis).
  final double steigung;
}

class DiagrammPunkt {
  const DiagrammPunkt(this.x, this.y, this.label);
  final double x;
  final double y;
  final String label;
}

// ------------------------------------------------------------ UML-Klassen

enum UmlArt {
  /// Einfache Linie.
  assoziation,

  /// Linie mit offener Pfeilspitze (Navigierbarkeit).
  gerichtet,

  /// Leere Raute am Ganzen ([UmlBeziehung.von]).
  aggregation,

  /// Gefüllte Raute am Ganzen ([UmlBeziehung.von]).
  komposition,

  /// Gestrichelter Pfeil.
  abhaengigkeit,
}

/// UML-Klassendiagramm. Die Klassen stehen untereinander; Beziehungen
/// verbinden sie über ihre Indizes.
class KlassenDiagramm extends Diagram {
  const KlassenDiagramm(this.klassen, {this.beziehungen = const []});

  final List<UmlKlasse> klassen;
  final List<UmlBeziehung> beziehungen;

  @override
  String get type => 'klassen';

  @override
  Map<String, dynamic> toJsonData() => {
    'klassen': [
      for (final k in klassen)
        {
          'name': k.name,
          'attribute': k.attribute,
          'methoden': k.methoden,
          if (k.stereotyp != null) 'stereotyp': k.stereotyp,
        },
    ],
    'beziehungen': [
      for (final b in beziehungen)
        {
          'von': b.von,
          'zu': b.zu,
          'art': b.art.name,
          if (b.multVon != null) 'mult_von': b.multVon,
          if (b.multZu != null) 'mult_zu': b.multZu,
          if (b.label != null) 'label': b.label,
        },
    ],
  };
}

class UmlKlasse {
  const UmlKlasse(
    this.name, {
    this.attribute = const [],
    this.methoden = const [],
    this.stereotyp,
  });

  final String name;

  /// In UML-Schreibweise, z. B. „- kontostand: double“.
  final List<String> attribute;

  /// z. B. „+ einzahlen(betrag: double): void“.
  final List<String> methoden;

  /// z. B. „interface“ - wird als «interface» gesetzt.
  final String? stereotyp;
}

class UmlBeziehung {
  const UmlBeziehung(
    this.von,
    this.zu, {
    this.art = UmlArt.assoziation,
    this.multVon,
    this.multZu,
    this.label,
  });

  /// Indizes in [KlassenDiagramm.klassen]. Bei Aggregation und Komposition
  /// ist [von] das Ganze, [zu] das Teil; bei gerichteten Beziehungen zeigt
  /// der Pfeil auf [zu].
  final int von;
  final int zu;
  final UmlArt art;

  /// Multiplizität am Ende [von] bzw. [zu], z. B. „1“, „0..*“, „1..*“.
  final String? multVon;
  final String? multZu;

  /// Name der Beziehung, z. B. „besitzt“.
  final String? label;
}

// --------------------------------------------------------------------- ERM

/// Entity-Relationship-Modell in Chen-Notation: Rechtecke für Entitäten,
/// Rauten für Beziehungen, Kardinalitäten an den Linien.
class ErmDiagramm extends Diagram {
  const ErmDiagramm(this.entitaeten, {this.beziehungen = const []});

  final List<ErmEntitaet> entitaeten;
  final List<ErmBeziehung> beziehungen;

  @override
  String get type => 'erm';

  @override
  Map<String, dynamic> toJsonData() => {
    'entitaeten': [
      for (final e in entitaeten)
        {'name': e.name, 'attribute': e.attribute, 'schluessel': e.schluessel},
    ],
    'beziehungen': [
      for (final b in beziehungen)
        {
          'a': b.a,
          'name': b.name,
          'b': b.b,
          'kard_a': b.kardA,
          'kard_b': b.kardB,
        },
    ],
  };
}

class ErmEntitaet {
  const ErmEntitaet(
    this.name, {
    this.attribute = const [],
    this.schluessel = const [],
  });

  final String name;
  final List<String> attribute;

  /// Teilmenge von [attribute], die unterstrichen wird (Primärschlüssel).
  final List<String> schluessel;
}

class ErmBeziehung {
  const ErmBeziehung(this.a, this.name, this.b, this.kardA, this.kardB);

  /// Namen der Entitäten aus [ErmDiagramm.entitaeten].
  final String a;
  final String name;
  final String b;

  /// Kardinalität an der Seite von [a] bzw. [b], z. B. „1“ und „n“.
  final String kardA;
  final String kardB;
}

// ---------------------------------------------------------------- Use Case

enum UcArt { include, extend }

/// UML-Anwendungsfalldiagramm: Akteure links, Anwendungsfälle in der
/// Systemgrenze, «include»/«extend» zwischen Anwendungsfällen.
class UseCaseDiagramm extends Diagram {
  const UseCaseDiagramm({
    required this.system,
    required this.faelle,
    required this.akteure,
    this.beziehungen = const [],
  });

  final String system;
  final List<String> faelle;
  final List<UcAkteur> akteure;
  final List<UcBeziehung> beziehungen;

  @override
  String get type => 'usecase';

  @override
  Map<String, dynamic> toJsonData() => {
    'system': system,
    'faelle': faelle,
    'akteure': [
      for (final a in akteure) {'name': a.name, 'faelle': a.faelle},
    ],
    'beziehungen': [
      for (final b in beziehungen)
        {'von': b.von, 'zu': b.zu, 'art': b.art.name},
    ],
  };
}

class UcAkteur {
  const UcAkteur(this.name, this.faelle);
  final String name;

  /// Indizes der Anwendungsfälle, mit denen der Akteur verbunden ist.
  final List<int> faelle;
}

class UcBeziehung {
  const UcBeziehung(this.von, this.zu, this.art);

  /// Pfeil von Anwendungsfall [von] nach [zu] (Indizes in `faelle`).
  /// «include»: Basisfall -> eingebundener Fall.
  /// «extend»: erweiternder Fall -> Basisfall.
  final int von;
  final int zu;
  final UcArt art;
}

// ------------------------------------------------------------ Netzwerk

enum NetzTyp {
  internet,
  router,
  firewall,
  switch_,
  accessPoint,
  server,
  pc,
  laptop,
  smartphone,
  drucker,
  nas,
  cloud,
}

/// Netzwerkskizze auf einem groben Raster: Topologien, DMZ, VLANs,
/// WLAN, Heimnetz. Koordinaten in Rastereinheiten (x nach rechts,
/// y nach unten), die App skaliert auf die Breite. Empfohlen: x 0-4,
/// y 0-6, damit es auf dem Handy lesbar bleibt.
class NetzSkizze extends Diagram {
  const NetzSkizze(
    this.knoten, {
    this.verbindungen = const [],
    this.zonen = const [],
  });

  final List<NetzKnoten> knoten;
  final List<NetzVerbindung> verbindungen;

  /// Umrandete Bereiche wie „DMZ“, „LAN“, „VLAN 10“.
  final List<NetzZone> zonen;

  @override
  String get type => 'netz';

  @override
  Map<String, dynamic> toJsonData() => {
    'knoten': [
      for (final k in knoten)
        {'id': k.id, 'label': k.label, 'typ': k.typ.name, 'x': k.x, 'y': k.y},
    ],
    'verbindungen': [
      for (final v in verbindungen)
        {
          'a': v.a,
          'b': v.b,
          if (v.label != null) 'label': v.label,
          if (v.funk) 'funk': true,
        },
    ],
    'zonen': [
      for (final z in zonen)
        {'label': z.label, 'x0': z.x0, 'y0': z.y0, 'x1': z.x1, 'y1': z.y1},
    ],
  };
}

class NetzKnoten {
  const NetzKnoten(this.id, this.label, this.typ, this.x, this.y);
  final String id;
  final String label;
  final NetzTyp typ;
  final double x;
  final double y;
}

class NetzVerbindung {
  const NetzVerbindung(this.a, this.b, {this.label, this.funk = false});
  final String a;
  final String b;
  final String? label;

  /// Funkverbindung (gestrichelt).
  final bool funk;
}

class NetzZone {
  const NetzZone(this.label, this.x0, this.y0, this.x1, this.y1);
  final String label;
  final double x0;
  final double y0;
  final double x1;
  final double y1;
}

// -------------------------------------------------------------------- Bits

/// Bitmuster in Festbreitenschrift, optional mit farbig getrenntem
/// Netz- und Hostanteil: Subnetting, Zahlensysteme, Zeichenkodierung.
class BitDiagramm extends Diagram {
  const BitDiagramm(this.zeilen, {this.legende});

  final List<BitZeile> zeilen;

  /// z. B. „blau = Netzanteil, grau = Hostanteil“.
  final String? legende;

  @override
  String get type => 'bits';

  @override
  Map<String, dynamic> toJsonData() => {
    'zeilen': [
      for (final z in zeilen)
        {'label': z.label, 'bits': z.bits, if (z.netz != null) 'netz': z.netz},
    ],
    if (legende != null) 'legende': legende,
  };
}

class BitZeile {
  const BitZeile(this.label, this.bits, {this.netz});
  final String label;

  /// Nur 0 und 1, Gruppen mit '.' oder Leerzeichen getrennt,
  /// z. B. „11000000.10101000.00000001.00001010“.
  final String bits;

  /// Anzahl der führenden Bits, die als Netzanteil markiert werden.
  final int? netz;
}

// ---------------------------------------------------------------- Netzplan

/// Vorgangsknoten-Netzplan. Die Werte (FAZ, FEZ, SAZ, SEZ, GP, FP) rechnet
/// die App mit dem NetzplanSolver aus - so stimmen sie immer.
class NetzplanDiagramm extends Diagram {
  const NetzplanDiagramm(this.vorgaenge, {this.mitWerten = true});

  final List<Activity> vorgaenge;

  /// false: nur Nummer, Name und Dauer - die leeren Felder zeigen, was zu
  /// berechnen ist.
  final bool mitWerten;

  @override
  String get type => 'netzplan';

  @override
  Map<String, dynamic> toJsonData() => {
    'vorgaenge': [for (final v in vorgaenge) v.toJson()],
    if (!mitWerten) 'mit_werten': false,
  };
}

/// Der Aufbau eines Netzplanknotens mit allen Feldbezeichnungen.
class NetzplanLegende extends Diagram {
  const NetzplanLegende();

  @override
  String get type => 'netzplan_legende';

  @override
  Map<String, dynamic> toJsonData() => const {};
}
