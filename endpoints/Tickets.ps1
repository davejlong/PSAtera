
<#
  .Synopsis
  Get a list of all tickets in Atera
#>
function Get-AteraTickets {
  return New-AteraGetRequest -Endpoint "/tickets"
}

<#
  .Synopsis
  Get a single ticket by it's ID

  .Parameter TicketID
#>
function Get-AteraTicket {
  param(
    # ID of ticket to retrieve
    [int]$TicketID
  )
  return New-AteraGetRequest -Endpoint "/tickets/$TicketID" -Paginate $false
}

<#
  .Synopsis
  Get the billable time spent on a ticket

  .Parameter TicketID
#>
function Get-AteraTicketBillableDuration {
  param(
    # ID of ticket to retrieve
    [int]$TicketID
  )
  return New-AteraGetRequest -Endpoint "/tickets/$TicketID/billableduration" -Paginate $false
}

<#
  .Synopsis
  Get the nonbillable time spent on a ticket
  .Parameter TicketID
#>
function Get-AteraTicketNonBillableDuration {
  param(
    # ID of ticket to retrieve
    [int]$TicketID
  )
  return New-AteraGetRequest -Endpoint "/tickets/$TicketID/nonbillableduration" -Paginate $false
}

<#
  .Synopsis
  Get both the billable and nonbillable time spent on a ticket

  .Parameter TicketID
#>
function Get-AteraTicketWorkHours {
  param(
    # ID of ticket to retrieve
    [int]$TicketID
  )
  return New-AteraGetRequest -Endpoint "/tickets/$TicketID/workhours" -Paginate $false
}

<#
  .Synopsis
  Get a list of time sheets for a ticket

  .Parameter TicketID
#>
function Get-AteraTicketWorkHoursList {
  param(
    # ID of ticket to retrieve
    [int]$TicketID
  )
  return New-AteraGetRequest -Endpoint "/tickets/$TicketID/workhoursrecords"
}

<#
  .Synopsis
  Get all comments on a ticket

  .Parameter TicketID
#>
function Get-AteraTicketComments {
  param(
    # ID of ticket to retrieve
    [int]$TicketID
  )
  return New-AteraGetRequest -Endpoint "/tickets/$TicketID/comments"
}

<#
  .Synopsis
  Get a filtered list of tickets from the API
  .Parameter Open
  .Parameter Pending
  .Parameter Resolved
  .Parameter Closed

  .Example
  Get-AteraTicketsFiltered -Open -Pending
  # Get all open or pending tickets
#>
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

<#
  .Synopsis
  Create a new ticket
  .Parameter TicketTitle
  .Parameter Description
  .Parameter EndUserID
  ID of the contact submitting the ticket
  .Parameter EndUserFirstName
  If the contact does not exist, one will be created using this value as the first name
  .Parameter EndUserLastName
  If the contact does not exist, one will be created using this value as the last name
  .Parameter EndUserEmail
  Create a new or search for a contact by email
  .Parameter TicketPriority
  Priority level for new ticket. Defaults to Low. Options: Low, Medium, High, Critical
  .Parameter TicketImpact
  Impact of the issue reported. Defaults to Minor. Options: NoImpact, Minor, Major, Site Down, Server Issue, Crisis
  .Parameter TicketStatus
  Current status of ticket. Defaults to Open. Options: Open, Pending, Resolved, Closed
  .Parameter TicketType
  Type of ticket being reported. Defaults to Problem. Options: Problem, Bug, Request, Other, Incident, Change
  .Parameter TechnicianContactID

  .Example
  Get-AteraContacts | Where-Object Email -eq "john@example.com" | New-AteraTicket -TicketTitle "Computer won't turn on" -Description "Some long description"
  # Create a new ticket for a user who's email is john@example.com

  .Example
  New-AteraTicket -TicketTitle "Update Sage Server" -Description "Some long description" -TicketType Change -EndUserEmail john@example.com -EndUserFirstName John -EndUserLastName Smith
  # Create a new ticket for John Smith, creating his contact if it doesn't exist.
