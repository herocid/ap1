import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../cards/card_session_screen.dart';
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
    final areaCards =
        allCards.where((c) => areaTopicIds.contains(c.topicId)).toList();
    final dueHere = deck.dueCount(areaCards);

    return Scaffold(
      appBar: AppBar(title: Text('${area.number} ${area.title}')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(area.blurb, style: context.text.bodyLarge),
                const SizedBox(height: Gap.s),
                Text(
                  'Geschätzter Anteil an der AP1: '
                  '${(area.weight * 100).round()} % der Punkte',
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
                const SizedBox(height: Gap.l),
                if (areaCards.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => context.push(
                        '/karten-lernen',
                        extra: CardSessionArgs(
                          topicIds: areaTopicIds,
                          title: area.title,
                        ),
                      ),
                      icon: const Icon(Icons.style_outlined),
                      label: Text(
                        dueHere > 0
                            ? 'Karteikarten lernen ($dueHere fällig)'
                            : 'Karteikarten wiederholen',
                      ),
                    ),
                  ),
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
                    onCards: () => context.push(
                      '/karten-lernen',
                      extra: CardSessionArgs(
                        topicIds: {t.id},
                        title: t.title,
                      ),
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
                Icon(topic.icon, size: 20, color: context.scheme.primary),
                const SizedBox(width: Gap.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(topic.title, style: context.text.titleMedium),
                      const SizedBox(height: 2),
                      Text(
                        topic.blurb,
                        style: context.text.bodyMedium
                            ?.copyWith(color: context.c.textMuted),
                      ),
                    ],
                  ),
                ),
                if (hasContent)
                  Text('${(confidence * 100).round()} %',
                      style: AppType.numeric(size: 13)),
              ],
            ),
            const SizedBox(height: Gap.s),
            if (hasContent) ...[
              TopicBar(confidence: confidence, coverage: coverage),
              const SizedBox(height: Gap.s),
              Text(
                '$seen von $questions Aufgaben gesehen · $cards Karten',
                style: context.text.labelSmall
                    ?.copyWith(color: context.c.textMuted),
              ),
              const SizedBox(height: Gap.s),
              Row(
                children: [
                  TextButton(onPressed: onTheory, child: const Text('Theorie')),
                  const Spacer(),
                  if (cards > 0)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 38),
                        padding: const EdgeInsets.symmetric(horizontal: Gap.m),
                      ),
                      onPressed: onCards,
                      child: const Text('Karten'),
                    ),
                  if (cards > 0 && questions > 0) const SizedBox(width: Gap.s),
                  if (questions > 0)
                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 38),
                        padding: const EdgeInsets.symmetric(horizontal: Gap.l),
                      ),
                      onPressed: onPractice,
                      child: const Text('Üben'),
                    ),
                ],
              ),
            ] else
              Text(
                'Inhalte folgen.',
                style: context.text.labelSmall
                    ?.copyWith(color: context.c.textMuted),
              ),
          ],
        ),
      ),
    );
  }
}
