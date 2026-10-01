import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/answer_format.dart';
import '../../core/util/exam_composer.dart';
import '../../state/session_controller.dart';
import '../../widgets/common.dart';
import '../../widgets/hyphenation.dart';

/// Rest- oder Laufzeit in der Kopfzeile.
///
/// Mit Zeitlimit zählt sie herunter und wird in den letzten fünf Minuten
/// orange, in der letzten rot (zusätzlich wechselt das Symbol - die Aussage
/// hängt nicht allein an der Farbe). Ohne Limit zeigt sie neutral die
/// bisherige Zeit.
class TimeBadge extends StatelessWidget {
  const TimeBadge({super.key, required this.session});

  final SessionState session;

  @override
  Widget build(BuildContext context) {
    final remaining = session.remaining;
    final warn = remaining != null && remaining.inMinutes < 5;
    final critical = remaining != null && remaining.inMinutes < 1;
    final color = critical
        ? context.c.danger
        : (warn ? context.c.flame : context.c.textMuted);

    return Semantics(
      label: remaining != null ? 'Restzeit' : 'Bisherige Zeit',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: 6),
        decoration: BoxDecoration(
          color: critical
              ? context.c.dangerBg
              : warn
              ? context.c.flameBg
              : context.c.surfaceAlt,
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              remaining == null
                  ? Icons.schedule
                  : critical
                  ? Icons.alarm
                  : Icons.timer_outlined,
              size: 15,
              color: color,
            ),
            const SizedBox(width: 5),
            Text(
              formatDuration(remaining ?? session.elapsed),
              // Die Kopfzeile ist schmal: Die Uhr wächst mit der
              // Systemschrift nur moderat mit.
              textScaler: MediaQuery.textScalerOf(
                context,
              ).clamp(maxScaleFactor: 1.15),
              style: AppType.numeric(size: 14, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// Punktangabe wie am Rand des Prüfungsbogens.
class PointsPill extends StatelessWidget {
  const PointsPill({super.key, required this.label, this.tone});

  final String label;

  /// Ohne Angabe neutral (Punktzahl der Aufgabe), sonst eingefärbt
  /// (erreichte Punkte).
  final TileTone? tone;

  /// „3 von 4 P.“ mit passender Farbe.
  factory PointsPill.earned(SessionItem item, {Key? key}) {
    final g = item.grade;
    return PointsPill(
      key: key,
      label: '${formatPoints(item.earned)} von ${item.question.points} P.',
      tone: g == null
          ? null
          : g.isCorrect
          ? TileTone.success
          : item.earned > 0
          ? TileTone.flame
          : TileTone.danger,
    );
  }

  @override
  Widget build(BuildContext context) {
    final (fg, bg) =
        tone?.colors(context) ?? (context.c.textMuted, context.c.surfaceAlt);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Text(
        label,
        maxLines: 1,
        softWrap: false,
        style: AppType.numeric(size: 13, color: fg),
      ),
    );
  }
}

/// Kopf einer Aufgabe mit einklappbarer Situation.
///
/// Die Situation bleibt bei jeder Teilaufgabe erreichbar, ohne dass man
/// zurückblättern muss - eingeklappt nimmt sie nur eine Zeile weg.
class TaskHeader extends StatelessWidget {
  const TaskHeader({
    super.key,
    required this.number,
    required this.task,
    required this.expanded,
    required this.onToggle,
    this.timeUsed,
  });

  final int number;
  final ExamTask task;
  final bool expanded;
  final VoidCallback onToggle;

  /// Bisher mit dieser Aufgabe verbrachte Zeit; `null` blendet die
  /// Zeitzeile aus (Auswertung).
  final Duration? timeUsed;

  bool get _hasSituation =>
      task.situation.trim().isNotEmpty || task.otherCompany != null;

  @override
  Widget build(BuildContext context) {
    final guide = ExamComposer.guideTime(task.points);
    final over = timeUsed != null && timeUsed! > guide;

    final head = Padding(
      padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.s, Gap.m),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AUFGABE $number  ·  ${task.points} PUNKTE',
                  style: context.text.labelSmall?.copyWith(
                    color: context.scheme.primary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                HyphenText(task.title, style: context.text.titleMedium),
                if (timeUsed != null) ...[
                  const SizedBox(height: Gap.xs),
                  Text(
                    'Richtzeit ${guide.inMinutes} min  ·  bisher '
                    '${formatDuration(timeUsed!)}',
                    style: context.text.labelSmall?.copyWith(
                      color: over ? context.c.flame : context.c.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (_hasSituation)
            SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                expanded ? Icons.expand_less : Icons.expand_more,
                color: context.c.textMuted,
              ),
            )
          else
            const SizedBox(width: Gap.s),
        ],
      ),
    );

    return Material(
      color: context.c.surfaceAlt,
      borderRadius: BorderRadius.circular(Radii.m),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_hasSituation)
            Semantics(
              button: true,
              label: expanded ? 'Situation einklappen' : 'Situation anzeigen',
              child: InkWell(onTap: onToggle, child: head),
            )
          else
            head,
          if (_hasSituation && expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 1, color: context.c.border),
                  const SizedBox(height: Gap.m),
                  if (task.otherCompany != null) ...[
                    HyphenText(
                      'Diese Aufgabe spielt bei einem anderen Unternehmen: '
                      '${task.otherCompany!.description}',
                      style: context.text.bodyMedium?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                    const SizedBox(height: Gap.m),
                  ],
                  if (task.situation.trim().isNotEmpty)
                    HyphenText(task.situation, style: context.text.bodyMedium),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Buchstabe einer Teilaufgabe - groß wie auf dem Bogen.
class PartBadge extends StatelessWidget {
  const PartBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      padding: const EdgeInsets.symmetric(horizontal: Gap.s),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.scheme.primaryContainer,
        borderRadius: BorderRadius.circular(Radii.m),
      ),
      child: Text(
        label,
        style: AppType.numeric(size: 16, color: context.scheme.primary),
      ),
    );
  }
}

/// Zeile mit Balken: „Rechnen  7 von 12 P.“ - für die Auswertung nach
/// Aufgabe, Antwortformat und Katalogbereich.
class ScoreRow extends StatelessWidget {
  const ScoreRow({
    super.key,
    required this.icon,
    required this.title,
    required this.earned,
    required this.possible,
    this.overline,
    this.caption,
  });

  final IconData icon;
  final String title;
  final String? overline;
  final String? caption;
  final double earned;
  final int possible;

  @override
  Widget build(BuildContext context) {
    final ratio = possible == 0 ? 0.0 : earned / possible;
    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.scheme.primary),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (overline != null)
                  Text(
                    overline!,
                    style: context.text.labelSmall?.copyWith(
                      color: context.c.textMuted,
                      letterSpacing: 1,
                    ),
                  ),
                HyphenText(title, style: context.text.titleSmall),
                const SizedBox(height: Gap.s),
                Row(
                  children: [
                    Expanded(child: TopicBar(confidence: ratio, coverage: 0)),
                    const SizedBox(width: Gap.m),
                    Text(
                      '${formatPoints(earned)} von $possible P.',
                      style: AppType.numeric(size: 13),
                    ),
                  ],
                ),
                if (caption != null) ...[
                  const SizedBox(height: Gap.xs),
                  Text(
                    caption!,
                    style: context.text.labelSmall?.copyWith(
                      color: context.c.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
