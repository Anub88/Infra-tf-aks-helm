# Dockerfiles
Dockerfiles, if they are located in our repository, are scanned w. [checkov](https://www.checkov.io) to detect the following [misconfigurations](https://www.checkov.io/5.Policy%20Index/dockerfile.html):

|FIELD1|FIELD2       |Id        |Type      |Entity                                                                  |Policy    |IaC                                                        |
|------|-------------|----------|----------|------------------------------------------------------------------------|----------|-----------------------------------------------------------|
|0     |CKV_DOCKER_1 |dockerfile|EXPOSE    |Ensure port 22 is not exposed                                           |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|1     |CKV_DOCKER_2 |dockerfile|*         |Ensure that HEALTHCHECK instructions have been added to container images|dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|2     |CKV_DOCKER_3 |dockerfile|*         |Ensure that a user for the container has been created                   |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|3     |CKV_DOCKER_4 |dockerfile|ADD       |Ensure that COPY is used instead of ADD in Dockerfiles                  |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|4     |CKV_DOCKER_5 |dockerfile|RUN       |Ensure update instructions are not use alone in the Dockerfile          |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|5     |CKV_DOCKER_6 |dockerfile|MAINTAINER|Ensure that LABEL maintainer is used instead of MAINTAINER (deprecated) |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|6     |CKV_DOCKER_7 |dockerfile|FROM      |Ensure the base image uses a non latest version tag                     |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|7     |CKV_DOCKER_8 |dockerfile|USER      |Ensure the last USER is not root                                        |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|8     |CKV_DOCKER_9 |dockerfile|RUN       |Ensure that APT isn’t used                                              |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|9     |CKV_DOCKER_10|dockerfile|WORKDIR   |Ensure that WORKDIR values are absolute paths                           |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
|10    |CKV_DOCKER_11|dockerfile|FROM      |Ensure From Alias are unique for multistage builds.                     |dockerfile|https://github.com/bridgecrewio/checkov/tree/master/checkov|
# Images
## At runtime

## At rest
The pipeline responsible for moving container images from the public ACR to the private ACR is conducting the following checks with  **Trivy** and/or **Docker Scan**, depending on the containers os.

- Checking if image runs with root user - > root user not allowed, check docker inspect Config.user, if no user is defined, default is "root" user
- Vulnerability check by Azure Container Registry -> Vulnerabilities visualized in Security Center
- Base images only allowed from trusted parties (Microsoft: aims to have no vulnerabilities in base images older than 30 days)
- Prefered using distroless images: no OS,  just a framework specific environment e.g. Python
- Inspect RUN commands in dockerfile -> docker inspect
- Prefered no volume mounts in dockerfile, especially not allowed to mount sensitive directories like /etc or /bin
- No sensitive data in dockerfile like secrets and credentials, even when docker image layers are removed later on
- Dockerfile should be immutable (including already any AI model dependencies), no loading of AI model during runtime of docker container
- Executables without setuid bit, to avoid privilege escalation

### Trivy (Linux)

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
### Docker Scan (Windows)
