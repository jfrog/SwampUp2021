# Pre requisites

1. Fork this github repository
2. Generate a [Github personnal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) with the following [permissions](https://www.jfrog.com/confluence/display/JFROG/GitHub+Integration)
3. `git clone` the forked repo on your workstation
4. Edit and export  the following environment variables according to your own setup
```
# FOR EXAMPLE
export JPD_URL=https://swampup301.jfrog.io 
export ADMIN_USER=yannc@jfrog.com 
export ADMIN_PASS=guestwhatitis 
```
5. Execute init script to generate the Artifactory repositories 
```
env_init/init.sh 
```

# Lab 1

In `lab1/{java,python}/pipelines.resources.yml`, Update the git resource by using your own git repo :
```
      path: cyan21/su301
```

Create the following Pipelines integrations :
* Github and name it `my_github`
* Artifactory and name it `artifactory_eu`

Load the pipeline source of your choice :
* java : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab1\/java\/pipelines.*\.yml`
* python : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab1\/python\/pipelines.*\.yml`

Run the pipeline ... and fix it :P

The pipeline will be triggered on each commit and more !

Extra : 
* Have a look to the pipeline you didn't choose


# Lab 2

In `lab2/{java,python}/pipelines.resources.yml`, Update the git resource by using your own git repo :
```
      path: cyan21/su301
```

Modify your pipeline source accordingly :
* java : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab2\/java\/pipelines.*\.yml`
* python : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab2\/python\/pipelines.*\.yml`

Run the pipeline and fix it :P

> Hint for troubleshooting : you may need another integration ...

> Note : We could have merged the 2 pipelines by using a Multi stage docker file. However you would have missed the basics of JFrog pipelines :)

Extra : 
* Have a look to the pipeline you didn't choose 

# Lab 3

Choose your deployment pipeline : **K8S** or **VM**

Update the input parameters with your environment info

Create Jenkins user in Artifactory

## K8S

> the K8S integration is already provisioned

In `lab3/cd/k8s/values.yml`, Update the git resource by using your own git repo :
```
      path: cyan21/su301
```

Create the following Pipelines integrations :
* IncomingWebhook and name it as you wish 

Modify your pipeline source accordingly : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab3\/cd\/k8s\/.*\.yml`

Edit the `lab3/cd/k8s/values.yml`  with your own integration name

Extra : 
* Run the other pipeline :) 

## VM

> the SSH key integration is already provisioned
> For the target VM, keep the one in the example

Create the following Pipelines integrations :
* IncomingWebhook and name it as you wish 

Modify your pipeline source accordingly : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab3\/cd\/vm\/pipelines.*\.yml`

Edit the `lab3/cd/vm/*.yml`  with your own integration names

Extra : 
* Run the other pipeline :) 