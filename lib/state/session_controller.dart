import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/progress.dart';
import '../data/models/question.dart';
import 'providers.dart';

@immutable
class SessionItem {
  const SessionItem({
    required this.question,
    this.answer,
    this.grade,
    this.checked = false,
    this.seconds = 0,
    this.flagged = false,
  });

  final Question question;

  /// Rohantwort, Format je nach [QuestionKind] - siehe [Question.grade].
  final Object? answer;

  /// Erst gesetzt, wenn geprüft wurde. Im Prüfungsmodus passiert das
  /// gesammelt am Ende.
  final GradeResult? grade;
  final bool checked;
  final int seconds;

  /// Im Prüfungsmodus: zum späteren Nachsehen markiert.
  final bool flagged;

  bool get hasAnswer {
    final a = answer;
    if (a == null) return false;
    if (a is Set) return a.isNotEmpty;
    if (a is Map) return a.isNotEmpty;
    if (a is List) return a.isNotEmpty;
    return true;
  }

  SessionItem copyWith({
    Object? answer,
    bool clearAnswer = false,
    GradeResult? grade,
    bool? checked,
    int? seconds,
    bool? flagged,
  }) => SessionItem(
    question: question,
    answer: clearAnswer ? null : (answer ?? this.answer),
    grade: grade ?? this.grade,
    checked: checked ?? this.checked,
    seconds: seconds ?? this.seconds,
    flagged: flagged ?? this.flagged,
  );
}

@immutable
class SessionState {
  const SessionState({
    required this.mode,
    required this.items,
    required this.index,
    required this.startedAt,
    this.limit,
    this.elapsed = Duration.zero,
    this.finished = false,
    this.topicFilter,
    this.title = 'Übung',
    this.endless = false,
    this.badgesBefore = const {},
  });

  final SessionMode mode;
  final List<SessionItem> items;
  final int index;
  final DateTime startedAt;

  /// Nur im Prüfungsmodus gesetzt.
  final Duration? limit;
  final Duration elapsed;
  final bool finished;
  final String? topicFilter;
  final String title;

  /// Kurztest: Nach jeder Aufgabe kommt eine neue, bis man selbst aufhört.
  final bool endless;

  /// Abzeichen, die beim Start schon verdient waren - für „Neu
  /// freigeschaltet“ in der Auswertung.
  final Set<Achievement> badgesBefore;

  SessionItem get current => items[index];
  bool get isLast => index >= items.length - 1;
  bool get isExam => mode == SessionMode.pruefung;

  /// Bereits geprüfte Aufgaben - im Kurztest die Zahl der beantworteten.
  int get checkedCount => items.where((i) => i.checked).length;

  int get correctCount => items.where((i) => i.grade?.isCorrect == true).length;

  /// Richtige Antworten in Folge, von der neuesten Aufgabe rückwärts.
  int get correctStreak {
    var n = 0;
    for (final i in items.reversed) {
      if (!i.checked) continue;
      if (i.grade?.isCorrect != true) break;
      n++;
    }
    return n;
  }

  Duration? get remaining => limit == null
      ? null
      : (limit! - elapsed).isNegative
      ? Duration.zero
      : limit! - elapsed;

  bool get timeIsUp => limit != null && elapsed >= limit!;

  int get answeredCount => items.where((i) => i.hasAnswer).length;

  double get totalScore {
    if (items.isEmpty) return 0;
    var earned = 0.0;
    var possible = 0.0;
    for (final i in items) {
      possible += i.question.points;
      earned += (i.grade?.score ?? 0) * i.question.points;
    }
    return possible == 0 ? 0 : earned / possible;
  }

  int get earnedPoints => items.fold<int>(
    0,
    (s, i) => s + ((i.grade?.score ?? 0) * i.question.points).round(),
  );

  int get possiblePoints => items.fold<int>(0, (s, i) => s + i.question.points);

  SessionState copyWith({
    List<SessionItem>? items,
    int? index,
    Duration? elapsed,
    bool? finished,
  }) => SessionState(
    mode: mode,
    items: items ?? this.items,
    index: index ?? this.index,
    startedAt: startedAt,
    limit: limit,
    elapsed: elapsed ?? this.elapsed,
    finished: finished ?? this.finished,
    topicFilter: topicFilter,
    title: title,
    endless: endless,
    badgesBefore: badgesBefore,
  );
}

/// Steuert eine laufende Lern- oder Prüfungssession.
///
/// Der Unterschied zwischen Übung und Prüfung steckt fast vollständig in
/// zwei Stellen: [check] ist im Prüfungsmodus gesperrt, und die Auswertung
/// passiert erst in [finish].
class SessionController extends StateNotifier<SessionState?> {
  SessionController(this._ref) : super(null);

  final Ref _ref;
  Timer? _timer;

  /// Liefert im Kurztest die nächste Aufgabe. Bekommt die IDs, die in
  /// dieser Runde schon dran waren, damit sich nichts zu früh wiederholt.
  Question? Function(Set<String> used)? _supply;

