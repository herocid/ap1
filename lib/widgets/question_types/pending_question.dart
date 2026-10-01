import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/question.dart';

/// Vorläufige Anzeige für die neuen Aufgabenarten (Lückentext, Tabelle,
/// Freitext, Markieren, Paare), bis ihre eigenen Ansichten fertig sind.
/// Zeigt die Aufgabe lesbar an, ist aber noch nicht bedienbar.
class PendingQuestionView extends StatelessWidget {
  const PendingQuestionView({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    final q = question;
    final lines = <String>[
      if (q.clozeText != null) q.clozeText!,
      for (final row in q.grid)
        row.map((c) => c.isGap ? '____' : c.text).join(' | '),
      for (final c in q.criteria) '• ${c.text} (${c.points} P.)',
      if (q.kind == QuestionKind.marking)
        for (final c in q.choices) c.text,
      for (final p in q.pairs) '${p.left} – ${p.right}',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: context.c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: context.c.border),
      ),
      child: Text(lines.join('\n'), style: context.text.bodyMedium),
    );
  }
}
