# Lab 1

## Context

- You are developing a new software and security is not a concern

## Objective

- Create a Gradle project and ship the archive in a Docker image
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

PROJECT_VERSION='0.0.9'
STRUTS_VERSION='2.0.5'

DOCKER_REPO_DEV=devsecops-docker-dev
DOCKER_REPO_PROD=devsecops-docker-prod

DOCKER_REGISTRY_DEV="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_DEV}"
DOCKER_REGISTRY_PROD="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_PROD}"

BASE_IMAGE_REGISTRY="${DOCKER_REGISTRY_PROD}"
BASE_IMAGE_TAG='3.1'
BASE_IMAGE="${BASE_IMAGE_REGISTRY}/alpine:${BASE_IMAGE_TAG}"
IMAGE_NAME='swampup/devsecops'
IMAGE_ABSOLUTE_NAME_DEV="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION}"
IMAGE_ABSOLUTE_NAME_PROD="${DOCKER_REGISTRY_PROD}/${IMAGE_NAME}:${PROJECT_VERSION}"
```

## Build the gradle project

```bash
./gradlew clean artifactoryPublish \
    -PprojectVersion="${PROJECT_VERSION}" \
    -PartifactoryUrl="${ARTIFACTORY_URL}" \
    -PartifactoryGradleRepo="devsecops-gradle-dev" \
    -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
    -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
    -PstrutsVersion="${STRUTS_VERSION}"
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
docker push "${IMAGE_ABSOLUTE_NAME_DEV}"
```

## Promote Docker image to production repository

```bash
curl -H "X-JFrog-Art-Api: ${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${ARTIFACTORY_URL}/api/docker/${DOCKER_REPO_DEV}-local/v2/promote" \
     -d "{\"targetRepo\":\"${DOCKER_REPO_PROD}-local\",\"dockerRepository\":\"${IMAGE_NAME}\"}"
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

Image can be downloaded successfully