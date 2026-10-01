import 'package:flutter/foundation.dart';

import 'diagram.dart';
import 'netzplan.dart';
import 'question_parts.dart';

export 'question_parts.dart';

/// Aufgabentypen des Trainers.
///
/// Bewusst mehr als nur Multiple Choice: Die AP1 besteht aus ungebundenen
/// Aufgaben - rechnen, Tabellen ausfüllen, Pseudocode ergänzen, erläutern.
/// Wer nur ankreuzt, fällt im Ernstfall genau über diese Aufgaben.
enum QuestionKind {
  single('Einfachauswahl'),
  multiple('Mehrfachauswahl'),
  numeric('Rechenaufgabe'),
  ordering('Reihenfolge'),
  matching('Zuordnung'),
  netzplan('Netzplan'),

  /// Text mit Lücken: Dropdown, Wortbank oder Eingabe (siehe [Blank]).
  cloze('Lückentext'),

  /// Tabelle, in der einzelne Zellen auszufüllen sind.
  table('Tabelle ausfüllen'),

  /// Freitext wie in der IHK-Prüfung: Antwort schreiben, mit der
  /// Musterlösung vergleichen, Bewertungskriterien abhaken.
  open('Freitext'),

  /// Zeilen oder Elemente antippen, die eine Bedingung erfüllen
  /// (fehlerhafte Codezeilen, personenbezogene Daten ...).
  marking('Markieren'),

  /// Linke und rechte Begriffe zu Paaren verbinden.
  pairs('Paare finden');

  const QuestionKind(this.label);
  final String label;

  static QuestionKind parse(String s) => QuestionKind.values.firstWhere(
    (k) => k.name == s,
    orElse: () => QuestionKind.single,
  );
}

/// Stand einer Aufgabe im Prüfungskatalog.
///
/// Der Katalog 2025 hat Themen gestrichen (Vorgehensmodelle außer Wasserfall
/// und Scrum, SQL, RAID, Struktogramm/PAP, Vererbung, SWOT, ISO-Normen ...).
/// Solche Aufgaben werden nicht gelöscht - sie bleiben als Nachschlagewerk
/// erhalten, fliegen aber aus jeder Auswahl und aus der Prüfungsreife.
enum CatalogStatus {
  /// Im Katalog ab 2025 enthalten.
  current,

  /// Ab 2025 nicht mehr Teil der AP1.
  removed2025;

  static CatalogStatus parse(String? s) => CatalogStatus.values.firstWhere(
    (e) => e.name == s,
    orElse: () => CatalogStatus.current,
  );
}

/// Ergebnis einer Bewertung. [parts] trägt die Detailrückmeldung, damit die
/// UI jede Option/Zelle einzeln einfärben kann.
@immutable
class GradeResult {
  const GradeResult({required this.score, required this.parts});

  /// 0.0 .. 1.0 - Teilpunkte sind ausdrücklich vorgesehen.
  final double score;

  /// Schlüssel je nach Aufgabentyp: Option-Index, Item-Index oder "A.faz".
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

  Map<String, dynamic> toJson() => {
    'text': text,
    'is_correct': isCorrect,
    'rationale': rationale,
  };
}

/// Ein Zuordnungs-Item ("Die Anforderung X gehört ins ...").
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

  Map<String, dynamic> toJson() => {
    'text': text,
    'bucket': bucket,
    'rationale': rationale,
  };
}

@immutable
class Question {
  const Question({
    required this.id,
    required this.topicId,
    required this.kind,
    required this.prompt,
    required this.explanation,
    this.subtopicId,
    this.scenario,
    this.diagram,
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
    this.catalogStatus = CatalogStatus.current,
    this.table,
    this.code,
    this.caseId,
    this.pointsOverride,
    this.clozeText,
    this.gaps = const [],
    this.wordBank = const [],
    this.grid = const [],
    this.criteria = const [],
    this.sampleSolution,
    this.mono = false,
    this.pairs = const [],
  });

  final String id;
  final String topicId;

  /// Lektion der Learning Journey, deren Wissenscheck diese Aufgabe ist.
  final String? subtopicId;
  final QuestionKind kind;

