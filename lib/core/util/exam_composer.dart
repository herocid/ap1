import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../../data/models/exam_area.dart';
import '../../data/models/exam_case.dart';
import '../../data/models/progress.dart';
import '../../data/models/question.dart';
import '../../data/models/topic.dart';
import 'question_selector.dart';

/// Umfang einer Prüfungssimulation.
@immutable
class ExamVariant {
  const ExamVariant({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tasks,
    required this.minutes,
  });

  final String id;
  final String title;
  final String subtitle;

  /// Anzahl der Aufgaben zu je 25 Punkten.
  final int tasks;
  final int minutes;

  int get points => tasks * ExamComposer.pointsPerTask;
  Duration get limit => Duration(minutes: minutes);
}

/// Die echte AP1: 4 Aufgaben, 100 Punkte, 90 Minuten. Die kürzeren
/// Varianten behalten das Verhältnis von knapp einer Minute je Punkt.
const kExamVariants = <ExamVariant>[
  ExamVariant(
    id: 'voll',
    title: 'Volle Prüfung',
    subtitle: 'Wie im Ernstfall: ein Unternehmen, vier Aufgaben.',
    tasks: 4,
    minutes: 90,
  ),
  ExamVariant(
    id: 'halb',
    title: 'Halbe Prüfung',
    subtitle: 'Zwei Aufgaben - gut für einen Abend in der Woche.',
    tasks: 2,
    minutes: 45,
  ),
  ExamVariant(
    id: 'eine',
    title: 'Eine Aufgabe',
    subtitle: 'Eine Aufgabe unter Zeitdruck, um das Tempo zu üben.',
    tasks: 1,
    minutes: 22,
  ),
];

/// Eine der Aufgaben einer Prüfung: eigene Situation, Teilaufgaben a), b) …
@immutable
class ExamTask {
  const ExamTask({
    required this.title,
    required this.situation,
    required this.parts,
    this.areaId,
    this.examCase,
    this.otherCompany,
  });

  final String title;

  /// Einleitung der Aufgabe; leer, wenn es keine Fallaufgabe ist.
  final String situation;
  final List<Question> parts;
  final String? areaId;
  final ExamCase? examCase;

  /// Gesetzt, wenn die Aufgabe für ein anderes Unternehmen geschrieben ist
  /// als das der Prüfung (Auffüllen bei zu wenigen Fällen). Die Ansicht
  /// stellt dieses Unternehmen dann in der Situation kurz vor.
  final ExamCompany? otherCompany;

  int get points => parts.fold(0, (s, q) => s + q.points);
}

/// Ein kompletter Prüfungsbogen.
@immutable
class ExamPaper {
  const ExamPaper({required this.tasks, this.company});

  /// Das durchgängige Unternehmen; `null`, wenn es (noch) keine
  /// Fallaufgaben gibt und gemischte Einzelaufgaben gestellt werden.
  final ExamCompany? company;
  final List<ExamTask> tasks;

  bool get fromCases => company != null;

  List<Question> get questions => [for (final t in tasks) ...t.parts];

  int get points => tasks.fold(0, (s, t) => s + t.points);

  int get partCount => tasks.fold(0, (s, t) => s + t.parts.length);

  /// Index der ersten Teilaufgabe von Aufgabe [task] in [questions].
  int startOf(int task) {
    var start = 0;
    for (var i = 0; i < task; i++) {
      start += tasks[i].parts.length;
    }
    return start;
  }

  /// Zu welcher Aufgabe die Teilaufgabe an Position [index] gehört.
  int taskAt(int index) {
    var start = 0;
    for (var i = 0; i < tasks.length; i++) {
      start += tasks[i].parts.length;
      if (index < start) return i;
    }
    return tasks.length - 1;
  }

  /// Position innerhalb der Aufgabe (0 = a).
  int partAt(int index) => index - startOf(taskAt(index));

  /// „a)“, „b)“ … wie auf dem Prüfungsbogen.
  String partLabel(int index) => '${partLetter(partAt(index))})';

