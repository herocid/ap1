import '../models/diagram.dart';
import '../models/exam_case.dart';
import '../models/question.dart';
import '../models/subtopic.dart';

export '../models/exam_case.dart';

/// Helfer für die Aufgabenarten im IHK-Stil und für Fallaufgaben.
///
/// Alle Aufgaben können Material mitbringen, das zwischen Situation und
/// Frage steht: `table:` (gegebene Tabelle, erste Zeile = Köpfe), `code:`
/// (Pseudocode, Log, Konfiguration, englischer Text) und `skizze:`.
/// `punkte:` setzt die Punktzahl wie im Lösungsbogen.

String _topicOf(String sub) {
  final s = Subtopics.byId(sub);
  if (s == null) throw ArgumentError('Unbekannte Lektion: $sub');
  return s.topicId;
}

/// Lücke mit Auswahlliste: `wahl('TCP', ['UDP', 'ICMP'])`.
/// Die richtige Antwort steht vorn, die App mischt die Liste.
Blank wahl(String richtig, List<String> falsch, [String rationale = '']) =>
    Blank([richtig], options: [richtig, ...falsch], rationale: rationale);

/// Lücke zum Eintippen oder für die Wortbank. Mehrere akzeptierte
/// Schreibweisen möglich: `wort(['Switch', 'Layer-2-Switch'])`.
Blank wort(List<String> akzeptiert, [String rationale = '']) =>
    Blank(akzeptiert, rationale: rationale);

/// Zahl als Lücke: `zahl(62)`, `zahl(12.5, toleranz: 0.1, einheit: '€')`.
Blank zahl(
  num wert, {
  double toleranz = 0,
  String? einheit,
  String rationale = '',
}) => Blank.zahl(wert, tolerance: toleranz, unit: einheit, rationale: rationale);

/// Bewertungskriterium einer Freitext-Aufgabe.
Criterion krit(
  String text, {
  int punkte = 1,
  List<String> stichwoerter = const [],
}) => Criterion(text, points: punkte, keywords: stichwoerter);

PairItem paar(String links, String rechts) => PairItem(links, rechts);

/// Lückentext. [text] enthält `{0}`, `{1}` ... für die [luecken].
/// - Lücken mit `wahl(...)`: Dropdown.
/// - Lücken mit `wort(...)` und gefüllter [wortbank] (Ablenker): Begriffe
///   antippen wie bei Sprachlern-Apps.
/// - Lücken mit `wort(...)`/`zahl(...)` ohne Wortbank: kurze Eingabe.
/// [mono] setzt den Text als Code (Pseudocode ergänzen).
Question lueckentext(
  String id,
  String sub, {
  required String prompt,
  required String text,
  required List<Blank> luecken,
  required String explanation,
  List<String> wortbank = const [],
  bool mono = false,
  String? scenario,
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) {
  for (var i = 0; i < luecken.length; i++) {
    if (!text.contains('{$i}')) {
      throw ArgumentError('$id: Platzhalter {$i} fehlt im Lückentext');
    }
  }
  return Question(
    id: id,
    topicId: _topicOf(sub),
    subtopicId: sub,
    kind: QuestionKind.cloze,
    prompt: prompt,
    clozeText: text,
    gaps: luecken,
    wordBank: wortbank,
    mono: mono,
    explanation: explanation,
    scenario: scenario,
    table: table,
    code: code,
    diagram: skizze,
    pointsOverride: punkte,
    difficulty: difficulty,
    tags: tags,
  );
}

/// Tabelle ausfüllen. [zeilen]: erste Zeile = Spaltenköpfe; jede Zelle ist
/// ein `String` (vorgegeben) oder eine Lücke (`wahl`, `wort`, `zahl`).
Question tabelle(
  String id,
  String sub, {
  required String prompt,
  required List<List<Object>> zeilen,
  required String explanation,
  String? scenario,
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) {
  final grid = [
    for (final row in zeilen)
      [
        for (final cell in row)
          switch (cell) {
            String s => GridCell(s),
            Blank g => GridCell.gap(g),
            _ => throw ArgumentError('$id: Zelle muss String oder Blank sein'),
          },
      ],
  ];
  return Question(
    id: id,
    topicId: _topicOf(sub),
    subtopicId: sub,
    kind: QuestionKind.table,
    prompt: prompt,
    grid: grid,
    explanation: explanation,
    scenario: scenario,
    table: table,
    code: code,
    diagram: skizze,
    pointsOverride: punkte,
    difficulty: difficulty,
    tags: tags,
  );
}

/// Freitext wie in der IHK-Prüfung ("Nennen Sie ...", "Erläutern Sie ...").
/// [loesung] ist die ausformulierte Musterlösung, [kriterien] sind die
/// Bewertungspunkte des Lösungsbogens; die Punkte der Aufgabe ergeben sich
/// aus ihrer Summe. [explanation] gibt den Bewertungshinweis ("je Nennung
/// 1 Punkt, andere sinnvolle Lösungen sind möglich").
Question freitext(
  String id,
  String sub, {
  required String prompt,
  required List<Criterion> kriterien,
  required String loesung,
  required String explanation,
  String? scenario,
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.open,
  prompt: prompt,
  criteria: kriterien,
  sampleSolution: loesung,
  explanation: explanation,
  scenario: scenario,
  table: table,
  code: code,
  diagram: skizze,
  pointsOverride: punkte,
  difficulty: difficulty,
  tags: tags,
);

/// Markieren: Zeilen/Elemente antippen, die eine Bedingung erfüllen.
/// [zeilen] mit `ja(...)` (gehört markiert) und `nein(...)`, jeweils mit
/// Begründung. [mono] für Code, Logs, Konfigurationen.
Question markieren(
  String id,
  String sub, {
  required String prompt,
  required List<Choice> zeilen,
  required String explanation,
  bool mono = false,
  String? scenario,
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.marking,
  prompt: prompt,
  choices: zeilen,
  mono: mono,
  explanation: explanation,
  scenario: scenario,
  table: table,
  code: code,
  diagram: skizze,
  pointsOverride: punkte,
  difficulty: difficulty,
  tags: tags,
);

/// Paare finden: links Begriff, rechts Gegenstück (4-6 Paare, kurze Texte).
Question paare(
  String id,
  String sub, {
  required String prompt,
  required List<PairItem> paare,
  required String explanation,
  String? scenario,
  List<List<String>>? table,
  String? code,
  Diagram? skizze,
  int? punkte,
  int difficulty = 2,
  List<String> tags = const [],
}) => Question(
  id: id,
  topicId: _topicOf(sub),
  subtopicId: sub,
  kind: QuestionKind.pairs,
  prompt: prompt,
  pairs: paare,
  explanation: explanation,
  scenario: scenario,
  table: table,
  code: code,
  diagram: skizze,
  pointsOverride: punkte,
  difficulty: difficulty,
  tags: tags,
);

/// Fallaufgabe im IHK-Stil: eine Situation, 4-8 Teilaufgaben, zusammen
/// genau 25 Punkte (jede Teilaufgabe mit `punkte:`). [firma] ist eine ID aus
/// `ExamCompanies` (`systemhaus`, `handel`, `agentur`, `logistik`), [bereich]
/// der Katalogbereich `a01` ... `a07`.
ExamCase fall(
  String id, {
  required String firma,
  required String bereich,
  required String titel,
  required String situation,
  required List<Question> teile,
}) => ExamCase(
  id: id,
  companyId: firma,
  areaId: bereich,
  title: titel,
  situation: situation,
  parts: [for (final q in teile) q.inCase(id)],
);
