# Traegt den Supabase-Anon-Key aus der Zwischenablage in env.json ein.
#
# Warum ueber die Zwischenablage: So muss der Key nirgends abgetippt werden
# und taucht weder in der Kommandozeilen-Historie noch in einem Chatverlauf
# auf. env.json steht in .gitignore.
#
# Ablauf:
#   1. Supabase-Dashboard -> Project Settings -> API Keys
#   2. Den Key "anon" / "public" (bzw. "Publishable key") kopieren
#   3. In diesem Ordner ausfuehren:  .\tool\set-anon-key.ps1

[CmdletBinding()]
param(
    [string] $EnvFile = (Join-Path $PSScriptRoot '..\env.json'),
    [string] $SupabaseUrl = 'https://zcxhrkwbulsedkxcbkkk.supabase.co'
)

$ErrorActionPreference = 'Stop'

$key = (Get-Clipboard -Raw)
if ($null -ne $key) { $key = $key.Trim() }

if ([string]::IsNullOrWhiteSpace($key)) {
    Write-Error 'Die Zwischenablage ist leer. Kopiere zuerst den anon/public Key aus dem Supabase-Dashboard.'
}

# Plausibilitaetspruefung, damit nicht versehentlich ein beliebiger
# Zwischenablage-Inhalt in die Konfiguration wandert.
$istLegacyJwt   = $key.StartsWith('eyJ')
$istPublishable = $key.StartsWith('sb_publishable_')

if (-not ($istLegacyJwt -or $istPublishable)) {
    Write-Error ("Das sieht nicht nach einem Supabase-Anon-Key aus (erwartet: beginnt mit 'eyJ' oder 'sb_publishable_'). " +
                 "Laenge des Zwischenablage-Inhalts: $($key.Length) Zeichen. Es wurde nichts geschrieben.")
}

# Der service_role-Key darf niemals in eine Client-App - er umgeht saemtliche
# RLS-Policies. Bei Legacy-JWTs steht die Rolle im Payload.
if ($istLegacyJwt) {
    $teile = $key.Split('.')
    if ($teile.Length -ge 2) {
        $payload = $teile[1].Replace('-', '+').Replace('_', '/')
        while ($payload.Length % 4 -ne 0) { $payload += '=' }
        try {
            $json = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($payload))
            if ($json -match '"role"\s*:\s*"service_role"') {
                Write-Error 'Das ist der service_role-Key. Der umgeht alle RLS-Policies und darf nicht in eine Client-App. Kopiere stattdessen den anon/public Key.'
            }
        } catch {
            Write-Verbose 'JWT-Payload nicht lesbar - Pruefung uebersprungen.'
        }
    }
}

$config = [ordered]@{
    SUPABASE_URL      = $SupabaseUrl
    SUPABASE_ANON_KEY = $key
}

$config | ConvertTo-Json | Out-File -FilePath $EnvFile -Encoding utf8 -NoNewline

$art = if ($istPublishable) { 'Publishable Key' } else { 'Legacy Anon-Key (JWT)' }
Write-Output "OK - $art mit $($key.Length) Zeichen nach $(Resolve-Path $EnvFile) geschrieben."
Write-Output ''
Write-Output 'Starten mit:'
Write-Output '  flutter run -d chrome --dart-define-from-file=env.json'
