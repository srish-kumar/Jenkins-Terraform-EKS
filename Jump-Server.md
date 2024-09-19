On the jump server run the command:
1. aws eks update-kubeconfig --name=<cluster-name> --region us-east-1
$ aws eks update-kubeconfig --name dev-medium-eks-cluster --region us-east-1

#update-kubeconfig updates or adds a context entry in the Kubeconfig file (usually ~/.kube/config), allowing kubectl to interact with the EKS cluster.

2. Configure the Load Balancer on our EKS because our application will have an ingress controller.
i. Pre-req - create a IAM policy for aws controller:
    a. Download the policy json for loadbalancer
        $ curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
    b. Create an IAM Policy using the downloaded json
        $ aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
    c. Verify that AWSLoadBalancerControllerIAMPolicy is created from consule

ii. Create a service account using eksctl, that will assume a IAM role which will create a load balancer from the eks cluster; provide the policy arn created above.
    Syntax- 
    eksctl create iamserviceaccount \
    --cluster <cluster-name> \
    --namespace <namespace> \
    --name <service-account-name> \
    [--role-name <role-name>] \
    [--attach-policy-arn <policy-arn>] \
    [--approve] \
    [--region <aws-region>]

# role-name - This flag specify the custom name for the IAM role. If not specified, eksctl will generate a role name for you.
# approve - flag automatically approves the IAM role creation without prompted to confirm the creation.

$ eksctl create iamserviceaccount --cluster=dev-medium-eks-cluster --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=arn:aws:iam::533267374094:policy/AWSLoadBalancerControllerIAMPolicy --approve --region=us-east-1

# Verify the IAM role and service account form the console:
$ kubectl get sa -n kube-system

# To trobleshoot- delete the CloudFormation stack and recreate.

Note: 
eksctl create iamserviceaccount is used to create an IAM service account in an Amazon EKS cluster. This service account integrates *IAM roles* with Kubernetes *service accounts*, allowing to provide *AWS permissions* to applications(eg. pod) running in EKS. By using this command, you can associate an IAM role with a Kubernetes service account, allowing pods that use the service account to assume that IAM role and access AWS resources securely (e.g., S3, DynamoDB, Load balancer etc.). 
In this case, ingress controller pod inside the EKS cluster, with which the service account is associated, will assume the IAM role to create loadbalancer (which is another AWS resource). 

Concepts - *IAM Roles for Service Accounts (IRSA)* - eksctl create iamserviceaccount command leverages IAM Roles for Service Accounts (IRSA), which allows you to securely assign IAM roles to Kubernetes service accounts in EKS. This mechanism ensures that workloads in the cluster can assume IAM roles based on the service account they are using, granting access to AWS resources without the need for static credentials.
*OIDC* - OIDC provider (OpenID Connect provider) is essential for integrating Kubernetes service accounts with IAM roles (IRSA). It maps Kubernetes service accounts to IAM roles, so that the workloads running on the cluster can securely access AWS resources such as S3, DynamoDB, and others.
    -> Create OIDC Provider - $ eksctl utils associate-iam-oidc-provider --cluster <cluster-name> --approve
    -> You create IAM roles that Kubernetes service accounts can assume. The trust policy of the IAM role is configured to trust the OIDC provider of your EKS cluster.
    -> After configuring the OIDC provider and creating an IAM role, you associate the IAM role with a Kubernetes service account.
Note -> In the current case, we were directly able to run eksctl create iamserviceaccount because terraform has already created OIDC provider trust policy setup of EKS service accounts.

# Summary:
*OIDC Provider in EKS*: Allows Kubernetes service accounts to assume IAM roles using OIDC tokens.
*IAM Roles for Service Accounts (IRSA)*: Enables secure AWS permissions for EKS workloads without hardcoding credentials.
*OIDC URL*: Unique to each EKS cluster and used for authentication between Kubernetes and AWS IAM.

iii. Run these commands to deploy the AWS Load Balancer Controller:
$ helm repo add eks https://aws.github.io/eks-charts
$ helm repo update eks

syntax:
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=<your-cluster-name> \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller \
--set region=<your-region> \
--set vpcId=<your-vpc-id> \

$ helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=dev-medium-eks-cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller

# Validate in console or $ kubectl get deployment -n kube-system aws-load-balancer-controller
Note - If controller pods are not up then generally troubleshoot the service account setup






