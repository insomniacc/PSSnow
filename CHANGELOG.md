# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Features

- Authentication using WebSessions and the ServiceNow `X-UserToken` header.
- Support for running background scripts using `Invoke-SNOWBackgroundScript`
- Support for running GlideAjax requests using `Invoke-SNOWGlideAjax` and `Wait-SNOWGlideAjaxProgress`.
- Support for `sn_cicd` and `sn_devstudio` API endpoints for managing update sets and VCS applications.

### Changed

- [`Set-SNOWAuth`](src/Public/Set-SNOWAuth.ps1)
  - Added `-UseWebSession` parameter to start a new WebSession and use it for authentication. This works with all authentication methods (Basic, OAuth, OAuthToken).
  - Added `OAuthToken` ParameterSet with new parameters `-AccessToken` and `-RefreshToken`  for OAuth authentication using an existing access token and refresh token.
  
- [`Assert-SNOWAuth`](src/Private/Assert-SNOWAuth.ps1)
  - Update OAuth refresh flow. ClientSecret is now optional and will be used if provided. If not, a refresh will be attempted using the existing `$script:SNOWAuth.token.refresh_token` and `$script:SNOWAuth.ClientId` only.
  - When a WebSession is used, the function will now check if the cookies are still valid and refreshes it if necessary. This sets the `$Script:SNOWAuth.SessionState` variable using the new `Get-SNOWWebSessionState` function.

  [`Invoke-SNOWWebRequest`](src/Public/Invoke-SNOWWebRequest.ps1)
  - Update to use the `$Script:SNOWAuth.session.WebSession` and `$script:SNOWAuth.SessionState.SecurityToken` variables for authentication and session management when available and valid.

### Added

#### [web](src/Public/web/)

- [`Get-SNOWWebConcourseState`](src/Public/web/Get-SNOWWebConcourseState.ps1) - Retrieves the current state of the active ServiceNow session.
- [`Get-SNOWWebSessionState`](src/Public/web/Get-SNOWWebSessionState.ps1) - Retrieves the current state of a ServiceNow web session.
- [`Invoke-SNOWBackgroundScript`](src/Public/web/Invoke-SNOWBackgroundScript.ps1) - Executes a background script in the ServiceNow instance.
- [`Invoke-SNOWGlideAjax`](src/Public/web/Invoke-SNOWGlideAjax.ps1) - Sends a GlideAjax request to a ServiceNow instance and returns the response synchronously.
- [`New-SNOWAuthWebSession`](src/Public/web/New-SNOWAuthWebSession.ps1) - Creates an authenticated web session to ServiceNow using credentials from SNOWAuth.
- [`Set-SNOWWebConcourseState`](src/Public/web/Set-SNOWWebConcourseState.ps1) - Sets the current application or update set in a ServiceNow web session.
- [`Wait-SNOWGlideAjaxProgress`](src/Public/web/Wait-SNOWGlideAjaxProgress.ps1) - Waits for a ServiceNow background process to complete.

#### [sn_cicd](src/Public/sn_cicd/)

- [`Get-SNOWUpdateSet`](src/Public/sn_cicd/Get-SNOWUpdateSet.ps1) - Get update set from ServiceNow by sys_id. Searches sys_update_set and sys_remote_update_set tables in order.
- [`Import-SNOWUpdateSet`](src/Public/sn_cicd/Import-SNOWUpdateSet.ps1) - Imports an update set XML file into ServiceNow using sys_upload.do and a valid WebSession.
- [`New-SNOWUpdateSet`](src/Public/sn_cicd/New-SNOWUpdateSet.ps1) - Creates a new update set in ServiceNow using the CICD API.
- [`Remove-SNOWUpdateSet`](src/Public/sn_cicd/Remove-SNOWUpdateSet.ps1) - Removes a ServiceNow update set by directly deleting it.
- [`Search-SNOWUpdateSet`](src/Public/sn_cicd/Search-SNOWUpdateSet.ps1) - Searches for update sets in ServiceNow.
- [`Start-SNOWUpdateSetBackOut`](src/Public/sn_cicd/Start-SNOWUpdateSetBackOut.ps1) - Removes (backs out) an update set from ServiceNow.
- [`Start-SNOWUpdateSetCommit`](src/Public/sn_cicd/Start-SNOWUpdateSetCommit.ps1) - Starts the commit process for a ServiceNow update set.
- [`Start-SNOWUpdateSetPreview`](src/Public/sn_cicd/Start-SNOWUpdateSetPreview.ps1) - Starts the preview process for a ServiceNow update set.
- [`Start-SNOWVCSApplyChanges`](src/Public/sn_cicd/Start-SNOWVCSApplyChanges.ps1) - Starts applying changes from a remote source control to a specified local application or application-customization.
- [`Start-SNOWVCSApplyStash`](src/Public/sn_cicd/Start-SNOWVCSApplyStash.ps1) - Starts applying a previously generated "stash" of changes from a remote source control.
- [`Start-SNOWVCSImport`](src/Public/sn_cicd/Start-SNOWVCSImport.ps1) - Imports an application using the specified repository URL and branch name.
- [`Sync-SNOWVCSApplication`](src/Public/sn_cicd/Sync-SNOWVCSApplication.ps1) - Synchronizes a ServiceNow application with a Git repository using the CICD Source Control API.
- [`Test-SNOWUpdateSet`](src/Public/sn_cicd/Test-SNOWUpdateSet.ps1) - Tests an update set XML file to determine if it contains an update set.
- [`Wait-SNOWCICDProgress`](src/Public/sn_cicd/Wait-SNOWCICDProgress.ps1) - Waits for a ServiceNow CICD operation to complete.

#### [sn_devstudio](src/Public/sn_devstudio/)

- [`Get-SNOWDevStudioApp`](src/Public/sn_devstudio/Get-SNOWDevStudioApp.ps1) - Get all VCS apps from api/sn_devstudio/v1/vcs/apps
- [`Sync-SNOWDevStudioApp`](src/Public/sn_devstudio/Sync-SNOWDevStudioApp.ps1) - Imports, syncs and updates a ServiceNow application with a Git repository. Use sn_devstudio API endpoints to manage the repository.
- [`Wait-SNOWDevStudioTransaction`](src/Public/sn_devstudio/Wait-SNOWDevStudioTransaction.ps1) - Wait for a sn_devstudio transaction to complete - api/sn_devstudio/v1/vcs/transactions/{ProgressId}

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