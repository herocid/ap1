import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// Schichtenmodell (OSI, TCP/IP, Schichtenarchitektur) oder Pyramide
/// (Speicherhierarchie, Maslow).
DiagramLayout layoutStapel(StapelDiagramm d, DiagramStyle s, double w) =>
    d.pyramide ? _PyramidLayout(d, s, w) : _StackLayout(d, s, w);

/// Pfeilschiene am linken Rand mit Beschriftung oben und unten.
class _Rail {
  _Rail(this.s, StapelDiagramm d, double w) {
    if (d.oben != null) oben = s.text(d.oben!, s.small(), maxWidth: w);
    if (d.unten != null) unten = s.text(d.unten!, s.small(), maxWidth: w);
  }

  final DiagramStyle s;
  TextPainter? oben;
  TextPainter? unten;

  bool get present => oben != null || unten != null;
  double get width => present ? s.sc(14) + 8 : 0;
  double get topH => oben == null ? 0 : oben!.height + 6;
  double get bottomH => unten == null ? 0 : unten!.height + 6;

  void paint(Canvas c, double top, double bottom) {
    if (!present) return;
    final x = s.sc(14) / 2;
    oben?.paint(c, const Offset(0, 0));
    unten?.paint(c, Offset(0, bottom + 6));
    final p = strokePaint(s.muted, 1.3);
    final a = Offset(x, top + 2);
    final b = Offset(x, bottom - 2);
    c.drawLine(a, b, p);
    if (oben != null) drawHead(c, b, a, ArrowHead.filled, s.muted, size: 7);
    if (unten != null) drawHead(c, a, b, ArrowHead.filled, s.muted, size: 7);
  }
}

class _StackLayout extends DiagramLayout {
  _StackLayout(this.d, this.s, double maxW) {
    rail = _Rail(s, d, maxW);
    x0 = rail.width;
    final inner = maxW - x0;
    final n = d.ebenen.length;
    const padX = 10.0;
    var withBadge =
        n >= 2 && !d.ebenen.any((e) => RegExp(r'^\d').hasMatch(e.label));
    // Auf sehr schmalen Displays hat das Wort Vorrang vor der Nummer.
    if (withBadge) {
      final w = inner - 2 * padX - s.sc(22) - 10;
      withBadge = !d.ebenen.any(
        (e) => s.longestWord(e.label, s.fit(e.label, s.title(), w)) > w,
      );
    }
    numbered = withBadge;
    badge = numbered ? s.sc(22) : 0;
    final textX = padX + (numbered ? badge + 10 : 0);
    final textW = inner - textX - padX;

    final hasDetail = d.ebenen.any((e) => e.detail != null);
    // Zweispaltig, wenn Bezeichnung und Detail nebeneinander passen.
    var labelCol = 0.0;
    for (final e in d.ebenen) {
      labelCol = math.max(
        labelCol,
        s.text(e.label, s.title()).width.ceilToDouble() + 1,
      );
    }
    sideBySide =
        hasDetail && labelCol <= textW * 0.45 && textW - labelCol >= 110;
    var needW = maxW;
    for (final e in d.ebenen) {
      final lw = sideBySide ? labelCol : textW;
      final label = s.text(
        e.label,
        s.fit(e.label, s.title(), lw),
        maxWidth: lw,
      );
      needW = math.max(needW, x0 + textX + label.width + padX);
      TextPainter? detail;
      if (e.detail != null) {
        detail = s.text(
          e.detail!,
          s.label(size: 12, weight: FontWeight.w400, color: s.muted),
          maxWidth: sideBySide ? textW - labelCol - 12 : textW,
        );
      }
      labels.add(label);
      details.add(detail);
    }
    this.labelCol = labelCol;
    this.textX = textX;

    var y = rail.topH;
    top = y;
    for (var i = 0; i < n; i++) {
      final l = labels[i];
      final dt = details[i];
      final contentH = sideBySide
          ? math.max(l.height, dt?.height ?? 0)
          : l.height + (dt == null ? 0 : dt.height + 2);
      final h = math.max(contentH, badge) + 2 * s.sc(8);
      boxes.add(Rect.fromLTWH(x0, y, needW - x0, h));
      y += h + 4;
    }
    bottom = y - 4;
    size = Size(needW, bottom + rail.bottomH);
  }

  final StapelDiagramm d;
  final DiagramStyle s;
  late final _Rail rail;
  late final double x0;
  late final bool numbered;
  late final double badge;
  late final bool sideBySide;
  late final double labelCol;
  late final double textX;
  late final double top;
  late final double bottom;
  final labels = <TextPainter>[];
  final details = <TextPainter?>[];
  final boxes = <Rect>[];

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    rail.paint(c, top, bottom);
    final n = boxes.length;
    for (var i = 0; i < n; i++) {
      final r = boxes[i];
      final rr = RRect.fromRectAndRadius(r, const Radius.circular(8));
      c.drawRRect(rr, fillPaint(s.surfaceAlt));
      c.drawRRect(rr, strokePaint(s.grid, 1));
      // Farbiger Rand links als Ebenenmarke.
      c.save();
      c.clipRRect(rr);
      c.drawRect(
        Rect.fromLTWH(r.left, r.top, 4, r.height),
        fillPaint(s.accent),
      );
      c.restore();

      final l = labels[i];
      final dt = details[i];
      if (numbered) {
        final center = Offset(r.left + 10 + badge / 2, r.center.dy);
        c.drawCircle(center, badge / 2, fillPaint(s.accent));
        final num = s.text(
          '${n - i}',
          s.numeric(size: 12, color: s.onAccent, weight: FontWeight.w700),
        );
        num.paint(c, center - Offset(num.width / 2, num.height / 2));
      }
      final tx = r.left + textX;
      if (sideBySide) {
        l.paint(c, Offset(tx, r.center.dy - l.height / 2));
        if (dt != null) {
          final dx = tx + labelCol + 12;
          c.drawLine(
            Offset(dx - 6, r.top + 6),
            Offset(dx - 6, r.bottom - 6),
            strokePaint(s.grid, 1),
          );
          dt.paint(c, Offset(dx, r.center.dy - dt.height / 2));
        }
      } else {
        final h = l.height + (dt == null ? 0 : dt.height + 2);
        final y = r.center.dy - h / 2;
        l.paint(c, Offset(tx, y));
        dt?.paint(c, Offset(tx, y + l.height + 2));
      }
    }
  }
}

