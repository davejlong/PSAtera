function Get-AteraAlerts {
  return New-AteraGetRequest -Endpoint "/alerts"
}

function Get-AteraAlert {
  param(
    # ID of Alert to retrieve  
    [Parameter(Mandatory)]
    [int]$ID
  )
  return New-AteraGetRequest -Endpoint "/alerts/$alertId"
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

function New-AteraAlert {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $DeviceGuid,
    [Parameter(Mandatory)]
    [int]$CustomerID,
    [Parameter(Mandatory)]
    [string] $Title,
    [ValidateSet("Information","Warning","Critical")]
    [string] $Severity,
    [ValidateSet("Hardware","Disk","Availability","Performance","Exchange","General")]
    [string] $AlertCategoryID,
    [string] $AlertMessage,
    [int] $TicketID,
    # ?
    [int] $Code,
    # ?
    [string] $ThresholdValue1,
    # ?
    [string] $ThresholdValue2,
    # ?
    [string] $ThresholdValue3,
    # ?
    [string] $ThresholdValue4,
    # ?
    [string] $ThresholdValue5,
    [DateTime] $SnoozedEndDate,
    [string] $AdditionalInfo,
    # ?
    [string] $MessageTemplate,
    # ?
    [int] $FolderID
  )
  New-AteraPostRequest -Endpoint "/alerts" -Body $PSBoundParameters
}