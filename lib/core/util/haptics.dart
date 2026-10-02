import 'package:flutter/services.dart';

/// Zentrale Haptik: feste Muster statt verstreuter `HapticFeedback`-Aufrufe,
/// damit sich jede Rückmeldung in der ganzen App gleich anfühlt.
class AppHaptics {
  const AppHaptics._();

  /// Antwort, Lücke oder Paar ausgewählt: kaum spürbares Klicken.
  static Future<void> select() => HapticFeedback.selectionClick();

  /// Antwort richtig bzw. Karte gewusst: kurzer, leichter Impuls.
  static Future<void> correct() => HapticFeedback.lightImpact();

  /// Antwort falsch bzw. Karte nicht gewusst: deutlicherer Impuls.
  static Future<void> wrong() => HapticFeedback.mediumImpact();

  /// Meilenstein (Konfetti): kräftiger Impuls.
  static Future<void> milestone() => HapticFeedback.heavyImpact();

  /// Karteikarte umgedreht: leichtes Klicken.
  static Future<void> flip() => HapticFeedback.selectionClick();
}
