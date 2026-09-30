import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';

/// UML-Anwendungsfalldiagramm: Strichmännchen links, Systemgrenze mit
/// Titel, Anwendungsfälle als Ellipsen. Eingebundene bzw. erweiternde
/// Fälle stehen - wenn Platz ist - in einer zweiten Spalte neben ihrem
/// Basisfall, verbunden mit gestrichelten «include»/«extend»-Pfeilen.
DiagramLayout layoutUseCase(UseCaseDiagramm d, DiagramStyle s, double w) =>
    _UseCaseLayout(d, s, w);

class _Case {
  _Case(this.i);
  final int i;
  late TextPainter text;
  Rect rect = Rect.zero;
  int col = 0;
  int slot = 0; // Position in der Spalte
}

class _Actor {
  _Actor(this.a, this.name);
  final UcAkteur a;
  final TextPainter name;
  double cy = 0;
}

class _UseCaseLayout extends DiagramLayout {
  _UseCaseLayout(this.d, this.s, double maxW) {
    final caseStyle = s.label(size: 12, weight: FontWeight.w500);
    final actorStyle = s.label(size: 11.5, weight: FontWeight.w600);
    final n = d.faelle.length;
    cases = [for (var i = 0; i < n; i++) _Case(i)];

    // Akteursspalte: schmal halten, lange Namen notfalls etwas kleiner.
    final colTarget = math.min(s.sc(84), maxW * 0.26);
    var natural = 0.0;
    var longest = 0.0;
    final styles = <TextStyle>[];
    for (final a in d.akteure) {
      final st = s.fit(a.name, actorStyle, colTarget);
      styles.add(st);
      natural = math.max(natural, s.text(a.name, st).width);
      longest = math.max(longest, s.longestWord(a.name, st));
    }
    figW = s.sc(28);
    actorW = [
      figW,
      longest,
      math.min(natural, colTarget),
    ].reduce(math.max).ceilToDouble();
    for (var k = 0; k < d.akteure.length; k++) {
      final a = d.akteure[k];
      actors.add(
        _Actor(
          a,
          s.text(a.name, styles[k], maxWidth: actorW, align: TextAlign.center),
        ),
      );
    }
    final boxX = actorW + s.sc(14);
    pad = s.sc(8);
    title = s.text(
      d.system,
      s.title(size: 12.5),
      maxWidth: math.max(40, maxW - boxX - 2 * pad),
    );

    // Primär: mit Akteur verbunden oder Basisfall. Sekundär: nur über
    // include/extend erreichbar.
    final withActor = <int>{for (final a in d.akteure) ...a.faelle};
    final secondary = <int>{};
    for (final r in d.beziehungen) {
      final inner = r.art == UcArt.include ? r.zu : r.von;
      if (inner >= 0 && inner < n && !withActor.contains(inner)) {
        secondary.add(inner);
      }
    }

    final innerW = maxW - boxX - 2 * pad;
    tagStyle = s.label(size: 10.5, weight: FontWeight.w500, color: s.muted);
    final tagSize = s.text('«include»', tagStyle);
    tagH = tagSize.height;
    final colGap = math.max(s.sc(26), tagSize.width + 14);
    // Zweispaltig nur, wenn jede Beziehung einen Basisfall mit einem
    // sekundären Fall verbindet - sonst kreuzten Pfeile die Spalten.
    final twoCol =
        secondary.isNotEmpty &&
        secondary.length < n &&
        d.beziehungen.every(
          (r) => secondary.contains(r.von) != secondary.contains(r.zu),
        ) &&
        _fits((innerW - colGap) / 2, caseStyle);

    // Eine Spalte: sekundäre Fälle direkt bei ihrem Basisfall (erweiternde
    // darüber, eingebundene darunter), etwas eingerückt - so laufen die
    // Linien der Akteure links an ihnen vorbei.
    final ordered = <int>[];
    for (final c in cases) {
      if (secondary.contains(c.i)) continue;
      final above = <int>[];
      final below = <int>[];
      for (final r in d.beziehungen) {
        final other = r.von == c.i ? r.zu : (r.zu == c.i ? r.von : -1);
        if (other < 0 ||
            !secondary.contains(other) ||
            ordered.contains(other)) {
          continue;
        }
        if (above.contains(other) || below.contains(other)) continue;
        (r.art == UcArt.extend && above.isEmpty ? above : below).add(other);
      }
      ordered
        ..addAll(above)
        ..add(c.i)
        ..addAll(below);
    }
    for (final i in secondary) {
      if (!ordered.contains(i)) ordered.add(i);
    }
    // Bögen für Pfeile zwischen nicht benachbarten Fällen.
    if (!twoCol) {
      final spans = <(int, int)>[];
      for (var ri = 0; ri < d.beziehungen.length; ri++) {
        final r = d.beziehungen[ri];
        final a = ordered.indexOf(r.von);
        final b = ordered.indexOf(r.zu);
        if (a >= 0 && b >= 0 && (a - b).abs() != 1) {
          spans.add((ri, (a - b).abs()));
        }
      }
      spans.sort((p, q) => p.$2.compareTo(q.$2));
      for (var k = 0; k < spans.length; k++) {
        arcLane[spans[k].$1] = k;
      }
    }
    final arcs = arcLane.length;
    // Beschriftung steht gedreht AUF der Spur (mit Hintergrund).
    arcBase = s.sc(8) + tagH / 2;
    arcStep = tagH + 4;
    // Die Spuren liegen im rechten Innenrand der Systemgrenze.
    final reserve = arcs == 0
        ? 0.0
        : math.max(0.0, arcBase + (arcs - 1) * arcStep + tagH / 2 + 3 - pad);
    var indentFrac = secondary.isEmpty || twoCol ? 0.0 : 0.16;
    final minCw = s.sc(80);
    if ((innerW - reserve) / (1 + indentFrac) < minCw) indentFrac = 0.06;
    final cw = twoCol
        ? (innerW - colGap) / 2
        : math.min(
            math.max((innerW - reserve) / (1 + indentFrac), minCw),
            s.sc(220),
          );
    final indent = cw * indentFrac;

    for (final c in cases) {
      final tw = math.max(
        (cw - 10) * _k,
        s.longestWord(d.faelle[c.i], caseStyle),
      );
      c.text = s.text(
        d.faelle[c.i],
        caseStyle,
        maxWidth: tw,
        align: TextAlign.center,
      );
      final a = math.max(cw / 2, c.text.width / (2 * _k) + 5);
      final ratio = (c.text.width / (2 * a)).clamp(0.0, 0.9);
      final b = (c.text.height / 2) / math.sqrt(1 - ratio * ratio) + s.sc(6);
      c.rect = Rect.fromLTWH(0, 0, 2 * a, 2 * b);
    }

    final top = title.height + 2 * pad;
    final vgap = s.sc(14);
    final col0X = boxX + pad;
    final col1X = col0X + cw + colGap;
    if (twoCol) {
      // Links die Basisfälle, rechts die sekundären - jeweils auf Höhe
      // des Mittels ihrer Basisfälle, ohne sich zu überlappen.
      var yl = top;
      var slot0 = 0;
      for (final c in cases) {
        if (secondary.contains(c.i)) continue;
        c.col = 0;
        c.slot = slot0++;
        c.rect = Rect.fromLTWH(col0X, yl, c.rect.width, c.rect.height);
        yl = c.rect.bottom + vgap;
      }
      final want = <int, double>{};
      for (final i in secondary) {
        final ys = [
          for (final r in d.beziehungen)
            if (r.von == i && !secondary.contains(r.zu))
              cases[r.zu].rect.center.dy
            else if (r.zu == i && !secondary.contains(r.von))
              cases[r.von].rect.center.dy,
        ];
        want[i] = ys.isEmpty ? top : ys.reduce((a, b) => a + b) / ys.length;
      }
      final order = [...secondary]
        ..sort((a, b) => want[a]!.compareTo(want[b]!));
      var yr = top;
      for (var k = 0; k < order.length; k++) {
        final sc = cases[order[k]];
        sc.col = 1;
        sc.slot = k;
        final y = math.max(yr, want[order[k]]! - sc.rect.height / 2);
        sc.rect = Rect.fromLTWH(col1X, y, sc.rect.width, sc.rect.height);
        yr = sc.rect.bottom + vgap;
      }
      contentBottom = math.max(yl, yr) - vgap;
    } else {
      var y = top;
      for (var k = 0; k < ordered.length; k++) {
        final c = cases[ordered[k]];
        c.col = 0;
        c.slot = k;
        final x = col0X + (secondary.contains(c.i) ? indent : 0);
        c.rect = Rect.fromLTWH(x, y, c.rect.width, c.rect.height);
        y = c.rect.bottom + math.max(s.sc(20), tagH + 8);
      }
      contentBottom = y - math.max(s.sc(20), tagH + 8);
    }

    // Akteure auf Höhe ihrer Fälle, ohne Überlappung.
    final figH = s.sc(44);
    for (final a in actors) {
      final ys = [
        for (final i in a.a.faelle)
          if (i >= 0 && i < n) cases[i].rect.center.dy,
      ];
      a.cy = ys.isEmpty
          ? top + figH / 2
          : ys.reduce((p, q) => p + q) / ys.length;
    }
    final sorted = [...actors]..sort((p, q) => p.cy.compareTo(q.cy));
    var minY = top;
    for (final a in sorted) {
      final h = figH + 4 + a.name.height;
      final t = math.max(minY, a.cy - figH / 2);
      a.cy = t + figH / 2;
      minY = t + h + s.sc(14);
    }
    final actorsBottom = sorted.isEmpty ? 0.0 : minY - s.sc(14);
    this.figH = figH;
    this.boxX = boxX;

    var right = 0.0;
    for (final c in cases) {
      right = math.max(right, c.rect.right);
    }
    casesRight = right;
    right += reserve;
    // Ein langes Einzelwort im Systemnamen kann breiter als maxW sein.
    boxRight = math.max(
      math.max(maxW, right + pad),
      boxX + title.width + 2 * pad + 1,
    );
    boxBottom = contentBottom + pad;
    size = Size(boxRight, math.max(boxBottom, actorsBottom) + 1);
  }

