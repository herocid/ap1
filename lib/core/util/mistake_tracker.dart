import 'package:flutter/foundation.dart';

import '../../data/models/progress.dart';

/// Fehler-Wiederholung mit Abstand.
///
/// Eine falsch beantwortete Aufgabe gilt erst als erledigt, wenn sie danach
/// an ZWEI verschiedenen Tagen richtig war. Sofort noch einmal richtig
/// antworten prüft nur das Kurzzeitgedächtnis - der zweite Tag zeigt, ob es
/// sitzt.
///
/// Abgeleitet aus der Antwort-Historie, ohne eigenen Speicher: Ein neuer
/// Fehler setzt die Zählung zurück.
@immutable
class MistakeStatus {
  const MistakeStatus({required this.open, required this.due});

  static const empty = MistakeStatus(open: {}, due: {});

  /// Alle noch nicht erledigten Fehler.
  final Set<String> open;

  /// Davon heute dran: seit dem letzten Fehler heute noch nicht richtig.
  final Set<String> due;

  /// Heute schon einmal richtig - der zweite Tag steht noch aus.
  Set<String> get waiting => open.difference(due);

  static MistakeStatus of(List<AnswerRecord> history, {DateTime? now}) {
    // Tage mit richtiger Antwort seit dem letzten Fehler, je Aufgabe.
    final rightDays = <String, Set<int>>{};
    for (final r in history) {
      if (!r.isCorrect) {
        rightDays[r.questionId] = <int>{};
      } else {
        rightDays[r.questionId]?.add(_day(r.at));
      }
    }
    final today = _day(now ?? DateTime.now());
    final open = <String>{};
    final due = <String>{};
    rightDays.forEach((id, days) {
      if (days.length >= 2) return;
      open.add(id);
      if (!days.contains(today)) due.add(id);
    });
    return MistakeStatus(open: open, due: due);
  }

  MistakeStatus restrictedTo(Set<String> ids) =>
      MistakeStatus(open: open.intersection(ids), due: due.intersection(ids));

  static int _day(DateTime d) => d.year * 10000 + d.month * 100 + d.day;
}
