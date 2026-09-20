export 'cards/cards_data.dart' show kSeedFlashcards;
import '../models/question.dart';
import '../models/theory.dart';
import 'cards/cards_data.dart';
import 'seed_anforderungen.dart';
import 'seed_grundlagen.dart';
import 'seed_netzplan.dart';
import 'seed_qs_service.dart';
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
  ...seedQsService,
];

final List<TheorySnack> kSeedTheory = seedTheory;

/// Nur die Aufgaben, die nach dem Katalog 2025 noch drankommen koennen.
/// Alles andere bleibt im Pool, wird aber nie ausgewaehlt.
List<Question> get kExamRelevantQuestions =>
    kSeedQuestions.where((q) => q.isExamRelevant).toList(growable: false);

/// Anzahl Karteikarten je Thema.
Map<String, int> kCardCountByTopic() {
  final out = <String, int>{};
  for (final c in kSeedFlashcards) {
    out[c.topicId] = (out[c.topicId] ?? 0) + 1;
  }
  return out;
}

/// Anzahl Aufgaben je Thema - Grundlage fuer die Coverage-Berechnung in der
/// Pruefungsreife.
Map<String, int> kPoolSizeByTopic() {
  final out = <String, int>{};
  for (final q in kExamRelevantQuestions) {
    out[q.topicId] = (out[q.topicId] ?? 0) + 1;
  }
  return out;
}
