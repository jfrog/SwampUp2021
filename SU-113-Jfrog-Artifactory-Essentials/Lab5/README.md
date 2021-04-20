# Lab5 - Browsing & Searching

## Prerequisites

The Docker repositories and image created in the previous labs.

## Browse

### Step1 - Browsing Through the UI

- Navigate to the Application module and click on 'Artifactory' -> 'Packages'.
- In the top search bar, brwose packages and filter by repository type - docker.
- Locate the sample docker image you've pushed to artifactory.

  **ADD SCREENSOHTS**

### Step2 - Assign Custom Properties

- Navigate to the Application module and click on 'Artifactory' -> 'Artifacts'.
- Filter by repository type - docker, and click on the docker package you've pushed, in the latest version.
- In the 'properties' tab, add a new property: 'deployement' : 'test'.

  **ADD SCREENSOHTS**

### Step3 - Search by Custom Properties

- In the top search bar, choose 'artifacts' and filter by the custom property you've just inserted - 'deployment' : 'test'.

### Step4 - Srearch Properties With the REST API

- Use cURL or any other HTTP client to search for the atrifact that you've modified:
  `curl -u ${user}:${password} -X GET https://**RT_ADDRESS**/artifactory/api/search/prop?deployment=test`
  **ADD SCREENSOHTS**
