# Lab5 - Docker Package manager

## Step1 - Fork the repository
- Fork this repository - https://github.com/jfrog/SwampUp2021
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/fork-repo.png" alt="Fork repo" style="height: 100px; width:100px;"/>

- Clone the forked repository
    -- ```git clone <your git repo path>```  
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/git-clone.png" alt="git clone" style="height: 100px; width:100px;"/>

- Navigate to Lab4 on the forked project on your local box.
  ```cd SwampUp2021/SU-113-Jfrog-Artifactory-Essentials/Lab4```


## Step2 - Update the dockerfile  

- Update the dockerfile present under lab4 section.Update the FROM line of the Dockerfile to reference your virtual Docker repository.
    - ```FROM ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/alpine:3.11.5```
      
    - The SERVER_NAME is the first part of the URL given to you for your environment: ```https://<SERVER_NAME>.jfrog.io.``` You can also get this information from the docker login command from Lab2
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/docker-commands.png" alt="docker commands" style="height: 100px; width:100px;"/>

    - The VIRTUAL_REPO_NAME is the name “swampup-docker” that you assigned to your virtual repository in Step 3 on Lab2.
    - After modifying your dockerfile should be something like below
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/modified-dockerfile.png" alt="dockerfile" style="height: 100px; width:100px;"/>
    
## Step3 - Push custom image to your docker repository

- Login to your docker virtual repository
    - ``` $docker login ${SERVER_NAME}.jfrog.io```
      
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/docker-login.png" alt="docker login" style="height: 100px; width:100px;"/>
      
- Build your docker image
    - ```$ docker build --tag ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest . ```
      
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/docker-build.png" alt="docker build" style="height: 100px; width:100px;"/>
      
- Push the build docker image to your docker registry
    - ``` $ docker push ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest ```
      
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/docker-push.png" alt="docker push" style="height: 100px; width:100px;"/>

### Awesome !!! You have successfully completed Lab4. Next lab we will help you to search and view the artifacts.

    
      