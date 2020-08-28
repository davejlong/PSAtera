
<#
  .Synopsis
  Get a list of customers from the API
  
#>
function Get-AteraCustomers {
  return New-AteraGetRequest -Endpoint "/customers"
}

<#
  .Synopsis
  Get a single customer from the API

  .Parameter CustomerID
#>
function Get-AteraCustomer {
  param(
    [Parameter(Mandatory=$true)]
    [int] $CustomerID
  )
  return New-AteraGetRequest -Endpoint "/customers/$CustomerID"
}

<#
  .Synopsis
  Creates a new Customer
  
  .Parameter CustomerName
  .Parameter BusinessNumber
  .Parameter Domain
  Semi-colon delimited list of domains used by customer. Should include both email domains and ActiveDirectory domains
  .Parameter Address
  .Parameter City
  .Parameter State
  .Parameter ZipCodeStr
  .Parameter Country
  .Parameter Phone
  .Parameter Fax
  .Parameter Notes
  .Parameter Links
  .Parameter Longitude
  Longitude used to generate dot on the dashboard map of customers
  .Parameter Latitude
  Latitude used to generate dot on the dashboard map of customers
#>
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
    [string] $ZipCodeStr,
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
    [string] $Latitude
  )
  New-AteraPostRequest -Endpoint "/customers" -Body $PSBoundParameters
}
