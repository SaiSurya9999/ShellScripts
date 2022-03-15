#!/bin/bash
# Run this script only on master
# Configuring Kubernetes using KOPS method

aws s3 mb s3://kubernets.telivic.com

export KOPS_STATE_STORE=s3://kubernets.telivic.com

# Installing KUBECTL
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Installing KOPS
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops

# Generating SSH Keygen
echo "Generating SSHKEYGEN please accept all default values..."
ssh-keygen

# Moving KOPS and KUBECTL to the executable folder
cp -pr /usr/local/bin/kubectl /usr/local/sbin
cp -pr /usr/local/bin/kops /usr/local/sbin

# Installing DOCKER
yum install docker -y
systemctl start docker
systemctl enable docker

# Creating a Kubernetes Cluster
/usr/local/bin/kops create cluster --zones=ap-south-1a kubernets.telivic.com --dns-zone=telivic.com --dns private
