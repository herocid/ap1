import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/exam_area.dart';
import '../../data/models/flashcard.dart';
import '../../data/models/topic.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/feedback_fx.dart';
import '../../widgets/mascot.dart';
import 'card_launch.dart';
import 'card_session_screen.dart';

/// Der Karteikasten.
///
/// Vier Wege zu lernen, alle mit Wiedervorlage innerhalb der Runde:
/// - **Fällig** (Leitner): was heute dran ist - die tägliche Routine.
/// - **Durchlauf**: alle Karten (oder eine Auswahl) bleiben im Pool, bis
///   jede gewusst wurde; gespeichert, jederzeit pausierbar.
/// - **Zufallsmix / Themenauswahl**: schnelle Runde quer durch alles oder
///   gezielt einzelne Themen.
/// - **Schwächen**: die wackeligsten schon gesehenen Karten.
///
/// Darunter: Verteilung über die fünf Fächer und Fortschritt je Bereich.
class CardsOverviewScreen extends ConsumerWidget {
  const CardsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(flashcardsProvider);
    final deck = ref.watch(deckProvider);
    final summary = ref.watch(deckSummaryProvider);
    final reviews = summary.reviews;
    final fresh = summary.fresh;
    final due = reviews + fresh;
    final mastery = summary.mastery;
    final weak = summary.weak;

