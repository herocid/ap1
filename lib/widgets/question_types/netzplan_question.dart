import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/netzplan.dart';
import '../../data/models/question.dart';
import 'number_input.dart';

const double _nodeW = 178;
/// Hoehe einer Zellenzeile im Knoten. Muss die Korrekturanzeige nach dem
/// Pruefen (Eingabe + kleine Musterloesung darunter) aufnehmen.
const double _rowH = 40;
const double _gapX = 54;
const double _gapY = 22;

/// Interaktiver Vorgangsknoten-Netzplan.
///
/// Designentscheidungen, die hier den Unterschied machen:
/// - Der Plan wird automatisch nach topologischen Ebenen angeordnet und die
///   Pfeile werden gezeichnet. Der Lernende ordnet nichts an, er RECHNET -
///   das ist die Faehigkeit, die geprueft wird.
/// - Nur die gefragten Felder sind Eingabefelder. Was nicht gefragt ist,
///   bleibt sichtbar leer, damit die gewohnte Knotenform erhalten bleibt.
/// - Eingabe: auf dem Handy ein eigenes Ziffernfeld (die Systemtastatur
///   verdeckt sonst den halben Plan), auf dem Desktop direktes Tippen mit
///   Tab-Sprung zur naechsten Zelle.
/// - Nach dem Pruefen wird jede Zelle einzeln bewertet und der kritische Pfad
///   hervorgehoben.
class NetzplanQuestionView extends StatefulWidget {
  const NetzplanQuestionView({
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
  State<NetzplanQuestionView> createState() => _NetzplanQuestionViewState();
}

class _NetzplanQuestionViewState extends State<NetzplanQuestionView> {
  final Map<String, TextEditingController> _controllers = {};
  bool _showRules = false;
  bool _showPath = false;

  Map<String, int> get _values =>
      (widget.answer as Map<String, int>?) ?? const <String, int>{};

  @override
  void didUpdateWidget(covariant NetzplanQuestionView old) {
    super.didUpdateWidget(old);
    if (old.question.id != widget.question.id) {
      for (final c in _controllers.values) {
        c.dispose();
      }
      _controllers.clear();
      _showPath = false;
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _controllerFor(String key) {
    return _controllers.putIfAbsent(key, () {
      final v = _values[key];
      return TextEditingController(text: v?.toString() ?? '');
    });
  }

  void _setValue(String key, int? value) {
    final next = {..._values};
    if (value == null) {
      next.remove(key);
    } else {
      next[key] = value;
    }
    widget.onChanged(next);
  }

  /// Topologische Ebenen: Ebene 0 = Vorgaenge ohne Vorgaenger.
  Map<String, int> _levels() {
    final acts = widget.question.activities;
    final byId = {for (final a in acts) a.id: a};
    final level = <String, int>{};

    int compute(String id, Set<String> seen) {
      if (level.containsKey(id)) return level[id]!;
      if (!seen.add(id)) return 0; // Zyklusschutz
      final a = byId[id];
      if (a == null || a.predecessors.isEmpty) {
        level[id] = 0;
        return 0;
      }
      var maxP = -1;
      for (final p in a.predecessors) {
        if (!byId.containsKey(p)) continue;
        maxP = math.max(maxP, compute(p, seen));
      }
      final v = maxP + 1;
      level[id] = v;
      return v;
    }

    for (final a in acts) {
      compute(a.id, <String>{});
    }
    return level;
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.question;
    final solution = q.netzplanSolution;
    if (solution == null) return const SizedBox.shrink();

    final levels = _levels();
    final columns = <int, List<Activity>>{};
    for (final a in q.activities) {
      columns.putIfAbsent(levels[a.id] ?? 0, () => []).add(a);
    }
    final maxLevel = columns.keys.fold<int>(0, math.max);
    final maxRows = columns.values.fold<int>(0, (m, l) => math.max(m, l.length));

    final askedFp = q.askedFields.contains(NodeField.fp);
    final nodeH = askedFp ? 166.0 : 124.0;

    final canvasW = (maxLevel + 1) * _nodeW + maxLevel * _gapX;
    final canvasH = maxRows * nodeH + (maxRows - 1) * _gapY;

    // Position jedes Knotens vorab berechnen - dadurch koennen die Pfeile
    // exakt gezeichnet werden, ohne die Kinder messen zu muessen.
    final positions = <String, Rect>{};
    for (final entry in columns.entries) {
      final col = entry.key;
      final list = entry.value;
      final colHeight = list.length * nodeH + (list.length - 1) * _gapY;
      final yOffset = (canvasH - colHeight) / 2;
      for (var i = 0; i < list.length; i++) {
        positions[list[i].id] = Rect.fromLTWH(
          col * (_nodeW + _gapX),
          yOffset + i * (nodeH + _gapY),
          _nodeW,
          nodeH,
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ActivityTable(activities: q.activities),
        const SizedBox(height: Gap.l),
        Row(
          children: [
            _ToolChip(
              icon: Icons.functions,
              label: 'Regeln',
              active: _showRules,
              onTap: () => setState(() => _showRules = !_showRules),
            ),
            const SizedBox(width: Gap.s),
            if (widget.revealed)
              _ToolChip(
                icon: Icons.route_outlined,
                label: 'Kritischer Pfad',
                active: _showPath,
                onTap: () => setState(() => _showPath = !_showPath),
              ),
            const Spacer(),
            Text(
              '${_values.length}/${q.activities.length * q.askedFields.length}',
              style: AppType.numeric(size: 13, color: context.c.textMuted),
            ),
          ],
        ),
        if (_showRules) ...[
          const SizedBox(height: Gap.m),
          _RulesBox(fields: q.askedFields),
        ],
        const SizedBox(height: Gap.m),
        _Legend(askedFields: q.askedFields, askedFp: askedFp),
        const SizedBox(height: Gap.m),
        // Der Plan wird fast immer breiter als das Display - horizontal
        // scrollen ist hier die ehrlichste Loesung. Zoomen waere auf dem
        // Handy schick, macht die Eingabefelder aber unzuverlaessig treffbar.
        Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: Gap.m),
            child: SizedBox(
              width: canvasW,
              height: canvasH,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _EdgePainter(
                        activities: q.activities,
                        positions: positions,
                        color: context.c.border,
                        criticalColor: context.c.flame,
                        highlightCritical: widget.revealed && _showPath,
                        criticalPath: solution.criticalPath.toSet(),
                      ),
                    ),
                  ),
                  for (final a in q.activities)
                    Positioned(
                      left: positions[a.id]!.left,
                      top: positions[a.id]!.top,
                      width: _nodeW,
                      height: nodeH,
                      child: _NetzNode(
                        activity: a,
                        result: solution.nodes[a.id]!,
                        askedFields: q.askedFields,
                        values: _values,
                        revealed: widget.revealed,
                        parts: widget.grade?.parts ?? const {},
                        highlightCritical: widget.revealed &&
                            _showPath &&
                            solution.nodes[a.id]!.isCritical,
                        controllerFor: _controllerFor,
                        onValue: _setValue,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.revealed) ...[
          const SizedBox(height: Gap.l),
          _SolutionSummary(solution: solution),
        ],
      ],
    );
  }
}

// ----------------------------------------------------------------- Knoten

class _NetzNode extends StatelessWidget {
  const _NetzNode({
    required this.activity,
    required this.result,
    required this.askedFields,
    required this.values,
    required this.revealed,
    required this.parts,
    required this.highlightCritical,
    required this.controllerFor,
    required this.onValue,
  });

  final Activity activity;
  final NodeResult result;
  final List<NodeField> askedFields;
  final Map<String, int> values;
  final bool revealed;
  final Map<String, bool> parts;
  final bool highlightCritical;
  final TextEditingController Function(String) controllerFor;
  final void Function(String, int?) onValue;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final askedFp = askedFields.contains(NodeField.fp);

    return Container(
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(
          color: highlightCritical ? c.flame : c.border,
          width: highlightCritical ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          _row(context, [
            _cell(context, NodeField.faz),
            _staticCell(context, '${activity.duration}', 'D', emphasize: true),
            _cell(context, NodeField.fez),
          ]),
          Container(height: 1, color: c.border),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activity.id,
                    style: AppType.numeric(
                      size: 15,
                      color: context.scheme.primary,
                    ),
                  ),
                  Text(
                    activity.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: context.text.labelSmall
                        ?.copyWith(color: c.textMuted, letterSpacing: 0),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: c.border),
          _row(context, [
            _cell(context, NodeField.saz),
            _cell(context, NodeField.gp),
            _cell(context, NodeField.sez),
          ]),
          if (askedFp) ...[
            Container(height: 1, color: c.border),
            _row(context, [_cell(context, NodeField.fp, wide: true)]),
          ],
        ],
      ),
    );
  }

  Widget _row(BuildContext context, List<Widget> children) {
    return SizedBox(
      height: _rowH,
      child: Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            Expanded(child: children[i]),
            if (i < children.length - 1)
              Container(width: 1, color: context.c.border),
          ],
        ],
      ),
    );
  }

  Widget _staticCell(BuildContext context, String text, String label,
      {bool emphasize = false}) {
    return Container(
      alignment: Alignment.center,
      color: emphasize ? context.c.surfaceAlt : null,
      child: Text(
        text,
        style: AppType.numeric(
          size: 14,
          color: emphasize ? context.scheme.onSurface : context.c.textMuted,
        ),
      ),
    );
  }

  Widget _cell(BuildContext context, NodeField field, {bool wide = false}) {
    final asked = askedFields.contains(field);
    if (!asked) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          field.short,
          style: context.text.labelSmall?.copyWith(
            color: context.c.textMuted.withValues(alpha: 0.5),
          ),
        ),
      );
    }
    return _EditableCell(
      key: ValueKey('${activity.id}.${field.name}'),
      cellKey: '${activity.id}.${field.name}',
      field: field,
      activity: activity,
      truth: result.value(field),
      value: values['${activity.id}.${field.name}'],
      revealed: revealed,
      isCorrect: parts['${activity.id}.${field.name}'],
      controllerFor: controllerFor,
      onValue: onValue,
      wide: wide,
    );
  }
}

