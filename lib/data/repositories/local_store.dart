import 'package:shared_preferences/shared_preferences.dart';

import '../models/flashcard.dart';
import '../models/profile.dart';
import '../models/progress.dart';

/// Lokale Persistenz. Die App ist offline-first: alles landet zuerst hier,
/// die Synchronisation mit Supabase ist ein zusätzlicher Schritt, kein
/// Voraussetzung. Wer im Zug ohne Netz lernt, verliert nichts.
class LocalStore {
  LocalStore(this._prefs);

  final SharedPreferences _prefs;

  static const _kProfile = 'ap1.profile';
  static const _kProgress = 'ap1.progress';
  static const _kSeenTheory = 'ap1.seen_theory';
  static const _kDeck = 'ap1.deck';

  UserProfile? readProfile() {
    final raw = _prefs.getString(_kProfile);
    if (raw == null) return null;
    try {
      return UserProfile.decode(raw);
    } catch (_) {
      return null;
    }
  }

  Future<void> writeProfile(UserProfile p) =>
      _prefs.setString(_kProfile, p.encode());

  ProgressState readProgress() {
    final raw = _prefs.getString(_kProgress);
    if (raw == null) return const ProgressState();
    try {
      return ProgressState.decode(raw);
    } catch (_) {
      return const ProgressState();
    }
  }

  Future<void> writeProgress(ProgressState p) =>
      _prefs.setString(_kProgress, p.encode());

  Set<String> readSeenTheory() =>
      (_prefs.getStringList(_kSeenTheory) ?? const []).toSet();

  Future<void> writeSeenTheory(Set<String> ids) =>
      _prefs.setStringList(_kSeenTheory, ids.toList());

  DeckState readDeck() {
    final raw = _prefs.getString(_kDeck);
    if (raw == null) return const DeckState();
    try {
      return DeckState.decode(raw);
    } catch (_) {
      return const DeckState();
    }
  }

  Future<void> writeDeck(DeckState d) => _prefs.setString(_kDeck, d.encode());

  Future<void> clearAll() async {
    await _prefs.remove(_kProfile);
    await _prefs.remove(_kProgress);
    await _prefs.remove(_kSeenTheory);
    await _prefs.remove(_kDeck);
  }
}
