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
  const BitTip(this.spot, {super.key, this.title = 'Tipp von Bit', this.mood});

  final BitSpot spot;
  final String title;
  final MascotMood? mood;

  @override
  State<BitTip> createState() => _BitTipState();
}

class _BitTipState extends State<BitTip> {
  int _offset = 0;

  @override
  Widget build(BuildContext context) {
    final many = BitTips.tips[widget.spot]!.length > 1;
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
          text: BitTips.forToday(widget.spot, offset: _offset),
        ),
      ),
    );
  }
}
