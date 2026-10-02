import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/util/answer_format.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/topic.dart';
import '../../state/session_controller.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';
import '../learn/session_launcher.dart';
import 'exam_result_view.dart';
import 'exam_widgets.dart';

/// Punkte einer Prüfung je Katalogbereich und das Thema mit dem größten
/// Punktverlust.
class AreaBreakdown {
  const AreaBreakdown({required this.areas, required this.weakestTopicId});

  /// Bereichs-ID -> Summe, in Katalogreihenfolge, nur vorkommende Bereiche.
  final Map<String, ScoreSum> areas;

  /// Thema mit den meisten verlorenen Punkten (mind. ein halber Punkt),
  /// sonst `null`.
  final String? weakestTopicId;

  static AreaBreakdown of(Iterable<SessionItem> items) {
    final list = items.toList();
    final byArea = ScoreSum.group(
      list,
      (i) => Topics.byId(i.question.topicId).areaId,
    );
    final ordered = <String, ScoreSum>{
      for (final a in ExamAreas.all)
        if (byArea[a.id] != null) a.id: byArea[a.id]!,
    };
    final byTopic = ScoreSum.group(list, (i) => i.question.topicId);
    String? weakest;
    var maxLost = 0.0;
    for (final e in byTopic.entries) {
      if (e.value.lost >= 0.5 && e.value.lost > maxLost) {
        maxLost = e.value.lost;
        weakest = e.key;
      }
    }
    return AreaBreakdown(areas: ordered, weakestTopicId: weakest);
  }
}

/// Abschnitt „Deine Punkte je Bereich“ in der Auswertung der Prüfung.
class ExamAreaBreakdown extends ConsumerWidget {
  const ExamAreaBreakdown({super.key, required this.session});

  final SessionState session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = AreaBreakdown.of(session.items);
    if (data.areas.isEmpty) return const SizedBox.shrink();
    final weakId = data.weakestTopicId;
    final weak = weakId == null ? null : Topics.byId(weakId);
    final weakSum = weakId == null
        ? null
        : ScoreSum.group(
            session.items.where((i) => i.question.topicId == weakId),
            (i) => weakId,
          )[weakId];
    final ratio = session.totalScore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Deine Punkte je Bereich'),
        for (final e in data.areas.entries) ...[
          ScoreRow(
            icon: ExamAreas.byId(e.key).icon,
            overline: 'BEREICH ${ExamAreas.byId(e.key).number}',
            title: ExamAreas.byId(e.key).title,
            earned: e.value.earned,
            possible: e.value.possible,
            caption: '${(e.value.ratio * 100).round()} %',
          ),
          const SizedBox(height: Gap.s),
        ],
        if (weak != null && weakSum != null) ...[
          const SizedBox(height: Gap.s),
          AppCard(
            padding: const EdgeInsets.all(Gap.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hier hast du die meisten Punkte verloren:',
                  style: context.text.bodyMedium?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
                const SizedBox(height: Gap.xs),
                Text(weak.title, style: context.text.titleMedium),
                const SizedBox(height: Gap.xs),
                Text(
                  '${formatPoints(weakSum.lost)} von ${weakSum.possible} P. '
                  'liegen geblieben.',
                  style: context.text.bodySmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
                const SizedBox(height: Gap.m),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => SessionLauncher.practice(
                      context,
                      ref,
                      topicId: weak.id,
                      replace: true,
                    ),
                    child: const Text('Dieses Thema üben'),
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: Gap.m),
        MascotSays(
          mood: ratio >= 0.5 ? MascotMood.cheer : MascotMood.think,
          text: weak == null
              ? 'Kaum Punkte verschenkt. So kann die echte Prüfung kommen!'
              : ratio >= 0.5
              ? 'Stark gemacht! Ein paar Minuten zu ${weak.title} holen dir '
                    'die letzten Punkte.'
              : 'Kopf hoch, jetzt weißt du, wo du ansetzt. Fang mit '
                    '${weak.title} an, da holst du am schnellsten auf.',
        ),
      ],
    );
  }
}
