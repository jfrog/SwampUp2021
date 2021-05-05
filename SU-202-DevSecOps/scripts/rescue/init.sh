#!/usr/bin/env sh

#################
# init process #
#################
echo "INFO - configuring instance"
jfrog config add "${CLI_INSTANCE_ID}" --artifactory-url="${ARTIFACTORY_URL}" --user="${ARTIFACTORY_LOGIN}" --apikey="${ARTIFACTORY_API_KEY}" --interactive=false
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "ERROR - issue encountered while configuring instance"
    exit 3
fi

echo "INFO - creating repos"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${DOCKER_REPO_DEV}-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${DOCKER_REPO_PROD}-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${DOCKER_REPO_REMOTE};repo-type=remote;tech=docker;url=https://registry-1.docker.io/" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${DOCKER_REPO_DEV};repo-type=virtual;tech=docker;repositories=${DOCKER_REPO_REMOTE},${DOCKER_REPO_DEV}-local;default=${DOCKER_REPO_DEV}-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${DOCKER_REPO_PROD};repo-type=virtual;tech=docker;repositories=${DOCKER_REPO_REMOTE},${DOCKER_REPO_PROD}-local;default=${DOCKER_REPO_PROD}-local" --server-id="${CLI_INSTANCE_ID}"

jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${GRADLE_REPO_DEV}-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${GRADLE_REPO_PROD}-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${GRADLE_REPO_REMOTE};repo-type=remote;tech=gradle;url=https://jcenter.bintray.com" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${GRADLE_REPO_DEV};repo-type=virtual;tech=gradle;repositories=${GRADLE_REPO_REMOTE},${GRADLE_REPO_DEV}-local;default=${GRADLE_REPO_DEV}-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../../template-create-repo.json --vars "repo-name=${GRADLE_REPO_PROD};repo-type=virtual;tech=gradle;repositories=${GRADLE_REPO_REMOTE},${GRADLE_REPO_PROD}-local;default=${GRADLE_REPO_PROD}-local" --server-id="${CLI_INSTANCE_ID}"
