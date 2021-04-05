# Lab4 - Setup Docker client to work with the Docker registry

## Step1 - Update the dockerfile  
- Navigate to Lab4 on the forked project on your local box.
- Update the dockerfile present under lab4 section.Update the FROM line of the Dockerfile to reference your virtual Docker repository.
    - FROM ${SERVER_NAME}.jfrog.io/${VIRTUAL_REPO_NAME}/alpine:3.11.5
    - The SERVER_NAME is the first part of the URL given to you for your environment: https://SERVER_NAME.jfrog.io. You can also get this information from the docker login command from Lab2
      <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab4/images/docker-commands.png" alt="docker commands" style="height: 100px; width:100px;"/>

    - The VIRTUAL_REPO_NAME is the name “docker” that you assigned to your virtual repository in Step 3 on Lab2.
    
- Push the changes to your git repository which you forked
      