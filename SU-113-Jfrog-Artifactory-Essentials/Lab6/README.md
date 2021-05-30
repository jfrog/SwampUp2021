# Lab6 - Leverage CLI to publish build to Artifactory

## Prerequisite
- Leverage the same container from Lab4. Ensure it is up and running. If the container has stopped, please refer Lab4 to run the container again.
  
- All the below steps (Step 1 to Step 4 needs to be executed inside this container )

## Step 1 - Run the build.sh script
- Navigate to Lab6 on the forked project on your container.
  ```cd ~/SwampUp2021/SU-113-Jfrog-Artifactory-Essentials/Lab6```
  
- Execute the ./build.sh script. 
- You will be prompted to enter some important details. We will discuss each one of these during the class and while implementing this lab 
* Detail about each input
  * Configuration name for CLI : The name used to reference your instance using Jfrog CLI on your local machine. e.g - "JPD" is the name which I am giving to access my Jfrog platform
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/CLI-Config-name.png" alt="CLI Config" style="height: 100px; width:100px;"/>
  
  * Jfrog instance name : The SERVER_NAME is the first part of the URL given to you for your environment: https://<SERVER_NAME>.jfrog.io. You can also get this information from the docker login command from Lab2.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/docker-command-display.png" alt="ServerName" style="height: 100px; width:100px;"/>
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/Server-Name.png" alt="ServerName" style="height: 100px; width:100px;"/>
  
  * Jfrog instance username : username for accessing your jfrog platform instance with deployment privileges 
  
  * Jfrog instance password : password for accessing your jfrog platform instance
  
  * Docker Virtual Repository name : Please provide this as "swampup-docker". This is the name of the virtual repository which you created in Step3 of Lab2
  
  * Build name : Provide a name to your build. This Build name will be displayed under the Builds tab in Jfrog platform. 
     <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/buildname.png" alt="buildname" style="height: 100px; width:100px;"/>
    
  * Build number : Provide a number to your build. This Buildnumber is usually your CI build run number.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/buildnumber.png" alt="Build Number" style="height: 100px; width:100px;"/>
    
- Once the above information is entered, the script dynamically modifies the Dockerfile to point to your SERVER_NAME and  VIRTUAL_REPO_NAME to point to your docker virtual repository ("swampup-docker")

- Finally, You should see that CLI builds the docker image and pushes to artifactory
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/buildsuccess.png" alt="Build success" style="height: 100px; width:100px;"/>

## Step 2 - View the Build information in Artifactory

- Navigate to the Application Module, expand the Artifactory menu and click the Build menu item. The published build is displayed here
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/build.png" alt="Build" style="height: 100px; width:100px;"/>
  
  
- Click the BuildName and the build number to view the published modules
  
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/build-name.png" alt="Build Name" style="height: 100px; width:100px;"/>

  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/build-number.png" alt="Build Number" style="height: 100px; width:100px;"/>

- Click the published docker image to view the different layers on it

  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/publishedmodule-layer.png" alt="Build Number" style="height: 100px; width:100px;"/>

## Step 3- Adding properties/metadata to the published build

- You can add properties to the docker image published. Below is a sample on how to add properties to the published docker image as part of the build

```$jfrog rt sp  --include-dirs=true "swampup-docker-dev-local/docker-example-build-image/1*" "unittest=passed"```

  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/properties-update.png" alt="properties" style="height: 100px; width:100px;"/>

- Once the properties are added, we can navigate to the respective docker image to view the data on the UI

  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/properties-ui.png" alt="properties-ui" style="height: 100px; width:100px;"/>


## Step 4-  Promote the Build 

- Promote the build and its associated build information to production. Below we are promoting our "Sample-docker-cli-build" to "swampup-docker-prod-local" repository
```$ jfrog rt build-promote sample-docker-cli-build 1 swampup-docker-prod-local```
  
- View the published module to validate the binary is now in swampup-docker-prod-local
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/build-promotion.png" alt="Build Number" style="height: 100px; width:100px;"/>


### Awesome !!! You have successfully completed Lab6. You can use CLI to push the build information from any CI build agent.

    
      
