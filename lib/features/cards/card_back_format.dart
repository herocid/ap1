/// Gliedert die Rückseite einer Karteikarte für die Anzeige.
///
/// Reine Darstellungslogik: Die Kartentexte bleiben, wie sie sind. Aus dem
/// einen Textblock werden Absätze, damit lange Antworten nicht als Textwand
/// erscheinen. Die Regeln sind bewusst zurückhaltend - im Zweifel bleibt der
/// Text ungegliedert. Zusammengesetzt ergeben die Blöcke immer wieder den
/// Originaltext (bis auf Leerraum), das prüft `test/card_back_format_test.dart`
/// über alle Karten.
library;

/// Ein Absatz der Rückseite.
class BackBlock {
  const BackBlock(this.text, {this.label, this.formula = false});

  /// Stichwort samt Doppelpunkt („Textform (§ 126b BGB):“), halbfett gezeigt.
  final String? label;

  /// Der Text hinter dem Stichwort bzw. der ganze Absatz.
  final String text;

  /// Reiner Rechenweg oder Formel - wird in Zahlenschrift abgesetzt.
  final bool formula;

  /// Der Absatz als Fließtext, so wie er in der Karte steht.
  String get plain => label == null ? text : '$label $text';

  @override
  String toString() =>
      '${formula ? '[=] ' : ''}${label == null ? '' : '<$label> '}$text';
}

/// Ab dieser Länge wird reiner Fließtext an Satzgrenzen geteilt.
const kLongBackChars = 220;

/// Stichwörter, die immer einen eigenen Absatz beginnen.
const _keywords = {
  'Beispiel',
  'Beispiele',
  'Merke',
  'Merkhilfe',
  'Merksatz',
  'Tipp',
  'Achtung',
  'Hinweis',
  'Ausnahme',
  'Ausnahmen',
  'Faustregel',
  'Formel',
  'Rechnung',
  'Rechenweg',
  'Probe',
  'Wichtig',
  'Aber',
  'Folge',
  'Prüfungsfalle',
};

/// Abkürzungen, nach deren Punkt kein Satz endet.
const _abbreviations = {
  'Abs',
  'Nr',
  'Art',
  'lit',
  'Kap',
  'Abb',
  'Tab',
  'Ziff',
  'bzw',
  'ca',
  'ggf',
  'inkl',
  'exkl',
  'zzgl',
  'evtl',
  'sog',
  'vgl',
  'usw',
  'etc',
  'max',
  'min',
  'mind',
  'Min',
  'Std',
  'Sek',
  'Mio',
  'Mrd',
  'Tsd',
  'St',
  'Dr',
  'Prof',
  'engl',
  'dt',
  'lat',
  'bspw',
  'gem',
  'einschl',
  'allg',
  'Tel',
  'Str',
  'Co',
  'Rn',
  'ff',
};

final _letter = RegExp(r'[A-Za-zÄÖÜäöüß]');
final _upper = RegExp(r'[A-ZÄÖÜ]');
final _digit = RegExp(r'[0-9]');
final _wordBefore = RegExp(r'([A-Za-zÄÖÜäöüß]+)$');
final _numberBefore = RegExp(r'(^|\s)([0-9][0-9.,]*)$');
final _unitBefore = RegExp(r'[0-9] [A-Za-z]$');
final _lowerWord = RegExp(r'(?<![A-Za-zÄÖÜäöüß])[a-zäöüß]{2,}');

/// Stichwort am Satzanfang: beginnt groß (oder mit Ziffer bzw. „), ist kurz,
/// enthält außer Kommas keine Satzzeichen und endet mit Doppelpunkt plus Leerzeichen.
/// Uhrzeiten („17:45“) und Verhältnisse („1:n“) haben kein Leerzeichen nach
/// dem Doppelpunkt und passen deshalb nie.
final _labelPattern = RegExp(r'^([A-ZÄÖÜ0-9„][^:.!?;=]{0,44}:)\s+(\S.*)$');