  /// Optionaler Fallbeispiel-Kontext, der über der Frage steht. In der AP1
  /// hängen mehrere Aufgaben an einer Situationsbeschreibung.
  final String? scenario;

  /// Zeichnung zur Aufgabe (z. B. ein Klassendiagramm, das gelesen werden
  /// muss). Steht zwischen Situation und Frage.
  final Diagram? diagram;
  final String prompt;

  /// Die Gesamterklärung nach dem Antworten (Rechenweg, Merksatz, Abgrenzung).
  final String explanation;

  /// 1 = Grundlagen, 2 = Prüfungsniveau, 3 = anspruchsvoll.
  final int difficulty;
  final List<String> tags;
  final String? source;

  /// Ob die Aufgabe nach dem Katalog 2025 noch drankommen kann.
  final CatalogStatus catalogStatus;

  bool get isExamRelevant => catalogStatus == CatalogStatus.current;

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

  // ---- Material, das zu jeder Aufgabenart gehören kann (wie die Anlagen
  // einer IHK-Aufgabe). Steht zwischen Situation und Frage.

  /// Gegebene Tabelle: erste Zeile = Spaltenköpfe, alle Zeilen gleich lang.
  final List<List<String>>? table;

  /// Gegebener Pseudocode, Konfigurationsauszug, Log oder englischer
  /// Handbuchtext - wird in Festbreitenschrift gesetzt.
  final String? code;

  /// Fallaufgabe (`ExamCase`), zu der diese Teilaufgabe gehört. Die App
  /// zeigt dann deren Ausgangssituation über der Aufgabe.
  final String? caseId;

  /// Punkte wie im Lösungsbogen der IHK; ohne Angabe gilt der Standard der
  /// Aufgabenart.
  final int? pointsOverride;

  // cloze
  /// Text mit Platzhaltern `{0}`, `{1}` ... für die [gaps]. Zeilenumbrüche
  /// bleiben erhalten; mit [mono] wird er als Code gesetzt.
  final String? clozeText;
  final List<Blank> gaps;

  /// Zusätzliche falsche Begriffe für die Wortbank. Ist die Liste gefüllt
  /// (oder haben die Lücken keine [Blank.options] und [wordBank] ist nicht
  /// leer), tippt man Begriffe an, statt zu schreiben.
  final List<String> wordBank;

  // table
  /// Zeilen der Tabelle; die erste Zeile sind die Spaltenköpfe.
  final List<List<GridCell>> grid;

  // open
  final List<Criterion> criteria;

  /// Ausformulierte Musterlösung, wie sie im Lösungsbogen stünde.
  final String? sampleSolution;

  // marking: nutzt [choices] (isCorrect = gehört markiert). cloze/marking:
  /// Zeilen in Festbreitenschrift setzen (Code, Logs, Konfiguration).
  final bool mono;

  // pairs
  final List<PairItem> pairs;

  /// Alle auszufüllenden Zellen der Tabelle als "zeile.spalte" -> Lücke.
  Map<String, Blank> get gridGaps => {
    for (var r = 0; r < grid.length; r++)
      for (var c = 0; c < grid[r].length; c++)
        if (grid[r][c].isGap) '$r.$c': grid[r][c].gap!,
  };

  /// Geschätzte Bearbeitungszeit - Grundlage für das Zeitbudget im
  /// Prüfungsmodus.
  int get estimatedSeconds => switch (kind) {
    QuestionKind.single => 55,
    QuestionKind.multiple => 80,
    QuestionKind.numeric => 110,
    QuestionKind.ordering => 75,
    QuestionKind.matching => 95,
    QuestionKind.netzplan => 60 + activities.length * 35,
    QuestionKind.cloze => 50 + gaps.length * 15,
    QuestionKind.table => 50 + gridGaps.length * 20,
    QuestionKind.open => 60 + points * 45,
    QuestionKind.marking => 75,
    QuestionKind.pairs => 40 + pairs.length * 8,
  };

