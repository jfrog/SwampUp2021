#!/usr/bin/env sh

#################
# build process #
#################
echo "INFO - build Gradle project"
(cd ../.. ; gradle clean artifactoryPublish \
    -PprojectVersion="${PROJECT_VERSION_LAB1}" \
    -PartifactoryUrl="${ARTIFACTORY_URL}" \
    -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
    -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
    -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
    -PstrutsVersion="${STRUTS_VERSION_UNSAFE}")

echo "INFO - Log into Docker registry ${DOCKER_REGISTRY_DEV}"
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"

echo "INFO - Build Docker image ${IMAGE_ABSOLUTE_NAME_DEV_LAB1}"
(cd ../.. ; docker build -t "${IMAGE_ABSOLUTE_NAME_DEV_LAB1}" --build-arg "BASE_IMAGE=${BASE_IMAGE_UNSAFE}" .)

echo "INFO - Push Docker image ${IMAGE_ABSOLUTE_NAME_DEV_LAB1}"
docker push "${IMAGE_ABSOLUTE_NAME_DEV_LAB1}"

echo "INFO - Promote Docker image to ${DOCKER_REPO_PROD}"
curl -H "X-JFrog-Art-Api: ${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${ARTIFACTORY_URL}/api/docker/${DOCKER_REPO_DEV}-local/v2/promote" \
     -d "{\"targetRepo\":\"${DOCKER_REPO_PROD}-local\",\"dockerRepository\":\"${IMAGE_NAME}\"}"

echo "INFO - Remove docker image"
docker rmi "${IMAGE_ABSOLUTE_NAME_DEV_LAB1}" 2>/dev/null
docker rmi "${BASE_IMAGE_UNSAFE}" 2>/dev/null

echo "INFO - Check local docker image"
docker images | grep "${DOCKER_REPO_PROD}"

echo "INFO - Pull docker image"
docker pull "${IMAGE_ABSOLUTE_NAME_PROD_LAB1}"

echo "INFO - Check local docker image"
docker images | grep "${DOCKER_REPO_PROD}"