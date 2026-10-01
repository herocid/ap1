import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/notifications/reminder_plan.dart';
import '../core/util/achievements.dart';
import '../core/util/exam_composer.dart';
import '../core/util/mistake_tracker.dart';
import '../core/util/study_plan.dart';
import '../data/models/exam_area.dart';
import '../data/models/exam_case.dart';
import '../data/models/flashcard.dart';
import '../data/models/resume.dart';
import '../data/models/nugget.dart';
import '../data/models/profile.dart';
import '../data/models/progress.dart';
import '../data/models/question.dart';
import '../data/models/subtopic.dart';
import '../data/models/topic.dart';
import '../data/repositories/local_store.dart';
import '../data/repositories/question_repository.dart';
import '../data/seed/nuggets/nuggets_data.dart';
import '../data/seed/seed_data.dart';

/// Wird in `main()` mit der echten Instanz überschrieben.
final localStoreProvider = Provider<LocalStore>((ref) {
  throw UnimplementedError('localStoreProvider muss überschrieben werden');
});

final questionRepositoryProvider = Provider<QuestionRepository>(
  (ref) => createQuestionRepository(),
);

/// Der Aufgabenpool. Startet sofort mit den Seed-Daten und wird ersetzt,
/// sobald Supabase geantwortet hat - so gibt es nie einen leeren Bildschirm.
final questionPoolProvider = FutureProvider<List<Question>>((ref) async {
  return ref.read(questionRepositoryProvider).fetchAll();
});

/// Synchroner Zugriff auf den Pool (Seed als Fallback während des Ladens).
final questionsProvider = Provider<List<Question>>((ref) {
  return ref
      .watch(questionPoolProvider)
      .maybeWhen(data: (qs) => qs, orElse: () => kSeedQuestions);
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
  ProfileNotifier(this._store)
    : super(_store.readProfile() ?? UserProfile.initial());

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

  void markTutorialSeen() => update((p) => p.copyWith(tutorialSeen: true));
}

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile>((
  ref,
) {
  return ProfileNotifier(ref.watch(localStoreProvider));
});

final themeModeProvider = Provider<ThemeMode>(
  (ref) => ref.watch(profileProvider).themeMode,
);

// -------------------------------------------------------------- Fortschritt

class ProgressNotifier extends StateNotifier<ProgressState> {
  ProgressNotifier(this._store) : super(_store.readProgress());

  final LocalStore _store;

  /// Trägt eine beantwortete Aufgabe ein und aktualisiert Streak und Badges.
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
    _store.appendAnswers([r]);
    _store.writeProgressMeta(next);
  }

  /// Mehrere Antworten auf einmal - so werden Prüfungssimulationen gebucht,
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
    _store.appendAnswers(records);
    _store.writeProgressMeta(next);
  }

  void reset() {
    state = const ProgressState();
    _store.clearProgress();
  }

  /// Gibt (aktuellerStreak, längsterStreak) zurück.
  (int, int) _updateStreak(ProgressState s, DateTime at) {
    final today = DateTime(at.year, at.month, at.day);
    final last = s.lastActiveDay;
    if (last == null) return (1, 1);

    final lastDay = DateTime(last.year, last.month, last.day);
    final diff = today.difference(lastDay).inDays;

    final streak = switch (diff) {
      0 => s.streak == 0 ? 1 : s.streak, // heute schon aktiv gewesen
      1 => s.streak + 1, // gestern aktiv -> Serie läuft weiter
      _ => 1, // Lücke -> Serie beginnt neu
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

    // Fehlerjäger: Aufgaben, die früher falsch und später richtig waren.
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

    // „Ernstfall bestanden“ und „Note 1“ wertet [evaluateAchievements] aus
    // den Prüfungspunkten aus - nur volle Simulationen zählen.

    return earned;
  }
}

final progressProvider = StateNotifierProvider<ProgressNotifier, ProgressState>(
  (ref) {
    return ProgressNotifier(ref.watch(localStoreProvider));
  },
);

/// Der Prüfungsreife-Wert (0..100), abgeleitet aus Fortschritt und Poolgröße.
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

