function Get-AteraTickets {
  return New-GetRequest -Endpoint "/tickets"
}

function Get-AteraTicket {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return New-GetRequest -Endpoint "/tickets/$ID"
}

function Get-AteraTicketBillableDuration {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return New-GetRequest -Endpoint "/tickets/$ID/billableduration"
}

function Get-AteraTicketNonBillableDuration {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return New-GetRequest -Endpoint "/tickets/$ID/nonbillableduration"
}

function Get-AteraTicketWorkHours {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return New-GetRequest -Endpoint "/tickets/$ID/workhours"
}

function Get-AteraTicketWorkHoursList {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return New-GetRequest -Endpoint "/tickets/$ID/workhoursrecords"
}

function Get-AteraTicketComments {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return New-GetRequest -Endpoint "/tickets/$ID/comments"
}

function Get-AteraTicketsFiltered {
  param(
    # Get Open tickets
    [switch] $Open,
    # Get Pending tickets
    [switch] $Pending,
    # Get Resolved tickets
    [switch] $Resolved,
    # Get Closed tickets
    [switch] $Closed
  )

  return Get-AteraTickets | Where-Object {
    $included = $false
    if ($Open.IsPresent -and $_.TicketStatus -eq "Open") { $included = $true }
    if ($Pending.IsPresent -and $_.TicketStatus -eq "Pending") { $included = $true }
    if ($Resolved.IsPresent -and $_.TicketStatus -eq "Resolved") { $included = $true }
    if ($Closed.IsPresent -and $_.TicketStatus -eq "Closed") { $included = $true }
    return $included
  }
}

function New-AteraTicket {
  [CmdletBinding(DefaultParameterSetName='ExistingContact')]
  param (
    [Parameter(Mandatory)]
    [string] $TicketTitle,
    [Parameter(Mandatory)]
    [string] $Description,
    [Parameter(Mandatory, ParameterSetName='ExistingContact')]
    [int] $EndUserID,
    [Parameter(Mandatory, ParameterSetName='NewContact')]
    [string] $EndUserFirstName,
    [Parameter(Mandatory, ParameterSetName='NewContact')]
    [string] $EndUserLastName,
    [Parameter(Mandatory, ParameterSetName='NewContact')]
    [string] $EndUserEmail,
    [Parameter()]
    [ValidateSet("Low", "Medium", "High", "Critical")]
    [string] $TicketPriority,
    [Parameter()]
    [ValidateSet("NoImpact", "SiteDown", "ServerIssue", "Minor", "Major", "Crisis")]
    [string] $TicketImpact,
    [Parameter()]
    [ValidateSet("Open", "Pending", "Resolved", "Closed")]
    [string] $TicketStatus,
    [Parameter()]
    [ValidateSet("Problem" ,"Bug", "Request", "Other", "Incident", "Change")]
    [string] $TicketType,
    [Parameter()]
    [int] $TechnicianContactID
  )
  New-PostRequest -Endpoint "/tickets" -Body $PSBoundParameters
}