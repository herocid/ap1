import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/util/answer_format.dart';
import '../../core/util/exam_composer.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/topic.dart';
import '../../state/session_controller.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../learn/review_tile.dart';
import 'exam_widgets.dart';

/// Erreichte und mögliche Punkte einer Gruppe von Teilaufgaben.
class ScoreSum {
  ScoreSum();

  double earned = 0;
  int possible = 0;
  int seconds = 0;

  double get lost => possible - earned;
  double get ratio => possible == 0 ? 0 : earned / possible;

  void add(SessionItem i) {
    earned += i.earned;
    possible += i.question.points;
    seconds += i.seconds;
  }

  static Map<K, ScoreSum> group<K>(
    Iterable<SessionItem> items,
    K Function(SessionItem) key,
  ) {
    final out = <K, ScoreSum>{};
    for (final i in items) {
      out.putIfAbsent(key(i), ScoreSum.new).add(i);
    }
    return out;
  }
}

/// Auswertung eines Prüfungsbogens: Ergebnis mit Note, Punkte je Aufgabe,
/// je Antwortformat und je Katalogbereich, danach die Durchsicht.
///
/// Die drei Aufschlüsselungen beantworten die Frage, die nach der Prüfung
/// zählt: Wo gehen die Punkte verloren - beim Rechnen, beim Formulieren
/// oder bei Diagrammen?
class ExamResultView extends StatefulWidget {
  const ExamResultView({super.key, required this.session});

  final SessionState session;

  @override
  State<ExamResultView> createState() => _ExamResultViewState();
}

class _ExamResultViewState extends State<ExamResultView> {
  final _situationOpen = <int>{};

