# Demo 2 - Ignore Violations

## Context

- Maintenance of a Docker image has been handed over to your team
- You want to start using Xray but need to clear your copy first 
- low severity vulnerabilities are fine according to our security team

## Objective

- Show how to ignore violations to clean the current status

## Create Xray policy

Create **raise-violation-on-medium-severity** security policy:
- trigger a violation on **medium severity** security issue discovered
- no action

## Create Xray watch

Create **devsecops-legacy-watch** watch:
- add **devsecops-docker-prod-local** repository as resource
- add **raise-violation-on-medium-severity** as policy

## push image to Artifactory

```bash
docker pull ubuntu:20.04
docker tag ubuntu:20.04 ${DOCKER_REGISTRY_PROD}/ubuntu:20.04
docker push ${DOCKER_REGISTRY_PROD}/ubuntu:20.04
```

## Go to devsecops-legacy-watch violation tab

Ignore violations:

> A flaw was found in nettle...
- Any Vulnerability / Current components / Version 20.04 / Current Watch
  Comment => We are not using any signing protocol

> Systemd 242...
- Any Vulnerability / Current components / Version 20.04 / Current Watch
  Comment => Security team currently evaluating the impact

## Go to list of Ignore Rules

- Show the content of each rule
- Show expiration time on second rule

## Go to devsecops-legacy-watch violation tab

=> It is expected to be empty
=> Show Ignored violations

## Conclusion

You can now start monitoring violations being added to this docker image.
You'll have to revisit your temporary ignore rules when those get expired.
