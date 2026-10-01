import 'package:flutter/foundation.dart';

/// Ein Unterthema - zugleich eine Lektion der Learning Journey.
///
/// Die Reihenfolge in [Subtopics.all] ist die Lernreihenfolge: Innerhalb
/// eines Themas baut jede Lektion auf der vorherigen auf (erst die Begriffe,
/// dann das Rechnen, dann die Sonderfälle). Die Liste ist deshalb bewusst
/// von Hand sortiert und nicht alphabetisch.
@immutable
class Subtopic {
  const Subtopic({
    required this.id,
    required this.topicId,
    required this.title,
    required this.goal,
  });

  final String id;
  final String topicId;
  final String title;

  /// Lernziel in einem Satz, aus Sicht des Lernenden ("Du kannst ...").
  final String goal;
}

class Subtopics {
  const Subtopics._();

  static const all = <Subtopic>[
    // ================================================================= 01
    // Projektgrundlagen & Organisation
    Subtopic(id: 'p-begriff', topicId: 'projektorganisation', title: 'Was ein Projekt ausmacht',
        goal: 'Du erkennst an vier Merkmalen, ob ein Vorhaben ein Projekt ist.'),
    Subtopic(id: 'p-ziele', topicId: 'projektorganisation', title: 'Projektziele und magisches Dreieck',
        goal: 'Du formulierst SMARTe Ziele und erklärst den Zielkonflikt aus Zeit, Kosten und Leistung.'),
    Subtopic(id: 'p-organisation', topicId: 'projektorganisation', title: 'Organisationsformen',
        goal: 'Du ordnest Situationen der reinen Projekt-, Matrix- oder Einflussorganisation zu.'),
    Subtopic(id: 'p-rollen', topicId: 'projektorganisation', title: 'Rollen im Projekt',
        goal: 'Du unterscheidest Auftraggeber, Lenkungsausschuss, Projektleitung und Team.'),
    Subtopic(id: 'p-stakeholder', topicId: 'projektorganisation', title: 'Stakeholder analysieren',
        goal: 'Du wählst für jeden Stakeholder anhand von Einfluss und Interesse die passende Strategie.'),

    // Vorgehensmodelle & Phasen
    Subtopic(id: 'v-phasen', topicId: 'vorgehensmodelle', title: 'Projektphasen',
        goal: 'Du nennst die Phasen eines Projekts und was in jeder entsteht.'),
    Subtopic(id: 'v-wasserfall', topicId: 'vorgehensmodelle', title: 'Das Wasserfallmodell',
        goal: 'Du beschreibst Ablauf, Stärken und Schwächen des Wasserfallmodells.'),
    Subtopic(id: 'v-auswahl', topicId: 'vorgehensmodelle', title: 'Klassisch oder agil?',
        goal: 'Du begründest für eine Projektsituation, ob Wasserfall oder Scrum besser passt.'),

    // Agiles Arbeiten & Scrum
    Subtopic(id: 's-manifest', topicId: 'agil_scrum', title: 'Das agile Manifest',
        goal: 'Du nennst die vier Werte des agilen Manifests und was sie im Alltag bedeuten.'),
    Subtopic(id: 's-rollen', topicId: 'agil_scrum', title: 'Die drei Verantwortlichkeiten',
        goal: 'Du ordnest Aufgaben dem Product Owner, dem Scrum Master oder den Developers zu.'),
    Subtopic(id: 's-artefakte', topicId: 'agil_scrum', title: 'Artefakte und Commitments',
        goal: 'Du erklärst Product Backlog, Sprint Backlog und Increment samt ihren Zielen.'),
    Subtopic(id: 's-events', topicId: 'agil_scrum', title: 'Die Scrum-Events',
        goal: 'Du ordnest die Events in den Sprint ein und kennst Zweck und Timebox.'),
    Subtopic(id: 's-stories', topicId: 'agil_scrum', title: 'User Stories und Schätzung',
        goal: 'Du schreibst User Stories mit Akzeptanzkriterien und kennst relative Schätzverfahren.'),

    // Netzplantechnik
    Subtopic(id: 'n-grundlagen', topicId: 'netzplan', title: 'Aufbau eines Netzplans',
        goal: 'Du liest einen Vorgangsknoten und kennst die Anordnungsbeziehungen.'),
    Subtopic(id: 'n-vorwaerts', topicId: 'netzplan', title: 'Vorwärtsrechnung',
        goal: 'Du berechnest FAZ und FEZ für jeden Vorgang, auch bei mehreren Vorgängern.'),
    Subtopic(id: 'n-rueckwaerts', topicId: 'netzplan', title: 'Rückwärtsrechnung',
        goal: 'Du berechnest SEZ und SAZ vom Projektende aus, auch bei mehreren Nachfolgern.'),
    Subtopic(id: 'n-puffer', topicId: 'netzplan', title: 'Gesamtpuffer und freier Puffer',
        goal: 'Du berechnest GP und FP und erklärst den Unterschied an einem Beispiel.'),
    Subtopic(id: 'n-kritisch', topicId: 'netzplan', title: 'Der kritische Pfad',
        goal: 'Du bestimmst den kritischen Pfad und schätzt die Folgen von Verzögerungen ein.'),

    // Projektstruktur & Termine
    Subtopic(id: 't-psp', topicId: 'terminplanung', title: 'Projektstrukturplan',
        goal: 'Du gliederst ein Projekt in Teilaufgaben und Arbeitspakete.'),
    Subtopic(id: 't-gantt', topicId: 'terminplanung', title: 'Gantt-Diagramm und Meilensteine',
        goal: 'Du liest ein Gantt-Diagramm und setzt Meilensteine sinnvoll.'),
    Subtopic(id: 't-ressourcen', topicId: 'terminplanung', title: 'Ressourcen und Aufwand',
        goal: 'Du rechnest mit Aufwand, Dauer und Kapazität und erkennst Überlastungen.'),

    // Risikomanagement
    Subtopic(id: 'r-prozess', topicId: 'risikomanagement', title: 'Der Risikomanagement-Prozess',
        goal: 'Du nennst die Schritte vom Erkennen bis zum Überwachen eines Risikos.'),
    Subtopic(id: 'r-bewertung', topicId: 'risikomanagement', title: 'Risiken bewerten',
        goal: 'Du berechnest Risikowerte und liest eine Risikomatrix.'),
    Subtopic(id: 'r-strategien', topicId: 'risikomanagement', title: 'Risikostrategien',
        goal: 'Du wählst für ein Risiko die passende Strategie und begründest sie.'),

    // Wirtschaftlichkeit von Projekten
    Subtopic(id: 'w-kalkulation', topicId: 'pm_wirtschaftlichkeit', title: 'Projektkosten kalkulieren',
        goal: 'Du berechnest Personal- und Sachkosten eines Projekts.'),
    Subtopic(id: 'w-nutzwert', topicId: 'pm_wirtschaftlichkeit', title: 'Nutzwertanalyse',
        goal: 'Du führst eine Nutzwertanalyse durch und interpretierst das Ergebnis.'),
    Subtopic(id: 'w-makeorbuy', topicId: 'pm_wirtschaftlichkeit', title: 'Make or Buy',
        goal: 'Du wägst Eigenentwicklung und Kauf mit Zahlen und Argumenten ab.'),
    Subtopic(id: 'w-breakeven', topicId: 'pm_wirtschaftlichkeit', title: 'Break-even und Amortisation',
        goal: 'Du berechnest, ab wann sich eine Investition lohnt.'),

    // Projektabschluss
    Subtopic(id: 'a-abnahme', topicId: 'projektabschluss', title: 'Abnahme und Übergabe',
        goal: 'Du beschreibst den Ablauf einer Abnahme und die Rolle des Abnahmeprotokolls.'),
    Subtopic(id: 'a-bericht', topicId: 'projektabschluss', title: 'Abschlussbericht und Soll-Ist',
        goal: 'Du erstellst einen Soll-Ist-Vergleich und leitest Abweichungen ab.'),
    Subtopic(id: 'a-lessons', topicId: 'projektabschluss', title: 'Lessons Learned',
        goal: 'Du sicherst Erfahrungen so, dass Folgeprojekte davon profitieren.'),

    // ================================================================= 02
    // Kommunikation & Kundenkontakt
    Subtopic(id: 'k-modelle', topicId: 'kommunikation', title: 'Kommunikationsmodelle',
        goal: 'Du erklärst Missverständnisse mit dem Sender-Empfänger- und dem Vier-Ohren-Modell.'),
    Subtopic(id: 'k-gespraech', topicId: 'kommunikation', title: 'Gesprächsführung',
        goal: 'Du führst Kundengespräche in Phasen, ermittelst den Bedarf und sprichst Probleme mit Ich-Botschaften an.'),
    Subtopic(id: 'k-kunde', topicId: 'kommunikation', title: 'Kunden beraten und betreuen',
        goal: 'Du erklärst Technik adressatengerecht und bearbeitest Anfragen strukturiert.'),

    // Teamarbeit
    Subtopic(id: 'te-phasen', topicId: 'teamarbeit', title: 'Teamphasen nach Tuckman',
        goal: 'Du erkennst, in welcher Phase ein Team steckt, und was ihm dann hilft.'),
    Subtopic(id: 'te-feedback', topicId: 'teamarbeit', title: 'Feedback und Fehlerkultur',
        goal: 'Du gibst und nimmst Feedback nach klaren Regeln.'),
    Subtopic(id: 'te-konflikte', topicId: 'teamarbeit', title: 'Konflikte und Vielfalt',
        goal: 'Du erkennst Konfliktarten und wählst einen passenden Lösungsweg.'),

    // Verhandeln
    Subtopic(id: 've-harvard', topicId: 'verhandlung', title: 'Das Harvard-Konzept',
        goal: 'Du wendest die vier Prinzipien des sachgerechten Verhandelns an.'),
    Subtopic(id: 've-einwaende', topicId: 'verhandlung', title: 'Argumentieren und Einwände behandeln',
        goal: 'Du reagierst auf Kundeneinwände mit passenden Techniken.'),

    // Präsentieren & Beraten
    Subtopic(id: 'pr-praesentation', topicId: 'praesentation', title: 'Präsentationen aufbauen',
        goal: 'Du gliederst eine Präsentation und wählst passende Visualisierungen.'),
    Subtopic(id: 'pr-quellen', topicId: 'praesentation', title: 'Informationsquellen bewerten',
        goal: 'Du prüfst Quellen auf Aktualität, Seriosität und Relevanz.'),
    Subtopic(id: 'pr-angebot', topicId: 'praesentation', title: 'Anfrage, Angebot und Vergleich',
        goal: 'Du erstellst ein Angebot und vergleichst Angebote quantitativ und qualitativ.'),

    // Markt, Bedarf & Marketing
    Subtopic(id: 'm-markt', topicId: 'markt_marketing', title: 'Markt und Marktformen',
        goal: 'Du ordnest Märkte nach Anbieter- und Nachfragerzahl ein.'),
    Subtopic(id: 'm-bedarf', topicId: 'markt_marketing', title: 'Bedarf ermitteln',
        goal: 'Du unterscheidest Bedürfnis, Bedarf und Nachfrage und ermittelst Kundenbedarf.'),
    Subtopic(id: 'm-marketing', topicId: 'markt_marketing', title: 'Marketing-Mix und AIDA',
        goal: 'Du ordnest Maßnahmen den vier Instrumenten zu und kennst die AIDA-Stufen.'),
    Subtopic(id: 'm-abc', topicId: 'markt_marketing', title: 'ABC-Analyse',
        goal: 'Du führst eine ABC-Analyse durch und leitest Prioritäten ab.'),
    Subtopic(id: 'm-rechtsformen', topicId: 'markt_marketing', title: 'Rechtsformen von Unternehmen',
        goal: 'Du unterscheidest Rechtsformen nach Haftung, Kapital und Geschäftsführung.'),

    // ================================================================= 03
    // Hardware & Arbeitsplatz
    Subtopic(id: 'h-komponenten', topicId: 'hardware', title: 'Komponenten eines PCs',
        goal: 'Du erklärst Aufgabe und Kennzahlen von CPU, RAM, Mainboard und Grafik.'),
    Subtopic(id: 'h-speicher', topicId: 'hardware', title: 'Speicher: HDD und SSD',
        goal: 'Du vergleichst Speichertechnologien und rechnest Speichereinheiten um.'),
    Subtopic(id: 'h-schnittstellen', topicId: 'hardware', title: 'Schnittstellen und Peripherie',
        goal: 'Du wählst passende Anschlüsse und bewertest Monitore und Peripherie.'),
    Subtopic(id: 'h-usv', topicId: 'hardware', title: 'USV und Stromversorgung',
        goal: 'Du unterscheidest USV-Typen und dimensionierst eine USV.'),
    Subtopic(id: 'h-arbeitsplatz', topicId: 'hardware', title: 'Green IT und Ergonomie',
        goal: 'Du richtest einen ergonomischen, energiesparenden Arbeitsplatz ein.'),

    // Betriebssysteme
    Subtopic(id: 'b-aufgaben', topicId: 'betriebssysteme', title: 'Aufgaben eines Betriebssystems',
        goal: 'Du erklärst, wie ein Betriebssystem Prozesse, Speicher und Geräte verwaltet.'),
    Subtopic(id: 'b-dateisysteme', topicId: 'betriebssysteme', title: 'Dateisysteme',
        goal: 'Du wählst für einen Einsatzzweck das passende Dateisystem.'),
    Subtopic(id: 'b-rechte', topicId: 'betriebssysteme', title: 'Benutzer und Rechte',
        goal: 'Du vergibst Rechte nach dem Minimalprinzip und liest Linux-Rechte.'),
    Subtopic(id: 'b-cli', topicId: 'betriebssysteme', title: 'Kommandozeile',
        goal: 'Du kennst die wichtigsten Befehle unter Windows und Linux.'),
    Subtopic(id: 'b-haertung', topicId: 'betriebssysteme', title: 'Updates und Härtung',
        goal: 'Du machst ein System mit Updates und Härtungsmaßnahmen sicherer.'),

    // Anwendungs- & Softwaresysteme
    Subtopic(id: 'an-unternehmen', topicId: 'anwendungssysteme', title: 'ERP, SCM und CRM',
        goal: 'Du ordnest betriebliche Aufgaben dem passenden Anwendungssystem zu.'),
    Subtopic(id: 'an-software', topicId: 'anwendungssysteme', title: 'Standard- oder Individualsoftware',
        goal: 'Du wägst Standard- und Individualsoftware für einen Kunden ab.'),
    Subtopic(id: 'an-lizenzen', topicId: 'anwendungssysteme', title: 'Lizenzmodelle',
        goal: 'Du unterscheidest proprietäre, Open-Source- und Abo-Lizenzen.'),
    Subtopic(id: 'an-kollaboration', topicId: 'anwendungssysteme', title: 'Kollaboration und Social Media',
        goal: 'Du bewertest Werkzeuge für Zusammenarbeit und Unternehmenskommunikation.'),

    // Netzwerke & Cloud
    Subtopic(id: 'nw-modelle', topicId: 'netzwerke', title: 'OSI- und TCP/IP-Modell',
        goal: 'Du ordnest Geräte und Protokolle den Schichten zu.'),
    Subtopic(id: 'nw-geraete', topicId: 'netzwerke', title: 'Netzwerkgeräte und Verkabelung',
        goal: 'Du unterscheidest Switch, Router und Access Point und wählst Kabel.'),
    Subtopic(id: 'nw-ipv4', topicId: 'netzwerke', title: 'IPv4 und Subnetting',
        goal: 'Du berechnest Netzadresse, Broadcast und Hostanzahl eines Subnetzes.'),
    Subtopic(id: 'nw-ipv6', topicId: 'netzwerke', title: 'IPv6',
        goal: 'Du kürzt IPv6-Adressen und kennst die wichtigsten Adresstypen.'),
    Subtopic(id: 'nw-dienste', topicId: 'netzwerke', title: 'Protokolle, Dienste und Ports',
        goal: 'Du erklärst DHCP, DNS und die wichtigsten Anwendungsprotokolle mit Ports.'),
    Subtopic(id: 'nw-cloud', topicId: 'netzwerke', title: 'Cloud und Virtualisierung',
        goal: 'Du unterscheidest IaaS, PaaS und SaaS sowie VMs und Container.'),

    // ================================================================= 04
    // Anforderungen
    Subtopic(id: 'af-dokumente', topicId: 'anforderungen', title: 'Lastenheft und Pflichtenheft',
        goal: 'Du unterscheidest beide Dokumente nach Verfasser, Inhalt und Zeitpunkt.'),
    Subtopic(id: 'af-arten', topicId: 'anforderungen', title: 'Arten von Anforderungen',
        goal: 'Du trennst funktionale von nicht-funktionalen Anforderungen.'),
    Subtopic(id: 'af-erhebung', topicId: 'anforderungen', title: 'Anforderungen erheben',
        goal: 'Du wählst passende Erhebungstechniken und formulierst gute Anforderungen.'),

    // UML & Modellierung
    Subtopic(id: 'u-usecase', topicId: 'uml_modellierung', title: 'Anwendungsfalldiagramm',
        goal: 'Du liest und zeichnest Akteure, Anwendungsfälle und ihre Beziehungen.'),
    Subtopic(id: 'u-klassen', topicId: 'uml_modellierung', title: 'Klassendiagramm',
        goal: 'Du liest Klassen mit Attributen, Methoden, Sichtbarkeiten und Multiplizitäten.'),
    Subtopic(id: 'u-aktivitaet', topicId: 'uml_modellierung', title: 'Aktivitätsdiagramm',
        goal: 'Du modellierst Abläufe mit Verzweigungen und parallelen Pfaden.'),

    // Programmierlogik
    Subtopic(id: 'pl-datentypen', topicId: 'programmierlogik', title: 'Variablen und Datentypen',
        goal: 'Du wählst für einen Wert den passenden Datentyp.'),
    Subtopic(id: 'pl-kontrollstrukturen', topicId: 'programmierlogik', title: 'Kontrollstrukturen',
        goal: 'Du setzt Verzweigungen und Schleifen richtig ein.'),
    Subtopic(id: 'pl-pseudocode', topicId: 'programmierlogik', title: 'Pseudocode lesen und schreiben',
        goal: 'Du beschreibst einen Algorithmus in Pseudocode.'),
    Subtopic(id: 'pl-schreibtischtest', topicId: 'programmierlogik', title: 'Schreibtischtest',
        goal: 'Du verfolgst Variablenwerte Schritt für Schritt in einer Tabelle.'),

    // Objektorientierung
    Subtopic(id: 'oo-grundbegriffe', topicId: 'objektorientierung', title: 'Klasse, Objekt, Attribut, Methode',
        goal: 'Du unterscheidest Bauplan und Exemplar und ihre Bestandteile.'),
    Subtopic(id: 'oo-kapselung', topicId: 'objektorientierung', title: 'Kapselung und Sichtbarkeit',
        goal: 'Du schützt Daten mit Sichtbarkeiten, Gettern und Settern.'),
    Subtopic(id: 'oo-konstruktor', topicId: 'objektorientierung', title: 'Objekte erzeugen und nutzen',
        goal: 'Du erklärst Konstruktoren und das Zusammenspiel von Objekten.'),

    // Datenmodellierung
    Subtopic(id: 'dm-erm', topicId: 'datenmodellierung', title: 'Das ER-Modell',
        goal: 'Du modellierst Entitäten, Attribute und Beziehungen.'),
    Subtopic(id: 'dm-kardinalitaet', topicId: 'datenmodellierung', title: 'Kardinalitäten',
        goal: 'Du bestimmst 1:1-, 1:n- und n:m-Beziehungen und löst n:m auf.'),
    Subtopic(id: 'dm-schluessel', topicId: 'datenmodellierung', title: 'Schlüssel',
        goal: 'Du setzt Primär- und Fremdschlüssel richtig ein.'),
    Subtopic(id: 'dm-normalisierung', topicId: 'datenmodellierung', title: 'Normalisierung',
        goal: 'Du bringst eine Tabelle schrittweise in die dritte Normalform.'),

    // Web & Internet
    Subtopic(id: 'wi-url', topicId: 'web_internet', title: 'Aufbau einer URL',
        goal: 'Du zerlegst eine URL in ihre Bestandteile.'),
    Subtopic(id: 'wi-http', topicId: 'web_internet', title: 'HTTP und HTTPS',
        goal: 'Du erklärst Anfrage, Antwort, Methoden und Statuscodes.'),
    Subtopic(id: 'wi-aufruf', topicId: 'web_internet', title: 'Was beim Seitenaufruf passiert',
        goal: 'Du beschreibst den Weg von der Eingabe der Adresse bis zur fertigen Seite.'),
    Subtopic(id: 'wi-html', topicId: 'web_internet', title: 'HTML und CSS',
        goal: 'Du trennst Struktur und Gestaltung einer Webseite.'),
    Subtopic(id: 'wi-barrierefrei', topicId: 'web_internet', title: 'Barrierefreiheit',
        goal: 'Du prüfst Webangebote auf barrierefreie Gestaltung.'),

    // Daten & Multimedia
    Subtopic(id: 'md-zahlensysteme', topicId: 'multimedia_daten', title: 'Zahlensysteme',
        goal: 'Du rechnest zwischen Dezimal-, Binär- und Hexadezimalsystem um.'),
    Subtopic(id: 'md-zeichen', topicId: 'multimedia_daten', title: 'Zeichensätze',
        goal: 'Du erklärst ASCII, Unicode und UTF-8.'),
    Subtopic(id: 'md-datenmengen', topicId: 'multimedia_daten', title: 'Datenmengen berechnen',
        goal: 'Du berechnest die Größe von Bildern, Audio und Video.'),
    Subtopic(id: 'md-uebertragung', topicId: 'multimedia_daten', title: 'Übertragungsdauer berechnen',
        goal: 'Du berechnest, wie lange eine Übertragung bei gegebener Bandbreite dauert.'),
    Subtopic(id: 'md-kompression', topicId: 'multimedia_daten', title: 'Kompression und Formate',
        goal: 'Du unterscheidest verlustfreie und verlustbehaftete Verfahren.'),

    // KI-Unterstützung
    Subtopic(id: 'ki-grundlagen', topicId: 'ki_grundlagen', title: 'Was KI ist und was nicht',
        goal: 'Du erklärst Grundbegriffe wie Machine Learning, Training und Sprachmodell.'),
    Subtopic(id: 'ki-einsatz', topicId: 'ki_grundlagen', title: 'KI im Arbeitsalltag',
        goal: 'Du nennst sinnvolle Einsatzfelder und formulierst gute Prompts.'),
    Subtopic(id: 'ki-grenzen', topicId: 'ki_grundlagen', title: 'Grenzen, Risiken und Recht',
        goal: 'Du erkennst Halluzinationen, Bias und Datenschutzrisiken.'),

    // ================================================================= 05
    // Qualitätsmanagement
    Subtopic(id: 'qm-grundlagen', topicId: 'qualitaetsmanagement', title: 'Qualität und Qualitätssicherung',
        goal: 'Du unterscheidest konstruktive und analytische Qualitätssicherung.'),
    Subtopic(id: 'qm-merkmale', topicId: 'qualitaetsmanagement', title: 'Qualitätsanforderungen',
        goal: 'Du formulierst nicht funktionale Anforderungen messbar und prüfst die Verfügbarkeit.'),
    Subtopic(id: 'qm-pdca', topicId: 'qualitaetsmanagement', title: 'PDCA und kontinuierliche Verbesserung',
        goal: 'Du wendest den PDCA-Zyklus auf ein Problem an.'),

    // Testverfahren
    Subtopic(id: 'ts-stufen', topicId: 'testen', title: 'Teststufen',
        goal: 'Du ordnest Tests den Stufen vom Modul- bis zum Abnahmetest zu.'),
    Subtopic(id: 'ts-verfahren', topicId: 'testen', title: 'Black-Box und White-Box',
        goal: 'Du unterscheidest die Verfahren danach, ob der Code bekannt ist.'),
    Subtopic(id: 'ts-testfaelle', topicId: 'testen', title: 'Testfälle entwerfen',
        goal: 'Du bildest Äquivalenzklassen und Grenzwerttests.'),
    Subtopic(id: 'ts-protokoll', topicId: 'testen', title: 'Testplanung und Testprotokoll',
        goal: 'Du dokumentierst Tests nachvollziehbar.'),

    // ================================================================= 06
    // Schutzziele & Bedrohungen
    Subtopic(id: 'sz-schutzziele', topicId: 'schutzziele_bedrohungen', title: 'Die Schutzziele',
        goal: 'Du ordnest Vorfälle Vertraulichkeit, Integrität und Verfügbarkeit zu.'),
    Subtopic(id: 'sz-schadsoftware', topicId: 'schutzziele_bedrohungen', title: 'Schadsoftware',
        goal: 'Du unterscheidest Virus, Wurm, Trojaner, Ransomware und Co.'),
    Subtopic(id: 'sz-angriffe', topicId: 'schutzziele_bedrohungen', title: 'Angriffe und Social Engineering',
        goal: 'Du erkennst Phishing, DoS und Man-in-the-Middle-Angriffe.'),
    Subtopic(id: 'sz-schutzbedarf', topicId: 'schutzziele_bedrohungen', title: 'Schutzbedarf und IT-Grundschutz',
        goal: 'Du stellst den Schutzbedarf nach dem Vorgehen des BSI fest.'),

    // Technische Schutzmaßnahmen
    Subtopic(id: 'sm-firewall', topicId: 'sicherheitsmassnahmen', title: 'Firewall und DMZ',
        goal: 'Du erklärst Paketfilter, Proxy und den Aufbau einer DMZ.'),
    Subtopic(id: 'sm-backup', topicId: 'sicherheitsmassnahmen', title: 'Datensicherung',
        goal: 'Du unterscheidest Voll-, inkrementelle und differenzielle Sicherung.'),
    Subtopic(id: 'sm-wlan', topicId: 'sicherheitsmassnahmen', title: 'Sicheres WLAN',
        goal: 'Du konfigurierst ein WLAN nach aktuellem Stand der Technik.'),
    Subtopic(id: 'sm-zugriff', topicId: 'sicherheitsmassnahmen', title: 'Zugriffsschutz und Härtung',
        goal: 'Du setzt Minimalprinzip und Härtung in konkreten Maßnahmen um.'),

    // Kryptographie & Authentifizierung
    Subtopic(id: 'kr-symmetrisch', topicId: 'kryptographie_auth', title: 'Symmetrische Verschlüsselung',
        goal: 'Du erklärst ein gemeinsames Schlüssel-Verfahren und sein Schlüsselproblem.'),
    Subtopic(id: 'kr-asymmetrisch', topicId: 'kryptographie_auth', title: 'Asymmetrische Verschlüsselung',
        goal: 'Du erklärst öffentliche und private Schlüssel, auch für Signaturen.'),
    Subtopic(id: 'kr-hybrid', topicId: 'kryptographie_auth', title: 'Hybride Verfahren und Zertifikate',
        goal: 'Du erklärst, wie TLS beide Verfahren kombiniert und wozu Zertifikate dienen.'),
    Subtopic(id: 'kr-hash', topicId: 'kryptographie_auth', title: 'Hashverfahren',
        goal: 'Du nennst Eigenschaften und Einsatzzwecke von Hashfunktionen.'),
    Subtopic(id: 'kr-auth', topicId: 'kryptographie_auth', title: 'Authentifizierung und 2FA',
        goal: 'Du kombinierst Faktoren sicher und kennst gute Passwortregeln.'),

    // Datenschutz & DSGVO
    Subtopic(id: 'ds-grundlagen', topicId: 'datenschutz', title: 'Personenbezogene Daten',
        goal: 'Du erkennst personenbezogene und besonders schützenswerte Daten.'),
    Subtopic(id: 'ds-grundsaetze', topicId: 'datenschutz', title: 'Grundsätze der Verarbeitung',
        goal: 'Du prüfst eine Verarbeitung gegen die Grundsätze der DSGVO.'),
    Subtopic(id: 'ds-rechte', topicId: 'datenschutz', title: 'Rechte der Betroffenen',
        goal: 'Du ordnest Anfragen den Betroffenenrechten zu.'),
    Subtopic(id: 'ds-anonym', topicId: 'datenschutz', title: 'Anonymisieren und Pseudonymisieren',
        goal: 'Du unterscheidest beide Verfahren und ihre rechtlichen Folgen.'),
    Subtopic(id: 'ds-tom', topicId: 'datenschutz', title: 'Technische und organisatorische Maßnahmen',
        goal: 'Du ordnest Schutzmaßnahmen den Kontrollzielen zu.'),

    // ================================================================= 07
    // Verträge & Recht
    Subtopic(id: 'vt-zustandekommen', topicId: 'vertraege', title: 'Wie ein Vertrag zustande kommt',
        goal: 'Du erkennst Antrag und Annahme und wann ein Vertrag gilt.'),
    Subtopic(id: 'vt-arten', topicId: 'vertraege', title: 'Vertragsarten',
        goal: 'Du unterscheidest Kauf-, Werk-, Dienst-, Miet- und Leasingvertrag.'),
    Subtopic(id: 'vt-urheber', topicId: 'vertraege', title: 'Urheberrecht und Lizenzen',
        goal: 'Du erklärst, wem Software gehört und was eine Lizenz erlaubt.'),

    // Service & SLA
    Subtopic(id: 'sla-inhalte', topicId: 'sla_service', title: 'Service Level Agreements',
        goal: 'Du liest ein SLA und rechnest mit Verfügbarkeit und Reaktionszeit.'),
    Subtopic(id: 'sla-support', topicId: 'sla_service', title: 'Support-Level und Eskalation',
        goal: 'Du ordnest Anfragen dem 1st-, 2nd- oder 3rd-Level zu.'),
    Subtopic(id: 'sla-itil', topicId: 'sla_service', title: 'Incident, Problem, Change',
        goal: 'Du unterscheidest die ITIL-Prozesse an Beispielen.'),

    // Leistungsstörungen & Abnahme
    Subtopic(id: 'ls-verzug', topicId: 'leistungsstoerungen', title: 'Verzug',
        goal: 'Du erkennst Liefer- und Zahlungsverzug und die Rechte daraus.'),
    Subtopic(id: 'ls-maengel', topicId: 'leistungsstoerungen', title: 'Mängel und Gewährleistung',
        goal: 'Du ordnest Mängel ein und kennst die Rechte des Käufers.'),
    Subtopic(id: 'ls-abnahme', topicId: 'leistungsstoerungen', title: 'Abnahme und Protokoll',
        goal: 'Du erklärst die rechtliche Wirkung der Abnahme.'),

    // Change Management
    Subtopic(id: 'cm-lewin', topicId: 'change_management', title: 'Veränderung nach Lewin',
        goal: 'Du ordnest Maßnahmen den Phasen Auftauen, Verändern, Einfrieren zu.'),
    Subtopic(id: 'cm-widerstand', topicId: 'change_management', title: 'Widerstände',
        goal: 'Du erkennst Ursachen von Widerstand und reagierst angemessen.'),
    Subtopic(id: 'cm-kaizen', topicId: 'change_management', title: 'Kaizen und KVP',
        goal: 'Du grenzt schrittweise Verbesserung von großen Umbrüchen ab.'),
  ];

  static final Map<String, Subtopic> map = {for (final s in all) s.id: s};

  static Subtopic? byId(String? id) => id == null ? null : map[id];

  /// Lektionen eines Themas in Lernreihenfolge.
  static List<Subtopic> ofTopic(String topicId) =>
      all.where((s) => s.topicId == topicId).toList(growable: false);
}
