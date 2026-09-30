import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/nugget.dart';
import '../../data/models/topic.dart';
import '../../widgets/common.dart';
import '../../widgets/diagrams/diagram_view.dart';

/// Symbol und Farbe je Beitragsart. Farbe ist sparsam: nur die Überzeile
/// trägt sie, der Rest der Karte bleibt neutral.
(IconData, Color) nuggetStyle(BuildContext context, NuggetKind kind) {
  final c = context.c;
  return switch (kind) {
    NuggetKind.konzept => (Icons.lightbulb_outline, context.scheme.primary),
    NuggetKind.vergleich => (Icons.compare_arrows, c.info),
    NuggetKind.ablauf => (Icons.format_list_numbered, c.info),
    NuggetKind.formel => (Icons.functions, context.scheme.primary),
    NuggetKind.merksatz => (Icons.push_pin_outlined, c.flame),
    NuggetKind.fehlerfalle => (Icons.report_outlined, c.danger),
    NuggetKind.beispiel => (Icons.calculate_outlined, c.success),
    NuggetKind.skizze => (Icons.schema_outlined, c.info),
  };
}

/// Ein Beitrag im Lern-Feed.
class NuggetCard extends StatelessWidget {
  const NuggetCard({
    super.key,
    required this.nugget,
    this.action,
    this.compact = false,
    this.onTap,
    this.showTopic = true,
  });

  final Nugget nugget;
  final VoidCallback? onTap;

  /// In einer Lektion steht das Thema schon in der Kopfzeile.
  final bool showTopic;

  /// Optionale Schaltfläche am Kartenende, z. B. "Thema üben".
  final Widget? action;

  /// Nur Überzeile, Titel und Einleitung - für die Vorschau auf der
  /// Startseite.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final n = nugget;
    final (icon, color) = nuggetStyle(context, n.kind);
    final topic = Topics.byId(n.topicId);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(Gap.xl, Gap.l, Gap.xl, Gap.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: color),
              const SizedBox(width: Gap.s),
              // Auf 320 px mit großer Systemschrift ist „PRÜFUNGSFALLE“
              // knapp zu breit - lieber minimal verkleinern als abschneiden.
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    n.kind.label.toUpperCase(),
                    style: context.text.labelSmall?.copyWith(
                      color: color,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Gap.s),
              if (showTopic)
                Flexible(
                  child: Text(
                    '·  ${topic.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.labelSmall?.copyWith(
                      color: context.c.textMuted,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: Gap.m),
          Text(n.title, style: context.text.titleLarge),
          const SizedBox(height: Gap.s),
          Text(
            n.body,
            maxLines: compact ? 3 : null,
            overflow: compact ? TextOverflow.ellipsis : null,
            style: context.text.bodyMedium?.copyWith(
              color: context.c.textMuted,
            ),
          ),
          if (!compact) ...[
            if (n.diagram != null) ...[
              const SizedBox(height: Gap.l),
              DiagramView(n.diagram!),
            ],
            if (n.table != null) ...[
              const SizedBox(height: Gap.l),
              _NuggetTable(n.table!),
            ],
            if (n.code != null) ...[
              const SizedBox(height: Gap.l),
              _CodeBlock(n.code!),
            ],
            if (n.points.isNotEmpty) ...[
              const SizedBox(height: Gap.l),
              if (n.kind == NuggetKind.beispiel) ...[
                Text(
                  'LÖSUNGSWEG',
                  style: context.text.labelSmall?.copyWith(
                    color: context.c.textMuted,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: Gap.s),
              ],
              n.kind == NuggetKind.ablauf || n.kind == NuggetKind.beispiel
                  ? _Steps(n.points)
                  : _Bullets(n.points),
            ],
            if (n.ergebnis != null) ...[
              const SizedBox(height: Gap.s),
              _Ergebnis(n.ergebnis!),
            ],
            if (n.merksatz != null) ...[
              const SizedBox(height: Gap.l),
              _Merksatz(n.merksatz!),
            ],
            if (action != null) ...[
              const SizedBox(height: Gap.l),
              Divider(color: context.c.border),
              const SizedBox(height: Gap.xs),
              action!,
            ],
          ],
        ],
      ),
    );
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets(this.points);
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in points)
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.s),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: context.scheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: Gap.m),
                Expanded(child: Text(p, style: context.text.bodyMedium)),
              ],
            ),
          ),
      ],
    );
  }
}

class _Steps extends StatelessWidget {
  const _Steps(this.points);
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < points.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.m),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: context.scheme.primary),
                  ),
                  child: Text(
                    '${i + 1}',
                    style: AppType.numeric(
                      size: 12,
                      color: context.scheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: Gap.m),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(points[i], style: context.text.bodyMedium),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Tabelle für Vergleiche. Auf schmalen Displays scrollt sie seitlich,
/// statt Spalten auf ein Wort pro Zeile zu quetschen.
class _NuggetTable extends StatelessWidget {
  const _NuggetTable(this.rows);
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    final head = rows.first;
    final body = rows.skip(1).toList();
    final border = context.c.border;

    return LayoutBuilder(
      builder: (context, box) {
        final minWidth = head.length * 150.0;
        final table = Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          border: TableBorder(horizontalInside: BorderSide(color: border)),
          children: [
            TableRow(
              decoration: BoxDecoration(color: context.c.surfaceAlt),
              children: [
                for (final h in head)
                  Padding(
                    padding: const EdgeInsets.all(Gap.m),
                    child: Text(h, style: context.text.labelLarge),
                  ),
              ],
            ),
            for (final r in body)
              TableRow(
                children: [
                  for (var i = 0; i < r.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(Gap.m),
                      child: Text(
                        r[i],
                        style: i == 0
                            ? context.text.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              )
                            : context.text.bodyMedium,
                      ),
                    ),
                ],
              ),
          ],
        );

        final framed = Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.m),
            border: Border.all(color: border),
          ),
          child: table,
        );

        if (box.maxWidth >= minWidth) return framed;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(width: minWidth, child: framed),
        );
      },
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: context.c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.m),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(code, style: AppType.mono(size: 13)),
      ),
    );
  }
}

class _Ergebnis extends StatelessWidget {
  const _Ergebnis(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: c.successBg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.success.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 17, color: c.success),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Text(
              text,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Merksatz extends StatelessWidget {
  const _Merksatz(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.l),
      decoration: BoxDecoration(
        color: c.flameBg,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: c.flame.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.push_pin_outlined, size: 17, color: c.flame),
          const SizedBox(width: Gap.m),
          Expanded(
            child: Text(
              text,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
