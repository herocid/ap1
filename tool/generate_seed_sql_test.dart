// Generator, kein Test.
//
// Erzeugt die Seed-Migration aus den Dart-Seed-Daten, damit App und Datenbank
// garantiert dieselben Inhalte kennen. Der Umweg über einen Test ist
// Absicht: die Seed-Daten hängen an `package:flutter` (Topic.icon), ein
// reines `dart run` kann sie deshalb nicht laden.
//
// Ausführen:
//   flutter test tool/generate_seed_sql_test.dart
//
// Danach: `npx supabase db push` oder die Datei im Supabase-SQL-Editor
// ausführen - in beiden Fällen nach den Schema-Migrationen.

import 'dart:convert';
import 'dart:io';

import 'package:ap1_trainer/data/models/exam_area.dart';
import 'package:ap1_trainer/data/models/topic.dart';
import 'package:ap1_trainer/data/seed/seed_data.dart';
import 'package:flutter_test/flutter_test.dart';

const _outPath = 'supabase/migrations/20260920090100_ap1_seed.sql';

String q(String? s) => s == null ? 'null' : "'${s.replaceAll("'", "''")}'";

String arr(List<String> items) =>
    items.isEmpty ? "'{}'" : "ARRAY[${items.map(q).join(', ')}]::text[]";

String jsonb(Map<String, dynamic> data) => "${q(jsonEncode(data))}::jsonb";

