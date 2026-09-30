import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 02 - Kundenbeziehungen und Kommunikation.
final List<Flashcard> cardsA02 = [
  // Kommunikationsmodelle
  karte('k-km-1', 'k-modelle', 'Sender-Empfänger-Modell',
      'Sender verschlüsselt, Kanal überträgt, Empfänger entschlüsselt. Verständigung klappt nur mit gemeinsamem Zeichenvorrat und ohne zu starke Störungen.'),
  karte('k-km-2', 'k-modelle', 'Vier Seiten einer Nachricht (Schulz von Thun)',
      'Sachinhalt, Selbstoffenbarung, Beziehung, Appell.',
      'Der Empfänger entscheidet, mit welchem Ohr er hört.'),
  karte('k-km-3', 'k-modelle', 'Man kann nicht nicht kommunizieren',
      'Erstes Axiom nach Watzlawick: Auch Schweigen und Körpersprache senden Botschaften.'),
  karte('k-km-4', 'k-modelle', 'Verbal, paraverbal, nonverbal',
      'Verbal: Worte. Paraverbal: Tonfall, Tempo, Lautstärke. Nonverbal: Mimik, Gestik, Haltung.'),
  karte('k-km-5', 'k-modelle', 'Inhalts- und Beziehungsaspekt',
      'Jede Nachricht hat beide. Die Beziehung bestimmt, wie der Inhalt verstanden wird.'),

  // Gesprächsführung
  karte('k-kg-1', 'k-gespraech', 'Aktives Zuhören',
      'Paraphrasieren, nachfragen, Gefühle ansprechen, zusammenfassen.'),
  karte('k-kg-2', 'k-gespraech', 'Offene Frage',
      'W-Frage, die eine ausführliche Antwort ermöglicht: „Wie gehen Sie heute vor?“',
      'Zum Informationen sammeln - vor allem am Gesprächsanfang.'),
  karte('k-kg-3', 'k-gespraech', 'Geschlossene Frage',
      'Frage, die mit Ja oder Nein beantwortet wird. Klärt Fakten und präzisiert.'),
  karte('k-kg-4', 'k-gespraech', 'Suggestivfrage',
      'Frage, die die Antwort vorgibt: „Sie wollen doch sicher ...?“ - manipulativ, im Kundengespräch vermeiden.'),
  karte('k-kg-5', 'k-gespraech', 'Ich-Botschaft',
      'Beschreibt die eigene Wahrnehmung statt den anderen anzugreifen: „Ich brauche die Fehlermeldung, um ...“'),

  // Kunden beraten
  karte('k-kk-1', 'k-kunde', 'Adressatengerecht',
      'Sprache, Detailtiefe und Beispiele an Vorwissen und Interessen des Gegenübers anpassen.'),
  karte('k-kk-2', 'k-kunde', 'Lebenszyklus eines Tickets',
      'Erfassen, kategorisieren, priorisieren, bearbeiten bzw. weiterleiten, Lösung dokumentieren, schließen.'),
  karte('k-kk-3', 'k-kunde', 'Priorität eines Tickets',
      'Ergibt sich aus Dringlichkeit und Auswirkung - wie eilig ist es und wie viele sind betroffen?'),
  karte('k-kk-4', 'k-kunde', 'Umgang mit Beschwerden',
      'Zuhören, ruhig bleiben, Verständnis zeigen, konkrete Lösung anbieten, nachfassen.'),

  // Teamphasen
  karte('k-tt-1', 'te-phasen', 'Teamphasen nach Tuckman',
      'Forming, Storming, Norming, Performing - ergänzt um Adjourning.'),
  karte('k-tt-2', 'te-phasen', 'Storming',
      'Konfliktphase: Rollen und Einfluss werden ausgehandelt. Normal und nötig - Konflikte moderieren, nicht unterdrücken.'),
  karte('k-tt-3', 'te-phasen', 'Norming',
      'Das Team einigt sich auf Regeln, Abläufe und Umgangsformen.'),
  karte('k-tt-4', 'te-phasen', 'Performing',
      'Das Team arbeitet selbstständig und effektiv an der Aufgabe. Führung lässt Freiraum.'),

  // Feedback
  karte('k-tf-1', 'te-feedback', 'Johari-Fenster: blinder Fleck',
      'Was andere an mir sehen, ich selbst aber nicht. Feedback verkleinert ihn.'),
  karte('k-tf-2', 'te-feedback', 'Regeln für gutes Feedback',
      'Ich-Botschaft, konkret, beschreibend statt bewertend, zeitnah, mit Verbesserungsvorschlag.'),
  karte('k-tf-3', 'te-feedback', 'Feedback annehmen',
      'Zuhören, nicht rechtfertigen, nachfragen, bedanken.'),
  karte('k-tf-4', 'te-feedback', 'Gute Fehlerkultur',
      'Fehler werden offen angesprochen und als Lernchance genutzt - ohne Angst vor Strafe.'),

  // Konflikte
  karte('k-tk-1', 'te-konflikte', 'Sachkonflikt vs. Beziehungskonflikt',
      'Sachkonflikt: Streit um Wege oder Methoden. Beziehungskonflikt: gestörtes Verhältnis zwischen Personen.'),
  karte('k-tk-2', 'te-konflikte', 'Konsens',
      'Gemeinsam erarbeitete Lösung, bei der beide Seiten gewinnen - die nachhaltigste Konfliktlösung.'),
  karte('k-tk-3', 'te-konflikte', 'Eskalationsstufen nach Glasl',
      'Neun Stufen in drei Phasen: win-win, win-lose, lose-lose.'),
  karte('k-tk-4', 'te-konflikte', 'AGG',
      'Allgemeines Gleichbehandlungsgesetz: verbietet Benachteiligung u. a. wegen Herkunft, Geschlecht, Religion, Behinderung, Alter oder sexueller Identität.'),

  // Harvard-Konzept
  karte('k-vh-1', 've-harvard', 'Die vier Prinzipien des Harvard-Konzepts',
      'Menschen und Probleme trennen, Interessen statt Positionen, Optionen zum beiderseitigen Vorteil, neutrale Beurteilungskriterien.'),
  karte('k-vh-2', 've-harvard', 'Position vs. Interesse',
      'Position: die Forderung. Interesse: der Grund dahinter. Verhandelt wird über Interessen.'),
  karte('k-vh-3', 've-harvard', 'BATNA',
      'Beste Alternative zur Verhandlungslösung - zeigt, ab wann ein Angebot schlechter ist als keine Einigung.'),
  karte('k-vh-4', 've-harvard', 'Neutrale Beurteilungskriterien',
      'Objektive Maßstäbe wie Marktpreise, Normen oder Gutachten - statt Druck und Willkür.'),

  // Einwände
  karte('k-ve-1', 've-einwaende', 'Nutzenargumentation',
      'Vom Merkmal über den Vorteil zum konkreten Nutzen für den Kunden argumentieren.'),
  karte('k-ve-2', 've-einwaende', 'Ja-aber-Methode',
      'Dem Einwand zunächst zustimmen, dann um ein Gegenargument ergänzen.'),
  karte('k-ve-3', 've-einwaende', 'Bumerang-Methode',
      'Den Einwand selbst als Argument für das Produkt nutzen.'),
  karte('k-ve-4', 've-einwaende', 'Einwand vs. Vorwand',
      'Einwand: echter Zweifel, sachlich ausräumen. Vorwand: vorgeschobener Grund, per Rückfrage den wahren Grund finden.'),

  // Präsentation
  karte('k-pp-1', 'pr-praesentation', 'Aufbau einer Präsentation',
      'Einleitung (Aufmerksamkeit, Thema), Hauptteil (Inhalte, Belege), Schluss (Zusammenfassung, Handlungsaufforderung).'),
  karte('k-pp-2', 'pr-praesentation', 'Balkendiagramm',
      'Zeigt Vergleiche - zum Beispiel die Kosten mehrerer Angebote.'),
  karte('k-pp-3', 'pr-praesentation', 'Liniendiagramm',
      'Zeigt Entwicklungen über die Zeit - zum Beispiel Ticketzahlen pro Monat.'),
  karte('k-pp-4', 'pr-praesentation', 'Kreisdiagramm',
      'Zeigt Anteile an einem Ganzen - die Teile ergeben 100 %.'),

  // Quellen
  karte('k-pq-1', 'pr-quellen', 'Primärquelle',
      'Originalinformation, z. B. Herstellerdokumentation, Gesetzestext, eigene Messung.'),
  karte('k-pq-2', 'pr-quellen', 'Sekundärquelle',
      'Aufbereitete Information aus zweiter Hand, z. B. Fachartikel, Lexikon, Forum.'),
  karte('k-pq-3', 'pr-quellen', 'Kriterien für Quellen',
      'Aktualität, Urheber, Objektivität, Nachprüfbarkeit, Relevanz.'),
  karte('k-pq-4', 'pr-quellen', 'KI-Antworten als Quelle?',
      'Nein. Sie können erfunden sein und müssen an einer Primärquelle überprüft werden.'),

  // Angebot
  karte('k-pa-1', 'pr-angebot', 'Anfrage',
      'Unverbindliche Erkundigung nach Leistung, Preis und Bedingungen.'),
  karte('k-pa-2', 'pr-angebot', 'Angebot',
      'Verbindliche Willenserklärung. Wird es rechtzeitig und unverändert angenommen, entsteht ein Vertrag.'),
  karte('k-pa-3', 'pr-angebot', 'Freizeichnungsklausel',
      'Schränkt die Bindung eines Angebots ein, z. B. „freibleibend“ oder „solange der Vorrat reicht“.'),
  karte('k-pa-4', 'pr-angebot', 'Ist ein Katalog ein Angebot?',
      'Nein - eine Aufforderung an die Allgemeinheit, selbst ein Angebot abzugeben.'),

  // Markt
  karte('k-mm-1', 'm-markt', 'Polypol',
      'Viele Anbieter, viele Nachfrager - der Wettbewerb bestimmt den Preis.'),
  karte('k-mm-2', 'm-markt', 'Oligopol',
      'Wenige Anbieter, viele Nachfrager - z. B. große Cloud-Anbieter.'),
  karte('k-mm-3', 'm-markt', 'Monopol',
      'Ein Anbieter, viele Nachfrager - der Anbieter hat große Macht über den Preis.'),
  karte('k-mm-4', 'm-markt', 'Nachfragemonopol',
      'Viele Anbieter, aber nur ein Nachfrager - etwa eine Behörde, die ein Spezialsystem ausschreibt.'),

  // Bedarf
  karte('k-mb-1', 'm-bedarf', 'Bedürfnis - Bedarf - Nachfrage',
      'Bedürfnis: empfundener Mangel. Bedarf: Bedürfnis mit Kaufkraft. Nachfrage: Bedarf, der am Markt wirksam wird.'),
  karte('k-mb-2', 'm-bedarf', 'Maslow-Pyramide',
      'Von unten: Grundbedürfnisse, Sicherheit, soziale Bedürfnisse, Wertschätzung, Selbstverwirklichung.'),
  karte('k-mb-3', 'm-bedarf', 'Methoden der Bedarfsermittlung',
      'Gespräch mit offenen Fragen, Ist-Analyse, Beobachtung, Fragebogen.'),
  karte('k-mb-4', 'm-bedarf', 'Wunsch vs. Bedarf',
      'Gute Beratung klärt den tatsächlichen Bedarf, statt jeden Wunsch zu erfüllen.'),

  // Marketing
  karte('k-mk-1', 'm-marketing', 'Die 4 P des Marketing-Mix',
      'Product, Price, Place, Promotion - Produkt-, Preis-, Distributions- und Kommunikationspolitik.'),
  karte('k-mk-2', 'm-marketing', 'AIDA',
      'Attention, Interest, Desire, Action - Stufen der Werbewirkung.'),
  karte('k-mk-3', 'm-marketing', 'Distributionspolitik',
      'Regelt, wie das Produkt zum Kunden kommt: Onlineshop, Fachhandel, Direktvertrieb.'),
  karte('k-mk-4', 'm-marketing', 'Rabattaktion - welches Instrument?',
      'Preispolitik. Die Anzeige, die darauf hinweist, ist Kommunikationspolitik.'),

  // ABC
  karte('k-ma-1', 'm-abc', 'ABC-Analyse - Zweck',
      'Objekte nach Bedeutung in drei Klassen teilen, um Aufwand gezielt einzusetzen.'),
  karte('k-ma-2', 'm-abc', 'A-Klasse',
      'Wenige Objekte mit dem größten Wertanteil, oft 70-80 %.'),
  karte('k-ma-3', 'm-abc', 'C-Klasse',
      'Viele Objekte mit geringem Wertanteil, oft nur 5-10 %.'),
  karte('k-ma-4', 'm-abc', 'Schritte der ABC-Analyse',
      'Werte ermitteln, absteigend sortieren, Anteile berechnen, kumulieren, Klassen zuordnen.'),

  // Rechtsformen
  karte('k-mr-1', 'm-rechtsformen', 'GmbH',
      'Kapitalgesellschaft, 25.000 € Stammkapital, Haftung mit dem Gesellschaftsvermögen.'),
  karte('k-mr-2', 'm-rechtsformen', 'AG',
      'Kapitalgesellschaft, 50.000 € Grundkapital, Organe: Vorstand, Aufsichtsrat, Hauptversammlung.'),
  karte('k-mr-3', 'm-rechtsformen', 'KG',
      'Komplementär haftet unbeschränkt, Kommanditist nur mit seiner Einlage.'),
  karte('k-mr-4', 'm-rechtsformen', 'UG (haftungsbeschränkt)',
      'GmbH mit Stammkapital ab 1 €. Ein Viertel des Jahresüberschusses muss angespart werden.'),
  karte('k-mr-5', 'm-rechtsformen', 'OHG',
      'Personengesellschaft, alle Gesellschafter haften unbeschränkt mit ihrem Privatvermögen.'),
];
