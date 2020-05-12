function Get-AteraContacts {
  return New-AteraGetRequest -Endpoint "/contacts"
}

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