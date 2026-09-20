import 'package:flutter/foundation.dart';

/// Ein Thema, das im Prüfungskatalog ab 2025 nicht mehr enthalten ist.
@immutable
class RemovedTopic {
  const RemovedTopic({
    required this.title,
    required this.note,
    this.stillRelevantFor,
  });

  final String title;

  /// Warum es weg ist bzw. was stattdessen gilt.
  final String note;

  /// Wo das Thema trotzdem noch gebraucht wird - damit niemand es voreilig
  /// aus dem Gedächtnis löscht.
  final String? stillRelevantFor;
}

/// Was der Katalog 2025 gestrichen hat.
///
/// Der Sinn dieser Liste: Wer mit einem Lehrbuch von 2022 oder mit
/// Altfragen lernt, verbringt sonst Wochen mit Stoff, der nicht mehr
/// abgefragt wird. Zu diesen Themen gibt es in der App bewusst keine
/// Aufgaben - nur diese Abgrenzung.
const List<RemovedTopic> kRemovedTopics = [
  RemovedTopic(
    title: 'SQL und Datenbankabfragen',
    note:
        'SELECT, JOIN, GROUP BY und Co. sind aus der AP1 verschwunden. '
        'Datenmodellierung (ER-Modell, Beziehungen, Normalisierung) bleibt.',
    stillRelevantFor: 'AP2 - dort wird SQL weiterhin geprüft.',
  ),
  RemovedTopic(
    title: 'Vorgehensmodelle außer Wasserfall und Scrum',
    note:
        'V-Modell, Spiralmodell, Extreme Programming und Kanban sind nicht '
        'mehr Teil des Katalogs. Gefordert sind nur noch das Wasserfallmodell '
        'und Scrum.',
    stillRelevantFor:
        'Die Teststufen aus dem V-Modell (Modul-, Integrations-, System-, '
        'Abnahmetest) bleiben im Bereich Qualitätssicherung relevant.',
  ),
  RemovedTopic(
    title: 'Struktogramm und Programmablaufplan (PAP)',
    note:
        'Die klassischen Ablaufdarstellungen sind gestrichen. Programmlogik '
        'wird jetzt über Pseudocode und das UML-Aktivitätsdiagramm geprüft.',
    stillRelevantFor: 'UML-Aktivitätsdiagramm - neu im Katalog 2025.',
  ),
  RemovedTopic(
    title: 'Vererbung in der Objektorientierung',
    note:
        'Vererbung, Polymorphie und abstrakte Klassen sind raus. Klasse, '
        'Objekt, Attribut, Methode und Kapselung bleiben.',
    stillRelevantFor: 'AP2 und die tägliche Programmierarbeit.',
  ),
  RemovedTopic(
    title: 'RAID und SAN',
    note:
        'RAID-Level und Storage Area Networks werden nicht mehr abgefragt. '
        'NAS wird im Katalog noch erwähnt.',
  ),
  RemovedTopic(
    title: 'LTE und 5G',
    note:
        'Mobilfunkstandards sind gestrichen. Netzwerktechnik konzentriert '
        'sich auf LAN/WLAN, IPv4/IPv6 und die gängigen Protokolle.',
  ),
  RemovedTopic(
    title: 'SWOT-Analyse',
    note:
        'Die SWOT-Matrix ist raus. Nutzwertanalyse, ABC-Analyse und '
        'Angebotsvergleich bleiben - genau diese werden gerechnet.',
  ),
  RemovedTopic(
    title: 'ISO-Normen (z. B. ISO 2700x)',
    note:
        'Normnummern müssen nicht mehr auswendig gelernt werden. Die '
        'Inhalte dahinter - Schutzziele, Maßnahmen, BSI-Grundschutz - sind '
        'weiterhin Prüfungsstoff.',
  ),
  RemovedTopic(
    title: 'Softwarequalitätskriterien als eigener Katalog',
    note:
        'Die Merkmalslisten (z. B. nach ISO 25010) sind als abzufragender '
        'Katalog gestrichen. Qualitätssicherung als Vorgehen bleibt.',
  ),
  RemovedTopic(
    title: 'Nicht-relationale Datenbanken',
    note: 'NoSQL-Konzepte sind nicht mehr Teil der AP1.',
  ),
  RemovedTopic(
    title: 'Dokumentationsarten',
    note:
        'Benutzer-, Programmier- und Netzwerkdokumentation als eigener '
        'Prüfungsgegenstand sind gestrichen. Dokumentation im Rahmen von '
        'Projektabschluss und Abnahme bleibt.',
  ),
];

