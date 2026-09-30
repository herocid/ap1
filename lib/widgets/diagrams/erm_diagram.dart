import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'box_graph.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// ER-Modell in Chen-Notation: Entitäten als Rechtecke (Attribute darunter
/// aufgelistet, Primärschlüssel unterstrichen), Beziehungen als Rauten,
/// Kardinalitäten an den Linien.
DiagramLayout layoutErm(ErmDiagramm d, DiagramStyle s, double w) =>
    _ErmLayout(d, s, w);

class _Ent {
  _Ent(this.e);
  final ErmEntitaet e;
  late TextPainter name;
  final attrs = <TextPainter>[];
  late double headH;
}

class _Rel {
  _Rel(this.r, this.edge, this.text, this.kA, this.kB);
  final ErmBeziehung r;
  final GraphEdge edge;
  final TextPainter text;
  final TextPainter kA;
  final TextPainter kB;
}

class _ErmLayout extends DiagramLayout {
  _ErmLayout(this.d, this.s, double maxW) {
    pad = s.sc(8);
    final nameStyle = s.title(size: 13);
    final attrStyle = s.label(size: 11.5, weight: FontWeight.w400);
    final keyStyle = attrStyle.copyWith(
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      decorationColor: s.ink,
    );
    final relStyle = s.label(size: 11.5, weight: FontWeight.w600);
    final kardStyle = s.numeric(
      size: 12.5,
      weight: FontWeight.w700,
      color: s.accent,
    );

    order = _bestOrder();
    for (final i in order) {
      ents.add(_Ent(d.entitaeten[i]));
    }
    final pos = {for (var k = 0; k < ents.length; k++) ents[k].e.name: k};

    Size measure(int i, double maxBoxW) {
      final en = ents[i];
      var natural = s.text(en.e.name, nameStyle).width;
      for (final a in en.e.attribute) {
        natural = math.max(
          natural,
          s.text(a, en.e.schluessel.contains(a) ? keyStyle : attrStyle).width,
        );
      }
      final w = math.max(s.sc(90), math.min(natural + 2 * pad + 1, maxBoxW));
      final inner = w - 2 * pad;
      en.name = s.text(
        en.e.name,
        s.fit(en.e.name, nameStyle, inner),
        maxWidth: inner,
        align: TextAlign.center,
      );
      en.attrs
        ..clear()
        ..addAll([
          for (final a in en.e.attribute)
            s.text(
              a,
              en.e.schluessel.contains(a) ? keyStyle : attrStyle,
              maxWidth: inner,
            ),
        ]);
      en.headH = en.name.height + 2 * s.sc(7);
      final attrH = en.attrs.isEmpty
          ? 0.0
          : en.attrs.fold<double>(0, (m, t) => m + t.height) + 2 * s.sc(5);
      return Size(w, en.headH + attrH);
    }

    for (final r in d.beziehungen) {
      final a = pos[r.a];
      final b = pos[r.b];
      if (a == null || b == null) continue;
      // Raute: Text passt hinein, Verhältnis 2:1.
      final tp = s.text(
        r.name,
        relStyle,
        maxWidth: s.sc(110),
        align: TextAlign.center,
      );
      final hb = tp.width / 4 + tp.height / 2 + s.sc(5);
      final kA = s.text(r.kardA, kardStyle);
      final kB = s.text(r.kardB, kardStyle);
      final e = GraphEdge(
        a,
        b,
        endA: Size(kA.width, kA.height),
        endB: Size(kB.width, kB.height),
        middle: Size(4 * hb, 2 * hb),
        middleOnLine: true,
      );
      rels.add(_Rel(r, e, tp, kA, kB));
    }
    graph = BoxGraph(
      s: s,
      count: ents.length,
      edges: [for (final r in rels) r.edge],
      measure: measure,
      maxW: maxW,
    );
    size = graph.size;
  }

