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
    if ($Open.IsPresent -and !$_.Archived) { return $true }
    if ($Closed.IsPresent -and $_.Archived) { return $true }

    if ($Information.IsPresent -and $_.Severity -eq "Information") { return $true }
    if ($Warning.IsPresent -and $_.Severity -eq "Warning") { return $true }
    if ($Critical.IsPresent -and $_.Severity -eq "Critical") { return $true }
  }
}