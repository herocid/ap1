import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../data/models/question.dart';
import '../data/models/topic.dart';
import '../data/seed/seed_data.dart' show kCaseById;
import 'common.dart';
import 'diagrams/diagram_view.dart';
import 'hyphenation.dart';
import 'question_types/choice_question.dart';
import 'question_types/cloze_question.dart';
import 'question_types/marking_question.dart';
import 'question_types/matching_question.dart';
import 'question_types/netzplan_question.dart';
import 'question_types/numeric_question.dart';
import 'question_types/open_question.dart';
import 'question_types/ordering_question.dart';
import 'question_types/pairs_question.dart';
import 'question_types/question_material.dart';
import 'question_types/shuffle.dart';
import 'question_types/table_question.dart';

/// Rahmen um jede Aufgabe: Ausgangssituation, Material (Tabelle, Code,
/// Zeichnung), Fragestellung, Eingabebereich und - nach dem Prüfen - die
/// Erklärung.
///
/// Antwortoptionen, Zuordnungs-Items, Paare und Wortbänke werden in der
/// Anzeige gemischt; die Antwort bleibt in Original-Indizes. Die Mischung
/// hängt an [shuffleSeed]: gleicher Wert, gleiche Reihenfolge. Ohne Angabe
/// würfelt die Ansicht selbst - neu bei jeder frisch begonnenen Aufgabe,
/// gleichbleibend beim Zurückblättern zu einer beantworteten.
class QuestionView extends StatefulWidget {
  const QuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
    this.showExplanation = true,
    this.showCaseContext = true,
    this.showPoints = true,
    this.shuffleSeed,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;

  /// Im Prüfungsmodus während des Laufs aus - die Erklärung kommt erst in
  /// der Nachbesprechung.
  final bool showExplanation;

  /// Ausgangssituation der Fallaufgabe über der Aufgabe zeigen. Die
  /// Prüfungssimulation stellt sie selbst dar und schaltet das ab.
  final bool showCaseContext;

  /// Punkte neben der Fragestellung zeigen. Der Prüfungslauf hat sie schon
  /// in seiner Kopfzeile und schaltet das ab.
  final bool showPoints;

  /// Zufallswert für die Reihenfolge in der Anzeige, z. B. einer je
  /// Durchgang. Jede Aufgabe mischt damit anders (die Aufgaben-ID geht mit
  /// ein).
  final int? shuffleSeed;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  late int _seed;

  @override
  void initState() {
    super.initState();
    _seed = _resolveSeed();
  }

  @override
  void didUpdateWidget(covariant QuestionView old) {
    super.didUpdateWidget(old);
    if (old.question.id != widget.question.id ||
        old.shuffleSeed != widget.shuffleSeed) {
      _seed = _resolveSeed();
    }
  }

  int _resolveSeed() {
    final id = widget.question.id;
    final given = widget.shuffleSeed;
    if (given != null) return (given ^ stableHash(id)) & 0x3FFFFFFF;
    return ShuffleSeeds.forQuestion(
      id,
      fresh: widget.answer == null && !widget.revealed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    final topic = Topics.byId(question.topicId);
    final examCase = widget.showCaseContext && question.caseId != null
        ? kCaseById[question.caseId]
        : null;
    const gap = SizedBox(height: Gap.l);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eine ruhige Überzeile statt vier Chips: Die Frage soll das
        // Auffälligste auf dem Bildschirm sein, nicht ihre Metadaten.
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(topic.icon, size: 15, color: context.scheme.primary),
                      const SizedBox(width: Gap.s),
                      Expanded(
                        child: HyphenText(
                          topic.title.toUpperCase(),
                          style: context.text.labelSmall?.copyWith(
                            color: context.scheme.primary,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Gap.xs),
                  Text(
                    [
                      question.kind.label,
                      switch (question.difficulty) {
                        1 => 'Grundlagen',
                        3 => 'Anspruchsvoll',
                        _ => 'Prüfungsniveau',
                      },
                    ].join('  ·  '),
                    style: context.text.labelSmall?.copyWith(
                      color: context.c.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.showPoints) ...[
              const SizedBox(width: Gap.s),
              PointsBadge(question.points),
            ],
          ],
        ),
        gap,
        if (examCase != null) ...[CaseContextBox(examCase: examCase), gap],
        if (question.scenario != null) ...[
          MaterialBox(
            label: 'Situation',
            child: HyphenText(
              question.scenario!,
              style: context.text.bodyMedium,
            ),
          ),
          gap,
        ],
        if (question.table != null && question.table!.isNotEmpty) ...[
          AdaptiveTable.text(question.table!),
          gap,
        ],
        if (question.code != null && question.code!.trim().isNotEmpty) ...[
          MaterialCodeBlock(question.code!),
          gap,
        ],
        if (question.diagram != null) ...[DiagramView(question.diagram!), gap],
        HyphenText(question.prompt, style: context.text.titleLarge),
        const SizedBox(height: Gap.xl),
        _body(context),
        if (widget.revealed && widget.showExplanation) ...[
          const SizedBox(height: Gap.xl),
          _ExplanationBlock(question: question, grade: widget.grade),
        ],
      ],
    );
  }

  Widget _body(BuildContext context) {
    final question = widget.question;
    final answer = widget.answer;
    final onChanged = widget.onChanged;
    final revealed = widget.revealed;
    final grade = widget.grade;

    switch (question.kind) {
      case QuestionKind.single:
      case QuestionKind.multiple:
        return ChoiceQuestionView(
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
          shuffleSeed: _seed,
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
          shuffleSeed: _seed,
        );
      case QuestionKind.matching:
        return MatchingQuestionView(
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
          shuffleSeed: _seed,
        );
      case QuestionKind.cloze:
        return ClozeQuestionView(
          key: ValueKey('cloze-${question.id}'),
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
          shuffleSeed: _seed,
        );
      case QuestionKind.table:
        return TableQuestionView(
          key: ValueKey('table-${question.id}'),
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
          shuffleSeed: _seed,
        );
      case QuestionKind.open:
        return OpenQuestionView(
          key: ValueKey('open-${question.id}'),
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
        );
      case QuestionKind.marking:
        return MarkingQuestionView(
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
          shuffleSeed: _seed,
        );
      case QuestionKind.pairs:
        return PairsQuestionView(
          key: ValueKey('pairs-${question.id}'),
          question: question,
          answer: answer,
          onChanged: onChanged,
          revealed: revealed,
          grade: grade,
          shuffleSeed: _seed,
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
    // Freitext bewertet der Prüfling selbst - „Leider falsch“ wäre hier das
    // falsche Signal. Die Punkte stehen in der Selbstbewertung.
    final isOpen = question.kind == QuestionKind.open;
    final tone = g == null || isOpen
        ? NoteTone.info
        : g.isCorrect
        ? NoteTone.success
        : g.isPartial
        ? NoteTone.warn
        : NoteTone.danger;

    final headline = isOpen
        ? 'Bewertungshinweis'
        : g == null
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
          child: HyphenText(question.explanation),
        ),
        if (question.tags.isNotEmpty) ...[
          const SizedBox(height: Gap.m),
          Wrap(
            spacing: Gap.s,
            runSpacing: Gap.s,
            children: [for (final t in question.tags) MetaChip(label: '#$t')],
          ),
        ],
      ],
    );
  }
}
