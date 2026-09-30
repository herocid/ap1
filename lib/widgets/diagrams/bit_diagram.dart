import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/models/diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_style.dart';
import 'legend.dart';

/// Bitmuster in Festbreitenschrift. Netzanteil blau hinterlegt und fett,
/// Hostanteil grau; Gruppen (Oktette) brechen bei wenig Platz um, die
/// Spalten der Zeilen bleiben dabei untereinander.
DiagramLayout layoutBits(BitDiagramm d, DiagramStyle s, double w) =>
    _BitLayout(d, s, w);

class _Line {
  _Line(this.z);
  final BitZeile z;
  late TextPainter label;
  late Offset labelPos;
  final groups = <(List<String>, int)>[]; // Bits, Index des ersten Bits
  late double top;
}

class _BitLayout extends DiagramLayout {
  _BitLayout(this.d, this.s, double maxW) {
    final labelStyle = s.label(size: 12, weight: FontWeight.w600);
    bitStyle = s.mono(size: 13.5, weight: FontWeight.w400);
    netStyle = s.mono(size: 13.5, weight: FontWeight.w700, color: s.accent);
    final probe = s.text('0', netStyle);
    cellW = probe.width + s.sc(2.5);
    cellH = probe.height + s.sc(5);
    groupGap = s.sc(9);
    sepChar =
        RegExp(r'\.').hasMatch(d.zeilen.isEmpty ? '' : d.zeilen.first.bits)
        ? '.'
        : ' ';

    // Gruppen je Zeile.
    var maxGroupBits = 1;
    var maxGroups = 1;
    for (final z in d.zeilen) {
      final l = _Line(z);
      var idx = 0;
      for (final g in z.bits.split(RegExp(r'[. ]+'))) {
        if (g.isEmpty) continue;
        final bits = g.split('');
        l.groups.add((bits, idx));
        idx += bits.length;
        maxGroupBits = math.max(maxGroupBits, bits.length);
      }
      maxGroups = math.max(maxGroups, l.groups.length);
      lines.add(l);
    }
    final groupW = maxGroupBits * cellW;

    // Bezeichnung links, wenn alles in eine Zeile passt; sonst darüber.
    var labelNatural = 0.0;
    for (final l in lines) {
      labelNatural = math.max(
        labelNatural,
        s.text(l.z.label, labelStyle).width,
      );
    }
    final fullBits = maxGroups * groupW + (maxGroups - 1) * groupGap;
    final labelCol = math.min(labelNatural, maxW * 0.3);
    labelLeft = maxW >= 420 && labelCol + 12 + fullBits <= maxW;
    final bitsAvail = labelLeft ? maxW - labelCol - 12 : maxW;
    perRow = math.max(
      1,
      math.min(
        maxGroups,
        ((bitsAvail + groupGap) / (groupW + groupGap)).floor(),
      ),
    );
    // Gleichmäßig umbrechen (4 Oktette: 2+2 statt 3+1).
    final rowsNeeded = (maxGroups / perRow).ceil();
    perRow = (maxGroups / rowsNeeded).ceil();
    bitsX = labelLeft ? labelCol + 12 : 0;
    this.groupW = groupW;
    width = math.max(maxW, bitsX + perRow * groupW + (perRow - 1) * groupGap);

    var y = 3.0; // Luft für die Netz/Host-Grenzmarke
    for (final l in lines) {
      l.label = s.text(
        l.z.label,
        labelStyle,
        maxWidth: labelLeft ? labelCol : width,
      );
      final rows = (l.groups.length / perRow).ceil();
      final bitsH = rows * cellH + (rows - 1) * s.sc(4);
      if (labelLeft) {
        l.labelPos = Offset(
          0,
          y + (math.min(bitsH, cellH) - l.label.height) / 2,
        );
        l.top = y;
        y += math.max(bitsH, l.label.height) + s.sc(10);
      } else {
        l.labelPos = Offset(0, y);
        l.top = y + l.label.height + 3;
        y = l.top + bitsH + s.sc(12);
      }
    }
    bitsBottom = y - s.sc(10);

    final hasNetz = d.zeilen.any((z) => z.netz != null);
    if (d.legende != null) {
      caption = s.text(
        d.legende!,
        s.label(size: 11.5, weight: FontWeight.w400, color: s.muted),
        maxWidth: width,
      );
    }
    legend = Legend(s, width, [
      if (hasNetz && d.legende == null) ...[
        LegendItem.box(s.accent, 'Netzanteil'),
        LegendItem.box(s.grid, 'Hostanteil'),
      ],
    ]);
    var h = bitsBottom;
    if (!legend.isEmpty) h += 10 + legend.height;
    if (caption != null) h += 10 + caption!.height;
    size = Size(width, h);
  }

