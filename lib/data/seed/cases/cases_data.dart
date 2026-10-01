import '../../models/exam_case.dart';
import 'cases_a01_planung.dart';
import 'cases_a01_projekte.dart';
import 'cases_a02_kunden.dart';
import 'cases_a03_systeme.dart';
import 'cases_a04_daten.dart';
import 'cases_a04_entwicklung.dart';
import 'cases_a05_qualitaet.dart';
import 'cases_a06_sicherheit.dart';
import 'cases_a07_vertraege.dart';

/// Alle Fallaufgaben der Prüfungssimulation.
final List<ExamCase> kSeedCases = [
  ...casesA01Projekte,
  ...casesA01Planung,
  ...casesA02,
  ...casesA03,
  ...casesA04Entwicklung,
  ...casesA04Daten,
  ...casesA05,
  ...casesA06,
  ...casesA07,
];

final Map<String, ExamCase> kCaseById = {for (final c in kSeedCases) c.id: c};
