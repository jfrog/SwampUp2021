#!/usr/bin/env sh
echo "Jfrog instance Name (copy instancename from host - https://{{instancename}}.jfrog.io/): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo "Jfrog API Key (Generate API Key from - Edit Profile > Authentication Settings > API Key) : "
read -r apikey
export APT_KEY=${apikey}

echo "START : Create Watches"
curl -u ${username}:${apikey} -X POST https://${instancename}.jfrog.io/xray/api/v2/watches -H "Content-Type: application/json" -d @json/lab2-watch-general.json
curl -u ${username}:${apikey} -X POST https://${instancename}.jfrog.io/xray/api/v2/watches -H "Content-Type: application/json" -d @json/lab2-watch-critical.json
echo "COMPLETE : Create Watches"