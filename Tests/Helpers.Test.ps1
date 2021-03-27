BeforeAll {
  Import-Module -Name $PSScriptRoot\..\PSAtera.psm1 -Force
}

Describe "Helpers" {
  Describe '*-AteraAPIKey' {
    It "Get's API key from the environment" {
      $env:ATERAAPIKEY = "Hello World"
      . $PSScriptRoot\..\Public\Helpers.ps1
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

  Describe "New-AteraGetRequest" {
    BeforeEach {
      Set-AteraRecordLimit -Limit 1

      Mock Invoke-RestMethod {
        return (Get-Content $PSScriptRoot\SampleData\Agents.json | ConvertFrom-Json)
      }
    }
    It "Makes a REST request" {
      New-AteraGetRequest -Endpoint "/test"
      Assert-MockCalled Invoke-RestMethod
    }

    It "Generates a query string from request data" {
      New-AteraGetRequest -Endpoint "/test" -Query @{ Foo="Bar"; Hello="World" }

      Assert-MockCalled Invoke-RestMethod -ParameterFilter {
        $Uri.Query.Contains("Foo=Bar") -and $Uri.Query.Contains("Hello=World")
      }
    }

    It "Paginates through the results" {
      Set-AteraRecordLimit -Limit 250
      New-AteraGetRequest -Endpoint "/test"
      Assert-MockCalled Invoke-RestMethod -Times 5
    }
  }
}