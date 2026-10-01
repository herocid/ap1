import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/achievements.dart';
import '../../core/util/answer_format.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../state/session_controller.dart';
import '../../widgets/achievement_badge.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../../widgets/mascot.dart';
import '../exam/exam_result_view.dart';
import '../exam/exam_widgets.dart';
import 'review_tile.dart';
import 'session_launcher.dart';

export '../../core/util/answer_format.dart' show ihkNote;

/// Auswertung nach einer Session.
///
/// Der wichtigste Teil ist nicht die Prozentzahl, sondern die Liste darunter:
/// jede Aufgabe aufklappbar mit der vollständigen Erklärung. Wer nach der
/// Simulation nur "58 %" sieht, hat nichts gelernt.
///
/// Prüfungsbögen (Simulation, Aufgabe des Tages) haben eine eigene
/// Auswertung ([ExamResultView]); Rahmen, Abzeichen und der nächste Schritt
/// sind für beide gleich.
class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  /// Die zuletzt gezeigte Auswertung. Startet von hier aus die nächste
  /// Runde, bleibt dieser Bildschirm während des Seitenwechsels noch kurz
  /// sichtbar - dann mit dem alten Ergebnis statt mit „keine Auswertung“.
  SessionState? _shown;

  /// Konfetti höchstens einmal je Auswertung.
  bool _celebrated = false;

  /// Zurück dorthin, wo die Runde gestartet wurde - Startseite, Quiz,
  /// Prüfung oder die Session eines Themengebiets.
  void _leave() {
    ref.read(sessionProvider.notifier).clear();
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final live = ref.watch(sessionProvider);
    if (live != null && live.finished) _shown = live;
    final session = _shown;

    if (session == null) {
      return Scaffold(
        appBar: AppBar(),
        body: EmptyState(
          icon: Icons.assessment_outlined,
          title: 'Keine Auswertung vorhanden',
          message: 'Beende zuerst eine Lernrunde.',
          action: FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Fertig'),
          ),
        ),
      );
    }

    final achievements = ref.watch(achievementsProvider);
    final newBadges = [
      for (final e in achievements.entries)
        if (e.value.earned && !session.badgesBefore.contains(e.key)) e.key,
    ];
    // Konfetti nur bei Meilensteinen: neues Abzeichen oder Tagesziel in
    // dieser Runde gerade erreicht (vorher noch nicht).
    if (!_celebrated) {
      _celebrated = true;
      final today = ref.read(progressProvider).answeredToday();
      final goal = ref.read(profileProvider).dailyGoal;
      final before = today - session.checkedCount;
      final goalJustReached = goal > 0 && today >= goal && before < goal;
      if (newBadges.isNotEmpty || goalJustReached) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) Celebration.show(context);
        });
      }
    }
    final dueMistakes = ref.watch(mistakeStatusProvider).due.length;
    final percent = session.totalScore;
    final isPaper = session.paper != null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _leave();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _leave,
            tooltip: 'Schließen',
          ),
          // Kurz gehalten: Mit großer Schrift passt auf 320 px nicht mehr -
          // welche Runde es war, steht in der Zeile darunter.
          title: const Text('Auswertung'),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
          children: [
            ReadableWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.title.toUpperCase(),
                    style: context.text.labelSmall?.copyWith(
                      color: context.scheme.primary,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: Gap.s),
                  MascotSays(
                    mood: percent >= 0.8
                        ? MascotMood.cheer
                        : percent >= 0.5
                        ? MascotMood.happy
                        : MascotMood.oops,
                    title: percent >= 0.8
                        ? 'Stark!'
                        : percent >= 0.5
                        ? 'Gut dabei.'
                        : 'Kein Problem.',
                    text: percent >= 0.8
                        ? 'Das sitzt. Genau so geht es in der AP1 weiter.'
                        : percent >= 0.5
                        ? 'Die Hälfte hast du sicher. Schau dir unten an, '
                              'wo die Punkte fehlen.'
                        : 'Fehler gehören zum Lernen. Was heute danebenging, '
                              'kommt in der Fehler-Wiederholung wieder - bis '
                              'es an zwei Tagen sitzt.',
                  ),
                  const SizedBox(height: Gap.l),
                  if (newBadges.isNotEmpty) ...[
                    _NewBadges(badges: newBadges, statuses: achievements),
                    const SizedBox(height: Gap.l),
                  ],
                  if (isPaper)
                    ExamResultView(session: session)
                  else
                    _PracticeResult(session: session),
                  const SizedBox(height: Gap.m),

                  // Genau ein empfohlener nächster Schritt, dazu „Fertig“.
                  if (dueMistakes > 0) ...[
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => SessionLauncher.practice(
                          context,
                          ref,
                          mistakesOnly: true,
                          replace: true,
                        ),
                        icon: const Icon(Icons.replay),
                        label: Text(
                          dueMistakes == 1
                              ? '1 Fehler wiederholen'
                              : '$dueMistakes Fehler wiederholen',
                        ),
                      ),
                    ),
                    const SizedBox(height: Gap.s),
                  ] else if (!isPaper && !session.endless) ...[
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => SessionLauncher.weakness(
                          context,
                          ref,
                          replace: true,
                        ),
                        icon: const Icon(Icons.fitness_center_rounded),
                        label: const Text('Schwächen-Training'),
                      ),
                    ),
                    const SizedBox(height: Gap.s),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _leave,
                      child: const Text('Fertig'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Auswertung einer Übungsrunde: Punkte, Formate mit den meisten Fehlern,
/// Themen und alle Aufgaben zum Aufklappen.
class _PracticeResult extends StatelessWidget {
  const _PracticeResult({required this.session});

  final SessionState session;

  @override
  Widget build(BuildContext context) {
    final percent = session.totalScore;
    final correct = session.items
        .where((i) => i.grade?.isCorrect == true)
        .length;
    final partial = session.items
        .where((i) => i.grade?.isCorrect != true && i.earned > 0)
        .length;
    final wrong = session.items.length - correct - partial;

    // Themenauswertung dieser Runde (nicht der Gesamtstatistik).
    final byTopic = ScoreSum.group(session.items, (i) => i.question.topicId);

    // Höchstens zwei Formate - die mit den meisten verlorenen Punkten.
    final weakFormats =
        ScoreSum.group(
            session.items,
            (i) => AnswerFormat.of(i.question),
          ).entries.where((e) => e.value.lost >= 0.5).toList()
          ..sort((a, b) => b.value.lost.compareTo(a.value.lost));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          padding: const EdgeInsets.all(Gap.xl),
          child: LayoutBuilder(
            builder: (context, box) {
              final target = (percent * 100).round();
              final reduce =
                  MediaQuery.maybeDisableAnimationsOf(context) ?? false;
              final ring = reduce
                  ? ReadinessRing(value: target, label: 'Prozent', size: 132)
                  : TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: target.toDouble()),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOutCubic,
                      builder: (context, v, _) => ReadinessRing(
                        value: v.round(),
                        label: 'Prozent',
                        size: 132,
                      ),
                    );
              final facts = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${formatPoints(session.earnedPoints)} von '
                    '${session.possiblePoints} Punkten',
                    style: context.text.titleMedium,
                  ),
                  const SizedBox(height: Gap.s),
                  _Tally(
                    color: context.c.success,
                    icon: Icons.check_circle,
                    count: correct,
                    label: 'richtig',
                  ),
                  if (partial > 0)
                    _Tally(
                      color: context.c.flame,
                      icon: Icons.adjust,
                      count: partial,
                      label: 'teilweise',
                    ),
                  _Tally(
                    color: context.c.danger,
                    icon: Icons.cancel,
                    count: wrong,
                    label: 'falsch',
                  ),
                  const SizedBox(height: Gap.s),
                  Text(
                    'Zeit: ${formatDuration(session.elapsed)}',
                    style: context.text.labelSmall?.copyWith(
                      color: context.c.textMuted,
                    ),
                  ),
                ],
              );
              // Neben dem Ring braucht der Text Platz für „12 teilweise“ -
              // auf schmalen Handys oder mit großer Schrift steht er darunter.
              final scale = MediaQuery.textScalerOf(context).scale(1);
              final beside = box.maxWidth - 132 - Gap.xl >= 150 * scale;
              return beside
                  ? Row(
                      children: [
                        ring,
                        const SizedBox(width: Gap.xl),
                        Expanded(child: facts),
                      ],
                    )
                  : Column(
                      children: [
                        ring,
                        const SizedBox(height: Gap.l),
                        facts,
                      ],
                    );
            },
          ),
        ),
        const SizedBox(height: Gap.xl),

        if (weakFormats.isNotEmpty) ...[
          const SectionHeader(
            'Hier fehlen die meisten Punkte',
            subtitle: 'Nach Antwortformat - das kommt im Training wieder.',
          ),
          for (final e in weakFormats.take(2)) ...[
            ScoreRow(
              icon: e.key.icon,
              title: e.key.label,
              earned: e.value.earned,
              possible: e.value.possible,
            ),
            const SizedBox(height: Gap.s),
          ],
          const SizedBox(height: Gap.xl),
        ],

        const SectionHeader('Nach Themen'),
        for (final e in byTopic.entries) ...[
          ScoreRow(
            icon: Topics.byId(e.key).icon,
            title: Topics.byId(e.key).title,
            earned: e.value.earned,
            possible: e.value.possible,
          ),
          const SizedBox(height: Gap.s),
        ],
        const SizedBox(height: Gap.xl),

        const SectionHeader(
          'Alle Aufgaben',
          subtitle:
              'Aufklappen zeigt deine Antwort, die Lösung und die '
              'Begründung.',
        ),
        for (var i = 0; i < session.items.length; i++) ...[
          ReviewTile(
            index: i,
            item: session.items[i],
            label: '${i + 1}.',
            startedAt: session.startedAt,
          ),
          const SizedBox(height: Gap.s),
        ],
        const SizedBox(height: Gap.m),
      ],
    );
  }
}

