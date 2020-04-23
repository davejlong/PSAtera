# PSAtera - The PowerShell Module for Atera

Start interacting with Atera from PowerShell with the PSAtera module.

## Configuration

The PSAtera module relies on the `ATERAAPIKEY` environment variable for the API key for your Atera account.

## Commands

### Get-AteraAlerts

Get the 1,000 most recent alerts from Atera

### Get-AteraTickets

Get the 1,000 most recent tickets from Atera

### Get-AteraAgents

Get the 1,000 most recent agents from Atera

## Development Plans

[ ] Support all GET API requests for all endpoints
[ ] Add filtering arguments to requests to filter down items (i.e. only open tickets, critical alerts, server type agents)
[ ] Support all POST requests
