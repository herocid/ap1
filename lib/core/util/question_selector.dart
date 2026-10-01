import 'dart:math' as math;

import '../../data/models/progress.dart';
import '../../data/models/question.dart';
import '../../data/models/topic.dart';
import 'answer_format.dart';

/// Wählt aus, welche Aufgaben als nächstes drankommen.
///
/// Statt Zufall: eine Prioritätsformel aus drei Bestandteilen -
/// Fehlerspeicher, Themenschwäche und Wiederholungsabstand. Ziel ist, dass
/// die App genau die Aufgaben zeigt, die den Punktestand in der Prüfung am
/// stärksten bewegen.
///
/// Danach sorgt der Formatmix ([mixFormats], [arrange]) dafür, dass eine
/// Runde der echten Prüfung ähnelt: Auswahlaufgaben bleiben, dominieren
/// aber nicht.
class QuestionSelector {
  const QuestionSelector._();

  /// Höchstanteil von Einfach-/Mehrfachauswahl an einer Runde.
  static const choiceShare = 0.3;

  /// Übungs- und Fokus-Sessions.
  ///
  /// [topicFilter] beschränkt auf ein Thema (Fokus-Training aus dem
  /// Dashboard), [mistakesOnly] zieht ausschließlich aus dem Fehlerspeicher.
  /// [mistakeIds] ersetzt dabei den einfachen Fehlerspeicher
  /// ([ProgressState.openMistakes]) durch eine eigene Liste, z. B. die heute
  /// fälligen Fehler der Wiederholung mit Abstand.
  static List<Question> forPractice({
    required List<Question> pool,
    required ProgressState progress,
    required Map<String, int> poolSize,
    int count = 10,
    String? topicFilter,
    String? subtopicFilter,
    bool mistakesOnly = false,
    Set<String>? mistakeIds,
    int? seed,
  }) {
    final rnd = math.Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final stats = progress.topicStats(poolSize);
    final mistakes = mistakeIds ?? progress.openMistakes;
    final lastSeen = _lastSeenByQuestion(progress);

    var candidates = pool.where((q) {
      // Ab 2025 gestrichene Aufgaben kommen nie in eine Übung. Sie bleiben
      // nur als Nachschlagewerk im Pool.
      if (!q.isExamRelevant) return false;
      if (topicFilter != null && q.topicId != topicFilter) return false;
      if (subtopicFilter != null && q.subtopicId != subtopicFilter) {
        return false;
      }
      if (mistakesOnly && !mistakes.contains(q.id)) return false;
      return true;
    }).toList();

    if (candidates.isEmpty) return const [];

    final now = DateTime.now();
    final scored = candidates.map((q) {
      var score = 0.0;

      // 1. Fehlerspeicher: zuletzt falsch beantwortet. Stärkster Treiber -
      //    was man nicht kann, bringt die meisten Punkte.
      if (mistakes.contains(q.id)) score += 100;

      // 2. Themenschwäche, gewichtet mit dem Prüfungsanteil des Themas.
      //    Ein schwaches Thema mit 18 % Punkteanteil ist dringender als ein
      //    schwaches Thema mit 4 %.
      final st = stats[q.topicId];
      final weakness = 1.0 - (st?.mastery ?? 0.0);
      final weight = Topics.map[q.topicId]?.weight ?? 0.1;
      score += weakness * weight * 200;

      // 3. Noch nie gesehen: klarer Bonus, damit die Abdeckung wächst.
      final seen = lastSeen[q.id];
      if (seen == null) {
        score += 40;
      } else {
        // 4. Wiederholungsabstand: je länger her, desto fälliger.
        //    Deckel bei 30 Tagen, damit alte Aufgaben nicht alles verdrängen.
        final days = now.difference(seen).inDays.clamp(0, 30);
        score += days * 1.5;
      }

      // 5. Schwierigkeit an das Können anpassen: wer im Thema stark ist,
      //    bekommt härtere Aufgaben.
      final mastery = st?.mastery ?? 0.0;
      final wanted = mastery < 0.4 ? 1 : (mastery < 0.75 ? 2 : 3);
      score -= (q.difficulty - wanted).abs() * 12;

      // 6. Etwas Rauschen, damit zwei Sessions hintereinander nicht identisch
      //    aussehen.
      score += rnd.nextDouble() * 15;

      return (q, score);
    }).toList()..sort((a, b) => b.$2.compareTo(a.$2));

    // Die Rangfolge bestimmt weiter, WAS drankommt - der Formatmix nur, in
    // welcher Zusammensetzung. Offene Fehler sind davon ausgenommen: Sie
    // kommen immer, auch wenn es Auswahlaufgaben sind.
    return arrange(
      mixFormats(
        [for (final e in scored) e.$1],
        count: count,
        pinned: mistakes,
      ),
    );
  }

