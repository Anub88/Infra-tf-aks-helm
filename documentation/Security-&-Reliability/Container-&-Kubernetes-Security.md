# A Platform Security Challenge

[[_TOC_]]


The unique security challenge we face is that many security threats arise in the inner layers of our platform. Meaning in the AI model containers that will be deployed in AKS and are running there. 

In essence we have to assume that in these containers **arbitrary code** can be executed.
Under this assumption we have to guarantee the following:

- Malicious entities in one container cannot affect other containers in any way. The should have no measurable influence on other containers performance, should not be able to access other containers data and so on.
- Malicious entities in one container are prevented from propagating to any other layer of the platform outside the container itself
- Malicious entities in one container cannot abuse/drain platform resources 

For these reasons a _defense-in-depth_ approach, where every layer is secured as best as reasonably possible, is suited best. 

<center>

![Container Security Layers](/Security-&-Reliability/.attachments/container_layer_security.png =500x)
</center>

## Container and AKS Security
Containers are made from images, images built from a definition in a Dockerfile.
Registries distribute Images. 
Running container in kubernetes involves the image, a container runtime, a container runtime interface (CRI) and so on. A lot of components are evolved and securing the system can never be focused on one component alone.
<center>

![Container Layers](/Security-&-Reliability/.attachments/container_layers.png =550x)

</center>



<center>

![Liz Rice Container Threats](/Security-&-Reliability/.attachments/container_hardening/container_threats_liz_rice.png =550x)

</center>



# Configuration Guidelines & Checklists

For most of these layers  guidelines/benchmarks exist that describe which configuration should be used from a security perspective. The following sources are used:

- [OWASP Docker Security](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)
- [Docker Security Documentation](https://docs.docker.com/engine/security/)
- _[CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)_
- _[IRIUS RISK]()_
- _[Checkov]()_
- _[Trivy](https://aquasecurity.github.io/trivy/v0.29.2/)_
- _[Container Security Checklist](https://krol3.github.io/container-security-checklist/)_
- _[OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)_
- _[Kubernetes](https://kubernetes.io/docs/concepts/security/security-checklist/)_
- [Azure Defender for Containers](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction)

# Strategy
To secure our platform from a container perspective security mitigations are implemented at different levels.


### Container Layer
To simplify the task of creating, from a security pov, optimally configured  containers we resort to using pre-hardened container images. See [Container Security](/Security-&-Reliability/Container-&-Kubernetes-Security/Linux-&-Windows-Container-Security) for details.


### Azure Container Registry Configuration
See [Container Registry Configuration](/Security-&-Reliability/Container-&-Kubernetes-Security/Azure-Container-Registry).
### Scanning
Scanning images w. for security vulnerabilities and misconfigurations is done when images are coming into the platform and while they are running. See [Scanning](/Security-&-Reliability/Container-&-Kubernetes-Security/Scanning).
### Host configuration
Since we are using Kubernetes on Azure, AKS, there are not alot of options to configure the underlying host operating system.
### AKS specific Configuration (RBAC, CNI, etc.)

### Kubernetes, Kubelet, Worker Node & Pod Configuration
### Monitoring
Todo: Sentinel policies to detect threats, anomalies etc.
<IMG  src="https://techcommunity.microsoft.com/t5/image/serverpage/image-id/211948i493AD453DBCE7C8C"  class="n3VNCb KAlRDb"  alt="Monitoring Azure Kubernetes Service (AKS) with Microsoft Sentinel -  Microsoft Community Hub" style="width: 545.926px;height: 454px;margin: 0px"/>

### Network layer (AKS VNet)
### Architecture Design
### Processes
_Updates_

Images need regular security updates / patches. A process must be put into place to deal with that.
See [Update & Patch Management](/Security-&-Reliability/Container-&-Kubernetes-Security/Vulnerability-&-Patch-Management).

_Vulnerabilities_




## General Security Considerations

- Keep the image as minimal as possible.
- When building an image with a given tag built it without cache to ensure all layers are freshly made.
- Similarily, an image should be rebuilt when its base images are updated.


## Container Hardening
- Do not use root in the container
- Keep host kernel and the docker/oci runtime up to date
- Consider using user namespaces




