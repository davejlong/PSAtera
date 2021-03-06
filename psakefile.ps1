Task default -depends FunctionsToExport

Task FunctionsToExport {
  $moduleName = Get-Item . | ForEach-Object BaseName
  
  $functionNames = Get-ChildItem endpoints/ -Recurse -PipelineVariable file | ForEach-Object {
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref] $null, [ref] $null)
    if ($ast.EndBlock.Statements.Name) {
      $ast.EndBlock.Statements.Name
    }
  }
  $functionNames += @("Install-AteraAgent", "Get-AteraAPIKey", "Set-AteraAPIKey", "Get-AteraRecordLimit", "Set-AteraRecordLimit", "New-AteraGetRequest", "New-AteraPostRequest")
  Write-Verbose "Using functions $functionNames"
  
  Update-ModuleManifest -Path ".\$($moduleName).psd1" -FunctionsToExport $functionNames
  Import-Module $moduleName -Force -Verbose:$false
}

Task Publish -depends FunctionsToExport, ExtractDocs {
  $moduleName = Get-Item . | ForEach-Object BaseName
  Publish-Module -Name ".\$($moduleName).psm1" -NuGetApiKey $env:NuGetAPIKey
}

Task ExtractDocs {
  Remove-Item "./docs.txt"
  $moduleName = Get-Item . | ForEach-Object BaseName
  Import-Module -Name "./$($moduleName).psm1" -Force
  
  Get-Command -Module $moduleName | ForEach-Object {
    Get-Help $_.Name -Detailed | Out-File -FilePath "./docs.txt" -Append
  }
}