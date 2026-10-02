import 'package:flutter/material.dart';

import '../../data/models/question.dart';
import '../../widgets/question_view.dart';

/// Die eine Stelle, an der Session, Prüfung und Auswertung die
/// Aufgabenansicht einbinden.
///
/// [shuffleSeed] hält die Mischung der Optionen über Neuaufbauten hinweg
/// stabil; [showCaseContext] schaltet die Ausgangssituation einer
/// Fallaufgabe ab, wenn der Bildschirm sie schon selbst zeigt (Prüfung).
///
class QuestionHost extends StatelessWidget {
  const QuestionHost({
    super.key,
    required this.question,
    required this.answer,
    required this.onChanged,
    required this.revealed,
    this.grade,
    this.showExplanation = true,
    this.shuffleSeed,
    this.showCaseContext = true,
    this.showPoints = true,
    this.showMeta = true,
  });

  final Question question;
  final Object? answer;
  final ValueChanged<Object?> onChanged;
  final bool revealed;
  final GradeResult? grade;
  final bool showExplanation;
  final int? shuffleSeed;
  final bool showCaseContext;
  final bool showPoints;

  /// Thema, Format und Schwierigkeit über der Aufgabe; im Prüfungslauf aus.
  final bool showMeta;

  /// Stabiler Mischwert je Runde und Aufgabe.
  static int seedFor(DateTime startedAt, Question q) =>
      Object.hash(startedAt.millisecondsSinceEpoch, q.id) & 0x3fffffff;

  @override
  Widget build(BuildContext context) {
    return QuestionView(
      question: question,
      answer: answer,
      onChanged: onChanged,
      revealed: revealed,
      grade: grade,
      showExplanation: showExplanation,
      shuffleSeed: shuffleSeed,
      showCaseContext: showCaseContext,
      showPoints: showPoints,
      showMeta: showMeta,
    );
  }
}
