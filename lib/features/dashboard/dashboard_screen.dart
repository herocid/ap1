import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/subtopic.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';
import '../learn/session_launcher.dart';

/// Die Startseite. Sie beantwortet in fünf Sekunden „Was mache ich jetzt?“:
///
/// 1. Bit sagt, was gerade am meisten bringt (ein Satz, kein Menü).
/// 2. Das Tagesziel mit genau einem großen Knopf.
/// 3. Weiterlernen in der Journey.
/// 4. Schnellstart für die drei Abfrage-Formate.
/// 5. Die Prüfungsreife als Einstieg in die Statistik.
///
/// Alles andere - Themenliste, Level, Lernplan - steht in den Tabs, zu denen
/// es gehört. Eine Startseite, die alles zeigt, zeigt nichts.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Wer die Einführung noch nicht kennt (z. B. nach einem Update), sieht
    // sie einmal.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final p = ref.read(profileProvider);
      if (p.onboarded && !p.tutorialSeen) context.push('/einfuehrung');
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final progress = ref.watch(progressProvider);
    final readiness = ref.watch(readinessProvider);
    final nextLesson = ref.watch(nextLessonProvider);
    final lessonCount = ref.watch(lessonsProvider).length;
    final lessonsDone = ref.watch(journeyProvider).length;

    final todayCount = progress.answeredToday();
    final goal = profile.dailyGoal;
    final mistakes = progress.openMistakes.length;
    final dueCards = ref.watch(dueReviewsProvider);

    final greeting = profile.displayName.isEmpty
        ? 'Moin!'
        : 'Moin, ${profile.displayName}!';
    final days = profile.daysUntilExam;
    final examLine = days >= 0
        ? 'Noch $days ${days == 1 ? "Tag" : "Tage"} bis zur AP1'
        : 'Prüfungstermin liegt in der Vergangenheit';

    final tip = _coachTip(
      lessonsDone: lessonsDone,
      todayCount: todayCount,
      goal: goal,
      mistakes: mistakes,
      dueCards: dueCards,
    );

    final today = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TodayCard(
          done: todayCount,
          goal: goal,
          onStart: () => SessionLauncher.practice(context, ref),
        ),
        if (mistakes > 0) ...[
          const SizedBox(height: Gap.s),
          _MistakeBanner(
            count: mistakes,
            onTap: () =>
                SessionLauncher.practice(context, ref, mistakesOnly: true),
          ),
        ],
      ],
    );
    final journey = nextLesson == null
        ? null
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionTitle(
                lessonsDone == 0 ? 'Hier anfangen' : 'Weiterlernen',
                action: 'Journey',
                onAction: () => context.go('/journey'),
              ),
              _JourneyCard(
                lesson: nextLesson,
                done: lessonsDone,
                total: lessonCount,
              ),
            ],
          );
    final journeyFirst = journey != null && lessonsDone == 0 && todayCount == 0;

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
                                message: DateFormat(
                                  'EEEE, d. MMMM yyyy',
                                  'de_DE',
                                ).format(profile.examDate),
                                child: Text(
                                  examLine,
                                  style: context.text.bodyMedium?.copyWith(
                                    color: context.c.textMuted,
                                  ),
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
                          icon: Icon(
                            Icons.settings_outlined,
                            color: context.c.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Gap.l),

                    // ------------------------------------------- Bit sagt
                    MascotSays(
                      mood: tip.mood,
                      title: tip.title,
                      text: tip.text,
                    ),
                    const SizedBox(height: Gap.l),

                    // Ganz am Anfang ist die erste Lektion der beste
                    // Einstieg, danach das Tagesziel.
                    if (journeyFirst) ...[
                      journey,
                      const SizedBox(height: Gap.xxl),
                      today,
                    ] else ...[
                      today,
                      if (journey != null) ...[
                        const SizedBox(height: Gap.xxl),
                        journey,
                      ],
                    ],

                    // ---------------------------------------- Schnellstart
                    const SizedBox(height: Gap.xxl),
                    _SectionTitle(
                      'Abfragen',
                      action: 'Quiz',
                      onAction: () => context.go('/quiz'),
                    ),
                    ActionTile(
                      icon: Icons.bolt_rounded,
                      tone: TileTone.flame,
                      title: 'Kurztest',
                      subtitle:
                          'Zufallsfragen aus allen Bereichen - '
                          'aufhören, wann du willst',
                      onTap: () => SessionLauncher.kurztest(context, ref),
                    ),
                    const SizedBox(height: Gap.s),
                    ActionTile(
                      icon: Icons.timer_rounded,
                      tone: TileTone.info,
                      title: 'Prüfungssimulation',
                      subtitle: 'Mit Zeitlimit, bis zu 90 Minuten',
                      onTap: () => context.push('/pruefung'),
                    ),
                    const SizedBox(height: Gap.s),
                    ActionTile(
                      icon: Icons.style_rounded,
                      tone: TileTone.success,
                      title: 'Karteikarten',
                      subtitle: dueCards == 0
                          ? 'Neue Karten lernen'
                          : 'Wiederholungen warten auf dich',
                      badge: dueCards == 0 ? null : '$dueCards',
                      onTap: () => context.go('/karten'),
                    ),

                    // --------------------------------------- Prüfungsreife
                    const SizedBox(height: Gap.xxl),
                    _SectionTitle(
                      'Dein Stand',
                      action: 'Statistik',
                      onAction: () => context.go('/statistik'),
                    ),
                    _ReadinessCard(
                      value: readiness,
                      label: progress.readinessLabel(readiness),
                      onTap: () => context.go('/statistik'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Ein Satz von Bit - immer die eine Sache, die gerade am meisten bringt.
  static ({MascotMood mood, String title, String text}) _coachTip({
    required int lessonsDone,
    required int todayCount,
    required int goal,
    required int mistakes,
    required int dueCards,
  }) {
    if (todayCount >= goal && goal > 0) {
      return (
        mood: MascotMood.cheer,
        title: 'Tagesziel geschafft!',
        text: 'Stark. Alles, was jetzt noch kommt, ist Bonus.',
      );
    }
    if (lessonsDone == 0 && todayCount == 0) {
      return (
        mood: MascotMood.wave,
        title: 'Los geht’s!',
        text:
            'Fang mit der ersten Lektion an - danach weißt du, wie '
            'hier alles funktioniert.',
      );
    }
    if (mistakes >= 5) {
      return (
        mood: MascotMood.think,
        title: 'Zweite Chance',
        text:
            '$mistakes Aufgaben warten im Fehlerspeicher. Wer sie jetzt '
            'wiederholt, macht sie in der Prüfung nicht noch mal falsch.',
      );
    }
    if (dueCards >= 10) {
      return (
        mood: MascotMood.think,
        title: 'Karten sind fällig',
        text:
            '$dueCards Karteikarten wollen heute wiederholt werden - das '
            'dauert nur ein paar Minuten.',
      );
    }
    final left = goal - todayCount;
    return (
      mood: MascotMood.happy,
      title: todayCount == 0 ? 'Schön, dass du da bist.' : 'Weiter so!',
      text:
          'Noch $left ${left == 1 ? "Aufgabe" : "Aufgaben"} bis zu deinem '
          'Tagesziel.',
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {this.action, this.onAction});

  final String text;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.s),
      child: Row(
        children: [
          Expanded(child: Text(text, style: context.text.titleMedium)),
          if (action != null)
            // Ohne eigenen Innenabstand, damit der Link bündig mit der
            // Kartenkante rechts abschließt.
            TextButton.icon(
              onPressed: onAction,
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.chevron_right, size: 18),
              label: Text(action!),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: Gap.s),
                minimumSize: const Size(0, 36),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
        ],
      ),
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
                      'Gemischte Runde: erst deine Fehler, dann die '
                      'schwächsten Themen.',
                      style: context.text.bodyMedium?.copyWith(
                        color: c.textMuted,
                      ),
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
              duration: const Duration(milliseconds: 700),
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
                    ? 'Weitermachen'
                    : 'Tagesrunde starten',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MistakeBanner extends StatelessWidget {
  const _MistakeBanner({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionTile(
      icon: Icons.replay_rounded,
      tone: TileTone.danger,
      title: 'Fehler wiederholen',
      subtitle: count == 1
          ? '1 Aufgabe wartet auf eine zweite Chance'
          : '$count Aufgaben warten auf eine zweite Chance',
      badge: '$count',
      onTap: onTap,
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
    final share = total == 0 ? 0.0 : done / total;
    return AppCard(
      onTap: () => context.push('/lektion/${lesson.id}'),
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.c.flameBg,
                  borderRadius: BorderRadius.circular(Radii.m),
                ),
                child: Icon(
                  Icons.route_outlined,
                  size: 22,
                  color: context.c.flame,
                ),
              ),
              const SizedBox(width: Gap.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      done == 0 ? 'Erste Lektion' : 'Nächste Lektion',
                      style: context.text.labelSmall?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(lesson.title, style: context.text.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      topic.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.labelSmall?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.play_circle_fill_rounded,
                size: 34,
                color: context.scheme.primary,
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.pill),
                  child: LinearProgressIndicator(
                    value: share,
                    minHeight: 5,
                    color: context.c.flame,
                  ),
                ),
              ),
              const SizedBox(width: Gap.m),
              Text(
                '$done / $total',
                style: AppType.numeric(size: 12, color: context.c.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Prüfungsreife kompakt: Ring, Einstufung und der nächste Meilenstein als
/// konkrete Zahl - „noch 12 Punkte“ motiviert mehr als ein Prozentwert.
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
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          ReadinessRing(value: value, label: '', size: 72),
          const SizedBox(width: Gap.l),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prüfungsreife · $label',
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
                const SizedBox(height: Gap.xs),
                Text(
                  next == null
                      ? 'Alle Meilensteine erreicht'
                      : 'Noch ${next.$1 - value} Punkte bis „${next.$2}“',
                  style: context.text.titleMedium,
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
