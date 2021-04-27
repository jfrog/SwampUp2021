# Demo 2 - Ignore Violations

## Context

- A gradle project has been handed over to your team
- You still want to benefit from Xray features (fail build), but you don't have much time to fix all the security issues 

## Objective

- Show how to ignore violations to clean the current status

## Configure Gradle build

```bash
jfrog rt gradle-config --server-id-resolve="${CLI_INSTANCE_ID}" --repo-resolve="${GRADLE_REPO_DEV}" --server-id-deploy="${CLI_INSTANCE_ID}" --repo-deploy="${GRADLE_REPO_DEV}" --use-wrapper=false --uses-plugin=true --deploy-ivy-desc=false
```

## Index resources

- index **devsecops-legacy-gradle** build

## Build the gradle project

```bash
jfrog rt gradle clean artifactoryPublish \
            -b build.gradle \
            --build-name "${CLI_GRADLE_LEGACY_BUILD_NAME}" \
            --build-number 1 \
            -PprojectVersion="${PROJECT_VERSION_DEMO1}" \
            -PartifactoryUrl="${ARTIFACTORY_URL}" \
            -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
            -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
            -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
            -PstrutsVersion="${STRUTS_VERSION_UNSAFE}"
```

## Publish Gradle Build info

```bash
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_LEGACY_BUILD_NAME}" 1
```

## Create Xray policy

Create **raise-violation-on-high-severity** security policy:
- trigger a violation on **high severity** security issue discovered
- no action

## Create Xray watch

Create **devsecops-legacy-watch** watch:
- add **devsecops-legacy-\*/*** build (pattern) as resource
- add **raise-violation-on-high-severity** as policy

## Scan Gradle Build

```bash
jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_LEGACY_BUILD_NAME}" 1
```

No violation found but this is expected.

## Go to devsecops-legacy-watch violation tab

Ignore violations:
- Any Vulnerability / Current Version FreeMarker 2.3.23 / Any Build / Current Watch
  Comment => Currently implementing a solution based on a safer template engine
  Expiration => One month from now as it should be delivered by end of current sprint

- Any Vulnerability / Current Version Struts 2.5.12 / Any Build / Current Watch
Comment => Struts is not a concern as we have a process preventing exploits of its vulnerabilities 


## Go to list of Ignore Rules

- Show the content of each rule
- Show expiration time of freemarker rule

## Build the gradle project another time

```bash
jfrog rt gradle clean artifactoryPublish \
            -b build.gradle \
            --build-name "${CLI_GRADLE_LEGACY_BUILD_NAME}" \
            --build-number 2 \
            -PprojectVersion="${PROJECT_VERSION_DEMO1}" \
            -PartifactoryUrl="${ARTIFACTORY_URL}" \
            -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
            -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
            -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
            -PstrutsVersion="${STRUTS_VERSION_UNSAFE}"
```

## Publish Gradle Build info

```bash
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_LEGACY_BUILD_NAME}" 2
```

## Scan Gradle Build

```bash
jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_LEGACY_BUILD_NAME}" 2
```

## Go to build page

=> Open devsecops-legacy-gradle #2
=> Force Scan on build #1 if result is not yet published
=> show empty violations tab 
=> Show Ignored violations

## Conclusion

Image can be built successfully after ignoring legacy violations.
You can apply the same procedure to get rid of any violations and start from a clean sheet.
From this point onward, you'll be able to take advantage of the fail build feature to check for any new vulnerability that could arise.

