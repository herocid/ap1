import 'dart:math' as math;

import '../../data/models/flashcard.dart';
import '../../data/models/progress.dart';
import 'answer_format.dart';
import 'exam_composer.dart';

/// Stand eines Abzeichens: wie weit, wie viel nötig, schon verdient?
class AchievementStatus {
  const AchievementStatus({
    required this.current,
    required this.target,
    required this.earned,
  });

  final int current;
  final int target;
  final bool earned;

  double get share => earned ? 1 : (current / target).clamp(0.0, 1.0);
}

/// Berechnet alle Abzeichen aus dem, was die App ohnehin speichert.
///
/// Abgeleitet statt gespeichert: So werden auch neue Abzeichen sofort
/// rückwirkend vergeben. Die gespeicherten [ProgressState.badges] zählen
/// zusätzlich - einmal verdient bleibt verdient, auch wenn z. B. die
/// Streak später reißt.
Map<Achievement, AchievementStatus> evaluateAchievements({
  required ProgressState progress,
  required Set<String> lessonsDone,
  required int lessonCount,
  required DeckState deck,
  required List<Flashcard> cards,
  required Map<String, int> areaReadiness,
  required Map<String, int> poolSize,
  Map<String, int> pointsById = const {},
}) {
  final h = progress.history;
  final answered = h.length;
  final bestStreak = math.max(progress.streak, progress.longestStreak);

  // Längste Serie richtiger Antworten.
  var run = 0;
  var bestRun = 0;
  for (final r in h) {
    run = r.isCorrect ? run + 1 : 0;
    bestRun = math.max(bestRun, run);
  }

  // Aufgaben, die erst falsch und später richtig waren.
  final wrongOnce = <String>{};
  final fixed = <String>{};
  for (final r in h) {
    if (!r.isCorrect) {
      wrongOnce.add(r.questionId);
    } else if (wrongOnce.contains(r.questionId)) {
      fixed.add(r.questionId);
    }
  }

  final netzplan = h
      .where((r) => r.topicId == 'netzplan' && r.isCorrect)
      .map((r) => r.questionId)
      .toSet()
      .length;

  // Themen mit mindestens fünf beantworteten Aufgaben.
  final perTopic = <String, int>{};
  for (final r in h) {
    perTopic[r.topicId] = (perTopic[r.topicId] ?? 0) + 1;
  }
  final topicsWithFive = poolSize.keys.where((t) => (perTopic[t] ?? 0) >= 5);

  final bestExam = bestExamPercent(h, pointsById);

  var learned = 0;
  var longTerm = 0;
  for (final c in cards) {
    final s = deck.stateOf(c.id);
    if (s.isNew) continue;
    if (s.box >= 2) learned++;
    if (s.box >= 4) longTerm++;
  }

  final bestArea = areaReadiness.values.fold<int>(0, math.max);
  final lessons = lessonsDone.length;
  final half = (lessonCount / 2).ceil();

  int valueOf(Achievement a) => switch (a) {
    Achievement.ersterTag ||
    Achievement.warmgelaufen ||
    Achievement.hundert ||
    Achievement.aufgabenprofi => answered,
    Achievement.ersteLektion ||
    Achievement.wissbegierig ||
    Achievement.halbzeit ||
    Achievement.stoffKomplett => lessons,
    Achievement.dranbleiber ||
    Achievement.woche ||
    Achievement.eisern => bestStreak,
    Achievement.treffsicher => bestRun,
    Achievement.fehlerjaeger => fixed.length,
    Achievement.netzplanProfi => netzplan,
    Achievement.allrounder => topicsWithFive.length,
    Achievement.bereichsprofi => bestArea,
    Achievement.kartenstapel => learned,
    Achievement.langzeit => longTerm,
    Achievement.simulant || Achievement.bestnote => bestExam,
  };

  // Ziele, die von der Anzahl der Inhalte abhängen.
  int targetOf(Achievement a) => switch (a) {
    Achievement.halbzeit => math.max(1, half),
    Achievement.stoffKomplett => math.max(1, lessonCount),
    Achievement.allrounder => math.max(1, poolSize.length),
    _ => a.target,
  };

  return {
    for (final a in Achievement.values)
      a: AchievementStatus(
        current: valueOf(a),
        target: targetOf(a),
        earned: progress.badges.contains(a) || valueOf(a) >= targetOf(a),
      ),
  };
}

/// Punkte einer vollen Prüfungssimulation (4 Aufgaben zu je 25 Punkten).
const int kFullExamPoints = 4 * ExamComposer.pointsPerTask;

/// Bestes Ergebnis (0..100, auf ganze Prozent gerundet wie [ihkNote]) einer
/// vollständigen Prüfungssimulation.
///
/// Rechnet wie die Auswertung: erreichte Punkte (je Teilaufgabe auf halbe
/// Punkte gerundet) durch mögliche Punkte. Ein Lauf bucht alle Antworten mit
/// demselben Zeitstempel; abgebrochene Läufe werden gar nicht gebucht. Halbe
/// Prüfungen und Einzelaufgaben (weniger als [kFullExamPoints]) zählen nicht.
int bestExamPercent(List<AnswerRecord> history, Map<String, int> pointsById) {
  final runs = <String, List<AnswerRecord>>{};
  for (final r in history.where((r) => r.mode == SessionMode.pruefung)) {
    runs.putIfAbsent(r.at.toIso8601String().substring(0, 16), () => []).add(r);
  }
  var best = 0;
  for (final list in runs.values) {
    var earned = 0.0;
    var possible = 0;
    for (final r in list) {
      final p = pointsById[r.questionId] ?? 1;
      earned += halfPoints(r.score * p);
      possible += p;
    }
    if (possible < kFullExamPoints) continue;
    best = math.max(best, (earned / possible * 100).round());
  }
  return best;
}
