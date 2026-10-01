import 'package:flutter/material.dart';

import '../../data/models/question.dart';

/// Antwortformate, wie sie die Auswertung zusammenfasst.
///
/// Feiner als „richtig/falsch“, gröber als [QuestionKind]: Die Frage nach
/// einer Prüfung ist nicht „welcher Aufgabentyp“, sondern „verliere ich die
/// Punkte beim Rechnen, beim Formulieren oder bei Diagrammen?“.
enum AnswerFormat {
  formulieren('Formulieren', 'beim Formulieren', Icons.edit_note_rounded),
  rechnen('Rechnen', 'beim Rechnen', Icons.calculate_outlined),
  tabelle(
    'Tabellen & Lückentexte',
    'bei Tabellen und Lückentexten',
    Icons.table_chart_outlined,
  ),
  diagramm('Diagramme', 'bei Diagrammen', Icons.schema_outlined),
  code('Code lesen', 'beim Lesen von Code', Icons.code_rounded),
  zuordnen(
    'Zuordnen & Ordnen',
    'beim Zuordnen und Ordnen',
    Icons.swap_vert_rounded,
  ),
  auswahl('Auswahl', 'bei Auswahlaufgaben', Icons.checklist_rounded);

  const AnswerFormat(this.label, this.where, this.icon);

  final String label;

  /// Satzbaustein: „Die meisten Punkte fehlen …“.
  final String where;
  final IconData icon;

  static AnswerFormat of(Question q) {
    switch (q.kind) {
      case QuestionKind.open:
        return AnswerFormat.formulieren;
      case QuestionKind.numeric:
        return AnswerFormat.rechnen;
      case QuestionKind.single:
      case QuestionKind.multiple:
        return AnswerFormat.auswahl;
      case QuestionKind.netzplan:
        return AnswerFormat.diagramm;
      case QuestionKind.cloze:
      case QuestionKind.table:
      case QuestionKind.marking:
      case QuestionKind.matching:
      case QuestionKind.ordering:
      case QuestionKind.pairs:
        // Ein Diagramm oder Code, das ergänzt wird, zählt als Diagramm- bzw.
        // Codeaufgabe - egal, mit welcher Bedienform es umgesetzt ist.
        if (q.diagram != null) return AnswerFormat.diagramm;
        if (q.mono) return AnswerFormat.code;
        return q.kind == QuestionKind.cloze || q.kind == QuestionKind.table
            ? AnswerFormat.tabelle
            : AnswerFormat.zuordnen;
    }
  }
}

/// Familien für den Formatmix einer Quiz-Runde.
class FormatMix {
  const FormatMix._();

  /// Einfach- und Mehrfachauswahl - das Format, das die echte Prüfung nicht
  /// kennt und das deshalb gedeckelt wird.
  static bool isChoice(Question q) =>
      q.kind == QuestionKind.single || q.kind == QuestionKind.multiple;

  /// Rechen- und Tabellenaufgaben (Zahlenarbeit).
  static bool isCalc(Question q) =>
      q.kind == QuestionKind.numeric ||
      q.kind == QuestionKind.table ||
      q.kind == QuestionKind.netzplan;

  static bool isOpen(Question q) => q.kind == QuestionKind.open;

  /// Schnelle Formate ohne Tippen und Rechnen.
  static bool isQuick(Question q) =>
      q.kind == QuestionKind.single ||
      q.kind == QuestionKind.pairs ||
      q.kind == QuestionKind.marking ||
      q.kind == QuestionKind.matching;

  /// „Dieselbe Art“ für die Regel „keine drei hintereinander“: Einfach- und
  /// Mehrfachauswahl gelten als eine Art.
  static String family(Question q) => isChoice(q) ? 'choice' : q.kind.name;
}

/// Rundet auf halbe Punkte, wie es Korrektoren auf dem Bogen tun.
double halfPoints(double raw) => (raw * 2).round() / 2;

/// „3“, „2,5“ - Punkte ohne überflüssige Nachkommastelle.
String formatPoints(double p) {
  final r = halfPoints(p);
  return r == r.roundToDouble()
      ? r.round().toString()
      : r.toStringAsFixed(1).replaceAll('.', ',');
}

/// IHK-Notenschlüssel (100-Punkte-Schema). [percent] ist 0..1.
({String note, String label}) ihkNote(double percent) {
  // Auf ganze Punkte runden, bevor verglichen wird: 91,6 von 100 sind 92.
  final p = (percent * 100).round();
  if (p >= 92) return (note: '1', label: 'sehr gut');
  if (p >= 81) return (note: '2', label: 'gut');
  if (p >= 67) return (note: '3', label: 'befriedigend');
  if (p >= 50) return (note: '4', label: 'ausreichend');
  if (p >= 30) return (note: '5', label: 'mangelhaft');
  return (note: '6', label: 'ungenügend');
}
