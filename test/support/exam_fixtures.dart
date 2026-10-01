import 'package:ap1_trainer/data/models/exam_case.dart';
import 'package:ap1_trainer/data/models/question.dart';
import 'package:ap1_trainer/data/models/topic.dart';

/// Test-Fallaufgaben im IHK-Stil - bewusst mit langen Texten und allen
/// wichtigen Antwortformaten, damit Auswahl, Ablauf und Layout der
/// Prüfungssimulation unabhängig von den echten Inhalten geprüft werden.

Question _q(
  String id,
  String topic,
  QuestionKind kind, {
  required String prompt,
  required int points,
  List<Choice> choices = const [],
  double? numeric,
  String? unit,
  List<Criterion> criteria = const [],
  String? solution,
  String? cloze,
  List<Blank> gaps = const [],
  List<List<GridCell>> grid = const [],
  List<List<String>>? table,
}) => Question(
  id: id,
  topicId: topic,
  kind: kind,
  prompt: prompt,
  explanation:
      'Bewertungshinweis: Je zutreffender Nennung gibt es die angegebenen '
      'Punkte; andere fachlich richtige Lösungen sind möglich.',
  pointsOverride: points,
  choices: choices,
  numericAnswer: numeric,
  unit: unit,
  criteria: criteria,
  sampleSolution: solution,
  clozeText: cloze,
  gaps: gaps,
  grid: grid,
  table: table,
);

/// Eine Fallaufgabe mit sechs Teilaufgaben und zusammen 25 Punkten:
/// Freitext (6), Rechnung (4), Tabelle (6), Auswahl (2), Lückentext (3),
/// Freitext kurz (4).
ExamCase testCase(String id, String company, String area, {String? title}) {
  final topic = Topics.ofArea(area).first.id;
  return ExamCase(
    id: id,
    companyId: company,
    areaId: area,
    title: title ?? 'Arbeitsplätze der Disposition modernisieren ($id)',
    situation:
        'Die Disposition erhält zwölf neue Arbeitsplätze. Du bereitest die '
        'Beschaffung vor, prüfst die Wirtschaftlichkeit und planst die '
        'Inbetriebnahme. Die Geschäftsführung erwartet eine nachvollziehbare '
        'Entscheidungsvorlage.',
    parts: [
      _q(
        '$id-a',
        topic,
        QuestionKind.open,
        prompt:
            'Erläutern Sie drei Kriterien, nach denen Sie die angebotenen '
            'Geräte vergleichen.',
        points: 6,
        criteria: const [
          Criterion(
            'Anschaffungs- und Folgekosten',
            points: 2,
            keywords: ['Kosten', 'Preis'],
          ),
          Criterion(
            'Leistung passend zum Einsatz',
            points: 2,
            keywords: ['Leistung', 'Prozessor'],
          ),
          Criterion(
            'Garantie und Service',
            points: 2,
            keywords: ['Garantie', 'Service'],
          ),
          Criterion(
            'Energieverbrauch',
            points: 2,
            keywords: ['Energie', 'Strom'],
          ),
        ],
        solution:
            'Kosten über die Nutzungsdauer, Leistung passend zu den '
            'Anwendungen, Garantie- und Serviceleistungen sowie der '
            'Energieverbrauch.',
      ).inCase(id),
      _q(
        '$id-b',
        topic,
        QuestionKind.numeric,
        prompt:
            'Berechnen Sie die monatlichen Kosten eines Arbeitsplatzes bei '
            '1.440 € Anschaffung und 48 Monaten Nutzungsdauer.',
        points: 4,
        numeric: 30,
        unit: '€',
      ).inCase(id),
      _q(
        '$id-c',
        topic,
        QuestionKind.table,
        prompt: 'Ergänzen Sie die Tabelle mit den Nutzwerten der Angebote.',
        points: 6,
        grid: [
          const [GridCell('Angebot'), GridCell('Nutzwert')],
          [const GridCell('A'), GridCell.gap(Blank.zahl(62))],
          [const GridCell('B'), GridCell.gap(Blank.zahl(66))],
        ],
      ).inCase(id),
      _q(
        '$id-d',
        topic,
        QuestionKind.single,
        prompt: 'Welche Anschlussart eignet sich für eine Monitorkette?',
        points: 2,
        choices: const [
          Choice(
            text: 'DisplayPort mit Multi-Stream Transport',
            isCorrect: true,
            rationale: 'MST erlaubt Daisy Chaining.',
          ),
          Choice(
            text: 'VGA',
            isCorrect: false,
            rationale: 'Analog, keine Kette möglich.',
          ),
          Choice(
            text: 'Kaltgerätebuchse',
            isCorrect: false,
            rationale: 'Das ist die Stromversorgung.',
          ),
        ],
      ).inCase(id),
      _q(
        '$id-e',
        topic,
        QuestionKind.cloze,
        prompt: 'Ergänzen Sie die Konfiguration des neuen Arbeitsplatzes.',
        points: 3,
        cloze: 'Maske {0}, nutzbare Hosts {1}, Gateway {2}',
        gaps: [
          const Blank(['255.255.255.192']),
          Blank.zahl(62),
          const Blank(['192.168.10.1']),
        ],
      ).inCase(id),
      _q(
        '$id-f',
        topic,
        QuestionKind.open,
        prompt: 'Nennen Sie vier Maßnahmen für eine sichere Inbetriebnahme.',
        points: 4,
        criteria: const [
          Criterion('Standardpasswörter ändern', keywords: ['Passwort']),
          Criterion('Updates einspielen', keywords: ['Update']),
          Criterion('Festplatte verschlüsseln', keywords: ['verschlüsseln']),
          Criterion('Benutzerrechte einschränken', keywords: ['Rechte']),
          Criterion('Virenschutz aktivieren', keywords: ['Virenschutz']),
        ],
        solution:
            'Standardpasswörter ändern, Updates einspielen, Datenträger '
            'verschlüsseln, Rechte nach dem Minimalprinzip vergeben.',
      ).inCase(id),
    ],
  );
}

const _areas = ['a01', 'a02', 'a03', 'a03', 'a04', 'a04', 'a05', 'a06', 'a07'];

/// Ein voller Satz: je Unternehmen Fälle für alle Bereiche, a03 und a04
/// doppelt - so, wie die Autoren liefern.
List<ExamCase> fullCaseSet() => [
  for (final c in ExamCompanies.all)
    for (var i = 0; i < _areas.length; i++)
      testCase('fall-${c.id}-${_areas[i]}-$i', c.id, _areas[i]),
];
