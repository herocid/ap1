import 'dart:convert';

import 'package:flutter/foundation.dart';

/// Lesezeichen: wo der Lernende in Journey und Karteikasten zuletzt war -
/// damit die Startseite „da weitermachen, wo du aufgehört hast“ anbieten kann.
@immutable
class ResumeState {
  const ResumeState({this.lesson, this.cards});

  final LessonBookmark? lesson;
  final CardBookmark? cards;

  ResumeState copyWith({
    LessonBookmark? lesson,
    CardBookmark? cards,
    bool clearLesson = false,
  }) => ResumeState(
    lesson: clearLesson ? null : (lesson ?? this.lesson),
    cards: cards ?? this.cards,
  );

  Map<String, dynamic> toJson() => {
    if (lesson != null) 'lesson': lesson!.toJson(),
    if (cards != null) 'cards': cards!.toJson(),
  };

  factory ResumeState.fromJson(Map<String, dynamic> j) => ResumeState(
    lesson: j['lesson'] is Map
        ? LessonBookmark.fromJson((j['lesson'] as Map).cast<String, dynamic>())
        : null,
    cards: j['cards'] is Map
        ? CardBookmark.fromJson((j['cards'] as Map).cast<String, dynamic>())
        : null,
  );

  String encode() => jsonEncode(toJson());
  static ResumeState decode(String s) =>
      ResumeState.fromJson((jsonDecode(s) as Map).cast<String, dynamic>());
}

/// Angefangene Lektion: welche Seite zuletzt offen war.
@immutable
class LessonBookmark {
  const LessonBookmark({
    required this.lessonId,
    required this.page,
    required this.at,
  });

  final String lessonId;

  /// Seite im Lektions-Pager: 0 = Einstieg, 1..n = Lernschritte.
  final int page;
  final DateTime at;

  Map<String, dynamic> toJson() => {
    'id': lessonId,
    'page': page,
    'at': at.toIso8601String(),
  };

  factory LessonBookmark.fromJson(Map<String, dynamic> j) => LessonBookmark(
    lessonId: j['id'] as String,
    page: (j['page'] as num?)?.toInt() ?? 0,
    at: DateTime.tryParse(j['at'] as String? ?? '') ?? DateTime(2000),
  );
}

/// Zuletzt gestartete Karteikarten-Runde - Art und Auswahl, nicht die
/// einzelnen Karten: Beim Weitermachen wird neu gezogen, was dann dran ist.
@immutable
class CardBookmark {
  const CardBookmark({
    required this.mode,
    required this.title,
    required this.at,
    this.topicIds = const {},
  });

  /// Name des `CardMode`.
  final String mode;
  final String title;
  final Set<String> topicIds;
  final DateTime at;

  Map<String, dynamic> toJson() => {
    'mode': mode,
    'title': title,
    'topics': topicIds.toList(),
    'at': at.toIso8601String(),
  };

  factory CardBookmark.fromJson(Map<String, dynamic> j) => CardBookmark(
    mode: j['mode'] as String? ?? 'due',
    title: j['title'] as String? ?? 'Karteikarten',
    topicIds: ((j['topics'] as List?) ?? const []).cast<String>().toSet(),
    at: DateTime.tryParse(j['at'] as String? ?? '') ?? DateTime(2000),
  );
}
