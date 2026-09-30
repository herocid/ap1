import 'package:flutter/foundation.dart';

import 'theory.dart';

/// Art eines Feed-Beitrags. Bestimmt Symbol, Farbe und Aufbau der Karte.
enum NuggetKind {
  /// Ein Begriff oder Konzept in wenigen Sätzen.
  konzept('Konzept'),

  /// Zwei oder mehr Begriffe nebeneinander - die klassische AP1-Abgrenzung.
  vergleich('Vergleich'),

  /// Schritte in fester Reihenfolge (Phasen, Abläufe, Rechenwege).
  ablauf('Ablauf'),

  /// Formel oder Code in Festbreitenschrift.
  formel('Formel'),

  /// Ein Satz zum Behalten.
  merksatz('Merksatz'),

  /// Was in der Prüfung typischerweise falsch gemacht wird.
  fehlerfalle('Prüfungsfalle');

  const NuggetKind(this.label);
  final String label;
}

/// Ein Beitrag im Lern-Feed: in 20-40 Sekunden erfassbar, ohne Vorwissen
/// aus einer vorherigen Karte.
///
/// Nur [title] und [body] sind Pflicht; die übrigen Felder sind je nach
/// [kind] gefüllt. Eine Karte zeigt, was vorhanden ist, statt je Art eigene
/// Klassen zu erzwingen - das hält das Schreiben neuer Beiträge einfach.
@immutable
class Nugget {
  const Nugget({
    required this.id,
    required this.topicId,
    required this.kind,
    required this.title,
    required this.body,
    this.points = const [],
    this.table,
    this.code,
    this.merksatz,
    this.tags = const [],
  });

  final String id;
  final String topicId;
  final NuggetKind kind;
  final String title;
  final String body;

  /// Aufzählung; bei [NuggetKind.ablauf] die Schritte in Reihenfolge.
  final List<String> points;

  /// Erste Zeile = Spaltenköpfe. Alle Zeilen gleich lang.
  final List<List<String>>? table;

  /// Formel, Pseudocode oder Befehl - wird in Festbreitenschrift gesetzt.
  final String? code;

  final String? merksatz;
  final List<String> tags;

  /// Theorie-Snacks erscheinen ebenfalls im Feed, ohne doppelt gepflegt zu
  /// werden.
  factory Nugget.fromTheory(TheorySnack s) => Nugget(
        id: 'feed-${s.id}',
        topicId: s.topicId,
        kind: NuggetKind.konzept,
        title: s.title,
        body: s.lead,
        points: s.points,
        merksatz: s.merksatz,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic_id': topicId,
        'kind': kind.name,
        'title': title,
        'body': body,
        if (points.isNotEmpty) 'points': points,
        if (table != null) 'table': table,
        if (code != null) 'code': code,
        if (merksatz != null) 'merksatz': merksatz,
        if (tags.isNotEmpty) 'tags': tags,
      };

  factory Nugget.fromJson(Map<String, dynamic> j) => Nugget(
        id: j['id'] as String,
        topicId: j['topic_id'] as String,
        kind: NuggetKind.values.firstWhere(
          (k) => k.name == j['kind'],
          orElse: () => NuggetKind.konzept,
        ),
        title: j['title'] as String,
        body: j['body'] as String,
        points: ((j['points'] as List?) ?? const []).cast<String>().toList(),
        table: (j['table'] as List?)
            ?.map((row) => (row as List).cast<String>().toList())
            .toList(),
        code: j['code'] as String?,
        merksatz: j['merksatz'] as String?,
        tags: ((j['tags'] as List?) ?? const []).cast<String>().toList(),
      );
}
