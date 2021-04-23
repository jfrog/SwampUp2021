#!/usr/bin/env bash

################################
# Sourcing external properties #
################################
readonly BUILD_ENV_FILE=../build.env
if [ ! -f "${BUILD_ENV_FILE}" ]; then
    echo "ERROR - could not find ${BUILD_ENV_FILE}"
    exit 1
fi

source "${BUILD_ENV_FILE}"

echo "INFO - artifactory = ${ARTIFACTORY_HOSTNAME}"
echo "INFO - login = ${ARTIFACTORY_LOGIN}"

#######################
# internal properties #
#######################
readonly ARTIFACTORY_URL="https://${ARTIFACTORY_HOSTNAME}/artifactory"

readonly PROJECT_VERSION='0.0.9'
readonly STRUTS_VERSION='2.0.5'

readonly DOCKER_REPO_DEV=devsecops-docker-dev
readonly DOCKER_REPO_PROD=devsecops-docker-prod

readonly DOCKER_REGISTRY_DEV="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_DEV}"
readonly DOCKER_REGISTRY_PROD="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_PROD}"

readonly BASE_IMAGE_REGISTRY="${DOCKER_REGISTRY_PROD}"
readonly BASE_IMAGE_TAG='3.1'
readonly BASE_IMAGE="${BASE_IMAGE_REGISTRY}/alpine:${BASE_IMAGE_TAG}"
readonly IMAGE_NAME='swampup/devsecops'
readonly IMAGE_ABSOLUTE_NAME_DEV="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION}"
readonly IMAGE_ABSOLUTE_NAME_PROD="${DOCKER_REGISTRY_PROD}/${IMAGE_NAME}:${PROJECT_VERSION}"

#################
# build process #
#################
echo "INFO - build Gradle project"
(cd ../.. ; ./gradlew clean artifactoryPublish \
    -PprojectVersion="${PROJECT_VERSION}" \
    -PartifactoryUrl="${ARTIFACTORY_URL}" \
    -PartifactoryGradleRepo="devsecops-gradle-dev" \
    -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
    -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
    -PstrutsVersion="${STRUTS_VERSION}")

echo "INFO - Log into Docker registry ${DOCKER_REGISTRY_DEV}"
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"

echo "INFO - Build Docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
(cd ../.. ; docker build -t "${IMAGE_ABSOLUTE_NAME_DEV}" --build-arg "BASE_IMAGE=${BASE_IMAGE}" .)

echo "INFO - Push Docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
docker push "${IMAGE_ABSOLUTE_NAME_DEV}"

echo "INFO - Promote Docker image to ${DOCKER_REPO_PROD}"
curl -H "X-JFrog-Art-Api: ${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${ARTIFACTORY_URL}/api/docker/${DOCKER_REPO_DEV}-local/v2/promote" \
     -d "{\"targetRepo\":\"${DOCKER_REPO_PROD}-local\",\"dockerRepository\":\"${IMAGE_NAME}\"}"

echo "INFO - Check local docker image"
docker images | grep "${DOCKER_REPO_PROD}"

echo "INFO - Pull docker image"
docker pull "${IMAGE_ABSOLUTE_NAME_PROD}"

echo "INFO - Check local docker image"
docker images | grep "${DOCKER_REPO_PROD}"
