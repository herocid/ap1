import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/subtopic.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/hyphenation.dart';
import '../cards/card_session_screen.dart';
import '../learn/session_launcher.dart';
import '../../widgets/bit_tips.dart';

/// Eine Session zu einem Themengebiet: Lernen, Wiederholen, Abfragen - am
/// Stück und zu genau einer Lektion.
///
/// 1. Lernen: die nächste offene Lektion des gewählten Themas.
/// 2. Karteikarten: die Karten genau dieser Lektion.
/// 3. Quiz: die Aufgaben genau dieser Lektion.
///
/// „Komplette Session starten“ führt durch alle drei Stufen nacheinander;
/// jede Stufe lässt sich aber auch einzeln starten. Am Ende steht eine kurze
/// Zusammenfassung. Die Session lebt nur, solange dieser Bildschirm offen
/// ist - sie ist ein Ablauf, kein gespeicherter Zustand.
class AreaSessionScreen extends ConsumerStatefulWidget {
  const AreaSessionScreen({super.key, required this.areaId});

  final String areaId;

  @override
  ConsumerState<AreaSessionScreen> createState() => _AreaSessionScreenState();
}

enum _Stage { learn, cards, quiz }

class _AreaSessionScreenState extends ConsumerState<AreaSessionScreen> {
  String? _topicId;
  String? _lessonId;

  /// Geführter Modus: nach jeder Stufe startet die nächste von selbst.
  bool _guided = false;

  final Set<_Stage> _done = {};

  /// Karteikarten-Bilanz der Session (gewusst / nochmal).
  int _cardsKnew = 0;
  int _cardsMissed = 0;

  /// Seit wann die Quiz-Stufe läuft - Antworten danach zählen zur Session.
  DateTime? _quizStart;

  ExamArea get _area => ExamAreas.byId(widget.areaId);

  List<Topic> get _topics => Topics.ofArea(widget.areaId);

  /// Thema mit der ersten offenen Lektion - sonst das erste Thema.
  String _defaultTopic(Set<String> done, Map<String, dynamic> steps) {
    for (final t in _topics) {
      final open = Subtopics.ofTopic(
        t.id,
      ).where((l) => steps.containsKey(l.id) && !done.contains(l.id));
      if (open.isNotEmpty) return t.id;
    }
    return _topics.first.id;
  }

  /// Nächste offene Lektion des Themas - sonst die erste (Wiederholung).
  String? _defaultLesson(
    String topicId,
    Set<String> done,
    Map<String, dynamic> steps,
  ) {
    final lessons = Subtopics.ofTopic(
      topicId,
    ).where((l) => steps.containsKey(l.id)).toList();
    if (lessons.isEmpty) return null;
    return (lessons.where((l) => !done.contains(l.id)).firstOrNull ??
            lessons.first)
        .id;
  }

  void _reset({String? topicId, String? lessonId}) {
    setState(() {
      if (topicId != null) _topicId = topicId;
      _lessonId = lessonId;
      _done.clear();
      _guided = false;
      _cardsKnew = 0;
      _cardsMissed = 0;
      _quizStart = null;
    });
  }

  // ------------------------------------------------------------- Stufen

  Future<void> _runLearn(Subtopic lesson) async {
    await context.push('/lektion/${lesson.id}');
    if (!mounted) return;
    final learned = ref.read(journeyProvider).contains(lesson.id);
    setState(() {
      if (learned) _done.add(_Stage.learn);
    });
    if (learned && _guided) await _next(lesson);
    if (!learned) setState(() => _guided = false);
  }

  Future<void> _runCards(Subtopic lesson, int cardCount) async {
    if (cardCount == 0) {
      setState(() => _done.add(_Stage.cards));
      if (_guided) await _next(lesson);
      return;
    }
    final ids = ref
        .read(flashcardsProvider)
        .where((c) => c.subtopicId == lesson.id)
        .map((c) => c.id)
        .toList();
    int sum(bool correct) {
      final deck = ref.read(deckProvider);
      return ids.fold(0, (s, id) {
        final st = deck.stateOf(id);
        return s + (correct ? st.timesCorrect : st.timesWrong);
      });
    }

    final knewBefore = sum(true);
    final missedBefore = sum(false);
    await context.push(
      '/karten-lernen',
      extra: CardSessionArgs(
        subtopicIds: {lesson.id},
        title: lesson.title,
        includeNotDue: true,
      ),
    );
    if (!mounted) return;
    final knew = sum(true) - knewBefore;
    final missed = sum(false) - missedBefore;
    setState(() {
      _cardsKnew += knew;
      _cardsMissed += missed;
      if (knew + missed > 0) _done.add(_Stage.cards);
    });
    if (knew + missed > 0 && _guided) {
      await _next(lesson);
    } else {
      setState(() => _guided = false);
    }
  }

