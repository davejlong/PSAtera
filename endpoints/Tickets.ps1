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