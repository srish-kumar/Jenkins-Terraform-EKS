*CONFIGURE ARGOCD:*

Pre-requisite:
-> Create a separate namespace for ArgoCd to avoid confusion
$ kubectl create namespace argocd

# Note - v2.10 is compatible with EKS version 1.29
1. Apply the *argocd installation using a manifest file* (ArgoCD provides a manifest file or helm)
$ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.10.16/manifests/install.yaml

-> Verify the installation by running:
$ kubectl get all -n argocd

2. To access argocd, expose the service type of argocd (service:argocd-server) as loadbalancer type (to internet) instead of ClusterIP type(default).
-> $ kubectl get svc -n argocd
$ kubectl edit svc argocd-server -n argocd
-> Edit the type at the end from ClusterIP to : LoadBalancer
As soon as this change is saved, a load balancer will be created.

Note:
This loadbalancer is created by the Cloud Control manager (CCM) of the EKS cluster and not by the load-balancer-controller installed before. When the service type is changed to LoadBalancer type, that request is received by the Cloud Control Manager component of the EKS.

3. Copy the DNS name of the load balancer from the consol and open in a browser to see the UI of Argocd.

4. Username is "admin" and password needs to be fetched from the secrets:
$ kubectl get secrets -n argocd

-> edit the secret for argocd-initial-admin-secret
$ kubectl edit secret argocd-initial-admin-secret -n argocd
-> copy the password and close the secret manifest

5. Decode the password with the help of base64
$ echo <password> | base64 --decode

-> Copy the decoded password and login to argocd UI:
Username = admin
Password = base64 decoded password

=====================================================

*Set up the repository in ArgoCd*





