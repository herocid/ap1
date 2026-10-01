import 'package:flutter/foundation.dart';

/// Vereinheitlicht eine getippte Antwort für den Vergleich: Groß-/Klein-
/// schreibung, Umlaut-Schreibweisen, Bindestriche und überzählige
/// Leerzeichen spielen keine Rolle.
String normalizeAnswer(String s) {
  var t = s.trim().toLowerCase();
  const fold = {'ä': 'ae', 'ö': 'oe', 'ü': 'ue', 'ß': 'ss'};
  fold.forEach((k, v) => t = t.replaceAll(k, v));
  t = t.replaceAll(RegExp(r'[\-‐‑–_]'), ' ');
  t = t.replaceAll(RegExp(r'[.,;:!?]+$'), '');
  return t.replaceAll(RegExp(r'\s+'), ' ').trim();
}

/// Liest eine Zahl in deutscher oder englischer Schreibweise
/// ("1.234,5", "1234.5", "12 %", "3,5 GB").
double? parseNumber(String s) {
  var t = s.trim().replaceAll(RegExp(r'[^0-9,.\-]'), '');
  if (t.isEmpty) return null;
  if (t.contains(',') && t.contains('.')) {
    // Das letzte der beiden Zeichen ist das Dezimaltrennzeichen.
    if (t.lastIndexOf(',') > t.lastIndexOf('.')) {
      t = t.replaceAll('.', '').replaceAll(',', '.');
    } else {
      t = t.replaceAll(',', '');
    }
  } else if (t.contains(',')) {
    t = t.replaceAll(',', '.');
  }
  return double.tryParse(t);
}

/// Eine Lücke in einem Lückentext oder eine auszufüllende Tabellenzelle.
///
/// Drei Bedienarten, die sich aus den Daten ergeben:
/// - [options] gefüllt: Auswahl aus einer Liste (Dropdown).
/// - [options] leer und die Aufgabe hat eine Wortbank: Begriff antippen.
/// - sonst: kurze Eingabe (Text oder, mit [numeric], eine Zahl).
@immutable
class Blank {
  const Blank(
    this.answers, {
    this.options = const [],
    this.numeric = false,
    this.tolerance = 0,
    this.unit,
    this.rationale = '',
  });

  /// Zahl als Lösung, z. B. `Blank.zahl(62, unit: 'Hosts')`.
  Blank.zahl(num value, {this.tolerance = 0, this.unit, this.rationale = ''})
    : answers = [_fmt(value)],
      options = const [],
      numeric = true;

  /// Akzeptierte Lösungen; die erste wird als Musterlösung gezeigt.
  final List<String> answers;

  /// Auswahlmöglichkeiten inklusive der richtigen. Reihenfolge egal - die
  /// App mischt.
  final List<String> options;
  final bool numeric;
  final double tolerance;
  final String? unit;

  /// Kurze Begründung, die nach dem Prüfen an der Lücke steht.
  final String rationale;

  String get solution => answers.first;

  bool matches(String? input) {
    if (input == null || input.trim().isEmpty) return false;
    if (numeric) {
      // "1.000" kann eintausend (deutsch) oder eins (englisch) heißen -
      // beide Lesarten gelten, damit niemand an der Schreibweise scheitert.
      final candidates = [
        parseNumber(input),
        if (RegExp(r'^\s*-?\d{1,3}(\.\d{3})+\D*$').hasMatch(input))
          parseNumber(input.replaceAll('.', '')),
      ].whereType<double>();
      return answers.any((a) {
        final w = double.tryParse(a.trim()) ?? parseNumber(a);
        return w != null &&
            candidates.any((v) => (v - w).abs() <= tolerance + 1e-9);
      });
    }
    final n = normalizeAnswer(input);
    return answers.any((a) => normalizeAnswer(a) == n);
  }

  static String _fmt(num v) =>
      v == v.roundToDouble() ? v.round().toString() : v.toString();

  Map<String, dynamic> toJson() => {
    'answers': answers,
    if (options.isNotEmpty) 'options': options,
    if (numeric) 'numeric': true,
    if (tolerance != 0) 'tolerance': tolerance,
    if (unit != null) 'unit': unit,
    if (rationale.isNotEmpty) 'rationale': rationale,
  };

  factory Blank.fromJson(Map<String, dynamic> j) => Blank(
    ((j['answers'] as List?) ?? const []).cast<String>().toList(),
    options: ((j['options'] as List?) ?? const []).cast<String>().toList(),
    numeric: j['numeric'] == true,
    tolerance: (j['tolerance'] as num?)?.toDouble() ?? 0,
    unit: j['unit'] as String?,
    rationale: (j['rationale'] ?? '') as String,
  );
}

