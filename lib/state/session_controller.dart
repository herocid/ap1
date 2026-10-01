import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/util/answer_format.dart';
import '../core/util/exam_composer.dart';
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
    this.recorded = false,
    this.retry = false,
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

  /// Schon in die Statistik gebucht. Freitext-Aufgaben werden erst beim
  /// Weitergehen gebucht, weil die Selbstbewertung die Punkte noch ändert.
  final bool recorded;

  /// Zweiter Anlauf in derselben Runde (Fehler-Wiederholung).
  final bool retry;

  bool get isOpen => question.kind == QuestionKind.open;

  bool get hasAnswer {
    final a = answer;
    if (a == null) return false;
    if (a is OpenAnswer) return a.text.trim().isNotEmpty || a.checked != null;
    if (a is Set) return a.isNotEmpty;
    if (a is Map) {
      return a.values.any((v) => v is! String || v.trim().isNotEmpty);
    }
    if (a is List) return a.isNotEmpty;
    return true;
  }

  /// Erreichte Punkte dieser Aufgabe, auf halbe Punkte gerundet.
  double get earned => halfPoints((grade?.score ?? 0) * question.points);

  SessionItem copyWith({
    Object? answer,
    bool clearAnswer = false,
    GradeResult? grade,
    bool? checked,
    int? seconds,
    bool? flagged,
    bool? recorded,
  }) => SessionItem(
    question: question,
    answer: clearAnswer ? null : (answer ?? this.answer),
    grade: grade ?? this.grade,
    checked: checked ?? this.checked,
    seconds: seconds ?? this.seconds,
    flagged: flagged ?? this.flagged,
    recorded: recorded ?? this.recorded,
    retry: retry,
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
    this.paper,
    this.begun = true,
    this.reviewing = false,
    this.timedOut = false,
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

  /// Prüfungsbogen mit Aufgaben und Teilaufgaben (Simulation und
  /// Prüfungsaufgabe des Tages). [items] sind dann dessen Teilaufgaben in
  /// Bogenreihenfolge.
  final ExamPaper? paper;

  /// Die Zeit läuft. Bei der Simulation erst nach dem Deckblatt.
  final bool begun;

  /// Abgegeben, aber noch nicht ausgewertet: Die Freitext-Antworten werden
  /// gerade anhand der Musterlösung selbst bewertet.
  final bool reviewing;

  /// Die Abgabe kam durch den Ablauf der Zeit zustande.
  final bool timedOut;

  SessionItem get current => items[index];
  bool get isLast => index >= items.length - 1;
  bool get isExam => mode == SessionMode.pruefung;

  /// Rückmeldung erst nach der Abgabe (Simulation und Aufgabe des Tages).
  bool get deferredFeedback => isExam || paper != null;

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

  /// Anteil der erreichten Punkte (0..1).
  double get totalScore {
    final possible = possiblePoints;
    return possible == 0 ? 0 : earnedPoints / possible;
  }

  /// Summe der auf halbe Punkte gerundeten Teilergebnisse.
  double get earnedPoints => items.fold<double>(0, (s, i) => s + i.earned);

  int get possiblePoints => items.fold<int>(0, (s, i) => s + i.question.points);

  /// Positionen der Freitext-Aufgaben - die Stationen der Selbstbewertung.
  List<int> get openIndices => [
    for (var i = 0; i < items.length; i++)
      if (items[i].isOpen) i,
  ];

  SessionState copyWith({
    List<SessionItem>? items,
    int? index,
    Duration? elapsed,
    bool? finished,
    bool? begun,
    bool? reviewing,
    bool? timedOut,
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
    paper: paper,
    begun: begun ?? this.begun,
    reviewing: reviewing ?? this.reviewing,
    timedOut: timedOut ?? this.timedOut,
  );
}

/// Steuert eine laufende Lern- oder Prüfungssession.
///
/// Der Unterschied zwischen Übung und Prüfung steckt in wenigen Stellen:
/// [check] ist bei [SessionState.deferredFeedback] gesperrt, die Bewertung
/// passiert erst in [finish] - und Freitext-Antworten werden davor in einem
/// eigenen Schritt selbst bewertet ([SessionState.reviewing]).
class SessionController extends StateNotifier<SessionState?> {
  SessionController(this._ref) : super(null);

  final Ref _ref;
  Timer? _timer;

  /// Liefert im Kurztest die nächste Aufgabe. Bekommt die Aufgaben, die in
  /// dieser Runde schon dran waren - damit sich nichts zu früh wiederholt
  /// und der Formatmix stimmt.
  Question? Function(List<Question> asked)? _supply;

  /// Falsch beantwortete Aufgaben kommen in derselben Runde noch einmal -
  /// mit ein paar anderen Aufgaben Abstand.
  bool _requeueWrong = false;

  /// So viele andere Aufgaben liegen zwischen Fehler und zweitem Anlauf.
  static const requeueGap = 3;

  void start({
    required List<Question> questions,
    required SessionMode mode,
    Duration? limit,
    String? topicFilter,
    String title = 'Übung',
    Question? Function(List<Question> asked)? supply,
    bool requeueWrong = false,
    ExamPaper? paper,
    bool begun = true,
  }) {
    _timer?.cancel();
    _supply = supply;
    _requeueWrong = requeueWrong;
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
      paper: paper,
      begun: begun,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  /// Startet einen Prüfungsbogen. Mit [cover] steht zuerst das Deckblatt
  /// mit der Ausgangssituation - die Zeit läuft erst ab [begin].
  void startPaper({
    required ExamPaper paper,
    required SessionMode mode,
    required String title,
    Duration? limit,
    bool cover = true,
  }) => start(
    questions: paper.questions,
    mode: mode,
    limit: limit,
    title: title,
    paper: paper,
    begun: !cover,
  );

  /// Deckblatt gelesen - die Zeit läuft.
  void begin() {
    final s = state;
    if (s == null || s.begun) return;
    state = s.copyWith(begun: true);
  }

  void _tick() {
    final s = state;
    if (s == null || s.finished || s.reviewing || !s.begun) return;

    final items = [...s.items];
    items[s.index] = items[s.index].copyWith(
      seconds: items[s.index].seconds + 1,
    );

    final elapsed = s.elapsed + const Duration(seconds: 1);
    state = s.copyWith(items: items, elapsed: elapsed);

    // Zeit abgelaufen: die Simulation endet hart, genau wie im Prüfungsraum.
    if (s.limit != null && elapsed >= s.limit!) {
      state = state!.copyWith(timedOut: true);
      finish();
    }
  }

  /// Setzt die Antwort der aktuellen Aufgabe.
  ///
  /// Nach dem Prüfen ist die Antwort eingefroren - außer bei Freitext: Dort
  /// hakt man die Bewertungskriterien erst ab, wenn die Musterlösung zu
  /// sehen ist. Die Aufgabe wird dann neu bewertet.
  void setAnswer(Object? answer) {
    final s = state;
    if (s == null || s.finished) return;
    if (s.current.checked) {
      regradeAt(s.index, answer);
      return;
    }
    final items = [...s.items];
    items[s.index] = items[s.index].copyWith(answer: answer);
    state = s.copyWith(items: items);
  }

  /// Bewertet eine schon geprüfte Freitext-Aufgabe neu (Selbstbewertung per
  /// Kriterien-Haken). Funktioniert während der Runde, im Schritt
  /// „Freitext selbst bewerten“ und in der Auswertung.
  ///
  /// In der Auswertung ändert sich nur noch die Anzeige: Die Statistik ist
  /// zu dem Zeitpunkt schon gebucht und wird nicht nachträglich umgeschrieben.
  void regradeAt(int index, Object? answer) {
    final s = state;
    if (s == null || index < 0 || index >= s.items.length) return;
    final item = s.items[index];
    if (!item.checked || !item.isOpen || answer is! OpenAnswer) return;
    final items = [...s.items];
    items[index] = item.copyWith(
      answer: answer,
      grade: item.question.grade(answer),
    );
    state = s.copyWith(items: items);
  }

  /// Sofortiges Feedback. Im Prüfungsmodus bewusst wirkungslos.
  void check() {
    final s = state;
    if (s == null || s.deferredFeedback || s.finished) return;
    final item = s.current;
    if (item.checked) return;
    // Freitext darf man auch „im Kopf“ lösen und dann die Musterlösung
    // aufdecken - alles andere braucht eine Antwort.
    if (!item.hasAnswer && !item.isOpen) return;

    final answer = item.answer ?? (item.isOpen ? const OpenAnswer() : null);
    final grade = item.question.grade(answer);
    final items = [...s.items];
    items[s.index] = item.copyWith(
      answer: answer,
      grade: grade,
      checked: true,
      recorded: !item.isOpen,
    );

    // Fehler-Wiederholung: Die Aufgabe kommt nach ein paar anderen noch
    // einmal - aber nur ein Mal und nur, wenn noch genug Abstand möglich ist.
    if (_requeueWrong && !grade.isCorrect && !item.retry && !item.isOpen) {
      _requeue(items, s.index);
    }
    state = s.copyWith(items: items);

    if (!item.isOpen) {
      _ref
          .read(progressProvider.notifier)
          .record(_record(item, grade.score, s.mode, DateTime.now()));
    }
  }

  void _requeue(List<SessionItem> items, int index) {
    final following = items.length - 1 - index;
    // Direkt danach wäre nur Kurzzeitgedächtnis.
    if (following < 2) return;
    final at = index + 1 + (following < requeueGap ? following : requeueGap);
    items.insert(at, SessionItem(question: items[index].question, retry: true));
  }

  AnswerRecord _record(
    SessionItem item,
    double score,
    SessionMode mode,
    DateTime at,
  ) => AnswerRecord(
    questionId: item.question.id,
    topicId: item.question.topicId,
    score: score,
    seconds: item.seconds,
    at: at,
    mode: mode,
  );

  /// Bucht geprüfte, aber noch nicht gebuchte Aufgaben (Freitext nach der
  /// Selbstbewertung).
  void _flushPending() {
    final s = state;
    if (s == null || s.deferredFeedback || s.finished) return;
    final items = [...s.items];
    final now = DateTime.now();
    final records = <AnswerRecord>[];
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (!item.checked || item.recorded) continue;
      final grade = item.grade!;
      records.add(_record(item, grade.score, s.mode, now));
      items[i] = item.copyWith(recorded: true);
      if (_requeueWrong && !grade.isCorrect && !item.retry) {
        _requeue(items, i);
      }
    }
    if (records.isEmpty) return;
    state = s.copyWith(items: items);
    final progress = _ref.read(progressProvider.notifier);
    for (final r in records) {
      progress.record(r);
    }
  }

  void toggleFlag() {
    final s = state;
    if (s == null || s.finished || s.reviewing) return;
    final items = [...s.items];
    items[s.index] = items[s.index].copyWith(flagged: !items[s.index].flagged);
    state = s.copyWith(items: items);
  }

  void next() {
    _flushPending();
    final s = state;
    if (s == null) return;
    if (s.reviewing) {
      final later = s.openIndices.where((i) => i > s.index);
      if (later.isNotEmpty) state = s.copyWith(index: later.first);
      return;
    }
    if (s.isLast) {
      // Im Kurztest geht es immer weiter - mit einer neuen Aufgabe.
      final q = s.endless
          ? _supply?.call([for (final i in s.items) i.question])
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
    if (s == null) return;
    if (s.reviewing) {
      final earlier = s.openIndices.where((i) => i < s.index);
      if (earlier.isNotEmpty) state = s.copyWith(index: earlier.last);
      return;
    }
    if (s.index == 0) return;
    state = s.copyWith(index: s.index - 1);
  }

  void jumpTo(int i) {
    final s = state;
    if (s == null || i < 0 || i >= s.items.length) return;
    state = s.copyWith(index: i);
  }

  /// Beendet die Session und wertet alles aus, was noch nicht geprüft wurde.
  ///
  /// Bei einem Prüfungsbogen mit Freitext-Aufgaben ist das zweistufig: Der
  /// erste Aufruf gibt ab und öffnet die Selbstbewertung
  /// ([SessionState.reviewing]), der zweite schließt sie ab und bucht das
  /// Ergebnis.
  void finish() {
    _flushPending();
    final s = state;
    if (s == null || s.finished) return;
    _timer?.cancel();

    if (s.deferredFeedback && !s.reviewing) {
      // Abgabe: alles bewerten. Bei Freitext ist das zunächst der Vorschlag
      // der Stichworterkennung - der Prüfling korrigiert ihn gleich selbst.
      final graded = [
        for (final item in s.items)
          item.checked
              ? item
              : item.copyWith(
                  answer:
                      item.answer ?? (item.isOpen ? const OpenAnswer() : null),
                  grade: item.question.grade(item.answer),
                  checked: true,
                ),
      ];
      final open = [
        for (var i = 0; i < graded.length; i++)
          if (graded[i].isOpen) i,
      ];
      if (open.isNotEmpty) {
        state = s.copyWith(items: graded, index: open.first, reviewing: true);
        return;
      }
      _finalize(s.copyWith(items: graded));
      return;
    }
    _finalize(s);
  }

  /// Selbstbewertung abgeschlossen - Ergebnis buchen und anzeigen.
  void completeReview() {
    final s = state;
    if (s == null || !s.reviewing) return;
    finish();
  }

  void _finalize(SessionState s) {
    final items = <SessionItem>[];
    final records = <AnswerRecord>[];
    // Ein Zeitstempel für alle: Daran erkennt die Statistik einen
    // zusammengehörigen Simulationslauf.
    final now = DateTime.now();

    for (final item in s.items) {
      if (item.checked && item.recorded) {
        items.add(item);
        continue;
      }
      // Im Kurztest hört man mitten in einer Aufgabe auf - die offene zählt
      // nicht als Fehler, sie fällt einfach weg.
      if (!item.checked && s.endless) continue;
      final grade = item.grade ?? item.question.grade(item.answer);
      items.add(item.copyWith(grade: grade, checked: true, recorded: true));
      // Unbeantwortete Aufgaben zählen als Versuch mit 0 Punkten - in der
      // echten Prüfung gibt es für eine leere Zeile auch nichts.
      records.add(_record(item, grade.score, s.mode, now));
    }

    if (records.isNotEmpty) {
      _ref.read(progressProvider.notifier).recordAll(records);
    }
    if (items.isEmpty) {
      // Kurztest ohne eine einzige beantwortete Aufgabe: nichts auszuwerten.
      state = null;
      return;
    }
    state = SessionState(
      mode: s.mode,
      items: items,
      index: 0,
      startedAt: s.startedAt,
      limit: s.limit,
      elapsed: s.elapsed,
      finished: true,
      topicFilter: s.topicFilter,
      title: s.title,
      endless: s.endless,
      badgesBefore: s.badgesBefore,
      paper: s.paper,
      timedOut: s.timedOut,
    );
  }

  /// Verwirft die Session. In der Übung bleibt gebucht, was geprüft wurde;
  /// ein abgebrochener Prüfungsbogen wird nicht gewertet.
  void clear() {
    _flushPending();
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
