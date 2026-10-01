import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/question.dart';
import '../hyphenation.dart';
import 'question_material.dart';
import 'shuffle.dart';

/// Einfach- und Mehrfachauswahl.
///
/// Nach dem Prüfen wird JEDE Option eingefärbt und mit ihrer Begründung
/// versehen - nicht nur die angekreuzte. Das ist der eigentliche Lerneffekt:
/// zu verstehen, warum die drei anderen Antworten falsch sind.
///
/// Die Optionen stehen in gemischter Reihenfolge ([shuffleSeed]); die
/// Antwort bleibt in Original-Indizes.
class ChoiceQuestionView extends StatelessWidget {
  const ChoiceQuestionView({
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

  /// Anzeigeposition -> Original-Index. „Alle genannten“ und ähnliche
  /// Optionen bleiben am Ende; verweist eine Option auf die Position einer
  /// anderen („Antwort A“), wird gar nicht gemischt.
  static List<int> orderFor(Question q, int seed) {
    final texts = [for (final c in q.choices) c.text];
    if (refersToPosition(texts)) {
      return List<int>.generate(texts.length, (i) => i);
    }
    return displayOrder(
      texts.length,
      seed,
      salt: 'choice',
      pinLast: (i) => isCatchAllOption(texts[i]),
    );
  }

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
    final order = orderFor(question, shuffleSeed);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isMulti && !revealed)
          const Padding(
            padding: EdgeInsets.only(bottom: Gap.m),
            child: HintLine(
              'Mehrere Antworten können richtig sein. '
              'Falsch angekreuzte Optionen ziehen Punkte ab.',
              icon: Icons.checklist,
            ),
          ),
        for (var pos = 0; pos < order.length; pos++) ...[
          _ChoiceRow(
            key: ValueKey('choice-${order[pos]}'),
            choice: question.choices[order[pos]],
            // Der Buchstabe folgt der Anzeige, nicht dem Original-Index.
            index: pos,
            selected: _selected.contains(order[pos]),
            revealed: revealed,
            isMulti: _isMulti,
            onTap: () => _toggle(order[pos]),
          ),
          if (pos < order.length - 1) const SizedBox(height: Gap.s),
        ],
      ],
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    super.key,
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

    final thick = selected || (revealed && choice.isCorrect);
    return Semantics(
      checked: isMulti ? selected : null,
      selected: isMulti ? null : selected,
      button: !revealed,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.m),
        child: InkWell(
          onTap: revealed ? null : onTap,
          borderRadius: BorderRadius.circular(Radii.m),
          child: Container(
            constraints: const BoxConstraints(minHeight: 60),
            // Der dickere Rahmen wird vom Innenabstand abgezogen - sonst
            // springt der Text beim Antippen um 1 px.
            padding: EdgeInsets.all(thick ? Gap.l - 1 : Gap.l),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(color: border, width: thick ? 2 : 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: HyphenText(
                          choice.text,
                          style: context.text.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                if (revealed && choice.rationale.isNotEmpty) ...[
                  const SizedBox(height: Gap.m),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: HyphenText(
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
        border: Border.all(
          color: selected ? accent : context.c.border,
          width: 1.6,
        ),
      ),
      child: Text(
        letter,
        textScaler: TextScaler.noScaling,
        style: context.text.labelSmall?.copyWith(
          color: selected ? context.scheme.onPrimary : context.c.textMuted,
        ),
      ),
    );
  }
}
