# Lab6 - Browsing & Searching

## Prerequisites

The Docker repositories and image created in the previous labs.

## Browsing

### Step1 - Browsing Through the UI

- Package View

  - Navigate to the Application module and click on 'Artifactory' -> 'Packages'.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/package-view.png" alt="package-view" style="height: 100px; width:100px;"/>
  
  - View More information about the package. Click on the docker image(my-docker-image)
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/docker-package.png" alt="docker-package" style="height: 100px; width:100px;"/>
  
  - Click on the version(latest) to view more details about the docker image
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/docker-version.png" alt="docker-version" style="height: 100px; width:100px;"/>
    
  - Navigate to the Docker layers tab to view the different docker layers on that docker image which we pushed as part of Lab5
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/docker-layers.png" alt="docker-layers" style="height: 100px; width:100px;"/>

- Tree View    
  - Navigate to the Application module and click on 'Artifactory' -> 'Artifacts'.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/artifacts-view.png" alt="artifact-view" style="height: 100px; width:100px;"/>
    
  - The docker image which we pushed as part of Lab5 actually resides in "swampup-docker-dev-local" repository which is the default deployment repository.
    <img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/tree-view.png" alt="tree-view" style="height: 100px; width:100px;"/>


### Step2 - Assign Custom Properties

- Navigate to the Application module and click on 'Artifactory' -> 'Artifacts'.
- Filter by repository type - docker, and click on the docker package you've pushed, in the latest version.
- In the 'properties' tab, add a new property: 'deployement' : 'test'.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/property.png" style="height: 100px; width:100px;"/>

### Step3 - Search by Custom Properties

- In the top search bar, choose 'artifacts' and filter by the custom property you've just inserted - 'deployment' : 'test'.

<img src="/SU-113-Jfrog-Artifactory-Essentials/Lab6/images/search_property.png" style="height: 100px; width:100px;"/>

### Step4 - Srearch Properties With the REST API

- Use cURL or any other HTTP client to search for the atrifact that you've modified:

  `curl -u ${user}:${password} -X GET https://**RT_ADDRESS**/artifactory/api/search/prop?deployment=test`