  /// Anteil der Ellipsenbreite, den der Text nutzen darf.
  static const _k = 0.84;

  bool _fits(double cw, TextStyle st) {
    for (final f in d.faelle) {
      if (s.longestWord(f, st) > (cw - 10) * _k) return false;
    }
    return cw >= s.sc(92);
  }

  final UseCaseDiagramm d;
  final DiagramStyle s;
  late final List<_Case> cases;
  final actors = <_Actor>[];
  late final TextPainter title;
  late final double actorW;
  late final double figW;
  late final double figH;
  late final double pad;
  late final TextStyle tagStyle;
  late final double tagH;
  late final double arcBase;
  late final double arcStep;
  late final double casesRight;

  /// Beziehungsindex -> Spur des Umwegs (nur nicht benachbarte Fälle).
  final arcLane = <int, int>{};
  late final double boxX;
  late final double boxRight;
  late final double boxBottom;
  late final double contentBottom;

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    // Systemgrenze.
    final sys = Rect.fromLTRB(boxX, 0.5, boxRight - 0.5, boxBottom);
    c.drawRRect(
      RRect.fromRectAndRadius(sys, const Radius.circular(6)),
      fillPaint(s.surfaceAlt.withValues(alpha: 0.45)),
    );
    c.drawRRect(
      RRect.fromRectAndRadius(sys, const Radius.circular(6)),
      strokePaint(s.ink, 1.2),
    );
    title.paint(c, Offset(sys.center.dx - title.width / 2, pad));

