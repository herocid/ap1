import 'package:ap1_trainer/data/models/question_parts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stichworterkennung im Freitext', () {
    const c = Criterion(
      'Die Daten werden verschlüsselt übertragen.',
      keywords: ['Verschlüsselung', 'TLS', 'öffentlicher Schlüssel'],
    );

    test('erkennt Wortformen', () {
      expect(c.foundIn('Die Daten sind verschlüsselt.'), isTrue);
      expect(c.foundIn('man verschluesselt die Verbindung'), isTrue);
    });

    test('erkennt einzelne Tippfehler', () {
      expect(c.foundIn('Verschlüsslung der Daten'), isTrue);
    });

    test('erkennt mehrteilige Stichwörter in anderer Stellung', () {
      expect(c.foundIn('mit dem Schlüssel, der öffentlich ist'), isTrue);
    });

    test('kurze Stichwörter nur exakt', () {
      expect(c.foundIn('per TLS gesichert'), isTrue);
      expect(c.foundIn('per TLP gesichert'), isFalse);
    });

    test('erkennt nichts in leeren oder fremden Antworten', () {
      expect(c.foundIn(''), isFalse);
      expect(c.foundIn('Das Kabel wird getauscht.'), isFalse);
    });
  });

  group('Lücken', () {
    test('Text: Schreibweise egal', () {
      const g = Blank(['Layer-2-Switch', 'Switch']);
      expect(g.matches(' switch '), isTrue);
      expect(g.matches('layer 2 switch'), isTrue);
      expect(g.matches('Router'), isFalse);
    });

    test('Zahl: deutsche und englische Schreibweise, Toleranz', () {
      final g = Blank.zahl(1234.5, tolerance: 0.1);
      expect(g.matches('1.234,5'), isTrue);
      expect(g.matches('1234.55 €'), isTrue);
      expect(g.matches('1235'), isFalse);
      expect(g.matches(''), isFalse);
    });
  });
}
