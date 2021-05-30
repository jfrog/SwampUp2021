# Lab5 - Browsing & Searching

## Prerequisites

- The Docker repositories and image created in the previous labs.

- Leverage the same container from Lab4. Ensure it is up and running. If the container has stopped, please refer Lab4 to run the container again.

## Browsing

### Step1 - Browsing Through the UI

- Package View

  - Navigate to the Application module and click on 'Artifactory' -> 'Packages'.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/package-view.png" alt="package-view" style="height: 100px; width:100px;"/>
  
  - View More information about the package. Click on the docker image(my-docker-image)
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/docker-package.png" alt="docker-package" style="height: 100px; width:100px;"/>
  
  - Click on the version(latest) to view more details about the docker image
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/docker-version.png" alt="docker-version" style="height: 100px; width:100px;"/>
    
  - Navigate to the Docker layers tab to view the different docker layers on that docker image which we pushed as part of Lab4
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/docker-layers.png" alt="docker-layers" style="height: 100px; width:100px;"/>

- Tree View    
  - Navigate to the Application module and click on 'Artifactory' -> 'Artifacts'.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/artifacts-view.png" alt="artifact-view" style="height: 100px; width:100px;"/>
    
  - The docker image which we pushed as part of Lab4 actually resides in "swampup-docker-dev-local" repository which is the default deployment repository.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/tree-view.png" alt="tree-view" style="height: 100px; width:100px;"/>


### Step2 - Assign Custom Properties

- Navigate to the properties tab and add a property "uat-test": "passed" to the latest tagged image and select the "Recursive" checkbox so that all the docker layers have this property set.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/add-properties.png" alt="properties-add" style="height: 100px; width:100px;"/>

### Step3 - Search by Custom Properties

- In the top search bar, choose 'Artifacts' and click on the double-sided filter to enable searching by the custom property you've just inserted.
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/search-artifacts.png" alt="search-artifact" style="height: 100px; width:100px;"/>
    
- Add the property which we inserted in the step above "uat-test : passed" to filter only that artifact
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/search-prop.png" alt="search-property" style="height: 100px; width:100px;"/>
  
- Search result will provide all the folders/subfolders which have "uat-test: passed" property set. You can choose that respective artifact and navigate to it.
  <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab5/images/search-result.png" alt="search-result" style="height: 100px; width:100px;"/>

### Step4 - Search Properties using REST API

- Use cURL or any other HTTP client to search for the artifact that you've modified. The SERVER_NAME is the first part of the URL given to you for your environment: ```https://<SERVER_NAME>.jfrog.io.```. Update the username/password for your instance 

  `curl -u${user}:${password} -X GET "https://<SERVER_NAME>.jfrog.io/artifactory/api/search/prop?uat-test=passed"`
