# Lab 2 - Troubleshooting

## General

In this Lab you will have hypothetical issues with JFrog Artifactory.
You will need to:
* Understand how to monitor the issue
* Understand how to solve the issue

## Issues

* **Issue #1**: Database connections exceeded

<details>
    <summary>Expand for step-by-step resolution</summary>

* **Resolution**:
    * Monitoring
        * Option 1 - Logs
            * Connect to your JFrog Artifactory instance using SSH
            * Navigate to: `/opt/jfrog/artifactory/var/log/`
            * Find the error log message in: `artifactory-service.log`
              ```
              [http-nio-8081-exec-9765] Timeout: Pool empty. Unable to fetch a connection in 120 seconds, none available[size:98; busy:98; idle:0; lastwait:120000]
              ```
        * Option 2 - JMX
            * Use Artifactory JMX MBeans (with JConsole) as described [here](https://www.jfrog.com/confluence/display/JFROG/Artifactory+JMX+MBeans)
            * Based on this option:
            
            ![JMX DB Connections](images/i1.png?raw=true "JMX DB Connections")
              
    * Troubleshooting
        * Control the database connection pool with the `system.yaml` file:
        ```
        artifactory:
          database:
            maxOpenConnections: 300
          ...    
        access:
          database:
            maxOpenConnections: 300
          ...
        metadata:
          database:
            maxOpenConnections: 300
        ```
</details>

* **Issue #2**: Async Thread Pool exceeded

<details>
    <summary>Expand for step-by-step resolution</summary>

* **Resolution**:
    * Monitoring
        * Connect to your JFrog Artifactory instance using SSH
        * Navigate to: `/opt/jfrog/artifactory/var/log/`
        * Find the error log message in: `artifactory-service.log`
          ```
          java.util.concurrent.ThreadPoolExecutor@434c855e[Running, pool size = 32, active threads = 32, queued tasks = 10000, completed tasks = 1190411]
          ```
    * Troubleshooting
        * Control the Async Thread pool size & queue 
            * Navigate to: `/opt/jfrog/artifactory/var/etc/artifactory/`
            * Edit `artifactory.system.properties`
            * Tune pool & queue parameters: ((Shouldn’t be more than 8x the machine CPU cores))
            ```
            artifactory.async.corePoolSize = 128
            artifactory.async.poolMaxQueueSize = 100000
            ```
        
</details>


* **Bonus**: Use ?trace (query param) for non-exist Maven/Gradle public artifact

<details>
    <summary>Expand for step-by-step resolution</summary>

* **Resolution**:
    * Navigate to `{{your_jfrog_artifactory_protocol}}://{{your_jfrog_artifactory_host}}:{{your_jfrog_artifactory_port}}/artifactory/swampup-gradle/jfree/jfreechart/1.0.0/jfreechart-1.0.0.jar?trace` (with your preferred browser)
        * {{your_jfrog_artifactory_protocol}}: http OR https
        * {{your_jfrog_artifactory_host}}: Your Artifactory instance's host name
        * {{your_jfrog_artifactory_port}}: 80/8080 for http, 443 for https
    * Find at the trace the origin (repository name) of the artifact:
      ![trace](images/bonus.png?raw=true "trace")

</details>