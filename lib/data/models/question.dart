import 'package:flutter/foundation.dart';

import 'netzplan.dart';

/// Aufgabentypen des Trainers.
///
/// Bewusst mehr als nur Multiple Choice: die AP1 prueft Rechnen (Netzplan,
/// Nutzwertanalyse), Zuordnen (Lastenheft vs. Pflichtenheft) und Reihenfolgen
/// (Phasen, Scrum-Events). Wer nur MC uebt, faellt im Ernstfall genau ueber
/// diese Aufgaben.
enum QuestionKind {
  single('Einfachauswahl'),
  multiple('Mehrfachauswahl'),
  numeric('Rechenaufgabe'),
  ordering('Reihenfolge'),
  matching('Zuordnung'),
  netzplan('Netzplan');

  const QuestionKind(this.label);
  final String label;

  static QuestionKind parse(String s) =>
      QuestionKind.values.firstWhere((k) => k.name == s,
          orElse: () => QuestionKind.single);
}

/// Ergebnis einer Bewertung. [parts] traegt die Detailrueckmeldung, damit die
/// UI jede Option/Zelle einzeln einfaerben kann.
@immutable
class GradeResult {
  const GradeResult({
    required this.score,
    required this.parts,
  });

  /// 0.0 .. 1.0 - Teilpunkte sind ausdruecklich vorgesehen.
  final double score;

  /// Schluessel je nach Aufgabentyp: Option-Index, Item-Index oder "A.faz".
  final Map<String, bool> parts;

  bool get isCorrect => score >= 0.9999;
  bool get isPartial => score > 0 && !isCorrect;

  static const empty = GradeResult(score: 0, parts: {});
}

@immutable
class Choice {
  const Choice({
    required this.text,
    required this.isCorrect,
    required this.rationale,
  });

  final String text;
  final bool isCorrect;

  /// Der eigentliche Lerneffekt: warum genau diese Option richtig bzw. falsch
  /// ist. Wird nach dem Antworten *an jeder* Option angezeigt, nicht nur an
  /// der richtigen.
  final String rationale;

  factory Choice.fromJson(Map<String, dynamic> j) => Choice(
        text: j['text'] as String,
        isCorrect: j['is_correct'] as bool? ?? false,
        rationale: (j['rationale'] ?? '') as String,
      );

  Map<String, dynamic> toJson() =>
      {'text': text, 'is_correct': isCorrect, 'rationale': rationale};
}

/// Ein Zuordnungs-Item ("Die Anforderung X gehoert ins ...").
@immutable
class MatchItem {
  const MatchItem({
    required this.text,
    required this.bucket,
    this.rationale = '',
  });

  final String text;
  final int bucket;
  final String rationale;

  factory MatchItem.fromJson(Map<String, dynamic> j) => MatchItem(
        text: j['text'] as String,
        bucket: (j['bucket'] as num).toInt(),
        rationale: (j['rationale'] ?? '') as String,
      );

  Map<String, dynamic> toJson() =>
      {'text': text, 'bucket': bucket, 'rationale': rationale};
}

@immutable
class Question {
  const Question({
    required this.id,
    required this.topicId,
    required this.kind,
    required this.prompt,
    required this.explanation,
    this.scenario,
    this.difficulty = 2,
    this.tags = const [],
    this.choices = const [],
    this.numericAnswer,
    this.numericTolerance = 0,
    this.unit,
    this.orderedItems = const [],
    this.orderingHint,
    this.buckets = const [],
    this.matchItems = const [],
    this.activities = const [],
    this.askedFields = const [],
    this.source,
  });

  final String id;
  final String topicId;
  final QuestionKind kind;

  /// Optionaler Fallbeispiel-Kontext, der ueber der Frage steht. In der AP1
  /// haengen mehrere Aufgaben an einer Situationsbeschreibung.
  final String? scenario;
  final String prompt;

  /// Die Gesamterklaerung nach dem Antworten (Rechenweg, Merksatz, Abgrenzung).
  final String explanation;

