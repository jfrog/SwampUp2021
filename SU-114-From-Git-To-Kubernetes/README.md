# From Git to Kubernetes: Cloud Native DevOps (Advanced)
<p align="center">
  <img src="https://i.ibb.co/xq9xX6R/Screen-Shot-2021-05-01-at-14-22-19.png" />
</p>
### In this training session, you’ll learn best-practices when using the JFrog Platform to store and manage your Docker images and Kubernetes deployments from beginning to end, while also setting up a continuous build, test and deploy pipeline. We’ll cover best practices for managing and creating Docker registries and Helm repositories, testing and promotion of Docker containers, and taking your containers all the way to production using the JFrog Platform and Kubernetes together. While the use cases discussed will cover and utilize the entire JFrog Platform, the majority of the hands-on training will focus on JFrog Artifactory and CI tools working together.
### Who should attend: Developers, Development Managers, and DevOps Engineers who are currently using JFrog Artifactory and Docker, Current Docker users who are considering using JFrog Artifactory. A good understanding of Docker containers and CI servers for cloud-native pipelines is required. 

### Prerequisites: basic knowledge of working with Git (git client installed and GitHub account), curl installed on their laptop. Basic understanding of Docker and DevOps concepts.

#### Lab #1 - Onboarding to Labs Environment

- Login to your SaaS Enterprise+ environment and make sure you are able to connect with your credentials.
- Fork this ([https://github.com/jfrog/SwampUp2021](https://github.com/jfrog/SwampUp2021)) repository to your GitHub Account (Top right - Click on "Fork"):
![alt text](https://i.ibb.co/dr7btgf/Screen-Shot-2021-05-01-at-13-26-24.png)
- Run ```git clone https://github.com/<YOUR_GITHUB_USERNAME>/SwampUp2021.git``` against your forked repository.
- Run ```cd SwampUp2021/SU-114-From-Git-To-Kubernetes``` which is our class's folder with all the relevant code.
- Open the file "back/src/pipelines.resources" and change the configuration.path in the following snippet:
```
  - name: source_code
    type: GitRepo
    configuration:
      gitProvider: github
      path: <CHANGE_THIS_TO_YOUR_GITHUB_USERNAME>/SwampUp2021
```
- Commit the changes to your forked repository:
 ```
git commit -m "updated my repo path in the source code resource"
git add .
git push
```
- Create the following Integrations (Administration Panel -> Pipelines -> Integrations -> Add an Integration):
    - "github" integration (type: "GitHub") with [personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) from your github account:</br>
    ![alt text](https://i.ibb.co/qkGd65z/Screen-Shot-2021-05-01-at-13-55-15.png) </br>
    - "artifactory" integration (type: "Artifactory"):</br>
    ![alt text](https://i.ibb.co/5nDV957/Screen-Shot-2021-05-01-at-13-54-51.png) </br>
    - "docker integration" (type: "Docker"):</br>
    ![alt text](https://i.ibb.co/TqdyPSC/Screen-Shot-2021-05-01-at-13-55-05.png) </br>
    - "generic integration" (type: "Generic"), where the value equals to your SaaS server name (for example, for swampup203.jfrog.io the server name is swampup203): </br>
    ![alt text](https://i.ibb.co/CzmrF3n/Screen-Shot-2021-05-01-at-13-55-26.png) </br>
- Create a Pipeline Source based on the forked repository, with the following Pipeline Config File Filter: ```SU-114-From-Git-To-Kubernetes/(.*)pipelines(.*).yaml``` and branch ```main```:</br>
![alt text](https://i.ibb.co/BrMcgw7/Screen-Shot-2021-05-01-at-13-55-40.png)</br>

- Make sure all pipelines were loaded under "My Pipelines".

- Run the "suv_114_on_boarding_environment" to populate all repositories for our demo.</br>
![alt text](https://i.ibb.co/vVrLwtP/Screen-Shot-2021-05-01-at-14-13-10.png)</br>
<b>* For any issues, please assist the instructor and T.A's!</b>

#### Lab #1 - Understanding the Environment

- Run all Pipelines.
- Understand the connection between all Pipelines based on the list view.

#### Lab #2 - Adding Security

- Index all builds.
- Configure Watch & Policy.
- Understand Xray results.
