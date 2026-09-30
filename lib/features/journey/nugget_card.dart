import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/nugget.dart';
import '../../data/models/topic.dart';
import '../../widgets/common.dart';
import '../../widgets/diagrams/diagram_view.dart';
import '../../widgets/hyphenation.dart';

/// Symbol und Farbe je Beitragsart. Farbe ist sparsam: das Etikett oben und
/// die Akzente der Art tragen sie, der Rest der Karte bleibt neutral.
(IconData, Color) nuggetStyle(BuildContext context, NuggetKind kind) {
  final c = context.c;
  return switch (kind) {
    NuggetKind.konzept => (Icons.lightbulb_outline, context.scheme.primary),
    NuggetKind.vergleich => (Icons.compare_arrows, c.info),
    NuggetKind.ablauf => (Icons.format_list_numbered, c.info),
    NuggetKind.formel => (Icons.functions, context.scheme.primary),
    NuggetKind.merksatz => (Icons.push_pin_outlined, c.flame),
    NuggetKind.fehlerfalle => (Icons.report_outlined, c.danger),
    NuggetKind.beispiel => (Icons.calculate_outlined, c.success),
    NuggetKind.skizze => (Icons.schema_outlined, c.info),
  };
}

/// Ein Lernschritt der Journey.
///
/// Alles wächst mit dem Inhalt: kein Text wird gekürzt, Tabellen passen ihre
/// Spalten an die Breite an (und werden auf sehr schmalen Displays zu
/// Karten je Zeile), Code bricht mit Einrückung um. Nur die kompakte
/// Vorschau ([compact]) kürzt die Einleitung sichtbar mit „…“.
class NuggetCard extends StatelessWidget {
  const NuggetCard({
    super.key,
    required this.nugget,
    this.action,
    this.compact = false,
    this.onTap,
    this.showTopic = true,
  });

  final Nugget nugget;
  final VoidCallback? onTap;

  /// In einer Lektion steht das Thema schon in der Kopfzeile.
  final bool showTopic;

  /// Optionale Schaltfläche am Kartenende, z. B. "Thema üben".
  final Widget? action;

  /// Nur Etikett, Titel und Einleitung - für Vorschauen.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final n = nugget;
    final (icon, color) = nuggetStyle(context, n.kind);
    final isBeispiel = n.kind == NuggetKind.beispiel;
    final bodyStyle = context.text.bodyMedium?.copyWith(
      color: context.scheme.onSurface,
    );

    return LayoutBuilder(
      builder: (context, box) {
        // Auf schmalen Handys zählt jeder Pixel für Tabellen und Formeln.
        final side = box.maxWidth < 380 ? Gap.l : Gap.xl;
        return AppCard(
          onTap: onTap,
          padding: EdgeInsets.fromLTRB(side, Gap.l, side, Gap.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: Gap.s,
                runSpacing: Gap.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _KindBadge(label: n.kind.label, icon: icon, color: color),
                  if (showTopic)
                    Text(
                      Topics.byId(n.topicId).title,
                      style: context.text.labelSmall?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: Gap.m),
              HyphenText(n.title, style: context.text.titleLarge),
              const SizedBox(height: Gap.s),
              if (compact)
                ClampedText(
                  n.body,
                  maxLines: 3,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.c.textMuted,
                  ),
                )
              else if (isBeispiel)
                _Panel(
                  label: 'Aufgabe',
                  child: HyphenText(n.body, style: bodyStyle),
                )
              else
                HyphenText(n.body, style: bodyStyle),
              if (!compact) ..._details(context, color),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _details(BuildContext context, Color color) {
    final n = nugget;
    const gap = SizedBox(height: Gap.l);
    final isBeispiel = n.kind == NuggetKind.beispiel;
    return [
      if (n.diagram != null) ...[gap, _Figure(child: DiagramView(n.diagram!))],
      if (n.table != null && n.table!.isNotEmpty) ...[
        gap,
        NuggetTable(n.table!),
      ],
      if (n.code != null) ...[gap, CodeBlock(n.code!, accent: color)],
      if (n.points.isNotEmpty) ...[
        gap,
        if (isBeispiel) ...[
          _SectionLabel('Lösungsweg', color: color),
          const SizedBox(height: Gap.m),
        ],
        n.kind == NuggetKind.ablauf || isBeispiel
            ? _Steps(n.points, color: color)
            : _Bullets(n.points, color: color),
      ],
      if (n.ergebnis != null) ...[
        SizedBox(height: n.points.isEmpty ? Gap.l : Gap.xs),
        _Ergebnis(n.ergebnis!),
      ],
      if (n.merksatz != null) ...[gap, _Merksatz(n.merksatz!)],
      if (action != null) ...[
        gap,
        Divider(color: context.c.border),
        const SizedBox(height: Gap.xs),
        action!,
      ],
    ];
  }
}

/// Getöntes Etikett mit der Art des Schritts („BEISPIEL“, „SKIZZE“ …).
class _KindBadge extends StatelessWidget {
  const _KindBadge({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Gap.s, 3, Gap.s + 2, 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: Gap.xs),
          Flexible(
            child: Text(
              label.toUpperCase(),
              style: context.text.labelSmall?.copyWith(
                color: color,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.text.labelSmall?.copyWith(
        color: color ?? context.c.textMuted,
        letterSpacing: 1.1,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

/// Abgesetzter Kasten mit Überschrift, z. B. die Aufgabe eines Beispiels.
class _Panel extends StatelessWidget {
  const _Panel({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.m + 2),
      decoration: BoxDecoration(
        color: context.c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.m),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label),
          const SizedBox(height: Gap.xs),
          child,
        ],
      ),
    );
  }
}

/// Rahmen um eine Zeichnung. Die Zeichnung selbst kommt aus [DiagramView].
class _Figure extends StatelessWidget {
  const _Figure({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: context.c.border),
      ),
      child: child,
    );
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets(this.points, {required this.color});
  final List<String> points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final style = context.text.bodyMedium;
    // Der Punkt sitzt auf Höhe der ersten Zeile - auch bei großer Schrift.
    final lineHeight =
        MediaQuery.textScalerOf(context).scale(style?.fontSize ?? 14.5) *
        (style?.height ?? 1.55);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in points)
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.s),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: lineHeight,
                  width: 6,
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Gap.m),
                Expanded(child: HyphenText(p, style: style)),
              ],
            ),
          ),
      ],
    );
  }
}

