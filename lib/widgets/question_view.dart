import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../data/models/question.dart';
import '../data/models/topic.dart';
import 'common.dart';
import 'question_types/choice_question.dart';
import 'question_types/matching_question.dart';
import 'question_types/netzplan_question.dart';
import 'question_types/numeric_question.dart';
import 'question_types/ordering_question.dart';

/// Rahmen um jede Aufgabe: Szenario, Fragestellung, Eingabebereich und -
/// nach dem Prüfen - die Erklärung.
class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
    this.showExplanation = true,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;

  /// Im Prüfungsmodus während des Laufs aus - die Erklärung kommt erst in
  /// der Nachbesprechung.
  final bool showExplanation;

  @override
  Widget build(BuildContext context) {
    final topic = Topics.byId(question.topicId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: Gap.s,
          runSpacing: Gap.s,
          children: [
            MetaChip(
              label: topic.title,
              icon: topic.icon,
              color: context.scheme.primary,
            ),
            MetaChip(label: question.kind.label),
            MetaChip(
              label: switch (question.difficulty) {
                1 => 'Grundlagen',
                3 => 'Anspruchsvoll',
                _ => 'Prüfungsniveau',
              },
              icon: Icons.speed,
            ),
            MetaChip(
              label: '${question.points} ${question.points == 1 ? "Punkt" : "Punkte"}',
              icon: Icons.star_outline,
            ),
          ],
        ),
        const SizedBox(height: Gap.l),
        if (question.scenario != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Gap.l),
            decoration: BoxDecoration(
              color: context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border(
                left: BorderSide(color: context.scheme.primary, width: 3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Situation',
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
                const SizedBox(height: Gap.xs),
                Text(question.scenario!, style: context.text.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: Gap.l),
        ],
        Text(question.prompt, style: context.text.titleLarge),
        const SizedBox(height: Gap.xl),
        _body(context),
        if (revealed && showExplanation) ...[
          const SizedBox(height: Gap.xl),
          _ExplanationBlock(question: question, grade: grade),
        ],
      ],
    );
  }

  Widget _body(BuildContext context) {
    switch (question.kind) {
      case QuestionKind.single:
      case QuestionKind.multiple:
        return ChoiceQuestionView(
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
        );
      case QuestionKind.numeric:
        return NumericQuestionView(
          key: ValueKey('num-${question.id}'),
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
        );
      case QuestionKind.ordering:
        return OrderingQuestionView(
          key: ValueKey('ord-${question.id}'),
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
        );
      case QuestionKind.matching:
        return MatchingQuestionView(
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
        );
      case QuestionKind.netzplan:
        return NetzplanQuestionView(
          key: ValueKey('np-${question.id}'),
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
        );
    }
  }
}

class _ExplanationBlock extends StatelessWidget {
  const _ExplanationBlock({required this.question, required this.grade});

  final Question question;
  final GradeResult? grade;

  @override
  Widget build(BuildContext context) {
    final g = grade;
    final tone = g == null
        ? NoteTone.info
        : g.isCorrect
            ? NoteTone.success
            : g.isPartial
                ? NoteTone.warn
                : NoteTone.danger;

    final headline = g == null
        ? 'Erklärung'
        : g.isCorrect
            ? 'Richtig'
            : g.isPartial
                ? 'Teilweise richtig – ${(g.score * 100).round()} %'
                : 'Leider falsch';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NoteBox(
          tone: tone,
          title: headline,
          child: Text(question.explanation),
        ),
        if (question.tags.isNotEmpty) ...[
          const SizedBox(height: Gap.m),
          Wrap(
            spacing: Gap.s,
            runSpacing: Gap.s,
            children: [
              for (final t in question.tags) MetaChip(label: '#$t'),
            ],
          ),
        ],
      ],
    );
  }
}
