import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Dauer des einheitlichen Seitenübergangs.
const kPageTransitionDuration = Duration(milliseconds: 280);

/// Seite mit weichem Übergang: Einblenden und leichtes Hochgleiten.
///
/// Bei "Animationen reduzieren" (MediaQuery.disableAnimations) steht die
/// Seite sofort, ohne Animation.
Page<void> fadeSlidePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.name,
    arguments: state.extra,
    child: child,
    transitionDuration: kPageTransitionDuration,
    reverseTransitionDuration: kPageTransitionDuration,
    transitionsBuilder: fadeSlideTransition,
  );
}

/// Übergang für [CustomTransitionPage]: 8 % Versatz nach unten, easeOutCubic.
Widget fadeSlideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;
  final curved = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );
  return FadeTransition(
    opacity: curved,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.08),
        end: Offset.zero,
      ).animate(curved),
      child: child,
    ),
  );
}