  /// Punkte, wie sie die IHK vergeben würde - skaliert mit Aufwand.
  int get points =>
      pointsOverride ??
      switch (kind) {
        QuestionKind.single => 2,
        QuestionKind.multiple => 3,
        QuestionKind.numeric => 3,
        QuestionKind.ordering => 3,
        QuestionKind.matching => 4,
        QuestionKind.netzplan => 6,
        QuestionKind.cloze => 3,
        QuestionKind.table => 4,
        QuestionKind.open => criteria.fold(0, (s, c) => s + c.points),
        QuestionKind.marking => 3,
        QuestionKind.pairs => 3,
      };

  NetzplanSolution? get netzplanSolution =>
      activities.isEmpty ? null : NetzplanSolver.solve(activities);

  /// Bewertet eine Antwort. [answer] ist typabhängig:
  /// - single/multiple: `Set<int>` der gewählten Indizes
  /// - numeric: `double`
  /// - ordering: `List<int>` der Original-Indizes in Nutzerreihenfolge
  /// - matching: `Map<int, int>` Item-Index -> Bucket-Index
  /// - netzplan: `Map<String, int>` "A.faz" -> Wert
  /// - cloze: `Map<int, String>` Lückenindex -> Eingabe
  /// - table: `Map<String, String>` "zeile.spalte" -> Eingabe
  /// - open: [OpenAnswer]
  /// - marking: `Set<int>` der markierten Indizes in [choices]
  /// - pairs: `Map<int, int>` Index links -> Index rechts (in [pairs])
  GradeResult grade(Object? answer) {
    switch (kind) {
      case QuestionKind.cloze:
        final map = (answer as Map<int, String>?) ?? const <int, String>{};
        final parts = <String, bool>{
          for (var i = 0; i < gaps.length; i++) '$i': gaps[i].matches(map[i]),
        };
        final hits = parts.values.where((v) => v).length;
        return GradeResult(
          score: gaps.isEmpty ? 0 : hits / gaps.length,
          parts: parts,
        );

      case QuestionKind.table:
        final map =
            (answer as Map<String, String>?) ?? const <String, String>{};
        final cells = gridGaps;
        final parts = <String, bool>{
          for (final e in cells.entries) e.key: e.value.matches(map[e.key]),
        };
        final hits = parts.values.where((v) => v).length;
        return GradeResult(
          score: cells.isEmpty ? 0 : hits / cells.length,
          parts: parts,
        );

      case QuestionKind.open:
        final a = answer as OpenAnswer?;
        final total = criteria.fold<int>(0, (s, c) => s + c.points);
        final parts = <String, bool>{};
        var earned = 0;
        for (var i = 0; i < criteria.length; i++) {
          final ok = a == null
              ? false
              : a.checked != null
              ? a.checked!.contains(i)
              : criteria[i].foundIn(a.text);
          parts['$i'] = ok;
          if (ok) earned += criteria[i].points;
        }
        return GradeResult(
          score: total == 0 ? 0 : earned / total,
          parts: parts,
        );

      case QuestionKind.pairs:
        final map = (answer as Map<int, int>?) ?? const <int, int>{};
        final parts = <String, bool>{
          for (var i = 0; i < pairs.length; i++) '$i': map[i] == i,
        };
        final hits = parts.values.where((v) => v).length;
        return GradeResult(
          score: pairs.isEmpty ? 0 : hits / pairs.length,
          parts: parts,
        );

      case QuestionKind.single:
      case QuestionKind.multiple:
      case QuestionKind.marking:
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
        // Falsch angekreuzte Optionen ziehen ab - sonst wäre "alles ankreuzen"
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
        return GradeResult(score: total == 0 ? 0 : hits / total, parts: parts);
    }
  }