class _EditableCell extends StatelessWidget {
  const _EditableCell({
    super.key,
    required this.cellKey,
    required this.field,
    required this.activity,
    required this.truth,
    required this.value,
    required this.revealed,
    required this.isCorrect,
    required this.controllerFor,
    required this.onValue,
    required this.wide,
  });

  final String cellKey;
  final NodeField field;
  final Activity activity;
  final int truth;
  final int? value;
  final bool revealed;
  final bool? isCorrect;
  final TextEditingController Function(String) controllerFor;
  final void Function(String, int?) onValue;
  final bool wide;

  Future<void> _openKeypad(BuildContext context) async {
    final result = await showNumericKeypad(
      context,
      title: '${field.short} von Vorgang ${activity.id}',
      hint: field.long,
      initial: value?.toString() ?? '',
      allowNegative: field == NodeField.gp || field == NodeField.fp,
    );
    if (result == null) return;
    final parsed = int.tryParse(result);
    controllerFor(cellKey).text = result;
    onValue(cellKey, parsed);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;

    Color bg = Colors.transparent;
    Color fg = context.scheme.onSurface;
    if (revealed) {
      if (isCorrect == true) {
        bg = c.successBg;
        fg = c.success;
      } else {
        bg = c.dangerBg;
        fg = c.danger;
      }
    } else if (value != null) {
      bg = context.scheme.primary.withValues(alpha: 0.07);
    }

    if (revealed) {
      return Container(
        color: bg,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value?.toString() ?? '–',
              style: AppType.numeric(size: 13.5, color: fg)
                  .copyWith(height: 1.15),
            ),
            if (isCorrect != true)
              Text(
                '$truth',
                style: AppType.numeric(
                  size: 10.5,
                  weight: FontWeight.w500,
                  color: c.success,
                ).copyWith(height: 1.15),
              ),
          ],
        ),
      );
    }

    // Handy: eigenes Ziffernfeld. Desktop/Tablet: direkt tippen.
    if (useKeypadLayout(context)) {
      return Material(
        color: bg,
        child: InkWell(
          onTap: () => _openKeypad(context),
          child: Container(
            alignment: Alignment.center,
            child: value == null
                ? Text(
                    field.short,
                    style: context.text.labelSmall
                        ?.copyWith(color: c.textMuted.withValues(alpha: 0.75)),
                  )
                : Text('$value', style: AppType.numeric(size: 14, color: fg)),
          ),
        ),
      );
    }

    return Container(
      color: bg,
      child: TextField(
        controller: controllerFor(cellKey),
        textAlign: TextAlign.center,
        style: AppType.numeric(size: 14),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]'))],
        onChanged: (s) => onValue(cellKey, int.tryParse(s)),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          hintText: field.short,
          hintStyle: context.text.labelSmall
              ?.copyWith(color: c.textMuted.withValues(alpha: 0.6)),
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.scheme.primary, width: 2),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------ Pfeile

