function Get-AteraContracts {
  param (
    [Parameter()]
    [int] $CustomerID
  )
  $uri = "/contracts"
  if ($CustomerID) { $uri = "$uri/customer/$CustomerID" }
  return New-AteraGetRequest -Endpoint $uri
}

function Get-AteraContracts {
  param (
    [Parameter()]
    [int] $ContractID
  )
  return New-AteraGetRequest -Endpoint "/contracts/$ContractID"
}