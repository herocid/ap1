import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/flashcard.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import 'card_session_screen.dart';

/// Der Karteikasten.
///
/// Zeigt, was heute fällig ist, wie die Karten über die fünf Leitner-Fächer
/// verteilt sind und wo noch Lücken sind. Von hier aus startet man entweder
/// alles Fällige oder gezielt einen Bereich.
class CardsOverviewScreen extends ConsumerWidget {
  const CardsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(flashcardsProvider);
    final deck = ref.watch(deckProvider);
    final due = deck.dueCount(cards);
    final mastery = deck.mastery(cards);

    if (cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Karteikasten')),
        body: const EmptyState(
          icon: Icons.style_outlined,
          title: 'Noch keine Karten',
          message: 'Für diesen Stand sind noch keine Karteikarten hinterlegt.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Karteikasten')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCard(
                  padding: const EdgeInsets.all(Gap.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Zahl und Aussage in einer Zeile, Erklärung darunter
                      // über die volle Breite - die Zahl rechts neben dem
                      // Text quetschte ihn auf 320 px auf vier Zeilen.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$due',
                            style: AppType.numeric(
                              size: 34,
                              weight: FontWeight.w700,
                              color: due == 0
                                  ? context.c.success
                                  : context.scheme.primary,
                            ),
                          ),
                          const SizedBox(width: Gap.m),
                          Expanded(
                            child: Text(
                              due == 0
                                  ? 'Heute nichts fällig'
                                  : due == 1
                                  ? 'Karte heute fällig'
                                  : 'Karten heute fällig',
                              style: context.text.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Gap.xs),
                      Text(
                        due == 0
                            ? 'Der Kasten legt jede Karte nach dem passenden '
                                  'Abstand wieder vor.'
                            : 'Diese Karten sollten heute wiederholt werden.',
                        style: context.text.bodyMedium?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                      const SizedBox(height: Gap.l),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: due == 0
                              ? null
                              : () => _start(context, const CardSessionArgs()),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: Text(
                            due == 0
                                ? 'Alles erledigt'
                                : 'Lernen (${due > 20 ? 20 : due} Karten)',
                          ),
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Verteilung im Kasten',
                              style: context.text.titleMedium,
                            ),
                          ),
                          const SizedBox(width: Gap.s),
                          CountBadge(
                            label: '${(mastery * 100).round()} % sicher',
                            tone: TileTone.success,
                          ),
                        ],
                      ),
                      const SizedBox(height: Gap.xs),
                      Text(
                        'Rechts sitzt es. Was nicht gewusst wird, fällt zurück '
                        'in Fach 1.',
                        style: context.text.bodySmall?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                      const SizedBox(height: Gap.l),
                      _BoxChart(cards: cards, deck: deck),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.xl),

                const SectionHeader(
                  'Nach Bereich lernen',
                  subtitle:
                      'Gezielt ein Themengebiet durchgehen, '
                      'auch wenn es noch nicht fällig ist.',
                ),
                for (final area in ExamAreas.all)
                  _AreaCardRow(area: area, cards: cards, deck: deck),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _start(BuildContext context, CardSessionArgs args) {
    context.push('/karten-lernen', extra: args);
  }
}

class _BoxChart extends StatelessWidget {
  const _BoxChart({required this.cards, required this.deck});

  final List<Flashcard> cards;
  final DeckState deck;

  @override
  Widget build(BuildContext context) {
    final counts = List<int>.filled(Leitner.boxCount, 0);
    var untouched = 0;
    for (final c in cards) {
      final s = deck.stateOf(c.id);
      if (s.isNew) {
        untouched++;
      } else {
        counts[s.box - 1]++;
      }
    }
    final max = [untouched, ...counts].fold<int>(1, (m, v) => v > m ? v : m);

    Widget bar(String label, int value, Color color) => Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: AppType.numeric(size: 12, color: context.c.textMuted),
          ),
          const SizedBox(height: 4),
          Container(
            height: 70 * (value / max).clamp(0.06, 1.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: Gap.s),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.text.labelSmall?.copyWith(
              color: context.c.textMuted,
            ),
          ),
        ],
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        bar('neu', untouched, context.c.border),
        const SizedBox(width: Gap.s),
        for (var i = 0; i < Leitner.boxCount; i++) ...[
          bar(
            '${i + 1}',
            counts[i],
            Color.lerp(
              context.scheme.primary,
              context.c.success,
              i / (Leitner.boxCount - 1),
            )!,
          ),
          if (i < Leitner.boxCount - 1) const SizedBox(width: Gap.s),
        ],
      ],
    );
  }
}

class _AreaCardRow extends StatelessWidget {
  const _AreaCardRow({
    required this.area,
    required this.cards,
    required this.deck,
  });

  final ExamArea area;
  final List<Flashcard> cards;
  final DeckState deck;

  @override
  Widget build(BuildContext context) {
    final topicIds = Topics.ofArea(area.id).map((t) => t.id).toSet();
    final areaCards = cards.where((c) => topicIds.contains(c.topicId)).toList();

    final due = deck.dueCount(areaCards);

    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.s),
      child: ProgressTile(
        icon: area.icon,
        overline: 'BEREICH ${area.number}',
        title: area.title,
        enabled: areaCards.isNotEmpty,
        progress: areaCards.isEmpty ? 0 : deck.mastery(areaCards),
        caption: areaCards.isEmpty
            ? 'Karten folgen'
            : '${areaCards.length} Karten',
        badge: due > 0 ? '$due fällig' : null,
        onTap: areaCards.isEmpty
            ? null
            : () => context.push(
                '/karten-lernen',
                extra: CardSessionArgs(topicIds: topicIds, title: area.title),
              ),
      ),
    );
  }
}
