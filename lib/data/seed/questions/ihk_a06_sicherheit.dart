import '../../models/question.dart';
import '../builders.dart';

const _andere = ' Andere fachlich richtige Antworten zählen ebenfalls.';

// Auswahl für die Schlüssel-Lücken der Public-Key-Aufgaben.
const _prS = 'privat (Sender)';
const _oeS = 'öffentlich (Sender)';
const _prE = 'privat (Empfänger)';
const _oeE = 'öffentlich (Empfänger)';

Blank _key(String richtig, [String rationale = '']) => wahl(richtig, [
  for (final k in const [_prS, _oeS, _prE, _oeE])
    if (k != richtig) k,
], rationale);

const _stufen = ['normal', 'hoch', 'sehr hoch'];
Blank _stufe(String richtig, [String rationale = '']) => wahl(richtig, [
  for (final s in _stufen)
    if (s != richtig) s,
], rationale);

/// Aufgaben im IHK-Stil zu Bereich 06: Lückentexte, Tabellen, Freitext mit
/// Bewertungskriterien, Markieren, Paare - angelehnt an echte AP1-Aufgaben.
final List<Question> ihkA06 = [
  // ================================================================ Schutzziele
  paare(
    'i6-zz-1',
    'sz-schutzziele',
    scenario:
        'Die Steuerkanzlei Albers & Partner lässt ihr Sicherheitskonzept überarbeiten. Im Entwurf steht zu jedem Schutzziel eine Maßnahme.',
    prompt: 'Ordne jedem Schutzziel die passende Maßnahme zu.',
    paare: [
      paar('Vertraulichkeit', 'Festplatten der Notebooks verschlüsseln'),
      paar('Integrität', 'Hashwert eines Downloads vergleichen'),
      paar('Verfügbarkeit', 'Zweite Internetleitung und USV'),
      paar('Authentizität', 'Anmeldung mit Chipkarte und PIN'),
      paar('Verbindlichkeit', 'Aufträge digital signieren lassen'),
    ],
    explanation:
        'Verschlüsselung hält Unbefugte vom Lesen ab (Vertraulichkeit), ein Hashvergleich deckt Veränderungen auf (Integrität), Redundanz und USV halten Dienste erreichbar (Verfügbarkeit). Die Anmeldung weist die Echtheit der Person nach (Authentizität), eine Signatur verhindert, dass ein Auftrag später abgestritten wird (Verbindlichkeit).',
    punkte: 5,
  ),
  freitext(
    'i6-zz-2',
    'sz-schutzziele',
    scenario:
        'In einer Arztpraxis ist nach einem Festplattendefekt das Terminsystem einen Tag lang ausgefallen. Außerdem hat eine Aushilfe eine Patientenliste an eine falsche E-Mail-Adresse geschickt.',
    prompt:
        'Nenne die drei Grundschutzziele der Informationssicherheit und gib zu jedem eine Maßnahme an, die es unterstützt. (6 P.)',
    kriterien: [
      krit(
        'Vertraulichkeit mit Maßnahme, z. B. Verschlüsselung, Zugriffsrechte, Schulung zum E-Mail-Versand',
        punkte: 2,
        stichwoerter: [
          'Vertraulichkeit',
          'vertraulich',
          'Verschlüsselung',
          'Zugriffsrechte',
        ],
      ),
      krit(
        'Integrität mit Maßnahme, z. B. Hashwerte/Prüfsummen, digitale Signatur, Protokollierung von Änderungen',
        punkte: 2,
        stichwoerter: ['Integrität', 'Hashwert', 'Prüfsumme', 'Signatur'],
      ),
      krit(
        'Verfügbarkeit mit Maßnahme, z. B. Datensicherung, redundante Datenträger oder Server, USV',
        punkte: 2,
        stichwoerter: [
          'Verfügbarkeit',
          'Datensicherung',
          'Backup',
          'Redundanz',
          'USV',
        ],
      ),
    ],
    loesung:
        'Vertraulichkeit: Nur Befugte dürfen Daten lesen - z. B. Verschlüsselung und Zugriffsrechte. Integrität: Daten sind vollständig und unverändert - z. B. Hashwerte oder Signaturen. Verfügbarkeit: Systeme und Daten sind nutzbar, wenn sie gebraucht werden - z. B. Datensicherung, redundante Hardware, USV.',
    explanation:
        'Je Schutzziel 1 Punkt für die Nennung und 1 Punkt für eine passende Maßnahme. Die falsch adressierte Liste verletzt die Vertraulichkeit, der Ausfall die Verfügbarkeit.$_andere',
  ),
  tabelle(
    'i6-zz-3',
    'sz-schutzziele',
    scenario:
        'Ein Hosting-Anbieter bietet drei Tarife mit unterschiedlicher zugesicherter Verfügbarkeit an. Gerechnet wird mit 8.760 Stunden je Jahr und einem Monat mit 30 Tagen (43.200 Minuten).',
    prompt:
        'Berechne die höchstens zulässige Ausfallzeit je Tarif und ergänze die Tabelle.',
    zeilen: [
      ['Verfügbarkeit', 'Ausfall je Jahr (h)', 'Ausfall je Monat (min)'],
      ['99 %', '87,6', '432'],
      [
        '99,5 %',
        zahl(43.8, toleranz: 0.05, rationale: '0,005 × 8.760 h = 43,8 h'),
        zahl(216, rationale: '0,005 × 43.200 min = 216 min'),
      ],
      [
        '99,9 %',
        zahl(8.76, toleranz: 0.01, rationale: '0,001 × 8.760 h = 8,76 h'),
        zahl(43.2, toleranz: 0.05, rationale: '0,001 × 43.200 min = 43,2 min'),
      ],
    ],
    explanation:
        'Zulässiger Ausfall = (100 % - Verfügbarkeit) × Betriebszeit. 99,5 %: 0,005 × 8.760 h = 43,8 h und 0,005 × 43.200 min = 216 min. 99,9 %: 0,001 × 8.760 h = 8,76 h und 0,001 × 43.200 min = 43,2 min.',
    punkte: 4,
  ),
  markieren(
    'i6-zz-4',
    'sz-schutzziele',
    scenario:
        'Die IT-Abteilung der Elbtal Logistik AG führt eine Liste der Sicherheitsvorfälle des letzten Quartals.',
    prompt:
        'Markiere alle Vorfälle, bei denen die Integrität von Daten verletzt wurde.',
    zeilen: [
      ja(
        'Ein Skript überschreibt Lagerbestände mit falschen Mengen',
        'Die Daten sind nicht mehr korrekt - Integrität verletzt.',
      ),
      nein(
        'Das Lagerverwaltungssystem ist nach einem Stromausfall zwei Stunden nicht erreichbar',
        'Die Daten sind unverändert, aber nicht nutzbar - Verfügbarkeit.',
      ),
      ja(
        'Ein Angreifer ändert die Lieferadresse in einem Frachtauftrag',
        'Unbefugte Veränderung von Daten - Integrität verletzt.',
      ),
      nein(
        'Ein Besucher fotografiert die Tourenplanung am Bildschirm',
        'Unbefugte Kenntnisnahme - Vertraulichkeit.',
      ),
      ja(
        'Ein defektes Kabel verfälscht übertragene Scannerdaten unbemerkt',
        'Auch ohne Angreifer gilt: verfälschte Daten verletzen die Integrität.',
      ),
      nein(
        'Ein Notebook mit unverschlüsselten Personaldaten wird gestohlen',
        'Die Daten gelangen an Unbefugte - Vertraulichkeit.',
      ),
    ],
    explanation:
        'Integrität heißt: Daten sind vollständig und unverändert. Verletzt wird sie durch jede unbemerkte oder unbefugte Veränderung - durch Angreifer, Programmfehler oder technische Störungen. Mitlesen betrifft die Vertraulichkeit, Ausfälle die Verfügbarkeit.',
    punkte: 3,
  ),

  // ============================================================== Schadsoftware
  lueckentext(
    'i6-zm-1',
    'sz-schadsoftware',
    scenario:
        'Für eine Schulung der Mitarbeitenden bereitest du eine Übersicht über Arten von Schadsoftware vor.',
    prompt: 'Ergänze die Übersicht mit den passenden Fachbegriffen.',
    text:
        'Ein {0} hängt sich an eine Wirtsdatei und wird erst aktiv, wenn diese ausgeführt wird. Ein {1} verbreitet sich selbstständig über das Netzwerk. Ein {2} gibt sich als nützliches Programm aus und enthält eine versteckte Schadfunktion. {3} verschlüsselt Daten und verlangt Lösegeld.',
    luecken: [
      wort(['Virus'], 'braucht eine Wirtsdatei und eine Aktion des Nutzers'),
      wort(['Wurm'], 'nutzt Sicherheitslücken, kein Zutun des Nutzers nötig'),
      wort(['Trojaner'], 'Tarnung als nützliche Software'),
      wort(['Ransomware'], 'ransom = Lösegeld'),
    ],
    wortbank: ['Spyware', 'Rootkit', 'Adware'],
    explanation:
        'Virus: braucht eine Wirtsdatei. Wurm: verbreitet sich selbstständig über Netze. Trojaner: getarnte Schadfunktion. Ransomware: verschlüsselt und erpresst. Spyware späht aus, ein Rootkit versteckt Schadsoftware im System, Adware blendet Werbung ein.',
    punkte: 4,
  ),
  freitext(
    'i6-zm-2',
    'sz-schadsoftware',
    scenario:
        'In der Grünwerk Gartenbedarf GmbH wurden auf mehreren Kassen-PCs seit Monaten keine Updates für Betriebssystem und Kassensoftware eingespielt.',
    prompt: 'Beschreibe zwei mögliche Folgen fehlender Softwareupdates. (4 P.)',
    kriterien: [
      krit(
        'Bekannte Sicherheitslücken bleiben offen und können von Angreifern oder Schadsoftware ausgenutzt werden',
        punkte: 2,
        stichwoerter: [
          'Sicherheitslücke',
          'Schwachstelle',
          'ausnutzen',
          'Angreifer',
          'Exploit',
        ],
      ),
      krit(
        'Schadsoftware kann sich im Netz ausbreiten - Folge sind Datenverlust, Datenabfluss oder Betriebsausfall',
        punkte: 2,
        stichwoerter: [
          'Schadsoftware',
          'Ransomware',
          'Datenverlust',
          'Ausfall',
          'Malware',
        ],
      ),
      krit(
        'Programmfehler werden nicht behoben, die Software läuft instabil oder fehlerhaft',
        punkte: 2,
        stichwoerter: ['Fehler', 'Bug', 'instabil', 'Absturz'],
      ),
      krit(
        'Herstellersupport und Kompatibilität gehen verloren; der Betrieb entspricht nicht mehr dem Stand der Technik (Haftung, Datenschutz)',
        punkte: 2,
        stichwoerter: [
          'Support',
          'Kompatibilität',
          'Stand der Technik',
          'Haftung',
          'DSGVO',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Ohne Updates bleiben bekannte Sicherheitslücken offen. Angreifer können sie gezielt ausnutzen, etwa um Ransomware einzuschleusen - mit Datenverlust und Stillstand der Kassen als Folge. Außerdem bleiben Programmfehler bestehen, und der Betrieb entspricht nicht mehr dem Stand der Technik.',
    explanation:
        'Je beschriebener Folge 2 Punkte, höchstens 4 Punkte. Erwartet wird eine Aussage mit kurzer Ausführung, nicht nur ein Stichwort.$_andere',
  ),
  mehrfach(
    'i6-zm-3',
    'sz-schadsoftware',
    scenario:
        'Der Hersteller einer Backup-Software verschickt eine Sicherheitswarnung an seine Kunden.',
    code:
        'SECURITY ADVISORY 2026-014\n\nA ransomware group is actively exploiting a flaw in\nversion 7.2 of our backup agent. We strongly recommend\nthat you install patch 7.2.4 without delay. Until the\npatch is applied, block TCP port 9401 at your firewall.\nKeep at least one backup copy offline so that it cannot\nbe encrypted. Finally, review the agent log files for\nlogins from unknown addresses.',
    prompt:
        'Welche Maßnahmen empfiehlt der Hersteller im Text? Wähle alle zutreffenden aus.',
    choices: [
      ja(
        'Den Patch 7.2.4 umgehend installieren',
        '„install patch 7.2.4 without delay“',
      ),
      ja(
        'Bis dahin den TCP-Port 9401 an der Firewall sperren',
        '„block TCP port 9401 at your firewall“',
      ),
      ja(
        'Mindestens eine Sicherungskopie offline aufbewahren',
        '„Keep at least one backup copy offline“',
      ),
      ja(
        'Die Protokolldateien auf Anmeldungen von unbekannten Adressen prüfen',
        '„review the agent log files for logins from unknown addresses“',
      ),
      nein(
        'Alle Passwörter der Benutzer zurücksetzen',
        'Sinnvoll nach einem Einbruch, steht aber nicht im Text.',
      ),
      nein(
        'Die Software deinstallieren und auf ein anderes Produkt wechseln',
        'Davon ist im Text keine Rede - der Hersteller liefert einen Patch.',
      ),
      nein(
        'Das geforderte Lösegeld zahlen',
        'Wird im Text nicht genannt und ist grundsätzlich nicht zu empfehlen.',
      ),
    ],
    explanation:
        'Der Text nennt vier Maßnahmen: Patch einspielen, Port 9401 bis dahin sperren, eine Offline-Sicherung vorhalten und die Logdateien prüfen. In der Prüfung zählt nur, was im Text steht - eigene Ideen bringen hier keine Punkte.',
    punkte: 4,
    tags: ['englisch'],
  ),
  reihenfolge(
    'i6-zm-4',
    'sz-schadsoftware',
    scenario:
        'Auf dem PC einer Sachbearbeiterin erscheint eine Lösegeldforderung, mehrere Dateien auf dem Netzlaufwerk lassen sich nicht mehr öffnen.',
    prompt:
        'Bringe die Schritte der Vorfallsbehandlung in eine sinnvolle Reihenfolge.',
    items: [
      'Betroffenen PC sofort vom Netzwerk trennen',
      'Vorfall an die IT bzw. die verantwortliche Stelle melden',
      'Umfang feststellen: betroffene Systeme und Daten ermitteln',
      'Betroffene Systeme bereinigen oder neu aufsetzen',
      'Daten aus einer sauberen Sicherung zurückspielen',
      'Ursache auswerten und Schutzmaßnahmen verbessern',
    ],
    hint:
        'Erst eindämmen, dann melden und untersuchen, zuletzt wiederherstellen.',
    explanation:
        'Zuerst wird die Ausbreitung gestoppt (Netz trennen) und der Vorfall gemeldet. Danach wird der Umfang ermittelt. Erst auf bereinigten oder neu aufgesetzten Systemen werden die Daten zurückgespielt - sonst wird die Sicherung gleich wieder verschlüsselt. Am Ende steht die Auswertung.',
    punkte: 3,
  ),

  // =================================================================== Angriffe
  markieren(
    'i6-za-1',
    'sz-angriffe',
    scenario:
        'Eine Mitarbeiterin aus dem Einkauf der Grünwerk Gartenbedarf GmbH leitet dir eine E-Mail weiter, die ihr merkwürdig vorkommt. Das Unternehmen ist Kunde der Nordbank.',
    prompt:
        'Markiere alle Zeilen der E-Mail, die auf einen Phishing-Versuch hindeuten.',
    zeilen: [
      ja(
        'Von: Nordbank Service <sicherheit@n0rdbank-kunden.example>',
        'Die Domain ist nachgeahmt (Null statt o, fremder Zusatz).',
      ),
      ja(
        'Betreff: DRINGEND - Ihr Konto wird in 24 Stunden gesperrt',
        'Zeitdruck und Drohung sind typische Mittel des Social Engineering.',
      ),
      ja(
        'Sehr geehrter Kunde,',
        'Unpersönliche Anrede - die echte Bank kennt den Namen.',
      ),
      nein(
        'unser System wurde in der vergangenen Woche aktualisiert.',
        'Eine neutrale Information ohne Aufforderung - für sich kein Merkmal.',
      ),
      ja(
        'Bestätigen Sie Ihre PIN und TAN unter http://nordbank.kunden-login.example',
        'Banken fragen nie per Mail nach PIN und TAN; der Link führt auf eine fremde Domain und ist unverschlüsselt.',
      ),
      ja(
        'Anhang: Sicherheitsformular.pdf.exe',
        'Doppelte Dateiendung - tatsächlich ein ausführbares Programm.',
      ),
      nein(
        'Mit freundlichen Grüßen',
        'Eine übliche Grußformel sagt nichts über die Echtheit aus.',
      ),
    ],
    explanation:
        'Typische Phishing-Merkmale: gefälschte Absenderdomain, Zeitdruck und Drohungen, unpersönliche Anrede, Aufforderung zur Eingabe von Zugangsdaten über einen Link auf eine fremde Seite und ausführbare Anhänge mit getarnter Endung.',
    punkte: 5,
  ),
  paare(
    'i6-za-2',
    'sz-angriffe',
    prompt: 'Ordne jedem Angriff die Gegenmaßnahme zu, die am besten hilft.',
    paare: [
      paar('Phishing', 'Mitarbeitende regelmäßig sensibilisieren'),
      paar('Brute-Force-Angriff', 'Konto nach Fehlversuchen sperren'),
      paar('Man-in-the-Middle', 'Verschlüsselung mit Zertifikatsprüfung'),
      paar('DDoS-Angriff', 'Verkehr beim Provider filtern lassen'),
      paar('Tailgating', 'Vereinzelungsanlage am Eingang'),
    ],
    explanation:
        'Gegen Täuschung hilft vor allem Aufmerksamkeit (Schulung). Kontosperren und Wartezeiten bremsen das Durchprobieren von Passwörtern. TLS mit geprüftem Zertifikat verhindert das unbemerkte Einklinken in die Verbindung. Überlastungsangriffe werden beim Provider gefiltert. Gegen das Hinterherlaufen durch die Tür hilft eine Vereinzelung.',
    punkte: 5,
  ),
  freitext(
    'i6-za-3',
    'sz-angriffe',
    scenario:
        'Die Elbtal Logistik AG hat zehn Handscanner über einen unbekannten Onlinehändler bestellt. Bei der Lieferung sind die Siegel einiger Kartons aufgebrochen.',
    prompt:
        'Beschreibe ein Risiko, das von manipulierten Geräten in der Lieferkette ausgeht, und nenne zwei Maßnahmen, mit denen sich das Unternehmen schützt. (4 P.)',
    kriterien: [
      krit(
        'Risiko: unbemerkt eingebaute Hintertür oder Abhörfunktion - Daten werden ausgelesen oder das Gerät wird ferngesteuert',
        punkte: 2,
        stichwoerter: [
          'Hintertür',
          'Backdoor',
          'abhören',
          'auslesen',
          'Fernzugriff',
          'mitlesen',
        ],
      ),
      krit(
        'Risiko: manipulierte Firmware bringt Schadsoftware ins interne Netz oder schaltet Sicherheitsfunktionen ab',
        punkte: 2,
        stichwoerter: [
          'Firmware',
          'Schadsoftware',
          'Malware',
          'Sicherheitsfunktion',
          'deaktiviert',
        ],
      ),
      krit(
        'Maßnahme: nur beim Hersteller oder bei autorisierten Händlern beschaffen',
        stichwoerter: [
          'autorisiert',
          'Hersteller',
          'vertrauenswürdig',
          'Fachhändler',
          'zertifiziert',
        ],
      ),
      krit(
        'Maßnahme: Verpackung, Siegel und Seriennummern bei der Annahme prüfen',
        stichwoerter: ['Siegel', 'Verpackung', 'Seriennummer', 'Wareneingang'],
      ),
      krit(
        'Maßnahme: Firmware vor Inbetriebnahme aus der Herstellerquelle neu einspielen und Hashwert bzw. Signatur prüfen',
        stichwoerter: [
          'neu einspielen',
          'Hashwert',
          'Signatur',
          'zurücksetzen',
          'Werkszustand',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Risiko: Auf dem Weg vom Hersteller zum Kunden kann ein Gerät verändert worden sein, etwa durch eine Hintertür in der Firmware. Damit lassen sich Daten unbemerkt auslesen oder das Gerät dient als Einstieg ins interne Netz. Maßnahmen: nur bei autorisierten Händlern kaufen, Siegel und Seriennummern prüfen, Firmware vor dem Einsatz aus der Herstellerquelle neu einspielen und deren Hashwert prüfen.',
    explanation:
        '2 Punkte für ein beschriebenes Risiko, je 1 Punkt für zwei Maßnahmen - höchstens 4 Punkte.$_andere',
  ),

  // ================================================================ Schutzbedarf
  tabelle(
    'i6-zb-1',
    'sz-schutzbedarf',
    scenario:
        'Für die Steuerkanzlei Albers & Partner wird der Schutzbedarf festgestellt. Die Kanzlei hat dafür eigene Regeln festgelegt (siehe Tabelle).\n\nDateiserver: Mandantenakten mit Steuerdaten, ein Ausfall von einem Arbeitstag ist verkraftbar.\nWebsite: nur öffentliche Informationen, ein Ausfall von mehreren Tagen ist verkraftbar.\nTelefonanlage: keine gespeicherten Mandantendaten, muss innerhalb einer Stunde wieder laufen.',
    table: [
      ['Kategorie', 'Vertraulichkeit', 'Verfügbarkeit'],
      ['normal', 'öffentliche oder interne Daten', 'Ausfall über 24 h tragbar'],
      ['hoch', 'personenbezogene Daten', 'Ausfall bis 24 h tragbar'],
      ['sehr hoch', 'Daten unter Berufsgeheimnis', 'Ausfall höchstens 1 h'],
    ],
    prompt:
        'Ergänze für jedes System den Schutzbedarf nach den Regeln der Kanzlei.',
    zeilen: [
      ['System', 'Vertraulichkeit', 'Verfügbarkeit'],
      [
        'Dateiserver',
        _stufe('sehr hoch', 'Mandantenakten unterliegen dem Berufsgeheimnis.'),
        _stufe('hoch', 'Ein Arbeitstag Ausfall ist tragbar, mehr nicht.'),
      ],
      [
        'Website',
        _stufe('normal', 'Nur öffentliche Informationen.'),
        _stufe('normal', 'Mehrere Tage Ausfall sind tragbar.'),
      ],
      [
        'Telefonanlage',
        _stufe('normal', 'Es werden keine Mandantendaten gespeichert.'),
        _stufe('sehr hoch', 'Höchstens eine Stunde Ausfall.'),
      ],
    ],
    explanation:
        'Der Schutzbedarf wird je Schutzziel getrennt bestimmt. Dateiserver: Berufsgeheimnis -> Vertraulichkeit sehr hoch, ein Tag Ausfall tragbar -> Verfügbarkeit hoch. Website: beides normal. Telefonanlage: Vertraulichkeit normal, aber Verfügbarkeit sehr hoch.',
    punkte: 6,
  ),
  lueckentext(
    'i6-zb-2',
    'sz-schutzbedarf',
    scenario:
        'Auf einem Server laufen drei Anwendungen: die Zeiterfassung (Schutzbedarf normal), die Lohnabrechnung (hoch) und das Intranet (normal).',
    prompt: 'Ergänze die Aussagen zur Vererbung des Schutzbedarfs.',
    text:
        'Der Server erhält nach dem {0} den Schutzbedarf {1}, weil die Anwendung mit dem höchsten Bedarf maßgeblich ist. Laufen sehr viele Anwendungen mit normalem Bedarf auf einem Server, kann sein Bedarf durch den {2} steigen, weil ein Ausfall alle zugleich trifft. Ist eine Anwendung auf mehrere redundante Server verteilt, kann der Bedarf des einzelnen Servers durch den {3} sinken.',
    luecken: [
      wahl('Maximumprinzip', ['Minimalprinzip', 'Verteilungseffekt']),
      _stufe('hoch', 'Die Lohnabrechnung bestimmt den Bedarf.'),
      wahl('Kumulationseffekt', ['Verteilungseffekt', 'Lawineneffekt']),
      wahl('Verteilungseffekt', ['Kumulationseffekt', 'Maximumprinzip']),
    ],
    explanation:
        'Maximumprinzip: Der höchste Schutzbedarf der Anwendungen vererbt sich auf das System - hier „hoch“. Kumulationseffekt: Viele kleinere Schäden summieren sich zu einem größeren. Verteilungseffekt: Redundanz senkt den Bedarf des einzelnen Systems.',
    punkte: 4,
  ),
  freitext(
    'i6-zb-3',
    'sz-schutzbedarf',
    scenario:
        'Bei der Schutzbedarfsfeststellung nach BSI wird für jedes Schutzziel gefragt: „Was wäre, wenn …?“ Dafür gibt das BSI Schadensszenarien vor.',
    prompt:
        'Nenne drei Schadensszenarien, die bei der Schutzbedarfsfeststellung betrachtet werden. (3 P.)',
    kriterien: [
      krit(
        'Verstoß gegen Gesetze, Vorschriften oder Verträge',
        stichwoerter: ['Gesetz', 'Vorschrift', 'Vertrag', 'Verstoß'],
      ),
      krit(
        'Beeinträchtigung des informationellen Selbstbestimmungsrechts (Datenschutz)',
        stichwoerter: [
          'Selbstbestimmung',
          'Datenschutz',
          'personenbezogen',
          'Persönlichkeitsrecht',
        ],
      ),
      krit(
        'Beeinträchtigung der persönlichen Unversehrtheit',
        stichwoerter: ['Unversehrtheit', 'Gesundheit', 'Verletzung', 'Leben'],
      ),
      krit(
        'Beeinträchtigung der Aufgabenerfüllung',
        stichwoerter: [
          'Aufgabenerfüllung',
          'Arbeitsfähigkeit',
          'Betriebsablauf',
          'Stillstand',
        ],
      ),
      krit(
        'Negative Innen- oder Außenwirkung (Ansehens- und Vertrauensverlust)',
        stichwoerter: [
          'Außenwirkung',
          'Image',
          'Ansehen',
          'Vertrauensverlust',
          'Ruf',
        ],
      ),
      krit(
        'Finanzielle Auswirkungen',
        stichwoerter: ['finanziell', 'Kosten', 'Umsatz', 'Geld'],
      ),
    ],
    punkte: 3,
    loesung:
        'Schadensszenarien des BSI: Verstoß gegen Gesetze, Vorschriften oder Verträge; Beeinträchtigung des informationellen Selbstbestimmungsrechts; Beeinträchtigung der persönlichen Unversehrtheit; Beeinträchtigung der Aufgabenerfüllung; negative Innen- oder Außenwirkung; finanzielle Auswirkungen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Stichworte genügen; überzählige Nennungen werden nicht gewertet.',
  ),

  // =================================================================== Firewall
  tabelle(
    'i6-yf-1',
    'sm-firewall',
    scenario:
        'Die Pixelhafen Medien GmbH betreibt einen Webserver in der DMZ. Vorgaben: Aus dem Internet ist nur HTTPS zum Webserver erlaubt. Die Administratoren warten den Webserver vom LAN aus per SSH. Alles andere wird verworfen.',
    prompt: 'Ergänze das Regelwerk der Firewall.',
    zeilen: [
      ['Quelle', 'Ziel', 'Port', 'Aktion'],
      [
        'Internet',
        'Webserver (DMZ)',
        wahl('TCP 443', ['TCP 23', 'TCP 25', 'UDP 53'], 'HTTPS'),
        'erlauben',
      ],
      [
        'Admin-PC (LAN)',
        'Webserver (DMZ)',
        wahl('TCP 22', ['TCP 21', 'TCP 23', 'TCP 3389'], 'SSH'),
        wahl('erlauben', ['verwerfen', 'umleiten']),
      ],
      [
        'Internet',
        wahl('LAN', [
          'Webserver (DMZ)',
          'Internet',
        ], 'Kein Zugriff von außen ins interne Netz.'),
        'alle',
        'verwerfen',
      ],
      [
        'alle',
        'alle',
        'alle',
        wahl('verwerfen', [
          'erlauben',
          'protokollieren',
        ], 'Default Deny als letzte Regel'),
      ],
    ],
    explanation:
        'HTTPS nutzt TCP 443, SSH nutzt TCP 22. Verbindungen aus dem Internet ins LAN werden verworfen. Als letzte Regel steht immer „alles verwerfen“ (Default Deny) - erlaubt ist nur, was ausdrücklich freigegeben wurde.',
    punkte: 5,
  ),
  markieren(
    'i6-yf-2',
    'sm-firewall',
    mono: true,
    scenario:
        'Sicherheitsrichtlinie: Aus dem Internet ist nur HTTPS zum Webserver in der DMZ erlaubt. Aus dem Internet und aus der DMZ dürfen keine Verbindungen ins LAN aufgebaut werden. Bei der Prüfung der Firewall findest du folgendes Regelwerk.',
    prompt: 'Markiere alle Regeln, die gegen die Richtlinie verstoßen.',
    zeilen: [
      nein(
        '1 ALLOW Internet -> DMZ-Web  tcp/443',
        'HTTPS zum Webserver ist ausdrücklich erlaubt.',
      ),
      ja(
        '2 ALLOW Internet -> LAN-File tcp/445',
        'Dateifreigaben aus dem Internet ins LAN - klarer Verstoß.',
      ),
      nein(
        '3 ALLOW LAN      -> Internet tcp/80,443',
        'Surfen aus dem LAN verbietet die Richtlinie nicht.',
      ),
      ja(
        '4 ALLOW Internet -> DMZ-Web  tcp/3389',
        'Fernwartung (RDP) aus dem Internet ist nicht vorgesehen - nur HTTPS.',
      ),
      ja(
        '5 ALLOW DMZ-Web  -> LAN      any',
        'Die DMZ darf keine Verbindungen ins LAN aufbauen.',
      ),
      nein(
        '6 DENY  any      -> any      any',
        'Default Deny am Ende ist richtig.',
      ),
    ],
    explanation:
        'Regel 2 öffnet das LAN nach außen, Regel 4 erlaubt neben HTTPS auch RDP zum Webserver, Regel 5 hebt die Trennung zwischen DMZ und LAN auf. Wird der Webserver übernommen, stünde dem Angreifer sonst das ganze LAN offen.',
    punkte: 3,
  ),
  freitext(
    'i6-yf-3',
    'sm-firewall',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH betreibt ihren Webshop auf einem eigenen Server. Er soll in einer DMZ stehen.',
    skizze: NetzSkizze(
      [
        NetzKnoten('inet', 'Internet', NetzTyp.internet, 2, 0),
        NetzKnoten('fw', 'Firewall', NetzTyp.firewall, 2, 1.6),
        NetzKnoten('web', 'Webshop', NetzTyp.server, 0.6, 3.4),
        NetzKnoten('sw', 'Switch', NetzTyp.switch_, 3.4, 3.4),
        NetzKnoten('pc', 'PCs', NetzTyp.pc, 3.4, 5),
      ],
      verbindungen: [
        NetzVerbindung('inet', 'fw'),
        NetzVerbindung('fw', 'web'),
        NetzVerbindung('fw', 'sw'),
        NetzVerbindung('sw', 'pc'),
      ],
      zonen: [
        NetzZone('DMZ', 0, 2.7, 1.3, 4.1),
        NetzZone('LAN', 2.7, 2.7, 4, 5.7),
      ],
    ),
    prompt: 'Erläutere den Zweck einer DMZ. (4 P.)',
    kriterien: [
      krit(
        'Aus dem Internet erreichbare Server stehen in einer eigenen Netzzone, getrennt vom internen Netz',
        punkte: 2,
        stichwoerter: [
          'eigene Zone',
          'getrennt',
          'Pufferzone',
          'abgetrennt',
          'eigenes Netz',
        ],
      ),
      krit(
        'Wird ein Server in der DMZ übernommen, hat der Angreifer noch keinen direkten Zugriff auf das LAN',
        punkte: 2,
        stichwoerter: [
          'kein Zugriff auf das LAN',
          'internes Netz geschützt',
          'kompromittiert',
          'übernommen',
          'kein direkter Zugriff',
        ],
      ),
      krit(
        'Die Firewall regelt den Verkehr zwischen Internet, DMZ und LAN getrennt',
        punkte: 2,
        stichwoerter: ['Firewall', 'Regeln', 'filtert', 'Verkehr'],
      ),
    ],
    punkte: 4,
    loesung:
        'Eine DMZ ist eine eigene Netzzone für Server, die aus dem Internet erreichbar sein müssen. Sie ist durch die Firewall sowohl vom Internet als auch vom internen Netz getrennt. Wird der Webshop angegriffen und übernommen, steht der Angreifer nur in der DMZ - der Weg ins LAN mit den internen Daten bleibt durch die Firewall versperrt.',
    explanation:
        'Je Aspekt 2 Punkte, höchstens 4 Punkte: Trennung öffentlicher Server vom internen Netz und der Schutz des LAN, falls ein Server übernommen wird.$_andere',
  ),

  // ============================================================== Datensicherung
  tabelle(
    'i6-yb-1',
    'sm-backup',
    scenario:
        'Am Sonntag läuft eine Vollsicherung mit 200 GB. Von Montag bis Donnerstag werden täglich 10 GB jeweils anderer Dateien geändert und abends gesichert. Verglichen werden zwei Verfahren. Am Freitagmorgen fällt der Server aus.',
    prompt:
        'Ergänze die Größe der täglichen Sicherung in GB und die Anzahl der Sicherungen, die für die Wiederherstellung nötig sind.',
    zeilen: [
      ['Tag', 'differenziell', 'inkrementell'],
      ['Montag', '10', '10'],
      [
        'Dienstag',
        zahl(20, rationale: 'alle Änderungen seit Sonntag: 10 + 10'),
        zahl(10, rationale: 'nur die Änderungen seit Montag'),
      ],
      ['Mittwoch', zahl(30), '10'],
      [
        'Donnerstag',
        zahl(40, rationale: '4 × 10 GB seit der Vollsicherung'),
        zahl(10),
      ],
      [
        'Sicherungen für die Wiederherstellung',
        zahl(2, rationale: 'Vollsicherung + Donnerstag'),
        zahl(5, rationale: 'Vollsicherung + Mo, Di, Mi, Do'),
      ],
    ],
    explanation:
        'Differenziell: immer alle Änderungen seit der letzten Vollsicherung - 10, 20, 30, 40 GB. Zurückgespielt werden nur die Vollsicherung und die letzte differenzielle (2). Inkrementell: nur die Änderungen seit der letzten Sicherung - jeweils 10 GB. Zurückgespielt werden die Vollsicherung und alle vier Inkremente (5).',
    punkte: 7,
  ),
  freitext(
    'i6-yb-2',
    'sm-backup',
    scenario:
        'Die Pixelhafen Medien GmbH sichert ihre Projektdaten bisher jede Nacht vollständig. Das dauert inzwischen zu lange. Zur Wahl stehen eine differenzielle und eine inkrementelle Sicherung an den Werktagen.',
    prompt:
        'Beschreibe zwei Unterschiede zwischen differenzieller und inkrementeller Sicherung. (4 P.)',
    kriterien: [
      krit(
        'Umfang: differenziell sichert alle Änderungen seit der letzten Vollsicherung, inkrementell nur die Änderungen seit der letzten Sicherung',
        punkte: 2,
        stichwoerter: [
          'seit der letzten Vollsicherung',
          'seit der letzten Sicherung',
          'seit dem letzten Backup',
          'Änderungen seit',
        ],
      ),
      krit(
        'Speicher und Dauer: inkrementelle Sicherungen bleiben klein und schnell, differenzielle wachsen von Tag zu Tag',
        punkte: 2,
        stichwoerter: [
          'Speicherplatz',
          'Speicherbedarf',
          'kleiner',
          'schneller',
          'wächst',
        ],
      ),
      krit(
        'Wiederherstellung: differenziell braucht Vollsicherung und letzte differenzielle, inkrementell die Vollsicherung und alle Inkremente - dauert länger, eine defekte Sicherung unterbricht die Kette',
        punkte: 2,
        stichwoerter: [
          'Wiederherstellung',
          'Restore',
          'alle Inkremente',
          'Kette',
          'zurückspielen',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Die differenzielle Sicherung enthält alle Änderungen seit der letzten Vollsicherung und wird deshalb täglich größer. Die inkrementelle enthält nur die Änderungen seit der letzten Sicherung und bleibt klein und schnell. Dafür braucht die Wiederherstellung bei inkrementeller Sicherung die Vollsicherung und alle Inkremente in der richtigen Reihenfolge, bei differenzieller nur die Vollsicherung und die letzte differenzielle.',
    explanation:
        'Je Unterschied 2 Punkte, höchstens 4 Punkte. Wichtig ist der Vergleich beider Verfahren, nicht nur die Beschreibung eines.$_andere',
  ),
  rechnen(
    'i6-yb-3',
    'sm-backup',
    scenario:
        'Ein Sicherungsplan sieht vor: jeden Sonntag eine Vollsicherung mit 400 GB, an den übrigen sechs Tagen je eine inkrementelle Sicherung mit 15 GB. Alle Sicherungen werden vier Wochen lang aufbewahrt.',
    prompt:
        'Berechne, wie viel Speicherplatz für die Sicherungen von vier Wochen mindestens bereitstehen muss.',
    answer: 1960,
    unit: 'GB',
    explanation:
        'Eine Woche: 400 GB + 6 × 15 GB = 400 GB + 90 GB = 490 GB. Vier Wochen: 4 × 490 GB = 1.960 GB.',
    punkte: 3,
  ),
  paare(
    'i6-yb-4',
    'sm-backup',
    prompt: 'Ordne jedem Begriff der Datensicherung die Erklärung zu.',
    paare: [
      paar('RPO', 'Höchster tragbarer Datenverlust als Zeitraum'),
      paar('RTO', 'Höchste tragbare Dauer bis zum Wiederanlauf'),
      paar('3-2-1-Regel', '3 Kopien, 2 Medienarten, 1 außer Haus'),
      paar(
        'Offline-Sicherung',
        'Vom Netz getrennt, für Ransomware unerreichbar',
      ),
      paar(
        'Wiederherstellungstest',
        'Prüft, ob sich die Sicherung zurückspielen lässt',
      ),
    ],
    explanation:
        'RPO (Recovery Point Objective) bestimmt, wie oft gesichert werden muss; RTO (Recovery Time Objective), wie schnell die Wiederherstellung gehen muss. Die 3-2-1-Regel schützt vor dem Verlust aller Kopien, eine Offline-Sicherung vor Verschlüsselung durch Ransomware. Erst ein Wiederherstellungstest zeigt, ob die Sicherung taugt.',
    punkte: 5,
  ),

  // ======================================================================= WLAN
  markieren(
    'i6-yw-1',
    'sm-wlan',
    mono: true,
    scenario:
        'In der neuen Filiale der Grünwerk Gartenbedarf GmbH hat ein Dienstleister einen Access Point eingerichtet. Du prüfst die Konfiguration.',
    prompt: 'Markiere alle unsicheren Einstellungen.',
    zeilen: [
      nein(
        'SSID:           Filiale-Buero',
        'Der Netzname ist kein Sicherheitsmerkmal.',
      ),
      ja(
        'Verschlüsselung:  WPA (TKIP)',
        'WPA mit TKIP ist veraltet - Stand der Technik ist WPA3, mindestens WPA2 mit AES.',
      ),
      ja(
        'WLAN-Schlüssel:  12345678',
        'Kurz und in jeder Passwortliste enthalten - per Wörterbuchangriff sofort gefunden.',
      ),
      ja(
        'WPS (PIN):      aktiviert',
        'Die WPS-PIN lässt sich in wenigen Stunden durchprobieren.',
      ),
      ja(
        'Admin-Login:    admin / admin',
        'Standardzugangsdaten stehen im Handbuch und in Listen im Internet.',
      ),
      nein(
        'Firmware:       aktuell, Auto-Update an',
        'Aktuelle Firmware schließt bekannte Lücken.',
      ),
      nein(
        'Gastnetz:       eigenes VLAN, kein LAN-Zugriff',
        'Gäste vom internen Netz zu trennen ist richtig.',
      ),
      ja(
        'Fernwartung:    aus dem Internet, HTTP',
        'Die Verwaltung ist von außen erreichbar und unverschlüsselt.',
      ),
    ],
    explanation:
        'Unsicher sind: veraltete Verschlüsselung (WPA/TKIP), ein schwacher Schlüssel, aktiviertes WPS mit PIN, Standardzugangsdaten für die Verwaltung und eine unverschlüsselte Fernwartung aus dem Internet. Ein eigener Netzname, aktuelle Firmware und ein getrenntes Gastnetz sind in Ordnung.',
    punkte: 5,
  ),
  freitext(
    'i6-yw-2',
    'sm-wlan',
    scenario:
        'Die Elbtal Logistik AG übernimmt von der Konzernmutter eine Richtlinie für Funknetze.',
    code:
        'WIRELESS NETWORK POLICY (excerpt)\n\n1. All access points must use WPA3 or, where older\n   devices require it, WPA2 with AES.\n2. Guests are only allowed to connect to the separate\n   guest network, which has no access to internal servers.\n3. The default administrator password of every access\n   point must be changed before it goes into service.\n4. WPS must be switched off on all devices.\n5. Firmware updates have to be installed within 14 days\n   after release.',
    prompt:
        'Nenne vier Vorgaben, die die Richtlinie für den Betrieb der Access Points macht. Antworte auf Deutsch. (4 P.)',
    kriterien: [
      krit(
        'Verschlüsselung mit WPA3, ersatzweise WPA2 mit AES',
        stichwoerter: ['WPA3', 'WPA2', 'AES', 'Verschlüsselung'],
      ),
      krit(
        'Gäste nur im getrennten Gastnetz ohne Zugriff auf interne Server',
        stichwoerter: ['Gastnetz', 'Gäste', 'getrennt', 'Gast-WLAN'],
      ),
      krit(
        'Standard-Administratorpasswort vor Inbetriebnahme ändern',
        stichwoerter: [
          'Standardpasswort',
          'Administratorpasswort',
          'Passwort ändern',
          'Admin-Passwort',
        ],
      ),
      krit(
        'WPS auf allen Geräten abschalten',
        stichwoerter: ['WPS', 'abschalten', 'deaktivieren', 'ausschalten'],
      ),
      krit(
        'Firmware-Updates innerhalb von 14 Tagen einspielen',
        stichwoerter: ['Firmware', 'Update', '14 Tage', 'aktualisieren'],
      ),
    ],
    punkte: 4,
    loesung:
        'Die Richtlinie verlangt: WPA3 (bei alten Geräten WPA2 mit AES), Gäste nur im getrennten Gastnetz ohne Zugriff auf interne Server, das Standardpasswort des Administrators vor der Inbetriebnahme ändern, WPS abschalten und Firmware-Updates innerhalb von 14 Tagen nach Erscheinen einspielen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Der Text enthält fünf Vorgaben - gewertet wird nur, was im Text steht. Stichworte auf Deutsch genügen.',
    tags: ['englisch'],
  ),
  lueckentext(
    'i6-yw-3',
    'sm-wlan',
    scenario:
        'Für ein Angebot an die Steuerkanzlei Albers & Partner beschreibst du die Absicherung des neuen WLAN.',
    prompt: 'Ergänze den Text.',
    text:
        'Im Modus „Personal“ melden sich alle Geräte mit demselben {0} an. WPA3 ersetzt dessen Aushandlung durch das Verfahren {1} und schützt so vor Wörterbuchangriffen auf mitgeschnittene Anmeldungen. Für die Kanzlei empfehlen wir den Modus {2}: Jede Person meldet sich nach dem Standard {3} mit eigenen Zugangsdaten an, die ein {4}-Server prüft. Scheidet jemand aus, wird nur dieses eine Konto gesperrt.',
    luecken: [
      wahl('Pre-Shared Key (PSK)', ['Zertifikat', 'Sitzungsschlüssel']),
      wahl('SAE', ['TKIP', 'WPS', 'WEP']),
      wahl('Enterprise', ['Personal', 'Open']),
      wahl('802.1X', ['802.3af', '802.11n', '802.1Q']),
      wahl('RADIUS', ['DHCP', 'DNS', 'NTP']),
    ],
    explanation:
        'WPA2/WPA3-Personal: ein gemeinsamer Schlüssel (PSK) für alle. WPA3 handelt ihn per SAE aus. Im Enterprise-Modus meldet sich jede Person einzeln nach 802.1X an, ein RADIUS-Server prüft die Zugangsdaten - beim Ausscheiden muss kein gemeinsamer Schlüssel getauscht werden.',
    punkte: 5,
  ),

  // ================================================================ Zugriffsschutz
  freitext(
    'i6-yz-1',
    'sm-zugriff',
    scenario:
        'Die Elbtal Logistik AG nimmt zwölf Netzwerkkameras in Betrieb. Ab Werk sind alle mit dem Benutzer „admin“ und dem Passwort „admin“ eingerichtet. Ein Kollege meint, das könne im internen Netz so bleiben.',
    prompt:
        'Erläutere zwei Risiken, die von unveränderten Standardpasswörtern ausgehen. (4 P.)',
    kriterien: [
      krit(
        'Standardpasswörter sind öffentlich bekannt (Handbuch, Listen im Internet) und bei allen Geräten der Baureihe gleich',
        punkte: 2,
        stichwoerter: [
          'öffentlich bekannt',
          'Handbuch',
          'Internet',
          'bei allen Geräten gleich',
          'bekannt',
        ],
      ),
      krit(
        'Angreifer oder automatisierte Scans übernehmen das Gerät: Bilder mitsehen, Einstellungen ändern, Aufzeichnung abschalten',
        punkte: 2,
        stichwoerter: [
          'übernehmen',
          'mitsehen',
          'umkonfigurieren',
          'Einstellungen ändern',
          'Zugriff',
        ],
      ),
      krit(
        'Das übernommene Gerät dient als Sprungbrett ins interne Netz oder wird Teil eines Botnetzes',
        punkte: 2,
        stichwoerter: ['Botnetz', 'Sprungbrett', 'internes Netz', 'Einstieg'],
      ),
    ],
    punkte: 4,
    loesung:
        'Standardpasswörter stehen im Handbuch und in Listen im Internet und sind bei allen Geräten der Baureihe gleich. Jeder im Netz - auch Schadsoftware auf einem befallenen PC - kann sich damit anmelden, Kamerabilder mitsehen, Einstellungen ändern oder die Aufzeichnung abschalten. Ein übernommenes Gerät kann außerdem als Sprungbrett für Angriffe auf weitere Systeme oder als Teil eines Botnetzes dienen.',
    explanation:
        'Je Risiko 2 Punkte, höchstens 4 Punkte. Auch im internen Netz gilt: Standardpasswörter werden vor der Inbetriebnahme geändert.$_andere',
  ),
  markieren(
    'i6-yz-2',
    'sm-zugriff',
    mono: true,
    scenario:
        'Die Pixelhafen Medien GmbH mietet einen Linux-Server für Kundenprojekte. Vor der Inbetriebnahme prüfst du den Zustand des Systems.',
    prompt:
        'Markiere alle Einträge, die bei der Härtung des Servers geändert werden müssen.',
    zeilen: [
      ja(
        'telnet:  aktiv (Port 23)',
        'Telnet überträgt alles im Klartext - abschalten, SSH nutzen.',
      ),
      ja(
        'ssh:     PermitRootLogin yes',
        'Direkte Anmeldung als root verbieten, mit eigenem Konto anmelden.',
      ),
      nein(
        'ssh:     Anmeldung nur mit Schlüssel',
        'Schlüsselanmeldung ist sicherer als Passwörter.',
      ),
      ja(
        'konto:   gast, aktiv, ohne Passwort',
        'Nicht benötigte Konten entfernen, kein Konto ohne Passwort.',
      ),
      nein(
        'updates: Sicherheitsupdates automatisch',
        'Zeitnahe Updates gehören zur Härtung.',
      ),
      ja(
        'ftp:     aktiv, wird nicht genutzt',
        'Nicht benötigte Dienste abschalten - zudem ist FTP unverschlüsselt.',
      ),
      nein(
        'firewall: nur 22 und 443 offen',
        'Nur die benötigten Ports sind geöffnet.',
      ),
    ],
    explanation:
        'Härtung heißt: Angriffsfläche verkleinern. Unverschlüsselte und ungenutzte Dienste (Telnet, FTP) abschalten, die direkte root-Anmeldung sperren und überflüssige Konten entfernen. Schlüsselanmeldung, automatische Sicherheitsupdates und eine restriktive Firewall sind richtig.',
    punkte: 4,
  ),
  tabelle(
    'i6-yz-3',
    'sm-zugriff',
    scenario:
        'In der Steuerkanzlei Albers & Partner gilt das Minimalprinzip. Die Lohnsachbearbeitung pflegt die Dateien im Ordner „Lohn“. Briefvorlagen im Ordner „Vorlagen“ werden von allen genutzt, aber nur von der Kanzleileitung geändert. Auszubildende arbeiten nicht an Lohnmandaten.',
    prompt: 'Ergänze die Berechtigungsmatrix.',
    zeilen: [
      ['Ordner', 'Lohnsachbearbeitung', 'Auszubildende'],
      [
        'Lohn',
        wahl('Lesen und Schreiben', [
          'nur Lesen',
          'kein Zugriff',
        ], 'Sie pflegt die Dateien.'),
        wahl('kein Zugriff', [
          'nur Lesen',
          'Lesen und Schreiben',
        ], 'Für die Aufgabe nicht nötig.'),
      ],
      [
        'Vorlagen',
        wahl('nur Lesen', [
          'Lesen und Schreiben',
          'kein Zugriff',
        ], 'Nutzen ja, ändern nein.'),
        wahl('nur Lesen', [
          'Lesen und Schreiben',
          'kein Zugriff',
        ], 'Nutzen ja, ändern nein.'),
      ],
    ],
    explanation:
        'Minimalprinzip: Jede Rolle erhält nur die Rechte, die sie für ihre Aufgaben braucht. Die Lohnsachbearbeitung schreibt im Ordner „Lohn“, Auszubildende haben dort keinen Zugriff. Vorlagen dürfen beide nur lesen, weil nur die Kanzleileitung sie ändert.',
    punkte: 4,
  ),
  mehrfach(
    'i6-yz-4',
    'sm-zugriff',
    scenario:
        'Der Hersteller eines Netzwerkspeichers (NAS) legt dem Gerät eine Kurzanleitung zur sicheren Einrichtung bei.',
    code:
        'SECURE SETUP - QUICK GUIDE\n\nBefore you connect the device to your network:\n- Replace the factory password with a strong, unique one.\n- Disable all services you do not need, e.g. FTP and Telnet.\n- Create a separate user account for daily work; use the\n  administrator account for configuration only.\n- Enable automatic security updates.\n- Turn on the audit log to record every login attempt.',
    prompt:
        'Welche Maßnahmen nennt die Anleitung? Wähle alle zutreffenden aus.',
    choices: [
      ja(
        'Das Werkspasswort durch ein starkes, einzigartiges Passwort ersetzen',
        '„Replace the factory password with a strong, unique one.“',
      ),
      ja(
        'Nicht benötigte Dienste wie FTP und Telnet abschalten',
        '„Disable all services you do not need“',
      ),
      ja(
        'Für die tägliche Arbeit ein eigenes Benutzerkonto anlegen',
        '„Create a separate user account for daily work“',
      ),
      ja(
        'Anmeldeversuche protokollieren lassen',
        '„Turn on the audit log to record every login attempt.“',
      ),
      nein(
        'Die Festplatten des Geräts verschlüsseln',
        'Sinnvoll, wird in der Anleitung aber nicht genannt.',
      ),
      nein('Das Gerät in eine DMZ stellen', 'Steht nicht im Text.'),
      nein(
        'Automatische Updates abschalten, damit der Betrieb nicht gestört wird',
        'Der Text verlangt das Gegenteil: „Enable automatic security updates.“',
      ),
    ],
    explanation:
        'Die Anleitung nennt fünf Maßnahmen: Werkspasswort ersetzen, unnötige Dienste abschalten, getrenntes Konto für die tägliche Arbeit, automatische Sicherheitsupdates einschalten und Anmeldeversuche protokollieren. Verschlüsselung und DMZ kommen im Text nicht vor.',
    punkte: 4,
    tags: ['englisch'],
  ),

  // ================================================ Symmetrische Verschlüsselung
  tabelle(
    'i6-cs-1',
    'kr-symmetrisch',
    scenario:
        'In einem Team soll jede Person mit jeder anderen vertraulich kommunizieren können. Verglichen wird die Zahl der nötigen Schlüssel: symmetrisch braucht jedes Paar einen eigenen Schlüssel, n × (n - 1) / 2; asymmetrisch hat jede Person ein Schlüsselpaar, 2 × n.',
    prompt: 'Berechne die Anzahl der Schlüssel und ergänze die Tabelle.',
    zeilen: [
      ['Personen', 'symmetrisch', 'asymmetrisch'],
      ['4', '6', '8'],
      [
        '10',
        zahl(45, rationale: '10 × 9 / 2 = 45'),
        zahl(20, rationale: '2 × 10 = 20'),
      ],
      [
        '20',
        zahl(190, rationale: '20 × 19 / 2 = 190'),
        zahl(40, rationale: '2 × 20 = 40'),
      ],
    ],
    explanation:
        'Symmetrisch: n × (n - 1) / 2, also 10 × 9 / 2 = 45 und 20 × 19 / 2 = 190. Asymmetrisch: 2 × n, also 20 und 40. Die Zahl der symmetrischen Schlüssel wächst quadratisch - ein Grund für asymmetrische und hybride Verfahren.',
    punkte: 4,
  ),
  lueckentext(
    'i6-cs-2',
    'kr-symmetrisch',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH verschlüsselt die Festplatten der neuen Notebooks mit AES-256.',
    prompt: 'Ergänze die Beschreibung des Verfahrens.',
    text:
        'AES ist ein {0} Verfahren: Zum Ver- und Entschlüsseln dient {1} Schlüssel. Es arbeitet sehr {2} und eignet sich deshalb für große Datenmengen. Die Angabe 256 nennt die {3} in Bit. Schwierig ist bei solchen Verfahren der sichere {4}, wenn zwei Parteien über ein unsicheres Netz kommunizieren.',
    luecken: [
      wahl('symmetrisches', ['asymmetrisches', 'hybrides']),
      wahl('derselbe', ['ein öffentlicher', 'ein Paar aus zwei']),
      wahl('schnell', ['langsam', 'verlustbehaftet']),
      wahl('Schlüssellänge', ['Blockanzahl', 'Länge des Hashwerts']),
      wahl('Schlüsselaustausch', ['Hashvergleich', 'Zertifikatswiderruf']),
    ],
    explanation:
        'Symmetrische Verfahren wie AES nutzen denselben Schlüssel zum Ver- und Entschlüsseln. Sie sind schnell und für große Datenmengen geeignet. Die Zahl hinter AES ist die Schlüssellänge. Das Kernproblem ist der sichere Austausch des gemeinsamen Schlüssels.',
    punkte: 5,
  ),
  freitext(
    'i6-cs-3',
    'kr-symmetrisch',
    scenario:
        'Die Pixelhafen Medien GmbH schickt einem Kunden ein mit AES verschlüsseltes ZIP-Archiv per E-Mail. Das Passwort steht in derselben E-Mail.',
    prompt:
        'Beschreibe das Problem dieses Vorgehens und nenne eine geeignete Lösung. (3 P.)',
    kriterien: [
      krit(
        'Problem: Beide Seiten brauchen denselben geheimen Schlüssel. Wer die E-Mail abfängt, erhält Geheimtext und Schlüssel zugleich und kann alles lesen',
        punkte: 2,
        stichwoerter: [
          'derselbe Schlüssel',
          'abfangen',
          'mitlesen',
          'Schlüsselaustausch',
          'gleicher Weg',
          'gleichen Kanal',
        ],
      ),
      krit(
        'Lösung: Schlüssel über einen zweiten Kanal übermitteln (Telefon, persönlich) oder asymmetrisch bzw. hybrid verschlüsseln',
        stichwoerter: [
          'zweiter Kanal',
          'Telefon',
          'persönlich',
          'asymmetrisch',
          'hybrid',
          'öffentlichen Schlüssel',
        ],
      ),
    ],
    loesung:
        'Bei symmetrischer Verschlüsselung brauchen Absender und Empfänger denselben geheimen Schlüssel. Steht das Passwort in derselben E-Mail wie das Archiv, bekommt ein Angreifer, der die E-Mail mitliest, beides - die Verschlüsselung ist wirkungslos. Lösung: das Passwort über einen anderen Kanal mitteilen (z. B. telefonisch) oder ein asymmetrisches bzw. hybrides Verfahren nutzen, bei dem kein geheimer Schlüssel übertragen werden muss.',
    explanation:
        '2 Punkte für das beschriebene Schlüsselaustauschproblem, 1 Punkt für eine geeignete Lösung.$_andere',
  ),
  rechnen(
    'i6-cs-4',
    'kr-symmetrisch',
    scenario:
        'Ein veraltetes Verfahren nutzt Schlüssel mit 40 Bit Länge. Ein Angreifer kann 2^30 Schlüssel (rund 1 Milliarde) je Sekunde durchprobieren.',
    prompt:
        'Berechne, nach wie vielen Sekunden der Angreifer spätestens alle möglichen Schlüssel getestet hat.',
    answer: 1024,
    unit: 's',
    explanation:
        'Anzahl der Schlüssel: 2^40. Dauer: 2^40 / 2^30 = 2^10 = 1.024 Sekunden, also rund 17 Minuten. Jedes zusätzliche Bit verdoppelt den Aufwand - deshalb gelten heute 128 Bit und mehr als sicher.',
    punkte: 3,
  ),

  // =============================================== Asymmetrische Verschlüsselung
  reihenfolge(
    'i6-ca-1',
    'kr-asymmetrisch',
    scenario:
        'Die Steuerkanzlei Albers & Partner will einem Mandanten einen Steuerbescheid vertraulich per E-Mail schicken. Eingesetzt wird ein Public-Key-Verfahren.',
    skizze: SequenzDiagramm(
      ['Kanzlei', 'Mandant'],
      [
        Nachricht(1, 0, 'öffentlicher Schlüssel'),
        Nachricht(0, 1, 'verschlüsselte Nachricht'),
      ],
    ),
    prompt:
        'Bringe die Schritte der asymmetrischen Verschlüsselung in die richtige Reihenfolge.',
    items: [
      'Der Mandant erzeugt ein Schlüsselpaar',
      'Der Mandant stellt der Kanzlei seinen öffentlichen Schlüssel bereit',
      'Die Kanzlei verschlüsselt den Bescheid mit dem öffentlichen Schlüssel des Mandanten',
      'Die Kanzlei überträgt den Geheimtext',
      'Der Mandant entschlüsselt mit seinem privaten Schlüssel',
    ],
    explanation:
        'Verschlüsselt wird immer mit dem öffentlichen Schlüssel des Empfängers. Nur der Empfänger besitzt den passenden privaten Schlüssel und kann den Geheimtext lesen - nicht einmal die Kanzlei selbst kann ihn wieder entschlüsseln.',
    punkte: 4,
  ),
  lueckentext(
    'i6-ca-2',
    'kr-asymmetrisch',
    scenario:
        'Frau Albers (Senderin) schickt Herrn Yilmaz (Empfänger) eine vertrauliche Nachricht. Beide besitzen je einen privaten und einen öffentlichen Schlüssel.',
    skizze: SequenzDiagramm(
      ['Albers', 'Yilmaz'],
      [
        Nachricht(1, 0, 'öffentlicher Schlüssel'),
        Nachricht(0, 1, 'verschlüsselte Nachricht'),
      ],
    ),
    prompt:
        'Wähle für jeden Schritt den richtigen Schlüssel bzw. das erreichte Schutzziel.',
    text:
        'Frau Albers verschlüsselt die Nachricht mit dem Schlüssel {0}. Herr Yilmaz entschlüsselt sie mit dem Schlüssel {1}. Geheim bleiben muss dabei nur der Schlüssel {2}. Erreicht wird das Schutzziel {3}.',
    luecken: [
      _key(
        _oeE,
        'Verschlüsselt wird mit dem öffentlichen Schlüssel des Empfängers.',
      ),
      _key(_prE, 'Nur der Empfänger besitzt den passenden privaten Schlüssel.'),
      _key(_prE, 'Der öffentliche Schlüssel darf jedem bekannt sein.'),
      wahl('Vertraulichkeit', [
        'Integrität',
        'Verfügbarkeit',
        'Verbindlichkeit',
      ]),
    ],
    explanation:
        'Verschlüsseln: öffentlicher Schlüssel des Empfängers. Entschlüsseln: privater Schlüssel des Empfängers. Die Schlüssel der Senderin spielen hier keine Rolle - sie kämen erst bei einer Signatur ins Spiel. Schutzziel ist die Vertraulichkeit.',
    punkte: 4,
  ),
  reihenfolge(
    'i6-ca-3',
    'kr-asymmetrisch',
    scenario:
        'Der Einkauf der Grünwerk Gartenbedarf GmbH schickt Bestellungen digital signiert an einen Lieferanten. Der Lieferant will sicher sein, dass die Bestellung echt und unverändert ist.',
    skizze: SequenzDiagramm(
      ['Einkauf', 'Lieferant'],
      [
        Nachricht(0, 1, 'Zertifikat (öff. Schlüssel)'),
        Nachricht(0, 1, 'Bestellung + Signatur'),
      ],
    ),
    prompt:
        'Bringe die Schritte beim Erstellen und Prüfen der digitalen Signatur in die richtige Reihenfolge.',
    items: [
      'Der Einkauf bildet den Hashwert der Bestellung',
      'Der Einkauf verschlüsselt den Hashwert mit seinem privaten Schlüssel - das ist die Signatur',
      'Der Einkauf sendet Bestellung und Signatur',
      'Der Lieferant entschlüsselt die Signatur mit dem öffentlichen Schlüssel des Einkaufs',
      'Der Lieferant vergleicht das Ergebnis mit dem Hashwert, den er selbst aus der Bestellung berechnet',
    ],
    explanation:
        'Signiert wird mit dem privaten Schlüssel des Absenders, geprüft mit dessen öffentlichem Schlüssel. Stimmen beide Hashwerte überein, ist die Bestellung unverändert (Integrität) und stammt vom Inhaber des privaten Schlüssels (Authentizität).',
    punkte: 4,
  ),
  tabelle(
    'i6-ca-4',
    'kr-asymmetrisch',
    scenario:
        'In der Prüfung wird das Public-Key-Verfahren in zwei Varianten gefragt: verschlüsseln und signieren. Die Verwechslung der Schlüssel ist der häufigste Fehler.',
    prompt:
        'Ergänze, welchen Schlüssel der Sender und welchen der Empfänger jeweils benutzt.',
    zeilen: [
      ['Vorgang', 'Sender nutzt', 'Empfänger nutzt'],
      [
        'Nachricht verschlüsseln',
        _key(_oeE, 'Nur der Empfänger soll lesen können.'),
        _key(_prE, 'Nur er besitzt ihn.'),
      ],
      [
        'Nachricht signieren',
        _key(_prS, 'Nur der Sender kann so signieren.'),
        _key(_oeS, 'Jeder kann die Signatur prüfen.'),
      ],
    ],
    explanation:
        'Verschlüsseln: Schlüsselpaar des Empfängers (öffentlich zum Verschlüsseln, privat zum Entschlüsseln). Signieren: Schlüsselpaar des Senders (privat zum Signieren, öffentlich zum Prüfen). Ein privater Schlüssel wird nie weitergegeben.',
    punkte: 4,
  ),
  freitext(
    'i6-ca-5',
    'kr-asymmetrisch',
    scenario:
        'Ein Lieferant erhält von der Elbtal Logistik AG einen digital signierten, aber nicht verschlüsselten Frachtauftrag.',
    skizze: SequenzDiagramm(
      ['Elbtal', 'Lieferant'],
      [
        Nachricht(0, 1, 'Zertifikat (öff. Schlüssel)'),
        Nachricht(0, 1, 'Auftrag + Signatur'),
      ],
    ),
    prompt:
        'Beschreibe anhand der Skizze, wie die digitale Signatur erstellt und wie sie geprüft wird. (4 P.)',
    kriterien: [
      krit(
        'Erstellen: Aus dem Auftrag wird ein Hashwert gebildet und mit dem privaten Schlüssel des Absenders verschlüsselt; Auftrag und Signatur werden gesendet',
        punkte: 2,
        stichwoerter: [
          'privaten Schlüssel',
          'privater Schlüssel',
          'private Schlüssel',
          'private key',
        ],
      ),
      krit(
        'Prüfen: Der Empfänger entschlüsselt die Signatur mit dem öffentlichen Schlüssel des Absenders, berechnet den Hashwert selbst und vergleicht beide Werte',
        punkte: 2,
        stichwoerter: [
          'öffentlichen Schlüssel',
          'öffentlicher Schlüssel',
          'öffentliche Schlüssel',
          'public key',
        ],
      ),
    ],
    loesung:
        'Elbtal bildet den Hashwert des Auftrags und verschlüsselt ihn mit dem eigenen privaten Schlüssel - das Ergebnis ist die Signatur. Auftrag und Signatur gehen an den Lieferanten. Dieser entschlüsselt die Signatur mit dem öffentlichen Schlüssel von Elbtal und erhält den ursprünglichen Hashwert. Er berechnet den Hashwert des erhaltenen Auftrags selbst und vergleicht: Stimmen beide überein, ist der Auftrag unverändert und stammt von Elbtal.',
    explanation:
        '2 Punkte für das Erstellen (privater Schlüssel des Absenders), 2 Punkte für das Prüfen (öffentlicher Schlüssel des Absenders). Auch die Kurzfassung „mit dem privaten Schlüssel signieren, mit dem öffentlichen prüfen“ reicht - entscheidend ist, wessen Schlüssel es sind.',
  ),
  markieren(
    'i6-ca-6',
    'kr-asymmetrisch',
    scenario:
        'Ein Auszubildender hat für die Berufsschule aufgeschrieben, wie Anna und Ben mit einem Public-Key-Verfahren arbeiten. Einige Sätze enthalten Fehler.',
    prompt: 'Markiere alle fehlerhaften Aussagen.',
    zeilen: [
      nein(
        'Anna verschlüsselt die Nachricht an Ben mit Bens öffentlichem Schlüssel.',
        'Richtig: öffentlicher Schlüssel des Empfängers.',
      ),
      ja(
        'Ben entschlüsselt die Nachricht mit Annas öffentlichem Schlüssel.',
        'Falsch: Ben braucht seinen eigenen privaten Schlüssel.',
      ),
      nein(
        'Anna signiert den Vertrag mit ihrem privaten Schlüssel.',
        'Richtig: Signiert wird mit dem privaten Schlüssel des Absenders.',
      ),
      ja(
        'Ben prüft Annas Signatur mit seinem eigenen privaten Schlüssel.',
        'Falsch: Geprüft wird mit Annas öffentlichem Schlüssel.',
      ),
      ja(
        'Damit jeder ihre Signatur prüfen kann, veröffentlicht Anna ihren privaten Schlüssel.',
        'Falsch: Der private Schlüssel bleibt immer geheim - veröffentlicht wird der öffentliche.',
      ),
      nein(
        'Ben entnimmt Annas öffentlichen Schlüssel ihrem Zertifikat.',
        'Richtig: Das Zertifikat bindet den öffentlichen Schlüssel an die Person.',
      ),
    ],
    explanation:
        'Merkregel: Verschlüsselt wird für den Empfänger (sein öffentlicher Schlüssel), entschlüsselt mit dessen privatem. Signiert wird mit dem privaten Schlüssel des Absenders, geprüft mit dessen öffentlichem. Private Schlüssel verlassen ihren Besitzer nie.',
    punkte: 3,
  ),

  // ========================================================== Hybride Verfahren
  lueckentext(
    'i6-ch-1',
    'kr-hybrid',
    scenario:
        'Die Pixelhafen Medien GmbH schickt einem Kunden große Entwurfsdateien hybrid verschlüsselt.',
    skizze: SequenzDiagramm(
      ['Agentur', 'Kunde'],
      [
        Nachricht(1, 0, 'öffentlicher Schlüssel'),
        Nachricht(0, 1, 'Sitzungsschlüssel (verschl.)'),
        Nachricht(0, 1, 'Datei (verschlüsselt)'),
      ],
    ),
    prompt: 'Ergänze die Beschreibung des hybriden Verfahrens.',
    text:
        'Die Agentur erzeugt einen zufälligen {0} und verschlüsselt damit die Datei {1}, zum Beispiel mit AES. Den Sitzungsschlüssel selbst verschlüsselt sie {2} mit dem Schlüssel {3}. Der Kunde entschlüsselt zuerst den Sitzungsschlüssel mit dem Schlüssel {4} und damit anschließend die Datei.',
    luecken: [
      wahl('Sitzungsschlüssel', ['Hashwert', 'privaten Schlüssel']),
      wahl('symmetrisch', ['asymmetrisch', 'gar nicht']),
      wahl('asymmetrisch', ['symmetrisch', 'mit einem Hashverfahren']),
      _key(_oeE, 'Der Kunde ist der Empfänger.'),
      _key(_prE),
    ],
    explanation:
        'Hybrid heißt: Die Nutzdaten werden schnell symmetrisch mit einem zufälligen Sitzungsschlüssel verschlüsselt. Nur dieser kurze Schlüssel wird asymmetrisch mit dem öffentlichen Schlüssel des Empfängers geschützt. So verbindet das Verfahren Geschwindigkeit mit einfachem Schlüsselaustausch.',
    punkte: 5,
  ),
  freitext(
    'i6-ch-2',
    'kr-hybrid',
    scenario:
        'Beim Aufruf des Webshops der Grünwerk Gartenbedarf GmbH über HTTPS kommen ein asymmetrisches und ein symmetrisches Verfahren zum Einsatz.',
    prompt:
        'Erläutere, warum hybride Verfahren beide Verschlüsselungsarten kombinieren. (4 P.)',
    kriterien: [
      krit(
        'Symmetrische Verfahren sind schnell und eignen sich für große Datenmengen, haben aber das Problem des Schlüsselaustauschs',
        punkte: 2,
        stichwoerter: [
          'schnell',
          'große Datenmengen',
          'Schlüsselaustausch',
          'performant',
          'Rechenaufwand',
        ],
      ),
      krit(
        'Asymmetrische Verfahren lösen den Schlüsselaustausch, sind aber langsam - sie schützen deshalb nur den kurzen Sitzungsschlüssel',
        punkte: 2,
        stichwoerter: [
          'langsam',
          'Sitzungsschlüssel',
          'Session Key',
          'rechenaufwendig',
          'kein geheimer Austausch',
        ],
      ),
    ],
    loesung:
        'Symmetrische Verfahren wie AES sind schnell und für große Datenmengen geeignet, beide Seiten brauchen aber denselben geheimen Schlüssel. Asymmetrische Verfahren brauchen keinen geheimen Schlüsselaustausch, sind aber rechenaufwendig und langsam. Hybride Verfahren nutzen deshalb das asymmetrische Verfahren nur, um einen Sitzungsschlüssel sicher zu vereinbaren, und verschlüsseln die eigentlichen Daten symmetrisch.',
    explanation:
        'Je 2 Punkte für die Rolle des symmetrischen Verfahrens (Tempo) und des asymmetrischen Verfahrens (Schlüsselaustausch).$_andere',
  ),
  markieren(
    'i6-ch-3',
    'kr-hybrid',
    mono: true,
    scenario:
        'Am 01.10.2026 ruft ein Mandant das Portal https://portal.albers-partner.example auf. Der Browser zeigt eine Zertifikatswarnung. Du siehst dir die Zertifikatsdaten an.',
    prompt: 'Markiere die Angaben, die die Warnung auslösen.',
    zeilen: [
      nein(
        'Ausgestellt für: portal.albers-partner.example',
        'Der Name passt zur aufgerufenen Adresse.',
      ),
      ja(
        'Aussteller:      selbst signiert',
        'Keine vertrauenswürdige Zertifizierungsstelle bürgt für den Inhaber.',
      ),
      nein(
        'Gültig ab:       01.08.2025',
        'Der Beginn liegt in der Vergangenheit.',
      ),
      ja(
        'Gültig bis:      31.08.2026',
        'Das Zertifikat ist seit einem Monat abgelaufen.',
      ),
      nein(
        'Schlüssel:       RSA 3072 Bit',
        'Eine ausreichende Schlüssellänge.',
      ),
      nein(
        'Signatur:        SHA-256 mit RSA',
        'Ein aktuelles Signaturverfahren.',
      ),
    ],
    explanation:
        'Der Browser prüft drei Dinge: Passt der Name zur Adresse? Ist das Zertifikat gültig (Zeitraum, nicht gesperrt)? Führt die Kette zu einer vertrauenswürdigen Zertifizierungsstelle? Hier ist das Zertifikat abgelaufen und selbst signiert.',
    punkte: 2,
  ),
  tabelle(
    'i6-ch-4',
    'kr-hybrid',
    prompt: 'Ergänze den Vergleich der beiden Verschlüsselungsarten.',
    zeilen: [
      ['Merkmal', 'symmetrisch', 'asymmetrisch'],
      [
        'Schlüssel',
        wahl('ein gemeinsamer', ['ein Schlüsselpaar', 'keiner']),
        wahl('ein Schlüsselpaar', ['ein gemeinsamer', 'keiner']),
      ],
      [
        'Geschwindigkeit',
        wahl('hoch', ['gering', 'nicht messbar']),
        wahl('gering', ['hoch', 'nicht messbar']),
      ],
      [
        'Beispiel',
        wahl('AES', ['RSA', 'SHA-256']),
        wahl('RSA', ['AES', 'SHA-256']),
      ],
    ],
    explanation:
        'Symmetrisch: ein gemeinsamer geheimer Schlüssel, schnell, Beispiel AES. Asymmetrisch: Schlüsselpaar aus privatem und öffentlichem Schlüssel, deutlich langsamer, Beispiel RSA. SHA-256 ist ein Hashverfahren und verschlüsselt nicht.',
    punkte: 6,
  ),

  // =============================================================== Hashverfahren
  freitext(
    'i6-cx-1',
    'kr-hash',
    scenario:
        'Für die Access Points der Steuerkanzlei lädst du eine neue Firmware von der Website des Herstellers. Neben dem Download steht ein Hashwert.',
    table: [
      ['Datei', 'SHA-256'],
      ['ap-firmware-4.2.bin', '7c1e09ab…52d4f0e3'],
    ],
    prompt:
        'Erläutere den Zweck des angegebenen Hashwerts und wie du ihn verwendest. (4 P.)',
    kriterien: [
      krit(
        'Zweck: Integrität prüfen - die Datei ist vollständig und wurde weder beim Übertragen beschädigt noch manipuliert',
        punkte: 2,
        stichwoerter: [
          'Integrität',
          'unverändert',
          'manipuliert',
          'vollständig',
          'beschädigt',
        ],
      ),
      krit(
        'Vorgehen: Hashwert der geladenen Datei selbst berechnen und mit dem veröffentlichten vergleichen; bei Abweichung nicht installieren',
        punkte: 2,
        stichwoerter: [
          'vergleichen',
          'selbst berechnen',
          'berechnen',
          'Abweichung',
          'nicht installieren',
        ],
      ),
    ],
    loesung:
        'Mit dem Hashwert lässt sich die Integrität der Datei prüfen. Nach dem Download berechne ich den SHA-256-Wert der Datei selbst und vergleiche ihn mit dem veröffentlichten. Sind beide gleich, ist die Datei vollständig und unverändert. Weichen sie ab, wurde die Datei beschädigt oder manipuliert und darf nicht installiert werden.',
    explanation:
        '2 Punkte für den Zweck (Integrität), 2 Punkte für das Vorgehen (berechnen, vergleichen, Folge bei Abweichung). Ein Hashwert verschlüsselt nichts und sagt allein nichts über den Absender aus.',
  ),
  lueckentext(
    'i6-cx-2',
    'kr-hash',
    prompt: 'Ergänze die Eigenschaften einer kryptographischen Hashfunktion.',
    text:
        'Eine Hashfunktion bildet Eingaben beliebiger Länge auf einen Wert {0} Länge ab. Sie ist eine {1}: Aus dem Hashwert lässt sich die Eingabe nicht zurückrechnen. Ändert sich nur ein Bit der Eingabe, ändert sich der Hashwert {2}. Haben zwei verschiedene Eingaben denselben Hashwert, spricht man von einer {3}. SHA-256 liefert {4} Bit, das sind {5} Hexadezimalzeichen.',
    luecken: [
      wahl('fester', ['gleicher wie die Eingabe', 'zufälliger']),
      wahl('Einwegfunktion', ['Verschlüsselung', 'Kodierung']),
      wahl('völlig', ['gar nicht', 'nur an einer Stelle']),
      wort(['Kollision'], 'Kollisionen dürfen praktisch nicht zu finden sein.'),
      zahl(256),
      zahl(64, rationale: '256 Bit / 4 Bit je Hexzeichen'),
    ],
    explanation:
        'Feste Ausgabelänge, Einwegfunktion, Lawineneffekt und Kollisionsresistenz sind die Kerneigenschaften. SHA-256: 256 Bit, je Hexzeichen 4 Bit, also 256 / 4 = 64 Zeichen.',
    punkte: 6,
  ),
  markieren(
    'i6-cx-3',
    'kr-hash',
    mono: true,
    scenario:
        'Vor der Installation vergleichst du die veröffentlichten Hashwerte (soll) mit den selbst berechneten (ist). Zur Übersicht sind nur die ersten acht Stellen angegeben.',
    prompt: 'Markiere die Dateien, die nicht installiert werden dürfen.',
    zeilen: [
      nein(
        'treiber.zip   soll 3fa94c1e  ist 3fa94c1e',
        'Beide Werte sind gleich.',
      ),
      ja(
        'firmware.bin  soll b71d02aa  ist b71d02ab',
        'Die letzte Stelle weicht ab - die Datei ist verändert oder beschädigt.',
      ),
      nein(
        'setup.exe     soll 09c5e7d3  ist 09c5e7d3',
        'Beide Werte sind gleich.',
      ),
      ja(
        'update.msi    soll e4a81f60  ist e4a18f60',
        'Zwei Stellen sind vertauscht - die Werte stimmen nicht überein.',
      ),
      nein(
        'tools.tar     soll 5d20bb97  ist 5d20bb97',
        'Beide Werte sind gleich.',
      ),
    ],
    explanation:
        'Schon eine einzige abweichende Stelle bedeutet: Die Datei ist nicht die veröffentlichte. Sie kann beim Download beschädigt oder absichtlich manipuliert worden sein - in beiden Fällen wird sie nicht installiert, sondern neu aus der Originalquelle geladen.',
    punkte: 2,
  ),
  zuordnen(
    'i6-cx-4',
    'kr-hash',
    scenario:
        'Bei einer Überprüfung der eingesetzten Verfahren ordnest du Hashfunktionen nach ihrem Einsatzzweck.',
    prompt: 'Ordne jedes Verfahren richtig ein.',
    buckets: [
      'veraltet, nicht mehr verwenden',
      'aktuell für Integritätsprüfung',
      'zum Speichern von Passwörtern',
    ],
    items: [
      zu('SHA-256', 1, 'Aus der SHA-2-Familie, gilt als sicher.'),
      zu('MD5', 0, 'Kollisionen lassen sich in Sekunden erzeugen.'),
      zu('bcrypt', 2, 'Absichtlich langsam, mit eingebautem Salt.'),
      zu('SHA-1', 0, 'Praktische Kollisionen sind nachgewiesen.'),
      zu('Argon2', 2, 'Speicher- und rechenintensiv - bremst Brute Force.'),
      zu('SHA-3', 1, 'Aktueller Standard neben SHA-2.'),
    ],
    explanation:
        'MD5 und SHA-1 gelten als gebrochen. SHA-256 und SHA-3 sind aktuell und schnell - gut für die Integritätsprüfung, aber zu schnell für Passwörter. Für Passwörter nimmt man absichtlich langsame Verfahren mit Salt wie bcrypt oder Argon2.',
    punkte: 3,
  ),
  freitext(
    'i6-cx-5',
    'kr-hash',
    scenario:
        'Bei der Prüfung einer älteren Webanwendung der Pixelhafen Medien GmbH stellst du fest, dass die Passwörter der Kunden im Klartext in der Datenbank stehen.',
    prompt:
        'Beschreibe zwei Maßnahmen, mit denen Passwörter sicher gespeichert werden. (4 P.)',
    kriterien: [
      krit(
        'Nur den Hashwert des Passworts speichern; bei der Anmeldung wird die Eingabe gehasht und verglichen',
        punkte: 2,
        stichwoerter: [
          'Hashwert',
          'hashen',
          'gehasht',
          'Hash',
          'Einwegfunktion',
        ],
      ),
      krit(
        'Je Passwort einen zufälligen Salt verwenden: gleiche Passwörter ergeben verschiedene Hashwerte, Rainbow-Tables werden nutzlos',
        punkte: 2,
        stichwoerter: ['Salt', 'Rainbow', 'Zufallswert', 'gesalzen'],
      ),
      krit(
        'Ein absichtlich langsames Passwort-Hashverfahren wie bcrypt oder Argon2 einsetzen, um Brute Force zu bremsen',
        punkte: 2,
        stichwoerter: ['bcrypt', 'Argon2', 'langsam', 'PBKDF2', 'Brute Force'],
      ),
    ],
    punkte: 4,
    loesung:
        'Statt des Passworts wird nur sein Hashwert gespeichert; bei der Anmeldung wird die Eingabe gehasht und mit dem gespeicherten Wert verglichen. Zusätzlich erhält jedes Passwort einen eigenen zufälligen Salt, damit gleiche Passwörter unterschiedliche Hashwerte ergeben und vorberechnete Tabellen nicht helfen. Geeignet sind absichtlich langsame Verfahren wie bcrypt oder Argon2.',
    explanation:
        'Je Maßnahme 2 Punkte, höchstens 4 Punkte. Wird die Datenbank gestohlen, liegen so keine Passwörter im Klartext vor.$_andere',
  ),

  // ============================================================ Authentifizierung
  tabelle(
    'i6-cz-1',
    'kr-auth',
    scenario:
        'Für die Anmeldung an den Kassen der neuen Filiale vergleicht die Grünwerk Gartenbedarf GmbH drei Arten von Authentifizierungsfaktoren.',
    prompt: 'Ergänze zu jedem Faktor ein Beispiel und ein typisches Risiko.',
    zeilen: [
      ['Faktor', 'Beispiel', 'Risiko'],
      [
        'Wissen',
        wahl('Passwort oder PIN', ['Chipkarte', 'Fingerabdruck']),
        wahl('kann erraten oder ausgespäht werden', [
          'kann verloren gehen oder gestohlen werden',
          'lässt sich nach Missbrauch nicht ändern',
        ]),
      ],
      [
        'Besitz',
        wahl('Chipkarte', ['Passwort oder PIN', 'Fingerabdruck']),
        wahl('kann verloren gehen oder gestohlen werden', [
          'kann erraten oder ausgespäht werden',
          'lässt sich nach Missbrauch nicht ändern',
        ]),
      ],
      [
        'Biometrie',
        wahl('Fingerabdruck', ['Passwort oder PIN', 'Chipkarte']),
        wahl('lässt sich nach Missbrauch nicht ändern', [
          'kann erraten oder ausgespäht werden',
          'kann verloren gehen oder gestohlen werden',
        ]),
      ],
    ],
    explanation:
        'Wissen (Passwort, PIN): kann erraten, ausgespäht oder weitergegeben werden. Besitz (Chipkarte, Token): kann verloren gehen oder gestohlen werden. Biometrie (Fingerabdruck): kann nicht vergessen werden, lässt sich aber nicht ändern, wenn das Merkmal einmal kopiert wurde.',
    punkte: 6,
  ),
  tabelle(
    'i6-cz-2',
    'kr-auth',
    scenario:
        'Die Elbtal Logistik AG überlegt, wie die Anmeldung an den Handscannern aussehen soll. Verglichen wird, wie viele Kombinationen ein Angreifer höchstens durchprobieren müsste.',
    prompt:
        'Berechne die Anzahl der möglichen Kombinationen und ergänze die Tabelle. Gib die Zahlen ohne Tausenderpunkt ein.',
    zeilen: [
      ['Regel', 'Rechnung', 'Kombinationen'],
      ['PIN, 4 Ziffern', '10^4', '10.000'],
      ['PIN, 6 Ziffern', '10^6', zahl(1000000)],
      ['4 Kleinbuchstaben (a-z)', '26^4', zahl(456976)],
      ['5 Kleinbuchstaben (a-z)', '26^5', zahl(11881376)],
    ],
    explanation:
        'Anzahl = Zeichenvorrat hoch Länge. 10^6 = 1.000.000. 26^4 = 26 × 26 × 26 × 26 = 456.976. 26^5 = 456.976 × 26 = 11.881.376. Ein Zeichen mehr vervielfacht die Zahl um den ganzen Zeichenvorrat - Länge wirkt stärker als ein etwas größerer Zeichensatz.',
    punkte: 3,
  ),
  freitext(
    'i6-cz-3',
    'kr-auth',
    scenario:
        'Die 20 Beschäftigten der Grünwerk Gartenbedarf GmbH, die mobil arbeiten, melden sich am VPN bisher nur mit Benutzername und Passwort an. Die IT-Abteilung will eine Zwei-Faktor-Authentifizierung einführen.',
    prompt:
        'Erläutere, warum eine Zwei-Faktor-Authentifizierung besser schützt als ein Passwort allein. (4 P.)',
    kriterien: [
      krit(
        'Es werden zwei Nachweise aus verschiedenen Kategorien verlangt (Wissen, Besitz, Biometrie)',
        punkte: 2,
        stichwoerter: [
          'verschiedene Kategorien',
          'zwei Faktoren',
          'Wissen und Besitz',
          'unterschiedliche Faktoren',
        ],
      ),
      krit(
        'Ein ausgespähtes oder erratenes Passwort reicht allein nicht - der Angreifer bräuchte zusätzlich den zweiten Faktor, z. B. das Smartphone',
        punkte: 2,
        stichwoerter: [
          'reicht nicht',
          'zusätzlich',
          'Phishing',
          'gestohlenes Passwort',
          'Smartphone',
          'Token',
        ],
      ),
    ],
    loesung:
        'Bei der Zwei-Faktor-Authentifizierung müssen zwei Nachweise aus verschiedenen Kategorien erbracht werden, zum Beispiel das Passwort (Wissen) und ein Einmalcode aus einer App auf dem Smartphone (Besitz). Wird das Passwort durch Phishing oder ein Datenleck bekannt, kann sich der Angreifer trotzdem nicht anmelden, weil ihm der zweite Faktor fehlt.',
    explanation:
        '2 Punkte für das Prinzip (zwei verschiedene Faktorkategorien), 2 Punkte für die Folge (ein gestohlenes Passwort genügt nicht mehr).$_andere',
  ),
  mehrfach(
    'i6-cz-4',
    'kr-auth',
    scenario:
        'Die Pixelhafen Medien GmbH arbeitet für einen internationalen Kunden und muss dessen Passwortrichtlinie einhalten.',
    code:
        'PASSWORD POLICY (excerpt)\n\nPasswords must be at least 14 characters long. A password\nmust not be reused for any other service. Passwords are\nonly changed if there is a suspicion that they have been\ncompromised. All employees have to store their passwords\nin the password manager provided by the company. Access\nfrom outside the office additionally requires a one-time\ncode from the authenticator app.',
    prompt:
        'Welche Vorgaben macht die Richtlinie? Wähle alle zutreffenden aus.',
    choices: [
      ja('Mindestens 14 Zeichen Länge', '„at least 14 characters long“'),
      ja(
        'Ein Passwort darf für keinen anderen Dienst wiederverwendet werden',
        '„must not be reused for any other service“',
      ),
      ja(
        'Passwörter werden im bereitgestellten Passwortmanager gespeichert',
        '„store their passwords in the password manager provided by the company“',
      ),
      ja(
        'Beim Zugriff von außerhalb ist zusätzlich ein Einmalcode aus der App nötig',
        '„additionally requires a one-time code from the authenticator app“',
      ),
      nein(
        'Passwörter müssen alle 90 Tage gewechselt werden',
        'Im Gegenteil: Gewechselt wird nur bei Verdacht auf Kompromittierung.',
      ),
      nein(
        'Jedes Passwort muss ein Sonderzeichen enthalten',
        'Zur Zusammensetzung sagt der Text nichts.',
      ),
      nein(
        'Nach drei Fehlversuchen wird das Konto gesperrt',
        'Eine Kontosperre wird im Text nicht erwähnt.',
      ),
    ],
    explanation:
        'Der Text verlangt: mindestens 14 Zeichen, keine Wiederverwendung, Wechsel nur bei Verdacht, Passwortmanager des Unternehmens und von außen zusätzlich einen Einmalcode. Ein regelmäßiger Wechsel, Sonderzeichen und Kontosperren stehen nicht im Text.',
    punkte: 4,
    tags: ['englisch'],
  ),
  lueckentext(
    'i6-cz-5',
    'kr-auth',
    scenario:
        'Die Anmeldung am VPN-Portal wird um einen Einmalcode aus einer Authenticator-App (TOTP) ergänzt.',
    skizze: SequenzDiagramm(
      ['Nutzer', 'Portal', 'App'],
      [
        Nachricht(0, 1, 'Benutzername + Passwort'),
        Nachricht(1, 0, 'Code anfordern', antwort: true),
        Nachricht(2, 0, 'Einmalcode'),
        Nachricht(0, 1, 'Einmalcode'),
        Nachricht(1, 0, 'Zugang', antwort: true),
      ],
    ),
    prompt: 'Ergänze die Beschreibung des Verfahrens.',
    text:
        'Bei der Einrichtung tauschen Portal und App per QR-Code ein gemeinsames {0} aus. Daraus und aus der aktuellen {1} berechnen beide denselben Code, der nur etwa {2} Sekunden gilt. Das Passwort gehört zur Faktorkategorie {3}, das Smartphone mit der App zur Kategorie {4}.',
    luecken: [
      wahl('Geheimnis', ['Zertifikat', 'Passwort des Nutzers']),
      wahl('Uhrzeit', ['IP-Adresse', 'Passwortlänge']),
      zahl(30),
      wahl('Wissen', ['Besitz', 'Biometrie']),
      wahl('Besitz', ['Wissen', 'Biometrie']),
    ],
    explanation:
        'TOTP = Time-based One-Time Password: App und Server berechnen aus dem gemeinsamen Geheimnis und der Uhrzeit denselben Code, der meist 30 Sekunden gilt. Passwort = Wissen, Smartphone mit App = Besitz - zusammen eine echte Zwei-Faktor-Authentifizierung.',
    punkte: 5,
  ),
  markieren(
    'i6-cz-6',
    'kr-auth',
    mono: true,
    scenario:
        'Passwortrichtlinie der Kanzlei Albers & Partner: mindestens 12 Zeichen; der Name der Kanzlei oder der eigene Benutzername darf nicht vorkommen; keine reinen Zahlen- oder Tastaturfolgen. Frau Albers (Benutzername m.albers) schlägt fünf Passwörter vor.',
    prompt: 'Markiere alle Vorschläge, die gegen die Richtlinie verstoßen.',
    zeilen: [
      ja('Sommer2026!', 'Nur 11 Zeichen - zu kurz.'),
      ja('Albers&Partner2026', 'Enthält den Namen der Kanzlei.'),
      nein(
        'Kaffee-Regal-Wolke-Fahrrad',
        '26 Zeichen, vier zufällige Wörter, kein Bezug zu Kanzlei oder Konto.',
      ),
      ja('123456789012', 'Reine Zahlenfolge.'),
      nein('Vq7#mLp2xRt9wZ', '14 zufällige Zeichen - erfüllt alle Regeln.'),
    ],
    explanation:
        'Geprüft wird jede Regel einzeln: Länge (mindestens 12), kein Kanzlei- oder Benutzername, keine reine Zahlen- oder Tastaturfolge. Eine lange Passphrase aus zufälligen Wörtern ist ebenso zulässig wie eine zufällige Zeichenfolge.',
    punkte: 3,
  ),

  // ======================================================= Personenbezogene Daten
  markieren(
    'i6-xg-1',
    'ds-grundlagen',
    scenario:
        'Die Personalabteilung der Elbtal Logistik AG führt zu jeder beschäftigten Person eine digitale Personalakte. Für besondere Kategorien personenbezogener Daten (Art. 9 DSGVO) sollen strengere Zugriffsregeln gelten.',
    prompt:
        'Markiere alle Einträge, die zu den besonderen Kategorien personenbezogener Daten gehören.',
    zeilen: [
      nein(
        'Privatanschrift',
        'Personenbezogen, aber keine besondere Kategorie.',
      ),
      ja(
        'Religionszugehörigkeit (für die Kirchensteuer)',
        'Religiöse Überzeugung nennt Art. 9 ausdrücklich.',
      ),
      nein(
        'Bankverbindung (IBAN)',
        'Schützenswert, aber nicht in Art. 9 genannt.',
      ),
      ja(
        'Ärztliches Attest mit Diagnose',
        'Gesundheitsdaten gehören zu den besonderen Kategorien.',
      ),
      ja(
        'Mitgliedschaft in einer Gewerkschaft',
        'Gewerkschaftszugehörigkeit nennt Art. 9 ausdrücklich.',
      ),
      nein('Geburtsdatum', 'Ein gewöhnliches personenbezogenes Datum.'),
      ja(
        'Fingerabdruck für die Zutrittskontrolle',
        'Biometrische Daten zur eindeutigen Identifizierung fallen unter Art. 9.',
      ),
      nein('Steuerklasse', 'Personenbezogen, aber keine besondere Kategorie.'),
    ],
    explanation:
        'Besondere Kategorien nach Art. 9 DSGVO sind unter anderem Gesundheitsdaten, religiöse Überzeugung, Gewerkschaftszugehörigkeit, politische Meinung, ethnische Herkunft, genetische Daten und biometrische Daten zur eindeutigen Identifizierung. Anschrift, Bankverbindung, Geburtsdatum und Steuerklasse sind „gewöhnliche“ personenbezogene Daten.',
    punkte: 4,
  ),
  freitext(
    'i6-xg-2',
    'ds-grundlagen',
    scenario:
        'Die Kessler & Brandt IT-Systemhaus GmbH wartet die Server der Steuerkanzlei Albers & Partner. Dabei können Techniker Mandantendaten einsehen. Die Kanzlei verlangt deshalb besonders strenge Schutzmaßnahmen.',
    prompt:
        'Nenne zwei rechtliche Grundlagen, aus denen sich die erhöhten Anforderungen an den Schutz der Mandantendaten ergeben. (2 P.)',
    kriterien: [
      krit(
        'Datenschutz-Grundverordnung (DSGVO)',
        stichwoerter: [
          'DSGVO',
          'Datenschutz-Grundverordnung',
          'Datenschutzgrundverordnung',
          'GDPR',
        ],
      ),
      krit(
        'Bundesdatenschutzgesetz (BDSG)',
        stichwoerter: ['BDSG', 'Bundesdatenschutzgesetz', 'Datenschutzgesetz'],
      ),
      krit(
        'Berufsgeheimnis der Steuerberater: Verschwiegenheitspflicht, strafbewehrt durch § 203 StGB',
        stichwoerter: [
          'Berufsgeheimnis',
          'Verschwiegenheit',
          '203',
          'StGB',
          'Schweigepflicht',
          'Steuerberatungsgesetz',
        ],
      ),
    ],
    punkte: 2,
    loesung:
        'Die DSGVO (ergänzt durch das BDSG) schützt die personenbezogenen Daten der Mandanten. Daneben unterliegen Steuerberater dem Berufsgeheimnis: Die Verletzung von Privatgeheimnissen ist nach § 203 StGB strafbar. Auch Dienstleister, die an der Berufsausübung mitwirken, müssen zur Verschwiegenheit verpflichtet werden.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 2 Punkte. Bei Kanzleien, Arztpraxen und Apotheken tritt neben das Datenschutzrecht immer das Berufsgeheimnis nach § 203 StGB.',
  ),
  zuordnen(
    'i6-xg-3',
    'ds-grundlagen',
    scenario:
        'Die Steuerkanzlei Albers & Partner verarbeitet Daten ihrer Mandanten und Beschäftigten. Das Systemhaus betreut die Server per Fernwartung, ein Rechenzentrum speichert die verschlüsselten Sicherungen.',
    prompt: 'Ordne jedem Beteiligten seine Rolle nach der DSGVO zu.',
    buckets: ['Verantwortlicher', 'Auftragsverarbeiter', 'Betroffene Person'],
    items: [
      zu(
        'Rechenzentrum, das die Sicherungen im Auftrag speichert',
        1,
        'Verarbeitet nur nach Weisung der Kanzlei.',
      ),
      zu(
        'Mandantin, deren Steuererklärung erstellt wird',
        2,
        'Um ihre Daten geht es.',
      ),
      zu(
        'Steuerkanzlei Albers & Partner',
        0,
        'Sie entscheidet über Zwecke und Mittel der Verarbeitung.',
      ),
      zu(
        'Systemhaus, das die Server per Fernwartung betreut',
        1,
        'Hat im Auftrag der Kanzlei Zugriff auf die Daten.',
      ),
      zu(
        'Angestellter der Kanzlei, dessen Gehalt abgerechnet wird',
        2,
        'Auch Beschäftigte sind betroffene Personen.',
      ),
    ],
    explanation:
        'Verantwortlicher ist, wer über Zwecke und Mittel der Verarbeitung entscheidet - hier die Kanzlei. Auftragsverarbeiter verarbeiten Daten nach Weisung des Verantwortlichen (Rechenzentrum, Systemhaus) und brauchen einen Vertrag nach Art. 28 DSGVO. Betroffene Personen sind die Menschen, deren Daten verarbeitet werden.',
    punkte: 5,
  ),
  lueckentext(
    'i6-xg-4',
    'ds-grundlagen',
    prompt: 'Ergänze die Begriffsbestimmung der DSGVO.',
    text:
        'Personenbezogene Daten sind alle Informationen, die sich auf eine identifizierte oder {0} {1} Person beziehen. Daten über eine GmbH fallen deshalb {2} unter die DSGVO. Eine Kundennummer ist {3}, weil sie sich über die Kundendatei einem Menschen zuordnen lässt. Wer über Zwecke und Mittel der Verarbeitung entscheidet, heißt {4}.',
    luecken: [
      wahl('identifizierbare', ['anonyme', 'verstorbene']),
      wahl('natürliche', ['juristische', 'volljährige']),
      wahl('nicht', ['immer', 'nur mit Einwilligung']),
      wahl('personenbezogen', ['anonym', 'eine besondere Kategorie']),
      wahl('Verantwortlicher', [
        'Auftragsverarbeiter',
        'Datenschutzbeauftragter',
      ]),
    ],
    explanation:
        'Art. 4 DSGVO: Personenbezogen sind Informationen über identifizierte oder identifizierbare natürliche Personen. Juristische Personen (GmbH, AG) sind nicht geschützt. Auch Kennungen wie Kundennummer oder IP-Adresse sind personenbezogen, wenn sie sich einem Menschen zuordnen lassen. Der Verantwortliche entscheidet über Zwecke und Mittel.',
    punkte: 5,
  ),
  freitext(
    'i6-xg-5',
    'ds-grundlagen',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH will ihre Lohnabrechnung an einen externen Dienstleister auslagern. Dieser erhält dafür Zugriff auf die Personaldaten.',
    prompt:
        'Nenne den Vertrag, der dafür nach der DSGVO geschlossen werden muss, und zwei Punkte, die darin zu regeln sind. (3 P.)',
    kriterien: [
      krit(
        'Vertrag zur Auftragsverarbeitung (AV-Vertrag) nach Art. 28 DSGVO',
        stichwoerter: ['Auftragsverarbeitung', 'AV-Vertrag', 'AVV', 'Art. 28'],
      ),
      krit(
        'Gegenstand, Dauer und Zweck der Verarbeitung sowie Art der Daten',
        stichwoerter: ['Gegenstand', 'Dauer', 'Zweck', 'Art der Daten'],
      ),
      krit(
        'Verarbeitung nur nach Weisung des Verantwortlichen',
        stichwoerter: ['Weisung', 'weisungsgebunden', 'Anweisung'],
      ),
      krit(
        'Technische und organisatorische Maßnahmen des Dienstleisters',
        stichwoerter: [
          'technische und organisatorische',
          'TOM',
          'Sicherheitsmaßnahmen',
        ],
      ),
      krit(
        'Verpflichtung der eingesetzten Personen zur Vertraulichkeit',
        stichwoerter: ['Vertraulichkeit', 'Verschwiegenheit', 'Geheimhaltung'],
      ),
      krit(
        'Unterauftragnehmer nur mit Genehmigung; Löschung oder Rückgabe der Daten nach Vertragsende; Kontrollrechte',
        stichwoerter: [
          'Unterauftragnehmer',
          'Subunternehmer',
          'Löschung',
          'Rückgabe',
          'Kontrollrecht',
        ],
      ),
    ],
    punkte: 3,
    loesung:
        'Nötig ist ein Vertrag zur Auftragsverarbeitung nach Art. 28 DSGVO. Er regelt unter anderem Gegenstand, Dauer und Zweck der Verarbeitung, die Bindung an die Weisungen des Verantwortlichen, die technischen und organisatorischen Maßnahmen, die Vertraulichkeitsverpflichtung des Personals, den Einsatz von Unterauftragnehmern sowie Löschung oder Rückgabe der Daten am Ende.',
    explanation:
        '1 Punkt für den Vertrag, je 1 Punkt für zwei Regelungspunkte - höchstens 3 Punkte. Grünwerk bleibt trotz Auslagerung Verantwortlicher.',
  ),

  // ================================================== Grundsätze der Verarbeitung
  freitext(
    'i6-xs-1',
    'ds-grundsaetze',
    scenario:
        'Im Webshop der Grünwerk Gartenbedarf GmbH geben Kundinnen und Kunden bei einer Bestellung Name, Lieferanschrift und E-Mail-Adresse an. Ein Kollege meint, dafür müsse jeder Kunde erst ein Einwilligungsformular ankreuzen.',
    prompt:
        'Benenne die Rechtsgrundlage, auf die sich diese Verarbeitung stützt, und begründe deine Antwort. (3 P.)',
    kriterien: [
      krit(
        'Rechtsgrundlage: Erfüllung eines Vertrags (Art. 6 Abs. 1 lit. b DSGVO)',
        stichwoerter: ['Vertrag', 'Vertragserfüllung', 'lit. b', 'Kaufvertrag'],
      ),
      krit(
        'Begründung: Ohne Name, Anschrift und Kontaktmöglichkeit kann der Kaufvertrag nicht erfüllt werden; eine Einwilligung ist deshalb nicht nötig',
        punkte: 2,
        stichwoerter: [
          'erforderlich',
          'liefern',
          'Lieferung',
          'keine Einwilligung',
          'notwendig',
          'erfüllen',
        ],
      ),
    ],
    loesung:
        'Rechtsgrundlage ist die Erfüllung eines Vertrags (Art. 6 Abs. 1 lit. b DSGVO). Die Daten sind erforderlich, um den Kaufvertrag abzuwickeln: Ohne Name und Anschrift kann die Ware nicht geliefert, ohne E-Mail-Adresse die Bestellung nicht bestätigt werden. Eine Einwilligung ist dafür nicht nötig - sie wäre erst gefragt, wenn die Daten zusätzlich für einen Newsletter genutzt werden sollen.',
    explanation:
        '1 Punkt für die Rechtsgrundlage, 2 Punkte für die Begründung (Erforderlichkeit für den Vertrag). Die Einwilligung ist nur eine von sechs Rechtsgrundlagen und hier überflüssig.',
  ),
  freitext(
    'i6-xs-2',
    'ds-grundsaetze',
    scenario:
        'Die Elbtal Logistik AG will die Laderampen und das Hoftor der neuen Lagerhalle mit Kameras überwachen, um Diebstähle aufzuklären.',
    prompt:
        'Nenne drei Pflichten, die das Unternehmen bei der Videoüberwachung aus Sicht des Datenschutzes einhalten muss. (3 P.)',
    kriterien: [
      krit(
        'Auf die Überwachung deutlich hinweisen (Schild mit Verantwortlichem und Zweck)',
        stichwoerter: [
          'Hinweisschild',
          'Schild',
          'hinweisen',
          'Hinweis',
          'kennzeichnen',
        ],
      ),
      krit(
        'Zweck vorab festlegen und Interessen abwägen: nur so viel überwachen wie erforderlich (berechtigtes Interesse)',
        stichwoerter: [
          'Zweck',
          'Interessenabwägung',
          'berechtigtes Interesse',
          'erforderlich',
          'abwägen',
        ],
      ),
      krit(
        'Keine Erfassung von öffentlichem Raum, Nachbargrundstücken, Pausen-, Umkleide- und Sanitärräumen',
        stichwoerter: [
          'öffentlicher Raum',
          'öffentlichen Raum',
          'Pausenraum',
          'Umkleide',
          'Sanitär',
          'Nachbargrundstück',
        ],
      ),
      krit(
        'Aufnahmen nur kurz speichern und danach löschen (Richtwert der Aufsichtsbehörden: 72 Stunden)',
        stichwoerter: [
          'löschen',
          'Speicherdauer',
          'Speicherfrist',
          '72',
          'Löschfrist',
        ],
      ),
      krit(
        'Aufnahmen vor unbefugtem Zugriff schützen (Zugriffsrechte, Verschlüsselung)',
        stichwoerter: [
          'Zugriffsschutz',
          'unbefugt',
          'Zugriffsrechte',
          'geschützt',
          'verschlüsselt',
        ],
      ),
      krit(
        'Betriebsrat beteiligen und die Verarbeitung dokumentieren',
        stichwoerter: [
          'Betriebsrat',
          'Mitbestimmung',
          'dokumentieren',
          'Verzeichnis',
        ],
      ),
    ],
    punkte: 3,
    loesung:
        'Das Unternehmen muss durch gut sichtbare Schilder auf die Überwachung hinweisen, den Zweck vorab festlegen und seine Interessen gegen die der Betroffenen abwägen. Die Kameras dürfen nur das Nötige erfassen - keinen öffentlichen Raum und keine Pausen- oder Umkleideräume. Aufnahmen werden vor unbefugtem Zugriff geschützt und nach kurzer Zeit gelöscht. Der Betriebsrat ist zu beteiligen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Rechtsgrundlage ist in der Regel das berechtigte Interesse (Art. 6 Abs. 1 lit. f DSGVO) - es muss gegen die Interessen der Gefilmten abgewogen werden.',
  ),
  paare(
    'i6-xs-3',
    'ds-grundsaetze',
    prompt:
        'Ordne jedem Grundsatz der Verarbeitung (Art. 5 DSGVO) das passende Beispiel zu.',
    paare: [
      paar('Zweckbindung', 'Bestelldaten nicht für fremde Werbung nutzen'),
      paar('Datenminimierung', 'Newsletter fragt nur die E-Mail-Adresse ab'),
      paar('Speicherbegrenzung', 'Bewerbungen nach Fristablauf löschen'),
      paar('Richtigkeit', 'Veraltete Anschrift wird berichtigt'),
      paar('Integrität und Vertraulichkeit', 'Kundendatenbank verschlüsseln'),
    ],
    explanation:
        'Zweckbindung: Daten nur für den festgelegten Zweck. Datenminimierung: nur erheben, was nötig ist. Speicherbegrenzung: löschen, wenn der Zweck entfällt. Richtigkeit: Daten aktuell und korrekt halten. Integrität und Vertraulichkeit: durch geeignete Maßnahmen schützen.',
    punkte: 5,
  ),

  // ====================================================== Rechte der Betroffenen
  freitext(
    'i6-xr-1',
    'ds-rechte',
    scenario:
        'Ein Kunde der Grünwerk Gartenbedarf GmbH verlangt per E-Mail, dass „alle seine Daten sofort gelöscht“ werden. Er hat ein Kundenkonto, den Newsletter abonniert und im Vorjahr zwei Bestellungen aufgegeben, zu denen Rechnungen vorliegen.',
    prompt:
        'Erläutere, wie das Unternehmen auf das Verlangen reagieren muss. (4 P.)',
    kriterien: [
      krit(
        'Daten ohne weiteren Zweck (Kundenkonto, Newsletter-Anmeldung) werden gelöscht - Recht auf Löschung nach Art. 17 DSGVO',
        punkte: 2,
        stichwoerter: [
          'Kundenkonto',
          'Newsletter',
          'Art. 17',
          'gelöscht',
          'löschen',
        ],
      ),
      krit(
        'Rechnungsdaten unterliegen gesetzlichen Aufbewahrungsfristen und dürfen nicht gelöscht werden; ihre Verarbeitung wird eingeschränkt (gesperrt)',
        punkte: 2,
        stichwoerter: [
          'Aufbewahrungsfrist',
          'Aufbewahrungspflicht',
          'sperren',
          'einschränken',
          'gesperrt',
          'Rechnung',
        ],
      ),
      krit(
        'Der Kunde erhält innerhalb eines Monats eine Antwort, was gelöscht wurde und was aus welchem Grund nicht',
        punkte: 2,
        stichwoerter: [
          'innerhalb eines Monats',
          'ein Monat',
          'Frist',
          'informieren',
          'mitteilen',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Das Unternehmen muss die Daten löschen, für die es keinen Zweck mehr gibt: das Kundenkonto und die Newsletter-Anmeldung. Die Rechnungen zu den Bestellungen muss es dagegen wegen gesetzlicher Aufbewahrungsfristen aus dem Handels- und Steuerrecht behalten; diese Daten werden für andere Zwecke gesperrt und nach Ablauf der Frist gelöscht. Der Kunde wird innerhalb eines Monats darüber informiert.',
    explanation:
        'Je Aspekt 2 Punkte, höchstens 4 Punkte. Das Recht auf Löschung gilt nicht, soweit eine rechtliche Verpflichtung zur Aufbewahrung besteht (Art. 17 Abs. 3 DSGVO).',
  ),
  lueckentext(
    'i6-xr-2',
    'ds-rechte',
    scenario:
        'Bei der Pixelhafen Medien GmbH geht ein Auskunftsersuchen eines ehemaligen Kunden ein.',
    prompt: 'Ergänze die Regeln für die Bearbeitung.',
    text:
        'Das Recht auf Auskunft steht in Art. {0} DSGVO. Die Auskunft muss unverzüglich erteilt werden, spätestens innerhalb {1} nach Eingang. Bei besonders umfangreichen Anfragen kann die Frist um weitere {2} verlängert werden. Die Auskunft ist grundsätzlich {3}. Vor der Auskunft muss die {4} des Antragstellers geprüft werden, damit keine Daten an Unbefugte gehen.',
    luecken: [
      zahl(15),
      wahl('eines Monats', [
        'von 72 Stunden',
        'von zwei Wochen',
        'von drei Monaten',
      ]),
      wahl('zwei Monate', ['72 Stunden', 'zwei Wochen', 'sechs Monate']),
      wahl('kostenlos', ['kostenpflichtig', 'nur schriftlich zulässig']),
      wahl('Identität', ['Zahlungsfähigkeit', 'Staatsangehörigkeit']),
    ],
    explanation:
        'Auskunft nach Art. 15 DSGVO. Frist nach Art. 12 DSGVO: unverzüglich, spätestens innerhalb eines Monats, verlängerbar um zwei weitere Monate. Die Auskunft ist unentgeltlich. Die 72 Stunden gehören zur Meldung von Datenpannen, nicht zu den Betroffenenrechten.',
    punkte: 5,
  ),
  reihenfolge(
    'i6-xr-3',
    'ds-rechte',
    scenario:
        'Ein früherer Bewerber verlangt von der Elbtal Logistik AG Auskunft über die zu ihm gespeicherten Daten.',
    prompt:
        'Bringe die Schritte der Bearbeitung in eine sinnvolle Reihenfolge.',
    items: [
      'Eingang des Ersuchens festhalten und Frist notieren',
      'Identität des Antragstellers prüfen',
      'Daten der Person in allen Systemen zusammentragen',
      'Auskunft mit Zwecken, Empfängern und Speicherdauer erstellen',
      'Auskunft auf sicherem Weg übermitteln',
      'Erledigung dokumentieren',
    ],
    explanation:
        'Mit dem Eingang beginnt die Monatsfrist. Erst nach der Identitätsprüfung werden die Daten zusammengetragen - sonst könnten Unbefugte Auskünfte erschleichen. Die Auskunft enthält neben den Daten auch Zwecke, Empfänger und Speicherdauer. Am Ende wird der Vorgang dokumentiert (Rechenschaftspflicht).',
    punkte: 3,
  ),
  paare(
    'i6-xr-4',
    'ds-rechte',
    prompt: 'Ordne jedem Betroffenenrecht die passende Beschreibung zu.',
    paare: [
      paar('Auskunft (Art. 15)', 'Erfahren, welche Daten gespeichert sind'),
      paar('Berichtigung (Art. 16)', 'Falsche Daten korrigieren lassen'),
      paar('Löschung (Art. 17)', '„Recht auf Vergessenwerden“'),
      paar('Datenübertragbarkeit (Art. 20)', 'Daten maschinenlesbar mitnehmen'),
      paar('Widerspruch (Art. 21)', 'Direktwerbung untersagen'),
    ],
    explanation:
        'Art. 15 Auskunft, Art. 16 Berichtigung, Art. 17 Löschung, Art. 18 Einschränkung der Verarbeitung, Art. 20 Datenübertragbarkeit, Art. 21 Widerspruch. Der Widerspruch gegen Direktwerbung wirkt immer und ohne Begründung.',
    punkte: 5,
  ),

  // ============================================ Anonymisieren und Pseudonymisieren
  markieren(
    'i6-xa-1',
    'ds-anonym',
    scenario:
        'Die Grünwerk Gartenbedarf GmbH will Bestelldaten des Webshops an ein Marktforschungsinstitut geben. Das Institut soll keine Person mehr bestimmen können.',
    prompt:
        'Markiere alle Felder, die vor der Weitergabe entfernt werden müssen.',
    zeilen: [
      ja('Vor- und Nachname', 'Identifiziert die Person unmittelbar.'),
      nein(
        'Altersgruppe (z. B. 30-39 Jahre)',
        'Vergröbert - trifft auf sehr viele Personen zu.',
      ),
      ja('E-Mail-Adresse', 'Eindeutige Kennung einer Person.'),
      ja(
        'Kundennummer',
        'Über die Kundendatei lässt sie sich wieder einer Person zuordnen - nur ein Pseudonym.',
      ),
      nein('Bundesland', 'Grobe Region ohne Bezug zu einer einzelnen Person.'),
      nein('Bestellmonat', 'Kein Merkmal, das eine Person bestimmt.'),
      ja('Telefonnummer', 'Eindeutige Kennung einer Person.'),
      nein(
        'Warengruppe der bestellten Artikel',
        'Sagt nichts über die Identität aus.',
      ),
    ],
    explanation:
        'Für eine Anonymisierung müssen alle Merkmale entfernt werden, die eine Person direkt bestimmen (Name, E-Mail, Telefon) oder über eine Zuordnungstabelle bestimmbar machen (Kundennummer). Vergröberte Angaben wie Altersgruppe, Bundesland oder Bestellmonat dürfen bleiben.',
    punkte: 4,
  ),
  freitext(
    'i6-xa-2',
    'ds-anonym',
    scenario:
        'Für Tests des neuen Ticketsystems will die Pixelhafen Medien GmbH echte Kundendaten verwenden. Der Datenschutzbeauftragte verlangt, sie vorher zu anonymisieren oder wenigstens zu pseudonymisieren.',
    prompt:
        'Erläutere den Unterschied zwischen Anonymisierung und Pseudonymisierung und die jeweilige Folge für die Anwendung der DSGVO. (4 P.)',
    kriterien: [
      krit(
        'Anonymisierung: Der Personenbezug wird dauerhaft entfernt und lässt sich nicht wiederherstellen - die DSGVO gilt für diese Daten nicht mehr',
        punkte: 2,
        stichwoerter: [
          'dauerhaft',
          'nicht wiederherstellbar',
          'kein Personenbezug',
          'nicht mehr zuordnen',
          'unumkehrbar',
        ],
      ),
      krit(
        'Pseudonymisierung: Merkmale werden durch ein Kennzeichen ersetzt; mit getrennt aufbewahrten Zusatzinformationen ist die Zuordnung möglich - die Daten bleiben personenbezogen, die DSGVO gilt weiter',
        punkte: 2,
        stichwoerter: [
          'Kennzeichen',
          'Zuordnungstabelle',
          'Zusatzinformation',
          'weiterhin personenbezogen',
          'umkehrbar',
          'Kennung',
        ],
      ),
    ],
    loesung:
        'Bei der Anonymisierung wird der Personenbezug so entfernt, dass niemand die Daten mehr einer Person zuordnen kann. Anonyme Daten fallen nicht unter die DSGVO. Bei der Pseudonymisierung werden identifizierende Merkmale durch ein Kennzeichen ersetzt; die Zuordnung ist mit getrennt aufbewahrten Zusatzinformationen weiterhin möglich. Pseudonyme Daten bleiben personenbezogen, die DSGVO gilt in vollem Umfang - das Risiko ist aber geringer.',
    explanation:
        'Je 2 Punkte für Anonymisierung und Pseudonymisierung, jeweils Erklärung und Rechtsfolge. Pseudonymisierung ist eine Schutzmaßnahme, kein Ausweg aus der DSGVO.',
  ),
  lueckentext(
    'i6-xa-3',
    'ds-anonym',
    scenario:
        'Eine Krankenkasse wertet Abrechnungsdaten aus. Im ersten Schritt ersetzt sie die Versichertennummer durch eine zufällige Kennung und bewahrt die Zuordnungsliste getrennt auf. Für den Jahresbericht bildet sie später nur noch Summen je Altersgruppe und Region.',
    prompt: 'Ergänze die Einordnung der beiden Schritte.',
    text:
        'Der erste Schritt ist eine {0}: Mit der Zuordnungsliste lässt sich jede Kennung wieder einer Person zuordnen, die Daten bleiben {1}. Die Liste muss deshalb {2} von den Daten aufbewahrt werden. Die Summen je Altersgruppe und Region sind {3}, sofern jede Gruppe genügend Personen enthält. Für sie gilt die DSGVO {4}.',
    luecken: [
      wahl('Pseudonymisierung', ['Anonymisierung', 'Verschlüsselung']),
      wahl('personenbezogen', ['anonym', 'öffentlich']),
      wahl('getrennt', ['gemeinsam', 'unverschlüsselt']),
      wahl('anonym', ['pseudonym', 'besonders schützenswert']),
      wahl('nicht', ['weiterhin', 'verschärft']),
    ],
    explanation:
        'Kennung plus getrennt aufbewahrte Zuordnungsliste = Pseudonymisierung, die Daten bleiben personenbezogen. Zusammengefasste Werte (Aggregation) ohne Rückschluss auf Einzelne sind anonym - für sie gilt die DSGVO nicht. Zu kleine Gruppen können allerdings wieder auf Einzelne schließen lassen.',
    punkte: 5,
  ),

  // ========================================================================= TOM
  tabelle(
    'i6-xt-1',
    'ds-tom',
    scenario:
        'Für das Verzeichnis der technischen und organisatorischen Maßnahmen der Steuerkanzlei Albers & Partner ordnest du vorhandene Maßnahmen ein.',
    prompt:
        'Ergänze für jede Maßnahme die Art und das Kontrollziel, dem sie vor allem dient.',
    zeilen: [
      ['Maßnahme', 'Art', 'Kontrollziel'],
      [
        'Chipkartenleser an der Tür zum Serverraum',
        wahl('technisch', ['organisatorisch', 'rechtlich']),
        wahl('Zutrittskontrolle', ['Zugangskontrolle', 'Zugriffskontrolle']),
      ],
      [
        'Dienstanweisung: Besucher werden stets begleitet',
        wahl('organisatorisch', ['technisch', 'rechtlich']),
        wahl('Zutrittskontrolle', ['Zugangskontrolle', 'Zugriffskontrolle']),
      ],
      [
        'Anmeldung am PC mit Passwort und Einmalcode',
        wahl('technisch', ['organisatorisch', 'rechtlich']),
        wahl('Zugangskontrolle', ['Zutrittskontrolle', 'Zugriffskontrolle']),
      ],
      [
        'Dateirechte je Benutzergruppe auf dem Server',
        wahl('technisch', ['organisatorisch', 'rechtlich']),
        wahl('Zugriffskontrolle', ['Zutrittskontrolle', 'Zugangskontrolle']),
      ],
    ],
    explanation:
        'Zutritt = räumlich (Gebäude, Serverraum), Zugang = Nutzung des Systems (Anmeldung), Zugriff = Rechte auf bestimmte Daten. Technische Maßnahmen wirken durch Geräte oder Software, organisatorische durch Regeln und Anweisungen.',
    punkte: 8,
  ),
  freitext(
    'i6-xt-2',
    'ds-tom',
    scenario:
        'Einem Mitarbeiter der Steuerkanzlei Albers & Partner wird im Zug das Notebook gestohlen. Auf der unverschlüsselten Festplatte liegen Steuerunterlagen von rund 40 Mandanten.',
    prompt:
        'Beschreibe zwei Pflichten, die die Kanzlei nach der DSGVO nun erfüllen muss. (4 P.)',
    kriterien: [
      krit(
        'Meldung an die zuständige Datenschutz-Aufsichtsbehörde - unverzüglich, möglichst binnen 72 Stunden (Art. 33 DSGVO)',
        punkte: 2,
        stichwoerter: [
          'Aufsichtsbehörde',
          '72 Stunden',
          'Art. 33',
          'melden',
          'Meldung',
        ],
      ),
      krit(
        'Benachrichtigung der betroffenen Mandanten, weil ein hohes Risiko für sie besteht (Art. 34 DSGVO)',
        punkte: 2,
        stichwoerter: [
          'Betroffene benachrichtigen',
          'Mandanten informieren',
          'Art. 34',
          'benachrichtigen',
          'hohes Risiko',
        ],
      ),
      krit(
        'Vorfall mit Auswirkungen und ergriffenen Abhilfemaßnahmen dokumentieren',
        punkte: 2,
        stichwoerter: [
          'dokumentieren',
          'Dokumentation',
          'Abhilfemaßnahmen',
          'festhalten',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Die Kanzlei muss die Verletzung des Schutzes personenbezogener Daten unverzüglich, möglichst binnen 72 Stunden nach Bekanntwerden, der Datenschutz-Aufsichtsbehörde melden (Art. 33 DSGVO). Weil unverschlüsselte Steuerdaten ein hohes Risiko für die Mandanten bedeuten, müssen auch diese unverzüglich benachrichtigt werden (Art. 34 DSGVO). Außerdem ist der Vorfall mit den ergriffenen Maßnahmen zu dokumentieren.',
    explanation:
        'Je Pflicht 2 Punkte, höchstens 4 Punkte. Wäre die Festplatte verschlüsselt gewesen, bestünde voraussichtlich kein Risiko - Meldung und Benachrichtigung könnten dann entfallen.',
  ),
  paare(
    'i6-xt-3',
    'ds-tom',
    prompt: 'Ordne jedem Kontrollziel die passende Beschreibung zu.',
    paare: [
      paar('Zutrittskontrolle', 'Unbefugte kommen nicht in die Räume'),
      paar('Zugangskontrolle', 'Unbefugte können Systeme nicht nutzen'),
      paar('Zugriffskontrolle', 'Jeder sieht nur die Daten seiner Rolle'),
      paar('Weitergabekontrolle', 'Daten sind beim Transport geschützt'),
      paar('Verfügbarkeitskontrolle', 'Schutz vor Verlust und Zerstörung'),
    ],
    explanation:
        'Zutritt (Räume), Zugang (Systeme), Zugriff (Daten nach Berechtigung), Weitergabe (Übertragung und Transport, z. B. durch Verschlüsselung), Verfügbarkeit (Datensicherung, USV, Brandschutz).',
    punkte: 5,
  ),
  freitext(
    'i6-xt-4',
    'ds-tom',
    scenario:
        'Die Elbtal Logistik AG arbeitet mit einem internationalen Kunden zusammen. Dessen Richtlinie für Sicherheitsvorfälle gilt auch für Dienstleister.',
    code:
        'INCIDENT RESPONSE POLICY (excerpt)\n\nAny employee who notices a possible data breach must\nreport it to the IT service desk immediately. The affected\ndevice has to be disconnected from the network, but it\nmust not be switched off. The service desk informs the\ndata protection officer within one hour. All steps taken\nare recorded in the incident log.',
    prompt:
        'Nenne vier Schritte, die die Richtlinie bei einem möglichen Datenschutzvorfall verlangt. Antworte auf Deutsch. (4 P.)',
    kriterien: [
      krit(
        'Vorfall sofort dem IT-Servicedesk melden',
        stichwoerter: [
          'Servicedesk',
          'Service Desk',
          'sofort melden',
          'melden',
        ],
      ),
      krit(
        'Betroffenes Gerät vom Netzwerk trennen',
        stichwoerter: [
          'vom Netz trennen',
          'Netzwerk trennen',
          'trennen',
          'Netzwerkkabel',
        ],
      ),
      krit(
        'Gerät nicht ausschalten',
        stichwoerter: [
          'nicht ausschalten',
          'nicht abschalten',
          'eingeschaltet lassen',
          'nicht herunterfahren',
        ],
      ),
      krit(
        'Servicedesk informiert den Datenschutzbeauftragten innerhalb einer Stunde',
        stichwoerter: [
          'Datenschutzbeauftragte',
          'eine Stunde',
          'einer Stunde',
          'DSB',
        ],
      ),
      krit(
        'Alle Schritte im Vorfallsprotokoll festhalten',
        stichwoerter: [
          'Protokoll',
          'dokumentieren',
          'festhalten',
          'aufzeichnen',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Die Richtlinie verlangt: den möglichen Vorfall sofort dem IT-Servicedesk melden, das betroffene Gerät vom Netzwerk trennen, es aber nicht ausschalten, den Datenschutzbeauftragten innerhalb einer Stunde durch den Servicedesk informieren und alle Schritte im Vorfallsprotokoll festhalten.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Der Text enthält fünf Schritte; gewertet wird nur, was im Text steht. Das Gerät bleibt eingeschaltet, damit Spuren im Arbeitsspeicher erhalten bleiben.',
    tags: ['englisch'],
  ),
  markieren(
    'i6-xt-5',
    'ds-tom',
    scenario:
        'Bei einer Begehung des Serverraums der Pixelhafen Medien GmbH notierst du deine Beobachtungen.',
    prompt: 'Markiere alle Beobachtungen, die einen Mangel darstellen.',
    zeilen: [
      ja(
        'Die Tür wird tagsüber mit einem Keil offen gehalten',
        'Die Zutrittskontrolle ist damit wirkungslos.',
      ),
      nein(
        'Der Zutritt per Chipkarte wird protokolliert',
        'So ist nachvollziehbar, wer wann im Raum war.',
      ),
      ja(
        'Die Sicherungsbänder liegen offen auf dem Server',
        'Ein Brand oder Diebstahl trifft Original und Sicherung zugleich.',
      ),
      ja(
        'Das Administratorpasswort klebt auf einem Zettel am Monitor',
        'Jeder im Raum kann sich als Administrator anmelden.',
      ),
      nein(
        'Die USV führt monatlich einen Selbsttest durch',
        'Regelmäßige Tests sichern die Verfügbarkeit.',
      ),
      nein(
        'Die Klimaanlage meldet Übertemperatur per Alarm',
        'Überwachung der Umgebungsbedingungen ist vorgesehen.',
      ),
      ja(
        'Im Raum lagern Kartons und Altpapier',
        'Brandlast gehört nicht in den Serverraum.',
      ),
    ],
    explanation:
        'Mängel sind: offene Tür (Zutritt), Sicherungen im selben Raum (keine räumliche Trennung), offen sichtbares Passwort (Zugang) und Brandlast. Protokollierter Zutritt, USV-Test und Temperaturalarm sind wirksame Maßnahmen.',
    punkte: 4,
  ),
];
