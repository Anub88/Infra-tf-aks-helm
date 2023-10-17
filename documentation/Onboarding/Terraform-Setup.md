

## Running Terraform locally

- Find the infrastructure pipeline where the tf command is run that you want
- Copy it (`tf init` and `tf plan`) and remove the client_id and client_secret vars

Example:
`terraform init -backend-config=storage_account_name=stbackendtfdatashared -backend-config=container_name=tf-state-container -backend-config=key=st-tf-shared-weus.tfstate -backend-config=resource_group_name=rg-backend-shared-weus-infra -backend-config=subscription_id=1fb500bc-6cb9-4087-97f0-8cc28b82ae40 -backend-config=tenant_id=82913d90-8716-4025-a8e8-4f8dfa42b719`


## Linting with [tflint](https://github.com/terraform-linters/tflint)
TFLint is a framework and each feature is provided by plugins, the key features are as follows:
- Find possible errors (like invalid instance types) for Major Cloud providers (AWS/Azure/GCP).
- Warn about deprecated syntax, unused declarations.
- Enforce best practices, naming conventions.

A `.tflint.hcl` config file is located in the infrastructure root folder.
Run tflint --init after installation in the infrastructure root folder.

Then do `tflint -c .tflint.hcl shared`  to lint a subfolder.
