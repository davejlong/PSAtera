function Get-AteraCustomers {
  param(
    [Parameter(Mandatory=$false)][int]$CustomerID
  )
  if($CustomerID){
    return New-GetRequest -Endpoint "/customers/$($CustomerID)"
  }
  else{
    return New-GetRequest -Endpoint "/customers"
  }
}
