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
        'Hier sieht jemand Daten, die nicht für ihn bestimmt sind. Verändert wird dabei nichts.',
      ),
      zu(
        'Ein Angreifer ändert die IBAN in einer Rechnungsvorlage',
        1,
        'Die Daten wurden unbemerkt verfälscht.',
      ),
      zu(
        'Der Webshop ist nach einem Stromausfall drei Stunden nicht erreichbar',
        2,
        'Der Dienst ist nicht nutzbar, wenn er gebraucht wird.',
      ),
      zu(
        'Ein Übertragungsfehler verfälscht Messwerte in der Datenbank',
        1,
        'Die Daten sind nicht mehr korrekt. Auch ohne Angreifer ist die Integrität verletzt.',
      ),
      zu(
        'Ein Mitarbeiter fotografiert Kundendaten vom Bildschirm und verkauft sie',
        0,
        'Die Daten gelangen an Unbefugte.',
      ),
    ],
    explanation:
        'Sieht jemand Daten unbefugt, ist die Vertraulichkeit verletzt. Werden Daten verändert, trifft es die Integrität, und ist ein Dienst nicht erreichbar, die Verfügbarkeit.',
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
  markieren(
    'a6-zz-4',
    'sz-schutzziele',
    scenario:
        'Ein Rechenzentrum listet in seinem Sicherheitskonzept folgende Maßnahmen auf.',
    prompt:
        'Markiere alle Maßnahmen, die in erster Linie der Verfügbarkeit dienen.',
    zeilen: [
      ja(
        'Unterbrechungsfreie Stromversorgung (USV)',
        'Sie überbrückt Stromausfälle, die Systeme bleiben erreichbar.',
      ),
      nein(
        'Verschlüsselung der Festplatten',
        'Sie schützt vor unbefugtem Lesen, also die Vertraulichkeit.',
      ),
      ja(
        'Zweite Internetleitung über einen anderen Anbieter',
        'Fällt eine Leitung aus, übernimmt die andere (Redundanz).',
      ),
      ja(
        'Tägliche Datensicherung mit Wiederherstellungstest',
        'Nach einem Datenverlust sind die Daten schnell wieder nutzbar.',
      ),
      nein(
        'Digitale Signatur für ausgehende Rechnungen',
        'Sie sichert Integrität und Authentizität, nicht die Verfügbarkeit.',
      ),
      nein(
        'Zugriffsrechte nach dem Minimalprinzip',
        'Begrenzt, wer Daten sehen und ändern darf, schützt also vor allem die Vertraulichkeit.',
      ),
      ja(
        'Klimaanlage mit Ersatzgerät im Serverraum',
        'Verhindert Ausfälle durch Überhitzung.',
      ),
    ],
    explanation:
        'Verfügbarkeit sichern alle Maßnahmen, die Ausfälle verhindern oder verkürzen: USV, redundante Leitungen und Geräte, Klimatisierung, Datensicherung. Verschlüsselung und Zugriffsrechte dienen der Vertraulichkeit, Signaturen der Integrität.',
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
        'Bei Komponenten in Reihe werden die Verfügbarkeiten multipliziert: 0,99 × 0,999 = 0,98901; 0,98901 × 0,995 = 0,98406495. Das sind gerundet 98,41 %, also weniger als jede einzelne Komponente.',
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
        'Es tarnt sich als nützliches Programm und wird vom Nutzer selbst installiert.',
      ),
      zu(
        'Verbreitet sich ohne jedes Zutun der Nutzer im gesamten Firmennetz',
        1,
        'Er braucht weder Wirtsdatei noch Nutzeraktion, also ist es ein Wurm.',
      ),
    ],
    explanation:
        'Ein Virus braucht eine Wirtsdatei, ein Wurm verbreitet sich selbstständig über das Netz, und ein Trojaner tarnt sich als nützliches Programm.',
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
        'Bei Ransomware zählt jede Minute. Trenne die Netzverbindung, damit sich die Verschlüsselung nicht ausbreitet, und melde den Vorfall sofort.',
  ),
  lueckentext(
    'a6-zm-4',
    'sz-schadsoftware',
    prompt: 'Ergänze die Aussagen zum Schutz vor Schadsoftware.',
    text:
        'Ein Virenscanner erkennt bekannte Schadsoftware an ihrer {0}. Noch unbekannte Schädlinge versucht er über die {1} zu erkennen, also an verdächtigem Verhalten. Damit die Erkennung aktuell bleibt, müssen die Signaturen {2} aktualisiert werden. Gegen das Ausnutzen bekannter Sicherheitslücken helfen vor allem zeitnahe {3}. Den Schaden durch Ransomware begrenzt eine {4}, die vom Netz getrennt aufbewahrt wird.',
    luecken: [
      wahl('Signatur', ['Dateigröße', 'IP-Adresse']),
      wahl('Heuristik', ['Signatur', 'Verschlüsselung']),
      wahl('mehrmals täglich', ['einmal im Jahr', 'nur nach einem Befall']),
      wahl('Updates', ['Neustarts', 'Passwortwechsel']),
      wahl('Datensicherung', ['Firewall-Regel', 'Bildschirmsperre']),
    ],
    explanation:
        'Signaturen erkennen bekannte Schadsoftware, die Heuristik (Verhaltensanalyse) auch unbekannte. Beides ersetzt keine Updates, denn erst sie schließen die Lücken, über die Würmer und Exploits eindringen. Gegen Ransomware hilft am Ende nur eine getrennt aufbewahrte Sicherung.',
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
        'Kennzeichen eines Rootkits ist die Tarnung: Es verbirgt Dateien, Prozesse und Netzverbindungen, oft mit höchsten Rechten. Es lässt sich nur schwer entfernen, meist wird das System neu aufgesetzt.',
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
        'Gegen Ransomware wirkt nur die Kombination: Infektionswege schließen (Updates, Makros blockieren), den Schaden begrenzen (keine Adminrechte) und eine Sicherung bereithalten, die die Schadsoftware nicht erreichen kann.',
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
  freitext(
    'a6-zm-8',
    'sz-schadsoftware',
    scenario:
        'In den Nachrichten heißt es, Angreifer nutzten eine „Zero-Day-Lücke“ in einem verbreiteten Browser aus.',
    prompt:
        'Erläutere, was eine Zero-Day-Lücke ist und warum sie besonders gefährlich ist. (4 P.)',
    kriterien: [
      krit(
        'Eine Sicherheitslücke, die dem Hersteller noch nicht bekannt ist oder für die es noch kein Update gibt',
        punkte: 2,
        stichwoerter: [
          'noch kein Update',
          'kein Patch',
          'Hersteller nicht bekannt',
          'unbekannt',
          'noch nicht behoben',
        ],
      ),
      krit(
        'Gefährlich, weil sich niemand durch Updates schützen kann und Virenscanner den Angriff meist noch nicht erkennen',
        punkte: 2,
        stichwoerter: [
          'kein Schutz',
          'nicht schützen',
          'Virenscanner erkennt',
          'keine Signatur',
          'schutzlos',
        ],
      ),
    ],
    loesung:
        'Eine Zero-Day-Lücke ist eine Sicherheitslücke, die dem Hersteller noch nicht bekannt ist oder für die es noch kein Update gibt. Er hatte „null Tage“ Zeit, sie zu schließen. Sie ist besonders gefährlich, weil sich selbst sorgfältig gepflegte Systeme nicht durch Updates schützen können und Virenscanner den Angriff mangels Signatur meist nicht erkennen.',
    explanation:
        '2 Punkte für die Erklärung des Begriffs, 2 Punkte für die Gefahr. Schutz bieten dann nur weitere Ebenen: Minimalprinzip, Netzsegmentierung, Verhaltensanalyse und Datensicherung.',
    difficulty: 1,
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
        'Vishing ist Social Engineering per Telefon.',
      ),
      zu(
        'Eine Person mit Kartons in den Händen folgt Mitarbeitenden durch die gesicherte Tür',
        1,
        'Sie nutzt die Zutrittsberechtigung anderer aus.',
      ),
      zu(
        'Der angebliche Geschäftsführer fordert per Mail eine eilige, vertrauliche Überweisung',
        2,
        'Autorität, Zeitdruck und Geheimhaltung sind typisch für CEO-Fraud.',
      ),
      zu(
        'Tausende gekaperte Rechner legen den Webshop mit Anfragen lahm',
        3,
        'Der Dienst wird aus vielen Quellen überlastet, meist aus einem Botnetz.',
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
        'Logos lassen sich beliebig kopieren. Sie sind weder ein Beleg für Echtheit noch ein Warnsignal.',
      ),
    ],
    explanation:
        'Typische Merkmale sind eine fremde Absenderdomain, Druck und Drohung, ein abweichendes Linkziel und die Bitte um Zugangsdaten. Ein Logo sagt nichts über die Echtheit.',
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
        'Beim Man-in-the-Middle-Angriff schaltet sich der Angreifer zwischen zwei Kommunikationspartner. Schutz bietet eine verschlüsselte Verbindung mit Zertifikatsprüfung, etwa TLS (HTTPS) oder ein VPN.',
  ),
  freitext(
    'a6-za-4',
    'sz-angriffe',
    scenario:
        'Das Protokoll eines Kundenportals zeigt mehrere tausend fehlgeschlagene Anmeldungen je Stunde auf dasselbe Benutzerkonto.',
    prompt:
        'Nenne drei Maßnahmen, die das Anmeldeportal gegen Brute-Force-Angriffe schützen. (3 P.)',
    kriterien: [
      krit(
        'Konto nach wenigen Fehlversuchen zeitweise sperren',
        stichwoerter: ['Kontosperre', 'sperren', 'Fehlversuche', 'Sperrung'],
      ),
      krit(
        'Wartezeit nach jedem Fehlversuch verlängern',
        stichwoerter: ['Wartezeit', 'Verzögerung', 'verzögern', 'Zeitsperre'],
      ),
      krit(
        'Zwei-Faktor-Authentifizierung verlangen',
        stichwoerter: [
          'Zwei-Faktor',
          '2FA',
          'MFA',
          'zweiter Faktor',
          'Einmalcode',
        ],
      ),
      krit(
        'Lange Passwörter vorschreiben',
        stichwoerter: [
          'lange Passwörter',
          'Passwortlänge',
          'Passwortrichtlinie',
          'Mindestlänge',
        ],
      ),
      krit(
        'CAPTCHA einsetzen oder auffällige IP-Adressen sperren',
        stichwoerter: [
          'CAPTCHA',
          'IP-Adresse sperren',
          'IP sperren',
          'Rate Limiting',
        ],
      ),
    ],
    punkte: 3,
    loesung:
        'Wirksam sind: das Konto nach wenigen Fehlversuchen zeitweise sperren, die Wartezeit nach jedem Fehlversuch verlängern, eine Zwei-Faktor-Authentifizierung verlangen, lange Passwörter vorschreiben und automatisierte Anfragen durch CAPTCHAs oder das Sperren auffälliger IP-Adressen bremsen.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 3 Punkte. Alle Maßnahmen bremsen das massenhafte Durchprobieren oder machen ein erratenes Passwort allein wertlos.',
  ),
  einfach(
    'a6-za-5',
    'sz-angriffe',
    scenario:
        'Auf dem Firmenparkplatz liegt ein USB-Stick mit der Aufschrift „Gehälter 2026, vertraulich“. Ein Mitarbeiter steckt ihn aus Neugier an seinen Arbeits-PC.',
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
        'Bei zehntausenden Quellen bleibt die Sperre einer Adresse wirkungslos. Hier hilft ein DDoS-Schutzdienst.',
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
        'XSS entsteht, wenn eine Webanwendung Eingaben ungeprüft wieder ausgibt. Davor schützt, Eingaben zu prüfen und Ausgaben zu maskieren, damit Skriptcode als Text angezeigt statt ausgeführt wird.',
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
        'Die Mehrheit zählt nicht. Sonst wären die Personaldaten unzureichend geschützt.',
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
        'Nach dem Maximumprinzip erbt das IT-System den höchsten Schutzbedarf der Anwendungen, die darauf laufen. Hier ist das „hoch“ von der Personalverwaltung.',
  ),
  zuordnen(
    'a6-zb-2',
    'sz-schutzbedarf',
    prompt: 'Welche Regel der Schutzbedarfsfeststellung wird angewendet?',
    buckets: ['Maximumprinzip', 'Kumulationseffekt', 'Verteilungseffekt'],
    items: [
      zu(
        'Auf dem Dateiserver liegen Projektdaten (normal) und Personalakten (hoch), deshalb wird er mit „hoch“ eingestuft',
        0,
        'Der höchste Einzelwert gilt.',
      ),
      zu(
        'Ein Virtualisierungshost trägt 30 VMs mit jeweils „normal“. Weil ein Ausfall alle trifft, wird er mit „hoch“ eingestuft',
        1,
        'Viele kleine Schäden summieren sich zu einem großen.',
      ),
      zu(
        'Der Webshop (Verfügbarkeit „hoch“) läuft auf drei redundanten Servern. Ein einzelner Server wird mit „normal“ eingestuft',
        2,
        'Fällt ein Server aus, übernehmen die anderen.',
      ),
    ],
    explanation:
        'Beim Maximumprinzip gilt der höchste Wert. Beim Kumulationseffekt erhöhen viele kleine Schäden zusammen den Schutzbedarf, beim Verteilungseffekt kann Redundanz ihn für ein einzelnes System senken.',
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
        'Welche Schadensszenarien sieht das BSI für die Schutzbedarfsfeststellung vor?',
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
        'Für die Anwendung selbst gilt ihr eigener Wert, also normal.',
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
  paare(
    'a6-zb-7',
    'sz-schutzbedarf',
    prompt:
        'Ordne jeder Schutzbedarfskategorie des BSI die Beschreibung der Schadensauswirkungen zu.',
    paare: [
      paar('normal', 'begrenzt und überschaubar'),
      paar('hoch', 'beträchtlich'),
      paar('sehr hoch', 'existenziell bedrohlich, katastrophal'),
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
        'Die Herkunft allein genügt nicht. Auch Port und Protokoll müssen zu einer Regel passen.',
      ),
    ],
    explanation:
        'Die Firewall prüft von oben nach unten, die erste passende Regel entscheidet. Für Port 80 passt erst Regel 3 (Default Deny).',
  ),
  paare(
    'a6-yf-2',
    'sm-firewall',
    prompt: 'Ordne jeder Firewall-Art ihr Merkmal zu.',
    paare: [
      paar('Paketfilter', 'prüft nur Adressen und Ports je Paket'),
      paar('Stateful Inspection', 'merkt sich den Zustand jeder Verbindung'),
      paar('Application-Firewall', 'prüft auch den Inhalt, z. B. von HTTP'),
      paar('Personal Firewall', 'läuft als Software auf dem Endgerät'),
    ],
    explanation:
        'Der Paketfilter entscheidet je Paket nach Adresse und Port. Stateful Inspection kennt zusätzlich den Verbindungszustand und lässt Antworten automatisch zu. Eine Application-Firewall (Proxy, Schicht 7) versteht das Anwendungsprotokoll und kann Schadcode im Inhalt erkennen. Die Personal Firewall schützt den einzelnen Rechner.',
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
  lueckentext(
    'a6-yf-4',
    'sm-firewall',
    prompt: 'Ergänze die Aussagen zu Firewalls.',
    text:
        'Ein Regelwerk wird von oben nach unten abgearbeitet; es gilt die {0} passende Regel. Am Ende steht die Regel „alles {1}“. Dieses Prinzip heißt {2}. Eine Stateful-Firewall lässt Antwortpakete zu einer erlaubten Verbindung {3} durch. Server, die aus dem Internet erreichbar sein müssen, stehen in der {4}.',
    luecken: [
      wahl('erste', ['letzte', 'strengste']),
      wahl('verwerfen', ['erlauben', 'protokollieren']),
      wahl('Default Deny', ['Default Allow', 'Minimalprinzip']),
      wahl('automatisch', ['nie', 'nur mit eigener Regel']),
      wahl('DMZ', ['LAN', 'VPN']),
    ],
    explanation:
        'Regeln werden der Reihe nach geprüft, die erste passende entscheidet. Was keine Regel erlaubt, wird verworfen (Default Deny). Eine Stateful-Firewall merkt sich Verbindungen und lässt die Antworten ohne eigene Regel zurück. Öffentliche Server gehören in die DMZ.',
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
        'Die erste passende Regel entscheidet. Die Sperrregel muss ans Ende.',
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
        'Der Paketfilter prüft einzelne Pakete nach ihren Kopfdaten, Stateful Inspection kennt zusätzlich den Verbindungszustand. Ein Application-Level-Gateway prüft die Inhalte auf Schicht 7, und ein IPS erkennt und blockiert Angriffe.',
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
        'Doch. Genau dafür steht er in der DMZ, die Firewall gibt die nötigen Ports frei.',
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
        'Die einstufige DMZ ist günstig und einfach, aber die ganze Sicherheit hängt an einer einzigen Firewall. Bei der zweistufigen DMZ muss ein Angreifer zwei Firewalls überwinden.',
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
        'Die letzte Sicherung lief am Mittwochabend. Benötigt werden die Vollsicherung vom Sonntag und alle Inkremente seitdem: Montag, Dienstag, Mittwoch. 1 + 3 = 4 Bänder.',
  ),
  lueckentext(
    'a6-yb-3',
    'sm-backup',
    scenario:
        'Ein Büro bewahrt seine Daten auf dem Server, auf einem NAS im selben Raum und zusätzlich verschlüsselt bei einem Cloud-Anbieter auf.',
    prompt: 'Ergänze die 3-2-1-Regel.',
    text:
        'Von wichtigen Daten gibt es mindestens {0} Kopien, gespeichert auf {1} verschiedenen Arten von Speichermedien; mindestens {2} Kopie liegt außer Haus. Im Beispiel erfüllt die Kopie {3} die Forderung „außer Haus“.',
    luecken: [
      zahl(3),
      zahl(2),
      zahl(1),
      wahl('beim Cloud-Anbieter', ['auf dem NAS', 'auf dem Server']),
    ],
    explanation:
        '3-2-1-Regel: 3 Kopien (Original eingeschlossen), 2 verschiedene Medienarten, 1 Kopie an einem anderen Ort. Das NAS im selben Raum schützt nicht vor Brand oder Einbruch. Das leistet nur die Kopie beim Cloud-Anbieter.',
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
        'Das RPO beschreibt den maximal hinnehmbaren Datenverlust. Hier müsste mindestens alle 4 Stunden gesichert werden.',
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
  paare(
    'a6-yb-7',
    'sm-backup',
    prompt:
        'Ordne den Generationen im Großvater-Vater-Sohn-Prinzip die Sicherung zu.',
    paare: [
      paar('Sohn', 'Tagessicherung, wird am schnellsten überschrieben'),
      paar('Vater', 'Wochensicherung'),
      paar('Großvater', 'Monatssicherung, wird am längsten aufbewahrt'),
    ],
    difficulty: 1,
    explanation:
        'Beim Großvater-Vater-Sohn-Prinzip werden tägliche Sicherungen (Sohn) schnell überschrieben, wöchentliche (Vater) länger und monatliche (Großvater) am längsten aufbewahrt.',
  ),
  tabelle(
    'a6-yb-8',
    'sm-backup',
    prompt: 'Ergänze den Vergleich der drei Sicherungsarten.',
    zeilen: [
      ['Merkmal', 'voll', 'differenziell', 'inkrementell'],
      [
        'Gesichert wird',
        'alles',
        wahl('Änderungen seit der letzten Vollsicherung', [
          'Änderungen seit der letzten Sicherung',
          'alles',
        ]),
        wahl('Änderungen seit der letzten Sicherung', [
          'Änderungen seit der letzten Vollsicherung',
          'alles',
        ]),
      ],
      [
        'Speicherbedarf',
        'am größten',
        wahl('wächst täglich', ['am größten', 'am kleinsten']),
        wahl('am kleinsten', ['am größten', 'wächst täglich']),
      ],
      [
        'Zur Wiederherstellung nötig',
        'nur die Vollsicherung',
        wahl('Voll + letzte Sicherung', [
          'Voll + alle Sicherungen',
          'nur die letzte Sicherung',
        ]),
        wahl('Voll + alle Sicherungen', [
          'Voll + letzte Sicherung',
          'nur die letzte Sicherung',
        ]),
      ],
    ],
    explanation:
        'Die differenzielle Sicherung enthält alle Änderungen seit der letzten Vollsicherung, wächst also täglich und braucht zur Wiederherstellung nur Voll + letzte Differenz. Die inkrementelle sichert nur die Änderungen seit der letzten Sicherung, braucht am wenigsten Speicher, aber zur Wiederherstellung Voll + alle Inkremente in der richtigen Reihenfolge.',
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
        'Das ist der aktuelle Standard. Dank SAE schützt er vor Offline-Wörterbuchangriffen.',
      ),
      nein(
        'WPA2 mit AES',
        'Das gilt als Minimum, ist aber nicht der aktuelle Stand, wenn alle Geräte WPA3 können.',
      ),
      nein('WPA2 mit TKIP', 'TKIP ist veraltet und gilt als unsicher.'),
      nein('WEP', 'WEP ist seit Jahren gebrochen.'),
    ],
    explanation:
        'Stand der Technik ist WPA3. Wo Altgeräte es nicht können, ist WPA2 mit AES das Minimum. WEP und TKIP sind tabu.',
  ),
  freitext(
    'a6-yw-2',
    'sm-wlan',
    scenario:
        'Eine Arztpraxis betreibt ein WLAN für die Praxisgeräte und möchte Patienten im Wartezimmer Internet anbieten.',
    prompt:
        'Nenne vier Maßnahmen, die die Sicherheit des WLANs wirksam erhöhen. (4 P.)',
    kriterien: [
      krit(
        'Aktuelle Verschlüsselung einsetzen: WPA3, mindestens WPA2 mit AES',
        stichwoerter: ['WPA3', 'WPA2', 'Verschlüsselung', 'AES'],
      ),
      krit(
        'Langen, zufälligen WLAN-Schlüssel verwenden',
        stichwoerter: [
          'langer Schlüssel',
          'langes Passwort',
          'starkes Passwort',
          'sicheres Passwort',
          'Passphrase',
        ],
      ),
      krit(
        'WPS abschalten',
        stichwoerter: ['WPS', 'abschalten', 'deaktivieren'],
      ),
      krit(
        'Getrenntes Gastnetz ohne Zugriff auf das Praxisnetz einrichten',
        stichwoerter: ['Gastnetz', 'Gast-WLAN', 'getrennt', 'VLAN'],
      ),
      krit(
        'Standardpasswort des Access Points ändern und Firmware aktuell halten',
        stichwoerter: [
          'Standardpasswort',
          'Firmware',
          'Update',
          'Admin-Passwort',
        ],
      ),
      krit(
        'Im Unternehmen: Anmeldung je Person über WPA-Enterprise (802.1X, RADIUS)',
        stichwoerter: [
          'Enterprise',
          '802.1X',
          'RADIUS',
          'persönliche Zugangsdaten',
        ],
      ),
    ],
    punkte: 4,
    loesung:
        'Wirksam sind: WPA3 (mindestens WPA2 mit AES), ein langer zufälliger Schlüssel, abgeschaltetes WPS, ein getrenntes Gastnetz ohne Zugriff auf das interne Netz, ein geändertes Administratorpasswort und aktuelle Firmware. Das Verstecken der SSID und MAC-Filter bringen dagegen kaum Sicherheit.',
    explanation:
        'Je Nennung 1 Punkt, höchstens 4 Punkte. Nicht gewertet werden Scheinmaßnahmen wie das Verstecken der SSID oder ein MAC-Filter, denn beides lässt sich leicht umgehen.',
  ),
  zuordnen(
    'a6-yw-3',
    'sm-wlan',
    prompt:
        'Welche Rolle bei der Anmeldung nach 802.1X hat das jeweilige Gerät?',
    buckets: ['Supplicant', 'Authenticator', 'Authentication Server'],
    items: [
      zu(
        'Notebook einer Mitarbeiterin',
        0,
        'Es ist das Endgerät, das Zugang möchte.',
      ),
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
        'Der Supplicant ist das Endgerät, der Authenticator der Access Point oder Switch und der Authentication Server meist ein RADIUS-Server.',
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
        'Das WLAN-Passwort auf allen Geräten ändern. Mit Enterprise würde man nur sein persönliches Konto sperren.',
        'Bei Personal kennen alle dasselbe Passwort, bei Enterprise meldet sich jede Person mit eigenen Zugangsdaten über 802.1X an.',
      ),
      nein(
        'Nichts. Ein WLAN-Passwort lässt sich nicht weitergeben.',
        'Der ehemalige Mitarbeiter kennt das Passwort und kann es nutzen oder weitergeben.',
      ),
      nein(
        'Nur die SSID verstecken. Mit Enterprise wäre das ebenso nötig.',
        'Eine versteckte SSID ist leicht zu finden und schützt nicht.',
      ),
      nein(
        'Den MAC-Filter um sein privates Handy ergänzen. Mit Enterprise wäre das ebenso nötig.',
        'MAC-Adressen lassen sich fälschen, und er kann jedes andere Gerät benutzen.',
      ),
    ],
    explanation:
        'WPA-Personal nutzt ein gemeinsames Passwort, das nur durch Ändern auf allen Geräten widerrufen werden kann. WPA-Enterprise prüft über 802.1X und RADIUS persönliche Zugangsdaten, sodass sich ein einzelnes Konto sperren lässt.',
  ),
  paare(
    'a6-yw-6',
    'sm-wlan',
    prompt: 'Ordne jedem WLAN-Sicherheitsstandard die Bewertung zu.',
    paare: [
      paar('WEP', 'gebrochen, in Minuten zu knacken'),
      paar('WPA mit TKIP', 'veraltet, nicht mehr einsetzen'),
      paar('WPA2-Personal', 'gemeinsamer Schlüssel mit AES, noch verbreitet'),
      paar('WPA3-Personal', 'SAE schützt vor Offline-Wörterbuchangriffen'),
      paar('WPA3-Enterprise', 'Anmeldung je Person über RADIUS'),
    ],
    explanation:
        'WEP und WPA/TKIP sind unsicher. WPA2-Personal mit AES gilt bei starkem Schlüssel noch als brauchbar. WPA3-Personal ersetzt die Aushandlung durch SAE: Mitgeschnittene Anmeldungen lassen sich nicht mehr offline durchprobieren, und alte Mitschnitte bleiben auch bei bekanntem Passwort geschützt. Enterprise meldet jede Person einzeln über einen RADIUS-Server an.',
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
        NetzKnoten('nb', 'Praxis-Notebook', NetzTyp.laptop, 1.0, 5.6),
        NetzKnoten('gast', 'Gast-Handy', NetzTyp.smartphone, 3.5, 5.6),
      ],
      verbindungen: [
        NetzVerbindung('inet', 'fw'),
        NetzVerbindung('fw', 'sw'),
        NetzVerbindung('sw', 'srv'),
        NetzVerbindung('sw', 'ap', label: 'VLAN 10 + 20'),
        NetzVerbindung('ap', 'nb', funk: true),
        NetzVerbindung('ap', 'gast', funk: true),
      ],
      zonen: [
        NetzZone('VLAN 10 intern', 0, 3.2, 2.6, 6),
        NetzZone('VLAN 20 Gäste', 2.8, 5.0, 3.9, 6),
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
      zu(
        'Chipkartenleser an der Tür zum Serverraum',
        0,
        'Er schützt einen Raum.',
      ),
      zu(
        'Anmeldung am Notebook mit Passwort und Fingerabdruck',
        1,
        'Sie schützt die Nutzung des IT-Systems.',
      ),
      zu(
        'Nur die Personalabteilung darf den Ordner „Gehälter“ öffnen',
        2,
        'Das regelt die Rechte an bestimmten Daten.',
      ),
      zu(
        'Besuchende werden am Empfang registriert und begleitet',
        0,
        'So wird das Betreten des Gebäudes kontrolliert.',
      ),
      zu(
        'Leserecht, aber kein Schreibrecht auf die Preisliste',
        2,
        'Das regelt, was mit bestimmten Daten erlaubt ist.',
      ),
    ],
    explanation:
        'Zutritt betrifft Räume und Gebäude, Zugang die Nutzung von IT-Systemen und Zugriff die Rechte an bestimmten Daten und Funktionen.',
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
        'So häufen sich Rechte an, und das verstößt gegen das Minimalprinzip.',
      ),
      nein(
        'Ihm Administratorrechte geben, damit er überall Zugriff hat',
        'Das wären weit mehr Rechte als nötig und ein hohes Risiko.',
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
        'Das vergrößert die Angriffsfläche, also das Gegenteil von Härtung.',
      ),
      nein(
        'Das Administratorkonto für die tägliche Arbeit nutzen',
        'Alltagsarbeit gehört in ein Konto ohne Adminrechte.',
      ),
    ],
    explanation:
        'Härtung verkleinert die Angriffsfläche: Unnötiges abschalten, Standardzugänge ändern, Updates einspielen.',
  ),
  freitext(
    'a6-yz-4',
    'sm-zugriff',
    scenario:
        'Ein Administrator liest E-Mails und surft im Internet, während er mit seinem Administratorkonto angemeldet ist.',
    prompt:
        'Erläutere, warum für E-Mail und Internet ein normales Benutzerkonto verwendet werden soll. (3 P.)',
    kriterien: [
      krit(
        'Schadsoftware aus einem Anhang oder von einer Webseite läuft mit den Rechten des angemeldeten Kontos',
        punkte: 2,
        stichwoerter: [
          'Rechten des Kontos',
          'mit den Rechten',
          'Schadsoftware',
          'Malware',
          'Adminrechte',
        ],
      ),
      krit(
        'Mit einem normalen Konto bleibt der Schaden begrenzt. Mit Administratorrechten wäre das ganze System oder Netz betroffen',
        stichwoerter: [
          'Schaden begrenzt',
          'ganzes System',
          'systemweit',
          'gesamtes Netz',
          'begrenzen',
        ],
      ),
    ],
    loesung:
        'Schadsoftware, die über einen E-Mail-Anhang oder eine präparierte Webseite gestartet wird, läuft mit den Rechten des angemeldeten Kontos. Ist das ein Administratorkonto, kann sie sich im ganzen System einnisten, Schutzprogramme abschalten und weitere Rechner angreifen. Mit einem normalen Benutzerkonto bleibt der Schaden auf dessen Rechte begrenzt (Minimalprinzip).',
    explanation:
        '2 Punkte für den Grund (Schadsoftware erbt die Rechte des Kontos), 1 Punkt für die Folge (Schaden bleibt begrenzt). Das ist das Minimalprinzip, angewendet auf Administratoren.',
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
        'Ein fehlendes Recht einer Rolle hebt die Rechte einer anderen Rolle nicht auf. Sie addieren sich.',
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
        'Der Besitzer entscheidet über seine Objekte, also benutzerbestimmt.',
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
        'Bei DAC vergibt der Besitzer die Rechte, bei MAC erzwingt das System Sicherheitsstufen. Bei RBAC hängen die Rechte an Rollen, das ist das übliche Modell in Unternehmen.',
  ),
  markieren(
    'a6-yz-7',
    'sm-zugriff',
    scenario:
        'Bei einer Überprüfung der Benutzerverwaltung eines Handelsunternehmens fallen folgende Punkte auf.',
    prompt:
        'Markiere alle Punkte, die gegen das Minimalprinzip (Least Privilege) verstoßen.',
    zeilen: [
      nein(
        'Der Vertrieb hat auf die Preisliste nur Leserecht.',
        'Mehr als Lesen braucht der Vertrieb für seine Aufgabe nicht.',
      ),
      ja(
        'Alle Azubis haben Adminrechte, damit sie Software selbst installieren können.',
        'Das sind weit mehr Rechte als nötig und eine offene Tür für Schadsoftware.',
      ),
      nein(
        'Administratoren nutzen für E-Mail und Internet ein normales Konto.',
        'Adminrechte gibt es nur für Verwaltungsaufgaben.',
      ),
      ja(
        'Die Buchhaltung nutzt ein gemeinsames Konto mit allen Rechten.',
        'Geteilte Konten bündeln Rechte und machen Aktionen unzurechenbar.',
      ),
      ja(
        'Eine Mitarbeiterin hat nach dem Wechsel in den Einkauf weiter Zugriff auf die Personalakten.',
        'Rechte der alten Rolle müssen entzogen werden.',
      ),
      nein(
        'Das Konto eines ausgeschiedenen Mitarbeiters wurde am letzten Arbeitstag gesperrt.',
        'Nicht mehr benötigte Konten werden sofort gesperrt.',
      ),
    ],
    explanation:
        'Minimalprinzip: Jedes Konto bekommt nur die Rechte, die es für seine Aufgabe braucht, und verliert sie, sobald die Aufgabe entfällt. Verstöße sind pauschale Adminrechte, geteilte Konten mit allen Rechten und mitgeschleppte Rechte nach einem Abteilungswechsel.',
  ),
];