  /// 1 = Grundlagen, 2 = Pruefungsniveau, 3 = anspruchsvoll.
  final int difficulty;
  final List<String> tags;
  final String? source;

  // single / multiple
  final List<Choice> choices;

  // numeric
  final double? numericAnswer;
  final double numericTolerance;
  final String? unit;

  // ordering: in *korrekter* Reihenfolge abgelegt
  final List<String> orderedItems;
  final String? orderingHint;

  // matching
  final List<String> buckets;
  final List<MatchItem> matchItems;

  // netzplan
  final List<Activity> activities;
  final List<NodeField> askedFields;

  /// Geschaetzte Bearbeitungszeit - Grundlage fuer das Zeitbudget im
  /// Pruefungsmodus.
  int get estimatedSeconds => switch (kind) {
        QuestionKind.single => 55,
        QuestionKind.multiple => 80,
        QuestionKind.numeric => 110,
        QuestionKind.ordering => 75,
        QuestionKind.matching => 95,
        QuestionKind.netzplan => 60 + activities.length * 35,
      };

  /// Punkte, wie sie die IHK vergeben wuerde - skaliert mit Aufwand.
  int get points => switch (kind) {
        QuestionKind.single => 2,
        QuestionKind.multiple => 3,
        QuestionKind.numeric => 3,
        QuestionKind.ordering => 3,
        QuestionKind.matching => 4,
        QuestionKind.netzplan => 6,
      };

  NetzplanSolution? get netzplanSolution =>
      activities.isEmpty ? null : NetzplanSolver.solve(activities);

  /// Bewertet eine Antwort. [answer] ist typabhaengig:
  /// - single/multiple: `Set<int>` der gewaehlten Indizes
  /// - numeric: `double`
  /// - ordering: `List<int>` der Original-Indizes in Nutzerreihenfolge
  /// - matching: `Map<int, int>` Item-Index -> Bucket-Index
  /// - netzplan: `Map<String, int>` "A.faz" -> Wert
  GradeResult grade(Object? answer) {
    switch (kind) {
      case QuestionKind.single:
      case QuestionKind.multiple:
        final selected = (answer as Set<int>?) ?? const <int>{};
        final parts = <String, bool>{};
        var hits = 0;
        var falseHits = 0;
        final totalCorrect = choices.where((c) => c.isCorrect).length;
        for (var i = 0; i < choices.length; i++) {
          final chosen = selected.contains(i);
          final shouldChoose = choices[i].isCorrect;
          parts['$i'] = chosen == shouldChoose;
          if (chosen && shouldChoose) hits++;
          if (chosen && !shouldChoose) falseHits++;
        }
        if (totalCorrect == 0) return GradeResult(score: 0, parts: parts);
        // Falsch angekreuzte Optionen ziehen ab - sonst waere "alles ankreuzen"
        // eine Gewinnstrategie.
        final raw = (hits - falseHits) / totalCorrect;
        return GradeResult(score: raw.clamp(0.0, 1.0), parts: parts);

      case QuestionKind.numeric:
        final v = answer as num?;
        if (v == null || numericAnswer == null) {
          return const GradeResult(score: 0, parts: {'value': false});
        }
        final ok = (v - numericAnswer!).abs() <= numericTolerance + 1e-9;
        return GradeResult(score: ok ? 1 : 0, parts: {'value': ok});

      case QuestionKind.ordering:
        final order = (answer as List<int>?) ?? const <int>[];
        if (order.length != orderedItems.length) {
          return const GradeResult(score: 0, parts: {});
        }
        final parts = <String, bool>{
          for (var pos = 0; pos < order.length; pos++)
            '${order[pos]}': order[pos] == pos,
        };
        // Paarweise Reihenfolge statt exakter Positionen: wer nur zwei Elemente
        // vertauscht, verliert nicht alles.
        var okPairs = 0;
        var pairs = 0;
        for (var i = 0; i < order.length; i++) {
          for (var j = i + 1; j < order.length; j++) {
            pairs++;
            if (order[i] < order[j]) okPairs++;
          }
        }
        final score = pairs == 0 ? 1.0 : okPairs / pairs;
        // Nur die perfekte Reihenfolge gilt als "richtig"; darunter Teilpunkte.
        return GradeResult(
          score: score >= 0.9999 ? 1.0 : score * 0.9,
          parts: parts,
        );

      case QuestionKind.matching:
        final map = (answer as Map<int, int>?) ?? const <int, int>{};
        final parts = <String, bool>{};
        var hits = 0;
        for (var i = 0; i < matchItems.length; i++) {
          final ok = map[i] == matchItems[i].bucket;
          parts['$i'] = ok;
          if (ok) hits++;
        }
        return GradeResult(
          score: matchItems.isEmpty ? 0 : hits / matchItems.length,
          parts: parts,
        );

      case QuestionKind.netzplan:
        final map = (answer as Map<String, int>?) ?? const <String, int>{};
        final sol = netzplanSolution;
        if (sol == null) return const GradeResult(score: 0, parts: {});
        final parts = <String, bool>{};
        var hits = 0;
        var total = 0;
        for (final a in activities) {
          for (final f in askedFields) {
            final key = '${a.id}.${f.name}';
            total++;
            final ok = map[key] == sol.nodes[a.id]!.value(f);
            parts[key] = ok;
            if (ok) hits++;
          }
        }
        return GradeResult(
          score: total == 0 ? 0 : hits / total,
          parts: parts,
        );
    }
  }

