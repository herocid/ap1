import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/util/exam_composer.dart';
import '../../core/util/question_selector.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../state/session_controller.dart';

/// Startet Sessions. Zentral an einer Stelle, damit Dashboard, Themenliste
/// und Statistik nicht jeweils ihre eigene Auswahllogik bauen.
class SessionLauncher {
  const SessionLauncher._();

  static const dailyTitle = 'Prüfungsaufgabe des Tages';

  /// Übungsrunde mit Sofort-Feedback.
  ///
  /// [mistakesOnly] ist die Fehler-Wiederholung mit Abstand: Es kommen die
  /// heute fälligen Fehler, und wer in der Runde erneut danebenliegt, sieht
  /// die Aufgabe nach ein paar anderen noch einmal. [replace] ersetzt den
  /// aktuellen Bildschirm (Start aus der Auswertung heraus).
  static void practice(
    BuildContext context,
    WidgetRef ref, {
    String? topicId,
    String? subtopicId,
    String? title,
    bool mistakesOnly = false,
    bool focus = false,
    int count = 10,
    bool replace = false,
  }) {
    final pool = ref.read(questionsProvider);
    final progress = ref.read(progressProvider);
    final poolSize = ref.read(poolSizeProvider);
    final mistakes = ref.read(mistakeStatusProvider);

    final questions = QuestionSelector.forPractice(
      pool: pool,
      progress: progress,
      poolSize: poolSize,
      count: count,
      topicFilter: topicId,
      subtopicFilter: subtopicId,
      mistakesOnly: mistakesOnly,
      // Offene Fehler haben in jeder Runde Vorrang; in der Wiederholung
      // zählen nur die, die heute noch nicht richtig waren.
      mistakeIds: mistakesOnly ? mistakes.due : null,
    );

    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            mistakesOnly && mistakes.open.isNotEmpty
                ? 'Für heute erledigt. Die Fehler kommen an einem anderen '
                      'Tag noch einmal.'
                : 'Für diese Auswahl gibt es gerade keine Aufgaben.',
          ),
        ),
      );
      return;
    }

    final sessionTitle =
        title ??
        (mistakesOnly
            ? 'Fehler wiederholen'
            : topicId != null
            ? Topics.byId(topicId).title
            : 'Tagesübung');

    ref
        .read(sessionProvider.notifier)
        .start(
          questions: questions,
          mode: focus || topicId != null || subtopicId != null || mistakesOnly
              ? SessionMode.fokus
              : SessionMode.uebung,
          topicFilter: topicId,
          title: sessionTitle,
          requeueWrong: mistakesOnly,
        );
    _open(context, '/session', replace: replace);
  }

  /// Schwächen-Training: 10 gemischte Aufgaben, gewichtet nach Fehlerquote,
  /// Themenschwäche und Abstand seit dem letzten Abruf.
  static void weakness(
    BuildContext context,
    WidgetRef ref, {
    bool replace = false,
  }) => practice(
    context,
    ref,
    title: 'Schwächen-Training',
    focus: true,
    replace: replace,
  );

  static void querbeet(BuildContext context, WidgetRef ref, {int count = 15}) {
    final questions = QuestionSelector.arrange(
      QuestionSelector.forMix(pool: ref.read(questionsProvider), count: count),
    );
    if (questions.isEmpty) return;

    ref
        .read(sessionProvider.notifier)
        .start(
          questions: questions,
          mode: SessionMode.uebung,
          title: 'Querbeet',
        );
    context.push('/session');
  }

  /// Kurztest: eine Zufallsaufgabe nach der anderen aus allen Bereichen,
  /// ohne festes Ende - mit demselben Formatmix wie jede Runde.
  static void kurztest(BuildContext context, WidgetRef ref) {
    final pool = ref.read(questionsProvider);
    final rnd = math.Random();
    final first = QuestionSelector.nextEndless(pool, const [], rnd);
    if (first == null) return;

    ref
        .read(sessionProvider.notifier)
        .start(
          questions: [first],
          mode: SessionMode.uebung,
          title: 'Kurztest',
          supply: (asked) => QuestionSelector.nextEndless(pool, asked, rnd),
        );
    context.push('/session');
  }

  /// Prüfungssimulation: ein Unternehmen, Fallaufgaben aus verschiedenen
  /// Bereichen, Zeitlimit. Beginnt mit dem Deckblatt.
  static void exam(BuildContext context, WidgetRef ref, ExamVariant variant) {
    final paper = ExamComposer.compose(
      cases: ref.read(examCasesProvider),
      pool: ref.read(questionsProvider),
      tasks: variant.tasks,
      lastSeen: ref.read(caseLastSeenProvider),
    );
    if (paper.tasks.isEmpty) return;

    ref
        .read(sessionProvider.notifier)
        .startPaper(
          paper: paper,
          mode: SessionMode.pruefung,
          // Bei Fallaufgaben stimmt das Verhältnis von selbst (25 Punkte je
          // Aufgabe). Der Ersatzbogen bekommt dieselbe Zeit.
          limit: variant.limit,
          title: variant.title,
        );
    context.push('/pruefung-lauf');
  }

  /// Prüfungsaufgabe des Tages: eine Fallaufgabe im Prüfungsformat, ohne
  /// Zeitlimit. Zählt als Übung, nicht als Simulation.
  static void daily(BuildContext context, WidgetRef ref) {
    final paper = ref.read(dailyPaperProvider);
    if (paper == null) return;
    ref
        .read(sessionProvider.notifier)
        .startPaper(
          paper: paper,
          mode: SessionMode.uebung,
          title: dailyTitle,
          cover: false,
        );
    context.push('/pruefung-lauf');
  }

  static void _open(
    BuildContext context,
    String route, {
    required bool replace,
  }) {
    if (replace) {
      context.pushReplacement(route);
    } else {
      context.push(route);
    }
  }
}
