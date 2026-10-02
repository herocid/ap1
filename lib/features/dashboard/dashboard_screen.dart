import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/subtopic.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../../widgets/hyphenation.dart';
import '../../widgets/mascot.dart';
import '../cards/card_launch.dart';
import '../cards/card_session_screen.dart';
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

    final today = _TodayCard(
      done: todayCount,
      goal: goal,
      mistakes: mistakes,
      onStart: () => SessionLauncher.practice(context, ref),
      onMistakes: () =>
          SessionLauncher.practice(context, ref, mistakesOnly: true),
    );
    final inProgress = ref.watch(lessonInProgressProvider);
    final resumeLesson = inProgress == null
        ? nextLesson
        : Subtopics.byId(inProgress.lessonId) ?? nextLesson;
    final steps = resumeLesson == null
        ? 0
        : (ref.watch(lessonStepsProvider)[resumeLesson.id]?.length ?? 0);
    // „Weitermachen“: Journey und Karteikasten genau da fortsetzen, wo
    // zuletzt aufgehört wurde.
    final journey = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(
          lessonsDone == 0 && inProgress == null
              ? 'Hier anfangen'
              : 'Weitermachen',
          action: 'Journey',
          onAction: () => context.go('/journey'),
        ),
        if (resumeLesson != null)
          _JourneyCard(
            lesson: resumeLesson,
            done: lessonsDone,
            total: lessonCount,
            step: inProgress?.lessonId == resumeLesson.id
                ? inProgress!.page
                : 0,
            stepCount: steps,
          ),
        const SizedBox(height: Gap.s),
        const _CardsResumeCard(),
      ],
    );
    final journeyFirst = lessonsDone == 0 && todayCount == 0;

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
                              WordSafeText(
                                greeting,
                                style: context.text.headlineSmall,
                              ),
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
                        // Die Serie erst zeigen, wenn es eine gibt - „0 Tage“
                        // ist keine Motivation, sondern ein Vorwurf.
                        if (progress.streak > 0) ...[
                          StreakChip(
                            days: progress.streak,
                            activeToday: todayCount > 0,
                          ),
                          const SizedBox(width: Gap.xs),
                        ],
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
                      const SizedBox(height: Gap.xxl),
                      journey,
                    ],

                    // ------------------------- Sessions nach Themengebiet
                    const SizedBox(height: Gap.xxl),
                    const _SessionAreas(),

                    // ---------------------------------------- Schnellstart
                    const SizedBox(height: Gap.xxl),
                    _SectionTitle(
                      'Abfragen',
                      action: 'Quiz',
                      onAction: () => context.go('/quiz'),
                    ),
                    _QuickTile(
                      icon: Icons.bolt_rounded,
                      tone: TileTone.flame,
                      title: 'Kurztest',
                      subtitle:
                          'Zufallsfragen aus allen Bereichen, '
                          'aufhören, wann du willst',
                      onTap: () => SessionLauncher.kurztest(context, ref),
                    ),
                    const SizedBox(height: Gap.s),
                    _QuickTile(
                      icon: Icons.timer_rounded,
                      tone: TileTone.info,
                      // Zwei Wörter statt eines langen: passt auch auf 320 px
                      // mit großer Schrift, ohne mitten im Wort umzubrechen.
                      title: 'Prüfung simulieren',
                      subtitle: 'Mit Zeitlimit, bis zu 90 Minuten',
                      onTap: () => context.push('/pruefung'),
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
            'Fang mit der ersten Lektion an. Danach weißt du, wie '
            'hier alles funktioniert.',
      );
    }
    // Wie viele Fehler offen sind, steht in der Zielkarte direkt darunter -
    // Bit sagt deshalb, warum sich das Wiederholen lohnt.
    if (mistakes >= 5) {
      return (
        mood: MascotMood.think,
        title: 'Fehler sind Lernstoff',
        text:
            'Was du erst falsch hattest und beim zweiten Mal richtig löst, '
            'bleibt besonders gut hängen.',
      );
    }
    if (dueCards >= 10) {
      return (
        mood: MascotMood.think,
        title: 'Karten sind fällig',
        text:
            '$dueCards Karteikarten wollen heute wiederholt werden. Das '
            'dauert nur ein paar Minuten.',
      );
    }
    // Der Zählerstand steht schon in der Zielkarte; Bit nennt ihn nur kurz
    // vor dem Ziel.
    final left = goal - todayCount;
    if (todayCount > 0 && left <= 3) {
      return (
        mood: MascotMood.happy,
        title: 'Fast geschafft!',
        text:
            'Nur noch $left ${left == 1 ? "Aufgabe" : "Aufgaben"}, dann '
            'ist dein Tagesziel erreicht.',
      );
    }
    return (
      mood: MascotMood.happy,
      title: todayCount == 0 ? 'Schön, dass du da bist.' : 'Weiter so!',
      text:
          'Jeden Tag eine kurze Runde bringt mehr als ein langer Abend '
          'kurz vor der Prüfung.',
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
                minimumSize: const Size(48, 48),
              ),
            ),
        ],
      ),
    );
  }
}

