<#
  .Synopsis
  Get generic devices.
#>
function Get-AteraGenericDevices {
  [CmdletBinding()]
  param(
    [Parameter()]
    [Hashtable] $Query
  )
  New-AteraGetRequest -Endpoint "/devices/genericdevices" -Query $Query
}

function Get-AteraGenericDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraGetRequest -Endpoint "/devices/genericdevice/$DeviceID" -Paginate $false
}

function New-AteraGenericDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][Hashtable] $Body)
  New-AteraPostRequest -Endpoint "/devices/genericdevice" -Body $Body
}

function Remove-AteraGenericDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraDeleteRequest -Endpoint "/devices/genericdevice/$DeviceID"
}

<#
  .Synopsis
  Get TCP devices.
#>
function Get-AteraTcpDevices {
  [CmdletBinding()]
  param(
    [Parameter()]
    [Hashtable] $Query
  )
  New-AteraGetRequest -Endpoint "/devices/tcpdevices" -Query $Query
}

function Get-AteraTcpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraGetRequest -Endpoint "/devices/tcpdevice/$DeviceID" -Paginate $false
}

function New-AteraTcpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][Hashtable] $Body)
  New-AteraPostRequest -Endpoint "/devices/tcpdevice" -Body $Body
}

function Remove-AteraTcpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraDeleteRequest -Endpoint "/devices/tcpdevice/$DeviceID"
}

<#
  .Synopsis
  Get HTTP devices.
#>
function Get-AteraHttpDevices {
  [CmdletBinding()]
  param(
    [Parameter()]
    [Hashtable] $Query
  )
  New-AteraGetRequest -Endpoint "/devices/httpdevices" -Query $Query
}

function Get-AteraHttpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraGetRequest -Endpoint "/devices/httpdevice/$DeviceID" -Paginate $false
}

function New-AteraHttpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][Hashtable] $Body)
  New-AteraPostRequest -Endpoint "/devices/httpdevice" -Body $Body
}

function Remove-AteraHttpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraDeleteRequest -Endpoint "/devices/httpdevice/$DeviceID"
}

<#
  .Synopsis
  Get SNMP devices.
#>
function Get-AteraSnmpDevices {
  [CmdletBinding()]
  param(
    [Parameter()]
    [Hashtable] $Query
  )
  New-AteraGetRequest -Endpoint "/devices/snmpdevices" -Query $Query
}

function Get-AteraSnmpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraGetRequest -Endpoint "/devices/snmpdevice/$DeviceID" -Paginate $false
}

function Get-AteraSnmpDeviceByGuid {
  [CmdletBinding()]
  param([Parameter(Mandatory)][string] $DeviceGuid)
  New-AteraGetRequest -Endpoint "/devices/snmpdevice/guid/$DeviceGuid" -Paginate $false
}

function New-AteraSnmpDeviceV1V2 {
  [CmdletBinding()]
  param([Parameter(Mandatory)][Hashtable] $Body)
  New-AteraPostRequest -Endpoint "/devices/snmpdevice/v1v2" -Body $Body
}

function New-AteraSnmpDeviceV3 {
  [CmdletBinding()]
  param([Parameter(Mandatory)][Hashtable] $Body)
  New-AteraPostRequest -Endpoint "/devices/snmpdevice/v3" -Body $Body
}

function Remove-AteraSnmpDevice {
  [CmdletBinding()]
  param([Parameter(Mandatory)][int] $DeviceID)
  New-AteraDeleteRequest -Endpoint "/devices/snmpdevice/$DeviceID"
}
