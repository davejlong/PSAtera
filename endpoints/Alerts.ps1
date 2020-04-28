function Get-AteraAlerts {
  return New-GetRequest -Endpoint "/alerts"
}

function Get-AteraAlert {
  param(
    # ID of Alert to retrieve  
    [int]$ID
  )
  return New-GetRequest -Endpoint "/alerts/$alertId"
}

function Get-AteraAlertsFiltered {
  param(
    # Get Open alerts
    [switch] $Open,
    # Get Closed alerts
    [switch] $Closed,
    # Get Information alerts
    [switch] $Information,
    # Get Warning alerts
    [switch] $Warning,
    # Get Critical alerts
    [switch] $Critical
  )

  return Get-AteraAlerts | Where-Object {
    if ($Open.IsPresent -and $_.Archived) { return $false}
    if ($Closed.IsPresent -and !$_.Archived) { return $false }

    if ($Information.IsPresent -and $_.Severity -ne "Information") { return $false }
    if ($Warning.IsPresent -and $_.Severity -ne "Warning") { return $false }
    if ($Critical.IsPresent -and $_.Severity -ne "Critical") { return $false }
    return $true
  }
}