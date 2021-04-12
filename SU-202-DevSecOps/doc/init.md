# Setup

All command line instructions have to be run from the root folder of the project

## Environment

copy *scripts/build.env.template* to *scripts/build.env* and set values accordingly:

```bash
ARTIFACTORY_HOSTNAME='my-instance.jfrog.io'
ARTIFACTORY_LOGIN='foo@bar.com'
ARTIFACTORY_API_KEY='MY_KEY'
```

## Source properties

```bash
source scripts/build.env
```

## More properties

```bash
ARTIFACTORY_URL="https://${ARTIFACTORY_HOSTNAME}/artifactory"
CLI_INSTANCE_ID='my-instance'
```

## Download JFrog CLI

```bash
curl -fL https://getcli.jfrog.io | sh
```

## Configure JFrog CLI

```bash
./jfrog config add "${CLI_INSTANCE_ID}" --artifactory-url="${ARTIFACTORY_URL}" --user="${ARTIFACTORY_LOGIN}" --apikey="${ARTIFACTORY_API_KEY}" --interactive=false
```

## Create repositories

```bash
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-docker-dev-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-docker-prod-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-docker-remote;repo-type=remote;tech=docker;url=https://registry-1.docker.io/" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-docker-dev;repo-type=virtual;tech=docker;repositories=devsecops-docker-remote,devsecops-docker-dev-local;default=devsecops-docker-dev-local" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-docker-prod;repo-type=virtual;tech=docker;repositories=devsecops-docker-remote,devsecops-docker-prod-local;default=devsecops-docker-prod-local" --server-id="${CLI_INSTANCE_ID}"

./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-gradle-dev-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-gradle-prod-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-gradle-remote;repo-type=remote;tech=gradle;url=https://jcenter.bintray.com" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-gradle-dev;repo-type=virtual;tech=gradle;repositories=devsecops-gradle-remote,devsecops-gradle-dev-local;default=devsecops-gradle-dev-local" --server-id="${CLI_INSTANCE_ID}"
./jfrog rt repo-create scripts/template-create-repo.json --vars "repo-name=devsecops-gradle-prod;repo-type=virtual;tech=gradle;repositories=devsecops-gradle-remote,devsecops-gradle-prod-local;default=devsecops-gradle-prod-local" --server-id="${CLI_INSTANCE_ID}"
```

