function Get-AteraCustomers {
  return New-GetRequest -Endpoint "/customers"
}

function New-AteraCustomer {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $CustomerName,
    [Parameter()]
    [string] $BusinessNumber,
    [Parameter()]
    [string] $Domain,
    [Parameter()]
    [string] $Address,
    [Parameter()]
    [string] $City,
    [Parameter()]
    [string] $State,
    [Parameter()]
    [string] $Country,
    [Parameter()]
    [string] $Phone,
    [Parameter()]
    [string] $Fax,
    [Parameter()]
    [string] $Notes,
    [Parameter()]
    [string] $Links,
    [Parameter()]
    [string] $Longitude,
    [Parameter()]
    [string] $Latitude,
    [Parameter()]
    [string] $ZipCodeStr
  )
  New-PostRequest -Endpoint "/customers" -Body $PSBoundParameters
}