#!/usr/bin/env sh
echo -n "Jfrog instance Name (copy instancename from host - https://{{instancename}}.jfrog.io/): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo -n "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo -n "Jfrog API Key (Generate API Key from - Edit Profile > Authentication Settings > API Key) : "
read -r apikey
export APT_KEY=${apikey}

echo -n "START : Index Repositories for Xray : "
curl -u ${username}:${apikey} -X PUT https://${instancename}.jfrog.io/xray/api/v1/binMgr/1/repos -H "Content-Type: application/json" -d @json/lab1-index-repos.json
echo -n "COMPLETE : Index Repositories for Xray"

echo -n "START : Index Builds for Xray : "
curl -u ${username}:${apikey} -X PUT https://${instancename}.jfrog.io/xray/api/v1/binMgr/1/builds -H "Content-Type: application/json" -d @json/lab1-index-builds.json
echo -n "COMPLETE : Index Builds for Xray"

echo -n "START : Create Security Policies with rules"
curl -u ${username}:${apikey} -X POST https://${instancename}.jfrog.io/xray/api/v2/policies -H "Content-Type: application/json" -d @json/lab1-sec-policy.json
curl -u ${username}:${apikey} -X POST https://${instancename}.jfrog.io/xray/api/v2/policies -H "Content-Type: application/json" -d @json/lab1-sec-critical-policy.json
echo -n "COMPLETE : Create Security Policies with rules"

echo -n "START : Create License Policies with rules"
curl -u ${username}:${apikey} -X POST https://${instancename}.jfrog.io/xray/api/v2/policies -H "Content-Type: application/json" -d @json/lab1-lic-policy.json
echo -n "COMPLETE : Create License Policies with rules"