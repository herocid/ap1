import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/question.dart';
import '../common.dart';
import 'gap_field.dart';
import 'question_material.dart';
import 'shuffle.dart';

/// Tabelle ausfüllen - das häufigste gebundene Format der echten AP1
/// (Nutzwertanalyse, Schreibtischtest, Subnetz-Tabelle).
///
/// Vorgegebene Zellen sind Text, Lücken sind Auswahl oder Eingabe. Passt die
/// Tabelle nicht in die Breite, wird jede Zeile zu einem Block
/// „Spaltenkopf: Wert/Eingabe“ ([AdaptiveTable]).
class TableQuestionView extends StatelessWidget {
  const TableQuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
    this.shuffleSeed = 0,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;
  final int shuffleSeed;

  Map<String, String> get _map =>
      (answer as Map<String, String>?) ?? const <String, String>{};

  void _set(String key, String? value) {
    final next = <String, String>{..._map};
    if (value == null || value.isEmpty) {
      next.remove(key);
    } else {
      next[key] = value;
    }
    onChanged(next.isEmpty ? null : next);
  }

  /// „Zeile · Spalte“ einer Lücke, z. B. „Server · IP-Adresse“.
  String _caption(int r, int c) {
    final grid = question.grid;
    final head = c < grid.first.length ? grid.first[c].text.trim() : '';
    final first = grid[r].first;
    final row = c != 0 && !first.isGap && first.text.trim().isNotEmpty
        ? first.text.trim()
        : 'Zeile $r';
    return head.isEmpty ? row : '$row · $head';
  }

  @override
  Widget build(BuildContext context) {
    final grid = question.grid;
    if (grid.isEmpty) return const SizedBox.shrink();
    final scaler = MediaQuery.textScalerOf(context);
    final style = context.text.bodyLarge!.copyWith(fontWeight: FontWeight.w600);
    final gaps = question.gridGaps;
    final filled = _map.keys.where(gaps.containsKey).length;
    final hasSelect = gaps.values.any((g) => g.options.isNotEmpty);
    final hasInput = gaps.values.any((g) => g.options.isEmpty);

    TableCellData cell(int r, int c) {
      final data = grid[r][c];
      if (!data.isGap) return TableCellData.text(data.text);
      final gap = data.gap!;
      final key = '$r.$c';
      final options = [
        for (final j in displayOrder(
          gap.options.length,
          shuffleSeed,
          salt: 'cell$key',
        ))
          gap.options[j],
      ];
      // Platzbedarf: Auswahl nach dem längsten Wort bzw. der längsten
      // Option, Eingabe einheitlich (verrät die Länge der Lösung nicht).
      double minW;
      double prefW;
      if (options.isNotEmpty) {
        var word = 0.0;
        var full = 0.0;
        for (final o in [...options, 'wählen']) {
          full = math.max(full, measureTextWidth(o, style, scaler));
          for (final w in WordSafeText.words(o)) {
            word = math.max(word, measureTextWidth(w, style, scaler));
          }
        }
        minW = math.min(word, scaler.scale(16) * 6.5) + 46;
        prefW = math.min(full, 220) + 46;
      } else {
        final unitW = gap.unit == null
            ? 0.0
            : measureTextWidth(gap.unit!, context.text.bodyMedium!, scaler) + 8;
        minW = scaler.scale(16) * (gap.numeric ? 3.2 : 4.2) + 22 + unitW;
        prefW = scaler.scale(16) * (gap.numeric ? 4.6 : 7) + 22 + unitW;
      }
      if (revealed) {
        final given = measureTextWidth(_map[key] ?? '–', style, scaler);
        final truth = measureTextWidth(
          'richtig: ${gapSolutionText(gap)}',
          style,
          scaler,
        );
        prefW = math.max(
          prefW,
          math.min(220, math.max(given + 46, truth + 22)),
        );
      }
      return TableCellData.widget(
        GapField(
          key: ValueKey('gap-$key'),
          gap: gap,
          value: _map[key],
          revealed: revealed,
          options: options,
          title: _caption(r, c),
          expand: true,
          showSolution: true,
          onChanged: (v) => _set(key, v),
        ),
        minWidth: minW,
        prefWidth: math.max(minW, prefW),
      );
    }

    final hint = [
      if (hasSelect) 'Tippe auf ein Feld und wähle den passenden Eintrag.',
      if (hasInput) 'Trage die fehlenden Werte ein.',
    ].join(' ');

    final withRationale = [
      for (final e in gaps.entries)
        if (e.value.rationale.isNotEmpty) e.key,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HintLine(
          revealed
              ? 'Auswertung: Jedes richtig gefüllte Feld zählt.'
              : '$hint ($filled von ${gaps.length} gefüllt)',
          icon: revealed
              ? Icons.fact_check_outlined
              : Icons.table_chart_outlined,
        ),
        const SizedBox(height: Gap.m),
        AdaptiveTable([
          for (var r = 0; r < grid.length; r++)
            [for (var c = 0; c < grid[r].length; c++) cell(r, c)],
        ]),
        if (revealed && withRationale.isNotEmpty) ...[
          const SizedBox(height: Gap.l),
          for (final key in withRationale) ...[
            GapFeedbackRow(
              gap: gaps[key]!,
              value: _map[key],
              caption: _caption(
                int.parse(key.split('.').first),
                int.parse(key.split('.').last),
              ),
            ),
            if (key != withRationale.last) const SizedBox(height: Gap.s),
          ],
        ],
      ],
    );
  }
}
