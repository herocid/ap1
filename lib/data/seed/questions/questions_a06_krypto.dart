import '../../models/question.dart';
import '../builders.dart';

/// Aufgaben Bereich 06, Teil 2: Kryptographie, Authentifizierung und Datenschutz.
final List<Question> questionsA06Krypto = [
  // ============================================== Symmetrische Verschlüsselung
  rechnen(
    'a6-cs-1',
    'kr-symmetrisch',
    scenario:
        'In einer Abteilung sollen 20 Mitarbeitende paarweise vertraulich miteinander kommunizieren können. Eingesetzt wird ein rein symmetrisches Verfahren.',
    prompt: 'Wie viele verschiedene Schlüssel werden insgesamt benötigt?',
    answer: 190,
    unit: 'Schlüssel',
    explanation:
        'Jedes Paar braucht einen eigenen Schlüssel: n × (n - 1) / 2 = 20 × 19 / 2 = 380 / 2 = 190 Schlüssel.',
  ),
  einfach(
    'a6-cs-2',
    'kr-symmetrisch',
    prompt:
        'Welches Verfahren ist ein symmetrisches Verschlüsselungsverfahren?',
    choices: [
      ja(
        'AES',
        'AES nutzt denselben Schlüssel zum Ver- und Entschlüsseln und ist der aktuelle Standard.',
      ),
      nein('RSA', 'RSA ist asymmetrisch und arbeitet mit einem Schlüsselpaar.'),
      nein('SHA-256', 'SHA-256 ist eine Hashfunktion und verschlüsselt nicht.'),
      nein(
        'ECC',
        'ECC (elliptische Kurven) gehört zu den asymmetrischen Verfahren.',
      ),
    ],
    explanation:
        'AES ist symmetrisch, RSA und ECC sind asymmetrisch, SHA-256 ist ein Hashverfahren ohne Schlüssel.',
  ),
  mehrfach(
    'a6-cs-3',
    'kr-symmetrisch',
    prompt: 'Welche Aussagen zur symmetrischen Verschlüsselung sind richtig?',
    choices: [
      ja(
        'Sie ist deutlich schneller als asymmetrische Verschlüsselung.',
        'Deshalb werden große Datenmengen immer symmetrisch verschlüsselt.',
      ),
      ja(
        'Der Schlüssel muss vorab sicher ausgetauscht werden.',
        'Das ist das Schlüsselaustauschproblem.',
      ),
      ja(
        'AES kann mit einem 256-Bit-Schlüssel arbeiten.',
        'AES erlaubt 128, 192 und 256 Bit.',
      ),
      nein(
        'DES gilt heute noch als sicher.',
        'Der 56-Bit-Schlüssel von DES lässt sich durch Ausprobieren knacken.',
      ),
      nein(
        'Jede Person braucht einen öffentlichen und einen privaten Schlüssel.',
        'Das beschreibt asymmetrische Verfahren.',
      ),
    ],
    explanation:
        'Symmetrisch heißt: ein gemeinsamer Schlüssel, sehr schnell, aber mit dem Problem, ihn sicher zu übergeben.',
  ),
  einfach(
    'a6-cs-4',
    'kr-symmetrisch',
    scenario:
        'Ein Azubi soll einer Kundin eine mit AES verschlüsselte ZIP-Datei per E-Mail schicken.',
    prompt: 'Wie übermittelt er das Passwort am sichersten?',
    choices: [
      ja(
        'Über einen anderen Kanal, z. B. telefonisch',
        'Wer die E-Mail mitliest, kennt dann das Passwort noch nicht.',
      ),
      nein(
        'Im Text derselben E-Mail',
        'Wer die E-Mail abfängt, hat Datei und Passwort zugleich.',
      ),
      nein(
        'Im Dateinamen der ZIP-Datei',
        'Der Dateiname ist für jeden sichtbar, der die Mail sieht.',
      ),
      nein(
        'In einer zweiten E-Mail direkt danach',
        'Beide Mails laufen über denselben Kanal und können gemeinsam mitgelesen werden.',
      ),
    ],
    explanation:
        'Das Schlüsselaustauschproblem löst man ohne Kryptographie nur über einen zweiten, unabhängigen Kanal.',
  ),
  rechnen(
    'a6-cs-5',
    'kr-symmetrisch',
    scenario:
        'Sechs Filialen eines Händlers sollen jeweils paarweise über symmetrisch verschlüsselte Verbindungen gekoppelt werden - jede Filiale mit jeder anderen, jede Verbindung mit eigenem Schlüssel.',
    prompt: 'Wie viele Schlüssel werden benötigt?',
    answer: 15,
    unit: 'Schlüssel',
    difficulty: 1,
    explanation:
        'Jedes Paar braucht einen eigenen Schlüssel: n × (n - 1) / 2 = 6 × 5 / 2 = 30 / 2 = 15 Schlüssel.',
  ),
  einfach(
    'a6-cs-6',
    'kr-symmetrisch',
    scenario:
        'Eine Nachricht wurde mit der Caesar-Verschiebung um 3 Stellen verschlüsselt. Der Geheimtext lautet FDHVDU.',
    prompt: 'Wie lautet der Klartext?',
    choices: [
      ja(
        'CAESAR',
        'Jeder Buchstabe rückt 3 Stellen zurück: F -> C, D -> A, H -> E, V -> S, D -> A, U -> R.',
      ),
      nein(
        'IGKYGX',
        'Hier wurde noch einmal um 3 vorwärts verschoben statt zurück.',
      ),
      nein('CAESER', 'Der fünfte Buchstabe D wird zu A, nicht zu E.'),
      nein('FDHVDU', 'Das ist der unveränderte Geheimtext.'),
    ],
    difficulty: 1,
    explanation:
        'Bei symmetrischen Verfahren entschlüsselt derselbe Schlüssel: Caesar mit Schlüssel 3 verschiebt beim Entschlüsseln jeden Buchstaben um 3 Stellen zurück. FDHVDU wird so zu CAESAR.',
  ),
  rechnen(
    'a6-cs-7',
    'kr-symmetrisch',
    prompt:
        'Ein symmetrischer Schlüssel wird von 64 auf 72 Bit verlängert. Um welchen Faktor steigt die Zahl der möglichen Schlüssel?',
    answer: 256,
    unit: 'fach',
    difficulty: 2,
    explanation:
        'Die Zahl der Schlüssel ist 2^Bitlänge. 2^72 / 2^64 = 2^(72 - 64) = 2^8 = 256. Jedes zusätzliche Bit verdoppelt die Anzahl, 8 Bit mehr ergeben also den Faktor 256.',
  ),
  einfach(
    'a6-cs-8',
    'kr-symmetrisch',
    prompt: 'Worauf beruht die Sicherheit eines modernen Verfahrens wie AES?',
    choices: [
      ja(
        'Allein auf der Geheimhaltung des Schlüssels - das Verfahren selbst ist öffentlich.',
        'Das ist das Kerckhoffs-Prinzip: Ein gutes Verfahren bleibt sicher, auch wenn jeder weiß, wie es funktioniert.',
      ),
      nein(
        'Auf der Geheimhaltung des Verfahrens',
        'Geheime Verfahren gelten als unsicher, weil sie nicht von Fachleuten geprüft werden können.',
      ),
      nein(
        'Darauf, dass der Geheimtext kürzer ist als der Klartext',
        'Die Länge sagt nichts über die Sicherheit aus.',
      ),
      nein(
        'Auf einem öffentlichen und einem privaten Schlüssel',
        'Das beschreibt asymmetrische Verfahren - AES ist symmetrisch.',
      ),
    ],
    explanation:
        'Nach dem Kerckhoffs-Prinzip darf das Verfahren bekannt sein; die Sicherheit hängt nur vom geheimen Schlüssel und seiner Länge ab. AES ist öffentlich und gründlich geprüft.',
  ),

  // ============================================= Asymmetrische Verschlüsselung
  einfach(
    'a6-ca-1',
    'kr-asymmetrisch',
    scenario:
        'Anna will Ben eine vertrauliche Nachricht schicken. Beide haben ein asymmetrisches Schlüsselpaar.',
    prompt: 'Mit welchem Schlüssel verschlüsselt Anna die Nachricht?',
    choices: [
      ja(
        'Mit Bens öffentlichem Schlüssel',
        'Dann kann nur Ben sie mit seinem privaten Schlüssel entschlüsseln.',
      ),
      nein(
        'Mit Annas privatem Schlüssel',
        'Das wäre eine Signatur - jeder könnte sie mit Annas öffentlichem Schlüssel lesen.',
      ),
      nein(
        'Mit Annas öffentlichem Schlüssel',
        'Dann könnte nur Anna selbst die Nachricht entschlüsseln.',
      ),
      nein(
        'Mit Bens privatem Schlüssel',
        'Den kennt nur Ben - Anna hat ihn nicht.',
      ),
    ],
    explanation:
        'Für Vertraulichkeit wird immer mit dem öffentlichen Schlüssel des Empfängers verschlüsselt und mit dessen privatem Schlüssel entschlüsselt.',
  ),
  zuordnen(
    'a6-ca-2',
    'kr-asymmetrisch',
    prompt: 'Welcher Schlüssel wird für den jeweiligen Schritt benutzt?',
    buckets: [
      'öffentlicher Schlüssel des Absenders',
      'privater Schlüssel des Absenders',
      'öffentlicher Schlüssel des Empfängers',
      'privater Schlüssel des Empfängers',
    ],
    items: [
      zu(
        'Signatur prüfen',
        0,
        'Jeder kann prüfen - dafür genügt der öffentliche Schlüssel des Absenders.',
      ),
      zu(
        'Signatur erstellen',
        1,
        'Nur der Absender besitzt seinen privaten Schlüssel - deshalb beweist die Signatur die Herkunft.',
      ),
      zu(
        'Nachricht verschlüsseln',
        2,
        'Mit dem öffentlichen Schlüssel des Empfängers kann jeder verschlüsseln.',
      ),
      zu(
        'Nachricht entschlüsseln',
        3,
        'Nur der Empfänger kann mit seinem privaten Schlüssel entschlüsseln.',
      ),
    ],
    explanation:
        'Verschlüsseln: öffentlich beim Empfänger, entschlüsseln mit dessen privatem Schlüssel. Signieren: privat beim Absender, prüfen mit dessen öffentlichem Schlüssel.',
  ),
  rechnen(
    'a6-ca-3',
    'kr-asymmetrisch',
    scenario:
        '50 Personen wollen untereinander vertraulich kommunizieren und nutzen dazu ein asymmetrisches Verfahren.',
    prompt:
        'Wie viele Schlüssel gibt es insgesamt (öffentliche und private zusammen)?',
    answer: 100,
    unit: 'Schlüssel',
    explanation:
        'Jede Person hat ein Schlüsselpaar: 2 × n = 2 × 50 = 100 Schlüssel. Symmetrisch wären es 50 × 49 / 2 = 1.225.',
  ),
  mehrfach(
    'a6-ca-4',
    'kr-asymmetrisch',
    prompt: 'Welche Aussagen zur digitalen Signatur sind richtig?',
    choices: [
      ja(
        'Sie weist nach, dass die Nachricht nicht verändert wurde.',
        'Jede Änderung führt zu einem anderen Hashwert - der Vergleich schlägt fehl.',
      ),
      ja(
        'Sie weist nach, wer die Nachricht signiert hat.',
        'Nur der Besitzer des privaten Schlüssels kann eine passende Signatur erzeugen.',
      ),
      ja(
        'Sie wird mit dem privaten Schlüssel des Absenders erstellt.',
        'Geprüft wird mit dem zugehörigen öffentlichen Schlüssel.',
      ),
      nein(
        'Sie macht den Inhalt der Nachricht vertraulich.',
        'Die Nachricht selbst bleibt lesbar. Für Vertraulichkeit muss zusätzlich verschlüsselt werden.',
      ),
      nein(
        'Zum Prüfen braucht der Empfänger den privaten Schlüssel des Absenders.',
        'Der private Schlüssel verlässt nie den Absender - geprüft wird mit dem öffentlichen.',
      ),
    ],
    explanation:
        'Eine Signatur sichert Integrität und Authentizität, aber keine Vertraulichkeit. Signiert wird privat, geprüft öffentlich.',
  ),
  einfach(
    'a6-ca-5',
    'kr-asymmetrisch',
    scenario:
        'Die Buchhaltung von Bob will eine Rechnung digital signieren, damit Kundin Alice prüfen kann, dass sie wirklich von Bob stammt und unverändert ist.',
    prompt: 'Mit welchem Schlüssel wird der Hashwert der Rechnung signiert?',
    choices: [
      ja(
        'Mit Bobs privatem Schlüssel',
        'Nur Bob besitzt ihn - deshalb beweist die Signatur die Herkunft.',
      ),
      nein(
        'Mit Bobs öffentlichem Schlüssel',
        'Den kennt jeder - eine damit erzeugte „Signatur“ könnte jeder fälschen.',
      ),
      nein(
        'Mit Alices öffentlichem Schlüssel',
        'Damit würde man für Alice verschlüsseln, nicht signieren.',
      ),
      nein('Mit Alices privatem Schlüssel', 'Den hat Bob nicht.'),
    ],
    difficulty: 1,
    explanation:
        'Signiert wird mit dem eigenen privaten Schlüssel, geprüft mit dem öffentlichen Schlüssel des Absenders. So kann jeder prüfen, aber nur der Absender signieren.',
  ),
  mehrfach(
    'a6-ca-6',
    'kr-asymmetrisch',
    scenario:
        'Anna schickt Ben ein Angebot. Es soll signiert sein, damit Ben die Herkunft prüfen kann, und verschlüsselt, damit niemand sonst es lesen kann.',
    prompt: 'Welche Schlüssel verwendet Anna?',
    choices: [
      ja(
        'Ihren eigenen privaten Schlüssel',
        'Damit erstellt sie die Signatur.',
      ),
      ja(
        'Bens öffentlichen Schlüssel',
        'Damit verschlüsselt sie das Angebot, sodass nur Ben es entschlüsseln kann.',
      ),
      nein('Bens privaten Schlüssel', 'Den besitzt nur Ben.'),
      nein(
        'Ihren eigenen öffentlichen Schlüssel',
        'Damit verschlüsselt könnte nur Anna selbst die Nachricht lesen.',
      ),
      nein(
        'Einen gemeinsamen Schlüssel, den sie Ben in derselben Mail schickt',
        'Wer die Mail mitliest, hätte den Schlüssel gleich mit.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Signieren: eigener privater Schlüssel des Absenders. Verschlüsseln: öffentlicher Schlüssel des Empfängers. Ben entschlüsselt mit seinem privaten Schlüssel und prüft die Signatur mit Annas öffentlichem.',
  ),
  zuordnen(
    'a6-ca-7',
    'kr-asymmetrisch',
    prompt: 'Gehört die Angabe zu symmetrischen oder asymmetrischen Verfahren?',
    buckets: ['symmetrisch', 'asymmetrisch'],
    items: [
      zu('AES', 0, 'AES nutzt einen gemeinsamen Schlüssel.'),
      zu(
        '3DES',
        0,
        'Auch 3DES arbeitet mit einem gemeinsamen, geheimen Schlüssel.',
      ),
      zu('RSA', 1, 'RSA arbeitet mit einem Schlüsselpaar.'),
      zu(
        'ECC',
        1,
        'Verfahren mit elliptischen Kurven nutzen ebenfalls Schlüsselpaare.',
      ),
      zu(
        'Schlüsselanzahl n × (n - 1) / 2',
        0,
        'Jedes Paar braucht einen eigenen gemeinsamen Schlüssel.',
      ),
      zu(
        'Schlüsselanzahl 2 × n',
        1,
        'Jede Person hat genau ein Paar aus zwei Schlüsseln.',
      ),
    ],
    explanation:
        'Symmetrisch: AES, 3DES, ein gemeinsamer Schlüssel je Paar, n × (n - 1) / 2. Asymmetrisch: RSA, ECC, ein Schlüsselpaar je Person, 2 × n.',
  ),

  // ============================================= Hybride Verfahren und Zertifikate
  einfach(
    'a6-ch-1',
    'kr-hybrid',
    prompt:
        'Warum verschlüsselt TLS die Nutzdaten symmetrisch und nicht asymmetrisch?',
    choices: [
      ja(
        'Symmetrische Verfahren sind viel schneller - asymmetrische dienen nur Schlüsselaustausch und Echtheitsnachweis.',
        'So verbindet das Hybridverfahren das Tempo der symmetrischen mit den Vorteilen der asymmetrischen Verfahren.',
      ),
      nein(
        'Asymmetrische Verfahren gelten als unsicher.',
        'RSA und ECC sind sicher, aber zu langsam für große Datenmengen.',
      ),
      nein(
        'Symmetrische Verfahren brauchen keinen Schlüssel.',
        'Sie brauchen einen gemeinsamen Schlüssel - den Sitzungsschlüssel.',
      ),
      nein(
        'Browser können keine asymmetrischen Verfahren ausführen.',
        'Browser nutzen sie im Handshake ständig, etwa beim Prüfen von Signaturen.',
      ),
    ],
    explanation:
        'Hybrid heißt: Asymmetrisch werden Server authentifiziert und Schlüssel vereinbart, die eigentlichen Daten laufen schnell symmetrisch verschlüsselt.',
  ),
  reihenfolge(
    'a6-ch-2',
    'kr-hybrid',
    prompt:
        'Bringe die Schritte beim Aufbau einer HTTPS-Verbindung (vereinfacht) in die richtige Reihenfolge.',
    items: [
      'Browser sendet Client Hello',
      'Server antwortet mit Server Hello',
      'Server sendet sein Zertifikat',
      'Browser prüft das Zertifikat',
      'Nutzdaten werden symmetrisch verschlüsselt übertragen',
    ],
    explanation:
        'Erst verständigen sich beide über die Verfahren, dann weist sich der Server mit seinem Zertifikat aus. Erst nach erfolgreicher Prüfung fließen die Nutzdaten verschlüsselt.',
  ),
  mehrfach(
    'a6-ch-3',
    'kr-hybrid',
    prompt: 'Welche Angaben enthält ein X.509-Serverzertifikat?',
    choices: [
      ja(
        'Den öffentlichen Schlüssel des Servers',
        'Genau diesen Schlüssel bestätigt das Zertifikat.',
      ),
      ja(
        'Den Aussteller (die CA)',
        'Über ihn wird die Vertrauenskette geprüft.',
      ),
      ja('Den Gültigkeitszeitraum', 'Außerhalb davon warnt der Browser.'),
      nein(
        'Den privaten Schlüssel des Servers',
        'Der private Schlüssel bleibt geheim auf dem Server und steht nie im Zertifikat.',
      ),
      nein(
        'Das Administratorpasswort des Servers',
        'Passwörter haben in einem öffentlichen Zertifikat nichts zu suchen.',
      ),
    ],
    explanation:
        'Ein Zertifikat enthält u. a. Inhaber, öffentlichen Schlüssel, Aussteller, Gültigkeit, Seriennummer und die Signatur der CA - nie den privaten Schlüssel.',
  ),
  einfach(
    'a6-ch-4',
    'kr-hybrid',
    scenario:
        'Ein Azubi ruft https://intranet.firma.example auf. Der Browser warnt. Das Zertifikat ist noch ein Jahr gültig, von einer bekannten CA signiert, nicht gesperrt und auf den Namen www.firma.example ausgestellt.',
    prompt: 'Welche Prüfung schlägt fehl?',
    choices: [
      ja(
        'Der Name im Zertifikat passt nicht zur aufgerufenen Adresse.',
        'Das Zertifikat gilt für www.firma.example, nicht für intranet.firma.example.',
      ),
      nein(
        'Der Gültigkeitszeitraum ist überschritten.',
        'Laut Aufgabe ist das Zertifikat noch ein Jahr gültig.',
      ),
      nein(
        'Der Aussteller ist nicht vertrauenswürdig.',
        'Es wurde von einer bekannten CA signiert.',
      ),
      nein(
        'Das Zertifikat wurde widerrufen.',
        'Laut Aufgabe ist es nicht gesperrt.',
      ),
    ],
    explanation:
        'Der Browser prüft Gültigkeit, Aussteller, Sperrstatus und Namen. Hier stimmt nur der Name nicht mit der Adresse überein.',
  ),
  einfach(
    'a6-ch-5',
    'kr-hybrid',
    scenario:
        'Alice schickt Bob eine mit S/MIME verschlüsselte Mail. Die Mail selbst ist mit AES und einem zufälligen Sitzungsschlüssel verschlüsselt. Der Sitzungsschlüssel wird mitgeschickt.',
    prompt: 'Womit ist der mitgeschickte Sitzungsschlüssel verschlüsselt?',
    choices: [
      ja(
        'Mit Bobs öffentlichem Schlüssel',
        'So kann nur Bob ihn mit seinem privaten Schlüssel auspacken und danach die Mail entschlüsseln.',
      ),
      nein(
        'Mit Alices privatem Schlüssel',
        'Dann könnte ihn jeder mit Alices öffentlichem Schlüssel lesen.',
      ),
      nein(
        'Mit sich selbst',
        'Ein Schlüssel, der nur mit sich selbst zu öffnen ist, wäre für Bob nicht zugänglich.',
      ),
      nein(
        'Gar nicht, er wird im Klartext mitgeschickt',
        'Dann könnte jeder Mitleser die Mail entschlüsseln.',
      ),
    ],
    explanation:
        'Bei hybrider Verschlüsselung wird der schnelle symmetrische Sitzungsschlüssel asymmetrisch mit dem öffentlichen Schlüssel des Empfängers geschützt. Bob entschlüsselt erst den Sitzungsschlüssel, dann die Mail.',
  ),
  zuordnen(
    'a6-ch-6',
    'kr-hybrid',
    prompt: 'Welcher Baustein einer PKI wird beschrieben?',
    buckets: [
      'Zertifizierungsstelle (CA)',
      'Registrierungsstelle (RA)',
      'Sperrliste / OCSP',
      'Root-Zertifikat',
    ],
    items: [
      zu(
        'Signiert Zertifikate und bestätigt damit die Zuordnung von Schlüssel und Name',
        0,
        'Das Ausstellen und Signieren ist die Kernaufgabe der CA.',
      ),
      zu(
        'Prüft vor der Ausstellung den Ausweis bzw. die Firmendaten des Antragstellers',
        1,
        'Die Identitätsprüfung übernimmt die Registrierungsstelle.',
      ),
      zu(
        'Zeigt an, dass ein Zertifikat nach Diebstahl des privaten Schlüssels widerrufen wurde',
        2,
        'Widerrufene Zertifikate stehen in der Sperrliste bzw. werden per OCSP abgefragt.',
      ),
      zu(
        'Ist im Browser hinterlegt und bildet den Anker der Vertrauenskette',
        3,
        'Browser vertrauen einer festen Liste von Root-Zertifikaten.',
      ),
    ],
    explanation:
        'Die RA prüft die Identität, die CA stellt aus und signiert, Sperrlisten bzw. OCSP melden widerrufene Zertifikate, und Root-Zertifikate im Browser sind der Vertrauensanker.',
  ),
  einfach(
    'a6-ch-7',
    'kr-hybrid',
    scenario:
        'Eine Firma verschickt E-Mails über SMTP mit STARTTLS. Alle Verbindungen zwischen Mailprogramm und Mailservern sind TLS-verschlüsselt. Eine Ende-zu-Ende-Verschlüsselung wird nicht genutzt.',
    prompt: 'Welche Aussage trifft zu?',
    choices: [
      ja(
        'Auf den beteiligten Mailservern liegt die Mail im Klartext vor.',
        'TLS schützt nur die Transportstrecken, auf den Servern wird wieder entschlüsselt.',
      ),
      nein(
        'Niemand außer dem Empfänger kann die Mail jemals lesen.',
        'Das leistet erst eine Ende-zu-Ende-Verschlüsselung wie S/MIME oder PGP.',
      ),
      nein(
        'STARTTLS ist dasselbe wie eine digitale Signatur.',
        'STARTTLS verschlüsselt die Verbindung, es signiert nicht die Mail.',
      ),
      nein(
        'Die Mail ist gar nicht verschlüsselt.',
        'Auf den Übertragungsstrecken ist sie verschlüsselt.',
      ),
    ],
    explanation:
        'Transportverschlüsselung schützt jede Teilstrecke einzeln. Ende-zu-Ende-Verschlüsselung (S/MIME, PGP) schützt vom Absender bis zum Empfänger, sodass auch die Server nur Geheimtext sehen.',
  ),
  reihenfolge(
    'a6-ch-8',
    'kr-hybrid',
    prompt:
        'Bringe die Schritte zu einem neuen Serverzertifikat in die richtige Reihenfolge.',
    items: [
      'Schlüsselpaar auf dem Server erzeugen',
      'Zertifikatsantrag (CSR) erstellen',
      'CSR an die Zertifizierungsstelle senden',
      'CA prüft die Kontrolle über die Domain',
      'CA signiert und liefert das Zertifikat',
      'Zertifikat auf dem Server einbinden',
    ],
    explanation:
        'Der private Schlüssel entsteht auf dem Server und verlässt ihn nie. Der CSR enthält nur den öffentlichen Schlüssel und den Namen. Nach der Prüfung signiert die CA, dann wird das Zertifikat samt Zwischenzertifikat eingebunden.',
  ),

  // ====================================================== Hashverfahren
  rechnen(
    'a6-cx-1',
    'kr-hash',
    prompt:
        'Ein SHA-512-Hashwert wird hexadezimal dargestellt. Aus wie vielen Zeichen besteht er?',
    answer: 128,
    unit: 'Zeichen',
    explanation:
        'Ein Hex-Zeichen stellt 4 Bit dar. 512 Bit / 4 Bit je Zeichen = 128 Zeichen.',
  ),
  mehrfach(
    'a6-cx-2',
    'kr-hash',
    prompt: 'Welche Eigenschaften hat eine kryptographische Hashfunktion?',
    choices: [
      ja(
        'Der Hashwert hat immer dieselbe Länge.',
        'Egal ob die Eingabe 1 Byte oder 10 GB groß ist.',
      ),
      ja(
        'Aus dem Hashwert lässt sich die Eingabe nicht berechnen.',
        'Sie ist eine Einwegfunktion.',
      ),
      ja(
        'Eine winzige Änderung der Eingabe ergibt einen völlig anderen Hashwert.',
        'Das ist der Lawineneffekt.',
      ),
      nein(
        'Mit dem richtigen Schlüssel lässt sich der Hashwert zurückrechnen.',
        'Hashfunktionen haben keinen Schlüssel und sind nicht umkehrbar.',
      ),
      nein(
        'Je größer die Datei, desto länger der Hashwert.',
        'Die Länge ist fest, z. B. 256 Bit bei SHA-256.',
      ),
    ],
    explanation:
        'Kryptographische Hashfunktionen sind Einwegfunktionen mit fester Ausgabelänge, Lawineneffekt und Kollisionsresistenz.',
  ),
  einfach(
    'a6-cx-3',
    'kr-hash',
    scenario:
        'Für einen neuen Kundenbereich im Webshop soll festgelegt werden, wie Passwörter in der Datenbank gespeichert werden.',
    prompt: 'Welche Lösung ist richtig?',
    choices: [
      ja(
        'Mit Argon2 und einem zufälligen Salt je Konto hashen',
        'Salt verhindert vorberechnete Tabellen, das langsame Verfahren bremst massenhaftes Ausprobieren.',
      ),
      nein(
        'Mit AES verschlüsseln',
        'Verschlüsseltes lässt sich mit dem Schlüssel zurückholen - wird er gestohlen, liegen alle Passwörter offen.',
      ),
      nein(
        'Mit MD5 hashen',
        'MD5 ist veraltet und extrem schnell zu berechnen.',
      ),
      nein(
        'Mit SHA-256 ohne Salt hashen',
        'Gleiche Passwörter ergeben gleiche Hashes, und SHA-256 ist für Passwörter zu schnell.',
      ),
    ],
    explanation:
        'Passwörter werden nicht verschlüsselt, sondern mit Salt und einem bewusst langsamen Verfahren wie Argon2 oder bcrypt gehasht.',
  ),
  einfach(
    'a6-cx-4',
    'kr-hash',
    scenario:
        'Eine Administratorin lädt ein Installationspaket herunter. Der SHA-256-Wert, den sie selbst berechnet, weicht vom Wert auf der Herstellerseite ab.',
    prompt: 'Was bedeutet das?',
    choices: [
      ja(
        'Die Datei wurde verändert oder beschädigt und darf nicht installiert werden.',
        'Schon ein einziges abweichendes Bit ergibt einen völlig anderen Hashwert.',
      ),
      nein(
        'Hashwerte weichen immer leicht ab, das ist normal.',
        'Gleiche Daten ergeben immer exakt denselben Hashwert.',
      ),
      nein(
        'Die Datei ist verschlüsselt und muss erst entschlüsselt werden.',
        'Ein Hashwert sagt nichts über Verschlüsselung aus.',
      ),
      nein(
        'Die Datei ist in Ordnung, nur größer als erwartet.',
        'Die Größe beeinflusst die Länge des Hashwerts nicht - abweichende Werte heißen abweichende Daten.',
      ),
    ],
    explanation:
        'Hashwerte prüfen die Integrität: Stimmen sie nicht überein, sind die Daten nicht dieselben wie beim Hersteller.',
  ),
  rechnen(
    'a6-cx-5',
    'kr-hash',
    prompt:
        'Ein SHA-1-Hashwert wird hexadezimal dargestellt. Aus wie vielen Zeichen besteht er?',
    answer: 40,
    unit: 'Zeichen',
    difficulty: 1,
    explanation:
        'SHA-1 liefert 160 Bit. Ein Hex-Zeichen stellt 4 Bit dar: 160 Bit / 4 Bit je Zeichen = 40 Zeichen.',
  ),
  zuordnen(
    'a6-cx-6',
    'kr-hash',
    prompt: 'Handelt es sich um Hashen, Verschlüsseln oder Kodieren?',
    buckets: ['Hashen', 'Verschlüsseln', 'Kodieren'],
    items: [
      zu('SHA-256', 0, 'Einwegfunktion mit fester Länge.'),
      zu('bcrypt', 0, 'Bewusst langsames Hashverfahren für Passwörter.'),
      zu('AES', 1, 'Mit dem Schlüssel wieder umkehrbar.'),
      zu('RSA', 1, 'Asymmetrische Verschlüsselung mit Schlüsselpaar.'),
      zu(
        'Base64',
        2,
        'Umwandlung ohne Schlüssel, jeder kann sie rückgängig machen.',
      ),
      zu(
        'URL-Kodierung, z. B. %20 für ein Leerzeichen',
        2,
        'Reine Darstellungsform für den Transport, kein Schutz.',
      ),
    ],
    explanation:
        'Hashen ist nicht umkehrbar, Verschlüsseln ist mit Schlüssel umkehrbar, Kodieren ist ohne Schlüssel umkehrbar und schützt nichts.',
  ),
  mehrfach(
    'a6-cx-7',
    'kr-hash',
    prompt:
        'Welche Aussagen zum Salt beim Speichern von Passwörtern sind richtig?',
    choices: [
      ja(
        'Es wird für jedes Konto zufällig erzeugt.',
        'Nur so ergeben gleiche Passwörter verschiedene Hashwerte.',
      ),
      ja(
        'Es darf im Klartext neben dem Hashwert gespeichert werden.',
        'Das Salt muss nicht geheim sein, es wird beim Login wieder gebraucht.',
      ),
      ja(
        'Es macht vorberechnete Tabellen (Rainbow Tables) nutzlos.',
        'Die Tabellen müssten für jedes Salt neu berechnet werden.',
      ),
      nein(
        'Es muss wie ein Schlüssel geheim gehalten werden.',
        'Das Salt ist kein Geheimnis, seine Wirkung entsteht durch die Einzigartigkeit.',
      ),
      nein(
        'Es macht den Hashwert umkehrbar.',
        'Auch mit Salt bleibt der Hash eine Einwegfunktion.',
      ),
    ],
    explanation:
        'Ein Salt ist ein zufälliger, nicht geheimer Wert je Konto. Er verhindert, dass gleiche Passwörter gleiche Hashes ergeben, und entwertet vorberechnete Tabellen.',
  ),
  einfach(
    'a6-cx-8',
    'kr-hash',
    scenario:
        'Ein Hersteller zeigt auf seiner Downloadseite neben der Datei auch deren SHA-256-Wert an. Ein Angreifer hat die Webseite übernommen.',
    prompt: 'Warum schützt der angezeigte Hashwert in diesem Fall nicht?',
    choices: [
      ja(
        'Der Angreifer kann Datei und angezeigten Hashwert gemeinsam austauschen.',
        'Der Vergleich passt dann wieder - der Hash belegt die Integrität, aber nicht die Herkunft.',
      ),
      nein(
        'SHA-256 ist veraltet und unsicher.',
        'SHA-256 gilt als sicher, das Problem liegt woanders.',
      ),
      nein(
        'Hashwerte lassen sich nur mit dem Schlüssel des Herstellers prüfen.',
        'Hashfunktionen haben keinen Schlüssel - jeder kann sie berechnen.',
      ),
      nein(
        'Der Hashwert ändert sich bei jedem Download.',
        'Gleiche Daten ergeben immer denselben Hashwert.',
      ),
    ],
    explanation:
        'Ein Hashwert beweist nur, dass zwei Daten gleich sind. Um die Herkunft zu belegen, braucht es eine digitale Signatur des Herstellers - die kann der Angreifer ohne dessen privaten Schlüssel nicht fälschen.',
  ),

  // =========================================== Authentifizierung und 2FA
  mehrfach(
    'a6-cz-1',
    'kr-auth',
    prompt:
        'Welche Kombinationen sind eine echte Zwei-Faktor-Authentifizierung?',
    choices: [
      ja(
        'Passwort und Code aus einer Authenticator-App',
        'Wissen und Besitz (Smartphone).',
      ),
      ja('Chipkarte und PIN', 'Besitz und Wissen.'),
      ja('Fingerabdruck und Passwort', 'Inhärenz und Wissen.'),
      nein(
        'Passwort und Sicherheitsfrage',
        'Beides ist Wissen - nur eine Kategorie.',
      ),
      nein('PIN und Passwort', 'Beides ist Wissen - nur eine Kategorie.'),
    ],
    explanation:
        '2FA verlangt zwei Faktoren aus verschiedenen Kategorien: Wissen, Besitz oder Inhärenz. Zweimal Wissen zählt nicht.',
  ),
  zuordnen(
    'a6-cz-2',
    'kr-auth',
    prompt: 'Ordne jeden Nachweis seiner Faktorkategorie zu.',
    buckets: ['Wissen', 'Besitz', 'Inhärenz'],
    items: [
      zu('PIN', 0, 'Eine PIN muss man sich merken - Wissen.'),
      zu(
        'Passphrase',
        0,
        'Auch eine lange Passphrase ist etwas, das man weiß.',
      ),
      zu(
        'Hardware-Sicherheitsschlüssel',
        1,
        'Ein Gegenstand, den man bei sich trägt - Besitz.',
      ),
      zu('Smartcard', 1, 'Die Karte muss man physisch besitzen.'),
      zu('Gesichtserkennung', 2, 'Ein körperliches Merkmal - Inhärenz.'),
      zu('Iris-Scan', 2, 'Die Iris ist ein biometrisches Merkmal der Person.'),
    ],
    explanation:
        'Wissen ist etwas, das man weiß, Besitz etwas, das man hat, Inhärenz ein körperliches Merkmal.',
  ),
  rechnen(
    'a6-cz-3',
    'kr-auth',
    prompt:
        'Ein Passwort besteht aus genau 4 Zeichen. Erlaubt sind die 26 Kleinbuchstaben und die 10 Ziffern. Wie viele verschiedene Passwörter sind möglich?',
    answer: 1679616,
    unit: 'Kombinationen',
    explanation:
        'Zeichenvorrat: 26 + 10 = 36. Kombinationen = 36^4 = 36 × 36 × 36 × 36 = 1.296 × 1.296 = 1.679.616.',
  ),
  einfach(
    'a6-cz-4',
    'kr-auth',
    prompt: 'Welche Regel entspricht den aktuellen Empfehlungen des BSI?',
    choices: [
      ja(
        'Lieber eine lange Passphrase und das Passwort nur bei Verdacht auf Kompromittierung ändern',
        'Das BSI empfiehlt keinen anlasslosen Zwangswechsel mehr, Länge bringt viel Sicherheit.',
      ),
      nein(
        'Passwörter alle 90 Tage zwangsweise wechseln',
        'Anlassloser Wechsel führt zu schwachen, abgewandelten Passwörtern und wird nicht mehr empfohlen.',
      ),
      nein(
        'Ein einziges starkes Passwort für alle Dienste nutzen',
        'Wird ein Dienst gehackt, sind alle anderen Konten mitbetroffen.',
      ),
      nein(
        'Acht Zeichen reichen immer, wenn ein Sonderzeichen dabei ist',
        'Kurze Passwörter bleiben auch mit Sonderzeichen angreifbar - Länge wirkt stärker.',
      ),
    ],
    explanation:
        'Heute gilt: lang vor kompliziert, für jeden Dienst ein eigenes Passwort (Passwortmanager), Wechsel nur bei Anlass, zusätzlich MFA.',
  ),
  rechnen(
    'a6-cz-5',
    'kr-auth',
    scenario:
        'Ein Passwort besteht aus 6 Kleinbuchstaben (26 mögliche Zeichen je Stelle). Ein Angreifer kann offline 100 Millionen (10^8) Passwörter pro Sekunde durchprobieren.',
    prompt:
        'Wie viele Sekunden braucht er höchstens, um alle Möglichkeiten zu testen? (auf zwei Nachkommastellen)',
    answer: 3.09,
    tolerance: 0.01,
    unit: 's',
    difficulty: 3,
    explanation:
        'Kombinationen: 26^6 = 308.915.776. Zeit: 308.915.776 / 100.000.000 pro s = 3,09 s. Ein kurzes Passwort aus Kleinbuchstaben ist also in wenigen Sekunden geknackt.',
  ),
  einfach(
    'a6-cz-6',
    'kr-auth',
    prompt:
        'Welchen Vorteil hat ein Challenge-Response-Verfahren gegenüber dem Übertragen eines Passworts?',
    choices: [
      ja(
        'Das Geheimnis wird nie übertragen, und eine mitgeschnittene Antwort ist beim nächsten Mal wertlos.',
        'Der Server schickt jedes Mal eine neue Zufallszahl, die Antwort passt nur zu ihr.',
      ),
      nein(
        'Es kommt ganz ohne Geheimnis aus.',
        'Beide Seiten brauchen ein gemeinsames Geheimnis oder ein Schlüsselpaar.',
      ),
      nein(
        'Der Nutzer muss sich keinen Benutzernamen mehr merken.',
        'Die Identifikation bleibt nötig.',
      ),
      nein(
        'Die Antwort ist immer dieselbe und kann gespeichert werden.',
        'Gerade weil sie sich ändert, schützt das Verfahren vor Wiedereinspielen.',
      ),
    ],
    explanation:
        'Beim Challenge-Response-Verfahren berechnet der Client aus einer Zufallszahl und seinem Geheimnis eine Antwort. Das Geheimnis verlässt das Gerät nie, und Replay-Angriffe laufen ins Leere.',
  ),
  zuordnen(
    'a6-cz-7',
    'kr-auth',
    scenario:
        'Eine Mitarbeiterin meldet sich morgens am Ticketsystem an und bearbeitet Anfragen.',
    prompt: 'Welcher Schritt wird beschrieben?',
    buckets: ['Identifikation', 'Authentifizierung', 'Autorisierung'],
    items: [
      zu(
        'Sie gibt ihren Benutzernamen ein.',
        0,
        'Damit behauptet sie, wer sie ist.',
      ),
      zu(
        'Sie gibt ihr Passwort ein.',
        1,
        'Das Passwort beweist die behauptete Identität.',
      ),
      zu(
        'Sie bestätigt die Anmeldung per Fingerabdruck am Smartphone.',
        1,
        'Ein weiterer Nachweis der Identität - zweiter Faktor.',
      ),
      zu(
        'Nur Teamleitungen dürfen Tickets endgültig schließen.',
        2,
        'Das regelt, was eine angemeldete Person darf.',
      ),
    ],
    explanation:
        'Identifikation: Wer bist du? Authentifizierung: Beweise es. Autorisierung: Was darfst du? Die Autorisierung folgt erst nach erfolgreicher Authentifizierung.',
  ),
  einfach(
    'a6-cz-8',
    'kr-auth',
    prompt: 'Welcher zweite Faktor schützt am besten vor Phishing?',
    choices: [
      ja(
        'FIDO2-Sicherheitsschlüssel bzw. Passkey',
        'Die Antwort ist an die echte Domain gebunden - eine Phishing-Seite erhält keine gültige Anmeldung.',
      ),
      nein(
        'SMS-Code',
        'Ein SMS-Code kann auf einer Phishing-Seite abgefragt und sofort weiterverwendet werden.',
      ),
      nein(
        'Code aus einer TOTP-App',
        'Auch dieser Code kann auf einer gefälschten Seite eingegeben und weitergereicht werden.',
      ),
      nein(
        'Sicherheitsfrage nach dem Namen des ersten Haustiers',
        'Das ist Wissen wie das Passwort und damit gar kein zweiter Faktor anderer Art.',
      ),
    ],
    explanation:
        'FIDO2 und Passkeys signieren eine Challenge mit einem Schlüssel, der an die Domain gebunden ist. Codes zum Abtippen können Angreifer dagegen in Echtzeit abfangen.',
  ),

  // =========================================== Personenbezogene Daten
  mehrfach(
    'a6-xg-1',
    'ds-grundlagen',
    prompt: 'Welche Daten sind personenbezogen im Sinne der DSGVO?',
    choices: [
      ja(
        'Die E-Mail-Adresse max.mueller@firma.example',
        'Sie ist einer bestimmten Person zugeordnet.',
      ),
      ja(
        'Die IP-Adresse eines Website-Besuchers',
        'Mit Zusatzwissen, etwa vom Provider, lässt sie sich einem Anschluss und einer Person zuordnen.',
      ),
      ja(
        'Das Kfz-Kennzeichen eines Dienstwagens, den eine Mitarbeiterin fährt',
        'Über das Kennzeichen und den Fahrtenplan ist die Person identifizierbar.',
      ),
      nein(
        'Der Jahresumsatz einer GmbH',
        'Er betrifft eine juristische Person, keine natürliche.',
      ),
      nein(
        'Die Durchschnittstemperatur im Serverraum',
        'Sie hat keinen Bezug zu einer Person.',
      ),
    ],
    explanation:
        'Personenbezogen ist jede Information über eine identifizierte oder identifizierbare natürliche Person - auch über Kennungen wie IP-Adresse oder Kennzeichen.',
  ),
  zuordnen(
    'a6-xg-2',
    'ds-grundlagen',
    prompt: 'Ordne die Daten richtig ein.',
    buckets: [
      'besondere Kategorie (Art. 9)',
      'personenbezogen, nicht besonders',
      'nicht personenbezogen',
    ],
    items: [
      zu(
        'Krankschreibung eines Mitarbeiters',
        0,
        'Gesundheitsdaten gehören zu Art. 9.',
      ),
      zu(
        'Gewerkschaftsmitgliedschaft einer Kollegin',
        0,
        'Die Gewerkschaftszugehörigkeit ist ausdrücklich in Art. 9 genannt.',
      ),
      zu(
        'Privatadresse einer Kundin',
        1,
        'Sie ist einer Person zugeordnet, aber keine besondere Kategorie.',
      ),
      zu(
        'Handynummer eines Kunden',
        1,
        'Über die Nummer ist die Person identifizierbar.',
      ),
      zu(
        'Handelsregisternummer einer GmbH',
        2,
        'Sie betrifft eine juristische Person, keinen Menschen.',
      ),
      zu(
        'Gesamtzahl aller Website-Aufrufe pro Tag',
        2,
        'Eine reine Summe lässt sich keiner Person zuordnen.',
      ),
    ],
    explanation:
        'Gesundheit und Gewerkschaft gehören zu Art. 9. Adresse und Telefonnummer sind personenbezogen, Firmendaten und reine Summen nicht.',
  ),
  einfach(
    'a6-xg-3',
    'ds-grundlagen',
    scenario:
        'Eine Arztpraxis lässt ihre Patientenverwaltung von einem externen Rechenzentrum betreiben. Das Rechenzentrum nutzt die Daten nur nach Vorgabe der Praxis.',
    prompt: 'Welche Rolle hat das Rechenzentrum nach der DSGVO?',
    choices: [
      ja(
        'Auftragsverarbeiter',
        'Es verarbeitet Daten im Auftrag und nach Weisung der Praxis.',
      ),
      nein(
        'Verantwortlicher',
        'Über Zweck und Mittel entscheidet die Praxis, nicht das Rechenzentrum.',
      ),
      nein(
        'Betroffene Person',
        'Betroffen sind die Patientinnen und Patienten.',
      ),
      nein('Aufsichtsbehörde', 'Das ist die staatliche Datenschutzbehörde.'),
    ],
    explanation:
        'Wer im Auftrag und nach Weisung verarbeitet, ist Auftragsverarbeiter. Dafür ist ein Vertrag zur Auftragsverarbeitung nötig.',
  ),
  einfach(
    'a6-xg-4',
    'ds-grundlagen',
    prompt: 'Wessen Daten schützt die DSGVO?',
    choices: [
      ja(
        'Die Daten natürlicher Personen',
        'Sie bezieht sich auf Informationen über identifizierte oder identifizierbare Menschen.',
      ),
      nein(
        'Die Daten juristischer Personen wie GmbHs',
        'Firmendaten fallen nicht unter die DSGVO.',
      ),
      nein(
        'Nur die Daten von Kunden',
        'Auch Beschäftigte, Bewerber und Lieferantenkontakte sind geschützt.',
      ),
      nein(
        'Nur Daten, die auf Papier vorliegen',
        'Die DSGVO gilt gerade auch für elektronische Verarbeitung.',
      ),
    ],
    explanation:
        'Die DSGVO schützt natürliche Personen - unabhängig davon, ob sie Kunden, Beschäftigte oder Bewerbende sind.',
  ),
  einfach(
    'a6-xg-5',
    'ds-grundlagen',
    scenario:
        'Ein Softwarehaus hat 45 Beschäftigte. 22 davon arbeiten in Entwicklung, Support und Vertrieb täglich am PC mit Kundendaten. 23 arbeiten in der Hardware-Montage ohne Zugriff auf personenbezogene Daten. Besondere Risiken bestehen nicht.',
    prompt: 'Muss das Unternehmen einen Datenschutzbeauftragten benennen?',
    choices: [
      ja(
        'Ja, weil mindestens 20 Personen ständig mit der automatisierten Verarbeitung personenbezogener Daten beschäftigt sind',
        '22 ≥ 20 - die Schwelle aus § 38 BDSG ist erreicht.',
      ),
      nein(
        'Nein, weil weniger als die Hälfte der Beschäftigten mit Daten arbeitet',
        'Es kommt nicht auf den Anteil an, sondern auf die absolute Zahl von mindestens 20.',
      ),
      nein(
        'Ja, weil das Unternehmen mehr als 20 Beschäftigte hat',
        'Die Begründung stimmt nicht: Maßgeblich sind nur die Personen, die ständig personenbezogene Daten verarbeiten.',
      ),
      nein(
        'Nein, Softwarehäuser sind grundsätzlich ausgenommen',
        'Eine solche Ausnahme gibt es nicht.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Nach § 38 BDSG ist ein DSB zu benennen, wenn in der Regel mindestens 20 Personen ständig mit der automatisierten Verarbeitung personenbezogener Daten beschäftigt sind. Gezählt werden nur diese Personen: hier 22.',
  ),
  zuordnen(
    'a6-xg-6',
    'ds-grundlagen',
    prompt: 'Gehört die Frage zum Datenschutz oder zur Informationssicherheit?',
    buckets: ['Datenschutz', 'Informationssicherheit'],
    items: [
      zu(
        'Darf der Webshop das Geburtsdatum der Kunden speichern?',
        0,
        'Ob personenbezogene Daten verarbeitet werden dürfen, ist eine Datenschutzfrage.',
      ),
      zu(
        'Ist der Quellcode der Firmensoftware vor Diebstahl geschützt?',
        1,
        'Quellcode ist ein Betriebsgeheimnis, keine personenbezogene Information.',
      ),
      zu(
        'Muss eine Bewerberin über die Speicherdauer ihrer Unterlagen informiert werden?',
        0,
        'Informationspflichten gegenüber Betroffenen regelt die DSGVO.',
      ),
      zu(
        'Läuft der Server bei einem Stromausfall weiter?',
        1,
        'Die Verfügbarkeit von Systemen ist eine Frage der Informationssicherheit.',
      ),
    ],
    explanation:
        'Datenschutz schützt Menschen und fragt, ob und wie personenbezogene Daten verarbeitet werden dürfen. Informationssicherheit schützt alle Informationen und Systeme vor Verlust, Ausfall und unbefugtem Zugriff.',
  ),
  einfach(
    'a6-xg-7',
    'ds-grundlagen',
    scenario:
        'Eine Firma lässt die monatliche Lohnabrechnung von einem externen Dienstleister erstellen. Dieser erhält dafür die Personaldaten und arbeitet nur nach Vorgaben der Firma.',
    prompt: 'Was muss die Firma vor der Übergabe der Daten abschließen?',
    choices: [
      ja(
        'Einen Vertrag zur Auftragsverarbeitung nach Art. 28 DSGVO',
        'Der Dienstleister verarbeitet im Auftrag und nach Weisung - dafür ist ein AV-Vertrag vorgeschrieben.',
      ),
      nein(
        'Eine Einwilligung jedes Beschäftigten',
        'Die Lohnabrechnung beruht auf dem Arbeitsvertrag und gesetzlichen Pflichten, nicht auf Einwilligung.',
      ),
      nein(
        'Eine Datenschutz-Folgenabschätzung für jeden Monat',
        'Eine DSFA ist nur bei voraussichtlich hohem Risiko und nicht monatlich nötig.',
      ),
      nein(
        'Nichts, weil der Dienstleister selbst Verantwortlicher wird',
        'Über Zweck und Mittel entscheidet weiter die Firma - sie bleibt verantwortlich.',
      ),
    ],
    explanation:
        'Wer Daten im Auftrag verarbeiten lässt, bleibt Verantwortlicher und muss mit dem Auftragsverarbeiter einen AV-Vertrag schließen: Weisungsbindung, TOM, Unterauftragnehmer, Löschung am Ende.',
  ),
  mehrfach(
    'a6-xg-8',
    'ds-grundlagen',
    prompt:
        'Welche Daten gehören zu den besonderen Kategorien nach Art. 9 DSGVO?',
    choices: [
      ja(
        'Religionszugehörigkeit einer Mitarbeiterin',
        'Religiöse Überzeugungen sind ausdrücklich genannt.',
      ),
      ja(
        'Fingerabdruck, mit dem sich Beschäftigte an der Zeiterfassung eindeutig identifizieren',
        'Biometrische Daten zur eindeutigen Identifizierung gehören zu Art. 9.',
      ),
      ja('Diagnose auf einem Arztbrief', 'Gesundheitsdaten gehören zu Art. 9.'),
      nein(
        'IBAN eines Kunden',
        'Bankdaten sind personenbezogen und schutzwürdig, aber keine besondere Kategorie.',
      ),
      nein(
        'Gehalt eines Mitarbeiters',
        'Das Gehalt ist vertraulich, zählt aber nicht zu Art. 9.',
      ),
    ],
    explanation:
        'Art. 9 nennt u. a. Gesundheit, Herkunft, Religion und Weltanschauung, politische Meinung, Gewerkschaft, genetische Daten, Biometrie zur Identifizierung und Sexualleben. Finanzdaten gehören nicht dazu.',
  ),

  // ========================================= Grundsätze der Verarbeitung
  zuordnen(
    'a6-xs-1',
    'ds-grundsaetze',
    prompt: 'Gegen welchen Grundsatz verstößt jeder Fall am deutlichsten?',
    buckets: [
      'Zweckbindung',
      'Datenminimierung',
      'Speicherbegrenzung',
      'Richtigkeit',
    ],
    items: [
      zu(
        'Für den Versand erhobene Adressen werden an einen Werbepartner verkauft.',
        0,
        'Die Daten werden für einen anderen als den ursprünglichen Zweck genutzt.',
      ),
      zu(
        'Ein Newsletter-Formular verlangt Geburtsdatum und Telefonnummer als Pflichtfelder.',
        1,
        'Für den Newsletter genügt die E-Mail-Adresse - alles andere ist zu viel.',
      ),
      zu(
        'Unterlagen abgelehnter Bewerbender liegen seit fünf Jahren im Ordner.',
        2,
        'Der Zweck ist längst entfallen, die Daten hätten gelöscht werden müssen.',
      ),
      zu(
        'Ein Kunde meldet seinen Umzug, im System bleibt die alte Adresse stehen.',
        3,
        'Bekannte falsche Daten müssen berichtigt werden.',
      ),
    ],
    explanation:
        'Zweckfremde Nutzung verletzt die Zweckbindung, unnötige Pflichtfelder die Datenminimierung, zu langes Aufbewahren die Speicherbegrenzung, veraltete Daten die Richtigkeit.',
  ),
  einfach(
    'a6-xs-2',
    'ds-grundsaetze',
    scenario:
        'Ein Webshop speichert die Lieferadresse, um eine Bestellung auszuliefern.',
    prompt: 'Auf welche Rechtsgrundlage stützt sich diese Verarbeitung?',
    choices: [
      ja(
        'Erfüllung eines Vertrags',
        'Ohne Adresse kann die Bestellung nicht geliefert werden.',
      ),
      nein(
        'Einwilligung',
        'Eine Einwilligung ist nicht nötig, wenn die Daten zur Vertragserfüllung erforderlich sind.',
      ),
      nein(
        'Lebenswichtige Interessen',
        'Die gelten nur, wenn es um Leben oder Gesundheit geht.',
      ),
      nein(
        'Öffentliche Aufgabe',
        'Ein Webshop nimmt keine hoheitliche Aufgabe wahr.',
      ),
    ],
    explanation:
        'Daten, die zur Erfüllung eines Vertrags nötig sind, dürfen nach Art. 6 Abs. 1 lit. b DSGVO ohne Einwilligung verarbeitet werden.',
  ),
  mehrfach(
    'a6-xs-3',
    'ds-grundsaetze',
    prompt: 'Welche Aussagen zur Einwilligung sind richtig?',
    choices: [
      ja(
        'Sie muss freiwillig erteilt werden.',
        'Wer keine echte Wahl hat, willigt nicht wirksam ein.',
      ),
      ja(
        'Sie kann jederzeit widerrufen werden.',
        'Der Widerruf muss so einfach sein wie die Erteilung.',
      ),
      ja(
        'Die Person muss wissen, worin sie einwilligt.',
        'Eine Einwilligung muss informiert sein.',
      ),
      nein(
        'Ein vorangekreuztes Häkchen genügt.',
        'Stillschweigen oder vorausgefüllte Kästchen sind keine eindeutige Einwilligung.',
      ),
      nein(
        'Ein Widerruf macht die bisherige Verarbeitung rückwirkend rechtswidrig.',
        'Der Widerruf wirkt nur für die Zukunft.',
      ),
    ],
    explanation:
        'Eine wirksame Einwilligung ist freiwillig, informiert, eindeutig und jederzeit für die Zukunft widerrufbar.',
  ),
  einfach(
    'a6-xs-4',
    'ds-grundsaetze',
    scenario:
        'Bei einer Prüfung verlangt die Aufsichtsbehörde von einem Unternehmen Belege, dass es die DSGVO einhält, etwa ein Verzeichnis der Verarbeitungstätigkeiten.',
    prompt: 'Welcher Grundsatz steht dahinter?',
    choices: [
      ja(
        'Rechenschaftspflicht',
        'Der Verantwortliche muss die Einhaltung der Grundsätze nachweisen können.',
      ),
      nein(
        'Datenminimierung',
        'Sie betrifft den Umfang der erhobenen Daten, nicht den Nachweis.',
      ),
      nein('Zweckbindung', 'Sie regelt, wofür Daten genutzt werden dürfen.'),
      nein(
        'Speicherbegrenzung',
        'Sie regelt, wie lange Daten gespeichert werden dürfen.',
      ),
    ],
    explanation:
        'Die Rechenschaftspflicht (Art. 5 Abs. 2) verlangt, dass der Verantwortliche die Einhaltung aller Grundsätze belegen kann.',
  ),
  zuordnen(
    'a6-xs-5',
    'ds-grundsaetze',
    prompt:
        'Auf welche Rechtsgrundlage nach Art. 6 Abs. 1 DSGVO stützt sich die Verarbeitung?',
    buckets: [
      'a) Einwilligung',
      'b) Vertrag',
      'c) rechtliche Verpflichtung',
      'f) berechtigtes Interesse',
    ],
    items: [
      zu(
        'Newsletter-Versand nach Anmeldung mit Häkchen und Bestätigungsmail',
        0,
        'Der Kunde hat freiwillig und aktiv zugestimmt.',
      ),
      zu(
        'Speichern der Lieferadresse für eine Bestellung',
        1,
        'Ohne Adresse kann der Kaufvertrag nicht erfüllt werden.',
      ),
      zu(
        'Übermittlung der Lohnsteuerdaten an das Finanzamt',
        2,
        'Der Arbeitgeber ist gesetzlich dazu verpflichtet.',
      ),
      zu(
        'Videoüberwachung des Lagers zum Schutz vor Diebstahl',
        3,
        'Der Schutz des Eigentums ist ein berechtigtes Interesse, das gegen die Interessen der Beschäftigten abgewogen wird.',
      ),
    ],
    explanation:
        'Art. 6 Abs. 1: a) Einwilligung, b) Vertrag, c) rechtliche Verpflichtung, d) lebenswichtige Interessen, e) öffentliche Aufgabe, f) berechtigtes Interesse. Eine Verarbeitung braucht mindestens eine davon.',
  ),
  rechnen(
    'a6-xs-6',
    'ds-grundsaetze',
    scenario:
        'Ein Konzern mit 2 Mrd. € weltweitem Jahresumsatz verarbeitet Kundendaten ohne Rechtsgrundlage.',
    prompt: 'Wie hoch ist das höchstmögliche Bußgeld in Mio. €?',
    answer: 80,
    unit: 'Mio. €',
    difficulty: 2,
    explanation:
        'Verstöße gegen die Rechtsgrundlagen fallen unter den oberen Rahmen: bis 20 Mio. € oder 4 % des weltweiten Jahresumsatzes, je nachdem, welcher Betrag höher ist. 4 % × 2.000 Mio. € = 80 Mio. € > 20 Mio. € -> 80 Mio. €.',
  ),
  einfach(
    'a6-xs-7',
    'ds-grundsaetze',
    scenario:
        'In einer neuen Fitness-App ist das Nutzerprofil nach der Registrierung standardmäßig für alle sichtbar, und die Standortfreigabe ist voreingestellt aktiv. Wer das nicht will, muss es in den Einstellungen abschalten.',
    prompt: 'Gegen welche Vorgabe verstößt die App?',
    choices: [
      ja(
        'Datenschutzfreundliche Voreinstellungen (Privacy by Default, Art. 25)',
        'Voreingestellt dürfen nur die Daten verarbeitet werden, die für den Zweck nötig sind.',
      ),
      nein(
        'Recht auf Datenübertragbarkeit',
        'Dabei geht es um den Export eigener Daten für einen Anbieterwechsel.',
      ),
      nein('Meldepflicht bei Datenpannen', 'Eine Datenpanne liegt nicht vor.'),
      nein('Recht auf Berichtigung', 'Es geht nicht um falsche Daten.'),
    ],
    explanation:
        'Art. 25 verlangt Datenschutz durch Technikgestaltung und datenschutzfreundliche Voreinstellungen: Profil privat, Standort aus, bis die Person selbst etwas anderes wählt.',
  ),
  einfach(
    'a6-xs-8',
    'ds-grundsaetze',
    prompt:
        'Welches Dokument listet alle Verarbeitungen eines Unternehmens mit Zweck, Datenkategorien, Empfängern und Löschfristen auf?',
    choices: [
      ja(
        'Verzeichnis von Verarbeitungstätigkeiten (Art. 30)',
        'Es ist der zentrale Nachweis für die Rechenschaftspflicht.',
      ),
      nein(
        'Datenschutzerklärung auf der Website',
        'Sie informiert Betroffene nach Art. 13, ist aber kein internes Gesamtverzeichnis.',
      ),
      nein(
        'Vertrag zur Auftragsverarbeitung',
        'Er regelt nur die Zusammenarbeit mit einem einzelnen Dienstleister.',
      ),
      nein(
        'Datenschutz-Folgenabschätzung',
        'Sie bewertet einzelne Verarbeitungen mit hohem Risiko, listet aber nicht alle auf.',
      ),
    ],
    difficulty: 1,
    explanation:
        'Das Verzeichnis von Verarbeitungstätigkeiten (VVT) nach Art. 30 beschreibt jede Verarbeitung. Die DSFA nach Art. 35 kommt nur bei voraussichtlich hohem Risiko hinzu.',
  ),

  // ============================================ Rechte der Betroffenen
  zuordnen(
    'a6-xr-1',
    'ds-rechte',
    prompt: 'Welches Recht macht die Person jeweils geltend?',
    buckets: [
      'Auskunft',
      'Berichtigung',
      'Löschung',
      'Datenübertragbarkeit',
      'Widerspruch',
    ],
    items: [
      zu(
        '„Welche Daten haben Sie über mich gespeichert?“',
        0,
        'Die Frage nach den gespeicherten Daten ist eine Auskunft nach Art. 15.',
      ),
      zu(
        '„Meine Hausnummer ist falsch hinterlegt.“',
        1,
        'Falsche Daten zu korrigieren ist Berichtigung nach Art. 16.',
      ),
      zu(
        '„Entfernen Sie mein Konto und alle meine Daten.“',
        2,
        'Das Entfernen aller Daten verlangt Löschung nach Art. 17.',
      ),
      zu(
        '„Schicken Sie mir meine Trainingsdaten als CSV, ich wechsle den Anbieter.“',
        3,
        'Maschinenlesbare Daten für den Anbieterwechsel: Art. 20.',
      ),
      zu(
        '„Ich möchte keine Werbung mehr per Post von Ihnen.“',
        4,
        'Gegen Direktwerbung kann man nach Art. 21 immer widersprechen.',
      ),
    ],
    explanation:
        'Auskunft Art. 15, Berichtigung Art. 16, Löschung Art. 17, Datenübertragbarkeit Art. 20, Widerspruch gegen Direktwerbung Art. 21.',
  ),
  rechnen(
    'a6-xr-2',
    'ds-rechte',
    prompt:
        'Eine Auskunftsanfrage ist sehr umfangreich. Der Verantwortliche verlängert die Frist ordnungsgemäß. Wie viele Monate hat er ab Eingang höchstens Zeit?',
    answer: 3,
    unit: 'Monate',
    difficulty: 1,
    explanation:
        'Grundfrist 1 Monat, Verlängerung um bis zu 2 Monate: 1 + 2 = 3 Monate. Die Verlängerung muss innerhalb des ersten Monats begründet mitgeteilt werden.',
  ),
  einfach(
    'a6-xr-3',
    'ds-rechte',
    scenario:
        'Ein Kunde verlangt, dass ein Onlineshop alle seine Daten löscht. Für seine Bestellungen liegen Rechnungen vor, die gesetzlich aufbewahrt werden müssen.',
    prompt: 'Wie geht der Shop richtig vor?',
    choices: [
      ja(
        'Rechnungsdaten sperren und nach Ablauf der Frist löschen, alle übrigen Daten sofort löschen und den Kunden informieren',
        'Aufbewahrungspflichten gehen vor, alles andere muss gelöscht werden.',
      ),
      nein(
        'Alle Daten sofort löschen, auch die Rechnungen',
        'Damit verstieße der Shop gegen gesetzliche Aufbewahrungspflichten.',
      ),
      nein(
        'Die Löschung ablehnen, weil Rechnungen existieren',
        'Nur die aufbewahrungspflichtigen Daten sind ausgenommen, nicht alle.',
      ),
      nein(
        'Das Kundenkonto deaktivieren, aber alle Daten weiter nutzen',
        'Eine Weiternutzung ohne Rechtsgrundlage verstößt gegen die DSGVO.',
      ),
    ],
    explanation:
        'Das Recht auf Löschung hat Grenzen: Gesetzlich aufzubewahrende Daten werden gesperrt, alles andere wird gelöscht.',
  ),
  einfach(
    'a6-xr-4',
    'ds-rechte',
    scenario:
        'Eine Kundin bestreitet, dass ihr gespeicherter Kontostand richtig ist. Die Prüfung dauert einige Tage.',
    prompt: 'Welches Recht kann sie für diese Zeit geltend machen?',
    choices: [
      ja(
        'Einschränkung der Verarbeitung',
        'Die Daten bleiben gespeichert, dürfen aber bis zur Klärung nicht weiter genutzt werden.',
      ),
      nein(
        'Datenübertragbarkeit',
        'Die dient dem Anbieterwechsel, nicht der Klärung strittiger Daten.',
      ),
      nein(
        'Beschwerde bei der Aufsichtsbehörde',
        'Möglich, aber sie stoppt die Nutzung der Daten während der Prüfung nicht.',
      ),
      nein(
        'Information bei der Erhebung',
        'Die Pflicht zur Information betrifft den Zeitpunkt der Erhebung.',
      ),
    ],
    explanation:
        'Art. 18 erlaubt die Einschränkung, solange die Richtigkeit bestritten wird und der Verantwortliche sie prüft.',
  ),
  einfach(
    'a6-xr-5',
    'ds-rechte',
    scenario:
        'Eine Bank lehnt einen Kreditantrag ab. Die Entscheidung hat allein ein Bewertungsprogramm getroffen, kein Mensch hat den Antrag angesehen.',
    prompt: 'Welches Recht kann der Antragsteller geltend machen?',
    choices: [
      ja(
        'Das Recht, keiner rein automatisierten Entscheidung unterworfen zu werden, und das Eingreifen eines Menschen zu verlangen (Art. 22)',
        'Entscheidungen mit rechtlicher oder ähnlich erheblicher Wirkung dürfen nicht allein ein Algorithmus treffen - Ausnahmen gelten nur mit Schutzmaßnahmen.',
      ),
      nein(
        'Das Recht auf Datenübertragbarkeit (Art. 20)',
        'Es dient dem Anbieterwechsel, nicht der Überprüfung einer Entscheidung.',
      ),
      nein(
        'Das Recht auf Berichtigung (Art. 16)',
        'Es setzt falsche Daten voraus, nicht eine automatisierte Entscheidung.',
      ),
      nein(
        'Kein Recht, weil die Bank frei entscheiden darf',
        'Die Bank darf ablehnen, aber nicht ohne Weiteres allein per Algorithmus.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Art. 22 schützt vor Entscheidungen, die ausschließlich automatisiert getroffen werden und erhebliche Wirkung haben. Betroffene können das Eingreifen eines Menschen verlangen, ihren Standpunkt darlegen und die Entscheidung anfechten.',
  ),
  einfach(
    'a6-xr-6',
    'ds-rechte',
    scenario:
        'Eine Bewerberin schickt ihre Unterlagen per Mail an ein IT-Systemhaus.',
    prompt:
        'Wann muss das Systemhaus sie über Zweck, Rechtsgrundlage und Speicherdauer informieren?',
    choices: [
      ja(
        'Zum Zeitpunkt der Erhebung, also beim Eingang ihrer Bewerbung',
        'Art. 13 verlangt die Information, wenn die Daten bei der Person selbst erhoben werden.',
      ),
      nein(
        'Erst wenn sie eine Auskunft verlangt',
        'Die Informationspflicht besteht von sich aus, unabhängig von einer Anfrage.',
      ),
      nein(
        'Erst bei einer Absage',
        'Dann wären die Daten längst verarbeitet worden, ohne dass sie informiert war.',
      ),
      nein(
        'Gar nicht, Bewerbungen sind ausgenommen',
        'Auch Bewerbende sind betroffene Personen mit allen Rechten.',
      ),
    ],
    explanation:
        'Die Informationspflicht nach Art. 13 gilt bei der Erhebung. Üblich ist ein Hinweis auf der Karriereseite oder in der Eingangsbestätigung mit Verantwortlichem, Zweck, Rechtsgrundlage, Speicherdauer und Rechten.',
  ),
  mehrfach(
    'a6-xr-7',
    'ds-rechte',
    prompt: 'Was gehört zu einer vollständigen Auskunft nach Art. 15 DSGVO?',
    choices: [
      ja(
        'Eine Kopie der gespeicherten personenbezogenen Daten',
        'Die erste Kopie ist kostenlos.',
      ),
      ja(
        'Die Zwecke der Verarbeitung',
        'Die Person soll wissen, wofür ihre Daten genutzt werden.',
      ),
      ja(
        'Die Empfänger oder Kategorien von Empfängern',
        'Dazu gehört, an wen Daten weitergegeben wurden.',
      ),
      ja(
        'Die geplante Speicherdauer',
        'Oder die Kriterien, nach denen sie festgelegt wird.',
      ),
      nein(
        'Der Quellcode der Kundendatenbank',
        'Die Auskunft betrifft die Daten der Person, nicht die Technik.',
      ),
      nein(
        'Eine Rechnung über 25 € für die erste Kopie',
        'Die erste Kopie ist kostenlos.',
      ),
    ],
    explanation:
        'Die Auskunft umfasst die Daten selbst (als Kopie), Zwecke, Kategorien, Empfänger, Speicherdauer, Herkunft sowie Hinweise auf die weiteren Rechte und das Beschwerderecht.',
  ),

  // ================================ Anonymisieren und Pseudonymisieren
  zuordnen(
    'a6-xa-1',
    'ds-anonym',
    prompt: 'Ist das Ergebnis anonym oder pseudonym?',
    buckets: ['anonym', 'pseudonym'],
    items: [
      zu(
        'Veröffentlichte Zahl der Bestellungen je Bundesland',
        0,
        'Eine Summe über ein ganzes Bundesland lässt keinen Rückschluss auf Einzelne zu.',
      ),
      zu(
        'Durchschnittsalter aller 500 Teilnehmenden einer Umfrage',
        0,
        'Der Durchschnitt einer großen Gruppe verrät keine Einzelperson.',
      ),
      zu(
        'Name durch Kundennummer ersetzt, Zuordnungsliste liegt in der Buchhaltung',
        1,
        'Über die Zuordnungsliste lässt sich die Person wieder bestimmen.',
      ),
      zu(
        'E-Mail-Adresse durch ihren SHA-256-Hashwert ersetzt',
        1,
        'Wer die Adresse kennt, kann den Hash nachrechnen und vergleichen.',
      ),
      zu(
        'Studiendaten mit Probandencode, Namensliste beim Studienleiter',
        1,
        'Mit der Namensliste als Zusatzwissen ist der Bezug herstellbar.',
      ),
    ],
    explanation:
        'Summen und Durchschnitte großer Gruppen sind anonym. Wo eine Liste oder das Nachrechnen eines Hashs zur Person führt, bleibt es pseudonym.',
  ),
  einfach(
    'a6-xa-2',
    'ds-anonym',
    prompt: 'Welche rechtliche Folge hat eine Pseudonymisierung?',
    choices: [
      ja(
        'Die Daten bleiben personenbezogen, die DSGVO gilt weiter.',
        'Mit dem Zusatzwissen lässt sich die Person bestimmen.',
      ),
      nein('Die DSGVO gilt nicht mehr.', 'Das gilt nur für anonyme Daten.'),
      nein(
        'Die Daten dürfen ohne Rechtsgrundlage weitergegeben werden.',
        'Auch pseudonyme Daten brauchen eine Rechtsgrundlage.',
      ),
      nein(
        'Die Daten werden automatisch zu besonderen Kategorien nach Art. 9.',
        'Pseudonymisierung ändert die Art der Daten nicht.',
      ),
    ],
    explanation:
        'Pseudonymisierung senkt das Risiko und ist eine Schutzmaßnahme, hebt den Personenbezug aber nicht auf.',
  ),
  mehrfach(
    'a6-xa-3',
    'ds-anonym',
    prompt: 'Welche Verfahren dienen der Anonymisierung?',
    choices: [
      ja(
        'Aggregieren, z. B. Durchschnittswerte je Abteilung',
        'Einzelwerte verschwinden in der Summe.',
      ),
      ja(
        'Generalisieren, z. B. Altersgruppen statt Geburtsdatum',
        'Werte werden so grob, dass sie keine Person mehr bestimmen.',
      ),
      nein(
        'Namen durch Personalnummern ersetzen',
        'Über die Personalnummer ist die Person weiterhin bestimmbar - das ist Pseudonymisierung.',
      ),
      nein(
        'E-Mail-Adressen durch ihren Hashwert ersetzen',
        'Der Hash lässt sich aus bekannten Adressen nachrechnen - das bleibt pseudonym.',
      ),
    ],
    explanation:
        'Anonymisieren heißt, den Personenbezug dauerhaft zu zerstören, etwa durch Aggregation oder Generalisierung. Ein Ersatzkennzeichen reicht dafür nicht.',
  ),
  einfach(
    'a6-xa-4',
    'ds-anonym',
    scenario:
        'Die Personalabteilung gibt eine Tabelle mit dem Durchschnittsgehalt je Abteilung weiter. Namen enthält sie nicht. Die Abteilung „Recht“ hat nur eine Mitarbeiterin.',
    prompt: 'Warum ist die Tabelle nicht vollständig anonym?',
    choices: [
      ja(
        'Der Durchschnitt der Abteilung „Recht“ ist genau das Gehalt der einen Mitarbeiterin.',
        'Bei einer Gruppe aus einer Person verrät der Durchschnitt den Einzelwert.',
      ),
      nein(
        'Weil Gehälter immer besondere Kategorien nach Art. 9 sind',
        'Gehälter gehören nicht zu Art. 9.',
      ),
      nein(
        'Weil Durchschnittswerte grundsätzlich personenbezogen sind',
        'Durchschnitte großer Gruppen sind anonym.',
      ),
      nein(
        'Weil keine Zuordnungstabelle getrennt aufbewahrt wird',
        'Eine Zuordnungstabelle gehört zur Pseudonymisierung, nicht zur Anonymisierung.',
      ),
    ],
    explanation:
        'Aggregation schützt nur, wenn die Gruppen groß genug sind. Kleine Gruppen müssen zusammengefasst werden.',
  ),
  einfach(
    'a6-xa-5',
    'ds-anonym',
    scenario:
        'Ein Entwickler möchte für Tests der neuen Shop-Version eine vollständige Kopie der Produktivdatenbank mit echten Kundendaten auf seinem Testsystem nutzen.',
    prompt: 'Wie geht man datenschutzgerecht vor?',
    choices: [
      ja(
        'Die Testdaten anonymisieren oder künstliche Testdaten erzeugen',
        'So enthält das weniger geschützte Testsystem keine echten personenbezogenen Daten.',
      ),
      nein(
        'Die Kopie unverändert nutzen, weil sie im eigenen Haus bleibt',
        'Die Nutzung echter Kundendaten für Tests ist eine Zweckänderung und das Testsystem meist schlechter geschützt.',
      ),
      nein(
        'Nur die Spalte „Name“ löschen',
        'Über Adresse, E-Mail oder Kundennummer bleiben die Kunden identifizierbar.',
      ),
      nein(
        'Die Kopie mit AES verschlüsseln und so testen',
        'Zum Testen muss sie entschlüsselt werden - der Personenbezug bleibt.',
      ),
    ],
    explanation:
        'Echte Kundendaten haben in Testsystemen nichts verloren. Richtig ist, sie zu anonymisieren oder synthetische Testdaten zu erzeugen - nur dann gilt die DSGVO für die Testdaten nicht.',
  ),
  einfach(
    'a6-xa-6',
    'ds-anonym',
    scenario:
        'Eine generalisierte Tabelle soll weitergegeben werden. Vorgabe: Jede Kombination aus Altersgruppe und PLZ-Bereich muss mindestens 3 Personen umfassen. Gruppen: 20-29 / 50xxx: 7 Personen, 30-39 / 50xxx: 5 Personen, 30-39 / 51xxx: 2 Personen, 40-49 / 50xxx: 4 Personen.',
    prompt: 'Was ist zu tun?',
    choices: [
      ja(
        'Die Gruppe 30-39 / 51xxx mit nur 2 Personen weiter vergröbern oder weglassen',
        'Sie unterschreitet die Mindestgröße von 3 - diese Personen wären leichter erkennbar.',
      ),
      nein(
        'Nichts, alle Gruppen sind groß genug',
        'Die Gruppe 30-39 / 51xxx hat nur 2 Personen.',
      ),
      nein(
        'Die Gruppe 20-29 / 50xxx aufteilen, weil sie die größte ist',
        'Große Gruppen sind unkritisch - das Problem sind kleine.',
      ),
      nein(
        'Namen ergänzen, damit die Tabelle verständlicher wird',
        'Das würde den Personenbezug gerade wiederherstellen.',
      ),
    ],
    difficulty: 2,
    explanation:
        'Beim Anonymisieren muss jede Gruppe groß genug sein, damit niemand herausfällt. Zu kleine Gruppen werden vergröbert (z. B. PLZ 5xxxx) oder unterdrückt.',
  ),
  zuordnen(
    'a6-xa-7',
    'ds-anonym',
    prompt: 'Welche Technik der Anonymisierung wird angewendet?',
    buckets: ['Entfernen', 'Generalisieren', 'Aggregieren', 'Verrauschen'],
    items: [
      zu(
        'Die Spalte mit den E-Mail-Adressen wird gelöscht.',
        0,
        'Ein direktes Merkmal fällt ganz weg.',
      ),
      zu(
        'Aus dem Geburtsdatum wird das Geburtsjahrzehnt.',
        1,
        'Der Wert wird vergröbert.',
      ),
      zu(
        'Ausgegeben wird nur die Umsatzsumme je Region.',
        2,
        'Einzelwerte werden zusammengefasst.',
      ),
      zu(
        'Jedes Gehalt wird zufällig um bis zu 3 % verändert.',
        3,
        'Zufällige Abweichungen verdecken Einzelwerte, die Statistik bleibt brauchbar.',
      ),
    ],
    explanation:
        'Entfernen löscht Merkmale, Generalisieren vergröbert sie, Aggregieren fasst zusammen, Verrauschen verändert Werte zufällig. Meist werden mehrere Techniken kombiniert.',
  ),
  einfach(
    'a6-xa-8',
    'ds-anonym',
    scenario:
        'Eine Kundendatenbank wird vollständig mit AES-256 verschlüsselt, bevor sie an einen Dienstleister geht. Der Schlüssel bleibt beim Unternehmen.',
    prompt: 'Sind die Daten für das Unternehmen dadurch anonym?',
    choices: [
      ja(
        'Nein - mit dem Schlüssel lässt sich der Personenbezug wiederherstellen, die DSGVO gilt weiter.',
        'Verschlüsselung ist eine wichtige Schutzmaßnahme, aber keine Anonymisierung.',
      ),
      nein(
        'Ja - verschlüsselte Daten sind immer anonym.',
        'Verschlüsselung ist umkehrbar, Anonymisierung nicht.',
      ),
      nein(
        'Ja - weil AES-256 als praktisch nicht knackbar gilt.',
        'Die Stärke des Verfahrens ändert nichts: Wer den Schlüssel hat, kann die Daten jederzeit wieder lesen.',
      ),
      nein(
        'Nein - verschlüsselte Daten sind automatisch besondere Kategorien nach Art. 9.',
        'Die Verschlüsselung ändert nichts an der Art der Daten.',
      ),
    ],
    explanation:
        'Anonym sind Daten nur, wenn sich der Personenbezug mit keinen vernünftigen Mitteln mehr herstellen lässt. Verschlüsselte Daten sind mit dem Schlüssel wieder lesbar - sie bleiben personenbezogen.',
  ),

  // =============================== Technische und organisatorische Maßnahmen
  zuordnen(
    'a6-xt-1',
    'ds-tom',
    prompt: 'Ordne jede Maßnahme dem klassischen Kontrollziel zu.',
    buckets: [
      'Zutrittskontrolle',
      'Zugangskontrolle',
      'Zugriffskontrolle',
      'Weitergabekontrolle',
      'Eingabekontrolle',
      'Verfügbarkeitskontrolle',
    ],
    items: [
      zu(
        'Chipkartenleser an der Tür zum Serverraum',
        0,
        'Schützt den Raum - Zutritt.',
      ),
      zu(
        'Anmeldung am Notebook mit Passwort und zweitem Faktor',
        1,
        'Schützt die Nutzung des Systems - Zugang.',
      ),
      zu(
        'Nur die Personalabteilung darf Personalakten lesen',
        2,
        'Regelt die Rechte auf bestimmte Daten - Zugriff.',
      ),
      zu(
        'E-Mails mit Patientendaten werden mit S/MIME verschlüsselt',
        3,
        'Schützt die Daten bei der Übertragung - Weitergabe.',
      ),
      zu(
        'Jede Änderung an einer Patientenakte wird mit Name und Uhrzeit protokolliert',
        4,
        'Macht nachvollziehbar, wer was geändert hat - Eingabe.',
      ),
      zu(
        'Tägliches Backup auf ein ausgelagertes System',
        5,
        'Schützt den Datenbestand vor Verlust - Verfügbarkeit.',
      ),
    ],
    explanation:
        'Zutritt: Räume. Zugang: Systeme. Zugriff: Daten. Weitergabe: Übertragung. Eingabe: Nachvollziehbarkeit von Änderungen. Verfügbarkeit: Schutz vor Verlust.',
  ),
  zuordnen(
    'a6-xt-2',
    'ds-tom',
    prompt: 'Ist die Maßnahme technisch oder organisatorisch?',
    buckets: ['technisch', 'organisatorisch'],
    items: [
      zu('Firewall', 0, 'Setzt das Regelwerk automatisch durch.'),
      zu(
        'Festplattenverschlüsselung',
        0,
        'Die Technik schützt die Daten, ohne dass jemand eingreifen muss.',
      ),
      zu('Alarmanlage', 0, 'Ein technisches System meldet das Eindringen.'),
      zu(
        'Datenschutzschulung',
        1,
        'Sie wirkt über das Verhalten der Menschen.',
      ),
      zu(
        'Besucherbuch am Empfang',
        1,
        'Eine Regel, die Menschen einhalten müssen.',
      ),
      zu(
        'Vier-Augen-Prinzip bei Überweisungen',
        1,
        'Ein festgelegter Ablauf mit zwei Personen.',
      ),
    ],
    explanation:
        'Technische Maßnahmen setzt die Technik selbst durch. Organisatorische Maßnahmen sind Regeln und Abläufe, die Menschen einhalten.',
  ),
  einfach(
    'a6-xt-3',
    'ds-tom',
    scenario:
        'Ein Softwarehaus betreibt eine Cloud-Lösung für mehrere Arztpraxen. Jede Praxis darf nur ihre eigenen Patientendaten sehen, die Daten liegen in getrennten Mandanten.',
    prompt: 'Welches klassische Kontrollziel wird damit vor allem umgesetzt?',
    choices: [
      ja(
        'Trennungsgebot',
        'Daten, die zu verschiedenen Zwecken erhoben wurden, werden getrennt verarbeitet.',
      ),
      nein(
        'Zutrittskontrolle',
        'Sie betrifft den physischen Zutritt zu Räumen.',
      ),
      nein(
        'Verfügbarkeitskontrolle',
        'Sie schützt vor Verlust, etwa durch Backups.',
      ),
      nein(
        'Eingabekontrolle',
        'Sie macht nachvollziehbar, wer Daten geändert hat.',
      ),
    ],
    explanation:
        'Mandantentrennung ist das typische Beispiel für das Trennungsgebot aus der klassischen Gliederung der Kontrollziele.',
  ),
  mehrfach(
    'a6-xt-4',
    'ds-tom',
    prompt:
        'Was nennt Art. 32 DSGVO als Teil angemessener Sicherheitsmaßnahmen?',
    choices: [
      ja(
        'Pseudonymisierung und Verschlüsselung',
        'Beides wird ausdrücklich als Beispiel genannt.',
      ),
      ja(
        'Vertraulichkeit, Integrität, Verfügbarkeit und Belastbarkeit der Systeme',
        'Sie sollen auf Dauer sichergestellt werden.',
      ),
      ja(
        'Regelmäßige Überprüfung der Wirksamkeit der Maßnahmen',
        'Maßnahmen müssen überprüft, bewertet und evaluiert werden.',
      ),
      nein(
        'Verschlüsselung aller Daten ohne Ausnahme, unabhängig vom Risiko',
        'Art. 32 verlangt risikoangemessene Maßnahmen, keine starre Pflicht.',
      ),
      nein(
        'Veröffentlichung aller Sicherheitsmaßnahmen im Internet',
        'Das fordert die DSGVO nicht - es würde Angreifern eher helfen.',
      ),
    ],
    explanation:
        'Art. 32 fordert risikoangemessene TOM: u. a. Pseudonymisierung, Verschlüsselung, dauerhafte Sicherheit der Systeme, schnelle Wiederherstellung und regelmäßige Überprüfung.',
  ),
  einfach(
    'a6-xt-5',
    'ds-tom',
    scenario:
        'Am Mittwoch um 10 Uhr stellt ein Unternehmen fest, dass eine Mail mit einer Liste von 800 Kundenadressen und Bestellungen an einen falschen externen Empfänger gegangen ist. Ein Risiko für die Kunden besteht.',
    prompt:
        'Bis wann muss die Meldung bei der Aufsichtsbehörde spätestens eingehen?',
    choices: [
      ja(
        'Samstag, 10 Uhr',
        '72 Stunden ab Bekanntwerden: Mi 10 Uhr + 3 × 24 h = Sa 10 Uhr.',
      ),
      nein('Freitag, 10 Uhr', 'Das wären nur 48 Stunden.'),
      nein(
        'Montag, 10 Uhr, weil das Wochenende nicht zählt',
        'Die 72 Stunden laufen auch am Wochenende weiter.',
      ),
      nein(
        'Innerhalb eines Monats',
        'Die Monatsfrist gilt für Anfragen von Betroffenen, nicht für die Meldung von Datenpannen.',
      ),
    ],
    difficulty: 2,
    explanation:
        'Nach Art. 33 ist eine Datenpanne unverzüglich und möglichst binnen 72 Stunden nach Bekanntwerden der Aufsichtsbehörde zu melden. Mittwoch 10 Uhr + 72 h = Samstag 10 Uhr.',
  ),
  mehrfach(
    'a6-xt-6',
    'ds-tom',
    prompt: 'Welche Aussagen zur Meldepflicht bei Datenpannen sind richtig?',
    choices: [
      ja(
        'Die Meldung an die Aufsichtsbehörde soll binnen 72 Stunden nach Bekanntwerden erfolgen.',
        'So verlangt es Art. 33.',
      ),
      ja(
        'Bei voraussichtlich hohem Risiko müssen zusätzlich die Betroffenen benachrichtigt werden.',
        'Das regelt Art. 34.',
      ),
      ja(
        'Jede Panne wird intern dokumentiert, auch wenn keine Meldung nötig ist.',
        'Die Dokumentation dient der Rechenschaftspflicht.',
      ),
      nein(
        'Gemeldet werden muss erst, wenn die Presse berichtet.',
        'Die Pflicht hängt vom Risiko für die Betroffenen ab, nicht von der Öffentlichkeit.',
      ),
      nein(
        'Am Wochenende ruht die 72-Stunden-Frist.',
        'Die Frist läuft durchgehend.',
      ),
    ],
    explanation:
        'Datenpanne: Aufsicht binnen 72 h (außer voraussichtlich kein Risiko), Betroffene bei hohem Risiko unverzüglich, intern immer dokumentieren.',
  ),
  einfach(
    'a6-xt-7',
    'ds-tom',
    scenario:
        'Einem Außendienstmitarbeiter wird das Notebook gestohlen. Die Festplatte ist vollständig mit BitLocker verschlüsselt, das Passwort ist stark und wurde nicht mitgestohlen. Eine aktuelle Sicherung existiert.',
    prompt: 'Was gilt für die Meldepflicht?',
    choices: [
      ja(
        'Voraussichtlich besteht kein Risiko für die Betroffenen - keine Meldung nötig, aber intern dokumentieren.',
        'Die Daten sind für den Dieb unlesbar und dank Sicherung nicht verloren.',
      ),
      nein(
        'Die Aufsichtsbehörde muss immer binnen 72 Stunden informiert werden.',
        'Die Meldepflicht entfällt, wenn die Panne voraussichtlich zu keinem Risiko führt.',
      ),
      nein(
        'Alle Kunden müssen sofort benachrichtigt werden.',
        'Das ist nur bei voraussichtlich hohem Risiko nötig.',
      ),
      nein(
        'Nichts ist zu tun, nicht einmal eine Dokumentation.',
        'Jede Panne muss intern dokumentiert werden.',
      ),
    ],
    difficulty: 3,
    explanation:
        'Starke Verschlüsselung ist eine wirksame TOM: Ohne Schlüssel sind die Daten unlesbar, das Risiko für die Betroffenen entfällt voraussichtlich. Die Panne wird trotzdem intern dokumentiert.',
  ),
];
