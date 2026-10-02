import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/exam_composer.dart';
import '../../data/models/exam_case.dart';
import '../../state/session_controller.dart';
import '../../widgets/common.dart';
import '../../widgets/hyphenation.dart';
import '../../widgets/mascot.dart';
import '../learn/question_host.dart';
import 'exam_widgets.dart';

/// Ein Prüfungsbogen: Deckblatt, Aufgaben mit Teilaufgaben, Abgabe und die
/// Selbstbewertung der Freitext-Antworten.
///
/// Aufgebaut wie die echte AP1 - ein Unternehmen, jede Aufgabe mit eigener
/// Situation, Teilaufgaben a), b) … mit Punktangabe. Während der
/// Bearbeitung gibt es keine Rückmeldung; die kommt erst nach der Abgabe.
class ExamRunScreen extends ConsumerStatefulWidget {
  const ExamRunScreen({super.key});

  @override
  ConsumerState<ExamRunScreen> createState() => _ExamRunScreenState();
}

class _ExamRunScreenState extends ConsumerState<ExamRunScreen> {
  final _scroll = ScrollController();

  /// Vom Nutzer umgeschaltete Situationen (Aufgabe -> ausgeklappt?). Ohne
  /// Eintrag ist die Situation bei der ersten Teilaufgabe offen und danach
  /// eingeklappt.
  final _situationOpen = <int, bool>{};

