import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';

/// Statistik. Beantwortet: Bin ich besser geworden, wo stehe ich pro Thema,
/// und habe ich zuletzt überhaupt etwas getan?
class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final readiness = ref.watch(readinessProvider);
    final stats = ref.watch(topicStatsProvider);
    final poolSize = ref.watch(poolSizeProvider);

    if (progress.history.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Statistik')),
        body: const EmptyState(
          icon: Icons.insights_outlined,
          title: 'Noch keine Daten',
          message:
              'Sobald du die erste Runde gespielt hast, entsteht hier deine '
              'Auswertung: Trefferquote je Thema, Aktivität der letzten '
              'zwei Wochen und der Prüfungsreife-Verlauf.',
        ),
      );
    }

    final days = _last14Days(progress.history);
    final maxDay = days.fold<int>(1, (m, e) => math.max(m, e));

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        icon: Icons.local_fire_department,
                        value: '${progress.streak}',
                        label: 'Tage Streak',
                        color: context.c.flame,
                      ),
                    ),
                    const SizedBox(width: Gap.s),
                    Expanded(
                      child: StatTile(
                        icon: Icons.military_tech_outlined,
                        value: 'Lv. ${progress.level}',
                        label: '${progress.xp} XP',
                      ),
                    ),
                    const SizedBox(width: Gap.s),
                    Expanded(
                      child: StatTile(
                        icon: Icons.checklist_rtl,
                        value: '${progress.totalAnswered}',
                        label: 'Aufgaben',
                        color: context.c.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.l),

                AppCard(
                  padding: const EdgeInsets.all(Gap.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fortschritt zum nächsten Level',
                          style: context.text.titleMedium),
                      const SizedBox(height: Gap.m),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Radii.pill),
                        child: LinearProgressIndicator(
                          value: progress.levelProgress,
                        ),
                      ),
                      const SizedBox(height: Gap.s),
                      Text(
                        '${progress.xp - progress.xpForCurrentLevel} von '
                        '${progress.xpForNextLevel - progress.xpForCurrentLevel} XP '
                        'bis Level ${progress.level + 1}',
                        style: context.text.labelSmall
                            ?.copyWith(color: context.c.textMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.l),

                AppCard(
                  padding: const EdgeInsets.all(Gap.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Letzte 14 Tage',
                          style: context.text.titleMedium),
                      const SizedBox(height: Gap.l),
                      SizedBox(
                        height: 92,
                        child: _ActivityChart(
                          values: days,
                          max: maxDay,
                          barColor: context.scheme.primary,
                          trackColor: context.c.surfaceAlt,
                        ),
                      ),
                      const SizedBox(height: Gap.s),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('vor 14 Tagen',
                              style: context.text.labelSmall
                                  ?.copyWith(color: context.c.textMuted)),
                          Text('heute',
                              style: context.text.labelSmall
                                  ?.copyWith(color: context.c.textMuted)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.xl),

                SectionHeader(
                  'Prüfungsreife: $readiness %',
                  subtitle:
                      'Gefüllter Balken = Können, senkrechter Strich = wie '
                      'viel des Themas du schon gesehen hast.',
                ),
                for (final t in Topics.all) ...[
                  _TopicStatRow(
                    topic: t,
                    stat: stats[t.id],
                    poolSize: poolSize[t.id] ?? 0,
                  ),
                  const SizedBox(height: Gap.s),
                ],
                const SizedBox(height: Gap.xl),

                const SectionHeader('Erfolge'),
                Wrap(
                  spacing: Gap.s,
                  runSpacing: Gap.s,
                  children: [
                    for (final a in Achievement.values)
                      _AchievementChip(
                        achievement: a,
                        earned: progress.badges.contains(a),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<int> _last14Days(List<AnswerRecord> history) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final counts = List<int>.filled(14, 0);
    for (final r in history) {
      final d = DateTime(r.at.year, r.at.month, r.at.day);
      final diff = today.difference(d).inDays;
      if (diff >= 0 && diff < 14) counts[13 - diff]++;
    }
    return counts;
  }
}

class _ActivityChart extends StatelessWidget {
  const _ActivityChart({
    required this.values,
    required this.max,
    required this.barColor,
    required this.trackColor,
  });

  final List<int> values;
  final int max;
  final Color barColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < values.length; i++) ...[
          Expanded(
            child: Tooltip(
              message: '${values[i]} Aufgaben',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (values[i] > 0)
                    Text(
                      '${values[i]}',
                      style: AppType.numeric(
                        size: 10,
                        weight: FontWeight.w600,
                        color: context.c.textMuted,
                      ),
                    ),
                  const SizedBox(height: 3),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: values[i] / max),
                    duration: Duration(milliseconds: 300 + i * 20),
                    curve: Curves.easeOut,
                    builder: (context, t, _) => Container(
                      height: math.max(4, 62 * t),
                      decoration: BoxDecoration(
                        color: values[i] == 0 ? trackColor : barColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (i < values.length - 1) const SizedBox(width: 4),
        ],
      ],
    );
  }
}

class _TopicStatRow extends StatelessWidget {
  const _TopicStatRow({
    required this.topic,
    required this.stat,
    required this.poolSize,
  });

  final Topic topic;
  final TopicStat? stat;
  final int poolSize;

  @override
  Widget build(BuildContext context) {
    final s = stat;
    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(topic.icon, size: 18, color: context.scheme.primary),
              const SizedBox(width: Gap.s),
              Expanded(
                child: Text(topic.title, style: context.text.titleMedium),
              ),
              Text('${((s?.confidence ?? 0) * 100).round()} %',
                  style: AppType.numeric(size: 14)),
            ],
          ),
          const SizedBox(height: Gap.s),
          TopicBar(
            confidence: s?.confidence ?? 0,
            coverage: s?.coverage ?? 0,
          ),
          const SizedBox(height: Gap.s),
          Text(
            s == null || s.answered == 0
                ? 'Noch nicht begonnen · $poolSize Aufgaben verfügbar'
                : 'Trefferquote ${(s.mastery * 100).round()} % · '
                    '${s.distinctQuestions}/$poolSize Aufgaben gesehen · '
                    '${s.answered} Versuche',
            style: context.text.labelSmall?.copyWith(color: context.c.textMuted),
          ),
        ],
      ),
    );
  }
}

class _AchievementChip extends StatelessWidget {
  const _AchievementChip({required this.achievement, required this.earned});

  final Achievement achievement;
  final bool earned;

  @override
  Widget build(BuildContext context) {
    final fg = earned ? context.c.flame : context.c.textMuted;
    return Tooltip(
      message: achievement.description,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Gap.m, vertical: Gap.s),
        decoration: BoxDecoration(
          color: earned ? context.c.flameBg : context.c.surfaceAlt,
          borderRadius: BorderRadius.circular(Radii.m),
          border: Border.all(
            color: earned ? fg.withValues(alpha: 0.4) : context.c.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              earned ? Icons.emoji_events : Icons.lock_outline,
              size: 16,
              color: fg,
            ),
            const SizedBox(width: Gap.s),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(achievement.title,
                    style: context.text.labelLarge
                        ?.copyWith(fontSize: 13, color: fg)),
                Text(achievement.description,
                    style: context.text.labelSmall
                        ?.copyWith(color: context.c.textMuted)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
