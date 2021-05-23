# Lab2 - Understanding CDN Funcionality with Artifactory

## Prerequisites

- A SaaS Instance of JFrog. This will be provided as part of your enrollment to the training class.

- Clone the Git repo
  - ```mkdir Swampup2021```
  - ```git clone https://github.com/jfrog/SwampUp2021.git```
  - Navigate to "Lab2" of "SU-307-Software-Distribution-Patterns"
    ```cd ~/SwampUp2021/SU-307-Software-Distribution-Patterns/Lab2```

- You can access curl


## Executing the Lab

### Step1 - Download spring-petclinic.2.4.2.jar without CDN

- Observe the redirection to Amazon S3 bucket and Total time to download after running below command
  - ```curl -v -O -L -u<user-name>:<password> https://<yourinstancename>.jfrog.io/artifactory/su307-maven-local/spring-petclinic-2.4.2.jar``

### Step2 - Enable CDN using UI

- Check "Enable CDN Download" option at the below location
  - Under "Settings" -> "Repositories" -> "su307-maven-local" -> "Advanced"

- Click "Save & Finish"

### Step3 - Download spring-petclinic.2.4.2.jar with CDN

- Observe the redirection to Cloudfront CDN and Total time to download after running below command
  - ```curl -v -O -L -u<user-name>:<password> https://<yourinstancename>.jfrog.io/artifactory/su307-maven-local/spring-petclinic-2.4.2.jar``

- Total time to download should be significantly reduced
