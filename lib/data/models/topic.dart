import 'package:flutter/material.dart';

/// Ein Themengebiet der AP1 im Bereich Projektmanagement / Strukturierung.
///
/// [weight] ist der geschaetzte Anteil an den PM-Punkten der Pruefung und geht
/// in die Berechnung der Pruefungsreife ein. Die Summe aller Gewichte ist 1.0.
@immutable
class Topic {
  const Topic({
    required this.id,
    required this.title,
    required this.blurb,
    required this.icon,
    required this.weight,
  });

  final String id;
  final String title;
  final String blurb;
  final IconData icon;
  final double weight;
}

class Topics {
  const Topics._();

  static const all = <Topic>[
    Topic(
      id: 'projektorganisation',
      title: 'Projektorganisation & Rollen',
      blurb: 'Projektarten, Aufbauorganisation, Stakeholder, Projektauftrag',
      icon: Icons.account_tree_outlined,
      weight: 0.10,
    ),
    Topic(
      id: 'vorgehensmodelle',
      title: 'Vorgehensmodelle & Phasen',
      blurb: 'Wasserfall, V-Modell, Spiralmodell, Phasenabgrenzung',
      icon: Icons.stairs_outlined,
      weight: 0.12,
    ),
    Topic(
      id: 'agil_scrum',
      title: 'Agile Methoden & Scrum',
      blurb: 'Rollen, Artefakte, Events, Kanban, agiles Manifest',
      icon: Icons.bolt_outlined,
      weight: 0.16,
    ),
    Topic(
      id: 'netzplan',
      title: 'Netzplantechnik',
      blurb: 'FAZ/FEZ/SAZ/SEZ, Puffer, kritischer Pfad',
      icon: Icons.hub_outlined,
      weight: 0.18,
    ),
    Topic(
      id: 'terminplanung',
      title: 'Gantt & Meilensteine',
      blurb: 'Balkenplan, Meilensteintrendanalyse, Ressourcenplanung',
      icon: Icons.view_timeline_outlined,
      weight: 0.10,
    ),
    Topic(
      id: 'lastenheft',
      title: 'Lasten- & Pflichtenheft',
      blurb: 'Anforderungsarten, Abgrenzung, Inhalte, Abnahme',
      icon: Icons.description_outlined,
      weight: 0.14,
    ),
    Topic(
      id: 'wirtschaftlichkeit',
      title: 'Wirtschaftlichkeit & Nutzwert',
      blurb: 'Angebotsvergleich, Nutzwertanalyse, Amortisation, TCO',
      icon: Icons.calculate_outlined,
      weight: 0.10,
    ),
    Topic(
      id: 'qualitaet_risiko',
      title: 'Qualitaet & Risiko',
      blurb: 'QS-Massnahmen, Testarten, Risikomatrix, Massnahmenstrategien',
      icon: Icons.shield_outlined,
      weight: 0.06,
    ),
    Topic(
      id: 'abschluss',
      title: 'Abschluss & Kommunikation',
      blurb: 'Projektabschluss, Doku, Praesentation, Lessons Learned',
      icon: Icons.flag_outlined,
      weight: 0.04,
    ),
  ];

  static Topic byId(String id) =>
      all.firstWhere((t) => t.id == id, orElse: () => all.first);

  static final Map<String, Topic> map = {for (final t in all) t.id: t};
}
