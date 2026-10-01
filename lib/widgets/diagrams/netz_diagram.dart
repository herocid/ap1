import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';
import 'netz_icons.dart';

/// Netzwerkskizze auf einem Raster: Symbol und Beschriftung je Gerät,
/// Kabel durchgezogen, Funk gestrichelt, Zonen (DMZ, LAN, VLAN) als
/// gestrichelte Rahmen mit Titel auf der Rahmenlinie.
DiagramLayout layoutNetz(NetzSkizze d, DiagramStyle s, double w) =>
    fitToWidth(_NetzLayout(d, s, w), w);

class _N {
  _N(this.k, this.label);
  final NetzKnoten k;
  final TextPainter label;
  late Rect icon;
  late Rect labelRect;
  late Rect plate;
  late Color bg;
}

class _NetzLayout extends DiagramLayout {
  _NetzLayout(this.d, this.s, double maxW) {
    final labelStyle = s.label(size: 11.5, weight: FontWeight.w600);
    zoneStyle = s.label(size: 11, weight: FontWeight.w700, color: s.muted);
    var minX = double.infinity;
    var maxX = -double.infinity;
    var minY = double.infinity;
    var maxY = -double.infinity;
    for (final k in d.knoten) {
      minX = math.min(minX, k.x);
      maxX = math.max(maxX, k.x);
      minY = math.min(minY, k.y);
      maxY = math.max(maxY, k.y);
    }
    for (final z in d.zonen) {
      minX = math.min(minX, math.min(z.x0, z.x1));
      maxX = math.max(maxX, math.max(z.x0, z.x1));
      minY = math.min(minY, math.min(z.y0, z.y1));
      maxY = math.max(maxY, math.max(z.y0, z.y1));
    }
    if (minX == double.infinity) {
      minX = maxX = minY = maxY = 0;
    }
    this.minX = minX;
    this.minY = minY;
    final cols = maxX - minX + 1;

    // Spaltenbreite: gleichmäßig, aber jedes Wort der Beschriftung passt.
    var cellW = maxW / cols;
    // Eine Schriftgröße für alle Geräte - notfalls leicht verkleinert.
    var fitted = labelStyle;
    for (final k in d.knoten) {
      final f = s.fit(k.label, labelStyle, cellW - 6);
      if ((f.fontSize ?? 0) < (fitted.fontSize ?? 0)) fitted = f;
    }
    final styles = {for (final k in d.knoten) k.id: fitted};
    var minCell = s.sc(52);
    for (final k in d.knoten) {
      minCell = math.max(minCell, s.longestWord(k.label, styles[k.id]!) + 6);
    }
    cellW = math.max(cellW, minCell);
    this.cellW = cellW;
    width = cellW * cols;
    iconS = math.min(s.sc(34), cellW * 0.6);

    var labelH = 0.0;
    for (final k in d.knoten) {
      final tp = s.text(
        k.label,
        styles[k.id]!,
        maxWidth: cellW - 6,
        align: TextAlign.center,
      );
      nodes.add(_N(k, tp));
      labelH = math.max(labelH, tp.height);
    }
    contentH = iconS + 4 + labelH;
    final hasZones = d.zonen.isNotEmpty;
    zoneLabelH = s.text('Ag', zoneStyle).height;
    zoneMargin = s.sc(9);
    gapY = hasZones
        ? math.max(s.sc(34), 2 * zoneMargin + zoneLabelH + 8)
        : s.sc(30);
    cellH = contentH + gapY;
    topPad = hasZones ? zoneMargin + zoneLabelH / 2 + 2 : 2;

    final zoneBg = Color.alphaBlend(
      s.surfaceAlt.withValues(alpha: 0.5),
      s.surface,
    );
    for (final n in nodes) {
      final c = Offset(_px(n.k.x), _py(n.k.y) + iconS / 2);
      n.icon = Rect.fromCenter(center: c, width: iconS, height: iconS);
      n.labelRect = Rect.fromLTWH(
        c.dx - n.label.width / 2,
        n.icon.bottom + 4,
        n.label.width,
        n.label.height,
      );
      n.plate = n.icon.inflate(3).expandToInclude(n.labelRect.inflate(2));
      final inZone = d.zonen.any(
        (z) =>
            n.k.x >= math.min(z.x0, z.x1) &&
            n.k.x <= math.max(z.x0, z.x1) &&
            n.k.y >= math.min(z.y0, z.y1) &&
            n.k.y <= math.max(z.y0, z.y1),
      );
      n.bg = inZone ? zoneBg : s.surface;
    }
    for (final n in nodes) {
      byId[n.k.id] = n;
    }
    final linkStyle = s.label(
      size: 10.5,
      weight: FontWeight.w500,
      color: s.muted,
    );
    for (final v in d.verbindungen) {
      links.add(
        v.label == null ? null : s.text(v.label!, linkStyle, maxWidth: cellW),
      );
    }
    for (final z in d.zonen) {
      zoneLabels.add(s.text(z.label, zoneStyle, maxWidth: width));
    }
    final bottom = _py(maxY) + contentH + (hasZones ? zoneMargin + 2 : 2);
    size = Size(width, bottom);
  }

