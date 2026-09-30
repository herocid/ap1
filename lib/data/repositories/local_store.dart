import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/flashcard.dart';
import '../models/profile.dart';
import '../models/progress.dart';

/// Lokale Persistenz. Die App ist offline-first: alles landet zuerst hier,
/// die Synchronisation mit Supabase ist ein zusätzlicher Schritt, keine
/// Voraussetzung. Wer im Zug ohne Netz lernt, verliert nichts.
///
/// Lesen ist synchron (die Daten liegen nach dem Öffnen im Speicher),
/// Schreiben asynchron und wird nicht abgewartet - die UI hängt nie an der
/// Festplatte.
abstract interface class LocalStore {
  UserProfile? readProfile();
  Future<void> writeProfile(UserProfile p);

  /// Historie plus Kennzahlen (Streak, Badges).
  ProgressState readProgress();

  /// Hängt Antworten an die Historie an. Bestehende Einträge werden nie
  /// verändert - die Historie ist eine Ereignisliste.
  Future<void> appendAnswers(List<AnswerRecord> records);

  /// Überschreibt nur die Kennzahlen, nicht die Historie.
  Future<void> writeProgressMeta(ProgressState p);
  Future<void> clearProgress();

  Set<String> readSeenTheory();
  Future<void> writeSeenTheory(Set<String> ids);

  /// Abgeschlossene Lektionen der Learning Journey (Unterthema-IDs).
  Set<String> readJourney();
  Future<void> writeJourney(Set<String> doneLessons);

  DeckState readDeck();
  Future<void> writeCardState(CardState s);
  Future<void> clearDeck();

  Future<void> clearAll();
}

/// [LocalStore] auf Basis von hive_ce: nativ eine Datei pro Box, im Web
/// IndexedDB.
///
/// Drei Boxen, jeweils mit JSON-Strings als Werten - so bleiben die
/// vorhandenen `toJson`/`fromJson`-Methoden die einzige Serialisierung, und
/// es braucht keine generierten TypeAdapter.
class HiveLocalStore implements LocalStore {
  HiveLocalStore._(this._meta, this._answers, this._cards);

  final Box<String> _meta;

  /// Automatisch hochgezählte Schlüssel halten die Einfügereihenfolge.
  final Box<String> _answers;

  /// Schlüssel = Karten-ID.
  final Box<String> _cards;

  static const _boxMeta = 'ap1_meta';
  static const _boxAnswers = 'ap1_answers';
  static const _boxCards = 'ap1_cards';

  static const _kProfile = 'profile';
  static const _kProgressMeta = 'progress_meta';
  static const _kSeenTheory = 'seen_theory';
  static const _kJourney = 'journey_done';

  /// Öffnet die Boxen. [inMemory] ist für Tests: nichts wird auf die Platte
  /// geschrieben, und jeder Test beginnt leer, sofern er die Boxen vorher
  /// mit [close] schließt.
  static Future<HiveLocalStore> open({bool inMemory = false}) async {
    Future<Box<String>> box(String name) => inMemory
        ? Hive.openBox<String>(name, bytes: Uint8List(0))
        : Hive.openBox<String>(name);
    if (!inMemory) await Hive.initFlutter();
    return HiveLocalStore._(
      await box(_boxMeta),
      await box(_boxAnswers),
      await box(_boxCards),
    );
  }

  Future<void> close() async {
    await _meta.close();
    await _answers.close();
    await _cards.close();
  }

  // ------------------------------------------------------------------ Profil

