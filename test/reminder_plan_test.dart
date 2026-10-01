import 'package:ap1_trainer/core/notifications/reminder_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<PlannedReminder> plan({
    DateTime? now,
    bool enabled = true,
    int hour = 18,
    bool goal = false,
    int streak = 0,
    DateTime? lastActive,
    int due = 0,
  }) => ReminderPlanner.plan(
    now: now ?? DateTime(2026, 10, 1, 9),
    enabled: enabled,
    hour: hour,
    goalReachedToday: goal,
    streak: streak,
    lastActiveDay: lastActive,
    dueCards: due,
    minutesPerDay: 15,
  );

  test('aus: nichts geplant', () {
    expect(plan(enabled: false), isEmpty);
  });

  test('Ziel offen: heute und Folgetage geplant', () {
    final p = plan();
    expect(p, hasLength(ReminderPlanner.kDaysAhead));
    expect(p.first.at, DateTime(2026, 10, 1, 18));
    expect(p.last.at, DateTime(2026, 10, 14, 18));
    expect(p.map((r) => r.id).toSet(), hasLength(p.length));
  });

  test('Ziel erreicht: heute übersprungen, morgen geplant', () {
    final p = plan(goal: true);
    expect(p, hasLength(ReminderPlanner.kDaysAhead - 1));
    expect(p.first.at, DateTime(2026, 10, 2, 18));
  });

  test('Uhrzeit heute schon vorbei: heute übersprungen', () {
    final p = plan(now: DateTime(2026, 10, 1, 19));
    expect(p.first.at, DateTime(2026, 10, 2, 18));
  });

  test('Serie nur, wenn sie noch läuft', () {
    final today = DateTime(2026, 10, 1);
    expect(
      ReminderPlanner.activeStreak(
        streak: 5,
        lastActiveDay: DateTime(2026, 9, 30, 20),
        today: today,
      ),
      5,
    );
    expect(
      ReminderPlanner.activeStreak(
        streak: 5,
        lastActiveDay: DateTime(2026, 9, 28),
        today: today,
      ),
      0,
    );
  });

  test('Texte nutzen echte Zahlen und wechseln ab', () {
    String text(int doy, {int offset = 0, int streak = 5, int due = 12}) =>
        ReminderPlanner.textFor(
          dayOffset: offset,
          dayOfYear: doy,
          goalReachedToday: false,
          streak: streak,
          dueCards: due,
          minutesPerDay: 15,
        );
    expect(text(3), contains('seit 5 Tagen'));
    expect(text(4), contains('12 Karten sind fällig'));
    expect(text(5), isNot(contains('5 Tagen')));
    expect(text(5), isNot(contains('12 Karten')));
    // Ohne Zahlen immer allgemein, z. B. mit den Minuten.
    final general = {for (var d = 0; d < 12; d++) text(d, streak: 0, due: 0)};
    expect(general.length, greaterThan(2));
    expect(general.any((t) => t.contains('15 Minuten')), isTrue);
    // Zahlen für spätere Tage werden nicht behauptet.
    expect(text(3, offset: 5), isNot(contains('Serie')));
    expect(text(4, offset: 5), isNot(contains('Karten sind')));
  });

  test('plan setzt Serie und Karten heute ein', () {
    final p = plan(streak: 5, lastActive: DateTime(2026, 9, 30), due: 12);
    final today = p.first.body;
    expect(
      today.contains('seit 5 Tagen') || today.contains('12 Karten'),
      isTrue,
      reason: today,
    );
  });
}
