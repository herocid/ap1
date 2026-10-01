import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/notifications/reminder_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../state/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/mascot.dart';
import '../shell/app_shell.dart';

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
    final first = !ref.read(profileProvider).tutorialSeen;
    ref.read(profileProvider.notifier).markTutorialSeen();
    // Erinnerungen sind standardmäßig an - nach der ersten Einführung
    // einmal um Erlaubnis fragen, sonst blieben sie stumm. Auf dem Web und
    // in Tests passiert nichts.
    if (first && ref.read(profileProvider).remindersOn) {
      ReminderService.instance.requestPermission();
    }
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
                                      horizontal: Gap.m,
                                    ),
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
    // Erst stellt Bit sich vor, dann führt er Tab für Tab durch die App.
    const _PageData(
      intro: true,
      mood: MascotMood.wave,
      title: 'Hallo! Ich bin Bit.',
      speech:
          'Ich bin ein kleiner Roboter und kenne den Prüfungskatalog '
          'der AP1 auswendig. Ab heute bin ich dein Coach.',
      points: [
        'Ich sage dir jeden Tag, was als Nächstes dran ist.',
        'Ich gebe dir überall Tipps. Tipp mich an, dann kommt der nächste.',
        'Und wenn etwas nicht klappt, üben wir es einfach noch einmal.',
      ],
    ),
    const _PageData(
      mood: MascotMood.happy,
      tab: 0,
      title: 'Start: Dein Tag auf einen Blick',
      speech:
          'Auf der Startseite steht immer, was jetzt am meisten bringt: '
          'ein Tipp von mir und ein großer Knopf.',
      points: [
        'Tagesziel: eine gemischte Runde, erst Fehler, dann Schwächen',
        'Weitermachen: Journey und Karten genau da, wo du aufgehört hast',
        'Countdown bis zu deiner Prüfung',
      ],
    ),
    _PageData(
      mood: MascotMood.happy,
      tab: 1,
      title: 'Journey: Neues lernen',
      speech:
          'In der Journey bringe ich dir den kompletten Stoff bei, in '
          '$lessons kurzen Lektionen, eine nach der anderen.',
      points: const [
        'Erst die Idee, dann ein Beispiel, dann die Prüfungsfalle',
        'Zum Schluss das Wichtigste in Kürze',
        'Unterbrochen? Ich merke mir den Schritt.',
      ],
    ),
    const _PageData(
      mood: MascotMood.think,
      tab: 2,
      title: 'Quiz: Abgefragt werden',
      speech:
          'Im Quiz erkläre ich nichts. Hier frage ich dich ab, in den '
          'Aufgabenformaten der echten IHK-Prüfung.',
      points: [
        'Kurztest: Zufallsfragen, bis du aufhörst',
        'Gezielt ein Thema üben',
        'Falsche Antworten kommen im Fehlerspeicher wieder',
      ],
    ),
    const _PageData(
      mood: MascotMood.think,
      tab: 2,
      title: 'Prüfung: Der Ernstfall zum Üben',
      speech:
          'Die Prüfungssimulation ist aufgebaut wie die echte AP1: ein '
          'Unternehmen, vier Fallaufgaben, 90 Minuten.',
      points: [
        'Je Aufgabe 25 Punkte, zusammen 100',
        'Freitext mit Bewertung nach Kriterien wie bei der IHK',
        'Am Ende deine Note nach dem IHK-Schlüssel',
      ],
    ),
    const _PageData(
      mood: MascotMood.happy,
      tab: 3,
      title: 'Karten: Schnell wiederholen',
      speech:
          'Karteikarten lege ich dir genau dann wieder hin, wenn du sie '
          'sonst vergessen würdest.',
      points: [
        'Nicht gewusst? Die Karte kommt in derselben Runde wieder.',
        'Jeden Tag 20 neue Karten plus deine Wiederholungen',
        'Durchlauf: alle Karten, bis du alles weißt',
      ],
    ),
    const _PageData(
      mood: MascotMood.happy,
      tab: 0,
      title: 'Sessions: Alles zu einem Thema',
      speech:
          'Wenn du ein Themengebiet am Stück durcharbeiten willst, '
          'starte auf der Startseite eine Session.',
      points: [
        'Erst lernen, dann die Karten dazu, dann ein kurzes Quiz',
        'Etwa 15 Minuten je Lektion',
      ],
    ),
    const _PageData(
      mood: MascotMood.cheer,
      tab: 4,
      title: 'Statistik: Was sitzt, was hakt',
      speech:
          'In der Statistik siehst du, wie du bei Karten und Quiz '
          'abschneidest und welche Themen noch Arbeit brauchen.',
      points: [
        'Problemthemen antippen startet die passende Übung',
        'Dein Fortschritt in der Journey',
        '20 Abzeichen zum Sammeln',
      ],
    ),
    const _PageData(
      mood: MascotMood.cheer,
      title: 'Jeden Tag ein Stück',
      speech:
          'Mein wichtigster Tipp: lieber jeden Tag 15 Minuten als einmal '
          'die Woche drei Stunden. Abstand ist der Trick beim Behalten.',
      points: [
        'Tagesziel erreichen hält deine Serie am Leben',
        'Du kannst diese Einführung in den Einstellungen wieder ansehen',
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
            if (page.tab != null)
              _NavPreview(active: page.tab!)
            else
              Center(child: Mascot(mood: page.mood, size: 120)),
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

/// Die echte Reiterleiste als Vorschau, mit dem gemeinten Reiter aktiv -
/// so sieht sie in der Einführung genau so aus wie danach in der App.
class _NavPreview extends StatelessWidget {
  const _NavPreview({required this.active});

  final int active;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: Gap.xs),
        child: AppNavigationBar(selectedIndex: active, framed: false),
      ),
    );
  }
}
