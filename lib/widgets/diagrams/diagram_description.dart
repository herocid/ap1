import '../../data/models/diagram.dart';
import '../../data/models/netzplan.dart';
import 'diagram_style.dart';

/// Textfassung einer Zeichnung für Screenreader - so vollständig, dass
/// man die Aufgabe auch ohne Bild lösen kann.
String describeDiagram(Diagram d) => switch (d) {
  StapelDiagramm() => _stapel(d),
  FlussDiagramm() => _fluss(d),
  BaumDiagramm() => 'Baumdiagramm: ${_baum(d.wurzel)}',
  SequenzDiagramm() => _sequenz(d),
  QuadrantenDiagramm() => _quadranten(d),
  BalkenDiagramm() => _balken(d),
  GanttDiagramm() => _gantt(d),
  GeradenDiagramm() => _geraden(d),
  KlassenDiagramm() => _klassen(d),
  ErmDiagramm() => _erm(d),
  UseCaseDiagramm() => _usecase(d),
  NetzSkizze() => _netz(d),
  BitDiagramm() => _bits(d),
  NetzplanDiagramm() => _netzplan(d),
  NetzplanLegende() =>
    'Aufbau eines Netzplanknotens: oben FAZ, Dauer, FEZ; in der Mitte '
        'Nummer und Vorgang; unten SAZ, Gesamtpuffer, SEZ.',
};

String _stapel(StapelDiagramm d) {
  final b = StringBuffer(
    d.pyramide
        ? 'Pyramide, von oben nach unten: '
        : 'Schichtenmodell, von oben nach unten: ',
  );
  final n = d.ebenen.length;
  for (var i = 0; i < n; i++) {
    final e = d.ebenen[i];
    if (i > 0) b.write('; ');
    if (!d.pyramide) b.write('${n - i}. ');
    b.write(e.label);
    if (e.detail != null) b.write(' (${e.detail})');
  }
  b.write('.');
  if (d.oben != null) b.write(' Oben: ${d.oben}.');
  if (d.unten != null) b.write(' Unten: ${d.unten}.');
  return b.toString();
}

String _fluss(FlussDiagramm d) {
  final b = StringBuffer('Ablauf: ');
  for (var i = 0; i < d.knoten.length; i++) {
    final k = d.knoten[i];
    if (i > 0) b.write(' – ');
    final form = switch (k.form) {
      FlussForm.start => 'Start',
      FlussForm.ende => 'Ende',
      FlussForm.entscheidung => 'Entscheidung',
      FlussForm.dokument => 'Dokument',
      FlussForm.schritt => '',
    };
    if (form.isNotEmpty) b.write('$form: ');
    b.write(k.label);
    if (k.seitlich != null) b.write(' (seitlich: ${k.seitlich})');
    if (k.pfeil != null && i < d.knoten.length - 1) b.write(', ${k.pfeil}');
  }
  if (d.zyklus) {
    b.write(' – danach zurück zu ${d.knoten.first.label}');
    if (d.zyklusLabel != null) b.write(' (${d.zyklusLabel})');
  }
  b.write('.');
  return b.toString();
}

String _baum(BaumKnoten k) {
  final self = k.detail == null ? k.label : '${k.detail} ${k.label}';
  if (k.kinder.isEmpty) return self;
  return '$self, darunter: (${k.kinder.map(_baum).join('; ')})';
}

String _sequenz(SequenzDiagramm d) {
  final b = StringBuffer('Sequenzdiagramm mit ${d.teilnehmer.join(', ')}. ');
  for (var i = 0; i < d.nachrichten.length; i++) {
    final n = d.nachrichten[i];
    final von = _at(d.teilnehmer, n.von);
    final an = _at(d.teilnehmer, n.an);
    b.write(
      '${i + 1}. $von an $an: ${n.text}${n.antwort ? ' (Antwort)' : ''}. ',
    );
  }
  return b.toString().trim();
}

String _quadranten(QuadrantenDiagramm d) {
  String q(String pos, Quadrant q) =>
      '$pos: ${q.titel}${q.text == null ? '' : ' – ${q.text}'}';
  return 'Matrix, waagerecht ${d.xAchse}, senkrecht ${d.yAchse}. '
      '${q('Oben links', d.obenLinks)}. ${q('Oben rechts', d.obenRechts)}. '
      '${q('Unten links', d.untenLinks)}. ${q('Unten rechts', d.untenRechts)}.';
}

String _balken(BalkenDiagramm d) =>
    'Balkendiagramm: ${d.balken.map((b) => '${b.label} ${mitEinheit(b.wert, d.einheit)}${b.hervorheben ? ' (hervorgehoben)' : ''}').join('; ')}.';

String _gantt(GanttDiagramm d) {
  final b = StringBuffer('Gantt-Diagramm, Einheit ${d.einheit}. ');
  for (final v in d.vorgaenge) {
    if (v.dauer == 0) {
      b.write('Meilenstein ${v.label} bei ${v.start}. ');
    } else {
      b.write(
        '${v.label}: von ${v.start} bis ${v.start + v.dauer}, Dauer ${v.dauer}'
        '${v.kritisch ? ', kritisch' : ''}. ',
      );
    }
  }
  return b.toString().trim();
}

