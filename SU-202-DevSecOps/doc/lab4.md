# Lab 4

## Context

- You are eventually asked to deliver clean software

## Objective

- Fix the security issues
- Build the Docker image in a CI like environment using JFrog CLI
- Upload the build information to Artifactory
- Scan while building
- Upload the artifacts to Artifactory
- Promote the Docker image to a production grade repository
- Download the Docker image 

## Source properties

```bash
source scripts/build.env
```

## Init Lab properties

```bash
ARTIFACTORY_URL="https://${ARTIFACTORY_HOSTNAME}/artifactory"

CLI_INSTANCE_ID='my-instance'
CLI_GRADLE_BUILD_NAME='devsecops-gradle'
CLI_DOCKER_BUILD_NAME='devsecops-docker'
CLI_BUILD_ID='2'

PROJECT_VERSION='1.0.0'
STRUTS_VERSION='2.5.26'

DOCKER_REPO_DEV=devsecops-docker-dev
DOCKER_REPO_PROD=devsecops-docker-prod
GRADLE_REPO_DEV=devsecops-gradle-dev
GRADLE_REPO_PROD=devsecops-gradle-prod

DOCKER_REGISTRY_DEV="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_DEV}"
DOCKER_REGISTRY_PROD="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_PROD}"

BASE_IMAGE_REGISTRY="${DOCKER_REGISTRY_PROD}"
BASE_IMAGE_TAG='3.13.0'
BASE_IMAGE="${BASE_IMAGE_REGISTRY}/alpine:${BASE_IMAGE_TAG}"
IMAGE_NAME='swampup/devsecops'
IMAGE_ABSOLUTE_NAME_DEV="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION}"
IMAGE_ABSOLUTE_NAME_PROD="${DOCKER_REGISTRY_PROD}/${IMAGE_NAME}:${PROJECT_VERSION}"
```

## Check watch results from build #1

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

## Promote Gradle build to production repository

```bash
./jfrog rt build-promote --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" "${CLI_BUILD_ID}" "${GRADLE_REPO_PROD}-local" 
```

## Log into Docker registry

```bash
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"
```

## Build Docker image

```bash
docker build -t "${IMAGE_ABSOLUTE_NAME_DEV}" --build-arg "BASE_IMAGE=${BASE_IMAGE}" .
```

## Push Docker image to Artifactory

```bash
./jfrog rt docker-push --server-id="${CLI_INSTANCE_ID}" --skip-login --build-name="${CLI_DOCKER_BUILD_NAME}" --build-number="${CLI_BUILD_ID}" --module="${CLI_DOCKER_BUILD_NAME}" "${IMAGE_ABSOLUTE_NAME_DEV}" "${DOCKER_REPO_DEV}"
```

## Publish Docker Build info

```bash
./jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" "${CLI_BUILD_ID}"
```

## Scan Docker Build

```bash
./jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" "${CLI_BUILD_ID}"
```

## Promote Docker image to production repository

```bash
./jfrog rt build-promote --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" "${CLI_BUILD_ID}" "${DOCKER_REPO_PROD}-local" 
```

## Download image

Check local docker image:
```bash
docker images | grep "${DOCKER_REPO_PROD}"
```

Pull docker image:
```bash
docker pull "${IMAGE_ABSOLUTE_NAME_PROD}"
```

Check local docker image:
```bash
docker images | grep "${DOCKER_REPO_PROD}"
```

## Conclusion

- Build passed successfully
- Image can be downloaded successfully