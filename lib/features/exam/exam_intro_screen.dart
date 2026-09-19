import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/progress.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../learn/session_launcher.dart';

/// Ein Simulationsformat.
class ExamPreset {
  const ExamPreset({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.questions,
    required this.minutes,
  });

  final String id;
  final String title;
  final String subtitle;
  final int questions;
  final int minutes;
}

const kExamPresets = <ExamPreset>[
  ExamPreset(
    id: 'kurz',
    title: 'Kurztest',
    subtitle: 'Fuer zwischendurch - reicht, um Zeitgefuehl aufzubauen.',
    questions: 10,
    minutes: 20,
  ),
  ExamPreset(
    id: 'halb',
    title: 'Halbe Pruefung',
    subtitle: 'Realistischer Ausschnitt, gut fuer die Woche vor der AP1.',
    questions: 18,
    minutes: 45,
  ),
  ExamPreset(
    id: 'voll',
    title: 'Komplette Simulation',
    subtitle: 'Themenmix nach Punkteanteil, 90 Minuten wie im Ernstfall.',
    questions: 30,
    minutes: 90,
  ),
];

/// Der Einstieg in die Pruefungssimulation.
///
/// Die Regeln stehen bewusst VOR dem Start und nicht als Hinweis waehrend des
/// Laufs: Wer sich auf Zeitdruck einlaesst, soll wissen, worauf er sich
/// einlaesst. Danach gibt es keine Erklaerungen mehr bis zur Abgabe.
class ExamIntroScreen extends ConsumerWidget {
  const ExamIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pool = ref.watch(questionsProvider);
    final history = ref.watch(progressProvider).history;
    final examRuns = history.where((r) => r.mode == SessionMode.pruefung);

    return Scaffold(
      appBar: AppBar(title: const Text('Pruefungssimulation')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NoteBox(
                  tone: NoteTone.warn,
                  title: 'So laeuft die Simulation',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Der Countdown laeuft durch. Ist er abgelaufen, '
                          'wird automatisch abgegeben.'),
                      SizedBox(height: Gap.s),
                      Text('Kein Feedback waehrend des Laufs - du erfaehrst '
                          'erst nach der Abgabe, was richtig war.'),
                      SizedBox(height: Gap.s),
                      Text('Du kannst frei zwischen den Aufgaben springen und '
                          'unsichere Aufgaben fuer spaeter markieren.'),
                      SizedBox(height: Gap.s),
                      Text('Unbeantwortete Aufgaben zaehlen mit 0 Punkten - '
                          'genau wie eine leere Zeile im Pruefungsbogen.'),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.xl),
                const SectionHeader('Format waehlen'),
                for (final p in kExamPresets) ...[
                  _PresetCard(
                    preset: p,
                    available: pool.length,
                    onStart: () => SessionLauncher.exam(
                      context,
                      ref,
                      count: p.questions.clamp(1, pool.length),
                      limit: Duration(minutes: p.minutes),
                      title: p.title,
                    ),
                  ),
                  const SizedBox(height: Gap.m),
                ],
                if (examRuns.isNotEmpty) ...[
                  const SizedBox(height: Gap.l),
                  const SectionHeader('Bisherige Simulationen'),
                  _ExamHistory(records: examRuns.toList()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.preset,
    required this.available,
    required this.onStart,
  });

  final ExamPreset preset;
  final int available;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final count = preset.questions.clamp(1, available);
    final perQuestion = (preset.minutes * 60 / count).round();

    return AppCard(
      padding: const EdgeInsets.all(Gap.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(preset.title, style: context.text.titleLarge),
              ),
              Text('${preset.minutes} Min.',
                  style: AppType.numeric(
                      size: 16, color: context.scheme.primary)),
            ],
          ),
          const SizedBox(height: Gap.xs),
          Text(
            preset.subtitle,
            style:
                context.text.bodyMedium?.copyWith(color: context.c.textMuted),
          ),
          const SizedBox(height: Gap.l),
          Wrap(
            spacing: Gap.s,
            runSpacing: Gap.s,
            children: [
              MetaChip(label: '$count Aufgaben', icon: Icons.list_alt),
              MetaChip(
                label: 'ca. ${perQuestion}s pro Aufgabe',
                icon: Icons.timer_outlined,
              ),
              const MetaChip(
                label: 'Themenmix nach Gewichtung',
                icon: Icons.pie_chart_outline,
              ),
            ],
          ),
          const SizedBox(height: Gap.l),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onStart,
              child: const Text('Simulation starten'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExamHistory extends StatelessWidget {
  const _ExamHistory({required this.records});

  final List<AnswerRecord> records;

  @override
  Widget build(BuildContext context) {
    // Nach Tag gruppieren - ein Simulationslauf bucht alle Antworten mit
    // demselben Zeitstempel.
    final byRun = <String, List<AnswerRecord>>{};
    for (final r in records) {
      final key = r.at.toIso8601String().substring(0, 16);
      byRun.putIfAbsent(key, () => []).add(r);
    }
    final runs = byRun.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return Column(
      children: [
        for (final run in runs.take(5))
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.s),
            child: AppCard(
              padding: const EdgeInsets.all(Gap.l),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${run.key.substring(8, 10)}.${run.key.substring(5, 7)}. '
                      'um ${run.key.substring(11)} Uhr',
                      style: context.text.bodyMedium,
                    ),
                  ),
                  Text('${run.value.length} Aufgaben',
                      style: context.text.labelSmall
                          ?.copyWith(color: context.c.textMuted)),
                  const SizedBox(width: Gap.m),
                  Text(
                    '${((run.value.fold<double>(0, (s, r) => s + r.score) / run.value.length) * 100).round()} %',
                    style: AppType.numeric(size: 15),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
