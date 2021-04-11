$Page = 0

function Reset-MockData {
  $script:Page = 0
}
function Get-MockData($datafile) {
  $data = Get-Content $PSScriptRoot\$datafile | ConvertFrom-Json
  return @{
    items = @(1..50 | ForEach-Object { $data.PSObject.Copy() })
    totalItemCount = 500
    page = $page
    itemsInPage = 50
    totalPages = 10
    prevLink = "https://app.atera.com/api/v3/Test?itemsInPage=50&page=$($page-1)"
    nextLink = "https://app.atera.com/api/v3/Test?itemsInPage=50&page=$($page+1)"
  }
}