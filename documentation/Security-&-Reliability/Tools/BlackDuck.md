[[_TOC_]]

[Blackduck Project Instance](https://zeiss.app.blackduck.com/api/risk-profile-dashboard?limit=25&offset=0)

# Overview
Black Duck helps you identify and mitigate open source related risks in your applications and containers. The Synopsys integration products are designed to become a part of your environment and workflow.
All integrations on this page are open sourced on our GitHub organization site at:
https://github.com/blackducksoftware

#How to Add a User to your Black Duck Portal
Apply for a project and user account and provide the information about project and User information.
According to the FOSS Wiki for request access create a ticket at the IT Servicedesk:
https://wiki.zeiss.com/pages/viewpage.action?pageId=387680850

#Integrations Documentation
##CI/CD Azure DevOps

###Synopsys Detect for Azure DevOps : 
The Synopsys Detect for Azure DevOps plugin, formerly known as Black Duck Detect plugin for TFS/VSTS, is architected to seamlessly integrate Synopsys Detect with Azure DevOps build and release pipelines. Synopsys Detect makes it easier to set up and scan code bases using a variety of languages and package managers.

The Synopsys Detect plugin for Azure DevOps supports native scanning in your Azure DevOps environment to run Software Composition Analysis (SCA) on your code.

As a Synopsys and Azure DevOps user, Synopsys Detect Extension for Azure DevOps enables you to:

Run a component scan in an Azure DevOps job and create projects and releases in Black Duck through the Azure DevOps job.
After a scan is complete, the results are available on the Black Duck server (for SCA).
Using the Synopsys Detect Extension for Azure DevOps together with Black Duck enables you to use Azure DevOps to automatically create Black Duck projects from your Azure DevOps projects.

###Invoking Synopsys Detect
Synopsys recommends invoking Synopsys Detect from the CI (build) pipeline.  Scanning during CI enables Synopsys Detect to break your application build, which is effective for enforcing policies like preventing the use of disallowed or vulnerable components.

#Basic workflow

###Using Synopsy Detect to analyze your code in Azure involves the following basic steps:

Make sure you satisfy system and other requirements

Download and configure the Synopsys Detect extension in Azure

Configure build agent and pipeline

Configure Black Duck connection

Configure Synopsys Detect arguments

Run pipeline and invoke scan

Examine the analysis results

##Requirements for Synopsys Detect in Azure DevOps
The following is a list of requirements for the Synopsys Detect in Azure DevOps integration.

Black Duck server.
For the supported versions of Black Duck, refer to Black Duck Release Compatibility.

Black Duck API token to use with Azure.

Azure DevOps Services or Azure DevOps Server 17 or later

The Synopsys Detect Extension for Azure DevOps is supported on the same operating systems and browsers as Black Duck.


##Installing the Synopsys Detect for Azure DevOps Extension


 From the Azure Pipelines page, add the Detect plug-in for ADO.

###Install the Synopsys Detect extension for Azure DevOps

1.Click the plus sign (+) under Tasks for Agent Job

2.Search for the Synopsys Detect plugin and click Add to add it to your pipeline.


#Configuring and Running the Plugin


After you install the plugin, you configure it in Pipeline task.

Configure your Synopsys Detect for Azure DevOps plugin by adding configuration for your Black Duck server and adding Detect arguments.


##Configuring the plugin

1. Navigate to Your Collection > Project > Pipelines > Tasks. The plugin adds a new task of Run Synopsys Detect for your build. You must add this task to your build queue. 

2. Click Run Synopsys Detect for your build, and the Synopsys Detect panel displays on the right. In the Synopsys Detect configuration panel, complete the following fields and options.

3. Display name: Type a unique name in this field.  Note that the name you type here displays in the left panel; the default name is Run Synopsys Detect for your build.

4. Click+ New to add a new Black Duck Service Endpoint and then configure the details.

5. Click+ New to add a new Black Duck Proxy Service Endpoint and then configure the details.

6. Detect Version: Version of the Detect binary to use. Synopsys recommends using the latest; you can specify a version override if desired.

7. Detect Run Mode: Select the run mode. If you select Use Airgap Mode, a Detect Air Gap Jar Directory Path field opens in which you must specify the Detect Air Gap Jar Path.

8. Detect Arguments: Here you can include additional Detect arguments; Detect picks up your build environment variables and your project variables. Use a new line or space to separate multiple arguments. Use double quotes to escape. You can use environment and build variables.  For more information on Detect arguments, refer to Synopsys Detect Properties.

9. Detect Folder: The location to download the Detect jar or the location of an existing Detect jar. The default is the system temp directory.  To specify a different directory, type the directory path and name in the field.

Windows agents require an absolute path when specifying detect download location in the Detect Folder field.

10. Add Detect Task Summary: Click this checkbox to add a summary of the Detect task to the build summary task.

###Running the task
After you have configured your task, you can run it as follows.

In Azure DevOps, click Queue, and your task is executed on the next available build agent.

If your task configuration is incomplete, a red status message of Some settings need your attention displays below Run Synopsys Detect for your build.  Missing required settings display in red in the Synopsys Detect panel.

##Release Notes for Synopsys Detect in Azure DevOps

Release Notes Contains information about the new and improved features, resolved issues, and known issues in the current and previous releases.











