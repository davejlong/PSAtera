BeforeAll {
  Import-Module -Name $PSScriptRoot\..\PSAtera.psm1 -Force
  . $PSScriptRoot\..\Public\Helpers.ps1
  . $PSScriptRoot\SampleData\Generator.ps1
}

Describe "Helpers" {
  Describe "Invoke-AteraGetRequest" {
    BeforeEach {
      Reset-MockData
      Mock Invoke-RestMethod {
        Write-Host "Invoke-RestMethod Mock called"
        return Get-MockData("Agents.json")
      }
    }
    It "Makes a REST request" {
      Invoke-AteraGetRequest -Endpoint "/test"
      Assert-MockCalled Invoke-RestMethod
    }

    It "Generates a query string from request data" {
      Invoke-AteraGetRequest -Endpoint "/test" -Query @{ Foo="Bar"; Hello="World" }

      Assert-MockCalled Invoke-RestMethod -ParameterFilter {
        $Uri.Query.Contains("Foo=Bar") -and $Uri.Query.Contains("Hello=World")
      }
    }

    It "Paginates through the results" {
      Set-AteraRecordLimit -Limit 10
      Invoke-AteraGetRequest -Endpoint "/test"
      Should -Invoke Invoke-RestMethod -Times 3
    }
  }
}