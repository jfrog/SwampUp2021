# SU-302  Advanced JFrog Artifactory Security practices
<p align="center">
  <img src="https://i.ibb.co/SKMtcs8/Screen-Shot-2021-05-20-at-10-49-17-PM.png" />
</p>

### In this training session, you’ll learn about the levels of security built into Artifactory and how to leverage them for your setup, as well as extend them with user plugins to provide a custom ACL and permission model. We will get hands-on experience with access tokens, establishing the circle of trust on federated instances and clusters, etc.


#### <ins>Who should attend:</ins> Developers, DevOps Engineers and Development Managers who are looking to get hands-on experience with securing Artifactory and securely integrating JFrog Artifactory into their pipeline.

#### <ins>Prerequisites</ins>: Knowledgeable with Git and Docker (git and docker clients installed including having a GitHub account). Basic understanding of DevOps concepts (familiarity with JFrog Artifactory).

#### <ins>Lab #1 - Onboarding to Labs Environment</ins>

- Login to your SaaS Enterprise environment and make sure you are able to connect with your credentials.
- Fork this ([https://github.com/jfrog/SwampUp2021](https://github.com/jfrog/SwampUp2021)) repository to your GitHub Account (Top right - Click on "Fork"):
![alt text](https://i.ibb.co/dr7btgf/Screen-Shot-2021-05-01-at-13-26-24.png)
- Run ```git clone https://github.com/<YOUR_GITHUB_USERNAME>/SwampUp2021.git``` against your forked repository.
- Run ```cd SwampUp2021/SU-302-Advanced-Artifactory-Security``` which is our class's folder with all the relevant code.
- Open the file "back/src/pipelines.resources" and change the configuration.path in the following snippet based on your github username:</br>
![alt text](https://i.ibb.co/wyrLVNK/Screen-Shot-2021-05-01-at-14-28-11.png)</br>
- Commit the changes to your forked repository:
 ```
git add .
git commit -m "updated my repo path in the source code resource"
git push
```
- Create the following Integrations (Administration Panel -> Pipelines -> Integrations -> Add an Integration):
    - "github" integration (type: "GitHub") with [personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) from your github account:</br>
    ![alt text](https://i.ibb.co/qkGd65z/Screen-Shot-2021-05-01-at-13-55-15.png)
    - "artifactory" integration (type: "Artifactory"):</br>
    ![alt text](https://i.ibb.co/5nDV957/Screen-Shot-2021-05-01-at-13-54-51.png)
    - "docker integration" (type: "Docker"):</br>
    ![alt text](https://i.ibb.co/TqdyPSC/Screen-Shot-2021-05-01-at-13-55-05.png)
    - "generic integration" (type: "Generic"), where the value equals to your SaaS server name (for example, for swampup203.jfrog.io the server name is swampup203): </br>
    ![alt text](https://i.ibb.co/CzmrF3n/Screen-Shot-2021-05-01-at-13-55-26.png)
- Create a Pipeline Source based on the forked repository, with the following Pipeline Config File Filter: ```SU-302-Advanced-Artifactory-Security/(.*)pipelines(.*).yaml``` and branch ```main```:</br>
![alt text](https://i.ibb.co/BrMcgw7/Screen-Shot-2021-05-01-at-13-55-40.png)

- Make sure all pipelines were loaded under "My Pipelines": 
![alt text](https://i.ibb.co/DMtK5Ht/Screen-Shot-2021-05-20-at-11-57-26-PM.png)


- Run the "suv_302_on_boarding_environment" to populate all repositories for our demo.</br>
![alt text](https://i.ibb.co/pQZhgDQ/Screen-Shot-2021-05-20-at-11-58-20-PM.png)</br>


The following repositories should be created (Go to "Artifactory" -> "Artifacts"):
![alt text](https://i.ibb.co/268SV4p/Screen-Shot-2021-05-20-at-11-59-28-PM.png)</br>

<b>* For any issues, please assist the instructor and T.A's!</b>

#### <ins>Lab #2 - Understanding the Environment</ins>

Complete/answer the following tasks/questions:
- Run all pipelines until your environment is GREEN:
![alt text](http://g.recordit.co/xaZV0g6i21.gif)

- Understand the relationship between the different pipelines - in what ways a pipeline can be triggered?
- How many repositories were created for the backend application?
- How many repositories were created for the frontend application?

#### <ins>Lab #3 - Adding Security</ins>

- Index all builds from Xray's Administration Panel (Xray -> Settings -> Builds):
![alt text](http://g.recordit.co/6V3mjmz2bz.gif)
- View the security issues and license discovered by Xray for every individual build.
- Add one Security and one License Policies: [Creating a Policy](https://www.jfrog.com/confluence/display/JFROG/Creating+Xray+Policies+and+Rules#CreatingXrayPoliciesandRules-CreatingaPolicy).
- Add a watch per application (one watch for the backend; one watch for the frontend) and assign the policies you have created to these watches: [Configure Xray Watches](https://www.jfrog.com/confluence/display/JFROG/Configuring+Xray+Watches).
- Explore the violations that were NOW created.
