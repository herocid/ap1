import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import 'card_launch.dart';
import '../../widgets/bit_tips.dart';

/// Themen für eine Karteikarten-Runde auswählen.
///
/// Ganze Bereiche oder einzelne Themen ankreuzen, dann entweder eine kurze
/// Runde (Unsicheres bevorzugt) oder einen gespeicherten Durchlauf über die
/// Auswahl starten.
class CardPickerScreen extends ConsumerStatefulWidget {
  const CardPickerScreen({super.key});

  @override
  ConsumerState<CardPickerScreen> createState() => _CardPickerScreenState();
}

class _CardPickerScreenState extends ConsumerState<CardPickerScreen> {
  final Set<String> _topics = {};
  int _count = 20;

  static const _counts = [10, 20, 40, 0];

  String _title() {
    if (_topics.length == 1) return Topics.byId(_topics.first).title;
    for (final a in ExamAreas.all) {
      final ids = Topics.ofArea(a.id).map((t) => t.id).toSet();
      if (ids.length == _topics.length && ids.containsAll(_topics)) {
        return a.title;
      }
    }
    return 'Auswahl aus ${_topics.length} Themen';
  }

  @override
  Widget build(BuildContext context) {
    final counts = ref.watch(cardCountProvider);
    final cards = ref.watch(flashcardsProvider);
    final deck = ref.watch(deckProvider);
    final selected = _topics.fold<int>(0, (s, t) => s + (counts[t] ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Themen auswählen'),
        actions: [
          if (_topics.isNotEmpty)
            TextButton(
              onPressed: () => setState(_topics.clear),
              child: const Text('Leeren'),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BitTip(BitSpot.picker),
                const SizedBox(height: Gap.l),
                for (final area in ExamAreas.all) ...[
                  _AreaBlock(
                    area: area,
                    selected: _topics,
                    counts: counts,
                    mastery: (topicId) => deck.mastery(
                      cards.where((c) => c.topicId == topicId).toList(),
                    ),
                    onChanged: (ids, on) => setState(() {
                      on ? _topics.addAll(ids) : _topics.removeAll(ids);
                    }),
                  ),
                  const SizedBox(height: Gap.s),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.scheme.surface,
          border: Border(top: BorderSide(color: context.c.border)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.l, Gap.l),
            child: ReadableWidth(
              shrinkHeight: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _topics.isEmpty
                        ? 'Noch nichts ausgewählt'
                        : '$selected Karten in ${_topics.length} '
                              '${_topics.length == 1 ? 'Thema' : 'Themen'}',
                    style: context.text.titleSmall,
                  ),
                  const SizedBox(height: Gap.s),
                  Wrap(
                    spacing: Gap.s,
                    runSpacing: Gap.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Runde:',
                        style: context.text.labelMedium?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                      for (final n in _counts)
                        ChoiceChip(
                          label: Text(n == 0 ? 'alle' : '$n'),
                          selected: _count == n,
                          onSelected: (_) => setState(() => _count = n),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                  const SizedBox(height: Gap.m),
                  ButtonPair(
                    labels: const ['Als Durchlauf', 'Runde starten'],
                    start: OutlinedButton(
                      onPressed: _topics.isEmpty
                          ? null
                          : () => CardLaunch.startRun(
                              context,
                              ref,
                              title: _title(),
                              topicIds: {..._topics},
                            ),
                      child: const Text('Als Durchlauf', maxLines: 1),
                    ),
                    end: FilledButton(
                      onPressed: _topics.isEmpty
                          ? null
                          : () => CardLaunch.practice(
                              context,
                              ref,
                              topicIds: {..._topics},
                              title: _title(),
                              count: _count,
                            ),
                      child: const Text('Runde starten', maxLines: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AreaBlock extends StatelessWidget {
  const _AreaBlock({
    required this.area,
    required this.selected,
    required this.counts,
    required this.mastery,
    required this.onChanged,
  });

  final ExamArea area;
  final Set<String> selected;
  final Map<String, int> counts;
  final double Function(String topicId) mastery;
  final void Function(Set<String> ids, bool on) onChanged;

  @override
  Widget build(BuildContext context) {
    final topics = Topics.ofArea(
      area.id,
    ).where((t) => (counts[t.id] ?? 0) > 0).toList();
    if (topics.isEmpty) return const SizedBox.shrink();
    final ids = topics.map((t) => t.id).toSet();
    final n = ids.where(selected.contains).length;
    final all = n == ids.length;
    final total = ids.fold<int>(0, (s, t) => s + (counts[t] ?? 0));

    return AppCard(
      padding: EdgeInsets.zero,
      child: Theme(
        // Ohne das zeichnet ExpansionTile eigene Trennlinien in die Karte.
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.fromLTRB(Gap.s, Gap.xs, Gap.m, Gap.xs),
          childrenPadding: const EdgeInsets.only(bottom: Gap.s),
          leading: Checkbox(
            tristate: true,
            value: all ? true : (n == 0 ? false : null),
            onChanged: (_) => onChanged(ids, !all),
          ),
          title: Text(area.title, style: context.text.titleSmall),
          subtitle: Text(
            'Bereich ${area.number} · $total Karten'
            '${n > 0 && !all ? ' · $n gewählt' : ''}',
            style: context.text.labelSmall?.copyWith(
              color: context.c.textMuted,
            ),
          ),
          children: [
            for (final t in topics)
              CheckboxListTile(
                value: selected.contains(t.id),
                onChanged: (v) => onChanged({t.id}, v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.symmetric(horizontal: Gap.s),
                dense: true,
                title: Text(t.title, style: context.text.bodyMedium),
                subtitle: Text(
                  '${counts[t.id]} Karten · '
                  '${(mastery(t.id) * 100).round()} % sicher',
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
