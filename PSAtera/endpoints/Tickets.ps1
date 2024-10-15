
<#
  .Synopsis
  Get a list of all tickets in Atera. Defaults to open and pending tickets when no options provided.
  
  .Parameter Open
  Queries tickets with the open status
  .Parameter Pending
  Queries tickets with the pending status
  .Parameter Resolved
  Queries tickets with the resolved status
  .Parameter Closed
  Queries tickets with the closed status
  .Parameter CustomStatuses
  Queries tickets with custom statuses, ex: -CustomStatuses "Waiting customer,Waiting order"
  .Parameter CustomerID
#>
function Get-AteraTickets {
    param(
        [Parameter(ParameterSetName="Filtered")]
        [switch] $Open,
        [Parameter(ParameterSetName="Filtered")]
        [switch] $Pending,
        [Parameter(ParameterSetName="Filtered")]
        [switch] $Resolved,
        [Parameter(ParameterSetName="Filtered")]
        [switch] $Closed,
        [Parameter(ParameterSetName="Filtered")]
        [string[]] $CustomStatuses,
        [int] $CustomerID
    )
    if ($PSCmdlet.ParameterSetName -ne "Filtered") {
        $PSBoundParameters["Open"] = $true
        $PSBoundParameters["Pending"] = $true
    }
    $Tickets = @()
    $Query = @{}
    if ($PSBoundParameters.ContainsKey("CustomerID")) { $Query.Add("customerId", $CustomerID) }

    if ($CustomStatuses) {
        $CustomStatuses = $CustomStatuses -join ","
        foreach ($ticketStatus in $CustomStatuses.Split(",")) {
            if ($ticketStatus) {
                $Tickets += New-AteraGetRequest -Endpoint "/tickets" -Query ($Query + @{ "ticketStatus" = $ticketStatus })
            }
        }
    }

    @("Open", "Pending", "Resolved", "Closed") | ForEach-Object {
        if ($PSBoundParameters[$_]) {
            $Tickets += New-AteraGetRequest -Endpoint "/tickets" -Query ($Query + @{"ticketStatus" = $_})
        }
    }
    $Tickets
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
  [Deprecated] Use `Get-AteraTickets` instead
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

  Get-AteraTickets @PSBoundParameters
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

<#
  .Synopsis
  Adds a comment into a ticket

  .Parameter TicketID
  ID of the ticket to update
  .Parameter CommentText
  Comment text to add to the ticket
  .Parameter CommentTimestampUTC
  UTC timestamp of the comment, ex: 2024-10-15T20:19:01.845Z
  .Parameter TechnicianID
  ID of the technician adding the comment
  .Parameter IsInternal
  If the comment is internal or not (Options: $true, $false, default: $false)
  .Parameter UserId
  ID of the user adding the comment
#>
function New-AteraTicketComment {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $TicketID,
    [Parameter()]
    [string] $CommentText,
    [Parameter()]
    [string] $CommentTimestampUTC,
    [Parameter()]
    [int] $TechnicianID,
    [Parameter()]
    [bool] $IsInternal=$false,
    [Parameter()]
    [int] $UserId
  )
  $Body = @{}

  if ($CommentText -ne "") { $Body["CommentText"] = $CommentText }
  if ($CommentTimestampUTC -ne "") { $Body.CommentTimestampUTC = $CommentTimestampUTC }
  
  # We don't set both Technician and User ID
  if ($TechnicianID -ne "") {
    $Body["TechnicianCommentDetails"] = @{}
    if ($TechnicianID -ne "") { $Body.TechnicianCommentDetails.TechnicianID = $TechnicianID }
    $Body.TechnicianCommentDetails.IsInternal = $IsInternal
  } elseif ($UserId -ne "") {
    $Body["EnduserCommentDetails"] = @{}
    if ($UserId -ne "") { $Body.EnduserCommentDetails.UserId = $UserId }
  }

  if (!$Body.Count) { throw "At least one update parameter needs to be set" }

  New-AteraPostRequest -Endpoint "/tickets/$($TicketID)/comments" -Body $Body
}
