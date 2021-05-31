# Lab 2

1. In `lab2/{java,python}/pipelines.resources.yml`, Update the git resource by using your own git repo :
```
      path: cyan21/SwampUp2021
```

2. In `lab2/{java,python}/pipelines.steps.yml`, replace  **swampup301.jfrog.io** **ONLY** in the Docker Pipeline with your own JFrog Platform URL
* Java pipeline
```
  - name: lab2_backapp_mvn_docker
    configuration:
      environmentVariables:
        readOnly:
          trainingPath: SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users
          dockerRepo: swampup301.jfrog.io/urs-docker
```

* Python pipeline
```
  - name: lab2_webapp_python_docker
    configuration:
      environmentVariables:
        readOnly:
          dockerRepo: swampup301.jfrog.io/urs-docker
          trainingPath: SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users
```

3. In `src/{java,python}/Dockerfile`, replace  **swampup301.jfrog.io** with your own JFrog Platform URL 

4. Modify your pipeline source by editing the  **Pipeline Config File Filter** :
* java : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users/lab2/java/pipelines.*\.yml`
* python : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users/lab2/python/pipelines.*\.yml`

5. Run the pipeline and fix it :P

> Hint for troubleshooting : you may need another integration ...

> Note : We could have merged the 2 pipelines by using a Multi stage docker file. However you would have missed the basics of JFrog pipelines :)

Extra : 
* Have a look to the pipeline you didn't choose 
