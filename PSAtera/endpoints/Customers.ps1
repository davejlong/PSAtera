
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
  return New-AteraGetRequest -Endpoint "/customers/$CustomerID" -Paginate $false
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

<#
  .Synopsis
  Updates an existing customer.
#>
function Set-AteraCustomer {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [int] $CustomerID,
    [Parameter()]
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
  $Body = @{} + $PSBoundParameters
  $null = $Body.Remove("CustomerID")
  if (!$Body.Count) { throw "At least one update parameter needs to be set" }
  New-AteraPutRequest -Endpoint "/customers/$CustomerID" -Body $Body
}

<#
  .Synopsis
  Deletes an existing customer.
#>
function Remove-AteraCustomer {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [int] $CustomerID
  )
  New-AteraDeleteRequest -Endpoint "/customers/$CustomerID"
}

<#
  .Synopsis
  Creates a customer folder.
#>
function New-AteraCustomerFolder {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Name,
    [Parameter(Mandatory)]
    [int] $CustomerID,
    [Parameter()]
    [int] $ThresholdId
  )
  New-AteraPostRequest -Endpoint "/customers/folders" -Body $PSBoundParameters
}

<#
  .Synopsis
  Creates a customer attachment from base64 content.
#>
function New-AteraCustomerAttachment {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [int] $CustomerID,
    [Parameter(Mandatory)]
    [string] $AttachmentName,
    [Parameter(Mandatory)]
    [string] $AttachmentContentBase64
  )
  New-AteraPostRequest -Endpoint "/customers/attachments" -Body $PSBoundParameters
}
