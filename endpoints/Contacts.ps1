
<#
  .Synopsis
  Get list of contacts from API
#>
function Get-AteraContacts {
  return New-AteraGetRequest -Endpoint "/contacts"
}

<#
  .Synopsis
  Get a single contact by it's ID

  .Parameter ContactID
#>
function Get-AteraContact {
  param (
    [Parameter(Mandatory)]
    [int] $ContactID
  )
  return New-AteraGetRequest -Endpoint "/contacts/$ContactID"
}

<#
  .Synopsis
  Create a contact attached to a customer
  .Parameter CustomerID

  .Parameter CustomerName

  .Parameter Email

  .Parameter FirstName

  .Parameter LastName

  .Parameter JobTitle

  .Parameter Phone

  .Parameter IsContactPerson
  Mark this contact as a key contact for the customer

  .Parameter InIgnoreMode
  Ignore emails from this contact

  .Example
  Get-AzureADUser | ForEach-Object {
    New-AteraContact -CustomerName "Contoso" -Email $_.Mail -FirstName $_.GivenName -LastName $_.Surname -Phone $_.TelephoneNumber -JobTitle $_.JobTitle
  }
  # Imports all Azure AD users into Atera
#>
function New-AteraContact {
  [CmdletBinding(DefaultParameterSetName='ByCustomerID')]
  param (
    [Parameter(Mandatory, ParameterSetName='ByCustomerID')]
    [int] $CustomerID,
    [Parameter(Mandatory, ParameterSetName='ByCustomerName')]
    [string] $CustomerName,
    [Parameter(Mandatory)]
    [string] $Email,
    [Parameter()]
    [string] $FirstName,
    [Parameter()]
    [string] $LastName,
    [Parameter()]
    [string] $JobTitle,
    [Parameter()]
    [string] $Phone,
    [Parameter()]
    [switch] $IsContactPerson,
    [Parameter()]
    [string] $InIgnoreMode
  )
  New-AteraPostRequest -Endpoint "/contacts" -Body $PSBoundParameters
}