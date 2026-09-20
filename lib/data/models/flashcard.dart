import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// Eine Lernkarteikarte.
///
/// Karteikarten sind der Einstieg für ein Thema, das man noch gar nicht kennt:
/// erst die Begriffe sitzen lassen, dann Übungsaufgaben rechnen. Deshalb sind
/// sie bewusst kurz - Vorderseite ein Begriff oder eine knappe Frage,
/// Rückseite die Antwort in ein bis drei Sätzen.
@immutable
class Flashcard {
  const Flashcard({
    required this.id,
    required this.topicId,
    required this.front,
    required this.back,
    this.hint,
    this.tags = const [],
  });

  final String id;
  final String topicId;

  /// Vorderseite: Begriff, Abkürzung oder kurze Frage.
  final String front;

  /// Rückseite: die Antwort. Kurz halten - wer eine halbe Seite umdreht,
  /// kann sich nicht ehrlich selbst einschätzen.
  final String back;

  /// Optionale Eselsbrücke oder Abgrenzung zu einem verwechselbaren Begriff.
  final String? hint;

  final List<String> tags;

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic_id': topicId,
        'front': front,
        'back': back,
        'hint': hint,
        'tags': tags,
      };

  factory Flashcard.fromJson(Map<String, dynamic> j) => Flashcard(
        id: j['id'].toString(),
        topicId: j['topic_id'] as String,
        front: j['front'] as String,
        back: j['back'] as String,
        hint: j['hint'] as String?,
        tags: ((j['tags'] as List?) ?? const []).cast<String>().toList(),
      );
}

/// Leitner-Karteikasten mit fünf Fächern.
///
/// Gewusst -> die Karte wandert ein Fach weiter und kommt später wieder.
/// Nicht gewusst -> zurück in Fach 1, also morgen wieder.
///
/// Warum Leitner und nicht SM-2: Das Verfahren ist ohne Erklärung
/// verständlich, und der Lernende sieht an der Fachverteilung körperlich,
/// wie der Stapel wandert. SM-2 wäre feiner, verlangt aber eine
/// Selbsteinschätzung in vier Stufen - genau das können Anfänger in einem
/// Thema, das sie neu lernen, noch nicht leisten.
class Leitner {
  const Leitner._();

  static const int boxCount = 5;

  /// Wiedervorlage in Tagen je Fach.
  static const List<int> intervalDays = [1, 2, 4, 9, 18];

  static int intervalFor(int box) =>
      intervalDays[(box - 1).clamp(0, boxCount - 1)];

  /// Bezeichnung für die Oberfläche.
  static String boxLabel(int box) => switch (box) {
        1 => 'Neu & schwierig',
        2 => 'Wird besser',
        3 => 'Sitzt langsam',
        4 => 'Fast sicher',
        _ => 'Sitzt',
      };
}

/// Lernstand einer einzelnen Karte.
@immutable
class CardState {
  const CardState({
    required this.cardId,
    this.box = 1,
    this.due,
    this.lastSeen,
    this.timesCorrect = 0,
    this.timesWrong = 0,
  });

  final String cardId;

  /// 1 bis 5.
  final int box;

  /// Nächste Wiedervorlage. `null` = noch nie gesehen, also sofort fällig.
  final DateTime? due;
  final DateTime? lastSeen;
  final int timesCorrect;
  final int timesWrong;

  bool get isNew => lastSeen == null;

  bool isDue([DateTime? now]) {
    final d = due;
    if (d == null) return true;
    final n = now ?? DateTime.now();
    return !d.isAfter(DateTime(n.year, n.month, n.day, 23, 59, 59));
  }

  /// Bewertet eine Antwort und gibt den neuen Stand zurück.
  CardState answer({required bool knewIt, DateTime? now}) {
    final n = now ?? DateTime.now();
    final today = DateTime(n.year, n.month, n.day);
    final nextBox = knewIt ? math.min(box + 1, Leitner.boxCount) : 1;
    return CardState(
      cardId: cardId,
      box: nextBox,
      due: today.add(Duration(days: Leitner.intervalFor(nextBox))),
      lastSeen: n,
      timesCorrect: timesCorrect + (knewIt ? 1 : 0),
      timesWrong: timesWrong + (knewIt ? 0 : 1),
    );
  }

