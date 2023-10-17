[[_TOC_]]

## Architecture Decisions
This section tracks the architectural, design, and technological decisions taken to build the MLware and AI-backend solution.


<span style="color:green">
--- Template section start ---
</span>

## Template Section

### Decision Record

#### Decision Summary

#### Status and Stakeholder
proposed, accepted, rejected, deprecated, superseded / (month/year)

#### Context
What is the issue that is motivating this decision?

#### Decision
What is the change proposed?

#### Consequences
- What becomes easier or more difficult?
- Who are the affected stakeholders?

<span style="color:green">
--- Template section end ---
</span>

### Decision Record 1

#### Status and Stakeholder
accepted (March/2022) by:
- Head of AI
- Solution Architects

#### Decision Summary
**Azure cloud-native implementation of the solution design** 

#### Context
For implementing the proposed solution design and concepts of a AI backend, a technological choice has to be taken. Considerations taken into account:
- the AI backend solution needs to serve international (med-regulated) markets
- the AI backend solution requires to serve high-end compute (machine learning as compute-heavy processing) and storage (redundancy, protection) demands
- the maintenance and operational footprint of the AI solution should be low, with respect of serving many different AI solutions on the same platform


#### Decision
Since Microsoft Azure is strategic partner of Carl Zeiss Meditec, a sustainable way of covering the context requirements is to leverage Azure cloud-native (and managed services) offerings. In this context, the MLware solution becomes part of the bigger HDP initiative (Azure cloud-hosted).

#### Consequences
- Single-cloud strategy: Binding the solution design implementation to one single cloud provider
- Leveraging the benefits of a cloud-native approach, especially when considering operational efficiency, scalability/elasticity, business continuity and disaster recovery 

### Decision Record 2

#### Status and Stakeholder
accepted (April/2022) by:
- Head of AI
- Product Owner
- Program Manager
- Development Team
- Solution Architects

#### Decision Summary
**Framework for AI-backend application code implementation: Python framework selected**

#### Context
For application code development for MLware solution (AI backend), a framework needs to be selected. Two frameworks are considered as candidates for application code development: Python (default framework in AI/ML context) and .NET C# (several team members have previous experience with .NET C#):
- Python is considered to be a default framework to be re-used in MLOps/data science context, because of being the default framework for data science related implementations (training and inference).
- Python is considered to be a default framework for automating (scripting) devops automation pipelines.
- Python is considered as common denominator for data science, application development and devops automation activities providing a shared framework all experts in the development team can understand and implement (supporting a devops mindset/culture within the team)
- Python is the predominant framework in data science and a good candidate for CI/CD pipeline automation and application development in AI/ML contexts
- .NET C# is a candidate framework, since the current development team has most experience and broadest skills in .NET and would implement most efficiently using that framework.

Selecting only one framework (Python or .NET C#) for application development is prefered, since this reduces maintenance and operational overhead and facilitates the knowledge sharing and devops mindset within the development team.

#### Decision
The long-term decision is to select Python as only framework for application code development (backend applications) because of the AI/ML context (MLware backend and solution is a ML platform for creating, hosting and executing ML applications) and technical solution provided in that problem space. The arguments for selecting Because of some team members lacking Python framework competencies, a temporary selection of .NET C# for application implementation (backend) is acceptable, until Python competencies have been ramped-up within the development team.
Short Term Steps: Identfy the application components  that are required to be developed for supporting Basic Care business use cases and development to be  based on .NET framework. 
Long Term: The entire application to be based on Python framework  and any rework necessary to re-write the  components already written in .NET framework to be  undertaken.
#### Consequences
- Advantage: Selecting Python as AI-backend framework for application code creates the potential to re-use application code within AI/MLOps contexts, without re-writing efforts (switch from .NET to Python implementation)
- Disadvantage: The implementation efficiency and quality of the application development might be not on par with a pure .NET C# implementation because of lack of experience with Python framework.

### Decision Record 3

#### Decision Summary
Selecting an integration and system testing framework for quality assurance of MLware platform components and their integration. **The selected framework is Python** [behave](https://behave.readthedocs.io/en/stable/) **for specifying and implenting those tests.**

#### Status and Stakeholder
accepted decision (07/2022)

- QA representatives
- Engineering Manager
- Engineering/developer representatives
- Program Manager
- Product Owner
- Solution architect

#### Context
The team responsible for developing the MLware AI/ML platform needs to ensure a high-quality of the integrated components of the platform. For this purpose a concrete framework needs to be selected for implementing platform integration and system tests. In this way, the platform team could ensure a reliable check of the quality of the platform even when introducing changes.

#### Decision
Since the main application framework is Python (context: AI/ML platform), the team has selected an integration framework that is based on Python to ensure compatibility with application and platform code. 
Moreover, a framework that supports BDD/BDT (Behavior-Driven-Development and Testing) was selected since the team expertise is fine-grained and distributed across engineers, QA-engineers, product owner, management, etc. and requires that potentially all team members could understand and specify integration tests. Therefore, [behave](https://behave.readthedocs.io/en/stable/) hase been selected as BDD Python framework that covers these concerns.
The tests specified within this framework need to be automatically executed regularly, latest when system changes are introduced using Azure DevOps pipelines.

#### Consequences
- The QA and engineering team members are going to use Python behave for specifying and implementing integration and system tests. In general, the testing framework is open to be used by anyone who has a stake in the MLware platform. 
- The framework and proposed solution is light-weight and generic, and therefore easily applicable in many technical integration testing contexts
- The integration and platform tests are understandable by all stakeholders which increases acceptance of this framework
- The integration tests themselves are part of the source code and therefore serve the purpose of documenting the quality of the MLware platform 