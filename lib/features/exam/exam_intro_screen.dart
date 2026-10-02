import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../core/util/answer_format.dart';
import '../../core/util/exam_composer.dart';
import '../../data/models/progress.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../learn/session_launcher.dart';
import '../../widgets/bit_tips.dart';

/// Der Einstieg in die Prüfungssimulation.
///
/// Die Regeln stehen bewusst VOR dem Start und nicht als Hinweis während des
/// Laufs: Wer sich auf Zeitdruck einlässt, soll wissen, worauf er sich
/// einlässt. Danach gibt es keine Erklärungen mehr bis zur Abgabe.
class ExamIntroScreen extends ConsumerWidget {
  const ExamIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cases = ref.watch(examCasesProvider);
    final hasCases =
        cases.where((c) => c.parts.isNotEmpty).length >= ExamComposer.minCases;
    final history = ref.watch(progressProvider).history;
    final examRuns = history.where((r) => r.mode == SessionMode.pruefung);
    final pointsById = {
      for (final q in ref.watch(questionsProvider)) q.id: q.points,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Prüfungssimulation')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BitTip(BitSpot.exam, title: 'Bits Prüfungstipp'),
                const SizedBox(height: Gap.l),
                // Neutrale Regeln im Hinweiston (Petrol) - Orange bleibt
                // Motivation und Warnung vorbehalten.
                const NoteBox(
                  tone: NoteTone.info,
                  title: 'Wie in der echten AP1',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Rule(
                        icon: Icons.business_outlined,
                        text:
                            'Ein Unternehmen, vier Aufgaben zu je 25 Punkten '
                            'mit Teilaufgaben a), b), c) …',
                      ),
                      _Rule(
                        icon: Icons.timer_outlined,
                        text:
                            'Die Zeit läuft durch. Rechne mit knapp einer Minute je '
                            'Punkt. Am Ende wird automatisch abgegeben.',
                      ),
                      _Rule(
                        icon: Icons.calculate_outlined,
                        text:
                            'Erlaubt ist nur ein Taschenrechner. Stichworte '
                            'genügen.',
                      ),
                      _Rule(
                        icon: Icons.flag_outlined,
                        text:
                            'Die Reihenfolge bestimmst du. Spring frei hin und her und '
                            'markier Unsicheres zum Nachsehen.',
                      ),
                      _Rule(
                        icon: Icons.visibility_off_outlined,
                        text:
                            'Bis zur Abgabe bekommst du keine Rückmeldung. Danach '
                            'bewertest du deine Freitext-Antworten mit der '
                            'Musterlösung selbst.',
                        last: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.xl),
                const SectionHeader('Umfang wählen'),
                for (final v in kExamVariants) ...[
                  _VariantCard(
                    variant: v,
                    onStart: () => SessionLauncher.exam(context, ref, v),
                  ),
                  const SizedBox(height: Gap.m),
                ],
                if (!hasCases) ...[
                  const NoteBox(
                    child: Text(
                      'Die Fallaufgaben mit durchgängigem Unternehmen sind '
                      'noch in Arbeit. Bis dahin besteht die Simulation aus '
                      'gemischten Einzelaufgaben. Die Punktzahl kann '
                      'abweichen, die Note wird hochgerechnet.',
                    ),
                  ),
                  const SizedBox(height: Gap.m),
                ],
                const SizedBox(height: Gap.s),
                const SectionHeader(
                  'Notenschlüssel der IHK',
                  subtitle: 'Bestanden ist ab 50 von 100 Punkten.',
                ),
                const _GradeKey(),
                if (examRuns.isNotEmpty) ...[
                  const SizedBox(height: Gap.xl),
                  const SectionHeader('Bisherige Simulationen'),
                  _ExamHistory(
                    records: examRuns.toList(),
                    pointsById: pointsById,
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

class _VariantCard extends StatelessWidget {
  const _VariantCard({required this.variant, required this.onStart});

  final ExamVariant variant;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(variant.title, style: context.text.titleLarge),
          const SizedBox(height: Gap.xs),
          Text(
            variant.subtitle,
            style: context.text.bodyMedium?.copyWith(
              color: context.c.textMuted,
            ),
          ),
          const SizedBox(height: Gap.m),
          Wrap(
            spacing: Gap.s,
            runSpacing: Gap.s,
            children: [
              MetaChip(
                label: variant.tasks == 1
                    ? '1 Aufgabe'
                    : '${variant.tasks} Aufgaben',
                icon: Icons.assignment_outlined,
              ),
              MetaChip(
                label: '${variant.points} Punkte',
                icon: Icons.star_outline_rounded,
              ),
              MetaChip(
                label: '${variant.minutes} Minuten',
                icon: Icons.timer_outlined,
              ),
            ],
          ),
          const SizedBox(height: Gap.l),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onStart,
              child: Text('${variant.title} starten'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Notenschlüssel als sechs kleine Felder - passt auch auf 320 px in zwei
/// Reihen.
class _GradeKey extends StatelessWidget {
  const _GradeKey();

  static const _steps = [
    ('1', 'ab 92'),
    ('2', 'ab 81'),
    ('3', 'ab 67'),
    ('4', 'ab 50'),
    ('5', 'ab 30'),
    ('6', 'unter 30'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final scale = MediaQuery.textScalerOf(context).scale(1);
        final perRow = box.maxWidth / (scale > 1.15 ? 104 : 88) >= 6 ? 6 : 3;
        final width = (box.maxWidth - Gap.s * (perRow - 1)) / perRow;
        return Wrap(
          spacing: Gap.s,
          runSpacing: Gap.s,
          children: [
            for (final (note, from) in _steps)
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: Gap.s),
                decoration: BoxDecoration(
                  color: note == '5' || note == '6'
                      ? context.c.surfaceAlt
                      : context.scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(Radii.m),
                ),
                child: Column(
                  children: [
                    Text(
                      note,
                      style: AppType.numeric(
                        size: 18,
                        weight: FontWeight.w700,
                        color: note == '5' || note == '6'
                            ? context.c.textMuted
                            : context.scheme.primary,
                      ),
                    ),
                    Text(
                      from,
                      style: context.text.labelSmall?.copyWith(
                        color: context.c.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ExamHistory extends StatelessWidget {
  const _ExamHistory({required this.records, required this.pointsById});

  final List<AnswerRecord> records;
  final Map<String, int> pointsById;

  @override
  Widget build(BuildContext context) {
    // Ein Simulationslauf bucht alle Antworten mit demselben Zeitstempel.
    final byRun = <String, List<AnswerRecord>>{};
    for (final r in records) {
      final key = r.at.toIso8601String().substring(0, 16);
      byRun.putIfAbsent(key, () => []).add(r);
    }
    final runs = byRun.entries.toList()..sort((a, b) => b.key.compareTo(a.key));

    return Column(
      children: [
        for (final run in runs.take(5))
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.s),
            child: _RunTile(
              stamp: run.key,
              records: run.value,
              pointsById: pointsById,
            ),
          ),
      ],
    );
  }
}

class _RunTile extends StatelessWidget {
  const _RunTile({
    required this.stamp,
    required this.records,
    required this.pointsById,
  });

  final String stamp;
  final List<AnswerRecord> records;
  final Map<String, int> pointsById;

  @override
  Widget build(BuildContext context) {
    // Nach Punkten gewichtet, wie in der Auswertung.
    var earned = 0.0;
    var possible = 0;
    for (final r in records) {
      final p = pointsById[r.questionId] ?? 1;
      earned += halfPoints(r.score * p);
      possible += p;
    }
    final percent = possible == 0 ? 0.0 : earned / possible;
    final note = ihkNote(percent);

    return AppCard(
      padding: const EdgeInsets.all(Gap.l),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stamp.substring(8, 10)}.${stamp.substring(5, 7)}. '
                  'um ${stamp.substring(11)} Uhr',
                  style: context.text.bodyMedium,
                ),
                Text(
                  '${formatPoints(earned)} von $possible Punkten',
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Gap.m),
          Text('Note ${note.note}', style: AppType.numeric(size: 15)),
        ],
      ),
    );
  }
}

/// Eine Regel der Simulation mit eigenem Symbol - vier Absätze Fließtext
/// liest vor dem Start niemand, vier kurze Punkte schon.
class _Rule extends StatelessWidget {
  const _Rule({required this.icon, required this.text, this.last = false});

  final IconData icon;
  final String text;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final body = context.text.bodyMedium!;
    final line =
        MediaQuery.textScalerOf(context).scale(body.fontSize!) *
        (body.height ?? 1.2);
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : Gap.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            // Symbol auf die Mitte der ersten Textzeile setzen - auch bei
            // großer Systemschrift, deshalb aus der echten Zeilenhöhe.
            padding: EdgeInsets.only(top: (line - 16).clamp(0, 99) / 2),
            child: Icon(icon, size: 16, color: context.c.textMuted),
          ),
          const SizedBox(width: Gap.s),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
