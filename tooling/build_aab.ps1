param([string]$ApiBaseUrl = '', [string]$ConfigFile = '')
$ErrorActionPreference = 'Stop'
if (-not [string]::IsNullOrWhiteSpace($ConfigFile)) {
    $cfg = [System.IO.File]::ReadAllText((Resolve-Path $ConfigFile).Path, [System.Text.Encoding]::UTF8) | ConvertFrom-Json
    if ([string]::IsNullOrWhiteSpace($ApiBaseUrl)) { $ApiBaseUrl = [string]$cfg.api_base_url }
}
& (Join-Path $PSScriptRoot 'compile_android.ps1') -ApiBaseUrl $ApiBaseUrl -Artifact appbundle
exit $LASTEXITCODE
