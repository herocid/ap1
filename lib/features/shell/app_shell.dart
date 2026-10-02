import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/util/haptics.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/brand.dart';
import '../../widgets/common.dart';

/// Ein Ziel der Hauptnavigation.
typedef AppDestination = ({IconData icon, IconData active, String label});

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

  /// Reihenfolge nach dem Lernweg: neuen Stoff lernen (Journey), abfragen
  /// (Quiz), wiederholen (Karten), Stand ansehen (Statistik).
  static const destinations = <AppDestination>[
    // Aktiver Reiter: dasselbe Symbol, hervorgehoben durch Pille und Farbe.
    // Die gefüllten Varianten fehlten im Web-Build (Icon-Tree-Shaking) - das
    // Symbol verschwand genau dann, wenn der Reiter aktiv war.
    (icon: Icons.home_outlined, active: Icons.home_outlined, label: 'Start'),
    (
      icon: Icons.route_outlined,
      active: Icons.route_outlined,
      label: 'Journey',
    ),
    (icon: Icons.quiz_outlined, active: Icons.quiz_outlined, label: 'Quiz'),
    (icon: Icons.style_outlined, active: Icons.style_outlined, label: 'Karten'),
    (
      icon: Icons.insights_outlined,
      active: Icons.insights_outlined,
      label: 'Statistik',
    ),
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
              backgroundColor: context.scheme.surface,
              indicatorColor: context.scheme.primary,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.m),
              ),
              selectedIconTheme: IconThemeData(
                color: context.scheme.onPrimary,
                size: 24,
              ),
              unselectedIconTheme: IconThemeData(
                color: context.scheme.onSurfaceVariant,
                size: 24,
              ),
              minWidth: 88,
              leading: const Padding(
                padding: EdgeInsets.only(top: Gap.s, bottom: Gap.xl),
                child: AppLogo(size: 40),
              ),
              destinations: [
                for (final d in destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.active),
                    label: Text(d.label, maxLines: 1, softWrap: false),
                    padding: const EdgeInsets.only(bottom: Gap.xs),
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
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onSelected: _onTap,
      ),
    );
  }
}

