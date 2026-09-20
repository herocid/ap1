import 'package:flutter/material.dart';

/// Die sieben Bereiche des IHK-Pruefungskatalogs fuer die AP1 der IT-Berufe
/// (2. ueberarbeitete Auflage, erstmals angewendet im Fruehjahr 2025).
///
/// Die Bereichsnummern und -namen folgen dem amtlichen Katalog. Die
/// Feingliederung in Themen darunter ist eine Rekonstruktion: Die exakten
/// amtlichen Unterkapitel-Titel (01.01, 01.02, ...) sind nicht frei
/// veroeffentlicht. Sie ist fachlich am Katalog ausgerichtet, aber kein Zitat.
@immutable
class ExamArea {
  const ExamArea({
    required this.id,
    required this.number,
    required this.title,
    required this.blurb,
    required this.icon,
    required this.weight,
  });

  final String id;

  /// Zweistellige Katalognummer, z. B. "01".
  final String number;
  final String title;
  final String blurb;
  final IconData icon;

  /// Geschaetzter Anteil an den Punkten der AP1. Summe ueber alle Bereiche = 1.
  final double weight;
}

class ExamAreas {
  const ExamAreas._();

  static const projekte = ExamArea(
    id: 'a01',
    number: '01',
    title: 'Projekte & Projektmanagement',
    blurb: 'Ziele, Vorgehensmodelle, Termin- und Kostenplanung, Risiken',
    icon: Icons.account_tree_outlined,
    weight: 0.22,
  );

  static const kunden = ExamArea(
    id: 'a02',
    number: '02',
    title: 'Kundenbeziehungen & Kommunikation',
    blurb: 'Gespraechsfuehrung, Team, Verhandlung, Praesentation, Markt',
    icon: Icons.forum_outlined,
    weight: 0.13,
  );

  static const systeme = ExamArea(
    id: 'a03',
    number: '03',
    title: 'Informations- & Softwaresysteme',
    blurb: 'Hardware, Betriebssysteme, Anwendungssysteme, Netzwerke',
    icon: Icons.dns_outlined,
    weight: 0.18,
  );

  static const entwicklung = ExamArea(
    id: 'a04',
    number: '04',
    title: 'Analyse & Entwicklung von Systemen',
    blurb: 'Anforderungen, UML, Programmierlogik, Web, Daten, KI',
    icon: Icons.architecture_outlined,
    weight: 0.22,
  );

  static const qualitaet = ExamArea(
    id: 'a05',
    number: '05',
    title: 'Qualitaetssicherung',
    blurb: 'QS-Massnahmen, PDCA, Testverfahren und Testprotokolle',
    icon: Icons.verified_outlined,
    weight: 0.07,
  );

  static const sicherheit = ExamArea(
    id: 'a06',
    number: '06',
    title: 'IT-Sicherheit & Datenschutz',
    blurb: 'Schutzziele, Massnahmen, Kryptographie, DSGVO',
    icon: Icons.shield_outlined,
    weight: 0.12,
  );

  static const vertraege = ExamArea(
    id: 'a07',
    number: '07',
    title: 'Vertragsmanagement & Service',
    blurb: 'Vertragsarten, SLA, Leistungsstoerungen, Change Management',
    icon: Icons.handshake_outlined,
    weight: 0.06,
  );

  static const all = <ExamArea>[
    projekte,
    kunden,
    systeme,
    entwicklung,
    qualitaet,
    sicherheit,
    vertraege,
  ];

  static final Map<String, ExamArea> map = {for (final a in all) a.id: a};

  static ExamArea byId(String id) => map[id] ?? projekte;
}
