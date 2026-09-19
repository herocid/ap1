import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_theme.dart';

/// Standardkarte. Fasst Padding, Rahmen und Radius an einer Stelle zusammen,
/// damit nicht jeder Screen sein eigenes Container-Rezept erfindet.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Gap.l),
    this.onTap,
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return Material(
      color: color ?? Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(Radii.l),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.l),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.l),
            border: Border.all(color: borderColor ?? context.c.border),
          ),
          child: content,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.action, this.subtitle});

  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.m),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.text.titleMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: context.text.bodyMedium
                        ?.copyWith(color: context.c.textMuted),
                  ),
                ],
              ],
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}

/// Der Pruefungsreife-Indikator.
///
/// Ein Ring statt eines Balkens, weil er als eigenstaendiges Objekt gelesen
/// wird und nicht mit den vielen Fortschrittsbalken der Themenliste
/// verschwimmt. Die Farbe wechselt in vier Stufen - zusaetzlich steht das
/// Label darunter, damit die Aussage nicht allein an der Farbe haengt.
class ReadinessRing extends StatelessWidget {
  const ReadinessRing({
    super.key,
    required this.value,
    required this.label,
    this.size = 148,
    this.caption,
  });

  /// 0..100
  final int value;
  final String label;
  final String? caption;
  final double size;

  Color _colorFor(BuildContext context) {
    final c = context.c;
    if (value >= 80) return c.success;
    if (value >= 60) return context.scheme.primary;
    if (value >= 35) return c.flame;
    return c.danger;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(context);
    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value / 100),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        builder: (context, t, _) => CustomPaint(
          painter: _RingPainter(
            progress: t,
            color: color,
            track: context.c.surfaceAlt,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(t * 100).round()}',
                  style: AppType.numeric(
                    size: size * 0.29,
                    weight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: context.text.labelSmall
                      ?.copyWith(color: context.c.textMuted),
                ),
                if (caption != null)
                  Text(
                    caption!,
                    style: context.text.labelSmall
                        ?.copyWith(color: context.c.textMuted),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.track,
  });

  final double progress;
  final Color color;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 12.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (math.min(size.width, size.height) - stroke) / 2;

    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = track;

    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = color;

    // Offener Ring: 270 Grad, Luecke unten - das liest sich als Skala,
    // nicht als Tortendiagramm.
    const start = math.pi * 0.75;
    const sweep = math.pi * 1.5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      base,
    );
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        sweep * progress,
        false,
        fg,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color || old.track != track;
}

/// Kleine Kennzahl mit Icon - fuer Streak, Level, Tage bis zur Pruefung.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.scheme.primary;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: Gap.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: c),
          const SizedBox(height: Gap.s),
          Text(value, style: AppType.numeric(size: 20, color: c)),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.text.labelSmall?.copyWith(color: context.c.textMuted),
          ),
        ],
      ),
    );
  }
}

/// Fortschrittsbalken je Thema. Zeigt Koennen (gefuellter Balken) und
/// Abdeckung (Punkt-Marker) in einem Element.
class TopicBar extends StatelessWidget {
  const TopicBar({
    super.key,
    required this.confidence,
    required this.coverage,
  });

  final double confidence;
  final double coverage;

