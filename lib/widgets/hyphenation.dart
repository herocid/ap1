import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Weiche Trennstelle (U+00AD) - unsichtbar, solange nicht getrennt wird.
final _shy = String.fromCharCode(0x00AD);

/// Unsichtbare Umbruchstelle (U+200B) ohne Trennstrich.
final kZeroWidthSpace = String.fromCharCode(0x200B);
String get _zwsp => kZeroWidthSpace;

/// Text mit Silbentrennung und sichtbarem Trennstrich.
///
/// Wie [Text], aber lange Wörter werden über [hyphenate] an Silbengrenzen
/// getrennt - und genau dort, wo tatsächlich umbrochen wird, steht ein „-“.
/// (Flutter bricht an weichen Trennstellen zwar um, zeichnet den Strich aber
/// nicht.) [prefix] steht ungetrennt davor, z. B. „Idee: “.
///
/// Der Text wächst immer auf die nötige Höhe - es gibt kein `maxLines`.
class HyphenText extends StatelessWidget {
  const HyphenText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.prefix,
    this.prefixStyle,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String? prefix;
  final TextStyle? prefixStyle;

  @override
  Widget build(BuildContext context) {
    final defaults = DefaultTextStyle.of(context);
    var effective = style == null || style!.inherit
        ? defaults.style.merge(style)
        : style!;
    if (MediaQuery.boldTextOf(context)) {
      effective = effective.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    return _HyphenTextLeaf(
      source: TextSpan(
        style: effective,
        children: [
          if (prefix != null) TextSpan(text: prefix, style: prefixStyle),
          TextSpan(text: hyphenate(text)),
        ],
      ),
      textAlign: textAlign ?? defaults.textAlign ?? TextAlign.start,
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      locale: Localizations.maybeLocaleOf(context),
    );
  }
}

class _HyphenTextLeaf extends LeafRenderObjectWidget {
  const _HyphenTextLeaf({
    required this.source,
    required this.textAlign,
    required this.textDirection,
    required this.textScaler,
    this.locale,
  });

  final InlineSpan source;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final TextScaler textScaler;
  final Locale? locale;

  @override
  RenderHyphenText createRenderObject(BuildContext context) => RenderHyphenText(
    source: source,
    textAlign: textAlign,
    textDirection: textDirection,
    textScaler: textScaler,
    locale: locale,
  );

  @override
  void updateRenderObject(BuildContext context, RenderHyphenText ro) {
    ro.configure(
      source: source,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaler: textScaler,
      locale: locale,
    );
  }
}

/// Zeichnet [HyphenText]. Öffentlich nur, damit die Layout-Tests prüfen
/// können, ob der Text vollständig sichtbar ist.
class RenderHyphenText extends RenderBox {
  RenderHyphenText({
    required InlineSpan source,
    required TextAlign textAlign,
    required TextDirection textDirection,
    required TextScaler textScaler,
    Locale? locale,
  }) : _source = source,
       _textAlign = textAlign,
       _textDirection = textDirection,
       _textScaler = textScaler,
       _locale = locale;

  InlineSpan _source;
  TextAlign _textAlign;
  TextDirection _textDirection;
  TextScaler _textScaler;
  Locale? _locale;

  final TextPainter _painter = TextPainter();
  double? _laidOutFor;

