import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/exam_area.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';
import '../learn/session_launcher.dart';

/// Der Quiz-Tab: Hier wird abgefragt, nicht erklärt.
///
/// Die Trennung ist Absicht und steht deshalb auch oben im Text: Neuer Stoff
/// kommt aus der Journey, hier wird geprüft, was schon sitzt. Oben die drei
/// Formate nach Aufwand (kurz, gezielt, ernst), darunter die Bereiche für
/// gezieltes Abfragen.
class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mistakes = ref.watch(progressProvider).openMistakes.length;
    final areaReadiness = ref.watch(areaReadinessProvider);

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
                      'Hier wirst du abgefragt. Neuen Stoff lernst du in '
                      'der Journey - hier zeigt sich, was schon sitzt.',
                ),
                const SizedBox(height: Gap.xl),

                // ------------------------------------------ Kurztest
                AppCard(
                  padding: const EdgeInsets.all(Gap.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TileIcon(
                            icon: Icons.bolt_rounded,
                            tone: TileTone.flame,
                          ),
                          const SizedBox(width: Gap.m),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kurztest',
                                  style: context.text.titleLarge,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Endlos, alle Bereiche gemischt',
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
                      Text(
                        'Eine Zufallsfrage nach der anderen, mit Lösung '
                        'direkt danach. Aufhören kannst du jederzeit - '
                        'gewertet wird, was du beantwortet hast.',
                        style: context.text.bodyMedium?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                      const SizedBox(height: Gap.l),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () =>
                              SessionLauncher.kurztest(context, ref),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Kurztest starten'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.m),

                // ------------------------------- Prüfung und Fehler
                ActionTile(
                  icon: Icons.timer_rounded,
                  tone: TileTone.info,
                  title: 'Prüfungssimulation',
                  subtitle:
                      'Zeitlimit, kein Feedback bis zur Abgabe - wie in '
                      'der AP1',
                  onTap: () => context.push('/pruefung'),
                ),
                const SizedBox(height: Gap.s),
                ActionTile(
                  icon: Icons.replay_rounded,
                  tone: TileTone.danger,
                  title: 'Fehler wiederholen',
                  subtitle: mistakes == 0
                      ? 'Aktuell ist nichts offen'
                      : 'Aufgaben, die zuletzt falsch waren',
                  badge: mistakes == 0 ? null : '$mistakes',
                  onTap: mistakes == 0
                      ? null
                      : () => SessionLauncher.practice(
                          context,
                          ref,
                          mistakesOnly: true,
                        ),
                ),
                const SizedBox(height: Gap.xxl),

                // ------------------------------------ Nach Bereich
                SectionHeader(
                  'Nach Bereich abfragen',
                  subtitle:
                      'Gezielt ein Thema üben. Der Wert rechts ist dein '
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
