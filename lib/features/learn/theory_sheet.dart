import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/theory.dart';
import '../../data/models/topic.dart';
import '../../data/seed/seed_theory.dart';
import '../../state/providers.dart';

/// Theorie-Snack als Bottom Sheet.
///
/// Warum ein Sheet und kein eigener Screen: Der Snack ist eine Fussnote zur
/// Aufgabe, kein Kapitel. Man soll ihn ueberfliegen und wieder wegwischen
/// koennen, ohne den Lernfluss zu verlassen.
Future<void> showTheorySheet(
  BuildContext context,
  WidgetRef ref, {
  required String topicId,
}) async {
  final snacks = seedTheory.where((s) => s.topicId == topicId).toList();
  if (snacks.isEmpty) return;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: 720),
    builder: (ctx) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.45,
      builder: (ctx, scrollController) => _TheoryBody(
        snacks: snacks,
        topicId: topicId,
        controller: scrollController,
      ),
    ),
  );

  for (final s in snacks) {
    ref.read(seenTheoryProvider.notifier).markSeen(s.id);
  }
}

class _TheoryBody extends StatelessWidget {
  const _TheoryBody({
    required this.snacks,
    required this.topicId,
    required this.controller,
  });

  final List<TheorySnack> snacks;
  final String topicId;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final topic = Topics.byId(topicId);
    final totalSeconds = snacks.fold<int>(0, (s, e) => s + e.readSeconds);

    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.xxl),
      children: [
        Row(
          children: [
            Icon(topic.icon, size: 20, color: context.scheme.primary),
            const SizedBox(width: Gap.s),
            Expanded(
              child: Text(topic.title, style: context.text.titleLarge),
            ),
          ],
        ),
        const SizedBox(height: Gap.xs),
        Text(
          'Etwa $totalSeconds Sekunden Lesezeit',
          style: context.text.labelSmall?.copyWith(color: context.c.textMuted),
        ),
        const SizedBox(height: Gap.xl),
        for (final s in snacks) ...[
          Text(s.title, style: context.text.titleMedium),
          const SizedBox(height: Gap.s),
          Text(
            s.lead,
            style:
                context.text.bodyMedium?.copyWith(color: context.c.textMuted),
          ),
          const SizedBox(height: Gap.l),
          for (final p in s.points)
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.m),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.scheme.primary,
                    ),
                  ),
                  const SizedBox(width: Gap.m),
                  Expanded(
                    child: Text(p, style: context.text.bodyMedium),
                  ),
                ],
              ),
            ),
          const SizedBox(height: Gap.s),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Gap.l),
            decoration: BoxDecoration(
              color: context.c.infoBg,
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(color: context.c.info.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.push_pin_outlined, size: 18, color: context.c.info),
                const SizedBox(width: Gap.m),
                Expanded(
                  child: Text(
                    s.merksatz,
                    style: context.text.bodyMedium
                        ?.copyWith(color: context.c.info),
                  ),
                ),
              ],
            ),
          ),
          if (s != snacks.last) ...[
            const SizedBox(height: Gap.xl),
            Divider(color: context.c.border),
            const SizedBox(height: Gap.xl),
          ],
        ],
        const SizedBox(height: Gap.xl),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Verstanden, weiter'),
        ),
      ],
    );
  }
}
