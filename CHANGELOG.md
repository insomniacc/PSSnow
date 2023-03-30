# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Improved error handling on Set-SNOWAuth
- Get-SNOWAuth

## [1.0.1] - 2023-03-28
### Added
- Set-SNOWAuth Aliveness check for developer instances

### Removed
- Defunct -Number param from Set/New table commands

## [1.0.0] - 2023-03-24
### Fixed
- Oauth auto refresh

## [0.0.4] - 2023-03-22
### Added
- PsScriptAnalyzer rule suppression for known exceptions
- ServiceCatalog API: New-SNOWSCCartItem
- ServiceCatalog API: Invoke-SNOWSCCart
- ServiceCatalog API: Get-SNOWSCCart

### Fixed
- Issue with Set-SNOWUserPhoto posting to a static record
- Get-SNOWAttachment Oauth issue for -PassThru requests

## [0.0.3] - 2023-03-21
### Fixed
- Oauth token auto refresh issue

## [0.0.2] - 2023-03-20
### Added
- Import API support: New-SNOWImport
- Oauth support (auto refreshes token)
- number/sys_id added to Get-SNOWRITMVariableSet output

### Changed
- Renamed Get-SNOWRITMVariable to Get-SNOWRITMVariableSet

## [0.0.1] - 2023-03-18
### Added
- Get-SNOWRITMVariable
- New/Get/Set Table functions: *-SNOWApprover, *-SNOWChangeRequest, *-SNOWIncident, *-SNOWSCRequest, *-SNOWSCRequestedItem, *-SNOWSCTask, *-SNOWTask
- Function Builder to auto generate TableAPI functions based on metadata from SNOW
- Attachment API support with Get/New/Remove-SNOWAttachment
- Aggregate API support with Get-SNOWStats
- New-SNOWUserPhoto with batch support
- Batch API support with Invoke-SNOWBatch (Can be used as a wrapper function around supporting commands)
- TABLE API support with Get/New/Set/Remove-SNOWObject (these core functions provide the template for all other table functions)
- TABLE API framework with private functions supporting CRUD operations.

[Unreleased]: https://github.com/insomniacc/PSSnow/compare/v1.0.1..HEAD
[1.0.1]: https://github.com/insomniacc/PSSnow/compare/v1.0.0..v1.0.1
[1.0.0]: https://github.com/insomniacc/PSSnow/compare/v0.0.4..v1.0.0
[0.0.4]: https://github.com/insomniacc/PSSnow/compare/v0.0.3..v0.0.4
[0.0.3]: https://github.com/insomniacc/PSSnow/compare/v0.0.2..v0.0.3
[0.0.2]: https://github.com/insomniacc/PSSnow/releases/tag/v0.0.2
[0.0.1]: https://github.com/insomniacc/PSSnow/releases/tag/v0.0.2