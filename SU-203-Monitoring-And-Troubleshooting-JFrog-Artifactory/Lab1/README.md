# Lab 1 - Monitoring

## Data Collections Points

* **Q**: What is your JFrog Artifactory uptime?

    * **A**: Navigate through the Monitoring section at the Admin view on the UI
        * Login to your JFrog Artifactory instance with admin user
        * Switch to `Administration` tab
        * Navigate to `Monitoring`-->`Service Status`
        * Expand all "Artifactory" rows


* **Q**: What is the general default log level?

    * **A**: Check `system.yaml` for logging level and `logback.xml`
        * Navigate to: `$JFROG_HOME/<product>/var/etc/`
        * Print\View `system.yaml`
        * Look for this section:
        ```
      frontend:
          logging:
            application:
                level: debug
      ```
        * If you didn't find the section above, let's check the `logback.xml` file:
            * Navigate to: `$JFROG_HOME/artifactory/var/etc/artifactory/logback.xml`
            * Print\View `logback.xml`
            * Look for this section:
        ```
      <!-- JFrog loggers -->
            <logger name="org.artifactory" level="info" />
            <logger name="org.jfrog" level="info" />
            ...
      ```
    

* **Q**: How much free space left on your JFrog Artifactory instance? (please mention at least 2 options)
  
    * **A1**: Navigate through the Monitoring section at the Admin view on the UI
        * Login to your JFrog Artifactory instance with admin user
        * Switch to `Administration` tab
        * Navigate to `Monitoring`-->`Storage`
        
    * **A2**: Use of `Storage Info` REST API
        * Invoke (with an admin user): `https://your_jfrog_artifactory_host:your_jfrog_artifactory_port/artifactory/api/storageinfo`
            * You can use your favorite REST Client or this `curl` command:
            `curl -uADMIN_USERNAME https://your_jfrog_artifactory_host:your_jfrog_artifactory_port/artifactory/api/storageinfo | json_pp`

              
* **Q**: Download an artifact, find its trace ID and mention which Microservices were part of this request

    * **A**:    
    
* **Q**: Log Analytics - Most downloaded artifacts (instructors env)

* **Q**: Prometheus - Top Downloading IPs  (instructors env)

