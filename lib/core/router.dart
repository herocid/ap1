import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/topics_screen.dart';
import '../features/exam/exam_intro_screen.dart';
import '../features/learn/result_screen.dart';
import '../features/learn/session_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/shell/app_shell.dart';
import '../features/stats/stats_screen.dart';
import '../state/providers.dart';

final _rootKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    // Solange das Onboarding nicht durch ist, fuehrt jeder Weg dorthin.
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
      // Session, Ergebnis und Simulation liegen ueber der Shell: waehrend
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
                path: '/themen',
                builder: (context, state) => const TopicsScreen(),
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/einstellungen',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
