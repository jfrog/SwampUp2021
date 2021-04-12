# Demo 6 - Custom Integration

## Context

- You are missioned to report issues on components not passing your internal security tests

## Objective

- Create a custom integration to an internal server querying your internal security tests results
- Understand that you could interconnect to any type of third party server reporting load capabilities, obsolescence...

## Share the server source code

Basically 2 endpoints

### Authentication

### Component check

## Create a custom integration

- name: xray-custom-provider
- url: http://xray-custom-provider-service.default/api/checkcomponent
- API token: foo

## Query the server

```bash

# tail the logs
kubectl logs xray-custom-provider-app-76dbdf4c66-czlcc -f

# Query the authentication endpoing
curl -X GET http://xray-custom-provider-service.default/api/checkaut

# Query the check component endpoint (safe component)
curl -X POST http://xray-custom-provider-service.default/api/checkcomponent \
      -H 'Content-Type: application/json' \
      -d \
      "{
          \"components\" : [{
              \"component_id\": \"gav://ant:ant:1.6.5\",
              \"blobs\": [
                  \"97282a3b066de4ee4c9409979737f3911f95ceab\"
              ]
          }],
          \"context\" : \"project_id\"
      }"

# Query the check component endpoint (unsafe component)
curl -X POST http://xray-custom-provider-service.default/api/checkcomponent \
      -H 'Content-Type: application/json' \
      -d \
      "{
          \"components\" : [{
              \"component_id\": \"generic://sha256:7f22d56c2d5585d89f884b3baf8273a12b3b3155e8f68c01a82ae2fdc4296a1f/swampup-devsecops-1.0.0.jar\",
              \"blobs\": [
                  \"97282a3b066de4ee4c9409979737f3911f95ceab\"
              ]
          }],
          \"context\" : \"project_id\"
      }"
```

## Check impact

- Browse devsecops-docker build #2
- Force component scan  
- Go To Xray tab
- Click on "This component is blacklisted internally" violation and see description

## Conclusion

You can create violations on your own components to deprecate them for internal reasons.