  static String partLetter(int part) =>
      part < 26 ? String.fromCharCode(97 + part) : '${part + 1}';
}

/// Ein Platz im Prüfungsbogen: aus welchen Katalogbereichen die Aufgabe
/// kommen darf und wie stark der Platz in der echten Prüfung wiegt.
@immutable
class ExamSlot {
  const ExamSlot(this.areas, this.weight);
  final List<String> areas;
  final int weight;
}

/// Stellt Prüfungen aus Fallaufgaben zusammen.
///
/// Wie in der AP1 hängen alle Aufgaben an EINEM Unternehmen und stammen aus
/// verschiedenen Katalogbereichen. Die Verteilung folgt der Auswertung der
/// Prüfungen 2025/26 (`docs/pruefungsanalyse`): Bereich 04 rund 38 %,
/// 03 rund 25 %, 06 rund 14 %, der Rest (01, 02, 05, 07) zusammen rund 24 %.
class ExamComposer {
  const ExamComposer._();

  static const pointsPerTask = 25;

  /// Ab so vielen Fallaufgaben besteht die Simulation ausschließlich aus
  /// Fällen. Darunter (Inhalte fehlen noch) gibt es gemischte Einzelaufgaben.
  static const minCases = 4;

  /// Reihenfolge wie auf dem Bogen: erst Organisation/Beschaffung, dann
  /// Systeme und Netze, Sicherheit, zuletzt Entwicklung und Daten.
  static const slots = <ExamSlot>[
    ExamSlot(['a01', 'a02', 'a05', 'a07'], 23),
    ExamSlot(['a03'], 25),
    ExamSlot(['a06'], 14),
    ExamSlot(['a04'], 38),
  ];

  /// Zeitrichtwert: 90 Minuten für 100 Punkte, also 54 Sekunden je Punkt.
  static Duration guideTime(int points) => Duration(seconds: points * 54);

  /// Prüfung aus Fallaufgaben. Nur wenn es weniger als [minCases] Fälle
  /// gibt, werden gemischte Einzelaufgaben gestellt.
  static ExamPaper compose({
    required List<ExamCase> cases,
    required List<Question> pool,
    required int tasks,
    Map<String, DateTime> lastSeen = const {},
    int? seed,
  }) =>
      fromCases(cases: cases, tasks: tasks, lastSeen: lastSeen, seed: seed) ??
      fallback(pool: pool, tasks: tasks, seed: seed);

