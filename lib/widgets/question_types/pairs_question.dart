import 'package:flutter/material.dart';

import '../../core/util/haptics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../common.dart';
import '../hyphenation.dart';
import 'question_material.dart';
import 'shuffle.dart';

/// Paare finden: links antippen, dann rechts antippen verbindet.
///
/// Kein Ziehen von Linien - auf einem schmalen Display mit dem Daumen nicht
/// zu treffen. Ein Paar erkennt man an derselben Nummer und Farbe auf
/// beiden Seiten; erneutes Antippen löst es wieder. Die rechte Seite ist
/// gemischt.
class PairsQuestionView extends StatefulWidget {
  const PairsQuestionView({
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
  State<PairsQuestionView> createState() => _PairsQuestionViewState();
}

class _PairsQuestionViewState extends State<PairsQuestionView> {
  int? _activeLeft;
  int? _activeRight;

  List<PairItem> get _pairs => widget.question.pairs;

  Map<int, int> get _map =>
      (widget.answer as Map<int, int>?) ?? const <int, int>{};

  /// Position rechts -> Original-Index.
  List<int> get _rightOrder => displayOrder(
    _pairs.length,
    widget.shuffleSeed,
    salt: 'right',
    avoidIdentity: true,
  );

  @override
  void didUpdateWidget(covariant PairsQuestionView old) {
    super.didUpdateWidget(old);
    if (old.question.id != widget.question.id) {
      _activeLeft = null;
      _activeRight = null;
    }
  }

  int? _leftOf(int right) {
    for (final e in _map.entries) {
      if (e.value == right) return e.key;
    }
    return null;
  }

  void _emit(Map<int, int> next) =>
      widget.onChanged(next.isEmpty ? null : next);

  void _connect(int left, int right) {
    final next = <int, int>{..._map}
      ..removeWhere((l, r) => r == right)
      ..[left] = right;
    setState(() {
      _activeLeft = null;
      _activeRight = null;
    });
    _emit(next);
  }

  void _tapLeft(int left) {
    if (widget.revealed) return;
    AppHaptics.select();
    if (_activeRight != null) return _connect(left, _activeRight!);
    if (_map.containsKey(left)) {
      // Erneutes Antippen löst das Paar; die linke Seite bleibt gewählt.
      _emit(<int, int>{..._map}..remove(left));
      setState(() => _activeLeft = left);
      return;
    }
    setState(() => _activeLeft = _activeLeft == left ? null : left);
  }

  void _tapRight(int right) {
    if (widget.revealed) return;
    AppHaptics.select();
    if (_activeLeft != null) return _connect(_activeLeft!, right);
    final owner = _leftOf(right);
    if (owner != null) {
      _emit(<int, int>{..._map}..remove(owner));
      setState(() => _activeRight = right);
      return;
    }
    setState(() => _activeRight = _activeRight == right ? null : right);
  }

  /// Farbe eines Paars - zusätzlich zur Nummer, nie allein.
  Color _tone(BuildContext context, int left) => switch (left % 3) {
    0 => context.scheme.primary,
    1 => context.c.flame,
    _ => context.c.info,
  };

  @override
  Widget build(BuildContext context) =>
      widget.revealed ? _review(context) : _board(context);

  Widget _board(BuildContext context) {
    final n = _pairs.length;
    final order = _rightOrder;
    final style = context.text.bodyMedium!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HintLine(
          'Tippe links einen Begriff an, dann rechts das Gegenstück. '
          'Erneutes Antippen löst das Paar. (${_map.length} von $n verbunden)',
        ),
        const SizedBox(height: Gap.m),
        LayoutBuilder(
          builder: (context, box) {
            // Breite, die dem Text in einer Kachel bleibt. Passt das längste
            // Wortstück nicht hinein, wird die Schrift aller Kacheln
            // gemeinsam etwas kleiner - statt mitten im Wort umzubrechen.
            final textW = (box.maxWidth - Gap.s) / 2 - 2 * _PairTile.pad - 2;
            final badge = _PairTile.badgeSize(context) + _PairTile.badgeGap;
            final scaler = fittingTextScaler(
              context,
              texts: [
                for (final p in _pairs) ...[
                  ..._pieces(p.left),
                  ..._pieces(p.right),
                ],
              ],
              style: style,
              maxWidth: textW - badge,
            );
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: scaler),
              child: Column(
                children: [
                  for (var row = 0; row < n; row++) ...[
                    if (row > 0) const SizedBox(height: Gap.s),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _leftTile(context, row)),
                          const SizedBox(width: Gap.s),
                          Expanded(child: _rightTile(context, order[row])),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// Nicht trennbare Stücke eines Texts (Wörter bzw. Silben langer Wörter).
  static Iterable<String> _pieces(String text) sync* {
    final shy = String.fromCharCode(0x00AD);
    // Wie HyphenText: Umbruch an Leerzeichen, nach Bindestrichen und an
    // weichen Trennstellen.
    final words = hyphenate(text).split(RegExp('[\\s$kZeroWidthSpace]|(?<=-)'));
    for (final word in words) {
      final parts = word.split(shy);
      for (var i = 0; i < parts.length; i++) {
        if (parts[i].isEmpty) continue;
        yield i < parts.length - 1 ? '${parts[i]}-' : parts[i];
      }
    }
  }

  Widget _leftTile(BuildContext context, int left) {
    final connected = _map.containsKey(left);
    return _PairTile(
      key: ValueKey('left-$left'),
      text: _pairs[left].left,
      number: left + 1,
      numberFilled: connected,
      tone: connected ? _tone(context, left) : null,
      active: _activeLeft == left,
      semantics: connected
          ? 'verbunden mit ${_pairs[_map[left]!].right}'
          : 'nicht verbunden',
      onTap: () => _tapLeft(left),
    );
  }

  Widget _rightTile(BuildContext context, int right) {
    final owner = _leftOf(right);
    return _PairTile(
      key: ValueKey('right-$right'),
      text: _pairs[right].right,
      number: owner == null ? null : owner + 1,
      numberFilled: owner != null,
      tone: owner == null ? null : _tone(context, owner),
      active: _activeRight == right,
      semantics: owner == null
          ? 'nicht verbunden'
          : 'verbunden mit ${_pairs[owner].left}',
      onTap: () => _tapRight(right),
    );
  }

  Widget _review(BuildContext context) {
    final c = context.c;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HintLine(
          'Auswertung: Jedes richtige Paar zählt.',
          icon: Icons.fact_check_outlined,
        ),
        const SizedBox(height: Gap.m),
        for (var i = 0; i < _pairs.length; i++) ...[
          if (i > 0) const SizedBox(height: Gap.s),
          Builder(
            builder: (context) {
              final chosen = _map[i];
              final ok = chosen == i;
              final fg = ok ? c.success : c.danger;
              return Container(
                key: ValueKey('pair-result-$i'),
                width: double.infinity,
                padding: const EdgeInsets.all(Gap.m),
                decoration: BoxDecoration(
                  color: ok ? c.successBg : c.dangerBg,
                  borderRadius: BorderRadius.circular(Radii.m),
                  border: Border.all(color: fg, width: 1.6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HyphenText(
                            _pairs[i].left,
                            style: context.text.titleSmall,
                          ),
                          const SizedBox(height: 2),
                          HyphenText(
                            _pairs[i].right,
                            prefix: '→ ',
                            style: context.text.bodyMedium?.copyWith(
                              color: c.success,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                          if (!ok)
                            HyphenText(
                              chosen == null
                                  ? 'nicht verbunden'
                                  : _pairs[chosen].right,
                              prefix: chosen == null ? null : 'Deine Wahl: ',
                              style: context.text.bodyMedium?.copyWith(
                                color: c.danger,
                                height: 1.4,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Gap.s),
                    Icon(
                      ok ? Icons.check_circle : Icons.cancel,
                      size: 20,
                      color: fg,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

class _PairTile extends StatelessWidget {
  const _PairTile({
    super.key,
    required this.text,
    required this.number,
    required this.numberFilled,
    required this.tone,
    required this.active,
    required this.semantics,
    required this.onTap,
  });

  static const pad = 10.0;
  static const badgeGap = 6.0;

  static double badgeSize(BuildContext context) => 22;

  final String text;

  /// Nummer des Paars; rechts erst sichtbar, wenn verbunden.
  final int? number;
  final bool numberFilled;
  final Color? tone;
  final bool active;
  final String semantics;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final primary = context.scheme.primary;
    final connected = tone != null;
    final border = active ? primary : (tone ?? c.border);
    final bg = active
        ? primary.withValues(alpha: 0.12)
        : connected
        ? tone!.withValues(alpha: 0.09)
        : context.scheme.surface;
    final size = badgeSize(context);

    return Semantics(
      button: true,
      selected: active,
      label: '$text, $semantics',
      excludeSemantics: true,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.m),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.m),
          child: Container(
            constraints: const BoxConstraints(minHeight: 56),
            padding: EdgeInsets.all(active || connected ? pad - 0.6 : pad),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(
                color: border,
                width: active || connected ? 1.6 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: numberFilled ? tone : Colors.transparent,
                    border: Border.all(
                      color: numberFilled ? tone! : c.border,
                      width: 1.4,
                    ),
                  ),
                  child: number == null
                      ? null
                      : Text(
                          '$number',
                          textScaler: TextScaler.noScaling,
                          style: AppType.numeric(
                            size: 12,
                            weight: FontWeight.w700,
                            color: numberFilled
                                ? context.scheme.surface
                                : c.textMuted,
                          ).copyWith(height: 1),
                        ),
                ),
                const SizedBox(width: badgeGap),
                Expanded(
                  child: HyphenText(
                    text,
                    style: context.text.bodyMedium?.copyWith(height: 1.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
