import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_case.dart';
import '../hyphenation.dart';

/// Bausteine für das Material einer Aufgabe - das, was in der IHK-Prüfung
/// als Anlage abgedruckt ist: Tabelle, Code/Log/englischer Text und die
/// Ausgangssituation einer Fallaufgabe.

/// Zelle einer [AdaptiveTable]: Text oder ein Eingabe-Widget.
class TableCellData {
  const TableCellData.text(this.text)
    : child = null,
      minWidth = 0,
      prefWidth = 0;

  /// [minWidth]/[prefWidth]: Breite, die das Widget mindestens braucht bzw.
  /// gern hätte (ohne Zellenrand).
  const TableCellData.widget(
    Widget this.child, {
    required this.minWidth,
    required this.prefWidth,
  }) : text = '';

  final String text;
  final Widget? child;
  final double minWidth;
  final double prefWidth;

  bool get isWidget => child != null;
}

/// Tabelle, die sich der Breite anpasst.
///
/// Die Spaltenbreiten richten sich nach dem Inhalt: Jede Spalte bekommt
/// mindestens ihr längstes Wort, der Rest wird nach Textmenge verteilt.
/// Passt das nicht - typisch bei vier Spalten auf 320 px -, wird jede Zeile
/// zu einem Block „Spaltenkopf: Wert“ untereinander. Niemand muss seitlich
/// scrollen, kein Wort wird mitten im Wort umbrochen.
class AdaptiveTable extends StatelessWidget {
  const AdaptiveTable(this.rows, {super.key});

  /// Nur Text: `AdaptiveTable.text(question.table!)`.
  AdaptiveTable.text(List<List<String>> table, {super.key})
    : rows = [
        for (final r in table) [for (final s in r) TableCellData.text(s)],
      ];

  /// Erste Zeile = Spaltenköpfe.
  final List<List<TableCellData>> rows;

  static const _padH = 10.0;
  static const _padV = 8.0;
  static const _padWidget = 4.0;

  /// Schmaler darf eine Spalte mit Fließtext nicht werden, sonst steht dort
  /// ein Wort pro Zeile.
  static const _minReadable = 76.0;

  @override
  Widget build(BuildContext context) {
    final cols = rows.fold<int>(0, (m, r) => math.max(m, r.length));
    if (cols == 0) return const SizedBox.shrink();
    final grid = [
      for (final r in rows)
        [
          for (var i = 0; i < cols; i++)
            i < r.length ? r[i] : const TableCellData.text(''),
        ],
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
            final cell = grid[r][c];
            if (cell.isWidget) {
              minW[c] = math.max(minW[c], cell.minWidth + 2 * _padWidget + 1);
              maxW[c] = math.max(maxW[c], cell.prefWidth + 2 * _padWidget + 1);
              continue;
            }
            final tp = TextPainter(
              text: TextSpan(text: hyphenate(cell.text), style: styleOf(r, c)),
              textDirection: TextDirection.ltr,
              textScaler: scaler,
            )..layout();
            minW[c] = math.max(minW[c], tp.minIntrinsicWidth + 2 * _padH + 1);
            maxW[c] = math.max(maxW[c], tp.maxIntrinsicWidth + 2 * _padH + 1);
            tp.dispose();
          }
        }

