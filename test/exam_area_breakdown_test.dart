import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/features/exam/exam_area_breakdown.dart';
import 'package:ap1_trainer/state/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/exam_fixtures.dart';

void main() {
  test('Punkte je Bereich und schwächstes Thema', () {
    final parts = [for (final c in fullCaseSet()) ...c.parts];
    final a = parts.firstWhere((p) => p.points >= 2);
    final areaA = Topics.byId(a.topicId).areaId;
    final b = parts.firstWhere(
      (p) => p.points >= 2 && Topics.byId(p.topicId).areaId != areaA,
    );
    final areaB = Topics.byId(b.topicId).areaId;

    SessionItem item(Question q, double score) => SessionItem(
      question: q,
      grade: GradeResult(score: score, parts: const {}),
    );
    final r = AreaBreakdown.of([item(a, 1), item(b, 0)]);

    expect(r.areas.keys.toSet(), {areaA, areaB});
    expect(r.areas[areaA]!.earned, a.points.toDouble());
    expect(r.areas[areaA]!.possible, a.points);
    expect(r.areas[areaA]!.ratio, 1);
    expect(r.areas[areaB]!.earned, 0);
    expect(r.areas[areaB]!.possible, b.points);
    expect(r.areas[areaB]!.lost, b.points.toDouble());
    expect(r.weakestTopicId, b.topicId);

    // Alles richtig: kein schwächstes Thema.
    expect(AreaBreakdown.of([item(a, 1), item(b, 1)]).weakestTopicId, isNull);
    expect(AreaBreakdown.of(const []).areas, isEmpty);
  });
}
