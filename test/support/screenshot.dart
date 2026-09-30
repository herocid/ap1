import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Schreibt den aktuellen Bildschirm als PNG - für die Sichtprüfung von
/// Layouts in Hell/Dunkel und auf schmalen Displays, ohne Emulator.
///
/// Nur aufrufen, wenn die Umgebungsvariable `AP1_SHOTS` auf einen Ordner
/// zeigt; sonst passiert nichts (normale Testläufe bleiben schnell).
Future<void> saveScreenshot(WidgetTester tester, String name) async {
  final dir = Platform.environment['AP1_SHOTS'];
  if (dir == null || dir.isEmpty) return;
  // Die oberste RepaintBoundary unterhalb der Wurzel ist die der App.
  final boundary = tester
      .renderObjectList<RenderObject>(find.byType(RepaintBoundary))
      .whereType<RenderRepaintBoundary>()
      .first;
  await tester.runAsync(() async {
    final image = await boundary.toImage(
      pixelRatio: tester.view.devicePixelRatio,
    );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    final file = File('$dir/$name.png');
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes!.buffer.asUint8List());
  });
}
