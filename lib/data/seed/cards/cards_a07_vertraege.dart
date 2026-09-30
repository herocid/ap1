import '../../models/flashcard.dart';
import '../builders.dart';

/// Karteikarten Bereich 07 - Vertragsmanagement und Service.
final List<Flashcard> cardsA07 = [
  // Zustandekommen
  karte(
    'k-vz-1',
    'vt-zustandekommen',
    'Wie entsteht ein Vertrag?',
    'Durch zwei übereinstimmende Willenserklärungen: Antrag und Annahme.',
  ),
  karte(
    'k-vz-2',
    'vt-zustandekommen',
    'Invitatio ad offerendum',
    'Aufforderung zur Abgabe eines Antrags, z. B. Katalog, Werbung, Webshop - noch kein Antrag.',
  ),
  karte(
    'k-vz-3',
    'vt-zustandekommen',
    'Verspätete oder geänderte Annahme',
    'Gilt als neuer Antrag - die andere Seite kann ihn annehmen oder ablehnen.',
  ),
  karte(
    'k-vz-4',
    'vt-zustandekommen',
    'Stufen der Geschäftsfähigkeit',
    'Unter 7: geschäftsunfähig. 7 bis 17: beschränkt geschäftsfähig. Ab 18: voll geschäftsfähig.',
  ),
  karte(
    'k-vz-5',
    'vt-zustandekommen',
    'Taschengeldparagraf',
    'Beschränkt Geschäftsfähige schließen wirksam Verträge, die sie mit ihnen frei überlassenen Mitteln bewirken.',
  ),
  karte(
    'k-vz-6',
    'vt-zustandekommen',
    'Willenserklärung',
    'Äußerung eines Willens, der unmittelbar auf eine Rechtsfolge gerichtet ist, z. B. eine Bestellung.',
  ),
  karte(
    'k-vz-7',
    'vt-zustandekommen',
    'Nichtig vs. anfechtbar',
    'Nichtig: von Anfang an unwirksam. Anfechtbar: wirksam, bis die Anfechtung erklärt ist - dann rückwirkend nichtig.',
  ),
  karte(
    'k-vz-8',
    'vt-zustandekommen',
    'Anfechtungsfristen',
    'Irrtum: unverzüglich nach Entdeckung (§ 121 BGB). Täuschung oder Drohung: innerhalb eines Jahres (§ 124 BGB).',
  ),
  karte(
    'k-vz-9',
    'vt-zustandekommen',
    'Wann gelten AGB gegenüber Verbrauchern?',
    'Bei ausdrücklichem Hinweis bei Vertragsschluss und zumutbarer Möglichkeit zur Kenntnisnahme. Individuelle Absprachen gehen vor.',
  ),
  karte(
    'k-vz-10',
    'vt-zustandekommen',
    'Schwebend unwirksam',
    'Vertrag eines beschränkt Geschäftsfähigen ohne Zustimmung: Er wird erst mit der Genehmigung der Eltern wirksam (§ 108 BGB).',
  ),

  // Vertragsarten
  karte(
    'k-vy-1',
    'vt-arten',
    'Werkvertrag',
    'Geschuldet wird ein Erfolg. Es gibt eine Abnahme, danach wird die Vergütung fällig.',
    'IT-Beispiel: Individualsoftware',
  ),
  karte(
    'k-vy-2',
    'vt-arten',
    'Dienstvertrag',
    'Geschuldet wird die Tätigkeit, kein Ergebnis. Keine Abnahme, Vergütung nach Aufwand.',
    'IT-Beispiel: Support oder Beratung nach Stunden',
  ),
  karte(
    'k-vy-3',
    'vt-arten',
    'Mietvertrag',
    'Gebrauchsüberlassung auf Zeit gegen Entgelt - typische Einordnung für SaaS und Cloud-Dienste.',
  ),
  karte(
    'k-vy-4',
    'vt-arten',
    'Werklieferungsvertrag',
    'Herstellung und Lieferung einer beweglichen Sache - es gilt Kaufrecht.',
  ),
  karte(
    'k-vy-5',
    'vt-arten',
    'Leasing',
    'Gebrauchsüberlassung gegen Leasingraten, der Leasinggeber finanziert. Im Kern wie Miete behandelt.',
  ),
  karte(
    'k-vy-6',
    'vt-arten',
    'Pflichten beim Kaufvertrag',
    'Verkäufer: übergeben, übereignen, mangelfrei liefern. Käufer: Kaufpreis zahlen, Ware abnehmen (§ 433 BGB).',
  ),
  karte(
    'k-vy-7',
    'vt-arten',
    'Besitz vs. Eigentum',
    'Besitz: tatsächliche Herrschaft über eine Sache. Eigentum: rechtliche Herrschaft - wem sie gehört.',
  ),
  karte(
    'k-vy-8',
    'vt-arten',
    'Leihe',
    'Unentgeltliche Gebrauchsüberlassung auf Zeit (§ 598 BGB), z. B. ein Vorführgerät zum Testen.',
  ),
  karte(
    'k-vy-9',
    'vt-arten',
    'Eigentumsvorbehalt',
    'Der Verkäufer bleibt Eigentümer, bis der Kaufpreis vollständig bezahlt ist; der Käufer ist nur Besitzer.',
  ),

  // Urheberrecht
  karte(
    'k-vu-1',
    'vt-urheber',
    'Wann entsteht Urheberrecht?',
    'Automatisch mit der Schöpfung des Werks - ohne Anmeldung oder Vermerk.',
  ),
  karte(
    'k-vu-2',
    'vt-urheber',
    'Ist das Urheberrecht übertragbar?',
    'Nein, nur vererbbar. Übertragen werden Nutzungsrechte (Lizenzen).',
  ),
  karte(
    'k-vu-3',
    'vt-urheber',
    'Einfaches Nutzungsrecht',
    'Erlaubt die Nutzung neben anderen Berechtigten - der Rechteinhaber darf weitere Lizenzen vergeben.',
  ),
  karte(
    'k-vu-4',
    'vt-urheber',
    'Software von Angestellten',
    'Urheber bleibt die Person, die vermögensrechtlichen Befugnisse liegen beim Arbeitgeber (§ 69b UrhG).',
  ),
  karte(
    'k-vu-5',
    'vt-urheber',
    'Schutzdauer Urheberrecht',
    '70 Jahre nach dem Tod des Urhebers.',
  ),
  karte(
    'k-vu-6',
    'vt-urheber',
    'Ausschließliches Nutzungsrecht',
    'Nur der Inhaber darf nutzen; weitere Lizenzen sind ausgeschlossen - grundsätzlich sogar für den Urheber selbst, wenn er sich die Nutzung nicht vorbehält (§ 31 Abs. 3 UrhG).',
  ),
  karte(
    'k-vu-7',
    'vt-urheber',
    'Rechte nach § 69d UrhG',
    'Ohne Zustimmung erlaubt: bestimmungsgemäße Nutzung mit Fehlerberichtigung, nötige Sicherungskopie, Beobachten und Testen.',
  ),
  karte(
    'k-vu-8',
    'vt-urheber',
    'Erschöpfungsgrundsatz',
    'Eine mit Zustimmung in der EU verkaufte Programmkopie darf weiterverkauft werden - nicht bei Miete oder Abo.',
  ),
  karte(
    'k-vu-9',
    'vt-urheber',
    'Zweckübertragungslehre',
    'Nicht ausdrücklich geregelte Nutzungsrechte gelten nur so weit eingeräumt, wie der Vertragszweck es erfordert (§ 31 Abs. 5 UrhG).',
  ),
  karte(
    'k-vu-10',
    'vt-urheber',
    'Patent vs. Urheberrecht',
    'Patent: technische Erfindung, Anmeldung nötig, max. 20 Jahre. Urheberrecht: automatisch, bis 70 Jahre nach dem Tod.',
  ),

  // SLA
  karte(
    'k-li-1',
    'sla-inhalte',
    'SLA',
    'Service Level Agreement - vereinbart messbare Servicequalität zwischen Dienstleister und Kunde.',
  ),
  karte(
    'k-li-2',
    'sla-inhalte',
    'Reaktionszeit',
    'Zeit bis zur ersten qualifizierten Rückmeldung - nicht bis zur Lösung.',
  ),
  karte(
    'k-li-3',
    'sla-inhalte',
    'Erlaubter Ausfall',
    'Servicezeit × (100 % - Verfügbarkeit). 24/7, ein Jahr, 99,9 %: 8.760 h × 0,001 = 8,76 h.',
  ),
  karte(
    'k-li-4',
    'sla-inhalte',
    'Pönale',
    'Vertragsstrafe oder Gutschrift, wenn der Dienstleister die vereinbarten Service Levels verfehlt.',
  ),
  karte(
    'k-li-5',
    'sla-inhalte',
    'Lösungszeit',
    'Zeit von der Meldung bis zur Behebung der Störung bzw. Wiederherstellung des Service.',
  ),
  karte(
    'k-li-6',
    'sla-inhalte',
    'OLA und UC',
    'OLA: interne Vereinbarung zwischen Teams. UC: Vertrag mit einem externen Lieferanten. Beide stützen das SLA.',
  ),
  karte(
    'k-li-7',
    'sla-inhalte',
    'MTBF',
    'Mean Time Between Failures: mittlere Betriebszeit zwischen zwei Ausfällen = Betriebszeit ohne Ausfall / Anzahl Ausfälle.',
  ),
  karte(
    'k-li-8',
    'sla-inhalte',
    'MTTR',
    'Mean Time To Repair: mittlere Dauer bis zur Wiederherstellung = gesamte Ausfallzeit / Anzahl Ausfälle.',
  ),
  karte(
    'k-li-9',
    'sla-inhalte',
    'Verfügbarkeit aus MTBF und MTTR',
    'V = MTBF / (MTBF + MTTR) × 100 %. Beispiel: 238 / (238 + 2) ≈ 99,17 %.',
  ),
  karte(
    'k-li-10',
    'sla-inhalte',
    '99,9 % bei 24/7',
    'Erlaubter Ausfall pro Jahr 8,76 h, pro 30-Tage-Monat 43,2 Minuten.',
  ),

  // Support
  karte(
    'k-ls-1',
    'sla-support',
    'Single Point of Contact',
    'Der Service Desk als einzige zentrale Anlaufstelle für alle Anfragen der Anwender.',
  ),
  karte(
    'k-ls-2',
    'sla-support',
    '1st, 2nd, 3rd Level',
    '1st: Service Desk, Standardfälle. 2nd: Fachspezialisten. 3rd: Hersteller oder Entwicklung.',
  ),
  karte(
    'k-ls-3',
    'sla-support',
    'Funktional vs. hierarchisch',
    'Funktionale Eskalation: an mehr Fachwissen. Hierarchische Eskalation: an die Führungsebene.',
  ),
  karte(
    'k-ls-4',
    'sla-support',
    'Priorität eines Tickets',
    'Ergibt sich aus Auswirkung (wie viele betroffen) und Dringlichkeit (wie eilig).',
  ),
  karte(
    'k-ls-5',
    'sla-support',
    'First Level Resolution Rate',
    'Anteil der Tickets, die der 1st Level ohne Weitergabe löst, in Prozent aller Tickets.',
  ),
  karte(
    'k-ls-6',
    'sla-support',
    'Level 0',
    'Self-Service: Anwender lösen selbst, z. B. per FAQ, Wissensdatenbank oder Passwort-Reset-Portal.',
  ),
  karte(
    'k-ls-7',
    'sla-support',
    'Ownership-Prinzip',
    'Der Service Desk bleibt Ansprechpartner des Anwenders, bis das Ticket geschlossen ist - auch nach einer Eskalation.',
  ),
  karte(
    'k-ls-8',
    'sla-support',
    'Follow the Sun',
    'Service Desks in mehreren Zeitzonen übergeben offene Tickets - so entsteht 24/7-Support ohne Nachtschicht.',
  ),
  karte(
    'k-ls-9',
    'sla-support',
    'SLA-Erfüllungsquote',
    'Fristgerecht gelöste Tickets / alle Tickets × 100 %.',
  ),
  karte(
    'k-ls-10',
    'sla-support',
    'Inhalt eines Tickets',
    'Nummer, Zeitstempel, Melder, System, Kategorie, Beschreibung, Priorität, Status, Bearbeiter, Historie, Lösung.',
  ),

  // ITIL
  karte(
    'k-lt-1',
    'sla-itil',
    'Incident',
    'Ungeplante Störung eines Service. Ziel: Service so schnell wie möglich wiederherstellen.',
  ),
  karte(
    'k-lt-2',
    'sla-itil',
    'Problem',
    'Die unbekannte Ursache eines oder mehrerer Incidents. Ziel: Ursache finden und beseitigen.',
  ),
  karte(
    'k-lt-3',
    'sla-itil',
    'Known Error',
    'Problem, dessen Ursache bekannt und dokumentiert ist, meist mit Workaround.',
  ),
  karte(
    'k-lt-4',
    'sla-itil',
    'Standard Change',
    'Häufige Änderung mit geringem Risiko, die vorab genehmigt ist.',
  ),
  karte(
    'k-lt-5',
    'sla-itil',
    'Service Request',
    'Standardanfrage eines Anwenders ohne Störung, z. B. Passwort zurücksetzen.',
  ),
  karte(
    'k-lt-6',
    'sla-itil',
    'Workaround',
    'Vorübergehende Umgehung, die den Service wiederherstellt, ohne die Ursache zu beseitigen.',
  ),
  karte(
    'k-lt-7',
    'sla-itil',
    'Service Value Chain',
    'Sechs Aktivitäten in ITIL 4: Plan, Improve, Engage, Design & Transition, Obtain/Build, Deliver & Support.',
  ),
  karte(
    'k-lt-8',
    'sla-itil',
    'Emergency Change',
    'Dringende Änderung, z. B. Sicherheitspatch bei aktivem Angriff - beschleunigt genehmigt und dokumentiert.',
  ),
  karte(
    'k-lt-9',
    'sla-itil',
    'Vier Dimensionen (ITIL 4)',
    'Organisationen und Personen, Informationen und Technologie, Partner und Lieferanten, Wertströme und Prozesse.',
  ),
  karte(
    'k-lt-10',
    'sla-itil',
    'Utility und Warranty',
    'Utility: Der Service erfüllt den Zweck (fit for purpose). Warranty: Er ist verfügbar, sicher und leistungsfähig (fit for use).',
  ),

  // Verzug
  karte(
    'k-gv-1',
    'ls-verzug',
    'Voraussetzungen Lieferungsverzug',
    'Fälligkeit, Mahnung (entbehrlich bei Kalendertermin), Verschulden des Lieferanten.',
  ),
  karte(
    'k-gv-2',
    'ls-verzug',
    'Rechte ohne Nachfrist',
    'Auf Lieferung bestehen und Ersatz des Verzugsschadens verlangen.',
  ),
  karte(
    'k-gv-3',
    'ls-verzug',
    'Rechte nach Nachfrist',
    'Rücktritt vom Vertrag und/oder Schadensersatz statt der Leistung.',
  ),
  karte(
    'k-gv-4',
    'ls-verzug',
    'Verzugszinssatz',
    'Mit Verbraucher: Basiszins + 5 Prozentpunkte. Nur Unternehmen: Basiszins + 9 Prozentpunkte.',
    'Unter Unternehmen zusätzlich 40 € Pauschale',
  ),
  karte(
    'k-gv-5',
    'ls-verzug',
    'Zahlungsverzug ohne Mahnung',
    'Spätestens 30 Tage nach Fälligkeit und Zugang der Rechnung - bei Verbrauchern nur mit Hinweis darauf.',
  ),
  karte(
    'k-gv-6',
    'ls-verzug',
    'Wann ist keine Mahnung nötig?',
    'Bei kalendermäßig bestimmtem Termin, ernsthafter Leistungsverweigerung oder besonderer Eilbedürftigkeit (§ 286 Abs. 2 BGB).',
  ),
  karte(
    'k-gv-7',
    'ls-verzug',
    'Fixgeschäft',
    'Der Termin ist so wesentlich, dass der Käufer ohne Nachfrist zurücktreten kann (§ 323 Abs. 2 BGB, § 376 HGB).',
  ),
  karte(
    'k-gv-8',
    'ls-verzug',
    'Annahmeverzug',
    'Der Käufer nimmt ordnungsgemäß angebotene Ware nicht an; der Verkäufer haftet dann nur noch für Vorsatz und grobe Fahrlässigkeit.',
  ),
  karte(
    'k-gv-9',
    'ls-verzug',
    'Formel Verzugszinsen',
    'Zins = Betrag × Zinssatz × Tage / 365 (oder / 360, wenn die Aufgabe das Bankjahr vorgibt).',
  ),
  karte(
    'k-gv-10',
    'ls-verzug',
    'Regelmäßige Verjährung',
    '3 Jahre, beginnend mit dem Ende des Jahres, in dem der Anspruch entstand und der Gläubiger davon wusste (§§ 195, 199 BGB).',
  ),

  // Mängel
  karte(
    'k-gm-1',
    'ls-maengel',
    'Vorrangiges Recht bei Mängeln',
    'Nacherfüllung: Nachbesserung oder Ersatzlieferung - beim Kauf wählt der Käufer.',
  ),
  karte(
    'k-gm-2',
    'ls-maengel',
    'Nachrangige Rechte',
    'Rücktritt, Minderung, Schadensersatz - in der Regel erst nach erfolgloser Frist zur Nacherfüllung.',
  ),
  karte(
    'k-gm-3',
    'ls-maengel',
    'Gewährleistungsfrist Kauf',
    '2 Jahre ab Übergabe bei neuen Sachen.',
  ),
  karte(
    'k-gm-4',
    'ls-maengel',
    'Beweislastumkehr',
    'Beim Verbrauchsgüterkauf: Zeigt sich ein Mangel im ersten Jahr, wird vermutet, dass er schon bei Übergabe vorlag.',
  ),
  karte(
    'k-gm-5',
    'ls-maengel',
    'Rügepflicht § 377 HGB',
    'Beim Kauf unter Kaufleuten Ware unverzüglich prüfen und Mängel unverzüglich rügen.',
  ),
  karte(
    'k-gm-6',
    'ls-maengel',
    'Sachmangel seit 2022',
    'Die Sache muss die subjektiven (vereinbarten), objektiven (üblichen) und Montageanforderungen erfüllen (§ 434 BGB).',
  ),
  karte(
    'k-gm-7',
    'ls-maengel',
    'Rechtsmangel',
    'Dritte haben Rechte an der Sache, z. B. Software ohne gültige Lizenz oder gestohlene Ware (§ 435 BGB).',
  ),
  karte(
    'k-gm-8',
    'ls-maengel',
    'Minderung berechnen',
    'Neuer Preis = Kaufpreis × Wert mit Mangel / Wert ohne Mangel (§ 441 BGB).',
  ),
  karte(
    'k-gm-9',
    'ls-maengel',
    'Garantie vs. Kulanz',
    'Garantie: freiwilliges, aber verbindliches Versprechen. Kulanz: freiwilliges Entgegenkommen ohne Rechtsanspruch.',
  ),
  karte(
    'k-gm-10',
    'ls-maengel',
    'Nacherfüllung beim Werkvertrag',
    'Der Unternehmer wählt zwischen Nachbesserung und Neuherstellung (§ 635 BGB).',
  ),

  // Abnahme
  karte(
    'k-ga-1',
    'ls-abnahme',
    'Folgen der Abnahme',
    'Vergütung fällig, Gefahrübergang, Verjährung beginnt, Beweislast geht auf den Besteller über.',
  ),
  karte(
    'k-ga-2',
    'ls-abnahme',
    'Fiktive Abnahme',
    'Werk gilt als abgenommen, wenn der Besteller eine gesetzte Frist verstreichen lässt, ohne einen Mangel zu nennen.',
  ),
  karte(
    'k-ga-3',
    'ls-abnahme',
    'Abnahme unter Vorbehalt',
    'Abnahme mit protokollierten Mängeln - die Rechte zu diesen Mängeln bleiben erhalten.',
  ),
  karte(
    'k-ga-4',
    'ls-abnahme',
    'Unwesentlicher Mangel',
    'Berechtigt nicht zur Verweigerung der Abnahme - er wird protokolliert und nachgebessert.',
  ),
  karte(
    'k-ga-5',
    'ls-abnahme',
    'Abnahme (§ 640 BGB)',
    'Billigung des Werks als im Wesentlichen vertragsgemäß - Pflicht des Bestellers, wenn das Werk vertragsgemäß ist.',
  ),
  karte(
    'k-ga-6',
    'ls-abnahme',
    'Konkludente Abnahme',
    'Abnahme durch schlüssiges Verhalten, z. B. vorbehaltlose Zahlung oder produktive Nutzung nach angemessener Prüfzeit.',
  ),
  karte(
    'k-ga-7',
    'ls-abnahme',
    'Vorbehaltlose Abnahme trotz Mängeln',
    'Für bekannte, nicht vorbehaltene Mängel entfallen Nacherfüllung, Selbstvornahme, Rücktritt und Minderung - nur Schadensersatz bleibt.',
  ),
  karte(
    'k-ga-8',
    'ls-abnahme',
    'Mängelklassen',
    'Betriebsverhindernd, betriebsbehindernd, leicht - im Vertrag festgelegt, ob die Abnahme verweigert werden darf.',
  ),
  karte(
    'k-ga-9',
    'ls-abnahme',
    '„Abnahme“ beim Kaufvertrag',
    'Nur die körperliche Entgegennahme der Ware (§ 433 Abs. 2 BGB) - keine Billigung wie beim Werkvertrag.',
  ),

  // Lewin
  karte(
    'k-cl-1',
    'cm-lewin',
    'Phasen nach Lewin',
    'Unfreezing (Auftauen), Moving (Verändern), Refreezing (Einfrieren).',
  ),
  karte(
    'k-cl-2',
    'cm-lewin',
    'Unfreezing',
    'Bereitschaft schaffen: informieren, Dringlichkeit zeigen, Betroffene beteiligen.',
  ),
  karte(
    'k-cl-3',
    'cm-lewin',
    'Moving',
    'Das Neue umsetzen: schulen, pilotieren, eng begleiten.',
  ),
  karte(
    'k-cl-4',
    'cm-lewin',
    'Refreezing',
    'Das Neue verankern: Standards festlegen, Altes abschalten, Erfolge sichtbar machen.',
  ),
  karte(
    'k-cl-5',
    'cm-lewin',
    'Kraftfeldanalyse',
    'Treibende und hemmende Kräfte halten sich die Waage. Verändern heißt: Treiber stärken oder Hemmnisse abbauen.',
  ),
  karte(
    'k-cl-6',
    'cm-lewin',
    'Kotter und Lewin',
    'Kotters 8 Schritte: 1 bis 4 entsprechen Unfreezing, 5 bis 7 Moving, 8 Refreezing.',
  ),
  karte(
    'k-cl-7',
    'cm-lewin',
    'Key-User',
    'Mitarbeitende, die das Neue früh testen und danach ihre Kollegen unterstützen (Multiplikatoren).',
  ),
  karte(
    'k-cl-8',
    'cm-lewin',
    'Leistungsdelle',
    'In der Moving-Phase sinkt die Leistung vorübergehend - das ist normal, kein Zeichen des Scheiterns.',
  ),

  // Widerstand
  karte(
    'k-cw-1',
    'cm-widerstand',
    'Ursachen von Widerstand',
    'Nicht wissen, nicht können, nicht wollen, nicht dürfen.',
  ),
  karte(
    'k-cw-2',
    'cm-widerstand',
    'Antwort auf „nicht können“',
    'Schulen und begleiten - die Fähigkeit fehlt, nicht der Wille.',
  ),
  karte(
    'k-cw-3',
    'cm-widerstand',
    'Verdeckter Widerstand',
    'Nicht offen ausgesprochen, z. B. Verzögern, Gerüchte, Dienst nach Vorschrift.',
  ),
  karte(
    'k-cw-4',
    'cm-widerstand',
    'Wirksamste Gegenmaßnahme',
    'Betroffene frühzeitig beteiligen - wer mitgestaltet, blockiert selten.',
  ),
  karte(
    'k-cw-5',
    'cm-widerstand',
    'Tal der Tränen',
    'Tiefpunkt der Veränderungskurve: In der emotionalen Akzeptanz ist die wahrgenommene Kompetenz am niedrigsten.',
  ),
  karte(
    'k-cw-6',
    'cm-widerstand',
    'Symptome nach Doppler/Lauterburg',
    'Widerspruch (verbal, aktiv), Ausweichen (verbal, passiv), Aufregung (nonverbal, aktiv), Lustlosigkeit (nonverbal, passiv).',
  ),
  karte(
    'k-cw-7',
    'cm-widerstand',
    'Antwort auf „nicht wollen“',
    'Beteiligen, Nutzen und persönliche Vorteile zeigen, Sorgen ernst nehmen.',
  ),
  karte(
    'k-cw-8',
    'cm-widerstand',
    'Scheinanpassung',
    'Folge von Druck: Das Neue wird nur pro forma genutzt, die eigentliche Arbeit läuft daneben weiter.',
  ),

  // Kaizen
  karte(
    'k-ck-1',
    'cm-kaizen',
    'Kaizen / KVP',
    'Kontinuierliche Verbesserung in kleinen Schritten, getragen von allen Mitarbeitenden.',
  ),
  karte(
    'k-ck-2',
    'cm-kaizen',
    'Muda',
    'Japanisch für Verschwendung: Aufwand ohne Wert für die Kundschaft, z. B. Wartezeit, Nacharbeit.',
  ),
  karte(
    'k-ck-3',
    'cm-kaizen',
    'PDCA',
    'Plan, Do, Check, Act - der Zyklus, mit dem jeder KVP-Schritt durchlaufen wird.',
  ),
  karte(
    'k-ck-4',
    'cm-kaizen',
    'Business Process Reengineering',
    'Radikale, grundlegende Neugestaltung von Prozessen - Gegenentwurf zu Kaizen.',
  ),
  karte(
    'k-ck-5',
    'cm-kaizen',
    'Die 7 Arten der Verschwendung',
    'Transport, Bestände, Bewegung, Wartezeit, Überproduktion, Überbearbeitung, Fehler.',
  ),
  karte(
    'k-ck-6',
    'cm-kaizen',
    '5S',
    'Sortieren, Systematisch ordnen, Sauber halten, Standardisieren, Selbstdisziplin.',
  ),
  karte(
    'k-ck-7',
    'cm-kaizen',
    '5-Why-Methode',
    'Fünfmal „Warum?“ fragen, bis die Grundursache statt des Symptoms gefunden ist.',
  ),
  karte(
    'k-ck-8',
    'cm-kaizen',
    'Gemba',
    'Japanisch für „Ort des Geschehens“: Verbesserungen dort suchen, wo die Arbeit gemacht wird.',
  ),
  karte(
    'k-ck-9',
    'cm-kaizen',
    'KVP vs. Vorschlagswesen',
    'KVP: Team, eigener Bereich, laufend. Vorschlagswesen: Einzelperson, auch fremde Bereiche, meist mit Prämie.',
  ),
];
