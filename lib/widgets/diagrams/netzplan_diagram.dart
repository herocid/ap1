import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import '../../data/models/netzplan.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';
import 'legend.dart';

/// Vorgangsknoten-Netzplan wie in der Aufgabenansicht: oben FAZ | D | FEZ,
/// in der Mitte Nummer und Vorgang, unten SAZ | GP | SEZ. Die Werte rechnet
/// der [NetzplanSolver]; der kritische Pfad ist orange.
///
/// Anordnung nach Ebenen (längster Weg vom Start). Kanten über mehrere
/// Ebenen laufen durch Platzhalter, damit sie keinen Knoten kreuzen. Passt
/// der Plan nicht nebeneinander (von links nach rechts), steht er von oben
/// nach unten; erst wenn auch das zu breit ist, scrollt er seitlich.
DiagramLayout layoutNetzplan(NetzplanDiagramm d, DiagramStyle s, double w) =>
    _NetzplanLayout(d, s, w);

DiagramLayout layoutNetzplanLegende(DiagramStyle s, double w) =>
    _LegendeLayout(s, w);

// ---------------------------------------------------------------- Knoten

/// Maße und Zeichnen eines Knotens - gemeinsam für Plan und Legende.
class _NodeGeom {
  _NodeGeom(this.s, {required List<String> names, required bool legende}) {
    numStyle = s.numeric(
      size: legende ? 11 : 12.5,
      weight: legende ? FontWeight.w600 : FontWeight.w600,
      color: legende ? s.muted : s.ink,
    );
    idStyle = s.numeric(size: 13, weight: FontWeight.w700, color: s.accent);
    nameStyle = s.label(size: 11, weight: FontWeight.w500, color: s.muted);
    final probe = s.text(legende ? 'FEZ' : '888', numStyle);
    cellW = probe.width + s.sc(8);
    rowH = probe.height + s.sc(9);
    var w = math.max(3 * cellW, s.sc(legende ? 150 : 96));
    for (final n in names) {
      w = math.max(w, math.min(s.longestWord(n, nameStyle) + 10, s.sc(150)));
    }
    width = w;
    cellW = w / 3;
    var mh = 0.0;
    for (final n in names) {
      final st = s.fit(n, nameStyle, w - 10);
      final tp = s.text(n, st, maxWidth: w - 10, align: TextAlign.center);
      nameTps[n] = tp;
      mh = math.max(mh, tp.height);
    }
    final idH = s.text('A', idStyle).height;
    midH = idH + mh + s.sc(10);
    height = 2 * rowH + midH;
  }

  final DiagramStyle s;
  late final TextStyle numStyle;
  late final TextStyle idStyle;
  late final TextStyle nameStyle;
  late double cellW;
  late final double rowH;
  late final double width;
  late final double midH;
  late final double height;
  final nameTps = <String, TextPainter>{};

  void paint(
    Canvas c,
    Offset o, {
    required String id,
    required String name,
    required List<String> top,
    required List<String> bottom,
    bool critical = false,
    bool gpZero = false,
    TextStyle? idStyleOverride,
  }) {
    final r = Rect.fromLTWH(o.dx, o.dy, width, height);
    final rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
    c.drawRRect(rr, fillPaint(s.surface));
    // Dauerfeld hinterlegt (wie in der Aufgabenansicht).
    c.save();
    c.clipRRect(rr);
    c.drawRect(
      Rect.fromLTWH(o.dx + cellW, o.dy, cellW, rowH),
      fillPaint(s.surfaceAlt),
    );
    if (critical) {
      c.drawRect(
        Rect.fromLTWH(o.dx, o.dy + rowH, width, midH),
        fillPaint(s.hotBg),
      );
    }
    c.restore();
    final border = critical ? s.hot : s.line;
    final lp = strokePaint(critical ? s.hot.withValues(alpha: 0.6) : s.grid, 1);
    // Innenlinien.
    c.drawLine(Offset(r.left, r.top + rowH), Offset(r.right, r.top + rowH), lp);
    c.drawLine(
      Offset(r.left, r.bottom - rowH),
      Offset(r.right, r.bottom - rowH),
      lp,
    );
    for (final i in [1, 2]) {
      final x = r.left + i * cellW;
      c.drawLine(Offset(x, r.top), Offset(x, r.top + rowH), lp);
      c.drawLine(Offset(x, r.bottom - rowH), Offset(x, r.bottom), lp);
    }
    c.drawRRect(rr, strokePaint(border, critical ? 2 : 1.2));

    void cell(String t, int col, double y, {Color? color, FontWeight? weight}) {
      if (t.isEmpty) return;
      final tp = s.text(t, numStyle.copyWith(color: color, fontWeight: weight));
      tp.paint(
        c,
        Offset(
          o.dx + col * cellW + (cellW - tp.width) / 2,
          y + (rowH - tp.height) / 2,
        ),
      );
    }

    for (var i = 0; i < 3; i++) {
      cell(top[i], i, o.dy, weight: i == 1 ? FontWeight.w700 : null);
      cell(
        bottom[i],
        i,
        o.dy + height - rowH,
        color: i == 1 && gpZero ? s.hot : null,
        weight: i == 1 && gpZero ? FontWeight.w700 : null,
      );
    }
    final idTp = s.text(
      id,
      idStyleOverride ?? idStyle.copyWith(color: critical ? s.hot : s.accent),
    );
    final nameTp = nameTps[name];
    final h = idTp.height + (nameTp?.height ?? 0);
    var y = o.dy + rowH + (midH - h) / 2;
    idTp.paint(c, Offset(r.center.dx - idTp.width / 2, y));
    y += idTp.height;
    nameTp?.paint(c, Offset(r.center.dx - nameTp.width / 2, y));
  }
}

