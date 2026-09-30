import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';

/// Einführung nach dem Onboarding: Bit erklärt in fünf Karten, wofür jeder
/// Tab da ist.
///
/// Jede Karte zeigt die Navigationsleiste mit dem gemeinten Tab
/// hervorgehoben - so verbindet man die Erklärung sofort mit dem Ort in der
/// App. Überspringen geht jederzeit; wieder aufrufen lässt sie sich in den
/// Einstellungen.
class TutorialScreen extends ConsumerStatefulWidget {
  const TutorialScreen({super.key});

  @override
  ConsumerState<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends ConsumerState<TutorialScreen> {
  final _pager = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  void _done() {
    ref.read(profileProvider.notifier).markTutorialSeen();
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessons = ref.watch(lessonsProvider).length;
    final pages = _pages(lessons);
    final last = _page == pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: ReadableWidth(
          maxWidth: 560,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(Gap.l, Gap.s, Gap.s, 0),
                child: Row(
                  children: [
                    for (var i = 0; i < pages.length; i++)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        margin: const EdgeInsets.only(right: 6),
                        width: i == _page ? 22 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i <= _page
                              ? context.scheme.primary
                              : context.c.border,
                          borderRadius: BorderRadius.circular(Radii.pill),
                        ),
                      ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: last
                            ? const SizedBox(height: 40)
                            : FittedBox(
                                fit: BoxFit.scaleDown,
                                child: TextButton(
                                  onPressed: _done,
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Gap.m),
                                    minimumSize: const Size(0, 40),
                                  ),
                                  child: const Text('Überspringen'),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pager,
                  onPageChanged: (p) => setState(() => _page = p),
                  children: [for (final p in pages) _TutorialPage(page: p)],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Gap.l),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: last
                        ? _done
                        : () => _pager.nextPage(
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOutCubic,
                          ),
                    child: Text(last ? 'Los geht’s' : 'Weiter'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<_PageData> _pages(int lessons) => [
    // Erst stellt Bit sich vor, dann führt er durch die Tabs.
    const _PageData(
      intro: true,
      mood: MascotMood.wave,
      title: 'Hallo! Ich bin Bit.',
      speech:
          'Ich bin ein kleiner Roboter und kenne den Prüfungskatalog '
          'der AP1 auswendig. Ab heute bin ich dein Coach.',
      points: [
        'Ich sage dir jeden Tag, was als Nächstes dran ist.',
        'Ich freue mich mit dir, wenn es klappt.',
        'Und wenn nicht, üben wir es einfach noch einmal.',
      ],
    ),
    _PageData(
      mood: MascotMood.happy,
      tab: 1,
      title: 'Journey: Neues lernen',
      speech:
          'In der Journey bringe ich dir den Stoff bei - in '
          '$lessons kurzen Lektionen, eine nach der anderen.',
      points: const [
        'Erst die Idee, dann ein Beispiel, dann die Prüfungsfalle',
        'Am Ende jeder Lektion ein kleiner Wissenscheck',
      ],
    ),
    const _PageData(
      mood: MascotMood.think,
      tab: 2,
      title: 'Quiz: Abgefragt werden',
      speech:
          'Im Quiz erkläre ich nichts - hier frage ich dich ab. '
          'So sehen wir beide, was schon sitzt.',
      points: [
        'Kurztest: Zufallsfragen, bis du aufhörst',
        'Prüfung: 90 Minuten mit Zeitlimit wie im Ernstfall',
        'Falsche Antworten merke ich mir im Fehlerspeicher',
      ],
    ),
    const _PageData(
      mood: MascotMood.happy,
      tab: 3,
      title: 'Karten: Wiederholen',
      speech:
          'Karteikarten lege ich dir genau dann wieder hin, wenn du '
          'sie sonst vergessen würdest.',
      points: [
        'Gewusst: Die Karte wandert ein Fach weiter',
        'Wiedervorlage nach 1, 2, 4, 9 und 18 Tagen',
      ],
    ),
    const _PageData(
      mood: MascotMood.cheer,
      tab: 0,
      title: 'Jeden Tag ein Stück',
      speech:
          'Auf der Startseite warte ich jeden Tag mit einem Tipp auf '
          'dich. Und in der Statistik siehst du, wie prüfungsreif du bist.',
      points: [
        'Ein Knopf für die Tagesrunde',
        'Streak und Tagesziel halten dich dran',
      ],
    ),
  ];
}

class _PageData {
  const _PageData({
    required this.mood,
    required this.title,
    required this.speech,
    this.points = const [],
    this.tab,
    this.intro = false,
  });

  final MascotMood mood;
  final String title;

  /// Was Bit sagt - in der Ich-Form, er führt durch die App.
  final String speech;
  final List<String> points;

  /// Hervorgehobener Tab der Navigationsleiste, null = keine Leiste.
  final int? tab;

  /// Vorstellungsseite: Bit groß mit Namensschild.
  final bool intro;
}

class _TutorialPage extends StatelessWidget {
  const _TutorialPage({required this.page});

  final _PageData page;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(Gap.xl, Gap.l, Gap.xl, Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (page.intro) ...[
            Center(child: Mascot(mood: page.mood, size: 150)),
            const SizedBox(height: Gap.m),
            Center(
              child: FittedBox(fit: BoxFit.scaleDown, child: _NameTag()),
            ),
            const SizedBox(height: Gap.xl),
            Text(page.title, style: context.text.headlineSmall),
            const SizedBox(height: Gap.s),
            Text(
              page.speech,
              style: context.text.bodyLarge?.copyWith(
                color: context.c.textMuted,
              ),
            ),
          ] else ...[
            _NavPreview(active: page.tab!),
            const SizedBox(height: Gap.xl),
            Text(page.title, style: context.text.headlineSmall),
            const SizedBox(height: Gap.l),
            MascotSays(mood: page.mood, text: page.speech, size: 72),
          ],
          const SizedBox(height: Gap.xl),
          for (final p in page.points)
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.m),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Icon(
                      Icons.check_circle,
                      size: 20,
                      color: context.c.success,
                    ),
                  ),
                  const SizedBox(width: Gap.m),
                  Expanded(child: Text(p, style: context.text.bodyMedium)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Namensschild unter Bit auf der Vorstellungsseite.
class _NameTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Gap.l, vertical: 6),
      decoration: BoxDecoration(
        color: context.c.flameBg,
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(color: context.c.flame.withValues(alpha: 0.35)),
      ),
      child: Text(
        'BIT · DEIN COACH',
        style: context.text.labelSmall?.copyWith(
          color: context.c.flame,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Nachbau der Navigationsleiste mit einem hervorgehobenen Tab.
class _NavPreview extends StatelessWidget {
  const _NavPreview({required this.active});

  final int active;

  static const _items = [
    (Icons.home_rounded, 'Start'),
    (Icons.route, 'Journey'),
    (Icons.quiz, 'Quiz'),
    (Icons.style, 'Karten'),
    (Icons.insights, 'Statistik'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: Gap.m, horizontal: Gap.xs),
      child: Row(
        children: [
          for (var i = 0; i < _items.length; i++)
            Expanded(
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Gap.m,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: i == active
                          ? context.scheme.primaryContainer
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(Radii.pill),
                    ),
                    child: Icon(
                      _items[i].$1,
                      size: 20,
                      color: i == active
                          ? context.scheme.primary
                          : context.c.textMuted.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _items[i].$2,
                      style: context.text.labelSmall?.copyWith(
                        color: i == active
                            ? context.scheme.primary
                            : context.c.textMuted.withValues(alpha: 0.6),
                        fontWeight: i == active
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
