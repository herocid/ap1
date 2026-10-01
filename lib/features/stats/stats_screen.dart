import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/flashcard.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';
import '../cards/card_launch.dart';
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
                  if (ref.watch(deckProvider).cards.isNotEmpty) ...[
                    const _CardStatsPanel(),
                    const SizedBox(height: Gap.xl),
                  ],
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
                const SizedBox(height: Gap.xl),
                const _CardStatsPanel(),
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

    final solid = deck.learnedCount(cards);
    final accuracy = deck.accuracy(cards);
    final days = activity.lastDays(14);
    final maxDay = days.fold<int>(1, (m, e) => math.max(m, e));

    // Schwächste Themen: nur mit genug gesehenen Karten, damit eine einzige
    // Fehlantwort kein ganzes Thema rot färbt.
    final byTopic = <String, List<Flashcard>>{};
    for (final c in cards) {
      byTopic.putIfAbsent(c.topicId, () => []).add(c);
    }
    final weakTopics = <(Topic, double, int, double)>[];
    for (final e in byTopic.entries) {
      final seen = e.value.where((c) => !deck.stateOf(c.id).isNew).toList();
      if (seen.length < 3) continue;
      final w =
          seen.map((c) => deck.weakness(c.id)!).reduce((a, b) => a + b) /
          seen.length;
      final shaky = deck.weakCards(e.value, limit: 999).length;
      if (shaky == 0) continue;
      weakTopics.add((
        Topics.byId(e.key),
        w,
        shaky,
        deck.accuracy(e.value) ?? 0,
      ));
    }
    weakTopics.sort((a, b) => b.$2.compareTo(a.$2));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          'Karteikarten',
          subtitle: 'Was sitzt, wie oft du übst und wo es noch hakt.',
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
        Text('Schwächste Themen', style: context.text.titleMedium),
        const SizedBox(height: Gap.s),
        if (weakTopics.isEmpty)
          NoteBox(
            tone: NoteTone.info,
            child: Text(
              deck.seenCount(cards) < 3
                  ? 'Lerne ein paar Runden - dann zeigt sich hier, welche '
                        'Themen noch wackeln.'
                  : 'Keine Schwächen erkennbar - alles, was du bisher '
                        'gelernt hast, sitzt.',
            ),
          )
        else
          for (final w in weakTopics.take(5)) ...[
            ProgressTile(
              icon: w.$1.icon,
              tone: TileTone.danger,
              title: w.$1.title,
              progress: w.$4,
              caption:
                  '${(w.$4 * 100).round()} % Treffer · ${w.$3} wackelige '
                  '${w.$3 == 1 ? 'Karte' : 'Karten'}',
              onTap: () => CardLaunch.weak(
                context,
                topicIds: {w.$1.id},
                title: w.$1.title,
              ),
            ),
            const SizedBox(height: Gap.s),
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