  factory Question.fromJson(Map<String, dynamic> j) {
    final data = (j['data'] as Map?)?.cast<String, dynamic>() ?? const {};
    return Question(
      id: j['id'].toString(),
      topicId: j['topic_id'] as String,
      kind: QuestionKind.parse(j['kind'] as String),
      scenario: j['scenario'] as String?,
      prompt: j['prompt'] as String,
      explanation: (j['explanation'] ?? '') as String,
      difficulty: (j['difficulty'] as num?)?.toInt() ?? 2,
      tags: ((j['tags'] as List?) ?? const []).cast<String>().toList(),
      source: j['source'] as String?,
      choices: ((data['choices'] as List?) ?? const [])
          .map((e) => Choice.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      numericAnswer: (data['answer'] as num?)?.toDouble(),
      numericTolerance: (data['tolerance'] as num?)?.toDouble() ?? 0,
      unit: data['unit'] as String?,
      orderedItems:
          ((data['ordered_items'] as List?) ?? const []).cast<String>().toList(),
      orderingHint: data['ordering_hint'] as String?,
      buckets: ((data['buckets'] as List?) ?? const []).cast<String>().toList(),
      matchItems: ((data['match_items'] as List?) ?? const [])
          .map((e) => MatchItem.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      activities: ((data['activities'] as List?) ?? const [])
          .map((e) => Activity.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      askedFields: ((data['asked_fields'] as List?) ?? const [])
          .cast<String>()
          .map((s) => NodeField.values.firstWhere((f) => f.name == s,
              orElse: () => NodeField.faz))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic_id': topicId,
        'kind': kind.name,
        'scenario': scenario,
        'prompt': prompt,
        'explanation': explanation,
        'difficulty': difficulty,
        'tags': tags,
        'source': source,
        'data': {
          if (choices.isNotEmpty)
            'choices': choices.map((c) => c.toJson()).toList(),
          if (numericAnswer != null) 'answer': numericAnswer,
          if (numericAnswer != null) 'tolerance': numericTolerance,
          if (unit != null) 'unit': unit,
          if (orderedItems.isNotEmpty) 'ordered_items': orderedItems,
          if (orderingHint != null) 'ordering_hint': orderingHint,
          if (buckets.isNotEmpty) 'buckets': buckets,
          if (matchItems.isNotEmpty)
            'match_items': matchItems.map((m) => m.toJson()).toList(),
          if (activities.isNotEmpty)
            'activities': activities.map((a) => a.toJson()).toList(),
          if (askedFields.isNotEmpty)
            'asked_fields': askedFields.map((f) => f.name).toList(),
        },
      };
}