  final BitDiagramm d;
  final DiagramStyle s;
  late final TextStyle bitStyle;
  late final TextStyle netStyle;
  late final double cellW;
  late final double cellH;
  late final double groupGap;
  late final double groupW;
  late final String sepChar;
  late final bool labelLeft;
  late int perRow;
  late final double bitsX;
  late final double width;
  late final double bitsBottom;
  late final Legend legend;
  TextPainter? caption;
  final lines = <_Line>[];

  @override
  late final Size size;

  @override
  void paint(Canvas c) {
    final zero = s.text('0', bitStyle);
    final one = s.text('1', bitStyle);
    final zeroN = s.text('0', netStyle);
    final oneN = s.text('1', netStyle);
    final sep = s.text(
      sepChar == '.' ? '.' : '',
      s.mono(size: 13.5, color: s.muted),
    );
    for (final l in lines) {
      l.label.paint(c, l.labelPos);
      final netz = l.z.netz ?? 0;
      for (var gi = 0; gi < l.groups.length; gi++) {
        final (bits, first) = l.groups[gi];
        final row = gi ~/ perRow;
        final col = gi % perRow;
        final x0 = bitsX + col * (groupW + groupGap);
        final y0 = l.top + row * (cellH + s.sc(4));
        // Hintergrund: Netzanteil blau, Hostanteil grau.
        final netCount = (netz - first).clamp(0, bits.length);
        final groupRect = Rect.fromLTWH(x0, y0, bits.length * cellW, cellH);
        final rr = RRect.fromRectAndRadius(groupRect, const Radius.circular(5));
        c.save();
        c.clipRRect(rr);
        if (l.z.netz != null) {
          if (netCount > 0) {
            c.drawRect(
              Rect.fromLTWH(x0, y0, netCount * cellW, cellH),
              fillPaint(s.accentBg),
            );
          }
          if (netCount < bits.length) {
            c.drawRect(
              Rect.fromLTWH(
                x0 + netCount * cellW,
                y0,
                (bits.length - netCount) * cellW,
                cellH,
              ),
              fillPaint(s.surfaceAlt),
            );
          }
        } else {
          c.drawRect(groupRect, fillPaint(s.surfaceAlt));
        }
        c.restore();
        // Grenze Netz | Host innerhalb der Gruppe.
        if (l.z.netz != null && netCount > 0 && netCount < bits.length) {
          final bx = x0 + netCount * cellW;
          c.drawLine(
            Offset(bx, y0 - 2),
            Offset(bx, y0 + cellH + 2),
            strokePaint(s.accent, 2),
          );
        }
        for (var bi = 0; bi < bits.length; bi++) {
          final isNet = l.z.netz != null && first + bi < netz;
          final tp = bits[bi] == '1'
              ? (isNet ? oneN : one)
              : (isNet ? zeroN : zero);
          tp.paint(
            c,
            Offset(
              x0 + bi * cellW + (cellW - tp.width) / 2,
              y0 + (cellH - tp.height) / 2,
            ),
          );
        }
        if (col < perRow - 1 && gi < l.groups.length - 1 && sep.width > 0) {
          sep.paint(
            c,
            Offset(
              x0 + groupW + (groupGap - sep.width) / 2,
              y0 + (cellH - sep.height) / 2,
            ),
          );
        }
      }
    }
    var y = bitsBottom;
    if (!legend.isEmpty) {
      legend.paint(c, Offset(0, y + 10));
      y += 10 + legend.height;
    }
    caption?.paint(c, Offset(0, y + 10));
  }
}
