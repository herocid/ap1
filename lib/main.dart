import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/env.dart';
import 'core/router.dart';
import 'core/theme/app_theme.dart';
import 'data/models/profile.dart';
import 'data/repositories/local_store.dart';
import 'state/providers.dart';
import 'widgets/brand.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('de_DE');

  // Supabase ist optional. Ohne Anon-Key startet die App im Offline-Modus mit
  // den eingebauten Aufgaben - das hält die Einstiegshürde bei null und
  // macht die App im Flugmodus benutzbar.
  if (Env.hasSupabase) {
    try {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        publishableKey: Env.supabaseAnonKey,
      );
    } catch (e) {
      debugPrint('Supabase-Initialisierung fehlgeschlagen: $e');
    }
  }

  _registerFontLicenses();

  final store = await HiveLocalStore.open();
  await store.migrateFrom(await SharedPreferences.getInstance());
  await resetOutdatedData(store);

  runApp(
    ProviderScope(
      overrides: [localStoreProvider.overrideWithValue(store)],
      child: const Ap1TrainerApp(),
    ),
  );
}

/// Einmaliger Reset: Stammen die Daten auf diesem Gerät aus einem älteren
/// Datenstand ([UserProfile.kIntroVersion]), wird alles gelöscht - Profil,
/// Fortschritt, Karteikasten, Durchlauf, Lesezeichen. Danach startet die
/// App mit Begrüßung und Einführung wie beim ersten Öffnen. Neue Nutzer
/// (noch kein Profil) sind nicht betroffen.
Future<void> resetOutdatedData(LocalStore store) async {
  final p = store.readProfile();
  if (p != null && p.introVersion < UserProfile.kIntroVersion) {
    await store.clearAll();
  }
}

/// Die Open Font License verlangt, dass der Lizenztext mit der App
/// ausgeliefert wird. So erscheint er in der Lizenzübersicht.
void _registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final (family, file) in const [
      ('Inter', 'assets/fonts/OFL-Inter.txt'),
      ('JetBrains Mono', 'assets/fonts/OFL-JetBrainsMono.txt'),
    ]) {
      yield LicenseEntryWithLineBreaks([
        family,
      ], await rootBundle.loadString(file));
    }
  });
}

class Ap1TrainerApp extends ConsumerWidget {
  const Ap1TrainerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: const Locale('de', 'DE'),
      supportedLocales: const [Locale('de', 'DE'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
