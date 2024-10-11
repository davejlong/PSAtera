<#
  .Synopsis
  Get all Atera alerts. Defaults to open alerts when no options provided.

  .Parameter Open
  Queries alerts with the open status
  .Parameter Resolved
  Queries alerts with the resolved status
  .Parameter Snoozed
  Queries alerts with the snoozed status
  .Parameter Critical
  Queries alerts with critical priority (note: parameter not supported in API and may effect command performance)
  .Parameter Warning
  Queries alerts with warning priority (note: parameter not supported in API and may effect command performance)
  .Parameter Information
  Queries alerts with information priority (note: parameter not supported in API and may effect command performance)
#>
function Get-AteraAlerts {
  param(
    [switch] $Open=!($PSBoundParameters.Keys | Where-Object { @("Resolved", "Snoozed") -match $_ }),
    [switch] $Resolved,
    [switch] $Snoozed,
    [switch] $Critical,
    [switch] $Warning,
    [switch] $Information
  )
  $Alerts = @()
  $Query = @{}

  @("Open", "Resolved", "Snoozed") | ForEach-Object {
    if (Get-Variable $_ -ValueOnly) {
      $Alerts += New-AteraGetRequest "/alerts" -Query ($Query + @{"alertStatus" = $_})
    }
  }

  if ($Critical -or $Warning -or $Information) {
    return $Alerts | Where-Object {
      return $PSBoundParameters[$_.Severity]
    }
  }
  $Alerts
}

<#
  .Synopsis
  Get an alert based on it's ID
#>
function Get-AteraAlert {
  param(
    # ID of Alert to retrieve
    [Parameter(Mandatory)]
    [int]$AlertID
  )
  return New-AteraGetRequest -Endpoint "/alerts/$AlertID" -Paginate $false
}

<#
  .Synopsis
  [Deprecated] Use `Get-AteraAlerts` instead
#>
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
  Get-AteraAlerts @PSBoundParameters
}

<#
  .Synopsis
  Creates a new Atera alert

  .Parameter DeviceGuid
  ID of the agent to open alert against. Can be retrieved from Atera Agents endpoint
  .Parameter CustomerID
  Customer ID to open alert in.
  .Parameter Title
  Title to give the alert
  .Parameter Severity
  Severity of the alert. Defaults to Warning. Options: Information, Warning, Critical
  .Parameter AlertCategoryID
  Category of alert. Defaults to General. Options: Hardware, Disk, Availability, Performance, Exchange, General
  .Parameter TicketID
  Ticket that alert is assigned to
  .Parameter Code
  ?
  .Parameter ThresholdValue1
  Optional field to store alert information. Only available through API
  .Parameter ThresholdValue2
  Optional field to store alert information. Only available through API
  .Parameter ThresholdValue3
  Optional field to store alert information. Only available through API
  .Parameter ThresholdValue4
  Optional field to store alert information. Only available through API
  .Parameter ThresholdValue5
  Optional field to store alert information. Only available through API
  .Parameter SnooozedEndDate
  If alert is snoozed tracks when to notify about the alert
  .Parameter AdditionalInfo
  Optional field to store alert information. Only available through API
  .Parameter MessageTemplate
  ?
  .Parameter FolderID
  ?

  .Example
  $BatteryReport = Join-Path $env:TEMP "batteryreport.xml"
  $Proc = Start-Process -FilePath powercfg.exe -ArgumentList "/batteryreport /xml /output $($BatteryReport)" -PassThru -NoNewWindow -Wait

  if ($Proc.ExitCode -eq 1) {
    Write-Output "No battery present"
    exit
  }

  $Report = ([xml](Get-Content $BatteryReport)).BatteryReport

  $MaxCharge = $Report.Batteries.Battery.FullChargeCapacity
  $DesignCapacity = $Report.Batteries.Battery.DesignCapacity
  $BatteryHealth = $MaxCharge / $DesignCapacity

  if ($BatteryHealth -gt 0.5) {
    Write-Output "Battery is charging to $([math]::Round($BatteryHealth*100, 2))% of designed capacity"
    exit
  }
  # Create the alert saving the charge percentage in Threshold Value 1, the Max Charge in Threshold Value 2 and the Designed capacity in Threshold Value 3
  Get-AteraAgent | New-AteraAlert -Title "Battery unhealthy" -Severity Warning -AlertCategoryID Hardware -ThresholdValue1 $BatteryHealth -ThresholdValue2 $MaxCharge -ThresholdValue3 $DesignCapacity
#>
function New-AteraAlert {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [string] $DeviceGuid,
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [int]$CustomerID,
    [Parameter(Mandatory)]
    [string] $Title,
    [ValidateSet("Information","Warning","Critical")]
    [string] $Severity = "Warning",
    [ValidateSet("Hardware","Disk","Availability","Performance","Exchange","General")]
    [string] $AlertCategoryID = "General",
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