    if (cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Karteikasten')),
        body: const EmptyState(
          icon: Icons.style_outlined,
          title: 'Noch keine Karten',
          message: 'Für diesen Stand sind noch keine Karteikarten hinterlegt.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Karteikasten')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MascotSays(
                  mood: _tipMood(deck, cards, reviews, weak),
                  size: 52,
                  title: _tipTitle(deck, cards, reviews, weak),
                  text: _tipText(deck, cards, reviews, weak),
                ),
                const SizedBox(height: Gap.l),
                AppCard(
                  padding: const EdgeInsets.all(Gap.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HEUTE DRAN',
                        style: context.text.labelSmall?.copyWith(
                          color: context.c.textMuted,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: Gap.xs),
                      // Zahl und Aussage in einer Zeile, Aufschlüsselung
                      // darunter über die volle Breite.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedCount(
                            due,
                            style: AppType.numeric(
                              size: 34,
                              weight: FontWeight.w700,
                              color: due == 0
                                  ? context.c.success
                                  : context.scheme.primary,
                            ),
                          ),
                          const SizedBox(width: Gap.m),
                          Expanded(
                            child: Text(
                              due == 0
                                  ? 'Alles erledigt für heute'
                                  : due == 1
                                  ? 'Karte wartet auf dich'
                                  : 'Karten warten auf dich',
                              style: context.text.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Gap.xs),
                      Text(
                        due == 0
                            ? 'Morgen legt dir der Kasten die nächsten Karten '
                                  'vor. Lust auf mehr? Starte einen Durchlauf.'
                            : '$reviews ${reviews == 1 ? 'Wiederholung' : 'Wiederholungen'}'
                                  ' · $fresh neue ${fresh == 1 ? 'Karte' : 'Karten'}'
                                  ' (Tageslimit ${Leitner.newPerDay})',
                        style: context.text.bodyMedium?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                      const SizedBox(height: Gap.l),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: due == 0
                              ? null
                              : () => _start(context, const CardSessionArgs()),
                          icon: Icon(
                            due == 0
                                ? Icons.check_circle_outline
                                : Icons.play_arrow_rounded,
                          ),
                          label: Text(
                            due == 0
                                ? 'Heute geschafft'
                                : 'Jetzt lernen (${due > 20 ? 20 : due} Karten)',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.l),
                _RunCard(cards: cards),
                const SizedBox(height: Gap.xl),

                const SectionHeader(
                  'Schnell lernen',
                  subtitle:
                      'Was nicht sitzt, kommt in derselben Runde wieder - '
                      'bis du es weißt.',
                ),
                ActionTile(
                  icon: Icons.shuffle,
                  title: 'Zufallsmix',
                  subtitle:
                      '20 Karten quer durch alle Themen - Unsicheres '
                      'bevorzugt. Trainiert das Umschalten wie in der Prüfung.',
                  onTap: () => CardLaunch.randomMix(context, ref),
                ),
                const SizedBox(height: Gap.s),
                ActionTile(
                  icon: Icons.tune,
                  title: 'Themen auswählen',
                  subtitle:
                      'Bereiche oder einzelne Themen wählen - als kurze '
                      'Runde oder als Durchlauf.',
                  onTap: () => context.push('/karten-auswahl'),
                ),
                const SizedBox(height: Gap.s),
                ActionTile(
                  icon: Icons.trending_down,
                  tone: TileTone.danger,
                  title: 'Schwächen trainieren',
                  subtitle: weak == 0
                      ? 'Sobald eine Karte danebengeht, landet sie hier.'
                      : 'Die Karten, die dir am häufigsten danebengehen.',
                  badge: weak == 0 ? null : '$weak',
                  onTap: weak == 0 ? null : () => CardLaunch.weak(context),
                ),
                const SizedBox(height: Gap.xl),

                AppCard(
                  padding: const EdgeInsets.all(Gap.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Verteilung im Kasten',
                              style: context.text.titleMedium,
                            ),
                          ),
                          const SizedBox(width: Gap.s),
                          CountBadge(
                            label: '${(mastery * 100).round()} % sicher',
                            tone: TileTone.success,
                          ),
                        ],
                      ),
                      const SizedBox(height: Gap.xs),
                      Text(
                        'Rechts sitzt es. Was nicht gewusst wird, fällt zurück '
                        'in Fach 1.',
                        style: context.text.bodySmall?.copyWith(
                          color: context.c.textMuted,
                        ),
                      ),
                      const SizedBox(height: Gap.l),
                      _BoxChart(cards: cards, deck: deck),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.xl),

                const SectionHeader(
                  'Nach Bereich lernen',
                  subtitle: 'Zuerst Fälliges, dann Neues aus dem Themengebiet.',
                ),
                for (final area in ExamAreas.all)
                  _AreaCardRow(area: area, cards: cards, deck: deck),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bit kommentiert den Stand des Kastens - ein Satz, der sagt, was jetzt
  // am meisten bringt.
  static MascotMood _tipMood(
    DeckState deck,
    List<Flashcard> cards,
    int reviews,
    int weak,
  ) {
    if (deck.cards.isEmpty) return MascotMood.wave;
    if (reviews == 0 && weak == 0) return MascotMood.cheer;
    return MascotMood.think;
  }

  static String _tipTitle(
    DeckState deck,
    List<Flashcard> cards,
    int reviews,
    int weak,
  ) {
    if (deck.cards.isEmpty) return 'Dein Karteikasten';
    if (reviews > 0) return 'Wiederholen lohnt sich';
    if (weak > 0) return 'Schwächen in Stärken verwandeln';
    return 'Alles im grünen Bereich';
  }

  static String _tipText(
    DeckState deck,
    List<Flashcard> cards,
    int reviews,
    int weak,
  ) {
    if (deck.cards.isEmpty) {
      return 'Lies die Frage, antworte im Kopf, dreh dann um - und sei ehrlich '
          'zu dir. Was du nicht weißt, kommt gleich nochmal.';
    }
    if (reviews > 0) {
      return '$reviews ${reviews == 1 ? 'Karte ist' : 'Karten sind'} kurz vor '
          'dem Vergessen. Jetzt wiederholt, sitzt es doppelt so lange.';
    }
    if (weak > 0) {
      return '$weak ${weak == 1 ? 'Karte wackelt' : 'Karten wackeln'} noch. '
          'Fünf Minuten Schwächen-Training bringen hier am meisten.';
    }
    return 'Keine Wiederholung offen. Ein Zufallsmix hält alles frisch.';
  }

  static void _start(BuildContext context, CardSessionArgs args) {
    context.push('/karten-lernen', extra: args);
  }
}

/// Der Durchlauf: starten, fortsetzen oder neu beginnen.
class _RunCard extends ConsumerWidget {
  const _RunCard({required this.cards});

