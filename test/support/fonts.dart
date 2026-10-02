import 'dart:io';

import 'package:flutter/services.dart';

bool _loaded = false;

/// Lädt die echten App-Schriften (Inter, Plus Jakarta Sans, JetBrains Mono) und die
/// Material-Symbole in die Testumgebung.
///
/// Ohne das rendert `flutter test` jeden Buchstaben als gleich breites
/// Quadrat. Für die Prüfung „ist der Text vollständig sichtbar?“ braucht es
/// aber die echten Laufweiten - sonst passen Wörter im Test nicht, die auf
/// dem Handy passen, und umgekehrt.
Future<void> loadAppFonts() async {
  if (_loaded) return;
  _loaded = true;

  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      final file = File(f);
      if (!file.existsSync()) continue;
      loader.addFont(file.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  }

  await load('Inter', [
    'assets/fonts/Inter-Regular.ttf',
    'assets/fonts/Inter-Medium.ttf',
    'assets/fonts/Inter-SemiBold.ttf',
    'assets/fonts/Inter-Bold.ttf',
  ]);
  await load('PlusJakartaSans', [
    'assets/fonts/PlusJakartaSans-SemiBold.ttf',
    'assets/fonts/PlusJakartaSans-Bold.ttf',
    'assets/fonts/PlusJakartaSans-ExtraBold.ttf',
  ]);
  await load('JetBrainsMono', [
    'assets/fonts/JetBrainsMono-Regular.ttf',
    'assets/fonts/JetBrainsMono-Bold.ttf',
  ]);

  // Symbole nur für Bildschirmfotos - für die Textprüfung egal.
  final root =
      Platform.environment['FLUTTER_ROOT'] ??
      r'C:\Users\Student\develop\flutter';
  await load('MaterialIcons', [
    '$root/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  ]);
}
