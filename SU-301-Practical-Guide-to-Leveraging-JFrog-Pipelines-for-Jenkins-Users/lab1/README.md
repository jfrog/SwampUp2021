# Lab 1

1. In `lab1/{java,python}/pipelines.resources.yml`, Update the git resource by using your own git repo :
```
      path: cyan21/SwampUp2021
```

2. Create the following Pipelines integrations :
* Github and name it `my_github`
* Artifactory and name it `artifactory_eu`

3. Load the pipeline source of your choice and specify one of the following **Pipeline Config File Filter**
* java : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab1\/java\/pipelines.*\.yml`
* python : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users\/lab1\/python\/pipelines.*\.yml`

4. Run the pipeline ... and fix it :P

The pipeline will be triggered on each commit and pull request !

> Hint for troubleshooting : read carefully the logs ... sometimes the YAML syntax isn't super clear ...


Extra : 
* Have a look to the pipeline you didn't choose
