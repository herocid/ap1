import '../models/question.dart';
import '../models/theory.dart';
import 'seed_anforderungen.dart';
import 'seed_grundlagen.dart';
import 'seed_netzplan.dart';
import 'seed_theory.dart';

/// Der komplette Aufgabenpool der App.
///
/// Diese Liste ist zugleich die Quelle fuer den SQL-Seed in
/// `supabase/migrations` - beides muss inhaltlich uebereinstimmen, damit die
/// App offline und online dieselben Aufgaben zeigt.
final List<Question> kSeedQuestions = [
  ...seedGrundlagen,
  ...seedNetzplan,
  ...seedAnforderungen,
];

final List<TheorySnack> kSeedTheory = seedTheory;

/// Anzahl Aufgaben je Thema - Grundlage fuer die Coverage-Berechnung in der
/// Pruefungsreife.
Map<String, int> kPoolSizeByTopic() {
  final out = <String, int>{};
  for (final q in kSeedQuestions) {
    out[q.topicId] = (out[q.topicId] ?? 0) + 1;
  }
  return out;
}
