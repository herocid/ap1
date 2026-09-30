import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/progress.dart';
import '../../data/models/subtopic.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../learn/session_launcher.dart';

/// Die Startseite. Reihenfolge nach Wichtigkeit:
/// 1. Was ist heute dran? (Tagesziel mit einer großen Schaltfläche - ganz oben)
/// 2. Wie will ich lernen? (vier Lernmodi)
/// 3. Wo stehe ich? (Prüfungsreife mit Meilensteinen)
/// 4. Etwas für zwischendurch (Feed) und die schwächsten Themen.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final progress = ref.watch(progressProvider);
    final readiness = ref.watch(readinessProvider);
    final stats = ref.watch(topicStatsProvider);
    final poolSize = ref.watch(poolSizeProvider);
    final plan = ref.watch(studyPlanProvider);
    final nextLesson = ref.watch(nextLessonProvider);
    final lessonCount = ref.watch(lessonsProvider).length;
    final lessonsDone = ref.watch(journeyProvider).length;

    final todayCount = progress.answeredToday();
    final mistakes = progress.openMistakes.length;
    final dueCards = ref.watch(dueCardsProvider);

    // Dringlichkeit wie im Lernplan: Prüfungsgewicht mal fehlendes Können.
    // Themen ohne Aufgaben fallen raus - sie lassen sich noch nicht üben.
    final next = Topics.all.where((t) => (poolSize[t.id] ?? 0) > 0).toList()
      ..sort((a, b) {
        double urgency(Topic t) =>
            t.weight * (1 - (stats[t.id]?.confidence ?? 0));
        return urgency(b).compareTo(urgency(a));
      });

    final greeting = profile.displayName.isEmpty
        ? 'Moin'
        : 'Moin, ${profile.displayName}';
    final days = profile.daysUntilExam;
    final examLine = days >= 0
        ? 'Noch $days ${days == 1 ? "Tag" : "Tage"} bis zur AP1'
        : 'Prüfungstermin liegt in der Vergangenheit';

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
                    // ------------------------------------------------ Kopf
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(greeting, style: context.text.headlineSmall),
                              const SizedBox(height: 2),
                              Tooltip(
                                message: DateFormat('EEEE, d. MMMM yyyy', 'de_DE')
                                    .format(profile.examDate),
                                child: Text(
                                  examLine,
                                  style: context.text.bodyMedium
                                      ?.copyWith(color: context.c.textMuted),
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreakChip(
                          days: progress.streak,
                          activeToday: todayCount > 0,
                        ),
                        const SizedBox(width: Gap.xs),
                        IconButton(
                          tooltip: 'Einstellungen',
                          onPressed: () => context.push('/einstellungen'),
                          icon: Icon(Icons.settings_outlined,
                              color: context.c.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: Gap.l),
                    _LevelBar(progress: progress),
                    const SizedBox(height: Gap.xl),

                    // ----------------------------------------------- Heute
                    _TodayCard(
                      done: todayCount,
                      goal: profile.dailyGoal,
                      onStart: () => SessionLauncher.practice(context, ref),
                    ),
                    const SizedBox(height: Gap.xxl),

                    // ------------------------------------------- Lernmodi
                    const _Overline('Lernmodi'),
                    const SizedBox(height: Gap.m),
                    _ModeGrid(
                      children: [
                        _ModeTile(
                          icon: Icons.shuffle_rounded,
                          title: 'Querbeet',
                          subtitle: 'Alle Themen gemischt',
                          onTap: () => SessionLauncher.querbeet(context, ref),
                        ),
                        _ModeTile(
                          icon: Icons.replay_rounded,
                          iconColor: mistakes > 0 ? context.c.danger : null,
                          title: 'Fehler üben',
                          subtitle: mistakes == 0
                              ? 'Nichts offen'
                              : '$mistakes ${mistakes == 1 ? "Aufgabe" : "Aufgaben"} offen',
                          onTap: mistakes == 0
                              ? null
                              : () => SessionLauncher.practice(
                                    context,
                                    ref,
                                    mistakesOnly: true,
                                    count: 10,
                                  ),
                        ),
                        _ModeTile(
                          icon: Icons.style_outlined,
                          title: 'Karteikarten',
                          subtitle: dueCards == 0
                              ? 'Nichts fällig'
                              : '$dueCards heute fällig',
                          onTap: () => context.go('/karten'),
                        ),
                        _ModeTile(
                          icon: Icons.timer_outlined,
                          title: 'Prüfung',
                          subtitle: 'Simulation mit Zeitlimit',
                          onTap: () => context.push('/prüfung'),
                        ),
                      ],
                    ),
                    const SizedBox(height: Gap.xxl),

                    // --------------------------------------- Prüfungsreife
                    const _Overline('Prüfungsreife'),
                    const SizedBox(height: Gap.m),
                    _ReadinessCard(
                      value: readiness,
                      label: progress.readinessLabel(readiness),
                      onTap: () => context.go('/statistik'),
                    ),

                    // ---------------------------------- Learning Journey
                    if (nextLesson != null) ...[
                      const SizedBox(height: Gap.xxl),
                      Row(
                        children: [
                          const Expanded(child: _Overline('Learning Journey')),
                          TextButton(
                            onPressed: () => context.go('/journey'),
                            child: const Text('Übersicht'),
                          ),
                        ],
                      ),
                      const SizedBox(height: Gap.xs),
                      _JourneyCard(
                        lesson: nextLesson,
                        done: lessonsDone,
                        total: lessonCount,
                      ),
                    ],

                    // ---------------------------------- Als nächstes dran
                    if (next.isNotEmpty) ...[
                      const SizedBox(height: Gap.xxl),
                      Row(
                        children: [
                          const Expanded(child: _Overline('Als nächstes dran')),
                          TextButton(
                            onPressed: () => context.go('/themen'),
                            child: const Text('Alle Themen'),
                          ),
                        ],
                      ),
                      Text(
                        plan.note,
                        style: context.text.bodyMedium
                            ?.copyWith(color: context.c.textMuted),
                      ),
                      const SizedBox(height: Gap.m),
                      for (final t in next.take(3)) ...[
                        _TopicRow(
                          topicId: t.id,
                          onTap: () => SessionLauncher.practice(context, ref,
                              topicId: t.id),
                        ),
                        const SizedBox(height: Gap.s),
                      ],
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

/// Abschnittsüberschrift in gesperrten Versalien - ruhiger als eine
/// fette Zwischenüberschrift, und sie gliedert trotzdem klar.
class _Overline extends StatelessWidget {
  const _Overline(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.text.labelSmall?.copyWith(
        color: context.c.textMuted,
        letterSpacing: 1.3,
      ),
    );
  }
}

class _LevelBar extends StatelessWidget {
  const _LevelBar({required this.progress});
  final ProgressState progress;

  /// Texte oben, Balken darunter über die volle Breite: So bleibt die Zeile
  /// auch bei großer Systemschrift auf schmalen Handys intakt.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Level ${progress.level}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.labelLarge,
              ),
            ),
            const SizedBox(width: Gap.m),
            Flexible(
              child: Text(
                '${progress.xp - progress.xpForCurrentLevel} / '
                '${progress.xpForNextLevel - progress.xpForCurrentLevel} XP '
                'bis Level ${progress.level + 1}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: AppType.numeric(size: 12.5, color: context.c.textMuted),
              ),
            ),
          ],
        ),
        const SizedBox(height: Gap.s),
        ClipRRect(
          borderRadius: BorderRadius.circular(Radii.pill),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress.levelProgress),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, t, _) => LinearProgressIndicator(
              value: t,
              minHeight: 6,
              color: context.scheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Die wichtigste Karte der App: was heute zu tun ist, und ein Knopf dafür.
class _TodayCard extends StatelessWidget {
  const _TodayCard({
    required this.done,
    required this.goal,
    required this.onStart,
  });

  final int done;
  final int goal;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final reached = done >= goal;
    final share = goal == 0 ? 0.0 : (done / goal).clamp(0.0, 1.0);
    final c = context.c;

    return AppCard(
      padding: const EdgeInsets.all(Gap.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reached ? 'Tagesziel erreicht' : 'Heutiges Ziel',
                      style: context.text.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      reached
                          ? 'Jede weitere Runde festigt, was du heute gelernt hast.'
                          : 'Zuerst deine Fehler, dann die schwächsten Themen.',
                      style: context.text.bodyMedium
                          ?.copyWith(color: c.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Gap.l),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$done',
                      style: AppType.numeric(
                        size: 28,
                        weight: FontWeight.w700,
                        color: reached ? c.success : context.scheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: ' / $goal',
                      style: AppType.numeric(size: 15, color: c.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.l),
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.pill),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: share),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, t, _) => LinearProgressIndicator(
                value: t,
                minHeight: 8,
                color: reached ? c.success : c.flame,
              ),
            ),
          ),
          const SizedBox(height: Gap.xl),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onStart,
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(
                reached
                    ? 'Noch eine Runde'
                    : done > 0
                        ? 'Weiterlernen'
                        : 'Heute starten',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Zwei Spalten auf dem Handy, vier ab Tablet-Breite. Die Kacheln einer
/// Reihe sind gleich hoch, die Höhe selbst richtet sich nach dem Inhalt -
/// eine feste Höhe lief bei großer Systemschrift über.
class _ModeGrid extends StatelessWidget {
  const _ModeGrid({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final cols = box.maxWidth >= Breakpoints.compact ? 4 : 2;
        final rows = <Widget>[];
        for (var i = 0; i < children.length; i += cols) {
          final cells = children.skip(i).take(cols).toList();
          rows.add(IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var j = 0; j < cols; j++) ...[
                  if (j > 0) const SizedBox(width: Gap.m),
                  Expanded(
                    child: j < cells.length ? cells[j] : const SizedBox(),
                  ),
                ],
              ],
            ),
          ));
        }
        return Column(
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) const SizedBox(height: Gap.m),
              rows[r],
            ],
          ],
        );
      },
    );
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final color = enabled
        ? (iconColor ?? context.scheme.primary)
        : context.c.textMuted;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Gap.l),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.c.surfaceAlt,
                borderRadius: BorderRadius.circular(Radii.s),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: Gap.l),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.titleMedium?.copyWith(
                color: enabled ? null : context.c.textMuted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  context.text.labelSmall?.copyWith(color: context.c.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

/// Die nächste offene Lektion - der Einstieg in neuen Stoff.
class _JourneyCard extends StatelessWidget {
  const _JourneyCard({
    required this.lesson,
    required this.done,
    required this.total,
  });

  final Subtopic lesson;
  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final topic = Topics.byId(lesson.topicId);
    return AppCard(
      onTap: () => context.push('/lektion/${lesson.id}'),
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.flameBg,
              borderRadius: BorderRadius.circular(Radii.m),
            ),
            child: Icon(Icons.route_outlined, size: 22, color: context.c.flame),
          ),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  done == 0 ? 'Erste Lektion' : 'Weiter mit',
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
                const SizedBox(height: 2),
                Text(lesson.title, style: context.text.titleMedium),
                const SizedBox(height: 2),
                Text(
                  '${topic.title}  ·  $done / $total Lektionen',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: context.c.textMuted),
        ],
      ),
    );
  }
}

