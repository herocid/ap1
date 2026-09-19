import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import 'number_input.dart';

/// Rechenaufgabe mit einer Zahl als Ergebnis.
class NumericQuestionView extends StatefulWidget {
  const NumericQuestionView({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;

  @override
  State<NumericQuestionView> createState() => _NumericQuestionViewState();
}

class _NumericQuestionViewState extends State<NumericQuestionView> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    final a = widget.answer;
    _ctrl = TextEditingController(text: a == null ? '' : _format(a as num));
  }

  @override
  void didUpdateWidget(covariant NumericQuestionView old) {
    super.didUpdateWidget(old);
    // Neue Aufgabe -> Feld leeren.
    if (old.question.id != widget.question.id) {
      final a = widget.answer;
      _ctrl.text = a == null ? '' : _format(a as num);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  static String _format(num v) {
    final s = v.toString();
    return s.endsWith('.0')
        ? s.substring(0, s.length - 2)
        : s.replaceAll('.', ',');
  }

  bool get _allowDecimal =>
      widget.question.numericTolerance > 0 ||
      (widget.question.numericAnswer ?? 0) % 1 != 0;

  void _submit(String raw) {
    final v = parseGermanNumber(raw);
    widget.onChanged(v);
  }

  Future<void> _openKeypad() async {
    final result = await showNumericKeypad(
      context,
      title: 'Ergebnis eingeben',
      initial: _ctrl.text,
      hint: widget.question.unit,
      allowDecimal: _allowDecimal,
    );
    if (result == null) return;
    setState(() => _ctrl.text = result);
    _submit(result);
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.question;
    final c = context.c;
    final correct = widget.grade?.isCorrect ?? false;

    final fieldColor = !widget.revealed
        ? context.scheme.surface
        : correct
            ? c.successBg
            : c.dangerBg;
    final borderColor = !widget.revealed
        ? c.border
        : correct
            ? c.success
            : c.danger;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: widget.revealed || !useKeypadLayout(context)
                    ? null
                    : _openKeypad,
                child: AbsorbPointer(
                  absorbing: useKeypadLayout(context),
                  child: TextField(
                    controller: _ctrl,
                    enabled: !widget.revealed,
                    style: AppType.numeric(size: 26),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: _allowDecimal,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,.\-]')),
                    ],
                    onChanged: _submit,
                    decoration: InputDecoration(
                      hintText: '0',
                      fillColor: fieldColor,
                      suffixText: q.unit,
                      suffixStyle: context.text.bodyMedium
                          ?.copyWith(color: c.textMuted),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Radii.m),
                        borderSide: BorderSide(color: borderColor, width: 1.6),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Radii.m),
                        borderSide: BorderSide(color: borderColor, width: 1.6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Gap.s),
        Text(
          useKeypadLayout(context)
              ? 'Tippe auf das Feld, um das Ziffernfeld zu oeffnen. '
                  'Dezimaltrennzeichen ist das Komma.'
              : 'Dezimaltrennzeichen ist das Komma.',
          style: context.text.labelSmall?.copyWith(color: c.textMuted),
        ),
        if (widget.revealed && !correct) ...[
          const SizedBox(height: Gap.l),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Gap.l),
            decoration: BoxDecoration(
              color: c.successBg,
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(color: c.success.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: c.success, size: 20),
                const SizedBox(width: Gap.m),
                Text('Richtig waere: ', style: context.text.bodyMedium),
                Text(
                  '${_format(q.numericAnswer ?? 0)}${q.unit != null ? ' ${q.unit}' : ''}',
                  style: AppType.numeric(size: 16, color: c.success),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
