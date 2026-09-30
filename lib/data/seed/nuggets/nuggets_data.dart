import '../../models/nugget.dart';
import 'nuggets_a01_planung.dart';
import 'nuggets_a01_projekte.dart';
import 'nuggets_a02_kunden.dart';
import 'nuggets_a03_netze.dart';
import 'nuggets_a03_systeme.dart';
import 'nuggets_a04_daten.dart';
import 'nuggets_a04_entwicklung.dart';
import 'nuggets_a05_qualitaet.dart';

/// Alle Lernschritte der Learning Journey. Die Reihenfolge innerhalb einer
/// Lektion ist die Listenreihenfolge.
final List<Nugget> kSeedNuggets = [
  ...nuggetsA01,
  ...nuggetsA01Planung,
  ...nuggetsA02,
  ...nuggetsA03Systeme,
  ...nuggetsA03Netze,
  ...nuggetsA04Entwicklung,
  ...nuggetsA04Daten,
  ...nuggetsA05,
];
