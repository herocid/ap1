import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/seed/seed_removed.dart';
import '../../widgets/common.dart';

/// Was sich mit dem Prüfungskatalog 2025 geändert hat.
///
/// Der praktische Nutzen liegt in der linken Spalte: Wer mit einem Lehrbuch
/// von 2022, mit Altfragen oder mit YouTube-Videos älteren Datums lernt,
/// verbringt sonst Wochen mit Stoff, der gar nicht mehr abgefragt wird.
class CatalogChangesScreen extends StatelessWidget {
  const CatalogChangesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Katalog 2025'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Gestrichen'),
              Tab(text: 'Neu'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ChangeList(
              items: kRemovedTopics,
              tone: NoteTone.danger,
              icon: Icons.remove_circle_outline,
              intro:
                  'Diese Themen sind ab 2025 nicht mehr Teil der AP1. Zu ihnen '
                  'gibt es in dieser App bewusst keine Aufgaben. Wenn dein '
                  'Lehrbuch oder ein Altfragen-Satz sie noch enthält: '
                  'überspringen.',
            ),
            _ChangeList(
              items: kAddedTopics,
              tone: NoteTone.success,
              icon: Icons.add_circle_outline,
              intro:
                  'Diese Themen sind neu im Katalog. In älteren Lehrbüchern '
                  'fehlen sie oft komplett - hier lohnt sich besondere '
                  'Aufmerksamkeit.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangeList extends StatelessWidget {
  const _ChangeList({
    required this.items,
    required this.tone,
    required this.icon,
    required this.intro,
  });

  final List<RemovedTopic> items;
  final NoteTone tone;
  final IconData icon;
  final String intro;

  @override
  Widget build(BuildContext context) {
    final accent = tone == NoteTone.danger ? context.c.danger : context.c.success;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Gap.l, Gap.l, Gap.l, Gap.xxxl),
      children: [
        ReadableWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteBox(tone: tone, child: Text(intro)),
              const SizedBox(height: Gap.xl),
              for (final item in items) ...[
                AppCard(
                  padding: const EdgeInsets.all(Gap.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(icon, size: 19, color: accent),
                          const SizedBox(width: Gap.m),
                          Expanded(
                            child: Text(item.title,
                                style: context.text.titleMedium),
                          ),
                        ],
                      ),
                      const SizedBox(height: Gap.s),
                      Padding(
                        padding: const EdgeInsets.only(left: 31),
                        child: Text(item.note,
                            style: context.text.bodyMedium),
                      ),
                      if (item.stillRelevantFor != null) ...[
                        const SizedBox(height: Gap.m),
                        Padding(
                          padding: const EdgeInsets.only(left: 31),
                          child: Container(
                            padding: const EdgeInsets.all(Gap.m),
                            decoration: BoxDecoration(
                              color: context.c.infoBg,
                              borderRadius: BorderRadius.circular(Radii.m),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.info_outline,
                                    size: 16, color: context.c.info),
                                const SizedBox(width: Gap.s),
                                Expanded(
                                  child: Text(
                                    'Trotzdem wichtig: ${item.stillRelevantFor}',
                                    style: context.text.bodyMedium
                                        ?.copyWith(color: context.c.info),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: Gap.s),
              ],
              const SizedBox(height: Gap.l),
              Text(
                'Quelle: Zusammenstellung der Änderungen des '
                'AP1-Prüfungskatalogs (2. überarbeitete Auflage, erstmals '
                'angewendet Frühjahr 2025). Im Zweifel gilt der amtliche '
                'Katalog deiner IHK.',
                style: context.text.labelSmall
                    ?.copyWith(color: context.c.textMuted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
