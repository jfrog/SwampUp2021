#!/usr/bin/env bash

################################
# Sourcing external properties #
################################
readonly BUILD_ENV_FILE=../../../scripts/build.env
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

readonly DOCKER_REPO_DEV=devsecops-docker-dev

readonly DOCKER_REGISTRY_DEV="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_DEV}"

readonly IMAGE_NAME='swampup/custom-provider:latest'
readonly IMAGE_ABSOLUTE_NAME_DEV="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}"

#################
# build process #
#################
echo "INFO - Log into Docker registry ${DOCKER_REGISTRY_DEV}"
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"

echo "INFO - Build Docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
docker build -t "${IMAGE_ABSOLUTE_NAME_DEV}" .

echo "INFO - Push Docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
docker push "${IMAGE_ABSOLUTE_NAME_DEV}"