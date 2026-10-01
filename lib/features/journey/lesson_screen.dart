import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/nugget.dart';
import '../../data/models/subtopic.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../../widgets/hyphenation.dart';
import 'nugget_card.dart';
import '../../widgets/bit_tips.dart';
import '../../widgets/mascot.dart';

/// Eine Lektion der Learning Journey - hier wird nur gelernt.
///
/// Aufbau: Einstieg mit Lernziel und Übersicht der Schritte, dann die
/// Lernschritte in fester Reihenfolge, am Ende eine Zusammenfassung mit den
/// Merksätzen. Abfragen gibt es hier bewusst nicht - dafür sind Quiz und
/// Karteikarten da. Geblättert wird seitlich; jeder Schritt steht für sich
/// und scrollt, wenn er länger ist als der Bildschirm.
class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  late final PageController _pager;
  int _page = 0;

  /// Angefangene Lektion: an der zuletzt offenen Seite weitermachen statt
  /// wieder beim Einstieg.
  @override
  void initState() {
    super.initState();
    final b = ref.read(resumeProvider).lesson;
    final steps = ref.read(lessonStepsProvider)[widget.lessonId] ?? const [];
    final done = ref.read(journeyProvider).contains(widget.lessonId);
    if (b != null && b.lessonId == widget.lessonId && !done) {
      _page = b.page.clamp(0, steps.length);
    }
    _pager = PageController(initialPage: _page);
    if (_page > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Weiter bei Schritt $_page von ${steps.length}'),
            action: SnackBarAction(
              label: 'Von vorn',
              onPressed: () => _pager.jumpToPage(0),
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  void _go(int page, int pageCount) {
    if (page < 0 || page >= pageCount) return;
    if (MediaQuery.of(context).disableAnimations) {
      _pager.jumpToPage(page);
    } else {
      _pager.animateToPage(
        page,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lesson = Subtopics.byId(widget.lessonId);
    final steps = ref.watch(lessonStepsProvider)[widget.lessonId] ?? const [];

    if (lesson == null || steps.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: EmptyState(
          icon: Icons.construction_outlined,
          title: 'Diese Lektion folgt',
          message: 'Die Inhalte zu diesem Unterthema sind noch in Arbeit.',
          action: FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Zurück'),
          ),
        ),
      );
    }

    final topic = Topics.byId(lesson.topicId);
    final pageCount = steps.length + 2;
    final isFinish = _page == pageCount - 1;
    final isStep = _page > 0 && !isFinish;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            _go(_page + 1, pageCount),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            _go(_page - 1, pageCount),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Lektion verlassen',
              onPressed: () => context.pop(),
            ),
            titleSpacing: 0,
            // Kopfzeile: bewusst einzeilig mit „…“ - der volle Titel steht
            // auf der Einstiegsseite der Lektion.
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClampedText(
                  topic.title.toUpperCase(),
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                    letterSpacing: 1.1,
                  ),
                ),
                ClampedText(lesson.title, style: context.text.titleMedium),
              ],
            ),
            actions: [
              if (isStep)
                Padding(
                  padding: const EdgeInsets.only(right: Gap.l),
                  child: Center(
                    child: Text(
                      '$_page/${steps.length}',
                      semanticsLabel: 'Schritt $_page von ${steps.length}',
                      style: AppType.numeric(
                        size: 13,
                        color: context.c.textMuted,
                      ),
                    ),
                  ),
                ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.s),
                child: LessonProgress(count: steps.length, current: _page),
              ),
            ),
          ),
          body: PageView.builder(
            controller: _pager,
            itemCount: pageCount,
            onPageChanged: (p) {
              setState(() => _page = p);
              if (p == pageCount - 1) {
                // Feier nur, wenn die Lektion jetzt neu abgeschlossen wird -
                // nicht beim erneuten Durchblättern. Gilt auch für das
                // Ende der kompletten Journey (letzte offene Lektion).
                final isNew = !ref.read(journeyProvider).contains(lesson.id);
                ref.read(journeyProvider.notifier).complete(lesson.id);
                if (isNew) Celebration.show(context);
                ref.read(resumeProvider.notifier).lessonDone(lesson.id);
                HapticFeedback.lightImpact();
              } else if (!ref.read(journeyProvider).contains(lesson.id)) {
                ref.read(resumeProvider.notifier).lessonAt(lesson.id, p);
              }
            },
            itemBuilder: (context, p) {
              final Widget child;
              if (p == 0) {
                child = _Intro(
                  lesson: lesson,
                  topic: topic,
                  steps: steps,
                  onJump: (i) => _go(i + 1, pageCount),
                );
              } else if (p == pageCount - 1) {
                child = _Finish(lesson: lesson, steps: steps);
              } else {
                child = NuggetCard(nugget: steps[p - 1], showTopic: false);
              }
              return SingleChildScrollView(
                key: PageStorageKey('lesson-${lesson.id}-$p'),
                padding: const EdgeInsets.fromLTRB(
                  Gap.l,
                  Gap.l,
                  Gap.l,
                  Gap.xxl,
                ),
                child: ReadableWidth(maxWidth: 680, child: child),
              );
            },
          ),
          bottomNavigationBar: _BottomBar(
            page: _page,
            pageCount: pageCount,
            onBack: () => _go(_page - 1, pageCount),
            onNext: isFinish
                ? () => context.pop()
                : () => _go(_page + 1, pageCount),
          ),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.page,
    required this.pageCount,
    required this.onBack,
    required this.onNext,
  });

  final int page;
  final int pageCount;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final label = page == pageCount - 1
        ? 'Fertig'
        : page == 0
        ? 'Los geht’s'
        : page == pageCount - 2
        ? 'Lektion abschließen'
        : 'Weiter';

    return Container(
      decoration: BoxDecoration(
        color: context.scheme.surface,
        border: Border(top: BorderSide(color: context.c.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.l, Gap.m),
          child: ReadableWidth(
            maxWidth: 680,
            shrinkHeight: true,
            child: Row(
              children: [
                // Zurück als Symbol: So bleibt dem Hauptknopf auch auf
                // 320 px mit großer Schrift genug Platz für seine
                // Beschriftung.
                if (page > 0) ...[
                  IconButton.outlined(
                    onPressed: onBack,
                    tooltip: 'Zurück',
                    iconSize: 22,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(52, 52),
                      side: BorderSide(color: context.c.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Radii.m),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: Gap.m),
                ],
                Expanded(
                  child: FilledButton(
                    onPressed: onNext,
                    child: Text(label, textAlign: TextAlign.center),
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

/// Fortschritt einer Lektion.
///
/// Bis 16 Schritte als Segmente wie bei Stories - man sieht, wie viele noch
/// kommen, ohne eine Zahl lesen zu müssen. Darüber würden die Segmente zu
/// Strichen; dann ein durchgehender Balken.
class LessonProgress extends StatelessWidget {
  const LessonProgress({super.key, required this.count, required this.current});

  final int count;

  /// 0 = Einstieg, 1..count = Schritte, count+1 = Abschluss.
  final int current;

  static const maxSegments = 16;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final done = current.clamp(0, count);
    final Widget bar;
    if (count <= maxSegments) {
      bar = Row(
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) SizedBox(width: count > 10 ? 3 : 4),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 4,
                decoration: BoxDecoration(
                  color: i < done ? c.flame : c.surfaceAlt,
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
              ),
            ),
          ],
        ],
      );
    } else {
      bar = ClipRRect(
        borderRadius: BorderRadius.circular(Radii.pill),
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: count == 0 ? 0 : done / count),
          duration: const Duration(milliseconds: 250),
          builder: (context, v, _) => LinearProgressIndicator(
            value: v,
            minHeight: 4,
            color: c.flame,
            backgroundColor: c.surfaceAlt,
          ),
        ),
      );
    }
    return Semantics(
      label: 'Lernfortschritt',
      value: '$done von $count Schritten',
      child: ExcludeSemantics(child: bar),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({
    required this.lesson,
    required this.topic,
    required this.steps,
    required this.onJump,
  });

  final Subtopic lesson;
  final Topic topic;
  final List<Nugget> steps;
  final ValueChanged<int> onJump;

  @override
  Widget build(BuildContext context) {
    final lessons = Subtopics.ofTopic(topic.id);
    final index = lessons.indexWhere((l) => l.id == lesson.id) + 1;
    final minutes = (steps.length * 0.9).ceil().clamp(1, 90);
    final examples = steps.where((s) => s.kind == NuggetKind.beispiel).length;
    final sketches = steps.where((s) => s.diagram != null).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${topic.title} · Lektion $index von ${lessons.length}'.toUpperCase(),
          style: context.text.labelSmall?.copyWith(
            color: context.c.textMuted,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: Gap.s),
        HyphenText(lesson.title, style: context.text.headlineSmall),
        const SizedBox(height: Gap.m),
        Wrap(
          spacing: Gap.s,
          runSpacing: Gap.s,
          children: [
            MetaChip(
              icon: Icons.layers_outlined,
              label: '${steps.length} Lernschritte',
            ),
            MetaChip(icon: Icons.schedule, label: 'ca. $minutes Min.'),
            if (examples > 0)
              MetaChip(
                icon: Icons.calculate_outlined,
                label: examples == 1
                    ? '1 Rechenbeispiel'
                    : '$examples Beispiele',
              ),
            if (sketches > 0)
              MetaChip(
                icon: Icons.schema_outlined,
                label: sketches == 1 ? '1 Skizze' : '$sketches Skizzen',
              ),
          ],
        ),
        const SizedBox(height: Gap.l),
        NoteBox(title: 'Lernziel', child: HyphenText(lesson.goal)),
        const SizedBox(height: Gap.xl),
        Text('Das erwartet dich', style: context.text.titleMedium),
        const SizedBox(height: Gap.s),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: Gap.xs),
          child: Column(
            children: [
              for (var i = 0; i < steps.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    indent: Gap.l + 32,
                    color: context.c.border,
                  ),
                _StepRow(
                  number: i + 1,
                  nugget: steps[i],
                  onTap: () => onJump(i),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Eine Zeile der Schrittübersicht - antippen springt direkt dorthin.
class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.number,
    required this.nugget,
    required this.onTap,
  });

  final int number;
  final Nugget nugget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = nuggetStyle(context, nugget.kind);
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Gap.l,
            vertical: Gap.s + 2,
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Radii.s),
                ),
                child: Icon(icon, size: 17, color: color),
              ),
              const SizedBox(width: Gap.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$number · ${nugget.kind.label}',
                      style: context.text.labelSmall?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                    HyphenText(nugget.title, style: context.text.bodyMedium),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: context.c.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

/// Abschluss: Glückwunsch, das Wichtigste in Kürze und die nächste
/// Lektion. Kein Quiz, keine Karten - die Journey ist zum Lernen da.
class _Finish extends ConsumerWidget {
  const _Finish({required this.lesson, required this.steps});

  final Subtopic lesson;
  final List<Nugget> steps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider);
    final done = ref.watch(journeyProvider);
    final i = lessons.indexWhere((l) => l.id == lesson.id);
    final following = i >= 0 && i + 1 < lessons.length ? lessons[i + 1] : null;
    final doneCount = lessons.where((l) => done.contains(l.id)).length;
    final c = context.c;

    // Die Merksätze der Lektion - zum Abschluss noch einmal am Stück.
    final keyPoints = <String>[
      for (final s in steps)
        if (s.merksatz != null)
          s.merksatz!
        else if (s.kind == NuggetKind.merksatz)
          s.body,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.successBg,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.task_alt_rounded, size: 30, color: c.success),
            ),
            const SizedBox(width: Gap.l),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lektion geschafft', style: context.text.headlineSmall),
                  const SizedBox(height: 2),
                  Text(
                    '${steps.length} Lernschritte · '
                    '$doneCount von ${lessons.length} Lektionen erledigt',
                    style: context.text.bodyMedium?.copyWith(
                      color: c.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Gap.xl),
        BitTip(
          BitSpot.lesson,
          title: following == null
              ? 'Journey komplett. Wahnsinn!'
              : 'Stark, Lektion geschafft!',
          mood: MascotMood.cheer,
        ),
        if (keyPoints.isNotEmpty) ...[
          const SizedBox(height: Gap.xl),
          AppCard(
            color: c.flameBg,
            borderColor: c.flame.withValues(alpha: 0.35),
            padding: const EdgeInsets.all(Gap.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.push_pin_outlined, size: 18, color: c.flame),
                    const SizedBox(width: Gap.s),
                    Expanded(
                      child: Text(
                        'Das Wichtigste in Kürze',
                        style: context.text.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.m),
                for (final p in keyPoints)
                  Padding(
                    padding: const EdgeInsets.only(bottom: Gap.s),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: c.flame,
                          ),
                        ),
                        const SizedBox(width: Gap.s),
                        Expanded(
                          child: HyphenText(p, style: context.text.bodyMedium),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
        if (following != null) ...[
          const SizedBox(height: Gap.xl),
          ActionTile(
            icon: Icons.arrow_forward_rounded,
            title: 'Nächste Lektion',
            subtitle: following.title,
            onTap: () => context.pushReplacement('/lektion/${following.id}'),
          ),
        ] else ...[
          const SizedBox(height: Gap.xl),
          const NoteBox(
            tone: NoteTone.success,
            child: Text('Das war die letzte Lektion der Journey.'),
          ),
        ],
      ],
    );
  }
}
