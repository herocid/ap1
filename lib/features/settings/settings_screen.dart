import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/env.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/profile.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);
    final progress = ref.watch(progressProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Gap.l, 0, Gap.l, Gap.xxxl),
        children: [
          ReadableWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader('Darstellung'),
                Column(
                  children: [
                    for (final m in ThemeMode.values) ...[
                      SelectTile(
                        title: switch (m) {
                          ThemeMode.system => 'Wie das System',
                          ThemeMode.light => 'Immer hell',
                          ThemeMode.dark => 'Immer dunkel',
                        },
                        icon: switch (m) {
                          ThemeMode.system => Icons.brightness_auto_outlined,
                          ThemeMode.light => Icons.light_mode_outlined,
                          ThemeMode.dark => Icons.dark_mode_outlined,
                        },
                        selected: profile.themeMode == m,
                        onTap: () => notifier.setThemeMode(m),
                      ),
                      const SizedBox(height: Gap.s),
                    ],
                  ],
                ),
                const SizedBox(height: Gap.xl),

                const SectionHeader('Prüfung & Pensum'),
                AppCard(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.event_outlined),
                        title: const Text('Prüfungstermin'),
                        subtitle: Text(
                          '${DateFormat('d. MMMM yyyy', 'de_DE').format(profile.examDate)} '
                          '· noch ${profile.daysUntilExam} Tage',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: profile.examDate.isBefore(DateTime.now())
                                ? DateTime.now()
                                : profile.examDate,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 900)),
                            locale: const Locale('de', 'DE'),
                          );
                          if (picked != null) {
                            notifier.update((p) => p.copyWith(examDate: picked));
                          }
                        },
                      ),
                      Divider(color: context.c.border),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.speed_outlined),
                        title: const Text('Lernintensität'),
                        subtitle: Text(
                          '${profile.intensitaet.label} · '
                          '${profile.intensitaet.questionsPerDay} Aufgaben, '
                          '${profile.intensitaet.minutesPerDay} Min. pro Tag',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _pickIntensity(context, ref, profile),
                      ),
                      Divider(color: context.c.border),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.badge_outlined),
                        title: const Text('Ausbildungsberuf'),
                        subtitle: Text(profile.beruf.label),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _pickBeruf(context, ref, profile),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.xl),

                const SectionHeader('Daten'),
                AppCard(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Env.hasSupabase ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
                          color: Env.hasSupabase ? context.c.success : context.c.textMuted,
                        ),
                        title: Text(
                          Env.hasSupabase
                              ? 'Mit Supabase verbunden'
                              : 'Offline-Modus',
                        ),
                        subtitle: Text(
                          Env.hasSupabase
                              ? 'Aufgaben werden vom Server geladen, '
                                  'Fortschritt bleibt zusätzlich lokal.'
                              : 'Alles läuft lokal mit den eingebauten '
                                  'Aufgaben. Für die Server-Anbindung '
                                  'SUPABASE_ANON_KEY per --dart-define setzen.',
                        ),
                        isThreeLine: true,
                      ),
                      Divider(color: context.c.border),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.delete_outline,
                            color: context.c.danger),
                        title: Text(
                          'Fortschritt zurücksetzen',
                          style: TextStyle(color: context.c.danger),
                        ),
                        subtitle: Text(
                          '${progress.totalAnswered} beantwortete Aufgaben, '
                          'Streak und Erfolge werden gelöscht.',
                        ),
                        onTap: () => _confirmReset(context, ref),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.xl),

                const SectionHeader('Über die App'),
                const AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alle Aufgaben sind eigene Formulierungen im Stil der '
                        'IHK-Abschlussprüfung Teil 1. Es werden keine '
                        'Originalaufgaben verwendet - die sind '
                        'urheberrechtlich geschützt.',
                      ),
                      SizedBox(height: Gap.m),
                      Text(
                        'Die Angaben zu Gewichtung und Prüfungsterminen sind '
                        'Schätzungen zur Lernsteuerung, keine Auskunft deiner '
                        'IHK.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _pickIntensity(BuildContext context, WidgetRef ref, UserProfile p) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lernintensität', style: ctx.text.titleLarge),
              const SizedBox(height: Gap.l),
              for (final i in LernIntensitaet.values) ...[
                SelectTile(
                  title: i.label,
                  subtitle:
                      '${i.minutesPerDay} Min. pro Tag, etwa ${i.questionsPerDay} Aufgaben',
                  selected: p.intensitaet == i,
                  onTap: () {
                    ref
                        .read(profileProvider.notifier)
                        .update((x) => x.copyWith(intensitaet: i));
                    Navigator.of(ctx).pop();
                  },
                ),
                const SizedBox(height: Gap.s),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _pickBeruf(BuildContext context, WidgetRef ref, UserProfile p) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ausbildungsberuf', style: ctx.text.titleLarge),
              const SizedBox(height: Gap.l),
              for (final b in Beruf.values) ...[
                SelectTile(
                  title: b.label,
                  selected: p.beruf == b,
                  onTap: () {
                    ref
                        .read(profileProvider.notifier)
                        .update((x) => x.copyWith(beruf: b));
                    Navigator.of(ctx).pop();
                  },
                ),
                const SizedBox(height: Gap.s),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Fortschritt wirklich löschen?'),
        content: const Text(
          'Historie, Streak, Level und Erfolge werden entfernt. '
          'Das lässt sich nicht rückgängig machen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
    if (ok == true) {
      ref.read(progressProvider.notifier).reset();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fortschritt zurückgesetzt.')),
        );
      }
    }
  }
}
