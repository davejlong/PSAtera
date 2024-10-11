# PSAtera - The PowerShell Module for Atera


<a href="https://www.buymeacoffee.com/davejlong" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

Start interacting with Atera from PowerShell with the PSAtera module.

## Configuration

The PSAtera module relies on the `ATERAAPIKEY` environment variable for the API key for your Atera account which can be found here:
https://app.atera.com/new/admin/api

## Install

```
PS> Install-Module -Name PSAtera
```

### Alternative Setup
The below script will make sure all the prerequisites are setup and install PSAtera. Copy and paste the line into a PowerShell window. Run as admin to install PSAtera globally on the system.

```
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityPotocol -bor 3072; Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; Install-Module PSAtera -Force
```
