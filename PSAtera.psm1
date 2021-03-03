Add-Type -AssemblyName System.Web

<#
  .Synopsis
  Generic command for making GET requests against the Atera API

  .Parameter Endpoint
  Endpoint to request, beginning with a /

  .Parameter Paginate
  Whether to paginate the request. If set to false, will only query the first page of results.

  .Example
  New-AteraGetRequest -Endpoint "/customers/3"
  # Get a customer

  .Example
  New-AteraGetRequest -Endpoint "/customvalues/ticketfield/2/Product%20Family" -Paginate $false
  # Get a custom value (which needs to not paginate)
#>
function New-AteraGetRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter()]
    [bool] $Paginate=$true,
    [Parameter()]
    [Hashtable] $Query
  )
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $ItemsInPage = 50
  $QueryString = Format-QueryString -Query $Query
  $Uri = "https://app.atera.com/api/v3$($endpoint)?itemsInPage=$ItemsInPage&$QueryString"
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
  New-AteraPostRequest -Endpoint "/contacts" -Body @{CustomerID=5; Email="john@example.com"}
  # Create a new Contact
#>
function New-AteraPostRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter(Mandatory, ValueFromPipeline)]
    [Hashtable] $Body
  )
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $Uri = "https://app.atera.com/api/v3$($endpoint)"
  Write-Debug "[PSAtera] Request for $Uri"
  $data = Invoke-RestMethod -Uri $Uri -Method "POST" -Headers $Headers -Body $body
  return $data
}

<#
  .Synopsis
  Generic command for making PUT requests against the Atera API. Basically the same as the
  New-AteraPostRequest command.

  .Parameter Endpoint
  Endpoint to request, beginning with a /

  .Parameter Body
  Hashtable of data to send in PUT request

  .Example
  New-AteraPutRequest -Endpoint "/customvalues/customerfield/1/age/5%20Years"
  # Updates the age field on customer 1 to "5 Years"
#>
function New-AteraPutRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter(ValueFromPipeline)]
    [Object] $Body
  )
  $Headers = @{
    "accept" = "application/json"
    "content-type" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $Uri = "https://app.atera.com/api/v3$($endpoint)"
  Write-Debug "[PSAtera] Request for $Uri"
  $Body | Write-Output
  $data = Invoke-RestMethod -Uri $Uri -Method "Put" -Headers $Headers -Body (ConvertTo-Json $Body)
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
  if (!$AteraAPIKey) { throw "`$AteraAPIKey not set. Set it with either Set-AteraAPIKey or `$env:ATERAAPIKEY" }
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

function Format-QueryString($Query) {
  $qs = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
  foreach($item in $Query.Keys) {
    $qs.Add($item, $Query[$item])
  }
  $qs.ToString()
}

Get-ChildItem -Path $PSScriptRoot/endpoints | ForEach-Object { . $_.PSPath }

Export-ModuleMember -Function Install-AteraAgent,Get-Atera*,Set-Atera*,New-Atera*