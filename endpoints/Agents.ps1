function Get-AteraAgents {
  param(
    # Customer ID to retrieve list of agents for
    [Parameter(Mandatory)]
    [int]$CustomerID
  )
  return New-GetRequest -Endpoint "/agents/customer/$CustomerID"
}

function Get-AteraAgent {
  ##############
  # If no param is given the function will get the current PC
  ##############
  param(
    # ID of agent to retrieve
    [Parameter(Mandatory)]
    [int]$ID
  )
  if($ID){
    return New-GetRequest -Endpoint "/agents/$AgentID"
  }
  if($MachineName){
    return New-GetRequest -Endpoint "/agents/machine/$MachineName"
  }
}

function Get-AteraAgent {
  param(
    # Hostname of machine to retrieve. Defaults to current device host name
    [Parameter()]
    [string]$MachineName=$env:COMPUTERNAME
  )
  
  return New-GetRequest -Endpoint "/agents/machine/$MachineName"
}
