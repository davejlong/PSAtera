function Get-AteraKnowledgebase {
  return New-AteraGetRequest -Endpoint "/knowledgebases"
}