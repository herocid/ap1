import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'box_graph.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// UML-Klassendiagramm: Klassen mit drei Abschnitten (Name, Attribute,
/// Methoden), Beziehungen mit korrekten Enden (Raute am Ganzen, offene
/// Pfeilspitze, gestrichelte Abhängigkeit) und Multiplizitäten.
DiagramLayout layoutKlassen(KlassenDiagramm d, DiagramStyle s, double w) =>
    _KlassenLayout(d, s, w);

class _Box {
  TextPainter? stereo;
  late TextPainter name;
  final attrs = <TextPainter>[];
  final methods = <TextPainter>[];
  late double headH;
  late double attrH;
  late double methH;
}

class _KlassenLayout extends DiagramLayout {
  _KlassenLayout(this.d, this.s, double maxW) {
    pad = s.sc(8);
    empty = s.sc(10);
    final nameStyle = s.title(size: 13);
    final stereoStyle = s.label(
      size: 11,
      weight: FontWeight.w400,
      color: s.muted,
    );
    final memberStyle = s.mono(size: 11.5);
    final multStyle = s.numeric(size: 11.5, weight: FontWeight.w700);
    final labelStyle = s
        .label(size: 11.5, weight: FontWeight.w500, color: s.muted)
        .copyWith(fontStyle: FontStyle.italic);

    final n = d.klassen.length;
    for (var i = 0; i < n; i++) {
      boxes.add(_Box());
    }

    Size measure(int i, double maxBoxW) {
      final k = d.klassen[i];
      final b = boxes[i];
      var natural = s.text(k.name, nameStyle).width;
      final stereoText = k.stereotyp == null ? null : '«${k.stereotyp}»';
      if (stereoText != null) {
        natural = math.max(natural, s.text(stereoText, stereoStyle).width);
      }
      for (final m in [...k.attribute, ...k.methoden]) {
        natural = math.max(natural, s.text(m, memberStyle).width);
      }
      final w = math.max(s.sc(96), math.min(natural + 2 * pad + 1, maxBoxW));
      final inner = w - 2 * pad;
      b.stereo = stereoText == null
          ? null
          : s.text(
              stereoText,
              stereoStyle,
              maxWidth: inner,
              align: TextAlign.center,
            );
      b.name = s.text(
        k.name,
        s.fit(k.name, nameStyle, inner),
        maxWidth: inner,
        align: TextAlign.center,
      );
      b.attrs
        ..clear()
        ..addAll([
          for (final a in k.attribute) s.text(a, memberStyle, maxWidth: inner),
        ]);
      b.methods
        ..clear()
        ..addAll([
          for (final m in k.methoden) s.text(m, memberStyle, maxWidth: inner),
        ]);
      b.headH = b.name.height + (b.stereo?.height ?? 0) + 2 * s.sc(6);
      double comp(List<TextPainter> l) => l.isEmpty
          ? empty
          : l.fold<double>(0, (m, t) => m + t.height) + 2 * s.sc(5);
      b.attrH = comp(b.attrs);
      b.methH = comp(b.methods);
      // Breite an längste tatsächliche Zeile anpassen (nach Umbruch).
      var used = math.max(b.name.width, b.stereo?.width ?? 0);
      for (final t in [...b.attrs, ...b.methods]) {
        used = math.max(used, t.width);
      }
      return Size(math.max(w, used + 2 * pad), b.headH + b.attrH + b.methH);
    }

    for (final r in d.beziehungen) {
      if (r.von < 0 || r.von >= n || r.zu < 0 || r.zu >= n || r.von == r.zu) {
        continue;
      }
      final ma = r.multVon == null ? null : s.text(r.multVon!, multStyle);
      final mb = r.multZu == null ? null : s.text(r.multZu!, multStyle);
      final lb = r.label == null
          ? null
          : s.text(r.label!, labelStyle, maxWidth: s.sc(120));
      final (hA, hB) = _heads(r.art);
      final e = GraphEdge(
        r.von,
        r.zu,
        endA: ma == null ? Size.zero : Size(ma.width, ma.height),
        endB: mb == null ? Size.zero : Size(mb.width, mb.height),
        middle: lb == null ? Size.zero : Size(lb.width + 4, lb.height),
        markerA: _headLen(hA),
        markerB: _headLen(hB),
      );
      rels.add((r, e, ma, mb, lb));
    }
    graph = BoxGraph(
      s: s,
      count: n,
      edges: [for (final r in rels) r.$2],
      measure: measure,
      maxW: maxW,
    );
    size = graph.size;
  }

