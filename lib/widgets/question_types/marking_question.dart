import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../common.dart';
import '../hyphenation.dart';
import 'question_material.dart';
import 'shuffle.dart';

/// Markieren: alle Zeilen antippen, die eine Bedingung erfüllen
/// (fehlerhafte Codezeilen, personenbezogene Daten, verdächtige Logzeilen).
///
/// Mit `question.mono` stehen die Zeilen als Code mit Zeilennummern in
/// ihrer festen Reihenfolge; sonst als gemischte Liste.
class MarkingQuestionView extends StatelessWidget {
  const MarkingQuestionView({
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

  Set<int> get _selected => (answer as Set<int>?) ?? const <int>{};

  void _toggle(int i) {
    if (revealed) return;
    HapticFeedback.selectionClick();
    final next = <int>{..._selected};
    next.contains(i) ? next.remove(i) : next.add(i);
    onChanged(next.isEmpty ? null : next);
  }

  @override
  Widget build(BuildContext context) {
    final q = question;
    final n = q.choices.length;
    // Code und Logs haben eine feste Reihenfolge - nur Listen mischen.
    final order = q.mono
        ? List<int>.generate(n, (i) => i)
        : displayOrder(n, shuffleSeed, salt: 'mark');
    final count = _selected.length;

    final rows = [
      for (var pos = 0; pos < n; pos++)
        _MarkRow(
          key: ValueKey('mark-${order[pos]}'),
          choice: q.choices[order[pos]],
          number: pos + 1,
          digits: '$n'.length,
          mono: q.mono,
          selected: _selected.contains(order[pos]),
          revealed: revealed,
          onTap: () => _toggle(order[pos]),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HintLine(
          revealed
              ? 'Auswertung: Grün gehört markiert, Rot war falsch markiert.'
              : 'Tippe alles an, was zutrifft. Falsch Markiertes zieht '
                    'Punkte ab. ($count markiert)',
          icon: revealed ? Icons.fact_check_outlined : Icons.touch_app_outlined,
        ),
        const SizedBox(height: Gap.m),
        if (q.mono)
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(color: context.c.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  if (i > 0) Divider(height: 1, color: context.c.border),
                  rows[i],
                ],
              ],
            ),
          )
        else
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const SizedBox(height: Gap.s),
            rows[i],
          ],
      ],
    );
  }
}

class _MarkRow extends StatelessWidget {
  const _MarkRow({
    super.key,
    required this.choice,
    required this.number,
    required this.digits,
    required this.mono,
    required this.selected,
    required this.revealed,
    required this.onTap,
  });

  final Choice choice;
  final int number;
  final int digits;
  final bool mono;
  final bool selected;
  final bool revealed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final primary = context.scheme.primary;
    final surface = mono ? Colors.transparent : context.scheme.surface;

    Color bg = surface;
    Color border = c.border;
    Color accent = c.textMuted;
    IconData icon = selected ? Icons.check_box : Icons.check_box_outline_blank;
    String? verdict;

    if (!revealed) {
      if (selected) {
        bg = primary.withValues(alpha: mono ? 0.12 : 0.07);
        border = primary;
        accent = primary;
      }
    } else if (choice.isCorrect && selected) {
      bg = c.successBg;
      border = c.success;
      accent = c.success;
      icon = Icons.check_circle;
      verdict = 'Richtig markiert';
    } else if (choice.isCorrect) {
      bg = c.successBg;
      border = c.success;
      accent = c.success;
      icon = Icons.add_circle_outline;
      verdict = 'Übersehen – gehört markiert';
    } else if (selected) {
      bg = c.dangerBg;
      border = c.danger;
      accent = c.danger;
      icon = Icons.cancel;
      verdict = 'Falsch markiert';
    }

    final scaler = MediaQuery.textScalerOf(context);
    final codeStyle = AppType.mono(
      size: 13.5,
      color: context.scheme.onSurface,
    ).copyWith(letterSpacing: 0);
    final charW = mono
        ? measureTextWidth('MMMMMMMMMM', codeStyle, scaler) / 10
        : 0.0;
    final raw = choice.text.replaceAll('\t', '    ');
    final indent = raw.length - raw.trimLeft().length;

    final text = mono
        ? Padding(
            padding: EdgeInsets.only(left: math.min(indent * charW, 56)),
            child: Text(breakableCode(raw.trim()), style: codeStyle),
          )
        : HyphenText(choice.text, style: context.text.bodyLarge);

    final feedback =
        revealed && (verdict != null || choice.rationale.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(top: Gap.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (verdict != null)
                  Text(
                    verdict,
                    style: context.text.labelSmall?.copyWith(
                      color: accent,
                      letterSpacing: 0.2,
                    ),
                  ),
                if (choice.rationale.isNotEmpty)
                  HyphenText(
                    choice.rationale,
                    style: context.text.bodyMedium?.copyWith(
                      color: verdict == null ? c.textMuted : null,
                      height: 1.4,
                    ),
                  ),
              ],
            ),
          )
        : null;

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (mono) ...[
          SizedBox(
            width: charW * math.max(2, digits) + 2,
            child: Text(
              '$number',
              textAlign: TextAlign.right,
              maxLines: 1,
              softWrap: false,
              style: codeStyle.copyWith(color: c.textMuted),
            ),
          ),
          const SizedBox(width: Gap.m),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [text, ?feedback],
          ),
        ),
        const SizedBox(width: Gap.s),
        Icon(icon, size: 22, color: selected || revealed ? accent : c.border),
      ],
    );

    final radius = mono ? BorderRadius.zero : BorderRadius.circular(Radii.m);
    return Semantics(
      checked: selected,
      button: !revealed,
      child: Material(
        color: bg,
        borderRadius: radius,
        child: InkWell(
          onTap: revealed ? null : onTap,
          borderRadius: radius,
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            alignment: Alignment.centerLeft,
            padding: mono
                ? const EdgeInsets.fromLTRB(Gap.s, Gap.m, Gap.m, Gap.m)
                : const EdgeInsets.all(Gap.l),
            decoration: mono
                ? BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: selected || (revealed && choice.isCorrect)
                            ? border
                            : Colors.transparent,
                        width: 4,
                      ),
                    ),
                  )
                : BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(
                      color: border,
                      width: selected || (revealed && choice.isCorrect) ? 2 : 1,
                    ),
                  ),
            child: content,
          ),
        ),
      ),
    );
  }
}
