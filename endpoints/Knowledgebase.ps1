
<#
  .Synopsis
  Get all pages from the Knowledgebase
#>
function Get-AteraKnowledgebase {
  return New-AteraGetRequest -Endpoint "/knowledgebases"
}