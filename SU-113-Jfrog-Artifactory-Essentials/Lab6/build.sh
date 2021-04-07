#!/usr/bin/env bash

curl -fL https://getcli.jfrog.io | sh
echo -n "Configuration name for CLI : "
read -r
CLIName=$REPLY

echo -n "Jfrog instance Name : "
read -r
instancename=$REPLY

echo -n "Jfrog instance username : "
read -r
username=$REPLY

echo -n "Jfrog instance password : "
read -r
password=$REPLY

echo -n "Docker registry name : "
read -r
dockerregistryname=$REPLY

chmod +x jfrog
./jfrog config add $CLIName --artifactory-url https://$instancename.jfrog.io/artifactory --user $username --password $password --interactive=false
./jfrog config use $CLIName

echo -n "Build name : "
read -r
buildname=$REPLY

echo -n "Build number : "
read -r
buildnumber=$REPLY

echo -n "Docker Image name: "
read -r
dockerimagename=$REPLY

docker build --tag $instancename.jfrog.io/$dockerregistryname/$dockerimagename:$buildnumber .

./jfrog rt docker-push $instancename.jfrog.io/$dockerregistryname/$dockerimagename:$buildnumber $dockerregistryname --build-name=$buildname --build-number=$buildnumber

./jfrog rt build-add-git $buildname $buildnumber
./jfrog rt build-collect-env $buildname $buildnumber
./jfrog rt build-publish $buildname $buildnumber