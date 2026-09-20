import 'package:flutter/material.dart';

import 'exam_area.dart';

/// Ein Thema innerhalb eines Katalogbereichs.
///
/// [weight] ist der geschätzte Anteil an den Punkten der gesamten AP1 - nicht
/// am Bereich. Die Summe über alle Themen ist 1.0, und die Summe der Themen
/// eines Bereichs ergibt dessen Bereichsgewicht. Ein Test sichert beides ab.
@immutable
class Topic {
  const Topic({
    required this.id,
    required this.areaId,
    required this.title,
    required this.blurb,
    required this.icon,
    required this.weight,
  });

  final String id;
  final String areaId;
  final String title;
  final String blurb;
  final IconData icon;
  final double weight;

  ExamArea get area => ExamAreas.byId(areaId);
}

class Topics {
  const Topics._();

  static const all = <Topic>[
    // ============================================ 01 Projekte & Projektmanagement
    Topic(
      id: 'projektorganisation',
      areaId: 'a01',
      title: 'Projektgrundlagen & Organisation',
      blurb: 'Projektbegriff, SMART-Ziele, magisches Dreieck, Rollen, Stakeholder',
      icon: Icons.account_tree_outlined,
      weight: 0.035,
    ),
    Topic(
      id: 'vorgehensmodelle',
      areaId: 'a01',
      title: 'Vorgehensmodelle & Phasen',
      blurb: 'Phasenmodell und Wasserfall - der Katalog 2025 kennt nur noch diese und Scrum',
      icon: Icons.stairs_outlined,
      weight: 0.020,
    ),
    Topic(
      id: 'agil_scrum',
      areaId: 'a01',
      title: 'Agiles Arbeiten & Scrum',
      blurb: 'Rollen, Artefakte, Events, agiles Manifest',
      icon: Icons.bolt_outlined,
      weight: 0.040,
    ),
    Topic(
      id: 'netzplan',
      areaId: 'a01',
      title: 'Netzplantechnik',
      blurb: 'FAZ/FEZ/SAZ/SEZ, Puffer, kritischer Pfad',
      icon: Icons.hub_outlined,
      weight: 0.040,
    ),
    Topic(
      id: 'terminplanung',
      areaId: 'a01',
      title: 'Projektstruktur & Termine',
      blurb: 'Projektstrukturplan, Gantt, Meilensteine, Ressourcen',
      icon: Icons.view_timeline_outlined,
      weight: 0.025,
    ),
    Topic(
      id: 'risikomanagement',
      areaId: 'a01',
      title: 'Risikomanagement',
      blurb: 'Risiken erkennen, bewerten, Strategien, Risikomatrix',
      icon: Icons.warning_amber_outlined,
      weight: 0.020,
    ),
    Topic(
      id: 'pm_wirtschaftlichkeit',
      areaId: 'a01',
      title: 'Wirtschaftlichkeit von Projekten',
      blurb: 'Machbarkeit, Make-or-Buy, Kalkulation, Break-Even, TCO',
      icon: Icons.calculate_outlined,
      weight: 0.025,
    ),
    Topic(
      id: 'projektabschluss',
      areaId: 'a01',
      title: 'Projektabschluss',
      blurb: 'Abnahme, Abschlussbericht, Lessons Learned, Übergabe',
      icon: Icons.flag_outlined,
      weight: 0.015,
    ),

    // ====================================== 02 Kundenbeziehungen & Kommunikation
    Topic(
      id: 'kommunikation',
      areaId: 'a02',
      title: 'Kommunikation & Kundenkontakt',
      blurb: 'Kommunikationsmodelle, adressatengerecht beraten, Ticketsysteme',
      icon: Icons.record_voice_over_outlined,
      weight: 0.035,
    ),
    Topic(
      id: 'teamarbeit',
      areaId: 'a02',
      title: 'Teamarbeit & Zusammenarbeit',
      blurb: 'Tuckman-Phasen, Feedback, Fehlerkultur, Diversity, Konflikte',
      icon: Icons.groups_outlined,
      weight: 0.025,
    ),
    Topic(
      id: 'verhandlung',
      areaId: 'a02',
      title: 'Verhandeln',
      blurb: 'Harvard-Konzept, Win-win, Einwandbehandlung',
      icon: Icons.balance_outlined,
      weight: 0.020,
    ),
    Topic(
      id: 'praesentation',
      areaId: 'a02',
      title: 'Präsentieren & Beraten',
      blurb: 'Argumentation, Präsentationstechnik, Quellen, Angebotserstellung',
      icon: Icons.co_present_outlined,
      weight: 0.020,
    ),
    Topic(
      id: 'markt_marketing',
      areaId: 'a02',
      title: 'Markt, Bedarf & Marketing',
      blurb: 'Marktformen, Bedarfsermittlung, AIDA, ABC-Analyse, Rechtsformen',
      icon: Icons.storefront_outlined,
      weight: 0.030,
    ),

    // ======================================== 03 Informations- & Softwaresysteme
    Topic(
      id: 'hardware',
      areaId: 'a03',
      title: 'Hardware & Arbeitsplatz',
      blurb: 'CPU, RAM, HDD vs. SSD, Peripherie, USV, Green IT, Ergonomie',
      icon: Icons.memory_outlined,
      weight: 0.040,
    ),
    Topic(
      id: 'betriebssysteme',
      areaId: 'a03',
      title: 'Betriebssysteme',
      blurb: 'Prozesse, Dateisysteme, Rechte, Kommandozeile, Härtung',
      icon: Icons.terminal_outlined,
      weight: 0.040,
    ),
    Topic(
      id: 'anwendungssysteme',
      areaId: 'a03',
      title: 'Anwendungs- & Softwaresysteme',
      blurb: 'ERP, SCM, CRM, Social Media, Lizenzmodelle, Standard vs. Individual',
      icon: Icons.apps_outlined,
      weight: 0.040,
    ),
    Topic(
      id: 'netzwerke',
      areaId: 'a03',
      title: 'Netzwerke & Cloud',
      blurb: 'OSI, IPv4/IPv6, Subnetting, Protokolle, Virtualisierung, Container',
      icon: Icons.lan_outlined,
      weight: 0.060,
    ),

    // ==================================== 04 Analyse & Entwicklung von Systemen
    Topic(
      id: 'anforderungen',
      areaId: 'a04',
      title: 'Anforderungen, Lasten- & Pflichtenheft',
      blurb: 'Anforderungsarten, Erhebung, Abgrenzung, Abnahmekriterien',
      icon: Icons.description_outlined,
      weight: 0.035,
    ),
    Topic(
      id: 'uml_modellierung',
      areaId: 'a04',
      title: 'UML & Modellierung',
      blurb: 'Use-Case-, Klassen- und Aktivitätsdiagramm',
      icon: Icons.schema_outlined,
      weight: 0.030,
    ),
    Topic(
      id: 'programmierlogik',
      areaId: 'a04',
      title: 'Programmierlogik',
      blurb: 'Datentypen, Kontrollstrukturen, Pseudocode, Schreibtischtest',
      icon: Icons.code_outlined,
      weight: 0.035,
    ),
    Topic(
      id: 'objektorientierung',
      areaId: 'a04',
      title: 'Objektorientierung',
      blurb: 'Klasse, Objekt, Attribut, Methode, Kapselung',
      icon: Icons.category_outlined,
      weight: 0.020,
    ),
    Topic(
      id: 'datenmodellierung',
      areaId: 'a04',
      title: 'Datenmodellierung',
      blurb: 'ER-Modell, Beziehungen, Schlüssel, Normalisierung',
      icon: Icons.table_chart_outlined,
      weight: 0.025,
    ),
    Topic(
      id: 'web_internet',
      areaId: 'a04',
      title: 'Web & Internet',
      blurb: 'URL, HTTP, Ablauf eines Seitenaufrufs, HTML/CSS, Barrierefreiheit',
      icon: Icons.language_outlined,
      weight: 0.030,
    ),
    Topic(
      id: 'multimedia_daten',
      areaId: 'a04',
      title: 'Daten & Multimedia',
      blurb: 'Zeichensätze, Kompression, Datenmengen und Übertragungsraten',
      icon: Icons.perm_media_outlined,
      weight: 0.025,
    ),
    Topic(
      id: 'ki_grundlagen',
      areaId: 'a04',
      title: 'KI-Unterstützung',
      blurb: 'Einsatzfelder, Grenzen, Halluzinationen, Datenschutz bei KI',
      icon: Icons.auto_awesome_outlined,
      weight: 0.020,
    ),

    // ==================================================== 05 Qualitätssicherung
    Topic(
      id: 'qualitaetsmanagement',
      areaId: 'a05',
      title: 'Qualitätsmanagement',
      blurb: 'Konstruktive und analytische QS, PDCA, Qualitätsplanung',
      icon: Icons.fact_check_outlined,
      weight: 0.030,
    ),
    Topic(
      id: 'testen',
      areaId: 'a05',
      title: 'Testverfahren',
      blurb: 'Teststufen, Black-/White-Box, Testfälle, Testprotokoll',
      icon: Icons.bug_report_outlined,
      weight: 0.040,
    ),

    // ============================================ 06 IT-Sicherheit & Datenschutz
    Topic(
      id: 'schutzziele_bedrohungen',
      areaId: 'a06',
      title: 'Schutzziele & Bedrohungen',
      blurb: 'Vertraulichkeit, Integrität, Verfügbarkeit, Angriffsarten, BSI',
      icon: Icons.gpp_maybe_outlined,
      weight: 0.035,
    ),
    Topic(
      id: 'sicherheitsmassnahmen',
      areaId: 'a06',
      title: 'Technische Schutzmaßnahmen',
      blurb: 'Firewall, DMZ, Härtung, WLAN-Sicherheit, Backup, Berechtigungen',
      icon: Icons.security_outlined,
      weight: 0.030,
    ),
    Topic(
      id: 'kryptographie_auth',
      areaId: 'a06',
      title: 'Kryptographie & Authentifizierung',
      blurb: 'Symmetrisch/asymmetrisch, Hashverfahren, Zertifikate, 2FA',
      icon: Icons.key_outlined,
      weight: 0.025,
    ),
    Topic(
      id: 'datenschutz',
      areaId: 'a06',
      title: 'Datenschutz & DSGVO',
      blurb: 'Grundsätze, Betroffenenrechte, Anonymisierung, Pseudonymisierung',
      icon: Icons.privacy_tip_outlined,
      weight: 0.030,
    ),

    // ========================================= 07 Vertragsmanagement & Service
    Topic(
      id: 'vertraege',
      areaId: 'a07',
      title: 'Verträge & Recht',
      blurb: 'Kauf-, Werk-, Dienstvertrag, Lizenzen, Urheberrecht',
      icon: Icons.gavel_outlined,
      weight: 0.020,
    ),
    Topic(
      id: 'sla_service',
      areaId: 'a07',
      title: 'Service & SLA',
      blurb: 'Service Level Agreements, Support-Level, Eskalation, ITIL',
      icon: Icons.support_agent_outlined,
      weight: 0.015,
    ),
    Topic(
      id: 'leistungsstoerungen',
      areaId: 'a07',
      title: 'Leistungsstörungen & Abnahme',
      blurb: 'Verzug, Mängel, Gewährleistung, Abnahmeprotokoll, Soll-Ist',
      icon: Icons.assignment_late_outlined,
      weight: 0.015,
    ),
    Topic(
      id: 'change_management',
      areaId: 'a07',
      title: 'Change Management',
      blurb: 'Lewin-Modell, Kaizen, Widerstände, Change-Prozess',
      icon: Icons.published_with_changes_outlined,
      weight: 0.010,
    ),
  ];

  static final Map<String, Topic> map = {for (final t in all) t.id: t};

  static Topic byId(String id) => map[id] ?? all.first;

  /// Themen eines Bereichs in Katalogreihenfolge.
  static List<Topic> ofArea(String areaId) =>
      all.where((t) => t.areaId == areaId).toList(growable: false);
}