String _geraden(GeradenDiagramm d) {
  final b = StringBuffer(
    'Koordinatensystem, x: ${d.xAchse} bis ${formatZahl(d.xMax)}, '
    'y: ${d.yAchse} bis ${formatZahl(d.yMax)}. ',
  );
  for (final g in d.geraden) {
    b.write(
      '${g.label}: beginnt bei ${formatZahl(g.start)}, steigt um '
      '${formatZahl(g.steigung)} je Einheit. ',
    );
  }
  for (final p in d.punkte) {
    b.write('${p.label} bei x ${formatZahl(p.x)}, y ${formatZahl(p.y)}. ');
  }
  return b.toString().trim();
}

String _klassen(KlassenDiagramm d) {
  final b = StringBuffer('UML-Klassendiagramm. ');
  for (final k in d.klassen) {
    b.write('Klasse ${k.name}');
    if (k.stereotyp != null) b.write(' (${k.stereotyp})');
    if (k.attribute.isNotEmpty) {
      b.write(', Attribute: ${k.attribute.join(', ')}');
    }
    if (k.methoden.isNotEmpty) b.write(', Methoden: ${k.methoden.join(', ')}');
    b.write('. ');
  }
  for (final r in d.beziehungen) {
    final von = _at(d.klassen.map((k) => k.name).toList(), r.von);
    final zu = _at(d.klassen.map((k) => k.name).toList(), r.zu);
    final art = switch (r.art) {
      UmlArt.assoziation => 'Assoziation',
      UmlArt.gerichtet => 'gerichtete Assoziation',
      UmlArt.aggregation => 'Aggregation (Ganzes $von)',
      UmlArt.komposition => 'Komposition (Ganzes $von)',
      UmlArt.abhaengigkeit => 'Abhängigkeit',
    };
    b.write('$art von $von');
    if (r.multVon != null) b.write(' (${r.multVon})');
    b.write(' zu $zu');
    if (r.multZu != null) b.write(' (${r.multZu})');
    if (r.label != null) b.write(', „${r.label}“');
    b.write('. ');
  }
  return b.toString().trim();
}

String _erm(ErmDiagramm d) {
  final b = StringBuffer('Entity-Relationship-Modell. ');
  for (final e in d.entitaeten) {
    b.write('Entität ${e.name}');
    if (e.attribute.isNotEmpty) {
      b.write(
        ': ${e.attribute.map((a) => e.schluessel.contains(a) ? '$a (Primärschlüssel)' : a).join(', ')}',
      );
    }
    b.write('. ');
  }
  for (final r in d.beziehungen) {
    b.write('${r.a} (${r.kardA}) ${r.name} (${r.kardB}) ${r.b}. ');
  }
  return b.toString().trim();
}

String _usecase(UseCaseDiagramm d) {
  final b = StringBuffer('Anwendungsfalldiagramm, System ${d.system}. ');
  for (final a in d.akteure) {
    b.write(
      'Akteur ${a.name} nutzt ${a.faelle.map((i) => _at(d.faelle, i)).join(', ')}. ',
    );
  }
  for (final r in d.beziehungen) {
    b.write(
      '${_at(d.faelle, r.von)} ${r.art == UcArt.include ? 'bindet ein (include)' : 'erweitert (extend)'} ${_at(d.faelle, r.zu)}. ',
    );
  }
  return b.toString().trim();
}

String _netz(NetzSkizze d) {
  final byId = {for (final k in d.knoten) k.id: k.label};
  final b = StringBuffer('Netzwerkskizze. ');
  for (final z in d.zonen) {
    final drin = d.knoten
        .where((k) => k.x >= z.x0 && k.x <= z.x1 && k.y >= z.y0 && k.y <= z.y1)
        .map((k) => k.label);
    b.write('Bereich ${z.label}: ${drin.join(', ')}. ');
  }
  for (final v in d.verbindungen) {
    b.write(
      '${byId[v.a] ?? v.a} ${v.funk ? 'per Funk ' : ''}verbunden mit ${byId[v.b] ?? v.b}'
      '${v.label == null ? '' : ' (${v.label})'}. ',
    );
  }
  return b.toString().trim();
}

String _bits(BitDiagramm d) {
  final b = StringBuffer('Bitmuster. ');
  for (final z in d.zeilen) {
    b.write('${z.label}: ${z.bits}');
    if (z.netz != null) b.write(', die ersten ${z.netz} Bit sind Netzanteil');
    b.write('. ');
  }
  if (d.legende != null) b.write(d.legende);
  return b.toString().trim();
}

String _netzplan(NetzplanDiagramm d) {
  final b = StringBuffer('Netzplan. ');
  NetzplanSolution? sol;
  if (d.mitWerten) {
    try {
      sol = NetzplanSolver.solve(d.vorgaenge);
    } catch (_) {
      sol = null;
    }
  }
  for (final v in d.vorgaenge) {
    b.write('Vorgang ${v.id} ${v.name}, Dauer ${v.duration}');
    b.write(
      v.predecessors.isEmpty
          ? ', ohne Vorgänger'
          : ', Vorgänger ${v.predecessors.join(', ')}',
    );
    final r = sol?.nodes[v.id];
    if (r != null) {
      b.write(
        ', FAZ ${r.faz}, FEZ ${r.fez}, SAZ ${r.saz}, SEZ ${r.sez}, GP ${r.gp}',
      );
    }
    b.write('. ');
  }
  if (sol != null) {
    b.write(
      'Kritischer Pfad: ${sol.criticalPath.join(', ')}. '
      'Projektdauer ${sol.projectDuration}.',
    );
  }
  return b.toString().trim();
}

String _at(List<String> l, int i) => i >= 0 && i < l.length ? l[i] : '?';
