#!/bin/bash

kubectl delete -f ssd-storage-class.yaml
kubectl delete -f artifactory/
kubectl delete -f gitlab/
kubectl delete -f jenkins/
kubectl delete -f sonarqube/
kubectl delete -f sonar-postgres/
kubectl delete -f mongodb/

