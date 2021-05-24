# Lab4 - Working with Artifactory as your docker registry

## Prerequisite
- Required - Docker container to execute this lab
    - Navigate to the git code folder which you cloned/forked in Lab1
    - Navigate to  ```cd SwampUp2021/SU-113-Jfrog-Artifactory-Essentials```

    - Execute the below commands which will create a docker image with Alpine, curl,git, VI and docker installed and then run the docker container
        - ```docker build -t swampup113-lab-image:latest .```
        - ```docker run -ti -v /var/run/docker.sock:/var/run/docker.sock swampup113-lab-image:latest```
        
    - Once the above container is up and running, Please execute the below steps inside this docker container.
        - ```git clone https://github.com/jfrog/SwampUp2021.git```

## Step1 - Navigate to Lab4 inside the container
- Navigate to Lab4 on the container
  ```cd ~/SwampUp2021/SU-113-Jfrog-Artifactory-Essentials/Lab4```


## Step2 - Update the dockerfile  

- Update the dockerfile present under lab4 section.Update the FROM line of the Dockerfile to reference your virtual Docker repository.
    - ```FROM ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/alpine:3.11.5```
      
    - The SERVER_NAME is the first part of the URL given to you for your environment: ```https://<SERVER_NAME>.jfrog.io.``` You can also get this information from the docker login command from Lab2
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/docker-command.png" alt="docker commands" style="height: 100px; width:100px;"/>

    - The VIRTUAL_REPO_NAME is the name “swampup-docker” that you assigned to your virtual repository in Step 3 on Lab2.
    - After modifying your dockerfile should be something like below
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/modified-dockerfiles.png" alt="dockerfile" style="height: 100px; width:100px;"/>
    
## Step3 - Push custom image to your docker repository

- Login to your docker virtual repository. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in Step2
    - ``` $docker login ${SERVER_NAME}.jfrog.io```
      
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/login-docker.png" alt="docker login" style="height: 100px; width:100px;"/>
      
- Build your docker image. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in Step2
    - ```$ docker build --tag ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest . ```
      
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/docker-builds.png" alt="docker build" style="height: 100px; width:100px;"/>
      
- Push the build docker image to your docker registry. Replace the  SERVER_NAME and VIRTUAL_REPO_NAME as mentioned in Step2
    - ``` $ docker push ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/my-docker-image:latest ```
      
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/dockerpush.png" alt="docker push" style="height: 100px; width:100px;"/>

### Awesome !!! You have successfully completed Lab4. Next lab we will help you to search and view the artifacts.

    
      