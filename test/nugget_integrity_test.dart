import 'package:ap1_trainer/data/models/nugget.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final nuggets = kSeedNuggets;

  test('IDs sind eindeutig', () {
    final ids = nuggets.map((n) => n.id).toList();
    expect(ids.toSet().length, ids.length);
  });

  test('jedes Nugget gehört zu einem existierenden Thema', () {
    for (final n in nuggets) {
      expect(Topics.map.containsKey(n.topicId), isTrue,
          reason: '${n.id}: unbekanntes Thema ${n.topicId}');
    }
  });

  test('Titel und Text sind nicht leer', () {
    for (final n in nuggets) {
      expect(n.title.trim(), isNotEmpty, reason: n.id);
      expect(n.body.trim().length, greaterThanOrEqualTo(30), reason: n.id);
    }
  });

  test('jede Art hat die Felder, die ihre Karte braucht', () {
    for (final n in nuggets) {
      switch (n.kind) {
        case NuggetKind.vergleich:
          expect(n.table, isNotNull, reason: '${n.id}: Vergleich ohne Tabelle');
        case NuggetKind.ablauf:
          expect(n.points.length, greaterThanOrEqualTo(2),
              reason: '${n.id}: Ablauf mit weniger als zwei Schritten');
        case NuggetKind.formel:
          expect(n.code, isNotNull, reason: '${n.id}: Formel ohne Formel');
        case NuggetKind.merksatz:
          expect(n.merksatz != null || n.points.isNotEmpty, isTrue,
              reason: '${n.id}: Merksatz ohne Merksatz oder Punkte');
        case NuggetKind.konzept:
        case NuggetKind.fehlerfalle:
          break;
      }
    }
  });

  test('Tabellen sind rechteckig und haben Kopf plus Inhalt', () {
    for (final n in nuggets.where((n) => n.table != null)) {
      final t = n.table!;
      expect(t.length, greaterThanOrEqualTo(2), reason: n.id);
      for (final row in t) {
        expect(row.length, t.first.length,
            reason: '${n.id}: Zeile "${row.first}" hat falsche Spaltenzahl');
      }
    }
  });

  test('JSON-Roundtrip verliert nichts', () {
    for (final n in nuggets) {
      final back = Nugget.fromJson(n.toJson());
      expect(back.toJson(), n.toJson(), reason: n.id);
    }
  });
}