  /// Wählt aus einer nach Priorität sortierten Liste [count] Aufgaben mit
  /// gesundem Formatmix:
  ///
  /// - Auswahlaufgaben (einfach + mehrfach) höchstens rund 30 % - solange
  ///   genug andere Aufgaben da sind,
  /// - je 10 Aufgaben möglichst mindestens eine Rechen-/Tabellenaufgabe und
  ///   eine Freitext-Aufgabe.
  ///
  /// Aufgaben aus [pinned] werden nie verdrängt und unterliegen nicht dem
  /// Deckel. Die Reihenfolge der Rückgabe folgt der Priorität.
  static List<Question> mixFormats(
    List<Question> ranked, {
    required int count,
    Set<String> pinned = const {},
  }) {
    if (count <= 0) return const [];
    final cap = math.max(1, (count * choiceShare).round());
    final selected = <Question>[];
    final rest = <Question>[];
    var choices = 0;
    for (final q in ranked) {
      if (selected.length >= count) {
        rest.add(q);
      } else if (!FormatMix.isChoice(q)) {
        selected.add(q);
      } else if (choices < cap || pinned.contains(q.id)) {
        selected.add(q);
        choices++;
      } else {
        rest.add(q);
      }
    }
    // Nicht genug andere Formate da: mit Auswahlaufgaben auffüllen, statt
    // eine zu kurze Runde zu liefern.
    while (selected.length < count && rest.isNotEmpty) {
      selected.add(rest.removeAt(0));
    }

    // Mindestens eine Rechen-/Tabellen- und eine Freitext-Aufgabe je
    // angefangene 10 Aufgaben - sehr kurze Runden ausgenommen.
    final need = count >= 5 ? (count / 10).ceil() : 0;
    for (final wanted in [FormatMix.isCalc, FormatMix.isOpen]) {
      while (selected.where(wanted).length < need) {
        final inIdx = rest.indexWhere(wanted);
        if (inIdx < 0) break;
        // Verdrängt wird die rangniedrigste Aufgabe, die weder gepinnt ist
        // noch selbst eine der Garantien erfüllt - bevorzugt eine
        // Auswahlaufgabe.
        bool free(Question q) =>
            !pinned.contains(q.id) &&
            !FormatMix.isCalc(q) &&
            !FormatMix.isOpen(q);
        var outIdx = selected.lastIndexWhere(
          (q) => free(q) && FormatMix.isChoice(q),
        );
        if (outIdx < 0) outIdx = selected.lastIndexWhere(free);
        if (outIdx < 0) break;
        rest.add(selected.removeAt(outIdx));
        selected.add(rest.removeAt(inIdx));
      }
    }
    return selected;
  }

  /// Bringt eine Runde in eine Reihenfolge ohne drei Aufgaben derselben Art
  /// hintereinander (Einfach- und Mehrfachauswahl gelten als eine Art).
  ///
  /// Geht es nicht anders - etwa wenn fast nur eine Art vorhanden ist -,
  /// bleibt die Runde vollständig; die Regel ist dann nicht erfüllbar.
  static List<Question> arrange(List<Question> items) {
    final remaining = [...items];
    final out = <Question>[];
    while (remaining.isNotEmpty) {
      final last = out.isEmpty ? null : FormatMix.family(out.last);
      final blocked =
          out.length >= 2 && FormatMix.family(out[out.length - 2]) == last
          ? last
          : null;

      final counts = <String, int>{};
      for (final q in remaining) {
        final f = FormatMix.family(q);
        counts[f] = (counts[f] ?? 0) + 1;
      }
      String? top;
      for (final e in counts.entries) {
        if (top == null || e.value > counts[top]!) top = e.key;
      }
      final others = remaining.length - counts[top]!;

      String pick;
      if (top != blocked && counts[top]! > others + 1) {
        // Eine Art überwiegt deutlich: früh und in Zweierpäckchen abbauen,
        // sonst bleibt am Ende ein Block davon übrig.
        pick = top!;
      } else {
        // Sonst abwechseln: die häufigste Art, die nicht gerade dran war.
        String? alt;
        for (final e in counts.entries) {
          if (e.key == last) continue;
          if (alt == null || e.value > counts[alt]!) alt = e.key;
        }
        pick =
            alt ??
            (last != blocked ? last! : FormatMix.family(remaining.first));
      }
      final i = remaining.indexWhere((q) => FormatMix.family(q) == pick);
      out.add(remaining.removeAt(i));
    }
    return out;
  }