// ------------------------------------------------------------- Netzplan

class _V {
  _V.real(this.a) : dummyOf = null;
  _V.dummy(this.dummyOf) : a = null;
  final Activity? a;
  final (String, String)? dummyOf; // Kante (von, nach)
  int level = 0;
  double order = 0;
  Rect rect = Rect.zero;
  bool get isDummy => a == null;
}

class _NetzplanLayout extends DiagramLayout {
  _NetzplanLayout(this.d, this.s, double maxW) {
    final acts = d.vorgaenge;
    geom = _NodeGeom(s, names: [for (final a in acts) a.name], legende: false);
    sol = NetzplanSolver.solve(acts);

    // Ebenen = längster Weg vom Start.
    final byId = {for (final a in acts) a.id: a};
    final level = <String, int>{};
    int lv(String id, Set<String> seen) {
      if (level[id] != null) return level[id]!;
      if (!seen.add(id)) return 0;
      final a = byId[id]!;
      var m = -1;
      for (final p in a.predecessors) {
        if (byId.containsKey(p)) m = math.max(m, lv(p, seen));
      }
      return level[id] = m + 1;
    }

    for (final a in acts) {
      lv(a.id, <String>{});
    }
    final maxLevel = level.values.fold(0, math.max);
    layers = List.generate(maxLevel + 1, (_) => <_V>[]);
    for (final a in acts) {
      final v = _V.real(a)..level = level[a.id]!;
      real[a.id] = v;
      layers[v.level].add(v);
    }
    // Platzhalter für Kanten über mehrere Ebenen.
    for (final a in acts) {
      for (final p in a.predecessors) {
        if (!byId.containsKey(p)) continue;
        final chain = <_V>[real[p]!];
        for (var l = level[p]! + 1; l < level[a.id]!; l++) {
          final dv = _V.dummy((p, a.id))..level = l;
          layers[l].add(dv);
          chain.add(dv);
        }
        chain.add(real[a.id]!);
        if (level[a.id]! <= level[p]!) continue; // Zyklus in fehlerhaften Daten
        edges.add(chain);
      }
    }
    _order();

    dummy = s.sc(12);
    final gapH = s.sc(28); // zwischen Ebenen (waagerecht)
    final gapHv = s.sc(16); // zwischen Knoten einer Ebene (waagerecht)
    final gapV = s.sc(30); // zwischen Ebenen (senkrecht)
    final gapVh = s.sc(10); // zwischen Knoten einer Ebene (senkrecht)
    double layerLen(List<_V> l, double node, double gap) =>
        l.fold<double>(0, (m, v) => m + (v.isDummy ? dummy : node)) +
        gap * (l.length - 1);
    final hW = layers.length * geom.width + (layers.length - 1) * gapH;
    final vW = layers.fold<double>(
      0,
      (m, l) => math.max(m, layerLen(l, geom.width, gapVh)),
    );
    horizontal = hW <= maxW || hW <= vW;
    var w = 0.0;
    var h = 0.0;
    if (horizontal) {
      final colH = [for (final l in layers) layerLen(l, geom.height, gapHv)];
      h = colH.fold(0, math.max);
      for (var i = 0; i < layers.length; i++) {
        var y = (h - colH[i]) / 2;
        final x = i * (geom.width + gapH);
        for (final v in layers[i]) {
          final vh = v.isDummy ? dummy : geom.height;
          v.rect = Rect.fromLTWH(x, y, geom.width, vh);
          y += vh + gapHv;
        }
      }
      w = hW;
    } else {
      final rowW = [for (final l in layers) layerLen(l, geom.width, gapVh)];
      w = math.max(maxW, rowW.fold(0, math.max));
      for (var i = 0; i < layers.length; i++) {
        var x = (w - rowW[i]) / 2;
        final y = i * (geom.height + gapV);
        for (final v in layers[i]) {
          final vw = v.isDummy ? dummy : geom.width;
          v.rect = Rect.fromLTWH(x, y, vw, geom.height);
          x += vw + gapVh;
        }
      }
      h = layers.length * geom.height + (layers.length - 1) * gapV;
    }
    chartH = h;
    if (d.mitWerten && sol.criticalPath.isNotEmpty) {
      legend = Legend(s, math.max(w, maxW), [
        LegendItem.line(
          s.hot,
          'kritischer Pfad: ${sol.criticalPath.join(' → ')} · Projektdauer ${sol.projectDuration}',
        ),
      ]);
    } else {
      legend = Legend(s, maxW, const []);
    }
    size = Size(math.max(w, 1), h + (legend.isEmpty ? 0 : 14 + legend.height));
  }

