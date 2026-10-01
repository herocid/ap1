import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/question.dart';
import '../hyphenation.dart';
import 'question_material.dart';
import 'shuffle.dart';

/// Zuordnungsaufgaben (Lastenheft/Pflichtenheft, Risikostrategien, ...).
///
/// Kein Drag-and-drop zwischen Spalten: Das ist auf einem 5-Zoll-Display
/// unbedienbar, sobald die Texte länger als drei Wörter sind. Stattdessen
/// steht unter jeder Aussage eine Reihe antippbarer Zielkategorien - ein Tipp
/// pro Zuordnung, funktioniert auf Touch und mit der Maus identisch.
///
/// Die Aussagen stehen in gemischter Reihenfolge ([shuffleSeed]) - sonst
/// verrät die Reihenfolge der Autoren (erst alles zu Kategorie 1, dann alles
/// zu Kategorie 2) die Lösung. Die Kategorien stehen unter jeder Aussage in
/// derselben Reihenfolge und sehen vor dem Prüfen alle gleich aus.
class MatchingQuestionView extends StatelessWidget {
  const MatchingQuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
    this.shuffleSeed = 0,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;
  final int shuffleSeed;

  Map<int, int> get _map => (answer as Map<int, int>?) ?? const <int, int>{};

  void _assign(int itemIndex, int bucketIndex) {
    if (revealed) return;
    final next = {..._map};
    if (next[itemIndex] == bucketIndex) {
      next.remove(itemIndex);
    } else {
      next[itemIndex] = bucketIndex;
    }
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final assigned = _map.length;
    final total = question.matchItems.length;
    final order = displayOrder(total, shuffleSeed, salt: 'items');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HintLine(
          revealed
              ? 'Auswertung: pro richtiger Zuordnung gibt es Teilpunkte.'
              : 'Tippe unter jeder Aussage die passende Kategorie an. '
                    '($assigned von $total zugeordnet)',
          icon: revealed ? Icons.fact_check_outlined : Icons.touch_app_outlined,
        ),
        const SizedBox(height: Gap.m),
        for (var pos = 0; pos < order.length; pos++) ...[
          _MatchRow(
            key: ValueKey('match-${order[pos]}'),
            item: question.matchItems[order[pos]],
            buckets: question.buckets,
            selected: _map[order[pos]],
            revealed: revealed,
            onSelect: (b) => _assign(order[pos], b),
          ),
          if (pos < order.length - 1) const SizedBox(height: Gap.m),
        ],
      ],
    );
  }
}

class _MatchRow extends StatelessWidget {
  const _MatchRow({
    super.key,
    required this.item,
    required this.buckets,
    required this.selected,
    required this.revealed,
    required this.onSelect,
  });

  final MatchItem item;
  final List<String> buckets;
  final int? selected;
  final bool revealed;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final isCorrect = selected == item.bucket;

    final border = !revealed
        ? c.border
        : isCorrect
        ? c.success
        : c.danger;
    final bg = !revealed
        ? context.scheme.surface
        : isCorrect
        ? c.successBg
        : c.dangerBg;

    return Container(
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: border, width: revealed ? 1.6 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: HyphenText(item.text, style: context.text.bodyLarge),
              ),
              if (revealed) ...[
                const SizedBox(width: Gap.s),
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  size: 20,
                  color: isCorrect ? c.success : c.danger,
                ),
              ],
            ],
          ),
          const SizedBox(height: Gap.m),
          Wrap(
            spacing: Gap.s,
            runSpacing: Gap.s,
            children: [
              for (var b = 0; b < buckets.length; b++)
                _BucketChip(
                  label: buckets[b],
                  selected: selected == b,
                  isTruth: revealed && b == item.bucket,
                  wrongPick: revealed && selected == b && b != item.bucket,
                  onTap: () => onSelect(b),
                  enabled: !revealed,
                ),
            ],
          ),
          if (revealed && item.rationale.isNotEmpty) ...[
            const SizedBox(height: Gap.m),
            HyphenText(
              item.rationale,
              style: context.text.bodyMedium?.copyWith(
                color: isCorrect ? c.success : c.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BucketChip extends StatelessWidget {
  const _BucketChip({
    required this.label,
    required this.selected,
    required this.isTruth,
    required this.wrongPick,
    required this.onTap,
    required this.enabled,
  });

  final String label;
  final bool selected;
  final bool isTruth;
  final bool wrongPick;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final c = context.c;

    Color fg = c.textMuted;
    Color bg = c.surfaceAlt;
    Color border = c.border;

    if (isTruth) {
      fg = c.success;
      bg = c.successBg;
      border = c.success;
    } else if (wrongPick) {
      fg = c.danger;
      bg = c.dangerBg;
      border = c.danger;
    } else if (selected) {
      fg = context.scheme.onPrimary;
      bg = context.scheme.primary;
      border = context.scheme.primary;
    }

    return Semantics(
      button: enabled,
      selected: selected,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.xl),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(Radii.xl),
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: const EdgeInsets.symmetric(
              horizontal: Gap.l,
              vertical: Gap.s,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.xl),
              border: Border.all(color: border, width: 1.4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isTruth) ...[
                  Icon(Icons.check, size: 15, color: fg),
                  const SizedBox(width: 4),
                ] else if (wrongPick) ...[
                  Icon(Icons.close, size: 15, color: fg),
                  const SizedBox(width: 4),
                ],
                // Lange Kategorien brechen um, statt die Zeile zu sprengen.
                Flexible(
                  child: HyphenText(
                    label,
                    style: context.text.labelLarge?.copyWith(
                      fontSize: 13.5,
                      color: fg,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
