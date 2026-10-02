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
    NuggetKind.fehlerfalle => (Icons.report_outlined, c.flame),
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
    final (_, color) = nuggetStyle(context, n.kind);
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
                  _KindLabel(
                    label: n.kind == NuggetKind.fehlerfalle
                        ? 'Achtung · ${n.kind.label}'
                        : n.kind.label,
                    color: color,
                  ),
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
                _Labeled(
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
      if (n.code != null) ...[gap, CodeBlock(n.code!)],
      if (n.points.isNotEmpty) ...[
        gap,
        if (isBeispiel) ...[
          _SectionLabel('Lösungsweg'),
          const SizedBox(height: Gap.s),
        ],
        n.kind == NuggetKind.ablauf || isBeispiel
            ? _Steps(n.points, color: color)
            : _Bullets(n.points, color: color),
      ],
      if (n.ergebnis != null) ...[gap, _Ergebnis(n.ergebnis!)],
      // Ist der Schritt selbst ein Merksatz, steht das Etikett schon oben.
      if (n.merksatz != null) ...[
        gap,
        _Merksatz(n.merksatz!, showLabel: n.kind != NuggetKind.merksatz),
      ],
      if (action != null) ...[
        gap,
        Divider(color: context.c.border),
        const SizedBox(height: Gap.xs),
        action!,
      ],
    ];
  }
}

/// Art des Schritts als kleines farbiges Wort („BEISPIEL“, „SKIZZE“ …).
class _KindLabel extends StatelessWidget {
  const _KindLabel({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: context.text.labelSmall?.copyWith(
        color: color,
        letterSpacing: 1.1,
        fontWeight: FontWeight.w700,
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

/// Absatz mit kleiner Überschrift, z. B. die Aufgabe eines Beispiels.
class _Labeled extends StatelessWidget {
  const _Labeled({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label),
        const SizedBox(height: Gap.xs),
        child,
      ],
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

/// Nummerierte Schritte mit schlichten Ziffern - für Abläufe und Lösungswege.
class _Steps extends StatelessWidget {
  const _Steps(this.points, {required this.color});
  final List<String> points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final style = context.text.bodyMedium;
    final numberWidth = math.max(22.0, scaler.scale(14.5) * 1.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < points.length; i++)
          Padding(
            padding: EdgeInsets.only(
              bottom: i < points.length - 1 ? Gap.s + 2 : 0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: numberWidth,
                  child: Text(
                    '${i + 1}.',
                    style: style?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                const SizedBox(width: Gap.xs),
                Expanded(child: HyphenText(points[i], style: style)),
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
  static const _padL = Gap.m + 2;
  static const _padR = Gap.m;

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final lines = code.replaceAll('\t', '    ').split('\n');

    return LayoutBuilder(
      builder: (context, box) {
        final inner = box.maxWidth - _padL - _padR;
        // Ohne Laufweite aus dem Theme - sonst stimmt die Messung nicht.
        final base = AppType.mono(
          size: _base,
          color: context.scheme.onSurface,
        ).copyWith(letterSpacing: 0);

        final baseSpace = (TextPainter(
          text: TextSpan(text: ' ', style: base),
          textDirection: TextDirection.ltr,
          textScaler: scaler,
        )..layout()).width;

        // Ganze Zeilen bzw. (mit [words]) Einrückung plus längstes Wort.
        double measure(String s, TextStyle style) {
          final tp = TextPainter(
            text: TextSpan(text: s, style: style),
            textDirection: TextDirection.ltr,
            textScaler: scaler,
          )..layout();
          final w = tp.width;
          tp.dispose();
          return w;
        }

        double widest(bool words, double scale) {
          final style = base.copyWith(fontSize: _base * scale);
          var m = 0.0;
          for (final l in lines) {
            final t = l.trimLeft();
            if (!words) {
              m = math.max(m, measure(l, style));
              continue;
            }
            final indent = (l.length - t.length) * baseSpace * scale;
            for (final piece in _pieces(t)) {
              m = math.max(m, indent + measure(piece, style));
            }
          }
          return m;
        }

        // Schrift so weit verkleinern, dass die längste Zeile passt - oder,
        // wenn das unter 60 % ginge, wenigstens das längste Wort. Mehrmals
        // nachmessen: Laufweiten skalieren nicht exakt linear.
        var scale = 1.0;
        var words = false;
        for (var i = 0; i < 4; i++) {
          final w = widest(words, scale);
          if (w <= inner - 1) break;
          final next = scale * (inner - 2) / w;
          if (!words && next < _minScale) {
            words = true;
            continue;
          }
          scale = math.max(_minScale, next);
          if (scale == _minScale) break;
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
            padding: const EdgeInsets.fromLTRB(_padL, Gap.m, _padR, Gap.m),
            color: context.c.surfaceAlt,
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

  /// Nicht umbrechbare Stücke einer Zeile (zwischen Leerzeichen und den
  /// Umbruchstellen aus [_breakable]).
  static Iterable<String> _pieces(String line) => _breakable(
    line,
  ).split(RegExp('[\\s$kZeroWidthSpace]')).where((p) => p.isNotEmpty);

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

/// Ergebnis als fette Zeile unter einer dünnen Linie, ohne Kasten.
class _Ergebnis extends StatelessWidget {
  const _Ergebnis(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: Gap.m),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.c.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Ergebnis'),
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
    );
  }
}

/// Merksatz im Zitat-Stil: Linie links, etwas größere Schrift.
class _Merksatz extends StatelessWidget {
  const _Merksatz(this.text, {this.showLabel = true});
  final String text;

  /// Überschrift „Merksatz“ - entfällt, wenn sie schon als Etikett über
  /// dem Schritt steht.
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(Gap.l, 2, 0, 2),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: c.flame, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel) ...[
            _SectionLabel('Merksatz', color: c.flame),
            const SizedBox(height: Gap.xs),
          ],
          HyphenText(
            text,
            style: context.text.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.45,
              color: context.scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