  @override
  void initState() {
    super.initState();
    // Bestandene Prüfungssimulation (Note 4 oder besser): einmal feiern.
    final s = widget.session;
    if (s.isExam && (s.totalScore * 100).round() >= 50) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Celebration.show(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final paper = session.paper!;
    final percent = session.totalScore;
    final note = ihkNote(percent);
    final earned = session.earnedPoints;
    final possible = session.possiblePoints;
    final passed = (percent * 100).round() >= 50;
    final full = possible == 100;

    final byFormat =
        ScoreSum.group(
          session.items,
          (i) => AnswerFormat.of(i.question),
        ).entries.toList()..sort((a, b) {
          // Wo am meisten fehlt, steht oben.
          final byLost = b.value.lost.compareTo(a.value.lost);
          return byLost != 0 ? byLost : a.key.index.compareTo(b.key.index);
        });
    final byArea = ScoreSum.group(
      session.items,
      (i) => Topics.byId(i.question.topicId).areaId,
    );
    final weakest = byFormat.isEmpty || byFormat.first.value.lost < 1
        ? null
        : byFormat.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          padding: const EdgeInsets.all(Gap.xl),
          child: Column(
            children: [
              ReadinessRing(
                value: (percent * 100).round(),
                label: session.isExam ? 'Note ${note.note}' : 'Prozent',
                caption: session.isExam ? note.label : null,
                size: 148,
              ),
              const SizedBox(height: Gap.m),
              Text(
                '${formatPoints(earned)} von $possible Punkten',
                textAlign: TextAlign.center,
                style: context.text.headlineSmall,
              ),
              const SizedBox(height: Gap.xs),
              Text(
                session.limit != null
                    ? 'Zeit: ${formatDuration(session.elapsed)} von '
                          '${formatDuration(session.limit!)}'
                    : 'Zeit: ${formatDuration(session.elapsed)}  ·  Richtzeit '
                          '${ExamComposer.guideTime(possible).inMinutes} min',
                textAlign: TextAlign.center,
                style: context.text.bodyMedium?.copyWith(
                  color: context.c.textMuted,
                ),
              ),
              if (session.isExam) ...[
                const SizedBox(height: Gap.l),
                NoteBox(
                  tone: passed ? NoteTone.success : NoteTone.warn,
                  title: passed ? 'Bestanden' : 'Noch nicht bestanden',
                  child: Text(
                    [
                      if (passed)
                        'Bestanden ist ab 50 von 100 Punkten, und das hast du '
                            'geschafft (Note ${note.note}, ${note.label}).'
                      else
                        'Bestanden ist ab 50 von 100 Punkten. Das hier ist '
                            'eine Übung, kein Urteil. Unten siehst du, wo '
                            'die Punkte liegen geblieben sind.',
                      if (!full)
                        'Die Note ist auf 100 Punkte hochgerechnet '
                            '(${(percent * 100).round()} %).',
                    ].join(' '),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: Gap.xl),

        if (paper.tasks.length > 1) ...[
          const SectionHeader('Punkte je Aufgabe'),
          for (var t = 0; t < paper.tasks.length; t++) ...[
            _taskRow(session, paper, t),
            const SizedBox(height: Gap.s),
          ],
          const SizedBox(height: Gap.xl),
        ],

        const SectionHeader(
          'Nach Antwortformat',
          subtitle: 'Wo die Punkte verloren gehen (oben fehlt am meisten).',
        ),
        if (weakest != null) ...[
          NoteBox(
            tone: NoteTone.info,
            child: Text(
              'Die meisten Punkte fehlen ${weakest.key.where}. Dort hast '
              'du ${formatPoints(weakest.value.lost)} von '
              '${weakest.value.possible} P. liegen gelassen.',
            ),
          ),
          const SizedBox(height: Gap.s),
        ],
        for (final e in byFormat) ...[
          ScoreRow(
            icon: e.key.icon,
            title: e.key.label,
            earned: e.value.earned,
            possible: e.value.possible,
          ),
          const SizedBox(height: Gap.s),
        ],
        const SizedBox(height: Gap.xl),

        if (byArea.length > 1) ...[
          const SectionHeader('Nach Katalogbereich'),
          for (final area in ExamAreas.all)
            if (byArea[area.id] != null) ...[
              ScoreRow(
                icon: area.icon,
                overline: 'BEREICH ${area.number}',
                title: area.title,
                earned: byArea[area.id]!.earned,
                possible: byArea[area.id]!.possible,
              ),
              const SizedBox(height: Gap.s),
            ],
          const SizedBox(height: Gap.xl),
        ],

        const SectionHeader(
          'Durchsicht',
          subtitle:
              'Aufklappen zeigt deine Antwort, die Lösung und die '
              'Begründung.',
        ),
        for (var t = 0; t < paper.tasks.length; t++) ...[
          TaskHeader(
            number: t + 1,
            task: paper.tasks[t],
            expanded: _situationOpen.contains(t),
            onToggle: () => setState(() {
              if (!_situationOpen.remove(t)) _situationOpen.add(t);
            }),
          ),
          const SizedBox(height: Gap.s),
          for (var p = 0; p < paper.tasks[t].parts.length; p++) ...[
            ReviewTile(
              index: paper.startOf(t) + p,
              item: session.items[paper.startOf(t) + p],
              label: '${ExamPaper.partLetter(p)})',
              startedAt: session.startedAt,
              showCaseContext: false,
            ),
            const SizedBox(height: Gap.s),
          ],
          const SizedBox(height: Gap.m),
        ],
      ],
    );
  }

  Widget _taskRow(SessionState session, ExamPaper paper, int t) {
    final task = paper.tasks[t];
    final start = paper.startOf(t);
    final sum = ScoreSum();
    for (var i = start; i < start + task.parts.length; i++) {
      sum.add(session.items[i]);
    }
    final guide = ExamComposer.guideTime(task.points);
    return ScoreRow(
      icon: task.areaId == null
          ? Icons.assignment_outlined
          : ExamAreas.byId(task.areaId!).icon,
      overline: 'AUFGABE ${t + 1}',
      title: task.title,
      earned: sum.earned,
      possible: sum.possible,
      caption:
          'Zeit ${formatDuration(Duration(seconds: sum.seconds))}  ·  '
          'Richtzeit ${guide.inMinutes} min',
    );
  }
}
