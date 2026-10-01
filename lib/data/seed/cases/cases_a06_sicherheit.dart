import '../builders.dart';

const _andere = ' Andere fachlich richtige Antworten zählen ebenfalls.';

/// Fallaufgaben (je 25 Punkte) zu Bereich 06 für die Prüfungssimulation.
/// Aufbau, Operatoren und Punktverteilung folgen den echten Aufgaben
/// „Sicherheit, Datenschutz, Organisation“ (siehe docs/pruefungsanalyse).
final List<ExamCase> casesA06 = [
  // ------------------------------------------------------------- Systemhaus 1
  fall(
    'f-a06-systemhaus',
    firma: 'systemhaus',
    bereich: 'a06',
    titel: 'Sichere E-Mail-Kommunikation der Kanzlei',
    situation:
        'Die Steuerkanzlei Albers & Partner möchte Steuerbescheide und Lohnunterlagen künftig per E-Mail mit ihren Mandanten austauschen. Die Kessler & Brandt IT-Systemhaus GmbH soll dafür ein neues E-Mail-Programm mit Verschlüsselung einrichten. Du bereitest die Einführung vor und berätst die Kanzlei zu Datenschutz und Datensicherheit.',
    teile: [
      freitext(
        'f-a06-systemhaus-a',
        'ds-grundlagen',
        prompt:
            'Für den Austausch zwischen Steuerberater und Mandant gelten erhöhte Anforderungen an den Schutz der Daten. Nenne zwei Rechtsgrundlagen, aus denen sich diese Anforderungen ergeben. (2 P.)',
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
            stichwoerter: [
              'BDSG',
              'Bundesdatenschutzgesetz',
              'Datenschutzgesetz',
            ],
          ),
          krit(
            'Berufsgeheimnis: Verschwiegenheitspflicht der Steuerberater (§ 203 StGB, Steuerberatungsgesetz)',
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
            'DSGVO und BDSG schützen die personenbezogenen Daten der Mandanten. Zusätzlich gilt das Berufsgeheimnis: Steuerberater sind zur Verschwiegenheit verpflichtet, ein Bruch ist nach § 203 StGB strafbar.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2 Punkte. Stichworte genügen; überzählige Nennungen werden nicht gewertet.',
      ),
      freitext(
        'f-a06-systemhaus-b',
        'ds-grundlagen',
        prompt: 'Beschreibe den Zweck des Datenschutzrechts. (2 P.)',
        kriterien: [
          krit(
            'Schutz natürlicher Personen bei der Verarbeitung ihrer Daten. Jeder soll selbst über seine Daten bestimmen können (informationelle Selbstbestimmung)',
            punkte: 2,
            stichwoerter: [
              'natürliche Personen',
              'Selbstbestimmung',
              'Persönlichkeitsrecht',
              'Schutz der Person',
              'Privatsphäre',
            ],
          ),
          krit(
            'Daten dürfen nur mit Rechtsgrundlage und zweckgebunden verarbeitet werden und sind vor unbefugtem Zugriff zu schützen',
            punkte: 2,
            stichwoerter: [
              'zweckgebunden',
              'Rechtsgrundlage',
              'unbefugt',
              'Missbrauch',
              'Zweckbindung',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Das Datenschutzrecht schützt nicht die Daten, sondern die Menschen dahinter: Jede Person soll grundsätzlich selbst bestimmen können, wer was über sie weiß (informationelle Selbstbestimmung). Deshalb dürfen personenbezogene Daten nur mit Rechtsgrundlage, zweckgebunden und geschützt vor unbefugtem Zugriff verarbeitet werden.',
        explanation:
            '2 Punkte für eine Aussage mit kurzer Ausführung: Schutz der Person bzw. ihrer informationellen Selbstbestimmung, oder zweckgebundene, geschützte Verarbeitung.$_andere',
      ),
      freitext(
        'f-a06-systemhaus-c',
        'kr-asymmetrisch',
        scenario:
            'Das E-Mail-Programm verschlüsselt asymmetrisch. Kanzlei und Mandant besitzen je einen privaten und einen öffentlichen Schlüssel.',
        skizze: SequenzDiagramm(
          ['Kanzlei', 'Mandant'],
          [
            Nachricht(1, 0, 'öffentlicher Schlüssel'),
            Nachricht(0, 1, 'verschlüsselte E-Mail'),
          ],
        ),
        prompt:
            'Beschreibe anhand der Skizze, wie die Kanzlei eine E-Mail verschlüsselt und wie der Mandant sie entschlüsselt. (4 P.)',
        kriterien: [
          krit(
            'Die Kanzlei verschlüsselt die E-Mail mit dem öffentlichen Schlüssel des Mandanten (Empfängers)',
            punkte: 2,
            stichwoerter: [
              'öffentlichen Schlüssel',
              'öffentlicher Schlüssel',
              'öffentliche Schlüssel',
              'public key',
            ],
          ),
          krit(
            'Der Mandant entschlüsselt mit seinem privaten Schlüssel, den nur er besitzt',
            punkte: 2,
            stichwoerter: [
              'privaten Schlüssel',
              'privater Schlüssel',
              'private Schlüssel',
              'private key',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Der Mandant stellt der Kanzlei seinen öffentlichen Schlüssel zur Verfügung. Die Kanzlei verschlüsselt die E-Mail mit diesem öffentlichen Schlüssel des Mandanten und sendet den Geheimtext. Der Mandant entschlüsselt mit seinem privaten Schlüssel. Weil nur er diesen Schlüssel besitzt, kann niemand sonst die E-Mail lesen.',
        explanation:
            '2 Punkte für die Seite der Kanzlei (öffentlicher Schlüssel des Empfängers), 2 Punkte für die Seite des Mandanten (sein privater Schlüssel). Die Schlüssel der Kanzlei werden für die Verschlüsselung nicht gebraucht.',
      ),
      lueckentext(
        'f-a06-systemhaus-d',
        'kr-asymmetrisch',
        prompt:
            'Ergänze das erreichte Schutzziel sowie je einen Vorteil und einen Nachteil der asymmetrischen gegenüber der symmetrischen Verschlüsselung.',
        text:
            'Die Verschlüsselung der E-Mail sichert das Schutzziel {0}. Vorteil des asymmetrischen Verfahrens: Es muss {1} ausgetauscht werden. Nachteil: Das Verfahren ist {2} als ein symmetrisches.',
        luecken: [
          wahl('Vertraulichkeit', ['Integrität', 'Verfügbarkeit']),
          wahl('kein geheimer Schlüssel', [
            'kein öffentlicher Schlüssel',
            'kein Zertifikat',
          ]),
          wahl('langsamer', ['schneller', 'unsicherer']),
        ],
        explanation:
            'Verschlüsselung schützt die Vertraulichkeit. Asymmetrisch muss kein geheimer Schlüssel über einen sicheren Kanal ausgetauscht werden. Der öffentliche darf jedem bekannt sein. Dafür ist das Verfahren rechenaufwendiger und langsamer.',
        punkte: 3,
      ),
      freitext(
        'f-a06-systemhaus-e',
        'kr-hash',
        scenario:
            'Das E-Mail-Programm wird von der Website des Herstellers geladen. Dort stehen folgende Angaben.',
        table: [
          ['Datei', 'SHA-256'],
          ['mailclient-12.4-setup.exe', '4be1907c…a3f2d85e'],
        ],
        prompt: 'Erläutere den Zweck des angegebenen Hashwerts. (4 P.)',
        kriterien: [
          krit(
            'Nach dem Download wird der Hashwert der Datei selbst berechnet und mit dem angegebenen verglichen',
            punkte: 2,
            stichwoerter: [
              'vergleichen',
              'berechnen',
              'selbst berechnet',
              'abgleichen',
            ],
          ),
          krit(
            'Gleich: Datei vollständig und unverändert (Integrität). Ungleich: beschädigt oder manipuliert, nicht installieren',
            punkte: 2,
            stichwoerter: [
              'Integrität',
              'unverändert',
              'manipuliert',
              'beschädigt',
              'nicht installieren',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Der Hashwert dient der Integritätsprüfung. Nach dem Download berechnet man den SHA-256-Wert der Datei selbst und vergleicht ihn mit dem Wert auf der Website. Stimmen beide überein, ist die Datei vollständig und unverändert. Weichen sie ab, wurde sie beschädigt oder manipuliert und darf nicht installiert werden.',
        explanation:
            '2 Punkte für das Vorgehen (berechnen und vergleichen), 2 Punkte für die Aussage des Ergebnisses (Integrität bzw. Manipulation).',
      ),
      freitext(
        'f-a06-systemhaus-f',
        'sm-zugriff',
        scenario:
            'Eine Mitarbeiterin der Kanzlei möchte auf ihrem PC Administratorrechte, um Programme selbst installieren zu können.',
        prompt:
            'Erläutere einen Grund, warum die Beschäftigten nicht mit Administratorrechten arbeiten sollen. (3 P.)',
        kriterien: [
          krit(
            'Schadsoftware läuft mit den Rechten des angemeldeten Kontos. Mit Administratorrechten kann sie sich systemweit einnisten und Schutzfunktionen abschalten',
            punkte: 3,
            stichwoerter: [
              'Schadsoftware',
              'Malware',
              'Virus',
              'systemweit',
              'Rechten des Benutzers',
              'Trojaner',
            ],
          ),
          krit(
            'Beschäftigte können versehentlich oder absichtlich Systemeinstellungen ändern, Schutzmechanismen abschalten oder ungeprüfte Software installieren',
            punkte: 3,
            stichwoerter: [
              'Systemeinstellungen',
              'versehentlich',
              'Virenscanner abschalten',
              'ungeprüfte Software',
              'Fehlbedienung',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Es gilt das Prinzip der minimalen Rechte. Schadsoftware, die etwa über einen E-Mail-Anhang auf den PC gelangt, läuft mit den Rechten des angemeldeten Kontos. Mit Administratorrechten könnte sie sich im ganzen System einnisten, den Virenscanner abschalten und weitere Rechner angreifen. Mit einem normalen Benutzerkonto bleibt der Schaden begrenzt.',
        explanation:
            'Grund und Folge zusammen ergeben 3 Punkte: Minimalprinzip nennen und erklären, was mit Administratorrechten passieren kann.$_andere',
      ),
      freitext(
        'f-a06-systemhaus-g',
        'sm-zugriff',
        scenario:
            'Der Hersteller des E-Mail-Programms gibt Hinweise zur sicheren Einrichtung.',
        code:
            'SECURING YOUR MAIL CLIENT\n\nTo protect confidential messages, first install the\nlatest security baseline provided by the vendor. Use a\nstrong and unique password for every mailbox. Make sure\nthe built-in firewall of the operating system is enabled.\nConfigure the client to download and install updates\nautomatically. Finally, disable the automatic loading of\nexternal images, because they can be used to track the\nreader.',
        prompt:
            'Nenne vier Sicherheitsmaßnahmen, die der Text empfiehlt. Antworte auf Deutsch. (4 P.)',
        kriterien: [
          krit(
            'Aktuelle Sicherheits-Baseline (Grundkonfiguration) des Herstellers einspielen',
            stichwoerter: [
              'Baseline',
              'Grundkonfiguration',
              'Sicherheitsvorlage',
              'Basiskonfiguration',
            ],
          ),
          krit(
            'Für jedes Postfach ein starkes, einzigartiges Passwort verwenden',
            stichwoerter: ['Passwort', 'Kennwort', 'starkes', 'einzigartig'],
          ),
          krit(
            'Eingebaute Firewall des Betriebssystems aktivieren',
            stichwoerter: ['Firewall', 'aktivieren', 'einschalten'],
          ),
          krit(
            'Updates automatisch laden und installieren lassen',
            stichwoerter: [
              'Updates',
              'automatisch',
              'Aktualisierung',
              'Update',
            ],
          ),
          krit(
            'Automatisches Laden externer Bilder abschalten (Schutz vor Nachverfolgung)',
            stichwoerter: ['Bilder', 'externe', 'Tracking', 'Nachverfolgung'],
          ),
        ],
        punkte: 4,
        loesung:
            'Der Text nennt fünf Maßnahmen: die aktuelle Sicherheits-Baseline des Herstellers einspielen, für jedes Postfach ein starkes und einzigartiges Passwort verwenden, die eingebaute Firewall des Betriebssystems aktivieren, Updates automatisch installieren lassen und das automatische Laden externer Bilder abschalten.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 4 Punkte. Gewertet wird nur, was im Text steht; Stichworte auf Deutsch genügen.',
        tags: ['englisch'],
      ),
      markieren(
        'f-a06-systemhaus-h',
        'sz-angriffe',
        scenario:
            'Kurz nach der Umstellung erhält die Kanzlei folgende E-Mail.',
        prompt:
            'Markiere alle Zeilen, die auf einen Phishing-Versuch hindeuten.',
        zeilen: [
          ja(
            'Von: Finanzamt Bremen <bescheid@finanzamt-bremen.steuer-post.example>',
            'Die Absenderdomain gehört nicht zur Finanzverwaltung.',
          ),
          ja(
            'Betreff: Letzte Mahnung: Vollstreckung in 48 Stunden',
            'Drohung und Zeitdruck sollen zu unüberlegtem Handeln verleiten.',
          ),
          nein(
            'Diese Nachricht wurde automatisch erstellt.',
            'Ein üblicher Hinweis ohne Aussagekraft.',
          ),
          ja(
            'Anhang: Bescheid_2026.zip (Passwort zum Öffnen: 2026)',
            'Passwortgeschützte Archive umgehen den Virenscanner des Mailservers.',
          ),
          ja(
            'Aktivieren Sie nach dem Öffnen die Makros, um den Bescheid anzuzeigen.',
            'Makros sind ein typischer Weg, Schadsoftware zu starten.',
          ),
          nein(
            'Rückfragen richten Sie bitte an Ihr zuständiges Finanzamt.',
            'Ein neutraler Hinweis ohne Aufforderung zu einer riskanten Handlung.',
          ),
        ],
        explanation:
            'Verdächtig sind die fremde Absenderdomain, die Drohung mit kurzer Frist, das passwortgeschützte Archiv und die Aufforderung, Makros zu aktivieren. Echte Bescheide kommen nicht als ZIP-Datei mit Makros.',
        punkte: 3,
      ),
    ],
  ),

  // ------------------------------------------------------------------ Handel
  fall(
    'f-a06-handel',
    firma: 'handel',
    bereich: 'a06',
    titel: 'Kassen und mobile Arbeitsplätze absichern',
    situation:
        'Für die neue Filiale in Göttingen beschafft die Grünwerk Gartenbedarf GmbH Kassenterminals. Gleichzeitig erhalten 20 Beschäftigte aus Einkauf und Kundenservice Notebooks für mobiles Arbeiten. Die IT-Abteilung soll beides sicher in Betrieb nehmen. Du unterstützt bei Planung und Einrichtung.',
    teile: [
      freitext(
        'f-a06-handel-a',
        'ds-grundlagen',
        scenario:
            'Die Filialleitung schlägt vor, dass sich das Kassenpersonal per Fingerabdruck an den Terminals anmeldet.',
        prompt:
            'Begründe, warum Fingerabdruckdaten einen erhöhten Schutz benötigen, und nenne eine Rechtsgrundlage für den Datenschutz. (3 P.)',
        kriterien: [
          krit(
            'Begründung: Biometrische Daten zur Identifizierung sind besonders schützenswerte personenbezogene Daten; ihre Verarbeitung ist nur ausnahmsweise erlaubt, z. B. mit ausdrücklicher Einwilligung',
            punkte: 2,
            stichwoerter: [
              'besonders schützenswert',
              'besondere Kategorie',
              'biometrisch',
              'Einwilligung',
              'Art. 9',
              'sensibel',
            ],
          ),
          krit(
            'Rechtsgrundlage: DSGVO (Art. 9) oder BDSG',
            stichwoerter: [
              'DSGVO',
              'BDSG',
              'Datenschutz-Grundverordnung',
              'Bundesdatenschutzgesetz',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Ein Fingerabdruck ist ein biometrisches Merkmal, das eine Person eindeutig identifiziert und sich nicht ändern lässt. Solche Daten zählen zu den besonderen Kategorien personenbezogener Daten; ihre Verarbeitung ist grundsätzlich untersagt und nur ausnahmsweise zulässig, etwa mit ausdrücklicher, freiwilliger Einwilligung. Rechtsgrundlage: DSGVO (Art. 9), ergänzt durch das BDSG.',
        explanation:
            '2 Punkte für die Begründung (besonders schützenswerte Daten, Einwilligung nötig), 1 Punkt für die Rechtsgrundlage (DSGVO oder BDSG).',
      ),
      tabelle(
        'f-a06-handel-b',
        'kr-auth',
        prompt:
            'Für die Anmeldung an den Kassen werden drei Methoden verglichen. Ergänze die Tabelle; die Zeile „Fingerabdruck“ dient als Muster.',
        zeilen: [
          ['Methode', 'Vorteil', 'Risiko'],
          [
            'Fingerabdruck (Biometrie)',
            'kann nicht vergessen oder verlegt werden',
            'lässt sich nach Missbrauch nicht ändern',
          ],
          [
            'Passwort (Wissen)',
            wahl('kein Lesegerät oder Hilfsmittel nötig', [
              'kann nicht vergessen werden',
              'speichert zusätzlich Daten wie Zeitkonten',
            ]),
            wahl('kann verraten, ausgespäht oder erraten werden', [
              'kann verloren gehen oder gestohlen werden',
              'Lesegerät erkennt das Merkmal nicht',
            ]),
          ],
          [
            'Chipkarte (Besitz)',
            wahl('kann nicht erraten werden, Verlust fällt auf', [
              'kein Lesegerät oder Hilfsmittel nötig',
              'kann nicht verloren gehen',
            ]),
            wahl('kann verloren gehen oder gestohlen werden', [
              'kann verraten, ausgespäht oder erraten werden',
              'lässt sich nach Missbrauch nicht ändern',
            ]),
          ],
        ],
        explanation:
            'Wissen (Passwort): braucht keine Hardware, kann aber verraten, ausgespäht oder erraten werden. Besitz (Chipkarte): nicht erratbar, ein Verlust fällt auf. Sie kann aber gestohlen und missbraucht werden. Je Zelle 1 Punkt.',
        punkte: 4,
      ),
      freitext(
        'f-a06-handel-c',
        'sz-schadsoftware',
        scenario:
            'Die Kassenterminals werden mit der Software ausgeliefert, die bei der Fertigung vor acht Monaten aufgespielt wurde.',
        prompt:
            'Beschreibe einen Grund, warum vor der Inbetriebnahme ein Softwareupdate durchgeführt werden soll. (2 P.)',
        kriterien: [
          krit(
            'Seit der Fertigung bekannt gewordene Sicherheitslücken werden geschlossen. Das Gerät ist gegen Angriffe gehärtet',
            punkte: 2,
            stichwoerter: [
              'Sicherheitslücke',
              'Schwachstelle',
              'Angriff',
              'härten',
              'schließen',
            ],
          ),
          krit(
            'Fehler der Auslieferungsversion werden behoben, das Gerät läuft stabiler',
            punkte: 2,
            stichwoerter: ['Fehler', 'Bug', 'beheben', 'stabil'],
          ),
          krit(
            'Die Software wird an aktuelle Anforderungen angepasst (neue Funktionen, Vorgaben, Kompatibilität)',
            punkte: 2,
            stichwoerter: [
              'Anforderungen',
              'Funktionen',
              'Kompatibilität',
              'Vorgaben',
              'anpassen',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Seit der Fertigung sind acht Monate vergangen. In dieser Zeit wurden Sicherheitslücken bekannt und vom Hersteller behoben. Erst das Update schließt diese Lücken, sodass das Terminal nicht mit bekannten Schwachstellen ans Netz geht.',
        explanation:
            '2 Punkte für einen beschriebenen Grund: Sicherheitslücken schließen, Fehler beheben oder an aktuelle Anforderungen anpassen.',
      ),
      freitext(
        'f-a06-handel-d',
        'sz-angriffe',
        scenario:
            'Ein unbekannter Onlinehändler bietet baugleiche Terminals deutlich günstiger an. Die IT-Leitung besteht auf dem Kauf beim autorisierten Fachhändler.',
        prompt:
            'Beschreibe ein Risiko, das von Geräten ausgeht, die in der Lieferkette manipuliert wurden. (2 P.)',
        kriterien: [
          krit(
            'Unbemerkt eingebaute Abhör- oder Auslesefunktionen: Kartendaten und PINs werden abgegriffen und an Dritte übertragen',
            punkte: 2,
            stichwoerter: [
              'abhören',
              'auslesen',
              'abgreifen',
              'Kartendaten',
              'Hintertür',
              'Backdoor',
            ],
          ),
          krit(
            'Sicherheitsfunktionen sind abgeschaltet oder die Firmware enthält Schadsoftware, die sich im Filialnetz ausbreitet',
            punkte: 2,
            stichwoerter: [
              'Sicherheitsfunktion',
              'Firmware',
              'Schadsoftware',
              'deaktiviert',
              'Malware',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Auf dem Weg vom Hersteller zum Kunden können Geräte verändert worden sein. Ein manipuliertes Terminal kann unbemerkt Kartendaten und PINs auslesen und an Dritte senden oder eine Hintertür ins Filialnetz öffnen.',
        explanation:
            '2 Punkte für ein beschriebenes Risiko, z. B. eingebaute Auslesefunktion oder abgeschaltete Sicherheitsfunktionen.$_andere',
      ),
      rechnen(
        'f-a06-handel-e',
        'sm-backup',
        scenario:
            'Die Kassendaten der Filiale werden gesichert: sonntags eine Vollsicherung mit 120 GB, von Montag bis Samstag je eine inkrementelle Sicherung mit 8 GB. Alle Sicherungen werden vier Wochen aufbewahrt.',
        prompt:
            'Berechne den Speicherplatz, der für die Sicherungen von vier Wochen benötigt wird.',
        answer: 672,
        unit: 'GB',
        explanation:
            'Eine Woche: 120 GB + 6 × 8 GB = 120 GB + 48 GB = 168 GB. Vier Wochen: 4 × 168 GB = 672 GB.',
        punkte: 3,
      ),
      freitext(
        'f-a06-handel-f',
        'kr-asymmetrisch',
        scenario:
            'Der Einkauf versendet Bestellungen an Lieferanten künftig digital signiert.',
        skizze: SequenzDiagramm(
          ['Einkauf', 'Lieferant'],
          [
            Nachricht(0, 1, 'Zertifikat (öff. Schlüssel)'),
            Nachricht(0, 1, 'Bestellung + Signatur'),
          ],
        ),
        prompt:
            'Beschreibe anhand der Skizze, wie die digitale Signatur erstellt und wie sie geprüft wird. (4 P.)',
        kriterien: [
          krit(
            'Erstellen: Hashwert der Bestellung bilden und mit dem privaten Schlüssel des Einkaufs (Absenders) verschlüsseln; Bestellung und Signatur senden',
            punkte: 2,
            stichwoerter: [
              'privaten Schlüssel',
              'privater Schlüssel',
              'private Schlüssel',
              'private key',
            ],
          ),
          krit(
            'Prüfen: Lieferant entschlüsselt die Signatur mit dem öffentlichen Schlüssel des Einkaufs, berechnet den Hashwert neu und vergleicht',
            punkte: 2,
            stichwoerter: [
              'öffentlichen Schlüssel',
              'öffentlicher Schlüssel',
              'öffentliche Schlüssel',
              'public key',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Der Einkauf bildet den Hashwert der Bestellung und verschlüsselt ihn mit seinem privaten Schlüssel. Das ist die Signatur. Bestellung und Signatur gehen an den Lieferanten. Dieser entschlüsselt die Signatur mit dem öffentlichen Schlüssel des Einkaufs, berechnet den Hashwert der Bestellung selbst und vergleicht beide Werte. Stimmen sie überein, ist die Bestellung echt (Authentizität) und unverändert (Integrität).',
        explanation:
            '2 Punkte für das Erstellen (privater Schlüssel des Absenders), 2 Punkte für das Prüfen (öffentlicher Schlüssel des Absenders). Auch die Kurzfassung „mit dem privaten Schlüssel signieren, mit dem öffentlichen prüfen“ erhält volle Punkte.',
      ),
      tabelle(
        'f-a06-handel-g',
        'ds-tom',
        prompt:
            'Für das mobile Arbeiten gelten Schutzmaßnahmen. Ergänze zu jeder Maßnahme die Folge, die droht, wenn sie fehlt. Die erste Zeile dient als Muster.',
        zeilen: [
          ['Maßnahme', 'Folge, wenn sie fehlt'],
          ['Anmeldung mit Passwort', 'Unbefugte können das Gerät nutzen'],
          [
            'Festplattenverschlüsselung',
            wahl('Nach einem Diebstahl sind die Daten lesbar', [
              'Die Übertragung im fremden WLAN ist mitlesbar',
              'Mitreisende sehen den Bildschirminhalt',
              'Nach einem Defekt sind die Daten verloren',
            ]),
          ],
          [
            'VPN-Verbindung',
            wahl('Die Übertragung im fremden WLAN ist mitlesbar', [
              'Nach einem Diebstahl sind die Daten lesbar',
              'Mitreisende sehen den Bildschirminhalt',
              'Nach einem Defekt sind die Daten verloren',
            ]),
          ],
          [
            'Blickschutzfolie',
            wahl('Mitreisende sehen den Bildschirminhalt', [
              'Nach einem Diebstahl sind die Daten lesbar',
              'Die Übertragung im fremden WLAN ist mitlesbar',
              'Nach einem Defekt sind die Daten verloren',
            ]),
          ],
          [
            'Regelmäßige Datensicherung',
            wahl('Nach einem Defekt sind die Daten verloren', [
              'Nach einem Diebstahl sind die Daten lesbar',
              'Die Übertragung im fremden WLAN ist mitlesbar',
              'Mitreisende sehen den Bildschirminhalt',
            ]),
          ],
        ],
        explanation:
            'Verschlüsselung schützt gespeicherte Daten bei Verlust des Geräts, das VPN die Übertragung, die Blickschutzfolie vor neugierigen Blicken, die Datensicherung vor Datenverlust. Je Zeile 1 Punkt.',
        punkte: 4,
      ),
      freitext(
        'f-a06-handel-h',
        'ls-verzug',
        scenario:
            'Die 20 Notebooks sollten laut Kaufvertrag „am 15. September“ geliefert werden. Am 1. Oktober sind sie noch nicht eingetroffen; der Händler hatte die Bestellung beim Hersteller versäumt.',
        prompt:
            'Nenne drei Rechte, die der Grünwerk Gartenbedarf GmbH wegen des Lieferungsverzugs zustehen können. (3 P.)',
        kriterien: [
          krit(
            'Weiterhin auf der Lieferung bestehen',
            stichwoerter: [
              'Lieferung verlangen',
              'auf Lieferung bestehen',
              'Erfüllung',
              'liefern',
            ],
          ),
          krit(
            'Ersatz des Verzögerungsschadens verlangen',
            stichwoerter: [
              'Verzögerungsschaden',
              'Verzugsschaden',
              'Schadensersatz wegen Verzögerung',
            ],
          ),
          krit(
            'Nach erfolgloser Nachfrist vom Vertrag zurücktreten',
            stichwoerter: ['Rücktritt', 'zurücktreten', 'Nachfrist'],
          ),
          krit(
            'Nach erfolgloser Nachfrist Schadensersatz statt der Leistung verlangen (z. B. Mehrkosten eines Deckungskaufs)',
            stichwoerter: [
              'statt der Leistung',
              'Deckungskauf',
              'Mehrkosten',
              'Schadensersatz',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Der Liefertermin war nach dem Kalender bestimmt, der Händler ist daher ohne Mahnung in Verzug und hat die Verspätung zu vertreten. Grünwerk kann weiter die Lieferung verlangen und daneben Ersatz des Verzögerungsschadens. Nach Ablauf einer angemessenen Nachfrist kann Grünwerk vom Vertrag zurücktreten und Schadensersatz statt der Leistung verlangen, etwa die Mehrkosten eines Deckungskaufs.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Rücktritt und Schadensersatz statt der Leistung setzen grundsätzlich eine erfolglos abgelaufene Nachfrist voraus.',
      ),
    ],
  ),

  // ----------------------------------------------------------------- Agentur
  fall(
    'f-a06-agentur',
    firma: 'agentur',
    bereich: 'a06',
    titel: 'Ticketsystem datenschutzgerecht einführen',
    situation:
        'Die Pixelhafen Medien GmbH führt ein Ticketsystem ein, über das Kunden Supportanfragen stellen. Das System läuft auf einem eigenen Server und ist über ein Webportal erreichbar. Du unterstützt die beiden Administratoren bei der sicheren Einrichtung und begleitest die Einführung im Supportteam.',
    teile: [
      freitext(
        'f-a06-agentur-a',
        'ds-grundlagen',
        prompt:
            'Im Ticketsystem werden personenbezogene Daten gespeichert. Nenne zwei Rechtsgrundlagen des Datenschutzes, die in Deutschland gelten. (2 P.)',
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
            stichwoerter: ['BDSG', 'Bundesdatenschutzgesetz'],
          ),
          krit(
            'Weitere Gesetze, z. B. Landesdatenschutzgesetze oder das TDDDG für Websites',
            stichwoerter: ['Landesdatenschutzgesetz', 'TDDDG', 'TTDSG', 'LDSG'],
          ),
        ],
        punkte: 2,
        loesung:
            'In Deutschland gelten die europäische Datenschutz-Grundverordnung (DSGVO) und ergänzend das Bundesdatenschutzgesetz (BDSG). Hinzu kommen Landesdatenschutzgesetze für Landesbehörden und Spezialgesetze wie das TDDDG für Websites.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2 Punkte. Erwartet werden in der Regel DSGVO und BDSG.',
      ),
      markieren(
        'f-a06-agentur-b',
        'ds-grundlagen',
        scenario: 'Ein Ticket enthält folgende Angaben.',
        prompt: 'Markiere alle Angaben, die personenbezogene Daten sind.',
        zeilen: [
          nein(
            'Kunde: Möbel Brandt GmbH',
            'Eine GmbH ist eine juristische Person und deshalb nicht von der DSGVO geschützt.',
          ),
          ja('Ansprechpartner: Jonas Reuter', 'Name einer natürlichen Person.'),
          ja(
            'E-Mail: j.reuter@moebel-brandt.example',
            'Persönliche Adresse, die auf eine bestimmte Person verweist.',
          ),
          nein(
            'Kategorie: Webshop, Fehler im Warenkorb',
            'Sachangabe ohne Bezug zu einer Person.',
          ),
          ja('Durchwahl: 0341 555-0142', 'Lässt sich einer Person zuordnen.'),
          nein('Priorität: hoch', 'Sachangabe zum Vorgang.'),
          ja(
            'Bearbeiterin: Lena Vogt (Support)',
            'Auch Daten der eigenen Beschäftigten sind personenbezogen.',
          ),
        ],
        explanation:
            'Personenbezogen sind alle Informationen über identifizierte oder identifizierbare natürliche Personen: Name, persönliche E-Mail-Adresse, Durchwahl, auch die der eigenen Beschäftigten. Angaben über eine GmbH und reine Sachangaben gehören nicht dazu.',
        punkte: 3,
      ),
      freitext(
        'f-a06-agentur-c',
        'ds-grundsaetze',
        scenario:
            'Das Ticketsystem protokolliert jede Anmeldung und jede Änderung an einem Ticket mit Benutzername und Uhrzeit.',
        prompt:
            'Beschreibe zwei Anforderungen des Datenschutzes an solche Protokolle. (4 P.)',
        kriterien: [
          krit(
            'Zweckbindung: Protokolle nur für festgelegte Zwecke wie Sicherheit und Fehlersuche auswerten, nicht zur Leistungs- oder Verhaltenskontrolle',
            punkte: 2,
            stichwoerter: [
              'Zweckbindung',
              'Zweck',
              'Leistungskontrolle',
              'Verhaltenskontrolle',
            ],
          ),
          krit(
            'Datenminimierung: nur protokollieren, was für den Zweck nötig ist',
            punkte: 2,
            stichwoerter: [
              'Datenminimierung',
              'Datensparsamkeit',
              'nur nötige',
              'so wenig wie möglich',
            ],
          ),
          krit(
            'Speicherbegrenzung: Protokolle nach einer festgelegten Frist löschen',
            punkte: 2,
            stichwoerter: [
              'löschen',
              'Löschfrist',
              'Speicherbegrenzung',
              'Speicherdauer',
              'Aufbewahrungsfrist',
            ],
          ),
          krit(
            'Vertraulichkeit: nur wenige Berechtigte dürfen die Protokolle einsehen; die Beschäftigten werden über die Protokollierung informiert',
            punkte: 2,
            stichwoerter: [
              'Zugriff',
              'Berechtigte',
              'informieren',
              'Transparenz',
              'einsehen',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Protokolle enthalten personenbezogene Daten der Beschäftigten und Kunden. Sie dürfen nur für den festgelegten Zweck (Sicherheit, Fehlersuche) ausgewertet werden und nicht zur Leistungskontrolle. Es wird nur das Nötige protokolliert, und die Einträge werden nach einer festgelegten Frist gelöscht. Einsehen dürfen sie nur wenige Berechtigte.',
        explanation:
            'Je Anforderung 2 Punkte, höchstens 4 Punkte. Auch die Nennung eines Grundsatzes mit kurzer Erklärung zählt.$_andere',
      ),
      freitext(
        'f-a06-agentur-d',
        'sm-zugriff',
        prompt:
            'Der Server des Ticketsystems soll vor der Inbetriebnahme gehärtet werden. Nenne vier Maßnahmen zur Härtung. (4 P.)',
        kriterien: [
          krit(
            'Nicht benötigte Dienste abschalten und ungenutzte Ports schließen',
            stichwoerter: [
              'Dienste abschalten',
              'Ports schließen',
              'Dienste deaktivieren',
              'Ports',
            ],
          ),
          krit(
            'Nicht benötigte Software entfernen',
            stichwoerter: [
              'Software entfernen',
              'deinstallieren',
              'unnötige Software',
              'Programme entfernen',
            ],
          ),
          krit(
            'Standardpasswörter ändern, ungenutzte Konten löschen oder sperren',
            stichwoerter: [
              'Standardpasswort',
              'Standardpasswörter',
              'Konten löschen',
              'Konten sperren',
              'Standardkonto',
            ],
          ),
          krit(
            'Rechte auf das Nötige beschränken (Minimalprinzip)',
            stichwoerter: [
              'Minimalprinzip',
              'Rechte minimieren',
              'Least Privilege',
              'geringste Rechte',
            ],
          ),
          krit(
            'Sicherheitsupdates einspielen und automatisch beziehen',
            stichwoerter: [
              'Updates',
              'Patches',
              'aktualisieren',
              'Sicherheitsupdates',
            ],
          ),
          krit(
            'Verschlüsselung und Firewall aktivieren, Zugriffe protokollieren',
            stichwoerter: [
              'Verschlüsselung',
              'Firewall',
              'protokollieren',
              'Logging',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Härtung verkleinert die Angriffsfläche: nicht benötigte Dienste abschalten und Ports schließen, unnötige Software entfernen, Standardpasswörter ändern und ungenutzte Konten löschen, Rechte nach dem Minimalprinzip vergeben, Sicherheitsupdates einspielen, Firewall und Verschlüsselung aktivieren.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 4 Punkte. Stichworte genügen; überzählige Nennungen werden nicht gewertet.',
      ),
      tabelle(
        'f-a06-agentur-e',
        'sm-zugriff',
        scenario:
            'Im Ticketsystem gibt es drei Rollen. Kunden sehen und kommentieren nur ihre eigenen Tickets. Support-Mitarbeitende bearbeiten alle Tickets. Benutzerkonten verwalten ausschließlich die Administratoren.',
        prompt: 'Ergänze die Berechtigungen nach dem Minimalprinzip.',
        zeilen: [
          ['Aktion', 'Kunde', 'Support'],
          [
            'Eigene Tickets kommentieren',
            wahl('erlaubt', ['nicht erlaubt', 'nur für Administratoren']),
            'erlaubt',
          ],
          [
            'Tickets anderer Kunden ansehen',
            wahl('nicht erlaubt', ['erlaubt', 'nur lesend erlaubt']),
            wahl('erlaubt', ['nicht erlaubt', 'nur für Administratoren']),
          ],
          [
            'Benutzerkonten verwalten',
            'nicht erlaubt',
            wahl('nicht erlaubt', ['erlaubt', 'nur lesend erlaubt']),
          ],
        ],
        explanation:
            'Minimalprinzip: Jede Rolle erhält nur die Rechte, die sie für ihre Aufgabe braucht. Kunden sehen nur eigene Tickets, der Support alle. Die Kontenverwaltung bleibt den Administratoren vorbehalten, denn auch der Support braucht sie nicht.',
        punkte: 4,
      ),
      lueckentext(
        'f-a06-agentur-f',
        'kr-hybrid',
        prompt:
            'Das Webportal ist nur über HTTPS erreichbar. Ergänze die Beschreibung des Verbindungsaufbaus.',
        text:
            'Beim Verbindungsaufbau prüft der Browser zuerst das {0} des Servers. Anschließend vereinbaren beide Seiten einen Sitzungsschlüssel. Die Nutzdaten werden damit {1} verschlüsselt, weil dieses Verfahren deutlich {2} ist.',
        luecken: [
          wahl('Zertifikat', ['Passwort', 'Impressum']),
          wahl('symmetrisch', ['asymmetrisch', 'gar nicht']),
          wahl('schneller', ['langsamer', 'unsicherer']),
        ],
        explanation:
            'HTTPS arbeitet hybrid: Das Zertifikat weist die Identität des Servers nach, der Sitzungsschlüssel wird mit asymmetrischer Kryptographie vereinbart, die Nutzdaten laufen danach schnell symmetrisch verschlüsselt.',
        punkte: 3,
      ),
      freitext(
        'f-a06-agentur-g',
        'cm-widerstand',
        scenario:
            'Ein Fachartikel beschreibt, warum Beschäftigte neue Software ablehnen.',
        code:
            'WHY PEOPLE RESIST NEW SOFTWARE\n\nEmployees often resist a new system because they fear\nlosing control over their work. Many worry that they will\nnot be able to learn the new tool quickly enough. Others\nhave had bad experiences with earlier projects. Resistance\nalso grows when staff are informed too late and are not\ninvolved in decisions.',
        prompt:
            'Benenne drei Gründe für Widerstand, die der Text anführt. Antworte auf Deutsch. (3 P.)',
        kriterien: [
          krit(
            'Angst, die Kontrolle über die eigene Arbeit zu verlieren',
            stichwoerter: ['Kontrolle', 'Kontrollverlust', 'Angst'],
          ),
          krit(
            'Sorge, das neue Werkzeug nicht schnell genug zu erlernen',
            stichwoerter: [
              'erlernen',
              'lernen',
              'überfordert',
              'Überforderung',
              'nicht schnell genug',
            ],
          ),
          krit(
            'Schlechte Erfahrungen mit früheren Projekten',
            stichwoerter: [
              'schlechte Erfahrungen',
              'frühere Projekte',
              'Erfahrung',
            ],
          ),
          krit(
            'Zu späte Information und fehlende Beteiligung an Entscheidungen',
            stichwoerter: [
              'zu spät informiert',
              'Beteiligung',
              'nicht einbezogen',
              'Information',
              'Entscheidungen',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Der Text nennt vier Gründe: die Angst, die Kontrolle über die eigene Arbeit zu verlieren; die Sorge, das neue Werkzeug nicht schnell genug zu erlernen; schlechte Erfahrungen mit früheren Projekten; zu späte Information und fehlende Beteiligung an Entscheidungen.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Gewertet wird nur, was im Text steht; eine sinngemäße Wiedergabe genügt.',
        tags: ['englisch'],
      ),
      freitext(
        'f-a06-agentur-h',
        'cm-widerstand',
        scenario:
            'Zwei Wochen nach dem Start beantworten einige Mitarbeitende Kundenanfragen weiter per E-Mail statt im Ticketsystem.',
        prompt:
            'Beschreibe eine Maßnahme, mit der die Agentur die Akzeptanz des Ticketsystems erhöhen kann. (2 P.)',
        kriterien: [
          krit(
            'Schulungen und Hilfen anbieten, damit alle das System sicher bedienen können',
            punkte: 2,
            stichwoerter: [
              'Schulung',
              'Training',
              'einweisen',
              'Anleitung',
              'Hilfe',
            ],
          ),
          krit(
            'Betroffene beteiligen: Rückmeldungen einholen und Abläufe im System gemeinsam anpassen',
            punkte: 2,
            stichwoerter: [
              'beteiligen',
              'einbeziehen',
              'Rückmeldung',
              'Feedback',
              'mitgestalten',
            ],
          ),
          krit(
            'Nutzen und Ziele offen kommunizieren, etwa keine verlorenen Anfragen und Vertretung im Urlaub',
            punkte: 2,
            stichwoerter: [
              'Nutzen',
              'Vorteile',
              'kommunizieren',
              'informieren',
              'erklären',
            ],
          ),
          krit(
            'Ansprechpersonen im Team benennen (Key-User), die bei Fragen helfen',
            punkte: 2,
            stichwoerter: [
              'Key-User',
              'Ansprechperson',
              'Ansprechpartner',
              'Multiplikator',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Die Agentur kann die Mitarbeitenden schulen und ihnen den Nutzen zeigen, zum Beispiel dass keine Anfrage mehr verloren geht und Kolleginnen im Urlaub vertreten werden können. Sinnvoll ist auch, Rückmeldungen einzuholen und das System daraufhin anzupassen: Beteiligung wirkt nachhaltiger als Druck.',
        explanation:
            '2 Punkte für eine beschriebene Maßnahme: Schulung, Beteiligung, offene Kommunikation des Nutzens oder Ansprechpersonen im Team.$_andere',
      ),
    ],
  ),

  // --------------------------------------------------------------- Logistik 1
  fall(
    'f-a06-logistik',
    firma: 'logistik',
    bereich: 'a06',
    titel: 'Kameras und Netz der neuen Lagerhalle',
    situation:
        'Die neue Lagerhalle der Elbtal Logistik AG erhält Netzwerkkameras an den Laderampen und am Hoftor. Die Kameras werden in ein eigenes Netzsegment eingebunden und liefern ihre Bilder an einen Aufzeichnungsserver. Die IT-Abteilung plant die Inbetriebnahme; du arbeitest im Projekt mit.',
    teile: [
      freitext(
        'f-a06-logistik-a',
        'ds-grundsaetze',
        prompt:
            'Nenne drei rechtliche Pflichten, die das Unternehmen bei der Videoüberwachung beachten muss. (3 P.)',
        kriterien: [
          krit(
            'Durch gut sichtbare Schilder auf die Überwachung hinweisen',
            stichwoerter: [
              'Hinweisschild',
              'Schild',
              'hinweisen',
              'Hinweis',
              'kennzeichnen',
            ],
          ),
          krit(
            'Keine Personen im öffentlichen Raum und keine Pausen-, Umkleide- oder Sanitärräume erfassen',
            stichwoerter: [
              'öffentlicher Raum',
              'öffentlichen Raum',
              'Pausenraum',
              'Umkleide',
              'Sanitär',
              'Straße',
            ],
          ),
          krit(
            'Aufnahmen geschützt speichern (Zugriff nur für Berechtigte)',
            stichwoerter: [
              'geschützt',
              'Zugriffsrechte',
              'Berechtigte',
              'verschlüsselt',
              'unbefugt',
            ],
          ),
          krit(
            'Speicherfristen einhalten: Aufnahmen nach kurzer Zeit löschen',
            stichwoerter: [
              'löschen',
              'Speicherfrist',
              'Speicherdauer',
              'Löschfrist',
              '72',
            ],
          ),
          krit(
            'Zweck festlegen und Interessen abwägen; Betriebsrat beteiligen',
            stichwoerter: [
              'Zweck',
              'Interessenabwägung',
              'Betriebsrat',
              'berechtigtes Interesse',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Das Unternehmen muss mit Schildern auf die Überwachung hinweisen, darf keinen öffentlichen Raum und keine Sozialräume erfassen, muss die Aufnahmen vor unbefugtem Zugriff schützen und sie nach kurzer Frist löschen. Der Zweck ist vorab festzulegen, der Betriebsrat zu beteiligen.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 3 Punkte. Stichworte genügen.$_andere',
      ),
      freitext(
        'f-a06-logistik-b',
        'sm-zugriff',
        scenario: 'Das Datenblatt der Kamera enthält folgenden Abschnitt.',
        code:
            'NETWORK CAMERA NC-420 - SECURITY FEATURES\n\n- No default passwords: a password must be set\n  during first setup\n- Encrypted video stream (TLS 1.3)\n- Signed firmware with automatic update check\n- Login is locked for 10 minutes after 5 failed\n  attempts',
        prompt:
            'Beschreibe zwei Konsequenzen, die sich aus der Angabe „No default passwords“ ergeben. (4 P.)',
        kriterien: [
          krit(
            'Bei der Ersteinrichtung muss für jede Kamera ein eigenes Passwort gesetzt werden, das der Passwortrichtlinie entspricht',
            punkte: 2,
            stichwoerter: [
              'eigenes Passwort',
              'Passwort setzen',
              'Passwort vergeben',
              'Ersteinrichtung',
              'festlegen',
            ],
          ),
          krit(
            'Es gibt kein bei allen Geräten gleiches, öffentlich bekanntes Passwort: Angriffe mit Listen von Standardpasswörtern laufen ins Leere',
            punkte: 2,
            stichwoerter: [
              'öffentlich bekannt',
              'bei allen Geräten',
              'Standardpasswort',
              'Listen',
              'nicht dasselbe',
            ],
          ),
          krit(
            'Ohne gesetztes Passwort ist kein Zugang möglich; die Passwörter müssen sicher dokumentiert werden (z. B. Passwortmanager)',
            punkte: 2,
            stichwoerter: [
              'kein Zugang',
              'Passwortmanager',
              'dokumentieren',
              'nicht nutzbar',
              'verwalten',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Die Kamera wird ohne voreingestelltes Passwort ausgeliefert. Erstens muss bei der Ersteinrichtung jeder Kamera ein eigenes, regelkonformes Passwort vergeben werden. Ohne dieses ist kein Zugang möglich. Zweitens teilen sich nicht alle Geräte des Herstellers dasselbe, öffentlich bekannte Passwort; Angreifer können die Kameras nicht mit Listen von Standardpasswörtern übernehmen.',
        explanation: 'Je Konsequenz 2 Punkte, höchstens 4 Punkte.$_andere',
        tags: ['englisch'],
      ),
      markieren(
        'f-a06-logistik-c',
        'sm-wlan',
        mono: true,
        scenario:
            'Die Handscanner der Halle verbinden sich über Access Points mit dem Lagernetz. Ein Dienstleister hat den ersten Access Point eingerichtet.',
        prompt: 'Markiere alle unsicheren Einstellungen.',
        zeilen: [
          ja(
            'Verschlüsselung: WEP',
            'WEP ist seit Jahren gebrochen und in Minuten zu knacken.',
          ),
          nein(
            'SSID:            Halle3-Scanner',
            'Der Netzname ist kein Sicherheitsmerkmal.',
          ),
          ja(
            'Admin-Zugang:    admin / 1234',
            'Triviales Passwort für die Verwaltung.',
          ),
          nein(
            'Verwaltung:      nur per HTTPS aus dem IT-Netz',
            'Verschlüsselt und auf das Verwaltungsnetz beschränkt.',
          ),
          ja(
            'WPS:             aktiviert',
            'Die WPS-PIN lässt sich durchprobieren.',
          ),
          ja(
            'Firmware:        Stand 2021, Updates aus',
            'Bekannte Lücken bleiben offen.',
          ),
          nein(
            'Netz:            eigenes VLAN für Scanner',
            'Trennung vom Verwaltungsnetz ist richtig.',
          ),
        ],
        explanation:
            'Unsicher sind die veraltete Verschlüsselung WEP, das triviale Administratorpasswort, aktiviertes WPS und die veraltete Firmware ohne Updates. Verwaltung per HTTPS aus dem IT-Netz und ein eigenes VLAN sind richtig.',
        punkte: 4,
      ),
      tabelle(
        'f-a06-logistik-d',
        'sm-firewall',
        scenario:
            'Vorgaben für das Kamera-Netz: Die Kameras liefern ihre Bilder per HTTPS an den Aufzeichnungsserver. Die Uhrzeit beziehen sie per NTP vom internen Zeitserver. Verbindungen ins Internet sind den Kameras verboten. Alles nicht ausdrücklich Erlaubte wird verworfen.',
        prompt: 'Ergänze das Regelwerk der Firewall.',
        zeilen: [
          ['Quelle', 'Ziel', 'Port', 'Aktion'],
          [
            'Kamera-Netz',
            'Aufzeichnungsserver',
            wahl('TCP 443', ['TCP 80', 'TCP 23', 'UDP 53'], 'HTTPS'),
            'erlauben',
          ],
          [
            'Kamera-Netz',
            'Zeitserver',
            wahl('UDP 123', ['TCP 25', 'UDP 53', 'TCP 443'], 'NTP'),
            'erlauben',
          ],
          [
            'Kamera-Netz',
            'Internet',
            'alle',
            wahl('verwerfen', ['erlauben', 'umleiten']),
          ],
          [
            'alle',
            'alle',
            'alle',
            wahl('verwerfen', ['erlauben', 'umleiten'], 'Default Deny'),
          ],
        ],
        explanation:
            'HTTPS nutzt TCP 443, NTP nutzt UDP 123. Verbindungen der Kameras ins Internet werden verworfen, ebenso alles, was keine Regel ausdrücklich erlaubt (Default Deny). Je Zelle 1 Punkt.',
        punkte: 4,
      ),
      rechnen(
        'f-a06-logistik-e',
        'sz-schutzziele',
        scenario:
            'Damit Bilder aufgezeichnet werden, müssen der Switch der Halle (Verfügbarkeit 99,9 %) und der Aufzeichnungsserver (Verfügbarkeit 99,0 %) gleichzeitig funktionieren.',
        prompt:
            'Berechne die Gesamtverfügbarkeit der Aufzeichnung in Prozent. Runde auf zwei Nachkommastellen.',
        answer: 98.9,
        tolerance: 0.01,
        unit: '%',
        explanation:
            'Beide Komponenten liegen in Reihe, die Verfügbarkeiten werden multipliziert: 0,999 × 0,990 = 0,98901. Das sind 98,90 %. Die Kette ist schlechter als ihr schwächstes Glied.',
        punkte: 3,
      ),
      freitext(
        'f-a06-logistik-f',
        'ls-verzug',
        scenario:
            'Laut Kaufvertrag sollten die Kameras „in der 38. Kalenderwoche“ geliefert werden. Zwei Wochen später sind sie noch nicht da; der Eröffnungstermin der Halle ist gefährdet.',
        prompt:
            'Beschreibe ein Recht, das die Elbtal Logistik AG als Käuferin wegen des Lieferungsverzugs geltend machen kann. (3 P.)',
        kriterien: [
          krit(
            'Auf Lieferung bestehen und Ersatz des Verzögerungsschadens verlangen, wenn der Verkäufer die Verspätung zu vertreten hat',
            punkte: 3,
            stichwoerter: [
              'Verzögerungsschaden',
              'Verzugsschaden',
              'auf Lieferung bestehen',
              'Lieferung verlangen',
            ],
          ),
          krit(
            'Angemessene Nachfrist setzen und nach deren erfolglosem Ablauf vom Vertrag zurücktreten',
            punkte: 3,
            stichwoerter: ['Rücktritt', 'zurücktreten', 'Nachfrist'],
          ),
          krit(
            'Nach erfolgloser Nachfrist Schadensersatz statt der Leistung verlangen, z. B. Mehrkosten eines Deckungskaufs',
            punkte: 3,
            stichwoerter: ['statt der Leistung', 'Deckungskauf', 'Mehrkosten'],
          ),
        ],
        punkte: 3,
        loesung:
            'Der Liefertermin ist nach dem Kalender bestimmt, der Verkäufer ist deshalb ohne Mahnung in Verzug. Die Käuferin kann eine angemessene Nachfrist setzen. Verstreicht sie erfolglos, kann sie vom Vertrag zurücktreten und die Kameras bei einem anderen Händler kaufen; hat der Verkäufer die Verspätung zu vertreten, kann sie die Mehrkosten als Schadensersatz statt der Leistung verlangen.',
        explanation:
            '3 Punkte für ein Recht mit seiner Voraussetzung: Lieferung und Verzögerungsschaden, Rücktritt nach Nachfrist oder Schadensersatz statt der Leistung nach Nachfrist.',
      ),
      freitext(
        'f-a06-logistik-g',
        'cm-widerstand',
        scenario:
            'In der Belegschaft regt sich Widerstand: Viele befürchten, die Kameras dienten dazu, ihr Arbeitstempo zu überwachen.',
        prompt:
            'Beschreibe zwei Maßnahmen, mit denen die Unternehmensleitung die Akzeptanz der Kameras erhöhen kann. (4 P.)',
        kriterien: [
          krit(
            'Früh und offen informieren: Zweck, erfasste Bereiche, Speicherdauer und Zugriffsberechtigte erklären',
            punkte: 2,
            stichwoerter: [
              'informieren',
              'Information',
              'erklären',
              'Transparenz',
              'offen',
            ],
          ),
          krit(
            'Betriebsrat und Beschäftigte beteiligen, z. B. über eine Betriebsvereinbarung, die Leistungskontrolle ausschließt',
            punkte: 2,
            stichwoerter: [
              'Betriebsrat',
              'Betriebsvereinbarung',
              'beteiligen',
              'einbeziehen',
              'Mitbestimmung',
            ],
          ),
          krit(
            'Überwachung auf das Nötige beschränken: nur Rampen und Tor, keine Arbeitsplätze und Pausenbereiche',
            punkte: 2,
            stichwoerter: [
              'beschränken',
              'nur Rampen',
              'keine Arbeitsplätze',
              'Pausenbereich',
              'begrenzen',
            ],
          ),
          krit(
            'Sorgen ernst nehmen: Gespräche und Fragerunden anbieten, Ansprechperson benennen',
            punkte: 2,
            stichwoerter: [
              'Gespräche',
              'Fragerunde',
              'Ansprechperson',
              'Sorgen',
              'zuhören',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Die Leitung sollte früh und offen informieren, wozu die Kameras dienen, welche Bereiche sie erfassen, wie lange gespeichert wird und wer die Bilder sehen darf. Außerdem sollte sie Betriebsrat und Beschäftigte beteiligen und in einer Betriebsvereinbarung festhalten, dass die Aufnahmen nicht zur Leistungskontrolle genutzt werden.',
        explanation:
            'Je Maßnahme 2 Punkte, höchstens 4 Punkte. Widerstand entsteht hier aus Sorge: Information und Beteiligung wirken besser als Anordnung.$_andere',
      ),
    ],
  ),

  // ------------------------------------------------------------- Systemhaus 2
  fall(
    'f-a06-systemhaus2',
    firma: 'systemhaus',
    bereich: 'a06',
    titel: 'Datenschutz und Datensicherung der Kanzlei',
    situation:
        'Mit dem Umzug in die neuen Büroräume lässt die Steuerkanzlei Albers & Partner ihr Sicherheitskonzept überarbeiten. Bisher wird der Server einmal wöchentlich auf eine zweite Festplatte im selben Gehäuse gesichert. Die Kessler & Brandt IT-Systemhaus GmbH soll Schutzbedarf, Zugriffsschutz und Datensicherung neu planen. Du arbeitest das Konzept mit aus.',
    teile: [
      zuordnen(
        'f-a06-systemhaus2-a',
        'sz-schutzziele',
        prompt:
            'Ordne jede geplante Maßnahme dem Schutzziel zu, das sie in erster Linie unterstützt.',
        buckets: ['Vertraulichkeit', 'Integrität', 'Verfügbarkeit'],
        items: [
          zu(
            'Tägliche Datensicherung auf ein externes Medium',
            2,
            'Nach einem Ausfall sind die Daten wieder nutzbar.',
          ),
          zu(
            'Festplattenverschlüsselung der Notebooks',
            0,
            'Unbefugte können die Daten nicht lesen.',
          ),
          zu(
            'Prüfsummen für archivierte Belege',
            1,
            'Nachträgliche Änderungen fallen auf.',
          ),
          zu(
            'USV für den Server',
            2,
            'Der Server läuft bei Stromausfall weiter.',
          ),
          zu(
            'Zugriffsrechte auf Mandantenordner',
            0,
            'Nur Befugte können die Akten öffnen.',
          ),
        ],
        explanation:
            'Datensicherung und USV halten Daten und Systeme nutzbar (Verfügbarkeit). Verschlüsselung und Zugriffsrechte schützen vor unbefugtem Lesen (Vertraulichkeit). Prüfsummen machen Veränderungen erkennbar (Integrität).',
        punkte: 4,
      ),
      freitext(
        'f-a06-systemhaus2-b',
        'sm-zugriff',
        scenario:
            'Der IT-Grundschutz fordert unter anderem „Autoupdate“ und „Rollentrennung“.',
        prompt:
            'Nenne zu jeder der beiden Anforderungen eine Maßnahme, mit der die Kanzlei sie umsetzt. (2 P.)',
        kriterien: [
          krit(
            'Autoupdate: automatische Updates für Betriebssystem, Anwendungen und Virensignaturen aktivieren',
            stichwoerter: [
              'automatische Updates',
              'Updates aktivieren',
              'Virensignaturen',
              'Autoupdate',
              'Update',
            ],
          ),
          krit(
            'Rollentrennung: Rollen- und Rechtekonzept nach dem Minimalprinzip; Administration nur mit eigenen Admin-Konten',
            stichwoerter: [
              'Rechtekonzept',
              'Rollenkonzept',
              'Admin-Konto',
              'Minimalprinzip',
              'getrennte Konten',
              'Benutzerkonto',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Autoupdate: Auf allen Rechnern werden automatische Updates für Betriebssystem und Virenscanner eingeschaltet. Rollentrennung: Es gibt ein Rechtekonzept nach dem Minimalprinzip; für die tägliche Arbeit nutzen alle ein normales Benutzerkonto, administriert wird nur mit einem getrennten Admin-Konto.',
        explanation: 'Je Maßnahme 1 Punkt. Stichworte genügen.$_andere',
      ),
      tabelle(
        'f-a06-systemhaus2-c',
        'sz-schutzbedarf',
        scenario:
            'Für die Schutzbedarfsfeststellung gelten die Kategorien der Tabelle. Zu den Anwendungen ist bekannt: Ein Bekanntwerden von Mandantenakten würde gegen das Berufsgeheimnis verstoßen und die Existenz der Kanzlei gefährden. Fällt das Lohnprogramm zum Monatsende länger als zwei Tage aus, entsteht ein beträchtlicher Schaden. Fehler auf der Website sind schnell korrigiert und kaum von Bedeutung.',
        table: [
          ['Kategorie', 'Schadensauswirkung'],
          ['normal', 'begrenzt und überschaubar'],
          ['hoch', 'beträchtlich'],
          ['sehr hoch', 'existenzbedrohend'],
        ],
        prompt:
            'Ergänze Kategorie und Begründung. Die erste Zeile dient als Muster.',
        zeilen: [
          ['Anwendung', 'Schutzziel', 'Kategorie', 'Begründung'],
          [
            'Textverarbeitung',
            'Verfügbarkeit',
            'normal',
            'Ausfall überbrückbar, Arbeit nachholbar',
          ],
          [
            'Mandantenakten',
            'Vertraulichkeit',
            wahl('sehr hoch', ['normal', 'hoch']),
            wahl('Bruch des Berufsgeheimnisses', [
              'Löhne würden verspätet gezahlt',
              'Fehler schnell korrigiert',
            ]),
          ],
          [
            'Lohnprogramm',
            'Verfügbarkeit',
            wahl('hoch', ['normal', 'sehr hoch']),
            wahl('Löhne würden verspätet gezahlt', [
              'Bruch des Berufsgeheimnisses',
              'Fehler schnell korrigiert',
            ]),
          ],
          [
            'Website',
            'Integrität',
            wahl('normal', ['hoch', 'sehr hoch']),
            wahl('Fehler schnell korrigiert', [
              'Bruch des Berufsgeheimnisses',
              'Löhne würden verspätet gezahlt',
            ]),
          ],
        ],
        explanation:
            'Der Schutzbedarf richtet sich nach dem möglichen Schaden: Mandantenakten/Vertraulichkeit sehr hoch (Berufsgeheimnis, Existenz gefährdet), Lohnprogramm/Verfügbarkeit hoch (beträchtlicher Schaden bei längerem Ausfall), Website/Integrität normal (Schaden begrenzt). Je Zelle 1 Punkt.',
        punkte: 6,
      ),
      freitext(
        'f-a06-systemhaus2-d',
        'kr-auth',
        prompt:
            'Führe zwei Kriterien für sichere Passwörter an und beschreibe jeweils, wie das Kriterium die Sicherheit erhöht. (4 P.)',
        kriterien: [
          krit(
            'Ausreichende Länge: Die Zahl der möglichen Kombinationen wächst mit jedem Zeichen stark, deshalb dauert Durchprobieren (Brute Force) zu lange',
            punkte: 2,
            stichwoerter: [
              'Länge',
              'lang',
              'Zeichen',
              'Brute Force',
              'Durchprobieren',
            ],
          ),
          krit(
            'Großer Zeichenvorrat (Groß- und Kleinbuchstaben, Ziffern, Sonderzeichen): mehr Möglichkeiten je Stelle',
            punkte: 2,
            stichwoerter: [
              'Zeichenvorrat',
              'Sonderzeichen',
              'Ziffern',
              'Zeichenmix',
              'Großbuchstaben',
            ],
          ),
          krit(
            'Kein persönlicher Bezug und keine Wörterbuchwörter: Wörterbuchangriffe und Erraten scheitern',
            punkte: 2,
            stichwoerter: [
              'Wörterbuch',
              'persönlicher Bezug',
              'erraten',
              'Namen',
              'Geburtsdatum',
            ],
          ),
          krit(
            'Für jeden Zugang ein eigenes Passwort: Ein Datenleck bei einem Dienst gefährdet die anderen Konten nicht',
            punkte: 2,
            stichwoerter: [
              'eigenes Passwort',
              'jeden Dienst',
              'nicht mehrfach',
              'Wiederverwendung',
              'einzigartig',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Länge: Mit jedem zusätzlichen Zeichen vervielfacht sich die Zahl der möglichen Kombinationen, sodass ein Brute-Force-Angriff zu lange dauert. Kein persönlicher Bezug und keine Wörterbuchwörter: Der Angreifer kann das Passwort weder erraten noch mit einem Wörterbuchangriff finden. Weitere Kriterien: großer Zeichenvorrat, für jeden Zugang ein eigenes Passwort.',
        explanation:
            'Je Kriterium 1 Punkt für die Nennung und 1 Punkt für die Wirkung, höchstens 4 Punkte.',
      ),
      freitext(
        'f-a06-systemhaus2-e',
        'sm-backup',
        prompt:
            'Bisher wird nur einmal wöchentlich auf eine zweite Festplatte im Servergehäuse gesichert. Beschreibe zwei Risiken dieses Vorgehens. (2 P.)',
        kriterien: [
          krit(
            'Bis zu sechs Tage Arbeit gehen verloren, weil nur wöchentlich gesichert wird',
            stichwoerter: [
              'sechs Tage',
              'eine Woche',
              'wöchentlich',
              'Datenverlust',
              'zu selten',
            ],
          ),
          krit(
            'Die Sicherung steckt im selben Gerät: Überspannung, Defekt oder Ransomware treffen Original und Sicherung zugleich',
            stichwoerter: [
              'selben Gerät',
              'gleichen Gerät',
              'Überspannung',
              'Ransomware',
              'selben Server',
              'gleichzeitig',
            ],
          ),
          krit(
            'Keine räumliche Trennung: Brand, Wasser oder Diebstahl vernichten beides',
            stichwoerter: [
              'räumlich',
              'Brand',
              'Diebstahl',
              'Wasser',
              'außer Haus',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Erstens gehen im schlimmsten Fall die Daten von bis zu sechs Arbeitstagen verloren. Zweitens liegt die Sicherung im selben Gehäuse wie das Original: Ein Defekt, eine Überspannung, ein Verschlüsselungstrojaner, ein Brand oder ein Diebstahl treffen beide zugleich.',
        explanation: 'Je Risiko 1 Punkt, höchstens 2 Punkte.$_andere',
      ),
      tabelle(
        'f-a06-systemhaus2-f',
        'sm-backup',
        scenario:
            'Neuer Sicherungsplan: Freitagabend eine Vollsicherung mit 300 GB auf ein externes Medium, das außer Haus gelagert wird. Von Montag bis Donnerstag folgt jeden Abend eine differenzielle Sicherung. Täglich ändern sich 20 GB jeweils anderer Dateien.',
        prompt:
            'Ergänze die Größe der differenziellen Sicherungen und die Anzahl der Sicherungen, die bei einem Ausfall am Freitagmorgen zurückgespielt werden müssen.',
        zeilen: [
          ['Sicherung', 'Wert'],
          ['Montag (GB)', '20'],
          [
            'Dienstag (GB)',
            zahl(40, rationale: 'Änderungen von Montag und Dienstag'),
          ],
          ['Mittwoch (GB)', zahl(60)],
          [
            'Donnerstag (GB)',
            zahl(80, rationale: '4 × 20 GB seit der Vollsicherung'),
          ],
          [
            'Sicherungen für die Wiederherstellung',
            zahl(2, rationale: 'Vollsicherung + Donnerstag'),
          ],
        ],
        explanation:
            'Die differenzielle Sicherung enthält alle Änderungen seit der letzten Vollsicherung: 20, 40, 60, 80 GB. Für die Wiederherstellung genügen die Vollsicherung und die letzte differenzielle Sicherung, also 2. Je Zelle 1 Punkt.',
        punkte: 4,
      ),
      rechnen(
        'f-a06-systemhaus2-g',
        'sm-backup',
        prompt:
            'Berechne, wie viel Speicherplatz die Vollsicherung und die vier differenziellen Sicherungen einer Woche zusammen belegen.',
        answer: 500,
        unit: 'GB',
        explanation:
            'Vollsicherung 300 GB + differenzielle Sicherungen 20 + 40 + 60 + 80 = 200 GB. Zusammen 300 GB + 200 GB = 500 GB.',
        punkte: 3,
      ),
    ],
  ),

  // --------------------------------------------------------------- Logistik 2
  fall(
    'f-a06-logistik2',
    firma: 'logistik',
    bereich: 'a06',
    titel: 'Mobile Arbeitsplätze der Disposition',
    situation:
        'Die Disponentinnen und Disponenten der Elbtal Logistik AG erhalten Notebooks, mit denen sie auch von zu Hause und unterwegs arbeiten. Die SSD jedes Notebooks ist verschlüsselt; beim Start wird ein Passwort abgefragt. Die IT-Abteilung legt die Regeln für das mobile Arbeiten fest. Du wirkst an der Richtlinie mit.',
    teile: [
      freitext(
        'f-a06-logistik2-a',
        'ds-grundsaetze',
        scenario:
            'Auf den Notebooks werden auch Schichtpläne mit Namen, Arbeitszeiten und Telefonnummern der Beschäftigten bearbeitet.',
        prompt:
            'Benenne eine Rechtsgrundlage, auf die sich die Verarbeitung dieser Beschäftigtendaten stützt, und begründe deine Antwort. (3 P.)',
        kriterien: [
          krit(
            'Rechtsgrundlage: Erfüllung des Arbeitsvertrags (Art. 6 Abs. 1 lit. b DSGVO); die Nennung von § 26 BDSG wird ebenfalls gewertet',
            stichwoerter: [
              'Arbeitsvertrag',
              'Vertrag',
              'lit. b',
              '§ 26',
              'Beschäftigungsverhältnis',
            ],
          ),
          krit(
            'Begründung: Ohne diese Daten lässt sich der Schichtbetrieb nicht planen. Die Verarbeitung ist für die Durchführung des Arbeitsverhältnisses erforderlich, eine Einwilligung ist nicht nötig',
            punkte: 2,
            stichwoerter: [
              'erforderlich',
              'notwendig',
              'Schichtplanung',
              'keine Einwilligung',
              'Durchführung',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Rechtsgrundlage ist die Erfüllung des Arbeitsvertrags (Art. 6 Abs. 1 lit. b DSGVO). Die Daten sind erforderlich, um den Dreischichtbetrieb zu planen und die Beschäftigten zu erreichen. Eine Einwilligung ist dafür nicht nötig. In Lehrbüchern und älteren Lösungen wird oft § 26 BDSG genannt; ob dessen allgemeine Regel nach einem Urteil des Europäischen Gerichtshofs von 2023 noch anwendbar ist, ist umstritten. Sicher ist die Stütze auf die DSGVO.',
        explanation:
            '1 Punkt für die Rechtsgrundlage, 2 Punkte für die Begründung über die Erforderlichkeit für das Arbeitsverhältnis.',
      ),
      tabelle(
        'f-a06-logistik2-b',
        'ds-tom',
        prompt:
            'Ergänze für jeden Bereich eine geeignete technisch-organisatorische Maßnahme. Die erste Zeile dient als Muster.',
        zeilen: [
          ['Bereich', 'Maßnahme'],
          ['Zutritt zum Arbeitsplatz zu Hause', 'abschließbares Arbeitszimmer'],
          [
            'Sichere Anmeldung',
            wahl('Passwort und Einmalcode', [
              'VPN-Tunnel',
              'Blickschutzfolie',
              'verschlossener Transportbehälter',
            ]),
          ],
          [
            'Sichere Kommunikation mit dem Firmennetz',
            wahl('VPN-Tunnel', [
              'Passwort und Einmalcode',
              'Blickschutzfolie',
              'verschlossener Transportbehälter',
            ]),
          ],
          [
            'Arbeiten in der Bahn',
            wahl('Blickschutzfolie', [
              'VPN-Tunnel',
              'Passwort und Einmalcode',
              'verschlossener Transportbehälter',
            ]),
          ],
          [
            'Transport von Datenträgern',
            wahl('verschlossener Transportbehälter', [
              'VPN-Tunnel',
              'Blickschutzfolie',
              'Passwort und Einmalcode',
            ]),
          ],
        ],
        explanation:
            'Anmeldung: Mehr-Faktor-Authentifizierung. Kommunikation: verschlüsselter VPN-Tunnel. Unterwegs: Blickschutzfolie gegen Mitlesen. Transport: verschlossene Behälter bzw. verschlüsselte Datenträger. Je Zeile 1 Punkt.',
        punkte: 4,
      ),
      freitext(
        'f-a06-logistik2-c',
        'kr-auth',
        prompt:
            'Nenne zwei Kriterien für ein sicheres Passwort zum Entsperren der SSD. (2 P.)',
        kriterien: [
          krit(
            'Ausreichende Länge',
            stichwoerter: ['Länge', 'lang', 'mindestens', 'Zeichen'],
          ),
          krit(
            'Mischung aus Groß- und Kleinbuchstaben, Ziffern und Sonderzeichen',
            stichwoerter: [
              'Sonderzeichen',
              'Ziffern',
              'Zeichenmix',
              'Großbuchstaben',
              'Zeichenvorrat',
            ],
          ),
          krit(
            'Kein Bezug zur Person und kein Wort aus dem Wörterbuch',
            stichwoerter: [
              'Wörterbuch',
              'Personenbezug',
              'Namen',
              'Geburtsdatum',
              'persönlich',
            ],
          ),
          krit(
            'Für jeden Zugang ein eigenes Passwort',
            stichwoerter: [
              'eigenes Passwort',
              'einzigartig',
              'nicht mehrfach',
              'Wiederverwendung',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Ein sicheres Passwort ist lang, mischt verschiedene Zeichenarten, hat keinen Bezug zur Person, ist kein Wörterbuchwort und wird nur für diesen einen Zugang verwendet.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 2 Punkte. Stichworte genügen.',
      ),
      freitext(
        'f-a06-logistik2-d',
        'sz-schutzziele',
        prompt:
            'Beschreibe, was die Schutzziele Vertraulichkeit und Integrität bezogen auf die Daten der verschlüsselten SSD bedeuten. (4 P.)',
        kriterien: [
          krit(
            'Vertraulichkeit: Nur Befugte, die das Passwort kennen, können die Daten auf der SSD lesen',
            punkte: 2,
            stichwoerter: [
              'nur Befugte',
              'lesen',
              'Unbefugte',
              'einsehen',
              'Kenntnis',
            ],
          ),
          krit(
            'Integrität: Die Daten sind vollständig und unverändert; unbefugte Änderungen sind nicht möglich oder werden erkannt',
            punkte: 2,
            stichwoerter: [
              'unverändert',
              'Änderungen',
              'manipuliert',
              'verändert',
              'vollständig',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Vertraulichkeit: Die Daten auf der SSD können nur von Befugten gelesen werden, die das Passwort kennen. Ein Finder oder Dieb sieht nur verschlüsselte Daten. Integrität: Die Daten bleiben vollständig und unverändert; ein Unbefugter kann sie nicht gezielt verändern, ohne dass es auffällt.',
        explanation:
            'Je Schutzziel 2 Punkte: Vertraulichkeit = nur Befugte können lesen, Integrität = unbefugte Änderungen werden verhindert oder erkannt.',
      ),
      freitext(
        'f-a06-logistik2-e',
        'kr-symmetrisch',
        scenario:
            'Einem Disponenten wird das ausgeschaltete Notebook aus dem Auto gestohlen.',
        prompt:
            'Beurteile, wie gut die Daten in diesem Fall durch die Verschlüsselung geschützt sind. (2 P.)',
        kriterien: [
          krit(
            'Ohne das Passwort kann der Dieb die Daten nicht lesen, auch nicht, wenn er die SSD ausbaut',
            stichwoerter: [
              'ohne Passwort',
              'nicht lesen',
              'kein Zugriff',
              'ausbauen',
              'nicht lesbar',
            ],
          ),
          krit(
            'Der Schutz ist nur so gut wie das Passwort: Ein schwaches oder am Gerät notiertes Passwort hebt ihn auf',
            stichwoerter: [
              'schwaches Passwort',
              'Passwortstärke',
              'notiert',
              'so gut wie das Passwort',
              'hängt vom Passwort',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Die Daten sind gut geschützt: Ohne das Passwort lässt sich die SSD nicht entschlüsseln, auch nicht nach dem Ausbau. Der Schutz hängt aber vollständig an der Qualität und Geheimhaltung des Passworts. Klebt es am Gerät oder ist es leicht zu erraten, ist die Verschlüsselung wertlos.',
        explanation:
            '1 Punkt für die Aussage (ohne Passwort kein Zugriff), 1 Punkt für die Einschränkung (Schutz hängt am Passwort).',
      ),
      freitext(
        'f-a06-logistik2-f',
        'sm-firewall',
        prompt:
            'Unterwegs nutzen die Beschäftigten häufig öffentliche WLANs. Beschreibe den Sicherheitsvorteil einer VPN-Verbindung. (2 P.)',
        kriterien: [
          krit(
            'Das VPN baut einen verschlüsselten Tunnel durch das unsichere Netz bis ins Firmennetz auf',
            stichwoerter: ['verschlüsselt', 'Tunnel', 'Verschlüsselung'],
          ),
          krit(
            'Dritte im selben WLAN oder der Betreiber können die übertragenen Daten nicht mitlesen oder verändern',
            stichwoerter: [
              'mitlesen',
              'abhören',
              'nicht einsehbar',
              'abfangen',
              'Dritte',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Ein VPN baut über das öffentliche Netz einen verschlüsselten Tunnel ins Firmennetz auf. Andere Nutzer des WLAN oder dessen Betreiber können die übertragenen Daten weder mitlesen noch unbemerkt verändern.',
        explanation:
            '2 Punkte für den verschlüsselten Tunnel über ein unsicheres Netz und den Schutz vor dem Mitlesen.',
      ),
      reihenfolge(
        'f-a06-logistik2-g',
        'kr-asymmetrisch',
        scenario:
            'Frachtpapiere gehen verschlüsselt per E-Mail an eine Spedition. Eingesetzt wird ein Public-Key-Verfahren.',
        skizze: SequenzDiagramm(
          ['Disposition', 'Spedition'],
          [
            Nachricht(1, 0, 'öffentlicher Schlüssel'),
            Nachricht(0, 1, 'verschlüsselte E-Mail'),
          ],
        ),
        prompt:
            'Bringe die Schritte der asymmetrischen Verschlüsselung in die richtige Reihenfolge.',
        items: [
          'Die Spedition erzeugt ein Schlüsselpaar',
          'Die Spedition übermittelt ihren öffentlichen Schlüssel an die Disposition',
          'Die Disposition verschlüsselt die Frachtpapiere mit dem öffentlichen Schlüssel der Spedition',
          'Die Disposition sendet den Geheimtext',
          'Die Spedition entschlüsselt mit ihrem privaten Schlüssel',
        ],
        explanation:
            'Verschlüsselt wird mit dem öffentlichen Schlüssel des Empfängers (hier der Spedition), entschlüsselt mit dessen privatem Schlüssel. Die Schlüssel der Disposition spielen für die Verschlüsselung keine Rolle.',
        punkte: 4,
      ),
      freitext(
        'f-a06-logistik2-h',
        'sz-schadsoftware',
        scenario:
            'Der Hersteller der Handscanner, die auch die Disposition nutzt, veröffentlicht eine Sicherheitsmeldung.',
        code:
            'SECURITY BULLETIN: HANDHELD SCANNER HS-70\n\nA vulnerability in the Bluetooth module allows attackers\nwithin radio range to take control of the device.\nUpdate the firmware to version 3.1.2 as soon as\npossible. Until then, switch off Bluetooth on all\ndevices. Change the administrator PIN, as the old PIN\nmay have been read out. Remove devices that are no\nlonger supported from the network. Report lost or\nstolen scanners to your IT department immediately.',
        prompt:
            'Nenne vier Maßnahmen, die der Hersteller empfiehlt. Antworte auf Deutsch. (4 P.)',
        kriterien: [
          krit(
            'Firmware so bald wie möglich auf Version 3.1.2 aktualisieren',
            stichwoerter: ['Firmware', 'aktualisieren', 'Update', '3.1.2'],
          ),
          krit(
            'Bis dahin Bluetooth auf allen Geräten abschalten',
            stichwoerter: [
              'Bluetooth',
              'abschalten',
              'ausschalten',
              'deaktivieren',
            ],
          ),
          krit(
            'Administrator-PIN ändern',
            stichwoerter: [
              'PIN ändern',
              'Administrator-PIN',
              'PIN',
              'Admin-PIN',
            ],
          ),
          krit(
            'Nicht mehr unterstützte Geräte aus dem Netz entfernen',
            stichwoerter: [
              'nicht mehr unterstützt',
              'entfernen',
              'alte Geräte',
              'aus dem Netz',
            ],
          ),
          krit(
            'Verlorene oder gestohlene Scanner sofort der IT melden',
            stichwoerter: ['verloren', 'gestohlen', 'melden', 'IT-Abteilung'],
          ),
        ],
        punkte: 4,
        loesung:
            'Der Hersteller empfiehlt: die Firmware so bald wie möglich auf Version 3.1.2 zu aktualisieren, bis dahin Bluetooth abzuschalten, die Administrator-PIN zu ändern, nicht mehr unterstützte Geräte aus dem Netz zu entfernen und verlorene oder gestohlene Scanner sofort der IT-Abteilung zu melden.',
        explanation:
            'Je Nennung 1 Punkt, höchstens 4 Punkte. Der Text enthält fünf Maßnahmen; gewertet wird nur, was im Text steht.',
        tags: ['englisch'],
      ),
    ],
  ),
];