  void configure({
    required InlineSpan source,
    required TextAlign textAlign,
    required TextDirection textDirection,
    required TextScaler textScaler,
    Locale? locale,
  }) {
    final changed =
        _source.compareTo(source) != RenderComparison.identical ||
        textAlign != _textAlign ||
        textDirection != _textDirection ||
        textScaler != _textScaler ||
        locale != _locale;
    if (!changed) return;
    _source = source;
    _textAlign = textAlign;
    _textDirection = textDirection;
    _textScaler = textScaler;
    _locale = locale;
    _laidOutFor = null;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  /// Der sichtbare Text ohne Trennhilfen - für Semantik und Tests.
  String get plainText => _source
      .toPlainText(includeSemanticsLabels: false)
      .replaceAll(_shy, '')
      .replaceAll(_zwsp, '');

  /// Breite des längsten nicht trennbaren Stücks. Ist sie größer als die
  /// Breite des Texts, bricht Flutter mitten im Wort um.
  double get widestUnbreakable {
    // `minIntrinsicWidth` übersieht weiche Trennstellen, wenn der Text nur
    // aus einem Wort besteht. Deshalb die Stücke zwischen allen
    // Umbruchstellen einzeln messen (vor einer Trennstelle mit Strich).
    final plain = _source.toPlainText(includeSemanticsLabels: false);
    final pieces = <String>[];
    final b = StringBuffer();
    for (final ch in plain.split('')) {
      if (ch.trim().isEmpty || ch == _zwsp) {
        pieces.add(b.toString());
        b.clear();
      } else if (ch == _shy) {
        pieces.add('$b-');
        b.clear();
      } else {
        b.write(ch);
        if (ch == '-') {
          pieces.add(b.toString());
          b.clear();
        }
      }
    }
    pieces.add(b.toString());
    var w = 0.0;
    for (final piece in pieces.toSet()) {
      if (piece.isEmpty) continue;
      final p = _measure(TextSpan(text: piece, style: _source.style))..layout();
      if (p.width > w) w = p.width;
      p.dispose();
    }
    return w;
  }

  /// Höhe, die der Text braucht - größer als [size], wenn ihn jemand mit
  /// fester Höhe beschneidet.
  double get neededHeight => _painter.height;

  /// Der tatsächlich gesetzte Text inklusive eingefügter Trennstriche.
  @visibleForTesting
  String get debugPainted =>
      _painter.text?.toPlainText(includeSemanticsLabels: false) ?? '';

  /// True, wenn jeder eingefügte Trennstrich am Ende einer Zeile steht.
  @visibleForTesting
  bool get debugDashesAtLineEnds {
    final text = debugPainted;
    final ends = <int>{};
    var start = 0;
    while (start < text.length) {
      final line = _painter.getLineBoundary(TextPosition(offset: start));
      if (line.end <= start) break;
      ends.add(line.end);
      start = line.end;
    }
    for (var i = 0; i < text.length - 1; i++) {
      if (text[i] == '-' && text[i + 1] == _zwsp && !ends.contains(i + 2)) {
        return false;
      }
    }
    return true;
  }

  TextPainter _measure(InlineSpan span) => TextPainter(
    text: span,
    textAlign: _textAlign,
    textDirection: _textDirection,
    textScaler: _textScaler,
    locale: _locale,
  );

  void _layoutFor(double maxWidth) {
    if (_laidOutFor == maxWidth) return;
    _painter
      ..text = _withVisibleHyphens(maxWidth)
      ..textAlign = _textAlign
      ..textDirection = _textDirection
      ..textScaler = _textScaler
      ..locale = _locale
      ..layout(maxWidth: maxWidth);
    _laidOutFor = maxWidth;
  }

  /// Ersetzt die weichen Trennstellen, an denen eine Zeile endet, durch
  /// einen echten Strich.
  InlineSpan _withVisibleHyphens(double width) {
    final plain = _source.toPlainText(includeSemanticsLabels: false);
    if (!width.isFinite || !plain.contains(_shy)) return _source;

    // Ein eingefügter Strich verändert den Umbruch der Zeile. Deshalb
    // setzen, nachsehen, wo die Zeilen wirklich enden, und wiederholen, bis
    // jeder Strich genau am Zeilenende steht (meist nach ein, zwei Runden).
    var breaks = <int>{};
    var span = _source;
    for (var round = 0; round < 5; round++) {
      final actual = _lineEndBreaks(span, breaks, width);
      if (actual.length == breaks.length && actual.containsAll(breaks)) break;
      breaks = actual;
      span = _insertDashes(breaks);
    }
    // Sicherheitsnetz: Steht ein Strich nicht am Zeilenende, lieber ganz
    // ohne sichtbare Striche setzen als mit einem Strich mitten im Wort.
    final check = _lineEndBreaks(span, breaks, width);
    if (!(check.length == breaks.length && check.containsAll(breaks))) {
      return _source;
    }
    return span;
  }

  /// Quelltext-Positionen der weichen Trennstellen, an denen im gesetzten
  /// [span] (mit Strichen an [breaks]) tatsächlich eine Zeile endet.
  Set<int> _lineEndBreaks(InlineSpan span, Set<int> breaks, double width) {
    final text = span.toPlainText(includeSemanticsLabels: false);
    final painter = _measure(span)..layout(maxWidth: width);
    // Position im gesetzten Text -> Position im Quelltext.
    final sorted = breaks.toList()..sort();
    int toSource(int i) {
      var shift = 0;
      for (final b in sorted) {
        if (b + shift < i - 1) shift++;
      }
      return i - shift;
    }

    final out = <int>{};
    var start = 0;
    while (start < text.length) {
      final line = painter.getLineBoundary(TextPosition(offset: start));
      if (line.end <= start) break;
      final end = line.end;
      if (end < text.length) {
        if (text[end - 1] == _shy) {
          out.add(toSource(end - 1));
        } else if (end >= 2 && text[end - 1] == _zwsp && text[end - 2] == '-') {
          final src = toSource(end - 2);
          if (breaks.contains(src)) out.add(src);
        }
      }
      start = end;
    }
    painter.dispose();
    return out;
  }

  InlineSpan _insertDashes(Set<int> breaks) {
    if (breaks.isEmpty) return _source;
    var offset = 0;
    InlineSpan rebuild(InlineSpan span) {
      if (span is! TextSpan) return span;
      var t = span.text;
      if (t != null) {
        final b = StringBuffer();
        for (var i = 0; i < t.length; i++) {
          b.write(breaks.contains(offset + i) ? '-$_zwsp' : t[i]);
        }
        offset += t.length;
        t = b.toString();
      }
      return TextSpan(
        text: t,
        style: span.style,
        children: span.children?.map(rebuild).toList(),
      );
    }

    return rebuild(_source);
  }

  @override
  double computeMinIntrinsicWidth(double height) => widestUnbreakable;

  @override
  double computeMaxIntrinsicWidth(double height) {
    final p = _measure(_source)..layout();
    final w = p.maxIntrinsicWidth;
    p.dispose();
    return w;
  }

  double _heightFor(double width) {
    final p = _measure(_withVisibleHyphens(width))..layout(maxWidth: width);
    final h = p.height;
    p.dispose();
    return h;
  }

  @override
  double computeMinIntrinsicHeight(double width) => _heightFor(width);

  @override
  double computeMaxIntrinsicHeight(double width) => _heightFor(width);

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final p = _measure(_withVisibleHyphens(constraints.maxWidth))
      ..layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
    final s = constraints.constrain(p.size);
    p.dispose();
    return s;
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    _layoutFor(constraints.maxWidth);
    return _painter.computeDistanceToActualBaseline(baseline);
  }

