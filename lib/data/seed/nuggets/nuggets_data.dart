import '../../models/nugget.dart';
import 'nuggets_a01_planung.dart';
import 'nuggets_a01_projekte.dart';

/// Alle Lernschritte der Learning Journey. Die Reihenfolge innerhalb einer
/// Lektion ist die Listenreihenfolge.
final List<Nugget> kSeedNuggets = [
  ...nuggetsA01,
  ...nuggetsA01Planung,
];
