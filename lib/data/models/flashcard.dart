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
    this.subtopicId,
    this.hint,
    this.tags = const [],
  });

  final String id;
  final String topicId;

  /// Lektion der Learning Journey, zu der die Karte gehört.
  final String? subtopicId;

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
    if (subtopicId != null) 'subtopic_id': subtopicId,
    'front': front,
    'back': back,
    'hint': hint,
    'tags': tags,
  };

  factory Flashcard.fromJson(Map<String, dynamic> j) => Flashcard(
    id: j['id'].toString(),
    topicId: j['topic_id'] as String,
    subtopicId: j['subtopic_id'] as String?,
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
    Set<String> subtopicIds = const {},
    int limit = 20,
    DateTime? now,
  }) {
    final candidates = pool
        .where((c) => topicIds.isEmpty || topicIds.contains(c.topicId))
        .where((c) => subtopicIds.isEmpty || subtopicIds.contains(c.subtopicId))
        .where((c) => stateOf(c.id).isDue(now))
        .toList();

    candidates.sort((a, b) {
      final sa = stateOf(a.id);
      final sb = stateOf(b.id);
      // Niedrigeres Fach zuerst: was noch wackelt, kommt öfter dran.
      final byBox = sa.box.compareTo(sb.box);
      if (byBox != 0) return byBox;
      // Im selben Fach erst die Wiederholungen, dann Neues - sonst
      // verdrängen bei über tausend neuen Karten die Neuen jede fällige
      // Wiederholung aus der Runde.
      if (sa.isNew != sb.isNew) return sa.isNew ? 1 : -1;
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

  int learnedCount(List<Flashcard> pool) =>
      pool.where((c) => !stateOf(c.id).isNew && stateOf(c.id).box >= 4).length;

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

  /// Trefferquote 0..1 über alle Antworten zu Karten aus [pool], `null`
  /// solange keine davon beantwortet wurde.
  double? accuracy(Iterable<Flashcard> pool) {
    var right = 0;
    var wrong = 0;
    for (final c in pool) {
      final s = cards[c.id];
      if (s == null) continue;
      right += s.timesCorrect;
      wrong += s.timesWrong;
    }
    final total = right + wrong;
    return total == 0 ? null : right / total;
  }

  /// Wie wackelig eine Karte ist, 0..1 - `null` für nie gesehene Karten.
  ///
  /// Fehlerquote mit Laplace-Glättung (eine Fehlantwort bei einem einzigen
  /// Versuch zählt nicht gleich als 100 % schwach) plus ein Aufschlag für
  /// niedrige Fächer: Was zuletzt danebenging, liegt in Fach 1.
  double? weakness(String cardId) {
    final s = cards[cardId];
    if (s == null || s.isNew) return null;
    final errorRate = (s.timesWrong + 1) / (s.timesCorrect + s.timesWrong + 2);
    final boxPenalty = (Leitner.boxCount - s.box) / (Leitner.boxCount - 1);
    return (0.6 * errorRate + 0.4 * boxPenalty).clamp(0.0, 1.0);
  }

  /// Die schwächsten schon gesehenen Karten - nur solche, die mindestens
  /// einmal danebengingen oder noch in Fach 1-2 liegen. Wackeligste zuerst.
  List<Flashcard> weakCards(Iterable<Flashcard> pool, {int limit = 20}) {
    final scored = <(Flashcard, double)>[];
    for (final c in pool) {
      final s = cards[c.id];
      if (s == null || s.isNew) continue;
      if (s.timesWrong == 0 && s.box > 2) continue;
      scored.add((c, weakness(c.id)!));
    }
    scored.sort((a, b) => b.$2.compareTo(a.$2));
    return [for (final e in scored.take(limit)) e.$1];
  }

  int seenCount(Iterable<Flashcard> pool) =>
      pool.where((c) => !stateOf(c.id).isNew).length;

  Map<String, dynamic> toJson() => {
    'cards': cards.values.map((s) => s.toJson()).toList(),
  };

  factory DeckState.fromJson(Map<String, dynamic> j) {
    final list = ((j['cards'] as List?) ?? const []).map(
      (e) => CardState.fromJson((e as Map).cast<String, dynamic>()),
    );
    return DeckState(cards: {for (final s in list) s.cardId: s});
  }

  String encode() => jsonEncode(toJson());
  static DeckState decode(String s) =>
      DeckState.fromJson((jsonDecode(s) as Map).cast<String, dynamic>());
}

/// Ein Durchlauf („Full Run“): Alle Karten einer Auswahl liegen im Pool, bis
/// jede einmal gewusst wurde.
///
/// Das ist das Drop-out-Verfahren aus dem klassischen Karteikartenlernen:
/// Was sitzt, fliegt raus, was nicht sitzt, bleibt drin und kommt wieder -
/// so lange, bis der Stapel leer ist. Anders als der Leitner-Kasten fragt der
/// Durchlauf nicht, was heute fällig ist; er sorgt dafür, dass jede Karte
/// mindestens einmal ehrlich abgerufen wurde. Die Antworten zählen trotzdem
/// für den Kasten, damit der langfristige Lernstand stimmt.
///
/// Die Reihenfolge wird beim Start gemischt und dann festgehalten: Themen
/// wechseln sich ab (Interleaving), und wer pausiert, macht morgen an
/// derselben Stelle weiter.
@immutable
class CardRun {
  const CardRun({
    required this.title,
    required this.cardIds,
    required this.startedAt,
    this.topicIds = const {},
    this.known = const {},
    this.misses = const {},
    this.finishedAt,
  });

  /// Neuer Durchlauf über [pool] in zufälliger Reihenfolge.
  factory CardRun.start({
    required String title,
    required List<Flashcard> pool,
    Set<String> topicIds = const {},
    math.Random? random,
    DateTime? now,
  }) {
    final ids = [for (final c in pool) c.id]..shuffle(random ?? math.Random());
    return CardRun(
      title: title,
      cardIds: ids,
      topicIds: topicIds,
      startedAt: now ?? DateTime.now(),
    );
  }

  final String title;

  /// Themen der Auswahl, leer = alle Karten.
  final Set<String> topicIds;

  /// Alle Karten des Durchlaufs in Abfragereihenfolge.
  final List<String> cardIds;

  /// Bereits gewusste Karten - die sind raus.
  final Set<String> known;

  /// Wie oft eine Karte in diesem Durchlauf nicht gewusst wurde.
  final Map<String, int> misses;

  final DateTime startedAt;
  final DateTime? finishedAt;

  int get total => cardIds.length;
  int get knownCount => known.length;
  int get remainingCount => total - knownCount;
  bool get isDone => total > 0 && remainingCount == 0;
  double get progress => total == 0 ? 0 : knownCount / total;

  /// Antworten insgesamt, die im Durchlauf danebengingen.
  int get missCount => misses.values.fold(0, (s, v) => s + v);

  /// Offene Karten in Abfragereihenfolge. Was im Durchlauf schon einmal
  /// danebenging, kommt zuerst - der Abstand seit dem Fehler ist dann groß
  /// genug, dass es echtes Abrufen ist und kein Kurzzeitgedächtnis.
  List<String> remainingIds() {
    final open = [
      for (final id in cardIds)
        if (!known.contains(id)) id,
    ];
    final missed = [
      for (final id in open)
        if (misses.containsKey(id)) id,
    ];
    final fresh = [
      for (final id in open)
        if (!misses.containsKey(id)) id,
    ];
    return [...missed, ...fresh];
  }

  CardRun withAnswer(String cardId, {required bool knewIt, DateTime? now}) {
    if (!cardIds.contains(cardId) || known.contains(cardId)) return this;
    final nextKnown = knewIt ? {...known, cardId} : known;
    final nextMisses = knewIt
        ? misses
        : {...misses, cardId: (misses[cardId] ?? 0) + 1};
    final done = nextKnown.length == cardIds.length;
    return CardRun(
      title: title,
      cardIds: cardIds,
      topicIds: topicIds,
      known: nextKnown,
      misses: nextMisses,
      startedAt: startedAt,
      finishedAt: done ? (now ?? DateTime.now()) : null,
    );
  }

  /// Gleicht den Durchlauf an die aktuelle Kartensammlung an: Karten, die es
  /// nach einem Update nicht mehr gibt, fallen heraus.
  CardRun restrictedTo(Set<String> existing) {
    if (cardIds.every(existing.contains)) return this;
    return CardRun(
      title: title,
      cardIds: [
        for (final id in cardIds)
          if (existing.contains(id)) id,
      ],
      topicIds: topicIds,
      known: known.where(existing.contains).toSet(),
      misses: {
        for (final e in misses.entries)
          if (existing.contains(e.key)) e.key: e.value,
      },
      startedAt: startedAt,
      finishedAt: finishedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'topics': topicIds.toList(),
    'cards': cardIds,
    'known': known.toList(),
    'misses': misses,
    'started': startedAt.toIso8601String(),
    'finished': finishedAt?.toIso8601String(),
  };

  factory CardRun.fromJson(Map<String, dynamic> j) => CardRun(
    title: j['title'] as String? ?? 'Durchlauf',
    topicIds: ((j['topics'] as List?) ?? const []).cast<String>().toSet(),
    cardIds: ((j['cards'] as List?) ?? const []).cast<String>().toList(),
    known: ((j['known'] as List?) ?? const []).cast<String>().toSet(),
    misses: {
      for (final e in ((j['misses'] as Map?) ?? const {}).entries)
        e.key as String: (e.value as num).toInt(),
    },
    startedAt:
        DateTime.tryParse(j['started'] as String? ?? '') ?? DateTime.now(),
    finishedAt: DateTime.tryParse(j['finished'] as String? ?? ''),
  );

  String encode() => jsonEncode(toJson());
  static CardRun decode(String s) =>
      CardRun.fromJson((jsonDecode(s) as Map).cast<String, dynamic>());
}

/// Wie viele Karten an welchem Tag abgefragt und gewusst wurden - für die
/// Aktivität in der Statistik. Der Lernstand je Karte steckt in [DeckState];
/// hier geht es nur um das „Wann“.
@immutable
class CardActivity {
  const CardActivity({this.days = const {}});

  /// Tag (`yyyy-mm-dd`) -> (abgefragt, gewusst).
  final Map<String, (int, int)> days;

  static String keyOf(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  CardActivity withAnswer({required bool knewIt, DateTime? now}) {
    final key = keyOf(now ?? DateTime.now());
    final (seen, knew) = days[key] ?? (0, 0);
    return CardActivity(
      days: {...days, key: (seen + 1, knew + (knewIt ? 1 : 0))},
    );
  }

  /// Abgefragte Karten am Tag [d].
  int reviewsOn(DateTime d) => days[keyOf(d)]?.$1 ?? 0;

  /// Abgefragte Karten der letzten [n] Tage, ältester zuerst.
  List<int> lastDays(int n, {DateTime? now}) {
    final today = now ?? DateTime.now();
    return [
      for (var i = n - 1; i >= 0; i--)
        reviewsOn(DateTime(today.year, today.month, today.day - i)),
    ];
  }

  /// Tage in Folge (bis heute oder gestern) mit mindestens einer Karte.
  int streak({DateTime? now}) {
    final today = now ?? DateTime.now();
    var day = DateTime(today.year, today.month, today.day);
    if (reviewsOn(day) == 0) day = day.subtract(const Duration(days: 1));
    var n = 0;
    while (reviewsOn(day) > 0) {
      n++;
      day = DateTime(day.year, day.month, day.day - 1);
    }
    return n;
  }

  int get totalReviews => days.values.fold(0, (s, v) => s + v.$1);

  Map<String, dynamic> toJson() => {
    for (final e in days.entries) e.key: [e.value.$1, e.value.$2],
  };

  factory CardActivity.fromJson(Map<String, dynamic> j) {
    final out = <String, (int, int)>{};
    for (final e in j.entries) {
      final v = e.value;
      if (v is List && v.length == 2) {
        out[e.key] = ((v[0] as num).toInt(), (v[1] as num).toInt());
      }
    }
    return CardActivity(days: out);
  }

  String encode() => jsonEncode(toJson());
  static CardActivity decode(String s) =>
      CardActivity.fromJson((jsonDecode(s) as Map).cast<String, dynamic>());
}
