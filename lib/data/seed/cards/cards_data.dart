import '../../models/flashcard.dart';
import 'cards_a01_journey.dart';
import 'cards_a01_projekte.dart';
import 'cards_a02_kunden.dart';
import 'cards_a03_systeme.dart';
import 'cards_a04_daten.dart';
import 'cards_a04_entwicklung.dart';
import 'cards_a05_qualitaet.dart';
import 'cards_a06_krypto.dart';
import 'cards_a06_sicherheit.dart';

/// Alle Lernkarteikarten der App.
///
/// Aufgeteilt nach Katalogbereich, damit die Dateien handhabbar bleiben und
/// eine Ergänzung eines Bereichs nicht die ganze Sammlung anfasst.
final List<Flashcard> kSeedFlashcards = [
  ...cardsA01,
  ...cardsA01Journey,
  ...cardsA02,
  ...cardsA03,
  ...cardsA04Entwicklung,
  ...cardsA04Daten,
  ...cardsA05,
  ...cardsA06Sicherheit,
  ...cardsA06Krypto,
];