  final NetzplanDiagramm d;
  final DiagramStyle s;
  late final _NodeGeom geom;
  late final NetzplanSolution sol;
  late final List<List<_V>> layers;
  late final bool horizontal;
  late final double dummy;
  late final double chartH;
  late final Legend legend;
  final real = <String, _V>{};
  final edges = <List<_V>>[];

  @override
  late final Size size;

  /// Reihenfolge innerhalb der Ebenen nach dem Schwerpunkt der Nachbarn
  /// (weniger Kreuzungen).
  void _order() {
    for (final l in layers) {
      for (var i = 0; i < l.length; i++) {
        l[i].order = i.toDouble();
      }
    }
    final preds = <_V, List<_V>>{};
    final succs = <_V, List<_V>>{};
    for (final chain in edges) {
      for (var i = 0; i < chain.length - 1; i++) {
        (succs[chain[i]] ??= []).add(chain[i + 1]);
        (preds[chain[i + 1]] ??= []).add(chain[i]);
      }
    }
    void sweep(Iterable<int> idx, Map<_V, List<_V>> nb) {
      for (final i in idx) {
        final l = layers[i];
        for (final v in l) {
          final n = nb[v];
          if (n != null && n.isNotEmpty) {
            v.order = n.map((x) => x.order).reduce((a, b) => a + b) / n.length;
          }
        }
        final stable = [...l];
        l.sort((a, b) {
          final c = a.order.compareTo(b.order);
          return c != 0 ? c : stable.indexOf(a).compareTo(stable.indexOf(b));
        });
        for (var k = 0; k < l.length; k++) {
          l[k].order = k.toDouble();
        }
      }
    }

    final down = [for (var i = 1; i < layers.length; i++) i];
    sweep(down, preds);
    sweep(down.reversed.map((i) => i - 1), succs);
    sweep(down, preds);
  }

