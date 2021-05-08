#!/usr/bin/env sh

#################
# init process #
#################
curl -fL https://getcli.jfrog.io | sh
echo -n "Configuration name for CLI (unique name) : "
read -r CLIName
export CLI_NAME=${CLIName}

echo -n "Jfrog instance Name (copy instancename from host - https://{{instancename}}.jfrog.io/): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo -n "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo -n "Jfrog API Key (Generate API Key from - Edit Profile > Authentication Settings > API Key) : "
read -r apikey
export APT_KEY=${apikey}

echo -n "Jfrog is accessible check : "
jfrog rt ping --url=http://$INSTANCE_NAME.jfrog.io/artifactory

echo -n
chmod +x jfrog
jfrog config add $CLI_NAME --artifactory-url https://$INSTANCE_NAME.jfrog.io/artifactory --user $INSTANCE_USERNAME --apikey $APT_KEY --interactive=false
jfrog config use $CLI_NAME

echo -n "START : Create local Repository in JFrog Artifactory"
jfrog rt repo-create ./json/npm-local.json
jfrog rt repo-create ./json/mvn-snapshot-local.json
jfrog rt repo-create ./json/mvn-release-local.json
echo -n "COMPLETE : Create local Repository in JFrog Artifactory"

echo -n "START: Create remote Repository in JFrog Artifactory"
jfrog rt repo-create ./json/npm-remote.json
jfrog rt repo-create ./json/mvn-remote.json
echo -n "COMPLETE : Create remote Repository in JFrog Artifactory"

echo -n "START: Create virtual Repository in JFrog Artifactory"
jfrog rt repo-create ./json/npm-virtual.json
jfrog rt repo-create ./json/mvn-snapshot-virtual.json
jfrog rt repo-create ./json/mvn-release-virtual.json
echo -n "COMPLETE : Create remote Repository in JFrog Artifactory"