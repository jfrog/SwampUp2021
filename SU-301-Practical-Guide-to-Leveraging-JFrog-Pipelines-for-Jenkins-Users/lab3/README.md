# Lab 3

Choose your deployment pipeline : **K8S** or **VM**

## K8S

> the K8S integration has already been provisionned

1. In `lab3/cd/k8s/values.yml`, Update the git resource by using your own git repo :
```
K8sResources:
  gitRepoHelm:
    path: cyan21/SwampUp2021
```

### On JFrog Pipelines UI

2. Create an **IncomingWebhook** integration and name it **trigger_chart_deployment** + Choose **Authorization** for the Authorization type

3. Modify your pipeline source by editing the  **Pipeline Config File Filter** : `lab3\/cd\/k8s\/.*\.yml`

4. Update `K8sResources.incomingWebhook.integrationName` in `lab3/cd/k8s/values.yml` a:
```
K8sResources:
...
  incomingWebhook:
    integrationName: trigger_chart_deployment
```

Now, jump to the Jenkins section


## VM

> the SSH Keys integration has already been provisionned


### On JFrog Pipelines UI

1. Create an **IncomingWebhook** integration and name it **trigger_vm_deployment** + Choose **Authorization** for the Authorization type

2. Modify your pipeline source by editing the  **Pipeline Config File Filter** : `lab3\/cd\/k8s\/.*\.yml`


## On Jenkins

1. Create a new job based on either **lab3-java** or **lab3-python**

2. Select your newly created job and edit the following input parameters :
* MY_GIT_URL
* MY_GIT_BRANCH
* JPD_URL
* WEBHOOK_URL  : you'll get it from the Incoming Webhook Integration you created before
* WEBHOOK_PASS : you defined it when creating the Incoming Webhook Integration

You can optionnaly modify the other input parameters if you want

3. Run your pipeline. No tricks this time ;)

