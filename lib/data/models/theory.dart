import 'package:flutter/foundation.dart';

/// Ein Theorie-Snack: die kleinste sinnvolle Lerneinheit, bewusst auf
/// 30-60 Sekunden Lesezeit geschnitten.
///
/// Der Snack steht vor der ersten Aufgabe eines Themas und lässt sich in
/// jeder Session über "Kurz nachlesen" erneut öffnen. Länger darf er nicht
/// werden - wer in der Bahn drei Bildschirmseiten Theorie sieht, macht die App
/// zu.
@immutable
class TheorySnack {
  const TheorySnack({
    required this.id,
    required this.topicId,
    required this.title,
    required this.lead,
    required this.points,
    required this.merksatz,
    this.readSeconds = 45,
  });

  final String id;
  final String topicId;
  final String title;

  /// Ein bis zwei Sätze Einstieg.
  final String lead;

  /// Die Kernaussagen. Ein Punkt = ein prüfungsrelevanter Fakt.
  final List<String> points;

  /// Der Satz, der hängen bleiben soll.
  final String merksatz;

  final int readSeconds;
}