  @override
  UserProfile? readProfile() {
    final raw = _meta.get(_kProfile);
    if (raw == null) return null;
    try {
      return UserProfile.decode(raw);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> writeProfile(UserProfile p) => _meta.put(_kProfile, p.encode());

  // ------------------------------------------------------------ Fortschritt

  @override
  ProgressState readProgress() {
    var meta = const ProgressState();
    final rawMeta = _meta.get(_kProgressMeta);
    if (rawMeta != null) {
      try {
        meta = ProgressState.decode(rawMeta);
      } catch (_) {
        // Kaputte Kennzahlen: Historie trotzdem laden, Streak beginnt neu.
      }
    }

    final history = <AnswerRecord>[];
    for (final raw in _answers.values) {
      try {
        history.add(AnswerRecord.fromJson(
          (jsonDecode(raw) as Map).cast<String, dynamic>(),
        ));
      } catch (_) {
        // Ein beschädigter Eintrag darf nicht die ganze Historie kosten.
      }
    }
    return meta.copyWith(history: history);
  }

  @override
  Future<void> appendAnswers(List<AnswerRecord> records) =>
      _answers.addAll(records.map((r) => jsonEncode(r.toJson())));

  @override
  Future<void> writeProgressMeta(ProgressState p) =>
      _meta.put(_kProgressMeta, jsonEncode(p.metaToJson()));

  @override
  Future<void> clearProgress() async {
    await _answers.clear();
    await _meta.delete(_kProgressMeta);
  }

  // ---------------------------------------------------------------- Theorie

  @override
  Set<String> readSeenTheory() {
    final raw = _meta.get(_kSeenTheory);
    if (raw == null) return {};
    try {
      return (jsonDecode(raw) as List).cast<String>().toSet();
    } catch (_) {
      return {};
    }
  }

  @override
  Future<void> writeSeenTheory(Set<String> ids) =>
      _meta.put(_kSeenTheory, jsonEncode(ids.toList()));

  // ---------------------------------------------------------------- Journey

  @override
  Set<String> readJourney() {
    final raw = _meta.get(_kJourney);
    if (raw == null) return {};
    try {
      return (jsonDecode(raw) as List).cast<String>().toSet();
    } catch (_) {
      return {};
    }
  }

  @override
  Future<void> writeJourney(Set<String> doneLessons) =>
      _meta.put(_kJourney, jsonEncode(doneLessons.toList()));

  // --------------------------------------------------------- Karteikasten

  @override
  DeckState readDeck() {
    final cards = <String, CardState>{};
    for (final raw in _cards.values) {
      try {
        final s = CardState.fromJson(
          (jsonDecode(raw) as Map).cast<String, dynamic>(),
        );
        cards[s.cardId] = s;
      } catch (_) {
        // Beschädigte Karte gilt als neu.
      }
    }
    return DeckState(cards: cards);
  }

  @override
  Future<void> writeCardState(CardState s) =>
      _cards.put(s.cardId, jsonEncode(s.toJson()));

  @override
  Future<void> clearDeck() => _cards.clear();

  // ------------------------------------------------------------------ Alles

  @override
  Future<void> clearAll() async {
    await _meta.clear();
    await _answers.clear();
    await _cards.clear();
  }

  // -------------------------------------------------------------- Migration

  static const _legacyProfile = 'ap1.profile';
  static const _legacyProgress = 'ap1.progress';
  static const _legacySeenTheory = 'ap1.seen_theory';
  static const _legacyDeck = 'ap1.deck';

  /// Übernimmt Daten aus der Vorgängerversion, die alles als einzelne
  /// JSON-Blöcke in SharedPreferences abgelegt hat, und löscht sie danach.
  ///
  /// Jeder Abschnitt wird nur übernommen, wenn hier noch nichts liegt. Bricht
  /// die App mitten in der Übernahme ab, entstehen beim nächsten Start also
  /// keine doppelten Antworten.
  Future<void> migrateFrom(SharedPreferences prefs) async {
    final profile = prefs.getString(_legacyProfile);
    if (profile != null && _meta.get(_kProfile) == null) {
      await _meta.put(_kProfile, profile);
    }

    final progress = prefs.getString(_legacyProgress);
    if (progress != null && _answers.isEmpty) {
      try {
        final p = ProgressState.decode(progress);
        await appendAnswers(p.history);
        await writeProgressMeta(p);
      } catch (e) {
        debugPrint('Alter Fortschritt nicht lesbar, wird verworfen: $e');
      }
    }

    final seen = prefs.getStringList(_legacySeenTheory);
    if (seen != null && _meta.get(_kSeenTheory) == null) {
      await writeSeenTheory(seen.toSet());
    }

    final deck = prefs.getString(_legacyDeck);
    if (deck != null && _cards.isEmpty) {
      try {
        for (final s in DeckState.decode(deck).cards.values) {
          await writeCardState(s);
        }
      } catch (e) {
        debugPrint('Alter Karteikasten nicht lesbar, wird verworfen: $e');
      }
    }

    for (final k in [
      _legacyProfile,
      _legacyProgress,
      _legacySeenTheory,
      _legacyDeck,
    ]) {
      await prefs.remove(k);
    }
  }
}
