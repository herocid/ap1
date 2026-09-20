import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../learn/session_launcher.dart';

/// Die Startseite. Sie beantwortet in dieser Reihenfolge drei Fragen:
/// 1. Wo stehe ich? (Prüfungsreife, Tage bis zur Prüfung)
/// 2. Was ist heute dran? (Tagesziel, eine große Schaltfläche)
/// 3. Wo hakt es? (Fehlerspeicher, schwächste Themen)
///
/// Alles andere - Statistik, Einstellungen, komplette Themenliste - liegt
/// bewusst auf anderen Tabs. Ein Dashboard, das alles zeigt, zeigt nichts.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final progress = ref.watch(progressProvider);
    final readiness = ref.watch(readinessProvider);
    final stats = ref.watch(topicStatsProvider);
    final plan = ref.watch(studyPlanProvider);

    final todayCount = progress.answeredToday();
    final goal = profile.dailyGoal;
    final goalReached = todayCount >= goal;
    final mistakes = progress.openMistakes.length;
    final dueCards = ref.watch(dueCardsProvider);

    final weakest = [...Topics.all]..sort((a, b) {
        final ca = stats[a.id]?.confidence ?? 0;
        final cb = stats[b.id]?.confidence ?? 0;
        return (ca * a.weight).compareTo(cb * b.weight);
      });

    final greeting = profile.displayName.isEmpty
        ? 'Moin'
        : 'Moin, ${profile.displayName}';

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(questionPoolProvider),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
            children: [
              ReadableWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(greeting, style: context.text.headlineSmall),
                              Text(
                                profile.daysUntilExam >= 0
                                    ? 'Noch ${profile.daysUntilExam} Tage bis zur AP1'
                                    : 'Prüfungstermin liegt in der Vergangenheit',
                                style: context.text.bodyMedium
                                    ?.copyWith(color: context.c.textMuted),
                              ),
                            ],
                          ),
                        ),
                        StreakChip(
                          days: progress.streak,
                          activeToday: todayCount > 0,
                        ),
                      ],
                    ),
                    const SizedBox(height: Gap.xl),

                    // ----------------------------------------- Prüfungsreife
                    AppCard(
                      padding: const EdgeInsets.all(Gap.xl),
                      child: LayoutBuilder(
                        builder: (context, box) {
                          final ring = ReadinessRing(
                            value: readiness,
                            label: progress.readinessLabel(readiness),
                          );
                          final side = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Prüfungsreife',
                                  style: context.text.titleMedium),
                              const SizedBox(height: Gap.xs),
                              Text(
                                readiness == 0
                                    ? 'Sobald du die ersten Aufgaben gelöst hast, '
                                        'siehst du hier, wie weit du bist.'
                                    : 'Gewichtet nach dem Punkteanteil der Themen '
                                        'in der AP1 - nicht nach Anzahl der '
                                        'Klicks.',
                                style: context.text.bodyMedium
                                    ?.copyWith(color: context.c.textMuted),
                              ),
                              const SizedBox(height: Gap.l),
                              Row(
                                children: [
                                  _MiniStat(
                                    value: '${progress.level}',
                                    label: 'Level',
                                  ),
                                  const SizedBox(width: Gap.xl),
                                  _MiniStat(
                                    value: '${progress.totalAnswered}',
                                    label: 'Aufgaben',
                                  ),
                                  const SizedBox(width: Gap.xl),
                                  _MiniStat(
                                    value: '${progress.longestStreak}',
                                    label: 'Bester Streak',
                                  ),
                                ],
                              ),
                            ],
                          );

                          if (box.maxWidth < 460) {
                            return Column(
                              children: [
                                ring,
                                const SizedBox(height: Gap.l),
                                side,
                              ],
                            );
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ring,
                              const SizedBox(width: Gap.xl),
                              Expanded(child: side),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: Gap.l),

                    // ------------------------------------------- Tagesziel
                    AppCard(
                      padding: const EdgeInsets.all(Gap.xl),
                      borderColor: goalReached
                          ? context.c.success.withValues(alpha: 0.5)
                          : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                goalReached
                                    ? Icons.check_circle
                                    : Icons.flag_outlined,
                                size: 20,
                                color: goalReached
                                    ? context.c.success
                                    : context.scheme.primary,
                              ),
                              const SizedBox(width: Gap.s),
                              Text(
                                goalReached
                                    ? 'Tagesziel geschafft'
                                    : 'Heutiges Ziel',
                                style: context.text.titleMedium,
                              ),
                              const Spacer(),
                              Text(
                                '$todayCount / $goal',
                                style: AppType.numeric(
                                  size: 15,
                                  color: goalReached
                                      ? context.c.success
                                      : context.c.textMuted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Gap.m),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Radii.pill),
                            child: LinearProgressIndicator(
                              value: goal == 0
                                  ? 0
                                  : (todayCount / goal).clamp(0.0, 1.0),
                              color: goalReached
                                  ? context.c.success
                                  : context.scheme.primary,
                            ),
                          ),
                          const SizedBox(height: Gap.l),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: () =>
                                  SessionLauncher.practice(context, ref),
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: Text(
                                goalReached
                                    ? 'Noch eine Runde'
                                    : todayCount > 0
                                        ? 'Weiterlernen'
                                        : 'Heute starten',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Gap.l),

                    // -------------------------------- Fehlerspeicher + Prüfung
                    Row(
                      children: [
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.replay_outlined,
                            iconColor: context.c.danger,
                            title: 'Fehlerspeicher',
                            subtitle: mistakes == 0
                                ? 'Nichts offen'
                                : '$mistakes offene ${mistakes == 1 ? "Aufgabe" : "Aufgaben"}',
                            onTap: mistakes == 0
                                ? null
                                : () => SessionLauncher.practice(
                                      context,
                                      ref,
                                      mistakesOnly: true,
                                      count: 10,
                                    ),
                          ),
                        ),
                        const SizedBox(width: Gap.m),
                        Expanded(
                          child: _ActionCard(
                            icon: Icons.style_outlined,
                            iconColor: context.scheme.primary,
                            title: 'Karteikarten',
                            subtitle: dueCards == 0
                                ? 'Nichts fällig'
                                : '$dueCards fällig',
                            onTap: () => context.go('/karten'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Gap.m),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => context.push('/prüfung'),
                        icon: const Icon(Icons.timer_outlined),
                        label: const Text('Prüfungssimulation starten'),
                      ),
                    ),
                    const SizedBox(height: Gap.xl),

                    // --------------------------------------- Heute im Plan
                    SectionHeader(
                      'Als nächstes dran',
                      subtitle: plan.note,
                      action: TextButton(
                        onPressed: () => context.go('/themen'),
                        child: const Text('Katalog'),
                      ),
                    ),
                    for (final t in weakest.take(3)) ...[
                      _TopicRow(
                        topicId: t.id,
                        onTap: () =>
                            SessionLauncher.practice(context, ref, topicId: t.id),
                      ),
                      const SizedBox(height: Gap.s),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppType.numeric(size: 19)),
        Text(label,
            style:
                context.text.labelSmall?.copyWith(color: context.c.textMuted)),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Opacity(
      opacity: enabled ? 1 : 0.55,
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsets.all(Gap.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(height: Gap.m),
            Text(title, style: context.text.titleMedium),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.text.labelSmall
                  ?.copyWith(color: context.c.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

/// Themenzeile mit Fortschrittsbalken. Wird auch in der Themenliste benutzt.
class _TopicRow extends ConsumerWidget {
  const _TopicRow({required this.topicId, required this.onTap});

  final String topicId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topic = Topics.byId(topicId);
    final st = ref.watch(topicStatsProvider)[topicId];
    final poolSize = ref.watch(poolSizeProvider)[topicId] ?? 0;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.m),
            ),
            child: Icon(topic.icon, size: 20, color: context.scheme.primary),
          ),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(topic.title, style: context.text.titleMedium),
                    ),
                    Text(
                      '${((st?.confidence ?? 0) * 100).round()} %',
                      style: AppType.numeric(
                          size: 13, color: context.c.textMuted),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${st?.distinctQuestions ?? 0} von $poolSize Aufgaben · '
                  '${(topic.weight * 100).round()} % der PM-Punkte',
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
                const SizedBox(height: Gap.s),
                TopicBar(
                  confidence: st?.confidence ?? 0,
                  coverage: st?.coverage ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
