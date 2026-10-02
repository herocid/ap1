import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bit_tips.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/hyphenation.dart';
import '../cards/card_launch.dart';
import '../learn/session_launcher.dart';
import '../learn/theory_sheet.dart';

/// Die Themen eines Katalogbereichs.
class AreaDetailScreen extends ConsumerWidget {
  const AreaDetailScreen({super.key, required this.areaId});

  final String areaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final area = ExamAreas.byId(areaId);
    final topics = Topics.ofArea(areaId);
    final stats = ref.watch(topicStatsProvider);
    final poolSize = ref.watch(poolSizeProvider);
    final cardCount = ref.watch(cardCountProvider);
    final deck = ref.watch(deckProvider);
    final allCards = ref.watch(flashcardsProvider);

    final areaTopicIds = topics.map((t) => t.id).toSet();
    final areaCards = allCards
        .where((c) => areaTopicIds.contains(c.topicId))
        .toList();
    final dueHere = deck.dueCount(areaCards);

    return Scaffold(
      // Kurzer Titel oben, der volle Bereichsname steht darunter im Inhalt -
      // in der Kopfzeile würde er auf schmalen Handys gekürzt.
      appBar: AppBar(title: Text('Bereich ${area.number}')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HyphenText(area.title, style: context.text.headlineSmall),
                const SizedBox(height: Gap.xs),
                HyphenText(area.blurb, style: context.text.bodyLarge),
                const SizedBox(height: Gap.s),
                Text(
                  'Geschätzter Anteil an der AP1: '
                  '${(area.weight * 100).round()} % der Punkte',
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
                const SizedBox(height: Gap.l),
                if (areaCards.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => CardLaunch.practice(
                        context,
                        ref,
                        topicIds: areaTopicIds,
                        title: area.title,
                      ),
                      icon: const Icon(Icons.style_outlined),
                      label: Text(
                        dueHere > 0
                            ? 'Karteikarten lernen ($dueHere fällig)'
                            : 'Karteikarten wiederholen',
                      ),
                    ),
                  ),
                const SizedBox(height: Gap.l),
                BitTip.area(areaId),
                const SizedBox(height: Gap.xl),
                const SectionHeader('Themen'),
                for (final t in topics) ...[
                  _TopicTile(
                    topic: t,
                    confidence: stats[t.id]?.confidence ?? 0,
                    coverage: stats[t.id]?.coverage ?? 0,
                    seen: stats[t.id]?.distinctQuestions ?? 0,
                    questions: poolSize[t.id] ?? 0,
                    cards: cardCount[t.id] ?? 0,
                    onPractice: () =>
                        SessionLauncher.practice(context, ref, topicId: t.id),
                    onCards: () => CardLaunch.practice(
                      context,
                      ref,
                      topicIds: {t.id},
                      title: t.title,
                    ),
                    onTheory: () =>
                        showTheorySheet(context, ref, topicId: t.id),
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

class _TopicTile extends StatelessWidget {
  const _TopicTile({
    required this.topic,
    required this.confidence,
    required this.coverage,
    required this.seen,
    required this.questions,
    required this.cards,
    required this.onPractice,
    required this.onCards,
    required this.onTheory,
  });

  final Topic topic;
  final double confidence;
  final double coverage;
  final int seen;
  final int questions;
  final int cards;
  final VoidCallback onPractice;
  final VoidCallback onCards;
  final VoidCallback onTheory;

  @override
  Widget build(BuildContext context) {
    final hasContent = questions > 0 || cards > 0;

    return Opacity(
      opacity: hasContent ? 1 : 0.55,
      child: AppCard(
        padding: const EdgeInsets.all(Gap.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TileIcon(
                  icon: topic.icon,
                  enabled: hasContent,
                  accent: ExamAreas.byId(topic.areaId).accent.tile(context),
                ),
                const SizedBox(width: Gap.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HyphenText(topic.title, style: context.text.titleMedium),
                      const SizedBox(height: 2),
                      HyphenText(
                        topic.blurb,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasContent)
                  Text(
                    '${(confidence * 100).round()} %',
                    style: AppType.numeric(size: 13),
                  ),
              ],
            ),
            const SizedBox(height: Gap.s),
            if (hasContent) ...[
              TopicBar(confidence: confidence, coverage: coverage),
              const SizedBox(height: Gap.s),
              Text(
                '$seen von $questions Aufgaben gesehen · $cards Karten',
                style: context.text.labelSmall?.copyWith(
                  color: context.c.textMuted,
                ),
              ),
              const SizedBox(height: Gap.s),
              // Karten und Üben teilen sich die Restbreite - mit festen
              // Breiten lief die Zeile auf schmalen Handys über.
              // Die Knöpfe rutschen bei wenig Platz in die nächste Zeile,
              // statt ihre Beschriftung zu zerhacken.
              Wrap(
                spacing: Gap.s,
                runSpacing: Gap.s,
                children: [
                  TextButton.icon(
                    onPressed: onTheory,
                    icon: const Icon(Icons.menu_book_outlined, size: 18),
                    label: const Text('Theorie'),
                  ),
                  if (cards > 0)
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 48),
                      ),
                      onPressed: onCards,
                      icon: const Icon(Icons.style_outlined, size: 18),
                      label: const Text('Karten'),
                    ),
                  if (questions > 0)
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 48),
                      ),
                      onPressed: onPractice,
                      icon: const Icon(Icons.quiz_outlined, size: 18),
                      label: const Text('Üben'),
                    ),
                ],
              ),
            ] else
              Text(
                'Inhalte folgen.',
                style: context.text.labelSmall?.copyWith(
                  color: context.c.textMuted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
