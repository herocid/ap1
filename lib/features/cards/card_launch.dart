import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/flashcard.dart';
import '../../state/providers.dart';
import 'card_session_screen.dart';

/// Startpunkte für Karteikarten-Runden - gemeinsam genutzt von Karteikasten,
/// Themenauswahl und Statistik.
class CardLaunch {
  const CardLaunch._();

  /// Wählt [count] Karten aus [pool] für eine Übungsrunde: Was noch nicht
  /// sitzt, kommt bevorzugt dran, innerhalb gleicher Priorität zufällig.
  /// `count <= 0` nimmt alle.
  static List<String> pickPractice(
    List<Flashcard> pool,
    DeckState deck, {
    int count = 20,
    math.Random? random,
  }) {
    final rnd = random ?? math.Random();
    double priority(Flashcard c) {
      final s = deck.stateOf(c.id);
      // Danebengegangen (Fach 1, gesehen) vor neu vor wackelig vor sicher.
      final base = s.isNew ? 1.5 : s.box.toDouble();
      return base + rnd.nextDouble() * 0.9;
    }

    final keyed = [for (final c in pool) (c.id, priority(c))]
      ..sort((a, b) => a.$2.compareTo(b.$2));
    final picked = [for (final e in keyed) e.$1];
    final ids = count <= 0 ? picked : picked.take(count).toList();
    // Die Priorität entscheidet, *welche* Karten dabei sind - die
    // Reihenfolge wird danach gemischt, damit Themen sich abwechseln.
    return ids..shuffle(rnd);
  }

  /// Zufallsmix quer durch alle Themen (Interleaving).
  static void randomMix(BuildContext context, WidgetRef ref, {int count = 20}) {
    final ids = pickPractice(
      ref.read(flashcardsProvider),
      ref.read(deckProvider),
      count: count,
    );
    context.push(
      '/karten-lernen',
      extra: CardSessionArgs(
        mode: CardMode.practice,
        title: 'Zufallsmix',
        cardIds: ids,
      ),
    );
  }

  /// Übungsrunde über eine Themenauswahl.
  static void practice(
    BuildContext context,
    WidgetRef ref, {
    required Set<String> topicIds,
    required String title,
    int count = 20,
  }) {
    final pool = ref
        .read(flashcardsProvider)
        .where((c) => topicIds.isEmpty || topicIds.contains(c.topicId))
        .toList();
    context.push(
      '/karten-lernen',
      extra: CardSessionArgs(
        mode: CardMode.practice,
        title: title,
        topicIds: topicIds,
        cardIds: pickPractice(pool, ref.read(deckProvider), count: count),
      ),
    );
  }

  /// Schwächen trainieren - optional auf Themen beschränkt.
  static void weak(
    BuildContext context, {
    Set<String> topicIds = const {},
    String title = 'Schwächen trainieren',
  }) {
    context.push(
      '/karten-lernen',
      extra: CardSessionArgs(
        mode: CardMode.weak,
        title: title,
        topicIds: topicIds,
      ),
    );
  }

  /// Setzt den gespeicherten Durchlauf fort.
  static void continueRun(BuildContext context, String title) {
    context.push(
      '/karten-lernen',
      extra: CardSessionArgs(mode: CardMode.run, title: title),
    );
  }

  /// Startet einen neuen Durchlauf. Läuft schon einer und ist nicht fertig,
  /// wird vorher gefragt - der alte Fortschritt ginge sonst stillschweigend
  /// verloren.
  static Future<void> startRun(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    Set<String> topicIds = const {},
  }) async {
    final current = ref.read(cardRunProvider);
    if (current != null && !current.isDone && current.knownCount > 0) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Neuen Durchlauf starten?'),
          content: Text(
            'Dein Durchlauf „${current.title}“ steht bei '
            '${current.knownCount} von ${current.total} Karten. '
            'Ein neuer Durchlauf ersetzt ihn. Dein Lernstand im '
            'Karteikasten bleibt erhalten.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Neu starten'),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }
    final pool = ref
        .read(flashcardsProvider)
        .where((c) => topicIds.isEmpty || topicIds.contains(c.topicId))
        .toList();
    if (pool.isEmpty) return;
    ref
        .read(cardRunProvider.notifier)
        .start(CardRun.start(title: title, pool: pool, topicIds: topicIds));
    if (context.mounted) continueRun(context, title);
  }
}
