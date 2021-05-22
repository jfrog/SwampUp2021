# Setup

Reminder: if you're lost, please contact the crew!

## Source code

- Open Github repository jfrog/SwampUp2021 in a browser
- Navigate to SU-202-DevSecOps/doc folder
- Open init.md

```bash
https://github.com/jfrog/SwampUp2021/blob/main/SU-202-DevSecOps/doc/init.md
```

## Requirements

- JFrog Platform instance
- Docker

## API Key

Generate an Artifactory [API Key](https://www.jfrog.com/confluence/display/JFROG/User+Profile#UserProfile-APIKey)

## Configure runner environment

- Open a terminal

- Set variables to build your image
```bash
ARTIFACTORY_HOSTNAME="my-instance.jfrog.io"
ARTIFACTORY_LOGIN="foo@bar.com"
ARTIFACTORY_API_KEY="MY_API_KEY"
```

- On Windows OS, please use
```bash
set ARTIFACTORY_HOSTNAME="my-instance.jfrog.io"
set ARTIFACTORY_LOGIN="foo@bar.com"
set ARTIFACTORY_API_KEY="MY_API_KEY"
```

## Start the lab runner

```bash
docker run --name swampup202-runner --rm --env  ARTIFACTORY_HOSTNAME="${ARTIFACTORY_HOSTNAME}" --env ARTIFACTORY_LOGIN="${ARTIFACTORY_LOGIN}" --env ARTIFACTORY_API_KEY="${ARTIFACTORY_API_KEY}" -it -v "/var/run/docker.sock:/var/run/docker.sock" swampup202.jfrog.io/swampup/swampup202-runner
```

From this point onward, every command will be run from within the container.

## Check configuration

```bash
jfrog rt ping
```

if you are not getting an OK response, please check your environment variables, there might be a typo, and run the container again.
