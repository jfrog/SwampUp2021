# Lab 3

Choose your deployment pipeline : **K8S** or **VM**

## K8S

> the K8S integration has already been provisionned

1. Create a branch called **k8s**
```
# on your java or python branch, run on of the following command
git checkout -b k8s

# push the branch
git push -u origin k8s
```

2. In `lab3/cd/k8s/values.yml`, Update the following fields :
```
K8sResources:
  gitRepoHelm:
    path: cyan21/SwampUp2021
  ...
  releaseName: my-web-app
```

### On JFrog Pipelines UI

3. Create an **IncomingWebhook** integration and name it **trigger_chart_deployment** + Choose **Authorization** for the Authorization type

4. Add a new pipeline source
* Single Branch
* From Yaml 
* Pipeline Config File Filter : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users/lab3/cd/k8s/.*\.yml`

5. Run the pipeline called **lab3_k8s_create_helm_chart** to generate the helm chart

Now, jump to the Jenkins section


## VM

> the SSH Keys integration has already been provisionned


1. Create a branch called **vm**
```
# on your java or python branch, run on of the following command
git checkout -b vm

# push the branch
git push -u origin vm
```

### On JFrog Pipelines UI

1. Create an **IncomingWebhook** integration and name it **trigger_vm_deployment** + Choose **Authorization** for the Authorization type

2. Add a new pipeline source
* Single Branch
* From Yaml 
* Pipeline Config File Filter : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users/lab3/cd/vm/.*\.yml`

3. Fork this github repository `https://github.com/cyan21/JFrogPipeExtensions`

### To load a JFrog Extension

4. Create a github integration with your github token (same as for lab1) and choose a different name and  pick **Admin** for the usage

5. Go to `Application tab > Extensions`and select `Extension Sources` tab, specify your github integration + Git repo + branch


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

