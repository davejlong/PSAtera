function Build-GetRequest([string]$endpoint) {
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
function Set-AteraAPIKey([string]$APIKey) {
  $script:AteraAPIKey = $APIKey
}
function Get-AteraAPIKey {
  return $AteraAPIKey
}

$RecordLimit = 1000
function Set-AteraRecordLimit([int]$Limit) {
  $script:RecordLimit = $Limit
}
function Get-AteraRecordLimit {
  $RecordLimit
}


###
# Agent Endpoint
###
function Get-AteraAgents {
  return Build-GetRequest -Endpoint "/agents"
}

function Get-AteraAgents {
  param(
    # Customer ID to retrieve list of agents for
    [int]$CustomerID
  )
  return Build-GetRequest -Endpoint "/agents/$CustomerID"
}

function Get-AteraAgent {
  param(
    # ID of agent to retrieve
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/agents/$AgentID"
}

function Get-AteraAgent {
  param(
    # Hostname of machine to retrieve. Defaults to current device host name
    [string]$MachineName=$env:COMPUTERNAME
  )
  
  return Build-GetRequest -Endpoint "/agents/machine/$MachineName"
}

###
# Alert Endpoint
###
function Get-AteraAlerts {
  return Build-GetRequest -Endpoint "/alerts"
}

function Get-AteraAlert {
  param(
    # ID of Alert to retrieve  
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/alerts/$alertId"
}

###
# Billing Endpoint
###
function Get-AteraInvoices {
  return Build-GetRequest -Endpoint "/invoices"
}

###
# Contact Endpoint
###
function Get-AteraContacts {
  return Build-GetRequest -Endpoint "/contacts"
}

###
# Contract Endpoint
###
function Get-AteraContracts {
  return Build-GetRequest -Endpoint "/contracts"
}

###
# Customers Endpoint
###
function Get-AteraCustomers {
  return Build-GetRequest -Endpoint "/customers"
}

###
# Knowledgebase Endpoint
###
function Get-AteraKnowledgebase {
  return Build-GetRequest -Endpoint "/knowledgebase"
}

###
# Rates Endpoint
###
function Get-AteraProducts {
  return Build-GetRequest -Endpoint "/rates/products"
}
function Get-AteraExpenses {
  return Build-GetRequest -Endpoint "/rates/expenses"
}

###
# Ticket Endpoint
###
function Get-AteraTickets {
  return Build-GetRequest -Endpoint "/tickets"
}

function Get-AteraTicket {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/tickets/$ID"
}

function Get-AteraTicketBillableDuration {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/tickets/$ID/billableduration"
}

function Get-AteraTicketNonBillableDuration {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/tickets/$ID/nonbillableduration"
}

function Get-AteraTicketWorkHours {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/tickets/$ID/workhours"
}

function Get-AteraTicketWorkHoursList {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/tickets/$ID/workhoursrecords"
}

function Get-AteraTicketComments {
  param(
    # ID of ticket to retrieve
    [int]$ID
  )
  return Build-GetRequest -Endpoint "/tickets/$ID/comments"
}

Export-ModuleMember -Function Get-Atera*,Set-Atera*
