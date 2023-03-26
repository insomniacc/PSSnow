#Contributing
## References & External Documentation
### ServiceNow
[REST API reference](https://docs.servicenow.com/bundle/tokyo-application-development/page/build/applications/concept/api-rest.html)
### VSCode
[Better comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments) is used throughout this repo, it is recommended to install this extension.

## Authentication
All commands initiating either an `Invoke-WebRequest` or `Invoke-RestMethod` against servicenow must have `Assert-SNOWAuth`.
## Testing
Please ensure pester tests pass and correct any flagged error/warning rules by script analyzer.  
All TableAPI functions have pester tests already, but any new functionality out side the normal framework will also need to be tested separately.  

## Commits & Versioning
The module is released following [Semantic Versioning](https://semver.org/). E.g Major.Minor.Patch  
[KeepAChangelog](https://keepachangelog.com/en/1.0.0/) standard is used for commits & changelog entries.  
Also please see [ChangeLogManagement](https://github.com/natescherer/ChangelogManagement).

## Pull Requests / Merging
Currently I don't have any formal process in place, until I've ironed out tests, build, ci/cd etc.
If you do want to contribute before that's all setup, I'll be happy to review any requests.