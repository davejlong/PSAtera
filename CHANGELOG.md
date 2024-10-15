# Changelog

All notable changes to this project will be documented in this file.

## [1.5.9] - 2024/10/15
### Fixed
-  removed parameter in New-AteraAlert made scripts break, we put it back with a deprecated notice

## [1.5.8] - 2024/10/15
### Added
- Publish to PSGallery on demand
- Tickets / Get-AteraTickets / New CustomStatuses parameter:

    Queries tickets with custom statuses, ex: -CustomStatuses "Waiting customer,Waiting order"
