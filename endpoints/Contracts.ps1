
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
  return New-AteraGetRequest -Endpoint "/contracts/$ContractID"
}