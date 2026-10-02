import 'package:flutter/material.dart';

import '../../core/util/haptics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/question.dart';
import '../../data/seed/seed_theory.dart';
import '../../state/providers.dart';
import '../../state/session_controller.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../../widgets/mascot.dart';
import '../exam/exam_widgets.dart';
import 'question_host.dart';
import 'theory_sheet.dart';

/// Der Aufgaben-Runner für Übungsrunden (Kurztest, Schwächen-Training,
/// Fehler wiederholen, Bereichs-Quiz).
///
/// Aktion "Prüfen" -> Rückmeldung mit Teilpunkten und Erklärung sofort, dann
/// "Weiter". Zurückblättern gibt es nicht; eine beantwortete Aufgabe ist
/// erledigt. Bei Freitext folgt nach dem Aufdecken die Selbstbewertung -
/// die Punkte oben ändern sich mit jedem Haken.
///
/// Prüfungsbögen (Simulation, Aufgabe des Tages) laufen im `ExamRunScreen`.
class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  final _scrollController = ScrollController();
  bool _theoryChecked = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _maybeShowTheory(SessionState s) {
    if (_theoryChecked || s.deferredFeedback || s.endless) return;
    _theoryChecked = true;

    final topicId = s.items.first.question.topicId;
    final seen = ref.read(seenTheoryProvider);
    final snacks = seedTheory.where((t) => t.topicId == topicId);
    if (snacks.isEmpty || snacks.every((t) => seen.contains(t.id))) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) showTheorySheet(context, ref, topicId: topicId);
    });
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  /// Kurztest beenden: Wer schon etwas beantwortet hat, sieht seine
  /// Auswertung - wer gleich wieder geht, landet ohne Umweg auf der Startseite.
  void _endKurztest(SessionState s, SessionController controller) {
    if (s.checkedCount == 0) {
      controller.clear();
      _leave();
    } else {
      controller.finish();
    }
  }

  /// Zurück dorthin, wo die Runde gestartet wurde.
  void _leave() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  Future<bool> _confirmLeave(SessionState s) async {
    if (s.finished) return true;
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Session beenden?'),
        content: const Text(
          'Bereits geprüfte Aufgaben bleiben in deiner Statistik. '
          'Der Rest der Runde verfällt.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Weitermachen'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Beenden'),
          ),
        ],
      ),
    );
    return leave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);

    if (session == null) {
      return Scaffold(
        appBar: AppBar(),
        body: EmptyState(
          icon: Icons.inbox_outlined,
          title: 'Keine laufende Session',
          message: 'Starte eine Runde auf der Startseite oder im Quiz.',
          action: FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Zur Startseite'),
          ),
        ),
      );
    }

    // Auswertung erreicht -> weiter zum Ergebnis.
    if (session.finished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pushReplacement('/ergebnis');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Ein Prüfungsbogen gehört in den Prüfungslauf.
    if (session.paper != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pushReplacement('/pruefung-lauf');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    _maybeShowTheory(session);

    final item = session.current;
    final controller = ref.read(sessionProvider.notifier);

    Future<void> close() async {
      if (session.endless) {
        _endKurztest(session, controller);
        return;
      }
      if (await _confirmLeave(session)) {
        controller.clear();
        if (context.mounted) _leave();
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) close();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Beenden',
            onPressed: close,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClampedText(session.title, style: context.text.titleMedium),
              Text(
                session.endless
                    ? 'Frage ${session.index + 1}  ·  '
                          '${session.correctCount} richtig'
                    : 'Aufgabe ${session.index + 1} von ${session.items.length}',
                style: context.text.labelSmall?.copyWith(
                  color: context.c.textMuted,
                ),
              ),
            ],
          ),
          actions: [
            if (session.endless) ...[
              if (session.correctStreak >= 3)
                Padding(
                  padding: const EdgeInsets.only(right: Gap.xs),
                  child: MetaChip(
                    label: '${session.correctStreak} in Folge',
                    icon: Icons.local_fire_department,
                    color: context.c.flame,
                  ),
                ),
              TextButton(
                onPressed: () => _endKurztest(session, controller),
                child: const Text('Beenden'),
              ),
              const SizedBox(width: Gap.xs),
            ] else
              IconButton(
                tooltip: 'Kurz nachlesen',
                onPressed: () => showTheorySheet(
                  context,
                  ref,
                  topicId: item.question.topicId,
                ),
                icon: const Icon(Icons.menu_book_outlined),
              ),
          ],
          // Der Kurztest hat kein Ende - ein Fortschrittsbalken wäre gelogen.
          bottom: session.endless
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(4),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(
                      end: (session.index + 1) / session.items.length,
                    ),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    builder: (context, v, _) =>
                        LinearProgressIndicator(value: v, minHeight: 4),
                  ),
                ),
        ),
        body: SafeArea(
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
            children: [
              ReadableWidth(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 260),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0.04, 0),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  layoutBuilder: (current, previous) => Stack(
                    alignment: Alignment.topCenter,
                    children: [...previous, ?current],
                  ),
                  child: Column(
                    key: ValueKey('${session.index}-${item.question.id}'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.checked) ...[
                        _Feedback(
                          item: item,
                          index: session.index,
                          streak: session.correctStreak,
                        ),
                        const SizedBox(height: Gap.l),
                      ] else if (item.retry) ...[
                        const _RetryNote(),
                        const SizedBox(height: Gap.l),
                      ],
                      QuestionHost(
                        question: item.question,
                        answer: item.answer,
                        onChanged: controller.setAnswer,
                        revealed: item.checked,
                        grade: item.grade,
                        shuffleSeed: QuestionHost.seedFor(
                          session.startedAt,
                          item.question,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _BottomBar(
          session: session,
          onCheck: () {
            controller.check();
            final grade = ref.read(sessionProvider)?.current.grade;
            if (grade != null) {
              grade.isCorrect ? AppHaptics.correct() : AppHaptics.wrong();
            }
            _scrollToTop();
          },
          onNext: () {
            controller.next();
            _scrollToTop();
          },
          onFinish: controller.finish,
        ),
      ),
    );
  }
}

