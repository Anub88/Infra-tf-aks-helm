# Feature branches and linking git commits to work items
Feature branches are prefixed with the identifier of the work item to identify the work that has been done in a feature branch to the respective work item like

``xxxxxx_user_story_short_name`` while xxxxxx represents the work item id

Moreover, git commits are prefixed with the identifier of the work item:

commit message: ``xxxxxx my change`` while xxxxxx represents the work item id

In this way, all work artifacts in git are automatically linked to the respective work item in Azure DevOps.
# Acceptance criteria (AC) and Definition of Done (DoD)
User stories contain a list of user story-specific acceptance criteria. The acceptance criteria need to be completely implemented, otherwise a user story can't be considered to be finished. 

The Definition of Done (DoD) is all conditions that must be met for being considered to be ready to be accepted by the owner of the user story. In this way, the DoD can be considered as generic guidelines while implementing a user story (DoD do not need to be explicitly stated as part of each user story).

The following **Definition of Done** is considered to be generic part of each user story and is used by the team as guideline for user story implementation (the Definition of Done sets the scope and quality of implementation of a user story):

- Implementation is completed according to **user story description** and **all acceptance criteria** and is checked into source code repository (merged to develop branch in [mlware git  repository](https://ZEISSgroup-MED@dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_git/mlware-platform))
- New implementation **concepts** are **documented** in the team/code-based wiki and checked into source code repository
- Implementation is **tested** (tests are considered as source code), tests are checked into source code repository, tests have been passed and document the quality of the existing implementation
- Build or source code artifacts (e. g. applications, infrastructure code, automation pipelines) have been **deployed to dev-environment**
- **Code review** has been completed and **comments** from code review have been **addressed**
- Implementation solution has been **presented in iteration review meeting** to show engineering team/business-side/stakeholder-side  completion of implementation