  void start({
    required List<Question> questions,
    required SessionMode mode,
    Duration? limit,
    String? topicFilter,
    String title = 'Übung',
    Question? Function(Set<String> used)? supply,
  }) {
    _timer?.cancel();
    _supply = supply;
    if (questions.isEmpty) return;

    state = SessionState(
      mode: mode,
      items: questions.map((q) => SessionItem(question: q)).toList(),
      index: 0,
      startedAt: DateTime.now(),
      limit: limit,
      topicFilter: topicFilter,
      title: title,
      endless: supply != null,
      badgesBefore: {
        for (final e in _ref.read(achievementsProvider).entries)
          if (e.value.earned) e.key,
      },
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final s = state;
    if (s == null || s.finished) return;

    final items = [...s.items];
    items[s.index] = items[s.index].copyWith(
      seconds: items[s.index].seconds + 1,
    );

    final elapsed = s.elapsed + const Duration(seconds: 1);
    state = s.copyWith(items: items, elapsed: elapsed);

    // Zeit abgelaufen: die Simulation endet hart, genau wie im Prüfungsraum.
    if (s.limit != null && elapsed >= s.limit!) {
      finish();
    }
  }

  void setAnswer(Object? answer) {
    final s = state;
    if (s == null || s.finished) return;
    // Nach dem Prüfen ist die Antwort im Übungsmodus eingefroren.
    if (s.current.checked) return;
    final items = [...s.items];
    items[s.index] = items[s.index].copyWith(answer: answer);
    state = s.copyWith(items: items);
  }

  /// Sofortiges Feedback. Im Prüfungsmodus bewusst wirkungslos.
  void check() {
    final s = state;
    if (s == null || s.isExam || s.finished) return;
    final item = s.current;
    if (item.checked || !item.hasAnswer) return;

    final grade = item.question.grade(item.answer);
    final items = [...s.items];
    items[s.index] = item.copyWith(grade: grade, checked: true);
    state = s.copyWith(items: items);

    _ref
        .read(progressProvider.notifier)
        .record(
          AnswerRecord(
            questionId: item.question.id,
            topicId: item.question.topicId,
            score: grade.score,
            seconds: item.seconds,
            at: DateTime.now(),
            mode: s.mode,
          ),
        );
  }

  void toggleFlag() {
    final s = state;
    if (s == null) return;
    final items = [...s.items];
    items[s.index] = items[s.index].copyWith(flagged: !items[s.index].flagged);
    state = s.copyWith(items: items);
  }

  void next() {
    final s = state;
    if (s == null) return;
    if (s.isLast) {
      // Im Kurztest geht es immer weiter - mit einer neuen Aufgabe.
      final q = s.endless
          ? _supply?.call({for (final i in s.items) i.question.id})
          : null;
      if (q == null) return;
      state = s.copyWith(
        items: [
          ...s.items,
          SessionItem(question: q),
        ],
        index: s.index + 1,
      );
      return;
    }
    state = s.copyWith(index: s.index + 1);
  }

  void previous() {
    final s = state;
    if (s == null || s.index == 0) return;
    state = s.copyWith(index: s.index - 1);
  }

  void jumpTo(int i) {
    final s = state;
    if (s == null || i < 0 || i >= s.items.length) return;
    state = s.copyWith(index: i);
  }

  /// Beendet die Session und wertet alles aus, was noch nicht geprüft wurde.
  void finish() {
    final s = state;
    if (s == null || s.finished) return;
    _timer?.cancel();

    final items = <SessionItem>[];
    final records = <AnswerRecord>[];
    final now = DateTime.now();

    for (final item in s.items) {
      if (item.checked) {
        items.add(item);
        continue;
      }
      // Im Kurztest hört man mitten in einer Aufgabe auf - die offene zählt
      // nicht als Fehler, sie fällt einfach weg.
      if (s.endless) continue;
      final grade = item.question.grade(item.answer);
      items.add(item.copyWith(grade: grade, checked: true));
      // Unbeantwortete Aufgaben zählen als Versuch mit 0 Punkten - in der
      // echten Prüfung gibt es für eine leere Zeile auch nichts.
      records.add(
        AnswerRecord(
          questionId: item.question.id,
          topicId: item.question.topicId,
          score: grade.score,
          seconds: item.seconds,
          at: now,
          mode: s.mode,
        ),
      );
    }

    if (records.isNotEmpty) {
      _ref.read(progressProvider.notifier).recordAll(records);
    }
    if (items.isEmpty) {
      // Kurztest ohne eine einzige beantwortete Aufgabe: nichts auszuwerten.
      state = null;
      return;
    }
    state = s.copyWith(items: items, index: 0, finished: true);
  }

  void clear() {
    _timer?.cancel();
    state = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final sessionProvider = StateNotifierProvider<SessionController, SessionState?>(
  (ref) {
    return SessionController(ref);
  },
);
