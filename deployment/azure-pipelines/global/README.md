# Infrastructure pipelines.

The following pipelines are defined:

* mlware-infra-deployment-dev.yaml
  * This pipeline plans and deploys changes to the dev environment. Used from feature branches as source.
  * Trigger rule: Manual, optional on PR context.
* mlware-infra-plan-{{env}}.yaml 
  * This pipeline checks the terraform code and plans for all states.
  * Tigger rule: PR pointing to main branch.
* mlware-infra-release.yaml
  * This pipeline checks out the code plans for all states and deploys in the environment order only with manual approval, tags commit after deploy (not implemented yet).
  * Trigger rule: release branch.


### Templating.

Templates are setup following the step/job/stage structure, this improved clarity and clearly shows where the different components can be introduced in any pipeline.

* Suffix templates with `-template`.
* Keep naming short and clear.

### Release and trace tagging

In order to match infrastructure state with the actual code configuration and we use release tagging, each time we make a new release to an environment the last ste after having released all states is to tag the commit accordingly.

As well when we deploy a state but still not release the complete set of states, we also tag in order to have traceability since its possible to only deploy a subset of states. This is done for all deployments on all environments.

- Complete release tags:
  - `environment` > `{timestamp}_{release_branch_name}`
  - E.g: `prod/20220404114444_release_0.1.1`
- Tracing tags: 
  - `tracing` > `environment` > `state_name` > `{timestamp}_{release_branch_name}`
  - E.g: `tracing/dev/mlware/20220404114444_my_new_feature`