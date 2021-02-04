# Basic state configration (DSC)

Steps for provisioning a basic DSC on K8S. This assumes that you've already followed the instructions under the README.md under the /cluster/aws directory.

1) Assuming you've cloned the Vulcan repository to your local drive when you provisioned the K8S cluster with the following:

  > git clone https://github.governmentcio.com/DevSecOps-CoT/vulcan.git

2) Navigate to the vulcan/configs/base/ directory

 > cd vulcan/configs/base/

3) Execute ./provision-dsc.sh to provision the components

4) Navigate to the /ingress folder and execute the following:
  
  > kb apply -f 1-nginx-controller.yaml
  > ./2-wait-for-pods.sh
  > kb apply -f 3-nginx-service.yaml

5) The components for the basic DSC can be accessed at (assuming a domain name of swf.devgovcio.com)

 SonarQube - http://swf.devgovcio.com/sonar
 Jenkins - http://swf.devgovcio.com/jenkins/
 Gitlab - http://swf.devgovcio.com/
 Artifactory - http://swf.devgovcio.com/artifactory



