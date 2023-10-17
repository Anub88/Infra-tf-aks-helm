[[_TOC_]]

This page serves to persist the discussion points in alignments of the AIXS devs and the security team.


# 13.12.2022
---
New Threats: 
- JSON deserialization attacks
- Misconfigured authentication (HDP)
- Unencrypted Temp. Storage

![image.png](/.attachments/image-f3f939c4-49f3-4aaf-9a14-37beeab12448.png)
![image.png](/.attachments/image-6ab34264-5c6f-46c3-8789-f08dcd79de54.png)
For very specific cloud security issues Nagaraj, Rajesh <rajesh.nagaraj@zeiss.com> is the relevant person (Cloud Security Architect).

# 05.12.2022
---
Next Meeting: Focus on API Security

Measures/Todo
- Restrict to CIS pre-hardened images for Linux & Windows
- Scan tools: checkov, trivy, blackduck, coverity
- Use IRIUS Recommendations as config baseline for componentes
- Sidecar API Definition -> API Security
- Mechanism to ensure comm via sidecar w. single specific storage instance (HDP or else)
- Collect best practices for windows containers
- Container Monitoring -> Sentinel to detect network anonmalies
- Container Monitoring -> Detect anomalous resource usage (Anomaly Detector)
- Sidecar should monitor failed access requests

Clarify:
- Manage/restrict resource usage of model pods/containers
- Sidecar - WAF/Defender ?
- Restrict pod-pod comm.


Additional Threats:
- Python supply chain attacks
![Screenshot from 2022-12-05 16-53-45.png](/.attachments/Screenshot%20from%202022-12-05%2016-53-45-e2bcfeac-f1ad-458a-863b-08289de935d7.png)

# 29.11.2022
---
- Dev Resourcen nicht ins Produkt, festgehalten als Requirement z.B. "Dev Umgebung muss sicher konfiguriert sein" und wird im IriusRisk mit modelliert
- Architektur Konzept: Die AIXS Platform soll als reine "Compute" Platform zugelassen werden. Ohne spezifische Container (bzw. den Models/Applikationen die in Containern laufen), diese liegen in der Verantwortlichkeit des Erstellers des Containers.
 - D.h. zentrale Sicherheitsfrage is wie gehen wir mit Containern um über die evtl. wir keinerlei Kontrolle haben und nicht wissen welcher Code in ihnen ausgeführt wird
- Zijo reviewed die Countermeasures für AKS/Keyvault/APIM/VNets/ACR -> Required/Rejected/Recommended etc.
- Wir setzen auf Konfigurationsebene Countermeasures für die gesetzten Komponenten aktuell um (Bsp. Nur HTTPS erlauben)
- Threat Modeling für das "große Ganze" macht erst sinn wenn das Architekturbild stabil ist.
- Zijo & Julian erarbeiten in regelmäßigeren extra Meetings jetzt schon das Sicherheitskonzept für AKS/K8S/POD/Container