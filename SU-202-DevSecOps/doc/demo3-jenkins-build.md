# Demo 3 - Jenkins Build

## Context

- Demo the fail build feature on Jenkins

## Objective

- Show integration on Jenkins

## Log into Jenkins

http://jenkins.staging.gcp.devopsacc.team/login

## Show configuration of the maven-sample-with-violations job

It is using a declarative pipeline.

- declare a connection to Artifactory
- wrap your calls to maven into the rtMavenRun groovy method provided by Artifactory plugin
- plug an Xray scan into your pipeline

## Show the console output

Xray failing the job due to some violations being discovered

## Conclusion

Xray can be integrated into any CI server, with a native plugin like for Jenkins, or with the JFrog CLI when there is no plugin.