  final KlassenDiagramm d;
  final DiagramStyle s;
  late final double pad;
  late final double empty;
  final boxes = <_Box>[];
  final rels =
      <(UmlBeziehung, GraphEdge, TextPainter?, TextPainter?, TextPainter?)>[];
  late final BoxGraph graph;

  @override
  late final Size size;

  (ArrowHead, ArrowHead) _heads(UmlArt art) => switch (art) {
    UmlArt.assoziation => (ArrowHead.none, ArrowHead.none),
    UmlArt.gerichtet => (ArrowHead.none, ArrowHead.open),
    UmlArt.aggregation => (ArrowHead.hollowDiamond, ArrowHead.none),
    UmlArt.komposition => (ArrowHead.filledDiamond, ArrowHead.none),
    UmlArt.abhaengigkeit => (ArrowHead.none, ArrowHead.open),
  };

  double _headLen(ArrowHead h) => switch (h) {
    ArrowHead.none => 0,
    ArrowHead.hollowDiamond || ArrowHead.filledDiamond => 9 * 1.5,
    _ => 10,
  };

  @override
  void paint(Canvas c) {
    // Linien.
    for (final (r, e, _, _, _) in rels) {
      if (e.route.length < 2) continue;
      final path = Path()..moveTo(e.route.first.dx, e.route.first.dy);
      for (final p in e.route.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      final p = strokePaint(s.ink, 1.3);
      if (r.art == UmlArt.abhaengigkeit) {
        c.drawPath(dashPath(path, dash: 6, gap: 4), p);
      } else {
        c.drawPath(path, p);
      }
    }
    // Kästen.
    for (var i = 0; i < boxes.length; i++) {
      _paintBox(c, boxes[i], graph.rects[i]);
    }
    // Enden, Multiplizitäten, Namen.
    for (final (r, e, ma, mb, lb) in rels) {
      if (e.route.length < 2) continue;
      final (hA, hB) = _heads(r.art);
      final rt = e.route;
      drawHead(
        c,
        rt[1],
        rt[0],
        hA,
        s.ink,
        size: 9,
        strokeWidth: 1.3,
        fill: s.surface,
      );
      drawHead(
        c,
        rt[rt.length - 2],
        rt.last,
        hB,
        s.ink,
        size: 10,
        strokeWidth: 1.3,
        fill: s.surface,
      );
      if (ma != null) paintLabel(c, ma, e.endAPos, s.surface, padX: 2, padY: 0);
      if (mb != null) paintLabel(c, mb, e.endBPos, s.surface, padX: 2, padY: 0);
      if (lb != null) {
        if (e.onLane) {
          c.save();
          c.translate(e.middleRect.left, e.middleRect.bottom - 2);
          c.rotate(-math.pi / 2);
          paintLabel(c, lb, Offset.zero, s.surface, padX: 2, padY: 0);
          c.restore();
        } else {
          paintLabel(
            c,
            lb,
            e.middleRect.topLeft + const Offset(2, 0),
            s.surface,
            padX: 2,
            padY: 0,
          );
        }
      }
    }
  }

  void _paintBox(Canvas c, _Box b, Rect r) {
    final rr = RRect.fromRectAndRadius(r, const Radius.circular(4));
    c.drawRRect(rr, fillPaint(s.surface));
    c.save();
    c.clipRRect(rr);
    c.drawRect(
      Rect.fromLTWH(r.left, r.top, r.width, b.headH),
      fillPaint(s.accentBg),
    );
    c.restore();
    final line = strokePaint(s.ink, 1);
    c.drawLine(
      Offset(r.left, r.top + b.headH),
      Offset(r.right, r.top + b.headH),
      line,
    );
    final y2 = r.top + b.headH + b.attrH;
    c.drawLine(Offset(r.left, y2), Offset(r.right, y2), line);
    c.drawRRect(rr, strokePaint(s.ink, 1.3));

    var y = r.top + s.sc(6);
    if (b.stereo != null) {
      b.stereo!.paint(c, Offset(r.center.dx - b.stereo!.width / 2, y));
      y += b.stereo!.height;
    }
    b.name.paint(c, Offset(r.center.dx - b.name.width / 2, y));
    y = r.top + b.headH + s.sc(5);
    for (final t in b.attrs) {
      t.paint(c, Offset(r.left + pad, y));
      y += t.height;
    }
    y = y2 + s.sc(5);
    for (final t in b.methods) {
      t.paint(c, Offset(r.left + pad, y));
      y += t.height;
    }
  }
}
