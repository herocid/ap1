import 'package:ap1_trainer/data/seed/cards/cards_data.dart';
import 'package:ap1_trainer/features/cards/card_back_format.dart';
import 'package:flutter_test/flutter_test.dart';

String _squash(String s) => s.replaceAll(RegExp(r'\s+'), '');

String _joined(List<BackBlock> blocks) => blocks.map((b) => b.plain).join(' ');

void main() {
  group('Sätze trennen', () {
    test('trennt an einfachen Satzgrenzen', () {
      expect(splitSentences('Er verliert seinen Inhalt. Gespeichert wird.'), [
        'Er verliert seinen Inhalt.',
        'Gespeichert wird.',
      ]);
    });

    // Gegenbeispiele: hier darf nichts zerrissen werden.
    for (final s in [
      'Motivirrtum, z. B. falsch kalkuliert oder d. h. Ware nicht gebraucht.',
      'Verzug ohne Mahnung nach § 286 Abs. 2 Nr. 1 BGB bei festem Termin.',
      'Der Schaden liegt bei 10.000 € und damit über der Grenze.',
      'Das Netz 192.168.10.64/26 hat 62 nutzbare Adressen.',
      'Das Backup läuft um 17:45 Uhr, die Beziehung ist 1:n.',
      'Die 3. Normalform verlangt: keine transitiven Abhängigkeiten.',
      'Fällig am 1. Januar, in der Regel (i. d. R.) nach 30 Tagen.',
      'Er sagt „Wir nehmen an. Danke.“ und bestätigt damit.',
      'USB 2.0 liefert 480 Mbit/s, USB 3.x ca. 5 Gbit/s.',
      'Zulässig nach Art. 6 Abs. 1 lit. f DSGVO bei berechtigtem Interesse.',
      'Der Wert (siehe oben. Details folgen) bleibt gleich.',
    ]) {
      test('lässt ganz: $s', () {
        expect(splitSentences(s), [s]);
        final blocks = formatCardBack(s);
        expect(blocks, hasLength(1));
        expect(blocks.single.label, isNull);
        expect(blocks.single.text, s);
      });
    }

    test('Ergebnis einer Rechnung beendet den Satz, Ordnungszahl nicht', () {
      expect(splitSentences('Dann ist FP = 1. Vorgänge folgen.'), hasLength(2));
      expect(splitSentences('Das gilt ab dem 1. Januar.'), hasLength(1));
      // Einheit hinter einer Zahl beendet den Satz, „S. 1“ im Gesetz nicht.
      expect(
        splitSentences('Das dauert 85,9 s. Danach folgt B.'),
        hasLength(2),
      );
      expect(
        splitSentences('Nach § 5 Abs. 2 S. 1 BGB gilt das.'),
        hasLength(1),
      );
    });
  });

  group('Gliederung', () {
    test('kurze Antwort bleibt ein Block ohne Stichwort', () {
      const s =
          'Er verliert seinen Inhalt ohne Strom. Dauerhaft gespeichert wird '
          'auf SSD oder Festplatte.';
      final blocks = formatCardBack(s);
      expect(blocks, hasLength(1));
      expect(blocks.single.plain, s);
      expect(blocks.single.formula, isFalse);
    });

    test('zwei Stichwort-Sätze bekommen je einen Absatz', () {
      final blocks = formatCardBack(
        'Textform (§ 126b BGB): lesbare Erklärung mit Namen, z. B. E-Mail. '
        'Schriftform (§ 126): eigenhändige Unterschrift.',
      );
      expect(blocks.map((b) => b.label), [
        'Textform (§ 126b BGB):',
        'Schriftform (§ 126):',
      ]);
      expect(blocks.first.text, 'lesbare Erklärung mit Namen, z. B. E-Mail.');
    });

    test('ein einzelner Doppelpunkt-Satz ist kein Stichwort', () {
      const s =
          'Nichts: USB-C ist nur die Steckerform. Dahinter kann USB 2.0 '
          '(480 Mbit/s) bis USB4 (40 Gbit/s) stecken.';
      final blocks = formatCardBack(s);
      expect(blocks, hasLength(1));
      expect(blocks.single.label, isNull);
    });

    test('Stichwortliste mit Semikolon wird geteilt', () {
      final blocks = formatCardBack(
        'Hub: Schicht 1; Switch: Schicht 2; Router: Schicht 3.',
      );
      expect(blocks.map((b) => b.label), ['Hub:', 'Switch:', 'Router:']);
      expect(blocks.map((b) => b.text), [
        'Schicht 1;',
        'Schicht 2;',
        'Schicht 3.',
      ]);
    });

    test('Semikolon ohne Stichwörter bleibt zusammen', () {
      const s = 'Der Vertrag bleibt bestehen; statt der Klausel gilt § 306.';
      expect(formatCardBack(s).single.text, s);
    });

    test('Rechenweg wird als Formel erkannt', () {
      final a = formatCardBack('60 / (15 × 0,8) = 60 / 12 = 5 Personen.');
      expect(a.single.formula, isTrue);
      final b = formatCardBack(
        '(20 - 5) × 0,8 = 12 PT. Erst den Urlaub abziehen, dann '
        'multiplizieren.',
      );
      expect(b.map((x) => x.formula), [true, false]);
      expect(
        isFormula('Vorgänge auf dem kritischen Pfad haben GP = 0.'),
        isFalse,
      );
      expect(isFormula('Personen = Aufwand / (Dauer × Verfügbarkeit).'), true);
    });

    test('Beispiel und Merke beginnen einen eigenen Absatz', () {
      final blocks = formatCardBack(
        'Der Puffer zeigt den Spielraum eines Vorgangs. Beispiel: SAZ 6, '
        'FAZ 4 ergibt zwei Tage. Merke: Erst vorwärts, dann rückwärts.',
      );
      expect(blocks.map((b) => b.label), [null, 'Beispiel:', 'Merke:']);
    });

    test('lange Antwort wird an Satzgrenzen geteilt', () {
      final s = List.filled(
        6,
        'Dieser Satz ist ein ganz gewöhnlicher Satz ohne Besonderheiten.',
      ).join(' ');
      final blocks = formatCardBack(s);
      expect(blocks.length, inInclusiveRange(2, 3));
      expect(blocks.every((b) => b.label == null && !b.formula), isTrue);
      expect(_joined(blocks), s);
    });
  });

  group('Alle echten Karten', () {
    test('Gliederung verliert und verändert keinen Text', () {
      var structured = 0;
      for (final c in kSeedFlashcards) {
        final blocks = formatCardBack(c.back);
        expect(blocks, isNotEmpty, reason: c.id);
        expect(_squash(_joined(blocks)), _squash(c.back), reason: c.id);
        for (final b in blocks) {
          expect(b.text.trim(), isNotEmpty, reason: c.id);
        }
        if (blocks.length > 1 || blocks.first.formula) structured++;
      }
      // Die meisten Karten sind kurz und bleiben, wie sie sind.
      expect(structured, lessThan(kSeedFlashcards.length * 0.5));
      expect(structured, greaterThan(50));
    });

    test('Stichprobe zur Sichtprüfung', () {
      final structured = [
        for (final c in kSeedFlashcards)
          if (formatCardBack(c.back).length > 1 ||
              formatCardBack(c.back).first.formula)
            c,
      ];
      // Mehr sehen: --dart-define=CARD_SAMPLE=5000 gibt alle aus.
      const sample = int.fromEnvironment('CARD_SAMPLE', defaultValue: 60);
      final step = (structured.length / sample).ceil().clamp(1, 1 << 20);
      final out = StringBuffer(
        '${structured.length} von ${kSeedFlashcards.length} Karten gegliedert\n',
      );
      for (var i = 0; i < structured.length; i += step) {
        final c = structured[i];
        out.writeln('--- ${c.id}: ${c.front}');
        for (final b in formatCardBack(c.back)) {
          out.writeln('    | $b');
        }
      }
      // ignore: avoid_print
      print(out);
    });
  });
}