  factory Question.fromJson(Map<String, dynamic> j) {
    final data = (j['data'] as Map?)?.cast<String, dynamic>() ?? const {};
    return Question(
      id: j['id'].toString(),
      topicId: j['topic_id'] as String,
      subtopicId: j['subtopic_id'] as String?,
      kind: QuestionKind.parse(j['kind'] as String),
      scenario: j['scenario'] as String?,
      diagram: Diagram.fromJson(
        (data['diagram'] as Map?)?.cast<String, dynamic>(),
      ),
      prompt: j['prompt'] as String,
      explanation: (j['explanation'] ?? '') as String,
      difficulty: (j['difficulty'] as num?)?.toInt() ?? 2,
      tags: ((j['tags'] as List?) ?? const []).cast<String>().toList(),
      source: j['source'] as String?,
      catalogStatus: CatalogStatus.parse(j['catalog_status'] as String?),
      choices: ((data['choices'] as List?) ?? const [])
          .map((e) => Choice.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      numericAnswer: (data['answer'] as num?)?.toDouble(),
      numericTolerance: (data['tolerance'] as num?)?.toDouble() ?? 0,
      unit: data['unit'] as String?,
      orderedItems: ((data['ordered_items'] as List?) ?? const [])
          .cast<String>()
          .toList(),
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
          .map(
            (s) => NodeField.values.firstWhere(
              (f) => f.name == s,
              orElse: () => NodeField.faz,
            ),
          )
          .toList(),
      table: (data['table'] as List?)
          ?.map((row) => (row as List).cast<String>().toList())
          .toList(),
      code: data['code'] as String?,
      caseId: data['case_id'] as String?,
      pointsOverride: (data['points'] as num?)?.toInt(),
      clozeText: data['cloze_text'] as String?,
      gaps: ((data['gaps'] as List?) ?? const [])
          .map((e) => Blank.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      wordBank: ((data['word_bank'] as List?) ?? const [])
          .cast<String>()
          .toList(),
      grid: ((data['grid'] as List?) ?? const [])
          .map(
            (row) => (row as List)
                .map(
                  (c) => GridCell.fromJson((c as Map).cast<String, dynamic>()),
                )
                .toList(),
          )
          .toList(),
      criteria: ((data['criteria'] as List?) ?? const [])
          .map((e) => Criterion.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      sampleSolution: data['sample_solution'] as String?,
      mono: data['mono'] == true,
      pairs: ((data['pairs'] as List?) ?? const [])
          .map((e) => PairItem.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'topic_id': topicId,
    if (subtopicId != null) 'subtopic_id': subtopicId,
    'kind': kind.name,
    'scenario': scenario,
    'prompt': prompt,
    'explanation': explanation,
    'difficulty': difficulty,
    'tags': tags,
    'source': source,
    'catalog_status': catalogStatus.name,
    'data': {
      if (diagram != null) 'diagram': diagram!.toJson(),
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
      if (table != null) 'table': table,
      if (code != null) 'code': code,
      if (caseId != null) 'case_id': caseId,
      if (pointsOverride != null) 'points': pointsOverride,
      if (clozeText != null) 'cloze_text': clozeText,
      if (gaps.isNotEmpty) 'gaps': gaps.map((g) => g.toJson()).toList(),
      if (wordBank.isNotEmpty) 'word_bank': wordBank,
      if (grid.isNotEmpty)
        'grid': [
          for (final row in grid) [for (final c in row) c.toJson()],
        ],
      if (criteria.isNotEmpty)
        'criteria': criteria.map((c) => c.toJson()).toList(),
      if (sampleSolution != null) 'sample_solution': sampleSolution,
      if (mono) 'mono': true,
      if (pairs.isNotEmpty) 'pairs': pairs.map((p) => p.toJson()).toList(),
    },
  };

  /// Kopie als Teilaufgabe einer Fallaufgabe.
  Question inCase(String caseId) => Question(
    id: id,
    topicId: topicId,
    kind: kind,
    prompt: prompt,
    explanation: explanation,
    subtopicId: subtopicId,
    scenario: scenario,
    diagram: diagram,
    difficulty: difficulty,
    tags: tags,
    choices: choices,
    numericAnswer: numericAnswer,
    numericTolerance: numericTolerance,
    unit: unit,
    orderedItems: orderedItems,
    orderingHint: orderingHint,
    buckets: buckets,
    matchItems: matchItems,
    activities: activities,
    askedFields: askedFields,
    source: source,
    catalogStatus: catalogStatus,
    table: table,
    code: code,
    caseId: caseId,
    pointsOverride: pointsOverride,
    clozeText: clozeText,
    gaps: gaps,
    wordBank: wordBank,
    grid: grid,
    criteria: criteria,
    sampleSolution: sampleSolution,
    mono: mono,
    pairs: pairs,
  );
}
