# Infrastructure CICD redesign.

### Issues.

The following pain-points have been found:

- There is no link between pipeline run and PR, therefore setting PR gates based on pipeline status is not possible.
- The pipeline has to be run manually outside of the scope of the PR.
- We have to manually provide 2 parameters: environment and state, this is error prone and cumbersome.
- There is no easy way to track which is the last pipeline run for a given set of changes given that also a pipeline run only plans and applies one state of the multiple states we manage.
- There's no single source of truth to know which code is deployed in which environment, terraform apply is not enforced on merge. This leads to stale states with unapplied changes in version control.
- We ideally have more tight control on what goes into environments like production and how and when its deployed. The current setup is error-prone and could lead to human error. 

Main questions to answer?

- How do we enforce effective PR checks?
- How do we automate CI/CD and remove as many manual steps as possible?
- How do we know which code is deployed in each environment and make sure its consistent? 

# General Proposal

### Change rollout sequence:

- Rework CI pipelines to be able to have effective PR checks and run all plans at once.
- Implement tagging mechanism and deploy on push to branch rather than manual deploy.
- Implement check to verify that the previous environment has been also deployed on the last pushed commit.

### Branches.

Principle: A branch status should reflect the state of a given environment. 

Restricted branches enforce 1:1 mapping between code and infrastructure, on unrestricted ones there could be code deployed to the environment that is not merged into the branch. 

* main: `--restricted`
  * Associated environment -> prod
    * Code can only be merged if tests pass, tests from stakeholders pass, comments are resolved and plan has been applied
    * Changes will be applied when the PR is merged.
* stage: `--restricted`
  * Associated environment -> stage
    * Code can only be merged if tests pass (internal testing team), comments are resolved and plan has been applied.
* qa: `--restricted`
  * Associated environment -> qa
    * Code can only be merged if it runs on dev, comments are resolved and plan has been applied.
* feature_branch: `--unrestricted`
  * Associated environment -> dev
    * Changes can be applied before to dev environment before the PR is merged.

![image.png](/.attachments/image-f0b2693f-8644-4701-89da-388d1d9ad091.png)

### Environments.

* **prod**: 
  * This environment will serve the production version of our platform. 
* **stage**:
  * stage will contain pre-release features and be available for users of our platform to also try out integrations in a non-productive environment. Code that is deployed into this environment should be throughly tested and approved.
* **qa**:
  * qa contains features that have been approved but still need testing and hardening. Code that is deployed into this environment should be tested and approved.
* **dev**:
  * dev contains experimental and in-progress features that developers need to deploy in order to try out and test ideas. Code that is deployed into this environment is neither necesarilly approved nor tested.
  * How do I know what is the current state of the dev enironment?
    * Good question!: When running a CD pipeline to completion as one step we would lightweight tag the commit with a version+timestamp+environment_name.
      * For example I was working in a feature branch xyz, at some point I want to try out my IaC so I run a pipeline that changes the terraform state, this pipeline will create a tag on my feature branch commit like `utctimestamp_dev_branchname`.
      * Then, I can map the latest state of the dev environment to the respective commit.
      * If I need to reset changes, I simply run the pipeline on the development branch at the commit I want to go back to.

### Pipelines.

There will be just one pipeline for all our terraform code, across all states.

Pipeline flow:
* The plans are run in parallel if possible.
* Apply is ran in sequential order (if plan is present) according to the dependency relationships between states (which should be respected).
  * When should this step run? See [Releases.](#releases)

Main pipeline:
* Trigger rule: PR created targeting qa, stage or main.
* Requires a 3rd persons approval to run the Deploy stage (apply).
* Infers the environment from the target branch.

Dev pipeline:
* Trigger rule: Manual trigger from the DevOps portal.
* Requires an approval to run the deploy stage but can be self-approved.
* The target environment is dev.

### PRs.

*PR Checks.*

We can consider the following checks:
* Pipeline check: associated pipelines pass.
  * CI checks: plan, tests, etc pass.
  * CD checks: deployment successful. 
* Comments resolved: all discussions are resolved.
* PR approval: all required approvals are provided.

We can now consider the following two configurations:

* *deploy on merge*: the deployment is done on-push to the target branch, meaning after I merge the pipeline runs and deploys.
* *deploy on approval*: the deployment is a prerequisite to be able to merge, meaning after all is approved I deploy to target env, then I merge.
  * This can be the preferred way since we make sure that the deploy went well before introducing changes to the target branch.

The preferred mode for automated deployment is: deploy on approval.

* We want to have consistency between the code that is integrated into a branch and the infrastructure that is deployed in its associated environment.
* A situation in which we merge and then a deploy fails would be undesired because: The code could only fail on apply (tf data source failing for example), the broken code could be grabbed by another developer for a feature branch, the broken code would be polluting terraform plans from PRs in progress that want to push code as well.

So the flow would be: create your PR, associated infra CI pipeline runs and plans with a deploy (apply) step waiting on approval, reviewers leave comments and these are adressed, once the plan and code looks good the apply step is ran. If the apply step is ran succesfully then merging is allowed.

### Releases.

Build number tagging schemes have been outlined [in this PR](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_git/mlware-platform/pullrequest/50374).

Tagging:
- Tagging will be done on deploy to the different environments.
- When deploying to qa: generated tag on merge: `M.m.p.timestamp.env`
- When deploying to stg: version must be bumped, generated tag: `M.m.p.timestamp.env`
- When deploying to prod: version must be bumped, generated tag: `M.m.p.timestamp.env`


### References.

* https://devops.stackexchange.com/a/13082