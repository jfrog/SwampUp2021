<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 0; ALERTS: 3.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>



### Lab 1 | Automation


#### Lab description: 

In this lab you will gain experience with one of the most common automation processes for on-boarding a new project to the JFrog Platform. This lab specifically is based on REST API calls.


#### Lab goals:

Hands-on experience with the available JFrog automation tools.


#### How to:

Onboard a new project/team to the platform by creating the required set of resources (repositories: docker,helm, Xray watches and Policies, user/permission) with the required set of permissions for both main JPD and Edge(s)


#### Step1: Login

Login to your saas instance .jfrog.io with your admin credentials



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")



#### Step2: Get familiarity with the JFrog automation tools


##### 2.1 Rest API ping 

Ping the environment using the ping API call

References: [System Health Ping](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-SystemHealthPing)


##### 2.2 JFrog CLI

	2.2.1 Download the JFrog CLI

	References: [INSTALL JFROG CLI](https://jfrog.com/getcli/)**, **[JFrog CLI](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI)


##### 	2.2.2  Add and configure your SaaS instance with the JFrog CLI \
	References: [Adding and Editing Configured Servers](https://www.jfrog.com/confluence/display/CLI/JFrog+CLI#JFrogCLI-JFrogPlatformConfiguration)


##### 2.2.3 Verify Artifactory is accessible

References: [Verifying Artifactory is Accessible](https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-VerifyingArtifactoryisAccessible)



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")



######  Configure CLI screenshot


#### Step3: Provision the set of resources for the Acme project


##### 3.1 Pre-script (optional)


    Check which resources are already available in your environment before running the script that provisiones all resources (Repositories, Xray Policies and Watches and Permission Targets) for the new project.


    [Get Repositories](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-GetRepositories) 


    [Get Permission Targets](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-GetPermissionTargets)


    [Get Watches](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetWatches)


    [Get Policies](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetPolicies.1)


##### 
    3.2 Run the onboarding.sh script



<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")



###### Script Screenshot


##### 3.3 Post-script (optional)


    Validate the script completed successfully by checking that all the resources for the Acme project are available and ready to be used.


    [Get Repositories](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-GetRepositories) 


    [Get Permission Targets](https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-GetPermissionTargets)


    [Get Watches](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetWatches)


    [Get Policies](https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetPolicies.1)
