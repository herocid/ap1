import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/seed/seed_theory.dart';
import '../../state/providers.dart';
import '../../state/session_controller.dart';
import '../../widgets/common.dart';
import '../../widgets/question_view.dart';
import 'theory_sheet.dart';

/// Der Aufgaben-Runner - eine Oberflaeche fuer Uebung und Pruefung.
///
/// Der Unterschied ist bewusst sichtbar, aber klein gehalten:
/// - Uebung: Aktion "Pruefen" -> Feedback und Erklaerung sofort, dann "Weiter".
///   Zurueckblaettern gibt es nicht; eine beantwortete Aufgabe ist erledigt.
/// - Pruefung: Countdown in der Kopfzeile, kein "Pruefen", dafuer freie
///   Navigation, Markieren fuer spaeter und eine Aufgabenuebersicht. Keine
///   Erklaerungen, keine Farben, kein Hinweis auf richtig oder falsch.
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
    if (_theoryChecked || s.isExam) return;
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

  Future<bool> _confirmLeave(SessionState s) async {
    if (s.finished) return true;
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.isExam ? 'Simulation abbrechen?' : 'Session beenden?'),
        content: Text(
          s.isExam
              ? 'Die Simulation wird nicht gewertet und der Versuch geht '
                  'verloren.'
              : 'Bereits gepruefte Aufgaben bleiben in deiner Statistik. '
                  'Der Rest der Runde verfaellt.',
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
          message: 'Starte eine Runde vom Dashboard aus.',
          action: FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Zum Dashboard'),
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

    _maybeShowTheory(session);

    final item = session.current;
    final controller = ref.read(sessionProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmLeave(session)) {
          controller.clear();
          if (context.mounted) context.go('/');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Beenden',
            onPressed: () async {
              if (await _confirmLeave(session)) {
                controller.clear();
                if (context.mounted) context.go('/');
              }
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(session.title, style: context.text.titleMedium),
              Text(
                'Aufgabe ${session.index + 1} von ${session.items.length}',
                style: context.text.labelSmall
                    ?.copyWith(color: context.c.textMuted),
              ),
            ],
          ),
          actions: [
            if (session.isExam) ...[
              IconButton(
                tooltip: item.flagged
                    ? 'Markierung entfernen'
                    : 'Fuer spaeter markieren',
                onPressed: controller.toggleFlag,
                icon: Icon(
                  item.flagged ? Icons.bookmark : Icons.bookmark_outline,
                  color: item.flagged ? context.c.flame : null,
                ),
              ),
              _CountdownBadge(remaining: session.remaining ?? Duration.zero),
              const SizedBox(width: Gap.s),
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: LinearProgressIndicator(
              value: (session.index + 1) / session.items.length,
              minHeight: 4,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
            children: [
              ReadableWidth(
                child: QuestionView(
                  key: ValueKey(item.question.id),
                  question: item.question,
                  answer: item.answer,
                  onChanged: controller.setAnswer,
                  revealed: item.checked,
                  grade: item.grade,
                  showExplanation: !session.isExam,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _BottomBar(
          session: session,
          onCheck: () {
            controller.check();
            _scrollToTop();
          },
          onNext: () {
            controller.next();
            _scrollToTop();
          },
          onPrevious: () {
            controller.previous();
            _scrollToTop();
          },
          onFinish: () => _confirmFinish(session, controller),
          onOverview: () => _showOverview(session, controller),
        ),
      ),
    );
  }

  Future<void> _confirmFinish(
    SessionState s,
    SessionController controller,
  ) async {
    if (!s.isExam) {
      controller.finish();
      return;
    }
    final open = s.items.where((i) => !i.hasAnswer).length;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Simulation abgeben?'),
        content: Text(
          open == 0
              ? 'Alle Aufgaben sind bearbeitet. Nach der Abgabe siehst du die '
                  'Auswertung mit allen Erklaerungen.'
              : '$open ${open == 1 ? "Aufgabe ist" : "Aufgaben sind"} noch '
                  'unbeantwortet. Unbeantwortete Aufgaben zaehlen mit 0 Punkten.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Zurueck'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Abgeben'),
          ),
        ],
      ),
    );
    if (ok == true) controller.finish();
  }

  void _showOverview(SessionState s, SessionController controller) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Aufgabenuebersicht', style: ctx.text.titleLarge),
              const SizedBox(height: Gap.xs),
              Text(
                '${s.answeredCount} von ${s.items.length} bearbeitet',
                style:
                    ctx.text.labelSmall?.copyWith(color: ctx.c.textMuted),
              ),
              const SizedBox(height: Gap.l),
              Wrap(
                spacing: Gap.s,
                runSpacing: Gap.s,
                children: [
                  for (var i = 0; i < s.items.length; i++)
                    _OverviewDot(
                      index: i,
                      item: s.items[i],
                      isCurrent: i == s.index,
                      onTap: () {
                        controller.jumpTo(i);
                        Navigator.of(ctx).pop();
                        _scrollToTop();
                      },
                    ),
                ],
              ),
              const SizedBox(height: Gap.l),
              Row(
                children: [
                  _LegendDot(color: ctx.scheme.primary, label: 'bearbeitet'),
                  const SizedBox(width: Gap.l),
                  _LegendDot(color: ctx.c.flame, label: 'markiert'),
                  const SizedBox(width: Gap.l),
                  _LegendDot(color: ctx.c.border, label: 'offen'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownBadge extends StatelessWidget {
  const _CountdownBadge({required this.remaining});

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final warn = remaining.inMinutes < 5;
    final critical = remaining.inMinutes < 1;
    final color =
        critical ? context.c.danger : (warn ? context.c.flame : context.c.textMuted);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: 6),
      decoration: BoxDecoration(
        color: critical
            ? context.c.dangerBg
            : warn
                ? context.c.flameBg
                : context.c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined, size: 15, color: color),
          const SizedBox(width: 5),
          Text(formatDuration(remaining),
              style: AppType.numeric(size: 14, color: color)),
        ],
      ),
    );
  }
}

