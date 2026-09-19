import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/util/study_plan.dart';
import '../data/models/profile.dart';
import '../data/models/progress.dart';
import '../data/models/question.dart';
import '../data/repositories/local_store.dart';
import '../data/repositories/question_repository.dart';
import '../data/seed/seed_data.dart';

/// Wird in `main()` mit der echten Instanz ueberschrieben.
final localStoreProvider = Provider<LocalStore>((ref) {
  throw UnimplementedError('localStoreProvider muss ueberschrieben werden');
});

final questionRepositoryProvider =
    Provider<QuestionRepository>((ref) => createQuestionRepository());

/// Der Aufgabenpool. Startet sofort mit den Seed-Daten und wird ersetzt,
/// sobald Supabase geantwortet hat - so gibt es nie einen leeren Bildschirm.
final questionPoolProvider = FutureProvider<List<Question>>((ref) async {
  return ref.read(questionRepositoryProvider).fetchAll();
});

/// Synchroner Zugriff auf den Pool (Seed als Fallback waehrend des Ladens).
final questionsProvider = Provider<List<Question>>((ref) {
  return ref.watch(questionPoolProvider).maybeWhen(
        data: (qs) => qs,
        orElse: () => kSeedQuestions,
      );
});

final poolSizeProvider = Provider<Map<String, int>>((ref) {
  final qs = ref.watch(questionsProvider);
  final out = <String, int>{};
  for (final q in qs) {
    out[q.topicId] = (out[q.topicId] ?? 0) + 1;
  }
  return out;
});

// ---------------------------------------------------------------- Profil

class ProfileNotifier extends StateNotifier<UserProfile> {
  ProfileNotifier(this._store) : super(_store.readProfile() ?? UserProfile.initial());

  final LocalStore _store;

  void update(UserProfile Function(UserProfile) fn) {
    state = fn(state);
    _store.writeProfile(state);
  }

  void completeOnboarding({
    required String name,
    required Beruf beruf,
    required DateTime examDate,
    required LernIntensitaet intensitaet,
  }) {
    state = state.copyWith(
      displayName: name,
      beruf: beruf,
      examDate: examDate,
      intensitaet: intensitaet,
      onboarded: true,
    );
    _store.writeProfile(state);
  }

  void setThemeMode(ThemeMode m) => update((p) => p.copyWith(themeMode: m));
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, UserProfile>((ref) {
  return ProfileNotifier(ref.watch(localStoreProvider));
});

final themeModeProvider =
    Provider<ThemeMode>((ref) => ref.watch(profileProvider).themeMode);

// -------------------------------------------------------------- Fortschritt

class ProgressNotifier extends StateNotifier<ProgressState> {
  ProgressNotifier(this._store) : super(_store.readProgress());

  final LocalStore _store;

  /// Traegt eine beantwortete Aufgabe ein und aktualisiert Streak und Badges.
  void record(AnswerRecord r) {
    final history = [...state.history, r];
    final streakInfo = _updateStreak(state, r.at);

    var next = state.copyWith(
      history: history,
      streak: streakInfo.$1,
      longestStreak: streakInfo.$2,
      lastActiveDay: DateTime(r.at.year, r.at.month, r.at.day),
    );
    next = next.copyWith(badges: _evaluateBadges(next));
    state = next;
    _store.writeProgress(state);
  }

  /// Mehrere Antworten auf einmal - so werden Pruefungssimulationen gebucht,
  /// damit der Streak nicht pro Aufgabe neu berechnet wird.
  void recordAll(List<AnswerRecord> records) {
    if (records.isEmpty) return;
    final history = [...state.history, ...records];
    final streakInfo = _updateStreak(state, records.last.at);
    var next = state.copyWith(
      history: history,
      streak: streakInfo.$1,
      longestStreak: streakInfo.$2,
      lastActiveDay: DateTime(
        records.last.at.year,
        records.last.at.month,
        records.last.at.day,
      ),
    );
    next = next.copyWith(badges: _evaluateBadges(next));
    state = next;
    _store.writeProgress(state);
  }

