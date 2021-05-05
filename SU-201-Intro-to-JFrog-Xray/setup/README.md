# Setup Jfrog Environment

### Step 1 - Create Repositories in JFrog Artifactory

- Login to your saas instance <XXXXX>.jfrog.io with  your admin credentials
- Nevigate to Welcome, <user> from top right
- Click on dropdown and select **Quick Setup**
- Select Package Type **NPM** or **MAVEN** and click **Next**
- Enter repository name **su201** and click **Create**


It will create local, remote and virtual repositories. 
e.g. 
NPM - su201-npm-local , su201-npm-remote, su201-npm
MAVEN - su201-libs-release-local, su201-libs-snapshot-local, su201-maven-jcenter, su201-libs-release, su201-libs-snapshot

### Step 2 - Configure Virtual Repository

- In the left sidebar, **Adminitration** > **Repositories** > **Repositories**
- Click on **Virtual** and select virtual repository that created as part of Step 1
- Scroll down and locate **Default Deployment Repository**
- From dropdown, select local repository that created in Step 1. (Artifacts create by CI will be store under this local repository)



### Step 3 - Create a personal access token in GitHub

- Login to your Github account
- In the upper-right corner of any page, click your profile photo, then click Settings.
- In the left sidebar, click Developer settings.
- In the left sidebar, click Personal access tokens.
- Click Generate new token.
- Give your token a descriptive name.
- Select the scopes, or permissions, you'd like to grant this token. To use your token to access repositories from the command line, select repo.
- Click Generate token.
- Click to copy the token to your clipboard. For security reasons, after you navigate off the page, you will not be able to see the token again.

### Step 4 - Integrate GitHub with JFrog Pipeline

- In the left sidebar, click **Administration** > **Pipelines** > **Integration**
- Click **Add an Integration**
- Add integration Name **GitHub** (**Same name** will be use in yml file)
- Select **GitHub** from **Integration Type** dropdown
- Enter GitHub API Token in **Token** (Generated in Step 3)
- Click **Test Connection** 
- Click **Create**

### Step 5 - Integrate Artifactory with JFrog Pipeline

- In the left sidebar, click **Administration** > **Pipelines** > **Integration**
- Click **Add an Integration**
- Add integration Name **Artifactory** (**Same name** will be use in yml file)
- Select **Artifactory** from **Integration Type** dropdown
- **Artifactory URL** will be autofill with your SaaS instance (No need to change)
- **User** will be autofill with your SaaS instance user (No need to change)
- Click on **Get API Key** which will fill **API Key** 
- Click **Test Connection** 
- Click **Create**