/// Wenig Platz für Text: schmales Handy oder große Schrift. Dann rücken die
/// Karten der Startseite zusammen (kleines Symbol in der Kopfzeile statt
/// eigener Spalte, Balken über die volle Breite).
bool _isTight(BuildContext context) {
  final mq = MediaQuery.of(context);
  return mq.size.width < 360 || mq.textScaler.scale(100) > 115;
}

/// Die wichtigste Karte der App: was heute zu tun ist, und ein Knopf dafür.
///
/// Als einzige Karte vollflächig in Markenblau - so ist auf einen Blick klar,
/// wo es losgeht. Die offenen Fehler stehen als ruhige Zeile mit in der Karte
/// statt als eigene Kachel darunter.
class _TodayCard extends StatelessWidget {
  const _TodayCard({
    required this.done,
    required this.goal,
    required this.mistakes,
    required this.onStart,
    required this.onMistakes,
  });

  final int done;
  final int goal;
  final int mistakes;
  final VoidCallback onStart;
  final VoidCallback onMistakes;

  // Fläche in beiden Modi das dunkle Markenblau: weiße Schrift erreicht
  // darauf 5,6:1, das helle Dunkelmodus-Blau wäre als Fläche zu grell.
  static const _bg = AppColors.brand;
  static const _fg = Colors.white;

  @override
  Widget build(BuildContext context) {
    final reached = done >= goal;
    final share = goal == 0 ? 0.0 : (done / goal).clamp(0.0, 1.0);
    final tight = _isTight(context);
    final soft = _fg.withValues(alpha: 0.92);
    final pad = tight ? Gap.l : Gap.xl;

    return AppCard(
      color: _bg,
      borderColor: _bg,
      // Die Fehlerzeile bringt unten eigene Luft mit.
      padding: EdgeInsets.fromLTRB(pad, pad, pad, mistakes > 0 ? Gap.s : pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (reached) ...[
                const Icon(Icons.check_circle_rounded, size: 20, color: _fg),
                const SizedBox(width: Gap.s),
              ],
              Expanded(
                child: Text(
                  reached ? 'Tagesziel erreicht' : 'Heutiges Ziel',
                  style: context.text.titleMedium?.copyWith(color: _fg),
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          // Die Kernzahl groß und frei stehend, das Ziel klein daneben.
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$done',
                  style: AppType.numeric(
                    size: 52,
                    weight: FontWeight.w800,
                    color: _fg,
                  ).copyWith(height: 1, letterSpacing: -1.5),
                ),
                TextSpan(
                  text: ' / $goal Aufgaben',
                  style: AppType.numeric(size: 15, color: soft),
                ),
              ],
            ),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: Gap.l),
          // Oranger Fortschritt in der hellen Stufe - die dunkle hebt sich
          // vom Blau nicht ab.
          AnimatedBar(
            value: share,
            minHeight: 8,
            color: reached ? _fg : AppColors.flameDark,
            backgroundColor: _fg.withValues(alpha: 0.24),
          ),
          const SizedBox(height: Gap.m),
          Text(
            'Gemischte Runde: erst deine Fehler, dann die '
            'schwächsten Themen.',
            style: context.text.bodyMedium?.copyWith(color: soft),
          ),
          const SizedBox(height: Gap.l),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onStart,
              style: FilledButton.styleFrom(
                backgroundColor: _fg,
                foregroundColor: _bg,
              ),
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
          if (mistakes > 0) ...[
            const SizedBox(height: Gap.xs),
            _MistakeRow(count: mistakes, onTap: onMistakes),
          ],
        ],
      ),
    );
  }
}

