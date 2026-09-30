import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'diagram_style.dart';

/// Kante für [BoxGraph]: Beschriftung an beiden Enden (Multiplizität,
/// Kardinalität) und ein Mittelstück - bei UML der Beziehungsname neben
/// der Linie, beim ERM die Raute auf der Linie ([middleOnLine]).
class GraphEdge {
  GraphEdge(
    this.a,
    this.b, {
    this.endA = Size.zero,
    this.endB = Size.zero,
    this.middle = Size.zero,
    this.middleOnLine = false,
    this.markerA = 0,
    this.markerB = 0,
  });

  final int a;
  final int b;
  final Size endA;
  final Size endB;
  final Size middle;
  final bool middleOnLine;

  /// Länge der Spitze/Raute an den Enden - Platz, der frei bleiben muss.
  final double markerA;
  final double markerB;

  // Ergebnis.
  List<Offset> route = const [];
  Offset endAPos = Offset.zero;
  Offset endBPos = Offset.zero;
  Rect middleRect = Rect.zero;

  /// Mittelstück auf einer senkrechten Umleitung (für die Rautenlage).
  bool onLane = false;
}

/// Ordnet Kästen (UML-Klassen, Entitäten) nebeneinander oder untereinander
/// an und führt die Verbindungen: benachbarte Kästen direkt, alle übrigen
/// über Umleitungen rechts neben der Spalte, damit keine Linie einen Kasten
/// kreuzt.
class BoxGraph {
  BoxGraph({
    required this.s,
    required this.count,
    required this.edges,
    required this.measure,
    required double maxW,
    this.allowRow = true,
  }) {
    if (allowRow && !_tryRow(maxW)) {
      _column(maxW);
    } else if (!allowRow) {
      _column(maxW);
    }
  }

  final DiagramStyle s;
  final int count;
  final List<GraphEdge> edges;

  /// Größe von Kasten [i] bei höchstens [maxW] Breite.
  final Size Function(int i, double maxW) measure;
  final bool allowRow;

  final rects = <Rect>[];
  late Size size;
  bool row = false;

  // --------------------------------------------------------- nebeneinander

  bool _tryRow(double maxW) {
    if (count < 2 || count > 3) return false;
    final pairs = <int>{};
    for (final e in edges) {
      if ((e.a - e.b).abs() != 1) return false;
      if (!pairs.add(math.min(e.a, e.b))) return false;
    }
    final sizes = [for (var i = 0; i < count; i++) measure(i, maxW)];
    final gaps = <double>[];
    for (var i = 0; i < count - 1; i++) {
      var g = s.sc(48);
      for (final e in edges) {
        if (math.min(e.a, e.b) != i) continue;
        final ends = e.endA.width + e.endB.width + e.markerA + e.markerB;
        g = math.max(
          g,
          e.middleOnLine
              ? e.endA.width + e.endB.width + e.middle.width + 36
              : math.max(ends + 24, e.middle.width + 16),
        );
      }
      gaps.add(g);
    }
    final total =
        sizes.fold<double>(0, (m, z) => m + z.width) +
        gaps.fold<double>(0, (m, g) => m + g);
    if (total > maxW) return false;
    row = true;
    var x = (maxW - total) / 2;
    var maxH = 0.0;
    var minH = double.infinity;
    for (var i = 0; i < count; i++) {
      rects.add(Rect.fromLTWH(x, 0, sizes[i].width, sizes[i].height));
      x += sizes[i].width + (i < count - 1 ? gaps[i] : 0);
      maxH = math.max(maxH, sizes[i].height);
      minH = math.min(minH, sizes[i].height);
    }
    // Raum oberhalb für Beschriftungen, die über die Linie ragen.
    final lineY = minH / 2;
    var extraTop = 0.0;
    var bottom = maxH;
    for (final e in edges) {
      extraTop = math.max(
        extraTop,
        math.max(e.endA.height, e.endB.height) + 6 - lineY,
      );
      if (e.middleOnLine) {
        extraTop = math.max(extraTop, e.middle.height / 2 - lineY);
        bottom = math.max(bottom, lineY + e.middle.height / 2);
      } else {
        bottom = math.max(bottom, lineY + 6 + e.middle.height);
      }
    }
    final dy = math.max(0.0, extraTop);
    for (var i = 0; i < count; i++) {
      rects[i] = rects[i].shift(Offset(0, dy));
    }
    final y = lineY + dy;
    for (final e in edges) {
      final ra = rects[e.a];
      final rb = rects[e.b];
      final aLeft = ra.left < rb.left;
      final pa = Offset(aLeft ? ra.right : ra.left, y);
      final pb = Offset(aLeft ? rb.left : rb.right, y);
      e.route = [pa, pb];
      e.endAPos = aLeft
          ? Offset(pa.dx + 5, y - 5 - e.endA.height)
          : Offset(pa.dx - 5 - e.endA.width, y - 5 - e.endA.height);
      e.endBPos = aLeft
          ? Offset(pb.dx - 5 - e.endB.width, y - 5 - e.endB.height)
          : Offset(pb.dx + 5, y - 5 - e.endB.height);
      final mx = (pa.dx + pb.dx) / 2;
      e.middleRect = e.middleOnLine
          ? Rect.fromCenter(
              center: Offset(mx, y),
              width: e.middle.width,
              height: e.middle.height,
            )
          : Rect.fromLTWH(
              mx - e.middle.width / 2,
              y + 5,
              e.middle.width,
              e.middle.height,
            );
    }
    size = Size(maxW, dy + bottom);
    return true;
  }