  /// Wählt ein Unternehmen und dazu [tasks] Fälle aus verschiedenen
  /// Bereichen. `null`, wenn es insgesamt weniger als [minCases] Fälle gibt.
  ///
  /// [lastSeen] (Fall-ID -> zuletzt bearbeitet) sorgt dafür, dass neue und
  /// lange nicht gesehene Fälle zuerst drankommen.
  static ExamPaper? fromCases({
    required List<ExamCase> cases,
    required int tasks,
    Map<String, DateTime> lastSeen = const {},
    int? seed,
  }) {
    final usable = cases.where((c) => c.parts.isNotEmpty).toList();
    if (tasks <= 0 || usable.length < math.max(tasks, minCases)) return null;
    final rnd = math.Random(seed ?? DateTime.now().millisecondsSinceEpoch);

    final wanted = _pickSlots(math.min(tasks, slots.length), rnd);

    // Das Unternehmen, das die meisten Plätze selbst füllen kann - bei
    // Gleichstand das mit den meisten noch nicht gesehenen Fällen.
    final companies = usable.map((c) => c.companyId).toSet().toList()
      ..shuffle(rnd);
    String? best;
    var bestScore = -1;
    for (final id in companies) {
      var filled = 0;
      var fresh = 0;
      for (final slot in wanted) {
        final own = usable.where(
          (c) => c.companyId == id && slot.areas.contains(c.areaId),
        );
        if (own.isEmpty) continue;
        filled++;
        if (own.any((c) => !lastSeen.containsKey(c.id))) fresh++;
      }
      final score = filled * 100 + fresh;
      if (score > bestScore) {
        bestScore = score;
        best = id;
      }
    }
    final companyId = best!;

    final used = <String>{};
    final usedAreas = <String>{};
    final picked = <(int, ExamCase)>[];

    ExamCase? take(Iterable<ExamCase> candidates) {
      final list = candidates.where((c) => !used.contains(c.id)).toList();
      if (list.isEmpty) return null;
      list.shuffle(rnd);
      // Nie gesehen zuerst, sonst der am längsten zurückliegende. Das
      // Mischen davor entscheidet bei Gleichstand.
      final epoch = DateTime.fromMillisecondsSinceEpoch(0);
      list.sort(
        (a, b) => (lastSeen[a.id] ?? epoch).compareTo(lastSeen[b.id] ?? epoch),
      );
      final c = list.first;
      used.add(c.id);
      usedAreas.add(c.areaId);
      return c;
    }

    // 1. Jeden Platz aus dem eigenen Unternehmen füllen, sonst aus einem
    //    anderen - der Bereichsmix geht vor dem Unternehmen.
    final open = <int>[];
    for (final slot in wanted) {
      final i = slots.indexOf(slot);
      final inSlot = usable.where((c) => slot.areas.contains(c.areaId));
      final c =
          take(inSlot.where((c) => c.companyId == companyId)) ?? take(inSlot);
      if (c == null) {
        open.add(i);
      } else {
        picked.add((i, c));
      }
    }

    // 2. Plätze ohne passenden Fall: irgendein noch freier Fall, möglichst
    //    aus einem Bereich, der noch nicht vertreten ist.
    for (final i in [...open, for (var k = picked.length; k < tasks; k++) -1]) {
      if (picked.length >= tasks) break;
      bool own(ExamCase c) => c.companyId == companyId;
      bool newArea(ExamCase c) => !usedAreas.contains(c.areaId);
      final c =
          take(usable.where((c) => own(c) && newArea(c))) ??
          take(usable.where(newArea)) ??
          take(usable.where(own)) ??
          take(usable);
      if (c == null) return null;
      picked.add((i < 0 ? slots.length : i, c));
    }

    picked.sort((a, b) => a.$1.compareTo(b.$1));
    final company = ExamCompanies.byId(companyId);
    return ExamPaper(
      company: company,
      tasks: [
        for (final (_, c) in picked)
          ExamTask(
            title: c.title,
            situation: c.situation,
            parts: c.parts,
            areaId: c.areaId,
            examCase: c,
            otherCompany: c.companyId == companyId ? null : c.company,
          ),
      ],
    );
  }

  /// Gewichtete Auswahl von [n] verschiedenen Plätzen.
  static List<ExamSlot> _pickSlots(int n, math.Random rnd) {
    if (n >= slots.length) return [...slots];
    final rest = [...slots];
    final out = <ExamSlot>[];
    while (out.length < n) {
      final total = rest.fold<int>(0, (s, e) => s + e.weight);
      var r = rnd.nextInt(total);
      for (final s in rest) {
        r -= s.weight;
        if (r < 0) {
          out.add(s);
          rest.remove(s);
          break;
        }
      }
    }
    return out;
  }

