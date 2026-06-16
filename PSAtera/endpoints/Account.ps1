<#
  .Synopsis
  Get account information from the Atera API.
#>
function Get-AteraAccount {
  [CmdletBinding()]
  param()
  New-AteraGetRequest -Endpoint "/account" -Paginate $false
}