  final NetzSkizze d;
  final DiagramStyle s;
  late final TextStyle zoneStyle;
  late final double minX;
  late final double minY;
  late final double cellW;
  late final double width;
  late final double iconS;
  late final double contentH;
  late final double zoneLabelH;
  late final double zoneMargin;
  late final double gapY;
  late final double cellH;
  late final double topPad;
  final nodes = <_N>[];
  final byId = <String, _N>{};
  final links = <TextPainter?>[];
  final zoneLabels = <TextPainter>[];

  @override
  late final Size size;

  double _px(double x) => (x - minX + 0.5) * cellW;
  double _py(double y) => topPad + (y - minY) * cellH;

  @override
  void paint(Canvas c) {
    // Zonen.
    for (var i = 0; i < d.zonen.length; i++) {
      final z = d.zonen[i];
      final x0 = math.min(z.x0, z.x1);
      final x1 = math.max(z.x0, z.x1);
      final y0 = math.min(z.y0, z.y1);
      final y1 = math.max(z.y0, z.y1);
      final r = Rect.fromLTRB(
        _px(x0) - cellW / 2 + 3,
        _py(y0) - zoneMargin,
        _px(x1) + cellW / 2 - 3,
        _py(y1) + contentH + zoneMargin,
      );
      final rr = RRect.fromRectAndRadius(r, const Radius.circular(10));
      c.drawRRect(rr, fillPaint(s.surfaceAlt.withValues(alpha: 0.5)));
      c.drawPath(
        dashPath(Path()..addRRect(rr), dash: 6, gap: 4),
        strokePaint(s.muted, 1.2),
      );
      final tp = zoneLabels[i];
      paintLabel(
        c,
        tp,
        Offset(r.left + 12, r.top - tp.height / 2),
        s.surface,
        padX: 5,
        padY: 0,
      );
    }
    // Verbindungen.
    for (var i = 0; i < d.verbindungen.length; i++) {
      final v = d.verbindungen[i];
      final a = byId[v.a];
      final b = byId[v.b];
      if (a == null || b == null) continue;
      final p0 = a.icon.center;
      final p1 = b.icon.center;
      if (v.funk) {
        drawDashedLine(c, p0, p1, strokePaint(s.info, 1.8), dash: 5, gap: 4);
      } else {
        c.drawLine(p0, p1, strokePaint(s.line, 1.8));
      }
    }
    // Geräte: eine Fläche in Hintergrundfarbe unter Symbol und Name
    // verdeckt die Linienenden.
    for (final n in nodes) {
      c.drawRRect(
        RRect.fromRectAndRadius(n.plate, const Radius.circular(6)),
        fillPaint(n.bg),
      );
      paintNetzIcon(c, n.k.typ, n.icon, s);
      n.label.paint(c, n.labelRect.topLeft);
    }
    // Beschriftungen der Verbindungen: mittig auf dem sichtbaren Stück.
    for (var i = 0; i < d.verbindungen.length; i++) {
      final tp = links[i];
      if (tp == null) continue;
      final v = d.verbindungen[i];
      final a = byId[v.a];
      final b = byId[v.b];
      if (a == null || b == null) continue;
      final p0 = a.icon.center;
      final p1 = b.icon.center;
      final t0 = _exitT(p0, p1, a.plate);
      final t1 = 1 - _exitT(p1, p0, b.plate);
      final mid = Offset.lerp(p0, p1, (t0 + t1) / 2)!;
      final dx = (p1.dx - p0.dx).abs();
      final dy = (p1.dy - p0.dy).abs();
      Offset pos;
      if (dy < 1) {
        pos = Offset(mid.dx - tp.width / 2, mid.dy - tp.height - 3);
      } else if (dx < 1) {
        // Rechts neben die Linie, am rechten Rand links daneben.
        pos = mid.dx + 6 + tp.width + 3 <= size.width
            ? Offset(mid.dx + 6, mid.dy - tp.height / 2)
            : Offset(mid.dx - 6 - tp.width, mid.dy - tp.height / 2);
      } else {
        pos = mid - Offset(tp.width / 2, tp.height / 2);
      }
      pos = Offset(
        pos.dx.clamp(3.0, math.max(3.0, size.width - tp.width - 3)),
        pos.dy,
      );
      paintLabel(c, tp, pos, s.surface, padX: 3, padY: 0);
    }
  }

  /// Anteil der Strecke p0->p1, an dem sie das Rechteck r (in dem p0
  /// liegt) verlässt.
  static double _exitT(Offset p0, Offset p1, Rect r) {
    final d = p1 - p0;
    var t = 1.0;
    if (d.dx > 0) t = math.min(t, (r.right - p0.dx) / d.dx);
    if (d.dx < 0) t = math.min(t, (r.left - p0.dx) / d.dx);
    if (d.dy > 0) t = math.min(t, (r.bottom - p0.dy) / d.dy);
    if (d.dy < 0) t = math.min(t, (r.top - p0.dy) / d.dy);
    return t.clamp(0.0, 1.0);
  }
}
