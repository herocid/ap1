import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/util/feed_order.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/nugget.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../cards/card_session_screen.dart';
import '../learn/session_launcher.dart';
import 'nugget_card.dart';

/// Der Lern-Feed: kurze Beiträge zum Durchscrollen, für die Bahn und die
/// Pause. Endlos - nach jeder Runde geht es in neuer Reihenfolge weiter, und
/// eine Trennzeile sagt ehrlich, dass jetzt Wiederholungen kommen.
class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  String? _areaId;
  final Map<int, List<Nugget>> _rounds = {};

  List<Nugget> _filtered(List<Nugget> all) => _areaId == null
      ? all
      : all.where((n) => Topics.byId(n.topicId).areaId == _areaId).toList();

  List<Nugget> _round(List<Nugget> items, int r) =>
      _rounds.putIfAbsent(r, () {
        final next = FeedOrder.round(items, seed: FeedOrder.daySeed() + r);
        // Rundenwechsel: nicht denselben Beitrag zweimal direkt hintereinander.
        final prev = r > 0 ? _round(items, r - 1) : null;
        if (prev != null && next.length > 1 && next.first.id == prev.last.id) {
          next.add(next.removeAt(0));
        }
        return next;
      });

  void _setArea(String? id) => setState(() {
        _areaId = id;
        _rounds.clear();
      });

  @override
  Widget build(BuildContext context) {
    final all = ref.watch(nuggetsProvider);
    final items = _filtered(all);
    final areasWithContent = ExamAreas.all
        .where((a) => all.any((n) => Topics.byId(n.topicId).areaId == a.id))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ReadableWidth(
              shrinkHeight: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lern-Feed', style: context.text.headlineSmall),
                    const SizedBox(height: 2),
                    Text(
                      'Kurz, konkret, prüfungsnah. Für die Bahn und die Pause.',
                      style: context.text.bodyMedium
                          ?.copyWith(color: context.c.textMuted),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Gap.m),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Gap.l),
                children: [
                  _AreaChip(
                    label: 'Alle',
                    selected: _areaId == null,
                    onTap: () => _setArea(null),
                  ),
                  for (final a in areasWithContent)
                    _AreaChip(
                      label: '${a.number} ${a.title}',
                      selected: _areaId == a.id,
                      onTap: () => _setArea(a.id),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Gap.s),
            Expanded(
              child: items.isEmpty
                  ? const EmptyState(
                      icon: Icons.dynamic_feed_outlined,
                      title: 'Noch keine Beiträge',
                      message: 'Für diesen Bereich gibt es noch keine '
                          'Feed-Beiträge.',
                    )
                  : ListView.builder(
                      key: ValueKey(_areaId),
                      padding: const EdgeInsets.fromLTRB(
                          Gap.l, Gap.s, Gap.l, Gap.xxxl),
                      itemBuilder: (context, i) {
                        final perRound = items.length + 1;
                        final r = i ~/ perRound;
                        final pos = i % perRound;
                        return ReadableWidth(
                          maxWidth: 640,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: Gap.l),
                            child: pos == items.length
                                ? _RoundDivider(count: items.length)
                                : NuggetCard(
                                    nugget: _round(items, r)[pos],
                                    action: _NuggetAction(
                                        topicId: _round(items, r)[pos].topicId),
                                  ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AreaChip extends StatelessWidget {
  const _AreaChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Gap.s),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

/// Führt vom Lesen ins Üben: zuerst Aufgaben, sonst Karteikarten.
class _NuggetAction extends ConsumerWidget {
  const _NuggetAction({required this.topicId});

  final String topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(poolSizeProvider)[topicId] ?? 0;
    final cards = ref.watch(cardCountProvider)[topicId] ?? 0;
    final topic = Topics.byId(topicId);

    if (questions > 0) {
      return TextButton.icon(
        onPressed: () =>
            SessionLauncher.practice(context, ref, topicId: topicId),
        icon: const Icon(Icons.play_arrow_rounded, size: 20),
        label: Text('Jetzt üben · $questions Aufgaben'),
      );
    }
    if (cards > 0) {
      return TextButton.icon(
        onPressed: () => context.push(
          '/karten-lernen',
          extra: CardSessionArgs(topicIds: {topicId}, title: topic.title),
        ),
        icon: const Icon(Icons.style_outlined, size: 20),
        label: Text('Karten lernen · $cards Karten'),
      );
    }
    return const SizedBox.shrink();
  }
}

class _RoundDivider extends StatelessWidget {
  const _RoundDivider({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.l),
      child: Row(
        children: [
          Expanded(child: Divider(color: context.c.border)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Gap.m),
            child: Column(
              children: [
                Icon(Icons.check_circle_outline,
                    size: 20, color: context.c.success),
                const SizedBox(height: Gap.xs),
                Text(
                  'Alle $count Beiträge gesehen',
                  style: context.text.labelLarge,
                ),
                Text(
                  'Weiter geht es in neuer Reihenfolge',
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
              ],
            ),
          ),
          Expanded(child: Divider(color: context.c.border)),
        ],
      ),
    );
  }
}
