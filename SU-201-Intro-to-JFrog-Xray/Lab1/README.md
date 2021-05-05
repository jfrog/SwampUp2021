# Lab1 - Get familiar with JFrog Platform and Xray

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

## Creating Watches & Policies

### Step1 - Add the repositories to indexing resources

- Login to your saas instance <XXXXX>.jfrog.io with  your admin credentials

- Navigate to the Administration Module go to Xray Security and Compliance and click on settings then indexed resources now add the repositories that you would like to index.
 
 <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/8.gif" alt="Watches & Policies tab" style="height: 100px; width:100px;"/>

### Step2 - Create a policy 

- Navigate to the Administration Module, expand the Xray menu at the bottom and click on the Watches & Policies menu item.
  <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/1.png" alt="Watches & Policies tab" style="height: 100px; width:100px;"/>
  
- Click on the new Policy button and let's create our first policy
  <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/2.png" alt="New Policy" style="height: 100px; width:100px;"/>

### Step3 - Create a rule

- Enter the policy name “Swampup-policy” and keep the security type then click on New Rule button
  <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/3.png" alt="New rule" style="height: 100px; width:100px;"/>

- Enter the rule name "Swampup-rule" scroll down a bit and enable block download action
  <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/4.gif" alt="Rule configuration" style="height: 100px; width:100px;"/>

### Step4 - Create a Watch

-  Click om the Watch tab and create a new watch name “Swampup-watch”  
   <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/5.png" alt="Create a watch" style="height: 100px; width:100px;"/>
   
-  Add the repositories to by clicking on the add repositories plus button and add the policy that we just created by clicking on the Manage policies button 
   <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/6.png" alt="mame the repo" style="height: 100px; width:100px;"/>

