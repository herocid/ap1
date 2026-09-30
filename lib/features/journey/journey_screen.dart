import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/subtopic.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';

/// Die Learning Journey: der komplette AP1-Stoff als Lehrgang.
///
/// Bereiche und Themen stehen in Katalogreihenfolge, die Lektionen eines
/// Themas in Lernreihenfolge. Nichts ist gesperrt - wer Vorwissen hat, darf
/// springen. Die Journey schlägt aber immer die nächste offene Lektion vor.
class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = <Widget>[
      const _Header(),
      const SizedBox(height: Gap.l),
      const _ProgressHero(),
    ];

    for (final area in ExamAreas.all) {
      items
        ..add(const SizedBox(height: Gap.xxl))
        ..add(_AreaHeader(area: area));
      for (final topic in Topics.ofArea(area.id)) {
        items
          ..add(const SizedBox(height: Gap.m))
          ..add(_TopicPath(topic: topic));
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
          itemCount: items.length,
          // Volle Breite, sonst zentriert ReadableWidth kurze Zeilen wie die
          // Bereichsüberschriften.
          itemBuilder: (context, i) => ReadableWidth(
            child: SizedBox(width: double.infinity, child: items[i]),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Learning Journey', style: context.text.headlineSmall),
        const SizedBox(height: 2),
        Text(
          'Der komplette AP1-Stoff in Lektionen, die aufeinander aufbauen.',
          style: context.text.bodyMedium?.copyWith(color: context.c.textMuted),
        ),
      ],
    );
  }
}

class _ProgressHero extends ConsumerWidget {
  const _ProgressHero();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider);
    final done = ref.watch(journeyProvider);
    final next = ref.watch(nextLessonProvider);
    final doneCount = lessons.where((l) => done.contains(l.id)).length;
    final share = lessons.isEmpty ? 0.0 : doneCount / lessons.length;

    return AppCard(
      padding: const EdgeInsets.all(Gap.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text('Dein Fortschritt', style: context.text.titleMedium),
              ),
              const SizedBox(width: Gap.m),
              Flexible(
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: '$doneCount',
                      style: AppType.numeric(size: 22, weight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: ' / ${lessons.length} Lektionen',
                      style:
                          AppType.numeric(size: 13, color: context.c.textMuted),
                    ),
                  ]),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.pill),
            child: LinearProgressIndicator(
              value: share,
              minHeight: 6,
              color: context.c.flame,
            ),
          ),
          if (next != null) ...[
            const SizedBox(height: Gap.xl),
            Text(
              'ALS NÄCHSTES',
              style: context.text.labelSmall?.copyWith(
                color: context.c.textMuted,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: Gap.xs),
            Text(next.title, style: context.text.titleLarge),
            const SizedBox(height: 2),
            Text(
              Topics.byId(next.topicId).title,
              style: context.text.bodyMedium
                  ?.copyWith(color: context.c.textMuted),
            ),
            const SizedBox(height: Gap.l),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => context.push('/lektion/${next.id}'),
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text(doneCount == 0 ? 'Journey starten' : 'Fortsetzen'),
              ),
            ),
          ] else if (lessons.isNotEmpty) ...[
            const SizedBox(height: Gap.l),
            NoteBox(
              tone: NoteTone.success,
              child: const Text(
                'Alle Lektionen abgeschlossen. Wiederhole gezielt über '
                'Karteikarten und Prüfungssimulation.',
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AreaHeader extends StatelessWidget {
  const _AreaHeader({required this.area});
  final ExamArea area;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${area.number}  ·  ${area.title}'.toUpperCase(),
      style: context.text.labelSmall?.copyWith(
        color: context.c.textMuted,
        letterSpacing: 1.2,
      ),
    );
  }
}

/// Ein Thema als Lernpfad: jede Lektion eine Station, verbunden durch eine
/// Linie. Erledigte Stationen tragen einen Haken, die nächste offene ist
/// hervorgehoben.
class _TopicPath extends ConsumerWidget {
  const _TopicPath({required this.topic});
  final Topic topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = Subtopics.ofTopic(topic.id);
    final steps = ref.watch(lessonStepsProvider);
    final done = ref.watch(journeyProvider);
    final next = ref.watch(nextLessonProvider);
    final doneHere = lessons.where((l) => done.contains(l.id)).length;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.c.surfaceAlt,
                  borderRadius: BorderRadius.circular(Radii.s),
                ),
                child: Icon(topic.icon, size: 19, color: context.scheme.primary),
              ),
              const SizedBox(width: Gap.m),
              Expanded(
                child: Text(topic.title, style: context.text.titleMedium),
              ),
              const SizedBox(width: Gap.s),
              Text(
                '$doneHere / ${lessons.length}',
                style: AppType.numeric(size: 13, color: context.c.textMuted),
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          for (var i = 0; i < lessons.length; i++)
            _Station(
              lesson: lessons[i],
              number: i + 1,
              isLast: i == lessons.length - 1,
              isDone: done.contains(lessons[i].id),
              isNext: next?.id == lessons[i].id,
              hasContent: steps.containsKey(lessons[i].id),
            ),
        ],
      ),
    );
  }
}

class _Station extends StatelessWidget {
  const _Station({
    required this.lesson,
    required this.number,
    required this.isLast,
    required this.isDone,
    required this.isNext,
    required this.hasContent,
  });

  final Subtopic lesson;
  final int number;
  final bool isLast;
  final bool isDone;
  final bool isNext;
  final bool hasContent;

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    final muted = context.c.textMuted;

    final marker = Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? primary : context.scheme.surface,
        border: Border.all(
          color: isDone || isNext ? primary : context.c.border,
          width: isNext ? 2 : 1.5,
        ),
      ),
      child: isDone
          ? Icon(Icons.check_rounded, size: 16, color: context.scheme.onPrimary)
          : Text(
              '$number',
              style: AppType.numeric(
                size: 12,
                color: isNext ? primary : muted,
              ),
            ),
    );

    return InkWell(
      onTap: hasContent ? () => context.push('/lektion/${lesson.id}') : null,
      borderRadius: BorderRadius.circular(Radii.m),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 28,
              child: Column(
                children: [
                  const SizedBox(height: Gap.s),
                  marker,
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 1.5,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        color: isDone ? primary : context.c.border,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: Gap.m),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: Gap.s, bottom: Gap.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lesson.title,
                            style: context.text.bodyLarge?.copyWith(
                              fontWeight:
                                  isNext ? FontWeight.w600 : FontWeight.w500,
                              color: hasContent ? null : muted,
                              height: 1.35,
                            ),
                          ),
                        ),
                        if (!hasContent)
                          Padding(
                            padding: const EdgeInsets.only(left: Gap.s),
                            child: Text(
                              'Folgt',
                              style: context.text.labelSmall
                                  ?.copyWith(color: muted),
                            ),
                          )
                        else
                          Icon(Icons.chevron_right, size: 20, color: muted),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lesson.goal,
                      style: context.text.labelSmall?.copyWith(color: muted),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
