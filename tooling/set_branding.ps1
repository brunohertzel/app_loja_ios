param(
    [Parameter(Mandatory=$true)][string]$PackageId,
    [Parameter(Mandatory=$true)][string]$AppName
)

$ErrorActionPreference = "Stop"
$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

if ($PackageId -notmatch '^[a-zA-Z][a-zA-Z0-9_]*(\.[a-zA-Z][a-zA-Z0-9_]*)+$') {
    throw "PackageId invalido: $PackageId"
}

$gradleKts = Join-Path $Root "android/app/build.gradle.kts"
if (Test-Path $gradleKts) {
    $g = Get-Content $gradleKts -Raw
    $g = [regex]::Replace($g, 'namespace\s*=\s*"[^"]+"', ('namespace = "' + $PackageId + '"'))
    $g = [regex]::Replace($g, 'applicationId\s*=\s*"[^"]+"', ('applicationId = "' + $PackageId + '"'))
    Set-Content -Encoding UTF8 $gradleKts $g
}

$gradle = Join-Path $Root "android/app/build.gradle"
if (Test-Path $gradle) {
    $g = Get-Content $gradle -Raw
    $g = [regex]::Replace($g, 'namespace\s+["''][^"'']+["'']', ('namespace "' + $PackageId + '"'))
    $g = [regex]::Replace($g, 'applicationId\s+["''][^"'']+["'']', ('applicationId "' + $PackageId + '"'))
    Set-Content -Encoding UTF8 $gradle $g
}

$manifest = Join-Path $Root "android/app/src/main/AndroidManifest.xml"
if (Test-Path $manifest) {
    $m = Get-Content $manifest -Raw
    $m = [regex]::Replace($m, 'android:label="[^"]*"', ('android:label="' + $AppName + '"'))
    Set-Content -Encoding UTF8 $manifest $m
}

$strings = Join-Path $Root "android/app/src/main/res/values/strings.xml"
New-Item -ItemType Directory -Force -Path (Split-Path $strings) | Out-Null
$escaped = [System.Security.SecurityElement]::Escape($AppName)
@"
<resources>
    <string name="app_name">$escaped</string>
</resources>
"@ | Set-Content -Encoding UTF8 $strings

& (Join-Path $PSScriptRoot 'write_android_activity.ps1') -Root $Root -PackageId $PackageId

Write-Host "Branding Android aplicado: $AppName / $PackageId" -ForegroundColor Green
