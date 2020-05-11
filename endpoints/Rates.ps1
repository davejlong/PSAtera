function Get-AteraProducts {
  return New-GetRequest -Endpoint "/rates/products"
}
function Get-AteraExpenses {
  return New-GetRequest -Endpoint "/rates/expenses"
}

function New-AteraProduct {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Description,
    [Parameter()]
    [string] $Category,
    [Parameter()]
    [double] $Amount,
    [Parameter()]
    [string] $SKU
  )
  New-PostRequest -Endpoint "/rates/products" -Body $PSBoundParameters
}

function New-AteraExpense {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Description,
    [Parameter()]
    [string] $Category,
    [Parameter()]
    [double] $Amount,
    [Parameter()]
    [string] $SKU
  )
  New-PostRequest -Endpoint "/rates/expenses" -Body $PSBoundParameters
}