  void reset() {
    state = const ProgressState();
    _store.writeProgress(state);
  }

  /// Gibt (aktuellerStreak, laengsterStreak) zurueck.
  (int, int) _updateStreak(ProgressState s, DateTime at) {
    final today = DateTime(at.year, at.month, at.day);
    final last = s.lastActiveDay;
    if (last == null) return (1, 1);

    final lastDay = DateTime(last.year, last.month, last.day);
    final diff = today.difference(lastDay).inDays;

    final streak = switch (diff) {
      0 => s.streak == 0 ? 1 : s.streak, // heute schon aktiv gewesen
      1 => s.streak + 1, // gestern aktiv -> Serie laeuft weiter
      _ => 1, // Luecke -> Serie beginnt neu
    };
    return (streak, streak > s.longestStreak ? streak : s.longestStreak);
  }

  Set<Achievement> _evaluateBadges(ProgressState s) {
    final earned = {...s.badges};
    final poolSize = kPoolSizeByTopic();
    final stats = s.topicStats(poolSize);

    if (s.history.isNotEmpty) earned.add(Achievement.ersterTag);
    if (s.streak >= 7) earned.add(Achievement.woche);
    if (s.totalAnswered >= 100) earned.add(Achievement.hundert);

    final netzplanPerfect = s.history
        .where((r) => r.topicId == 'netzplan' && r.isCorrect)
        .map((r) => r.questionId)
        .toSet()
        .length;
    if (netzplanPerfect >= 10) earned.add(Achievement.netzplanProfi);

    if (stats.values.every((st) => st.answered >= 5)) {
      earned.add(Achievement.allrounder);
    }

    // Fehlerjaeger: Aufgaben, die frueher falsch und spaeter richtig waren.
    final firstWrong = <String>{};
    final laterRight = <String>{};
    for (final r in s.history) {
      if (!r.isCorrect) {
        firstWrong.add(r.questionId);
      } else if (firstWrong.contains(r.questionId)) {
        laterRight.add(r.questionId);
      }
    }
    if (laterRight.length >= 20) earned.add(Achievement.fehlerjaeger);

    final examRuns = s.history.where((r) => r.mode == SessionMode.pruefung);
    if (examRuns.isNotEmpty) {
      final avg = examRuns.fold<double>(0, (a, r) => a + r.score) /
          examRuns.length;
      if (avg >= 0.5) earned.add(Achievement.simulant);
    }

    return earned;
  }
}

final progressProvider =
    StateNotifierProvider<ProgressNotifier, ProgressState>((ref) {
  return ProgressNotifier(ref.watch(localStoreProvider));
});

/// Der Pruefungsreife-Wert (0..100), abgeleitet aus Fortschritt und Poolgroesse.
final readinessProvider = Provider<int>((ref) {
  final progress = ref.watch(progressProvider);
  final pool = ref.watch(poolSizeProvider);
  return progress.readiness(pool);
});

final topicStatsProvider = Provider<Map<String, TopicStat>>((ref) {
  final progress = ref.watch(progressProvider);
  final pool = ref.watch(poolSizeProvider);
  return progress.topicStats(pool);
});

final studyPlanProvider = Provider<StudyPlan>((ref) {
  return StudyPlanner.build(
    profile: ref.watch(profileProvider),
    progress: ref.watch(progressProvider),
    poolSize: ref.watch(poolSizeProvider),
  );
});

/// Gesehene Theorie-Snacks - steuert, ob vor einer Session der Snack
/// automatisch aufgeht.
class SeenTheoryNotifier extends StateNotifier<Set<String>> {
  SeenTheoryNotifier(this._store) : super(_store.readSeenTheory());
  final LocalStore _store;

  void markSeen(String id) {
    state = {...state, id};
    _store.writeSeenTheory(state);
  }
}

final seenTheoryProvider =
    StateNotifierProvider<SeenTheoryNotifier, Set<String>>((ref) {
  return SeenTheoryNotifier(ref.watch(localStoreProvider));
});
