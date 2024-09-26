***Deployment of a tree tier application on EKS cluster using Terraform and GitOps tool ArgoCD.***

***In this repository:***
1. Set up EKS infrastructure using Terraform and Jenkins/Github
2. For GitOps (For Continuous Delivery) refer to this repo - 
https://github.com/srish-kumar/ArgoCD-Deploy-EKS

***Set up EKS infrastructure using Terraform and Jenkins/Github***

Infrastructure-as-code:
AWS Infrastructure setup using Terraform:
Networking setup using Terraform (VPC, subnet, security groups etc.)
IAM roles setup
Kubernetes (EKS) Cluster creation and setup
Complete setup using Jenkins/GitHub pipeline.
Deploying Ingress Controller
Deployment of Ingress Controller, using AWS CLI and Helm charts 
Service account setup
Setting up load balancer for EKS cluster

===============================================
Steps:

1. Create an EC2 instance - Ubuntu 22
2. Setup security group having inbound rules for 
   Jenkins - Custom TCP/TCP/8080
   Sonarqube - Custom TCP/TCP/9000
   HTTP - HTTP/TCP/80
   SSH - SSH/TCP/22
2. Install all the required tools:
    Jenkins
    AWS CLI
    Docker
    Terraform
    Sonarqube
    Trivy
3. Connect to the EC2 usnig AWS Systems Manager Session Manager and validate 
   tool installation.
3. Access the Jenkins server in a browser - <public ip of EC2 instance>:<Jenkins port>
4.  Get Jenkins password by running command in session manager:
    ``` $ sudo systemctl status jenkins.service``` (sudo may be required to view journal files)```
5. Install suggested plugins 
6. On the Jenkins Dashboard, select Manage Jenkins to install plugins.
7. Install these plugins for deploying infrastructure on AWS:
    AWS Credentials
    Pipeline: AWS Steps
8. After installation we need to save AWS credentials, go to manage jenkins -> security ->
   Credentials
   global -> add credentials 
   Under kind - Select AWS Credentials (available if AWS credentials plugin is installed)
9. Create an IAM user with admin access to get the Access and Secret keys. Provide info in Jenkins.
10. Now install Terraform plugin
11. Goto Manage Jenkins -> Tools -> Terraform installations
    As we already have terraform installed on the Jenkins server, we will use the same for installation
    From Session run command - ```$whereis terraform``` 
    (this will provide the directory path where terrafrom is)
    /usr/bin/terraform
    Uncheck the Install Automatically checkbox and paste the file path.
    Click apply and save.
12. Install Jenkins plugin -  Pipeline: Stage View
13. Now we will create a pipeline to run terraform to create EKS infra.
14. Create a S3 bucket and Dynamodb table (Lock-Files) for Terraform backend.
15. Create the Jenkinsfile.
16. Configure Jenkins to run the terraform script.
17. Add jenkins pipeline script in the Jenkins and run the Jenkins job. 

=====================================







