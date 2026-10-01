import '../models/diagram.dart';
import '../models/flashcard.dart';
import '../models/netzplan.dart';
import '../models/nugget.dart';
import '../models/question.dart';
import '../models/subtopic.dart';

// Die Inhaltsdateien brauchen nur diesen Import für Zeichnungen und
// Netzplan-Vorgänge.
export '../models/diagram.dart';
export '../models/netzplan.dart' show Activity, NodeField;
export 'builders_ihk.dart';

/// Kurzschreibweisen für die Inhaltsdateien.
///
/// Jede Funktion bekommt die Lektion ([sub]) und leitet das Thema daraus
/// ab. So kann ein Inhalt gar nicht in einem Thema landen, zu dem seine
/// Lektion nicht gehört. Unbekannte Lektions-IDs fallen sofort auf.
///
/// Alle Lernschritte nehmen optional eine Tabelle (`table`, erste Zeile =
/// Spaltenköpfe) und eine Zeichnung (`skizze`) mit.

String _topicOf(String sub) {
  final s = Subtopics.byId(sub);
  if (s == null) throw ArgumentError('Unbekannte Lektion: $sub');
  return s.topicId;
}

// ------------------------------------------------------------ Lernschritte

Nugget konzept(
  String id,
  String sub,
  String title,
  String body, {
  List<String> points = const [],
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  String? merksatz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.konzept,
  title: title,
  body: body,
  points: points,
  table: table,
  code: code,
  diagram: skizze,
  merksatz: merksatz,
);

Nugget vergleich(
  String id,
  String sub,
  String title,
  String body,
  List<List<String>> table, {
  List<String> points = const [],
  Diagram? skizze,
  String? merksatz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.vergleich,
  title: title,
  body: body,
  table: table,
  points: points,
  diagram: skizze,
  merksatz: merksatz,
);

Nugget ablauf(
  String id,
  String sub,
  String title,
  String body,
  List<String> steps, {
  List<List<String>>? table,
  Diagram? skizze,
  String? merksatz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.ablauf,
  title: title,
  body: body,
  points: steps,
  table: table,
  diagram: skizze,
  merksatz: merksatz,
);

Nugget formel(
  String id,
  String sub,
  String title,
  String body,
  String code, {
  List<String> points = const [],
  List<List<String>>? table,
  Diagram? skizze,
  String? merksatz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.formel,
  title: title,
  body: body,
  code: code,
  points: points,
  table: table,
  diagram: skizze,
  merksatz: merksatz,
);

/// Durchgerechnetes Beispiel. [aufgabe] ist die Aufgabenstellung mit allen
/// Zahlen, [schritte] der Lösungsweg (je Schritt eine Rechnung mit kurzer
/// Begründung), [ergebnis] das hervorgehobene Endergebnis mit Einheit.
/// Optional [table] für Ausgangsdaten oder Zwischenergebnisse, [code] für
/// eine längere Rechnung in Festbreitenschrift, [skizze] für eine Zeichnung.
Nugget beispiel(
  String id,
  String sub,
  String title,
  String aufgabe, {
  required List<String> schritte,
  required String ergebnis,
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  String? merksatz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.beispiel,
  title: title,
  body: aufgabe,
  points: schritte,
  ergebnis: ergebnis,
  table: table,
  code: code,
  diagram: skizze,
  merksatz: merksatz,
);

/// Eine Zeichnung mit Erläuterung. [body] sagt, was man sieht und worauf
/// es ankommt; [points] kann einzelne Elemente der Zeichnung erklären.
Nugget skizze(
  String id,
  String sub,
  String title,
  String body,
  Diagram diagram, {
  List<String> points = const [],
  List<List<String>>? table,
  String? merksatz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.skizze,
  title: title,
  body: body,
  diagram: diagram,
  points: points,
  table: table,
  merksatz: merksatz,
);

Nugget merke(
  String id,
  String sub,
  String title,
  String body, {
  List<String> points = const [],
  List<List<String>>? table,
  Diagram? skizze,
  String? satz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.merksatz,
  title: title,
  body: body,
  points: points,
  table: table,
  diagram: skizze,
  merksatz: satz,
);

Nugget falle(
  String id,
  String sub,
  String title,
  String body, {
  List<String> points = const [],
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  String? merksatz,
}) => Nugget(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: NuggetKind.fehlerfalle,
  title: title,
  body: body,
  points: points,
  table: table,
  code: code,
  diagram: skizze,
  merksatz: merksatz,
);

// ----------------------------------------------------------- Karteikarten

Flashcard karte(
  String id,
  String sub,
  String front,
  String back, [
  String? hint,
]) => Flashcard(
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

// Alle Aufgaben nehmen optional eine Zeichnung (`skizze`) mit, die zwischen
// Situation und Frage steht - etwa ein Klassendiagramm, das gelesen werden muss.

Question einfach(
  String id,
  String sub, {
  required String prompt,
  required List<Choice> choices,
  required String explanation,
  String? scenario,
  Diagram? skizze,
  List<List<String>>? table,
  String? code,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.single,
  prompt: prompt,
  scenario: scenario,
  diagram: skizze,
  table: table,
  code: code,
  pointsOverride: punkte,
  choices: choices,
  explanation: explanation,
  difficulty: difficulty,
  tags: tags,
);

Question mehrfach(
  String id,
  String sub, {
  required String prompt,
  required List<Choice> choices,
  required String explanation,
  String? scenario,
  Diagram? skizze,
  List<List<String>>? table,
  String? code,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.multiple,
  prompt: prompt,
  scenario: scenario,
  diagram: skizze,
  table: table,
  code: code,
  pointsOverride: punkte,
  choices: choices,
  explanation: explanation,
  difficulty: difficulty,
  tags: tags,
);

Question rechnen(
  String id,
  String sub, {
  required String prompt,
  required double answer,
  required String explanation,
  String? scenario,
  Diagram? skizze,
  List<List<String>>? table,
  String? code,
  int? punkte,
  String? unit,
  double tolerance = 0,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.numeric,
  prompt: prompt,
  scenario: scenario,
  diagram: skizze,
  table: table,
  code: code,
  pointsOverride: punkte,
  numericAnswer: answer,
  numericTolerance: tolerance,
  unit: unit,
  explanation: explanation,
  difficulty: difficulty,
  tags: tags,
);

/// [items] in der RICHTIGEN Reihenfolge - gemischt wird in der App.
Question reihenfolge(
  String id,
  String sub, {
  required String prompt,
  required List<String> items,
  required String explanation,
  String? scenario,
  Diagram? skizze,
  List<List<String>>? table,
  String? code,
  int? punkte,
  String? hint,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.ordering,
  prompt: prompt,
  scenario: scenario,
  diagram: skizze,
  table: table,
  code: code,
  pointsOverride: punkte,
  orderedItems: items,
  orderingHint: hint,
  explanation: explanation,
  difficulty: difficulty,
  tags: tags,
);

Question zuordnen(
  String id,
  String sub, {
  required String prompt,
  required List<String> buckets,
  required List<MatchItem> items,
  required String explanation,
  String? scenario,
  Diagram? skizze,
  List<List<String>>? table,
  String? code,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.matching,
  prompt: prompt,
  scenario: scenario,
  diagram: skizze,
  table: table,
  code: code,
  pointsOverride: punkte,
  buckets: buckets,
  matchItems: items,
  explanation: explanation,
  difficulty: difficulty,
  tags: tags,
);

/// Netzplan zum Ausfüllen. Die Lösung rechnet die App selbst
/// (NetzplanSolver) - [explanation] beschreibt den Rechenweg.
Question netzplanAufgabe(
  String id,
  String sub, {
  required String prompt,
  required List<Activity> vorgaenge,
  required String explanation,
  List<NodeField> gefragt = const [
    NodeField.faz,
    NodeField.fez,
    NodeField.saz,
    NodeField.sez,
    NodeField.gp,
  ],
  String? scenario,
  int? punkte,
  int difficulty = 3,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.netzplan,
  prompt: prompt,
  scenario: scenario,
  pointsOverride: punkte,
  activities: vorgaenge,
  askedFields: gefragt,
  explanation: explanation,
  difficulty: difficulty,
  tags: tags,
);
