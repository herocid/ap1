import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/util/haptics.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../hyphenation.dart';

/// Wie eine Lücke bedient wird - ergibt sich aus den Daten.
enum GapMode { select, bank, input }

GapMode gapModeOf(Blank gap, {bool hasWordBank = false}) =>
    gap.options.isNotEmpty
    ? GapMode.select
    // Zahlen werden immer getippt - auch wenn andere Lücken derselben
    // Aufgabe aus der Wortbank gefüllt werden.
    : gap.numeric
    ? GapMode.input
    : hasWordBank
    ? GapMode.bank
    : GapMode.input;

/// Musterlösung einer Lücke, wie sie angezeigt wird (Dezimalkomma, Einheit).
String gapSolutionText(Blank gap) {
  final s = gap.numeric ? gap.solution.replaceAll('.', ',') : gap.solution;
  return gap.unit == null ? s : '$s ${gap.unit}';
}

/// Sichtbare Höhe einer Lücke; wächst mit der Systemschrift.
double gapVisualHeight(BuildContext context) =>
    math.max(40, MediaQuery.textScalerOf(context).scale(16) * 1.3 + 16);

/// Höhe der Tippfläche (mindestens 48 px).
double gapTouchHeight(BuildContext context) =>
    math.max(48, gapVisualHeight(context) + 6);

/// Farben einer Lücke je Zustand.
({Color fg, Color bg, Color border}) gapColors(
  BuildContext context, {
  required bool filled,
  required bool revealed,
  required bool correct,
  bool active = false,
}) {
  final c = context.c;
  final primary = context.scheme.primary;
  if (revealed) {
    return correct
        ? (fg: c.success, bg: c.successBg, border: c.success)
        : (fg: c.danger, bg: c.dangerBg, border: c.danger);
  }
  if (active) {
    return (
      fg: context.scheme.onSurface,
      bg: primary.withValues(alpha: 0.12),
      border: primary,
    );
  }
  if (filled) {
    return (
      fg: context.scheme.onSurface,
      bg: primary.withValues(alpha: 0.07),
      border: primary,
    );
  }
  return (
    fg: c.textMuted,
    bg: c.surfaceAlt,
    border: c.textMuted.withValues(alpha: 0.55),
  );
}

/// Nummer einer Lücke - verbindet die Lücke im Text mit ihrer Rückmeldung.
class GapBadge extends StatelessWidget {
  const GapBadge(this.label, {super.key, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = math.max(18.0, MediaQuery.textScalerOf(context).scale(11) + 7);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        maxLines: 1,
        softWrap: false,
        style: AppType.numeric(
          size: 11,
          weight: FontWeight.w700,
          color: color,
        ).copyWith(height: 1),
      ),
    );
  }
}

/// Eine Lücke zum Auswählen (Bottom Sheet) oder Eintippen.
///
/// [expand] füllt die verfügbare Breite (Tabellenzelle); sonst ist die
/// Lücke so breit wie ihr Inhalt bzw. bei Eingaben einheitlich breit - die
/// Breite verrät nicht, wie lang die Lösung ist.
class GapField extends StatefulWidget {
  const GapField({
    super.key,
    required this.gap,
    required this.value,
    required this.onChanged,
    required this.revealed,
    this.options = const [],
    this.label,
    this.title = 'Antwort wählen',
    this.expand = false,
    this.maxWidth = double.infinity,
    this.mono = false,
    this.showSolution = false,
  });

  final Blank gap;
  final String? value;
  final ValueChanged<String?> onChanged;
  final bool revealed;

  /// Auswahlmöglichkeiten in Anzeigereihenfolge (schon gemischt).
  final List<String> options;

  /// Nummer der Lücke, falls es mehrere gibt.
  final String? label;

  /// Überschrift des Auswahl-Sheets.
  final String title;
  final bool expand;
  final double maxWidth;
  final bool mono;

  /// Nach dem Prüfen die richtige Lösung direkt unter der Eingabe zeigen.
  final bool showSolution;

  @override
  State<GapField> createState() => _GapFieldState();
}

class _GapFieldState extends State<GapField> {
  TextEditingController? _ctrl;
  FocusNode? _focus;

