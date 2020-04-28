function New-GetRequest([string]$endpoint) {
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $ItemsInPage = 50
  $Uri = "https://app.atera.com/api/v3$($endpoint)?itemsInPage=$ItemsInPage"
  $items = @()
  $index = 0

  do {
    $data = Invoke-RestMethod -Uri $Uri -Method "GET" -Headers $Headers
    $items += $data.items
    $index += 1
    $Uri = $data.nextLink
  } while ($Uri -ne "" -and $index -lt [math]::ceiling($RecordLimit / $ItemsInPage))
  return $items
}

$AteraAPIKey = $env:ATERAAPIKEY
<#
  .SYNOPSIS
    Set the Atera API Key used by the module. If none set, the ATERAAPIKEY environment
    variable will be used instead.
#>
function Set-AteraAPIKey {
  param(
    # Atera API Key
    [string]$APIKey
  )
  $script:AteraAPIKey = $APIKey
}
<#
  .SYNOPSIS
    Get the Atera API Key in use by the module.
#>
function Get-AteraAPIKey {
  if (!$AteraAPIKey) { Write-Error "`$AteraAPIKey not set. Set it with either Set-AteraAPIKey or `$env:ATERAAPIKEY"; exit 1 }
  return $AteraAPIKey
}

$RecordLimit = 1000
<#
  .SYNOPSIS
    Set the maximum number of records returned by API calls. Default is set at 1,000.
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
  .SYNOPSIS
    Get the maximum number of records returned by API calls.
#>
function Get-AteraRecordLimit {
  $RecordLimit
}

Get-ChildItem -Path $PSScriptRoot/endpoints | ForEach-Object { . $_.PSPath }

Export-ModuleMember -Function Get-Atera*,Set-Atera*