        final widths = width.isFinite ? _fit(minW, maxW, width) : null;
        if (widths == null || grid.length < 2) {
          return _StackedTable(grid: grid, cell: cellStyle);
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

  final List<List<TableCellData>> grid;
  final List<double> widths;
  final TextStyle? Function(int row, int col) styleOf;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final primary = context.scheme.primary;
    final hasWidgets = grid.any((r) => r.any((cell) => cell.isWidget));
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.border),
      ),
      child: Table(
        columnWidths: {
          for (var i = 0; i < widths.length; i++)
            i: FixedColumnWidth(widths[i]),
        },
        defaultVerticalAlignment: hasWidgets
            ? TableCellVerticalAlignment.middle
            : TableCellVerticalAlignment.top,
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
                  grid[r][col].isWidget
                      ? Padding(
                          padding: const EdgeInsets.all(
                            AdaptiveTable._padWidget,
                          ),
                          child: grid[r][col].child,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AdaptiveTable._padH,
                            vertical: AdaptiveTable._padV,
                          ),
                          child: HyphenText(
                            grid[r][col].text,
                            style: styleOf(r, col),
                          ),
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
  const _StackedTable({required this.grid, required this.cell});

  final List<List<TableCellData>> grid;
  final TextStyle? cell;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final header = grid.first;
    final hasHeader = grid.length > 1;
    final body = hasHeader ? grid.skip(1).toList() : [header];
    final labelStyle = cell?.copyWith(
      fontWeight: FontWeight.w600,
      color: c.textMuted,
    );
    final overline = context.text.labelSmall?.copyWith(color: c.textMuted);

    String head(int col) => hasHeader ? header[col].text.trim() : '';

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.scheme.surface,
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
                  if (head(0).isNotEmpty) Text(head(0), style: overline),
                  if (body[r].first.isWidget)
                    Padding(
                      padding: const EdgeInsets.only(top: Gap.xs),
                      child: body[r].first.child,
                    )
                  else
                    HyphenText(
                      body[r].first.text,
                      style: context.text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  const SizedBox(height: Gap.xs),
                  for (var col = 1; col < body[r].length; col++)
                    if (body[r][col].isWidget)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Gap.xs,
                          bottom: Gap.s,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (head(col).isNotEmpty) ...[
                              HyphenText(head(col), style: labelStyle),
                              const SizedBox(height: Gap.xs),
                            ],
                            body[r][col].child!,
                          ],
                        ),
                      )
                    else if (body[r][col].text.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: Gap.xs),
                        child: HyphenText(
                          body[r][col].text,
                          style: cell,
                          prefix: head(col).isNotEmpty
                              ? '${head(col)}: '
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

/// Unsichtbare Umbruchstellen nach `.`, `(`, `,`, `/` und `_` in langen
/// Ausdrücken wie `kunde.istStammkunde()`.
String breakableCode(String line) => line.replaceAllMapped(
  RegExp(r'[^\s]{12,}'),
  (m) => m[0]!.replaceAllMapped(
    RegExp(r'[.(,/_:=]'),
    (b) => '${b[0]}$kZeroWidthSpace',
  ),
);

/// Eine Zeile des Materials nach dem Aufbereiten.
class MaterialLine {
  const MaterialLine(
    this.text, {
    this.flow = false,
    this.bullet,
    this.indent = 0,
  });

  final String text;

  /// Fließtext: bricht am Wort um, die Schrift wird nicht verkleinert.
  final bool flow;

  /// Aufzählungszeichen („-“, „1.“), falls die Zeile ein Listenpunkt ist.
  final String? bullet;

  /// Einrückung in Zeichen (nur Code).
  final int indent;

  bool get isBlank => text.isEmpty && bullet == null;
}

final _codeSymbols = RegExp(r'[{}()\[\];=<>|\\#$]');
final _bulletLine = RegExp(r'^\s*([-*•]|\d{1,2}[.)])\s+(.*)$');

/// Bereitet Material für die Anzeige auf.
///
/// Englische Handbuchtexte und Datenblätter sind von den Autoren hart
/// umbrochen (rund 34-56 Zeichen je Zeile). Auf einem schmalen Display
/// entstünde daraus ein Flattersatz aus halben Zeilen. Deshalb werden die
/// Zeilen eines Absatzes wieder zu Fließtext verbunden, Listenpunkte samt
/// ihrer eingerückten Fortsetzung ebenfalls. Code, Logs und
/// Konfigurationen (Sonderzeichen, Einrückung, Spalten aus Leerzeichen)
/// behalten ihre Zeilen.
List<MaterialLine> prepareMaterial(String code) {
  final raw = code.replaceAll('\t', '    ').trimRight().split('\n');
  final out = <MaterialLine>[];

  List<MaterialLine> asCode(List<String> block) => [
    for (final l in block)
      MaterialLine(l.trim(), indent: l.length - l.trimLeft().length),
  ];

  bool textLike(List<String> block) {
    final all = block.join('\n');
    if (_codeSymbols.allMatches(all).length > all.length * 0.012) return false;
    // Pseudocode ohne Sonderzeichen erkennt man an den Schlüsselwörtern in
    // Großbuchstaben (WENN, DANN, ENDE) - eine einzelne Überschrift in
    // Großbuchstaben ist dagegen Text.
    if (block.length > 1) {
      final words = all.split(RegExp(r'\s+')).where((w) => w.length >= 3);
      final caps = words.where(
        (w) => w == w.toUpperCase() && w.contains(RegExp(r'[A-ZÄÖÜ]')),
      );
      if (caps.length > words.length * 0.15) return false;
    }
    var inList = false;
    for (final l in block) {
      if (_bulletLine.hasMatch(l)) {
        inList = true;
        continue;
      }
      // Spalten aus Leerzeichen: Tabelle oder Konfiguration.
      if (l.trim().contains(RegExp(r'\S {2,}\S'))) return false;
      if (l.startsWith(' ')) {
        if (!inList) return false;
      } else {
        inList = false;
      }
    }
    return true;
  }

  List<MaterialLine> asText(List<String> block) {
    final lines = <MaterialLine>[];
    final para = <String>[];

    void flush() {
      if (para.isEmpty) return;
      final longest = para.fold<int>(0, (m, l) => math.max(m, l.length));
      final wrapped =
          para.length > 1 &&
          longest >= 28 &&
          para
              .take(para.length - 1)
              .every((l) => l.length >= longest * 0.6 && l.contains(' '));
      if (wrapped) {
        lines.add(MaterialLine(para.join(' '), flow: true));
      } else {
        lines.addAll([for (final l in para) MaterialLine(l, flow: true)]);
      }
      para.clear();
    }

    String? bullet;
    final item = <String>[];
    void flushItem() {
      if (bullet == null) return;
      lines.add(MaterialLine(item.join(' '), flow: true, bullet: bullet));
      bullet = null;
      item.clear();
    }

    for (final l in block) {
      final m = _bulletLine.firstMatch(l);
      if (m != null) {
        flush();
        flushItem();
        bullet = m[1];
        item.add(m[2]!.trim());
      } else if (bullet != null && l.startsWith(' ')) {
        item.add(l.trim());
      } else {
        flushItem();
        para.add(l.trim());
      }
    }
    flush();
    flushItem();
    return lines;
  }

  final block = <String>[];
  void flushBlock() {
    if (block.isEmpty) return;
    out.addAll(textLike(block) ? asText(block) : asCode(block));
    block.clear();
  }

  for (final l in raw) {
    if (l.trim().isEmpty) {
      flushBlock();
      out.add(const MaterialLine(''));
    } else {
      block.add(l.trimRight());
    }
  }
  flushBlock();
  return out;
}

/// Gegebener Pseudocode, Log, Konfigurationsauszug oder englischer Text in
/// Festbreitenschrift.
///
/// Fließtext und Listen brechen ganz normal am Wort um
/// ([prepareMaterial]). Code behält seine Zeilen: Ist eine Zeile zu lang,
/// wird die Schrift bis auf [_minScale] verkleinert; reicht das nicht,
/// bricht die Zeile um und die Fortsetzung bleibt eingerückt - die Struktur
/// bleibt erkennbar, nichts verschwindet hinter dem Rand und niemand muss
/// seitlich scrollen.
class MaterialCodeBlock extends StatelessWidget {
  const MaterialCodeBlock(this.code, {super.key, this.accent});

  final String code;
  final Color? accent;

  static const _base = 13.5;
  static const _minScale = 0.74;
  static const _padL = Gap.m + 3;
  static const _padR = Gap.m;

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final lines = prepareMaterial(code);
    final base = AppType.mono(
      size: _base,
      color: context.scheme.onSurface,
    ).copyWith(letterSpacing: 0);

    return LayoutBuilder(
      builder: (context, box) {
        final inner = box.maxWidth - _padL - 3 - _padR;

        double charWidth(TextStyle style) {
          final tp = TextPainter(
            text: TextSpan(text: 'MMMMMMMMMM', style: style),
            textDirection: TextDirection.ltr,
            textScaler: scaler,
          )..layout();
          final w = tp.width / 10;
          tp.dispose();
          return w;
        }

        // Schrift so weit verkleinern, dass die längste Codezeile passt -
        // aber nicht unter die Lesbarkeitsgrenze.
        var scale = 1.0;
        final longest = lines
            .where((l) => !l.flow)
            .fold<int>(0, (m, l) => math.max(m, l.indent + l.text.length));
        final need = longest * charWidth(base);
        if (need > inner && inner > 0) {
          scale = math.max(_minScale, (inner - 1) / need);
        }
        final codeStyle = base.copyWith(fontSize: _base * scale);
        final flowStyle = base.copyWith(height: 1.55);
        final space = charWidth(codeStyle);

        Widget line(MaterialLine l) {
          if (l.isBlank) return const SizedBox(height: Gap.s);
          if (l.bullet != null) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${l.bullet} ', style: flowStyle),
                Expanded(child: Text(l.text, style: flowStyle)),
              ],
            );
          }
          if (l.flow) return Text(l.text, style: flowStyle);
          return Padding(
            padding: EdgeInsets.only(
              // Höchstens ein Drittel der Breite einrücken - tiefe
              // Verschachtelung soll nicht zu einem Wort pro Zeile führen.
              left: math.min(l.indent * space, math.max(0, inner / 3)),
            ),
            child: Text(breakableCode(l.text), style: codeStyle),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(Radii.m),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(_padL, Gap.m, _padR, Gap.m),
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
              children: [for (final l in lines) line(l)],
            ),
          ),
        );
      },
    );
  }
}

