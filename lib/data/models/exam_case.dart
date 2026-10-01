import 'package:flutter/foundation.dart';

import 'question.dart';

/// Ein Modellunternehmen der Prüfungssimulation.
///
/// Wie in der echten AP1 hängen alle vier Aufgaben einer Prüfung an EINEM
/// Unternehmen. Die Simulation wählt deshalb erst ein Unternehmen und dann
/// vier Fallaufgaben, die dafür geschrieben sind.
@immutable
class ExamCompany {
  const ExamCompany({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;

  /// Ausgangssituation, die auf dem Deckblatt der Prüfung steht.
  final String description;
}

class ExamCompanies {
  const ExamCompanies._();

  static const all = <ExamCompany>[
    ExamCompany(
      id: 'systemhaus',
      name: 'Kessler & Brandt IT-Systemhaus GmbH',
      description:
          'Die Kessler & Brandt IT-Systemhaus GmbH in Bremen betreut mit 45 '
          'Mitarbeitenden kleine und mittlere Unternehmen der Region: '
          'Beratung, Beschaffung, Einrichtung von Arbeitsplätzen und Netzen '
          'sowie laufender Support. Du bist dort in der Ausbildung und '
          'arbeitest im Team Kundenprojekte mit. Aktueller Kunde ist die '
          'Steuerkanzlei Albers & Partner mit 18 Beschäftigten, die neue '
          'Büroräume bezieht und ihre IT erneuern lässt.',
    ),
    ExamCompany(
      id: 'handel',
      name: 'Grünwerk Gartenbedarf GmbH',
      description:
          'Die Grünwerk Gartenbedarf GmbH aus Kassel verkauft Gartenmöbel, '
          'Werkzeug und Pflanzen über einen Webshop und drei Filialen. Von '
          'den 120 Mitarbeitenden arbeiten 8 in der eigenen IT-Abteilung, '
          'in der du deine Ausbildung machst. Das Unternehmen eröffnet eine '
          'vierte Filiale in Göttingen und stattet zugleich 20 '
          'Beschäftigte aus Einkauf und Kundenservice für mobiles Arbeiten '
          'aus.',
    ),
    ExamCompany(
      id: 'agentur',
      name: 'Pixelhafen Medien GmbH',
      description:
          'Die Pixelhafen Medien GmbH ist eine Agentur für Webdesign und '
          'Onlinemarketing in Leipzig mit 30 Mitarbeitenden. Sie entwickelt '
          'Websites und kleine Webanwendungen für Kunden und betreibt ihre '
          'eigene IT mit zwei Administratoren, die du als Auszubildende/r '
          'unterstützt. Die Agentur führt ein neues Ticketsystem für '
          'Kundenanfragen ein und rüstet die Arbeitsplätze der Grafik '
          'auf.',
    ),
    ExamCompany(
      id: 'logistik',
      name: 'Elbtal Logistik AG',
      description:
          'Die Elbtal Logistik AG betreibt in Magdeburg ein Lager- und '
          'Umschlagzentrum mit 300 Beschäftigten im Dreischichtbetrieb. Die '
          'IT-Abteilung (12 Personen), in der du ausgebildet wirst, '
          'verantwortet die Verwaltungsarbeitsplätze, das Lagernetz mit '
          'mobilen Handscannern und die Anbindung der Disposition. Das '
          'Unternehmen modernisiert die Arbeitsplätze der Disposition und '
          'bindet eine neue Lagerhalle an.',
    ),
  ];

  static ExamCompany byId(String id) =>
      all.firstWhere((c) => c.id == id, orElse: () => all.first);
}

/// Eine Fallaufgabe im IHK-Stil: eine Situation, mehrere Teilaufgaben,
/// zusammen 25 Punkte - genau eine der vier Aufgaben einer AP1.
@immutable
class ExamCase {
  const ExamCase({
    required this.id,
    required this.companyId,
    required this.areaId,
    required this.title,
    required this.situation,
    required this.parts,
  });

  final String id;

  /// [ExamCompany.id] - für welches Modellunternehmen der Fall geschrieben
  /// ist.
  final String companyId;

  /// Katalogbereich `a01` ... `a07` (Schwerpunkt des Falls).
  final String areaId;

  /// Kurzer Titel, z. B. "Netzwerk der neuen Filiale planen".
  final String title;

  /// Situation dieser Aufgabe (2-5 Sätze), aufbauend auf der Beschreibung
  /// des Unternehmens.
  final String situation;

  /// Teilaufgaben a), b), c) ... in Bearbeitungsreihenfolge.
  final List<Question> parts;

  ExamCompany get company => ExamCompanies.byId(companyId);

  int get points => parts.fold(0, (s, q) => s + q.points);
}
