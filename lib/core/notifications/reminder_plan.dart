import 'package:flutter/foundation.dart';

/// Eine geplante Erinnerung: wann und mit welchem Text von Bit.
@immutable
class PlannedReminder {
  const PlannedReminder({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
  });

  /// Feste Kennung je Tagesversatz, damit Neuplanen alte Einträge ersetzt.
  final int id;
  final DateTime at;
  final String title;
  final String body;

  @override
  String toString() => 'PlannedReminder($id, $at, $body)';
}

/// Reine Planungslogik für die täglichen Lern-Erinnerungen - ohne Plugin,
/// damit sie sich in Unit-Tests prüfen lässt.
///
/// Regeln:
/// - Erinnerungen aus: nichts planen.
/// - Heute nur, wenn das Tagesziel noch offen ist und die Uhrzeit noch kommt.
/// - Folgetage immer (bis [kDaysAhead] Tage im Voraus), weil die App nicht
///   weiß, ob sie bis dahin noch einmal geöffnet wird.
/// - Texte wechseln sich ab; echte Zahlen (Serie, fällige Karten) nur dort,
///   wo sie für den Tag noch stimmen.
class ReminderPlanner {
  const ReminderPlanner._();

  /// Erste Benachrichtigungs-ID; Tag `i` bekommt `kBaseId + i`.
  static const kBaseId = 4200;

  /// So viele Tage im Voraus wird geplant.
  static const kDaysAhead = 14;

  static const title = 'Bit, dein AP1 Coach';

  static List<PlannedReminder> plan({
    required DateTime now,
    required bool enabled,
    required int hour,
    required bool goalReachedToday,
    required int streak,
    required DateTime? lastActiveDay,
    required int dueCards,
    required int minutesPerDay,
    int days = kDaysAhead,
  }) {
    if (!enabled) return const [];
    final h = hour.clamp(0, 23);
    final today = DateTime(now.year, now.month, now.day);
    final liveStreak = activeStreak(
      streak: streak,
      lastActiveDay: lastActiveDay,
      today: today,
    );
    final out = <PlannedReminder>[];
    for (var i = 0; i < days; i++) {
      final at = DateTime(today.year, today.month, today.day + i, h);
      if (i == 0 && (goalReachedToday || !at.isAfter(now))) continue;
      out.add(
        PlannedReminder(
          id: kBaseId + i,
          at: at,
          title: title,
          body: textFor(
            dayOffset: i,
            dayOfYear: _dayOfYear(at),
            goalReachedToday: goalReachedToday,
            streak: liveStreak,
            dueCards: dueCards,
            minutesPerDay: minutesPerDay,
          ),
        ),
      );
    }
    return out;
  }

  /// Serie, die heute noch zählt: zuletzt aktiv gestern oder heute, sonst 0.
  static int activeStreak({
    required int streak,
    required DateTime? lastActiveDay,
    required DateTime today,
  }) {
    if (lastActiveDay == null || streak <= 0) return 0;
    final last = DateTime(
      lastActiveDay.year,
      lastActiveDay.month,
      lastActiveDay.day,
    );
    final gap = DateTime(
      today.year,
      today.month,
      today.day,
    ).difference(last).inHours;
    return gap <= 25 ? streak : 0; // 25 h wegen Sommer-/Winterzeit
  }

  /// Text für einen Tag. Rotiert nach Kalendertag zwischen Serie, fälligen
  /// Karten und allgemeinen Sätzen; fehlt die Zahl, kommt ein anderer Text.
  static String textFor({
    required int dayOffset,
    required int dayOfYear,
    required bool goalReachedToday,
    required int streak,
    required int dueCards,
    required int minutesPerDay,
  }) {
    // Zahlen stimmen nur für heute bzw. morgen (wenn heute schon gelernt).
    final streakValid =
        streak > 0 && (dayOffset == 0 || (dayOffset == 1 && goalReachedToday));
    final cardsValid = dueCards > 0 && dayOffset <= 1;
    final general = _general(minutesPerDay);
    final slot = dayOfYear % 3;
    if (slot == 0 && streakValid) return _streakText(streak);
    if (slot == 1 && cardsValid) return _cardsText(dueCards);
    if (slot == 2 || (!streakValid && !cardsValid)) {
      return general[dayOfYear % general.length];
    }
    return streakValid ? _streakText(streak) : _cardsText(dueCards);
  }

  static String _streakText(int s) => s == 1
      ? 'Deine Serie hat begonnen. Heute machst du Tag 2 daraus!'
      : 'Deine Serie läuft seit $s Tagen. Lass sie heute nicht abreißen!';

  static String _cardsText(int n) => n == 1
      ? '1 Karte ist fällig. Schnell auffrischen, bevor sie verblasst.'
      : '$n Karten sind fällig. Kurz auffrischen, dann sitzen sie.';

  static List<String> _general(int minutes) => [
    'Zeit für deine $minutes Minuten. Ich hab schon was vorbereitet.',
    'Kleine Runde, großer Effekt: Lass uns ein paar Aufgaben machen.',
    'Die AP1 rückt näher. Ein Schritt heute zählt mehr als drei morgen.',
    'Bereit für eine Lektion? Ich warte schon auf dich.',
  ];

  static int _dayOfYear(DateTime d) =>
      DateTime.utc(
        d.year,
        d.month,
        d.day,
      ).difference(DateTime.utc(d.year)).inDays +
      1;
}
