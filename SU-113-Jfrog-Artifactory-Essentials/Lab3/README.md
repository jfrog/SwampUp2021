# Lab3 - Security & Permissions

## Prerequisites

A SaaS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

## Create a User and a Group

### Step1 - Create Groups

- Navigate to the Administration module and click on 'Identity and Access' -> 'Groups'.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/groups.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on the plus sign and create a new group - 'Developers'.
- Explore the different options and permissions a group can have.
- Create another group - 'SRE'.
- Save and navigate to 'Users'.

### Step2 - Create a User

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/users.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on the plus sign and create a new user - 'Developer1'.
- Explore the different options and permissions a user can have.
- Assign a the group 'Developers' and save.
- Create another user - 'ReleaseEngineer1' and add to the 'SRE' group.
- Navigate to 'Permissions'.

### Step3 - Create a Permission

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3/images/permissions.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on the plus sign and create a new permission with the ability to read and deploy from a 'dev' repository.
- Notice the different resources a permission can realte to.
- Assign the permission to your developers group.
- Create another permission for the 'SRE' group with the ability to deploy to the 'prod' repository.
- Save!
