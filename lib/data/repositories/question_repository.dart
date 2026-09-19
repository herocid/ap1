import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/env.dart';
import '../models/question.dart';
import '../seed/seed_data.dart';

/// Woher die Aufgaben kommen.
abstract class QuestionRepository {
  Future<List<Question>> fetchAll();
}

/// Die eingebauten Aufgaben. Immer verfuegbar, auch ohne Netz und ohne
/// Supabase-Konfiguration.
class SeedQuestionRepository implements QuestionRepository {
  const SeedQuestionRepository();

  @override
  Future<List<Question>> fetchAll() async => kSeedQuestions;
}

/// Aufgaben aus Supabase. Faellt bei jedem Fehler auf den Seed zurueck -
/// eine leere Aufgabenliste waere fuer die App fataler als veraltete Inhalte.
class SupabaseQuestionRepository implements QuestionRepository {
  SupabaseQuestionRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Question>> fetchAll() async {
    try {
      final rows = await _client
          .from('ap1_questions')
          .select()
          .eq('is_active', true)
          .order('id');
      final parsed = (rows as List)
          .map((r) => Question.fromJson((r as Map).cast<String, dynamic>()))
          .toList();
      if (parsed.isEmpty) return kSeedQuestions;
      return parsed;
    } catch (e) {
      debugPrint('Supabase-Abruf fehlgeschlagen, nutze Seed-Daten: $e');
      return kSeedQuestions;
    }
  }
}

QuestionRepository createQuestionRepository() {
  if (!Env.hasSupabase) return const SeedQuestionRepository();
  try {
    return SupabaseQuestionRepository(Supabase.instance.client);
  } catch (_) {
    return const SeedQuestionRepository();
  }
}
