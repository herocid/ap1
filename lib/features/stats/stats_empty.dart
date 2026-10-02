import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../cards/card_launch.dart';
import '../learn/session_launcher.dart';

/// Einstiege aus der leeren Statistik. Alle drei nutzen die vorhandenen
/// Startpunkte der App, damit die Statistik keine eigenen Abläufe erfindet.
class StatsStart {
  const StatsStart._();

  /// Öffnet die erste offene Lektion - oder die Journey, wenn alles
  /// geschafft ist.
  static void lesson(BuildContext context, WidgetRef ref) {
    final next = ref.read(nextLessonProvider);
    if (next == null) {
      context.go('/journey');
    } else {
      context.push('/lektion/${next.id}');
    }
  }

  /// Zehn gemischte Karten: kurz genug für den ersten Versuch.
  static void cards(BuildContext context, WidgetRef ref) =>
      CardLaunch.randomMix(context, ref, count: 10);

  static void quiz(BuildContext context, WidgetRef ref) =>
      SessionLauncher.kurztest(context, ref);
}

/// Einladung statt Nullen: Solange es zu einem Abschnitt noch keine Daten
/// gibt, steht hier in einem Satz, was erscheinen wird, und ein Knopf startet
/// die passende erste Aktion.
class StatsInvite extends StatelessWidget {
  const StatsInvite({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
    required this.actionLabel,
    required this.onAction,
    this.tone = TileTone.brand,
  });

  final IconData icon;
  final String title;
  final String text;
  final String actionLabel;
  final VoidCallback onAction;
  final TileTone tone;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TileIcon(icon: icon, tone: tone),
              const SizedBox(width: Gap.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.text.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      text,
                      style: context.text.bodyMedium?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          FilledButton.tonal(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    );
  }
}

/// Leerzustand der ganzen Statistik: noch keine Aufgabe, keine Karte, keine
/// Lektion. Statt dreier leerer Abschnitte drei Einstiege - jeder füllt
/// einen Teil der Statistik.
class StatsFirstSteps extends ConsumerWidget {
  const StatsFirstSteps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          'Womit fängst du an?',
          subtitle: 'Jeder Einstieg füllt einen Teil deiner Statistik.',
        ),
        ActionTile(
          icon: Icons.route_outlined,
          title: 'Erste Lektion lernen',
          subtitle: 'Zeigt dir, wie weit du auf deinem Lernweg bist.',
          onTap: () => StatsStart.lesson(context, ref),
        ),
        const SizedBox(height: Gap.s),
        ActionTile(
          icon: Icons.style_outlined,
          tone: TileTone.success,
          title: 'Zehn Karten üben',
          subtitle: 'Zeigt dir, welche Karten schon sicher sitzen.',
          onTap: () => StatsStart.cards(context, ref),
        ),
        const SizedBox(height: Gap.s),
        ActionTile(
          icon: Icons.bolt_rounded,
          tone: TileTone.flame,
          title: 'Kurztest starten',
          subtitle: 'Zeigt dir Trefferquote, Stärken und Problemthemen.',
          onTap: () => StatsStart.quiz(context, ref),
        ),
      ],
    );
  }
}
