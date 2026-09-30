import '../models/flashcard.dart';
import '../models/nugget.dart';
import '../models/question.dart';
import '../models/subtopic.dart';

/// Kurzschreibweisen für die Inhaltsdateien.
///
/// Jede Funktion bekommt die Lektion ([sub]) und leitet das Thema daraus
/// ab. So kann ein Inhalt gar nicht in einem Thema landen, zu dem seine
/// Lektion nicht gehört. Unbekannte Lektions-IDs fallen sofort auf.

String _topicOf(String sub) {
  final s = Subtopics.byId(sub);
  if (s == null) throw ArgumentError('Unbekannte Lektion: $sub');
  return s.topicId;
}

// ------------------------------------------------------------ Lernschritte

Nugget konzept(String id, String sub, String title, String body,
        {List<String> points = const [], String? merksatz}) =>
    Nugget(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: NuggetKind.konzept,
      title: title,
      body: body,
      points: points,
      merksatz: merksatz,
    );

Nugget vergleich(String id, String sub, String title, String body,
        List<List<String>> table, {String? merksatz}) =>
    Nugget(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: NuggetKind.vergleich,
      title: title,
      body: body,
      table: table,
      merksatz: merksatz,
    );

Nugget ablauf(String id, String sub, String title, String body,
        List<String> steps, {String? merksatz}) =>
    Nugget(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: NuggetKind.ablauf,
      title: title,
      body: body,
      points: steps,
      merksatz: merksatz,
    );

Nugget formel(String id, String sub, String title, String body, String code,
        {List<String> points = const [], String? merksatz}) =>
    Nugget(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: NuggetKind.formel,
      title: title,
      body: body,
      code: code,
      points: points,
      merksatz: merksatz,
    );

Nugget merke(String id, String sub, String title, String body,
        {List<String> points = const [], String? satz}) =>
    Nugget(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: NuggetKind.merksatz,
      title: title,
      body: body,
      points: points,
      merksatz: satz,
    );

Nugget falle(String id, String sub, String title, String body,
        {List<String> points = const [], String? merksatz}) =>
    Nugget(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: NuggetKind.fehlerfalle,
      title: title,
      body: body,
      points: points,
      merksatz: merksatz,
    );

// ----------------------------------------------------------- Karteikarten

Flashcard karte(String id, String sub, String front, String back,
        [String? hint]) =>
    Flashcard(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      front: front,
      back: back,
      hint: hint,
    );

// --------------------------------------------------------------- Aufgaben

/// Richtige Antwortoption mit Begründung.
Choice ja(String text, String rationale) =>
    Choice(text: text, isCorrect: true, rationale: rationale);

/// Falsche Antwortoption mit Begründung, warum sie falsch ist.
Choice nein(String text, String rationale) =>
    Choice(text: text, isCorrect: false, rationale: rationale);

/// Zuordnungs-Item: [bucket] ist der Index der richtigen Kategorie.
MatchItem zu(String text, int bucket, [String rationale = '']) =>
    MatchItem(text: text, bucket: bucket, rationale: rationale);

Question einfach(String id, String sub,
        {required String prompt,
        required List<Choice> choices,
        required String explanation,
        String? scenario,
        int difficulty = 2,
        List<String> tags = const []}) =>
    Question(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: QuestionKind.single,
      prompt: prompt,
      scenario: scenario,
      choices: choices,
      explanation: explanation,
      difficulty: difficulty,
      tags: tags,
    );

Question mehrfach(String id, String sub,
        {required String prompt,
        required List<Choice> choices,
        required String explanation,
        String? scenario,
        int difficulty = 2,
        List<String> tags = const []}) =>
    Question(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: QuestionKind.multiple,
      prompt: prompt,
      scenario: scenario,
      choices: choices,
      explanation: explanation,
      difficulty: difficulty,
      tags: tags,
    );

Question rechnen(String id, String sub,
        {required String prompt,
        required double answer,
        required String explanation,
        String? scenario,
        String? unit,
        double tolerance = 0,
        int difficulty = 2,
        List<String> tags = const []}) =>
    Question(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: QuestionKind.numeric,
      prompt: prompt,
      scenario: scenario,
      numericAnswer: answer,
      numericTolerance: tolerance,
      unit: unit,
      explanation: explanation,
      difficulty: difficulty,
      tags: tags,
    );

/// [items] in der RICHTIGEN Reihenfolge - gemischt wird in der App.
Question reihenfolge(String id, String sub,
        {required String prompt,
        required List<String> items,
        required String explanation,
        String? scenario,
        String? hint,
        int difficulty = 2,
        List<String> tags = const []}) =>
    Question(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: QuestionKind.ordering,
      prompt: prompt,
      scenario: scenario,
      orderedItems: items,
      orderingHint: hint,
      explanation: explanation,
      difficulty: difficulty,
      tags: tags,
    );

Question zuordnen(String id, String sub,
        {required String prompt,
        required List<String> buckets,
        required List<MatchItem> items,
        required String explanation,
        String? scenario,
        int difficulty = 2,
        List<String> tags = const []}) =>
    Question(
      id: id,
      topicId: _topicOf(sub),
      subtopicId: sub,
      kind: QuestionKind.matching,
      prompt: prompt,
      scenario: scenario,
      buckets: buckets,
      matchItems: items,
      explanation: explanation,
      difficulty: difficulty,
      tags: tags,
    );
