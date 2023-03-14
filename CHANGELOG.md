# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- New/Get/Set Table functions: *-SNOWApprover, *-SNOWChangeRequest, *-SNOWIncident, *-SNOWSCRequest, *-SNOWSCRequestedItem, *-SNOWSCTask, *-SNOWTask
- Function Builder to auto generate TableAPI functions based on metadata from SNOW
- Attachment API support with Get/New/Remove-SNOWAttachment
- Aggregate API support with Get-SNOWStats
- New-SNOWUserPhoto with batch support
- Batch API support with Invoke-SNOWBatch (Can be used as a wrapper function around supporting commands)
- New-SNOWUser Table API function
- TABLE API support with Get/New/Set/Remove-SNOWObject (these core functions provide the template for all other table functions)
- TABLE API framework with private functions supporting CRUD operations.

