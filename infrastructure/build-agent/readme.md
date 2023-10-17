# Build Agent module.

This set of terraform modules contain the specs for the deployment of our self-hosted build-agent to run azure pipelines.

### Submodules

```
modules
│   az-network -> Networking setup for the build-agent.
│   key-vault -> Vault to store credentials.
│   linux-vm -> Linux virtual machine related resources.
│   public-acr -> Public ACR to enable users to push docker images.
│   recovery-vault -> Backup and recovery related resources.
│   windows-vm -> Windows virtual machine related resources.
```

### Self Hosted Build Agent
An agent that you set up and manage on your own to run jobs is a self-hosted agent. You can use self-hosted agents in Azure Pipelines. Self-hosted agents give you more control to install dependent software needed for your builds and deployments. Also, machine-level caches and configuration persist from run to run, which can boost speed.

### How to install, configure and add self-hosted agent in Azure DevOps?
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