class _PyramidLayout extends DiagramLayout {
  _PyramidLayout(this.d, this.s, double maxW) {
    rail = _Rail(s, d, maxW);
    final x0 = rail.width;
    final avail = maxW - x0;
    final n = d.ebenen.length;
    final hasDetail = d.ebenen.any((e) => e.detail != null);
    detailsRight = hasDetail && avail >= 300;
    final pyrW = detailsRight ? avail * 0.56 : avail;
    final detailW = avail - pyrW - 12;
    final pad = s.sc(10);

    // Spitze so breit wählen, dass das längste Wort der obersten Ebene passt.
    var topFrac = 0.26;
    double bandTop(int i) => pyrW * (topFrac + (1 - topFrac) * i / n);
    final detailStyle = s.label(
      size: 11.5,
      weight: FontWeight.w400,
      color: s.muted,
    );
    for (var tries = 0; tries < 30; tries++) {
      var ok = true;
      for (var i = 0; i < n; i++) {
        final e = d.ebenen[i];
        final need = math.max(
          s.longestWord(e.label, s.title()),
          (!detailsRight && e.detail != null)
              ? s.longestWord(e.detail!, detailStyle)
              : 0.0,
        );
        if (need > bandTop(i) - 2 * pad) ok = false;
      }
      if (ok || topFrac >= 0.9) break;
      topFrac += 0.03;
    }
    this.topFrac = topFrac;

    var bandH = s.sc(30);
    for (var i = 0; i < n; i++) {
      final e = d.ebenen[i];
      final w = bandTop(i) - 2 * pad;
      final l = s.text(
        e.label,
        s.title(),
        maxWidth: w,
        align: TextAlign.center,
      );
      TextPainter? dt;
      if (e.detail != null) {
        dt = detailsRight
            ? s.text(e.detail!, detailStyle, maxWidth: detailW)
            : s.text(
                e.detail!,
                detailStyle,
                maxWidth: w,
                align: TextAlign.center,
              );
      }
      labels.add(l);
      details.add(dt);
      final inner = detailsRight
          ? math.max(l.height, dt?.height ?? 0)
          : l.height + (dt == null ? 0 : dt.height + 1);
      bandH = math.max(bandH, inner + 2 * s.sc(7));
    }
    this.bandH = bandH;
    this.x0 = x0;
    this.pyrW = pyrW;
    top = rail.topH;
    bottom = top + n * bandH + (n - 1) * 3;
    size = Size(maxW, bottom + rail.bottomH);
  }

  final StapelDiagramm d;
  final DiagramStyle s;
  late final _Rail rail;
  late final bool detailsRight;
  late final double topFrac;
  late final double bandH;
  late final double x0;
  late final double pyrW;
  late final double top;
  late final double bottom;
  final labels = <TextPainter>[];
  final details = <TextPainter?>[];

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    rail.paint(c, top, bottom);
    final n = labels.length;
    final cx = x0 + pyrW / 2;
    // Durchgehende Flanke: die Breite hängt linear von der Höhe ab.
    final totalH = bottom - top;
    double widthAt(double y) =>
        pyrW * (topFrac + (1 - topFrac) * ((y - top) / totalH));
    for (var i = 0; i < n; i++) {
      final y0 = top + i * (bandH + 3);
      final y1 = y0 + bandH;
      final w0 = widthAt(y0);
      final w1 = widthAt(y1);
      final path = Path()
        ..moveTo(cx - w0 / 2, y0)
        ..lineTo(cx + w0 / 2, y0)
        ..lineTo(cx + w1 / 2, y1)
        ..lineTo(cx - w1 / 2, y1)
        ..close();
      // Nach oben kräftiger: die Spitze ist das Knappe/Wertvolle.
      final t = n == 1 ? 1.0 : 1 - i / (n - 1);
      c.drawPath(
        path,
        fillPaint(Color.lerp(s.accentBg, s.accent, 0.08 + 0.22 * t)!),
      );
      c.drawPath(path, strokePaint(s.accent, 1.2));
      final l = labels[i];
      final dt = details[i];
      final ymid = (y0 + y1) / 2;
      if (detailsRight) {
        l.paint(c, Offset(cx - l.width / 2, ymid - l.height / 2));
        if (dt != null) {
          final dx = x0 + pyrW + 12;
          c.drawLine(
            Offset(cx + (w0 + w1) / 4 + 4, ymid),
            Offset(dx - 4, ymid),
            strokePaint(s.grid, 1),
          );
          dt.paint(c, Offset(dx, ymid - dt.height / 2));
        }
      } else {
        final h = l.height + (dt == null ? 0 : dt.height + 1);
        final y = ymid - h / 2;
        l.paint(c, Offset(cx - l.width / 2, y));
        dt?.paint(c, Offset(cx - dt.width / 2, y + l.height + 1));
      }
    }
  }
}
