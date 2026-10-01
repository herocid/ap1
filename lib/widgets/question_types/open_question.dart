import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../common.dart';
import '../hyphenation.dart';
import 'question_material.dart';

/// Freitext wie in der IHK-Prüfung: schreiben, dann mit der Musterlösung
/// vergleichen und die Bewertungskriterien selbst abhaken.
///
/// Vor dem Prüfen ist `OpenAnswer.checked == null`. Nach dem Prüfen schlägt
/// die App vor, welche Kriterien sie in der Antwort erkennt; jede Änderung
/// an den Haken geht als neue [OpenAnswer] an den Host - der bewertet dann
/// neu.
class OpenQuestionView extends StatefulWidget {
  const OpenQuestionView({
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
  State<OpenQuestionView> createState() => _OpenQuestionViewState();
}

class _OpenQuestionViewState extends State<OpenQuestionView> {
  late final TextEditingController _ctrl;

  OpenAnswer? get _answer => widget.answer as OpenAnswer?;
  Question get _q => widget.question;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: _answer?.text ?? '');
  }

  @override
  void didUpdateWidget(covariant OpenQuestionView old) {
    super.didUpdateWidget(old);
    final text = _answer?.text ?? '';
    if (old.question.id != _q.id ||
        (text != _ctrl.text && text.trim() != _ctrl.text.trim())) {
      _ctrl.text = text;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _textChanged(String text) {
    final checked = _answer?.checked;
    if (text.trim().isEmpty && (checked == null || checked.isEmpty)) {
      widget.onChanged(null);
    } else {
      widget.onChanged(OpenAnswer(text: text, checked: checked));
    }
  }

  /// Was die App in der Antwort erkennt - nur ein Vorschlag.
  Set<int> get _suggested {
    final text = _answer?.text ?? '';
    return {
      for (var i = 0; i < _q.criteria.length; i++)
        if (_q.criteria[i].foundIn(text)) i,
    };
  }

  Set<int> get _checked => _answer?.checked ?? _suggested;

  void _toggle(int i) {
    HapticFeedback.selectionClick();
    final next = {..._checked};
    next.contains(i) ? next.remove(i) : next.add(i);
    widget.onChanged(OpenAnswer(text: _answer?.text ?? '', checked: next));
  }

  @override
  Widget build(BuildContext context) =>
      widget.revealed ? _review(context) : _editor(context);

  Widget _editor(BuildContext context) {
    final c = context.c;
    final words = _ctrl.text.trim().isEmpty
        ? 0
        : _ctrl.text.trim().split(RegExp(r'\s+')).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HintLine(
          'Antworte wie in der Prüfung: Stichworte genügen. Danach '
          'vergleichst du mit der Musterlösung.',
          icon: Icons.edit_note,
        ),
        const SizedBox(height: Gap.m),
        TextField(
          controller: _ctrl,
          minLines: 5,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          style: context.text.bodyLarge,
          // Platz unter der Schreibmarke lassen: Tastatur und
          // „Prüfen“-Leiste dürfen die Zeile nicht verdecken.
          scrollPadding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
          onChanged: (s) {
            setState(() {});
            _textChanged(s);
          },
          decoration: InputDecoration(
            hintText: 'Stichworte genügen …',
            hintStyle: context.text.bodyLarge?.copyWith(color: c.textMuted),
            contentPadding: const EdgeInsets.all(Gap.l),
          ),
        ),
        const SizedBox(height: Gap.xs),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            words == 1 ? '1 Wort' : '$words Wörter',
            style: context.text.labelSmall?.copyWith(color: c.textMuted),
          ),
        ),
      ],
    );
  }

  Widget _review(BuildContext context) {
    final c = context.c;
    final q = _q;
    final text = (_answer?.text ?? '').trim();
    final checked = _checked;
    final isSuggestion = _answer?.checked == null;
    final total = q.points;
    final listed = q.criteria.fold<int>(0, (s, k) => s + k.points);
    final earned = math.min(
      total,
      [
        for (var i = 0; i < q.criteria.length; i++)
          if (checked.contains(i)) q.criteria[i].points,
      ].fold<int>(0, (s, p) => s + p),
    );
    final samePoints =
        q.criteria.isNotEmpty &&
        q.criteria.every((k) => k.points == q.criteria.first.points);
    final needed = samePoints && q.criteria.first.points > 0
        ? (total / q.criteria.first.points).ceil()
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialBox(
          label: 'Deine Antwort',
          child: HyphenText(
            text.isEmpty ? 'Keine Antwort eingegeben.' : text,
            style: context.text.bodyMedium?.copyWith(
              color: text.isEmpty ? c.textMuted : null,
            ),
          ),
        ),
        if ((q.sampleSolution ?? '').isNotEmpty) ...[
          const SizedBox(height: Gap.m),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Gap.l),
            decoration: BoxDecoration(
              color: c.successBg,
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(color: c.success.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MUSTERLÖSUNG',
                  style: context.text.labelSmall?.copyWith(
                    color: c.success,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: Gap.xs),
                HyphenText(q.sampleSolution!, style: context.text.bodyMedium),
              ],
            ),
          ),
        ],
        const SizedBox(height: Gap.l),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selbstbewertung', style: context.text.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    'Hake ab, was in deiner Antwort wirklich steht.',
                    style: context.text.bodySmall?.copyWith(color: c.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Gap.m),
            _Score(earned: earned, total: total),
          ],
        ),
        if (listed > total) ...[
          const SizedBox(height: Gap.s),
          Text(
            needed != null && needed < q.criteria.length
                ? '$needed von ${q.criteria.length} Nennungen genügen für '
                      'die volle Punktzahl – die Liste zeigt alle Möglichkeiten.'
                : 'Für die volle Punktzahl genügen $total von $listed '
                      'möglichen Punkten.',
            style: context.text.bodySmall?.copyWith(color: c.textMuted),
          ),
        ],
        const SizedBox(height: Gap.m),
        if (isSuggestion && q.criteria.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Gap.m,
              vertical: Gap.s,
            ),
            decoration: BoxDecoration(
              color: c.infoBg,
              borderRadius: BorderRadius.circular(Radii.s),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Icon(Icons.auto_awesome, size: 16, color: c.info),
                ),
                const SizedBox(width: Gap.s),
                Expanded(
                  child: Text(
                    'Vorschlag der App – bitte selbst prüfen',
                    style: context.text.labelSmall?.copyWith(
                      color: c.info,
                      letterSpacing: 0.2,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Gap.s),
        ],
        for (var i = 0; i < q.criteria.length; i++) ...[
          _CriterionTile(
            key: ValueKey('krit-$i'),
            criterion: q.criteria[i],
            checked: checked.contains(i),
            onTap: () => _toggle(i),
          ),
          if (i < q.criteria.length - 1) const SizedBox(height: Gap.s),
        ],
        const SizedBox(height: Gap.m),
        const HintLine(
          'Die IHK wertet auch andere fachlich richtige Antworten.',
          icon: Icons.info_outline,
        ),
      ],
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({required this.earned, required this.total});

  final int earned;
  final int total;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final full = total > 0 && earned >= total;
    final (fg, bg) = full
        ? (c.success, c.successBg)
        : earned > 0
        ? (c.flame, c.flameBg)
        : (c.textMuted, c.surfaceAlt);
    return Semantics(
      label: '$earned von $total Punkten',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: Gap.s),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(Radii.m),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$earned / $total',
              maxLines: 1,
              softWrap: false,
              style: AppType.numeric(
                size: 18,
                weight: FontWeight.w700,
                color: fg,
              ),
            ),
            Text(
              total == 1 ? 'Punkt' : 'Punkte',
              maxLines: 1,
              softWrap: false,
              style: context.text.labelSmall?.copyWith(color: fg),
            ),
          ],
        ),
      ),
    );
  }
}

class _CriterionTile extends StatelessWidget {
  const _CriterionTile({
    super.key,
    required this.criterion,
    required this.checked,
    required this.onTap,
  });

  final Criterion criterion;
  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final fg = checked ? c.success : c.textMuted;
    return Semantics(
      checked: checked,
      button: true,
      child: Material(
        color: checked ? c.successBg : context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.m),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.m),
          child: Container(
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(
              horizontal: Gap.m,
              vertical: Gap.m,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.m),
              border: Border.all(
                color: checked ? c.success : c.border,
                width: checked ? 1.6 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  checked ? Icons.check_box : Icons.check_box_outline_blank,
                  size: 24,
                  color: fg,
                ),
                const SizedBox(width: Gap.m),
                Expanded(
                  child: HyphenText(
                    criterion.text,
                    style: context.text.bodyMedium,
                  ),
                ),
                const SizedBox(width: Gap.s),
                CountBadge(
                  label: '${criterion.points} P.',
                  tone: checked ? TileTone.success : TileTone.brand,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
