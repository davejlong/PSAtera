function Get-AteraAPIKey {
  return $env:ATERAAPIKEY
}

function Build-GetRequest([string]$endpoint, [int]$maxPages=20) {
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $Uri = "https://app.atera.com/api/v3$($endpoint)?itemsInPage=50"
  $items = @()
  $index = 0

  do {
    $data = Invoke-RestMethod -Uri $Uri -Method "GET" -Headers $Headers
    $items += $data.items
    $index += 1
    $Uri = $data.nextLink
  } while ($Uri -ne "" -and $index -lt $maxPages)
  return $items
}

function Get-AteraAlerts {
  return Build-GetRequest -Endpoint "/alerts"
}

function Get-AteraTickets {
  return Build-GetRequest -Endpoint "/tickets"
}

function Get-AteraAgents {
  return Build-GetRequest -Endpoint "/agents"
}

Export-ModuleMember -Function Get-Atera*
