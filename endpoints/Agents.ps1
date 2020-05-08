function Get-AteraAgents {
  return New-GetRequest -Endpoint "/agents"
}

function Get-AteraAgents {
  param(
    # Customer ID to retrieve list of agents for
    [Parameter(Mandatory)]
    [int]$CustomerID
  )
  return New-GetRequest -Endpoint "/agents/customer/$CustomerID"
}

function Get-AteraAgent {
  param(
    # ID of agent to retrieve
    [Parameter(Mandatory)]
    [int]$ID
  )
  return New-GetRequest -Endpoint "/agents/$AgentID"
}

function Get-AteraAgent {
  param(
    # Hostname of machine to retrieve. Defaults to current device host name
    [Parameter()]
    [string]$MachineName=$env:COMPUTERNAME
  )
  
  return New-GetRequest -Endpoint "/agents/machine/$MachineName"
}