# Lab 4

## Context

- You have been provided a vulnerability report and told to clean your software.

## Objective

![](images/lab4.png)

- Fix the security issues
- Build the Docker image in a CI like environment using JFrog CLI
- Upload the build information to Artifactory
- Scan while building
- Upload the artifacts to Artifactory
- Promote the Docker image to a production grade repository
- Download the Docker image 

## Check devsecops-docker-build-watch watch violations dashboard 

## Configure Gradle build

```bash
jfrog rt gradle-config --server-id-resolve="${CLI_INSTANCE_ID}" --repo-resolve="${GRADLE_REPO_DEV}" --server-id-deploy="${CLI_INSTANCE_ID}" --repo-deploy="${GRADLE_REPO_DEV}" --use-wrapper=false --uses-plugin=true --deploy-ivy-desc=false
```

## Build the gradle project

```bash
printf "Building ${PROJECT_VERSION_LAB4}\nwith struts ${STRUTS_VERSION_SAFE} (safe)\n" 
```

```bash
jfrog rt gradle clean artifactoryPublish \
            -PprojectVersion="${PROJECT_VERSION_LAB4}" \
            -PartifactoryUrl="${ARTIFACTORY_URL}" \
            -PartifactoryGradleRepo="${GRADLE_REPO_DEV}" \
            -PartifactoryUser="${ARTIFACTORY_LOGIN}" \
            -PartifactoryApiKey="${ARTIFACTORY_API_KEY}" \
            -PstrutsVersion="${STRUTS_VERSION_SAFE}" \
            --build-name "${CLI_GRADLE_BUILD_NAME}" \
            --build-number 2
```

## Publish Gradle Build info

```bash
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" 2
```

## Promote Gradle build to production repository

```bash
jfrog rt build-promote --server-id="${CLI_INSTANCE_ID}" "${CLI_GRADLE_BUILD_NAME}" 2 "${GRADLE_REPO_PROD}-local" 
```

## Log into Docker registry

```bash
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"
```

## Build Docker image

```bash
printf "Building ${IMAGE_ABSOLUTE_NAME_DEV_LAB4}\nwith base image ${BASE_IMAGE_SAFE} (safe)\n" 
```

```bash
docker build -t "${IMAGE_ABSOLUTE_NAME_DEV_LAB4}" --build-arg "BASE_IMAGE=${BASE_IMAGE_SAFE}" . --no-cache
```

## Push Docker image to Artifactory

```bash
jfrog rt docker-push --server-id="${CLI_INSTANCE_ID}" --skip-login --build-name="${CLI_DOCKER_BUILD_NAME}" --build-number=2 --module="${CLI_DOCKER_BUILD_NAME}" "${IMAGE_ABSOLUTE_NAME_DEV_LAB4}" "${DOCKER_REPO_DEV}"
```

## Publish Docker Build info

```bash
jfrog rt build-publish --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" 2
```

## Scan Docker Build

```bash
jfrog rt build-scan --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" 2
```

## Promote Docker image to production repository

```bash
jfrog rt build-promote --server-id="${CLI_INSTANCE_ID}" "${CLI_DOCKER_BUILD_NAME}" 2 "${DOCKER_REPO_PROD}-local" 
```

## Download image

Remove local docker image:
```bash
docker rmi ${BASE_IMAGE_UNSAFE}
docker rmi ${BASE_IMAGE_SAFE}
```

Check local docker image:
```bash
docker images | grep "${DOCKER_REPO_PROD}"
```

Pull docker image:
```bash
docker pull "${IMAGE_ABSOLUTE_NAME_PROD_LAB4}"
```

Check local docker image:
```bash
docker images | grep "${DOCKER_REPO_PROD}"
```

## Conclusion

- Build passed successfully
- Image can be downloaded successfully