  Map<String, dynamic> toJson() => {
        'card_id': cardId,
        'box': box,
        'due': due?.toIso8601String(),
        'last_seen': lastSeen?.toIso8601String(),
        'correct': timesCorrect,
        'wrong': timesWrong,
      };

  factory CardState.fromJson(Map<String, dynamic> j) => CardState(
        cardId: j['card_id'] as String,
        box: (j['box'] as num?)?.toInt() ?? 1,
        due: DateTime.tryParse((j['due'] ?? '') as String),
        lastSeen: DateTime.tryParse((j['last_seen'] ?? '') as String),
        timesCorrect: (j['correct'] as num?)?.toInt() ?? 0,
        timesWrong: (j['wrong'] as num?)?.toInt() ?? 0,
      );
}

/// Der gesamte Karteikasten des Lernenden.
@immutable
class DeckState {
  const DeckState({this.cards = const {}});

  /// cardId -> Lernstand. Karten ohne Eintrag sind neu.
  final Map<String, CardState> cards;

  CardState stateOf(String cardId) =>
      cards[cardId] ?? CardState(cardId: cardId);

  DeckState withAnswer(String cardId, bool knewIt, {DateTime? now}) {
    final next = {...cards};
    next[cardId] = stateOf(cardId).answer(knewIt: knewIt, now: now);
    return DeckState(cards: next);
  }

  /// Fällige und neue Karten eines Themas - oder aller Themen, wenn
  /// [topicIds] leer ist. Reihenfolge: zuerst was schon mal danebenging
  /// (niedriges Fach), dann Neues, dann der Rest.
  List<Flashcard> due(
    List<Flashcard> pool, {
    Set<String> topicIds = const {},
    int limit = 20,
    DateTime? now,
  }) {
    final candidates = pool
        .where((c) => topicIds.isEmpty || topicIds.contains(c.topicId))
        .where((c) => stateOf(c.id).isDue(now))
        .toList();

    candidates.sort((a, b) {
      final sa = stateOf(a.id);
      final sb = stateOf(b.id);
      // Niedrigeres Fach zuerst: was noch wackelt, kommt öfter dran.
      final byBox = sa.box.compareTo(sb.box);
      if (byBox != 0) return byBox;
      // Danach: länger überfällig zuerst.
      final da = sa.due ?? DateTime(2000);
      final db = sb.due ?? DateTime(2000);
      return da.compareTo(db);
    });

    return candidates.take(limit).toList();
  }

  int countInBox(int box) =>
      cards.values.where((s) => s.box == box && !s.isNew).length;

  int dueCount(List<Flashcard> pool, {DateTime? now}) =>
      pool.where((c) => stateOf(c.id).isDue(now)).length;

  int learnedCount(List<Flashcard> pool) => pool
      .where((c) => !stateOf(c.id).isNew && stateOf(c.id).box >= 4)
      .length;

  /// 0..1 - wie weit der Kasten insgesamt durchgearbeitet ist. Eine Karte in
  /// Fach 5 zählt voll, eine in Fach 1 fast nichts.
  double mastery(List<Flashcard> pool) {
    if (pool.isEmpty) return 0;
    var sum = 0.0;
    for (final c in pool) {
      final s = stateOf(c.id);
      if (s.isNew) continue;
      sum += (s.box - 1) / (Leitner.boxCount - 1);
    }
    return (sum / pool.length).clamp(0.0, 1.0);
  }

  Map<String, dynamic> toJson() =>
      {'cards': cards.values.map((s) => s.toJson()).toList()};

  factory DeckState.fromJson(Map<String, dynamic> j) {
    final list = ((j['cards'] as List?) ?? const [])
        .map((e) => CardState.fromJson((e as Map).cast<String, dynamic>()));
    return DeckState(cards: {for (final s in list) s.cardId: s});
  }

  String encode() => jsonEncode(toJson());
  static DeckState decode(String s) =>
      DeckState.fromJson((jsonDecode(s) as Map).cast<String, dynamic>());
}
