import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/util/question_selector.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../state/session_controller.dart';

/// Startet Sessions. Zentral an einer Stelle, damit Dashboard, Themenliste
/// und Statistik nicht jeweils ihre eigene Auswahllogik bauen.
class SessionLauncher {
  const SessionLauncher._();

  static void practice(
    BuildContext context,
    WidgetRef ref, {
    String? topicId,
    bool mistakesOnly = false,
    int count = 10,
  }) {
    final pool = ref.read(questionsProvider);
    final progress = ref.read(progressProvider);
    final poolSize = ref.read(poolSizeProvider);

    final questions = QuestionSelector.forPractice(
      pool: pool,
      progress: progress,
      poolSize: poolSize,
      count: count,
      topicFilter: topicId,
      mistakesOnly: mistakesOnly,
    );

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Für diese Auswahl gibt es gerade keine Aufgaben.'),
        ),
      );
      return;
    }

    final title = mistakesOnly
        ? 'Fehlerspeicher'
        : topicId != null
            ? Topics.byId(topicId).title
            : 'Tagesübung';

    ref.read(sessionProvider.notifier).start(
          questions: questions,
          mode: topicId != null || mistakesOnly
              ? SessionMode.fokus
              : SessionMode.uebung,
          topicFilter: topicId,
          title: title,
        );
    context.push('/session');
  }

  static void exam(
    BuildContext context,
    WidgetRef ref, {
    required int count,
    required Duration limit,
    required String title,
  }) {
    final pool = ref.read(questionsProvider);
    final questions = QuestionSelector.forExam(pool: pool, count: count);
    if (questions.isEmpty) return;

    ref.read(sessionProvider.notifier).start(
          questions: questions,
          mode: SessionMode.pruefung,
          limit: limit,
          title: title,
        );
    context.push('/session');
  }
}
