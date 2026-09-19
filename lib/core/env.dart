/// Laufzeit-Konfiguration.
///
/// Werte kommen per `--dart-define` bzw. `--dart-define-from-file=env.json`.
/// Fehlt der Anon-Key, läuft die App im **Offline-Modus** komplett gegen die
/// eingebauten Seed-Daten – praktisch für Demo, Entwicklung und Flugmodus.
class Env {
  const Env._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://zcxhrkwbulsedkxcbkkk.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
  );

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
