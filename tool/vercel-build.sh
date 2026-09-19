#!/usr/bin/env bash
#
# Build-Skript fuer Vercel.
#
# Vercels Build-Container kennt Flutter nicht, deshalb holen wir das SDK hier
# selbst. Ein flacher Clone des stable-Branches ist schneller und robuster als
# der Tarball-Download, weil dafuer weder curl-Optionen noch unzip noetig sind.
#
# Konfiguration ueber Vercel-Umgebungsvariablen (Project Settings -> Environment
# Variables):
#   SUPABASE_URL       optional, faellt auf das Projekt dieses Repos zurueck
#   SUPABASE_ANON_KEY  optional; fehlt er, laeuft die App im Offline-Modus mit
#                      den eingebauten Aufgaben - das ist ein gueltiger Zustand,
#                      kein Fehler
#   FLUTTER_VERSION    optional, Branch oder Tag; Standard: stable

set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-stable}"
FLUTTER_DIR="${FLUTTER_DIR:-$HOME/flutter}"

echo "==> Flutter SDK ($FLUTTER_VERSION) bereitstellen"
if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
    git clone --depth 1 --branch "$FLUTTER_VERSION" \
        https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi

# Der Build laeuft unter einem anderen Benutzer als der Clone-Vorgang; ohne das
# bricht git mit "detected dubious ownership" ab und Flutter kann seine Version
# nicht bestimmen.
git config --global --add safe.directory "$FLUTTER_DIR" || true

export PATH="$FLUTTER_DIR/bin:$PATH"
export FLUTTER_SUPPRESS_ANALYTICS=true
export CI=true

flutter --version

echo "==> Abhaengigkeiten aufloesen"
flutter pub get

echo "==> Web-Build erzeugen"
flutter build web --release \
    --dart-define=SUPABASE_URL="${SUPABASE_URL:-https://zcxhrkwbulsedkxcbkkk.supabase.co}" \
    --dart-define=SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY:-}"

echo "==> Fertig. Inhalt von build/web:"
ls -la build/web

if [ ! -f build/web/index.html ]; then
    echo "FEHLER: build/web/index.html fehlt - der Build hat nichts erzeugt." >&2
    exit 1
fi
