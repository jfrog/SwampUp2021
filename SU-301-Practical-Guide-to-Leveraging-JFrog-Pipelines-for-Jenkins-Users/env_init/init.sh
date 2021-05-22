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

echo "$ADMIN_USER:$ADMIN_PASS"

# create repo
echo "[ARTIFACTORY] creating repositories on Artifactory..."
curl \
     -XPATCH \
     -u $ADMIN_USER:$ADMIN_PASS \
     -H "Content-Type: application/yaml" -T artifactory_repo.yaml \
$JPD_URL/artifactory/api/system/configuration 

# curl \
#      -u $ADMIN_USER:$ADMIN_PASS \
#      -H "Content-Type: application/json" \
# $JPD_URL/api/v1/binMgr/default/builds

# index build
# echo "{\"names\":[\"`echo $BUILD_NAMES | sed 's/,/","/g'`\"]}"
# echo -e "\n[XRAY] indexing builds ... "
# curl \
#      -XPOST \
#      -u $ADMIN_USER:$ADMIN_PASS \
#      -H "Content-Type: application/json" \
#      -d "@test.json" \
# $JPD_URL/xray/api/v1/binMgr/builds

#     -d "{\"names\":[\"`echo $BUILD_NAMES | sed 's/,/","/g'`\"]}" \


# # create policy
# echo -e "\n[XRAY] creating policy  ... !"
# curl \
#      -XPOST \
#      -u $ADMIN_USER:$ADMIN_PASS \
#      -H "Content-Type: application/json" \
#      -d @xray_policy.json \
# $JPD_URL/xray/api/v2/policies


# # create watch
# echo -e "\n[XRAY] creating watch  ... !"
# curl \
#      -XPOST \
#      -u $ADMIN_USER:$ADMIN_PASS \
#      -H "Content-Type: application/json" \
#      -d @xray_watch.json \
# $JPD_URL/xray/api/v2/watches
