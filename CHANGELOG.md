# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.2] - 2024-05-26
### Fixed
- fixed issued with TimeoutSec on Invoke-SNOWWebRequest in PS 7.3

## [1.3.1] - 2024-04-20
### Fixed
- fixed issued with utf-8 character encoding on update and create table API functions

## [1.3.0] - 2024-03-31
### Added
- -BypassDefaultProxy added to Set-SNOWAuth

### Fixed
- Fixed Content-Type errors on table SET commands

## [1.2.0] - 2023-08-23
### Added
- Added Invoke-SNOWWebRequest as a wrapper for Invoke-WebRequest/RestMethod, which handles rate limiting, auth & proxy auth.
- Proxy auth support added to Set-SNOWAuth and all relevant commands
- WebCallTimeoutSeconds added to Set-SNOWAuth

## [1.1.0] - 2023-04-06
### Added
- Invoke-SNOWRestMethod
- Get/New/Remove/Set-SNOWUserGroup
- Get-SNOWSCOrderGuide
- Get-SNOWSCItem
- Get/New/Remove/Set-SNOWLocation
- Get/New/Remove/Set-SNOWDepartment
- Get/New/Set-SNOWCMDBCI
- Get/Set-SNOWApprovalGroup
- Set-SNOWRITMVariable
- Improved error handling on Set-SNOWAuth
- Get-SNOWAuth

### Fixed
- Get-SNOWRITMVariableSet removed RITM lookup by LIKE and replaced with =
- Get-SNOWRITMVariableSet parameter sets fixed

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

[Unreleased]: https://github.com/insomniacc/PSSnow/compare/v1.3.2..HEAD
[1.3.2]: https://github.com/insomniacc/PSSnow/compare/v1.3.1..v1.3.2
[1.3.1]: https://github.com/insomniacc/PSSnow/compare/v1.3.0..v1.3.1
[1.3.0]: https://github.com/insomniacc/PSSnow/compare/v1.2.0..v1.3.0
[1.2.0]: https://github.com/insomniacc/PSSnow/compare/v1.1.0..v1.2.0
[1.1.0]: https://github.com/insomniacc/PSSnow/compare/v1.0.1..v1.1.0
[1.0.1]: https://github.com/insomniacc/PSSnow/compare/v1.0.0..v1.0.1
[1.0.0]: https://github.com/insomniacc/PSSnow/compare/v0.0.4..v1.0.0
[0.0.4]: https://github.com/insomniacc/PSSnow/compare/v0.0.3..v0.0.4
[0.0.3]: https://github.com/insomniacc/PSSnow/compare/v0.0.2..v0.0.3
[0.0.2]: https://github.com/insomniacc/PSSnow/releases/tag/v0.0.2
[0.0.1]: https://github.com/insomniacc/PSSnow/releases/tag/v0.0.2