/// Die Reiterleiste unten.
///
/// Eigene Umsetzung statt Material-NavigationBar, weil die mit fünf Reitern
/// auf 320 px und großer Systemschrift „Statistik“ bis an den Rand schiebt
/// und die Labels einzeln statt gemeinsam behandelt. Hier gilt:
///
/// * Jeder Reiter ist gleich breit; Symbol und Label stehen exakt mittig
///   übereinander, mit festen Abständen (12 · 32 · 4 · Label · 16).
/// * Alle Labels sind einzeilig und gleich groß. Reicht der Platz für das
///   längste nicht, wird die Schrift für alle gemeinsam so weit reduziert,
///   dass es passt ([fittingTextScaler]) - nie abgeschnitten, nie umbrochen.
/// * Aktiv: gefülltes, abgerundetes Feld in Markenfarbe hinter dem Symbol
///   (Symbol weiß), Label fett in Markenfarbe. Das Feld blendet beim
///   Wechsel weich ein und wächst leicht auf.
/// * Die Leiste schwebt als abgerundete Fläche mit weichem Schatten und
///   Abstand zum Rand über dem System-Gestenbereich (SafeArea).
///
/// [onSelected] null zeigt die Leiste nur an (Vorschau in der Einführung).
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onSelected,
    this.destinations = AppShell.destinations,
    this.framed = true,
  });

  final int selectedIndex;
  final ValueChanged<int>? onSelected;
  final List<AppDestination> destinations;

  /// Mit Fläche, oberer Trennlinie und SafeArea - aus für die Vorschau.
  final bool framed;

  /// Breite des Feldes hinter dem Symbol.
  static const double indicatorWidth = 52;
  static const double indicatorHeight = 32;

  /// Seitlicher Mindestabstand eines Labels zur Reitergrenze.
  static const double labelInset = 4;

  /// Große Systemschrift wird bis hierhin übernommen. Darüber hinaus wird
  /// die Leiste nur höher, aber nicht lesbarer - iOS und Android begrenzen
  /// ihre Leisten ebenso.
  static const double maxTextScale = 1.3;

  @override
  Widget build(BuildContext context) {
    final bar = LayoutBuilder(
      builder: (context, box) {
        final itemWidth = box.maxWidth / destinations.length;
        // Gemessen wird mit dem fetten Stil: Der aktive Reiter darf nicht
        // breiter werden als der Platz.
        final scaler = fittingTextScaler(
          context,
          texts: [for (final d in destinations) d.label],
          style: AppType.navLabel(selected: true),
          maxWidth: itemWidth - 2 * labelInset,
          maxScale: maxTextScale,
        );
        final indW = (itemWidth - 2 * labelInset).clamp(0.0, indicatorWidth);
        final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
        final row = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < destinations.length; i++)
              Expanded(
                child: _NavItem(
                  destination: destinations[i],
                  selected: i == selectedIndex,
                  index: i,
                  count: destinations.length,
                  textScaler: scaler,
                  indicatorWidth: indW,
                  onTap: onSelected == null ? null : () => onSelected!(i),
                ),
              ),
          ],
        );
        // Eine Pille, die zum aktiven Reiter gleitet, statt fünf Felder, die
        // ein- und ausblenden: Der Wechsel wirkt wie eine Bewegung.
        final dark = Theme.of(context).brightness == Brightness.dark;
        return Stack(
          children: [
            AnimatedPositioned(
              duration: reduce || onSelected == null
                  ? Duration.zero
                  : const Duration(milliseconds: 320),
              curve: Curves.easeOutBack,
              left: itemWidth * selectedIndex + (itemWidth - indW) / 2,
              top: Gap.m,
              width: indW,
              height: indicatorHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.scheme.primary.withValues(
                    alpha: dark ? 0.26 : 0.12,
                  ),
                  borderRadius: BorderRadius.circular(indicatorHeight / 2),
                ),
              ),
            ),
            row,
          ],
        );
      },
    );

    if (!framed) return bar;

    final dark = Theme.of(context).brightness == Brightness.dark;
    // Volle Breite, bündig unten (wie iOS und Android selbst), mit feiner
    // Kante und leichtem Schatten nach oben.
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.scheme.surface,
        border: Border(top: BorderSide(color: context.c.border, width: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.35 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Gap.xs),
          child: Material(type: MaterialType.transparency, child: bar),
        ),
      ),
    );
  }

  /// Eckenradius der schwebenden Leiste.
  static const double barRadius = 24;
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.index,
    required this.count,
    required this.textScaler,
    required this.indicatorWidth,
    required this.onTap,
  });

  final AppDestination destination;
  final bool selected;
  final int index;
  final int count;
  final TextScaler textScaler;
  final double indicatorWidth;
  final VoidCallback? onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _pressed = false;
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;
    final selected = widget.selected;
    final fg = selected ? scheme.primary : scheme.onSurfaceVariant;
    final iconColor = selected ? scheme.primary : scheme.onSurfaceVariant;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    // In der Vorschau (Einführung, ohne onTap) ohne Überblendung: Auf einer
    // Seite, die gerade ins Bild wischt, steht der Ticker still.
    final duration = reduce || widget.onTap == null
        ? Duration.zero
        : const Duration(milliseconds: 240);

    // Rückmeldung beim Drücken, Überfahren und Tastaturfokus: eine leichte
    // Tönung in der Feldform statt einer Ripple über den ganzen Reiter.
    final overlay = _pressed
        ? 0.12
        : (_hovered || _focused)
        ? 0.08
        : 0.0;

    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: widget.indicatorWidth,
            height: AppNavigationBar.indicatorHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (overlay > 0)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.onSurface.withValues(alpha: overlay),
                      borderRadius: BorderRadius.circular(
                        AppNavigationBar.indicatorHeight / 2,
                      ),
                    ),
                    child: const SizedBox.expand(),
                  ),
                // In der Vorschau (Einführung, ohne onTap) ohne Überblendung:
                // Auf einer Seite, die gerade ins Bild wischt, steht der
                // Ticker still - das Symbol blieb dann unsichtbar.
                if (widget.onTap == null)
                  Icon(
                    selected
                        ? widget.destination.active
                        : widget.destination.icon,
                    size: 24,
                    color: iconColor,
                  )
                else
                  AnimatedSwitcher(
                    duration: duration,
                    child: Icon(
                      selected
                          ? widget.destination.active
                          : widget.destination.icon,
                      key: ValueKey(selected),
                      size: 24,
                      color: iconColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Gap.xs),
          Text(
            widget.destination.label,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaler: widget.textScaler,
            style: AppType.navLabel(selected: selected, color: fg),
          ),
        ],
      ),
    );

    return Semantics(
      container: true,
      button: true,
      selected: selected,
      enabled: widget.onTap != null,
      label:
          '${widget.destination.label}, Reiter ${widget.index + 1} '
          'von ${widget.count}',
      excludeSemantics: true,
      child: widget.onTap == null
          ? content
          : InkWell(
              onTap: () {
                if (!selected) AppHaptics.select();
                widget.onTap!();
              },
              onHighlightChanged: (v) => setState(() => _pressed = v),
              onHover: (v) => setState(() => _hovered = v),
              onFocusChange: (v) => setState(() => _focused = v),
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: content,
            ),
    );
  }
}