  /// Ersatz ohne Fallaufgaben: gemischte Einzelaufgaben nach Punkteanteil
  /// der Themen, je Aufgabe ein Block aus benachbarten Themen. Auch hier
  /// gilt der Formatmix: höchstens rund 30 % Auswahlaufgaben.
  static ExamPaper fallback({
    required List<Question> pool,
    required int tasks,
    int perTask = 8,
    int? seed,
  }) {
    final relevant = pool.where((q) => q.isExamRelevant).toList();
    // Teilaufgaben von Fällen brauchen ihre Situation - hier lieber
    // eigenständige Aufgaben, solange genug da sind.
    final standalone = relevant.where((q) => q.caseId == null).toList();
    final source = standalone.length >= tasks * perTask ? standalone : relevant;
    final count = math.min(tasks * perTask, source.length);
    // Erst großzügig nach Themengewicht ziehen, dann auf den Formatmix
    // eindampfen - so bleiben beide Verteilungen erhalten.
    final candidates = QuestionSelector.forExam(
      pool: source,
      count: math.min(count * 5, source.length),
      seed: seed,
    )..shuffle(math.Random(seed ?? DateTime.now().millisecondsSinceEpoch));
    final picked = QuestionSelector.mixFormats(candidates, count: count);
    int areaOrder(Question q) =>
        ExamAreas.all.indexWhere((a) => a.id == Topics.byId(q.topicId).areaId);
    picked.sort((a, b) {
      final byArea = areaOrder(a).compareTo(areaOrder(b));
      return byArea != 0 ? byArea : a.topicId.compareTo(b.topicId);
    });

    final n = math.max(1, math.min(tasks, picked.length));
    final out = <ExamTask>[];
    for (var i = 0; i < n; i++) {
      final from = (picked.length * i / n).round();
      final to = (picked.length * (i + 1) / n).round();
      final parts = picked.sublist(from, to);
      if (parts.isEmpty) continue;
      // Titel nach dem Bereich, der in diesem Block am häufigsten vorkommt.
      final count = <String, int>{};
      for (final q in parts) {
        final a = Topics.byId(q.topicId).areaId;
        count[a] = (count[a] ?? 0) + 1;
      }
      final top = count.entries.reduce((a, b) => b.value > a.value ? b : a).key;
      out.add(
        ExamTask(
          title: count.length == 1
              ? ExamAreas.byId(top).title
              : 'Schwerpunkt ${ExamAreas.byId(top).title}',
          situation: '',
          parts: parts,
          areaId: top,
        ),
      );
    }
    return ExamPaper(tasks: out);
  }

  /// Die „Prüfungsaufgabe des Tages“: immer eine Fallaufgabe, für alle am
  /// selben Tag dieselbe. `null`, solange es keine Fälle gibt.
  ///
  /// Die Fälle rotieren in einer festen, aus den IDs abgeleiteten
  /// Reihenfolge - ohne Zufallsgenerator, damit Handy und Web dasselbe
  /// zeigen.
  static ExamPaper? daily({
    required List<ExamCase> cases,
    required DateTime day,
  }) {
    final n = dayNumber(day);
    final usable = cases.where((c) => c.parts.isNotEmpty).toList();
    if (usable.isEmpty) return null;
    usable.sort((a, b) {
      final h = _hash(a.id).compareTo(_hash(b.id));
      return h != 0 ? h : a.id.compareTo(b.id);
    });
    final c = usable[n % usable.length];
    return ExamPaper(
      company: c.company,
      tasks: [
        ExamTask(
          title: c.title,
          situation: c.situation,
          parts: c.parts,
          areaId: c.areaId,
          examCase: c,
        ),
      ],
    );
  }

  /// Fortlaufende Nummer des Kalendertags (Ortszeit).
  static int dayNumber(DateTime day) =>
      DateTime.utc(day.year, day.month, day.day).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;

  static int _hash(String s) {
    var h = 7;
    for (final c in s.codeUnits) {
      h = (h * 31 + c) % 1000003;
    }
    return h;
  }

  /// Wann welcher Fall zuletzt bearbeitet wurde - abgeleitet aus der
  /// Antwort-Historie, es braucht dafür keinen eigenen Speicher.
  static Map<String, DateTime> lastSeenByCase(
    List<ExamCase> cases,
    List<AnswerRecord> history,
  ) {
    final caseOf = <String, String>{
      for (final c in cases)
        for (final q in c.parts) q.id: c.id,
    };
    final out = <String, DateTime>{};
    for (final r in history) {
      final id = caseOf[r.questionId];
      if (id == null) continue;
      final prev = out[id];
      if (prev == null || r.at.isAfter(prev)) out[id] = r.at;
    }
    return out;
  }
}
