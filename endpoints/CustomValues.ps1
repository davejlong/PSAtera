
<#
  .Synopsis
  Get the value from a custom field in Atera

  .Parameter ObjectType
  The type of object to query against. Options: Ticket, Customer, Contact, Contract, SLA, Agent, SNMP, TCP, HTTP, Generic

  .Parameter ObjectID
  The ID of the object to query (ex. Ticket ID)

  .Parameter FieldName
  The name of the custom field

  .Example
  Get-AteraCustomValue -ObjectType Ticket -ObjectID 1234 -FieldName "Scheduled For"
  # Get the "Scheduled For" field for Ticket 1234
#>
function Get-AteraCustomValue {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [ValidateSet("Ticket", "Customer", "Contact", "Contract", "SLA", "Agent", "SNMP", "TCP", "HTTP", "Generic")]
    [string] $ObjectType,
    [Parameter(Mandatory)]
    [int] $ObjectID,
    [Parameter(Mandatory)]
    [string] $FieldName
  )
  $FieldName = [uri]::EscapeDataString($FieldName)
  $uri = "/customvalues/$($ObjectType.ToLower())field/$ObjectID/$FieldName"
  New-AteraGetRequest -Endpoint $uri -Paginate $false
}

<#
  .Synopsis
  Get the value from a custom field in Atera

  .Parameter ObjectType
  The type of object to query against. Options: Ticket, Customer, Contact, Contract, SLA, Agent, SNMP, TCP, HTTP, Generic

  .Parameter ObjectID
  The ID of the object to query (ex. Ticket ID)

  .Parameter FieldName
  The name of the custom field

  .Parameter Value
  The value of the custom field

  .Example
  Set-AteraCustomValue -ObjectType Ticket -ObjectID 1234 -FieldName "Scheduled For" -Value "2021-02-03"
  # Get the "Scheduled For" field for Ticket 1234
#>
function Set-AteraCustomValue {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [ValidateSet("Ticket", "Customer", "Contact", "Contract", "SLA", "Agent", "SNMP", "TCP", "HTTP", "Generic")]
    [string] $ObjectType,
    [Parameter(Mandatory)]
    [int] $ObjectID,
    [Parameter(Mandatory)]
    [string] $FieldName,
    [Parameter(Mandatory)]
    [string] $Value
  )
  $FieldName = [uri]::EscapeDataString($FieldName)
  $uri = "/customvalues/$($ObjectType.ToLower())field/$ObjectID/$FieldName"
  New-AteraPutRequest -Endpoint $uri -Body @{Value=$Value}
}