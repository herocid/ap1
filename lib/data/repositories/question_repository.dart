import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/env.dart';
import '../models/question.dart';
import '../seed/seed_data.dart';

/// Woher die Aufgaben kommen.
abstract class QuestionRepository {
  Future<List<Question>> fetchAll();
}

/// Die eingebauten Aufgaben. Immer verfügbar, auch ohne Netz und ohne
/// Supabase-Konfiguration.
class SeedQuestionRepository implements QuestionRepository {
  const SeedQuestionRepository();

  @override
  Future<List<Question>> fetchAll() async => kSeedQuestions;
}

/// Aufgaben aus Supabase. Fällt bei jedem Fehler auf den Seed zurück -
/// eine leere Aufgabenliste wäre für die App fataler als veraltete Inhalte.
class SupabaseQuestionRepository implements QuestionRepository {
  SupabaseQuestionRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Question>> fetchAll() async {
    try {
      final rows = await _client.from('ap1_questions').select().order('id');
      final merged = mergeWithSeed(
        (rows as List).map((r) => (r as Map).cast<String, dynamic>()),
        kSeedQuestions,
      );
      return merged.isEmpty ? kSeedQuestions : merged;
    } catch (e) {
      debugPrint('Supabase-Abruf fehlgeschlagen, nutze Seed-Daten: $e');
      return kSeedQuestions;
    }
  }
}

/// Führt die Aufgaben aus der Datenbank mit dem eingebauten Seed zusammen.
///
/// - Datenbankzeilen haben Vorrang, deaktivierte (`is_active = false`)
///   bleiben ausgeblendet - auch wenn der Seed sie noch kennt.
/// - Aufgaben, die nur der Seed kennt, kommen dazu. Sonst fehlen neue
///   Inhalte, bis jemand die Seed-Migration einspielt.
/// - Kennt die Datenbank die Lektion einer Aufgabe nicht, kommt sie aus dem
///   Seed. Ohne sie fände der Wissenscheck einer Lektion keine Aufgaben.
@visibleForTesting
List<Question> mergeWithSeed(
  Iterable<Map<String, dynamic>> rows,
  List<Question> seed,
) {
  final seedById = {for (final q in seed) q.id: q};
  final inDb = <String>{};
  final out = <Question>[];
  for (final row in rows) {
    final id = row['id'].toString();
    inDb.add(id);
    if (row['is_active'] == false) continue;
    final json = Map<String, dynamic>.of(row);
    json['subtopic_id'] ??= seedById[id]?.subtopicId;
    out.add(Question.fromJson(json));
  }
  if (out.isEmpty) return out;
  out.addAll(seed.where((q) => !inDb.contains(q.id)));
  return out;
}

QuestionRepository createQuestionRepository() {
  if (!Env.hasSupabase) return const SeedQuestionRepository();
  try {
    return SupabaseQuestionRepository(Supabase.instance.client);
  } catch (_) {
    return const SeedQuestionRepository();
  }
}
