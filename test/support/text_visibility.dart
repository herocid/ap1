import 'package:ap1_trainer/widgets/common.dart';
import 'package:ap1_trainer/widgets/hyphenation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Sucht auf dem aktuellen Bildschirm nach Texten, die der Nutzer nicht
/// vollständig lesen kann.
///
/// Flutter meldet von selbst nur Überläufe von Row/Column. Ein Text, der
/// per `maxLines` gekürzt, mitten im Wort umbrochen, von einer festen Höhe
/// abgeschnitten oder hinter dem Rand einer seitlich scrollenden Fläche
/// versteckt wird, fällt dagegen nicht auf - genau das meldet der Nutzer
/// als „Text mittendrin abgeschnitten“. Diese Prüfung findet alle vier Fälle.
///
/// Bewusst gekürzte Vorschauen stehen in [ClampedText] und werden
/// übersprungen. [allowHorizontalScroll] erlaubt seitlich scrollende
/// Flächen (z. B. den Netzplan, der fast nie auf ein Handy passt).
List<String> findCutTexts(
  WidgetTester tester, {
  bool allowHorizontalScroll = false,
  bool Function(Widget widget)? skipInside,
}) {
  bool skipped(Element e) => skipInside != null && _hasAncestor(e, skipInside);
  final problems = <String>[];
  // Getrennter Text (HyphenText) hat einen eigenen Renderer.
  for (final element in find.byType(HyphenText).evaluate()) {
    final ro = element.renderObject;
    if (ro is! RenderHyphenText || !ro.attached || !ro.hasSize) continue;
    if (skipped(element)) continue;
    final text = ro.plainText.trim();
    if (text.isEmpty) continue;
    final label = text.length > 70 ? '${text.substring(0, 67)}...' : text;
    if (ro.neededHeight > ro.size.height + 0.5) {
      problems.add('unten abgeschnitten: "$label"');
    } else if (ro.widestUnbreakable > ro.size.width + 0.5) {
      problems.add(
        'mitten im Wort umbrochen (${ro.size.width.toStringAsFixed(0)} px): '
        '"$label"',
      );
    } else if (!allowHorizontalScroll &&
        _hiddenInHorizontalScroll(element, ro)) {
      problems.add('hinter seitlichem Scrollrand versteckt: "$label"');
    }
  }
  for (final element in find.byType(RichText).evaluate()) {
    final ro = element.renderObject;
    if (ro is! RenderParagraph || !ro.attached || !ro.hasSize) continue;
    final text = ro.text.toPlainText().trim();
    if (text.isEmpty) continue;
    if (_hasAncestor(element, (w) => w is ClampedText)) continue;
    if (skipped(element)) continue;

    final label = text.length > 70 ? '${text.substring(0, 67)}...' : text;
    final w = ro.size.width;
    final h = ro.size.height;

    if (ro.didExceedMaxLines) {
      problems.add('gekürzt (maxLines ${ro.maxLines}): "$label"');
      continue;
    }
    if (!ro.softWrap && ro.getMaxIntrinsicWidth(double.infinity) > w + 0.5) {
      problems.add('seitlich abgeschnitten: "$label"');
      continue;
    }
    // +1 px Breite: Mit exakt der eigenen Breite bricht die Textmessung
    // durch Rundung manchmal eine Zeile früher um als das echte Layout.
    if (ro.getMaxIntrinsicHeight(w + 1) > h + 0.5) {
      problems.add('unten abgeschnitten: "$label"');
      continue;
    }
    // Die breiteste Silbenkette passt nicht in die Zeile: Flutter bricht
    // dann mitten im Wort um („Verfügbarkeitsanfor-“ / „derung“ ohne
    // Trennstrich). Das liest sich wie abgeschnitten.
    if (ro.getMinIntrinsicWidth(double.infinity) > w + 0.5 &&
        _widestPiece(ro) > w + 0.5) {
      problems.add(
        'mitten im Wort umbrochen (${w.toStringAsFixed(0)} px): "$label"',
      );
      continue;
    }
    if (!allowHorizontalScroll && _hiddenInHorizontalScroll(element, ro)) {
      problems.add('hinter seitlichem Scrollrand versteckt: "$label"');
    }
  }
  return problems;
}

/// `minIntrinsicWidth` ignoriert unsichtbare Umbruchstellen (U+200B), wenn
/// der Text keine Leerzeichen hat. Zur Kontrolle deshalb die Stücke
/// zwischen allen Umbruchstellen einzeln messen.
double _widestPiece(RenderParagraph ro) {
  final plain = ro.text.toPlainText(includeSemanticsLabels: false);
  final zwsp = String.fromCharCode(0x200B);
  final pieces = plain.split(RegExp('[\\s$zwsp]|(?<=-)'));
  var widest = 0.0;
  for (final piece in pieces.toSet()) {
    if (piece.isEmpty) continue;
    final tp = TextPainter(
      text: TextSpan(text: piece, style: ro.text.style),
      textDirection: ro.textDirection,
      textScaler: ro.textScaler,
    )..layout();
    if (tp.width > widest) widest = tp.width;
    tp.dispose();
  }
  return widest;
}

bool _hasAncestor(Element element, bool Function(Widget) test) {
  var found = false;
  element.visitAncestorElements((a) {
    if (test(a.widget)) {
      found = true;
      return false;
    }
    return true;
  });
  return found;
}

/// True, wenn der Text in einer seitlich scrollenden Fläche steht und nicht
/// ganz in deren sichtbarem Bereich liegt. Seiten eines PageView zählen
/// nicht - dort liegt immer genau eine Seite im Bild.
bool _hiddenInHorizontalScroll(Element element, RenderBox paragraph) {
  Element? scrollable;
  element.visitAncestorElements((a) {
    final w = a.widget;
    if (w is PageView || w is TabBarView) return false;
    if (w is Scrollable &&
        axisDirectionToAxis(w.axisDirection) == Axis.horizontal) {
      scrollable = a;
      return false;
    }
    return true;
  });
  final box = scrollable?.renderObject;
  if (box is! RenderBox || !box.hasSize) return false;
  final viewport = box.localToGlobal(Offset.zero) & box.size;
  final rect = paragraph.localToGlobal(Offset.zero) & paragraph.size;
  return rect.left < viewport.left - 0.5 || rect.right > viewport.right + 0.5;
}
