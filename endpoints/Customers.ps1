function Get-AteraCustomers {
  return New-GetRequest -Endpoint "/customers"
}