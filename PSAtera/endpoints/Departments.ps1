<#
  .Synopsis
  Get a list of departments.
#>
function Get-AteraDepartments {
  [CmdletBinding()]
  param()
  New-AteraGetRequest -Endpoint "/departments"
}

<#
  .Synopsis
  Get a specific department.
#>
function Get-AteraDepartment {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [int] $DepartmentID
  )
  New-AteraGetRequest -Endpoint "/departments/$DepartmentID" -Paginate $false
}

<#
  .Synopsis
  Create a department.
#>
function New-AteraDepartment {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [string] $Name,
    [Parameter()]
    [string] $Description
  )
  New-AteraPostRequest -Endpoint "/departments" -Body $PSBoundParameters
}

<#
  .Synopsis
  Update a department.
#>
function Set-AteraDepartment {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [int] $DepartmentID,
    [Parameter(Mandatory)]
    [Hashtable] $Body
  )
  New-AteraPutRequest -Endpoint "/departments/$DepartmentID" -Body $Body
}

<#
  .Synopsis
  Delete a department.
#>
function Remove-AteraDepartment {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [int] $DepartmentID
  )
  New-AteraDeleteRequest -Endpoint "/departments/$DepartmentID"
}
