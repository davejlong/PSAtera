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
function Invoke-AteraGetRequest {
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
function New-AteraGetRequest {
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter()]
    [bool] $Paginate=$true,
    [Parameter()]
    [Hashtable] $Query
  )
  Write-Warning "New-AteraGetRequest deprecated. Please use Invoke-AteraGetRequest"
  Invoke-AteraGetRequest @PSBoundParameters
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
function Invoke-AteraPostRequest {
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
function New-AteraPostRequest {
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter(Mandatory, ValueFromPipeline)]
    [Hashtable] $Body
  )
  Write-Warning "New-AteraPostRequest deprecated. Please use Invoke-AteraPostRequest"
  Invoke-AteraPostRequest @PSBoundParameters
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
function Invoke-AteraPutRequest {
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
function New-AteraPutRequest {
  param (
    [Parameter(Mandatory)]
    [string] $Endpoint,
    [Parameter(Mandatory, ValueFromPipeline)]
    [Hashtable] $Body
  )
  Write-Warning "New-AteraPutRequest deprecated. Please use Invoke-AteraPutRequest"
  Invoke-AteraPutRequest @PSBoundParameters
}

function Format-QueryString($Query) {
  $qs = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
  foreach($item in $Query.Keys) {
    $qs.Add($item, $Query[$item])
  }
  $qs.ToString()
}