    // Akteure und Assoziationen.
    final line = strokePaint(s.ink, 1.2);
    for (final a in actors) {
      final hand = Offset(actorW / 2 + figW * 0.45, a.cy - figH * 0.10);
      for (final i in a.a.faelle) {
        if (i < 0 || i >= cases.length) continue;
        final r = cases[i].rect;
        c.drawLine(hand, ellipseEdgePoint(r, hand), line);
      }
    }
    for (final a in actors) {
      _stickFigure(c, Offset(actorW / 2, a.cy));
      a.name.paint(
        c,
        Offset(actorW / 2 - a.name.width / 2, a.cy + figH / 2 + 4),
      );
    }

    // Anwendungsfälle.
    for (final cs in cases) {
      c.drawOval(cs.rect, fillPaint(s.accentBg));
      c.drawOval(cs.rect, strokePaint(s.accent, 1.3));
      cs.text.paint(
        c,
        cs.rect.center - Offset(cs.text.width / 2, cs.text.height / 2),
      );
    }

    // «include» / «extend».
    for (var ri = 0; ri < d.beziehungen.length; ri++) {
      final r = d.beziehungen[ri];
      if (r.von < 0 ||
          r.von >= cases.length ||
          r.zu < 0 ||
          r.zu >= cases.length) {
        continue;
      }
      final a = cases[r.von];
      final b = cases[r.zu];
      final p = strokePaint(s.ink, 1.2);
      final tag = s.text(
        r.art == UcArt.include ? '«include»' : '«extend»',
        tagStyle,
      );
      final lane = arcLane[ri];
      if (lane == null) {
        final p0 = ellipseEdgePoint(a.rect, b.rect.center);
        final p1 = ellipseEdgePoint(b.rect, a.rect.center);
        drawDashedLine(c, p0, p1, p, dash: 5, gap: 4);
        drawHead(c, p0, p1, ArrowHead.open, s.ink, size: 8, strokeWidth: 1.2);
        final mid = (p0 + p1) / 2;
        final vertical = (p1.dx - p0.dx).abs() < (p1.dy - p0.dy).abs();
        final pos = vertical
            ? Offset(mid.dx + 5, mid.dy - tag.height / 2)
            : Offset(mid.dx - tag.width / 2, mid.dy - tag.height / 2);
        paintLabel(c, tag, pos, s.surface, padX: 2, padY: 0);
      } else {
        // Umweg rechts an den Fällen dazwischen vorbei, eigene Spur je
        // Pfeil, Beschriftung senkrecht daneben.
        final x = casesRight + arcBase + lane * arcStep;
        final p0 = Offset(a.rect.right, a.rect.center.dy);
        final p1 = Offset(b.rect.right, b.rect.center.dy);
        final rad = math.min(8.0, (p1.dy - p0.dy).abs() / 2);
        final dir = p1.dy > p0.dy ? 1.0 : -1.0;
        final path = Path()
          ..moveTo(p0.dx, p0.dy)
          ..lineTo(x - rad, p0.dy)
          ..quadraticBezierTo(x, p0.dy, x, p0.dy + dir * rad)
          ..lineTo(x, p1.dy - dir * rad)
          ..quadraticBezierTo(x, p1.dy, x - rad, p1.dy)
          ..lineTo(p1.dx, p1.dy);
        c.drawPath(dashPath(path, dash: 5, gap: 4), p);
        drawHead(
          c,
          Offset(p1.dx + 10, p1.dy),
          p1,
          ArrowHead.open,
          s.ink,
          size: 8,
          strokeWidth: 1.2,
        );
        final my = (p0.dy + p1.dy) / 2;
        c.save();
        c.translate(x - tag.height / 2, my + tag.width / 2);
        c.rotate(-math.pi / 2);
        paintLabel(c, tag, Offset.zero, s.surface, padX: 2, padY: 0);
        c.restore();
      }
    }
  }

  void _stickFigure(Canvas c, Offset center) {
    final h = figH;
    final p = strokePaint(s.ink, 1.5);
    final headR = h * 0.13;
    final headC = Offset(center.dx, center.dy - h / 2 + headR);
    c.drawCircle(headC, headR, fillPaint(s.surface));
    c.drawCircle(headC, headR, p);
    final neck = Offset(center.dx, headC.dy + headR);
    final hip = Offset(center.dx, center.dy + h * 0.14);
    c.drawLine(neck, hip, p);
    final armY = neck.dy + h * 0.14;
    c.drawLine(
      Offset(center.dx - figW * 0.45, armY),
      Offset(center.dx + figW * 0.45, armY),
      p,
    );
    c.drawLine(hip, Offset(center.dx - figW * 0.35, center.dy + h / 2), p);
    c.drawLine(hip, Offset(center.dx + figW * 0.35, center.dy + h / 2), p);
  }
}
