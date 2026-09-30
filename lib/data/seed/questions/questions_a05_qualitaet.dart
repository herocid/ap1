import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 05 - Qualitätssicherung.
///
/// Ergänzt die Altaufgaben mit Lektionszuordnung aus `seed_qs_service.dart`
/// (qm-001..qm-004, te-001..te-005) und `seed_anforderungen.dart` (qr-003).
final List<Question> questionsA05 = [
  // ======================================== Qualität und Qualitätssicherung
  zuordnen('a5-qg-1', 'qm-grundlagen',
      prompt: 'Ordne die Prüfverfahren der statischen oder der dynamischen Prüfung zu.',
      buckets: ['Statisch (ohne Ausführung)', 'Dynamisch (mit Ausführung)'],
      items: [
        zu('Inspektion eines Entwurfsdokuments mit Checkliste', 0,
            'Ein Dokument wird gelesen und geprüft, nichts wird ausgeführt.'),
        zu('Walkthrough, bei dem die Autorin ihren Code dem Team erklärt', 0,
            'Der Code wird gemeinsam gelesen, nicht gestartet.'),
        zu('Ein Analysewerkzeug meldet eine nie genutzte Variable', 0,
            'Statische Codeanalyse untersucht den Quelltext ohne Ausführung.'),
        zu('Unit-Test, der eine Funktion mit Testdaten aufruft', 1,
            'Die Funktion wird tatsächlich ausgeführt.'),
        zu('Lasttest mit 1.000 simulierten Nutzern', 1,
            'Das laufende System wird unter Last beobachtet.'),
      ],
      explanation: 'Statische Prüfungen untersuchen ein Ergebnis, ohne es auszuführen - das geht auch mit Anforderungen und Entwürfen, lange bevor Code existiert. Dynamische Prüfungen, also Tests, führen das Programm aus.'),

  // ================================================== Qualitätsmerkmale
  zuordnen('a5-qe-1', 'qm-merkmale',
      scenario: 'Für eine neue Rechnungssoftware wurden Anforderungen gesammelt.',
      prompt: 'Ordne jede Anforderung dem Qualitätsmerkmal zu, das sie konkretisiert.',
      buckets: ['Effizienz', 'Benutzbarkeit', 'Wartbarkeit', 'Übertragbarkeit', 'Sicherheit'],
      items: [
        zu('Eine Rechnung wird in höchstens 1 s als PDF erzeugt.', 0,
            'Antwortzeit gehört zum Zeitverhalten, also zur Effizienz.'),
        zu('Neue Mitarbeitende erfassen nach 15 Minuten Einweisung eine Rechnung ohne Hilfe.', 1,
            'Erlernbarkeit ist ein Teil der Benutzbarkeit.'),
        zu('Ein neues Zahlungsverfahren lässt sich ergänzen, ohne bestehende Module zu ändern.', 2,
            'Änderbarkeit ist ein Teil der Wartbarkeit.'),
        zu('Die Software läuft ohne Anpassung unter Windows und macOS.', 3,
            'Betrieb in einer anderen Umgebung ist Übertragbarkeit.'),
        zu('Nur die Rolle Buchhaltung darf Rechnungen stornieren.', 4,
            'Schutz vor unbefugten Aktionen ist Sicherheit.'),
        zu('Bei 50 gleichzeitigen Nutzern belegt der Server höchstens 4 GB RAM.', 0,
            'Ressourcenverbrauch gehört ebenfalls zur Effizienz.'),
      ],
      explanation: 'Jede Anforderung wird über ihre Leitfrage eingeordnet: Wie schnell und sparsam (Effizienz)? Wie leicht zu bedienen (Benutzbarkeit)? Wie leicht zu ändern (Wartbarkeit)? Läuft sie anderswo (Übertragbarkeit)? Ist sie geschützt (Sicherheit)?'),
  einfach('a5-qe-2', 'qm-merkmale',
      scenario: 'Eine Zeiterfassungs-App berechnet die Arbeitszeiten stets korrekt. Sie stürzt aber etwa zweimal pro Woche ab, und ungespeicherte Eingaben gehen verloren.',
      prompt: 'Welches Qualitätsmerkmal ist vor allem verletzt?',
      choices: [
        ja('Zuverlässigkeit', 'Abstürze und Datenverlust zeigen, dass die App nicht stabil läuft.'),
        nein('Funktionalität', 'Die Berechnungen sind korrekt - die App tut das Richtige, nur nicht beständig.'),
        nein('Übertragbarkeit', 'Es geht nicht um den Betrieb in einer anderen Umgebung.'),
        nein('Wartbarkeit', 'Wartbarkeit betrifft die Änderbarkeit des Codes, nicht das Verhalten im Betrieb.'),
      ],
      explanation: 'Funktionalität fragt, ob die Software das Richtige tut. Zuverlässigkeit fragt, ob sie das dauerhaft und stabil tut. Korrekte Ergebnisse bei häufigen Abstürzen sind ein Zuverlässigkeitsproblem.'),
  einfach('a5-qe-3', 'qm-merkmale',
      prompt: 'Welche Anforderung an einen Webshop ist messbar und damit prüfbar formuliert?',
      choices: [
        ja('Die Produktseite lädt bei 500 gleichzeitigen Nutzern in höchstens 2 Sekunden.',
            'Messgröße, Zielwert und Bedingung sind genannt - ein Test kann eindeutig bestehen oder scheitern.'),
        nein('Der Shop soll möglichst schnell sein.', '„Möglichst schnell“ hat keinen Zielwert, jeder Test wäre Ansichtssache.'),
        nein('Die Bedienung soll intuitiv und modern wirken.', '„Intuitiv“ und „modern“ sind Empfindungen, keine Messgrößen.'),
        nein('Der Shop soll auch bei vielen Besuchern stabil laufen.', 'Wie viele Besucher und was „stabil“ heißt, bleibt offen.'),
      ],
      explanation: 'Eine prüfbare Anforderung nennt Merkmal, Messgröße, Zielwert und Bedingung. Nur dann lässt sich später im Test entscheiden, ob die Qualität erreicht ist.'),

  // ======================================================= PDCA und KVP
  zuordnen('a5-qp-1', 'qm-pdca',
      scenario: 'Eine Arztpraxis will die Wartezeit am Telefon senken und geht nach dem PDCA-Zyklus vor.',
      prompt: 'Ordne jeden Schritt der passenden Phase zu.',
      buckets: ['Plan', 'Do', 'Check', 'Act'],
      items: [
        zu('Ziel festlegen: Wartezeit unter 2 Minuten, Maßnahme: Online-Terminbuchung', 0,
            'Ziel mit Kennzahl und geplante Maßnahme gehören in die Planung.'),
        zu('Online-Terminbuchung vier Wochen lang für Kontrolltermine anbieten', 1,
            'Die Maßnahme wird im begrenzten Rahmen erprobt.'),
        zu('Gemessene Wartezeiten mit dem Ziel vergleichen', 2,
            'Soll-Ist-Vergleich ist die Aufgabe von Check.'),
        zu('Online-Buchung für alle Terminarten freigeben', 3,
            'Nach erfolgreichem Check wird die Maßnahme zum Standard.'),
        zu('Ursachen für lange Wartezeiten aus der Anrufstatistik ermitteln', 0,
            'Die Analyse des Problems ist Teil der Planung.'),
      ],
      explanation: 'Plan: analysieren, Ziel setzen, Maßnahme planen. Do: im Kleinen erproben. Check: Ergebnis gegen das Ziel prüfen. Act: bei Erfolg standardisieren, sonst nachbessern - dann beginnt der nächste Zyklus.'),
  einfach('a5-qp-2', 'qm-pdca',
      scenario: 'Ein Service-Desk hat ein Self-Service-Portal im Pilotbereich getestet. Im Check zeigt sich: Der Anteil der Passwort-Tickets sank nur von 30 % auf 25 %, Ziel waren unter 15 %.',
      prompt: 'Was ist in der Phase Act jetzt richtig?',
      choices: [
        ja('Ursachen analysieren, die Maßnahme anpassen und einen neuen Zyklus starten',
            'Das Ziel ist verfehlt - also wird nachgebessert und erneut erprobt.'),
        nein('Das Portal sofort für alle Abteilungen einführen', 'Eine Maßnahme, die ihr Ziel verfehlt hat, wird nicht zum Standard gemacht.'),
        nein('Den Zyklus beenden, weil die Maßnahme gescheitert ist', 'PDCA endet nicht, ein verfehltes Ziel ist Anlass für den nächsten Durchlauf.'),
        nein('Das Ziel nachträglich auf 25 % senken', 'Das Ziel an das Ergebnis anzupassen verbessert nichts, es verschleiert nur das Problem.'),
      ],
      explanation: 'Act hat zwei Ausgänge: Ziel erreicht -> Maßnahme wird Standard. Ziel verfehlt -> Ursachen klären, Maßnahme anpassen, neuer Zyklus. Genau dieses Weiterdrehen macht PDCA zum Werkzeug des KVP.'),

  // ============================================================ Teststufen
  einfach('a5-ss-1', 'ts-stufen',
      scenario: 'Das Bestellmodul eines Webshops soll getestet werden. Es ruft den Zahlungsdienst auf, der aber erst in drei Wochen fertig ist.',
      prompt: 'Womit wird der fehlende Zahlungsdienst im Test ersetzt?',
      choices: [
        ja('Mit einem Stub, der feste Antworten wie „Zahlung erfolgreich“ liefert',
            'Der Stub ersetzt eine Komponente, die vom Testobjekt aufgerufen wird.'),
        nein('Mit einem Testtreiber', 'Ein Testtreiber ersetzt den Aufrufer des Testobjekts, nicht die aufgerufene Komponente.'),
        nein('Mit einem Regressionstest', 'Das ist eine Testart, kein Platzhalter für fehlende Komponenten.'),
        nein('Gar nicht - das Modul kann erst nach Fertigstellung aller Teile getestet werden', 'Genau dafür gibt es Platzhalter: Komponenten lassen sich früh und isoliert testen.'),
      ],
      explanation: 'Stub und Testtreiber sind Platzhalter. Der Stub wird vom Testobjekt aufgerufen und ersetzt eine noch fehlende Komponente darunter. Der Testtreiber ruft das Testobjekt auf und ersetzt den fehlenden Aufrufer darüber.'),
  zuordnen('a5-ss-2', 'ts-stufen',
      prompt: 'Ordne jede Situation der passenden Teststufe zu.',
      buckets: ['Komponententest', 'Integrationstest', 'Systemtest', 'Abnahmetest'],
      items: [
        zu('Ein Entwickler prüft seine Funktion zur Berechnung der Mehrwertsteuer.', 0,
            'Eine einzelne Funktion wird isoliert geprüft.'),
        zu('Es wird geprüft, ob der Warenkorb die Daten korrekt an das Bestellmodul übergibt.', 1,
            'Im Fokus steht die Schnittstelle zwischen zwei Komponenten.'),
        zu('Das Testteam prüft den kompletten Shop in der Testumgebung gegen das Pflichtenheft.', 2,
            'Gesamtsystem gegen die Spezifikation, in der Verantwortung des Auftragnehmers.'),
        zu('Die Kundin prüft den Shop mit echten Artikeldaten und entscheidet über die Annahme.', 3,
            'Der Auftraggeber prüft und entscheidet - das ist die Abnahme.'),
      ],
      explanation: 'Der Prüfgegenstand wächst von Stufe zu Stufe: einzelne Komponente, Schnittstellen, Gesamtsystem, Abnahme durch den Auftraggeber. Entscheidend für die Abnahme ist, dass der Kunde selbst über die Annahme entscheidet.'),

  // ================================================ Black-Box und White-Box
  rechnen('a5-sv-1', 'ts-verfahren',
      scenario: 'Eine Funktion berechnet den Endpreis im Webshop. Die beiden Bedingungen sind voneinander unabhängig.\n'
          'rabatt = 0\n'
          'versand = 5\n'
          'WENN betrag > 100 DANN\n'
          '  rabatt = 5\n'
          'ENDE WENN\n'
          'WENN express = wahr DANN\n'
          '  versand = versand + 8\n'
          'ENDE WENN\n'
          'preis = betrag - rabatt + versand',
      prompt: 'Wie viele Testfälle braucht man mindestens für eine vollständige Zweigüberdeckung?',
      answer: 2,
      unit: 'Testfälle',
      difficulty: 3,
      explanation: 'Zweigüberdeckung heißt: Jeder Ja- und jeder Nein-Zweig wird mindestens einmal durchlaufen. Das sind 4 Zweige, aber ein Testfall deckt je Bedingung einen Zweig ab.\n'
          'Testfall 1: betrag = 150, express = wahr -> beide Ja-Zweige.\n'
          'Testfall 2: betrag = 50, express = falsch -> beide Nein-Zweige.\n'
          'Also 2 Testfälle. Für Anweisungsüberdeckung genügt schon Testfall 1. Alle 4 Kombinationen wären erst für eine Pfadüberdeckung nötig.'),
  mehrfach('a5-sv-2', 'ts-verfahren',
      prompt: 'Welche Aussagen zu manuellen und automatisierten Tests sind richtig?',
      choices: [
        ja('Automatisierte Tests lohnen sich besonders für Regressionstests nach jeder Änderung.',
            'Sie laufen beliebig oft ohne zusätzlichen Personalaufwand.'),
        ja('Die Bedienbarkeit einer Oberfläche wird sinnvoll mit echten Nutzern manuell getestet.',
            'Ob etwas verständlich ist, kann nur ein Mensch beurteilen.'),
        ja('Automatisierte Tests verursachen vor allem beim Erstellen und Pflegen Aufwand.',
            'Die Ausführung selbst kostet danach kaum noch Zeit.'),
        nein('Automatisierte Tests machen manuelle Tests vollständig überflüssig.',
            'Erkundende Tests und Usability-Tests bleiben Menschenarbeit.'),
        nein('Ein einmaliger Test, der nie wiederholt wird, sollte immer automatisiert werden.',
            'Der Aufwand für die Automatisierung lohnt sich erst durch häufige Wiederholung.'),
      ],
      explanation: 'Automatisierung rechnet sich über die Wiederholung: hoher Aufwand beim Erstellen, danach fast kostenlos. Manuelle Tests sind stark, wo menschliches Urteil gefragt ist, etwa bei Bedienbarkeit oder beim freien Erkunden.'),

  // ====================================================== Testfälle entwerfen
  einfach('a5-sf-1', 'ts-testfaelle',
      scenario: 'Ein Passwort muss 8 bis 64 Zeichen lang sein. Getestet wird nur die Länge.',
      prompt: 'Welche Passwortlängen decken alle Äquivalenzklassen mit je einem Repräsentanten ab?',
      choices: [
        ja('5, 20 und 70 Zeichen', 'Je ein Vertreter für „zu kurz“, „gültig“ und „zu lang“.'),
        nein('7, 8 und 64 Zeichen', 'Die ungültige Klasse „länger als 64“ fehlt.'),
        nein('20, 30 und 40 Zeichen', 'Alle drei liegen in derselben gültigen Klasse.'),
        nein('8, 64 und 65 Zeichen', 'Die ungültige Klasse „kürzer als 8“ fehlt.'),
      ],
      explanation: 'Es gibt drei Klassen: ungültig (unter 8), gültig (8 bis 64) und ungültig (über 64). Jede braucht einen Vertreter. Die Werte an den Grenzen sind Sache der Grenzwertanalyse - hier reicht je Klasse ein beliebiger Wert.'),
  rechnen('a5-sf-2', 'ts-testfaelle',
      scenario: 'In einem Webshop ist die Bestellmenge eine ganze Zahl. Erlaubt sind 1 bis 100 Stück: 1 bis 9 ohne Rabatt, 10 bis 49 mit 5 %, 50 bis 100 mit 10 %. Mengen unter 1 und über 100 werden abgelehnt.',
      prompt: 'Für die Grenzwertanalyse werden an jedem Übergang zwischen zwei benachbarten Klassen die beiden Werte direkt links und rechts des Übergangs getestet. Wie viele verschiedene Testwerte ergeben sich?',
      answer: 8,
      unit: 'Testwerte',
      difficulty: 3,
      explanation: 'Klassen: unter 1 | 1 bis 9 | 10 bis 49 | 50 bis 100 | über 100. Das ergibt 4 Übergänge mit je 2 Werten:\n'
          '- zwischen ungültig und 1 bis 9: 0 und 1\n'
          '- zwischen 1 bis 9 und 10 bis 49: 9 und 10\n'
          '- zwischen 10 bis 49 und 50 bis 100: 49 und 50\n'
          '- zwischen 50 bis 100 und ungültig: 100 und 101\n'
          '4 × 2 = 8 verschiedene Testwerte.'),
  zuordnen('a5-sf-3', 'ts-testfaelle',
      scenario: 'Im Webshop sind Bestellmengen von 1 bis 99 Stück als ganze Zahl erlaubt.',
      prompt: 'Gehört die eingegebene Menge zu einer gültigen oder einer ungültigen Äquivalenzklasse?',
      buckets: ['Gültige Klasse', 'Ungültige Klasse'],
      items: [
        zu('1', 0, 'Untere Grenze, liegt noch im erlaubten Bereich.'),
        zu('99', 0, 'Obere Grenze, liegt noch im erlaubten Bereich.'),
        zu('0', 1, 'Kleiner als 1.'),
        zu('100', 1, 'Größer als 99.'),
        zu('„zwei“', 1, 'Keine Zahl - eine eigene ungültige Klasse.'),
        zu('-5', 1, 'Negative Mengen liegen unter der Untergrenze.'),
      ],
      explanation: 'Gültig ist nur der Bereich 1 bis 99, die Grenzen eingeschlossen. Ungültige Klassen sind „zu klein“, „zu groß“ und „keine Zahl“. Grenzwerte wie 1 und 99 gehören zur gültigen Klasse, ihre Nachbarn 0 und 100 zur ungültigen.'),
  mehrfach('a5-sf-4', 'ts-testfaelle',
      prompt: 'Welche Aussagen zu Äquivalenzklassen und Grenzwertanalyse sind richtig?',
      choices: [
        ja('Aus jeder Äquivalenzklasse genügt ein Repräsentant.',
            'Laut Spezifikation verhält sich das Programm für alle Werte einer Klasse gleich.'),
        ja('Für jede ungültige Klasse wird ein eigener Testfall gebildet.',
            'Kombinierte ungültige Werte können sich gegenseitig verdecken.'),
        ja('Die Grenzwertanalyse ergänzt die Äquivalenzklassen um Werte an den Klassengrenzen.',
            'An den Rändern entstehen typische Fehler wie > statt >=.'),
        nein('Äquivalenzklassen werden aus dem Quellcode abgeleitet.',
            'Sie stammen aus der Spezifikation - es ist ein Black-Box-Verfahren.'),
        nein('Ungültige Klassen müssen nicht getestet werden, weil der Nutzer sie nicht eingeben soll.',
            'Gerade falsche Eingaben muss das Programm sauber abweisen.'),
      ],
      explanation: 'Äquivalenzklassen und Grenzwertanalyse sind Black-Box-Verfahren und ergänzen sich: Die Klassen sorgen dafür, dass jeder Fall einmal vorkommt, die Grenzwerte prüfen gezielt die Ränder, an denen Programmierfehler besonders häufig sind.'),

  // ============================================ Testplanung und Testprotokoll
  zuordnen('a5-sp-1', 'ts-protokoll',
      prompt: 'Gehört die Angabe in das Testkonzept (vor dem Test) oder in das Testprotokoll (bei der Durchführung)?',
      buckets: ['Testkonzept', 'Testprotokoll'],
      items: [
        zu('Endekriterien für den Testabschluss', 0,
            'Wann Schluss ist, muss vor dem Test feststehen.'),
        zu('Benötigte Testumgebung und Testdaten', 0,
            'Ressourcen werden vorab geplant.'),
        zu('Testobjekte und Testumfang', 0,
            'Was geprüft wird, legt die Planung fest.'),
        zu('Tatsächliches Ergebnis (Ist-Ergebnis)', 1,
            'Das Ist entsteht erst bei der Durchführung.'),
        zu('Datum und Name der Testerin', 1,
            'Wer wann getestet hat, wird bei der Durchführung notiert.'),
        zu('Festgestellte Abweichung vom Soll', 1,
            'Abweichungen zeigen sich erst beim Ausführen.'),
      ],
      explanation: 'Das Testkonzept plant: Ziele, Umfang, Testobjekte, Ressourcen, Termine und Endekriterien. Das Testprotokoll dokumentiert die Durchführung: wer, wann, welche Eingabe, Soll, Ist, Ergebnis und Abweichung.'),
  reihenfolge('a5-sp-2', 'ts-protokoll',
      prompt: 'Bringe die Schritte der Fehlerbehandlung in die richtige Reihenfolge.',
      items: [
        'Abweichung zwischen Soll und Ist im Testprotokoll festhalten',
        'Fehlermeldung mit Fehlerklasse und Priorität erfassen',
        'Fehler durch die Entwicklung beheben',
        'Nachtest des fehlgeschlagenen Testfalls',
        'Regressionstest der übrigen Funktionen',
        'Fehlermeldung schließen',
      ],
      hint: 'Beginne mit der Beobachtung im Test',
      explanation: 'Erst wird die Abweichung dokumentiert und als Fehler mit Klasse und Priorität gemeldet. Nach der Korrektur bestätigt der Nachtest die Behebung, der Regressionstest schließt Nebenwirkungen aus. Erst dann wird die Meldung geschlossen.'),
  einfach('a5-sp-3', 'ts-protokoll',
      scenario: 'Im Testprotokoll steht zu TF-017: Eingabe Bestellmenge 100, Soll „Meldung: Höchstens 99 Stück“, Ist „Bestellung angelegt“. Die Entwicklung meldet den Fehler als behoben.',
      prompt: 'Was ist der nächste Testschritt?',
      choices: [
        ja('TF-017 mit denselben Eingaben erneut ausführen (Nachtest)',
            'Nur so wird bestätigt, dass genau dieser Fehler wirklich behoben ist.'),
        nein('TF-017 als bestanden eintragen, weil die Entwicklung die Behebung gemeldet hat',
            'Ein Testergebnis beruht auf Durchführung, nicht auf einer Meldung.'),
        nein('Sofort den Abnahmetest mit dem Kunden starten',
            'Vorher muss feststehen, dass die Korrektur wirkt und nichts anderes beschädigt hat.'),
        nein('Das Soll-Ergebnis von TF-017 an das Ist-Ergebnis anpassen',
            'Das Soll kommt aus der Spezifikation und wird nicht an das Programm angepasst.'),
      ],
      explanation: 'Nach jeder Fehlerbehebung folgt der Nachtest: Der fehlgeschlagene Testfall wird mit denselben Daten wiederholt. Besteht er, prüft ein Regressionstest, ob die Korrektur Nebenwirkungen hat.'),
];
