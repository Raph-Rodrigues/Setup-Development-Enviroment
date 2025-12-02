Write-Output "=== Windows setup (via PowerShell) — instale o que for possível via terminal ==="

# Exemplo: instalar .NET SDK 8/9/10 via script oficial PowerShell
$dotnetScriptUrl = "https://dot.net/v1/dotnet-install.ps1"
$dotnetInstallPath = "$env:USERPROFILE\\.dotnet"
Invoke-WebRequest -Uri $dotnetScriptUrl -OutFile "$env:TEMP\dotnet-install.ps1"
Write-Output "Executando script de instalação do .NET"
. "$env:TEMP\dotnet-install.ps1" -InstallDir $dotnetInstallPath -Channel 8.0
. "$env:TEMP\dotnet-install.ps1" -InstallDir $dotnetInstallPath -Channel 9.0
. "$env:TEMP\dotnet-install.ps1" -InstallDir $dotnetInstallPath -Channel 10.0

Write-Output ".NET SDK instalado no diretório $dotnetInstallPath — adicionar ao PATH manualmente se necessário."

# Outras ferramentas que possam ser instaladas via winget / choco / scoop poderiam ser chamadas aqui
Write-Output "ATENÇÃO: você deve instalar manualmente IDEs, engines e softwares pesados — veja Windows-Instructions.md"
