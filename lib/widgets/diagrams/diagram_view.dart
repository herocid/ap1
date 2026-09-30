import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/diagram.dart';

/// Zeichnet ein [Diagram] in der verfügbaren Breite.
///
/// Vorläufige, schlichte Umsetzung: Schichten, Abläufe und Bäume als
/// Kästen, alle übrigen Arten als strukturierte Textfassung.
class DiagramView extends StatelessWidget {
  const DiagramView(this.diagram, {super.key});

  final Diagram diagram;

  @override
  Widget build(BuildContext context) {
    final d = diagram;
    final Widget child = switch (d) {
      StapelDiagramm() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final e in d.ebenen)
            _Box(e.detail == null ? e.label : '${e.label}\n${e.detail}'),
        ],
      ),
      FlussDiagramm() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < d.knoten.length; i++) ...[
            if (i > 0) Icon(Icons.arrow_downward, color: context.c.textMuted),
            _Box(
              d.knoten[i].seitlich == null
                  ? d.knoten[i].label
                  : '${d.knoten[i].label}\n→ ${d.knoten[i].seitlich}',
            ),
          ],
        ],
      ),
      BaumDiagramm() => _Tree(d.wurzel, 0),
      _ => _Box(_describe(d)),
    };
    return child;
  }

  static String _describe(Diagram d) => switch (d) {
    SequenzDiagramm() =>
      d.nachrichten
          .map(
            (n) => '${d.teilnehmer[n.von]} → ${d.teilnehmer[n.an]}: ${n.text}',
          )
          .join('\n'),
    QuadrantenDiagramm() =>
      '${d.yAchse} ↑ / ${d.xAchse} →\n'
          'oben links: ${d.obenLinks.titel}\n'
          'oben rechts: ${d.obenRechts.titel}\n'
          'unten links: ${d.untenLinks.titel}\n'
          'unten rechts: ${d.untenRechts.titel}',
    BalkenDiagramm() => d.balken.map((b) => '${b.label}: ${b.wert}').join('\n'),
    GanttDiagramm() =>
      d.vorgaenge.map((v) => '${v.label}: ${v.start} + ${v.dauer}').join('\n'),
    GeradenDiagramm() =>
      d.geraden
          .map((g) => '${g.label}: ${g.start} + ${g.steigung} · x')
          .join('\n'),
    KlassenDiagramm() =>
      d.klassen
          .map((k) => [k.name, ...k.attribute, ...k.methoden].join('\n'))
          .join('\n\n'),
    ErmDiagramm() =>
      d.beziehungen
          .map((b) => '${b.a} (${b.kardA}) – ${b.name} – (${b.kardB}) ${b.b}')
          .join('\n'),
    UseCaseDiagramm() => '${d.system}\n${d.faelle.join('\n')}',
    NetzSkizze() => d.knoten.map((k) => k.label).join(', '),
    BitDiagramm() => d.zeilen.map((z) => '${z.label}: ${z.bits}').join('\n'),
    NetzplanDiagramm() =>
      d.vorgaenge.map((v) => '${v.id} ${v.name} (${v.duration})').join('\n'),
    NetzplanLegende() => 'FAZ | Dauer | FEZ\nVorgang\nSAZ | GP | SEZ',
    _ => '',
  };
}

class _Box extends StatelessWidget {
  const _Box(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(Gap.m),
      decoration: BoxDecoration(
        color: context.c.surfaceAlt,
        borderRadius: BorderRadius.circular(Radii.m),
        border: Border.all(color: context.c.border),
      ),
      child: Text(text, style: context.text.bodyMedium),
    );
  }
}

class _Tree extends StatelessWidget {
  const _Tree(this.node, this.depth);
  final BaumKnoten node;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth == 0 ? 0 : Gap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Box(
            node.detail == null ? node.label : '${node.label} (${node.detail})',
          ),
          for (final k in node.kinder) _Tree(k, depth + 1),
        ],
      ),
    );
  }
}
