import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/topic.dart';
import '../../state/session_controller.dart';
import '../../core/util/achievements.dart';
import '../../data/models/progress.dart';
import '../../state/providers.dart';
import '../../widgets/achievement_badge.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';
import '../../widgets/question_view.dart';

/// IHK-Notenschlüssel (100-Punkte-Schema).
({String note, String label}) ihkNote(double percent) {
  final p = percent * 100;
  if (p >= 92) return (note: '1', label: 'sehr gut');
  if (p >= 81) return (note: '2', label: 'gut');
  if (p >= 67) return (note: '3', label: 'befriedigend');
  if (p >= 50) return (note: '4', label: 'ausreichend');
  if (p >= 30) return (note: '5', label: 'mangelhaft');
  return (note: '6', label: 'ungenügend');
}

/// Auswertung nach einer Session.
///
/// Der wichtigste Teil ist nicht die Prozentzahl, sondern die Liste darunter:
/// jede Aufgabe aufklappbar mit der vollständigen Erklärung. Wer nach der
/// Simulation nur "58 %" sieht, hat nichts gelernt.
class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    if (session == null || !session.finished) {
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

    final percent = session.totalScore;
    final note = ihkNote(percent);
    final correct = session.items
        .where((i) => i.grade?.isCorrect == true)
        .length;
    final partial = session.items
        .where((i) => i.grade?.isPartial == true)
        .length;
    final wrong = session.items.length - correct - partial;

    // Themenauswertung dieser Runde (nicht der Gesamtstatistik).
    final byTopic = <String, List<SessionItem>>{};
    for (final i in session.items) {
      byTopic.putIfAbsent(i.question.topicId, () => []).add(i);
    }

    // Zurück dorthin, wo die Runde gestartet wurde - Startseite, Quiz,
    // Prüfung oder die Session eines Themengebiets.
    void leave() {
      ref.read(sessionProvider.notifier).clear();
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) leave();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: leave,
            tooltip: 'Schließen',
          ),
          title: Text(
            session.isExam
                ? 'Auswertung Simulation'
                : session.endless
                ? 'Auswertung Kurztest'
                : 'Auswertung',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
          children: [
            ReadableWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        : 'Fehler sind hier erwünscht - jede falsche '
                              'Aufgabe kommt in den Fehlerspeicher und du '
                              'übst sie gezielt nach.',
                  ),
                  const SizedBox(height: Gap.l),
                  if (newBadges.isNotEmpty) ...[
                    _NewBadges(badges: newBadges, statuses: achievements),
                    const SizedBox(height: Gap.l),
                  ],
                  AppCard(
                    padding: const EdgeInsets.all(Gap.xl),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ReadinessRing(
                              value: (percent * 100).round(),
                              label: session.isExam
                                  ? 'Note ${note.note}'
                                  : 'erreicht',
                              caption: session.isExam ? note.label : null,
                              size: 132,
                            ),
                            const SizedBox(width: Gap.xl),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${session.earnedPoints} von ${session.possiblePoints} Punkten',
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
                              ),
                            ),
                          ],
                        ),
                        if (session.isExam) ...[
                          const SizedBox(height: Gap.l),
                          NoteBox(
                            tone: percent >= 0.5
                                ? NoteTone.success
                                : NoteTone.warn,
                            child: Text(
                              percent >= 0.5
                                  ? 'Mit ${(percent * 100).round()} % wärst du '
                                        'bestanden (Note ${note.note}, ${note.label}). '
                                        'Die Punkte holst du jetzt in den Themen '
                                        'unten.'
                                  : 'Unter 50 % gilt als nicht bestanden. Das ist '
                                        'eine Übung, kein Urteil - arbeite die '
                                        'schwächsten Themen unten der Reihe nach ab.',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: Gap.xl),

                  const SectionHeader('Nach Themen'),
                  for (final e in byTopic.entries) ...[
                    _TopicResultRow(topic: Topics.byId(e.key), items: e.value),
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
                    _ReviewTile(index: i, item: session.items[i]),
                    const SizedBox(height: Gap.s),
                  ],
                  const SizedBox(height: Gap.xl),

                  if (wrong + partial > 0)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: leave,
                        icon: const Icon(Icons.replay),
                        label: Text(
                          wrong + partial == 1
                              ? '1 Aufgabe landet im Fehlerspeicher'
                              : '${wrong + partial} Aufgaben landen im '
                                    'Fehlerspeicher',
                        ),
                      ),
                    ),
                  const SizedBox(height: Gap.s),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: leave,
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

class _TopicResultRow extends StatelessWidget {
  const _TopicResultRow({required this.topic, required this.items});

  final Topic topic;
  final List<SessionItem> items;

  @override
  Widget build(BuildContext context) {
    final earned = items.fold<double>(
      0,
      (s, i) => s + (i.grade?.score ?? 0) * i.question.points,
    );
    final possible = items.fold<int>(0, (s, i) => s + i.question.points);
    final ratio = possible == 0 ? 0.0 : earned / possible;

    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          Icon(topic.icon, size: 20, color: context.scheme.primary),
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
                      '${(ratio * 100).round()} %',
                      style: AppType.numeric(size: 13),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.s),
                TopicBar(confidence: ratio, coverage: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.index, required this.item});

  final int index;
  final SessionItem item;

  @override
  Widget build(BuildContext context) {
    final g = item.grade;
    final (color, icon) = g == null
        ? (context.c.textMuted, Icons.help_outline)
        : g.isCorrect
        ? (context.c.success, Icons.check_circle)
        : g.isPartial
        ? (context.c.flame, Icons.adjust)
        : (context.c.danger, Icons.cancel);

    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.l),
      child: Container(
        decoration: BoxDecoration(
          color: context.scheme.surface,
          borderRadius: BorderRadius.circular(Radii.l),
          border: Border.all(color: context.c.border),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: Gap.l),
            childrenPadding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
            leading: Icon(icon, color: color),
            // Vorschau - aufgeklappt steht die ganze Aufgabe darunter.
            title: ClampedText(
              '${index + 1}. ${item.question.prompt}',
              maxLines: 2,
              style: context.text.bodyLarge,
            ),
            subtitle: Text(
              '${Topics.byId(item.question.topicId).title} · '
              '${((g?.score ?? 0) * item.question.points).toStringAsFixed(1).replaceAll('.', ',')}'
              ' von ${item.question.points} Punkten',
              style: context.text.labelSmall?.copyWith(
                color: context.c.textMuted,
              ),
            ),
            children: [
              QuestionView(
                question: item.question,
                answer: item.answer,
                onChanged: (_) {},
                revealed: true,
                grade: item.grade,
              ),
            ],
          ),
        ),
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
