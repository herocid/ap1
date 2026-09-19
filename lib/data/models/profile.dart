import 'dart:convert';

import 'package:flutter/material.dart';

/// IT-Berufe mit gemeinsamer AP1. Der Beruf beeinflusst spaeter die
/// Aufgaben-Auswahl (Fachrichtungs-Tags), nicht aber den PM-Kern - der ist
/// fuer alle identisch.
enum Beruf {
  fiae('Fachinformatiker/-in Anwendungsentwicklung'),
  fisi('Fachinformatiker/-in Systemintegration'),
  fidv('Fachinformatiker/-in Daten- und Prozessanalyse'),
  fidp('Fachinformatiker/-in Digitale Vernetzung'),
  kaufIt('Kaufmann/-frau fuer IT-System-Management'),
  kaufDig('Kaufmann/-frau fuer Digitalisierungsmanagement'),
  itSys('IT-System-Elektroniker/-in');

  const Beruf(this.label);
  final String label;

  static Beruf parse(String? s) => Beruf.values.firstWhere(
        (b) => b.name == s,
        orElse: () => Beruf.fiae,
      );
}

/// Wie viel Zeit pro Tag realistisch drin ist. Steuert die Tagesdosis im
/// Lernplan.
enum LernIntensitaet {
  locker('Locker', 10, 8),
  solide('Solide', 20, 15),
  intensiv('Intensiv', 35, 25),
  endspurt('Endspurt', 60, 40);

  const LernIntensitaet(this.label, this.minutesPerDay, this.questionsPerDay);
  final String label;
  final int minutesPerDay;
  final int questionsPerDay;

  static LernIntensitaet parse(String? s) => LernIntensitaet.values
      .firstWhere((e) => e.name == s, orElse: () => LernIntensitaet.solide);
}

@immutable
class UserProfile {
  const UserProfile({
    required this.displayName,
    required this.beruf,
    required this.examDate,
    required this.intensitaet,
    this.themeMode = ThemeMode.system,
    this.onboarded = false,
    this.reminderHour = 18,
    this.remindersOn = true,
  });

  final String displayName;
  final Beruf beruf;
  final DateTime examDate;
  final LernIntensitaet intensitaet;
  final ThemeMode themeMode;
  final bool onboarded;
  final int reminderHour;
  final bool remindersOn;

  int get daysUntilExam {
    final today = DateTime.now();
    final d0 = DateTime(today.year, today.month, today.day);
    final d1 = DateTime(examDate.year, examDate.month, examDate.day);
    return d1.difference(d0).inDays;
  }

  int get dailyGoal => intensitaet.questionsPerDay;

  static UserProfile initial() => UserProfile(
        displayName: '',
        beruf: Beruf.fiae,
        examDate: nextIhkDate(),
        intensitaet: LernIntensitaet.solide,
      );

  /// Die IHK-Termine fuer AP1 liegen bundeseinheitlich im Fruehjahr (Maerz)
  /// und Herbst (September). Wir schlagen den naechsten plausiblen Termin vor,
  /// aendern laesst er sich frei.
  static DateTime nextIhkDate([DateTime? now]) {
    final n = now ?? DateTime.now();
    final candidates = <DateTime>[
      DateTime(n.year, 3, 4),
      DateTime(n.year, 9, 23),
      DateTime(n.year + 1, 3, 4),
      DateTime(n.year + 1, 9, 23),
    ];
    return candidates.firstWhere((d) => d.isAfter(n), orElse: () => candidates.last);
  }

  UserProfile copyWith({
    String? displayName,
    Beruf? beruf,
    DateTime? examDate,
    LernIntensitaet? intensitaet,
    ThemeMode? themeMode,
    bool? onboarded,
    int? reminderHour,
    bool? remindersOn,
  }) =>
      UserProfile(
        displayName: displayName ?? this.displayName,
        beruf: beruf ?? this.beruf,
        examDate: examDate ?? this.examDate,
        intensitaet: intensitaet ?? this.intensitaet,
        themeMode: themeMode ?? this.themeMode,
        onboarded: onboarded ?? this.onboarded,
        reminderHour: reminderHour ?? this.reminderHour,
        remindersOn: remindersOn ?? this.remindersOn,
      );

  Map<String, dynamic> toJson() => {
        'display_name': displayName,
        'beruf': beruf.name,
        'exam_date': examDate.toIso8601String(),
        'intensitaet': intensitaet.name,
        'theme_mode': themeMode.name,
        'onboarded': onboarded,
        'reminder_hour': reminderHour,
        'reminders_on': remindersOn,
      };

  factory UserProfile.fromJson(Map<String, dynamic> j) => UserProfile(
        displayName: (j['display_name'] ?? '') as String,
        beruf: Beruf.parse(j['beruf'] as String?),
        examDate: DateTime.tryParse((j['exam_date'] ?? '') as String) ??
            nextIhkDate(),
        intensitaet: LernIntensitaet.parse(j['intensitaet'] as String?),
        themeMode: ThemeMode.values.firstWhere(
          (m) => m.name == j['theme_mode'],
          orElse: () => ThemeMode.system,
        ),
        onboarded: j['onboarded'] as bool? ?? false,
        reminderHour: (j['reminder_hour'] as num?)?.toInt() ?? 18,
        remindersOn: j['reminders_on'] as bool? ?? true,
      );

  String encode() => jsonEncode(toJson());
  static UserProfile decode(String s) =>
      UserProfile.fromJson((jsonDecode(s) as Map).cast<String, dynamic>());
}
