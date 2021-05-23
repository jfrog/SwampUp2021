#!/usr/bin/env sh

#################
# build process #
#################
echo "INFO - configure CLI for Gradle"
jfrog rt gradle-config --server-id-resolve="${CLI_INSTANCE_ID}" --repo-resolve="${GRADLE_REPO_DEV}" --server-id-deploy="${CLI_INSTANCE_ID}" --repo-deploy="${GRADLE_REPO_DEV}" --use-wrapper=false --uses-plugin=true --deploy-ivy-desc=false

echo "INFO - build gradle project"
jfrog rt gradle clean artifactoryPublish \
            -b ../../build.gradle \
            --build-name "${CLI_GRADLE_BUILD_NAME}" \
            --build-number 2 \
            -PprojectVersion="${PROJECT_VERSION_LAB4}" \
            -PartifactoryUrl="${ARTIFACTORY_URL}" \
            -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
            -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
            -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
            -PstrutsVersion="${STRUTS_VERSION_SAFE}"

echo "INFO - publish Gradle build info"
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" 2

echo "INFO - Promote Gradle build to ${GRADLE_REPO_PROD}"
jfrog rt build-promote --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" 2 "${GRADLE_REPO_PROD}-local"

echo "INFO - Log into Docker registry ${DOCKER_REGISTRY_DEV}"
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"

echo "INFO - Build docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
(cd ../.. ; docker build -t "${IMAGE_ABSOLUTE_NAME_DEV_LAB4}" --build-arg "BASE_IMAGE=${BASE_IMAGE_SAFE}" .)

#echo "INFO - Add dependencies to Build info"
#docker rmi "${BASE_IMAGE}"
#./jfrog rt docker-pull --server-id="${CLI_INSTANCE_ID}" --skip-login --build-name="${CLI_DOCKER_BUILD_NAME}" --build-number="${CLI_BUILD_ID}" --module="${CLI_DOCKER_BUILD_NAME}" "${BASE_IMAGE}" "${DOCKER_REPO_PROD}"
#./jfrog rt build-add-dependencies --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" "${CLI_BUILD_ID}" "build/distributions/*.tar"

echo "INFO - Push docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
jfrog rt docker-push --server-id="${CLI_INSTANCE_ID}" --skip-login --build-name="${CLI_DOCKER_BUILD_NAME}" --build-number=2 --module="${CLI_DOCKER_BUILD_NAME}" "${IMAGE_ABSOLUTE_NAME_DEV_LAB4}" "${DOCKER_REPO_DEV}"

echo "INFO - Publish Docker build info"
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" 2

echo "INFO - Scan Docker build"
jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" 2

echo "INFO - Promote Docker image to ${DOCKER_REPO_PROD}"
jfrog rt build-promote --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" 2 "${DOCKER_REPO_PROD}-local"

echo "INFO - Remove local docker image"
docker rmi ${BASE_IMAGE_UNSAFE}
docker rmi ${BASE_IMAGE_SAFE}

echo "INFO - Check local docker image"
docker images | grep "${DOCKER_REPO_PROD}"

echo "INFO - Pull docker image"
docker pull "${IMAGE_ABSOLUTE_NAME_PROD_LAB4}"

echo "INFO - Check local docker image"
docker images | grep "${DOCKER_REPO_PROD}"
