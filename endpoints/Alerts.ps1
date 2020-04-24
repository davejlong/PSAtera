###
# Alert Endpoint
###
function Get-AteraAlerts {
  return New-GetRequest -Endpoint "/alerts"
}

function Get-AteraAlert {
  param(
    # ID of Alert to retrieve  
    [int]$ID
  )
  return New-GetRequest -Endpoint "/alerts/$alertId"
}