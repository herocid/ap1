import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Navigationsrahmen.
///
/// Unter 900 px eine BottomBar (Daumen erreicht sie), darueber eine
/// NavigationRail (der Platz ist da, und eine BottomBar auf einem 27-Zoll-
/// Monitor sieht falsch aus). Vier Ziele - mehr passt weder in die Leiste
/// noch in den Kopf.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = <({IconData icon, IconData active, String label})>[
    (icon: Icons.home_outlined, active: Icons.home, label: 'Start'),
    (icon: Icons.category_outlined, active: Icons.category, label: 'Katalog'),
    (icon: Icons.style_outlined, active: Icons.style, label: 'Karten'),
    (icon: Icons.insights_outlined, active: Icons.insights, label: 'Statistik'),
    (icon: Icons.settings_outlined, active: Icons.settings, label: 'Mehr'),
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
