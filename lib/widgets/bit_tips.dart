import 'package:flutter/material.dart';

import 'mascot.dart';

/// Wo in der App ein Tipp von Bit steht.
enum BitSpot { journey, lesson, cards, picker, exam, areas, session, quiz }

/// Lerntipps von Bit - je Ort ein kleiner Vorrat, der täglich wechselt.
///
/// Die Tipps sind bewusst handfest: eine Technik oder eine Prüfungsregel,
/// die man sofort anwenden kann - kein „Du schaffst das!“ ohne Inhalt.
class BitTips {
  const BitTips._();

  static const Map<BitSpot, List<String>> tips = {
    BitSpot.journey: [
      'Eine Lektion am Tag reicht. Wer täglich ein Stück lernt, behält mehr '
          'als beim Pauken am Wochenende.',
      'Lies jeden Schritt einmal, dann erklär ihn in einem Satz laut. Was du '
          'nicht erklären kannst, hast du noch nicht verstanden.',
      'Die Lektionen bauen aufeinander auf. Wenn etwas hakt, lohnt ein Blick '
          'in die Lektion davor.',
      'Rechenbeispiele nicht nur lesen. Deck die Zahlen ab und rechne selbst. '
          'Genau das verlangt die Prüfung.',
      'Angefangen und unterbrochen? Ich merke mir den Schritt, und du machst '
          'genau da weiter.',
    ],
    BitSpot.lesson: [
      'Direkt nach der Lektion vergisst du am schnellsten. Ein paar Karten '
          'zum Thema heute Abend wirken Wunder.',
      'Lies „Das Wichtigste in Kürze“ morgen noch einmal. Das sind 30 Sekunden, die '
          'sich lohnen.',
      'Erklär die Merksätze jemandem. Wer lehrt, lernt doppelt.',
    ],
    BitSpot.cards: [
      'Erst im Kopf antworten, dann umdrehen. Wer nur liest, erkennt nur wieder. '
          'Wer abruft, lernt.',
      'Sei ehrlich bei „Wusste ich“. Halb gewusst ist nicht gewusst, die '
          'Karte kommt dann einfach öfter.',
      'Lieber jeden Tag zehn Minuten als einmal in der Woche eine Stunde. '
          'Abstand ist der Trick beim Behalten.',
      'Gemischte Themen fühlen sich schwerer an, bleiben aber genau deshalb '
          'länger hängen.',
    ],
    BitSpot.picker: [
      'Mehrere Themen gemischt zu lernen fällt schwerer, bleibt aber länger '
          'hängen als ein Thema am Stück.',
      'Ein Durchlauf über einen Bereich ist ideal vor einer Klassenarbeit: '
          'Am Ende hast du jede Karte einmal gewusst.',
    ],
    BitSpot.exam: [
      'Lies zuerst alle vier Aufgaben, dann fang mit der leichtesten an. So '
          'sicherst du früh Punkte.',
      'Schreib bei Rechnungen immer den Rechenweg auf, denn die IHK vergibt '
          'Teilpunkte auch bei falschem Ergebnis.',
      'Achte auf die Operatoren: „Nenne“ heißt Stichworte, „Erläutere“ heißt '
          'ganze Sätze mit Begründung.',
      'Knapp eine Minute pro Punkt: Für eine 6-Punkte-Teilaufgabe hast du '
          'rund fünf Minuten.',
    ],
    BitSpot.areas: [
      'Der Prozentwert zeigt, wie viel ein Bereich in der Prüfung ausmacht. '
          'Große Bereiche zuerst sichern.',
      'Lern nicht nur, was du magst. Die schwächsten Bereiche bringen die '
          'meisten zusätzlichen Punkte.',
    ],
    BitSpot.session: [
      'Lernen, Karten, Quiz, und zwar in dieser Reihenfolge. Erst verstehen, dann '
          'festigen, dann prüfen.',
      'Eine Session dauert etwa 15 Minuten. Perfekt für die Pause oder die '
          'Bahnfahrt.',
    ],
    BitSpot.quiz: [
      'Falsch beantwortete Aufgaben landen im Fehlerspeicher und kommen an '
          'einem anderen Tag wieder.',
      'Lies die Erklärung auch bei richtigen Antworten. Oft steckt ein '
          'Detail drin, das in der Prüfung gefragt wird.',
    ],
  };

