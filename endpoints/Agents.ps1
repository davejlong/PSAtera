function Get-AteraAgents {
  param(
      # Customer ID to retrieve list of agents for
       [Parameter(Mandatory=$false)][int]$CustomerID
  )
  if($CustomerID){
    return New-GetRequest -Endpoint "/agents/$CustomerID"
  }
  else
  {
    return New-GetRequest -Endpoint "/agents"
  }
}

function Get-AteraAgent {
  ##############
  # If no param is given the function will get the current PC
  ##############
  param(
    # ID of agent to retrieve
    [Parameter(Mandatory=$false,ParameterSetName=’ID’)][int]$ID
    # Machine Name; Default hostname of PC
    [Parameter(Mandatory=$false,ParameterSetName=’MachineName’)][string]$MachineName=$env:COMPUTERNAME
  )
  if($ID){
    return New-GetRequest -Endpoint "/agents/$AgentID"
  }
  if($MachineName){
    return New-GetRequest -Endpoint "/agents/machine/$MachineName"
  }
}

 