/// Zelle einer Tabelle zum Ausfüllen: entweder vorgegebener Text oder eine
/// [Blank], die der Prüfling füllt.
@immutable
class GridCell {
  const GridCell(this.text) : gap = null;
  const GridCell.gap(Blank this.gap) : text = '';

  final String text;
  final Blank? gap;

  bool get isGap => gap != null;

  Map<String, dynamic> toJson() =>
      gap == null ? {'text': text} : {'gap': gap!.toJson()};

  factory GridCell.fromJson(Map<String, dynamic> j) => j['gap'] == null
      ? GridCell((j['text'] ?? '') as String)
      : GridCell.gap(Blank.fromJson((j['gap'] as Map).cast<String, dynamic>()));
}

/// Bewertungskriterium einer Freitext-Aufgabe - so, wie es in den
/// Lösungshinweisen der IHK steht ("je Nennung 1 Punkt").
@immutable
class Criterion {
  const Criterion(this.text, {this.points = 1, this.keywords = const []});

  /// Was in der Antwort stehen muss, als ganzer Satz oder Stichpunkt.
  final String text;
  final int points;

  /// Stichwörter, an denen die App das Kriterium in der getippten Antwort
  /// erkennt (Vorschlag für die Selbstbewertung; ein Treffer genügt).
  final List<String> keywords;

  /// Tolerant gegenüber Wortformen ("verschlüsselt" trifft "Verschlüsselung")
  /// und einzelnen Tippfehlern. Bleibt ein Vorschlag - die Bewertung macht
  /// der Prüfling anhand der Musterlösung selbst.
  bool foundIn(String answer) {
    final n = normalizeAnswer(answer);
    if (n.isEmpty) return false;
    final words = n.split(RegExp(r'[^a-z0-9]+')).where((w) => w.isNotEmpty);
    return keywords.any((k) {
      final key = normalizeAnswer(k);
      if (key.isEmpty) return false;
      if (n.contains(key)) return true;
      // Jedes Wort des Stichworts muss sich in der Antwort wiederfinden.
      final tokens = key
          .split(RegExp(r'[^a-z0-9]+'))
          .where((t) => t.isNotEmpty);
      // Stichwörter nur aus Sonderzeichen (<=) zählen nur bei exaktem Treffer.
      return tokens.isNotEmpty &&
          tokens.every((t) => words.any((w) => _similar(w, t)));
    });
  }

  static bool _similar(String word, String token) {
    if (word == token) return true;
    // Kurze Wörter und Zahlen (TCP, 443, /24) nur exakt.
    if (token.length < 5 || word.length < 4) return false;
    final stem = token.substring(0, (token.length * 0.7).ceil().clamp(4, 99));
    if (word.startsWith(stem)) return true;
    return (word.length - token.length).abs() <= 1 &&
        _distance(word, token) <= 1;
  }

  /// Levenshtein-Abstand, abgebrochen sobald er 1 übersteigt.
  static int _distance(String a, String b) {
    var prev = List<int>.generate(b.length + 1, (i) => i);
    for (var i = 1; i <= a.length; i++) {
      final cur = List<int>.filled(b.length + 1, 0)..[0] = i;
      var best = cur[0];
      for (var j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        cur[j] = [
          prev[j] + 1,
          cur[j - 1] + 1,
          prev[j - 1] + cost,
        ].reduce((x, y) => x < y ? x : y);
        if (cur[j] < best) best = cur[j];
      }
      if (best > 1) return 2;
      prev = cur;
    }
    return prev[b.length];
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'points': points,
    if (keywords.isNotEmpty) 'keywords': keywords,
  };

  factory Criterion.fromJson(Map<String, dynamic> j) => Criterion(
    j['text'] as String,
    points: (j['points'] as num?)?.toInt() ?? 1,
    keywords: ((j['keywords'] as List?) ?? const []).cast<String>().toList(),
  );
}

/// Antwort auf eine Freitext-Aufgabe.
@immutable
class OpenAnswer {
  const OpenAnswer({this.text = '', this.checked});

  /// Die getippte Antwort (darf leer sein, wenn nur im Kopf gelöst wurde).
  final String text;

  /// Vom Prüfling nach Ansicht der Musterlösung abgehakte Kriterien.
  /// `null`: noch nicht selbst bewertet - dann zählt die Stichworterkennung.
  final Set<int>? checked;

  OpenAnswer copyWith({String? text, Set<int>? checked}) =>
      OpenAnswer(text: text ?? this.text, checked: checked ?? this.checked);
}

/// Ein Paar für "Paare finden": Begriff links, Gegenstück rechts.
@immutable
class PairItem {
  const PairItem(this.left, this.right);
  final String left;
  final String right;

  Map<String, dynamic> toJson() => {'left': left, 'right': right};

  factory PairItem.fromJson(Map<String, dynamic> j) =>
      PairItem(j['left'] as String, j['right'] as String);
}
