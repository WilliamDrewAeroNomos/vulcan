#!/bin/bash

# Note: This script requires the installation of minikube, istioctl and kubectl
#
# Installation Instructions for: 
#
# Minikube can be found at https://kubernetes.io/docs/tasks/tools/install-minikube/
# 
# Istio and istioctl can be found at https://istio.io/latest/docs/setup/getting-started/#download
#
# Kubectl can be found at https://kubernetes.io/docs/tasks/tools/install-kubectl/
#
# If the installation process that you choose does not already do so, add the executables to your path.
#

minikube stop
minikube delete

echo "Starting minikube with 16MB and 4 CPUs with version 1.18.3..."

minikube start --memory 16384 --cpus=4 --kubernetes-version=v1.18.3 --disk-size=128GB

echo "Installing with demo profile..."
istioctl install --set profile=demo 


