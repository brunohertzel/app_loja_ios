param([Parameter(Mandatory=$true)][string]$Root,[Parameter(Mandatory=$true)][string]$PackageId)
$ErrorActionPreference='Stop'
if ($PackageId -notmatch '^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)+$') { throw 'Package ID invalido.' }
$template=Join-Path $PSScriptRoot 'MainActivity.kt.template'
if (!(Test-Path $template)) { throw 'Template nativo de notificacoes ausente. Use o pacote completo atualizado.' }
$text=[System.IO.File]::ReadAllText($template,[System.Text.Encoding]::UTF8).Replace('__PACKAGE_ID__',$PackageId)
$kotlinRoot=Join-Path $Root 'android/app/src/main/kotlin'
$target=Join-Path $kotlinRoot ($PackageId.Replace('.','/')+'/MainActivity.kt')
New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
Get-ChildItem $kotlinRoot -Filter MainActivity.kt -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -ne $target } | Remove-Item -Force
if (!(Test-Path $target) -or [System.IO.File]::ReadAllText($target,[System.Text.Encoding]::UTF8) -cne $text) {
 [System.IO.File]::WriteAllText($target,$text,(New-Object System.Text.UTF8Encoding($false)))
}

$manifest=Join-Path $Root 'android/app/src/main/AndroidManifest.xml'
if (Test-Path $manifest) {
 $xml=[System.IO.File]::ReadAllText($manifest,[System.Text.Encoding]::UTF8)
 if ($xml -notmatch 'android.permission.POST_NOTIFICATIONS') {
  $xml=[regex]::Replace($xml,'<manifest([^>]*)>','<manifest$1>'+[Environment]::NewLine+'    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />')
  [System.IO.File]::WriteAllText($manifest,$xml,(New-Object System.Text.UTF8Encoding($false)))
 }
}
