Script to install tools:

#!/bin/bash
# For Ubuntu 22.04

# Installing Java for Jenkins
sudo apt update -y
sudo apt install openjdk-17-jre -y
sudo apt install openjdk-17-jdk -y
java --version
# Installing Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y

# Installing Docker
#!/bin/bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock

# Installing Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
sudo apt update
sudo apt install terraform

# Installing AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install


# To Run SonarQube as container run command
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Installing Trivy
#!/bin/bash
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

================================

# # Install kubectl:
# #! /bin/bash
# sudo apt update
# sudo apt install curl
# curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# kubectl version --client

# ========================

# # Intalling Helm
# #! /bin/bash
# sudo snap install helm --classic

==========================

# # Install-Jfrog-Artifactory

# #! /bin/bash

# cd /opt
# wget https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/7.9.2/jfrog-artifactory-oss-7.9.2-linux.tar.gz
# tar -xvf jfrog-artifactory-oss-7.9.2-linux.tar.gz
# cd artifactory-oss-7.9.2/
# cd app/bin/
# ./artifactory.sh start

# =======================

# # Install minikube
# #! /bin/bash

# sudo apt update
# sudo apt upgrade
# wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# chmod +x minikube-linux-amd64
# sudo mv minikube-linux-amd64 /usr/local/bin/minikube
# ==============

# # Note:
# # Installation Only Work for Ubuntu 18.04LTS, 20.04LTS and 22.04LTS

# # Steps to use the Scripts For Linux OS only
# # Installation Only Work for Ubuntu 18.04LTS, 20.04LTS and 22.04LTS

# # Steps to use the Scripts For Linux OS only
# # Clone the repo by command, git clone where the scripts are placed in a folder 
# # called Sripts-Installation, ex Install-Jenkins.sh, Install-Docker.sh etc.

# cd Scripts-Installation
# sudo chmod +x <Script_name> e.g,sudo chmod +x Install-Docker.sh
# ./<Script_name> e.g ./Install-Docker.sh



