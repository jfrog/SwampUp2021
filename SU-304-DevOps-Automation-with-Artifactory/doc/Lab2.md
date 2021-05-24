# Lab2 - Get familiar with JFrog Platform, SetMeUp utility, REST API and JFrogCLI 

## Step1 - Download a Docker image from Artifactory using configuration provided by SetMeUp

- Open Artifactory URL provided to you as a part of Lab exercise 

- Access Artifactory Repositories - Navigate to Application tab in the Unified Platform. Open Artifactory -> Repositories. You will be able to see all the local, remote and virtual repositories 
 
 - Now, click on one of the docker remote repositories ```devsecops-docker-remote ``` and you can see that this remote repository is caching ```Docker Hub - https://registry-1.docker.io/```, A public registry for docker dependencies
 - then open the '```SetMeUp ``` button on the right hand top corner

![1-1](https://i.imgur.com/Eh4z23m.gif)
 
### Log into Docker registry

```bash
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_DEV}"
```

### Download Docker image from Artifactory's reository 

```bash
docker pull "${DOCKER_REGISTRY_DEV}/nginx:latest"
```

### Check remote repository's cache 
- UI Login and check the status of the Docker cache 
  ![view cache](https://i.imgur.com/9JplyOJ.gif)


### Conclusion 
- Successfully completed Dev Environemnt integration with Artifactory
- All Docker dependencies resolved/utilized by your Dev team is redirected to Artifactory
- Your Security and Development leads can keep track of dependencies your organization is utilizing 

### Entrypoint.sh 
- The entrypoint.sh located in the /usr/local directory of this docker container has completed the inital setup. Explore the JFrog CLI docuemntation on configuring Artifactory, creating repositories to learn more
Adding Artifactory to JFrogCLI [JFrogCLI- Adding and Editiong Configured Server](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI#JFrogCLI-AddingandEditingConfiguredServers)
Creating Repositories [JFrogCLI- Creating/Updating Repositories](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-Creating/UpdatingRepositories)

Recording here - 

<img src="/SU-304-DevOps-Automation-with-Artifactory/doc/images/Lab10in4.gif?raw=true" alt="JFrogCLI" style="height: 100px; width:100px;">

### Conclusion 
- We have completed initial setup and deployed all the required repositories using JFrogCLI 

## Bonus Section
- Think how you can control the sources your organization can rely on? Try to add another remote repository pointing to quay.io and cache a docker dependency 
- Utilizing the permmison target API/ JFrogCLI calls, control who can cache new dependencies (Cache/deploy privilege) and who can download exisitng cached images (Read privilege) 


