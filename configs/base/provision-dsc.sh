#!/bin/bash

kubectl apply -f ssd-storage-class.yaml
kubectl apply -f ../../components/mongodb/
kubectl apply -f ../../components/sonar-postgres/
kubectl apply -f ../../components/artifactory/
kubectl apply -f ../../components/gitlab/
kubectl apply -f ../../components/jenkins/
kubectl apply -f ../../components/sonarqube/

