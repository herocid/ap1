import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/flashcard.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';
import '../../data/models/subtopic.dart';
import '../cards/card_launch.dart';
import '../learn/session_launcher.dart';
import '../../state/providers.dart';
import '../../widgets/achievement_badge.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../../widgets/mascot.dart';

/// Statistik in der Reihenfolge, in der man sie liest:
///
/// 1. Karteikarten - wie sicher die Karten sitzen.
/// 2. Quiz - Trefferquote, Aktivität, Prüfungsreife je Thema.
/// 3. Problemthemen - aus Quiz und Karten zusammen: wo es am meisten hakt.
/// 4. Journey - wie weit der Lernweg ist.
/// 5. Abzeichen - ganz unten, als Belohnung.
///
/// Bit steht oben und sagt in einem Satz, was die Zahlen bedeuten.
class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final achievements = ref.watch(achievementsProvider);
    final problems = ref.watch(_problemTopicsProvider);
    final deck = ref.watch(deckProvider);
    final lessonsDone = ref.watch(journeyProvider).length;

    final tip =
        progress.history.isEmpty && deck.cards.isEmpty && lessonsDone == 0
        ? (
            mood: MascotMood.think,
            title: 'Hier entsteht dein Lernbild',
            text:
                'Sobald du lernst, siehst du hier, was sitzt und wo es hakt. '
                'Starte mit einer Lektion oder ein paar Karten.',
          )
        : problems.isNotEmpty
        ? (
            mood: MascotMood.think,
            title: 'Dein größter Hebel',
            text:
                '„${problems.first.topic.title}“ hakt noch am meisten. '
                'Tipp das Thema bei den Problemthemen an - ich stelle dir '
                'die passende Übung zusammen.',
          )
        : (
            mood: MascotMood.cheer,
            title: 'Keine Problemthemen',
            text:
                'Was du bisher gelernt hast, sitzt. Nimm dir jetzt ein Thema '
                'vor, das du noch nicht angefasst hast.',
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MascotSays(mood: tip.mood, title: tip.title, text: tip.text),
                const SizedBox(height: Gap.xl),
                const _CardStatsPanel(),
                const SizedBox(height: Gap.xxl),
                _QuizPanel(progress: progress),
                const SizedBox(height: Gap.xxl),
                _ProblemTopicsPanel(problems: problems),
                const SizedBox(height: Gap.xxl),
                const _JourneyPanel(),
                const SizedBox(height: Gap.xxl),
                const SectionHeader(
                  'Abzeichen',
                  subtitle: 'Für Ausdauer, Können und Meilensteine.',
                ),
                AchievementsPanel(statuses: achievements),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Quiz: Trefferquote, Level, Aktivität und Prüfungsreife je Thema.
class _QuizPanel extends ConsumerWidget {
  const _QuizPanel({required this.progress});

  final ProgressState progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readiness = ref.watch(readinessProvider);
    final stats = ref.watch(topicStatsProvider);
    final poolSize = ref.watch(poolSizeProvider);
    final history = progress.history;
    final days = _last14Days(history);
    final maxDay = days.fold<int>(1, (m, e) => math.max(m, e));
    final quote = history.isEmpty
        ? null
        : history.fold<double>(0, (s, r) => s + r.score) / history.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          'Quiz',
          subtitle: 'Wie du bei Aufgaben und Prüfungsfragen abschneidest.',
        ),
        StatTileRow(
          children: [
            StatTile(
              icon: Icons.checklist_rtl,
              value: '${progress.totalAnswered}',
              label: 'Aufgaben',
              color: context.c.success,
            ),
            StatTile(
              icon: Icons.track_changes,
              value: quote == null ? '–' : '${(quote * 100).round()} %',
              label: 'Trefferquote',
            ),
            StatTile(
              icon: Icons.local_fire_department,
              value: '${progress.streak}',
              label: progress.streak == 1 ? 'Tag Serie' : 'Tage Serie',
              color: context.c.flame,
            ),
          ],
        ),
        const SizedBox(height: Gap.l),
        if (history.isEmpty)
          const NoteBox(
            tone: NoteTone.info,
            child: Text(
              'Noch keine Quizrunde gespielt. Starte im Tab „Quiz“ einen '
              'Kurztest - nach zehn Aufgaben siehst du hier deine Stärken.',
            ),
          )
        else ...[
          AppCard(
            padding: const EdgeInsets.all(Gap.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level ${progress.level}',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: Gap.m),
                AnimatedBar(value: progress.levelProgress, minHeight: 8),
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
                Text(
                  'Aufgaben der letzten 14 Tage',
                  style: context.text.titleMedium,
                ),
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
                    Flexible(
                      child: Text(
                        'vor 14 Tagen',
                        style: context.text.labelSmall?.copyWith(
                          color: context.c.textMuted,
                        ),
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
          const SizedBox(height: Gap.l),
          // Die 35 Themen eingeklappt: aufgeklappt wären sie eine
          // Bildschirmlänge nach der anderen.
          AppCard(
            padding: EdgeInsets.zero,
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: Gap.l),
                childrenPadding: const EdgeInsets.fromLTRB(
                  Gap.s,
                  0,
                  Gap.s,
                  Gap.s,
                ),
                title: Text(
                  'Prüfungsreife: $readiness %',
                  style: context.text.titleMedium,
                ),
                subtitle: Text(
                  progress.readinessLabel(readiness),
                  style: context.text.bodySmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
                children: [
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
          ),
        ],
      ],
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

/// Ein Problemthema: schwach im Quiz, bei den Karten oder in beidem.
class _ProblemTopic {
  const _ProblemTopic({
    required this.topic,
    required this.score,
    this.quiz,
    this.cards,
  });

  final Topic topic;

  /// 0..1, Mittel aus Quiz- und Kartenquote (soweit vorhanden).
  final double score;
  final double? quiz;
  final double? cards;
}

/// Problemthemen aus Quiz und Karten. Ein Thema zählt erst ab drei Antworten
/// (Quiz) bzw. drei gesehenen Karten - eine einzelne Fehlantwort macht noch
/// kein Problemthema. Problem = unter 70 %.
final _problemTopicsProvider = Provider<List<_ProblemTopic>>((ref) {
  final stats = ref.watch(topicStatsProvider);
  final cards = ref.watch(flashcardsProvider);
  final deck = ref.watch(deckProvider);

  final byTopic = <String, List<Flashcard>>{};
  for (final c in cards) {
    byTopic.putIfAbsent(c.topicId, () => []).add(c);
  }

  final out = <_ProblemTopic>[];
  for (final t in Topics.all) {
    final st = stats[t.id];
    final quiz = st != null && st.answered >= 3 ? st.mastery : null;
    final topicCards = byTopic[t.id] ?? const <Flashcard>[];
    final card = deck.seenCount(topicCards) >= 3
        ? deck.accuracy(topicCards)
        : null;
    final parts = [?quiz, ?card];
    if (parts.isEmpty) continue;
    final score = parts.reduce((a, b) => a + b) / parts.length;
    if (score >= 0.7) continue;
    out.add(_ProblemTopic(topic: t, score: score, quiz: quiz, cards: card));
  }
  out.sort((a, b) => a.score.compareTo(b.score));
  return out;
});

class _ProblemTopicsPanel extends ConsumerWidget {
  const _ProblemTopicsPanel({required this.problems});

  final List<_ProblemTopic> problems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String pct(double v) => '${(v * 100).round()} %';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          'Problemthemen',
          subtitle:
              'Aus deinen Quizrunden und Karten - antippen startet die '
              'passende Übung.',
        ),
        if (problems.isEmpty)
          const NoteBox(
            tone: NoteTone.info,
            child: Text(
              'Noch keine Problemthemen. Ein Thema landet hier, wenn du '
              'darin unter 70 % liegst - ab drei Antworten oder Karten.',
            ),
          )
        else
          for (final p in problems.take(6)) ...[
            ProgressTile(
              icon: p.topic.icon,
              tone: TileTone.danger,
              title: p.topic.title,
              progress: p.score,
              caption: [
                if (p.quiz != null) 'Quiz ${pct(p.quiz!)}',
                if (p.cards != null) 'Karten ${pct(p.cards!)}',
              ].join(' · '),
              // Geübt wird da, wo es am meisten hakt.
              onTap: () => (p.cards ?? 2) < (p.quiz ?? 2)
                  ? CardLaunch.weak(
                      context,
                      topicIds: {p.topic.id},
                      title: p.topic.title,
                    )
                  : SessionLauncher.practice(context, ref, topicId: p.topic.id),
            ),
            const SizedBox(height: Gap.s),
          ],
      ],
    );
  }
}

/// Journey: Lektionen je Bereich und die angefangene Lektion.
class _JourneyPanel extends ConsumerWidget {
  const _JourneyPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider);
    final done = ref.watch(journeyProvider);
    final inProgress = ref.watch(lessonInProgressProvider);
    final steps = ref.watch(lessonStepsProvider);
    final doneCount = lessons.where((l) => done.contains(l.id)).length;
    final stepsRead = lessons
        .where((l) => done.contains(l.id))
        .fold<int>(0, (s, l) => s + (steps[l.id]?.length ?? 0));
    final open = inProgress == null
        ? null
        : Subtopics.byId(inProgress.lessonId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          'Journey',
          subtitle: 'Dein Lernweg durch alle sieben Prüfungsbereiche.',
        ),
        StatTileRow(
          children: [
            StatTile(
              icon: Icons.route_outlined,
              value: '$doneCount',
              label: 'von ${lessons.length} Lektionen',
              color: context.c.flame,
            ),
            StatTile(
              icon: Icons.menu_book_outlined,
              value: '$stepsRead',
              label: 'Lernschritte',
            ),
            StatTile(
              icon: Icons.pie_chart_outline,
              value: lessons.isEmpty
                  ? '0 %'
                  : '${(doneCount / lessons.length * 100).round()} %',
              label: 'geschafft',
              color: context.c.success,
            ),
          ],
        ),
        if (open != null) ...[
          const SizedBox(height: Gap.l),
          ActionTile(
            icon: Icons.bookmark_outline,
            tone: TileTone.flame,
            title: open.title,
            subtitle:
                'Angefangen - weiter bei Schritt ${inProgress!.page} von '
                '${steps[open.id]?.length ?? 0}',
            onTap: () => context.push('/lektion/${open.id}'),
          ),
        ],
        const SizedBox(height: Gap.l),
        for (final area in ExamAreas.all) ...[
          Builder(
            builder: (context) {
              final areaLessons = lessons
                  .where((l) => Topics.byId(l.topicId).areaId == area.id)
                  .toList();
              if (areaLessons.isEmpty) return const SizedBox.shrink();
              final n = areaLessons.where((l) => done.contains(l.id)).length;
              return ProgressTile(
                icon: area.icon,
                tone: TileTone.flame,
                overline: 'BEREICH ${area.number}',
                title: area.title,
                progress: n / areaLessons.length,
                caption: '$n von ${areaLessons.length} Lektionen',
                onTap: () => context.go('/journey'),
              );
            },
          ),
          const SizedBox(height: Gap.s),
        ],
      ],
    );
  }
}

