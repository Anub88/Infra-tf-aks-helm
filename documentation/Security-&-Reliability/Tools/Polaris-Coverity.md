
[[_TOC_]]

[Coverity Project Instance](https://carlzeiss.polaris.synopsys.com/home)

#Overview

Coverity on PolarisTM (Polaris) provides a comprehensive, aggregated view of application security with the ability to examine and manage individual security issues.

Coverity on Polaris is a cloud service specifically tailored to companies that need to do the following:

- Scan code in the cloud through an enterprise-scale service

- Incorporate application security testing into the DevOps pipeline.

- Integrate results from multiple Synopsys tools into a single report,

- Using Coverity on Polaris Reporting Platform, 

- Coverity, Seeker, and Managed Services Portal.

It contains Coverity, a fast, accurate, and highly scalable static analysis (SAST) solution. (See Understanding Coverity for more information.)

According to the FOSS Wiki for request access create a ticket at the IT Servicedesk:

https://wiki.zeiss.com/pages/viewpage.action?pageId=445780195

Apply for a project and user account and provide the information about project.

https://zeissprod.service-now.com/it4u (to apply for a project and user account.)

Please also provide the following information :

User(s) - who needs access to Coverity on Polaris to review the results

Segment/SBU - to which segment/SBU is this project belonging to (required for naming and internal billing - your project will NOT be charged)

#How to Add a User to your Coverity
Apply for a project and user account and provide the information about project. 
According to the FOSS Wiki for request access create a ticket at the IT Servicedesk: https://wiki.zeiss.com/pages/viewpage.action?pageId=387680850 

We need to raise the request a ticket to IT Service desk team provide the Polaris (Coverity) login access along with the project request creation. To provide access to the users we need to request again to the same IT desk for user onboarding to Polaris  directory. Once onboarding is done user will recieve a notification email for the first login. After user successful first login admin of the project will have access to add the user into the project with a specific role. Post that user will be able to access the project in the Polaris (Coverity) 

#Admin will have the access as described below
Once user got the admin privilege's. which has an authority to manage user, role, and project.

At least one user has the organization administrator role, which means they can manage users, groups, projects.  An organization owner is automatically assigned the same privileges as an organization administrator.
A contributor is able to triage issues and perform analysis for a project.

An observer has read-only access to the project.

#Adding a User
1. To create a new user in Coverity on Polaris

2. Click on Projects in the left side menu.

3. Make sure Users is selected in the middle menu.

4. Click + Add Member.

5. In the Add User panel, fill in the username, full name, email address.
6. Click Save to save your changes.


#Create a Pipeline
Next, select the Pipeline entry on the left and then click 'Create Pipeline'.

On the 'Where is your code?' page, you can connect your (forked or own) GitHub repository.

On the 'Configure your pipeline' page, select 'Starter pipeline'.
In the last step, you can review the default YAML code of the starter pipeline and click 'Save and run'. This will add and commit the file azure-pipeline.yml to your repository. 
This is the file that will be used to control all the steps in the pipeline.

#Create a Service Connection
To be able to connect with the Coverity Connect server later for commit and 'break-the-build' checks, too, we need to create a Service Connection.

On your project or pipeline page, click on 'Project Settings' at the bottom left (see screenshot above).

Select 'Service Connections' under the 'Pipelines' group. If you connected a GitHub repository to your project, you should have one Service Connection already (to GitHub).

Click 'New service connection' and select 'Coverity'. Click 'Next'.

If Coverity does not show up here, double-check if you have installed the Coverity Azure DevOps extension


![service_connection.png](../../.attachments/service_connection.png)

Fill in the required details and click 'Save'. You will refer to this later just using the service connection name, 'coverity-connect' in my example below

#Create Variables
Now we are almost ready to create the actual job. For downloading the Coverity Analysis packages from the Connect server, we need two Variables that define the server URL and credentials.
Ideally, we could re-use the Coverity Service Connection for that, but I have not found a way to do that.


![adding_variables.png](../../.attachments/adding_variables.png)

Go to the 'Edit' page of your pipeline. The left side of the page shows the navigation menu. The middle part shows the editor for the YAML file.
The right-hand side shows a lot of pre-canned tasks that we can use in our pipeline. Click the 'Variables' button just above the tasks list.

Create variables COVERITY_AUTHKEY and COVERITY_URL in your pipeline job:

#Adding the task in pipeline 
Running Coverity analysis is the Azure Pipeline is very easy using the Coverity Azure DevOps extension. 
Simply find the Coverity task from the task list on the right, fill the fields and click 'Add'. 

![coverity_Azure_devops.png](../../.attachments/coverity_Azure_devops.png)







