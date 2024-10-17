# Changelog

All notable changes to this project will be documented in this file.

## [1.6.1] - 2024/10/16
### Fixed
-  `Get-AteraAgent`: Kinda fix #11: if we have multiple computers for the current machine, we match on its serial number until Atera gives access to local AgentID

## [1.6.0] - 2024/10/16
### Changed
- `New-AteraPostRequest` Body is now sent as a JSON
### Added
- New function `New-AteraTicketComment`, it adds a comment into a ticket

  ex: `New-AteraTicketComment -TicketID 123 -EnduserId 123 -CommentText "Hello World"`

## [1.5.9] - 2024/10/15
### Fixed
-  removed parameter in New-AteraAlert made scripts break, we put it back with a deprecated notice

## [1.5.8] - 2024/10/15
### Added
- Publish to PSGallery on demand
- Tickets / Get-AteraTickets / New CustomStatuses parameter:

    Queries tickets with custom statuses, ex: -CustomStatuses "Waiting customer,Waiting order"
