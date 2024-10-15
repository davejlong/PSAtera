if ($null -eq $env:ATERAAPIKEY) {
  Write-Warning "To use PSAtera, you must either set the ATERAAPIKEY environment or call Set-AteraAPIKey"
}