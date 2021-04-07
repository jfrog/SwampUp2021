# Lab6 - Leverage CLI to publish build to Artifactory

## Run the build.sh script
- Navigate to Lab6 on the forked project on your local box.
  ```cd SwampUp2021/SU-113-Jfrog-Artifactory-Essentials/Lab6```
  
- Execute the ./build.sh script. Ensure you have the right permission to execute this on your local box
- You will be prompted to enter some important details. We will discuss each one of these during the class and while implementing this lab 
* Detail about each input
  * Configuration name for CLI : The name of how you would like Jfrog CLI to be configured on your local machine. e.g - "JPD" is the name which I am giving to access my Jfrog platform
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/CLI-Config-name.png" alt="CLI Config" style="height: 100px; width:100px;"/>
  
  * Jfrog instance name : The SERVER_NAME is the first part of the URL given to you for your environment: https://<SERVER_NAME>.jfrog.io. You can also get this information from the docker login command from Lab2.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/ServerName.png" alt="ServerName" style="height: 100px; width:100px;"/>
  
  * Jfrog instance username : username for accessing your jfrog platform instance with deployment privileges 
  
  * Jfrog instance username : password for accessing your jfrog platform instance
  
  * Docker Virtual Repository name : Please provide this as "docker". This is the name of the virtual repository which you created in Step3 of Lab2
  
  * Build name : Provide a name to your build. This Build name will be displayed under the Builds tab in Jfrog platform. 
     <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/buildname.png" alt="buildname" style="height: 100px; width:100px;"/>
    
  * Build name : Provide a name to your build. This Build name will be displayed under the Builds tab in Jfrog platform.
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/buildname.png" alt="buildname" style="height: 100px; width:100px;"/>

  * Build number : Provide a number to your build. This Buildnumber is usually your CI build run number.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/buildnumber.png" alt="Build Number" style="height: 100px; width:100px;"/>

## View the Build information in Artifactory



### Awesome !!! You have successfully completed Lab6. You can use CLI to push the build information from any CI build agent.

    
      