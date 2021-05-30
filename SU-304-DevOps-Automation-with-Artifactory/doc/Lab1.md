# swampup2021-SU-304-DevOps Automation with Artifactory (Basic)
# Setup

Reminder: if you're lost, please contact the crew!

## Source code

- Open Github repository https://github.com/jfrog/SwampUp2021 in a browser
- Navigate to SU-304-DevOps-Automation-with-Artifactory/doc folder
- Open Lab1.md

```bash
https://github.com/jfrog/SwampUp2021/blob/main/SU-304-DevOps-Automation-with-Artifactory/doc/Lab1.md
```

## Requirements

- JFrog Platform instance (Provided by JFrog before the training)
- Docker (installation links below)
CentOS/Redhat [CentOS Installation](https://docs.docker.com/engine/install/centos/)
Ubuntu [Ubuntu Installation](https://docs.docker.com/engine/install/ubuntu/)
Windows [Windows Installation](https://docs.docker.com/docker-for-windows/install/)
MacOS [MacOS Installation](https://docs.docker.com/docker-for-mac/install/)

## API Key

Generate an Artifactory [API Key](https://www.jfrog.com/confluence/display/JFROG/User+Profile#UserProfile-APIKey)
- Follow the recording below 

![geenrate API key](https://i.imgur.com/ElFGv6b.gif)

## Configure runner environment

- Open a terminal

- Set variables to build your image (see instaruction for Windows OS vs. Linux OS below) 

- On Linux OS, please use
```bash
export ARTIFACTORY_HOSTNAME="my-instance.jfrog.io"
export ARTIFACTORY_LOGIN="foo@bar.com"
export ARTIFACTORY_API_KEY="MY_API_KEY"
```

- On Windows OS, please use
```bash
ARTIFACTORY_HOSTNAME="my-instance.jfrog.io"
ARTIFACTORY_LOGIN="foo@bar.com"
ARTIFACTORY_API_KEY="MY_API_KEY"
```
Follow recording here - 
![setting environemnt variables](https://i.imgur.com/BastCGE.gif)

## Start the lab runner
- Ensure Docker is running on your system and run the following command 
For Linux 

```bash
docker run --name swampup202-runner --rm --env  ARTIFACTORY_HOSTNAME="${ARTIFACTORY_HOSTNAME}" --env ARTIFACTORY_LOGIN="${ARTIFACTORY_LOGIN}" --env ARTIFACTORY_API_KEY="${ARTIFACTORY_API_KEY}" -it -v "/var/run/docker.sock:/var/run/docker.sock" swampup202.jfrog.io/swampup/swampup202-runner
```
For Windows 

```bash
docker run --name swampup202-runner --rm --env ARTIFACTORY_HOSTNAME="%ARTIFACTORY_HOSTNAME%" --env ARTIFACTORY_LOGIN="%ARTIFACTORY_LOGIN%" --env ARTIFACTORY_API_KEY="%ARTIFACTORY_API_KEY%" -it -v "/var/run/docker.sock:/var/run/docker.sock" swampup202.jfrog.io/swampup/swampup202-runner
```

From this point onward, every command will be run from within the container.

## Check configuration

```bash
jfrog rt ping
```
Recording here - 

![setting environemnt variables](https://i.imgur.com/DHIbKfk.gif)

if you are not getting an OK response, please check your environment variables, there might be a typo, and run the container again.



## Conclusion 
- Using JfrogCLI ping command, we verified our test system is able to communicate with Artifactory
- Our lab environement is ready for palying around with all capabilities that Artifactory has to offer
