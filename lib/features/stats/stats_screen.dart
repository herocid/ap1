import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/achievement_badge.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';

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
    final achievements = ref.watch(achievementsProvider);

    // Die Erfolge stehen immer ganz oben - auch vor der ersten Aufgabe
    // zeigen sie, was es zu holen gibt.
    if (progress.history.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Statistik')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
          children: [
            ReadableWidth(
              child: Column(
                children: [
                  AchievementsPanel(statuses: achievements),
                  const SizedBox(height: Gap.xl),
                  const MascotSays(
                    mood: MascotMood.think,
                    title: 'Noch keine Daten',
                    text:
                        'Sobald du die erste Runde gespielt hast, siehst du '
                        'hier deine Trefferquote je Thema, deine Aktivität '
                        'und deine Prüfungsreife.',
                  ),
                ],
              ),
            ),
          ],
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
                AchievementsPanel(statuses: achievements),
                const SizedBox(height: Gap.l),
                StatTileRow(
                  children: [
                    StatTile(
                      icon: Icons.local_fire_department,
                      value: '${progress.streak}',
                      label: progress.streak == 1
                          ? 'Tag Streak'
                          : 'Tage Streak',
                      color: context.c.flame,
                    ),
                    StatTile(
                      icon: Icons.military_tech_outlined,
                      value: 'Lv. ${progress.level}',
                      label: '${progress.xp} XP',
                    ),
                    StatTile(
                      icon: Icons.checklist_rtl,
                      value: '${progress.totalAnswered}',
                      label: 'Aufgaben',
                      color: context.c.success,
                    ),
                  ],
                ),
                const SizedBox(height: Gap.l),

                AppCard(
                  padding: const EdgeInsets.all(Gap.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fortschritt zum nächsten Level',
                        style: context.text.titleMedium,
                      ),
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
                        style: context.text.labelSmall?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.l),

                AppCard(
                  padding: const EdgeInsets.all(Gap.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Letzte 14 Tage', style: context.text.titleMedium),
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
                          Text(
                            'vor 14 Tagen',
                            style: context.text.labelSmall?.copyWith(
                              color: context.c.textMuted,
                            ),
                          ),
                          Text(
                            'heute',
                            style: context.text.labelSmall?.copyWith(
                              color: context.c.textMuted,
                            ),
                          ),
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
    final started = s != null && s.answered > 0;
    // Aufbau wie die Bereichskacheln im Quiz: Symbol links, Titel über die
    // volle Breite (lange Wörter wie „Risikomanagement“ brachen neben dem
    // Prozentwert mitten im Wort), darunter Balken mit Prozentwert.
    return ProgressTile(
      icon: topic.icon,
      title: topic.title,
      progress: s?.confidence ?? 0,
      coverage: s?.coverage ?? 0,
      caption: started
          ? 'Trefferquote ${(s.mastery * 100).round()} % · '
                '${s.distinctQuestions}/$poolSize gesehen · '
                '${s.answered} Versuche'
          : 'Noch nicht begonnen · $poolSize Aufgaben',
    );
  }
}
