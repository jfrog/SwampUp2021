# Lab1 - Create and Distribute Release Bundle using JFrog CLI

## Prerequisites

- A SaaS Instance of JFrog. This will be provided as part of your enrollment to the training class.

- Clone the Git repo
  - ```mkdir Swampup2021```
  - ```git clone https://github.com/jfrog/SwampUp2021.git```
  - Navigate to "Lab1" of "SU-307-Software-Distribution-Patterns"
    ```cd ~/SwampUp2021/SU-307-Software-Distribution-Patterns/Lab1```

- You can download JFrog CLI [here](https://jfrog.com/getcli/) and install it
OR
- You can also Install JFrog CLI, using following command:
  - ```curl -fL https://getcli.jfrog.io | sh```

## Executing the Lab

### Step1 - ADD JFrog Platform to CLI

- To view the usage of the CLI
  - ```jfrog config```

- To add JFrog platform to CLI
  - ```jfrog config add```
  
- When prompted please provide Server ID (Unique)

- Platform URL is http://<yourinstancename>.jfrog.io

- CLI will detect the URIs of all the products inside the platform, just hit enter

- Don't enter anything for JFrog access token, just hit enter

- Enter the provided username & password

- Is the Artifactory reverse proxy configured to accept a client certificate?, just hit enter

### Step2 - Configure CLI to use the added JFrog Platform & Verify

- In the below command use the Server ID provided in Step1
  - ```jfrog config use <SERVER-ID>```

- Verify that CLI is talking to Artifactory, you should receive OK as response
  - ```jfrog rt ping```

### Step3 - Create release bundle using the provided file spec

- su307-rb is the name of the release bundle with version 1.0.0
 - ```jfrog rt rbc --spec=lab1-spec.json su307-rb 1.0.0```

### Step4 - Sign the release bundle

- Below command will use GPG key came with Artifactory for Signing the release bundle
 - ```jfrog rt rbs su307-rb 1.0.0```

### Step5 - Distributing the release bundle to Edge node

- Before Distributing the release bundle from main JFrog platform to Edge node, verify that distributing artifact is not there on edge node using UI

- Below command will distribute the release bundle to Edge node
  - ```jfrog rt rbd --site=<youredgename> su307-rb 1.0.0```

- Verify that release bundle and artifact are distributed to Edge node using UI