import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../common.dart';
import '../hyphenation.dart';
import 'gap_field.dart';
import 'question_material.dart';
import 'shuffle.dart';

/// Lückentext: Der Text fließt, die Lücken stehen mitten im Satz.
///
/// Drei Bedienarten, die sich aus den Daten ergeben ([gapModeOf]):
/// Auswahl aus einer Liste, Wortbank zum Antippen oder Eintippen. Mit
/// `question.mono` wird der Text als Code gesetzt - Zeilen und Einrückung
/// bleiben erhalten (Pseudocode ergänzen).
class ClozeQuestionView extends StatefulWidget {
  const ClozeQuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
    this.shuffleSeed = 0,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;
  final int shuffleSeed;

  @override
  State<ClozeQuestionView> createState() => _ClozeQuestionViewState();
}

class _Part {
  const _Part.text(this.text) : gap = null;
  const _Part.gap(int this.gap) : text = '';
  final String text;
  final int? gap;
}

final _placeholder = RegExp(r'\{(\d+)\}');

class _ClozeQuestionViewState extends State<ClozeQuestionView> {
  /// Lücke, die der nächste Begriff aus der Wortbank füllt.
  int? _active;

  late List<List<String>> _options;
  late List<String> _bank;

  Question get _q => widget.question;

  Map<int, String> get _map =>
      (widget.answer as Map<int, String>?) ?? const <int, String>{};

  GapMode _mode(int i) =>
      gapModeOf(_q.gaps[i], hasWordBank: _q.wordBank.isNotEmpty);

  List<int> get _bankGaps => [
    for (var i = 0; i < _q.gaps.length; i++)
      if (_mode(i) == GapMode.bank) i,
  ];

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  @override
  void didUpdateWidget(covariant ClozeQuestionView old) {
    super.didUpdateWidget(old);
    if (old.question.id != _q.id || old.shuffleSeed != widget.shuffleSeed) {
      _active = null;
      _prepare();
    }
  }

  void _prepare() {
    final seed = widget.shuffleSeed;
    _options = [
      for (var i = 0; i < _q.gaps.length; i++)
        [
          for (final j in displayOrder(
            _q.gaps[i].options.length,
            seed,
            salt: 'gap$i',
          ))
            _q.gaps[i].options[j],
        ],
    ];
    // Wortbank: alle Lösungen plus Ablenker, ohne doppelte Ablenker.
    final words = [for (final i in _bankGaps) _q.gaps[i].solution];
    for (final w in _q.wordBank) {
      final n = normalizeAnswer(w);
      if (!words.any((x) => normalizeAnswer(x) == n)) words.add(w);
    }
    _bank = [
      for (final j in displayOrder(words.length, seed, salt: 'bank')) words[j],
    ];
  }

  void _set(int gap, String? value) {
    final next = <int, String>{..._map};
    if (value == null || value.isEmpty) {
      next.remove(gap);
    } else {
      next[gap] = value;
    }
    widget.onChanged(next.isEmpty ? null : next);
  }

  void _tapBankGap(int gap) {
    if (widget.revealed) return;
    HapticFeedback.selectionClick();
    if (_map.containsKey(gap)) {
      _set(gap, null);
      setState(() => _active = gap);
    } else {
      setState(() => _active = _active == gap ? null : gap);
    }
  }

  void _tapChip(String word, bool used) {
    if (widget.revealed) return;
    HapticFeedback.selectionClick();
    if (used) {
      // Benutzten Begriff zurücknehmen.
      final from = _bankGaps.lastWhere(
        (i) => _map[i] == word,
        orElse: () => -1,
      );
      if (from >= 0) _set(from, null);
      return;
    }
    final free = _bankGaps.where((i) => !_map.containsKey(i));
    final target = _active != null && free.contains(_active)
        ? _active
        : (free.isEmpty ? null : free.first);
    if (target == null) return;
    setState(() => _active = null);
    _set(target, word);
  }

  String? _label(int gap) => _q.gaps.length > 1 ? '${gap + 1}' : null;

