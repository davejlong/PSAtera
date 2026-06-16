
<#
  .Synopsis
  Get list of contracts from the API

  .Parameter CustomerID
#>
function Get-AteraContracts {
  param (
    [Parameter()]
    [int] $CustomerID
  )
  $uri = "/contracts"
  if ($CustomerID) { $uri = "$uri/customer/$CustomerID" }
  return New-AteraGetRequest -Endpoint $uri
}

<#
  .Synopsis
  Get a single contract from the API

  .Parameter ContractID
#>
function Get-AteraContract {
  param (
    [Parameter()]
    [int] $ContractID
  )
  return New-AteraGetRequest -Endpoint "/contracts/$ContractID" -Paginate $false
}

<#
  .Synopsis
  Create a new contract.
#>
function New-AteraContract {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [Hashtable] $Body
  )
  New-AteraPostRequest -Endpoint "/contracts" -Body $Body
}

<#
  .Synopsis
  Update an existing contract.
#>
function Set-AteraContract {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [int] $ContractID,
    [Parameter(Mandatory)]
    [Hashtable] $Body
  )
  New-AteraPutRequest -Endpoint "/contracts/$ContractID" -Body $Body
}