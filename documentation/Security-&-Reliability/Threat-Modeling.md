
# Overview
The security threat modeling serves as analysis of potential threats of the MLware platform and AI backend. It serves to improve the level of security of the solution design by deriving mitigation strategies for identified threats and risks.

Questions that are relevant:
- How does the technical solution look like?
- From security perspective: What could potentially happen?
- What could be done to mitigate the potential threat?
- How does the overall solution need to be evaluated from security perspective?

Refer to the [Threat Modeling Manifesto](https://www.threatmodelingmanifesto.org) or the [OWASP Threat Modeling Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html) for a general overview of Threat Modeling.

## Zeiss Requirements

Results from our initial meeting (22.07.2022):

- Irius Tool used from October onwards
- Til then continue in the wiki, 
- Use STRIDE, draw.io diagrams
- Cover as many scenarios as possible

# The Thread Modeling Process
A structured approach to threat modeling, independent of the used methodology, mostly includes the following steps:

### Model/Decompose the Application

The goal is to identify and understand all **elements** in the system and how they **interact** with eachother.
Among these are the **assets of interest**: Elements that are relevant for threat modeling.


### Vulnerabilities and Threats

Based on the assets identified in the previous step the potential weaknesses and **vulnerabilities** of the system should be identified. STRIDE or PASTA are methodologies are associated methodologies.
**Threat Actors** are useful for describing specific attack scenarios.
To rank the security risk for each threat risk-models, e.g. DREAD, can be utilized.

### Mitigations and Countermeasures

Each vulnerability/threat can be mapped to a mitigation that describes how the threat was dealt with. This includes an argument which countermeasures are taken, or not taken, for what reasons.

# Relevant areas

- MLware platform security: networking, security boundaries
- OCI container security
- Multitenancy
- Mitigation: Implementation of the least privilege principle

# Analysis

## System Analysis
- Modeling using threat actors, actors, resources to protect, and interaction between actors and resources

### Cloud Assets
- Storage
- Compute for AI inference
- Vaults
- Registries
- Microservices with business logic
- Communication resources like buses and brokers
- (Virtual) network infrastructure
- CI/CD resources like build agents
- Jumphost

## Data Classification
Data that is stored and processed on the MLware platform needs to be evaluated based on the impact if data gets compromised.

Classification levels of data protection requirements:
- low: low impact when compromised (e. g. public IP addresses)
- medium: moderate impact when compromised (e. g. personnel information or system resource details)
- high: high impact when compromised (e. g. secrets to the data storage, client-specific inference results)

# Mitigation
About risk management and potential risk handling alternatives:
- avoid risk
- mitigate risk
- transfer the risk
- accept the risk
