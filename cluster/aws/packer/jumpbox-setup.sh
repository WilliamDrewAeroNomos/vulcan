#!/bin/bash
echo "Executing base image setup of Software Factory Jumpbox."

echo "Update the image to the latest patches..."
sudo yum install epel-release -y
sudo yum update -y

echo "Remove java 1.7..."
sudo yum erase java-1.7.0* -y

echo "Install Java 1.8.0..."
sudo yum install java-1.8.0-openjdk.x86_64 -y

echo "Install Java 1.8.0 JDK..."
sudo yum install java-1.8.0-openjdk-devel -y

sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

echo $JAVA_HOME
echo $JRE_HOME

echo "Install Git..."
sudo yum install git -y

echo "Install aws-cli..."
sudo yum install aws-cli -y

echo "Install Maven..."
wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar xvf apache-maven-3.5.4-bin.tar.gz
sudo mv apache-maven-3.5.4 /usr/local/apache-maven

echo 'export M2_HOME=/usr/local/apache-maven' | sudo tee -a ~/.bashrc
echo 'export M2=$M2_HOME/bin' | sudo tee -a ~/.bashrc
echo 'export PATH=$M2:$PATH' | sudo tee -a ~/.bashrc
source ~/.bashrc

rm -f apache-maven-3.5.4-bin.tar.gz

echo "Install xmlstarlet used for XML config manipulation..."
sudo yum install -y xmlstarlet

echo "Install Terraform..."

sudo wget https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip

sudo yum install unzip -y

unzip terraform_0.11.1_linux_amd64.zip 

sudo mv terraform /usr/local/bin/

rm -f terraform_0.11.1_linux_amd64.zip

echo "Installing Packer..."

curl -O https://releases.hashicorp.com/packer/1.1.3/packer_1.1.3_linux_amd64.zip
sudo yum install -y unzip
sudo unzip -d /usr/local packer_1.1.3_linux_amd64.zip 
sudo ln -s /usr/local/packer /usr/local/bin/packer.io

rm -f packer_1.1.3_linux_amd64.zip

echo "Installing kops..."

curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x ./kops
sudo mv ./kops /usr/local/bin/

echo "Installing kubectl..."

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

kubectl version --client

echo "Installing Docker..."

sudo yum-config-manager --enable rhui-REGION-rhel-server-extras
sudo yum -y install docker
sudo systemctl start docker
sudo chmod 666 /var/run/docker.sock
docker version

echo "Testing the docker installation."

docker run hello-world

docker rmi hello-world -f

END_TIMESTAMP=`date +"%Y-%m-$d %T"`
echo End time : ${END_TIMESTAMP}
