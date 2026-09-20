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

/// Die sieben Bereiche des Pruefungskatalogs.
///
/// Zweistufige Navigation: erst der Bereich, dann das Thema. Eine flache
/// Liste aus 35 Themen waere auf dem Handy nicht mehr ueberschaubar - und
/// die Katalognummern helfen beim Abgleich mit IHK-Unterlagen.
class AreasScreen extends ConsumerWidget {
  const AreasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(studyPlanProvider);
    final areaReadiness = ref.watch(areaReadinessProvider);
    final poolSize = ref.watch(poolSizeProvider);
    final cardCount = ref.watch(cardCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pruefungskatalog'),
        actions: [
          IconButton(
            tooltip: 'Was 2025 gestrichen wurde',
            onPressed: () => context.push('/katalog-aenderungen'),
            icon: const Icon(Icons.rule_outlined),
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
                NoteBox(
                  tone: plan.feasible ? NoteTone.success : NoteTone.warn,
                  title: plan.feasible
                      ? 'Dein Plan geht auf'
                      : 'Das Pensum ist knapp',
                  child: Text(plan.note),
                ),
                const SizedBox(height: Gap.xl),
                const SectionHeader(
                  'Die sieben Bereiche',
                  subtitle: 'Gliederung und Nummern folgen dem amtlichen '
                      'Katalog ab 2025. Der Prozentwert ist dein Stand im '
                      'jeweiligen Bereich.',
                ),
                for (final area in ExamAreas.all) ...[
                  _AreaCard(
                    area: area,
                    readiness: areaReadiness[area.id] ?? 0,
                    questionCount: Topics.ofArea(area.id)
                        .fold<int>(0, (s, t) => s + (poolSize[t.id] ?? 0)),
                    cardCount: Topics.ofArea(area.id)
                        .fold<int>(0, (s, t) => s + (cardCount[t.id] ?? 0)),
                    topicCount: Topics.ofArea(area.id).length,
                    onTap: () => context.push('/bereich/${area.id}'),
                  ),
                  const SizedBox(height: Gap.s),
                ],
                const SizedBox(height: Gap.l),
                Text(
                  'Die Bereichsnummern stammen aus dem Pruefungskatalog. Die '
                  'Aufteilung in Themen darunter ist eine fachliche '
                  'Rekonstruktion - die amtlichen Unterkapitel-Titel sind '
                  'nicht frei veroeffentlicht.',
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AreaCard extends StatelessWidget {
  const _AreaCard({
    required this.area,
    required this.readiness,
    required this.questionCount,
    required this.cardCount,
    required this.topicCount,
    required this.onTap,
  });

  final ExamArea area;
  final int readiness;
  final int questionCount;
  final int cardCount;
  final int topicCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.m),
            ),
            child: Icon(area.icon, size: 22, color: context.scheme.primary),
          ),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      area.number,
                      style: AppType.numeric(
                        size: 13,
                        color: context.c.textMuted,
                      ),
                    ),
                    const SizedBox(width: Gap.s),
                    Expanded(
                      child: Text(area.title, style: context.text.titleMedium),
                    ),
                    Text('$readiness %', style: AppType.numeric(size: 14)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  area.blurb,
                  style: context.text.bodyMedium
                      ?.copyWith(color: context.c.textMuted),
                ),
                const SizedBox(height: Gap.s),
                TopicBar(confidence: readiness / 100, coverage: 0),
                const SizedBox(height: Gap.s),
                Wrap(
                  spacing: Gap.s,
                  runSpacing: Gap.xs,
                  children: [
                    MetaChip(
                      label: '$topicCount Themen',
                      icon: Icons.list_alt,
                    ),
                    MetaChip(
                      label: '$questionCount Aufgaben',
                      icon: Icons.quiz_outlined,
                      color: questionCount == 0 ? null : context.c.success,
                    ),
                    MetaChip(
                      label: '$cardCount Karten',
                      icon: Icons.style_outlined,
                      color: cardCount == 0 ? null : context.c.success,
                    ),
                    MetaChip(
                      label: '${(area.weight * 100).round()} % der Punkte',
                      icon: Icons.pie_chart_outline,
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
