import 'dart:math' as math;

import '../../data/models/profile.dart';
import '../../data/models/progress.dart';
import '../../data/models/topic.dart';

/// Ein Eintrag im Lernplan: welches Thema wann dran ist und warum.
class PlanBlock {
  const PlanBlock({
    required this.topic,
    required this.fromDay,
    required this.toDay,
    required this.targetQuestions,
    required this.reason,
  });

  final Topic topic;

  /// Tage ab heute (0 = heute).
  final int fromDay;
  final int toDay;
  final int targetQuestions;
  final String reason;
}

class StudyPlan {
  const StudyPlan({
    required this.daysLeft,
    required this.dailyGoal,
    required this.minutesPerDay,
    required this.blocks,
    required this.bufferDays,
    required this.feasible,
    required this.note,
  });

  final int daysLeft;
  final int dailyGoal;
  final int minutesPerDay;
  final List<PlanBlock> blocks;

  /// Die letzten Tage vor der Prüfung sind für Wiederholung und
  /// Simulationen reserviert, nicht für neuen Stoff.
  final int bufferDays;

  /// Ob das Pensum mit der gewählten Intensität überhaupt zu schaffen ist.
  final bool feasible;
  final String note;
}

/// Erzeugt aus Prüfungstermin, Intensität und aktuellem Stand einen
/// konkreten Plan.
///
/// Leitgedanken:
/// - Reihenfolge nach Dringlichkeit = Prüfungsgewicht x Wissenslücke,
///   nicht nach Kapitelnummer.
/// - Die letzten Tage gehören der Wiederholung. Neuer Stoff kurz vor der
///   Prüfung schadet mehr, als er nützt.
/// - Der Plan sagt ehrlich, wenn die Zeit nicht reicht, statt ein
///   unerreichbares Pensum auszuwerfen.
class StudyPlanner {
  const StudyPlanner._();

  static StudyPlan build({
    required UserProfile profile,
    required ProgressState progress,
    required Map<String, int> poolSize,
  }) {
    final daysLeft = math.max(0, profile.daysUntilExam);
    final dailyGoal = profile.dailyGoal;
    final stats = progress.topicStats(poolSize);

    // Wiederholungspuffer: 15 % der Zeit, mindestens 2 und höchstens 10 Tage.
    final bufferDays =
        daysLeft <= 3 ? 0 : (daysLeft * 0.15).round().clamp(2, 10);
    final learnDays = math.max(1, daysLeft - bufferDays);

    final ranked = [...Topics.all]..sort((a, b) {
        final ua = a.weight * (1 - (stats[a.id]?.confidence ?? 0));
        final ub = b.weight * (1 - (stats[b.id]?.confidence ?? 0));
        return ub.compareTo(ua);
      });

    // Tage proportional zur Dringlichkeit verteilen, aber jedes Thema bekommt
    // mindestens einen Tag - sonst fällt bei kurzem Vorlauf die Hälfte weg.
    final urgency = <String, double>{
      for (final t in ranked)
        t.id: math.max(
          0.02,
          t.weight * (1 - (stats[t.id]?.confidence ?? 0)),
        ),
    };
    final urgencySum = urgency.values.fold<double>(0, (a, b) => a + b);

    final blocks = <PlanBlock>[];
    var cursor = 0;
    for (var i = 0; i < ranked.length; i++) {
      final t = ranked[i];
      final share = urgency[t.id]! / urgencySum;
      final isLast = i == ranked.length - 1;
      var days = math.max(1, (learnDays * share).round());
      if (isLast) days = math.max(1, learnDays - cursor);
      if (cursor >= learnDays) days = 1;

      final st = stats[t.id];
      final pool = poolSize[t.id] ?? 0;
      final done = st?.distinctQuestions ?? 0;
      final target = math.max(3, pool - done);

      blocks.add(PlanBlock(
        topic: t,
        fromDay: math.min(cursor, learnDays - 1),
        toDay: math.min(cursor + days - 1, learnDays - 1),
        targetQuestions: target,
        reason: _reasonFor(t, st),
      ));
      cursor += days;
    }

    final totalTarget =
        blocks.fold<int>(0, (sum, b) => sum + b.targetQuestions);
    final capacity = learnDays * dailyGoal;
    final feasible = capacity >= totalTarget;

    return StudyPlan(
      daysLeft: daysLeft,
      dailyGoal: dailyGoal,
      minutesPerDay: profile.intensitaet.minutesPerDay,
      blocks: blocks,
      bufferDays: bufferDays,
      feasible: feasible,
      note: feasible
          ? 'Mit $dailyGoal Aufgaben pro Tag schaffst du den Stoff in '
              '$learnDays Lerntagen und behältst $bufferDays Tage zum '
              'Wiederholen.'
          : 'Bei $dailyGoal Aufgaben pro Tag reichen die $learnDays Lerntage '
              'rechnerisch nicht für alle $totalTarget offenen Aufgaben. '
              'Erhöhe die Intensität auf etwa '
              '${(totalTarget / learnDays).ceil()} Aufgaben pro Tag - oder '
              'konzentriere dich auf die oberen drei Themen dieser Liste.',
    );
  }

  static String _reasonFor(Topic t, TopicStat? st) {
    final weightPct = (t.weight * 100).round();
    if (st == null || st.answered == 0) {
      return 'Noch nicht begonnen, rund $weightPct % der PM-Punkte.';
    }
    if (st.mastery < 0.5) {
      return 'Trefferquote erst ${(st.mastery * 100).round()} % bei '
          '$weightPct % Punkteanteil.';
    }
    if (st.coverage < 0.6) {
      return 'Sitzt gut, aber erst ${(st.coverage * 100).round()} % der '
          'Aufgaben gesehen.';
    }
    return 'Stabil - hier reicht Wiederholung.';
  }
}
