import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/flashcard.dart';
import '../../data/models/resume.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../../widgets/mascot.dart';
import 'card_launch.dart';

/// Wie eine Karteikarten-Runde ihre Karten auswählt.
enum CardMode {
  /// Leitner: was heute fällig ist, Wiederholungen vor Neuem.
  due,

  /// Alle Karten einer Lektion, auch wenn sie noch nicht fällig sind.
  lesson,

  /// Eine feste Auswahl ([CardSessionArgs.cardIds]) - Themenauswahl,
  /// Zufallsmix, Fehler der letzten Runde.
  practice,

  /// Der gespeicherte Durchlauf: alles bleibt im Pool, bis es gewusst wurde.
  run,

  /// Die wackeligsten schon gesehenen Karten.
  weak,
}

/// Parameter einer Karteikarten-Runde.
class CardSessionArgs {
  const CardSessionArgs({
    this.topicIds = const {},
    this.subtopicIds = const {},
    this.title = 'Karteikarten',
    this.includeNotDue = false,
    this.mode,
    this.cardIds = const [],
    this.limit = 20,
  });

  final Set<String> topicIds;
  final Set<String> subtopicIds;
  final String title;

  /// Direkt nach einer Lektion sollen deren Karten drankommen, auch wenn sie
  /// laut Karteikasten erst später fällig wären.
  final bool includeNotDue;

  final CardMode? mode;

  /// Feste Kartenauswahl für [CardMode.practice], in dieser Reihenfolge.
  final List<String> cardIds;

  /// Höchstzahl Karten für [CardMode.due] und [CardMode.weak].
  final int limit;

  CardMode get effectiveMode =>
      mode ?? (includeNotDue ? CardMode.lesson : CardMode.due);
}

/// Die Karteikarten-Session.
///
/// Ablauf pro Karte: Vorderseite lesen, selbst beantworten, umdrehen, ehrlich
/// bewerten. Die Selbsteinschätzung ist bewusst binär - "wusste ich" oder
/// "wusste ich nicht". Vier Abstufungen wie bei Anki klingen präziser,
/// überfordern aber genau die Person, die ein Thema gerade erst lernt.
///
/// Was nicht gewusst wird, verschwindet nicht bis morgen, sondern kommt
/// wenige Karten später in derselben Runde noch einmal - so lange, bis es
/// sitzt (Relearning wie in Anki, Drop-out-Prinzip). Für den Leitner-Kasten
/// zählt nur die erste Antwort je Runde: Wer eine Karte erst im dritten
/// Anlauf weiß, hat sie nicht „gewusst“, sie bleibt in Fach 1.
class CardSessionScreen extends ConsumerStatefulWidget {
  const CardSessionScreen({super.key, required this.args});

  final CardSessionArgs args;

  @override
  ConsumerState<CardSessionScreen> createState() => _CardSessionScreenState();
}

class _CardSessionScreenState extends ConsumerState<CardSessionScreen> {
  /// Nach so vielen anderen Karten kommt eine nicht gewusste wieder - genug
  /// Abstand, dass die Antwort nicht mehr im Kurzzeitgedächtnis liegt.
  static const _requeueGap = 3;

  late final List<Flashcard> _queue;
  late final CardMode _mode = widget.args.effectiveMode;
  int _pos = 0;
  bool _revealed = false;
  bool _finished = false;

  /// Karten mit erster Antwort in dieser Runde.
  final Set<String> _attempted = {};

  /// Nicht gewusst und noch nicht nachgelernt.
  final Set<String> _open = {};

  int _firstKnew = 0;
  int _relearned = 0;
  final List<Flashcard> _missedCards = [];

  /// Gewusst in Folge (jede Antwort zählt) - Bit meldet sich bei 5 und 10.
  int _knewStreak = 0;

  /// Kurzes Feedback auf der Bewertungsleiste nach jeder Antwort.
  AnswerFxKind _fx = AnswerFxKind.none;
  int _fxTick = 0;

  @override
  void initState() {
    super.initState();
    _queue = _pick();
  }

