# PSServiceNow
[![Documentation](https://img.shields.io/badge/Documentation-PSServiceNow-blue.svg)](https://github.com/insomniacc/PSServiceNow/blob/main/docs/GettingStarted.MD)
[![License](https://img.shields.io/badge/license-GPL&ndash;3.0-blue.svg)](https://github.com/insomniacc/PSServiceNow/blob/main/LICENSE) 
[![PSServicenow](https://img.shields.io/powershellgallery/v/PSServiceNow.svg?style=flat-square&label=Powershell%20Gallery)](https://www.powershellgallery.com/packages/PSServiceNow/)
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.0-blue.svg)](https://github.com/PowerShell/PSServiceNow)
<a href="https://www.buymeacoffee.com/insomniacc"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" height="20px"></a>

## Summary
A powershell module for interacting with the various ServiceNow REST API's.  

This module tries to build a framework around the Table API allowing it to support any instance.  
Focusing on the Table API initially for CRUD operations, this module also supports batch, attachment and aggregate API's with more to come in future.  
I've built this on my own time, if you do find it useful I would greatly appreciate any [feedback](https://github.com/insomniacc/PSServiceNow/issues/new/choose) or [support](https://www.buymeacoffee.com/insomniacc).

<details>
<summary>A bit more...</summary>
This is the first public module I've released so please go easy 😀. As always, ensure you understand any scripts before you run them and make sure to do your own testing. If you do find any bugs, it's still early days, so please help me improve and log an issue.  
  
I've worked for a few large orgs with vastly different implementations of Service-Now, some more out of the box, others heavily modified. Finding a suitable 'one size fits all' module was quite hard and I ended up building from scratch or improving existing modules in each case. Either way it was very time consuming. Some of the gallery modules out there I found either 1. very lacking in functionality or 2. locked behind a paywall. This repo is hopefully my solution to fill the gap.
</details>

## Demo

## Installation
```powershell
Install-Module -Name PSServiceNow -Repository PSGallery -Force
```
## Usage
- [Getting started](docs/GettingStarted.MD)
    - [Batching new user photos](docs/Batching_New_User_Photos.MD)
- [Function documentation](docs/functions)
- [Function Builder](docs/functionBuilder.MD)

## Reporting Issues and Feedback
- [Raise a bug or feature request](https://github.com/insomniacc/PSServiceNow/issues/new/choose)

## Contributing
Please see [CONTRIBUTING.MD](/CONTRIBUTING.md) for details on design, structure and how to get involved.

## Changelog
Please see [CHANGELOG.md](/CHANGELOG.md) for a full release history.