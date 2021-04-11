BeforeAll {
  Import-Module -Name $PSScriptRoot\..\PSAtera.psm1 -Force
}
Describe 'Config' {
  Describe '*-AteraAPIKey' {
    It "Get's API key from the environment" {
      $env:ATERAAPIKEY = "Hello World"
      . $PSScriptRoot\..\Public\Config.ps1
      Get-AteraAPIKey | Should -Be "Hello World"
    }

    It "Can be set using Set-AteraAPIKey" {
      Set-AteraAPIKey -APIKey "Foo Bar"
      Get-AteraAPIKey | Should -Be "Foo Bar"
    }
  }

  Describe "*-AteraRecordLimit" {
    It "Defaults to a sane value" {
      Import-Module -Name $PSScriptRoot\..\PSAtera.psm1 -Force
      Get-AteraRecordLimit | Should -Be 1000
    }

    It "Can be updated on the fly" {
      Set-AteraRecordLimit -Limit 2
      Get-AteraRecordLimit | Should -Be 2
    }
  }
}