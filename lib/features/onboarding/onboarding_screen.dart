import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/profile.dart';
import '../../data/models/exam_area.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';

/// Onboarding in vier Schritten.
///
/// Leitgedanke: Nach spaetestens 60 Sekunden muss der erste Nutzen sichtbar
/// sein. Deshalb wird nur abgefragt, was den Lernplan wirklich veraendert -
/// Beruf, Pruefungstermin, Zeitbudget. Kein Konto, keine E-Mail, keine
/// Datenschutzerklaerung vor dem ersten Erfolgserlebnis. Registrieren kann
/// man spaeter in den Einstellungen, um den Fortschritt zu sichern.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  final _nameController = TextEditingController();

  int _step = 0;
  Beruf _beruf = Beruf.fiae;
  DateTime _examDate = UserProfile.nextIhkDate();
  LernIntensitaet _intensitaet = LernIntensitaet.solide;

  static const _stepCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _go(int next) {
    if (next < 0 || next >= _stepCount) return;
    setState(() => _step = next);
    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _finish() {
    ref.read(profileProvider.notifier).completeOnboarding(
          name: _nameController.text.trim(),
          beruf: _beruf,
          examDate: _examDate,
          intensitaet: _intensitaet,
        );
    context.go('/');
  }

  int get _daysLeft {
    final now = DateTime.now();
    return DateTime(_examDate.year, _examDate.month, _examDate.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReadableWidth(
          maxWidth: 620,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(Gap.xl, Gap.l, Gap.xl, 0),
                child: Row(
                  children: [
                    if (_step > 0)
                      IconButton(
                        onPressed: () => _go(_step - 1),
                        icon: const Icon(Icons.arrow_back),
                        tooltip: 'Zurueck',
                      )
                    else
                      const SizedBox(width: 48),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < _stepCount; i++)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              height: 5,
                              width: i == _step ? 28 : 16,
                              decoration: BoxDecoration(
                                color: i <= _step
                                    ? context.scheme.primary
                                    : context.c.border,
                                borderRadius: BorderRadius.circular(Radii.pill),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _WelcomeStep(controller: _nameController),
                    _BerufStep(
                      value: _beruf,
                      onChanged: (b) => setState(() => _beruf = b),
                    ),
                    _ExamDateStep(
                      value: _examDate,
                      daysLeft: _daysLeft,
                      onChanged: (d) => setState(() => _examDate = d),
                    ),
                    _IntensityStep(
                      value: _intensitaet,
                      daysLeft: _daysLeft,
                      onChanged: (i) => setState(() => _intensitaet = i),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Gap.xl),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _step == _stepCount - 1
                        ? _finish
                        : () => _go(_step + 1),
                    child: Text(
                      _step == _stepCount - 1
                          ? 'Lernplan erstellen'
                          : 'Weiter',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(Gap.xl, Gap.xl, Gap.xl, Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.text.displaySmall),
          const SizedBox(height: Gap.s),
          Text(
            subtitle,
            style: context.text.bodyLarge?.copyWith(color: context.c.textMuted),
          ),
          const SizedBox(height: Gap.xxl),
          child,
        ],
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      title: 'AP1 Trainer',
      subtitle:
          'Alle sieben Bereiche des Pruefungskatalogs ab 2025 - von '
          'Projektmanagement ueber Netzwerke bis Datenschutz. Mit '
          'Uebungsaufgaben und Lernkarteikarten.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Wie sollen wir dich nennen? (optional)',
              hintText: 'Vorname',
            ),
          ),
          const SizedBox(height: Gap.xl),
          const NoteBox(
            tone: NoteTone.info,
            title: 'Kein Konto noetig',
            child: Text(
              'Dein Fortschritt bleibt zunaechst nur auf diesem Geraet. '
              'Wenn du ihn spaeter auf mehreren Geraeten brauchst, kannst du '
              'dich in den Einstellungen registrieren.',
            ),
          ),
          const SizedBox(height: Gap.xl),
          Text(
            'Die sieben Bereiche des Pruefungskatalogs 2025',
            style: context.text.labelSmall?.copyWith(color: context.c.textMuted),
          ),
          const SizedBox(height: Gap.s),
          // Die sieben Bereiche statt aller 35 Themen: Hier soll man den
          // Umfang erfassen, nicht ein Inhaltsverzeichnis lesen.
          for (final a in ExamAreas.all)
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.xs),
              child: Row(
                children: [
                  SizedBox(
                    width: 26,
                    child: Text(
                      a.number,
                      style: context.text.labelSmall
                          ?.copyWith(color: context.c.textMuted),
                    ),
                  ),
                  Icon(a.icon, size: 16, color: context.scheme.primary),
                  const SizedBox(width: Gap.s),
                  Expanded(
                    child: Text(a.title, style: context.text.bodyMedium),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _BerufStep extends StatelessWidget {
  const _BerufStep({required this.value, required this.onChanged});

  final Beruf value;
  final ValueChanged<Beruf> onChanged;

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      title: 'Dein Ausbildungsberuf',
      subtitle:
          'Der Projektmanagement-Teil ist fuer alle IT-Berufe gleich. Wir '
          'nutzen den Beruf nur, um Beispiele passend zu waehlen.',
      child: Column(
        children: [
          for (final b in Beruf.values) ...[
            SelectTile(
              title: b.label,
              selected: value == b,
              onTap: () => onChanged(b),
            ),
            const SizedBox(height: Gap.s),
          ],
        ],
      ),
    );
  }
}

class _ExamDateStep extends StatelessWidget {
  const _ExamDateStep({
    required this.value,
    required this.daysLeft,
    required this.onChanged,
  });

  final DateTime value;
  final int daysLeft;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('EEEE, d. MMMM yyyy', 'de_DE');
    final now = DateTime.now();

    final suggestions = <DateTime>[
      DateTime(now.year, 3, 4),
      DateTime(now.year, 9, 23),
      DateTime(now.year + 1, 3, 4),
      DateTime(now.year + 1, 9, 23),
    ].where((d) => d.isAfter(now)).take(3).toList();

    return _StepScaffold(
      title: 'Wann ist deine AP1?',
      subtitle:
          'Daraus berechnen wir dein Tagespensum und die Reihenfolge der '
          'Themen.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fmt.format(value),
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: Gap.xs),
                Row(
                  children: [
                    Text('$daysLeft',
                        style: AppType.numeric(
                            size: 30, color: context.scheme.primary)),
                    const SizedBox(width: Gap.s),
                    Text(
                      daysLeft == 1 ? 'Tag verbleibend' : 'Tage verbleibend',
                      style: context.text.bodyMedium
                          ?.copyWith(color: context.c.textMuted),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.m),
                OutlinedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: value,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 900)),
                      locale: const Locale('de', 'DE'),
                    );
                    if (picked != null) onChanged(picked);
                  },
                  icon: const Icon(Icons.calendar_today_outlined, size: 18),
                  label: const Text('Datum aendern'),
                ),
              ],
            ),
          ),
          const SizedBox(height: Gap.xl),
          Text('Uebliche IHK-Termine',
              style: context.text.labelSmall
                  ?.copyWith(color: context.c.textMuted)),
          const SizedBox(height: Gap.s),
          Wrap(
            spacing: Gap.s,
            runSpacing: Gap.s,
            children: [
              for (final d in suggestions)
                ActionChip(
                  label: Text(DateFormat('d. MMM yyyy', 'de_DE').format(d)),
                  onPressed: () => onChanged(d),
                ),
            ],
          ),
          const SizedBox(height: Gap.l),
          Text(
            'Die genauen Termine legt deine IHK fest - pruefe sie im Zweifel '
            'in deiner Einladung zur Pruefung.',
            style:
                context.text.labelSmall?.copyWith(color: context.c.textMuted),
          ),
        ],
      ),
    );
  }
}

