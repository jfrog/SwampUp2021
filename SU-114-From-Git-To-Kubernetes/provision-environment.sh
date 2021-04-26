#!/bin/bash
#Please update this based on your environment!
server_name=talyi
github_username=talitz
artifactory_user_name=
artifactory_api_token=

#Artifactory Related Tasks

#Create Repositories using the wizard of type Gradle, Docker, NPM and Generic.

#Upload apache tomcat v8.0.32 (https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz) to generic-local repository.



#Pipelines Related Tasks

#Create 2 integration in Artifactory: artifactory (of Type Artifactory), docker (of Type Docker Integration), and git.

#Create new Source in JFrog Pipelines and add this repository.

#In all pipelines.resources, change the GitRepo path and provider based on your github user name.
