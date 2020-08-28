<#
  .Synopsis
  Get invoices from Atera
#>
function Get-AteraInvoices {
  return New-AteraGetRequest -Endpoint "/invoices"
}

<#
  .Synopsis
  Get an invoice by the Invoice ID

  .Parameter InvoiceNumber
#>
function Get-AteraInvoice {
  param (
    [Parameter(Mandatory)]
    [int] $InvoiceNumber
  )
  return New-AteraGetRequest -Endpoint "/invoices/$InvoiceNumber"
}