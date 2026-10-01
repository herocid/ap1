import '../builders.dart';

/// Fallaufgaben (je 25 Punkte) zu Bereich 03 für die Prüfungssimulation.
///
/// Je Modellunternehmen zwei Fälle: `f-a03h-*` mit Schwerpunkt Hardware,
/// Beschaffung und Arbeitsplatz, `f-a03n-*` mit Schwerpunkt Netzwerk und
/// Betrieb. Aufbau, Operatoren und Punkte folgen den Prüfungen 2025/2026.
final List<ExamCase> casesA03 = [
  // ================================================================ Systemhaus
  fall(
    'f-a03h-systemhaus',
    firma: 'systemhaus',
    bereich: 'a03',
    titel: 'Multifunktionsgerät auswählen und anschließen',
    situation:
        'Die Steuerkanzlei Albers & Partner braucht für die neuen Büroräume ein Multifunktionsgerät zum Drucken und Scannen. Monatlich fallen etwa 1.500 Schwarzweiß- und 400 Farbseiten an. Drei Geräte stehen zur Auswahl; du bereitest die Entscheidung vor und bindest das Gerät anschließend ins Netz ein.',
    teile: [
      tabelle(
        'f-a03h-systemhaus-a',
        'h-schnittstellen',
        scenario:
            'Die Geräte werden mit einer Entscheidungsmatrix verglichen: Je Kriterium erhält das beste Gerät Rang 3, das schlechteste Rang 1. Das Gerät mit der höchsten Summe wird gewählt.',
        table: [
          ['Kriterium', 'Gerät A', 'Gerät B', 'Gerät C'],
          ['Drucken (Seiten/min)', '35', '50', '42'],
          ['Scannen (Seiten/min)', '30', '45', '60'],
          ['Wartung (€/Monat)', '18', '12', '25'],
          ['Preis (€)', '1.980', '2.640', '2.250'],
        ],
        prompt: 'Vervollständige die Entscheidungsmatrix und bilde die Summen.',
        zeilen: [
          ['Kriterium', 'Gerät A', 'Gerät B', 'Gerät C'],
          ['Drucken', '1', '3', '2'],
          ['Scannen', zahl(1), zahl(2), zahl(3)],
          ['Wartung', zahl(2), zahl(3), zahl(1)],
          ['Preis', zahl(3), zahl(1), zahl(2)],
          ['Summe', zahl(7), zahl(9), zahl(8)],
        ],
        punkte: 6,
        explanation:
            'Bei Tempo ist der größte Wert der beste, bei Wartung und Preis der kleinste. Scannen: C 3, B 2, A 1. Wartung: B 3, A 2, C 1. Preis: A 3, C 2, B 1. Summen: A 7, B 9, C 8 - gewählt wird Gerät B.',
      ),
      rechnen(
        'f-a03h-systemhaus-b',
        'h-schnittstellen',
        scenario:
            'Gerät B (2.640 €, Wartung 12 € im Monat) wird gekauft und 48 Monate genutzt. Eine Schwarzweißseite kostet 0,04 €, eine Farbseite 0,09 €.',
        prompt:
            'Berechne die gesamten Kosten pro Monat in Euro: Anschaffung, Druck und Wartung.',
        answer: 163,
        unit: '€',
        punkte: 3,
        explanation:
            'Anschaffung: 2.640 € / 48 = 55 €. Druck: 1.500 × 0,04 € + 400 × 0,09 € = 60 € + 36 € = 96 €. Wartung: 12 €. Summe: 55 € + 96 € + 12 € = 163 € pro Monat.',
      ),
      paare(
        'f-a03h-systemhaus-c',
        'h-schnittstellen',
        scenario:
            'An der Rückseite des Geräts sitzen vier Buchsen. Das Handbuch beschreibt sie nur in Worten.',
        prompt: 'Ordne jeder Beschreibung den Namen des Anschlusses zu.',
        paare: [
          paar('achtpolige Buchse mit Rastnase', 'RJ45'),
          paar('flache, rechteckige Buchse', 'USB-A'),
          paar('kleine ovale Buchse, verdrehsicher', 'USB-C'),
          paar('dreipolige Buchse fürs Netzkabel', 'Kaltgerätebuchse'),
        ],
        punkte: 4,
        explanation:
            'RJ45 nimmt das Netzwerkkabel auf, USB-A und USB-C dienen dem direkten Anschluss an einen PC oder einem USB-Stick, in die Kaltgerätebuchse kommt das 230-V-Netzkabel. Je Zuordnung 1 Punkt.',
      ),
      lueckentext(
        'f-a03h-systemhaus-d',
        'nw-ipv4',
        scenario:
            'Das Gerät kommt ins Netz 192.168.40.0/26. Der Router hat als Gateway die letzte nutzbare Adresse des Netzes, das Multifunktionsgerät (MFG) soll die vorletzte nutzbare Adresse erhalten.',
        skizze: const NetzSkizze(
          [
            NetzKnoten('rt', 'Router', NetzTyp.router, 1.5, 0),
            NetzKnoten('sw', 'Switch', NetzTyp.switch_, 1.5, 1.5),
            NetzKnoten('pc', 'PC .21', NetzTyp.pc, 0.5, 3),
            NetzKnoten('mf', 'MFG', NetzTyp.drucker, 2.5, 3),
          ],
          verbindungen: [
            NetzVerbindung('rt', 'sw'),
            NetzVerbindung('sw', 'pc'),
            NetzVerbindung('sw', 'mf'),
          ],
        ),
        prompt: 'Trage die IPv4-Konfiguration des Geräts ein.',
        text:
            'IP-Adresse: {0}\n'
            'Subnetzmaske: {1}\n'
            'Standardgateway: {2}',
        luecken: [
          wort(['192.168.40.61'], 'Broadcast .63, letzte .62, vorletzte .61'),
          wort(['255.255.255.192'], '/26'),
          wort(['192.168.40.62'], 'letzte nutzbare Adresse'),
        ],
        punkte: 3,
        explanation:
            '/26 = 64 Adressen: Netz 192.168.40.0, Broadcast 192.168.40.63. Letzte nutzbare Adresse .62 (Gateway), vorletzte .61 (Gerät). Maske 255.255.255.192.',
      ),
      freitext(
        'f-a03h-systemhaus-e',
        'b-haertung',
        code:
            'Security notes for your new device\n'
            'Change the default administrator\n'
            'password before first use. Install\n'
            'firmware updates regularly or enable\n'
            'automatic updates. Disable network\n'
            'services you do not need, such as FTP\n'
            'or Telnet. Enable the built-in firewall\n'
            'and allow printing only from your own\n'
            'network. Erase the internal storage\n'
            'before you dispose of the device.',
        prompt:
            'Nenne vier Sicherheitsmaßnahmen, die der Hersteller im Text empfiehlt.',
        kriterien: [
          krit(
            'Standardpasswort des Administrators vor der ersten Nutzung ändern',
            stichwoerter: ['Passwort', 'Kennwort', 'Standardpasswort'],
          ),
          krit(
            'Firmware regelmäßig oder automatisch aktualisieren',
            stichwoerter: ['Firmware', 'Update', 'aktualisieren'],
          ),
          krit(
            'Nicht benötigte Netzwerkdienste wie FTP oder Telnet abschalten',
            stichwoerter: ['Dienste', 'FTP', 'Telnet', 'abschalten'],
          ),
          krit(
            'Eingebaute Firewall aktivieren, Drucken nur aus dem eigenen Netz zulassen',
            stichwoerter: ['Firewall', 'eigenes Netz', 'eigenen Netz'],
          ),
          krit(
            'Internen Speicher vor der Entsorgung löschen',
            stichwoerter: ['Speicher löschen', 'löschen', 'Entsorgung'],
          ),
        ],
        punkte: 4,
        loesung:
            'Das Standardpasswort des Administrators ändern, Firmware-Updates regelmäßig oder automatisch einspielen, nicht benötigte Dienste wie FTP und Telnet abschalten, die eingebaute Firewall aktivieren und nur das eigene Netz zulassen, vor der Entsorgung den internen Speicher löschen.',
        explanation:
            'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte. Der Text enthält fünf Maßnahmen; es zählen nur Maßnahmen, die im Text stehen.',
        tags: ['englisch'],
      ),
      freitext(
        'f-a03h-systemhaus-f',
        'b-rechte',
        scenario:
            'Ein Partner der Kanzlei schlägt vor, allen Beschäftigten das Administratorkonto des Geräts und ihrer PCs zu geben, damit sie Einstellungen selbst ändern können.',
        prompt:
            'Erläutere einen Grund, warum nicht alle Beschäftigten Administratorrechte erhalten sollten.',
        kriterien: [
          krit(
            'Schadsoftware läuft mit den Rechten des Benutzers und könnte sich mit Adminrechten im ganzen System einnisten',
            punkte: 3,
            stichwoerter: ['Schadsoftware', 'Malware', 'Virus', 'Trojaner'],
          ),
          krit(
            'Benutzer könnten versehentlich oder absichtlich Einstellungen ändern oder Schutzfunktionen abschalten',
            punkte: 3,
            stichwoerter: [
              'Einstellungen',
              'versehentlich',
              'abschalten',
              'Fehlbedienung',
            ],
          ),
          krit(
            'Vertrauliche Mandantendaten (z. B. gespeicherte Scans) wären für alle einsehbar',
            punkte: 3,
            stichwoerter: [
              'vertraulich',
              'Mandantendaten',
              'einsehbar',
              'Scans',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Nach dem Prinzip der minimalen Rechte bekommt jeder nur die Rechte, die er für seine Arbeit braucht. Öffnet ein Benutzer mit Administratorrechten versehentlich Schadsoftware, kann sie sich im ganzen System installieren und Schutzfunktionen abschalten. Mit eingeschränkten Rechten bleibt der Schaden begrenzt.',
        explanation:
            'Bewertung: Grund plus Folge ergeben 3 Punkte. Ein erläuterter Grund genügt.',
      ),
      freitext(
        'f-a03h-systemhaus-g',
        'nw-geraete',
        scenario:
            'Das Gerät kann per Netzwerkkabel oder per WLAN angebunden werden.',
        prompt:
            'Nenne zwei Vorteile des Anschlusses per Netzwerkkabel gegenüber WLAN.',
        kriterien: [
          krit(
            'stabilere Verbindung ohne Funkstörungen',
            stichwoerter: ['stabil', 'zuverlässig', 'Störung', 'störungsfrei'],
          ),
          krit(
            'höhere und gleichbleibende Datenrate, wichtig bei großen Scans',
            stichwoerter: ['Datenrate', 'schneller', 'Geschwindigkeit'],
          ),
          krit(
            'sicherer, weil kein Funksignal mitgeschnitten werden kann',
            stichwoerter: ['sicherer', 'abhören', 'Sicherheit', 'mitschneiden'],
          ),
          krit(
            'kein WLAN-Kennwort im Gerät nötig, einfachere Einrichtung',
            stichwoerter: ['Kennwort', 'Einrichtung', 'einfacher'],
          ),
        ],
        punkte: 2,
        loesung:
            'Die Kabelverbindung ist stabiler und schneller als WLAN, weil sie nicht von Funkstörungen oder der Entfernung zum Access Point abhängt. Außerdem ist sie sicherer, da kein Funksignal abgehört werden kann.',
        explanation:
            'Bewertung: je Nennung 1 Punkt, höchstens 2 Punkte. Andere fachlich richtige Vorteile zählen ebenfalls.',
      ),
    ],
  ),
  fall(
    'f-a03n-systemhaus',
    firma: 'systemhaus',
    bereich: 'a03',
    titel: 'Kanzleinetz adressieren und Fehler suchen',
    situation:
        'In den neuen Räumen der Steuerkanzlei Albers & Partner ist die Verkabelung fertig. Du nimmst die Arbeitsplätze in Betrieb, dokumentierst die Adressierung und gehst den ersten Störungsmeldungen nach. Der Internetanbieter der Kanzlei stellt neben IPv4 auch IPv6 bereit.',
    teile: [
      lueckentext(
        'f-a03n-systemhaus-a',
        'nw-ipv4',
        scenario:
            'Der Dateiserver der Kanzlei hat die Adresse 192.168.75.140/25.',
        prompt: 'Ermittle die Werte des Subnetzes.',
        text:
            'Subnetzmaske: {0}\n'
            'Nutzbare Hostadressen: {1}\n'
            'Netzadresse: {2}\n'
            'Broadcastadresse: {3}',
        luecken: [
          wort(['255.255.255.128'], '/25 = 24 + 1 Bit'),
          zahl(126, rationale: '2⁷ - 2'),
          wort(['192.168.75.128'], '140 liegt im oberen Block 128 bis 255'),
          wort(['192.168.75.255'], 'letzte Adresse des Blocks'),
        ],
        punkte: 4,
        explanation:
            '/25: Maske 255.255.255.128, Blockgröße 128, 2⁷ - 2 = 126 nutzbare Adressen. Die 140 liegt im oberen Teilnetz: Netz 192.168.75.128, Broadcast 192.168.75.255. Je Wert 1 Punkt.',
      ),
      tabelle(
        'f-a03n-systemhaus-b',
        'nw-dienste',
        scenario:
            'Vier Arbeitsplätze melden „kein Netz“. Für jede vermutete Ursache soll festgelegt werden, wie sie überprüft und wie der Fehler behoben wird.',
        prompt:
            'Gib zu jeder vermuteten Ursache eine Überprüfung und eine Behebung an.',
        zeilen: [
          ['Vermutete Ursache', 'Überprüfung', 'Behebung'],
          [
            'Patchkabel am PC defekt',
            wahl('Link-LED an der Netzwerkkarte prüfen', [
              'nslookup aufrufen',
              'DNS-Cache leeren',
            ]),
            wahl('Kabel tauschen', ['DNS-Server eintragen', 'Gateway ändern']),
          ],
          [
            'Falsche IP-Adresse eingetragen',
            wahl('ipconfig aufrufen und Werte vergleichen', [
              'Link-LED prüfen',
              'Kabeltester anschließen',
            ]),
            wahl('richtige Adresse zuweisen', [
              'Kabel tauschen',
              'Dose patchen lassen',
            ]),
          ],
          [
            'Netzwerkdose nicht gepatcht',
            wahl('funktionierendes Gerät an die Dose hängen', [
              'ipconfig /flushdns',
              'nslookup aufrufen',
            ]),
            wahl('Dose patchen lassen', [
              'Treiber neu installieren',
              'DNS-Server prüfen',
            ]),
          ],
          [
            'Namensauflösung gestört',
            wahl('ping auf einen Namen, nslookup', [
              'Link-LED prüfen',
              'Kabeltester anschließen',
            ]),
            wahl('DNS-Server prüfen', [
              'Kabel tauschen',
              'Dose patchen lassen',
            ]),
          ],
        ],
        punkte: 8,
        explanation:
            'Kabel: Link-LED prüfen, Kabel tauschen. Adresse: mit ipconfig prüfen, richtige Adresse zuweisen. Dose: mit funktionierendem Gerät oder Tester prüfen, patchen lassen. DNS: ping auf den Namen und nslookup, dann den DNS-Server prüfen. Je Zelle 1 Punkt.',
        tags: ['fehlersuche'],
      ),
      freitext(
        'f-a03n-systemhaus-c',
        'nw-ipv6',
        scenario:
            'Ein Partner der Kanzlei möchte wissen, was IPv6 von IPv4 unterscheidet.',
        prompt: 'Beschreibe zwei Unterschiede zwischen IPv4 und IPv6.',
        kriterien: [
          krit(
            'Adresslänge: 32 Bit gegenüber 128 Bit, dadurch ein viel größerer Adressraum',
            punkte: 2,
            stichwoerter: ['32 Bit', '128 Bit', 'Adressraum', 'mehr Adressen'],
          ),
          krit(
            'Schreibweise: dezimal mit Punkten gegenüber hexadezimal mit Doppelpunkten',
            punkte: 2,
            stichwoerter: [
              'hexadezimal',
              'dezimal',
              'Doppelpunkt',
              'Schreibweise',
            ],
          ),
          krit(
            'Konfiguration: von Hand oder per DHCP gegenüber Selbstkonfiguration (SLAAC)',
            punkte: 2,
            stichwoerter: ['SLAAC', 'Autokonfiguration', 'Selbstkonfiguration'],
          ),
          krit(
            'IPv6 kennt keinen Broadcast und braucht kein NAT',
            punkte: 2,
            stichwoerter: ['Broadcast', 'NAT', 'Multicast', 'NDP'],
          ),
        ],
        punkte: 4,
        loesung:
            'IPv4-Adressen haben 32 Bit und werden dezimal mit Punkten geschrieben; IPv6-Adressen haben 128 Bit und werden hexadezimal mit Doppelpunkten geschrieben - der Adressraum ist um ein Vielfaches größer. IPv6-Geräte können sich außerdem per SLAAC selbst konfigurieren.',
        explanation:
            'Bewertung: 2 Punkte je beschriebenem Unterschied, höchstens 4 Punkte.',
      ),
      freitext(
        'f-a03n-systemhaus-d',
        'nw-ipv6',
        scenario:
            'Die Kanzleisoftware auf dem Server beherrscht nur IPv4, die neuen Arbeitsplätze sollen aber auch IPv6 nutzen.',
        prompt:
            'Erläutere eine Möglichkeit, IPv4 und IPv6 im Netz der Kanzlei gemeinsam zu betreiben.',
        kriterien: [
          krit(
            'Dual Stack: Geräte und Router erhalten eine IPv4- und eine IPv6-Adresse und nutzen je nach Ziel das passende Protokoll',
            punkte: 3,
            stichwoerter: [
              'Dual Stack',
              'Dual-Stack',
              'beide Adressen',
              'beide Protokolle',
              'parallel',
            ],
          ),
          krit(
            'Tunneling: IPv6-Pakete werden in IPv4-Pakete gekapselt und durch das IPv4-Netz transportiert (z. B. 6to4)',
            punkte: 3,
            stichwoerter: [
              'Tunnel',
              'Tunneling',
              '6to4',
              'gekapselt',
              'verpackt',
            ],
          ),
        ],
        punkte: 3,
        loesung:
            'Dual Stack: Arbeitsplätze, Router und - soweit möglich - Server erhalten sowohl eine IPv4- als auch eine IPv6-Adresse. Die Kanzleisoftware wird weiter über IPv4 angesprochen, Ziele mit IPv6 über IPv6. Alternativ Tunneling: IPv6-Pakete werden in IPv4-Pakete verpackt und am Tunnelende wieder ausgepackt.',
        explanation:
            'Bewertung: Eine erläuterte Möglichkeit ergibt 3 Punkte - Dual Stack oder Tunneling.',
      ),
      freitext(
        'f-a03n-systemhaus-e',
        'nw-ipv4',
        scenario:
            'Die Arbeitsplätze haben Adressen aus dem Bereich 192.168.75.x. Ein Mandant fragt, ob diese PCs aus dem Internet direkt angesprochen werden können.',
        prompt:
            'Beschreibe, warum die PCs der Kanzlei nicht direkt aus dem Internet erreichbar sind.',
        kriterien: [
          krit(
            'Es sind private IPv4-Adressen (Bereich 192.168.0.0/16)',
            stichwoerter: ['private', 'privat', '192.168.0.0'],
          ),
          krit(
            'Private Adressen werden im Internet nicht geroutet; nach außen tritt nur die öffentliche Adresse des Routers auf (NAT)',
            stichwoerter: [
              'nicht geroutet',
              'NAT',
              'öffentliche Adresse',
              'nicht weitergeleitet',
            ],
          ),
        ],
        loesung:
            'Die PCs haben private IPv4-Adressen. Solche Adressen werden im Internet nicht geroutet. Ins Internet gelangen die PCs über den Router, der ihre Adresse per NAT durch seine öffentliche ersetzt - von außen sind sie deshalb nicht direkt erreichbar.',
        punkte: 2,
        explanation:
            'Bewertung: 1 Punkt für „private Adressen“, 1 Punkt für „werden im Internet nicht geroutet“.',
      ),
      markieren(
        'f-a03n-systemhaus-f',
        'b-cli',
        scenario:
            'Die Kanzleisoftware reagiert an einem Arbeitsplatz sehr träge. Du pingst vom PC aus drei Ziele im eigenen Netz.',
        prompt: 'Markiere die beiden auffälligen Zeilen der Auswertung.',
        mono: true,
        zeilen: [
          nein('Gateway:  Mittelwert 1ms, 0% Verlust', 'Im LAN normal.'),
          nein('Drucker:  Mittelwert 2ms, 0% Verlust', 'Im LAN normal.'),
          ja(
            'Server:   Mittelwert 438ms',
            'Im eigenen LAN sind wenige Millisekunden üblich.',
          ),
          ja(
            'Server:   25% Verlust',
            'Jedes vierte Paket bleibt unbeantwortet.',
          ),
          nein('Server:   TTL=64', 'Die TTL ist unauffällig.'),
        ],
        punkte: 2,
        explanation:
            'Gateway und Drucker antworten schnell und verlustfrei. Nur beim Server fallen die hohe Antwortzeit von 438 ms und 25 % Paketverlust auf - die Strecke zum Server ist gestört.',
      ),
      freitext(
        'f-a03n-systemhaus-g',
        'b-cli',
        scenario:
            'Der Server antwortet im Mittel erst nach 438 ms, ein Viertel der Pakete geht verloren.',
        prompt:
            'Beschreibe ein Problem, das sich daraus für die Arbeit mit der Kanzleisoftware ergibt.',
        kriterien: [
          krit(
            'Die Software reagiert verzögert: Masken und Dokumente laden langsam',
            punkte: 2,
            stichwoerter: ['verzögert', 'langsam', 'träge', 'Wartezeit'],
          ),
          krit(
            'Zeitüberschreitungen führen zu Fehlermeldungen oder Verbindungsabbrüchen, Eingaben können verloren gehen',
            punkte: 2,
            stichwoerter: [
              'Abbruch',
              'Abbrüche',
              'Timeout',
              'Zeitüberschreitung',
              'Fehlermeldung',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Durch die hohe Antwortzeit und die verlorenen Pakete, die erneut gesendet werden müssen, reagiert die Kanzleisoftware stark verzögert. Bei Zeitüberschreitungen bricht die Verbindung zum Server ab, und nicht gespeicherte Eingaben können verloren gehen.',
        explanation: 'Bewertung: Ein beschriebenes Problem ergibt 2 Punkte.',
      ),
    ],
  ),

  // ==================================================================== Handel
  fall(
    'f-a03h-handel',
    firma: 'handel',
    bereich: 'a03',
    titel: 'Kartenterminals für die Filiale Göttingen einrichten',
    situation:
        'In der neuen Filiale Göttingen der Grünwerk Gartenbedarf GmbH werden vier Kassenplätze aufgebaut. Jede Kasse erhält ein Kartenterminal, das der Lieferant mit englischem Datenblatt ausliefert. Du beschaffst die Terminals, schließt sie an und nimmst sie ins Filialnetz 10.44.2.0/24 auf.',
    teile: [
      tabelle(
        'f-a03h-handel-a',
        'h-schnittstellen',
        code:
            'Payment Terminal PT-40 - Technical Data\n'
            'Display:      5 inch touch screen\n'
            'Connectivity: Ethernet (RJ45), Wi-Fi,\n'
            '              USB-C\n'
            'Power supply: 12 V / 2 A adapter\n'
            '              (included)\n'
            'Alternative:  power via USB, 5 V\n'
            'Firmware:     update before first use',
        prompt: 'Ergänze die Tabelle anhand des Datenblatts.',
        zeilen: [
          ['Merkmal', 'Wert'],
          [
            'Anschluss für das Netzwerkkabel',
            wahl('RJ45', ['USB-C', 'Wi-Fi', 'HDMI']),
          ],
          ['Spannung des Netzteils in V', zahl(12)],
          ['Strom des Netzteils in A', zahl(2)],
          ['Spannung bei Versorgung über USB in V', zahl(5)],
          [
            'Vor der ersten Nutzung nötig',
            wahl('Firmware aktualisieren', [
              'Display tauschen',
              'WLAN abschalten',
            ]),
          ],
        ],
        punkte: 5,
        explanation:
            '„Ethernet (RJ45)“ ist der kabelgebundene Netzwerkanschluss. Das Netzteil liefert 12 V und 2 A; alternativ kann das Terminal mit 5 V über USB versorgt werden. „Update before first use“: Die Firmware wird vor der Inbetriebnahme aktualisiert.',
        tags: ['englisch', 'datenblatt'],
      ),
      lueckentext(
        'f-a03h-handel-b',
        'h-usv',
        scenario:
            'An den Kassen fehlen Steckdosen. Deshalb soll das Terminal statt über das Netzteil (12 V / 2 A) über einen USB-Port des Kassen-PCs (5 V) versorgt werden. Es gilt P = U × I.',
        prompt:
            'Ermittle die Leistung des Terminals und den Strom, den der USB-Port liefern müsste.',
        text:
            'Leistung des Terminals: {0} W\n'
            'Nötiger Strom am USB-Port: {1} A',
        luecken: [
          zahl(24, rationale: 'P = 12 V × 2 A'),
          zahl(4.8, toleranz: 0.001, rationale: 'I = 24 W / 5 V'),
        ],
        punkte: 4,
        explanation:
            'Leistung: P = U × I = 12 V × 2 A = 24 W. Strom bei 5 V: I = P / U = 24 W / 5 V = 4,8 A. Je Wert 2 Punkte.',
      ),
      freitext(
        'f-a03h-handel-c',
        'h-schnittstellen',
        scenario:
            'Am Kassen-PC hängen bereits Scanner, Bondrucker und Kundendisplay per USB. Rechnerisch braucht das Terminal bei 5 V einen Strom von 4,8 A. Im Test fällt das über USB versorgte Terminal immer wieder aus.',
        prompt:
            'Begründe, warum die Versorgung über den USB-Port zu Störungen führt, und gib eine Empfehlung.',
        kriterien: [
          krit(
            'Ein USB-Port liefert deutlich weniger als 4,8 A (USB-A 0,5 bis 0,9 A, USB-C ohne Power Delivery bis 3 A)',
            stichwoerter: [
              '0,9 A',
              '0,5 A',
              '3 A',
              'zu wenig Strom',
              'liefert nicht',
            ],
          ),
          krit(
            'Folge: Unterversorgung - das Terminal startet neu oder fällt aus; weitere USB-Geräte verschärfen das',
            stichwoerter: [
              'instabil',
              'Unterversorgung',
              'Neustart',
              'fällt aus',
              'überlastet',
            ],
          ),
          krit(
            'Empfehlung: das mitgelieferte Netzteil verwenden (ggf. Steckdosen nachrüsten)',
            stichwoerter: ['Netzteil', 'Steckdose', 'eigene Stromversorgung'],
          ),
        ],
        loesung:
            'Das Terminal braucht bei 5 V rund 4,8 A. Ein USB-A-Port liefert nur 0,5 bis 0,9 A, selbst USB-C ohne Power Delivery höchstens 3 A - und am Kassen-PC hängen weitere USB-Geräte. Das Terminal ist unterversorgt, startet neu oder fällt aus. Empfehlung: das mitgelieferte Netzteil nutzen und dafür Steckdosen nachrüsten.',
        punkte: 3,
        explanation:
            'Bewertung: 2 Punkte für die Begründung (Port liefert zu wenig, Versorgung instabil), 1 Punkt für die Empfehlung.',
      ),
      freitext(
        'f-a03h-handel-d',
        'b-haertung',
        scenario:
            'Laut Datenblatt soll vor der ersten Nutzung ein Softwareupdate eingespielt werden.',
        prompt:
            'Beschreibe einen Grund, warum das Update vor der Inbetriebnahme sinnvoll ist.',
        kriterien: [
          krit(
            'Bekannte Sicherheitslücken werden geschlossen, das Gerät ist besser gegen Angriffe geschützt',
            punkte: 2,
            stichwoerter: [
              'Sicherheitslücke',
              'Schwachstelle',
              'Angriff',
              'Sicherheit',
            ],
          ),
          krit(
            'Fehler der ausgelieferten Version werden behoben',
            punkte: 2,
            stichwoerter: ['Fehler', 'Bug', 'behoben', 'Fehlerbehebung'],
          ),
          krit(
            'Das Gerät wird an aktuelle Anforderungen angepasst (z. B. neue Kartenarten, Vorgaben der Zahlungsdienste)',
            punkte: 2,
            stichwoerter: [
              'aktuelle Anforderungen',
              'neue Funktionen',
              'Vorgaben',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Zwischen Herstellung und Auslieferung können Sicherheitslücken bekannt geworden sein. Das Update schließt sie, bevor über das Terminal Zahlungsdaten laufen. Außerdem behebt es Fehler der ausgelieferten Version.',
        explanation: 'Bewertung: Ein beschriebener Grund ergibt 2 Punkte.',
      ),
      lueckentext(
        'f-a03h-handel-e',
        'nw-ipv4',
        scenario:
            'Das Terminal der Kasse 1 erhält eine feste Adresse: die letzte mögliche Hostadresse des Filialnetzes 10.44.2.0/24.',
        skizze: const NetzSkizze(
          [
            NetzKnoten('rt', 'Router .1', NetzTyp.router, 1.5, 0),
            NetzKnoten('sw', 'Switch', NetzTyp.switch_, 1.5, 1.5),
            NetzKnoten('pc', 'Kasse .20', NetzTyp.pc, 0.5, 3),
            NetzKnoten('kt', 'Terminal', NetzTyp.smartphone, 2.5, 3),
          ],
          verbindungen: [
            NetzVerbindung('rt', 'sw'),
            NetzVerbindung('sw', 'pc'),
            NetzVerbindung('sw', 'kt'),
          ],
        ),
        prompt: 'Trage die IPv4-Konfiguration des Terminals ein.',
        text:
            'IP-Adresse: {0}\n'
            'Subnetzmaske: {1}\n'
            'Standardgateway: {2}',
        luecken: [
          wort(['10.44.2.254'], 'Broadcast ist .255, letzte Hostadresse .254'),
          wort(['255.255.255.0'], '/24'),
          wort(['10.44.2.1'], 'die Adresse des Routers'),
        ],
        punkte: 3,
        explanation:
            '/24: Maske 255.255.255.0, Hostadressen .1 bis .254, Broadcast .255. Letzte mögliche Adresse 10.44.2.254; Gateway ist der Router mit 10.44.2.1. Je Wert 1 Punkt.',
      ),
      freitext(
        'f-a03h-handel-f',
        'nw-geraete',
        scenario:
            'An Kasse 1 gibt es die Netzwerkdosen 1 bis 4. Das Terminal wird an Dose 3 angeschlossen und bekommt keine Verbindung. Im Verteilerschrank ergibt sich folgendes Bild.',
        table: [
          ['Patchfeld-Port', 'Patchkabel zum Switch'],
          ['1', 'gesteckt'],
          ['2', 'gesteckt'],
          ['3', 'nicht gesteckt'],
          ['4', 'nicht gesteckt'],
        ],
        prompt:
            'Gib an, an welchen Dosen das Terminal funktioniert, und begründe deine Antwort.',
        kriterien: [
          krit(
            'Nur an Dose 1 oder 2',
            stichwoerter: ['Dose 1', 'Dose 2', '1 oder 2', '1 und 2'],
          ),
          krit(
            'Die Ports 3 und 4 sind am Patchfeld nicht mit dem Switch verbunden (nicht gepatcht), die Dosen haben keine Verbindung ins Netz',
            punkte: 2,
            stichwoerter: [
              'nicht gepatcht',
              'nicht mit dem Switch verbunden',
              'kein Patchkabel',
              'nicht verbunden',
            ],
          ),
          krit(
            'Alternativ: Port 3 mit einem Patchkabel an den Switch anschließen (umpatchen)',
            stichwoerter: ['patchen', 'umpatchen', 'Patchkabel stecken'],
          ),
        ],
        punkte: 3,
        loesung:
            'Das Terminal funktioniert nur an Dose 1 oder 2. Die Dosen 3 und 4 enden zwar am Patchfeld, ihre Ports sind dort aber nicht per Patchkabel mit dem Switch verbunden - sie sind nicht gepatcht. Alternativ kann Port 3 nachträglich gepatcht werden.',
        explanation:
            'Bewertung: 1 Punkt für die richtige Dose, 2 Punkte für die Begründung. Auch die Lösung „Port 3 patchen“ ist richtig.',
      ),
      rechnen(
        'f-a03h-handel-g',
        'h-komponenten',
        scenario:
            'Der Lieferant bietet die vier Terminals zum Stückpreis von 289 € netto an. Er gewährt 5 % Rabatt auf den Warenwert; dazu kommen 19 % Umsatzsteuer. Bei Zahlung innerhalb von 10 Tagen dürfen 2 % Skonto vom Bruttobetrag abgezogen werden.',
        prompt:
            'Berechne den Überweisungsbetrag in Euro bei Zahlung mit Skonto. Runde auf zwei Nachkommastellen.',
        answer: 1280.72,
        tolerance: 0.01,
        unit: '€',
        punkte: 3,
        explanation:
            'Warenwert: 4 × 289 € = 1.156,00 €. Abzüglich 5 % Rabatt: 1.098,20 €. Zuzüglich 19 % Umsatzsteuer: 1.306,86 €. Abzüglich 2 % Skonto: 1.306,86 € × 0,98 = 1.280,72 €.',
      ),
      freitext(
        'f-a03h-handel-h',
        'h-arbeitsplatz',
        scenario:
            'Die Beschäftigten arbeiten an den Kassen mehrere Stunden am Stück mit Bildschirm, Scanner und Terminal.',
        prompt:
            'Nenne zwei Anforderungen an einen ergonomisch gestalteten Kassenarbeitsplatz.',
        kriterien: [
          krit(
            'Bildschirm blend- und spiegelfrei aufgestellt, in Höhe und Neigung verstellbar',
            stichwoerter: ['Bildschirm', 'Monitor', 'blendfrei', 'Spiegelung'],
          ),
          krit(
            'verstellbarer Stuhl oder Stehhilfe, Wechsel zwischen Sitzen und Stehen',
            stichwoerter: ['Stuhl', 'Stehhilfe', 'Sitzen', 'Stehen'],
          ),
          krit(
            'Scanner, Terminal und Tastatur im Greifraum, ohne Verdrehen erreichbar',
            stichwoerter: [
              'Greifraum',
              'erreichbar',
              'Anordnung',
              'Reichweite',
            ],
          ),
          krit(
            'ausreichende Beleuchtung, kein Zugluft- oder Lärmproblem',
            stichwoerter: ['Beleuchtung', 'Licht', 'Lärm', 'Zugluft'],
          ),
        ],
        punkte: 2,
        loesung:
            'Der Bildschirm steht blendfrei und lässt sich in Höhe und Neigung verstellen. Scanner, Terminal und Tastatur liegen im Greifraum; ein verstellbarer Stuhl oder eine Stehhilfe erlaubt den Wechsel der Körperhaltung.',
        explanation:
            'Bewertung: je Nennung 1 Punkt, höchstens 2 Punkte. Andere fachlich richtige Anforderungen zählen ebenfalls.',
      ),
    ],
  ),
  fall(
    'f-a03n-handel',
    firma: 'handel',
    bereich: 'a03',
    titel: 'Mobiles Arbeiten: Fernzugriff und E-Mail einrichten',
    situation:
        'Die Grünwerk Gartenbedarf GmbH stattet 20 Beschäftigte aus Einkauf und Kundenservice für mobiles Arbeiten aus. Sie sollen von unterwegs E-Mails auf Notebook und Smartphone bearbeiten; die IT-Abteilung verwaltet einen Linux-Server in der Zentrale aus der Ferne. Du richtest die Zugänge ein und dokumentierst das Netz der mobilen Geräte.',
    teile: [
      lueckentext(
        'f-a03n-handel-a',
        'nw-dienste',
        scenario:
            'Der Linux-Server in der Zentrale hat die Adresse 10.20.0.15. Für die sichere Fernverwaltung öffnest du den Terminal-Client und füllst den Dialog aus.',
        code:
            'New remote session\n'
            'Host name (or IP address): [      ]\n'
            'Port: [    ]\n'
            'Connection type:\n'
            '( ) Serial  ( ) Telnet  ( ) SSH',
        table: [
          ['Dienst', 'Port'],
          ['FTP', '21'],
          ['SSH', '22'],
          ['Telnet', '23'],
          ['HTTP', '80'],
        ],
        prompt: 'Gib die Werte für eine sichere Fernverbindung an.',
        text:
            'Host name: {0}\n'
            'Port: {1}\n'
            'Connection type: {2}',
        luecken: [
          wort(['10.20.0.15']),
          zahl(22),
          wahl('SSH', ['Telnet', 'Serial']),
        ],
        punkte: 3,
        explanation:
            'Für die verschlüsselte Fernverwaltung wird SSH gewählt; der Standardport laut Tabelle ist 22. Als Host wird die Adresse des Servers eingetragen. Je Wert 1 Punkt.',
        tags: ['englisch'],
      ),
      freitext(
        'f-a03n-handel-b',
        'nw-dienste',
        scenario:
            'Der Terminal-Client bietet neben SSH auch die Verbindungstypen Telnet und Serial an.',
        prompt:
            'Begründe, warum die Verbindungstypen Telnet und Serial hier nicht in Frage kommen.',
        kriterien: [
          krit(
            'Telnet überträgt unverschlüsselt - auch Benutzername und Passwort können mitgelesen werden',
            stichwoerter: [
              'unverschlüsselt',
              'Klartext',
              'mitlesen',
              'mitgelesen',
            ],
          ),
          krit(
            'Serial braucht eine direkte Kabelverbindung zum Gerät und funktioniert nicht über das Netz',
            stichwoerter: ['Kabel', 'direkt', 'vor Ort', 'nicht über das Netz'],
          ),
        ],
        loesung:
            'Telnet überträgt alle Daten einschließlich der Anmeldedaten unverschlüsselt und kann mitgelesen werden. Eine serielle Verbindung setzt ein direkt am Server angeschlossenes Kabel voraus und ist aus der Ferne nicht möglich.',
        punkte: 2,
        explanation: 'Bewertung: je Verbindungstyp 1 Punkt für die Begründung.',
      ),
      freitext(
        'f-a03n-handel-c',
        'nw-dienste',
        scenario:
            'Die Postfächer sollen auf Notebook und Smartphone eingerichtet werden. Zur Wahl stehen IMAP und POP3.',
        prompt: 'Begründe, warum IMAP eingerichtet wird.',
        kriterien: [
          krit(
            'Die E-Mails bleiben auf dem Server und werden mit allen Geräten synchronisiert',
            punkte: 2,
            stichwoerter: [
              'auf dem Server',
              'synchronisiert',
              'Synchronisation',
              'bleiben',
            ],
          ),
          krit(
            'Notebook und Smartphone zeigen denselben Stand (Ordner, gelesen, gesendet)',
            punkte: 2,
            stichwoerter: [
              'gleicher Stand',
              'beide Geräte',
              'mehrere Geräte',
              'Ordner',
            ],
          ),
        ],
        punkte: 2,
        loesung:
            'Bei IMAP bleiben die E-Mails auf dem Server und werden mit jedem Gerät synchronisiert. Notebook und Smartphone zeigen deshalb denselben Stand. POP3 würde die Mails auf ein Gerät herunterladen und sie meist vom Server löschen.',
        explanation: 'Bewertung: Aussage plus Begründung ergeben 2 Punkte.',
      ),
      tabelle(
        'f-a03n-handel-d',
        'nw-dienste',
        scenario:
            'Für die Einrichtung der Mailprogramme wird eine Übersicht der verschlüsselten Zugänge gebraucht.',
        prompt: 'Ergänze Protokoll und Port.',
        zeilen: [
          ['Aufgabe', 'Protokoll', 'Port'],
          [
            'E-Mails abrufen (TLS)',
            wahl('IMAPS', ['SMTP', 'DNS', 'SSH']),
            zahl(993),
          ],
          [
            'E-Mails senden (STARTTLS)',
            wahl('SMTP', ['IMAPS', 'POP3S', 'DHCP']),
            zahl(587),
          ],
        ],
        punkte: 4,
        explanation:
            'Abgerufen wird verschlüsselt per IMAPS auf Port 993, versendet per SMTP - Mailprogramme liefern über Port 587 mit STARTTLS ein. Je Zelle 1 Punkt.',
      ),
      lueckentext(
        'f-a03n-handel-e',
        'nw-ipv4',
        scenario:
            'Mobile Geräte, die sich mit der Zentrale verbinden, erhalten Adressen aus einem eigenen Subnetz. Ein Notebook hat die Adresse 10.20.64.75/26.',
        prompt: 'Ermittle die Werte dieses Subnetzes.',
        text:
            'Subnetzmaske: {0}\n'
            'Nutzbare Hostadressen: {1}\n'
            'Netzadresse: {2}\n'
            'Broadcastadresse: {3}\n'
            'Erste nutzbare Adresse: {4}',
        luecken: [
          wort(['255.255.255.192'], '/26'),
          zahl(62, rationale: '2⁶ - 2'),
          wort(['10.20.64.64'], '75 liegt im Block 64 bis 127'),
          wort(['10.20.64.127'], 'letzte Adresse des Blocks'),
          wort(['10.20.64.65'], 'Netzadresse + 1'),
        ],
        punkte: 5,
        explanation:
            '/26: Maske 255.255.255.192, Blockgröße 64, 62 nutzbare Adressen. Die 75 liegt im Block 64 bis 127: Netz 10.20.64.64, Broadcast 10.20.64.127, erste nutzbare Adresse 10.20.64.65. Je Wert 1 Punkt.',
      ),
      freitext(
        'f-a03n-handel-f',
        'nw-ipv4',
        scenario:
            'Im Homeoffice hat ein Notebook die Adresse 192.168.178.34/24 vom heimischen Router erhalten.',
        prompt:
            'Beschreibe, warum das Notebook unter dieser Adresse nicht direkt aus dem Internet erreichbar ist.',
        kriterien: [
          krit(
            'Es ist eine private IPv4-Adresse',
            stichwoerter: ['private', 'privat', '192.168.0.0'],
          ),
          krit(
            'Private Adressen werden im Internet nicht geroutet; nach außen ist nur die öffentliche Adresse des Routers sichtbar (NAT)',
            stichwoerter: [
              'nicht geroutet',
              'NAT',
              'öffentliche Adresse',
              'nicht weitergeleitet',
            ],
          ),
        ],
        loesung:
            'Die Adresse stammt aus dem privaten Bereich 192.168.0.0/16. Private Adressen werden im Internet nicht geroutet. Das Notebook kommuniziert nach außen nur über den Router, der seine Adresse per NAT durch die öffentliche ersetzt.',
        punkte: 2,
        explanation:
            'Bewertung: 1 Punkt für „private Adresse“, 1 Punkt für „wird im Internet nicht geroutet“.',
      ),
      markieren(
        'f-a03n-handel-g',
        'b-cli',
        scenario:
            'Eine Mitarbeiterin klagt im Homeoffice über stockende Videokonferenzen. Sie schickt die Auswertung von drei Ping-Läufen.',
        prompt: 'Markiere alle auffälligen Zeilen.',
        mono: true,
        zeilen: [
          nein('Router zu Hause: Mittelwert 2ms', 'Im Heimnetz normal.'),
          nein('Router zu Hause: 0% Verlust', 'Kein Paketverlust.'),
          ja(
            'Konferenzserver: Mittelwert 466ms',
            'Für Echtzeitanwendungen viel zu hoch.',
          ),
          ja(
            'Konferenzserver: Maximum 863ms',
            'Starker Ausreißer - die Laufzeit schwankt erheblich.',
          ),
          ja(
            'Konferenzserver: 10% Verlust',
            'Jedes zehnte Paket geht verloren.',
          ),
          nein(
            'Mailserver: Mittelwert 24ms',
            'Für ein Ziel im Internet normal.',
          ),
        ],
        punkte: 3,
        explanation:
            'Auffällig sind die Werte zum Konferenzserver: hoher Mittelwert, großes Maximum und Paketverlust. Folge sind ruckelnde Bilder, abgehackter Ton und Abbrüche. Heimnetz und Mailserver sind unauffällig.',
      ),
      freitext(
        'f-a03n-handel-h',
        'an-lizenzen',
        scenario:
            'Für die Notebooks stehen ein Open-Source-Mailprogramm und ein proprietäres Produkt zur Wahl.',
        prompt:
            'Nenne je zwei Vorteile von Open-Source-Software und von proprietärer Software.',
        kriterien: [
          krit(
            'Open Source: keine Lizenzkosten',
            stichwoerter: [
              'keine Lizenzkosten',
              'kostenlos',
              'lizenzkostenfrei',
            ],
          ),
          krit(
            'Open Source: Quellcode einsehbar und anpassbar',
            stichwoerter: ['Quellcode', 'einsehbar', 'anpassbar', 'offen'],
          ),
          krit(
            'Open Source: keine Bindung an einen Hersteller',
            stichwoerter: ['Herstellerbindung', 'unabhängig', 'Abhängigkeit'],
          ),
          krit(
            'Proprietär: Support und Gewährleistung durch den Hersteller',
            stichwoerter: ['Support', 'Gewährleistung', 'Ansprechpartner'],
          ),
          krit(
            'Proprietär: geregelte Updates',
            stichwoerter: ['Updates', 'geregelt', 'Wartung'],
          ),
          krit(
            'Proprietär: gute Integration in andere Produkte des Herstellers',
            stichwoerter: ['Integration', 'integriert', 'aus einer Hand'],
          ),
        ],
        punkte: 4,
        loesung:
            'Open Source: keine Lizenzkosten, Quellcode einsehbar und anpassbar, keine Herstellerbindung. Proprietär: Support und Gewährleistung vom Hersteller, geregelte Updates, gute Integration in dessen übrige Produkte.',
        explanation:
            'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte (je zwei pro Seite).',
      ),
    ],
  ),

  // =================================================================== Agentur
  fall(
    'f-a03h-agentur',
    firma: 'agentur',
    bereich: 'a03',
    titel: 'Arbeitsplätze der Grafik aufrüsten',
    situation:
        'Die Pixelhafen Medien GmbH rüstet die sechs Arbeitsplätze der Grafik auf: neue Workstations, je drei Monitore und ein passendes Netzteil. Zwei Anbieter haben Angebote abgegeben. Du wertest die Angebote aus, planst die Stromversorgung und die Verkabelung der Monitore.',
    teile: [
      tabelle(
        'f-a03h-agentur-a',
        'an-software',
        scenario:
            'Die Angebote werden mit einer Nutzwertanalyse verglichen. Die Grafik hat je Kriterium 1 bis 10 Punkte vergeben.',
        table: [
          ['Kriterium', 'Gewicht', 'Anbieter A', 'Anbieter B'],
          ['Grafikkarte', '30 %', '8', '6'],
          ['Arbeitsspeicher', '20 %', '6', '9'],
          ['Monitore', '30 %', '7', '8'],
          ['Preis', '20 %', '5', '7'],
        ],
        prompt:
            'Vervollständige die Nutzwertanalyse mit den gewichteten Punkten und den Summen.',
        zeilen: [
          ['Kriterium', 'A gewichtet', 'B gewichtet'],
          ['Grafikkarte', '2,4', zahl(1.8, toleranz: 0.001)],
          ['Arbeitsspeicher', zahl(1.2, toleranz: 0.001), '1,8'],
          ['Monitore', zahl(2.1, toleranz: 0.001), zahl(2.4, toleranz: 0.001)],
          ['Preis', zahl(1, toleranz: 0.001), zahl(1.4, toleranz: 0.001)],
          ['Nutzwert', zahl(6.7, toleranz: 0.001), zahl(7.4, toleranz: 0.001)],
        ],
        punkte: 6,
        explanation:
            'Gewichtete Punkte = Gewicht × Punkte. A: 2,4 + 1,2 + 2,1 + 1,0 = 6,7. B: 1,8 + 1,8 + 2,4 + 1,4 = 7,4. Anbieter B hat den höheren Nutzwert und erhält den Zuschlag.',
      ),
      lueckentext(
        'f-a03h-agentur-b',
        'h-komponenten',
        scenario:
            'Für die Workstation wird das Netzteil ausgelegt. Auf die Summe kommen 10 % Puffer; Netzteile gibt es in 50-W-Schritten von 400 W bis 800 W. Das gewählte Netzteil hat bei dieser Last einen Wirkungsgrad von 90 %.',
        table: [
          ['Komponente', 'Anzahl', 'Leistung je Stück'],
          ['Prozessor', '1', '125 W'],
          ['Grafikkarte', '1', '220 W'],
          ['Mainboard', '1', '50 W'],
          ['RAM-Modul', '2', '5 W'],
          ['SSD', '2', '8 W'],
          ['Lüfter', '3', '4 W'],
        ],
        prompt: 'Dimensioniere das Netzteil. Runde auf eine Nachkommastelle.',
        text:
            'Summe der Komponenten: {0} W\n'
            'mit 10 % Puffer: {1} W\n'
            'gewähltes Netzteil: {2}\n'
            'Aufnahme aus der Steckdose, wenn alle Komponenten voll arbeiten: {3} W',
        luecken: [
          zahl(433, rationale: '125 + 220 + 50 + 10 + 16 + 12'),
          zahl(476.3, toleranz: 0.05, rationale: '433 W × 1,1'),
          wahl('500 W', ['450 W', '400 W', '550 W']),
          zahl(481.1, toleranz: 0.05, rationale: '433 W / 0,9'),
        ],
        punkte: 4,
        explanation:
            'Summe: 125 + 220 + 50 + 2 × 5 + 2 × 8 + 3 × 4 = 433 W. Mit Puffer: 433 W × 1,1 = 476,3 W - das nächstgrößere Netzteil hat 500 W. Aus der Steckdose: 433 W / 0,9 ≈ 481,1 W, denn die Nutzleistung wird durch den Wirkungsgrad geteilt.',
      ),
      freitext(
        'f-a03h-agentur-c',
        'h-schnittstellen',
        scenario:
            'Die drei Monitore je Arbeitsplatz sollen per Daisy Chaining angeschlossen werden.',
        prompt: 'Nenne einen Vorteil von Daisy Chaining.',
        kriterien: [
          krit(
            'weniger Kabel zum PC, aufgeräumter Arbeitsplatz',
            stichwoerter: [
              'weniger Kabel',
              'aufgeräumt',
              'Kabelsalat',
              'ein Kabel',
            ],
          ),
          krit(
            'nur ein Bildausgang am PC wird belegt',
            stichwoerter: ['ein Ausgang', 'nur ein Anschluss', 'einen Ausgang'],
          ),
        ],
        punkte: 1,
        loesung:
            'Zum PC führt nur ein Kabel: Der Arbeitsplatz bleibt aufgeräumt, und am PC wird nur ein Bildausgang belegt.',
        explanation: 'Bewertung: Eine richtige Nennung ergibt 1 Punkt.',
      ),
      freitext(
        'f-a03h-agentur-d',
        'h-schnittstellen',
        code:
            'Daisy chaining lets you connect several\n'
            'monitors in a row using a single video\n'
            'output of your PC. The PC output and\n'
            'every monitor in the chain except the\n'
            'last one must support Multi-Stream\n'
            'Transport (MST). Use DisplayPort or\n'
            'Thunderbolt connections.',
        prompt:
            'Erläutere anhand des Textes die technische Voraussetzung für Daisy Chaining.',
        kriterien: [
          krit(
            'Multi-Stream Transport (MST) muss unterstützt werden',
            stichwoerter: ['MST', 'Multi-Stream', 'Multi Stream Transport'],
          ),
          krit(
            'vom Bildausgang des PCs (DisplayPort oder Thunderbolt)',
            stichwoerter: [
              'Ausgang des PC',
              'DisplayPort',
              'Thunderbolt',
              'PC',
            ],
          ),
          krit(
            'und von allen Monitoren der Kette außer dem letzten',
            stichwoerter: ['Monitore', 'Monitor', 'außer dem letzten'],
          ),
        ],
        loesung:
            'Der Bildausgang des PCs - DisplayPort oder Thunderbolt - und alle Monitore der Kette bis auf den letzten müssen Multi-Stream Transport (MST) unterstützen. Nur dann lassen sich mehrere Bildsignale über ein Kabel übertragen und von Monitor zu Monitor weiterreichen.',
        punkte: 3,
        explanation:
            'Bewertung: je 1 Punkt für MST, den Ausgang des PCs und die Monitore - zusammen 3 Punkte.',
        tags: ['englisch'],
      ),
      reihenfolge(
        'f-a03h-agentur-e',
        'h-schnittstellen',
        scenario:
            'Das I/O-Panel der Workstation hat die Ausgänge HDMI, DisplayPort und Thunderbolt. Die drei Monitore haben je einen DisplayPort-Eingang (IN) und einen DisplayPort-Ausgang (OUT).',
        prompt:
            'Bringe die Stationen der Monitorkette in die Reihenfolge, in der das Bildsignal sie durchläuft.',
        items: [
          'PC: DisplayPort-Ausgang',
          'Monitor 1: DisplayPort IN',
          'Monitor 1: DisplayPort OUT',
          'Monitor 2: DisplayPort IN',
          'Monitor 2: DisplayPort OUT',
          'Monitor 3: DisplayPort IN',
        ],
        punkte: 2,
        explanation:
            'Das Signal geht vom DisplayPort-Ausgang (oder Thunderbolt) des PCs zum Eingang des ersten Monitors, von dessen Ausgang zum zweiten und von dort zum dritten. Der HDMI-Ausgang eignet sich nicht für eine Kette.',
      ),
      rechnen(
        'f-a03h-agentur-f',
        'h-usv',
        scenario:
            'An einem Arbeitsplatz hängen an einer Steckdosenleiste (Aufdruck: max. 16 A bei 230 V) die Workstation mit 480 W, drei Monitore mit je 40 W, ein Laserdrucker mit 900 W und ein Wasserkocher mit 2.000 W. Es gilt P = U × I.',
        prompt:
            'Berechne den Gesamtstrom in Ampere. Runde auf zwei Nachkommastellen.',
        answer: 15.22,
        tolerance: 0.01,
        unit: 'A',
        punkte: 3,
        explanation:
            'Gesamtleistung: 480 W + 3 × 40 W + 900 W + 2.000 W = 3.500 W. Strom: I = P / U = 3.500 W / 230 V ≈ 15,22 A. Das liegt knapp unter 16 A - zulässig, aber ohne Reserve; der Wasserkocher gehört an eine andere Steckdose.',
      ),
      freitext(
        'f-a03h-agentur-g',
        'h-arbeitsplatz',
        scenario:
            'Eine Grafikerin arbeitet übergangsweise nur am Notebook, das auf einem niedrigen Beistelltisch steht; sie sitzt auf einem Stuhl ohne Verstellmöglichkeit.',
        prompt:
            'Nenne vier Möglichkeiten, diesen Arbeitsplatz ergonomischer zu gestalten.',
        kriterien: [
          krit(
            'separater, größerer, höhenverstellbarer Bildschirm',
            stichwoerter: ['Monitor', 'Bildschirm', 'externer Bildschirm'],
          ),
          krit(
            'externe Tastatur und Maus',
            stichwoerter: ['Tastatur', 'Maus', 'Eingabegeräte'],
          ),
          krit(
            'höhenverstellbarer, ausreichend großer Schreibtisch',
            stichwoerter: ['Tisch', 'Schreibtisch', 'höhenverstellbar'],
          ),
          krit(
            'ergonomischer, verstellbarer Bürostuhl',
            stichwoerter: ['Stuhl', 'Bürostuhl', 'Rückenlehne'],
          ),
          krit(
            'mehrere Bildschirme bzw. hohe Auflösung für die Grafikarbeit',
            stichwoerter: [
              'mehrere Bildschirme',
              'Auflösung',
              'zweiter Monitor',
            ],
          ),
          krit(
            'Dockingstation oder Notebook-Ständer',
            stichwoerter: ['Dockingstation', 'Dock', 'Ständer'],
          ),
        ],
        punkte: 4,
        loesung:
            'Ein separater, größerer und höhenverstellbarer Bildschirm, externe Tastatur und Maus, ein höhenverstellbarer Schreibtisch und ein ergonomischer Bürostuhl. Für die Grafikarbeit zusätzlich mehrere Bildschirme mit hoher Auflösung.',
        explanation: 'Bewertung: je Nennung 1 Punkt, höchstens 4 Punkte.',
      ),
      freitext(
        'f-a03h-agentur-h',
        'h-arbeitsplatz',
        scenario:
            'Die sechs Workstations mit je drei Monitoren laufen bisher auch nachts und am Wochenende durch.',
        prompt:
            'Nenne zwei Maßnahmen, mit denen sich der Stromverbrauch der Grafik-Arbeitsplätze senken lässt.',
        kriterien: [
          krit(
            'Energiesparmodus bzw. Ruhezustand nach kurzer Inaktivität',
            stichwoerter: ['Energiesparmodus', 'Ruhezustand', 'Standby'],
          ),
          krit(
            'Geräte nach Feierabend ganz ausschalten, schaltbare Steckdosenleisten',
            stichwoerter: ['ausschalten', 'Steckdosenleiste', 'abschalten'],
          ),
          krit(
            'Netzteil mit hohem Wirkungsgrad (80 PLUS)',
            stichwoerter: ['Wirkungsgrad', '80 PLUS', 'effizientes Netzteil'],
          ),
          krit(
            'sparsame Monitore, Helligkeit reduzieren',
            stichwoerter: ['Helligkeit', 'sparsame Monitore', 'Energielabel'],
          ),
        ],
        punkte: 2,
        loesung:
            'Energiesparmodus und automatischen Ruhezustand einrichten und die Geräte nach Feierabend über schaltbare Steckdosenleisten vom Netz trennen. Außerdem Netzteile mit hohem Wirkungsgrad wählen.',
        explanation: 'Bewertung: je Nennung 1 Punkt, höchstens 2 Punkte.',
      ),
    ],
  ),
  fall(
    'f-a03n-agentur',
    firma: 'agentur',
    bereich: 'a03',
    titel: 'Netzwerkeinstellungen am Ticket-Arbeitsplatz prüfen',
    situation:
        'Bei der Pixelhafen Medien GmbH geht das neue Ticketsystem in Betrieb. Ein Arbeitsplatz im Support erreicht den Ticketserver nicht zuverlässig. Du prüfst mit den Administratoren die Netzwerkeinstellungen des PCs und dokumentierst das Servernetz.',
    teile: [
      freitext(
        'f-a03n-agentur-a',
        'nw-geraete',
        scenario:
            'An der Netzwerkbuchse des PCs sitzt eine LED. Sie leuchtet dauerhaft und blinkt zeitweise.',
        prompt:
            'Erläutere, was das Dauerlicht und was das Blinken der LED bedeutet.',
        kriterien: [
          krit(
            'Dauerlicht: Es besteht eine physische Verbindung (Link) zum Switch',
            punkte: 2,
            stichwoerter: ['Link', 'Verbindung', 'verbunden', 'angeschlossen'],
          ),
          krit(
            'Blinken: Es werden gerade Daten übertragen (Aktivität)',
            punkte: 2,
            stichwoerter: ['Daten', 'Aktivität', 'Datenverkehr', 'übertragen'],
          ),
        ],
        punkte: 4,
        loesung:
            'Dauerlicht: Die Netzwerkkarte hat eine physische Verbindung (Link) zum Gegenüber, etwa dem Switch - Kabel und Patchung sind in Ordnung. Blinken: Über die Verbindung werden gerade Daten gesendet oder empfangen.',
        explanation:
            'Bewertung: je 2 Punkte für Dauerlicht (Link) und Blinken (Datenverkehr). Bleibt die LED dunkel, liegt der Fehler auf Schicht 1: Kabel, Dose, Patchung oder Switch-Port.',
      ),
      tabelle(
        'f-a03n-agentur-b',
        'nw-modelle',
        scenario:
            'Die Fehlersuche folgt dem OSI-Modell. Die Zeile für Schicht 4 ist als Beispiel ausgefüllt.',
        prompt:
            'Benenne die Schichten und ordne jeder Schicht den passenden Begriff zu.',
        zeilen: [
          ['Schicht', 'Name', 'Begriff'],
          [
            '7',
            wahl('Anwendung', ['Sitzung', 'Vermittlung', 'Sicherung']),
            wahl('DHCP', ['MAC-Adresse', 'IPv4-Adresse', 'RJ45-Buchse']),
          ],
          ['4', 'Transport', 'TCP-Port'],
          [
            '3',
            wahl('Vermittlung', ['Transport', 'Sicherung', 'Anwendung']),
            wahl('IPv4-Adresse', ['MAC-Adresse', 'DHCP', 'RJ45-Buchse']),
          ],
          [
            '2',
            wahl('Sicherung', ['Vermittlung', 'Bitübertragung', 'Transport']),
            wahl('MAC-Adresse', ['IPv4-Adresse', 'DHCP', 'RJ45-Buchse']),
          ],
          [
            '1',
            wahl('Bitübertragung', ['Sicherung', 'Vermittlung', 'Anwendung']),
            wahl('RJ45-Buchse', ['MAC-Adresse', 'IPv4-Adresse', 'DHCP']),
          ],
        ],
        punkte: 4,
        explanation:
            'Schicht 7 Anwendung: DHCP ist ein Anwendungsprotokoll. Schicht 3 Vermittlung: IP-Adressen. Schicht 2 Sicherung: MAC-Adressen. Schicht 1 Bitübertragung: Buchsen, Kabel, Signale. Je Zeile 1 Punkt.',
      ),
      lueckentext(
        'f-a03n-agentur-c',
        'nw-ipv4',
        scenario: 'ipconfig /all zeigt am Support-PC die folgende Ausgabe.',
        code:
            'Physische Adresse : 5C-26-0A-7B-91-3E\n'
            'DHCP aktiviert  . : Ja\n'
            'IPv4-Adresse  . . : 10.30.5.108\n'
            'Subnetzmaske  . . : 255.255.255.224\n'
            'Standardgateway . : 10.30.5.97\n'
            'DHCP-Server . . . : 10.30.5.98\n'
            'DNS-Server  . . . : 10.30.5.99\n'
            'IPv6 (lokal)  . . : fe80::5e26:aff:fe7b:913e',
        prompt: 'Ermittle aus der Ausgabe die Werte des Subnetzes.',
        text:
            'Präfixlänge: /{0}\n'
            'Netzadresse: {1}\n'
            'Broadcastadresse: {2}\n'
            'Nutzbare Hostadressen: {3}\n'
            'Letzte nutzbare Adresse: {4}',
        luecken: [
          zahl(27, rationale: '224 = 11100000: 24 + 3 Bit'),
          wort(['10.30.5.96'], 'Blockgröße 32: 108 liegt im Block 96 bis 127'),
          wort(['10.30.5.127'], 'letzte Adresse des Blocks'),
          zahl(30, rationale: '2⁵ - 2'),
          wort(['10.30.5.126'], 'Broadcast - 1'),
        ],
        punkte: 5,
        explanation:
            'Maske 255.255.255.224 = /27, Blockgröße 256 - 224 = 32, 30 nutzbare Adressen. Blöcke: 64, 96, 128 - die 108 liegt im Block 96 bis 127. Netz 10.30.5.96, Broadcast 10.30.5.127, letzte nutzbare Adresse 10.30.5.126. Je Wert 1 Punkt.',
      ),
      freitext(
        'f-a03n-agentur-d',
        'nw-dienste',
        scenario: 'ipconfig /all zeigt am Support-PC die folgende Ausgabe.',
        code:
            'Physische Adresse : 5C-26-0A-7B-91-3E\n'
            'DHCP aktiviert  . : Ja\n'
            'IPv4-Adresse  . . : 10.30.5.108\n'
            'Subnetzmaske  . . : 255.255.255.224\n'
            'Standardgateway . : 10.30.5.97\n'
            'DHCP-Server . . . : 10.30.5.98\n'
            'DNS-Server  . . . : 10.30.5.99\n'
            'IPv6 (lokal)  . . : fe80::5e26:aff:fe7b:913e',
        prompt:
            'Nenne zwei Angaben aus der Ausgabe, die der PC vom DHCP-Server erhalten hat.',
        kriterien: [
          krit(
            'IPv4-Adresse (10.30.5.108)',
            stichwoerter: ['IP-Adresse', 'IPv4', '10.30.5.108'],
          ),
          krit(
            'Subnetzmaske (255.255.255.224)',
            stichwoerter: ['Subnetzmaske', 'Maske', '255.255.255.224'],
          ),
          krit(
            'Standardgateway (10.30.5.97)',
            stichwoerter: ['Gateway', 'Standardgateway', '10.30.5.97'],
          ),
          krit(
            'DNS-Server (10.30.5.99)',
            stichwoerter: ['DNS', 'DNS-Server', '10.30.5.99'],
          ),
        ],
        punkte: 2,
        loesung:
            'Vom DHCP-Server stammen die IPv4-Adresse 10.30.5.108 und die Subnetzmaske 255.255.255.224, außerdem Standardgateway und DNS-Server.',
        explanation:
            'Bewertung: je Nennung 1 Punkt, höchstens 2 Punkte. Die physische Adresse (MAC) und die fe80-Adresse stammen nicht vom DHCP-Server.',
      ),
      freitext(
        'f-a03n-agentur-e',
        'nw-modelle',
        scenario: 'Der Befehl arp -a zeigt am Support-PC diese Zeile.',
        code:
            'Internetadresse  Physische Adresse  Typ\n'
            '10.30.5.97       00-1b-21-aa-04-10  dynamisch',
        prompt: 'Erläutere die Aufgabe von ARP am Beispiel dieser Zeile.',
        kriterien: [
          krit(
            'ARP ermittelt im lokalen Netz zu einer IP-Adresse die zugehörige MAC-Adresse',
            punkte: 2,
            stichwoerter: [
              'MAC-Adresse',
              'MAC',
              'physische Adresse',
              'zuordnen',
            ],
          ),
          krit(
            'Beispiel: Zum Gateway 10.30.5.97 gehört die MAC-Adresse 00-1b-21-aa-04-10; der Eintrag wurde per Anfrage gelernt (dynamisch)',
            stichwoerter: ['10.30.5.97', '00-1b-21', 'Gateway', 'dynamisch'],
          ),
        ],
        loesung:
            'ARP löst im lokalen Netz eine IP-Adresse in die zugehörige MAC-Adresse auf, damit der Frame an die richtige Netzwerkkarte geschickt werden kann. Hier hat der PC per ARP-Anfrage gelernt, dass zum Gateway 10.30.5.97 die MAC-Adresse 00-1b-21-aa-04-10 gehört; der Eintrag steht dynamisch in der ARP-Tabelle.',
        punkte: 3,
        explanation:
            'Bewertung: 2 Punkte für die Aufgabe von ARP, 1 Punkt für den Bezug auf die Werte der Zeile.',
      ),
      lueckentext(
        'f-a03n-agentur-f',
        'b-cli',
        scenario:
            'Der Ticketserver hat die Adresse 10.30.5.100 und den Namen tickets.pixelhafen.example.',
        prompt: 'Gib die passenden Befehle an.',
        text:
            'Erreichbarkeit des Servers prüfen: {0} 10.30.5.100\n'
            'Namensauflösung prüfen: {1} tickets.pixelhafen.example',
        luecken: [
          wort(['ping', 'tracert', 'pathping']),
          wort(['nslookup']),
        ],
        punkte: 2,
        explanation:
            'ping prüft, ob das Ziel antwortet (auch tracert zeigt die Erreichbarkeit). nslookup fragt den DNS-Server, welche Adresse zum Namen gehört. Je Befehl 1 Punkt.',
      ),
      freitext(
        'f-a03n-agentur-g',
        'nw-ipv6',
        scenario: 'ipconfig /all zeigt am Support-PC die folgende Ausgabe.',
        code:
            'Physische Adresse : 5C-26-0A-7B-91-3E\n'
            'DHCP aktiviert  . : Ja\n'
            'IPv4-Adresse  . . : 10.30.5.108\n'
            'Subnetzmaske  . . : 255.255.255.224\n'
            'Standardgateway . : 10.30.5.97\n'
            'DHCP-Server . . . : 10.30.5.98\n'
            'DNS-Server  . . . : 10.30.5.99\n'
            'IPv6 (lokal)  . . : fe80::5e26:aff:fe7b:913e',
        prompt:
            'Beschreibe, woher die Adresse fe80::5e26:aff:fe7b:913e in der Ausgabe stammt.',
        kriterien: [
          krit(
            'Es ist eine verbindungslokale (Link-Local-)IPv6-Adresse, die nur im eigenen Netzsegment gilt',
            stichwoerter: [
              'Link-Local',
              'verbindungslokal',
              'link lokal',
              'fe80',
            ],
          ),
          krit(
            'Der PC weist sie sich selbst zu, ohne DHCP-Server oder Router',
            stichwoerter: [
              'selbst',
              'automatisch',
              'ohne DHCP',
              'eigenständig',
            ],
          ),
        ],
        loesung:
            'Es ist die verbindungslokale IPv6-Adresse (Link-Local, Bereich fe80::/10). Jede IPv6-Schnittstelle weist sie sich selbst zu, ohne dass ein DHCP-Server oder Router beteiligt ist; hier wurde sie aus der MAC-Adresse gebildet. Sie gilt nur im eigenen Netzsegment.',
        punkte: 2,
        explanation:
            'Bewertung: 1 Punkt für „Link-Local“, 1 Punkt für „selbst zugewiesen“.',
      ),
      tabelle(
        'f-a03n-agentur-h',
        'nw-dienste',
        scenario:
            'Für die Firewall vor dem Ticketserver werden die benötigten Standardports dokumentiert.',
        prompt: 'Ergänze die Ports.',
        zeilen: [
          ['Zweck', 'Protokoll', 'Port'],
          ['Weboberfläche des Ticketsystems', 'HTTPS', zahl(443)],
          ['Fernverwaltung durch die Administratoren', 'SSH', zahl(22)],
          ['Abruf des Support-Postfachs', 'IMAPS', zahl(993)],
        ],
        punkte: 3,
        explanation:
            'HTTPS 443, SSH 22, IMAPS 993. Alle übrigen Ports bleiben in der Firewall geschlossen. Je Port 1 Punkt.',
      ),
    ],
  ),

  // ================================================================== Logistik
  fall(
    'f-a03h-logistik',
    firma: 'logistik',
    bereich: 'a03',
    titel: 'Überwachungskameras für die neue Lagerhalle',
    situation:
        'In der neuen Lagerhalle der Elbtal Logistik AG sollen sechs Kameras die Verladetore überwachen. Sie werden über das Netzwerkkabel mit Strom versorgt (48 V), die Aufnahmen der letzten 48 Stunden bleiben gespeichert. Der Hersteller liefert ein englisches Datenblatt, das du auswertest.',
    teile: [
      freitext(
        'f-a03h-logistik-a',
        'b-haertung',
        code:
            'Dome Camera DC-8 - Datasheet\n'
            'Resolution: 2560 x 1440, 25 fps\n'
            'Night vision: infrared LEDs\n'
            'Power consumption:\n'
            '  camera only           6 W\n'
            '  with infrared        11 W\n'
            '  with IR and heater   21 W\n'
            'Power supply: PoE, 48 V\n'
            'Setup: no default password',
        prompt:
            'Im Datenblatt steht „no default password“. Beschreibe zwei Konsequenzen für die Inbetriebnahme und den Betrieb.',
        kriterien: [
          krit(
            'Bei der Einrichtung muss ein eigenes, sicheres Passwort gesetzt werden',
            punkte: 2,
            stichwoerter: [
              'eigenes Passwort',
              'Passwort setzen',
              'Passwort vergeben',
              'neues Passwort',
            ],
          ),
          krit(
            'Die Geräte des Herstellers teilen sich kein bekanntes Passwort - Angreifer können sich nicht mit Standarddaten anmelden',
            punkte: 2,
            stichwoerter: [
              'kein bekanntes Passwort',
              'nicht alle Geräte',
              'Angreifer',
              'Standardpasswort',
            ],
          ),
          krit(
            'Ohne gesetztes Passwort ist kein Zugriff auf die Kamera möglich; das Passwort muss dokumentiert werden',
            punkte: 2,
            stichwoerter: [
              'kein Zugriff',
              'dokumentieren',
              'Passwortverwaltung',
            ],
          ),
        ],
        punkte: 4,
        loesung:
            'Die Kamera wird ohne voreingestelltes Passwort geliefert. Bei der ersten Anmeldung muss deshalb ein eigenes, sicheres Passwort vergeben und dokumentiert werden - vorher ist kein Zugriff möglich. Vorteil: Es gibt kein Passwort, das alle Geräte des Herstellers teilen und das Angreifer aus dem Handbuch kennen.',
        explanation:
            'Bewertung: 2 Punkte je beschriebener Konsequenz, höchstens 4 Punkte.',
        tags: ['englisch', 'datenblatt'],
      ),
      freitext(
        'f-a03h-logistik-b',
        'h-komponenten',
        scenario:
            'Laut Datenblatt steigt die Leistungsaufnahme mit Infrarot (11 W) und mit Infrarot und Heizung („heater“, 21 W).',
        prompt: 'Nenne den Zweck der Infrarot-LEDs und den Zweck der Heizung.',
        kriterien: [
          krit(
            'Infrarot: Aufnahmen bei Dunkelheit (Nachtsicht)',
            stichwoerter: ['Nacht', 'Dunkelheit', 'dunkel', 'Nachtsicht'],
          ),
          krit(
            'Heizung: verhindert Vereisen und Beschlagen bei Kälte',
            stichwoerter: ['Vereisung', 'Eis', 'Beschlag', 'Kälte', 'Frost'],
          ),
        ],
        loesung:
            'Die Infrarot-LEDs beleuchten die Szene unsichtbar und ermöglichen Aufnahmen bei Dunkelheit. Die Heizung verhindert, dass die Kamera an den offenen Verladetoren bei Kälte vereist oder beschlägt.',
        punkte: 2,
        explanation:
            'Bewertung: je Nennung 1 Punkt. Infrarot dient der Nachtsicht, die Heizung schützt vor Vereisung und Beschlag - beides erhöht die Leistungsaufnahme.',
      ),
      lueckentext(
        'f-a03h-logistik-c',
        'nw-geraete',
        scenario:
            'Die Kameras laufen an den Toren mit Infrarot und Heizung (21 W). Der Switch speist 48 V ein. Es gilt P = U × I.',
        table: [
          ['Standard', 'Leistung am Switch-Port'],
          ['IEEE 802.3af', 'bis 15,4 W'],
          ['IEEE 802.3at', 'bis 30 W'],
        ],
        prompt:
            'Wähle den passenden PoE-Standard und berechne die Stromstärke je Kamera.',
        text:
            'Passender Standard: {0}\n'
            'Stromstärke: {1} A\n'
            'Stromstärke: {2} mA',
        luecken: [
          wahl('IEEE 802.3at', ['IEEE 802.3af', 'keiner von beiden']),
          zahl(0.4375, toleranz: 0.0005, rationale: 'I = 21 W / 48 V'),
          zahl(437.5, toleranz: 0.5, rationale: '0,4375 A × 1.000'),
        ],
        punkte: 4,
        explanation:
            '21 W liegen über 15,4 W, aber unter 30 W - nur IEEE 802.3at reicht. I = P / U = 21 W / 48 V = 0,4375 A = 437,5 mA. 2 Punkte für den Standard, 2 Punkte für die Stromstärke.',
      ),
      rechnen(
        'f-a03h-logistik-d',
        'h-speicher',
        scenario:
            'Die Kamera liefert 2560 × 1440 Pixel mit 25 Bildern pro Sekunde und 24 Bit Farbtiefe. Der Videostrom wird auf 5 % der ursprünglichen Datenmenge komprimiert.',
        prompt:
            'Berechne die Datenrate des komprimierten Videostroms in Mbit/s (1 Mbit = 1.000.000 Bit). Runde auf volle Mbit/s.',
        answer: 111,
        unit: 'Mbit/s',
        punkte: 4,
        explanation:
            'Unkomprimiert: 2560 × 1440 × 24 Bit × 25 = 2.211.840.000 Bit/s = 2.211,84 Mbit/s. Komprimiert auf 5 %: 2.211,84 × 0,05 = 110,592 Mbit/s, gerundet 111 Mbit/s. „Auf 5 %“ heißt Faktor 0,05.',
        difficulty: 3,
      ),
      rechnen(
        'f-a03h-logistik-e',
        'h-speicher',
        scenario:
            'Alle sechs Kameras zeichnen ununterbrochen auf. Rechne mit 111 Mbit/s je Kamera; gespeichert werden 48 Stunden.',
        prompt:
            'Berechne den Speicherbedarf in TiB (1 TiB = 1.024⁴ Byte). Runde auf volle TiB auf.',
        answer: 14,
        unit: 'TiB',
        punkte: 5,
        explanation:
            'Alle Kameras: 6 × 111 Mbit/s = 666 Mbit/s = 666.000.000 Bit/s. Zeit: 48 × 3.600 s = 172.800 s. Datenmenge: 666.000.000 × 172.800 / 8 = 14.385.600.000.000 Byte. In TiB: / 1.024⁴ ≈ 13,08 TiB. Aufgerundet 14 TiB, weil der Speicher reichen muss.',
        difficulty: 3,
      ),
      rechnen(
        'f-a03h-logistik-f',
        'nw-geraete',
        scenario:
            'Die sechs Kameras (je 21 W) hängen an einem PoE-Switch mit einem Gesamtbudget von 150 W.',
        prompt:
            'Berechne, wie viel Watt des PoE-Budgets für weitere Geräte frei bleiben.',
        answer: 24,
        unit: 'W',
        punkte: 3,
        explanation:
            'Bedarf: 6 × 21 W = 126 W. Frei: 150 W - 126 W = 24 W. Das reicht für eine weitere Kamera, aber nicht für zwei.',
      ),
      freitext(
        'f-a03h-logistik-g',
        'nw-geraete',
        scenario:
            'An den Verladetoren gibt es keine Steckdosen in der Nähe der Montageorte. Die Kameras werden deshalb über den PoE-Switch versorgt.',
        prompt:
            'Erläutere einen Vorteil der Stromversorgung per PoE gegenüber einzelnen Netzteilen an den Verladetoren.',
        kriterien: [
          krit(
            'Daten und Strom laufen über ein Kabel - am Montageort wird keine Steckdose gebraucht, die Installation ist einfacher',
            punkte: 3,
            stichwoerter: [
              'ein Kabel',
              'keine Steckdose',
              'Installation',
              'Netzwerkkabel',
            ],
          ),
          krit(
            'Zentrale Versorgung über den Switch: Hängt er an einer USV, laufen bei einem Stromausfall auch die Kameras weiter',
            punkte: 3,
            stichwoerter: ['USV', 'zentral', 'Stromausfall'],
          ),
          krit(
            'Geräte lassen sich zentral am Switch aus- und einschalten (Neustart aus der Ferne)',
            punkte: 3,
            stichwoerter: ['aus der Ferne', 'neu starten', 'Port abschalten'],
          ),
        ],
        punkte: 3,
        loesung:
            'Bei PoE liefert der Switch den Strom über das Netzwerkkabel. An den Verladetoren muss deshalb keine Steckdose installiert werden; ein einziges Kabel je Kamera genügt. Hängt der Switch an einer USV, laufen bei einem Stromausfall auch alle Kameras weiter.',
        explanation: 'Bewertung: Vorteil plus Erläuterung ergeben 3 Punkte.',
      ),
    ],
  ),
  fall(
    'f-a03n-logistik',
    firma: 'logistik',
    bereich: 'a03',
    titel: 'Neue Lagerhalle ans Netz anbinden',
    situation:
        'Die neue Lagerhalle der Elbtal Logistik AG wird an das Firmennetz angeschlossen. In der Halle arbeiten mobile Handscanner über WLAN; dazu kommen Büro-PCs, Kameras und die Netzwerktechnik. Der Halle ist das Netz 10.50.8.0/24 zugeteilt, zusätzlich das IPv6-Netz 2001:db8:5a0:1c::/64.',
    teile: [
      tabelle(
        'f-a03n-logistik-a',
        'nw-ipv4',
        scenario:
            'Das Netz 10.50.8.0/24 wird in vier gleich große Subnetze geteilt: Büro, Handscanner, Kameras und Netzwerktechnik.',
        prompt: 'Ergänze die Subnetztabelle.',
        zeilen: [
          ['Subnetz', 'Netzadresse', 'erster Host', 'Broadcast'],
          ['Büro', '10.50.8.0', '10.50.8.1', '10.50.8.63'],
          [
            'Handscanner',
            wort(['10.50.8.64']),
            '10.50.8.65',
            wort(['10.50.8.127']),
          ],
          [
            'Kameras',
            wort(['10.50.8.128']),
            wort(['10.50.8.129']),
            '10.50.8.191',
          ],
          [
            'Netzwerktechnik',
            wort(['10.50.8.192']),
            '10.50.8.193',
            wort(['10.50.8.255']),
          ],
        ],
        punkte: 6,
        explanation:
            'Vier Subnetze brauchen 2 zusätzliche Bits: /26 mit Blockgröße 64. Netzadressen .0, .64, .128, .192; Broadcast ist jeweils die Adresse vor dem nächsten Block (.63, .127, .191, .255). Je Zelle 1 Punkt.',
      ),
      lueckentext(
        'f-a03n-logistik-b',
        'nw-ipv4',
        scenario:
            'Im Subnetz der Handscanner ist der Router das Gateway mit der ersten nutzbaren Adresse. Der Access Point erhält die vorletzte nutzbare Adresse dieses Subnetzes.',
        skizze: const NetzSkizze(
          [
            NetzKnoten('rt', 'Router .65', NetzTyp.router, 1.5, 0),
            NetzKnoten('sw', 'Switch', NetzTyp.switch_, 1.5, 1.5),
            NetzKnoten('ap', 'Access Point', NetzTyp.accessPoint, 1.5, 3),
            NetzKnoten('hs', 'Scanner', NetzTyp.smartphone, 1.5, 4.5),
          ],
          verbindungen: [
            NetzVerbindung('rt', 'sw'),
            NetzVerbindung('sw', 'ap'),
            NetzVerbindung('ap', 'hs', funk: true),
          ],
        ),
        prompt: 'Trage die IPv4-Konfiguration des Access Points ein.',
        text:
            'IP-Adresse: {0}\n'
            'Subnetzmaske: {1}\n'
            'Standardgateway: {2}',
        luecken: [
          wort(['10.50.8.125'], 'Broadcast .127, letzte .126, vorletzte .125'),
          wort(['255.255.255.192'], '/26'),
          wort(['10.50.8.65'], 'erste nutzbare Adresse'),
        ],
        punkte: 3,
        explanation:
            'Subnetz 10.50.8.64/26: Hosts .65 bis .126, Broadcast .127. Vorletzte nutzbare Adresse 10.50.8.125, Maske 255.255.255.192, Gateway 10.50.8.65. Je Wert 1 Punkt.',
      ),
      freitext(
        'f-a03n-logistik-c',
        'nw-geraete',
        scenario:
            'Ein Büro-PC in der Halle wird an Dose 5 angeschlossen und bekommt keine Verbindung. An Dose 6 daneben funktioniert derselbe PC sofort. Im Verteilerschrank steckt am Patchfeld-Port 5 kein Kabel.',
        prompt: 'Erläutere die Ursache und beschreibe eine Lösung.',
        kriterien: [
          krit(
            'Dose 5 ist am Patchfeld nicht mit dem Switch verbunden (nicht gepatcht)',
            punkte: 2,
            stichwoerter: [
              'nicht gepatcht',
              'nicht mit dem Switch verbunden',
              'kein Patchkabel',
              'nicht verbunden',
            ],
          ),
          krit(
            'Lösung: Port 5 per Patchkabel mit einem freien Switch-Port verbinden oder Dose 6 nutzen',
            stichwoerter: ['patchen', 'Patchkabel', 'Dose 6', 'Switch-Port'],
          ),
        ],
        loesung:
            'PC und Kabel sind in Ordnung, denn an Dose 6 funktioniert alles. Dose 5 endet im Verteilerschrank am Patchfeld-Port 5, der nicht per Patchkabel mit dem Switch verbunden ist - die Dose ist nicht gepatcht. Lösung: Port 5 an einen freien Switch-Port patchen oder den PC an Dose 6 betreiben.',
        punkte: 3,
        explanation:
            'Bewertung: 2 Punkte für die Ursache, 1 Punkt für die Lösung.',
      ),
      lueckentext(
        'f-a03n-logistik-d',
        'nw-ipv6',
        scenario:
            'Das IPv6-Netz der Halle lautet 2001:db8:5a0:1c::/64. Die ersten 48 Bit sind das Standortpräfix des Unternehmens, die nächsten 16 Bit die Subnetz-ID.',
        prompt: 'Ergänze die Angaben.',
        text:
            'Standortpräfix, ungekürzt: {0}\n'
            'Subnetz-ID, ungekürzt: {1}\n'
            'Mögliche Subnetze je Standort: {2}\n'
            'Adresse eines Geräts mit der Interface-ID ::20, gekürzt: {3}',
        luecken: [
          wort(['2001:0db8:05a0'], 'drei Blöcke zu je vier Hex-Ziffern'),
          wort(['001c'], 'auf vier Hex-Ziffern aufgefüllt'),
          zahl(65536, rationale: '2¹⁶'),
          wort(['2001:db8:5a0:1c::20'], 'Präfix und Interface-ID zusammen'),
        ],
        punkte: 4,
        explanation:
            'Ausgeschrieben hat jeder Block vier Hex-Ziffern: 2001:0db8:05a0 (48 Bit) und 001c (16 Bit). Mit 16 Bit lassen sich 2¹⁶ = 65.536 Subnetze bilden. Die Geräteadresse: 2001:db8:5a0:1c::20. Je Wert 1 Punkt.',
      ),
      freitext(
        'f-a03n-logistik-e',
        'nw-geraete',
        scenario:
            'Für die Handscanner wird in der Halle ein WLAN mit mehreren Access Points aufgebaut.',
        prompt:
            'Nenne drei Maßnahmen, mit denen das WLAN der Handscanner abgesichert bzw. zuverlässig geplant wird.',
        kriterien: [
          krit(
            'Verschlüsselung mit WPA3 oder mindestens WPA2',
            stichwoerter: ['WPA3', 'WPA2', 'Verschlüsselung'],
          ),
          krit(
            'eigenes VLAN bzw. Subnetz für die Handscanner, getrennt vom Büronetz',
            stichwoerter: ['VLAN', 'Subnetz', 'getrennt', 'Trennung'],
          ),
          krit(
            'Anmeldung je Gerät mit WPA-Enterprise (802.1X) statt eines gemeinsamen Kennworts',
            stichwoerter: ['802.1X', 'Enterprise', 'RADIUS', 'Zertifikat'],
          ),
          krit(
            'mehrere Access Points mit gleicher SSID für lückenlose Abdeckung, Ausleuchtung messen',
            stichwoerter: [
              'Abdeckung',
              'SSID',
              'Ausleuchtung',
              'mehrere Access Points',
            ],
          ),
          krit(
            'Kanäle überlappungsfrei planen, 5 GHz nutzen',
            stichwoerter: ['Kanal', 'Kanäle', '5 GHz', 'überlappungsfrei'],
          ),
        ],
        punkte: 3,
        loesung:
            'Das WLAN wird mit WPA3 (mindestens WPA2) verschlüsselt, die Handscanner erhalten ein eigenes VLAN getrennt vom Büronetz, und mehrere Access Points mit derselben SSID sorgen für lückenlose Abdeckung der Halle.',
        explanation: 'Bewertung: je Nennung 1 Punkt, höchstens 3 Punkte.',
      ),
      markieren(
        'f-a03n-logistik-f',
        'b-cli',
        scenario:
            'Im hinteren Regalgang verlieren die Handscanner immer wieder die Verbindung. Vom Leitstand aus wird ein Scanner im vorderen und einer im hinteren Gang angepingt.',
        prompt: 'Markiere alle auffälligen Zeilen der Auswertung.',
        mono: true,
        zeilen: [
          nein('Scanner vorn:   Minimum 3ms', 'Im WLAN normal.'),
          nein('Scanner vorn:   Maximum 9ms', 'Im WLAN normal.'),
          nein('Scanner vorn:   0% Verlust', 'Kein Paketverlust.'),
          nein(
            'Scanner hinten: Minimum 6ms',
            'Der kleinste Wert ist unauffällig.',
          ),
          ja(
            'Scanner hinten: Maximum 940ms',
            'Fast eine Sekunde - die Verbindung ist zeitweise sehr schlecht.',
          ),
          ja(
            'Scanner hinten: Mittelwert 310ms',
            'Im eigenen Netz viel zu hoch.',
          ),
          ja(
            'Scanner hinten: 30% Verlust',
            'Fast jedes dritte Paket geht verloren.',
          ),
        ],
        punkte: 3,
        explanation:
            'Der Scanner im vorderen Gang antwortet schnell und verlustfrei. Im hinteren Gang fallen Maximum, Mittelwert und Paketverlust auf - dort ist die Funkverbindung gestört.',
      ),
      freitext(
        'f-a03n-logistik-g',
        'b-cli',
        scenario:
            'Der Handscanner im hinteren Regalgang antwortet im Mittel erst nach 310 ms, im schlechtesten Fall nach 940 ms; 30 % der Pakete gehen verloren.',
        prompt:
            'Beschreibe ein Problem, das diese Werte für die Arbeit mit den Handscannern bedeuten, und nenne eine mögliche Ursache.',
        kriterien: [
          krit(
            'Problem: Buchungen werden verzögert oder gar nicht übertragen, die Scanner-Anwendung hängt oder bricht mit Zeitüberschreitung ab',
            punkte: 2,
            stichwoerter: [
              'verzögert',
              'Abbruch',
              'Timeout',
              'Zeitüberschreitung',
              'hängt',
            ],
          ),
          krit(
            'Ursache: schwaches WLAN-Signal im hinteren Gang, z. B. zu großer Abstand zum Access Point oder Abschirmung durch Metallregale',
            stichwoerter: [
              'Signal',
              'Abdeckung',
              'Metall',
              'Regale',
              'Access Point',
              'Reichweite',
            ],
          ),
        ],
        loesung:
            'Durch hohe Antwortzeiten und Paketverlust kommen Buchungen verspätet oder gar nicht beim Lagerverwaltungssystem an; die Anwendung auf dem Scanner hängt oder meldet Zeitüberschreitungen. Mögliche Ursache: Das WLAN-Signal ist im hinteren Gang zu schwach, weil der Access Point zu weit entfernt ist oder Metallregale das Signal abschirmen.',
        punkte: 3,
        explanation:
            'Bewertung: 2 Punkte für das beschriebene Problem, 1 Punkt für eine plausible Ursache.',
      ),
    ],
  ),
];