class _OverviewDot extends StatelessWidget {
  const _OverviewDot({
    required this.index,
    required this.item,
    required this.isCurrent,
    required this.onTap,
  });

  final int index;
  final SessionItem item;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = item.flagged
        ? context.c.flame
        : item.hasAnswer
            ? context.scheme.primary
            : context.c.border;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Radii.s),
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.hasAnswer || item.flagged
              ? color.withValues(alpha: 0.14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Radii.s),
          border: Border.all(color: color, width: isCurrent ? 2.4 : 1.2),
        ),
        child: Text('${index + 1}', style: AppType.numeric(size: 14)),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 5),
        Text(label,
            style:
                context.text.labelSmall?.copyWith(color: context.c.textMuted)),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.session,
    required this.onCheck,
    required this.onNext,
    required this.onPrevious,
    required this.onFinish,
    required this.onOverview,
  });

  final SessionState session;
  final VoidCallback onCheck;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onFinish;
  final VoidCallback onOverview;

  @override
  Widget build(BuildContext context) {
    final item = session.current;

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
            child: session.isExam
                ? Row(
                    children: [
                      IconButton.outlined(
                        onPressed: session.index == 0 ? null : onPrevious,
                        icon: const Icon(Icons.chevron_left),
                        tooltip: 'Vorherige Aufgabe',
                      ),
                      const SizedBox(width: Gap.s),
                      IconButton.outlined(
                        onPressed: onOverview,
                        icon: const Icon(Icons.grid_view_outlined),
                        tooltip: 'Uebersicht',
                      ),
                      const SizedBox(width: Gap.m),
                      Expanded(
                        child: session.isLast
                            ? FilledButton.icon(
                                onPressed: onFinish,
                                icon: const Icon(Icons.done_all),
                                label: const Text('Abgeben'),
                              )
                            : FilledButton(
                                onPressed: onNext,
                                child: const Text('Weiter'),
                              ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: item.checked
                            ? FilledButton.icon(
                                onPressed: session.isLast ? onFinish : onNext,
                                icon: Icon(
                                  session.isLast
                                      ? Icons.flag_outlined
                                      : Icons.arrow_forward,
                                ),
                                label: Text(
                                  session.isLast
                                      ? 'Auswertung ansehen'
                                      : 'Naechste Aufgabe',
                                ),
                              )
                            : FilledButton(
                                onPressed: item.hasAnswer ? onCheck : null,
                                child: Text(
                                  item.hasAnswer
                                      ? 'Antwort pruefen'
                                      : 'Antwort auswaehlen',
                                ),
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
