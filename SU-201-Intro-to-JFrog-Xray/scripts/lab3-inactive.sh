#!/usr/bin/env sh
echo -n "Jfrog instance Name (copy instancename from host - https://{{instancename}}.jfrog.io/): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo -n "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo -n "GitHub Token"
read -r gittoken
export GIT_TOKEN=${gittoken}

echo -n "JFrog Access Token for pipeline (Administration > Identity and Access > Access Token) NOTE: Make sure to select Pipelines"
read -r accesstoken
export ACCESS_TOKEN=${accesstoken}

curl -X POST https://${instancename}.jfrog.io/pipelines/api/v1/projectIntegrations 
     -H "Content-Type: application/json" 
     -H 'Authorization: Bearer ${ACCESS_TOKEN}' 
     -d '{
         "name":"GitHub",
         "projectId":1,
         "masterIntegrationId":20,
         "masterIntegrationName":"github",
         "formJSONValues":[
             {
                "label":"token",
                "value":${GIT_TOKEN}
             },{
                "label":"url",
                "value":"https://api.github.com"}
         ],
         "permissions":{"pipelineSources":{"allowAllPipelineSources":true}}}'


