The environment can be provisionned with :
* a set of repositories
* a jenkins user and its permission
* 1 Xray policy and 1 Xray watch
* K8S and SSH integrations for JFrog Pipelines

Here is the procedure which was applied :

> To modify the Jenkins user and his permission, edit the json files in **env_init**
> To create the Pipelines integrations, update **integration_k8s.json** and **integration_sshkey.json** 

1. if you don't have Xray or JFrog Pipelines, comment the piece of code in the init.sh

2. Edit and export  the following environment variables according to your own setup
```
# FOR EXAMPLE
export JPD_URL=https://swampup301.jfrog.io \
    ADMIN_USER=yannc@jfrog.com \
    ADMIN_PASS=guestwhatitis

# ONLY FOR PIPELINES
export PIPE_TOKEN=fdsfdsfdsfsdfqsfdqfsfdsqf
```
> To generate an [Admin Token for JFrog pipelines](https://www.jfrog.com/confluence/display/JFROG/Access+Tokens#AccessTokens-GeneratingAdminTokens)

3. Execute init script
```
env_init/init.sh 
```