  @override
  void performLayout() {
    _layoutFor(constraints.maxWidth);
    size = constraints.constrain(_painter.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _painter.paint(context.canvas, offset);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..label = plainText
      ..textDirection = _textDirection;
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }
}

/// Silbentrennung für lange deutsche Wörter.
///
/// Flutter trennt nicht selbst. Passt ein langes Kompositum wie
/// „Eintrittswahrscheinlichkeit“ nicht in die Zeile, bricht es irgendwo
/// mitten im Wort um - auf 320 px mit großer Schrift sieht das aus, als sei
/// der Text abgeschnitten. [hyphenate] setzt deshalb weiche Trennstellen
/// (U+00AD) an Silbengrenzen. Sie sind unsichtbar, solange das Wort passt.
///
/// Lange Zeichenketten ohne Leerzeichen (URLs, IPv6-Adressen,
/// `objekt.methode(...)`, „Lessons-Learned-Workshop“) bekommen nach `-`,
/// `/`, `:`, `.` und `_` eine unsichtbare Umbruchstelle (U+200B).
///
/// Die Regeln sind die klassischen Schulregeln (ein Konsonant geht in die
/// nächste Silbe, von mehreren nur der letzte; „ch“, „ck“, „sch“, „ph“ und
/// typische Anlaute wie „tr“, „schr“, „st“ bleiben zusammen). Das trifft
/// nicht jede Wörterbuchtrennung, aber immer eine lesbare Stelle.
String hyphenate(String text) {
  if (text.length < 12) return text;
  final out = text.replaceAllMapped(_longToken, (m) {
    final token = m[0]!;
    if (!_breakChars.hasMatch(token)) return token;
    // Nach dem letzten Zeichen braucht es keine Umbruchstelle.
    return token.replaceAllMapped(
      _breakAfter,
      (b) => b.end == token.length ? b[0]! : '${b[0]}$_zwsp',
    );
  });
  return out.replaceAllMapped(_longWord, (m) => _hyphenateWord(m[0]!));
}

final _longToken = RegExp(r'[^\s]{16,}');
final _breakChars = RegExp(r'[-/:._]');
final _breakAfter = RegExp(r'[-/:._]+');
final _longWord = RegExp(r'[A-Za-zÄÖÜäöüß]{12,}');

const _vowels = 'aeiouyäöü';

/// Anlaute, die zusammen in die nächste Silbe wandern. Längste zuerst.
const _onsets = [
  'schl', 'schm', 'schn', 'schr', 'schw', 'spr', 'str', 'sch', //
  'bl', 'br', 'ch', 'ck', 'dr', 'fl', 'fr', 'gl', 'gr', 'kl', 'kn', 'kr',
  'ph', 'pf', 'pl', 'pr', 'qu', 'sp', 'st', 'th', 'tr', 'zw',
];

/// Wortenden mit Fugen-s, nach denen ein neues Wort beginnt.
const _fugen = [
  'ungs',
  'heits',
  'keits',
  'schafts',
  'ions',
  'ings',
  'tums',
  'ts',
];

/// Mindestens so viele Buchstaben bleiben nach einer Trennung.
const _minPart = 3;

String _hyphenateWord(String word) {
  final lower = word.toLowerCase();
  bool isVowel(int i) => _vowels.contains(lower[i]);

  final breaks = <int>[];
  var i = 0;
  // Zum ersten Vokal.
  while (i < lower.length && !isVowel(i)) {
    i++;
  }
  while (i < lower.length) {
    // Vokalgruppe überspringen (Diphthonge und Doppelvokale bleiben ganz).
    while (i < lower.length && isVowel(i)) {
      i++;
    }
    final start = i;
    while (i < lower.length && !isVowel(i)) {
      i++;
    }
    if (i >= lower.length) break; // Endkonsonanten - keine Silbe mehr.
    final cluster = lower.substring(start, i);
    if (cluster.isEmpty) continue;

    var cut = start + cluster.length - 1; // vor dem letzten Konsonanten
    for (final o in _onsets) {
      if (cluster.length >= o.length && cluster.endsWith(o)) {
        cut = start + cluster.length - o.length;
        break;
      }
    }
    // Fugen-s vor einem Vokal: Das nächste Wort des Kompositums beginnt mit
    // dem Vokal („Zahlungs-art“, „Sicherheits-aspekt“, nicht „Zahlung-sart“).
    final head = lower.substring(0, i);
    if (_fugen.any(head.endsWith)) cut = i;
    // „ck“ wird heute vor dem c getrennt (Zu-cker), „ch“/„sch“ nie geteilt.
    // Vorn reichen zwei Buchstaben („An-schaf-fung“), hinten drei.
    if (cut >= 2 && word.length - cut >= _minPart) breaks.add(cut);
  }
  if (breaks.isEmpty) return word;

  final b = StringBuffer();
  var last = 0;
  for (final cut in breaks) {
    b
      ..write(word.substring(last, cut))
      ..write(_shy);
    last = cut;
  }
  b.write(word.substring(last));
  return b.toString();
}
