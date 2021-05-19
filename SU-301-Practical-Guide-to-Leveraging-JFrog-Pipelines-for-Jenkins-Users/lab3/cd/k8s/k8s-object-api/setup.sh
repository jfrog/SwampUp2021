#!/bin/bash

ns="build-plane"
sa="yann-tooling"
email="yannc@jfrog.com"

backend_registry_name="uranus-registry"
backend_registry_url="su301.jfrog.io"
backend_registry_user="yannc@jfrog.com"
backend_registry_pass="%%%%%%%%%%%%"

# create namespace, service account, role, role binding
sed "s/MY_NAMESPACE/$ns/g" demo.yaml.tpl > demo.yaml
sed -i '' "s/MY_SVC_ACCOUNT/$sa/g" demo.yaml

sudo kubectl apply -f demo.yaml 

sudo kubectl create secret docker-registry $backend_registry_name \
    --docker-server=$backend_registry_url \
    --docker-username=$backend_registry_user --docker-password=$backend_registry_pass --docker-email=$email -n $ns


# generate kubeconfig (for JFrog Pipelines)
####################
path="."
which yq >/dev/null

if [ $? -ne 0 ]; then
    echo "[INFO] installing yq in the current path"
    curl -LO https://github.com/mikefarah/yq/releases/download/v4.4.0/yq_linux_amd64
    chmod u+x yq_linux_amd64 && sudo mv yq_linux_amd64 yq 
    $path/yq --version
else 
    echo "[INFO] yq already installed"
    yq_path=`which yq`
    path=${yq_path%/*}
fi

# get kubeconfig  
kubectl config view --flatten --minify > myKubeConfig

# get token from secret
token=`sudo kubectl describe secrets $sa -n $ns | grep "^token" | tr -d "[[:space:]]" | cut -d: -f2`

# add authentication by token 
$path/yq -i e ".users[0].user.token = \"$token\"" myKubeConfig 

# remove authentication via gcp 
$path/yq -i e "del(.users[0].user.auth-provider)" myKubeConfig