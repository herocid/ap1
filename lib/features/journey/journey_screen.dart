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
import '../../widgets/feedback_fx.dart';
import '../../widgets/hyphenation.dart';
import '../../widgets/bit_tips.dart';

/// Die Learning Journey: der komplette AP1-Stoff als Lehrgang - hier wird
/// nur gelernt, abgefragt wird in Quiz und Karteikarten.
///
/// Bereiche und Themen stehen in Katalogreihenfolge, die Lektionen eines
/// Themas in Lernreihenfolge. Nichts ist gesperrt - wer Vorwissen hat, darf
/// springen. Die Themen sind zugeklappt, bis auf das mit der nächsten
/// offenen Lektion; so bleibt die Liste trotz 134 Lektionen übersichtlich.
class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final next = ref.watch(nextLessonProvider);
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
          ..add(const SizedBox(height: Gap.s))
          ..add(
            _TopicSection(
              key: PageStorageKey('journey-topic-${topic.id}'),
              topic: topic,
              initiallyOpen: next?.topicId == topic.id,
            ),
          );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          key: const PageStorageKey('journey-list'),
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
        const SizedBox(height: Gap.l),
        const BitTip(BitSpot.journey),
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
    final steps = ref.watch(lessonStepsProvider);
    final doneCount = lessons.where((l) => done.contains(l.id)).length;
    final share = lessons.isEmpty ? 0.0 : doneCount / lessons.length;
    final c = context.c;

    return AppCard(
      padding: const EdgeInsets.all(Gap.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: Gap.m,
            runSpacing: Gap.xs,
            children: [
              Text('Dein Fortschritt', style: context.text.titleMedium),
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: AnimatedCount(
                        doneCount,
                        style: AppType.numeric(
                          size: 22,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' / ${lessons.length} Lektionen',
                      style: AppType.numeric(size: 13, color: c.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          AnimatedBar(value: share, minHeight: 6, color: c.flame),
          if (next != null) ...[
            const SizedBox(height: Gap.xl),
            Text(
              doneCount == 0 ? 'HIER ANFANGEN' : 'ALS NÄCHSTES',
              style: context.text.labelSmall?.copyWith(
                color: c.textMuted,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: Gap.xs),
            HyphenText(next.title, style: context.text.titleLarge),
            const SizedBox(height: 2),
            HyphenText(
              '${Topics.byId(next.topicId).title} · '
              '${steps[next.id]?.length ?? 0} Lernschritte',
              style: context.text.bodyMedium?.copyWith(color: c.textMuted),
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
            const NoteBox(
              tone: NoteTone.success,
              child: Text(
                'Alle Lektionen abgeschlossen. Jede Lektion lässt sich '
                'jederzeit noch einmal durchgehen.',
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AreaHeader extends ConsumerWidget {
  const _AreaHeader({required this.area});
  final ExamArea area;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final done = ref.watch(journeyProvider);
    final steps = ref.watch(lessonStepsProvider);
    final lessons = [
      for (final t in Topics.ofArea(area.id))
        for (final l in Subtopics.ofTopic(t.id))
          if (steps.containsKey(l.id)) l,
    ];
    final doneHere = lessons.where((l) => done.contains(l.id)).length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BEREICH ${area.number}',
                style: context.text.labelSmall?.copyWith(
                  color: context.c.textMuted,
                  letterSpacing: 1.2,
                ),
              ),
              HyphenText(area.title, style: context.text.titleMedium),
            ],
          ),
        ),
        const SizedBox(width: Gap.s),
        Text(
          '$doneHere / ${lessons.length}',
          style: AppType.numeric(size: 13, color: context.c.textMuted),
        ),
      ],
    );
  }
}

/// Ein Thema als aufklappbarer Lernpfad: jede Lektion eine Station,
/// verbunden durch eine Linie. Erledigte Stationen tragen einen Haken, die
/// nächste offene ist hervorgehoben.
class _TopicSection extends ConsumerStatefulWidget {
  const _TopicSection({
    super.key,
    required this.topic,
    required this.initiallyOpen,
  });

  final Topic topic;
  final bool initiallyOpen;

  @override
  ConsumerState<_TopicSection> createState() => _TopicSectionState();
}

class _TopicSectionState extends ConsumerState<_TopicSection> {
  late bool _open =
      PageStorage.maybeOf(context)?.readState(context) as bool? ??
      widget.initiallyOpen;

  void _toggle() {
    setState(() => _open = !_open);
    PageStorage.maybeOf(context)?.writeState(context, _open);
  }

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    final lessons = Subtopics.ofTopic(topic.id);
    final steps = ref.watch(lessonStepsProvider);
    final done = ref.watch(journeyProvider);
    final next = ref.watch(nextLessonProvider);
    final doneHere = lessons.where((l) => done.contains(l.id)).length;
    final complete = lessons.isNotEmpty && doneHere == lessons.length;
    final c = context.c;

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            button: true,
            expanded: _open,
            child: InkWell(
              onTap: _toggle,
              borderRadius: BorderRadius.circular(Radii.l),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.m, Gap.m),
                child: Row(
                  children: [
                    TileIcon(
                      icon: complete ? Icons.check_rounded : topic.icon,
                      tone: complete ? TileTone.success : TileTone.brand,
                    ),
                    const SizedBox(width: Gap.m),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HyphenText(
                            topic.title,
                            style: context.text.titleSmall,
                          ),
                          const SizedBox(height: Gap.xs),
                          Row(
                            children: [
                              Expanded(
                                child: TopicBar(
                                  confidence: lessons.isEmpty
                                      ? 0
                                      : doneHere / lessons.length,
                                  coverage: 0,
                                ),
                              ),
                              const SizedBox(width: Gap.s),
                              Text(
                                '$doneHere / ${lessons.length}',
                                style: AppType.numeric(
                                  size: 12,
                                  color: c.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Gap.xs),
                    AnimatedRotation(
                      turns: _open ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.expand_more, color: c.textMuted),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: !_open
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.m, Gap.s),
                    child: Column(
                      children: [
                        Divider(height: 1, color: c.border),
                        const SizedBox(height: Gap.s),
                        for (var i = 0; i < lessons.length; i++)
                          _Station(
                            lesson: lessons[i],
                            number: i + 1,
                            isLast: i == lessons.length - 1,
                            isDone: done.contains(lessons[i].id),
                            isNext: next?.id == lessons[i].id,
                            stepCount: steps[lessons[i].id]?.length ?? 0,
                          ),
                      ],
                    ),
                  ),
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
    required this.stepCount,
  });

  final Subtopic lesson;
  final int number;
  final bool isLast;
  final bool isDone;
  final bool isNext;
  final int stepCount;

  bool get hasContent => stepCount > 0;

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
              ).copyWith(height: 1),
            ),
    );

    return Semantics(
      button: hasContent,
      label: isDone
          ? 'Erledigt'
          : isNext
          ? 'Als Nächstes'
          : null,
      child: InkWell(
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
                      HyphenText(
                        lesson.title,
                        style: context.text.bodyLarge?.copyWith(
                          fontWeight: isNext
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: hasContent ? null : muted,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 2),
                      HyphenText(
                        lesson.goal,
                        style: context.text.labelSmall?.copyWith(
                          color: muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (hasContent) ...[
                        const SizedBox(height: 2),
                        Text(
                          isDone
                              ? '$stepCount Schritte · erledigt'
                              : '$stepCount Schritte',
                          style: context.text.labelSmall?.copyWith(
                            color: isDone ? context.c.success : muted,
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 2),
                        Text(
                          'Folgt',
                          style: context.text.labelSmall?.copyWith(
                            color: muted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (hasContent)
                Padding(
                  padding: const EdgeInsets.only(top: Gap.s + 2),
                  child: Icon(Icons.chevron_right, size: 20, color: muted),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
