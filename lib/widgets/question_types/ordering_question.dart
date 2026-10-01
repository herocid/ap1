import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../hyphenation.dart';
import 'question_material.dart';
import 'shuffle.dart';

/// Reihenfolge-Aufgaben (Phasen, Scrum-Events, Abläufe).
///
/// Bedienung bewusst doppelt: gedrückt halten und ziehen für Touch,
/// Pfeiltasten für Maus und Screenreader. Drag-and-drop allein ist auf dem
/// Desktop fummelig und mit Tastatur gar nicht bedienbar. Einen eigenen
/// Ziehgriff gibt es nicht - die ganze Zeile lässt sich ziehen, so bleibt
/// dem Text auf schmalen Displays mehr Breite.
class OrderingQuestionView extends StatefulWidget {
  const OrderingQuestionView({
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

  @override
  State<OrderingQuestionView> createState() => _OrderingQuestionViewState();
}

class _OrderingQuestionViewState extends State<OrderingQuestionView> {
  late List<int> _order;

  @override
  void initState() {
    super.initState();
    _order = _initialOrder();
    if (widget.answer == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onChanged(List<int>.from(_order));
      });
    }
  }

  @override
  void didUpdateWidget(covariant OrderingQuestionView old) {
    super.didUpdateWidget(old);
    if (old.question.id != widget.question.id) {
      _order = _initialOrder();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onChanged(List<int>.from(_order));
      });
    }
  }

  List<int> _initialOrder() {
    final existing = widget.answer as List<int>?;
    if (existing != null &&
        existing.length == widget.question.orderedItems.length) {
      return List<int>.from(existing);
    }
    // Eine zufällig korrekte Startreihenfolge wäre ein Geschenk - deshalb
    // nie die Lösung selbst.
    return displayOrder(
      widget.question.orderedItems.length,
      widget.shuffleSeed,
      salt: 'order',
      avoidIdentity: true,
    );
  }

  void _apply(List<int> next) {
    setState(() => _order = next);
    widget.onChanged(List<int>.from(next));
  }

  void _move(int from, int to) {
    if (widget.revealed) return;
    if (to < 0 || to >= _order.length) return;
    final next = [..._order];
    final item = next.removeAt(from);
    next.insert(to, item);
    _apply(next);
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.question.orderedItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HintLine(
          widget.revealed
              ? 'Auswertung: Grün steht am richtigen Platz.'
              : [
                  ?widget.question.orderingHint,
                  'Verschiebe mit den Pfeilen oder halte eine Zeile gedrückt '
                      'und ziehe sie.',
                ].join(' '),
          icon: widget.revealed ? Icons.fact_check_outlined : Icons.swap_vert,
        ),
        const SizedBox(height: Gap.m),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          itemCount: _order.length,
          onReorder: (oldIndex, newIndex) {
            if (widget.revealed) return;
            if (newIndex > oldIndex) newIndex -= 1;
            _move(oldIndex, newIndex);
          },
          itemBuilder: (context, position) {
            final originalIndex = _order[position];
            final row = _OrderRow(
              position: position,
              text: items[originalIndex],
              revealed: widget.revealed,
              correctHere: originalIndex == position,
              correctPosition: originalIndex + 1,
              onUp: position == 0 ? null : () => _move(position, position - 1),
              onDown: position == _order.length - 1
                  ? null
                  : () => _move(position, position + 1),
            );
            return Padding(
              key: ValueKey('ord-${widget.question.id}-$originalIndex'),
              padding: const EdgeInsets.only(bottom: Gap.s),
              child: widget.revealed
                  ? row
                  : ReorderableDelayedDragStartListener(
                      index: position,
                      child: row,
                    ),
            );
          },
        ),
      ],
    );
  }
}

class _OrderRow extends StatelessWidget {
  const _OrderRow({
    required this.position,
    required this.text,
    required this.revealed,
    required this.correctHere,
    required this.correctPosition,
    required this.onUp,
    required this.onDown,
  });

  final int position;
  final String text;
  final bool revealed;
  final bool correctHere;
  final int correctPosition;
  final VoidCallback? onUp;
  final VoidCallback? onDown;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final bg = !revealed
        ? context.scheme.surface
        : correctHere
        ? c.successBg
        : c.dangerBg;
    final border = !revealed
        ? c.border
        : correctHere
        ? c.success
        : c.danger;

    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: EdgeInsets.fromLTRB(
        Gap.m,
        Gap.s,
        revealed ? Gap.m : Gap.xs,
        Gap.s,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: border, width: revealed ? 1.6 : 1),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.pill),
            ),
            child: Text(
              '${position + 1}',
              textScaler: TextScaler.noScaling,
              style: AppType.numeric(size: 13),
            ),
          ),
          const SizedBox(width: Gap.m),
          Expanded(child: HyphenText(text, style: context.text.bodyMedium)),
          if (revealed) ...[
            const SizedBox(width: Gap.s),
            if (correctHere)
              Icon(Icons.check_circle, size: 20, color: c.success)
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.north_east, size: 15, color: c.danger),
                  const SizedBox(width: 2),
                  Text(
                    'Platz $correctPosition',
                    style: context.text.labelSmall?.copyWith(color: c.danger),
                  ),
                ],
              ),
          ] else ...[
            _ArrowButton(
              icon: Icons.keyboard_arrow_up,
              tooltip: 'Nach oben',
              onPressed: onUp,
            ),
            _ArrowButton(
              icon: Icons.keyboard_arrow_down,
              tooltip: 'Nach unten',
              onPressed: onDown,
            ),
          ],
        ],
      ),
    );
  }
}

/// Pfeil mit 40 px Breite und 48 px Höhe: schmal genug, dass dem Text Platz
/// bleibt, hoch genug zum Treffen.
class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      tooltip: tooltip,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 40, height: 48),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