  final List<Flashcard> cards;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(cardRunProvider);
    final active = run != null && !run.isDone && run.total > 0;
    final done = run != null && run.isDone;

    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TileIcon(
                icon: done ? Icons.emoji_events_outlined : Icons.all_inclusive,
                tone: done ? TileTone.success : TileTone.flame,
              ),
              const SizedBox(width: Gap.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DURCHLAUF',
                      style: context.text.labelSmall?.copyWith(
                        color: context.c.textMuted,
                        letterSpacing: 1,
                      ),
                    ),
                    WordSafeText(
                      active || done
                          ? run.title
                          : 'Alle Karten bis alles sitzt',
                      style: context.text.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Gap.m),
          if (active || done) ...[
            AnimatedBar(value: run.progress, minHeight: 8),
            const SizedBox(height: Gap.s),
            Text(
              done
                  ? 'Geschafft: alle ${run.total} Karten gewusst, '
                        '${run.missCount} Fehlversuche unterwegs.'
                  : '${run.knownCount} von ${run.total} gewusst · '
                        '${run.remainingCount} offen · '
                        '${run.missCount} Fehlversuche',
              style: context.text.bodySmall?.copyWith(
                color: context.c.textMuted,
              ),
            ),
          ] else
            Text(
              'Alle ${cards.length} Karten liegen im Pool. Was du weißt, '
              'fliegt raus - was nicht sitzt, kommt wieder, bis du alles '
              'kannst. Du kannst jederzeit pausieren.',
              style: context.text.bodyMedium?.copyWith(
                color: context.c.textMuted,
              ),
            ),
          const SizedBox(height: Gap.l),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: active
                  ? () => CardLaunch.continueRun(context, run.title)
                  : () =>
                        CardLaunch.startRun(context, ref, title: 'Alle Karten'),
              icon: Icon(
                active ? Icons.play_arrow_rounded : Icons.flag_outlined,
              ),
              label: Text(
                active
                    ? 'Weiter (${run.remainingCount} offen)'
                    : done
                    ? 'Neuer Durchlauf'
                    : 'Durchlauf starten',
              ),
            ),
          ),
          if (active)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    CardLaunch.startRun(context, ref, title: 'Alle Karten'),
                child: const Text('Neu mit allen Karten'),
              ),
            ),
        ],
      ),
    );
  }
}

class _BoxChart extends StatelessWidget {
  const _BoxChart({required this.cards, required this.deck});

  final List<Flashcard> cards;
  final DeckState deck;

  @override
  Widget build(BuildContext context) {
    final counts = List<int>.filled(Leitner.boxCount, 0);
    var untouched = 0;
    for (final c in cards) {
      final s = deck.stateOf(c.id);
      if (s.isNew) {
        untouched++;
      } else {
        counts[s.box - 1]++;
      }
    }
    final max = [untouched, ...counts].fold<int>(1, (m, v) => v > m ? v : m);

    Widget bar(String label, int value, Color color) => Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: AppType.numeric(size: 12, color: context.c.textMuted),
          ),
          const SizedBox(height: 4),
          Container(
            height: 70 * (value / max).clamp(0.06, 1.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: Gap.s),
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.text.labelSmall?.copyWith(
              color: context.c.textMuted,
            ),
          ),
        ],
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        bar('neu', untouched, context.c.border),
        const SizedBox(width: Gap.s),
        for (var i = 0; i < Leitner.boxCount; i++) ...[
          bar(
            '${i + 1}',
            counts[i],
            Color.lerp(
              context.scheme.primary,
              context.c.success,
              i / (Leitner.boxCount - 1),
            )!,
          ),
          if (i < Leitner.boxCount - 1) const SizedBox(width: Gap.s),
        ],
      ],
    );
  }
}

class _AreaCardRow extends ConsumerWidget {
  const _AreaCardRow({
    required this.area,
    required this.cards,
    required this.deck,
  });

  final ExamArea area;
  final List<Flashcard> cards;
  final DeckState deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicIds = Topics.ofArea(area.id).map((t) => t.id).toSet();
    final areaCards = cards.where((c) => topicIds.contains(c.topicId)).toList();

    final due = deck.dueCount(areaCards);

    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.s),
      child: ProgressTile(
        icon: area.icon,
        overline: 'BEREICH ${area.number}',
        title: area.title,
        enabled: areaCards.isNotEmpty,
        progress: areaCards.isEmpty ? 0 : deck.mastery(areaCards),
        caption: areaCards.isEmpty
            ? 'Karten folgen'
            : '${areaCards.length} Karten',
        badge: due > 0 ? '$due fällig' : null,
        onTap: areaCards.isEmpty
            ? null
            // Gezielt lernen kennt kein Tageslimit: Fälliges und Neues
            // zuerst, dann was noch wackelt - auch nach den 20 neuen
            // Karten des Tages.
            : () => CardLaunch.practice(
                context,
                ref,
                topicIds: topicIds,
                title: area.title,
              ),
      ),
    );
  }
}
