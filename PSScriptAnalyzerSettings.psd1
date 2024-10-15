@{
  Severity = @('Error', 'Warning')
  # ExcludeRules = @('PSUseShouldProcessForStateChangingFunctions')

  Rules = @{
    PSUseCompatibleSyntax = @{
      Enable = $true
      TargetVersions = @(
        '7.0'
        '6.0'
        '5.1'
        '4.0'
      )
    }
    PSUseCompatibleCommands = @{
      Enable = $true
      TargetProfiles = @(
        'win-8_x64_6.3.9600.0_4.0_x64_4.0.30319.42000_framework'              # PS 4.0
        'win-48_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework' # PS 5.1
        'win-4_x64_10.0.18362.0_6.2.4_x64_4.0.30319.42000_core'               # PS 6.2
        'win-4_x64_10.0.18362.0_7.0.0_x64_3.1.2_core'                         # Pwsh 7.0 - Windows
        'ubuntu_x64_18.04_7.0.0_x64_3.1.2_core'                               # Pwsh 7.0 - Ubuntu
      )
    }
  }
}