/// Zerlegt [back] in Absätze. Kurze, einfache Antworten ergeben genau einen
/// Block ohne Stichwort - dann zeigt die Karte den Text unverändert.
List<BackBlock> formatCardBack(String back) {
  final text = back.trim();
  if (text.isEmpty) return const [];

  final blocks = <BackBlock>[];
  final loose = <String>[];
  // Lose Sätze werden zu einem Absatz; ist der sehr lang, wird er geteilt.
  void flush() {
    if (loose.isEmpty) return;
    blocks.addAll(_paragraphs(loose).map(BackBlock.new));
    loose.clear();
  }

  final sentences = [
    for (final s in splitSentences(text)) ..._splitLabelList(s),
  ];
  final labels = [for (final s in sentences) _labelOf(s)];
  // Ein einzelnes „Begriff: …“ ist meist nur ein Satz mit Doppelpunkt
  // („Nichts: USB-C ist nur die Steckerform.“). Gegliedert wird erst, wenn
  // mindestens zwei Sätze so gebaut sind.
  final termCount = labels.where((l) => l != null && !_isKeyword(l)).length;
  final lastTerm = labels.lastIndexWhere((l) => l != null && !_isKeyword(l));

  for (var i = 0; i < sentences.length; i++) {
    final s = sentences[i];
    final label = labels[i];
    final asLabel =
        label != null &&
        sentences.length > 1 &&
        (_isKeyword(label) || termCount >= 2);
    if (asLabel) {
      flush();
      final rest = s.substring(label.length).trim();
      blocks.add(BackBlock(rest, label: label, formula: isFormula(rest)));
    } else if (isFormula(s)) {
      flush();
      blocks.add(BackBlock(s, formula: true));
    } else if (termCount >= 2 &&
        i < lastTerm &&
        !s.contains(': ') &&
        blocks.isNotEmpty &&
        loose.isEmpty &&
        blocks.last.label != null &&
        !_isKeyword(blocks.last.label!) &&
        !blocks.last.formula) {
      // Satz zwischen zwei Stichwörtern: gehört noch zum vorherigen.
      final prev = blocks.removeLast();
      blocks.add(BackBlock('${prev.text} $s', label: prev.label));
    } else {
      loose.add(s);
    }
  }
  flush();
  return blocks;
}

/// Teilt Text an sicheren Satzgrenzen. Kein Schnitt nach Abkürzungen
/// („z. B.“, „Abs. 2“), in Zahlen („10.000 €“, „192.168.10.64/26“), nach
/// Ordnungszahlen („3. Normalform“), in Klammern oder in Anführungszeichen.
List<String> splitSentences(String text) {
  final out = <String>[];
  var start = 0;
  var round = 0;
  var quote = 0;
  for (var i = 0; i < text.length; i++) {
    final ch = text[i];
    if (ch == '(') round++;
    if (ch == ')' && round > 0) round--;
    if (ch == '„') quote++;
    if (ch == '“' && quote > 0) quote--;
    if (ch != '.' && ch != '!' && ch != '?') continue;
    if (round > 0 || quote > 0) continue;
    if (i + 2 >= text.length || text[i + 1] != ' ') continue;
    final next = text[i + 2];
    if (!_upper.hasMatch(next) &&
        !_digit.hasMatch(next) &&
        next != '„' &&
        next != '(' &&
        next != '§') {
      continue;
    }
    if (ch == '.' && !_endsSentence(text.substring(start, i), next)) continue;
    out.add(text.substring(start, i + 1).trim());
    start = i + 1;
  }
  final rest = text.substring(start).trim();
  if (rest.isNotEmpty) out.add(rest);
  return out;
}

