# Dockerfile: installs Docker, all needed requirments and runs the integration tests

# to test this dockerfile locally: uncomment lines with '#ARG PATkey' and 'RUN python3 -m pip install'
# and comment line 'RUN pip config ...' and the next one
# at build provide your PAT, ex: docker build --no-cache -t docker_integration_tests_image . --build-arg PATkey=Your-PAT --build-arg  BehaveTags=runall --build-arg Environment=stage
# and run with: docker run --name docker_integration_tests  docker_integration_tests_image
# copy folder to host with: docker cp docker_integration_tests:intgr_tests .

FROM python:3.9


# Personal access token to authenticate against Azure DevOps package management (Artifacts)
#ARG PATkey

ARG BehaveTags
ARG Environment
ARG INDEX_URL
ARG ContFolder
ARG ContFolderReports


ENV ENV_STATE=$Environment
ENV PIP_EXTRA_INDEX_URL=$INDEX_URL
ENV BEHAVE_TAGS=$BehaveTags
ENV CONT_FOLDER=${ContFolder}
ENV CONT_FOLDER_REPORTS=${ContFolderReports}


WORKDIR /${CONT_FOLDER}

#
# Install docker 20.10.8 and show docker version
#

RUN echo "Docker Installation"  
RUN apt-get update -qq && apt-get install curl -y
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
RUN echo "Docker Version: "  \
    docker --version

# copy requierments from host to container image
COPY ./requirements.txt /${CONT_FOLDER}/requirements.txt

#
# Install dependencies
#

#RUN python3 -m pip install -r /intgr_tests/requirements.txt --index-url=https://mlware-python-feed:$PATkey@pkgs.dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_packaging/mlware-python-feed/pypi/simple/
RUN pip config set global.extra-index-url "$ENV:ENV_EXTRA_INDEX_URL"
RUN python3 -m pip install -r /${CONT_FOLDER}/requirements.txt 

# copy the host folder integration_tests into the container 
COPY . /${CONT_FOLDER}

COPY ./runTests.sh /${CONT_FOLDER}/runTests.sh
RUN chmod 777 /${CONT_FOLDER}/runTests.sh 



CMD ["/bin/sh", "-c", "/${CONT_FOLDER}/runTests.sh ${ENV_STATE} ${BEHAVE_TAGS} ${CONT_FOLDER} ${CONT_FOLDER_REPORTS}"]