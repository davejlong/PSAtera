Task default -depends FunctionsToExport

Task FunctionsToExport {
    $moduleName = Get-Item . | ForEach-Object BaseName

    $functionNames = Get-ChildItem endpoints/ -Recurse -PipelineVariable file | ForEach-Object {
        $ast = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref] $null, [ref] $null)
        if ($ast.EndBlock.Statements.Name) {
            $ast.EndBlock.Statements.Name
        }
    }
    Write-Verbose "Using functions $functionNames"

    Update-ModuleManifest -Path ".\$($moduleName).psd1" -FunctionsToExport $functionNames
    Import-Module $moduleName -Force -Verbose:$false
}

Task Publish -depends FunctionsToExport {
    $moduleName = Get-Item . | ForEach-Object BaseName
    Publish-Module -Name ".\$($moduleName).psm1" -NuGetApiKey $env:NuGetAPIKey
}