# AWS cluster provisioning

[![asciicast](https://asciinema.org/a/2lnCYidpGOpaIWJzx2BR4YcjP.svg)](https://asciinema.org/a/2lnCYidpGOpaIWJzx2BR4YcjP)

Steps to provisioning a Kubernetes (K8S) cluster on AWS:

1) Establish account on AWS

2) Ensure the following are installed and configured :

 - Git command line tool - https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
 - AWS command line interface (CLI) tool - aws - https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
 - Kubernetes command-line tool - kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl/
 - Istio command line tool - istioctl - https://istio.io/latest/docs/setup/install/istioctl/

2) Clone the Vulcan repository to your local drive:

  > git clone https://github.governmentcio.com/DevSecOps-CoT/vulcan.git

3) Navigate to the vulcan/cluster/aws directory

 > cd vulcan/cluster/aws

4) Source set-env-vars.sh to establish environment variables

 > . ./set-env-vars.sh

5) Create the K8S cluster

 > ./create-aws-k8s-cluster.sh

6) Run the following after 10 - 15 mins and response indicates the cluster is ready.

 > kops validate cluster
 
7) Navigate to the /ingress folder and execute ./provision-ingress.sh
  
8) Create type 'A' record for swf.devgovcio.com using the external IP of the ingress-nginx-controller.
  
  You get the full description of the controller with:

  kb describe svc ingress-nginx-controller -n ingress-nginx

  Note the line starting with "LoadBalancer Ingress:". 

  *** This will be replaced with an automated process in later versions. *** 

