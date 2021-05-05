# Demo 1 - Xray Features

## Objective

Walk through Xray features

## Log into the UI

Show the Security & Compliance menu entry.

## Administration section

This is where to configure Xray.

### Settings => Indexed Resources

All resources (repositories, builds and release bundles) that will be indexed by Xray

### Watches & Policies

where you can create, modify or delete watches, policies and ignore rules.

- Policies > block-download-on-high-severity > Edit Rule
show criteria and actions

- Watches > devsecops-docker-repo-watch
show manageable resources
show manage policies  
  
- Watches > devsecops-docker-repo-watch > Edit repositories
show how you can add repositories and apply patterns

## User section

### Watch violations

This is where you can consult the outcome of your watches.

- show the list of watches

- drill down on *devsecops-docker-repo-watch*
show violations
show filters (min severity, type)

### Reports

where you can create and access reports
  
## Search vulnerable Artifact

Artifactory > Packages > swampup

you can get the list of versions for this docker image

> 0.0.9

> Xray Data > descendants

This is actually a representation of the component graph described earlier during the presentation

> Xray Data > Security

This is where all the vulnerabilities are listed

>> Click on first item (Busybox arp applet arp_main()...)

=> Show issue detail (all fields)
description, severity, source, creation date, CVE detail, references, infected component

=> Show component graph
component in a docker layer in a docker image

>> Click on 3.1:busybox:1.22.1-r15 in the component graph

=> check violations related to a given component

=> Click on ancestor tab and show all references to this component in Artifactory 

## REST API

- Collect indexing configuration
```bash
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
      -H 'Content-Type: application/json' \
      -X GET "${XRAY_URL}/api/v1/binMgr/default/repos" \
      | jq
```

You can obviously update the configuration as well

- Create a policy
```bash
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
      -H 'Content-Type: application/json' \
      -X POST "${XRAY_URL}/api/v2/policies" \
      -d \
      "{
          \"name\": \"devsecops-sample-policy\",
          \"description\": \"DevSecOps sample policy\",
          \"type\": \"security\",
          \"rules\": [{
              \"name\": \"devsecops-sample-policy-rule\",
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
          }]
      }"
```

- Create a watch
```bash
curl -u "${ARTIFACTORY_LOGIN}:${ARTIFACTORY_API_KEY}" \
    -H 'Content-Type: application/json' \
    -X POST "${XRAY_URL}/api/v2/watches" \
    -d \
    "{
        \"general_data\": {
            \"name\": \"devsecops-sample-watch\",
            \"description\": \"Docker sample repo\",
            \"active\": false
        },
        \"project_resources\": {
            \"resources\": [{
                \"type\": \"repository\",
                \"bin_mgr_id\": \"default\",
                \"name\": \"demo-docker-dev-local\"
            }]
        },
        \"assigned_policies\": [{
            \"name\": \"devsecops-sample-policy\",
            \"type\": \"security\"
        }]
    }"
```

An error is expected for this last call as we do not have this repo indexed by Xray

## Conclusion

We have seen in the UI how to access and interact with Xray features.
We have seen as well how to interact with the REST API, allowing us to automate our processes.
