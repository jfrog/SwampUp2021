#!/bin/bash


#JPD_URL=https://swampup301.jfrog.io
BUILD_NAMES=backapp_mvn

if [ -z "$JPD_URL" ]
then
     echo "provide your JFrog Platform Deployment Unit (Artifactory) URL"
     exit 1
fi

if [ -z "$ADMIN_USER" ]
then
     echo "No user. Default : admin user"
     ADMIN_USER=admin
fi

if [ -z "$ADMIN_PASS" ]
then
     echo "provide your Artifactory Admin API KEY or password"
     exit 1
fi

if [ -z "$PIPE_TOKEN" ]
then
     echo "provide your Pipeline Token"
     exit 1
fi

if [ -z "$RT_USER" ]
then
     echo "provide a username to be created"
     exit 1
fi

#echo "$ADMIN_USER:$ADMIN_PASS"

echo "============================"
echo "$JPD_URL"
echo "============================"

# create repo
echo "[ARTIFACTORY] creating repositories ..."
curl \
     -XPATCH \
     -u $ADMIN_USER:$ADMIN_PASS \
     -H "Content-Type: application/yaml" -T artifactory_repo.yaml \
$JPD_URL/artifactory/api/system/configuration 

# create user
echo "[ARTIFACTORY] creating jenkins user ..."
curl \
     -XPUT \
     -u $ADMIN_USER:$ADMIN_PASS \
     -H "Content-Type: application/json" -T user.json \
$JPD_URL/artifactory/api/security/users/jenkins


# create user
echo "[ARTIFACTORY] creating user ..."
curl \
     -XPUT \
     -u $ADMIN_USER:$ADMIN_PASS \
     -H "Content-Type: application/json" -T user2.json \
$JPD_URL/artifactory/api/security/users/admin


# create permissions for jenkins user
echo "[ARTIFACTORY] creating permissions ..."
curl \
     -XPUT \
     -u $ADMIN_USER:$ADMIN_PASS \
     -H "Content-Type: application/json" -T permissions.json \
$JPD_URL/artifactory/api/v2/security/permissions/ci-urs


# create policy
echo -e "\n[XRAY] creating policy  ... !"
curl \
     -XPOST \
     -u $ADMIN_USER:$ADMIN_PASS \
     -H "Content-Type: application/json" \
     -d @xray_policy.json \
$JPD_URL/xray/api/v2/policies


# create watch
echo "[XRAY] creating watch  ... !"
curl \
     -XPOST \
     -u $ADMIN_USER:$ADMIN_PASS \
     -H "Content-Type: application/json" \
     -d @xray_watch.json \
$JPD_URL/xray/api/v2/watches

# create JFrog pipelines integrations
echo -e "\n[PIPE] creating K8S integration  ... !"
curl \
     -XPOST \
     -H "Authorization: Bearer $PIPE_TOKEN" \
     -H "Content-Type: application/json" \
     -d @integration_k8s.json \
$JPD_URL/pipelines/api/v1/projectIntegrations


#############################

# echo "[PIPE] creating SSH integration  ... !"
# curl \
#      -XPOST \
#      -H "Authorization: Bearer $PIPE_TOKEN" \
#      -H "Content-Type: application/json" \
#      -d @integration_sshkey.json \
# $JPD_URL/pipelines/api/v1/projectIntegrations

# curl \
#      -XPOST \
#      -H "Authorization: Bearer $PIPE_TOKEN" \
#      -H "Content-Type: application/json" \
#      -d @extension.json \
# $JPD_URL/pipelines/api/v1/extensionsources

# curl \
#      -H "Authorization: Bearer $PIPE_TOKEN" \
#      -H "Content-Type: application/json" \
# $JPD_URL/pipelines/api/v1/projectIntegrations

## index build
# echo "{\"names\":[\"`echo $BUILD_NAMES | sed 's/,/","/g'`\"]}"
# echo -e "\n[XRAY] indexing builds ... "
# curl \
#      -XPOST \
#      -u $ADMIN_USER:$ADMIN_PASS \
#      -H "Content-Type: application/json" \
#      -d "{\"names\":[\"`echo $BUILD_NAMES | sed 's/,/","/g'`\"]}" \
# $JPD_URL/xray/api/v1/binMgr/builds

# curl \
#      -u $ADMIN_USER:$ADMIN_PASS \
#      -H "Content-Type: application/json" \
# $JPD_URL/api/v1/binMgr/default/builds