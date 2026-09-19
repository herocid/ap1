import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../learn/session_launcher.dart';
import '../learn/theory_sheet.dart';
import 'dashboard_screen.dart';

/// Alle Themen mit Fortschritt - und der Lernplan, der sagt, in welcher
/// Reihenfolge sie sinnvollerweise drankommen.
class TopicsScreen extends ConsumerWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(studyPlanProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Themen & Lernplan')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NoteBox(
                  tone: plan.feasible ? NoteTone.success : NoteTone.warn,
                  title: plan.feasible
                      ? 'Dein Plan geht auf'
                      : 'Das Pensum ist knapp',
                  child: Text(plan.note),
                ),
                const SizedBox(height: Gap.xl),
                SectionHeader(
                  'Empfohlene Reihenfolge',
                  subtitle:
                      'Sortiert nach Punkteanteil in der AP1 mal deiner '
                      'aktuellen Wissensluecke.',
                ),
                for (var i = 0; i < plan.blocks.length; i++) ...[
                  _PlanRow(
                    position: i + 1,
                    topic: plan.blocks[i].topic,
                    reason: plan.blocks[i].reason,
                    fromDay: plan.blocks[i].fromDay,
                    toDay: plan.blocks[i].toDay,
                    onPractice: () => SessionLauncher.practice(
                      context,
                      ref,
                      topicId: plan.blocks[i].topic.id,
                    ),
                    onTheory: () => showTheorySheet(
                      context,
                      ref,
                      topicId: plan.blocks[i].topic.id,
                    ),
                  ),
                  const SizedBox(height: Gap.s),
                ],
                const SizedBox(height: Gap.xl),
                const SectionHeader('Alle Themen'),
                for (final t in Topics.all) ...[
                  TopicRowCard(
                    topicId: t.id,
                    onTap: () =>
                        SessionLauncher.practice(context, ref, topicId: t.id),
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

class _PlanRow extends StatelessWidget {
  const _PlanRow({
    required this.position,
    required this.topic,
    required this.reason,
    required this.fromDay,
    required this.toDay,
    required this.onPractice,
    required this.onTheory,
  });

  final int position;
  final Topic topic;
  final String reason;
  final int fromDay;
  final int toDay;
  final VoidCallback onPractice;
  final VoidCallback onTheory;

  String get _window {
    if (fromDay == toDay) {
      return fromDay == 0 ? 'heute' : 'in $fromDay Tagen';
    }
    return 'Tag ${fromDay + 1}–${toDay + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: position <= 3
                  ? context.scheme.primary
                  : context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.pill),
            ),
            child: Text(
              '$position',
              style: context.text.labelSmall?.copyWith(
                color: position <= 3
                    ? context.scheme.onPrimary
                    : context.c.textMuted,
              ),
            ),
          ),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(topic.title, style: context.text.titleMedium),
                const SizedBox(height: 2),
                Text(
                  reason,
                  style: context.text.bodyMedium
                      ?.copyWith(color: context.c.textMuted),
                ),
                const SizedBox(height: Gap.s),
                Row(
                  children: [
                    MetaChip(label: _window, icon: Icons.event_outlined),
                    const Spacer(),
                    TextButton(
                      onPressed: onTheory,
                      child: const Text('Theorie'),
                    ),
                    const SizedBox(width: Gap.xs),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 38),
                        padding:
                            const EdgeInsets.symmetric(horizontal: Gap.l),
                      ),
                      onPressed: onPractice,
                      child: const Text('Ueben'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
