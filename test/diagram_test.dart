import 'package:ap1_trainer/data/models/diagram.dart';
import 'package:ap1_trainer/data/models/netzplan.dart';
import 'package:ap1_trainer/data/seed/nuggets/nuggets_data.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

/// Prüft jede Zeichnung in Lernschritten und Aufgaben auf innere
/// Stimmigkeit - ein falscher Index oder ein unbekannter Entitätsname
/// fiele sonst erst beim Anschauen auf.
void main() {
  final all = <String, Diagram>{
    for (final n in kSeedNuggets)
      if (n.diagram != null) n.id: n.diagram!,
    for (final q in kSeedQuestions)
      if (q.diagram != null) q.id: q.diagram!,
  };

  test('JSON-Roundtrip jeder Zeichnung', () {
    for (final e in all.entries) {
      final back = Diagram.fromJson(e.value.toJson());
      expect(back, isNotNull, reason: e.key);
      expect(back!.toJson(), e.value.toJson(), reason: e.key);
    }
  });

  test('Zeichnungen sind in sich stimmig', () {
    final errors = <String>[];
    void check(bool ok, String id, String msg) {
      if (!ok) errors.add('$id: $msg');
    }

    for (final MapEntry(key: id, value: d) in all.entries) {
      switch (d) {
        case StapelDiagramm():
          check(d.ebenen.length >= 2, id, 'Stapel mit weniger als 2 Ebenen');
        case FlussDiagramm():
          check(d.knoten.length >= 2, id, 'Fluss mit weniger als 2 Knoten');
        case BaumDiagramm():
          check(d.wurzel.kinder.isNotEmpty, id, 'Baum ohne Kinder');
        case SequenzDiagramm():
          check(
            d.teilnehmer.length >= 2 && d.teilnehmer.length <= 4,
            id,
            'Sequenz braucht 2-4 Teilnehmer',
          );
          for (final n in d.nachrichten) {
            check(
              n.von >= 0 && n.von < d.teilnehmer.length,
              id,
              'Nachricht "${n.text}": von ${n.von} ungültig',
            );
            check(
              n.an >= 0 && n.an < d.teilnehmer.length,
              id,
              'Nachricht "${n.text}": an ${n.an} ungültig',
            );
            check(n.von != n.an, id, 'Nachricht "${n.text}" an sich selbst');
          }
        case QuadrantenDiagramm():
          break;
        case BalkenDiagramm():
          check(d.balken.isNotEmpty, id, 'Balkendiagramm ohne Balken');
          for (final b in d.balken) {
            check(b.wert >= 0, id, 'Balken "${b.label}" negativ');
            check(
              d.max == null || b.wert <= d.max!,
              id,
              'Balken "${b.label}" über max',
            );
          }
        case GanttDiagramm():
          check(d.vorgaenge.isNotEmpty, id, 'Gantt ohne Vorgänge');
          for (final v in d.vorgaenge) {
            check(v.start >= 0 && v.dauer >= 0, id, 'Gantt "${v.label}"');
          }
        case GeradenDiagramm():
          check(d.xMax > 0 && d.yMax > 0, id, 'Achsen ohne Länge');
          check(d.geraden.isNotEmpty, id, 'keine Geraden');
          for (final p in d.punkte) {
            check(
              p.x >= 0 && p.x <= d.xMax && p.y >= 0 && p.y <= d.yMax,
              id,
              'Punkt "${p.label}" außerhalb',
            );
          }
        case KlassenDiagramm():
          check(d.klassen.isNotEmpty, id, 'Klassendiagramm ohne Klassen');
          for (final b in d.beziehungen) {
            check(
              b.von >= 0 && b.von < d.klassen.length,
              id,
              'Beziehung von ${b.von} ungültig',
            );
            check(
              b.zu >= 0 && b.zu < d.klassen.length,
              id,
              'Beziehung zu ${b.zu} ungültig',
            );
            check(b.von != b.zu, id, 'Beziehung auf sich selbst');
          }
        case ErmDiagramm():
          final names = d.entitaeten.map((e) => e.name).toSet();
          check(
            names.length == d.entitaeten.length,
            id,
            'Entitätsnamen doppelt',
          );
          for (final e in d.entitaeten) {
            for (final k in e.schluessel) {
              check(
                e.attribute.contains(k),
                id,
                '${e.name}: Schlüssel $k fehlt in den Attributen',
              );
            }
          }
          for (final b in d.beziehungen) {
            check(names.contains(b.a), id, 'ERM: unbekannte Entität ${b.a}');
            check(names.contains(b.b), id, 'ERM: unbekannte Entität ${b.b}');
          }
        case UseCaseDiagramm():
          check(
            d.faelle.isNotEmpty && d.akteure.isNotEmpty,
            id,
            'Use Case ohne Fälle oder Akteure',
          );
          for (final a in d.akteure) {
            for (final i in a.faelle) {
              check(
                i >= 0 && i < d.faelle.length,
                id,
                'Akteur ${a.name}: Fall $i ungültig',
              );
            }
          }
          for (final b in d.beziehungen) {
            check(
              b.von >= 0 &&
                  b.von < d.faelle.length &&
                  b.zu >= 0 &&
                  b.zu < d.faelle.length &&
                  b.von != b.zu,
              id,
              'include/extend ${b.von}->${b.zu} ungültig',
            );
          }
        case NetzSkizze():
          final ids = d.knoten.map((k) => k.id).toSet();
          check(ids.length == d.knoten.length, id, 'Knoten-IDs doppelt');
          for (final v in d.verbindungen) {
            check(
              ids.contains(v.a) && ids.contains(v.b),
              id,
              'Verbindung ${v.a}-${v.b}: unbekannter Knoten',
            );
          }
          for (final k in d.knoten) {
            check(
              k.x >= 0 && k.x <= 6 && k.y >= 0 && k.y <= 10,
              id,
              'Knoten ${k.id} außerhalb des Rasters (x 0-6, y 0-10)',
            );
          }
        case BitDiagramm():
          for (final z in d.zeilen) {
            check(
              RegExp(r'^[01. ]+$').hasMatch(z.bits),
              id,
              'Bitzeile "${z.label}" enthält andere Zeichen als 0/1/./Leerzeichen',
            );
            final n = z.bits.replaceAll(RegExp('[. ]'), '').length;
            check(
              z.netz == null || (z.netz! >= 0 && z.netz! <= n),
              id,
              'Bitzeile "${z.label}": netz > Bitanzahl',
            );
          }
        case NetzplanDiagramm():
          final ids = d.vorgaenge.map((v) => v.id).toSet();
          check(ids.length == d.vorgaenge.length, id, 'Vorgangs-IDs doppelt');
          for (final v in d.vorgaenge) {
            for (final p in v.predecessors) {
              check(ids.contains(p), id, 'Vorgang ${v.id}: Vorgänger $p fehlt');
            }
          }
          if (errors.isEmpty) NetzplanSolver.solve(d.vorgaenge);
        case NetzplanLegende():
          break;
      }
    }
    expect(errors, isEmpty, reason: errors.join('\n'));
  });
}