/// Kasten mit Überzeile, z. B. „SITUATION“.
class MaterialBox extends StatelessWidget {
  const MaterialBox({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: context.c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: context.c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: context.text.labelSmall?.copyWith(
              color: context.c.textMuted,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: Gap.xs),
          child,
        ],
      ),
    );
  }
}

/// Ausgangssituation einer Fallaufgabe - einklappbar, damit sie bei den
/// Teilaufgaben b), c) ... nicht jedes Mal den Bildschirm füllt.
///
/// Was der Nutzer für einen Fall gewählt hat (auf oder zu), gilt auch für
/// die nächsten Teilaufgaben desselben Falls.
class CaseContextBox extends StatefulWidget {
  const CaseContextBox({super.key, required this.examCase});

  final ExamCase examCase;

  static final _collapsed = <String>{};

  @override
  State<CaseContextBox> createState() => _CaseContextBoxState();
}

class _CaseContextBoxState extends State<CaseContextBox> {
  bool get _open => !CaseContextBox._collapsed.contains(widget.examCase.id);

  void _toggle() => setState(() {
    final id = widget.examCase.id;
    _open
        ? CaseContextBox._collapsed.add(id)
        : CaseContextBox._collapsed.remove(id);
  });

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ec = widget.examCase;
    final open = _open;
    return Material(
      color: c.infoBg,
      borderRadius: BorderRadius.circular(Radii.m),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radii.m),
          border: Border.all(color: c.info.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              button: true,
              expanded: open,
              child: InkWell(
                onTap: _toggle,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 52),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Gap.l,
                      Gap.s,
                      Gap.s,
                      Gap.s,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.apartment_outlined, size: 20, color: c.info),
                        const SizedBox(width: Gap.m),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'AUSGANGSSITUATION',
                                style: context.text.labelSmall?.copyWith(
                                  color: c.info,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              HyphenText(
                                ec.title,
                                style: context.text.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: Gap.xs),
                        Padding(
                          padding: const EdgeInsets.all(Gap.s),
                          child: Icon(
                            open ? Icons.expand_less : Icons.expand_more,
                            color: c.info,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (open)
              Padding(
                padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HyphenText(
                      ec.company.name,
                      style: context.text.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    HyphenText(
                      ec.company.description,
                      style: context.text.bodySmall?.copyWith(
                        color: c.textMuted,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: Gap.m),
                    HyphenText(ec.situation, style: context.text.bodyMedium),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Punkte der Aufgabe wie am Rand des IHK-Aufgabenbogens: „4 P.“
class PointsBadge extends StatelessWidget {
  const PointsBadge(this.points, {super.key});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$points ${points == 1 ? 'Punkt' : 'Punkte'}',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Gap.s, vertical: 3),
        decoration: BoxDecoration(
          color: context.scheme.primaryContainer,
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
        child: Text(
          '$points P.',
          maxLines: 1,
          softWrap: false,
          style: AppType.numeric(size: 12.5, color: context.scheme.primary),
        ),
      ),
    );
  }
}

/// Kleine Hinweiszeile über dem Eingabebereich („Tippe ... an“).
class HintLine extends StatelessWidget {
  const HintLine(this.text, {super.key, this.icon = Icons.touch_app_outlined});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final style = context.text.labelSmall?.copyWith(color: c.textMuted);
    final line =
        MediaQuery.textScalerOf(context).scale(style?.fontSize ?? 11.5) * 1.3;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: math.max(0, (line - 15) / 2)),
          child: Icon(icon, size: 15, color: c.textMuted),
        ),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: style?.copyWith(height: 1.3))),
      ],
    );
  }
}
