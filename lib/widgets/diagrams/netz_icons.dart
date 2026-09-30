import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_style.dart';

/// Gezeichnete Netzwerksymbole im Stil von Lehrbuch-Skizzen - einheitlich
/// in Strichstärke und Farbe, unabhängig von Icon-Schriften.
void paintNetzIcon(Canvas c, NetzTyp typ, Rect r, DiagramStyle s) {
  final (stroke, fill) = switch (typ) {
    NetzTyp.firewall => (s.hot, s.hotBg),
    NetzTyp.internet || NetzTyp.cloud => (s.info, s.infoBg),
    NetzTyp.router ||
    NetzTyp.switch_ ||
    NetzTyp.accessPoint => (s.accent, s.accentBg),
    _ => (s.ink, s.surfaceAlt),
  };
  final w = r.width;
  final sw = math.max(1.3, w / 22);
  final p = strokePaint(stroke, sw);
  final f = fillPaint(fill);
  Offset at(double x, double y) => Offset(r.left + x * w, r.top + y * r.height);
  Rect box(double l, double t, double rr, double b) => Rect.fromLTRB(
    r.left + l * w,
    r.top + t * r.height,
    r.left + rr * w,
    r.top + b * r.height,
  );

  switch (typ) {
    case NetzTyp.internet:
      final cc = r.center;
      final rad = w * 0.44;
      c.drawCircle(cc, rad, f);
      c.drawCircle(cc, rad, p);
      c.drawOval(
        Rect.fromCenter(center: cc, width: rad * 0.95, height: rad * 2),
        p,
      );
      c.drawLine(Offset(cc.dx - rad, cc.dy), Offset(cc.dx + rad, cc.dy), p);
      c.drawLine(cc - Offset(0, rad), cc + Offset(0, rad), p);
      final dy = rad * 0.5;
      final dx = math.sqrt(rad * rad - dy * dy);
      c.drawLine(
        Offset(cc.dx - dx, cc.dy - dy),
        Offset(cc.dx + dx, cc.dy - dy),
        p,
      );
      c.drawLine(
        Offset(cc.dx - dx, cc.dy + dy),
        Offset(cc.dx + dx, cc.dy + dy),
        p,
      );
    case NetzTyp.cloud:
      final path = Path()
        ..moveTo(at(0.22, 0.78).dx, at(0.22, 0.78).dy)
        ..arcToPoint(at(0.18, 0.46), radius: Radius.circular(w * 0.17))
        ..arcToPoint(at(0.44, 0.26), radius: Radius.circular(w * 0.2))
        ..arcToPoint(at(0.8, 0.38), radius: Radius.circular(w * 0.22))
        ..arcToPoint(at(0.82, 0.78), radius: Radius.circular(w * 0.2))
        ..close();
      c.drawPath(path, f);
      c.drawPath(path, p);
    case NetzTyp.router:
      final cc = r.center;
      final rad = w * 0.44;
      c.drawCircle(cc, rad, f);
      c.drawCircle(cc, rad, p);
      // Vier Pfeile: zwei hinein, zwei hinaus (Cisco-Router).
      final a = rad * 0.72;
      final i = rad * 0.18;
      for (final (dx, dy, out) in const [
        (-1.0, -1.0, false),
        (1.0, 1.0, false),
        (1.0, -1.0, true),
        (-1.0, 1.0, true),
      ]) {
        final u = Offset(dx, dy) / math.sqrt2;
        final from = cc + u * (out ? i : a);
        final to = cc + u * (out ? a : i);
        c.drawLine(from, to, p);
        drawHead(
          c,
          from,
          to,
          ArrowHead.open,
          stroke,
          size: w * 0.14,
          strokeWidth: sw,
        );
      }
    case NetzTyp.firewall:
      final b = box(0.08, 0.18, 0.92, 0.84);
      c.drawRect(b, f);
      c.drawRect(b, p);
      final rows = 4;
      final rh = b.height / rows;
      for (var k = 1; k < rows; k++) {
        c.drawLine(
          Offset(b.left, b.top + k * rh),
          Offset(b.right, b.top + k * rh),
          p,
        );
      }
      for (var k = 0; k < rows; k++) {
        final offs = k.isEven ? [0.33, 0.66] : [0.17, 0.5, 0.83];
        for (final o in offs) {
          final x = b.left + o * b.width;
          c.drawLine(
            Offset(x, b.top + k * rh),
            Offset(x, b.top + (k + 1) * rh),
            p,
          );
        }
      }
    case NetzTyp.switch_:
      final b = box(0.04, 0.28, 0.96, 0.72);
      final rr = RRect.fromRectAndRadius(b, Radius.circular(w * 0.06));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      final y1 = b.top + b.height * 0.33;
      final y2 = b.top + b.height * 0.67;
      final l = b.left + b.width * 0.18;
      final rgt = b.right - b.width * 0.18;
      c.drawLine(Offset(l, y1), Offset(rgt, y1), p);
      drawHead(
        c,
        Offset(l, y1),
        Offset(rgt, y1),
        ArrowHead.open,
        stroke,
        size: w * 0.12,
        strokeWidth: sw,
      );
      c.drawLine(Offset(rgt, y2), Offset(l, y2), p);
      drawHead(
        c,
        Offset(rgt, y2),
        Offset(l, y2),
        ArrowHead.open,
        stroke,
        size: w * 0.12,
        strokeWidth: sw,
      );
    case NetzTyp.accessPoint:
      final b = box(0.16, 0.62, 0.84, 0.86);
      final rr = RRect.fromRectAndRadius(b, Radius.circular(w * 0.06));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      final base = at(0.5, 0.62);
      final tip = at(0.5, 0.34);
      c.drawLine(base, tip, p);
      for (final k in [0.16, 0.3]) {
        final rad = w * k;
        c.drawArc(
          Rect.fromCircle(center: tip, radius: rad),
          -math.pi * 0.8,
          math.pi * 0.6,
          false,
          p,
        );
      }
      c.drawCircle(at(0.3, 0.74), sw * 0.9, fillPaint(stroke));
    case NetzTyp.server:
      final b = box(0.24, 0.06, 0.76, 0.94);
      final rr = RRect.fromRectAndRadius(b, Radius.circular(w * 0.05));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      for (final y in [0.3, 0.52]) {
        c.drawLine(at(0.24, y), at(0.76, y), p);
      }
      for (final y in [0.18, 0.41]) {
        c.drawLine(at(0.34, y), at(0.56, y), p);
      }
      c.drawCircle(at(0.5, 0.76), w * 0.05, fillPaint(stroke));
    case NetzTyp.pc:
      final b = box(0.08, 0.1, 0.92, 0.66);
      final rr = RRect.fromRectAndRadius(b, Radius.circular(w * 0.05));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      c.drawLine(at(0.5, 0.66), at(0.5, 0.82), p);
      c.drawLine(at(0.3, 0.86), at(0.7, 0.86), p);
    case NetzTyp.laptop:
      final b = box(0.16, 0.2, 0.84, 0.66);
      final rr = RRect.fromRectAndRadius(b, Radius.circular(w * 0.04));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      final base = Path()
        ..moveTo(at(0.16, 0.7).dx, at(0.16, 0.7).dy)
        ..lineTo(at(0.84, 0.7).dx, at(0.84, 0.7).dy)
        ..lineTo(at(0.96, 0.82).dx, at(0.96, 0.82).dy)
        ..lineTo(at(0.04, 0.82).dx, at(0.04, 0.82).dy)
        ..close();
      c.drawPath(base, f);
      c.drawPath(base, p);
    case NetzTyp.smartphone:
      final b = box(0.3, 0.06, 0.7, 0.94);
      final rr = RRect.fromRectAndRadius(b, Radius.circular(w * 0.07));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      c.drawLine(at(0.44, 0.84), at(0.56, 0.84), p);
    case NetzTyp.drucker:
      final paper = box(0.28, 0.08, 0.72, 0.4);
      c.drawRect(paper, fillPaint(s.surface));
      c.drawRect(paper, p);
      final body = box(0.08, 0.36, 0.92, 0.74);
      final rr = RRect.fromRectAndRadius(body, Radius.circular(w * 0.06));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      final out = box(0.24, 0.64, 0.76, 0.9);
      c.drawRect(out, fillPaint(s.surface));
      c.drawRect(out, p);
      c.drawCircle(at(0.78, 0.47), sw * 0.9, fillPaint(stroke));
    case NetzTyp.nas:
      final b = box(0.14, 0.12, 0.86, 0.88);
      final rr = RRect.fromRectAndRadius(b, Radius.circular(w * 0.06));
      c.drawRRect(rr, f);
      c.drawRRect(rr, p);
      for (final y in [0.3, 0.52]) {
        final slot = RRect.fromRectAndRadius(
          box(0.26, y - 0.07, 0.74, y + 0.07),
          Radius.circular(w * 0.03),
        );
        c.drawRRect(slot, p);
      }
      c.drawCircle(at(0.32, 0.75), sw * 0.9, fillPaint(stroke));
      c.drawCircle(at(0.46, 0.75), sw * 0.9, fillPaint(stroke));
  }
}
