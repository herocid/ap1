import 'package:ap1_trainer/data/models/netzplan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetzplanSolver', () {
    test('Vorwärtsrechnung nimmt das Maximum der Vorgänger', () {
      final sol = NetzplanSolver.solve(const [
        Activity(id: 'A', name: 'A', duration: 4),
        Activity(id: 'B', name: 'B', duration: 3, predecessors: ['A']),
        Activity(id: 'C', name: 'C', duration: 6, predecessors: ['A']),
        Activity(id: 'D', name: 'D', duration: 5, predecessors: ['B']),
        Activity(id: 'E', name: 'E', duration: 2, predecessors: ['C', 'D']),
      ]);

      expect(sol.nodes['A']!.faz, 0);
      expect(sol.nodes['A']!.fez, 4);
      expect(sol.nodes['C']!.fez, 10);
      expect(sol.nodes['D']!.fez, 12);
      // E hängt an C (10) und D (12) -> Maximum, nicht Minimum.
      expect(sol.nodes['E']!.faz, 12);
      expect(sol.projectDuration, 14);
      expect(sol.criticalPath, ['A', 'B', 'D', 'E']);
    });

    test('unterscheidet Gesamtpuffer und freien Puffer korrekt', () {
      final sol = NetzplanSolver.solve(const [
        Activity(id: 'A', name: 'A', duration: 3),
        Activity(id: 'B', name: 'B', duration: 5, predecessors: ['A']),
        Activity(id: 'C', name: 'C', duration: 2, predecessors: ['A']),
        Activity(id: 'D', name: 'D', duration: 4, predecessors: ['B']),
        Activity(id: 'E', name: 'E', duration: 6, predecessors: ['C']),
        Activity(id: 'F', name: 'F', duration: 3, predecessors: ['D', 'E']),
      ]);

      expect(sol.projectDuration, 15);
      // C hat Luft bis zum Projektende, aber keine gegenüber dem Nachfolger.
      expect(sol.nodes['C']!.gp, 1);
      expect(sol.nodes['C']!.fp, 0);
      expect(sol.nodes['E']!.gp, 1);
      expect(sol.nodes['E']!.fp, 1);
      expect(sol.criticalPath, ['A', 'B', 'D', 'F']);
    });

    test('siebenteiliger Plan: Puffer und kritischer Pfad', () {
      final sol = NetzplanSolver.solve(const [
        Activity(id: 'A', name: 'A', duration: 2),
        Activity(id: 'B', name: 'B', duration: 4, predecessors: ['A']),
        Activity(id: 'C', name: 'C', duration: 6, predecessors: ['A']),
        Activity(id: 'D', name: 'D', duration: 3, predecessors: ['B']),
        Activity(id: 'E', name: 'E', duration: 2, predecessors: ['B']),
        Activity(id: 'F', name: 'F', duration: 4, predecessors: ['D', 'C']),
        Activity(id: 'G', name: 'G', duration: 3, predecessors: ['E', 'F']),
      ]);

      expect(sol.projectDuration, 16);
      expect(sol.nodes['C']!.gp, 1);
      expect(sol.nodes['E']!.gp, 5);
      expect(sol.nodes['E']!.fp, 5);
      expect(sol.criticalPath, ['A', 'B', 'D', 'F', 'G']);
    });

    test('GP ist über beide Formeln identisch', () {
      final sol = NetzplanSolver.solve(const [
        Activity(id: 'A', name: 'A', duration: 2),
        Activity(id: 'B', name: 'B', duration: 4, predecessors: ['A']),
        Activity(id: 'C', name: 'C', duration: 3, predecessors: ['A']),
        Activity(id: 'D', name: 'D', duration: 5, predecessors: ['B']),
        Activity(id: 'E', name: 'E', duration: 2, predecessors: ['C']),
        Activity(id: 'F', name: 'F', duration: 1, predecessors: ['D', 'E']),
      ]);

      for (final n in sol.nodes.values) {
        expect(n.gp, n.saz - n.faz);
        expect(n.gp, n.sez - n.fez, reason: 'GP = SEZ - FEZ muss gelten');
        expect(n.fp, lessThanOrEqualTo(n.gp),
            reason: 'Der freie Puffer ist nie größer als der Gesamtpuffer');
      }
      expect(sol.nodes['C']!.gp, 4);
    });

    test('mehrere Startvorgänge, längster Weg gewinnt', () {
      final sol = NetzplanSolver.solve(const [
        Activity(id: 'A', name: 'A', duration: 5),
        Activity(id: 'B', name: 'B', duration: 3),
        Activity(id: 'C', name: 'C', duration: 4, predecessors: ['A', 'B']),
        Activity(id: 'D', name: 'D', duration: 6, predecessors: ['A']),
        Activity(id: 'E', name: 'E', duration: 2, predecessors: ['C', 'D']),
      ]);
      expect(sol.projectDuration, 13);
      expect(sol.criticalPath, ['A', 'D', 'E']);
    });

    test('ein Zyklus wirft keine Exception', () {
      final sol = NetzplanSolver.solve(const [
        Activity(id: 'A', name: 'A', duration: 2, predecessors: ['B']),
        Activity(id: 'B', name: 'B', duration: 2, predecessors: ['A']),
      ]);
      expect(sol.nodes.length, 2);
    });
  });
}
