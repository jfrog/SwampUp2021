# Lab 1 - Monitoring

* **Q**: What is your JFrog Artifactory uptime?

<details>
    <summary>Expand for step-by-step answer</summary>

* **A**: Navigate through the Monitoring section at the Admin view on the UI
    * Login to your JFrog Artifactory instance with admin user
    * Switch to `Administration` tab
    * Navigate to `Monitoring`-->`Service Status`
    * Expand all "Artifactory" rows

![Service Status](images/q1.png?raw=true "Service Status")
</details>


* **Q**: What is the general default log level?

<details>
    <summary>Expand for step-by-step answer</summary>

* **A**: Check `system.yaml` for logging level and `logback.xml`
    * Connect to JFrog Artifactory instance using SSH
    * Navigate to: `/opt/jfrog/artifactory/var/etc/`
    * Print\View `system.yaml` (if `system.yaml` doesn't exist you can always create one to override values or use `system.full-template.yaml`)
    * Look for this section:
    ```
  frontend:
      logging:
        application:
            level: debug
  ```
    * If you didn't find the section above (because `system.yaml` is with default values on your instance, let's check the `logback.xml` file:
        * Navigate to: `/opt/jfrog/artifactory/var/etc/artifactory/logback.xml`
        * Print\View `logback.xml`
        * Look for this section:
    ```
  <!-- JFrog loggers -->
        <logger name="org.artifactory" level="info" />
        <logger name="org.jfrog" level="info" />
        ...
  ```
</details>

* **Q**: How much free space left on your JFrog Artifactory instance? (please use both of the UI option, and the REST API option)

<details>
    <summary>Expand for step-by-step answer</summary>

* **A1**: Navigate through the Monitoring section at the Admin view on the UI
    * Login to your JFrog Artifactory instance with an admin user
    * Switch to the `Administration` tab
    * Navigate to the `Monitoring`-->`Storage` section

![Storage](images/q3.png?raw=true "Storage")
    
* **A2**: Use of `Storage Info` REST API
    * Invoke (with an admin user): `{{your_jfrog_artifactory_protocol}}://{{your_jfrog_artifactory_host}}:{{your_jfrog_artifactory_port}}/artifactory/api/storageinfo`
        * You can use your favorite REST Client or this `curl` command:
        `curl -uADMIN_USERNAME {{your_jfrog_artifactory_protocol}}://{{your_jfrog_artifactory_host}}:{{your_jfrog_artifactory_port}}/artifactory/api/storageinfo | json_pp`
            * {{your_jfrog_artifactory_protocol}}: http OR https
            * {{your_jfrog_artifactory_host}}: Your Artifactory instance's host name
            * {{your_jfrog_artifactory_port}}: 80/8080 for http, 443 for https

![Storage Info](images/q3_2.png?raw=true "Storage Info")

</details>
              
* **Q**: Add a custom property to an artifact (through the UI) and find its request and trace ID, then mention which Microservices were part of this request
    * **Hint**: Please use this artifact: `swampup-gradle-dev-local/ant/ant/1.6.5/ant-1.6.5.jar`

<details>
    <summary>Expand for step-by-step answer</summary>

* **A**:
    * Go over [Artifactory architecture diagram](https://www.jfrog.com/confluence/display/JFROG/System+Architecture) for reference
    * Browse to the pre-populated artifact using your default browser
        * Navigate to `Artifacts` section
        * Navigate to repository: `swampup-gradle-dev-local`
        * Expand and navigate to artifact: `ant/ant/1.6.5/ant-1.6.5.jar`
        * Switch to Properties tab
        * Add custom property: `key=swampUp, value=2021`
    * Connect to your JFrog Artifactory instance using SSH
    * Navigate to: `/opt/jfrog/artifactory/var/log/`
    * Start with finding the first log line represents the request for that artifact in: `router-request.log`
      ```
      router-request.log:{"BackendAddr":"localhost:8070","ClientAddr":"10.24.2.3:54800","DownstreamContentSize":379,"DownstreamStatus":200,"Duration":17780048,"RequestMethod":"GET","RequestPath":"/ui/api/v1/ui/artifactproperties?repoKey=docker-demo-prod-local\u0026path=abbrev%2F-%2Fabbrev-1.1.1.tgz","StartUTC":"2021-05-20T08:40:05.307589003Z","level":"info","msg":"","request_Uber-Trace-Id":"27d6c2004320ef8a:144b74101317f73d:27d6c2004320ef8a:0","request_User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36","time":"2021-05-20T08:40:05Z"}
      ```
    * Copy the TraceId (`request_Uber-Trace-Id` - from start to first semicolon)
        * TraceId from the log snippet above will be: "request_Uber-Trace-Id":"**_27d6c2004320ef8a_**:144b74101317f73d:27d6c2004320ef8a:0"
    * Search for the whole logs with that TraceId (you can use this grep command: `grep *.* -e TRACE_ID`)
        ```
        artifactory@artifactory-artifactory-0:/opt/jfrog/artifactory/var/log$ grep *.* -e "27d6c2004320ef8a"
        artifactory-request.log:2021-05-20T08:40:05.323Z|27d6c2004320ef8a|52.215.237.185|talet@jfrog.com|GET|/api/artifactproperties|200|2|0|3|Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36
        frontend-request.log:2021-05-20T08:40:05.325Z|27d6c2004320ef8a|127.0.0.1|talet@jfrog.com|GET|/api/v1/ui/artifactproperties?repoKey=docker-demo-prod-local&path=abbrev%2F-%2Fabbrev-1.1.1.tgz|200|379|-|15.136|Chrome|90.0.4430.212|Mac OS|10.15.7
        router-request.log:{"BackendAddr":"localhost:8081","ClientAddr":"127.0.0.1:44162","DownstreamContentSize":379,"DownstreamStatus":200,"Duration":4798127,"RequestMethod":"GET","RequestPath":"/artifactory/api/artifactproperties?repoKey=docker-demo-prod-local\u0026path=abbrev%2F-%2Fabbrev-1.1.1.tgz","StartUTC":"2021-05-20T08:40:05.319273513Z","level":"info","msg":"","request_Uber-Trace-Id":"27d6c2004320ef8a:3d2d61ca29819b04:398bb96353e2f52d:0","request_User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36","time":"2021-05-20T08:40:05Z"}
        router-request.log:{"BackendAddr":"localhost:8070","ClientAddr":"10.24.2.3:54800","DownstreamContentSize":379,"DownstreamStatus":200,"Duration":17780048,"RequestMethod":"GET","RequestPath":"/ui/api/v1/ui/artifactproperties?repoKey=docker-demo-prod-local\u0026path=abbrev%2F-%2Fabbrev-1.1.1.tgz","StartUTC":"2021-05-20T08:40:05.307589003Z","level":"info","msg":"","request_Uber-Trace-Id":"27d6c2004320ef8a:144b74101317f73d:27d6c2004320ef8a:0","request_User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36","time":"2021-05-20T08:40:05Z"}
        artifactory@artifactory-artifactory-0:/opt/jfrog/artifactory/var/log$
        ```
    * Based on the log snippet above, we can see the different Microservices (based on the log file name):
        * Router
        * Frontend
        * Artifactory
    
</details>