void main() {
  test('erzeugt die Seed-Migration aus den Dart-Seed-Daten', () {
    final b = StringBuffer();
    final rule = '-- ${'=' * 74}';

    b.writeln(rule);
    b.writeln('-- AP1-Trainer - Inhalte');
    b.writeln('--');
    b.writeln('-- ACHTUNG: automatisch erzeugt. Nicht von Hand aendern.');
    b.writeln('-- Quelle:  lib/data/seed/');
    b.writeln('-- Befehl:  flutter test tool/generate_seed_sql_test.dart');
    b.writeln('--');
    b.writeln('-- Alle Aufgaben und Karten sind eigene Formulierungen im Stil');
    b.writeln('-- der IHK-AP1, keine Originalaufgaben (urheberrechtlich');
    b.writeln('-- geschuetzt).');
    b.writeln('--');
    b.writeln('-- Kein explizites begin/commit: sowohl der Supabase-SQL-Editor');
    b.writeln('-- als auch `supabase db push` fuehren ein Skript bereits in');
    b.writeln('-- einer Transaktion aus.');
    b.writeln(rule);
    b.writeln();

    // ------------------------------------------------------- Bereiche
    b.writeln('-- Katalogbereiche -------------------------------------------');
    b.writeln('insert into public.ap1_areas '
        '(id, number, title, blurb, weight, sort_order) values');
    b.writeln([
      for (var i = 0; i < ExamAreas.all.length; i++)
        '  (${q(ExamAreas.all[i].id)}, ${q(ExamAreas.all[i].number)}, '
            '${q(ExamAreas.all[i].title)}, ${q(ExamAreas.all[i].blurb)}, '
            '${ExamAreas.all[i].weight.toStringAsFixed(3)}, $i)',
    ].join(',\n'));
    b.writeln('on conflict (id) do update set');
    b.writeln('  number = excluded.number,');
    b.writeln('  title = excluded.title,');
    b.writeln('  blurb = excluded.blurb,');
    b.writeln('  weight = excluded.weight,');
    b.writeln('  sort_order = excluded.sort_order;');
    b.writeln();

    // --------------------------------------------------------- Themen
    b.writeln('-- Themen ----------------------------------------------------');
    b.writeln('insert into public.ap1_topics '
        '(id, area_id, title, blurb, weight, sort_order) values');
    b.writeln([
      for (var i = 0; i < Topics.all.length; i++)
        '  (${q(Topics.all[i].id)}, ${q(Topics.all[i].areaId)}, '
            '${q(Topics.all[i].title)}, ${q(Topics.all[i].blurb)}, '
            '${Topics.all[i].weight.toStringAsFixed(3)}, $i)',
    ].join(',\n'));
    b.writeln('on conflict (id) do update set');
    b.writeln('  area_id = excluded.area_id,');
    b.writeln('  title = excluded.title,');
    b.writeln('  blurb = excluded.blurb,');
    b.writeln('  weight = excluded.weight,');
    b.writeln('  sort_order = excluded.sort_order;');
    b.writeln();

    // ------------------------------------------------------- Aufgaben
    b.writeln('-- Aufgaben --------------------------------------------------');
    for (final question in kSeedQuestions) {
      final data =
          (question.toJson()['data'] as Map).cast<String, dynamic>();
      b.writeln('insert into public.ap1_questions');
      b.writeln('  (id, topic_id, kind, scenario, prompt, explanation, '
          'difficulty, tags, source, data, catalog_status)');
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
      b.writeln('  ${jsonb(data)},');
      b.writeln('  ${q(question.catalogStatus.name)}');
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
      b.writeln('  catalog_status = excluded.catalog_status,');
      b.writeln('  is_active = true;');
      b.writeln();
    }

    // ---------------------------------------------------- Karteikarten
    b.writeln('-- Karteikarten ----------------------------------------------');
    for (var i = 0; i < kSeedFlashcards.length; i++) {
      final c = kSeedFlashcards[i];
      b.writeln('insert into public.ap1_flashcards');
      b.writeln('  (id, topic_id, front, back, hint, tags, sort_order)');
      b.writeln('values (${q(c.id)}, ${q(c.topicId)}, ${q(c.front)}, '
          '${q(c.back)}, ${q(c.hint)}, ${arr(c.tags)}, $i)');
      b.writeln('on conflict (id) do update set');
      b.writeln('  topic_id = excluded.topic_id,');
      b.writeln('  front = excluded.front,');
      b.writeln('  back = excluded.back,');
      b.writeln('  hint = excluded.hint,');
      b.writeln('  tags = excluded.tags,');
      b.writeln('  sort_order = excluded.sort_order,');
      b.writeln('  is_active = true;');
      b.writeln();
    }

    // -------------------------------------------------- Theorie-Snacks
    b.writeln('-- Theorie-Snacks --------------------------------------------');
    for (var i = 0; i < kSeedTheory.length; i++) {
      final s = kSeedTheory[i];
      b.writeln('insert into public.ap1_theory');
      b.writeln('  (id, topic_id, title, lead, points, merksatz, '
          'read_seconds, sort_order)');
      b.writeln('values (${q(s.id)}, ${q(s.topicId)}, ${q(s.title)}, '
          '${q(s.lead)}, ${arr(s.points)}, ${q(s.merksatz)}, '
          '${s.readSeconds}, $i)');
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

    b.writeln('-- Kontrolle:');
    b.writeln('--   select count(*) from public.ap1_questions '
        "where catalog_status = 'current';");
    b.writeln('-- erwartet: ${ExamAreas.all.length} Bereiche, '
        '${Topics.all.length} Themen, '
        '${kExamRelevantQuestions.length} aktive Aufgaben '
        '(${kSeedQuestions.length} gesamt), '
        '${kSeedFlashcards.length} Karten, '
        '${kSeedTheory.length} Theorie-Snacks.');

    final file = File(_outPath);
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(b.toString());

    final sql = file.readAsStringSync();
    for (final question in kSeedQuestions) {
      expect("'${question.id}'".allMatches(sql), isNotEmpty,
          reason: '${question.id} fehlt im erzeugten SQL');
    }
    for (final c in kSeedFlashcards) {
      expect("'${c.id}'".allMatches(sql), isNotEmpty,
          reason: '${c.id} fehlt im erzeugten SQL');
    }
    // ignore: avoid_print
    print('geschrieben: $_outPath (${kSeedQuestions.length} Aufgaben, '
        '${kSeedFlashcards.length} Karten, ${kSeedTheory.length} Snacks)');
  });
}
