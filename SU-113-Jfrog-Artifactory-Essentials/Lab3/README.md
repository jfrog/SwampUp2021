# Lab3 - Security & Permissions

## Prerequisites

A SaaS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

## Create a User and a Group

### Step1 - Create Groups

- Navigate to the Administration module and click on 'Identity and Access' -> 'Groups'.
  
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/groups.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on the plus sign and create a new group - 'Developers'.
- Explore the different options and permissions a group can have but don't check any box.  
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/developers_grp.png" alt="DevelopersGroup" style="height: 100px; width:100px;"/>
- Create another group - 'SRE'.
  
   <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/sre_grp.png" alt="SRE Group" style="height: 100px; width:100px;"/>
- Save and navigate to 'Users'.

### Step2 - Create a User
- Navigate to the Administration module and click on 'Identity and Access' -> 'Users'.  
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/users.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on the plus sign and create a new user - 'developer1'.'
- Email address and password are mandatory fields. Please fill the relevant information as shown in the UI.

  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/developer1.png" alt="Developer" style="height: 100px; width:100px;"/>
  
- Scroll down to related groups and Assign the group 'Developers' and save.
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/group-association.png" alt="Developer group association" style="height: 100px; width:100px;"/>
- Explore the different options and permissions a user can have.
- Follow the same process as above and Create another user - 'releaseengineer1' and add to the 'SRE' group. Once completed you should see the below 2 users under the user tab

  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/users-groups.png" alt="Developer group association" style="height: 100px; width:100px;"/>
- Navigate to 'Permissions'.

### Step3 - Create a Permission
- Navigate to the Administration module and click on 'Identity and Access' -> 'Permissions'.

  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/permissions.png" alt="Admin tab" style="height: 100px; width:100px;"/>
- Developer repository Permission
  - Click on the plus sign and create a new permission "docker-dev-permission" for the developers group to have read and deploy permissions to the "swampup-docker-dev-local" repository created in Lab2
  
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/docker-dev-permission.png" alt="Admin tab" style="height: 100px; width:100px;"/>  
  
  - Navigate to the Groups tab and add "developers" group
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/choose-developers.png" alt="Choose Developers tab" style="height: 100px; width:100px;"/>
  
  - Provide the appropriate permissions to the developers group. In our case, we have given Read,Annotate and Deploy/Cache permissions
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/group-permissions.png" alt="Choose Developers tab" style="height: 100px; width:100px;"/>
  - Add SRE group and provide only "Read" permission to the developer repository
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/sre-dev-permission.png" alt="Choose SRE tab" style="height: 100px; width:100px;"/>

- SRE repository Permission
  - Create another permission for the 'SRE' group with the ability to deploy to the 'prod' repository and save. In our case, we have given Read,Annotate ,Deploy/Cache, Delete/Overwrite permissions to our SRE team
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/prod-permission.png" alt="Choose SRE tab" style="height: 100px; width:100px;"/>
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/prod-association.png" alt="Choose SRE tab" style="height: 100px; width:100px;"/>
  - Add Developers group and provide only "Read" permission to the production repository
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/dev-prod-association.png" alt="Choose SRE tab" style="height: 100px; width:100px;"/>
  
- Once completed,  you should see the below 2 permissions under the Permissions tab
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/all-permissions.png" alt="Choose SRE tab" style="height: 100px; width:100px;"/>

### Awesome !!! You have now successfully secured your repositories. Only SRE team members have deploy/write access to your production repositories