/// Zweiter Einstieg in der Zielkarte: nur den Fehlerspeicher wiederholen.
class _MistakeRow extends StatelessWidget {
  const _MistakeRow({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const fg = _TodayCard._fg;
    return Semantics(
      button: true,
      label: count == 1 ? '1 offener Fehler' : '$count offene Fehler',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.m),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Gap.xs),
            child: Row(
              children: [
                const Icon(Icons.replay_rounded, size: 20, color: fg),
                const SizedBox(width: Gap.s),
                Expanded(
                  child: Text(
                    'Fehler wiederholen',
                    style: context.text.labelLarge?.copyWith(color: fg),
                  ),
                ),
                const SizedBox(width: Gap.s),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Gap.s,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: fg.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(Radii.pill),
                  ),
                  child: Text(
                    '$count',
                    maxLines: 1,
                    softWrap: false,
                    style: AppType.numeric(size: 12, color: fg),
                  ),
                ),
                const SizedBox(width: Gap.xs),
                const Icon(Icons.chevron_right, color: fg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Ruhige Karte mit Symbol, Zeile darüber, Titel und Fortschritt - für
/// Journey, Karteikasten und die empfohlene Session.
///
/// Normal steht das Symbol als Quadrat links und der Zähler neben dem Balken.
/// Bei wenig Platz ([_isTight]) wandert das Symbol klein in die Kopfzeile,
/// der Balken läuft über die volle Breite und der Zähler steht darunter - so
/// bleibt dem Titel die ganze Breite und nichts bricht mitten im Zähler um.
class _ResumeCard extends StatelessWidget {
  const _ResumeCard({
    required this.icon,
    required this.tone,
    required this.label,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.progress,
    this.progressLabel,
    this.trailingIcon = Icons.play_circle_fill_rounded,
    this.hyphenate = false,
    this.accent,
  });

  final IconData icon;
  final TileTone tone;
  final String label;
  final String title;
  final String? subtitle;
  final double? progress;
  final String? progressLabel;
  final IconData trailingIcon;

  /// Titel mit Silbentrennung (Lektionstitel) statt nur wortweise umbrechen.
  final bool hyphenate;

  /// Eigene Symbolfarben, z. B. Akzent des empfohlenen Bereichs.
  final (Color, Color)? accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final tight = _isTight(context);
    final (fg, _) = tone.colors(context);
    final muted = context.text.labelSmall?.copyWith(color: c.textMuted);
    final isPlay = trailingIcon == Icons.play_circle_fill_rounded;

    final labelText = Text(label, style: muted);
    final texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tight)
          Row(
            children: [
              Icon(icon, size: 16, color: fg),
              const SizedBox(width: Gap.xs + 2),
              Expanded(child: labelText),
            ],
          )
        else
          labelText,
        const SizedBox(height: 2),
        if (hyphenate)
          HyphenText(title, style: context.text.titleMedium)
        else
          WordSafeText(title, style: context.text.titleMedium),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(subtitle!, style: muted),
        ],
      ],
    );
    final counter = progressLabel == null
        ? null
        : Text(
            progressLabel!,
            maxLines: 1,
            softWrap: false,
            style: AppType.numeric(size: 12, color: c.textMuted),
          );

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (!tight) ...[
                TileIcon(icon: icon, tone: tone, accent: accent),
                const SizedBox(width: Gap.m),
              ],
              Expanded(child: texts),
              const SizedBox(width: Gap.s),
              Icon(
                trailingIcon,
                size: isPlay ? 34 : 24,
                color: isPlay
                    ? (tone == TileTone.flame ? context.scheme.primary : fg)
                    : c.textMuted,
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: Gap.m),
            if (tight) ...[
              AnimatedBar(value: progress!, minHeight: 5, color: fg),
              if (counter != null) ...[
                const SizedBox(height: Gap.xs + 2),
                counter,
              ],
            ] else
              Row(
                children: [
                  Expanded(
                    child: AnimatedBar(
                      value: progress!,
                      minHeight: 5,
                      color: fg,
                    ),
                  ),
                  if (counter != null) ...[
                    const SizedBox(width: Gap.m),
                    counter,
                  ],
                ],
              ),
          ],
        ],
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
    this.step = 0,
    this.stepCount = 0,
  });

  final Subtopic lesson;
  final int done;
  final int total;

  /// Angefangene Lektion: zuletzt offener Lernschritt, 0 = nicht begonnen.
  final int step;
  final int stepCount;

  @override
  Widget build(BuildContext context) {
    final topic = Topics.byId(lesson.topicId);
    final share = total == 0 ? 0.0 : done / total;
    return _ResumeCard(
      icon: Icons.route_outlined,
      tone: TileTone.flame,
      label: step > 0
          ? 'Journey · Schritt $step von $stepCount'
          : done == 0
          ? 'Journey · Erste Lektion'
          : 'Journey · Nächste Lektion',
      title: lesson.title,
      hyphenate: true,
      subtitle: topic.title,
      progress: share,
      progressLabel: '$done / $total Lektionen',
      onTap: () => context.push('/lektion/${lesson.id}'),
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
                const SizedBox(height: Gap.s),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$value',
                        style: AppType.numeric(
                          size: 52,
                          weight: FontWeight.w800,
                          color: context.scheme.primary,
                        ).copyWith(height: 1, letterSpacing: -1.5),
                      ),
                      TextSpan(
                        text: ' %',
                        style: AppType.numeric(
                          size: 24,
                          weight: FontWeight.w700,
                          color: context.scheme.primary,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  softWrap: false,
                ),
                const SizedBox(height: Gap.m),
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

/// „Sessions nach Themengebiet“: die sieben Katalogbereiche mit
/// Lernfortschritt. Antippen öffnet die Session-Seite des Bereichs, die
/// Lernen, Karteikarten und Quiz zu einer Lektion verbindet.
class _SessionAreas extends ConsumerWidget {
  const _SessionAreas();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(lessonStepsProvider);
    final done = ref.watch(journeyProvider);

    final byArea = {
      for (final area in ExamAreas.all)
        area.id: [
          for (final t in Topics.ofArea(area.id))
            for (final l in Subtopics.ofTopic(t.id))
              if (steps.containsKey(l.id)) l,
        ],
    };
    // Empfohlen: der erste Bereich, in dem noch Lektionen offen sind - so
    // folgt die Session der Lernreihenfolge.
    final recommended =
        ExamAreas.all
            .where((a) => byArea[a.id]!.any((l) => !done.contains(l.id)))
            .firstOrNull ??
        ExamAreas.all.first;
    final recLessons = byArea[recommended.id]!;
    final recDone = recLessons.where((l) => done.contains(l.id)).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle('Session nach Themengebiet'),
        Padding(
          padding: const EdgeInsets.only(bottom: Gap.m),
          child: Text(
            'Lernen, Karteikarten und Quiz zu einer Lektion in einem '
            'Durchgang.',
            style: context.text.bodyMedium?.copyWith(
              color: context.c.textMuted,
            ),
          ),
        ),
        _ResumeCard(
          icon: recommended.icon,
          tone: TileTone.brand,
          accent: recommended.accent.tile(context),
          label: 'Empfohlen · Bereich ${recommended.number}',
          title: recommended.title,
          progress: recLessons.isEmpty ? 0 : recDone / recLessons.length,
          progressLabel: '$recDone / ${recLessons.length} Lektionen',
          trailingIcon: Icons.chevron_right,
          onTap: () => context.push('/session-bereich/${recommended.id}'),
        ),
        const SizedBox(height: Gap.m),
        // Die anderen Bereiche als kompakte Knöpfe statt sieben großer
        // Kacheln - die Startseite bleibt kurz, jeder Bereich ist einen
        // Tipp entfernt.
        Wrap(
          spacing: Gap.s,
          runSpacing: Gap.s,
          children: [
            for (final area in ExamAreas.all)
              if (area.id != recommended.id)
                Tooltip(
                  message: area.title,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      padding: const EdgeInsets.symmetric(horizontal: Gap.m),
                    ),
                    icon: Icon(
                      area.icon,
                      size: 18,
                      color: area.accent.fg(context),
                    ),
                    label: Text('Bereich ${area.number}'),
                    onPressed: () =>
                        context.push('/session-bereich/${area.id}'),
                  ),
                ),
          ],
        ),
      ],
    );
  }
}