// ------------------------------------------------------- Bereichsauswertung

/// Prüfungsreife je Katalogbereich (0..100).
///
/// Innerhalb eines Bereichs wird auf dessen eigenes Gewicht normiert: Ein
/// Bereich mit 6 % Punkteanteil kann genauso 100 % erreichen wie einer mit
/// 22 %. Sonst wären die kleinen Bereiche optisch immer "schlecht".
final areaReadinessProvider = Provider<Map<String, int>>((ref) {
  final stats = ref.watch(topicStatsProvider);
  final out = <String, int>{};
  for (final area in ExamAreas.all) {
    final topics = Topics.ofArea(area.id);
    final total = topics.fold<double>(0, (s, t) => s + t.weight);
    if (total <= 0) {
      out[area.id] = 0;
      continue;
    }
    var acc = 0.0;
    for (final t in topics) {
      acc += t.weight * (stats[t.id]?.confidence ?? 0);
    }
    out[area.id] = ((acc / total) * 100).round().clamp(0, 100);
  }
  return out;
});

// ---------------------------------------------------------- Karteikarten

/// Alle Lernkarteikarten.
final flashcardsProvider = Provider<List<Flashcard>>((ref) => kSeedFlashcards);

/// Anzahl Karten je Thema.
final cardCountProvider = Provider<Map<String, int>>((ref) {
  final out = <String, int>{};
  for (final c in ref.watch(flashcardsProvider)) {
    out[c.topicId] = (out[c.topicId] ?? 0) + 1;
  }
  return out;
});

/// Der Karteikasten: welche Karte in welchem Leitner-Fach liegt.
class DeckNotifier extends StateNotifier<DeckState> {
  DeckNotifier(this._store) : super(_store.readDeck());

  final LocalStore _store;

  void answer(String cardId, {required bool knewIt}) {
    state = state.withAnswer(cardId, knewIt);
    _store.writeCardState(state.stateOf(cardId));
  }

  void reset() {
    state = const DeckState();
    _store.clearDeck();
  }
}

final deckProvider = StateNotifierProvider<DeckNotifier, DeckState>((ref) {
  return DeckNotifier(ref.watch(localStoreProvider));
});

/// Der laufende Durchlauf („Full Run“) - `null`, solange keiner gestartet
/// wurde. Karten, die es nach einem Update nicht mehr gibt, fallen heraus.
class CardRunNotifier extends StateNotifier<CardRun?> {
  CardRunNotifier(this._store, Set<String> existing)
    : super(_store.readCardRun()?.restrictedTo(existing));

  final LocalStore _store;

  void start(CardRun run) {
    state = run;
    _store.writeCardRun(run);
  }

  void answer(String cardId, {required bool knewIt}) {
    final run = state;
    if (run == null) return;
    state = run.withAnswer(cardId, knewIt: knewIt);
    _store.writeCardRun(state);
  }

  void clear() {
    state = null;
    _store.writeCardRun(null);
  }
}

final cardRunProvider = StateNotifierProvider<CardRunNotifier, CardRun?>((ref) {
  return CardRunNotifier(ref.watch(localStoreProvider), {
    for (final c in ref.read(flashcardsProvider)) c.id,
  });
});

/// Abgefragte Karten je Tag.
class CardActivityNotifier extends StateNotifier<CardActivity> {
  CardActivityNotifier(this._store) : super(_store.readCardActivity());

  final LocalStore _store;

  void log({required bool knewIt}) {
    state = state.withAnswer(knewIt: knewIt);
    _store.writeCardActivity(state);
  }

  void reset() => state = const CardActivity();
}

final cardActivityProvider =
    StateNotifierProvider<CardActivityNotifier, CardActivity>((ref) {
      return CardActivityNotifier(ref.watch(localStoreProvider));
    });

/// Kennzahlen des ganzen Kastens, einmal je Änderung berechnet statt bei
/// jedem Neuaufbau eines Screens - bei rund 3.000 Karten spürbar.
typedef DeckSummary = ({
  int reviews,
  int fresh,
  double mastery,
  int weak,
  int solid,
  double? accuracy,
});