  final ErmDiagramm d;
  final DiagramStyle s;
  late final double pad;
  late final List<int> order;
  final ents = <_Ent>[];
  final rels = <_Rel>[];
  late final BoxGraph graph;

  @override
  late final Size size;

  /// Reihenfolge, in der möglichst viele Beziehungen zwischen Nachbarn
  /// liegen; bei Gleichstand die der Autorin.
  List<int> _bestOrder() {
    final n = d.entitaeten.length;
    final ident = [for (var i = 0; i < n; i++) i];
    if (n <= 2 || n > 7) return ident;
    final idx = {for (var i = 0; i < n; i++) d.entitaeten[i].name: i};
    final pairs = <(int, int)>[
      for (final r in d.beziehungen)
        if (idx[r.a] != null && idx[r.b] != null && r.a != r.b)
          (idx[r.a]!, idx[r.b]!),
    ];
    var best = ident;
    var bestScore = -1 << 30;
    void permute(List<int> cur, List<bool> used) {
      if (cur.length == n) {
        final at = List.filled(n, 0);
        for (var k = 0; k < n; k++) {
          at[cur[k]] = k;
        }
        final seen = <int>{};
        var adj = 0;
        for (final (a, b) in pairs) {
          final lo = math.min(at[a], at[b]);
          if ((at[a] - at[b]).abs() == 1 && seen.add(lo)) adj++;
        }
        var disp = 0;
        for (var k = 0; k < n; k++) {
          disp += (cur[k] - k).abs();
        }
        final score = adj * 1000 - disp;
        if (score > bestScore) {
          bestScore = score;
          best = [...cur];
        }
        return;
      }
      for (var i = 0; i < n; i++) {
        if (used[i]) continue;
        used[i] = true;
        cur.add(i);
        permute(cur, used);
        cur.removeLast();
        used[i] = false;
      }
    }

    permute([], List.filled(n, false));
    return best;
  }

  @override
  void paint(Canvas c) {
    final line = strokePaint(s.ink, 1.3);
    for (final r in rels) {
      final rt = r.edge.route;
      if (rt.length < 2) continue;
      final path = Path()..moveTo(rt.first.dx, rt.first.dy);
      for (final p in rt.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      c.drawPath(path, line);
    }
    for (var i = 0; i < ents.length; i++) {
      _paintEntity(c, ents[i], graph.rects[i]);
    }
    for (final r in rels) {
      if (r.edge.route.length < 2) continue;
      final m = r.edge.middleRect;
      final p = diamondPath(m);
      c.drawPath(p, fillPaint(s.hotBg));
      c.drawPath(p, strokePaint(s.hot, 1.3));
      r.text.paint(c, m.center - Offset(r.text.width / 2, r.text.height / 2));
      paintLabel(c, r.kA, r.edge.endAPos, s.surface, padX: 2, padY: 0);
      paintLabel(c, r.kB, r.edge.endBPos, s.surface, padX: 2, padY: 0);
    }
  }

  void _paintEntity(Canvas c, _Ent en, Rect r) {
    final rr = RRect.fromRectAndRadius(r, const Radius.circular(3));
    c.drawRRect(rr, fillPaint(s.surface));
    c.save();
    c.clipRRect(rr);
    c.drawRect(
      Rect.fromLTWH(r.left, r.top, r.width, en.headH),
      fillPaint(s.accentBg),
    );
    c.restore();
    if (en.attrs.isNotEmpty) {
      c.drawLine(
        Offset(r.left, r.top + en.headH),
        Offset(r.right, r.top + en.headH),
        strokePaint(s.accent, 1),
      );
    }
    c.drawRRect(rr, strokePaint(s.accent, 1.5));
    en.name.paint(
      c,
      Offset(
        r.center.dx - en.name.width / 2,
        r.top + (en.headH - en.name.height) / 2,
      ),
    );
    var y = r.top + en.headH + s.sc(5);
    for (final t in en.attrs) {
      t.paint(c, Offset(r.left + pad, y));
      y += t.height;
    }
  }
}
