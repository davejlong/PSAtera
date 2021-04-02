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