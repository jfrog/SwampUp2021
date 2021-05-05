# Setup Jfrog Environment

### Step 1 - Create Repositories in JFrog Artifactory

- Login to your saas instance <XXXXX>.jfrog.io with  your admin credentials
- Nevigate to Welcome, <user> from top right
- Click on dropdown and select **Quick Setup**
- Select Package Type **NPM** or **MAVEN** and click **Next**
- Enter repository name **su201** and click **Create**

https://user-images.githubusercontent.com/7561138/117176035-50557c00-ad84-11eb-95f5-3130b4d3c1fd.mp4


It will create local, remote and virtual repositories.<br/> e.g. <br/> NPM - su201-npm-local , su201-npm-remote, su201-npm <br/> MAVEN - su201-libs-release-local, su201-libs-snapshot-local, su201-maven-jcenter, su201-libs-release, su201-libs-snapshot

### Step 2 - Configure Virtual Repository

- Go to **Adminitration** > **Repositories** > **Repositories**
- Click on **Virtual** and select virtual repository that created as part of Step 1
- Scroll down and locate **Default Deployment Repository**
- From dropdown, select local repository that created in Step 1. (Artifacts create by CI will be store under this local repository)


https://user-images.githubusercontent.com/7561138/117176084-5b101100-ad84-11eb-9785-503a7df8bcb8.mp4