/// Nummerierte Schritte mit Verbindungslinie - für Abläufe und Lösungswege.
class _Steps extends StatelessWidget {
  const _Steps(this.points, {required this.color});
  final List<String> points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final dot = math.max(26.0, scaler.scale(12.5) + 12);
    final style = context.text.bodyMedium;
    // Erste Textzeile mittig zur Nummer ausrichten.
    final lineHeight =
        scaler.scale(style?.fontSize ?? 14.5) * (style?.height ?? 1.55);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < points.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: dot,
                  child: Column(
                    children: [
                      Container(
                        width: dot,
                        height: dot,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withValues(alpha: 0.13),
                        ),
                        child: Text(
                          '${i + 1}',
                          style: AppType.numeric(
                            size: 12.5,
                            weight: FontWeight.w700,
                            color: color,
                          ).copyWith(height: 1),
                        ),
                      ),
                      if (i < points.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            color: color.withValues(alpha: 0.22),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: Gap.m),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: math.max(0, (dot - lineHeight) / 2),
                      bottom: i < points.length - 1 ? Gap.m : 0,
                    ),
                    child: HyphenText(points[i], style: style),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Tabelle für Vergleiche und Rechendaten.
///
/// Die Spaltenbreiten richten sich nach dem Inhalt: Jede Spalte bekommt
/// mindestens ihr längstes Wort, der Rest wird nach Textmenge verteilt.
/// Passt das nicht in die Breite - typisch bei vier Spalten auf 320 px -,
/// wird jede Zeile zu einem eigenen Block („Spaltenkopf: Wert“). So muss
/// niemand seitlich scrollen und kein Wort wird mitten im Wort umbrochen.
class NuggetTable extends StatelessWidget {
  const NuggetTable(this.rows, {super.key});
  final List<List<String>> rows;

  static const _padH = 10.0;
  static const _padV = 8.0;

  /// Schmaler darf eine Spalte mit Fließtext nicht werden, sonst steht
  /// dort ein Wort pro Zeile.
  static const _minReadable = 76.0;

