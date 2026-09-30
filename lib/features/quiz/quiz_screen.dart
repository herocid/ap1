import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
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
                  padding: const EdgeInsets.all(Gap.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _IconBadge(
                            icon: Icons.bolt_rounded,
                            color: context.c.flame,
                            background: context.c.flameBg,
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
                                Text(
                                  'Endlos, alle Bereiche gemischt',
                                  style: context.text.labelSmall?.copyWith(
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
                  _AreaRow(
                    area: area,
                    readiness: areaReadiness[area.id] ?? 0,
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

class _IconBadge extends StatelessWidget {
  const _IconBadge({
    required this.icon,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Radii.m),
      ),
      child: Icon(icon, size: 24, color: color),
    );
  }
}

class _AreaRow extends StatelessWidget {
  const _AreaRow({
    required this.area,
    required this.readiness,
    required this.onTap,
  });

  final ExamArea area;
  final int readiness;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.m, Gap.m),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.m),
            ),
            child: Icon(area.icon, size: 22, color: context.scheme.primary),
          ),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BEREICH ${area.number}',
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                    letterSpacing: 1,
                  ),
                ),
                Text(area.title, style: context.text.titleSmall),
                const SizedBox(height: Gap.s),
                Row(
                  children: [
                    Expanded(
                      child: TopicBar(confidence: readiness / 100, coverage: 0),
                    ),
                    const SizedBox(width: Gap.s),
                    Text(
                      '$readiness %',
                      style: AppType.numeric(
                        size: 12,
                        color: context.c.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: Gap.xs),
          Icon(Icons.chevron_right, color: context.c.textMuted),
        ],
      ),
    );
  }
}
