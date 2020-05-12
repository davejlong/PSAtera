function Get-AteraInvoices {
  return New-AteraGetRequest -Endpoint "/invoices"
}