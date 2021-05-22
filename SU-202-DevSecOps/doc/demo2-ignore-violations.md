# Demo 2 - Ignore Violations

## Context

- Maintenance of a Docker image has been handed over to your team
- You want to start using Xray but need to clear your copy first 
- low severity vulnerabilities are fine according to our security team

## Objective

- Show how to ignore violations to clean the current status

## Create Xray policy

Create security policy:
```bash
raise-violation-on-medium-severity
```
with rule
```bash
raise-violation-on-medium-severity-rule
```

- trigger a violation on **medium severity** security issue discovered
- no action

## Create Xray watch

Create watch:
```bash
devsecops-legacy-watch
```

- add a repository as resource:
```bash
devsecops-docker-prod-local
```
- add a filter on name:
```bash
ubuntu:20.04
```
- add policy:
```bash
raise-violation-on-medium-severity
```

## Log into Docker registry

```bash
docker login -u "${ARTIFACTORY_LOGIN}" -p "${ARTIFACTORY_API_KEY}" "${DOCKER_REGISTRY_PROD}"
```

## push image to Artifactory

```bash
docker pull ubuntu:20.04
docker tag ubuntu:20.04 ${DOCKER_REGISTRY_PROD}/ubuntu:20.04
docker push ${DOCKER_REGISTRY_PROD}/ubuntu:20.04
```

## Go to devsecops-legacy-watch violation tab

Ignore violations:

> Systemd 242...
- Any Vulnerability / Current components / Version 20.04 / Current Watch
  Comment => Security team currently evaluating the impact

Add an expiration date onto this rule

## Go to list of Ignore Rules

- Show the content of the rule
- Show expiration time on rule

## Go to devsecops-legacy-watch violation tab

=> It is expected to be empty
=> Show Ignored violations

## Conclusion

You can now start monitoring violations being added to this docker image.
You'll have to revisit your temporary ignore rules when those get expired.
