$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
$nomes = @('TAOPS_DB_HOST','TAOPS_DB_USER','TAOPS_DB_PASSWORD','TAOPS_DB_SSL_CERT')
$anteriores = @{}
foreach ($nome in $nomes) { $anteriores[$nome] = [Environment]::GetEnvironmentVariable($nome, 'Process') }
$segredo = $null
$ponteiro = [IntPtr]::Zero
try {
    Write-Host 'TA Ops - conexao de leitura ao Laboratorio SQL'
    Write-Host 'Use Connect > Session pooler, porta 5432, no painel Supabase.'
    $dbHost = (Read-Host 'Cole somente o Host do Session pooler').Trim()
    if ($dbHost -notmatch '^[a-zA-Z0-9-]+\.pooler\.supabase\.com$') {
        throw 'Host invalido. Copie apenas o nome que termina em .pooler.supabase.com.'
    }
    $certificado = (Read-Host 'Caminho completo do certificado CA baixado do Supabase').Trim().Trim('"')
    if (-not (Test-Path -LiteralPath $certificado -PathType Leaf)) {
        throw 'Certificado nao encontrado. Confira o caminho informado.'
    }
    $env:TAOPS_DB_HOST = $dbHost
    $env:TAOPS_DB_USER = 'taops_app.tkubetvrizvujluddhir'
    $env:TAOPS_DB_SSL_CERT = (Resolve-Path -LiteralPath $certificado).Path
    $segredo = Read-Host 'Senha que voce definiu para taops_app (fica oculta)' -AsSecureString
    if ($segredo.Length -eq 0) { throw 'A senha nao pode ficar vazia.' }
    $ponteiro = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($segredo)
    $env:TAOPS_DB_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ponteiro)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ponteiro)
    $ponteiro = [IntPtr]::Zero
    Write-Host 'Aguarde: TA Ops: conexao com o banco confirmada.'
    & .\mvnw.cmd 'spring-boot:run' '-Dspring-boot.run.profiles=banco'
    if ($LASTEXITCODE -ne 0) { throw 'A inicializacao falhou. Confira a mensagem anterior.' }
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
} finally {
    if ($ponteiro -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ponteiro) }
    if ($null -ne $segredo) { $segredo.Dispose() }
    foreach ($nome in $nomes) { [Environment]::SetEnvironmentVariable($nome, $anteriores[$nome], 'Process') }
}
Read-Host 'Pressione Enter para fechar'
