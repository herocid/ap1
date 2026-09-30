import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 05 - Qualitätssicherung.
final List<Flashcard> cardsA05 = [
  // Qualität und Qualitätssicherung
  karte('k-qg-1', 'qm-grundlagen', 'Qualität',
      'Grad, in dem ein Produkt die vereinbarten Anforderungen erfüllt.'),
  karte('k-qg-2', 'qm-grundlagen', 'Konstruktive vs. analytische QS',
      'Konstruktiv verhindert Fehler (Styleguide, Schulung). Analytisch findet Fehler (Test, Review).'),
  karte('k-qg-3', 'qm-grundlagen', 'Statische vs. dynamische Prüfung',
      'Statisch: ohne Ausführung (Review, Inspektion, Codeanalyse). Dynamisch: Programm wird ausgeführt (Test).'),
  karte('k-qg-4', 'qm-grundlagen', 'Walkthrough vs. Inspektion',
      'Walkthrough: informell, der Autor führt durch. Inspektion: formal mit Moderator, Rollen, Checkliste und Protokoll.'),
  karte('k-qg-5', 'qm-grundlagen', 'Zehnerregel',
      'Fehlerkosten verzehnfachen sich grob mit jeder Phase, die ein Fehler unentdeckt bleibt.'),

  // Qualitätsmerkmale
  karte('k-qe-1', 'qm-merkmale', 'Zuverlässigkeit',
      'Die Software läuft stabil, verträgt Störungen und ist verfügbar, wenn sie gebraucht wird.'),
  karte('k-qe-2', 'qm-merkmale', 'Benutzbarkeit',
      'Wie leicht die Software zu erlernen und zu bedienen ist.'),
  karte('k-qe-3', 'qm-merkmale', 'Effizienz',
      'Zeitverhalten und Ressourcenverbrauch, z. B. Antwortzeit oder Speicherbedarf.'),
  karte('k-qe-4', 'qm-merkmale', 'Wartbarkeit vs. Übertragbarkeit',
      'Wartbarkeit: leicht zu ändern und zu korrigieren. Übertragbarkeit: läuft auch in anderer Umgebung.'),
  karte('k-qe-5', 'qm-merkmale', 'Messbare Anforderung',
      'Merkmal, Messgröße, Zielwert und Bedingung - z. B. max. 2 s bei 200 Nutzern.'),

  // PDCA
  karte('k-qp-1', 'qm-pdca', 'PDCA',
      'Plan, Do, Check, Act - der Deming-Kreis für schrittweise Verbesserung.'),
  karte('k-qp-2', 'qm-pdca', 'Was passiert in „Do“?',
      'Die geplante Maßnahme wird im kleinen Rahmen erprobt, etwa als Pilot.'),
  karte('k-qp-3', 'qm-pdca', 'Was passiert in „Act“?',
      'Bei Erfolg wird die Maßnahme zum Standard, sonst angepasst. Danach beginnt der nächste Zyklus.'),
  karte('k-qp-4', 'qm-pdca', 'KVP',
      'Kontinuierlicher Verbesserungsprozess: viele kleine, stetige Verbesserungen unter Beteiligung der Mitarbeitenden.'),

  // Teststufen
  karte('k-ss-1', 'ts-stufen', 'Die vier Teststufen',
      'Komponententest, Integrationstest, Systemtest, Abnahmetest.'),
  karte('k-ss-2', 'ts-stufen', 'Integrationstest',
      'Prüft die Schnittstellen und das Zusammenspiel mehrerer Komponenten.'),
  karte('k-ss-3', 'ts-stufen', 'Systemtest vs. Abnahmetest',
      'Systemtest: Auftragnehmer prüft gegen die Spezifikation. Abnahmetest: Auftraggeber prüft gegen seine Anforderungen.'),
  karte('k-ss-4', 'ts-stufen', 'Stub vs. Testtreiber',
      'Stub ersetzt eine aufgerufene Komponente. Testtreiber ersetzt den Aufrufer.'),
  karte('k-ss-5', 'ts-stufen', 'Regressionstest',
      'Wiederholt bestandene Tests nach einer Änderung, um Nebenwirkungen zu finden.'),

  // Black-Box und White-Box
  karte('k-sv-1', 'ts-verfahren', 'Black-Box-Test',
      'Testfälle aus der Spezifikation, ohne Kenntnis des Codes.'),
  karte('k-sv-2', 'ts-verfahren', 'White-Box-Test',
      'Testfälle aus der Codestruktur, gemessen mit Überdeckungsmaßen.'),
  karte('k-sv-3', 'ts-verfahren', 'Anweisungs- vs. Zweigüberdeckung',
      'Anweisung: jede Anweisung einmal ausgeführt. Zweig: jeder Zweig einmal, auch leere Nein-Zweige.'),
  karte('k-sv-4', 'ts-verfahren', 'Grey-Box-Test',
      'Test gegen die Spezifikation mit Teilwissen über den inneren Aufbau.'),
  karte('k-sv-5', 'ts-verfahren', 'Wann automatisieren?',
      'Wenn Tests oft wiederholt werden, etwa als Regressionstest nach jeder Änderung.'),

  // Testfälle entwerfen
  karte('k-sf-1', 'ts-testfaelle', 'Äquivalenzklasse',
      'Menge von Eingaben, bei denen sich das Programm laut Spezifikation gleich verhält.'),
  karte('k-sf-2', 'ts-testfaelle', 'Grenzwertanalyse',
      'Testet gezielt an den Klassengrenzen: den Grenzwert und seine direkten Nachbarn.'),
  karte('k-sf-3', 'ts-testfaelle', 'Grenzwerte für 1 bis 99',
      'Grenzwert und Nachbar außerhalb: 0, 1, 99, 100.',
      'Mit Nachbarn innerhalb zusätzlich 2 und 98.'),
  karte('k-sf-4', 'ts-testfaelle', 'Bestandteile eines Testfalls',
      'Kennung, Vorbedingung, Eingabe, erwartetes Ergebnis.'),
  karte('k-sf-5', 'ts-testfaelle', 'Ungültige Klassen kombinieren?',
      'Nein - je ungültige Klasse ein eigener Testfall, sonst verdeckt ein Fehler den anderen.'),

  // Testplanung und Testprotokoll
  karte('k-sp-1', 'ts-protokoll', 'Inhalt eines Testkonzepts',
      'Ziele, Umfang, Testobjekte, Ressourcen, Termine und Endekriterien.'),
  karte('k-sp-2', 'ts-protokoll', 'Endekriterium',
      'Vorab festgelegte, messbare Bedingung, wann der Test abgeschlossen ist.'),
  karte('k-sp-3', 'ts-protokoll', 'Felder im Testprotokoll',
      'Testfall-ID, Datum, Tester, Eingabe, Soll, Ist, Ergebnis, Abweichung.'),
  karte('k-sp-4', 'ts-protokoll', 'Nachtest vs. Regressionstest',
      'Nachtest prüft die Korrektur selbst. Regressionstest prüft, ob sie anderes beschädigt hat.'),
  karte('k-sp-5', 'ts-protokoll', 'Fehlerklasse vs. Priorität',
      'Klasse: wie schwer der Fehler wiegt. Priorität: wie dringend er behoben wird.'),
];
