<#
  .Synopsis
  Generic command for making GET requests against the Atera API
  
  .Parameter Endpoint
  Endpoint to request, beginning with a /
  
  .Parameter Paginate
  Whether to paginate the request. If set to false, will only query the first page of results.
  
  .Example
  # Get a customer
  New-AteraGetRequest -Endpoint "/customers/3"

  .Example
  # Get a custom value (which needs to not paginate)
  New-AteraGetRequest -Endpoint "/customvalues/ticketfield/2/Product%20Family" -Paginate $false
#>
function New-AteraGetRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter()]
    [bool] $Paginate=$true
  )
  $ApiKey = Get-AteraAPIKey
  if (!$ApiKey) { return }
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = $ApiKey
  }
  $ItemsInPage = 50
  $Uri = "https://app.atera.com/api/v3$($endpoint)?itemsInPage=$ItemsInPage"
  $items = @()
  $index = 0

  do {
    Write-Debug "[PSAtera] Request for $Uri"
    $data = Invoke-RestMethod -Uri $Uri -Method "GET" -Headers $Headers
    if (!$Paginate) { return $data }
    $items += $data.items
    $index += 1
    $Uri = $data.nextLink
  } while ($Uri -ne "" -and $index -lt [math]::ceiling($RecordLimit / $ItemsInPage))
  return $items
}

<#
  .Synopsis
  Generic command for making POST requests against the Atera API
  
  .Parameter Endpoint
  Endpoint to request, beginning with a /

  .Parameter Body
  Hashtable of data to send in POST request

  .Example
  # Create a new Contact
  New-AteraPostRequest -Endpoint "/contacts" -Body @{CustomerID=5; Email="john@example.com"}
#>
function New-AteraPostRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter(Mandatory, ValueFromPipeline)]
    [Hashtable] $Body
  )
  $ApiKey = Get-AteraAPIKey
  if (!$ApiKey) { return; }
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = $ApiKey
  }
  $Uri = "https://app.atera.com/api/v3$($endpoint)"
  Write-Debug "[PSAtera] Request for $Uri"
  $data = Invoke-RestMethod -Uri $Uri -Method "POST" -Headers $Headers -Body $body
  return $data
}

$AteraAPIKey = $env:ATERAAPIKEY
<#
  .Synopsis
  Set the Atera API Key used by the module. If none set, the ATERAAPIKEY environment variable will be used instead.
  
  .Parameter APIKey
  Atera API Key which can be found at https://app.atera.com/Admin#/admin/api
#>
function Set-AteraAPIKey {
  param(
    # Atera API Key
    [string]$APIKey
  )
  $script:AteraAPIKey = $APIKey
}

<#
  .Synopsis
  Get the Atera API Key in use by the module.
#>
function Get-AteraAPIKey {
  if (!$AteraAPIKey) { Write-Error "`$AteraAPIKey not set. Set it with either Set-AteraAPIKey or `$env:ATERAAPIKEY"; return $false }
  return $AteraAPIKey
}

$RecordLimit = 1000
<#
  .Synopsis
  Set the maximum number of records returned by API calls. Default is set at 1,000.

  .Parameter Limit
  Number of total records returned by Get- command
#>
function Set-AteraRecordLimit {
  param(
    # Maximum records returned
    [Parameter(Mandatory=$true)]
    [int]$Limit
  )
  $script:RecordLimit = $Limit
}
<#
  .Synopsis
  Get the maximum number of records returned by API calls.
#>
function Get-AteraRecordLimit {
  $RecordLimit
}

<#
  .Synopsis
  Installs the Atera Agent for a device

  .Parameter Subdomain
  Atera instances subdomain (ex. for https://example.atera.com/GetAgent... the subdomain is 'example')

  .Parameter IntegratorLogin
  Your Atera username

  .Parameter CustomerID
  Customer ID to assign agent to

  .Example
  # Install agent
  Install-AteraAgent -Subdomain example -IntegratorLogin john@example.com -CustomerID 2

  .Example
  # Search for a customer to install the agent for
  Get-AteraCustomers | Where CustomerName -eq "Contoso" | Install-AteraAgent -Subdomain example -IntegratorLogin john@example.com
#>
function Install-AteraAgent {
  param (
    [Parameter(Mandatory)]
    [string] $Subdomain,
    [Parameter(Mandatory)]
    [string] $IntegratorLogin,
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [int] $CustomerID=0
  )
  if (Get-Service -Name "AteraAgent" -ErrorAction SilentlyContinue) {
    Write-Host "Atera Agent already installed."
    return
  }

  Write-Debug "Downloading Atera Installer"
  $TempFile = Join-Path -Path $env:TEMP -ChildPath "AteraAgent.msi"
  Invoke-WebRequest -Uri "http://$Subdomain.atera.com/GetAgent/Msi/?CustomerID=$CustomerID&IntegratorLogin=$IntegratorLogin" -OutFile $TempFile
  Write-Debug "Installing Atera"
  $proc = Start-Process (Join-Path -Path $env:SystemRoot -ChildPath "system32\msiexec.exe") -PassThru -Wait -ArgumentList "/I","$TempFile","/quiet"
  Write-Host "Exit code: $($proc.ExitCode)"
  if ($proc.ExitCode -eq 0) { Write-Host "Atera Agent installed" -ForegroundColor Green }
  else { Write-Error "Installation failed with exit code $($proc.ExitCode)" -Category InvalidResult }
}

Get-ChildItem -Path $PSScriptRoot/endpoints | ForEach-Object { . $_.PSPath }

Export-ModuleMember -Function Install-AteraAgent,Get-Atera*,Set-Atera*,New-Atera*