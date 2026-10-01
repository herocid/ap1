import 'dart:math' as math;

/// Mischt die ANZEIGE von Antwortoptionen, Zuordnungs-Items, Paaren und
/// Wortbänken.
///
/// Autoren schreiben die richtige Antwort gern zuerst oder Zuordnungen in
/// der Reihenfolge der Kategorien - ohne Mischen lernt man das Muster statt
/// des Stoffs. Gemischt wird nur die Darstellung: Die Antwort bleibt in
/// Original-Indizes, die Bewertung ändert sich nicht.

/// Hashwert eines Texts, der auf jeder Plattform und in jedem Lauf gleich
/// ist (anders als `String.hashCode`).
int stableHash(String s) {
  var h = 7;
  for (final u in s.codeUnits) {
    h = (h * 31 + u) & 0x3FFFFFFF;
  }
  return h;
}

/// Reihenfolge, in der [n] Elemente angezeigt werden: Position -> Original-
/// Index. Gleicher [seed] und gleiches [salt] ergeben immer dieselbe
/// Reihenfolge.
///
/// [pinLast] hält Elemente am Ende fest („Alle genannten“). Mit
/// [avoidIdentity] kommt nie die Original-Reihenfolge heraus - nötig, wo sie
/// die Lösung wäre (Reihenfolge-Aufgaben, rechte Seite der Paare).
List<int> displayOrder(
  int n,
  int seed, {
  String salt = '',
  bool Function(int index)? pinLast,
  bool avoidIdentity = false,
}) {
  final movable = <int>[];
  final pinned = <int>[];
  for (var i = 0; i < n; i++) {
    (pinLast != null && pinLast(i) ? pinned : movable).add(i);
  }
  movable.shuffle(math.Random((seed ^ stableHash(salt)) & 0x3FFFFFFF));
  if (avoidIdentity && movable.length > 1) {
    var sorted = true;
    for (var i = 1; i < movable.length; i++) {
      if (movable[i - 1] > movable[i]) sorted = false;
    }
    if (sorted) movable.add(movable.removeAt(0));
  }
  return [...movable, ...pinned];
}

final _catchAllStart = RegExp(
  r'^(alle|alles|keine|keiner|keines|nichts|beide|beides|weder)(\s|$)',
);
final _catchAllRef = RegExp(
  r'(genannt|oben|vorherig|vorgenannt|antwort|aussage|option|davon|'
  r'möglichkeit|beiden|noch|drei|vier|trifft|stimm|richtig|falsch|korrekt)',
);

/// Optionen wie „Alle genannten“, „Keine der Antworten“ oder „Beides“
/// beziehen sich auf die übrigen und gehören deshalb ans Ende.
bool isCatchAllOption(String text) {
  final t = text.trim().toLowerCase().replaceAll(RegExp(r'[.!]+$'), '');
  if (!_catchAllStart.hasMatch(t)) return false;
  final words = t.split(RegExp(r'\s+')).length;
  return words == 1 || (words <= 8 && _catchAllRef.hasMatch(t));
}

final _positional = RegExp(
  r'\b(Antwort(en)?|Option(en)?|Aussage(n)?)\s+[A-H1-9]\b',
);

/// Verweist eine Option auf die Position einer anderen („Antwort A und C“),
/// darf nicht gemischt werden.
bool refersToPosition(Iterable<String> options) =>
    options.any(_positional.hasMatch);

/// Merkt sich je Aufgabe den Zufallswert der Mischung, solange niemand
/// einen `shuffleSeed` vorgibt.
///
/// Wer eine Aufgabe neu beginnt (noch keine Antwort), bekommt eine neue
/// Mischung. Wer zu einer beantworteten Aufgabe zurückblättert oder sie in
/// der Auswertung ansieht, sieht dieselbe Reihenfolge wie beim Antworten -
/// auch wenn die Ansicht dazwischen neu aufgebaut wurde.
class ShuffleSeeds {
  const ShuffleSeeds._();

  static final _byQuestion = <String, int>{};
  static final _random = math.Random();
  static const _capacity = 600;

  static int forQuestion(String questionId, {required bool fresh}) {
    final known = _byQuestion[questionId];
    if (known != null && !fresh) return known;
    final seed = _random.nextInt(0x3FFFFFFF);
    _byQuestion.remove(questionId);
    _byQuestion[questionId] = seed;
    if (_byQuestion.length > _capacity) {
      _byQuestion.remove(_byQuestion.keys.first);
    }
    return seed;
  }
}