final deckSummaryProvider = Provider<DeckSummary>((ref) {
  final deck = ref.watch(deckProvider);
  final cards = ref.watch(flashcardsProvider);
  return (
    reviews: deck.dueReviewCount(cards),
    fresh: deck.dueNewCount(cards),
    mastery: deck.mastery(cards),
    weak: deck.weakCards(cards, limit: 1 << 30).length,
    solid: deck.learnedCount(cards),
    accuracy: deck.accuracy(cards),
  );
});

/// Wie viele Karten heute fällig sind - die Zahl fürs Dashboard.
final dueCardsProvider = Provider<int>((ref) {
  final deck = ref.watch(deckProvider);
  return deck.dueCount(ref.watch(flashcardsProvider));
});

/// Fällige Wiederholungen - ohne Karten, die noch nie drankamen. „601
/// fällig“ am ersten Tag wäre zwar technisch richtig, schreckt aber ab.
final dueReviewsProvider = Provider<int>((ref) {
  final deck = ref.watch(deckProvider);
  return ref.watch(flashcardsProvider).where((c) {
    final s = deck.stateOf(c.id);
    return !s.isNew && s.isDue();
  }).length;
});

// ------------------------------------------------------- Learning Journey

final nuggetsProvider = Provider<List<Nugget>>((ref) => kSeedNuggets);

/// Lernschritte je Lektion, in Lernreihenfolge.
final lessonStepsProvider = Provider<Map<String, List<Nugget>>>((ref) {
  final out = <String, List<Nugget>>{};
  for (final n in ref.watch(nuggetsProvider)) {
    out.putIfAbsent(n.subtopicId, () => []).add(n);
  }
  return out;
});

/// Lektionen, für die es Lernschritte gibt - in Journey-Reihenfolge.
final lessonsProvider = Provider<List<Subtopic>>((ref) {
  final steps = ref.watch(lessonStepsProvider);
  return Subtopics.all.where((s) => steps.containsKey(s.id)).toList();
});

class JourneyNotifier extends StateNotifier<Set<String>> {
  JourneyNotifier(this._store) : super(_store.readJourney());
  final LocalStore _store;

  void complete(String lessonId) {
    if (state.contains(lessonId)) return;
    state = {...state, lessonId};
    _store.writeJourney(state);
  }

  void reset() {
    state = {};
    _store.writeJourney(state);
  }
}

final journeyProvider = StateNotifierProvider<JourneyNotifier, Set<String>>((
  ref,
) {
  return JourneyNotifier(ref.watch(localStoreProvider));
});

/// Lesezeichen für „Weitermachen“: angefangene Lektion und letzte
/// Kartenrunde.
class ResumeNotifier extends StateNotifier<ResumeState> {
  ResumeNotifier(this._store) : super(_store.readResume());
  final LocalStore _store;

  void lessonAt(String lessonId, int page) {
    state = state.copyWith(
      lesson: LessonBookmark(
        lessonId: lessonId,
        page: page,
        at: DateTime.now(),
      ),
    );
    _store.writeResume(state);
  }

  /// Lektion fertig: Lesezeichen entfernen, falls es auf sie zeigt.
  void lessonDone(String lessonId) {
    if (state.lesson?.lessonId != lessonId) return;
    state = state.copyWith(clearLesson: true);
    _store.writeResume(state);
  }

  void cardsStarted(CardBookmark b) {
    state = state.copyWith(cards: b);
    _store.writeResume(state);
  }

  void reset() {
    state = const ResumeState();
    _store.writeResume(state);
  }
}

final resumeProvider = StateNotifierProvider<ResumeNotifier, ResumeState>((
  ref,
) {
  return ResumeNotifier(ref.watch(localStoreProvider));
});

/// Die angefangene Lektion, sofern sie noch nicht abgeschlossen ist.
final lessonInProgressProvider = Provider<LessonBookmark?>((ref) {
  final b = ref.watch(resumeProvider).lesson;
  if (b == null || ref.watch(journeyProvider).contains(b.lessonId)) {
    return null;
  }
  return b;
});