class _EdgePainter extends CustomPainter {
  _EdgePainter({
    required this.activities,
    required this.positions,
    required this.color,
    required this.criticalColor,
    required this.highlightCritical,
    required this.criticalPath,
  });

  final List<Activity> activities;
  final Map<String, Rect> positions;
  final Color color;
  final Color criticalColor;
  final bool highlightCritical;
  final Set<String> criticalPath;

  @override
  void paint(Canvas canvas, Size size) {
    for (final a in activities) {
      final to = positions[a.id];
      if (to == null) continue;
      for (final p in a.predecessors) {
        final from = positions[p];
        if (from == null) continue;

        final isCritical = highlightCritical &&
            criticalPath.contains(p) &&
            criticalPath.contains(a.id);

        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = isCritical ? 2.4 : 1.4
          ..color = isCritical ? criticalColor : color;

        final start = Offset(from.right, from.center.dy);
        final end = Offset(to.left, to.center.dy);
        final midX = (start.dx + end.dx) / 2;

        final path = Path()
          ..moveTo(start.dx, start.dy)
          ..cubicTo(midX, start.dy, midX, end.dy, end.dx, end.dy);
        canvas.drawPath(path, paint);

        // Pfeilspitze
        final head = Path()
          ..moveTo(end.dx, end.dy)
          ..lineTo(end.dx - 7, end.dy - 4)
          ..lineTo(end.dx - 7, end.dy + 4)
          ..close();
        canvas.drawPath(
          head,
          Paint()..color = isCritical ? criticalColor : color,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_EdgePainter old) =>
      old.highlightCritical != highlightCritical ||
      old.color != color ||
      old.positions.length != positions.length;
}

// ------------------------------------------------------------- Beiwerk

class _ActivityTable extends StatelessWidget {
  const _ActivityTable({required this.activities});

  final List<Activity> activities;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Gap.m, Gap.s, Gap.m, Gap.xs),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Text('Nr',
                      style: context.text.labelSmall
                          ?.copyWith(color: c.textMuted)),
                ),
                Expanded(
                  child: Text('Vorgang',
                      style: context.text.labelSmall
                          ?.copyWith(color: c.textMuted)),
                ),
                SizedBox(
                  width: 44,
                  child: Text('Dauer',
                      textAlign: TextAlign.right,
                      style: context.text.labelSmall
                          ?.copyWith(color: c.textMuted)),
                ),
                SizedBox(
                  width: 80,
                  child: Text('Vorgaenger',
                      textAlign: TextAlign.right,
                      style: context.text.labelSmall
                          ?.copyWith(color: c.textMuted)),
                ),
              ],
            ),
          ),
          for (final a in activities)
            Padding(
              padding: const EdgeInsets.fromLTRB(Gap.m, 3, Gap.m, 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(a.id,
                        style: AppType.numeric(
                            size: 13, color: context.scheme.primary)),
                  ),
                  Expanded(
                    child: Text(a.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.bodyMedium),
                  ),
                  SizedBox(
                    width: 44,
                    child: Text('${a.duration}',
                        textAlign: TextAlign.right,
                        style: AppType.numeric(size: 13)),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      a.predecessors.isEmpty ? '–' : a.predecessors.join(', '),
                      textAlign: TextAlign.right,
                      style: AppType.numeric(size: 13, color: c.textMuted),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: Gap.s),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.askedFields, required this.askedFp});

  final List<NodeField> askedFields;
  final bool askedFp;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Wrap(
      spacing: Gap.m,
      runSpacing: Gap.xs,
      children: [
        for (final f in NodeField.values)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: askedFields.contains(f)
                      ? context.scheme.primary
                      : c.border,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '${f.short} = ${f.long}',
                style: context.text.labelSmall?.copyWith(
                  color: askedFields.contains(f)
                      ? context.scheme.onSurface
                      : c.textMuted,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _RulesBox extends StatelessWidget {
  const _RulesBox({required this.fields});

  final List<NodeField> fields;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final lines = <String>[
      if (fields.contains(NodeField.faz))
        'FAZ = groesster FEZ aller Vorgaenger (Startvorgang: 0)',
      if (fields.contains(NodeField.fez)) 'FEZ = FAZ + Dauer',
      if (fields.contains(NodeField.sez))
        'SEZ = kleinster SAZ aller Nachfolger (Endvorgang: Projektdauer)',
      if (fields.contains(NodeField.saz)) 'SAZ = SEZ - Dauer',
      if (fields.contains(NodeField.gp)) 'GP = SAZ - FAZ = SEZ - FEZ',
      if (fields.contains(NodeField.fp))
        'FP = kleinster FAZ der Nachfolger - eigener FEZ',
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.m),
      decoration: BoxDecoration(
        color: c.infoBg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.info.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final l in lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              child: Text(l, style: AppType.mono(size: 12.5, color: c.info)),
            ),
        ],
      ),
    );
  }
}

class _SolutionSummary extends StatelessWidget {
  const _SolutionSummary({required this.solution});

  final NetzplanSolution solution;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Projektdauer',
                    style:
                        context.text.labelSmall?.copyWith(color: c.textMuted)),
                Text('${solution.projectDuration} Tage',
                    style: AppType.numeric(size: 18)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kritischer Pfad',
                    style:
                        context.text.labelSmall?.copyWith(color: c.textMuted)),
                Text(solution.criticalPath.join(' – '),
                    style: AppType.numeric(size: 18, color: c.flame)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolChip extends StatelessWidget {
  const _ToolChip({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = active ? context.scheme.primary : context.c.textMuted;
    return Material(
      color: active
          ? context.scheme.primary.withValues(alpha: 0.1)
          : context.c.surfaceAlt,
      borderRadius: BorderRadius.circular(Radii.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: fg),
              const SizedBox(width: 5),
              Text(label,
                  style: context.text.labelSmall?.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
