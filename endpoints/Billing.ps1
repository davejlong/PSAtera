function Get-AteraInvoices {
  return New-AteraGetRequest -Endpoint "/invoices"
}

function Get-AteraInvoice {
  param (
    [Parameter(Mandatory)]
    [int] $InvoiceNumber
  )
  return New-AteraGetRequest -Endpoint "/invoices/$InvoiceNumber"
}