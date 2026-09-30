import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// Ablauf von oben nach unten in UML-Aktivitätsnotation: Aktionen als
/// abgerundete Rechtecke, Entscheidungen als Rauten, Start als gefüllter
/// Kreis, Ende als Kreis mit Ring, Dokumente mit Wellenkante.
///
/// Seitenausgänge stehen rechts neben ihrem Knoten; reicht die Breite
/// dafür nicht, rückt der Seitenkasten eine Zeile tiefer (rechts neben
/// der weiterlaufenden Hauptlinie).
DiagramLayout layoutFluss(FlussDiagramm d, DiagramStyle s, double w) =>
    _FlussLayout(d, s, w);

class _Node {
  _Node(this.k);
  final FlussKnoten k;
  TextPainter? text;
  TextPainter? outside; // Beschriftung neben Start/Ende
  Rect shape = Rect.zero;
  TextPainter? guard; // Pfeil zum nächsten Knoten
  double arrowLen = 0;
  Offset guardPos = Offset.zero;
  // Seitenausgang
  TextPainter? sideGuard;
  TextPainter? sideText;
  Rect? sideBox;
  List<Offset> sidePath = const [];
  Offset sideGuardPos = Offset.zero;
}

class _FlussLayout extends DiagramLayout {
  _FlussLayout(this.d, this.s, double maxW) {
    padX = s.sc(12);
    padY = s.sc(9);
    textStyle = s.label(size: 12.5, weight: FontWeight.w600);
    guardStyle = s.label(size: 11.5, weight: FontWeight.w500, color: s.muted);
    sideStyle = s.label(size: 12, weight: FontWeight.w500);

    // Zyklus-Rinne links.
    if (d.zyklus) {
      if (d.zyklusLabel != null && d.zyklusLabel!.isNotEmpty) {
        cycleLabel = s.text(d.zyklusLabel!, guardStyle);
      }
      gutter = (cycleLabel?.height ?? 0) + s.sc(12) + 10;
    }

    // Seitenausgänge zerlegen: „[nein] Kunden informieren“.
    final parsed = <int, (String?, String)>{};
    var guardW = 0.0;
    var sideMin = s.sc(84);
    for (var i = 0; i < d.knoten.length; i++) {
      final sl = d.knoten[i].seitlich;
      if (sl == null) continue;
      final m = RegExp(r'^\s*(\[[^\]]*\])\s*(.*)$').firstMatch(sl);
      final p = m == null
          ? (null, sl.trim())
          : (m.group(1), m.group(2)!.trim());
      parsed[i] = p;
      if (p.$1 != null) {
        guardW = math.max(guardW, s.text(p.$1!, guardStyle).width);
      }
      sideMin = math.max(
        sideMin,
        s.longestWord(p.$2, sideStyle) + 2 * s.sc(12),
      );
    }
    final hasSide = parsed.isNotEmpty;
    final sideArrow = math.max(s.sc(28), guardW + 14);

    // Erst nebeneinander versuchen, sonst Seitenkasten eine Zeile tiefer.
    var mainW = _measure(maxW - gutter - (hasSide ? sideArrow + sideMin : 0));
    stacked = hasSide && gutter + mainW + sideArrow + sideMin > maxW + 0.5;
    if (stacked) mainW = _measure((maxW - gutter) * 0.6);
    cx = gutter + mainW / 2;

    // Seitenkästen.
    final sideX = stacked ? cx + s.sc(18) : gutter + mainW + sideArrow;
    final sideAvail = math.max(sideMin, maxW - sideX);
    var right = gutter + mainW;
    for (final MapEntry(key: i, value: p) in parsed.entries) {
      final n = nodes[i];
      if (p.$1 != null) n.sideGuard = s.text(p.$1!, guardStyle);
      if (p.$2.isNotEmpty) {
        n.sideText = s.text(
          p.$2,
          sideStyle,
          maxWidth: sideAvail - 2 * s.sc(12),
          align: TextAlign.center,
        );
        final sw = math.max(n.sideText!.width + 2 * s.sc(12), s.sc(84));
        n.sideBox = Rect.fromLTWH(
          sideX,
          0,
          sw,
          n.sideText!.height + 2 * s.sc(8),
        );
      }
    }

    // Vertikal stapeln.
    var y = 2.0;
    for (var i = 0; i < nodes.length; i++) {
      final n = nodes[i];
      final g = n.sideGuard;
      if (!stacked) {
        // Beschriftung neben Start/Ende kann höher sein als der Kreis.
        var rowH = math.max(n.shape.height, n.outside?.height ?? 0);
        if (n.sideBox != null) rowH = math.max(rowH, n.sideBox!.height);
        if (g != null) rowH = math.max(rowH, 2 * g.height + 8);
        final cy = y + rowH / 2;
        n.shape = Rect.fromCenter(
          center: Offset(cx, cy),
          width: n.shape.width,
          height: n.shape.height,
        );
        if (parsed.containsKey(i)) {
          final x0 = n.shape.right;
          final x1 = n.sideBox?.left ?? (x0 + sideArrow);
          n.sidePath = [Offset(x0, cy), Offset(x1, cy)];
          if (g != null) {
            n.sideGuardPos = Offset(
              (x0 + x1) / 2 - g.width / 2,
              cy - g.height - 3,
            );
          }
          if (n.sideBox != null) {
            n.sideBox = n.sideBox!.shift(Offset(0, cy - n.sideBox!.height / 2));
            right = math.max(right, n.sideBox!.right);
          } else {
            right = math.max(right, x1 + s.sc(16) + 2);
          }
        }
        y += rowH;
      } else {
        final rowH = math.max(n.shape.height, n.outside?.height ?? 0);
        n.shape = Rect.fromLTWH(
          cx - n.shape.width / 2,
          y + (rowH - n.shape.height) / 2,
          n.shape.width,
          n.shape.height,
        );
        y += rowH;
        if (parsed.containsKey(i)) {
          // Nach rechts, dann hinunter in den Seitenkasten darunter.
          final cy = n.shape.center.dy;
          final gH = math.max(g?.height ?? 0, n.guard?.height ?? 0);
          final top = y + math.max(s.sc(16), gH + 8);
          var box = n.sideBox;
          final tx = box?.center.dx ?? (n.shape.right + s.sc(24));
          final turnX = math.max(tx, n.shape.right + 12);
          if (box != null && turnX > box.right - 12) {
            box = box.shift(Offset(turnX - box.center.dx, 0));
          }
          n.sidePath = [
            Offset(n.shape.right, cy),
            Offset(turnX, cy),
            Offset(turnX, top),
          ];
          if (g != null) {
            n.sideGuardPos = Offset(turnX + 5, (cy + top) / 2 - g.height / 2);
            right = math.max(right, turnX + 5 + g.width);
          }
          if (box != null) {
            n.sideBox = Rect.fromLTWH(box.left, top, box.width, box.height);
            right = math.max(right, n.sideBox!.right);
            y = n.sideBox!.bottom;
          } else {
            y = top + s.sc(16);
            right = math.max(right, turnX + s.sc(9));
          }
        }
      }
      if (i < nodes.length - 1) {
        final gd = n.guard;
        if (stacked && parsed.containsKey(i) && gd != null) {
          // Wächter direkt unter dem Knoten, bevor der Seitenkasten beginnt.
          n.guardPos = Offset(cx + 7, n.shape.bottom + 3);
        }
        y += n.arrowLen;
        if (gd != null && !(stacked && parsed.containsKey(i))) {
          n.guardPos = Offset(cx + 7, y - n.arrowLen / 2 - gd.height / 2);
        }
      }
    }
    width = math.max(gutter + mainW, right);
    size = Size(width, y + 2);
  }