/// Ob der Punkt nach [before] wirklich einen Satz beendet.
bool _endsSentence(String before, String next) {
  if (before.isEmpty) return false;
  final word = _wordBefore.firstMatch(before)?.group(1);
  if (word != null) {
    // Einzelbuchstabe: „z. B.“, „d. h.“, „i. d. R.“, „o. Ä.“.
    // Ausnahme ist eine Einheit hinter einer Zahl („85,9 s. Danach …“).
    if (word.length == 1) {
      return _unitBefore.hasMatch(before) && _upper.hasMatch(next);
    }
    if (_abbreviations.contains(word)) return false;
    return true;
  }
  final number = _numberBefore.firstMatch(before);
  if (number != null) {
    // „1. Januar“, „3. Normalform“: kurze Zahl vor dem Punkt kann eine
    // Ordnungszahl sein. Sicher ein Satzende ist sie nur als Ergebnis
    // („= 5.“) oder wenn sie lang ist („im Jahr 2025.“, „0,5.“).
    final digits = number.group(2)!;
    if (digits.length >= 3) return true;
    final lead = before.substring(0, number.start).trimRight();
    return lead.endsWith('=') || lead.endsWith('≈');
  }
  final last = before[before.length - 1];
  // Nach Klammer, Anführungszeichen, Einheit oder Prozent endet ein Satz.
  return ')“%€°'.contains(last) || !_letter.hasMatch(last);
}

String? _labelOf(String sentence) {
  final m = _labelPattern.firstMatch(sentence);
  if (m == null) return null;
  final label = m.group(1)!;
  // Klammern müssen im Stichwort geschlossen sein.
  if ('('.allMatches(label).length != ')'.allMatches(label).length) return null;
  if (label.contains('„') != label.contains('“')) return null;
  // Höchstens vier Wörter - sonst ist es ein Satz, kein Stichwort.
  if (label.trim().split(RegExp(r'\s+')).length > 4) return null;
  return label;
}

bool _isKeyword(String label) =>
    _keywords.contains(label.substring(0, label.length - 1));

/// „Hub: Schicht 1; Switch: Schicht 2; Router: Schicht 3.“ - eine Liste aus
/// Stichwörtern in einem Satz. Geteilt wird nur, wenn jeder Teil mit einem
/// Stichwort beginnt.
List<String> _splitLabelList(String sentence) {
  if (!sentence.contains('; ')) return [sentence];
  final parts = <String>[];
  var start = 0;
  var round = 0;
  for (var i = 0; i < sentence.length - 1; i++) {
    final ch = sentence[i];
    if (ch == '(') round++;
    if (ch == ')' && round > 0) round--;
    if (ch == ';' && round == 0 && sentence[i + 1] == ' ') {
      parts.add(sentence.substring(start, i + 1).trim());
      start = i + 1;
    }
  }
  parts.add(sentence.substring(start).trim());
  if (parts.length < 2) return [sentence];
  for (final p in parts) {
    final label = _labelOf(p);
    if (label == null || _isKeyword(label)) return [sentence];
  }
  return parts;
}

/// Reiner Rechenweg: ein Gleichheitszeichen und fast keine Fließtextwörter.
/// „60 / (15 × 0,8) = 60 / 12 = 5 Personen.“ ja, „Vorgänge auf dem
/// kritischen Pfad haben GP = 0.“ nein.
bool isFormula(String sentence) {
  if (!sentence.contains(' = ')) return false;
  if (sentence.contains(': ')) return false;
  return _lowerWord.allMatches(sentence).length <= 2;
}

/// Fasst Sätze zu einem Absatz zusammen; über [kLongBackChars] werden daraus
/// zwei, über der doppelten Länge drei etwa gleich lange Absätze.
List<String> _paragraphs(List<String> sentences) {
  final total = sentences.join(' ').length;
  if (sentences.length < 2 || total <= kLongBackChars) {
    return [sentences.join(' ')];
  }
  final wanted = total > 2 * kLongBackChars && sentences.length >= 3 ? 3 : 2;
  final out = <String>[];
  var current = <String>[];
  var done = 0;
  for (var i = 0; i < sentences.length; i++) {
    current.add(sentences[i]);
    done += sentences[i].length + 1;
    final left = sentences.length - i - 1;
    final open = wanted - out.length - 1;
    // Schnitt, sobald der Anteil für diesen Absatz erreicht ist - oder die
    // restlichen Sätze gerade noch für die restlichen Absätze reichen.
    if (open > 0 &&
        left > 0 &&
        (done >= total * (out.length + 1) / wanted - 20 || left == open)) {
      out.add(current.join(' '));
      current = <String>[];
    }
  }
  if (current.isNotEmpty) out.add(current.join(' '));
  return out;
}
