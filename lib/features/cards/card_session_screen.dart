import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/flashcard.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';

/// Parameter einer Karteikarten-Runde.
class CardSessionArgs {
  const CardSessionArgs({this.topicIds = const {}, this.title = 'Karteikarten'});

  final Set<String> topicIds;
  final String title;
}

/// Die Karteikarten-Session.
///
/// Ablauf pro Karte: Vorderseite lesen, selbst beantworten, umdrehen, ehrlich
/// bewerten. Die Selbsteinschätzung ist bewusst binär - "wusste ich" oder
/// "wusste ich nicht". Vier Abstufungen wie bei Anki klingen präziser,
/// überfordern aber genau die Person, die ein Thema gerade erst lernt.
class CardSessionScreen extends ConsumerStatefulWidget {
  const CardSessionScreen({super.key, required this.args});

  final CardSessionArgs args;

  @override
  ConsumerState<CardSessionScreen> createState() => _CardSessionScreenState();
}

class _CardSessionScreenState extends ConsumerState<CardSessionScreen> {
  late final List<Flashcard> _cards;
  int _index = 0;
  bool _revealed = false;
  int _knew = 0;
  int _missed = 0;
  final List<Flashcard> _missedCards = [];

  @override
  void initState() {
    super.initState();
    final deck = ref.read(deckProvider);
    final pool = ref.read(flashcardsProvider);
    _cards = deck.due(pool, topicIds: widget.args.topicIds, limit: 20);
  }

