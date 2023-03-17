#Contributing

## Summary

## References & External Documentation
### ServiceNow
[REST API reference](https://docs.servicenow.com/bundle/tokyo-application-development/page/build/applications/concept/api-rest.html)
### VSCode
[Better comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments) is used throughout code, it is recommended to install this extension.

## Table API

## Function Builder

## Testing
Currently pester testing is run manually although I will setup a pipeline for this in due course.  
All non table API functions must have their own pester tests.

## Commits & Versioning
The module is released following [Semantic Versioning](https://semver.org/). E.g Major.Minor.Patch  
[KeepAChangelog](https://keepachangelog.com/en/1.0.0/) standard is used for commits & changelog entries.  
Also please see [ChangeLogManagement](https://github.com/natescherer/ChangelogManagement).

## Pull Requests / Merging
Currently I don't have any formal process in place, until I've ironed out tests, build, ci/cd etc.
If you do want to contribute before that's all setup, please create a feature request with a link to your fork/branch.
Once you think it's ready just tag me in the feature and I'll review, test, and merge.
As things are still changing rapidly and I've still got quite a few todo list items, it may be best waiting until this is at v1.0.0 and I've got all the functionality I set out to implement in the original version.