  @override
  void paint(Canvas c) {
    // Kanten.
    for (final chain in edges) {
      final from = chain.first.a!;
      final to = chain.last.a!;
      final rf = sol.nodes[from.id]!;
      final rt = sol.nodes[to.id]!;
      final crit =
          d.mitWerten && rf.isCritical && rt.isCritical && rf.fez == rt.faz;
      final color = crit ? s.hot : s.line;
      final paint = strokePaint(color, crit ? 2.2 : 1.4);
      final pts = <Offset>[];
      for (var i = 0; i < chain.length; i++) {
        final v = chain[i];
        if (horizontal) {
          if (i == 0) {
            pts.add(v.rect.centerRight);
          } else if (i == chain.length - 1) {
            pts.add(v.rect.centerLeft);
          } else {
            pts
              ..add(v.rect.centerLeft)
              ..add(v.rect.centerRight);
          }
        } else {
          if (i == 0) {
            pts.add(v.rect.bottomCenter);
          } else if (i == chain.length - 1) {
            pts.add(v.rect.topCenter);
          } else {
            pts
              ..add(v.rect.topCenter)
              ..add(v.rect.bottomCenter);
          }
        }
      }
      final path = Path()..moveTo(pts.first.dx, pts.first.dy);
      for (var i = 0; i < pts.length - 1; i++) {
        final a = pts[i];
        final b = pts[i + 1];
        if (i.isOdd) {
          // Durch den Platzhalter: gerade.
          path.lineTo(b.dx, b.dy);
          continue;
        }
        if (horizontal) {
          final mx = (a.dx + b.dx) / 2;
          path.cubicTo(mx, a.dy, mx, b.dy, b.dx, b.dy);
        } else {
          final my = (a.dy + b.dy) / 2;
          path.cubicTo(a.dx, my, b.dx, my, b.dx, b.dy);
        }
      }
      c.drawPath(path, paint);
      final end = pts.last;
      final dir = horizontal
          ? Offset(end.dx - 10, end.dy)
          : Offset(end.dx, end.dy - 10);
      drawHead(c, dir, end, ArrowHead.filled, color, size: 8);
    }
    // Knoten.
    for (final v in real.values) {
      final a = v.a!;
      final r = sol.nodes[a.id]!;
      final w = d.mitWerten;
      geom.paint(
        c,
        v.rect.topLeft,
        id: a.id,
        name: a.name,
        top: [w ? '${r.faz}' : '', '${a.duration}', w ? '${r.fez}' : ''],
        bottom: w ? ['${r.saz}', '${r.gp}', '${r.sez}'] : const ['', '', ''],
        critical: w && r.isCritical,
        gpZero: w && r.gp == 0,
      );
    }
    legend.paint(c, Offset(0, chartH + 14));
  }
}

// --------------------------------------------------------------- Legende

class _LegendeLayout extends DiagramLayout {
  _LegendeLayout(this.s, double maxW) {
    geom = _NodeGeom(s, names: const ['Vorgangsbezeichnung'], legende: true);
    final keyStyle = s.numeric(size: 11.5, weight: FontWeight.w700);
    final descStyle = s.label(
      size: 11.5,
      weight: FontWeight.w400,
      color: s.muted,
    );
    const defs = [
      ('Nr.', 'Nummer des Vorgangs'),
      ('D', 'Dauer'),
      ('FAZ', 'Frühester Anfangszeitpunkt'),
      ('FEZ', 'Frühester Endzeitpunkt = FAZ + D'),
      ('SAZ', 'Spätester Anfangszeitpunkt = SEZ − D'),
      ('SEZ', 'Spätester Endzeitpunkt'),
      ('GP', 'Gesamtpuffer = SAZ − FAZ'),
    ];
    final keyW =
        defs.fold<double>(
          0,
          (m, e) => math.max(m, s.text(e.$1, keyStyle).width),
        ) +
        8;
    listRight = maxW >= geom.width + 16 + 200;
    final listW = listRight ? maxW - geom.width - 16 : maxW;
    var y = 0.0;
    for (final (k, v) in defs) {
      final kt = s.text(k, keyStyle);
      final vt = s.text(v, descStyle, maxWidth: listW - keyW);
      rows.add((kt, vt, y));
      y += math.max(kt.height, vt.height) + 3;
    }
    listH = y - 3;
    this.keyW = keyW;
    nodeX = listRight ? 0 : (maxW - geom.width) / 2;
    listX = listRight ? geom.width + 16 : 0;
    listY = listRight
        ? math.max(0, (geom.height - listH) / 2)
        : geom.height + 14;
    size = Size(
      math.max(maxW, geom.width),
      listRight ? math.max(geom.height, listH) : geom.height + 14 + listH,
    );
  }

  final DiagramStyle s;
  late final _NodeGeom geom;
  late final bool listRight;
  late final double listH;
  late final double keyW;
  late final double nodeX;
  late final double listX;
  late final double listY;
  final rows = <(TextPainter, TextPainter, double)>[];

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    geom.paint(
      c,
      Offset(nodeX, listRight ? math.max(0, (listH - geom.height) / 2) : 0),
      id: 'Nr.',
      name: 'Vorgangsbezeichnung',
      top: const ['FAZ', 'D', 'FEZ'],
      bottom: const ['SAZ', 'GP', 'SEZ'],
    );
    for (final (k, v, y) in rows) {
      k.paint(c, Offset(listX, listY + y));
      v.paint(c, Offset(listX + keyW, listY + y));
    }
  }
}
