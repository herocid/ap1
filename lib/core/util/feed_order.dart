import 'dart:math' as math;

import '../../data/models/nugget.dart';

/// Reihenfolge des Lern-Feeds.
///
/// Gemischt statt nach Kapiteln, weil der Feed für zwischendurch ist - fünf
/// Netzplan-Beiträge hintereinander wären eine Lektion, kein Feed. Zwei
/// Beiträge desselben Themas stehen nie direkt nebeneinander, solange es
/// sich vermeiden lässt.
class FeedOrder {
  const FeedOrder._();

  /// Seed für den heutigen Tag: Die Reihenfolge bleibt über den Tag stabil
  /// (Zurückscrollen findet dasselbe wieder) und ist morgen eine andere.
  static int daySeed([DateTime? now]) {
    final n = now ?? DateTime.now();
    return n.year * 10000 + n.month * 100 + n.day;
  }

  static List<Nugget> round(List<Nugget> items, {required int seed}) {
    final pool = [...items]..shuffle(math.Random(seed));
    final out = <Nugget>[];
    while (pool.isNotEmpty) {
      final last = out.isEmpty ? null : out.last.topicId;
      final i = pool.indexWhere((n) => n.topicId != last);
      out.add(pool.removeAt(i < 0 ? 0 : i));
    }
    return out;
  }
}
