import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_theme.dart';
import '../core/util/achievements.dart';
import '../data/models/progress.dart';

/// Farben der Abzeichen. Kräftige IT-Farben (Blau, Orange, Grün, Rot,
/// Petrol, Gold) - keine Verläufe. Auf hellem wie dunklem Grund lesbar, weil das
/// Symbol immer weiß auf der vollen Farbe steht.
class BadgePalette {
  const BadgePalette._();

  static const brass = Color(0xFFE8A200);
  static const orange = Color(0xFFF07B1D);
  static const brick = Color(0xFFD93025);
  static const green = Color(0xFF1E8E3E);
  static const teal = Color(0xFF00897B);
  static const slate = Color(0xFF1A73E8);
  static const ink = Color(0xFF0B3D91);
}

extension AchievementLook on Achievement {
  IconData get icon => switch (this) {
    Achievement.ersterTag => Icons.flag_rounded,
    Achievement.warmgelaufen => Icons.bolt_rounded,
    Achievement.ersteLektion => Icons.school_rounded,
    Achievement.wissbegierig => Icons.menu_book_rounded,
    Achievement.halbzeit => Icons.route_rounded,
    Achievement.stoffKomplett => Icons.emoji_events_rounded,
    Achievement.dranbleiber => Icons.local_fire_department_rounded,
    Achievement.woche => Icons.whatshot_rounded,
    Achievement.eisern => Icons.shield_rounded,
    Achievement.hundert => Icons.military_tech_rounded,
    Achievement.aufgabenprofi => Icons.workspace_premium_rounded,
    Achievement.treffsicher => Icons.gps_fixed_rounded,
    Achievement.fehlerjaeger => Icons.bug_report_rounded,
    Achievement.netzplanProfi => Icons.account_tree_rounded,
    Achievement.allrounder => Icons.public_rounded,
    Achievement.bereichsprofi => Icons.star_rounded,
    Achievement.kartenstapel => Icons.style_rounded,
    Achievement.langzeit => Icons.psychology_rounded,
    Achievement.simulant => Icons.verified_rounded,
    Achievement.bestnote => Icons.auto_awesome_rounded,
  };

  Color get color => switch (this) {
    Achievement.ersterTag ||
    Achievement.stoffKomplett ||
    Achievement.bereichsprofi ||
    Achievement.bestnote => BadgePalette.brass,
    Achievement.warmgelaufen ||
    Achievement.dranbleiber ||
    Achievement.netzplanProfi => BadgePalette.orange,
    Achievement.woche || Achievement.eisern => BadgePalette.brick,
    Achievement.treffsicher || Achievement.fehlerjaeger => BadgePalette.green,
    Achievement.ersteLektion ||
    Achievement.wissbegierig ||
    Achievement.allrounder ||
    Achievement.langzeit => BadgePalette.teal,
    Achievement.halbzeit ||
    Achievement.hundert ||
    Achievement.kartenstapel => BadgePalette.slate,
    Achievement.aufgabenprofi || Achievement.simulant => BadgePalette.ink,
  };

  /// Wie der Fortschritt angezeigt wird - Prozentwerte mit %.
  String progressLabel(AchievementStatus s) => switch (this) {
    Achievement.bereichsprofi ||
    Achievement.simulant ||
    Achievement.bestnote => '${s.current} % von ${s.target} %',
    _ => '${math.min(s.current, s.target)} von ${s.target}',
  };
}

/// Eine runde Medaille. Verdient: volle Farbe, weißes Symbol. Noch offen:
/// grau, mit einem Fortschrittsring in der Farbe des Abzeichens.
class AchievementMedal extends StatelessWidget {
  const AchievementMedal({
    super.key,
    required this.achievement,
    required this.status,
    this.size = 58,
  });

  final Achievement achievement;
  final AchievementStatus status;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = achievement.color;
    final earned = status.earned;
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _RingPainter(
          share: earned ? 1 : status.share,
          color: color,
          track: context.c.border,
          earned: earned,
        ),
        child: Padding(
          padding: EdgeInsets.all(size * 0.09),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Auch gesperrt in der eigenen Farbe getönt - das Raster soll
              // bunt sein und schon zeigen, worauf man hinarbeitet.
              color: earned ? color : color.withValues(alpha: 0.13),
            ),
            child: Center(
              child: Icon(
                achievement.icon,
                size: size * 0.42,
                color: earned ? Colors.white : color.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.share,
    required this.color,
    required this.track,
    required this.earned,
  });

