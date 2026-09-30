import 'package:flutter/material.dart';

import 'diagram_style.dart';

/// Fertig ausgelegte Zeichnung: Größe steht fest, alle Texte sind gemessen.
/// Die Layout-Klassen rechnen einmal pro Breite/Theme/Schriftgröße und
/// zeichnen danach nur noch.
abstract class DiagramLayout {
  Size get size;
  void paint(Canvas canvas);
}

typedef DiagramLayoutFactory =
    DiagramLayout Function(DiagramStyle style, double maxWidth);

/// Zeichenfläche für eine [DiagramLayout].
///
/// Das Layout wird zwischengespeichert, solange Zeichnung, Breite und Stil
/// gleich bleiben - Scrollen oder ein Neuaufbau der Eltern rechnet nichts
/// neu. Ist die Zeichnung trotz aller Umstellungen breiter als der Platz,
/// scrollt sie seitlich (letzter Ausweg, damit nie etwas abgeschnitten wird).
class DiagramCanvas extends StatefulWidget {
  const DiagramCanvas({super.key, required this.source, required this.layout});

  /// Die Zeichnung; dient als Schlüssel für den Zwischenspeicher.
  final Object source;
  final DiagramLayoutFactory layout;

  @override
  State<DiagramCanvas> createState() => _DiagramCanvasState();
}

class _DiagramCanvasState extends State<DiagramCanvas> {
  final _scroll = ScrollController();
  Object? _source;
  double? _width;
  DiagramStyle? _style;
  DiagramLayout? _layout;

  DiagramLayout _get(DiagramStyle style, double width) {
    if (_layout == null ||
        !identical(_source, widget.source) ||
        _width != width ||
        _style != style) {
      _source = widget.source;
      _width = width;
      _style = style;
      _layout = widget.layout(style, width);
    }
    return _layout!;
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = DiagramStyle.of(context);
    return LayoutBuilder(
      builder: (context, box) {
        final width = box.maxWidth.isFinite ? box.maxWidth : 400.0;
        final layout = _get(style, width);
        final paint = CustomPaint(
          size: layout.size,
          painter: _LayoutPainter(layout),
        );
        if (layout.size.width <= width + 0.5) {
          return Align(alignment: Alignment.topCenter, child: paint);
        }
        return Scrollbar(
          controller: _scroll,
          child: SingleChildScrollView(
            controller: _scroll,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: 10),
            child: paint,
          ),
        );
      },
    );
  }
}

class _LayoutPainter extends CustomPainter {
  _LayoutPainter(this.layout);
  final DiagramLayout layout;

  @override
  void paint(Canvas canvas, Size size) => layout.paint(canvas);

  @override
  bool shouldRepaint(_LayoutPainter old) => !identical(old.layout, layout);
}
