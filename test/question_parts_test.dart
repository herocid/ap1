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

    test('kurze Stichwörter treffen keine längeren Fremdwörter', () {
      const java = Criterion('Java', keywords: ['Java']);
      expect(java.foundIn('Wir nutzen JavaScript im Browser.'), isFalse);
      expect(java.foundIn('Das Backend ist in Java geschrieben.'), isTrue);
      const test = Criterion('Test', keywords: ['Test']);
      expect(test.foundIn('zwei Tests und ein Abnahmetest'), isTrue);
      const port = Criterion('Port 443', keywords: ['443']);
      expect(port.foundIn('Port 8443 ist offen'), isFalse);
      expect(port.foundIn('HTTPS nutzt 443.'), isTrue);
    });

    test('Füllwörter zählen nicht als Stichwort', () {
      const c2 = Criterion('Kein Verzug', keywords: ['nicht', 'Verzug']);
      expect(c2.foundIn('Das weiß ich nicht.'), isFalse);
      expect(c2.foundIn('Der Lieferant ist in Verzug.'), isTrue);
    });

    test('erkennt nichts in leeren oder fremden Antworten', () {
      expect(c.foundIn(''), isFalse);
      expect(c.foundIn('Das Kabel wird getauscht.'), isFalse);
    });
  });

  group('Lücken', () {
    test('Text: Leerzeichen, Operatoren und Klammern egal', () {
      const g = Blank(['[Bestand >= 20]']);
      expect(g.matches('[Bestand>=20]'), isTrue);
      expect(g.matches('Bestand ≥ 20'), isTrue);
      expect(g.matches('[ bestand >= 20 ]'), isTrue);
      expect(g.matches('[Bestand > 20]'), isFalse);
      expect(g.matches('[Bestand <= 20]'), isFalse);
    });

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

    test('Zahl: Tausenderpunkte', () {
      expect(Blank.zahl(1000000).matches('1.000.000'), isTrue);
      expect(Blank.zahl(456976).matches('456.976'), isTrue);
      expect(Blank.zahl(456976).matches('456976'), isTrue);
      expect(Blank.zahl(3.125).matches('3,125'), isTrue);
      expect(Blank.zahl(3.125).matches('3.125'), isTrue);
      expect(Blank.zahl(62).matches('62 Hosts'), isTrue);
    });
  });
}
