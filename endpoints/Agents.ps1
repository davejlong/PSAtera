function Get-AteraAgents {
  param(
    # Customer ID to retrieve list of agents for
    [Parameter(Mandatory=$true)]
    [int]$CustomerID
  )
  return New-AteraGetRequest -Endpoint "/agents/customer/$CustomerID"
}

function Get-AteraAgent {
  ##############
  # If no param is given the function will get the current PC
  ##############
  param(	 
    # ID of agent to retrieve
    [Parameter(Mandatory=$false,ParameterSetName="AgentID")]
    [int]$AgentID,
    # Machine Name; Default hostname of PC
    [Parameter(Mandatory=$false,ParameterSetName="MachineName")]
    [string]$MachineName=$env:COMPUTERNAME
  )	  
  if($ID){
    return New-AteraGetRequest -Endpoint "/agents/$AgentID"
  }
  if($MachineName){
    return New-AteraGetRequest -Endpoint "/agents/machine/$MachineName"
  }
}
