# PSAtera - The PowerShell Module for Atera


<a href="https://www.buymeacoffee.com/davejlong" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

Start interacting with Atera from PowerShell with the PSAtera module.

## Configuration

The PSAtera module relies on the `ATERAAPIKEY` environment variable for the API key for your Atera account.

## Install

```
PS> Install-Module -Name PSAtera
```

## Development Plans

* [x] Support all GET API requests for all endpoints
* [x] Add filtering arguments to requests to filter down items (i.e. only open tickets, critical alerts, server type agents)
* [x] Support POST requests on all endpoints
* [ ] Support PUT requests on all endpoints
