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
readonly XRAY_URL="https://${ARTIFACTORY_HOSTNAME}/xray"

readonly CLI_INSTANCE_ID='my-instance'
readonly CLI_GRADLE_BUILD_NAME='devsecops-gradle'
readonly CLI_DOCKER_BUILD_NAME='devsecops-docker'
readonly CLI_BUILD_ID='1'

readonly PROJECT_VERSION='0.0.10'
readonly STRUTS_VERSION='2.0.5'

readonly DOCKER_REPO_DEV=devsecops-docker-dev
readonly DOCKER_REPO_PROD=devsecops-docker-prod
readonly GRADLE_REPO_DEV=devsecops-gradle-dev

readonly DOCKER_REGISTRY_DEV="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_DEV}"
readonly DOCKER_REGISTRY_PROD="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_PROD}"

readonly BASE_IMAGE_REGISTRY="${DOCKER_REGISTRY_PROD}"
readonly BASE_IMAGE_TAG='3.1'
readonly BASE_IMAGE="${BASE_IMAGE_REGISTRY}/alpine:${BASE_IMAGE_TAG}"
readonly IMAGE_NAME='swampup/devsecops'
readonly IMAGE_ABSOLUTE_NAME_DEV="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION}"

#################
# build process #
#################
echo "INFO - Collect indexing configuration"
INDEXED_BUILDS=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                  -H 'Content-Type: application/json' \
                  -X GET "${XRAY_URL}/api/v1/binMgr/default/builds" \
                  | jq -r '.indexed_builds + ["devsecops-gradle-legacy","devsecops-docker","devsecops-gradle"]')

echo "INFO - Updating indexing configuration"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X PUT "${XRAY_URL}/api/v1/binMgr/default/builds" \
    -d \
    "{
        \"indexed_builds\": ${INDEXED_BUILDS}
    }"

echo "INFO - Create policy"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X POST "${XRAY_URL}/api/v2/policies" \
    -d \
    "{
        \"name\": \"fail-build-on-high-severity\",
        \"description\": \"Fail build on high severity issue\",
        \"type\": \"security\",
        \"rules\": [
            {
                \"name\": \"fail-build-on-high-severity-rule\",
                \"criteria\": {
                    \"min_severity\": \"high\"
                },
                \"actions\": {
                    \"fail_build\": true
                },
                \"priority\": 1
            }
        ]
    }"

echo "INFO - Create watch"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${XRAY_URL}/api/v2/watches" \
     -d \
     "{
        \"general_data\": {
            \"name\": \"devsecops-docker-build-watch\",
            \"description\": \"Docker build\",
            \"active\": true
        },
        \"project_resources\": {
            \"resources\": [{
                \"type\": \"all-builds\",
                \"bin_mgr_id\": \"default\",
                \"name\":\"\",
                \"filters\":[{\"type\":\"ant-patterns\",\"value\":{\"IncludePatterns\":[\"devsecops-*/*\"]}}]
            }]
        },
        \"assigned_policies\": [{
            \"name\": \"fail-build-on-high-severity\",
            \"type\": \"security\"
        }]
    }"

echo "INFO - configure CLI for Gradle"
../../jfrog rt gradle-config --server-id-resolve="${CLI_INSTANCE_ID}" --repo-resolve="${GRADLE_REPO_DEV}" --server-id-deploy="${CLI_INSTANCE_ID}" --repo-deploy="${GRADLE_REPO_DEV}" --use-wrapper=true --uses-plugin=true --deploy-ivy-desc=false

echo "INFO - build gradle project"
(cd ../.. ; ./jfrog rt gradle clean artifactoryPublish \
            -b build.gradle \
            --build-name "${CLI_GRADLE_BUILD_NAME}" \
            --build-number "${CLI_BUILD_ID}" \
            -PprojectVersion="${PROJECT_VERSION}" \
            -PartifactoryUrl="${ARTIFACTORY_URL}" \
            -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
            -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
            -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
            -PstrutsVersion="${STRUTS_VERSION}")

echo "INFO - publish Gradle build info"
../../jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" "${CLI_BUILD_ID}"

echo "INFO - Log into Docker registry ${DOCKER_REGISTRY_DEV}"
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"

echo "INFO - Build docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
(cd ../.. ; docker build -t "${IMAGE_ABSOLUTE_NAME_DEV}" --build-arg "BASE_IMAGE=${BASE_IMAGE}" .)

#echo "INFO - Add dependencies to Build info"
#docker rmi "${BASE_IMAGE}"
#./jfrog rt docker-pull --server-id="${CLI_INSTANCE_ID}" --skip-login --build-name="${CLI_DOCKER_BUILD_NAME}" --build-number="${CLI_BUILD_ID}" --module="${CLI_DOCKER_BUILD_NAME}" "${BASE_IMAGE}" "${DOCKER_REPO_PROD}"
#./jfrog rt build-add-dependencies --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" "${CLI_BUILD_ID}" "build/distributions/*.tar"

echo "INFO - Push docker image ${IMAGE_ABSOLUTE_NAME_DEV}"
../../jfrog rt docker-push --server-id="${CLI_INSTANCE_ID}" --skip-login --build-name="${CLI_DOCKER_BUILD_NAME}" --build-number="${CLI_BUILD_ID}" --module="${CLI_DOCKER_BUILD_NAME}" "${IMAGE_ABSOLUTE_NAME_DEV}" "${DOCKER_REPO_DEV}"

echo "INFO - Publish Docker build info"
../../jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" "${CLI_BUILD_ID}"

echo "INFO - Scan Gradle build"
../../jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" "${CLI_BUILD_ID}"

echo "INFO - Scan Docker build"
../../jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" "${CLI_BUILD_ID}"
