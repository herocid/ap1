import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Navigationsrahmen.
///
/// Unter 900 px eine BottomBar (Daumen erreicht sie), darüber eine
/// NavigationRail (der Platz ist da, und eine BottomBar auf einem 27-Zoll-
/// Monitor sieht falsch aus). Fünf Ziele sind die Obergrenze; die
/// Einstellungen liegen deshalb als Symbol auf der Startseite statt in der
/// Leiste.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = <({IconData icon, IconData active, String label})>[
    (icon: Icons.home_outlined, active: Icons.home_rounded, label: 'Start'),
    (icon: Icons.menu_book_outlined, active: Icons.menu_book, label: 'Lernen'),
    (icon: Icons.dynamic_feed_outlined, active: Icons.dynamic_feed, label: 'Feed'),
    (icon: Icons.style_outlined, active: Icons.style, label: 'Karten'),
    (icon: Icons.insights_outlined, active: Icons.insights, label: 'Statistik'),
  ];

  void _onTap(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= Breakpoints.medium;

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onTap,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.active),
                    label: Text(d.label),
                  ),
              ],
            ),
            VerticalDivider(width: 1, color: context.c.border),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.active),
              label: d.label,
            ),
        ],
      ),
    );
  }
}
