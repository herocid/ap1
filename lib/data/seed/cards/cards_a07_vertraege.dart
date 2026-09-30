import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 07 - Vertragsmanagement und Service.
final List<Flashcard> cardsA07 = [
  // Zustandekommen
  karte('k-vz-1', 'vt-zustandekommen', 'Wie entsteht ein Vertrag?',
      'Durch zwei übereinstimmende Willenserklärungen: Antrag und Annahme.'),
  karte('k-vz-2', 'vt-zustandekommen', 'Invitatio ad offerendum',
      'Aufforderung zur Abgabe eines Antrags, z. B. Katalog, Werbung, Webshop - noch kein Antrag.'),
  karte('k-vz-3', 'vt-zustandekommen', 'Verspätete oder geänderte Annahme',
      'Gilt als neuer Antrag - die andere Seite kann ihn annehmen oder ablehnen.'),
  karte('k-vz-4', 'vt-zustandekommen', 'Stufen der Geschäftsfähigkeit',
      'Unter 7: geschäftsunfähig. 7 bis 17: beschränkt geschäftsfähig. Ab 18: voll geschäftsfähig.'),
  karte('k-vz-5', 'vt-zustandekommen', 'Taschengeldparagraf',
      'Beschränkt Geschäftsfähige schließen wirksam Verträge, die sie mit ihnen frei überlassenen Mitteln bewirken.'),

  // Vertragsarten
  karte('k-vy-1', 'vt-arten', 'Werkvertrag',
      'Geschuldet wird ein Erfolg. Es gibt eine Abnahme, danach wird die Vergütung fällig.',
      'IT-Beispiel: Individualsoftware'),
  karte('k-vy-2', 'vt-arten', 'Dienstvertrag',
      'Geschuldet wird die Tätigkeit, kein Ergebnis. Keine Abnahme, Vergütung nach Aufwand.',
      'IT-Beispiel: Support oder Beratung nach Stunden'),
  karte('k-vy-3', 'vt-arten', 'Mietvertrag',
      'Gebrauchsüberlassung auf Zeit gegen Entgelt - typische Einordnung für SaaS und Cloud-Dienste.'),
  karte('k-vy-4', 'vt-arten', 'Werklieferungsvertrag',
      'Herstellung und Lieferung einer beweglichen Sache - es gilt Kaufrecht.'),
  karte('k-vy-5', 'vt-arten', 'Leasing',
      'Gebrauchsüberlassung gegen Leasingraten, der Leasinggeber finanziert. Im Kern wie Miete behandelt.'),

  // Urheberrecht
  karte('k-vu-1', 'vt-urheber', 'Wann entsteht Urheberrecht?',
      'Automatisch mit der Schöpfung des Werks - ohne Anmeldung oder Vermerk.'),
  karte('k-vu-2', 'vt-urheber', 'Ist das Urheberrecht übertragbar?',
      'Nein, nur vererbbar. Übertragen werden Nutzungsrechte (Lizenzen).'),
  karte('k-vu-3', 'vt-urheber', 'Einfaches Nutzungsrecht',
      'Erlaubt die Nutzung neben anderen Berechtigten - der Rechteinhaber darf weitere Lizenzen vergeben.'),
  karte('k-vu-4', 'vt-urheber', 'Software von Angestellten',
      'Urheber bleibt die Person, die vermögensrechtlichen Befugnisse liegen beim Arbeitgeber (§ 69b UrhG).'),
  karte('k-vu-5', 'vt-urheber', 'Schutzdauer Urheberrecht',
      '70 Jahre nach dem Tod des Urhebers.'),

  // SLA
  karte('k-li-1', 'sla-inhalte', 'SLA',
      'Service Level Agreement - vereinbart messbare Servicequalität zwischen Dienstleister und Kunde.'),
  karte('k-li-2', 'sla-inhalte', 'Reaktionszeit',
      'Zeit bis zur ersten qualifizierten Rückmeldung - nicht bis zur Lösung.'),
  karte('k-li-3', 'sla-inhalte', 'Erlaubter Ausfall',
      'Servicezeit × (100 % - Verfügbarkeit). 24/7, ein Jahr, 99,9 %: 8.760 h × 0,001 = 8,76 h.'),
  karte('k-li-4', 'sla-inhalte', 'Pönale',
      'Vertragsstrafe oder Gutschrift, wenn der Dienstleister die vereinbarten Service Levels verfehlt.'),

  // Support
  karte('k-ls-1', 'sla-support', 'Single Point of Contact',
      'Der Service Desk als einzige zentrale Anlaufstelle für alle Anfragen der Anwender.'),
  karte('k-ls-2', 'sla-support', '1st, 2nd, 3rd Level',
      '1st: Service Desk, Standardfälle. 2nd: Fachspezialisten. 3rd: Hersteller oder Entwicklung.'),
  karte('k-ls-3', 'sla-support', 'Funktional vs. hierarchisch',
      'Funktionale Eskalation: an mehr Fachwissen. Hierarchische Eskalation: an die Führungsebene.'),
  karte('k-ls-4', 'sla-support', 'Priorität eines Tickets',
      'Ergibt sich aus Auswirkung (wie viele betroffen) und Dringlichkeit (wie eilig).'),
  karte('k-ls-5', 'sla-support', 'First Level Resolution Rate',
      'Anteil der Tickets, die der 1st Level ohne Weitergabe löst, in Prozent aller Tickets.'),

  // ITIL
  karte('k-lt-1', 'sla-itil', 'Incident',
      'Ungeplante Störung eines Service. Ziel: Service so schnell wie möglich wiederherstellen.'),
  karte('k-lt-2', 'sla-itil', 'Problem',
      'Die unbekannte Ursache eines oder mehrerer Incidents. Ziel: Ursache finden und beseitigen.'),
  karte('k-lt-3', 'sla-itil', 'Known Error',
      'Problem, dessen Ursache bekannt und dokumentiert ist, meist mit Workaround.'),
  karte('k-lt-4', 'sla-itil', 'Standard Change',
      'Häufige Änderung mit geringem Risiko, die vorab genehmigt ist.'),
  karte('k-lt-5', 'sla-itil', 'Service Request',
      'Standardanfrage eines Anwenders ohne Störung, z. B. Passwort zurücksetzen.'),

  // Verzug
  karte('k-gv-1', 'ls-verzug', 'Voraussetzungen Lieferungsverzug',
      'Fälligkeit, Mahnung (entbehrlich bei Kalendertermin), Verschulden des Lieferanten.'),
  karte('k-gv-2', 'ls-verzug', 'Rechte ohne Nachfrist',
      'Auf Lieferung bestehen und Ersatz des Verzugsschadens verlangen.'),
  karte('k-gv-3', 'ls-verzug', 'Rechte nach Nachfrist',
      'Rücktritt vom Vertrag und/oder Schadensersatz statt der Leistung.'),
  karte('k-gv-4', 'ls-verzug', 'Verzugszinssatz',
      'Mit Verbraucher: Basiszins + 5 Prozentpunkte. Nur Unternehmen: Basiszins + 9 Prozentpunkte.',
      'Unter Unternehmen zusätzlich 40 € Pauschale'),
  karte('k-gv-5', 'ls-verzug', 'Zahlungsverzug ohne Mahnung',
      'Spätestens 30 Tage nach Fälligkeit und Zugang der Rechnung - bei Verbrauchern nur mit Hinweis darauf.'),

  // Mängel
  karte('k-gm-1', 'ls-maengel', 'Vorrangiges Recht bei Mängeln',
      'Nacherfüllung: Nachbesserung oder Ersatzlieferung - beim Kauf wählt der Käufer.'),
  karte('k-gm-2', 'ls-maengel', 'Nachrangige Rechte',
      'Rücktritt, Minderung, Schadensersatz - in der Regel erst nach erfolgloser Frist zur Nacherfüllung.'),
  karte('k-gm-3', 'ls-maengel', 'Gewährleistungsfrist Kauf',
      '2 Jahre ab Übergabe bei neuen Sachen.'),
  karte('k-gm-4', 'ls-maengel', 'Beweislastumkehr',
      'Beim Verbrauchsgüterkauf: Zeigt sich ein Mangel im ersten Jahr, wird vermutet, dass er schon bei Übergabe vorlag.'),
  karte('k-gm-5', 'ls-maengel', 'Rügepflicht § 377 HGB',
      'Beim Kauf unter Kaufleuten Ware unverzüglich prüfen und Mängel unverzüglich rügen.'),

  // Abnahme
  karte('k-ga-1', 'ls-abnahme', 'Folgen der Abnahme',
      'Vergütung fällig, Gefahrübergang, Verjährung beginnt, Beweislast geht auf den Besteller über.'),
  karte('k-ga-2', 'ls-abnahme', 'Fiktive Abnahme',
      'Werk gilt als abgenommen, wenn der Besteller eine gesetzte Frist verstreichen lässt, ohne einen Mangel zu nennen.'),
  karte('k-ga-3', 'ls-abnahme', 'Abnahme unter Vorbehalt',
      'Abnahme mit protokollierten Mängeln - die Rechte zu diesen Mängeln bleiben erhalten.'),
  karte('k-ga-4', 'ls-abnahme', 'Unwesentlicher Mangel',
      'Berechtigt nicht zur Verweigerung der Abnahme - er wird protokolliert und nachgebessert.'),

  // Lewin
  karte('k-cl-1', 'cm-lewin', 'Phasen nach Lewin',
      'Unfreezing (Auftauen), Moving (Verändern), Refreezing (Einfrieren).'),
  karte('k-cl-2', 'cm-lewin', 'Unfreezing',
      'Bereitschaft schaffen: informieren, Dringlichkeit zeigen, Betroffene beteiligen.'),
  karte('k-cl-3', 'cm-lewin', 'Moving',
      'Das Neue umsetzen: schulen, pilotieren, eng begleiten.'),
  karte('k-cl-4', 'cm-lewin', 'Refreezing',
      'Das Neue verankern: Standards festlegen, Altes abschalten, Erfolge sichtbar machen.'),

  // Widerstand
  karte('k-cw-1', 'cm-widerstand', 'Ursachen von Widerstand',
      'Nicht wissen, nicht können, nicht wollen, nicht dürfen.'),
  karte('k-cw-2', 'cm-widerstand', 'Antwort auf „nicht können“',
      'Schulen und begleiten - die Fähigkeit fehlt, nicht der Wille.'),
  karte('k-cw-3', 'cm-widerstand', 'Verdeckter Widerstand',
      'Nicht offen ausgesprochen, z. B. Verzögern, Gerüchte, Dienst nach Vorschrift.'),
  karte('k-cw-4', 'cm-widerstand', 'Wirksamste Gegenmaßnahme',
      'Betroffene frühzeitig beteiligen - wer mitgestaltet, blockiert selten.'),

  // Kaizen
  karte('k-ck-1', 'cm-kaizen', 'Kaizen / KVP',
      'Kontinuierliche Verbesserung in kleinen Schritten, getragen von allen Mitarbeitenden.'),
  karte('k-ck-2', 'cm-kaizen', 'Muda',
      'Japanisch für Verschwendung: Aufwand ohne Wert für die Kundschaft, z. B. Wartezeit, Nacharbeit.'),
  karte('k-ck-3', 'cm-kaizen', 'PDCA',
      'Plan, Do, Check, Act - der Zyklus, mit dem jeder KVP-Schritt durchlaufen wird.'),
  karte('k-ck-4', 'cm-kaizen', 'Business Process Reengineering',
      'Radikale, grundlegende Neugestaltung von Prozessen - Gegenentwurf zu Kaizen.'),
];
