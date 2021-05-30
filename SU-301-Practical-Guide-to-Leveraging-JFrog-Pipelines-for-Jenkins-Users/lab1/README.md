# Lab 1

1. Create a branch called **java** or **python**
```
# on the main branch, run on of the following command
git checkout -b java
git checkout -b python

# push the branch
git push -u origin java
git push -u origin python
```

2. In `lab1/{java,python}/pipelines.resources.yml`, Update the git resource by using your own git repo :
```
      path: cyan21/SwampUp2021
```

3. Create the following Pipelines integrations :
* Github and name it `my_github`, choose **Pipelines** for the usage
* Artifactory and name it `artifactory_eu`

4. Load the pipeline source of your choice and specify one of the following **Pipeline Config File Filter**
* java : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users/lab1/java/pipelines.*\.yml`
* python : `SU-301-Practical-Guide-to-Leveraging-JFrog-Pipelines-for-Jenkins-Users/lab1/python/pipelines.*\.yml`

4. Run the pipeline ... and fix it :P

The pipeline will be triggered on each commit and pull request !

> Hint for troubleshooting : read carefully the logs ... sometimes the YAML syntax isn't super clear ...


Extra : 
* Have a look to the pipeline you didn't choose