  // ----------------------------------------------------------- untereinander

  void _column(double maxW) {
    // Direkt: erste Kante zwischen Nachbarn. Alles andere: Umleitung.
    final direct = <int, GraphEdge>{};
    final lanes = <GraphEdge>[];
    for (final e in edges) {
      final lo = math.min(e.a, e.b);
      if ((e.a - e.b).abs() == 1 && !direct.containsKey(lo)) {
        direct[lo] = e;
      } else {
        lanes.add(e);
      }
    }
    lanes.sort((x, y) => (x.a - x.b).abs().compareTo((y.a - y.b).abs()));

    // Platz rechts für Umleitungen.
    var laneOffset = 0.0;
    var laneStep = 0.0;
    for (final e in lanes) {
      laneOffset = math.max(
        laneOffset,
        [e.endA.width, e.endB.width, e.markerA, e.markerB].reduce(math.max) +
            14,
      );
      if (e.middleOnLine) {
        laneStep = math.max(laneStep, e.middle.width + 10);
      } else {
        // Name senkrecht links neben der Umleitung.
        laneStep = math.max(laneStep, math.max(s.sc(16), e.middle.height + 8));
        laneOffset = math.max(laneOffset, e.middle.height + 10);
      }
    }
    final lanesW = lanes.isEmpty
        ? 0.0
        : laneOffset +
              (lanes.length - 1) * laneStep +
              (lanes.any((e) => e.middleOnLine) ? laneStep / 2 : 0) +
              4;
    final colMax = math.max(s.sc(120), maxW - lanesW - 2);
    final sizes = [for (var i = 0; i < count; i++) measure(i, colMax)];
    // Die Spalte ist mindestens so breit wie die breiteste Raute auf einer
    // direkten Kante - sonst ragt sie bei schmalen Kästen links hinaus.
    final colW = math.max(
      sizes.fold<double>(0, (m, z) => math.max(m, z.width)),
      direct.values
          .where((e) => e.middleOnLine)
          .fold<double>(0, (m, e) => math.max(m, e.middle.width)),
    );
    final cx = colW / 2;

    // Senkrechte Abstände.
    var y = 0.0;
    for (var i = 0; i < count; i++) {
      rects.add(
        Rect.fromLTWH(
          cx - sizes[i].width / 2,
          y,
          sizes[i].width,
          sizes[i].height,
        ),
      );
      y += sizes[i].height;
      if (i == count - 1) break;
      var g = s.sc(22);
      final e = direct[i];
      if (e != null) {
        if (e.middleOnLine) {
          g = math.max(
            s.sc(40),
            e.endA.height + e.endB.height + e.middle.height + 24,
          );
        } else {
          g = math.max(
            s.sc(52),
            math.max(
              e.endA.height +
                  e.endB.height +
                  16 +
                  math.max(e.markerA, e.markerB),
              e.middle.height + 20,
            ),
          );
        }
      }
      // Umleitungen, die hier andocken, brauchen Luft für ihre Beschriftung.
      y += g;
    }
    final colBottom = y;

    // Direkte Kanten.
    for (final MapEntry(key: i, value: e) in direct.entries) {
      final top = rects[i];
      final bottom = rects[i + 1];
      final x = cx;
      final pTop = Offset(x, top.bottom);
      final pBottom = Offset(x, bottom.top);
      final aTop = e.a == i;
      final pa = aTop ? pTop : pBottom;
      final pb = aTop ? pBottom : pTop;
      e.route = [pa, pb];
      Offset endPos(Offset p, Size z, bool atTop) =>
          atTop ? Offset(x + 9, p.dy + 3) : Offset(x + 9, p.dy - 3 - z.height);
      e.endAPos = endPos(pa, e.endA, aTop);
      e.endBPos = endPos(pb, e.endB, !aTop);
      final my = (pTop.dy + pBottom.dy) / 2;
      e.middleRect = e.middleOnLine
          ? Rect.fromCenter(
              center: Offset(x, my),
              width: e.middle.width,
              height: e.middle.height,
            )
          : Rect.fromLTWH(
              x - 9 - e.middle.width,
              my - e.middle.height / 2,
              e.middle.width,
              e.middle.height,
            );
    }

    // Umleitungen: Andockpunkte je Kasten gleichmäßig verteilen.
    final attach = <int, List<(GraphEdge, bool)>>{};
    for (final e in lanes) {
      (attach[e.a] ??= []).add((e, true));
      (attach[e.b] ??= []).add((e, false));
    }
    final attachY = <(GraphEdge, bool), double>{};
    for (final MapEntry(key: i, value: list) in attach.entries) {
      final r = rects[i];
      // Obere Enden zuerst, damit sich Umleitungen nicht kreuzen.
      list.sort((p, q) {
        double other((GraphEdge, bool) t) =>
            (t.$2 ? t.$1.b : t.$1.a).toDouble();
        return other(p).compareTo(other(q));
      });
      for (var k = 0; k < list.length; k++) {
        attachY[list[k]] = r.top + r.height * (k + 1) / (list.length + 1);
      }
    }
    var right = colW;
    for (var k = 0; k < lanes.length; k++) {
      final e = lanes[k];
      final lx =
          colW +
          laneOffset +
          k * laneStep +
          (e.middleOnLine ? laneStep / 2 - 5 : 0);
      final ra = rects[e.a];
      final rb = rects[e.b];
      final ya = attachY[(e, true)]!;
      final yb = attachY[(e, false)]!;
      e.onLane = true;
      e.route = [
        Offset(ra.right, ya),
        Offset(lx, ya),
        Offset(lx, yb),
        Offset(rb.right, yb),
      ];
      e.endAPos = Offset(ra.right + 4, ya - 6 - e.endA.height);
      e.endBPos = Offset(rb.right + 4, yb - 6 - e.endB.height);
      final my = (ya + yb) / 2;
      // Auf Umleitungen steht ein Name senkrecht (um 90° gedreht) links
      // neben der Linie; middleRect ist dann die gedrehte Fläche.
      e.middleRect = e.middleOnLine
          ? Rect.fromCenter(
              center: Offset(lx, my),
              width: e.middle.width,
              height: e.middle.height,
            )
          : Rect.fromLTWH(
              lx - 4 - e.middle.height,
              my - e.middle.width / 2,
              e.middle.height,
              e.middle.width,
            );
      right = math.max(right, math.max(lx + 2, e.middleRect.right));
    }
    size = Size(right + 2, colBottom);
  }
}