  @override
  Widget build(BuildContext context) {
    final q = _q;
    final text = q.clozeText ?? '';
    final modes = {for (var i = 0; i < q.gaps.length; i++) _mode(i)};
    final filled = _map.keys.where((k) => k < q.gaps.length).length;

    final hint = [
      if (modes.contains(GapMode.bank))
        'Tippe die Begriffe an – sie füllen die Lücken der Reihe nach. '
            'Ein Tipp auf eine gefüllte Lücke leert sie.',
      if (modes.contains(GapMode.select))
        'Tippe auf eine Lücke und wähle die passende Antwort.',
      if (modes.contains(GapMode.input)) 'Tippe die Antwort in die Lücke.',
    ].join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HintLine(
          widget.revealed
              ? 'Auswertung: Jede richtig gefüllte Lücke zählt.'
              : '$hint ($filled von ${q.gaps.length} gefüllt)',
          icon: widget.revealed
              ? Icons.fact_check_outlined
              : Icons.touch_app_outlined,
        ),
        const SizedBox(height: Gap.m),
        LayoutBuilder(
          builder: (context, box) => q.mono
              ? _monoText(context, text, box.maxWidth)
              : _proseText(context, text, box.maxWidth),
        ),
        if (!widget.revealed && modes.contains(GapMode.bank)) ...[
          const SizedBox(height: Gap.l),
          _bankChips(context),
        ],
        if (widget.revealed) ...[
          const SizedBox(height: Gap.l),
          for (var i = 0; i < q.gaps.length; i++) ...[
            if (i > 0) const SizedBox(height: Gap.s),
            GapFeedbackRow(
              gap: q.gaps[i],
              value: _map[i],
              label: _label(i),
              mono: q.mono,
            ),
          ],
        ],
      ],
    );
  }

  // ------------------------------------------------------------- Textsatz

  List<List<_Part>> _tokens(String line) {
    final tokens = <List<_Part>>[];
    for (final raw in line.split(RegExp(r'\s+'))) {
      if (raw.isEmpty) continue;
      final parts = <_Part>[];
      var last = 0;
      for (final m in _placeholder.allMatches(raw)) {
        final index = int.parse(m[1]!);
        if (index >= _q.gaps.length) continue;
        if (m.start > last) parts.add(_Part.text(raw.substring(last, m.start)));
        parts.add(_Part.gap(index));
        last = m.end;
      }
      if (last < raw.length) parts.add(_Part.text(raw.substring(last)));
      tokens.add(parts);
    }
    return tokens;
  }

  double _spaceWidth(TextStyle style) {
    final scaler = MediaQuery.textScalerOf(context);
    return math.max(
      2,
      measureTextWidth('a b', style, scaler) -
          measureTextWidth('ab', style, scaler),
    );
  }

  Widget _proseText(BuildContext context, String text, double width) {
    final style = context.text.bodyLarge!;
    // Zeilen ohne Lücke etwas enger als die Tippfläche einer Lücke - sonst
    // wirkt der Text wie mit doppeltem Zeilenabstand gesetzt.
    final lineH = gapVisualHeight(context) - 4;
    final space = _spaceWidth(style);

    Widget word(String w) => ConstrainedBox(
      constraints: BoxConstraints(minHeight: lineH),
      child: Center(
        widthFactor: 1,
        child: w.length >= 12
            ? HyphenText(w, style: style)
            : Text(w, style: style),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final line in text.split('\n'))
          if (line.trim().isEmpty)
            const SizedBox(height: Gap.s)
          else
            Wrap(
              spacing: space,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final token in _tokens(line))
                  _token(context, token, width, style, word),
              ],
            ),
      ],
    );
  }

  Widget _monoText(BuildContext context, String text, double width) {
    final c = context.c;
    final style = AppType.mono(
      size: 13.5,
      color: context.scheme.onSurface,
    ).copyWith(letterSpacing: 0);
    final scaler = MediaQuery.textScalerOf(context);
    final charW = measureTextWidth('MMMMMMMMMM', style, scaler) / 10;
    const padL = Gap.m + 3.0;
    const padR = Gap.m;
    final inner = width - padL - padR;
    final lines = text.replaceAll('\t', '    ').split('\n');

    Widget word(String w) => Text(breakableCode(w), style: style);

    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.m),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(padL - 3, Gap.m, padR, Gap.m),
        decoration: BoxDecoration(
          color: c.surfaceAlt,
          border: Border(
            left: BorderSide(color: context.scheme.primary, width: 3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final line in lines)
              if (line.trim().isEmpty)
                Text(' ', style: style)
              else
                Builder(
                  builder: (context) {
                    final indent = math.min(
                      (line.length - line.trimLeft().length) * charW,
                      math.max(0.0, inner / 3),
                    );
                    return Padding(
                      padding: EdgeInsets.only(left: indent),
                      child: Wrap(
                        spacing: charW,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          for (final token in _tokens(line))
                            _token(context, token, inner - indent, style, word),
                        ],
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }

  Widget _token(
    BuildContext context,
    List<_Part> parts,
    double width,
    TextStyle style,
    Widget Function(String) word,
  ) {
    if (parts.length == 1 && parts.first.gap == null) {
      return word(parts.first.text);
    }
    // Satzzeichen direkt an der Lücke bleiben bei ihr („{0},“).
    final textW = parts
        .where((p) => p.gap == null)
        .fold<double>(
          0,
          (s, p) =>
              s +
              measureTextWidth(
                p.text,
                style,
                MediaQuery.textScalerOf(context),
              ) +
              2,
        );
    final gapCount = parts.where((p) => p.gap != null).length;
    final maxGap = math.max(48.0, (width - textW) / gapCount - 1);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final p in parts)
          if (p.gap == null)
            Text(p.text, style: style)
          else
            _gap(context, p.gap!, maxGap),
      ],
    );
  }

  Widget _gap(BuildContext context, int i, double maxWidth) {
    final gap = _q.gaps[i];
    final mode = _mode(i);
    if (mode == GapMode.bank && !widget.revealed) {
      return _BankSlot(
        key: ValueKey('gap-$i'),
        label: _label(i),
        value: _map[i],
        active: _active == i,
        maxWidth: maxWidth,
        mono: _q.mono,
        onTap: () => _tapBankGap(i),
      );
    }
    return GapField(
      key: ValueKey('gap-$i'),
      gap: gap,
      value: _map[i],
      revealed: widget.revealed,
      options: _options[i],
      label: _label(i),
      title: _q.gaps.length > 1 ? 'Lücke ${i + 1}' : 'Antwort wählen',
      maxWidth: maxWidth,
      mono: _q.mono,
      onChanged: (v) => _set(i, v),
    );
  }

  // ------------------------------------------------------------- Wortbank

  Widget _bankChips(BuildContext context) {
    final remaining = <String, int>{};
    for (final i in _bankGaps) {
      final v = _map[i];
      if (v != null) remaining[v] = (remaining[v] ?? 0) + 1;
    }
    final used = <bool>[];
    for (final w in _bank) {
      final left = remaining[w] ?? 0;
      used.add(left > 0);
      if (left > 0) remaining[w] = left - 1;
    }
    return Wrap(
      spacing: Gap.s,
      runSpacing: Gap.s,
      children: [
        for (var j = 0; j < _bank.length; j++)
          _BankChip(
            key: ValueKey('bank-$j'),
            word: _bank[j],
            used: used[j],
            mono: _q.mono,
            onTap: () => _tapChip(_bank[j], used[j]),
          ),
      ],
    );
  }
}