/// Rückmeldung direkt nach dem Prüfen: Symbol, ein Wort und die Teilpunkte
/// („3 von 4 P.“) - nie nur Farbe. Die ausführliche Erklärung steht unter
/// der Aufgabe.
class _Feedback extends StatelessWidget {
  const _Feedback({
    required this.item,
    required this.index,
    required this.streak,
  });

  final SessionItem item;
  final int index;
  final int streak;

  static const _comfort = [
    'Kein Problem, genau so lernt man. Lies die Erklärung, die Aufgabe kommt wieder.',
    'Fehler sind Lernstoff. Schau dir die Erklärung in Ruhe an.',
    'Nicht schlimm, beim nächsten Mal sitzt es.',
    'Dranbleiben! Die Erklärung unten zeigt, worauf es ankommt.',
  ];

  /// Bit meldet sich nur selten: bei 3, 5 und 10 richtigen in Folge oder
  /// nach einer falschen Antwort - bei normal-richtig reicht der Puls.
  (MascotMood, String)? _bit() {
    final g = item.grade;
    if (g == null || item.isOpen) return null;
    if (g.isCorrect) {
      return switch (streak) {
        3 => (MascotMood.cheer, '3 in Folge, du bist im Flow!'),
        5 => (MascotMood.cheer, '5 in Folge. Stark, weiter so!'),
        10 => (MascotMood.cheer, '10 in Folge, das ist Prüfungsniveau!'),
        _ => null,
      };
    }
    return (MascotMood.oops, _comfort[index % _comfort.length]);
  }