  final FlussDiagramm d;
  final DiagramStyle s;
  late final double padX;
  late final double padY;
  late final TextStyle textStyle;
  late final TextStyle guardStyle;
  late final TextStyle sideStyle;
  final nodes = <_Node>[];
  TextPainter? cycleLabel;
  double gutter = 0;
  late final bool stacked;
  late final double cx;
  late final double width;

  @override
  late final Size size;

  /// Misst alle Knoten für die Breite [mainAvail] der Hauptspalte und
  /// liefert deren benötigte Breite.
  double _measure(double mainAvail) {
    nodes.clear();
    final circle = s.sc(20);
    var natural = 0.0;
    for (final k in d.knoten) {
      if (k.form == FlussForm.schritt || k.form == FlussForm.dokument) {
        natural = math.max(natural, s.text(k.label, textStyle).width);
      }
    }
    final boxW = math.min(
      math.max(natural + 2 * padX, s.sc(120)),
      math.max(mainAvail, s.sc(80)),
    );

    var guardMax = 0.0;
    for (var i = 0; i < d.knoten.length; i++) {
      final k = d.knoten[i];
      final n = _Node(k);
      nodes.add(n);
      switch (k.form) {
        case FlussForm.schritt:
        case FlussForm.dokument:
          final st = s.fit(k.label, textStyle, boxW - 2 * padX);
          n.text = s.text(
            k.label,
            st,
            maxWidth: boxW - 2 * padX,
            align: TextAlign.center,
          );
          final wave = k.form == FlussForm.dokument ? s.sc(12) : 0;
          n.shape = Rect.fromLTWH(
            0,
            0,
            math.max(boxW, n.text!.width + 2 * padX),
            n.text!.height + 2 * padY + wave,
          );
        case FlussForm.entscheidung:
          // Text passt in die Raute, wenn tw/(2A) + th/(2B) <= 1. Mit
          // A = r*B ist die Breite 2A = tw + r*th; erst flach (r = 2),
          // bei wenig Platz steiler.
          final longest = s.longestWord(k.label, textStyle);
          final ww = math.min(
            s.text(k.label, textStyle).width,
            mainAvail * 0.6,
          );
          TextPainter? tp;
          var a = 0.0;
          var b = 0.0;
          search:
          for (final r in const [2.0, 1.6, 1.25]) {
            var w = ww;
            for (var t = 0; t < 8; t++) {
              tp = s.text(
                k.label,
                textStyle,
                maxWidth: w,
                align: TextAlign.center,
              );
              b = tp.width / (2 * r) + tp.height / 2 + s.sc(6);
              a = r * b;
              if (2 * a <= mainAvail) break search;
              if (w <= longest) break;
              w = math.max(longest, w * 0.8);
            }
          }
          n.text = tp;
          n.shape = Rect.fromLTWH(0, 0, 2 * a, 2 * b);
        case FlussForm.start:
        case FlussForm.ende:
          n.shape = Rect.fromLTWH(0, 0, circle, circle);
          if (k.label.trim().isNotEmpty) {
            n.outside = s.text(
              k.label,
              guardStyle,
              maxWidth: math.max(40, mainAvail / 2 - circle),
            );
          }
      }
      if (k.pfeil != null && i < d.knoten.length - 1) {
        n.guard = s.text(
          k.pfeil!,
          guardStyle,
          maxWidth: math.max(40, mainAvail / 2 - 10),
        );
        guardMax = math.max(guardMax, n.guard!.width);
      }
      n.arrowLen = n.guard == null
          ? s.sc(24)
          : math.max(s.sc(24), n.guard!.height + 12);
    }
    var mainW = 0.0;
    for (final n in nodes) {
      var w = n.shape.width;
      if (n.outside != null) w = n.shape.width + 2 * (n.outside!.width + 8);
      mainW = math.max(mainW, w);
    }
    return math.max(mainW, 2 * (guardMax + 10));
  }

