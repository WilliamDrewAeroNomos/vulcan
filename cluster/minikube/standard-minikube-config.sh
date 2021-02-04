#!/bin/bash

# Note: This script requires the installation of minikube
#
# Installation Instructions for: 
#
# Minikube can be found at https://kubernetes.io/docs/tasks/tools/install-minikube/
# 

minikube stop
minikube delete

echo "Starting minikube with 16MB and 4 CPUs with version 1.18.3..."

minikube start --memory 16384 --cpus=4 --kubernetes-version=v1.18.3 --disk-size=128GB

