# From Git to Kubernetes: Cloud Native DevOps (Advanced)
<p align="center">
  <img src="https://i.ibb.co/xq9xX6R/Screen-Shot-2021-05-01-at-14-22-19.png" />
</p>

### In this training session, you’ll learn best-practices when using the JFrog Platform to store and manage your Docker images and Kubernetes deployments from beginning to end, while also setting up a continuous build, test and deploy pipeline. We’ll cover best practices for managing and creating Docker registries and Helm repositories, testing and promotion of Docker containers, and taking your containers all the way to production using the JFrog Platform and Kubernetes together. While the use cases discussed will cover and utilize the entire JFrog Platform, the majority of the hands-on training will focus on JFrog Artifactory and CI tools working together.


#### <ins>Who should attend:</ins> Developers, Development Managers, and DevOps Engineers who are currently using JFrog Artifactory and Docker, Current Docker users who are considering using JFrog Artifactory. A good understanding of Docker containers and CI servers for cloud-native pipelines is required. 

#### <ins>Prerequisites</ins>: Knowledgeable with Git and Docker (git and docker clients installed including having a GitHub account). Basic understanding of DevOps concepts (familiarity with JFrog Artifactory).

### <ins>Lab #1 - Onboarding to Labs Environment</ins>

- Login to your SaaS Enterprise+ environment and make sure you are able to connect with your credentials.
- Fork this ([https://github.com/jfrog/SwampUp2021](https://github.com/jfrog/SwampUp2021)) repository to your GitHub Account (Top right - Click on "Fork"):
![alt text](https://i.ibb.co/dr7btgf/Screen-Shot-2021-05-01-at-13-26-24.png)
- Run ```git clone https://github.com/<YOUR_GITHUB_USERNAME>/SwampUp2021.git``` against your forked repository.
- Run ```cd SwampUp2021/SU-114-From-Git-To-Kubernetes``` which is our class's folder with all the relevant code.
- Open the file "back/pipelines.resources.yaml" and change the configuration.path in the following snippet based on your github username:</br>
![alt text](https://i.ibb.co/wyrLVNK/Screen-Shot-2021-05-01-at-14-28-11.png)</br>
- Commit the changes to your forked repository:
 ```
git add .
git commit -m "updated my repo path in the source code resource"
git push
```
- Create the following Integrations (Administration Panel -> Pipelines -> Integrations -> Add an Integration), while using your SaaS instance values:
    - "github" integration (type: "GitHub") with [personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) from your github account:</br>
    <img src="https://i.ibb.co/qkGd65z/Screen-Shot-2021-05-01-at-13-55-15.png" width="30%" height="30%"></br>
    - "artifactory" integration (type: "Artifactory"):</br>
    <img src="https://i.ibb.co/5nDV957/Screen-Shot-2021-05-01-at-13-54-51.png" width="40%" height="40%"></br>
    - "docker integration" (type: "Docker", used for accessing Artifactory as a Docker Registry):</br>
    <img src="https://i.ibb.co/TqdyPSC/Screen-Shot-2021-05-01-at-13-55-05.png" width="30%" height="30%"></br>
    - "generic integration" (type: "Generic"), where the value equals to your SaaS server name (for example, for swampup203.jfrog.io the server name is swampup203): </br>
    <img src="https://i.ibb.co/CzmrF3n/Screen-Shot-2021-05-01-at-13-55-26.png" width="50%" height="50%"></br>
- Create a Pipeline Source based on the forked repository, with the following Pipeline Config File Filter: ```SU-114-From-Git-To-Kubernetes/(.*)pipelines(.*).yaml``` and branch ```main```:</br>
<img src="https://i.ibb.co/BrMcgw7/Screen-Shot-2021-05-01-at-13-55-40.png" width="40%" height="40%"></br>
- Make sure all pipelines were loaded under "My Pipelines":</br> 
![alt text](https://i.ibb.co/mqMSDpd/Screen-Shot-2021-05-11-at-13-32-51.png)</br>
- Run the "suv_114_on_boarding_environment" to populate all repositories for our demo.</br>
<img src="https://i.ibb.co/vVrLwtP/Screen-Shot-2021-05-01-at-14-13-10.png" width="50%" height="50%"></br>
The following repositories should be created (Go to "Artifactory" -> "Artifacts"):</br>
<img src="https://i.ibb.co/qY4YK77/Screen-Shot-2021-05-16-at-19-48-58.png" width="25%" height="25%"></br>
<b>* For any issues, please request assistance from the instructor and T.A's!</b>

### <ins>Lab #2 - Understanding the Environment</ins>

Complete/answer the following tasks/questions:
- Run all pipelines until your environment is GREEN:</br>
<img src="https://i.ibb.co/bP4tRcY/Screen-Shot-2021-05-11-at-14-34-34.png" width="55%" height="55%"></br>
- Understand the relationship between the different pipelines - in what ways a pipeline can be triggered?
- How many repositories were created for the backend application?
- How many repositories were created for the frontend application?

### <ins>Lab #3 - Adding Security</ins>

- Index all builds from Xray's Administration Panel (Xray -> Settings -> Builds):</br>
<img src="https://i.ibb.co/T4cLCsp/Screen-Shot-2021-05-11-at-15-21-48.png" width="55%" height="55%"></br>
- View the security issues and license discovered by Xray for every individual build.
- Add one Security and one License Policies: [Creating a Policy](https://www.jfrog.com/confluence/display/JFROG/Creating+Xray+Policies+and+Rules#CreatingXrayPoliciesandRules-CreatingaPolicy).
- Add a watch per application (one watch for the backend; one watch for the frontend) and assign the policies you have created to these watches: [Configure Xray Watches](https://www.jfrog.com/confluence/display/JFROG/Configuring+Xray+Watches).
- Explore the violations that were NOW created.

### <ins>Extras - Do it yourself!</ins>

##### <ins>1 Bonus - Creating a Release Bundle & Distributing to Edge</ins></br>
- From Distribution UI, [Creating a Release Bundle](https://www.jfrog.com/confluence/display/JFROG/Distributing+Release+Bundles#DistributingReleaseBundles-CreatingaNewReleaseBundle) that contains:
    - The promoted docker images for the backend and front end applications.
    - The helm charts for both applications.
- Sign the release bundle.
- [Distribute the Release Bundle](https://www.jfrog.com/confluence/display/JFROG/Distributing+Release+Bundles#DistributingReleaseBundles-DistributingaReleaseBundle) to the edge.
- Login to your edge node, and view the release bundle that was just distributed.
- Download the release bundle from the edge.
- This application is now ready to be deployed to any k8s cluster of your choice :-)</br>
##### <ins>2 Bonus:</ins> [Index your Release Bundle with Xray](https://www.jfrog.com/confluence/display/JFROG/Distributing+Release+Bundles#DistributingReleaseBundles-XrayScanningofReleaseBundlesxraydata), and view the results under 'Xray' tab in Distribution.</br>
##### <ins>3 Bonus:</ins> Implement helm chart promotion: extend the pipelines with adding a quality gate after publishing the helm chart - what types of quality gate can you use?</br>
