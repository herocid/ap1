import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Weiche Trennstelle (U+00AD) - unsichtbar, solange nicht getrennt wird.
final _shy = String.fromCharCode(0x00AD);

/// Wortverbinder (U+2060): unsichtbar und ohne Umbruchmöglichkeit - ersetzt
/// eine weiche Trennstelle, an der nicht getrennt werden darf.
final _noBreak = String.fromCharCode(0x2060);

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
      // An einem harten Zeilenumbruch liefert die Abfrage dieselbe Zeile noch
      // einmal - dann ein Zeichen weitergehen statt abzubrechen.
      if (line.end <= start) {
        start++;
        continue;
      }
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

  /// Anzahl der Zeilen, die an einer weichen Trennstelle enden, ohne dass
  /// dort ein Strich steht (mitten im Wort umbrochen).
  @visibleForTesting
  int get debugUndashedBreaks {
    final text = debugPainted;
    var count = 0;
    var start = 0;
    while (start < text.length) {
      final line = _painter.getLineBoundary(TextPosition(offset: start));
      // An einem harten Zeilenumbruch liefert die Abfrage dieselbe Zeile noch
      // einmal - dann ein Zeichen weitergehen statt abzubrechen.
      if (line.end <= start) {
        start++;
        continue;
      }
      if (line.end < text.length && text[line.end - 1] == _shy) count++;
      start = line.end;
    }
    return count;
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
    //
    // Von oben nach unten, je Runde eine Trennstelle: Die oberste Zeile, die
    // an einer weichen Trennstelle ohne Strich endet, bekommt ihren Strich.
    // Passt er nicht mehr in die Zeile, rückt der Umbruch an die Stelle
    // davor. So steht nie ein Strich mitten in der Zeile, und das Verfahren
    // endet immer (jede Runde legt eine Stelle fest oder schließt eine aus).
    final fixed = <int>{};
    // Trennstellen, an denen der Strich nicht mehr in die Zeile passt: Dort
    // darf gar nicht umbrochen werden, das Wortstück rutscht in die nächste
    // Zeile oder die Zeile endet an der Trennstelle davor.
    final blocked = <int>{};
    final limit = _shy.allMatches(plain).length + 2;
    for (var round = 0; round < limit; round++) {
      final actual = _lineEndBreaks(
        _insertDashes(fixed, blocked),
        fixed,
        width,
      );
      fixed.removeWhere((b) => !actual.contains(b));
      final missing = actual.where((b) => !fixed.contains(b)).toList()..sort();
      if (missing.isEmpty) break;
      final s = missing.first;
      final trial = {...fixed, s};
      final after = _lineEndBreaks(_insertDashes(trial, blocked), trial, width);
      if (after.contains(s)) {
        fixed.add(s);
      } else {
        blocked.add(s);
      }
    }
    // Zum Schluss nur Striche behalten, die wirklich am Zeilenende stehen.
    for (var i = 0; i < 3; i++) {
      final check = _lineEndBreaks(_insertDashes(fixed, blocked), fixed, width);
      if (check.containsAll(fixed)) break;
      fixed.removeWhere((b) => !check.contains(b));
    }
    return _insertDashes(fixed, blocked);
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
      // An einem harten Zeilenumbruch liefert die Abfrage dieselbe Zeile noch
      // einmal - dann ein Zeichen weitergehen statt abzubrechen.
      if (line.end <= start) {
        start++;
        continue;
      }
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

  InlineSpan _insertDashes(Set<int> breaks, [Set<int> blocked = const {}]) {
    if (breaks.isEmpty && blocked.isEmpty) return _source;
    var offset = 0;
    InlineSpan rebuild(InlineSpan span) {
      if (span is! TextSpan) return span;
      var t = span.text;
      if (t != null) {
        final b = StringBuffer();
        for (var i = 0; i < t.length; i++) {
          final at = offset + i;
          b.write(
            breaks.contains(at)
                ? '-$_zwsp'
                : blocked.contains(at)
                ? _noBreak
                : t[i],
          );
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
/// Die Regeln sind die amtlichen Trennregeln, soweit sie sich ohne Wörterbuch
/// umsetzen lassen: Ein Konsonant geht in die nächste Silbe, von mehreren nur
/// der letzte. Auch „st“ wird getrennt („Mus-ter“, „Kas-ten“, „Fens-ter“);
/// „ch“, „ck“, „sch“, „ph“ und Anlaute wie „tr“, „schr“, „pfl“ bleiben
/// zusammen. Zusammensetzungen und Vorsilben werden an der Wortfuge getrennt,
/// wenn der zweite Teil mit einem bekannten Wortstamm beginnt
/// („Daten-über-tra-gung“, „Be-stand-teil“, „Test-ab-de-ckung“). Das trifft
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
/// „st“ und „str“ fehlen bewusst: Seit der Rechtschreibreform wird „st“
/// getrennt („Kos-ten“, „Indus-trie“). Wo ein Wortteil mit „st“ beginnt,
/// greift [_stStems].
const _onsets = [
  'schl', 'schm', 'schn', 'schr', 'schw', 'spl', 'spr', 'pfl', 'pfr', 'sch', //
  'bl', 'br', 'ch', 'ck', 'dr', 'fl', 'fr', 'gl', 'gr', 'kl', 'kn', 'kr',
  'ph', 'pl', 'pr', 'sp', 'th', 'tr', 'zw',
];

/// Wortstämme mit „st“ am Anfang. Vor ihnen liegt eine Wortfuge, dort bleibt
/// „st“ zusammen („Be-stand“, „Kosten-stelle“, „Ver-ständnis“).
const _stStems = [
  'staat', 'staben', 'stabil', 'stabs', 'stack', 'stadt', 'städt', 'stalt', //
  'stamm', 'stand', 'ständ', 'stang', 'stapel', 'stark', 'stärk', 'start',
  'stati', 'statt', 'stätt', 'status', 'statut', 'stauch', 'steck', 'steh',
  'stehl', 'steig', 'stein', 'stell', 'steuer', 'stich', 'stieg', 'stift',
  'stil', 'stimm', 'stoff', 'stohl', 'stopp', 'stör', 'storm', 'stoß', 'stöß',
  'straf', 'strahl', 'strang', 'sträng', 'straß', 'strateg', 'stream',
  'streb', 'streck', 'streich', 'streif', 'streit', 'stress', 'strich',
  'strick', 'string', 'stritt', 'strom', 'ström', 'strukt', 'stück', 'studi',
  'stuf', 'stund', 'stünd', 'sturz', 'stütz',
];

/// Wörter auf „st“, hinter denen oft ein Vokal folgt („Test-art“). Nach
/// ihnen gilt [_stStems] nicht - sonst würde aus „Testarten“ „Te-starten“.
const _stEnders = [
  'test', 'dienst', 'last', 'frist', 'kunst', 'post', 'selbst', //
];

/// Wörter auf „st“, nach denen ein „r“ zum nächsten Wort gehört
/// („Mindest-rechte“, „Dienst-reise“ - aber „Indus-trie“).
const _stBeforeR = [
  'test', 'dienst', 'last', 'frist', 'kunst', 'mindest', 'höchst', //
];

/// Wortstämme mit Konsonant am Anfang, die sonst falsch zerlegt würden:
/// „Zugriffs-pfad“ (sonst wird „pf“ im Wortinnern getrennt: „Emp-fänger“),
/// „Netzwerk-skizze“, „Wirk-leistung“, „Stab-linien“, „Wissens-check“.
const _consStems = [
  'pfad', 'pfand', 'pfänd', 'pfeil', 'skizz', 'skalier', 'szenar', 'sphär', //
  'leistung', 'linien', 'laser', 'scan', 'check', 'chance',
];

/// Wortstämme mit „r“ am Anfang. Davor sind „tr“, „dr“, „gr“ kein Anlaut:
/// „Projekt-rahmen“, „Passwort-regeln“, „Prozent-rechnung“.
const _rStems = [
  'rahmen', 'risik', 'regel', 'richtlin', 'richtung', 'richtwert', 'refer', //
  'reform', 'reihen', 'reichend', 'reichweit', 'recht', 'rechn', 'rechen',
];

/// Wortstämme mit „sp“ am Anfang („Bei-spiel“, „Ent-sprechung“). Sonst
/// gehört das „s“ nach vorn: „Ausweis-prüfung“, „Bonus-programm“,
/// „Gesprächs-partner“, „As-pekt“.
const _spStems = [
  'späh', 'spalt', 'spam', 'spann', 'spare', 'sparm', 'sparn', 'sparp', //
  'spars', 'sparu', 'spät', 'spedit', 'speich', 'speis', 'spekt', 'spend',
  'sperr', 'spezi', 'spiegel', 'spiel', 'spitz', 'split', 'spoof', 'sporn',
  'sprach', 'spräch', 'sprech', 'sprich', 'spring', 'sprint', 'sproch',
  'spruch', 'sprüch', 'sprung', 'sprüng', 'spule', 'spur', 'spür',
];

/// Mit diesen Stämmen beginnt nach „b“, „f“, „g“, „k“ oder „sch“ ein neuer
/// Wortteil („erheb-lich“, „mög-lich“, „Wunsch-liste“, „Deutsch-land“) -
/// „bl“, „gl“, „schl“ sind dann kein Anlaut.
const _lStems = [
  'lich', 'land', 'list', 'liefer', 'läng', 'lings', 'losig', //
];

/// Wie [_lStems], aber nicht nach „g“ („Klinik-leitung“, „Ab-leitung“ -
/// aber „Be-gleitung“).
const _leitStems = ['leit'];

/// Nach „sch“ beginnt mit diesen Stämmen ein neuer Wortteil
/// („Lösch-weitergabe“), „schw“ ist dann kein Anlaut.
const _wStems = ['weiter', 'wunsch', 'wert'];

/// Echte Anlaute mit „zw“ („Ver-zweigung“, „Schutz-zweck“). Sonst gehört
/// das „z“ nach vorn: „Netz-werk“, „Grenz-wert“.
const _zwStems = ['zwei', 'zwang', 'zwäng', 'zwing', 'zweck', 'zwisch'];

/// Wortstämme mit „h“ am Anfang: Davor wird „th“ getrennt („Gut-haben“,
/// „Ent-haltung“), sonst bleibt es zusammen („Me-thode“).
const _hStems = [
  'hab', 'halt', 'hält', 'hilf', 'haft', 'heit', 'hoch', 'haus', 'häuf', //
  'hand',
];

/// Wortstämme mit „s“ am Anfang: Das „s“ nach einem „t“ ist dann kein
/// Fugen-s („Echtzeit-system“, „tat-sächlich“, nicht „Echtzeits-ystem“).
const _sStems = [
  'sach', 'säch', 'saldo', 'samk', 'sammel', 'sammlung', 'sanier', 'segment', //
  'seit', 'sektor', 'selekt', 'sende', 'sensor', 'serie', 'server', 'session',
  'sicher', 'sicht', 'sign', 'simul', 'situation', 'sitz', 'software',
  'sonder', 'sorg', 'sortier', 'suche', 'summe', 'support', 'synchron',
  'system',
];

/// Wortstämme mit Vokal am Anfang. Vor ihnen liegt eine Wortfuge - ohne
/// diese Liste zöge die Grundregel den Konsonanten davor mit in die Silbe
/// („Date-nübertragung“, „Ve-rarbeitung“). Bewusst nur Stämme, die kaum
/// zufällig in anderen Wörtern stecken.
const _vowelStems = [
  // a
  'abbau', 'abbild', 'abbruch', 'abdeck', 'abdruck', 'abfluss', 'abfolge', //
  'abfrage', 'abgabe', 'abgleich', 'abgrenz', 'abhäng', 'abkürz', 'ablage',
  'ablauf', 'abläuf', 'ablehn', 'abmahn', 'abnahme', 'abrech', 'abruf',
  'absatz', 'abschalt', 'abschätz', 'abschluss', 'abschnitt', 'abschreib',
  'absender', 'absicher', 'absicht', 'absprache', 'abstand', 'abständ',
  'abstimm', 'abstreit', 'absturz', 'abteil', 'abwäg', 'abweich', 'abwesen',
  'abwick', 'abzug', 'admin', 'adress', 'aggregat', 'ähnlich', 'akquis',
  'aktual', 'akust', 'akzept', 'alarm', 'allgemein', 'alltag', 'alternat',
  'analys', 'anbiet', 'anbind', 'änderung', 'anfäll', 'anfang', 'anforder',
  'anfrage', 'angabe', 'angebot', 'angemess', 'angestellt', 'angriff',
  'anhang', 'anhäng', 'anlage', 'anlass', 'anlauf', 'anleit', 'anmeld',
  'annahme', 'anomal', 'anordn', 'anpass', 'anruf', 'ansatz', 'anschaff',
  'anschau', 'anschlag', 'anschläg', 'anschluss', 'anschlüss', 'anschrift',
  'ansicht', 'ansprech', 'anspruch', 'ansprüch', 'anstalt', 'anstand',
  'anstieg', 'anteil', 'antrag', 'anträg', 'antwort', 'anweis', 'anwend',
  'anwesen', 'anzahl', 'anzeig', 'applik', 'arbeit', 'architekt', 'archiv',
  'argument', 'artig', 'artikel', 'arzt', 'ärzt', 'aspekt', 'assist',
  'attribut', 'audit', 'aufbau', 'aufbewahr', 'aufforder', 'aufgabe',
  'aufklär', 'aufkomm', 'auflist', 'auflös', 'aufnahme', 'aufruf', 'aufsicht',
  'aufstell', 'aufteil', 'auftrag', 'aufträg', 'auftritt', 'aufwand',
  'aufwänd', 'aufwend', 'aufzeich', 'ausbau', 'ausbild', 'ausdruck',
  'ausfall', 'ausfäll', 'ausführ', 'ausfüll', 'ausgabe', 'ausgang', 'ausgäng',
  'ausgleich', 'auskunft', 'auslage', 'auslast', 'auslauf', 'ausleucht',
  'ausnahme', 'ausnutz', 'ausricht', 'ausrüst', 'aussage', 'ausschluss',
  'ausschreib', 'aussetz', 'aussicht', 'ausstatt', 'austausch', 'ausüb',
  'auswahl', 'ausweis', 'ausweit', 'auswert', 'auswirk', 'auszahl', 'auszug',
  'authent', 'autom', 'autor',
  // e
  'effekt', 'effizi', 'eigenschaft', 'eign', 'einander', 'einbar', 'einbau', //
  'einbind', 'einblick', 'einbruch', 'eindeutig', 'eindring', 'einfach',
  'einfluss', 'einfüg', 'einführ', 'eingabe', 'eingang', 'eingäng',
  'einglied', 'eingriff', 'einhalt', 'einheit', 'einigung', 'einkauf',
  'einlad', 'einleit', 'einnahme', 'einricht', 'einsatz', 'einsätz',
  'einschalt', 'einschätz', 'einschränk', 'einsicht', 'einspar', 'einspiel',
  'einstell', 'einteil', 'eintrag', 'einträg', 'eintritt', 'einwand',
  'einwänd', 'einweis', 'einwillig', 'einzel', 'elektr', 'element', 'empfang',
  'empfäng', 'empfehl', 'empfind', 'energie', 'entfern', 'entgelt',
  'entscheid', 'entsorg', 'entsprech', 'entsteh', 'entwick', 'entwurf',
  'entwürf', 'eröffn', 'europ', 'exempl', 'experte', 'export', 'extern',
  // i
  'identif', 'identit', 'inbetrieb', 'index', 'indikat', 'inform', 'infra', //
  'inhab', 'inhalt', 'initial', 'initiat', 'inklus', 'inspekt', 'install',
  'instand', 'instanz', 'instru', 'integr', 'intensi', 'interes', 'interf',
  'intern', 'interp', 'interv', 'intuit', 'inventar', 'inventur', 'invest',
  // o
  'oberfl', 'obergrenz', 'oberkant', 'objekt', 'offenbar', 'öffentl', //
  'offlin', 'ökolog', 'ökonom', 'oligopol', 'online', 'operat', 'optim',
  'option', 'ordner', 'ordnung', 'organe', 'organi', 'organs', 'orient',
  'origin',
  // u
  'über', 'üblich', 'übung', 'umbau', 'umbruch', 'umfang', 'umfrage', //
  'umgebung', 'umkehr', 'umlage', 'umlauf', 'umrechn', 'umsatz', 'umsätz',
  'umschalt', 'umsetz', 'umstell', 'umwand', 'umwelt', 'umzug', 'unabhäng',
  'unter', 'update', 'upload', 'urheber', 'urkund', 'urlaub', 'ursache',
  'ursprung', 'urteil',
];

/// Stämme mit der Vorsilbe „er“. Sie stecken auch zufällig in Wörtern
/// („Verfahren“, „Lagerfahrzeug“) und gelten deshalb nur nach einem
/// Wortende, das eine Fuge nahelegt (siehe [_erHeads]).
const _erStems = [
  'ereignis', 'erfahr', 'erfass', 'erfolg', 'erfüll', 'ergänz', 'ergebnis', //
  'erheb', 'erhöh', 'erinner', 'erkenn', 'erklär', 'erlaub', 'erläuter',
  'erleb', 'ermittl', 'erreich', 'ersatz', 'erspar', 'erstatt', 'erstellt',
  'erstellung', 'erteil', 'ertrag', 'erträg', 'erwart', 'erweiter', 'erwerb',
  'erzeug',
];
const _erHeads = [
  's', 'n', 'l', 'er', 'kt', 'rt', 'samt', 'nach', 'rück', 'schutz', //
  'scherz', 'budget', 'sprach', 'such', 'wunsch', 'text', 'zeit', 'strom',
  'markt', ..._stEnders,
];

/// Vorsilben der [_vowelStems]: Hinter ihnen liegt ebenfalls eine Fuge
/// („Auf-lösung“, „Ab-lauf“, „Ab-rechnung“ - sonst zöge „fl“, „bl“ oder
/// „br“ als Anlaut in die nächste Silbe). Längste zuerst.
const _stemPrefixes = [
  'unter', 'über', 'auf', 'aus', 'ein', 'ent', 'emp', 'ab', 'an', 'um', 'ur', //
];

/// Stämme, die nur scheinbar mit einer Vorsilbe beginnen („Ana-lyse“).
const _noPrefix = [
  'analys', 'anomal', 'antwort', 'einigung', 'einzel', 'einander', //
];

/// Zwei Vokale, die zusammen einen Laut bilden. Zwischen ihnen beginnt kein
/// Wortstamm („Kleinbetrieb“ enthält keine „Inbetriebnahme“).
const _diphthongs = ['ai', 'ei', 'au', 'eu', 'äu', 'ie'];

/// Wortenden, nach denen trotzdem ein Vokalstamm folgen kann
/// („Be-urteilung“, „Software-update“, „Energie-effizienz“).
const _openHeads = [
  'be', 'ge', 're', 'de', 'te', 'ne', 'ie', 'ei', 'eu', 'au', //
];

/// Wortenden, deren Fugen-s immer zum ersten Wort gehört (Wörter auf
/// „-ung“, „-heit“, „-ion“ … bekommen in Zusammensetzungen stets ein „s“):
/// „Zahlungs-art“, „Integritäts-prüfung“, „Verarbeitungs-tätigkeit“.
const _fugenAlways = [
  'ungs', 'heits', 'keits', 'schafts', 'ions', 'tums', 'täts', //
];

/// Wortenden, deren Fugen-s vor einem Konsonanten meist zum ersten Wort
/// gehört („Arbeits-paket“, „Verkaufs-preis“) - außer es folgt „stell“
/// („Antrag-steller“).
const _fugenWeak = [
  'arbeits', 'triebs', 'trags', 'gangs', 'darfs', 'schäfts', 'kaufs', 'bots', //
];

/// Mindestens so viele Buchstaben bleiben nach einer Trennung.
const _minPart = 3;

/// Schon getrennte Wörter - dieselben Wörter kommen in jedem Neuaufbau
/// wieder vor, der Wortschatz der App ist überschaubar.
final _wordCache = <String, String>{};

String _hyphenateWord(String word) =>
    _wordCache[word] ??= _computeHyphenation(word);

String _computeHyphenation(String word) {
  final lower = word.toLowerCase();
  final n = lower.length;
  bool isVowel(int i) => _vowels.contains(lower[i]);
  bool startsAt(List<String> stems, int p) =>
      stems.any((s) => lower.startsWith(s, p));

  // Wortfugen: Stellen, an denen sicher ein neuer Wortteil beginnt. Sie
  // gehen der Silbenregel vor.
  final fugen = <int>{};
  // Vorsilben am Wortanfang: „Trans-port“, „Ver-antwortung“, „Vor-aussetzung“.
  if (lower.startsWith('trans')) fugen.add(5);
  if ((lower.startsWith('ver') || lower.startsWith('vor')) &&
      'aeouäöü'.contains(lower[3])) {
    fugen.add(3);
  }
  // Fuge hinter der Vorsilbe des Stamms, der bei [p] beginnt.
  void prefixFuge(int p) {
    if (startsAt(_noPrefix, p)) return;
    for (final pre in _stemPrefixes) {
      if (lower.startsWith(pre, p)) {
        fugen.add(p + pre.length);
        return;
      }
    }
  }

  // Erster Vokal: Vor einer Fuge muss schon eine Silbe stehen („Pl-anteil“
  // gibt es nicht).
  var first = 0;
  while (first < n && !isVowel(first)) {
    first++;
  }
  final from = first + 1 < 2 ? 2 : first + 1;

  // 1. Wortteile, die mit einem Vokal beginnen.
  if (startsAt(_vowelStems, 0)) prefixFuge(0);
  for (var p = from; p <= n - _minPart; p++) {
    if (!isVowel(p)) continue;
    final head = lower.substring(0, p);
    if (isVowel(p - 1) &&
        _diphthongs.contains(lower.substring(p - 1, p + 1)) &&
        !_openHeads.any(head.endsWith)) {
      continue;
    }
    if (startsAt(_vowelStems, p)) {
      // „Allgemeinheit“, „Kleinheit“ und „Alleinstellung“ enthalten kein
      // Wort mit der Vorsilbe „ein“.
      final ein =
          lower.startsWith('ein', p) &&
          (head.endsWith('gem') || head.endsWith('kl') || head == 'all');
      if (!ein) {
        fugen.add(p);
        prefixFuge(p);
      }
    } else if (startsAt(_erStems, p)) {
      if (_erHeads.any(head.endsWith)) {
        fugen.add(p);
        fugen.add(p + 2);
      }
    } else if (lower.startsWith('art', p) &&
        (_stEnders.any(head.endsWith) ||
            (_artHeads.any(head.endsWith) &&
                (n - p == 3 || lower.endsWith('arten') && n - p == 5)))) {
      fugen.add(p); // „Test-arten“, „Betriebs-art“, „Aufgaben-arten“
    } else if (lower.startsWith('abend', p) &&
        (head.endsWith('tag') || head.endsWith('woch'))) {
      fugen.add(p); // „Freitag-abend“
    } else if (lower.startsWith('ebene', p) &&
        !isVowel(p - 1) &&
        (!'gnl'.contains(lower[p - 1]) ||
            head.endsWith('ll') ||
            (head.endsWith('en') && n - p <= 6))) {
      // „System-ebene“, „Modell-ebenen“, „Seiten-ebene“ - aber „gege-bene“
      // und „neben-einander“.
      fugen.add(p);
    } else if (startsAt(_aktStems, p) &&
        ('nslt'.contains(lower[p - 1]) || head.endsWith('er'))) {
      fugen.add(p); // „Rabatt-aktion“, aber „Sub-trak-tion“
    } else if (lower.endsWith('organ') && p == n - 5 && !isVowel(p - 1)) {
      fugen.add(p); // „Kontroll-organ“
    } else if (lower.startsWith('akte', p) && 'nl'.contains(lower[p - 1])) {
      fugen.add(p); // „Personal-akte“, aber „Kon-takte“
    } else if (lower.endsWith('sende') &&
        p == n - 4 &&
        _endeHeads.any(head.endsWith)) {
      fugen.add(p); // „Quartals-ende“
    }
  }

  // Beginnt bei [p] ein Wortstamm mit „st“?
  bool isStStem(int p) {
    if (startsAt(_stStems, p)) return !lower.startsWith('stilg', p);
    // „Maß-stab“ am Wortende, „Be-stätigung“ (aber „Berufs-tätigkeit“).
    if (lower.startsWith('stab', p) && n - p <= 5) return true;
    return lower.startsWith('stät', p) && lower.substring(0, p).endsWith('be');
  }

  // 2. Wortteile, die mit einem Konsonanten beginnen.
  for (var p = from; p < n - _minPart; p++) {
    if (isVowel(p)) continue;
    final fugenS = lower[p] == 's' && !isVowel(p + 1);
    final head = lower.substring(0, p + 1);
    if (fugenS && _fugenAlways.any(head.endsWith)) {
      fugen.add(p + 1);
    } else if (fugenS &&
        !lower.startsWith('sch', p) &&
        !lower.startsWith('stell', p) &&
        _fugenWeak.any(head.endsWith)) {
      fugen.add(p + 1);
    } else if (lower.startsWith('st', p) && isStStem(p)) {
      // Nicht, wenn gleich danach ein Vokalstamm beginnt („Mindest-abstand“
      // enthält keinen „Stab“) oder ein Wort auf „st“ davorsteht.
      final ender = _stEnders.any(lower.substring(0, p + 2).endsWith);
      if (!ender && !fugen.contains(p + 2)) fugen.add(p);
    } else if (startsAt(_consStems, p)) {
      fugen.add(p);
    } else if (lower[p] == 'r' &&
        !isVowel(p - 1) &&
        startsAt(_rStems, p) &&
        !(lower.startsWith('rech', p) &&
            (lower.startsWith('recht', p) ? 'p' : 'pbf').contains(
              lower[p - 1],
            ))) {
      fugen.add(p); // „Projekt-rahmen“, aber „spre-chen“
    } else if (lower[p] == 'r' &&
        _stBeforeR.any(lower.substring(0, p).endsWith)) {
      fugen.add(p);
    }
  }

  final breaks = <int>{...fugen};
  var i = first;
  while (i < n) {
    // Vokalgruppe überspringen (Diphthonge und Doppelvokale bleiben ganz).
    while (i < n && isVowel(i)) {
      i++;
    }
    final start = i;
    while (i < n && !isVowel(i)) {
      i++;
    }
    if (i >= n) break; // Endkonsonanten - keine Silbe mehr.
    final cluster = lower.substring(start, i);
    if (cluster.isEmpty) continue;
    // Liegt eine Wortfuge in dieser Konsonantengruppe, wird nur dort getrennt.
    if (fugen.any((f) => f >= start && f <= i)) continue;

    var cut = start + cluster.length - 1; // vor dem letzten Konsonanten
    for (final o in _onsets) {
      if (cluster.length >= o.length && cluster.endsWith(o)) {
        cut = start + cluster.length - o.length;
        // „t“ und „h“ gehören zu zwei Wortteilen: „Gut-haben“.
        if (o == 'th' && startsAt(_hStems, i - 1)) cut = i - 1;
        // „Wunsch-liste“, „mög-lich“ - aber „Pflicht“, „Schlichter“ und
        // „ausge-glichen“.
        if (o.endsWith('l') &&
            o != 'pfl' &&
            o != 'pl' &&
            (startsAt(_lStems, i - 1) ||
                o != 'gl' && startsAt(_leitStems, i - 1)) &&
            !lower.startsWith('licht', i - 1) &&
            !_glichen.any(lower.substring(0, i - 1).endsWith)) {
          cut = i - 1;
        }
        if (o == 'schw' && startsAt(_wStems, i - 1)) cut = i - 1;
        // Doppelkonsonant bleibt vorn: „Kopp-lung“.
        if (o.length == 2 &&
            o.endsWith('l') &&
            cut > start &&
            lower[cut] == lower[cut - 1]) {
          cut++;
        }
        // „erfolg-reich“, „umfang-reich“.
        if (o == 'gr' && lower.startsWith('reich', i - 1)) cut = i - 1;
        // „tz“ und „nz“ bleiben vorn: „Netz-werk“, „Grenz-wert“.
        if (o == 'zw' && cut > start && !startsAt(_zwStems, cut)) cut++;
        // „Ausweis-prüfung“, „As-pekt“ - aber „Bei-spiel“.
        if (o.startsWith('sp') && !startsAt(_spStems, cut)) cut++;
        break;
      }
    }
    // „ck“ wird nie geteilt: vor einem Vokal wandert es in die nächste Silbe
    // („Zu-cker“), vor einem Konsonanten bleibt es vorn („Entwick-lung“).
    if (lower[cut - 1] == 'c' && lower[cut] == 'k') cut++;
    // Fugen-s vor einem Vokal: Das nächste Wort des Kompositums beginnt mit
    // dem Vokal („Zahlungs-art“, „Sicherheits-aspekt“, nicht „Zahlung-sart“).
    // Nach einem bloßen „ts“ nur, wenn das „s“ nicht erkennbar zum nächsten
    // Wort gehört („Angebots-erstellung“, aber „Echtzeit-system“).
    final head = lower.substring(0, i);
    if (_fugenAlways.any(head.endsWith) ||
        head.endsWith('ings') ||
        (head.endsWith('ts') && !startsAt(_sStems, i - 1))) {
      cut = i;
    }
    breaks.add(cut);
  }

  // Vorn reichen zwei Buchstaben („An-schaf-fung“), hinten drei; zwischen
  // zwei Trennstellen stehen mindestens zwei, damit nie ein einzelner
  // Buchstabe abgetrennt wird.
  final cuts = <int>[];
  for (final cut in breaks.toList()..sort()) {
    if (cut < 2 || n - cut < _minPart) continue;
    if (cuts.isNotEmpty && cut - cuts.last < 2) continue;
    cuts.add(cut);
  }
  if (cuts.isEmpty) return word;

  final b = StringBuffer();
  var last = 0;
  for (final cut in cuts) {
    b
      ..write(word.substring(last, cut))
      ..write(_shy);
    last = cut;
  }
  b.write(word.substring(last));
  return b.toString();
}

/// Wortenden, nach denen „-art“ und „-arten“ ein eigenes Wort sind
/// („Betriebs-art“, „Projekt-arten“ - aber „Kar-ten“, „star-ten“).
const _artHeads = ['s', 'en', 'el', 'kt', 'rm', 'rt'];

/// „Aktion“ und „Aktivität“ als eigenes Wort - nur nach bestimmten
/// Buchstaben, sonst träfe es „Sub-traktion“ und „Attraktivität“.
const _aktStems = ['aktion', 'aktivit'];

/// Wortenden mit Fugen-s vor „-ende“ („Quartals-ende“, „Monats-ende“).
const _endeHeads = ['ls', 'ts', 'es', 'gs'];

/// Wortanfänge vor „-glichen“ („verglichen“, „ausgeglichen“, „beglichen“):
/// Hier ist „gl“ Anlaut, kein „-lich“ („mög-lichen“).
const _glichen = ['geg', 'verg', 'beg'];