/// Prüfungsreife mit den drei Meilensteinen, an denen sich die Einstufung
/// ändert. Der nächste Meilenstein steht als konkrete Zahl da - "noch 12
/// Punkte" motiviert mehr als ein abstrakter Prozentwert.
class _ReadinessCard extends StatelessWidget {
  const _ReadinessCard({
    required this.value,
    required this.label,
    required this.onTap,
  });

  final int value;
  final String label;
  final VoidCallback onTap;

  static const _milestones = [
    (35, 'Grundlagen'),
    (60, 'Guter Weg'),
    (80, 'Prüfungsreif'),
  ];

  @override
  Widget build(BuildContext context) {
    final next = _milestones.where((m) => value < m.$1).firstOrNull;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Gap.xl),
      child: Row(
        children: [
          // Ohne Label im Ring: bei dieser Größe kollidiert es mit dem Bogen.
          // Die Einstufung steht stattdessen rechts daneben.
          ReadinessRing(value: value, label: '', size: 96),
          const SizedBox(width: Gap.xl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: Gap.xs),
                Text(
                  next == null
                      ? 'Alle Meilensteine erreicht'
                      : 'Noch ${next.$1 - value} Punkte bis „${next.$2}“',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  'Gewichtet nach dem Punkteanteil der Themen in der AP1.',
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
                const SizedBox(height: Gap.l),
                _MilestoneTrack(value: value, milestones: _milestones),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MilestoneTrack extends StatelessWidget {
  const _MilestoneTrack({required this.value, required this.milestones});

  final int value;
  final List<(int, String)> milestones;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;
        return SizedBox(
          height: 30,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 4,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.c.surfaceAlt,
                    borderRadius: BorderRadius.circular(Radii.pill),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 4,
                child: Container(
                  width: w * (value / 100).clamp(0.0, 1.0),
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.scheme.primary,
                    borderRadius: BorderRadius.circular(Radii.pill),
                  ),
                ),
              ),
              for (final (at, _) in milestones)
                Positioned(
                  left: w * at / 100 - 5,
                  top: 1,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value >= at
                          ? context.scheme.primary
                          : context.scheme.surface,
                      border: Border.all(
                        color: value >= at
                            ? context.scheme.primary
                            : context.c.border,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              for (final (at, _) in milestones)
                Positioned(
                  left: w * at / 100 - 12,
                  top: 16,
                  child: SizedBox(
                    width: 24,
                    child: Text(
                      '$at',
                      textAlign: TextAlign.center,
                      style: AppType.numeric(
                          size: 11, color: context.c.textMuted),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Themenzeile mit Fortschrittsbalken.
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
                  '${(topic.weight * 100).round()} % der AP1-Punkte',
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