  @override
  Widget build(BuildContext context) {
    final cols = rows.fold<int>(0, (m, r) => math.max(m, r.length));
    if (cols == 0) return const SizedBox.shrink();
    final grid = [
      for (final r in rows)
        [for (var i = 0; i < cols; i++) i < r.length ? r[i] : ''],
    ];

    final headStyle = context.text.labelLarge?.copyWith(
      fontSize: 13.5,
      fontWeight: FontWeight.w700,
      color: context.scheme.onSurface,
    );
    final cellStyle = context.text.bodyMedium?.copyWith(fontSize: 14);
    final firstStyle = cellStyle?.copyWith(fontWeight: FontWeight.w600);
    final scaler = MediaQuery.textScalerOf(context);

    TextStyle? styleOf(int row, int col) => row == 0
        ? headStyle
        : col == 0
        ? firstStyle
        : cellStyle;

    return LayoutBuilder(
      builder: (context, box) {
        final width = box.maxWidth;
        final minW = List<double>.filled(cols, 0);
        final maxW = List<double>.filled(cols, 0);
        for (var r = 0; r < grid.length; r++) {
          for (var c = 0; c < cols; c++) {
            final tp = TextPainter(
              text: TextSpan(text: hyphenate(grid[r][c]), style: styleOf(r, c)),
              textDirection: TextDirection.ltr,
              textScaler: scaler,
            )..layout();
            minW[c] = math.max(minW[c], tp.minIntrinsicWidth + 2 * _padH + 1);
            maxW[c] = math.max(maxW[c], tp.maxIntrinsicWidth + 2 * _padH + 1);
            tp.dispose();
          }
        }

        final widths = _fit(minW, maxW, width);
        if (widths == null || grid.length < 2) {
          return _StackedTable(grid: grid, head: headStyle, cell: cellStyle);
        }
        return _GridTable(grid: grid, widths: widths, styleOf: styleOf);
      },
    );
  }

  /// Verteilt [width] auf die Spalten oder liefert null, wenn die Tabelle
  /// nicht lesbar in die Breite passt.
  static List<double>? _fit(
    List<double> minW,
    List<double> maxW,
    double width,
  ) {
    final sumMin = minW.fold<double>(0, (s, v) => s + v);
    final sumMax = maxW.fold<double>(0, (s, v) => s + v);
    if (sumMin > width) return null;

    final List<double> widths;
    if (sumMax <= width) {
      // Alles passt einzeilig - Rest gleichmäßig verteilen.
      final extra = (width - sumMax) / maxW.length;
      widths = [for (final m in maxW) m + extra];
    } else {
      final slack = width - sumMin;
      final want = [for (var i = 0; i < minW.length; i++) maxW[i] - minW[i]];
      final sumWant = want.fold<double>(0, (s, v) => s + v);
      widths = [
        for (var i = 0; i < minW.length; i++)
          minW[i] + (sumWant == 0 ? 0 : slack * want[i] / sumWant),
      ];
    }
    // Eine Spalte mit viel Text, die schmaler als lesbar wird, macht die
    // Tabelle zu einem langen Wurm - dann lieber Blöcke je Zeile.
    for (var i = 0; i < widths.length; i++) {
      if (widths[i] < _minReadable && maxW[i] > widths[i] * 1.8) return null;
    }
    return widths;
  }
}

class _GridTable extends StatelessWidget {
  const _GridTable({
    required this.grid,
    required this.widths,
    required this.styleOf,
  });