/// Die erste noch offene Lektion in Lernreihenfolge - oder null, wenn alles
/// geschafft ist.
final nextLessonProvider = Provider<Subtopic?>((ref) {
  final done = ref.watch(journeyProvider);
  return ref
      .watch(lessonsProvider)
      .where((s) => !done.contains(s.id))
      .firstOrNull;
});

/// Aufgaben je Lektion - für den Wissenscheck am Ende einer Lektion.
final questionCountBySubtopicProvider = Provider<Map<String, int>>((ref) {
  final out = <String, int>{};
  for (final q in ref.watch(questionsProvider)) {
    final s = q.subtopicId;
    if (s != null && q.isExamRelevant) out[s] = (out[s] ?? 0) + 1;
  }
  return out;
});

final cardCountBySubtopicProvider = Provider<Map<String, int>>((ref) {
  final out = <String, int>{};
  for (final c in ref.watch(flashcardsProvider)) {
    final s = c.subtopicId;
    if (s != null) out[s] = (out[s] ?? 0) + 1;
  }
  return out;
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

// ------------------------------------------------------ Prüfung und Fehler

/// Alle Fallaufgaben der Prüfungssimulation.
final examCasesProvider = Provider<List<ExamCase>>((ref) => kSeedCases);

/// Wann welcher Fall zuletzt bearbeitet wurde - die Simulation meidet
/// zuletzt gesehene Fälle.
final caseLastSeenProvider = Provider<Map<String, DateTime>>((ref) {
  return ExamComposer.lastSeenByCase(
    ref.watch(examCasesProvider),
    ref.watch(progressProvider).history,
  );
});

/// Die Prüfungsaufgabe des Tages - für alle am selben Tag dieselbe
/// Fallaufgabe. `null`, solange es keine Fallaufgaben gibt.
final dailyPaperProvider = Provider<ExamPaper?>((ref) {
  return ExamComposer.daily(
    cases: ref.watch(examCasesProvider),
    day: DateTime.now(),
  );
});

/// Fehler-Wiederholung mit Abstand: offen bleibt eine Aufgabe, bis sie an
/// zwei verschiedenen Tagen richtig war. Beschränkt auf Aufgaben, die es im
/// Pool noch gibt und die prüfungsrelevant sind.
final mistakeStatusProvider = Provider<MistakeStatus>((ref) {
  final ids = {
    for (final q in ref.watch(questionsProvider))
      if (q.isExamRelevant) q.id,
  };
  return MistakeStatus.of(
    ref.watch(progressProvider).history,
  ).restrictedTo(ids);
});

// ------------------------------------------------------------- Abzeichen

/// Stand aller Abzeichen - abgeleitet aus Antworten, Journey und Karten.
final achievementsProvider = Provider<Map<Achievement, AchievementStatus>>((
  ref,
) {
  return evaluateAchievements(
    progress: ref.watch(progressProvider),
    lessonsDone: ref.watch(journeyProvider),
    lessonCount: ref.watch(lessonsProvider).length,
    deck: ref.watch(deckProvider),
    cards: ref.watch(flashcardsProvider),
    areaReadiness: ref.watch(areaReadinessProvider),
    poolSize: ref.watch(poolSizeProvider),
    pointsById: {for (final q in ref.watch(questionsProvider)) q.id: q.points},
  );
});

/// Geplante Lern-Erinnerungen der nächsten Tage. Ändert sich mit Profil,
/// Fortschritt und Karteikasten; `main.dart` reicht den Plan an den
/// `ReminderService` weiter (heute entfällt, sobald das Tagesziel erreicht ist).
final reminderPlanProvider = Provider<List<PlannedReminder>>((ref) {
  final profile = ref.watch(profileProvider);
  final progress = ref.watch(progressProvider);
  return ReminderPlanner.plan(
    now: DateTime.now(),
    enabled: profile.remindersOn,
    hour: profile.reminderHour,
    goalReachedToday: progress.answeredToday() >= profile.dailyGoal,
    streak: progress.streak,
    lastActiveDay: progress.lastActiveDay,
    dueCards: ref.watch(dueReviewsProvider),
    minutesPerDay: profile.intensitaet.minutesPerDay,
  );
});