class _ActivityChart extends StatelessWidget {
  const _ActivityChart({
    required this.values,
    required this.max,
    required this.barColor,
    required this.trackColor,
    this.unit = 'Aufgaben',
  });

  final List<int> values;
  final int max;
  final Color barColor;
  final Color trackColor;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < values.length; i++) ...[
          Expanded(
            child: Tooltip(
              message: '${values[i]} $unit',
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
                  // Flexible: Mit großer Schrift braucht die Zahl über dem
                  // Balken mehr Höhe - dann wird der Balken kürzer, statt
                  // unten aus dem Diagramm zu laufen.
                  Flexible(
                    child: TweenAnimationBuilder<double>(
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

/// Karteikarten in der Statistik: wie viel sitzt, wie oft gelernt wurde,
/// wie weit der Durchlauf ist - und vor allem, wo die Schwächen liegen.
class _CardStatsPanel extends ConsumerWidget {
  const _CardStatsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(flashcardsProvider);
    final deck = ref.watch(deckProvider);
    final activity = ref.watch(cardActivityProvider);
    final run = ref.watch(cardRunProvider);

    final summary = ref.watch(deckSummaryProvider);
    final solid = summary.solid;
    final accuracy = summary.accuracy;
    final days = activity.lastDays(14);
    final maxDay = days.fold<int>(1, (m, e) => math.max(m, e));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          'Karteikarten',
          subtitle: 'Wie sicher deine Karten sitzen und wie oft du übst.',
        ),
        StatTileRow(
          children: [
            StatTile(
              icon: Icons.verified_outlined,
              value: '$solid',
              label: 'von ${cards.length} sitzen',
              color: context.c.success,
            ),
            StatTile(
              icon: Icons.track_changes,
              value: accuracy == null ? '–' : '${(accuracy * 100).round()} %',
              label: 'Trefferquote',
            ),
            StatTile(
              icon: Icons.today_outlined,
              value: '${activity.reviewsOn(DateTime.now())}',
              label: 'heute geübt',
              color: context.c.flame,
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
                'Karten der letzten 14 Tage',
                style: context.text.titleMedium,
              ),
              const SizedBox(height: Gap.xs),
              Text(
                '${activity.totalReviews} Abfragen insgesamt · '
                '${activity.streak()} ${activity.streak() == 1 ? 'Tag' : 'Tage'} in Folge',
                style: context.text.bodySmall?.copyWith(
                  color: context.c.textMuted,
                ),
              ),
              const SizedBox(height: Gap.l),
              // Ohne Abfragen wäre das Diagramm nur eine Reihe grauer
              // Striche - dann lieber ein Satz, wie es losgeht.
              if (activity.totalReviews == 0)
                Text(
                  'Noch keine Karten geübt. Schon fünf Minuten im '
                  'Karteikasten füllen dieses Diagramm.',
                  style: context.text.bodyMedium?.copyWith(
                    color: context.c.textMuted,
                  ),
                )
              else
                SizedBox(
                  height: 92,
                  child: _ActivityChart(
                    values: days,
                    max: maxDay,
                    barColor: context.c.flame,
                    trackColor: context.c.surfaceAlt,
                    unit: 'Karten',
                  ),
                ),
            ],
          ),
        ),
        if (run != null && run.total > 0) ...[
          const SizedBox(height: Gap.l),
          ProgressTile(
            icon: run.isDone
                ? Icons.emoji_events_outlined
                : Icons.all_inclusive,
            tone: run.isDone ? TileTone.success : TileTone.flame,
            overline: run.isDone ? 'DURCHLAUF GESCHAFFT' : 'DURCHLAUF',
            title: run.title,
            progress: run.progress,
            caption:
                '${run.knownCount} von ${run.total} gewusst · '
                '${run.missCount} Fehlversuche',
            onTap: run.isDone
                ? null
                : () => CardLaunch.continueRun(context, run.title),
          ),
        ],
        const SizedBox(height: Gap.l),
        Text('Karten je Bereich', style: context.text.titleMedium),
        const SizedBox(height: Gap.xs),
        Text(
          'Balken = wie sicher, Strich = wie viel du schon gesehen hast.',
          style: context.text.bodySmall?.copyWith(color: context.c.textMuted),
        ),
        const SizedBox(height: Gap.s),
        for (final area in ExamAreas.all) ...[
          Builder(
            builder: (context) {
              final topicIds = Topics.ofArea(area.id).map((t) => t.id).toSet();
              final areaCards = cards
                  .where((c) => topicIds.contains(c.topicId))
                  .toList();
              if (areaCards.isEmpty) return const SizedBox.shrink();
              final seen = deck.seenCount(areaCards);
              final acc = deck.accuracy(areaCards);
              return ProgressTile(
                icon: area.icon,
                overline: 'BEREICH ${area.number}',
                title: area.title,
                progress: deck.mastery(areaCards),
                coverage: seen / areaCards.length,
                caption:
                    '$seen/${areaCards.length} gesehen'
                    '${acc == null ? '' : ' · ${(acc * 100).round()} % Treffer'}',
                onTap: () => CardLaunch.practice(
                  context,
                  ref,
                  topicIds: topicIds,
                  title: area.title,
                ),
              );
            },
          ),
          const SizedBox(height: Gap.s),
        ],
      ],
    );
  }
}
