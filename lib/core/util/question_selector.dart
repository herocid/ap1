import 'dart:math' as math;

import '../../data/models/progress.dart';
import '../../data/models/question.dart';
import '../../data/models/topic.dart';

/// Waehlt aus, welche Aufgaben als naechstes drankommen.
///
/// Statt Zufall: eine Prioritaetsformel aus drei Bestandteilen -
/// Fehlerspeicher, Themenschwaeche und Wiederholungsabstand. Ziel ist, dass
/// die App genau die Aufgaben zeigt, die den Punktestand in der Pruefung am
/// staerksten bewegen.
class QuestionSelector {
  const QuestionSelector._();

  /// Uebungs- und Fokus-Sessions.
  ///
  /// [topicFilter] beschraenkt auf ein Thema (Fokus-Training aus dem
  /// Dashboard), [mistakesOnly] zieht ausschliesslich aus dem Fehlerspeicher.
  static List<Question> forPractice({
    required List<Question> pool,
    required ProgressState progress,
    required Map<String, int> poolSize,
    int count = 10,
    String? topicFilter,
    bool mistakesOnly = false,
    int? seed,
  }) {
    final rnd = math.Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final stats = progress.topicStats(poolSize);
    final mistakes = progress.openMistakes;
    final lastSeen = _lastSeenByQuestion(progress);

    var candidates = pool.where((q) {
      // Ab 2025 gestrichene Aufgaben kommen nie in eine Uebung. Sie bleiben
      // nur als Nachschlagewerk im Pool.
      if (!q.isExamRelevant) return false;
      if (topicFilter != null && q.topicId != topicFilter) return false;
      if (mistakesOnly && !mistakes.contains(q.id)) return false;
      return true;
    }).toList();

    if (candidates.isEmpty) return const [];

    final now = DateTime.now();
    final scored = candidates.map((q) {
      var score = 0.0;

      // 1. Fehlerspeicher: zuletzt falsch beantwortet. Staerkster Treiber -
      //    was man nicht kann, bringt die meisten Punkte.
      if (mistakes.contains(q.id)) score += 100;

      // 2. Themenschwaeche, gewichtet mit dem Pruefungsanteil des Themas.
      //    Ein schwaches Thema mit 18 % Punkteanteil ist dringender als ein
      //    schwaches Thema mit 4 %.
      final st = stats[q.topicId];
      final weakness = 1.0 - (st?.mastery ?? 0.0);
      final weight = Topics.map[q.topicId]?.weight ?? 0.1;
      score += weakness * weight * 200;

      // 3. Noch nie gesehen: klarer Bonus, damit die Abdeckung waechst.
      final seen = lastSeen[q.id];
      if (seen == null) {
        score += 40;
      } else {
        // 4. Wiederholungsabstand: je laenger her, desto faelliger.
        //    Deckel bei 30 Tagen, damit alte Aufgaben nicht alles verdraengen.
        final days = now.difference(seen).inDays.clamp(0, 30);
        score += days * 1.5;
      }

      // 5. Schwierigkeit an das Koennen anpassen: wer im Thema stark ist,
      //    bekommt haertere Aufgaben.
      final mastery = st?.mastery ?? 0.0;
      final wanted = mastery < 0.4 ? 1 : (mastery < 0.75 ? 2 : 3);
      score -= (q.difficulty - wanted).abs() * 12;

      // 6. Etwas Rauschen, damit zwei Sessions hintereinander nicht identisch
      //    aussehen.
      score += rnd.nextDouble() * 15;

      return (q, score);
    }).toList()
      ..sort((a, b) => b.$2.compareTo(a.$2));

    return scored.take(count).map((e) => e.$1).toList();
  }

  /// Aufgabenmix fuer die Pruefungssimulation.
  ///
  /// Die Themen werden nach ihrem geschaetzten Punkteanteil in der AP1
  /// verteilt - nicht nach dem, was der Lernende gern uebt. Genau das
  /// unterscheidet die Simulation vom Training.
  static List<Question> forExam({
    required List<Question> pool,
    required int count,
    int? seed,
  }) {
    final rnd = math.Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final relevant = pool.where((q) => q.isExamRelevant).toList();
    final byTopic = <String, List<Question>>{};
    for (final q in relevant) {
      byTopic.putIfAbsent(q.topicId, () => []).add(q);
    }

    final picked = <Question>[];
    final used = <String>{};

    // Erste Runde: Soll-Anzahl je Thema nach Gewichtung.
    for (final t in Topics.all) {
      final available = [...(byTopic[t.id] ?? const <Question>[])]..shuffle(rnd);
      final want = (count * t.weight).round();
      for (final q in available.take(want)) {
        if (used.add(q.id)) picked.add(q);
      }
    }

    // Zweite Runde: Rundungsreste auffuellen.
    if (picked.length < count) {
      final rest = relevant.where((q) => !used.contains(q.id)).toList()
        ..shuffle(rnd);
      for (final q in rest) {
        if (picked.length >= count) break;
        if (used.add(q.id)) picked.add(q);
      }
    }

    final result = picked.take(count).toList()..shuffle(rnd);

    // In der echten Pruefung stehen zusammengehoerige Aufgaben beieinander -
    // wir gruppieren deshalb nach Thema, damit kein Themen-Pingpong entsteht.
    result.sort((a, b) => a.topicId.compareTo(b.topicId));
    return result;
  }

  static Map<String, DateTime> _lastSeenByQuestion(ProgressState p) {
    final out = <String, DateTime>{};
    for (final r in p.history) {
      final prev = out[r.questionId];
      if (prev == null || r.at.isAfter(prev)) out[r.questionId] = r.at;
    }
    return out;
  }
}
