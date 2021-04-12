# Demo 2 - License compliance

## Context

- You will be distributing your software soon, and you don't want to publish your source code
- You need to avoid any contaminating license like GPL

## Objective

- Show how to create policies for license compliance

## Create Xray policy

Create **raise-violation-on-gpl** license policy:
- trigger a violation on **GPL** license discovered
- no action

## Create Xray watch

Update **devsecops-docker-build-watch** watch:
- add **raise-violation-on-gpl** as policy

## Apply on existing content

## Check violations on devsecops-gradle build

Drill down on the culprit (javassist) and look for its Xray data
=> several licenses are bound to the component

There is some Apache which is fine according to our legal department

## Update Xray policy

Update **raise-violation-on-gpl** license policy:
- Check "Multiple License Permissive Approach"

## Apply on existing content

## Check violations on devsecops-gradle build

No more license violation are found

## Conclusion

We have implemented a blacklisting policy on GPL licenses.
We gave it some flexibility allowing components with at least one non GPL license to be allowed.

You could have some whitelisting policies if needed within your organization.