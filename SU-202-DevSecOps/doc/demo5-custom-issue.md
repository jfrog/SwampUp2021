# Demo 5 - Custom Issue

## Context

- You are initiating an obsolescence process on your internal artifacts as you are deprecated struts based software (even if safe)

## Objective

- Create issues on your artifacts and have them reported by Xray

## Source properties

```bash
source scripts/build.env
```

## Init demo properties

```bash
ARTIFACTORY_URL="https://${ARTIFACTORY_HOSTNAME}/artifactory"

CLI_INSTANCE_ID='my-instance'
CLI_GRADLE_BUILD_NAME='devsecops-legacy-gradle'
CLI_BUILD_ID='1'
CLI_FIX_BUILD_ID='2'

PROJECT_VERSION='0.0.11'
STRUTS_VERSION='2.5.12'

GRADLE_REPO_DEV=devsecops-gradle-dev
```

## Indexing

Expedite the indexing process on devsecops-gradle-prod-local using the Index Now feature.

## Create custom issue on jar containing Struts dependency

- Browse devsecops-gradle build #2
- Expand published module
- Select Jar and use Show In Tree action
- Go To Xray tab
- Assign custom issue
* Title: Struts Based Component
* Description: Let's ged rid of struts
* Severity: High
* Specific Version: 1.0.0

## Check impact

- Browse devsecops-docker build #2
- Go To Xray tab
- Click on "Struts Based Component" violation and see description

## Conclusion

You can create violations on your own components to deprecate them for internal reasons.

