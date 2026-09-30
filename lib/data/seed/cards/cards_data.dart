import '../../models/flashcard.dart';
import 'cards_a01_journey.dart';
import 'cards_a01_projekte.dart';
import 'cards_a02_kunden.dart';
import 'cards_a03_systeme.dart';

/// Alle Lernkarteikarten der App.
///
/// Aufgeteilt nach Katalogbereich, damit die Dateien handhabbar bleiben und
/// eine Ergänzung eines Bereichs nicht die ganze Sammlung anfasst.
final List<Flashcard> kSeedFlashcards = [
  ...cardsA01,
  ...cardsA01Journey,
  ...cardsA02,
  ...cardsA03,
];
