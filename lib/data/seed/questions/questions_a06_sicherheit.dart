import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 06, Teil 1: Schutzziele, Bedrohungen und
/// technische Schutzmaßnahmen.
final List<Question> questionsA06Sicherheit = [
  // ================================================================ Schutzziele
  zuordnen(
    'a6-zz-1',
    'sz-schutzziele',
    prompt: 'Welches Schutzziel ist durch den Vorfall verletzt?',
    buckets: ['Vertraulichkeit', 'Integrität', 'Verfügbarkeit'],
    items: [
      zu(
        'Ein Azubi öffnet die Gehaltsliste in einem für alle freigegebenen Ordner',
        0,
        'Unbefugte Einsicht - die Daten selbst bleiben unverändert und verfügbar.',
      ),
      zu(
        'Ein Angreifer ändert die IBAN in einer Rechnungsvorlage',
        1,
        'Die Daten wurden unbemerkt verfälscht.',
      ),
      zu(
        'Der Webshop ist nach einem Stromausfall drei Stunden nicht erreichbar',
        2,
        'Der Dienst ist nicht nutzbar, als er gebraucht wird.',
      ),
      zu(
        'Ein Übertragungsfehler verfälscht Messwerte in der Datenbank',
        1,
        'Die Daten sind nicht mehr korrekt - auch ohne Angreifer ist die Integrität verletzt.',
      ),
      zu(
        'Ein Mitarbeiter fotografiert Kundendaten vom Bildschirm und verkauft sie',
        0,
        'Die Daten gelangen an Unbefugte.',
      ),
    ],
    explanation:
        'Gesehen -> Vertraulichkeit, verändert -> Integrität, nicht erreichbar -> Verfügbarkeit.',
  ),
  rechnen(
    'a6-zz-2',
    'sz-schutzziele',
    scenario:
        'Ein Hosting-Anbieter garantiert im Vertrag eine Verfügbarkeit von 99,5 % bei Betrieb rund um die Uhr an 365 Tagen.',
    prompt:
        'Wie viele Stunden darf der Dienst pro Jahr höchstens ausfallen? (auf eine Nachkommastelle)',
    answer: 43.8,
    tolerance: 0.05,
    unit: 'h',
    explanation:
        'Stunden pro Jahr: 365 × 24 h = 8.760 h. Erlaubter Ausfall: 100 % - 99,5 % = 0,5 % = 0,005. 0,005 × 8.760 h = 43,8 h.',
  ),
  einfach(
    'a6-zz-3',
    'sz-schutzziele',
    scenario:
        'Ein Kunde behauptet, er habe eine Online-Bestellung über 12.000 € nie abgeschickt.',
    prompt: 'Welches Schutzziel soll genau diesen Fall verhindern?',
    choices: [
      ja(
        'Verbindlichkeit (Nichtabstreitbarkeit)',
        'Sie stellt sicher, dass eine Handlung später nicht geleugnet werden kann, etwa durch eine digitale Signatur.',
      ),
      nein(
        'Vertraulichkeit',
        'Sie schützt vor unbefugtem Mitlesen, nicht vor dem Abstreiten einer Handlung.',
      ),
      nein(
        'Verfügbarkeit',
        'Sie betrifft die Erreichbarkeit des Shops, nicht den Nachweis der Bestellung.',
      ),
      nein(
        'Integrität',
        'Sie schützt die Bestelldaten vor Veränderung, beweist aber nicht, wer die Bestellung abgegeben hat.',
      ),
    ],
    explanation:
        'Verbindlichkeit bedeutet, dass eine Person eine Handlung nicht abstreiten kann. Technisch wird das mit digitalen Signaturen und Protokollen erreicht.',
  ),
  mehrfach(
    'a6-zz-4',
    'sz-schutzziele',
    prompt: 'Welche Maßnahmen dienen in erster Linie der Verfügbarkeit?',
    choices: [
      ja(
        'Unterbrechungsfreie Stromversorgung (USV) für den Server',
        'Überbrückt Stromausfälle und hält den Dienst am Laufen.',
      ),
      ja(
        'Zweite Internetleitung eines anderen Providers',
        'Fällt eine Leitung aus, bleibt der Zugang über die andere bestehen.',
      ),
      ja(
        'Regelmäßige Datensicherung',
        'Nach Datenverlust lassen sich die Daten wieder nutzbar machen.',
      ),
      nein(
        'Verschlüsselung der Notebook-Festplatten',
        'Schützt die Vertraulichkeit bei Diebstahl, nicht die Verfügbarkeit.',
      ),
      nein(
        'Prüfsumme (Hashwert) für einen Download',
        'Macht Veränderungen sichtbar und dient damit der Integrität.',
      ),
    ],
    explanation:
        'Verfügbarkeit sichern Redundanz, Stromversorgung und Datensicherung. Verschlüsselung dient der Vertraulichkeit, Hashwerte der Integrität.',
  ),
  rechnen(
    'a6-zz-5',
    'sz-schutzziele',
    scenario:
        'Ein Cloud-Anbieter sichert für sein Ticketsystem eine Verfügbarkeit von 99,95 % zu. Das System läuft rund um die Uhr. Gerechnet wird mit einem Monat von 30 Tagen.',
    prompt:
        'Wie viele Minuten darf das System in einem Monat höchstens ausfallen?',
    answer: 21.6,
    tolerance: 0.05,
    unit: 'min',
    difficulty: 2,
    explanation:
        'Stunden im Monat: 30 × 24 h = 720 h. Erlaubter Ausfallanteil: 100 % - 99,95 % = 0,05 % = 0,0005. Ausfall: 0,0005 × 720 h = 0,36 h = 0,36 × 60 min = 21,6 min.',
  ),
  rechnen(
    'a6-zz-6',
    'sz-schutzziele',
    scenario:
        'Ein Webshop ist nur erreichbar, wenn Internetleitung (99 %), Firewall (99,9 %) und Webserver (99,5 %) gleichzeitig funktionieren. Es gibt keine Redundanz.',
    prompt:
        'Wie hoch ist die Gesamtverfügbarkeit des Shops in Prozent? (auf zwei Nachkommastellen)',
    answer: 98.41,
    tolerance: 0.01,
    unit: '%',
    difficulty: 3,
    explanation:
        'Bei Komponenten in Reihe werden die Verfügbarkeiten multipliziert: 0,99 × 0,999 = 0,98901; 0,98901 × 0,995 = 0,98406495. Das sind gerundet 98,41 % - weniger als jede einzelne Komponente.',
  ),
  zuordnen(
    'a6-zz-7',
    'sz-schutzziele',
    scenario: 'Ein Steuerbüro stellt sein Sicherheitskonzept vor.',
    prompt: 'Welches Schutzziel unterstützt die jeweilige Maßnahme vor allem?',
    buckets: [
      'Vertraulichkeit',
      'Integrität',
      'Verfügbarkeit',
      'Authentizität',
    ],
    items: [
      zu(
        'VPN-Verschlüsselung für die Arbeit im Homeoffice',
        0,
        'Die Verschlüsselung verhindert, dass Unbefugte die übertragenen Mandantendaten mitlesen.',
      ),
      zu(
        'Hashwert jeder Sicherungsdatei wird nach dem Kopieren verglichen',
        1,
        'Der Vergleich zeigt, ob die Sicherung unverändert und fehlerfrei ist.',
      ),
      zu(
        'Zweiter Server, der bei einem Defekt sofort übernimmt',
        2,
        'Redundanz hält den Dienst am Laufen.',
      ),
      zu(
        'Serverzertifikat für das Mandantenportal',
        3,
        'Das Zertifikat weist nach, dass das Portal wirklich dem Steuerbüro gehört.',
      ),
      zu(
        'Vier-Augen-Prinzip bei Änderungen an Bankverbindungen',
        1,
        'Eine zweite Person verhindert unbemerkte oder falsche Änderungen an den Daten.',
      ),
    ],
    explanation:
        'Verschlüsselung schützt die Vertraulichkeit, Prüfsummen und Kontrollen die Integrität, Redundanz die Verfügbarkeit und Zertifikate die Authentizität.',
  ),

  // ============================================================= Schadsoftware
  zuordnen(
    'a6-zm-1',
    'sz-schadsoftware',
    prompt: 'Welche Art von Schadsoftware wird beschrieben?',
    buckets: ['Virus', 'Wurm', 'Trojaner'],
    items: [
      zu(
        'Hängt sich an eine ausführbare Datei und wird aktiv, wenn diese gestartet wird',
        0,
        'Die Wirtsdatei ist das Kennzeichen des Virus.',
      ),
      zu(
        'Nutzt eine Lücke in einem Netzwerkdienst und befällt selbstständig weitere Rechner',
        1,
        'Selbstständige Verbreitung über das Netz kennzeichnet den Wurm.',
      ),
      zu(
        'Kostenloses PDF-Werkzeug, das nach der Installation heimlich eine Hintertür öffnet',
        2,
        'Getarnt als nützliches Programm und vom Nutzer selbst installiert.',
      ),
      zu(
        'Verbreitet sich ohne jedes Zutun der Nutzer im gesamten Firmennetz',
        1,
        'Kein Wirt, keine Nutzeraktion - ein Wurm.',
      ),
    ],
    explanation:
        'Virus: braucht eine Wirtsdatei. Wurm: verbreitet sich selbstständig über das Netz. Trojaner: tarnt sich als nützliches Programm.',
  ),
  einfach(
    'a6-zm-2',
    'sz-schadsoftware',
    scenario:
        'Nach dem Öffnen eines Mail-Anhangs lassen sich die Dateien auf dem Netzlaufwerk nicht mehr öffnen. Sie tragen die Endung .locked, und eine Textdatei fordert eine Zahlung in Bitcoin.',
    prompt: 'Welche Art von Schadsoftware ist am Werk?',
    choices: [
      ja(
        'Ransomware',
        'Sie verschlüsselt Daten und erpresst Lösegeld für die Entschlüsselung.',
      ),
      nein(
        'Adware',
        'Adware blendet Werbung ein, verschlüsselt aber keine Dateien.',
      ),
      nein(
        'Keylogger',
        'Ein Keylogger zeichnet heimlich Tastatureingaben auf und macht sich nicht durch Erpressung bemerkbar.',
      ),
      nein(
        'Rootkit',
        'Ein Rootkit versteckt Schadsoftware im System, statt offen Lösegeld zu fordern.',
      ),
    ],
    explanation:
        'Verschlüsselte Dateien und eine Lösegeldforderung sind das typische Bild eines Ransomware-Angriffs.',
  ),
  einfach(
    'a6-zm-3',
    'sz-schadsoftware',
    scenario:
        'Eine Kollegin bemerkt, dass auf ihrem PC gerade Dateien umbenannt und unlesbar werden.',
    prompt: 'Was sollte sie als Erstes tun?',
    choices: [
      ja(
        'Den PC vom Netz trennen und sofort die IT informieren',
        'So kann die Ransomware keine weiteren Netzlaufwerke und Rechner erreichen, und die IT kann reagieren.',
      ),
      nein(
        'Das geforderte Lösegeld zahlen, damit es schnell weitergeht',
        'Eine Zahlung garantiert keine Entschlüsselung und finanziert weitere Angriffe.',
      ),
      nein(
        'Den PC neu starten und weiterarbeiten',
        'Die Schadsoftware bleibt aktiv und verschlüsselt weiter.',
      ),
      nein(
        'Die noch lesbaren Dateien per Mail an Kollegen schicken',
        'Das kann die Schadsoftware weiterverbreiten und hält den Angriff nicht auf.',
      ),
    ],
    explanation:
        'Bei Ransomware zählt jede Minute: Netzverbindung trennen, damit sich die Verschlüsselung nicht ausbreitet, und den Vorfall sofort melden.',
  ),
  mehrfach(
    'a6-zm-4',
    'sz-schadsoftware',
    prompt: 'Welche Aussagen sind richtig?',
    choices: [
      ja(
        'Ein Botnetz besteht aus vielen ferngesteuerten Rechnern, die z. B. für DDoS-Angriffe genutzt werden.',
        'Die Rechner werden unbemerkt über einen Steuerserver kontrolliert.',
      ),
      ja(
        'Ein Rootkit verbirgt Schadsoftware vor Betriebssystem und Virenscanner.',
        'Deshalb ist es besonders schwer zu entdecken.',
      ),
      ja(
        'Ein Keylogger kann Passwörter abgreifen, indem er Tastatureingaben aufzeichnet.',
        'Genau das ist seine Schadfunktion.',
      ),
      nein(
        'Adware verschlüsselt Daten und fordert Lösegeld.',
        'Das beschreibt Ransomware - Adware blendet Werbung ein.',
      ),
      nein(
        'Ein Virus verbreitet sich ohne Wirtsdatei selbstständig über das Netz.',
        'Das beschreibt einen Wurm - ein Virus braucht eine Wirtsdatei.',
      ),
    ],
    explanation:
        'Botnetz: ferngesteuerte Rechner. Rootkit: Tarnung im System. Keylogger: Tastaturmitschnitt. Adware und Virus sind falsch beschrieben.',
  ),
  einfach(
    'a6-zm-5',
    'sz-schadsoftware',
    scenario:
        'Bei einer Analyse wird auf einem Server ein Programm entdeckt, das mit Administratorrechten läuft und seine eigenen Dateien und Prozesse vor dem Task-Manager und dem Virenscanner verbirgt.',
    prompt: 'Um welche Art von Schadsoftware handelt es sich?',
    choices: [
      ja(
        'Rootkit',
        'Ein Rootkit nistet sich tief im System ein und versteckt sich und andere Schädlinge vor Betriebssystem und Schutzprogrammen.',
      ),
      nein(
        'Adware',
        'Adware fällt gerade durch eingeblendete Werbung auf, statt sich zu verstecken.',
      ),
      nein(
        'Wurm',
        'Ein Wurm ist über seine selbstständige Verbreitung definiert, nicht über Tarnung im System.',
      ),
      nein(
        'Scareware',
        'Scareware macht mit falschen Warnungen auf sich aufmerksam, um Nutzer zum Kauf zu drängen.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Kennzeichen eines Rootkits ist die Tarnung: Es verbirgt Dateien, Prozesse und Netzverbindungen, oft mit höchsten Rechten. Entfernen ist schwierig, meist wird das System neu aufgesetzt.',
  ),
  mehrfach(
    'a6-zm-6',
    'sz-schadsoftware',
    scenario:
        'Eine Anwaltskanzlei mit 15 Arbeitsplätzen will sich nach einem Ransomware-Fall bei einer befreundeten Kanzlei besser schützen.',
    prompt: 'Welche Maßnahmen helfen wirksam gegen Ransomware?',
    choices: [
      ja(
        'Eine Sicherung, die offline oder unveränderbar aufbewahrt wird',
        'Diese Kopie kann die Ransomware nicht erreichen und verschlüsseln.',
      ),
      ja(
        'Makros in Office-Dokumenten aus dem Internet blockieren',
        'Makros in Mail-Anhängen sind ein häufiger Infektionsweg.',
      ),
      ja(
        'Sicherheitsupdates zeitnah einspielen',
        'Updates schließen Lücken, über die sich Ransomware verbreitet.',
      ),
      ja(
        'Im Alltag ohne Administratorrechte arbeiten',
        'Mit eingeschränkten Rechten kann Schadsoftware weniger Schaden anrichten.',
      ),
      nein(
        'Die Sicherung auf ein dauerhaft verbundenes Netzlaufwerk schreiben',
        'Dauerhaft erreichbare Sicherungen verschlüsselt die Ransomware gleich mit.',
      ),
      nein(
        'Eine Rücklage für das Lösegeld bilden',
        'Eine Zahlung garantiert keine Entschlüsselung und ist keine Schutzmaßnahme.',
      ),
    ],
    explanation:
        'Gegen Ransomware wirkt die Kombination: Infektionswege schließen (Updates, Makros blockieren), Schaden begrenzen (keine Adminrechte) und eine Sicherung, die die Schadsoftware nicht erreichen kann.',
  ),
  zuordnen(
    'a6-zm-7',
    'sz-schadsoftware',
    prompt: 'Welche Art von Schadsoftware passt zur Beobachtung?',
    buckets: ['Ransomware', 'Spyware', 'Keylogger', 'Bot'],
    items: [
      zu(
        'Dateien tragen plötzlich die Endung .crypt, eine Textdatei fordert Zahlung',
        0,
        'Verschlüsseln und Erpressen ist das Kennzeichen von Ransomware.',
      ),
      zu(
        'Ein Programm schickt heimlich Browserverlauf und Standort an einen fremden Server',
        1,
        'Heimliches Ausspähen von Nutzerdaten ist Spyware.',
      ),
      zu(
        'Jeder Tastendruck wird aufgezeichnet, so gelangt das Banking-Passwort nach außen',
        2,
        'Das Mitschneiden der Tastatur ist die Schadfunktion eines Keyloggers.',
      ),
      zu(
        'Der PC nimmt nachts auf Befehl eines Steuerservers an Angriffen auf einen Webshop teil',
        3,
        'Ein fernsteuerbarer Rechner als Teil eines Botnetzes ist ein Bot.',
      ),
    ],
    explanation:
        'Ransomware erpresst, Spyware späht Daten aus, ein Keylogger zeichnet Eingaben auf, ein Bot wird ferngesteuert und ist Teil eines Botnetzes.',
  ),
  einfach(
    'a6-zm-8',
    'sz-schadsoftware',
    prompt: 'Was ist eine Zero-Day-Lücke?',
    choices: [
      ja(
        'Eine Sicherheitslücke, die dem Hersteller noch unbekannt ist oder für die es noch kein Update gibt',
        'Der Hersteller hatte „null Tage“ Zeit, sie zu schließen - Angreifer nutzen sie schon aus.',
      ),
      nein(
        'Eine Lücke, die am Tag der Installation automatisch geschlossen wird',
        'Das Gegenteil: Für eine Zero-Day-Lücke gibt es gerade noch keinen Patch.',
      ),
      nein(
        'Ein Virus, der sich nach null Tagen selbst löscht',
        'Zero-Day beschreibt eine Lücke, keine Art von Schadsoftware.',
      ),
      nein(
        'Eine Lücke, die nur am ersten Tag des Monats angreifbar ist',
        'Der Name hat nichts mit einem Datum zu tun.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Eine Zero-Day-Lücke ist noch nicht geschlossen. Dagegen helfen nur Schutz in mehreren Schichten, minimale Rechte und Verhaltenserkennung, bis ein Update erscheint.',
  ),

  // ======================================================= Angriffe und Social Engineering
  zuordnen(
    'a6-za-1',
    'sz-angriffe',
    prompt: 'Welcher Angriff wird beschrieben?',
    buckets: ['Vishing', 'Tailgating', 'CEO-Fraud', 'DDoS'],
    items: [
      zu(
        'Ein angeblicher Support-Mitarbeiter ruft an und verlangt Fernzugriff auf den PC',
        0,
        'Social Engineering per Telefon.',
      ),
      zu(
        'Eine Person mit Kartons in den Händen folgt Mitarbeitenden durch die gesicherte Tür',
        1,
        'Sie nutzt die Zutrittsberechtigung anderer aus.',
      ),
      zu(
        'Der angebliche Geschäftsführer fordert per Mail eine eilige, vertrauliche Überweisung',
        2,
        'Autorität, Zeitdruck und Geheimhaltung - typisch für CEO-Fraud.',
      ),
      zu(
        'Tausende gekaperte Rechner legen den Webshop mit Anfragen lahm',
        3,
        'Überlastung aus vielen Quellen, meist einem Botnetz.',
      ),
    ],
    explanation:
        'Vishing nutzt das Telefon, Tailgating die Tür, CEO-Fraud die Autorität der Chefin oder des Chefs. DDoS ist ein technischer Angriff auf die Verfügbarkeit.',
  ),
  mehrfach(
    'a6-za-2',
    'sz-angriffe',
    scenario:
        'Eine Mail von service@sparkasse-kontosicherheit.info beginnt mit „Sehr geehrter Kunde“ und droht: „Ihr Konto wird in 24 Stunden gesperrt.“ Der Link zeigt „www.sparkasse.de“ an, führt beim Überfahren mit der Maus aber zu einer ganz anderen Adresse. Dort sollen die Online-Banking-Zugangsdaten eingegeben werden. Die Mail trägt das Logo der Sparkasse.',
    prompt: 'Welche Merkmale weisen auf Phishing hin?',
    choices: [
      ja(
        'Die Absenderdomain gehört nicht der Bank',
        'Angreifer registrieren ähnlich klingende Domains.',
      ),
      ja(
        'Die Drohung mit einer kurzen Frist',
        'Zeitdruck soll unüberlegtes Handeln auslösen.',
      ),
      ja(
        'Das Linkziel weicht vom angezeigten Linktext ab',
        'Der sichtbare Text lässt sich beliebig wählen, entscheidend ist das Ziel.',
      ),
      ja(
        'Die Aufforderung, Zugangsdaten einzugeben',
        'Banken fragen Zugangsdaten nie per Mail-Link ab.',
      ),
      nein(
        'Das Logo der Sparkasse in der Mail',
        'Logos lassen sich beliebig kopieren - sie sind weder ein Beleg für Echtheit noch ein Warnsignal.',
      ),
    ],
    explanation:
        'Typische Merkmale: fremde Absenderdomain, Druck und Drohung, abweichendes Linkziel und die Bitte um Zugangsdaten. Ein Logo sagt nichts über die Echtheit.',
  ),
  einfach(
    'a6-za-3',
    'sz-angriffe',
    scenario:
        'Im offenen WLAN eines Cafés leitet ein Angreifer den Datenverkehr der anderen Gäste unbemerkt über seinen Laptop und liest mit.',
    prompt: 'Um welchen Angriff handelt es sich?',
    choices: [
      ja(
        'Man-in-the-Middle',
        'Der Angreifer sitzt unbemerkt zwischen den Gästen und dem Internet.',
      ),
      nein(
        'Denial of Service',
        'DoS legt einen Dienst lahm, hier wird aber mitgelesen.',
      ),
      nein(
        'Brute Force',
        'Dabei werden Passwörter durchprobiert, nicht Verbindungen umgeleitet.',
      ),
      nein(
        'Tailgating',
        'Tailgating ist das Mitgehen durch eine gesicherte Tür.',
      ),
    ],
    explanation:
        'Beim Man-in-the-Middle-Angriff schaltet sich der Angreifer zwischen zwei Kommunikationspartner. Schutz bietet eine Ende-zu-Ende-Verschlüsselung wie TLS mit Zertifikatsprüfung.',
  ),
  einfach(
    'a6-za-4',
    'sz-angriffe',
    prompt:
        'Welche Maßnahme schützt ein Anmeldeportal wirksam gegen Brute-Force-Angriffe?',
    choices: [
      ja(
        'Nach mehreren Fehlversuchen das Konto vorübergehend sperren oder Wartezeiten erzwingen',
        'Das macht das massenhafte Durchprobieren praktisch unmöglich.',
      ),
      nein(
        'Passwörter auf höchstens 8 Zeichen begrenzen',
        'Kurze Passwörter verkleinern den Suchraum und erleichtern den Angriff.',
      ),
      nein(
        'In der Fehlermeldung angeben, ob Benutzername oder Passwort falsch war',
        'Der Angreifer erfährt so, welche Benutzernamen existieren.',
      ),
      nein(
        'Die Anmeldeseite über HTTP statt HTTPS ausliefern',
        'Das ermöglicht zusätzlich das Mitlesen der Zugangsdaten.',
      ),
    ],
    explanation:
        'Brute Force probiert systematisch Kombinationen. Sperren oder Verzögerungen nach Fehlversuchen und lange Passwörter machen den Angriff unwirtschaftlich.',
  ),
  einfach(
    'a6-za-5',
    'sz-angriffe',
    scenario:
        'Auf dem Firmenparkplatz liegt ein USB-Stick mit der Aufschrift „Gehälter 2026 - vertraulich“. Ein Mitarbeiter steckt ihn aus Neugier an seinen Arbeits-PC.',
    prompt: 'Welche Social-Engineering-Methode hat der Angreifer genutzt?',
    choices: [
      ja(
        'Baiting',
        'Der Angreifer legt einen Köder aus und setzt auf die Neugier des Finders.',
      ),
      nein(
        'Tailgating',
        'Tailgating ist das Mitgehen durch eine gesicherte Tür hinter einer berechtigten Person.',
      ),
      nein('Vishing', 'Vishing ist Phishing per Telefonanruf.'),
      nein(
        'Shoulder Surfing',
        'Beim Shoulder Surfing schaut der Angreifer bei der Eingabe über die Schulter.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Baiting nutzt einen Köder wie einen präparierten USB-Stick. Gefundene Datenträger gehören ungeöffnet zur IT, und USB-Autostart sollte abgeschaltet sein.',
  ),
  zuordnen(
    'a6-za-6',
    'sz-angriffe',
    prompt:
        'Welche Gegenmaßnahme hilft gegen den jeweiligen Angriff am besten?',
    buckets: [
      'Salt beim Hashen',
      'vorbereitete Abfragen',
      'TLS mit Zertifikatsprüfung',
      'eigenes Passwort je Dienst',
    ],
    items: [
      zu(
        'Rainbow-Table-Angriff auf erbeutete Passwort-Hashes',
        0,
        'Mit individuellem Salt passen vorberechnete Tabellen nicht mehr.',
      ),
      zu(
        'SQL-Injection über das Suchfeld eines Webshops',
        1,
        'Vorbereitete Abfragen (Prepared Statements) trennen Eingabe und Befehl, die Eingabe wird nie als Befehl ausgeführt.',
      ),
      zu(
        'Man-in-the-Middle im offenen Café-WLAN',
        2,
        'Eine verschlüsselte Verbindung mit geprüftem Zertifikat kann der Angreifer weder lesen noch unbemerkt umleiten.',
      ),
      zu(
        'Credential Stuffing mit Zugangsdaten aus einem fremden Datenleck',
        3,
        'Ist jedes Passwort nur einmal verwendet, nützen erbeutete Daten eines anderen Dienstes nichts.',
      ),
    ],
    explanation:
        'Jeder Angriff hat seinen passenden Schutz: Salt gegen vorberechnete Tabellen, vorbereitete Abfragen gegen SQL-Injection, TLS gegen Mitlesen und Umleiten, eigene Passwörter gegen Credential Stuffing.',
  ),
  mehrfach(
    'a6-za-7',
    'sz-angriffe',
    scenario:
        'Der Webshop eines Händlers ist seit einer Stunde nicht erreichbar. Die Firewall meldet Millionen Anfragen pro Minute von zehntausenden verschiedenen IP-Adressen.',
    prompt: 'Welche Aussagen zu diesem Angriff sind richtig?',
    choices: [
      ja(
        'Es handelt sich um einen DDoS-Angriff.',
        'Die Überlastung kommt aus sehr vielen Quellen gleichzeitig.',
      ),
      ja(
        'Verletzt ist vor allem die Verfügbarkeit.',
        'Der Shop ist für echte Kundschaft nicht nutzbar.',
      ),
      ja(
        'Die Anfragen stammen vermutlich aus einem Botnetz.',
        'Zehntausende Quellen sind typisch für ferngesteuerte, infizierte Rechner.',
      ),
      nein(
        'Der Angreifer hat dadurch Zugriff auf die Kundendatenbank.',
        'Ein DDoS legt den Dienst lahm, verschafft aber keinen Zugriff auf Daten.',
      ),
      nein(
        'Das Sperren einer einzelnen IP-Adresse stoppt den Angriff zuverlässig.',
        'Bei zehntausenden Quellen bleibt die Sperre einer Adresse wirkungslos - hier hilft ein DDoS-Schutzdienst.',
      ),
    ],
    explanation:
        'Ein DDoS überlastet einen Dienst aus vielen Quellen, meist aus einem Botnetz, und trifft die Verfügbarkeit. Abhilfe schaffen Filter- und Schutzdienste des Providers oder eines CDN, nicht das Sperren einzelner Adressen.',
  ),
  einfach(
    'a6-za-8',
    'sz-angriffe',
    scenario:
        'Im Gästebuch der Firmenwebsite trägt jemand einen Beitrag mit eingebettetem Skriptcode ein. Jeder Besucher, der das Gästebuch öffnet, führt das Skript unbemerkt im eigenen Browser aus.',
    prompt: 'Um welchen Angriff handelt es sich?',
    choices: [
      ja(
        'Cross-Site-Scripting (XSS)',
        'Eingeschleuster Skriptcode läuft im Browser anderer Nutzer.',
      ),
      nein(
        'SQL-Injection',
        'Dabei wird eine Datenbankabfrage manipuliert, nicht Code im Browser der Besucher ausgeführt.',
      ),
      nein(
        'DNS-Spoofing',
        'Dabei werden Namensauflösungen gefälscht, die Webseite selbst bleibt unverändert.',
      ),
      nein('Brute Force', 'Dabei werden Passwörter durchprobiert.'),
    ],
    explanation:
        'XSS entsteht, wenn eine Webanwendung Eingaben ungeprüft wieder ausgibt. Schutz: Eingaben prüfen und Ausgaben maskieren, damit Skriptcode als Text angezeigt statt ausgeführt wird.',
  ),

  // ====================================================== Schutzbedarf und IT-Grundschutz
  einfach(
    'a6-zb-1',
    'sz-schutzbedarf',
    scenario:
        'Auf einem Server laufen drei Anwendungen. Ihr Schutzbedarf für die Vertraulichkeit: Wiki „normal“, Personalverwaltung „hoch“, Kantinenplan „normal“. Kumulations- und Verteilungseffekt spielen keine Rolle.',
    prompt: 'Welchen Schutzbedarf hat der Server für die Vertraulichkeit?',
    choices: [
      ja(
        'hoch',
        'Nach dem Maximumprinzip bestimmt die Anwendung mit dem höchsten Schutzbedarf den Wert.',
      ),
      nein(
        'normal',
        'Die Mehrheit zählt nicht - sonst wären die Personaldaten unzureichend geschützt.',
      ),
      nein(
        'sehr hoch',
        'Keine Anwendung hat „sehr hoch“, und ein Kumulationseffekt liegt laut Aufgabe nicht vor.',
      ),
      nein(
        'zwischen normal und hoch',
        'Es gibt keine Zwischenstufen und keinen Durchschnitt.',
      ),
    ],
    explanation:
        'Maximumprinzip: Das IT-System erbt den höchsten Schutzbedarf der Anwendungen, die darauf laufen - hier „hoch“ von der Personalverwaltung.',
  ),
  zuordnen(
    'a6-zb-2',
    'sz-schutzbedarf',
    prompt: 'Welche Regel der Schutzbedarfsfeststellung wird angewendet?',
    buckets: ['Maximumprinzip', 'Kumulationseffekt', 'Verteilungseffekt'],
    items: [
      zu(
        'Auf dem Dateiserver liegen Projektdaten (normal) und Personalakten (hoch) - er wird mit „hoch“ eingestuft',
        0,
        'Der höchste Einzelwert gilt.',
      ),
      zu(
        'Ein Virtualisierungshost trägt 30 VMs mit jeweils „normal“ - weil ein Ausfall alle trifft, wird er mit „hoch“ eingestuft',
        1,
        'Viele kleine Schäden summieren sich zu einem großen.',
      ),
      zu(
        'Der Webshop (Verfügbarkeit „hoch“) läuft auf drei redundanten Servern - ein einzelner Server wird mit „normal“ eingestuft',
        2,
        'Fällt ein Server aus, übernehmen die anderen.',
      ),
    ],
    explanation:
        'Maximumprinzip: höchster Wert gilt. Kumulation: viele kleine Schäden erhöhen den Schutzbedarf. Verteilung: Redundanz kann ihn für ein einzelnes System senken.',
  ),
  reihenfolge(
    'a6-zb-3',
    'sz-schutzbedarf',
    prompt: 'In welcher Reihenfolge wird der Schutzbedarf nach BSI vererbt?',
    items: ['Geschäftsprozess', 'Anwendung', 'IT-System', 'Raum'],
    explanation:
        'Der Schutzbedarf wird von den Geschäftsprozessen über die Anwendungen auf die IT-Systeme übertragen, auf denen sie laufen, und von dort auf die Räume, in denen die Systeme stehen.',
  ),
  mehrfach(
    'a6-zb-4',
    'sz-schutzbedarf',
    prompt:
        'Welche der folgenden sind Schadensszenarien, die das BSI für die Schutzbedarfsfeststellung vorsieht?',
    choices: [
      ja(
        'Verstoß gegen Gesetze, Vorschriften oder Verträge',
        'Etwa ein Datenschutzverstoß mit Bußgeld.',
      ),
      ja(
        'Beeinträchtigung der persönlichen Unversehrtheit',
        'Etwa wenn ein Ausfall die Gesundheit von Menschen gefährdet.',
      ),
      ja(
        'Negative Innen- oder Außenwirkung',
        'Etwa ein Imageschaden nach einem öffentlich gewordenen Vorfall.',
      ),
      ja('Finanzielle Auswirkungen', 'Etwa Umsatzausfall oder Schadenersatz.'),
      nein(
        'Hohe Anschaffungskosten für eine Schutzmaßnahme',
        'Das sind Kosten der Absicherung, kein Schaden durch einen Vorfall.',
      ),
    ],
    explanation:
        'Das BSI nennt sechs Schadensszenarien, darunter Rechtsverstöße, Beeinträchtigung der Unversehrtheit, negative Innen- oder Außenwirkung und finanzielle Auswirkungen.',
  ),
  zuordnen(
    'a6-zb-5',
    'sz-schutzbedarf',
    scenario:
        'Auf einem Server laufen drei Anwendungen mit folgendem Schutzbedarf (Vertraulichkeit / Integrität / Verfügbarkeit): Lohnabrechnung sehr hoch / hoch / normal. Intranet normal / normal / normal. Ticketsystem normal / normal / hoch. Kumulations- und Verteilungseffekt spielen keine Rolle.',
    prompt: 'Welchen Schutzbedarf hat der jeweilige Wert?',
    buckets: ['normal', 'hoch', 'sehr hoch'],
    items: [
      zu(
        'Vertraulichkeit des Servers',
        2,
        'Maximum aus sehr hoch, normal, normal = sehr hoch (Lohnabrechnung).',
      ),
      zu(
        'Integrität des Servers',
        1,
        'Maximum aus hoch, normal, normal = hoch (Lohnabrechnung).',
      ),
      zu(
        'Verfügbarkeit des Servers',
        1,
        'Maximum aus normal, normal, hoch = hoch (Ticketsystem).',
      ),
      zu(
        'Verfügbarkeit des Intranets',
        0,
        'Für die Anwendung selbst gilt ihr eigener Wert - normal.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Nach dem Maximumprinzip übernimmt der Server je Schutzziel den höchsten Wert seiner Anwendungen: Vertraulichkeit sehr hoch, Integrität hoch, Verfügbarkeit hoch. Die Schutzziele werden getrennt betrachtet.',
  ),
  reihenfolge(
    'a6-zb-6',
    'sz-schutzbedarf',
    prompt:
        'Bringe die Schritte der Standard-Absicherung nach BSI-Standard 200-2 in die richtige Reihenfolge.',
    items: [
      'Strukturanalyse',
      'Schutzbedarfsfeststellung',
      'Modellierung mit Bausteinen',
      'IT-Grundschutz-Check',
      'Risikoanalyse für hohen Schutzbedarf',
    ],
    explanation:
        'Erst wird erfasst, was es gibt (Strukturanalyse), dann wie schutzbedürftig es ist. Danach werden passende Bausteine gewählt (Modellierung), der Ist-Zustand geprüft (Check) und für Objekte mit hohem oder sehr hohem Schutzbedarf eine Risikoanalyse ergänzt.',
  ),
  einfach(
    'a6-zb-7',
    'sz-schutzbedarf',
    prompt:
        'Wie beschreibt das BSI die Schadensauswirkungen der Schutzbedarfskategorie „sehr hoch“?',
    choices: [
      ja(
        'Existenziell bedrohlich, katastrophales Ausmaß',
        'So beschreibt das BSI die höchste Kategorie.',
      ),
      nein('Begrenzt und überschaubar', 'Das ist die Kategorie „normal“.'),
      nein('Beträchtlich', 'Das ist die Kategorie „hoch“.'),
      nein(
        'Kein Schaden zu erwarten',
        'Eine solche Kategorie gibt es nicht - die niedrigste ist „normal“.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Das BSI unterscheidet drei Kategorien: normal (begrenzt und überschaubar), hoch (beträchtlich) und sehr hoch (existenziell bedrohlich, katastrophal).',
  ),

  // ============================================================ Firewall und DMZ
  einfach(
    'a6-yf-1',
    'sm-firewall',
    scenario:
        'Das Regelwerk der Firewall (von oben nach unten): 1. Quelle LAN, Ziel any, Port 443, allow. 2. Quelle LAN, Ziel any, Port 53, allow. 3. Quelle any, Ziel any, Port any, deny. Ein PC im LAN ruft eine Webseite über HTTP auf Port 80 auf.',
    prompt: 'Was passiert mit der Verbindung?',
    choices: [
      ja(
        'Sie wird durch Regel 3 verworfen.',
        'Regel 1 und 2 passen nicht zu Port 80, also greift die abschließende Sperrregel.',
      ),
      nein(
        'Sie wird durch Regel 1 erlaubt.',
        'Regel 1 gilt nur für Port 443 (HTTPS), nicht für Port 80.',
      ),
      nein('Sie wird durch Regel 2 erlaubt.', 'Port 53 ist DNS, nicht HTTP.'),
      nein(
        'Sie wird erlaubt, weil sie aus dem LAN kommt.',
        'Die Herkunft allein genügt nicht - auch Port und Protokoll müssen zu einer Regel passen.',
      ),
    ],
    explanation:
        'Die Firewall prüft von oben nach unten, die erste passende Regel entscheidet. Für Port 80 passt erst Regel 3 (Default Deny).',
  ),
  einfach(
    'a6-yf-2',
    'sm-firewall',
    prompt:
        'Welche Firewall kann den Inhalt von HTTP-Verbindungen prüfen und z. B. Schadcode in einer Webseite erkennen?',
    choices: [
      ja(
        'Application-Level-Gateway (Proxy)',
        'Es arbeitet auf Schicht 7 und sieht die Inhalte des Anwendungsprotokolls.',
      ),
      nein(
        'Zustandsloser Paketfilter',
        'Er prüft nur Adressen, Ports und Protokoll im Paketkopf.',
      ),
      nein(
        'Stateful-Inspection-Firewall',
        'Sie kennt zusätzlich den Verbindungszustand, prüft aber keine Inhalte.',
      ),
      nein(
        'Switch mit VLANs',
        'Ein Switch trennt Netze, ist aber keine inhaltsprüfende Firewall.',
      ),
    ],
    explanation:
        'Nur ein Application-Level-Gateway (bzw. eine NGFW mit Anwendungserkennung) prüft Inhalte. Paketfilter und Stateful Inspection arbeiten auf Schicht 3 und 4.',
  ),
  zuordnen(
    'a6-yf-3',
    'sm-firewall',
    scenario: 'Ein Online-Händler baut ein Netz mit zweistufiger DMZ auf.',
    prompt: 'Wo befindet sich das jeweilige System?',
    buckets: ['Internet', 'DMZ', 'internes LAN'],
    items: [
      zu(
        'Rechner der Kundschaft, die im Webshop einkauft',
        0,
        'Die Kundschaft greift von außen zu.',
      ),
      zu(
        'Öffentlich erreichbarer Webserver des Shops',
        1,
        'Er muss aus dem Internet erreichbar sein, soll aber vom LAN getrennt stehen.',
      ),
      zu(
        'Mailserver, der Mails aus dem Internet annimmt',
        1,
        'Auch er ist von außen erreichbar.',
      ),
      zu(
        'Datenbankserver mit Kundendaten und Zahlungsinformationen',
        2,
        'Schützenswerte Daten gehören hinter die innere Firewall.',
      ),
      zu(
        'Arbeitsplatz-PCs der Buchhaltung',
        2,
        'Interne Arbeitsplätze haben in der DMZ nichts verloren.',
      ),
    ],
    explanation:
        'In die DMZ gehören nur Server, die aus dem Internet erreichbar sein müssen. Schützenswerte Daten und Arbeitsplätze stehen im internen LAN.',
  ),
  mehrfach(
    'a6-yf-4',
    'sm-firewall',
    prompt: 'Welche Aussagen sind richtig?',
    choices: [
      ja(
        'Ein zustandsloser Paketfilter prüft jedes Paket einzeln nach Adressen, Ports und Protokoll.',
        'Er kennt keinen Zusammenhang zwischen Paketen.',
      ),
      ja(
        'Stateful Inspection lässt Antworten zu einer erlaubten ausgehenden Verbindung automatisch zurück.',
        'Dafür führt sie eine Tabelle der offenen Verbindungen.',
      ),
      ja(
        'Eine zweistufige DMZ nutzt zwei Firewalls.',
        'Eine vor und eine hinter der DMZ.',
      ),
      nein(
        'Ein Paketfilter erkennt Schadcode im Inhalt einer Webseite.',
        'Er sieht nur den Paketkopf, keine Inhalte.',
      ),
      nein(
        'Eine Personal Firewall macht eine Netzwerk-Firewall überflüssig.',
        'Sie schützt nur das einzelne Gerät und ergänzt die Netzwerk-Firewall.',
      ),
    ],
    explanation:
        'Paketfilter und Stateful Inspection prüfen Kopfdaten, nur Proxys und NGFW prüfen Inhalte. Eine zweistufige DMZ hat zwei Firewalls, Personal Firewalls ergänzen den Schutz.',
  ),
  einfach(
    'a6-yf-5',
    'sm-firewall',
    scenario:
        'Das Regelwerk der Firewall wird von oben nach unten geprüft:\n1. Quelle LAN, Ziel any, Port 443, allow\n2. Quelle any, Ziel any, Port any, deny\n3. Quelle LAN, Ziel any, Port 80, allow\nNutzer im LAN beschweren sich, dass Webseiten über HTTP (Port 80) nicht laden.',
    prompt: 'Was ist die Ursache?',
    choices: [
      ja(
        'Regel 2 steht vor Regel 3 und verwirft die Verbindung, bevor Regel 3 geprüft wird.',
        'Die erste passende Regel entscheidet - die Sperrregel muss ans Ende.',
      ),
      nein(
        'Port 80 lässt sich grundsätzlich nicht freigeben.',
        'Port 80 kann wie jeder Port erlaubt werden.',
      ),
      nein(
        'Regel 1 verbietet Port 80.',
        'Regel 1 passt nur auf Port 443 und erlaubt diesen.',
      ),
      nein(
        'Regel 3 gilt nur für Verbindungen aus dem Internet.',
        'Als Quelle ist LAN eingetragen, sie gilt also für Verbindungen aus dem LAN.',
      ),
    ],
    difficulty: 2,
    explanation:
        'Firewalls prüfen Regeln von oben nach unten, die erste passende entscheidet. Die allgemeine Sperrregel (Default Deny) gehört ans Ende, sonst werden alle Regeln dahinter nie erreicht.',
  ),
  zuordnen(
    'a6-yf-6',
    'sm-firewall',
    prompt: 'Welches System wird beschrieben?',
    buckets: [
      'Paketfilter',
      'Stateful Inspection',
      'Application-Level-Gateway',
      'IPS',
    ],
    items: [
      zu(
        'Prüft nur IP-Adressen, Ports und Protokoll jedes Pakets einzeln',
        0,
        'Ohne Zusammenhang zwischen den Paketen arbeitet nur der zustandslose Paketfilter.',
      ),
      zu(
        'Lässt Antwortpakete zu einer erlaubten ausgehenden Verbindung automatisch zurück',
        1,
        'Dafür führt Stateful Inspection eine Tabelle der offenen Verbindungen.',
      ),
      zu(
        'Nimmt HTTP-Verbindungen selbst an und filtert die Inhalte von Webseiten',
        2,
        'Als Proxy arbeitet es auf Schicht 7 und sieht die Inhalte.',
      ),
      zu(
        'Erkennt Angriffsmuster im Datenstrom und blockiert sie sofort',
        3,
        'Ein Intrusion Prevention System greift aktiv ein, ein IDS würde nur melden.',
      ),
    ],
    explanation:
        'Paketfilter: einzelne Pakete nach Kopfdaten. Stateful Inspection: zusätzlich Verbindungszustand. Application-Level-Gateway: Inhalte auf Schicht 7. IPS: erkennt und blockiert Angriffe.',
  ),
  einfach(
    'a6-yf-7',
    'sm-firewall',
    scenario:
        'Die Skizze zeigt das Netz eines kleinen Onlinehändlers: Eine einzige Firewall trennt Internet, DMZ und LAN.',
    skizze: NetzSkizze(
      [
        NetzKnoten('inet', 'Internet', NetzTyp.internet, 2, 0),
        NetzKnoten('fw', 'Firewall', NetzTyp.firewall, 2, 1.8),
        NetzKnoten('web', 'Webserver', NetzTyp.server, 0.6, 3.6),
        NetzKnoten('sw', 'Switch', NetzTyp.switch_, 3.2, 3.2),
        NetzKnoten('pc', 'Arbeitsplatz', NetzTyp.pc, 2.6, 4.8),
        NetzKnoten('db', 'Datenbank', NetzTyp.server, 3.8, 4.8),
      ],
      verbindungen: [
        NetzVerbindung('inet', 'fw'),
        NetzVerbindung('fw', 'web'),
        NetzVerbindung('fw', 'sw'),
        NetzVerbindung('sw', 'pc'),
        NetzVerbindung('sw', 'db'),
      ],
      zonen: [NetzZone('DMZ', 0, 3, 1.4, 4.4), NetzZone('LAN', 2, 2.6, 4, 5.6)],
    ),
    prompt:
        'Welchen Nachteil hat diese einstufige DMZ gegenüber einer zweistufigen?',
    choices: [
      ja(
        'Wird die eine Firewall überwunden oder falsch konfiguriert, sind DMZ und LAN zugleich ungeschützt.',
        'Es gibt nur eine Hürde zwischen Internet und internem Netz.',
      ),
      nein(
        'Der Webserver ist aus dem Internet nicht erreichbar.',
        'Doch - genau dafür steht er in der DMZ, die Firewall gibt die nötigen Ports frei.',
      ),
      nein(
        'Die Datenbank steht ungeschützt im Internet.',
        'Sie steht im LAN hinter der Firewall.',
      ),
      nein(
        'Eine einstufige DMZ ist teurer als eine zweistufige.',
        'Umgekehrt: Sie braucht nur eine Firewall und ist günstiger.',
      ),
    ],
    explanation:
        'Die einstufige DMZ ist günstig und einfach, aber die einzige Firewall ist ein Single Point of Failure. Bei der zweistufigen DMZ muss ein Angreifer zwei Firewalls überwinden.',
  ),
  einfach(
    'a6-yf-8',
    'sm-firewall',
    scenario:
        'Eine Firma mit Zentrale in Köln und Filiale in Bonn will beide Netze dauerhaft und verschlüsselt über das Internet verbinden. Die Beschäftigten sollen davon nichts merken.',
    prompt: 'Welche Lösung passt?',
    choices: [
      ja(
        'Site-to-Site-VPN zwischen den Routern bzw. Firewalls beider Standorte',
        'Die Geräte an beiden Standorten halten den Tunnel dauerhaft aufrecht, die Endgeräte brauchen keine eigene VPN-Software.',
      ),
      nein(
        'Client-to-Site-VPN auf jedem einzelnen PC in Bonn',
        'Das eignet sich für einzelne mobile Geräte, nicht für die dauerhafte Kopplung ganzer Standorte.',
      ),
      nein(
        'Alle Server in Köln per Portweiterleitung ins Internet freigeben',
        'Das öffnet die Server für jeden im Internet und verschlüsselt nichts.',
      ),
      nein(
        'Eine DMZ in Bonn einrichten',
        'Eine DMZ trennt öffentliche Server vom LAN, sie verbindet keine Standorte.',
      ),
    ],
    explanation:
        'Ein Site-to-Site-VPN koppelt zwei Standorte dauerhaft über einen verschlüsselten Tunnel, z. B. mit IPsec. Client-to-Site-VPN ist für einzelne Geräte wie Notebooks im Homeoffice gedacht.',
  ),

  // ============================================================== Datensicherung
  rechnen(
    'a6-yb-1',
    'sm-backup',
    scenario:
        'Sonntags läuft eine Vollsicherung mit 500 GB. Von Montag bis Freitag folgt jeden Abend eine differenzielle Sicherung. Täglich werden 20 GB jeweils anderer Dateien geändert.',
    prompt:
        'Wie viel GB belegen die differenziellen Sicherungen von Montag bis Freitag zusammen?',
    answer: 300,
    unit: 'GB',
    explanation:
        'Die differenzielle Sicherung enthält alle Änderungen seit der Vollsicherung: Mo 20 GB, Di 40 GB, Mi 60 GB, Do 80 GB, Fr 100 GB. Summe: 20 + 40 + 60 + 80 + 100 = 300 GB.',
  ),
  rechnen(
    'a6-yb-2',
    'sm-backup',
    scenario:
        'Sonntags läuft eine Vollsicherung, von Montag bis Freitag jeden Abend eine inkrementelle Sicherung, jede auf ein eigenes Band. Am Donnerstagmittag fällt der Server aus.',
    prompt:
        'Wie viele Bänder werden benötigt, um den letzten gesicherten Stand wiederherzustellen?',
    answer: 4,
    unit: 'Bänder',
    explanation:
        'Letzte Sicherung war Mittwochabend. Benötigt werden die Vollsicherung vom Sonntag und alle Inkremente seitdem: Montag, Dienstag, Mittwoch. 1 + 3 = 4 Bänder.',
  ),
  einfach(
    'a6-yb-3',
    'sm-backup',
    prompt: 'Welcher Aufbau erfüllt die 3-2-1-Regel?',
    choices: [
      ja(
        'Originaldaten auf dem Server, eine Sicherung auf Band, eine zweite verschlüsselt in der Cloud',
        'Drei Kopien, mehrere verschiedene Medien, eine Kopie außer Haus.',
      ),
      nein(
        'Originaldaten auf dem Server und zwei Sicherungen auf einem NAS im selben Serverraum',
        'Keine Kopie außer Haus - ein Brand vernichtet alles.',
      ),
      nein(
        'Originaldaten auf dem Server, je eine Sicherung auf Band und auf USB-Platte - beide im Serverschrank',
        'Drei Kopien auf zwei Medien, aber keine außer Haus - ein Brand vernichtet alles.',
      ),
      nein(
        'Originaldaten auf dem Server und eine Sicherung in der Cloud',
        'Das sind nur zwei statt drei Kopien.',
      ),
    ],
    explanation:
        '3-2-1: drei Kopien der Daten, auf zwei verschiedenen Speichermedien, eine davon außer Haus.',
  ),
  einfach(
    'a6-yb-4',
    'sm-backup',
    scenario:
        'Die Geschäftsführung legt fest: Bei einem Ausfall dürfen höchstens 4 Stunden Arbeit verloren gehen.',
    prompt: 'Welche Kennzahl wird damit festgelegt?',
    choices: [
      ja(
        'Recovery Point Objective (RPO)',
        'Das RPO beschreibt den maximal hinnehmbaren Datenverlust - hier müsste mindestens alle 4 Stunden gesichert werden.',
      ),
      nein(
        'Recovery Time Objective (RTO)',
        'Das RTO beschreibt, wie schnell der Betrieb wieder laufen muss, nicht wie viele Daten verloren gehen dürfen.',
      ),
      nein(
        'Verfügbarkeit in Prozent',
        'Sie beschreibt den Anteil der Betriebszeit, nicht den Datenverlust.',
      ),
      nein(
        'Generationenprinzip',
        'Es regelt die Aufbewahrung der Sicherungen, keinen Zeitraum für Datenverlust.',
      ),
    ],
    explanation:
        'RPO: Wie viel Datenverlust ist hinnehmbar? Daraus folgt der Sicherungsabstand. RTO: Wie lange darf die Wiederherstellung dauern?',
  ),
  rechnen(
    'a6-yb-5',
    'sm-backup',
    scenario:
        'Sonntags läuft eine Vollsicherung mit 400 GB. Von Montag bis Samstag folgt jeden Abend eine inkrementelle Sicherung. Täglich werden 15 GB jeweils anderer Dateien geändert.',
    prompt:
        'Wie viel Speicher belegen alle Sicherungen dieser Woche zusammen (Vollsicherung eingeschlossen)?',
    answer: 490,
    unit: 'GB',
    explanation:
        'Inkrementell wird täglich nur die Änderung des Tages gesichert: 6 Tage × 15 GB = 90 GB. Dazu kommt die Vollsicherung: 400 GB + 90 GB = 490 GB.',
  ),
  rechnen(
    'a6-yb-6',
    'sm-backup',
    scenario:
        'Sonntags läuft eine Vollsicherung mit 300 GB, von Montag bis Freitag jeden Abend eine differenzielle Sicherung. Täglich werden 12 GB jeweils anderer Dateien geändert. Am Samstag um 9 Uhr fällt der Server aus.',
    prompt:
        'Wie viele GB müssen insgesamt eingespielt werden, um den letzten gesicherten Stand herzustellen?',
    answer: 360,
    unit: 'GB',
    difficulty: 3,
    explanation:
        'Benötigt werden die Vollsicherung und die letzte differenzielle Sicherung (Freitag). Diese enthält alle Änderungen seit Sonntag: 5 Tage × 12 GB = 60 GB. Zusammen: 300 GB + 60 GB = 360 GB.',
  ),
  einfach(
    'a6-yb-7',
    'sm-backup',
    prompt:
        'Wie heißt im Generationenprinzip die monatliche Sicherung, die am längsten aufbewahrt wird?',
    choices: [
      ja(
        'Großvater',
        'Großväter sind die Monatssicherungen mit der längsten Aufbewahrung.',
      ),
      nein('Vater', 'Väter sind die Wochensicherungen.'),
      nein(
        'Sohn',
        'Söhne sind die Tagessicherungen, die am schnellsten überschrieben werden.',
      ),
      nein(
        'Enkel',
        'Einen Enkel gibt es im Großvater-Vater-Sohn-Prinzip nicht.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Großvater-Vater-Sohn: tägliche Sicherungen (Sohn) werden schnell überschrieben, wöchentliche (Vater) länger und monatliche (Großvater) am längsten aufbewahrt.',
  ),
  mehrfach(
    'a6-yb-8',
    'sm-backup',
    prompt: 'Welche Aussagen zur Datensicherung sind richtig?',
    choices: [
      ja(
        'Die differenzielle Sicherung setzt das Archivbit nicht zurück.',
        'Deshalb enthält jede differenzielle Sicherung alle Änderungen seit der letzten Vollsicherung.',
      ),
      ja(
        'Für eine Wiederherstellung aus inkrementellen Sicherungen braucht man die Vollsicherung und alle Inkremente seitdem.',
        'Jedes Inkrement enthält nur die Änderungen eines Zeitraums.',
      ),
      ja(
        'Regelmäßige Restore-Tests gehören zu jedem Sicherungskonzept.',
        'Nur ein Test zeigt, ob sich die Sicherung wirklich zurückspielen lässt.',
      ),
      nein(
        'Ein synchronisierter Cloud-Ordner ersetzt eine Datensicherung.',
        'Er übernimmt auch Löschungen und Verschlüsselungen sofort und bewahrt keine alten Stände.',
      ),
      nein(
        'Bei differenzieller Sicherung wird von Tag zu Tag weniger gesichert.',
        'Umgekehrt: Die differenzielle Sicherung wächst bis zur nächsten Vollsicherung täglich.',
      ),
    ],
    explanation:
        'Differenziell: Archivbit bleibt, Sicherung wächst, Restore mit Voll + letzter Differenz. Inkrementell: Restore mit Voll + allen Inkrementen. Synchronisation ist kein Backup, und jedes Backup muss getestet werden.',
  ),

  // ================================================================ Sicheres WLAN
  einfach(
    'a6-yw-1',
    'sm-wlan',
    scenario:
        'Der neue Router einer Arztpraxis bietet WEP, WPA2 mit TKIP, WPA2 mit AES und WPA3-Personal an. Alle Geräte der Praxis unterstützen WPA3.',
    prompt: 'Welche Einstellung entspricht dem aktuellen Stand der Technik?',
    choices: [
      ja(
        'WPA3-Personal',
        'Aktuellster Standard, schützt dank SAE vor Offline-Wörterbuchangriffen.',
      ),
      nein(
        'WPA2 mit AES',
        'Gilt als Minimum, ist aber nicht der aktuelle Stand, wenn alle Geräte WPA3 können.',
      ),
      nein('WPA2 mit TKIP', 'TKIP ist veraltet und gilt als unsicher.'),
      nein('WEP', 'WEP ist seit Jahren gebrochen.'),
    ],
    explanation:
        'Stand der Technik ist WPA3. Wo Altgeräte es nicht können, ist WPA2 mit AES das Minimum. WEP und TKIP sind tabu.',
  ),
  mehrfach(
    'a6-yw-2',
    'sm-wlan',
    prompt: 'Welche Maßnahmen erhöhen die Sicherheit eines WLANs wirksam?',
    choices: [
      ja(
        'WPS im Router deaktivieren',
        'Die WPS-PIN lässt sich in kurzer Zeit per Brute Force knacken.',
      ),
      ja(
        'Ein eigenes Gastnetz einrichten',
        'Besuchergeräte bleiben vom internen Netz getrennt.',
      ),
      ja(
        'Ein langes, zufälliges WLAN-Passwort verwenden',
        'Erschwert Wörterbuch- und Brute-Force-Angriffe.',
      ),
      nein(
        'Die SSID verstecken',
        'Die SSID taucht trotzdem in den Funkpaketen auf und ist leicht zu ermitteln.',
      ),
      nein(
        'Sich allein auf einen MAC-Filter verlassen',
        'MAC-Adressen lassen sich mitlesen und fälschen.',
      ),
    ],
    explanation:
        'Wirksam sind starke Verschlüsselung mit langem Passwort, abgeschaltetes WPS und ein getrenntes Gastnetz. Versteckte SSID und MAC-Filter bringen kaum Sicherheit.',
  ),
  zuordnen(
    'a6-yw-3',
    'sm-wlan',
    prompt:
        'Welche Rolle bei der Anmeldung nach 802.1X hat das jeweilige Gerät?',
    buckets: ['Supplicant', 'Authenticator', 'Authentication Server'],
    items: [
      zu('Notebook einer Mitarbeiterin', 0, 'Das Endgerät, das Zugang möchte.'),
      zu(
        'Access Point im Großraumbüro',
        1,
        'Er vermittelt die Anmeldung und gibt den Zugang frei.',
      ),
      zu(
        'RADIUS-Server im Rechenzentrum',
        2,
        'Er prüft die Zugangsdaten und entscheidet.',
      ),
      zu(
        'Firmen-Smartphone mit Gerätezertifikat',
        0,
        'Auch das Smartphone ist ein Endgerät.',
      ),
    ],
    explanation:
        'Supplicant: Endgerät. Authenticator: Access Point oder Switch. Authentication Server: meist ein RADIUS-Server.',
  ),
  rechnen(
    'a6-yw-4',
    'sm-wlan',
    scenario:
        'Die WPS-PIN hat 8 Ziffern, die letzte ist eine Prüfziffer. Der Router bestätigt die ersten 4 Ziffern und die restlichen 3 frei wählbaren Ziffern getrennt.',
    prompt:
        'Wie viele Versuche braucht ein Angreifer höchstens, um die PIN zu ermitteln?',
    answer: 11000,
    unit: 'Versuche',
    explanation:
        'Erste Hälfte: 4 Ziffern -> 10⁴ = 10.000 Möglichkeiten. Zweite Hälfte: 3 Ziffern -> 10³ = 1.000 Möglichkeiten. Weil getrennt geprüft wird, werden die Werte addiert: 10.000 + 1.000 = 11.000 Versuche.',
  ),
  einfach(
    'a6-yw-5',
    'sm-wlan',
    scenario:
        'Eine Firma mit 60 Beschäftigten nutzt WPA2-Personal mit einem gemeinsamen WLAN-Passwort. Ein Mitarbeiter verlässt das Unternehmen im Streit.',
    prompt:
        'Was ist jetzt nötig, und wie wäre es mit WPA2- oder WPA3-Enterprise?',
    choices: [
      ja(
        'Das WLAN-Passwort auf allen Geräten ändern - mit Enterprise würde man nur sein persönliches Konto sperren.',
        'Bei Personal kennen alle dasselbe Passwort, bei Enterprise meldet sich jede Person mit eigenen Zugangsdaten über 802.1X an.',
      ),
      nein(
        'Nichts - ein WLAN-Passwort lässt sich nicht weitergeben.',
        'Der ehemalige Mitarbeiter kennt das Passwort und kann es nutzen oder weitergeben.',
      ),
      nein(
        'Nur die SSID verstecken - mit Enterprise wäre das ebenso nötig.',
        'Eine versteckte SSID ist leicht zu finden und schützt nicht.',
      ),
      nein(
        'Den MAC-Filter um sein privates Handy ergänzen - mit Enterprise wäre das ebenso nötig.',
        'MAC-Adressen lassen sich fälschen, und er kann jedes andere Gerät benutzen.',
      ),
    ],
    explanation:
        'WPA-Personal nutzt ein gemeinsames Passwort, das nur durch Ändern auf allen Geräten widerrufen werden kann. WPA-Enterprise prüft über 802.1X und RADIUS persönliche Zugangsdaten - ein einzelnes Konto lässt sich sperren.',
  ),
  mehrfach(
    'a6-yw-6',
    'sm-wlan',
    prompt: 'Welche Vorteile bietet WPA3-Personal gegenüber WPA2-Personal?',
    choices: [
      ja(
        'Ein mitgeschnittener Anmeldevorgang erlaubt kein Offline-Durchprobieren des Passworts.',
        'Das Verfahren SAE verlangt für jeden Rateversuch eine echte Anmeldung.',
      ),
      ja(
        'Forward Secrecy: Früher mitgeschnittener Verkehr bleibt geschützt, auch wenn das Passwort später bekannt wird.',
        'Jede Sitzung bekommt eigene Schlüssel.',
      ),
      ja(
        'Verwaltungspakete sind geschützt, gefälschte Abmeldepakete wirken nicht.',
        'Protected Management Frames sind bei WPA3 Pflicht.',
      ),
      nein(
        'Es wird gar kein Passwort mehr benötigt.',
        'WPA3-Personal nutzt weiterhin ein Passwort, nur sicherer.',
      ),
      nein(
        'Auch alte WEP-Geräte können sich damit verbinden.',
        'WEP-Geräte unterstützen WPA3 nicht - WEP ist gebrochen und gehört ausgemustert.',
      ),
    ],
    explanation:
        'WPA3-Personal ersetzt den angreifbaren Handshake durch SAE, bietet Forward Secrecy und schützt Verwaltungspakete. Ein Passwort ist weiterhin nötig, es sollte lang und zufällig sein.',
  ),
  einfach(
    'a6-yw-7',
    'sm-wlan',
    scenario:
        'In einer Arztpraxis strahlt ein Access Point die SSIDs „Praxis“ (VLAN 10, mit Praxisserver) und „Gast“ (VLAN 20) aus. Die Skizze zeigt den Aufbau.',
    skizze: NetzSkizze(
      [
        NetzKnoten('inet', 'Internet', NetzTyp.internet, 2, 0),
        NetzKnoten('fw', 'Router/Firewall', NetzTyp.firewall, 2, 1.2),
        NetzKnoten('sw', 'Switch', NetzTyp.switch_, 2, 2.4),
        NetzKnoten('srv', 'Praxisserver', NetzTyp.server, 0.6, 3.8),
        NetzKnoten('ap', 'Access Point', NetzTyp.accessPoint, 3.4, 3.6),
        NetzKnoten('nb', 'Praxis-Notebook', NetzTyp.laptop, 1.8, 5.3),
        NetzKnoten('gast', 'Gast-Handy', NetzTyp.smartphone, 3.5, 5.3),
      ],
      verbindungen: [
        NetzVerbindung('inet', 'fw'),
        NetzVerbindung('fw', 'sw'),
        NetzVerbindung('sw', 'srv'),
        NetzVerbindung('sw', 'ap', label: 'VLAN 10 + 20'),
        NetzVerbindung('ap', 'nb', label: 'SSID Praxis', funk: true),
        NetzVerbindung('ap', 'gast', label: 'SSID Gast', funk: true),
      ],
      zonen: [
        NetzZone('VLAN 10 intern', 0, 3.2, 2.6, 6),
        NetzZone('VLAN 20 Gäste', 2.8, 4.7, 4, 6),
      ],
    ),
    prompt: 'Welche Firewall-Regeln sind für das Gast-VLAN richtig?',
    choices: [
      ja(
        'VLAN 20 -> Internet erlauben, VLAN 20 -> VLAN 10 verbieten',
        'Gäste kommen ins Internet, aber nie an den Praxisserver.',
      ),
      nein(
        'VLAN 20 -> VLAN 10 erlauben, damit Gäste drucken können',
        'Damit stünde das interne Netz mit den Patientendaten für fremde Geräte offen.',
      ),
      nein(
        'VLAN 20 komplett sperren, auch ins Internet',
        'Dann wäre das Gastnetz nutzlos.',
      ),
      nein(
        'Keine Regel nötig, weil die SSIDs verschieden heißen',
        'Erst die Firewall-Regel zwischen den VLANs trennt die Netze wirksam.',
      ),
    ],
    explanation:
        'Ein Gastnetz bekommt ein eigenes VLAN mit der Regel „nur Internet“. Zusätzlich verhindert Client-Isolation, dass Gastgeräte sich gegenseitig erreichen.',
  ),

  // =================================================== Zugriffsschutz und Härtung
  zuordnen(
    'a6-yz-1',
    'sm-zugriff',
    prompt: 'Um welche Art der Kontrolle handelt es sich?',
    buckets: ['Zutritt', 'Zugang', 'Zugriff'],
    items: [
      zu('Chipkartenleser an der Tür zum Serverraum', 0, 'Schützt einen Raum.'),
      zu(
        'Anmeldung am Notebook mit Passwort und Fingerabdruck',
        1,
        'Schützt die Nutzung des IT-Systems.',
      ),
      zu(
        'Nur die Personalabteilung darf den Ordner „Gehälter“ öffnen',
        2,
        'Regelt Rechte auf bestimmte Daten.',
      ),
      zu(
        'Besuchende werden am Empfang registriert und begleitet',
        0,
        'Kontrolliert das Betreten des Gebäudes.',
      ),
      zu(
        'Leserecht, aber kein Schreibrecht auf die Preisliste',
        2,
        'Regelt, was mit bestimmten Daten erlaubt ist.',
      ),
    ],
    explanation:
        'Zutritt: Räume und Gebäude. Zugang: Nutzung von IT-Systemen. Zugriff: Rechte auf bestimmte Daten und Funktionen.',
  ),
  einfach(
    'a6-yz-2',
    'sm-zugriff',
    scenario:
        'Die Rechte werden rollenbasiert vergeben. Ein Azubi wechselt vom Vertrieb in die Buchhaltung.',
    prompt: 'Was ist richtig?',
    choices: [
      ja(
        'Rolle „Vertrieb“ entziehen und Rolle „Buchhaltung“ zuordnen',
        'So hat er genau die Rechte, die er für die neue Aufgabe braucht.',
      ),
      nein(
        'Rolle „Buchhaltung“ zusätzlich zuordnen und „Vertrieb“ behalten',
        'Rechte würden sich anhäufen - ein Verstoß gegen das Minimalprinzip.',
      ),
      nein(
        'Ihm Administratorrechte geben, damit er überall Zugriff hat',
        'Weit mehr Rechte als nötig und ein hohes Risiko.',
      ),
      nein(
        'Ihn vorerst das Konto einer Kollegin aus der Buchhaltung mitbenutzen lassen',
        'Geteilte Konten verhindern Nachvollziehbarkeit und verletzen die Zugangskontrolle.',
      ),
    ],
    explanation:
        'Bei einem Abteilungswechsel werden alte Rollen entzogen und neue zugeordnet. So bleibt das Minimalprinzip gewahrt.',
  ),
  mehrfach(
    'a6-yz-3',
    'sm-zugriff',
    scenario:
        'Ein neuer Webserver soll vor der Inbetriebnahme gehärtet werden.',
    prompt: 'Welche Maßnahmen gehören zur Härtung?',
    choices: [
      ja(
        'Nicht benötigte Dienste wie FTP und Telnet deaktivieren',
        'Was nicht läuft, kann nicht angegriffen werden.',
      ),
      ja(
        'Das Standardpasswort des Administratorkontos ändern',
        'Standardpasswörter stehen öffentlich in Handbüchern.',
      ),
      ja(
        'Alle verfügbaren Sicherheitsupdates einspielen',
        'Updates schließen bekannte Lücken.',
      ),
      nein(
        'Alle Ports öffnen, damit später keine Dienste blockiert werden',
        'Das vergrößert die Angriffsfläche - das Gegenteil von Härtung.',
      ),
      nein(
        'Das Administratorkonto für die tägliche Arbeit nutzen',
        'Alltagsarbeit gehört in ein Konto ohne Adminrechte.',
      ),
    ],
    explanation:
        'Härtung verkleinert die Angriffsfläche: Unnötiges abschalten, Standardzugänge ändern, Updates einspielen.',
  ),
  einfach(
    'a6-yz-4',
    'sm-zugriff',
    prompt:
        'Warum sollen Administratorinnen und Administratoren für E-Mail und Internet ein normales Benutzerkonto verwenden?',
    choices: [
      ja(
        'Weil Schadcode aus einem Anhang oder einer Webseite sonst mit vollen Administratorrechten läuft',
        'Mit eingeschränkten Rechten kann Schadsoftware deutlich weniger anrichten.',
      ),
      nein(
        'Weil Administratorkonten keine E-Mails empfangen können',
        'Technisch ist das möglich - es ist nur riskant.',
      ),
      nein(
        'Weil Administratorkonten kein Passwort benötigen',
        'Gerade Administratorkonten brauchen besonders starke Anmeldeverfahren.',
      ),
      nein(
        'Weil das Programm sonst langsamer läuft',
        'Die Geschwindigkeit hängt nicht von den Kontorechten ab.',
      ),
    ],
    explanation:
        'Getrennte Konten setzen das Minimalprinzip um: Admin-Rechte nur für Verwaltungsaufgaben, der Alltag läuft ohne erhöhte Rechte.',
  ),
  einfach(
    'a6-yz-5',
    'sm-zugriff',
    scenario:
        'Rechte auf den Ordner „Projekte“: Rolle Vertrieb lesen und schreiben, Rolle Azubi nur lesen, Rolle Personal kein Zugriff. Rechte mehrerer Rollen addieren sich. Azubi Jonas hat die Rollen „Azubi“ und „Personal“.',
    prompt: 'Was darf Jonas im Ordner „Projekte“?',
    choices: [
      ja(
        'Nur lesen',
        'Azubi bringt das Leserecht mit, Personal fügt nichts hinzu.',
      ),
      nein(
        'Lesen und schreiben',
        'Schreibrechte hat nur die Rolle Vertrieb, die Jonas nicht besitzt.',
      ),
      nein(
        'Nichts, weil „Personal“ keinen Zugriff hat',
        'Ein fehlendes Recht einer Rolle hebt die Rechte einer anderen Rolle nicht auf - sie addieren sich.',
      ),
      nein('Nur schreiben', 'Keine seiner Rollen erlaubt das Schreiben.'),
    ],
    explanation:
        'Bei rollenbasierter Rechtevergabe erhält eine Person die Summe der Rechte all ihrer Rollen: Azubi (lesen) + Personal (nichts) = lesen.',
  ),
  zuordnen(
    'a6-yz-6',
    'sm-zugriff',
    prompt: 'Welches Zugriffsmodell wird beschrieben?',
    buckets: [
      'DAC (benutzerbestimmt)',
      'MAC (systembestimmt)',
      'RBAC (rollenbasiert)',
    ],
    items: [
      zu(
        'Wer eine Datei anlegt, legt selbst fest, wer sie lesen darf',
        0,
        'Der Besitzer entscheidet über seine Objekte - benutzerbestimmt.',
      ),
      zu(
        'Dokumente tragen Einstufungen wie „VS-Vertraulich“, Nutzer dürfen nur bis zu ihrer Freigabestufe lesen',
        1,
        'Feste Sicherheitsstufen, die das System erzwingt, kennzeichnen MAC.',
      ),
      zu(
        'Neue Beschäftigte erhalten die Rolle ihrer Abteilung und damit alle nötigen Rechte',
        2,
        'Rechte hängen an Rollen, nicht an Personen.',
      ),
      zu(
        'Nutzer können die Einstufung eines Dokuments nicht selbst ändern',
        1,
        'Beim systembestimmten Modell hat der Nutzer keinen Einfluss auf die Regeln.',
      ),
    ],
    explanation:
        'DAC: Besitzer vergibt Rechte. MAC: System erzwingt Sicherheitsstufen. RBAC: Rechte hängen an Rollen - das übliche Modell in Unternehmen.',
  ),
  mehrfach(
    'a6-yz-7',
    'sm-zugriff',
    prompt: 'Welche Maßnahmen setzen das Minimalprinzip (Least Privilege) um?',
    choices: [
      ja(
        'Der Vertrieb erhält auf die Preisliste nur Leserecht.',
        'Mehr als Lesen braucht der Vertrieb für seine Aufgabe nicht.',
      ),
      ja(
        'Administratoren nutzen für E-Mail und Internet ein normales Konto.',
        'Adminrechte gibt es nur für Verwaltungsaufgaben.',
      ),
      ja(
        'Beim Abteilungswechsel wird die alte Rolle entzogen.',
        'So sammeln sich keine überflüssigen Rechte an.',
      ),
      nein(
        'Alle Azubis erhalten Adminrechte, damit sie Software selbst installieren können.',
        'Das gibt weit mehr Rechte als nötig und öffnet Schadsoftware die Tür.',
      ),
      nein(
        'Die Abteilung nutzt ein gemeinsames Konto mit allen Rechten.',
        'Geteilte Konten bündeln Rechte und machen Aktionen unzurechenbar.',
      ),
    ],
    explanation:
        'Minimalprinzip: Jedes Konto bekommt nur die Rechte, die es für seine Aufgabe braucht - und verliert sie, sobald die Aufgabe entfällt.',
  ),
];
