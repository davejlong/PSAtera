
<#
  .Synopsis
  Get a list of products from the API
#>
function Get-AteraProducts {
  return New-AteraGetRequest -Endpoint "/rates/products"
}

<#
  .Synopsis
  Get a list of the expenses from the API
#>
function Get-AteraExpenses {
  return New-AteraGetRequest -Endpoint "/rates/expenses"
}

<#
  .Synopsis
  Get a single product by it's ID
  
  .Parameter ProductID
#>
function Get-AteraProduct {
  param (
    [Parameter(Mandatory)]
    [int] $ProductID
  )
  return New-AteraGetRequest -Endpoint "/rates/products/$ProductID"
}

<#
  .Synopsis
  Get a single Expense by it's ID

  .Parameter ExpenseID
#>
function Get-AteraExpense {
  param (
    [Parameter(Mandatory)]
    [int] $ExpenseID
  )
  return New-AteraGetRequest -Endpoint "/rates/expenses/$ExpenseID"
}

<#
  .Synopsis
  Create a new product
  
  .Parameter Description
  Name to give the product
  .Parameter Category
  Category to assign product to (ex. Cables)
  .Parameter  Amount
  Price of the product
  .Parameter SKU
  Optional SKU number to assign to product
#>
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

<#
  .Synopsis
  Create a new expense in Atera
  
  .Parameter Description
  Name to give the expense
  .Parameter Category
  Category to assign expense to
  .Parameter  Amount
  Price of the expense
  .Parameter SKU
  Optional SKU number to assign to expense
#>
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