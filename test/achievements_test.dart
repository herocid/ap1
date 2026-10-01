import 'package:ap1_trainer/core/util/achievements.dart';
import 'package:ap1_trainer/data/models/flashcard.dart';
import 'package:ap1_trainer/data/models/progress.dart';
import 'package:flutter_test/flutter_test.dart';

AnswerRecord _r(
  String id,
  double score, {
  String topic = 'netzwerke',
  SessionMode mode = SessionMode.uebung,
  DateTime? at,
}) => AnswerRecord(
  questionId: id,
  topicId: topic,
  score: score,
  seconds: 10,
  at: at ?? DateTime(2026, 9, 30, 10),
  mode: mode,
);

Map<Achievement, AchievementStatus> _eval(
  ProgressState p, {
  Set<String> lessons = const {},
  Map<String, int> points = const {},
}) => evaluateAchievements(
  progress: p,
  lessonsDone: lessons,
  lessonCount: 134,
  deck: const DeckState(),
  cards: const [],
  areaReadiness: const {'a01': 20},
  poolSize: const {'netzwerke': 10, 'hardware': 10},
  pointsById: points,
);

void main() {
  test('ohne Daten ist nichts verdient', () {
    final a = _eval(const ProgressState());
    expect(a.values.where((s) => s.earned), isEmpty);
    expect(a.length, Achievement.values.length);
  });

  test('erste Antwort und erste Lektion schalten frei', () {
    final a = _eval(ProgressState(history: [_r('q1', 1)]), lessons: {'l1'});
    expect(a[Achievement.ersterTag]!.earned, isTrue);
    expect(a[Achievement.ersteLektion]!.earned, isTrue);
    expect(a[Achievement.wissbegierig]!.current, 1);
  });

  test('Treffsicher zählt die längste Serie richtiger Antworten', () {
    final h = [
      for (var i = 0; i < 6; i++) _r('a$i', 1),
      _r('x', 0),
      for (var i = 0; i < 10; i++) _r('b$i', 1),
    ];
    final a = _eval(ProgressState(history: h));
    expect(a[Achievement.treffsicher]!.current, 10);
    expect(a[Achievement.treffsicher]!.earned, isTrue);
  });

  test('Fehlerjäger zählt erst falsche, später richtige Aufgaben', () {
    final h = [_r('q1', 0), _r('q2', 0), _r('q1', 1), _r('q3', 1)];
    expect(
      _eval(ProgressState(history: h))[Achievement.fehlerjaeger]!.current,
      1,
    );
  });

  test('Simulation rechnet mit Punkten, nicht mit dem Mittel', () {
    final run = DateTime(2026, 9, 30, 12, 5);
    // 100 Punkte: eine 70-Punkte-Aufgabe falsch, drei 10er richtig.
    final h = [
      _r('big', 0, mode: SessionMode.pruefung, at: run),
      for (var i = 0; i < 3; i++)
        _r('s$i', 1, mode: SessionMode.pruefung, at: run),
    ];
    final points = {'big': 70, 's0': 10, 's1': 10, 's2': 10};
    final a = _eval(ProgressState(history: h), points: points);
    // Ungewichtet wären es 75 % - nach Punkten nur 30 von 100.
    expect(a[Achievement.simulant]!.current, 30);
    expect(a[Achievement.simulant]!.earned, isFalse);
  });

  test('bestandene volle Simulation, Note 1 ab 92 Punkten', () {
    final run1 = DateTime(2026, 9, 30, 12, 5);
    final run2 = DateTime(2026, 9, 30, 15, 5);
    final h = [
      _r('a', 1, mode: SessionMode.pruefung, at: run1),
      _r('b', 0.2, mode: SessionMode.pruefung, at: run1),
      _r('a', 1, mode: SessionMode.pruefung, at: run2),
      _r('b', 0.85, mode: SessionMode.pruefung, at: run2),
    ];
    final points = {'a': 50, 'b': 50};
    final a = _eval(ProgressState(history: h), points: points);
    // Lauf 2: 50 + 42,5 = 92,5 von 100.
    expect(bestExamPercent(h, points), 93);
    expect(a[Achievement.simulant]!.earned, isTrue);
    expect(a[Achievement.bestnote]!.earned, isTrue);
  });

  test('halbe Prüfungen und Übung zählen nicht', () {
    final run = DateTime(2026, 9, 30, 12, 5);
    final h = [
      _r('a', 1, mode: SessionMode.pruefung, at: run),
      _r('b', 1, mode: SessionMode.pruefung, at: run),
      _r('c', 1, at: run),
    ];
    final points = {'a': 25, 'b': 25, 'c': 50};
    final a = _eval(ProgressState(history: h), points: points);
    expect(a[Achievement.simulant]!.current, 0);
    expect(a[Achievement.simulant]!.earned, isFalse);
    expect(a[Achievement.bestnote]!.earned, isFalse);
  });

  test('einmal gespeichert bleibt verdient, auch wenn die Streak reißt', () {
    final a = _eval(const ProgressState(badges: {Achievement.woche}));
    expect(a[Achievement.woche]!.earned, isTrue);
  });

  test('Allrounder richtet sich nach der Zahl der Themen', () {
    final h = [
      for (var i = 0; i < 5; i++) _r('n$i', 1),
      for (var i = 0; i < 5; i++) _r('h$i', 1, topic: 'hardware'),
    ];
    final a = _eval(ProgressState(history: h));
    expect(a[Achievement.allrounder]!.target, 2);
    expect(a[Achievement.allrounder]!.earned, isTrue);
  });
}
