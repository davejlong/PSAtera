<#
  .Synopsis
  Get workhour records with optional date/rate filters.
#>
function Get-AteraWorkHours {
  [CmdletBinding()]
  param(
    [Parameter()]
    [string] $StartWorkhour,
    [Parameter()]
    [string] $EndWorkhour,
    [Parameter()]
    [bool] $IncludeRates = $false
  )
  $Query = @{
    includeRates = $IncludeRates
  }
  if ($PSBoundParameters.ContainsKey("StartWorkhour")) { $Query.startWorkhour = $StartWorkhour }
  if ($PSBoundParameters.ContainsKey("EndWorkhour")) { $Query.endWorkhour = $EndWorkhour }
  New-AteraGetRequest -Endpoint "/workhours" -Query $Query
}
