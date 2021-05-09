# Setup Jfrog Environment

Fork GitHub repository - https://github.com/jfrog/SwampUp2021 and clone your forked repository.

### Step 1 - Create Repositories in JFrog Artifactory

- Login to your saas instance <XXXXX>.jfrog.io with  your admin credentials
- Nevigate to Welcome, <user> from top right
- Click on dropdown and select **Quick Setup**
- Select Package Type **NPM** or **MAVEN** and click **Next**
- Enter repository name **su201** and click **Create**

![create_repos](https://user-images.githubusercontent.com/7561138/117177841-4f254e80-ad86-11eb-8184-20ffbe5c7af9.gif)

**NOTE: Please use the same name as above to be consistent throughout the class.** <br/> 

It will create local, remote and virtual repositories.<br/> 
e.g. <br/> 
**NPM** - su201-npm-local , su201-npm-remote, su201-npm <br/> 
**MAVEN** - su201-libs-release-local, su201-libs-snapshot-local, su201-maven-jcenter, su201-libs-release, su201-libs-snapshot<br/> 


### Step 2 - Configure Virtual Repository

- In the left sidebar, **Adminitration** > **Repositories** > **Repositories**
- Click on **Virtual** and select virtual repository that created as part of Step 1
- Scroll down and locate **Default Deployment Repository**
- From dropdown, select local repository that created in Step 1. (Artifacts create by CI will be store under this local repository)

![set_deployment_repo](https://user-images.githubusercontent.com/7561138/117177860-53516c00-ad86-11eb-905f-31128c8e164d.gif)

### Step 3 - Create a personal access token in GitHub

Please follow steps from https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token <br/>
NOTE: if you already have GitHub account then start from Step 2 else create GitHub account first and then follow above steps.

### Step 4 - Integrate GitHub with JFrog Pipeline

- In the left sidebar, click **Administration** > **Pipelines** > **Integration**
- Click **Add an Integration**
- Add integration Name "**GitHub**" (Please use **GitHub (Same name)** as it is used in yml file)
- Select **GitHub** from **Integration Type** dropdown
- Enter GitHub API Token in **Token** (Generated in Step 3)
- Click **Test Connection** 
- Click **Create**

![github_pipeline](https://user-images.githubusercontent.com/7561138/117182982-dd500380-ad8b-11eb-919d-9b051158bd1a.gif)


### Step 5 - Integrate Artifactory with JFrog Pipeline

- In the left sidebar, click **Administration** > **Pipelines** > **Integration**
- Click **Add an Integration**
- Add integration Name "**Artifactory**" (Please use **Artifactory (Same name)** as it is used in yml file)
- Select **Artifactory** from **Integration Type** dropdown
- **Artifactory URL** will be autofill with your SaaS instance (No need to change)
- **User** will be autofill with your SaaS instance user (No need to change)
- Click on **Get API Key** which will fill **API Key** 
- Click **Test Connection** 
- Click **Create**

![artifactory_pipeline](https://user-images.githubusercontent.com/7561138/117183054-f658b480-ad8b-11eb-9e9a-c07e3a415cbd.gif)


### Step 6 - Add Pipeline Source

- Navigate to **SwampUp2021/SU-201-Intro-to-JFrog-Xray/pipelines.yml** in your IDE 
- Change line 8, **path: jfrog/SwampUp2021** to **path: {{your_git_user}}/SwampUp2021** save and commit to your remote main
--- git add SU-201-Intro-to-JFrog-Xray/pipelines.yml
--- git commit -m "rename path value in pipeline.yml"
--- git push -u origin main
- In the left sidebar, click **Administration** > **Pipelines** > **Pipeline Sources**
- Click **Add Pipeline Source**
- Select **From YAML** 
- Select **GitHub** from drop down for "SCM Provider Integration" (based on Step 4 github integration name will appear here)
- Select **{{your_git_user}}/SwampUp2021** for "Repository Full Name"
- Select **main** for Branch 
- Keep **pipelines.yml** as it is for "Pipeline Config File Filter" 
- Click **Create Source**
- Latest Status will be **Syncying** and later it will change to **Success | Error**  