  /// Prüfungstipps je Bereich (a01 bis a07): kurz, handfest, nachrechenbar.
  static const Map<String, List<String>> areaTips = {
    'a01': [
      'Netzplan: erst vorwärts, dann rückwärts. Vorwärts nimmst du das größte '
          'FEZ der Vorgänger, rückwärts das kleinste SAZ der Nachfolger.',
      'Gesamtpuffer ist SAZ minus FAZ. Alle Vorgänge mit Gesamtpuffer 0 '
          'bilden den kritischen Pfad.',
      'Freier Puffer ist das kleinste FAZ der Nachfolger minus das eigene FEZ. '
          'Er verschiebt keinen anderen Vorgang.',
      'Nutzwertanalyse: Punkte mal Gewichtung, dann je Alternative summieren. '
          'Prüf vorher, ob die Gewichte zusammen 100 % ergeben.',
      'Lastenheft schreibt der Auftraggeber und sagt, was gebraucht wird. '
          'Das Pflichtenheft vom Auftragnehmer sagt, wie es umgesetzt wird.',
      'Amortisationszeit ist die Investition geteilt durch die jährliche '
          'Einsparung. Einheit Jahre nicht vergessen.',
      'SMART heißt spezifisch, messbar, attraktiv, realistisch und terminiert. '
          'Prüf in der Aufgabe jedes Kriterium einzeln.',
    ],
    'a02': [
      'Vier-Ohren-Modell: Sachinhalt, Selbstoffenbarung, Beziehung und Appell. '
          'Ordne jede Aussage im Fall einer Seite zu.',
      'Offene W-Fragen erkunden den Bedarf, geschlossene Fragen bestätigen ihn. '
          'Im Kundengespräch erst offen, dann geschlossen fragen.',
      'Angebotsvergleich: erst Rabatt vom Listenpreis, dann Skonto vom '
          'Zieleinkaufspreis, dann Bezugskosten addieren.',
      'Brutto durch 1,19 ergibt netto. Brutto minus 19 % ist falsch und ein '
          'beliebter Punktverlust.',
      'Werbung und Kataloge sind nur eine Aufforderung zum Angebot. Ein '
          'Vertrag entsteht erst durch Antrag und Annahme.',
      'In Konflikten mit Ich-Botschaften sprechen: Du beschreibst deine '
          'Sicht, statt dem anderen Vorwürfe zu machen.',
    ],
    'a03': [
      'Subnetting: Nutzbare Hosts sind 2 hoch (32 minus Präfix) minus 2. '
          'Ein /26 hat also 64 Adressen und 62 nutzbare.',
      'Übertragungszeit ist Datenmenge in Bit durch Datenrate in Bit/s. '
          'Bytes vorher mal 8 nehmen.',
      'Achte auf die Präfixe: 1 KiB sind 1024 Byte, 1 kB sind 1000 Byte. '
          'Die Aufgabe sagt, was gemeint ist.',
      'Bildgröße: Breite mal Höhe mal Farbtiefe in Bit, dann durch 8 für Byte.',
      'IPv6 kürzen: führende Nullen je Block weglassen, und :: darf nur '
          'einmal in der Adresse stehen.',
      'Switch arbeitet auf OSI-Schicht 2 mit MAC-Adressen, Router auf '
          'Schicht 3 mit IP-Adressen.',
      'IaaS, PaaS, SaaS: Je weiter hinten in der Reihe, desto mehr übernimmt '
          'der Anbieter.',
    ],
    'a04': [
      'Pseudocode prüfst du mit einem Schreibtischtest: Wertetabelle anlegen '
          'und jede Zeile Schritt für Schritt durchgehen.',
      'Arrays beginnen meist bei Index 0. Bei n Elementen ist der letzte '
          'Index n minus 1.',
      'Klassendiagramm: „+“ steht für public, „-“ für private und „#“ für '
          'protected.',
      'Ausgefüllte Raute heißt Komposition: Das Teil lebt nicht ohne das '
          'Ganze. Die leere Raute ist Aggregation.',
      'Ein Hex-Zeichen entspricht genau 4 Bit. So rechnest du schnell '
          'zwischen Binär und Hex um.',
      'Use Case: „include“ wird immer mit ausgeführt, „extend“ nur unter '
          'einer Bedingung.',
      'Aktivitätsdiagramm: Bedingungen an einer Verzweigung stehen in eckigen '
          'Klammern und müssen alle Fälle abdecken.',
    ],
    'a05': [
      'Blackbox-Tests prüfen gegen die Anforderungen, ohne den Code zu '
          'kennen. Whitebox-Tests setzen am Code an.',
      'Äquivalenzklassen: je gültige und ungültige Klasse mindestens ein '
          'Testfall. Grenzwerte direkt an und neben der Grenze testen.',
      'Ein Testfall braucht Vorbedingung, Eingabe und erwartetes Ergebnis. '
          'Das erwartete Ergebnis steht vor dem Test fest.',
      'Nach jeder Änderung kommt ein Regressionstest. Er zeigt, ob '
          'Bestehendes noch funktioniert.',
      'Testebenen in Reihenfolge: Komponententest, Integrationstest, '
          'Systemtest, Abnahmetest.',
      'PDCA heißt Plan, Do, Check, Act. Der Kreis läuft immer wieder von '
          'vorn, das ist die kontinuierliche Verbesserung.',
    ],
    'a06': [
      'Die drei Schutzziele sind Vertraulichkeit, Integrität und '
          'Verfügbarkeit. Ordne jede Maßnahme einem davon zu.',
      'Datenpanne: Meldung an die Aufsichtsbehörde möglichst binnen 72 '
          'Stunden nach Bekanntwerden (Art. 33 DSGVO).',
      'Auskunft nach Art. 15 DSGVO: Antwort innerhalb eines Monats, in '
          'komplexen Fällen um zwei Monate verlängerbar.',
      '3-2-1-Regel: drei Kopien, zwei verschiedene Medien, eine Kopie '
          'außer Haus.',
      'Inkrementell sichert die Änderungen seit der letzten Sicherung, '
          'differenziell die seit der letzten Vollsicherung.',
      'Asymmetrisch: Mit dem öffentlichen Schlüssel verschlüsseln, mit dem '
          'privaten entschlüsseln. Signiert wird mit dem privaten.',
      'Ein Hash ist keine Verschlüsselung. Er lässt sich nicht zurückrechnen '
          'und prüft nur die Integrität.',
    ],
    'a07': [
      'SLA rechnen: 99,9 % bei 30 Tagen (720 Stunden) erlauben 0,72 Stunden '
          'Ausfall, also rund 43 Minuten.',
      'Werkvertrag schuldet einen Erfolg, Dienstvertrag nur die Tätigkeit. '
          'Daran entscheidest du die Vertragsart.',
      'Gewährleistung beim Kauf beweglicher Sachen: zwei Jahre (§ 438 BGB). '
          'Eine Garantie ist dagegen freiwillig.',
      'Bei einem Mangel kommt zuerst die Nacherfüllung. Der Käufer wählt '
          'Nachbesserung oder Ersatzlieferung (§ 439 BGB).',
      'Unter Kaufleuten musst du Mängel unverzüglich rügen (§ 377 HGB), '
          'sonst gilt die Ware als genehmigt.',
      'Incident heißt Störung schnell beheben, Problem heißt Ursache finden. '
          'Das unterscheidet ITIL streng.',
      'Reaktionszeit ist nicht Lösungszeit. Lies im SLA genau, welche Zeit '
          'gemeint ist.',
    ],
  };

