# Lab4 - Impact Analysis, Notifications Create Reports and Debug logs 

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

### Part 1 - Impact Analysis

- Xray analyzes how an issue in one component affects all others in your company and displays the chain of impact in a component graph, allowing you to have a clear understanding of the impact one component has on another. 

- Every time new component metadata is available (vulnerabilities, licenses, etc.), Xray looks up the component in the components graph and if the update matches any watches, Xray will generate an issue and create a map of its impact to determine which artifacts are ultimately affected by it. This process is called ["Impact Analysis"](https://jfrog.com/ja/article/impact-analysis/) .

<img src="/SU-201-Intro-to-JFrog-Xray/Lab4/images/1.png" alt="Impact Analysis" style="height: 100px; width:100px;"/>

### Part 2 - Notifications

- With Xray you can easily set up actions determines the automatic response to a detected Policy violation. You can define one or more action within each Policy Rule for example we can create a [" mail server"](https://www.jfrog.com/confluence/display/JFROG/General+System+Settings#GeneralSystemSettings-MailServerConfiguration) to send a email for every violation like the following screenshot:
<img src="/SU-201-Intro-to-JFrog-Xray/Lab4/images/3.png" alt="Create Reports" style="height: 100px; width:100px;"/>

### Part 3 - Create Reports

- Xray reports provide you the ability to collect and view information on the Xray scanning of your packages and artifacts. 
- To collect a report click on the Security and compliance tab and the reports tab 
<img src="/SU-201-Intro-to-JFrog-Xray/Lab4/images/2.gif" alt="Create Reports" style="height: 100px; width:100px;"/>

### Part 4 - Debug logs
- The JFrog Platform provides standardized logs for all JFrog products and their services. All logs include a standard format and naming convention.
- Xray logs can be found under /var/opt/jfrog/xray/data/logs on ["linux installation"](https://www.jfrog.com/confluence/display/XRAY2X/Installing+Xray#InstallingXray-LinuxInstallation) 
- The service log file console pattern uses colors to highlight the service type and message level. On Windows console colors should be disabled.
<img src="/SU-201-Intro-to-JFrog-Xray/Lab4/images/4.png" alt="Create Reports" style="height: 100px; width:100px;"/>
- You may want to read more about logging ["here"](https://www.jfrog.com/confluence/display/JFROG/Logging)
