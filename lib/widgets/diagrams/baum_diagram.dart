import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// Baumdiagramm (PSP, Organigramm). Drei Anordnungen, die erste, die in
/// die Breite passt, gewinnt:
/// 1. klassischer Baum von oben nach unten,
/// 2. PSP-Form: Wurzel oben, Teilprojekte als Spalten, darunter die
///    Arbeitspakete eingerückt untereinander,
/// 3. eingerückter Baum mit Verbindungslinien (schmale Displays).
DiagramLayout layoutBaum(BaumDiagramm d, DiagramStyle s, double w) =>
    _BaumLayout(d, s, w);

class _T {
  _T(this.k, this.depth, this.kids);
  final BaumKnoten k;
  final int depth;
  final List<_T> kids;
  late TextPainter label;
  TextPainter? detail;
  Rect box = Rect.zero;
  double subtree = 0;
}

enum _Mode { tree, columns, indented }

class _BaumLayout extends DiagramLayout {
  _BaumLayout(this.d, this.s, double maxW) {
    root = _build(d.wurzel, 0);
    padX = s.sc(9);
    padY = s.sc(6);
    gapX = s.sc(10);
    gapY = s.sc(22);
    indent = s.sc(16);
    if (!_tryTree(maxW) && !_tryColumns(maxW)) _indented(maxW);
  }

  final BaumDiagramm d;
  final DiagramStyle s;
  late final _T root;
  late final double padX;
  late final double padY;
  late final double gapX;
  late final double gapY;
  late final double indent;
  late _Mode mode;
  final all = <_T>[];

  @override
  late Size size;

  _T _build(BaumKnoten k, int depth) {
    final t = _T(k, depth, [for (final c in k.kinder) _build(c, depth + 1)]);
    all.add(t);
    return t;
  }

  TextStyle _labelStyle(_T t) => t.depth == 0
      ? s.title(size: 13, color: s.onAccent)
      : s.label(
          size: 12.5,
          weight: t.depth == 1 ? FontWeight.w700 : FontWeight.w500,
        );

  TextStyle _detailStyle(_T t) => s.numeric(
    size: 10.5,
    weight: FontWeight.w500,
    color: t.depth == 0 ? s.onAccent.withValues(alpha: 0.85) : s.muted,
  );

  /// Legt Text des Knotens für die Innenbreite [inner] aus; bei [fill]
  /// bekommt der Kasten die volle Breite, sonst die des Textes.
  Size _measure(_T t, double inner, {bool center = true}) {
    final align = center ? TextAlign.center : TextAlign.left;
    final ls = s.fit(t.k.label, _labelStyle(t), inner);
    t.label = s.text(t.k.label, ls, maxWidth: inner, align: align);
    t.detail = t.k.detail == null
        ? null
        : s.text(t.k.detail!, _detailStyle(t), maxWidth: inner, align: align);
    final w = math.max(t.label.width, t.detail?.width ?? 0) + 2 * padX;
    final h =
        t.label.height + (t.detail == null ? 0 : t.detail!.height) + 2 * padY;
    return Size(w, h);
  }

  // ------------------------------------------------------ 1: klassisch

  bool _tryTree(double maxW) {
    final maxBox = math.min(math.max(maxW * 0.34, s.sc(84)), s.sc(150));
    final sizes = <_T, Size>{};
    for (final t in all) {
      final sz = _measure(t, maxBox - 2 * padX);
      sizes[t] = sz;
    }
    double sub(_T t) {
      final own = sizes[t]!.width;
      if (t.kids.isEmpty) return t.subtree = own;
      var sum = 0.0;
      for (final c in t.kids) {
        sum += sub(c);
      }
      sum += gapX * (t.kids.length - 1);
      return t.subtree = math.max(own, sum);
    }

    if (sub(root) > maxW) return false;
    // Höhe je Ebene.
    final levelH = <int, double>{};
    for (final t in all) {
      levelH[t.depth] = math.max(levelH[t.depth] ?? 0, sizes[t]!.height);
    }
    final levelY = <int, double>{};
    var y = 0.0;
    final maxDepth = levelH.keys.fold(0, math.max);
    for (var dd = 0; dd <= maxDepth; dd++) {
      levelY[dd] = y;
      y += levelH[dd]! + gapY;
    }
    void place(_T t, double left) {
      final sz = sizes[t]!;
      if (t.kids.isEmpty) {
        t.box = Rect.fromLTWH(
          left + (t.subtree - sz.width) / 2,
          levelY[t.depth]!,
          sz.width,
          levelH[t.depth]!,
        );
        return;
      }
      var kidsW = gapX * (t.kids.length - 1);
      for (final c in t.kids) {
        kidsW += c.subtree;
      }
      var x = left + (t.subtree - kidsW) / 2;
      for (final c in t.kids) {
        place(c, x);
        x += c.subtree + gapX;
      }
      final cx = (t.kids.first.box.center.dx + t.kids.last.box.center.dx) / 2;
      t.box = Rect.fromLTWH(
        cx - sz.width / 2,
        levelY[t.depth]!,
        sz.width,
        levelH[t.depth]!,
      );
    }

    place(root, (maxW - root.subtree) / 2);
    mode = _Mode.tree;
    size = Size(maxW, y - gapY);
    return true;
  }

  // ----------------------------------------------------- 2: PSP-Spalten

