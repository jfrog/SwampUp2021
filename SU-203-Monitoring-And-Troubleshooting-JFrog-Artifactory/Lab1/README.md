# Lab 1 - Monitoring

## Data Collections Points

* **Q**: What is your JFrog Artifactory uptime?

    * **A**: Navigate through the Monitoring section at the Admin view on the UI
        * Login to your JFrog Artifactory instance with admin user
        * Switch to `Administration` tab
        * Navigate to `Monitoring`-->`Service Status`
        * Expand all "Artifactory" rows


* **Q**: How much free space left on your JFrog Artifactory instance? (please mention at least 2 options)
  
    * **A1**: Navigate through the Monitoring section at the Admin view on the UI
        * Login to your JFrog Artifactory instance with admin user
        * Switch to `Administration` tab
        * Navigate to `Monitoring`-->`Storage`
        
    * **A2**: Use of `Storage Info` REST API
        * Invoke (with an admin user): `https://your_jfrog_artifactory_host:your_jfrog_artifactory_port/artifactory/api/storageinfo`
            * You can use your favorite REST Client or this `curl` command:
            `curl -uADMIN_USERNAME https://your_jfrog_artifactory_host:your_jfrog_artifactory_port/artifactory/api/storageinfo | json_pp`
    