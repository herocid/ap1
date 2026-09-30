import '../../models/nugget.dart';
import 'nuggets_a01_planung.dart';
import 'nuggets_a01_projekte.dart';
import 'nuggets_a02_kunden.dart';
import 'nuggets_a03_netze.dart';
import 'nuggets_a03_systeme.dart';

/// Alle Lernschritte der Learning Journey. Die Reihenfolge innerhalb einer
/// Lektion ist die Listenreihenfolge.
final List<Nugget> kSeedNuggets = [
  ...nuggetsA01,
  ...nuggetsA01Planung,
  ...nuggetsA02,
  ...nuggetsA03Systeme,
  ...nuggetsA03Netze,
];