  /// Alle Tipps eines Bereichs (leer bei unbekannter ID).
  static List<String> forArea(String areaId) => areaTips[areaId] ?? const [];

  /// Bereichstipp des Tages; [offset] blättert weiter.
  static String areaForToday(String areaId, {int offset = 0, DateTime? now}) {
    final list = forArea(areaId);
    if (list.isEmpty) return forToday(BitSpot.areas, offset: offset, now: now);
    return list[(_day(now) + areaId.codeUnitAt(areaId.length - 1) + offset) %
        list.length];
  }

  static int _day(DateTime? now) {
    final d = now ?? DateTime.now();
    return DateTime(d.year, d.month, d.day).difference(DateTime(2026)).inDays;
  }

  /// Tipp des Tages für [spot]; [offset] blättert weiter.
  static String forToday(BitSpot spot, {int offset = 0, DateTime? now}) {
    final list = tips[spot]!;
    final d = now ?? DateTime.now();
    final day = DateTime(
      d.year,
      d.month,
      d.day,
    ).difference(DateTime(2026)).inDays;
    return list[(day + spot.index + offset) % list.length];
  }
}

/// Bit mit dem Tipp des Tages für einen Ort. Antippen blättert zum nächsten
/// Tipp - so wird der Hinweis zum kleinen Gespräch statt zur Werbefläche.
class BitTip extends StatefulWidget {
  const BitTip(this.spot, {super.key, this.title = 'Tipp von Bit', this.mood})
    : areaId = null;

  /// Prüfungstipp zu einem Bereich (a01 bis a07).
  const BitTip.area(
    String this.areaId, {
    super.key,
    this.title = 'Bits Prüfungstipp',
    this.mood,
  }) : spot = BitSpot.areas;

  final BitSpot spot;
  final String? areaId;
  final String title;
  final MascotMood? mood;

  @override
  State<BitTip> createState() => _BitTipState();
}

class _BitTipState extends State<BitTip> {
  int _offset = 0;

  @override
  Widget build(BuildContext context) {
    final area = widget.areaId;
    final many =
        (area != null ? BitTips.forArea(area) : BitTips.tips[widget.spot]!)
            .length >
        1;
    return Semantics(
      button: many,
      hint: many ? 'Antippen für den nächsten Tipp' : null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: many ? () => setState(() => _offset++) : null,
        child: MascotSays(
          mood: widget.mood ?? MascotMood.think,
          size: 52,
          title: widget.title,
          text: area != null
              ? BitTips.areaForToday(area, offset: _offset)
              : BitTips.forToday(widget.spot, offset: _offset),
        ),
      ),
    );
  }
}
