# AKS Security
Kubernetes is a complex piece of software that requires broad security considerations. The [threat matrix for Kubernetes](https://www.microsoft.com/en-us/security/blog/2020/04/02/attack-matrix-kubernetes/) provides an overview of different attack vectors.

![AKS Threat Matrix](https://www.microsoft.com/en-us/security/blog//wp-content/uploads/2020/04/k8s-matrix.png)



Cluster Isolation
--- 
---
Since our cluster should be able to run applications/ml-models from different customers multi-tenancy is an issue.
Resources and workloads must be strictly isolated to 

Cluster Security
--- 
---




Pod Security
--- 
---


Container image security
---
---


Authentication & Authorization
---
---




TODO MOVE 

The following configuration are applied to AKS:

- Authorize IP ranges for the AKS API defined
- Dashboard disabled
- Cluster Monitoring enabled
- Defender for AKS enabled
- Private Clusters enabled
- Disk Encryption enabled
- AKS local admin account disabled
- AKS in VNet, non public
- Azure policy add-on installed