  /// Teilaufgaben, bei denen „Ganz lesen“ getippt wurde. Ohne Eintrag zeigt
  /// die erste Teilaufgabe die Situation nur als Anriss, damit die Aufgabe
  /// selbst auf kleinen Handys noch auf den ersten Bildschirm passt.
  final _situationFull = <int>{};

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _toTop() {
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  void _leave() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/quiz');
    }
  }

  Future<void> _confirmLeave(SessionState s) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.isExam ? 'Prüfung abbrechen?' : 'Aufgabe abbrechen?'),
        content: Text(
          s.reviewing
              ? 'Ohne die Selbstbewertung gibt es keine Auswertung, der '
                    'Versuch wird nicht gewertet.'
              : s.isExam
              ? 'Die Simulation wird nicht gewertet und der Versuch geht '
                    'verloren.'
              : 'Deine Antworten werden nicht gewertet. Die Aufgabe kannst du '
                    'heute jederzeit neu beginnen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Weitermachen'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            // Nicht „Abbrechen“ - das läse sich wie „Dialog schließen“.
            child: const Text('Beenden'),
          ),
        ],
      ),
    );
    if (leave == true && mounted) {
      ref.read(sessionProvider.notifier).clear();
      _leave();
    }
  }

  Future<void> _confirmSubmit(SessionState s) async {
    final open = s.items.where((i) => !i.hasAnswer).length;
    final flagged = s.items.where((i) => i.flagged).length;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.isExam ? 'Prüfung abgeben?' : 'Aufgabe abgeben?'),
        content: Text(
          [
            if (open == 0)
              'Alle Teilaufgaben sind bearbeitet.'
            else
              '$open ${open == 1 ? "Teilaufgabe ist" : "Teilaufgaben sind"} '
                  'noch unbeantwortet und ${open == 1 ? "zählt" : "zählen"} '
                  'mit 0 Punkten.',
            if (flagged > 0)
              '$flagged ${flagged == 1 ? "ist" : "sind"} noch zum Nachsehen '
                  'markiert.',
            'Nach der Abgabe kannst du nichts mehr ändern.',
          ].join(' '),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Zurück'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Abgeben'),
          ),
        ],
      ),
    );
    if (ok == true) {
      ref.read(sessionProvider.notifier).finish();
      _toTop();
    }
  }

  void _showOverview(SessionState s) {
    final controller = ref.read(sessionProvider.notifier);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => _OverviewSheet(
        session: s,
        onJump: (i) {
          controller.jumpTo(i);
          Navigator.of(ctx).pop();
          _toTop();
        },
        onSubmit: () {
          Navigator.of(ctx).pop();
          _confirmSubmit(ref.read(sessionProvider)!);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final paper = session?.paper;

    if (session == null || paper == null) {
      return Scaffold(
        appBar: AppBar(),
        body: EmptyState(
          icon: Icons.assignment_outlined,
          title: 'Keine laufende Prüfung',
          message: 'Starte eine Prüfungssimulation im Quiz-Reiter.',
          action: FilledButton(
            onPressed: () => context.go('/quiz'),
            child: const Text('Zum Quiz'),
          ),
        ),
      );
    }

    if (session.finished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pushReplacement('/ergebnis');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final controller = ref.read(sessionProvider.notifier);

    final Widget child;
    if (!session.begun) {
      child = _Cover(
        session: session,
        paper: paper,
        onBegin: controller.begin,
        onClose: () {
          // Auf dem Deckblatt ist noch nichts passiert - ohne Rückfrage.
          controller.clear();
          _leave();
        },
      );
    } else if (session.reviewing) {
      child = _SelfReview(
        session: session,
        paper: paper,
        scroll: _scroll,
        onClose: () => _confirmLeave(session),
        onChanged: (a) => controller.regradeAt(session.index, a),
        onPrevious: () {
          controller.previous();
          _toTop();
        },
        onNext: () {
          controller.next();
          _toTop();
        },
        onDone: controller.completeReview,
      );
    } else {
      final task = paper.taskAt(session.index);
      child = _Run(
        session: session,
        paper: paper,
        scroll: _scroll,
        situationOpen: _situationOpen[task] ?? paper.partAt(session.index) == 0,
        // Von Hand aufgeklappt heißt: ganz zeigen.
        situationPreview:
            _situationOpen[task] == null &&
            !_situationFull.contains(session.index),
        onReadSituation: () =>
            setState(() => _situationFull.add(session.index)),
        onToggleSituation: () => setState(() {
          _situationOpen[task] =
              !(_situationOpen[task] ?? paper.partAt(session.index) == 0);
        }),
        onClose: () => _confirmLeave(session),
        onFlag: controller.toggleFlag,
        onChanged: controller.setAnswer,
        onPrevious: () {
          controller.previous();
          _toTop();
        },
        onNext: () {
          controller.next();
          _toTop();
        },
        onSubmit: () => _confirmSubmit(session),
        onOverview: () => _showOverview(session),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (!session.begun) {
          controller.clear();
          _leave();
        } else {
          _confirmLeave(session);
        }
      },
      child: child,
    );
  }
}

// ------------------------------------------------------------- Deckblatt

class _Cover extends StatelessWidget {
  const _Cover({
    required this.session,
    required this.paper,
    required this.onBegin,
    required this.onClose,
  });

  final SessionState session;
  final ExamPaper paper;
  final VoidCallback onBegin;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final company = paper.company;
    final minutes = session.limit?.inMinutes;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Zurück',
          onPressed: onClose,
        ),
        title: Text(session.title),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, Gap.s, Gap.l, Gap.xxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatTileRow(
                  children: [
                    StatTile(
                      icon: Icons.assignment_outlined,
                      value: '${paper.tasks.length}',
                      label: paper.tasks.length == 1 ? 'Aufgabe' : 'Aufgaben',
                    ),
                    StatTile(
                      icon: Icons.star_outline_rounded,
                      value: '${paper.points}',
                      label: 'Punkte',
                    ),
                    if (minutes != null)
                      StatTile(
                        icon: Icons.timer_outlined,
                        value: '$minutes',
                        label: 'Minuten',
                        color: context.c.flame,
                      ),
                  ],
                ),
                const SizedBox(height: Gap.xl),
                Text(
                  'AUSGANGSSITUATION',
                  style: context.text.labelSmall?.copyWith(
                    color: context.scheme.primary,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: Gap.xs),
                if (company != null) ...[
                  HyphenText(company.name, style: context.text.headlineSmall),
                  const SizedBox(height: Gap.m),
                  HyphenText(
                    company.description,
                    style: context.text.bodyLarge,
                  ),
                ] else ...[
                  HyphenText(
                    'Gemischte Prüfungsaufgaben',
                    style: context.text.headlineSmall,
                  ),
                  const SizedBox(height: Gap.m),
                  HyphenText(
                    'Die Aufgaben stammen aus allen Bereichen des Katalogs '
                    'und sind nach Schwerpunkt gebündelt. Jede Teilaufgabe '
                    'steht für sich.',
                    style: context.text.bodyLarge,
                  ),
                ],
                const SizedBox(height: Gap.xl),
                const SectionHeader('Aufgaben'),
                for (var i = 0; i < paper.tasks.length; i++) ...[
                  _CoverTask(number: i + 1, task: paper.tasks[i]),
                  const SizedBox(height: Gap.s),
                ],
                const SizedBox(height: Gap.l),
                const NoteBox(
                  title: 'Wie in der Prüfung',
                  child: Text(
                    'Erlaubt ist nur ein Taschenrechner. Stichworte genügen, '
                    'ganze Sätze bringen keine Zusatzpunkte. Die Reihenfolge '
                    'bestimmst du selbst. Rechne mit knapp einer Minute je '
                    'Punkt.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BarFrame(
        child: FilledButton.icon(
          onPressed: onBegin,
          icon: const Icon(Icons.play_arrow_rounded),
          label: Text(
            minutes != null ? 'Beginnen (die Zeit läuft)' : 'Beginnen',
          ),
        ),
      ),
    );
  }
}

class _CoverTask extends StatelessWidget {
  const _CoverTask({required this.number, required this.task});

  final int number;
  final ExamTask task;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          PartBadge('$number'),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HyphenText(task.title, style: context.text.titleSmall),
                const SizedBox(height: 2),
                Text(
                  '${task.parts.length} Teilaufgaben  ·  ${task.points} Punkte',
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------- Bearbeitung

class _Run extends StatelessWidget {
  const _Run({
    required this.session,
    required this.paper,
    required this.scroll,
    required this.situationOpen,
    required this.situationPreview,
    required this.onReadSituation,
    required this.onToggleSituation,
    required this.onClose,
    required this.onFlag,
    required this.onChanged,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
    required this.onOverview,
  });

  final SessionState session;
  final ExamPaper paper;
  final ScrollController scroll;
  final bool situationOpen;
  final bool situationPreview;
  final VoidCallback onReadSituation;
  final VoidCallback onToggleSituation;
  final VoidCallback onClose;
  final VoidCallback onFlag;
  final ValueChanged<Object?> onChanged;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;
  final VoidCallback onOverview;

  @override
  Widget build(BuildContext context) {
    final item = session.current;
    final taskIndex = paper.taskAt(session.index);
    final task = paper.tasks[taskIndex];
    final start = paper.startOf(taskIndex);
    final part = paper.partLabel(session.index);
    final q = item.question;

    var taskSeconds = 0;
    for (var i = start; i < start + task.parts.length; i++) {
      taskSeconds += session.items[i].seconds;
    }
    final guide = ExamComposer.guideTime(q.points);
    final guideMin = (guide.inSeconds / 60).round().clamp(1, 99);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Abbrechen',
          onPressed: onClose,
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wo man gerade ist, muss immer ganz lesbar sein - neben Uhr
            // und Lesezeichen wird die Zeile auf schmalen Handys kleiner
            // statt abgeschnitten.
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                paper.tasks.length == 1
                    ? 'Teilaufgabe $part'
                    : 'Aufgabe ${taskIndex + 1} · $part',
                maxLines: 1,
                style: context.text.titleMedium,
              ),
            ),
            ClampedText(
              session.title,
              style: context.text.labelSmall?.copyWith(
                color: context.c.textMuted,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: item.flagged
                ? 'Markierung entfernen'
                : 'Zum Nachsehen markieren',
            onPressed: onFlag,
            icon: Icon(
              item.flagged ? Icons.bookmark : Icons.bookmark_outline,
              color: item.flagged ? context.c.flame : null,
            ),
          ),
          TimeBadge(session: session),
          const SizedBox(width: Gap.s),
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
          controller: scroll,
          padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
          children: [
            ReadableWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskHeader(
                    number: taskIndex + 1,
                    task: task,
                    expanded: situationOpen,
                    onToggle: onToggleSituation,
                    preview: situationPreview,
                    onReadAll: onReadSituation,
                    timeUsed: Duration(seconds: taskSeconds),
                  ),
                  const SizedBox(height: Gap.l),
                  Row(
                    children: [
                      PartBadge(part),
                      const SizedBox(width: Gap.m),
                      Expanded(
                        child: Wrap(
                          spacing: Gap.s,
                          runSpacing: Gap.xs,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            PointsPill(
                              label:
                                  '${q.points} '
                                  '${q.points == 1 ? "Punkt" : "Punkte"}',
                              tone: TileTone.brand,
                            ),
                            Text(
                              'ca. $guideMin min',
                              style: context.text.labelSmall?.copyWith(
                                color: context.c.textMuted,
                              ),
                            ),
                            if (item.flagged)
                              Text(
                                'markiert',
                                style: context.text.labelSmall?.copyWith(
                                  color: context.c.flame,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Gap.l),
                  QuestionHost(
                    key: ValueKey('${session.index}-${q.id}'),
                    question: q,
                    answer: item.answer,
                    onChanged: onChanged,
                    revealed: false,
                    showExplanation: false,
                    shuffleSeed: QuestionHost.seedFor(session.startedAt, q),
                    showCaseContext: false,
                    // Die Punkte stehen schon in der Kopfzeile.
                    showPoints: false,
                    // Wie auf dem echten Bogen: weder Thema noch
                    // Schwierigkeit über der Teilaufgabe.
                    showMeta: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BarFrame(
        child: Row(
          children: [
            IconButton.outlined(
              onPressed: session.index == 0 ? null : onPrevious,
              icon: const Icon(Icons.chevron_left),
              tooltip: 'Vorherige Teilaufgabe',
            ),
            const SizedBox(width: Gap.s),
            IconButton.outlined(
              onPressed: onOverview,
              icon: const Icon(Icons.grid_view_outlined),
              tooltip: 'Übersicht',
            ),
            const SizedBox(width: Gap.m),
            Expanded(
              child: session.isLast
                  ? FilledButton.icon(
                      onPressed: onSubmit,
                      icon: const Icon(Icons.done_all),
                      label: const Text('Abgeben'),
                    )
                  : FilledButton(
                      onPressed: onNext,
                      child: const Text('Weiter'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Unterer Balken mit Rahmen - gleich für Deckblatt, Lauf und Bewertung.
class _BarFrame extends StatelessWidget {
  const _BarFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
            child: SizedBox(width: double.infinity, child: child),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------- Übersicht

class _OverviewSheet extends StatelessWidget {
  const _OverviewSheet({
    required this.session,
    required this.onJump,
    required this.onSubmit,
  });

  final SessionState session;
  final ValueChanged<int> onJump;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final paper = session.paper!;
    final company = paper.company;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Übersicht', style: context.text.titleLarge),
              const SizedBox(height: Gap.xs),
              Text(
                '${session.answeredCount} von ${session.items.length} '
                'Teilaufgaben bearbeitet',
                style: context.text.bodyMedium?.copyWith(
                  color: context.c.textMuted,
                ),
              ),
              if (company != null) ...[
                const SizedBox(height: Gap.m),
                _CompanyFold(company: company),
              ],
              for (var t = 0; t < paper.tasks.length; t++) ...[
                const SizedBox(height: Gap.l),
                Text(
                  'AUFGABE ${t + 1}  ·  ${paper.tasks[t].points} PUNKTE',
                  style: context.text.labelSmall?.copyWith(
                    color: context.scheme.primary,
                    letterSpacing: 1,
                  ),
                ),
                HyphenText(
                  paper.tasks[t].title,
                  style: context.text.titleSmall,
                ),
                const SizedBox(height: Gap.s),
                Wrap(
                  spacing: Gap.s,
                  runSpacing: Gap.s,
                  children: [
                    for (var p = 0; p < paper.tasks[t].parts.length; p++)
                      _PartDot(
                        key: ValueKey('teil-${paper.startOf(t) + p}'),
                        letter: ExamPaper.partLetter(p),
                        item: session.items[paper.startOf(t) + p],
                        isCurrent: paper.startOf(t) + p == session.index,
                        onTap: () => onJump(paper.startOf(t) + p),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: Gap.l),
              Wrap(
                spacing: Gap.l,
                runSpacing: Gap.xs,
                children: [
                  _Legend(
                    color: context.scheme.primary,
                    filled: true,
                    label: 'bearbeitet',
                  ),
                  _Legend(
                    color: context.c.flame,
                    filled: true,
                    label: 'markiert',
                    icon: Icons.bookmark,
                  ),
                  _Legend(
                    color: context.c.textMuted,
                    filled: false,
                    label: 'offen',
                  ),
                ],
              ),
              const SizedBox(height: Gap.l),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onSubmit,
                  icon: const Icon(Icons.done_all),
                  label: Text(
                    session.isExam ? 'Prüfung abgeben' : 'Aufgabe abgeben',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ausgangssituation des Unternehmens zum Nachlesen - eingeklappt.
class _CompanyFold extends StatelessWidget {
  const _CompanyFold({required this.company});

  final ExamCompany company;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceAlt,
      borderRadius: BorderRadius.circular(Radii.m),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: Gap.l),
          childrenPadding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text('Ausgangssituation', style: context.text.titleSmall),
          subtitle: HyphenText(
            company.name,
            style: context.text.labelSmall?.copyWith(
              color: context.c.textMuted,
            ),
          ),
          children: [
            HyphenText(company.description, style: context.text.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _PartDot extends StatelessWidget {
  const _PartDot({
    super.key,
    required this.letter,
    required this.item,
    required this.isCurrent,
    required this.onTap,
  });

  final String letter;
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
    final state = [
      if (item.hasAnswer) 'bearbeitet' else 'offen',
      if (item.flagged) 'markiert',
      if (isCurrent) 'aktuell',
    ].join(', ');

    return Semantics(
      button: true,
      label: 'Teilaufgabe $letter, $state',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.m),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: item.hasAnswer || item.flagged
                ? color.withValues(alpha: 0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(Radii.m),
            border: Border.all(
              color: isCurrent ? context.scheme.onSurface : color,
              width: isCurrent ? 2.4 : 1.2,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                letter,
                textScaler: TextScaler.noScaling,
                style: AppType.numeric(size: 16),
              ),
              // Zustand nicht nur über die Farbe: Häkchen und Lesezeichen.
              if (item.flagged)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Icon(Icons.bookmark, size: 14, color: context.c.flame),
                )
              else if (item.hasAnswer)
                Positioned(
                  top: 3,
                  right: 3,
                  child: Icon(
                    Icons.check,
                    size: 13,
                    color: context.scheme.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    required this.color,
    required this.filled,
    required this.label,
    this.icon,
  });

  final Color color;
  final bool filled;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(icon, size: 14, color: color)
        else
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: filled ? color.withValues(alpha: 0.14) : null,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: color, width: 1.5),
            ),
          ),
        const SizedBox(width: 6),
        Text(
          label,
          style: context.text.labelSmall?.copyWith(color: context.c.textMuted),
        ),
      ],
    );
  }
}

// --------------------------------------------------------- Selbstbewertung

/// Schritt zwischen Abgabe und Ergebnis: Freitext-Antworten anhand der
/// Musterlösung selbst bewerten - so, wie es Korrektoren mit dem
/// Lösungsbogen tun.
class _SelfReview extends StatelessWidget {
  const _SelfReview({
    required this.session,
    required this.paper,
    required this.scroll,
    required this.onClose,
    required this.onChanged,
    required this.onPrevious,
    required this.onNext,
    required this.onDone,
  });

  final SessionState session;
  final ExamPaper paper;
  final ScrollController scroll;
  final VoidCallback onClose;
  final ValueChanged<Object?> onChanged;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final open = session.openIndices;
    final pos = open.indexOf(session.index).clamp(0, open.length - 1);
    final item = session.current;
    final q = item.question;
    final taskIndex = paper.taskAt(session.index);
    final task = paper.tasks[taskIndex];
    final isLast = pos >= open.length - 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Abbrechen',
          onPressed: onClose,
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClampedText('Freitext bewerten', style: context.text.titleMedium),
            ClampedText(
              'Antwort ${pos + 1} von ${open.length}',
              style: context.text.labelSmall?.copyWith(
                color: context.c.textMuted,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (pos + 1) / open.length,
            minHeight: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          controller: scroll,
          padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
          children: [
            ReadableWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (session.timedOut && pos == 0) ...[
                    const NoteBox(
                      tone: NoteTone.warn,
                      title: 'Zeit abgelaufen',
                      child: Text(
                        'Die Prüfung wurde automatisch abgegeben, wie im '
                        'Prüfungsraum, wenn die Aufsicht einsammelt.',
                      ),
                    ),
                    const SizedBox(height: Gap.l),
                  ],
                  if (pos == 0) ...[
                    const MascotSays(
                      mood: MascotMood.think,
                      title: 'Jetzt bist du Korrektor',
                      text:
                          'Vergleiche deine Antwort mit der Musterlösung und '
                          'hake ab, was wirklich dastand. Die IHK wertet auch '
                          'andere fachlich richtige Antworten.',
                    ),
                    const SizedBox(height: Gap.l),
                  ],
                  Row(
                    children: [
                      PartBadge(paper.partLabel(session.index)),
                      const SizedBox(width: Gap.m),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AUFGABE ${taskIndex + 1}',
                              style: context.text.labelSmall?.copyWith(
                                color: context.scheme.primary,
                                letterSpacing: 1,
                              ),
                            ),
                            HyphenText(
                              task.title,
                              style: context.text.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: Gap.s),
                      PointsPill.earned(item),
                    ],
                  ),
                  const SizedBox(height: Gap.l),
                  QuestionHost(
                    key: ValueKey('review-${session.index}-${q.id}'),
                    question: q,
                    answer: item.answer,
                    onChanged: onChanged,
                    revealed: true,
                    grade: item.grade,
                    shuffleSeed: QuestionHost.seedFor(session.startedAt, q),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BarFrame(
        child: Row(
          children: [
            IconButton.outlined(
              onPressed: pos == 0 ? null : onPrevious,
              icon: const Icon(Icons.chevron_left),
              tooltip: 'Vorherige Antwort',
            ),
            const SizedBox(width: Gap.m),
            Expanded(
              child: isLast
                  ? FilledButton.icon(
                      onPressed: onDone,
                      icon: const Icon(Icons.flag_outlined),
                      label: const Text('Zur Auswertung'),
                    )
                  : FilledButton(
                      onPressed: onNext,
                      child: const Text('Nächste Antwort'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
