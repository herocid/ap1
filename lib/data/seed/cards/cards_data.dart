import '../../models/flashcard.dart';
import 'cards_a01_projekte.dart';

/// Alle Lernkarteikarten der App.
///
/// Aufgeteilt nach Katalogbereich, damit die Dateien handhabbar bleiben und
/// eine Ergänzung eines Bereichs nicht die ganze Sammlung anfasst.
final List<Flashcard> kSeedFlashcards = [
  ...cardsA01,
];
