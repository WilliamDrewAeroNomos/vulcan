#!/bin/bash

./build_jenkins_master_image.sh

./push_jenkins_master_image.sh

kubectl apply -f ssd-storage-class.yaml

kubectl apply -f jenkins-master-deployment.yaml