  @override
  void paint(Canvas c) {
    final linePaint = strokePaint(s.line, 1.4);

    // Pfeile zwischen den Knoten.
    for (var i = 0; i < nodes.length - 1; i++) {
      final a = nodes[i];
      final b = nodes[i + 1];
      final p0 = Offset(cx, a.shape.bottom);
      final p1 = Offset(cx, b.shape.top);
      c.drawLine(p0, p1, linePaint);
      drawHead(c, p0, p1, ArrowHead.open, s.line, size: 8);
      a.guard?.paint(c, a.guardPos);
    }

    // Seitenausgänge.
    for (final n in nodes) {
      final pts = n.sidePath;
      if (pts.length < 2) continue;
      final path = Path()..moveTo(pts.first.dx, pts.first.dy);
      for (final p in pts.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      c.drawPath(path, linePaint);
      drawHead(
        c,
        pts[pts.length - 2],
        pts.last,
        ArrowHead.open,
        s.line,
        size: 8,
      );
      n.sideGuard?.paint(c, n.sideGuardPos);
      final box = n.sideBox;
      if (box != null) {
        final rr = RRect.fromRectAndRadius(box, Radius.circular(s.sc(10)));
        c.drawRRect(rr, fillPaint(s.surfaceAlt));
        c.drawRRect(rr, strokePaint(s.line, 1.2));
        final t = n.sideText!;
        t.paint(c, box.center - Offset(t.width / 2, t.height / 2));
      } else {
        // Seitenausgang ohne Aktion endet in einem Endknoten.
        final last = pts.last;
        final prev = pts[pts.length - 2];
        final dir = (last - prev) / (last - prev).distance;
        _drawEnd(c, last + dir * s.sc(8), s.sc(8));
      }
    }

    // Zyklus zurück zum ersten Knoten.
    if (d.zyklus && nodes.length >= 2) {
      final first = nodes.first;
      final last = nodes.last;
      final gx = gutter - 10;
      final yl = last.shape.center.dy;
      final yf = first.shape.center.dy;
      final xl = last.shape.left;
      final xf = first.shape.left;
      final path = Path()
        ..moveTo(xl, yl)
        ..lineTo(gx + 6, yl)
        ..quadraticBezierTo(gx, yl, gx, yl - 6)
        ..lineTo(gx, yf + 6)
        ..quadraticBezierTo(gx, yf, gx + 6, yf)
        ..lineTo(xf, yf);
      c.drawPath(path, strokePaint(s.accent, 1.6));
      drawHead(
        c,
        Offset(xf - 10, yf),
        Offset(xf, yf),
        ArrowHead.open,
        s.accent,
        size: 8,
        strokeWidth: 1.6,
      );
      final lbl = cycleLabel;
      if (lbl != null) {
        c.save();
        final mid = (yl + yf) / 2;
        c.translate(gx - 6 - lbl.height, mid + lbl.width / 2);
        c.rotate(-math.pi / 2);
        lbl.paint(c, Offset.zero);
        c.restore();
      }
    }

    // Knoten.
    for (final n in nodes) {
      final r = n.shape;
      switch (n.k.form) {
        case FlussForm.schritt:
          final rr = RRect.fromRectAndRadius(r, Radius.circular(s.sc(12)));
          c.drawRRect(rr, fillPaint(s.accentBg));
          c.drawRRect(rr, strokePaint(s.accent, 1.3));
        case FlussForm.dokument:
          final wave = s.sc(12);
          final bottom = r.bottom - wave;
          final path = Path()
            ..moveTo(r.left, r.top)
            ..lineTo(r.right, r.top)
            ..lineTo(r.right, bottom)
            ..cubicTo(
              r.right - r.width * 0.25,
              bottom - wave,
              r.left + r.width * 0.45,
              bottom + wave,
              r.left,
              bottom,
            )
            ..close();
          c.drawPath(path, fillPaint(s.infoBg));
          c.drawPath(path, strokePaint(s.info, 1.3));
        case FlussForm.entscheidung:
          final p = diamondPath(r);
          c.drawPath(p, fillPaint(s.surfaceAlt));
          c.drawPath(p, strokePaint(s.ink, 1.3));
        case FlussForm.start:
          c.drawCircle(r.center, r.width / 2, fillPaint(s.ink));
        case FlussForm.ende:
          _drawEnd(c, r.center, r.width / 2);
      }
      final t = n.text;
      if (t != null) {
        final lift = n.k.form == FlussForm.dokument ? s.sc(12) / 2 : 0;
        t.paint(c, r.center - Offset(t.width / 2, t.height / 2 + lift));
      }
      final o = n.outside;
      if (o != null) {
        o.paint(c, Offset(r.right + 8, r.center.dy - o.height / 2));
      }
    }
  }

  void _drawEnd(Canvas c, Offset center, double r) {
    c.drawCircle(center, r, fillPaint(s.surface));
    c.drawCircle(center, r - 0.8, strokePaint(s.ink, 1.6));
    c.drawCircle(center, r * 0.55, fillPaint(s.ink));
  }
}
