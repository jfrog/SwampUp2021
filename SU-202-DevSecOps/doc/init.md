# Setup

Reminder: if you're lost, please contact our training assistant!

## Source code

- git clone / download the source code
  https://github.com/jfrog/SwampUp2021

## Requirements

- JFrog Platform instance
- Docker

## API Key

Generate an Artifactory [API Key](https://www.jfrog.com/confluence/display/JFROG/User+Profile#UserProfile-APIKey)

## Build docker lab runner

- Open a terminal and navigate to the current session's root folder:
```bash
cd SU-202-DevSecOps
```

- Set variables to build your image
```bash
ARTIFACTORY_HOSTNAME="my-instance.jfrog.io"
ARTIFACTORY_LOGIN="foo@bar.com"
ARTIFACTORY_API_KEY="MY_API_KEY"
```

- Build the Docker lab runner image, replacing the variables according to your setup:
```bash
docker build -f lab-runner/Dockerfile --build-arg ARTIFACTORY_HOSTNAME="${ARTIFACTORY_HOSTNAME}" --build-arg ARTIFACTORY_LOGIN="${ARTIFACTORY_LOGIN}" --build-arg ARTIFACTORY_API_KEY="${ARTIFACTORY_API_KEY}" -t swampup:runner . --no-cache 
```

## Start the lab runner

```bash
docker run --name swampup-runner --rm -it -v "/var/run/docker.sock:/var/run/docker.sock" swampup:runner /bin/sh
```

From this point onward, every command will be run from within the container.

## Configure JFrog CLI

JFrog CLI is a clean and convenient way to interact with Artifactory.

```bash
jfrog config add "${CLI_INSTANCE_ID}" --artifactory-url="${ARTIFACTORY_URL}" --user="${ARTIFACTORY_LOGIN}" --apikey="${ARTIFACTORY_API_KEY}" --interactive=false
```

## 

jfrog rt ping

if unseccful redirect to build

## Create repositories

For each package type (docker, gradle) and maturity (dev, prod), we'll create:
- a local repository
- a remote repository
- a virtual repository

```bash
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-docker-dev-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-docker-prod-local;repo-type=local;tech=docker" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-docker-remote;repo-type=remote;tech=docker;url=https://registry-1.docker.io/" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-docker-dev;repo-type=virtual;tech=docker;repositories=devsecops-docker-remote,devsecops-docker-dev-local;default=devsecops-docker-dev-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-docker-prod;repo-type=virtual;tech=docker;repositories=devsecops-docker-remote,devsecops-docker-prod-local;default=devsecops-docker-prod-local" --server-id="${CLI_INSTANCE_ID}"

jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-gradle-dev-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-gradle-prod-local;repo-type=local;tech=gradle" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-gradle-remote;repo-type=remote;tech=gradle;url=https://jcenter.bintray.com" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-gradle-dev;repo-type=virtual;tech=gradle;repositories=devsecops-gradle-remote,devsecops-gradle-dev-local;default=devsecops-gradle-dev-local" --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-create template-create-repo.json --vars "repo-name=devsecops-gradle-prod;repo-type=virtual;tech=gradle;repositories=devsecops-gradle-remote,devsecops-gradle-prod-local;default=devsecops-gradle-prod-local" --server-id="${CLI_INSTANCE_ID}"
```
