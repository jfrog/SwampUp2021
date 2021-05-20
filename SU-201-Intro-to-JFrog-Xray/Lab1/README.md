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
  
- Click on the **Create a Policy** or **New Policy** (if you already have one) and Let's create our first **Security** policy with **"sec_policy"** name
![2-1](https://user-images.githubusercontent.com/7561138/118908191-c6ee8f80-b8d5-11eb-9a72-b35d542332dc.gif)


- Click on **New Rule** to add rule to **sec_policy**. 
![2-2](https://user-images.githubusercontent.com/7561138/118908208-cd7d0700-b8d5-11eb-8abe-f6247d0eed61.gif)


- Click on the **New Policy**. Let's create our second **License** policy with **"lic_policy"** name
![2-3](https://user-images.githubusercontent.com/7561138/118908220-d4a41500-b8d5-11eb-808e-cd9a6599ff5f.gif)


- Click on **New Rule** to add rule to **lic_policy** 
![2-4](https://user-images.githubusercontent.com/7561138/118908229-da99f600-b8d5-11eb-8865-0668317538e0.gif)

**NOTE:** You may have noticed that Fields under **Criteria** are different for License Policy and for Security Policy.  





