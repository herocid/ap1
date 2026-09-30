import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 02 - Kundenbeziehungen und Kommunikation.
final List<Flashcard> cardsA02 = [
  // Kommunikationsmodelle
  karte(
    'k-km-1',
    'k-modelle',
    'Sender-Empfänger-Modell',
    'Sender verschlüsselt, Kanal überträgt, Empfänger entschlüsselt. Verständigung klappt nur mit gemeinsamem Zeichenvorrat und ohne zu starke Störungen.',
  ),
  karte(
    'k-km-2',
    'k-modelle',
    'Vier Seiten einer Nachricht (Schulz von Thun)',
    'Sachinhalt, Selbstoffenbarung, Beziehung, Appell.',
    'Der Empfänger entscheidet, mit welchem Ohr er hört.',
  ),
  karte(
    'k-km-3',
    'k-modelle',
    'Man kann nicht nicht kommunizieren',
    'Erstes Axiom nach Watzlawick: Auch Schweigen und Körpersprache senden Botschaften.',
  ),
  karte(
    'k-km-4',
    'k-modelle',
    'Verbal, paraverbal, nonverbal',
    'Verbal: Worte. Paraverbal: Tonfall, Tempo, Lautstärke. Nonverbal: Mimik, Gestik, Haltung.',
  ),
  karte(
    'k-km-5',
    'k-modelle',
    'Inhalts- und Beziehungsaspekt',
    'Jede Nachricht hat beide. Die Beziehung bestimmt, wie der Inhalt verstanden wird.',
  ),
  karte(
    'k-km-6',
    'k-modelle',
    'Eisbergmodell',
    'Nur die Sachebene ist sichtbar (ca. 20 %). Darunter liegen Gefühle, Werte und Erfahrungen (ca. 80 %) - sie steuern, wie die Sache ankommt.',
  ),
  karte(
    'k-km-7',
    'k-modelle',
    'Interpunktion (Watzlawick)',
    'Jeder sieht den Auslöser eines Streits beim anderen: „Ich schweige, weil du nörgelst.“ - „Ich nörgle, weil du schweigst.“',
  ),
  karte(
    'k-km-8',
    'k-modelle',
    'Kongruenz',
    'Verbale, paraverbale und nonverbale Signale passen zusammen. Widersprechen sie sich, glaubt der Empfänger meist der Körpersprache.',
  ),
  karte(
    'k-km-9',
    'k-modelle',
    'Appell-Seite einer Nachricht',
    'Was der Sender beim Empfänger erreichen will - steht oft nicht wörtlich im Satz: „Der Drucker ist leer.“ → „Füll Papier nach.“',
  ),

  // Gesprächsführung
  karte(
    'k-kg-1',
    'k-gespraech',
    'Aktives Zuhören',
    'Paraphrasieren, nachfragen, Gefühle ansprechen, zusammenfassen.',
  ),
  karte(
    'k-kg-2',
    'k-gespraech',
    'Offene Frage',
    'W-Frage, die eine ausführliche Antwort ermöglicht: „Wie gehen Sie heute vor?“',
    'Zum Informationen sammeln - vor allem am Gesprächsanfang.',
  ),
  karte(
    'k-kg-3',
    'k-gespraech',
    'Geschlossene Frage',
    'Frage, die mit Ja oder Nein beantwortet wird. Klärt Fakten und präzisiert.',
  ),
  karte(
    'k-kg-4',
    'k-gespraech',
    'Suggestivfrage',
    'Frage, die die Antwort vorgibt: „Sie wollen doch sicher ...?“ - manipulativ, im Kundengespräch vermeiden.',
  ),
  karte(
    'k-kg-5',
    'k-gespraech',
    'Ich-Botschaft',
    'Beschreibt die eigene Wahrnehmung statt den anderen anzugreifen: „Ich brauche die Fehlermeldung, um ...“',
  ),
  karte(
    'k-kg-6',
    'k-gespraech',
    'Trichtertechnik',
    'Von offenen über gezielte zu geschlossenen Fragen, am Ende eine Kontrollfrage - dann das Ergebnis festhalten.',
  ),
  karte(
    'k-kg-7',
    'k-gespraech',
    'Paraphrasieren vs. Verbalisieren',
    'Paraphrasieren: den Inhalt mit eigenen Worten wiedergeben. Verbalisieren: das Gefühl des anderen ansprechen.',
  ),
  karte(
    'k-kg-8',
    'k-gespraech',
    'Alternativfrage',
    'Bietet zwei Möglichkeiten zur Wahl: „Passt Ihnen Dienstag oder Donnerstag?“ - führt zu einer Entscheidung.',
  ),
  karte(
    'k-kg-9',
    'k-gespraech',
    'Phasen eines Kundengesprächs',
    'Kontakt, Bedarfsermittlung, Lösung mit Nutzen, Einwände klären, Abschluss, Nachbereitung.',
  ),

  // Kunden beraten
  karte(
    'k-kk-1',
    'k-kunde',
    'Adressatengerecht',
    'Sprache, Detailtiefe und Beispiele an Vorwissen und Interessen des Gegenübers anpassen.',
  ),
  karte(
    'k-kk-2',
    'k-kunde',
    'Lebenszyklus eines Tickets',
    'Erfassen, kategorisieren, priorisieren, bearbeiten bzw. weiterleiten, Lösung dokumentieren, schließen.',
  ),
  karte(
    'k-kk-3',
    'k-kunde',
    'Priorität eines Tickets',
    'Ergibt sich aus Dringlichkeit und Auswirkung - wie eilig ist es und wie viele sind betroffen?',
  ),
  karte(
    'k-kk-4',
    'k-kunde',
    'Umgang mit Beschwerden',
    'Zuhören, ruhig bleiben, Verständnis zeigen, konkrete Lösung anbieten, nachfassen.',
  ),
  karte(
    'k-kk-5',
    'k-kunde',
    'Synchron vs. asynchron',
    'Synchron: beide gleichzeitig (Telefon, Videokonferenz). Asynchron: zeitversetzt (E-Mail, Ticket) - leichter zu dokumentieren.',
  ),
  karte(
    'k-kk-6',
    'k-kunde',
    'Interner Kunde',
    'Kollegen oder Abteilungen, die deine Leistung nutzen - z. B. der Vertrieb, den der IT-Support betreut.',
  ),
  karte(
    'k-kk-7',
    'k-kunde',
    'Kundentyp „Besserwisser“',
    'Sein Wissen anerkennen, sachlich-fachlich bleiben, nicht um Recht streiten.',
  ),
  karte(
    'k-kk-8',
    'k-kunde',
    'Wann wird ein Ticket geschlossen?',
    'Erst wenn die Lösung dokumentiert und vom Kunden bestätigt ist.',
  ),

  // Teamphasen
  karte(
    'k-tt-1',
    'te-phasen',
    'Teamphasen nach Tuckman',
    'Forming, Storming, Norming, Performing - ergänzt um Adjourning.',
  ),
  karte(
    'k-tt-2',
    'te-phasen',
    'Storming',
    'Konfliktphase: Rollen und Einfluss werden ausgehandelt. Normal und nötig - Konflikte moderieren, nicht unterdrücken.',
  ),
  karte(
    'k-tt-3',
    'te-phasen',
    'Norming',
    'Das Team einigt sich auf Regeln, Abläufe und Umgangsformen.',
  ),
  karte(
    'k-tt-4',
    'te-phasen',
    'Performing',
    'Das Team arbeitet selbstständig und effektiv an der Aufgabe. Führung lässt Freiraum.',
  ),
  karte(
    'k-tt-5',
    'te-phasen',
    'Forming',
    'Orientierungsphase: höflich, vorsichtig, abwartend. Die Leitung klärt Ziele und Rollen.',
  ),
  karte(
    'k-tt-6',
    'te-phasen',
    'Adjourning',
    'Auflösungsphase (1977 ergänzt): Ergebnisse würdigen, Erfahrungen sichern, Abschied nehmen.',
  ),
  karte(
    'k-tt-7',
    'te-phasen',
    'Rückfall in frühere Phasen',
    'Neue Mitglieder oder geänderte Ziele werfen ein Team oft zurück, z. B. ins Storming.',
  ),
  karte(
    'k-tt-8',
    'te-phasen',
    'Teamrollen nach Belbin',
    'Neun Rollen: Macher, Umsetzer, Perfektionist (Handeln); Koordinator, Teamarbeiter, Wegbereiter (Kommunikation); Neuerer, Beobachter, Spezialist (Wissen).',
  ),

  // Feedback
  karte(
    'k-tf-1',
    'te-feedback',
    'Johari-Fenster: blinder Fleck',
    'Was andere an mir sehen, ich selbst aber nicht. Feedback verkleinert ihn.',
  ),
  karte(
    'k-tf-2',
    'te-feedback',
    'Regeln für gutes Feedback',
    'Ich-Botschaft, konkret, beschreibend statt bewertend, zeitnah, mit Verbesserungsvorschlag.',
  ),
  karte(
    'k-tf-3',
    'te-feedback',
    'Feedback annehmen',
    'Zuhören, nicht rechtfertigen, nachfragen, bedanken.',
  ),
  karte(
    'k-tf-4',
    'te-feedback',
    'Gute Fehlerkultur',
    'Fehler werden offen angesprochen und als Lernchance genutzt - ohne Angst vor Strafe.',
  ),
  karte(
    'k-tf-5',
    'te-feedback',
    'Johari-Fenster: vier Bereiche',
    'Öffentliche Person (allen bekannt), blinder Fleck (nur anderen), private Person (nur mir), Unbekanntes (niemandem).',
  ),
  karte(
    'k-tf-6',
    'te-feedback',
    'WWW-Methode',
    'Feedback in drei Schritten: Wahrnehmung, Wirkung, Wunsch - jeweils als Ich-Botschaft.',
  ),
  karte(
    'k-tf-7',
    'te-feedback',
    'Sandwich-Methode',
    'Lob - Kritik - Lob. Wirkt wertschätzend, nutzt sich bei häufigem Einsatz aber ab.',
  ),
  karte(
    'k-tf-8',
    'te-feedback',
    'Selbstoffenbarung im Johari-Fenster',
    'Wer etwas von sich erzählt, verkleinert den privaten Bereich und vergrößert die öffentliche Person.',
  ),

  // Konflikte
  karte(
    'k-tk-1',
    'te-konflikte',
    'Sachkonflikt vs. Beziehungskonflikt',
    'Sachkonflikt: Streit um Wege oder Methoden. Beziehungskonflikt: gestörtes Verhältnis zwischen Personen.',
  ),
  karte(
    'k-tk-2',
    'te-konflikte',
    'Konsens',
    'Gemeinsam erarbeitete Lösung, bei der beide Seiten gewinnen - die nachhaltigste Konfliktlösung.',
  ),
  karte(
    'k-tk-3',
    'te-konflikte',
    'Eskalationsstufen nach Glasl',
    'Neun Stufen in drei Phasen: win-win, win-lose, lose-lose.',
  ),
  karte(
    'k-tk-4',
    'te-konflikte',
    'AGG',
    'Allgemeines Gleichbehandlungsgesetz: verbietet Benachteiligung u. a. wegen Herkunft, Geschlecht, Religion, Behinderung, Alter oder sexueller Identität.',
  ),
  karte(
    'k-tk-5',
    'te-konflikte',
    'Mediation',
    'Ein neutraler, allparteilicher Dritter strukturiert das Gespräch - die Parteien finden die Lösung freiwillig selbst.',
  ),
  karte(
    'k-tk-6',
    'te-konflikte',
    'Kompromiss vs. Konsens',
    'Kompromiss: beide geben etwas nach. Konsens: neue Lösung, die die Interessen beider voll erfüllt.',
  ),
  karte(
    'k-tk-7',
    'te-konflikte',
    'Konfliktlösung nach Schwarz',
    'Sechs Grundmuster: Flucht, Vernichtung (Kampf), Unterordnung, Delegation, Kompromiss, Konsens.',
  ),
  karte(
    'k-tk-8',
    'te-konflikte',
    'Verteilungskonflikt',
    'Streit um knappe Ressourcen - z. B. zwei Teams wollen denselben Testserver.',
  ),

  // Harvard-Konzept
  karte(
    'k-vh-1',
    've-harvard',
    'Die vier Prinzipien des Harvard-Konzepts',
    'Menschen und Probleme trennen, Interessen statt Positionen, Optionen zum beiderseitigen Vorteil, neutrale Beurteilungskriterien.',
  ),
  karte(
    'k-vh-2',
    've-harvard',
    'Position vs. Interesse',
    'Position: die Forderung. Interesse: der Grund dahinter. Verhandelt wird über Interessen.',
  ),
  karte(
    'k-vh-3',
    've-harvard',
    'BATNA',
    'Beste Alternative zur Verhandlungslösung - zeigt, ab wann ein Angebot schlechter ist als keine Einigung.',
  ),
  karte(
    'k-vh-4',
    've-harvard',
    'Neutrale Beurteilungskriterien',
    'Objektive Maßstäbe wie Marktpreise, Normen oder Gutachten - statt Druck und Willkür.',
  ),
  karte(
    'k-vh-5',
    've-harvard',
    'Menschen und Probleme trennen',
    'Hart in der Sache, respektvoll zur Person: Gefühle anerkennen, aktiv zuhören, keine Angriffe.',
  ),
  karte(
    'k-vh-6',
    've-harvard',
    'Optionen zum beiderseitigen Vorteil',
    'Vor der Entscheidung mehrere Lösungen entwickeln - den Kuchen vergrößern statt ihn nur zu teilen.',
  ),
  karte(
    'k-vh-7',
    've-harvard',
    'Win-Win',
    'Ergebnis, bei dem die Interessen beider Seiten erfüllt sind - das Ziel des Harvard-Konzepts.',
  ),
  karte(
    'k-vh-8',
    've-harvard',
    'Weich, hart, sachgerecht',
    'Weich: nachgeben. Hart: Druck ausüben, siegen wollen. Sachgerecht (Harvard): Interessen, Optionen, neutrale Kriterien.',
  ),

  // Einwände
  karte(
    'k-ve-1',
    've-einwaende',
    'Nutzenargumentation',
    'Vom Merkmal über den Vorteil zum konkreten Nutzen für den Kunden argumentieren.',
  ),
  karte(
    'k-ve-2',
    've-einwaende',
    'Ja-aber-Methode',
    'Dem Einwand zunächst zustimmen, dann um ein Gegenargument ergänzen.',
  ),
  karte(
    'k-ve-3',
    've-einwaende',
    'Bumerang-Methode',
    'Den Einwand selbst als Argument für das Produkt nutzen.',
  ),
  karte(
    'k-ve-4',
    've-einwaende',
    'Einwand vs. Vorwand',
    'Einwand: echter Zweifel, sachlich ausräumen. Vorwand: vorgeschobener Grund, per Rückfrage den wahren Grund finden.',
  ),
  karte(
    'k-ve-5',
    've-einwaende',
    'Merkmal - Vorteil - Nutzen',
    'Merkmal: was das Produkt hat. Vorteil: was es besser kann. Nutzen: was der Kunde konkret davon hat.',
  ),
  karte(
    'k-ve-6',
    've-einwaende',
    'Rückfrage-Methode',
    'Den Einwand hinterfragen: „Was genau meinen Sie mit zu teuer?“ - klärt den wahren Grund.',
  ),
  karte(
    'k-ve-7',
    've-einwaende',
    'Preis nennen (Sandwich)',
    'Den Preis zwischen zwei Nutzenaussagen nennen: Nutzen - Preis - Nutzen.',
  ),
  karte(
    'k-ve-8',
    've-einwaende',
    'Kompensationsmethode',
    'Einen Nachteil zugeben und durch Vorteile ausgleichen: „Die Einrichtung dauert länger, dafür ...“',
  ),

  // Präsentation
  karte(
    'k-pp-1',
    'pr-praesentation',
    'Aufbau einer Präsentation',
    'Einleitung (Aufmerksamkeit, Thema), Hauptteil (Inhalte, Belege), Schluss (Zusammenfassung, Handlungsaufforderung).',
  ),
  karte(
    'k-pp-2',
    'pr-praesentation',
    'Balkendiagramm',
    'Zeigt Vergleiche - zum Beispiel die Kosten mehrerer Angebote.',
  ),
  karte(
    'k-pp-3',
    'pr-praesentation',
    'Liniendiagramm',
    'Zeigt Entwicklungen über die Zeit - zum Beispiel Ticketzahlen pro Monat.',
  ),
  karte(
    'k-pp-4',
    'pr-praesentation',
    'Kreisdiagramm',
    'Zeigt Anteile an einem Ganzen - die Teile ergeben 100 %.',
  ),
  karte(
    'k-pp-5',
    'pr-praesentation',
    'Zielgruppenanalyse',
    'Vorwissen, Interessen, Erwartungen und Entscheidungsrolle der Zuhörer klären, bevor Inhalte ausgewählt werden.',
  ),
  karte(
    'k-pp-6',
    'pr-praesentation',
    'Regeln für Folien',
    'Eine Kernaussage pro Folie, wenig Text, große serifenlose Schrift, Diagramme statt Zahlenkolonnen, einheitliches Layout.',
  ),
  karte(
    'k-pp-7',
    'pr-praesentation',
    'Flipchart vs. Beamer',
    'Flipchart: vorbereitbar, bleibt hängen, nur für kleine Gruppen. Beamer: Bilder und Videos, aber abhängig von Technik.',
  ),
  karte(
    'k-pp-8',
    'pr-praesentation',
    'Irreführendes Diagramm',
    'Achse nicht ab 0, fehlende Einheiten oder 3D-Effekte übertreiben oder verzerren Unterschiede.',
  ),

  // Quellen
  karte(
    'k-pq-1',
    'pr-quellen',
    'Primärquelle',
    'Originalinformation, z. B. Herstellerdokumentation, Gesetzestext, eigene Messung.',
  ),
  karte(
    'k-pq-2',
    'pr-quellen',
    'Sekundärquelle',
    'Aufbereitete Information aus zweiter Hand, z. B. Fachartikel, Lexikon, Forum.',
  ),
  karte(
    'k-pq-3',
    'pr-quellen',
    'Kriterien für Quellen',
    'Aktualität, Urheber, Objektivität, Nachprüfbarkeit, Relevanz.',
  ),
  karte(
    'k-pq-4',
    'pr-quellen',
    'KI-Antworten als Quelle?',
    'Nein. Sie können erfunden sein und müssen an einer Primärquelle überprüft werden.',
  ),
  karte(
    'k-pq-5',
    'pr-quellen',
    'Zitatrecht (§ 51 UrhG)',
    'Zitieren ohne Erlaubnis ist erlaubt bei Zitatzweck, angemessenem Umfang, unveränderter Übernahme und Quellenangabe.',
  ),
  karte(
    'k-pq-6',
    'pr-quellen',
    'Creative Commons: BY, SA, NC, ND',
    'BY Namensnennung, SA Weitergabe unter gleichen Bedingungen, NC nicht kommerziell, ND keine Bearbeitung.',
  ),
  karte(
    'k-pq-7',
    'pr-quellen',
    'Quellenangabe für Internetquellen',
    'Autor (Jahr): Titel. Website. URL (abgerufen am TT.MM.JJJJ).',
  ),
  karte(
    'k-pq-8',
    'pr-quellen',
    'Direktes vs. indirektes Zitat',
    'Direkt: wörtlich in Anführungszeichen. Indirekt: sinngemäß in eigenen Worten mit „vgl.“ - beide mit Quelle.',
  ),

  // Angebot
  karte(
    'k-pa-1',
    'pr-angebot',
    'Anfrage',
    'Unverbindliche Erkundigung nach Leistung, Preis und Bedingungen.',
  ),
  karte(
    'k-pa-2',
    'pr-angebot',
    'Angebot',
    'Verbindliche Willenserklärung. Wird es rechtzeitig und unverändert angenommen, entsteht ein Vertrag.',
  ),
  karte(
    'k-pa-3',
    'pr-angebot',
    'Freizeichnungsklausel',
    'Schränkt die Bindung eines Angebots ein, z. B. „freibleibend“ oder „solange der Vorrat reicht“.',
  ),
  karte(
    'k-pa-4',
    'pr-angebot',
    'Ist ein Katalog ein Angebot?',
    'Nein - eine Aufforderung an die Allgemeinheit, selbst ein Angebot abzugeben.',
  ),
  karte(
    'k-pa-5',
    'pr-angebot',
    'Bezugskalkulation',
    'Listeneinkaufspreis − Rabatt = Zieleinkaufspreis − Skonto = Bareinkaufspreis + Bezugskosten = Bezugspreis.',
  ),
  karte(
    'k-pa-6',
    'pr-angebot',
    'Wovon wird Skonto berechnet?',
    'Vom Zieleinkaufspreis - also nach Abzug des Rabatts, nicht vom Listenpreis.',
  ),
  karte(
    'k-pa-7',
    'pr-angebot',
    'Angebotsvergleich: quantitativ vs. qualitativ',
    'Quantitativ: Bezugspreis in Euro. Qualitativ: Lieferzeit, Service, Garantie, Zuverlässigkeit - z. B. per Nutzwertanalyse.',
  ),
  karte(
    'k-pa-8',
    'pr-angebot',
    'Bindung unter Abwesenden',
    'Ein Angebot per Brief oder E-Mail ohne Frist bindet, solange unter normalen Umständen mit einer Antwort zu rechnen ist.',
  ),
  karte(
    'k-pa-9',
    'pr-angebot',
    'Skonto als Jahreszins',
    '2 % Skonto für 20 Tage früheres Zahlen ≈ 2 % × 360 / 20 = 36 % pro Jahr - Skonto zu nutzen lohnt sich fast immer.',
  ),

  // Markt
  karte(
    'k-mm-1',
    'm-markt',
    'Polypol',
    'Viele Anbieter, viele Nachfrager - der Wettbewerb bestimmt den Preis.',
  ),
  karte(
    'k-mm-2',
    'm-markt',
    'Oligopol',
    'Wenige Anbieter, viele Nachfrager - z. B. große Cloud-Anbieter.',
  ),
  karte(
    'k-mm-3',
    'm-markt',
    'Monopol',
    'Ein Anbieter, viele Nachfrager - der Anbieter hat große Macht über den Preis.',
  ),
  karte(
    'k-mm-4',
    'm-markt',
    'Nachfragemonopol',
    'Viele Anbieter, aber nur ein Nachfrager - etwa eine Behörde, die ein Spezialsystem ausschreibt.',
  ),
  karte(
    'k-mm-5',
    'm-markt',
    'Marktanteil',
    'Eigener Umsatz (oder Absatz) / Marktvolumen × 100.',
  ),
  karte(
    'k-mm-6',
    'm-markt',
    'Marktvolumen vs. Marktpotenzial',
    'Volumen: tatsächlicher Absatz aller Anbieter. Potenzial: größtmöglicher Absatz. Das Volumen ist nie größer als das Potenzial.',
  ),
  karte(
    'k-mm-7',
    'm-markt',
    'Marktanalyse, -beobachtung, -prognose',
    'Analyse: Momentaufnahme (Zeitpunkt). Beobachtung: Entwicklung (Zeitraum). Prognose: Blick in die Zukunft.',
  ),
  karte(
    'k-mm-8',
    'm-markt',
    'Primär- vs. Sekundärforschung',
    'Primär: eigene, neue Erhebung (Befragung, Beobachtung). Sekundär: vorhandene Daten auswerten (Statistiken, Berichte).',
  ),
  karte(
    'k-mm-9',
    'm-markt',
    'Gleichgewichtspreis',
    'Preis, bei dem angebotene und nachgefragte Menge gleich sind - der Schnittpunkt von Angebots- und Nachfragekurve.',
  ),

  // Bedarf
  karte(
    'k-mb-1',
    'm-bedarf',
    'Bedürfnis - Bedarf - Nachfrage',
    'Bedürfnis: empfundener Mangel. Bedarf: Bedürfnis mit Kaufkraft. Nachfrage: Bedarf, der am Markt wirksam wird.',
  ),
  karte(
    'k-mb-2',
    'm-bedarf',
    'Maslow-Pyramide',
    'Von unten: Grundbedürfnisse, Sicherheit, soziale Bedürfnisse, Wertschätzung, Selbstverwirklichung.',
  ),
  karte(
    'k-mb-3',
    'm-bedarf',
    'Methoden der Bedarfsermittlung',
    'Gespräch mit offenen Fragen, Ist-Analyse, Beobachtung, Fragebogen.',
  ),
  karte(
    'k-mb-4',
    'm-bedarf',
    'Wunsch vs. Bedarf',
    'Gute Beratung klärt den tatsächlichen Bedarf, statt jeden Wunsch zu erfüllen.',
  ),
  karte(
    'k-mb-5',
    'm-bedarf',
    'Latenter Bedarf',
    'Bedarf, der dem Kunden (noch) nicht bewusst ist - z. B. ein fehlendes Backup, das erst die Beratung aufdeckt.',
  ),
  karte(
    'k-mb-6',
    'm-bedarf',
    'Defizit- vs. Wachstumsbedürfnisse',
    'Nach Maslow sind Stufe 1 bis 4 Defizitbedürfnisse, die Selbstverwirklichung ist ein Wachstumsbedürfnis.',
  ),
  karte(
    'k-mb-7',
    'm-bedarf',
    'Inhalte einer Bedarfsanalyse',
    'Ist-Zustand, Schwachstellen, Soll-Zustand, Rahmenbedingungen (Budget, Termine) und dokumentierter Bedarf.',
  ),
  karte(
    'k-mb-8',
    'm-bedarf',
    'Existenz-, Kultur-, Luxusbedürfnis',
    'Einteilung nach Dringlichkeit: lebensnotwendig - gehobener Lebensstandard - besonderer Luxus.',
  ),

  // Marketing
  karte(
    'k-mk-1',
    'm-marketing',
    'Die 4 P des Marketing-Mix',
    'Product, Price, Place, Promotion - Produkt-, Preis-, Distributions- und Kommunikationspolitik.',
  ),
  karte(
    'k-mk-2',
    'm-marketing',
    'AIDA',
    'Attention, Interest, Desire, Action - Stufen der Werbewirkung.',
  ),
  karte(
    'k-mk-3',
    'm-marketing',
    'Distributionspolitik',
    'Regelt, wie das Produkt zum Kunden kommt: Onlineshop, Fachhandel, Direktvertrieb.',
  ),
  karte(
    'k-mk-4',
    'm-marketing',
    'Rabattaktion - welches Instrument?',
    'Preispolitik. Die Anzeige, die darauf hinweist, ist Kommunikationspolitik.',
  ),
  karte(
    'k-mk-5',
    'm-marketing',
    'Penetrationsstrategie',
    'Niedriger Einstiegspreis, um schnell Marktanteile zu gewinnen - später wird der Preis erhöht.',
  ),
  karte(
    'k-mk-6',
    'm-marketing',
    'Abschöpfungsstrategie (Skimming)',
    'Hoher Einstiegspreis für frühe Käufer, später wird der Preis schrittweise gesenkt.',
  ),
  karte(
    'k-mk-7',
    'm-marketing',
    'BCG-Matrix',
    'Marktwachstum und relativer Marktanteil: Question Marks, Stars, Cash Cows, Poor Dogs.',
  ),
  karte(
    'k-mk-8',
    'm-marketing',
    'Produktlebenszyklus',
    'Einführung, Wachstum, Reife, Sättigung, Rückgang - der Marketing-Mix passt sich der Phase an.',
  ),

  // ABC
  karte(
    'k-ma-1',
    'm-abc',
    'ABC-Analyse - Zweck',
    'Objekte nach Bedeutung in drei Klassen teilen, um Aufwand gezielt einzusetzen.',
  ),
  karte(
    'k-ma-2',
    'm-abc',
    'A-Klasse',
    'Wenige Objekte mit dem größten Wertanteil, oft 70-80 %.',
  ),
  karte(
    'k-ma-3',
    'm-abc',
    'C-Klasse',
    'Viele Objekte mit geringem Wertanteil, oft nur 5-10 %.',
  ),
  karte(
    'k-ma-4',
    'm-abc',
    'Schritte der ABC-Analyse',
    'Werte ermitteln, absteigend sortieren, Anteile berechnen, kumulieren, Klassen zuordnen.',
  ),
  karte(
    'k-ma-5',
    'm-abc',
    'B-Klasse',
    'Mittlere Zahl von Objekten mit mittlerem Wertanteil, oft 15-20 %.',
  ),
  karte(
    'k-ma-6',
    'm-abc',
    'Jahresverbrauchswert',
    'Menge × Preis je Artikel - die Grundlage der ABC-Analyse im Einkauf.',
  ),
  karte(
    'k-ma-7',
    'm-abc',
    'Wonach wird sortiert?',
    'Absteigend nach dem Wert (Umsatz oder Menge × Preis) - nie nach der Stückzahl.',
  ),
  karte(
    'k-ma-8',
    'm-abc',
    'Maßnahmen für A-Kunden',
    'Persönlicher Ansprechpartner, intensive Betreuung, individuelle Konditionen.',
  ),

  // Rechtsformen
  karte(
    'k-mr-1',
    'm-rechtsformen',
    'GmbH',
    'Kapitalgesellschaft, 25.000 € Stammkapital, Haftung mit dem Gesellschaftsvermögen.',
  ),
  karte(
    'k-mr-2',
    'm-rechtsformen',
    'AG',
    'Kapitalgesellschaft, 50.000 € Grundkapital, Organe: Vorstand, Aufsichtsrat, Hauptversammlung.',
  ),
  karte(
    'k-mr-3',
    'm-rechtsformen',
    'KG',
    'Komplementär haftet unbeschränkt, Kommanditist nur mit seiner Einlage.',
  ),
  karte(
    'k-mr-4',
    'm-rechtsformen',
    'UG (haftungsbeschränkt)',
    'GmbH mit Stammkapital ab 1 €. Ein Viertel des Jahresüberschusses muss angespart werden.',
  ),
  karte(
    'k-mr-5',
    'm-rechtsformen',
    'OHG',
    'Personengesellschaft, alle Gesellschafter haften unbeschränkt mit ihrem Privatvermögen.',
  ),
  karte(
    'k-mr-6',
    'm-rechtsformen',
    'GbR',
    'Personengesellschaft ohne Mindestkapital; alle Gesellschafter haften unbeschränkt; Geschäftsführung gemeinsam, wenn nichts anderes vereinbart ist.',
  ),
  karte(
    'k-mr-7',
    'm-rechtsformen',
    'Haftung in der OHG',
    'Unbeschränkt (Privatvermögen), unmittelbar (direkt beim Gesellschafter), solidarisch (jeder für die ganze Schuld).',
  ),
  karte(
    'k-mr-8',
    'm-rechtsformen',
    'Organe der AG',
    'Vorstand (leitet), Aufsichtsrat (überwacht den Vorstand), Hauptversammlung (Versammlung der Aktionäre).',
  ),
  karte(
    'k-mr-9',
    'm-rechtsformen',
    'GmbH & Co. KG',
    'Eine KG, deren Komplementär eine GmbH ist - im Ergebnis haftet keine natürliche Person unbeschränkt.',
  ),
  karte(
    'k-mr-10',
    'm-rechtsformen',
    'Einzelunternehmen (e. K.)',
    'Ein Inhaber, kein Mindestkapital, unbeschränkte Haftung - er entscheidet allein.',
  ),
];
