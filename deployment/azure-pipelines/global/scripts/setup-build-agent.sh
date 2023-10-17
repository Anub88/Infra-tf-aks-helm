#!/bin/bash

###--- This is a script that has not been tested end to end yet, only snippets have been tested. ---#
###--- There is therefore no guarantee that this works the way it is. ---###

#TODO inject personal access token & Agent name
PAT = "some-passed-value-to-be-changed" # personal access token
AGENT_NAME = "some-passed-value-for-the-new-agent-name"
PYTHON_TGZ = "https://www.python.org/ftp/python/3.9.15/Python-3.9.15.tgz"

# Creates download dir if not existing
DOWNLOAD_DIR = "~/Downloads/"
if [! -d "$DOWNLOAD_DIR" ]; then
  mkdir $DOWNLOAD_DIR
fi

# download build agent and unpack it
wget https://vstsagentpackage.azureedge.net/agent/2.210.1/vsts-agent-linux-x64-2.210.1.tar.gz -P $DOWNLOAD_DIR
mkdir myagent && cd myagent
tar zxvf ~/Downloads/vsts-agent-linux-x64-2.210.1.tar.gz

# Configure the agent
./config.sh << CONFIG
Y
https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform

$PAT
HDP Image Analyzer Application Agent
$AGENT_NAME
.
CONFIG

## Install Python 3.9

# Prepare the installation
cd ~/myagent/_tool/
if [! -d "Python/" ]; then
  mkdir "Python/"
fi

mkdir Python/3.9.15
mkdir Python/3.9.15/x64

# Install packages required for installing and running python
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

# Download python
wget $PYTHON_TGZ -P $DOWNLOAD_DIR
tar -xf $DOWNLOAD_DIR/Python-3.9.1.tgz
cp -a $DOWNLOAD_DIR/Python-3.9.1/. Python/3.9.15/x64

# Install python
cd Python/3.9.15/x64
./configure --enable-optimizations
make -j 12 # This is optimizing the build for 12 cores, can be changes for a faster installation
sudo make altinstall

## Install the other required softwares

cd $DOWNLOAD_DIR

# Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform

# Install azure CLI & Helm

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash

# Install kubernetes

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

# Install docker

sudo snap install docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp - docker
sudo chmod 666 /var/run/docker.sock