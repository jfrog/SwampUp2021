run the ```setup.sh``` to : 
* init the env to deploy the Helm Chart
* generate a kubeconfig to be used in a Integration in JFrog Pipelines

# Deploying the Helm Chart

* create namespace
* create service account
* create secrets to use Artifactory as a private container registry (there are referenced in the helm chart)
* create role and rolebinding


# JFrog Pipelines configuration

You have to craft a kubeconfig which user token is a service account's secret