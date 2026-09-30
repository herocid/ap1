import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 05 - Qualitätssicherung.
///
/// Ergänzt die Altaufgaben mit Lektionszuordnung aus `seed_qs_service.dart`
/// (qm-001..qm-004, te-001..te-005) und `seed_anforderungen.dart` (qr-003).
final List<Question> questionsA05 = [
  // ======================================== Qualität und Qualitätssicherung
  zuordnen(
    'a5-qg-1',
    'qm-grundlagen',
    prompt:
        'Ordne die Prüfverfahren der statischen oder der dynamischen Prüfung zu.',
    buckets: ['Statisch (ohne Ausführung)', 'Dynamisch (mit Ausführung)'],
    items: [
      zu(
        'Inspektion eines Entwurfsdokuments mit Checkliste',
        0,
        'Ein Dokument wird gelesen und geprüft, nichts wird ausgeführt.',
      ),
      zu(
        'Walkthrough, bei dem die Autorin ihren Code dem Team erklärt',
        0,
        'Der Code wird gemeinsam gelesen, nicht gestartet.',
      ),
      zu(
        'Ein Analysewerkzeug meldet eine nie genutzte Variable',
        0,
        'Statische Codeanalyse untersucht den Quelltext ohne Ausführung.',
      ),
      zu(
        'Unit-Test, der eine Funktion mit Testdaten aufruft',
        1,
        'Die Funktion wird tatsächlich ausgeführt.',
      ),
      zu(
        'Lasttest mit 1.000 simulierten Nutzern',
        1,
        'Das laufende System wird unter Last beobachtet.',
      ),
    ],
    explanation:
        'Statische Prüfungen untersuchen ein Ergebnis, ohne es auszuführen - das geht auch mit Anforderungen und Entwürfen, lange bevor Code existiert. Dynamische Prüfungen, also Tests, führen das Programm aus.',
  ),
  zuordnen(
    'a5-qg-2',
    'qm-grundlagen',
    prompt: 'Geht es um Verifikation oder um Validierung?',
    buckets: ['Verifikation', 'Validierung'],
    items: [
      zu(
        'Der Systemtest prüft, ob alle Punkte des Pflichtenhefts umgesetzt sind.',
        0,
        'Maßstab ist die Spezifikation: Wurde das Produkt richtig gebaut?',
      ),
      zu(
        'Anwender probieren im Abnahmetest, ob die Software ihre Arbeit wirklich erleichtert.',
        1,
        'Maßstab ist der Bedarf: Ist es das richtige Produkt?',
      ),
      zu(
        'Ein Code-Review prüft die Einhaltung der Programmierrichtlinien.',
        0,
        'Geprüft wird gegen Vorgaben, nicht gegen den Kundennutzen.',
      ),
      zu(
        'Ein Klick-Prototyp wird Nutzern gezeigt, um zu prüfen, ob die Idee ihren Bedarf trifft.',
        1,
        'Frühe Validierung, bevor viel Aufwand in die falsche Richtung fließt.',
      ),
    ],
    explanation:
        'Verifikation fragt „Bauen wir das Produkt richtig?“ und prüft gegen die Spezifikation. Validierung fragt „Bauen wir das richtige Produkt?“ und prüft gegen den tatsächlichen Bedarf des Kunden.',
  ),
  rechnen(
    'a5-qg-3',
    'qm-grundlagen',
    scenario:
        'Die Korrektur eines Anforderungsfehlers kostet in der Anforderungsphase 50 €. Nach der Zehnerregel verzehnfachen sich die Kosten mit jeder weiteren Phase.',
    prompt:
        'Was kostet die Korrektur, wenn der Fehler erst drei Phasen später gefunden wird?',
    answer: 50000,
    unit: '€',
    explanation:
        'Jede Phase verzehnfacht die Kosten:\n'
        '50 € × 10 = 500 € (1 Phase später)\n'
        '500 € × 10 = 5.000 € (2 Phasen später)\n'
        '5.000 € × 10 = 50.000 € (3 Phasen später)\n'
        'Kurz: 50 € × 10³ = 50.000 €.',
  ),
  einfach(
    'a5-qg-4',
    'qm-grundlagen',
    prompt: 'Welche Review-Art ist am stärksten formalisiert?',
    choices: [
      ja(
        'Inspektion',
        'Mit Moderator, festen Rollen, Checkliste und Protokoll.',
      ),
      nein('Walkthrough', 'Der Autor führt informell durch sein Ergebnis.'),
      nein(
        'Informelles Review',
        'Eine Kollegin liest gegen - ohne feste Regeln und Protokoll.',
      ),
      nein(
        'Schreibtischtest',
        'Eine gedankliche Programmausführung, kein Review im Team.',
      ),
    ],
    explanation:
        'Reviews reichen vom informellen Gegenlesen über Walkthrough und technisches Review bis zur Inspektion - der formalsten Form mit Moderator, Rollen, Checklisten und Protokoll.',
  ),
  einfach(
    'a5-qg-5',
    'qm-grundlagen',
    prompt: 'Welche Maßnahme gehört zur konstruktiven Qualitätssicherung?',
    choices: [
      ja(
        'Verbindliche Namenskonventionen für Variablen und Klassen einführen',
        'Sie beugen Fehlern und Unklarheiten vor, bevor Code entsteht.',
      ),
      nein(
        'Eine Code-Inspektion nach Fertigstellung des Moduls',
        'Analytisch: Ein fertiges Ergebnis wird geprüft.',
      ),
      nein(
        'Ein Lasttest mit 1.000 simulierten Nutzern',
        'Analytisch und dynamisch: Das System wird ausgeführt.',
      ),
      nein(
        'Der Abnahmetest durch den Kunden',
        'Analytisch: Es wird geprüft, nicht vorgebeugt.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Konstruktive QS verhindert Fehler (Richtlinien, Vorlagen, Schulung, Werkzeuge). Analytische QS findet Fehler in fertigen Ergebnissen (Reviews, Inspektionen, Tests).',
  ),
  mehrfach(
    'a5-qg-6',
    'qm-grundlagen',
    prompt: 'Welche Aussagen zur Qualitätssicherung sind richtig?',
    choices: [
      ja(
        'Tests können das Vorhandensein von Fehlern zeigen, nicht ihre Abwesenheit.',
        'Kein Test deckt alle Eingaben ab - fehlerfrei lässt sich nicht beweisen.',
      ),
      ja(
        'Anforderungen lassen sich prüfen, bevor Code existiert.',
        'Reviews von Dokumenten sind statische Prüfungen.',
      ),
      ja(
        'Je später ein Fehler gefunden wird, desto teurer ist seine Behebung.',
        'Das beschreibt die Zehnerregel.',
      ),
      nein(
        'Ein bestandener Systemtest beweist, dass die Software fehlerfrei ist.',
        'Er zeigt nur, dass die geprüften Fälle funktionieren.',
      ),
      nein(
        'Statische Prüfungen setzen lauffähigen Code voraus.',
        'Statisch heißt gerade: ohne Ausführung.',
      ),
    ],
    explanation:
        'Qualität entsteht nicht durch eine Endkontrolle: Konstruktive Maßnahmen und frühe statische Prüfungen sparen die teuren späten Fehler. Tests zeigen Fehler, beweisen aber nie Fehlerfreiheit.',
  ),

  // ================================================== Qualitätsmerkmale
  zuordnen(
    'a5-qe-1',
    'qm-merkmale',
    scenario: 'Für eine neue Rechnungssoftware wurden Anforderungen gesammelt.',
    prompt:
        'Ordne jede Anforderung dem Qualitätsmerkmal zu, das sie konkretisiert.',
    buckets: [
      'Effizienz',
      'Benutzbarkeit',
      'Wartbarkeit',
      'Übertragbarkeit',
      'Sicherheit',
    ],
    items: [
      zu(
        'Eine Rechnung wird in höchstens 1 s als PDF erzeugt.',
        0,
        'Antwortzeit gehört zum Zeitverhalten, also zur Effizienz.',
      ),
      zu(
        'Neue Mitarbeitende erfassen nach 15 Minuten Einweisung eine Rechnung ohne Hilfe.',
        1,
        'Erlernbarkeit ist ein Teil der Benutzbarkeit.',
      ),
      zu(
        'Ein neues Zahlungsverfahren lässt sich ergänzen, ohne bestehende Module zu ändern.',
        2,
        'Änderbarkeit ist ein Teil der Wartbarkeit.',
      ),
      zu(
        'Die Software läuft ohne Anpassung unter Windows und macOS.',
        3,
        'Betrieb in einer anderen Umgebung ist Übertragbarkeit.',
      ),
      zu(
        'Nur die Rolle Buchhaltung darf Rechnungen stornieren.',
        4,
        'Schutz vor unbefugten Aktionen ist Sicherheit.',
      ),
      zu(
        'Bei 50 gleichzeitigen Nutzern belegt der Server höchstens 4 GB RAM.',
        0,
        'Ressourcenverbrauch gehört ebenfalls zur Effizienz.',
      ),
    ],
    explanation:
        'Jede Anforderung wird über ihre Leitfrage eingeordnet: Wie schnell und sparsam (Effizienz)? Wie leicht zu bedienen (Benutzbarkeit)? Wie leicht zu ändern (Wartbarkeit)? Läuft sie anderswo (Übertragbarkeit)? Ist sie geschützt (Sicherheit)?',
  ),
  einfach(
    'a5-qe-2',
    'qm-merkmale',
    scenario:
        'Eine Zeiterfassungs-App berechnet die Arbeitszeiten stets korrekt. Sie stürzt aber etwa zweimal pro Woche ab, und ungespeicherte Eingaben gehen verloren.',
    prompt: 'Welches Qualitätsmerkmal ist vor allem verletzt?',
    choices: [
      ja(
        'Zuverlässigkeit',
        'Abstürze und Datenverlust zeigen, dass die App nicht stabil läuft.',
      ),
      nein(
        'Funktionalität',
        'Die Berechnungen sind korrekt - die App tut das Richtige, nur nicht beständig.',
      ),
      nein(
        'Übertragbarkeit',
        'Es geht nicht um den Betrieb in einer anderen Umgebung.',
      ),
      nein(
        'Wartbarkeit',
        'Wartbarkeit betrifft die Änderbarkeit des Codes, nicht das Verhalten im Betrieb.',
      ),
    ],
    explanation:
        'Funktionalität fragt, ob die Software das Richtige tut. Zuverlässigkeit fragt, ob sie das dauerhaft und stabil tut. Korrekte Ergebnisse bei häufigen Abstürzen sind ein Zuverlässigkeitsproblem.',
  ),
  einfach(
    'a5-qe-3',
    'qm-merkmale',
    prompt:
        'Welche Anforderung an einen Webshop ist messbar und damit prüfbar formuliert?',
    choices: [
      ja(
        'Die Produktseite lädt bei 500 gleichzeitigen Nutzern in höchstens 2 Sekunden.',
        'Messgröße, Zielwert und Bedingung sind genannt - ein Test kann eindeutig bestehen oder scheitern.',
      ),
      nein(
        'Der Shop soll möglichst schnell sein.',
        '„Möglichst schnell“ hat keinen Zielwert, jeder Test wäre Ansichtssache.',
      ),
      nein(
        'Die Bedienung soll intuitiv und modern wirken.',
        '„Intuitiv“ und „modern“ sind Empfindungen, keine Messgrößen.',
      ),
      nein(
        'Der Shop soll auch bei vielen Besuchern stabil laufen.',
        'Wie viele Besucher und was „stabil“ heißt, bleibt offen.',
      ),
    ],
    explanation:
        'Eine prüfbare Anforderung nennt Merkmal, Messgröße, Zielwert und Bedingung. Nur dann lässt sich später im Test entscheiden, ob die Qualität erreicht ist.',
  ),
  rechnen(
    'a5-qe-4',
    'qm-merkmale',
    scenario:
        'Für ein Kundenportal ist eine Verfügbarkeit von 99,9 % pro Monat vereinbart. Der Monat wird mit 30 Tagen gerechnet, das Portal läuft rund um die Uhr.',
    prompt:
        'Wie viele Minuten darf das Portal pro Monat höchstens ausfallen? (eine Nachkommastelle)',
    answer: 43.2,
    tolerance: 0.05,
    unit: 'min',
    explanation:
        'Stunden im Monat: 30 × 24 h = 720 h\n'
        'Erlaubte Ausfallquote: 100 % - 99,9 % = 0,1 % = 0,001\n'
        'Ausfallzeit: 720 h × 0,001 = 0,72 h\n'
        'In Minuten: 0,72 × 60 = 43,2 min',
  ),
  zuordnen(
    'a5-qe-5',
    'qm-merkmale',
    prompt: 'Welchem Qualitätsmerkmal gehört die Anforderung an?',
    buckets: ['Zuverlässigkeit', 'Wartbarkeit', 'Kompatibilität'],
    items: [
      zu(
        'Nach einem Stromausfall startet der Dienst selbstständig und ohne Datenverlust neu.',
        0,
        'Wiederherstellbarkeit ist ein Teilmerkmal der Zuverlässigkeit.',
      ),
      zu(
        'Fällt ein Server im Cluster aus, läuft der Dienst ohne Unterbrechung weiter.',
        0,
        'Fehlertoleranz gehört zur Zuverlässigkeit.',
      ),
      zu(
        'Der Code ist in unabhängige Module gegliedert, die einzeln getestet werden können.',
        1,
        'Modularität und Testbarkeit sind Teil der Wartbarkeit.',
      ),
      zu(
        'Aussagekräftige Logdateien grenzen einen Fehler schnell ein.',
        1,
        'Analysierbarkeit gehört zur Wartbarkeit.',
      ),
      zu(
        'Kundendaten werden über eine REST-Schnittstelle mit dem CRM ausgetauscht.',
        2,
        'Interoperabilität ist ein Teilmerkmal der Kompatibilität.',
      ),
      zu(
        'Die Anwendung läuft auf demselben Server wie die Buchhaltung, ohne sie zu stören.',
        2,
        'Koexistenz gehört zur Kompatibilität.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Die Teilmerkmale helfen bei der Zuordnung: Zuverlässigkeit (Reife, Verfügbarkeit, Fehlertoleranz, Wiederherstellbarkeit), Wartbarkeit (Modularität, Analysierbarkeit, Änderbarkeit, Testbarkeit), Kompatibilität (Interoperabilität, Koexistenz).',
  ),
  einfach(
    'a5-qe-6',
    'qm-merkmale',
    prompt: 'Welche Anforderung ist nicht funktional?',
    choices: [
      ja(
        'Die Suche liefert Ergebnisse in höchstens 2 Sekunden.',
        'Sie beschreibt, WIE GUT das System arbeitet (Effizienz).',
      ),
      nein(
        'Kunden können Artikel in den Warenkorb legen.',
        'Eine Funktion - WAS das System tut.',
      ),
      nein(
        'Das System erstellt monatlich eine Umsatzstatistik.',
        'Eine Funktion des Systems.',
      ),
      nein(
        'Kunden können ihr Passwort selbst zurücksetzen.',
        'Auch das ist eine Funktion.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Funktionale Anforderungen beschreiben, WAS ein System tun soll. Nicht funktionale Anforderungen beschreiben, WIE GUT es das tun soll - Antwortzeit, Verfügbarkeit, Bedienbarkeit, Sicherheit.',
  ),
  einfach(
    'a5-qe-7',
    'qm-merkmale',
    scenario:
        'Eine Bank führt für ihre App eine Zwei-Faktor-Anmeldung per Bestätigungscode ein.',
    prompt:
        'Welche Wirkung auf die Qualitätsmerkmale ist am ehesten zu erwarten?',
    choices: [
      ja(
        'Die Sicherheit steigt, die Benutzbarkeit sinkt etwas.',
        'Ein zusätzlicher Schritt schützt besser, macht die Anmeldung aber umständlicher.',
      ),
      nein(
        'Sicherheit und Benutzbarkeit steigen beide.',
        'Der zusätzliche Schritt macht die Bedienung nicht leichter.',
      ),
      nein(
        'Die Effizienz steigt, weil die Anmeldung schneller geht.',
        'Die Anmeldung dauert eher länger.',
      ),
      nein(
        'Keine Merkmale sind betroffen.',
        'Sicherheit und Benutzbarkeit ändern sich spürbar.',
      ),
    ],
    explanation:
        'Qualitätsmerkmale konkurrieren: Mehr Sicherheit kostet oft Benutzbarkeit, starke Optimierung kostet Wartbarkeit. Welches Merkmal Vorrang hat, legt der Auftraggeber fest.',
  ),

  // ======================================================= PDCA und KVP
  zuordnen(
    'a5-qp-1',
    'qm-pdca',
    scenario:
        'Eine Arztpraxis will die Wartezeit am Telefon senken und geht nach dem PDCA-Zyklus vor.',
    prompt: 'Ordne jeden Schritt der passenden Phase zu.',
    buckets: ['Plan', 'Do', 'Check', 'Act'],
    items: [
      zu(
        'Ziel festlegen: Wartezeit unter 2 Minuten, Maßnahme: Online-Terminbuchung',
        0,
        'Ziel mit Kennzahl und geplante Maßnahme gehören in die Planung.',
      ),
      zu(
        'Online-Terminbuchung vier Wochen lang für Kontrolltermine anbieten',
        1,
        'Die Maßnahme wird im begrenzten Rahmen erprobt.',
      ),
      zu(
        'Gemessene Wartezeiten mit dem Ziel vergleichen',
        2,
        'Soll-Ist-Vergleich ist die Aufgabe von Check.',
      ),
      zu(
        'Online-Buchung für alle Terminarten freigeben',
        3,
        'Nach erfolgreichem Check wird die Maßnahme zum Standard.',
      ),
      zu(
        'Ursachen für lange Wartezeiten aus der Anrufstatistik ermitteln',
        0,
        'Die Analyse des Problems ist Teil der Planung.',
      ),
    ],
    explanation:
        'Plan: analysieren, Ziel setzen, Maßnahme planen. Do: im Kleinen erproben. Check: Ergebnis gegen das Ziel prüfen. Act: bei Erfolg standardisieren, sonst nachbessern - dann beginnt der nächste Zyklus.',
  ),
  einfach(
    'a5-qp-2',
    'qm-pdca',
    scenario:
        'Ein Service-Desk hat ein Self-Service-Portal im Pilotbereich getestet. Im Check zeigt sich: Der Anteil der Passwort-Tickets sank nur von 30 % auf 25 %, Ziel waren unter 15 %.',
    prompt: 'Was ist in der Phase Act jetzt richtig?',
    choices: [
      ja(
        'Ursachen analysieren, die Maßnahme anpassen und einen neuen Zyklus starten',
        'Das Ziel ist verfehlt - also wird nachgebessert und erneut erprobt.',
      ),
      nein(
        'Das Portal sofort für alle Abteilungen einführen',
        'Eine Maßnahme, die ihr Ziel verfehlt hat, wird nicht zum Standard gemacht.',
      ),
      nein(
        'Den Zyklus beenden, weil die Maßnahme gescheitert ist',
        'PDCA endet nicht, ein verfehltes Ziel ist Anlass für den nächsten Durchlauf.',
      ),
      nein(
        'Das Ziel nachträglich auf 25 % senken',
        'Das Ziel an das Ergebnis anzupassen verbessert nichts, es verschleiert nur das Problem.',
      ),
    ],
    explanation:
        'Act hat zwei Ausgänge: Ziel erreicht -> Maßnahme wird Standard. Ziel verfehlt -> Ursachen klären, Maßnahme anpassen, neuer Zyklus. Genau dieses Weiterdrehen macht PDCA zum Werkzeug des KVP.',
  ),
  rechnen(
    'a5-qp-3',
    'qm-pdca',
    scenario:
        'Vor einer Maßnahme betrafen 240 von 800 Tickets Druckerprobleme. Nach der Pilotphase sind es 60 von 600 Tickets.',
    prompt:
        'Um wie viele Prozentpunkte ist der Anteil der Druckertickets gesunken?',
    answer: 20,
    unit: 'Prozentpunkte',
    explanation:
        'Anteil vorher: 240 / 800 = 0,30 = 30 %\n'
        'Anteil nachher: 60 / 600 = 0,10 = 10 %\n'
        'Differenz: 30 % - 10 % = 20 Prozentpunkte\n'
        'Relativ wäre das ein Rückgang um 20 / 30 ≈ 66,7 Prozent - Prozentpunkte und Prozent nicht verwechseln.',
  ),
  einfach(
    'a5-qp-4',
    'qm-pdca',
    prompt:
        'Welche Aussage zum kontinuierlichen Verbesserungsprozess (KVP) ist richtig?',
    choices: [
      ja(
        'Viele kleine Verbesserungen, an denen die Mitarbeitenden beteiligt sind und die fortlaufend weitergehen.',
        'Genau das kennzeichnet KVP (Kaizen).',
      ),
      nein(
        'Eine einmalige große Umstrukturierung durch externe Berater.',
        'Das wäre eine Innovation oder ein Reorganisationsprojekt.',
      ),
      nein(
        'Er endet, sobald ein Ziel erreicht ist.',
        'Nach Act beginnt der nächste Zyklus.',
      ),
      nein(
        'Er ist allein Aufgabe der Geschäftsführung.',
        'Gerade die Mitarbeitenden kennen die Schwachstellen im Alltag.',
      ),
    ],
    difficulty: 1,
    explanation:
        'KVP setzt auf stetige kleine Schritte statt seltener großer Sprünge. Sein Werkzeug ist der PDCA-Zyklus, der nach jedem Act von vorn beginnt.',
  ),
  reihenfolge(
    'a5-qp-5',
    'qm-pdca',
    scenario:
        'Ein IT-Service-Desk bekommt auffällig viele Tickets wegen fehlender Druckertreiber.',
    prompt: 'Bringe die Schritte in die Reihenfolge des PDCA-Zyklus.',
    items: [
      'Ursache analysieren, Ziel „unter 5 % Druckertickets“ festlegen, automatische Treiberverteilung planen',
      'Treiberverteilung vier Wochen in einer Abteilung erproben',
      'Ticketzahlen dieser Abteilung mit dem Ziel vergleichen',
      'Treiberverteilung für alle Abteilungen verbindlich einführen und dokumentieren',
    ],
    explanation:
        'Plan: analysieren, Ziel setzen, Maßnahme planen. Do: im Kleinen erproben. Check: Ergebnis gegen das Ziel messen. Act: bei Erfolg zum Standard machen.',
  ),
  einfach(
    'a5-qp-6',
    'qm-pdca',
    prompt:
        'In welcher Phase des PDCA-Zyklus wird eine Ursachenanalyse, etwa mit der 5-Why-Methode, typischerweise eingesetzt?',
    choices: [
      ja(
        'Plan',
        'Bevor eine Maßnahme geplant wird, muss die Ursache des Problems klar sein.',
      ),
      nein('Do', 'In Do wird die bereits geplante Maßnahme erprobt.'),
      nein(
        'Check',
        'In Check wird das Ergebnis gemessen, nicht die Ursache gesucht.',
      ),
      nein('Act', 'In Act wird standardisiert oder nachgebessert.'),
    ],
    explanation:
        'Plan umfasst Problemanalyse, Ursachenanalyse, Zielsetzung mit Kennzahl und Maßnahmenplanung. Wer die Ursache nicht kennt, plant leicht die falsche Maßnahme.',
  ),

  // ============================================================ Teststufen
  einfach(
    'a5-ss-1',
    'ts-stufen',
    scenario:
        'Das Bestellmodul eines Webshops soll getestet werden. Es ruft den Zahlungsdienst auf, der aber erst in drei Wochen fertig ist.',
    prompt: 'Womit wird der fehlende Zahlungsdienst im Test ersetzt?',
    choices: [
      ja(
        'Mit einem Stub, der feste Antworten wie „Zahlung erfolgreich“ liefert',
        'Der Stub ersetzt eine Komponente, die vom Testobjekt aufgerufen wird.',
      ),
      nein(
        'Mit einem Testtreiber',
        'Ein Testtreiber ersetzt den Aufrufer des Testobjekts, nicht die aufgerufene Komponente.',
      ),
      nein(
        'Mit einem Regressionstest',
        'Das ist eine Testart, kein Platzhalter für fehlende Komponenten.',
      ),
      nein(
        'Gar nicht - das Modul kann erst nach Fertigstellung aller Teile getestet werden',
        'Genau dafür gibt es Platzhalter: Komponenten lassen sich früh und isoliert testen.',
      ),
    ],
    explanation:
        'Stub und Testtreiber sind Platzhalter. Der Stub wird vom Testobjekt aufgerufen und ersetzt eine noch fehlende Komponente darunter. Der Testtreiber ruft das Testobjekt auf und ersetzt den fehlenden Aufrufer darüber.',
  ),
  zuordnen(
    'a5-ss-2',
    'ts-stufen',
    prompt: 'Ordne jede Situation der passenden Teststufe zu.',
    buckets: [
      'Komponententest',
      'Integrationstest',
      'Systemtest',
      'Abnahmetest',
    ],
    items: [
      zu(
        'Ein Entwickler prüft seine Funktion zur Berechnung der Mehrwertsteuer.',
        0,
        'Eine einzelne Funktion wird isoliert geprüft.',
      ),
      zu(
        'Es wird geprüft, ob der Warenkorb die Daten korrekt an das Bestellmodul übergibt.',
        1,
        'Im Fokus steht die Schnittstelle zwischen zwei Komponenten.',
      ),
      zu(
        'Das Testteam prüft den kompletten Shop in der Testumgebung gegen das Pflichtenheft.',
        2,
        'Gesamtsystem gegen die Spezifikation, in der Verantwortung des Auftragnehmers.',
      ),
      zu(
        'Die Kundin prüft den Shop mit echten Artikeldaten und entscheidet über die Annahme.',
        3,
        'Der Auftraggeber prüft und entscheidet - das ist die Abnahme.',
      ),
    ],
    explanation:
        'Der Prüfgegenstand wächst von Stufe zu Stufe: einzelne Komponente, Schnittstellen, Gesamtsystem, Abnahme durch den Auftraggeber. Entscheidend für die Abnahme ist, dass der Kunde selbst über die Annahme entscheidet.',
  ),
  zuordnen(
    'a5-ss-3',
    'ts-stufen',
    scenario:
        'Für einen Webshop werden verschiedene Testarten geplant. Gefordert ist: 500 gleichzeitige Nutzer bei höchstens 2 s Ladezeit.',
    prompt: 'Welche Testart wird jeweils beschrieben?',
    buckets: ['Lasttest', 'Stresstest', 'Regressionstest', 'Usability-Test'],
    items: [
      zu(
        'Prüfen, ob der Shop 500 gleichzeitige Nutzer in höchstens 2 s bedient',
        0,
        'Verhalten bei der erwarteten Höchstlast.',
      ),
      zu(
        'Die Nutzerzahl schrittweise über 2.000 steigern, bis das System ausfällt',
        1,
        'Verhalten über der Belastungsgrenze.',
      ),
      zu(
        'Nach einem Bugfix alle bisher bestandenen Tests erneut ausführen',
        2,
        'Suche nach Nebenwirkungen der Änderung.',
      ),
      zu(
        'Fünf Kundinnen bestellen, während beobachtet wird, wo sie zögern',
        3,
        'Bedienbarkeit mit echten Nutzern.',
      ),
    ],
    explanation:
        'Testarten beschreiben, worauf geprüft wird: Last (erwartete Höchstlast), Stress (über der Grenze), Regression (Nebenwirkungen nach Änderungen), Usability (Bedienbarkeit). Sie kommen auf verschiedenen Teststufen vor.',
  ),
  einfach(
    'a5-ss-4',
    'ts-stufen',
    scenario:
        'Bei der Top-down-Integration wird zuerst die Benutzeroberfläche mit der Geschäftslogik verbunden. Die Datenbankschicht darunter ist noch nicht fertig.',
    prompt: 'Was wird für die fehlende Datenbankschicht benötigt?',
    choices: [
      ja(
        'Stubs, die die Aufrufe mit festen Testdaten beantworten',
        'Stubs ersetzen aufgerufene Komponenten unterhalb des Testobjekts.',
      ),
      nein(
        'Testtreiber',
        'Treiber ersetzen fehlende Aufrufer oberhalb - das braucht die Bottom-up-Integration.',
      ),
      nein(
        'Ein Betatest',
        'Ein Betatest ist ein Test mit externen Anwendern, kein Platzhalter.',
      ),
      nein(
        'Nichts - Top-down kommt ohne Platzhalter aus',
        'Ohne Ersatz für die untere Schicht wäre kein Test möglich.',
      ),
    ],
    explanation:
        'Top-down integriert von oben nach unten und braucht Stubs für die noch fehlenden unteren Teile. Bottom-up integriert von unten nach oben und braucht Treiber, die die fehlenden oberen Teile ersetzen.',
  ),
  einfach(
    'a5-ss-5',
    'ts-stufen',
    scenario:
        'Ein Softwarehersteller gibt eine Vorabversion an ausgewählte Kunden. Diese nutzen sie in ihrer eigenen Umgebung und melden Fehler zurück.',
    prompt: 'Um welchen Test handelt es sich?',
    choices: [
      ja('Betatest', 'Externe Anwender testen in ihrer eigenen Umgebung.'),
      nein(
        'Alphatest',
        'Der Alphatest findet mit Anwendern beim Hersteller statt.',
      ),
      nein(
        'Komponententest',
        'Den führen Entwickler an einzelnen Modulen durch.',
      ),
      nein('Integrationstest', 'Er prüft Schnittstellen zwischen Komponenten.'),
    ],
    difficulty: 1,
    explanation:
        'Alpha- und Betatest sind Tests mit echten Anwendern vor der Freigabe. Beim Alphatest kommen die Anwender zum Hersteller, beim Betatest testen sie in ihrer eigenen Umgebung.',
  ),
  mehrfach(
    'a5-ss-6',
    'ts-stufen',
    prompt: 'Welche Aussagen zum Systemtest sind richtig?',
    choices: [
      ja(
        'Er prüft das Gesamtsystem gegen die Spezifikation, etwa das Pflichtenheft.',
        'Grundlage ist die Spezifikation.',
      ),
      ja(
        'Er läuft in einer möglichst produktionsnahen Testumgebung.',
        'So zeigen sich Fehler, die erst im Zusammenspiel auftreten.',
      ),
      ja(
        'Er liegt in der Verantwortung des Auftragnehmers.',
        'Der Auftragnehmer weist nach, dass er die Spezifikation erfüllt.',
      ),
      nein(
        'In ihm entscheidet der Kunde über die Annahme des Ergebnisses.',
        'Das geschieht im Abnahmetest.',
      ),
      nein(
        'Er prüft einzelne Funktionen isoliert vom Rest.',
        'Das ist der Komponententest.',
      ),
    ],
    explanation:
        'Systemtest: Gesamtsystem, gegen die Spezifikation, produktionsnahe Umgebung, Verantwortung beim Auftragnehmer. Abnahmetest: Auftraggeber prüft gegen seine Anforderungen und entscheidet über die Annahme.',
  ),

  // ================================================ Black-Box und White-Box
  rechnen(
    'a5-sv-1',
    'ts-verfahren',
    scenario:
        'Eine Funktion berechnet den Endpreis im Webshop. Die beiden Bedingungen sind voneinander unabhängig.\n'
        'rabatt = 0\n'
        'versand = 5\n'
        'WENN betrag > 100 DANN\n'
        '  rabatt = 5\n'
        'ENDE WENN\n'
        'WENN express = wahr DANN\n'
        '  versand = versand + 8\n'
        'ENDE WENN\n'
        'preis = betrag - rabatt + versand',
    prompt:
        'Wie viele Testfälle braucht man mindestens für eine vollständige Zweigüberdeckung?',
    answer: 2,
    unit: 'Testfälle',
    difficulty: 3,
    explanation:
        'Zweigüberdeckung heißt: Jeder Ja- und jeder Nein-Zweig wird mindestens einmal durchlaufen. Das sind 4 Zweige, aber ein Testfall deckt je Bedingung einen Zweig ab.\n'
        'Testfall 1: betrag = 150, express = wahr -> beide Ja-Zweige.\n'
        'Testfall 2: betrag = 50, express = falsch -> beide Nein-Zweige.\n'
        'Also 2 Testfälle. Für Anweisungsüberdeckung genügt schon Testfall 1. Alle 4 Kombinationen wären erst für eine Pfadüberdeckung nötig.',
  ),
  mehrfach(
    'a5-sv-2',
    'ts-verfahren',
    prompt:
        'Welche Aussagen zu manuellen und automatisierten Tests sind richtig?',
    choices: [
      ja(
        'Automatisierte Tests lohnen sich besonders für Regressionstests nach jeder Änderung.',
        'Sie laufen beliebig oft ohne zusätzlichen Personalaufwand.',
      ),
      ja(
        'Die Bedienbarkeit einer Oberfläche wird sinnvoll mit echten Nutzern manuell getestet.',
        'Ob etwas verständlich ist, kann nur ein Mensch beurteilen.',
      ),
      ja(
        'Automatisierte Tests verursachen vor allem beim Erstellen und Pflegen Aufwand.',
        'Die Ausführung selbst kostet danach kaum noch Zeit.',
      ),
      nein(
        'Automatisierte Tests machen manuelle Tests vollständig überflüssig.',
        'Erkundende Tests und Usability-Tests bleiben Menschenarbeit.',
      ),
      nein(
        'Ein einmaliger Test, der nie wiederholt wird, sollte immer automatisiert werden.',
        'Der Aufwand für die Automatisierung lohnt sich erst durch häufige Wiederholung.',
      ),
    ],
    explanation:
        'Automatisierung rechnet sich über die Wiederholung: hoher Aufwand beim Erstellen, danach fast kostenlos. Manuelle Tests sind stark, wo menschliches Urteil gefragt ist, etwa bei Bedienbarkeit oder beim freien Erkunden.',
  ),
  rechnen(
    'a5-sv-3',
    'ts-verfahren',
    scenario:
        'Ein Programm enthält 40 Anweisungen. Die vorhandenen Testfälle führen zusammen 34 davon mindestens einmal aus.',
    prompt: 'Wie hoch ist die Anweisungsüberdeckung in Prozent?',
    answer: 85,
    unit: '%',
    difficulty: 1,
    explanation:
        'Anweisungsüberdeckung = ausgeführte / alle Anweisungen × 100 %\n'
        '= 34 / 40 × 100 % = 85 %.\n'
        '6 Anweisungen wurden nie ausgeführt - für sie fehlen Testfälle.',
  ),
  rechnen(
    'a5-sv-4',
    'ts-verfahren',
    scenario:
        'Eine Funktion enthält drei voneinander unabhängige WENN-Abfragen ohne SONST-Teil, die hintereinander ausgeführt werden.',
    prompt: 'Wie viele verschiedene Pfade gibt es durch die Funktion?',
    answer: 8,
    unit: 'Pfade',
    difficulty: 3,
    explanation:
        'Jede Abfrage hat zwei Ausgänge (ja/nein), und die Abfragen sind unabhängig:\n'
        '2 × 2 × 2 = 2³ = 8 Pfade.\n'
        'Zum Vergleich: Für die Zweigüberdeckung reichen 2 Testfälle (einmal alle Ja-, einmal alle Nein-Zweige).',
  ),
  rechnen(
    'a5-sv-5',
    'ts-verfahren',
    scenario:
        'rabatt = 0\n'
        'WENN betrag > 100 DANN\n'
        '  rabatt = 5\n'
        'ENDE WENN\n'
        'zahlen = betrag - rabatt\n'
        'Es gibt genau einen Testfall: betrag = 150.',
    prompt: 'Wie hoch ist die Zweigüberdeckung in Prozent?',
    answer: 50,
    unit: '%',
    explanation:
        'Die Abfrage hat 2 Zweige: ja und nein.\n'
        'Mit betrag = 150 wird nur der Ja-Zweig durchlaufen: 1 von 2.\n'
        'Zweigüberdeckung = 1 / 2 × 100 % = 50 %.\n'
        'Die Anweisungsüberdeckung liegt dagegen schon bei 100 %, weil alle Anweisungen liefen - der leere Nein-Zweig enthält keine Anweisung.',
  ),
  zuordnen(
    'a5-sv-6',
    'ts-verfahren',
    prompt: 'Gehört die Vorgehensweise zum Black-Box- oder zum White-Box-Test?',
    buckets: ['Black-Box', 'White-Box'],
    items: [
      zu(
        'Testfälle aus den Äquivalenzklassen der Spezifikation bilden',
        0,
        'Grundlage ist nur die Spezifikation.',
      ),
      zu(
        'Grenzwertanalyse an den Rändern der erlaubten Eingaben',
        0,
        'Auch sie braucht keinen Einblick in den Code.',
      ),
      zu(
        'Messen, welcher Anteil der Zweige durchlaufen wurde',
        1,
        'Zweigüberdeckung setzt Kenntnis des Codes voraus.',
      ),
      zu(
        'Testfälle so wählen, dass jede Schleife mindestens einmal läuft',
        1,
        'Man muss die Schleifen im Code kennen.',
      ),
      zu(
        'Abnahmetest des Fachbereichs anhand der vereinbarten Anforderungen',
        0,
        'Der Fachbereich prüft von außen gegen Anforderungen.',
      ),
      zu(
        'Unit-Test, der gezielt den SONST-Zweig einer Abfrage auslöst',
        1,
        'Der Testfall ist aus der Programmstruktur abgeleitet.',
      ),
    ],
    explanation:
        'Black-Box-Testfälle stammen aus der Spezifikation (Äquivalenzklassen, Grenzwerte, Anforderungen). White-Box-Testfälle stammen aus dem Code (Anweisungen, Zweige, Schleifen, Pfade).',
  ),
  reihenfolge(
    'a5-sv-7',
    'ts-verfahren',
    prompt:
        'Bringe die Schritte der testgetriebenen Entwicklung (TDD) in die richtige Reihenfolge.',
    items: [
      'Einen Test schreiben, der zunächst fehlschlägt (Red)',
      'Gerade so viel Code schreiben, dass der Test besteht (Green)',
      'Den Code aufräumen, ohne dass der Test fehlschlägt (Refactor)',
    ],
    explanation:
        'TDD dreht die übliche Reihenfolge um: erst der Test, dann der Code. Der kurze Kreislauf Red - Green - Refactor wiederholt sich für jede kleine Funktion.',
  ),

  // ====================================================== Testfälle entwerfen
  einfach(
    'a5-sf-1',
    'ts-testfaelle',
    scenario:
        'Ein Passwort muss 8 bis 64 Zeichen lang sein. Getestet wird nur die Länge.',
    prompt:
        'Welche Passwortlängen decken alle Äquivalenzklassen mit je einem Repräsentanten ab?',
    choices: [
      ja(
        '5, 20 und 70 Zeichen',
        'Je ein Vertreter für „zu kurz“, „gültig“ und „zu lang“.',
      ),
      nein(
        '7, 8 und 64 Zeichen',
        'Die ungültige Klasse „länger als 64“ fehlt.',
      ),
      nein(
        '20, 30 und 40 Zeichen',
        'Alle drei liegen in derselben gültigen Klasse.',
      ),
      nein(
        '8, 64 und 65 Zeichen',
        'Die ungültige Klasse „kürzer als 8“ fehlt.',
      ),
    ],
    explanation:
        'Es gibt drei Klassen: ungültig (unter 8), gültig (8 bis 64) und ungültig (über 64). Jede braucht einen Vertreter. Die Werte an den Grenzen sind Sache der Grenzwertanalyse - hier reicht je Klasse ein beliebiger Wert.',
  ),
  rechnen(
    'a5-sf-2',
    'ts-testfaelle',
    scenario:
        'In einem Webshop ist die Bestellmenge eine ganze Zahl. Erlaubt sind 1 bis 100 Stück: 1 bis 9 ohne Rabatt, 10 bis 49 mit 5 %, 50 bis 100 mit 10 %. Mengen unter 1 und über 100 werden abgelehnt.',
    prompt:
        'Für die Grenzwertanalyse werden an jedem Übergang zwischen zwei benachbarten Klassen die beiden Werte direkt links und rechts des Übergangs getestet. Wie viele verschiedene Testwerte ergeben sich?',
    answer: 8,
    unit: 'Testwerte',
    difficulty: 3,
    explanation:
        'Klassen: unter 1 | 1 bis 9 | 10 bis 49 | 50 bis 100 | über 100. Das ergibt 4 Übergänge mit je 2 Werten:\n'
        '- zwischen ungültig und 1 bis 9: 0 und 1\n'
        '- zwischen 1 bis 9 und 10 bis 49: 9 und 10\n'
        '- zwischen 10 bis 49 und 50 bis 100: 49 und 50\n'
        '- zwischen 50 bis 100 und ungültig: 100 und 101\n'
        '4 × 2 = 8 verschiedene Testwerte.',
  ),
  zuordnen(
    'a5-sf-3',
    'ts-testfaelle',
    scenario:
        'Im Webshop sind Bestellmengen von 1 bis 99 Stück als ganze Zahl erlaubt.',
    prompt:
        'Gehört die eingegebene Menge zu einer gültigen oder einer ungültigen Äquivalenzklasse?',
    buckets: ['Gültige Klasse', 'Ungültige Klasse'],
    items: [
      zu('1', 0, 'Untere Grenze, liegt noch im erlaubten Bereich.'),
      zu('99', 0, 'Obere Grenze, liegt noch im erlaubten Bereich.'),
      zu('0', 1, 'Kleiner als 1.'),
      zu('100', 1, 'Größer als 99.'),
      zu('„zwei“', 1, 'Keine Zahl - eine eigene ungültige Klasse.'),
      zu('-5', 1, 'Negative Mengen liegen unter der Untergrenze.'),
    ],
    explanation:
        'Gültig ist nur der Bereich 1 bis 99, die Grenzen eingeschlossen. Ungültige Klassen sind „zu klein“, „zu groß“ und „keine Zahl“. Grenzwerte wie 1 und 99 gehören zur gültigen Klasse, ihre Nachbarn 0 und 100 zur ungültigen.',
  ),
  mehrfach(
    'a5-sf-4',
    'ts-testfaelle',
    prompt:
        'Welche Aussagen zu Äquivalenzklassen und Grenzwertanalyse sind richtig?',
    choices: [
      ja(
        'Aus jeder Äquivalenzklasse genügt ein Repräsentant.',
        'Laut Spezifikation verhält sich das Programm für alle Werte einer Klasse gleich.',
      ),
      ja(
        'Für jede ungültige Klasse wird ein eigener Testfall gebildet.',
        'Kombinierte ungültige Werte können sich gegenseitig verdecken.',
      ),
      ja(
        'Die Grenzwertanalyse ergänzt die Äquivalenzklassen um Werte an den Klassengrenzen.',
        'An den Rändern entstehen typische Fehler wie > statt >=.',
      ),
      nein(
        'Äquivalenzklassen werden aus dem Quellcode abgeleitet.',
        'Sie stammen aus der Spezifikation - es ist ein Black-Box-Verfahren.',
      ),
      nein(
        'Ungültige Klassen müssen nicht getestet werden, weil der Nutzer sie nicht eingeben soll.',
        'Gerade falsche Eingaben muss das Programm sauber abweisen.',
      ),
    ],
    explanation:
        'Äquivalenzklassen und Grenzwertanalyse sind Black-Box-Verfahren und ergänzen sich: Die Klassen sorgen dafür, dass jeder Fall einmal vorkommt, die Grenzwerte prüfen gezielt die Ränder, an denen Programmierfehler besonders häufig sind.',
  ),
  rechnen(
    'a5-sf-5',
    'ts-testfaelle',
    scenario:
        'Ein Rabattsystem erwartet den Bestellwert in Euro (Dezimalzahl): 0 bis unter 50 € kein Rabatt, 50 bis unter 200 € 5 % Rabatt, ab 200 € 10 % Rabatt. Negative Werte sind ungültig, eine Obergrenze gibt es nicht. Nicht-numerische Eingaben bilden eine eigene ungültige Klasse.',
    prompt: 'Wie viele Äquivalenzklassen ergeben sich insgesamt?',
    answer: 5,
    unit: 'Klassen',
    difficulty: 3,
    explanation:
        'Gültige Klassen (je unterschiedliches Verhalten):\n'
        '1. 0 bis unter 50 € (kein Rabatt)\n'
        '2. 50 bis unter 200 € (5 %)\n'
        '3. ab 200 € (10 %)\n'
        'Ungültige Klassen:\n'
        '4. negative Werte\n'
        '5. keine Zahl\n'
        'Eine Klasse „zu groß“ gibt es nicht, weil keine Obergrenze festgelegt ist. Zusammen 5 Klassen.',
  ),
  einfach(
    'a5-sf-6',
    'ts-testfaelle',
    scenario:
        'Ab einer Bestellmenge von 50 Stück (ganze Zahl) gibt es Mengenrabatt.',
    prompt: 'Welches Wertepaar prüft genau diese Grenze?',
    choices: [
      ja(
        '49 und 50',
        '49 ist der letzte Wert ohne, 50 der erste Wert mit Rabatt.',
      ),
      nein(
        '50 und 51',
        'Beide Werte liegen schon im Rabattbereich - ein Fehler wie > statt >= bliebe unentdeckt.',
      ),
      nein(
        '1 und 50',
        '1 ist die untere Grenze der Bestellmenge, nicht die Rabattgrenze.',
      ),
      nein('25 und 75', 'Das sind Repräsentanten, keine Grenzwerte.'),
    ],
    explanation:
        '„Ab 50“ schließt 50 ein. Die Grenzwertanalyse testet den letzten Wert vor der Grenze (49) und den ersten dahinter (50). Stünde im Code „menge > 50“, würde der Test mit 50 den Fehler aufdecken.',
  ),
  zuordnen(
    'a5-sf-7',
    'ts-testfaelle',
    scenario: 'Ein Passwort muss 8 bis 64 Zeichen lang sein.',
    prompt: 'Ist der Testfall ein Positiv- oder ein Negativtest?',
    buckets: ['Positivtest', 'Negativtest'],
    items: [
      zu(
        'Passwort mit 12 Zeichen',
        0,
        'Gültige Eingabe, soll angenommen werden.',
      ),
      zu('Passwort mit 8 Zeichen', 0, 'Untere Grenze, noch gültig.'),
      zu('Passwort mit 64 Zeichen', 0, 'Obere Grenze, noch gültig.'),
      zu('Passwort mit 5 Zeichen', 1, 'Zu kurz, muss abgewiesen werden.'),
      zu('Passwort mit 70 Zeichen', 1, 'Zu lang, muss abgewiesen werden.'),
      zu(
        'Leere Eingabe',
        1,
        'Ungültig, muss eine verständliche Meldung auslösen.',
      ),
    ],
    explanation:
        'Positivtests prüfen, ob gültige Eingaben korrekt verarbeitet werden. Negativtests prüfen, ob ungültige Eingaben sauber abgewiesen werden - mit verständlicher Meldung und ohne Absturz.',
  ),
  rechnen(
    'a5-sf-8',
    'ts-testfaelle',
    scenario:
        'Ob ein Kunde Versandkostenfreiheit erhält, hängt von drei Bedingungen ab, die jeweils mit ja oder nein beantwortet werden: Stammkunde?, Bestellwert über 50 €?, Lieferung ins Inland?',
    prompt: 'Wie viele Regeln hat die vollständige Entscheidungstabelle?',
    answer: 8,
    unit: 'Regeln',
    explanation:
        'Jede Bedingung hat 2 Ausprägungen. Bei 3 unabhängigen Bedingungen gibt es\n'
        '2 × 2 × 2 = 2³ = 8 Kombinationen.\n'
        'Jede Regel (Spalte bzw. Zeile der Tabelle) wird zu einem Testfall.',
  ),

  // ============================================ Testplanung und Testprotokoll
  zuordnen(
    'a5-sp-1',
    'ts-protokoll',
    prompt:
        'Gehört die Angabe in das Testkonzept (vor dem Test) oder in das Testprotokoll (bei der Durchführung)?',
    buckets: ['Testkonzept', 'Testprotokoll'],
    items: [
      zu(
        'Endekriterien für den Testabschluss',
        0,
        'Wann Schluss ist, muss vor dem Test feststehen.',
      ),
      zu(
        'Benötigte Testumgebung und Testdaten',
        0,
        'Ressourcen werden vorab geplant.',
      ),
      zu(
        'Testobjekte und Testumfang',
        0,
        'Was geprüft wird, legt die Planung fest.',
      ),
      zu(
        'Tatsächliches Ergebnis (Ist-Ergebnis)',
        1,
        'Das Ist entsteht erst bei der Durchführung.',
      ),
      zu(
        'Datum und Name der Testerin',
        1,
        'Wer wann getestet hat, wird bei der Durchführung notiert.',
      ),
      zu(
        'Festgestellte Abweichung vom Soll',
        1,
        'Abweichungen zeigen sich erst beim Ausführen.',
      ),
    ],
    explanation:
        'Das Testkonzept plant: Ziele, Umfang, Testobjekte, Ressourcen, Termine und Endekriterien. Das Testprotokoll dokumentiert die Durchführung: wer, wann, welche Eingabe, Soll, Ist, Ergebnis und Abweichung.',
  ),
  reihenfolge(
    'a5-sp-2',
    'ts-protokoll',
    prompt:
        'Bringe die Schritte der Fehlerbehandlung in die richtige Reihenfolge.',
    items: [
      'Abweichung zwischen Soll und Ist im Testprotokoll festhalten',
      'Fehlermeldung mit Fehlerklasse und Priorität erfassen',
      'Fehler durch die Entwicklung beheben',
      'Nachtest des fehlgeschlagenen Testfalls',
      'Regressionstest der übrigen Funktionen',
      'Fehlermeldung schließen',
    ],
    hint: 'Beginne mit der Beobachtung im Test',
    explanation:
        'Erst wird die Abweichung dokumentiert und als Fehler mit Klasse und Priorität gemeldet. Nach der Korrektur bestätigt der Nachtest die Behebung, der Regressionstest schließt Nebenwirkungen aus. Erst dann wird die Meldung geschlossen.',
  ),
  einfach(
    'a5-sp-3',
    'ts-protokoll',
    scenario:
        'Im Testprotokoll steht zu TF-017: Eingabe Bestellmenge 100, Soll „Meldung: Höchstens 99 Stück“, Ist „Bestellung angelegt“. Die Entwicklung meldet den Fehler als behoben.',
    prompt: 'Was ist der nächste Testschritt?',
    choices: [
      ja(
        'TF-017 mit denselben Eingaben erneut ausführen (Nachtest)',
        'Nur so wird bestätigt, dass genau dieser Fehler wirklich behoben ist.',
      ),
      nein(
        'TF-017 als bestanden eintragen, weil die Entwicklung die Behebung gemeldet hat',
        'Ein Testergebnis beruht auf Durchführung, nicht auf einer Meldung.',
      ),
      nein(
        'Sofort den Abnahmetest mit dem Kunden starten',
        'Vorher muss feststehen, dass die Korrektur wirkt und nichts anderes beschädigt hat.',
      ),
      nein(
        'Das Soll-Ergebnis von TF-017 an das Ist-Ergebnis anpassen',
        'Das Soll kommt aus der Spezifikation und wird nicht an das Programm angepasst.',
      ),
    ],
    explanation:
        'Nach jeder Fehlerbehebung folgt der Nachtest: Der fehlgeschlagene Testfall wird mit denselben Daten wiederholt. Besteht er, prüft ein Regressionstest, ob die Korrektur Nebenwirkungen hat.',
  ),
  rechnen(
    'a5-sp-4',
    'ts-protokoll',
    scenario:
        'Im Systemtest wurden 250 Testfälle durchgeführt. 235 davon wurden bestanden.',
    prompt: 'Wie hoch ist die Bestehensquote in Prozent?',
    answer: 94,
    unit: '%',
    difficulty: 1,
    explanation:
        'Bestehensquote = bestandene / durchgeführte Testfälle × 100 %\n'
        '= 235 / 250 × 100 % = 94 %.',
  ),
  einfach(
    'a5-sp-5',
    'ts-protokoll',
    scenario:
        'Endekriterien: mindestens 95 % der Testfälle bestanden, kein kritischer Fehler offen.\n'
        'Stand heute: 97 % bestanden, ein kritischer Fehler (Datenverlust beim Speichern) ist offen.',
    prompt: 'Wie ist der Teststand zu bewerten?',
    choices: [
      ja(
        'Der Test ist nicht abgeschlossen, weil ein kritischer Fehler offen ist.',
        'Alle Endekriterien müssen erfüllt sein - eines ist verfehlt.',
      ),
      nein(
        'Der Test ist abgeschlossen, weil mehr als 95 % bestanden sind.',
        'Die Quote allein reicht nicht, das zweite Kriterium ist verletzt.',
      ),
      nein(
        'Der kritische Fehler wird als schwer eingestuft, dann ist der Test fertig.',
        'Die Fehlerklasse richtet sich nach der Auswirkung, nicht nach dem Wunschergebnis.',
      ),
      nein(
        'Die Endekriterien werden auf 90 % gesenkt.',
        'Endekriterien werden vorher festgelegt und nicht nachträglich angepasst.',
      ),
    ],
    explanation:
        'Endekriterien werden vor dem Test messbar festgelegt und gelten gemeinsam. Solange ein kritischer Fehler offen ist, ist der Test nicht beendet - erst Korrektur, dann Nachtest und Regressionstest.',
  ),
  mehrfach(
    'a5-sp-6',
    'ts-protokoll',
    prompt: 'Was gehört in eine gute Fehlermeldung (Bug-Report)?',
    choices: [
      ja(
        'Die Schritte, mit denen sich der Fehler nachstellen lässt',
        'Ohne sie kann die Entwicklung den Fehler oft nicht finden.',
      ),
      ja(
        'Soll- und Ist-Ergebnis',
        'Zeigt, worin die Abweichung genau besteht.',
      ),
      ja(
        'Testumgebung und Softwareversion',
        'Viele Fehler treten nur in bestimmten Umgebungen auf.',
      ),
      ja(
        'Fehlerklasse und Priorität',
        'Steuern, wie schnell der Fehler bearbeitet wird.',
      ),
      nein(
        'Den Namen des Entwicklers, der den Fehler verursacht hat',
        'Schuldzuweisungen gehören nicht in eine Fehlermeldung.',
      ),
    ],
    explanation:
        'Eine Fehlermeldung muss so genau sein, dass die Entwicklung den Fehler nachstellen kann: ID und Titel, Schritte, Soll und Ist, Umgebung und Version, Fehlerklasse und Priorität, Status.',
  ),
  reihenfolge(
    'a5-sp-7',
    'ts-protokoll',
    prompt:
        'Bringe die Zustände einer Fehlermeldung im Normalfall in die richtige Reihenfolge.',
    items: [
      'neu',
      'zugewiesen',
      'behoben',
      'Nachtest bestanden',
      'geschlossen',
    ],
    explanation:
        'Eine Fehlermeldung wird erfasst (neu), einer Entwicklerin zugewiesen, behoben und im Nachtest geprüft. Erst nach bestandenem Nachtest wird sie geschlossen; scheitert der Nachtest, wird sie wiedereröffnet.',
  ),
];
