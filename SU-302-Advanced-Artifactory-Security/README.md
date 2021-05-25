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
- Open the file "back/pipelines.resources" and change the configuration.path in the following snippet based on your github username:</br>
![alt text](https://i.ibb.co/wyrLVNK/Screen-Shot-2021-05-01-at-14-28-11.png)</br>
- Commit the changes to your forked repository:
 ```
git add .
git commit -m "updated my repo path in the source code resource"
git push
```
- Create the following Integrations (Administration Panel -> Pipelines -> Integrations -> Add an Integration): </br>
  NOTE: Name is CASE-SENSITIVE here </br>
    - "github" integration (type: "GitHub") with [personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) from your github account:</br>
    Scopes will need to include the following (repo, admin:repo_hook, delete_repo) </br>
    ![alt text](https://i.ibb.co/qkGd65z/Screen-Shot-2021-05-01-at-13-55-15.png)
    
    - "artifactory" integration (type: "Artifactory"):</br>
    ![alt text](https://i.ibb.co/5nDV957/Screen-Shot-2021-05-01-at-13-54-51.png)
    
    - "docker integration" (type: "Docker"):</br>
    ![alt text](https://i.ibb.co/TqdyPSC/Screen-Shot-2021-05-01-at-13-55-05.png)
    
    - "generic integration" (type: "Generic"), where the value equals to your SaaS server name (for example, for swampup203.jfrog.io the server name is swampup203): </br>
    ![alt text](https://i.ibb.co/CzmrF3n/Screen-Shot-2021-05-01-at-13-55-26.png)
    
- Create a Pipeline Source based on the forked repository (From YAML Option), with the following Pipeline Config File Filter: ```SU-302-Advanced-Artifactory-Security/(.*)pipelines(.*).yaml``` and branch ```main```:</br>
![alt text](https://i.ibb.co/BrMcgw7/Screen-Shot-2021-05-01-at-13-55-40.png)

- Make sure all pipelines were loaded under "My Pipelines": 
![alt text](https://i.ibb.co/DMtK5Ht/Screen-Shot-2021-05-20-at-11-57-26-PM.png)

- Setup a "Node Pool" (Node Pools -> Add Node Pool -> Save Node Pool)
![image](https://user-images.githubusercontent.com/8787649/119433736-d65e4600-bce4-11eb-8a94-63cd6f74268d.png)


- Run the "suv_302_on_boarding_environment" to populate all repositories for our demo.</br>
![alt text](https://i.ibb.co/pQZhgDQ/Screen-Shot-2021-05-20-at-11-58-20-PM.png)</br>


The following repositories should be created (Go to "Artifactory" -> "Artifacts"):
![alt text](https://i.ibb.co/268SV4p/Screen-Shot-2021-05-20-at-11-59-28-PM.png)</br>

<b>* For any issues, please assist the instructor and T.A's!</b>

#### <ins>Lab #2 - Start leverging project and protect your resources </ins>

- Create two users on artifactory (SuperFrog who work in RnD, and SpiderFrog who work in SRE team)
![image](https://user-images.githubusercontent.com/8787649/119436199-b7ae7e00-bce9-11eb-8ee5-994b1045ddb2.png)

- Time to create new projects. Let create one for RnD team first, and assign SuperFrog as project admins.
![image](https://user-images.githubusercontent.com/8787649/119436336-fb08ec80-bce9-11eb-924f-a91d2405a1b5.png)

- Assign all dev repositories to this project (RnD). 
![image](https://user-images.githubusercontent.com/8787649/119436404-196ee800-bcea-11eb-9476-509f9f0ddb37.png)

- Likewise, following the above steps to create a project for SRE team with all prod repositories assigned and add SpiderFrog as project admin.
![image](https://user-images.githubusercontent.com/8787649/119436618-7d91ac00-bcea-11eb-97df-f01906dd0564.png)

- Project admin can also go to identity and access tab to see who you want to add user into this project and assign specific role. For this specific lab, I have remove everyone under the member lists.
![image](https://user-images.githubusercontent.com/8787649/119437581-6f448f80-bcec-11eb-937a-bf4ffb069e2f.png)

- Now if you login as superfrog, you will only able to see your RnD project scope. 
![image](https://user-images.githubusercontent.com/8787649/119437695-ad41b380-bcec-11eb-96d6-b1b3daf53ac5.png)

Play around with SpiderFrog user as well! Let us know if there is any additional questions.
