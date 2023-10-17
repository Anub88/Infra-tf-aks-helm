[[_TOC_]]
# Container and AKS Security
Containers are made from images, images built from a definition in a Dockerfile.
Registries distribute Images. 
Since running containers involves a lot of components, from the linux kernel to application code, securing the system can never be focused on one component alone. A _defense-in-depth approach_ is suited best. 

Useful Sources:
- [Azure Defender for Containers](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction)

## Strategy
To secure our platform from a container perspective security mitigations are applied at different levels:
- Registry Configuration

TODO: Describe each point in a bit more detail here
- Image Scans
- Image definition (Dockerfile)
- Pod security
- AKS Worker Node Configuration
- Kubelet Configuration
- Kubernetes Configuration
- AKS specific Configuration (RBAC, CNI, etc.)
- Network layer (AKS VNet)
- Architecture Design
- Update Management

## Pre-defined Configuration Guidelines
For many of the points above guidelines/benchmarks exist that describe which configuration should be used from a security perspective. The following sources are used:

- _[CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)_
- _[IRIUS RISK]()_
- _[Checkov]()_
- _[Trivy](https://aquasecurity.github.io/trivy/v0.29.2/)_
- _[Container Security Checklist](https://krol3.github.io/container-security-checklist/)_
- _[OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)_
- _[Kubernetes](https://kubernetes.io/docs/concepts/security/security-checklist/)_

## General Security Considerations

- Keep the image as minimal as possible.
- When building an image with a given tag built it without cache to ensure all layers are freshly made.
- Similarily, an image should be rebuilt when its base images are updated.


## Container Hardening
- Do not use root in the container
- Keep host kernel and the docker/oci runtime up to date
- Consider using user namespaces

## Image Scanning
### Trivy (Linux Hosts)

```bash
# create a role with AcrPull permission for the registry
export SP_DATA=$(az ad sp create-for-rbac --name TrivyTest --role AcrPull --scope "/subscriptions/1fb500bc-6cb9-4087-97f0-8cc28b82ae40/resourceGroups/rg-mlw-dev-weus/providers/Microsoft.ContainerRegistry/registries/acralgomlwsdevweus")


# must set TRIVY_USERNAME empty char
export AZURE_CLIENT_ID=$(echo $SP_DATA | jq -r .appId)
export AZURE_CLIENT_SECRET=$(echo $SP_DATA | jq -r .password)
export AZURE_TENANT_ID=$(echo $SP_DATA | jq -r .tenant)

# scan a specific image
docker run -it --rm -v /tmp:/tmp\
  -e AZURE_CLIENT_ID=${AZURE_CLIENT_ID} -e AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET} \
  -e AZURE_TENANT_ID=${AZURE_TENANT_ID} aquasec/trivy image acralgomlwsdevweus.azurecr.io/oct_image_analyzer:1.0.0.16
```


## Update Management
Images need regular security updates / patches. A process must be put into place to deal with that.

See [Update & Patch Management](/Security-&-Reliability/Container-Security/Vulnerability-&-Patch-Management)

## Supply-chain attacks

# Understanding the Attack Surface
![Liz Rice Container Threats](/Security-&-Reliability/.attachments/container_hardening/container_threats_liz_rice.png)
## Linux Kernel
## runc, containerd


