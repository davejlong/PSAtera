function Get-AteraCustomValue {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [ValidateSet("Ticket", "Customer", "Contact", "Contact", "Contract", "SLA", "Agent", "SNMP", "TCP", "HTTP", "Generic")]
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