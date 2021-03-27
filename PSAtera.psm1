Add-Type -AssemblyName System.Web

Get-ChildItem -Path $PSScriptRoot/Public | ForEach-Object { . $_.PSPath }
Get-ChildItem -Path $PSScriptRoot/Endpoints | ForEach-Object { . $_.PSPath }

<#
  .Synopsis
  Installs the Atera Agent for a device

  .Parameter Subdomain
  Atera instances subdomain (ex. for https://example.atera.com/GetAgent... the subdomain is 'example')

  .Parameter IntegratorLogin
  Your Atera username

  .Parameter CustomerID
  Customer ID to assign agent to. If not provided, assigned agent to the Unassigned customer in Atera

  .Example
  Install-AteraAgent -Subdomain example -IntegratorLogin john@example.com -CustomerID 2
  # Install agent

  .Example
  Get-AteraCustomers | Where CustomerName -eq "Contoso" | Install-AteraAgent -Subdomain example -IntegratorLogin john@example.com
  # Search for a customer to install the agent for
#>
function Install-AteraAgent {
  param (
    [Parameter(Mandatory)]
    [string] $Subdomain,
    [Parameter(Mandatory)]
    [string] $IntegratorLogin,
    [Parameter(ValueFromPipelineByPropertyName)]
    [int] $CustomerID = 0
  )
  if (Get-Service -Name "AteraAgent" -ErrorAction SilentlyContinue) {
    Write-Output "Atera Agent already installed."
    return
  }

  Write-Debug "Downloading Atera Installer"
  $TempFile = Join-Path -Path $env:TEMP -ChildPath "AteraAgent.msi"
  Invoke-WebRequest -Uri "http://$Subdomain.atera.com/GetAgent/Msi/?CustomerID=$CustomerID&IntegratorLogin=$IntegratorLogin" -OutFile $TempFile
  Write-Debug "Installing Atera"
  $proc = Start-Process (Join-Path -Path $env:SystemRoot -ChildPath "system32\msiexec.exe") -PassThru -Wait -ArgumentList "/I","$TempFile","/quiet"
  Write-Debug "Exit code: $($proc.ExitCode)"
  if ($proc.ExitCode -eq 0) { Write-Output "Atera Agent installed" -ForegroundColor Green }
  else { Write-Error "Installation failed with exit code $($proc.ExitCode)" -Category InvalidResult }
}


Export-ModuleMember -Function Install-AteraAgent,Get-Atera*,Set-Atera*,New-Atera*