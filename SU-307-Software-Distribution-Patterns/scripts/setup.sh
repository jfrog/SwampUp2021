#!/usr/bin/env sh

#################
# init process #
#################
echo "Jfrog Main instance Name (paste provided instance name): "
read -r instancename 
export INSTANCE_NAME=${instancename}

echo "Jfrog Edge instance Name (paste provided edge instance name): "
read -r edgename
export EDGE_NAME=${edgename}

echo "Jfrog instance username : "
read -r username
export INSTANCE_USERNAME=${username}

echo "Jfrog instance password : "
read -r password
export PASSWORD=${password}

echo "Jfrog Main instance is accessible check : "
jfrog rt ping --url=http://$INSTANCE_NAME.jfrog.io/artifactory

echo "Jfrog Edge instance is accessible check : "
jfrog rt ping --url=http://$EDGE_NAME.jfrog.io/artifactory

jfrog config add $INSTANCE_NAME --artifactory-url https://$INSTANCE_NAME.jfrog.io/artifactory --user $INSTANCE_USERNAME --password $PASSWORD --interactive=false
jfrog config use $INSTANCE_NAME

echo "START : Create Maven local Repository in Main JFrog Artifactory"
jfrog rt repo-create ../Lab1/mvn-local.json
echo "COMPLETE : Create Maven local Repository in Main JFrog Artifactory"

echo "START : Upload Spring pet clinic jar to maven local"
jfrog rt upload ../Lab1/spring-petclinic-2.4.2.jar su307-maven-local
echo "COMPLETE : Upload Spring pet clinic jar to maven local"

jfrog config add $EDGE_NAME --artifactory-url https://$EDGE_NAME.jfrog.io/artifactory --user $INSTANCE_USERNAME --password $PASSWORD --interactive=false
jfrog config use $EDGE_NAME

echo -n "START : Create local Repository in JFrog Edge Artifactory"
jfrog rt repo-create ../Lab1/mvn-local.json
echo -n "COMPLETE : Create local Repository in JFrog Edge Artifactory"
