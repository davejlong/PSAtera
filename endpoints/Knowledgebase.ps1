function Get-AteraKnowledgebase {
  return New-GetRequest -Endpoint "/knowledgebases"
}