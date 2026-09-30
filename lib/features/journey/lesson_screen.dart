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
import '../cards/card_session_screen.dart';
import '../learn/session_launcher.dart';
import 'nugget_card.dart';

/// Eine Lektion der Learning Journey.
///
/// Aufbau: Einstieg mit Lernziel, dann die Lernschritte in fester
/// Reihenfolge, am Ende Abschluss mit Wissenscheck. Geblättert wird
/// seitlich, damit jeder Schritt für sich steht - wer zurück will, kann
/// jederzeit zurück.
class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  final _pager = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  void _go(int page, int pageCount) {
    if (page < 0 || page >= pageCount) return;
    final instant = MediaQuery.of(context).disableAnimations;
    if (instant) {
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  lesson.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.titleMedium,
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.s),
                child: _Segments(count: steps.length, current: _page),
              ),
            ),
          ),
          body: PageView.builder(
            controller: _pager,
            itemCount: pageCount,
            onPageChanged: (p) {
              setState(() => _page = p);
              if (p == pageCount - 1) {
                ref.read(journeyProvider.notifier).complete(lesson.id);
                HapticFeedback.lightImpact();
              }
            },
            itemBuilder: (context, p) {
              final Widget child;
              if (p == 0) {
                child = _Intro(lesson: lesson, topic: topic, steps: steps);
              } else if (p == pageCount - 1) {
                child = _Finish(lesson: lesson);
              } else {
                child = NuggetCard(nugget: steps[p - 1], showTopic: false);
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxl),
                child: ReadableWidth(maxWidth: 640, child: child),
              );
            },
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: context.scheme.surface,
              border: Border(top: BorderSide(color: context.c.border)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(Gap.l),
                child: ReadableWidth(
                  maxWidth: 640,
                  shrinkHeight: true,
                  child: Row(
                    children: [
                      if (_page > 0) ...[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _go(_page - 1, pageCount),
                            child: const Text('Zurück'),
                          ),
                        ),
                        const SizedBox(width: Gap.m),
                      ],
                      Expanded(
                        flex: 2,
                        child: FilledButton(
                          onPressed: isFinish
                              ? () => context.pop()
                              : () => _go(_page + 1, pageCount),
                          child: Text(
                            isFinish
                                ? 'Fertig'
                                : _page == 0
                                    ? 'Los geht\'s'
                                    : _page == pageCount - 2
                                        ? 'Lektion abschließen'
                                        : 'Weiter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Fortschritt als Segmente wie bei Stories - man sieht, wie viele Schritte
/// noch kommen, ohne eine Zahl lesen zu müssen.
class _Segments extends StatelessWidget {
  const _Segments({required this.count, required this.current});

  final int count;

  /// 0 = Einstieg, 1..count = Schritte, count+1 = Abschluss.
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const SizedBox(width: 4),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 4,
              decoration: BoxDecoration(
                color: i < current ? context.c.flame : context.c.surfaceAlt,
                borderRadius: BorderRadius.circular(Radii.pill),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.lesson, required this.topic, required this.steps});

  final Subtopic lesson;
  final Topic topic;
  final List<Nugget> steps;

  @override
  Widget build(BuildContext context) {
    final lessons = Subtopics.ofTopic(topic.id);
    final index = lessons.indexWhere((l) => l.id == lesson.id) + 1;
    final minutes = (steps.length * 0.75).ceil().clamp(1, 60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LEKTION $index VON ${lessons.length}',
          style: context.text.labelSmall?.copyWith(
            color: context.c.textMuted,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: Gap.s),
        Text(lesson.title, style: context.text.headlineSmall),
        const SizedBox(height: Gap.l),
        NoteBox(
          title: 'Lernziel',
          child: Text(lesson.goal),
        ),
        const SizedBox(height: Gap.xl),
        Text(
          '${steps.length} Lernschritte  ·  etwa $minutes '
          '${minutes == 1 ? "Minute" : "Minuten"}',
          style: context.text.labelLarge,
        ),
        const SizedBox(height: Gap.m),
        for (var i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.s),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 26,
                  child: Text(
                    '${i + 1}',
                    style: AppType.numeric(size: 13, color: context.c.textMuted),
                  ),
                ),
                Expanded(
                  child: Text(steps[i].title, style: context.text.bodyMedium),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Finish extends ConsumerWidget {
  const _Finish({required this.lesson});
  final Subtopic lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionCountBySubtopicProvider)[lesson.id] ?? 0;
    final topicQuestions = ref.watch(poolSizeProvider)[lesson.topicId] ?? 0;
    final cards = ref.watch(cardCountBySubtopicProvider)[lesson.id] ?? 0;
    final lessons = ref.watch(lessonsProvider);
    final i = lessons.indexWhere((l) => l.id == lesson.id);
    final following = i >= 0 && i + 1 < lessons.length ? lessons[i + 1] : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.task_alt_rounded, size: 40, color: context.c.success),
        const SizedBox(height: Gap.m),
        Text('Lektion geschafft', style: context.text.headlineSmall),
        const SizedBox(height: Gap.xs),
        Text(
          'Festige das Gelernte jetzt, solange es frisch ist - das bringt '
          'mehr als eine weitere Lektion.',
          style: context.text.bodyMedium?.copyWith(color: context.c.textMuted),
        ),
        const SizedBox(height: Gap.xl),
        if (questions > 0 || topicQuestions > 0)
          _FinishAction(
            icon: Icons.quiz_outlined,
            title: 'Wissen prüfen',
            subtitle: questions > 0
                ? '$questions ${questions == 1 ? "Aufgabe" : "Aufgaben"} zu dieser Lektion'
                : '$topicQuestions Aufgaben zum ganzen Thema',
            primary: true,
            onTap: () => questions > 0
                ? SessionLauncher.practice(
                    context,
                    ref,
                    subtopicId: lesson.id,
                    title: lesson.title,
                    count: questions.clamp(1, 10),
                  )
                : SessionLauncher.practice(context, ref,
                    topicId: lesson.topicId),
          ),
        if (cards > 0) ...[
          const SizedBox(height: Gap.m),
          _FinishAction(
            icon: Icons.style_outlined,
            title: 'Karteikarten',
            subtitle: '$cards ${cards == 1 ? "Karte" : "Karten"} zu dieser Lektion',
            onTap: () => context.push(
              '/karten-lernen',
              extra: CardSessionArgs(
                subtopicIds: {lesson.id},
                title: lesson.title,
                includeNotDue: true,
              ),
            ),
          ),
        ],
        if (following != null) ...[
          const SizedBox(height: Gap.m),
          _FinishAction(
            icon: Icons.arrow_forward_rounded,
            title: 'Nächste Lektion',
            subtitle: following.title,
            onTap: () => context.pushReplacement('/lektion/${following.id}'),
          ),
        ],
      ],
    );
  }
}

class _FinishAction extends StatelessWidget {
  const _FinishAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.primary = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      borderColor: primary ? context.scheme.primary.withValues(alpha: 0.5) : null,
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primary ? context.scheme.primary : context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.m),
            ),
            child: Icon(
              icon,
              size: 20,
              color: primary ? context.scheme.onPrimary : context.scheme.primary,
            ),
          ),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.text.titleMedium),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: context.c.textMuted),
        ],
      ),
    );
  }
}
