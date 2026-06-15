# PSAtera - The PowerShell Module for Atera


<a href="https://www.buymeacoffee.com/davejlong" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

Start interacting with Atera from PowerShell with the PSAtera module.

## Configuration

The PSAtera module relies on the `ATERAAPIKEY` environment variable for the API key or token for your Atera account, which can be found here:
https://app.atera.com/new/admin/api

You can also set the key at runtime with `Set-AteraAPIKey`.

### API authentication

Atera is moving from legacy static API keys (`X-API-KEY` header) to JWT Bearer tokens (`Authorization: Bearer {token}`). Legacy keys remain valid for **60 days** after the change—plan to replace yours with a JWT before that deadline.

PSAtera detects the format automatically based on token length:

- **Short keys** (100 characters or fewer) are sent as `X-API-KEY` for backward compatibility with existing scripts.
- **Long keys** (more than 100 characters) are sent as `Authorization: Bearer {token}` for the new JWT format.

No code changes are required when upgrading: keep using `Set-AteraAPIKey` and `ATERAAPIKEY` as before. When Atera rotates your credentials to a JWT, PSAtera will switch to Bearer authentication automatically.

## Install

```
PS> Install-Module -Name PSAtera
```

### Alternative Setup
The below script will make sure all the prerequisites are setup and install PSAtera. Copy and paste the line into a PowerShell window. Run as admin to install PSAtera globally on the system.

```
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityPotocol -bor 3072; Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; Install-Module PSAtera -Force
```