  List<Flashcard> _pick() {
    final deck = ref.read(deckProvider);
    final pool = ref.read(flashcardsProvider);
    final byId = {for (final c in pool) c.id: c};
    final a = widget.args;
    bool inScope(Flashcard c) =>
        (a.topicIds.isEmpty || a.topicIds.contains(c.topicId)) &&
        (a.subtopicIds.isEmpty || a.subtopicIds.contains(c.subtopicId));

    switch (_mode) {
      case CardMode.lesson:
        return pool.where(inScope).take(30).toList();
      case CardMode.practice:
        return [
          for (final id in a.cardIds)
            if (byId[id] != null) byId[id]!,
        ];
      case CardMode.run:
        final run = ref.read(cardRunProvider);
        if (run == null) return [];
        return [
          for (final id in run.remainingIds())
            if (byId[id] != null) byId[id]!,
        ];
      case CardMode.weak:
        // Gemischt statt streng nach Schwäche: sonst kämen verwandte Karten
        // eines Themas gebündelt hintereinander.
        return deck.weakCards(pool.where(inScope), limit: a.limit)..shuffle();
      case CardMode.due:
        return deck.due(
          pool,
          topicIds: a.topicIds,
          subtopicIds: a.subtopicIds,
          limit: a.limit,
        );
    }
  }

