$ModulePath = "$PSScriptRoot\PSAtera"
Publish-Module -Path $ModulePath -NuGetApiKey $Env:APIKEY