  bool get _isSelect => widget.options.isNotEmpty;
  bool get _filled => (widget.value ?? '').trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (!_isSelect) {
      _ctrl = TextEditingController(text: widget.value ?? '');
      _focus = FocusNode()..addListener(_onFocus);
    }
  }

  void _onFocus() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant GapField old) {
    super.didUpdateWidget(old);
    final ctrl = _ctrl;
    if (ctrl != null &&
        (widget.value ?? '') != ctrl.text &&
        !(_focus?.hasFocus ?? false)) {
      ctrl.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    _focus
      ?..removeListener(_onFocus)
      ..dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    AppHaptics.select();
    final picked = await showGapOptions(
      context,
      title: widget.title,
      options: widget.options,
      selected: widget.value,
      mono: widget.mono,
    );
    if (picked == null) return;
    widget.onChanged(picked.isEmpty ? null : picked);
  }

  TextStyle _textStyle(BuildContext context, Color color) =>
      (widget.mono
              ? AppType.mono(size: 14.5)
              : context.text.bodyLarge!.copyWith(height: 1.25))
          .copyWith(color: color, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    final correct = widget.revealed && widget.gap.matches(widget.value);
    final focused = _focus?.hasFocus ?? false;
    final colors = gapColors(
      context,
      filled: _filled,
      revealed: widget.revealed,
      correct: correct,
      active: focused,
    );
    final visualH = gapVisualHeight(context);
    final touchH = gapTouchHeight(context);
    final style = _textStyle(context, colors.fg);
    final scaler = MediaQuery.textScalerOf(context);

    final Widget content;
    if (widget.revealed) {
      content = _revealed(context, colors.fg, style, correct);
    } else if (_isSelect) {
      content = _select(context, colors.fg, style);
    } else {
      content = _input(context, colors.fg, style);
    }

    // Eingaben sind einheitlich breit, Auswahl und Ergebnis so breit wie
    // ihr Text.
    double? fixedWidth;
    if (!widget.expand && !widget.revealed && !_isSelect) {
      final unit = widget.gap.unit;
      final unitW = unit == null ? 0.0 : scaler.scale(14) * 0.62 * unit.length;
      final base = scaler.scale(16) * (widget.gap.numeric ? 3.4 : 7.4);
      fixedWidth = math.min(
        widget.maxWidth,
        base + 24 + unitW + (widget.label != null ? 26 : 0),
      );
    }

    Widget box = Container(
      width: widget.expand ? double.infinity : fixedWidth,
      constraints: BoxConstraints(
        minHeight: visualH,
        minWidth: widget.expand ? 0 : math.min(64, widget.maxWidth),
        maxWidth: widget.expand ? double.infinity : widget.maxWidth,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(Radii.s + 2),
        border: Border.all(
          color: colors.border,
          width: widget.revealed || focused || _filled ? 1.6 : 1.2,
        ),
      ),
      alignment: widget.expand ? Alignment.centerLeft : null,
      child: content,
    );

    // Tippfläche mindestens 48 px hoch, auch wenn die Lücke flacher wirkt.
    box = ConstrainedBox(
      constraints: BoxConstraints(minHeight: touchH),
      child: Center(widthFactor: 1, child: box),
    );
    if (widget.expand) {
      box = SizedBox(width: double.infinity, child: box);
    }

    if (widget.revealed) return box;
    return Semantics(
      button: _isSelect,
      textField: !_isSelect,
      label: widget.title,
      value: widget.value,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _isSelect ? _pick : () => _focus?.requestFocus(),
        child: box,
      ),
    );
  }

  Widget _badge(Color color) => Padding(
    padding: const EdgeInsets.only(right: 6),
    child: GapBadge(widget.label!, color: color),
  );

  Widget _select(BuildContext context, Color fg, TextStyle style) {
    final text = _filled ? widget.value! : 'wählen';
    final label = _filled
        ? HyphenText(text, style: style)
        : Text(text, style: style.copyWith(fontWeight: FontWeight.w500));
    return Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (widget.label != null) _badge(fg),
        widget.expand ? Expanded(child: label) : Flexible(child: label),
        const SizedBox(width: 2),
        Icon(Icons.expand_more, size: 20, color: fg),
      ],
    );
  }

  Widget _input(BuildContext context, Color fg, TextStyle style) {
    final gap = widget.gap;
    final onSurface = context.scheme.onSurface;
    return Row(
      children: [
        if (widget.label != null) _badge(fg),
        Expanded(
          child: TextField(
            controller: _ctrl,
            focusNode: _focus,
            style: style.copyWith(color: onSurface),
            textAlign: widget.expand ? TextAlign.start : TextAlign.center,
            keyboardType: gap.numeric
                ? const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  )
                : TextInputType.text,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
            inputFormatters: [
              if (gap.numeric)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.\-]')),
              LengthLimitingTextInputFormatter(60),
            ],
            // Platz unter dem Feld lassen: Tastatur und „Prüfen“-Leiste
            // dürfen die Eingabe nicht verdecken.
            scrollPadding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
            onChanged: (s) => widget.onChanged(s.trim().isEmpty ? null : s),
            // Rahmen und Füllung trägt die Lücke selbst - die des Themes
            // würden ein zweites Kästchen hineinzeichnen.
            decoration: InputDecoration(
              isCollapsed: true,
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: gap.numeric ? '0' : '…',
              hintStyle: style.copyWith(
                color: context.c.textMuted.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (gap.unit != null) ...[
          const SizedBox(width: 6),
          Text(
            gap.unit!,
            style: context.text.bodyMedium?.copyWith(
              color: context.c.textMuted,
              height: 1.25,
            ),
          ),
        ],
      ],
    );
  }

  Widget _revealed(
    BuildContext context,
    Color fg,
    TextStyle style,
    bool correct,
  ) {
    final gap = widget.gap;
    final given = _filled
        ? '${widget.value!.trim()}${gap.unit != null ? ' ${gap.unit}' : ''}'
        : '–';
    final row = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (widget.label != null) _badge(fg),
        widget.expand
            ? Expanded(child: HyphenText(given, style: style))
            : Flexible(child: HyphenText(given, style: style)),
        const SizedBox(width: 4),
        Icon(correct ? Icons.check_circle : Icons.cancel, size: 18, color: fg),
      ],
    );
    if (!widget.showSolution || correct) return row;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        row,
        const SizedBox(height: 2),
        HyphenText(
          gapSolutionText(gap),
          prefix: 'richtig: ',
          prefixStyle: context.text.labelSmall?.copyWith(
            color: context.c.success,
            letterSpacing: 0,
          ),
          style: style.copyWith(
            color: context.c.success,
            fontSize: (style.fontSize ?? 16) - 2,
          ),
        ),
      ],
    );
  }
}