  bool _tryColumns(double maxW) {
    final k = root.kids.length;
    if (k < 2) return false;
    final colW = (maxW - gapX * (k - 1)) / k;
    // Passt jedes Wort in seine Spalte?
    for (final t in all) {
      if (t.depth == 0) continue;
      final ind = indent * math.max(0, t.depth - 1);
      final need =
          ind +
          2 * padX +
          math.max(
            s.longestWord(t.k.label, _labelStyle(t)),
            t.k.detail == null
                ? 0.0
                : s.longestWord(t.k.detail!, _detailStyle(t)),
          );
      if (need > colW) return false;
    }
    final rootSz = _measure(root, math.min(maxW, s.sc(260)) - 2 * padX);
    root.box = Rect.fromLTWH(
      (maxW - rootSz.width) / 2,
      0,
      rootSz.width,
      rootSz.height,
    );
    var bottom = 0.0;
    for (var i = 0; i < k; i++) {
      final x0 = i * (colW + gapX);
      bottom = math.max(
        bottom,
        _stack(root.kids[i], x0, colW, 1, root.box.bottom + gapY),
      );
    }
    mode = _Mode.columns;
    size = Size(maxW, bottom);
    return true;
  }

  /// Stapelt den Teilbaum [t] eingerückt ab [y]; liefert die Unterkante.
  double _stack(_T t, double x0, double colW, int baseDepth, double y) {
    final ind = indent * (t.depth - baseDepth);
    final w = colW - ind;
    final sz = _measure(t, w - 2 * padX, center: t.depth == baseDepth);
    t.box = Rect.fromLTWH(x0 + ind, y, w, sz.height);
    var yy = t.box.bottom;
    for (final c in t.kids) {
      yy = _stack(c, x0, colW, baseDepth, yy + s.sc(6));
    }
    return yy;
  }

  // -------------------------------------------------- 3: eingerückt

  void _indented(double maxW) {
    // Breite mindestens so, dass das längste Wort jeder Ebene passt.
    var need = maxW;
    for (final t in all) {
      need = math.max(
        need,
        indent * t.depth + 2 * padX + s.longestWord(t.k.label, _labelStyle(t)),
      );
    }
    final bottom = _stack(root, 0, need, 0, 0);
    mode = _Mode.indented;
    size = Size(need, bottom);
  }

  // ------------------------------------------------------------ Zeichnen

  @override
  void paint(Canvas c) {
    final line = strokePaint(s.line, 1.2);
    switch (mode) {
      case _Mode.tree:
        for (final t in all) {
          _elbowDown(c, t, line);
        }
      case _Mode.columns:
        _elbowDown(c, root, line);
        for (final t in all) {
          if (t.depth >= 1) _spine(c, t, line);
        }
      case _Mode.indented:
        for (final t in all) {
          _spine(c, t, line);
        }
    }
    for (final t in all) {
      _box(c, t);
    }
  }

  /// Rechtwinklige Verbindung von oben zu den Kindern darunter.
  void _elbowDown(Canvas c, _T t, Paint p) {
    if (t.kids.isEmpty) return;
    final top = t.box.bottom;
    final kidTop = t.kids.first.box.top;
    final midY = top + (kidTop - top) / 2;
    c.drawLine(Offset(t.box.center.dx, top), Offset(t.box.center.dx, midY), p);
    final xs = [for (final k in t.kids) k.box.center.dx];
    c.drawLine(
      Offset(math.min(xs.reduce(math.min), t.box.center.dx), midY),
      Offset(math.max(xs.reduce(math.max), t.box.center.dx), midY),
      p,
    );
    for (final k in t.kids) {
      c.drawLine(
        Offset(k.box.center.dx, midY),
        Offset(k.box.center.dx, k.box.top),
        p,
      );
    }
  }

  /// Senkrechte Linie links mit Abzweigen zu den Kindern.
  void _spine(Canvas c, _T t, Paint p) {
    if (t.kids.isEmpty) return;
    final x = t.box.left + indent / 2;
    final lastY = t.kids.last.box.center.dy;
    c.drawLine(Offset(x, t.box.bottom), Offset(x, lastY), p);
    for (final k in t.kids) {
      c.drawLine(
        Offset(x, k.box.center.dy),
        Offset(k.box.left, k.box.center.dy),
        p,
      );
    }
  }

  void _box(Canvas c, _T t) {
    final rr = RRect.fromRectAndRadius(t.box, const Radius.circular(8));
    if (t.depth == 0) {
      c.drawRRect(rr, fillPaint(s.accent));
    } else if (t.depth == 1) {
      c.drawRRect(rr, fillPaint(s.accentBg));
      c.drawRRect(rr, strokePaint(s.accent, 1.2));
    } else {
      c.drawRRect(rr, fillPaint(s.surfaceAlt));
      c.drawRRect(rr, strokePaint(s.grid, 1));
    }
    final h = t.label.height + (t.detail?.height ?? 0);
    var y = t.box.center.dy - h / 2;
    final centered = t.label.textAlign == TextAlign.center;
    double x(TextPainter tp) =>
        centered ? t.box.center.dx - tp.width / 2 : t.box.left + padX;
    t.label.paint(c, Offset(x(t.label), y));
    y += t.label.height;
    t.detail?.paint(c, Offset(x(t.detail!), y));
  }
}