class _Tally extends StatelessWidget {
  const _Tally({
    required this.color,
    required this.icon,
    required this.count,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: Gap.s),
          Text('$count', style: AppType.numeric(size: 14, color: color)),
          const SizedBox(width: 4),
          Text(
            label,
            style: context.text.bodyMedium?.copyWith(
              color: context.c.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// „Neu freigeschaltet“ - die Abzeichen, die in dieser Runde dazukamen.
class _NewBadges extends StatelessWidget {
  const _NewBadges({required this.badges, required this.statuses});

  final List<Achievement> badges;
  final Map<Achievement, AchievementStatus> statuses;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: context.c.flameBg,
      borderColor: context.c.flame.withValues(alpha: 0.35),
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            badges.length == 1
                ? 'Neues Abzeichen!'
                : '${badges.length} neue Abzeichen!',
            style: context.text.titleMedium?.copyWith(color: context.c.flame),
          ),
          const SizedBox(height: Gap.m),
          for (final b in badges)
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.s),
              child: Row(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.4, end: 1),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.elasticOut,
                    builder: (context, s, child) =>
                        Transform.scale(scale: s, child: child),
                    child: AchievementMedal(
                      achievement: b,
                      status: statuses[b]!,
                      size: 48,
                    ),
                  ),
                  const SizedBox(width: Gap.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.title, style: context.text.titleSmall),
                        Text(
                          b.description,
                          style: context.text.bodySmall?.copyWith(
                            color: context.c.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
