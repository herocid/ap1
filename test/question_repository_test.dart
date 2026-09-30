import 'package:ap1_trainer/data/repositories/question_repository.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

/// Eine Datenbankzeile, wie Supabase sie vor der Learning Journey lieferte:
/// ohne Spalte subtopic_id.
Map<String, dynamic> _row(String id, {bool active = true}) {
  final q = kSeedQuestions.firstWhere((q) => q.id == id);
  return {...q.toJson(), 'is_active': active}..remove('subtopic_id');
}

void main() {
  final withLesson = kSeedQuestions.firstWhere((q) => q.subtopicId != null).id;
  final other = kSeedQuestions.firstWhere((q) => q.id != withLesson).id;

  test('fehlende Lektion wird aus dem Seed ergänzt', () {
    final out = mergeWithSeed([_row(withLesson)], kSeedQuestions);
    final q = out.firstWhere((q) => q.id == withLesson);
    expect(q.subtopicId, isNotNull);
  });

  test('Aufgaben, die nur der Seed kennt, kommen dazu', () {
    final out = mergeWithSeed([_row(withLesson)], kSeedQuestions);
    expect(
      out.map((q) => q.id).toSet(),
      kSeedQuestions.map((q) => q.id).toSet(),
    );
  });

  test('in der Datenbank deaktivierte Aufgaben bleiben ausgeblendet', () {
    final out = mergeWithSeed([
      _row(withLesson),
      _row(other, active: false),
    ], kSeedQuestions);
    expect(out.any((q) => q.id == other), isFalse);
  });

  test('ohne aktive Zeilen bleibt das Ergebnis leer (Aufrufer nimmt Seed)', () {
    expect(mergeWithSeed(const [], kSeedQuestions), isEmpty);
  });
}