class _IntensityStep extends StatelessWidget {
  const _IntensityStep({
    required this.value,
    required this.daysLeft,
    required this.onChanged,
  });

  final LernIntensitaet value;
  final int daysLeft;
  final ValueChanged<LernIntensitaet> onChanged;

  @override
  Widget build(BuildContext context) {
    final total = daysLeft * value.questionsPerDay;
    return _StepScaffold(
      title: 'Wie viel Zeit hast du?',
      subtitle:
          'Lieber taeglich 15 Minuten als einmal die Woche zwei Stunden. '
          'Die Einstellung kannst du jederzeit aendern.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final i in LernIntensitaet.values) ...[
            SelectTile(
              title: i.label,
              subtitle:
                  '${i.minutesPerDay} Min. pro Tag, etwa ${i.questionsPerDay} Aufgaben',
              selected: value == i,
              onTap: () => onChanged(i),
            ),
            const SizedBox(height: Gap.s),
          ],
          const SizedBox(height: Gap.l),
          NoteBox(
            tone: NoteTone.success,
            title: 'Dein Plan',
            child: Text(
              'Bei $daysLeft Tagen bis zur Pruefung und ${value.questionsPerDay} '
              'Aufgaben pro Tag kommst du auf rund $total bearbeitete Aufgaben. '
              'Die letzten Tage halten wir fuer Wiederholung und '
              'Pruefungssimulationen frei.',
            ),
          ),
        ],
      ),
    );
  }
}
