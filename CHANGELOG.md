
# Changelog

All notable changes to this project will be documented in this file.

## [1.8.0] - 2026/06/16
### Added
- API authentication now supports Atera JWT Bearer tokens in addition to legacy `X-API-KEY` headers. The module detects the format automatically by token length (short keys use `X-API-KEY`, keys longer than 100 characters use `Authorization: Bearer {token}`). Existing scripts using `Set-AteraAPIKey` or `ATERAAPIKEY` require no code changes.
- New generic request helper `New-AteraDeleteRequest` for DELETE operations against the API.
- `Get-AteraAccount` — account information (`GET /account`).
- `Get-AteraWorkHours` — workhour records with optional date and rate filters.
- **Departments:** `Get-AteraDepartments`, `Get-AteraDepartment`, `New-AteraDepartment`, `Set-AteraDepartment`, `Remove-AteraDepartment`.
- **Devices:** Generic, TCP, HTTP, and SNMP device cmdlets including list, get, create, and delete operations; `Get-AteraSnmpDeviceByGuid`, `New-AteraSnmpDeviceV1V2`, `New-AteraSnmpDeviceV3`.
- **Tickets:** `Get-AteraTicketsWithoutComments`, `Get-AteraTicketsByStatusModified`, `Get-AteraTicketsByLastModified`, `Get-AteraTicketAttachments`, `New-AteraTicketWorkHours`, `Add-AteraTicketRelation`, `Remove-AteraTicketRelation`, `Remove-AteraTicket`.
- **Customers:** `Set-AteraCustomer`, `Remove-AteraCustomer`, `New-AteraCustomerFolder`, `New-AteraCustomerAttachment`.
- **Contacts:** `Set-AteraContact`, `Remove-AteraContact`.
- **Contracts:** `New-AteraContract`, `Set-AteraContract`.
- **Rates:** `Set-AteraProduct`, `Remove-AteraProduct`, `Set-AteraExpense`, `Remove-AteraExpense`.
- **Agents:** `Get-AteraAgentInstalledPatches`, `Get-AteraAgentAvailablePatches`, `Remove-AteraAgent`.
- **Alerts:** `Remove-AteraAlert`.
- **Custom values:** `Get-AteraCustomValuesForObject`, `New-AteraCustomValue`, `Get-AteraCustomValueById`.

### Fixed
- `Set-AteraTicket`: `-TicketTitle` was ignored due to a typo in the parameter check (`$TickeTitle`).

### Changed
- Module exports now include `Remove-Atera*` and `Add-Atera*` cmdlets in addition to existing `Get-Atera*`, `Set-Atera*`, and `New-Atera*` patterns.
- `New-AteraPutRequest` and `New-AteraDeleteRequest` are included in the published function list.

### Notes
- Legacy API keys remain supported during Atera's transition period. Replace your key with a JWT from the Atera admin portal before legacy keys expire.
- Do not prefix the token with `Bearer ` in `ATERAAPIKEY` or `Set-AteraAPIKey`; the module adds the scheme automatically for JWT tokens.

## [1.7.1] - 2025/09/05
### Fixed
-  `Get-AteraAgent`: if we have multiple computers matched, sort agents by latest seen agent
-  `Get-AteraAgent`: we now match the default machine name with the full name (> 15 characters)

## [1.7.0] - 2024/10/17
### Added
-  New function `Set-AteraAlert`: Resolve a specified alert. Requires the alert ID.  

*Sample:*
```ps1
# Resolves alert with 1234 ID
Set-AteraAlert -AlertID 1234
# Resolves all Opened Information
get-AteraAlerts -Open -Information | ForEach-Object { set-AteraAlert -AlertID $_.AlertID }
```
## [1.6.1] - 2024/10/16
### Fixed
-  `Get-AteraAgent`: Kinda fix #11: if we have multiple computers for the current machine, we match on its serial number until Atera gives access to local AgentID

## [1.6.0] - 2024/10/16
### Changed
- `New-AteraPostRequest` Body is now sent as a JSON
### Added
- New function `New-AteraTicketComment`, it adds a comment into a ticket

*Sample:* 
```ps1
# Creates a comment for ticket ID 123 and contact's ID 123, with a comment
New-AteraTicketComment -TicketID 123 -EnduserId 123 -CommentText "Hello World"
```

## [1.5.9] - 2024/10/15
### Fixed
-  removed parameter in New-AteraAlert made scripts break, we put it back with a deprecated notice

## [1.5.8] - 2024/10/15
### Added
- Publish to PSGallery on demand
- Tickets / Get-AteraTickets / New CustomStatuses parameter:

    Queries tickets with custom statuses, ex: -CustomStatuses "Waiting customer,Waiting order"
