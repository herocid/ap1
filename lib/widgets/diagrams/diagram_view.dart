import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/models/diagram.dart';
import 'balken_diagram.dart';
import 'baum_diagram.dart';
import 'bit_diagram.dart';
import 'diagram_canvas.dart';
import 'diagram_description.dart';
import 'diagram_style.dart';
import 'erm_diagram.dart';
import 'fluss_diagram.dart';
import 'gantt_diagram.dart';
import 'geraden_diagram.dart';
import 'klassen_diagram.dart';
import 'netz_diagram.dart';
import 'netzplan_diagram.dart';
import 'quadranten_diagram.dart';
import 'sequenz_diagram.dart';
import 'stapel_diagram.dart';
import 'usecase_diagram.dart';

/// Zeichnet ein [Diagram] in der verfügbaren Breite.
///
/// Jede Art hat ein eigenes Layout, das Texte mit der Schriftgröße des
/// Geräts misst und sich an die Breite anpasst (umbrechen, umstellen,
/// erst zuletzt seitlich scrollen). Für Screenreader gibt es eine
/// vollständige Textfassung.
class DiagramView extends StatelessWidget {
  const DiagramView(this.diagram, {super.key});

  final Diagram diagram;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      image: true,
      label: describeDiagram(diagram),
      child: ExcludeSemantics(
        child: LayoutBuilder(
          builder: (context, box) {
            final pad = box.maxWidth >= 320 ? Gap.m : Gap.s;
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(pad),
              decoration: BoxDecoration(
                color: context.scheme.surface,
                borderRadius: BorderRadius.circular(Radii.m),
                border: Border.all(color: context.c.border),
              ),
              child: DiagramCanvas(
                source: diagram,
                layout: (s, w) => layoutDiagram(diagram, s, w),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Legt [d] für die Breite [w] aus (ohne Widget - auch für Tests, die die
/// Geometrie prüfen).
DiagramLayout layoutDiagram(Diagram d, DiagramStyle s, double w) => switch (d) {
  StapelDiagramm() => layoutStapel(d, s, w),
  FlussDiagramm() => layoutFluss(d, s, w),
  BaumDiagramm() => layoutBaum(d, s, w),
  SequenzDiagramm() => layoutSequenz(d, s, w),
  QuadrantenDiagramm() => layoutQuadranten(d, s, w),
  BalkenDiagramm() => layoutBalken(d, s, w),
  GanttDiagramm() => layoutGantt(d, s, w),
  GeradenDiagramm() => layoutGeraden(d, s, w),
  KlassenDiagramm() => layoutKlassen(d, s, w),
  ErmDiagramm() => layoutErm(d, s, w),
  UseCaseDiagramm() => layoutUseCase(d, s, w),
  NetzSkizze() => layoutNetz(d, s, w),
  BitDiagramm() => layoutBits(d, s, w),
  NetzplanDiagramm() => layoutNetzplan(d, s, w),
  NetzplanLegende() => layoutNetzplanLegende(s, w),
};