/// Lücke, die aus der Wortbank gefüllt wird.
class _BankSlot extends StatelessWidget {
  const _BankSlot({
    super.key,
    required this.label,
    required this.value,
    required this.active,
    required this.maxWidth,
    required this.mono,
    required this.onTap,
  });

  final String? label;
  final String? value;
  final bool active;
  final double maxWidth;
  final bool mono;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final filled = value != null;
    final colors = gapColors(
      context,
      filled: filled,
      revealed: false,
      correct: false,
      active: active && !filled,
    );
    final style =
        (mono
                ? AppType.mono(size: 14.5)
                : context.text.bodyLarge!.copyWith(height: 1.25))
            .copyWith(color: colors.fg, fontWeight: FontWeight.w600);
    return Semantics(
      button: true,
      label: filled
          ? 'Lücke ${label ?? ''}: $value. Antippen zum Leeren.'
          : 'Lücke ${label ?? ''}, leer',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: gapTouchHeight(context)),
          child: Center(
            widthFactor: 1,
            child: Container(
              constraints: BoxConstraints(
                minHeight: gapVisualHeight(context),
                minWidth: math.min(72, maxWidth),
                maxWidth: maxWidth,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: colors.bg,
                borderRadius: BorderRadius.circular(Radii.s + 2),
                border: Border.all(
                  color: colors.border,
                  width: filled || active ? 1.6 : 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (label != null) ...[
                    GapBadge(label!, color: colors.fg),
                    if (filled) const SizedBox(width: 6),
                  ],
                  if (filled) Flexible(child: HyphenText(value!, style: style)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BankChip extends StatelessWidget {
  const _BankChip({
    super.key,
    required this.word,
    required this.used,
    required this.mono,
    required this.onTap,
  });

  final String word;
  final bool used;
  final bool mono;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final fg = used
        ? c.textMuted.withValues(alpha: 0.45)
        : context.scheme.onSurface;
    final style =
        (mono
                ? AppType.mono(size: 14.5)
                : context.text.bodyLarge!.copyWith(height: 1.25))
            .copyWith(color: fg, fontWeight: FontWeight.w600);
    return Semantics(
      button: true,
      label: used ? '$word, schon eingesetzt' : word,
      excludeSemantics: true,
      child: Material(
        color: used ? c.surfaceAlt : context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.m),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.m),
          child: Container(
            constraints: const BoxConstraints(minHeight: 48, minWidth: 56),
            padding: const EdgeInsets.symmetric(horizontal: Gap.l, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(
                color: used ? c.border : c.textMuted.withValues(alpha: 0.55),
                width: used ? 1 : 1.4,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Flexible(child: HyphenText(word, style: style))],
            ),
          ),
        ),
      ),
    );
  }
}
