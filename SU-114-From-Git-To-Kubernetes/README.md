# From Git to Kubernetes: Cloud Native DevOps (Advanced)

###### In this training session, you’ll learn best-practices when using the JFrog Platform to store and manage your Docker images and Kubernetes deployments from beginning to end, while also setting up a continuous build, test and deploy pipeline. We’ll cover best practices for managing and creating Docker registries and Helm repositories, testing and promotion of Docker containers, and taking your containers all the way to production using the JFrog Platform and Kubernetes together. While the use cases discussed will cover and utilize the entire JFrog Platform, the majority of the hands-on training will focus on JFrog Artifactory and CI tools working together.
###### <b>Who should attend:</b> Developers, Development Managers, and DevOps Engineers who are currently using JFrog Artifactory and Docker, Current Docker users who are considering using JFrog Artifactory. A good understanding of Docker containers and CI servers for cloud-native pipelines is required. 

###### Prerequisites: 

#### Lab #1 - On Boarding to Labs Environment

- Login to your SaaS E+ Environment, make sure you are able to connect.
- Fork this (https://github.com/jfrog/SwampUp2021) repository to your GitHub Account.
- Clone the forked repository to your local environment.
- cd into SU-114-From-Git-To-Kubernetes.
- Insert the relevant variables in the source code.
- Commit the changes to your forked repository.
- Create 3 integrations:
    - "github" integration with personal access token from your github account.
    - "artifactory integration".
    - "docker integration".
- Create a Pipeline Source based on the forked repository, with the following Pipeline Config Filter: "SU-114-From-Git-To-Kubernetes/(.*)pipelines(.*).yaml".
- Make sure all pipelines were loaded under "My Pipelines".

* For any issues, please assist the instructor and T.A's!

#### Lab #1 - Understanding the Environment

- Run all Pipelines.
- Understand the connection between all Pipelines based on the list view.

#### Lab #2 - Adding Security

- Index all builds.
- Configure Watch & Policy.
- Understand Xray results.
