import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import 'topic.dart';

enum SessionMode {
  /// Freies Üben mit Sofort-Feedback.
  uebung,

  /// Gezieltes Training einer Schwachstelle (aus dem Dashboard heraus).
  fokus,

  /// Prüfungssimulation: Zeitdruck, kein Feedback während des Laufs.
  pruefung,
}

/// Ein beantwortetes Item. Die gesamte Statistik der App lässt sich aus
/// dieser Liste neu berechnen - es gibt keinen zweiten, abweichenden
/// Wahrheitsstand.
@immutable
class AnswerRecord {
  const AnswerRecord({
    required this.questionId,
    required this.topicId,
    required this.score,
    required this.seconds,
    required this.at,
    required this.mode,
  });

  final String questionId;
  final String topicId;

  /// 0.0 .. 1.0
  final double score;
  final int seconds;
  final DateTime at;
  final SessionMode mode;

  bool get isCorrect => score >= 0.9999;

  Map<String, dynamic> toJson() => {
        'question_id': questionId,
        'topic_id': topicId,
        'score': score,
        'seconds': seconds,
        'at': at.toIso8601String(),
        'mode': mode.name,
      };

  factory AnswerRecord.fromJson(Map<String, dynamic> j) => AnswerRecord(
        questionId: j['question_id'] as String,
        topicId: j['topic_id'] as String,
        score: (j['score'] as num).toDouble(),
        seconds: (j['seconds'] as num).toInt(),
        at: DateTime.parse(j['at'] as String),
        mode: SessionMode.values
            .firstWhere((m) => m.name == j['mode'], orElse: () => SessionMode.uebung),
      );
}

/// Kennzahlen pro Thema, abgeleitet aus der Historie.
@immutable
class TopicStat {
  const TopicStat({
    required this.topicId,
    required this.answered,
    required this.distinctQuestions,
    required this.mastery,
    required this.coverage,
    required this.lastSeen,
  });

  final String topicId;
  final int answered;
  final int distinctQuestions;

  /// 0..1 - gewichtete Trefferquote, jüngere Antworten zählen mehr.
  final double mastery;

  /// 0..1 - wie viel vom Thema überhaupt schon angefasst wurde.
  final double coverage;
  final DateTime? lastSeen;

  /// Das, was im Dashboard als Balken erscheint: Können *und* Abdeckung.
  double get confidence => mastery * (0.45 + 0.55 * coverage);
}

/// Badges sind bewusst an Verhalten gekoppelt, das wirklich zum Bestehen
/// beiträgt (Dranbleiben, Schwachstellen angehen, Simulation überstehen) -
/// nicht an reine Nutzungsdauer.
enum Achievement {
  ersterTag('Erster Schritt', 'Erste Session abgeschlossen'),
  woche('Sieben am Stück', '7 Tage Streak'),
  netzplanProfi('Netzplan-Profi', '10 Netzplan-Aufgaben fehlerfrei'),
  fehlerjaeger('Fehlerjäger', '20 früher falsche Aufgaben korrigiert'),
  simulant('Ernstfall bestanden', 'Prüfungssimulation mit >= 50 % beendet'),
  allrounder('Allrounder', 'In jedem Thema mindestens 5 Aufgaben'),
  hundert('Hundert', '100 Aufgaben insgesamt');

  const Achievement(this.title, this.description);
  final String title;
  final String description;
}

@immutable
class ProgressState {
  const ProgressState({
    this.history = const [],
    this.streak = 0,
    this.longestStreak = 0,
    this.lastActiveDay,
    this.badges = const {},
  });

  final List<AnswerRecord> history;
  final int streak;
  final int longestStreak;
  final DateTime? lastActiveDay;
  final Set<Achievement> badges;

  int get totalAnswered => history.length;

  /// XP-Formel: volle Antwort = 10 XP, Teilpunkte anteilig, Mindestlohn 2 XP
  /// fürs Versuchen. Kein XP-Multiplikator für Tempo - das würde zu
  /// Ratewürfeln erziehen.
  int get xp => history.fold<int>(
        0,
        (sum, r) => sum + math.max(2, (r.score * 10).round()),
      );

  int get level => math.max(1, (math.sqrt(xp / 45) + 1).floor());

  int get xpForCurrentLevel => (math.pow(level - 1, 2) * 45).round();
  int get xpForNextLevel => (math.pow(level, 2) * 45).round();

  double get levelProgress {
    final span = xpForNextLevel - xpForCurrentLevel;
    if (span <= 0) return 0;
    return ((xp - xpForCurrentLevel) / span).clamp(0.0, 1.0);
  }

  int answeredToday() {
    final now = DateTime.now();
    return history
        .where((r) =>
            r.at.year == now.year &&
            r.at.month == now.month &&
            r.at.day == now.day)
        .length;
  }