/// Öffnet die Auswahl einer Lücke als Bottom Sheet.
///
/// Liefert den gewählten Text, `''` für „Auswahl entfernen“ oder `null`,
/// wenn abgebrochen wurde.
Future<String?> showGapOptions(
  BuildContext context, {
  required String title,
  required List<String> options,
  String? selected,
  bool mono = false,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      final maxH = MediaQuery.sizeOf(ctx).height * 0.75;
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HyphenText(title, style: ctx.text.titleMedium),
                const SizedBox(height: Gap.m),
                for (final o in options) ...[
                  _OptionTile(
                    text: o,
                    selected: o == selected,
                    mono: mono,
                    onTap: () => Navigator.of(ctx).pop(o),
                  ),
                  const SizedBox(height: Gap.s),
                ],
                if ((selected ?? '').isNotEmpty)
                  TextButton.icon(
                    onPressed: () => Navigator.of(ctx).pop(''),
                    icon: const Icon(Icons.backspace_outlined, size: 18),
                    label: const Text('Auswahl entfernen'),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.text,
    required this.selected,
    required this.mono,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final bool mono;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    return Material(
      color: selected
          ? primary.withValues(alpha: 0.08)
          : context.scheme.surface,
      borderRadius: BorderRadius.circular(Radii.m),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.m),
        child: Container(
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.symmetric(
            horizontal: Gap.l,
            vertical: Gap.m,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.m),
            border: Border.all(
              color: selected ? primary : context.c.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: HyphenText(
                  text,
                  style: mono
                      ? AppType.mono(
                          size: 14.5,
                          color: context.scheme.onSurface,
                        )
                      : context.text.bodyLarge,
                ),
              ),
              const SizedBox(width: Gap.s),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 22,
                color: selected ? primary : context.c.border,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rückmeldung zu einer Lücke nach dem Prüfen: richtig/falsch, die eigene
/// Eingabe, die Musterlösung und die Begründung.
class GapFeedbackRow extends StatelessWidget {
  const GapFeedbackRow({
    super.key,
    required this.gap,
    required this.value,
    this.label,
    this.caption,
    this.mono = false,
  });

  final Blank gap;
  final String? value;

  /// Nummer der Lücke im Text.
  final String? label;

  /// Ort der Lücke, z. B. „Server · IP-Adresse“.
  final String? caption;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ok = gap.matches(value);
    final fg = ok ? c.success : c.danger;
    final filled = (value ?? '').trim().isNotEmpty;
    final solutionStyle =
        (mono
                ? AppType.mono(size: 14.5)
                : context.text.bodyLarge!.copyWith(height: 1.35))
            .copyWith(color: c.success, fontWeight: FontWeight.w700);
    final small = context.text.bodyMedium?.copyWith(height: 1.4);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.m),
      decoration: BoxDecoration(
        color: ok ? c.successBg : c.dangerBg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: fg.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            GapBadge(label!, color: fg),
            const SizedBox(width: Gap.s),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (caption != null)
                  HyphenText(
                    caption!,
                    style: context.text.labelSmall?.copyWith(
                      color: c.textMuted,
                      letterSpacing: 0.2,
                    ),
                  ),
                HyphenText(gapSolutionText(gap), style: solutionStyle),
                if (!ok)
                  HyphenText(
                    filled ? value!.trim() : 'nicht ausgefüllt',
                    prefix: filled ? 'Deine Antwort: ' : null,
                    style: small?.copyWith(color: c.danger),
                  ),
                if (gap.rationale.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  HyphenText(gap.rationale, style: small),
                ],
              ],
            ),
          ),
          const SizedBox(width: Gap.s),
          Icon(ok ? Icons.check_circle : Icons.cancel, size: 20, color: fg),
        ],
      ),
    );
  }
}