#>
function New-AteraTicket {
  [CmdletBinding(DefaultParameterSetName='ExistingContact')]
  param (
    [Parameter(Mandatory)]
    [string] $TicketTitle,
    [Parameter(Mandatory)]
    [string] $Description,
    [Parameter(Mandatory, ParameterSetName='ExistingContact', ValueFromPipelineByPropertyName)]
    [int] $EndUserID,
    [Parameter(Mandatory, ParameterSetName='NewContact')]
    [string] $EndUserFirstName,
    [Parameter(Mandatory, ParameterSetName='NewContact')]
    [string] $EndUserLastName,
    [Parameter(Mandatory, ParameterSetName='NewContact')]
    [string] $EndUserEmail,
    [Parameter()]
    [ValidateSet("Low", "Medium", "High", "Critical")]
    [string] $TicketPriority = "Low",
    [Parameter()]
    [ValidateSet("NoImpact", "SiteDown", "ServerIssue", "Minor", "Major", "Crisis")]
    [string] $TicketImpact = "Minor",
    [Parameter()]
    [ValidateSet("Open", "Pending", "Resolved", "Closed")]
    [string] $TicketStatus = "Open",
    [Parameter()]
    [ValidateSet("Problem" ,"Bug", "Request", "Other", "Incident", "Change")]
    [string] $TicketType = "Problem",
    [Parameter()]
    [int] $TechnicianContactID
  )
  New-AteraPostRequest -Endpoint "/tickets" -Body $PSBoundParameters
}

<#
  .Synopsis
  Updates details about a ticket

  .Parameter TicketID
  ID of the ticket to update
  .Parameter TicketTitle
  New title for ticket
  .Parameter TicketStatus
  New status for ticket (Options: Open, Pending, Resolved, Closed)
  .Parameter TicketType
  New type for ticket (Options: Problem, Bug, Question, Request, Other, Incident, Change)
  .Parameter TicketPriority
  New priority for ticket (Options: Low, Medium, High, Critical)
  .Parameter TicketImpact
  New impact for ticket (Options: NoImpact, SiteDown, ServiceIssue, Minor, Major, Crisis)
  .Parameter TechnicianContactID
  New technician ID to assign ticket to
#>
function Set-AteraTicket {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $TicketID,
    [Parameter()]
    [string] $TicketTitle,
    [Parameter()]
    [ValidateSet("Open", "Pending", "Resolved", "Closed")]
    [string] $TicketStatus,
    [Parameter()]
    [ValidateSet("Problem" ,"Bug", "Request", "Other", "Incident", "Change")]
    [string] $TicketType,
    [Parameter()]
    [ValidateSet("Low", "Medium", "High", "Critical")]
    [string] $TicketPriority,
    [Parameter()]
    [ValidateSet("NoImpact", "SiteDown", "ServerIssue", "Minor", "Major", "Crisis")]
    [string] $TicketImpact,
    [Parameter()]
    [int] $TechnicianContactID
  )
  $Body = @{}
  if ($TickeTitle -ne "") { $Body["TicketTitle"] = $TicketTitle }
  if ($TicketStatus -ne "") { $Body.TicketStatus = $TicketStatus }
  if ($TicketType -ne "") { $Body.TicketType = $TicketType }
  if ($TicketPriority -ne "") { $Body.TicketPriority = $TicketPriority }
  if ($TicketImpact -ne "") { $Body.TicketImpact = $TicketImpact }
  if ($TechnicianContactID -ne "") { $Body.TechnicianContactID = $TechnicianContactID }
  if (!$Body.Count) { throw "At least one update parameter needs to be set" }

  New-AteraPostRequest -Endpoint "/tickets/$($TicketID)" -Body $Body
}