# Demo 4 - Ignore Violations

## Context

- A gradle project has been handed over to your team
- You still want to benefit from Xray features (fail build), but you don't have much time to fix all the security issues 

## Objective

- Show how to ignore violations to clean the current status

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

## Configure Gradle build

```bash
./jfrog rt gradle-config --server-id-resolve="${CLI_INSTANCE_ID}" --repo-resolve="${GRADLE_REPO_DEV}" --server-id-deploy="${CLI_INSTANCE_ID}" --repo-deploy="${GRADLE_REPO_DEV}" --use-wrapper=true --uses-plugin=true --deploy-ivy-desc=false
```

## Build the gradle project

```bash
./jfrog rt gradle clean artifactoryPublish \
            -b build.gradle \
            --build-name "${CLI_GRADLE_BUILD_NAME}" \
            --build-number "${CLI_BUILD_ID}" \
            -PprojectVersion="${PROJECT_VERSION}" \
            -PartifactoryUrl="${ARTIFACTORY_URL}" \
            -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
            -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
            -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
            -PstrutsVersion="${STRUTS_VERSION}"
```

## Publish Gradle Build info

```bash
./jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" "${CLI_BUILD_ID}"
```

## Create Xray policy

Create **raise-violation-on-high-severity** security policy:
- trigger a violation on **high severity** security issue discovered
- no action

## Create Xray watch

Create **devsecops-legacy-watch** watch:
- add **devsecops-legacy-\*/*** build (pattern) as resource
- add **raise-violation-on-high-severity** as policy

## Edit Xray watch

Edit **devsecops-docker-build-watch** watch:
- add exclude pattern **devsecops-legacy-\*/*** build (pattern) as resource

## Scan Gradle Build

```bash
./jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" "${CLI_BUILD_ID}"
```

## Go to devsecops-legacy-watch violation tab

Ignore violations:
- Any Vulnerability / Current Version Struts 2.5.12 / Any Build / Current Watch
Comment => Struts is not a concern as we have a process preventing exploits of its vulnerabilities 

- Any Vulnerability / Current Version FreeMarker 2.3.23 / Any Build / Current Watch
Comment => Currently implementing a solution based on a safer template engine
Expiration => One month from now as it should be delivered by end of current sprint  

## Go to list of Ignore Rules

- Show the content of each rule
- Show expiration time of freemarker rule

## Build the gradle project another time

```bash
./jfrog rt gradle clean artifactoryPublish \
            -b build.gradle \
            --build-name "${CLI_GRADLE_BUILD_NAME}" \
            --build-number "${CLI_FIX_BUILD_ID}" \
            -PprojectVersion="${PROJECT_VERSION}" \
            -PartifactoryUrl="${ARTIFACTORY_URL}" \
            -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
            -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
            -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
            -PstrutsVersion="${STRUTS_VERSION}"
```

## Publish Gradle Build info

```bash
./jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" "${CLI_FIX_BUILD_ID}"
```

## Scan Gradle Build

```bash
./jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" "${CLI_FIX_BUILD_ID}"
```

## Go to build page

=> Open devsecops-legacy-gradle #2
=> show empty violations tab 
=> Show Ignored violations

## Conclusion

Image can be built successfully after ignoring legacy violations.
You can apply the same procedure to get rid of any violations and start from a clean sheet.
From this point onward, you'll be able to take advantage of the fail build feature to check for any new vulnerability that could arise.

