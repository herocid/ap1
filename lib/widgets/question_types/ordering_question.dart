import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';

/// Reihenfolge-Aufgaben (Phasen, Scrum-Events, Abläufe).
///
/// Bedienung bewusst doppelt: ziehen am Griff für Touch, Pfeiltasten für
/// Maus und Screenreader. Drag-and-drop allein ist auf dem Desktop fummelig
/// und mit Tastatur gar nicht bedienbar.
class OrderingQuestionView extends StatefulWidget {
  const OrderingQuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;

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
    if (existing != null && existing.length == widget.question.orderedItems.length) {
      return List<int>.from(existing);
    }
    final n = widget.question.orderedItems.length;
    final idx = List<int>.generate(n, (i) => i);
    // Fester Seed pro Aufgabe: dieselbe Aufgabe startet immer gleich, aber
    // verschiedene Aufgaben unterschiedlich.
    final rnd = math.Random(widget.question.id.hashCode);
    idx.shuffle(rnd);
    // Eine zufällig korrekte Startreihenfolge wäre ein Geschenk - einmal
    // rotieren, falls das passiert.
    final isIdentity = List.generate(n, (i) => idx[i] == i).every((e) => e);
    if (isIdentity && n > 1) {
      final first = idx.removeAt(0);
      idx.add(first);
    }
    return idx;
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
        if (widget.question.orderingHint != null)
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.m),
            child: Text(
              widget.question.orderingHint!,
              style:
                  context.text.labelSmall?.copyWith(color: context.c.textMuted),
            ),
          ),
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
            return Padding(
              key: ValueKey('ord-${widget.question.id}-$originalIndex'),
              padding: const EdgeInsets.only(bottom: Gap.s),
              child: _OrderRow(
                position: position,
                text: items[originalIndex],
                revealed: widget.revealed,
                correctHere: originalIndex == position,
                correctPosition: originalIndex + 1,
                onUp: position == 0 ? null : () => _move(position, position - 1),
                onDown: position == _order.length - 1
                    ? null
                    : () => _move(position, position + 1),
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
      padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: Gap.m),
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
            child: Text('${position + 1}', style: AppType.numeric(size: 13)),
          ),
          const SizedBox(width: Gap.m),
          Expanded(child: Text(text, style: context.text.bodyMedium)),
          if (revealed) ...[
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
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onUp,
              icon: const Icon(Icons.keyboard_arrow_up),
              tooltip: 'Nach oben',
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onDown,
              icon: const Icon(Icons.keyboard_arrow_down),
              tooltip: 'Nach unten',
            ),
            ReorderableDragStartListener(
              index: position,
              child: Padding(
                padding: const EdgeInsets.only(left: Gap.xs),
                child: Icon(Icons.drag_indicator, color: c.textMuted),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
