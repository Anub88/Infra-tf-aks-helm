[[_TOC_]]
# Overview
An agent that you set up and manage on your own to run jobs is a self-hosted agent. You can use self-hosted agents in Azure Pipelines. Self-hosted agents give you more control to install dependent software needed for your builds and deployments. Also, machine-level caches and configuration persist from run to run, which can boost speed.

# Requirements before executing the steps below
A self hosted build agent runs on a virtual machine in azure. Therefore, the virtual machine must be there before executing the following steps. You can check in the portal wether this machine exists. 

On top of that, an ssh connection needs to be established. For that, make sure that: 
- The VM has a public IP address
- The VM has a rule to allow any connection from port 22 (add a rule with your IP address in the portal)
- Your public key is published to the VM

# Self Hosted Build Linux Agent

## How to install, configure and add self-hosted agent in Azure DevOps 
Prerequisites:
>> - One active Azure DevOps account
>> - Personal Access Token (PAT)
>> - Linux instance where you will host the self-hosted agent

 - Step 1: Login to Azure DevOps portal and click on “Organization settings”
    https://dev.azure.com/<Your_Organization_Name>/_settings/organizationOverview
 - Step 2: Navigate to Pipelines > Agent pools and click “Add pool”.
- Step 3: From the “Pool type” drop-down select “Self-hosted”, provide a name and description and click “Create”.
- Step 4: Click on the newly create pool and then click on “New agent”.
- Step 5: Select the OS and architecture and copy the download link.
- Step 6: Install self-hosted agent on your system.
- Step 7: Login to virtual machine
- Step 8: Create a new directory and get inside the directory
**mkdir myagent && cd myagent**
- Step 9: Get the latest Azure self-hosted agent package
**curl -o vsts-agent-linux-x64-2.194.0.tar.gz \\ -L https://vstsagentpackage.azureedge.net/agent/2194.0/vsts-agent-linux-x64-2.194.0.tar.gz**
 - Step 10: Extract the Azure self-hosted agent package
**tar zxvf ./vsts-agent-linux-x64-2.194.0.tar.gz**
- Step 11: Configure and add self-hosted agent for Azure DevOps.
**./config.sh**
>>>- Enter (Y/N) Accept the Team Explorer Everywhere license agreement now? (press enter for N) > Y
>>>- Enter server URL > https://dev.azure.com/<your_organization_name>
>>>- Enter authentication type (press enter for PAT) >
>>>- Enter personal access token > ****************************************************
>>>- Enter agent pool (press enter for default) > mypool
>>>- Enter agent name (press enter for ip-172-31-41-155) > myagent
>>>- Enter work folder (press enter for _work) >.
- Step 12: Install the self-hosted agent as service
**sudo ./svc.sh install vmadmin**
- Step 13: Start the self-hosted agent
**sudo ./svc.sh start**
- Step 14: Get the status of self-hosted agent
**sudo ./svc.sh status**

## Install python3.9 on the build agent
Microsoft build agents currently only supports python version 3.8 In order to run python 3.9 on a self-hosted agent, it must be installed as described [here](https://learn.microsoft.com/en-gb/azure/devops/pipelines/tasks/tool/use-python-version?view=azure-devops#how-can-i-configure-a-self-hosted-agent-to-use-this-task). Here are the steps that needs to be done:

1. Connect to the build agent via SSH
2. Navigate to the tools cache folder. Should be `~/myagent/_tool/`
3. Create a `Python/3.9.<whatever-version-is-needed>/x64` folder.
4. Install python using apt as described in this blog post: https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/#installing-python-39-on-ubuntu-with-apt
5. Make sure that `python3` has a sym link to your installed version (this can be checked with `python3 --version`).
6. If that's not the case, remove the current symlink: `cd /usr/bin` and `unlink python3`
7. And create a new one pointing to your installation: `ln -s ~/myagent/_tool/Python/3.9.14/x64/python python3`


### Troubleshooting
Here are some issues that might raise when installing python 3.9
#### **No compiler found error**
If you get the following error while installing python:

```
configure: error: no acceptable C compiler found in $PATH
```

You can install the C complier with `apt-get install build-essential` as suggested in this thread: https://stackoverflow.com/questions/19816275/no-acceptable-c-compiler-found-in-path-when-installing-python

#### **Pip SSL error**
If you get the following error installing a package with pip:
```
pip is configured with locations that require TLS/SSL, however the ssl module in Python is not available
```

Then install the additional packages with:
```
sudo apt install libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev libtk8.6 libgdm-dev libdb4o-cil-dev libpcap-dev

```
And rebuild python with from your python folder:
```
cd ~/myagent/_tool/Python/3.9.14/x64
./configure
make
make install
```
like suggested [here](https://stackoverflow.com/questions/45954528/pip-is-configured-with-locations-that-require-tls-ssl-however-the-ssl-module-in/49696062#49696062?newreg=889a656d38ca44bea2d418851a6f0aa1)
## Install Required Packages on the Agent
Now that the agent is up and running, it needs some packages to be installed:

- Terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli
- AzureCLI: https://docs.microsoft.com/de-de/cli/azure/install-azure-cli-linux?pivots=apt
- Helm: https://helm.sh/docs/intro/install/
- Kubetcl: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- Docker
   sudo snap install docker
   sudo groupadd docker
   sudo usermod -aG docker $USER
   newgrp - docker
   sudo chmod 666 /var/run/docker.sock

# Self Hosted Build Windows Agent

## How to install, configure and add self-hosted agent in Azure DevOps 
**Configuring Pre-requisites:**

>>>- Install Azure CLI and Terraform on your local machine
>>>- If you are using Visual Studio Code as your editor ensure you have the Terraform extension installed.
>>>- If required, Connect to virtual machine page, select RDP, and then select the appropriate IP address and Port number. In most cases, the default IP address and port should be used. Select Download RDP File. If the VM has a just-in-time policy set, you first need to select the Request access button to request access before you can download the RDP file. For more information about the just-in-time policy, see Manage virtual machine access using the just in time policy.
>>>- To allow Terraform to access Azure create a password-based Azure AD service principal and make a note of the appId and password that are returned.
>>>- Create a new Agent Pool in your ADOS subscription
>>>- Create a PAT in your ADOS subscription limiting it to Agent Pools (read, manage) scope.
