<#
  .Synopsis
  Generic command for making GET requests against the Atera API

  .Parameter Endpoint
  Endpoint to request, beginning with a /

  .Parameter Paginate
  Whether to paginate the request. If set to false, will only query the first page of results.

  .Example
  New-AteraGetRequest -Endpoint "/customers/3"
  # Get a customer

  .Example
  New-AteraGetRequest -Endpoint "/customvalues/ticketfield/2/Product%20Family" -Paginate $false
  # Get a custom value (which needs to not paginate)
#>
function New-AteraGetRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter()]
    [bool] $Paginate=$true,
    [Parameter()]
    [Hashtable] $Query
  )
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $ItemsInPage = 50
  $QueryString = Format-QueryString -Query $Query
  $Uri = "https://app.atera.com/api/v3$($endpoint)?itemsInPage=$ItemsInPage&$QueryString"
  $items = @()
  $index = 0

  do {
    Write-Debug "[PSAtera] Request for $Uri"
    $data = Invoke-RestMethod -Uri $Uri -Method "GET" -Headers $Headers
    if (!$Paginate) { return $data }
    $items += $data.items
    $index += 1
    $Uri = $data.nextLink
  } while ($Uri -ne "" -and $index -lt [math]::ceiling($RecordLimit / $ItemsInPage))
  return $items
}

<#
  .Synopsis
  Generic command for making POST requests against the Atera API

  .Parameter Endpoint
  Endpoint to request, beginning with a /

  .Parameter Body
  Hashtable of data to send in POST request

  .Example
  New-AteraPostRequest -Endpoint "/contacts" -Body @{CustomerID=5; Email="john@example.com"}
  # Create a new Contact
#>
function New-AteraPostRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter(Mandatory, ValueFromPipeline)]
    [Hashtable] $Body
  )
  $Headers = @{
    "accept" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $Uri = "https://app.atera.com/api/v3$($endpoint)"
  Write-Debug "[PSAtera] Request for $Uri"
  $data = Invoke-RestMethod -Uri $Uri -Method "POST" -Headers $Headers -Body $Body
  return $data
}

<#
  .Synopsis
  Generic command for making PUT requests against the Atera API. Basically the same as the
  New-AteraPostRequest command.

  .Parameter Endpoint
  Endpoint to request, beginning with a /

  .Parameter Body
  Hashtable of data to send in PUT request

  .Example
  New-AteraPutRequest -Endpoint "/customvalues/customerfield/1/age/5%20Years"
  # Updates the age field on customer 1 to "5 Years"
#>
function New-AteraPutRequest {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter(ValueFromPipeline)]
    [Object] $Body
  )
  $Headers = @{
    "accept" = "application/json"
    "content-type" = "application/json"
    "X-API-KEY" = Get-AteraAPIKey
  }
  $Uri = "https://app.atera.com/api/v3$($endpoint)"
  Write-Debug "[PSAtera] Request for $Uri"
  $JsonBody = ConvertTo-Json -InputObject $Body
  $data = Invoke-RestMethod -Uri $Uri -Method "Put" -Headers $Headers -Body ([System.Text.Encoding]::UTF8.GetBytes($JsonBody))
  return $data
}

function Format-QueryString($Query) {
  $qs = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
  foreach($item in $Query.Keys) {
    $qs.Add($item, $Query[$item])
  }
  $qs.ToString()
}