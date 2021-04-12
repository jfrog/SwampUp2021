# Demo 7 - Webhooks

## Context

- You need to create some custom behavior upon violation detection (create a Jira ticket for instance) 

## Objective

- Create a webhook and configure it in a policy
- Show the payload

## Configure the webhook

name: custom-webhook
url: http://xray-custom-provider-service.default/api/checkcomponent

## Update policy fail-build-on-high-severity

Add newly created webhook

## Check impact

```bash

# tail the logs
kubectl logs xray-custom-provider-app-76dbdf4c66-czlcc -f

```

- Apply on devsecops-docker-build-watch on existing content

=> show the payload

## Conclusion

You can create custom behavior upon issue detection.

