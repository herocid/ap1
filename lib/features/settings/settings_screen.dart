import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/env.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/profile.dart';
import '../../state/providers.dart';
import '../../widgets/brand.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';

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
                _SettingsGroup(
                  children: [
                    _SettingsRow(
                      icon: Icons.event_outlined,
                      title: 'Prüfungstermin',
                      subtitle:
                          '${DateFormat('d. MMMM yyyy', 'de_DE').format(profile.examDate)} '
                          '· noch ${profile.daysUntilExam} Tage',
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: profile.examDate.isBefore(DateTime.now())
                              ? DateTime.now()
                              : profile.examDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 900),
                          ),
                          locale: const Locale('de', 'DE'),
                        );
                        if (picked != null) {
                          notifier.update((p) => p.copyWith(examDate: picked));
                        }
                      },
                    ),
                    _SettingsRow(
                      icon: Icons.speed_outlined,
                      title: 'Lernintensität',
                      subtitle:
                          '${profile.intensitaet.label} · '
                          '${profile.intensitaet.questionsPerDay} Aufgaben, '
                          '${profile.intensitaet.minutesPerDay} Min. pro Tag',
                      onTap: () => _pickIntensity(context, ref, profile),
                    ),
                    _SettingsRow(
                      icon: Icons.badge_outlined,
                      title: 'Ausbildungsberuf',
                      subtitle: profile.beruf.label,
                      onTap: () => _pickBeruf(context, ref, profile),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.xl),

                const SectionHeader('Daten'),
                _SettingsGroup(
                  children: [
                    _SettingsRow(
                      icon: Env.hasSupabase
                          ? Icons.cloud_done_outlined
                          : Icons.cloud_off_outlined,
                      tone: Env.hasSupabase ? TileTone.success : TileTone.info,
                      title: Env.hasSupabase
                          ? 'Mit Supabase verbunden'
                          : 'Offline-Modus',
                      subtitle: Env.hasSupabase
                          ? 'Aufgaben werden vom Server geladen, '
                                'Fortschritt bleibt zusätzlich lokal.'
                          : 'Alles läuft lokal mit den eingebauten '
                                'Aufgaben. Für die Server-Anbindung '
                                'SUPABASE_ANON_KEY per --dart-define setzen.',
                    ),
                    _SettingsRow(
                      icon: Icons.delete_outline,
                      tone: TileTone.danger,
                      title: 'Fortschritt zurücksetzen',
                      titleColor: context.c.danger,
                      subtitle:
                          '${progress.totalAnswered} beantwortete Aufgaben, '
                          'Streak und Erfolge werden gelöscht.',
                      onTap: () => _confirmReset(context, ref),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.xl),

                const SectionHeader('Über die App'),
                _SettingsGroup(
                  children: [
                    _SettingsRow(
                      leading: const Mascot(size: TileIcon.kTileIconSize),
                      title: 'Einführung ansehen',
                      subtitle: 'Bit erklärt noch einmal die Tabs',
                      onTap: () => context.push('/einfuehrung'),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.s),
                const AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWordmark(size: 32),
                      SizedBox(height: Gap.l),
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
          'Historie, Streak, Level, Erfolge, Karteikasten und der '
          'Fortschritt der Learning Journey werden entfernt. '
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
      ref.read(deckProvider.notifier).reset();
      ref.read(journeyProvider.notifier).reset();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fortschritt zurückgesetzt.')),
        );
      }
    }
  }
}

/// Eine Gruppe von Einstellungszeilen in einer Karte, getrennt durch
/// eingerückte Linien (bündig mit dem Text, nicht mit dem Symbol).
class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                indent: Gap.l + TileIcon.kTileIconSize + Gap.m,
                color: context.c.border,
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Einstellungszeile im Kachel-Stil: Symbol 44, Titel, Untertitel, Pfeil.
/// Titel brechen nie mitten im Wort um („Ausbildungsberu-f“).
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.title,
    required this.subtitle,
    this.icon,
    this.leading,
    this.tone = TileTone.brand,
    this.titleColor,
    this.onTap,
  });

  final IconData? icon;
  final Widget? leading;
  final TileTone tone;
  final String title;
  final Color? titleColor;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: EdgeInsets.fromLTRB(
        Gap.l,
        Gap.m,
        onTap == null ? Gap.l : Gap.m,
        Gap.m,
      ),
      child: Row(
        children: [
          leading ?? TileIcon(icon: icon!, tone: tone),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WordSafeText(
                  title,
                  style: context.text.titleSmall?.copyWith(color: titleColor),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: context.text.bodySmall?.copyWith(
                    color: context.c.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: Gap.xs),
            Icon(Icons.chevron_right, color: context.c.textMuted),
          ],
        ],
      ),
    );
    if (onTap == null) return row;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Radii.l),
      child: row,
    );
  }
}
