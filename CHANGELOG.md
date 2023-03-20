# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
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

[Unreleased]: https://github.com/insomniacc/PSSnow/compare/v0.0.1..HEAD
[0.0.1]: https://github.com/insomniacc/PSSnow/tree/v0.0.1