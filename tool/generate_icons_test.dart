// Generator, kein Test.
//
// Zeichnet das Logo aus `lib/widgets/brand.dart` als PNG in alle Icon-
// Größen für Web, Android und iOS. So gibt es nur eine Quelle für das Logo.
//
// Ausführen:
//   flutter test tool/generate_icons_test.dart

import 'dart:io';
import 'dart:ui' as ui;

import 'package:ap1_trainer/widgets/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _write(
  String path,
  int px, {
  bool rounded = true,
  double inset = 0,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  LogoPainter(
    rounded: rounded,
    inset: inset,
  ).paint(canvas, Size(px.toDouble(), px.toDouble()));
  final image = await recorder.endRecording().toImage(px, px);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes!.buffer.asUint8List());
}

void main() {
  test('erzeugt die App-Icons aus dem Logo', () async {
    await TestWidgetsFlutterBinding.ensureInitialized().runAsync(() async {
      // Web: normale Icons mit runden Ecken, maskierbare randlos mit
      // Sicherheitszone (das System schneidet selbst zu).
      await _write('web/favicon.png', 64);
      await _write('web/icons/Icon-192.png', 192);
      await _write('web/icons/Icon-512.png', 512);
      await _write(
        'web/icons/Icon-maskable-192.png',
        192,
        rounded: false,
        inset: 0.12,
      );
      await _write(
        'web/icons/Icon-maskable-512.png',
        512,
        rounded: false,
        inset: 0.12,
      );

      // Android (klassische Launcher-Icons).
      const android = {
        'mdpi': 48,
        'hdpi': 72,
        'xhdpi': 96,
        'xxhdpi': 144,
        'xxxhdpi': 192,
      };
      for (final e in android.entries) {
        await _write(
          'android/app/src/main/res/mipmap-${e.key}/ic_launcher.png',
          e.value,
        );
      }

      // iOS verlangt deckende Icons ohne Transparenz - die Rundung macht
      // das System.
      const ios = {
        'Icon-App-20x20@1x.png': 20,
        'Icon-App-20x20@2x.png': 40,
        'Icon-App-20x20@3x.png': 60,
        'Icon-App-29x29@1x.png': 29,
        'Icon-App-29x29@2x.png': 58,
        'Icon-App-29x29@3x.png': 87,
        'Icon-App-40x40@1x.png': 40,
        'Icon-App-40x40@2x.png': 80,
        'Icon-App-40x40@3x.png': 120,
        'Icon-App-60x60@2x.png': 120,
        'Icon-App-60x60@3x.png': 180,
        'Icon-App-76x76@1x.png': 76,
        'Icon-App-76x76@2x.png': 152,
        'Icon-App-83.5x83.5@2x.png': 167,
        'Icon-App-1024x1024@1x.png': 1024,
      };
      for (final e in ios.entries) {
        await _write(
          'ios/Runner/Assets.xcassets/AppIcon.appiconset/${e.key}',
          e.value,
          rounded: false,
          inset: 0.08,
        );
      }
    });
  });
}