  /// Aufgaben, die beim letzten Versuch daneben gingen und noch nicht
  /// korrigiert wurden - die Grundlage für den Fehlerspeicher.
  Set<String> get openMistakes {
    final latest = <String, AnswerRecord>{};
    for (final r in history) {
      final prev = latest[r.questionId];
      if (prev == null || r.at.isAfter(prev.at)) latest[r.questionId] = r;
    }
    return latest.entries
        .where((e) => !e.value.isCorrect)
        .map((e) => e.key)
        .toSet();
  }

  /// Statistik je Thema. [poolSize] liefert die Gesamtzahl verfügbarer
  /// Aufgaben pro Thema, damit Coverage ehrlich bleibt.
  Map<String, TopicStat> topicStats(Map<String, int> poolSize) {
    final byTopic = <String, List<AnswerRecord>>{};
    for (final r in history) {
      byTopic.putIfAbsent(r.topicId, () => []).add(r);
    }

    final out = <String, TopicStat>{};
    for (final t in Topics.all) {
      final rs = byTopic[t.id] ?? const <AnswerRecord>[];
      if (rs.isEmpty) {
        out[t.id] = TopicStat(
          topicId: t.id,
          answered: 0,
          distinctQuestions: 0,
          mastery: 0,
          coverage: 0,
          lastSeen: null,
        );
        continue;
      }
      final sorted = [...rs]..sort((a, b) => a.at.compareTo(b.at));

      // Exponentielle Gewichtung: die letzten Antworten zählen mehr als die
      // vom ersten Lerntag. Halbwertszeit ~ 8 Antworten.
      var weightSum = 0.0;
      var scoreSum = 0.0;
      for (var i = 0; i < sorted.length; i++) {
        final ageFromEnd = sorted.length - 1 - i;
        final w = math.pow(0.917, ageFromEnd).toDouble();
        weightSum += w;
        scoreSum += w * sorted[i].score;
      }
      final mastery = weightSum == 0 ? 0.0 : scoreSum / weightSum;

      final distinct = rs.map((r) => r.questionId).toSet().length;
      final pool = math.max(1, poolSize[t.id] ?? 1);
      final coverage = (distinct / pool).clamp(0.0, 1.0);

      out[t.id] = TopicStat(
        topicId: t.id,
        answered: rs.length,
        distinctQuestions: distinct,
        mastery: mastery,
        coverage: coverage,
        lastSeen: sorted.last.at,
      );
    }
    return out;
  }

  /// Der Prüfungsreife-Indikator (0..100).
  ///
  /// Gewichteter Mittelwert der Themen-Confidence, gewichtet mit dem
  /// geschätzten Punkteanteil des Themas in der AP1. Themen, die noch gar
  /// nicht angefasst wurden, zählen als 0 - der Wert soll nicht dadurch
  /// steigen, dass man sein Lieblingsthema dreimal durchspielt.
  int readiness(Map<String, int> poolSize) {
    final stats = topicStats(poolSize);
    var acc = 0.0;
    for (final t in Topics.all) {
      acc += t.weight * (stats[t.id]?.confidence ?? 0);
    }
    return (acc * 100).round().clamp(0, 100);
  }

  String readinessLabel(int value) {
    if (value >= 80) return 'Prüfungsreif';
    if (value >= 60) return 'Auf gutem Weg';
    if (value >= 35) return 'Grundlagen sitzen';
    if (value > 0) return 'Aufbauphase';
    return 'Noch keine Daten';
  }

  ProgressState copyWith({
    List<AnswerRecord>? history,
    int? streak,
    int? longestStreak,
    DateTime? lastActiveDay,
    Set<Achievement>? badges,
  }) =>
      ProgressState(
        history: history ?? this.history,
        streak: streak ?? this.streak,
        longestStreak: longestStreak ?? this.longestStreak,
        lastActiveDay: lastActiveDay ?? this.lastActiveDay,
        badges: badges ?? this.badges,
      );

  Map<String, dynamic> toJson() => {
        'history': history.map((r) => r.toJson()).toList(),
        'streak': streak,
        'longest_streak': longestStreak,
        'last_active_day': lastActiveDay?.toIso8601String(),
        'badges': badges.map((b) => b.name).toList(),
      };

  factory ProgressState.fromJson(Map<String, dynamic> j) => ProgressState(
        history: ((j['history'] as List?) ?? const [])
            .map((e) => AnswerRecord.fromJson((e as Map).cast<String, dynamic>()))
            .toList(),
        streak: (j['streak'] as num?)?.toInt() ?? 0,
        longestStreak: (j['longest_streak'] as num?)?.toInt() ?? 0,
        lastActiveDay: DateTime.tryParse((j['last_active_day'] ?? '') as String),
        badges: ((j['badges'] as List?) ?? const [])
            .cast<String>()
            .map((s) => Achievement.values.where((b) => b.name == s).firstOrNull)
            .whereType<Achievement>()
            .toSet(),
      );

  String encode() => jsonEncode(toJson());
  static ProgressState decode(String s) =>
      ProgressState.fromJson((jsonDecode(s) as Map).cast<String, dynamic>());
}
