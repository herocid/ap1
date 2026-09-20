import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/question.dart';

/// Einfach- und Mehrfachauswahl.
///
/// Nach dem Prüfen wird JEDE Option eingefärbt und mit ihrer Begründung
/// versehen - nicht nur die angekreuzte. Das ist der eigentliche Lerneffekt:
/// zu verstehen, warum die drei anderen Antworten falsch sind.
class ChoiceQuestionView extends StatelessWidget {
  const ChoiceQuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;

  Set<int> get _selected => (answer as Set<int>?) ?? const <int>{};

  bool get _isMulti => question.kind == QuestionKind.multiple;

  void _toggle(int i) {
    if (revealed) return;
    if (_isMulti) {
      final next = {..._selected};
      next.contains(i) ? next.remove(i) : next.add(i);
      onChanged(next);
    } else {
      onChanged(<int>{i});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isMulti)
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.m),
            child: Text(
              'Mehrere Antworten können richtig sein. '
              'Falsch angekreuzte Optionen ziehen Punkte ab.',
              style:
                  context.text.labelSmall?.copyWith(color: context.c.textMuted),
            ),
          ),
        for (var i = 0; i < question.choices.length; i++) ...[
          _ChoiceRow(
            choice: question.choices[i],
            index: i,
            selected: _selected.contains(i),
            revealed: revealed,
            isMulti: _isMulti,
            onTap: () => _toggle(i),
          ),
          if (i < question.choices.length - 1) const SizedBox(height: Gap.s),
        ],
      ],
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.choice,
    required this.index,
    required this.selected,
    required this.revealed,
    required this.isMulti,
    required this.onTap,
  });

  final Choice choice;
  final int index;
  final bool selected;
  final bool revealed;
  final bool isMulti;
  final VoidCallback onTap;

  static const _letters = 'ABCDEFGH';

  @override
  Widget build(BuildContext context) {
    final c = context.c;

    Color border = c.border;
    Color bg = context.scheme.surface;
    Color accent = c.textMuted;
    IconData? marker;

    if (!revealed) {
      if (selected) {
        border = context.scheme.primary;
        bg = context.scheme.primary.withValues(alpha: 0.07);
        accent = context.scheme.primary;
      }
    } else {
      if (choice.isCorrect) {
        border = c.success;
        bg = c.successBg;
        accent = c.success;
        marker = Icons.check_circle;
      } else if (selected) {
        border = c.danger;
        bg = c.dangerBg;
        accent = c.danger;
        marker = Icons.cancel;
      } else {
        bg = context.scheme.surface;
      }
    }

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(Radii.m),
      child: InkWell(
        onTap: revealed ? null : onTap,
        borderRadius: BorderRadius.circular(Radii.m),
        child: Container(
          padding: const EdgeInsets.all(Gap.l),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.m),
            border: Border.all(
              color: border,
              width: (selected || (revealed && choice.isCorrect)) ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Marker(
                    letter: _letters[index % _letters.length],
                    selected: selected,
                    revealed: revealed,
                    accent: accent,
                    icon: marker,
                    isMulti: isMulti,
                  ),
                  const SizedBox(width: Gap.m),
                  Expanded(
                    child: Text(choice.text, style: context.text.bodyLarge),
                  ),
                ],
              ),
              if (revealed && choice.rationale.isNotEmpty) ...[
                const SizedBox(height: Gap.m),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    choice.rationale,
                    style: context.text.bodyMedium?.copyWith(
                      color: choice.isCorrect || selected
                          ? accent
                          : c.textMuted,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Marker extends StatelessWidget {
  const _Marker({
    required this.letter,
    required this.selected,
    required this.revealed,
    required this.accent,
    required this.isMulti,
    this.icon,
  });

  final String letter;
  final bool selected;
  final bool revealed;
  final Color accent;
  final bool isMulti;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final shape = isMulti
        ? BorderRadius.circular(6)
        : BorderRadius.circular(Radii.pill);

    if (revealed && icon != null) {
      return Icon(icon, size: 28, color: accent);
    }

    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: shape,
        color: selected ? accent : Colors.transparent,
        border: Border.all(color: selected ? accent : context.c.border, width: 1.6),
      ),
      child: Text(
        letter,
        style: context.text.labelSmall?.copyWith(
          color: selected ? context.scheme.onPrimary : context.c.textMuted,
        ),
      ),
    );
  }
}
