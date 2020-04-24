function Get-AteraInvoices {
  return New-GetRequest -Endpoint "/invoices"
}