  final double share;
  final Color color;
  final Color track;
  final bool earned;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.05;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      0,
      math.pi * 2,
      false,
      paint..color = earned ? color.withValues(alpha: 0.35) : track,
    );
    if (!earned && share > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * share,
        false,
        paint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.share != share ||
      old.color != color ||
      old.track != track ||
      old.earned != earned;
}

/// Alle Abzeichen als Raster - verdiente zuerst, dann die, die am nächsten
/// dran sind.
class AchievementsPanel extends StatefulWidget {
  const AchievementsPanel({super.key, required this.statuses});

  final Map<Achievement, AchievementStatus> statuses;

  @override
  State<AchievementsPanel> createState() => _AchievementsPanelState();
}

class _AchievementsPanelState extends State<AchievementsPanel> {
  /// Zu Beginn zwei Reihen - sonst schiebt das Raster die eigentliche
  /// Statistik weit nach unten.
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final statuses = widget.statuses;
    final list = statuses.entries.toList()
      ..sort((a, b) {
        if (a.value.earned != b.value.earned) return a.value.earned ? -1 : 1;
        return b.value.share.compareTo(a.value.share);
      });
    final earned = list.where((e) => e.value.earned).length;

    return Container(
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(Radii.l),
        border: Border.all(color: context.c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events_rounded,
                size: 22,
                color: BadgePalette.brass,
              ),
              const SizedBox(width: Gap.s),
              Expanded(child: Text('Erfolge', style: context.text.titleLarge)),
              Text(
                '$earned / ${list.length}',
                style: AppType.numeric(size: 15, color: context.c.textMuted),
              ),
            ],
          ),
          const SizedBox(height: Gap.s),
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.pill),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: list.isEmpty ? 0 : earned / list.length),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, v, _) => LinearProgressIndicator(
                value: v,
                minHeight: 6,
                color: BadgePalette.brass,
              ),
            ),
          ),
          const SizedBox(height: Gap.l),
          LayoutBuilder(
            builder: (context, box) {
              final cols = box.maxWidth >= 520
                  ? 6
                  : (box.maxWidth >= 400 ? 4 : 3);
              final cell = box.maxWidth / cols;
              final shown = _expanded ? list : list.take(cols * 2);
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: Wrap(
                  runSpacing: Gap.l,
                  children: [
                    for (final e in shown)
                      SizedBox(
                        width: cell,
                        child: _BadgeCell(achievement: e.key, status: e.value),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: Gap.s),
          Center(
            child: TextButton.icon(
              onPressed: () => setState(() => _expanded = !_expanded),
              iconAlignment: IconAlignment.end,
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              label: Text(
                _expanded ? 'Weniger anzeigen' : 'Alle ${list.length} anzeigen',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeCell extends StatelessWidget {
  const _BadgeCell({required this.achievement, required this.status});

  final Achievement achievement;
  final AchievementStatus status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Radii.m),
      onTap: () => _showDetails(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Column(
          children: [
            AchievementMedal(achievement: achievement, status: status),
            const SizedBox(height: Gap.xs),
            // Mehrere Wörter dürfen umbrechen, ein einzelnes langes Wort
            // („Warmgelaufen“) wird lieber minimal kleiner als zerhackt.
            _label(context),
          ],
        ),
      ),
    );
  }

  Widget _label(BuildContext context) {
    final style = context.text.labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: status.earned ? null : context.c.textMuted,
    );
    final title = achievement.title;
    if (title.contains(' ') || title.contains('-')) {
      return Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: style,
      );
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(title, maxLines: 1, style: style),
    );
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AchievementMedal(
                achievement: achievement,
                status: status,
                size: 96,
              ),
              const SizedBox(height: Gap.l),
              Text(achievement.title, style: ctx.text.headlineSmall),
              const SizedBox(height: Gap.xs),
              Text(
                achievement.description,
                textAlign: TextAlign.center,
                style: ctx.text.bodyMedium?.copyWith(color: ctx.c.textMuted),
              ),
              const SizedBox(height: Gap.l),
              if (status.earned)
                Text(
                  'Freigeschaltet',
                  style: ctx.text.titleSmall?.copyWith(
                    color: achievement.color,
                  ),
                )
              else ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.pill),
                  child: LinearProgressIndicator(
                    value: status.share,
                    minHeight: 8,
                    color: achievement.color,
                  ),
                ),
                const SizedBox(height: Gap.s),
                Text(
                  achievement.progressLabel(status),
                  style: AppType.numeric(size: 14, color: ctx.c.textMuted),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
