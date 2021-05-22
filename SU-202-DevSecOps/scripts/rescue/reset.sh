#!/usr/bin/env sh

#################
# reset process #
#################
echo "INFO - deleting repos"
jfrog rt repo-delete "${DOCKER_REPO_DEV}"-local --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${DOCKER_REPO_PROD}"-local --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${DOCKER_REPO_REMOTE}" --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${DOCKER_REPO_DEV}" --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${DOCKER_REPO_PROD}" --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${GRADLE_REPO_DEV}"-local --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${GRADLE_REPO_PROD}"-local --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${GRADLE_REPO_REMOTE}" --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${GRADLE_REPO_DEV}" --quiet --server-id="${CLI_INSTANCE_ID}"
jfrog rt repo-delete "${GRADLE_REPO_PROD}" --quiet --server-id="${CLI_INSTANCE_ID}"

echo "INFO - deleting builds"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${ARTIFACTORY_URL}/api/build/delete" \
     -d "{\"buildName\":\"${CLI_GRADLE_BUILD_NAME}\",\"deleteAll\":\"true\"}"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X POST "${ARTIFACTORY_URL}/api/build/delete" \
     -d "{\"buildName\":\"${CLI_DOCKER_BUILD_NAME}\",\"deleteAll\":\"true\"}"

echo "INFO - deleting watches"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -X DELETE "${XRAY_URL}/api/v2/watches/devsecops-docker-repo-watch"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -X DELETE "${XRAY_URL}/api/v2/watches/devsecops-docker-build-watch"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -X DELETE "${XRAY_URL}/api/v2/watches/devsecops-legacy-watch"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -X DELETE "${XRAY_URL}/api/v2/watches/devsecops-sample-watch"

echo "INFO - deleting policies"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X DELETE "${XRAY_URL}/api/v2/policies/block-download-on-high-severity"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X DELETE "${XRAY_URL}/api/v2/policies/fail-build-on-high-severity"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X DELETE "${XRAY_URL}/api/v2/policies/raise-violation-on-gpl"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X DELETE "${XRAY_URL}/api/v2/policies/raise-violation-on-medium-severity"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
     -H 'Content-Type: application/json' \
     -X DELETE "${XRAY_URL}/api/v2/policies/devsecops-sample-policy"

echo "INFO - Collect indexing configuration"
INDEXED_REPOS=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                  -H 'Content-Type: application/json' \
                  -X GET "${XRAY_URL}/api/v1/binMgr/default/repos" \
                  | jq 'del(.indexed_repos[] | select(.name == "devsecops-docker-prod-local" or .name == "devsecops-gradle-prod-local"))' \
                  | jq -r '.indexed_repos')

INDEXED_BUILDS=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                  -H 'Content-Type: application/json' \
                  -X GET "${XRAY_URL}/api/v1/binMgr/default/builds" \
                  | jq 'del(.indexed_builds[] | select(. == "devsecops-gradle" or . == "devsecops-docker"))' \
                  | jq -r '.indexed_builds')

echo "INFO - resetting indexing configuration"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X PUT "${XRAY_URL}/api/v1/binMgr/default/repos" \
    -d \
    "{
        \"indexed_repos\": ${INDEXED_REPOS}
    }"

curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X PUT "${XRAY_URL}/api/v1/binMgr/default/builds" \
    -d \
    "{
        \"indexed_builds\": ${INDEXED_BUILDS}
    }"

echo "INFO - removing reports"
REPORT_ID_LICENSE=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                      -H 'Content-Type: application/json' \
                      -X POST "${XRAY_URL}/api/v1/reports?page_num=1&num_of_rows=1" \
                      -d "{\"filters\": {\"name\":\"devsecops-prod-swampup-licenses\"}}" \
                    | jq -r '.reports[0].id')
REPORT_ID_FIX=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                      -H 'Content-Type: application/json' \
                      -X POST "${XRAY_URL}/api/v1/reports?page_num=1&num_of_rows=1" \
                      -d "{\"filters\": {\"name\":\"devsecops-prod-swampup-high-with-fix\"}}" \
                    | jq -r '.reports[0].id')
REPORT_ID_HIGH=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                      -H 'Content-Type: application/json' \
                      -X POST "${XRAY_URL}/api/v1/reports?page_num=1&num_of_rows=1" \
                      -d "{\"filters\": {\"name\":\"devsecops-prod-swampup-high\"}}" \
                    | jq -r '.reports[0].id')
REPORT_ID=$(curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
                      -H 'Content-Type: application/json' \
                      -X POST "${XRAY_URL}/api/v1/reports?page_num=1&num_of_rows=1" \
                      -d "{\"filters\": {\"name\":\"devsecops-prod-swampup\"}}" \
                    | jq -r '.reports[0].id')
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" -X DELETE "${XRAY_URL}/api/v1/reports/${REPORT_ID_LICENSE}"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" -X DELETE "${XRAY_URL}/api/v1/reports/${REPORT_ID_FIX}"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" -X DELETE "${XRAY_URL}/api/v1/reports/${REPORT_ID_HIGH}"
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" -X DELETE "${XRAY_URL}/api/v1/reports/${REPORT_ID}"

echo "INFO - removing CLI configuration"
jfrog config remove "${CLI_INSTANCE_ID}" --quiet

echo "INFO - clean local docker registry"
docker rmi ${BASE_IMAGE_SAFE} 2>/dev/null
docker rmi ${BASE_IMAGE_UNSAFE} 2>/dev/null
docker rmi ${IMAGE_ABSOLUTE_NAME_DEV_LAB1} 2>/dev/null
docker rmi ${IMAGE_ABSOLUTE_NAME_DEV_LAB3} 2>/dev/null
docker rmi ${IMAGE_ABSOLUTE_NAME_DEV_LAB4} 2>/dev/null
docker rmi ${IMAGE_ABSOLUTE_NAME_PROD_LAB1} 2>/dev/null
docker rmi ${IMAGE_ABSOLUTE_NAME_PROD_LAB4} 2>/dev/null
