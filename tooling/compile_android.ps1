param(
    [string]$ApiBaseUrl = '',
    [ValidateSet('apk','appbundle')][string]$Artifact = 'apk'
)
$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Push-Location $Root
try {
    # Apenas o endereco da API e usado para localizar o cliente. Identidade e
    # release sao consultados novamente no servidor antes de cada compilacao.
    if ([string]::IsNullOrWhiteSpace($ApiBaseUrl)) {
        $configPath = Join-Path $PSScriptRoot 'mobile_app_config.json'
        if (-not (Test-Path $configPath)) { throw 'Informe a API: .\COMPILAR_ANDROID.cmd https://CLIENTE/api/mobile/v1' }
        $config = [System.IO.File]::ReadAllText($configPath, [System.Text.Encoding]::UTF8) | ConvertFrom-Json
        $ApiBaseUrl = [string]$config.api_base_url
    }
    $ApiBaseUrl = $ApiBaseUrl.Trim().TrimEnd('/')
    $uri = $null
    if (-not [Uri]::TryCreate($ApiBaseUrl, [UriKind]::Absolute, [ref]$uri) -or $uri.Scheme -notin @('http','https')) {
        throw 'URL da API invalida. Informe a URL do cliente ao COMPILAR_ANDROID.cmd.'
    }
    & (Join-Path $PSScriptRoot 'sync_android_branding.ps1') -ApiBaseUrl $ApiBaseUrl
    if ($LASTEXITCODE -ne 0) { throw 'Falha sincronizando a API. Nenhum build sera iniciado.' }
    & flutter clean
    if ($LASTEXITCODE -ne 0) { throw 'flutter clean falhou.' }
    & flutter pub get
    if ($LASTEXITCODE -ne 0) { throw 'flutter pub get falhou.' }
    & flutter build $Artifact --release "--dart-define=SOFT_API_BASE_URL=$ApiBaseUrl"
    if ($LASTEXITCODE -ne 0) { throw 'Build falhou. Nao instale um APK/AAB antigo da pasta build.' }
    if ($Artifact -eq 'apk') {
        Write-Host 'APK: build/app/outputs/flutter-apk/app-release.apk' -ForegroundColor Green
    } else {
        Write-Host 'AAB: build/app/outputs/bundle/release/app-release.aab' -ForegroundColor Green
    }
} catch {
    Write-Error $_ -ErrorAction Continue
    exit 1
} finally { Pop-Location }
exit 0