  void _answer(bool knewIt) {
    final card = _cards[_index];
    ref.read(deckProvider.notifier).answer(card.id, knewIt: knewIt);
    HapticFeedback.selectionClick();
    setState(() {
      if (knewIt) {
        _knew++;
      } else {
        _missed++;
        _missedCards.add(card);
      }
      _revealed = false;
      _index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.args.title)),
        body: EmptyState(
          icon: Icons.task_alt,
          title: 'Nichts fällig',
          message: 'Für diese Auswahl ist heute keine Karte dran. '
              'Der Karteikasten legt jede Karte nach dem richtigen Abstand '
              'wieder vor - komm morgen wieder.',
          action: FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Zurück'),
          ),
        ),
      );
    }

    if (_index >= _cards.length) return _buildSummary(context);

    final card = _cards[_index];
    final state = ref.watch(deckProvider).stateOf(card.id);
    final topic = Topics.byId(card.topicId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
          tooltip: 'Beenden',
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.args.title, style: context.text.titleMedium),
            Text(
              'Karte ${_index + 1} von ${_cards.length}',
              style:
                  context.text.labelSmall?.copyWith(color: context.c.textMuted),
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
            value: _index / _cards.length,
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
                  MetaChip(
                    label: topic.title,
                    icon: topic.icon,
                    color: context.scheme.primary,
                  ),
                  const SizedBox(height: Gap.l),
                  _CardFace(
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
            child: ReadableWidth(
              maxWidth: 640,
              shrinkHeight: true,
              child: _revealed
                  ? Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _answer(false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: context.c.danger,
                              side: BorderSide(
                                color: context.c.danger.withValues(alpha: 0.5),
                              ),
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Nochmal'),
                          ),
                        ),
                        const SizedBox(width: Gap.m),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => _answer(true),
                            style: FilledButton.styleFrom(
                              backgroundColor: context.c.success,
                            ),
                            icon: const Icon(Icons.check),
                            label: const Text('Wusste ich'),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
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
    );
  }

  Widget _buildSummary(BuildContext context) {
    final total = _knew + _missed;
    final quote = total == 0 ? 0.0 : _knew / total;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text('Runde beendet'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            maxWidth: 640,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCard(
                  padding: const EdgeInsets.all(Gap.xl),
                  child: Row(
                    children: [
                      ReadinessRing(
                        value: (quote * 100).round(),
                        label: 'gewusst',
                        size: 120,
                      ),
                      const SizedBox(width: Gap.xl),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$total Karten bearbeitet',
                                style: context.text.titleMedium),
                            const SizedBox(height: Gap.s),
                            Row(children: [
                              Icon(Icons.check_circle,
                                  size: 15, color: context.c.success),
                              const SizedBox(width: Gap.s),
                              Text('$_knew gewusst',
                                  style: context.text.bodyMedium),
                            ]),
                            Row(children: [
                              Icon(Icons.refresh,
                                  size: 15, color: context.c.danger),
                              const SizedBox(width: Gap.s),
                              Text('$_missed nochmal',
                                  style: context.text.bodyMedium),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.l),
                NoteBox(
                  tone: NoteTone.info,
                  child: Text(
                    _missed == 0
                        ? 'Alle Karten saßen. Sie kommen jetzt in längeren '
                            'Abständen wieder.'
                        : '$_missed ${_missed == 1 ? "Karte liegt" : "Karten liegen"} '
                            'wieder in Fach 1 und kommen morgen erneut dran. '
                            'Genau so soll der Kasten arbeiten.',
                  ),
                ),
                if (_missedCards.isNotEmpty) ...[
                  const SizedBox(height: Gap.xl),
                  const SectionHeader('Das kam nochmal zurück'),
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
                            Text(c.back,
                                style: context.text.bodyMedium?.copyWith(
                                    color: context.c.textMuted)),
                          ],
                        ),
                      ),
                    ),
                ],
                const SizedBox(height: Gap.xl),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => context.pop(),
                    child: const Text('Fertig'),
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

/// Die eigentliche Karte. Vorderseite kurz, Rückseite erst nach dem Tippen -
/// wer die Antwort schon sieht, lernt nichts.
class _CardFace extends StatelessWidget {
  const _CardFace({
    required this.card,
    required this.revealed,
    required this.onTap,
  });

  final Flashcard card;
  final bool revealed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: revealed ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 220),
        padding: const EdgeInsets.all(Gap.xl),
        decoration: BoxDecoration(
          color: context.scheme.surface,
          borderRadius: BorderRadius.circular(Radii.l),
          border: Border.all(
            color: revealed ? context.scheme.primary : context.c.border,
            width: revealed ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vorderseite',
              style:
                  context.text.labelSmall?.copyWith(color: context.c.textMuted),
            ),
            const SizedBox(height: Gap.s),
            Text(card.front, style: context.text.headlineSmall),
            if (!revealed) ...[
              const SizedBox(height: Gap.xl),
              Row(
                children: [
                  Icon(Icons.touch_app_outlined,
                      size: 16, color: context.c.textMuted),
                  const SizedBox(width: Gap.s),
                  // Ohne Expanded läuft der Hinweis auf schmalen Displays
                  // aus der Karte heraus.
                  Expanded(
                    child: Text(
                      'Erst selbst beantworten, dann tippen zum Umdrehen',
                      style: context.text.labelSmall
                          ?.copyWith(color: context.c.textMuted),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: Gap.l),
              Divider(color: context.c.border),
              const SizedBox(height: Gap.l),
              Text(
                'Rückseite',
                style: context.text.labelSmall
                    ?.copyWith(color: context.c.textMuted),
              ),
              const SizedBox(height: Gap.s),
              Text(card.back, style: context.text.bodyLarge),
              if (card.hint != null) ...[
                const SizedBox(height: Gap.l),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Gap.m),
                  decoration: BoxDecoration(
                    color: context.c.infoBg,
                    borderRadius: BorderRadius.circular(Radii.m),
                    border:
                        Border.all(color: context.c.info.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lightbulb_outline,
                          size: 17, color: context.c.info),
                      const SizedBox(width: Gap.m),
                      Expanded(
                        child: Text(
                          card.hint!,
                          style: context.text.bodyMedium
                              ?.copyWith(color: context.c.info),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ],
        ),
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
          : '${Leitner.boxLabel(box)} - Wiedervorlage nach '
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