  void _answer(bool knewIt) {
    final card = _queue[_pos];
    if (_attempted.isEmpty && _mode != CardMode.lesson) {
      // Erst mit der ersten Antwort zählt die Runde als begonnen - wer nur
      // reinschaut, überschreibt nicht das Lesezeichen.
      ref
          .read(resumeProvider.notifier)
          .cardsStarted(
            CardBookmark(
              mode: _mode.name,
              title: widget.args.title,
              topicIds: widget.args.topicIds,
              at: DateTime.now(),
            ),
          );
    }
    final first = _attempted.add(card.id);
    if (first) {
      ref.read(deckProvider.notifier).answer(card.id, knewIt: knewIt);
      if (knewIt) {
        _firstKnew++;
      } else {
        _missedCards.add(card);
      }
    }
    ref.read(cardActivityProvider.notifier).log(knewIt: knewIt);
    if (_mode == CardMode.run) {
      ref.read(cardRunProvider.notifier).answer(card.id, knewIt: knewIt);
    }
    HapticFeedback.selectionClick();
    _knewStreak = knewIt ? _knewStreak + 1 : 0;
    if (_knewStreak == 5 || _knewStreak == 10) _bitCheers(_knewStreak);
    final wasFinished = _finished;
    setState(() {
      _fx = knewIt ? AnswerFxKind.correct : AnswerFxKind.wrong;
      _fxTick++;
      if (knewIt) {
        if (_open.remove(card.id)) _relearned++;
      } else {
        _open.add(card.id);
        final at = math.min(_pos + 1 + _requeueGap, _queue.length);
        _queue.insert(at, card);
      }
      _revealed = false;
      _pos++;
      if (_mode == CardMode.run &&
          (ref.read(cardRunProvider)?.isDone ?? false)) {
        _finished = true;
      }
    });
    // Durchlauf gerade fertig: alle Karten gewusst - ein echter Meilenstein.
    if (!wasFinished && _finished && _mode == CardMode.run) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Celebration.show(context);
      });
    }
  }

  void _bitCheers(int streak) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              const Mascot(mood: MascotMood.cheer, size: 36),
              const SizedBox(width: Gap.s),
              Expanded(
                child: Text(
                  streak >= 10
                      ? '10 gewusst in Folge, du bist richtig drin!'
                      : '5 gewusst in Folge. Weiter so!',
                ),
              ),
            ],
          ),
        ),
      );
  }

  void _close() {
    if (_attempted.isEmpty) {
      context.pop();
    } else {
      setState(() => _finished = true);
    }
  }

  String get _emptyMessage => switch (_mode) {
    CardMode.run =>
      'Es läuft gerade kein Durchlauf, oder alle Karten darin sind '
          'schon gewusst. Starte im Karteikasten einen neuen.',
    CardMode.weak =>
      'Noch keine Schwächen gefunden: Schwach ist eine Karte erst, wenn '
          'sie einmal danebenging. Lern zuerst ein paar Runden.',
    CardMode.practice ||
    CardMode.lesson => 'Für diese Auswahl gibt es keine Karten.',
    CardMode.due =>
      'Für diese Auswahl ist heute keine Karte dran. Der Karteikasten '
          'legt jede Karte nach dem richtigen Abstand wieder vor. Komm '
          'morgen wieder oder starte einen Durchlauf.',
  };

  @override
  Widget build(BuildContext context) {
    if (_queue.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.args.title)),
        body: EmptyState(
          icon: Icons.task_alt,
          title: _mode == CardMode.weak ? 'Keine Schwächen' : 'Nichts fällig',
          message: _emptyMessage,
          // Nichts fällig heißt nicht „nichts mehr zu lernen“: Wer weiter
          // will, bekommt eine Runde ohne Tageslimit.
          action: _mode == CardMode.due
              ? Column(
                  children: [
                    FilledButton.icon(
                      onPressed: () => CardLaunch.practice(
                        context,
                        ref,
                        topicIds: widget.args.topicIds,
                        title: widget.args.topicIds.isEmpty
                            ? 'Weiterlernen'
                            : widget.args.title,
                        replace: true,
                      ),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Trotzdem weiterlernen'),
                    ),
                    const SizedBox(height: Gap.s),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Zurück'),
                    ),
                  ],
                )
              : FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('Zurück'),
                ),
        ),
      );
    }

    if (_finished || _pos >= _queue.length) return _buildSummary(context);

    final card = _queue[_pos];
    final state = ref.watch(deckProvider).stateOf(card.id);
    final topic = Topics.byId(card.topicId);
    final run = _mode == CardMode.run ? ref.watch(cardRunProvider) : null;
    final left = _queue.length - _pos;
    final repeat = _open.contains(card.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _close,
          tooltip: 'Beenden',
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.args.title,
              style: context.text.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              run != null
                  ? '${run.knownCount} von ${run.total} gewusst'
                  : left == 1
                  ? 'Letzte Karte'
                  : 'Noch $left Karten',
              style: context.text.labelSmall?.copyWith(
                color: context.c.textMuted,
              ),
            ),
          ],
        ),
        actions: [
          _BoxBadge(box: state.box, isNew: state.isNew),
          const SizedBox(width: Gap.m),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: run != null ? run.progress : _pos / _queue.length,
            minHeight: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
          children: [
            ReadableWidth(
              maxWidth: 640,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: Gap.s,
                    runSpacing: Gap.s,
                    children: [
                      MetaChip(
                        label: topic.title,
                        icon: topic.icon,
                        color: context.scheme.primary,
                      ),
                      if (repeat)
                        MetaChip(
                          label: 'Wiederholung',
                          icon: Icons.refresh,
                          color: context.c.flame,
                        ),
                    ],
                  ),
                  const SizedBox(height: Gap.l),
                  _FlipCard(
                    // Die Position gehört in den Schlüssel: Kommt dieselbe
                    // Karte als Wiederholung, beginnt sie wieder vorne.
                    key: ValueKey('${card.id}-$_pos'),
                    card: card,
                    revealed: _revealed,
                    onTap: () => setState(() => _revealed = true),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            child: AnswerFx(
              kind: _fx,
              trigger: _fxTick,
              child: ReadableWidth(
                maxWidth: 640,
                shrinkHeight: true,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _revealed
                      // Auf 320 px mit großer Schrift passen beide Knöpfe nicht
                      // nebeneinander - dann untereinander statt „Wusst-e ich“.
                      ? ButtonPair(
                          key: const ValueKey('bewerten'),
                          labels: const ['Nochmal', 'Wusste ich'],
                          start: OutlinedButton.icon(
                            onPressed: () => _answer(false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: context.c.danger,
                              side: BorderSide(
                                color: context.c.danger.withValues(alpha: 0.5),
                              ),
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Nochmal', maxLines: 1),
                          ),
                          end: FilledButton.icon(
                            onPressed: () => _answer(true),
                            style: FilledButton.styleFrom(
                              backgroundColor: context.c.success,
                              foregroundColor: context.scheme.onPrimary,
                            ),
                            icon: const Icon(Icons.check),
                            label: const Text('Wusste ich', maxLines: 1),
                          ),
                        )
                      : SizedBox(
                          key: const ValueKey('umdrehen'),
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () => setState(() => _revealed = true),
                            icon: const Icon(Icons.flip_to_back),
                            label: const Text('Umdrehen'),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  MascotMood _summaryMood(CardRun? run, double quote) {
    if (run?.isDone ?? false) return MascotMood.cheer;
    if (quote >= 0.8) return MascotMood.cheer;
    if (quote < 0.5) return MascotMood.oops;
    return MascotMood.happy;
  }

  String _summaryTitle(CardRun? run, double quote) {
    if (run?.isDone ?? false) return 'Du hast es durchgezogen!';
    if (quote >= 0.8) return 'Stark gewusst!';
    if (quote < 0.5) return 'Dranbleiben lohnt sich';
    return 'Gute Runde!';
  }

  String _summaryNote(CardRun? run) {
    if (run != null) {
      if (run.isDone) {
        return 'Durchlauf geschafft: Jede der ${run.total} Karten wurde '
            'mindestens einmal gewusst. Ab jetzt hält der Karteikasten sie '
            'mit Wiederholungen im passenden Abstand frisch.';
      }
      return 'Dein Durchlauf ist gespeichert. Noch ${run.remainingCount} '
          '${run.remainingCount == 1 ? 'Karte ist' : 'Karten sind'} offen. '
          'Mach weiter, wann du willst. Was danebenging, kommt zuerst.';
    }
    final missed = _missedCards.length;
    if (missed == 0) {
      return 'Alle Karten saßen beim ersten Versuch. Sie kommen jetzt in '
          'längeren Abständen wieder.';
    }
    return '$missed ${missed == 1 ? 'Karte liegt' : 'Karten liegen'} wieder '
        'in Fach 1 und ${missed == 1 ? 'kommt' : 'kommen'} morgen erneut dran, '
        'auch wenn du sie hier nachgelernt hast. Genau so festigt sich '
        'Wissen: abrufen, vergessen, wieder abrufen.';
  }

  Widget _buildSummary(BuildContext context) {
    final run = _mode == CardMode.run ? ref.watch(cardRunProvider) : null;
    final total = _attempted.length;
    final quote = total == 0 ? 0.0 : _firstKnew / total;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text(
          run?.isDone ?? false ? 'Durchlauf geschafft' : 'Runde beendet',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            maxWidth: 640,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ring oben, Zahlen darunter: nebeneinander lief „12 nochmal“
                // auf 320 px mit großer Schrift aus der Karte.
                AppCard(
                  padding: const EdgeInsets.all(Gap.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ReadinessRing(
                          value: ((run?.progress ?? quote) * 100).round(),
                          label: run != null ? 'Durchlauf' : 'sofort gewusst',
                          size: 132,
                        ),
                      ),
                      const SizedBox(height: Gap.m),
                      Text(
                        run != null
                            ? '${run.knownCount} von ${run.total} Karten gewusst'
                            : '$total ${total == 1 ? 'Karte' : 'Karten'} bearbeitet',
                        textAlign: TextAlign.center,
                        style: context.text.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.s),
                StatTileRow(
                  children: [
                    StatTile(
                      icon: Icons.check_circle,
                      value: '$_firstKnew',
                      label: 'sofort gewusst',
                      color: context.c.success,
                    ),
                    StatTile(
                      icon: Icons.replay,
                      value: '$_relearned',
                      label: 'nachgelernt',
                      color: context.c.flame,
                    ),
                    if (_open.isNotEmpty)
                      StatTile(
                        icon: Icons.help_outline,
                        value: '${_open.length}',
                        label: 'offen',
                        color: context.c.danger,
                      ),
                  ],
                ),
                const SizedBox(height: Gap.l),
                MascotSays(
                  mood: _summaryMood(run, quote),
                  title: _summaryTitle(run, quote),
                  text: _summaryNote(run),
                ),
                if (_missedCards.isNotEmpty) ...[
                  const SizedBox(height: Gap.xl),
                  const SectionHeader('Das ging beim ersten Mal daneben'),
                  for (final c in _missedCards)
                    Padding(
                      padding: const EdgeInsets.only(bottom: Gap.s),
                      child: AppCard(
                        padding: const EdgeInsets.all(Gap.l),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.front, style: context.text.titleMedium),
                            const SizedBox(height: Gap.xs),
                            Text(
                              c.back,
                              style: context.text.bodyMedium?.copyWith(
                                color: context.c.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
                const SizedBox(height: Gap.xl),
                if (run != null && !run.isDone) ...[
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => context.pushReplacement(
                        '/karten-lernen',
                        extra: widget.args,
                      ),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Weiter im Durchlauf'),
                    ),
                  ),
                  const SizedBox(height: Gap.s),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      child: const Text('Pause'),
                    ),
                  ),
                ] else ...[
                  if (_missedCards.isNotEmpty && _mode != CardMode.run) ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => context.pushReplacement(
                          '/karten-lernen',
                          extra: CardSessionArgs(
                            mode: CardMode.practice,
                            title: 'Fehler wiederholen',
                            cardIds: [for (final c in _missedCards) c.id],
                          ),
                        ),
                        icon: const Icon(Icons.replay),
                        label: const Text('Fehler gleich nochmal'),
                      ),
                    ),
                    const SizedBox(height: Gap.s),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Fertig'),
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
}

/// Die Karte mit echter 3D-Drehung um die Hochachse.
///
/// Vorderseite zuerst, Rückseite erst nach dem Tippen - wer die Antwort
/// schon sieht, lernt nichts. Bei "Animationen reduzieren" springt sie
/// direkt um. Der Schlüssel je Karte sorgt dafür, dass jede neue Karte
/// wieder mit der Vorderseite beginnt.
class _FlipCard extends StatefulWidget {
  const _FlipCard({
    super.key,
    required this.card,
    required this.revealed,
    required this.onTap,
  });

  final Flashcard card;
  final bool revealed;
  final VoidCallback onTap;

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
    value: widget.revealed ? 1 : 0,
  );
  late final Animation<double> _turn = CurvedAnimation(
    parent: _ctrl,
    curve: Curves.easeInOutCubic,
  );

  @override
  void didUpdateWidget(_FlipCard old) {
    super.didUpdateWidget(old);
    if (widget.revealed && !old.revealed) {
      if (MediaQuery.of(context).disableAnimations) {
        _ctrl.value = 1;
      } else {
        _ctrl.forward();
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: !widget.revealed,
      label: widget.revealed ? null : 'Karte umdrehen',
      child: GestureDetector(
        onTap: widget.revealed ? null : widget.onTap,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: AnimatedBuilder(
            animation: _turn,
            builder: (context, _) {
              final angle = _turn.value * math.pi;
              final back = angle > math.pi / 2;
              final face = back
                  ? _CardBack(card: widget.card)
                  : _CardFront(card: widget.card);
              return Transform(
                alignment: Alignment.center,
                // setEntry(3, 2, …) erzeugt die Perspektive; ohne sie wirkt
                // die Drehung wie ein flaches Zusammenstauchen.
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0012)
                  ..rotateY(angle),
                child: back
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: face,
                      )
                    : face,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Face extends StatelessWidget {
  const _Face({required this.child, this.accent = false});

  final Widget child;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    // Die Karte soll wie eine Karte wirken (Mindesthöhe nach Bildschirm),
    // wächst aber mit langen Rückseiten beliebig mit - die Seite scrollt,
    // nichts wird abgeschnitten. Auf schmalen Handys etwas weniger Rand,
    // damit mehr Text in die Zeile passt.
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: (screen.height * 0.36).clamp(220.0, 340.0),
      ),
      padding: EdgeInsets.all(screen.width < 360 ? Gap.l : Gap.xl),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.xl),
        border: Border.all(
          color: accent
              ? context.scheme.primary.withValues(alpha: 0.55)
              : context.c.border,
          width: accent ? 1.5 : 1,
        ),
      ),
      child: child,
    );
  }
}

class _FaceLabel extends StatelessWidget {
  const _FaceLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.text.labelSmall?.copyWith(
        color: context.c.textMuted,
        letterSpacing: 1.3,
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({required this.card});
  final Flashcard card;

  @override
  Widget build(BuildContext context) {
    return _Face(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _FaceLabel('Frage'),
          const SizedBox(height: Gap.m),
          Text(card.front, style: context.text.headlineSmall),
          const SizedBox(height: Gap.xl),
          // Hinweis als dezente Pille. Flexible statt fester Breite: auf
          // schmalen Displays bricht der Text um statt aus der Karte zu laufen.
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Gap.m,
              vertical: Gap.s,
            ),
            decoration: BoxDecoration(
              color: context.c.surfaceAlt,
              borderRadius: BorderRadius.circular(Radii.m),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.touch_app_outlined,
                  size: 16,
                  color: context.c.textMuted,
                ),
                const SizedBox(width: Gap.s),
                Flexible(
                  child: Text(
                    'Erst selbst beantworten, dann antippen zum Umdrehen',
                    style: context.text.labelSmall?.copyWith(
                      color: context.c.textMuted,
                    ),
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

class _CardBack extends StatelessWidget {
  const _CardBack({required this.card});
  final Flashcard card;

  @override
  Widget build(BuildContext context) {
    return _Face(
      accent: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _FaceLabel('Antwort'),
          const SizedBox(height: Gap.s),
          Text(
            card.front,
            style: context.text.titleSmall?.copyWith(
              color: context.c.textMuted,
            ),
          ),
          const SizedBox(height: Gap.m),
          Divider(color: context.c.border),
          const SizedBox(height: Gap.m),
          Text(card.back, style: context.text.bodyLarge),
          if (card.hint != null) ...[
            const SizedBox(height: Gap.l),
            NoteBox(tone: NoteTone.info, child: Text(card.hint!)),
          ],
        ],
      ),
    );
  }
}

class _BoxBadge extends StatelessWidget {
  const _BoxBadge({required this.box, required this.isNew});

  final int box;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final label = isNew ? 'neu' : 'Fach $box';
    return Tooltip(
      message: isNew
          ? 'Diese Karte siehst du zum ersten Mal'
          : '${Leitner.boxLabel(box)}, Wiedervorlage nach '
                '${Leitner.intervalFor(box)} Tagen',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: 6),
        decoration: BoxDecoration(
          color: context.c.surfaceAlt,
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
        child: Text(label, style: AppType.numeric(size: 13)),
      ),
    );
  }
}
