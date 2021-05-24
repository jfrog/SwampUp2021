### Lab 2 | Distribution


#### Lab goals: Gain Hand-on experience with JFrog Distribution by managing full Release Bundle lifecycle


#### Step1: Login and navigate to JFrog Distribution

Now that you’re familiar with your environment, login to your main JPD using your admin credentials and then navigate to Distribution service in the Application panel.



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")



#### Step2: Manage Release Bundle Lifecycle (Create, Sign and Distribute)

2.1 Create a new Release Bundle


 2.1.1 Click _+ New Release Bundle _
 2.1.2 Give your Release Bundle a convenient name, version and description
 2.1.3 Click the _Create Query_. For simplicity, use the first option - _Add Query_. Give this query a name and for the Search Criteria choose Acme docker local repository. Click _Next._

<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")



        2.1.4 Additional Details - here you can the queried artifacts with properties and also change the repository path mapping. we’ll skip this option by clicking _Next_.


    

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")



        2.1.5 Preview Artifacts - here is the list of all artifacts that answered this query wizard. Because the only search criteria we used is the repository name in this view we’re getting all artifacts in this repository.


        

<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")



        2.1.6 Repeat steps 2.1.3-2.15 but now query Acme helm repository.

2.2 Sign the created Release Bundle


    2.2.1 Try and edit this Release Bundle. 



*   Click on your new release bundle, now you can see all its available versions and each version state. As you can see its state is _Ready_ and there is a lock next to it - this means it’s immutable and can’t be edited. 
*   Let’s try anyway - click on the RB version then click the _Version Actions_ (right on the top) as you can see the Edit Version action is greyed out.

	

<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")



    2.3 DIstribute the Release Bundle to the available Edge Node in your federation



*   Click again on the _Version Actions_ and choose the _Distribute Version_
*   Choose the Edge JPD and click _Distribute_

    

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: error handling inline image </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>





#### Step3: Consume the distributed Release Bundle

3.1 Login to your Edge 

3.2 Navigate to the Application panel | Distribution section and there you get your distributed Release Bundle.



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")



##### References:

[Distributing Release Bundles](https://www.jfrog.com/confluence/display/JFROG/Distributing+Release+Bundles)
