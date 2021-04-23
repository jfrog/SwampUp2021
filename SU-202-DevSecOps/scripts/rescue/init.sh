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
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-docker-dev-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-docker-prod-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-docker-remote;repo-type=remote;tech=docker;url=https://registry-1.docker.io/" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-docker-dev;repo-type=virtual;tech=docker;repositories=devsecops-docker-remote,devsecops-docker-dev-local;default=devsecops-docker-dev-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-docker-prod;repo-type=virtual;tech=docker;repositories=devsecops-docker-remote,devsecops-docker-prod-local;default=devsecops-docker-prod-local" --server-id="${CLI_INSTANCE_ID}"

jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-gradle-dev-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-gradle-prod-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-gradle-remote;repo-type=remote;tech=gradle;url=https://jcenter.bintray.com" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-gradle-dev;repo-type=virtual;tech=gradle;repositories=devsecops-gradle-remote,devsecops-gradle-dev-local;default=devsecops-gradle-dev-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create ../template-create-repo.json --vars "repo-name=devsecops-gradle-prod;repo-type=virtual;tech=gradle;repositories=devsecops-gradle-remote,devsecops-gradle-prod-local;default=devsecops-gradle-prod-local" --server-id="${CLI_INSTANCE_ID}"
