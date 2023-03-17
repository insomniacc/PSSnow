# PSServiceNow

<!--
Link to PSGallery module / Badge
-->

## Summary
A powershell module for interacting with the various ServiceNow REST API's. 

This module tries to build a framework around the Table API allowing it to support any instance.

Focusing on the Table API initially for CRUD operations, this module also supports batch, attachment and aggregate API's with more to come in future.

I've built this on my own time, if you do find it useful I would greatly appreciate any [feedback](https://github.com/insomniacc/PSServiceNow/issues/new/choose) or support [BuyMeACoffee](https://www.buymeacoffee.com/insomniacc).

<details>
<summary>A bit more...</summary>
This is the first release of my first public module so please go easy 😀. As always, ensure you understand any scripts before you run them and make sure to do your own testing. If you do find any bugs, it's still early days, so please help me improve and [log an issue here](https://github.com/insomniacc/PSServiceNow/issues/new/choose) any and all feedback will also be appreciated.
  
I've worked for a few large orgs with vastly different implementations of Service-Now, some more out of the box, others heavily modified. Finding a suitable 'one size fits all' module was quite hard and I ended up building from scratch or improving existing modules in each case. Either way it was very time consuming. Some of the gallery modules out there I found either 1. very lacking in functionality or 2. licensed and locked behind a paywall. This repo is hopefully my solution to fill that gap.
</details>

## Demo

## Installation
```powershell
Install-Module -Name PSServiceNow -Repository PSGallery -Force
```
## Usage
- [Getting started](docs\GettingStarted.MD)
    - [Batching new user photos](docs\Batching_New_User_Photos.MD)
- [Function documentation](docs\functions\)

## Reporting Issues and Feedback
[Raise a bug or feature request](https://github.com/insomniacc/PSServiceNow/issues/new/choose) 
[Support me with BuyACoffee](https://www.buymeacoffee.com/insomniacc)

## Contributing
Please see [CONTRIBUTING.MD](CONTRIBUTING.MD) for details on design, structure and how to get involved.

## Changelog
v 0.0.1 - Initial Release  
Please see [CHANGELOG.md](CHANGELOG.md) for a full release history.