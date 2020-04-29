Task default -depends FunctionsToExport

Task FunctionsToExport {
    $moduleName = Get-Item . | ForEach-Object BaseName

    # RegEx matches files like Verb-Noun.ps1 only, not psakefile.ps1 or *-*.Tests.ps1
    $functionNames = Get-ChildItem -Recurse | Where-Object { $_.Name -match "^[^\.]+-[^\.]+\.ps1$" } -PipelineVariable file | ForEach-Object {
        $ast = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref] $null, [ref] $null)
        if ($ast.EndBlock.Statements.Name) {
            $ast.EndBlock.Statements.Name
        }
    }
    Write-Verbose "Using functions $functionNames"

    Update-ModuleManifest -Path ".\$($moduleName).psd1" -FunctionsToExport $functionNames
    Import-Module $moduleName -Force -Verbose:$false
}