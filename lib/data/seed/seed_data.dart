export 'cards/cards_data.dart' show kSeedFlashcards;
export 'cases/cases_data.dart' show kSeedCases, kCaseById;
import '../models/question.dart';
import '../models/theory.dart';
import 'cards/cards_data.dart';
import 'cases/cases_data.dart';
import 'questions/ihk_a01_planung.dart';
import 'questions/ihk_a01_projekte.dart';
import 'questions/ihk_a02_kunden.dart';
import 'questions/ihk_a03_systeme.dart';
import 'questions/ihk_a04_daten.dart';
import 'questions/ihk_a04_entwicklung.dart';
import 'questions/ihk_a05_qualitaet.dart';
import 'questions/ihk_a06_sicherheit.dart';
import 'questions/ihk_a07_vertraege.dart';
import 'questions/questions_a01_journey.dart';
import 'questions/questions_a01_planung.dart';
import 'questions/questions_a02_kunden.dart';
import 'questions/questions_a03_systeme.dart';
import 'questions/questions_a04_daten.dart';
import 'questions/questions_a04_entwicklung.dart';
import 'questions/questions_a05_qualitaet.dart';
import 'questions/questions_a06_krypto.dart';
import 'questions/questions_a06_sicherheit.dart';
import 'questions/questions_a07_vertraege.dart';
import 'seed_anforderungen.dart';
import 'seed_grundlagen.dart';
import 'seed_netzplan.dart';
import 'seed_qs_service.dart';
import 'seed_theory.dart';

/// Der komplette Aufgabenpool der App.
///
/// Diese Liste ist zugleich die Quelle für den SQL-Seed in
/// `supabase/migrations` - beides muss inhaltlich übereinstimmen, damit die
/// App offline und online dieselben Aufgaben zeigt.
final List<Question> kSeedQuestions = [
  ...seedGrundlagen,
  ...seedNetzplan,
  ...seedAnforderungen,
  ...seedQsService,
  ...questionsA01Journey,
  ...questionsA01Planung,
  ...questionsA02,
  ...questionsA03,
  ...questionsA04Entwicklung,
  ...questionsA04Daten,
  ...questionsA05,
  ...questionsA06Sicherheit,
  ...questionsA06Krypto,
  ...questionsA07,
  ...ihkA01Projekte,
  ...ihkA01Planung,
  ...ihkA02,
  ...ihkA03,
  ...ihkA04Entwicklung,
  ...ihkA04Daten,
  ...ihkA05,
  ...ihkA06,
  ...ihkA07,
  // Teilaufgaben der Fallaufgaben (mit caseId) - auch im Quiz verfügbar.
  for (final c in kSeedCases) ...c.parts,
];

final List<TheorySnack> kSeedTheory = seedTheory;

/// Nur die Aufgaben, die nach dem Katalog 2025 noch drankommen können.
/// Alles andere bleibt im Pool, wird aber nie ausgewählt.
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

/// Anzahl Aufgaben je Thema - Grundlage für die Coverage-Berechnung in der
/// Prüfungsreife.
Map<String, int> kPoolSizeByTopic() {
  final out = <String, int>{};
  for (final q in kExamRelevantQuestions) {
    out[q.topicId] = (out[q.topicId] ?? 0) + 1;
  }
  return out;
}