/// Karteikasten fortsetzen: laufender Durchlauf, sonst was heute dran ist,
/// sonst die zuletzt gestartete Runde.
class _CardsResumeCard extends ConsumerWidget {
  const _CardsResumeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(cardRunProvider);
    final last = ref.watch(resumeProvider).cards;
    final summary = ref.watch(deckSummaryProvider);
    final due = summary.reviews + summary.fresh;
    final activeRun = run != null && !run.isDone && run.total > 0;

    final String label;
    final String title;
    final double? progress;
    final VoidCallback onTap;
    if (activeRun) {
      label = 'Karten · Durchlauf';
      title = '${run.title}: noch ${run.remainingCount} offen';
      progress = run.progress;
      onTap = () => CardLaunch.continueRun(context, run.title);
    } else if (due > 0) {
      label = 'Karten · Heute dran';
      title = '$due ${due == 1 ? 'Karte wartet' : 'Karten warten'} auf dich';
      progress = summary.mastery;
      onTap = () => context.push(
        '/karten-lernen',
        extra: const CardSessionArgs(title: 'Fällige Karten'),
      );
    } else if (last != null) {
      label = 'Karten · Zuletzt gelernt';
      title = last.title;
      progress = summary.mastery;
      onTap = () => last.topicIds.isEmpty
          ? CardLaunch.randomMix(context, ref)
          : CardLaunch.practice(
              context,
              ref,
              topicIds: last.topicIds,
              title: last.title,
            );
    } else {
      label = 'Karten · Schnell wiederholen';
      title = 'Zufallsmix mit 20 Karten';
      progress = null;
      onTap = () => CardLaunch.randomMix(context, ref);
    }

    return _ResumeCard(
      icon: Icons.style_rounded,
      tone: TileTone.success,
      label: label,
      title: title,
      progress: progress,
      progressLabel: progress == null
          ? null
          : activeRun
          ? '${run.knownCount} / ${run.total}'
          : '${(progress * 100).round()} % sicher',
      onTap: onTap,
    );
  }
}

/// Schnellstart-Kachel. Normal eine [ActionTile]; bei wenig Platz
/// ([_isTight]) steht das Symbol klein vor dem Titel, damit der Untertitel
/// die volle Breite bekommt und nicht über vier Zeilen läuft.
class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final TileTone tone;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!_isTight(context)) {
      return ActionTile(
        icon: icon,
        tone: tone,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
      );
    }
    final (fg, _) = tone.colors(context);
    return Semantics(
      button: true,
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.m, Gap.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 20, color: fg),
                      const SizedBox(width: Gap.s),
                      Expanded(
                        child: Text(title, style: context.text.titleMedium),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: context.text.bodySmall?.copyWith(
                      color: context.c.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Gap.xs),
            Icon(Icons.chevron_right, color: context.c.textMuted),
          ],
        ),
      ),
    );
  }
}
