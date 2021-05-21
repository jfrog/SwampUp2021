#! /bin/sh

export PROJECT_VERSION_LAB1="0.0.9"
export PROJECT_VERSION_LAB3="0.0.10"
export PROJECT_VERSION_LAB4="1.0.0"
export PROJECT_VERSION_DEMO1="0.0.11"
export STRUTS_VERSION_UNSAFE="2.0.5"
export STRUTS_VERSION_SAFE="2.5.26"
export ALPINE_IMAGE_TAG_UNSAFE="3.1"
export ALPINE_IMAGE_TAG_SAFE="3.13.0"
export IMAGE_NAME="swampup/devsecops"
export GRADLE_REPO_REMOTE="alpha-gradle-remote"
export GRADLE_REPO_DEV="alpha-gradle-dev"
export GRADLE_REPO_PROD="alpha-gradle-prod"
export DOCKER_REPO_REMOTE="alpha-docker-remote"
export DOCKER_REPO_DEV="alpha-docker-dev"
export DOCKER_REPO_PROD="alpha-docker-prod"
export CLI_GRADLE_BUILD_NAME="alpha-gradle"
export CLI_DOCKER_BUILD_NAME="alpha-docker"
export JFROG_CLI_OFFER_CONFIG=false
export CLI_INSTANCE_ID="my-instance"

export ARTIFACTORY_URL="https://${ARTIFACTORY_HOSTNAME}/artifactory"
export XRAY_URL="https://${ARTIFACTORY_HOSTNAME}/xray"
export DOCKER_REGISTRY_DEV="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_DEV}"
export DOCKER_REGISTRY_PROD="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_PROD}"

export BASE_IMAGE_UNSAFE="${DOCKER_REGISTRY_PROD}/alpine:${ALPINE_IMAGE_TAG_UNSAFE}"
export BASE_IMAGE_SAFE="${DOCKER_REGISTRY_PROD}/alpine:${ALPINE_IMAGE_TAG_SAFE}"
export IMAGE_ABSOLUTE_NAME_DEV_LAB1="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION_LAB1}"
export IMAGE_ABSOLUTE_NAME_DEV_LAB3="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION_LAB3}"
export IMAGE_ABSOLUTE_NAME_DEV_LAB4="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION_LAB4}"
export IMAGE_ABSOLUTE_NAME_PROD_LAB1="${DOCKER_REGISTRY_PROD}/${IMAGE_NAME}:${PROJECT_VERSION_LAB1}"
export IMAGE_ABSOLUTE_NAME_PROD_LAB4="${DOCKER_REGISTRY_PROD}/${IMAGE_NAME}:${PROJECT_VERSION_LAB4}"

jfrog config add "${CLI_INSTANCE_ID}" --artifactory-url="${ARTIFACTORY_URL}" --user="${ARTIFACTORY_LOGIN}" --apikey="${ARTIFACTORY_API_KEY}" --interactive=false

jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-docker-dev-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-docker-prod-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-docker-remote;repo-type=remote;tech=docker;url=https://registry-1.docker.io/" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-docker-dev;repo-type=virtual;tech=docker;repositories=alpha-docker-remote,alpha-docker-dev-local;default=alpha-docker-dev-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-docker-prod;repo-type=virtual;tech=docker;repositories=alpha-docker-remote,alpha-docker-prod-local;default=alpha-docker-prod-local" --server-id="${CLI_INSTANCE_ID}"

jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-gradle-dev-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-gradle-prod-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-gradle-remote;repo-type=remote;tech=gradle;url=https://jcenter.bintray.com" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-gradle-dev;repo-type=virtual;tech=gradle;repositories=alpha-gradle-remote,alpha-gradle-dev-local;default=alpha-gradle-dev-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=alpha-gradle-prod;repo-type=virtual;tech=gradle;repositories=alpha-gradle-remote,alpha-gradle-prod-local;default=alpha-gradle-prod-local" --server-id="${CLI_INSTANCE_ID}"

jfrog rt bce "${CLI_DOCKER_BUILD_NAME}" 0
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" 0
jfrog rt bce "${CLI_GRADLE_BUILD_NAME}" 0
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" 0

sh