echo "Enter jfrog server name"

read -p 'Server Name (example:https://swampupsu112.jfrog.io): ' servername
servername=$(echo $servername | sed 's:/*$::')
echo $servername

echo "Enter admin credentials"
read -p 'Username: ' user
read -sp 'Password: ' password

echo "Creating repos"

jfrog rt repo-create acme-docker-dev-local.json
jfrog rt repo-create acme-helm-dev-local.json

jfrog rt repo-create acme-docker-remote.json
jfrog rt repo-create acme-helm-remote.json

jfrog rt repo-create acme-docker-virtual.json
jfrog rt repo-create acme-helm-virtual.json

echo "Creating policies and watches"

curl -u$user:$password -XPUT -H "Content-Type: application/json" --data @index_resources.json $servername/xray/api/v1/binMgr/default/repos -w "\n"

curl -u$user:$password -XPOST -H "Content-Type: application/json" --data @policy.json $servername/xray/api/v2/policies -w "\n"

curl -u$user:$password -XPOST -H "Content-Type: application/json" --data @watches.json $servername/xray/api/v2/watches -w "\n"

echo "Creating user and permission targets"

curl -u$user:$password -XPUT -H "Content-Type: application/json" --data @users.json $servername/artifactory/api/security/users/testuser

jfrog rt ptc permission-targets.json
