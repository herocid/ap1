import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/util/answer_format.dart';
import '../../data/models/topic.dart';
import '../../state/session_controller.dart';
import '../../widgets/common.dart';
import 'question_host.dart';

/// Eine Aufgabe in der Durchsicht: zugeklappt Vorschau und Punkte,
/// aufgeklappt die ganze Aufgabe mit eigener Antwort, Lösung und Begründung.
class ReviewTile extends ConsumerWidget {
  const ReviewTile({
    super.key,
    required this.index,
    required this.item,
    required this.label,
    required this.startedAt,
    this.showCaseContext = true,
  });

  /// Position der Aufgabe in der Session (für die Neubewertung).
  final int index;
  final SessionItem item;

  /// „3.“ in der Übung, „b)“ im Prüfungsbogen.
  final String label;
  final DateTime startedAt;
  final bool showCaseContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final g = item.grade;
    final (color, icon, word) = g == null
        ? (context.c.textMuted, Icons.help_outline, 'offen')
        : g.isCorrect
        ? (context.c.success, Icons.check_circle, 'richtig')
        : item.earned > 0
        ? (context.c.flame, Icons.adjust, 'teilweise')
        : (context.c.danger, Icons.cancel, 'falsch');

    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.l),
      child: Container(
        decoration: BoxDecoration(
          color: context.scheme.surface,
          borderRadius: BorderRadius.circular(Radii.l),
          border: Border.all(color: context.c.border),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: Gap.l),
            childrenPadding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
            leading: Icon(icon, color: color, semanticLabel: word),
            // Vorschau - aufgeklappt steht die ganze Aufgabe darunter.
            title: ClampedText(
              '$label ${item.question.prompt}',
              maxLines: 2,
              style: context.text.bodyLarge,
            ),
            subtitle: Text(
              '${AnswerFormat.of(item.question).label} · '
              '${Topics.byId(item.question.topicId).title} · '
              '${formatPoints(item.earned)} von ${item.question.points} P.'
              '${item.retry ? ' · 2. Anlauf' : ''}',
              style: context.text.labelSmall?.copyWith(
                color: context.c.textMuted,
              ),
            ),
            children: [
              QuestionHost(
                question: item.question,
                answer: item.answer,
                // Freitext lässt sich auch hier noch selbst bewerten.
                onChanged: (a) =>
                    ref.read(sessionProvider.notifier).regradeAt(index, a),
                revealed: true,
                grade: item.grade,
                shuffleSeed: QuestionHost.seedFor(startedAt, item.question),
                showCaseContext: showCaseContext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
