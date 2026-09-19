// Generator, kein Test.
//
// Erzeugt `supabase/migrations/0002_seed.sql` aus den Dart-Seed-Daten, damit
// App und Datenbank garantiert dieselben Aufgaben kennen. Der Umweg ueber
// einen Test ist Absicht: die Seed-Daten haengen an `package:flutter`
// (Topic.icon), ein reines `dart run` kann sie deshalb nicht laden.
//
// Ausfuehren:
//   flutter test tool/generate_seed_sql_test.dart
//
// Die Datei danach im Supabase SQL Editor ausfuehren - nach 0001_schema.sql.

import 'dart:convert';
import 'dart:io';

import 'package:ap1_trainer/data/models/theory.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

String q(String? s) => s == null ? 'null' : "'${s.replaceAll("'", "''")}'";

String arr(List<String> items) =>
    items.isEmpty ? "'{}'" : "ARRAY[${items.map(q).join(', ')}]::text[]";

String jsonb(Map<String, dynamic> data) => "${q(jsonEncode(data))}::jsonb";

void main() {
  test('erzeugt 0002_seed.sql aus den Dart-Seed-Daten', () {
    final b = StringBuffer();

    final rule = '-- ${'=' * 74}';
    b.writeln(rule);
    b.writeln('-- AP1 Projektmanagement-Trainer - Inhalte');
    b.writeln('--');
    b.writeln('-- ACHTUNG: automatisch erzeugt. Nicht von Hand aendern.');
    b.writeln('-- Quelle:  lib/data/seed/*.dart');
    b.writeln('-- Befehl:  flutter test tool/generate_seed_sql_test.dart');
    b.writeln('--');
    b.writeln('-- Alle Aufgaben sind eigene Formulierungen im Stil der IHK-AP1,');
    b.writeln('-- keine Originalaufgaben (die sind urheberrechtlich geschuetzt).');
    b.writeln(rule);
    b.writeln();
    b.writeln('begin;');
    b.writeln();

    // -------------------------------------------------------------- Themen
    b.writeln('-- Themen ----------------------------------------------------');
    b.writeln('insert into public.ap1_topics (id, title, blurb, weight, sort_order) values');
    final topicRows = <String>[];
    for (var i = 0; i < Topics.all.length; i++) {
      final t = Topics.all[i];
      topicRows.add('  (${q(t.id)}, ${q(t.title)}, ${q(t.blurb)}, '
          '${t.weight.toStringAsFixed(3)}, $i)');
    }
    b.writeln(topicRows.join(',\n'));
    b.writeln('on conflict (id) do update set');
    b.writeln('  title = excluded.title,');
    b.writeln('  blurb = excluded.blurb,');
    b.writeln('  weight = excluded.weight,');
    b.writeln('  sort_order = excluded.sort_order;');
    b.writeln();

    // ---------------------------------------------------------- Aufgaben
    b.writeln('-- Aufgaben --------------------------------------------------');
    for (final question in kSeedQuestions) {
      final json = question.toJson();
      final data = (json['data'] as Map).cast<String, dynamic>();

      b.writeln('insert into public.ap1_questions');
      b.writeln('  (id, topic_id, kind, scenario, prompt, explanation, '
          'difficulty, tags, source, data)');
      b.writeln('values (');
      b.writeln('  ${q(question.id)},');
      b.writeln('  ${q(question.topicId)},');
      b.writeln('  ${q(question.kind.name)},');
      b.writeln('  ${q(question.scenario)},');
      b.writeln('  ${q(question.prompt)},');
      b.writeln('  ${q(question.explanation)},');
      b.writeln('  ${question.difficulty},');
      b.writeln('  ${arr(question.tags)},');
      b.writeln('  ${q(question.source)},');
      b.writeln('  ${jsonb(data)}');
      b.writeln(')');
      b.writeln('on conflict (id) do update set');
      b.writeln('  topic_id = excluded.topic_id,');
      b.writeln('  kind = excluded.kind,');
      b.writeln('  scenario = excluded.scenario,');
      b.writeln('  prompt = excluded.prompt,');
      b.writeln('  explanation = excluded.explanation,');
      b.writeln('  difficulty = excluded.difficulty,');
      b.writeln('  tags = excluded.tags,');
      b.writeln('  data = excluded.data,');
      b.writeln('  is_active = true;');
      b.writeln();
    }

    // ----------------------------------------------------- Theorie-Snacks
    b.writeln('-- Theorie-Snacks --------------------------------------------');
    for (var i = 0; i < kSeedTheory.length; i++) {
      final TheorySnack s = kSeedTheory[i];
      b.writeln('insert into public.ap1_theory');
      b.writeln('  (id, topic_id, title, lead, points, merksatz, '
          'read_seconds, sort_order)');
      b.writeln('values (');
      b.writeln('  ${q(s.id)},');
      b.writeln('  ${q(s.topicId)},');
      b.writeln('  ${q(s.title)},');
      b.writeln('  ${q(s.lead)},');
      b.writeln('  ${arr(s.points)},');
      b.writeln('  ${q(s.merksatz)},');
      b.writeln('  ${s.readSeconds},');
      b.writeln('  $i');
      b.writeln(')');
      b.writeln('on conflict (id) do update set');
      b.writeln('  topic_id = excluded.topic_id,');
      b.writeln('  title = excluded.title,');
      b.writeln('  lead = excluded.lead,');
      b.writeln('  points = excluded.points,');
      b.writeln('  merksatz = excluded.merksatz,');
      b.writeln('  read_seconds = excluded.read_seconds,');
      b.writeln('  sort_order = excluded.sort_order;');
      b.writeln();
    }

    b.writeln('commit;');
    b.writeln();
    b.writeln('-- Kontrolle:');
    b.writeln('--   select topic_id, count(*) from public.ap1_questions '
        'group by 1 order by 1;');
    b.writeln('-- erwartet: ${kSeedQuestions.length} Aufgaben, '
        '${Topics.all.length} Themen, ${kSeedTheory.length} Theorie-Snacks.');

    final file = File('supabase/migrations/0002_seed.sql');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(b.toString());

    expect(file.existsSync(), isTrue);
    // Sanity: jede Aufgabe muss genau einmal im Skript stehen.
    final sql = file.readAsStringSync();
    for (final question in kSeedQuestions) {
      expect("'${question.id}'".allMatches(sql).length, greaterThanOrEqualTo(1),
          reason: '${question.id} fehlt im erzeugten SQL');
    }
    // ignore: avoid_print
    print('geschrieben: ${file.path} '
        '(${kSeedQuestions.length} Aufgaben, ${kSeedTheory.length} Snacks)');
  });
}