  void _runQuiz(Subtopic lesson, int questionCount) {
    if (questionCount == 0) {
      setState(() => _done.add(_Stage.quiz));
      return;
    }
    // Der Abschluss der Quiz-Stufe wird an den Antworten im Verlauf erkannt
    // (siehe build) - die Auswertung kehrt danach hierher zurück.
    setState(() {
      _quizStart = DateTime.now();
      _guided = false;
    });
    SessionLauncher.practice(
      context,
      ref,
      subtopicId: lesson.id,
      title: lesson.title,
      count: questionCount.clamp(1, 10),
    );
  }

  Future<void> _next(Subtopic lesson) async {
    final cards = ref.read(cardCountBySubtopicProvider)[lesson.id] ?? 0;
    final questions = ref.read(questionCountBySubtopicProvider)[lesson.id] ?? 0;
    if (!_done.contains(_Stage.learn)) return _runLearn(lesson);
    if (!_done.contains(_Stage.cards)) return _runCards(lesson, cards);
    if (!_done.contains(_Stage.quiz)) return _runQuiz(lesson, questions);
  }

  Future<void> _startGuided(Subtopic lesson) async {
    setState(() => _guided = true);
    await _next(lesson);
  }

  // --------------------------------------------------------------- Aufbau

  @override
  Widget build(BuildContext context) {
    final area = _area;
    final steps = ref.watch(lessonStepsProvider);
    final done = ref.watch(journeyProvider);
    final history = ref.watch(progressProvider).history;
    final cardCounts = ref.watch(cardCountBySubtopicProvider);
    final questionCounts = ref.watch(questionCountBySubtopicProvider);

    final topicId = _topicId ??= _defaultTopic(done, steps);
    final lessonId = _lessonId ??= _defaultLesson(topicId, done, steps);
    final lesson = Subtopics.byId(lessonId);

    // Quiz-Stufe erledigt, sobald nach ihrem Start Antworten zu Aufgaben
    // dieser Lektion im Verlauf stehen.
    final quizIds = {
      for (final q in ref.watch(questionsProvider))
        if (q.subtopicId == lessonId) q.id,
    };
    final quizRecords = _quizStart == null
        ? const []
        : history
              .where(
                (r) =>
                    !r.at.isBefore(_quizStart!) &&
                    quizIds.contains(r.questionId),
              )
              .toList();
    if (quizRecords.isNotEmpty) _done.add(_Stage.quiz);
    final quizCorrect = quizRecords.where((r) => r.isCorrect).length;

    final cards = cardCounts[lessonId] ?? 0;
    final questions = questionCounts[lessonId] ?? 0;
    final stepCount = steps[lessonId]?.length ?? 0;
    final finished = _done.length == _Stage.values.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Session')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
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
                HyphenText(area.title, style: context.text.headlineSmall),
                const SizedBox(height: Gap.s),
                Text(
                  'Eine Session verbindet alles zu einer Lektion: erst lernen, '
                  'dann die Karteikarten dazu, zum Schluss ein kurzes Quiz.',
                  style: context.text.bodyMedium?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
                const SizedBox(height: Gap.l),
                const BitTip(BitSpot.session),
                const SizedBox(height: Gap.xl),

                // ------------------------------------------------ Thema
                const SectionHeader('Thema wählen'),
                for (final t in _topics) ...[
                  _TopicChoice(
                    topic: t,
                    selected: t.id == topicId,
                    onTap: () => _reset(
                      topicId: t.id,
                      lessonId: _defaultLesson(t.id, done, steps),
                    ),
                  ),
                  const SizedBox(height: Gap.s),
                ],
                const SizedBox(height: Gap.l),

                // ---------------------------------------------- Session
                if (lesson == null)
                  const NoteBox(
                    tone: NoteTone.warn,
                    child: Text(
                      'Zu diesem Thema gibt es noch keine Lektionen.',
                    ),
                  )
                else ...[
                  // Überschrift und „Lektion ändern“ dürfen umbrechen - bei
                  // großer Schrift steht der Knopf dann unter dem Titel.
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: Gap.s,
                    children: [
                      Text('Deine Session', style: context.text.titleMedium),
                      TextButton.icon(
                        onPressed: () => _pickLesson(topicId, lessonId!),
                        icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                        label: const Text('Lektion ändern'),
                      ),
                    ],
                  ),
                  if (done.contains(lesson.id))
                    Padding(
                      padding: const EdgeInsets.only(bottom: Gap.s),
                      child: Text(
                        'Diese Lektion hast du schon gelernt - die Session '
                        'wiederholt sie.',
                        style: context.text.bodyMedium?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                    ),
                  const SizedBox(height: Gap.xs),
                  _StageTile(
                    number: 1,
                    icon: Icons.route_rounded,
                    tone: TileTone.flame,
                    title: 'Lernen',
                    subtitle:
                        '${lesson.title} · $stepCount Lernschritte, '
                        'ca. ${math.max(1, (stepCount * 0.9).ceil())} Min.',
                    done: _done.contains(_Stage.learn),
                    onTap: () => _runLearn(lesson),
                  ),
                  const SizedBox(height: Gap.s),
                  _StageTile(
                    number: 2,
                    icon: Icons.style_rounded,
                    tone: TileTone.success,
                    title: 'Karteikarten',
                    subtitle: cards == 0
                        ? 'Zu dieser Lektion gibt es keine Karten'
                        : _done.contains(_Stage.cards)
                        ? '$_cardsKnew gewusst, $_cardsMissed nochmal'
                        : '$cards ${cards == 1 ? "Karte" : "Karten"} zu '
                              'dieser Lektion',
                    done: _done.contains(_Stage.cards),
                    onTap: () => _runCards(lesson, cards),
                  ),
                  const SizedBox(height: Gap.s),
                  _StageTile(
                    number: 3,
                    icon: Icons.quiz_rounded,
                    tone: TileTone.info,
                    title: 'Quiz',
                    subtitle: questions == 0
                        ? 'Zu dieser Lektion gibt es keine Aufgaben'
                        : quizRecords.isNotEmpty
                        ? '$quizCorrect von ${quizRecords.length} richtig'
                        : '${math.min(questions, 10)} '
                              '${questions == 1 ? "Aufgabe" : "Aufgaben"} '
                              'zu dieser Lektion',
                    done: _done.contains(_Stage.quiz),
                    onTap: () => _runQuiz(lesson, questions),
                  ),
                  const SizedBox(height: Gap.xl),
                  if (finished)
                    _Summary(
                      lesson: lesson,
                      cardsKnew: _cardsKnew,
                      cardsMissed: _cardsMissed,
                      quizCorrect: quizCorrect,
                      quizTotal: quizRecords.length,
                      onNext: () {
                        final next = _defaultLesson(
                          topicId,
                          ref.read(journeyProvider),
                          steps,
                        );
                        _reset(lessonId: next);
                      },
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _startGuided(lesson),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: Text(
                          _done.isEmpty
                              ? 'Komplette Session starten'
                              : 'Session fortsetzen',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _pickLesson(String topicId, String current) {
    final steps = ref.read(lessonStepsProvider);
    final done = ref.read(journeyProvider);
    final lessons = Subtopics.ofTopic(
      topicId,
    ).where((l) => steps.containsKey(l.id)).toList();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(ctx).height * 0.8,
          ),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
            children: [
              Text('Lektion wählen', style: ctx.text.titleLarge),
              const SizedBox(height: Gap.m),
              for (final l in lessons) ...[
                SelectTile(
                  title: l.title,
                  subtitle: done.contains(l.id)
                      ? 'Gelernt · ${steps[l.id]!.length} Schritte'
                      : '${steps[l.id]!.length} Schritte',
                  selected: l.id == current,
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _reset(lessonId: l.id);
                  },
                ),
                const SizedBox(height: Gap.s),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Auswahlzeile für ein Thema mit Lernfortschritt.
class _TopicChoice extends ConsumerWidget {
  const _TopicChoice({
    required this.topic,
    required this.selected,
    required this.onTap,
  });

  final Topic topic;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(lessonStepsProvider);
    final done = ref.watch(journeyProvider);
    final lessons = Subtopics.ofTopic(
      topic.id,
    ).where((l) => steps.containsKey(l.id)).toList();
    final doneHere = lessons.where((l) => done.contains(l.id)).length;
    final primary = context.scheme.primary;
    final c = context.c;

    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected
            ? primary.withValues(alpha: 0.08)
            : context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.m),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.m),
          child: Container(
            constraints: const BoxConstraints(minHeight: 56),
            padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.m, Gap.m),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(
                color: selected ? primary : c.border,
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(topic.icon, size: 22, color: primary),
                const SizedBox(width: Gap.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HyphenText(topic.title, style: context.text.titleSmall),
                      const SizedBox(height: 2),
                      Text(
                        lessons.isEmpty
                            ? 'Lektionen folgen'
                            : '$doneHere von ${lessons.length} Lektionen gelernt',
                        style: context.text.labelSmall?.copyWith(
                          color: c.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Gap.s),
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  color: selected ? primary : c.border,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Eine Stufe der Session - gleicher Aufbau wie [ActionTile], mit Haken,
/// sobald sie erledigt ist.
class _StageTile extends StatelessWidget {
  const _StageTile({
    required this.number,
    required this.icon,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.done,
    required this.onTap,
  });

  final int number;
  final IconData icon;
  final TileTone tone;
  final String title;
  final String subtitle;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Semantics(
      button: true,
      label: done ? 'Erledigt' : null,
      child: AppCard(
        onTap: onTap,
        borderColor: done ? c.success.withValues(alpha: 0.5) : null,
        padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.m, Gap.m),
        child: Row(
          children: [
            TileIcon(
              icon: done ? Icons.check_rounded : icon,
              tone: done ? TileTone.success : tone,
            ),
            const SizedBox(width: Gap.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SCHRITT $number',
                    style: context.text.labelSmall?.copyWith(
                      color: c.textMuted,
                      letterSpacing: 1,
                    ),
                  ),
                  HyphenText(title, style: context.text.titleMedium),
                  const SizedBox(height: 2),
                  HyphenText(
                    subtitle,
                    style: context.text.bodySmall?.copyWith(color: c.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Gap.xs),
            Icon(
              done ? Icons.replay_rounded : Icons.chevron_right,
              color: c.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.lesson,
    required this.cardsKnew,
    required this.cardsMissed,
    required this.quizCorrect,
    required this.quizTotal,
    required this.onNext,
  });

  final Subtopic lesson;
  final int cardsKnew;
  final int cardsMissed;
  final int quizCorrect;
  final int quizTotal;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final quizShare = quizTotal == 0 ? null : quizCorrect / quizTotal;

    Widget line(IconData icon, Color color, String text) => Padding(
      padding: const EdgeInsets.only(bottom: Gap.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: Gap.s),
          Expanded(child: HyphenText(text, style: context.text.bodyMedium)),
        ],
      ),
    );

    return AppCard(
      color: c.successBg,
      borderColor: c.success.withValues(alpha: 0.4),
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Session abgeschlossen', style: context.text.titleLarge),
          const SizedBox(height: Gap.m),
          line(Icons.route_rounded, c.flame, 'Gelernt: ${lesson.title}'),
          if (cardsKnew + cardsMissed > 0)
            line(
              Icons.style_rounded,
              c.success,
              'Karteikarten: $cardsKnew gewusst, $cardsMissed nochmal',
            ),
          if (quizShare != null)
            line(
              Icons.quiz_rounded,
              c.info,
              'Quiz: $quizCorrect von $quizTotal richtig '
              '(${(quizShare * 100).round()} %)',
            ),
          const SizedBox(height: Gap.s),
          Text(
            quizShare == null || quizShare >= 0.8
                ? 'Das sitzt. Weiter mit der nächsten Lektion.'
                : 'Die falschen Aufgaben liegen im Fehlerspeicher und kommen '
                      'im Quiz wieder dran.',
            style: context.text.bodyMedium?.copyWith(color: c.textMuted),
          ),
          const SizedBox(height: Gap.l),
          ButtonPair(
            labels: const ['Nächste Session', 'Fertig'],
            start: OutlinedButton(
              onPressed: () => context.pop(),
              child: const Text('Fertig'),
            ),
            end: FilledButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('Nächste Session'),
            ),
          ),
        ],
      ),
    );
  }
}
