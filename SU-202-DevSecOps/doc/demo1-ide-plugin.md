# Demo 1 - IDE Plugin

## Context

- Pushing the shift left concept to its extreme
- Demo in Intellij on a Gradle project

## Objective

- Show benefits of IDE plugin

## Scope

- IntelliJ IDEA, WebStorm and GoLand:
=> Maven, Gradle, Go, npm
  
- Eclipse
=> Maven, Gradle, npm

- Visual Studio Code:
=> Maven, Python, Go, npm
  
- Visual Studio 
=> NuGet

## Plugin installation

found in the regular marketplace 
Preferences => Plugins

Look for JFrog

## Plugin configuration

Preferences => Other Settings => JFrog Xray Configuration

- URL
https://<JFROG_PLATFORM_URL>/xray

- Credentials
Prefer API Key
  
=> Test connection to validate the configuration

## In Action

switch to branch feature/demo_ide_plugin
=> no environment variables in the build.gradle

Fill api key in artifactory repository configuration

### Scan

=> show issue with fix version information

### Bump up the dependency

=> Refresh

### Show License filtering

- Select only Apache-2.0
=> show corresponding dependencies
  
- Select only LGPL-2.0
  => show corresponding dependencies

## Back to main branch

## Conclusion

This is how you can shift left, allowing the developer to fix security even before publishing them on the SCM.
=> great savings on the downstream pipeline (CI, tests, packaging, distribution)

You can even be aware of the licenses used in your code, helpful if you have a blacklist.