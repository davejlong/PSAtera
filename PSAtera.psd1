#
# Module manifest for module 'PSAtera'
#
# Generated by: Dave Long
#
# Generated on: 3/3/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSAtera.psm1'

# Version number of this module.
ModuleVersion = '1.5.5'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '72244c88-50f8-4f2b-8a5b-8256a642d1ed'

# Author of this module
Author = 'Dave Long'

# Company or vendor of this module
CompanyName = 'Cage Data'

# Copyright statement for this module
Copyright = '(c) 2020 David Long. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell Module for interacting with the Atera API'

# Minimum version of the PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
ScriptsToProcess = 'PostInstall.ps1'

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-AteraAgents', 'Get-AteraAgent', 'Get-AteraAlerts', 
               'Get-AteraAlert', 'Get-AteraAlertsFiltered', 'New-AteraAlert', 
               'Get-AteraInvoices', 'Get-AteraInvoice', 'Get-AteraContacts', 
               'Get-AteraContact', 'New-AteraContact', 'Get-AteraContracts', 
               'Get-AteraContract', 'Get-AteraCustomers', 'Get-AteraCustomer', 
               'New-AteraCustomer', 'Get-AteraCustomValue', 'Set-AteraCustomValue', 
               'Get-AteraKnowledgebase', 'Get-AteraProducts', 'Get-AteraExpenses', 
               'Get-AteraProduct', 'Get-AteraExpense', 'New-AteraProduct', 
               'New-AteraExpense', 'Get-AteraTickets', 'Get-AteraTicket', 
               'Get-AteraTicketBillableDuration', 
               'Get-AteraTicketNonBillableDuration', 'Get-AteraTicketWorkHours', 
               'Get-AteraTicketWorkHoursList', 'Get-AteraTicketComments', 
               'Get-AteraTicketsFiltered', 'New-AteraTicket', 'Set-AteraTicket', 
               'Install-AteraAgent', 'Get-AteraAPIKey', 'Set-AteraAPIKey', 
               'Get-AteraRecordLimit', 'Set-AteraRecordLimit', 'New-AteraGetRequest', 
               'New-AteraPostRequest'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Atera','RMM','PSA'

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/davejlong/PSAtera/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/davejlong/PSAtera'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

