import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/cards/card_picker_screen.dart';
import '../features/cards/card_session_screen.dart';
import '../features/cards/cards_overview_screen.dart';
import '../features/dashboard/area_detail_screen.dart';
import '../features/dashboard/area_session_screen.dart';
import '../features/dashboard/areas_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/journey/journey_screen.dart';
import '../features/journey/lesson_screen.dart';
import '../features/info/catalog_changes_screen.dart';
import '../features/exam/exam_intro_screen.dart';
import '../features/exam/exam_run_screen.dart';
import '../features/learn/result_screen.dart';
import '../features/learn/session_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/onboarding/tutorial_screen.dart';
import '../features/quiz/quiz_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/shell/app_shell.dart';
import '../features/stats/stats_screen.dart';
import '../state/providers.dart';

final _rootKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    // Solange das Onboarding nicht durch ist, führt jeder Weg dorthin.
    redirect: (context, state) {
      final onboarded = ref.read(profileProvider).onboarded;
      final atOnboarding = state.matchedLocation == '/onboarding';
      if (!onboarded && !atOnboarding) return '/onboarding';
      if (onboarded && atOnboarding) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // Session, Ergebnis und Simulation liegen über der Shell: während
      // einer Runde soll die Navigationsleiste nicht ablenken.
      GoRoute(
        path: '/session',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const SessionScreen(),
      ),
      GoRoute(
        path: '/ergebnis',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const ResultScreen(),
      ),
      GoRoute(
        path: '/pruefung',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const ExamIntroScreen(),
      ),
      // Laufender Prüfungsbogen: Deckblatt, Aufgaben, Selbstbewertung.
      GoRoute(
        path: '/pruefung-lauf',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const ExamRunScreen(),
      ),
      GoRoute(
        path: '/karten-lernen',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => CardSessionScreen(
          args: state.extra as CardSessionArgs? ?? const CardSessionArgs(),
        ),
      ),
      GoRoute(
        path: '/karten-auswahl',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const CardPickerScreen(),
      ),
      GoRoute(
        path: '/bereich/:areaId',
        parentNavigatorKey: _rootKey,
        builder: (context, state) =>
            AreaDetailScreen(areaId: state.pathParameters['areaId']!),
      ),
      // Session zu einem Themengebiet: Lernen, Karteikarten, Quiz.
      GoRoute(
        path: '/session-bereich/:areaId',
        parentNavigatorKey: _rootKey,
        builder: (context, state) =>
            AreaSessionScreen(areaId: state.pathParameters['areaId']!),
      ),
      GoRoute(
        path: '/katalog-aenderungen',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const CatalogChangesScreen(),
      ),
      GoRoute(
        path: '/themen',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const AreasScreen(),
      ),
      GoRoute(
        path: '/einfuehrung',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const TutorialScreen(),
      ),
      GoRoute(
        path: '/einstellungen',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/lektion/:id',
        parentNavigatorKey: _rootKey,
        builder: (context, state) =>
            LessonScreen(lessonId: state.pathParameters['id']!),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/journey',
                builder: (context, state) => const JourneyScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/quiz',
                builder: (context, state) => const QuizScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/karten',
                builder: (context, state) => const CardsOverviewScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/statistik',
                builder: (context, state) => const StatsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
