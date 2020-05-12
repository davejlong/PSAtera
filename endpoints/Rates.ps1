function Get-AteraProducts {
  return New-AteraGetRequest -Endpoint "/rates/products"
}

function Get-AteraExpenses {
  return New-AteraGetRequest -Endpoint "/rates/expenses"
}

function Get-AteraProduct {
  param (
    [Parameter(Mandatory)]
    [int] $ProductID
  )
  return New-AteraGetRequest -Endpoint "/rates/products/$ProductID"
}

function Get-AteraExpense {
  param (
    [Parameter(Mandatory)]
    [int] $ExpenseID
  )
  return New-AteraGetRequest -Endpoint "/rates/expenses/$ExpenseID"
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
  New-AteraPostRequest -Endpoint "/rates/products" -Body $PSBoundParameters
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
  New-AteraPostRequest -Endpoint "/rates/expenses" -Body $PSBoundParameters
}