  @override
  Widget build(BuildContext context) {
    final color = confidence >= 0.75
        ? context.c.success
        : confidence >= 0.45
            ? context.scheme.primary
            : confidence > 0
                ? context.c.flame
                : context.c.textMuted;

    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;
        return SizedBox(
          height: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.c.surfaceAlt,
                  borderRadius: BorderRadius.circular(Radii.pill),
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: confidence.clamp(0.0, 1.0)),
                duration: const Duration(milliseconds: 500),
                builder: (context, t, _) => Container(
                  width: w * t,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(Radii.pill),
                  ),
                ),
              ),
              if (coverage > 0)
                Positioned(
                  left: (w * coverage.clamp(0.0, 1.0) - 2).clamp(0.0, w - 4),
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 3,
                    decoration: BoxDecoration(
                      color: context.scheme.onSurface.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Streak-Anzeige. Bewusst zurueckhaltend: eine Flamme, eine Zahl, fertig.
class StreakChip extends StatelessWidget {
  const StreakChip({super.key, required this.days, this.activeToday = false});

  final int days;
  final bool activeToday;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Gap.m, vertical: 7),
      decoration: BoxDecoration(
        color: days > 0 ? c.flameBg : c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(
          color: days > 0 ? c.flame.withValues(alpha: 0.35) : c.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            activeToday ? Icons.local_fire_department : Icons.local_fire_department_outlined,
            size: 17,
            color: days > 0 ? c.flame : c.textMuted,
          ),
          const SizedBox(width: 5),
          Text(
            '$days',
            style: AppType.numeric(
              size: 14,
              color: days > 0 ? c.flame : c.textMuted,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            days == 1 ? 'Tag' : 'Tage',
            style: context.text.labelSmall?.copyWith(
              color: days > 0 ? c.flame : c.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// Farbig hinterlegter Hinweiskasten. [tone] steuert Farbe UND Icon - die
/// Aussage haengt nie allein an der Farbe.
enum NoteTone { info, success, danger, warn }

class NoteBox extends StatelessWidget {
  const NoteBox({
    super.key,
    required this.child,
    this.tone = NoteTone.info,
    this.title,
  });

  final Widget child;
  final NoteTone tone;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final (fg, bg, icon) = switch (tone) {
      NoteTone.info => (c.info, c.infoBg, Icons.lightbulb_outline),
      NoteTone.success => (c.success, c.successBg, Icons.check_circle_outline),
      NoteTone.danger => (c.danger, c.dangerBg, Icons.cancel_outlined),
      NoteTone.warn => (c.flame, c.flameBg, Icons.error_outline),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: fg),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: context.text.titleMedium?.copyWith(color: fg),
                  ),
                  const SizedBox(height: Gap.xs),
                ],
                DefaultTextStyle.merge(
                  style: context.text.bodyMedium!,
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Kleines Label mit Icon fuer Metadaten (Thema, Schwierigkeit, Punkte).
class MetaChip extends StatelessWidget {
  const MetaChip({super.key, required this.label, this.icon, this.color});

  final String label;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final fg = color ?? context.c.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: context.c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: fg),
            const SizedBox(width: 4),
          ],
          Text(label, style: context.text.labelSmall?.copyWith(color: fg)),
        ],
      ),
    );
  }
}

/// Zentriert den Inhalt und begrenzt die Zeilenlaenge. Auf breiten Screens
/// sonst unlesbar - 70 Zeichen sind die Obergrenze fuer Fliesstext.
///
/// [shrinkHeight] ist Pflicht ueberall dort, wo der Elternteil lockere
/// Hoehen-Constraints vergibt (Scaffold.bottomNavigationBar, Column ohne
/// Expanded). Ohne das nimmt sich Center die maximal verfuegbare Hoehe und
/// legt sich ueber den restlichen Bildschirm.
class ReadableWidth extends StatelessWidget {
  const ReadableWidth({
    super.key,
    required this.child,
    this.maxWidth = 760,
    this.shrinkHeight = false,
  });

  final Widget child;
  final double maxWidth;
  final bool shrinkHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: shrinkHeight ? 1.0 : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

/// Grosse Auswahlkachel fuers Onboarding: Titel, Beschreibung, Haken.
class SelectTile extends StatelessWidget {
  const SelectTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.icon,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final primary = context.scheme.primary;
    return Material(
      color: selected
          ? primary.withValues(alpha: 0.08)
          : context.scheme.surface,
      borderRadius: BorderRadius.circular(Radii.m),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.m),
        child: Container(
          padding: const EdgeInsets.all(Gap.l),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.m),
            border: Border.all(
              color: selected ? primary : context.c.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon,
                    size: 22,
                    color: selected ? primary : context.c.textMuted),
                const SizedBox(width: Gap.m),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.text.titleMedium),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: context.text.bodyMedium
                            ?.copyWith(color: context.c.textMuted),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  color: selected ? primary : context.c.border,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Leerer Zustand mit Handlungsaufforderung statt nur "keine Daten".
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Gap.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: context.c.textMuted),
            const SizedBox(height: Gap.l),
            Text(title, style: context.text.titleMedium),
            const SizedBox(height: Gap.s),
            Text(
              message,
              textAlign: TextAlign.center,
              style:
                  context.text.bodyMedium?.copyWith(color: context.c.textMuted),
            ),
            if (action != null) ...[
              const SizedBox(height: Gap.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

String formatDuration(Duration d) {
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (d.inHours > 0) return '${d.inHours}:$m:$s';
  return '$m:$s';
}
