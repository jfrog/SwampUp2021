FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine AS PACKAGER

# Artifactory login informations
ARG ARTIFACTORY_HOSTNAME=foo
ARG ARTIFACTORY_LOGIN=bar
ARG ARTIFACTORY_API_KEY=baz

ENV PROJECT_VERSION_LAB1="0.0.9" \
    PROJECT_VERSION_LAB3="0.0.10" \
    PROJECT_VERSION_LAB4="1.0.0" \
    PROJECT_VERSION_DEMO1="0.0.11" \
    STRUTS_VERSION_UNSAFE="2.0.5" \
    STRUTS_VERSION_SAFE="2.5.26" \
    ALPINE_IMAGE_TAG_UNSAFE="3.1" \
    ALPINE_IMAGE_TAG_SAFE="3.13.0" \
    GRADLE_VERSION="7.0" \
    IMAGE_NAME="swampup/devsecops" \
    GRADLE_REPO_REMOTE="devsecops-gradle-remote" \
    GRADLE_REPO_DEV="devsecops-gradle-dev" \
    GRADLE_REPO_PROD="devsecops-gradle-prod" \
    DOCKER_REPO_REMOTE="devsecops-docker-remote" \
    DOCKER_REPO_DEV="devsecops-docker-dev" \
    DOCKER_REPO_PROD="devsecops-docker-prod" \
    CLI_GRADLE_BUILD_NAME='devsecops-gradle' \
    CLI_GRADLE_LEGACY_BUILD_NAME='devsecops-legacy-gradle' \
    CLI_DOCKER_BUILD_NAME='devsecops-docker' \
    JFROG_CLI_OFFER_CONFIG=false \
    ARTIFACTORY_URL="https://${ARTIFACTORY_HOSTNAME}/artifactory" \
    CLI_INSTANCE_ID="my-instance" \
    ARTIFACTORY_HOSTNAME=${ARTIFACTORY_HOSTNAME} \
    ARTIFACTORY_LOGIN=${ARTIFACTORY_LOGIN} \
    ARTIFACTORY_API_KEY=${ARTIFACTORY_API_KEY}

ENV ARTIFACTORY_URL="https://${ARTIFACTORY_HOSTNAME}/artifactory" \
    XRAY_URL="https://${ARTIFACTORY_HOSTNAME}/xray" \
    DOCKER_REGISTRY_DEV="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_DEV}" \
    DOCKER_REGISTRY_PROD="${ARTIFACTORY_HOSTNAME}/${DOCKER_REPO_PROD}"

ENV BASE_IMAGE_UNSAFE="${DOCKER_REGISTRY_PROD}/alpine:${ALPINE_IMAGE_TAG_UNSAFE}" \
    BASE_IMAGE_SAFE="${DOCKER_REGISTRY_PROD}/alpine:${ALPINE_IMAGE_TAG_SAFE}" \
    IMAGE_ABSOLUTE_NAME_DEV_LAB1="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION_LAB1}" \
    IMAGE_ABSOLUTE_NAME_DEV_LAB3="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION_LAB3}" \
    IMAGE_ABSOLUTE_NAME_DEV_LAB4="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}:${PROJECT_VERSION_LAB4}" \
    IMAGE_ABSOLUTE_NAME_PROD_LAB1="${DOCKER_REGISTRY_PROD}/${IMAGE_NAME}:${PROJECT_VERSION_LAB1}" \
    IMAGE_ABSOLUTE_NAME_PROD_LAB4="${DOCKER_REGISTRY_PROD}/${IMAGE_NAME}:${PROJECT_VERSION_LAB4}" \
    PATH="/usr/local:/usr/local/gradle-$GRADLE_VERSION/bin:$PATH"

WORKDIR /usr/local

# install curl and jq
RUN apk add --update \
    curl jq docker \
    && rm -rf /var/cache/apk/*

# install gradle
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip && \
    rm -f gradle-${GRADLE_VERSION}-bin.zip

# install jfrog CLI
RUN curl -fL https://getcli.jfrog.io | sh

# add sources
ADD src src
ADD build.gradle .
ADD settings.gradle .
ADD docker/Dockerfile .
# add scripts
ADD scripts scripts
