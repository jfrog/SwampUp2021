#!/usr/bin/env sh

#################
# build process #
#################
echo "INFO - Collect indexing configuration"
INDEXED_REPOS=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                  -H 'Content-Type: application/json' \
                  -X GET "${XRAY_URL}/api/v1/binMgr/default/repos" \
                  | jq -r ".indexed_repos + [{\"name\": \"$DOCKER_REPO_PROD-local\",\"type\": \"local\",\"pkg_type\": \"Docker\"}] + [{\"name\": \"$GRADLE_REPO_PROD-local\",\"type\": \"local\",\"pkg_type\": \"Gradle\"}]")

echo "INFO - Updating indexing configuration"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X PUT "${XRAY_URL}/api/v1/binMgr/default/repos" \
    -d \
    "{
        \"indexed_repos\": ${INDEXED_REPOS}
    }"

echo "INFO - Create policy"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X POST "${XRAY_URL}/api/v2/policies" \
    -d \
    "{
        \"name\": \"block-download-on-high-severity\",
        \"description\": \"Block download on high severity issue\",
        \"type\": \"security\",
        \"rules\": [
            {
                \"name\": \"block-download-on-high-severity-rule\",
                \"criteria\": {
                    \"min_severity\": \"high\"
                },
                \"actions\": {
                    \"block_download\": {
                        \"active\": true,
                        \"unscanned\": true
                    }
                },
                \"priority\": 1
            }
        ]
    }"

echo "INFO - Create watch"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${XRAY_URL}/api/v2/watches" \
     -d \
     "{
        \"general_data\": {
            \"name\": \"devsecops-docker-repo-watch\",
            \"description\": \"Docker production repos\",
            \"active\": true
        },
        \"project_resources\": {
            \"resources\": [{
                \"type\": \"repository\",
                \"bin_mgr_id\": \"default\",
                \"name\": \"$DOCKER_REPO_PROD-local\"
            }]
        },
        \"assigned_policies\": [{
            \"name\": \"block-download-on-high-severity\",
            \"type\": \"security\"
        }]
    }"

echo "INFO - scan artifact"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${XRAY_URL}/api/v1/scanArtifact" \
     -d "{\"componentID\": \"docker://${IMAGE_NAME}:${PROJECT_VERSION_LAB1}\"}"

echo "INFO - Remove local docker image"
docker rmi "${IMAGE_ABSOLUTE_NAME_DEV_LAB1}" 2>/dev/null
docker rmi "${IMAGE_ABSOLUTE_NAME_PROD_LAB1}" 2>/dev/null

echo "INFO - Try to pull docker image"
docker pull "${IMAGE_ABSOLUTE_NAME_PROD_LAB1}"