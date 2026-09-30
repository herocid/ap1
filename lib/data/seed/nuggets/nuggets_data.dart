import '../../models/nugget.dart';
import '../seed_theory.dart';
import 'nuggets_a01_projekte.dart';

/// Alle Beiträge des Lern-Feeds: eigens geschriebene Nuggets plus die
/// Theorie-Snacks, damit diese nicht doppelt gepflegt werden müssen.
final List<Nugget> kSeedNuggets = [
  ...nuggetsA01,
  ...seedTheory.map(Nugget.fromTheory),
];
