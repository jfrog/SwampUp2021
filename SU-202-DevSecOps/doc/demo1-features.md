# Demo 1 - Xray Features

## Objective

Walk through Xray features

## Log into the UI

Show the Security & Compliance menu entry.

## User section

- Watch violations: where you can check all violations per watch
- Reports: where you can create and access reports

## Administration section

Allow Xray configuration, in particular:
- what will be scanned
- creation of policies and watches

## Browse to vulnerable Artifact

Artifactory => Artifacts => demo-docker-dev-local => swampup => devsecops => 0.0.9 => manifest.json

## Open Xray Tab

## Open Descendants

This is actually a representation of the component graph described earlier during the presentation

## Open Security tab

### Click on first item on first page (Busybox arp applet arp_main()...)

=> Show issue detail (all fields)
description, severity, source, creation date, CVE detail, references, infected component

=> Show component graph
component in a docker layer in a docker image

### Click on 3.1:busybox:1.22.1-r15 in the component graph

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


## Conclusion

We have seen in details the main features of Xray.
We have seen as well how to interact with the REST API, allowing us to automate our processes.