  /// Nächste Aufgabe für eine endlose Runde (Kurztest).
  ///
  /// Zieht erst ein Thema, dann eine Aufgabe daraus - so kommen kleine
  /// Themen genauso oft dran wie große. [asked] sind die Aufgaben, die in
  /// dieser Runde schon dran waren: Sie wiederholen sich erst, wenn der Pool
  /// erschöpft ist, und aus ihnen ergibt sich der Formatmix (Auswahl
  /// höchstens rund 30 %, keine drei gleichen hintereinander, regelmäßig
  /// eine Rechen- und eine Freitext-Aufgabe).
  static Question? nextEndless(
    List<Question> pool,
    List<Question> asked,
    math.Random rnd,
  ) {
    final relevant = pool.where((q) => q.isExamRelevant).toList();
    if (relevant.isEmpty) return null;
    final used = {for (final q in asked) q.id};
    final fresh = relevant.where((q) => !used.contains(q.id)).toList();
    var candidates = fresh.isEmpty ? relevant : fresh;

    List<Question> narrow(bool Function(Question) test) {
      final list = candidates.where(test).toList();
      return list.isEmpty ? candidates : list;
    }

    if (asked.isNotEmpty) {
      // Nicht dreimal dieselbe Art hintereinander.
      if (asked.length >= 2) {
        final a = FormatMix.family(asked[asked.length - 1]);
        final b = FormatMix.family(asked[asked.length - 2]);
        if (a == b) candidates = narrow((q) => FormatMix.family(q) != a);
      }
      // Auswahlaufgaben deckeln.
      final choices = asked.where(FormatMix.isChoice).length;
      final allowed = ((asked.length + 1) * choiceShare).ceil();
      if (choices + 1 > allowed) {
        candidates = narrow((q) => !FormatMix.isChoice(q));
      }
      // Zu lange keine Rechen- bzw. Freitext-Aufgabe: jetzt. Freitext schaut
      // eine Aufgabe kürzer zurück, damit beide Garantien auch dann in zehn
      // Aufgaben passen, wenn sie gleichzeitig fällig werden.
      if (asked.length >= 4) {
        List<Question> last(int n) =>
            asked.sublist(math.max(0, asked.length - n));
        if (!last(9).any(FormatMix.isCalc)) {
          candidates = narrow(FormatMix.isCalc);
        } else if (!last(8).any(FormatMix.isOpen)) {
          candidates = narrow(FormatMix.isOpen);
        }
      }
    }

    final byTopic = <String, List<Question>>{};
    for (final q in candidates) {
      byTopic.putIfAbsent(q.topicId, () => []).add(q);
    }
    final topics = byTopic.keys.toList();
    final list = byTopic[topics[rnd.nextInt(topics.length)]]!;
    return list[rnd.nextInt(list.length)];
  }

  /// Querbeet: bunt gemischt über alle Themen, bewusst ohne Gewichtung nach
  /// Schwächen. Die Themen werden reihum gezogen, damit nicht zufällig fünf
  /// Aufgaben aus demselben Thema hintereinander kommen.
  static List<Question> forMix({
    required List<Question> pool,
    int count = 15,
    int? seed,
  }) {
    final rnd = math.Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final byTopic = <String, List<Question>>{};
    for (final q in pool.where((q) => q.isExamRelevant)) {
      byTopic.putIfAbsent(q.topicId, () => []).add(q);
    }
    for (final list in byTopic.values) {
      list.shuffle(rnd);
    }
    final topics = byTopic.keys.toList()..shuffle(rnd);

    final picked = <Question>[];
    for (var round = 0; picked.length < count; round++) {
      var any = false;
      for (final t in topics) {
        final list = byTopic[t]!;
        if (round < list.length) {
          picked.add(list[round]);
          any = true;
          if (picked.length >= count) break;
        }
      }
      if (!any) break;
    }
    return picked;
  }

  /// Aufgabenmix nach Punkteanteil der Themen.
  ///
  /// Grundlage für den Ersatz-Prüfungsbogen, solange es zu wenige
  /// Fallaufgaben gibt (`ExamComposer.fallback`). Die Themen werden nach
  /// ihrem geschätzten Punkteanteil in der AP1 verteilt - nicht nach dem,
  /// was der Lernende gern übt.
  static List<Question> forExam({
    required List<Question> pool,
    required int count,
    int? seed,
  }) {
    final rnd = math.Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final relevant = pool.where((q) => q.isExamRelevant).toList();
    final byTopic = <String, List<Question>>{};
    for (final q in relevant) {
      byTopic.putIfAbsent(q.topicId, () => []).add(q);
    }

    final picked = <Question>[];
    final used = <String>{};

    // Erste Runde: Soll-Anzahl je Thema nach Gewichtung.
    for (final t in Topics.all) {
      final available = [...(byTopic[t.id] ?? const <Question>[])]
        ..shuffle(rnd);
      final want = (count * t.weight).round();
      for (final q in available.take(want)) {
        if (used.add(q.id)) picked.add(q);
      }
    }

    // Zweite Runde: Rundungsreste auffüllen.
    if (picked.length < count) {
      final rest = relevant.where((q) => !used.contains(q.id)).toList()
        ..shuffle(rnd);
      for (final q in rest) {
        if (picked.length >= count) break;
        if (used.add(q.id)) picked.add(q);
      }
    }

    final result = picked.take(count).toList()..shuffle(rnd);

    // In der echten Prüfung stehen zusammengehörige Aufgaben beieinander -
    // wir gruppieren deshalb nach Thema, damit kein Themen-Pingpong entsteht.
    result.sort((a, b) => a.topicId.compareTo(b.topicId));
    return result;
  }

  static Map<String, DateTime> _lastSeenByQuestion(ProgressState p) {
    final out = <String, DateTime>{};
    for (final r in p.history) {
      final prev = out[r.questionId];
      if (prev == null || r.at.isAfter(prev)) out[r.questionId] = r.at;
    }
    return out;
  }
}
