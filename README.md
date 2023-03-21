# PSSnow
[![PSSnow](https://img.shields.io/powershellgallery/v/PSSnow.svg?style=flat-square&label=Powershell%20Gallery)](https://www.powershellgallery.com/packages/PSSnow/)
![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PSSnow?style=plastic)
[![Documentation](https://img.shields.io/badge/Documentation-PSSnow-blue.svg)](https://github.com/insomniacc/PSSnow/blob/main/docs/GettingStarted.MD)
[![License](https://img.shields.io/badge/license-GPL&ndash;3.0-blue.svg)](https://github.com/insomniacc/PSSnow/blob/main/LICENSE) 
<img src="https://img.shields.io/badge/Supports PS-5.0-blue.svg"></img>
<a href="https://www.buymeacoffee.com/insomniacc"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" height="20px"></a>

> ⚠️ **Please note this is module is currently an ALPHA release**

## Summary
A powershell module for interacting with the various ServiceNow REST API's.  

This module has a framework built around the Table API allowing it to support any Service-Now instance.  
Focusing on the Table API initially for CRUD operations, this module also supports batch, attachment, import, service catalog and aggregate API's with more to come in future.  
I've built this in my spare time, if you do find it useful I would greatly appreciate any [feedback](https://github.com/insomniacc/PSSnow/issues/new/choose) or [support](https://www.buymeacoffee.com/insomniacc).

<details>
<summary>A bit more...</summary>
This is the first public module I've released so please go easy 😀.<br>
As always, ensure you understand any scripts before you run them and make sure to do your own testing. <br>
If you do find any bugs, it's still early days, so please help me improve and log an issue.  <br>
<br>
I've worked for a few large orgs with vastly different implementations of Service-Now, some more out of the box, others heavily modified. Finding a suitable 'one size fits all' module was quite hard and I ended up building from scratch or improving existing modules in each case. Either way it was very time consuming. Some of the gallery modules out there I found either 1. very lacking in functionality or 2. locked behind a paywall. This repo is hopefully my solution to fill the gap.
</details>

## Installation
```powershell
Install-Module -Name PSSnow -Repository PSGallery -Force
```
## Usage
- [User Guide](docs/UserGuide.MD)
- [Function documentation](docs/functions)
- [Function builder](docs/functionBuilder.MD)

## Reporting Issues and Feedback
- [File a bug report](https://github.com/insomniacc/PSSnow/issues/new?assignees=&labels=bug&template=bug_report.md)
- [Raise a feature request](https://github.com/insomniacc/PSSnow/issues/new?assignees=&labels=enhancement&template=feature_request.md)
- [Something else](https://github.com/insomniacc/PSSnow/issues/new/choose)

## Contributing
- [Contributing](/CONTRIBUTING.md)

## Changelog
- [Changelog](/CHANGELOG.md)

## Roadmap
- [v1.0.0](https://github.com/insomniacc/PSSnow/milestone/4)