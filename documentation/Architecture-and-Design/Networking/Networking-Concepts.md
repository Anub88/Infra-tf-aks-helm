## Network Topology
The network topology tries to separate different solution concerns and (therefore) different security concerns, using network-level isolation (VNets, Subnets). There three main different solution concerns covered in the MLware solution:
- ML Workspace: ML Workspace covers cross-cutting (shared) concerns and is the entry point (hub) into MLware platform.
- ML Inference: ML Inference covers model, data, and prediction aspects during runtime. 
- ML Training: ML Training covers model creation, training data management, and validation, model registration aspects.

### Hub-and-spoke Architecture
The MLware solution design follows a hub-and-spoke architectural design, being composed of the following VNets:
- Hub VNet: ML Workspace VNet - could potentially include site-to-site connectivity (Azure, Meditec on-premise)
- Spoke VNets:
    - ML Inference PROD
    - ML Inference DEV
    - ML Training

![solution_design_hub_and_spoke.svg](../.attachments/solution_design_hub_and_spoke.svg)

## IP Address Ranges
IP address ranges assigned to MLware Azure VNets should not overlap with existing (potentially peered) Azure VNets of other Meditec initiatives, including on-premise networks. 

[To Do] IP range alignment with overall enterprise network planning

## VNet and region-focused network design
Each solution concern is segregated within its own VNet setup: An Azure resource that belongs to the same solution concern is associated with the same VNet. This segregation even enables specific regional deployments (based on VNet segregation).

## Virtual Private Networks
In a future case, Azure cloud to Meditec connectivity could be established, whereas the hub VNet (see ML Workspace) could be leveraged to create a VPN-based connection.

[To Do] Double check if an Express Route based connectivity is already available.