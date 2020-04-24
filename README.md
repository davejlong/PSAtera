# PSAtera - The PowerShell Module for Atera

Start interacting with Atera from PowerShell with the PSAtera module.

## Configuration

The PSAtera module relies on the `ATERAAPIKEY` environment variable for the API key for your Atera account.

## Install

```
PS> Install-Module -Name PSAtera
```

## Development Plans

* [x] Support all GET API requests for all endpoints
* [In Progress] Add filtering arguments to requests to filter down items (i.e. only open tickets, critical alerts, server type agents)
* [ ] Support POST requests on all endpoints
