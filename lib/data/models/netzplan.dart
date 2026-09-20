import 'package:flutter/foundation.dart';

/// Ein Vorgang im Netzplan (Vorgangsknoten-Netzplan / MPM, so wie er in der
/// AP1 drankommt).
@immutable
class Activity {
  const Activity({
    required this.id,
    required this.name,
    required this.duration,
    this.predecessors = const [],
  });

  /// Kurzkennung, in Aufgaben typischerweise "A".."H" oder "1".."9".
  final String id;
  final String name;
  final int duration;
  final List<String> predecessors;

  factory Activity.fromJson(Map<String, dynamic> j) => Activity(
        id: j['id'] as String,
        name: (j['name'] ?? '') as String,
        duration: (j['duration'] as num).toInt(),
        predecessors:
            ((j['predecessors'] as List?) ?? const []).cast<String>().toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'duration': duration,
        'predecessors': predecessors,
      };
}

/// Die sechs Werte, die pro Knoten gefragt werden können.
enum NodeField {
  faz('FAZ', 'Frühester Anfangszeitpunkt'),
  fez('FEZ', 'Frühester Endzeitpunkt'),
  saz('SAZ', 'Spätester Anfangszeitpunkt'),
  sez('SEZ', 'Spätester Endzeitpunkt'),
  gp('GP', 'Gesamtpuffer'),
  fp('FP', 'Freier Puffer');

  const NodeField(this.short, this.long);
  final String short;
  final String long;
}

@immutable
class NodeResult {
  const NodeResult({
    required this.id,
    required this.faz,
    required this.fez,
    required this.saz,
    required this.sez,
    required this.gp,
    required this.fp,
  });

  final String id;
  final int faz;
  final int fez;
  final int saz;
  final int sez;
  final int gp;
  final int fp;

  bool get isCritical => gp == 0;

  int value(NodeField f) => switch (f) {
        NodeField.faz => faz,
        NodeField.fez => fez,
        NodeField.saz => saz,
        NodeField.sez => sez,
        NodeField.gp => gp,
        NodeField.fp => fp,
      };
}

@immutable
class NetzplanSolution {
  const NetzplanSolution({
    required this.nodes,
    required this.projectDuration,
    required this.criticalPath,
  });

  final Map<String, NodeResult> nodes;
  final int projectDuration;

  /// Die kritischen Vorgänge in topologischer Reihenfolge.
  final List<String> criticalPath;
}

/// Löst einen Vorgangsknoten-Netzplan per Vorwärts- und Rückwärtsrechnung.
///
/// Konvention (wie in der AP1 üblich, nullbasiert):
///   FAZ(Start) = 0
///   FEZ = FAZ + Dauer
///   FAZ = max(FEZ aller Vorgänger)
///   SEZ(Ende) = Projektdauer,  SEZ = min(SAZ aller Nachfolger)
///   SAZ = SEZ - Dauer
///   GP  = SAZ - FAZ
///   FP  = min(FAZ aller Nachfolger) - FEZ   (ohne Nachfolger: Projektende - FEZ)
class NetzplanSolver {
  const NetzplanSolver._();

  static NetzplanSolution solve(List<Activity> activities) {
    final byId = {for (final a in activities) a.id: a};
    final successors = <String, List<String>>{
      for (final a in activities) a.id: <String>[],
    };
    for (final a in activities) {
      for (final p in a.predecessors) {
        successors[p]?.add(a.id);
      }
    }

    final order = _topologicalOrder(activities, successors);

    // Vorwärtsrechnung
    final faz = <String, int>{};
    final fez = <String, int>{};
    for (final id in order) {
      final a = byId[id]!;
      final preds = a.predecessors.where(byId.containsKey);
      faz[id] = preds.isEmpty
          ? 0
          : preds.map((p) => fez[p] ?? 0).reduce((x, y) => x > y ? x : y);
      fez[id] = faz[id]! + a.duration;
    }

    final projectDuration =
        fez.values.isEmpty ? 0 : fez.values.reduce((x, y) => x > y ? x : y);

    // Rückwärtsrechnung
    final saz = <String, int>{};
    final sez = <String, int>{};
    for (final id in order.reversed) {
      final a = byId[id]!;
      // Bei fehlerhaften Daten (Zyklus) kann ein Nachfolger noch unberechnet
      // sein - dann zählt er als unkritisch, statt die Rechnung abzubrechen.
      final succs =
          successors[id]!.where((s) => saz.containsKey(s)).toList();
      sez[id] = succs.isEmpty
          ? projectDuration
          : succs.map((s) => saz[s]!).reduce((x, y) => x < y ? x : y);
      saz[id] = sez[id]! - a.duration;
    }

    final nodes = <String, NodeResult>{};
    for (final a in activities) {
      final succs = successors[a.id]!;
      final freeFloat = succs.isEmpty
          ? projectDuration - fez[a.id]!
          : succs.map((s) => faz[s]!).reduce((x, y) => x < y ? x : y) -
              fez[a.id]!;
      nodes[a.id] = NodeResult(
        id: a.id,
        faz: faz[a.id]!,
        fez: fez[a.id]!,
        saz: saz[a.id]!,
        sez: sez[a.id]!,
        gp: saz[a.id]! - faz[a.id]!,
        fp: freeFloat,
      );
    }

    final criticalPath =
        order.where((id) => nodes[id]!.isCritical).toList(growable: false);

    return NetzplanSolution(
      nodes: nodes,
      projectDuration: projectDuration,
      criticalPath: criticalPath,
    );
  }

  /// Kahn-Algorithmus. Bei einem Zyklus (fehlerhafte Aufgabendaten) werden die
  /// verbleibenden Knoten hinten angehängt, statt eine Exception zu werfen -
  /// eine kaputte Aufgabe soll die Lern-Session nicht abschießen.
  static List<String> _topologicalOrder(
    List<Activity> activities,
    Map<String, List<String>> successors,
  ) {
    final ids = activities.map((a) => a.id).toSet();
    final indegree = <String, int>{for (final a in activities) a.id: 0};
    for (final a in activities) {
      indegree[a.id] = a.predecessors.where(ids.contains).length;
    }

    final queue = <String>[
      for (final a in activities)
        if (indegree[a.id] == 0) a.id,
    ];
    final order = <String>[];
    while (queue.isNotEmpty) {
      final id = queue.removeAt(0);
      order.add(id);
      for (final s in successors[id] ?? const <String>[]) {
        indegree[s] = indegree[s]! - 1;
        if (indegree[s] == 0) queue.add(s);
      }
    }
    if (order.length != activities.length) {
      order.addAll(ids.where((id) => !order.contains(id)));
    }
    return order;
  }
}