  @override
  Widget build(BuildContext context) {
    final g = item.grade;
    final open = item.isOpen;
    final (color, bg, icon, word) = g == null
        ? (context.c.textMuted, context.c.surfaceAlt, Icons.help_outline, '')
        : g.isCorrect
        ? (
            context.c.success,
            context.c.successBg,
            Icons.check_circle,
            open ? 'Volle Punkte' : 'Richtig',
          )
        : item.earned > 0
        ? (
            context.c.flame,
            context.c.flameBg,
            Icons.adjust,
            open ? 'Teilpunkte' : 'Teilweise richtig',
          )
        : (
            context.c.danger,
            context.c.dangerBg,
            Icons.cancel,
            open ? 'Noch keine Punkte' : 'Noch nicht',
          );

    final fx = g == null
        ? AnswerFxKind.none
        : g.isCorrect
        ? AnswerFxKind.correct
        : item.earned > 0
        ? AnswerFxKind.none
        : AnswerFxKind.wrong;
    final bit = _bit();

    return AnswerFx(
      kind: fx,
      trigger: index,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Gap.l, vertical: Gap.m),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(Radii.m),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: Gap.s),
                Expanded(
                  child: Text(
                    word,
                    style: context.text.titleMedium?.copyWith(color: color),
                  ),
                ),
                const SizedBox(width: Gap.s),
                PointsPill.earned(item),
              ],
            ),
            if (open) ...[
              const SizedBox(height: Gap.xs),
              Text(
                'Vergleiche mit der Musterlösung und hake ab, was wirklich '
                'in deiner Antwort stand. Danach richten sich die Punkte.',
                style: context.text.bodySmall,
              ),
            ] else if (item.retry && g?.isCorrect == true) ...[
              const SizedBox(height: Gap.xs),
              Text(
                'Im zweiten Anlauf geschafft. Die Aufgabe kommt an einem '
                'anderen Tag noch einmal.',
                style: context.text.bodySmall,
              ),
            ],
            if (bit != null) ...[
              const SizedBox(height: Gap.s),
              Row(
                children: [
                  Mascot(mood: bit.$1, size: 36),
                  const SizedBox(width: Gap.s),
                  Expanded(child: Text(bit.$2, style: context.text.bodySmall)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RetryNote extends StatelessWidget {
  const _RetryNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.replay, size: 16, color: context.c.flame),
        const SizedBox(width: Gap.s),
        Expanded(
          child: Text(
            'Zweiter Anlauf, die Aufgabe ging vorhin daneben.',
            style: context.text.labelSmall?.copyWith(color: context.c.flame),
          ),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.session,
    required this.onCheck,
    required this.onNext,
    required this.onFinish,
  });

  final SessionState session;
  final VoidCallback onCheck;
  final VoidCallback onNext;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final item = session.current;
    final last = session.isLast && !session.endless;
    final kind = item.question.kind;
    final picks =
        kind == QuestionKind.single ||
        kind == QuestionKind.multiple ||
        kind == QuestionKind.marking;

    return Container(
      decoration: BoxDecoration(
        color: context.scheme.surface,
        border: Border(top: BorderSide(color: context.c.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(Gap.l),
          child: ReadableWidth(
            shrinkHeight: true,
            child: SizedBox(
              width: double.infinity,
              child: item.checked
                  ? FilledButton.icon(
                      onPressed: last ? onFinish : onNext,
                      icon: Icon(
                        last ? Icons.flag_outlined : Icons.arrow_forward,
                      ),
                      label: Text(
                        last
                            ? 'Auswertung ansehen'
                            : session.endless
                            ? 'Nächste Frage'
                            : 'Nächste Aufgabe',
                      ),
                    )
                  : FilledButton(
                      // Freitext darf man auch im Kopf lösen und dann die
                      // Musterlösung aufdecken.
                      onPressed: item.hasAnswer || item.isOpen ? onCheck : null,
                      child: Text(
                        item.hasAnswer
                            ? 'Antwort prüfen'
                            : item.isOpen
                            ? 'Musterlösung zeigen'
                            : picks
                            ? 'Antwort auswählen'
                            : 'Antwort eingeben',
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
