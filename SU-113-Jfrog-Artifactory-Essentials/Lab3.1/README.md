# Lab3.1 - Projects

## Prerequisites

The 'Developer1' and 'ReleaseEngineer1' users from the previous lab.

## Create a Project and assign members

### Step1 - Create a Project

- Navigate to the Administration module and click on 'Projects'.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3.1/images/projects.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on the plus sign and create a new project with name: 'SwampUp', key: 'su'.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3.1/images/new_project.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Add 'ReleaseEngineer1' as the project's admin.
- Assign the docker repositories to the project.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3.1/images/project_repositories.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Set a storage quota and save.

### Step2 - Assign Roles & Members

- Make sure to choose your project at the project selector.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3.1/images/selector.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on 'Identity and Access' -> 'Roles'.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab3.1/images/roles.png" alt="Admin tab" style="height: 100px; width:100px;"/>

- Click on the plus sign and create a new role - 'Custom Developer'.
- Navigate to 'Members' and click on the plus sign to add 'Developer1'.
- Assign the proper role for it.

### Step3 - Inspect the Project

- Click on the project selector and select your project.
- Inspect your view and the resources assigned to the project.
