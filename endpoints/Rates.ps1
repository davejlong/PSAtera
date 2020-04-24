function Get-AteraProducts {
  return New-GetRequest -Endpoint "/rates/products"
}
function Get-AteraExpenses {
  return New-GetRequest -Endpoint "/rates/expenses"
}