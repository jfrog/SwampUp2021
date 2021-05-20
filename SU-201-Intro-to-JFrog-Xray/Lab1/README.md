# Lab1 - Get familiar with JFrog Platform and Xray

## Prerequisites
A SAAS Instance of JFrog. This will be provided as part of your enrollment to the Training class.

### Step1 - Add the repositories to indexing resources

- Login to your saas instance **{{instance_name}}**.jfrog.io with  your admin credentials

- Navigate to the Administration Module go to Xray Security and Compliance and click on settings then indexed resources now add the repositories that you would like to index.
 
 <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/8.gif" alt="Watches & Policies tab" style="height: 100px; width:100px;"/>

### Step2 - Create a policy 

- Navigate to the **Administration** Module, expand the **Xray** menu at the bottom and click on the **Watches & Policies** menu item.
  <img src="/SU-201-Intro-to-JFrog-Xray/Lab1/images/1.png" alt="Watches & Policies tab" style="height: 100px; width:100px;"/>
  
- Click on the **Create a Policy** or **New Policy** (if you already have one) and Let's create our first **Security** policy with **sec_policy** name

- Click on **New Rule** to add rule to **sec_policy**

- Click on the **New Policy**. Let's create our second **License** policy with **lic_policy** name

- Click on **New Rule** to add rule to **lic_policy** 

You may have noticed that Fields under **Criteria** are different for License Policy and for Security Policy.  