/// Was 2025 neu hinzugekommen ist - der Gegenteil-Blick zur Liste oben.
const List<RemovedTopic> kAddedTopics = [
  RemovedTopic(
    title: 'KI-Unterstützung und KI-Software',
    note:
        'Einsatzmöglichkeiten, Grenzen und Risiken von KI-Werkzeugen im '
        'Arbeitsalltag - einschließlich Datenschutz und Halluzinationen.',
  ),
  RemovedTopic(
    title: 'SMART-Prinzip für Projektziele',
    note: 'Spezifisch, messbar, attraktiv, realistisch, terminiert.',
  ),
  RemovedTopic(
    title: 'Schutzziele Vertraulichkeit, Verfügbarkeit, Integrität',
    note: 'Die Schutzziele werden ausdrücklich genannt und abgefragt.',
  ),
  RemovedTopic(
    title: 'Hashverfahren und Zwei-Faktor-Authentifizierung',
    note: 'Hashes, ihre Eigenschaften und 2FA als Authentifizierungsverfahren.',
  ),
  RemovedTopic(
    title: 'Härtung von Betriebssystemen',
    note: 'Angriffsfläche reduzieren: Dienste abschalten, Rechte begrenzen, '
        'Updates einspielen.',
  ),
  RemovedTopic(
    title: 'Barrierefreiheit auf Websites',
    note: 'Anforderungen an barrierefreie Gestaltung und ihre Umsetzung.',
  ),
  RemovedTopic(
    title: 'ERP-, SCM- und CRM-Systeme',
    note: 'Betriebliche Anwendungssysteme und ihre Einsatzzwecke.',
  ),
  RemovedTopic(
    title: 'Social-Media-Systeme',
    note: 'Betrieblicher Einsatz und Abgrenzung der Plattformarten.',
  ),
  RemovedTopic(
    title: 'IPv4 und IPv6',
    note: 'Aufbau, Unterschiede, Adressierung und Subnetting.',
  ),
  RemovedTopic(
    title: 'UML-Aktivitätsdiagramm',
    note: 'Ersetzt Struktogramm und PAP als Darstellung von Abläufen.',
  ),
  RemovedTopic(
    title: 'Fehlersuche im Code und Schreibtischtest',
    note:
        'Gegebenen Code Zeile für Zeile durchgehen und Fehler finden - ein '
        'Aufgabentyp, der in der AP1 häufig vorkommt.',
  ),
  RemovedTopic(
    title: 'Betroffenenrechte nach DSGVO',
    note: 'Auskunft, Berichtigung, Löschung, Einschränkung, '
        'Datenübertragbarkeit, Widerspruch.',
  ),
  RemovedTopic(
    title: 'Anonymisierung und Pseudonymisierung',
    note: 'Der Unterschied und wann welches Verfahren zulässig ist.',
  ),
  RemovedTopic(
    title: 'Übertragungsraten und Datenmengen berechnen',
    note: 'Bit/Byte, Präfixe, Dauer einer Übertragung - reine Rechenaufgaben.',
  ),
  RemovedTopic(
    title: 'HDD und SSD unterscheiden',
    note: 'Aufbau, Geschwindigkeit, Lebensdauer, Einsatzzweck.',
  ),
];