  final List<List<String>> grid;
  final List<double> widths;
  final TextStyle? Function(int row, int col) styleOf;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final primary = context.scheme.primary;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.border),
      ),
      child: Table(
        columnWidths: {
          for (var i = 0; i < widths.length; i++)
            i: FixedColumnWidth(widths[i]),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        border: TableBorder(
          horizontalInside: BorderSide(color: c.border),
          verticalInside: BorderSide(color: c.border.withValues(alpha: 0.6)),
        ),
        children: [
          for (var r = 0; r < grid.length; r++)
            TableRow(
              decoration: BoxDecoration(
                color: r == 0
                    ? primary.withValues(alpha: 0.09)
                    : r.isEven
                    ? c.surfaceAlt.withValues(alpha: 0.55)
                    : null,
              ),
              children: [
                for (var col = 0; col < grid[r].length; col++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: NuggetTable._padH,
                      vertical: NuggetTable._padV,
                    ),
                    child: HyphenText(grid[r][col], style: styleOf(r, col)),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Tabelle als Blöcke je Zeile - für schmale Displays.
class _StackedTable extends StatelessWidget {
  const _StackedTable({
    required this.grid,
    required this.head,
    required this.cell,
  });

  final List<List<String>> grid;
  final TextStyle? head;
  final TextStyle? cell;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final header = grid.first;
    final body = grid.length > 1 ? grid.skip(1).toList() : [header];
    final labelStyle = cell?.copyWith(
      fontWeight: FontWeight.w600,
      color: c.textMuted,
    );

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var r = 0; r < body.length; r++) ...[
            if (r > 0) Divider(height: 1, color: c.border),
            Container(
              color: r.isOdd ? c.surfaceAlt.withValues(alpha: 0.55) : null,
              padding: const EdgeInsets.fromLTRB(Gap.m, Gap.m, Gap.m, Gap.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (header.first.trim().isNotEmpty && grid.length > 1)
                    Text(
                      header.first,
                      style: context.text.labelSmall?.copyWith(
                        color: c.textMuted,
                      ),
                    ),
                  HyphenText(
                    body[r].first,
                    style: context.text.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: Gap.xs),
                  for (var col = 1; col < body[r].length; col++)
                    if (body[r][col].trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: Gap.xs),
                        child: HyphenText(
                          body[r][col],
                          style: cell,
                          prefix:
                              grid.length > 1 && header[col].trim().isNotEmpty
                              ? '${header[col]}: '
                              : null,
                          prefixStyle: labelStyle,
                        ),
                      ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Formel, Pseudocode oder Befehl in Festbreitenschrift.
///
/// Nichts verschwindet hinter dem Rand: Ist eine Zeile zu lang, wird die
/// Schrift bis auf 60 % verkleinert (so bleiben Tabellen aus Text
/// und ASCII-Kästen intakt). Reicht das nicht, bricht die Zeile um und
/// behält in der Fortsetzung ihre Einrückung - die Struktur von Pseudocode
/// bleibt erkennbar.
class CodeBlock extends StatelessWidget {
  const CodeBlock(this.code, {super.key, this.accent});
  final String code;
  final Color? accent;

  static const _base = 13.5;
  static const _minScale = 0.6;
  static const _padL = Gap.m + 2 + 3;
  static const _padR = Gap.m;

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final lines = code.replaceAll('\t', '    ').split('\n');

    return LayoutBuilder(
      builder: (context, box) {
        final inner = box.maxWidth - _padL - _padR;
        final base = AppType.mono(size: _base, color: context.scheme.onSurface);

        final baseSpace = (TextPainter(
          text: TextSpan(text: ' ', style: base),
          textDirection: TextDirection.ltr,
          textScaler: scaler,
        )..layout()).width;

        // Ganze Zeilen bzw. (mit [words]) Einrückung plus längstes Wort.
        double widest(bool words) {
          var m = 0.0;
          for (final l in lines) {
            final t = l.trimLeft();
            final tp = TextPainter(
              text: TextSpan(text: words ? _breakable(t) : l, style: base),
              textDirection: TextDirection.ltr,
              textScaler: scaler,
            )..layout();
            final indent = (l.length - t.length) * baseSpace;
            m = math.max(m, words ? tp.minIntrinsicWidth + indent : tp.width);
            tp.dispose();
          }
          return m;
        }

        var scale = 1.0;
        final longestLine = widest(false);
        if (longestLine > inner) {
          scale = (inner - 2) / longestLine;
          if (scale < _minScale) {
            final longestWord = widest(true);
            scale = ((inner - 2) / longestWord).clamp(_minScale, 1.0);
          }
        }
        final style = base.copyWith(fontSize: _base * scale);
        final space = (TextPainter(
          text: TextSpan(text: ' ', style: style),
          textDirection: TextDirection.ltr,
          textScaler: scaler,
        )..layout()).width;

        return ClipRRect(
          borderRadius: BorderRadius.circular(Radii.m),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(_padL - 3, Gap.m, _padR, Gap.m),
            decoration: BoxDecoration(
              color: context.c.surfaceAlt,
              border: Border(
                left: BorderSide(
                  color: accent ?? context.scheme.primary,
                  width: 3,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final line in lines)
                  Padding(
                    padding: EdgeInsets.only(
                      // Höchstens ein Drittel der Breite einrücken - tiefe
                      // Verschachtelung soll nicht zu einem Wort pro Zeile
                      // führen.
                      left: math.min(
                        (line.length - line.trimLeft().length) * space,
                        inner / 3,
                      ),
                    ),
                    child: Text(
                      line.trimLeft().isEmpty
                          ? ' '
                          : _breakable(line.trimLeft()),
                      style: style,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Unsichtbare Umbruchstellen nach `.`, `(`, `,` und `/` in langen
  /// Ausdrücken wie `kunde.istStammkunde()`.
  static String _breakable(String line) => line.replaceAllMapped(
    RegExp(r'[^\s]{12,}'),
    (m) => m[0]!.replaceAllMapped(
      RegExp(r'[.(,/]'),
      (b) => '${b[0]}$kZeroWidthSpace',
    ),
  );
}

class _Ergebnis extends StatelessWidget {
  const _Ergebnis(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: c.successBg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(
          color: c.success.withValues(alpha: 0.45),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, size: 22, color: c.success),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel('Ergebnis', color: c.success),
                const SizedBox(height: 2),
                HyphenText(
                  text,
                  style: context.text.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Merksatz extends StatelessWidget {
  const _Merksatz(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: c.flameBg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.flame.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.push_pin_outlined, size: 18, color: c.flame),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel('Merksatz', color: c.flame),
                const SizedBox(height: 2),
                HyphenText(
                  text,
                  style: context.text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
