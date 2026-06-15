# PSAtera - The PowerShell Module for Atera


<a href="https://www.buymeacoffee.com/davejlong" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

Start interacting with Atera from PowerShell with the PSAtera module.

## Configuration

The PSAtera module relies on the `ATERAAPIKEY` environment variable for the API token for your Atera account, which can be found here:
https://app.atera.com/new/admin/api

You can also set the token at runtime with `Set-AteraAPIKey`.

### API authentication change

Atera now uses JWT Bearer authentication instead of the legacy `X-API-KEY` header. Recent versions of PSAtera send requests as `Authorization: Bearer {token}`.

**If you upgrade PSAtera, update every script and automation that talks to Atera:** replace your old API key with the new JWT token from the Atera admin portal. The `Set-AteraAPIKey` cmdlet and `ATERAAPIKEY` environment variable names are unchanged—only the token value format has changed.

## Install

```
PS> Install-Module -Name PSAtera
```

### Alternative Setup
The below script will make sure all the prerequisites are setup and install PSAtera. Copy and paste the line into a PowerShell window. Run as admin to install PSAtera globally on the system.

```
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityPotocol -bor 3072; Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; Install-Module PSAtera -Force
```
