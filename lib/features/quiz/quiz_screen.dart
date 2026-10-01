import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/util/exam_composer.dart';
import '../../data/models/exam_area.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/hyphenation.dart';
import '../../widgets/mascot.dart';
import '../learn/session_launcher.dart';

/// Der Quiz-Tab: Hier wird abgefragt, nicht erklärt.
///
/// Die Trennung ist Absicht und steht deshalb auch oben im Text: Neuer Stoff
/// kommt aus der Journey, hier wird geprüft, was schon sitzt.
///
/// Aufbau von oben nach unten: die Prüfungsaufgabe des Tages als fester
/// Tagesanker, darunter die Trainingsmodi (Schwächen, Fehler, Kurztest), die
/// Prüfungssimulation und zuletzt die Bereiche für gezieltes Abfragen.
class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mistakes = ref.watch(mistakeStatusProvider);
    final areaReadiness = ref.watch(areaReadinessProvider);
    final daily = ref.watch(dailyPaperProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MascotSays(
                  mood: MascotMood.think,
                  text:
                      'Hier wirst du abgefragt, so gemischt wie in der '
                      'Prüfung: rechnen, Tabellen füllen, formulieren. '
                      'Ankreuzen ist nur ein kleiner Teil.',
                ),
                const SizedBox(height: Gap.xl),

                // ------------------------- Prüfungsaufgabe des Tages
                _DailyCard(paper: daily),
                const SizedBox(height: Gap.xl),

                // ------------------------------------------ Training
                const SectionHeader('Trainieren'),
                ActionTile(
                  icon: Icons.fitness_center_rounded,
                  tone: TileTone.brand,
                  title: 'Schwächen-Training',
                  subtitle:
                      '10 gemischte Aufgaben aus den Themen, in denen dir die '
                      'meisten Punkte fehlen',
                  onTap: () => SessionLauncher.weakness(context, ref),
                ),
                const SizedBox(height: Gap.s),
                ActionTile(
                  icon: Icons.replay_rounded,
                  tone: TileTone.danger,
                  title: 'Fehler wiederholen',
                  subtitle: mistakes.open.isEmpty
                      ? 'Aktuell ist nichts offen'
                      : mistakes.due.isEmpty
                      ? 'Für heute erledigt. Sie kommen an einem anderen '
                            'Tag noch einmal'
                      : 'Erledigt ist ein Fehler erst, wenn er an zwei Tagen '
                            'richtig war',
                  badge: mistakes.due.isEmpty ? null : '${mistakes.due.length}',
                  onTap: mistakes.due.isEmpty
                      ? null
                      : () => SessionLauncher.practice(
                          context,
                          ref,
                          mistakesOnly: true,
                        ),
                ),
                const SizedBox(height: Gap.s),
                ActionTile(
                  icon: Icons.bolt_rounded,
                  tone: TileTone.flame,
                  title: 'Kurztest',
                  subtitle:
                      'Läuft endlos mit allen Bereichen gemischt. Aufhören '
                      'kannst du jederzeit',
                  onTap: () => SessionLauncher.kurztest(context, ref),
                ),
                const SizedBox(height: Gap.xl),

                // --------------------------------------- Simulation
                const SectionHeader('Ernstfall proben'),
                ActionTile(
                  icon: Icons.timer_rounded,
                  tone: TileTone.info,
                  // Zwei Wörter: „Prüfungssimulation“ passt mit großer
                  // Schrift auf 320 px nicht in eine Zeile.
                  title: 'Prüfung simulieren',
                  subtitle:
                      '4 Aufgaben, 100 Punkte, 90 Minuten. Oder erst mal die '
                      'halbe Prüfung',
                  onTap: () => context.push('/pruefung'),
                ),
                const SizedBox(height: Gap.xxl),

                // ------------------------------------ Nach Bereich
                SectionHeader(
                  'Nach Bereich abfragen',
                  subtitle:
                      'Üb gezielt ein Thema. Der Wert rechts ist dein '
                      'Stand im Bereich.',
                  action: TextButton(
                    onPressed: () => context.push('/themen'),
                    child: const Text('Katalog'),
                  ),
                ),
                for (final area in ExamAreas.all) ...[
                  ProgressTile(
                    icon: area.icon,
                    overline: 'BEREICH ${area.number}',
                    title: area.title,
                    progress: (areaReadiness[area.id] ?? 0) / 100,
                    onTap: () => context.push('/bereich/${area.id}'),
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
}

/// Die Prüfungsaufgabe des Tages: eine Fallaufgabe im IHK-Stil, für alle am
/// selben Tag dieselbe. Kleine Dosis des echten Formats und fester Anker
/// für die tägliche Serie.
class _DailyCard extends ConsumerWidget {
  const _DailyCard({required this.paper});

  final ExamPaper? paper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paper = this.paper;
    final task = paper?.tasks.firstOrNull;

    // Heute schon bearbeitet? Abgeleitet aus der Historie.
    var doneToday = false;
    if (task != null) {
      final ids = {for (final q in task.parts) q.id};
      final now = DateTime.now();
      doneToday = ref
          .watch(progressProvider)
          .history
          .any(
            (r) =>
                ids.contains(r.questionId) &&
                r.at.year == now.year &&
                r.at.month == now.month &&
                r.at.day == now.day,
          );
    }

    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TileIcon(
                icon: Icons.today_rounded,
                tone: TileTone.flame,
                enabled: task != null,
              ),
              const SizedBox(width: Gap.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HyphenText(
                      SessionLauncher.dailyTitle,
                      style: context.text.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      task == null
                          ? 'Eine Fallaufgabe im IHK-Stil'
                          : '${task.points} Punkte  ·  '
                                '${task.parts.length} Teilaufgaben  ·  ca. '
                                '${ExamComposer.guideTime(task.points).inMinutes}'
                                ' min',
                      style: context.text.bodySmall?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          if (task == null)
            Text(
              'Die Fallaufgaben sind noch in Arbeit. Sobald sie da sind, '
              'wartet hier jeden Tag eine Aufgabe wie in der Prüfung.',
              style: context.text.bodyMedium?.copyWith(
                color: context.c.textMuted,
              ),
            )
          else ...[
            HyphenText(task.title, style: context.text.titleMedium),
            const SizedBox(height: 2),
            HyphenText(
              '${paper!.company?.name ?? ''}: erst die Situation, dann die '
              'Teilaufgaben a), b), c) … und danach die Musterlösung.',
              style: context.text.bodyMedium?.copyWith(
                color: context.c.textMuted,
              ),
            ),
            if (doneToday) ...[
              const SizedBox(height: Gap.m),
              Row(
                children: [
                  Icon(Icons.check_circle, size: 18, color: context.c.success),
                  const SizedBox(width: Gap.s),
                  Expanded(
                    child: Text(
                      'Heute erledigt. Morgen gibt es eine neue.',
                      style: context.text.bodyMedium?.copyWith(
                        color: context.c.success,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: Gap.l),
            SizedBox(
              width: double.infinity,
              child: doneToday
                  ? OutlinedButton.icon(
                      onPressed: () => SessionLauncher.daily(context, ref),
                      icon: const Icon(Icons.replay),
                      label: const Text('Noch einmal lösen'),
                    )
                  : FilledButton.icon(
                      onPressed: () => SessionLauncher.daily(context, ref),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Aufgabe starten'),
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
